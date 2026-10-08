namespace AdbMapController.Tests;

public sealed class PortalLearningBaselineTests
{
    static readonly Cell Source = new(1, 1);
    static readonly Cell Destination = new(5, 1);
    static MapDump Map(Cell player, int level = 1) => new()
    {
        Level = level, MapName = "fixture", Width = 8, Height = 3,
        Player = new PlayerInfo { X = player.X, Y = player.Y },
        Tiles = [[new TileInfo { X = Source.X, Y = Source.Y, Roles = [Portal()] },
            new TileInfo { X = Destination.X, Y = Destination.Y, Roles = [Portal()] }]]
    };
    // Protocol literals are intentionally independent of implementation constants.
    static RoleInfo Portal(bool random = false) => new() { ClassName = "TriggerNpcData", RoleType = 1, MinimapType = 22, TransdoorType = 3, IsRandomTransfer = random };

    [Fact]
    public void LearnsAdjacentArrivalAndClearsAtReset()
    {
        var session = new DungeonSession();
        var before = Map(Source); var after = Map(new Cell(6, 1));
        Assert.True(session.PortalJumps.Observe(before, Source, after, out var target));
        Assert.Equal(Destination, target);
        Assert.Equal(new[] { Destination }, session.PortalJumps.ObservedTargets(after, Source));
        session.Reset();
        Assert.Empty(session.PortalJumps.ObservedTargets(after, Source));
    }

    [Theory]
    [InlineData(1, 1, 1)] // No displacement.
    [InlineData(7, 1, 1)] // More than one cell from a portal.
    [InlineData(5, 1, 2)] // Different floor.
    public void RejectsAmbiguousOrCrossFloorObservation(int x, int y, int level)
    {
        var graph = new PortalJumpGraph();
        Assert.False(graph.Observe(Map(Source), Source, Map(new Cell(x, y), level), out _));
        Assert.Equal(0, graph.EdgeCount(Map(Source)));
    }

    [Fact]
    public void OnlyRandomPortalFallsBackToUnobservedCandidates()
    {
        var graph = new PortalJumpGraph(); var map = Map(Source);
        Assert.Empty(graph.CandidateTargets(map, Source, Portal()));
        Assert.Equal(new[] { Destination }, graph.CandidateTargets(map, Source, Portal(true)));
    }
}
