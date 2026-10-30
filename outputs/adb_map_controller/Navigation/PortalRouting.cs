using System;
using System.Collections.Generic;
using System.Linq;

namespace AdbMapController;

/// <summary>
/// 根据游戏的 PublicDefine.TRANS_DOOR_TYPE 和 TriggerNpcData 还原的语义。
/// 客户端知道传送模式，但房间间传送门的目的地由服务器拥有，不在角色数据中。
/// </summary>
public enum PortalTransferMode
{
    Unknown,
    NextLevel,
    CaveToTown,
    RoomToRoom,
    GuildToTown,
    TownToGuild,
    BlackHouseToTown,
    TownCaveToTown,
    TownToTownCave,
    TownToManor,
    ManorToTown,
    TownToBigSailPort,
    BigSailPortToTown,
}

public static class PortalRouting
{
    public const int TriggerNpcRoleType = 1;
    public const int StairsMinimapType = 1;
    public const int PortalMinimapType = 18;
    public const int RoomPortalMinimapType = 22;
    public const int RoomToRoomTransdoorType = PortalProtocol.RoomToRoomTransdoorType;

    public static bool IsPortalKind(string kind) => kind is "出口" or "传送门" or "秘境传送门";

    public static bool IsPortalRole(RoleInfo role)
        => role.ClassName == "TriggerNpcData" && role.RoleType == TriggerNpcRoleType &&
           role.MinimapType is StairsMinimapType or PortalMinimapType or RoomPortalMinimapType or 21 or 44;

    public static PortalTransferMode GetTransferMode(RoleInfo role)
    {
        if (!IsPortalRole(role)) return PortalTransferMode.Unknown;
        return role.TransdoorType switch
        {
            1 => PortalTransferMode.NextLevel,
            2 => PortalTransferMode.CaveToTown,
            RoomToRoomTransdoorType => PortalTransferMode.RoomToRoom,
            4 => PortalTransferMode.GuildToTown,
            5 => PortalTransferMode.TownToGuild,
            6 => PortalTransferMode.BlackHouseToTown,
            7 => PortalTransferMode.TownCaveToTown,
            8 => PortalTransferMode.TownToTownCave,
            9 => PortalTransferMode.TownToManor,
            10 => PortalTransferMode.ManorToTown,
            11 => PortalTransferMode.TownToBigSailPort,
            12 => PortalTransferMode.BigSailPortToTown,
            _ when role.MinimapType == RoomPortalMinimapType => PortalTransferMode.RoomToRoom,
            _ when role.MinimapType == StairsMinimapType => PortalTransferMode.NextLevel,
            _ when role.MinimapType == PortalMinimapType => PortalTransferMode.CaveToTown,
            _ => PortalTransferMode.Unknown,
        };
    }

    public static bool IsRoomToRoom(RoleInfo role)
        => IsPortalRole(role) && (GetTransferMode(role) == PortalTransferMode.RoomToRoom ||
                                   role.MinimapType == RoomPortalMinimapType);

    public static bool IsRandomRoomPortal(RoleInfo role)
        => IsRoomToRoom(role) && role.IsRandomTransfer;

    public static bool IsAvailable(RoleInfo role) => IsPortalRole(role) && !role.Locked;

    public static bool IsFloorTransition(RoleInfo role)
        => IsPortalRole(role) && !IsRoomToRoom(role) &&
           GetTransferMode(role) is PortalTransferMode.NextLevel or PortalTransferMode.CaveToTown;

    public static IEnumerable<(Cell Cell, RoleInfo Role)> Enumerate(MapDump map)
        => map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles
            .Where(IsPortalRole).Select(role => (new Cell(tile.X, tile.Y), role)));

    public static IEnumerable<Cell> RoomPortalCells(MapDump map)
        => Enumerate(map).Where(item => IsRoomToRoom(item.Role) && !item.Role.Locked).Select(item => item.Cell).Distinct();

    // 将传送门格从步行图中移除，再按相邻道路划分房间。
    public static (Dictionary<int, List<Cell>> Rooms, Dictionary<Cell, HashSet<int>> PortalRooms,
        Dictionary<Cell, int> Regions) RoomLayout(MapDump map)
    {
        var tiles = map.ByCell;
        var portals = Enumerate(map).Where(item => IsRoomToRoom(item.Role))
            .Select(item => item.Cell).ToHashSet();
        var regions = new Dictionary<Cell, int>();
        var directions = new[] { new Cell(1, 0), new Cell(-1, 0), new Cell(0, 1), new Cell(0, -1) };
        var region = 0;
        foreach (var (cell, tile) in tiles)
        {
            if (!tile.Walkable || portals.Contains(cell) || regions.ContainsKey(cell)) continue;
            var pending = new Queue<Cell>();
            pending.Enqueue(cell);
            regions[cell] = region;
            while (pending.TryDequeue(out var current))
                foreach (var direction in directions)
                {
                    var next = new Cell(current.X + direction.X, current.Y + direction.Y);
                    if (regions.ContainsKey(next) || portals.Contains(next) ||
                        !tiles.TryGetValue(next, out var neighbour) || !neighbour.Walkable) continue;
                    regions[next] = region;
                    pending.Enqueue(next);
                }
            region++;
        }
        var portalRooms = portals.ToDictionary(portal => portal, portal => directions
            .Select(direction => new Cell(portal.X + direction.X, portal.Y + direction.Y))
            .Where(regions.ContainsKey).Select(cell => regions[cell]).ToHashSet());
        var rooms = regions.GroupBy(pair => pair.Value)
            .ToDictionary(group => group.Key, group => group.Select(pair => pair.Key).ToList());
        return (rooms, portalRooms, regions);
    }

    public static Cell? NearestRoomPortal(MapDump map, Cell origin, int maxDistance = 2, bool includeLocked = false)
    {
        var cells = includeLocked
            ? Enumerate(map).Where(item => IsRoomToRoom(item.Role)).Select(item => item.Cell).Distinct()
            : RoomPortalCells(map);
        var candidates = cells
            .Select(cell => (Cell: cell, Distance: Math.Abs(cell.X - origin.X) + Math.Abs(cell.Y - origin.Y)))
            .OrderBy(item => item.Distance)
            .ToList();
        if (candidates.Count == 0) return null;
        var nearest = candidates[0];
        return nearest.Distance <= maxDistance ? nearest.Cell : null;
    }

    public static string Describe(RoleInfo role)
    {
        if (!IsPortalRole(role)) return "非传送门";
        var mode = GetTransferMode(role) switch
        {
            PortalTransferMode.NextLevel => "层间-下一层",
            PortalTransferMode.CaveToTown => "层间-回城",
            PortalTransferMode.RoomToRoom => role.IsRandomTransfer ? "层内-随机房间" : "层内-固定房间",
            _ => $"模式{role.TransdoorType}",
        };
        return $"{mode} minimapType={role.MinimapType}";
    }
}

public readonly record struct PortalMapKey(int Level, string MapName, int Width, int Height, int CaveMode);

/// <summary>
/// 从两次地图快照中学习服务器选择的房间传送门目的地。
/// 有意不假设随机传送门只有一条固定边。
/// </summary>
public sealed class PortalJumpGraph
{
    readonly Dictionary<PortalMapKey, Dictionary<Cell, HashSet<Cell>>> edges = [];
    readonly Dictionary<PortalMapKey, Dictionary<Cell, Cell>> confirmedFixedPairs = [];
    public void Clear() { edges.Clear(); confirmedFixedPairs.Clear(); }

    public static PortalMapKey KeyOf(MapDump map)
        => new(map.Level, map.MapName ?? "", map.Width, map.Height, map.CaveMode);

    public bool Observe(MapDump before, Cell source, MapDump after, out Cell destination, Cell? beforePlayerOverride = null)
    {
        destination = default;
        if (before.Level != after.Level || KeyOf(before) != KeyOf(after)) return false;
        var beforePlayer = beforePlayerOverride ?? new Cell(before.Player.X, before.Player.Y);
        var afterPlayer = new Cell(after.Player.X, after.Player.Y);
        if (beforePlayer == afterPlayer || afterPlayer == source) return false;

        // 游戏可能将玩家生成在目的地传送门旁边，而不是传送门格上。
        // 超过一个格子的距离后，端点就无法确定。
        var candidate = PortalRouting.NearestRoomPortal(after, afterPlayer, includeLocked: true);
        if (candidate is null || candidate.Value == source) return false;
        destination = candidate.Value;
        AddEdge(after, source, destination);
        if (FixedRole(before, source) is not null && FixedRole(after, destination) is not null)
            AddConfirmedFixedPair(after, source, destination);
        return true;
    }

    void AddConfirmedFixedPair(MapDump map, Cell first, Cell second)
    {
        var mapKey = KeyOf(map);
        if (!confirmedFixedPairs.TryGetValue(mapKey, out var pairs))
            confirmedFixedPairs[mapKey] = pairs = [];
        void RemovePair(Cell portal)
        {
            if (!pairs.Remove(portal, out var previous)) return;
            if (pairs.TryGetValue(previous, out var reciprocal) && reciprocal == portal)
            {
                pairs.Remove(previous);
                if (edges.TryGetValue(mapKey, out var fromEdges)) fromEdges.Remove(previous);
            }
            if (edges.TryGetValue(mapKey, out var sources)) sources.Remove(portal);
        }
        RemovePair(first);
        RemovePair(second);
        pairs[first] = second;
        pairs[second] = first;
        AddEdge(map, first, second);
        AddEdge(map, second, first);
    }

    // 落点门尚未下发时仍记录实际到达的房间位置，供后续规划识别已走过的房间。
    public void ObserveArrival(MapDump map, Cell source, Cell arrival)
    {
        if (!map.ByCell.TryGetValue(arrival, out var tile) || !tile.Walkable || source == arrival) return;
        AddEdge(map, source, arrival);
    }

    // 坐标更新可能早于目的地传送门下发；地图补齐后将落地格修正为真正的门。
    public IReadOnlyCollection<Cell> ReconcileArrivals(MapDump map)
    {
        if (!edges.TryGetValue(KeyOf(map), out var fromEdges)) return Array.Empty<Cell>();
        var resolved = new List<Cell>();
        foreach (var (source, targets) in fromEdges.ToArray())
        {
            foreach (var arrival in targets.ToArray())
            {
                var isPortal = PortalRouting.Enumerate(map).Any(item => item.Cell == arrival && PortalRouting.IsRoomToRoom(item.Role));
                if (isPortal && IsConfirmedConnection(map, source, arrival)) continue;
                var portal = isPortal ? arrival : PortalRouting.NearestRoomPortal(map, arrival, includeLocked: true);
                if (portal is null || portal.Value == source) continue;
                if (!isPortal)
                {
                    targets.Remove(arrival);
                    targets.Add(portal.Value);
                }
                if (FixedRole(map, source) is not null && FixedRole(map, portal.Value) is not null)
                    AddConfirmedFixedPair(map, source, portal.Value);
                if (!isPortal) resolved.Add(portal.Value);
            }
        }
        return resolved;
    }

    void AddEdge(MapDump map, Cell source, Cell destination)
    {
        var mapKey = KeyOf(map);
        if (!edges.TryGetValue(mapKey, out var fromEdges))
            edges[mapKey] = fromEdges = [];
        if (!fromEdges.TryGetValue(source, out var targets))
            fromEdges[source] = targets = [];
        if (FixedRole(map, source) is not null) targets.Clear();
        targets.Add(destination);
    }

    public IReadOnlyCollection<Cell> ObservedTargets(MapDump map, Cell source)
        => edges.TryGetValue(KeyOf(map), out var fromEdges) && fromEdges.TryGetValue(source, out var targets)
            ? targets.ToArray() : Array.Empty<Cell>();

    public bool IsObservedLandingPortal(MapDump map, Cell portal)
        => edges.TryGetValue(KeyOf(map), out var fromEdges) &&
           fromEdges.Values.SelectMany(targets => targets).Any(arrival =>
               PortalRouting.NearestRoomPortal(map, arrival, includeLocked: true) == portal);

    static RoleInfo? FixedRole(MapDump map, Cell cell)
        => map.ByCell.TryGetValue(cell, out var tile)
            ? tile.Roles.FirstOrDefault(role => PortalRouting.IsRoomToRoom(role) && !role.IsRandomTransfer)
            : null;

    /// <summary>实际落点优先；完整连续的门生成序列用于推断尚未经过的固定门。</summary>
    public IReadOnlyDictionary<Cell, Cell> ConnectedRooms(MapDump map)
    {
        var result = new Dictionary<Cell, Cell>();
        var fixedPortals = PortalRouting.Enumerate(map)
            .Where(item => PortalRouting.IsRoomToRoom(item.Role) && !item.Role.IsRandomTransfer)
            .GroupBy(item => item.Cell).Select(group => group.First())
            .OrderBy(item => item.Role.SpriteID).ToArray();
        var fixedCells = fixedPortals.Select(item => item.Cell).ToHashSet();
        var (_, portalRooms, regions) = PortalRouting.RoomLayout(map);
        if (edges.TryGetValue(KeyOf(map), out var observed))
        {
            foreach (var (source, targets) in observed)
            {
                if (!fixedCells.Contains(source) || targets.Count == 0) continue;
                result[source] = targets.Last();
            }
        }

        var used = result.Keys.ToHashSet();
        foreach (var destination in result.Values)
            if (PortalRouting.NearestRoomPortal(map, destination, includeLocked: true) is { } landing && fixedCells.Contains(landing))
                used.Add(landing);

        // SpriteID 的高 16 位是本层角色的连续生成序号。只有序列完整时才按相邻
        // 两门配对；缺门、重复序号或跨同一房间时退回房间几何推断。
        var orderedIds = fixedPortals.Select(item => item.Role.SpriteID >> 16).ToArray();
        var completeSequence = fixedPortals.Length > 0 && fixedPortals.Length % 2 == 0 &&
            fixedPortals.All(item => item.Role.SpriteID > 0) &&
            orderedIds.Zip(orderedIds.Skip(1), (first, second) => second - first).All(delta => delta == 1) &&
            fixedPortals.Chunk(2).All(pair => portalRooms.TryGetValue(pair[0].Cell, out var first) &&
                portalRooms.TryGetValue(pair[1].Cell, out var second) && first.Count > 0 &&
                second.Count > 0 && !first.Overlaps(second));
        if (completeSequence)
        {
            foreach (var pair in fixedPortals.Chunk(2))
            {
                var first = pair[0].Cell;
                var second = pair[1].Cell;
                if (used.Contains(first) || used.Contains(second)) continue;
                result[first] = second;
                result[second] = first;
                used.Add(first);
                used.Add(second);
            }
        }

        // 无完整序号时保留原有朝向与距离推断，但只在两扇门互相指向对方房间时配对。
        if (!completeSequence)
        {
            var rooms = regions.GroupBy(item => item.Value)
                .ToDictionary(group => group.Key, group => group.Select(item => item.Key).ToArray());
            var directions = new[] { new Cell(1, 0), new Cell(-1, 0), new Cell(0, 1), new Cell(0, -1) };
            int? PreferredRoom(Cell portal)
            {
                if (!portalRooms.TryGetValue(portal, out var adjacent) || adjacent.Count == 0) return null;
                var inward = directions.Where(step => regions.TryGetValue(
                    new Cell(portal.X + step.X, portal.Y + step.Y), out var room) && adjacent.Contains(room)).ToArray();
                var outwardX = -inward.Sum(step => step.X);
                var outwardY = -inward.Sum(step => step.Y);
                var choices = rooms.Where(room => !adjacent.Contains(room.Key)).Select(room =>
                {
                    var facing = room.Value.Where(cell =>
                        (cell.X - portal.X) * outwardX + (cell.Y - portal.Y) * outwardY > 0).ToArray();
                    var nearest = (facing.Length > 0 ? facing : room.Value).Min(cell =>
                        Math.Abs(cell.X - portal.X) + Math.Abs(cell.Y - portal.Y));
                    return (room.Key, Facing: facing.Length > 0, Distance: nearest);
                }).OrderByDescending(choice => choice.Facing).ThenBy(choice => choice.Distance)
                  .ThenBy(choice => choice.Key).ToArray();
                return choices.Length > 0 ? choices[0].Key : null;
            }
            var free = fixedPortals.Select(item => item.Cell).Where(cell => !used.Contains(cell)).ToArray();
            var preferred = free.ToDictionary(cell => cell, PreferredRoom);
            var candidates = (from i in Enumerable.Range(0, free.Length)
                              from j in Enumerable.Range(i + 1, free.Length - i - 1)
                              let first = free[i]
                              let second = free[j]
                              where portalRooms[first].Count > 0 && portalRooms[second].Count > 0 &&
                                  !portalRooms[first].Overlaps(portalRooms[second]) &&
                                  preferred[first] == portalRooms[second].Min() &&
                                  preferred[second] == portalRooms[first].Min()
                              select (First: first, Second: second,
                                  Distance: Math.Abs(first.X - second.X) + Math.Abs(first.Y - second.Y)))
                .OrderBy(pair => pair.Distance).ToArray();
            foreach (var pair in candidates)
            {
                if (used.Contains(pair.First) || used.Contains(pair.Second)) continue;
                result[pair.First] = pair.Second;
                result[pair.Second] = pair.First;
                used.Add(pair.First);
                used.Add(pair.Second);
            }
        }
        // 单向的固定门连接也可作为反向配对线索。若目标门已有自己的落点，
        // 或有多扇门同时指向它，则保留现状，避免覆盖或猜测冲突关系。
        var incoming = result.Where(pair => fixedCells.Contains(pair.Value) && pair.Key != pair.Value)
            .GroupBy(pair => pair.Value).ToArray();
        foreach (var group in incoming)
        {
            if (group.Count() != 1 || result.ContainsKey(group.Key)) continue;
            var source = group.Single().Key;
            if (!portalRooms.TryGetValue(source, out var sourceRooms) ||
                !portalRooms.TryGetValue(group.Key, out var targetRooms) ||
                sourceRooms.Count == 0 || targetRooms.Count == 0 || sourceRooms.Overlaps(targetRooms)) continue;
            result[group.Key] = source;
        }
        return result;
    }

    public bool IsConfirmedConnection(MapDump map, Cell source, Cell destination)
        => confirmedFixedPairs.TryGetValue(KeyOf(map), out var pairs) &&
           pairs.TryGetValue(source, out var paired) && paired == destination;

    /// <summary>为尚未配对的固定门提供房间预测，供地图和寻路使用。</summary>
    public IReadOnlyDictionary<Cell, Cell> PredictedRoomConnections(MapDump map)
    {
        var connected = ConnectedRooms(map);
        var (rooms, portalRooms, regions) = PortalRouting.RoomLayout(map);
        var portals = PortalRouting.Enumerate(map)
            .Where(item => PortalRouting.IsRoomToRoom(item.Role) && !item.Role.IsRandomTransfer)
            .Select(item => item.Cell).Distinct().ToArray();
        var directions = new[] { new Cell(1, 0), new Cell(-1, 0), new Cell(0, 1), new Cell(0, -1) };
        var result = new Dictionary<Cell, Cell>();
        foreach (var source in portals)
        {
            if (connected.ContainsKey(source) || !portalRooms.TryGetValue(source, out var sourceRooms) || sourceRooms.Count == 0)
                continue;
            var inward = directions.Where(step => regions.TryGetValue(
                new Cell(source.X + step.X, source.Y + step.Y), out var room) && sourceRooms.Contains(room)).ToArray();
            var outwardX = -inward.Sum(step => step.X);
            var outwardY = -inward.Sum(step => step.Y);
            if (outwardX == 0 && outwardY == 0) continue;

            var alreadyConnected = connected.Where(pair => portalRooms.TryGetValue(pair.Key, out var origin) &&
                    origin.Overlaps(sourceRooms))
                .SelectMany(pair => portalRooms.TryGetValue(pair.Value, out var target) ? target.AsEnumerable() :
                    regions.TryGetValue(pair.Value, out var targetRoom) ? [targetRoom] : Enumerable.Empty<int>())
                .ToHashSet();
            var target = rooms.Where(room => !sourceRooms.Contains(room.Key) && !alreadyConnected.Contains(room.Key))
                .Select(room => room.Value.Where(cell =>
                    (cell.X - source.X) * outwardX + (cell.Y - source.Y) * outwardY > 0)
                    .OrderBy(cell => Math.Abs(cell.X - source.X) + Math.Abs(cell.Y - source.Y))
                    .ThenBy(cell => cell.X).ThenBy(cell => cell.Y).Select(cell => (Cell?)cell).FirstOrDefault())
                .Where(cell => cell.HasValue).Select(cell => cell!.Value)
                .OrderBy(cell => Math.Abs(cell.X - source.X) + Math.Abs(cell.Y - source.Y))
                .ThenBy(cell => cell.X).ThenBy(cell => cell.Y).ToArray();
            if (target.Length > 0) result[source] = target[0];
        }
        return result;
    }

    /// <summary>实际落点优先，其次配对门，最后使用朝向和距离预测目标房间。</summary>
    public IReadOnlyCollection<Cell> CandidateTargets(MapDump map, Cell source, RoleInfo role)
    {
        if (!PortalRouting.IsRoomToRoom(role)) return Array.Empty<Cell>();
        var observed = ObservedTargets(map, source);
        if (observed.Count > 0) return observed;
        if (role.IsRandomTransfer) return Array.Empty<Cell>();
        if (ConnectedRooms(map).TryGetValue(source, out var roomCell)) return [roomCell];
        return PredictedRoomConnections(map).TryGetValue(source, out var predictedRoom)
            ? [predictedRoom] : Array.Empty<Cell>();
    }

    public int EdgeCount(MapDump map)
        => edges.TryGetValue(KeyOf(map), out var fromEdges) ? fromEdges.Values.Sum(set => set.Count) : 0;
}

public readonly record struct PortalUnlockObservation(Cell Portal, IReadOnlyCollection<Cell> DefeatedMonsters);

/// <summary>
/// 记录客户端唯一可观察的解锁依赖：锁定的门在后续地图快照中变为可用，
/// 同时一个或多个普通怪物节点消失。服务器消息携带的是门解锁，而不是稳定的
/// 怪物到门的 ID，因此此处有意基于证据判断。
/// </summary>
public sealed class PortalUnlockGraph
{
    readonly Dictionary<PortalMapKey, Dictionary<Cell, HashSet<Cell>>> requirements = [];

    public void Clear() => requirements.Clear();

    public IReadOnlyList<PortalUnlockObservation> Observe(MapDump before, MapDump after)
    {
        if (PortalJumpGraph.KeyOf(before) != PortalJumpGraph.KeyOf(after)) return [];
        var oldLocked = PortalRouting.Enumerate(before)
            .Where(item => item.Role.Locked)
            .Select(item => item.Cell).ToHashSet();
        var newlyUnlocked = PortalRouting.Enumerate(after)
            .Where(item => !item.Role.Locked && oldLocked.Contains(item.Cell))
            .Select(item => item.Cell).ToHashSet();
        if (newlyUnlocked.Count == 0) return [];

        var beforeMonsters = MonsterCells(before);
        var afterMonsters = MonsterCells(after);
        var defeated = beforeMonsters.Except(afterMonsters).ToArray();
        if (defeated.Length == 0) return [];

        var mapKey = PortalJumpGraph.KeyOf(after);
        if (!requirements.TryGetValue(mapKey, out var mapRequirements))
            requirements[mapKey] = mapRequirements = [];
        var observations = new List<PortalUnlockObservation>();
        foreach (var portal in newlyUnlocked)
        {
            if (!mapRequirements.TryGetValue(portal, out var monsters))
                mapRequirements[portal] = monsters = [];
            foreach (var monster in defeated) monsters.Add(monster);
            observations.Add(new PortalUnlockObservation(portal, defeated));
        }
        return observations;
    }

    public IReadOnlyCollection<Cell> RequiredMonsters(MapDump map, Cell portal)
        => requirements.TryGetValue(PortalJumpGraph.KeyOf(map), out var mapRequirements) &&
           mapRequirements.TryGetValue(portal, out var monsters)
            ? monsters.ToArray() : Array.Empty<Cell>();

    static HashSet<Cell> MonsterCells(MapDump map)
        => map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles
            .Where(role => role.ClassName == "MonsterData" && role.NormalMonster)
            .Select(_ => new Cell(tile.X, tile.Y))).ToHashSet();
}
