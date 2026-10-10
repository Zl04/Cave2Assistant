using System.Drawing;

namespace AdbMapController;

/// <summary>Owns cached images and reader leases across capture generations.</summary>
internal sealed class ScreenFrameCache : IDisposable
{
    sealed class Frame(long id, Bitmap image)
    {
        public long Id { get; } = id;
        public Bitmap Image { get; } = image;
        public int References;
    }

    sealed class Capture(long id, long generation)
    {
        public long Id { get; } = id;
        public long Generation { get; } = generation;
        public int Readers;
        public Frame? Frame;
        public TaskCompletionSource Completion { get; } = new(TaskCreationOptions.RunContinuationsAsynchronously);
    }

    readonly object gate = new();
    readonly Dictionary<long, Capture> pending = [];
    Frame? cached;
    long generation;
    long latestRequest;
    bool disposed;

    public async Task<Bitmap> GetAsync(long frameId,
        Func<CancellationToken, Task<Bitmap>> captureAsync, CancellationToken token = default)
    {
        ArgumentNullException.ThrowIfNull(captureAsync);
        token.ThrowIfCancellationRequested();
        Capture operation;
        bool start;
        lock (gate)
        {
            ObjectDisposedException.ThrowIf(disposed, this);
            if (cached?.Id == frameId) return new Bitmap(cached.Image);
            latestRequest = frameId;
            start = !pending.TryGetValue(frameId, out operation!);
            if (start) pending.Add(frameId, operation = new Capture(frameId, generation));
            operation.Readers++;
        }
        if (start) _ = CaptureAsync(operation, captureAsync);
        try
        {
            await operation.Completion.Task.WaitAsync(token).ConfigureAwait(false);
            lock (gate)
            {
                ObjectDisposedException.ThrowIf(disposed, this);
                // The reader lease survives Clear and eviction; all Bitmap
                // access is serialized with clone and release operations.
                return new Bitmap(operation.Frame!.Image);
            }
        }
        finally
        {
            lock (gate)
            {
                operation.Readers--;
                Release(operation.Frame);
            }
        }
    }

    async Task CaptureAsync(Capture operation, Func<CancellationToken, Task<Bitmap>> captureAsync)
    {
        try
        {
            // Cancelling one reader cannot cancel a capture shared by others.
            using var image = await captureAsync(CancellationToken.None).ConfigureAwait(false);
            var frame = new Frame(operation.Id, new Bitmap(image));
            lock (gate)
            {
                RemovePending(operation);
                if (disposed)
                {
                    frame.Image.Dispose();
                    operation.Completion.TrySetException(new ObjectDisposedException(nameof(ScreenFrameCache)));
                    _ = operation.Completion.Task.Exception;
                    return;
                }
                operation.Frame = frame;
                frame.References = operation.Readers;
                if (operation.Generation == generation && operation.Id == latestRequest)
                {
                    Release(cached);
                    cached = frame;
                    frame.References++;
                }
                if (frame.References == 0) frame.Image.Dispose();
                operation.Completion.TrySetResult();
            }
        }
        catch (Exception error)
        {
            lock (gate)
            {
                RemovePending(operation);
                operation.Completion.TrySetException(error);
                _ = operation.Completion.Task.Exception;
            }
        }
    }

    void RemovePending(Capture operation)
    {
        if (pending.TryGetValue(operation.Id, out var current) && ReferenceEquals(current, operation))
            pending.Remove(operation.Id);
    }

    static void Release(Frame? frame)
    {
        if (frame is not null && --frame.References == 0) frame.Image.Dispose();
    }

    void Invalidate()
    {
        generation++;
        pending.Clear();
        Release(cached);
        cached = null;
    }

    public void Clear()
    {
        lock (gate)
        {
            ObjectDisposedException.ThrowIf(disposed, this);
            Invalidate();
        }
    }

    public void Dispose()
    {
        lock (gate)
        {
            if (disposed) return;
            disposed = true;
            Invalidate();
        }
    }
}
