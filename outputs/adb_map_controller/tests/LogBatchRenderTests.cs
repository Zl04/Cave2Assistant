using System.Drawing;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Windows.Forms;

namespace AdbMapController.Tests;

public sealed class LogBatchRenderTests
{
    [Fact]
    public void EnablingInfoPublishesHistoryInOneBatch()
    {
        Exception? failure = null;
        var thread = new Thread(() =>
        {
            try
            {
                // Exercise the real filter/render path without starting device services.
                var form = (MainForm)RuntimeHelpers.GetUninitializedObject(typeof(MainForm));
                const BindingFlags flags = BindingFlags.Instance | BindingFlags.NonPublic;
                void Set(string name, object value) => typeof(MainForm).GetField(name, flags)!.SetValue(form, value);
                using var host = new Form();
                using var log = new ThemedRichTextBox { Dock = DockStyle.Fill };
                using var info = new CheckBox();
                using var warning = new CheckBox { Checked = true };
                using var error = new CheckBox { Checked = true };
                using var regex = new CheckBox();
                using var scroll = new CheckBox { Checked = true };
                using var search = new TextBox();
                using var status = new Label();
                host.Controls.Add(log);
                host.Show();
                Set("log", log); Set("logInfo", info); Set("logWarning", warning); Set("logError", error);
                Set("logRegex", regex); Set("logAutoScroll", scroll); Set("logSearch", search);
                Set("logFilterStatus", status); Set("currentPalette", ThemePalette.Light);
                var entries = new Queue<LogEntry>(Enumerable.Range(0, 999).Select(i =>
                    new LogEntry(DateTime.Today, (LogLevel)(i % 3), $"日志 {i}: 中文 {{test}} \\ 路径\n第二行")));
                Set("logEntries", entries);
                var refresh = typeof(MainForm).GetMethod("RefreshLogFilter", flags)!;
                refresh.Invoke(form, null);
                var changes = 0;
                log.TextChanged += (_, _) => changes++;
                info.Checked = true;
                refresh.Invoke(form, null);
                // RichEdit emits up to two notifications for one RTF stream replacement.
                Assert.True(changes <= 2, $"Filter replay exposed {changes} intermediate text changes instead of one batch");
                Assert.Equal(string.Concat(entries.Select(e => e.DisplayText.Replace("\r\n", "\n") + "\n")), log.Text);
                var offset = 0;
                foreach (var entry in entries)
                {
                    log.Select(offset, 1);
                    Assert.Equal(entry.Level switch { LogLevel.Warning => ThemePalette.Light.WarningText,
                        LogLevel.Error => ThemePalette.Light.ErrorText, _ => ThemePalette.Light.Text }, log.SelectionColor);
                    offset += entry.DisplayText.Length + 1;
                }
            }
            catch (Exception ex) { failure = ex; }
        });
        thread.SetApartmentState(ApartmentState.STA);
        thread.Start();
        Assert.True(thread.Join(TimeSpan.FromSeconds(30)), "Log rendering timed out");
        if (failure != null) throw failure;
    }
}
