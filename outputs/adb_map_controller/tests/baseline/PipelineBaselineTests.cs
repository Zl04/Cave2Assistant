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

}
