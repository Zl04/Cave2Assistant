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
            ExecutionTasks = [new() { EntryId = 3, EntryRunCount = 2, TargetStopFloor = 10 }, new() { TaskEnabled = false, TaskKind = ExecutionTaskKind.CurrentMapRun, EntryId = 1, EntryDifficulty = DungeonDifficulty.Elite, Mining = true }],
        };

        store.Save(expected);
        var actual = store.Load();

        Assert.NotNull(actual);
        Assert.Equal(expected.Theme, actual.Theme);
        Assert.Equal(expected.Device, actual.Device);
        Assert.Equal(expected.AttackBoss, actual.AttackBoss);
        Assert.Equal(expected.EntryDifficulty, actual.EntryDifficulty);
        Assert.Equal(expected.BonusPriority, actual.BonusPriority);
        Assert.Equal(new[] { 3, 1 }, actual.ExecutionTasks.Select(x => x.EntryId));
        Assert.Equal(2, actual.ExecutionTasks[0].EntryRunCount);
        Assert.Equal(10, actual.ExecutionTasks[0].TargetStopFloor);
        Assert.True(actual.ExecutionTasks[1].Mining);
        Assert.True(actual.ExecutionTasks[0].TaskEnabled);
        Assert.False(actual.ExecutionTasks[1].TaskEnabled);
        Assert.Equal(ExecutionTaskKind.CurrentMapRun, actual.ExecutionTasks[1].TaskKind);
        Assert.Equal(ExecutionTaskKind.EntryAndRun, actual.ExecutionTasks[0].TaskKind);
        Assert.Equal(DungeonDifficulty.Normal, actual.ExecutionTasks[1].EntryDifficulty);
    }

    [Fact]
    public void LegacyTasksDefaultToEnabled()
    {
        var settings = System.Text.Json.JsonSerializer.Deserialize<ControllerSettings>("{\"ExecutionTasks\":[{\"EntryId\":3}]}")!;
        Assert.True(settings.ExecutionTasks[0].TaskEnabled);
    }

    [Fact]
    public void EternalWinterSweepTaskRoundTripsFloorAndCount()
    {
        Directory.CreateDirectory(directory);
        var store = new JsonSettingsStore(Path.Combine(directory, "settings.json"));
        store.Save(new ControllerSettings
        {
            TaskTemplates = [new TaskTemplate
            {
                Name = "测试模板",
                Tasks = [new ControllerSettings
                {
                    TaskKind = ExecutionTaskKind.EternalWinterSweep,
                    EternalWinterFloor = 4,
                    EternalWinterSweepCount = 2
                }]
            }]
        });

        var task = Assert.Single(Assert.Single(store.Load()!.TaskTemplates).Tasks);
        Assert.Equal(4, task.EternalWinterFloor);
        Assert.Equal(2, task.EternalWinterSweepCount);
    }

    [Fact]
    public void MissingDifficultyDefaultsToNormal()
    {
        Directory.CreateDirectory(directory);
        var path = Path.Combine(directory, "settings.json");
        File.WriteAllText(path, """
            {"ExecutionTasks":[
              {"EntryDifficulty":"Normal"},
              {},
              {"EntryDifficulty":"Nightmare"}]}
            """);
        var actual = new JsonSettingsStore(path).Load()!;
        Assert.Equal(DungeonDifficulty.Normal, actual.EntryDifficulty);
        Assert.Equal(new[] { DungeonDifficulty.Normal, DungeonDifficulty.Normal, DungeonDifficulty.Nightmare },
            actual.ExecutionTasks.Select(task => task.EntryDifficulty));
        new JsonSettingsStore(path).Save(actual);
        Assert.Equal(DungeonDifficulty.Normal, new JsonSettingsStore(path).Load()!.ExecutionTasks[0].EntryDifficulty);
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
