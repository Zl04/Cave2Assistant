using System.Drawing;

namespace AdbMapController;

public enum SaleQuality { Unknown, Purple, DarkGold, Gold }
public sealed record SaleCell(Rectangle Bounds, SaleQuality Quality, bool Empty, bool Selected, Point? Checkbox);
public sealed record SaleGrid(double Pitch, IReadOnlyList<SaleCell> Cells);

public sealed class EquipmentSaleVisionSettings
{
    public double GapCoverage { get; set; } = .70;
    public double FitTolerance { get; set; } = 2.1;
    public double QualitySaturation { get; set; } = .37;
    public double BorderCoverage { get; set; } = .30;
    public int BorderInset { get; set; } = 4;
    public int BorderBandWidth { get; set; } = 2;
    public int BorderSideStart { get; set; } = 28;
    public int[] PurpleHue { get; set; } = [260, 320];
    public int[] DarkGoldHue { get; set; } = [10, 34];
    public int[] GoldHue { get; set; } = [34, 70];
    public int[] CheckboxColor { get; set; } = [183, 167, 165];
    public int CheckboxTolerance { get; set; } = 12;
    public double EmptyStandardDeviation { get; set; } = 3;
    public string SelectedCheckTemplate { get; set; } = "templates/ui/EquipmentSale/selected_check.png";
    public double SelectedCheckThreshold { get; set; } = .97;
    public void Validate()
    {
        if (SelectedCheckThreshold is < .9 or > 1 || string.IsNullOrWhiteSpace(SelectedCheckTemplate) ||
            GapCoverage is < .5 or > .95 || FitTolerance is < .5 or > 3 || QualitySaturation is < .30 or > .8 ||
            BorderCoverage is < .2 or > .9 || BorderInset is < 4 or > 5 || BorderBandWidth is < 1 or > 2 ||
            BorderInset + BorderBandWidth > 6 || BorderSideStart is < 27 or > 32 ||
            CheckboxTolerance is < 0 or > 20 || EmptyStandardDeviation is <= 0 or > 5 ||
            CheckboxColor.Length != 3 || CheckboxColor.Any(c => c is < 0 or > 255) ||
            new[] { PurpleHue, DarkGoldHue, GoldHue }.Any(r => r.Length != 2 || r[0] < 0 || r[1] > 360 || r[0] >= r[1]))
            throw new InvalidDataException("出售 Pipeline 的网格或品质识别参数无效");
    }
}

/// <summary>从背景间隙拟合五列等距网格，选择框不参与网格推算。</summary>
public static class EquipmentSaleVision
{
    public const int Width = 1004, Height = 565;
    public static Bitmap Normalize(Bitmap source) => new(source, new Size(Width, Height));

    public static SaleGrid? Detect(Bitmap frame, EquipmentSaleVisionSettings? settings = null)
    {
        settings ??= new();
        // ROI 是搜索约束；实际边界和滚动后的行相位均由当前截图重新拟合。
        var values = new List<double>();
        for (var y = 145; y < 410; y++)
            for (var x = 552; x < 560; x++) values.Add(frame.GetPixel(x, y).GetBrightness());
        values.Sort();
        var background = values[values.Count / 2];
        bool Neutral(int x, int y)
        {
            var c = frame.GetPixel(x, y);
            return c.GetSaturation() < .20 && Math.Abs(c.GetBrightness() - background) < .10;
        }
        var vertical = Enumerable.Range(560, 332).Select(x =>
            Enumerable.Range(145, 265).Count(y => Neutral(x, y)) / 265d).ToArray();
        var xs = Fit(Bands(vertical, 560, settings.GapCoverage), 6, settings.FitTolerance);
        if (xs is null) return null;
        var left = (int)Math.Ceiling(xs[0] + 4);
        var right = (int)Math.Floor(xs[^1] - 4);
        var horizontal = Enumerable.Range(145, 325).Select(y =>
            Enumerable.Range(left, right - left).Count(x => Neutral(x, y)) / (double)(right - left)).ToArray();
        var ys = Fit(Bands(horizontal, 145, settings.GapCoverage), null, settings.FitTolerance);
        if (ys is null || ys.Length < 4) return null;
        var pitch = (xs[^1] - xs[0]) / 5;
        if (Math.Abs((ys[^1] - ys[0]) / (ys.Length - 1) - pitch) > pitch * .06) return null;
        var cells = new List<SaleCell>();
        // 仅处理完整、非底部渐隐行。首行可能被裁切，不能根据固定 y 坐标补齐。
        for (var row = 0; row < ys.Length - 1; row++)
        {
            if (ys[row] < 144 || ys[row + 1] > 411) continue;
            for (var col = 0; col < 5; col++)
            {
                var rect = Rectangle.FromLTRB((int)Math.Round(xs[col]), (int)Math.Round(ys[row]),
                    (int)Math.Round(xs[col + 1]), (int)Math.Round(ys[row + 1]));
                cells.Add(Inspect(frame, rect, settings));
            }
        }
        return cells.Count >= 10 ? new(pitch, cells) : null;
    }

    static double[] Bands(double[] profile, int offset, double coverage)
    {
        var result = new List<double>();
        for (var i = 0; i < profile.Length; i++)
        {
            if (profile[i] < coverage) continue;
            var start = i;
            while (i + 1 < profile.Length && profile[i + 1] >= coverage) i++;
            if (i - start >= 1) result.Add(offset + (start + i) / 2d);
        }
        return result.ToArray();
    }

    static double[]? Fit(double[] centers, int? required, double tolerance)
    {
        double[]? best = null;
        double bestError = double.MaxValue;
        var bestMatches = 0;
        for (var a = 0; a < centers.Length; a++)
        for (var b = a + 1; b < centers.Length; b++)
        for (var step = 1; step <= 6; step++)
        {
            var pitch = (centers[b] - centers[a]) / step;
            if (pitch < 50 || pitch > 80) continue;
            var matches = centers.Select(v => (Value: v, Index: (int)Math.Round((v - centers[a]) / pitch)))
                .Where(v => Math.Abs(v.Value - centers[a] - v.Index * pitch) <= tolerance)
                .GroupBy(v => v.Index).Select(g => g.First()).OrderBy(v => v.Index).ToArray();
            if (matches.Length < 4) continue;
            var span = matches[^1].Index - matches[0].Index + 1;
            if (required is { } count ? span != count : span != matches.Length) continue;
            var meanIndex = matches.Average(v => v.Index); var meanValue = matches.Average(v => v.Value);
            var slope = matches.Sum(v => (v.Index - meanIndex) * (v.Value - meanValue)) /
                matches.Sum(v => (v.Index - meanIndex) * (v.Index - meanIndex));
            var origin = meanValue - slope * meanIndex;
            var error = matches.Sum(v => Math.Abs(v.Value - origin - slope * v.Index));
            if (best is not null && (matches.Length < bestMatches || matches.Length == bestMatches && error >= bestError)) continue;
            best = Enumerable.Range(matches[0].Index, span).Select(i => origin + slope * i).ToArray(); bestError = error; bestMatches = matches.Length;
        }
        return best;
    }

    public static SaleCell Inspect(Bitmap frame, Rectangle r, EquipmentSaleVisionSettings? settings = null)
    {
        settings ??= new();
        var pixels = new List<Color>();
        for (var y = r.Top + 12; y < r.Bottom - 10; y++)
            for (var x = r.Left + 10; x < r.Right - 12; x++) pixels.Add(frame.GetPixel(x, y));
        double Std(Func<Color, double> channel)
        {
            var mean = pixels.Average(channel);
            return Math.Sqrt(pixels.Average(c => Math.Pow(channel(c) - mean, 2)));
        }
        var empty = Math.Max(Std(c => c.R), Math.Max(Std(c => c.G), Std(c => c.B))) < settings.EmptyStandardDeviation &&
            pixels.Average(c => c.GetBrightness()) is > .18f and < .40f;
        // 网格边界处是间隙中心。跳过外侧高亮和圆角，仅取原品质边框的窄带；
        // 两侧从选择框/MAX/锁标记下方开始，底边去掉两端，内部图标不参与取色。
        var left = new List<Color>(); var right = new List<Color>(); var bottom = new List<Color>();
        for (var y = r.Top + settings.BorderSideStart; y < r.Bottom - 12; y++)
            for (var offset = settings.BorderInset; offset < settings.BorderInset + settings.BorderBandWidth; offset++)
            {
                left.Add(frame.GetPixel(r.Left + offset, y));
                right.Add(frame.GetPixel(r.Right - offset, y));
            }
        for (var x = r.Left + 10; x < r.Right - 12; x++)
            for (var offset = settings.BorderInset; offset < settings.BorderInset + settings.BorderBandWidth; offset++)
                bottom.Add(frame.GetPixel(x, r.Bottom - offset));
        SaleQuality Quality(List<Color> samples)
        {
            var colors = samples.Where(c => (Math.Max(c.R, Math.Max(c.G, c.B)) - Math.Min(c.R, Math.Min(c.G, c.B))) / (double)Math.Max(1, (int)Math.Max(c.R, Math.Max(c.G, c.B))) >= settings.QualitySaturation && Math.Max(c.R, Math.Max(c.G, c.B)) >= 90).ToArray();
            if (colors.Length < samples.Count * settings.BorderCoverage) return SaleQuality.Unknown;
            var hues = colors.Select(c => c.GetHue()).Order().ToArray(); var hue = hues[hues.Length / 2];
            if (hue >= settings.PurpleHue[0] && hue <= settings.PurpleHue[1]) return SaleQuality.Purple;
            if (hue >= settings.DarkGoldHue[0] && hue < settings.DarkGoldHue[1]) return SaleQuality.DarkGold;
            if (hue >= settings.GoldHue[0] && hue <= settings.GoldHue[1]) return SaleQuality.Gold;
            return SaleQuality.Unknown;
        }
        var votes = new[] { Quality(left), Quality(right), Quality(bottom) }.Where(q => q != SaleQuality.Unknown).ToArray();
        // 至少两个独立边框片段一致；有效片段冲突时仍跳过，不能把未知色强行归类。
        var q = votes.Length >= 2 && votes.Distinct().Count() == 1 ? votes[0] : SaleQuality.Unknown;
        var neutral = new List<Point>();
        for (var y = r.Top + 2; y < r.Top + 27; y++)
        for (var x = r.Right - 26; x < r.Right - 3; x++)
        {
            var c = frame.GetPixel(x, y);
            if (Math.Abs(c.R - settings.CheckboxColor[0]) <= settings.CheckboxTolerance &&
                Math.Abs(c.G - settings.CheckboxColor[1]) <= settings.CheckboxTolerance &&
                Math.Abs(c.B - settings.CheckboxColor[2]) <= settings.CheckboxTolerance) neutral.Add(new(x, y));
        }
        Point? box = neutral.Count >= 180 ? new Point((int)neutral.Average(p => p.X), (int)neutral.Average(p => p.Y)) : null;
        var selected = SelectedCheckMatcher.Load(settings.SelectedCheckTemplate)
            .Score(frame, new Rectangle(r.Right - 29, r.Top - 3, 34, 34)) >= settings.SelectedCheckThreshold;
        return new(r, q, empty && q == SaleQuality.Unknown && box is null && !selected, selected, box);
    }
}
