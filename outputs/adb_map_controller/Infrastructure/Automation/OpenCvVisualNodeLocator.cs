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
        // 地图底色和岩石也有一定饱和度；提高 S 阈值可压掉大部分背景色，只保留高饱和度节点徽章。
        using var colourMask = hsv.InRange(new Scalar(0, 120, 100), new Scalar(180, 255, 255));

        var x0 = Math.Clamp((int)(image.Width * .33), 0, image.Width - 1);
        var x1 = Math.Clamp((int)(image.Width * .90), x0 + 1, image.Width);
        var y0 = Math.Clamp((int)(image.Height * .10), 0, image.Height - 1);
        var y1 = Math.Clamp((int)(image.Height * .78), y0 + 1, image.Height);
        using var roi = new Mat(colourMask, new Rect(x0, y0, x1 - x0, y1 - y0)).Clone();
        // 剑形图标与彩色徽章的高饱和度区域可能被白色剑刃分开，先连接近邻像素再提取整枚徽章。
        using var closeKernel = Cv2.GetStructuringElement(MorphShapes.Ellipse, new OpenCvSharp.Size(11, 11));
        Cv2.MorphologyEx(roi, roi, MorphTypes.Close, closeKernel);
        using var labels = new Mat();
        using var stats = new Mat();
        using var centroids = new Mat();
        var count = Cv2.ConnectedComponentsWithStats(roi, labels, stats, centroids, PixelConnectivity.Connectivity8);
        var candidates = new List<VisualNodeCandidate>();
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
            candidates.Add(new VisualNodeCandidate(center,
                new DrawingRectangle(left, top, width, height), area));
        }

        return candidates
            .Where(x => x.Bounds.Width >= 48 && x.Bounds.Height >= 48)
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

}
