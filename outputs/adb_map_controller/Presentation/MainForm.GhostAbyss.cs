using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;

namespace AdbMapController;

public sealed partial class MainForm
{
    sealed class GhostAbyssState(MaaAdbPipelineState adbState, int floor, bool preferDouble)
    {
        public MaaAdbPipelineState AdbState { get; } = adbState;
        public int Floor { get; } = floor;
        public bool PreferDouble { get; } = preferDouble;
        public int CurrentFloor;
        public int Remaining;
        public int Completed;
        public bool DoubleSelected;
        public bool MapOpen;
        public bool AbyssOpen;
        public bool ListOpen;
        public bool Locked;
        public bool ScrollTowardHigher = true;
        public double FloorX;
        public double FloorY;
        public double MapX;
        public double MapY;
        public double MapCloseX;
        public double MapCloseY;
    }

    async Task RunGhostAbyssAsync(ControllerSettings config, CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        adb.Serial = devices.Text;
        var state = new GhostAbyssState(new MaaAdbPipelineState(adb, log: Log, saveEvidence: false),
            Math.Max(1, config.GhostAbyssFloor), config.GhostAbyssDouble);
        var trace = new MaaPipelineTraceCollector();
        var progress = new DelegateMaaPipelineTraceSink(value =>
        {
            if (value.Kind != MaaPipelineTraceKind.NodeCompleted) return;
            if (value.TaskName == "OpenFloorList") state.ListOpen = true;
            if (value.TaskName == "OpenAbyss") state.AbyssOpen = true;
            Log($"幽灵深渊 Pipeline：{value.TaskName}；目标={state.Floor}层，当前={state.CurrentFloor}层，剩余={state.Remaining}次，完成={state.Completed}轮");
        });
        try
        {
            popupHandling = true;
            var catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("ghost-abyss-pipeline.json"));
            var pipeline = new MaaPipeline<GhostAbyssState>(catalog,
                [new DelegateMaaPipelineHandler<GhostAbyssState>("GhostAbyss",
                    (task, _, ct) => RecognizeGhostAbyssAsync(task.Name, state, ct),
                    (task, _, _, ct) => ExecuteGhostAbyssAsync(task.Name, state, ct)),
                 new MaaAdbPipelineHandler<GhostAbyssState>("GhostAdb", s => s.AdbState)],
                new MaaPipelineExecutionOptions { TaskChain = "GhostAbyss", RetryTimes = 0, MaxTransitions = 300 },
                new MaaPipelineTraceMultiplexer([trace, progress, pipelineWebServer]));
            var result = await pipeline.RunAsync(state, ["OpenMap"], token);
            trace.SaveJson(runtime.Paths.Trace($"ghost-abyss-{result.RunId}.json"));
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded && result.Status != MaaPipelineExecutionStatus.Stopped)
                throw new InvalidOperationException($"{result.LastTask ?? "入口"}：{result.Error ?? result.Status.ToString()}");
            if (state.Locked) throw new InvalidOperationException($"{state.Floor} 层尚未解锁");
            Log($"幽灵深渊：任务结束，已完成 {state.Completed} 轮");
            lastEntryRunSucceeded = true;
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex) { State($"幽灵深渊未完成：{ex.Message}"); }
        finally
        {
            if (state.ListOpen)
                try { await GhostTapAsync(805, 525); } catch (Exception ex) { Warn($"关闭关卡选择失败：{ex.Message}"); }
            if (state.AbyssOpen)
                try { await GhostTapAsync(970, 530); } catch (Exception ex) { Warn($"关闭深渊界面失败：{ex.Message}"); }
            if (state.MapOpen)
                try { await GhostTapAsync(900, 70); } catch (Exception ex) { Warn($"关闭巴萨坦地图失败：{ex.Message}"); }
            popupHandling = false;
        }
    }

    async Task<MaaPipelineRecognitionResult> RecognizeGhostAbyssAsync(string name, GhostAbyssState s, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        if (name == "OpenMap")
        {
            var map = await adb.ReadMap();
            if (!MapRunTask.IsReturnDestination(map)) return MaaPipelineRecognitionResult.Miss("当前不在城镇");
        }
        if (name is "NeedFloor" or "TargetSelected")
            return (s.CurrentFloor == s.Floor) == (name == "TargetSelected")
                ? MaaPipelineRecognitionResult.Hit(detail: $"当前{s.CurrentFloor}层，目标{s.Floor}层") : MaaPipelineRecognitionResult.Miss();
        if (name is "NoQuota" or "HasQuota")
            return (s.Remaining == 0) == (name == "NoQuota") ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss();
        if (name is "UseDouble" or "UseNormal")
            return s.DoubleSelected == (name == "UseDouble") ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss();
        using var frame = await adb.CaptureScreenForAutomationAsync(token);
        if (name == "OpenMap")
        {
            var marker = BuiltInUiTemplateCatalog.FindMinimapPlayer(frame);
            if (marker is null || marker.Score < .55) return MaaPipelineRecognitionResult.Miss("未找到地图按钮");
            s.MapX = marker.Center.X / (double)frame.Width; s.MapY = marker.Center.Y / (double)frame.Height;
            return MaaPipelineRecognitionResult.Hit(detail: "地图按钮已定位");
        }
        if (name == "MapReady") return BuiltInUiTemplateCatalog.IsBastanMapOpen(frame)
            ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("巴萨坦地图未打开");
        if (name is "MapAfterAbyssClosed" or "CloseMap")
        {
            var close = BuiltInUiTemplateCatalog.FindBastanMapClose(frame);
            var title = BuiltInUiTemplateCatalog.FindBastanTitle(frame);
            if (close is null || title is null && BuiltInUiTemplateCatalog.MatchBastanMapBody(frame) < .85)
                return MaaPipelineRecognitionResult.Miss("尚未同时确认完整巴萨坦地图及关闭按钮");
            s.MapCloseX = close.Center.X / (double)frame.Width;
            s.MapCloseY = close.Center.Y / (double)frame.Height;
            return MaaPipelineRecognitionResult.Hit(close.Score, detail: "已确认巴萨坦地图及关闭按钮");
        }
        if (name == "MapClosed")
        {
            var mapGone = BuiltInUiTemplateCatalog.FindBastanTitle(frame) is null &&
                BuiltInUiTemplateCatalog.FindBastanMapClose(frame) is null;
            var minimapVisible = BuiltInUiTemplateCatalog.FindMinimapPlayer(frame) is not null;
            return mapGone && minimapVisible ? MaaPipelineRecognitionResult.Hit(detail: "地图已关闭，城镇画面可见")
                : MaaPipelineRecognitionResult.Miss("地图尚未关闭或仍处于过渡画面");
        }
        var words = await adb.ReadOcrWordsAsync(frame, token);
        var compact = string.Concat(words.Select(w => OcrTextLocator.Compact(w.Text)));
        if (name == "MenuReady") return compact.Contains("深渊秘境")
            ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("地图菜单未出现深渊秘境");
        if (name == "FloorReady")
        {
            var title = GhostAreaText(words, frame, 460, 20, 340, 65);
            var match = Regex.Match(title, @"幽灵深渊第(\d+)层");
            if (!match.Success) return MaaPipelineRecognitionResult.Miss("未识别幽灵深渊层数");
            s.CurrentFloor = int.Parse(match.Groups[1].Value); s.AbyssOpen = true;
            return MaaPipelineRecognitionResult.Hit(text: match.Value);
        }
        if (name == "ListReady") return compact.Contains("关卡选择")
            ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("关卡选择未打开");
        if (name == "FindFloor")
        {
            var rows = words.Where(w => w.Center.X > frame.Width * .25 && w.Center.X < frame.Width * .48 &&
                w.Center.Y > frame.Height * .23 && w.Center.Y < frame.Height * .85)
                .Select(w => (Word: w, Match: Regex.Match(OcrTextLocator.Compact(w.Text), @"第(\d+)层")))
                .Where(x => x.Match.Success).ToArray();
            var target = rows.FirstOrDefault(x => int.Parse(x.Match.Groups[1].Value) == s.Floor);
            if (target.Word is not null)
            {
                var locked = words.Any(w => Math.Abs(w.Center.Y - target.Word.Center.Y) < frame.Height * .065 &&
                    OcrTextLocator.Compact(w.Text).Contains("解锁楼层"));
                if (locked) { s.Locked = true; return MaaPipelineRecognitionResult.Miss($"{s.Floor}层未解锁"); }
                s.FloorX = target.Word.Center.X / (double)frame.Width;
                s.FloorY = target.Word.Center.Y / (double)frame.Height;
                return MaaPipelineRecognitionResult.Hit(text: target.Word.Text);
            }
            if (rows.Length > 0) s.ScrollTowardHigher = s.Floor > rows.Max(x => int.Parse(x.Match.Groups[1].Value));
            return MaaPipelineRecognitionResult.Miss($"未找到{s.Floor}层；可见层数：{string.Join(',', rows.Select(x => x.Match.Groups[1].Value))}");
        }
        if (name == "ChoiceReady")
        {
            if (!compact.Contains("普通挑战") || !compact.Contains("双倍挑战")) return MaaPipelineRecognitionResult.Miss("挑战方式界面未出现");
            // 双倍按钮为黄色时才可点击；灰色按钮不能消耗挑战次数。
            var pixel = frame.GetPixel((int)(frame.Width * .67), (int)(frame.Height * .755));
            var doubleEnabled = pixel.R > pixel.B * 1.35 && pixel.G > pixel.B * 1.2 && pixel.R > 115;
            s.DoubleSelected = s.PreferDouble && s.Remaining >= 2 && doubleEnabled;
            Log($"幽灵深渊：剩余{s.Remaining}次，双倍按钮{(doubleEnabled ? "可用" : "灰色")}" +
                $"，选择{(s.DoubleSelected ? "双倍" : "普通")}挑战");
            return MaaPipelineRecognitionResult.Hit();
        }
        throw new InvalidOperationException($"未知幽灵深渊识别节点：{name}");
    }

    async Task<MaaPipelineActionResult> ExecuteGhostAbyssAsync(string name, GhostAbyssState s, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        switch (name)
        {
            case "OpenMap": await adb.TapScreen(s.MapX, s.MapY); s.MapOpen = true; break;
            case "OpenFloorList": s.ListOpen = true; break;
            case "ScrollFloor":
                if (s.Locked) return MaaPipelineActionResult.Stop();
                await adb.SwipeScreen(.5, s.ScrollTowardHigher ? .66 : .42, .5, s.ScrollTowardHigher ? .42 : .66, 750);
                break;
            case "ChooseFloor": await adb.TapScreen(s.FloorX, s.FloorY); s.ListOpen = false; break;
            case "QuotaGate":
                using (var frame = await adb.CaptureScreenForAutomationAsync(token))
                {
                    var words = await adb.ReadOcrWordsAsync(frame, token);
                    var count = GhostAreaText(words, frame, 110, 425, 220, 55);
                    var match = Regex.Match(count, @"(?:可挑战次数|挑战次数)(\d+)");
                    if (!match.Success && !count.Contains("挑战次数已用完"))
                        return MaaPipelineActionResult.Failure($"无法核验剩余挑战次数：{count}");
                    s.Remaining = match.Success ? int.Parse(match.Groups[1].Value) : 0;
                }
                break;
            case "FloorUnavailable": s.Locked = true; return MaaPipelineActionResult.Stop();
            case "RunMap":
                s.MapOpen = false; s.AbyssOpen = false;
                entryRunMovementScope = true; lastMapRunSucceeded = false;
                popupHandling = false;
                try { await RunMovementScope(token, StartRunCore, startupProbePaused: true); }
                finally { entryRunMovementScope = false; popupHandling = true; }
                if (!lastMapRunSucceeded) return MaaPipelineActionResult.Failure("幽灵深渊跑图未完成");
                s.Completed++;
                Log($"幽灵深渊：第{s.Completed}轮跑图完成");
                break;
            case "LoopGate":
                if (s.DoubleSelected || s.Remaining <= 1) return MaaPipelineActionResult.Stop();
                break;
            case "CloseAbyss": await GhostTapAsync(970, 530); s.AbyssOpen = false; break;
            case "CloseMap": await adb.TapScreen(s.MapCloseX, s.MapCloseY); break;
            case "MapClosed": s.MapOpen = false; break;
        }
        return MaaPipelineActionResult.Success();
    }

    static string GhostAreaText(IEnumerable<OcrWord> words, Bitmap frame, int x, int y, int width, int height) =>
        string.Concat(words.Where(w => w.Center.X >= x / 1004d * frame.Width &&
            w.Center.X <= (x + width) / 1004d * frame.Width && w.Center.Y >= y / 565d * frame.Height &&
            w.Center.Y <= (y + height) / 565d * frame.Height)
            .OrderBy(w => w.Center.Y).ThenBy(w => w.Left).Select(w => OcrTextLocator.Compact(w.Text)));

    Task GhostTapAsync(int x, int y) => adb.TapScreen(x / 1004d, y / 565d);
}
