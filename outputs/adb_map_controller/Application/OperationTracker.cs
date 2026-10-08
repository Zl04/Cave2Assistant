namespace AdbMapController;

/// <summary>
/// Tracks user-triggered asynchronous work so shutdown can await it without
/// exposing task collection bookkeeping to the presentation layer.
/// </summary>
public sealed class OperationTracker
{
    readonly HashSet<Task> active = [];

    public bool IsBusy => active.Count != 0;

    public async Task RunAsync(Func<Task> action)
    {
        var operation = action();
        active.Add(operation);
        try { await operation; }
        finally { active.Remove(operation); }
    }

    public Task WhenIdleAsync() => active.Count == 0
        ? Task.CompletedTask
        : Task.WhenAll(active.ToArray());
}
