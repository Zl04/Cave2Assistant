using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

internal sealed record TouchBackendInfo(string Name, int MaxX, int MaxY, int MaxContacts);

internal interface IAndroidTouchBackend : IDisposable
{
    string Name { get; }
    Action<string>? TimingLog { get; set; }
    Task<TouchBackendInfo> StartAsync(int screenWidth, int screenHeight, int orientation);
    Task TouchDownAsync((int X, int Y) point);
    Task TouchUpAsync();
    Task TapAsync((int X, int Y) point);
    Task TapSecondaryAsync((int X, int Y) point);
    Task SwipeAsync((int X, int Y) from, (int X, int Y) to, int durationMs);
    Task ResetAsync();
}

/// <summary>
/// 面向行的 minitouch 协议共享实现。两个后端在传输方式和坐标空间上不同，
/// 但都刻意保持一个串行写入器，并将每个逻辑手势作为一个协议批次处理。
/// </summary>
internal abstract class LineTouchBackend : IAndroidTouchBackend
{
    public Action<string>? TimingLog { get; set; }
    protected readonly Func<string[], Task<string>> RunAdb;
    protected readonly string Serial;
    protected readonly SemaphoreSlim WriteLock = new(1, 1);
    protected StreamWriter? Writer;
    protected Process? AgentProcess;
    protected int ScreenWidth;
    protected int ScreenHeight;
    protected int Orientation;
    protected int RawMaxX;
    protected int RawMaxY;
    bool disposed;

    protected LineTouchBackend(string serial, Func<string[], Task<string>> runAdb)
    {
        Serial = serial;
        RunAdb = runAdb;
    }

    public abstract string Name { get; }

    public abstract Task<TouchBackendInfo> StartAsync(int screenWidth, int screenHeight, int orientation);

    protected abstract (int X, int Y) MapPoint((int X, int Y) point);

    protected async Task SendBatchAsync(params string[] commands)
    {
        await WriteLock.WaitAsync().ConfigureAwait(false);
        try
        {
            if (Writer is null) throw new IOException($"{Name} 触控进程未连接");
            foreach (var command in commands)
                await Writer.WriteLineAsync(command).ConfigureAwait(false);
            await Writer.FlushAsync().ConfigureAwait(false);
        }
        finally { WriteLock.Release(); }
    }

    public Task TouchDownAsync((int X, int Y) point)
    {
        var mapped = MapPoint(point);
        return SendBatchAsync($"d 0 {mapped.X} {mapped.Y} 255", "c");
    }

    public Task TouchUpAsync()
        => SendBatchAsync("u 0", "c");

    public Task TapAsync((int X, int Y) point)
    {
        var mapped = MapPoint(point);
        return SendBatchAsync($"d 0 {mapped.X} {mapped.Y} 255", "c", "u 0", "c");
    }

    public Task TapSecondaryAsync((int X, int Y) point)
    {
        var mapped = MapPoint(point);
        return SendBatchAsync($"d 1 {mapped.X} {mapped.Y} 255", "c", "u 1", "c");
    }

    public async Task SwipeAsync((int X, int Y) from, (int X, int Y) to, int durationMs)
    {
        var startedAt = Stopwatch.GetTimestamp();
        long ElapsedMs() => (long)Stopwatch.GetElapsedTime(startedAt).TotalMilliseconds;
        durationMs = Math.Clamp(durationMs, 1, 5000);
        var steps = Math.Clamp((int)Math.Ceiling(durationMs / 16d), 1, 320);
        var fromMapped = MapPoint(from);

        await WriteLock.WaitAsync().ConfigureAwait(false);
        try
        {
            TimingLog?.Invoke($"脉冲后端：写入锁等待={ElapsedMs()}ms，设定按住={durationMs}ms，步数={steps}");
            if (Writer is null) throw new IOException($"{Name} 触控进程未连接");
            await Writer.WriteLineAsync($"d 0 {fromMapped.X} {fromMapped.Y} 255").ConfigureAwait(false);
            await Writer.WriteLineAsync("c").ConfigureAwait(false);
            await Writer.FlushAsync().ConfigureAwait(false);
            var downAt = ElapsedMs();
            TimingLog?.Invoke($"脉冲后端：按下写入完成=+{downAt}ms");

            for (var step = 1; step <= steps; step++)
            {
                await Task.Delay(Math.Max(1, durationMs / steps)).ConfigureAwait(false);
                var progress = step / (double)steps;
                var point = (
                    X: (int)Math.Round(from.X + (to.X - from.X) * progress),
                    Y: (int)Math.Round(from.Y + (to.Y - from.Y) * progress));
                var mapped = MapPoint(point);
                await Writer.WriteLineAsync($"m 0 {mapped.X} {mapped.Y} 255").ConfigureAwait(false);
                await Writer.WriteLineAsync("c").ConfigureAwait(false);
                await Writer.FlushAsync().ConfigureAwait(false);
            }

            await Writer.WriteLineAsync("u 0").ConfigureAwait(false);
            await Writer.WriteLineAsync("c").ConfigureAwait(false);
            await Writer.FlushAsync().ConfigureAwait(false);
            TimingLog?.Invoke($"脉冲后端：松开写入完成=+{ElapsedMs()}ms，写入后按住={ElapsedMs() - downAt}ms");
        }
        finally { WriteLock.Release(); }
    }

    public Task ResetAsync() => SendBatchAsync("r");

    protected Process StartAdbProcess(params string[] args)
    {
        var psi = new ProcessStartInfo("adb")
        {
            RedirectStandardInput = true,
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            UseShellExecute = false,
            CreateNoWindow = true
        };
        psi.ArgumentList.Add("-s");
        psi.ArgumentList.Add(Serial);
        foreach (var arg in args) psi.ArgumentList.Add(arg);
        return Process.Start(psi) ?? throw new InvalidOperationException($"无法启动 {Name} 触控进程");
    }

    protected static async Task<string> ReadLineAsync(StreamReader reader, string description)
    {
        var line = await reader.ReadLineAsync().WaitAsync(TimeSpan.FromSeconds(5));
        return line ?? throw new EndOfStreamException($"{description} 提前关闭了协议流");
    }

    protected static bool TryParseLimits(string line, out int maxContacts, out int maxX, out int maxY)
    {
        var match = Regex.Match(line, @"^\^\s+(?<contacts>\d+)\s+(?<x>\d+)\s+(?<y>\d+)");
        if (!match.Success ||
            !int.TryParse(match.Groups["contacts"].Value, out maxContacts) ||
            !int.TryParse(match.Groups["x"].Value, out maxX) ||
            !int.TryParse(match.Groups["y"].Value, out maxY))
        {
            maxContacts = maxX = maxY = 0;
            return false;
        }
        return maxContacts > 0 && maxX > 0 && maxY > 0;
    }

    protected static int Scale(int value, int size, int rawMax)
        => Math.Clamp((int)Math.Round(value * rawMax / (double)Math.Max(1, size - 1)), 0, rawMax);

    protected void StopAgentProcess()
    {
        var process = AgentProcess;
        AgentProcess = null;
        if (process is null) return;
        try { process.StandardInput.Close(); } catch { }
        try
        {
            if (!process.HasExited && !process.WaitForExit(250)) process.Kill(true);
        }
        catch { }
        try { if (!process.HasExited) process.WaitForExit(500); } catch { }
        process.Dispose();
    }

    public virtual void Dispose()
    {
        if (disposed) return;
        disposed = true;
        try { Writer?.Dispose(); } catch { }
        Writer = null;
        StopAgentProcess();
        WriteLock.Dispose();
    }
}

internal sealed class MaaTouchBackend : LineTouchBackend
{
    static readonly Encoding Utf8 = new UTF8Encoding(false);
    string? remotePath;

    public MaaTouchBackend(string serial, Func<string[], Task<string>> runAdb)
        : base(serial, runAdb) { }

    public override string Name => "MaaTouch";

    protected override (int X, int Y) MapPoint((int X, int Y) point)
        => (Math.Clamp(point.X, 0, ScreenWidth - 1), Math.Clamp(point.Y, 0, ScreenHeight - 1));

    public override async Task<TouchBackendInfo> StartAsync(int screenWidth, int screenHeight, int orientation)
    {
        ScreenWidth = screenWidth;
        ScreenHeight = screenHeight;
        Orientation = orientation;
        remotePath = $"/data/local/tmp/codex_maatouch_{Guid.NewGuid():N}.apk";

        var asset = Path.Combine(AppContext.BaseDirectory, "TouchAgents", "bin", "maatouch", "universal", "maatouch");
        if (!File.Exists(asset)) throw new FileNotFoundException("MaaTouch 发布资源缺失", asset);

        await RunAdb(new[] { "push", asset, remotePath });
        AgentProcess = StartAdbProcess("shell", $"export CLASSPATH={remotePath}; exec app_process /data/local/tmp com.shxyke.MaaTouch.App");

        var stdout = AgentProcess.StandardOutput;
        var sawLimits = false;
        var sawPid = false;
        var maxContacts = 0;
        var maxX = 0;
        var maxY = 0;
        for (var i = 0; i < 6 && (!sawLimits || !sawPid); i++)
        {
            var line = await ReadLineAsync(stdout, "MaaTouch");
            if (TryParseLimits(line, out maxContacts, out maxX, out maxY)) sawLimits = true;
            if (line.StartsWith("$ ", StringComparison.Ordinal)) sawPid = true;
        }
        if (!sawLimits || !sawPid)
            throw new InvalidDataException("MaaTouch 未返回完整的触控协议头");

        Writer = new StreamWriter(AgentProcess.StandardInput.BaseStream, Utf8, 1024, leaveOpen: false)
        {
            AutoFlush = true,
            NewLine = "\n"
        };
        return new TouchBackendInfo(Name, maxX, maxY, maxContacts);
    }
}

internal sealed class MinitouchBackend : LineTouchBackend
{
    static readonly Encoding Utf8 = new UTF8Encoding(false);
    TcpClient? client;
    string? socketName;
    int forwardedPort;

    public MinitouchBackend(string serial, Func<string[], Task<string>> runAdb)
        : base(serial, runAdb) { }

    public override string Name => "minitouch";

    protected override (int X, int Y) MapPoint((int X, int Y) point)
        => TouchCoordinateMapper.ToRawTouchPixels(point, ScreenWidth, ScreenHeight, RawMaxX, RawMaxY, Orientation);

    public override async Task<TouchBackendInfo> StartAsync(int screenWidth, int screenHeight, int orientation)
    {
        ScreenWidth = screenWidth;
        ScreenHeight = screenHeight;
        Orientation = orientation;

        var abiOutput = await RunAdb(new[] { "shell", "getprop", "ro.product.cpu.abilist" });
        var abi = abiOutput.Split([',', '\r', '\n'], StringSplitOptions.RemoveEmptyEntries)
            .Select(x => x.Trim())
            .FirstOrDefault(x => File.Exists(Path.Combine(AppContext.BaseDirectory, "TouchAgents", "bin", "minitouch", x, "minitouch")));
        if (abi is null)
        {
            var singleAbi = (await RunAdb(new[] { "shell", "getprop", "ro.product.cpu.abi" })).Trim();
            if (File.Exists(Path.Combine(AppContext.BaseDirectory, "TouchAgents", "bin", "minitouch", singleAbi, "minitouch")))
                abi = singleAbi;
        }
        if (abi is null) throw new InvalidOperationException("没有匹配设备 ABI 的 minitouch 二进制");

        var asset = Path.Combine(AppContext.BaseDirectory, "TouchAgents", "bin", "minitouch", abi, "minitouch");
        var remotePath = $"/data/local/tmp/codex_minitouch_{Guid.NewGuid():N}";
        socketName = $"codex_minitouch_{Guid.NewGuid():N}";
        await RunAdb(new[] { "push", asset, remotePath });
        await RunAdb(new[] { "shell", "chmod", "700", remotePath });

        AgentProcess = StartAdbProcess("shell", remotePath, "-n", socketName);
        _ = AgentProcess.StandardOutput.ReadToEndAsync();
        _ = AgentProcess.StandardError.ReadToEndAsync();

        var forwardOutput = await RunAdb(new[] { "forward", "tcp:0", $"localabstract:{socketName}" });
        var portMatch = Regex.Match(forwardOutput, @"(?m)^\s*(?:tcp:)?(?<port>\d+)\s*$");
        if (!portMatch.Success || !int.TryParse(portMatch.Groups["port"].Value, out forwardedPort))
            throw new InvalidDataException($"无法解析 minitouch 端口：{forwardOutput.Trim()}");

        client = new TcpClient { NoDelay = true };
        await client.ConnectAsync("127.0.0.1", forwardedPort).WaitAsync(TimeSpan.FromSeconds(5));
        var stream = client.GetStream();
        using (var reader = new StreamReader(stream, Utf8, detectEncodingFromByteOrderMarks: false, 1024, leaveOpen: true))
        {
            var sawLimits = false;
            var sawPid = false;
            var maxContacts = 0;
            var maxX = 0;
            var maxY = 0;
            for (var i = 0; i < 6 && (!sawLimits || !sawPid); i++)
            {
                var line = await ReadLineAsync(reader, "minitouch");
                if (TryParseLimits(line, out maxContacts, out maxX, out maxY)) sawLimits = true;
                if (line.StartsWith("$ ", StringComparison.Ordinal)) sawPid = true;
            }
            if (!sawLimits || !sawPid)
                throw new InvalidDataException("minitouch 未返回完整的触控协议头");
            RawMaxX = maxX;
            RawMaxY = maxY;
            Writer = new StreamWriter(stream, Utf8, 1024, leaveOpen: true)
            {
                AutoFlush = true,
                NewLine = "\n"
            };
            return new TouchBackendInfo(Name, maxX, maxY, maxContacts);
        }
    }

    public override void Dispose()
    {
        try { client?.Close(); } catch { }
        client = null;
        base.Dispose();
        if (socketName is null) return;
        try
        {
            using var list = StartAdbProcess("forward", "--list");
            var forwards = list.StandardOutput.ReadToEnd();
            if (!list.WaitForExit(5000) || list.ExitCode != 0) return;
            foreach (var line in forwards.Split('\n'))
            {
                var parts = Regex.Split(line.Trim(), @"\s+");
                if (parts.Length != 3 || parts[0] != Serial ||
                    parts[2] != $"localabstract:{socketName}" ||
                    !Regex.IsMatch(parts[1], @"^tcp:\d+$")) continue;
                using var remove = StartAdbProcess("forward", "--remove", parts[1]);
                remove.WaitForExit(5000);
            }
        }
        catch { }
        finally { forwardedPort = 0; socketName = null; }
    }
}
