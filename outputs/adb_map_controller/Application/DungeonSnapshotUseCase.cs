namespace AdbMapController;

public interface IGameSnapshotSource : IPlayerStatusSource
{
    Task<MapDump> ReadMap();
}

public sealed record DungeonSnapshotResult(MapDump Map, IReadOnlyList<string> Messages, IReadOnlyList<string> Diagnostics);

/// <summary>Reads a complete snapshot before committing dungeon observations.</summary>
public sealed class DungeonSnapshotUseCase(DungeonSession dungeon, IGameSnapshotSource source)
{
    public async Task<DungeonSnapshotResult> RefreshAsync(CancellationToken token = default)
    {
        token.ThrowIfCancellationRequested();
        var previousMap = dungeon.Map;
        var map = await source.ReadMap();
        var player = await source.ReadPlayer();
        token.ThrowIfCancellationRequested();
        var messages = new List<string>();
        if (player.MoveSpeed > 0) dungeon.RouteExecution.MoveSpeed = player.MoveSpeed;
        RouteExecutor.ApplyPlayerStatus(map, player);
        if (previousMap is not null)
            foreach (var unlock in dungeon.PortalUnlocks.Observe(previousMap, map))
                messages.Add($"检测到传送门解锁：{unlock.Portal}，关联消失小怪 {string.Join(", ", unlock.DefeatedMonsters)}");
        if (dungeon.PendingRoomPortal is { } roomPortal && previousMap is not null && dungeon.RoomPortalOrigin is { } origin &&
            map.Level == previousMap.Level && PortalJumpGraph.KeyOf(map) == PortalJumpGraph.KeyOf(previousMap))
        {
            var now = new Cell(map.Player.X, map.Player.Y);
            if (dungeon.RoomPortalInteractionAt != 0 &&
                dungeon.PortalJumps.Observe(previousMap, roomPortal.Cell, map, out var destination, dungeon.RoomPortalOrigin))
            {
                // 将落地传送门视为本楼层自动探索流程中已消耗。
                // 这样可以防止下一次规划立即激活双传送门循环的反向边。
                dungeon.AttemptedRoomPortals.Add(destination);
                var sourceRole = previousMap.ByCell.TryGetValue(roomPortal.Cell, out var sourceTile)
                    ? sourceTile.Roles.FirstOrDefault(role => role.Kind == roomPortal.Kind)
                    : null;
                var description = sourceRole is null ? "层内传送门" : PortalRouting.Describe(sourceRole);
                messages.Add($"层内传送已确认：{roomPortal.Cell} -> {destination}（{description}，已记录 {dungeon.PortalJumps.EdgeCount(map)} 条边）");
                dungeon.RoomPortalSettlingCell = now;
                dungeon.RoomPortalResumeAt = Environment.TickCount64 + 1500;
                dungeon.PendingRoomPortal = null; dungeon.RoomPortalOrigin = null; dungeon.RoomPortalInteractionAt = 0;
            }
            else if (dungeon.RoomPortalInteractionAt != 0 && now != origin && now != roomPortal.Cell)
            {
                if (PortalRouting.NearestRoomPortal(map, now) is { } landingPortal)
                    dungeon.AttemptedRoomPortals.Add(landingPortal);
                messages.Add($"层内传送已发生：{roomPortal.Cell} -> {now}，落点附近没有可确认的传送门，保留当前位置重新寻路");
                dungeon.RoomPortalSettlingCell = now;
                dungeon.RoomPortalResumeAt = Environment.TickCount64 + 1500;
                dungeon.PendingRoomPortal = null; dungeon.RoomPortalOrigin = null; dungeon.RoomPortalInteractionAt = 0;
            }
        }
        foreach (var (cell, pass) in dungeon.PendingMechanismPasses.ToArray())
        {
            var trigger = map.ByCell.TryGetValue(cell, out var tile)
                ? tile.Roles.FirstOrDefault(role => role.RoleType == 5) : null;
            if (trigger is null || !MechanismChamberPolicy.IsPendingTrigger(trigger))
            {
                dungeon.PendingMechanismPasses.Remove(cell);
                dungeon.StalledMechanisms.Remove(cell);
                continue;
            }
            if (trigger.TriggeredCount > pass.PreviousCount)
            {
                dungeon.MechanismAttempts[cell] = (trigger.TriggeredCount, 0);
                dungeon.PendingMechanismPasses.Remove(cell);
                dungeon.StalledMechanisms.Remove(cell);
                messages.Add($"机关 {cell} 触发计数增长至 {trigger.TriggeredCount}/{trigger.TriggerCountMax}");
            }
            else if (Environment.TickCount64 - pass.PassedAt >= 500)
            {
                dungeon.MechanismAttempts.TryGetValue(cell, out var attempt);
                var failures = trigger.TriggeredCount > attempt.LastCount ? 0 : attempt.Failures + 1;
                dungeon.MechanismAttempts[cell] = (trigger.TriggeredCount, failures);
                dungeon.PendingMechanismPasses.Remove(cell);
                if (failures >= 2)
                {
                    dungeon.StalledMechanisms.Add(cell);
                    messages.Add($"机关 {cell} 两次经过后计数仍未增长，暂不再重复经过");
                }
            }
        }
        foreach (var cell in dungeon.StalledMechanisms.ToArray())
        {
            var trigger = map.ByCell.TryGetValue(cell, out var tile)
                ? tile.Roles.FirstOrDefault(role => role.RoleType == 5) : null;
            dungeon.MechanismAttempts.TryGetValue(cell, out var attempt);
            if (trigger is null || !MechanismChamberPolicy.IsPendingTrigger(trigger) || trigger.TriggeredCount > attempt.LastCount)
                dungeon.StalledMechanisms.Remove(cell);
        }
        dungeon.Map = map; dungeon.Route.Snapshot = MapSnapshot.Capture(map);

        return new DungeonSnapshotResult(map, messages, JsonDiagnostics.Drain());
    }
}
