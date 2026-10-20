using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Text.Json;
using System.Collections.Concurrent;

namespace AdbMapController;

public readonly record struct Cell(int X, int Y);

/// <summary>
/// JSON 解码诊断信息。无效字段仍会规范化为现有默认值，
/// 因此格式错误的导出快照不会中断控制。
/// UI 会在每次读取快照后清空此队列，并决定如何记录日志。
/// </summary>
public static class JsonDiagnostics
{
    static readonly ConcurrentQueue<string> Errors = new();
    public static void Record(string field, string detail)
    {
        var text = $"{field}: {detail}";
        Errors.Enqueue(text.Length <= 512 ? text : text[..512]);
        while (Errors.Count > 128) Errors.TryDequeue(out _);
    }
    public static IReadOnlyList<string> Drain()
    {
        var result = new List<string>();
        while (Errors.TryDequeue(out var error)) result.Add(error);
        return result;
    }
}

public sealed class PlayerInfo { public int X { get; set; } public int Y { get; set; } }

public sealed class RoleInfo
{
    public int SpriteID { get; set; }
    public int TemplateID { get; set; } = -1;
    public int RoleType { get; set; }
    public int MinimapType { get; set; }
    // TriggerNpcData 通过 getTransdoorType() 和 getIsRandomTransfer() 暴露这两个值。
    // 使用 -1 可以让旧版辅助程序生成的快照与游戏的 INVALID_TRANS_DOOR=0 值区分开。
    public int TransdoorType { get; set; } = -1;
    public bool IsRandomTransfer { get; set; }
    public int TreasureType { get; set; }
    public int OccupyWidth { get; set; } = 1;
    public int OccupyHeight { get; set; } = 1;
    public int TalkRange { get; set; }
    public bool Locked { get; set; }
    public bool MasterHero { get; set; }
    public bool BigBoss { get; set; }
    public bool SmallBoss { get; set; }
    public bool EliteMonster { get; set; }
    public bool NormalMonster { get; set; }
    public bool GroupMonster { get; set; }
    public bool Opened { get; set; }
    public string ClassName { get; set; } = "";

    // 神秘商人地图中的 Boss 直达 NPC；与商人同为功能 NPC，但使用独立的小地图类型。
    [JsonIgnore] public bool IsDirectBossNpc => ClassName == "TriggerNpcData" &&
        RoleType == 7 && MinimapType == 42 && TreasureType == 39;

    public string Kind
    {
        get
        {
            if (Opened && ClassName == "TriggerNpcData" && RoleType is 2 or 3 or 8) return "";
            if (IsDirectBossNpc) return "直接挑战Boss NPC";
            if (MapIconCatalog.TryGetKind(this, out var mapKind)) return mapKind;
            return ClassName switch
            {
                "MonsterData" when BigBoss => "Boss",
                "MonsterData" when SmallBoss => "小Boss",
                "MonsterData" when EliteMonster => "精英",
                "MonsterData" when GroupMonster => "群怪",
                "MonsterData" when NormalMonster => "小怪",
                "TriggerNpcData" when RoleType == 2 && TreasureType == 1 => "罐子",
                "TriggerNpcData" when RoleType == 2 && TreasureType == 2 => "石堆",
                "TriggerNpcData" when RoleType == 2 && TreasureType == 3 => "木箱",
                "TriggerNpcData" when RoleType == 2 && TreasureType == 4 => "金箱",
                // 特殊宝箱：该类型可能不在游戏小地图绘制图标，但仍由运行时
                // 以 TriggerNpcData/treasureType=6 下发；界面统一使用金箱图标。
                "TriggerNpcData" when RoleType == 2 && TreasureType == 6 => "金箱",
                "TriggerNpcData" when RoleType == 3 => "金币",
                "TriggerNpcData" when RoleType == 12 => "陷阱",
                "TriggerNpcData" when RoleType == 18 => "钥匙",
                // 密室节点由运行时直接下发：普通密室入口使用 type=4，机关密室入口
                // 使用 type=6；两者 minimap 均为 1001。机关触发点使用 type=5，
                // 游戏小地图对触发点不绘制图标。
                "TriggerNpcData" when RoleType is 4 or 6 && MinimapType == 1001 => "密室",
                "TriggerNpcData" when RoleType == 5 => "机关",
                "TriggerNpcData" when RoleType == 8 && MinimapType == 5 => "符文",
                "MonsterData" or "TriggerNpcData" => "未知",
                _ => ""
            };
        }
    }
}

/// <summary>
/// 由角色占据的次级地图格，而该角色的实际数据位于关联坐标处。
/// 游戏使用这些占位格表示多格 NPC、陷阱、怪物和 NPC 对话范围。
/// </summary>
public sealed class MapPlaceholderInfo
{
    public string TypeName { get; set; } = "";
    public int AssociatedID { get; set; }
    public int AssociatedX { get; set; } = -1;
    public int AssociatedY { get; set; } = -1;
    public bool Reachable { get; set; }
    public bool NodeOfPath { get; set; }
    public bool EndOfPath { get; set; }

    [JsonIgnore] public bool IsTriggerNpc => TypeName == "trigger_npc";
    [JsonIgnore] public Cell? AssociatedCell => AssociatedX >= 0 && AssociatedY >= 0
        ? new Cell(AssociatedX, AssociatedY) : null;
}

/// <summary>
/// MapTownView 根据 ConfigManager 的 iconMap 放置的城镇地图图标。
/// 其显示位置可能不同于角色的逻辑地图格。
/// </summary>
public sealed class TownIconInfo
{
    public int X { get; set; } = -1;
    public int Y { get; set; } = -1;
    public int SpriteID { get; set; }
    public int TemplateID { get; set; } = -1;
    public int RoleType { get; set; }
    public int MinimapType { get; set; }
    public int TreasureType { get; set; }
    public bool Opened { get; set; }
    public string ClassName { get; set; } = "";

    [JsonIgnore] public bool HasPosition => X >= 0 && Y >= 0;
    public bool Matches(RoleInfo role) =>
        (SpriteID != 0 && role.SpriteID == SpriteID) ||
        (TemplateID >= 0 && role.TemplateID == TemplateID);

    public RoleInfo ToRoleInfo() => new()
    {
        SpriteID = SpriteID,
        TemplateID = TemplateID,
        RoleType = RoleType,
        MinimapType = MinimapType,
        TreasureType = TreasureType,
        Opened = Opened,
        ClassName = ClassName,
    };
}

[JsonConverter(typeof(TileInfoConverter))]
public sealed class TileInfo
{
    public int X { get; set; }
    public int Y { get; set; }
    public int TerrainType { get; set; }
    public bool Explored { get; set; }
    public bool Reached { get; set; }
    public bool Reachable { get; set; }
    public List<RoleInfo> Roles { get; set; } = [];
    public List<MapPlaceholderInfo> Placeholders { get; set; } = [];
    [JsonIgnore] public bool Ground => TerrainType == 0;
    [JsonIgnore] public bool Walkable => TerrainType == 0 && Reachable;
}

public sealed class FlexibleIntConverter : JsonConverter<int>
{
    public override int Read(ref Utf8JsonReader reader, Type type, JsonSerializerOptions options)
    {
        if (reader.TokenType == JsonTokenType.Number)
        {
            if (reader.TryGetInt32(out var value)) return value;
            if (reader.TryGetInt64(out var wide))
            {
                JsonDiagnostics.Record("int", $"数值超出 Int32，已截断为默认值 0（原值 {wide}）");
                return 0;
            }
        }
        else if (reader.TokenType == JsonTokenType.String && int.TryParse(reader.GetString(), out var textValue)) return textValue;
        else if (reader.TokenType == JsonTokenType.True) return 1;
        JsonDiagnostics.Record("int", $"不支持的 JSON 类型 {reader.TokenType}，已修正为默认值 0");
        return 0;
    }
    public override void Write(Utf8JsonWriter writer, int value, JsonSerializerOptions options) => writer.WriteNumberValue(value);
}

public sealed class TileInfoConverter : JsonConverter<TileInfo>
{
    public override TileInfo Read(ref Utf8JsonReader reader, Type type, JsonSerializerOptions options)
    {
        if (reader.TokenType is JsonTokenType.False or JsonTokenType.Null) return new TileInfo { TerrainType = 1 };
        using var document = JsonDocument.ParseValue(ref reader); var root = document.RootElement;
        int I(string name, int fallback = 0)
        {
            if (!root.TryGetProperty(name, out var p)) return fallback;
            if (p.ValueKind == JsonValueKind.Number && p.TryGetInt32(out var value)) return value;
            if (p.ValueKind == JsonValueKind.String && int.TryParse(p.GetString(), out value)) return value;
            JsonDiagnostics.Record($"tile.{name}", $"类型为 {p.ValueKind}，已修正为默认值 {fallback}");
            return fallback;
        }
        bool B(string name)
        {
            if (!root.TryGetProperty(name, out var p)) return false;
            if (p.ValueKind == JsonValueKind.True) return true;
            if (p.ValueKind == JsonValueKind.False) return false;
            JsonDiagnostics.Record($"tile.{name}", $"类型为 {p.ValueKind}，已修正为默认值 false");
            return false;
        }
        var tile = new TileInfo { X = I("x"), Y = I("y"), TerrainType = I("terrainType", 1), Explored = B("explored"), Reached = B("reached"), Reachable = B("reachable") };
        if (root.TryGetProperty("roles", out var roles))
        {
            if (roles.ValueKind == JsonValueKind.Array)
            {
                try { tile.Roles = JsonSerializer.Deserialize<List<RoleInfo>>(roles.GetRawText(), options) ?? []; }
                catch (JsonException ex)
                {
                    JsonDiagnostics.Record("tile.roles", $"角色数组解析失败，已使用空数组（{ex.Message}）");
                    tile.Roles = [];
                }
            }
            else JsonDiagnostics.Record("tile.roles", $"类型为 {roles.ValueKind}，已修正为空数组");
        }
        if (root.TryGetProperty("placeholders", out var placeholders))
        {
            if (placeholders.ValueKind == JsonValueKind.Array)
            {
                try { tile.Placeholders = JsonSerializer.Deserialize<List<MapPlaceholderInfo>>(placeholders.GetRawText(), options) ?? []; }
                catch (JsonException ex)
                {
                    JsonDiagnostics.Record("tile.placeholders", $"占位数组解析失败，已使用空数组（{ex.Message}）");
                    tile.Placeholders = [];
                }
            }
            else JsonDiagnostics.Record("tile.placeholders", $"类型为 {placeholders.ValueKind}，已修正为空数组");
        }
        return tile;
    }
    public override void Write(Utf8JsonWriter writer, TileInfo value, JsonSerializerOptions options) => throw new NotSupportedException();
}

public sealed class MapDump
{
    public int Width { get; set; }
    public int Height { get; set; }
    public int Level { get; set; }
    public int TownMapId { get; set; }
    // SceneType=1 是城镇地图路径（MapTownView）。保留 CaveMode 供未来地图变体使用，
    // 也用于诊断转场。
    public int SceneType { get; set; } = -1;
    public int CaveMode { get; set; } = -1;
    // 通过游戏的 LanguageManager 从 MapData:getTitle() 导出的本地化地图标题。
    // 旧版辅助程序的快照可能没有此字段。
    public string MapName { get; set; } = "";
    public long Timestamp { get; set; }
    public PlayerInfo Player { get; set; } = new();
    public bool InBattle { get; set; }
    public bool IsDead { get; set; }
    public bool Confused { get; set; }
    public bool Reversed { get; set; }
    // 游戏拥有的迷雾状态。这是 MapData.ISeeDeadPeople 的序列化形式，
    // 不是控制器维护的访问集合。
    // 为 true 时，所有可通行格对玩家都已可见，即使每格的 hasExplored 缓存尚未填充。
    public bool AllExplored { get; set; }
    public List<int> ConfuseDirections { get; set; } = [];
    public BossSealInfo BossSeal { get; set; } = new();
    public List<TownIconInfo> TownIcons { get; set; } = [];
    public List<List<TileInfo>> Tiles { get; set; } = [];
    [JsonIgnore] public Dictionary<Cell, TileInfo> ByCell => Tiles.SelectMany(x => x).ToDictionary(t => new Cell(t.X, t.Y));

    public Cell ResolveInteractiveCell(Cell cell)
    {
        if (!ByCell.TryGetValue(cell, out var tile)) return cell;
        var placeholder = tile.Placeholders.FirstOrDefault(value => value.IsTriggerNpc && value.AssociatedCell is not null);
        if (placeholder?.AssociatedCell is { } associatedCell) return associatedCell;

        // MapTownView 可能将可见图标放在 ConfigManager.iconMap 的位置，
        // 而不是角色的逻辑地图格。将该显示坐标解析回包含角色的地图格。
        var townIcon = SceneType == 1
            ? TownIcons.FirstOrDefault(value => value.X == cell.X && value.Y == cell.Y)
            : null;
        if (townIcon is not null)
        {
            var match = ByCell.FirstOrDefault(pair => pair.Value.Roles.Any(townIcon.Matches));
            if (match.Value is not null) return match.Key;
        }
        return cell;
    }

    /// <summary>
    /// 根据游戏拥有的探索信号规范化控制器视图。
    /// ISeeDeadPeople/allExplored 表示整张地图禁用迷雾；reached 是服务器同步的已访问区域位。
    /// 不涉及控制器维护的访问集合。
    /// </summary>
    public void ApplyGameExplorationState()
    {
        foreach (var tile in Tiles.SelectMany(row => row))
            if (AllExplored || tile.Reached) tile.Explored = true;
    }
}

public sealed class BossSealInfo
{
    public int SpriteID { get; set; }
    public int CurScore { get; set; }
    public int WakeScore { get; set; }
    public int Percent { get; set; }
    public bool Present { get; set; }
    public bool Ready { get; set; }
}

public static class BossSealPolicy
{
    // 与游戏 MainUILayer:onSealBossUpdate 的场景限制一致。
    public static bool AppliesTo(MapDump map) => map.SceneType == 2 && map.CaveMode is 9 or 17;

    public static bool IsActive(MapDump map) => AppliesTo(map) && map.BossSeal.Present;
}

public sealed class PlayerStatus
{
    public int Level { get; set; }
    public int Width { get; set; }
    public int Height { get; set; }
    public string FogBits { get; set; } = "";
    public bool AllExplored { get; set; }
    public long Sequence { get; set; }
    public PlayerInfo Player { get; set; } = new();
    // 游戏单位/秒。游戏会先使用 MAP_COORD_COVERT_DISTANCE（每个地图格 1000 单位）
    // 转换该值，然后积分计算移动。
    public double MoveSpeed { get; set; }
    public bool Confused { get; set; }
    public bool Reversed { get; set; }
    public List<int> ConfuseDirections { get; set; } = [];
}
