using System;
using System.Drawing;
using System.IO;
using OpenCvSharp;
using CvSize = OpenCvSharp.Size;

namespace AdbMapController;

/// <summary>
/// Aligns the game's original six-slot quickbar sprite to a frame and removes
/// only its opaque pixels from a quantity crop. Item icons and counts remain.
/// </summary>
internal sealed class QuickbarBackground : IDisposable
{
    readonly Mat source;
    Alignment? cached;

    readonly record struct Alignment(int Width, int Height, double Scale, int X, int Y);

    public QuickbarBackground(string path)
    {
        source = Cv2.ImRead(path, ImreadModes.Unchanged);
        if (source.Empty() || source.Channels() != 4)
            throw new InvalidDataException($"快捷栏底板资源必须为带透明通道的图片：{path}");
    }

    public Bitmap? RemoveFromQuantity(Bitmap frame, Rectangle quantity)
    {
        using var scene = OpenCvImage.ToMat(frame);
        var alignment = cached;
        if (alignment is null || alignment.Value.Width != frame.Width || alignment.Value.Height != frame.Height ||
            UnchangedFraction(scene, alignment.Value) < .35)
        {
            alignment = Calibrate(scene);
            cached = alignment;
        }
        if (alignment is null) return null;

        using var scaled = Resize(alignment.Value.Scale);
        var local = new Rect(quantity.X - alignment.Value.X, quantity.Y - alignment.Value.Y,
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
        using var grayscale = new Mat();
        using var foreground = new Mat();
        Cv2.Absdiff(current, backgroundBgr, difference);
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

        Cv2.ImEncode(".png", foreground, out var bytes);
        using var stream = new MemoryStream(bytes);
        using var decoded = new Bitmap(stream);
        return new Bitmap(decoded);
    }

    Alignment? Calibrate(Mat scene)
    {
        var nominal = 1.685 * scene.Height / 1080d;
        var visibleHeight = Math.Max(24, (int)Math.Round(scene.Height * .115));
        var left = Math.Max(0, (int)Math.Round(scene.Width * .18));
        var top = Math.Max(0, (int)Math.Round(scene.Height * .82));
        var right = Math.Min(scene.Width, (int)Math.Round(scene.Width * .75));
        var bottom = Math.Min(scene.Height, (int)Math.Round(scene.Height * .996));
        if (right <= left || bottom <= top) return null;
        using var search = new Mat(scene, new Rect(left, top, right - left, bottom - top));

        double bestMatch = 0;
        Alignment? coarse = null;
        for (var step = -4; step <= 4; step++)
        {
            var scale = nominal * (1 + step * .005);
            using var scaled = Resize(scale);
            if (scaled.Width > search.Width || visibleHeight > search.Height || visibleHeight > scaled.Height)
                continue;
            using var strip = new Mat(scaled, new Rect(0, 0, scaled.Width, visibleHeight));
            using var color = new Mat();
            using var alpha = new Mat();
            using var mask = new Mat();
            Cv2.CvtColor(strip, color, ColorConversionCodes.BGRA2BGR);
            Cv2.ExtractChannel(strip, alpha, 3);
            Cv2.Threshold(alpha, mask, 249, 255, ThresholdTypes.Binary);
            using var response = new Mat();
            Cv2.MatchTemplate(search, color, response, TemplateMatchModes.CCorrNormed, mask);
            Cv2.MinMaxLoc(response, out _, out var score, out _, out var location);
            if (score <= bestMatch) continue;
            bestMatch = score;
            coarse = new Alignment(scene.Width, scene.Height, scale, left + location.X, top + location.Y);
        }
        if (coarse is null || bestMatch < .60) return null;

        // Icons obscure much of the sprite. Score the fraction of pixels that
        // remain unchanged to refine the location without trusting icon colors.
        Alignment? best = null;
        var bestFraction = 0d;
        for (var scaleStep = -2; scaleStep <= 2; scaleStep++)
        {
            var scale = coarse.Value.Scale * (1 + scaleStep * .0015);
            for (var dx = -3; dx <= 3; dx++)
            for (var dy = -4; dy <= 4; dy++)
            {
                var candidate = new Alignment(scene.Width, scene.Height, scale,
                    coarse.Value.X + dx, coarse.Value.Y + dy);
                var fraction = UnchangedFraction(scene, candidate);
                if (fraction <= bestFraction) continue;
                bestFraction = fraction;
                best = candidate;
            }
        }
        return bestFraction >= .35 ? best : null;
    }

    double UnchangedFraction(Mat scene, Alignment alignment)
    {
        using var scaled = Resize(alignment.Scale);
        var height = Math.Min(scaled.Height, scene.Height - alignment.Y);
        if (alignment.X < 0 || alignment.Y < 0 ||
            alignment.X + scaled.Width > scene.Width || height < 24) return 0;
        using var strip = new Mat(scaled, new Rect(0, 0, scaled.Width, height));
        using var color = new Mat();
        using var alpha = new Mat();
        using var mask = new Mat();
        Cv2.CvtColor(strip, color, ColorConversionCodes.BGRA2BGR);
        Cv2.ExtractChannel(strip, alpha, 3);
        Cv2.Threshold(alpha, mask, 249, 255, ThresholdTypes.Binary);
        using var current = new Mat(scene, new Rect(alignment.X, alignment.Y, scaled.Width, height));
        using var difference = new Mat();
        using var grayscale = new Mat();
        using var unchanged = new Mat();
        Cv2.Absdiff(current, color, difference);
        Cv2.CvtColor(difference, grayscale, ColorConversionCodes.BGR2GRAY);
        Cv2.Threshold(grayscale, unchanged, 4, 255, ThresholdTypes.BinaryInv);
        Cv2.BitwiseAnd(unchanged, mask, unchanged);
        var opaqueCount = Cv2.CountNonZero(mask);
        return opaqueCount == 0 ? 0 : Cv2.CountNonZero(unchanged) / (double)opaqueCount;
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
