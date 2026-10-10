using System;
using System.Collections.Generic;
using System.Linq;

namespace AdbMapController;

public sealed record MiningPlan(Cell Wall, Cell Stop, RoutePlan Movement);

public sealed record MiningToolStatus(bool IconPresent, int? Quantity);

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

    public static MiningPlan? Plan(MapDump map, IReadOnlySet<Cell>? blocked = null)
    {
        if (map.SceneType == 1 || map.InBattle || map.IsDead) return null;
        var tiles = map.ByCell;
        var start = new Cell(map.Player.X, map.Player.Y);
        if (!tiles.TryGetValue(start, out var origin) || !origin.Ground) return null;
        var walls = tiles.Keys.Where(cell => IsWall(tiles, cell)).ToHashSet();
        var previous = new Dictionary<Cell, Cell>();
        var seen = new HashSet<Cell> { start };
        var queue = new Queue<Cell>();
        queue.Enqueue(start);
        while (queue.TryDequeue(out var stop))
        {
            // BFS 先选择无需移动的墙，再选择步数最少的可达停靠点。
            var nearby = walls.Where(wall => InRange(stop, wall))
                .OrderBy(wall => Math.Abs(wall.X - stop.X) + Math.Abs(wall.Y - stop.Y))
                .ThenBy(wall => wall.Y).ThenBy(wall => wall.X).ToList();
            if (nearby.Count > 0)
            {
                var path = new List<Cell> { stop };
                for (var cursor = stop; cursor != start;)
                { cursor = previous[cursor]; path.Add(cursor); }
                path.Reverse();
                // 和普通导航一样，路上的怪物是交互停靠点，战斗后重新读取地图。
                for (var i = 1; i < path.Count; i++)
                {
                    var monster = tiles[path[i]].Roles.FirstOrDefault(r => r.Kind is "小怪" or "群怪" or "精英");
                    if (monster is null) continue;
                    var target = new TargetKey(path[i], monster.Kind);
                    return new(nearby[0], stop, new RoutePlan
                    {
                        Route = path.Take(i).ToList(),
                        Interactions = [new(path[i - 1], target)], TargetUniverse = [target]
                    });
                }
                return new(nearby[0], stop, new RoutePlan { Route = path });
            }
            foreach (var delta in Directions)
            {
                var next = new Cell(stop.X + delta.X, stop.Y + delta.Y);
                if (seen.Contains(next) || blocked?.Contains(next) == true ||
                    !tiles.TryGetValue(next, out var tile) || !tile.Walkable) continue;
                // 挖矿路线不主动触发换层、传送门或其它 NPC 交互。
                if (tile.Roles.Any(r => !r.MasterHero && r.Kind is not
                    ("" or "金币" or "钥匙" or "符文" or "小怪" or "群怪" or "精英"))) continue;
                seen.Add(next); previous[next] = stop; queue.Enqueue(next);
            }
        }
        return null;
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
