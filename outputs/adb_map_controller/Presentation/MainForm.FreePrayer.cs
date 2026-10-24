namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunFreePrayerAsync(CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        var running = false;
        try
        {
            var map = await adb.ReadMap();
            token.ThrowIfCancellationRequested();
            if (!MapRunTask.IsReturnDestination(map)) throw new InvalidOperationException("当前不在城镇");
            adb.Serial = devices.Text;
            popupHandling = true;
            Log("免费祈祷：任务开始");

            var prayer = new FreePrayerPipeline(adb, runtime.Paths.Pipeline("free-prayer-pipeline.json"), Log);
            var trace = new MaaPipelineTraceCollector();
            running = true;
            var result = await prayer.RunAsync(token, new MaaPipelineTraceMultiplexer([trace, pipelineWebServer]));
            trace.SaveJson(runtime.Paths.Trace($"free-prayer-{result.RunId}.json"));
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded)
                throw new InvalidOperationException(result.LastTask == "PrayerLimit"
                    ? "连续祈祷达到 20 次上限，未确认免费状态结束"
                    : result.Error ?? $"Pipeline 状态：{result.Status}");

            var count = trace.Events.Count(item => item.Kind == MaaPipelineTraceKind.NodeCompleted && item.TaskName == "FreePrayer");
            Log($"免费祈祷完成：执行 {count} 次");
            running = false;
            lastEntryRunSucceeded = true;
            State("免费祈祷完成：已无免费次数");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex)
        {
            Log($"免费祈祷：任务未完成，{ex.Message}", LogLevel.Error);
            State($"免费祈祷未完成：{ex.Message}");
        }
        finally
        {
            if (running)
                try { await adb.TapScreen(966d / 1004, 280d / 565); }
                catch (Exception ex) { Warn($"关闭神迹许愿失败：{ex.Message}"); }
            popupHandling = false;
        }
    }
}
