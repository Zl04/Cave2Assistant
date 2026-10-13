using System.Collections.Generic;
using System.Drawing;

namespace AdbMapController;

/// <summary>使用 OpenCV 查找地图节点和地图切换图标。</summary>
public static class VisualNodeLocator
{
    public static IReadOnlyList<VisualNodeCandidate> FindMapNodes(Bitmap source)
        => OpenCvVisualNodeLocator.FindMapNodes(source);

    public static VisualIconCandidate? FindMapSwitchIcon(Bitmap source)
        => OpenCvVisualNodeLocator.FindMapSwitchIcon(source);
}

public sealed record VisualNodeCandidate(Point Center, Rectangle Bounds, int Area);
public sealed record VisualIconCandidate(Point Center, Rectangle Bounds, int PixelCount);
