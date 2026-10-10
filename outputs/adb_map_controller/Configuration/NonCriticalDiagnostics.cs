namespace AdbMapController;

/// <summary>进程内诊断旁路：最多100条、每条512字符，全局每30秒最多接收一条，不做磁盘I/O。</summary>
public sealed class NonCriticalDiagnostics(Action<string>? sink = null, TimeProvider? clock = null)
{
    const int Capacity = 100;
    const int MaxMessageLength = 512;
    static readonly TimeSpan Interval = TimeSpan.FromSeconds(30);
    readonly TimeProvider clock = clock ?? TimeProvider.System;
    readonly object gate = new();
    readonly Queue<string> messages = new();
    long? lastAt;

    public void Record(string message)
    {
        try
        {
            var now = clock.GetTimestamp();
            var bounded = message.Length > MaxMessageLength ? message[..MaxMessageLength] : message;
            lock (gate)
            {
                if (lastAt is { } previous && clock.GetElapsedTime(previous, now) < Interval) return;
                lastAt = now;
                if (messages.Count == Capacity) messages.Dequeue();
                messages.Enqueue(bounded);
            }
            try { sink?.Invoke(bounded); } catch { }
        }
        catch { } // Diagnostic failures must never change control outcomes.
    }

    public IReadOnlyList<string> Snapshot()
    {
        lock (gate) return messages.ToArray();
    }
}
