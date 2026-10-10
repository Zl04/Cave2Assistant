namespace AdbMapController.Tests;

public sealed class DiagnosticsTests : IDisposable
{
    readonly string directory = Path.Combine(AppContext.BaseDirectory, "diagnostic-fixture-" + Guid.NewGuid().ToString("N"));
    sealed class Clock : TimeProvider
    {
        public long Now;
        public override long TimestampFrequency => 1;
        public override long GetTimestamp() => Now;
    }

    [Fact]
    public void DiagnosticCapacityLengthRateAndSinkFailureAreBounded()
    {
        var clock = new Clock();
        var emitted = 0;
        var diagnostics = new NonCriticalDiagnostics(_ => { emitted++; throw new IOException(); }, clock);
        diagnostics.Record("first");
        diagnostics.Record("suppressed");
        Assert.Equal(new[] { "first" }, diagnostics.Snapshot());
        for (var i = 1; i <= 110; i++) { clock.Now = i * 30; diagnostics.Record(new string('x', 2000)); }
        Assert.Equal(111, emitted);
        Assert.Equal(100, diagnostics.Snapshot().Count);
        Assert.All(diagnostics.Snapshot(), x => Assert.Equal(512, x.Length));
    }

    [Fact]
    public void MissingSettingsIsSilentButMalformedSettingsIsReportedAndStillNull()
    {
        Directory.CreateDirectory(directory);
        var path = Path.Combine(directory, "settings.json");
        var errors = new List<string>();
        var store = new JsonSettingsStore(path, errors.Add);
        Assert.Null(store.Load()); Assert.Empty(errors);
        File.WriteAllText(path, "invalid-json");
        Assert.Null(store.Load());
        Assert.Contains("Settings Load: JsonException", Assert.Single(errors));
    }

    [Fact]
    public void ThrowingDiagnosticDoesNotChangeLoadSaveFailureOrTemporaryCleanup()
    {
        Directory.CreateDirectory(directory);
        var path = Path.Combine(directory, "settings.json");
        File.WriteAllText(path, "invalid-json");
        Assert.Null(new JsonSettingsStore(path, _ => throw new IOException()).Load());
        var absent = Path.Combine(directory, "absent", "settings.json");
        Assert.Null(Record.Exception(() => new JsonSettingsStore(absent, _ => throw new IOException()).Save(new ControllerSettings())));
        Assert.False(File.Exists(absent + ".tmp"));
    }

    public void Dispose() { if (Directory.Exists(directory)) Directory.Delete(directory, true); }
}
