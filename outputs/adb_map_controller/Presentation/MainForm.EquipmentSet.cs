using System.Drawing;
using System.Drawing.Imaging;
using OpenCvSharp;
using DrawingPoint = System.Drawing.Point;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task TrySwitchTaskEquipmentAsync(int set, CancellationToken token)
    {
        var bagOpen = false;
        try
        {
            var map = await adb.ReadMap();
            token.ThrowIfCancellationRequested();
            if (!MapRunTask.IsReturnDestination(map))
            {
                Warn("装备方案切换跳过：当前不在城镇");
                return;
            }
            adb.Serial = devices.Text;
            popupHandling = true;
            if (!await OpenEquipmentBagAsync(token)) throw new InvalidOperationException("未能打开背包");
            bagOpen = true;
            using (var frame = await CaptureEquipmentFrameAsync(token))
            {
                var count = await EquipmentSalePipeline.ReadInventoryCountAsync(frame, adb.ReadOcrWordsAsync, token);
                if (count is null) throw new InvalidOperationException("未能识别背包容量");
                var parts = count.Split('/');
                var free = int.Parse(parts[1]) - int.Parse(parts[0]);
                Log($"背包容量 {count}，剩余 {free} 格");
                if (free < 9)
                {
                    await EquipmentBagCloser.CloseAsync(new AdbEquipmentSaleDevice(adb), Log, CancellationToken.None);
                    bagOpen = false;
                    popupHandling = false;
                    Log("背包不足 9 格，先出售装备");
                    if (!await RunEquipmentSaleAsync(token)) Warn("装备出售未完成，仍尝试切换装备方案");
                    popupHandling = true;
                    if (!await OpenEquipmentBagAsync(token)) throw new InvalidOperationException("出售后未能打开背包");
                    bagOpen = true;
                }
            }
            await SelectEquipmentTabAsync(token);
            set = Math.Clamp(set, 1, 3);
            await adb.TapScreen((set == 1 ? 222d : set == 2 ? 287d : 353d) / 1004, 422d / 565);
            var confirmVisible = false;
            for (var check = 0; check < 6; check++)
            {
                await Task.Delay(check == 0 ? 450 : 300, token);
                using var dialog = await CaptureEquipmentFrameAsync(token);
                if (!IsEquipmentSwitchConfirmVisible(dialog)) continue;
                confirmVisible = true;
                break;
            }
            if (!confirmVisible) throw new InvalidOperationException("重试 6 次仍未检测到切换装备确认弹窗");
            await adb.TapScreen(592d / 1004, 361d / 565);
            await ConfirmEquipmentSwitchDialogClosedAsync(token);
            Log($"已确认切换装备方案{set}");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex) { Warn($"装备方案切换未完成：{ex.Message}，继续执行任务"); }
        finally
        {
            popupHandling = false;
            if (bagOpen) await EquipmentBagCloser.CloseAsync(new AdbEquipmentSaleDevice(adb), Log, CancellationToken.None);
        }
    }

    async Task SelectEquipmentTabAsync(CancellationToken token)
    {
        var tabArea = new Rectangle(602, 505, 64, 50);
        for (var attempt = 0; attempt < 4; attempt++)
        {
            using var frame = await CaptureEquipmentFrameAsync(token);
            if (HasEquipmentTemplate(frame, "equipment_tab_active.png", tabArea)) return;
            var idle = FindEquipmentTemplate(frame, "equipment_tab_idle.png", tabArea);
            if (idle is null) throw new InvalidOperationException("未识别到装备页签");
            Log($"切换到装备页签：第 {attempt + 1} 次");
            await adb.TapScreen(idle.Value.X / 1004d, idle.Value.Y / 565d);
            await Task.Delay(450, token);
        }
        using var finalFrame = await CaptureEquipmentFrameAsync(token);
        if (!HasEquipmentTemplate(finalFrame, "equipment_tab_active.png", tabArea))
            throw new InvalidOperationException("装备页签切换未确认");
    }

    async Task ConfirmEquipmentSwitchDialogClosedAsync(CancellationToken token)
    {
        var missingChecks = 0;
        for (var check = 0; check < 10; check++)
        {
            await Task.Delay(1000, token);
            using var frame = await CaptureEquipmentFrameAsync(token);
            var decision = EquipmentSwitchConfirmationPolicy.Decide(
                IsEquipmentSwitchConfirmVisible(frame), missingChecks);
            missingChecks = decision.MissingChecks;

            if (decision.Action == EquipmentSwitchConfirmationAction.Completed)
                return;
            if (decision.Action == EquipmentSwitchConfirmationAction.RetryTap)
            {
                Log("切换装备确认弹窗仍在，重试确认");
                await adb.TapScreen(592d / 1004, 361d / 565);
            }
        }

        throw new InvalidOperationException("切换装备确认弹窗未连续两次消失");
    }

    async Task<bool> OpenEquipmentBagAsync(CancellationToken token)
    {
        for (var attempt = 0; attempt < 3; attempt++)
        {
            DrawingPoint? button = null;
            for (var check = 0; check < 10; check++)
            {
                using var frame = await CaptureEquipmentFrameAsync(token);
                if (await IsEquipmentBagOpenAsync(frame, token)) return true;
                button = FindEquipmentTemplate(frame, "bag.png", new Rectangle(885, 455, 119, 110));
                if (button is not null) break;
                await Task.Delay(300, token);
            }
            if (button is null) return false;
            Log($"打开背包：点击按钮 ({button.Value.X},{button.Value.Y})，第 {attempt + 1} 次");
            await adb.TapScreen(button.Value.X / 1004d, button.Value.Y / 565d);
            // 一次点击后等待页面稳定，不能在切换动画期间再次点击同一个按钮。
            for (var check = 0; check < 10; check++)
            {
                await Task.Delay(300, token);
                using var frame = await CaptureEquipmentFrameAsync(token);
                if (await IsEquipmentBagOpenAsync(frame, token)) return true;
            }
        }
        return false;
    }

    async Task<bool> IsEquipmentBagOpenAsync(Bitmap frame, CancellationToken token)
    {
        var active = HasEquipmentTemplate(frame, "equipment_tab_active.png", new Rectangle(602, 505, 64, 50));
        var idle = HasEquipmentTemplate(frame, "equipment_tab_idle.png", new Rectangle(602, 505, 64, 50));
        if (!active && !idle) return false;
        if (HasEquipmentTemplate(frame, "role_title.png", new Rectangle(90, 3, 150, 45))) return true;
        using var title = frame.Clone(new Rectangle(90, 4, 150, 43), PixelFormat.Format24bppRgb);
        var words = await adb.ReadOcrWordsAsync(title, token);
        if (words.Any(word => OcrTextLocator.Compact(word.Text).Contains("角色"))) return true;
        return await EquipmentSalePipeline.ReadInventoryCountAsync(frame, adb.ReadOcrWordsAsync, token) is not null;
    }

    async Task<Bitmap> CaptureEquipmentFrameAsync(CancellationToken token)
    {
        using var source = await adb.CaptureScreenForAutomationAsync(token);
        return EquipmentSaleVision.Normalize(source);
    }

    internal static bool IsEquipmentSwitchConfirmVisible(Bitmap frame)
    {
        if (frame.Width != 1004 || frame.Height != 565) return false;
        static bool Panel(Color color) => color.R is >= 140 and <= 230 &&
            Math.Abs(color.R - color.G) <= 35 && Math.Abs(color.G - color.B) <= 35;
        static bool Green(Color color) => color.G >= color.R + 45 && color.G >= color.B + 25;
        return Panel(frame.GetPixel(350, 200)) && Panel(frame.GetPixel(500, 320)) &&
            Green(frame.GetPixel(550, 355)) && Green(frame.GetPixel(620, 355)) &&
            frame.GetPixel(500, 120).GetBrightness() < .35;
    }

    internal static bool HasEquipmentTemplate(Bitmap frame, string name, Rectangle roi)
        => FindEquipmentTemplate(frame, name, roi) is not null;

    internal static DrawingPoint? FindEquipmentTemplate(Bitmap frame, string name, Rectangle roi)
    {
        using var crop = frame.Clone(roi, PixelFormat.Format24bppRgb);
        using var bytes = new MemoryStream();
        crop.Save(bytes, ImageFormat.Png);
        using var image = Cv2.ImDecode(bytes.ToArray(), ImreadModes.Color);
        using var template = Cv2.ImRead(Path.Combine(AppContext.BaseDirectory, "templates", "ui", "EquipmentSale", name), ImreadModes.Color);
        if (template.Empty() || template.Width > image.Width || template.Height > image.Height) return null;
        using var result = new Mat();
        Cv2.MatchTemplate(image, template, result, TemplateMatchModes.SqDiffNormed);
        Cv2.MinMaxLoc(result, out double difference, out double _, out OpenCvSharp.Point location, out _);
        return 1 - difference >= .92
            ? new DrawingPoint(roi.X + location.X + template.Width / 2, roi.Y + location.Y + template.Height / 2)
            : null;
    }
}
