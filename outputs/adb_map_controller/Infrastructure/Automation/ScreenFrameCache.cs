using System;
using System.Drawing;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// 按逻辑帧编号复用截图。
///
/// FrameId 由调用方在一次检测循环开始时生成，而不是由此类定时采集。
/// 同一 FrameId 的并发请求共享一次真实截图；不同 FrameId 必须重新截图。
/// </summary>
internal sealed class ScreenFrameCache : IDisposable
{
    sealed class CachedFrame : IDisposable
    {
        public long FrameId { get; }
        public Bitmap Image { get; }
        readonly object imageGate = new();

        public CachedFrame(long frameId, Bitmap image)
        {
            FrameId = frameId;
            Image = image;
        }

        // System.Drawing.Bitmap is not safe for concurrent reads. A single
        // logical frame can have multiple waiters resume at the same time
        // (for example, after the shared capture completes), so cloning must
        // be serialized even though the cache lookup itself is locked.
        public Bitmap CloneImage()
        {
            lock (imageGate)
                return new Bitmap(Image);
        }

        public void Dispose()
        {
            lock (imageGate)
                Image.Dispose();
        }
    }

    sealed class CaptureOperation
    {
        public long FrameId { get; }
        public TaskCompletionSource<CachedFrame> Completion { get; } =
            new(TaskCreationOptions.RunContinuationsAsynchronously);

        public CaptureOperation(long frameId) => FrameId = frameId;
    }

    readonly object gate = new();
    CachedFrame? cached;
    CaptureOperation? active;
    bool disposed;

    public async Task<Bitmap> GetAsync(
        long frameId,
        Func<CancellationToken, Task<Bitmap>> captureAsync,
        CancellationToken token = default)
    {
        if (captureAsync is null) throw new ArgumentNullException(nameof(captureAsync));

        CaptureOperation operation;
        var startCapture = false;
        lock (gate)
        {
            ThrowIfDisposed();
            if (cached?.FrameId == frameId)
                return cached.CloneImage();

            if (active?.FrameId == frameId)
            {
                operation = active;
            }
            else
            {
                operation = new CaptureOperation(frameId);
                active = operation;
                startCapture = true;
            }
        }

        if (startCapture)
            _ = CaptureAndPublishAsync(operation, captureAsync);

        var result = await operation.Completion.Task.WaitAsync(token);
        return result.CloneImage();
    }

    async Task CaptureAndPublishAsync(
        CaptureOperation operation,
        Func<CancellationToken, Task<Bitmap>> captureAsync)
    {
        try
        {
            // 共享截图不能被某一个等待者的取消操作中断；取消只作用于该等待者。
            using var image = await captureAsync(CancellationToken.None);
            var next = new CachedFrame(operation.FrameId, new Bitmap(image));
            CachedFrame? previous = null;
            var rejected = false;
            lock (gate)
            {
                if (disposed)
                {
                    rejected = true;
                }
                else
                {
                    previous = cached;
                    cached = next;
                    if (ReferenceEquals(active, operation)) active = null;
                }
            }

            previous?.Dispose();
            if (rejected)
            {
                next.Dispose();
                operation.Completion.TrySetException(new ObjectDisposedException(nameof(ScreenFrameCache)));
                return;
            }

            operation.Completion.TrySetResult(next);
        }
        catch (Exception ex)
        {
            lock (gate)
            {
                if (ReferenceEquals(active, operation)) active = null;
            }
            operation.Completion.TrySetException(ex);
        }
    }

    public void Clear()
    {
        CachedFrame? previous;
        lock (gate)
        {
            ThrowIfDisposed();
            previous = cached;
            cached = null;
        }
        previous?.Dispose();
    }

    void ThrowIfDisposed()
    {
        if (disposed) throw new ObjectDisposedException(nameof(ScreenFrameCache));
    }

    public void Dispose()
    {
        CachedFrame? previous;
        lock (gate)
        {
            if (disposed) return;
            disposed = true;
            previous = cached;
            cached = null;
        }
        previous?.Dispose();
    }
}
