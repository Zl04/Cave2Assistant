using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// 一次管线处理中由所有识别节点共享的不可变输入。
/// 弹窗看门狗每张截图创建一个上下文，使识别器不会在同一模态框的不同帧之间竞争。
/// </summary>
public sealed class UiPipelineContext<TFrame>
{
    public TFrame Frame { get; }
    public long? FrameId { get; }
    public DateTimeOffset CapturedAt { get; }
    internal Dictionary<string, object?> Cache { get; } = new();

    public UiPipelineContext(TFrame frame, long? frameId = null, DateTimeOffset? capturedAt = null)
    {
        Frame = frame;
        FrameId = frameId;
        CapturedAt = capturedAt ?? DateTimeOffset.UtcNow;
    }
}

public sealed class UiPipelineNode<TFrame, TValue>
{
    public string Name { get; }
    public TValue Value { get; }
    public int MaxAttempts { get; }
    public TimeSpan Timeout { get; }
    public Func<UiPipelineContext<TFrame>, CancellationToken, Task<bool>> RecognizeAsync { get; }

    public UiPipelineNode(
        string name,
        TValue value,
        Func<UiPipelineContext<TFrame>, CancellationToken, Task<bool>> recognizeAsync,
        int maxAttempts = 1,
        TimeSpan? timeout = null)
    {
        if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("UI Pipeline 节点名不能为空", nameof(name));
        if (recognizeAsync is null) throw new ArgumentNullException(nameof(recognizeAsync));
        if (maxAttempts < 1) throw new ArgumentOutOfRangeException(nameof(maxAttempts));

        Name = name;
        Value = value;
        RecognizeAsync = recognizeAsync;
        MaxAttempts = maxAttempts;
        Timeout = timeout ?? TimeSpan.FromMilliseconds(2500);
        if (Timeout <= TimeSpan.Zero && Timeout != System.Threading.Timeout.InfiniteTimeSpan)
            throw new ArgumentOutOfRangeException(nameof(timeout));
    }
}

public sealed record UiPipelineAttempt(
    string NodeName,
    int Attempt,
    bool Matched,
    bool TimedOut,
    TimeSpan Duration,
    string? Error);

public sealed record UiPipelineResult<TValue>(
    TValue Value,
    string? NodeName,
    IReadOnlyList<UiPipelineAttempt> Attempts)
{
    public bool Matched => NodeName is not null;
}

/// <summary>
/// 针对一张已捕获画面按顺序运行 UI 识别节点。
///
/// 节点有意串行执行：弹窗优先级关系到安全，且基于 OCR 的节点共享串行 Worker。
/// 看门狗本身作为移动旁边的并行任务运行，而此类保持一次探测的一致性。
/// </summary>
public sealed class UiPipeline<TFrame, TValue>
{
    readonly IReadOnlyList<UiPipelineNode<TFrame, TValue>> nodes;
    readonly TValue noMatchValue;

    public UiPipeline(
        TValue noMatchValue,
        IEnumerable<UiPipelineNode<TFrame, TValue>> nodes)
    {
        this.noMatchValue = noMatchValue;
        this.nodes = nodes is null
            ? throw new ArgumentNullException(nameof(nodes))
            : new List<UiPipelineNode<TFrame, TValue>>(nodes);
        if (this.nodes.Count == 0) throw new ArgumentException("UI Pipeline 至少需要一个节点", nameof(nodes));
    }

    public async Task<UiPipelineResult<TValue>> RunAsync(
        TFrame frame,
        CancellationToken cancellationToken = default)
        => await RunAsync(frame, null, cancellationToken);

    public async Task<UiPipelineResult<TValue>> RunAsync(
        TFrame frame,
        long? frameId,
        CancellationToken cancellationToken = default)
    {
        var context = new UiPipelineContext<TFrame>(frame, frameId);
        var attempts = new List<UiPipelineAttempt>();

        foreach (var node in nodes)
        {
            for (var attempt = 1; attempt <= node.MaxAttempts; attempt++)
            {
                cancellationToken.ThrowIfCancellationRequested();
                var stopwatch = Stopwatch.StartNew();
                using var nodeCancellation = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
                if (node.Timeout != Timeout.InfiniteTimeSpan)
                    nodeCancellation.CancelAfter(node.Timeout);

                try
                {
                    var matched = await node.RecognizeAsync(context, nodeCancellation.Token);
                    var timedOut = nodeCancellation.IsCancellationRequested && !cancellationToken.IsCancellationRequested;
                    if (timedOut)
                    {
                        attempts.Add(new UiPipelineAttempt(node.Name, attempt, false, true,
                            stopwatch.Elapsed, $"节点超时（>{node.Timeout.TotalMilliseconds:0}ms）"));
                        continue;
                    }

                    attempts.Add(new UiPipelineAttempt(node.Name, attempt, matched, false,
                        stopwatch.Elapsed, null));
                    if (matched)
                        return new UiPipelineResult<TValue>(node.Value, node.Name, attempts);
                }
                catch (OperationCanceledException) when (cancellationToken.IsCancellationRequested)
                {
                    throw;
                }
                catch (OperationCanceledException)
                {
                    attempts.Add(new UiPipelineAttempt(node.Name, attempt, false, true,
                        stopwatch.Elapsed, $"节点超时（>{node.Timeout.TotalMilliseconds:0}ms）"));
                }
                catch (Exception ex)
                {
                    attempts.Add(new UiPipelineAttempt(node.Name, attempt, false, false,
                        stopwatch.Elapsed, ex.Message));
                }
            }
        }

        return new UiPipelineResult<TValue>(noMatchValue, null, attempts);
    }
}
