using System;
using System.Collections.Generic;
using System.Linq;

namespace AdbMapController;

public static class AbyssRoutePlanner
{
    public static bool IsAbyss(MapDump map) => map.SceneType == 2 && map.CaveMode == 2;

    public static bool HasLockedPortal(MapDump map) => IsAbyss(map) &&
        PortalRouting.Enumerate(map).Any(item => item.Role.Locked);

    public static bool HasRequiredElite(MapDump map) => HasLockedPortal(map) &&
        map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles).Any(role => role.Kind == "精英");

    // 已知可攻击的 Boss 或可用楼梯时，精英不能抢占跨房间寻路目标。
    // 若门仍锁着且 Boss 尚不可攻击，解锁流程仍可单独选择精英。
    public static bool ShouldSelectElite(MapDump map) => HasLockedPortal(map) &&
        !map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles).Any(role =>
            role.Kind is ("Boss" or "小Boss") && Planner.IsBossAttackable(map, role) ||
            PortalRouting.IsFloorTransition(role) && !role.Locked);

    // 巡查只要求人物当前可到达的区域已经没有迷雾；其他房间仍可能因隐藏入口而未探索。
    public static bool IsSurveyReady(MapDump map, IReadOnlySet<Cell>? blocked = null)
        => !Planner.HasReachableUnexplored(map, blocked);

    public static RoutePlan PlanToUnlockMonster(MapDump map, IReadOnlySet<Cell>? blocked = null,
        PortalUnlockGraph? unlockGraph = null)
    {
        var lockedPortals = PortalRouting.Enumerate(map).Where(item => item.Role.Locked)
            .Select(item => item.Cell).Distinct().ToList();
        if (lockedPortals.Count == 0) return new RoutePlan { FailureReason = "没有锁定的传送门" };
        var evidence = unlockGraph is null ? new HashSet<Cell>() :
            lockedPortals.SelectMany(portal => unlockGraph.RequiredMonsters(map, portal)).ToHashSet();
        var candidates = Planner.EnumerateMonsters(map)
            .Where(item => item.Role.NormalMonster || item.Role.Kind is "小怪" or "精英")
            .GroupBy(item => item.Cell)
            .Select(group => (Cell: group.Key, Elite: group.Any(item => item.Role.Kind == "精英")))
            .OrderBy(item => item.Elite ? 0 : 1)
            .ThenBy(item => evidence.Contains(item.Cell) ? 0 : 1)
            .ThenBy(item => lockedPortals.Min(portal => Math.Abs(item.Cell.X - portal.X) + Math.Abs(item.Cell.Y - portal.Y)));
        foreach (var candidate in candidates)
        {
            var plan = Planner.PlanToTarget(map, candidate.Cell, clearRoadMonsters: true, blocked: blocked);
            if (plan.Route.Count > 1 || plan.Interactions.Count > 0) return plan;
        }
        return new RoutePlan { FailureReason = "封锁传送门附近没有可到达的解锁怪物" };
    }

    public static RoutePlan PlanExploration(MapDump map, IReadOnlySet<Cell>? blocked = null, bool avoidMonsters = true)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        var walkableCount = tiles.Values.Count(tile => tile.Walkable && !(blocked?.Contains(new Cell(tile.X, tile.Y)) ?? false));
        var unexploredCount = tiles.Values.Count(tile => tile.Walkable && !tile.Explored);
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { WalkableCells = walkableCount, UnexploredCells = unexploredCount, FailureReason = "起点不可走" };

        var (distance, previous, encounters) = Planner.Search(start, tiles, blocked, avoidMonsters);
        var destination = distance.Keys.Where(cell => cell != start && tiles.TryGetValue(cell, out var tile) &&
                tile.Walkable && !tile.Explored)
            .OrderBy(cell => distance[cell] + encounters[cell] * Planner.MonsterAvoidanceDetourLimit)
            .ThenBy(cell => distance[cell])
            .Select(cell => (Cell?)cell).FirstOrDefault();
        if (destination is null)
            return new RoutePlan { WalkableCells = walkableCount, UnexploredCells = unexploredCount,
                FailureReason = unexploredCount > 0 ? "未探索区域不可达" : "没有待探索区域" };
        return new RoutePlan { Route = Planner.BuildPath(start, destination.Value, previous),
            WalkableCells = walkableCount, UnexploredCells = unexploredCount };
    }

    /// <summary>
    /// 房间格子即使已标为探索，偏僻位置的角色仍可能等玩家靠近才下发。
    /// 在当前可步行区域选择一个未近距离观察过的停靠点；传送门格不作为停靠点。
    /// </summary>
    public static RoutePlan PlanRoomSurvey(MapDump map, IReadOnlySet<Cell> covered,
        IReadOnlySet<Cell>? blocked = null, bool avoidMonsters = true)
    {
        if (!IsSurveyReady(map, blocked))
            return new RoutePlan { FailureReason = "当前可达区域仍有迷雾" };
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { FailureReason = "房间巡查起点不可走" };
        var (distance, previous, encounters) = Planner.Search(start, tiles, blocked, avoidMonsters);
        var uncovered = distance.Keys.Where(cell => tiles.TryGetValue(cell, out var tile) &&
            tile.Walkable && !tile.Roles.Any(Planner.IsNavigationPortal) && !covered.Contains(cell)).ToHashSet();
        Cell? chosen = null;
        var best = double.NegativeInfinity;
        foreach (var candidate in distance.Keys)
        {
            if (candidate == start || covered.Contains(candidate) ||
                tiles[candidate].Roles.Any(Planner.IsNavigationPortal)) continue;
            var gain = Planner.CoverageGain(candidate, uncovered, 2);
            if (gain == 0) continue;
            var cost = distance[candidate] + encounters[candidate] * Planner.MonsterAvoidanceDetourLimit;
            var score = gain / (double)Math.Max(1, cost);
            if (score <= best) continue;
            best = score;
            chosen = candidate;
        }
        return chosen is { } destination
            ? new RoutePlan { Route = Planner.BuildPath(start, destination, previous) }
            : new RoutePlan { FailureReason = "当前房间已完成近距离巡查" };
    }

    /// <summary>
    /// 构建楼层内房间传送门路线的第一段。
    /// 交互有意作为此规划的终点：服务器可能将玩家移动到另一个房间，
    /// 因此 MainForm 会刷新，并从跳转后的权威坐标规划下一段。
    /// </summary>
    public static RoutePlan PlanToRoomPortal(MapDump map, IReadOnlySet<Cell>? blocked = null,
        bool avoidMonsters = false, IReadOnlySet<Cell>? attempted = null, PortalJumpGraph? jumps = null,
        IReadOnlyCollection<TargetKey>? desiredTargets = null, bool requireTargetProgress = false)
    {
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        var walkableCount = tiles.Values.Count(t => t.Walkable && !(blocked?.Contains(new Cell(t.X, t.Y)) ?? false));
        if (!tiles.TryGetValue(start, out var startTile) || !startTile.Walkable)
            return new RoutePlan { WalkableCells = walkableCount, FailureReason = "起点不可走" };

        var available = PortalRouting.Enumerate(map)
            .Where(item => PortalRouting.IsRoomToRoom(item.Role) && !item.Role.Locked && item.Cell != start)
            .ToList();
        var (distance, previous, encounters) = Planner.Search(start, tiles, blocked, avoidMonsters, allowPortalStops: true);
        var targetStops = (desiredTargets ?? Array.Empty<TargetKey>()).SelectMany(target => Planner.TaskStops(target, tiles)).ToHashSet();
        var roomPortals = available.GroupBy(item => item.Cell).ToDictionary(group => group.Key, group => group.First().Role);
        bool WasAttempted(Cell cell) => attempted?.Contains(cell) == true ||
            jumps?.IsObservedLandingPortal(map, cell) == true;
        (bool Target, bool Unexplored, bool NewPortal) ProgressFrom(Cell destination, HashSet<Cell> visited)
        {
            if (!visited.Add(destination)) return (false, false, false);
            var origin = tiles.TryGetValue(destination, out var landing) && landing.Walkable &&
                !landing.Roles.Any(PortalRouting.IsRoomToRoom)
                ? destination : Planner.TaskStops(new TargetKey(destination, "秘境传送门"), tiles).FirstOrDefault();
            if (!tiles.TryGetValue(origin, out var tile) || !tile.Walkable)
                return (false, false, false);
            var (reachable, _, _) = Planner.Search(origin, tiles, blocked, allowPortalStops: true);
            var progress = (
                targetStops.Any(reachable.ContainsKey),
                reachable.Keys.Any(cell => tiles.TryGetValue(cell, out var floor) && !floor.Explored),
                reachable.Keys.Any(cell => cell != destination && roomPortals.ContainsKey(cell) &&
                    !WasAttempted(cell)));
            // 一个已走过的房间可能只是通往尚未探索房间的中转站。
            // 沿已知传送边继续查看，不能只凭紧邻房间没有新内容就屏蔽回程门。
            if (jumps is not null)
                foreach (var portal in reachable.Keys.Where(cell => cell != destination && roomPortals.ContainsKey(cell)))
                    foreach (var next in jumps.CandidateTargets(map, portal, roomPortals[portal]))
                    {
                        var onward = ProgressFrom(next, visited);
                        progress = (progress.Item1 || onward.Target, progress.Item2 || onward.Unexplored,
                            progress.Item3 || onward.NewPortal);
                    }
            return progress;
        }
        int TargetHopsFrom(Cell destination, HashSet<Cell> visited)
        {
            if (!visited.Add(destination)) return int.MaxValue;
            var origin = tiles.TryGetValue(destination, out var landing) && landing.Walkable &&
                !landing.Roles.Any(PortalRouting.IsRoomToRoom)
                ? destination : Planner.TaskStops(new TargetKey(destination, "秘境传送门"), tiles).FirstOrDefault();
            if (!tiles.TryGetValue(origin, out var tile) || !tile.Walkable)
            {
                visited.Remove(destination);
                return int.MaxValue;
            }
            var (reachable, _, _) = Planner.Search(origin, tiles, blocked, allowPortalStops: true);
            var hops = targetStops.Any(reachable.ContainsKey) ? 0 : int.MaxValue;
            if (hops != 0 && jumps is not null)
                foreach (var portal in reachable.Keys.Where(cell => cell != destination && roomPortals.ContainsKey(cell)))
                    foreach (var next in jumps.CandidateTargets(map, portal, roomPortals[portal]))
                    {
                        var onward = TargetHopsFrom(next, visited);
                        if (onward < int.MaxValue) hops = Math.Min(hops, onward + 1);
                    }
            visited.Remove(destination);
            return hops;
        }
        int UnexploredHopsFrom(Cell destination, HashSet<Cell> visited)
        {
            if (!visited.Add(destination)) return int.MaxValue;
            var origin = tiles.TryGetValue(destination, out var landing) && landing.Walkable &&
                !landing.Roles.Any(PortalRouting.IsRoomToRoom)
                ? destination : Planner.TaskStops(new TargetKey(destination, "秘境传送门"), tiles).FirstOrDefault();
            if (!tiles.TryGetValue(origin, out var tile) || !tile.Walkable)
            {
                visited.Remove(destination);
                return int.MaxValue;
            }
            var (reachable, _, _) = Planner.Search(origin, tiles, blocked, allowPortalStops: true);
            var hops = reachable.Keys.Any(cell => tiles.TryGetValue(cell, out var floor) &&
                floor.Walkable && !floor.Explored) ? 0 : int.MaxValue;
            if (hops != 0 && jumps is not null)
                foreach (var portal in reachable.Keys.Where(cell => cell != destination && roomPortals.ContainsKey(cell)))
                    foreach (var next in jumps.CandidateTargets(map, portal, roomPortals[portal]))
                    {
                        var onward = UnexploredHopsFrom(next, visited);
                        if (onward < int.MaxValue) hops = Math.Min(hops, onward + 1);
                    }
            visited.Remove(destination);
            return hops;
        }
        // 已观察到的回程边如果只能抵达走过的区域，就不再反复激活。
        // 只要目的地有目标、未探索格或尚未尝试的门，走过的入口仍可参与规划。
        if (jumps is not null && attempted is not null)
            available = available.Where(item =>
            {
                var connected = jumps.CandidateTargets(map, item.Cell, item.Role);
                return !WasAttempted(item.Cell) || connected.Any(destination =>
                {
                    var progress = ProgressFrom(destination, []);
                    return progress.Target || progress.Unexplored || progress.NewPortal;
                });
            }).ToList();
        if (requireTargetProgress)
            available = available.Where(item => jumps is not null &&
                jumps.CandidateTargets(map, item.Cell, item.Role)
                    .Any(destination => TargetHopsFrom(destination, []) < int.MaxValue)).ToList();
        var portals = available.Select(item => new TargetKey(item.Cell, item.Role.Kind)).Distinct().ToList();
        if (portals.Count == 0) return new RoutePlan { WalkableCells = walkableCount, FailureReason = "已知层内传送门无法带来新的目标或区域" };
        var portalPriority = available.GroupBy(item => item.Cell).ToDictionary(group => group.Key, group =>
        {
            if (jumps is not null && targetStops.Count > 0)
            {
                var targetHops = group.SelectMany(item => jumps.CandidateTargets(map, item.Cell, item.Role))
                    .Select(destination => TargetHopsFrom(destination, [])).DefaultIfEmpty(int.MaxValue).Min();
                if (targetHops < int.MaxValue) return targetHops;
            }
            // 已确认落点和紫色点线的房间预测都参与最短传送次数计算。
            // 这样通往迷雾的门优先于虽然更近、却只会返回已探索房间的门。
            if (jumps is not null)
            {
                var unexploredHops = group.SelectMany(item => jumps.CandidateTargets(map, item.Cell, item.Role))
                    .Select(destination => UnexploredHopsFrom(destination, [])).DefaultIfEmpty(int.MaxValue).Min();
                if (unexploredHops < int.MaxValue) return 10 + unexploredHops;
            }
            // 优先尝试能抵达目标的门；没有目标时先试当前房间未走过的门。
            if (!WasAttempted(group.Key)) return targetStops.Count > 0 ? 100 : 50;
            if (jumps is null) return targetStops.Count > 0 ? 103 : 53;
            var destinations = group.SelectMany(item => jumps.CandidateTargets(map, item.Cell, item.Role)).Distinct().ToArray();
            if (destinations.Length == 0) return targetStops.Count > 0 ? 103 : 53;
            var progress = destinations.Select(destination => ProgressFrom(destination, [])).ToArray();
            var fallback = progress.Any(item => item.Target) ? 1 : progress.Any(item => item.Unexplored) ? 2 : 3;
            return targetStops.Count > 0 ? 100 + fallback : 50 + fallback;
        });
        TargetKey? chosen = null; Cell? stop = null;
        var best = (Priority: int.MaxValue, Cost: int.MaxValue, Distance: int.MaxValue);
        foreach (var portal in portals)
            foreach (var candidate in Planner.TaskStops(portal, tiles))
                if (distance.TryGetValue(candidate, out var d) &&
                    (portalPriority[portal.Cell], d + encounters[candidate] * Planner.MonsterAvoidanceDetourLimit, d)
                        .CompareTo(best) < 0)
                {
                    best = (portalPriority[portal.Cell], d + encounters[candidate] * Planner.MonsterAvoidanceDetourLimit, d);
                    chosen = portal; stop = candidate;
                }
        if (chosen is null || stop is null)
            return new RoutePlan { WalkableCells = walkableCount, FailureReason = "层内传送门不可达" };
        return new RoutePlan
        {
            Route = Planner.BuildPath(start, stop.Value, previous),
            Interactions = [new PlannedInteraction(stop.Value, chosen.Value)],
            TargetUniverse = [chosen.Value], WalkableCells = walkableCount
        };
    }

    public static RoutePlan PlanToSurveyRoomPortal(MapDump map, IReadOnlySet<Cell> covered,
        IReadOnlySet<Cell>? blocked, IReadOnlySet<Cell> attempted, PortalJumpGraph jumps, bool avoidMonsters)
    {
        var surveyTargets = map.Tiles.SelectMany(row => row)
            .Where(tile => tile.Walkable && !covered.Contains(new Cell(tile.X, tile.Y)) &&
                !tile.Roles.Any(Planner.IsNavigationPortal))
            .Select(tile => new TargetKey(new Cell(tile.X, tile.Y), "钥匙")).ToArray();
        if (surveyTargets.Length == 0)
            return new RoutePlan { FailureReason = "所有已知房间均已巡查" };
        return PlanToRoomPortal(map, blocked, avoidMonsters, attempted, jumps, surveyTargets,
            requireTargetProgress: true);
    }

}
