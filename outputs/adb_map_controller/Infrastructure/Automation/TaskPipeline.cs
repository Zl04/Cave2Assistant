using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// 有限任务流水线的执行状态。流水线只负责编排，不取代地图领域状态机。
/// </summary>
public enum TaskPipelineExecutionStatus
{
    Succeeded,
    Failed,
    Canceled,
    TransitionLimitReached
}

public enum TaskPipelineEventKind
{
    Started,
    NodeStarted,
    NodeSucceeded,
    NodeRetrying,
    NodeFailed,
    Completed,
    Canceled,
    Failed
}

public sealed record TaskPipelineNodeResult(bool Succeeded, string? Error = null)
{
    public static TaskPipelineNodeResult Success() => new(true);
    public static TaskPipelineNodeResult Failure(string error) => new(false, error);
}

public sealed record TaskPipelineExecutionResult(
    TaskPipelineExecutionStatus Status,
    string RunId,
    string? LastNode,
    int Transitions,
    string? Error)
{
    public bool Succeeded => Status == TaskPipelineExecutionStatus.Succeeded;
}

public sealed record TaskPipelineEvent(
    TaskPipelineEventKind Kind,
    string RunId,
    string? NodeName,
    int Attempt,
    int Transitions,
    TimeSpan Duration,
    string? Error);

public sealed class TaskPipelineContext<TState>
{
    readonly Dictionary<string, int> hitCounts;

    internal TaskPipelineContext(
        TState state,
        string runId,
        string nodeName,
        int attempt,
        int transitions,
        Dictionary<string, int> hitCounts)
    {
        State = state;
        RunId = runId;
        NodeName = nodeName;
        Attempt = attempt;
        Transitions = transitions;
        this.hitCounts = hitCounts;
    }

    public TState State { get; }
    public string RunId { get; }
    public string NodeName { get; }
    public int Attempt { get; }
    public int Transitions { get; }

    public int HitCount(string nodeName)
        => hitCounts.TryGetValue(nodeName, out var count) ? count : 0;

    public IReadOnlyDictionary<string, int> HitCounts
        => new ReadOnlyDictionary<string, int>(hitCounts);
}

public interface ITaskPipelineHandler<TState>
{
    string Name { get; }

    /// <summary>
    /// 相当于 MAA Pipeline 的“识别 next”：在候选列表中按顺序询问，命中第一个。
    /// entry 节点不会调用此方法，而是直接执行。
    /// </summary>
    Task<bool> CanRunAsync(TaskPipelineContext<TState> context, CancellationToken token);

    Task<TaskPipelineNodeResult> ExecuteAsync(TaskPipelineContext<TState> context, CancellationToken token);
}

public sealed class DelegateTaskPipelineHandler<TState> : ITaskPipelineHandler<TState>
{
    readonly Func<TaskPipelineContext<TState>, CancellationToken, Task<bool>> canRun;
    readonly Func<TaskPipelineContext<TState>, CancellationToken, Task<TaskPipelineNodeResult>> execute;

    public DelegateTaskPipelineHandler(
        string name,
        Func<TaskPipelineContext<TState>, CancellationToken, Task<bool>> canRun,
        Func<TaskPipelineContext<TState>, CancellationToken, Task<TaskPipelineNodeResult>> execute)
    {
        if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("任务处理器名称不能为空", nameof(name));
        Name = name;
        this.canRun = canRun ?? throw new ArgumentNullException(nameof(canRun));
        this.execute = execute ?? throw new ArgumentNullException(nameof(execute));
    }

    public string Name { get; }
    public Task<bool> CanRunAsync(TaskPipelineContext<TState> context, CancellationToken token) => canRun(context, token);
    public Task<TaskPipelineNodeResult> ExecuteAsync(TaskPipelineContext<TState> context, CancellationToken token) => execute(context, token);
}

public sealed class TaskPipelineNode<TState>
{
    public TaskPipelineNode(
        string name,
        string handler,
        IReadOnlyList<string>? next = null,
        IReadOnlyList<string>? onError = null,
        IReadOnlyList<string>? exceededNext = null,
        int maxAttempts = 1,
        int maxTimes = -1,
        TimeSpan? timeout = null,
        TimeSpan? preDelay = null,
        TimeSpan? postDelay = null,
        bool enabled = true)
    {
        if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("任务节点名不能为空", nameof(name));
        if (string.IsNullOrWhiteSpace(handler)) throw new ArgumentException("任务节点处理器不能为空", nameof(handler));
        if (maxAttempts < 1) throw new ArgumentOutOfRangeException(nameof(maxAttempts));
        if (maxTimes == 0 || maxTimes < -1) throw new ArgumentOutOfRangeException(nameof(maxTimes));

        Name = name;
        Handler = handler;
        Next = next ?? [];
        OnError = onError ?? [];
        ExceededNext = exceededNext ?? [];
        MaxAttempts = maxAttempts;
        MaxTimes = maxTimes;
        Timeout = timeout ?? System.Threading.Timeout.InfiniteTimeSpan;
        PreDelay = preDelay ?? TimeSpan.Zero;
        PostDelay = postDelay ?? TimeSpan.Zero;
        Enabled = enabled;
        ValidateDelay(PreDelay, nameof(preDelay));
        ValidateDelay(PostDelay, nameof(postDelay));
        if (Timeout <= TimeSpan.Zero && Timeout != System.Threading.Timeout.InfiniteTimeSpan)
            throw new ArgumentOutOfRangeException(nameof(timeout));
    }

    public string Name { get; }
    public string Handler { get; }
    public IReadOnlyList<string> Next { get; }
    public IReadOnlyList<string> OnError { get; }
    public IReadOnlyList<string> ExceededNext { get; }
    public int MaxAttempts { get; }
    public int MaxTimes { get; }
    public TimeSpan Timeout { get; }
    public TimeSpan PreDelay { get; }
    public TimeSpan PostDelay { get; }
    public bool Enabled { get; }

    static void ValidateDelay(TimeSpan value, string name)
    {
        if (value < TimeSpan.Zero || value > TimeSpan.FromMinutes(5))
            throw new ArgumentOutOfRangeException(name);
    }
}

/// <summary>
/// 受限的 MAA 风格任务执行器：next 是有顺序候选分支，节点动作由强类型 handler 提供。
/// 它刻意不理解地图、路线和 UI，只负责生命周期、重试、超时和分支。
/// </summary>
public sealed class TaskPipeline<TState>
{
    readonly TaskPipelineDefinition definition;
    readonly IReadOnlyDictionary<string, TaskPipelineNode<TState>> nodes;
    readonly IReadOnlyDictionary<string, ITaskPipelineHandler<TState>> handlers;
    readonly Action<TaskPipelineEvent>? eventSink;

    public TaskPipeline(
        TaskPipelineDefinition definition,
        IEnumerable<ITaskPipelineHandler<TState>> handlers,
        Action<TaskPipelineEvent>? eventSink = null)
    {
        this.definition = definition ?? throw new ArgumentNullException(nameof(definition));
        if (handlers is null) throw new ArgumentNullException(nameof(handlers));
        var handlerList = handlers.ToList();
        this.handlers = handlerList.ToDictionary(x => x.Name, StringComparer.OrdinalIgnoreCase);
        if (this.handlers.Count != handlerList.Count)
            throw new ArgumentException("任务处理器名称重复", nameof(handlers));
        this.eventSink = eventSink;

        nodes = definition.Nodes
            .Select(node => new TaskPipelineNode<TState>(
                node.Name,
                node.Handler,
                node.Next,
                node.OnError,
                node.ExceededNext,
                node.MaxAttempts,
                node.MaxTimes,
                node.TimeoutMs == -1 ? Timeout.InfiniteTimeSpan : TimeSpan.FromMilliseconds(node.TimeoutMs),
                TimeSpan.FromMilliseconds(node.PreDelayMs),
                TimeSpan.FromMilliseconds(node.PostDelayMs),
                node.Enabled))
            .ToDictionary(x => x.Name, StringComparer.OrdinalIgnoreCase);

        foreach (var node in nodes.Values)
        {
            if (!this.handlers.ContainsKey(node.Handler))
                throw new InvalidDataException($"任务节点 {node.Name} 引用了未知处理器：{node.Handler}");
        }
    }

    public async Task<TaskPipelineExecutionResult> RunAsync(
        TState state,
        CancellationToken cancellationToken = default)
    {
        var runId = Guid.NewGuid().ToString("N");
        var hitCounts = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        var transitions = 0;
        string? current = definition.Entry;
        string? lastNode = null;
        Emit(new(TaskPipelineEventKind.Started, runId, null, 0, 0, TimeSpan.Zero, null));

        try
        {
            while (current is not null)
            {
                cancellationToken.ThrowIfCancellationRequested();
                if (++transitions > definition.MaxTransitions)
                {
                    var error = $"任务流水线超过最大跳转次数 {definition.MaxTransitions}";
                    Emit(new(TaskPipelineEventKind.Failed, runId, lastNode, 0, transitions, TimeSpan.Zero, error));
                    return new(TaskPipelineExecutionStatus.TransitionLimitReached, runId, lastNode, transitions, error);
                }

                if (!nodes.TryGetValue(current, out var node))
                    return Fail(runId, lastNode, transitions, $"任务流水线找不到节点：{current}");
                if (!node.Enabled)
                {
                    current = await SelectNextAsync(node.Next, state, runId, transitions, hitCounts, cancellationToken);
                    continue;
                }

                lastNode = node.Name;
                if (node.MaxTimes > 0 && hitCounts.TryGetValue(node.Name, out var currentHits) && currentHits >= node.MaxTimes)
                {
                    current = await SelectNextAsync(node.ExceededNext, state, runId, transitions, hitCounts, cancellationToken);
                    if (current is null)
                    {
                        Emit(new(TaskPipelineEventKind.Completed, runId, lastNode, 0, transitions, TimeSpan.Zero, null));
                        return new(TaskPipelineExecutionStatus.Succeeded, runId, lastNode, transitions, null);
                    }
                    continue;
                }

                var completed = false;
                string? lastError = null;
                for (var attempt = 1; attempt <= node.MaxAttempts; attempt++)
                {
                    cancellationToken.ThrowIfCancellationRequested();
                    if (attempt == 1 && node.PreDelay > TimeSpan.Zero)
                        await Task.Delay(node.PreDelay, cancellationToken);

                    var stopwatch = Stopwatch.StartNew();
                    Emit(new(TaskPipelineEventKind.NodeStarted, runId, node.Name, attempt, transitions, TimeSpan.Zero, null));
                    try
                    {
                        var context = new TaskPipelineContext<TState>(state, runId, node.Name, attempt, transitions, hitCounts);
                        using var nodeCancellation = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
                        if (node.Timeout != Timeout.InfiniteTimeSpan)
                            nodeCancellation.CancelAfter(node.Timeout);
                        var result = await handlers[node.Handler].ExecuteAsync(context, nodeCancellation.Token);
                        if (!result.Succeeded)
                        {
                            lastError = result.Error ?? "任务节点返回失败";
                            Emit(new(TaskPipelineEventKind.NodeFailed, runId, node.Name, attempt, transitions, stopwatch.Elapsed, lastError));
                        }
                        else
                        {
                            completed = true;
                            hitCounts[node.Name] = hitCounts.TryGetValue(node.Name, out var hits) ? hits + 1 : 1;
                            Emit(new(TaskPipelineEventKind.NodeSucceeded, runId, node.Name, attempt, transitions, stopwatch.Elapsed, null));
                        }
                    }
                    catch (OperationCanceledException) when (cancellationToken.IsCancellationRequested)
                    {
                        throw;
                    }
                    catch (OperationCanceledException)
                    {
                        lastError = $"节点超时（>{node.Timeout.TotalMilliseconds:0}ms）";
                        Emit(new(TaskPipelineEventKind.NodeFailed, runId, node.Name, attempt, transitions, stopwatch.Elapsed, lastError));
                    }
                    catch (Exception ex)
                    {
                        lastError = ex.Message;
                        Emit(new(TaskPipelineEventKind.NodeFailed, runId, node.Name, attempt, transitions, stopwatch.Elapsed, lastError));
                    }

                    if (completed) break;
                    if (attempt < node.MaxAttempts)
                    {
                        Emit(new(TaskPipelineEventKind.NodeRetrying, runId, node.Name, attempt, transitions, stopwatch.Elapsed, lastError));
                        if (node.PostDelay > TimeSpan.Zero)
                            await Task.Delay(node.PostDelay, cancellationToken);
                    }
                }

                if (!completed)
                {
                    current = await SelectNextAsync(node.OnError, state, runId, transitions, hitCounts, cancellationToken);
                    if (current is null)
                        return Fail(runId, lastNode, transitions, lastError ?? $"节点 {node.Name} 执行失败");
                    continue;
                }

                if (node.PostDelay > TimeSpan.Zero)
                    await Task.Delay(node.PostDelay, cancellationToken);
                var hitCount = hitCounts[node.Name];
                var branch = node.MaxTimes > 0 && hitCount >= node.MaxTimes ? node.ExceededNext : node.Next;
                current = await SelectNextAsync(branch, state, runId, transitions, hitCounts, cancellationToken);
                if (current is null)
                {
                    Emit(new(TaskPipelineEventKind.Completed, runId, lastNode, 0, transitions, TimeSpan.Zero, null));
                    return new(TaskPipelineExecutionStatus.Succeeded, runId, lastNode, transitions, null);
                }
            }

            Emit(new(TaskPipelineEventKind.Completed, runId, lastNode, 0, transitions, TimeSpan.Zero, null));
            return new(TaskPipelineExecutionStatus.Succeeded, runId, lastNode, transitions, null);
        }
        catch (OperationCanceledException) when (cancellationToken.IsCancellationRequested)
        {
            Emit(new(TaskPipelineEventKind.Canceled, runId, lastNode, 0, transitions, TimeSpan.Zero, "流水线已取消"));
            return new(TaskPipelineExecutionStatus.Canceled, runId, lastNode, transitions, "流水线已取消");
        }
    }

    async Task<string?> SelectNextAsync(
        IReadOnlyList<string> candidates,
        TState state,
        string runId,
        int transitions,
        Dictionary<string, int> hitCounts,
        CancellationToken token)
    {
        foreach (var candidate in candidates)
        {
            if (!nodes.TryGetValue(candidate, out var node) || !node.Enabled) continue;
            if (node.MaxTimes > 0 && hitCounts.TryGetValue(node.Name, out var hits) && hits >= node.MaxTimes) continue;
            if (!handlers.TryGetValue(node.Handler, out var handler)) continue;
            var context = new TaskPipelineContext<TState>(state, runId, node.Name, 0, transitions, hitCounts);
            if (await handler.CanRunAsync(context, token)) return node.Name;
        }
        return null;
    }

    TaskPipelineExecutionResult Fail(string runId, string? lastNode, int transitions, string error)
    {
        Emit(new(TaskPipelineEventKind.Failed, runId, lastNode, 0, transitions, TimeSpan.Zero, error));
        return new(TaskPipelineExecutionStatus.Failed, runId, lastNode, transitions, error);
    }

    void Emit(TaskPipelineEvent value)
    {
        try { eventSink?.Invoke(value); } catch { /* 事件订阅不应破坏任务本身 */ }
    }
}

public sealed class TaskPipelineDefinition
{
    public int Version { get; set; }
    public string Name { get; set; } = "";
    public string Entry { get; set; } = "";
    public int MaxTransitions { get; set; } = 10000;
    public List<TaskPipelineNodeDefinition> Nodes { get; set; } = [];
}

public sealed class TaskPipelineNodeDefinition
{
    public string Name { get; set; } = "";
    public string Handler { get; set; } = "";
    public List<string> Next { get; set; } = [];
    public List<string> OnError { get; set; } = [];
    public List<string> ExceededNext { get; set; } = [];
    public bool Enabled { get; set; } = true;
    public int MaxAttempts { get; set; } = 1;
    public int MaxTimes { get; set; } = -1;
    public int TimeoutMs { get; set; } = -1;
    public int PreDelayMs { get; set; }
    public int PostDelayMs { get; set; }
}

public static class TaskPipelineDefinitionLoader
{
    static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNameCaseInsensitive = true,
        ReadCommentHandling = JsonCommentHandling.Skip,
        AllowTrailingCommas = true
    };

    public static TaskPipelineDefinition Load(string path)
    {
        if (string.IsNullOrWhiteSpace(path)) throw new ArgumentException("任务流水线配置路径不能为空", nameof(path));
        if (!File.Exists(path)) throw new FileNotFoundException("任务流水线配置不存在", path);
        TaskPipelineDefinition? definition;
        try { definition = JsonSerializer.Deserialize<TaskPipelineDefinition>(File.ReadAllText(path), JsonOptions); }
        catch (JsonException ex) { throw new InvalidDataException($"任务流水线 JSON 无法解析：{path}", ex); }
        if (definition is null) throw new InvalidDataException($"任务流水线配置为空：{path}");
        Validate(definition, path);
        return definition;
    }

    static void Validate(TaskPipelineDefinition definition, string path)
    {
        if (definition.Version != 1) throw new InvalidDataException($"不支持的任务流水线版本 {definition.Version}：{path}");
        if (string.IsNullOrWhiteSpace(definition.Name)) throw new InvalidDataException($"任务流水线缺少 name：{path}");
        if (string.IsNullOrWhiteSpace(definition.Entry)) throw new InvalidDataException($"任务流水线缺少 entry：{path}");
        if (definition.MaxTransitions < 1 || definition.MaxTransitions > 1_000_000)
            throw new InvalidDataException($"任务流水线 maxTransitions 必须在 1~1000000：{path}");
        if (definition.Nodes.Count == 0) throw new InvalidDataException($"任务流水线没有节点：{path}");

        var names = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        foreach (var node in definition.Nodes)
        {
            if (string.IsNullOrWhiteSpace(node.Name)) throw new InvalidDataException($"任务流水线存在空节点名：{path}");
            if (!names.Add(node.Name)) throw new InvalidDataException($"任务流水线节点名重复：{node.Name}（{path}）");
            if (string.IsNullOrWhiteSpace(node.Handler)) throw new InvalidDataException($"节点 {node.Name} 缺少 handler：{path}");
            if (node.MaxAttempts < 1 || node.MaxAttempts > 100) throw new InvalidDataException($"节点 {node.Name} 的 maxAttempts 必须在 1~100：{path}");
            if (node.MaxTimes == 0 || node.MaxTimes < -1) throw new InvalidDataException($"节点 {node.Name} 的 maxTimes 必须为 -1 或正数：{path}");
            if (node.TimeoutMs < -1 || node.TimeoutMs > 24 * 60 * 60 * 1000) throw new InvalidDataException($"节点 {node.Name} 的 timeoutMs 无效：{path}");
            if (node.PreDelayMs < 0 || node.PreDelayMs > 5 * 60 * 1000 || node.PostDelayMs < 0 || node.PostDelayMs > 5 * 60 * 1000)
                throw new InvalidDataException($"节点 {node.Name} 的延时必须在 0~300000ms：{path}");
        }

        if (!names.Contains(definition.Entry)) throw new InvalidDataException($"entry 引用了不存在的节点：{definition.Entry}（{path}）");
        foreach (var node in definition.Nodes)
            foreach (var reference in node.Next.Concat(node.OnError).Concat(node.ExceededNext))
                if (!names.Contains(reference)) throw new InvalidDataException($"节点 {node.Name} 引用了不存在的后继：{reference}（{path}）");
    }
}
