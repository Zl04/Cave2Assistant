using System;
using System.Collections.Generic;

namespace AdbMapController;

/// <summary>
/// 每次用当前的混乱方向表查出游戏哪个按键代表目标方向，再返回该按键的固定屏幕位置。
/// 屏幕位置编号：左上=1、右上=2、右下=3、左下=4。游戏方向表槽位顺序是上、下、左、右。
/// </summary>
public static class DirectionMapper
{
    // 这里只描述游戏控件槽位在屏幕上的布局，不包含任何混乱方向排列。
    static readonly int[] GamePadSlotToScreenPosition = [1, 3, 4, 2];

    public static int ButtonPosition(Cell desired, bool confused, bool reversed, IReadOnlyList<int> currentConfuseDirections)
    {
        var direction = desired switch
        {
            { X: 0, Y: 1 } => 1,  // 默认上
            { X: 1, Y: 0 } => 2,
            { X: 0, Y: -1 } => 3, // 默认下
            { X: -1, Y: 0 } => 4,
            _ => 0
        };
        if (direction == 0) return 0;

        // 游戏方向盘在两种状态同时出现时优先使用随机混乱排列。
        if (confused)
        {
            if (currentConfuseDirections.Count < 4) return direction;
            for (var slot = 0; slot < 4; slot++)
            {
                if (currentConfuseDirections[slot] == direction)
                    return GamePadSlotToScreenPosition[slot];
            }
            return direction;
        }

        // 扭曲空间固定迷惑：每个方向按相反方向的键。
        if (!reversed) return direction;
        return direction switch
        {
            1 => 3,
            2 => 4,
            3 => 1,
            4 => 2,
            _ => direction
        };
    }
}

/// <summary>
/// 将逻辑方向映射到归一化按钮中心。
/// 将其独立出来后，可以在不修改 ADB 命令处理的情况下校准设备。
/// </summary>
public static class TouchCoordinateMapper
{
    const double DesignWidth = 1280d;
    const double DesignHeight = 720d;

    // 游戏源码以横屏 Cocos 坐标系发送这些点（原点在左下角）。ToPixels 返回 Android
    // 显示坐标（原点在左上角），因此在此处反转 Y。保留源码坐标点可以明确表达
    // 与 ControlPadNormal 的关系，并防止设备旋转导致触摸偏离方向键区域。
    static (double X, double Y) FromGamePoint(double x, double y)
        => (x / DesignWidth, (DesignHeight - 1d - y) / DesignHeight);

    public static Cell ButtonPositionToDelta(int position) => position switch
    {
        1 => new(0, 1),  // 左上
        2 => new(1, 0),  // 右上
        3 => new(0, -1), // 右下
        4 => new(-1, 0), // 左下
        _ => throw new ArgumentOutOfRangeException(nameof(position))
    };

    public static (double X, double Y) Normalize(Cell delta) => delta switch
    {
        // 导出地图的垂直增量与方向键标签相反：地图 Y 为正使用上方按钮，
        // 地图 Y 为负使用下方按钮。这些对应关系已经过设备验证。
        { X: 0, Y: 1 } => FromGamePoint(60, 230),
        { X: 1, Y: 0 } => FromGamePoint(223, 235),
        { X: 0, Y: -1 } => FromGamePoint(213, 88),
        { X: -1, Y: 0 } => FromGamePoint(58, 89),
        _ => throw new ArgumentOutOfRangeException(nameof(delta))
    };

    public static (int X, int Y) ToPixels(Cell delta, int width, int height)
    {
        var normalized = Normalize(delta);
        return ((int)Math.Round(normalized.X * width), (int)Math.Round(normalized.Y * height));
    }

    public static (int X, int Y) ToRawTouchPixels((int X, int Y) logical, int width, int height,
        int rawMaxX, int rawMaxY, int orientation)
    {
        var x = Math.Clamp(logical.X, 0, width - 1);
        var y = Math.Clamp(logical.Y, 0, height - 1);
        return orientation switch
        {
            1 => (Scale(height - 1 - y, height, rawMaxX), Scale(x, width, rawMaxY)),
            2 => (Scale(width - 1 - x, width, rawMaxX), Scale(height - 1 - y, height, rawMaxY)),
            3 => (Scale(y, height, rawMaxX), Scale(width - 1 - x, width, rawMaxY)),
            _ => (Scale(x, width, rawMaxX), Scale(y, height, rawMaxY))
        };
    }

    static int Scale(int value, int size, int rawMax)
        => Math.Clamp((int)Math.Round(value * rawMax / (double)Math.Max(1, size - 1)), 0, rawMax);
}
