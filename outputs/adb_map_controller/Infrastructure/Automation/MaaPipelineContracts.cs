using System.Collections.Concurrent;
using System.Globalization;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace AdbMapController;

public sealed record MaaPipelineRecognitionResult(
    bool Matched,
    double Score = 0,
    MaaRect? Box = null,
    string? Text = null,
    string? Detail = null,
    string? EvidencePath = null,
    long? FrameId = null)
{
    public static MaaPipelineRecognitionResult Miss(string? detail = null, string? evidencePath = null)
        => new(false, Detail: detail, EvidencePath: evidencePath);

    public static MaaPipelineRecognitionResult Hit(
        double score = 1,
        MaaRect? box = null,
        string? text = null,
        string? detail = null,
        string? evidencePath = null,
        long? frameId = null)
        => new(true, score, box, text, detail, evidencePath, frameId);
}

public sealed record MaaPipelineActionResult(bool Succeeded, string? Error = null, bool Interrupted = false, string? EvidencePath = null)
{
    public static MaaPipelineActionResult Success() => new(true);
    public static MaaPipelineActionResult Failure(string error, string? evidencePath = null) => new(false, error, EvidencePath: evidencePath);
    public static MaaPipelineActionResult Stop() => new(true, Interrupted: true);
}

public sealed class MaaPipelineTaskContext<TState>
{
    internal MaaPipelineTaskContext(
        TState state,
        string runId,
        string taskChain,
        string taskName,
        int taskId,
        string? parentTask,
        int attempt,
        int executionCount,
        IReadOnlyDictionary<string, int> executionCounts)
    {
        State = state;
        RunId = runId;
        TaskChain = taskChain;
        TaskName = taskName;
        TaskId = taskId;
        ParentTask = parentTask;
        Attempt = attempt;
        ExecutionCount = executionCount;
        ExecutionCounts = executionCounts;
    }

    public TState State { get; }
    public string RunId { get; }
    public string TaskChain { get; }
    public string TaskName { get; }
    public int TaskId { get; }
    public string? ParentTask { get; }
    public int Attempt { get; }
    public int ExecutionCount { get; }
    public IReadOnlyDictionary<string, int> ExecutionCounts { get; }
}

public interface IMaaPipelineHandler<TState>
{
    string Name { get; }

    Task<MaaPipelineRecognitionResult> RecognizeAsync(
        MaaPipelineTask task,
        MaaPipelineTaskContext<TState> context,
        CancellationToken token);

    Task<MaaPipelineActionResult> ExecuteAsync(
        MaaPipelineTask task,
        MaaPipelineRecognitionResult recognition,
        MaaPipelineTaskContext<TState> context,
        CancellationToken token);
}

public sealed class DelegateMaaPipelineHandler<TState> : IMaaPipelineHandler<TState>
{
    readonly Func<MaaPipelineTask, MaaPipelineTaskContext<TState>, CancellationToken, Task<MaaPipelineRecognitionResult>> recognize;
    readonly Func<MaaPipelineTask, MaaPipelineRecognitionResult, MaaPipelineTaskContext<TState>, CancellationToken, Task<MaaPipelineActionResult>> execute;

    public DelegateMaaPipelineHandler(
        string name,
        Func<MaaPipelineTask, MaaPipelineTaskContext<TState>, CancellationToken, Task<MaaPipelineRecognitionResult>> recognize,
        Func<MaaPipelineTask, MaaPipelineRecognitionResult, MaaPipelineTaskContext<TState>, CancellationToken, Task<MaaPipelineActionResult>> execute)
    {
        if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("handler 名称不能为空", nameof(name));
        Name = name;
        this.recognize = recognize ?? throw new ArgumentNullException(nameof(recognize));
        this.execute = execute ?? throw new ArgumentNullException(nameof(execute));
    }

    public string Name { get; }
    public Task<MaaPipelineRecognitionResult> RecognizeAsync(MaaPipelineTask task, MaaPipelineTaskContext<TState> context, CancellationToken token)
        => recognize(task, context, token);
    public Task<MaaPipelineActionResult> ExecuteAsync(MaaPipelineTask task, MaaPipelineRecognitionResult recognition, MaaPipelineTaskContext<TState> context, CancellationToken token)
        => execute(task, recognition, context, token);
}

public enum MaaPipelineTraceKind
{
    TaskChainStarted,
    CandidateRecognizing,
    CandidateRecognized,
    NodeStarted,
    ActionStarted,
    NodeCompleted,
    NodeFailed,
    Retrying,
    LimitExceeded,
    BranchSelected,
    TaskChainCompleted,
    TaskChainFailed,
    Canceled,
    Stopped
}

public sealed record MaaPipelineTraceEvent(
    MaaPipelineTraceKind Kind,
    string RunId,
    string TaskChain,
    int TaskId,
    string? TaskName,
    string? ParentTask,
    int Attempt,
    int ExecutionCount,
    TimeSpan Duration,
    bool? Matched,
    double? Score,
    MaaRect? Box,
    string? Text,
    string? Action,
    string? Detail,
    string? Error,
    string? EvidencePath,
    long? FrameId,
    IReadOnlyList<string>? Candidates = null);

public interface IMaaPipelineTraceSink
{
    void Write(MaaPipelineTraceEvent value);
}

public sealed class DelegateMaaPipelineTraceSink : IMaaPipelineTraceSink
{
    readonly Action<MaaPipelineTraceEvent> action;

    public DelegateMaaPipelineTraceSink(Action<MaaPipelineTraceEvent> action)
        => this.action = action ?? throw new ArgumentNullException(nameof(action));

    public void Write(MaaPipelineTraceEvent value) => action(value);
}

public sealed class MaaPipelineTraceMultiplexer : IMaaPipelineTraceSink
{
    readonly IReadOnlyList<IMaaPipelineTraceSink> sinks;

    public MaaPipelineTraceMultiplexer(IEnumerable<IMaaPipelineTraceSink> sinks)
        => this.sinks = sinks?.Where(x => x is not null).ToArray()
            ?? throw new ArgumentNullException(nameof(sinks));

    public void Write(MaaPipelineTraceEvent value)
    {
        foreach (var sink in sinks)
        {
            try { sink.Write(value); } catch { /* 一个诊断订阅者不能破坏任务 */ }
        }
    }

}

public sealed class MaaPipelineTraceCollector : IMaaPipelineTraceSink
{
    readonly ConcurrentQueue<MaaPipelineTraceEvent> events = new();

    public IReadOnlyList<MaaPipelineTraceEvent> Events => events.ToArray();
    public void Write(MaaPipelineTraceEvent value) => events.Enqueue(value);

    public void SaveJson(string path)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(path);
        var directory = Path.GetDirectoryName(Path.GetFullPath(path));
        if (!string.IsNullOrWhiteSpace(directory)) Directory.CreateDirectory(directory);
        File.WriteAllText(path, JsonSerializer.Serialize(Events, new JsonSerializerOptions { WriteIndented = true }));
    }
}

public sealed record MaaPipelineExecutionResult(
    MaaPipelineExecutionStatus Status,
    string RunId,
    string? LastTask,
    int TaskId,
    int Transitions,
    string? Error)
{
    public bool Succeeded => Status == MaaPipelineExecutionStatus.Succeeded;
}

public enum MaaPipelineExecutionStatus
{
    Succeeded,
    Failed,
    Canceled,
    Stopped,
    TransitionLimitReached
}

public sealed class MaaPipelineExecutionOptions
{
    public int RetryTimes { get; init; } = 20;
    public TimeSpan RetryInterval { get; init; } = TimeSpan.FromMilliseconds(500);
    public int MaxTransitions { get; init; } = 100_000;
    public string TaskChain { get; init; } = "Custom";
}
