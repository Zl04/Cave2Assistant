namespace AdbMapController.Tests;

public sealed class RouteExecutorTests
{
    [Fact]
    public async Task RejectsStaleRouteBeforeSendingInput()
    {
        var movement = new FakeMovementInput();
        var observer = new RecordingObserver();
        var map = MapAt(new Cell(4, 4));
        var session = new RouteSession { Route = [new Cell(1, 1), new Cell(2, 1)] };
        var context = new RouteExecutionContext(
            map, session, [], new MovementTuning(30, 50, 1000), new RouteExecutionRuntime(),
            _ => true, value => value, observer);

        var result = await new RouteExecutor(new FakePlayerStatusSource(), movement)
            .ExecuteDetailed(context, default);

        Assert.Equal(RouteExecutionStatus.Replan, result.Status);
        Assert.Empty(movement.Actions);
        Assert.Contains(observer.Logs, value => value.Contains("路线起点已过期"));
    }

    [Fact]
    public async Task ExecutesSingleCellThroughInjectedPorts()
    {
        var start = new Cell(1, 1);
        var destination = new Cell(2, 1);
        var movement = new FakeMovementInput();
        var statuses = new FakePlayerStatusSource(
            Status(destination, 1),
            Status(destination, 2));
        var context = new RouteExecutionContext(
            MapAt(start),
            new RouteSession { Route = [start, destination] },
            [], new MovementTuning(30, 50, 1000), new RouteExecutionRuntime(),
            _ => true, value => value, new RecordingObserver());

        var result = await new RouteExecutor(statuses, movement).ExecuteDetailed(context, default);

        Assert.Equal(RouteExecutionStatus.Completed, result.Status);
        Assert.Contains("pulse:1,0:50", movement.Actions);
        Assert.Equal(destination, new Cell(context.Map.Player.X, context.Map.Player.Y));
    }

    static MapDump MapAt(Cell player) => new()
    {
        Width = 5,
        Height = 5,
        Level = 1,
        Player = new PlayerInfo { X = player.X, Y = player.Y },
        Tiles = [],
    };

    static PlayerStatus Status(Cell player, long sequence) => new()
    {
        Level = 1,
        Width = 5,
        Height = 5,
        FogBits = "",
        Sequence = sequence,
        MoveSpeed = 1000,
        Player = new PlayerInfo { X = player.X, Y = player.Y },
    };

    sealed class FakePlayerStatusSource(params PlayerStatus[] statuses) : IPlayerStatusSource
    {
        readonly Queue<PlayerStatus> values = new(statuses);
        public Task<PlayerStatus> ReadPlayer() => Task.FromResult(values.Count > 1 ? values.Dequeue() : values.Peek());
    }

    sealed class FakeMovementInput : IMovementInput
    {
        public List<string> Actions { get; } = [];
        public Task TouchDown(Cell delta, CancellationToken cancellationToken = default) { Actions.Add($"down:{delta.X},{delta.Y}"); return Task.CompletedTask; }
        public Task TouchUp() { Actions.Add("up"); return Task.CompletedTask; }
        public Task ChangeDirection(Cell delta, CancellationToken cancellationToken = default) { Actions.Add($"change:{delta.X},{delta.Y}"); return Task.CompletedTask; }
        public Task PulseOneCell(Cell delta, int milliseconds, CancellationToken cancellationToken = default) { Actions.Add($"pulse:{delta.X},{delta.Y}:{milliseconds}"); return Task.CompletedTask; }
    }

    sealed class RecordingObserver : IRouteExecutionObserver
    {
        public List<string> Logs { get; } = [];
        public void SetState(string text) { }
        public void WriteLog(string text) => Logs.Add(text);
        public void MapChanged() { }
    }
}
