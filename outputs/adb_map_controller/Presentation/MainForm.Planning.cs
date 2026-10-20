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
    static bool IsCombatInteraction(string kind) => kind is "小怪" or "群怪" or "精英" or "小Boss" or "Boss";
    Cell InputDelta(Cell desired)
    {
        if (dungeon.Map is null) return desired;
        var position = DirectionMapper.ButtonPosition(
            desired,
            dungeon.Map.Confused,
            dungeon.Map.Reversed,
            dungeon.Map.ConfuseDirections);
        return position == 0 ? desired : TouchCoordinateMapper.ButtonPositionToDelta(position);
    }
    async Task<bool> SendInteraction((Cell Delta, string Kind) interaction, CancellationToken ownerToken)
    {
        // 传送门等可通行交互点的路线会以目标格本身作为停靠点。
        // 到达后目标与人物重合，游戏应自动触发或由弹窗流程接管，
        // 不能再把 (0,0) 当作方向输入交给 TouchCoordinateMapper。
        if (interaction.Delta == default)
        {
            Log($"{interaction.Kind} 已到达目标格，无需额外方向交互");
            return false;
        }
        var duration = (int)interactionHold.Value;
        var interrupted = await RunMovementSlice(ownerToken,
            token => touch.HoldInteraction(InputDelta(interaction.Delta), duration, token));
        if (interrupted) return true;
        Log($"{interaction.Kind} 交互按住 {duration}ms（独立于人物速度）");
        return false;
    }

    async Task<bool> FightWhileHolding(PlannedInteraction task, CancellationToken ownerToken)
    {
        return await RunMovementSlice(ownerToken, token => FightWhileHoldingCore(task, token));
    }

    async Task FightWhileHoldingCore(PlannedInteraction task, CancellationToken token)
    {
        if (dungeon.Map is null) return;
        var start = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
        var delta = new Cell(task.Target.Cell.X - start.X, task.Target.Cell.Y - start.Y);
        var inputDelta = InputDelta(delta);
        if (Math.Abs(delta.X) + Math.Abs(delta.Y) != 1)
        {
            Warn($"战斗停靠点失效：人物 {start}，目标 {task.Target.Cell}，等待重新规划");
            return;
        }

        State($"持续按住战斗 {task.Target.Kind}，方向 {delta.X},{delta.Y}");
        Log($"开始持续按住战斗：{start} -> {task.Target.Cell}");
        await touch.TouchDown(inputDelta, token);
        try
        {
            var startedAt = Environment.TickCount64;
            var nextMapReadAt = 0L;
            var targetGone = false;
            long targetGoneAt = 0;
            while (Environment.TickCount64 - startedAt < 30_000)
            {
                token.ThrowIfCancellationRequested();
                await Task.Delay(5, token);
                var player = await adb.ReadPlayer();
                if (player.MoveSpeed > 0) dungeon.RouteExecution.MoveSpeed = player.MoveSpeed;
                var position = new Cell(player.Player.X, player.Player.Y);
                dungeon.Map.Player = player.Player;
                mapPanel.Invalidate();

                // 被占据的怪物格变得可通行后，仍按住的方向会自然提交移动。
                // 在坐标首次变化时释放，避免继续移动到下一个地图格。
                if (position != start)
                {
                    Log($"战斗后人物开始进格：{start} -> {position}，立即松开");
                    return;
                }

                var now = Environment.TickCount64;
                if (now < nextMapReadAt) continue;
                nextMapReadAt = now + 100;
                var map = await adb.ReadMap();
                RouteExecutor.ApplyPlayerStatus(map, player);
                dungeon.Map = map; mapPanel.Map = map; mapPanel.Route = route; mapPanel.Invalidate();
                // 与怪物接触后，游戏可能在玩家坐标变化前切换到战斗场景。
                // 立即释放方向；战斗过程中绝不能继续移动角色。
                if (map.InBattle)
                {
                    State("战斗中，已停止移动");
                    Log("已进入战斗，停止发送方向操作");
                    return;
                }
                targetGone = !map.ByCell.TryGetValue(task.Target.Cell, out var tile)
                    || !tile.Roles.Any(role => role.Kind == task.Target.Kind);
                if (targetGone)
                {
                    if (targetGoneAt == 0)
                    {
                        targetGoneAt = Environment.TickCount64;
                        State($"{task.Target.Kind} 已消失，保持方向直到人物进格");
                    }
                    // 怪物被击败后，其所在格通常会变得可通行，按住的方向也会立即推进玩家。
                    // 如果在配置的卡顿窗口内没有观察到坐标变化，继续按住可能会让 UI
                    // 卡在旧的 30 秒战斗超时中。此时释放方向，让常规循环刷新并重新协调路线。
                    if (Environment.TickCount64 - targetGoneAt >= Math.Max(300L, (long)stallTimeout.Value))
                    {
                        Warn($"{task.Target.Kind} 已消失但人物未进格，超过卡住超时，停止当前方向并重新校准");
                        return;
                    }
                }
                else targetGoneAt = 0;
            }
            Log(targetGone
                ? $"{task.Target.Kind} 已消失但人物尚未进格，本轮释放后继续确认"
                : $"{task.Target.Kind} 战斗持续 30 秒，分段释放并继续确认");
        }
        finally { await touch.TouchUp(); }
    }
    PlanOptions Options()
    {
        if (dungeon.Map?.MapName != "神秘商人") ignoredDirectBossTargets.Clear();
        var includeAll = dungeon.Map is not null && FloorPlanningPolicy.IncludeAllInteractions(dungeon.Map);
        return new PlanOptions
        {
            // 6101 是纯战斗房间。该楼型不依赖用户的“全清小怪/清除精英”勾选，
            // 进入后统一交给怪物追猎规划器；普通楼层仍完全遵循 UI 选项。
            AttackBoss = (dungeon.Map is not null && IsEscapeReturnFloor(dungeon.Map)
                    ? escapeReturnAttackBoss.Checked : includeAll || attackBoss.Checked) ||
                (dungeon.Map is not null && FloorPlanningPolicy.IsMonsterHuntRoom(dungeon.Map)),
            DirectBossNpc = directBossNpc.Checked,
            IgnoredTargets = ignoredDirectBossTargets,
            Monsters = includeAll || monsters.Checked ||
                (dungeon.Map is not null && FloorPlanningPolicy.IsMonsterHuntRoom(dungeon.Map)),
            Elites = includeAll || elites.Checked || (dungeon.Map is not null && FloorPlanningPolicy.IsMonsterHuntRoom(dungeon.Map)),
            Chests = includeAll || chests.Checked,
            Pots = includeAll || pots.Checked,
            Bones = includeAll || bones.Checked,
            Gold = includeAll || gold.Checked,
            Runes = includeAll || runes.Checked,
            Altars = includeAll || altars.Checked,
            Chambers = includeAll || chambers.Checked
        };
    }
    static bool IsSelected(RoleInfo role, PlanOptions o) => TargetPolicy.IsSelected(role, o);
    Dictionary<Cell, bool> WalkabilitySnapshot(MapDump map) => map.Tiles.SelectMany(row => row)
        .ToDictionary(tile => new Cell(tile.X, tile.Y), tile => tile.Walkable && !dungeon.Blocked.Contains(new Cell(tile.X, tile.Y)));
    static int OptionsSignature(PlanOptions o) => HashCode.Combine(
        HashCode.Combine(o.AttackBoss, o.Monsters, o.Elites, o.Chests, o.Pots, o.Bones, o.Gold),
        HashCode.Combine(o.Runes, o.Altars, o.Chambers, o.DirectBossNpc, o.VisionRadius));
    HashSet<TargetKey> SelectedTargets(MapDump map, PlanOptions options, bool includeLockedBoss = false) => map.Tiles.SelectMany(row => row)
        .SelectMany(tile => tile.Roles.Where(role => TargetPolicy.IsSelected(role, options) && !(role.RoleType == 5 && role.Opened) &&
            (role.Kind != "机关" || (!tile.Reached && !visitedMechanisms.Contains(new Cell(tile.X, tile.Y)))) &&
            (includeLockedBoss || role.Kind is not ("Boss" or "小Boss") || Planner.IsBossAttackable(map, role)))
            .Select(role => new TargetKey(new Cell(tile.X, tile.Y), role.Kind)))
        .Where(target => !(options.IgnoredTargets?.Contains(target) ?? false)).ToHashSet();

    HashSet<TargetKey> ActiveTargets(MapDump map, PlanOptions options) => SelectedTargets(map, options);

    HashSet<TargetKey> ReachableActiveTargets(MapDump map, PlanOptions options)
        => Planner.ReachableTargets(map, ActiveTargets(map, options), dungeon.Blocked);

    bool IsTargetStopFloor(MapDump map)
    {
        // 卷轴回城优先；卷轴尚未取得时也必须允许继续跑图。
        if (IsEscapeReturnFloor(map)) return false;
        var manualTargetReached = targetStopFloor.Value > 0 && map.Level == (int)targetStopFloor.Value;
        // 卡矿在未启用挖矿时退化为卡层：到达自动匹配的最高层后，
        // 即使“卡层”本身未勾选，也不能继续进入下一层。
        var cardTarget = (cardLayer.Checked || (cardMining.Checked && !mining.Checked))
            ? CardFloorPolicy.Resolve(map) : null;
        // 两种设置彼此独立：只开一个时使用对应条件；同时开启时，
        // 任一目标层都复用同一套“完成所选目标后停住”流程。
        var cardTargetReached = cardTarget is { } target && map.Level == target;
        return manualTargetReached || cardTargetReached;
    }

    bool IsEscapeReturnFloor(MapDump map)
    {
        var target = (int)escapeReturnFloor.Value;
        var maximum = CardFloorPolicy.MaximumFloor(map);
        return target > 0 && maximum is { } last && target < last &&
            map.Level >= target && map.Level < last;
    }

    bool ShouldCancelNextFloorDialog(MapDump map)
        => IsEscapeReturnFloor(map) || IsTargetStopFloor(map);

    bool ShouldReturnFromGreedySelection(MapDump map)
        => !cardMiningTaskRunning && IsTargetStopFloor(map);

    bool TargetFloorStopReady(MapDump map)
    {
        if (!IsTargetStopFloor(map)) return false;
        if (map.InBattle) return false;
        // 挖矿优先于卡层：到达停层位置时，先把本层应执行的挖矿做完。
        if (ShouldMineBeforeFloorTransition(map)) return false;
        // 指定层复用普通“目标”选项；未勾选的可选目标不阻止停住，
        // 钥匙仍由 TargetPolicy 强制视为目标。锁定中的 Boss 也必须保留，
        // 防止封印尚未打开时误判为目标已完成。
        return SelectedTargets(map, Options(), includeLockedBoss: true).Count == 0;
    }

    bool IsCardMiningFloor(MapDump map)
        => cardMining.Checked && CardFloorPolicy.Resolve(map) is { } target && map.Level == target;

    bool ShouldMineBeforeFloorTransition(MapDump map)
    {
        if (!mining.Checked || dungeon.FloorMiningCompletedLevel == map.Level || dungeon.FloorMiningSkippedLevel == map.Level) return false;
        // 卡矿优先级高于普通挖矿：只有自动匹配的最高层允许使用道具。
        return !cardMining.Checked || IsCardMiningFloor(map);
    }

    async Task<bool> TryStopAtTargetFloor()
    {
        if (dungeon.TargetFloorStopped || dungeon.Map is null || !TargetFloorStopReady(dungeon.Map)) return false;

        var level = dungeon.Map.Level;
        await touch.EmergencyRelease();
        dungeon.TargetFloorStopped = true;
        dungeon.Route.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();
        Log($"已到达指定层 {level}，所选目标已完成，停止运行");
        State($"指定层 {level} 已完成所选目标");
        return true;
    }
    bool HasTarget(TargetKey target) => dungeon.Map is not null && dungeon.Map.ByCell.TryGetValue(target.Cell, out var tile) &&
        tile.Roles.Any(role => role.Kind == target.Kind) && (target.Kind != "机关" || (!tile.Reached && !visitedMechanisms.Contains(target.Cell)));
    bool IsAtPlannedInteractionStop(Cell cell)
        => plannedInteractions.Any(task => task.Stop == cell &&
            (HasTarget(task.Target) || PortalRouting.IsPortalKind(task.Target.Kind)));
    void ArmRoomPortalTransition()
    {
        if (dungeon.Map is null || dungeon.PendingRoomPortal is not null || route.Count < 2) return;
        var current = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
        var task = plannedInteractions.FirstOrDefault(value => value.Target.Kind == "秘境传送门" &&
            value.Stop != current && route.Contains(value.Stop));
        if (task == default) return;
        dungeon.AttemptedRoomPortals.Add(task.Target.Cell);
        dungeon.PendingRoomPortal = task.Target;
        dungeon.RoomPortalOrigin = current;
        dungeon.RoomPortalInteractionAt = Environment.TickCount64;
        Log($"已挂起层内传送等待：{task.Target.Cell}，从 {current} 进入后再确认跳转");
    }
    bool IsRoomPortalTarget(TargetKey target)
        => dungeon.Map is not null && dungeon.Map.ByCell.TryGetValue(target.Cell, out var tile) &&
           tile.Roles.Any(role => role.Kind == target.Kind && PortalRouting.IsRoomToRoom(role));
    void ReconcileCompletedTasks()
    {
        if (dungeon.Map is null) return;
        var active = ActiveTargets(dungeon.Map, Options());
        var newlyCompleted = plannedTargetUniverse.Where(target => Planner.IsCompletedTarget(target, active) && dungeon.ConfirmedCompletedTargets.Add(target)).ToList();
        foreach (var target in newlyCompleted) dungeon.ExpectedTaskRoadChanges.Add(target.Cell);
        var removed = plannedInteractions.RemoveAll(task => dungeon.ConfirmedCompletedTargets.Contains(task.Target));
        if (newlyCompleted.Count > 0)
        {
            dungeon.RouteExecution.ClearPulseFallback();
            Log($"已确认完成 {newlyCompleted.Count} 个计划任务，移除 {removed} 个停靠动作并保留剩余完整路线；重置防横跳记录");
        }
    }

    bool PortalPrerequisitesMet(MapDump map)
    {
        // 已存在的封印具有权威性：在其分数达到唤醒阈值前，守护 Boss 必须继续作为战斗目标。
        var requireBoss = !IsEscapeReturnFloor(map) || escapeReturnAttackBoss.Checked;
        if (requireBoss && map.BossSeal.Present && !map.BossSeal.Ready) return false;
        if (requireBoss && map.Tiles.SelectMany(r => r).SelectMany(t => t.Roles)
            .Any(r => r.Kind is "Boss" or "小Boss")) return false;
        // 探索进度不是下楼的前置条件。满足战斗/目标前置条件后，
        // 即使仍有未发现的可通行格，也可以使用楼层入口。
        // 导出的地图中可能仍存在过期或被阻塞的角色；当不存在可到达的交互停靠点时，
        // 它不是真正的前置条件。
        if (ReachableActiveTargets(map, Options()).Count > 0) return false;
        return true;
    }

    bool UpdateFloorPhase()
    {
        if (dungeon.Map is null) return false;
        var map = dungeon.Map;
        if (dungeon.ObservedLevel < 0) dungeon.ObservedLevel = map.Level;
        if (map.Level != dungeon.ObservedLevel)
        {
            CancelPortalChoiceCoroutine();
            dungeon.ObservedLevel = map.Level; floorPhase = FloorPhase.WaitingFloorLoad; dungeon.FloorChangedAt = Environment.TickCount64;
            pendingFogRevealLevel = map.Level;
            dungeon.RouteExecution.ClearPulseFallback();
            dungeon.FloorMiningCompletedLevel = -1;
            dungeon.FloorMiningSkippedLevel = -1;
            dungeon.RouteRecoveryUsed = 0;
            dungeon.Blocked.Clear(); dungeon.LastBlockedAttempt = null; dungeon.UnchangedCount = 0;
            dungeon.LastAcceptedPlayerCell = null;
            dungeon.LastAcceptedPlayerAt = 0;
            dungeon.InteractedChambers.Clear();
            dungeon.ShortcutDeferredByTargets = false;
            dungeon.TargetFloorStopped = false;
            dungeon.PortalCandidate = null; dungeon.PortalConfirmCount = 0; dungeon.Route.Clear();
            dungeon.AttemptedRoomPortals.Clear(); dungeon.PendingRoomPortal = null; dungeon.RoomPortalOrigin = null; dungeon.RoomPortalInteractionAt = 0;
            dungeon.ConfirmedCompletedTargets.Clear(); dungeon.ExpectedTaskRoadChanges.Clear();
            Log($"检测到进入新层：{map.Level}，重置本层路线和目标");
            return true;
        }
        if (floorPhase == FloorPhase.WaitingFloorLoad)
        {
            if (Environment.TickCount64 - dungeon.FloorChangedAt < (long)newFloorStartDelay.Value) return true;
            floorPhase = FloorPhase.Explore;
            Log("新层遮罩等待完成，开始规划路线");
        }

        // 6101 没有普通洞窟的下楼/探索阶段。即使快照中偶尔残留传送门角色，
        // 也不能让通用楼层状态机把房间切换到 GoToPortal。
        if (FloorPlanningPolicy.IsMonsterHuntRoom(map))
        {
            dungeon.PortalCandidate = null;
            dungeon.PortalConfirmCount = 0;
            if (floorPhase != FloorPhase.Explore)
            {
                floorPhase = FloorPhase.Explore;
                Log("进入 6101 怪物房间，切换为直接找怪战斗规划");
            }
            return false;
        }

        // 换层弹窗出现后，地图快照仍可能保留弹窗下方的旧目标。
        // 这时不能再用楼层前置条件覆盖 SelectBonus/VerifyTransition，
        // 否则主循环永远到不了 SelectBonusRoutine，只会反复识别同一个弹窗。
        if (floorPhase is FloorPhase.SelectBonus or FloorPhase.VerifyTransition)
            return true;

        if (cancelledNextFloorLevel == map.Level)
        {
            floorPhase = FloorPhase.Explore;
            return false;
        }

        var portal = map.Tiles.SelectMany(r => r)
            .SelectMany(t => t.Roles.Where(PortalRouting.IsFloorTransition)
                .Select(r => new TargetKey(new Cell(t.X, t.Y), r.Kind)))
            .OrderBy(t => Math.Abs(t.Cell.X - map.Player.X) + Math.Abs(t.Cell.Y - map.Player.Y))
            .FirstOrDefault();
        if (portal == default)
        {
            dungeon.PortalCandidate = null; dungeon.PortalConfirmCount = 0;
            floorPhase = map.BossSeal.Present && !map.BossSeal.Ready ? FloorPhase.CollectWarning : FloorPhase.Explore;
            return false;
        }
        if (dungeon.PortalCandidate == portal) dungeon.PortalConfirmCount++; else { dungeon.PortalCandidate = portal; dungeon.PortalConfirmCount = 1; }
        if (!PortalPrerequisitesMet(map))
        {
            floorPhase = map.BossSeal.Present && !map.BossSeal.Ready ? FloorPhase.CollectWarning : FloorPhase.Explore;
            return false;
        }
        if (dungeon.PortalConfirmCount < 2) { floorPhase = FloorPhase.ConfirmPortal; return false; }
        if (floorPhase is not (FloorPhase.GoToPortal or FloorPhase.InteractPortal or FloorPhase.SelectBonus or FloorPhase.VerifyTransition))
        {
            floorPhase = FloorPhase.GoToPortal;
            var blockedBefore = dungeon.Blocked.Count;
            var plan = Planner.PlanToPortalRecoveringTemporaryBlocks(map, dungeon.Blocked, !Options().Monsters, dungeon.PortalUnlocks);
            if (blockedBefore > 0 && dungeon.Blocked.Count == 0)
                Log($"临时封锁导致出口不可达，已撤销 {blockedBefore} 个封锁并恢复路线");
            route = plan.Route; plannedInteractions = plan.Interactions; plannedTargetUniverse = plan.TargetUniverse;
            mapPanel.Route = route; mapPanel.Invalidate();
            Log(route.Count > 1 ? $"传送门已确认，锁定下楼路线 {route.Count - 1} 步" : "传送门已确认，但当前不可达");
        }
        return true;
    }

    bool HasPlanningWork(MapDump map)
    {
        var options = Options();
        return Planner.HasReachableUnexplored(map, dungeon.Blocked) ||
            ReachableActiveTargets(map, options).Count > 0 ||
            (map.BossSeal.Present && !map.BossSeal.Ready && !options.Monsters && map.BossSeal.WakeScore > map.BossSeal.CurScore);
    }

    static bool HasMapDownstairsEntrance(MapDump map)
        => map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles)
            .Any(PortalRouting.IsFloorTransition);

    bool TryPlanExplorationRoute()
    {
        if (dungeon.Map is null || floorPhase != FloorPhase.Explore ||
            FloorPlanningPolicy.IsMonsterHuntRoom(dungeon.Map)) return false;
        var map = dungeon.Map;
        var options = Options();
        var plan = Planner.PlanExploration(map, options.VisionRadius, dungeon.Blocked, !options.Monsters);
        if (plan.Route.Count < 2) return false;

        route = plan.Route;
        plannedInteractions = [];
        // 当这条路线只用于揭示地图时，保持目标集合为空。
        // 新出现且已勾选的目标必须在下一次刷新时触发正常的完整规划，
        // 而不能被探索流程隐藏。
        plannedTargetUniverse = [];
        plannedWalkability = WalkabilitySnapshot(map);
        plannedOptionsSignature = OptionsSignature(options);
        dungeon.Route.PlannedNavigationHash = dungeon.Route.Snapshot?.NavigationHash;
        dungeon.Route.PlannedRoadMonsters = [.. map.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
        dungeon.ExpectedTaskRoadChanges.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();
        Log($"无可达勾选目标且没有下楼入口，直接探索地图：{route.Count - 1} 步，寻找勾选目标");
        State("探索地图，寻找勾选目标");
        return true;
    }

    bool TryPlanRoomPortalRoute()
    {
        if (dungeon.Map is null || floorPhase != FloorPhase.Explore || HasMapDownstairsEntrance(dungeon.Map) ||
            dungeon.PendingRoomPortal is not null) return false;
        var plan = Planner.PlanToRoomPortal(dungeon.Map, dungeon.Blocked, !Options().Monsters, dungeon.AttemptedRoomPortals);
        if (plan.Interactions.Count == 0)
        {
            var unlockPlan = Planner.PlanToPortalUnlockMonster(dungeon.Map, dungeon.Blocked, dungeon.PortalUnlocks);
            if (unlockPlan.Route.Count < 2 && unlockPlan.Interactions.Count == 0) return false;
            route = unlockPlan.Route; plannedInteractions = unlockPlan.Interactions; plannedTargetUniverse = unlockPlan.TargetUniverse;
            dungeon.Route.PlannedRoadMonsters = [.. dungeon.Map.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
            mapPanel.Route = route; mapPanel.Invalidate();
            var unlockTarget = unlockPlan.Interactions.FirstOrDefault().Target;
            var unlockKind = string.IsNullOrWhiteSpace(unlockTarget.Kind) ? "小怪" : unlockTarget.Kind;
            Log($"层内传送门仍锁定，先规划击败 {unlockKind} {unlockTarget.Cell}");
            State("前往小怪解锁传送门");
            return true;
        }
        route = plan.Route; plannedInteractions = plan.Interactions; plannedTargetUniverse = plan.TargetUniverse;
        dungeon.Route.PlannedRoadMonsters = [.. dungeon.Map.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
        mapPanel.Route = route; mapPanel.Invalidate();
        Log($"层内传送寻路：前往 {plan.Interactions[0].Target.Cell}，路线 {Math.Max(0, route.Count - 1)} 步，等待记录跳转边");
        State("前往层内传送门");
        return true;
    }

    async Task<bool> TryExploreWithoutTarget(CancellationToken token)
    {
        // TryUseNextFloorShortcut 已在此回退逻辑前立即执行。
        // 只有 Explore 符合条件，因此活动中的传送门/转场阶段绝不会被随机移动替代。
        if (dungeon.Map is null || floorPhase != FloorPhase.Explore ||
            FloorPlanningPolicy.IsMonsterHuntRoom(dungeon.Map)) return false;
        var origin = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
        var candidates = new[] { new Cell(0, -1), new Cell(1, 0), new Cell(0, 1), new Cell(-1, 0) }
            .Select(delta => new Cell(origin.X + delta.X, origin.Y + delta.Y))
            .Where(cell => dungeon.Map.ByCell.TryGetValue(cell, out var tile) && tile.Walkable && !dungeon.Blocked.Contains(cell))
            .ToList();
        if (candidates.Count == 0) return false;

        if (!Options().Monsters)
        {
            var safeCandidates = candidates.Where(cell => !Planner.HasRoadMonster(dungeon.Map.ByCell[cell])).ToList();
            if (safeCandidates.Count > 0) candidates = safeCandidates;
        }
        var unexplored = candidates.Where(cell => !dungeon.Map.ByCell[cell].Explored).ToList();
        var pool = unexplored.Count > 0 ? unexplored : candidates;
        var next = pool.OrderBy(_ => random.Next()).First();
        var delta = new Cell(next.X - origin.X, next.Y - origin.Y);
        Log($"无可达勾选目标且没有下楼入口，执行单格探索：方向 {delta.X},{delta.Y}");
        State("探索地图，寻找勾选目标");
        if (await RunMovementSlice(token,
                sliceToken => touch.PulseOneCell(InputDelta(delta), (int)singleCellPulseHold.Value, sliceToken)))
        {
            await HandleMovementPopupInterrupt(token);
            return true;
        }
        await Task.Delay(80, token);
        await RefreshMap(false, waitForLock: true);
        if (dungeon.Map is not null) EnsureRoute(true);
        return true;
    }

    async Task<bool> TryPlanningRecovery(CancellationToken token)
    {
        if (dungeon.Map is null || !HasPlanningWork(dungeon.Map) || dungeon.RouteRecoveryUsed >= (int)routeRecoveryAttempts.Value) return false;
        var origin = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
        var candidates = new[] { new Cell(0, -1), new Cell(1, 0), new Cell(0, 1), new Cell(-1, 0) }
            .Where(d => dungeon.Map.ByCell.TryGetValue(new Cell(origin.X + d.X, origin.Y + d.Y), out var t) && t.Walkable && !dungeon.Blocked.Contains(new Cell(origin.X + d.X, origin.Y + d.Y)))
            .OrderBy(_ => random.Next()).ToList();
        if (candidates.Count == 0) return false;
        var delta = candidates[0]; dungeon.RouteRecoveryUsed++;
        Log($"路线无有效结果，执行随机容错移动 {dungeon.RouteRecoveryUsed}/{(int)routeRecoveryAttempts.Value}：方向 {delta.X},{delta.Y}");
        if (await RunMovementSlice(token,
                sliceToken => touch.PulseOneCell(InputDelta(delta), (int)singleCellPulseHold.Value, sliceToken)))
        {
            await HandleMovementPopupInterrupt(token);
            return true;
        }
        await Task.Delay(80, token);
        await RefreshMap(false, waitForLock: true);
        if (dungeon.Map is not null) EnsureRoute(true);
        return true;
    }

    async Task<bool> TryUseNextFloorShortcut(CancellationToken token)
    {
        // 右侧快捷入口是另一种传送门入口。玩家到达传送门前它就可能出现，
        // 因此优先级必须高于常规路线规划。转场对话框正在处理时绝不能探测它，
        // 否则同一个按钮可能在弹窗流程中被反复点击。
        if (floorPhase is FloorPhase.WaitingFloorLoad or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)
            return false;
        if (dungeon.Map is not null && FloorPlanningPolicy.IsMonsterHuntRoom(dungeon.Map))
            return false;
        if (!await adb.HasNextFloorButton()) return false;

        var map = dungeon.Map;
        if (map is null) return false;
        if (cancelledNextFloorLevel == map.Level) return false;
        var options = Options();
        var allPending = ActiveTargets(map, options);
        var pending = ReachableActiveTargets(map, options);
        var unreachable = allPending.Count - pending.Count;
        if (unreachable > 0 && !dungeon.ShortcutDeferredByTargets)
            Log($"忽略 {unreachable} 个不可达目标，不阻塞下一层入口");
        // ActiveTargets 有意省略被锁定的 Boss，使其不会在预警阈值前被规划。
        // 但对于快捷入口的门控，已勾选的 Boss 仍然是必需任务；
        // 在游戏移除该 Boss 节点前，必须阻止进入下一层。
        var hasRequiredBoss = options.AttackBoss && map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles)
            .Any(role => role.Kind is "Boss" or "小Boss");
        var pendingCount = pending.Count + (hasRequiredBoss ? 1 : 0);
        if (pendingCount > 0)
        {
            if (!dungeon.ShortcutDeferredByTargets)
                Log($"检测到右侧‘前往下层’入口，但仍有 {pendingCount} 个已勾选目标未完成，暂不点击");
            dungeon.ShortcutDeferredByTargets = true;
            return false;
        }
        dungeon.ShortcutDeferredByTargets = false;

        // 快捷入口出现时也要先执行换层前的挖矿，尤其是没有显式传送门路线的楼型。
        // 放在目标门控之后，保证“完成目标后再挖矿”的顺序不被打乱。
        if (await TryMineBeforeFloorTransition(token, transitionAvailable: true)) return true;
        if (IsTargetStopFloor(map) && !TargetFloorStopReady(map))
        {
            if (!dungeon.ShortcutDeferredByTargets)
                Log($"检测到右侧‘前往下层’入口，但指定层停止条件尚未满足，暂不点击");
            dungeon.ShortcutDeferredByTargets = true;
            return false;
        }
        dungeon.ShortcutDeferredByTargets = false;

        await touch.EmergencyRelease();
        var shortcutTapTimer = Stopwatch.StartNew();
        await adb.TapScreen(0.890625, 0.498);
        route = [];
        plannedInteractions = [];
        plannedTargetUniverse.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();
        floorPhase = FloorPhase.SelectBonus;
        portalInteractionDelta = default;
        portalInteractionAt = Environment.TickCount64;
        Log("检测到右侧‘前往下层’快捷入口，未前往传送门，已直接点击");
        Log($"换层弹窗诊断：快捷入口点击耗时={shortcutTapTimer.ElapsedMilliseconds}ms，开始等待弹窗流程");
        State("已点击前往下层，独立弹窗监控处理确认/加成");
        return true;
    }

    void EnsurePortalRoute()
    {
        if (dungeon.Map is null) return;
        var player = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
        // GoToPortal 有意跳过常规完整路线规划。
        // 但它仍需要独立的有效性检查，否则一次超调就会让执行器永远重试同一条过期传送门路线。
        var routeIndex = route.FindIndex(cell => cell == player);
        if (route.Count > 1 && !HasNewRoadMonsters(dungeon.Map) && Planner.CanContinueRoute(dungeon.Map, route, player, dungeon.Blocked))
        {
            // CanContinueRoute 接受已经走到锁定传送门路线中途的玩家。
            // 但执行器要求 route[0] 必须是玩家实际所在格。
            // 因此只保留剩余后缀，避免卡顿或超调的传送门路线因原始起点格而永远被拒绝。
            if (routeIndex > 0) route = route.Skip(routeIndex).ToList();
            mapPanel.Route = route;
            mapPanel.Invalidate();
            return;
        }

        var blockedBefore = dungeon.Blocked.Count;
        var plan = Planner.PlanToPortalRecoveringTemporaryBlocks(dungeon.Map, dungeon.Blocked, !Options().Monsters, dungeon.PortalUnlocks);
        if (blockedBefore > 0 && dungeon.Blocked.Count == 0)
            Log($"临时封锁导致出口不可达，已撤销 {blockedBefore} 个封锁并恢复路线");
        route = plan.Route;
        plannedInteractions = plan.Interactions;
        plannedTargetUniverse = plan.TargetUniverse;
        dungeon.Route.PlannedRoadMonsters = [.. dungeon.Map.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
        mapPanel.Route = route;
        mapPanel.Invalidate();
        Log(plan.Interactions.FirstOrDefault().Target.Kind is "小怪" or "群怪" or "精英"
            ? $"传送门仍锁定，先规划击败 {plan.Interactions[0].Target.Kind} {plan.Interactions[0].Target.Cell}"
            : route.Count > 1
            ? $"传送门路线失效，已按当前位置重新规划：{route.Count - 1} 步"
            : $"传送门路线失效，当前不可达：{plan.FailureReason}");
    }

    bool HasNewRoadMonsters(MapDump map) => !FloorPlanningPolicy.IsMonsterHuntRoom(map) && !Options().Monsters && map.ByCell.Any(pair =>
        Planner.HasRoadMonster(pair.Value) && !dungeon.Route.PlannedRoadMonsters.Contains(pair.Key));

    void EnsureRoute(bool force = false)
    {
        if (dungeon.Map is null)
        {
            // 保持此处的显式检查：过去规划器可能在首次成功获取快照前被调用
            // （例如设备列表或 root Shell 仍在稳定时），然后悄悄让 UI 显示空路线。
            Log("规划跳过：当前没有有效地图快照，请先刷新地图并确认助手数据已生成");
            State("地图未就绪");
            return;
        }
        var options = Options(); var walkability = WalkabilitySnapshot(dungeon.Map); var optionSignature = OptionsSignature(options); var player = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y);
        // 运行时导出器可能在战斗或脉冲后短暂暴露前一个格子。
        // 如果该采样比上次接受的位置落后一步，且不在锁定路线中，
        // 不要将其视为真实偏离；改为等待下一次玩家状态采样。
        if (!force && dungeon.LastAcceptedPlayerCell is { } accepted && player != accepted &&
            Environment.TickCount64 - dungeon.LastAcceptedPlayerAt < 600 &&
            Math.Abs(player.X - accepted.X) + Math.Abs(player.Y - accepted.Y) == 1 &&
            route.Contains(accepted) && !route.Contains(player))
        {
            dungeon.Map.Player = new PlayerInfo { X = accepted.X, Y = accepted.Y };
            Log($"忽略疑似滞后坐标：{player}，保持已确认位置 {accepted}");
            return;
        }
        dungeon.LastAcceptedPlayerCell = player;
        dungeon.LastAcceptedPlayerAt = Environment.TickCount64;
        var activeTargets = ActiveTargets(dungeon.Map, options);
        var routeIndex = route.FindIndex(cell => cell == player);
        var changedRoadCells = plannedWalkability.Count == 0 ? [] : walkability.Keys.Union(plannedWalkability.Keys)
            .Where(cell => !walkability.TryGetValue(cell, out var now) || !plannedWalkability.TryGetValue(cell, out var before) || now != before).ToList();
        var expectedRoadUpdate = changedRoadCells.Count > 0 && changedRoadCells.All(dungeon.ExpectedTaskRoadChanges.Contains);
        if (expectedRoadUpdate)
        {
            plannedWalkability = walkability;
            Log($"接受 {changedRoadCells.Count} 个计划任务引起的道路状态变化，不重新规划");
        }
        var navigationChanged = dungeon.Route.PlannedNavigationHash is not null &&
            dungeon.Route.Snapshot is not null && dungeon.Route.PlannedNavigationHash != dungeon.Route.Snapshot.NavigationHash;
        var roadChanged = (changedRoadCells.Count > 0 || navigationChanged) && !expectedRoadUpdate || HasNewRoadMonsters(dungeon.Map);
        dungeon.ExpectedTaskRoadChanges.Clear();
        var optionsChanged = plannedOptionsSignature is not null && plannedOptionsSignature != optionSignature;
        var newTargets = activeTargets.Where(target => !plannedTargetUniverse.Contains(target)).ToList();
        var canContinue = Planner.CanContinueRoute(dungeon.Map, route, player, dungeon.Blocked);
        if (!force && !roadChanged && !optionsChanged && newTargets.Count == 0 && canContinue)
        {
            if (routeIndex > 0) route = route.Skip(routeIndex).ToList();
            Log($"道路和计划外目标未变化，复用完整路线剩余 {route.Count - 1} 步");
        }
        else
        {
            var reason = force ? "手动" : plannedWalkability.Count == 0 ? "首次" : roadChanged ? "计划外道路变化" : optionsChanged ? "选项变化" : newTargets.Count > 0 ? $"出现 {newTargets.Count} 个计划外目标" : "人物偏离或剩余路线结束";
            var blockedBefore = dungeon.Blocked.Count;
            var plan = Planner.PlanForFloorRecoveringTemporaryBlocks(dungeon.Map, options, dungeon.Blocked, visitedMechanisms);
            if (blockedBefore > 0 && dungeon.Blocked.Count == 0)
                Log($"临时封锁切断全部目标路线，已撤销 {blockedBefore} 个封锁并恢复规划");
            route = plan.Route; plannedInteractions = plan.Interactions; plannedTargetUniverse = plan.TargetUniverse;
            dungeon.ConfirmedCompletedTargets.Clear(); dungeon.ExpectedTaskRoadChanges.Clear(); plannedWalkability = walkability; plannedOptionsSignature = optionSignature;
            dungeon.Route.PlannedNavigationHash = dungeon.Route.Snapshot?.NavigationHash;
            dungeon.Route.PlannedRoadMonsters = [.. dungeon.Map.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
            Log($"{reason}完整规划：{Math.Max(0, route.Count - 1)} 步，交互节点 {plannedInteractions.Count}，目标 {plannedTargetUniverse.Count}");
            if (!string.IsNullOrWhiteSpace(plan.FailureReason))
                Log($"规划诊断：{plan.FailureReason}，可走 {plan.WalkableCells}，未探索 {plan.UnexploredCells}，不可达目标 {plan.UnreachableTargets.Count}");
        }
        mapPanel.Route = route; mapPanel.Invalidate();
    }
    async Task Replan()
    {
        // 路线执行器移动时会轮询玩家状态，但完整地图（尤其是 tile.Explored）
        // 按独立的节奏导出。强制/手动重新规划前始终获取新的设备快照，
        // 否则规划器可能复用运行开始时捕获的迷雾状态。
        await RefreshMap(false, waitForLock: true);
        if (serverErrorDialogVisible || operations.CurrentToken.IsCancellationRequested) return;
        ReplanFromCurrentMap();
    }

    void ReplanFromCurrentMap()
    {
        if (dungeon.Map is null)
        {
            Warn("规划失败：当前没有有效地图快照（设备、Root 会话或助手地图数据未就绪）");
            State("地图未就绪");
            return;
        }
        if (dungeon.Blocked.Count > 0)
        {
            var cleared = dungeon.Blocked.Count;
            dungeon.Blocked.Clear(); dungeon.LastBlockedAttempt = null; dungeon.UnchangedCount = 0;
            Log($"手动重新规划：已清除 {cleared} 个临时封锁");
        }
        // 手动重新规划也必须先更新楼层阶段。特殊副本可能只有出口/前往下一层
        // 节点，普通完整规划会刻意排除出口，导致误报“没有可规划目标”。
        UpdateFloorPhase();
        if (floorPhase is FloorPhase.ConfirmPortal or FloorPhase.GoToPortal or FloorPhase.InteractPortal or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)
        {
            if (floorPhase is FloorPhase.ConfirmPortal or FloorPhase.GoToPortal)
            {
                var portalPlan = Planner.PlanToPortalRecoveringTemporaryBlocks(dungeon.Map, dungeon.Blocked, !Options().Monsters, dungeon.PortalUnlocks);
                route = portalPlan.Route; plannedInteractions = portalPlan.Interactions; plannedTargetUniverse = portalPlan.TargetUniverse;
                mapPanel.Route = route; mapPanel.Invalidate();
                if (route.Count > 1) Log($"重新规划前往出口：{route.Count - 1} 步");
                else Log($"出口路线为空：{portalPlan.FailureReason}，可走 {portalPlan.WalkableCells}");
            }
            else Log($"当前处于 {floorPhase} 阶段，保留现有换层流程");
            return;
        }
        var map = dungeon.Map; var options = Options();
        var walkable = map.Tiles.SelectMany(row => row).Count(t => t.Walkable);
        var unexplored = map.Tiles.SelectMany(row => row).Count(t => t.Walkable && !t.Explored);
        var active = ActiveTargets(map, options).Count;
        var diagnosticTargets = ActiveTargets(map, options).OrderBy(t => t.Cell.Y).ThenBy(t => t.Cell.X)
            .Select(t => $"{t.Kind}@({t.Cell.X},{t.Cell.Y})");
        Log($"planning targets: {string.Join(" | ", diagnosticTargets)}");
        var warningNeed = map.BossSeal.Present && !map.BossSeal.Ready && !options.Monsters
            ? Math.Max(0, (int)Math.Ceiling((map.BossSeal.WakeScore - map.BossSeal.CurScore) / 11d)) : 0;
        Log($"规划诊断：阶段 {floorPhase}，可走 {walkable}，未探索 {unexplored}，已选目标 {active}，预警还需 {warningNeed} 个小怪");
        EnsureRoute(true);
        Log(route.Count > 1 ? $"路线：{route.Count - 1} 步，目标 {route[^1]}" : "没有可规划目标");
    }
}
