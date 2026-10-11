using System.Diagnostics;
using System.Drawing;
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
    readonly CheckBox logAutoScroll = Box("自动滚动到最新");
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
            FlowDirection = FlowDirection.TopDown, WrapContents = false,
            Padding = new(8), Tag = ThemeRole.SurfaceAlt
        };
        var searchRow = new TableLayoutPanel
        {
            AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink,
            ColumnCount = 4, RowCount = 1, Margin = Padding.Empty
        };
        for (var column = 0; column < 4; column++)
            searchRow.ColumnStyles.Add(new ColumnStyle(SizeType.AutoSize));
        searchRow.RowStyles.Add(new RowStyle(SizeType.AutoSize));
        var filterRow = new FlowLayoutPanel
        {
            AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink,
            WrapContents = false, Margin = new Padding(0, 4, 0, 0)
        };
        logInfo.Checked = logWarning.Checked = logError.Checked = logAutoScroll.Checked = true;
        var clear = Btn("清除日志", ThemeRole.SecondaryButton);
        logSearch.Anchor = logRegex.Anchor = clear.Anchor = AnchorStyles.None;
        clear.Click += (_, _) =>
        {
            logEntries.Clear();
            RefreshLogFilter();
        };
        searchRow.Controls.Add(new Label { Text = "搜索", AutoSize = true, Padding = new(0, 5, 0, 0), Anchor = AnchorStyles.None }, 0, 0);
        searchRow.Controls.Add(logSearch, 1, 0);
        searchRow.Controls.Add(logRegex, 2, 0);
        searchRow.Controls.Add(clear, 3, 0);
        filterRow.Controls.AddRange([logInfo, logWarning, logError, logAutoScroll]);
        toolbar.Controls.AddRange([searchRow, filterRow]);
        logSearch.TextChanged += (_, _) => RefreshLogFilter();
        logAutoScroll.CheckedChanged += (_, _) =>
        {
            if (logAutoScroll.Checked) ScrollLogToEnd();
        };
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
        var firstVisibleLine = log.FirstVisibleLine;
        var matchedEntries = new List<LogEntry>();
        var timer = Stopwatch.StartNew();
        foreach (var entry in logEntries)
        {
            if (logFilter.Matches(entry)) matchedEntries.Add(entry);
            if (logRegex.Checked && timer.ElapsedMilliseconds > 200) logFilter.StopForTimeout();
            if (logFilter.Error != null) break;
        }
        // 不显示部分匹配结果，避免超时后让用户误以为筛选已经完成。
        if (logFilter.Error != null) matchedEntries.Clear();
        log.SuspendLayout();
        try
        {
            log.Clear();
            foreach (var entry in matchedEntries) AppendLogEntry(entry);
        }
        finally { log.ResumeLayout(); }
        visibleLogEntries = matchedEntries.Count;
        if (logAutoScroll.Checked) ScrollLogToEnd();
        else log.ScrollToLine(firstVisibleLine);
        UpdateLogFilterStatus();
    }

    void AppendLogEntry(LogEntry entry)
    {
        log.SelectionStart = log.TextLength;
        log.SelectionLength = 0;
        log.SelectionColor = LogColor(entry.Level);
        log.AppendText(entry.DisplayText + "\r\n");
    }

    Color LogColor(LogLevel level) => level switch
    {
        LogLevel.Warning => currentPalette.WarningText,
        LogLevel.Error => currentPalette.ErrorText,
        _ => currentPalette.Text,
    };

    void ScrollLogToEnd()
    {
        log.SelectionStart = log.TextLength;
        log.SelectionLength = 0;
        log.ScrollToCaret();
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
            var firstVisibleLine = log.FirstVisibleLine;
            AppendLogEntry(entry);
            visibleLogEntries++;
            if (logAutoScroll.Checked) ScrollLogToEnd();
            else log.ScrollToLine(firstVisibleLine);
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
