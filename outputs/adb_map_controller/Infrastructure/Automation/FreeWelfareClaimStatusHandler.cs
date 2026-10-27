using System.Drawing;
using System.Drawing.Imaging;

namespace AdbMapController;

/// <summary>确认福利卡领取按钮消失，或福利活动页面已关闭。</summary>
public sealed class FreeWelfareClaimStatusHandler : IMaaPipelineHandler<MaaAdbPipelineState>
{
    public string Name => "WelfareClaimStatus";

    public async Task<MaaPipelineRecognitionResult> RecognizeAsync(
        MaaPipelineTask task, MaaPipelineTaskContext<MaaAdbPipelineState> context, CancellationToken token)
    {
        if (task.Roi is not { } roi) throw new InvalidDataException($"{task.Name} 缺少按钮区域");
        var area = new Rectangle(roi.X, roi.Y, roi.Width, roi.Height);
        var closing = task.Name == "WelfareClosed";
        var targetText = closing ? "福利活动" : "领取";
        // 连续两帧确认目标状态，避免动画或瞬时 OCR 漏读造成误判。
        for (var check = 0; check < 2; check++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await context.State.Adb.CaptureScreenForAutomationAsync(token);
            var bounds = VisionPipeline.ScaleRoi(area, frame.Size);
            using var crop = frame.Clone(bounds, PixelFormat.Format24bppRgb);
            var words = await context.State.Adb.ReadOcrWordsAsync(crop, token);
            if (OcrTextLocator.Find(words, targetText) is not null)
                return MaaPipelineRecognitionResult.Miss(closing ? "福利活动标题仍可见，页面尚未关闭" : "原领取按钮仍可见");
            if (check == 0) await Task.Delay(250, token);
        }
        return MaaPipelineRecognitionResult.Hit(detail: closing
            ? "连续两帧未识别到福利活动标题，页面已关闭"
            : "连续两帧未识别到原领取按钮");
    }

    public Task<MaaPipelineActionResult> ExecuteAsync(
        MaaPipelineTask task, MaaPipelineRecognitionResult recognition,
        MaaPipelineTaskContext<MaaAdbPipelineState> context, CancellationToken token)
        => Task.FromResult(MaaPipelineActionResult.Success());
}
