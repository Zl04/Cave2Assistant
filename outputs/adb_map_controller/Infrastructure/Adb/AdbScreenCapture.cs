using System.Diagnostics;
using System.Drawing;

namespace AdbMapController;

internal sealed class AdbScreenCapture : IDisposable
{
    const int TimeoutMs = 5000;
    readonly SemaphoreSlim captureLock = new(1, 1);

    public async Task<Bitmap> CaptureAsync(
        string serial,
        string errorMessage,
        CancellationToken token = default)
    {
        await captureLock.WaitAsync(token);
        try
        {
            var psi = new ProcessStartInfo("adb")
            {
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
                CreateNoWindow = true,
                ErrorDialog = false,
            };
            psi.ArgumentList.Add("-s");
            psi.ArgumentList.Add(serial);
            psi.ArgumentList.Add("exec-out");
            psi.ArgumentList.Add("screencap");
            psi.ArgumentList.Add("-p");
            using var process = Process.Start(psi) ?? throw new InvalidOperationException(errorMessage);
            using var data = new MemoryStream();
            var copyTask = process.StandardOutput.BaseStream.CopyToAsync(data, token);
            var errorTask = process.StandardError.ReadToEndAsync(token);
            try
            {
                await process.WaitForExitAsync(token).WaitAsync(TimeSpan.FromMilliseconds(TimeoutMs), token);
                await copyTask.WaitAsync(TimeSpan.FromMilliseconds(TimeoutMs), token);
            }
            catch (TimeoutException)
            {
                try { if (!process.HasExited) process.Kill(entireProcessTree: true); } catch { }
                throw new TimeoutException($"ADB 截图超时（>{TimeoutMs}ms），已终止卡住的 adb 进程");
            }
            catch (OperationCanceledException)
            {
                try { if (!process.HasExited) process.Kill(entireProcessTree: true); } catch { }
                throw;
            }
            var error = (await errorTask).Trim();
            if (process.ExitCode != 0)
                throw new InvalidOperationException(string.IsNullOrWhiteSpace(error)
                    ? errorMessage
                    : $"{errorMessage}：{error}");
            if (data.Length == 0) throw new InvalidDataException($"{errorMessage}：ADB 返回了空截图");
            data.Position = 0;
            using var captured = new Bitmap(data);
            return new Bitmap(captured);
        }
        finally { captureLock.Release(); }
    }

    public void Dispose() => captureLock.Dispose();
}
