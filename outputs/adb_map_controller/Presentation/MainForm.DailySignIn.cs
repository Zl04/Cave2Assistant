namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunDailySignInAsync(CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        try
        {
            var map = await adb.ReadMap();
            token.ThrowIfCancellationRequested();
            if (!MapRunTask.IsReturnDestination(map))
                throw new InvalidOperationException("当前不在城镇");
            adb.Serial = devices.Text;
            popupHandling = true;
            Log("每日签到：任务开始，识别顶部签到入口");

            var catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("daily-sign-in-pipeline.json"));
            var state = new MaaAdbPipelineState(adb, log: Log, saveEvidence: false);
            var trace = new MaaPipelineTraceCollector();
            var pipeline = new MaaPipeline<MaaAdbPipelineState>(catalog,
                [new MaaAdbPipelineHandler<MaaAdbPipelineState>("SignInAdb", current => current),
                    new DailySignInPipelineHandler(state)],
                new MaaPipelineExecutionOptions { TaskChain = "DailySignIn", RetryTimes = 0, MaxTransitions = 48 },
                new MaaPipelineTraceMultiplexer([trace, pipelineWebServer]));
            var result = await pipeline.RunAsync(state, ["OpenSignIn"], token);
            var tracePath = runtime.Paths.Trace($"daily-sign-in-{result.RunId}.json");
            if (trace.SaveJson(tracePath)) Log($"每日签到：Pipeline 跟踪日志已保存至 {tracePath}");
            token.ThrowIfCancellationRequested();

            foreach (var completed in trace.Events.Where(item => item.Kind == MaaPipelineTraceKind.NodeCompleted))
            {
                var message = completed.TaskName switch
                {
                    "OpenSignIn" => "已点击签到入口",
                    "ConfirmSignInPage" => "已通过 OCR 确认签到页",
                    "FindClaimableReward" => "已点击高亮奖励",
                    "ConfirmRewardDialog" => "已通过识图确认奖励弹窗",
                    "ClickRewardConfirm" => "已点击弹窗确定",
                    "VerifyDialogClosed" => "已确认奖励弹窗关闭",
                    "CheckCumulativeReward" => "已发现符合天数且未勾选的累计奖励",
                    "ConfirmCumulativeDayLabel" => "已 OCR 确认奖励下方天数并点击",
                    "ConfirmCumulativeDialog" => "已通过识图确认累计奖励弹窗",
                    "ClickCumulativeConfirm" => "已点击累计奖励弹窗确定",
                    "VerifyCumulativeDialogClosed" => "已确认累计奖励弹窗关闭",
                    "CloseSignIn" => "已点击签到页右侧空白处",
                    "VerifySignInClosed" => "已确认签到页关闭",
                    _ => null
                };
                if (message is not null) Log($"每日签到：{message}");
            }
            var closeAttempted = trace.Events.Any(item =>
                item.Kind == MaaPipelineTraceKind.NodeCompleted && item.TaskName == "CloseSignIn");
            var closeVerificationFailed = !result.Succeeded && closeAttempted && result.LastTask == "CloseSignIn";
            if (!result.Succeeded && !closeVerificationFailed)
                throw new InvalidOperationException($"Pipeline 状态：{result.Status}，最后节点：{result.LastTask}，原因：{result.Error ?? "未知"}");
            if (closeVerificationFailed)
                Log($"每日签到：奖励检查已完成，但未能确认签到页关闭（{result.Error ?? "未知"}）；继续执行后续任务", LogLevel.Warning);

            var claimed = trace.Events.Any(item =>
                item.Kind == MaaPipelineTraceKind.NodeCompleted && item.TaskName == "FindClaimableReward");
            var cumulativeCount = trace.Events.Count(item =>
                item.Kind == MaaPipelineTraceKind.NodeCompleted && item.TaskName == "CheckCumulativeReward");
            if (!claimed) Log("每日签到：采样期间未发现可领取的高亮奖励");
            Log($"每日签到：累计奖励已领取 {cumulativeCount} 项");
            lastEntryRunSucceeded = true;
            State(closeVerificationFailed ? "每日签到奖励检查完成：关闭状态待确认，继续后续任务" : claimed || cumulativeCount > 0
                ? $"每日签到完成：每日奖励 {(claimed ? "已领取" : "无需领取")}，累计奖励 {cumulativeCount} 项"
                : "每日签到完成：当前没有可领取奖励");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex)
        {
            Log($"每日签到：任务未完成，{ex.Message}", LogLevel.Error);
            State($"每日签到未完成：{ex.Message}");
        }
        finally { popupHandling = false; }
    }
}
