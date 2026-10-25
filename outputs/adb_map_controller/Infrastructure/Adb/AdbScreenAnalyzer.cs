using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// Interprets captured game frames. It owns OCR and image recognition state,
/// but never captures screenshots or sends device input.
/// </summary>
internal sealed class AdbScreenAnalyzer : IDisposable
{
    readonly PaddleOcrEngine paddleOcr = new();
    internal Action<string>? OcrTimingLog
    {
        get => paddleOcr.TimingLog;
        set => paddleOcr.TimingLog = value;
    }
    readonly Lazy<VisualTemplate?> miningToolTemplate = new(LoadMiningToolTemplate);
    readonly Lazy<VisualTemplate?> miningCancelTemplate = new(LoadMiningCancelTemplate);
    readonly Lazy<VisualTemplate?> fogRevealTemplate = new(() =>
    {
        var path = Path.Combine(AppContext.BaseDirectory, "vision", "fog_reveal_tool.png");
        // Captured directly from the in-game quick slot at 1920x1080.
        return File.Exists(path) ? VisualTemplate.FromFile(path, 85d / 1080d, 90d / 1080d) : null;
    });
    readonly Lazy<VisualTemplate?> escapeScrollTemplate = new(() =>
    {
        var path = Path.Combine(AppContext.BaseDirectory, "templates", "ui", "escape-scroll.png");
        // Captured directly from the in-game quick slot at 1920x1080.
        return File.Exists(path) ? VisualTemplate.FromFile(path, 85d / 1080d, 89d / 1080d) : null;
    });
    readonly Lazy<QuickbarBackground?> quickbarBackground = new(() =>
    {
        var path = Path.Combine(AppContext.BaseDirectory, "vision", "quickbar-background.png");
        return File.Exists(path) ? new QuickbarBackground(path) : null;
    });

    public async Task<BottomToolInfo?> FindBottomToolAsync(
        Bitmap source, BottomToolKind kind, CancellationToken token = default)
    {
        ArgumentNullException.ThrowIfNull(source);
        var template = kind switch
        {
            BottomToolKind.Mining => miningToolTemplate.Value,
            BottomToolKind.FogReveal => fogRevealTemplate.Value,
            BottomToolKind.EscapeScroll => escapeScrollTemplate.Value,
            _ => throw new ArgumentOutOfRangeException(nameof(kind)),
        };
        if (template is null) return null;

        foreach (var match in template.FindAll(source, .84, 16))
        {
            token.ThrowIfCancellationRequested();
            var center = match.Center;
            var x = center.X / (double)source.Width;
            var y = center.Y / (double)source.Height;
            if (x is < .12 or > .88 || y is < .82 or > .97) continue;
            var quantity = MiningToolGuard.ParseQuantityText(
                await ReadBottomToolQuantityTextAsync(source, center, token));
            return new BottomToolInfo(kind, x, y, quantity);
        }
        return null;
    }

    public string? LastRiftGemTitle { get; private set; }
    public string GemTitleDetectionMode { get; private set; } = "未检测";
    public NextFloorDialogKind LastNextFloorDialogKind { get; private set; }

    public Task InitializeOcrAsync(CancellationToken token = default)
        => paddleOcr.InitializeAsync(token);

    public async Task<string> ReadTextAsync(Bitmap image, CancellationToken token = default)
        => (await paddleOcr.RecognizeAsync(image, token)).Text.Trim();

    public async Task<IReadOnlyList<OcrWord>> ReadOcrWordsAsync(Bitmap image, CancellationToken token)
    {
        var response = await paddleOcr.RecognizeAsync(image, token);
        return response.Words
            .Where(word => !string.IsNullOrWhiteSpace(word.Text) && word.Width > 0 && word.Height > 0)
            .Select(word => new OcrWord(word.Text.Trim(), word.Left, word.Top, word.Width, word.Height, word.Confidence))
            .ToArray();
    }

    public async Task<MiningToolStatus> ReadMiningToolStatusAsync(Bitmap source, CancellationToken token = default)
    {
        var tool = await FindBottomToolAsync(source, BottomToolKind.Mining, token);
        var inSecondSlot = tool is not null &&
            Math.Abs(tool.X - MiningScreenCoordinates.ToolSlot.X) <= .10 &&
            Math.Abs(tool.Y - MiningScreenCoordinates.ToolSlot.Y) <= .10;
        return new(inSecondSlot, inSecondSlot ? tool!.Quantity : null);
    }

    static VisualTemplate? LoadMiningToolTemplate()
    {
        var path = Path.Combine(AppContext.BaseDirectory, "vision", "mining_tool_slot.png");
        if (!File.Exists(path)) return null;
        try
        {
            var template = VisualTemplate.FromFile(path);
            // The tight template is 97x81 at 1920x1080; scale from the shorter
            // display dimension so matching also works at other resolutions.
            template.PatchWidthRatio = 97d / 1080d;
            template.PatchHeightRatio = 81d / 1080d;
            return template;
        }
        catch { return null; }
    }

    static VisualTemplate? LoadMiningCancelTemplate()
    {
        var path = Path.Combine(AppContext.BaseDirectory, "vision", "mining_cancel.png");
        if (!File.Exists(path)) return null;
        try { return VisualTemplate.FromFile(path, 63d / 565d, 65d / 565d); }
        catch { return null; }
    }

    public bool HasMiningCancelIcon(Bitmap source)
    {
        var template = miningCancelTemplate.Value;
        if (template is null) return false;
        return template.FindAll(source, .84, 8).Any(match =>
            match.Center.X >= source.Width * .90 && match.Center.Y >= source.Height * .85);
    }

    internal static Rectangle BottomToolQuantityBounds(Size frame, Point slotCenter)
    {
        // All six quick slots use the same artwork and count-label layout.
        // These offsets were measured in a 1920x1080 frame. Convert them with
        // the game's FIXED_HEIGHT/FIXED_WIDTH scale, which also preserves the
        // ItemPanel and quickbar anchor transform on non-16:9 displays.
        var scale = QuickbarBackground.ScaleRelativeToFullHd(frame);
        var x = (int)Math.Round(slotCenter.X - 10 * scale);
        var y = (int)Math.Round(slotCenter.Y + 39 * scale);
        var width = Math.Max(1, (int)Math.Round(83 * scale));
        var height = Math.Max(1, (int)Math.Round(40 * scale));
        return Rectangle.Intersect(new Rectangle(Point.Empty, frame),
            new Rectangle(x, y, width, height));
    }

    async Task<string> ReadBottomToolQuantityTextAsync(Bitmap source, Point slotCenter, CancellationToken token)
    {
        var bounds = BottomToolQuantityBounds(source.Size, slotCenter);
        if (bounds.Width == 0 || bounds.Height == 0) return string.Empty;
        var alignment = QuickbarBackground.AlignmentFor(source.Size);
        OcrTimingLog?.Invoke(
            $"快捷栏数量取图：分辨率={source.Width}x{source.Height}，底板左上=({alignment.X},{alignment.Y})，" +
            $"倍率={alignment.Scale:F4}，底板锚点=(0,0)，数字区域=({bounds.X},{bounds.Y},{bounds.Width},{bounds.Height})");
        var background = quickbarBackground.Value;
        if (background is null) return string.Empty;
        using var color = background.RemoveFromQuantityPreservingColor(source, bounds);
        if (color is not null)
        {
            var colorText = await ReadTextAsync(color, token);
            if (MiningToolGuard.ParseQuantityText(colorText) is not null) return colorText;
            using var enlargedColor = new Bitmap(color, new Size(color.Width * 4, color.Height * 4));
            var enlargedColorText = await ReadTextAsync(enlargedColor, token);
            if (MiningToolGuard.ParseQuantityText(enlargedColorText) is not null) return enlargedColorText;
        }

        using var binary = background.RemoveFromQuantity(source, bounds);
        if (binary is null) return string.Empty;
        var binaryText = await ReadTextAsync(binary, token);
        if (MiningToolGuard.ParseQuantityText(binaryText) is not null) return binaryText;
        using var enlargedBinary = new Bitmap(binary, new Size(binary.Width * 4, binary.Height * 4));
        var enlargedBinaryText = await ReadTextAsync(enlargedBinary, token);
        return MiningToolGuard.ParseQuantityText(enlargedBinaryText) is not null
            ? enlargedBinaryText : string.Empty;
    }

    public bool HasNextFloorButton(Bitmap source)
    {
        // The button darkens during stable scenes; accept the observed brown/gold tone.
        return OpenCvPopupColorAnalysis.Ratio(source, (.78, .985, .45, .57),
            PopupColorKind.GoldButton) > .30;
    }

    public async Task<bool> HasServerErrorDialogAsync(Bitmap source, CancellationToken token = default)
    {
        if (!ConnectionPopupRecognition.IsCandidate(source)) return false;
        // Match the confirm button before reading the modal text.
        var text = await ReadScreenTextAsync(source, (.25, .75, .24, .74), "服务器异常弹窗", token);
        return ConnectionPopupRecognition.IsDisconnectText(text);
    }

    public Task<bool> HasServerErrorDialogAsync(Bitmap source, string? ocrText)
    {
        if (!ConnectionPopupRecognition.IsCandidate(source)) return Task.FromResult(false);
        return Task.FromResult(ConnectionPopupRecognition.IsDisconnectText(ocrText));
    }

    public Task<bool> HasEnterNextFloorConfirmAsync(Bitmap source)
        // Merchant/special-map confirmation uses a green button on the right.
        => Task.FromResult(OpenCvPopupColorAnalysis.Ratio(source, (.52, .68, .56, .72),
            PopupColorKind.GreenButton) > .15);

    public async Task<bool> HasNextFloorBonusSelectionAsync(Bitmap source, CancellationToken token = default)
    {
        var title = await ReadPopupTitleTextAsync(source, token);
        return PopupRecognition.IsGreedySelectionTitle(title);
    }

    public async Task<NextFloorDialogKind> DetectNextFloorDialogAsync(
        Bitmap bitmap,
        CancellationToken token,
        Action<string?>? bodyObserved,
        Action<string?>? titleObserved = null)
    {
        // 普通/警告确认框先用绿色勾按钮筛选，再读中央提示文字。
        if (PopupRecognition.HasNextFloorConfirmButton(bitmap))
        {
            var confirmText = await ReadScreenTextAsync(bitmap, (.24, .76, .24, .62), "换层确认提示", token);
            if (PopupRecognition.IsNextFloorConfirmText(confirmText))
            {
                bodyObserved?.Invoke(confirmText);
                titleObserved?.Invoke(null);
                return DetectNextFloorDialog(bitmap, null, confirmText);
            }
        }

        // 贪婪抉择仅以标题为入口；标题未命中时不读取卡片。
        var title = await ReadPopupTitleTextAsync(bitmap, token);
        titleObserved?.Invoke(title);
        if (!PopupRecognition.IsGreedySelectionTitle(title))
        {
            bodyObserved?.Invoke(null);
            LastNextFloorDialogKind = NextFloorDialogKind.None;
            return NextFloorDialogKind.None;
        }

        var body = await ReadScreenTextAsync(bitmap, (.20, .80, .20, .70), "贪婪抉择卡片", token);
        bodyObserved?.Invoke(body);
        return DetectNextFloorDialog(bitmap, title, body);
    }

    public NextFloorDialogKind DetectNextFloorDialog(Bitmap bitmap, string? ocrText)
        => DetectNextFloorDialog(bitmap, ocrText, ocrText);

    public NextFloorDialogKind DetectNextFloorDialog(Bitmap bitmap, string? titleText, string? bodyText)
    {
        LastNextFloorDialogKind = PopupRecognition.ClassifyNextFloorDialog(bitmap, titleText, bodyText);
        return LastNextFloorDialogKind;
    }

    public NextFloorDialogKind ClassifyNextFloorDialog(Bitmap bitmap, string? ocrText)
    {
        LastNextFloorDialogKind = PopupRecognition.ClassifyNextFloorDialog(bitmap, ocrText);
        return LastNextFloorDialogKind;
    }

    public async Task<string?> ReadPopupTitleTextAsync(Bitmap frame, CancellationToken token = default)
    {
        var rawTitle = await ReadScreenTextAsync(frame, (.35, .65, .03, .18), "贪婪抉择标题", token);
        var title = GreedyTitleCorrector.CorrectTitleLines(rawTitle);
        if (PopupRecognition.IsGreedySelectionTitle(title)) return title;

        // 短标题的字形在原始裁剪尺寸下可能未被检测器收录；放大同一区域再读一次。
        var bounds = new Rectangle((int)(frame.Width * .35), (int)(frame.Height * .03),
            (int)(frame.Width * .30), (int)(frame.Height * .15));
        using var crop = frame.Clone(bounds, PixelFormat.Format24bppRgb);
        using var enlarged = new Bitmap(crop, new Size(crop.Width * 2, crop.Height * 2));
        var retry = GreedyTitleCorrector.CorrectTitleLines(await ReadTextAsync(enlarged, token));
        return PopupRecognition.IsGreedySelectionTitle(retry) ? retry : title;
    }

    public async Task<bool> HasRiftGemSelectionAsync(Bitmap bitmap)
    {
        LastRiftGemTitle = null;
        GemTitleDetectionMode = "PaddleOCR标题区域";
        // The selection title is in a centered banner at the top of the screen.
        // Keep a wide crop around it for layout context without OCRing gameplay HUD text.
        var title = await ReadRiftGemTitleAsync(bitmap);
        return HasRiftGemSelectionText(title);
    }

    public Task<string?> ReadRiftGemTitleAsync(Bitmap bitmap, CancellationToken token = default)
        => ReadGemTitleAsync(bitmap, token);

    public bool HasRiftGemSelectionText(string? title)
    {
        GemTitleDetectionMode = "PaddleOCR标题区域";
        LastRiftGemTitle = title;
        return !string.IsNullOrWhiteSpace(title) && IsRiftGemTitle(title!);
    }

    public static bool IsRiftGemTitle(string text)
        => GemTitleMatcher.IsSelectionTitle(text);

    public async Task<string?> ReadScreenTextAsync(
        Bitmap source,
        (double X0, double X1, double Y0, double Y1) region,
        string description,
        CancellationToken token = default)
    {
        var sx = Math.Clamp((int)(source.Width * region.X0), 0, source.Width - 1);
        var sy = Math.Clamp((int)(source.Height * region.Y0), 0, source.Height - 1);
        var sw = Math.Clamp((int)(source.Width * (region.X1 - region.X0)), 1, source.Width - sx);
        var sh = Math.Clamp((int)(source.Height * (region.Y1 - region.Y0)), 1, source.Height - sy);
        using var screenCrop = source.Clone(new Rectangle(sx, sy, sw, sh), PixelFormat.Format24bppRgb);
        return await ReadTextAsync(screenCrop, token);
    }

    async Task<string?> ReadGemTitleAsync(Bitmap source, CancellationToken token)
    {
        return await ReadScreenTextAsync(source, (.20, .80, .00, .16), "秘境宝石标题", token);
    }

    public async Task<string> ReadPopupFrameTextAsync(Bitmap frame, CancellationToken token = default)
    {
        token.ThrowIfCancellationRequested();
        var text = await ReadTextAsync(frame, token);
        token.ThrowIfCancellationRequested();
        return text;
    }

    public void Dispose()
    {
        if (quickbarBackground.IsValueCreated) quickbarBackground.Value?.Dispose();
        paddleOcr.Dispose();
    }
}
