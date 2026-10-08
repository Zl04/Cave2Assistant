namespace AdbMapController.Tests;

public sealed class DungeonSessionTests
{
    [Fact]
    public void ResetClearsDeviceScopedState()
    {
        var state = new DungeonSession
        {
            Map = new MapDump { Level = 8 },
            ObservedLevel = 8,
            PortalConfirmCount = 2,
            TargetFloorStopped = true,
            FloorMiningCompletedLevel = 8,
        };
        state.Route.Route = [new Cell(1, 1)];
        state.Blocked.Add(new Cell(2, 2));
        state.Reset();

        Assert.Null(state.Map);
        Assert.Empty(state.Route.Route);
        Assert.Empty(state.Blocked);
        Assert.Equal(-1, state.ObservedLevel);
        Assert.Equal(0, state.PortalConfirmCount);
        Assert.False(state.TargetFloorStopped);
        Assert.Equal(-1, state.FloorMiningCompletedLevel);
    }

}
