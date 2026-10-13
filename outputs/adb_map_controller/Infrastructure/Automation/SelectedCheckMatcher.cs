using System.Collections.Concurrent;
using System.Drawing;

namespace AdbMapController;

/// <summary>只在指定方框附近进行 RGB 归一化平方差模板匹配。</summary>
public sealed class SelectedCheckMatcher
{
    static readonly ConcurrentDictionary<string, SelectedCheckMatcher> Cache = new();
    readonly Color[] pixels;
    readonly int width, height;
    readonly double energy;

    SelectedCheckMatcher(string path)
    {
        using var image = new Bitmap(path);
        width = image.Width; height = image.Height;
        if (width < 4 || height < 4 || width > 32 || height > 32)
            throw new InvalidDataException("装备勾号模板必须为 4～32 像素");
        pixels = new Color[width * height];
        for (var y = 0; y < height; y++)
        for (var x = 0; x < width; x++)
        {
            var c = image.GetPixel(x, y); pixels[y * width + x] = c;
            energy += c.R * c.R + c.G * c.G + c.B * c.B;
        }
    }

    public static SelectedCheckMatcher Load(string path)
        => Cache.GetOrAdd(Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, path)), p => new(p));

    public double Score(Bitmap frame, Rectangle area)
    {
        area = Rectangle.Intersect(area, new Rectangle(Point.Empty, frame.Size));
        if (area.Width < width || area.Height < height) return 0;
        var region = new Color[area.Width * area.Height];
        for (var y = 0; y < area.Height; y++)
        for (var x = 0; x < area.Width; x++) region[y * area.Width + x] = frame.GetPixel(area.X + x, area.Y + y);
        var best = 0d;
        for (var y = 0; y <= area.Height - height; y++)
        for (var x = 0; x <= area.Width - width; x++)
        {
            double difference = 0, candidateEnergy = 0;
            for (var yy = 0; yy < height; yy++)
            for (var xx = 0; xx < width; xx++)
            {
                var a = pixels[yy * width + xx]; var b = region[(y + yy) * area.Width + x + xx];
                difference += (a.R - b.R) * (a.R - b.R) + (a.G - b.G) * (a.G - b.G) + (a.B - b.B) * (a.B - b.B);
                candidateEnergy += b.R * b.R + b.G * b.G + b.B * b.B;
            }
            if (candidateEnergy > 0 && energy > 0)
                best = Math.Max(best, 1 - difference / Math.Sqrt(energy * candidateEnergy));
        }
        return Math.Clamp(best, 0, 1);
    }
}
