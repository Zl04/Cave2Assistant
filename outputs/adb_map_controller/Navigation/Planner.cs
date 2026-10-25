using System;
using System.Collections.Generic;
using System.Linq;

namespace AdbMapController;

public sealed class PlanOptions
{
    // 默认保持现有行为：除非用户明确取消 UI 选项，否则 Boss 目标可执行。
    public bool AttackBoss = true;
    public bool DirectBossNpc;
    public IReadOnlySet<TargetKey>? IgnoredTargets;
    public bool Monsters, Elites, WoodChests, OtherChests, Pots, Bones, Gold, Runes, Altars, Chambers;
    public int VisionRadius = 6;
}

public readonly record struct TargetKey(Cell Cell, string Kind);
public readonly record struct PlannedInteraction(Cell Stop, TargetKey Target);
public sealed class RoutePlan
{
    public List<Cell> Route { get; init; } = [];
    public List<PlannedInteraction> Interactions { get; init; } = [];
    public HashSet<TargetKey> TargetUniverse { get; init; } = [];
    public int WalkableCells { get; init; }
    public int UnexploredCells { get; init; }
    public HashSet<TargetKey> UnreachableTargets { get; init; } = [];
    public string FailureReason { get; init; } = "";
}

public static class Planner
{
    static readonly Cell[] Dirs = [new(1, 0), new(-1, 0), new(0, 1), new(0, -1)];
    public const int MonsterAvoidanceDetourLimit = 7;

    /// <summary>
    /// 临时阻塞来自观察到的移动卡顿，也可能是误报
    /// （例如战斗期间或坐标导出器尚未稳定时）。如果这些阻塞排除了所有规划，
    /// 但游戏拥有的地图仍有可行路线，则丢弃过期阻塞并使用有效规划。
    /// </summary>
    public static RoutePlan PlanFullRecoveringTemporaryBlocks(MapDump map, PlanOptions options,
        HashSet<Cell> blocked)
    {
        var plan = PlanFull(map, options, blocked);
        if (HasExecutablePlan(plan) || blocked.Count == 0) return plan;

        var unblockedPlan = PlanFull(map, options, null);
        if (!HasExecutablePlan(unblockedPlan)) return plan;
        blocked.Clear();
        return unblockedPlan;
    }

    /// <summary>
    /// 根据当前楼型选择规划器，并在临时封锁切断路线时重试一次权威地图。
    /// 特殊房间通过此入口接入，避免调用方各自复制楼型分支。
    /// </summary>
    public static RoutePlan PlanForFloorRecoveringTemporaryBlocks(MapDump map, PlanOptions options,
        HashSet<Cell> blocked)
    {
        var plan = FloorPlanningPolicy.IsMonsterHuntRoom(map)
            ? PlanMonsterHunt(map, blocked)
            : PlanFull(map, options, blocked);
        if (HasExecutablePlan(plan) || blocked.Count == 0) return plan;

        var unblockedPlan = FloorPlanningPolicy.IsMonsterHuntRoom(map)
            ? PlanMonsterHunt(map)
            : PlanFull(map, options, null);
        if (!HasExecutablePlan(unblockedPlan)) return plan;
        blocked.Clear();
        return unblockedPlan;
    }

    public static RoutePlan PlanToPortalRecoveringTemporaryBlocks(MapDump map, HashSet<Cell> blocked, bool avoidMonsters = false,
        PortalUnlockGraph? unlockGraph = null)
    {
        var plan = PlanToPortal(map, blocked, avoidMonsters);
        if (!HasExecutablePlan(plan))
        {
            // 被锁定的传送门是真实的导航关卡，但当前还不能到达或点击。
            // 游戏服务器会在击杀怪物后解锁它；先前往有证据支持且距离最近的普通怪物。
            var unlockPlan = PlanToPortalUnlockMonster(map, blocked, unlockGraph);
            if (HasExecutablePlan(unlockPlan)) return unlockPlan;
        }
        if (HasExecutablePlan(plan) || blocked.Count == 0) return plan;

        var unblockedPlan = PlanToPortal(map, avoidMonsters: avoidMonsters);
        if (!HasExecutablePlan(unblockedPlan)) return plan;
        blocked.Clear();
        return unblockedPlan;
    }

    public static RoutePlan PlanToPortalUnlockMonster(MapDump map, IReadOnlySet<Cell>? blocked = null,
        PortalUnlockGraph? unlockGraph = null)
    {
        var tiles = map.ByCell;
        var lockedPortals = PortalRouting.Enumerate(map)
            .Where(item => item.Role.Locked)
            .Select(item => item.Cell).Distinct().ToList();
        if (lockedPortals.Count == 0)
            return new RoutePlan { FailureReason = "没有锁定的传送门" };

        var monsters = EnumerateMonsters(map)
            .Where(item => item.Role.NormalMonster || item.Role.Kind == "小怪")
            .Select(item => (item.Cell, Kind: item.Role.Kind)).Distinct().ToList();
        if (monsters.Count == 0)
            return new RoutePlan { FailureReason = "锁定传送门等待小怪，但地图中没有可击败的小怪" };

        var evidence = unlockGraph is null
            ? new HashSet<Cell>()
            : lockedPortals.SelectMany(portal => unlockGraph.RequiredMonsters(map, portal)).ToHashSet();
        var candidates = monsters
            .OrderBy(item => evidence.Contains(item.Cell) ? 0 : 1)
            .ThenBy(item => lockedPortals.Min(portal => Manhattan(item.Cell, portal)))
            .ToList();
        var chosen = candidates[0];
        return PlanToTarget(map, chosen.Cell, clearRoadMonsters: true, blocked: blocked);
    }

    static bool HasExecutablePlan(RoutePlan plan) => plan.Route.Count > 1 || plan.Interactions.Count > 0;

    public static bool CanContinueRoute(MapDump map, IReadOnlyList<Cell> route, Cell player, IReadOnlySet<Cell>? blocked = null)
    {
        var index = -1;
        for (var i = 0; i < route.Count; i++)
            if (route[i] == player) { index = i; break; }
        if (index < 0 || index >= route.Count - 1) return false;
        var tiles = map.ByCell;
        for (var i = index + 1; i < route.Count; i++)
            if (blocked?.Contains(route[i]) == true || !tiles.TryGetValue(route[i], out var tile) || !tile.Walkable) return false;
        return true;
    }

    /// <summary>
    /// 返回从玩家当前所在格确实可以到达交互停靠点的已选目标。
    /// 某个角色的分支封闭/阻塞后，该角色仍可能留在游戏数据中；
    /// 不能让这样的角色阻止出口/下一层流程继续。
    /// </summary>
    public static HashSet<TargetKey> ReachableTargets(MapDump map, IEnumerable<TargetKey> targets, IReadOnlySet<Cell>? blocked = null)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return [];
        var (distance, _, _) = Search(start, tiles, blocked);
        return targets.Where(target => TaskStops(target, tiles).Any(distance.ContainsKey)).ToHashSet();
    }

    public static bool HasReachableUnexplored(MapDump map, IReadOnlySet<Cell>? blocked = null)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return false;
        var (distance, _, _) = Search(start, tiles, blocked);
        return distance.Keys.Any(cell => tiles.TryGetValue(cell, out var tile) && tile.Walkable && !tile.Explored);
    }

    /// <summary>
    /// 构建一条唯一目的为揭示当前楼层更多区域的路线。
    /// 它有意独立于已选目标集合：已勾选任务可能仍隐藏在地图的下一部分，
    /// 而不可到达或过期的可见角色不能让这种情况变成空闲状态。
    /// </summary>
    public static RoutePlan PlanExploration(MapDump map, int visionRadius = 6, IReadOnlySet<Cell>? blocked = null, bool avoidMonsters = true)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        var walkableCount = tiles.Values.Count(t => t.Walkable && !(blocked?.Contains(new Cell(t.X, t.Y)) ?? false));
        var unexploredCount = tiles.Values.Count(t => t.Walkable && !t.Explored);
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { WalkableCells = walkableCount, UnexploredCells = unexploredCount, FailureReason = "起点不可走" };

        var radius = Math.Max(0, visionRadius);
        var uncovered = tiles.Values.Where(tile => tile.Walkable && !tile.Explored)
            .Select(tile => new Cell(tile.X, tile.Y)).ToHashSet();
        CoverFrom(start, uncovered, radius);
        var (distance, previous, encounters) = Search(start, tiles, blocked, avoidMonsters);
        Cell? chosen = null;
        var bestRatio = -1d;
        var bestDistance = int.MaxValue;
        var bestEncounters = int.MaxValue;
        foreach (var candidate in distance.Keys)
        {
            if (candidate == start) continue;
            var gain = CoverageGain(candidate, uncovered, radius);
            if (gain == 0) continue;
            var candidateDistance = distance[candidate];
            var ratio = gain / (double)Math.Max(1, candidateDistance);
            if (encounters[candidate] < bestEncounters || encounters[candidate] == bestEncounters &&
                (ratio > bestRatio || ratio == bestRatio && candidateDistance < bestDistance))
            {
                chosen = candidate;
                bestRatio = ratio;
                bestDistance = candidateDistance;
                bestEncounters = encounters[candidate];
            }
        }

        if (chosen is null)
            return new RoutePlan
            {
                WalkableCells = walkableCount,
                UnexploredCells = unexploredCount,
                FailureReason = unexploredCount > 0 ? "未探索区域不可达" : "没有待探索区域"
            };

        var route = BuildPath(start, chosen.Value, previous);
        return new RoutePlan
        {
            Route = route,
            WalkableCells = walkableCount,
            UnexploredCells = unexploredCount,
            FailureReason = route.Count > 1 ? "" : "未探索区域不可达"
        };
    }

    public static RoutePlan PlanFull(MapDump map, PlanOptions options, IReadOnlySet<Cell>? blocked = null)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        var walkableCount = tiles.Values.Count(t => t.Walkable && !(blocked?.Contains(new Cell(t.X, t.Y)) ?? false));
        var unexploredCount = tiles.Values.Count(t => t.Walkable && !t.Explored);
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { WalkableCells = walkableCount, UnexploredCells = unexploredCount, FailureReason = "起点不可走" };

        var targets = tiles.Values
            .SelectMany(tile => tile.Roles.Where(role => TargetPolicy.IsSelected(role, options) &&
                (role.Kind != "机关" || MechanismChamberPolicy.IsPendingTrigger(role)) &&
                (role.Kind != "机关密室" || MechanismChamberPolicy.IsAvailableEntrance(role)) &&
                (role.Kind is not ("Boss" or "小Boss") || IsBossAttackable(map, role)))
                .Select(role => new TargetKey(new Cell(tile.X, tile.Y), role.Kind)))
            .Where(target => !(options.IgnoredTargets?.Contains(target) ?? false))
            .Distinct().ToList();
        // 禁用 Boss 攻击时，在所有探索/已选任务完成后仍前往 Boss 区域，
        // 但将 Boss 排除在可执行目标集合之外，避免协调逻辑把有意不交互的 Boss
        // 误认为已完成任务。
        var passiveBosses = !options.AttackBoss
            ? tiles.Values.SelectMany(tile => tile.Roles
                .Where(role => role.Kind is "Boss" or "小Boss")
                .Select(role => new TargetKey(new Cell(tile.X, tile.Y), role.Kind)))
                .Distinct().ToList()
            : [];
        // 当预警封印存在但尚未打开时，用户可以不勾选“全清小怪”。
        // 仍只添加达到唤醒分数所需的最少附近敌人（每次击杀贡献 11%），
        // 否则被锁定的 Boss 会被排除，规划器可能在明明可以推进时返回空路线。
        if (BossSealPolicy.IsActive(map) && !map.BossSeal.Ready && !options.Monsters)
        {
            var needed = Math.Max(0, (int)Math.Ceiling((map.BossSeal.WakeScore - map.BossSeal.CurScore) / 11d));
            if (needed > 0)
            {
                var startDistance = (Cell c) => Math.Abs(c.X - start.X) + Math.Abs(c.Y - start.Y);
                var warningTargets = tiles.Values
                    .SelectMany(tile => tile.Roles.Where(role => role.Kind is "小怪" or "群怪" or "精英")
                        .Select(role => new TargetKey(new Cell(tile.X, tile.Y), role.Kind)))
                    .Distinct().OrderBy(t => startDistance(t.Cell)).Take(needed);
                targets.AddRange(warningTargets);
            }
        }
        var universe = targets.ToHashSet();
        if (targets.Any(target => target.Kind == "机关" && target.Cell == start))
        {
            var exit = Dirs.Select(direction => new Cell(start.X + direction.X, start.Y + direction.Y))
                .Where(cell => tiles.TryGetValue(cell, out var tile) && tile.Walkable &&
                    !(blocked?.Contains(cell) ?? false) && !tile.Roles.Any(IsNavigationPortal))
                .Select(cell => (Cell?)cell).FirstOrDefault();
            if (exit is { } next)
                return new RoutePlan { Route = [start, next], TargetUniverse = universe,
                    WalkableCells = walkableCount, UnexploredCells = unexploredCount };
        }
        var pending = targets.ToList();
        var uncovered = tiles.Values.Where(tile => tile.Walkable && !tile.Explored).Select(tile => new Cell(tile.X, tile.Y)).ToHashSet();
        var route = new List<Cell> { start };
        var interactions = new List<PlannedInteraction>();
        var cursor = start;
        var clearedMonsters = new HashSet<Cell>();
        CoverFrom(start, uncovered, options.VisionRadius);

        var safety = Math.Max(64, tiles.Count * 3 + pending.Count * 2);
        while (safety-- > 0 && (uncovered.Count > 0 || pending.Count > 0))
        {
            var (distance, previous, encounters) = Search(cursor, tiles, blocked, !options.Monsters, clearedMonsters);
            TargetKey? chosenTarget = null; Cell? chosenStop = null; Cell? chosenExplore = null;
            var bestScore = double.MinValue;
            var bestEncounters = int.MaxValue;

            foreach (var target in pending)
            {
                // 某些楼层需要先从普通敌人处获得预警值，才能攻击楼层 Boss。
                // 将 Boss 保持为敌人列表中的最后一个。
                if (target.Kind is "Boss" or "小Boss" && pending.Any(other => other.Kind is "小怪" or "群怪" or "精英")) continue;
                foreach (var stop in TaskStops(target, tiles))
                {
                    if (!distance.TryGetValue(stop, out var d)) continue;
                    var priority = target.Kind is "Boss" or "小Boss" or "钥匙" ? 40d : 18d;
                    var score = priority / Math.Max(1, d);
                    if (encounters[stop] > bestEncounters || encounters[stop] == bestEncounters && score <= bestScore) continue;
                    bestEncounters = encounters[stop];
                    bestScore = score; chosenTarget = target; chosenStop = stop; chosenExplore = null;
                }
            }

            // 可见、已选且可攻击的 Boss 是明确目标，因此发现更多迷雾绝不能取代它。
            // 其它已选目标仍使用上面的常规评分规则。
            var hasReachableBoss = pending.Any(target => target.Kind is "Boss" or "小Boss" &&
                TaskStops(target, tiles).Any(distance.ContainsKey));
            if (!hasReachableBoss)
            foreach (var candidate in distance.Keys)
            {
                var gain = CoverageGain(candidate, uncovered, options.VisionRadius);
                if (gain == 0) continue;
                var score = gain / (double)Math.Max(1, distance[candidate]);
                if (encounters[candidate] > bestEncounters || encounters[candidate] == bestEncounters && score <= bestScore) continue;
                bestEncounters = encounters[candidate];
                bestScore = score; chosenExplore = candidate; chosenTarget = null; chosenStop = null;
            }

            var destination = chosenStop ?? chosenExplore;
            if (destination is null || bestScore <= 0) break;
            var path = BuildPath(cursor, destination.Value, previous);
            foreach (var cell in path.Skip(1))
            {
                route.Add(cell); CoverFrom(cell, uncovered, options.VisionRadius);
                if (HasRoadMonster(tiles[cell])) clearedMonsters.Add(cell);
            }
            cursor = destination.Value;
            if (chosenTarget is { } task)
            {
                pending.Remove(task);
                if (task.Kind is "小怪" or "群怪" or "精英") clearedMonsters.Add(task.Cell);
                if (RequiresExplicitInteraction(task.Kind) || task.Kind is "密室" or "机关密室") interactions.Add(new(cursor, task));
            }
        }
        if (!options.AttackBoss)
        {
            // 仅在常规路线完成后追加被动 Boss 目的地。
            // 最终停靠点与每个 Boss 相邻，因此此模式下执行器不会发送战斗/交互输入。
            foreach (var boss in passiveBosses)
            {
                var (distance, previous, encounters) = Search(cursor, tiles, blocked, !options.Monsters, clearedMonsters);
                Cell? bossStop = null; var best = (Encounters: int.MaxValue, Distance: int.MaxValue);
                foreach (var stop in TaskStops(boss, tiles))
                    if (distance.TryGetValue(stop, out var d) && (encounters[stop], d).CompareTo(best) < 0)
                    { best = (encounters[stop], d); bossStop = stop; }
                if (bossStop is null) continue;
                var path = BuildPath(cursor, bossStop.Value, previous);
                foreach (var cell in path.Skip(1)) route.Add(cell);
                cursor = bossStop.Value;
            }
        }
        var served = interactions.Select(x => x.Target).ToHashSet();
        var unreachable = universe.Where(target => !served.Contains(target) &&
            !TaskStops(target, tiles).Any(stop => route.Contains(stop))).ToHashSet();
        var reason = route.Count > 1 ? "" : universe.Count > 0 ? "目标不可达或没有可用停靠点" : unexploredCount > 0 ? "未探索区域不可达" : "没有待处理目标";
        return new RoutePlan { Route = route, Interactions = interactions, TargetUniverse = universe,
            WalkableCells = walkableCount, UnexploredCells = unexploredCount, UnreachableTargets = unreachable, FailureReason = reason };
    }

    /// <summary>
    /// 6101“奇怪的房间”的专用规划：只找当前地图中可识别的怪物，
    /// 选最近的一个，路线在怪物相邻格停下并交给战斗流程。
    /// 不把迷雾覆盖、宝箱、机关或出口加入本次规划。
    /// </summary>
    public static RoutePlan PlanMonsterHunt(MapDump map, IReadOnlySet<Cell>? blocked = null)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        var walkableCount = tiles.Values.Count(t => t.Walkable && !(blocked?.Contains(new Cell(t.X, t.Y)) ?? false));
        var unexploredCount = tiles.Values.Count(t => t.Walkable && !t.Explored);
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { WalkableCells = walkableCount, UnexploredCells = unexploredCount, FailureReason = "起点不可走" };

        var monsters = tiles.Values
            .SelectMany(tile => tile.Roles
                .Where(FloorPlanningPolicy.IsMonster)
                .Select(role => new TargetKey(new Cell(tile.X, tile.Y), role.Kind)))
            .Distinct()
            .ToHashSet();
        if (monsters.Count == 0)
            return new RoutePlan
            {
                WalkableCells = walkableCount,
                UnexploredCells = unexploredCount,
                FailureReason = "没有可见怪物"
            };

        // 该房间的目的就是战斗，不为绕开怪物增加代价。
        var (distance, previous, encounters) = Search(start, tiles, blocked);
        TargetKey? selected = null;
        Cell? stop = null;
        var best = (Distance: int.MaxValue, Encounters: int.MaxValue, X: int.MaxValue, Y: int.MaxValue);
        foreach (var target in monsters)
        foreach (var candidate in TaskStops(target, tiles))
        {
            if (!distance.TryGetValue(candidate, out var targetDistance)) continue;
            var score = (targetDistance, encounters[candidate], target.Cell.X, target.Cell.Y);
            if (score.CompareTo(best) >= 0) continue;
            best = score;
            selected = target;
            stop = candidate;
        }

        if (selected is null || stop is null)
            return new RoutePlan
            {
                TargetUniverse = monsters,
                WalkableCells = walkableCount,
                UnexploredCells = unexploredCount,
                UnreachableTargets = monsters,
                FailureReason = "怪物不可达或没有可用战斗停靠点"
            };

        var path = BuildPath(start, stop.Value, previous);
        // 路上的怪物也必须逐个战斗，不能穿过后才在远处停下。
        for (var i = 1; i < path.Count; i++)
        {
            if (!tiles.TryGetValue(path[i], out var tile)) continue;
            var roadMonster = tile.Roles.FirstOrDefault(FloorPlanningPolicy.IsMonster);
            if (roadMonster is null) continue;
            var roadTarget = new TargetKey(path[i], roadMonster.Kind);
            return new RoutePlan
            {
                Route = path.Take(i).ToList(),
                Interactions = [new PlannedInteraction(path[i - 1], roadTarget)],
                TargetUniverse = monsters,
                WalkableCells = walkableCount,
                UnexploredCells = unexploredCount
            };
        }

        return new RoutePlan
        {
            Route = path,
            Interactions = [new PlannedInteraction(stop.Value, selected.Value)],
            TargetUniverse = monsters,
            WalkableCells = walkableCount,
            UnexploredCells = unexploredCount
        };
    }

    // 传送门是洞窟地图中的可通行触发格。路线必须在传送门格本身结束；
    // 停在相邻格会让角色位于传送门旁边，可能错过游戏的触发条件。
    public static RoutePlan PlanToPortal(MapDump map, IReadOnlySet<Cell>? blocked = null, bool avoidMonsters = false)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        var walkableCount = tiles.Values.Count(t => t.Walkable && !(blocked?.Contains(new Cell(t.X, t.Y)) ?? false));
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { WalkableCells = walkableCount, FailureReason = "起点不可走" };
        // 房间之间的传送门是楼层内导航节点，不是显示下一层奖励对话框的请求。
        // 只有源码确认的楼层转场属于此阶段。
        var portals = tiles.Values
            .SelectMany(t => t.Roles.Where(r => PortalRouting.IsFloorTransition(r) && !r.Locked)
                .Select(r => new TargetKey(new Cell(t.X, t.Y), r.Kind))).Distinct().ToList();
        if (portals.Count == 0) return new RoutePlan { WalkableCells = walkableCount, FailureReason = "地图中没有层间出口" };
        var (distance, previous, encounters) = Search(start, tiles, blocked, avoidMonsters, allowPortalStops: true);
        TargetKey? chosen = null; Cell? stop = null; var best = (Encounters: int.MaxValue, Distance: int.MaxValue);
        foreach (var portal in portals)
            foreach (var candidate in TaskStops(portal, tiles))
                if (distance.TryGetValue(candidate, out var d) && (encounters[candidate], d).CompareTo(best) < 0)
                { best = (encounters[candidate], d); chosen = portal; stop = candidate; }
        if (chosen is null || stop is null) return new RoutePlan { WalkableCells = walkableCount, FailureReason = "出口不可达" };
        return new RoutePlan
        {
            Route = BuildPath(start, stop.Value, previous),
            Interactions = [new PlannedInteraction(stop.Value, chosen.Value)],
            TargetUniverse = [chosen.Value], WalkableCells = walkableCount
        };
    }

    /// <summary>
    /// 构建楼层内房间传送门路线的第一段。
    /// 交互有意作为此规划的终点：服务器可能将玩家移动到另一个房间，
    /// 因此 MainForm 会刷新，并从跳转后的权威坐标规划下一段。
    /// </summary>
    public static RoutePlan PlanToRoomPortal(MapDump map, IReadOnlySet<Cell>? blocked = null,
        bool avoidMonsters = false, IReadOnlySet<Cell>? attempted = null)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        var walkableCount = tiles.Values.Count(t => t.Walkable && !(blocked?.Contains(new Cell(t.X, t.Y)) ?? false));
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { WalkableCells = walkableCount, FailureReason = "起点不可走" };

        var portals = PortalRouting.Enumerate(map)
            .Where(item => PortalRouting.IsRoomToRoom(item.Role) && !item.Role.Locked && item.Cell != start &&
                (attempted?.Contains(item.Cell) != true))
            .Select(item => new TargetKey(item.Cell, item.Role.Kind)).Distinct().ToList();
        if (portals.Count == 0) return new RoutePlan { WalkableCells = walkableCount, FailureReason = "没有未尝试的层内传送门" };

        var (distance, previous, encounters) = Search(start, tiles, blocked, avoidMonsters, allowPortalStops: true);
        TargetKey? chosen = null; Cell? stop = null; var best = (Encounters: int.MaxValue, Distance: int.MaxValue);
        foreach (var portal in portals)
            foreach (var candidate in TaskStops(portal, tiles))
                if (distance.TryGetValue(candidate, out var d) && (encounters[candidate], d).CompareTo(best) < 0)
                { best = (encounters[candidate], d); chosen = portal; stop = candidate; }
        if (chosen is null || stop is null)
            return new RoutePlan { WalkableCells = walkableCount, FailureReason = "层内传送门不可达" };
        return new RoutePlan
        {
            Route = BuildPath(start, stop.Value, previous),
            Interactions = [new PlannedInteraction(stop.Value, chosen.Value)],
            TargetUniverse = [chosen.Value], WalkableCells = walkableCount
        };
    }

    /// <summary>为地图点击构建点到点路线。</summary>
    public static RoutePlan PlanToTarget(MapDump map, Cell target, bool clearRoadMonsters,
        IReadOnlySet<Cell>? blocked = null)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { FailureReason = "起点不可走" };
        if (!tiles.TryGetValue(target, out var targetTile) || !IsClickableTarget(targetTile))
            return new RoutePlan { FailureReason = "点击位置不是可行走道路或可交互目标" };

        var targetRole = targetTile.Roles.Select(role => role.Kind)
            .FirstOrDefault(kind => IsClickableRole(kind));
        var clickedTarget = string.IsNullOrEmpty(targetRole) ? (TargetKey?)null : new TargetKey(target, targetRole);
        var (distance, previous, _) = Search(start, tiles, blocked, !clearRoadMonsters,
            allowPortalStops: targetTile.Roles.Any(IsNavigationPortal));
        Cell? stop = null;
        if (clickedTarget is { } task)
        {
            var stops = TaskStops(task, tiles).Where(distance.ContainsKey)
                .OrderBy(cell => distance[cell]).ToList();
            if (stops.Count > 0) stop = stops[0];
        }
        else if (distance.ContainsKey(target)) stop = target;
        if (stop is null) return new RoutePlan { FailureReason = "点击目标不可达" };

        var fullPath = BuildPath(start, stop.Value, previous);
        // 所选道路上的怪物是同步点：停在它旁边并战斗，然后让调用方刷新并计算剩余路线。
        for (var i = 1; i < fullPath.Count; i++)
        {
            var monster = tiles[fullPath[i]].Roles.FirstOrDefault(role => role.Kind is "小怪" or "群怪" or "精英");
            if (monster is null) continue;
            var roadTarget = new TargetKey(fullPath[i], monster.Kind);
            return new RoutePlan
            {
                Route = fullPath.Take(i).ToList(),
                Interactions = [new PlannedInteraction(fullPath[i - 1], roadTarget)],
                TargetUniverse = [roadTarget]
            };
        }

        return new RoutePlan
        {
            Route = fullPath,
            // 拾取类目标进入其可通行格即可完成。其它已识别角色都是明确的点击目标，
            // 包括不属于常规自动收集策略的传送门、商人和其它地图任务点。
            Interactions = clickedTarget is { } final &&
                (RequiresExplicitInteraction(final.Kind) || stop.Value != final.Cell)
                ? [new PlannedInteraction(stop.Value, final)] : [],
            TargetUniverse = clickedTarget is { } selected ? [selected] : []
        };
    }

    public static bool IsClickableTarget(TileInfo tile)
        => tile.Walkable || tile.Roles.Any(role => IsClickableRole(role.Kind));

    static bool IsClickableRole(string kind) => kind.Length > 0 && kind != "未知";

    static bool RequiresExplicitInteraction(string kind) => kind is
        "小怪" or "群怪" or "精英" or "小Boss" or "Boss" or
        "罐子" or "石堆" or "木箱" or "金箱" or "点金台" or "直接挑战Boss NPC";
    static IEnumerable<Cell> TaskStops(TargetKey target, Dictionary<Cell, TileInfo> tiles)
    {
        if (PortalRouting.IsPortalKind(target.Kind) &&
            tiles.TryGetValue(target.Cell, out var portalTile) && portalTile.Walkable)
        { yield return target.Cell; yield break; }

        // 拾取类目标通过走过其所在格收集。怪物在被击败前会占据其所在格，
        // 因此怪物的停靠点是相邻的可通行格。
        if (target.Kind is "金币" or "钥匙" or "符文" or "机关" or "密室" or "机关密室"
            && tiles.TryGetValue(target.Cell, out var passThrough) && passThrough.Walkable)
        { yield return target.Cell; yield break; }
        foreach (var d in Dirs)
        {
            var stop = new Cell(target.Cell.X - d.X, target.Cell.Y - d.Y);
            if (tiles.TryGetValue(stop, out var tile) && tile.Walkable) yield return stop;
        }
    }
    public static bool HasRoadMonster(TileInfo tile) => tile.Roles.Any(role => role.Kind is "小怪" or "群怪" or "精英");

    internal static IEnumerable<(Cell Cell, RoleInfo Role)> EnumerateMonsters(MapDump map)
        => map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles
            .Where(role => role.ClassName == "MonsterData")
            .Select(role => (new Cell(tile.X, tile.Y), role)));

    static int Manhattan(Cell a, Cell b) => Math.Abs(a.X - b.X) + Math.Abs(a.Y - b.Y);

    static bool IsNavigationPortal(RoleInfo role)
        => PortalRouting.IsPortalRole(role) || PortalRouting.IsPortalKind(role.Kind);

    // 绕开一个道路怪物最多值得多走七步。
    // 这样既保持安全偏好，又不会为了单场普通战斗让玩家大幅绕路。
    // 完全相同的情况下，优先选择遭遇更少的路线。
    // 当所有路线都需要战斗时，怪物所在格仍可通行。
    static (Dictionary<Cell, int> Distance, Dictionary<Cell, Cell> Previous, Dictionary<Cell, int> Encounters) Search(
        Cell start, Dictionary<Cell, TileInfo> tiles, IReadOnlySet<Cell>? blocked,
        bool avoidMonsters = false, IReadOnlySet<Cell>? clearedMonsters = null, bool allowPortalStops = false)
    {
        var queue = new PriorityQueue<Cell, (int Cost, int Encounters, int Distance, int Order)>();
        var order = 0;
        queue.Enqueue(start, (0, 0, 0, order++));
        var previous = new Dictionary<Cell, Cell>(); var distance = new Dictionary<Cell, int> { [start] = 0 };
        var encounters = new Dictionary<Cell, int> { [start] = 0 };
        while (queue.TryDequeue(out var current, out var cost))
        {
            if (cost.Encounters != encounters[current] || cost.Distance != distance[current]) continue;
            foreach (var d in Dirs)
            {
                var next = new Cell(current.X + d.X, current.Y + d.Y);
                if (blocked?.Contains(next) == true || !tiles.TryGetValue(next, out var tile) || !tile.Walkable) continue;
                // 踩门可能立即离开当前房间，收集和探索不能把它当作普通道路。
                // 专门的传送路线可以到门上，但不能假设穿门后仍在原坐标系行走。
                var isPortal = tile.Roles.Any(IsNavigationPortal);
                if (isPortal && !allowPortalStops) continue;
                var nextEncounters = encounters[current] +
                    (avoidMonsters && HasRoadMonster(tile) && clearedMonsters?.Contains(next) != true ? 1 : 0);
                var nextDistance = distance[current] + 1;
                var nextCost = nextDistance + nextEncounters * MonsterAvoidanceDetourLimit;
                if (distance.TryGetValue(next, out var oldDistance))
                {
                    var oldEncounters = encounters[next];
                    var oldCost = oldDistance + oldEncounters * MonsterAvoidanceDetourLimit;
                    if ((nextCost, nextEncounters, nextDistance).CompareTo((oldCost, oldEncounters, oldDistance)) >= 0) continue;
                }
                encounters[next] = nextEncounters; distance[next] = nextDistance; previous[next] = current;
                if (!isPortal) queue.Enqueue(next, (nextCost, nextEncounters, nextDistance, order++));
            }
        }
        return (distance, previous, encounters);
    }
    static List<Cell> BuildPath(Cell start, Cell end, Dictionary<Cell, Cell> previous)
    {
        var path = new List<Cell> { end }; var cursor = end;
        while (cursor != start) { if (!previous.TryGetValue(cursor, out cursor)) return [start]; path.Add(cursor); }
        path.Reverse(); return path;
    }
    static int CoverageGain(Cell center, HashSet<Cell> uncovered, int radius)
        => uncovered.Count(cell => Math.Abs(cell.X - center.X) + Math.Abs(cell.Y - center.Y) <= radius);
    static void CoverFrom(Cell center, HashSet<Cell> uncovered, int radius)
        => uncovered.RemoveWhere(cell => Math.Abs(cell.X - center.X) + Math.Abs(cell.Y - center.Y) <= radius);

    static double Score(Cell cell, Dictionary<Cell, TileInfo> tiles, PlanOptions o)
    {
        double score = 0;
        for (var dx = -o.VisionRadius; dx <= o.VisionRadius; dx++)
        for (var dy = -o.VisionRadius; dy <= o.VisionRadius; dy++)
            if (Math.Abs(dx) + Math.Abs(dy) <= o.VisionRadius && tiles.TryGetValue(new(cell.X + dx, cell.Y + dy), out var t) && t.Walkable && !t.Explored) score++;
        if (!tiles.TryGetValue(cell, out var here)) return score;
        foreach (var role in here.Roles)
        {
            if (TargetPolicy.IsSelected(role, o)) score += 18;
        }
        // 可破坏物和被怪物占据的格不可通行。为它们的可通行邻居评分，
        // 使规划在交互点结束。
        foreach (var d in Dirs)
            if (tiles.TryGetValue(new(cell.X + d.X, cell.Y + d.Y), out var neighbour) && neighbour.Roles.Any(r => TargetPolicy.IsSelected(r, o))) score += 18;
        return score;
    }

    public static bool IsSelectedTarget(RoleInfo role, PlanOptions o) => TargetPolicy.IsSelected(role, o);

    // 传送门/出口目标有意排除在常规规划器的已选目标集合之外。
    // 因此在实际发送传送门交互前，它们必须保持待处理；
    // 否则协调逻辑可能在传送门路线创建后立即移除该交互。
    public static bool IsCompletedTarget(TargetKey target, IReadOnlySet<TargetKey> active)
        => !PortalRouting.IsPortalKind(target.Kind) && !active.Contains(target);

    // 守护 Boss 在封印打开前是有效的地图对象，但在服务器下发的预警分数
    // 达到要求前，不得将其加入可执行目标集合。SpriteID 只是资源标识符，
    // 绝不能拿它与 Boss 实例比较。
    public static bool IsBossAttackable(MapDump map, RoleInfo role)
        => !BossSealPolicy.IsActive(map) || map.BossSeal.Ready;

    public static (Cell Delta, string Kind)? InteractionAt(MapDump map, Cell from, PlanOptions options)
    {
        var tiles = map.ByCell;
        foreach (var d in Dirs)
            if (tiles.TryGetValue(new(from.X + d.X, from.Y + d.Y), out var tile))
            {
                var role = tile.Roles.FirstOrDefault(r => TargetPolicy.IsSelected(r, options));
                if (role is not null) return (d, role.Kind);
            }
        return null;
    }
}
