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
    Task StartRun() => RunMovement(StartRunCore, startupProbePaused: true);

    async Task NavigateToMapCell(Cell target)
    {
        // 拒绝无效点击，但不要干扰活动路线。有效点击采用最新请求优先：
        // 只串行化交接过程，而不是整个导航过程，这样另一次点击可以立即抢占。
        if (dungeon.Map is null || !dungeon.Map.ByCell.TryGetValue(target, out var tile) || !Planner.IsClickableTarget(tile))
        {
            State("该位置不可导航");
            Log($"地图点击已忽略：{target} 不是可行走道路或可交互目标，当前路线保持不变");
            return;
        }
        var requestVersion = Interlocked.Increment(ref clickNavigationVersion);
        var deferredLogged = false;
        while (requestVersion == Volatile.Read(ref clickNavigationVersion))
        {
            // 游戏战斗场景中的地图点击只会排队。这里不要取消当前运行或释放输入；
            // 等待现有战斗循环观察到战斗结束。
            if (dungeon.Map?.InBattle == true)
            {
                if (!deferredLogged)
                {
                    State($"战斗中，已记录导航目标 {target}");
                    Log($"战斗期间暂不执行地图点击；脱离战斗后切换至 {target}");
                    deferredLogged = true;
                }
                await Task.Delay(120);
                continue;
            }

            Task? navigation = null;
            await clickNavigationSwitch.WaitAsync();
            try
            {
                if (requestVersion != Volatile.Read(ref clickNavigationVersion)) return;
                // 获取切换锁后重新检查：此请求在等待前一个点击期间，战斗可能已经开始。
                if (dungeon.Map?.InBattle == true) continue;
                if (activeMovement is { IsCompleted: false })
                {
                    State($"切换导航目标至 {target}");
                    await StopMovement();
                }
                if (requestVersion != Volatile.Read(ref clickNavigationVersion)) return;
                navigation = RunMovement(() => NavigateToMapCellCore(target, requestVersion));
            }
            finally { clickNavigationSwitch.Release(); }
            if (navigation is not null) await navigation;
            return;
        }
    }

    async Task RunMapClick(Cell target)
    {
        if (closing) return;
        try
        {
            await uiOperations.RunAsync(() => NavigateToMapCell(target));
        }
        catch (Exception ex) { Error(ex); }
        finally
        {
            UpdateDeviceAvailability();
        }
    }

    async Task NavigateToMapCellCore(Cell target, int requestVersion)
    {
        var owner = new CancellationTokenSource();
        runCts = owner;
        touch.MovementCancellation = owner.Token;
        try
        {
            var startup = Stopwatch.StartNew();
            State($"正在读取地图并规划至 {target}");
            RoutePlan? initialPlan = null;
            var ready = await RefreshMap(true, waitForLock: true, onMapReady: () =>
            {
                var planning = Stopwatch.StartNew();
                initialPlan = Planner.PlanToTarget(dungeon.Map!, target, monsters.Checked, dungeon.Blocked);
                route = initialPlan.Route; plannedInteractions = initialPlan.Interactions;
                plannedTargetUniverse = initialPlan.TargetUniverse;
                mapPanel.Route = route; mapPanel.Invalidate();
                Log($"点击导航规划就绪 {startup.ElapsedMilliseconds} ms，其中路径规划 {planning.ElapsedMilliseconds} ms");
                State("路线已规划，等待弹窗检查完成");
            });
            owner.Token.ThrowIfCancellationRequested();
            if (serverErrorDialogVisible) return;
            if (!ready || dungeon.Map is null) { State("地图未就绪"); return; }
            Log($"点击导航启动检查完成 {startup.ElapsedMilliseconds} ms");
            if (!dungeon.Map.ByCell.TryGetValue(target, out var clickedTile) || !Planner.IsClickableTarget(clickedTile))
            {
                State("该位置不可导航");
                Log($"地图点击已忽略：{target} 不是可行走道路或可交互目标");
                return;
            }

            var clickedKind = clickedTile.Roles.Select(role => role.Kind)
                .FirstOrDefault(kind => kind.Length > 0 && kind != "未知");
            Log($"地图点击导航：{target}{(string.IsNullOrEmpty(clickedKind) ? "（道路）" : $"（{clickedKind}）")}，全清小怪={(monsters.Checked ? "是" : "否")}");
            var useInitialSnapshot = true;
            while (!owner.IsCancellationRequested && requestVersion == Volatile.Read(ref clickNavigationVersion))
            {
                if (useInitialSnapshot) useInitialSnapshot = false;
                else await RefreshMap(false, waitForLock: true);
                owner.Token.ThrowIfCancellationRequested();
                if (serverErrorDialogVisible) return;
                if (runeSelectionVisible)
                {
                    initialPlan = null;
                    await HandleRiftGemSelection(owner.Token);
                    continue;
                }
                if (dungeon.Map is null) { State("地图未就绪"); return; }
                if (dungeon.Map.InBattle)
                {
                    initialPlan = null;
                    await touch.EmergencyRelease();
                    State("战斗中，已停止移动");
                    await Task.Delay(120, owner.Token);
                    continue;
                }

                var player = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
                var targetStillPresent = !string.IsNullOrEmpty(clickedKind) && dungeon.Map.ByCell.TryGetValue(target, out var liveTargetTile) &&
                    liveTargetTile.Roles.Any(role => role.Kind == clickedKind);
                if ((string.IsNullOrEmpty(clickedKind) && player == target) || (!string.IsNullOrEmpty(clickedKind) && !targetStillPresent))
                {
                    State($"已到达点击目标 {target}");
                    Log($"地图点击导航完成：{target}");
                    return;
                }

                var plan = initialPlan ?? Planner.PlanToTarget(dungeon.Map, target, monsters.Checked, dungeon.Blocked);
                initialPlan = null;
                route = plan.Route;
                plannedInteractions = plan.Interactions;
                plannedTargetUniverse = plan.TargetUniverse;
                mapPanel.Route = route;
                mapPanel.Invalidate();
                if (!string.IsNullOrWhiteSpace(plan.FailureReason))
                {
                    State(plan.FailureReason);
                    Log($"地图点击导航失败：{target}，{plan.FailureReason}");
                    return;
                }

                var task = plannedInteractions.FirstOrDefault(interaction => interaction.Stop == player && HasTarget(interaction.Target));
                if (task != default)
                {
                    if (requestVersion != Volatile.Read(ref clickNavigationVersion)) return;
                    var delta = new Cell(task.Target.Cell.X - player.X, task.Target.Cell.Y - player.Y);
                    State($"点击导航交互 {task.Target.Kind}，方向 {delta.X},{delta.Y}");
                    var popupInterrupted = IsCombatInteraction(task.Target.Kind)
                        ? await FightWhileHolding(task, owner.Token)
                        : await SendInteraction((delta, task.Target.Kind), owner.Token);
                    if (popupInterrupted)
                    {
                        await HandleMovementPopupInterrupt(owner.Token);
                        continue;
                    }
                    if (task.Target.Cell == target && !IsCombatInteraction(task.Target.Kind))
                    {
                        State($"已交互点击目标 {target}");
                        Log($"地图点击导航完成：已交互 {task.Target.Kind} {target}");
                        return;
                    }
                    await Task.Delay(80, owner.Token);
                    continue;
                }

                if (route.Count < 2)
                {
                    State(player == target ? $"已到达点击目标 {target}" : "点击目标不可达");
                    return;
                }
                State($"自动导航至 {target}，剩余 {route.Count - 1} 步");
                var routeResult = await ExecuteRouteSlice(owner.Token);
                if (routeResult.InterruptedByPopup)
                {
                    await HandleMovementPopupInterrupt(owner.Token);
                    continue;
                }
                if (routeResult.RequiresReplan)
                {
                // RouteExecutor 已拒绝该路线，且没有发送另一条移动指令。
                // 在下一次点击导航迭代前刷新权威玩家位置并丢弃失败的规划；
                // 下一次会从该位置构建新路线。
                    await RefreshMap(false, waitForLock: true);
                    route = [];
                    plannedInteractions = [];
                    plannedTargetUniverse.Clear();
                    mapPanel.Route = route;
                    mapPanel.Invalidate();
                }
                await Task.Delay(20, owner.Token);
            }
        }
        catch (OperationCanceledException) { }
        finally
        {
            coroutines.StopAll(); portalChoiceCoroutine = null;
            try { await touch.TouchUp(); } catch (Exception ex) { Error(ex); }
            if (ReferenceEquals(runCts, owner)) runCts = null;
            owner.Dispose();
        }
    }

    bool PopupProbeEnabled()
        => !popupHandling && !startupPreparing && !runeSelectionVisible &&
           floorPhase is not (FloorPhase.SelectBonus or FloorPhase.VerifyTransition);

    string PopupProbeDisabledReason()
    {
        if (popupHandling) return "当前正在处理弹窗";
        if (startupPreparing) return "启动地图/OCR检查中";
        if (runeSelectionVisible) return "秘境宝石选择已锁存，等待点击/关闭确认";
        return floorPhase switch
        {
            FloorPhase.SelectBonus => "当前处于换层弹窗流程（OCR确认/加成选择）",
            FloorPhase.VerifyTransition => "当前处于换层确认流程",
            _ => "专用流程未结束"
        };
    }

    bool CancelCurrentMovementSlice()
    {
        lock (movementSliceGate)
        {
            if (currentMovementSlice is null) return false;
            try { currentMovementSlice.Cancel(); return true; }
            catch (ObjectDisposedException) { return false; }
        }
    }

    void SetCurrentMovementSlice(CancellationTokenSource? slice)
    {
        lock (movementSliceGate) currentMovementSlice = slice;
    }

    async Task<RouteExecutionResult> ExecuteRouteSlice(CancellationToken ownerToken)
    {
        using var slice = CancellationTokenSource.CreateLinkedTokenSource(ownerToken);
        SetCurrentMovementSlice(slice);
        try
        {
            var result = await routeExecutor.ExecuteDetailed(CreateRouteExecutionContext(), slice.Token, () => dungeon.MotionInterrupt.Reason);
            SetCurrentMovementSlice(null);
            return dungeon.MotionInterrupt.Reason == MotionInterruptReason.Popup
                ? new RouteExecutionResult(RouteExecutionStatus.InterruptedByPopup)
                : result;
        }
        finally { SetCurrentMovementSlice(null); }
    }

    async Task<bool> RunMovementSlice(CancellationToken ownerToken, Func<CancellationToken, Task> action)
    {
        using var slice = CancellationTokenSource.CreateLinkedTokenSource(ownerToken);
        SetCurrentMovementSlice(slice);
        try
        {
            await action(slice.Token);
            SetCurrentMovementSlice(null);
            if (dungeon.MotionInterrupt.Reason == MotionInterruptReason.Popup) return true;
            return false;
        }
        catch (OperationCanceledException) when (dungeon.MotionInterrupt.Reason == MotionInterruptReason.Popup)
        {
            return true;
        }
        finally { SetCurrentMovementSlice(null); }
    }

    async Task HandleMovementPopupInterrupt(CancellationToken ownerToken)
    {
        popupHandling = true;
        try
        {
            var kind = dungeon.MotionInterrupt.PopupKind;
            if (kind == MovementPopupKind.None) return;

        await touch.EmergencyRelease();
        Log($"检测到弹窗：{kind}，已释放触摸并暂停当前路线");
        route = [];
        plannedInteractions = [];
        plannedTargetUniverse.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();

        if (kind == MovementPopupKind.ServerError)
        {
            serverErrorDialogVisible = true;
            runCts?.Cancel();
            State("服务器连接异常，已停止运行");
            return;
        }

        if (kind == MovementPopupKind.RiftGemSelection)
        {
            // 看门狗已经通过共享管线完成标题识别；这里仅锁存状态，
            // 由主循环执行点击并确认覆盖层关闭。
            LatchRiftGemSelection();
        }
        else if (kind == MovementPopupKind.NextFloorDialog)
        {
            // 共享管线已经在同一帧给出了具体子类型。不要丢掉它后再
            // 重新截图识别，否则转场动画会把已确认的弹窗变成超时。
            pendingNextFloorDialog = dungeon.MotionInterrupt.NextFloorDialogKind;
            pendingGreedySelectionReturnOnly = dungeon.MotionInterrupt.GreedySelectionReturnOnly;
            pendingGreedySelectionReturnCards = dungeon.MotionInterrupt.GreedySelectionReturnCards;
            floorPhase = FloorPhase.SelectBonus;
            portalInteractionAt = portalInteractionAt > 0 ? portalInteractionAt : Environment.TickCount64;
            portalDialogPausedMs = 0;
            State("检测到换层弹窗，暂停移动等待处理");
        }
        // 会拦截触摸的覆盖层打断移动后，刷新非弹窗状态。
        // 这样下一次规划能获得权威的玩家/地图快照；上面的弹窗专用标志
        // 则能在地图导出暂时过期时保留正确的处理分支。
        await RefreshMap(false, waitForLock: true);
        if (!ownerToken.IsCancellationRequested && !serverErrorDialogVisible)
            State("弹窗已接管，等待处理完成后继续");
        }
        finally
        {
            dungeon.MotionInterrupt.Clear();
            popupHandling = false;
        }
    }

    async Task RunMovement(Func<Task> action, bool startupProbePaused = false)
    {
        if (closing || stopping || scanning || activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false }) return;
        if (startupProbePaused) startupPreparing = true;
        devices.Enabled = false;
        dungeon.MotionInterrupt.Clear();
        using var watchdogCts = new CancellationTokenSource();
        var watchdog = new PopupWatchdog(adb, touch, dungeon.MotionInterrupt, PopupProbeEnabled, CancelCurrentMovementSlice,
            popup => Log($"弹窗监控已锁存：{popup}，等待主循环接管"),
            ex => Log($"移动弹窗监控暂时失败：{ex.Message}"),
            message => Log(message),
            PopupProbeDisabledReason);
        var watchdogTask = watchdog.RunAsync(watchdogCts.Token);
        try { activeMovement = action(); await activeMovement; }
        finally
        {
            watchdogCts.Cancel();
            try { await watchdogTask; } catch (OperationCanceledException) { }
            dungeon.MotionInterrupt.Clear();
            touch.MovementCancellation = default;
            if (startupProbePaused) startupPreparing = false;
            UpdateDeviceAvailability();
        }
    }

    async Task StopMovement()
    {
        stopping = true;
        try
        {
            runCts?.Cancel();
            entryCts?.Cancel();
            try { await touch.EmergencyRelease(); } catch (Exception ex) { Error(ex); }
            if (activeMovement is not null) await activeMovement;
            if (activeEntry is not null) await activeEntry;
        }
        finally
        {
            // StopMovement 是一次新的运行/导航请求的边界。若上一次宝石弹窗
            // 在点击后被急停，PopupWatchdog 已停止探测，而锁存状态会一直
            // 遗留到下一次启动，导致普通战斗画面仍显示“宝石选择”。
            ClearRiftGemSelectionState();
            stopping = false;
        }
    }
}
