using System.Text.Json;

namespace AdbMapController.Tests;

public sealed class PipelineContractTests : IDisposable
{
    readonly string directory = Path.Combine(AppContext.BaseDirectory, "pipeline-fixture-" + Guid.NewGuid().ToString("N"));
    string Fixture(string name, string json)
    {
        Directory.CreateDirectory(directory);
        var path = Path.Combine(directory, name);
        File.WriteAllText(path, json);
        return path;
    }

    [Fact]
    public void InheritanceAtPrefixAndListExpressionsKeepOrder()
    {
        var catalog = MaaPipelineCatalogLoader.Load(Fixture("tasks.json", """
            {"Base":{"algorithm":"JustReturn","handler":"fake","next":["Tail"],"timeout":123},
             "Tail":{"algorithm":"JustReturn"},
             "Derived":{"baseTask":"Base","timeout":456},
             "Prefix@Base":{},
             "Expression":{"algorithm":"JustReturn","next":["(Base + Tail) ^ Tail","Tail * 2","#none"]}}
            """));
        Assert.Equal(456, catalog.Get("Derived").TimeoutMs);
        Assert.Equal("fake", catalog.Get("Derived").Handler);
        Assert.Equal(new[] { "Tail" }, catalog.Get("Derived").Next);
        Assert.Equal(new[] { "Prefix@Tail" }, catalog.Get("Prefix@Base").Next);
        Assert.Equal(MaaPipelineAlgorithm.JustReturn, catalog.Get("Prefix@Tail").Algorithm);
        Assert.Equal(new[] { "Base", "Tail" }, catalog.Get("Expression").Next);
    }

    [Fact]
    public void MultiFileMergeAndExplicitBaseReplacementRemainDifferent()
    {
        var first = Fixture("first.json", """
            {"Task":{"algorithm":"JustReturn","handler":"first","timeout":100},
             "Base":{"algorithm":"JustReturn","handler":"base","timeout":200}}
            """);
        var merge = MaaPipelineCatalogLoader.Load(new[] { first, Fixture("merge.json", """{"Task":{"timeout":300}}""") });
        Assert.Equal("first", merge.Get("Task").Handler);
        Assert.Equal(300, merge.Get("Task").TimeoutMs);
        var replace = MaaPipelineCatalogLoader.Load(new[] { first, Fixture("replace.json", """{"Task":{"baseTask":"Base"}}""") });
        Assert.Equal("base", replace.Get("Task").Handler);
        Assert.Equal(200, replace.Get("Task").TimeoutMs);
    }

    [Theory]
    [InlineData("{\"A\":{\"baseTask\":\"B\"},\"B\":{\"baseTask\":\"A\"}}")]
    [InlineData("{\"A\":{\"next\":[\"Missing\"]}}")]
    [InlineData("{\"A\":{\"action\":\"ClickRect\"}}")]
    [InlineData("{\"A\":{\"algorithm\":\"OCR\"}}")]
    public void InvalidCatalogFailsBeforeAnyAction(string json)
        => Assert.Throws<InvalidDataException>(() => MaaPipelineCatalogLoader.Load(Fixture("invalid.json", json)));

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public async Task SubFailureIsIgnoredOnlyWhenConfigured(bool ignore)
    {
        var json = $$$"""
            {"Parent":{"algorithm":"JustReturn","handler":"fake","sub":["Child"],"subErrorIgnored":{{{ignore.ToString().ToLowerInvariant()}}},"next":["Tail"],"onErrorNext":["Recovery"]},
             "Child":{"algorithm":"JustReturn","handler":"fake"},
             "Tail":{"algorithm":"JustReturn","handler":"fake"},
             "Recovery":{"algorithm":"JustReturn","handler":"fake"}}
            """;
        var calls = new List<string>();
        var pipeline = Runtime(MaaPipelineCatalogLoader.Load(Fixture("sub.json", json)), calls,
            task => task.Name == "Child" ? MaaPipelineActionResult.Failure("child") : MaaPipelineActionResult.Success());
        Assert.True((await pipeline.RunAsync(new object(), ["Parent"])).Succeeded);
        Assert.Equal(new[] { "Parent", "Child", ignore ? "Tail" : "Recovery" }, calls);
    }

    [Fact]
    public async Task CandidatesUseDeclaredPriorityAndDisabledNodesAreSkipped()
    {
        var catalog = MaaPipelineCatalogLoader.Load(Fixture("priority.json", """
            {"Disabled":{"algorithm":"JustReturn","enabled":false,"handler":"fake"},
             "First":{"algorithm":"MatchTemplate","handler":"fake"},
             "Second":{"algorithm":"JustReturn","handler":"fake"}}
            """));
        var calls = new List<string>();
        Assert.True((await Runtime(catalog, calls).RunAsync(new object(), ["Disabled", "First", "Second"])).Succeeded);
        Assert.Equal(new[] { "First" }, calls);
    }

    [Fact]
    public async Task TransitionLimitStopsCyclesAndEmitsFailure()
    {
        var catalog = MaaPipelineCatalogLoader.Load(Fixture("loop.json", """
            {"Loop":{"algorithm":"JustReturn","handler":"fake","next":["Loop"]}}
            """));
        var calls = new List<string>();
        var trace = new MaaPipelineTraceCollector();
        var pipeline = Runtime(catalog, calls, trace: trace, limit: 2);
        Assert.Equal(MaaPipelineExecutionStatus.TransitionLimitReached, (await pipeline.RunAsync(new object(), ["Loop"])).Status);
        Assert.Equal(new[] { "Loop", "Loop" }, calls);
        Assert.Contains(trace.Events, x => x.Kind == MaaPipelineTraceKind.TaskChainFailed);
    }

    [Theory]
    [InlineData("map-run-pipeline.json", "RunDungeon", "RunDungeon")]
    [InlineData("dungeon-entry-pipeline.json", "DungeonEntry", "DungeonEntryStep")]
    public async Task ActualMaaResourcesLoadAndRunWithOfflineHandlers(string file, string entry, string handler)
    {
        var path = Path.Combine(AppContext.BaseDirectory, "Fixtures", "Production", file);
        var catalog = MaaPipelineCatalogLoader.Load(path);
        Assert.Equal(handler, catalog.Get(entry).Handler);
        var calls = new List<string>();
        var handlers = catalog.Names.Select(catalog.Get).Select(x => x.Handler).Distinct()
            .Select(name => new DelegateMaaPipelineHandler<object>(name,
                (_, _, _) => Task.FromResult(MaaPipelineRecognitionResult.Hit()),
                (task, _, _, _) => { calls.Add(task.Name); return Task.FromResult(MaaPipelineActionResult.Success()); }));
        var pipeline = new MaaPipeline<object>(catalog, handlers);
        Assert.True((await pipeline.RunAsync(new object(), [entry])).Succeeded);
        Assert.Equal(file.StartsWith("map-") ? new[] { "RunDungeon" } : new[] {
            "DungeonEntry", "EnsureMapOpen", "BastanMapOpened", "EnterDungeon", "SelectMapVariant",
            "SelectDifficulty", "SelectLayer", "ChallengeAndEnter", "WaitForMapLoad" }, calls);
    }

    [Theory]
    [InlineData(1)]
    [InlineData(3)]
    [InlineData(10)]
    [InlineData(11)]
    public async Task DungeonEntryRechecksMapAfterOpeningInsteadOfCompletingEarly(int opensNeeded)
    {
        var catalog = MaaPipelineCatalogLoader.Load(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Production", "dungeon-entry-pipeline.json"));
        var calls = new List<string>();
        var opens = 0;
        var handlers = catalog.Names.Select(catalog.Get).Select(x => x.Handler).Distinct()
            .Select(name => new DelegateMaaPipelineHandler<object>(name,
                (task, _, _) => Task.FromResult(task.Name == "BastanMapOpened" && opens < opensNeeded
                    ? MaaPipelineRecognitionResult.Miss() : MaaPipelineRecognitionResult.Hit()),
                (task, _, _, _) =>
                {
                    calls.Add(task.Name);
                    if (task.Name == "OpenMapButton") opens++;
                    return Task.FromResult(MaaPipelineActionResult.Success());
                }));
        var result = await new MaaPipeline<object>(catalog, handlers).RunAsync(new object(), ["DungeonEntry"]);
        if (opensNeeded > 10)
        {
            Assert.Equal(MaaPipelineExecutionStatus.Stopped, result.Status);
            Assert.DoesNotContain("EnterDungeon", calls);
            Assert.Equal(10, opens);
            return;
        }
        Assert.True(result.Succeeded);
        Assert.Contains("EnterDungeon", calls);
        Assert.Equal("WaitForMapLoad", calls.Last());
        Assert.Equal(opensNeeded, opens);
    }

    [Fact]
    public void ActualPopupResourcePreservesPriorityAttemptsAndTimeout()
    {
        var definition = UiPipelineDefinitionLoader.Load(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Production", "popup-watchdog.json"));
        Assert.Equal(new[] { "ServerError", "RiftGemSelection", "NextFloorDialog" }, definition.Nodes.Select(x => x.Name));
        Assert.Equal(new[] { 10, 20, 30 }, definition.Nodes.Select(x => x.Priority));
        Assert.All(definition.Nodes, x => { Assert.Equal(1, x.MaxAttempts); Assert.Equal(3500, x.TimeoutMs); });
    }

    [Theory]
    [InlineData("ChallengeAndEnter")]
    [InlineData("ConfirmEnter")]
    public void EntryOcrNodesDoNotRequireTemplateImages(string node)
    {
        var catalog = MaaPipelineCatalogLoader.Load(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Production", "dungeon-entry-pipeline.json"));
        var method = typeof(MaaAdbPipelineHandler<object>).GetMethod("CreateVisionTask",
            System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic)!;
        var task = (VisionTask)method.Invoke(null, [catalog.Get(node), directory])!;
        Assert.Equal(VisionAlgorithm.OcrDetect, task.Algorithm);
        Assert.Null(task.TemplatePath);
        Assert.NotEmpty(task.Text);
    }

    [Fact]
    public async Task ChallengeFailureDoesNotReportEntrySuccess()
    {
        var catalog = MaaPipelineCatalogLoader.Load(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Production", "dungeon-entry-pipeline.json"));
        var calls = new List<string>();
        var handlers = catalog.Names.Select(catalog.Get).Select(x => x.Handler).Distinct()
            .Select(name => new DelegateMaaPipelineHandler<object>(name,
                (_, _, _) => Task.FromResult(MaaPipelineRecognitionResult.Hit()),
                (task, _, _, _) =>
                {
                    calls.Add(task.Name);
                    return Task.FromResult(task.Name == "ChallengeAndEnter"
                        ? MaaPipelineActionResult.Failure("challenge unavailable") : MaaPipelineActionResult.Success());
                }));
        var result = await new MaaPipeline<object>(catalog, handlers).RunAsync(new object(), ["DungeonEntry"]);
        Assert.Equal(MaaPipelineExecutionStatus.Failed, result.Status);
        Assert.DoesNotContain("WaitForMapLoad", calls);
    }

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public async Task EntryCompletesOnMapSwitchWithOptionalConfirmation(bool confirmation)
    {
        var catalog = MaaPipelineCatalogLoader.Load(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Production", "dungeon-entry-pipeline.json"));
        var switched = !confirmation;
        var calls = new List<string>();
        var handlers = catalog.Names.Select(catalog.Get).Select(x => x.Handler).Distinct()
            .Select(name => new DelegateMaaPipelineHandler<object>(name,
                (task, _, _) => Task.FromResult(task.Name == "WaitForMapLoad" && !switched || task.Name == "ConfirmEnter" && !confirmation
                    ? MaaPipelineRecognitionResult.Miss() : MaaPipelineRecognitionResult.Hit()),
                (task, _, _, _) =>
                {
                    calls.Add(task.Name);
                    if (task.Name == "ConfirmEnter") switched = true;
                    return Task.FromResult(MaaPipelineActionResult.Success());
                }));
        var result = await new MaaPipeline<object>(catalog, handlers).RunAsync(new object(), ["ChallengeAndEnter"]);
        Assert.True(result.Succeeded);
        Assert.Equal(confirmation ? new[] { "ChallengeAndEnter", "ConfirmEnter", "WaitForMapLoad" }
            : new[] { "ChallengeAndEnter", "WaitForMapLoad" }, calls);
    }

    [Fact]
    public void EntryMapSwitchRejectsUnchangedTownStaleAndEmptySnapshots()
    {
        var method = typeof(DungeonEntryAutomation).GetMethod("HasEnteredDungeon",
            System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic)!;
        var town = new MapDump { SceneType = 1, Timestamp = 100, Width = 10, Height = 10 };
        var cave = new MapDump { SceneType = 2, Timestamp = 101, Width = 10, Height = 10,
            Level = 41, Tiles = [new List<TileInfo> { new() }] };
        bool Entered(MapDump previous, MapDump current) => (bool)method.Invoke(null, [previous, current])!;
        Assert.True(Entered(town, cave));
        Assert.False(Entered(town, town));
        Assert.False(Entered(cave, cave));
        cave.Timestamp = 99;
        Assert.False(Entered(town, cave));
        cave.Timestamp = 101;
        cave.Tiles.Clear();
        Assert.False(Entered(town, cave));
    }

    [Fact]
    public void RecognitionActionParametersAndLocalAliasPrecedenceArePreserved()
    {
        var task = MaaPipelineCatalogLoader.Load(Fixture("fields.json", """
            {"Task":{"recognition":{"type":"OCR","param":{"text":["挑战"],"threshold":0.7}},
             "action":{"type":"Click","param":{"roi":[1,2,3,4]}},"handler":"fake",
             "timeout":-1,"rateLimit":5,"rate_limit":99,"pre_delay":6,"post_delay":7,
             "cache":false,"rectMove":[5,6,7,8],"specificRect":[9,10,11,12],
             "specialParams":[1,2],"highResolutionSwipeFix":true,"template":["a.png"],
             "maskRange":[2,200],"colorScales":[[[1],[255]]],"colorWithClose":false,
             "pureColor":true,"method":["SqDiff"],"nmsDistance":3,"index":-1,"orderBy":"Vertical",
             "ocrReplace":[["a","b"]],"fullMatch":true,"replaceFull":true,"isAscii":true,
             "withoutDet":true,"useRaw":false,"binThreshold":[10,240],"count":9,"ratio":0.4,"detector":"ORB"}}
            """ )).Get("Task");
        Assert.Equal(MaaPipelineAlgorithm.OcrDetect, task.Algorithm);
        Assert.Equal(MaaPipelineAction.ClickSelf, task.Action);
        Assert.Equal(new[] { "挑战" }, task.Text);
        Assert.Equal(new[] { .7 }, task.TemplateThresholds);
        Assert.Equal(new MaaRect(1, 2, 3, 4), task.Roi);
        Assert.Equal(new MaaRect(5, 6, 7, 8), task.RectMove);
        Assert.Equal(new MaaRect(9, 10, 11, 12), task.SpecificRect);
        Assert.Equal(-1, task.TimeoutMs); Assert.Equal(5, task.RateLimitMs);
        Assert.Equal(6, task.PreDelayMs); Assert.Equal(7, task.PostDelayMs);
        Assert.False(task.Cache); Assert.True(task.HighResolutionSwipeFix);
        Assert.Equal(new[] { 1, 2 }, task.SpecialParams); Assert.Equal(new[] { "a.png" }, task.Templates);
        Assert.Equal(new[] { 2, 200 }, task.MaskRange);
        Assert.Equal(1, task.ColorScales[0][0][0]); Assert.Equal(255, task.ColorScales[0][1][0]);
        Assert.False(task.ColorWithClose); Assert.True(task.PureColor);
        Assert.Equal(new[] { "SqDiff" }, task.Methods); Assert.Equal(3, task.NmsDistance);
        Assert.Equal(-1, task.Index); Assert.Equal("Vertical", task.OrderBy);
        Assert.Equal(new[] { "a", "b" }, Assert.Single(task.OcrReplace));
        Assert.True(task.FullMatch && task.ReplaceFull && task.IsAscii && task.WithoutDet);
        Assert.False(task.UseRaw); Assert.Equal(new[] { 10, 240 }, task.BinThreshold);
        Assert.Equal(9, task.FeatureCount); Assert.Equal(.4, task.FeatureRatio); Assert.Equal("ORB", task.FeatureDetector);
    }

    [Fact]
    public void VirtualReferencesResolveSelfNoneAndOtherTaskLists()
    {
        var catalog = MaaPipelineCatalogLoader.Load(Fixture("references.json", """
            {"Base":{"algorithm":"JustReturn","next":["Tail"]},"Tail":{"algorithm":"JustReturn"},
             "Self":{"algorithm":"JustReturn","next":["#self"]},
             "Copy":{"algorithm":"JustReturn","next":["Base#next + #none"]},
             "Prefix":{"algorithm":"JustReturn"},"Prefix@Back":{"algorithm":"JustReturn","next":["#back"]}}
            """));
        Assert.Equal(new[] { "Self" }, catalog.Get("Self").Next);
        Assert.Equal(new[] { "Tail" }, catalog.Get("Copy").Next);
        Assert.Equal(new[] { "Prefix" }, catalog.Get("Prefix@Back").Next);
    }

    [Fact]
    public async Task ReduceOtherTimesAllowsExactlyOneExtraActionBeforeLimitBranch()
    {
        var catalog = MaaPipelineCatalogLoader.Load(Fixture("reduce.json", """
            {"A":{"algorithm":"JustReturn","handler":"fake","maxTimes":1,"next":["B"]},
             "B":{"algorithm":"JustReturn","handler":"fake","maxTimes":1,"next":["A"],"reduceOtherTimes":["A"],"exceededNext":["Tail"]},
             "Tail":{"algorithm":"JustReturn","handler":"fake"}}
            """));
        var calls = new List<string>();
        Assert.True((await Runtime(catalog, calls).RunAsync(new object(), ["A"])).Succeeded);
        Assert.Equal(new[] { "A", "B", "A", "Tail" }, calls);
    }

    static MaaPipeline<object> Runtime(MaaPipelineCatalog catalog, List<string> calls,
        Func<MaaPipelineTask, MaaPipelineActionResult>? execute = null, IMaaPipelineTraceSink? trace = null, int limit = 20)
        => new(catalog, [new DelegateMaaPipelineHandler<object>("fake",
            (_, _, _) => Task.FromResult(MaaPipelineRecognitionResult.Hit()),
            (task, _, _, _) => { calls.Add(task.Name); return Task.FromResult(execute?.Invoke(task) ?? MaaPipelineActionResult.Success()); })],
            new MaaPipelineExecutionOptions { MaxTransitions = limit }, trace);

    public void Dispose() { if (Directory.Exists(directory)) Directory.Delete(directory, true); }
}
