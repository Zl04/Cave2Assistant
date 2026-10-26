using System.Drawing;
using System.Text.RegularExpressions;
using OpenCvSharp;

namespace AdbMapController;

public static class ConnectionPopupRecognition
{
    public static bool IsCandidate(Bitmap frame)
    {
        return MatchesButton(frame, "connection-idle-disconnect-x.png", 57, 37, .82) ||
            MatchesButton(frame, "connection-disconnect-confirm.png", 134, 47, .80);
    }

    static bool MatchesButton(Bitmap frame, string filename, int designWidth, int designHeight, double minimumScore)
    {
        var templatePath = Path.Combine(AppContext.BaseDirectory, "templates", "ui", filename);
        if (!File.Exists(templatePath)) return false;

        using var scene = OpenCvImage.ToMat(frame);
        using var template = Cv2.ImRead(templatePath, ImreadModes.Color);
        if (scene.Empty() || template.Empty()) return false;

        // Both template dimensions are normalized to a 1280 x 720 capture.
        var scale = frame.Height / 720.0;
        var width = Math.Max(4, (int)Math.Round(designWidth * scale));
        var height = Math.Max(4, (int)Math.Round(designHeight * scale));
        var bounds = Rectangle.FromLTRB(
            (int)Math.Round(frame.Width * .40), (int)Math.Round(frame.Height * .55),
            (int)Math.Round(frame.Width * .60), (int)Math.Round(frame.Height * .72));
        if (bounds.Width < width || bounds.Height < height) return false;

        using var resized = new Mat();
        Cv2.Resize(template, resized, new OpenCvSharp.Size(width, height), 0, 0, InterpolationFlags.Area);
        using var roi = new Mat(scene, new Rect(bounds.X, bounds.Y, bounds.Width, bounds.Height));
        using var response = roi.MatchTemplate(resized, TemplateMatchModes.CCoeffNormed);
        response.MinMaxLoc(out _, out var score, out _, out _);
        return score >= minimumScore;
    }

    public static bool IsDisconnectText(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return false;
        var normalized = Regex.Replace(text, @"[^\p{L}\p{N}]", "");
        return normalized.Contains("\u670d\u52a1\u5668\u8fde\u63a5\u5f02\u5e38", StringComparison.Ordinal) ||
            (normalized.Contains("\u8fde\u63a5\u5f02\u5e38", StringComparison.Ordinal) && normalized.Contains("\u91cd\u65b0\u8fdb\u5165\u6e38\u620f", StringComparison.Ordinal)) ||
            (normalized.Contains("\u95f2\u7f6e\u65f6\u95f4\u8fc7\u957f", StringComparison.Ordinal) && normalized.Contains("\u670d\u52a1\u5668\u65ad\u5f00\u8fde\u63a5", StringComparison.Ordinal)) ||
            (normalized.Contains("\u8fde\u63a5\u670d\u52a1\u5668\u5931\u8d25", StringComparison.Ordinal) &&
             normalized.Contains("\u7f51\u7edc\u8fde\u63a5", StringComparison.Ordinal) &&
             normalized.Contains("\u91cd\u8bd5", StringComparison.Ordinal));
    }
}
