using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// 一次弹窗管线探测的结果。换层确认框的子类型必须和该次探测绑定，
/// 不能再通过 AdbClient 上的可变“最后一次结果”属性回读，否则移动看门狗
/// 与专用换层协程并发识别时，后一帧可能覆盖前一帧的 OCR 结果。
/// </summary>
internal sealed record PopupUiPipelineResult(
    UiPipelineResult<MovementPopupKind> Pipeline,
    NextFloorDialogKind NextFloorDialog,
    string? FullFrameText,
    string? NextFloorDialogBodyText,
    bool GreedySelectionReturnOnly,
    IReadOnlyList<int> GreedySelectionReturnCards)
{
    public MovementPopupKind Value => Pipeline.Value;
    public string? NodeName => Pipeline.NodeName;
    public IReadOnlyList<UiPipelineAttempt> Attempts => Pipeline.Attempts;

    public string AttemptSummary
        => string.Join("|", Attempts.Select(attempt =>
            $"{attempt.NodeName}:{(attempt.Matched ? "命中" : "未命中")}" +
            (attempt.TimedOut ? ",超时" : "") +
            (string.IsNullOrWhiteSpace(attempt.Error) ? "" : $",错误={attempt.Error}")));

    public static string SummarizeText(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return "<空>";
        var normalized = text.Replace("\r", " ").Replace("\n", "|");
        return normalized.Length <= 300 ? normalized : normalized[..300] + "…";
    }
}

/// <summary>
/// 根据 JSON 定义构建弹窗管线。JSON 控制节点顺序、启用状态、结果值和时序；
/// 下面的注册表有意由代码拥有，避免资源文件执行任意代码。
/// </summary>
public static class PopupUiPipeline
{
    const string FrameTextCacheKey = "popup.full-frame-text";

    public static string DefaultConfigPath
        => Path.Combine(AppContext.BaseDirectory, "pipelines", "popup-watchdog.json");

    public static UiPipeline<Bitmap, MovementPopupKind> Create(
        AdbClient adb,
        string? configPath = null,
        Action<string>? fullFrameTextObserved = null,
        Action<NextFloorDialogKind, string?>? nextFloorDialogDetected = null)
    {
        if (adb is null) throw new ArgumentNullException(nameof(adb));

        var path = configPath ?? DefaultConfigPath;
        var definition = UiPipelineDefinitionLoader.Load(path);
        var nodes = new List<UiPipelineNode<Bitmap, MovementPopupKind>>();
        foreach (var node in definition.Nodes)
        {
            if (!Enum.TryParse<MovementPopupKind>(node.Result, ignoreCase: true, out var result) ||
                result == MovementPopupKind.None)
                throw new InvalidDataException($"节点 {node.Name} 的 result 不是有效弹窗类型：{node.Result}（{path}）");

            nodes.Add(new UiPipelineNode<Bitmap, MovementPopupKind>(
                node.Name,
                result,
                CreateRecognizer(adb, node, path, fullFrameTextObserved, nextFloorDialogDetected),
                node.MaxAttempts,
                node.TimeoutMs == -1 ? System.Threading.Timeout.InfiniteTimeSpan :
                    TimeSpan.FromMilliseconds(node.TimeoutMs)));
        }

        return new UiPipeline<Bitmap, MovementPopupKind>(MovementPopupKind.None, nodes);
    }

    static Func<UiPipelineContext<Bitmap>, CancellationToken, Task<bool>> CreateRecognizer(
        AdbClient adb,
        UiPipelineNodeDefinition node,
        string path,
        Action<string>? fullFrameTextObserved,
        Action<NextFloorDialogKind, string?>? nextFloorDialogDetected)
        => node.Recognizer switch
        {
            "ServerErrorDialog" => async (context, token) =>
            {
                var text = await ReadFrameTextAsync(adb, context, token, fullFrameTextObserved);
                return await adb.HasServerErrorDialog(context.Frame, text);
            },
            "NextFloorDialog" => async (context, token) =>
            {
                token.ThrowIfCancellationRequested();
                // 换层弹窗的正文/卡片标题位于固定中央区域。扩大裁剪范围以同时
                // 捕获贪婪抉择卡片的“返回城镇/继续探险”语义，仍避免整屏文字干扰。
                string? bodyText = null;
                var kind = await adb.DetectNextFloorDialog(context.Frame, token,
                    text => bodyText = text);
                nextFloorDialogDetected?.Invoke(kind, bodyText);
                token.ThrowIfCancellationRequested();
                return kind != NextFloorDialogKind.None;
            },
            "RiftGemSelection" => async (context, token) =>
            {
                var text = await ReadFrameTextAsync(adb, context, token, fullFrameTextObserved);
                return adb.HasRiftGemSelectionText(text);
            },
            _ => throw new InvalidDataException(
                $"节点 {node.Name} 使用了未注册的 recognizer：{node.Recognizer}（{path}）")
        };

    static async Task<string> ReadFrameTextAsync(
        AdbClient adb,
        UiPipelineContext<Bitmap> context,
        CancellationToken token,
        Action<string>? textObserved)
    {
        if (context.Cache.TryGetValue(FrameTextCacheKey, out var cached) && cached is string text)
        {
            textObserved?.Invoke(text);
            return text;
        }

        var result = await adb.ReadPopupFrameTextAsync(context.Frame, token);
        context.Cache[FrameTextCacheKey] = result;
        textObserved?.Invoke(result);
        return result;
    }

    static async Task<bool> ObserveAsync(Func<Task<bool>> detector, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        var result = await detector();
        token.ThrowIfCancellationRequested();
        return result;
    }
}
