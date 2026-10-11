using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Win32;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task CalibrateEntry()
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) throw new InvalidOperationException("请先连接设备");
        if (activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false })
            throw new InvalidOperationException("请先暂停当前运行，再进行入口标定");
        var map = SelectedEntryMap;
        using var screenshot = await adb.CaptureScreenForAutomationAsync();
        using var dialog = new EntryCalibrationForm(screenshot, map.Name);
        dialog.ApplyTheme(currentPalette);
        if (dialog.ShowDialog(this) != DialogResult.OK || dialog.SelectedPoint is not Point point ||
            dialog.SelectedTemplateBounds is not Rectangle bounds) return;
        entryTemplates.Save(map.TemplateId, VisualTemplate.Create(screenshot, bounds),
            EntryTemplateStore.GetTargetOffset(bounds, point));
        Log(map.UsesSharedEntrance
            ? $"已保存特殊副本公共入口场景模板（{map.Name}共用）；会以场景定位、锚点点击并二次确认"
            : $"已保存“{map.Name}”入口场景模板；会以场景定位并按锚点点击");
        State("入口模板已保存");
    }

    async Task AutoEnter()
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) throw new InvalidOperationException("请先连接设备");
        if (activeMovement is { IsCompleted: false })
            throw new InvalidOperationException("请先暂停或停止地图导航，再自动进图");
        if (activeEntry is { IsCompleted: false }) return;

        await operations.RunAsync(ControllerOperationKind.Entry, RunEntryRunPipelineAsync);
    }
    async Task RunEntryRunPipelineAsync(CancellationToken owner)
    {
        MaaPipelineCatalog catalog;
        try { catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("entry-run-pipeline.json")); }
        catch (Exception ex) { Error(ex); State("进图跑图 Pipeline 配置无效"); return; }

        var trace = new MaaPipelineTraceCollector();
        var liveTrace = new DelegateMaaPipelineTraceSink(value =>
        {
            var task = value.TaskName ?? value.TaskChain;
            if (value.Kind == MaaPipelineTraceKind.NodeStarted) Log($"进图跑图 Pipeline 节点开始：{task}");
            else if (value.Kind == MaaPipelineTraceKind.NodeCompleted) Log($"进图跑图 Pipeline 节点完成：{task}，耗时 {value.Duration.TotalMilliseconds:0}ms");
            else if (value.Kind is MaaPipelineTraceKind.NodeFailed or MaaPipelineTraceKind.TaskChainFailed)
                Log($"进图跑图 Pipeline 失败：{task}，{value.Error ?? value.Detail}", LogLevel.Error);
            else if (value.Kind == MaaPipelineTraceKind.BranchSelected)
                Log($"进图跑图 Pipeline 分支：{task} -> {value.Detail ?? "结束"}");
        });
        var handlers = new[]
        {
            new DelegateMaaPipelineHandler<MainForm>("EntryRunCycle", async (task, _, token) =>
                {
                    if (task.Name != "AlreadyInDungeon")
                        return MaaPipelineRecognitionResult.Hit(detail: "DirectHit");

                    try
                    {
                        var map = await adb.ReadMap();
                        token.ThrowIfCancellationRequested();
                        var ready = map.SceneType >= 0 && map.Width > 0 && map.Height > 0;
                        var inDungeon = ready && !MapRunTask.IsReturnDestination(map);
                        Log(inDungeon
                            ? $"启动状态检查：已在副本（SceneType={map.SceneType}, Level={map.Level}），跳过进图"
                            : ready
                                ? $"启动状态检查：当前在城镇或返回点（SceneType={map.SceneType}, Level={map.Level}），先执行进图"
                                : "启动状态检查：地图数据尚未就绪，按城镇流程尝试进图");
                        return inDungeon
                            ? MaaPipelineRecognitionResult.Hit(text: map.MapName, detail: "AlreadyInDungeon")
                            : MaaPipelineRecognitionResult.Miss(ready ? "AtReturnDestination" : "MapNotReady");
                    }
                    catch (OperationCanceledException) { throw; }
                    catch (Exception ex)
                    {
                        Warn($"启动状态检查读取地图失败，将尝试进图：{ex.Message}");
                        return MaaPipelineRecognitionResult.Miss("MapReadFailed");
                    }
                },
                async (_, _, context, token) =>
                {
                    if (context.TaskName is "AlreadyInDungeon" or "StartFromTown")
                        return MaaPipelineActionResult.Success();
                    if (context.TaskName == "EnterDungeon")
                    {
                        var succeeded = await context.State.AutoEnterCore(token);
                        token.ThrowIfCancellationRequested();
                        return succeeded ? MaaPipelineActionResult.Success() : MaaPipelineActionResult.Failure("进图失败或已取消");
                    }
                    if (context.TaskName == "RunDungeonCycle")
                    {
                        context.State.lastMapRunSucceeded = false;
                        context.State.entryRunMovementScope = true;
                        try
                        {
                            await context.State.RunMovementScope(token, context.State.StartRunCore, startupProbePaused: true);
                        }
                        finally { context.State.entryRunMovementScope = false; }
                        token.ThrowIfCancellationRequested();
                        return context.State.lastMapRunSucceeded
                            ? MaaPipelineActionResult.Success()
                            : MaaPipelineActionResult.Failure("跑图未完成");
                    }
                    if (context.TaskName == "LoopGate")
                    {
                        if (!context.State.loopEntryAndRun.Checked)
                        {
                            context.State.Log("循环进图/跑图已关闭，本轮任务结束");
                            return MaaPipelineActionResult.Stop();
                        }
                        return MaaPipelineActionResult.Success();
                    }
                    return MaaPipelineActionResult.Failure($"未知的进图跑图任务：{context.TaskName}");
                })
        };
        var pipeline = new MaaPipeline<MainForm>(catalog, handlers,
            new MaaPipelineExecutionOptions { TaskChain = "EntryAndMapRun", RetryTimes = 0, MaxTransitions = int.MaxValue },
            new MaaPipelineTraceMultiplexer([trace, liveTrace, pipelineWebServer]));
        State("进图跑图 Pipeline 运行中");
        var result = await pipeline.RunAsync(this, ["AlreadyInDungeon", "StartFromTown"], owner);
        try
        {
            var tracePath = runtime.Paths.Trace($"entry-run-{result.RunId}.json");
            trace.SaveJson(tracePath);
            Log($"进图跑图 Pipeline 节点诊断已保存：{tracePath}");
        }
        catch (Exception ex) { Warn($"进图跑图 Pipeline 诊断保存失败：{ex.Message}"); }
        if (result.Status == MaaPipelineExecutionStatus.Canceled)
        {
            Log("进图跑图 Pipeline 已取消");
            State("进图跑图已取消");
        }
        else if (!result.Succeeded && result.Status != MaaPipelineExecutionStatus.Stopped)
        {
            Log($"进图跑图 Pipeline 失败：{result.Error ?? result.Status.ToString()}", LogLevel.Error);
            State("进图跑图失败");
        }
        else
        {
            State("进图跑图任务完成");
        }
    }

    async Task<bool> AutoEnterCore(CancellationToken owner)
    {
        var selection = new DungeonEntrySelection(
            SelectedEntryMap.Id, Math.Max(1, entryChoice.SelectedIndex + 1),
            (DungeonDifficulty)Math.Clamp(entryDifficulty.SelectedIndex, (int)DungeonDifficulty.Normal, (int)DungeonDifficulty.Nightmare));
        try
        {
            adb.Serial = devices.Text;
            var automation = new DungeonEntryAutomation(adb, entryTemplates, Log, State);
            var trace = new MaaPipelineTraceCollector();
            var liveTrace = new DelegateMaaPipelineTraceSink(value =>
            {
                var task = value.TaskName ?? value.TaskChain;
                switch (value.Kind)
                {
                    case MaaPipelineTraceKind.NodeStarted:
                        Log($"进图 Pipeline 节点开始：{task}");
                        break;
                    case MaaPipelineTraceKind.NodeCompleted:
                        Log($"进图 Pipeline 节点完成：{task}，耗时 {value.Duration.TotalMilliseconds:0}ms");
                        break;
                    case MaaPipelineTraceKind.CandidateRecognized when string.Equals(task, "点击挑战", StringComparison.Ordinal):
                        Log($"挑战按钮 OCR：命中={(value.Matched == true ? "是" : "否")}，文本={value.Text ?? "<空>"}，位置={value.Box?.ToString() ?? "无"}，详情={value.Detail ?? "-"}");
                        break;
                    case MaaPipelineTraceKind.NodeFailed:
                    case MaaPipelineTraceKind.TaskChainFailed:
                        Log($"进图 Pipeline 失败：{task}，{value.Error ?? value.Detail}", LogLevel.Error);
                        break;
                    case MaaPipelineTraceKind.BranchSelected:
                        Log($"进图 Pipeline 分支：{task} -> {value.Detail ?? "结束"}");
                        break;
                }
            });
            var entryOperation = automation.RunAsync(selection, owner, new MaaPipelineTraceMultiplexer([trace, liveTrace]));
            var result = await entryOperation;
            try
            {
                var tracePath = runtime.Paths.Trace($"dungeon-entry-{result.RunId}.json");
                trace.SaveJson(tracePath);
                Log($"进图 Pipeline 节点诊断已保存：{tracePath}");
            }
            catch (Exception ex) { Warn($"进图 Pipeline 节点诊断保存失败：{ex.Message}"); }

            if (result.Status == MaaPipelineExecutionStatus.Canceled)
            {
                Log("自动进图已取消");
                State("自动进图已取消");
                return false;
            }
            else if (!result.Succeeded)
            {
                Log($"自动进图失败：{result.Error ?? result.Status.ToString()}", LogLevel.Error);
                State("自动进图失败");
                return false;
            }
            return true;
        }
        catch (OperationCanceledException) { Log("自动进图已取消"); State("自动进图已取消"); return false; }
        catch (Exception ex) { Error(ex); State("自动进图失败"); return false; }
        finally
        {
            UpdateDeviceAvailability();
        }
    }
}
