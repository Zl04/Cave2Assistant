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
            if (dungeon.PortalJumps.Observe(previousMap, roomPortal.Cell, map, out var destination, dungeon.RoomPortalOrigin))
            {
                // 将落地传送门视为本楼层自动探索流程中已消耗。
                // 这样可以防止下一次规划立即激活双传送门循环的反向边。
                dungeon.AttemptedRoomPortals.Add(destination);
                var sourceRole = previousMap.ByCell.TryGetValue(roomPortal.Cell, out var sourceTile)
                    ? sourceTile.Roles.FirstOrDefault(role => role.Kind == roomPortal.Kind)
                    : null;
                var description = sourceRole is null ? "层内传送门" : PortalRouting.Describe(sourceRole);
                messages.Add($"层内传送已确认：{roomPortal.Cell} -> {destination}（{description}，已记录 {dungeon.PortalJumps.EdgeCount(map)} 条边）");
                dungeon.PendingRoomPortal = null; dungeon.RoomPortalOrigin = null; dungeon.RoomPortalInteractionAt = 0;
            }
            else if (now != origin && now != roomPortal.Cell)
            {
                if (PortalRouting.NearestRoomPortal(map, now) is { } landingPortal)
                    dungeon.AttemptedRoomPortals.Add(landingPortal);
                messages.Add($"层内传送已发生：{roomPortal.Cell} -> {now}，落点附近没有可确认的传送门，保留当前位置重新寻路");
                dungeon.PendingRoomPortal = null; dungeon.RoomPortalOrigin = null; dungeon.RoomPortalInteractionAt = 0;
            }
        }
        dungeon.Mechanisms.ObserveLevel(map.Level);
        dungeon.Map = map; dungeon.Route.Snapshot = MapSnapshot.Capture(map);
        var cell = new Cell(map.Player.X, map.Player.Y);
        if (map.ByCell.TryGetValue(cell, out var tile) && tile.Roles.Any(role => role.Kind == "机关") && dungeon.Mechanisms.Add(cell))
            messages.Add($"已记录机关踩中：{cell}（以实际人物坐标确认）");


        return new DungeonSnapshotResult(map, messages, JsonDiagnostics.Drain());
    }
}
