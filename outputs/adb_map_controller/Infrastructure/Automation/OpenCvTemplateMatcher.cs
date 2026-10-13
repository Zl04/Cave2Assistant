using System.Drawing;
using System.Drawing.Imaging;
using OpenCvSharp;

namespace AdbMapController;

/// <summary>
/// OpenCV's visible PNG template matcher. Unlike the former sampled-array matcher,
/// this class keeps the actual template image and uses Cv2.MatchTemplate directly.
/// </summary>
public sealed class OpenCvTemplateMatcher
{
    public static OpenCvTemplateMatcher Shared { get; } = new();

    public IReadOnlyList<VisualMatch> FindAll(
        VisualTemplate template, Bitmap screen, double minimumScore = .55, int maxResults = 24)
    {
        if (!template.IsValid || maxResults < 1) return [];

        using var scene = OpenCvImage.ToMat(screen, ImreadModes.Color);
        using var source = template.LoadTemplateMat();
        using var mask = template.LoadMaskMat();
        if (scene.Empty() || source.Empty()) return [];

        var drawingSize = template.GetSearchSize(screen);
        var size = new OpenCvSharp.Size(drawingSize.Width, drawingSize.Height);
        if (size.Width < 4 || size.Height < 4 || size.Width > scene.Width || size.Height > scene.Height)
            return [];

        using var resized = new Mat();
        using var resizedMask = mask is null ? null : new Mat();
        Cv2.Resize(source, resized, size, 0, 0, InterpolationFlags.Area);
        if (mask is not null) Cv2.Resize(mask, resizedMask!, size, 0, 0, InterpolationFlags.Nearest);

        var method = resizedMask is null
            ? TemplateMatchModes.CCoeffNormed
            : TemplateMatchModes.CCorrNormed;
        using var response = resizedMask is null
            ? scene.MatchTemplate(resized, method)
            : scene.MatchTemplate(resized, method, resizedMask);

        var results = new List<VisualMatch>();
        var suppressionWidth = Math.Max(8, (int)Math.Round(size.Width * .65));
        var suppressionHeight = Math.Max(8, (int)Math.Round(size.Height * .65));
        var minimum = Math.Clamp(minimumScore, 0, 1);
        for (var index = 0; index < maxResults; index++)
        {
            response.MinMaxLoc(out _, out var score, out _, out var location);
            if (score < minimum) break;

            var center = new System.Drawing.Point(location.X + size.Width / 2, location.Y + size.Height / 2);
            results.Add(new VisualMatch(center, Math.Clamp(score, 0, 1), 0));

            var left = Math.Max(0, location.X - suppressionWidth / 2);
            var top = Math.Max(0, location.Y - suppressionHeight / 2);
            var right = Math.Min(response.Width, location.X + suppressionWidth / 2 + 1);
            var bottom = Math.Min(response.Height, location.Y + suppressionHeight / 2 + 1);
            Cv2.Rectangle(response, new Rect(left, top, Math.Max(1, right - left), Math.Max(1, bottom - top)),
                Scalar.All(-1), -1);
        }

        return results
            .Select((match, index) => match with
            {
                SecondScore = index + 1 < results.Count ? results[index + 1].Score : 0
            })
            .ToArray();
    }
}

internal static class OpenCvImage
{
    public static Mat ToMat(Bitmap bitmap, ImreadModes mode = ImreadModes.Color)
    {
        using var stream = new MemoryStream();
        bitmap.Save(stream, ImageFormat.Png);
        return Cv2.ImDecode(stream.ToArray(), mode);
    }
}
