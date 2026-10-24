using System.Drawing;

namespace AdbMapController;

internal static class BastanMapOpening
{
    public static bool IsOpen(Bitmap frame) =>
        BuiltInUiTemplateCatalog.FindBastanMapClose(frame) is not null &&
        BuiltInUiTemplateCatalog.IsBastanMapOpen(frame);

    public static async Task EnsureOpenAsync(AdbClient adb, Action<string> log, CancellationToken token)
    {
        async Task<bool> StableOpenAsync()
        {
            using (var first = await adb.CaptureScreenForAutomationAsync(token))
                if (!IsOpen(first)) return false;
            await Task.Delay(350, token);
            using var second = await adb.CaptureScreenForAutomationAsync(token);
            return IsOpen(second);
        }

        if (await StableOpenAsync()) return;
        for (var attempt = 1; attempt <= 3; attempt++)
        {
            var search = System.Diagnostics.Stopwatch.StartNew();
            var clicked = false;
            while (search.Elapsed < TimeSpan.FromSeconds(5))
            {
                token.ThrowIfCancellationRequested();
                if (await StableOpenAsync()) return;
                using var frame = await adb.CaptureScreenForAutomationAsync(token);
                var marker = BuiltInUiTemplateCatalog.FindMinimapPlayer(frame);
                if (marker is { Score: >= .55 })
                {
                    log($"巴萨坦地图：第 {attempt} 次点击小地图 ({marker.Center.X},{marker.Center.Y})，分数 {marker.Score:F3}");
                    await adb.TapScreen(marker.Center.X / (double)frame.Width, marker.Center.Y / (double)frame.Height);
                    clicked = true;
                    break;
                }
                await Task.Delay(250, token);
            }
            if (!clicked) continue;
            var wait = System.Diagnostics.Stopwatch.StartNew();
            while (wait.Elapsed < TimeSpan.FromSeconds(attempt == 3 ? 8 : 3))
            {
                token.ThrowIfCancellationRequested();
                if (await StableOpenAsync()) { log("巴萨坦地图：已二次确认打开"); return; }
                await Task.Delay(250, token);
            }
            log($"巴萨坦地图：第 {attempt} 次点击后未打开，重新定位小地图");
        }
        throw new InvalidOperationException("未能确认巴萨坦地图打开");
    }
}
