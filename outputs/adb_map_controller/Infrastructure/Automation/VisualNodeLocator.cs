using System.Collections.Generic;
using System.Drawing;

namespace AdbMapController;

/// <summary>使用 OpenCV 查找地图节点和地图切换图标。</summary>
public static class VisualNodeLocator
{
    public static IReadOnlyList<VisualNodeCandidate> FindMapNodes(Bitmap source)
        => OpenCvVisualNodeLocator.FindMapNodes(source);

    public static VisualNodeCandidate? FindSelectedMapNode(Bitmap source,
        IReadOnlyList<VisualNodeCandidate> candidates)
        => OpenCvVisualNodeLocator.FindSelectedMapNode(source, candidates);

    public static IReadOnlyList<VisualNodeCandidate> FindGoldNodeBadges(Bitmap source)
        => OpenCvVisualNodeLocator.FindGoldNodeBadges(source);

    public static IReadOnlyList<VisualNodeCandidate> FindBlueNodeBadges(Bitmap source)
        => OpenCvVisualNodeLocator.FindBlueNodeBadges(source);

    public static IReadOnlyList<Rectangle> FindSweepButtonRegions(Bitmap source)
        => OpenCvVisualNodeLocator.FindSweepButtonRegions(source);

    public static bool IsMapStill(Bitmap previous, Bitmap current,
        out double displacement, out double response)
        => OpenCvVisualNodeLocator.IsMapStill(previous, current, out displacement, out response);

    public static VisualIconCandidate? FindMapSwitchIcon(Bitmap source)
        => OpenCvVisualNodeLocator.FindMapSwitchIcon(source);
}

public sealed record VisualNodeCandidate(Point Center, Rectangle Bounds, int Area);
public sealed record VisualIconCandidate(Point Center, Rectangle Bounds, int PixelCount);
