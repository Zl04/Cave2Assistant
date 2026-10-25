namespace AdbMapController;

public static class LockedTreasurePolicy
{
    public static bool IsTreasure(RoleInfo role) => role.ClassName == "TriggerNpcData" &&
        role.RoleType == 2 && role.Kind is ("罐子" or "石堆" or "木箱" or "金箱");

    public static bool IsAvailable(RoleInfo role) => !IsTreasure(role) || !role.Locked;

    public static bool IsTreasureKind(string kind) => kind is "罐子" or "石堆" or "木箱" or "金箱";
}
