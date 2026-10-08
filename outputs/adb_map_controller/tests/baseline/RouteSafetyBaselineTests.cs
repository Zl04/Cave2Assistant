namespace AdbMapController.Tests;

public sealed class RouteSafetyBaselineTests
{
    static RouteExecutionContext Context(params Cell[] route) => new(
        new MapDump { Level = 1, Width = 8, Height = 8, Player = new PlayerInfo { X = route[0].X, Y = route[0].Y }, Tiles = [] },
        new RouteSession { Route = [.. route] }, [], new MovementTuning(0, 50, 1000), new RouteExecutionRuntime(),
        _ => true, x => x, new Observer());

    [Fact]
    public async Task EmptyRouteCompletesEvenWhenOwnerCanceled()
    {
        using var owner = new CancellationTokenSource(); owner.Cancel();
        var context = Context(new Cell(1, 1));
        var input = new Input();
        Assert.Equal(RouteExecutionStatus.Completed, (await new RouteExecutor(new Source(() => throw new Exception()), input).ExecuteDetailed(context, owner.Token)).Status);
        Assert.Empty(input.Events);
    }

    [Fact]
    public async Task HeldRouteReleasesOnReadFailure()
    {
        var input = new Input();
        var context = Context(new Cell(1, 1), new Cell(2, 1), new Cell(3, 1));
        await Assert.ThrowsAsync<IOException>(() => new RouteExecutor(new Source(() => throw new IOException("disconnect")), input).ExecuteDetailed(context, default));
        Assert.Equal(new[] { "down", "up" }, input.Events);
    }

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public async Task CancellationReleasesHeldInputAndPopupDoesNotBecomeReplan(bool popup)
    {
        using var owner = new CancellationTokenSource();
        var input = new Input { OnDown = owner.Cancel };
        var executor = new RouteExecutor(new Source(() => throw new Exception("should not read")), input);
        var context = Context(new Cell(1, 1), new Cell(2, 1), new Cell(3, 1));
        if (popup)
            Assert.Equal(RouteExecutionStatus.InterruptedByPopup, (await executor.ExecuteDetailed(context, owner.Token, () => MotionInterruptReason.Popup)).Status);
        else await Assert.ThrowsAnyAsync<OperationCanceledException>(() => executor.ExecuteDetailed(context, owner.Token));
        Assert.Equal(new[] { "down", "up" }, input.Events);
    }

    [Fact]
    public async Task FailedDownDoesNotClaimHeldOrSendUpAtExecutorLevel()
    {
        var input = new Input { DownError = new IOException("partial send") };
        await Assert.ThrowsAsync<IOException>(() => new RouteExecutor(new Source(() => throw new Exception()), input)
            .ExecuteDetailed(Context(new Cell(1, 1), new Cell(2, 1), new Cell(3, 1)), default));
        Assert.Equal(new[] { "down" }, input.Events); // Documents a hardware-safety gap, not a guarantee.
    }

    [Fact]
    public async Task ReleaseFailureCurrentlyMasksReadFailure()
    {
        var input = new Input { UpError = new InvalidOperationException("release") };
        var error = await Assert.ThrowsAsync<InvalidOperationException>(() => new RouteExecutor(new Source(() => throw new IOException("read")), input)
            .ExecuteDetailed(Context(new Cell(1, 1), new Cell(2, 1), new Cell(3, 1)), default));
        Assert.Equal("release", error.Message);
    }

    [Fact]
    public async Task UnchangedBoundarySequenceRequestsReplan()
    {
        var input = new Input();
        var status = Status(2, 1);
        var result = await new RouteExecutor(new Source(() => status), input)
            .ExecuteDetailed(Context(new Cell(1, 1), new Cell(2, 1)), default).WaitAsync(TimeSpan.FromSeconds(5));
        Assert.Equal(RouteExecutionStatus.Replan, result.Status);
        Assert.Equal(new[] { "pulse" }, input.Events);
    }

    [Fact]
    public async Task OffRouteReleasesAndReplans()
    {
        var input = new Input();
        var result = await new RouteExecutor(new Source(() => Status(7, 1)), input)
            .ExecuteDetailed(Context(new Cell(1, 1), new Cell(2, 1), new Cell(3, 1)), default);
        Assert.Equal(RouteExecutionStatus.Replan, result.Status);
        Assert.Equal(new[] { "down", "up" }, input.Events);
    }

    static PlayerStatus Status(int x, long sequence) => new() { Level = 1, Player = new PlayerInfo { X = x, Y = 1 }, Sequence = sequence };
    sealed class Source(Func<PlayerStatus> read) : IPlayerStatusSource { public Task<PlayerStatus> ReadPlayer() => Task.FromResult(read()); }
    sealed class Input : IMovementInput
    {
        public List<string> Events { get; } = [];
        public Action? OnDown { get; init; }
        public Exception? DownError { get; init; }
        public Exception? UpError { get; init; }
        public Task TouchDown(Cell delta, CancellationToken cancellationToken = default) { Events.Add("down"); OnDown?.Invoke(); if (DownError is not null) throw DownError; return Task.CompletedTask; }
        public Task TouchUp() { Events.Add("up"); if (UpError is not null) throw UpError; return Task.CompletedTask; }
        public Task ChangeDirection(Cell delta, CancellationToken cancellationToken = default) { Events.Add("change"); return Task.CompletedTask; }
        public Task PulseOneCell(Cell delta, int milliseconds, CancellationToken cancellationToken = default) { Events.Add("pulse"); return Task.CompletedTask; }
    }
    sealed class Observer : IRouteExecutionObserver { public void SetState(string text) { } public void WriteLog(string text) { } public void MapChanged() { } }
}
