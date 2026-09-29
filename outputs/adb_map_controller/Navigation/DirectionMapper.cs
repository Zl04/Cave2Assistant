using System;
using System.Collections.Generic;

namespace AdbMapController;

/// <summary>
/// 将目标地图方向转换为游戏卡顿时必须按下的物理方向按钮。
/// 映射值 1..4 是游戏导出的逻辑方向（上、右、下、左）。
/// </summary>
public static class DirectionMapper
{
    public static Cell ApplyConfusion(Cell desired, bool confused, IReadOnlyList<int> confuseDirections)
    {
        if (!confused || confuseDirections.Count < 4) return desired;
        var actual = desired switch
        {
            { X: 0, Y: -1 } => 1,
            { X: 1, Y: 0 } => 2,
            { X: 0, Y: 1 } => 3,
            { X: -1, Y: 0 } => 4,
            _ => 0
        };
        if (actual == 0) return desired;
        var button = -1;
        for (var i = 0; i < confuseDirections.Count; i++)
            if (confuseDirections[i] == actual) { button = i; break; }
        return button switch
        {
            0 => new(0, -1),
            1 => new(0, 1),
            2 => new(-1, 0),
            3 => new(1, 0),
            _ => desired
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
