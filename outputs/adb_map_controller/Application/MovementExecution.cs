namespace AdbMapController;

/// <summary>Owns one interruptible movement slice; popup cancellation never cancels its run.</summary>
public sealed class MovementExecution(MotionInterruptState interrupt)
{
    readonly object gate = new();
    CancellationTokenSource? current;

    CancellationTokenSource Begin(CancellationToken owner)
    {
        lock (gate)
        {
            if (current is not null) throw new InvalidOperationException("A movement slice is already active.");
            return current = CancellationTokenSource.CreateLinkedTokenSource(owner);
        }
    }

    void End(CancellationTokenSource slice)
    {
        lock (gate)
        {
            if (ReferenceEquals(current, slice)) current = null;
            slice.Dispose();
        }
    }

    public bool Interrupt()
    {
        lock (gate)
        {
            if (current is null) return false;
            current.Cancel();
            return true;
        }
    }

    public async Task<RouteExecutionResult> ExecuteRouteAsync(RouteExecutor executor,
        RouteExecutionContext context, CancellationToken owner)
    {
        var slice = Begin(owner);
        try
        {
            var result = await executor.ExecuteDetailed(context, slice.Token, () => interrupt.Reason);
            owner.ThrowIfCancellationRequested();
            return interrupt.Reason == MotionInterruptReason.Popup
                ? new RouteExecutionResult(RouteExecutionStatus.InterruptedByPopup) : result;
        }
        finally { End(slice); }
    }

    public async Task<bool> ExecuteInteractionAsync(Func<CancellationToken, Task> action, CancellationToken owner)
    {
        var slice = Begin(owner);
        try
        {
            await action(slice.Token);
            return interrupt.Reason == MotionInterruptReason.Popup;
        }
        catch (OperationCanceledException) when (!owner.IsCancellationRequested && interrupt.Reason == MotionInterruptReason.Popup)
        {
            return true;
        }
        finally { End(slice); }
    }
}
