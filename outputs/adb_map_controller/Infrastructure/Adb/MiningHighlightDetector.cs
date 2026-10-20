using System;
using System.Drawing;
using OpenCvSharp;
using CvPoint = OpenCvSharp.Point;
using DrawingPoint = System.Drawing.Point;

namespace AdbMapController;

internal readonly record struct MiningHighlight(DrawingPoint Click, Rect Bounds, double Area);

/// <summary>Finds the yellow wall overlay that appears after selecting a pickaxe.</summary>
internal static class MiningHighlightDetector
{
    public static MiningHighlight? Find(Bitmap before, Bitmap after)
    {
        if (before.Size != after.Size || before.Width < 320 || before.Height < 180) return null;
        using var first = OpenCvImage.ToMat(before);
        using var second = OpenCvImage.ToMat(after);
        using var afterHsv = new Mat();
        Cv2.CvtColor(second, afterHsv, ColorConversionCodes.BGR2HSV);
        using var increase = new Mat();
        Cv2.Subtract(second, first, increase);
        var channels = Cv2.Split(increase);
        try
        {
            using var red = new Mat();
            using var green = new Mat();
            using var redOverBlue = new Mat();
            using var greenOverBlue = new Mat();
            using var mask = new Mat();
            Cv2.Threshold(channels[2], red, 12, 255, ThresholdTypes.Binary);
            Cv2.Threshold(channels[1], green, 12, 255, ThresholdTypes.Binary);
            Cv2.Subtract(channels[2], channels[0], redOverBlue);
            Cv2.Subtract(channels[1], channels[0], greenOverBlue);
            Cv2.Threshold(redOverBlue, redOverBlue, 8, 255, ThresholdTypes.Binary);
            Cv2.Threshold(greenOverBlue, greenOverBlue, 8, 255, ThresholdTypes.Binary);
            Cv2.BitwiseAnd(red, green, mask);
            Cv2.BitwiseAnd(mask, redOverBlue, mask);
            Cv2.BitwiseAnd(mask, greenOverBlue, mask);

            // The map occupies the middle of the landscape frame. Exclude UI and
            // moving characters near the top and bottom of the example scene.
            var left = (int)(before.Width * .20);
            var top = (int)(before.Height * .35);
            var right = (int)(before.Width * .83);
            var bottom = (int)(before.Height * .75);
            using var region = new Mat(mask, new Rect(left, top, right - left, bottom - top));
            using var opened = new Mat();
            using var closed = new Mat();
            var scale = Math.Min(before.Width / 1920d, before.Height / 1080d);
            int Kernel(int size) => Math.Max(3, (int)Math.Round(size * scale) | 1);
            using var smallKernel = Cv2.GetStructuringElement(MorphShapes.Rect,
                new OpenCvSharp.Size(Kernel(3), Kernel(3)));
            using var largeKernel = Cv2.GetStructuringElement(MorphShapes.Rect,
                new OpenCvSharp.Size(Kernel(25), Kernel(25)));
            Cv2.MorphologyEx(region, opened, MorphTypes.Open, smallKernel);
            Cv2.MorphologyEx(opened, closed, MorphTypes.Close, largeKernel);
            Cv2.FindContours(closed, out var contours, out _, RetrievalModes.External,
                ContourApproximationModes.ApproxSimple);

            MiningHighlight? best = null;
            var bestScore = 0d;
            foreach (var contour in contours)
            {
                var area = Cv2.ContourArea(contour);
                if (area < 5000 * scale * scale) continue;
                var bounds = Cv2.BoundingRect(contour);
                // Reject narrow effects and character fragments.
                if (bounds.Width < 100 * scale || bounds.Height < 45 * scale) continue;
                using var shape = new Mat(bounds.Height, bounds.Width, MatType.CV_8UC1, Scalar.Black);
                var local = Array.ConvertAll(contour, p => new CvPoint(p.X - bounds.X, p.Y - bounds.Y));
                Cv2.FillPoly(shape, [local], Scalar.White);
                using var distance = new Mat();
                Cv2.DistanceTransform(shape, distance, DistanceTypes.L2, DistanceTransformMasks.Mask3);
                // A merged contour can include a hero or monster. The click
                // must land on a muted yellow wall pixel inside the contour.
                var radius = 0f;
                var center = new CvPoint();
                var yStart = Math.Max((int)(20 * scale), top + (int)(35 * scale) - (top + bounds.Y));
                var yEnd = Math.Min(bounds.Height, Math.Max(yStart + 1, (int)(bounds.Height * .60)));
                for (var y = yStart; y < yEnd; y += 3)
                for (var x = 0; x < bounds.Width; x += 3)
                {
                    var depth = distance.At<float>(y, x);
                    if (depth <= radius || depth < 12 * scale) continue;
                    var huePixel = afterHsv.At<Vec3b>(top + bounds.Y + y, left + bounds.X + x);
                    if (huePixel.Item0 is < 18 or > 40 || huePixel.Item1 is < 20 or > 110 ||
                        huePixel.Item2 is < 40 or > 135) continue;
                    radius = depth;
                    center = new CvPoint(x, y);
                }
                if (radius == 0) continue;
                var candidate = new MiningHighlight(
                    new DrawingPoint(left + bounds.X + center.X, top + bounds.Y + center.Y),
                    new Rect(left + bounds.X, top + bounds.Y, bounds.Width, bounds.Height), area);
                // Characters and spell effects can merge into a highlighted
                // wall. Prefer a muted wall interior over a bright foreground.
                var color = second.At<Vec3b>(candidate.Click.Y, candidate.Click.X);
                var brightness = Math.Max(color.Item0, Math.Max(color.Item1, color.Item2));
                var score = area / (1 + Math.Max(0, brightness - 125) * .1);
                if (score > bestScore) { best = candidate; bestScore = score; }
            }
            return best;
        }
        finally
        {
            foreach (var channel in channels) channel.Dispose();
        }
    }
}
