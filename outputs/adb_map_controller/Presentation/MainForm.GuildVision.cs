using System.Collections.Concurrent;
using System.Drawing;

namespace AdbMapController;

public sealed partial class MainForm
{
    // 宽高按原游戏截图的短边换算；搜索区仅限制识别范围，不参与点击坐标计算。
    readonly record struct GuildTarget(string File, double Width, double Height,
        double Left, double Top, double Right, double Bottom, double Threshold = .70);

    static readonly IReadOnlyDictionary<string, GuildTarget> GuildTargets = new Dictionary<string, GuildTarget>
    {
        ["bastan-guild-entry"] = new("bastan-guild-entry.png", 28d / 565, 25d / 565, .49, .18, .60, .34, .68),
        ["guild-map-title"] = new("guild-map-title.png", 324d / 720, 72d / 720, .30, .03, .70, .23, .72),
        ["guild-map-close"] = new("guild-map-close.png", 59d / 720, 57d / 720, .84, .04, .96, .23, .74),
        ["guild-map-body"] = new("guild-map-body.png", 790d / 720, 435d / 720, .40, .40, .61, .53, .82),
        ["guild-wish-entry"] = new("guild-wish-entry.png", 45d / 720, 42d / 720, .50, .27, .70, .50, .70),
        ["guild-shop-entry"] = new("guild-shop-entry.png", 43d / 720, 42d / 720, .40, .18, .61, .43, .70),
        ["guild-dungeon-entry"] = new("guild-dungeon-entry.png", 51d / 720, 47d / 720, .32, .48, .55, .76, .70),
        ["guild-return-entry"] = new("guild-return-entry.png", 32d / 720, 33d / 720, .57, .49, .78, .77, .70),
        ["advancement-close"] = new("advancement-close.png", 100d / 565, 35d / 565, .30, .53, .51, .75, .72),
        ["wish-panel-title"] = new("wish-panel-title.png", 127d / 720, 51d / 720, .40, .02, .62, .18, .72),
        ["wish-gold-button"] = new("wish-gold-button.png", 169d / 565, 34d / 565, .20, .69, .50, .90, .72),
        ["wish-confirm"] = new("wish-confirm.png", 55d / 565, 19d / 565, .38, .53, .64, .73, .68),
        ["shop-crystal-tab"] = new("shop-crystal-tab.png", 96d / 720, 40d / 720, .81, .30, .98, .56, .68),
        ["shop-free-button"] = new("shop-free-button.png", 161d / 565, 32d / 565, .07, .81, .42, .98, .70),
        ["shop-sold-out"] = new("shop-sold-out.png", 230d / 720, 50d / 720, .10, .85, .40, .98, .72),
        ["shop-confirm"] = new("shop-confirm.png", 43d / 565, 26d / 565, .49, .54, .68, .75, .70),
        ["dungeon-challenge"] = new("dungeon-challenge.png", 97d / 720, 23d / 720, .63, .76, .90, .94, .68)
    };

    static readonly ConcurrentDictionary<string, VisualTemplate> GuildTemplateCache = new();

    VisualMatch? GuildFind(Bitmap frame, string targetName)
    {
        var target = GuildTargets[targetName];
        var scales = targetName == "guild-map-body" ? new[] { 1d } : new[] { .9, 1d, 1.1 };
        VisualMatch? best = null;
        foreach (var scale in scales)
        {
            var key = $"{targetName}:{scale}";
            var template = GuildTemplateCache.GetOrAdd(key, _ => VisualTemplate.FromFile(
                Path.Combine(AppContext.BaseDirectory, "templates", "ui", "Guild", target.File),
                target.Width * scale, target.Height * scale));
            var match = template.FindAll(frame, target.Threshold, 40)
                .Where(candidate => candidate.Center.X >= frame.Width * target.Left &&
                    candidate.Center.X <= frame.Width * target.Right &&
                    candidate.Center.Y >= frame.Height * target.Top &&
                    candidate.Center.Y <= frame.Height * target.Bottom)
                .OrderByDescending(candidate => candidate.Score).FirstOrDefault();
            if (match is not null && (best is null || match.Score > best.Score)) best = match;
        }
        return best;
    }

    async Task<VisualMatch> GuildWaitTargetAsync(string targetName, CancellationToken token, int timeoutMs = 6000)
    {
        var timer = System.Diagnostics.Stopwatch.StartNew();
        while (timer.ElapsedMilliseconds < timeoutMs)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            if (GuildFind(frame, targetName) is { } match) return match;
            await Task.Delay(250, token);
        }
        throw new InvalidOperationException($"未识别到{targetName}，停止点击");
    }

    async Task GuildClickTargetAsync(string targetName, CancellationToken token, string? ocrFallback = null)
    {
        var timer = System.Diagnostics.Stopwatch.StartNew();
        while (timer.Elapsed < TimeSpan.FromSeconds(6))
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            var match = GuildFind(frame, targetName);
            if (match is not null)
            {
                Log($"公会定位点击：{targetName}，模板分数 {match.Score:F3}，位置 ({match.Center.X},{match.Center.Y})");
                await adb.TapScreen(match.Center.X / (double)frame.Width, match.Center.Y / (double)frame.Height);
                return;
            }
            if (ocrFallback is not null)
            {
                var spec = GuildTargets[targetName];
                var words = await adb.ReadOcrWordsAsync(frame, token);
                var textMatch = OcrTextLocator.Find(words, ocrFallback, word =>
                    word.Center.X >= frame.Width * spec.Left && word.Center.X <= frame.Width * spec.Right &&
                    word.Center.Y >= frame.Height * spec.Top && word.Center.Y <= frame.Height * spec.Bottom);
                if (textMatch is not null)
                {
                    Log($"公会定位点击：{targetName}，OCR={textMatch.Text}，位置 ({textMatch.Center.X},{textMatch.Center.Y})");
                    await adb.TapScreen(textMatch.Center.X / (double)frame.Width, textMatch.Center.Y / (double)frame.Height);
                    return;
                }
            }
            await Task.Delay(250, token);
        }
        throw new InvalidOperationException($"未定位到{targetName}，停止点击");
    }

    async Task GuildClickOutsideAsync(string panel, CancellationToken token, bool requireGone = true)
    {
        var anchorName = panel switch
        {
            "wish" => "wish-panel-title",
            "shop" => "shop-crystal-tab",
            "dungeon" => "dungeon-challenge",
            _ => throw new ArgumentOutOfRangeException(nameof(panel))
        };
        using (var frame = await adb.CaptureScreenForAutomationAsync(token))
        {
            var anchor = GuildFind(frame, anchorName)
                ?? throw new InvalidOperationException($"未定位到{panel}界面，不能计算面板外点击位置");
            var point = panel switch
            {
                "wish" => new Point(anchor.Center.X + (int)(frame.Width * .40), anchor.Center.Y + (int)(frame.Height * .40)),
                "shop" => new Point(anchor.Center.X + (int)(frame.Width * .055), anchor.Center.Y + (int)(frame.Height * .17)),
                _ => new Point(anchor.Center.X + (int)(frame.Width * .21), anchor.Center.Y - (int)(frame.Height * .32))
            };
            point.X = Math.Clamp(point.X, 3, frame.Width - 4);
            point.Y = Math.Clamp(point.Y, 3, frame.Height - 4);
            Log($"公会面板外点击：{panel}，依据{anchorName}定位到 ({point.X},{point.Y})");
            await adb.TapScreen(point.X / (double)frame.Width, point.Y / (double)frame.Height);
        }
        if (!requireGone) return;
        var timer = System.Diagnostics.Stopwatch.StartNew();
        while (timer.Elapsed < TimeSpan.FromSeconds(5))
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            if (GuildFind(frame, anchorName) is null) return;
            await Task.Delay(250, token);
        }
        throw new InvalidOperationException($"点击面板外后{panel}界面仍未关闭");
    }

    static Point GuildBossCenter(Bitmap frame, VisualMatch challenge, int boss)
        => new(challenge.Center.X - (int)(frame.Width * .61),
            challenge.Center.Y - (int)(frame.Height * (.63 - (boss - 1) * .125)));

    static int GuildBossHighlightScore(Bitmap frame, Point center)
    {
        var halfWidth = (int)(frame.Width * .031);
        var halfHeight = (int)(frame.Height * .056);
        var score = 0;
        for (var x = center.X - halfWidth; x <= center.X + halfWidth; x += 3)
        for (var y = center.Y - halfHeight; y <= center.Y + halfHeight; y += 3)
        {
            if (x < 0 || y < 0 || x >= frame.Width || y >= frame.Height) continue;
            if (Math.Abs(x - center.X) < halfWidth - 5 && Math.Abs(y - center.Y) < halfHeight - 5) continue;
            var color = frame.GetPixel(x, y);
            if (color.R > 130 && color.G > 65 && color.B < 105 && color.R > color.B * 1.7) score++;
        }
        return score;
    }

    async Task GuildSelectBossAsync(int boss, CancellationToken token)
    {
        using var frame = await adb.CaptureScreenForAutomationAsync(token);
        var challenge = GuildFind(frame, "dungeon-challenge")
            ?? throw new InvalidOperationException("未识别公会副本挑战按钮，无法定位 Boss 列");
        var center = GuildBossCenter(frame, challenge, boss);
        Log($"公会副本：根据面板定位选择第 {boss} 个 Boss ({center.X},{center.Y})");
        await adb.TapScreen(center.X / (double)frame.Width, center.Y / (double)frame.Height);
        var timer = System.Diagnostics.Stopwatch.StartNew();
        while (timer.Elapsed < TimeSpan.FromSeconds(3))
        {
            token.ThrowIfCancellationRequested();
            using var next = await adb.CaptureScreenForAutomationAsync(token);
            var selected = GuildBossHighlightScore(next, center);
            var others = Enumerable.Range(1, 5).Where(index => index != boss)
                .Select(index => GuildBossHighlightScore(next, GuildBossCenter(next, challenge, index))).Max();
            if (selected > others + 5) { Log($"公会副本：第 {boss} 个 Boss 高亮已确认"); return; }
            await Task.Delay(250, token);
        }
        throw new InvalidOperationException($"未确认第 {boss} 个 Boss 已被选中");
    }
}
