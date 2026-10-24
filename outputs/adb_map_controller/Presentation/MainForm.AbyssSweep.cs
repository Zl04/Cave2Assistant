using System.Drawing;
using System.Text.RegularExpressions;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunAbyssSweepAsync(CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        var state = new AbyssSweepState(new MaaAdbPipelineState(adb, log: Log, saveEvidence: false));
        try
        {
            adb.Serial = devices.Text;
            popupHandling = true;
            Log("深渊秘境：开始执行扫荡任务");
            var catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("abyss-sweep-pipeline.json"));
            var trace = new MaaPipelineTraceCollector();
            string? currentStep = null;
            string? lastMiss = null;
            var progress = new DelegateMaaPipelineTraceSink(value =>
            {
                if (value.Kind == MaaPipelineTraceKind.CandidateRecognizing &&
                    value.TaskName is { } candidate && currentStep != candidate)
                {
                    currentStep = candidate;
                    lastMiss = null;
                    Log($"深渊秘境：正在{AbyssSweepStepName(candidate)}");
                }
                if (value.Kind == MaaPipelineTraceKind.CandidateRecognized && value.Matched == false)
                {
                    var detail = value.Text ?? value.Detail;
                    if (!string.IsNullOrWhiteSpace(detail))
                        lastMiss = $"{AbyssSweepStepName(value.TaskName)}：{detail[..Math.Min(detail.Length, 120)]}";
                }
                if (value.Kind == MaaPipelineTraceKind.TaskChainFailed)
                    Log($"深渊秘境：流程失败，停在{AbyssSweepStepName(currentStep)}；{lastMiss ?? value.Error ?? "原因未明"}", LogLevel.Error);
                if (value.Kind != MaaPipelineTraceKind.NodeCompleted) return;
                Log(value.TaskName switch
                {
                    "QuantityReady" => $"深渊秘境：识别到钥匙 {state.Keys} 把、当前上限 {state.Maximum} 次，计划扫荡 {state.Desired} 次",
                    "QuantitySelected" => $"深渊秘境：已核对选择次数 {state.Desired}",
                    "NoKeys" => "深渊秘境：无可用钥匙，准备关闭界面",
                    _ => $"深渊秘境：已完成{AbyssSweepStepName(value.TaskName)}"
                });
                switch (value.TaskName)
                {
                    case "OpenAbyss": state.AbyssOpen = true; break;
                    case "OpenQuantity": state.QuantityOpen = true; break;
                    case "SubmitQuantity": state.QuantityOpen = false; state.ConfirmationOpen = true; break;
                    case "ConfirmSweep": state.ConfirmationOpen = false; break;
                    case "RewardClosed": state.AbyssOpen = false; state.MapOpen = false; break;
                    case "CloseQuantity": state.QuantityOpen = false; break;
                    case "CloseAbyss": state.AbyssOpen = false; break;
                    case "CloseMap": state.MapOpen = false; break;
                }
            });
            var pipeline = new MaaPipeline<AbyssSweepState>(catalog,
                [new DelegateMaaPipelineHandler<AbyssSweepState>("AbyssSweep",
                    (task, _, ct) => RecognizeAbyssSweepAsync(task.Name, state, ct),
                    (task, _, _, ct) => ExecuteAbyssSweepAsync(task.Name, state, ct)),
                 new MaaAdbPipelineHandler<AbyssSweepState>("AbyssAdb", current => current.AdbState)],
                new MaaPipelineExecutionOptions { TaskChain = "AbyssSweep", RetryTimes = 0, MaxTransitions = 25 },
                new MaaPipelineTraceMultiplexer([trace, progress, pipelineWebServer]));
            var result = await pipeline.RunAsync(state, ["OpenMap"], token);
            trace.SaveJson(runtime.Paths.Trace($"abyss-sweep-{result.RunId}.json"));
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded)
                throw new InvalidOperationException($"{result.LastTask ?? "入口"}：{result.Error ?? result.Status.ToString()}");
            Log(state.Keys == 0 ? "深渊秘境：没有可用钥匙，跳过扫荡" : $"深渊秘境：已扫荡 {state.Desired} 次并领取战利品");
            lastEntryRunSucceeded = true;
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex) { State($"深渊秘境扫荡未完成：{ex.Message}"); }
        finally
        {
            if (state.ConfirmationOpen)
                try { await TapAbyssSweepAsync(414, 362); await Task.Delay(200); }
                catch (Exception ex) { Warn($"关闭扫荡确认弹窗失败：{ex.Message}"); }
            if (state.QuantityOpen)
                try { await TapAbyssSweepAsync(432, 377); await Task.Delay(200); }
                catch (Exception ex) { Warn($"关闭扫荡次数弹窗失败：{ex.Message}"); }
            if (state.AbyssOpen)
                try { await TapAbyssSweepAsync(925, 120); await Task.Delay(200); }
                catch (Exception ex) { Warn($"关闭深渊模式失败：{ex.Message}"); }
            if (state.MapOpen)
                try { await TapAbyssSweepAsync(900, 70); }
                catch (Exception ex) { Warn($"关闭巴萨坦地图失败：{ex.Message}"); }
            popupHandling = false;
        }
    }

    sealed class AbyssSweepState(MaaAdbPipelineState adbState)
    {
        public MaaAdbPipelineState AdbState { get; } = adbState;
        public bool MapOpen;
        public bool AbyssOpen;
        public bool QuantityOpen;
        public bool ConfirmationOpen;
        public int Keys = -1;
        public int Maximum;
        public int Desired;
    }

    async Task<MaaPipelineRecognitionResult> RecognizeAbyssSweepAsync(string name, AbyssSweepState state, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        if (name == "SetQuantity")
            return MaaPipelineRecognitionResult.Hit(detail: "流程动作");
        if (name == "HasKeys") return state.Keys > 0 ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("无钥匙");
        if (name == "NoKeys") return state.Keys == 0 ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("有钥匙");
        if (name == "OpenMap")
        {
            var map = await adb.ReadMap();
            if (!MapRunTask.IsReturnDestination(map)) throw new InvalidOperationException("当前不在城镇");
        }
        using var frame = await adb.CaptureScreenForAutomationAsync(token);
        if (name == "OpenMap")
        {
            return MaaPipelineRecognitionResult.Hit(detail: "通过通用巴萨坦地图入口定位并确认");
        }
        if (name == "MapReady")
        {
            return BastanMapOpening.IsOpen(frame)
                ? MaaPipelineRecognitionResult.Hit(detail: "巴萨坦地图已打开")
                : MaaPipelineRecognitionResult.Miss("巴萨坦地图未打开");
        }
        if (name == "RewardClosed")
        {
            var title = await ReadAbyssSweepAreaAsync(frame, new Rectangle(370, 80, 265, 75), token);
            return title.Contains("战利品", StringComparison.Ordinal)
                ? MaaPipelineRecognitionResult.Miss("战利品弹窗仍在")
                : MaaPipelineRecognitionResult.Hit(detail: "战利品弹窗已关闭");
        }
        if (name == "QuantityReady")
        {
            var keyText = await ReadAbyssSweepAreaAsync(frame, new Rectangle(470, 185, 65, 37), token);
            var maximumText = await ReadAbyssSweepAreaAsync(frame, new Rectangle(625, 275, 38, 50), token);
            var keyMatch = Regex.Match(keyText, @"\d+");
            var maxMatch = Regex.Match(maximumText, @"\d+");
            if (!keyMatch.Success || !int.TryParse(keyMatch.Value, out var keys) ||
                !maxMatch.Success || !int.TryParse(maxMatch.Value, out var maximum) || maximum < 1)
                return MaaPipelineRecognitionResult.Miss($"钥匙={keyText}，上限={maximumText}");
            state.Keys = keys;
            state.Maximum = maximum;
            state.Desired = Math.Min(keys, maximum);
            return MaaPipelineRecognitionResult.Hit(text: $"钥匙 {keys}，上限 {maximum}");
        }
        if (name == "QuantitySelected")
        {
            // 黄色数量标签随滑块移动；覆盖整条滑轨上方，避开下方的起点和上限数字。
            var selectedText = await ReadAbyssSweepAreaAsync(frame, new Rectangle(350, 220, 300, 58), token);
            var match = Regex.Match(selectedText, @"\d+");
            return match.Success && int.TryParse(match.Value, out var selected) && selected == state.Desired
                ? MaaPipelineRecognitionResult.Hit(text: selectedText)
                : MaaPipelineRecognitionResult.Miss($"预期 {state.Desired}，识别 {selectedText}");
        }
        var area = name switch
        {
            "ConfirmationReady" => new Rectangle(345, 180, 325, 120),
            _ => throw new InvalidOperationException($"未知扫荡识别节点：{name}")
        };
        var confirmationText = await ReadAbyssSweepAreaAsync(frame, area, token);
        var expected = $"共计{state.Desired}次";
        return confirmationText.Contains(expected, StringComparison.Ordinal)
            ? MaaPipelineRecognitionResult.Hit(text: confirmationText)
            : MaaPipelineRecognitionResult.Miss($"期待 {expected}，识别 {confirmationText}");
    }

    async Task<MaaPipelineActionResult> ExecuteAbyssSweepAsync(string name, AbyssSweepState state, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        switch (name)
        {
            case "OpenMap":
                await BastanMapOpening.EnsureOpenAsync(adb, message => Log(message), token);
                state.MapOpen = true;
                break;
            case "SetQuantity":
                if (state.Desired > 1)
                {
                    // 最大值需要越过滑轨末端一点；停在 612 附近时界面仍显示倒数第二档。
                    var targetX = state.Desired == state.Maximum
                        ? 645d
                        : 390 + 222d * (state.Desired - 1) / (state.Maximum - 1);
                    await adb.SwipeScreen(390d / 1004, 298d / 565, targetX / 1004, 298d / 565, 450);
                }
                break;
            case "RewardCloseFailed":
                return MaaPipelineActionResult.Failure("点击确定后战利品弹窗仍未关闭");
        }
        return MaaPipelineActionResult.Success();
    }

    Task TapAbyssSweepAsync(int x, int y) => adb.TapScreen(x / 1004d, y / 565d);

    Task<string> ReadAbyssSweepAreaAsync(Bitmap frame, Rectangle designArea, CancellationToken token)
    {
        var x = (int)Math.Round(designArea.X * frame.Width / 1004d);
        var y = (int)Math.Round(designArea.Y * frame.Height / 565d);
        var right = (int)Math.Round(designArea.Right * frame.Width / 1004d);
        var bottom = (int)Math.Round(designArea.Bottom * frame.Height / 565d);
        return ReadAbyssAreaAsync(frame, Rectangle.FromLTRB(x, y, right, bottom), token);
    }

    static string AbyssSweepStepName(string? node) => node switch
    {
        "OpenMap" => "打开巴萨坦地图",
        "MapReady" => "确认巴萨坦标题",
        "OpenMenu" => "点击深渊秘境地图图标",
        "MenuReady" => "识别深渊秘境入口",
        "OpenAbyss" => "进入深渊秘境",
        "AbyssReady" => "确认深渊模式标题",
        "OpenQuantity" => "打开扫荡次数弹窗",
        "QuantityReady" => "识别钥匙和次数上限",
        "HasKeys" => "确认钥匙可用",
        "NoKeys" => "确认没有钥匙",
        "SetQuantity" => "拖动扫荡次数滑块",
        "QuantitySelected" => "核对选择次数",
        "SubmitQuantity" => "提交扫荡次数",
        "ConfirmationReady" => "核对二次确认弹窗",
        "ConfirmSweep" => "确认扫荡",
        "RewardReady" => "等待战利品弹窗",
        "CollectReward" => "领取战利品",
        "RewardClosed" => "确认战利品弹窗已关闭",
        "RewardCloseFailed" => "关闭战利品弹窗失败",
        "CloseQuantity" => "关闭扫荡次数弹窗",
        "CloseAbyss" => "关闭深渊模式",
        "CloseMap" => "关闭巴萨坦地图",
        _ => node ?? "入口"
    };
}
