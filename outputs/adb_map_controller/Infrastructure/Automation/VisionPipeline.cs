using System.Drawing;
using System.Drawing.Imaging;
using System.Text.Json;

namespace AdbMapController;

/// <summary>
/// 本地 MAA 风格视觉管线使用的识别算法。
/// JustReturn 适用于只需执行动作的流程节点；MatchTemplate 和 OcrDetect
/// 是 Cave Online 控制器当前需要的两种算法。
/// </summary>
public enum VisionAlgorithm
{
    JustReturn,
    MatchTemplate,
    OcrDetect,
    FeatureMatch
}

/// <summary>
/// 一个识别节点。ROI 坐标使用与游戏任务配置相同的 1280x720 设计空间，
/// 并缩放到实际截图尺寸。
/// </summary>
public sealed class VisionTask
{
    public string Name { get; init; } = "VisionTask";
    public VisionAlgorithm Algorithm { get; init; } = VisionAlgorithm.MatchTemplate;
    public string? TemplatePath { get; init; }
    public IReadOnlyList<string> Text { get; init; } = [];
    public Rectangle? Roi { get; init; }
    public double TemplateThreshold { get; init; } = .80;
    public int MinimumFeatureMatches { get; init; } = 6;
    public double FeatureRatio { get; init; } = .75;
    public int FeatureCount { get; init; } = 800;
    public bool FullMatch { get; init; }
    public double MinimumOcrConfidence { get; init; } = 10;
}

public sealed record VisionRecognitionResult(
    string TaskName,
    VisionAlgorithm Algorithm,
    bool Hit,
    Rectangle Box,
    double Score,
    string? Text,
    OcrTextMatch? TextMatch,
    IReadOnlyList<VisualMatch> Matches,
    IReadOnlyList<OcrWord> Words,
    string? Detail = null)
{
    public static VisionRecognitionResult Miss(VisionTask task, Rectangle roi, string? detail = null)
        => new(task.Name, task.Algorithm, false, Rectangle.Empty, 0, null, null, [], [], detail);
}

/// <summary>
/// 可复用的识别外观层。有意使用现有的 VisualTemplate 和 PaddleOCR 抽象，
/// 而不是引入第二套图像栈。因此 Bitmap 和 PNG 文件会经过完全相同的识别路径。
/// </summary>
public sealed class VisionPipeline
{
    public const int DesignWidth = 1280;
    public const int DesignHeight = 720;

    readonly Func<Bitmap, Task<IReadOnlyList<OcrWord>>>? ocrReader;
    readonly Dictionary<string, VisualTemplate> templateCache = new(StringComparer.OrdinalIgnoreCase);
    readonly OpenCvFeatureMatcher featureMatcher = new();

    public VisionPipeline(Func<Bitmap, Task<IReadOnlyList<OcrWord>>>? ocrReader = null)
    {
        this.ocrReader = ocrReader;
    }

    public async Task<VisionRecognitionResult> RecognizeFileAsync(
        VisionTask task, string imagePath, Func<OcrWord, bool>? wordFilter = null,
        CancellationToken token = default)
    {
        if (string.IsNullOrWhiteSpace(imagePath)) throw new ArgumentException("PNG 路径不能为空", nameof(imagePath));
        if (!File.Exists(imagePath)) throw new FileNotFoundException("识图输入图片不存在", imagePath);

        using var loaded = new Bitmap(imagePath);
        // 从解码器流分离，这样调用返回后可以替换文件，
        // 并确保所有调用方收到普通的 24 位 RGB 位图。
        using var image = new Bitmap(loaded.Width, loaded.Height, PixelFormat.Format24bppRgb);
        using (var graphics = Graphics.FromImage(image)) graphics.DrawImageUnscaled(loaded, 0, 0);
        return await RecognizeAsync(task, image, wordFilter, token);
    }

    public async Task<VisionRecognitionResult> RecognizeAsync(
        VisionTask task, Bitmap frame, Func<OcrWord, bool>? wordFilter = null,
        CancellationToken token = default)
    {
        ArgumentNullException.ThrowIfNull(task);
        ArgumentNullException.ThrowIfNull(frame);
        token.ThrowIfCancellationRequested();

        var roi = ScaleRoi(task.Roi, frame.Size);
        if (roi.Width <= 0 || roi.Height <= 0)
            return VisionRecognitionResult.Miss(task, roi, "ROI 为空");

        return task.Algorithm switch
        {
            VisionAlgorithm.JustReturn => new(task.Name, task.Algorithm, true, roi, 1, null, null, [], []),
            VisionAlgorithm.MatchTemplate => MatchTemplate(task, frame, roi),
            VisionAlgorithm.OcrDetect => await DetectTextAsync(task, frame, roi, wordFilter, token),
            VisionAlgorithm.FeatureMatch => MatchFeatures(task, frame, roi),
            _ => throw new ArgumentOutOfRangeException(nameof(task.Algorithm), task.Algorithm, "未知识别算法")
        };
    }

    VisionRecognitionResult MatchTemplate(VisionTask task, Bitmap frame, Rectangle roi)
    {
        if (string.IsNullOrWhiteSpace(task.TemplatePath))
            throw new InvalidDataException($"识图任务“{task.Name}”缺少 template");

        var template = GetTemplate(task.TemplatePath);
        var candidates = template.FindAll(frame, .35, 128)
            .Where(match => roi.Contains(match.Center))
            .OrderByDescending(match => match.Score)
            .Take(32)
            .ToArray();
        var best = candidates.FirstOrDefault(x => x.Score >= task.TemplateThreshold);
        if (best is null)
            return new(task.Name, task.Algorithm, false, Rectangle.Empty, candidates.FirstOrDefault()?.Score ?? 0,
                null, null, candidates, [], "模板得分未达到阈值");

        return new(task.Name, task.Algorithm, true,
            new Rectangle(best.Center.X, best.Center.Y, 0, 0), best.Score,
            null, null, candidates, []);
    }

    VisionRecognitionResult MatchFeatures(VisionTask task, Bitmap frame, Rectangle roi)
    {
        if (string.IsNullOrWhiteSpace(task.TemplatePath))
            throw new InvalidDataException($"特征匹配任务“{task.Name}”缺少 template");

        var result = featureMatcher.Find(task.TemplatePath, frame, roi,
            task.MinimumFeatureMatches, task.FeatureRatio, task.FeatureCount);
        var matches = result.Hit
            ? [new VisualMatch(new Point(result.Box.Left + result.Box.Width / 2,
                result.Box.Top + result.Box.Height / 2), result.Score, 0)]
            : Array.Empty<VisualMatch>();
        return new(task.Name, task.Algorithm, result.Hit, result.Box, result.Score,
            null, null, matches, [], result.Detail);
    }

    async Task<VisionRecognitionResult> DetectTextAsync(
        VisionTask task, Bitmap frame, Rectangle roi, Func<OcrWord, bool>? wordFilter,
        CancellationToken token)
    {
        if (ocrReader is null)
            throw new InvalidOperationException("当前 VisionPipeline 没有配置 OCR 读取器");
        if (task.Text.Count == 0)
            throw new InvalidDataException($"OCR 任务“{task.Name}”缺少 text");

        using var crop = frame.Clone(roi, PixelFormat.Format24bppRgb);
        var localWords = await ocrReader(crop);
        token.ThrowIfCancellationRequested();
        var words = localWords
            .Where(word => word.Confidence >= task.MinimumOcrConfidence)
            .Select(word => word with { Left = word.Left + roi.Left, Top = word.Top + roi.Top })
            .ToArray();

        foreach (var expected in task.Text)
        {
            var match = OcrTextLocator.Find(words, expected, wordFilter, task.FullMatch);
            if (match is not null)
            {
                return new(task.Name, task.Algorithm, true, match.Bounds, match.Confidence,
                    match.Text, match, [], words);
            }
        }

        var text = OcrTextLocator.Compact(string.Concat(words
            .OrderBy(word => word.Top).ThenBy(word => word.Left)
            .Select(word => word.Text)));
        return new(task.Name, task.Algorithm, false, Rectangle.Empty, words.Length == 0 ? 0 : words.Max(x => x.Confidence),
            text, null, [], words, "OCR 未命中目标文本");
    }

    VisualTemplate GetTemplate(string path)
    {
        var fullPath = Path.GetFullPath(path);
        if (templateCache.TryGetValue(fullPath, out var cached)) return cached;
        if (!File.Exists(fullPath)) throw new FileNotFoundException("模板图片不存在", fullPath);

        using var asset = new Bitmap(fullPath);
        if (asset.Width <= 1 || asset.Height <= 1)
            throw new InvalidDataException($"模板图片尺寸无效：{fullPath}");

        // 模板通常从 1280x720 设计空间裁剪。现有匹配器以短边的相对比例表示补丁大小，
        // 因此两个比例都使用 720 作为设计空间分母。
        var template = VisualTemplate.CreateFromAsset(asset,
            asset.Width / (double)DesignHeight, asset.Height / (double)DesignHeight);
        if (!template.IsValid) throw new InvalidDataException($"模板图片内容无效：{fullPath}");
        templateCache[fullPath] = template;
        return template;
    }

    public static Rectangle ScaleRoi(Rectangle? designRoi, Size actualSize)
    {
        if (actualSize.Width <= 0 || actualSize.Height <= 0) return Rectangle.Empty;
        if (designRoi is null) return new Rectangle(Point.Empty, actualSize);
        var source = designRoi.Value;
        var x = (int)Math.Round(source.X * actualSize.Width / (double)DesignWidth);
        var y = (int)Math.Round(source.Y * actualSize.Height / (double)DesignHeight);
        var right = (int)Math.Round((source.X + source.Width) * actualSize.Width / (double)DesignWidth);
        var bottom = (int)Math.Round((source.Y + source.Height) * actualSize.Height / (double)DesignHeight);
        var bounds = Rectangle.FromLTRB(x, y, right, bottom);
        return Rectangle.Intersect(new Rectangle(Point.Empty, actualSize), bounds);
    }
}

/// <summary>
/// 加载新识别层使用的小型 JSON 任务格式。
/// 有意兼容 MAA 任务架构中有用的子集，同时使资源路径相对于 JSON 文件。
/// </summary>
public sealed class VisionTaskCatalog
{
    readonly Dictionary<string, VisionTask> tasks;

    VisionTaskCatalog(Dictionary<string, VisionTask> tasks) => this.tasks = tasks;

    public IReadOnlyCollection<string> Names => tasks.Keys;

    public VisionTask Get(string name)
        => tasks.TryGetValue(name, out var task)
            ? task
            : throw new KeyNotFoundException($"未找到识图任务：{name}");

    public static VisionTaskCatalog Load(string path)
    {
        if (!File.Exists(path)) throw new FileNotFoundException("识图任务配置不存在", path);
        using var document = JsonDocument.Parse(File.ReadAllText(path));
        if (document.RootElement.ValueKind != JsonValueKind.Object)
            throw new InvalidDataException("识图任务配置根节点必须是 JSON 对象");

        var baseDirectory = Path.GetDirectoryName(Path.GetFullPath(path))!;
        var result = new Dictionary<string, VisionTask>(StringComparer.OrdinalIgnoreCase);
        foreach (var property in document.RootElement.EnumerateObject())
        {
            if (property.Name.StartsWith('$')) continue;
            var node = property.Value;
            if (node.ValueKind != JsonValueKind.Object)
                throw new InvalidDataException($"识图任务“{property.Name}”必须是对象");

            var algorithm = ParseAlgorithm(node, property.Name);
            var templatePath = ReadString(node, "template");
            if (!string.IsNullOrWhiteSpace(templatePath) && !Path.IsPathRooted(templatePath))
                templatePath = Path.GetFullPath(Path.Combine(baseDirectory, templatePath));
            var text = ReadStrings(node, "text");
            var roi = ReadRoi(node, property.Name);
            var threshold = ReadNumber(node, "templThreshold") ?? .80;
            var minimumFeatureMatches = ReadInteger(node, "minFeatureMatches") ?? 6;
            var featureRatio = ReadNumber(node, "featureRatio") ?? .75;
            var featureCount = ReadInteger(node, "featureCount") ?? 800;
            var fullMatch = ReadBool(node, "fullMatch") ?? false;
            var minConfidence = ReadNumber(node, "minOcrConfidence") ?? 10;

            if ((algorithm == VisionAlgorithm.MatchTemplate || algorithm == VisionAlgorithm.FeatureMatch) &&
                string.IsNullOrWhiteSpace(templatePath))
                throw new InvalidDataException($"模板任务“{property.Name}”缺少 template");
            if (algorithm == VisionAlgorithm.OcrDetect && text.Count == 0)
                throw new InvalidDataException($"OCR 任务“{property.Name}”缺少 text");

            result[property.Name] = new VisionTask
            {
                Name = property.Name,
                Algorithm = algorithm,
                TemplatePath = templatePath,
                Text = text,
                Roi = roi,
                TemplateThreshold = Math.Clamp(threshold, 0, 1),
                MinimumFeatureMatches = Math.Max(4, minimumFeatureMatches),
                FeatureRatio = Math.Clamp(featureRatio, .5, .95),
                FeatureCount = Math.Clamp(featureCount, 100, 4000),
                FullMatch = fullMatch,
                MinimumOcrConfidence = Math.Max(0, minConfidence)
            };
        }
        return new VisionTaskCatalog(result);
    }

    static VisionAlgorithm ParseAlgorithm(JsonElement node, string name)
    {
        var raw = ReadString(node, "algorithm") ?? "MatchTemplate";
        return raw switch
        {
            "JustReturn" => VisionAlgorithm.JustReturn,
            "MatchTemplate" or "TemplateMatch" => VisionAlgorithm.MatchTemplate,
            "OcrDetect" or "OCR" => VisionAlgorithm.OcrDetect,
            "FeatureMatch" => VisionAlgorithm.FeatureMatch,
            _ => throw new InvalidDataException($"识图任务“{name}”使用了未知算法：{raw}")
        };
    }

    static Rectangle? ReadRoi(JsonElement node, string name)
    {
        if (!node.TryGetProperty("roi", out var value)) return null;
        if (value.ValueKind != JsonValueKind.Array || value.GetArrayLength() != 4)
            throw new InvalidDataException($"识图任务“{name}”的 roi 必须是 [x,y,width,height]");
        var values = value.EnumerateArray().Select(x => x.GetInt32()).ToArray();
        if (values[2] <= 0 || values[3] <= 0)
            throw new InvalidDataException($"识图任务“{name}”的 roi 尺寸必须大于 0");
        return new Rectangle(values[0], values[1], values[2], values[3]);
    }

    static string? ReadString(JsonElement node, string name)
        => node.TryGetProperty(name, out var value) && value.ValueKind == JsonValueKind.String
            ? value.GetString()
            : null;

    static IReadOnlyList<string> ReadStrings(JsonElement node, string name)
    {
        if (!node.TryGetProperty(name, out var value)) return [];
        if (value.ValueKind == JsonValueKind.String) return [value.GetString() ?? ""];
        if (value.ValueKind != JsonValueKind.Array)
            throw new InvalidDataException($"识图任务字段 {name} 必须是字符串或字符串数组");
        return value.EnumerateArray().Select(x => x.GetString() ?? "").Where(x => x.Length > 0).ToArray();
    }

    static double? ReadNumber(JsonElement node, string name)
    {
        if (!node.TryGetProperty(name, out var value)) return null;
        if (value.ValueKind == JsonValueKind.Number && value.TryGetDouble(out var number)) return number;
        if (value.ValueKind == JsonValueKind.Array && value.GetArrayLength() > 0 &&
            value[0].TryGetDouble(out number)) return number;
        throw new InvalidDataException($"识图任务字段 {name} 必须是数字");
    }

    static int? ReadInteger(JsonElement node, string name)
    {
        var number = ReadNumber(node, name);
        return number is null ? null : (int)Math.Round(number.Value);
    }

    static bool? ReadBool(JsonElement node, string name)
    {
        if (!node.TryGetProperty(name, out var value)) return null;
        if (value.ValueKind == JsonValueKind.True || value.ValueKind == JsonValueKind.False) return value.GetBoolean();
        throw new InvalidDataException($"识图任务字段 {name} 必须是布尔值");
    }
}
