using System.Drawing;

namespace AdbMapController.Tests;

public sealed class RefactorFoundationTests
{
    static Bitmap Pixel(Color color)
    {
        var image = new Bitmap(2, 2);
        image.SetPixel(0, 0, color);
        return image;
    }

    [Fact]
    public async Task ClearSeparatesCaptureGenerationsAndOldCaptureCannotReplaceNewCache()
    {
        using var cache = new ScreenFrameCache();
        var oldImage = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
        var old = cache.GetAsync(1, _ => oldImage.Task);
        cache.Clear();
        using var fresh = await cache.GetAsync(1, _ => Task.FromResult(Pixel(Color.Green)));
        oldImage.SetResult(Pixel(Color.Red));
        using var previous = await old;
        using var retained = await cache.GetAsync(1, _ => throw new Exception("Unexpected recapture"));
        Assert.Equal(Color.Red.ToArgb(), previous.GetPixel(0, 0).ToArgb());
        Assert.Equal(Color.Green.ToArgb(), retained.GetPixel(0, 0).ToArgb());
    }

    [Fact]
    public async Task InterleavedFrameRequestsShareEachPendingCapture()
    {
        using var cache = new ScreenFrameCache();
        var oneImage = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
        var twoImage = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
        var one = cache.GetAsync(1, _ => oneImage.Task);
        var two = cache.GetAsync(2, _ => twoImage.Task);
        var sameOne = cache.GetAsync(1, _ => throw new Exception("Duplicate capture"));
        twoImage.SetResult(Pixel(Color.Blue));
        using var second = await two;
        oneImage.SetResult(Pixel(Color.Red));
        using var first = await one;
        using var copy = await sameOne;
        cache.Clear();
        Assert.NotSame(first, copy);
        Assert.Equal(first.GetPixel(0, 0), copy.GetPixel(0, 0));
        Assert.Equal(Color.Blue.ToArgb(), second.GetPixel(0, 0).ToArgb());
    }

    [Fact]
    public async Task CancelledOnlyReaderDoesNotKeepAnUncachedLateImageAlive()
    {
        using var cache = new ScreenFrameCache();
        using var cancel = new CancellationTokenSource();
        var image = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
        var pending = cache.GetAsync(1, _ => image.Task, cancel.Token);
        cancel.Cancel();
        await Assert.ThrowsAnyAsync<OperationCanceledException>(() => pending);
        cache.Clear();
        image.SetResult(Pixel(Color.Red));
        using var fresh = await cache.GetAsync(1, _ => Task.FromResult(Pixel(Color.Green)));
        Assert.Equal(Color.Green.ToArgb(), fresh.GetPixel(0, 0).ToArgb());
    }

    [Fact]
    public async Task StopClosesAdmissionCancelsAndWaitsForFinalCleanup()
    {
        var operations = new ControllerOperations();
        var finish = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        CancellationToken token = default;
        var running = operations.RunAsync(ControllerOperationKind.Movement, ct => { token = ct; return finish.Task; });
        await Assert.ThrowsAsync<InvalidOperationException>(() => operations.RunAsync(ControllerOperationKind.Entry, _ => Task.CompletedTask));
        var stop = operations.StopAsync(closeAdmission: true);
        Assert.True(token.IsCancellationRequested);
        Assert.False(stop.IsCompleted);
        finish.SetResult();
        await stop;
        await running;
        Assert.Null(operations.TaskFor(ControllerOperationKind.Movement));
        await Assert.ThrowsAsync<InvalidOperationException>(() => operations.RunAsync(ControllerOperationKind.Entry, _ => Task.CompletedTask));
    }

    [Fact]
    public async Task OperationFailureReleasesAdmissionAndIsNotReportedAsSuccess()
    {
        var operations = new ControllerOperations();
        await Assert.ThrowsAsync<IOException>(() => operations.RunAsync(ControllerOperationKind.Movement, _ => throw new IOException("failed")));
        await operations.RunAsync(ControllerOperationKind.Entry, _ => Task.CompletedTask);
    }

    [Fact]
    public async Task PopupOnlyCancelsSliceAndDoesNotCancelItsOwner()
    {
        var interrupt = new MotionInterruptState();
        var movement = new MovementExecution(interrupt);
        using var owner = new CancellationTokenSource();
        var entered = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var action = movement.ExecuteInteractionAsync(async token => { entered.SetResult(); await Task.Delay(Timeout.Infinite, token); }, owner.Token);
        await entered.Task;
        Assert.True(interrupt.Request(MovementPopupKind.ServerError));
        Assert.True(movement.Interrupt());
        Assert.True(await action);
        Assert.False(owner.IsCancellationRequested);
        Assert.False(movement.Interrupt());
    }

    [Fact]
    public async Task OwnerCancellationCannotBeReclassifiedAsPopupCompletion()
    {
        var interrupt = new MotionInterruptState();
        var movement = new MovementExecution(interrupt);
        using var owner = new CancellationTokenSource();
        var entered = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var action = movement.ExecuteInteractionAsync(async token => { entered.SetResult(); await Task.Delay(Timeout.Infinite, token); }, owner.Token);
        await entered.Task;
        interrupt.Request(MovementPopupKind.ServerError);
        owner.Cancel();
        await Assert.ThrowsAnyAsync<OperationCanceledException>(() => action);
    }

    sealed class SnapshotSource : IGameSnapshotSource
    {
        public MapDump Map = new() { Level = 7 };
        public TaskCompletionSource<PlayerStatus> Player = new(TaskCreationOptions.RunContinuationsAsynchronously);
        public Task<MapDump> ReadMap() => Task.FromResult(Map);
        public Task<PlayerStatus> ReadPlayer() => Player.Task;
    }

    [Fact]
    public async Task CancelledSnapshotDoesNotCommitPartialSessionState()
    {
        var previous = new MapDump { Level = 6 };
        var session = new DungeonSession { Map = previous };
        var source = new SnapshotSource();
        using var cancel = new CancellationTokenSource();
        var refresh = new DungeonSnapshotUseCase(session, source).RefreshAsync(cancel.Token);
        cancel.Cancel();
        source.Player.SetResult(new PlayerStatus { Level = 7, MoveSpeed = 800 });
        await Assert.ThrowsAnyAsync<OperationCanceledException>(() => refresh);
        Assert.Same(previous, session.Map);
        Assert.Equal(1000, session.RouteExecution.MoveSpeed);
    }

    [Fact]
    public async Task CompleteSnapshotCommitsAuthoritativePositionAndSpeed()
    {
        var session = new DungeonSession();
        var source = new SnapshotSource();
        source.Player.SetResult(new PlayerStatus { Level = 7, Player = new PlayerInfo { X = 2, Y = 3 }, MoveSpeed = 800 });
        var result = await new DungeonSnapshotUseCase(session, source).RefreshAsync();
        Assert.Same(result.Map, session.Map);
        Assert.Equal(new Cell(2, 3), new Cell(result.Map.Player.X, result.Map.Player.Y));
        Assert.Equal(800, session.RouteExecution.MoveSpeed);
        Assert.NotNull(session.Route.Snapshot);
    }

    [Fact]
    public async Task ConcurrentPipelineRunsKeepCountersAndTraceIdentitySeparate()
    {
        var path = Path.Combine(AppContext.BaseDirectory, "concurrent-" + Guid.NewGuid().ToString("N") + ".json");
        File.WriteAllText(path, """{"A":{"algorithm":"JustReturn","handler":"test","maxTimes":1}}""");
        try
        {
            var gate = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
            var entered = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
            var trace = new MaaPipelineTraceCollector();
            var pipeline = new MaaPipeline<int>(MaaPipelineCatalogLoader.Load(path),
                [new DelegateMaaPipelineHandler<int>("test", (_, _, _) => Task.FromResult(MaaPipelineRecognitionResult.Hit()),
                    async (_, _, context, _) => { if (context.State == 1) { entered.SetResult(); await gate.Task; } return MaaPipelineActionResult.Success(); })], trace: trace);
            var first = pipeline.RunAsync(1, ["A"]);
            await entered.Task;
            var second = await pipeline.RunAsync(2, ["A"]);
            gate.SetResult();
            var completed = await first;
            Assert.True(completed.Succeeded);
            Assert.True(second.Succeeded);
            Assert.NotEqual(completed.RunId, second.RunId);
            Assert.Equal(1, completed.TaskId);
            Assert.Equal(1, second.TaskId);
        }
        finally { File.Delete(path); }
    }
    sealed class QueuedContext : SynchronizationContext
    {
        public readonly System.Collections.Concurrent.BlockingCollection<(SendOrPostCallback Callback, object? State)> Queue = new();
        public override void Post(SendOrPostCallback callback, object? state) => Queue.Add((callback, state));
    }

    [Fact]
    public async Task ClearingPublishedFrameBeforeUiReaderResumesPreservesReaderLease()
    {
        var finished = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var thread = new Thread(() =>
        {
            var context = new QueuedContext();
            SynchronizationContext.SetSynchronizationContext(context);
            try
            {
                using var cache = new ScreenFrameCache();
                var image = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
                var reader = cache.GetAsync(1, _ => image.Task);
                image.SetResult(Pixel(Color.Red));
                // The old implementation posts publication, then reader cloning
                // to this context. Clear between those callbacks reproduced E01.
                var deadline = DateTime.UtcNow.AddSeconds(3);
                while (!reader.IsCompleted && DateTime.UtcNow < deadline)
                    if (context.Queue.TryTake(out var callback, 10)) { callback.Callback(callback.State); break; }
                cache.Clear();
                while (!reader.IsCompleted && DateTime.UtcNow < deadline)
                    if (context.Queue.TryTake(out var callback, 10)) callback.Callback(callback.State);
                Assert.True(reader.IsCompleted);
                using var result = reader.GetAwaiter().GetResult();
                Assert.Equal(Color.Red.ToArgb(), result.GetPixel(0, 0).ToArgb());
                finished.SetResult();
            }
            catch (Exception error) { finished.SetException(error); }
            finally { context.Queue.Dispose(); }
        }) { IsBackground = true };
        thread.Start();
        await finished.Task.WaitAsync(TimeSpan.FromSeconds(5));
        Assert.True(thread.Join(TimeSpan.FromSeconds(1)));
    }

    [Fact]
    public async Task SnapshotUseCaseLearnsRoomPortalAndConsumesItsLanding()
    {
        var from = new Cell(1, 1); var to = new Cell(5, 1);
        MapDump Map(Cell player) => new()
        {
            Level = 7, Width = 8, Height = 3, MapName = "fixture", Player = new PlayerInfo { X = player.X, Y = player.Y },
            Tiles = [[new TileInfo { X = from.X, Y = from.Y, Roles = [new RoleInfo { ClassName = "TriggerNpcData", RoleType = 1, MinimapType = 22, TransdoorType = 3 }] },
                new TileInfo { X = to.X, Y = to.Y, Roles = [new RoleInfo { ClassName = "TriggerNpcData", RoleType = 1, MinimapType = 22, TransdoorType = 3 }] }]]
        };
        var before = Map(from);
        var session = new DungeonSession { Map = before, PendingRoomPortal = new TargetKey(from, "秘境传送门"), RoomPortalOrigin = from, RoomPortalInteractionAt = 123 };
        var source = new SnapshotSource { Map = Map(to) };
        source.Player.SetResult(new PlayerStatus { Level = 7, Player = new PlayerInfo { X = to.X, Y = to.Y } });
        var result = await new DungeonSnapshotUseCase(session, source).RefreshAsync();
        Assert.Equal(new[] { to }, session.PortalJumps.ObservedTargets(result.Map, from));
        Assert.Contains(to, session.AttemptedRoomPortals);
        Assert.Null(session.PendingRoomPortal);
        Assert.Null(session.RoomPortalOrigin);
        Assert.Equal(0, session.RoomPortalInteractionAt);
        Assert.Contains(result.Messages, message => message.Contains("层内传送已确认"));
    }}
