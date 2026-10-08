namespace AdbMapController.Tests;

public sealed class SettingsStoreTests : IDisposable
{
    readonly string directory = Path.Combine(Path.GetTempPath(), "adb-map-controller-tests", Guid.NewGuid().ToString("N"));

    [Fact]
    public void RoundTripsExistingSettingsContract()
    {
        Directory.CreateDirectory(directory);
        var store = new JsonSettingsStore(Path.Combine(directory, "settings.json"));
        var expected = new ControllerSettings
        {
            Theme = ThemeMode.Dark,
            Device = "emulator-5556",
            AttackBoss = false,
            EntryDifficulty = DungeonDifficulty.Nightmare,
            BonusPriority = ["物资", "道具"],
        };

        store.Save(expected);
        var actual = store.Load();

        Assert.NotNull(actual);
        Assert.Equal(expected.Theme, actual.Theme);
        Assert.Equal(expected.Device, actual.Device);
        Assert.Equal(expected.AttackBoss, actual.AttackBoss);
        Assert.Equal(expected.EntryDifficulty, actual.EntryDifficulty);
        Assert.Equal(expected.BonusPriority, actual.BonusPriority);
    }

    [Fact]
    public void InvalidJsonKeepsLegacyNullResult()
    {
        Directory.CreateDirectory(directory);
        var path = Path.Combine(directory, "settings.json");
        File.WriteAllText(path, "not-json");

        Assert.Null(new JsonSettingsStore(path).Load());
    }

    public void Dispose()
    {
        if (Directory.Exists(directory)) Directory.Delete(directory, recursive: true);
    }
}
