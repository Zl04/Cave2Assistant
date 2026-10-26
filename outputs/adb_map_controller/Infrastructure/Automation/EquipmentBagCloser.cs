using System.Drawing;

namespace AdbMapController;

internal static class EquipmentBagCloser
{
    public static async Task CloseAsync(IEquipmentSaleDevice device, Action<string> log, CancellationToken token)
    {
        // 确认弹窗消失后，背包页面的遮罩/切换动画还可能持续一段时间。
        // 先等待返回按钮稳定出现，再开始计算实际点击重试次数。
        var backWaits = 0;
        for (var attempt = 1; attempt <= 3; attempt++)
        {
            System.Drawing.Point? back = null;
            for (var check = 0; check < 15; check++)
            {
                using var source = await device.CaptureAsync(token);
                using var frame = EquipmentSaleVision.Normalize(source);
                back = MainForm.FindEquipmentTemplate(frame, "back.png", new Rectangle(818, 0, 112, 60));
                if (back is not null) break;
                if (await BagButtonVisibleTwiceAsync(device, token)) return;
                backWaits++;
                await Task.Delay(300, token);
            }
            if (back is null) break;

            if (backWaits > 0) log($"关闭背包：等待返回按钮出现，检查 {backWaits} 次");
            log($"关闭背包：点击返回按钮 ({back.Value.X},{back.Value.Y})，第 {attempt} 次");
            await device.TapAsync(back.Value.X / 1004d, back.Value.Y / 565d);
            for (var check = 0; check < 10; check++)
            {
                await Task.Delay(300, token);
                if (await BagButtonVisibleTwiceAsync(device, token)) return;
            }
        }

        var error = backWaits > 0
            ? $"未确认背包关闭：返回按钮有 {backWaits} 次检查未识别"
            : "点击返回按钮后未确认背包关闭";
        try
        {
            using var source = await device.CaptureAsync(token);
            var fileName = PipelineEvidenceStore.Save(source, "bag-close-failed", 0, log);
            if (fileName is not null)
            {
                var path = Path.Combine(AppContext.BaseDirectory, "pipeline-traces", "evidence", fileName);
                log($"关闭背包失败截图已保存：{path}");
                error += $"；截图：{path}";
            }
        }
        catch (Exception ex) when (ex is not OperationCanceledException)
        {
            log($"关闭背包失败截图未能获取：{ex.Message}");
        }
        throw new InvalidOperationException(error);
    }

    static async Task<bool> BagButtonVisibleTwiceAsync(IEquipmentSaleDevice device, CancellationToken token)
    {
        for (var check = 0; check < 2; check++)
        {
            using var source = await device.CaptureAsync(token);
            using var frame = EquipmentSaleVision.Normalize(source);
            if (MainForm.FindEquipmentTemplate(frame, "bag.png", new Rectangle(885, 455, 119, 110)) is null ||
                MainForm.FindEquipmentTemplate(frame, "back.png", new Rectangle(818, 0, 112, 60)) is not null)
                return false;
            if (check == 0) await Task.Delay(300, token);
        }
        return true;
    }
}
