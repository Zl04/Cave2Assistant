using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// 在一次运行任务期间独立观察和处理覆盖层，不修改移动状态。
/// </summary>
public sealed class PopupWatchdog
{
    static readonly TimeSpan ProbeInterval = TimeSpan.FromMilliseconds(120);
    static readonly TimeSpan ErrorLogInterval = TimeSpan.FromSeconds(2);

    readonly AdbClient adb;
    readonly Func<bool> probeEnabled;
    readonly Func<PopupUiPipelineResult, CancellationToken, Task<bool>> detected;
    readonly Action<Exception> probeFailed;
    readonly Action<string>? probeStatus;
    readonly Func<string>? probeDisabledReason;

    internal PopupWatchdog(
        AdbClient adb,
        Func<bool> probeEnabled,
        Func<PopupUiPipelineResult, CancellationToken, Task<bool>> detected,
        Action<Exception> probeFailed,
        Action<string>? probeStatus = null,
        Func<string>? probeDisabledReason = null)
    {
        this.adb = adb;
        this.probeEnabled = probeEnabled;
        this.detected = detected;
        this.probeFailed = probeFailed;
        this.probeStatus = probeStatus;
        this.probeDisabledReason = probeDisabledReason;
    }

    public async Task RunAsync(CancellationToken token)
    {
        var lastErrorAt = 0L;
        var lastStatusAt = 0L;
        var probeCount = 0L;
        var candidate = MovementPopupKind.None;
        var candidateFrames = 0;
        var handled = MovementPopupKind.None;
        var emptyFrames = 0;
        var lastGemClickAt = 0L;
        var gemClickAttempts = 0;
        probeStatus?.Invoke("弹窗监控已启动");

        void ReportStatus(string message, bool force = false)
        {
            var now = Environment.TickCount64;
            if (!force && now - lastStatusAt < 2000) return;
            lastStatusAt = now;
            probeStatus?.Invoke(message);
        }

        while (!token.IsCancellationRequested)
        {
            // 弹窗识别独立于移动。调用方只在专门的弹窗流程消费模态框时
            // 暂停探测；其余时间即使移动分片刚结束，也要把弹窗锁存给主循环处理。
            if (probeEnabled())
            {
                try
                {
                    var probeId = ++probeCount;
                    var frameId = adb.NextPopupFrameId();
                    var stopwatch = Stopwatch.StartNew();
                    ReportStatus($"弹窗监控开始探测 #{probeId}（FrameId={frameId}）：截图中");
                    using var probeCancellation = CancellationTokenSource.CreateLinkedTokenSource(token);
                    using var monitorCancellation = CancellationTokenSource.CreateLinkedTokenSource(token);
                    var disabledMonitor = CancelProbeWhenDisabledAsync(probeCancellation, monitorCancellation.Token);
                    try
                    {
                        using var frame = await adb.CaptureMovementPopupFrameAsync(frameId, probeCancellation.Token);
                        var captureMs = stopwatch.ElapsedMilliseconds;
                        ReportStatus($"弹窗监控探测 #{probeId}（FrameId={frameId}）：识别中");
                        var pipelineResult = await adb.RunPopupUiPipelineAsync(frame, frameId, probeCancellation.Token);
                        var popup = pipelineResult.Value;
                        var node = pipelineResult.NodeName ?? "无匹配";
                        var attemptDetail = pipelineResult.AttemptSummary;
                        var gemTitleDetail = pipelineResult.RiftGemTitleText is null
                            ? ""
                            : $"，OCR宝石标题={PopupUiPipelineResult.SummarizeText(pipelineResult.RiftGemTitleText)}";
                        var bodyText = pipelineResult.NextFloorDialogBodyText;
                        var bodyDetail = bodyText is null ? "" : $"，OCR正文={PopupUiPipelineResult.SummarizeText(bodyText)}";
                        ReportStatus($"弹窗监控探测 #{probeId}（FrameId={frameId}）：{node}，结果 {popup}{gemTitleDetail}{bodyDetail}，节点={attemptDetail}，截图={captureMs}ms，识别={stopwatch.ElapsedMilliseconds - captureMs}ms，总计={stopwatch.ElapsedMilliseconds}ms",
                            popup != MovementPopupKind.None || stopwatch.ElapsedMilliseconds >= 500);
                        if (popup == MovementPopupKind.None)
                        {
                            candidate = MovementPopupKind.None;
                            candidateFrames = 0;
                            if (++emptyFrames >= 2)
                            {
                                handled = MovementPopupKind.None;
                                gemClickAttempts = 0;
                            }
                        }
                        else if (popup != candidate)
                        {
                            emptyFrames = 0;
                            candidate = popup;
                            candidateFrames = 1;
                        }
                        else { emptyFrames = 0; candidateFrames++; }

                        var requiredFrames = PopupDetectionPolicy.RequiredConsecutiveFrames(popup);
                        var retryGem = popup == MovementPopupKind.RiftGemSelection &&
                            popup == handled && gemClickAttempts < 5 &&
                            Environment.TickCount64 - lastGemClickAt >= 700;
                        if (candidateFrames >= requiredFrames && (popup != handled || retryGem))
                        {
                            if (await detected(pipelineResult, token))
                            {
                                handled = popup;
                                if (popup == MovementPopupKind.RiftGemSelection)
                                {
                                    gemClickAttempts++;
                                    lastGemClickAt = Environment.TickCount64;
                                }
                            }
                        }
                    }
                    finally
                    {
                        monitorCancellation.Cancel();
                        try { await disabledMonitor; }
                        catch (OperationCanceledException) when (monitorCancellation.IsCancellationRequested) { }
                    }
                }
                catch (OperationCanceledException) when (token.IsCancellationRequested) { break; }
                catch (OperationCanceledException)
                {
                    ReportStatus("弹窗监控探测已让位给专用弹窗流程", force: true);
                }
                catch (Exception ex)
                {
                    var now = Environment.TickCount64;
                    if (now - lastErrorAt >= ErrorLogInterval.TotalMilliseconds)
                    {
                        lastErrorAt = now;
                        probeFailed(ex);
                    }
                }
            }
            else
                ReportStatus($"弹窗监控等待专用弹窗流程结束：{probeDisabledReason?.Invoke() ?? "专用流程未结束"}");

            try { await Task.Delay(ProbeInterval, token); }
            catch (OperationCanceledException) when (token.IsCancellationRequested) { break; }
        }
    }

    async Task CancelProbeWhenDisabledAsync(CancellationTokenSource probeCancellation, CancellationToken token)
    {
        while (!token.IsCancellationRequested)
        {
            if (!probeEnabled())
            {
                probeCancellation.Cancel();
                return;
            }
            await Task.Delay(25, token);
        }
    }
}
