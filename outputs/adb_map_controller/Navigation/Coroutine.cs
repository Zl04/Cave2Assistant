using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>控制器协程产生的 Unity 风格指令。</summary>
public sealed record WaitForMilliseconds(int Milliseconds);

/// <summary>
/// 每次推进 IEnumerator 一个 yield。延迟基于截止时间，产生的 Task 会返回给所有者串行等待，
/// 因此控制器不会启动重叠的 ADB 操作。
/// </summary>
public sealed class Coroutine : IDisposable
{
    readonly IEnumerator routine;
    readonly CancellationTokenSource cancellation;
    Task? pendingTask;
    long resumeAt;
    bool disposed;

    internal Coroutine(Func<CancellationToken, IEnumerator> routineFactory, CancellationToken parentToken)
    {
        cancellation = CancellationTokenSource.CreateLinkedTokenSource(parentToken);
        routine = routineFactory(cancellation.Token);
    }
    public bool IsCompleted { get; private set; }
    public bool IsCancellationRequested => cancellation.IsCancellationRequested;

    public Task? Tick(long now)
    {
        if (IsCompleted) return null;
        if (pendingTask is not null)
        {
            if (!pendingTask.IsCompleted) return pendingTask;
            pendingTask.GetAwaiter().GetResult();
            pendingTask = null;
        }
        if (now < resumeAt) return null;

        if (!routine.MoveNext())
        {
            IsCompleted = true;
            return null;
        }

        switch (routine.Current)
        {
            case null:
                return null;
            case WaitForMilliseconds wait:
                resumeAt = now + Math.Max(0, wait.Milliseconds);
                return null;
            case Task task:
                pendingTask = task;
                return task;
            default:
                throw new InvalidOperationException($"Unsupported coroutine yield: {routine.Current.GetType().Name}");
        }
    }

    public void Dispose()
    {
        if (disposed) return;
        disposed = true;
        if (!IsCompleted) cancellation.Cancel();
        IsCompleted = true;
        (routine as IDisposable)?.Dispose();
        cancellation.Dispose();
    }
}

/// <summary>
/// 管理控制器协程，并提供类似 Unity 的 StopCoroutine 和 StopAllCoroutines 语义。
/// </summary>
public sealed class CoroutineRunner : IDisposable
{
    readonly HashSet<Coroutine> active = [];
    public int Count => active.Count;

    public Coroutine Start(Func<CancellationToken, IEnumerator> routineFactory,
        CancellationToken parentToken = default)
    {
        var coroutine = new Coroutine(routineFactory, parentToken);
        active.Add(coroutine);
        return coroutine;
    }

    public Task? Tick(Coroutine coroutine, long now)
    {
        if (!active.Contains(coroutine)) return null;
        var task = coroutine.Tick(now);
        if (coroutine.IsCompleted)
        {
            active.Remove(coroutine);
            coroutine.Dispose();
        }
        return task;
    }

    public bool Stop(Coroutine? coroutine)
    {
        if (coroutine is null || !active.Remove(coroutine)) return false;
        coroutine.Dispose();
        return true;
    }

    public void StopAll()
    {
        var snapshot = active.ToArray();
        active.Clear();
        foreach (var coroutine in snapshot) coroutine.Dispose();
    }

    public void Dispose() => StopAll();
}
