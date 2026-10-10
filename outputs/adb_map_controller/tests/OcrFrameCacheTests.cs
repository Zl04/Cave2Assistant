using Xunit;

namespace AdbMapController.Tests;

public sealed class OcrFrameCacheTests
{
    [Fact]
    public void IdenticalFrameReusesTextAndWordCoordinates()
    {
        var cache = new OcrFrameCache();
        var result = new PaddleOcrRecognition("文字", [new("文字", 1, 2, 3, 4, .9)]);
        cache.Store([1, 2, 3], result);
        Assert.Same(result, cache.Find([1, 2, 3]));
    }

    [Fact]
    public void DifferentFrameDoesNotReusePreviousRecognition()
    {
        var cache = new OcrFrameCache();
        var first = new PaddleOcrRecognition("旧帧", []);
        cache.Store([1, 2, 3], first);
        Assert.Null(cache.Find([1, 2, 4]));
        Assert.Null(cache.Find([1, 2]));
        var next = new PaddleOcrRecognition("", []);
        cache.Store([1, 2, 4], next);
        Assert.Null(cache.Find([1, 2, 3]));
        Assert.Same(next, cache.Find([1, 2, 4]));
        cache.Clear();
        Assert.Null(cache.Find([1, 2, 4]));
    }
}
