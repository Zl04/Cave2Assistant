namespace AdbMapController.Tests;

[Collection("JSON diagnostics")]
public sealed class BoundedDiagnosticRegressionTests
{
    [Fact]
    public void JsonDiagnosticBacklogRetainsRecentBoundedMessages()
    {
        JsonDiagnostics.Drain();
        for (var index = 0; index < 300; index++) JsonDiagnostics.Record(index.ToString(), new string('x', 1000));
        var messages = JsonDiagnostics.Drain();
        Assert.Equal(128, messages.Count);
        Assert.All(messages, message => Assert.Equal(512, message.Length));
        Assert.StartsWith("299:", messages[^1]);
        Assert.Empty(JsonDiagnostics.Drain());
    }

    [Fact]
    public void FloorTransitionHistoryIsBoundedAndResetWithSession()
    {
        var session = new DungeonSession();
        for (var index = 0; index < 300; index++)
        {
            session.FloorState.Set(FloorPhase.Explore);
            session.FloorState.Transition(FloorPhase.SelectBonus);
        }
        Assert.Equal(128, session.FloorState.InvalidTransitions.Count);
        session.Reset();
        Assert.Empty(session.FloorState.InvalidTransitions);
        Assert.Equal(FloorPhase.Explore, session.FloorState.Current);
    }
}
