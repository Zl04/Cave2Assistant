namespace AdbMapController;

/// <summary>
/// 地图楼型对应的导航策略。
///
/// 游戏把特殊房间也放在 MapData.Level 中。6101 是“奇怪的房间”，
/// 它不是普通洞窟楼层：进入后只需要寻找房间里的怪物并战斗，
/// 不应该被通用的探索、宝箱或下楼规划接管。
/// </summary>
public enum FloorPlanningMode
{
    Standard,
    MonsterHunt
}

public static class FloorPlanningPolicy
{
    public const int MonsterHuntRoomLevel = 6101;

    public static FloorPlanningMode Resolve(MapDump map)
        => map.Level == MonsterHuntRoomLevel
            ? FloorPlanningMode.MonsterHunt
            : FloorPlanningMode.Standard;

    public static bool IsMonsterHuntRoom(MapDump map)
        => Resolve(map) == FloorPlanningMode.MonsterHunt;

    public static bool IncludeAllInteractions(MapDump map)
        => CardFloorPolicy.MaximumFloor(map) is { } maximum && map.Level > maximum;

    public static bool IsMonster(RoleInfo role)
        => role.ClassName == "MonsterData" && role.Kind is "小怪" or "群怪" or "精英" or "小Boss" or "Boss";
}
