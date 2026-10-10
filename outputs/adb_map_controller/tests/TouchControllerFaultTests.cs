namespace AdbMapController.Tests;

public sealed class TouchControllerFaultTests
{
    sealed class Backend : ITouchTransport
    {
        readonly object gate = new();
        readonly List<string> events = [];
        public IReadOnlyList<string> Events { get { lock (gate) return events.ToArray(); } }
        public Exception? DownError { get; set; }
        public Exception? UpError { get; set; }
        public Exception? SwipeError { get; set; }
        public TaskCompletionSource? DownGate { get; set; }
        public Task EnsureTouchReady() => Task.CompletedTask;
        public (int X, int Y) TouchPoint(Cell delta) => (delta.X, delta.Y);
        public async Task SendTouchDown((int X, int Y) point)
        {
            Record("TouchDownAsync");
            if (DownGate is { } pending) await pending.Task;
            if (DownError is not null) throw DownError;
        }
        public Task SendTouchUp() { Record("TouchUpAsync"); return UpError is { } error ? Task.FromException(error) : Task.CompletedTask; }
        public Task SendTouchPulse((int X, int Y) point, int milliseconds)
        { Record("SwipeAsync"); return SwipeError is { } error ? Task.FromException(error) : Task.CompletedTask; }
        void Record(string value) { lock (gate) events.Add(value); }
    }

    static (TouchController Touch, Backend Backend) CreateController()
    {
        var backend = new Backend();
        return (new TouchController(backend), backend);
    }
    [Fact]
    public async Task DownThenDirectionChangeAndEmergencyReleaseKeepProtocolOrder()
    {
        var (touch, backend) = CreateController();
        try
        {
            await touch.TouchDown(new Cell(1, 0));
            await touch.ChangeDirection(new Cell(0, 1));
            await touch.EmergencyRelease();

            Assert.Equal(new[] { "TouchDownAsync", "TouchUpAsync", "TouchDownAsync", "TouchUpAsync" }, backend.Events);
        }
        finally { touch.Dispose(); }
    }

    [Fact]
    public async Task EmergencyReleaseQueuesBehindAnInFlightDown()
    {
        var (touch, backend) = CreateController();
        var downGate = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        backend.DownGate = downGate;
        var pending = backend.DownGate;
        try
        {
            var down = touch.TouchDown(new Cell(1, 0));
            var release = touch.EmergencyRelease();
            Assert.Equal(new[] { "TouchDownAsync" }, backend.Events);

            pending!.SetResult();
            await down.WaitAsync(TimeSpan.FromSeconds(2));
            await release.WaitAsync(TimeSpan.FromSeconds(2));
            Assert.Equal(new[] { "TouchDownAsync", "TouchUpAsync" }, backend.Events);
        }
        finally
        {
            touch.Dispose();
        }
    }

    [Fact]
    public async Task FailedDownRetainsUncertainContactUntilExplicitEmergencyRelease()
    {
        var (touch, backend) = CreateController();
        backend.DownError = new IOException("partial protocol write");
        var failures = 0;
        touch.InputFailed += _ => failures++;
        try
        {
            await Assert.ThrowsAsync<IOException>(() => touch.TouchDown(new Cell(1, 0)));
            await touch.EmergencyRelease();

            Assert.Equal(new[] { "TouchDownAsync", "TouchUpAsync" }, backend.Events);
            Assert.Equal(1, failures);
        }
        finally { touch.Dispose(); }
    }

    [Fact]
    public async Task FailedUpRetainsContactForExplicitEmergencyRetry()
    {
        var (touch, backend) = CreateController();
        await touch.TouchDown(new Cell(1, 0));
        backend.UpError = new IOException("release failed");
        var failures = 0;
        touch.InputFailed += _ => failures++;
        try
        {
            await Assert.ThrowsAsync<IOException>(() => touch.EmergencyRelease());
            backend.UpError = null;
            await touch.EmergencyRelease();

            Assert.Equal(new[] { "TouchDownAsync", "TouchUpAsync", "TouchUpAsync" }, backend.Events);
            Assert.Equal(1, failures);
        }
        finally { touch.Dispose(); }
    }

    [Fact]
    public async Task PulseUsesSwipeAsOneBackendOperationAndPropagatesFailure()
    {
        var (touch, backend) = CreateController();
        try
        {
            await touch.PulseOneCell(new Cell(1, 0), 0);
            Assert.Equal(new[] { "SwipeAsync" }, backend.Events);

            backend.SwipeError = new IOException("pulse failed");
            await Assert.ThrowsAsync<IOException>(() => touch.PulseOneCell(new Cell(1, 0), 1));
            Assert.Equal(new[] { "SwipeAsync", "SwipeAsync" }, backend.Events);
        }
        finally { touch.Dispose(); }
    }
    [Fact]
    public async Task FailedPulseRetainsUncertaintyForExplicitRelease()
    {
        var (touch, backend) = CreateController();
        using (touch)
        {
            backend.SwipeError = new IOException("partial swipe");
            await Assert.ThrowsAsync<IOException>(() => touch.PulseOneCell(new Cell(1, 0), 20));
            await touch.EmergencyRelease();
            Assert.Equal(new[] { "SwipeAsync", "TouchUpAsync" }, backend.Events);
        }
    }

    [Fact]
    public async Task FaultObserverCannotReplaceOriginalTransportFailure()
    {
        var (touch, backend) = CreateController();
        using (touch)
        {
            var error = new IOException("original input failure");
            backend.DownError = error;
            touch.InputFailed += _ => throw new InvalidOperationException("observer failed");
            Assert.Same(error, await Assert.ThrowsAsync<IOException>(() => touch.TouchDown(new Cell(1, 0))));
        }
    }

    [Fact]
    public async Task DisposedControllerRejectsInputBeforeCallingTransport()
    {
        var (touch, backend) = CreateController();
        touch.Dispose();
        await Assert.ThrowsAsync<ObjectDisposedException>(() => touch.TouchDown(new Cell(1, 0)));
        await Assert.ThrowsAsync<ObjectDisposedException>(() => touch.PulseOneCell(new Cell(1, 0), 20));
        await Assert.ThrowsAsync<ObjectDisposedException>(() => touch.TouchUp());
        Assert.Empty(backend.Events);
    }}
