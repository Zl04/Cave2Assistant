using System.Text.RegularExpressions;

namespace AdbMapController;

internal enum LogLevel { Info, Warning, Error }

internal sealed record LogEntry(DateTime Timestamp, LogLevel Level, string Message)
{
    public string DisplayText => $"[{Timestamp:HH:mm:ss}] [{Level.ToString().ToLowerInvariant()}] {Message}";
}

internal sealed class LogFilter
{
    readonly string search;
    readonly HashSet<LogLevel> levels;
    readonly Regex? regex;
    public string? Error { get; private set; }

    public void StopForTimeout() => Error = "正则匹配超时，请简化搜索条件";

    public LogFilter(string search, bool useRegex, IEnumerable<LogLevel> levels)
    {
        this.search = search;
        this.levels = levels.ToHashSet();
        if (!useRegex || search.Length == 0) return;
        try
        {
            regex = new Regex(search, RegexOptions.IgnoreCase | RegexOptions.CultureInvariant,
                TimeSpan.FromMilliseconds(50));
        }
        catch (ArgumentException) { Error = "正则表达式无效，请修改搜索条件"; }
    }

    public bool Matches(LogEntry entry)
    {
        if (Error != null || !levels.Contains(entry.Level)) return false;
        if (search.Length == 0) return true;
        if (regex == null) return entry.DisplayText.Contains(search, StringComparison.OrdinalIgnoreCase);
        try { return regex.IsMatch(entry.DisplayText); }
        catch (RegexMatchTimeoutException)
        {
            StopForTimeout();
            return false;
        }
    }
}
