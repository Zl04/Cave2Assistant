using System.Drawing;
using System.Drawing.Imaging;

namespace AdbMapController;

/// <summary>领取后的卡片没有统一弹窗，确认原领取按钮已消失。</summary>
public sealed class FreeWelfareClaimStatusHandler : IMaaPipelineHandler<MaaAdbPipelineState>
{
    public string Name => "WelfareClaimStatus";

    public async Task<MaaPipelineRecognitionResult> RecognizeAsync(
        MaaPipelineTask task, MaaPipelineTaskContext<MaaAdbPipelineState> context, CancellationToken token)
    {
        if (task.Roi is not { } roi) throw new InvalidDataException($"{task.Name} 缺少按钮区域");
        var area = new Rectangle(roi.X, roi.Y, roi.Width, roi.Height);
        // 连续两帧检查，避免领取动画中的瞬时 OCR 漏读被当成按钮消失。
        for (var check = 0; check < 2; check++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await context.State.Adb.CaptureScreenForAutomationAsync(token);
            var bounds = VisionPipeline.ScaleRoi(area, frame.Size);
            using var crop = frame.Clone(bounds, PixelFormat.Format24bppRgb);
            var words = await context.State.Adb.ReadOcrWordsAsync(crop, token);
            if (OcrTextLocator.Find(words, "领取") is not null)
                return MaaPipelineRecognitionResult.Miss("原领取按钮仍可见");
            if (check == 0) await Task.Delay(250, token);
        }
        return MaaPipelineRecognitionResult.Hit(detail: "连续两帧未识别到原领取按钮");
    }

    public Task<MaaPipelineActionResult> ExecuteAsync(
        MaaPipelineTask task, MaaPipelineRecognitionResult recognition,
        MaaPipelineTaskContext<MaaAdbPipelineState> context, CancellationToken token)
        => Task.FromResult(MaaPipelineActionResult.Success());
}
