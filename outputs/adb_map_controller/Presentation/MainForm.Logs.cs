using System.Diagnostics;
using System.Windows.Forms;

namespace AdbMapController;

public sealed partial class MainForm
{
    const int MaxLogEntries = 5000;
    readonly Queue<LogEntry> logEntries = new();
    readonly TextBox logSearch = new ThemedTextBox
    {
        Width = 240, PlaceholderText = "输入关键词或正则表达式", AccessibleName = "日志搜索"
    };
    readonly CheckBox logRegex = Box("正则匹配");
    readonly CheckBox logInfo = Box("info");
    readonly CheckBox logWarning = Box("warning");
    readonly CheckBox logError = Box("error");
    readonly Label logFilterStatus = new()
    {
        Dock = DockStyle.Top, AutoSize = true, Padding = new(10, 4, 10, 8), Tag = ThemeRole.MutedText
    };
    LogFilter logFilter = new("", false, Enum.GetValues<LogLevel>());
    int visibleLogEntries;

    Control CreateLogView()
    {
        var panel = new Panel { Dock = DockStyle.Fill, Tag = ThemeRole.Default };
        var toolbar = new FlowLayoutPanel
        {
            Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink,
            Padding = new(8), WrapContents = true, Tag = ThemeRole.SurfaceAlt
        };
        logInfo.Checked = logWarning.Checked = logError.Checked = true;
        var clear = Btn("清除日志", ThemeRole.SecondaryButton);
        clear.Click += (_, _) =>
        {
            logEntries.Clear();
            RefreshLogFilter();
        };
        toolbar.Controls.AddRange([
            new Label { Text = "搜索", AutoSize = true, Padding = new(0, 5, 0, 0) },
            logSearch, logRegex, logInfo, logWarning, logError, clear
        ]);
        logSearch.TextChanged += (_, _) => RefreshLogFilter();
        foreach (var checkbox in new[] { logRegex, logInfo, logWarning, logError })
            checkbox.CheckedChanged += (_, _) => RefreshLogFilter();
        panel.Controls.Add(log);
        panel.Controls.Add(logFilterStatus);
        panel.Controls.Add(toolbar);
        UpdateLogFilterStatus();
        return panel;
    }

    void RefreshLogFilter()
    {
        var levels = new List<LogLevel>();
        if (logInfo.Checked) levels.Add(LogLevel.Info);
        if (logWarning.Checked) levels.Add(LogLevel.Warning);
        if (logError.Checked) levels.Add(LogLevel.Error);
        logFilter = new(logSearch.Text, logRegex.Checked, levels);
        RenderLogs();
    }

    void RenderLogs()
    {
        var lines = new List<string>();
        var timer = Stopwatch.StartNew();
        foreach (var entry in logEntries)
        {
            if (logFilter.Matches(entry)) lines.Add(entry.DisplayText);
            if (logRegex.Checked && timer.ElapsedMilliseconds > 200) logFilter.StopForTimeout();
            if (logFilter.Error != null) break;
        }
        // 不显示部分匹配结果，避免超时后让用户误以为筛选已经完成。
        if (logFilter.Error != null) lines.Clear();
        visibleLogEntries = lines.Count;
        log.Text = lines.Count == 0 ? "" : string.Join("\r\n", lines) + "\r\n";
        log.SelectionStart = log.TextLength;
        log.ScrollToCaret();
        UpdateLogFilterStatus();
    }

    void UpdateLogFilterStatus()
    {
        logFilterStatus.Text = logFilter.Error ?? $"显示 {visibleLogEntries} / {logEntries.Count} 条日志（保留最近 {MaxLogEntries} 条）";
        logFilterStatus.Tag = logFilter.Error == null ? ThemeRole.MutedText : ThemeRole.WarningText;
        logFilterStatus.ForeColor = logFilter.Error == null ? currentPalette.MutedText : currentPalette.WarningText;
    }

    void Log(string text) => Log(text, LogLevel.Info);

    void Log(string text, LogLevel level)
    {
        if (IsDisposed || Disposing) return;
        if (InvokeRequired) { BeginInvoke(() => Log(text, level)); return; }
        var entry = new LogEntry(DateTime.Now, level, text);
        logEntries.Enqueue(entry);
        if (logEntries.Count > MaxLogEntries)
        {
            logEntries.Dequeue();
            RenderLogs();
            return;
        }
        if (logFilter.Matches(entry))
        {
            log.AppendText(entry.DisplayText + "\r\n");
            visibleLogEntries++;
        }
        else if (logFilter.Error != null && visibleLogEntries > 0)
        {
            log.Clear();
            visibleLogEntries = 0;
        }
        UpdateLogFilterStatus();
    }

    void Warn(string text) => Log(text, LogLevel.Warning);
}
