namespace AdbMapController.Tests;

public sealed class SettingsFailureBaselineTests : IDisposable
{
    readonly string directory = Path.Combine(AppContext.BaseDirectory, "fixture-work-" + Guid.NewGuid().ToString("N"));
    public SettingsFailureBaselineTests() => Directory.CreateDirectory(directory);

    [Fact]
    public void MissingOrCorruptSettingsReturnsNull()
    {
        var store = new JsonSettingsStore(Path.Combine(directory, "settings.json"));
        Assert.Null(store.Load());
        File.WriteAllText(Path.Combine(directory, "settings.json"), "not-json");
        Assert.Null(store.Load());
    }

    [Fact]
    public void FailedSaveDoesNotThrowOrLeaveTemporaryFile()
    {
        var path = Path.Combine(directory, "absent-parent", "settings.json");
        Assert.Null(Record.Exception(() => new JsonSettingsStore(path).Save(new ControllerSettings())));
        Assert.False(File.Exists(path + ".tmp"));
    }

    [Fact]
    public void SuccessfulSaveRetainsContractAndReplacesExistingFile()
    {
        var path = Path.Combine(directory, "settings.json"); var store = new JsonSettingsStore(path);
        store.Save(new ControllerSettings { Device = "first", AttackBoss = true });
        store.Save(new ControllerSettings { Device = "second", AttackBoss = false });
        Assert.Equal("second", store.Load()!.Device);
        Assert.False(store.Load()!.AttackBoss);
        Assert.False(File.Exists(path + ".tmp"));
    }

    public void Dispose()
    {
        var root = Path.GetFullPath(AppContext.BaseDirectory).TrimEnd(Path.DirectorySeparatorChar) + Path.DirectorySeparatorChar;
        if (!Path.GetFullPath(directory).StartsWith(root, StringComparison.OrdinalIgnoreCase)) throw new InvalidOperationException("Unsafe fixture path");
        if (Directory.Exists(directory)) Directory.Delete(directory, recursive: true);
    }
}
