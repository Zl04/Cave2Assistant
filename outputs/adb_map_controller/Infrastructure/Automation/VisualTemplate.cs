using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text.Json;
using System.Text.Json.Serialization;
using Cv2 = OpenCvSharp.Cv2;
using ColorConversionCodes = OpenCvSharp.ColorConversionCodes;
using ImreadModes = OpenCvSharp.ImreadModes;
using Mat = OpenCvSharp.Mat;

namespace AdbMapController;

public sealed class VisualTemplate
{
    const int DesignHeight = 720;
    public int Version { get; set; } = 1;
    public int SampleWidth { get; set; } = 24;
    public int SampleHeight { get; set; } = 24;
    public double PatchRatio { get; set; } = .14;
    public double? PatchWidthRatio { get; set; }
    public double? PatchHeightRatio { get; set; }
    // 当内置图标的轮廓容易与另一个白色地图图标混淆时，可以启用空间图案相关性。
    // 现有已校准模板保留历史上的仅使用掩码行为。
    public double PatternBlend { get; set; }
    public double[] Pixels { get; set; } = [];
    // 内置游戏图标模板带有从 alpha 通道派生的掩码，避免提取 PNG 的透明边框
    // 参与相关性评分。用户校准的屏幕模板保持为 null。
    public double[]? Weights { get; set; }
    // 内置 UI 模板还会保留采样得到的 RGB 值。仅使用灰度可能将青色玩家标记
    // 与附近的白色圆形按钮混淆。
    public double[]? ColorPixels { get; set; }

    // New templates retain the real image so the target can be opened and inspected.
    // The old sampled fields remain only for reading legacy JSON files; all matching
    // methods below now delegate to OpenCV's MatchTemplate implementation.
    [JsonIgnore] Bitmap? sourceImage;
    [JsonIgnore] string? sourcePath;

    public static VisualTemplate FromFile(string path, double? widthRatio = null, double? heightRatio = null)
    {
        var fullPath = Path.GetFullPath(path);
        if (!File.Exists(fullPath)) throw new FileNotFoundException("视觉模板图片不存在", fullPath);
        using var image = new Bitmap(fullPath);
        if (image.Width < 4 || image.Height < 4)
            throw new InvalidDataException($"视觉模板图片尺寸无效：{fullPath}");
        var baseSize = Math.Max(1, Math.Min(image.Width, image.Height));
        return new VisualTemplate
        {
            sourcePath = fullPath,
            PatchRatio = widthRatio ?? image.Width / (double)DesignHeight,
            PatchWidthRatio = widthRatio ?? image.Width / (double)DesignHeight,
            PatchHeightRatio = heightRatio ?? image.Height / (double)DesignHeight,
            SampleWidth = image.Width,
            SampleHeight = image.Height
        };
    }

    public static VisualTemplate Create(Bitmap screen, Point center, double patchRatio = .14)
    {
        var baseSize = Math.Max(1, Math.Min(screen.Width, screen.Height));
        var patch = Math.Max(16, (int)Math.Round(baseSize * patchRatio));
        var left = Math.Clamp(center.X - patch / 2, 0, Math.Max(0, screen.Width - patch));
        var top = Math.Clamp(center.Y - patch / 2, 0, Math.Max(0, screen.Height - patch));
        var bounds = new Rectangle(left, top,
            Math.Min(patch, screen.Width - left), Math.Min(patch, screen.Height - top));
        return Create(screen, bounds);
    }

    /// <summary>
    /// 从当前地图截图中保留用户框选的场景区域。该区域可以避开人物蓝色标记，
    /// 以周边固定地形而不是入口图标本身作为定位依据。
    /// </summary>
    public static VisualTemplate Create(Bitmap screen, Rectangle bounds)
    {
        var clipped = Rectangle.Intersect(new Rectangle(Point.Empty, screen.Size), bounds);
        if (clipped.Width < 16 || clipped.Height < 16)
            throw new ArgumentOutOfRangeException(nameof(bounds), "入口场景模板至少需要 16x16 像素");
        var baseSize = Math.Max(1, Math.Min(screen.Width, screen.Height));
        return new VisualTemplate
        {
            sourceImage = screen.Clone(clipped, PixelFormat.Format32bppArgb),
            PatchRatio = clipped.Width / (double)baseSize,
            PatchWidthRatio = clipped.Width / (double)baseSize,
            PatchHeightRatio = clipped.Height / (double)baseSize,
            SampleWidth = clipped.Width,
            SampleHeight = clipped.Height
        };
    }

    public static VisualTemplate CreateFromAsset(Bitmap asset, double patchRatio = .10)
        => CreateFromAsset(asset, patchRatio, 24);

    public static VisualTemplate CreateFromAsset(Bitmap asset, double patchRatio, int sampleSize)
    {
        return new VisualTemplate
        {
            sourceImage = new Bitmap(asset),
            SampleWidth = asset.Width,
            SampleHeight = asset.Height,
            PatchRatio = patchRatio,
            PatchWidthRatio = patchRatio,
            PatchHeightRatio = patchRatio
        };
    }

    public static VisualTemplate CreateFromAsset(Bitmap asset, double patchWidthRatio, double patchHeightRatio)
    {
        return new VisualTemplate
        {
            sourceImage = new Bitmap(asset),
            SampleWidth = asset.Width,
            SampleHeight = asset.Height,
            PatchRatio = patchWidthRatio,
            PatchWidthRatio = patchWidthRatio,
            PatchHeightRatio = patchHeightRatio
        };
    }

    public bool IsValid
    {
        get
        {
            if (sourceImage is not null) return sourceImage.Width > 3 && sourceImage.Height > 3;
            if (!string.IsNullOrWhiteSpace(sourcePath) && File.Exists(sourcePath))
            {
                try
                {
                    using var image = new Bitmap(sourcePath);
                    return image.Width > 3 && image.Height > 3;
                }
                catch { return false; }
            }
            // Legacy sampled templates are intentionally no longer considered valid
            // visual targets. Recalibration creates a visible PNG template instead.
            return false;
        }
    }

    public VisualMatch? Find(Bitmap screen, double minimumScore = .80)
    {
        var matches = FindAll(screen, minimumScore, 2);
        return matches.Count == 0 ? null : matches[0];
    }

    public IReadOnlyList<VisualMatch> FindAll(Bitmap screen, double minimumScore = .55, int maxResults = 24)
    {
        return OpenCvTemplateMatcher.Shared.FindAll(this, screen, minimumScore, maxResults);
#pragma warning disable CS0162
        if (!IsValid || maxResults < 1) return [];
        var patchWidth = Math.Max(16, (int)Math.Round(Math.Min(screen.Width, screen.Height) * (PatchWidthRatio ?? PatchRatio)));
        var patchHeight = Math.Max(16, (int)Math.Round(Math.Min(screen.Width, screen.Height) * (PatchHeightRatio ?? PatchRatio)));
        var halfWidth = patchWidth / 2;
        var halfHeight = patchHeight / 2;
        if (screen.Width <= patchWidth || screen.Height <= patchHeight) return [];

        var gray = GrayPixels(screen);
        var step = Math.Max(2, Math.Min(screen.Width, screen.Height) / 180);
        var suppression = Math.Max(Math.Min(halfWidth, halfHeight) * .75, 28);
        var candidates = new List<VisualMatch>();
        var coarseMinimum = Math.Max(.35, minimumScore - .12);
        for (var y = halfHeight; y <= screen.Height - halfHeight - 1; y += step)
        for (var x = halfWidth; x <= screen.Width - halfWidth - 1; x += step)
        {
            var score = ScoreAt(gray, screen.Width, screen.Height, x, y, patchWidth, patchHeight);
            // 图标可能落在粗采样点之间。保留接近但未命中的结果，
            // 供单像素细化遍历使用，然后再应用实际阈值。
            if (score < coarseMinimum) continue;
            var nearby = candidates.FindIndex(item => Distance(item.Center, new Point(x, y)) <= suppression);
            var candidate = new VisualMatch(new Point(x, y), score, 0);
            if (nearby >= 0)
            {
                if (score > candidates[nearby].Score) candidates[nearby] = candidate;
            }
            else candidates.Add(candidate);
        }

        var refined = candidates
            .OrderByDescending(x => x.Score)
            .Take(Math.Max(maxResults * 2, maxResults))
            .Select(candidate => Search(gray, screen.Width, screen.Height, patchWidth, patchHeight, halfWidth, halfHeight, 1,
                candidate.Center.X - step - 2, candidate.Center.Y - step - 2,
                candidate.Center.X + step + 3, candidate.Center.Y + step + 3,
                candidate.Score - .08) ?? candidate)
            .OrderByDescending(x => x.Score)
            .ToList();

        var result = new List<VisualMatch>();
        foreach (var candidate in refined)
        {
            if (candidate.Score < minimumScore) continue;
            if (result.Any(item => Distance(item.Center, candidate.Center) <= suppression)) continue;
            result.Add(candidate);
            if (result.Count >= maxResults) break;
        }
        var ranked = result.OrderByDescending(x => x.Score).ToArray();
        return ranked.Select((candidate, index) => candidate with
        {
            // Search() 的局部第二分数通常是同一图标的相邻采样点。
            // 使用下一个经过 NMS 分离的候选结果，使 Margin 衡量真实的唯一性，而不是像素平台。
            SecondScore = index + 1 < ranked.Length ? ranked[index + 1].Score : 0
        }).ToArray();
#pragma warning restore CS0162
    }

    internal Mat LoadTemplateMat()
    {
        using var raw = LoadRawMat();
        if (raw.Channels() == 4)
        {
            var result = new Mat();
            Cv2.CvtColor(raw, result, ColorConversionCodes.BGRA2BGR);
            return result;
        }
        return raw.Clone();
    }

    internal Mat? LoadMaskMat()
    {
        using var raw = LoadRawMat();
        if (raw.Channels() != 4) return null;
        var mask = new Mat();
        Cv2.ExtractChannel(raw, mask, 3);
        if (Cv2.CountNonZero(mask) == 0)
        {
            mask.Dispose();
            return null;
        }
        double minimum, maximum;
        mask.MinMaxLoc(out minimum, out maximum);
        if (minimum >= 254)
        {
            mask.Dispose();
            return null;
        }
        return mask;
    }

    internal System.Drawing.Size GetSearchSize(Bitmap screen, System.Drawing.Size sourceSize)
    {
        var baseSize = Math.Max(1, Math.Min(screen.Width, screen.Height));
        var widthRatio = PatchWidthRatio ?? PatchRatio;
        var heightRatio = PatchHeightRatio ?? PatchRatio;
        return new System.Drawing.Size(
            Math.Max(4, (int)Math.Round(baseSize * widthRatio)),
            Math.Max(4, (int)Math.Round(baseSize * heightRatio)));
    }

    internal void SavePng(string path)
    {
        if (!IsValid) throw new InvalidOperationException("无法保存无效视觉模板");
        var directory = Path.GetDirectoryName(Path.GetFullPath(path));
        if (!string.IsNullOrWhiteSpace(directory)) Directory.CreateDirectory(directory);
        using var image = LoadBitmap();
        image.Save(path, ImageFormat.Png);
    }

    Bitmap LoadBitmap()
    {
        if (sourceImage is not null) return new Bitmap(sourceImage);
        if (!string.IsNullOrWhiteSpace(sourcePath)) return new Bitmap(sourcePath);
        throw new InvalidOperationException("视觉模板没有可见的 PNG 图像");
    }

    Mat LoadRawMat()
    {
        if (!string.IsNullOrWhiteSpace(sourcePath))
            return Cv2.ImRead(sourcePath, ImreadModes.Unchanged);
        using var image = LoadBitmap();
        return OpenCvImage.ToMat(image, ImreadModes.Unchanged);
    }

    VisualMatch? Search(byte[] gray, int width, int height, int patchWidth, int patchHeight,
        int halfWidth, int halfHeight, int step,
        int x0, int y0, int x1, int y1, double? knownBest = null)
    {
        var minX = Math.Max(halfWidth, x0); var minY = Math.Max(halfHeight, y0);
        var maxX = Math.Min(width - halfWidth - 1, x1 - 1); var maxY = Math.Min(height - halfHeight - 1, y1 - 1);
        if (minX > maxX || minY > maxY) return null;

        VisualMatch? best = null;
        VisualMatch? second = null;
        for (var y = minY; y <= maxY; y += step)
        for (var x = minX; x <= maxX; x += step)
        {
            var score = ScoreAt(gray, width, height, x, y, patchWidth, patchHeight);
            if (knownBest.HasValue && score < knownBest.Value - .08) continue;
            var candidate = new VisualMatch(new Point(x, y), score, 0);
            if (best is null || score > best.Score)
            {
                second = best;
                best = candidate;
            }
            else if (second is null || score > second.Score) second = candidate;
        }
        if (best is null) return null;
        return best with { SecondScore = second?.Score ?? 0 };
    }

    static double Distance(Point a, Point b)
        => Math.Sqrt(Math.Pow(a.X - b.X, 2) + Math.Pow(a.Y - b.Y, 2));

    double ScoreAt(byte[] gray, int width, int height, int cx, int cy, int patchWidth, int patchHeight)
    {
        var values = SamplePatch(gray, width, height, cx, cy, patchWidth, patchHeight, SampleWidth, SampleHeight);
        var weights = Weights;
        if (weights is not null && weights.Length == values.Length)
        {
            // 对城镇地图来说，仅统计二值前景并不足够：符文图案的白色轮廓
            // 与扭曲空间图案相似。保留掩码分数以容忍抗锯齿，
            // 再加入归一化像素图案，使内部形状参与判断。
            var mask = MaskScore(values, weights);
            if (PatternBlend <= 0) return mask;
            var pattern = PatternScore(values, weights);
            return mask * (1 - PatternBlend) + pattern * PatternBlend;
        }

        Normalize(values, weights);
        var sum = 0d;
        var weightTotal = 0d;
        for (var i = 0; i < values.Length; i++)
        {
            var weight = weights is not null ? weights[i] : 1;
            sum += weight * values[i] * Pixels[i];
            weightTotal += weight;
        }
        var correlation = sum / Math.Max(1, weightTotal - 1);
        return (correlation + 1) / 2;
    }

    public double ColorScore(Bitmap screen, Point center)
    {
        if (ColorPixels is null || ColorPixels.Length != Pixels.Length * 3) return 1;
        var patchWidth = Math.Max(16, (int)Math.Round(Math.Min(screen.Width, screen.Height) * (PatchWidthRatio ?? PatchRatio)));
        var patchHeight = Math.Max(16, (int)Math.Round(Math.Min(screen.Width, screen.Height) * (PatchHeightRatio ?? PatchRatio)));
        var halfWidth = patchWidth / 2;
        var halfHeight = patchHeight / 2;
        if (center.X < halfWidth || center.Y < halfHeight || center.X >= screen.Width - halfWidth || center.Y >= screen.Height - halfHeight)
            return 0;

        var weights = Weights;
        var total = 0d;
        var score = 0d;
        for (var y = 0; y < SampleHeight; y++)
        for (var x = 0; x < SampleWidth; x++)
        {
            var index = y * SampleWidth + x;
            var weight = weights is null ? 1 : weights[index];
            if (weight < .05) continue;
            var px = Math.Clamp((int)Math.Round(center.X - halfWidth + (x + .5) * patchWidth / (double)SampleWidth), 0, screen.Width - 1);
            var py = Math.Clamp((int)Math.Round(center.Y - halfHeight + (y + .5) * patchHeight / (double)SampleHeight), 0, screen.Height - 1);
            var color = screen.GetPixel(px, py);
            var dr = color.R / 255d - ColorPixels[index * 3];
            var dg = color.G / 255d - ColorPixels[index * 3 + 1];
            var db = color.B / 255d - ColorPixels[index * 3 + 2];
            score += weight * Math.Clamp(1 - Math.Sqrt(dr * dr + dg * dg + db * db) / Math.Sqrt(3), 0, 1);
            total += weight;
        }
        return total < .001 ? 0 : score / total;
    }

    static double MaskScore(double[] values, double[] weights)
    {
        const double brightThreshold = 155;
        var foreground = 0;
        var truePositive = 0;
        var falsePositive = 0;
        var foregroundBrightness = 0d;
        var backgroundBrightness = 0d;
        var background = 0;
        for (var i = 0; i < values.Length; i++)
        {
            var screenBright = values[i] >= brightThreshold;
            if (weights[i] >= .05)
            {
                foreground++;
                foregroundBrightness += values[i];
                if (screenBright) truePositive++;
            }
            else
            {
                background++;
                backgroundBrightness += values[i];
                if (screenBright) falsePositive++;
            }
        }

        if (foreground == 0) return 0;
        // 大多数提取的 minimap 图标在透明/深色背景上较亮，
        // 但城镇标题是在浅色横幅上的深色文字。
        // 根据不透明像素推断极性，使两种图像类型可以使用同一个 alpha 掩码匹配器。
        var foregroundMean = foregroundBrightness / foreground;
        var backgroundMean = backgroundBrightness / Math.Max(1, background);
        var foregroundIsBright = foregroundMean >= brightThreshold;
        if (!foregroundIsBright)
        {
            truePositive = 0;
            falsePositive = 0;
            for (var i = 0; i < values.Length; i++)
            {
                var screenDark = values[i] < brightThreshold;
                if (weights[i] >= .05)
                {
                    if (screenDark) truePositive++;
                }
                else if (screenDark) falsePositive++;
            }
        }

        var precision = truePositive / (double)Math.Max(1, truePositive + falsePositive);
        var recall = truePositive / (double)foreground;
        var f1 = 2 * precision * recall / Math.Max(.001, precision + recall);
        var contrast = foregroundIsBright
            ? Math.Clamp((foregroundMean - backgroundMean) / 160, 0, 1)
            : Math.Clamp((backgroundMean - foregroundMean) / 160, 0, 1);
        return f1 * .78 + contrast * .22;
    }

    double PatternScore(double[] values, double[] weights)
    {
        if (values.Length != weights.Length || values.Length != Pixels.Length) return 0;
        var normalized = (double[])values.Clone();
        Normalize(normalized, weights);
        var total = 0d;
        var sum = 0d;
        for (var i = 0; i < normalized.Length; i++)
        {
            var weight = weights[i];
            if (weight < .05) continue;
            sum += weight * normalized[i] * Pixels[i];
            total += weight;
        }
        if (total < 2) return 0;
        var correlation = sum / Math.Max(1, total - 1);
        return Math.Clamp((correlation + 1) / 2, 0, 1);
    }

    static double[] SamplePatch(byte[] gray, int width, int height, int cx, int cy,
        int patchWidth, int patchHeight, int sampleWidth, int sampleHeight)
    {
        var result = new double[sampleWidth * sampleHeight];
        var left = cx - patchWidth / 2d; var top = cy - patchHeight / 2d;
        for (var y = 0; y < sampleHeight; y++)
        for (var x = 0; x < sampleWidth; x++)
        {
            var px = Math.Clamp((int)Math.Round(left + (x + .5) * patchWidth / sampleWidth), 0, width - 1);
            var py = Math.Clamp((int)Math.Round(top + (y + .5) * patchHeight / sampleHeight), 0, height - 1);
            result[y * sampleWidth + x] = gray[py * width + px];
        }
        return result;
    }

    static double[] SampleColorPatch(Bitmap source, int cx, int cy, int patchWidth, int patchHeight,
        int sampleWidth, int sampleHeight)
    {
        var result = new double[sampleWidth * sampleHeight * 3];
        var left = cx - patchWidth / 2d; var top = cy - patchHeight / 2d;
        for (var y = 0; y < sampleHeight; y++)
        for (var x = 0; x < sampleWidth; x++)
        {
            var px = Math.Clamp((int)Math.Round(left + (x + .5) * patchWidth / sampleWidth), 0, source.Width - 1);
            var py = Math.Clamp((int)Math.Round(top + (y + .5) * patchHeight / sampleHeight), 0, source.Height - 1);
            var color = source.GetPixel(px, py);
            var index = (y * sampleWidth + x) * 3;
            result[index] = color.R / 255d;
            result[index + 1] = color.G / 255d;
            result[index + 2] = color.B / 255d;
        }
        return result;
    }

    static void Normalize(double[] values, double[]? weights = null)
    {
        if (values.Length == 0) return;
        var weightTotal = weights is null ? values.Length : weights.Sum();
        if (weightTotal < 2)
        {
            Array.Fill(values, 0);
            return;
        }

        var mean = weights is null
            ? values.Average()
            : values.Select((value, index) => value * weights[index]).Sum() / weightTotal;
        var variance = weights is null
            ? values.Sum(x => (x - mean) * (x - mean)) / Math.Max(1, values.Length - 1)
            : values.Select((value, index) => weights[index] * (value - mean) * (value - mean)).Sum()
                / Math.Max(1, weightTotal - 1);
        var scale = Math.Sqrt(variance);
        if (scale < .001) { Array.Fill(values, 0); return; }
        for (var i = 0; i < values.Length; i++)
            values[i] = weights is not null && weights[i] < .05 ? 0 : (values[i] - mean) / scale;
    }

    static byte[] GrayPixels(Bitmap source)
    {
        using var bitmap = new Bitmap(source.Width, source.Height, PixelFormat.Format24bppRgb);
        using (var graphics = Graphics.FromImage(bitmap)) graphics.DrawImageUnscaled(source, 0, 0);
        var rect = new Rectangle(0, 0, bitmap.Width, bitmap.Height);
        var data = bitmap.LockBits(rect, ImageLockMode.ReadOnly, PixelFormat.Format24bppRgb);
        try
        {
            var result = new byte[bitmap.Width * bitmap.Height];
            for (var y = 0; y < bitmap.Height; y++)
            {
                var row = IntPtr.Add(data.Scan0, y * data.Stride);
                for (var x = 0; x < bitmap.Width; x++)
                {
                    var b = System.Runtime.InteropServices.Marshal.ReadByte(row, x * 3);
                    var g = System.Runtime.InteropServices.Marshal.ReadByte(row, x * 3 + 1);
                    var r = System.Runtime.InteropServices.Marshal.ReadByte(row, x * 3 + 2);
                    result[y * bitmap.Width + x] = (byte)((r * 299 + g * 587 + b * 114) / 1000);
                }
            }
            return result;
        }
        finally { bitmap.UnlockBits(data); }
    }

    static byte[] AlphaPixels(Bitmap source)
    {
        // 直接从 PNG 读取 alpha。绘制到另一个位图可能会预乘/合成透明像素，从而破坏掩码。
        var result = new byte[source.Width * source.Height];
        for (var y = 0; y < source.Height; y++)
        for (var x = 0; x < source.Width; x++)
            result[y * source.Width + x] = source.GetPixel(x, y).A;
        return result;
    }
}

public sealed record VisualMatch(Point Center, double Score, double SecondScore)
{
    public double Margin => Score - SecondScore;
}

public sealed class EntryTemplateStore
{
    readonly string path;
    readonly Dictionary<int, VisualTemplate> templates;
    readonly Dictionary<int, PointF> targetOffsets;

    public EntryTemplateStore(string path)
    {
        this.path = path;
        templates = Load(path, out targetOffsets);
    }

    public VisualTemplate? Get(int mapId)
        => templates.TryGetValue(mapId, out var value) ? value : BuiltInEntryTemplateCatalog.Get(mapId);

    public VisualMatch? Find(int mapId, Bitmap screen)
        => FindAll(mapId, screen, .58, 2).FirstOrDefault();

    public IReadOnlyList<VisualMatch> FindAll(int mapId, Bitmap screen,
        double minimumScore = .55, int maxResults = 32)
    {
        var hasCalibratedTemplate = templates.TryGetValue(mapId, out var template);
        template ??= BuiltInEntryTemplateCatalog.Get(mapId);
        if (template is null) return [];
        var matches = hasCalibratedTemplate
            ? template.FindAll(screen, minimumScore, maxResults)
            : BuiltInEntryTemplateCatalog.FindAll(mapId, screen, minimumScore, maxResults);
        if (!targetOffsets.TryGetValue(mapId, out var offset) || (offset.X == 0 && offset.Y == 0))
            return matches;

        var size = template.GetSearchSize(screen, new Size(template.SampleWidth, template.SampleHeight));
        return matches.Select(match => match with
        {
            Center = new Point(
                Math.Clamp((int)Math.Round(match.Center.X + offset.X * size.Width), 0, screen.Width - 1),
                Math.Clamp((int)Math.Round(match.Center.Y + offset.Y * size.Height), 0, screen.Height - 1))
        }).ToArray();
    }

    public void Save(int mapId, VisualTemplate template)
        => Save(mapId, template, PointF.Empty);

    /// <summary>
    /// 保存当前地图截图中的场景模板及其入口锚点偏移。偏移以模板宽高为单位，
    /// 因而不同分辨率下仍可由匹配到的场景位置推导出实际点击位置。
    /// </summary>
    public void Save(int mapId, VisualTemplate template, PointF targetOffset)
    {
        if (!template.IsValid) throw new InvalidDataException("不能保存无效入口模板");
        var baseDirectory = Path.GetDirectoryName(Path.GetFullPath(path))!;
        var imageDirectory = Path.Combine(baseDirectory, "entry-templates");
        Directory.CreateDirectory(imageDirectory);
        var imagePath = Path.Combine(imageDirectory, $"map-{mapId}.png");
        template.SavePng(imagePath);
        templates[mapId] = VisualTemplate.FromFile(imagePath,
            template.PatchWidthRatio ?? template.PatchRatio,
            template.PatchHeightRatio ?? template.PatchRatio);
        targetOffsets[mapId] = targetOffset;
        WriteMetadata(baseDirectory);
    }

    public static PointF GetTargetOffset(Rectangle templateBounds, Point target)
    {
        if (templateBounds.Width < 1 || templateBounds.Height < 1)
            throw new ArgumentOutOfRangeException(nameof(templateBounds));
        return new PointF(
            (target.X - (templateBounds.Left + templateBounds.Width / 2f)) / templateBounds.Width,
            (target.Y - (templateBounds.Top + templateBounds.Height / 2f)) / templateBounds.Height);
    }

    void WriteMetadata(string baseDirectory)
    {
        var metadata = templates.ToDictionary(
            pair => pair.Key.ToString(),
            pair =>
            {
                targetOffsets.TryGetValue(pair.Key, out var offset);
                return new
                {
                    template = Path.Combine("entry-templates", $"map-{pair.Key}.png").Replace('\\', '/'),
                    scaleWidthRatio = pair.Value.PatchWidthRatio ?? pair.Value.PatchRatio,
                    scaleHeightRatio = pair.Value.PatchHeightRatio ?? pair.Value.PatchRatio,
                    targetOffsetX = offset.X,
                    targetOffsetY = offset.Y
                };
            });
        var temp = path + ".tmp";
        File.WriteAllText(temp, JsonSerializer.Serialize(metadata, new JsonSerializerOptions { WriteIndented = true }));
        File.Move(temp, path, true);
    }

    static Dictionary<int, VisualTemplate> Load(string path, out Dictionary<int, PointF> offsets)
    {
        offsets = [];
        try
        {
            if (!File.Exists(path)) return [];
            using var document = JsonDocument.Parse(File.ReadAllText(path));
            if (document.RootElement.ValueKind != JsonValueKind.Object) return [];
            var baseDirectory = Path.GetDirectoryName(Path.GetFullPath(path))!;
            var result = new Dictionary<int, VisualTemplate>();
            foreach (var property in document.RootElement.EnumerateObject())
            {
                if (!int.TryParse(property.Name, out var mapId) ||
                    property.Value.ValueKind != JsonValueKind.Object) continue;
                var node = property.Value;
                if (!node.TryGetProperty("template", out var templateNode) ||
                    templateNode.ValueKind != JsonValueKind.String) continue;
                var templatePath = templateNode.GetString();
                if (string.IsNullOrWhiteSpace(templatePath)) continue;
                if (!Path.IsPathRooted(templatePath))
                    templatePath = Path.Combine(baseDirectory, templatePath);
                if (!File.Exists(templatePath)) continue;
                var width = ReadNumber(node, "scaleWidthRatio");
                var height = ReadNumber(node, "scaleHeightRatio");
                result[mapId] = VisualTemplate.FromFile(templatePath, width, height);
                var offsetX = ReadNumber(node, "targetOffsetX") ?? 0;
                var offsetY = ReadNumber(node, "targetOffsetY") ?? 0;
                if (offsetX != 0 || offsetY != 0) offsets[mapId] = new PointF((float)offsetX, (float)offsetY);
            }
            // Old entry-templates.json files contain only sampled arrays. They are
            // intentionally ignored so the next calibration replaces them with a
            // real PNG that can be opened and reviewed.
            return result;
        }
        catch
        {
            offsets = [];
            return [];
        }
    }

    static double? ReadNumber(JsonElement node, string name)
        => node.TryGetProperty(name, out var value) && value.TryGetDouble(out var number)
            ? number
            : null;
}

/// <summary>
/// 随控制器附带的游戏提取入口图标。这些是实际的城镇地图帧，
/// 因此全新安装可以定位入口，无需用户校准屏幕坐标。
/// </summary>
public static class BuiltInEntryTemplateCatalog
{
    sealed record EntranceTemplateAsset(string FileName, double WidthRatio, double HeightRatio);

    static readonly IReadOnlyDictionary<int, EntranceTemplateAsset> Assets =
        new Dictionary<int, EntranceTemplateAsset>
        {
            // 截自巴萨坦地图的入口图，不与 icons/ 中的原始游戏图标混用。
            [0] = new("time-gate.png", .05664, .06726),
            [1] = new("sand-eye.png", .06549, .06372),
            [DungeonEntryCatalog.SharedEntranceMapId] = new("shared-special.png", .06372, .06903),
            [5] = new("original-trial.png", .06549, .06726)
        };

    static readonly Dictionary<int, VisualTemplate?> cache = [];

    public static VisualTemplate? Get(int mapId)
    {
        lock (cache)
        {
            if (cache.TryGetValue(mapId, out var cached)) return cached;
            cache[mapId] = Load(mapId);
            return cache[mapId];
        }
    }

    public static VisualMatch? Find(int mapId, Bitmap screen, double minimumScore = .58)
        => FindAll(mapId, screen, minimumScore, 2).FirstOrDefault();

    public static IReadOnlyList<VisualMatch> FindAll(int mapId, Bitmap screen,
        double minimumScore = .58, int maxResults = 32)
    {
        var template = Get(mapId);
        if (template is null || maxResults < 1) return [];
        var candidates = template.FindAll(screen, .45, 128)
            .Where(x => x.Center.X >= screen.Width * .28 && x.Center.X <= screen.Width * .96 &&
                        x.Center.Y >= screen.Height * .10 && x.Center.Y <= screen.Height * .92 &&
                        x.Score >= minimumScore)
            .OrderByDescending(x => x.Score)
            .Take(maxResults)
            .ToArray();
        return candidates.Select((candidate, index) => new VisualMatch(
            candidate.Center,
            candidate.Score,
            index + 1 < candidates.Length ? candidates[index + 1].Score : 0)).ToArray();
    }

    static VisualTemplate? Load(int mapId)
    {
        if (!Assets.TryGetValue(mapId, out var asset)) return null;
        var path = Path.Combine(AppContext.BaseDirectory, "templates", "entrances", asset.FileName);
        if (!File.Exists(path)) return null;
        try
        {
            return VisualTemplate.FromFile(path, asset.WidthRatio, asset.HeightRatio);
        }
        catch { return null; }
    }
}

/// <summary>
/// 用于从游戏场景切换到城镇地图覆盖层的内置 UI 模板。
/// 玩家标记只在右上角 minimap 区域搜索，因此打开的城镇地图中的同一图标不会触发第二次点击。
/// </summary>
public static class BuiltInUiTemplateCatalog
{
    static readonly object sync = new();
    static VisualTemplate? playerMarker;
    static bool playerLoaded;
    static VisualTemplate? bastanTitle;
    static bool bastanTitleLoaded;

    public static VisualMatch? FindBastanTitle(Bitmap screen)
    {
        var template = GetBastanTitle();
        if (template is null) return null;
        var candidates = template.FindAll(screen, .30, 24)
            .Where(x => x.Center.X >= screen.Width * .42 && x.Center.X <= screen.Width * .60 &&
                        x.Center.Y >= screen.Height * .05 && x.Center.Y <= screen.Height * .30 &&
                        x.Score >= .75)
            .OrderByDescending(x => x.Score)
            .ToArray();
        if (candidates.Length == 0) return null;
        return new VisualMatch(candidates[0].Center, candidates[0].Score,
            candidates.Length > 1 ? candidates[1].Score : 0);
    }

    public static VisualMatch? FindMinimapPlayer(Bitmap screen)
    {
        var template = GetPlayerMarker();
        if (template is null) return null;
        var candidates = template.FindAll(screen, .55, 24)
            .Where(x => x.Center.X >= screen.Width * .78 && x.Center.X <= screen.Width * .99 &&
                        x.Center.Y >= screen.Height * .08 && x.Center.Y <= screen.Height * .30 &&
                        x.Score >= .65)
            .OrderByDescending(x => x.Score)
            .ToArray();
        if (candidates.Length == 0) return null;
        var score = candidates[0].Score;
        var second = candidates.Length > 1
            ? candidates[1].Score
            : 0;
        return new VisualMatch(candidates[0].Center, score, second);
    }

    static VisualTemplate? GetPlayerMarker()
    {
        lock (sync)
        {
            if (playerLoaded) return playerMarker;
            playerLoaded = true;
            var path = Path.Combine(AppContext.BaseDirectory, "icons", "player.png");
            if (!File.Exists(path)) return null;
            try { playerMarker = VisualTemplate.FromFile(path, .037, .037); }
            catch { playerMarker = null; }
            return playerMarker;
        }
    }

    static VisualTemplate? GetBastanTitle()
    {
        lock (sync)
        {
            if (bastanTitleLoaded) return bastanTitle;
            bastanTitleLoaded = true;
            var path = Path.Combine(AppContext.BaseDirectory, "templates", "ui", "ui_title_bastan.png");
            if (!File.Exists(path)) return null;
            // 该模板直接截取自 1004x565 的主城地图截图，保持其原始屏幕尺寸比例。
            try { bastanTitle = VisualTemplate.FromFile(path, 79d / 565d, 30d / 565d); }
            catch { bastanTitle = null; }
            return bastanTitle;
        }
    }
}
