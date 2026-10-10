using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// MaaFramework 风格 Pipeline 的设备上下文。
/// Pipeline 节点只描述 recognition/action，设备截图、OCR 和触控由该通用适配器提供。
/// </summary>
public sealed class MaaAdbPipelineState
{
    public MaaAdbPipelineState(AdbClient adb, string? resourceRoot = null, Action<string>? log = null)
    {
        Adb = adb ?? throw new ArgumentNullException(nameof(adb));
        ResourceRoot = Path.GetFullPath(resourceRoot ?? AppContext.BaseDirectory);
        Log = log;
        Vision = new VisionPipeline(adb.ReadOcrWordsAsync);
    }

    public AdbClient Adb { get; }
    public string ResourceRoot { get; }
    public Action<string>? Log { get; }
    public VisionPipeline Vision { get; }
    public Size LastScreenSize { get; internal set; }
}

/// <summary>
/// 通用 ADB Pipeline handler。它实现 MaaFramework Pipeline 中最常用的
/// DirectHit/TemplateMatch/OCR/FeatureMatch 与 Click/Swipe 动作，
/// 使简单 UI 流程不再需要按节点名称编写业务 switch。
/// </summary>
public sealed class MaaAdbPipelineHandler<TState> : IMaaPipelineHandler<TState>
{
    readonly Func<TState, MaaAdbPipelineState> stateFactory;

    public MaaAdbPipelineHandler(string name, Func<TState, MaaAdbPipelineState> stateFactory)
    {
        if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("handler 名称不能为空", nameof(name));
        Name = name;
        this.stateFactory = stateFactory ?? throw new ArgumentNullException(nameof(stateFactory));
    }

    public string Name { get; }

    public async Task<MaaPipelineRecognitionResult> RecognizeAsync(
        MaaPipelineTask task,
        MaaPipelineTaskContext<TState> context,
        CancellationToken token)
    {
        var state = stateFactory(context.State);
        using var frame = await state.Adb.CaptureScreenForAutomationAsync();
        state.LastScreenSize = frame.Size;
        var visionTask = CreateVisionTask(task, state.ResourceRoot);
        var result = await state.Vision.RecognizeAsync(visionTask, frame, token: token);
        MaaRect? box = result.Box.IsEmpty
            ? null
            : new MaaRect(
                (int)Math.Round(result.Box.Left * VisionPipeline.DesignWidth / (double)frame.Width),
                (int)Math.Round(result.Box.Top * VisionPipeline.DesignHeight / (double)frame.Height),
                (int)Math.Round(result.Box.Width * VisionPipeline.DesignWidth / (double)frame.Width),
                (int)Math.Round(result.Box.Height * VisionPipeline.DesignHeight / (double)frame.Height));
        return new MaaPipelineRecognitionResult(
            result.Hit,
            result.Score,
            box,
            result.Text,
            result.Detail,
            null,
            null);
    }

    public async Task<MaaPipelineActionResult> ExecuteAsync(
        MaaPipelineTask task,
        MaaPipelineRecognitionResult recognition,
        MaaPipelineTaskContext<TState> context,
        CancellationToken token)
    {
        var state = stateFactory(context.State);
        token.ThrowIfCancellationRequested();
        switch (task.Action)
        {
            case MaaPipelineAction.DoNothing:
                return MaaPipelineActionResult.Success();
            case MaaPipelineAction.ClickSelf:
            case MaaPipelineAction.ClickRand:
                if (recognition.Box is not { } box || box.Width < 0 || box.Height < 0)
                    return MaaPipelineActionResult.Failure("Click 动作没有可用的识别目标");
                await TapDesignRect(state, box);
                return MaaPipelineActionResult.Success();
            case MaaPipelineAction.ClickRect:
                if (task.SpecificRect is not { } rect)
                    return MaaPipelineActionResult.Failure("ClickRect 缺少 specificRect");
                await TapDesignRect(state, rect);
                return MaaPipelineActionResult.Success();
            case MaaPipelineAction.Swipe:
                if (task.SpecificRect is not { } begin || task.RectMove is not { } move)
                    return MaaPipelineActionResult.Failure("Swipe 缺少 specificRect 或 rectMove");
                await state.Adb.SwipeScreen(
                    begin.X / (double)VisionPipeline.DesignWidth,
                    begin.Y / (double)VisionPipeline.DesignHeight,
                    (begin.X + move.X) / (double)VisionPipeline.DesignWidth,
                    (begin.Y + move.Y) / (double)VisionPipeline.DesignHeight,
                    Math.Max(1, move.Width));
                return MaaPipelineActionResult.Success();
            case MaaPipelineAction.Input:
                return MaaPipelineActionResult.Failure("当前 ADB Pipeline 尚未实现 InputText 动作");
            default:
                return MaaPipelineActionResult.Failure($"ADB Pipeline 不支持动作：{task.Action}");
        }
    }

    static VisionTask CreateVisionTask(MaaPipelineTask task, string resourceRoot)
    {
        var template = task.Algorithm is MaaPipelineAlgorithm.MatchTemplate or MaaPipelineAlgorithm.FeatureMatch
            ? task.Templates.FirstOrDefault()
            : null;
        return new VisionTask
        {
            Name = task.Name,
            Algorithm = task.Algorithm switch
            {
                MaaPipelineAlgorithm.JustReturn => VisionAlgorithm.JustReturn,
                MaaPipelineAlgorithm.MatchTemplate => VisionAlgorithm.MatchTemplate,
                MaaPipelineAlgorithm.OcrDetect => VisionAlgorithm.OcrDetect,
                MaaPipelineAlgorithm.FeatureMatch => VisionAlgorithm.FeatureMatch,
                _ => throw new InvalidDataException($"ADB Pipeline 不支持识别算法：{task.Algorithm}")
            },
            TemplatePath = template is null ? null : ResolveTemplate(resourceRoot, template),
            Text = task.Text,
            Roi = task.Roi is { } roi ? new Rectangle(roi.X, roi.Y, roi.Width, roi.Height) : null,
            TemplateThreshold = task.TemplateThresholds.FirstOrDefault(.80),
            MinimumFeatureMatches = Math.Max(4, task.FeatureCount),
            FeatureRatio = task.FeatureRatio,
            FeatureCount = Math.Max(64, task.FeatureCount * 100),
            FullMatch = task.FullMatch
        };
    }

    static string ResolveTemplate(string resourceRoot, string template)
    {
        if (Path.IsPathRooted(template)) return template;
        var candidates = new[]
        {
            Path.Combine(resourceRoot, template),
            Path.Combine(resourceRoot, "images", template),
            Path.Combine(resourceRoot, "icons", template)
        };
        return candidates.FirstOrDefault(File.Exists)
            ?? throw new FileNotFoundException("Maa Pipeline 模板图片不存在", candidates[0]);
    }

    static Task TapDesignRect(MaaAdbPipelineState state, MaaRect rect)
        => state.Adb.TapScreen(
            (rect.X + rect.Width / 2d) / VisionPipeline.DesignWidth,
            (rect.Y + rect.Height / 2d) / VisionPipeline.DesignHeight);
}
