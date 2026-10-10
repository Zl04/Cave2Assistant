using System.Collections.Generic;

namespace AdbMapController;

public enum MapIconPalette
{
    Amber,
    Azure,
    Emerald,
    Violet,
    Rose,
    Steel,
}

/// <summary>
/// 游戏 MapGrid/MapTownView 使用的 minimap 类型表。
/// 控制器不必附带游戏图集也能保持可用：没有匹配的光栅资源时，地图面板可以绘制字形。
/// </summary>
public sealed record TownMapIcon(string Kind, string Glyph, MapIconPalette Palette);

public static class MapIconCatalog
{
    // 这些值是游戏的 NPC_TYPE 常量。保持显示名称稳定，因为 RoleInfo.Kind
    // 也会被规划器和点击日志使用。
    static readonly IReadOnlyDictionary<int, TownMapIcon> FunctionIcons =
        new Dictionary<int, TownMapIcon>
        {
            [6] = new("点金台", "金", MapIconPalette.Amber),
            [7] = new("附魔台", "附", MapIconPalette.Azure),
            [8] = new("商人", "商", MapIconPalette.Emerald),
            [9] = new("城镇商人", "猫", MapIconPalette.Emerald),
            [10] = new("黑市商人", "黑", MapIconPalette.Violet),
            [11] = new("铁匠", "匠", MapIconPalette.Rose),
            [12] = new("邮箱", "邮", MapIconPalette.Azure),
            [13] = new("洞窟入口", "窟", MapIconPalette.Azure),
            [14] = new("任务板", "任", MapIconPalette.Amber),
            [15] = new("仓库", "库", MapIconPalette.Steel),
            [16] = new("卫兵", "卫", MapIconPalette.Steel),
            [17] = new("转盘抽奖", "轮", MapIconPalette.Amber),
            [18] = new("传送门", "传", MapIconPalette.Violet),
            [19] = new("秘境入口", "秘", MapIconPalette.Violet),
            [20] = new("排行榜", "榜", MapIconPalette.Azure),
            [21] = new("公会入口", "会", MapIconPalette.Violet),
            [22] = new("秘境传送门", "门", MapIconPalette.Violet),
            [23] = new("炼金术士", "炼", MapIconPalette.Amber),
            // 保留控制器历史名称“公会商人”，以兼容现有日志和选择代码；
            // 源码将其称为 guild shop。
            [24] = new("公会商人", "店", MapIconPalette.Violet),
            [25] = new("公会布告板", "板", MapIconPalette.Amber),
            [26] = new("活动", "活", MapIconPalette.Rose),
            [27] = new("宝石", "宝", MapIconPalette.Azure),
            [28] = new("家园", "家", MapIconPalette.Emerald),
            [29] = new("技能进阶", "技", MapIconPalette.Amber),
            [30] = new("幻化", "幻", MapIconPalette.Violet),
            [31] = new("梦境入口", "梦", MapIconPalette.Azure),
            [32] = new("装备重铸", "铸", MapIconPalette.Rose),
            [33] = new("星痕", "星", MapIconPalette.Azure),
            [34] = new("探险队", "探", MapIconPalette.Emerald),
            [35] = new("沙之眼", "沙", MapIconPalette.Amber),
            [36] = new("扭曲空间", "扭", MapIconPalette.Violet),
            [37] = new("节日活动", "节", MapIconPalette.Rose),
            [38] = new("许愿池", "愿", MapIconPalette.Azure),
            [39] = new("采集物", "采", MapIconPalette.Emerald),
            [40] = new("公会拍卖师", "拍", MapIconPalette.Violet),
            [41] = new("公会副本", "副", MapIconPalette.Rose),
            [43] = new("庄园商人", "庄", MapIconPalette.Emerald),
            [44] = new("庄园入口", "入", MapIconPalette.Emerald),
            [45] = new("易物台", "易", MapIconPalette.Amber),
            [46] = new("工坊", "工", MapIconPalette.Rose),
            [47] = new("管家", "管", MapIconPalette.Azure),
            [48] = new("庄园书桌", "桌", MapIconPalette.Steel),
            [49] = new("庄园远航", "航", MapIconPalette.Azure),
            [50] = new("庄园餐桌", "餐", MapIconPalette.Amber),
            [51] = new("幻化架", "架", MapIconPalette.Violet),
            [52] = new("维京时代", "维", MapIconPalette.Rose),
            [53] = new("永冬裂缝", "冬", MapIconPalette.Azure),
            [54] = new("符文模具", "模", MapIconPalette.Emerald),
            [55] = new("港口码头", "码", MapIconPalette.Azure),
            [56] = new("港口商人", "商", MapIconPalette.Emerald),
            [57] = new("港口任务", "任", MapIconPalette.Amber),
            [58] = new("港口补给", "补", MapIconPalette.Emerald),
            [59] = new("港口拉力赛", "赛", MapIconPalette.Rose),
        };

    static readonly IReadOnlyDictionary<int, TownMapIcon> TransferIcons =
        new Dictionary<int, TownMapIcon>
        {
            [1] = new("出口", "出", MapIconPalette.Azure),
            [18] = new("传送门", "传", MapIconPalette.Violet),
            [22] = new("秘境传送门", "门", MapIconPalette.Violet),
            [21] = new("公会入口", "会", MapIconPalette.Violet),
            [44] = new("庄园入口", "入", MapIconPalette.Emerald),
        };

    // 资源名称来自 ui_general_minimap_icon.plist 的帧名称。
    // 它们有意与上面的显示表分开：多个节点可能共享显示名称，
    // 但使用不同的洞窟/城镇帧。
    static readonly IReadOnlyDictionary<int, string> FunctionAssets =
        new Dictionary<int, string>
        {
            [6] = "ui_minimap_icon_dianjin",
            [7] = "ui_minimap_icon_town_enchanting",
            [8] = "ui_minimap_icon_businessman",
            [9] = "ui_minimap_icon_town_catfood",
            [10] = "ui_minimap_icon_town_blackmarket",
            [11] = "ui_minimap_icon_town_blacksmith",
            [12] = "ui_minimap_icon_town_mail",
            // MapGrid 在城镇地图上使用 fam 帧表示普通洞窟入口。
            // cave 帧属于 SECRET_AREA（19）。
            [13] = "ui_minimap_icon_town_fam",
            [14] = "ui_minimap_icon_town_pipe",
            [15] = "ui_minimap_icon_town_warehouse",
            [16] = "ui_minimap_icon_town_pipe",
            [17] = "ui_minimap_icon_town_luckdraw",
            [18] = "ui_minimap_icon_town_transfer",
            [19] = "ui_minimap_icon_town_cave",
            [20] = "ui_minimap_icon_town_ranking",
            [21] = "ui_minimap_icon_town_guildentrance",
            [22] = "ui_minimap_icon_room",
            [23] = "ui_minimap_icon_town_goldmetallurgy",
            [24] = "ui_minimap_icon_town_guildshop",
            [25] = "ui_minimap_icon_town_pipe",
            [26] = "ui_minimap_icon_town_activity",
            [27] = "ui_minimap_icon_town_gem",
            [28] = "ui_minimap_icon_town_home",
            [29] = "ui_minimap_icon_town_upgrade",
            [30] = "ui_minimap_icon_town_deformation",
            [31] = "ui_minimap_icon_town_dreamword",
            [32] = "ui_minimap_icon_town_recasting",
            [33] = "ui_minimap_icon_town_starpray",
            [34] = "ui_minimap_icon_town_explore",
            [35] = "ui_minimap_icon_town_sandeye",
            [36] = "ui_minimap_icon_town_twistedspace",
            [37] = "ui_minimap_icon_town_festival",
            [38] = "ui_minimap_icon_guild_wishingpond",
            [39] = "ui_minimap_icon_town_cave",
            [40] = "ui_minimap_icon_guild_auction",
            [41] = "ui_minimap_icon_guild_selectfloor",
            [43] = "ui_minimap_icon_house_trade",
            [44] = "ui_minimap_icon_town_manor",
            [45] = "ui_minimap_icon_house_barter",
            [46] = "ui_minimap_icon_house_workshop",
            [47] = "ui_minimap_icon_house_housekeeper",
            [48] = "ui_minimap_icon_town_desk",
            [49] = "ui_minimap_icon_house_navigation",
            [50] = "ui_minimap_icon_house_diningtable",
            [51] = "ui_minimap_icon_house_illusion",
            [52] = "ui_minimap_icon_town_reincarnation",
            [53] = "ui_minimap_icon_town_crack",
            [54] = "ui_minimap_icon_town_mold",
            [55] = "ui_minimap_icon_port_wharf",
            [56] = "ui_minimap_icon_port_merchant",
            [57] = "ui_minimap_icon_port_task",
            [58] = "ui_minimap_icon_port_supply",
            [59] = "ui_minimap_icon_town_rally",
        };

    static readonly IReadOnlyDictionary<int, string> TransferAssets =
        new Dictionary<int, string>
        {
            [1] = "ui_minimap_icon_stairs",
            [18] = "ui_minimap_icon_transfer",
            [22] = "ui_minimap_icon_room",
            [21] = "ui_minimap_icon_town_guildentrance",
            [44] = "ui_minimap_icon_town_manor",
        };

    public static bool TryGetTownIcon(RoleInfo role, out TownMapIcon icon)
    {
        icon = null!;
        if (role.ClassName != "TriggerNpcData") return false;
        var icons = role.RoleType == 7 ? FunctionIcons : role.RoleType == 1 ? TransferIcons : null;
        return icons is not null && icons.TryGetValue(role.MinimapType, out icon!);
    }

    public static bool TryGetKind(RoleInfo role, out string kind)
    {
        if (TryGetTownIcon(role, out var icon))
        {
            kind = icon.Kind;
            return true;
        }

        kind = "";
        return false;
    }

    public static string? GetAssetName(RoleInfo role)
    {
        if (role.ClassName != "TriggerNpcData") return null;
        if (role.RoleType == 1 && role.MinimapType == 22 &&
            role.TransdoorType == PortalProtocol.RoomToRoomTransdoorType && role.IsRandomTransfer)
            return "ui_minimap_icon_room_purple";
        var assets = role.RoleType == 7 ? FunctionAssets : role.RoleType == 1 ? TransferAssets : null;
        return assets is not null && assets.TryGetValue(role.MinimapType, out var asset) ? asset : null;
    }

    /// <summary>
    /// 游戏有意将多个角色记录排除在 minimap 之外。
    /// 它们仍是有用的运行时记录（例如多格交互 NPC），但绘制控制器自有的问号，
    /// 会错误暗示游戏在该位置有未知图标。
    /// 将其与 <see cref="RoleInfo.Kind"/> 分开，使规划和诊断仍能区分不支持的角色。
    /// </summary>
    public static bool ShouldDrawUnknownMarker(RoleInfo role)
    {
        if (role.Kind != "未知") return false;
        if (role.ClassName == "TriggerNpcData" && role.RoleType == 7 && role.MinimapType == 0) return false;
        if (role.RoleType is 14 or 16) return false;
        return true;
    }
}
