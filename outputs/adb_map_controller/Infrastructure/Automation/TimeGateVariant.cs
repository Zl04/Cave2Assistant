using System;
using System.Linq;
using System.Text.RegularExpressions;

namespace AdbMapController;

public enum TimeGateVariant
{
    Unknown,
    Normal,
    Hero
}

/// <summary>
/// Classifies the title shown in the upper-left panel after entering Time Gate.
/// A normal page shows a floor title (for example "第171层"), while a hero page
/// shows a map name (for example "遗忘之穴").
/// </summary>
public static class TimeGateVariantClassifier
{
    static readonly Regex NormalFloorTitle = new(
        @"(?:第)?\d{1,3}层",
        RegexOptions.Compiled | RegexOptions.CultureInvariant);
    static readonly string[] HeroMapTitles =
    [
        "遗忘之穴", "巨石旷野", "淤泥回廊", "大裂缝", "旧神庇护所", "幽魂废都"
    ];

    public static TimeGateVariant Classify(string? title)
    {
        if (string.IsNullOrWhiteSpace(title)) return TimeGateVariant.Unknown;

        var compact = Compact(title);
        if (compact.Length == 0) return TimeGateVariant.Unknown;
        if (NormalFloorTitle.IsMatch(compact)) return TimeGateVariant.Normal;
        return HeroMapTitles.Any(compact.Contains)
            ? TimeGateVariant.Hero
            : TimeGateVariant.Unknown;
    }

    public static bool IsHeroEntry(string? entryName)
        => !string.IsNullOrWhiteSpace(entryName) &&
           entryName.TrimStart().StartsWith("图", StringComparison.Ordinal);

    static string Compact(string value)
    {
        var chars = value.Where(c => !char.IsWhiteSpace(c) &&
                                     c != '第' &&
                                     c != '\r' &&
                                     c != '\n' &&
                                     c != '\t').ToArray();
        return new string(chars);
    }
}
