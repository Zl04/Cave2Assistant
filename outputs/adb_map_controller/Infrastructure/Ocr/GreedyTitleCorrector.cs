using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace AdbMapController;

/// <summary>
/// 标题区域专用的词表纠错。只接受已实测的完整标题变体，
/// 不修改底层 OCR 原文，也不对普通句子做通用模糊替换。
/// </summary>
public static class GreedyTitleCorrector
{
    public const string CanonicalTitle = "贪婪抉择";

    static readonly HashSet<string> RecordedTitles = new(StringComparer.Ordinal)
    {
        CanonicalTitle,
        "贪婪块择",
        "贪婪执择",
        "含婪块择",
    };

    public static string? CorrectTitleLines(string? title)
    {
        if (string.IsNullOrWhiteSpace(title)) return title;
        return Regex.Replace(title, @"[^\r\n]+", line =>
        {
            var compact = Regex.Replace(line.Value, @"[^\p{L}\p{N}]", "");
            return RecordedTitles.Contains(compact) ? CanonicalTitle : line.Value;
        });
    }
}
