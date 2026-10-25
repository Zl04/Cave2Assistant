using System.Drawing;
using System.Drawing.Imaging;
using System.Text.RegularExpressions;

namespace AdbMapController;

public sealed class SoulArtifactPipeline : IMaaPipelineHandler<SoulArtifactPipeline>
{
    readonly IEquipmentSaleDevice device;
    readonly MaaAdbPipelineState adbState;
    readonly MaaPipelineCatalog catalog;
    readonly Action<string> log;
    int previous = -1;
    bool bagOpened;
    public string Name => "SoulArtifact";

    public SoulArtifactPipeline(AdbClient adb, string configuration, Action<string> log)
    {
        device = new AdbEquipmentSaleDevice(adb);
        adbState = new MaaAdbPipelineState(adb, log: log);
        this.log = log;
        catalog = MaaPipelineCatalogLoader.Load(configuration);
    }

    public Task<MaaPipelineExecutionResult> RunAsync(CancellationToken token, IMaaPipelineTraceSink? trace = null)
    {
        // 调用方复用装备流程完成背包打开与确认；Pipeline 从切换魂器页签开始。
        bagOpened = true;
        var tracking = new DelegateMaaPipelineTraceSink(value =>
        {
            if (value.Kind != MaaPipelineTraceKind.NodeCompleted) return;
            if (value.TaskName == "BagClosed") bagOpened = false;
        });
        IMaaPipelineTraceSink sink = trace is null ? tracking : new MaaPipelineTraceMultiplexer([tracking, trace]);
        return new MaaPipeline<SoulArtifactPipeline>(catalog,
            [this, new MaaAdbPipelineHandler<SoulArtifactPipeline>("SoulAdb", state => state.adbState)],
            new MaaPipelineExecutionOptions { TaskChain = "SoulArtifact", RetryTimes = 0, MaxTransitions = 75 }, sink)
            .RunAsync(this, ["SelectSoulTab"], token);
    }

    public async Task<MaaPipelineRecognitionResult> RecognizeAsync(MaaPipelineTask task,
        MaaPipelineTaskContext<SoulArtifactPipeline> context, CancellationToken token)
    {
        using var source = await device.CaptureAsync(token);
        using var frame = EquipmentSaleVision.Normalize(source);
        var evidence = task.SaveScreenshot ? PipelineEvidenceStore.Save(frame, context.RunId, context.TaskId, log) : null;
        if (task.Name == "CloseBag")
        {
            var button = MainForm.FindEquipmentTemplate(frame, "back.png", new Rectangle(818, 0, 112, 60));
            return button is { } point
                ? MaaPipelineRecognitionResult.Hit(box: new MaaRect(point.X - 1, point.Y - 1, 2, 2),
                    detail: "已识别背包返回按钮", evidencePath: evidence)
                : MaaPipelineRecognitionResult.Miss("未识别到背包返回按钮", evidence);
        }
        if (task.Name == "BagClosed")
        {
            var button = MainForm.FindEquipmentTemplate(frame, "bag.png", new Rectangle(885, 455, 119, 110));
            return button is not null
                ? MaaPipelineRecognitionResult.Hit(detail: "地图背包按钮已出现", evidencePath: evidence)
                : MaaPipelineRecognitionResult.Miss("未确认背包已关闭", evidence);
        }
        var progress = await ReadProgressAsync(frame, token, device.ReadWordsAsync);
        if (progress is null)
            return MaaPipelineRecognitionResult.Miss("未识别到魂器普通培养次数", evidence);
        var (used, limit, detail) = progress.Value;
        return task.Name switch
        {
            "SoulReady" => MaaPipelineRecognitionResult.Hit(detail: detail, evidencePath: evidence),
            "Exhausted" => used >= limit ? MaaPipelineRecognitionResult.Hit(detail: detail, evidencePath: evidence)
                : MaaPipelineRecognitionResult.Miss(detail, evidence),
            "CultivateAvailable" => used < limit && (previous < 0 || used > previous)
                ? MaaPipelineRecognitionResult.Hit(detail: detail, evidencePath: evidence)
                : MaaPipelineRecognitionResult.Miss($"次数未增加：{detail}", evidence),
            _ => MaaPipelineRecognitionResult.Miss($"未知节点 {task.Name}", evidence)
        };
    }

    public async Task<MaaPipelineActionResult> ExecuteAsync(MaaPipelineTask task,
        MaaPipelineRecognitionResult recognition, MaaPipelineTaskContext<SoulArtifactPipeline> context,
        CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        if (task.Name == "CloseBag")
        {
            await EquipmentBagCloser.CloseAsync(device, log, token);
            return MaaPipelineActionResult.Success();
        }
        if (task.Name == "CultivateAvailable")
        {
            var match = Regex.Match(recognition.Detail ?? "", @"(\d{1,2})/(\d{1,2})");
            if (!match.Success) return MaaPipelineActionResult.Failure("普通培养次数缺失");
            previous = int.Parse(match.Groups[1].Value);
            log($"魂器普通培养：准备第 {context.ExecutionCount} 次，当前 {recognition.Detail}");
        }
        if (task.Name == "Exhausted") log($"魂器普通培养次数已耗尽：{recognition.Detail}");
        if (task.Action == MaaPipelineAction.ClickSelf)
        {
            if (recognition.Box is not { } box)
                return MaaPipelineActionResult.Failure("识别成功但缺少点击区域");
            return await ClickRecognizedAsync(box);
        }
        return MaaPipelineActionResult.Success();
    }

    async Task<MaaPipelineActionResult> ClickRecognizedAsync(MaaRect box)
    {
        await device.TapAsync((box.X + box.Width / 2d) / 1004, (box.Y + box.Height / 2d) / 565);
        return MaaPipelineActionResult.Success();
    }

    public async Task CloseAfterFailureAsync()
    {
        if (!bagOpened) return;
        try
        {
            await EquipmentBagCloser.CloseAsync(device, log, CancellationToken.None);
        }
        catch (Exception ex) { log($"关闭背包失败：{ex.Message}"); }
    }

    public static async Task<(int Used, int Limit, string Detail)?> ReadProgressAsync(Bitmap frame,
        CancellationToken token,
        Func<Bitmap, CancellationToken, Task<IReadOnlyList<OcrWord>>> readWords)
    {
        ArgumentNullException.ThrowIfNull(readWords);
        using var region = frame.Clone(new Rectangle(142, 466, 170, 39), PixelFormat.Format24bppRgb);
        var words = await readWords(region, token);
        var text = string.Concat(words.OrderBy(word => word.Left).Select(word => word.Text));
        if (Regex.IsMatch(text, @"(?:今天)?次数(?:已经|已)?用完"))
            return (20, 20, "今天次数已经用完");
        var match = Regex.Match(text, @"(\d{1,2})\s*[/／]\s*(\d{1,2})");
        if (!match.Success || !int.TryParse(match.Groups[1].Value, out var used) ||
            !int.TryParse(match.Groups[2].Value, out var limit) || limit is < 1 or > 20 || used > limit)
            return null;
        return (used, limit, $"普通培养 {used}/{limit}");
    }
}
