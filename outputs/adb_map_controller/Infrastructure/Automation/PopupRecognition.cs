using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text.RegularExpressions;

namespace AdbMapController;

/// <summary>
/// 下一层覆盖层的纯视觉/文本分类。
/// 将其与 ADB 传输分离，可以在没有设备的情况下重放误报案例，
/// 并防止移动看门狗自行发明规则。
/// </summary>
public static class PopupRecognition
{
    public static VisualMatch? FindCharacterAdvancementCloseButton(Bitmap frame, string templatePath)
    {
        // 只在中央弹窗的左下方搜索取消按钮，避免命中其它界面的 ×。
        var bounds = Rectangle.FromLTRB((int)(frame.Width * .30), (int)(frame.Height * .54),
            (int)(frame.Width * .50), (int)(frame.Height * .72));
        using var crop = frame.Clone(bounds, frame.PixelFormat);
        using var asset = new Bitmap(templatePath);
        var baseSize = Math.Min(crop.Width, crop.Height);
        var screenScale = Math.Min(frame.Width, frame.Height) / 565d;
        VisualMatch? best = null;
        foreach (var scale in new[] { .9, 1.0, 1.1 })
        {
            var template = VisualTemplate.FromFile(templatePath,
                asset.Width * screenScale * scale / baseSize,
                asset.Height * screenScale * scale / baseSize);
            var match = template.Find(crop, .85);
            if (match is not null && (best is null || match.Score > best.Score))
                best = match with { Center = new Point(match.Center.X + bounds.Left, match.Center.Y + bounds.Top) };
        }
        return best;
    }

    public static NextFloorDialogKind ClassifyNextFloorDialog(Bitmap source, string? ocrText)
        => ClassifyNextFloorDialog(source, ocrText, ocrText);

    public static NextFloorDialogKind ClassifyNextFloorDialog(
        Bitmap source,
        string? titleText,
        string? bodyText)
    {
        // 三选一界面有稳定的语义标题“贪婪抉择”。
        // 不再使用黄色按钮面积作为判定条件，避免普通地图/战斗画面误报。
        if (IsGreedySelectionTitle(titleText)) return NextFloorDialogKind.GreedySelection;
        // 下一层确认框的正文是稳定的语义信号。不要再要求中央面板或绿色按钮
        // 的颜色阈值同时命中，否则转场动画、截图变暗或按钮样式变化会漏检。
        if (!IsNextFloorDialogText(bodyText))
            return NextFloorDialogKind.None;

        return HasNextFloorWarningText(source)
            ? NextFloorDialogKind.WarningConfirm
            : NextFloorDialogKind.PlainConfirm;
    }

    public static bool IsGreedySelectionTitle(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return false;
        var corrected = GreedyTitleCorrector.CorrectTitleLines(text)!;
        var normalized = Regex.Replace(corrected, @"[^\p{L}\p{N}]", "");
        return normalized.Contains("贪婪抉择", StringComparison.Ordinal);
    }

    public static bool IsGreedySelectionReturnOnly(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return false;
        var normalized = NormalizeText(text);
        var hasReturn = normalized.Contains("返回城镇", StringComparison.Ordinal) ||
            normalized.Contains("安全回城", StringComparison.Ordinal) ||
            normalized.Contains("特殊回城", StringComparison.Ordinal);
        var hasContinue = normalized.Contains("继续探险", StringComparison.Ordinal) ||
            normalized.Contains("前往下一层", StringComparison.Ordinal);
        return hasReturn && !hasContinue;
    }

    /// <summary>
    /// Return-event cards use the red title ribbon, while a continue-event card
    /// uses the plain title style. The three card regions are stable in the
    /// game's greedy-selection layout, so this gives the caller the displayed
    /// card indexes instead of assuming a return card has a fixed position.
    /// </summary>
    public static IReadOnlyList<int> FindGreedySelectionReturnCards(Bitmap source)
    {
        if (source is null) throw new ArgumentNullException(nameof(source));

        var cards = new List<int>();
        foreach (var (center, index) in new[] { (.313, 0), (.500, 1), (.687, 2) })
        {
            var redTitleRatio = OpenCvPopupColorAnalysis.Ratio(source,
                (center - .075, center + .075, .245, .330), PopupColorKind.RedWarning);
            if (redTitleRatio >= .15) cards.Add(index);
        }

        return cards;
    }

    public static bool IsNextFloorDialogText(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return false;
        var normalized = NormalizeText(text);
        return normalized.Contains("下一层", StringComparison.Ordinal) ||
            normalized.Contains("进入下层", StringComparison.Ordinal) ||
            (normalized.Contains("下层", StringComparison.Ordinal) &&
             normalized.Contains("进入", StringComparison.Ordinal));
    }

    public static bool IsCharacterAdvancementDialogText(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return false;
        return NormalizeText(text).Contains("勇敢的冒险者角色进阶已开启", StringComparison.Ordinal);
    }

    static string NormalizeText(string text)
        => Regex.Replace(text, @"[^\p{L}\p{N}]", "")
            .Replace('層', '层').Replace('進', '进').Replace('鎮', '镇');

    public static bool LooksLikeEnterNextFloorConfirmVisual(Bitmap source)
    {
        var panel = OpenCvPopupColorAnalysis.Ratio(source, (.28, .72, .25, .78),
            PopupColorKind.LightNeutralPanel);
        var confirm = OpenCvPopupColorAnalysis.Ratio(source, (.50, .70, .54, .75),
            PopupColorKind.GreenButton);
        return panel >= .30 && confirm >= .08;
    }

    static bool HasNextFloorWarningText(Bitmap source)
    {
        var warningText = OpenCvPopupColorAnalysis.Ratio(source, (.33, .67, .37, .58),
            PopupColorKind.RedWarning);
        return warningText >= .015;
    }
}
