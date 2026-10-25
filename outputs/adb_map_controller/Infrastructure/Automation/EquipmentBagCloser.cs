using System.Drawing;

namespace AdbMapController;

internal static class EquipmentBagCloser
{
    public static async Task CloseAsync(IEquipmentSaleDevice device, Action<string> log, CancellationToken token)
    {
        for (var attempt = 1; attempt <= 3; attempt++)
        {
            using var source = await device.CaptureAsync(token);
            using var frame = EquipmentSaleVision.Normalize(source);
            var back = MainForm.FindEquipmentTemplate(frame, "back.png", new Rectangle(818, 0, 112, 60));
            if (back is null)
            {
                if (await BagButtonVisibleTwiceAsync(device, token)) return;
                await Task.Delay(300, token);
                continue;
            }

            log($"关闭背包：点击返回按钮 ({back.Value.X},{back.Value.Y})，第 {attempt} 次");
            await device.TapAsync(back.Value.X / 1004d, back.Value.Y / 565d);
            for (var check = 0; check < 10; check++)
            {
                await Task.Delay(300, token);
                if (await BagButtonVisibleTwiceAsync(device, token)) return;
            }
        }

        throw new InvalidOperationException("点击返回按钮后未确认背包关闭");
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
