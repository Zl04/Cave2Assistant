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
    static Rect MapRegion(int width, int height)
    {
        var x0 = Math.Clamp((int)(width * (350.0 / 1004)), 0, width - 1);
        var x1 = Math.Clamp((int)(width * (853.0 / 1004)), x0 + 1, width);
        var y0 = Math.Clamp((int)(height * (133.0 / 565)), 0, height - 1);
        var y1 = Math.Clamp((int)(height * (376.0 / 565)), y0 + 1, height);
        return new Rect(x0, y0, x1 - x0, y1 - y0);
    }

    static Rect TimeGateRegion(int width, int height)
    {
        // 时光之门的路线会延伸到通用地图框的上方；171 层旁的徽章位于 (848,126)。
        var x0 = Math.Clamp((int)(width * (300.0 / 1004)), 0, width - 1);
        var x1 = Math.Clamp((int)(width * (900.0 / 1004)), x0 + 1, width);
        var y0 = Math.Clamp((int)(height * (60.0 / 565)), 0, height - 1);
        var y1 = Math.Clamp((int)(height * (440.0 / 565)), y0 + 1, height);
        return new Rect(x0, y0, x1 - x0, y1 - y0);
    }

    static Rect SelectionRegion(int width, int height, int? mapId)
    {
        if (!MapSelectionRegion.HasCustomBounds(mapId)) return MapRegion(width, height);
        var bounds = MapSelectionRegion.ForFrame(mapId.GetValueOrDefault(), width, height);
        return new Rect(bounds.X, bounds.Y, bounds.Width, bounds.Height);
    }
    public static IReadOnlyList<VisualNodeCandidate> FindMapNodes(System.Drawing.Bitmap source, int? mapId = null)
    {
        using var image = OpenCvImage.ToMat(source, ImreadModes.Color);
        using var hsv = image.CvtColor(ColorConversionCodes.BGR2HSV);
        // 地图底色和岩石也有一定饱和度；提高 S 阈值可压掉大部分背景色，只保留高饱和度节点徽章。
        using var colourMask = hsv.InRange(new Scalar(0, 120, 100), new Scalar(180, 255, 255));

        // 各地图使用独立红框，未标定地图继续使用原通用框。
        var selectionRegion = SelectionRegion(image.Width, image.Height, mapId);
        var region = selectionRegion;
        if (mapId is 4 or 5 or DungeonEntryCatalog.TimeGateHeroMapId)
        {
            // 红框可能穿过边缘节点：保留轮廓上下文，仅接纳中心在红框内的节点。
            var marginX = (int)Math.Ceiling(45.0 * image.Width / 1004);
            var marginY = (int)Math.Ceiling(45.0 * image.Height / 565);
            var left = Math.Max(0, region.Left - marginX);
            var top = Math.Max(0, region.Top - marginY);
            region = new Rect(left, top, Math.Min(image.Width, region.Right + marginX) - left,
                Math.Min(image.Height, region.Bottom + marginY) - top);
        }
        var x0 = region.X;
        var y0 = region.Y;
        using var roi = new Mat(colourMask, region).Clone();
        // 剑形图标与彩色徽章的高饱和度区域可能被白色剑刃分开，先连接近邻像素再提取整枚徽章。
        using var closeKernel = Cv2.GetStructuringElement(MorphShapes.Ellipse, mapId == DungeonEntryCatalog.TimeGateHeroMapId
            ? new OpenCvSharp.Size(Math.Max(3, (int)Math.Round(11.0 * image.Width / 1004) | 1), Math.Max(3, (int)Math.Round(11.0 * image.Height / 565) | 1))
            : new OpenCvSharp.Size(11, 11));
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
            var scaledWidth = width * 1004.0 / image.Width;
            var scaledHeight = height * 565.0 / image.Height;
            var scaledArea = area * (1004.0 * 565) / (image.Width * image.Height);
            if (!MapSelectionRegion.HasCustomBounds(mapId)) { scaledWidth = width; scaledHeight = height; scaledArea = area; }
            if (scaledArea < 500 || scaledArea > 16000 ||
                scaledWidth < 42 || scaledHeight < (MapSelectionRegion.HasCustomBounds(mapId) ? 32 : 42) ||
                scaledWidth > 190 || scaledHeight > 190 || aspect < .45 || aspect > 2.20)
                continue;

            var center = new DrawingPoint(left + width / 2, top + height / 2);
            candidates.Add(new VisualNodeCandidate(center,
                new DrawingRectangle(left, top, width, height), area));
        }

        return candidates
            .Where(x => selectionRegion.Contains(new OpenCvSharp.Point(x.Center.X, x.Center.Y)))
            .Where(x => MapSelectionRegion.HasCustomBounds(mapId)
                ? x.Bounds.Width * 1004.0 / image.Width >= 42 && x.Bounds.Height * 565.0 / image.Height >= 32
                : x.Bounds.Width >= 48 && x.Bounds.Height >= 48)
            .OrderBy(x => x.Center.X)
            .ThenBy(x => x.Center.Y)
            .ToArray();
    }

    public static VisualNodeCandidate? FindSelectedMapNode(System.Drawing.Bitmap source,
        IReadOnlyList<VisualNodeCandidate> candidates)
    {
        using var image = OpenCvImage.ToMat(source, ImreadModes.Color);
        using var hsv = image.CvtColor(ColorConversionCodes.BGR2HSV);
        VisualNodeCandidate? selected = null;
        var bestWhiteRatio = .08;
        foreach (var candidate in candidates)
        {
            var bounds = candidate.Bounds;
            var scaledWidth = bounds.Width * 1004.0 / image.Width;
            var scaledHeight = bounds.Height * 565.0 / image.Height;
            if (scaledWidth is < 40 or > 100 || scaledHeight is < 40 or > 100)
                continue;
            var rect = new Rect(bounds.Left, bounds.Top, bounds.Width, bounds.Height);
            using var roi = new Mat(hsv, rect);
            // 选中节点上的白色交叉剑刃在普通彩色徽章中不存在。
            using var white = roi.InRange(new Scalar(0, 0, 170), new Scalar(180, 80, 255));
            var whiteCount = Cv2.CountNonZero(white);
            var whiteRatio = whiteCount / (double)(bounds.Width * bounds.Height);
            if (whiteCount < 100 * image.Width * image.Height / (1004.0 * 565) ||
                whiteRatio <= bestWhiteRatio)
                continue;
            selected = candidate;
            bestWhiteRatio = whiteRatio;
        }
        return selected;
    }

    public static IReadOnlyList<VisualNodeCandidate> FindGoldNodeBadges(System.Drawing.Bitmap source, int? mapId = null)
    {
        using var image = OpenCvImage.ToMat(source, ImreadModes.Color);
        using var hsv = image.CvtColor(ColorConversionCodes.BGR2HSV);
        using var gold = hsv.InRange(new Scalar(8, 90, 65), new Scalar(35, 255, 255));
        var region = SelectionRegion(image.Width, image.Height, mapId);
        using var roi = new Mat(gold, region).Clone();
        var kernelSize = Math.Max(3, (int)Math.Round(7.0 * image.Width / 1004) | 1);
        using var kernel = Cv2.GetStructuringElement(MorphShapes.Ellipse, new OpenCvSharp.Size(kernelSize, kernelSize));
        Cv2.MorphologyEx(roi, roi, MorphTypes.Close, kernel);
        using var labels = new Mat();
        using var stats = new Mat();
        using var centroids = new Mat();
        var count = Cv2.ConnectedComponentsWithStats(roi, labels, stats, centroids, PixelConnectivity.Connectivity8);
        var candidates = new List<VisualNodeCandidate>();
        for (var label = 1; label < count; label++)
        {
            var area = stats.Get<int>(label, (int)ConnectedComponentsTypes.Area);
            var left = stats.Get<int>(label, (int)ConnectedComponentsTypes.Left) + region.X;
            var top = stats.Get<int>(label, (int)ConnectedComponentsTypes.Top) + region.Y;
            var width = stats.Get<int>(label, (int)ConnectedComponentsTypes.Width);
            var height = stats.Get<int>(label, (int)ConnectedComponentsTypes.Height);
            var scaledWidth = width * 1004.0 / image.Width;
            var scaledHeight = height * 565.0 / image.Height;
            var scaledArea = area * (1004.0 * 565) / (image.Width * image.Height);
            if (scaledWidth is < 38 or > 85 || scaledHeight is < 38 or > 85 ||
                scaledArea is < 700 or > 4500 || scaledWidth / scaledHeight is < .65 or > 1.45)
                continue;
            var bounds = new DrawingRectangle(left, top, width, height);
            candidates.Add(new VisualNodeCandidate(new DrawingPoint(left + width / 2, top + height / 2), bounds, area));
        }
        return candidates.OrderBy(x => x.Center.X).ToArray();
    }

    public static IReadOnlyList<VisualNodeCandidate> FindBlueNodeBadges(System.Drawing.Bitmap source, int? mapId = null)
    {
        using var image = OpenCvImage.ToMat(source, ImreadModes.Color);
        using var hsv = image.CvtColor(ColorConversionCodes.BGR2HSV);
        // 时光之门关卡的蓝色圆徽章与连接它们的细点可通过连通区域尺寸区分。
        using var blue = hsv.InRange(new Scalar(90, 100, 110), new Scalar(108, 255, 255));
        var region = mapId is null ? TimeGateRegion(image.Width, image.Height) : SelectionRegion(image.Width, image.Height, mapId);
        using var roi = new Mat(blue, region);
        using var labels = new Mat();
        using var stats = new Mat();
        using var centroids = new Mat();
        var count = Cv2.ConnectedComponentsWithStats(roi, labels, stats, centroids, PixelConnectivity.Connectivity8);
        var candidates = new List<VisualNodeCandidate>();
        for (var label = 1; label < count; label++)
        {
            var area = stats.Get<int>(label, (int)ConnectedComponentsTypes.Area);
            var left = stats.Get<int>(label, (int)ConnectedComponentsTypes.Left) + region.X;
            var top = stats.Get<int>(label, (int)ConnectedComponentsTypes.Top) + region.Y;
            var width = stats.Get<int>(label, (int)ConnectedComponentsTypes.Width);
            var height = stats.Get<int>(label, (int)ConnectedComponentsTypes.Height);
            var scaledWidth = width * 1004.0 / image.Width;
            var scaledHeight = height * 565.0 / image.Height;
            var scaledArea = area * (1004.0 * 565) / (image.Width * image.Height);
            if (scaledWidth is < 42 or > 70 || scaledHeight is < 40 or > 65 ||
                scaledArea is < 700 or > 2500 || scaledWidth / scaledHeight is < .75 or > 1.40)
                continue;
            var bounds = new DrawingRectangle(left, top, width, height);
            candidates.Add(new VisualNodeCandidate(new DrawingPoint(left + width / 2, top + height / 2), bounds, area));
        }
        return candidates.OrderBy(x => x.Center.X).ToArray();
    }

    public static IReadOnlyList<DrawingRectangle> FindSweepButtonRegions(System.Drawing.Bitmap source, int? mapId = null)
    {
        // 时光之门英雄页的节点是带“银色/暗金”等标签的奖励宝箱，没有扫荡条。
        // 其中黄色宝箱会满足普通地图扫荡按钮的颜色和尺寸条件，不能作为点击禁区。
        if (mapId == DungeonEntryCatalog.TimeGateHeroMapId) return [];

        using var image = OpenCvImage.ToMat(source, ImreadModes.Color);
        using var hsv = image.CvtColor(ColorConversionCodes.BGR2HSV);
        using var yellow = hsv.InRange(new Scalar(15, 110, 90), new Scalar(40, 255, 255));
        var region = SelectionRegion(image.Width, image.Height, mapId);
        using var roi = new Mat(yellow, region);
        using var labels = new Mat();
        using var stats = new Mat();
        using var centroids = new Mat();
        var count = Cv2.ConnectedComponentsWithStats(roi, labels, stats, centroids, PixelConnectivity.Connectivity8);
        var buttons = new List<DrawingRectangle>();
        for (var label = 1; label < count; label++)
        {
            var area = stats.Get<int>(label, (int)ConnectedComponentsTypes.Area);
            var left = stats.Get<int>(label, (int)ConnectedComponentsTypes.Left) + region.X;
            var top = stats.Get<int>(label, (int)ConnectedComponentsTypes.Top) + region.Y;
            var width = stats.Get<int>(label, (int)ConnectedComponentsTypes.Width);
            var height = stats.Get<int>(label, (int)ConnectedComponentsTypes.Height);
            var scaledWidth = width * 1004.0 / image.Width;
            var scaledHeight = height * 565.0 / image.Height;
            var scaledArea = area * (1004.0 * 565) / (image.Width * image.Height);
            // 黄色“扫荡”文字条约 63×23；节点圆徽章高度明显更大。
            if (scaledWidth is < 50 or > 110 || scaledHeight is < 17 or > 34 ||
                scaledArea is < 500 or > 2600)
                continue;
            var marginX = (int)Math.Ceiling(20.0 * image.Width / 1004);
            var marginY = (int)Math.Ceiling(18.0 * image.Height / 565);
            buttons.Add(new DrawingRectangle(left - marginX, top - marginY,
                width + marginX * 2, height + marginY * 2));
        }
        return buttons;
    }

    public static bool IsMapStill(System.Drawing.Bitmap previous, System.Drawing.Bitmap current,
        out double displacement, out double response)
    {
        using var before = MapMotionFrame(previous);
        using var after = MapMotionFrame(current);
        using var noWindow = new Mat();
        var shift = Cv2.PhaseCorrelate(before, after, noWindow, out response);
        displacement = Math.Sqrt(shift.X * shift.X + shift.Y * shift.Y);
        // 500×240 采样图中移动超过 1 像素即视为仍在滚动。
        return response >= .80 && displacement <= 1.0;
    }

    static Mat MapMotionFrame(System.Drawing.Bitmap bitmap)
    {
        using var image = OpenCvImage.ToMat(bitmap, ImreadModes.Color);
        using var region = new Mat(image, MapRegion(image.Width, image.Height));
        using var gray = region.CvtColor(ColorConversionCodes.BGR2GRAY);
        using var small = gray.Resize(new OpenCvSharp.Size(500, 240), interpolation: InterpolationFlags.Area);
        using var blurred = small.GaussianBlur(new OpenCvSharp.Size(5, 5), 0);
        var result = new Mat();
        blurred.ConvertTo(result, MatType.CV_32FC1);
        return result;
    }

}
