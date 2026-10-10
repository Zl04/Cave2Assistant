using Xunit;

namespace AdbMapController.Tests;

public sealed class MapRunTaskTests
{
    static MapDump Map(int scene, int level, int town = 0) => new()
    { SceneType = scene, Level = level, TownMapId = town, Width = 10, Height = 10 };

    [Theory]
    [InlineData(1, 9001, 0)]
    [InlineData(7, 6001, 0)]
    [InlineData(7, 6101, 0)]
    [InlineData(-1, 0, 10001)]
    [InlineData(-1, 0, 10002)]
    public void ReturnCompletesOnlyAfterEnteringMap(int scene, int level, int town)
    {
        var task = new MapRunTask();
        var destination = Map(scene, level, town);
        Assert.False(task.Observe(destination));
        Assert.False(task.Observe(Map(2, 1)));
        Assert.True(task.Observe(destination));
    }

    [Theory]
    [InlineData(2, 6001)]
    [InlineData(2, 9001)]
    [InlineData(1, 9091)]
    [InlineData(7, 6002)]
    public void OtherMapsDoNotCompleteTask(int scene, int level)
    {
        var task = new MapRunTask();
        task.Observe(Map(2, 1));
        Assert.False(task.Observe(Map(scene, level)));
    }
}
