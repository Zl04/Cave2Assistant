using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace AdbMapController;

public enum ThemeMode
{
    Light,
    Dark,
    System,
}

public enum ExecutionTaskKind { EntryAndRun, CurrentMapRun }

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
    public bool AutoEquipmentSale { get; set; }
    public bool SellBlueWhite { get; set; } = true;
    public bool SellPurple { get; set; }
    public bool SellDarkGold { get; set; }
    public bool SellGold { get; set; }
    public decimal MiningTileWidth { get; set; } = 200;
    public decimal MiningTileHeight { get; set; } = 100;
    public decimal MiningInterval { get; set; } = 3000;
    public bool Mining { get; set; }
    public bool CardMining { get; set; }
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
    // 到达普通关卡的指定层后，持有逃脱卷轴时主动回城。
    public int EscapeReturnFloor { get; set; }
    public bool EscapeReturnAttackBoss { get; set; }
    public bool CardLayer { get; set; }
    public int EntryMapId { get; set; }
    public int EntryId { get; set; } = 1;
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public DungeonDifficulty EntryDifficulty { get; set; } = DungeonDifficulty.Normal;
    // 0 表示自动次数：普通难度无限，其它难度使用剩余次数。
    public int EntryRunCount { get; set; }
    public List<string> BonusPriority { get; set; } = [];
    public string Device { get; set; } = "";
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public ExecutionTaskKind TaskKind { get; set; }
    // 新任务默认启用。
    public bool TaskEnabled { get; set; } = true;
    public List<ControllerSettings> ExecutionTasks { get; set; } = [];
}
