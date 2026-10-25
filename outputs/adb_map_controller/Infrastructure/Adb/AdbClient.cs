using System;
using System.Diagnostics;
using System.Drawing;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// Compatibility facade for the controller's device operations.
/// Process transport, touch session, game-data decoding, screen analysis,
/// screenshot ownership and assistant patching live in dedicated collaborators.
/// </summary>
public sealed class AdbClient : IGameSnapshotSource, ITouchTransport, IDisposable
{
    readonly AdbCommandTransport transport;
    readonly AdbScreenCapture screenCapture;
    readonly AssistantController assistant;
    readonly AdbTouchSession touchSession;
    readonly AdbGameDataReader gameDataReader;
    readonly AdbScreenAnalyzer screenAnalyzer;
    readonly ScreenFrameCache popupFrameCache;
    long popupFrameSequence;
    internal Action<string>? CaptureTimingLog
    {
        get => screenCapture.TimingLog;
        set => screenCapture.TimingLog = value;
    }
    internal Action<string>? OcrTimingLog
    {
        get => screenAnalyzer.OcrTimingLog;
        set => screenAnalyzer.OcrTimingLog = value;
    }
    int disposed;

    public string TouchDescription => touchSession.Description;
    public bool IsTouchReady => touchSession.IsReady;
    public string? LastRiftGemTitle => screenAnalyzer.LastRiftGemTitle;
    public string GemTitleDetectionMode => screenAnalyzer.GemTitleDetectionMode;
    internal NextFloorDialogKind LastNextFloorDialogKind => screenAnalyzer.LastNextFloorDialogKind;

    public string Serial
    {
        get => transport.Serial;
        set
        {
            if (transport.Serial == value) return;
            transport.Serial = value;
            popupFrameCache.Clear();
            touchSession.ResetSession();
        }
    }

    public AdbClient()
    {
        transport = new AdbCommandTransport();
        screenCapture = new AdbScreenCapture();
        popupFrameCache = new ScreenFrameCache();
        screenAnalyzer = new AdbScreenAnalyzer();
        touchSession = new AdbTouchSession(transport, popupFrameCache.Clear);
        gameDataReader = new AdbGameDataReader(RunRoot);
        assistant = new AssistantController(transport);
    }

    Task<string> Run(params string[] args) => transport.RunAsync(args);
    Task<string> RunRoot(string command) => transport.RunRootAsync(command);

    // Compatibility seam used by the touch backend and production-reference tests.
    internal Task<string> RunAdb(params string[] args) => Run(args);
    Task ITouchTransport.EnsureTouchReady() => touchSession.EnsureReady();
    (int X, int Y) ITouchTransport.TouchPoint(Cell delta) => touchSession.TouchPoint(delta);
    Task ITouchTransport.SendTouchDown((int X, int Y) point) => touchSession.SendTouchDown(point);
    Task ITouchTransport.SendTouchUp() => touchSession.SendTouchUp();
    Task ITouchTransport.SendTouchPulse((int X, int Y) point, int milliseconds)
        => touchSession.SendTouchPulse(point, milliseconds);

    public Task<System.Collections.Generic.List<string>> Devices() => touchSession.DevicesAsync();
    public Task<bool> EnableAdbRoot() => touchSession.EnableRootAsync();

    /// <summary>Connects the selected device and initializes its touch backend.</summary>
    public Task<bool> ConnectAsync(string deviceSerial) => touchSession.ConnectAsync(deviceSerial);

    /// <summary>Invalidates the current device session so a same-serial reconnect is re-probed.</summary>
    public void Disconnect() => ResetDeviceSession();

    void ResetDeviceSession()
    {
        popupFrameCache.Clear();
        touchSession.ResetSession();
        transport.ResetSession();
    }

    public Task<MapDump> ReadMap() => gameDataReader.ReadMapAsync();
    public Task<PlayerStatus> ReadPlayer() => gameDataReader.ReadPlayerAsync();

    /// <summary>Finds a tool in the bottom quick bar and reads its visible count.</summary>
    public async Task<BottomToolInfo?> FindBottomToolAsync(
        BottomToolKind kind, CancellationToken token = default)
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕", token);
        return await screenAnalyzer.FindBottomToolAsync(bitmap, kind, token);
    }

    internal Task<BottomToolInfo?> FindBottomToolAsync(
        Bitmap source, BottomToolKind kind, CancellationToken token = default)
        => screenAnalyzer.FindBottomToolAsync(source, kind, token);

    public Task<MiningToolStatus> ReadMiningToolStatusAsync(CancellationToken token = default)
        => ReadMiningToolStatusFromDeviceAsync(token);

    async Task<MiningToolStatus> ReadMiningToolStatusFromDeviceAsync(CancellationToken token)
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕", token);
        return await screenAnalyzer.ReadMiningToolStatusAsync(bitmap, token);
    }

    internal Task<MiningToolStatus> ReadMiningToolStatusAsync(Bitmap source, CancellationToken token = default)
        => screenAnalyzer.ReadMiningToolStatusAsync(source, token);

    public async Task<bool> HasMiningCancelIconAsync(CancellationToken token = default)
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕", token);
        return screenAnalyzer.HasMiningCancelIcon(bitmap);
    }

    internal bool HasMiningCancelIcon(Bitmap source) => screenAnalyzer.HasMiningCancelIcon(source);

    internal Task InitializeOcrAsync(CancellationToken token = default)
        => screenAnalyzer.InitializeOcrAsync(token);

    public Task<System.Collections.Generic.IReadOnlyList<OcrWord>> ReadOcrWordsAsync(Bitmap image)
        => ReadOcrWordsAsync(image, default);

    public Task<System.Collections.Generic.IReadOnlyList<OcrWord>> ReadOcrWordsAsync(
        Bitmap image,
        CancellationToken token)
        => screenAnalyzer.ReadOcrWordsAsync(image, token);

    public sealed record AssistantStatus(string Target, string CurrentHash, string PatchHash, bool Installed, bool BackupExists, string Format, bool TestPanelSupported);

    public Task TapScreen(double normalizedX, double normalizedY)
        => touchSession.TapScreen(normalizedX, normalizedY);

    public Task TapScreenSecondary(double normalizedX, double normalizedY)
        => touchSession.TapScreenSecondary(normalizedX, normalizedY);

    public Task PressBack() => touchSession.PressBack();

    /// <summary>Tap in the assistant's original 720x1280 portrait coordinate space.</summary>
    public Task TapGameCoordinate(int x, int y) => touchSession.TapGameCoordinate(x, y);

    public Task SwipeScreen(double normalizedX0, double normalizedY0,
        double normalizedX1, double normalizedY1, int durationMs)
        => touchSession.SwipeScreen(normalizedX0, normalizedY0, normalizedX1, normalizedY1, durationMs);

    public Task<Bitmap> CaptureScreenForAutomationAsync()
        => CaptureScreenAsync("无法截取设备屏幕");

    public Task<Bitmap> CaptureScreenForAutomationAsync(CancellationToken token)
        => CaptureScreenAsync("无法截取设备屏幕", token);

    internal async Task<IReadOnlyList<string?>> ReadGreedyCardTextsAsync(CancellationToken token)
    {
        using var frame = await CaptureScreenAsync("无法截取贪婪抉择卡片", token);
        var result = new string?[3];
        var centers = new[] { .3125, .5, .6875 };
        for (var index = 0; index < centers.Length; index++)
            result[index] = await screenAnalyzer.ReadScreenTextAsync(frame,
                (centers[index] - .085, centers[index] + .085, .33, .63),
                $"贪婪抉择第 {index + 1} 张卡片", token);
        return result;
    }

    public async Task<bool> HasNextFloorButton()
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕");
        return screenAnalyzer.HasNextFloorButton(bitmap);
    }

    public async Task<bool> HasServerErrorDialog()
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕");
        return await screenAnalyzer.HasServerErrorDialogAsync(bitmap);
    }

    internal Task<bool> HasServerErrorDialog(Bitmap bitmap, CancellationToken token = default)
        => screenAnalyzer.HasServerErrorDialogAsync(bitmap, token);

    internal Task<bool> HasServerErrorDialog(Bitmap bitmap, string? ocrText)
        => screenAnalyzer.HasServerErrorDialogAsync(bitmap, ocrText);

    internal static bool IsServerErrorText(string? text)
        => ConnectionPopupRecognition.IsDisconnectText(text);

    public async Task<bool> HasEnterNextFloorConfirm()
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕");
        return await screenAnalyzer.HasEnterNextFloorConfirmAsync(bitmap);
    }

    public async Task<bool> HasNextFloorBonusSelection()
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕");
        return await screenAnalyzer.HasNextFloorBonusSelectionAsync(bitmap);
    }

    internal Task<NextFloorDialogKind> DetectNextFloorDialog(
        Bitmap bitmap,
        CancellationToken token,
        Action<string?>? bodyObserved,
        Action<string?>? titleObserved = null)
        => screenAnalyzer.DetectNextFloorDialogAsync(bitmap, token, bodyObserved, titleObserved);

    internal NextFloorDialogKind DetectNextFloorDialog(Bitmap bitmap, string? ocrText)
        => screenAnalyzer.DetectNextFloorDialog(bitmap, ocrText);

    internal NextFloorDialogKind DetectNextFloorDialog(
        Bitmap bitmap,
        string? titleText,
        string? bodyText)
        => screenAnalyzer.DetectNextFloorDialog(bitmap, titleText, bodyText);

    internal Task<string?> ReadPopupTitleTextAsync(Bitmap frame, CancellationToken token = default)
        => screenAnalyzer.ReadPopupTitleTextAsync(frame, token);

    public async Task<bool> HasRiftGemSelection()
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕");
        return await screenAnalyzer.HasRiftGemSelectionAsync(bitmap);
    }

    internal Task<bool> HasRiftGemSelection(Bitmap bitmap)
        => screenAnalyzer.HasRiftGemSelectionAsync(bitmap);

    internal bool HasRiftGemSelectionText(string? title)
        => screenAnalyzer.HasRiftGemSelectionText(title);

    internal Task<string?> ReadRiftGemTitleAsync(Bitmap frame, CancellationToken token = default)
        => screenAnalyzer.ReadRiftGemTitleAsync(frame, token);

    internal static bool IsRiftGemTitle(string text)
        => AdbScreenAnalyzer.IsRiftGemTitle(text);

    /// <summary>Runs the popup UI pipeline against one captured logical frame.</summary>
    internal async Task<PopupUiPipelineResult> ProbeMovementPopupAsync(
        CancellationToken token = default, Action<string>? timingLog = null,
        bool prioritizeNextFloor = false)
    {
        var frameId = NextPopupFrameId();
        var timer = Stopwatch.StartNew();
        using var bitmap = await CaptureMovementPopupFrameAsync(frameId, token);
        var captureMs = timer.ElapsedMilliseconds;
        timingLog?.Invoke($"帧={frameId}，截图={captureMs}ms");
        var result = await RunPopupUiPipelineCoreAsync(bitmap, frameId, token, prioritizeNextFloor);
        timingLog?.Invoke($"帧={frameId}，识别={timer.ElapsedMilliseconds - captureMs}ms，总计={timer.ElapsedMilliseconds}ms，结果={result.Value}，节点={result.AttemptSummary}");
        return result;
    }

    internal long NextPopupFrameId() => Interlocked.Increment(ref popupFrameSequence);

    internal Task<PopupUiPipelineResult> RunPopupUiPipelineAsync(
        Bitmap frame, CancellationToken token = default)
        => RunPopupUiPipelineCoreAsync(frame, null, token, prioritizeNextFloor: false);

    internal Task<PopupUiPipelineResult> RunPopupUiPipelineAsync(
        Bitmap frame, long frameId, CancellationToken token = default)
        => RunPopupUiPipelineCoreAsync(frame, frameId, token, prioritizeNextFloor: false);

    async Task<PopupUiPipelineResult> RunPopupUiPipelineCoreAsync(
        Bitmap frame, long? frameId, CancellationToken token, bool prioritizeNextFloor)
    {
        NextFloorDialogKind nextFloorDialog = NextFloorDialogKind.None;
        string? nextFloorDialogBody = null;
        string? nextFloorDialogTitle = null;
        string? riftGemTitle = null;
        var pipeline = await PopupUiPipeline.Create(this,
                nextFloorDialogDetected: (kind, body) =>
                {
                    nextFloorDialog = kind;
                    nextFloorDialogBody = body;
                },
                nextFloorDialogTitleObserved: text => nextFloorDialogTitle = text,
                riftGemTitleObserved: text => riftGemTitle = text,
                prioritizeNextFloor: prioritizeNextFloor)
            .RunAsync(frame, frameId, token);
        var isGreedySelection = nextFloorDialog == NextFloorDialogKind.GreedySelection;
        return new PopupUiPipelineResult(pipeline, nextFloorDialog, nextFloorDialogBody,
            isGreedySelection && PopupRecognition.IsGreedySelectionReturnOnly(nextFloorDialogBody),
            isGreedySelection ? PopupRecognition.FindGreedySelectionReturnCards(frame) : Array.Empty<int>(),
            riftGemTitle, nextFloorDialogTitle);
    }

    internal Task<string> ReadPopupFrameTextAsync(Bitmap frame, CancellationToken token = default)
        => screenAnalyzer.ReadPopupFrameTextAsync(frame, token);

    internal Task<Bitmap> CaptureMovementPopupFrameAsync(CancellationToken token)
        => CaptureMovementPopupFrameAsync(NextPopupFrameId(), token);

    internal Task<Bitmap> CaptureMovementPopupFrameAsync(long frameId, CancellationToken token)
        => popupFrameCache.GetAsync(
            frameId,
            captureToken => CaptureScreenAsync("无法截取设备屏幕", captureToken),
            token);

    public async Task<int> TapRandomRiftGemCard()
    {
        await touchSession.EnsureReady();
        var index = Random.Shared.Next(3);
        await TapRiftGemCard(index);
        return index + 1;
    }

    /// <summary>Tap the stable selection button on the requested gem card.</summary>
    public async Task TapRiftGemCard(int index)
    {
        await touchSession.EnsureReady();
        index = Math.Clamp(index, 0, 2);
        var x = index switch { 0 => .268, 1 => .466, _ => .661 };
        await TapScreen(x, .648);
    }

    async Task<Bitmap> CaptureScreenAsync(string errorMessage, CancellationToken token = default)
        => await screenCapture.CaptureAsync(Serial, errorMessage, token);

    public Task<AssistantStatus> GetAssistantStatus(string templateFile)
        => assistant.GetStatusAsync(templateFile);

    public Task RequestOpenTestPanel()
        => assistant.RequestOpenTestPanelAsync();

    public Task<AssistantStatus> InstallAssistant(string templateFile)
        => assistant.InstallAsync(templateFile);

    public Task<AssistantStatus> RestoreAssistant(string templateFile)
        => assistant.RestoreAsync(templateFile);

    public void Dispose()
    {
        if (Interlocked.Exchange(ref disposed, 1) != 0) return;
        var errors = new List<Exception>();
        void Close(Action close) { try { close(); } catch (Exception error) { errors.Add(error); } }
        Close(popupFrameCache.Dispose);
        Close(screenCapture.Dispose);
        Close(screenAnalyzer.Dispose);
        Close(touchSession.Dispose);
        Close(transport.Dispose);
        if (errors.Count > 0) throw new AggregateException("Device resources failed to close.", errors);
    }
}
