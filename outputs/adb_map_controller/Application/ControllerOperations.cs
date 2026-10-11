namespace AdbMapController;

public enum ControllerOperationKind { Movement, Entry }

/// <summary>Single owner of automation admission, cancellation and task draining.</summary>
public sealed class ControllerOperations
{
    sealed class Operation(ControllerOperationKind kind)
    {
        public ControllerOperationKind Kind { get; } = kind;
        public CancellationTokenSource Cancellation { get; } = new();
        public TaskCompletionSource Completion { get; } = new(TaskCreationOptions.RunContinuationsAsynchronously);
    }

    readonly object gate = new();
    Operation? current;
    bool closed;

    public CancellationToken MovementToken
    {
        get { lock (gate) return current?.Kind == ControllerOperationKind.Movement ? current.Cancellation.Token : default; }
    }
    public CancellationToken CurrentToken
    {
        get { lock (gate) return current?.Cancellation.Token ?? default; }
    }
    public Task? TaskFor(ControllerOperationKind kind)
    {
        lock (gate) return current?.Kind == kind ? current.Completion.Task : null;
    }

    public Task RunAsync(ControllerOperationKind kind, Func<CancellationToken, Task> action)
    {
        ArgumentNullException.ThrowIfNull(action);
        Operation operation;
        lock (gate)
        {
            if (closed) throw new InvalidOperationException("Controller operations are closed.");
            if (current is not null) throw new InvalidOperationException("Another controller operation is running.");
            current = operation = new Operation(kind);
        }
        _ = CompleteAsync(operation, action);
        return operation.Completion.Task;
    }

    async Task CompleteAsync(Operation operation, Func<CancellationToken, Task> action)
    {
        Exception? error = null;
        try { await action(operation.Cancellation.Token); }
        catch (Exception exception) { error = exception; }
        lock (gate)
        {
            current = null;
            operation.Cancellation.Dispose();
            if (error is OperationCanceledException canceled)
                operation.Completion.TrySetCanceled(canceled.CancellationToken);
            else if (error is not null) operation.Completion.TrySetException(error);
            else operation.Completion.TrySetResult();
        }
    }

    public void Cancel(ControllerOperationKind kind)
    {
        lock (gate)
            if (current?.Kind == kind ||
                (kind == ControllerOperationKind.Movement && current?.Kind == ControllerOperationKind.Entry))
                current.Cancellation.Cancel();
    }

    public Task StopAsync(bool closeAdmission = false)
    {
        lock (gate)
        {
            closed |= closeAdmission;
            current?.Cancellation.Cancel();
            return current?.Completion.Task ?? Task.CompletedTask;
        }
    }
}
