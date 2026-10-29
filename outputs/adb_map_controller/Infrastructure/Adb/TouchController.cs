namespace AdbMapController;

/// <summary>Device capability consumed by the contact state machine.</summary>
public interface ITouchTransport
{
    Task EnsureTouchReady();
    (int X, int Y) TouchPoint(Cell delta);
    Task SendTouchDown((int X, int Y) point);
    Task SendTouchUp();
    Task SendTouchPulse((int X, int Y) point, int milliseconds);
}

/// <summary>Serializes gestures and owns the last confirmed or uncertain contact.</summary>
public sealed class TouchController(ITouchTransport transport) : IMovementInput, IDisposable
{
    readonly SemaphoreSlim lifecycle = new(1, 1);
    bool contactMayBeDown;
    int disposed;
    public event Action<Exception>? InputFailed;
    public Action<string>? TimingLog { get; set; }


    public async Task TouchDown(Cell delta, CancellationToken cancellationToken = default)
    {
        await lifecycle.WaitAsync().ConfigureAwait(false);
        try
        {
            ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
            await transport.EnsureTouchReady().ConfigureAwait(false);
            await ReleaseCore().ConfigureAwait(false);
            cancellationToken.ThrowIfCancellationRequested();
            var point = transport.TouchPoint(delta);
            // A partial protocol write can reach the device before throwing.
            // Retain uncertainty until an explicit release is acknowledged.
            contactMayBeDown = true;
            await transport.SendTouchDown(point).ConfigureAwait(false);
        }
        catch (Exception error) { Notify(error); throw; }
        finally { lifecycle.Release(); }
    }

    public async Task TouchUp()
    {
        await lifecycle.WaitAsync().ConfigureAwait(false);
        try
        {
            ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
            await ReleaseCore().ConfigureAwait(false);
        }
        catch (Exception error) { Notify(error); throw; }
        finally { lifecycle.Release(); }
    }

    async Task ReleaseCore()
    {
        if (!contactMayBeDown) return;
        await transport.SendTouchUp().ConfigureAwait(false);
        contactMayBeDown = false;
    }

    public Task ChangeDirection(Cell delta, CancellationToken cancellationToken = default)
        => TouchDown(delta, cancellationToken);

    public async Task PulseOneCell(Cell delta, int milliseconds, CancellationToken cancellationToken = default)
    {
        var startedAt = Environment.TickCount64;
        await lifecycle.WaitAsync().ConfigureAwait(false);
        try
        {
            TimingLog?.Invoke($"单格触摸：生命周期锁等待={Environment.TickCount64 - startedAt}ms，方向={delta}，设定按住={milliseconds}ms");
            ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
            await transport.EnsureTouchReady().ConfigureAwait(false);
            await ReleaseCore().ConfigureAwait(false);
            TimingLog?.Invoke($"单格触摸：后端调用开始=+{Environment.TickCount64 - startedAt}ms");
            cancellationToken.ThrowIfCancellationRequested();
            var point = transport.TouchPoint(delta);
            contactMayBeDown = true;
            await transport.SendTouchPulse(point, Math.Max(1, milliseconds)).ConfigureAwait(false);
            TimingLog?.Invoke($"单格触摸：后端调用完成=+{Environment.TickCount64 - startedAt}ms");
            contactMayBeDown = false;
            cancellationToken.ThrowIfCancellationRequested();
        }
        catch (Exception error) { Notify(error); throw; }
        finally { lifecycle.Release(); }
    }

    public Task HoldInteraction(Cell delta, int milliseconds, CancellationToken cancellationToken = default)
        => PulseOneCell(delta, milliseconds, cancellationToken);
    public Task EmergencyRelease() => TouchUp();

    void Notify(Exception error)
    {
        if (error is OperationCanceledException or ObjectDisposedException) return;
        if (InputFailed is not { } handlers) return;
        foreach (Action<Exception> handler in handlers.GetInvocationList())
            try { handler(error); } catch { /* Observers cannot replace a transport failure. */ }
    }

    public void Dispose()
    {
        if (Interlocked.Exchange(ref disposed, 1) != 0) return;
        lifecycle.Wait();
        try { contactMayBeDown = false; }
        finally { lifecycle.Release(); }
        // The owner releases the device before disposal. Already queued callers
        // still need a valid semaphore so they can observe disposed admission.
    }
}
