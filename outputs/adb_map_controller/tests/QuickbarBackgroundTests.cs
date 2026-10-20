using System.Drawing;
using Xunit;

namespace AdbMapController.Tests;

[Collection("Native OCR")]
public sealed class QuickbarBackgroundTests
{
    [Fact]
    public void QuantityBoundsFollowTheMatchedSlot()
    {
        var mining = AdbScreenAnalyzer.BottomToolQuantityBounds(new Size(1920, 1080), new Point(704, 998));
        var fog = AdbScreenAnalyzer.BottomToolQuantityBounds(new Size(1920, 1080), new Point(1122, 1001));
        var scroll = AdbScreenAnalyzer.BottomToolQuantityBounds(new Size(1920, 1080), new Point(1264, 998));
        Assert.Equal(mining.Size, scroll.Size);
        Assert.Equal(mining.Size, fog.Size);
        Assert.Equal(mining.X + (1122 - 704), fog.X);
        Assert.Equal(mining.X + (1264 - 704), scroll.X);
        Assert.Equal(mining.Y + 3, fog.Y);

        var narrow = AdbScreenAnalyzer.BottomToolQuantityBounds(new Size(1280, 800), new Point(470, 739));
        Assert.Equal(55, narrow.Width);
        Assert.Equal(27, narrow.Height);
    }

    [Fact]
    public void QuickbarAlignmentComesDirectlyFromResolution()
    {
        var fullHd = QuickbarBackground.AlignmentFor(new Size(1920, 1080));
        Assert.Equal(1.6875, fullHd.Scale, 4);
        Assert.Equal(445, fullHd.X);
        Assert.Equal(937, fullHd.Y);

        var half = QuickbarBackground.AlignmentFor(new Size(960, 540));
        Assert.Equal(.84375, half.Scale, 5);
        Assert.Equal(223, half.X);
        Assert.Equal(468, half.Y);

        var narrow = QuickbarBackground.AlignmentFor(new Size(1280, 800));
        Assert.Equal(1280d / 1136d, narrow.Scale, 5);
        Assert.Equal(296, narrow.X);
        Assert.Equal(704, narrow.Y);
    }
    [Fact]
    public void OriginalSpriteRemovesEmptySlotButKeepsScrollAndCount()
    {
        var asset = Path.Combine(AppContext.BaseDirectory, "vision", "quickbar-background.png");
        using var background = new QuickbarBackground(asset);
        using var empty = Frame("quickbar-empty.png");
        using var occupied = Frame("quickbar-escape-one.png");
        var quantity = new Rectangle(1258, 1040, 83, 40);

        using var emptyForeground = background.RemoveFromQuantity(empty, quantity);
        Assert.Null(emptyForeground);
        using var occupiedForeground = background.RemoveFromQuantity(occupied, quantity);
        Assert.NotNull(occupiedForeground);
        Assert.Equal(quantity.Size, occupiedForeground.Size);
    }

    [Theory]
    [InlineData(BottomToolKind.Mining, 1)]
    [InlineData(BottomToolKind.FogReveal, 0)]
    [InlineData(BottomToolKind.EscapeScroll, 1)]
    [Trait("Category", "NativeOCR")]
    public async Task BottomToolCountIsReadFromCapturedFrame(BottomToolKind kind, int expected)
    {
        using var frame = Frame("quickbar-escape-one.png");
        using var analyzer = new AdbScreenAnalyzer();
        var tool = await analyzer.FindBottomToolAsync(frame, kind);
        Assert.NotNull(tool);
        Assert.Equal(expected, tool.Quantity);
    }

    [Fact]
    [Trait("Category", "NativeOCR")]
    public async Task MiningCountIsReadFromRuntimeFrame()
    {
        using var frame = Frame("quickbar-mining-runtime.png");
        using var analyzer = new AdbScreenAnalyzer();
        var tool = await analyzer.FindBottomToolAsync(frame, BottomToolKind.Mining);
        Assert.NotNull(tool);
        Assert.Equal(1, tool.Quantity);
    }

    static Bitmap Frame(string name)
        => new(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", name));
}
