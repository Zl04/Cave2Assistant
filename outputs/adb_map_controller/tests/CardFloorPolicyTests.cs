namespace AdbMapController.Tests;

public sealed class CardFloorPolicyTests
{
    [Theory]
    [InlineData(1, 180)]
    [InlineData(4, 30)]
    [InlineData(8, 30)]
    [InlineData(9, 70)]
    [InlineData(12, 50)]
    [InlineData(14, 20)]
    [InlineData(16, 10)]
    public void AllInteractionsAreIncludedOnlyAboveMapMaximum(int mode, int maximum)
    {
        var map = new MapDump { CaveMode = mode, Level = maximum - 1 };
        Assert.Equal(maximum, CardFloorPolicy.MaximumFloor(map));
        Assert.False(FloorPlanningPolicy.IncludeAllInteractions(map));
        map.Level = maximum;
        Assert.False(FloorPlanningPolicy.IncludeAllInteractions(map));
        map.Level++;
        Assert.True(FloorPlanningPolicy.IncludeAllInteractions(map));
    }

    [Fact]
    public void UnknownMapDoesNotOverrideSelectedInteractions()
        => Assert.False(FloorPlanningPolicy.IncludeAllInteractions(new MapDump { CaveMode = -1, Level = 6101 }));

    [Theory]
    [InlineData(1)]
    [InlineData(9)]
    [InlineData(10)]
    [InlineData(11)]
    public void PrimordialTrialStopsAtTenRegardlessOfLocalizedMapName(int floor)
        => Assert.Equal(10, CardFloorPolicy.Resolve(new MapDump
        {
            CaveMode = 16, MapName = "极寒之地", Level = floor,
        }));

    [Fact]
    public void PrimordialTrialWithoutValidFloorHasNoTarget()
        => Assert.Null(CardFloorPolicy.Resolve(new MapDump { CaveMode = 16, Level = 0 }));
}
