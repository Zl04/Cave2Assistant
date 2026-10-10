using System.Collections.Concurrent;

namespace AdbMapController.Tests;

public sealed class OperationLifecycleTests
{
    sealed class UiContext : SynchronizationContext, IDisposable
    {
        readonly BlockingCollection<(SendOrPostCallback Callback, object? State)> queue = new();
        public override void Post(SendOrPostCallback callback, object? state) => queue.Add((callback, state));
        public void Pump() { foreach (var item in queue.GetConsumingEnumerable()) item.Callback(item.State); }
        public void Finish() => queue.CompleteAdding();
        public void Dispose() => queue.Dispose();
    }

    static async Task OnUi(Func<Task> action)
    {
        var completion = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var thread = new Thread(() =>
        {
            using var context = new UiContext();
            SynchronizationContext.SetSynchronizationContext(context);
            context.Post(async _ =>
            {
                try { await action(); completion.TrySetResult(); }
                catch (Exception ex) { completion.TrySetException(ex); }
                finally { context.Finish(); }
            }, null);
            context.Pump();
        }) { IsBackground = true };
        thread.SetApartmentState(ApartmentState.STA);
        thread.Start();
        try { await completion.Task.WaitAsync(TimeSpan.FromSeconds(5)); }
        finally { Assert.True(thread.Join(TimeSpan.FromSeconds(1)), "UI fixture thread did not exit"); }
    }

    [Fact]
    public Task FailureDoesNotDiscardOtherActiveOperation() => OnUi(async () =>
    {
        var tracker = new OperationTracker();
        var first = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var second = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var a = tracker.RunAsync(() => first.Task);
        var b = tracker.RunAsync(() => second.Task);
        first.SetException(new IOException("first"));
        await Assert.ThrowsAsync<IOException>(() => a);
        Assert.True(tracker.IsBusy);
        var idle = tracker.WhenIdleAsync();
        Assert.False(idle.IsCompleted);
        second.SetResult();
        await b; await idle;
        Assert.False(tracker.IsBusy);
        Assert.IsType<UiContext>(SynchronizationContext.Current);
    });

    [Fact]
    public Task SnapshotDoesNotWaitForSubsequentlyAddedOperation() => OnUi(async () =>
    {
        var tracker = new OperationTracker();
        var first = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var second = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var a = tracker.RunAsync(() => first.Task);
        var snapshot = tracker.WhenIdleAsync();
        var b = tracker.RunAsync(() => second.Task);
        first.SetResult(); await a; await snapshot;
        Assert.True(tracker.IsBusy);
        Assert.False(b.IsCompleted);
        second.SetResult(); await b;
        Assert.False(tracker.IsBusy);
    });

    [Fact]
    public Task OwnerCancellationRunsAllOperationFinallyBlocksBeforeIdle() => OnUi(async () =>
    {
        using var owner = new CancellationTokenSource();
        var tracker = new OperationTracker(); var released = 0;
        async Task Work() { try { await Task.Delay(Timeout.Infinite, owner.Token); } finally { released++; } }
        var a = tracker.RunAsync(Work); var b = tracker.RunAsync(Work);
        var idle = tracker.WhenIdleAsync(); owner.Cancel();
        await Assert.ThrowsAnyAsync<OperationCanceledException>(() => a);
        await Assert.ThrowsAnyAsync<OperationCanceledException>(() => b);
        await Assert.ThrowsAnyAsync<OperationCanceledException>(() => idle);
        Assert.Equal(2, released);
        Assert.False(tracker.IsBusy);
    });

    [Fact]
    public Task SynchronousFailureNeverRegistersAnActiveTask() => OnUi(async () =>
    {
        var tracker = new OperationTracker();
        await Assert.ThrowsAsync<InvalidOperationException>(() => tracker.RunAsync(() => throw new InvalidOperationException()));
        Assert.False(tracker.IsBusy);
        await tracker.WhenIdleAsync();
    });
}
