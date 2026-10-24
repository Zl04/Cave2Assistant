namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunSoulArtifactCultivationAsync(CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        SoulArtifactPipeline? pipeline = null;
        try
        {
            var map = await adb.ReadMap();
            token.ThrowIfCancellationRequested();
            if (!MapRunTask.IsReturnDestination(map)) throw new InvalidOperationException("当前不在城镇");
            adb.Serial = devices.Text;
            popupHandling = true;
            Log("培养魂器：复用装备流程打开背包");
            if (!await OpenEquipmentBagAsync(token))
                throw new InvalidOperationException("未能打开背包");
            Log("培养魂器：背包已打开，开始执行魂器 Pipeline");
            pipeline = new SoulArtifactPipeline(adb,
                runtime.Paths.Pipeline("soul-artifact-pipeline.json"), Log);
            var trace = new MaaPipelineTraceCollector();
            var liveTrace = new DelegateMaaPipelineTraceSink(LogSoulArtifactPipelineEvent);
            var result = await pipeline.RunAsync(token,
                new MaaPipelineTraceMultiplexer([trace, liveTrace, pipelineWebServer]));
            try
            {
                var tracePath = runtime.Paths.Trace($"soul-artifact-{result.RunId}.json");
                trace.SaveJson(tracePath);
                Log($"培养魂器：Pipeline 轨迹已保存：{tracePath}");
            }
            catch (Exception ex) { Warn($"培养魂器：Pipeline 轨迹保存失败：{ex.Message}"); }
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded)
                throw new InvalidOperationException(result.Error ?? $"Pipeline 状态：{result.Status}");
            lastEntryRunSucceeded = true;
            Log("培养魂器：Pipeline 执行成功");
            State("培养魂器完成：次数已耗尽，已关闭背包");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex) { State($"培养魂器未完成：{ex.Message}"); }
        finally
        {
            if (pipeline is not null) await pipeline.CloseAfterFailureAsync();
            popupHandling = false;
        }
    }

    void LogSoulArtifactPipelineEvent(MaaPipelineTraceEvent value)
    {
        var task = SoulArtifactTaskName(value.TaskName ?? value.TaskChain);
        switch (value.Kind)
        {
            case MaaPipelineTraceKind.TaskChainStarted:
                Log("培养魂器：Pipeline 已启动");
                break;
            case MaaPipelineTraceKind.CandidateRecognized:
                Log($"培养魂器识别：{task}，命中={(value.Matched == true ? "是" : "否")}，详情={value.Detail ?? "-"}");
                break;
            case MaaPipelineTraceKind.NodeStarted:
                Log($"培养魂器节点开始：{task}，第 {value.ExecutionCount} 次");
                break;
            case MaaPipelineTraceKind.ActionStarted:
                Log($"培养魂器执行动作：{task} / {value.Action}");
                break;
            case MaaPipelineTraceKind.NodeCompleted:
                Log($"培养魂器节点完成：{task}，耗时 {value.Duration.TotalMilliseconds:0}ms");
                break;
            case MaaPipelineTraceKind.BranchSelected:
                Log($"培养魂器流程：{task} -> {value.Detail ?? "结束"}");
                break;
            case MaaPipelineTraceKind.Retrying:
                Log($"培养魂器重试：{task}，{value.Detail}");
                break;
            case MaaPipelineTraceKind.LimitExceeded:
                Log($"培养魂器次数上限：{task}，{value.Detail}", LogLevel.Error);
                break;
            case MaaPipelineTraceKind.NodeFailed:
            case MaaPipelineTraceKind.TaskChainFailed:
                Log($"培养魂器 Pipeline 失败：{task}，{value.Error ?? value.Detail ?? "未知原因"}", LogLevel.Error);
                break;
            case MaaPipelineTraceKind.TaskChainCompleted:
                Log("培养魂器：Pipeline 流程完成");
                break;
            case MaaPipelineTraceKind.Canceled:
                Log("培养魂器：Pipeline 已取消");
                break;
            case MaaPipelineTraceKind.Stopped:
                Log($"培养魂器：Pipeline 已停止，{value.Error ?? value.Detail ?? "无详情"}");
                break;
        }
    }

    static string SoulArtifactTaskName(string name) => name switch
    {
        "SoulArtifact" => "培养魂器",
        "SoulReady" => "确认魂器培养页",
        "SelectSoulTab" => "切换魂器页签",
        "Exhausted" => "检查培养次数是否耗尽",
        "CultivateAvailable" => "检查普通培养是否可用",
        "Cultivate" => "点击普通培养",
        "CultivationLimit" => "培养点击次数保护",
        "CloseBag" => "关闭背包",
        "BagClosed" => "确认背包已关闭",
        _ => name
    };
}
