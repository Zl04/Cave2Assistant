using System;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace AdbMapController;

public sealed class ControllerSettings
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public ThemeMode Theme { get; set; } = ThemeMode.Light;
    public bool AlwaysOnTop { get; set; }
    public bool AttackBoss { get; set; } = true;
    public bool Monsters { get; set; }
    public bool Elites { get; set; }
    public bool Chests { get; set; }
    public bool Pots { get; set; }
    public bool Bones { get; set; }
    public bool Gold { get; set; }
    public bool Runes { get; set; }
    public bool Chambers { get; set; }
    public decimal MiningTileWidth { get; set; } = 200;
    public decimal MiningTileHeight { get; set; } = 100;
    public decimal MiningInterval { get; set; } = 3000;
    public decimal SingleCellPulseHold { get; set; } = 50;
    // 正值：在预期格前释放。负值：在到达预期格后释放。
    public decimal MovementReleaseLead { get; set; } = 30;
    public decimal InteractionHold { get; set; } = 300;
    public decimal StallTimeout { get; set; } = 1000;
    public decimal NewFloorStartDelay { get; set; } = 1500;
    public decimal RouteRecoveryAttempts { get; set; } = 3;
    // TargetStopFloor=0 禁用楼层停止。到达目标楼层后，按“目标”选项
    // 执行当前楼层目标，所选目标全部完成后自动停止。
    public int TargetStopFloor { get; set; }
    public bool CardLayer { get; set; }
    public int EntryMapId { get; set; }
    public int EntryId { get; set; } = 1;
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public DungeonDifficulty EntryDifficulty { get; set; } = DungeonDifficulty.Normal;
    // 兼容旧版本配置：旧字段为 true 时迁移为精英难度。
    public bool EntryEliteMode { get; set; }
    public List<string> BonusPriority { get; set; } = [];
    public string Device { get; set; } = "";
}

public static class SettingsStore
{
    static readonly JsonSerializerOptions JsonOptions = new() { WriteIndented = true };

    public static ControllerSettings? Load(string path)
    {
        try
        {
            if (!File.Exists(path)) return null;
            return JsonSerializer.Deserialize<ControllerSettings>(File.ReadAllText(path));
        }
        catch { return null; }
    }

    public static void Save(string path, ControllerSettings settings)
    {
        var temp = path + ".tmp";
        try
        {
            File.WriteAllText(temp, JsonSerializer.Serialize(settings, JsonOptions));
            File.Move(temp, path, true);
        }
        catch
        {
            try { if (File.Exists(temp)) File.Delete(temp); } catch { }
        }
    }
}
