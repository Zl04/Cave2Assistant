using System.Collections.Concurrent;
using System.Globalization;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace AdbMapController;

/// <summary>
/// MAA ProcessTask 风格运行时。识别和设备动作由 handler 提供，
/// 任务编译、候选优先级、sub/next 分支、次数、重试和可观测事件由此类统一管理。
/// </summary>
public sealed class MaaPipeline<TState>
{
    readonly MaaPipelineCatalog catalog;
    readonly IReadOnlyDictionary<string, IMaaPipelineHandler<TState>> handlers;
    readonly IMaaPipelineTraceSink? trace;
    readonly MaaPipelineExecutionOptions options;
    public MaaPipeline(
        MaaPipelineCatalog catalog,
        IEnumerable<IMaaPipelineHandler<TState>> handlers,
        MaaPipelineExecutionOptions? options = null,
        IMaaPipelineTraceSink? trace = null)
    {
        this.catalog = catalog ?? throw new ArgumentNullException(nameof(catalog));
        var list = handlers?.ToList() ?? throw new ArgumentNullException(nameof(handlers));
        this.handlers = list.ToDictionary(x => x.Name, StringComparer.OrdinalIgnoreCase);
        if (this.handlers.Count != list.Count) throw new ArgumentException("handler 名称重复", nameof(handlers));
        this.options = options ?? new MaaPipelineExecutionOptions();
        if (this.options.RetryTimes < 0 || this.options.MaxTransitions < 1)
            throw new ArgumentOutOfRangeException(nameof(options));
        this.trace = trace;
    }

    // Each invocation owns counters, branches and trace identity. Catalog and
    // handler bindings are immutable and may be reused across invocations.
    public Task<MaaPipelineExecutionResult> RunAsync(TState state,
        IEnumerable<string> entryTasks, CancellationToken token = default)
        => new Execution(catalog, handlers, options, trace).RunAsync(state, entryTasks, token);

    sealed class Execution(MaaPipelineCatalog catalog,
        IReadOnlyDictionary<string, IMaaPipelineHandler<TState>> handlers,
        MaaPipelineExecutionOptions options, IMaaPipelineTraceSink? trace)
    {
        readonly Dictionary<string, int> executionCounts = new(StringComparer.OrdinalIgnoreCase);
        readonly object countLock = new();
        int taskId;
        int transitions;
        string runId = "";
        string? lastTask;

        public async Task<MaaPipelineExecutionResult> RunAsync(
            TState state,
            IEnumerable<string> entryTasks,
            CancellationToken token = default)
        {
            var entries = entryTasks?.Where(x => !string.IsNullOrWhiteSpace(x)).ToArray()
                ?? throw new ArgumentNullException(nameof(entryTasks));
            if (entries.Length == 0) throw new ArgumentException("至少需要一个入口任务", nameof(entryTasks));
            foreach (var name in entries) _ = catalog.Get(name);

            runId = Guid.NewGuid().ToString("N");
            taskId = 0;
            transitions = 0;
            lastTask = null;
            lock (countLock) executionCounts.Clear();
            Emit(new(MaaPipelineTraceKind.TaskChainStarted, runId, options.TaskChain, 0, null, null, 0, 0,
                TimeSpan.Zero, null, null, null, null, null, null, null, null, null));

            IReadOnlyList<string> candidates = entries;
            IReadOnlyList<string> onErrorCandidates = [];
            var nextTimeoutMs = 0;
            var nextRateLimitMs = 0;
            try
            {
                while (candidates.Count > 0)
                {
                    token.ThrowIfCancellationRequested();
                    if (++transitions > options.MaxTransitions)
                    {
                        var error = $"MAA Pipeline 超过最大跳转次数 {options.MaxTransitions}";
                        EmitFailure(error);
                        return new(MaaPipelineExecutionStatus.TransitionLimitReached, runId, lastTask, taskId, transitions, error);
                    }

                    var outcome = await FindAndRunAsync(state, candidates, token, followNext: false,
                        parentTask: null, nextTimeoutMs, nextRateLimitMs);
                    switch (outcome.Kind)
                    {
                        case MaaTaskRunKind.Success:
                            candidates = outcome.Task?.Next.ToArray() ?? [];
                            onErrorCandidates = outcome.Task?.OnErrorNext.ToArray() ?? [];
                            nextTimeoutMs = outcome.Task?.TimeoutMs ?? 0;
                            nextRateLimitMs = outcome.Task?.RateLimitMs ?? 0;
                            EmitBranch(outcome.Task, candidates);
                            break;
                        case MaaTaskRunKind.Runout:
                            candidates = outcome.Task?.ExceededNext.ToArray() ?? [];
                            onErrorCandidates = [];
                            nextTimeoutMs = 0;
                            nextRateLimitMs = 0;
                            EmitBranch(outcome.Task, candidates);
                            break;
                        case MaaTaskRunKind.Failed:
                            candidates = outcome.Task?.OnErrorNext.ToArray() ?? [];
                            onErrorCandidates = [];
                            nextTimeoutMs = 0;
                            nextRateLimitMs = 0;
                            if (candidates.Count == 0)
                            {
                                EmitFailure(outcome.Error ?? "任务执行失败");
                                return new(MaaPipelineExecutionStatus.Failed, runId, lastTask, taskId, transitions, outcome.Error);
                            }
                            EmitBranch(outcome.Task, candidates);
                            break;
                        case MaaTaskRunKind.NoMatch:
                            if (onErrorCandidates.Count > 0)
                            {
                                EmitBranch(outcome.Task, onErrorCandidates);
                                candidates = onErrorCandidates;
                                onErrorCandidates = [];
                                nextTimeoutMs = 0;
                                nextRateLimitMs = 0;
                                break;
                            }
                            var noMatch = "入口候选任务在重试后仍未命中";
                            EmitFailure(noMatch);
                            return new(MaaPipelineExecutionStatus.Failed, runId, lastTask, taskId, transitions, noMatch);
                        case MaaTaskRunKind.Interrupted:
                            Emit(new(MaaPipelineTraceKind.Stopped, runId, options.TaskChain, taskId, lastTask, null, 0, 0,
                                TimeSpan.Zero, null, null, null, null, "Stop", outcome.Error, outcome.Error, null, null));
                            return new(MaaPipelineExecutionStatus.Stopped, runId, lastTask, taskId, transitions, outcome.Error);
                    }
                }

                Emit(new(MaaPipelineTraceKind.TaskChainCompleted, runId, options.TaskChain, taskId, lastTask, null, 0,
                    0, TimeSpan.Zero, null, null, null, null, null, null, null, null, null));
                return new(MaaPipelineExecutionStatus.Succeeded, runId, lastTask, taskId, transitions, null);
            }
            catch (OperationCanceledException) when (token.IsCancellationRequested)
            {
                Emit(new(MaaPipelineTraceKind.Canceled, runId, options.TaskChain, taskId, lastTask, null, 0, 0,
                    TimeSpan.Zero, null, null, null, null, null, null, "Pipeline 已取消", null, null));
                return new(MaaPipelineExecutionStatus.Canceled, runId, lastTask, taskId, transitions, "Pipeline 已取消");
            }
        }

        async Task<MaaTaskRunOutcome> FindAndRunAsync(
            TState state,
            IReadOnlyList<string> candidates,
            CancellationToken token,
            bool followNext,
            string? parentTask,
            int timeoutMs,
            int rateLimitMs)
        {
            var overall = System.Diagnostics.Stopwatch.StartNew();
            var retry = 0;
            while (true)
            {
                foreach (var name in candidates)
                {
                    token.ThrowIfCancellationRequested();
                    var task = catalog.Get(name);
                    if (!task.Enabled) continue;
                    var handler = GetHandler(task);
                    var context = CreateContext(state, task, parentTask, retry, GetCount(task.Name));
                    Emit(new(MaaPipelineTraceKind.CandidateRecognizing, runId, options.TaskChain, context.TaskId, task.Name,
                        parentTask, retry, context.ExecutionCount, TimeSpan.Zero, null, null, task.Roi, null, null, null, null, null, null,
                        candidates));
                    var stopwatch = System.Diagnostics.Stopwatch.StartNew();
                    MaaPipelineRecognitionResult recognition;
                    try
                    {
                        recognition = task.Algorithm == MaaPipelineAlgorithm.JustReturn
                            ? MaaPipelineRecognitionResult.Hit(detail: "JustReturn")
                            : await handler.RecognizeAsync(task, context, token);
                    }
                    catch (Exception ex) when (ex is not OperationCanceledException)
                    {
                        Emit(new(MaaPipelineTraceKind.NodeFailed, runId, options.TaskChain, context.TaskId, task.Name, parentTask,
                            retry, context.ExecutionCount, stopwatch.Elapsed, false, null, task.Roi, null, task.Action.ToString(), null, ex.Message, null, null));
                        return new(MaaTaskRunKind.Failed, task, ex.Message);
                    }

                    Emit(new(MaaPipelineTraceKind.CandidateRecognized, runId, options.TaskChain, context.TaskId, task.Name,
                        parentTask, retry, context.ExecutionCount, stopwatch.Elapsed, recognition.Matched, recognition.Score,
                        recognition.Box ?? task.Roi, recognition.Text, task.Action.ToString(), recognition.Detail, null,
                        recognition.EvidencePath, recognition.FrameId, candidates));
                    if (!recognition.Matched) continue;

                    if (GetCount(task.Name) >= task.MaxTimes)
                    {
                        Emit(new(MaaPipelineTraceKind.LimitExceeded, runId, options.TaskChain, context.TaskId, task.Name, parentTask,
                            retry, GetCount(task.Name), stopwatch.Elapsed, true, recognition.Score, recognition.Box, recognition.Text,
                            task.Action.ToString(), $"达到 maxTimes={task.MaxTimes}", null, recognition.EvidencePath, recognition.FrameId));
                        return new(MaaTaskRunKind.Runout, task, null);
                    }

                    var result = await ExecuteAsync(state, task, recognition, token, parentTask, retry);
                    if (result.Kind != MaaTaskRunKind.NoMatch) return result;
                }

                if (timeoutMs >= 0 && overall.ElapsedMilliseconds >= timeoutMs)
                    return new(MaaTaskRunKind.NoMatch, null, null);

                retry++;
                Emit(new(MaaPipelineTraceKind.Retrying, runId, options.TaskChain, taskId, parentTask, null, retry, 0,
                    overall.Elapsed, null, null, null, null, null, null, $"等待候选节点（{retry}）", null, null, null));
                var requestedDelay = rateLimitMs > 0 ? rateLimitMs : (int)Math.Max(0, options.RetryInterval.TotalMilliseconds);
                if (requestedDelay > 0)
                {
                    var delay = timeoutMs < 0
                        ? requestedDelay
                        : Math.Min(requestedDelay, Math.Max(1, timeoutMs - (int)overall.ElapsedMilliseconds));
                    await Task.Delay(delay, token);
                }
            }
        }

        async Task<MaaTaskRunOutcome> ExecuteAsync(
            TState state,
            MaaPipelineTask task,
            MaaPipelineRecognitionResult recognition,
            CancellationToken token,
            string? parentTask,
            int attempt)
        {
            var id = taskId++;
            var executionCount = Increment(task.Name);
            lastTask = task.Name;
            var context = CreateContext(state, task, parentTask, attempt, executionCount, id);
            var stopwatch = System.Diagnostics.Stopwatch.StartNew();
            Emit(new(MaaPipelineTraceKind.NodeStarted, runId, options.TaskChain, id, task.Name, parentTask, attempt,
                executionCount, TimeSpan.Zero, true, recognition.Score, recognition.Box, recognition.Text, task.Action.ToString(), null, null,
                recognition.EvidencePath, recognition.FrameId));

            try
            {
                if (task.PreDelayMs > 0) await Task.Delay(task.PreDelayMs, token);
                Emit(new(MaaPipelineTraceKind.ActionStarted, runId, options.TaskChain, id, task.Name, parentTask, attempt,
                    executionCount, stopwatch.Elapsed, true, recognition.Score, recognition.Box, recognition.Text, task.Action.ToString(), null, null,
                    recognition.EvidencePath, recognition.FrameId));

                MaaPipelineActionResult action;
                if (task.Action == MaaPipelineAction.Stop) action = MaaPipelineActionResult.Stop();
                else
                {
                    var handler = GetHandler(task);
                    action = await handler.ExecuteAsync(task, recognition, context, token);
                }
                if (action.Interrupted)
                {
                    Emit(new(MaaPipelineTraceKind.Stopped, runId, options.TaskChain, id, task.Name, parentTask, attempt,
                        executionCount, stopwatch.Elapsed, true, recognition.Score, recognition.Box, recognition.Text, task.Action.ToString(),
                        action.Error, action.Error, recognition.EvidencePath, recognition.FrameId));
                    return new(MaaTaskRunKind.Interrupted, task, action.Error);
                }
                if (!action.Succeeded) return FailNode(task, context, recognition, stopwatch.Elapsed, action.Error ?? "动作执行失败");

                foreach (var sub in task.Sub)
                {
                    var child = await FindAndRunAsync(state, [sub], token, followNext: false, task.Name, 0, 0);
                    if (child.Kind is MaaTaskRunKind.Failed or MaaTaskRunKind.NoMatch or MaaTaskRunKind.Interrupted)
                    {
                        if (!task.SubErrorIgnored)
                            return FailNode(task, context, recognition, stopwatch.Elapsed, child.Error ?? $"子任务失败：{sub}");
                    }
                }

                if (task.PostDelayMs > 0) await Task.Delay(task.PostDelayMs, token);
                foreach (var other in task.ReduceOtherTimes) Decrement(other);
                Emit(new(MaaPipelineTraceKind.NodeCompleted, runId, options.TaskChain, id, task.Name, parentTask, attempt,
                    executionCount, stopwatch.Elapsed, true, recognition.Score, recognition.Box, recognition.Text, task.Action.ToString(), null, null,
                    recognition.EvidencePath, recognition.FrameId));
                return new(MaaTaskRunKind.Success, task, null);
            }
            catch (OperationCanceledException) when (token.IsCancellationRequested)
            {
                throw;
            }
            catch (Exception ex)
            {
                return FailNode(task, context, recognition, stopwatch.Elapsed, ex.Message);
            }
        }

        MaaTaskRunOutcome FailNode(
            MaaPipelineTask task,
            MaaPipelineTaskContext<TState> context,
            MaaPipelineRecognitionResult recognition,
            TimeSpan duration,
            string error)
        {
            Emit(new(MaaPipelineTraceKind.NodeFailed, runId, options.TaskChain, context.TaskId, task.Name, context.ParentTask,
                context.Attempt, context.ExecutionCount, duration, true, recognition.Score, recognition.Box, recognition.Text,
                task.Action.ToString(), null, error, recognition.EvidencePath, recognition.FrameId));
            return new(MaaTaskRunKind.Failed, task, error);
        }

        IMaaPipelineHandler<TState> GetHandler(MaaPipelineTask task)
            => handlers.TryGetValue(task.Handler, out var handler)
                ? handler
                : throw new InvalidDataException($"任务 {task.Name} 没有注册 handler：{task.Handler}");

        MaaPipelineTaskContext<TState> CreateContext(
            TState state,
            MaaPipelineTask task,
            string? parentTask,
            int attempt,
            int executionCount,
            int? id = null)
            => new(state, runId, options.TaskChain, task.Name, id ?? taskId, parentTask, attempt, executionCount,
                new Dictionary<string, int>(executionCounts, StringComparer.OrdinalIgnoreCase));

        int GetCount(string name)
        {
            lock (countLock) return executionCounts.TryGetValue(name, out var value) ? value : 0;
        }

        int Increment(string name)
        {
            lock (countLock)
            {
                executionCounts[name] = GetCount(name) + 1;
                return executionCounts[name];
            }
        }

        void Decrement(string name)
        {
            lock (countLock)
                if (executionCounts.TryGetValue(name, out var value)) executionCounts[name] = Math.Max(0, value - 1);
        }

        void EmitBranch(MaaPipelineTask? task, IReadOnlyList<string> candidates)
        {
            Emit(new(MaaPipelineTraceKind.BranchSelected, runId, options.TaskChain, taskId, task?.Name, null, 0,
                task is null ? 0 : GetCount(task.Name), TimeSpan.Zero, null, null, null, null, null,
                task is null ? null : string.Join(",", candidates), null, null, null, candidates));
        }

        void EmitFailure(string error)
        {
            Emit(new(MaaPipelineTraceKind.TaskChainFailed, runId, options.TaskChain, taskId, lastTask, null, 0, 0,
                TimeSpan.Zero, null, null, null, null, null, null, error, null, null));
        }

        void Emit(MaaPipelineTraceEvent value)
        {
            try { trace?.Write(value); } catch { /* trace 不得破坏自动化 */ }
        }

        enum MaaTaskRunKind
        {
            Success,
            Runout,
            Failed,
            NoMatch,
            Interrupted
        }

        sealed record MaaTaskRunOutcome(MaaTaskRunKind Kind, MaaPipelineTask? Task, string? Error);

    }
}
