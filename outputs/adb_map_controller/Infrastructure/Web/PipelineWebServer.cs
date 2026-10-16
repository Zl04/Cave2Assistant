using System.Net;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace AdbMapController;

/// <summary>
/// Local-only read-only dashboard for MAA pipeline traces.
/// The listener is deliberately bound to loopback; it is not a remote control API.
/// </summary>
public sealed class PipelineWebServer : IMaaPipelineTraceSink, IMaaPipelineDebugControl, IAsyncDisposable
{
    const int PreferredPort = 17830;
    const int PortAttempts = 10;
    const int MaxLiveEvents = 2000;

    static readonly JsonSerializerOptions ApiJson = new(JsonSerializerDefaults.Web)
    {
        Converters = { new JsonStringEnumConverter() }
    };
    static readonly JsonSerializerOptions TraceJson = new()
    {
        PropertyNameCaseInsensitive = true
    };

    readonly object liveGate = new();
    readonly string traceDirectory;
    readonly string webRoot;
    readonly Func<IReadOnlyList<string>>? diagnostics;
    readonly List<MaaPipelineTraceEvent> liveEvents = [];
    readonly HashSet<string> breakpoints = new(StringComparer.OrdinalIgnoreCase);
    readonly string pipelineDirectory;
    TaskCompletionSource<bool>? resumeGate;
    bool pauseRequested;
    bool stepRequested;
    string? pausedTask;
    public Func<string, string?, Task<object>>? ControllerCommand { get; set; }
    readonly CancellationTokenSource stopSource = new();
    HttpListener? listener;
    Task? listenerTask;
    string? liveRunId;
    bool liveRunning;
    DateTimeOffset? liveStartedAt;
    DateTimeOffset? liveLastEventAt;

    public PipelineWebServer(string traceDirectory, string webRoot) : this(traceDirectory, webRoot, null) { }

    public PipelineWebServer(string traceDirectory, string webRoot, Func<IReadOnlyList<string>>? diagnostics)
    {
        this.traceDirectory = Path.GetFullPath(traceDirectory);
        this.webRoot = Path.GetFullPath(webRoot);
        pipelineDirectory = Path.GetFullPath(Path.Combine(this.webRoot, "..", "pipelines"));
        this.diagnostics = diagnostics;
    }

    public string? Url { get; private set; }

    public void Start()
    {
        if (listener is not null) return;

        Directory.CreateDirectory(traceDirectory);
        Directory.CreateDirectory(webRoot);
        Exception? lastError = null;
        for (var offset = 0; offset < PortAttempts; offset++)
        {
            var port = PreferredPort + offset;
            var candidate = new HttpListener();
            candidate.Prefixes.Add($"http://127.0.0.1:{port}/");
            try
            {
                candidate.Start();
                listener = candidate;
                Url = $"http://127.0.0.1:{port}/";
                listenerTask = ListenLoopAsync(candidate, stopSource.Token);
                return;
            }
            catch (Exception ex)
            {
                lastError = ex;
                candidate.Close();
            }
        }

        throw new InvalidOperationException("无法启动本地 Pipeline Web 页面。", lastError);
    }

    public void Write(MaaPipelineTraceEvent value)
    {
        lock (liveGate)
        {
            if (!string.Equals(liveRunId, value.RunId, StringComparison.Ordinal))
            {
                liveEvents.Clear();
                liveRunId = value.RunId;
                liveStartedAt = DateTimeOffset.Now;
                liveRunning = true;
            }

            if (liveEvents.Count >= MaxLiveEvents)
                liveEvents.RemoveAt(0);
            liveEvents.Add(value);
            liveLastEventAt = DateTimeOffset.Now;
            if (value.Kind is MaaPipelineTraceKind.TaskChainCompleted
                or MaaPipelineTraceKind.TaskChainFailed
                or MaaPipelineTraceKind.Canceled
                or MaaPipelineTraceKind.Stopped)
                liveRunning = false;
            if (!liveRunning) ReleasePause();
        }
    }

    public async Task BeforeCandidateAsync(string runId, string taskName, CancellationToken token)
    {
        Task? wait = null;
        lock (liveGate)
        {
            if (!string.Equals(liveRunId, runId, StringComparison.Ordinal)) return;
            if (pauseRequested || stepRequested || breakpoints.Contains(taskName))
            {
                pauseRequested = false;
                stepRequested = false;
                pausedTask = taskName;
                resumeGate = new(TaskCreationOptions.RunContinuationsAsynchronously);
                wait = resumeGate.Task;
            }
        }
        if (wait is not null)
        {
            try { await wait.WaitAsync(token); }
            finally { lock (liveGate) pausedTask = null; }
        }
    }

    void ReleasePause()
    {
        resumeGate?.TrySetResult(true);
        resumeGate = null;
        pausedTask = null;
    }

    async Task ListenLoopAsync(HttpListener currentListener, CancellationToken token)
    {
        while (!token.IsCancellationRequested)
        {
            HttpListenerContext context;
            try
            {
                context = await currentListener.GetContextAsync().ConfigureAwait(false);
            }
            catch (HttpListenerException) when (token.IsCancellationRequested) { break; }
            catch (ObjectDisposedException) when (token.IsCancellationRequested) { break; }
            catch (InvalidOperationException) when (token.IsCancellationRequested) { break; }
            catch { continue; }

            _ = Task.Run(() => HandleRequestAsync(context), token);
        }
    }

    async Task HandleRequestAsync(HttpListenerContext context)
    {
        try
        {
            var path = context.Request.Url?.AbsolutePath ?? "/";
            if (string.Equals(context.Request.HttpMethod, "POST", StringComparison.OrdinalIgnoreCase)
                && path.Equals("/api/debug", StringComparison.OrdinalIgnoreCase))
            {
                await HandleDebugCommandAsync(context);
                return;
            }
            if (string.Equals(context.Request.HttpMethod, "POST", StringComparison.OrdinalIgnoreCase)
                && path.Equals("/api/controller", StringComparison.OrdinalIgnoreCase))
            {
                if (ControllerCommand is null) { await WriteTextAsync(context, 503, "Controller unavailable", "text/plain; charset=utf-8"); return; }
                using var document = await JsonDocument.ParseAsync(context.Request.InputStream);
                var root = document.RootElement;
                var command = root.GetProperty("command").GetString() ?? "";
                var argument = root.TryGetProperty("argument", out var property) ? property.GetString() : null;
                await WriteJsonAsync(context, await ControllerCommand(command, argument));
                return;
            }
            if (HttpMethodsIsGet(context.Request.HttpMethod))
            {
                const string evidencePrefix = "/api/evidence/";
                if (path.StartsWith(evidencePrefix, StringComparison.OrdinalIgnoreCase))
                {
                    var fileName = Uri.UnescapeDataString(path[evidencePrefix.Length..]);
                    if (!fileName.EndsWith(".jpg", StringComparison.OrdinalIgnoreCase)
                        || !string.Equals(Path.GetFileName(fileName), fileName, StringComparison.Ordinal))
                    {
                        await WriteTextAsync(context, 400, "Invalid evidence file", "text/plain; charset=utf-8");
                        return;
                    }
                    await WriteFileAsync(context, Path.Combine(traceDirectory, "evidence", fileName), "image/jpeg");
                    return;
                }
                if (path.Equals("/api/controller", StringComparison.OrdinalIgnoreCase))
                {
                    await WriteJsonAsync(context, ControllerCommand is null ? new { error = "Controller unavailable" } : await ControllerCommand("status", null));
                    return;
                }
                if (path.Equals("/api/pipelines", StringComparison.OrdinalIgnoreCase))
                {
                    await WriteJsonAsync(context, ListPipelines());
                    return;
                }
                if (path.StartsWith("/api/pipelines/", StringComparison.OrdinalIgnoreCase))
                {
                    await WritePipelineAsync(context, Uri.UnescapeDataString(path[15..]));
                    return;
                }
                if (path == "/" || path == "/index.html")
                {
                    await WriteFileAsync(context, Path.Combine(webRoot, "pipeline.html"), "text/html; charset=utf-8");
                    return;
                }

                if (path.Equals("/api/diagnostics", StringComparison.OrdinalIgnoreCase))
                {
                    await WriteJsonAsync(context, diagnostics?.Invoke() ?? Array.Empty<string>());
                    return;
                }

                if (path.Equals("/api/health", StringComparison.OrdinalIgnoreCase))
                {
                    await WriteJsonAsync(context, new { ok = true, url = Url, now = DateTimeOffset.Now });
                    return;
                }

                if (path.Equals("/api/live", StringComparison.OrdinalIgnoreCase))
                {
                    await WriteJsonAsync(context, GetLiveSnapshot());
                    return;
                }

                if (path.Equals("/api/runs", StringComparison.OrdinalIgnoreCase))
                {
                    await WriteJsonAsync(context, ListRuns());
                    return;
                }

                const string runPrefix = "/api/runs/";
                if (path.StartsWith(runPrefix, StringComparison.OrdinalIgnoreCase))
                {
                    var fileName = Uri.UnescapeDataString(path[runPrefix.Length..]);
                    await WriteRunAsync(context, fileName);
                    return;
                }
            }

            await WriteTextAsync(context, 404, "Not found", "text/plain; charset=utf-8");
        }
        catch (Exception ex)
        {
            try { await WriteTextAsync(context, 500, ex.Message, "text/plain; charset=utf-8"); }
            catch { }
        }
        finally
        {
            context.Response.Close();
        }
    }

    object GetLiveSnapshot()
    {
        lock (liveGate)
        {
            return new
            {
                running = liveRunning,
                runId = liveRunId,
                startedAt = liveStartedAt,
                lastEventAt = liveLastEventAt,
                events = liveEvents.ToArray()
                , pausedTask,
                breakpoints = breakpoints.Order(StringComparer.OrdinalIgnoreCase).ToArray()
            };
        }
    }

    async Task HandleDebugCommandAsync(HttpListenerContext context)
    {
        using var document = await JsonDocument.ParseAsync(context.Request.InputStream);
        var root = document.RootElement;
        var command = root.TryGetProperty("command", out var value) ? value.GetString() : null;
        var task = root.TryGetProperty("task", out value) ? value.GetString() : null;
        lock (liveGate)
        {
            switch (command)
            {
                case "pause": pauseRequested = true; break;
                case "continue": pauseRequested = false; stepRequested = false; ReleasePause(); break;
                case "step": stepRequested = true; ReleasePause(); break;
                case "breakpoint" when !string.IsNullOrWhiteSpace(task):
                    if (!breakpoints.Add(task)) breakpoints.Remove(task);
                    break;
                case "clear": breakpoints.Clear(); break;
                default: context.Response.StatusCode = 400; return;
            }
        }
        await WriteJsonAsync(context, new { ok = true });
    }

    string[] ListPipelines() => Directory.Exists(pipelineDirectory)
        ? Directory.EnumerateFiles(pipelineDirectory, "*-pipeline.json").Select(Path.GetFileName).OfType<string>().Order().ToArray()
        : [];

    async Task WritePipelineAsync(HttpListenerContext context, string fileName)
    {
        if (!ListPipelines().Contains(fileName, StringComparer.OrdinalIgnoreCase))
        {
            await WriteTextAsync(context, 404, "Pipeline not found", "text/plain; charset=utf-8");
            return;
        }
        var catalog = MaaPipelineCatalogLoader.Load(Path.Combine(pipelineDirectory, fileName));
        await WriteJsonAsync(context, catalog.Names.Order().Select(catalog.Get).ToArray());
    }

    IReadOnlyList<TraceRunSummary> ListRuns()
    {
        if (!Directory.Exists(traceDirectory)) return [];

        return Directory.EnumerateFiles(traceDirectory, "*.json", SearchOption.TopDirectoryOnly)
            .Select(path =>
            {
                var info = new FileInfo(path);
                var events = ReadTrace(path);
                var last = events.LastOrDefault();
                return new TraceRunSummary(
                    info.Name,
                    events.FirstOrDefault()?.RunId ?? Path.GetFileNameWithoutExtension(info.Name),
                    info.LastWriteTimeUtc,
                    events.Count,
                    last?.Kind.ToString() ?? "Unknown",
                    last?.TaskName,
                    last?.Duration);
            })
            .OrderByDescending(x => x.ModifiedAt)
            .ToArray();
    }

    async Task WriteRunAsync(HttpListenerContext context, string fileName)
    {
        if (!IsSafeTraceFileName(fileName))
        {
            await WriteTextAsync(context, 400, "Invalid trace file", "text/plain; charset=utf-8");
            return;
        }

        var path = Path.Combine(traceDirectory, fileName);
        if (!File.Exists(path))
        {
            await WriteTextAsync(context, 404, "Trace not found", "text/plain; charset=utf-8");
            return;
        }

        await WriteJsonAsync(context, ReadTraceForReplay(path));
    }

    List<MaaPipelineTraceEvent> ReadTraceForReplay(string path)
    {
        var events = ReadTrace(path);
        if (!Path.GetFileName(path).StartsWith("entry-run-", StringComparison.OrdinalIgnoreCase)
            || !events.Any(value => value.TaskName == "EnterDungeon"
                && value.Kind == MaaPipelineTraceKind.NodeFailed && string.IsNullOrWhiteSpace(value.EvidencePath)))
            return events;

        // Older outer traces did not copy the nested entry failure evidence. Pair only
        // a uniquely timed nested trace, so an unrelated run cannot supply its image.
        var modified = File.GetLastWriteTimeUtc(path);
        var matches = Directory.EnumerateFiles(traceDirectory, "dungeon-entry-*.json")
            .Where(candidate => Math.Abs((File.GetLastWriteTimeUtc(candidate) - modified).TotalSeconds) <= 3)
            .Take(2).ToArray();
        if (matches.Length != 1) return events;
        var failure = ReadTrace(matches[0]).LastOrDefault(value =>
            (value.Kind is MaaPipelineTraceKind.NodeFailed or MaaPipelineTraceKind.TaskChainFailed)
            && !string.IsNullOrWhiteSpace(value.EvidencePath));
        if (failure?.EvidencePath is not { } evidencePath
            || !File.Exists(Path.Combine(traceDirectory, "evidence", evidencePath))) return events;
        return events.Select(value => value.TaskName == "EnterDungeon"
                && (value.Kind is MaaPipelineTraceKind.NodeFailed or MaaPipelineTraceKind.TaskChainFailed)
                && string.IsNullOrWhiteSpace(value.EvidencePath)
            ? value with { EvidencePath = evidencePath, Error = failure.Error ?? value.Error }
            : value).ToList();
    }

    List<MaaPipelineTraceEvent> ReadTrace(string path)
    {
        try
        {
            return JsonSerializer.Deserialize<List<MaaPipelineTraceEvent>>(File.ReadAllText(path), TraceJson) ?? [];
        }
        catch
        {
            return [];
        }
    }

    static bool IsSafeTraceFileName(string fileName)
        => fileName.EndsWith(".json", StringComparison.OrdinalIgnoreCase)
            && string.Equals(Path.GetFileName(fileName), fileName, StringComparison.Ordinal);

    static bool HttpMethodsIsGet(string? method)
        => string.Equals(method, "GET", StringComparison.OrdinalIgnoreCase);

    static async Task WriteFileAsync(HttpListenerContext context, string path, string contentType)
    {
        if (!File.Exists(path))
        {
            await WriteTextAsync(context, 404, "Web page not found", "text/plain; charset=utf-8");
            return;
        }

        var bytes = await File.ReadAllBytesAsync(path).ConfigureAwait(false);
        context.Response.StatusCode = 200;
        context.Response.ContentType = contentType;
        context.Response.ContentLength64 = bytes.Length;
        await context.Response.OutputStream.WriteAsync(bytes).ConfigureAwait(false);
    }

    static async Task WriteJsonAsync(HttpListenerContext context, object value)
    {
        var bytes = JsonSerializer.SerializeToUtf8Bytes(value, ApiJson);
        context.Response.StatusCode = 200;
        context.Response.ContentType = "application/json; charset=utf-8";
        context.Response.ContentLength64 = bytes.Length;
        await context.Response.OutputStream.WriteAsync(bytes).ConfigureAwait(false);
    }

    static async Task WriteTextAsync(HttpListenerContext context, int statusCode, string text, string contentType)
    {
        var bytes = Encoding.UTF8.GetBytes(text);
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = contentType;
        context.Response.ContentLength64 = bytes.Length;
        await context.Response.OutputStream.WriteAsync(bytes).ConfigureAwait(false);
    }

    public async ValueTask DisposeAsync()
    {
        stopSource.Cancel();
        try { listener?.Stop(); } catch { }
        try { listener?.Close(); } catch { }
        if (listenerTask is not null)
        {
            try { await listenerTask.ConfigureAwait(false); } catch { }
        }
        stopSource.Dispose();
        listener = null;
    }

    sealed record TraceRunSummary(
        string FileName,
        string RunId,
        DateTime ModifiedAt,
        int EventCount,
        string Status,
        string? LastTask,
        TimeSpan? Duration);
}
