namespace AdbMapController.Tests;

public sealed class PipelineBaselineTests
{
    static MaaPipelineCatalog Catalog() => MaaPipelineCatalogLoader.Load(Path.Combine(AppContext.BaseDirectory, "Fixtures", "maa-semantics.json"));
    static MaaPipeline<object> Maa(List<string> calls, Func<MaaPipelineTask, CancellationToken, Task<MaaPipelineActionResult>>? action = null,
        Func<MaaPipelineTask, Task<MaaPipelineRecognitionResult>>? recognize = null, IMaaPipelineTraceSink? trace = null) => new(Catalog(),
        [new DelegateMaaPipelineHandler<object>("test", (task, _, _) => recognize?.Invoke(task) ?? Task.FromResult(MaaPipelineRecognitionResult.Hit()),
            (task, _, _, token) => { calls.Add(task.Name); return action?.Invoke(task, token) ?? Task.FromResult(MaaPipelineActionResult.Success()); })],
        new MaaPipelineExecutionOptions { RetryInterval = TimeSpan.FromMilliseconds(1), MaxTransitions = 10 }, trace);

    [Fact]
    public async Task MaaOrdersParentActionSubAndNext()
    {
        var calls = new List<string>();
        Assert.True((await Maa(calls).RunAsync(new object(), ["Parent"])).Succeeded);
        Assert.Equal(new[] { "Parent", "Child", "Tail" }, calls);
    }

    [Fact]
    public async Task MaaMaxTimesBranchesBeforeSecondActionAndSequentialRunsResetCounts()
    {
        var calls = new List<string>(); var pipeline = Maa(calls);
        var first = await pipeline.RunAsync(new object(), ["Limited"]);
        var second = await pipeline.RunAsync(new object(), ["Limited"]);
        Assert.True(first.Succeeded && second.Succeeded);
        Assert.NotEqual(first.RunId, second.RunId);
        Assert.Equal(new[] { "Limited", "Tail", "Limited", "Tail" }, calls);
    }

    [Fact]
    public async Task MaaTimeoutDoesNotBoundAction()
    {
        var calls = new List<string>();
        var result = await Maa(calls, async (_, token) => { await Task.Delay(30, token); return MaaPipelineActionResult.Success(); })
            .RunAsync(new object(), ["Action"]).WaitAsync(TimeSpan.FromSeconds(5));
        Assert.True(result.Succeeded); // task timeout=1ms is NOT an action cancellation deadline.
    }

    [Fact]
    public async Task MaaMissRetriesUntilPreviousTaskDeadlineThenUsesOnError()
    {
        var calls = new List<string>(); var trace = new MaaPipelineTraceCollector();
        var result = await Maa(calls, recognize: _ => Task.FromResult(MaaPipelineRecognitionResult.Miss()), trace: trace)
            .RunAsync(new object(), ["Entry"]).WaitAsync(TimeSpan.FromSeconds(5));
        Assert.True(result.Succeeded);
        Assert.Equal(new[] { "Entry", "Recovery" }, calls);
        Assert.Contains(trace.Events, x => x.Kind == MaaPipelineTraceKind.Retrying);
    }

    [Fact]
    public async Task MaaStopSkipsHandlerAction()
    {
        var calls = new List<string>();
        Assert.Equal(MaaPipelineExecutionStatus.Stopped, (await Maa(calls).RunAsync(new object(), ["Stop"])).Status);
        Assert.Empty(calls);
    }

    [Fact]
    public async Task MaaOwnerCancellationReturnsCanceledAndHandlerFinallyRuns()
    {
        using var owner = new CancellationTokenSource();
        var released = false;
        var result = await Maa([], async (_, token) => { try { owner.Cancel(); await Task.Delay(Timeout.Infinite, token); return MaaPipelineActionResult.Success(); } finally { released = true; } })
            .RunAsync(new object(), ["Action"], owner.Token);
        Assert.Equal(MaaPipelineExecutionStatus.Canceled, result.Status);
        Assert.True(released);
    }

    [Fact]
    public async Task MaaTraceSubscriberFailureDoesNotChangeOutcome()
    {
        Assert.True((await Maa([], trace: new DelegateMaaPipelineTraceSink(_ => throw new IOException("trace"))).RunAsync(new object(), ["Action"])).Succeeded);
    }

    static TaskPipeline<object> Legacy(Func<CancellationToken, Task<TaskPipelineNodeResult>> execute, int attempts = 1, int timeout = -1,
        Func<Task<bool>>? canRun = null) => new(new TaskPipelineDefinition { Entry = "Entry", Nodes = [new TaskPipelineNodeDefinition { Name = "Entry", Handler = "test", MaxAttempts = attempts, TimeoutMs = timeout }] },
        [new DelegateTaskPipelineHandler<object>("test", (_, _) => canRun?.Invoke() ?? Task.FromResult(true), (_, token) => execute(token))]);

    [Fact]
    public async Task TaskEntryDoesNotCallRecognitionAndRetriesReturnedFailure()
    {
        var attempts = 0;
        var result = await Legacy(_ => Task.FromResult(++attempts == 1 ? TaskPipelineNodeResult.Failure("first") : TaskPipelineNodeResult.Success()), 2,
            canRun: () => throw new InvalidOperationException("entry must skip recognition")).RunAsync(new object());
        Assert.True(result.Succeeded); Assert.Equal(2, attempts);
    }

    [Fact]
    public async Task TaskCooperativeTimeoutRetriesAndReleasesEachAttempt()
    {
        var released = 0;
        var result = await Legacy(async token => { try { await Task.Delay(Timeout.Infinite, token); return TaskPipelineNodeResult.Success(); } finally { released++; } }, 2, 20)
            .RunAsync(new object()).WaitAsync(TimeSpan.FromSeconds(5));
        Assert.Equal(TaskPipelineExecutionStatus.Failed, result.Status);
        Assert.Equal(2, released);
    }

    [Fact]
    public async Task TaskIgnoredCancellationMayStillSucceed()
    {
        using var owner = new CancellationTokenSource();
        var result = await Legacy(_ => { owner.Cancel(); return Task.FromResult(TaskPipelineNodeResult.Success()); }).RunAsync(new object(), owner.Token);
        Assert.True(result.Succeeded); // There is no final post-handler cancellation check.
    }

    [Fact]
    public async Task TaskObservedOwnerCancellationDoesNotRetry()
    {
        using var owner = new CancellationTokenSource(); var attempts = 0;
        var result = await Legacy(token => { attempts++; owner.Cancel(); token.ThrowIfCancellationRequested(); return Task.FromResult(TaskPipelineNodeResult.Success()); }, 3)
            .RunAsync(new object(), owner.Token);
        Assert.Equal(TaskPipelineExecutionStatus.Canceled, result.Status); Assert.Equal(1, attempts);
    }

    [Fact]
    public async Task UiPipelineRetriesTimeoutThenFallsBackUsingSameFrame()
    {
        var frame = new object(); var seen = new List<UiPipelineContext<object>>();
        var pipeline = new UiPipeline<object, string>("none", [
            new("slow", "wrong", async (context, token) => { seen.Add(context); await Task.Delay(Timeout.Infinite, token); return true; }, 2, TimeSpan.FromMilliseconds(20)),
            new("fallback", "safe", (context, _) => { seen.Add(context); return Task.FromResult(true); })]);
        var result = await pipeline.RunAsync(frame, 42).WaitAsync(TimeSpan.FromSeconds(5));
        Assert.Equal("safe", result.Value); Assert.Equal(3, result.Attempts.Count);
        Assert.All(result.Attempts.Take(2), x => Assert.True(x.TimedOut));
        Assert.All(seen, x => { Assert.Same(frame, x.Frame); Assert.Same(seen[0], x); Assert.Equal(42, x.FrameId); });
    }
}
