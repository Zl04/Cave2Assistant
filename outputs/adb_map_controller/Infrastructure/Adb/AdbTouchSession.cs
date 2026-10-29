using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// Owns device selection, touch-backend startup and coordinate-based input for one ADB session.
/// Command execution remains owned by <see cref="AdbCommandTransport"/>.
/// </summary>
internal sealed class AdbTouchSession : IDisposable
{
    readonly AdbCommandTransport transport;
    readonly Action serialChanged;
    readonly SemaphoreSlim connectionLock = new(1, 1);
    readonly SemaphoreSlim payloadLock = new(1, 1);
    IAndroidTouchBackend? backend;
    bool payloadsReady;
    int screenWidth;
    int screenHeight;
    int orientation;
    int androidSdk;
    int maxContacts;
    string? backendDescription;
    int disposed;
    Action<string>? timingLog;

    public Action<string>? TimingLog
    {
        get => timingLog;
        set
        {
            timingLog = value;
            if (backend is not null) backend.TimingLog = value;
        }
    }

    public AdbTouchSession(AdbCommandTransport transport, Action serialChanged)
    {
        this.transport = transport ?? throw new ArgumentNullException(nameof(transport));
        this.serialChanged = serialChanged ?? throw new ArgumentNullException(nameof(serialChanged));
    }

    public string Serial => transport.Serial;
    public bool IsReady => payloadsReady && backend is not null;
    public string Description => screenWidth == 0 || backendDescription is null
        ? "未检测"
        : backendDescription;

    public Task<List<string>> DevicesAsync() => transport.ListDevicesAsync();
    public Task<bool> EnableRootAsync() => transport.EnableRootAsync();

    public async Task<bool> ConnectAsync(string deviceSerial)
    {
        ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
        if (string.IsNullOrWhiteSpace(deviceSerial))
            throw new ArgumentException("设备序列号不能为空", nameof(deviceSerial));

        await connectionLock.WaitAsync().ConfigureAwait(false);
        try
        {
            ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
            if (!string.Equals(Serial, deviceSerial, StringComparison.Ordinal))
            {
                transport.Serial = deviceSerial;
                serialChanged();
                ResetSession();
            }
            if (IsReady) return transport.RunsAsRoot;

            var directRoot = await EnableRootAsync().ConfigureAwait(false);
            await InitializeBackendAsync().ConfigureAwait(false);
            return directRoot;
        }
        finally { connectionLock.Release(); }
    }

    public void ResetSession()
    {
        payloadsReady = false;
        screenWidth = screenHeight = 0;
        orientation = androidSdk = 0;
        backendDescription = null;
        maxContacts = 0;
        DisposeBackend();
    }

    async Task InitializeBackendAsync()
    {
        await payloadLock.WaitAsync().ConfigureAwait(false);
        try
        {
            var size = await transport.RunAsync("shell", "wm", "size").ConfigureAwait(false);
            var matches = Regex.Matches(size, @"(?<width>\d+)x(?<height>\d+)");
            if (matches.Count == 0) throw new InvalidOperationException("无法读取设备屏幕尺寸");
            var selected = matches[^1];
            var a = int.Parse(selected.Groups["width"].Value);
            var b = int.Parse(selected.Groups["height"].Value);
            screenWidth = Math.Max(a, b); screenHeight = Math.Min(a, b);
            var sdkText = await transport.RunAsync("shell", "getprop", "ro.build.version.sdk").ConfigureAwait(false);
            _ = int.TryParse(sdkText.Trim(), out androidSdk);
            var inputState = await transport.RunAsync("shell", "dumpsys", "input").ConfigureAwait(false);
            var viewport = Regex.Match(inputState,
                @"Viewport: displayId=0, orientation=(?<orientation>[0-3]), logicalFrame=\[0, 0, (?<width>\d+), (?<height>\d+)\]");
            orientation = viewport.Success &&
                int.Parse(viewport.Groups["width"].Value) == screenWidth &&
                int.Parse(viewport.Groups["height"].Value) == screenHeight
                    ? int.Parse(viewport.Groups["orientation"].Value) : 0;
            var backends = androidSdk >= 29
                ? new IAndroidTouchBackend[]
                {
                    new MaaTouchBackend(Serial, RunAdbAsync),
                    new MinitouchBackend(Serial, RunAdbAsync)
                }
                : new IAndroidTouchBackend[]
                {
                    new MinitouchBackend(Serial, RunAdbAsync),
                    new MaaTouchBackend(Serial, RunAdbAsync)
                };
            var failures = new List<Exception>();
            foreach (var candidate in backends)
            {
                try
                {
                    var info = await candidate.StartAsync(screenWidth, screenHeight, orientation).ConfigureAwait(false);
                    backend = candidate;
                    backend.TimingLog = timingLog;
                    maxContacts = info.MaxContacts;
                    backendDescription = $"{info.Name} ({screenWidth}x{screenHeight}, Android API {androidSdk}, 触点 {info.MaxContacts})";
                    payloadsReady = true;
                    return;
                }
                catch (Exception ex)
                {
                    failures.Add(new InvalidOperationException($"{candidate.Name}: {ex.Message}", ex));
                    candidate.Dispose();
                }
            }
            throw new InvalidOperationException(
                $"无法启动 Android 触控后端（API {androidSdk}）。" + Environment.NewLine +
                string.Join(Environment.NewLine, failures.Select(x => x.Message)), failures.FirstOrDefault());
        }
        finally { payloadLock.Release(); }
    }

    Task<string> RunAdbAsync(string[] args) => transport.RunAsync(args);

    void RequireReady()
    {
        ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
        if (!IsReady)
            throw new InvalidOperationException("当前设备尚未连接或触控后端尚未启动");
    }

    public Task EnsureReady()
    {
        RequireReady();
        return Task.CompletedTask;
    }

    public (int X, int Y) TouchPoint(Cell delta)
        => TouchCoordinateMapper.ToPixels(delta, screenWidth, screenHeight);

    public Task SendTouchDown((int X, int Y) point)
        => backend?.TouchDownAsync(point) ?? throw new InvalidOperationException("Android 触控后端尚未启动");

    public Task SendTouchUp()
        => backend?.TouchUpAsync() ?? Task.CompletedTask;

    public Task SendTouchPulse((int X, int Y) point, int milliseconds)
        => backend?.SwipeAsync(point, point, milliseconds)
            ?? throw new InvalidOperationException("Android 触控后端尚未启动");

    public async Task TapScreen(double normalizedX, double normalizedY)
    {
        RequireReady();
        var x = Math.Clamp((int)Math.Round(normalizedX * screenWidth), 0, screenWidth - 1);
        var y = Math.Clamp((int)Math.Round(normalizedY * screenHeight), 0, screenHeight - 1);
        await (backend?.TapAsync((x, y))
            ?? throw new InvalidOperationException("Android 触控后端尚未启动")).ConfigureAwait(false);
    }

    public async Task TapScreenSecondary(double normalizedX, double normalizedY)
    {
        RequireReady();
        var x = Math.Clamp((int)Math.Round(normalizedX * screenWidth), 0, screenWidth - 1);
        var y = Math.Clamp((int)Math.Round(normalizedY * screenHeight), 0, screenHeight - 1);
        if (maxContacts >= 2)
            await backend!.TapSecondaryAsync((x, y)).ConfigureAwait(false);
        else
            await transport.RunAsync("shell", "input", "tap", x.ToString(), y.ToString()).ConfigureAwait(false);
    }

    /// <summary>
    /// Maps the assistant's original 720x1280 portrait coordinates to the current display.
    /// </summary>
    public async Task TapGameCoordinate(int x, int y)
    {
        RequireReady();
        var point = GameScreenCoordinates.ToDisplay(x, y, screenWidth, screenHeight);
        await (backend?.TapAsync((point.X, point.Y))
            ?? throw new InvalidOperationException("Android 触控后端尚未启动")).ConfigureAwait(false);
    }

    public async Task SwipeScreen(double normalizedX0, double normalizedY0,
        double normalizedX1, double normalizedY1, int durationMs)
    {
        RequireReady();
        var x0 = Math.Clamp((int)Math.Round(normalizedX0 * screenWidth), 0, screenWidth - 1);
        var y0 = Math.Clamp((int)Math.Round(normalizedY0 * screenHeight), 0, screenHeight - 1);
        var x1 = Math.Clamp((int)Math.Round(normalizedX1 * screenWidth), 0, screenWidth - 1);
        var y1 = Math.Clamp((int)Math.Round(normalizedY1 * screenHeight), 0, screenHeight - 1);
        await (backend?.SwipeAsync((x0, y0), (x1, y1), durationMs)
            ?? throw new InvalidOperationException("Android 触控后端尚未启动")).ConfigureAwait(false);
    }

    public Task PressBack() => transport.RunAsync("shell", "input", "keyevent", "4");

    void DisposeBackend()
    {
        var active = backend;
        backend = null;
        backendDescription = null;
        try { active?.Dispose(); } catch { }
    }

    public void Dispose()
    {
        if (Interlocked.Exchange(ref disposed, 1) != 0) return;
        connectionLock.Wait();
        try { ResetSession(); }
        finally { connectionLock.Release(); }
    }
}
