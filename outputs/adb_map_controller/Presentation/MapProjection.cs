using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;

namespace AdbMapController;

public sealed class MapProjection
{
    public const float StandardCellSize = 20f;
    readonly int minX, maxY;
    readonly float scale, originX, originY;
    readonly int mapWidth, mapHeight, viewportWidth, viewportHeight;
    public MapProjection(IReadOnlyList<TileInfo> ground, int width, int height, PointF offset = default, float zoom = 1f)
    {
        var maxX = ground.Max(t => t.X); minX = ground.Min(t => t.X);
        var minY = ground.Min(t => t.Y); maxY = ground.Max(t => t.Y);
        mapWidth = maxX - minX + 1;
        mapHeight = maxY - minY + 1;
        viewportWidth = width;
        viewportHeight = height;
        scale = Math.Max(2f, StandardCellSize * zoom);
        originX = (width - mapWidth * scale) / 2f + offset.X;
        originY = (height - mapHeight * scale) / 2f + offset.Y;
    }
    public float Scale => scale;
    public bool FitsViewport => mapWidth * scale <= viewportWidth && mapHeight * scale <= viewportHeight;
    public PointF PointAt(float x, float y) => new(originX + (x - minX + .5f) * scale, originY + (maxY - y + .5f) * scale);
    public PointF Point(Cell cell) => new(originX + (cell.X - minX + .5f) * scale, originY + (maxY - cell.Y + .5f) * scale);
    public PointF MapPositionAt(PointF point) => new(
        minX + (point.X - originX) / scale - .5f,
        maxY - (point.Y - originY) / scale + .5f);
    public Cell CellAt(Point point) => new(
        minX + (int)Math.Floor((point.X - originX) / scale),
        maxY - (int)Math.Floor((point.Y - originY) / scale));

    public PointF ClampOffset(PointF offset, float extraMargin = 0f)
    {
        var baseOriginX = (viewportWidth - mapWidth * scale) / 2f;
        var baseOriginY = (viewportHeight - mapHeight * scale) / 2f;
        return new PointF(
            ClampAxis(offset.X, viewportWidth, mapWidth * scale, baseOriginX, extraMargin),
            ClampAxis(offset.Y, viewportHeight, mapHeight * scale, baseOriginY, extraMargin));
    }

    static float ClampAxis(float offset, float viewport, float extent, float baseOrigin, float extraMargin)
    {
        // 在地图周围保留有意设置的空白边距，使用户缩放后仍可拖动地图，
        // 即使地图在某个轴向上小于视口也是如此。
        if (extent <= viewport)
            return Math.Clamp(offset, -extraMargin, extraMargin);
        var minimum = viewport - (baseOrigin + extent) - extraMargin;
        var maximum = -baseOrigin + extraMargin;
        return Math.Clamp(offset, minimum, maximum);
    }
}
