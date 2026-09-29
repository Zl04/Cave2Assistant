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
    public const int RoomToRoomTransdoorType = 3;

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

    public static Cell? NearestRoomPortal(MapDump map, Cell origin, int maxDistance = 1)
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
    /// 对随机房间传送门，在服务器响应让我们得知更小的边集合前，
    /// 其它每个房间传送门都是有效的静态候选。
    /// 固定房间传送门没有客户端可见的目标，因此只返回观察到的目的地。
    /// </summary>
    public IReadOnlyCollection<Cell> CandidateTargets(MapDump map, Cell source, RoleInfo role)
    {
        var observed = ObservedTargets(map, source);
        if (observed.Count > 0) return observed;
        if (!PortalRouting.IsRandomRoomPortal(role)) return Array.Empty<Cell>();
        return PortalRouting.RoomPortalCells(map).Where(cell => cell != source).ToArray();
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
