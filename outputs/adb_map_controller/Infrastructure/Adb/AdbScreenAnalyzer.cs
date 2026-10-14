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
        var iconPresent = HasMiningToolIcon(source);
        var quantityText = await ReadMiningToolQuantityTextAsync(source, token);
        return new(iconPresent, MiningToolGuard.ParseQuantityText(quantityText));
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

    bool HasMiningToolIcon(Bitmap source)
    {
        var template = miningToolTemplate.Value;
        if (template is null) return false;
        var expectedX = source.Width * MiningScreenCoordinates.ToolSlot.X;
        var expectedY = source.Height * MiningScreenCoordinates.ToolSlot.Y;
        return template.FindAll(source, .84, 16).Any(match =>
            Math.Abs(match.Center.X - expectedX) <= source.Width * .10 &&
            Math.Abs(match.Center.Y - expectedY) <= source.Height * .10);
    }

    async Task<string> ReadMiningToolQuantityTextAsync(Bitmap source, CancellationToken token)
    {
        // The marked count area in the lower-right of the second quick-bag slot.
        var sx = Math.Clamp((int)Math.Round(source.Width * .362), 0, source.Width - 1);
        var sy = Math.Clamp((int)Math.Round(source.Height * .963), 0, source.Height - 1);
        var sw = Math.Clamp((int)Math.Round(source.Width * .043), 1, source.Width - sx);
        var sh = Math.Clamp((int)Math.Round(source.Height * .037), 1, source.Height - sy);
        using var crop = source.Clone(new Rectangle(sx, sy, sw, sh), PixelFormat.Format24bppRgb);
        return await ReadTextAsync(crop, token);
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
        // Color is only a cheap candidate filter. The modal text is authoritative.
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
        Action<string?>? bodyObserved)
    {
        var title = await ReadPopupTitleTextAsync(bitmap, token);
        var body = await ReadScreenTextAsync(bitmap, (.20, .80, .20, .70), "换层弹窗", token);
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
        return GreedyTitleCorrector.CorrectTitleLines(rawTitle);
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

    public void Dispose() => paddleOcr.Dispose();
}
