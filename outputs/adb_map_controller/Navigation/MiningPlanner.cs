using System;
using System.Collections.Generic;
using System.Linq;

namespace AdbMapController;

public sealed record MiningPlan(Cell Wall, Cell Stop, RoutePlan Movement);

public sealed record MiningToolStatus(bool IconPresent, int? Quantity);

public readonly record struct MiningRange(int XMax, int YMax)
{
    public bool Contains(Cell cell) => cell.X >= 1 && cell.Y >= 1 && cell.X <= XMax && cell.Y <= YMax;
}

public static class MiningToolGuard
{
    public static string? StopReason(MiningToolStatus status)
    {
        if (!status.IconPresent) return "挖矿已停止：第二格未放置挖矿道具";
        if (status.Quantity is null) return "挖矿已停止：无法识别第二格挖矿道具数量";
        if (status.Quantity <= 0) return "挖矿已停止：第二格挖矿道具数量为0";
        return null;
    }

    public static int? ParseQuantityText(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return null;
        var digits = new string(text
            .Replace('O', '0').Replace('o', '0')
            .Where(character => char.IsDigit(character))
            .ToArray());
        return digits.Length > 0 && int.TryParse(digits, out var quantity) ? quantity : null;
    }
}

public static class MiningPlanner
{
    static readonly Cell[] Directions = [new(1, 0), new(0, 1), new(-1, 0), new(0, -1)];
    static readonly Cell[] MiningOffsets =
    [
        new(1, 0), new(0, 1), new(-1, 0), new(0, -1),
        new(1, 1), new(-1, 1), new(-1, -1), new(1, -1)
    ];

    // An exposed tile is a poor mining stop: fewer known walkable neighbors
    // means the player is closer to the edge of the explored floor.
    public static int OpenGroundNeighbors(MapDump map, Cell cell)
    {
        var count = 0;
        for (var dx = -1; dx <= 1; dx++)
        for (var dy = -1; dy <= 1; dy++)
        {
            if (dx == 0 && dy == 0) continue;
            if (map.ByCell.TryGetValue(new Cell(cell.X + dx, cell.Y + dy), out var tile) &&
                tile.Walkable) count++;
        }
        return count;
    }

    public static bool IsWall(MapDump map, Cell cell)
        => IsWall(map.ByCell, cell);

    static bool IsWall(IReadOnlyDictionary<Cell, TileInfo> tiles, Cell cell)
    {
        // 导出包含 0..max 的完整格子；宽/高是数量，不能当作最大坐标。
        // 必须是快照内真实存在的格子，天然不会超过各轴的实际最大值。
        return cell.X >= 1 && cell.Y >= 1 &&
            tiles.TryGetValue(cell, out var tile) && tile.TerrainType == 1;
    }

    public static bool InRange(Cell player, Cell target)
        => Math.Max(Math.Abs((long)target.X - player.X), Math.Abs((long)target.Y - player.Y)) == 1;

    public static MiningPlan? Plan(MapDump map, IReadOnlySet<Cell>? blocked = null,
        MiningRange? miningRange = null)
    {
        if (map.SceneType == 1 || map.InBattle || map.IsDead) return null;
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        if (!tiles.TryGetValue(start, out var origin) || !origin.Ground) return null;
        var walls = tiles.Keys.Where(cell => IsWall(tiles, cell) &&
            (miningRange is null || miningRange.Value.Contains(cell))).ToHashSet();
        var previous = new Dictionary<Cell, Cell>();
        var depth = new Dictionary<Cell, int> { [start] = 0 };
        var seen = new HashSet<Cell> { start };
        var queue = new Queue<Cell>();
        queue.Enqueue(start);
        Cell? bestStop = null;
        Cell? bestWall = null;
        var bestDepth = int.MaxValue;
        var bestOpenness = -1;
        var comfortableDepth = int.MaxValue;
        while (queue.TryDequeue(out var stop))
        {
            var steps = depth[stop];
            if (steps > comfortableDepth) break;
            var nearby = MiningOffsets.Select(offset => new Cell(stop.X + offset.X, stop.Y + offset.Y))
                .Where(walls.Contains)
                .OrderBy(wall => Math.Abs(wall.X - stop.X) + Math.Abs(wall.Y - stop.Y))
                .ThenBy(wall => wall.Y).ThenBy(wall => wall.X).ToList();
            if (nearby.Count > 0)
            {
                var openness = OpenGroundNeighbors(map, stop);
                if (openness >= 6) comfortableDepth = Math.Min(comfortableDepth, steps);
                if (openness > bestOpenness || (openness == bestOpenness && steps < bestDepth))
                { bestOpenness = openness; bestDepth = steps; bestStop = stop; bestWall = nearby[0]; }
            }
            if (steps >= comfortableDepth) continue;
            foreach (var delta in Directions)
            {
                var next = new Cell(stop.X + delta.X, stop.Y + delta.Y);
                if (seen.Contains(next) || blocked?.Contains(next) == true ||
                    !tiles.TryGetValue(next, out var tile) || !tile.Walkable) continue;
                // 挖矿路线不主动触发换层、传送门或其它 NPC 交互。
                if (tile.Roles.Any(r => !r.MasterHero && r.Kind is not
                    ("" or "金币" or "钥匙" or "符文" or "小怪" or "群怪" or "精英"))) continue;
                seen.Add(next); previous[next] = stop; depth[next] = steps + 1; queue.Enqueue(next);
            }
        }
        if (bestStop is not { } chosenStop || bestWall is not { } chosenWall) return null;
        var path = new List<Cell> { chosenStop };
        for (var cursor = chosenStop; cursor != start;)
        { cursor = previous[cursor]; path.Add(cursor); }
        path.Reverse();
        // As in ordinary navigation, fight a monster on the route first,
        // then read the map again before continuing to the mining stop.
        for (var i = 1; i < path.Count; i++)
        {
            var monster = tiles[path[i]].Roles.FirstOrDefault(r => r.Kind is "小怪" or "群怪" or "精英");
            if (monster is null) continue;
            var target = new TargetKey(path[i], monster.Kind);
            return new(chosenWall, chosenStop, new RoutePlan
            {
                Route = path.Take(i).ToList(),
                Interactions = [new(path[i - 1], target)], TargetUniverse = [target]
            });
        }
        return new(chosenWall, chosenStop, new RoutePlan { Route = path });
    }
}

public static class MiningScreenCoordinates
{
    // 用户截图中的第二个快捷栏中心（横屏归一化坐标）。
    public static (double X, double Y) ToolSlot => (0.365, 0.93);

    // 1280x720 设计分辨率下的菱形格子尺寸。人物默认位于屏幕中心。
    public static (double X, double Y) Wall(Cell player, Cell target,
        double tileWidth = 200, double tileHeight = 100)
    {
        if (!MiningPlanner.InRange(player, target) || player == target)
            throw new ArgumentOutOfRangeException(nameof(target), "目标必须位于人物身边一格");
        if (!double.IsFinite(tileWidth) || !double.IsFinite(tileHeight) || tileWidth <= 0 || tileHeight <= 0)
            throw new ArgumentOutOfRangeException(nameof(tileWidth));
        var dx = target.X - player.X;
        var dy = target.Y - player.Y;
        var x = .5 + (dx - dy) * tileWidth / 2 / 1280;
        // CaveMap.coordinateToPosition anchors a tile at its center by adding
        // half a tile height. Screen Y grows downwards, so preserve that
        // downward offset when converting the mining target to a tap point.
        var y = .5 - (dx + dy) * tileHeight / 2 / 720
            + tileHeight / 2 / 720;
        // 不夹紧到屏幕边缘，防止校准错误时误点其它按钮。
        if (x <= 0 || x >= 1 || y <= 0 || y >= 1)
            throw new ArgumentOutOfRangeException(nameof(target), "挖矿点击位置超出屏幕");
        return (x, y);
    }
}
