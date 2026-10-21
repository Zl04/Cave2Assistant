using System;
using System.Drawing;
using System.IO;
using OpenCvSharp;
using DrawingSize = System.Drawing.Size;
using CvSize = OpenCvSharp.Size;

namespace AdbMapController;

/// <summary>
/// Aligns the game's original six-slot quickbar sprite to a frame and removes
/// only its opaque pixels from a quantity crop. Item icons and counts remain.
/// </summary>
internal sealed class QuickbarBackground : IDisposable
{
    // Game source: config.lua uses a 1136x640 design resolution and switches
    // between FIXED_HEIGHT/FIXED_WIDTH. MainUILayer centers the 580x540
    // ItemPanel 5 units above the bottom. Component/cc.Layer uses its local
    // lower-left as the child origin; quickBarAllNode stays at local (0,0).
    // ItemPanel places a 552x233 Scale9 quickbar at (-15,-153) and explicitly
    // gives that sprite anchor (0,0), so the position is its lower-left. No
    // half-width/half-height anchor correction belongs in this transform.
    // Only its unchanged top strip
    // is visible on screen, so the original 552x133 sprite can be sampled at
    // the game's design-to-frame scale.
    const double DesignWidth = 1136d;
    const double DesignHeight = 640d;
    const double ItemPanelWidth = 580d;
    const double ItemPanelBottom = 5d;
    const double QuickbarX = -15d;
    const double QuickbarY = -153d;
    const double QuickbarHeight = 233d;
    readonly Mat source;

    readonly record struct Alignment(double Scale, int X, int Y);

    public QuickbarBackground(string path)
    {
        source = Cv2.ImRead(path, ImreadModes.Unchanged);
        if (source.Empty() || source.Channels() != 4)
            throw new InvalidDataException($"快捷栏底板资源必须为带透明通道的图片：{path}");
    }

    public Bitmap? RemoveFromQuantity(Bitmap frame, Rectangle quantity)
        => RemoveFromQuantity(frame, quantity, preserveColor: false);

    public Bitmap? RemoveFromQuantityPreservingColor(Bitmap frame, Rectangle quantity)
        => RemoveFromQuantity(frame, quantity, preserveColor: true);

    Bitmap? RemoveFromQuantity(Bitmap frame, Rectangle quantity, bool preserveColor)
    {
        using var scene = OpenCvImage.ToMat(frame);
        var alignment = FromResolution(frame.Size);

        using var scaled = Resize(alignment.Scale);
        var local = new Rect(quantity.X - alignment.X, quantity.Y - alignment.Y,
            quantity.Width, quantity.Height);
        if (local.X < 0 || local.Y < 0 || local.Right > scaled.Width || local.Bottom > scaled.Height)
            return null;

        using var background = new Mat(scaled, local);
        using var backgroundBgr = new Mat();
        using var alpha = new Mat();
        using var opaque = new Mat();
        Cv2.CvtColor(background, backgroundBgr, ColorConversionCodes.BGRA2BGR);
        Cv2.ExtractChannel(background, alpha, 3);
        Cv2.Threshold(alpha, opaque, 249, 255, ThresholdTypes.Binary);
        using var current = new Mat(scene, new Rect(quantity.X, quantity.Y, quantity.Width, quantity.Height));
        using var difference = new Mat();
        Cv2.Absdiff(current, backgroundBgr, difference);
        if (preserveColor)
        {
            // Subtract the aligned sprite but keep the count's color and soft
            // edges. Alpha scales the difference without thresholding pixels.
            using var alphaBgr = new Mat();
            using var colorDifference = new Mat();
            Cv2.CvtColor(alpha, alphaBgr, ColorConversionCodes.GRAY2BGR);
            Cv2.Multiply(difference, alphaBgr, colorDifference, 1d / 255d);
            return ToBitmap(colorDifference);
        }
        using var grayscale = new Mat();
        using var foreground = new Mat();
        Cv2.CvtColor(difference, grayscale, ColorConversionCodes.BGR2GRAY);
        Cv2.Threshold(grayscale, foreground, 20, 255, ThresholdTypes.Binary);
        Cv2.BitwiseAnd(foreground, opaque, foreground);
        // The crop begins inside the icon. Its upper edge may contain icon
        // highlights, while the quantity label is on the lower baseline.
        using (var iconEdge = foreground.RowRange(0, (int)Math.Round(quantity.Height * .30)))
            iconEdge.SetTo(Scalar.Black);
        using var labels = new Mat();
        using var stats = new Mat();
        using var centroids = new Mat();
        var componentCount = Cv2.ConnectedComponentsWithStats(foreground, labels, stats, centroids,
            PixelConnectivity.Connectivity8);
        for (var label = 1; label < componentCount; label++)
        {
            // A partial icon crossing the left edge can resemble a digit.
            // Remove only edge-connected fragments; keep the full OCR crop.
            if (stats.Get<int>(label, (int)ConnectedComponentsTypes.Left) > 1) continue;
            using var component = new Mat();
            Cv2.Compare(labels, new Scalar(label), component, CmpType.EQ);
            foreground.SetTo(Scalar.Black, component);
        }
        if (Cv2.CountNonZero(foreground) == 0) return null;

        return ToBitmap(foreground);
    }

    static Bitmap ToBitmap(Mat pixels)
    {
        Cv2.ImEncode(".png", pixels, out var bytes);
        using var stream = new MemoryStream(bytes);
        using var decoded = new Bitmap(stream);
        return new Bitmap(decoded);
    }

    internal static (double Scale, int X, int Y) AlignmentFor(DrawingSize frame)
    {
        var fixedHeight = frame.Width / (double)frame.Height >= DesignWidth / DesignHeight;
        var scale = fixedHeight ? frame.Height / DesignHeight : frame.Width / DesignWidth;
        var designFrameWidth = frame.Width / scale;
        var panelX = (designFrameWidth - ItemPanelWidth) / 2d;
        var quickbarLeft = panelX + QuickbarX;
        var quickbarTop = ItemPanelBottom + QuickbarY + QuickbarHeight;
        return (scale,
            (int)Math.Round(quickbarLeft * scale),
            (int)Math.Round(frame.Height - quickbarTop * scale));
    }

    internal static double ScaleRelativeToFullHd(DrawingSize frame)
        => AlignmentFor(frame).Scale / (1080d / DesignHeight);

    static Alignment FromResolution(DrawingSize frame)
    {
        var (scale, x, y) = AlignmentFor(frame);
        return new Alignment(scale, x, y);
    }

    Mat Resize(double scale)
    {
        var image = new Mat();
        Cv2.Resize(source, image,
            new CvSize((int)Math.Round(source.Width * scale), (int)Math.Round(source.Height * scale)),
            interpolation: InterpolationFlags.Linear);
        return image;
    }

    public void Dispose() => source.Dispose();
}
