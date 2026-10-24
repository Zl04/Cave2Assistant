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
    int pendingFogRevealLevel = -1;

    async Task TryRevealNewFloorAsync(CancellationToken token)
    {
        var map = dungeon.Map;
        if (map is null || pendingFogRevealLevel != map.Level) return;
        pendingFogRevealLevel = -1;
        if (map.AllExplored || map.Tiles.SelectMany(row => row).Where(tile => tile.Walkable).All(tile => tile.Explored) ||
            map.InBattle || map.SceneType == 1) return;
        var tool = await adb.FindBottomToolAsync(BottomToolKind.FogReveal, token);
        if (tool?.Quantity is not > 0) return;
        await touch.TouchUp();
        await adb.TapScreen(tool.X, tool.Y);
        Log($"新层 {map.Level} 使用清除迷雾道具，使用前数量 {tool.Quantity}");
        await Task.Delay(400, token);
        await RefreshMap(false, waitForLock: true);
        if (dungeon.Map?.Level == map.Level && dungeon.Map.AllExplored)
            Log($"新层 {map.Level} 迷雾已全部清除");
        else
            Warn($"新层 {map.Level} 使用道具后尚未确认迷雾清除");
    }
    async Task StartRunCore(CancellationToken owner)
    {
        lastMapRunSucceeded = false;
        MaaPipelineCatalog catalog;
        try
        {
            var path = runtime.Paths.Pipeline("map-run-pipeline.json");
            catalog = MaaPipelineCatalogLoader.Load(path);
        }
        catch (Exception ex)
        {
            Error(ex);
            State("任务流水线配置无效");
            return;
        }

        var trace = new MaaPipelineTraceCollector();
        var liveTrace = new DelegateMaaPipelineTraceSink(value =>
        {
            var task = value.TaskName ?? value.TaskChain;
            switch (value.Kind)
            {
                case MaaPipelineTraceKind.CandidateRecognized:
                    Log($"MAA Pipeline 识别：{task}，命中={value.Matched}，得分={value.Score:0.000}，详情={value.Detail ?? "-"}");
                    break;
                case MaaPipelineTraceKind.NodeStarted:
                    Log($"MAA Pipeline 节点开始：{task}，第 {value.ExecutionCount} 次");
                    break;
                case MaaPipelineTraceKind.ActionStarted:
                    Log($"MAA Pipeline 动作：{task} / {value.Action}");
                    break;
                case MaaPipelineTraceKind.NodeCompleted:
                    Log($"MAA Pipeline 节点完成：{task}，耗时 {value.Duration.TotalMilliseconds:0}ms");
                    break;
                case MaaPipelineTraceKind.NodeFailed:
                case MaaPipelineTraceKind.TaskChainFailed:
                    Log($"MAA Pipeline 失败：{task}，{value.Error ?? value.Detail}", LogLevel.Error);
                    break;
                case MaaPipelineTraceKind.BranchSelected:
                    Log($"MAA Pipeline 分支：{task} -> {value.Detail ?? "停止"}");
                    break;
                case MaaPipelineTraceKind.Retrying:
                    Log($"MAA Pipeline 重试：{value.Detail}");
                    break;
            }
        });
        var pipeline = new MaaPipeline<MainForm>(
            catalog,
            [new DelegateMaaPipelineHandler<MainForm>(
                "RunDungeon",
                (_, _, _) => Task.FromResult(MaaPipelineRecognitionResult.Hit(detail: "JustReturn")),
                (_, _, context, token) => context.State.RunDungeonTaskCore(token))],
            new MaaPipelineExecutionOptions { TaskChain = "MapRun", RetryTimes = 0 },
            new MaaPipelineTraceMultiplexer([trace, liveTrace, pipelineWebServer]));

        var result = await pipeline.RunAsync(this, ["RunDungeon"], owner);
        lastMapRunSucceeded = result.Succeeded;
        try
        {
            var tracePath = runtime.Paths.Trace($"map-run-{result.RunId}.json");
            trace.SaveJson(tracePath);
            Log($"MAA Pipeline 节点诊断已保存：{tracePath}");
        }
        catch (Exception ex) { Warn($"MAA Pipeline 节点诊断保存失败：{ex.Message}"); }
        if (!result.Succeeded && result.Status != MaaPipelineExecutionStatus.Canceled)
        {
            State("任务流水线失败");
            Log($"MAA Pipeline 已停止：{result.Status}，{result.Error}");
        }
    }

    async Task<MaaPipelineActionResult> RunDungeonTaskCore(CancellationToken pipelineToken)
    {
        // 停层标记只属于上一次运行。停止后玩家可能已手动重新进图，
        // 每次开始都必须刷新地图，再按当前楼层和剩余目标判断是否停住。
        dungeon.TargetFloorStopped = false;
        dungeon.FloorMiningCompletedLevel = -1;
        dungeon.FloorMiningSkippedLevel = -1;
        escapeScrollPending = false;
        escapeScrollLastProbeAt = 0;
        escapeReturnDiagnostic = null;
        escapeReturnDiagnosticAt = 0;
        var owner = pipelineToken;
        var runTask = new MapRunTask();
        try
        {
            var startup = Stopwatch.StartNew();
            State("开始前刷新地图并强制规划");
            bool ready;
            try
            {
                ready = await RefreshMap(true, waitForLock: true, onMapReady: () =>
                {
                    if (dungeon.Map is not null && MapRunTask.IsReturnDestination(dungeon.Map)) return;
                    var planning = Stopwatch.StartNew();
                    ReplanFromCurrentMap();
                    Log($"导航规划就绪 {startup.ElapsedMilliseconds} ms，其中路径规划 {planning.ElapsedMilliseconds} ms");
                    State("路线已规划，等待弹窗检查完成");
                });
            }
            finally
            {
                // RefreshMap 已完成启动时的截图/OCR预检；从这里开始让 watchdog
                // 负责新出现的覆盖层，并保持移动期间的独立探测。
                startupPreparing = false;
            }
            if (dungeon.MotionInterrupt.Reason == MotionInterruptReason.Popup)
                await HandleMovementPopupInterrupt(owner);
            if (serverErrorDialogVisible || owner.IsCancellationRequested)
            {
                return serverErrorDialogVisible
                    ? MaaPipelineActionResult.Failure("服务器连接异常")
                    : throw new OperationCanceledException(owner);
            }
            // 刷新已经等待完成的标题 OCR（包括模型启动）。
            // 重复执行否定检查会拖慢每次正常启动；移动开始后由移动看门狗监控新覆盖层。
            if ((!ready || dungeon.Map is null) && !runeSelectionVisible && floorPhase != FloorPhase.SelectBonus)
            {
                State("地图未就绪");
                Log($"跑图启动地图刷新失败：refresh={(ready ? "完成" : "未完成")}，map={(dungeon.Map is null ? "缺失" : "已加载")}，Entry跑图授权={entryRunMovementScope}", LogLevel.Error);
                return MaaPipelineActionResult.Failure("地图未就绪");
            }
            if (dungeon.Map is not null) runTask.Observe(dungeon.Map);
            if (await TryStopForCardMiningAsync(owner)) return MaaPipelineActionResult.Success();
            // 宝石选择覆盖层会消耗所有触摸输入。不要在其下方构建或启动移动路线；
            // RunLoop 会先执行有界的点击/重试序列，关闭后再恢复。
            if (runeSelectionVisible)
            {
                route = [];
                plannedInteractions = [];
                plannedTargetUniverse.Clear();
                mapPanel.Route = route;
                mapPanel.Invalidate();
                State("秘境宝石选择：等待自动选择");
                Log("启动检查已锁存秘境宝石选择，先执行一次专用点击流程");
                await HandleRiftGemSelection(owner);
                await RunLoop(owner, runTask, useInitialSnapshot: true);
                return runTask.Completed || cardMiningTaskRunning && (dungeon.TargetFloorStopped || cardMiningEarlyStop) ? MaaPipelineActionResult.Success() : MaaPipelineActionResult.Failure("跑图已停止，尚未返回主城或公会");
            }
            if (dungeon.Map is { } startupSaleMap) await HandleMerchantEquipmentSale(startupSaleMap, owner);
            if (await TryReturnWithEscapeScroll(owner))
            {
                await RunLoop(owner, runTask, useInitialSnapshot: true);
                return runTask.Completed ? MaaPipelineActionResult.Success() : MaaPipelineActionResult.Failure("卷轴回城尚未完成");
            }
            if (dungeon.Map is not null && !MapRunTask.IsReturnDestination(dungeon.Map) &&
                floorPhase != FloorPhase.WaitingFloorLoad && await TryStopAtTargetFloor())
            {
                return cardMiningTaskRunning ? MaaPipelineActionResult.Success() : MaaPipelineActionResult.Failure("已在目标楼层暂停，尚未返回主城或公会");
            }
            Log($"导航启动检查完成 {startup.ElapsedMilliseconds} ms");
            owner.ThrowIfCancellationRequested();
            State("运行中");
            await RunLoop(owner, runTask, useInitialSnapshot: true);
            return runTask.Completed || cardMiningTaskRunning && (dungeon.TargetFloorStopped || cardMiningEarlyStop) ? MaaPipelineActionResult.Success() : MaaPipelineActionResult.Failure("跑图已停止，尚未返回主城或公会");
        }
        catch (OperationCanceledException) { throw; }
        catch (Exception ex)
        {
            startupPreparing = false;
            Error(ex);
            return MaaPipelineActionResult.Failure(ex.Message);
        }
    }
    async Task RunLoop(CancellationToken owner, MapRunTask runTask, bool useInitialSnapshot = false)
    {
        // 使用一次启动时刚检查过的快照；后续迭代继续执行常规的地图/覆盖层刷新。
        var skipRefreshForConfirmedTaskStop = useInitialSnapshot;
        Exception? executionError = null;
        try
        {
            while (!owner.IsCancellationRequested)
            {
                if (dreamTrialRunning && await TryHandleDreamTrialVictoryAsync(owner))
                    continue;
                if (escapeScrollPending)
                {
                    await TryReturnWithEscapeScroll(owner);
                    continue;
                }
                if (dungeon.MotionInterrupt.Reason == MotionInterruptReason.Popup)
                {
                    await HandleMovementPopupInterrupt(owner);
                    continue;
                }
                // RouteExecutor 已在每个分段边界执行释放后的玩家状态读取。
                // 当该读取确认已到达规划的任务停靠点时，直接使用该结果，
                // 不必在发送交互前再次进行完整的地图/弹窗刷新。
                // 下面的交互分支仍会执行自己的最终释放和坐标检查。
                if (skipRefreshForConfirmedTaskStop)
                {
                    skipRefreshForConfirmedTaskStop = false;
                }
                else
                {
                    await RefreshMap(false);
                }
                if (serverErrorDialogVisible || owner.IsCancellationRequested) break;
                if (dungeon.Map is { } observedMap)
                {
                    if (runTask.Observe(observedMap))
                    {
                        var finalized = await CloseReturnTownDialogsAsync(owner);
                        route = []; plannedInteractions = []; plannedTargetUniverse.Clear();
                        mapPanel.Route = route; mapPanel.Invalidate();
                        if (finalized)
                        {
                            runTask.MarkCompleted();
                            State("跑图任务完成：已返回主城并完成弹窗检查");
                            Log($"跑图任务完成：{observedMap.MapName}，地图 {observedMap.Level}，同屏场景 {observedMap.TownMapId}");
                        }
                        else
                        {
                            State("跑图收尾失败：回城弹窗未关闭");
                            Log("已返回主城，但回城弹窗未能关闭；本轮未标记完成", LogLevel.Error);
                        }
                        break;
                    }
                    if (MapRunTask.IsReturnDestination(observedMap))
                    {
                        State("跑图任务等待进入地图");
                        await Task.Delay(180, owner);
                        continue;
                    }
                }
                if (dungeon.Map is { } saleMap) await HandleMerchantEquipmentSale(saleMap, owner);
                if (floorPhase == FloorPhase.WaitingReturnTown)
                {
                    State("已选择安全回城，等待主城地图加载");
                    await Task.Delay(120, owner);
                    continue;
                }
                // 看门狗在宝石选择锁存期间暂停探测；由主循环复用同一套
                // OCR/弹窗管线确认它已关闭，避免点击后永久停留在宝石状态。
                if (runeSelectionVisible)
                {
                    await RefreshOverlayState(false, failSafe: true);
                    if (serverErrorDialogVisible || owner.IsCancellationRequested) break;
                }
                if (runeSelectionVisible)
                {
                    await HandleRiftGemSelection(owner);
                    continue;
                }
                if (dungeon.Map is null)
                {
                    State("地图未就绪，等待弹窗/地图数据");
                    await Task.Delay(120, owner);
                    continue;
                }
                // InBattle 由游戏运行时导出，是唯一必须暂停路线执行的状态。
                // 保留现有路线和目标，使移动能在胜利或逃跑后恢复，而不必无谓地重新规划。
                if (dungeon.Map.InBattle)
                {
                    await touch.EmergencyRelease();
                    State("战斗中，已停止移动");
                    await Task.Delay(120, owner);
                    continue;
                }
                UpdateFloorPhase();
                if (dungeon.PendingRoomPortal is { } waitingRoomPortal && dungeon.RoomPortalOrigin is { } roomOrigin)
                {
                    var now = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
                    if (now == roomOrigin && Environment.TickCount64 - dungeon.RoomPortalInteractionAt < 5000)
                    {
                        State($"等待层内传送门跳转 {waitingRoomPortal.Cell}");
                        await Task.Delay(80, owner);
                        continue;
                    }
                    // 到达传送门格但没有自动跳转，仍是有效的中间状态：
                    // 保留规划的交互，以便下一个分支触发它。
                    if (now != waitingRoomPortal.Cell)
                    {
                        if (now == roomOrigin)
                            Warn($"层内传送门 {waitingRoomPortal.Cell} 超时未改变坐标，按当前位置恢复寻路");
                        dungeon.PendingRoomPortal = null; dungeon.RoomPortalOrigin = null; dungeon.RoomPortalInteractionAt = 0;
                        route = []; plannedInteractions = []; plannedTargetUniverse.Clear();
                        mapPanel.Route = route; mapPanel.Invalidate();
                    }
                }
                if (floorPhase == FloorPhase.WaitingFloorLoad)
                {
                    State($"等待新层加载 {(newFloorStartDelay.Value / 1000):0.##} 秒");
                    await Task.Delay(80, owner); continue;
                }
                await TryRevealNewFloorAsync(owner);
                if (await TryReturnWithEscapeScroll(owner)) continue;
                if (await TryStopForCardMiningAsync(owner)) break;
                if (await TryStopAtTargetFloor()) break;
                // 已满足的楼层门控优先于探索。快捷入口会自行检查活动目标/Boss，
                // 即使当前地图仍有迷雾，也允许继续前进。
                if (await TryUseNextFloorShortcut(owner))
                {
                    await Task.Delay(80, owner);
                    continue;
                }
                ReconcileCompletedTasks();
                // 传送门停靠点是一个同步点。玩家到达该格后，
                // 必须先完成交互，再让普通规划将路线视为耗尽并替换它。
                var atPlannedInteractionStop = IsAtPlannedInteractionStop(new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y));
                if (!atPlannedInteractionStop)
                {
                    if (floorPhase == FloorPhase.GoToPortal) EnsurePortalRoute();
                    else if (floorPhase is not (FloorPhase.InteractPortal or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)) EnsureRoute();
                }
                if (floorPhase is FloorPhase.SelectBonus or FloorPhase.VerifyTransition)
                {
                    if (floorPhase == FloorPhase.SelectBonus && pendingNextFloorDialog == NextFloorDialogKind.None &&
                        Environment.TickCount64 - portalInteractionAt >= 1500)
                    {
                        if (await adb.HasNextFloorButton())
                        {
                            await adb.TapScreen(0.890625, 0.498);
                            Log("换层弹窗尚未出现，重新点击前往下层快捷入口");
                        }
                        else if (portalInteractionDelta != default)
                        {
                            if (dungeon.Map is null || !await ConfirmInteractionStop(new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y), owner))
                            {
                                floorPhase = FloorPhase.GoToPortal;
                                continue;
                            }
                            if (await SendInteraction((portalInteractionDelta, portalInteractionKind), owner))
                            {
                                await HandleMovementPopupInterrupt(owner);
                                continue;
                            }
                            Log("换层弹窗尚未出现，重新交互楼层传送门");
                        }
                        portalInteractionAt = Environment.TickCount64;
                    }
                    if (floorPhase == FloorPhase.VerifyTransition && Environment.TickCount64 - portalInteractionAt > 8000)
                    {
                        Log("出口交互后 8 秒仍未检测到换层，重新确认传送门入口"); floorPhase = FloorPhase.GoToPortal; dungeon.PortalCandidate = null; dungeon.PortalConfirmCount = 0;
                    }
                    await Task.Delay(180, owner); continue;
                }
                var currentCell = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
                var plannedTask = plannedInteractions.FirstOrDefault(task => task.Stop == currentCell &&
                    (HasTarget(task.Target) || PortalRouting.IsPortalKind(task.Target.Kind)));
                if (plannedTask != default)
                {
                    // 路线可能在长按分段后立即结束。
                    // 在任务停靠点强制执行第二次同步释放，避免交互准备期间
                    // 飞行中的方向指令提交额外的地图格。
                    if (!await ConfirmInteractionStop(currentCell, owner))
                    {
                        // 不要在此处退出 RunLoop。任务停靠点的超调会同时使路线和交互停靠点失效，
                        // 但自动化必须继续运行，并从权威位置重新构建。
                        await RefreshMap(false, waitForLock: true);
                        route = [];
                        plannedInteractions = [];
                        plannedTargetUniverse.Clear();
                        mapPanel.Route = route;
                        mapPanel.Invalidate();
                        if (PortalRouting.IsPortalKind(plannedTask.Target.Kind) && !IsRoomPortalTarget(plannedTask.Target))
                        {
                            floorPhase = FloorPhase.GoToPortal;
                            EnsurePortalRoute();
                        }
                        else EnsureRoute(true);
                        await Task.Delay(10, owner);
                        continue;
                    }
                    var delta = new Cell(plannedTask.Target.Cell.X - currentCell.X, plannedTask.Target.Cell.Y - currentCell.Y);
                    State($"任务交互 {plannedTask.Target.Kind}，方向 {delta.X},{delta.Y}");
                    var isRoomPortal = IsRoomPortalTarget(plannedTask.Target);
                    if (isRoomPortal)
                    {
                        if (await SendInteraction((delta, plannedTask.Target.Kind), owner))
                        {
                            await HandleMovementPopupInterrupt(owner);
                            continue;
                        }
                        dungeon.AttemptedRoomPortals.Add(plannedTask.Target.Cell);
                        dungeon.PendingRoomPortal = plannedTask.Target;
                        dungeon.RoomPortalOrigin = currentCell;
                        dungeon.RoomPortalInteractionAt = Environment.TickCount64;
                    }
                    else if (PortalRouting.IsPortalKind(plannedTask.Target.Kind))
                    {
                        if (cancelledNextFloorLevel == dungeon.Map.Level)
                        {
                            floorPhase = FloorPhase.Explore;
                            route = [];
                            plannedInteractions = [];
                            plannedTargetUniverse.Clear();
                            mapPanel.Route = route;
                            mapPanel.Invalidate();
                            await Task.Delay(80, owner);
                            continue;
                        }
                        portalInteractionDelta = delta;
                        portalInteractionKind = plannedTask.Target.Kind;
                        // 到达楼层传送门后，必须在任何换层动作前完成挖矿判断。
                        // 这里既覆盖传送门交互，也覆盖同一位置出现的右侧快捷入口，
                        // 防止先触发“前往下一层”弹窗后才进入挖矿流程。
                        if (await TryMineBeforeFloorTransition(owner, transitionAvailable: true))
                        {
                            await Task.Delay(20, owner);
                            continue;
                        }
                        // 常规循环会在路线执行前检查目标楼层，但此传送门任务是路线停止后
                        // 到达的第二条转场路径。在任何传送门交互前立即重新检查，
                        // 避免快捷入口绕过楼层停止设置。
                        if (dungeon.Map is not null && IsTargetStopFloor(dungeon.Map))
                        {
                            if (await TryStopAtTargetFloor()) break;
                            if (!dungeon.ShortcutDeferredByTargets)
                                Log("已到达指定层，但停层条件尚未满足，暂不交互传送门");
                            dungeon.ShortcutDeferredByTargets = true;
                            floorPhase = FloorPhase.Explore;
                            route = [];
                            plannedInteractions = [];
                            plannedTargetUniverse.Clear();
                            mapPanel.Route = route;
                            mapPanel.Invalidate();
                            await Task.Delay(80, owner);
                            continue;
                        }

                        var hasShortcut = await adb.HasNextFloorButton();
                        Log($"传送门快捷入口检测：{(hasShortcut ? "存在" : "不存在")}");
                        if (hasShortcut)
                        {
                            var shortcutTapTimer = Stopwatch.StartNew();
                            await adb.TapScreen(0.890625, 0.498);
                            Log("检测到右侧‘前往下层’快捷入口，已点击");
                            Log($"换层弹窗诊断：传送门快捷入口点击耗时={shortcutTapTimer.ElapsedMilliseconds}ms");
                        }
                        else if (await SendInteraction((delta, plannedTask.Target.Kind), owner))
                        {
                            await HandleMovementPopupInterrupt(owner);
                            continue;
                        }
                    }
                    else if (plannedTask.Target.Kind == "直接挑战Boss NPC")
                    {
                        if (await SendInteraction((delta, plannedTask.Target.Kind), owner))
                        {
                            await HandleMovementPopupInterrupt(owner);
                            continue;
                        }
                        await HandleDirectBossDialogAsync(plannedTask.Target, owner);
                        route = []; plannedInteractions = []; plannedTargetUniverse.Clear();
                        mapPanel.Route = route; mapPanel.Invalidate();
                        await RefreshMap(false, waitForLock: true);
                        continue;
                    }
                    else if (plannedTask.Target.Kind == "机关密室")
                    {
                        if (await SendInteraction((delta, plannedTask.Target.Kind), owner))
                        {
                            await HandleMovementPopupInterrupt(owner);
                            continue;
                        }
                        await RefreshMap(false, waitForLock: true);
                        route = []; plannedInteractions = []; plannedTargetUniverse.Clear();
                        mapPanel.Route = route; mapPanel.Invalidate();
                        await Task.Delay(300, owner);
                        continue;
                    }
                    else if (IsCombatInteraction(plannedTask.Target.Kind))
                    {
                        if (await FightWhileHolding(plannedTask, owner))
                        {
                            await HandleMovementPopupInterrupt(owner);
                            continue;
                        }
                    }
                    else if (await SendInteraction((delta, plannedTask.Target.Kind), owner))
                    {
                        await HandleMovementPopupInterrupt(owner);
                        continue;
                    }
                    if (plannedTask.Target.Kind == "密室")
                    {
                        dungeon.InteractedChambers.Add(plannedTask.Target.Cell);
                        Log($"已记录密室交互：{plannedTask.Target.Cell}，等待游戏地图刷新");
                    }
                    // 任务停靠点是一个同步点。到达任务且没有再次摆动后，
                    // 恢复常规连续移动模式，执行下一个分段。
                    dungeon.RouteExecution.ClearPulseFallback();
                    Log($"触发计划任务 {plannedTask.Target.Kind} {plannedTask.Target.Cell}，等待地图确认；不重规划");
                    if (isRoomPortal)
                    {
                        plannedInteractions.Remove(plannedTask);
                        route = []; plannedTargetUniverse.Clear(); floorPhase = FloorPhase.Explore;
                        mapPanel.Route = route; mapPanel.Invalidate();
                        State("已交互层内传送门，等待服务端跳转");
                    }
                    else if (PortalRouting.IsPortalKind(plannedTask.Target.Kind))
                    {
                        plannedInteractions.Remove(plannedTask); floorPhase = FloorPhase.SelectBonus;
                        portalInteractionAt = Environment.TickCount64;
                        portalDialogPausedMs = 0;
                        State("已交互传送门，等待换层弹窗");
                    }
                    await Task.Delay(50, owner);
                    continue;
                }
                if (route.Count < 2)
                {
                    var reachableTargets = ReachableActiveTargets(dungeon.Map, Options());
                    if (Options().Chambers && MechanismChamberPolicy.HasLockedEntrance(dungeon.Map) &&
                        reachableTargets.Count == 0 && !Planner.HasReachableUnexplored(dungeon.Map, dungeon.Blocked))
                    {
                        if (dungeon.LockedChamberWaitSince == 0) dungeon.LockedChamberWaitSince = Environment.TickCount64;
                        if (Environment.TickCount64 - dungeon.LockedChamberWaitSince > 8000)
                            throw new InvalidOperationException($"机关密室仍锁定，且无可触发机关或可探索区域；失败机关：{string.Join(", ", dungeon.StalledMechanisms)}");
                    }
                    else dungeon.LockedChamberWaitSince = 0;
                    if (floorPhase == FloorPhase.Explore && reachableTargets.Count == 0)
                    {
                        // 当前没有可到达的目标时，探索是主要动作。
                        // 在检查下一层快捷入口前先执行探索；否则当前地图仍有未发现路径时，
                        // 快捷入口可能会抢先执行。
                        if (TryPlanExplorationRoute())
                        {
                            await Task.Delay(20, owner);
                            continue;
                        }
                        if (await TryExploreWithoutTarget(owner)) continue;
                    }
                    // 探索规划失败时，不能在右侧下一层快捷入口出现前终止运行。
                    // 这是探索已经没有剩余路线时的回退逻辑。
                    if (await TryUseNextFloorShortcut(owner))
                    {
                        await Task.Delay(80, owner);
                        continue;
                    }
                    if (floorPhase == FloorPhase.GoToPortal)
                    {
                        State("传送门暂不可达，等待道路更新");
                        dungeon.PortalCandidate = null; dungeon.PortalConfirmCount = 0;
                        await Task.Delay(100, owner); continue;
                    }
                    if (floorPhase == FloorPhase.Explore && reachableTargets.Count == 0)
                    {
                        State("探索地图，等待发现勾选目标");
                        await Task.Delay(180, owner);
                        continue;
                    }
                    if (await TryPlanningRecovery(owner)) continue;
                    if (reachableTargets.Count == 0)
                    {
                        State("无有效目标，等待下一层入口");
                        await Task.Delay(180, owner);
                        continue;
                    }
                    State("无目标，等待返回主城或公会");
                    await Task.Delay(180, owner);
                    continue;
                }
                ArmRoomPortalTransition();
                var executedRoute = route.ToArray();
                var routeResult = await ExecuteRouteSlice(owner);
                if (routeResult.Status == RouteExecutionStatus.Completed && dungeon.Map is { } traversedMap)
                {
                    var arrival = new Cell(traversedMap.Player.X, traversedMap.Player.Y);
                    var arrivalIndex = Array.IndexOf(executedRoute, arrival);
                    for (var index = 1; index <= arrivalIndex; index++)
                    {
                        var cell = executedRoute[index];
                        if (dungeon.PendingMechanismPasses.ContainsKey(cell) ||
                            !traversedMap.ByCell.TryGetValue(cell, out var tile)) continue;
                        var trigger = tile.Roles.FirstOrDefault(MechanismChamberPolicy.IsPendingTrigger);
                        if (trigger is not null)
                            dungeon.PendingMechanismPasses[cell] = (trigger.TriggeredCount, Environment.TickCount64);
                    }
                }
                if (routeResult.InterruptedByPopup)
                {
                    await HandleMovementPopupInterrupt(owner);
                    continue;
                }
                if (routeResult.RequiresReplan)
                {
                    // 执行器已经采样了玩家实际所在格，但替换失败路线前也要刷新格子表。
                    // 这样可以防止超调/偏离后在紧循环中重试过期路线。
                    await RefreshMap(false, waitForLock: true);
                    if (floorPhase == FloorPhase.GoToPortal) EnsurePortalRoute();
                    else if (floorPhase is not (FloorPhase.InteractPortal or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)) EnsureRoute(true);
                }
                else if (dungeon.Map is not null)
                {
                    var arrived = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
                    skipRefreshForConfirmedTaskStop = plannedInteractions.Any(task => task.Stop == arrived &&
                        (HasTarget(task.Target) || PortalRouting.IsPortalKind(task.Target.Kind)));
                    if (skipRefreshForConfirmedTaskStop) continue;
                }
                await Task.Delay(10, owner);
            }
            if (serverErrorDialogVisible) throw new IOException("服务器连接已断开");
            owner.ThrowIfCancellationRequested();
        }
        catch (Exception error) { executionError = error; throw; }
        finally
        {
            coroutines.StopAll(); portalChoiceCoroutine = null;
            try { await touch.TouchUp(); }
            catch (Exception releaseError)
            {
                if (executionError is not null) throw new AggregateException(executionError, releaseError);
                throw;
            }
        }
    }

    async Task<bool> CloseReturnTownDialogsAsync(CancellationToken token)
    {
        var deadline = Stopwatch.StartNew();
        var clickedPopup = false;
        var consecutiveClearChecks = 0;
        while (deadline.Elapsed < TimeSpan.FromSeconds(10))
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureMovementPopupFrameAsync(token);
            // The loot title occupies the small banner above the reward grid.
            // Full-frame OCR is slow and can miss the title among item labels.
            var lootTitleArea = new Rectangle(
                (int)(frame.Width * .405), (int)(frame.Height * .138),
                (int)(frame.Width * .190), (int)(frame.Height * .128));
            using var lootTitle = frame.Clone(lootTitleArea, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
            var lootWords = await adb.ReadOcrWordsAsync(lootTitle, token);
            var lootText = string.Concat(lootWords.Select(word => OcrTextLocator.Compact(word.Text)));
            var loot = lootText.Contains("战利品", StringComparison.Ordinal);
            if (!loot)
            {
                using var enlargedTitle = new Bitmap(lootTitle.Width * 2, lootTitle.Height * 2);
                using (var graphics = Graphics.FromImage(enlargedTitle))
                {
                    graphics.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                    graphics.DrawImage(lootTitle, 0, 0, enlargedTitle.Width, enlargedTitle.Height);
                }
                var enlargedWords = await adb.ReadOcrWordsAsync(enlargedTitle, token);
                lootText = string.Concat(enlargedWords.Select(word => OcrTextLocator.Compact(word.Text)));
                loot = lootText.Contains("战利品", StringComparison.Ordinal);
            }
            var advancement = false;
            if (!loot)
            {
                var advancementTextArea = new Rectangle(
                    (int)(frame.Width * .34), (int)(frame.Height * .35),
                    (int)(frame.Width * .32), (int)(frame.Height * .17));
                using var advancementText = frame.Clone(advancementTextArea,
                    System.Drawing.Imaging.PixelFormat.Format24bppRgb);
                var advancementWords = await adb.ReadOcrWordsAsync(advancementText, token);
                var text = string.Concat(advancementWords.Select(word => OcrTextLocator.Compact(word.Text)));
                advancement = PopupRecognition.IsCharacterAdvancementDialogText(text);
            }
            if (advancement)
            {
                consecutiveClearChecks = 0;
                var close = PopupRecognition.FindCharacterAdvancementCloseButton(frame,
                    Path.Combine(AppContext.BaseDirectory, "templates", "ui", "character-advancement-close.png"));
                if (close is null)
                {
                    await Task.Delay(150, token);
                    continue;
                }
                await adb.TapScreen((double)close.Center.X / frame.Width, (double)close.Center.Y / frame.Height);
                clickedPopup = true;
                Log($"返回主城后识别到角色进阶提示，已点击 × 关闭：({close.Center.X},{close.Center.Y})，匹配分数 {close.Score:F3}");
                await Task.Delay(250, token);
                continue;
            }
            if (loot)
            {
                consecutiveClearChecks = 0;
                await adb.TapScreen(.5, .9);
                clickedPopup = true;
                Log("返回主城后识别到战利品标题并点击确定，下一轮继续核对是否关闭");
                await Task.Delay(250, token);
            }
            else
            {
                if (clickedPopup)
                {
                    consecutiveClearChecks++;
                    if (consecutiveClearChecks >= 2)
                    {
                        Log("返回主城后连续两轮未识别到战利品或进阶弹窗，确认弹窗已关闭");
                        return true;
                    }
                    Log("返回主城后暂未识别到弹窗，等待下一轮二次确认");
                }
                else if (deadline.Elapsed >= TimeSpan.FromSeconds(3))
                {
                    Log("返回主城后 3 秒内未检测到待处理弹窗，跑图收尾完成");
                    return true;
                }
                await Task.Delay(150, token);
            }
        }
        Warn("回城弹窗在 10 秒内未能关闭；跑图任务不标记完成");
        return false;
    }
}
