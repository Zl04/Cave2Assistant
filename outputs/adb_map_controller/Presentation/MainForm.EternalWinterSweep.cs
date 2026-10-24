using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunEternalWinterSweepAsync(ControllerSettings config, CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        var state = new EternalWinterSweepState(new MaaAdbPipelineState(adb, log: Log, saveEvidence: false),
            Math.Max(1, config.EternalWinterFloor), Math.Max(1, config.EternalWinterSweepCount));
        try
        {
            adb.Serial = devices.Text;
            popupHandling = true;
            var catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("eternal-winter-sweep-pipeline.json"));
            var trace = new MaaPipelineTraceCollector();
            var progress = new DelegateMaaPipelineTraceSink(value =>
            {
                if (value.Kind != MaaPipelineTraceKind.NodeCompleted) return;
                switch (value.TaskName)
                {
                    case "OpenMap": state.MapOpen = true; break;
                    case "OpenRift": state.RiftOpen = true; break;
                    case "OpenFloorSelection": state.SelectionOpen = true; break;
                    case "FloorChanged": state.SelectionOpen = false; break;
                    case "DismissLockedFloor": state.SelectionOpen = false; break;
                    case "ClickSweep": UpdateTaskExecutionProgress(state.Completed + 1, state.RequestedCount.ToString()); break;
                    case "ConfirmReward": state.Completed++; break;
                    case "CloseRift": state.RiftOpen = false; break;
                    case "MapClosed": state.MapOpen = false; break;
                }
                LogEternalWinterPipelineStep(value.TaskName, state);
            });
            var pipeline = new MaaPipeline<EternalWinterSweepState>(catalog,
                [new DelegateMaaPipelineHandler<EternalWinterSweepState>("EternalWinterSweep",
                    (task, _, ct) => RecognizeEternalWinterSweepAsync(task.Name, state, ct),
                    (task, _, _, ct) => ExecuteEternalWinterSweepAsync(task.Name, state, ct)),
                 new MaaAdbPipelineHandler<EternalWinterSweepState>("EternalWinterAdb", current => current.AdbState)],
                new MaaPipelineExecutionOptions { TaskChain = "EternalWinterSweep", RetryTimes = 0, MaxTransitions = 100 },
                new MaaPipelineTraceMultiplexer([trace, progress, pipelineWebServer]));
            var result = await pipeline.RunAsync(state, ["OpenMap"], token);
            trace.SaveJson(runtime.Paths.Trace($"eternal-winter-sweep-{result.RunId}.json"));
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded)
                throw new InvalidOperationException($"{result.LastTask ?? "入口"}：{result.Error ?? result.Status.ToString()}");
            Log(state.TargetLocked
                ? $"永冬裂缝：{state.TargetFloor} 层未解锁，已关闭界面"
                : $"永冬裂缝：完成 {state.Completed}/{state.RequestedCount} 次扫荡");
            lastEntryRunSucceeded = true;
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex) { State($"永冬裂缝扫荡未完成：{ex.Message}"); }
        finally
        {
            if (state.SelectionOpen)
                try { await TapEternalWinterAsync(760, 500); await Task.Delay(200); }
                catch (Exception ex) { Warn($"关闭层数选择失败：{ex.Message}"); }
            if (state.RiftOpen)
                try { await TapEternalWinterAsync(923, 123); await Task.Delay(250); }
                catch (Exception ex) { Warn($"关闭永冬裂缝失败：{ex.Message}"); }
            if (state.MapOpen)
                try { await TapEternalWinterAsync(900, 70); }
                catch (Exception ex) { Warn($"关闭巴萨坦地图失败：{ex.Message}"); }
            popupHandling = false;
        }
    }

    sealed class EternalWinterSweepState(MaaAdbPipelineState adbState, int targetFloor, int requestedCount)
    {
        public MaaAdbPipelineState AdbState { get; } = adbState;
        public int TargetFloor { get; } = targetFloor;
        public int RequestedCount { get; } = requestedCount;
        public int Completed;
        public int CurrentFloor;
        public bool MapOpen;
        public bool RiftOpen;
        public bool SelectionOpen;
        public bool TargetLocked;
        public double MapButtonX;
        public double MapButtonY;
        public double TargetFloorX;
        public double TargetFloorY;
        public bool SwipeDown = true;
    }

    async Task<MaaPipelineRecognitionResult> RecognizeEternalWinterSweepAsync(string name, EternalWinterSweepState state, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        if (name == "OpenMap")
        {
            var map = await adb.ReadMap();
            if (!MapRunTask.IsReturnDestination(map)) throw new InvalidOperationException("当前不在城镇");
        }
        if (name == "SweepComplete")
            return state.Completed >= state.RequestedCount ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("尚未达到配置次数");
        if (name == "SweepRecorded") return MaaPipelineRecognitionResult.Hit(detail: "记录本次扫荡");

        using var frame = await adb.CaptureScreenForAutomationAsync(token);
        if (name == "OpenMap")
        {
            var marker = BuiltInUiTemplateCatalog.FindMinimapPlayer(frame);
            if (marker is null || marker.Score < .55) return MaaPipelineRecognitionResult.Miss("未找到地图按钮");
            state.MapButtonX = marker.Center.X / (double)frame.Width;
            state.MapButtonY = marker.Center.Y / (double)frame.Height;
            return MaaPipelineRecognitionResult.Hit(marker.Score, detail: $"地图按钮=({marker.Center.X},{marker.Center.Y})");
        }
        if (name == "MapReady")
            return BuiltInUiTemplateCatalog.IsBastanMapOpen(frame)
                ? MaaPipelineRecognitionResult.Hit(detail: "现有巴萨坦地图识别命中")
                : MaaPipelineRecognitionResult.Miss("巴萨坦标题和地图主体均未命中");
        if (name == "MapClosed")
            return !BuiltInUiTemplateCatalog.IsBastanMapOpen(frame)
                ? MaaPipelineRecognitionResult.Hit(detail: "巴萨坦地图已消失")
                : MaaPipelineRecognitionResult.Miss("巴萨坦地图仍然打开");

        var words = await adb.ReadOcrWordsAsync(frame, token);
        var compact = string.Concat(words.Select(word => OcrTextLocator.Compact(word.Text)));
        if (name == "RiftReady" || name == "TargetFloorSelected")
        {
            var floor = ReadEternalWinterFloor(words, frame.Size);
            if (floor > 0) state.CurrentFloor = floor;
            if (name == "RiftReady")
                return floor > 0 ? MaaPipelineRecognitionResult.Hit(text: $"{floor}层") : MaaPipelineRecognitionResult.Miss("未识别当前层数");
            return floor == state.TargetFloor ? MaaPipelineRecognitionResult.Hit(text: $"{floor}层")
                : MaaPipelineRecognitionResult.Miss($"当前 {floor} 层，目标 {state.TargetFloor} 层");
        }
        if (name == "NeedSwitchFloor")
            return state.CurrentFloor != state.TargetFloor ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("当前层即目标层");
        if (name == "LocateTargetFloor")
        {
            var row = OcrTextLocator.Find(words, $"永冬裂缝{state.TargetFloor}层", word =>
                word.Center.X > frame.Width * .35 && word.Center.X < frame.Width * .65 &&
                word.Center.Y > frame.Height * .27 && word.Center.Y < frame.Height * .79);
            if (row is not null)
            {
                state.TargetFloorX = row.Center.X / (double)frame.Width;
                state.TargetFloorY = row.Center.Y / (double)frame.Height;
                return MaaPipelineRecognitionResult.Hit(text: $"永冬裂缝{state.TargetFloor}层", detail: $"目标=({row.Center.X},{row.Center.Y})");
            }
            var visible = words.Select(word => Regex.Match(OcrTextLocator.Compact(word.Text), @"永冬裂缝(\d+)层"))
                .Where(match => match.Success).Select(match => int.Parse(match.Groups[1].Value)).ToArray();
            state.SwipeDown = visible.Length == 0 || state.TargetFloor > visible.Max();
            return MaaPipelineRecognitionResult.Miss(visible.Length == 0 ? "未识别可见层数"
                : $"目标 {state.TargetFloor} 层，可见 {string.Join(',', visible)} 层");
        }
        if (name == "FloorChanged")
        {
            var floor = ReadEternalWinterFloor(words, frame.Size);
            if (floor == state.TargetFloor) { state.CurrentFloor = floor; return MaaPipelineRecognitionResult.Hit(text: $"{floor}层"); }
            return MaaPipelineRecognitionResult.Miss($"尚未切换到 {state.TargetFloor} 层");
        }
        if (name == "FloorLocked")
        {
            var selectionStillOpen = compact.Contains("难度选择", StringComparison.Ordinal);
            if (selectionStillOpen) state.TargetLocked = true;
            return selectionStillOpen ? MaaPipelineRecognitionResult.Hit(detail: "选择窗口仍存在，目标层未解锁") : MaaPipelineRecognitionResult.Miss();
        }
        if (name == "SweepAvailable")
        {
            var remaining = Regex.Match(compact, @"挑战次数(\d+)");
            var available = compact.Contains("扫荡", StringComparison.Ordinal) && (!remaining.Success || int.Parse(remaining.Groups[1].Value) > 0);
            return available ? MaaPipelineRecognitionResult.Hit(text: remaining.Success ? remaining.Value : "扫荡")
                : MaaPipelineRecognitionResult.Miss($"扫荡不可用，界面={compact}");
        }
        if (name == "SweepUnavailable")
        {
            var remaining = Regex.Match(compact, @"挑战次数(\d+)");
            var unavailable = !compact.Contains("扫荡", StringComparison.Ordinal) ||
                remaining.Success && int.Parse(remaining.Groups[1].Value) == 0;
            return unavailable ? MaaPipelineRecognitionResult.Hit(detail: "次数不足或关卡未解锁扫荡")
                : MaaPipelineRecognitionResult.Miss("仍可扫荡");
        }
        throw new InvalidOperationException($"未知永冬裂缝识别节点：{name}");
    }

    async Task<MaaPipelineActionResult> ExecuteEternalWinterSweepAsync(string name, EternalWinterSweepState state, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        switch (name)
        {
            case "OpenMap": await adb.TapScreen(state.MapButtonX, state.MapButtonY); break;
            case "SelectTargetFloor": await adb.TapScreen(state.TargetFloorX, state.TargetFloorY); break;
            case "ScrollFloorList":
                await adb.SwipeScreen(.5, state.SwipeDown ? .72 : .35, .5, state.SwipeDown ? .35 : .72, 350);
                break;
        }
        return MaaPipelineActionResult.Success();
    }

    static int ReadEternalWinterFloor(IEnumerable<OcrWord> words, Size size)
    {
        var list = words.ToArray();
        var label = OcrTextLocator.Find(list, "永冬裂缝", word =>
            word.Center.X < size.Width * .38 && word.Center.Y > size.Height * .42 && word.Center.Y < size.Height * .57);
        if (label is null) return 0;
        var nearby = string.Concat(list.Where(word => Math.Abs(word.Center.Y - label.Center.Y) < size.Height * .04 &&
            word.Center.X > size.Width * .15 && word.Center.X < size.Width * .35)
            .OrderBy(word => word.Left).Select(word => OcrTextLocator.Compact(word.Text)));
        var match = Regex.Match(nearby, @"(\d+)层");
        return match.Success ? int.Parse(match.Groups[1].Value) : 0;
    }

    void LogEternalWinterPipelineStep(string? task, EternalWinterSweepState state)
    {
        var message = task switch
        {
            "OpenMap" => "已点击巴萨坦地图入口", "MapReady" => "已确认巴萨坦地图",
            "OpenRiftMarker" => "已点击永冬裂缝地图图标", "OpenRift" => "已打开永冬裂缝",
            "RiftReady" => $"当前层数 {state.CurrentFloor}，配置层数 {state.TargetFloor}",
            "OpenFloorSelection" => "已打开层数选择", "LocateTargetFloor" => $"已定位 {state.TargetFloor} 层",
            "ScrollFloorList" => $"列表中未找到 {state.TargetFloor} 层，继续滚动",
            "SelectTargetFloor" => $"已点击 {state.TargetFloor} 层", "FloorChanged" => $"已切换到 {state.TargetFloor} 层",
            "FloorLocked" => $"{state.TargetFloor} 层未解锁", "ClickSweep" => $"开始第 {state.Completed + 1}/{state.RequestedCount} 次扫荡",
            "RewardReady" => "已确认宝物获得界面", "ConfirmReward" => $"已完成第 {state.Completed}/{state.RequestedCount} 次扫荡",
            "SweepUnavailable" => "扫荡次数不足或扫荡功能未解锁", "CloseRift" => "已关闭永冬裂缝",
            "CloseMap" => "已点击巴萨坦地图关闭按钮", "MapClosed" => "已确认巴萨坦地图关闭",
            _ => null
        };
        if (message is not null) Log($"永冬裂缝 Pipeline：{message}");
    }

    Task TapEternalWinterAsync(int x, int y) => adb.TapScreen(x / 1004d, y / 565d);
}
