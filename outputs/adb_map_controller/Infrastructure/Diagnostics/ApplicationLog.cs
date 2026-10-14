using System.Diagnostics;

namespace AdbMapController;

internal static class ApplicationLog
{
    static readonly object Gate = new();

    internal static void Write(LogEntry entry)
    {
        try
        {
            lock (Gate)
            {
                var directory = Path.Combine(AppContext.BaseDirectory, "logs");
                Directory.CreateDirectory(directory);
                var path = Path.Combine(directory, $"application-{entry.Timestamp:yyyyMMdd}.log");
                File.AppendAllText(path, entry.DisplayText + Environment.NewLine);
            }
        }
        catch (Exception error)
        {
            Debug.WriteLine(error);
        }
    }
}
