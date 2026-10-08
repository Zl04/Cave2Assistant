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
        if (closing || activeEntry is { IsCompleted: false }) return false;
        // WinForms Timer 不会等待异步 Tick 处理程序。如果 ADB 卡住，
        // 过去每 500 毫秒就会启动一次新的刷新，每次都可能留下一个
        // adb screencap 进程，直到 Windows 耗尽提交内存。
        // 刷新只是获取快照，因此应跳过重叠请求，而不是排队形成不断增长的积压。
        if (waitForLock) await refreshLock.WaitAsync();
        else if (!await refreshLock.WaitAsync(0)) return false;
        if (lockDeviceSelection) devices.Enabled = false;
        try { return await RefreshMapCore(writeLog, onMapReady); }
        finally { refreshLock.Release(); UpdateDeviceAvailability(); }
    }

    async Task<bool> RefreshMapCore(bool writeLog, Action? onMapReady)
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) return false;
        adb.Serial = devices.Text;
        if (onMapReady is not null)
        {
            var ready = await NavigationStartup.PrepareAsync(
                () => RefreshMapSnapshot(writeLog), () => RefreshOverlayState(writeLog, failSafe: true),
                onMapReady, runCts?.Token ?? default);
            if (!ready || runeSelectionVisible) return ready;

            // OCR 在冷启动时可能耗时数秒。在允许输入前只重新读取开销较低的
            // 地图/玩家导出数据，不再执行另一轮 OCR。如果期间玩家或目标发生变化，
            // 则重新计算。
            var planned = MapSnapshot.Capture(dungeon.Map!);
            if (!await RefreshMapSnapshot(false)) return false;
            var latest = dungeon.Route.Snapshot!;
            if (planned.Level != latest.Level || planned.Player != latest.Player ||
                planned.StructureHash != latest.StructureHash ||
                planned.Map.BossSeal.Ready != latest.Map.BossSeal.Ready ||
                planned.Map.BossSeal.CurScore != latest.Map.BossSeal.CurScore)
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
        Log("弹窗状态未知");
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
            using var screen = await adb.CaptureMovementPopupFrameAsync(frameId, runCts?.Token ?? default);
            var runPopupPipeline = writeLog || runeSelectionVisible;
            var popup = MovementPopupKind.None;
            PopupUiPipelineResult? popupPipeline = null;
            if (runPopupPipeline)
            {
                popupPipeline = await adb.RunPopupUiPipelineAsync(screen, frameId);
                popup = popupPipeline.Value;
            }
            else if (await adb.HasServerErrorDialog(screen))
            {
                popup = MovementPopupKind.ServerError;
            }

            if (popup == MovementPopupKind.ServerError)
            {
                if (!serverErrorDialogVisible)
                    Log("检测到服务器连接异常弹窗，已停止运行；请重新进入游戏");
                serverErrorDialogVisible = true;
                await touch.EmergencyRelease();
                runCts?.Cancel();
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
                    pendingNextFloorDialog = nextFloorDialog;
                    pendingGreedySelectionReturnOnly = popupPipeline?.GreedySelectionReturnOnly ?? false;
                    pendingGreedySelectionReturnCards = popupPipeline?.GreedySelectionReturnCards ?? Array.Empty<int>();
                    floorPhase = FloorPhase.SelectBonus;
                    portalInteractionAt = portalInteractionAt > 0 ? portalInteractionAt : Environment.TickCount64;
                    portalDialogPausedMs = 0;
                    runeSelectionVisible = false;
                    Log($"启动时检测到换层界面：{nextFloorDialog}，暂停路线并接管弹窗");
                    State("检测到换层弹窗，暂停移动等待处理");
                    return true;
                }
            }

            RefreshRiftSelectionState(writeLog, popup == MovementPopupKind.RiftGemSelection);
            if (writeLog)
            {
                if (popupPipeline is not null)
                    Log($"弹窗管线诊断：结果 {popupPipeline.Value}，节点 {popupPipeline.NodeName ?? "无匹配"}，" +
                        $"节点={popupPipeline.AttemptSummary}，OCR全屏={PopupUiPipelineResult.SummarizeText(popupPipeline.FullFrameText)}");
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
            runCts?.Cancel();
            try { await touch.EmergencyRelease(); } catch { }
            State("弹窗状态未知，已停止运行");
            return false;
        }
    }

    async Task<bool> RefreshMapSnapshot(bool writeLog)
    {
        try
        {
            adb.Serial = devices.Text; var previousMap = dungeon.Map; var map = await adb.ReadMap(); var player = await adb.ReadPlayer();
            // JSON 容错诊断仍会被收集，但暂时不在界面日志中输出，避免
            // 正常的默认值修正淹没移动和规划日志。
            _ = JsonDiagnostics.Drain();
            if (player.MoveSpeed > 0) dungeon.RouteExecution.MoveSpeed = player.MoveSpeed;
            RouteExecutor.ApplyPlayerStatus(map, player);
            if (previousMap is not null)
                foreach (var unlock in dungeon.PortalUnlocks.Observe(previousMap, map))
                    Log($"检测到传送门解锁：{unlock.Portal}，关联消失小怪 {string.Join(", ", unlock.DefeatedMonsters)}");
            if (dungeon.PendingRoomPortal is { } roomPortal && previousMap is not null && dungeon.RoomPortalOrigin is { } origin &&
                map.Level == previousMap.Level && PortalJumpGraph.KeyOf(map) == PortalJumpGraph.KeyOf(previousMap))
            {
                var now = new Cell(map.Player.X, map.Player.Y);
                if (dungeon.PortalJumps.Observe(previousMap, roomPortal.Cell, map, out var destination, dungeon.RoomPortalOrigin))
                {
                    // 将落地传送门视为本楼层自动探索流程中已消耗。
                    // 这样可以防止下一次规划立即激活双传送门循环的反向边。
                    dungeon.AttemptedRoomPortals.Add(destination);
                    var sourceRole = previousMap.ByCell.TryGetValue(roomPortal.Cell, out var sourceTile)
                        ? sourceTile.Roles.FirstOrDefault(role => role.Kind == roomPortal.Kind)
                        : null;
                    var description = sourceRole is null ? "层内传送门" : PortalRouting.Describe(sourceRole);
                    Log($"层内传送已确认：{roomPortal.Cell} -> {destination}（{description}，已记录 {dungeon.PortalJumps.EdgeCount(map)} 条边）");
                    dungeon.PendingRoomPortal = null; dungeon.RoomPortalOrigin = null; dungeon.RoomPortalInteractionAt = 0;
                }
                else if (now != origin && now != roomPortal.Cell)
                {
                    if (PortalRouting.NearestRoomPortal(map, now) is { } landingPortal)
                        dungeon.AttemptedRoomPortals.Add(landingPortal);
                    Log($"层内传送已发生：{roomPortal.Cell} -> {now}，落点附近没有可确认的传送门，保留当前位置重新寻路");
                    dungeon.PendingRoomPortal = null; dungeon.RoomPortalOrigin = null; dungeon.RoomPortalInteractionAt = 0;
                }
            }
            dungeon.Mechanisms.ObserveLevel(map.Level);
            dungeon.Map = map; dungeon.Route.Snapshot = MapSnapshot.Capture(map); mapPanel.Map = map; mapPanel.Route = route; mapPanel.Invalidate();
            RecordMechanismVisit(map);
            var tiles = map.Tiles.SelectMany(x => x).Where(t => t.Walkable).ToList();
            var seal = map.BossSeal;
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
            Log($"秘境宝石标题未匹配：{adb.LastRiftGemTitle}");
        }
    }

    // SendInteraction 只会在规划器有意停在非战斗任务旁边后使用。
    // 穿过即可拾取的目标不会进入此路径。
    // 其持续时间应独立于移动速度和脉冲时序。
}
