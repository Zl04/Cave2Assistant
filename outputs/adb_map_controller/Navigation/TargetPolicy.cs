namespace AdbMapController;

/// <summary>
/// 地图目标的稳定领域标识。为兼容 UI，显示文本仍保留在 RoleInfo.Kind 中，
/// 而规划和选择使用此枚举。
/// </summary>
public enum TargetKind
{
    None, Unknown, NormalMonster, GroupMonster, Elite, SmallBoss, Boss,
    Pot, StonePile, WoodChest, GoldChest, Gold, Key, Rune,
    Altar, Enchanting, Merchant, Trap, Exit, Portal, Chamber, Mechanism,
    GuildTechnology, GuildMerchant, GuildBoard, WishingPool, GuildAuction, GuildDungeon
}

public static class TargetPolicy
{
    public static TargetKind Classify(RoleInfo role) => role.Kind switch
    {
        "小怪" => TargetKind.NormalMonster,
        "群怪" => TargetKind.GroupMonster,
        "精英" => TargetKind.Elite,
        "小Boss" => TargetKind.SmallBoss,
        "Boss" => TargetKind.Boss,
        "罐子" => TargetKind.Pot,
        "石堆" => TargetKind.StonePile,
        "木箱" => TargetKind.WoodChest,
        "金箱" => TargetKind.GoldChest,
        "金币" => TargetKind.Gold,
        "钥匙" => TargetKind.Key,
        "符文" => TargetKind.Rune,
        "点金台" => TargetKind.Altar,
        "附魔台" => TargetKind.Enchanting,
        "商人" => TargetKind.Merchant,
        "陷阱" => TargetKind.Trap,
        "出口" => TargetKind.Exit,
        "传送门" or "秘境传送门" => TargetKind.Portal,
        "密室" => TargetKind.Chamber,
        "机关" => TargetKind.Mechanism,
        "公会科技" => TargetKind.GuildTechnology,
        "公会商人" => TargetKind.GuildMerchant,
        "公会布告板" => TargetKind.GuildBoard,
        "许愿池" => TargetKind.WishingPool,
        "公会拍卖师" => TargetKind.GuildAuction,
        "公会副本" => TargetKind.GuildDungeon,
        "未知" => TargetKind.Unknown,
        _ => TargetKind.None
    };

    public static bool IsSelected(RoleInfo role, PlanOptions options)
        => Classify(role) switch
        {
            TargetKind.Boss or TargetKind.SmallBoss => options.AttackBoss,
            TargetKind.Key => true,
            TargetKind.NormalMonster or TargetKind.GroupMonster => options.Monsters,
            TargetKind.Elite => options.Monsters || options.Elites,
            TargetKind.WoodChest or TargetKind.GoldChest => options.Chests,
            TargetKind.Pot => options.Pots,
            TargetKind.StonePile => options.Bones,
            TargetKind.Gold => options.Gold,
            TargetKind.Rune or TargetKind.Altar => options.Runes,
            TargetKind.Chamber or TargetKind.Mechanism => options.Chambers,
            _ => false
        };
}
