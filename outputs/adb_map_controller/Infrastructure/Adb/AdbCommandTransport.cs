using System.Diagnostics;

namespace AdbMapController;

/// <summary>
/// Owns ADB process execution and the persistent privileged shell. It knows
/// nothing about maps, OCR, touch coordinates, popups, or assistant scripts.
/// </summary>
internal sealed class AdbCommandTransport : IDisposable
{
    const int CommandTimeoutMs = 5000;
    const int PersistentShellTimeoutMs = 3000;

    readonly SemaphoreSlim rootShellLock = new(1, 1);
    readonly object processGate = new();
    readonly HashSet<Process> commands = [];
    int disposed;
    Process? rootShell;
    long rootCommandId;
    bool runsAsRoot;
    string serial = "emulator-5556";

    public string Serial
    {
        get => serial;
        set
        {
            rootShellLock.Wait();
            try
            {
                ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
                if (serial == value) return;
                serial = value;
                runsAsRoot = false;
                DisposeRootShell();
            }
            finally { rootShellLock.Release(); }
        }
    }

    public bool RunsAsRoot => runsAsRoot;

    public async Task<string> RunAsync(params string[] args)
    {
        ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
        var psi = new ProcessStartInfo("adb")
        {
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            UseShellExecute = false,
            CreateNoWindow = true,
        };
        psi.ArgumentList.Add("-s");
        psi.ArgumentList.Add(Serial);
        foreach (var arg in args) psi.ArgumentList.Add(arg);
        Process process;
        lock (processGate)
        {
            ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
            process = Process.Start(psi) ?? throw new InvalidOperationException("无法启动 adb");
            commands.Add(process);
        }
        try
        {
            var stdout = process.StandardOutput.ReadToEndAsync();
            var stderr = process.StandardError.ReadToEndAsync();
            try
            {
                await process.WaitForExitAsync().WaitAsync(TimeSpan.FromMilliseconds(CommandTimeoutMs)).ConfigureAwait(false);
            }
            catch (TimeoutException)
            {
                try { if (!process.HasExited) process.Kill(entireProcessTree: true); } catch { }
                throw new TimeoutException($"ADB 命令超时（>{CommandTimeoutMs}ms）");
            }
            var error = await stderr.ConfigureAwait(false);
            if (process.ExitCode != 0) throw new InvalidOperationException(error.Trim());
            return await stdout.ConfigureAwait(false);
        }
        finally
        {
            lock (processGate) commands.Remove(process);
            process.Dispose();
        }
    }

    public async Task<string> RunRootAsync(string command)
    {
        if (!await rootShellLock.WaitAsync(TimeSpan.FromMilliseconds(PersistentShellTimeoutMs)).ConfigureAwait(false))
            throw new TimeoutException($"Root ADB 命令锁等待超时（>{PersistentShellTimeoutMs}ms）");
        try
        {
            ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
            EnsureRootShell();
            var marker = $"__CODEX_DONE_{Interlocked.Increment(ref rootCommandId)}__";
            await rootShell!.StandardInput.WriteLineAsync(command).ConfigureAwait(false);
            await rootShell.StandardInput.WriteLineAsync($"__codex_status=$?; printf '\\n{marker}:%s\\n' \"$__codex_status\"").ConfigureAwait(false);
            await rootShell.StandardInput.FlushAsync().ConfigureAwait(false);
            var lines = new List<string>();
            while (true)
            {
                var line = await rootShell.StandardOutput.ReadLineAsync()
                    .WaitAsync(TimeSpan.FromMilliseconds(PersistentShellTimeoutMs)).ConfigureAwait(false)
                    ?? throw new IOException("持续 Root ADB shell 已断开");
                if (line.StartsWith(marker + ":", StringComparison.Ordinal))
                {
                    if (!line.EndsWith(":0", StringComparison.Ordinal))
                        throw new InvalidOperationException($"Root 命令失败（状态 {line[(marker.Length + 1)..]}）");
                    return string.Join('\n', lines);
                }
                lines.Add(line);
            }
        }
        catch
        {
            DisposeRootShell();
            throw;
        }
        finally { rootShellLock.Release(); }
    }

    public async Task<List<string>> ListDevicesAsync()
    {
        var text = await RunAsync("devices");
        return text.Split('\n').Skip(1).Select(value => value.Trim().Split('\t'))
            .Where(value => value.Length == 2 && value[1] == "device")
            .Select(value => value[0]).ToList();
    }

    public async Task<bool> EnableRootAsync()
    {
        ResetSession();
        try
        {
            await RunAsync("root");
            await RunAsync("wait-for-device");
            var identity = await RunAsync("shell", "id");
            runsAsRoot = identity.Contains("uid=0", StringComparison.Ordinal);
        }
        catch { runsAsRoot = false; }
        return runsAsRoot;
    }

    public void ResetSession()
    {
        rootShellLock.Wait();
        try { runsAsRoot = false; DisposeRootShell(); }
        finally { rootShellLock.Release(); }
    }

    void EnsureRootShell()
    {
        if (rootShell is { HasExited: false }) return;
        DisposeRootShell();
        var psi = new ProcessStartInfo("adb")
        {
            RedirectStandardInput = true,
            RedirectStandardOutput = true,
            UseShellExecute = false,
            CreateNoWindow = true,
        };
        psi.ArgumentList.Add("-s");
        psi.ArgumentList.Add(Serial);
        psi.ArgumentList.Add("shell");
        if (!runsAsRoot)
        {
            psi.ArgumentList.Add("su");
            psi.ArgumentList.Add("0");
        }
        psi.ArgumentList.Add("sh");
        rootShell = Process.Start(psi) ?? throw new InvalidOperationException("无法建立持续 Root ADB shell");
    }

    void DisposeRootShell()
    {
        var process = rootShell;
        rootShell = null;
        if (process is null) return;
        try { if (!process.HasExited) process.Kill(true); } catch { }
        process.Dispose();
    }

    public void Dispose()
    {
        if (Interlocked.Exchange(ref disposed, 1) != 0) return;
        lock (processGate)
            foreach (var process in commands)
                try { if (!process.HasExited) process.Kill(entireProcessTree: true); } catch { }
        ResetSession();
        // Keep admission synchronization valid for queued callers, which must
        // reject disposal rather than release an already disposed semaphore.
    }
}
