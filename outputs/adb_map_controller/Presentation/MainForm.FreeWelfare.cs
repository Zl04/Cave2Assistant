namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunFreeWelfareAsync(CancellationToken token)
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
            Log("福利活动：任务开始");

            var catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("free-welfare-pipeline.json"));
            var state = new MaaAdbPipelineState(adb, log: Log);
            var trace = new MaaPipelineTraceCollector();
            var operationLog = new DelegateMaaPipelineTraceSink(value =>
            {
                if (value.Kind == MaaPipelineTraceKind.NodeCompleted)
                {
                    switch (value.TaskName)
                    {
                        case "OpenWelfare": Log("福利活动：已点击活动入口"); break;
                        case "WelfareTitle": Log("福利活动：已确认活动界面"); break;
                        case "OpenValueTab": Log($"福利活动：第 {value.ExecutionCount} 次点击超值礼包页签"); break;
                        case "ValueTabReady": Log("福利活动：已确认超值礼包页签打开"); break;
                        case "ClaimFreeGift": Log($"福利活动：已点击第 {value.ExecutionCount} 个免费礼包"); break;
                        case "ConfirmFreeReward": Log("福利活动：已点击免费礼包奖励弹窗的确定按钮"); break;
                        case "OpenPrivilegeTab": Log($"福利活动：超值礼包已无免费按钮，第 {value.ExecutionCount} 次点击特权礼包页签"); break;
                        case "PrivilegeTabReady": Log("福利活动：已确认特权礼包页签打开"); break;
                        case "ClaimMonthlyCard": Log("福利活动：已点击月卡领取按钮"); break;
                        case "MonthlyClaimGone": Log("福利活动：已确认月卡领取按钮消失"); break;
                        case "ClaimLifetimeCard": Log("福利活动：已点击终身卡领取按钮"); break;
                        case "LifetimeClaimGone": Log("福利活动：已确认终身卡领取按钮消失"); break;
                        case "CloseWelfare": Log("福利活动：已点击右侧空白区域关闭界面"); break;
                    }
                }
                else if (value.Kind is MaaPipelineTraceKind.NodeFailed or MaaPipelineTraceKind.TaskChainFailed)
                    Log($"福利活动 Pipeline 失败：{value.TaskName ?? value.TaskChain}，{value.Error ?? value.Detail}", LogLevel.Error);
            });
            var pipeline = new MaaPipeline<MaaAdbPipelineState>(catalog,
                [new MaaAdbPipelineHandler<MaaAdbPipelineState>("WelfareAdb", current => current),
                 new FreeWelfareClaimStatusHandler()],
                new MaaPipelineExecutionOptions { TaskChain = "FreeWelfare", RetryTimes = 0, MaxTransitions = 60 },
                new MaaPipelineTraceMultiplexer([trace, operationLog, pipelineWebServer]));
            panelOpen = true;
            var result = await pipeline.RunAsync(state, ["OpenWelfare"], token);
            trace.SaveJson(runtime.Paths.Trace($"free-welfare-{result.RunId}.json"));
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded)
                throw new InvalidOperationException(result.LastTask switch
                {
                    "FreeGiftLimit" => "连续领取达到 8 次上限，未确认免费礼包结束",
                    "ValueTabLimit" => "连续点击后仍未确认超值礼包页签打开",
                    "PrivilegeTabLimit" => "连续点击后仍未确认特权礼包页签打开",
                    _ => result.Error ?? $"Pipeline 状态：{result.Status}"
                });
            var completed = trace.Events.Where(item => item.Kind == MaaPipelineTraceKind.NodeCompleted).ToArray();
            var freeCount = completed.Count(item => item.TaskName == "ClaimFreeGift");
            if (!completed.Any(item => item.TaskName == "ClaimMonthlyCard")) Log("福利活动：月卡无可领取按钮");
            if (!completed.Any(item => item.TaskName == "ClaimLifetimeCard")) Log("福利活动：终身卡无可领取按钮");
            Log($"福利活动：领取完成，免费礼包 {freeCount} 个");
            panelOpen = false;
            lastEntryRunSucceeded = true;
            State("福利活动免费奖励领取完成");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex)
        {
            Log($"福利活动：任务未完成，{ex.Message}", LogLevel.Error);
            State($"福利活动免费奖励未完成：{ex.Message}");
        }
        finally
        {
            if (panelOpen)
                try
                {
                    await adb.TapScreen(972d / 1004, 280d / 565);
                    Log("福利活动：异常结束后已点击右侧空白区域关闭界面");
                }
                catch (Exception ex) { Warn($"关闭福利活动失败：{ex.Message}"); }
            popupHandling = false;
        }
    }
}
