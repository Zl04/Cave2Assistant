using System.Text.Json;
namespace AdbMapController.Tests;

// These tests freeze compatibility quirks, not desirable new business rules.
[CollectionDefinition("JSON diagnostics", DisableParallelization = true)]
public sealed class JsonDiagnosticCollection { }

[Collection("JSON diagnostics")]
public sealed class StateAndJsonBaselineTests
{
    [Fact]
    public void IllegalFloorTransitionIsRecordedButApplied()
    {
        var state = new FloorStateMachine();
        Assert.True(state.Transition(FloorPhase.SelectBonus));
        Assert.Equal(FloorPhase.SelectBonus, state.Current);
        Assert.Equal("Explore->SelectBonus", Assert.Single(state.InvalidTransitions));
        state.Transition(FloorPhase.SelectBonus);
        Assert.Single(state.InvalidTransitions);
    }

    [Fact]
    public void ExplicitSetBypassesTransitionDiagnostics()
    {
        var state = new FloorStateMachine();
        state.Set(FloorPhase.SelectBonus);
        Assert.Empty(state.InvalidTransitions);
        state.Transition(FloorPhase.VerifyTransition);
        Assert.Empty(state.InvalidTransitions);
    }

    [Fact]
    public void StopRetainsMapMechanismsAndSpeedButResetDoesNot()
    {
        var map = new MapDump { Level = 7 };
        var state = new DungeonSession { Map = map, ObservedLevel = 7, FloorChangedAt = 123 };
        state.Mechanisms.Add(new Cell(1, 1));
        state.InteractedChambers.Add(new Cell(2, 2));
        state.RouteExecution.MoveSpeed = 2400;
        state.RouteExecution.PulseFallback = true;
        state.MotionInterrupt.Request(MovementPopupKind.ServerError);
        state.StopAutomation();
        Assert.Same(map, state.Map);
        Assert.Equal(7, state.ObservedLevel);
        Assert.Equal(123, state.FloorChangedAt);
        Assert.Contains(new Cell(2, 2), state.InteractedChambers);
        Assert.Equal(2400, state.RouteExecution.MoveSpeed);
        Assert.False(state.RouteExecution.PulseFallback);
        Assert.Equal(MotionInterruptReason.None, state.MotionInterrupt.Reason);
        state.Reset();
        Assert.Null(state.Map);
        Assert.Empty(state.InteractedChambers);
        Assert.Equal(1000, state.RouteExecution.MoveSpeed);
        Assert.Equal(0, state.FloorChangedAt);
    }

    [Fact]
    public void InterruptFirstWinnerCopiesCardsAndClearAllowsNewWinner()
    {
        var state = new MotionInterruptState();
        var cards = new List<int> { 2, 3 };
        Assert.False(state.Request(MovementPopupKind.None));
        Assert.True(state.Request(MovementPopupKind.NextFloorDialog, NextFloorDialogKind.GreedySelection, true, cards));
        cards.Clear();
        Assert.False(state.Request(MovementPopupKind.ServerError));
        Assert.Equal(new[] { 2, 3 }, state.GreedySelectionReturnCards);
        Assert.True(state.GreedySelectionReturnOnly);
        state.Clear();
        Assert.Empty(state.GreedySelectionReturnCards);
        Assert.True(state.Request(MovementPopupKind.ServerError));
    }

    [Fact]
    public async Task ConcurrentInterruptRequestsHaveExactlyOneWinner()
    {
        var state = new MotionInterruptState();
        var results = await Task.WhenAll(Enumerable.Range(0, 32).Select(_ => Task.Run(() => state.Request(MovementPopupKind.ServerError))));
        Assert.Single(results, x => x);
    }

    [Theory]
    [InlineData("\"12\"", 12, false)]
    [InlineData("true", 1, false)]
    [InlineData("false", 0, true)]
    [InlineData("2147483648", 0, true)]
    [InlineData("\"bad\"", 0, true)]
    public void FlexibleIntPreservesDefaults(string json, int expected, bool diagnostic)
    {
        JsonDiagnostics.Drain();
        var options = new JsonSerializerOptions();
        options.Converters.Add(new FlexibleIntConverter());
        Assert.Equal(expected, JsonSerializer.Deserialize<int>(json, options));
        Assert.Equal(diagnostic, JsonDiagnostics.Drain().Count > 0);
    }

    [Fact]
    public void InvalidTileFixtureKeepsLegacyFallbacksAndDiagnostics()
    {
        JsonDiagnostics.Drain();
        var json = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "Fixtures", "tolerant-tile.json"));
        var tile = JsonSerializer.Deserialize<TileInfo>(json)!;
        Assert.Equal(2, tile.X);
        Assert.Equal(0, tile.Y);
        Assert.Equal(1, tile.TerrainType);
        Assert.False(tile.Explored);
        Assert.Empty(tile.Roles);
        Assert.Empty(tile.Placeholders);
        Assert.Equal(5, JsonDiagnostics.Drain().Count);
    }

    [Fact]
    public void FalseTileMeansWallAndTileWriteRemainsUnsupported()
    {
        Assert.Equal(1, JsonSerializer.Deserialize<TileInfo>("false")!.TerrainType);
        // Reference-type converters default to HandleNull=false: root JSON null
        // bypasses TileInfoConverter.Read, despite its explicit Null branch.
        Assert.Null(JsonSerializer.Deserialize<TileInfo>("null"));
        Assert.Throws<NotSupportedException>(() => JsonSerializer.Serialize(new TileInfo()));
    }

    [Fact]
    public void DifferentFloorDoesNotApplyPlayerOrFog()
    {
        var player = new PlayerInfo { X = 1 };
        var tile = new TileInfo { X = 0, Y = 0 };
        var map = new MapDump { Level = 1, Width = 1, Height = 1, Player = player, Tiles = [[tile]] };
        RouteExecutor.ApplyPlayerStatus(map, new PlayerStatus { Level = 2, Width = 1, Height = 1, FogBits = "1", Player = new PlayerInfo { X = 9 } });
        Assert.Same(player, map.Player);
        Assert.False(tile.Explored);
    }

    [Fact]
    public void ClearingConfusionClearsDirectionsButBadFogLengthIsIgnored()
    {
        var tile = new TileInfo { X = 0, Y = 0 };
        var map = new MapDump { Level = 1, Width = 1, Height = 1, Confused = true, ConfuseDirections = [3, 2], Tiles = [[tile]] };
        RouteExecutor.ApplyPlayerStatus(map, new PlayerStatus { Level = 1, Width = 1, Height = 1, AllExplored = true, FogBits = "" });
        Assert.False(map.Confused);
        Assert.Empty(map.ConfuseDirections);
        Assert.False(tile.Explored); // AllExplored does not bypass the length guard.
    }

    [Fact]
    public void SnapshotMetadataIsCapturedButMapReferenceRemainsMutable()
    {
        var map = new MapDump { Level = 1, Player = new PlayerInfo { X = 1 } };
        var snapshot = MapSnapshot.Capture(map);
        map.Level = 2; map.Player.X = 9;
        Assert.Same(map, snapshot.Map);
        Assert.Equal(1, snapshot.Level);
        Assert.Equal(new Cell(1, 0), snapshot.Player);
        Assert.Equal(2, snapshot.Map.Level);
    }

    [Theory]
    [InlineData(MovementPopupKind.None, 0)]
    [InlineData(MovementPopupKind.ServerError, 1)]
    [InlineData(MovementPopupKind.RiftGemSelection, 1)]
    [InlineData(MovementPopupKind.NextFloorDialog, 1)]
    public void PopupConfirmationThresholdIsCompatibilityPolicy(MovementPopupKind kind, int frames)
        => Assert.Equal(frames, PopupDetectionPolicy.RequiredConsecutiveFrames(kind));
}
