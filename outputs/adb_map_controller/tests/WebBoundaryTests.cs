using System.Net;
using System.Text.Json;

namespace AdbMapController.Tests;

[CollectionDefinition("Local web listener", DisableParallelization = true)]
public sealed class LocalWebCollection { }

[Collection("Local web listener")]
public sealed class WebBoundaryTests : IAsyncLifetime
{
    readonly string directory = Path.Combine(AppContext.BaseDirectory, "web-fixture-" + Guid.NewGuid().ToString("N"));
    PipelineWebServer server = null!;
    HttpClient client = null!;
    public Task InitializeAsync()
    {
        Directory.CreateDirectory(Path.Combine(directory, "web"));
        File.WriteAllText(Path.Combine(directory, "web", "pipeline.html"), "fixture page");
        server = new PipelineWebServer(Path.Combine(directory, "traces"), Path.Combine(directory, "web"), () => new[] { "fixture diagnostic" });
        server.Start();
        client = new HttpClient(new HttpClientHandler { UseProxy = false }) { BaseAddress = new Uri(server.Url!), Timeout = TimeSpan.FromSeconds(5) };
        return Task.CompletedTask;
    }

    [Fact]
    public async Task HealthPageDiagnosticsAndMissingTraceAreReadOnlyAndLoopback()
    {
        Assert.Equal("127.0.0.1", client.BaseAddress!.Host);
        Assert.Equal("fixture page", await client.GetStringAsync("/"));
        using var health = JsonDocument.Parse(await client.GetStringAsync("api/health"));
        Assert.True(health.RootElement.GetProperty("ok").GetBoolean());
        Assert.Equal(new[] { "fixture diagnostic" }, JsonSerializer.Deserialize<string[]>(await client.GetStringAsync("api/diagnostics")));
        using var missing = await client.GetAsync("api/runs/map-run-missing.json");
        Assert.Equal(HttpStatusCode.NotFound, missing.StatusCode);
    }

    [Fact]
    public async Task ValidTraceReadsOnlyFixtureAndNonGetIsRejected()
    {
        File.WriteAllText(Path.Combine(directory, "traces", "map-run-fixture.json"), "[]");
        Assert.Equal("[]", await client.GetStringAsync("api/runs/map-run-fixture.json"));
        using var response = await client.PostAsync("api/health", new StringContent("no write"));
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Theory]
    [InlineData("settings.json")]
    [InlineData("map-run-x.txt")]
    [InlineData("map-run-..%5coutside.json")]
    [InlineData("map-run-..%2foutside.json")]
    public async Task EncodedSeparatorsAndInvalidNamesCannotReadOutsideTraceDirectory(string name)
    {
        File.WriteAllText(Path.Combine(directory, "outside.json"), "secret outside trace");
        using var response = await client.GetAsync("api/runs/" + name);
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.DoesNotContain("secret outside trace", await response.Content.ReadAsStringAsync());
    }

    [Fact]
    public async Task SecondListenerFallsBackAndDisposedPrefixCanBeReacquired()
    {
        var second = new PipelineWebServer(Path.Combine(directory, "second-traces"), Path.Combine(directory, "second-web"));
        Uri secondUrl;
        try
        {
            second.Start();
            secondUrl = new Uri(second.Url!);
            Assert.Equal("127.0.0.1", secondUrl.Host);
            Assert.True(secondUrl.Port > client.BaseAddress!.Port);
        }
        finally { await second.DisposeAsync(); }
        // Re-acquire the exact prefix to prove shutdown released this test's listener.
        using var owned = new HttpListener();
        owned.Prefixes.Add(secondUrl.AbsoluteUri);
        owned.Start();
        owned.Stop();
    }

    public async Task DisposeAsync()
    {
        client?.Dispose();
        if (server is not null) await server.DisposeAsync();
        if (Directory.Exists(directory)) Directory.Delete(directory, true);
    }
}
