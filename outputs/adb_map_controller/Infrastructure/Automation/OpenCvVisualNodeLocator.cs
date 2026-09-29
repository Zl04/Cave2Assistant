using DrawingPoint = System.Drawing.Point;
using DrawingRectangle = System.Drawing.Rectangle;
using OpenCvSharp;

namespace AdbMapController;

/// <summary>
/// OpenCV implementation for the non-template map markers. It uses HSV masking
/// and connected components instead of walking pixels in managed C# code.
/// </summary>
public static class OpenCvVisualNodeLocator
{
    public static IReadOnlyList<VisualNodeCandidate> FindMapNodes(System.Drawing.Bitmap source)
    {
        using var image = OpenCvImage.ToMat(source, ImreadModes.Color);
        using var hsv = image.CvtColor(ColorConversionCodes.BGR2HSV);
        using var colourMask = hsv.InRange(new Scalar(0, 45, 90), new Scalar(180, 255, 255));

        var x0 = Math.Clamp((int)(image.Width * .33), 0, image.Width - 1);
        var x1 = Math.Clamp((int)(image.Width * .90), x0 + 1, image.Width);
        var y0 = Math.Clamp((int)(image.Height * .10), 0, image.Height - 1);
        var y1 = Math.Clamp((int)(image.Height * .78), y0 + 1, image.Height);
        using var roi = new Mat(colourMask, new Rect(x0, y0, x1 - x0, y1 - y0)).Clone();
        using var labels = new Mat();
        using var stats = new Mat();
        using var centroids = new Mat();
        var count = Cv2.ConnectedComponentsWithStats(roi, labels, stats, centroids, PixelConnectivity.Connectivity8);
        var components = new List<Blob>();
        for (var label = 1; label < count; label++)
        {
            var area = stats.Get<int>(label, (int)ConnectedComponentsTypes.Area);
            var left = stats.Get<int>(label, (int)ConnectedComponentsTypes.Left) + x0;
            var top = stats.Get<int>(label, (int)ConnectedComponentsTypes.Top) + y0;
            var width = stats.Get<int>(label, (int)ConnectedComponentsTypes.Width);
            var height = stats.Get<int>(label, (int)ConnectedComponentsTypes.Height);
            var aspect = width / (double)Math.Max(1, height);
            if (area < 500 || area > 16000 || width < 42 || height < 42 ||
                width > 190 || height > 190 || aspect < .45 || aspect > 2.20)
                continue;

            var center = new DrawingPoint(left + width / 2, top + height / 2);
            if (center.X > image.Width * .86 || center.Y > image.Height * .68) continue;
            var weightedX = (int)Math.Round(centroids.Get<double>(label, 0) + x0);
            var weightedY = (int)Math.Round(centroids.Get<double>(label, 1) + y0);
            components.Add(new Blob(area, new DrawingRectangle(left, top, width, height), center,
                new DrawingPoint(weightedX, weightedY)));
        }

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
    }

    public static VisualIconCandidate? FindMapSwitchIcon(System.Drawing.Bitmap source)
    {
        using var image = OpenCvImage.ToMat(source, ImreadModes.Color);
        using var hsv = image.CvtColor(ColorConversionCodes.BGR2HSV);
        using var mask = hsv.InRange(new Scalar(0, 42, 75), new Scalar(180, 255, 255));
        var x1 = Math.Clamp((int)(image.Width * .34), 1, image.Width);
        var y1 = Math.Clamp((int)(image.Height * .30), 1, image.Height);
        using var roi = new Mat(mask, new Rect(0, 0, x1, y1)).Clone();
        if (Cv2.CountNonZero(roi) < image.Width * image.Height * .006) return null;

        using var points = roi.FindNonZero();
        if (points.Empty()) return null;
        var local = Cv2.BoundingRect(points);
        var bounds = new DrawingRectangle(local.X, local.Y, local.Width, local.Height);
        if (bounds.Width < image.Width * .12 || bounds.Height < image.Height * .10) return null;
        var center = new DrawingPoint(bounds.Left + bounds.Width / 2, bounds.Top + bounds.Height / 2);
        return new VisualIconCandidate(center, bounds, Cv2.CountNonZero(roi));
    }

    static bool CanMerge(Blob a, Blob b)
    {
        var union = DrawingRectangle.Union(a.Bounds, b.Bounds);
        var dx = Math.Max(0, Math.Max(a.Bounds.Left - b.Bounds.Right, b.Bounds.Left - a.Bounds.Right));
        var dy = Math.Max(0, Math.Max(a.Bounds.Top - b.Bounds.Bottom, b.Bounds.Top - a.Bounds.Bottom));
        return dx <= 24 && dy <= 24 && union.Width <= 180 && union.Height <= 180 &&
            Distance(a.Center, b.Center) <= 100;
    }

    static Blob Merge(Blob a, Blob b)
    {
        var bounds = DrawingRectangle.Union(a.Bounds, b.Bounds);
        var area = a.Area + b.Area;
        return new Blob(area, bounds,
            new DrawingPoint((a.Center.X + b.Center.X) / 2, (a.Center.Y + b.Center.Y) / 2),
            new DrawingPoint((a.WeightedCenter.X * a.Area + b.WeightedCenter.X * b.Area) / Math.Max(1, area),
                (a.WeightedCenter.Y * a.Area + b.WeightedCenter.Y * b.Area) / Math.Max(1, area)));
    }

    static double Distance(DrawingPoint a, DrawingPoint b)
        => Math.Sqrt(Math.Pow(a.X - b.X, 2) + Math.Pow(a.Y - b.Y, 2));

    sealed record Blob(int Area, DrawingRectangle Bounds, DrawingPoint Center, DrawingPoint WeightedCenter);
}
