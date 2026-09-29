namespace AdbMapController;

/// <summary>
/// 以与游戏 MiniMap:onUpdateView 相同的方式格式化地图标题。
/// 游戏根据 MapData.sceneType 而不是 caveMode 决定是否追加楼层：
/// 只有 SCENE_TYPE.CAVE（2）会获得楼层后缀。
/// </summary>
public static class MapDisplayName
{
    const int CaveSceneType = 2;
    const int HeroInterval = 30;

    // 来自 PublicDefine.CAVE_MODE 的值。它们对应 MiniMap:onUpdateView 使用的
    // SceneManager 状态。
    const int HeroMode = 4;
    const int TrialLandMode = 15;
    const int EverWinterMode = 17;
    const int TitanHeroMode = 19;
    const int WormholeMode = 24;

    public static string Format(MapDump map)
    {
        var name = string.IsNullOrWhiteSpace(map.MapName) ? "--" : map.MapName.Trim();
        if (map.SceneType != CaveSceneType) return name;

        var level = DisplayLevel(map.Level, map.CaveMode);
        // UI.TEXT_DES_MINI_MAP_LEVEL 在游戏中文本地化中是“%s层”；
        // MiniMap 使用“%s:%s”（没有 BigMap 使用的空格）。
        return $"{name}:{level}层";
    }

    public static int DisplayLevel(int level, int caveMode)
    {
        return caveMode switch
        {
            HeroMode or TitanHeroMode => Normalize(level, HeroInterval, HeroInterval),
            TrialLandMode => Normalize(level, 10, 10),
            // 源码使用 math.ceil(level % 10)，对游戏导出的整数楼层不起作用。
            // 特别是 10 在此处显示为 0；与 TrialLand 不同，不会改为 10。
            EverWinterMode or WormholeMode => Modulo(level, 10),
            _ => level,
        };
    }

    static int Normalize(int level, int divisor, int zeroValue)
    {
        var value = Modulo(level, divisor);
        return value == 0 ? zeroValue : value;
    }

    // Lua 在除数为正时的 % 结果非负，不同于 C# 对负被除数的 %。
    // 正常游戏楼层为正数，但在此匹配 Lua 行为，可以让格式化器对格式错误/旧版快照保持确定性。
    static int Modulo(int value, int divisor) => ((value % divisor) + divisor) % divisor;
}
