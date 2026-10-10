namespace AdbMapController;

public sealed record ApplicationPaths(string Root)
{
    public string Settings => Path.Combine(Root, "settings.json");
    public string EntryTemplates => Path.Combine(Root, "entry-templates.json");
    public string Assistant(string name) => Path.Combine(Root, "assistant", name);
    public string Pipeline(string name) => Path.Combine(Root, "pipelines", name);
    public string Trace(string name) => Path.Combine(Root, "pipeline-traces", name);
    public string Web => Path.Combine(Root, "web");
}

/// <summary>
/// Owns process-lifetime infrastructure. MainForm coordinates user intent but
/// does not construct or dispose transport adapters itself.
/// </summary>
public sealed class ControllerRuntime : IAsyncDisposable
{
    readonly object disposalGate = new();
    Task? disposal;
    public AdbClient Adb { get; }
    public TouchController Touch { get; }
    public PipelineWebServer PipelineMonitor { get; }
    public ApplicationPaths Paths { get; }
    public NonCriticalDiagnostics Diagnostics { get; } = new();

    public ControllerRuntime(string baseDirectory)
    {
        Paths = new ApplicationPaths(Path.GetFullPath(baseDirectory));
        Adb = new AdbClient();
        Touch = new TouchController(Adb);
        PipelineMonitor = new PipelineWebServer(
            Path.Combine(Paths.Root, "pipeline-traces"),
            Paths.Web, Diagnostics.Snapshot);
    }

    public ValueTask DisposeAsync()
    {
        lock (disposalGate) return new ValueTask(disposal ??= DisposeCoreAsync());
    }

    async Task DisposeCoreAsync()
    {
        var errors = new List<Exception>();
        try { Touch.Dispose(); } catch (Exception error) { errors.Add(error); }
        try { Adb.Dispose(); } catch (Exception error) { errors.Add(error); }
        try { await PipelineMonitor.DisposeAsync(); } catch (Exception error) { errors.Add(error); }
        if (errors.Count > 0) throw new AggregateException("Controller resources failed to close.", errors);
    }
}
