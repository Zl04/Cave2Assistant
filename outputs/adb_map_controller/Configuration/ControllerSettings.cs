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

public enum ExecutionTaskKind { EntryAndRun, CurrentMapRun, CardMining, DreamTrial, SoulArtifactCultivation, FreePrayer, FreeWelfare, AbyssKey, EternalWinterSweep, AbyssSweep, DailySignIn, GhostAbyss, GuildTasks, BossChallenge, ScheduledConnectionRecovery, AbyssRun }

public sealed class TaskTemplate
{
    public string Name { get; set; } = "";
    public List<ControllerSettings> Tasks { get; set; } = [];
    // 兼容旧版单任务模板，加载时迁移到 Tasks。
    [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
    public ControllerSettings? Task { get; set; }
}

public sealed class ControllerSettings
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public ThemeMode Theme { get; set; } = ThemeMode.Light;
    public bool AlwaysOnTop { get; set; }
    public bool SavePipelineScreenshots { get; set; } = true;
    public bool SavePipelineRecords { get; set; } = true;
    public bool AttackBoss { get; set; } = true;
    public bool DirectBossNpc { get; set; }
    public bool Monsters { get; set; }
    public bool Elites { get; set; }
    public bool WoodChests { get; set; }
    public bool OtherChests { get; set; }
    public bool Pots { get; set; }
    public bool Bones { get; set; }
    public bool Gold { get; set; }
    public bool Runes { get; set; }
    public bool Altars { get; set; }
    public bool Chambers { get; set; }
    public bool AutoEquipmentSale { get; set; }
    public bool SellBlueWhite { get; set; } = true;
    public bool SellPurple { get; set; }
    public bool SellDarkGold { get; set; }
    public bool SellGold { get; set; }
    public bool SellRed { get; set; }
    public decimal MiningTileWidth { get; set; } = 200;
    public decimal MiningTileHeight { get; set; } = 100;
    public decimal MiningInterval { get; set; } = 3000;
    public bool Mining { get; set; }
    public bool CardMining { get; set; }
    public decimal SingleCellPulseHold { get; set; } = 50;
    // 正值：在预期格前释放。负值：在到达预期格后释放。
    public decimal MovementReleaseLead { get; set; } = 30;
    public decimal InteractionHold { get; set; } = 300;
    public decimal InteractionSettleDelay { get; set; } = 300;
    public decimal StallTimeout { get; set; } = 1000;
    public decimal NewFloorStartDelay { get; set; } = 1500;
    public decimal RouteRecoveryAttempts { get; set; } = 3;
    // TargetStopFloor=0 禁用楼层停止。到达目标楼层后，按“目标”选项
    // 执行当前楼层目标，所选目标全部完成后自动停止。
    public int TargetStopFloor { get; set; }
    // 到达指定层后且当前层低于玩法最高层时，持有逃脱卷轴则主动回城，不限制场景类型。
    public int EscapeReturnFloor { get; set; }
    public bool EscapeReturnAttackBoss { get; set; }
    public bool CardLayer { get; set; }
    public int EntryMapId { get; set; }
    public int EntryId { get; set; } = 1;
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public DungeonDifficulty EntryDifficulty { get; set; } = DungeonDifficulty.Normal;
    // 0 表示自动次数：普通难度无限，其它难度使用剩余次数。
    public int EntryRunCount { get; set; }
    public int AbyssRunCount { get; set; } = 1;
    public bool AbyssTeamMode { get; set; }
    public List<string> BonusPriority { get; set; } = [];
    public string Device { get; set; } = "";
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public ExecutionTaskKind TaskKind { get; set; }
    // 新任务默认启用。
    public bool TaskEnabled { get; set; } = true;
    public bool SwitchEquipmentSet { get; set; }
    public int EquipmentSet { get; set; } = 1;
    public DateTime CardMiningStartAt { get; set; } = DateTime.Today.AddDays(1);
    public DateTime ScheduledRecoveryStartAt { get; set; } = DateTime.Today.AddDays(1);
    public int CardMiningMinimumTools { get; set; } = 1;
    // 从左到右六位分别对应梦境试炼的六位 Boss。
    public int DreamTrialBossMask { get; set; } = 63;
    public int EternalWinterFloor { get; set; } = 1;
    public int EternalWinterSweepCount { get; set; } = 1;
    public int GhostAbyssFloor { get; set; } = 1;
    public bool GhostAbyssDouble { get; set; }
    public bool GuildWish { get; set; } = true;
    public bool GuildCrystalShop { get; set; } = true;
    public bool GuildDungeon { get; set; } = true;
    public int GuildBoss { get; set; } = 1;
    public List<ControllerSettings> ExecutionTasks { get; set; } = [];
    public List<TaskTemplate> TaskTemplates { get; set; } = [];
    public string SelectedTaskTemplateName { get; set; } = "";
}
