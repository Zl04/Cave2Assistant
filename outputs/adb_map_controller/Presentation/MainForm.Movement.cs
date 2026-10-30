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
    Task StartRun() => RunMovement(() => StartRunCore(operations.CurrentToken), startupProbePaused: true);

    Task StartAbyssRun() => RunMovement(() => StartAbyssRunCore(operations.CurrentToken, false),
        startupProbePaused: true, popupProfile: PopupRecognitionProfile.Abyss);

    async Task StartAbyssRunCore(CancellationToken token, bool teamMode)
    {
        adb.Serial = devices.Text;
        var currentMap = await adb.ReadMap();
        token.ThrowIfCancellationRequested();
        if (AbyssRoutePlanner.IsAbyss(currentMap))
        {
            Log("深渊：当前已在深渊地图，直接开始跑图");
            await StartRunCore(token);
            return;
        }
        var catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("abyss-entry-pipeline.json"));
        var entryHandler = new DelegateMaaPipelineHandler<MainForm>("AbyssEntry",
            async (task, _, ct) =>
            {
                if (task.Name == "ChooseSolo") return teamMode ? MaaPipelineRecognitionResult.Miss("选择组队") : MaaPipelineRecognitionResult.Hit();
                if (task.Name == "ChooseTeam") return teamMode ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("选择单人");
                if (task.Name == "OpenMap")
                {
                    var map = await adb.ReadMap();
                    if (!MapRunTask.IsReturnDestination(map))
                        throw new InvalidOperationException("当前不在城镇");
                    return MaaPipelineRecognitionResult.Hit();
                }
                using var frame = await adb.CaptureScreenForAutomationAsync(ct);
                return BastanMapOpening.IsOpen(frame)
                    ? MaaPipelineRecognitionResult.Hit()
                    : MaaPipelineRecognitionResult.Miss("巴萨坦地图未打开");
            },
            async (task, _, _, ct) =>
            {
                if (task.Name == "OpenMap")
                    await BastanMapOpening.EnsureOpenAsync(adb, Log, ct);
                return MaaPipelineActionResult.Success();
            });
        static string EntryStepName(string name) => name switch
        {
            "OpenMap" => "确认角色在城镇并打开地图",
            "MapReady" => "确认巴萨坦地图已打开",
            "OpenMenu" => "打开地图菜单",
            "MenuReady" => "识别深渊秘境入口",
            "OpenAbyss" => "打开深渊模式界面",
            "AbyssReady" => "识别深渊模式标题",
            "ChooseSolo" or "ChooseTeam" => "读取任务选择的冒险模式",
            "SoloSelected" or "TeamSelected" => "检查目标模式是否已亮起",
            "ClickSolo" or "ClickTeam" => "匹配未亮起图标并切换模式",
            "VerifySolo" or "VerifyTeam" => "确认切换后的模式已亮起",
            "StartSolo" or "StartTeam" => "匹配并点击开始冒险",
            "TeamStartNow" => "匹配并点击组队弹窗的立即开始",
            _ => name
        };
        var trace = new MaaPipelineTraceCollector();
        string? currentCheck = null;
        string? lastMiss = null;
        var progress = new DelegateMaaPipelineTraceSink(value =>
        {
            if (value.Kind == MaaPipelineTraceKind.CandidateRecognizing)
            {
                var check = string.Join("／", (value.Candidates ?? [value.TaskName ?? "未知节点"]).Select(EntryStepName).Distinct());
                if (check != currentCheck)
                {
                    currentCheck = check;
                    lastMiss = null;
                    Log($"深渊进图：正在{check}");
                    State($"深渊进图：正在{check}");
                }
            }
            else if (value.Kind == MaaPipelineTraceKind.CandidateRecognized && value.Matched == false)
                lastMiss = $"{EntryStepName(value.TaskName ?? "未知节点")}未命中{(string.IsNullOrWhiteSpace(value.Detail) ? "" : $"（{value.Detail}）")}";
            else if (value.Kind == MaaPipelineTraceKind.NodeCompleted)
                Log($"深渊进图：已完成{EntryStepName(value.TaskName ?? "未知节点")}");
        });
        var pipeline = new MaaPipeline<MainForm>(catalog,
            [entryHandler, new MaaAdbPipelineHandler<MainForm>("MaaAdb", _ => new MaaAdbPipelineState(adb, log: Log, saveEvidence: false))],
            new MaaPipelineExecutionOptions { TaskChain = "深渊进图", RetryTimes = 0 },
            new MaaPipelineTraceMultiplexer([pipelineWebServer, trace, progress]));
        State("深渊进图：正在检查入口");
        var result = await pipeline.RunAsync(this, ["OpenMap"], token);
        trace.SaveJson(runtime.Paths.Trace($"abyss-entry-{result.RunId}.json"));
        token.ThrowIfCancellationRequested();
        if (!result.Succeeded)
            throw new InvalidOperationException($"深渊进图失败：正在{currentCheck ?? "检查入口"}；{lastMiss ?? result.Error ?? "原因未明"}");
        Log("深渊：已点击开始冒险");
        await StartRunCore(token);
    }

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
        var owner = operations.CurrentToken;
        try
        {
            var startup = Stopwatch.StartNew();
            State($"正在读取地图并规划至 {target}");
            RoutePlan? initialPlan = null;
            var ready = await RefreshMap(true, waitForLock: true, onMapReady: () =>
            {
                var planning = Stopwatch.StartNew();
                initialPlan = PlanClickedMapTarget(dungeon.Map!, target);
                route = initialPlan.Route; plannedInteractions = initialPlan.Interactions;
                plannedTargetUniverse = initialPlan.TargetUniverse;
                mapPanel.Route = route; mapPanel.Invalidate();
                Log($"点击导航规划就绪 {startup.ElapsedMilliseconds} ms，其中路径规划 {planning.ElapsedMilliseconds} ms");
                State("路线已规划，等待弹窗检查完成");
            });
            owner.ThrowIfCancellationRequested();
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
                owner.ThrowIfCancellationRequested();
                if (serverErrorDialogVisible) return;
                if (runeSelectionVisible)
                {
                    initialPlan = null;
                    await HandleRiftGemSelection(owner);
                    continue;
                }
                if (dungeon.Map is null) { State("地图未就绪"); return; }
                if (dungeon.Map.InBattle)
                {
                    initialPlan = null;
                    await touch.EmergencyRelease();
                    State("战斗中，已停止移动");
                    await Task.Delay(120, owner);
                    continue;
                }

                if (dungeon.PendingRoomPortal is { } pendingPortal && dungeon.RoomPortalOrigin is { } portalOrigin)
                {
                    var current = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
                    if (dungeon.RoomPortalInteractionAt == 0 && current == pendingPortal.Cell)
                    {
                        dungeon.RoomPortalInteractionAt = Environment.TickCount64;
                        dungeon.AttemptedRoomPortals.Add(pendingPortal.Cell);
                    }
                    if (dungeon.RoomPortalInteractionAt != 0 &&
                        Environment.TickCount64 - dungeon.RoomPortalInteractionAt < 5000 &&
                        (current == portalOrigin || current == pendingPortal.Cell))
                    {
                        State($"等待层内传送门跳转 {pendingPortal.Cell}");
                        await Task.Delay(80, owner);
                        continue;
                    }
                    if (dungeon.RoomPortalInteractionAt != 0 &&
                        Environment.TickCount64 - dungeon.RoomPortalInteractionAt >= 5000)
                    {
                        dungeon.PendingRoomPortal = null;
                        dungeon.RoomPortalOrigin = null;
                        dungeon.RoomPortalInteractionAt = 0;
                    }
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

                var plan = initialPlan ?? PlanClickedMapTarget(dungeon.Map, target);
                initialPlan = null;
                route = plan.Route;
                plannedInteractions = plan.Interactions;
                plannedTargetUniverse = plan.TargetUniverse;
                mapPanel.Route = route;
                mapPanel.Invalidate();
                if (!string.IsNullOrWhiteSpace(plan.FailureReason))
                {
                    State(plan.FailureReason);
                    Warn($"地图点击导航失败：{target}，{plan.FailureReason}");
                    return;
                }

                var task = plannedInteractions.FirstOrDefault(interaction => interaction.Stop == player && HasTarget(interaction.Target));
                if (task != default)
                {
                    if (requestVersion != Volatile.Read(ref clickNavigationVersion)) return;
                    if (!await ConfirmInteractionStop(player, owner))
                    {
                        await RefreshMap(false, waitForLock: true);
                        continue;
                    }
                    var delta = new Cell(task.Target.Cell.X - player.X, task.Target.Cell.Y - player.Y);
                    State($"点击导航交互 {task.Target.Kind}，方向 {delta.X},{delta.Y}");
                    var roomPortal = IsRoomPortalTarget(task.Target);
                    var popupInterrupted = IsCombatInteraction(task.Target.Kind)
                        ? await FightWhileHolding(task, owner)
                        : await SendInteraction((delta, task.Target.Kind), owner);
                    if (popupInterrupted)
                    {
                        await HandleMovementPopupInterrupt(owner);
                        continue;
                    }
                    if (roomPortal)
                    {
                        dungeon.AttemptedRoomPortals.Add(task.Target.Cell);
                        dungeon.PendingRoomPortal = task.Target;
                        dungeon.RoomPortalOrigin = player;
                        dungeon.RoomPortalInteractionAt = Environment.TickCount64;
                        Log($"点击导航经过层内传送门 {task.Target.Cell}，等待刷新落点");
                    }
                    if (task.Target.Cell == target && !IsCombatInteraction(task.Target.Kind))
                    {
                        State($"已交互点击目标 {target}");
                        Log($"地图点击导航完成：已交互 {task.Target.Kind} {target}");
                        return;
                    }
                    await Task.Delay(80, owner);
                    continue;
                }

                if (route.Count < 2)
                {
                    State(player == target ? $"已到达点击目标 {target}" : "点击目标不可达");
                    return;
                }
                State($"自动导航至 {target}，剩余 {route.Count - 1} 步");
                ArmRoomPortalTransition();
                var routeResult = await ExecuteRouteSlice(owner);
                if (dungeon.PendingRoomPortal is { } enteringPortal && dungeon.RoomPortalInteractionAt == 0 &&
                    dungeon.Map is { } movedMap)
                {
                    var now = new Cell(movedMap.Player.X, movedMap.Player.Y);
                    if (now == enteringPortal.Cell ||
                        Math.Abs(now.X - enteringPortal.Cell.X) + Math.Abs(now.Y - enteringPortal.Cell.Y) > 2 &&
                        routeResult.Status == RouteExecutionStatus.Completed)
                    {
                        dungeon.RoomPortalInteractionAt = Environment.TickCount64;
                        dungeon.AttemptedRoomPortals.Add(enteringPortal.Cell);
                    }
                }
                if (routeResult.InterruptedByPopup)
                {
                    await HandleMovementPopupInterrupt(owner);
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
                await Task.Delay(20, owner);
            }
        }
        catch (OperationCanceledException) { }
        finally
        {
            coroutines.StopAll(); portalChoiceCoroutine = null;
            try { await touch.TouchUp(); } catch (Exception ex) { Error(ex); }
        }
    }

    RoutePlan PlanClickedMapTarget(MapDump map, Cell target)
    {
        var direct = Planner.PlanToTarget(map, target, Options().Monsters, dungeon.Blocked);
        if (direct.FailureReason != "点击目标不可达" || !AbyssRoutePlanner.IsAbyss(map)) return direct;

        // 房间门由服务器传送，不能把地图上的两段道路拼成一条连续步行路线。
        // 每次只走到一扇门；落地后从最新地图重新规划至原点击坐标。
        var desired = new[] { new TargetKey(target, "金币") }; // 拾取类停靠点就是目标格本身。
        var viaKnownDoor = AbyssRoutePlanner.PlanToRoomPortal(map, dungeon.Blocked,
            !Options().Monsters, dungeon.AttemptedRoomPortals, dungeon.PortalJumps,
            desired, requireTargetProgress: true);
        if (viaKnownDoor.Interactions.Count > 0) return viaKnownDoor;

        // 未观察到的门没有权威落点；尝试尚未走过的入口，避免在两间房之间循环。
        var viaUnknownDoor = AbyssRoutePlanner.PlanToRoomPortal(map, dungeon.Blocked,
            !Options().Monsters, dungeon.AttemptedRoomPortals, dungeon.PortalJumps, desired);
        return viaUnknownDoor.Interactions.Count > 0 ? viaUnknownDoor : direct;
    }

    bool PopupProbeEnabled()
        => !startupPreparing && !popupHandling && !serverErrorDialogVisible;

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

    Task<RouteExecutionResult> ExecuteRouteSlice(CancellationToken ownerToken)
        => movementExecution.ExecuteRouteAsync(routeExecutor, CreateRouteExecutionContext(), ownerToken);

    Task<bool> RunMovementSlice(CancellationToken ownerToken, Func<CancellationToken, Task> action)
        => movementExecution.ExecuteInteractionAsync(action, ownerToken);

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
                BeginConnectionRecovery();
                State("服务器连接异常，正在恢复连接");
                return;
            }

            if (kind == MovementPopupKind.RiftGemSelection)
            {
                // 看门狗已经通过共享管线完成标题识别；这里仅锁存状态，
                // 由主循环执行点击并确认覆盖层关闭。
                LatchRiftGemSelection();
            }
            else if (kind == MovementPopupKind.ReturnTownConfirm)
            {
                await adb.TapScreen(.591, .639);
                floorPhase = FloorPhase.WaitingReturnTown;
                Log("已确认返回城镇，等待主城地图加载");
            }
            else if (kind == MovementPopupKind.AltarDialog)
            {
                await HandleAltarDialog(ownerToken);
            }
            else if (kind == MovementPopupKind.EnchantingDialog)
            {
                // 临时兼容：跑图误触附魔台后点击空白处关闭。
                // 实现附魔台交互时移除此分支，并同步调整 PopupUiPipeline、popup-watchdog.json 中的识别节点。
                await adb.TapScreen(.44, .18);
                Log("检测到附魔台界面，已点击空白区域关闭");
                await Task.Delay(180, ownerToken);
            }
            else if (kind == MovementPopupKind.AbyssMerchantDialog)
            {
                await adb.TapScreen(.52, .18);
                Log("检测到深渊商人界面，已点击中间空白区域关闭");
                await Task.Delay(180, ownerToken);
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

    async Task<bool> HandleIndependentPopup(PopupUiPipelineResult probe, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        switch (probe.Value)
        {
            case MovementPopupKind.ReturnTownConfirm:
                await adb.TapScreenSecondary(.591, .639);
                floorPhase = FloorPhase.WaitingReturnTown;
                Log("独立弹窗监控：已确认返回城镇，等待主城地图加载");
                State("已确认返回城镇，等待主城地图加载");
                return true;
            case MovementPopupKind.NextFloorDialog:
            {
                var kind = probe.NextFloorDialog;
                if (kind == NextFloorDialogKind.None) return false;
                if (kind is NextFloorDialogKind.WarningConfirm or NextFloorDialogKind.PlainConfirm)
                {
                    if (dungeon.Map is { } stopMap && ShouldCancelNextFloorDialog(stopMap))
                    {
                        await adb.TapScreenSecondary(0.409, 0.639);
                        cancelledNextFloorLevel = stopMap.Level;
                        floorPhase = FloorPhase.Explore;
                        Log($"独立弹窗监控：第 {stopMap.Level} 层已点击‘再考虑一下’取消下楼");
                        return true;
                    }
                    await adb.TapScreenSecondary(0.591, 0.639);
                    Log($"独立弹窗监控：已点击下楼确认（{kind}），移动路线未修改");
                    return true;
                }
                var returnAtTargetFloor = dungeon.Map is not null && ShouldReturnFromGreedySelection(dungeon.Map);
                if (returnAtTargetFloor && probe.GreedySelectionReturnCards.Count == 0)
                    Log("指定层未识别到回城卡，随机选择一张卡继续");
                var selection = returnAtTargetFloor && probe.GreedySelectionReturnCards.Count == 1
                    ? (Index: probe.GreedySelectionReturnCards[0], Reward: "回城")
                    : await FindPreferredGreedyCardAsync(probe.GreedySelectionReturnCards,
                        probe.GreedySelectionContinueCards, returnAtTargetFloor, token);
                var cardIndex = selection.Index;
                var preferred = selection.Reward;
                await adb.TapScreenSecondary(cardIndex switch { 1 => 0.50, 2 => 0.6875, _ => 0.3125 }, 0.657);
                Log($"独立弹窗监控：已点击第 {cardIndex + 1} 张贪婪卡（{preferred}），移动路线未修改");
                if (probe.GreedySelectionReturnOnly ||
                    probe.GreedySelectionReturnCards.Contains(cardIndex))
                    floorPhase = FloorPhase.WaitingReturnTown;
                return true;
            }
            case MovementPopupKind.RiftGemSelection:
                if (runeSelectionCard < 0) runeSelectionCard = Random.Shared.Next(3);
                await adb.TapScreenSecondary(new[] { .268, .466, .661 }[runeSelectionCard], .648);
                Log($"独立弹窗监控：已点击第 {runeSelectionCard + 1} 张秘境宝石卡，移动路线未修改");
                return true;
            case MovementPopupKind.AltarDialog:
                await HandleAltarDialog(token);
                return true;
            case MovementPopupKind.EnchantingDialog:
                await adb.TapScreenSecondary(.44, .18);
                Log("独立弹窗监控：已关闭附魔台界面，移动路线未修改");
                return true;
            case MovementPopupKind.AbyssMerchantDialog:
                await adb.TapScreenSecondary(.52, .18);
                Log("独立弹窗监控：已关闭深渊商人界面，移动路线未修改");
                return true;
            case MovementPopupKind.ServerError:
                BeginConnectionRecovery();
                return true;
            default:
                return false;
        }
    }

    async Task RunMovement(Func<Task> action, bool startupProbePaused = false,
        PopupRecognitionProfile popupProfile = PopupRecognitionProfile.Normal)
    {
        if (closing || stopping || scanning || activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false }) return;
        await operations.RunAsync(ControllerOperationKind.Movement, owner =>
            RunMovementScope(owner, _ => action(), startupProbePaused, popupProfile));
        UpdateDeviceAvailability();
    }

    async Task RunMovementScope(CancellationToken owner, Func<CancellationToken, Task> action,
        bool startupProbePaused = false, PopupRecognitionProfile popupProfile = PopupRecognitionProfile.Normal)
    {
        activePopupProfile = popupProfile;
        mapRunActiveDuringRecovery = true;
        if (startupProbePaused) startupPreparing = true;
        devices.Enabled = false;
        dungeon.MotionInterrupt.Clear();
        using var watchdogCts = CancellationTokenSource.CreateLinkedTokenSource(owner);
        var watchdog = new PopupWatchdog(adb, PopupProbeEnabled, HandleIndependentPopup,
            ex => Warn($"移动弹窗监控暂时失败：{ex.Message}"),
            message => Log(message),
            PopupProbeDisabledReason,
            () => CurrentPopupProfile);
        var watchdogTask = watchdog.RunAsync(watchdogCts.Token);
        try { await action(owner); }
        finally
        {
            watchdogCts.Cancel();
            try { await watchdogTask; } catch (OperationCanceledException) { }
            mapRunActiveDuringRecovery = false;
            activePopupProfile = PopupRecognitionProfile.Normal;
            dungeon.MotionInterrupt.Clear();
            if (startupProbePaused) startupPreparing = false;
            UpdateDeviceAvailability();
        }
    }

    async Task StopMovement()
    {
        stopping = true;
        try
        {
            connectionRecoveryCancellation?.Cancel();
            operations.Cancel(ControllerOperationKind.Movement);
            operations.Cancel(ControllerOperationKind.Entry);
            if (connectionRecoveryTask is { } recovery)
                try { await recovery; } catch (OperationCanceledException) { }
            try { await touch.EmergencyRelease(); } catch (Exception ex) { Error(ex); }
            // The Application operation includes watchdog and final cleanup.
            try { await operations.StopAsync(closeAdmission: closing); } catch (OperationCanceledException) { }
            // Release again after draining to cover input already in flight.
            await touch.EmergencyRelease();
        }
        finally
        {
            serverErrorDialogVisible = false;
            dungeon.MotionInterrupt.Clear();
            // StopMovement 是一次新的运行/导航请求的边界。若上一次宝石弹窗
            // 在点击后被急停，PopupWatchdog 已停止探测，而锁存状态会一直
            // 遗留到下一次启动，导致普通战斗画面仍显示“宝石选择”。
            ClearRiftGemSelectionState();
            stopping = false;
        }
    }
}
