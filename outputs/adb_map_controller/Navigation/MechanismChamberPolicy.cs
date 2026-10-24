namespace AdbMapController;

public static class MechanismChamberPolicy
{
    public static bool IsPendingTrigger(RoleInfo role) => role.RoleType == 5 && !role.Opened &&
        (role.TriggerCountMax > 0 ? role.TriggeredCount < role.TriggerCountMax : role.TriggeredCount == 0);

    public static bool IsAvailableEntrance(RoleInfo role) => role.RoleType == 6 && !role.Locked && !role.Opened;

    public static bool HasLockedEntrance(MapDump map) => map.Tiles.SelectMany(row => row)
        .SelectMany(tile => tile.Roles).Any(role => role.RoleType == 6 && role.Locked && !role.Opened);
}
