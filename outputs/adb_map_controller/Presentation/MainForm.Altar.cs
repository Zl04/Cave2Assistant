namespace AdbMapController;

public sealed partial class MainForm
{
    async Task HandleAltarDialog(CancellationToken token)
    {
        var level = dungeon.Map?.Level ?? dungeon.ObservedLevel;
        // 弹窗已经实际打开时，地图快照的 Opened 可能滞后或表示 NPC 的触发态；
        // 它只能用于规划，不能阻止当前弹窗的处理。
        if (!Options().Altars || level < 0 || dungeon.AltarAttemptedLevel == level)
        {
            Log($"点金台弹窗跳过：层={level}，本层已尝试={dungeon.AltarAttemptedLevel == level}，规划启用={Options().Altars}");
            await CloseAltarDialogIfVisible(token);
            return;
        }

        // 一层只进入一次。无可点击装备、按钮未点亮和异常也不再重新触发该 NPC。
        dungeon.AltarAttemptedLevel = level;
        // 独立弹窗监控可能在路线仍缓存时发现点金台；立即丢弃旧路线。
        // 下一轮规划通过 Options() 排除本层点金台，避免失败后再次走向同一目标。
        route = [];
        plannedInteractions = [];
        plannedTargetUniverse.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();
        popupHandling = true;
        try
        {
            State("点金台：寻找可点击装备");
            var pipeline = new AltarPipeline(adb, runtime.Paths.Pipeline("altar-pipeline.json"), Log);
            var result = await pipeline.RunAsync(token, pipelineWebServer);
            if (!result.Succeeded) Warn($"点金台交互停止：{result.Error}");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex) { Warn($"点金台交互异常：{ex.Message}"); }
        finally
        {
            try { if (!token.IsCancellationRequested) await CloseAltarDialogIfVisible(token); }
            finally { popupHandling = false; }
        }
    }

    async Task CloseAltarDialogIfVisible(CancellationToken token)
    {
        using var frame = await adb.CaptureScreenForAutomationAsync(token);
        if (PopupRecognition.HasAltarDialog(frame))
        {
            await adb.TapScreenSecondary(.46, .63);
            Log("点金台弹窗处理结束，已关闭界面");
        }
    }
}
