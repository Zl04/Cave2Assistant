using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// 在一次运行任务期间独立观察会消耗触摸的覆盖层。
/// 它不会自行点击：有活动移动分片时请求取消并释放触摸，空闲时把弹窗锁存给主循环。
/// </summary>
public sealed class PopupWatchdog
{
    static readonly TimeSpan ProbeInterval = TimeSpan.FromMilliseconds(120);
    static readonly TimeSpan ErrorLogInterval = TimeSpan.FromSeconds(2);

    readonly AdbClient adb;
    readonly TouchController touch;
    readonly MotionInterruptState interrupt;
    readonly Func<bool> probeEnabled;
    readonly Func<bool> cancelCurrentMovement;
    readonly Action<MovementPopupKind> detected;
    readonly Action<Exception> probeFailed;
    readonly Action<string>? probeStatus;
    readonly Func<string>? probeDisabledReason;

    public PopupWatchdog(
        AdbClient adb,
        TouchController touch,
        MotionInterruptState interrupt,
        Func<bool> probeEnabled,
        Func<bool> cancelCurrentMovement,
        Action<MovementPopupKind> detected,
        Action<Exception> probeFailed,
        Action<string>? probeStatus = null,
        Func<string>? probeDisabledReason = null)
    {
        this.adb = adb;
        this.touch = touch;
        this.interrupt = interrupt;
        this.probeEnabled = probeEnabled;
        this.cancelCurrentMovement = cancelCurrentMovement;
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
            if (interrupt.Reason == MotionInterruptReason.None && probeEnabled())
            {
                try
                {
                    var probeId = ++probeCount;
                    var frameId = adb.NextPopupFrameId();
                    var stopwatch = Stopwatch.StartNew();
                    ReportStatus($"弹窗监控开始探测 #{probeId}（FrameId={frameId}）：截图中");
                    using var frame = await adb.CaptureMovementPopupFrameAsync(frameId, token);
                    ReportStatus($"弹窗监控探测 #{probeId}（FrameId={frameId}）：识别中");
                    var pipelineResult = await adb.RunPopupUiPipelineAsync(frame, frameId, token);
                    var popup = pipelineResult.Value;
                    var node = pipelineResult.NodeName ?? "无匹配";
                    var attemptDetail = pipelineResult.AttemptSummary;
                    var fullTextDetail = pipelineResult.FullFrameText is null
                        ? ""
                        : $"，OCR全屏={PopupUiPipelineResult.SummarizeText(pipelineResult.FullFrameText)}";
                    var bodyText = pipelineResult.NextFloorDialogBodyText;
                    var bodyDetail = bodyText is null ? "" : $"，OCR正文={PopupUiPipelineResult.SummarizeText(bodyText)}";
                    ReportStatus($"弹窗监控探测 #{probeId}（FrameId={frameId}）：{node}，结果 {popup}{fullTextDetail}{bodyDetail}，节点={attemptDetail}，耗时 {stopwatch.ElapsedMilliseconds} ms",
                        popup != MovementPopupKind.None || stopwatch.ElapsedMilliseconds >= 500);
                    if (popup == MovementPopupKind.None)
                    {
                        candidate = MovementPopupKind.None;
                        candidateFrames = 0;
                    }
                    else if (popup != candidate)
                    {
                        candidate = popup;
                        candidateFrames = 1;
                    }
                    else candidateFrames++;

                    var requiredFrames = PopupDetectionPolicy.RequiredConsecutiveFrames(popup);
                    if (candidateFrames >= requiredFrames &&
                        interrupt.Request(popup, pipelineResult.NextFloorDialog,
                            pipelineResult.GreedySelectionReturnOnly))
                    {
                        // 取消移动只是可选的交接动作。没有活动分片时仍保留中断，
                        // 由所属运行循环在下一轮消费待处理弹窗。
                        if (cancelCurrentMovement())
                        {
                            try { await touch.EmergencyRelease(); }
                            catch (Exception ex) { probeFailed(ex); }
                        }
                        detected(popup);
                    }
                }
                catch (OperationCanceledException) when (token.IsCancellationRequested) { break; }
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
            else if (interrupt.Reason == MotionInterruptReason.None)
                ReportStatus($"弹窗监控等待专用弹窗流程结束：{probeDisabledReason?.Invoke() ?? "专用流程未结束"}");

            try { await Task.Delay(ProbeInterval, token); }
            catch (OperationCanceledException) when (token.IsCancellationRequested) { break; }
        }
    }
}
