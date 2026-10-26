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

    /// <summary>
    /// 不穿过传送门，对可行走格划分房间。门旁属于同一连通区域的门在同一个房间。
    /// </summary>
    public static IReadOnlyDictionary<Cell, HashSet<int>> RoomRegionsOfPortals(MapDump map)
    {
        var tiles = map.ByCell;
        var portalCells = Enumerate(map).Where(item => IsRoomToRoom(item.Role))
            .Select(item => item.Cell).ToHashSet();
        var regions = new Dictionary<Cell, int>();
        var directions = new[] { new Cell(1, 0), new Cell(-1, 0), new Cell(0, 1), new Cell(0, -1) };
        var region = 0;
        foreach (var (cell, tile) in tiles)
        {
            if (!tile.Walkable || portalCells.Contains(cell) || regions.ContainsKey(cell)) continue;
            var pending = new Queue<Cell>();
            pending.Enqueue(cell);
            regions[cell] = region;
            while (pending.TryDequeue(out var current))
                foreach (var direction in directions)
                {
                    var next = new Cell(current.X + direction.X, current.Y + direction.Y);
                    if (regions.ContainsKey(next) || portalCells.Contains(next) ||
                        !tiles.TryGetValue(next, out var neighbour) || !neighbour.Walkable) continue;
                    regions[next] = region;
                    pending.Enqueue(next);
                }
            region++;
        }
        return portalCells.ToDictionary(portal => portal, portal => directions
            .Select(direction => new Cell(portal.X + direction.X, portal.Y + direction.Y))
            .Where(regions.ContainsKey).Select(cell => regions[cell]).ToHashSet());
    }

    /// <summary>只在不同房间的门之间按距离配对；每扇门最多属于一对。</summary>
    public static IReadOnlyDictionary<Cell, Cell> NearestRoomPortalPairs(MapDump map)
    {
        var portals = Enumerate(map).Where(item => IsRoomToRoom(item.Role)).Select(item => item.Cell)
            .Distinct().OrderBy(cell => cell.X).ThenBy(cell => cell.Y).ToArray();
        var portalRegions = RoomRegionsOfPortals(map);
        var pairs = new Dictionary<Cell, Cell>();
        var candidates = (from first in Enumerable.Range(0, portals.Length)
                          from second in Enumerable.Range(first + 1, portals.Length - first - 1)
                          where portalRegions[portals[first]].Count > 0 && portalRegions[portals[second]].Count > 0 &&
                                !portalRegions[portals[first]].Overlaps(portalRegions[portals[second]])
                          select (First: portals[first], Second: portals[second],
                              Distance: Math.Abs(portals[first].X - portals[second].X) +
                                        Math.Abs(portals[first].Y - portals[second].Y)))
            .OrderBy(pair => pair.Distance).ThenBy(pair => pair.First.X).ThenBy(pair => pair.First.Y)
            .ThenBy(pair => pair.Second.X).ThenBy(pair => pair.Second.Y);
        foreach (var pair in candidates)
        {
            if (pairs.ContainsKey(pair.First) || pairs.ContainsKey(pair.Second)) continue;
            pairs[pair.First] = pair.Second;
            pairs[pair.Second] = pair.First;
        }
        return pairs;
    }

    public static Cell? NearestRoomPortal(MapDump map, Cell origin, int maxDistance = 2)
    {
        var candidates = RoomPortalCells(map)
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

    public void Clear() => edges.Clear();

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
        var candidate = PortalRouting.NearestRoomPortal(after, afterPlayer);
        if (candidate is null || candidate.Value == source) return false;
        destination = candidate.Value;
        var mapKey = KeyOf(after);
        if (!edges.TryGetValue(mapKey, out var fromEdges))
            edges[mapKey] = fromEdges = [];
        if (!fromEdges.TryGetValue(source, out var targets))
            fromEdges[source] = targets = [];
        targets.Add(destination);
        return true;
    }

    public IReadOnlyCollection<Cell> ObservedTargets(MapDump map, Cell source)
        => edges.TryGetValue(KeyOf(map), out var fromEdges) && fromEdges.TryGetValue(source, out var targets)
            ? targets.ToArray() : Array.Empty<Cell>();

    /// <summary>
    /// 已观测的目标优先；未观测时采用距离最近的互斥配对作为推断目标。
    /// </summary>
    public IReadOnlyCollection<Cell> CandidateTargets(MapDump map, Cell source, RoleInfo role)
    {
        var observed = ObservedTargets(map, source);
        if (observed.Count > 0) return observed;
        if (!PortalRouting.IsRoomToRoom(role)) return Array.Empty<Cell>();
        var pairs = PortalRouting.NearestRoomPortalPairs(map);
        return pairs.TryGetValue(source, out var target) ? [target] : Array.Empty<Cell>();
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
