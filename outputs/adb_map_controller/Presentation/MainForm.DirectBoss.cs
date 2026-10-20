using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed partial class MainForm
{
    // 同一次商人地图访问只尝试一次。关闭弹窗后角色仍在地图上，不能反复交互。
    readonly HashSet<TargetKey> ignoredDirectBossTargets = [];

    static Rectangle DirectBossRegion(Bitmap frame, double left, double top, double right, double bottom)
        => Rectangle.FromLTRB((int)(frame.Width * left), (int)(frame.Height * top),
            (int)(frame.Width * right), (int)(frame.Height * bottom));

    static bool IsDirectBossTitle(string text)
    {
        var compact = Regex.Replace(text, @"\s+", "").ToUpperInvariant();
        return compact.Contains("挑战BOSS", StringComparison.Ordinal);
    }

    static int? DirectBossRemaining(string text)
    {
        var match = Regex.Match(text, @"(\d+)\s*[/／]\s*(\d+)");
        return match.Success && int.TryParse(match.Groups[1].Value, out var count) ? count : null;
    }

    async Task HandleDirectBossDialogAsync(TargetKey target, CancellationToken token)
    {
        popupHandling = true;
        try
        {
            for (var attempt = 0; attempt < 8; attempt++)
            {
                token.ThrowIfCancellationRequested();
                await Task.Delay(attempt == 0 ? 280 : 220, token);
                using var frame = await adb.CaptureScreenForAutomationAsync(token);
                using var title = frame.Clone(DirectBossRegion(frame, .40, .20, .61, .30), frame.PixelFormat);
                var titleText = string.Concat((await adb.ReadOcrWordsAsync(title, token)).Select(word => word.Text));
                if (!IsDirectBossTitle(titleText)) continue;

                using var countRegion = frame.Clone(DirectBossRegion(frame, .53, .625, .65, .68), frame.PixelFormat);
                var countText = string.Concat((await adb.ReadOcrWordsAsync(countRegion, token)).Select(word => word.Text));
                var remaining = DirectBossRemaining(countText);
                if (remaining is null)
                {
                    Log($"挑战Boss弹窗已识别，剩余次数尚未读清：{countText}");
                    continue;
                }

                ignoredDirectBossTargets.Add(target);
                if (remaining.Value > 0)
                {
                    await adb.TapScreenSecondary(.594, .708);
                    State($"直接挑战Boss：剩余 {remaining} 次，已确认传送");
                    Log($"挑战Boss弹窗：剩余次数 {countText}，已点击绿色确定按钮");
                    await Task.Delay(800, token);
                }
                else
                {
                    await adb.TapScreenSecondary(.417, .708);
                    State("直接挑战Boss次数不足，已关闭弹窗并继续跑图");
                    Log("挑战Boss弹窗：剩余次数为 0，已点击左侧关闭按钮");
                    await Task.Delay(180, token);
                }
                return;
            }
            throw new InvalidOperationException("直接挑战Boss弹窗未能同时识别标题和剩余次数，已停止自动操作以免误点");
        }
        finally { popupHandling = false; }
    }
}
