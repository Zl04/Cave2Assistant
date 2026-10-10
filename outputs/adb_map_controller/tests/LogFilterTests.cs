namespace AdbMapController.Tests;

public sealed class LogFilterTests
{
    static LogEntry Entry(LogLevel level, string message) => new(new DateTime(2026, 10, 10, 12, 34, 56), level, message);

    [Fact]
    public void LiteralSearchAndLevelsAreCombinedAndCaseInsensitive()
    {
        var filter = new LogFilter("ROOT [1]", false, [LogLevel.Warning, LogLevel.Error]);
        Assert.True(filter.Matches(Entry(LogLevel.Warning, "Root [1] 尚未就绪")));
        Assert.True(filter.Matches(Entry(LogLevel.Error, "Root [1] 连接失败")));
        Assert.False(filter.Matches(Entry(LogLevel.Info, "Root [1] 已连接")));
        Assert.False(filter.Matches(Entry(LogLevel.Warning, "Root 1 尚未就绪")));
    }

    [Fact]
    public void RegexCanMatchAlternativesAndLevelLabels()
    {
        var filter = new LogFilter(@"\[warning\].*(超时|受阻)", true, Enum.GetValues<LogLevel>());
        Assert.True(filter.Matches(Entry(LogLevel.Warning, "移动超时")));
        Assert.True(filter.Matches(Entry(LogLevel.Warning, "移动受阻")));
        Assert.False(filter.Matches(Entry(LogLevel.Error, "移动超时")));
        Assert.False(filter.Matches(Entry(LogLevel.Warning, "移动完成")));
    }

    [Fact]
    public void EmptySearchAndDisabledLevelsWorkIndependently()
    {
        var entry = Entry(LogLevel.Info, "地图已刷新");
        Assert.True(new LogFilter("", true, [LogLevel.Info]).Matches(entry));
        Assert.False(new LogFilter("", false, []).Matches(entry));
    }

    [Fact]
    public void InvalidRegexIsReportedAndEditingRecovers()
    {
        var entry = Entry(LogLevel.Info, "地图已刷新");
        var invalid = new LogFilter("[", true, Enum.GetValues<LogLevel>());
        Assert.NotNull(invalid.Error);
        Assert.False(invalid.Matches(entry));
        var corrected = new LogFilter("地图", true, Enum.GetValues<LogLevel>());
        Assert.Null(corrected.Error);
        Assert.True(corrected.Matches(entry));
        Assert.Equal("[12:34:56] [info] 地图已刷新", entry.DisplayText);
    }

    [Fact]
    public void PathologicalRegexTimesOutAndStopsFurtherMatching()
    {
        var filter = new LogFilter("(a+)+$", true, [LogLevel.Info]);
        Assert.False(filter.Matches(Entry(LogLevel.Info, new string('a', 100000) + "!")));
        Assert.Contains("超时", filter.Error);
        Assert.False(filter.Matches(Entry(LogLevel.Info, "aaa")));
    }
}
