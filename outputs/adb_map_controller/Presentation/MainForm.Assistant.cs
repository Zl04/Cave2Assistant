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
    async Task DetectAssistant()
    {
        try
        {
            adb.Serial = devices.Text; var s = await adb.GetAssistantStatus(AssistantFile("MiniMapDrawer.template.lua"));
            assistantState.Text = s.Installed ? $"助手已安装  备份:{(s.BackupExists ? "有" : "无")}  测试面板:{(s.TestPanelSupported ? "支持" : "需重装")}" : $"助手未安装  备份:{(s.BackupExists ? "有" : "无")}";
            assistantState.ForeColor = s.Installed ? currentPalette.SuccessText : currentPalette.WarningText;
            Log($"助手检测：{assistantState.Text.Trim()}，目标 {s.Target}，当前 {s.CurrentHash[..12]}，格式 {s.Format}");
        }
        catch (Exception ex) { Error(ex); }
    }
    async Task InstallAssistant()
    {
        if (MessageBox.Show("将先备份原文件，再以 Root 权限写入地图助手。游戏需重启后生效。继续吗？", "安装地图助手", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) != DialogResult.Yes) return;
        try { adb.Serial = devices.Text; await adb.InstallAssistant(AssistantFile("MiniMapDrawer.template.lua")); Log("已读取设备当前 Lua 源码、注入并按原格式加密校验；请重启游戏"); await DetectAssistant(); }
        catch (Exception ex) { Error(ex); }
    }
    async Task RestoreAssistant()
    {
        if (MessageBox.Show("将用设备端备份恢复原版文件。游戏需重启后生效。继续吗？", "恢复原版", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) != DialogResult.Yes) return;
        try { adb.Serial = devices.Text; await adb.RestoreAssistant(AssistantFile("MiniMapDrawer.template.lua")); Log("原版文件已恢复；请重启游戏"); await DetectAssistant(); }
        catch (Exception ex) { Error(ex); }
    }
    async Task OpenTestPanel()
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) { Log("打开测试面板失败：尚未选择设备"); return; }
        if (activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false })
        {
            Log("打开测试面板失败：请先暂停或停止自动运行");
            MessageBox.Show("请先暂停或停止自动运行，再打开测试面板。", "打开测试面板", MessageBoxButtons.OK, MessageBoxIcon.Information);
            return;
        }
        try
        {
            adb.Serial = devices.Text;
            var status = await adb.GetAssistantStatus(AssistantFile("MiniMapDrawer.template.lua"));
            if (!status.Installed)
            {
                Log("打开测试面板失败：地图助手未安装");
                MessageBox.Show("请先安装地图助手并重启游戏。", "打开测试面板", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (!status.TestPanelSupported)
            {
                Log("打开测试面板失败：当前设备上的助手版本不支持，请重新安装助手并重启游戏");
                MessageBox.Show("当前设备上的助手版本不支持该功能，请重新安装助手并重启游戏。", "打开测试面板", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            await adb.RequestOpenTestPanel();
            Log("已请求打开测试面板；游戏将在助手脚本下一次轮询时打开，请确认游戏已重启并加载助手");
        }
        catch (Exception ex) { Error(ex); }
    }
}
