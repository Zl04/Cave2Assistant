using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
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
    public double PatchRatio { get; set; } = .14;
    public double? PatchWidthRatio { get; set; }
    public double? PatchHeightRatio { get; set; }
    [JsonIgnore] Bitmap? sourceImage;
    [JsonIgnore] string? sourcePath;

    public static VisualTemplate FromFile(string path, double? widthRatio = null, double? heightRatio = null)
    {
        var fullPath = Path.GetFullPath(path);
        if (!File.Exists(fullPath)) throw new FileNotFoundException("视觉模板图片不存在", fullPath);
        using var image = new Bitmap(fullPath);
        if (image.Width < 4 || image.Height < 4)
            throw new InvalidDataException($"视觉模板图片尺寸无效：{fullPath}");
        return new VisualTemplate
        {
            sourcePath = fullPath,
            PatchRatio = widthRatio ?? image.Width / (double)DesignHeight,
            PatchWidthRatio = widthRatio ?? image.Width / (double)DesignHeight,
            PatchHeightRatio = heightRatio ?? image.Height / (double)DesignHeight
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
            PatchHeightRatio = clipped.Height / (double)baseSize
        };
    }

    public static VisualTemplate CreateFromAsset(Bitmap asset, double patchWidthRatio, double patchHeightRatio)
    {
        return new VisualTemplate
        {
            sourceImage = new Bitmap(asset),
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

    internal System.Drawing.Size GetSearchSize(Bitmap screen)
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

        var size = template.GetSearchSize(screen);
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
/// 玩家标记只在右上角 minimap 区域搜索，因此打开的城镇地图中的同一图标不会触发第二次点击。
/// </summary>
public static class BuiltInUiTemplateCatalog
{
    static readonly object sync = new();
    static IReadOnlyList<VisualTemplate> playerMarkers = [];
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
        var left = Math.Clamp((int)Math.Round(screen.Width * .74), 0, screen.Width - 1);
        var top = Math.Clamp((int)Math.Round(screen.Height * .03), 0, screen.Height - 1);
        var width = Math.Max(1, screen.Width - left);
        var height = Math.Min(screen.Height - top, Math.Max(1, (int)Math.Round(screen.Height * .36)));
        using var minimapRegion = screen.Clone(new Rectangle(left, top, width, height),
            System.Drawing.Imaging.PixelFormat.Format32bppArgb);
        var candidates = GetPlayerMarkers().SelectMany(template => template.FindAll(minimapRegion, .40, 24))
            .Where(x => x.Score >= .52)
            .OrderByDescending(x => x.Score)
            .ToArray();
        if (candidates.Length == 0) return null;
        var best = candidates[0];
        var score = best.Score;
        var second = candidates.Length > 1
            ? candidates[1].Score
            : 0;
        return new VisualMatch(new Point(best.Center.X + left, best.Center.Y + top), score, second);
    }

    static IReadOnlyList<VisualTemplate> GetPlayerMarkers()
    {
        lock (sync)
        {
            if (playerLoaded) return playerMarkers;
            playerLoaded = true;
            var path = Path.Combine(AppContext.BaseDirectory, "icons", "player.png");
            if (!File.Exists(path)) return playerMarkers;
            // 不同设备 DPI/游戏渲染比例会让小地图玩家标记尺寸变化；并行尝试常见比例。
            // 小地图 ROI 的最短边约为屏幕高度的三分之一，故这里按裁剪后尺寸换算比例。
            foreach (var ratio in new[] { .085, .10, .115, .13, .145 })
            {
                try { playerMarkers = playerMarkers.Append(VisualTemplate.FromFile(path, ratio, ratio)).ToArray(); }
                catch { }
            }
            return playerMarkers;
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
