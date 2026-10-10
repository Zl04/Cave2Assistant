using System.Drawing;
using System.Reflection;
using System.Collections.Concurrent;

namespace AdbMapController.Tests;

[Collection("Fake ADB process")]
public sealed class ShutdownResourceTests
{
    sealed class MemorySettingsStore : ISettingsStore
    {
        public ControllerSettings? Load() => null;
        public void Save(ControllerSettings settings) { }
    }

    sealed class UiContext : SynchronizationContext, IDisposable
    {
        readonly BlockingCollection<(SendOrPostCallback Callback, object? State)> queue = new();
        public override void Post(SendOrPostCallback callback, object? state) => queue.Add((callback, state));
        public void Pump() { foreach (var item in queue.GetConsumingEnumerable()) item.Callback(item.State); }
        public void Finish() => queue.CompleteAdding();
        public void Dispose() => queue.Dispose();
    }

    static async Task OnUiThread(Func<Task> action)
    {
        var completion = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var thread = new Thread(() =>
        {
            using var context = new UiContext();
            SynchronizationContext.SetSynchronizationContext(context);
            context.Post(async _ =>
            {
                try { await action(); completion.TrySetResult(); }
                catch (Exception ex) { completion.TrySetException(ex); }
                finally { context.Finish(); }
            }, null);
            context.Pump();
        }) { IsBackground = true };
        thread.SetApartmentState(ApartmentState.STA);
        thread.Start();
        try { await completion.Task.WaitAsync(TimeSpan.FromSeconds(10)); }
        finally { Assert.True(thread.Join(TimeSpan.FromSeconds(2)), "WinForms lifecycle fixture thread did not exit"); }
    }

    static object CreateCache()
        => Activator.CreateInstance(typeof(AdbClient).Assembly.GetType("AdbMapController.ScreenFrameCache", true)!, nonPublic: true)!;

    [Fact]
    public Task LogPageFiltersIncomingEntriesRestoresHiddenEntriesAndClearsEverything() => OnUiThread(async () =>
    {
        var root = Path.Combine(AppContext.BaseDirectory, "log-view-fixture-" + Guid.NewGuid().ToString("N"));
        var runtime = new ControllerRuntime(root);
        using var form = new MainForm(runtime, new MemorySettingsStore());
        var flags = BindingFlags.Instance | BindingFlags.NonPublic;
        T Field<T>(string name) => (T)typeof(MainForm).GetField(name, flags)!.GetValue(form)!;
        var write = typeof(MainForm).GetMethod("Log", flags, null, [typeof(string), typeof(LogLevel)], null)!;
        void Write(string text, LogLevel level) => write.Invoke(form, [text, level]);
        var tabs = Assert.IsAssignableFrom<System.Windows.Forms.TabControl>(Assert.Single(form.Controls.Cast<System.Windows.Forms.Control>()));
        var page = tabs.TabPages[tabs.TabPages.Count - 1];
        Assert.Equal("日志", page.Text);
        var panel = Assert.IsType<System.Windows.Forms.Panel>(Assert.Single(page.Controls.Cast<System.Windows.Forms.Control>()));
        var toolbar = Assert.IsType<System.Windows.Forms.FlowLayoutPanel>(panel.Controls.Cast<System.Windows.Forms.Control>().Single(x => x is System.Windows.Forms.FlowLayoutPanel));
        var clear = Assert.IsAssignableFrom<System.Windows.Forms.Button>(toolbar.Controls.Cast<System.Windows.Forms.Control>().Single(x => x.Text == "清除日志"));
        void Clear() => typeof(System.Windows.Forms.Button).GetMethod("OnClick", flags)!.Invoke(clear, [EventArgs.Empty]);
        var output = Field<System.Windows.Forms.TextBox>("log");
        var search = Field<System.Windows.Forms.TextBox>("logSearch");
        var warning = Field<System.Windows.Forms.CheckBox>("logWarning");
        try
        {
            Clear();
            Write("地图刷新", LogLevel.Info);
            Write("移动超时", LogLevel.Warning);
            Write("连接失败", LogLevel.Error);
            search.Text = "移动";
            Assert.Contains("移动超时", output.Text);
            Assert.DoesNotContain("地图刷新", output.Text);
            warning.Checked = false;
            Write("移动受阻", LogLevel.Warning);
            Assert.Equal("", output.Text);
            warning.Checked = true;
            Assert.Contains("移动受阻", output.Text);
            search.Text = "";
            Assert.Contains("地图刷新", output.Text);
            Assert.Contains("[error] 连接失败", output.Text);
            search.Text = "移动";
            Clear();
            search.Text = "";
            Assert.Equal("", output.Text);
            Write("新的日志", LogLevel.Info);
            Assert.Contains("新的日志", output.Text);
            Assert.DoesNotContain("连接失败", output.Text);
        }
        finally { await form.ShutdownAsync(); }
    });

    [Fact]
    public async Task SharedCaptureCompletingAfterCacheDisposeIsRejected()
    {
        var cache = CreateCache();
        var cacheType = cache.GetType();
        var captureStarted = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var finishCapture = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
        Func<CancellationToken, Task<Bitmap>> capture = _ =>
        {
            captureStarted.TrySetResult();
            return finishCapture.Task;
        };
        var get = (Task<Bitmap>)cacheType.GetMethod("GetAsync")!
            .Invoke(cache, [42L, capture, CancellationToken.None])!;

        await captureStarted.Task.WaitAsync(TimeSpan.FromSeconds(2));
        cacheType.GetMethod("Dispose")!.Invoke(cache, null);
        finishCapture.SetResult(new Bitmap(4, 4));

        var error = await Assert.ThrowsAsync<ObjectDisposedException>(() => get.WaitAsync(TimeSpan.FromSeconds(2)));
        Assert.Contains("ScreenFrameCache", error.ObjectName, StringComparison.Ordinal);
    }

    [Fact]
    public async Task RuntimeDisposalIsIdempotentWithoutStartingDeviceOrWebOperations()
    {
        var root = Path.Combine(Path.GetTempPath(), "adb-map-controller-lifecycle", Guid.NewGuid().ToString("N"));
        var runtime = new ControllerRuntime(root);

        await runtime.DisposeAsync();
        await runtime.DisposeAsync();

        Assert.False(Directory.Exists(root));
    }

    [Theory]
    [InlineData(ControllerOperationKind.Movement, false)]
    [InlineData(ControllerOperationKind.Entry, false)]
    [InlineData(ControllerOperationKind.Movement, true)]
    public Task MainFormShutdownDrainsApplicationOperation(ControllerOperationKind kind, bool fail) => OnUiThread(async () =>
    {
        var root = Path.Combine(Path.GetTempPath(), "adb-map-controller-close", Guid.NewGuid().ToString("N"));
        var runtime = new ControllerRuntime(root);
        using var form = new MainForm(runtime, new MemorySettingsStore());
        var flags = BindingFlags.Instance | BindingFlags.NonPublic;
        var operations = (ControllerOperations)typeof(MainForm).GetField("operations", flags)!.GetValue(form)!;
        var finish = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        CancellationToken owner = default;
        var operation = operations.RunAsync(kind, token => { owner = token; return finish.Task; });
        try
        {
            var shutdown = (Task)typeof(MainForm).GetMethod("ShutdownAsync", flags)!.Invoke(form, null)!;
            Assert.True(owner.IsCancellationRequested);
            Assert.False(shutdown.IsCompleted);
            await Assert.ThrowsAsync<InvalidOperationException>(() => operations.RunAsync(kind, _ => Task.CompletedTask));
            if (fail) finish.SetException(new IOException("operation failed during shutdown"));
            else finish.SetResult();
            if (fail) await Assert.ThrowsAsync<IOException>(() => operation);
            else await operation;
            await shutdown.WaitAsync(TimeSpan.FromSeconds(5));
            await runtime.DisposeAsync();
            Assert.True(form.IsDisposed);
        }
        finally { finish.TrySetResult(); }
    });
}
