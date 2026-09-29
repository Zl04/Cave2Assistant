using System.Drawing;
using System.Drawing.Imaging;
using OpenCvSharp;

namespace AdbMapController;

/// <summary>
/// OpenCV ORB feature matcher for scene elements that can scale, move, or receive
/// small perspective changes. The native runtime is supplied by OpenCvSharp4.runtime.win.
/// </summary>
public sealed class OpenCvFeatureMatcher
{
    readonly Dictionary<string, FeatureTemplate> templates = new(StringComparer.OrdinalIgnoreCase);

    public OpenCvFeatureMatchResult Find(
        string templatePath, Bitmap frame, Rectangle roi,
        int minimumMatches = 6, double ratio = .75, int featureCount = 800)
    {
        if (string.IsNullOrWhiteSpace(templatePath))
            throw new InvalidDataException("OpenCV 特征匹配任务缺少 template");
        if (!File.Exists(templatePath))
            throw new FileNotFoundException("OpenCV 特征模板不存在", templatePath);
        if (roi.Width < 8 || roi.Height < 8)
            return OpenCvFeatureMatchResult.Miss("ROI 太小，无法进行特征匹配");

        var template = GetTemplate(Path.GetFullPath(templatePath), featureCount);
        using var scene = Decode(frame);
        using var sceneRoi = new Mat(scene, new Rect(roi.X, roi.Y, roi.Width, roi.Height));
        using var sceneGray = sceneRoi.Clone();
        using var detector = ORB.Create(Math.Clamp(featureCount, 100, 4000));
        using var sceneDescriptors = new Mat();
        detector.DetectAndCompute(sceneGray, null, out var sceneKeypoints, sceneDescriptors);
        using (sceneDescriptors)
        {
            if (sceneDescriptors.Empty() || sceneKeypoints.Length < 2)
                return OpenCvFeatureMatchResult.Miss("场景中没有足够的 ORB 特征点");

            using var matcher = new BFMatcher(NormTypes.Hamming, crossCheck: false);
            var knn = matcher.KnnMatch(template.Descriptors, sceneDescriptors, 2, null, false);
            var good = knn
                .Where(pair => pair.Length >= 2 && pair[0].Distance <= pair[1].Distance * Math.Clamp(ratio, .5, .95))
                .Select(pair => pair[0])
                .ToArray();
            var required = Math.Max(4, minimumMatches);
            if (good.Length < required)
                return OpenCvFeatureMatchResult.Miss($"有效特征匹配不足：{good.Length}/{required}", good.Length);

            var sourcePoints = good.Select(match =>
                new Point2d(template.Keypoints[match.QueryIdx].Pt.X,
                            template.Keypoints[match.QueryIdx].Pt.Y)).ToArray();
            var destinationPoints = good.Select(match =>
                new Point2d(sceneKeypoints[match.TrainIdx].Pt.X + roi.X,
                            sceneKeypoints[match.TrainIdx].Pt.Y + roi.Y)).ToArray();
            using var inlierMask = new Mat();
            using var homography = Cv2.FindHomography(
                sourcePoints, destinationPoints, HomographyMethods.Ransac, 5, inlierMask);
            if (homography.Empty() || inlierMask.Empty())
                return OpenCvFeatureMatchResult.Miss("无法建立可靠的 RANSAC 单应性", good.Length);

            var inliers = Enumerable.Range(0, good.Length)
                .Count(index => inlierMask.Get<byte>(index, 0) != 0);
            if (inliers < required)
                return OpenCvFeatureMatchResult.Miss($"RANSAC 内点不足：{inliers}/{required}", good.Length, inliers);

            var projected = Cv2.PerspectiveTransform(
                [
                    new Point2f(0, 0),
                    new Point2f(template.Width - 1, 0),
                    new Point2f(template.Width - 1, template.Height - 1),
                    new Point2f(0, template.Height - 1)
                ], homography);

            var left = (int)Math.Floor(projected.Min(point => point.X));
            var top = (int)Math.Floor(projected.Min(point => point.Y));
            var right = (int)Math.Ceiling(projected.Max(point => point.X));
            var bottom = (int)Math.Ceiling(projected.Max(point => point.Y));
            var bounds = Rectangle.Intersect(
                new System.Drawing.Rectangle(System.Drawing.Point.Empty,
                    new System.Drawing.Size(scene.Cols, scene.Rows)),
                Rectangle.FromLTRB(left, top, right, bottom));
            if (bounds.Width < 4 || bounds.Height < 4)
                return OpenCvFeatureMatchResult.Miss("特征投影范围无效", good.Length, inliers);

            var averageDistance = good.Average(match => match.Distance);
            var descriptorScore = Math.Clamp(1 - averageDistance / 100, 0, 1);
            var inlierScore = inliers / (double)good.Length;
            var score = Math.Clamp(inlierScore * .70 + descriptorScore * .30, 0, 1);
            return new(true, bounds, score, good.Length, inliers,
                $"ORB good={good.Length}, RANSAC inliers={inliers}, distance={averageDistance:0.0}");
        }
    }

    FeatureTemplate GetTemplate(string path, int featureCount)
    {
        if (templates.TryGetValue(path, out var cached)) return cached;
        using var image = Cv2.ImRead(path, ImreadModes.Grayscale);
        if (image.Empty() || image.Width < 8 || image.Height < 8)
            throw new InvalidDataException($"OpenCV 特征模板尺寸无效：{path}");

        using var detector = ORB.Create(Math.Clamp(featureCount, 100, 4000));
        using var descriptors = new Mat();
        detector.DetectAndCompute(image, null, out var keypoints, descriptors);
        if (descriptors.Empty() || keypoints.Length < 2)
            throw new InvalidDataException($"OpenCV 特征模板没有足够的 ORB 特征点：{path}");

        var result = new FeatureTemplate(path, image.Width, image.Height, keypoints, descriptors.Clone());
        templates[path] = result;
        return result;
    }

    static Mat Decode(Bitmap bitmap)
    {
        using var stream = new MemoryStream();
        bitmap.Save(stream, ImageFormat.Png);
        return Cv2.ImDecode(stream.ToArray(), ImreadModes.Grayscale);
    }

    sealed record FeatureTemplate(
        string Path, int Width, int Height, KeyPoint[] Keypoints, Mat Descriptors);
}

public sealed record OpenCvFeatureMatchResult(
    bool Hit, Rectangle Box, double Score, int GoodMatches, int InlierMatches, string Detail)
{
    public static OpenCvFeatureMatchResult Miss(string detail, int goodMatches = 0, int inlierMatches = 0)
        => new(false, Rectangle.Empty, 0, goodMatches, inlierMatches, detail);
}
