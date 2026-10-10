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

        await operations.RunAsync(ControllerOperationKind.Entry, AutoEnterCore);
    }
    async Task AutoEnterCore(CancellationToken owner)
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
            }
            else if (!result.Succeeded)
            {
                Log($"自动进图失败：{result.Error ?? result.Status.ToString()}", LogLevel.Error);
                State("自动进图失败");
            }
        }
        catch (OperationCanceledException) { Log("自动进图已取消"); State("自动进图已取消"); }
        finally
        {
            UpdateDeviceAvailability();
        }
    }
}
