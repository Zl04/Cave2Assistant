using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;

namespace AdbMapController;

public sealed record OcrWord(string Text, int Left, int Top, int Width, int Height, double Confidence)
{
    public int Right => Left + Width;
    public int Bottom => Top + Height;
    public Point Center => new(Left + Width / 2, Top + Height / 2);
}

public sealed record OcrTextMatch(string Text, Rectangle Bounds, double Confidence)
{
    public Point Center => new(Bounds.Left + Bounds.Width / 2, Bounds.Top + Bounds.Height / 2);
}

public static class OcrTextLocator
{
    public static OcrTextMatch? Find(IEnumerable<OcrWord> source, string target,
        Func<OcrWord, bool>? filter = null, bool fullMatch = false)
    {
        var wanted = Compact(target);
        if (wanted.Length == 0) return null;
        var words = source.Where(x => !string.IsNullOrWhiteSpace(x.Text) &&
                x.Confidence >= 10 && (filter?.Invoke(x) ?? true))
            .OrderBy(x => x.Top).ThenBy(x => x.Left).ToList();
        OcrTextMatch? best = null;
        foreach (var line in GroupLines(words))
        for (var start = 0; start < line.Count; start++)
        {
            var joined = "";
            for (var end = start; end < line.Count && end < start + 4; end++)
            {
                if (end > start && line[end].Left - line[end - 1].Right > Math.Max(12, line[end].Height * 3)) break;
                joined += Compact(line[end].Text);
                var matched = fullMatch
                    ? string.Equals(joined, wanted, StringComparison.Ordinal)
                    : joined.Contains(wanted, StringComparison.Ordinal);
                if (!matched) continue;
                var selected = line.Skip(start).Take(end - start + 1).ToList();
                var bounds = Rectangle.FromLTRB(selected.Min(x => x.Left), selected.Min(x => x.Top), selected.Max(x => x.Right), selected.Max(x => x.Bottom));
                var match = new OcrTextMatch(target, bounds, selected.Average(x => x.Confidence));
                if (best is null || match.Confidence > best.Confidence) best = match;
                break;
            }
        }
        return best;
    }

    static IEnumerable<List<OcrWord>> GroupLines(IReadOnlyList<OcrWord> words)
    {
        foreach (var word in words)
        {
            // 分组有意只依据垂直距离；调用方会在下面对每一行排序，
            // 以容忍检测器输出顺序的差异。
            var existing = words.TakeWhile(x => !ReferenceEquals(x, word)).FirstOrDefault(x =>
                Math.Abs(x.Center.Y - word.Center.Y) <= Math.Max(8, Math.Min(x.Height, word.Height)));
            if (existing is not null) continue;
            yield return words.Where(x => Math.Abs(x.Center.Y - word.Center.Y) <= Math.Max(8, Math.Min(x.Height, word.Height)))
                .OrderBy(x => x.Left).ToList();
        }
    }

    public static string Compact(string text)
        => new string((text ?? "").Where(c => !char.IsWhiteSpace(c) && !char.IsPunctuation(c) && !char.IsSymbol(c)).ToArray());
}
