using System.Diagnostics;
using System.Drawing;
using System.Collections.Concurrent;
using System.Threading;
using System.Text;
using System.Windows.Forms;

namespace AdbMapController;

public sealed partial class MainForm
{
    const int MaxLogEntries = 999;
    readonly Queue<LogEntry> logEntries = new();
    readonly ConcurrentQueue<LogEntry> pendingLogEntries = new();
    int logFlushScheduled;
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
    bool logViewDirty;

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
        log.VisibleChanged += (_, _) =>
        {
            if (log.Visible && logViewDirty) RenderLogs();
        };
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
        if (!log.Visible)
        {
            logViewDirty = true;
            return;
        }
        logViewDirty = false;
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
        // 先在内存中生成完整的带颜色文本，再一次提交给 RichEdit。
        // SuspendLayout 只暂停布局，无法阻止 AppendText 逐条更新和重绘。
        var rtf = new StringBuilder(@"{\rtf1\ansi\deff0{\fonttbl{\f0 ");
        AppendRtfText(rtf, log.Font.Name);
        rtf.Append(@";}}{\colortbl ;");
        foreach (var level in Enum.GetValues<LogLevel>())
        {
            var color = LogColor(level);
            rtf.Append($@"\red{color.R}\green{color.G}\blue{color.B};");
        }
        rtf.Append(@"}\viewkind4\uc1\pard\f0\fs");
        rtf.Append((int)Math.Round(log.Font.SizeInPoints * 2));
        rtf.Append(' ');
        foreach (var entry in matchedEntries)
        {
            rtf.Append(@"\cf").Append((int)entry.Level + 1).Append(' ');
            AppendRtfText(rtf, entry.DisplayText);
            rtf.Append(@"\par ");
        }
        // RichEdit 不将文档最后的段落标记计入 Text，额外保留日志末尾换行。
        if (matchedEntries.Count > 0) rtf.Append(@"\par ");
        rtf.Append('}');
        log.ReplaceRtf(rtf.ToString());
        visibleLogEntries = matchedEntries.Count;
        if (logAutoScroll.Checked) ScrollLogToEnd();
        else log.ScrollToLine(firstVisibleLine);
        UpdateLogFilterStatus();
    }

    static void AppendRtfText(StringBuilder builder, string text)
    {
        for (var index = 0; index < text.Length; index++)
        {
            var character = text[index];
            switch (character)
            {
                case '\\': case '{': case '}': builder.Append('\\').Append(character); break;
                case '\r':
                    if (index + 1 < text.Length && text[index + 1] == '\n') index++;
                    builder.Append(@"\par ");
                    break;
                case '\n': builder.Append(@"\par "); break;
                case '\t': builder.Append(@"\tab "); break;
                default:
                    if (character >= ' ' && character <= '~') builder.Append(character);
                    else builder.Append(@"\u").Append((short)character).Append('?');
                    break;
            }
        }
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
        var entry = new LogEntry(DateTime.Now, level, text);
        ApplicationLog.Write(entry);
        if (InvokeRequired)
        {
            pendingLogEntries.Enqueue(entry);
            if (Interlocked.Exchange(ref logFlushScheduled, 1) == 0)
                BeginInvoke(FlushPendingLogs);
            return;
        }
        AppendLog(entry);
    }

    void FlushPendingLogs()
    {
        if (IsDisposed || Disposing) return;
        for (var count = 0; count < 256 && pendingLogEntries.TryDequeue(out var entry); count++)
            AppendLog(entry);
        Interlocked.Exchange(ref logFlushScheduled, 0);
        if (!pendingLogEntries.IsEmpty && Interlocked.Exchange(ref logFlushScheduled, 1) == 0)
            BeginInvoke(FlushPendingLogs);
    }

    void AppendLog(LogEntry entry)
    {
        logEntries.Enqueue(entry);
        if (!log.Visible)
        {
            if (logEntries.Count > MaxLogEntries) logEntries.Dequeue();
            logViewDirty = true;
            return;
        }
        if (logEntries.Count > MaxLogEntries)
        {
            var oldest = logEntries.Dequeue();
            if (logFilter.Matches(oldest) && visibleLogEntries > 0)
            {
                var nextLine = log.GetFirstCharIndexFromLine(1);
                log.Select(0, nextLine >= 0 ? nextLine : log.TextLength);
                log.SelectedText = string.Empty;
                visibleLogEntries--;
            }
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
