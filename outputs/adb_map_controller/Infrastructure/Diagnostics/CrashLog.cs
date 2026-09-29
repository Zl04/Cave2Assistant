using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;

namespace AdbMapController;

internal static class CrashLog
{
    static readonly object Gate = new();

    // 日志记录绝不能用 I/O 异常替换原始故障。
    internal static string? Write(string context, Exception exception)
    {
        try
        {
            lock (Gate)
            {
                var directory = Path.Combine(AppContext.BaseDirectory, "logs");
                Directory.CreateDirectory(directory);
                var path = Path.Combine(directory, $"errors-{DateTime.Now:yyyyMMdd}.log");
                if (File.Exists(path) && new FileInfo(path).Length > 4 * 1024 * 1024)
                    File.Move(path, path + ".previous", true);
                File.AppendAllText(path,
                    $"[{DateTimeOffset.Now:O}] {context}\n" +
                    $"Process: {Environment.ProcessPath}; PID: {Environment.ProcessId}\n" +
                    $"Runtime: {RuntimeInformation.FrameworkDescription}; Architecture: {RuntimeInformation.ProcessArchitecture}\n" +
                    $"Build: {File.GetLastWriteTimeUtc(typeof(CrashLog).Assembly.Location):O}\n" +
                    $"{exception}\n\n");
                return path;
            }
        }
        catch (Exception loggingError)
        {
            Debug.WriteLine(loggingError);
            return null;
        }
    }
}
