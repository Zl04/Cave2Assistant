using System.Drawing;
using System.Drawing.Imaging;
using System.Text.RegularExpressions;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunSoulArtifactCultivationAsync(CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        var bagOpen = false;
        try
        {
            var map = await adb.ReadMap();
            token.ThrowIfCancellationRequested();
            if (!MapRunTask.IsReturnDestination(map)) throw new InvalidOperationException("当前不在城镇");
            adb.Serial = devices.Text;
            popupHandling = true;
            if (!await OpenEquipmentBagAsync(token)) throw new InvalidOperationException("未能打开背包");
            bagOpen = true;

            await adb.TapScreen(592d / 1004, 25d / 565);
            await Task.Delay(550, token);
            var previous = -1;
            for (var click = 0; click <= 20; click++)
            {
                token.ThrowIfCancellationRequested();
                using var frame = await CaptureEquipmentFrameAsync(token);
                var progress = await ReadSoulCultivationProgressAsync(frame, token);
                if (progress is null) throw new InvalidOperationException("未识别到魂器页的普通培养次数");
                var (used, limit) = progress.Value;
                if (used >= limit)
                {
                    Log($"魂器普通培养次数已耗尽：{used}/{limit}");
                    await adb.TapScreen(872d / 1004, 25d / 565);
                    for (var check = 0; check < 5; check++)
                    {
                        await Task.Delay(300, token);
                        using var closedFrame = await CaptureEquipmentFrameAsync(token);
                        if (HasEquipmentTemplate(closedFrame, "bag.png", new Rectangle(885, 455, 119, 110)))
                        {
                            bagOpen = false;
                            break;
                        }
                    }
                    if (bagOpen) throw new InvalidOperationException("未确认背包已关闭");
                    lastEntryRunSucceeded = true;
                    State("培养魂器完成：次数已耗尽，已关闭背包");
                    return;
                }
                if (click == 20 || (previous >= 0 && used <= previous))
                    throw new InvalidOperationException($"普通培养次数未按预期增加：{used}/{limit}");
                previous = used;
                await adb.TapScreen(212d / 1004, 517d / 565);
                Log($"魂器普通培养：点击第 {click + 1} 次，当前 {used}/{limit}");
                await Task.Delay(650, token);
            }
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex) { State($"培养魂器未完成：{ex.Message}"); }
        finally
        {
            if (bagOpen)
                try { await adb.TapScreen(872d / 1004, 25d / 565); }
                catch (Exception ex) { Warn($"关闭背包失败：{ex.Message}"); }
            popupHandling = false;
        }
    }

    async Task<(int Used, int Limit)?> ReadSoulCultivationProgressAsync(Bitmap frame, CancellationToken token)
    {
        // 截图中的普通培养计数位于左下角，形如“普通培养 (0/20)”。
        using var region = frame.Clone(new Rectangle(142, 466, 170, 39), PixelFormat.Format24bppRgb);
        var words = await adb.ReadOcrWordsAsync(region, token);
        var text = string.Concat(words.OrderBy(word => word.Left).Select(word => word.Text));
        var match = Regex.Match(text, @"(\d{1,2})\s*[/／]\s*(\d{1,2})");
        if (!match.Success || !int.TryParse(match.Groups[1].Value, out var used) ||
            !int.TryParse(match.Groups[2].Value, out var limit) || limit is < 1 or > 20 || used > limit)
            return null;
        return (used, limit);
    }
}
