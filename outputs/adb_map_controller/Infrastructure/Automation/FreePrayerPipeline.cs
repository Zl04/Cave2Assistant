using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;

namespace AdbMapController;

/// <summary>祈祷流程中需要结合上下文判断的两个识别节点。</summary>
public sealed class FreePrayerPipeline : IMaaPipelineHandler<FreePrayerPipeline>
{
    readonly MaaPipelineCatalog catalog;
    readonly Action<string> log;
    int closedChecks;

    public FreePrayerPipeline(AdbClient adb, string configuration, Action<string> log)
    {
        Device = new MaaAdbPipelineState(adb, log: log);
        this.log = log;
        catalog = MaaPipelineCatalogLoader.Load(configuration);
    }

    public string Name => "PrayerCheck";
    public MaaAdbPipelineState Device { get; }

    public Task<MaaPipelineExecutionResult> RunAsync(CancellationToken token, IMaaPipelineTraceSink? trace = null)
    {
        var executionLog = new DelegateMaaPipelineTraceSink(value =>
        {
            if (value.Kind == MaaPipelineTraceKind.NodeCompleted)
            {
                switch (value.TaskName)
                {
                    case "OpenPrayer": log("免费祈祷：已点击神迹许愿入口"); break;
                    case "PrayerTitle": log("免费祈祷：神迹许愿界面已打开"); break;
                    case "FreePrayer": log($"免费祈祷：已点击第 {value.ExecutionCount} 次免费祈祷"); break;
                    case "PaidPrayer": log("免费祈祷：按钮已不免费，准备结束任务"); break;
                    case "ClosePrayer": log("免费祈祷：已点击界面外空白区域"); break;
                    case "SkipPrayerAnimation": log("免费祈祷：已快速跳过动画，等待界面关闭"); break;
                    case "PrayerClosed": log("免费祈祷：已确认界面关闭"); break;
                    case "WaitBeforeReopen": log("免费祈祷：关闭后等待 0.3 秒完成，开始下一轮"); break;
                    case "ClosePaidPrayer": log("免费祈祷：已关闭非免费祈祷界面"); break;
                    case "PaidPrayerClosed": log("免费祈祷：已确认最终界面关闭"); break;
                }
            }
            else if (value.Kind is MaaPipelineTraceKind.NodeFailed or MaaPipelineTraceKind.TaskChainFailed)
                log($"免费祈祷 Pipeline 失败：{value.TaskName ?? value.TaskChain}，{value.Error ?? value.Detail}");
        });
        IMaaPipelineTraceSink sink = trace is null
            ? executionLog
            : new MaaPipelineTraceMultiplexer([executionLog, trace]);
        var pipeline = new MaaPipeline<FreePrayerPipeline>(catalog,
            [new MaaAdbPipelineHandler<FreePrayerPipeline>("PrayerAdb", current => current.Device), this],
            new MaaPipelineExecutionOptions { TaskChain = "FreePrayer", RetryTimes = 0, MaxTransitions = 180 }, sink);
        return pipeline.RunAsync(this, ["OpenPrayer"], token);
    }

    public async Task<MaaPipelineRecognitionResult> RecognizeAsync(
        MaaPipelineTask task, MaaPipelineTaskContext<FreePrayerPipeline> context, CancellationToken token)
    {
        if (task.Roi is not { } roi) throw new InvalidDataException($"{task.Name} 缺少识别区域");
        using var frame = await Device.Adb.CaptureScreenForAutomationAsync(token);
        var bounds = VisionPipeline.ScaleRoi(new Rectangle(roi.X, roi.Y, roi.Width, roi.Height), frame.Size);
        using var crop = frame.Clone(bounds, PixelFormat.Format24bppRgb);
        var words = await Device.Adb.ReadOcrWordsAsync(crop, token);
        var content = string.Concat(words.OrderBy(word => word.Top).ThenBy(word => word.Left)
            .Select(word => OcrTextLocator.Compact(word.Text)));

        if (task.Name is "PrayerClosed" or "PaidPrayerClosed")
        {
            if (context.Attempt == 0) closedChecks = 0;
            closedChecks = content.Contains("神迹许愿", StringComparison.Ordinal) ? 0 : closedChecks + 1;
            return closedChecks >= 2
                ? MaaPipelineRecognitionResult.Hit(text: content, detail: "连续两次未见神迹许愿标题")
                : MaaPipelineRecognitionResult.Miss($"等待祈祷界面关闭：{content}");
        }
        throw new InvalidDataException($"未知祈祷识别节点：{task.Name}");
    }

    public Task<MaaPipelineActionResult> ExecuteAsync(
        MaaPipelineTask task, MaaPipelineRecognitionResult recognition,
        MaaPipelineTaskContext<FreePrayerPipeline> context, CancellationToken token)
        => Task.FromResult(MaaPipelineActionResult.Success());
}
