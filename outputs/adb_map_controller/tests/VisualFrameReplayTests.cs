using System.Drawing;
using System.Reflection;

namespace AdbMapController.Tests;

[CollectionDefinition("Native OCR", DisableParallelization = true)]
public sealed class NativeOcrCollection { }

[Collection("Native OCR")]
public sealed class VisualFrameReplayTests
{
    [Fact]
    public async Task BundledPaddleOcrNativeRuntimeRecognizesPopupFrameWithoutDevice()
    {
        using var frame = Load("next-floor-plain-confirm.png");
        using var engine = new PaddleOcrEngine();
        var result = await engine.RecognizeAsync(frame);

        Assert.NotEmpty(result.Words);
        Assert.All(result.Words, word =>
        {
            Assert.False(string.IsNullOrWhiteSpace(word.Text));
            Assert.True(word.Width > 0);
            Assert.True(word.Height > 0);
        });
    }

    [Fact]
    public async Task UserSuppliedPopupFramesMatchTheirAnnotatedVisualAndTextClasses()
    {
        using var plainNextFloor = Load("next-floor-plain-confirm.png");
        using var gemSelection = Load("rift-gem-selection.png");
        using var greedyContinueOnly = Load("greedy-continue-only.png");
        using var greedyReturnOnly = Load("greedy-return-only.png");
        using var warningNextFloor = Load("next-floor-warning-confirm.png");
        using var greedyMixed = Load("greedy-mixed-continue-return.png");

        Assert.All(new[] { plainNextFloor, gemSelection, greedyContinueOnly, greedyReturnOnly, warningNextFloor, greedyMixed },
            frame => Assert.Equal((1004, 565), (frame.Width, frame.Height)));

        Assert.True(PopupRecognition.LooksLikeEnterNextFloorConfirmVisual(plainNextFloor));
        Assert.False(PopupRecognition.LooksLikeEnterNextFloorConfirmVisual(gemSelection));
        Assert.False(PopupRecognition.LooksLikeEnterNextFloorConfirmVisual(greedyContinueOnly));
        Assert.False(PopupRecognition.LooksLikeEnterNextFloorConfirmVisual(greedyReturnOnly));
        Assert.False(PopupRecognition.LooksLikeEnterNextFloorConfirmVisual(greedyMixed));
        Assert.Equal(NextFloorDialogKind.PlainConfirm,
            PopupRecognition.ClassifyNextFloorDialog(plainNextFloor, null, "是否进入下一层?"));
        Assert.True(PopupRecognition.LooksLikeEnterNextFloorConfirmVisual(warningNextFloor));
        Assert.Equal(NextFloorDialogKind.WarningConfirm,
            PopupRecognition.ClassifyNextFloorDialog(warningNextFloor, null,
                "是否进入下一层? 毁灭会让你失去本次的探险所得与进度"));

        Assert.True(GemTitleMatcher.IsSelectionTitle("原初试炼宝石"));
        Assert.Equal(NextFloorDialogKind.None,
            PopupRecognition.ClassifyNextFloorDialog(gemSelection, null, "原初试炼宝石"));

        Assert.True(PopupRecognition.IsGreedySelectionTitle("贪婪抉择"));
        Assert.Equal(NextFloorDialogKind.GreedySelection,
            PopupRecognition.ClassifyNextFloorDialog(greedyContinueOnly, "贪婪抉择", null));
        Assert.Empty(PopupRecognition.FindGreedySelectionReturnCards(greedyContinueOnly));
        Assert.False(PopupRecognition.IsGreedySelectionReturnOnly("前往下一层"));

        Assert.Equal(new[] { 0, 1, 2 }, PopupRecognition.FindGreedySelectionReturnCards(greedyReturnOnly));
        Assert.True(PopupRecognition.IsGreedySelectionReturnOnly("返回城镇 安全回城"));
        Assert.Equal(new[] { 1 }, PopupRecognition.FindGreedySelectionReturnCards(greedyMixed));
        Assert.False(PopupRecognition.IsGreedySelectionReturnOnly("继续探险 前往下一层 返回城镇 安全回城"));

        using var adb = new AdbClient();
        var serverDetector = typeof(AdbClient).GetMethod("HasServerErrorDialog",
            BindingFlags.Instance | BindingFlags.NonPublic, binder: null,
            types: [typeof(Bitmap), typeof(string)], modifiers: null)!;
        Assert.False(await ProbeServerError(serverDetector, adb, plainNextFloor, "是否进入下一层?"));
        Assert.False(await ProbeServerError(serverDetector, adb, gemSelection, "原初试炼宝石"));
        Assert.False(await ProbeServerError(serverDetector, adb, greedyContinueOnly, "贪婪抉择 继续探险 前往下一层"));
        Assert.False(await ProbeServerError(serverDetector, adb, greedyReturnOnly, "贪婪抉择 返回城镇 安全回城"));
        Assert.False(await ProbeServerError(serverDetector, adb, warningNextFloor,
            "是否进入下一层? 毁灭会让你失去本次的探险所得与进度"));
        Assert.False(await ProbeServerError(serverDetector, adb, greedyMixed,
            "贪婪抉择 继续探险 前往下一层 返回城镇 安全回城"));
    }

    [Fact]
    public void ActiveGameplayFrameIsNegativeForPopupColorAndTextDetectors()
    {
        var path = Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", "active-play-negative-1080x1920.png");
        using var frame = new Bitmap(path);
        Assert.Equal((1920, 1080), (frame.Width, frame.Height));

        Assert.False(PopupRecognition.LooksLikeEnterNextFloorConfirmVisual(frame));
        Assert.Empty(PopupRecognition.FindGreedySelectionReturnCards(frame));
        Assert.False(OpenCvPopupColorAnalysis.Ratio(frame, (.30, .70, .28, .72), PopupColorKind.LightNeutralPanel) >= .45
            && OpenCvPopupColorAnalysis.Ratio(frame, (.43, .57, .59, .70), PopupColorKind.GreenButton) >= .20);
        Assert.False(OpenCvPopupColorAnalysis.Ratio(frame, (.38, .62, .84, .96), PopupColorKind.GoldButton) > .35);
        Assert.Equal(NextFloorDialogKind.None, PopupRecognition.ClassifyNextFloorDialog(frame, null, null));
        Assert.False(PopupRecognition.IsGreedySelectionTitle("巴萨坦"));
        Assert.False(PopupRecognition.IsNextFloorDialogText("首领入侵活动已经开始"));
        Assert.False(PopupRecognition.IsGreedySelectionReturnOnly("活动公告"));
    }

    [Theory]
    [InlineData("是否进入下一层", true)]
    [InlineData("是否进入下一层？", true)]
    [InlineData("确认前往下一层", true)]
    [InlineData("是否进入下一层 但这是公告", true)]
    [InlineData("原初试炼宝石", false)]
    [InlineData("贪婪抉择 继续探险", false)]
    [InlineData("贪婪抉择 返回城镇", false)]
    public void NextFloorTextClassifierRejectsNearMisses(string text, bool expected)
        => Assert.Equal(expected, PopupRecognition.IsNextFloorDialogText(text));

    [Theory]
    [InlineData("贪婪抉择 继续探险 前往下一层", false)]
    [InlineData("贪婪抉择 返回城镇 安全回城", true)]
    [InlineData("返回城镇", true)]
    [InlineData("继续探险 安全回城", false)]
    [InlineData("活动公告 返回城镇", true)]
    public void GreedyReturnOnlyTextRequiresTheExistingSemanticPair(string text, bool expected)
        => Assert.Equal(expected, PopupRecognition.IsGreedySelectionReturnOnly(text));

    static Bitmap Load(string filename)
        => new(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", filename));

    [Fact]
    public async Task IdleDisconnectFrameIsRecognizedByNativeOcrAndPopupPipeline()
    {
        using var frame = Load("server-idle-disconnect.png");
        Assert.True(ConnectionPopupRecognition.IsCandidate(frame));
        Assert.True(ConnectionPopupRecognition.IsDisconnectText("闲置时间过长,已和服务器断开连接."));
        using var adb = new AdbClient();
        var result = await adb.RunPopupUiPipelineAsync(frame, 9001);
        Assert.Equal(MovementPopupKind.ServerError, result.Value);
        Assert.True(ConnectionPopupRecognition.IsDisconnectText(result.FullFrameText));
    }

    [Theory]
    [InlineData("服务器连接异常", true)]
    [InlineData("连接异常，请重新进入游戏", true)]
    [InlineData("闲置时间过长，已和服务器断开连接。", true)]
    [InlineData("闲置时间过长", false)]
    [InlineData("服务器维护公告", false)]
    [InlineData("连接正常，请继续探险", false)]
    public void DisconnectClassifierRequiresObservedSemanticPairs(string text, bool expected)
        => Assert.Equal(expected, ConnectionPopupRecognition.IsDisconnectText(text));

    static Task<bool> ProbeServerError(MethodInfo detector, AdbClient adb, Bitmap frame, string text)
        => (Task<bool>)detector.Invoke(adb, [frame, text])!;
}
