using System.Drawing;
using System.Text.Json;

namespace AdbMapController;

/// <summary>点金台选择游戏标为可用的物品；翻页与重试顺序由 altar-pipeline.json 控制。</summary>
public sealed class AltarPipeline : IMaaPipelineHandler<AltarPipeline>
{
    readonly IEquipmentSaleDevice device;
    readonly MaaPipelineCatalog catalog;
    readonly Action<string> log;
    readonly int maxPages, scrollDistance, scrollDurationMs, settleDelayMs;
    Point? candidate;
    string? previousPage;
    int pages, unchanged;
    bool lastPage, submitted;

    public string Name => "Altar";
    public bool Submitted => submitted;

    public AltarPipeline(AdbClient adb, string configuration, Action<string> log)
        : this(new AdbEquipmentSaleDevice(adb), configuration, log) { }

    public AltarPipeline(IEquipmentSaleDevice device, string configuration, Action<string> log)
    {
        this.device = device;
        this.log = log;
        catalog = MaaPipelineCatalogLoader.Load(configuration);
        using var json = JsonDocument.Parse(File.ReadAllText(configuration));
        var settings = json.RootElement.GetProperty("$settings");
        maxPages = settings.GetProperty("maxPages").GetInt32();
        scrollDistance = settings.GetProperty("scrollDistance").GetInt32();
        scrollDurationMs = settings.GetProperty("scrollDurationMs").GetInt32();
        settleDelayMs = settings.GetProperty("settleDelayMs").GetInt32();
        if (maxPages is < 1 or > 100 || scrollDistance is < 40 or > 180 ||
            scrollDurationMs is < 300 or > 3000 || settleDelayMs is < 200 or > 2000)
            throw new InvalidDataException("点金台翻页配置无效");
    }

    public Task<MaaPipelineExecutionResult> RunAsync(CancellationToken token, IMaaPipelineTraceSink? trace = null)
        => new MaaPipeline<AltarPipeline>(catalog, [this],
            new MaaPipelineExecutionOptions { TaskChain = "Altar", RetryTimes = 0, MaxTransitions = maxPages * 2 + 12 }, trace)
            .RunAsync(this, ["Start"], token);

    async Task<Bitmap> Capture(CancellationToken token)
    {
        using var source = await device.CaptureAsync(token);
        return EquipmentSaleVision.Normalize(source);
    }

    public async Task<MaaPipelineRecognitionResult> RecognizeAsync(MaaPipelineTask task,
        MaaPipelineTaskContext<AltarPipeline> context, CancellationToken token)
    {
        if (task.Name == "Finish") return MaaPipelineRecognitionResult.Hit();
        if (task.Name == "Scroll") return !lastPage && pages < maxPages && unchanged < 2
            ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("背包末页或翻页停滞");
        if (task.Name is "DoubleClick" or "RetryDoubleClick") return candidate is not null
            ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("可点击装备位置不存在");
        using var frame = await Capture(token);
        if (task.Name is "Ready" or "ReadyAfterRetry")
        {
            var enabled = AltarVision.IsButtonEnabled(frame);
            log($"点金台{(task.Name == "Ready" ? "首次" : "补试后")}按钮检查：{(enabled ? "已点亮" : "未点亮")}");
            return enabled ? MaaPipelineRecognitionResult.Hit(detail: "点金按钮已点亮")
                : MaaPipelineRecognitionResult.Miss("点金按钮未点亮");
        }
        if (task.Name == "Submit") return AltarVision.IsButtonEnabled(frame)
            ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("点金前按钮未点亮");
        if (task.Name != "FindUsable") return MaaPipelineRecognitionResult.Miss("未知节点");
        if (!PopupRecognition.HasAltarDialog(frame)) return MaaPipelineRecognitionResult.Miss("点金台界面已关闭");
        candidate = AltarVision.FindUsable(frame, out var quality, out var rows);
        log($"点金台第 {pages + 1} 页扫描：按装备底板边缘识别白色/蓝色品质，其余品质和空格跳过");
        foreach (var row in rows) log($"点金台格子扫描：{row}");
        if (candidate is not null)
        {
            log($"点金台发现可点击装备：({candidate.Value.X},{candidate.Value.Y})，第 {pages + 1} 页，品质={quality}");
            return MaaPipelineRecognitionResult.Hit();
        }
        lastPage = AltarVision.HasEmptyCell(frame);
        var signature = AltarVision.PageSignature(frame);
        unchanged = signature == previousPage ? unchanged + 1 : 0;
        previousPage = signature;
        log($"点金台第 {pages + 1} 页未发现白色或蓝色装备，末页={lastPage}，连续未变化={unchanged}");
        return MaaPipelineRecognitionResult.Miss("当前页未发现可点击装备");
    }

    public async Task<MaaPipelineActionResult> ExecuteAsync(MaaPipelineTask task,
        MaaPipelineRecognitionResult recognition, MaaPipelineTaskContext<AltarPipeline> context,
        CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        switch (task.Name)
        {
            case "Scroll":
                log($"点金台第 {pages + 1} 页无候选，向下拖动背包");
                await device.SwipeAsync(.782, .705, .782, (.705 * 565 - scrollDistance) / 565, scrollDurationMs);
                pages++;
                await Task.Delay(settleDelayMs, token);
                break;
            case "DoubleClick":
            case "RetryDoubleClick":
                if (candidate is not { } point) return MaaPipelineActionResult.Failure("可点击装备位置不存在");
                log($"点金台{(task.Name == "DoubleClick" ? "首次" : "补试")}双击装备：({point.X},{point.Y})");
                await device.TapAsync(point.X / 1004d, point.Y / 565d);
                await Task.Delay(110, token);
                await device.TapAsync(point.X / 1004d, point.Y / 565d);
                break;
            case "Submit":
                await device.TapAsync(175 / 1004d, 493 / 565d);
                submitted = true;
                log("点金台已点击点金按钮");
                break;
            case "Finish":
                log(submitted ? "点金台本层交互结束" : "点金台无可点击装备或按钮未点亮，本层不再尝试");
                break;
        }
        return MaaPipelineActionResult.Success();
    }
}

public static class AltarVision
{
    static readonly int[] X = [667, 731, 794, 858, 922];
    static readonly int[] Y = [154, 218, 282, 347, 411];

    public static Point? FindUsable(Bitmap frame, out string quality, out string[] rows)
    {
        Point? blue = null, white = null;
        quality = "无";
        var details = new List<string>();
        for (var row = 0; row < 4; row++)
        {
            var cells = new List<string>();
            for (var col = 0; col < X.Length; col++)
            {
                var x = X[col]; var y = Y[row];
                if (IsEmptyCell(frame, x, y))
                {
                    cells.Add($"{col + 1}({x},{y})=空");
                    continue;
                }
                var detected = ClassifyPlate(frame, x, y);
                cells.Add($"{col + 1}({x},{y})={detected}");
                if (detected == "蓝色" && blue is null) blue = new Point(x, y);
                if (detected == "白色" && white is null) white = new Point(x, y);
            }
            details.Add($"第{row + 1}行 {string.Join(" ", cells)}");
        }
        rows = details.ToArray();
        if (blue is not null) { quality = "蓝色"; return blue; }
        if (white is not null) { quality = "白色"; return white; }
        return null;
    }

    static string ClassifyPlate(Bitmap frame, int x, int y)
    {
        // 与装备出售识别相同：在底板的左右及上下窄边取样，要求至少两条边
        // 呈现同一品质颜色，且其中一条为侧边，避免图标内部颜色冒充底板。
        var strips = new[]
        {
            Rectangle.FromLTRB(x - 28, y - 17, x - 23, y + 18),
            Rectangle.FromLTRB(x + 23, y - 17, x + 28, y + 18),
            Rectangle.FromLTRB(x - 17, y - 28, x + 18, y - 23),
            Rectangle.FromLTRB(x - 17, y + 23, x + 18, y + 28)
        };
        var blueStrips = 0; var whiteStrips = 0;
        var blueSide = false; var whiteSide = false;
        for (var i = 0; i < strips.Length; i++)
        {
            var blue = 0; var white = 0;
            var strip = strips[i];
            for (var py = strip.Top; py < strip.Bottom; py++)
            for (var px = strip.Left; px < strip.Right; px++)
            {
                var color = frame.GetPixel(px, py);
                var saturation = color.GetSaturation();
                var brightness = color.GetBrightness();
                if (saturation >= .12 && brightness >= .20 && color.GetHue() is >= 165 and <= 255) blue++;
                if (saturation <= .13 && brightness >= .60) white++;
            }
            if (blue >= 12) { blueStrips++; if (i < 2) blueSide = true; }
            if (white >= 12) { whiteStrips++; if (i < 2) whiteSide = true; }
        }
        if (blueStrips >= 2 && blueSide) return "蓝色";
        if (whiteStrips >= 2 && whiteSide) return "白色";
        return "其他/禁用";
    }

    public static bool HasEmptyCell(Bitmap frame)
    {
        foreach (var y in Y.Take(4))
        foreach (var x in X)
            if (IsEmptyCell(frame, x, y)) return true;
        return false;
    }

    static bool IsEmptyCell(Bitmap frame, int x, int y)
    {
        var values = new List<int>();
        for (var dy = -14; dy <= 14; dy += 4)
        for (var dx = -14; dx <= 14; dx += 4)
        {
            var c = frame.GetPixel(x + dx, y + dy);
            values.Add(c.R + c.G + c.B);
        }
        return values.Max() - values.Min() < 22;
    }

    public static string PageSignature(Bitmap frame) => string.Join(',',
        Y.Take(4).SelectMany(y => X.Select(x =>
        {
            var c = frame.GetPixel(x, y);
            return $"{c.R / 16:X}{c.G / 16:X}{c.B / 16:X}";
        })));

    public static bool IsButtonEnabled(Bitmap frame)
    {
        var brightGold = 0;
        var samples = 0;
        for (var y = 478; y <= 509; y += 2)
        for (var x = 85; x <= 265; x += 2)
        {
            var c = frame.GetPixel(x, y);
            if (c.R > 115 && c.R > c.G * 1.14 && c.G > c.B * 1.25 && c.G > 75) brightGold++;
            samples++;
        }
        return brightGold > samples * .025;
    }
}
