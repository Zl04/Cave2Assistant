using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunAbyssKeyAsync(CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        var panelOpen = false;
        try
        {
            var map = await adb.ReadMap();
            token.ThrowIfCancellationRequested();
            if (!MapRunTask.IsReturnDestination(map)) throw new InvalidOperationException("当前不在城镇");
            adb.Serial = devices.Text;
            popupHandling = true;
            Log("深渊钥匙：开始执行领取任务");

            var path = Path.Combine(AppContext.BaseDirectory, "pipelines", "abyss-key-pipeline.json");
            var catalog = MaaPipelineCatalogLoader.Load(path);
            var handler = new DelegateMaaPipelineHandler<MainForm>(
                "AbyssKey",
                async (task, _, ct) =>
                {
                    using var frame = await CaptureEquipmentFrameAsync(ct);
                    switch (task.Name)
                    {
                        case "确认商店已打开":
                        {
                            var tabs = await ReadAbyssAreaAsync(frame, new Rectangle(95, 0, 430, 55), ct);
                            if (!tabs.Contains("宝箱", StringComparison.Ordinal)) return MaaPipelineRecognitionResult.Miss($"商店页签未出现：{tabs}");
                            panelOpen = true;
                            return MaaPipelineRecognitionResult.Hit(detail: "商店页签已出现");
                        }
                        case "确认宝箱页签":
                            return IsAbyssChestTabSelected(frame)
                                ? MaaPipelineRecognitionResult.Hit(detail: "宝箱页签已选中")
                                : MaaPipelineRecognitionResult.Miss("宝箱页签尚未选中");
                        case "礼包已售罄":
                        case "礼包可领取":
                        {
                            var card = await ReadAbyssAreaAsync(frame, new Rectangle(510, 245, 190, 270), ct);
                            if (!card.Contains("深渊钥匙", StringComparison.Ordinal)) return MaaPipelineRecognitionResult.Miss($"未找到礼包：{card}");
                            var sold = card.Contains("已售罄", StringComparison.Ordinal);
                            if (task.Name == "礼包已售罄")
                                return sold ? MaaPipelineRecognitionResult.Hit(text: card) : MaaPipelineRecognitionResult.Miss("礼包仍可领取");
                            return !sold && card.Contains("每日限购", StringComparison.Ordinal) && card.Contains("1", StringComparison.Ordinal)
                                ? MaaPipelineRecognitionResult.Hit(text: card)
                                : MaaPipelineRecognitionResult.Miss($"未确认可领取的限购礼包：{card}");
                        }
                        case "确认礼包弹窗":
                        {
                            var title = await ReadAbyssAreaAsync(frame, new Rectangle(500, 50, 265, 65), ct);
                            var limit = await ReadAbyssAreaAsync(frame, new Rectangle(650, 105, 105, 35), ct);
                            return title.Contains("深渊钥匙", StringComparison.Ordinal) && limit.Contains("每日限购", StringComparison.Ordinal)
                                ? MaaPipelineRecognitionResult.Hit(detail: "礼包和限购状态已确认")
                                : MaaPipelineRecognitionResult.Miss($"礼包弹窗未就绪：{title} {limit}");
                        }
                        case "确认宝物获得":
                        {
                            var title = await ReadAbyssAreaAsync(frame, new Rectangle(360, 185, 280, 55), ct);
                            return title.Contains("宝物获得", StringComparison.Ordinal)
                                ? MaaPipelineRecognitionResult.Hit(detail: "宝物获得弹窗已出现")
                                : MaaPipelineRecognitionResult.Miss($"奖励弹窗未就绪：{title}");
                        }
                        default:
                            return MaaPipelineRecognitionResult.Hit();
                    }
                },
                (task, _, _, _) => Task.FromResult(task.Name switch
                {
                    "宝箱页签切换失败" => MaaPipelineActionResult.Failure("宝箱页签多次点击后仍未选中"),
                    "深渊钥匙礼包未找到" => MaaPipelineActionResult.Failure("宝箱页未找到深渊钥匙礼包"),
                    _ => MaaPipelineActionResult.Success()
                }));
            var progress = new DelegateMaaPipelineTraceSink(value =>
            {
                if (value.Kind != MaaPipelineTraceKind.NodeCompleted) return;
                var message = value.TaskName switch
                {
                    "打开商店" => "已点击商店入口，等待界面打开",
                    "确认商店已打开" => "商店界面已打开，等待动画结束",
                    "点击宝箱页签" => "已点击宝箱页签，等待切换",
                    "确认宝箱页签" => "已切换到宝箱页签",
                    "向下查找礼包" => "向下滑动查找深渊钥匙礼包",
                    "礼包已售罄" => "深渊钥匙今日已售罄，跳过领取",
                    "礼包可领取" => "找到可领取的深渊钥匙礼包",
                    "确认礼包弹窗" => "已确认深渊钥匙礼包和每日限购状态",
                    "领取礼包" => "已点击领取，等待奖励弹窗",
                    "确认宝物获得" => "已确认宝物获得弹窗",
                    "确定宝物获得" => "已确定宝物获得，领取成功",
                    "关闭商店" => "已关闭商店界面",
                    _ => null
                };
                if (message is not null) Log($"深渊钥匙：{message}");
            });
            var pipeline = new MaaPipeline<MainForm>(catalog,
                [handler, new MaaAdbPipelineHandler<MainForm>("MaaAdb", _ => new MaaAdbPipelineState(adb, AppContext.BaseDirectory, Log))],
                new MaaPipelineExecutionOptions { TaskChain = "领取深渊钥匙", RetryTimes = 0, RetryInterval = TimeSpan.Zero },
                new MaaPipelineTraceMultiplexer([progress, pipelineWebServer]));
            var result = await pipeline.RunAsync(this, ["打开商店"], token);
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded) throw new InvalidOperationException($"Pipeline 未完成，最后完成节点 {result.LastTask ?? "未知"}：{result.Error ?? result.Status.ToString()}");
            panelOpen = false;
            lastEntryRunSucceeded = true;
            State("领取深渊钥匙任务完成");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { Log("深渊钥匙：任务已取消"); throw; }
        catch (Exception ex) { Warn($"深渊钥匙：任务未完成，{ex.Message}"); State($"领取深渊钥匙未完成：{ex.Message}"); }
        finally
        {
            if (panelOpen)
                try { await adb.TapScreen(865d / 1004, 19d / 565); }
                catch (Exception ex) { Warn($"关闭宝箱界面失败：{ex.Message}"); }
            popupHandling = false;
        }
    }

    async Task<string> ReadAbyssAreaAsync(Bitmap frame, Rectangle area, CancellationToken token)
    {
        using var crop = frame.Clone(area, PixelFormat.Format24bppRgb);
        return string.Concat((await adb.ReadOcrWordsAsync(crop, token)).Select(word => OcrTextLocator.Compact(word.Text)));
    }

    static bool IsAbyssChestTabSelected(Bitmap frame)
    {
        var redPixels = 0;
        for (var x = 370; x < 525; x += 2)
        for (var y = 5; y < 50; y += 2)
        {
            var color = frame.GetPixel(x, y);
            if (color.R > 90 && color.R > color.G * 1.5 && color.R > color.B * 1.5)
                redPixels++;
        }
        return redPixels > 30;
    }
}
