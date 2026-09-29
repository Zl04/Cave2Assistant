using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Runtime.InteropServices;

namespace AdbMapController;

#pragma warning disable CS8602, CS8604 // legacy managed scanner below is unreachable; OpenCV implementation is active.

/// <summary>
/// 查找洞窟选择器中的大型彩色剑形节点。
/// 地图使用不同的配色（金色、紫色、青色和蓝色），但可选节点具有两个共同的视觉属性：
/// 高饱和度外部徽章和大致方形的轮廓。小型彩色路线点和大型侧面板会被组件大小/形状检查排除。
/// </summary>
public static class VisualNodeLocator
{
    public static IReadOnlyList<VisualNodeCandidate> FindMapNodes(Bitmap source)
    {
        return OpenCvVisualNodeLocator.FindMapNodes(source);
#pragma warning disable CS0162
        using var image = new Bitmap(source.Width, source.Height, PixelFormat.Format24bppRgb);
        using (var graphics = Graphics.FromImage(image)) graphics.DrawImageUnscaled(source, 0, 0);
        var width = image.Width;
        var height = image.Height;
        var x0 = Math.Clamp((int)(width * .33), 0, width - 1);
        var x1 = Math.Clamp((int)(width * .90), x0 + 1, width);
        var y0 = Math.Clamp((int)(height * .10), 0, height - 1);
        var y1 = Math.Clamp((int)(height * .78), y0 + 1, height);
        var pixels = ReadPixels(image);
        var visited = new bool[width * height];
        var components = new List<Blob>();

        for (var y = y0; y < y1; y++)
        for (var x = x0; x < x1; x++)
        {
            var index = y * width + x;
            if (visited[index] || !IsMapColour(pixels, index)) continue;
            var queue = new Queue<Point>();
            queue.Enqueue(new Point(x, y));
            visited[index] = true;
            var count = 0;
            var sumX = 0L;
            var sumY = 0L;
            var left = x;
            var right = x;
            var top = y;
            var bottom = y;
            while (queue.Count > 0)
            {
                var point = queue.Dequeue();
                count++;
                sumX += point.X;
                sumY += point.Y;
                left = Math.Min(left, point.X);
                right = Math.Max(right, point.X);
                top = Math.Min(top, point.Y);
                bottom = Math.Max(bottom, point.Y);
                TryQueue(queue, point.X + 1, point.Y);
                TryQueue(queue, point.X - 1, point.Y);
                TryQueue(queue, point.X, point.Y + 1);
                TryQueue(queue, point.X, point.Y - 1);
            }

            var blobWidth = right - left + 1;
            var blobHeight = bottom - top + 1;
            var aspect = blobWidth / (double)Math.Max(1, blobHeight);
            if (count < 500 || count > 16000 || blobWidth < 42 || blobHeight < 42 ||
                blobWidth > 190 || blobHeight > 190 || aspect < .45 || aspect > 2.20)
                continue;
            var center = new Point((left + right) / 2, (top + bottom) / 2);
            if (center.X > width * .86 || center.Y > height * .68) continue;
            components.Add(new Blob(count, new Rectangle(left, top, blobWidth, blobHeight), center,
                new Point((int)(sumX / Math.Max(1, count)), (int)(sumY / Math.Max(1, count)))));
        }

        // 少数徽章中有白色剑形穿过彩色圆环，会将掩码分成两个相近组件。
        // 只合并距离较近的组件，并限制合并后的范围，避免路线点链被识别为节点。
        var merged = new List<Blob>();
        foreach (var component in components.OrderByDescending(x => x.Area))
        {
            var index = merged.FindIndex(x => CanMerge(x, component));
            if (index < 0) merged.Add(component);
            else merged[index] = Merge(merged[index], component);
        }

        return merged
            .Where(x => x.Bounds.Width >= 48 && x.Bounds.Height >= 48)
            .Select(x => new VisualNodeCandidate(x.Center, x.Bounds, x.Area))
            .OrderBy(x => x.Center.X)
            .ThenBy(x => x.Center.Y)
            .ToArray();

        void TryQueue(Queue<Point> queue, int nx, int ny)
        {
            if (nx < x0 || nx >= x1 || ny < y0 || ny >= y1) return;
            var ni = ny * width + nx;
            if (visited[ni] || !IsMapColour(pixels, ni)) return;
            visited[ni] = true;
            queue.Enqueue(new Point(nx, ny));
        }
#pragma warning restore CS0162
    }

    /// <summary>
    /// 定位打开三卡选择器的大型地图标题图标。
    /// 有意根据当前帧的颜色面积而不是固定坐标定位，因为三种地图皮肤使用不同颜色。
    /// </summary>
    public static VisualIconCandidate? FindMapSwitchIcon(Bitmap source)
    {
        return OpenCvVisualNodeLocator.FindMapSwitchIcon(source);
#pragma warning disable CS0162
        using var image = new Bitmap(source.Width, source.Height, PixelFormat.Format24bppRgb);
        using (var graphics = Graphics.FromImage(image)) graphics.DrawImageUnscaled(source, 0, 0);
        var pixels = ReadPixels(image);
        var x1 = Math.Clamp((int)(source.Width * .34), 1, source.Width);
        var y1 = Math.Clamp((int)(source.Height * .30), 1, source.Height);
        var points = new List<Point>();
        for (var y = 0; y < y1; y++)
        for (var x = 0; x < x1; x++)
        {
            var index = y * source.Width + x;
            var (r, g, b) = pixels[index];
            var max = Math.Max(r, Math.Max(g, b));
            var min = Math.Min(r, Math.Min(g, b));
            if (max >= 75 && max - min >= 42) points.Add(new Point(x, y));
        }
        if (points.Count < source.Width * source.Height * .006) return null;
        var bounds = Rectangle.FromLTRB(points.Min(x => x.X), points.Min(x => x.Y),
            points.Max(x => x.X) + 1, points.Max(x => x.Y) + 1);
        if (bounds.Width < source.Width * .12 || bounds.Height < source.Height * .10) return null;
        var center = new Point(bounds.Left + bounds.Width / 2, bounds.Top + bounds.Height / 2);
        return new VisualIconCandidate(center, bounds, points.Count);
#pragma warning restore CS0162
    }

    static bool CanMerge(Blob a, Blob b)
    {
        var union = Rectangle.Union(a.Bounds, b.Bounds);
        var dx = Math.Max(0, Math.Max(a.Bounds.Left - b.Bounds.Right, b.Bounds.Left - a.Bounds.Right));
        var dy = Math.Max(0, Math.Max(a.Bounds.Top - b.Bounds.Bottom, b.Bounds.Top - a.Bounds.Bottom));
        return dx <= 24 && dy <= 24 && union.Width <= 180 && union.Height <= 180 &&
            Distance(a.Center, b.Center) <= 100;
    }

    static Blob Merge(Blob a, Blob b)
    {
        var bounds = Rectangle.Union(a.Bounds, b.Bounds);
        var area = a.Area + b.Area;
        return new Blob(area, bounds,
            new Point((a.Center.X + b.Center.X) / 2, (a.Center.Y + b.Center.Y) / 2),
            new Point((a.WeightedCenter.X * a.Area + b.WeightedCenter.X * b.Area) / Math.Max(1, area),
                (a.WeightedCenter.Y * a.Area + b.WeightedCenter.Y * b.Area) / Math.Max(1, area)));
    }

    static double Distance(Point a, Point b)
        => Math.Sqrt(Math.Pow(a.X - b.X, 2) + Math.Pow(a.Y - b.Y, 2));

    static bool IsMapColour((byte R, byte G, byte B)[] pixels, int index)
    {
        var (r, g, b) = pixels[index];
        var max = Math.Max(r, Math.Max(g, b));
        var min = Math.Min(r, Math.Min(g, b));
        return max >= 90 && max - min >= 45;
    }

    static (byte R, byte G, byte B)[] ReadPixels(Bitmap bitmap)
    {
        var rect = new Rectangle(0, 0, bitmap.Width, bitmap.Height);
        var data = bitmap.LockBits(rect, ImageLockMode.ReadOnly, PixelFormat.Format24bppRgb);
        try
        {
            var result = new (byte R, byte G, byte B)[bitmap.Width * bitmap.Height];
            for (var y = 0; y < bitmap.Height; y++)
            {
                var row = IntPtr.Add(data.Scan0, y * data.Stride);
                for (var x = 0; x < bitmap.Width; x++)
                {
                    var offset = x * 3;
                    result[y * bitmap.Width + x] = (Marshal.ReadByte(row, offset + 2),
                        Marshal.ReadByte(row, offset + 1), Marshal.ReadByte(row, offset));
                }
            }
            return result;
        }
        finally { bitmap.UnlockBits(data); }
    }

    sealed record Blob(int Area, Rectangle Bounds, Point Center, Point WeightedCenter);
}

public sealed record VisualNodeCandidate(Point Center, Rectangle Bounds, int Area);

public sealed record VisualIconCandidate(Point Center, Rectangle Bounds, int PixelCount);
