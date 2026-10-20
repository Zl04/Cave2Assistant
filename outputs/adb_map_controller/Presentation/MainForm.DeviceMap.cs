using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Win32;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task Scan()
    {
        if (closing || stopping || scanning || activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false }) return;
        scanning = true;
        await refreshLock.WaitAsync();
        try
        {
            var found = await adb.Devices();
            if (closing || activeMovement is { IsCompleted: false }) return;

            var currentSerial = adb.Serial;
            var currentStillPresent = found.Contains(currentSerial, StringComparer.Ordinal);
            if (adb.IsTouchReady && !currentStillPresent)
            {
                adb.Disconnect();
                ResetDeviceState();
            }

            devices.Items.Clear();
            devices.Items.AddRange(found.Cast<object>().ToArray());
            if (found.Count > 0)
            {
                var selected = currentStillPresent ? currentSerial : found[0];
                devices.SelectedItem = selected;
                await ConnectDeviceAsync(selected);
            }
            else
            {
                adb.Disconnect();
                ResetDeviceState();
                State("设备 0");
                return;
            }
            State($"设备 {found.Count}");
        }
        catch (Exception ex) { Error(ex); }
        finally { scanning = false; refreshLock.Release(); }
    }

    async Task<bool> RefreshMap(bool writeLog = true, bool waitForLock = false, Action? onMapReady = null, bool lockDeviceSelection = true)
    {
        if (closing || (activeEntry is { IsCompleted: false } && !entryRunMovementScope)) return false;
        // WinForms Timer 不会等待异步 Tick 处理程序。如果 ADB 卡住，
        // 过去每 500 毫秒就会启动一次新的刷新，每次都可能留下一个
        // adb screencap 进程，直到 Windows 耗尽提交内存。
        // 刷新只是获取快照，因此应跳过重叠请求，而不是排队形成不断增长的积压。
        var lockWait = Stopwatch.StartNew();
        if (waitForLock) await refreshLock.WaitAsync();
        else if (!await refreshLock.WaitAsync(0)) return false;
        if (onMapReady is not null) Log($"导航启动计时：刷新锁等待 {lockWait.ElapsedMilliseconds} ms");
        if (lockDeviceSelection) devices.Enabled = false;
        try { return await RefreshMapCore(writeLog, onMapReady); }
        finally
        {
            refreshLock.Release();
            if (lockDeviceSelection) UpdateDeviceAvailability();
        }
    }

    async Task<bool> RefreshMapCore(bool writeLog, Action? onMapReady)
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) return false;
        adb.Serial = devices.Text;
        if (onMapReady is not null)
        {
            async Task<bool> Measure(string stage, Func<Task<bool>> action)
            {
                var timer = Stopwatch.StartNew();
                try { return await action(); }
                finally { Log($"导航启动计时：{stage} {timer.ElapsedMilliseconds} ms"); }
            }
            var ready = await NavigationStartupUseCase.PrepareAsync(
                () => Measure("首次地图读取", () => RefreshMapSnapshot(writeLog)),
                () => Measure("覆盖层检查（与地图规划并行）", () => RefreshOverlayState(writeLog, failSafe: true)),
                onMapReady, operations.CurrentToken);
            if (!ready || runeSelectionVisible) return ready;

            // OCR 在冷启动时可能耗时数秒。在允许输入前只重新读取开销较低的
            // 地图/玩家导出数据，不再执行另一轮 OCR。如果期间玩家或目标发生变化，
            // 则重新计算。
            var planned = MapSnapshot.Capture(dungeon.Map!);
            if (!await Measure("OCR后地图复读", () => RefreshMapSnapshot(false))) return false;
            var latest = dungeon.Route.Snapshot!;
            if (planned.Level != latest.Level || planned.Player != latest.Player ||
                planned.StructureHash != latest.StructureHash ||
                (BossSealPolicy.AppliesTo(latest.Map) &&
                    (planned.Map.BossSeal.Ready != latest.Map.BossSeal.Ready ||
                     planned.Map.BossSeal.CurScore != latest.Map.BossSeal.CurScore)))
                onMapReady();
            return true;
        }

        // 普通启动/刷新只读取并提交地图。弹窗检查属于“开始”动作的
        // 安全预检，不应在控制器刚打开或定时刷新时启动 OCR。
        return await RefreshMapSnapshot(writeLog);
    }

    void LogOverlayUnknown()
    {
        var now = Environment.TickCount64;
        if (now - Interlocked.Read(ref lastOverlayUnknownLogAt) < 2000) return;
        Interlocked.Exchange(ref lastOverlayUnknownLogAt, now);
        Warn("弹窗状态未知");
    }

    async Task<bool> RefreshOverlayState(bool writeLog, bool failSafe = false)
    {
        // 点击“开始”后的路线预检先检查会拦截触摸的覆盖层。
        // 转场或刚打开的弹窗可能会短暂地使这些文件不可用；
        // 弹窗处理仍必须能够继续。
        try
        {
            adb.Serial = devices.Text;
            // 在同一帧检查两个覆盖层，避免重复截图。
            var frameId = adb.NextPopupFrameId();
            var captureTimer = Stopwatch.StartNew();
            var previousCaptureLog = adb.CaptureTimingLog;
            if (writeLog) adb.CaptureTimingLog = message => Log($"导航启动计时：帧={frameId}，{message}");
            Bitmap capturedScreen;
            try { capturedScreen = await adb.CaptureMovementPopupFrameAsync(frameId, operations.CurrentToken); }
            finally { adb.CaptureTimingLog = previousCaptureLog; }
            using var screen = capturedScreen;
            if (writeLog) Log($"导航启动计时：弹窗截图 {captureTimer.ElapsedMilliseconds} ms，帧={frameId}，尺寸={screen.Width}x{screen.Height}");
            var runPopupPipeline = writeLog || runeSelectionVisible;
            var popup = MovementPopupKind.None;
            PopupUiPipelineResult? popupPipeline = null;
            if (runPopupPipeline)
            {
                var pipelineTimer = Stopwatch.StartNew();
                var previousTimingLog = adb.OcrTimingLog;
                if (writeLog) adb.OcrTimingLog = message => Log($"导航启动计时：帧={frameId}，{message}");
                try { popupPipeline = await adb.RunPopupUiPipelineAsync(screen, frameId); }
                finally
                {
                    adb.OcrTimingLog = previousTimingLog;
                    if (writeLog) Log($"导航启动计时：弹窗识别管线 {pipelineTimer.ElapsedMilliseconds} ms，帧={frameId}");
                }
                popup = popupPipeline.Value;
            }
            else if (await adb.HasServerErrorDialog(screen))
            {
                popup = MovementPopupKind.ServerError;
            }

            if (popup == MovementPopupKind.ServerError)
            {
                if (!serverErrorDialogVisible)
                    Log("检测到服务器连接异常弹窗，已停止运行；请重新进入游戏", LogLevel.Error);
                serverErrorDialogVisible = true;
                await touch.EmergencyRelease();
                operations.Cancel(ControllerOperationKind.Movement);
                State("服务器连接异常，已停止运行");
                return false;
            }
            serverErrorDialogVisible = false;

            // 用户按下开始时，游戏可能停留在居中的“是否进入下一层？”对话框上。
            // 在同一次启动覆盖层检查中识别它，避免过期的地图传送门路线在模态框下方
            // 发送移动输入。交由 SelectBonus 接管后，下面的协程会实际点击按钮并执行
            // 确认循环。
            if (writeLog && floorPhase is not (FloorPhase.SelectBonus or FloorPhase.VerifyTransition) &&
                popup == MovementPopupKind.NextFloorDialog)
            {
                var nextFloorDialog = popupPipeline?.NextFloorDialog ?? NextFloorDialogKind.None;
                if (nextFloorDialog != NextFloorDialogKind.None)
                {
                    Log($"启动时检测到换层界面：{nextFloorDialog}，交由独立弹窗监控处理");
                    return true;
                }
            }

            if (writeLog && popup == MovementPopupKind.RiftGemSelection)
                Log("启动时检测到秘境宝石界面，交由独立弹窗监控处理");
            if (writeLog)
            {
                if (popupPipeline is not null)
                    Log($"弹窗管线诊断：结果 {popupPipeline.Value}，节点 {popupPipeline.NodeName ?? "无匹配"}，" +
                        $"节点={popupPipeline.AttemptSummary}，OCR宝石标题={PopupUiPipelineResult.SummarizeText(popupPipeline.RiftGemTitleText)}");
                Log($"秘境宝石选择 本帧命中={(popup == MovementPopupKind.RiftGemSelection ? "是" : "否")}，" +
                    $"锁存={(runeSelectionVisible ? "是" : "否")}，宝石标题 {adb.GemTitleDetectionMode} {adb.LastRiftGemTitle ?? "--"}");
            }
            return true;
        }
        catch (Exception)
        {
            // 地图刷新不依赖弹窗识别；预检失败只记录状态未知，
            // 运行中的路线仍需停机，避免在模态框下发送移动输入。
            LogOverlayUnknown();
            if (!failSafe) return true;
            operations.Cancel(ControllerOperationKind.Movement);
            try { await touch.EmergencyRelease(); } catch { }
            State("弹窗状态未知，已停止运行");
            return false;
        }
    }

    async Task<bool> RefreshMapSnapshot(bool writeLog)
    {
        try
        {
            adb.Serial = devices.Text;
            var result = await new DungeonSnapshotUseCase(dungeon, adb).RefreshAsync(operations.CurrentToken);
            var map = result.Map;
            foreach (var diagnostic in result.Diagnostics) runtime.Diagnostics.Record("JSON: " + diagnostic);
            foreach (var message in result.Messages) Log(message);
            mapPanel.Map = map; mapPanel.Route = miningRouteDisplaySuppressed ? [] : route; mapPanel.Invalidate();
            var seal = map.BossSeal;
            warningState.Visible = BossSealPolicy.AppliesTo(map);
            var warning = seal.Present
                ? $"  预警 {seal.CurScore}/{seal.WakeScore} ({seal.Percent}%) {(seal.Ready ? "守层Boss可攻击" : "守层Boss未解锁")}"
                : "  预警 --";
            warningState.Text = warning.Trim();
            warningState.ForeColor = seal.Present && seal.Ready ? currentPalette.SuccessText : currentPalette.WarningText;
            stats.Text = $"层 {map.Level}  人物 ({map.Player.X},{map.Player.Y})";
            mapPanel.InfoText = stats.Text;
            if (writeLog) Log("地图已刷新");
            return true;
        }
        catch (Exception ex) { if (writeLog) Error(ex); return false; }
    }

    void RefreshRiftSelectionState(bool writeLog, bool visible)
    {
        // 宝石选择覆盖层是真正会拦截触摸的 UI 层。
        // 新弹窗由独立的 PopupWatchdog 负责探测；这里仅在显式刷新或已经
        // 锁存为可见时用标题确认状态，避免路线循环反复启动整帧 OCR。
        var checkRunePopup = writeLog || runeSelectionVisible;
        if (!checkRunePopup) return;

        var wasVisible = runeSelectionVisible;
        if (visible)
        {
            LatchRiftGemSelection();
        }
        else if (wasVisible)
        {
            // PaddleOCR 在主进程中运行。连续两次未识别后才能判定覆盖层已关闭，
            // 否则单个慢帧可能会错误释放其下方的路线。
            runeSelectionMisses++;
            if (runeSelectionMisses >= 2)
            {
                if (runeSelectionStartedAt > 0)
                    portalDialogPausedMs += Math.Max(0, Environment.TickCount64 - runeSelectionStartedAt);
                Log("秘境宝石选择界面已关闭");
                runeSelectionVisible = false;
                runeSelectionMisses = 0;
                runeSelectionCard = -1;
                runeSelectionClickAttempts = 0;
                runeSelectionLastClickAt = 0;
                if (portalInteractionBlockedByGem)
                {
                    // 宝石覆盖层消耗了传送门点击。不要等待这次交互并未产生的转场对话框；
                    // 返回传送门并重试。
                    portalInteractionBlockedByGem = false;
                    floorPhase = FloorPhase.GoToPortal;
                    dungeon.PortalCandidate = null;
                    dungeon.PortalConfirmCount = 0;
                    route = [];
                    plannedInteractions = [];
                    plannedTargetUniverse.Clear();
                    mapPanel.Route = route;
                    mapPanel.Invalidate();
                    Log("秘境宝石选择已完成；传送门交互被遮挡，重新前往传送门");
                }
            }
        }
        else if (writeLog && !string.IsNullOrWhiteSpace(adb.LastRiftGemTitle))
        {
            Warn($"秘境宝石标题未匹配：{adb.LastRiftGemTitle}");
        }
    }

    // SendInteraction 只会在规划器有意停在非战斗任务旁边后使用。
    // 穿过即可拾取的目标不会进入此路径。
    // 其持续时间应独立于移动速度和脉冲时序。
}
