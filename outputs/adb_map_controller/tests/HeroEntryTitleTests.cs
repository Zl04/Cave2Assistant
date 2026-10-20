using System.Drawing;
using System.Reflection;

namespace AdbMapController.Tests;


[Collection("Native OCR")]
public sealed class HeroEntryTitleTests
{
    [Fact]
    public async Task SelectedMudCorridorScreenshotResolvesHeroEntry()
    {
        using var frame = new Bitmap(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", "hero-mud-corridor.png"));
        using var adb = new AdbClient();
        var automation = new DungeonEntryAutomation(adb, null!, 0, null!, _ => { }, _ => { });
        var method = typeof(DungeonEntryAutomation).GetMethod("ReadSelectedEntry", BindingFlags.Instance | BindingFlags.NonPublic)!;
        var heroMap = DungeonEntryCatalog.Maps.Single(map => map.IsHeroVariant);
        var selected = await (Task<DungeonEntryOption?>)method.Invoke(automation, [frame, heroMap.Id])!;
        Assert.NotNull(selected);
        Assert.Equal(3, selected.Id);
    }
}
