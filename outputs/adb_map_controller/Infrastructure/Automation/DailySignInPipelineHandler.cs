using System.Drawing;
using System.Drawing.Imaging;
using System.Text.RegularExpressions;
using OpenCvSharp;

namespace AdbMapController;

internal static class DailySignInHighlightDetector
{
    internal readonly record struct Hit(int Row, int Column, int Pixels, MaaRect Box);

    // The grid coordinates use the same 1280x720 design space as the Pipeline.
    static readonly int[] Columns = [246, 360, 475, 590, 705, 820, 934];
    static readonly int[] Rows = [118, 229, 340, 450];

    internal static Hit? Find(Bitmap frame)
    {
        using var source = OpenCvImage.ToMat(frame);
        using var scaled = new Mat();
        Cv2.Resize(source, scaled, new OpenCvSharp.Size(1280, 720));
        using var hsv = new Mat();
        using var mask = new Mat();
        Cv2.CvtColor(scaled, hsv, ColorConversionCodes.BGR2HSV);
        Cv2.InRange(hsv, new Scalar(27, 100, 220), new Scalar(30, 145, 255), mask);

        Hit? best = null;
        var runnerUp = 0;
        for (var row = 0; row < Rows.Length; row++)
        for (var column = 0; column < Columns.Length; column++)
        {
            var rect = new OpenCvSharp.Rect(Columns[column], Rows[row], 102, 103);
            using var cell = new Mat(mask, rect);
            var count = Cv2.CountNonZero(cell);
            if (best is null || count > best.Value.Pixels)
            {
                runnerUp = best?.Pixels ?? 0;
                best = new Hit(row + 1, column + 1, count,
                    new MaaRect(rect.X, rect.Y, rect.Width, rect.Height));
            }
            else runnerUp = Math.Max(runnerUp, count);
        }

        // A lit border contains hundreds of matching pixels at design size;
        // the ordinary reward icons in the supplied frames contain almost none.
        return best is { Pixels: >= 120 } candidate && candidate.Pixels >= runnerUp * 3
            ? candidate
            : null;
    }
}

internal static class DailySignInCumulativeDetector
{
    internal readonly record struct Hit(int Day, double CheckScore, MaaRect Box);
    static readonly (int Day, int X)[] Milestones = [(7, 434), (14, 617), (21, 800), (28, 987)];

    internal static Hit? Find(Bitmap frame, int signedDays, IReadOnlySet<int> attempted, string templatePath,
        Action<string>? log)
    {
        using var source = OpenCvImage.ToMat(frame);
        using var scaled = new Mat();
        using var check = Cv2.ImRead(templatePath, ImreadModes.Color);
        if (check.Empty()) throw new FileNotFoundException("累计奖励勾选模板无法读取", templatePath);
        Cv2.Resize(source, scaled, new OpenCvSharp.Size(1280, 720));
        foreach (var (day, x) in Milestones)
        {
            if (day > signedDays || attempted.Contains(day)) continue;
            // The check overlaps the upper-right edge of each milestone icon.
            var checkCenter = x + 19;
            using var roi = new Mat(scaled, new OpenCvSharp.Rect(checkCenter - 45, 575, 90, 75));
            using var result = new Mat();
            Cv2.MatchTemplate(roi, check, result, TemplateMatchModes.CCoeffNormed);
            Cv2.MinMaxLoc(result, out _, out var score, out _, out _);
            log?.Invoke($"每日签到：累计 {day} 天奖励的已领取勾选识图得分 {score:F3}");
            if (score < .8)
                return new Hit(day, score, new MaaRect(x - 30, 600, 60, 60));
        }
        return null;
    }
}

internal sealed class DailySignInPipelineHandler(MaaAdbPipelineState state) : IMaaPipelineHandler<MaaAdbPipelineState>
{
    readonly HashSet<int> attemptedMilestones = [];
    int? pendingMilestone;
    public string Name => "SignInCustom";

    public async Task<MaaPipelineRecognitionResult> RecognizeAsync(
        MaaPipelineTask task, MaaPipelineTaskContext<MaaAdbPipelineState> context, CancellationToken token)
    {
        if (task.Name == "FindClaimableReward")
        {
            using var frame = await state.Adb.CaptureScreenForAutomationAsync(token);
            var match = DailySignInHighlightDetector.Find(frame);
            if (match is null) return MaaPipelineRecognitionResult.Miss("本帧未见窄 HSV 高亮框");
            state.Log?.Invoke($"每日签到：检测到第 {match.Value.Row} 排第 {match.Value.Column} 格，黄色像素 {match.Value.Pixels}");
            return MaaPipelineRecognitionResult.Hit(box: match.Value.Box,
                detail: $"第 {match.Value.Row} 排第 {match.Value.Column} 格，黄色像素 {match.Value.Pixels}");
        }

        if (task.Name == "CheckCumulativeReward")
        {
            var first = await ReadSignedDaysAsync(token);
            await Task.Delay(200, token);
            var second = await ReadSignedDaysAsync(token);
            if (first is null || second is null || first != second)
                throw new InvalidOperationException($"累计签到天数 OCR 二次确认失败：{first?.ToString() ?? "?"} / {second?.ToString() ?? "?"}");
            state.Log?.Invoke($"每日签到：累计签到天数 OCR 二次确认 {first} 天");
            using var frame = await state.Adb.CaptureScreenForAutomationAsync(token);
            var templatePath = Path.Combine(state.ResourceRoot, "templates", "ui", "sign-in-claimed-check.png");
            var match = DailySignInCumulativeDetector.Find(frame, first.Value, attemptedMilestones,
                templatePath, state.Log);
            if (match is null) return MaaPipelineRecognitionResult.Miss($"累计 {first} 天，无可领取的阶段奖励");
            pendingMilestone = match.Value.Day;
            state.Log?.Invoke($"每日签到：累计 {match.Value.Day} 天奖励可领取，准备点击");
            return MaaPipelineRecognitionResult.Hit(box: match.Value.Box,
                detail: $"累计 {match.Value.Day} 天奖励未见已领取勾选");
        }

        if (task.Name == "ConfirmCumulativeDayLabel")
        {
            if (pendingMilestone is not { } day)
                throw new InvalidOperationException("累计奖励档位未确定，不能核对下方天数");
            var x = day switch { 7 => 434, 14 => 617, 21 => 800, 28 => 987, _ => throw new InvalidOperationException($"未知奖励档位：{day}") };
            var first = await ReadMilestoneLabelAsync(x, token);
            await Task.Delay(200, token);
            var second = await ReadMilestoneLabelAsync(x, token);
            if (first != day || second != day)
                throw new InvalidOperationException($"累计奖励下方天数 OCR 二次确认失败：预期 {day} 天，识别 {first?.ToString() ?? "?"} / {second?.ToString() ?? "?"}");
            state.Log?.Invoke($"每日签到：奖励下方“{day}天”OCR 二次确认通过");
            return MaaPipelineRecognitionResult.Hit(box: new MaaRect(x - 30, 600, 60, 60),
                detail: $"奖励下方“{day}天”二次确认通过");
        }

        var isRewardDialog = task.Name is "VerifyDialogClosed" or "VerifyCumulativeDialogClosed";
        if (!isRewardDialog && task.Name != "VerifySignInClosed")
            throw new InvalidOperationException($"未知签到识别节点：{task.Name}");
        var title = isRewardDialog ? "宝物获得" : "签到";
        var visionTask = isRewardDialog
            ? new VisionTask
            {
                Name = task.Name,
                Algorithm = VisionAlgorithm.MatchTemplate,
                TemplatePath = Path.Combine(state.ResourceRoot, "templates", "ui", "sign-in-reward-title.png"),
                TemplateThreshold = .8,
                Roi = new Rectangle(550, 220, 200, 90)
            }
            : new VisionTask
            {
                Name = task.Name,
                Algorithm = VisionAlgorithm.OcrDetect,
                Text = [title],
                Roi = new Rectangle(430, 0, 420, 100)
            };
        for (var i = 0; i < 2; i++)
        {
            using var frame = await state.Adb.CaptureScreenForAutomationAsync(token);
            var result = await state.Vision.RecognizeAsync(visionTask, frame, token: token);
            if (result.Hit) return MaaPipelineRecognitionResult.Miss($"仍可见“{title}”，等待界面关闭");
            if (i == 0) await Task.Delay(200, token);
        }
        state.Log?.Invoke($"每日签到：连续两帧未见“{title}”，已确认关闭");
        return MaaPipelineRecognitionResult.Hit(detail: $"连续两帧未见“{title}”");
    }

    async Task<int?> ReadSignedDaysAsync(CancellationToken token)
    {
        using var frame = await state.Adb.CaptureScreenForAutomationAsync(token);
        var roi = VisionPipeline.ScaleRoi(new Rectangle(185, 585, 110, 80), frame.Size);
        using var crop = frame.Clone(roi, PixelFormat.Format24bppRgb);
        var words = await state.Adb.ReadOcrWordsAsync(crop, token);
        var text = string.Concat(words.OrderBy(word => word.Left).Select(word => word.Text));
        var found = Regex.Match(text, @"(?<!\d)\d{1,2}(?!\d)");
        if (!found.Success || !int.TryParse(found.Value, out var days) || days is < 0 or > 31)
        {
            state.Log?.Invoke($"每日签到：累计天数 OCR 未能解析，结果“{text}”");
            return null;
        }
        return days;
    }

    async Task<int?> ReadMilestoneLabelAsync(int x, CancellationToken token)
    {
        using var frame = await state.Adb.CaptureScreenForAutomationAsync(token);
        var roi = VisionPipeline.ScaleRoi(new Rectangle(x - 45, 666, 90, 40), frame.Size);
        using var crop = frame.Clone(roi, PixelFormat.Format24bppRgb);
        var words = await state.Adb.ReadOcrWordsAsync(crop, token);
        var text = string.Concat(words.OrderBy(word => word.Left).Select(word => word.Text));
        var found = Regex.Match(text, @"(?<!\d)(\d{1,2})\s*天(?!\d)");
        if (found.Success && int.TryParse(found.Groups[1].Value, out var day)) return day;
        state.Log?.Invoke($"每日签到：奖励下方天数 OCR 未能解析，结果“{text}”");
        return null;
    }

    public async Task<MaaPipelineActionResult> ExecuteAsync(
        MaaPipelineTask task, MaaPipelineRecognitionResult recognition,
        MaaPipelineTaskContext<MaaAdbPipelineState> context, CancellationToken token)
    {
        if (task.Name is not ("FindClaimableReward" or "ConfirmCumulativeDayLabel"))
            return MaaPipelineActionResult.Success();
        if (recognition.Box is not { } box) return MaaPipelineActionResult.Failure("签到高亮框缺少位置");
        token.ThrowIfCancellationRequested();
        await state.Adb.TapScreen((box.X + box.Width / 2d) / 1280d,
            (box.Y + box.Height / 2d) / 720d);
        if (task.Name == "ConfirmCumulativeDayLabel" && pendingMilestone is { } day)
        {
            attemptedMilestones.Add(day);
            state.Log?.Invoke($"每日签到：已点击累计 {day} 天奖励");
            pendingMilestone = null;
        }
        else state.Log?.Invoke($"每日签到：已点击奖励格中心 ({box.X + box.Width / 2}, {box.Y + box.Height / 2})");
        return MaaPipelineActionResult.Success();
    }
}
