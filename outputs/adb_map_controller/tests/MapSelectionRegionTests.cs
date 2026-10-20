using System.Drawing;
namespace AdbMapController.Tests;
public sealed class MapSelectionRegionTests
{
    [Theory]
    [InlineData(4, "void-map-selection.png", 1004, 565)]
    [InlineData(4, "void-map-selection.png", 1920, 1080)]
    [InlineData(4, "void-map-selection.png", 2560, 1440)]
    [InlineData(5, "primal-map-selection.png", 1004, 565)]
    [InlineData(5, "primal-map-selection.png", 1920, 1080)]
    [InlineData(5, "primal-map-selection.png", 2560, 1440)]
    public void SpecialMapContainsNodesAndExcludesDifficultyButtons(int mapId, string fixture, int width, int height)
    {
        using var source = new Bitmap(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", fixture));
        using var frame = new Bitmap(source, width, height);
        var nodes = VisualNodeLocator.FindMapNodes(frame, mapId);
        var gold = VisualNodeLocator.FindGoldNodeBadges(frame, mapId);
        var region = MapSelectionRegion.ForFrame(mapId, width, height);
        Assert.All(nodes.Concat(gold), node => Assert.True(region.Contains(node.Center)));
        var expected = mapId == 4 ? new[] { (1015, 575), (1575, 443) } : new[] { (1017, 495) };
        Assert.DoesNotContain(nodes.Concat(gold), node => node.Center.X / (double)width > .82 && node.Center.Y / (double)height > .5);
        foreach (var (x, y) in expected)
            Assert.Contains(nodes, node => node.Bounds.Contains(new Point((int)(x * width / 1920.0), (int)(y * height / 1080.0))));
        Assert.Empty(gold); // 这两张截图中的关卡徽章为蓝色/红色，金色难度按钮不应成为候选。
    }

    [Theory]
    [InlineData(1004, 565)]
    [InlineData(1600, 900)]
    [InlineData(1920, 1080)]
    [InlineData(2560, 1440)]
    public void NormalTimeGateIncludesUpperSelectedNodeAndLowerRoute(int width, int height)
    {
        using var source = new Bitmap(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", "time-gate-161.png"));
        using var frame = new Bitmap(source, width, height);
        var nodes = VisualNodeLocator.FindBlueNodeBadges(frame, DungeonEntryCatalog.TimeGateMapId)
            .Concat(VisualNodeLocator.FindMapNodes(frame, DungeonEntryCatalog.TimeGateMapId)).ToArray();
        var region = MapSelectionRegion.ForFrame(DungeonEntryCatalog.TimeGateMapId, width, height);
        Assert.Equal(region, MapSelectionRegion.ForFrame(1, width, height));
        Assert.All(nodes, node => Assert.True(region.Contains(node.Center)));
        foreach (var (x, y) in new[] { (764, 327), (983, 481), (780, 607), (1138, 641), (1210, 405), (1559, 472), (1625, 245) })
            Assert.True(nodes.Any(node => Math.Abs(node.Center.X / (double)width - x / 1920.0) < .025 &&
                Math.Abs(node.Center.Y / (double)height - y / 1080.0) < .04),
                $"Missing {x},{y}. Found: {string.Join(";", nodes.Select(n => n.Center))}");
    }

    [Theory]
    [InlineData(1004, 565)]
    [InlineData(1600, 900)]
    [InlineData(1920, 1080)]
    [InlineData(2560, 1440)]
    public void HeroMapIncludesAllThreeChests(int width, int height)
    {
        using var source = new Bitmap(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", "hero-mud-corridor.png"));
        using var frame = new Bitmap(source, width, height);
        var nodes = VisualNodeLocator.FindMapNodes(frame, DungeonEntryCatalog.TimeGateHeroMapId);
        Assert.Equal(3, nodes.Count);
        var region = MapSelectionRegion.ForFrame(DungeonEntryCatalog.TimeGateHeroMapId, width, height);
        Assert.All(nodes, node => Assert.True(region.Contains(node.Center)));
        foreach (var (x, y) in new[] { (735.0, 509.0), (1203.0, 273.0), (1510.0, 727.0) })
            Assert.True(nodes.Any(node => Math.Abs(node.Center.X / (double)width - x / 1920) < .025 &&
                Math.Abs(node.Center.Y / (double)height - y / 1080) < .04),
                $"Missing ({x},{y}); found {string.Join(";", nodes.Select(n => n.Center))}");
    }

    [Theory]
    [InlineData(1004, 565)]
    [InlineData(1600, 900)]
    [InlineData(1920, 1080)]
    [InlineData(2560, 1440)]
    public void TwistedMapPreservesItsSwordNodesAndExcludesHelp(int width, int height)
    {
        using var source = new Bitmap(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", "twisted-layer-selection.png"));
        using var frame = new Bitmap(source, width, height);
        var nodes = VisualNodeLocator.FindMapNodes(frame, 2);
        foreach (var (x, y) in new[] { (.580, .286), (.526, .495), (.765, .458) })
            Assert.True(nodes.Any(node => Math.Abs(node.Center.X / (double)width - x) < .025 &&
                Math.Abs(node.Center.Y / (double)height - y) < .025));
        Assert.DoesNotContain(nodes, node => Math.Abs(node.Center.X / (double)width - .704) < .035 &&
            Math.Abs(node.Center.Y / (double)height - .145) < .055);
    }
}
