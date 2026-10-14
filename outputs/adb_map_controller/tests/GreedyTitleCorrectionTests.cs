namespace AdbMapController.Tests;

public sealed class GreedyTitleCorrectionTests
{
    [Theory]
    [InlineData("贪婪抉择")]
    [InlineData("贪婪块择")]
    [InlineData("贪婪执择")]
    [InlineData("含婪块择")]
    [InlineData(" 含 婪 块 择 ")]
    [InlineData("●贪婪块择●")]
    public void RecordedOcrTitleVariantsAreRecognized(string text)
        => Assert.True(PopupRecognition.IsGreedySelectionTitle(text));

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("贪婪的抉择")]
    [InlineData("贪婪选择")]
    [InlineData("含婪选择")]
    [InlineData("勇敢抉择")]
    [InlineData("关于贪婪块择的公告")]
    [InlineData("贪婪块择公告")]
    [InlineData("含婪块择 返回城镇 安全回城")]
    [InlineData("下一层")]
    public void UnrelatedOrEmbeddedNearMatchesAreRejected(string? text)
    {
        Assert.False(PopupRecognition.IsGreedySelectionTitle(text));
        Assert.Equal(text, GreedyTitleCorrector.CorrectTitleLines(text));
    }

    [Theory]
    [InlineData("贪婪抉择")]
    [InlineData("贪婪块择")]
    [InlineData("贪婪执择")]
    [InlineData("含婪块择")]
    public void RecordedVariantsAreCorrectedToTheCanonicalTitle(string rawTitle)
        => Assert.Equal("贪婪抉择", GreedyTitleCorrector.CorrectTitleLines(rawTitle));

    [Fact]
    public void CorrectionPreservesOtherLinesAndRawOcrResult()
    {
        const string raw = "含婪块择\r\n角色等级110\n前往下一层";
        var recognition = new PaddleOcrRecognition(raw, Array.Empty<PaddleOcrWord>());
        Assert.Equal("贪婪抉择\r\n角色等级110\n前往下一层",
            GreedyTitleCorrector.CorrectTitleLines(recognition.Text));
        Assert.Equal(raw, recognition.Text);
    }

    [Theory]
    [InlineData("贪婪块择")]
    [InlineData("贪婪执择")]
    [InlineData("含婪块择")]
    public void RecordedTitleErrorsDoNotMisclassifyGreedyAsPlainNextFloor(string rawTitle)
    {
        using var frame = new System.Drawing.Bitmap(System.IO.Path.Combine(
            AppContext.BaseDirectory,"Fixtures","Visual","greedy-mixed-continue-return.png"));
        Assert.Equal(NextFloorDialogKind.GreedySelection,
            PopupRecognition.ClassifyNextFloorDialog(frame,rawTitle,
                "继续探险 前往下一层 返回城镇 安全回城"));
        Assert.Equal(new[] { 1 },PopupRecognition.FindGreedySelectionReturnCards(frame));
    }

    [Fact]
    public void MissingTitleStillClassifiesThreeRewardCardsAsGreedySelection()
    {
        using var frame = new System.Drawing.Bitmap(System.IO.Path.Combine(
            AppContext.BaseDirectory, "Fixtures", "Visual", "greedy-continue-only.png"));
        const string body = "继续探险|继续探险|继续探险|随机获得一份回复药剂|随机获得一个道具|随机获得一个增益效果|前往下一层|前往下一层|前往下一层";
        Assert.Equal(NextFloorDialogKind.GreedySelection,
            PopupRecognition.ClassifyNextFloorDialog(frame, null, body));
    }
}
