using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public enum PopupRecognitionProfile { Normal, Abyss }

/// <summary>
/// 一次弹窗管线探测的结果。换层确认框的子类型必须和该次探测绑定，
/// 不能再通过 AdbClient 上的可变“最后一次结果”属性回读，否则移动看门狗
/// 与专用换层协程并发识别时，后一帧可能覆盖前一帧的 OCR 结果。
/// </summary>
internal sealed record PopupUiPipelineResult(
    UiPipelineResult<MovementPopupKind> Pipeline,
    NextFloorDialogKind NextFloorDialog,
    string? NextFloorDialogBodyText,
    bool GreedySelectionReturnOnly,
    IReadOnlyList<int> GreedySelectionReturnCards,
    IReadOnlyList<int> GreedySelectionContinueCards,
    string? RiftGemTitleText,
    string? NextFloorDialogTitleText)
{
    public MovementPopupKind Value => Pipeline.Value;
    public string? NodeName => Pipeline.NodeName;
    public IReadOnlyList<UiPipelineAttempt> Attempts => Pipeline.Attempts;

    public string AttemptSummary
        => string.Join("|", Attempts.Select(attempt =>
            $"{attempt.NodeName}:{(attempt.Matched ? "命中" : "未命中")}" +
            $",耗时={attempt.Duration.TotalMilliseconds:0}ms,尝试={attempt.Attempt}" +
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
    public static string DefaultConfigPath
        => Path.Combine(AppContext.BaseDirectory, "pipelines", "popup-watchdog.json");

    public static UiPipeline<Bitmap, MovementPopupKind> Create(
        AdbClient adb,
        string? configPath = null,
        Action<NextFloorDialogKind, string?>? nextFloorDialogDetected = null,
        Action<string?>? nextFloorDialogTitleObserved = null,
        Action<string?>? riftGemTitleObserved = null,
        bool prioritizeNextFloor = false,
        PopupRecognitionProfile profile = PopupRecognitionProfile.Normal)
    {
        if (adb is null) throw new ArgumentNullException(nameof(adb));

        var path = configPath ?? DefaultConfigPath;
        var definition = UiPipelineDefinitionLoader.Load(path);
        if (prioritizeNextFloor)
            definition.Nodes = definition.Nodes
                .OrderBy(node => node.Name == "NextFloorDialog" ? 0 : 1)
                .ThenBy(node => node.Priority)
                .ToList();
        var nodes = new List<UiPipelineNode<Bitmap, MovementPopupKind>>();
        foreach (var node in definition.Nodes)
        {
            if (profile == PopupRecognitionProfile.Abyss && node.Recognizer == "RiftGemSelection") continue;
            if (profile != PopupRecognitionProfile.Abyss && node.Recognizer == "ReturnTownConfirm") continue;
            if (profile != PopupRecognitionProfile.Abyss && node.Recognizer == "AbyssMerchantDialog") continue;
            if (!Enum.TryParse<MovementPopupKind>(node.Result, ignoreCase: true, out var result) ||
                result == MovementPopupKind.None)
                throw new InvalidDataException($"节点 {node.Name} 的 result 不是有效弹窗类型：{node.Result}（{path}）");

            nodes.Add(new UiPipelineNode<Bitmap, MovementPopupKind>(
                node.Name,
                result,
                CreateRecognizer(adb, node, path, nextFloorDialogDetected, nextFloorDialogTitleObserved, riftGemTitleObserved, profile),
                node.MaxAttempts,
                System.Threading.Timeout.InfiniteTimeSpan));
        }

        return new UiPipeline<Bitmap, MovementPopupKind>(MovementPopupKind.None, nodes);
    }

    static Func<UiPipelineContext<Bitmap>, CancellationToken, Task<bool>> CreateRecognizer(
        AdbClient adb,
        UiPipelineNodeDefinition node,
        string path,
        Action<NextFloorDialogKind, string?>? nextFloorDialogDetected,
        Action<string?>? nextFloorDialogTitleObserved,
        Action<string?>? riftGemTitleObserved,
        PopupRecognitionProfile profile)
        => node.Recognizer switch
        {
            "ServerErrorDialog" => (context, token) => adb.HasServerErrorDialog(context.Frame, token),
            "NextFloorDialog" => (context, token) => RecognizeNextFloorAsync(adb, context.Frame, token,
                nextFloorDialogDetected, nextFloorDialogTitleObserved, profile),
            "RiftGemSelection" => (context, token) => RecognizeRiftGemAsync(adb, context.Frame, token, riftGemTitleObserved),
            "ReturnTownConfirm" => (context, token) => RecognizeReturnTownAsync(adb, context.Frame, token),
            "AbyssMerchantDialog" => (context, token) =>
            {
                token.ThrowIfCancellationRequested();
                return Task.FromResult(PopupRecognition.HasAbyssMerchantDialog(context.Frame));
            },
            // 临时兼容识别节点；正式交互接入时同时检查 popup-watchdog.json 与 MainForm.Movement.cs。
            "AltarDialog" => (context, token) =>
            {
                token.ThrowIfCancellationRequested();
                return Task.FromResult(PopupRecognition.HasAltarDialog(context.Frame));
            },
            "EnchantingDialog" => (context, token) =>
            {
                token.ThrowIfCancellationRequested();
                return Task.FromResult(PopupRecognition.HasEnchantingDialog(context.Frame));
            },
            _ => throw new InvalidDataException(
                $"节点 {node.Name} 使用了未注册的 recognizer：{node.Recognizer}（{path}）")
        };

    static async Task<bool> RecognizeNextFloorAsync(AdbClient adb, Bitmap frame, CancellationToken token,
        Action<NextFloorDialogKind, string?>? detected, Action<string?>? titleObserved,
        PopupRecognitionProfile profile)
    {
        string? body = null;
        var kind = await adb.DetectNextFloorDialog(frame, token, text => body = text, titleObserved,
            includeGreedySelection: profile == PopupRecognitionProfile.Normal);
        detected?.Invoke(kind, body);
        token.ThrowIfCancellationRequested();
        return kind != NextFloorDialogKind.None;
    }

    static async Task<bool> RecognizeRiftGemAsync(AdbClient adb, Bitmap frame, CancellationToken token,
        Action<string?>? titleObserved)
    {
        var title = await adb.ReadRiftGemTitleAsync(frame, token);
        titleObserved?.Invoke(title);
        return adb.HasRiftGemSelectionText(title);
    }

    static async Task<bool> RecognizeReturnTownAsync(AdbClient adb, Bitmap frame, CancellationToken token)
    {
        if (!PopupRecognition.HasNextFloorConfirmButton(frame)) return false;
        var text = await adb.ReadReturnTownConfirmTextAsync(frame, token);
        return PopupRecognition.IsReturnTownConfirmText(text);
    }

}
