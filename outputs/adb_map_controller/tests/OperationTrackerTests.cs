namespace AdbMapController.Tests;

public sealed class OperationTrackerTests
{
    [Fact]
    public async Task TracksWorkUntilItCompletes()
    {
        var tracker = new OperationTracker();
        var completion = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);

        var running = tracker.RunAsync(() => completion.Task);

        Assert.True(tracker.IsBusy);
        var idle = tracker.WhenIdleAsync();
        Assert.False(idle.IsCompleted);

        completion.SetResult();
        await running;
        await idle;
        Assert.False(tracker.IsBusy);
    }
}
