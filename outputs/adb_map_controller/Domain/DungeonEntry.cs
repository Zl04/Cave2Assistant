using System.Collections.Generic;
using System.Linq;

namespace AdbMapController;

public sealed record DungeonMapOption(
    int Id,
    string Name,
    bool UsesSharedEntrance,
    IReadOnlyList<DungeonDifficulty>? AvailableDifficulties = null,
    int? TemplateOverrideId = null)
{
    public IReadOnlyList<DungeonDifficulty> Difficulties => AvailableDifficulties ?? DungeonEntryCatalog.AllDifficulties;
    public bool SupportsDifficulty => Difficulties.Count > 1;
    public bool IsTimeGate => Id is DungeonEntryCatalog.TimeGateMapId or DungeonEntryCatalog.TimeGateHeroMapId;
    public bool IsHeroVariant => Id == DungeonEntryCatalog.TimeGateHeroMapId;
    public int TemplateId => TemplateOverrideId ?? (UsesSharedEntrance ? DungeonEntryCatalog.SharedEntranceMapId : Id);
}

public sealed record DungeonEntryOption(int Id, string Name);

public enum DungeonDifficulty
{
    Normal,
    Elite,
    Nightmare,
}

public sealed record DungeonEntrySelection(int MapId, int EntryId, DungeonDifficulty Difficulty = DungeonDifficulty.Normal)
{
    // 保留旧调用方的构造方式，旧的勾选项只对应精英难度。
    public DungeonEntrySelection(int mapId, int entryId, bool eliteMode)
        : this(mapId, entryId, eliteMode ? DungeonDifficulty.Elite : DungeonDifficulty.Normal) { }

    public bool EliteMode => Difficulty == DungeonDifficulty.Elite;
    public DungeonMapOption Map => DungeonEntryCatalog.MapOrDefault(MapId);
    public DungeonEntryOption Entry => DungeonEntryCatalog.EntryOrDefault(MapId, EntryId);
}

/// <summary>
/// 当前巴萨坦 UI 中观察到的入口。
///
/// 三张特殊地图有意使用独立地图 ID 供用户选择，但 UsesSharedEntrance 告诉自动化：
/// 它们都从同一个城镇图标开始，并且首先需要执行页面内的地图卡片切换。
/// EntryId 是每张地图的序号，与 APK 的“入口选择”设置一致。
/// </summary>
public static class DungeonEntryCatalog
{
    public const int TimeGateMapId = 0;
    public const int SharedEntranceMapId = 2;
    public const int TimeGateHeroMapId = 6;

    static readonly IReadOnlyList<DungeonDifficulty> NoDifficulty = [];
    static readonly IReadOnlyList<DungeonDifficulty> StandardDifficulties =
        [DungeonDifficulty.Normal, DungeonDifficulty.Elite];
    internal static readonly IReadOnlyList<DungeonDifficulty> AllDifficulties =
        [DungeonDifficulty.Normal, DungeonDifficulty.Elite, DungeonDifficulty.Nightmare];

    public static readonly IReadOnlyList<DungeonMapOption> Maps =
    [
        new(TimeGateMapId, "时光之门", false, NoDifficulty),
        new(TimeGateHeroMapId, "时光之门(英雄)", false, NoDifficulty, TimeGateMapId),
        new(1, "沙之眼", false, NoDifficulty),
        new(2, "扭曲空间", true, StandardDifficulties),
        new(3, "元素炼狱", true),
        new(4, "虚空秘境", true),
        new(5, "原初试炼", false)
    ];

    static readonly IReadOnlyDictionary<int, IReadOnlyList<DungeonEntryOption>> entries =
        new Dictionary<int, IReadOnlyList<DungeonEntryOption>>
        {
            [TimeGateMapId] =
            [
                new(1, "1层"), new(2, "11层"), new(3, "21层"), new(4, "31层"),
                new(5, "41层"), new(6, "51层"), new(7, "61层"), new(8, "71层"),
                new(9, "81层"), new(10, "91层"), new(11, "101层"), new(12, "111层"),
                new(13, "121层"), new(14, "131层"), new(15, "141层"), new(16, "151层"),
                new(17, "161层"), new(18, "171层")
            ],
            [1] = [new(1, "1层"), new(2, "11层"), new(3, "21层")],
            [2] = [new(1, "1层"), new(2, "11层"), new(3, "21层"), new(4, "31层"), new(5, "41层"), new(6, "51层"), new(7, "61层")],
            [3] = [new(1, "1层"), new(2, "11层"), new(3, "21层"), new(4, "31层"), new(5, "41层")],
            [4] = [new(1, "1层"), new(2, "11层")],
            [5] = Enumerable.Range(0, 1)
                .Select(index => new DungeonEntryOption(index + 1, $"{index * 10 + 1}层"))
                .ToArray(),
            [TimeGateHeroMapId] =
            [
                new(1, "图一[遗忘之穴]"),
                new(2, "图二[巨石旷野]"),
                new(3, "图三[淤泥回廊]"),
                new(4, "图四[大裂缝]"),
                new(5, "图五[旧神庇护所]"),
                new(6, "图六[幽魂废都]")
            ]
        };

    public static IReadOnlyList<DungeonEntryOption> EntriesForMap(int mapId)
        => entries.TryGetValue(mapId, out var value) ? value : entries[0];

    public static DungeonMapOption MapOrDefault(int id)
        => Maps.FirstOrDefault(x => x.Id == id) ?? Maps[0];

    public static DungeonEntryOption EntryOrDefault(int mapId, int id)
    {
        var options = EntriesForMap(mapId);
        return options.FirstOrDefault(x => x.Id == id) ?? options[0];
    }

    // 为使用历史共用入口目录（地图 2）的调用方提供兼容性重载。
    public static DungeonEntryOption EntryOrDefault(int id)
        => EntryOrDefault(SharedEntranceMapId, id);
}
