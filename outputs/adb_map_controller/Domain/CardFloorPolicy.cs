using System;

namespace AdbMapController;

/// <summary>
/// 根据当前地图和楼层计算“卡层”的临时指定层。
/// 特殊地图的入口名称代表区间起点，因此卡层目标不能直接取入口编号。
/// </summary>
public static class CardFloorPolicy
{
    // PublicDefine.CAVE_MODE values exported by the Lua assistant.
    const int NormalTimeGate = 1;
    const int HeroTimeGate = 4;
    const int SandEye = 8;
    const int DistortedSpace = 9;
    const int ElementalInferno = 12;
    const int VoidRift = 14;

    public static int? Resolve(string? mapName, int currentFloor)
        => Resolve(-1, mapName, currentFloor);

    public static int? Resolve(MapDump map)
        => Resolve(map.CaveMode, map.MapName, map.Level);

    static int? Resolve(int caveMode, string? mapName, int currentFloor)
    {
        if (currentFloor <= 0) return null;

        var normalized = mapName?.Trim() ?? "";
        if (caveMode is HeroTimeGate) return 30;
        if (caveMode is NormalTimeGate) return 180;

        var maximum = caveMode switch
        {
            SandEye => 30,
            DistortedSpace => 70,
            ElementalInferno => 50,
            VoidRift => 20,
            _ => 0,
        };
        if (maximum == 0) return null;

        var decade = ((currentFloor + 9) / 10) * 10;
        return Math.Min(decade, maximum);
    }

}
