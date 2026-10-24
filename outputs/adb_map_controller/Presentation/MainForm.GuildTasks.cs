using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;

namespace AdbMapController;

public sealed partial class MainForm
{
    sealed class GuildTaskState(MaaAdbPipelineState adbState, ControllerSettings config)
    {
        public MaaAdbPipelineState AdbState { get; } = adbState;
        public ControllerSettings Config { get; } = config;
        public bool MapOpen;
        public bool PanelOpen;
        public string? PanelKind;
        public int DungeonRuns;
    }

    async Task RunGuildTasksAsync(ControllerSettings config, CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        adb.Serial = devices.Text;
        var state = new GuildTaskState(new MaaAdbPipelineState(adb, log: Log, saveEvidence: false), config);
        var trace = new MaaPipelineTraceCollector();
        Log($"冒险家公会任务启动：许愿={(config.GuildWish ? "是" : "否")}，水晶商店={(config.GuildCrystalShop ? "是" : "否")}，副本={(config.GuildDungeon ? $"Boss {config.GuildBoss}" : "否")}");
        var progress = new DelegateMaaPipelineTraceSink(value =>
        {
            if (value.Kind == MaaPipelineTraceKind.NodeCompleted)
                Log($"冒险家公会 Pipeline：{value.TaskName} 完成");
        });
        try
        {
            popupHandling = true;
            var catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("guild-tasks-pipeline.json"));
            var pipeline = new MaaPipeline<GuildTaskState>(catalog,
                [new DelegateMaaPipelineHandler<GuildTaskState>("GuildTasks",
                    (task, _, ct) => RecognizeGuildTaskAsync(task.Name, state, ct),
                    (task, _, _, ct) => ExecuteGuildTaskAsync(task.Name, state, ct))],
                new MaaPipelineExecutionOptions { TaskChain = "GuildTasks", RetryTimes = 0, MaxTransitions = 120 },
                new MaaPipelineTraceMultiplexer([trace, progress, pipelineWebServer]));
            var result = await pipeline.RunAsync(state, ["EnterGuild"], token);
            trace.SaveJson(runtime.Paths.Trace($"guild-tasks-{result.RunId}.json"));
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded) throw new InvalidOperationException($"{result.LastTask ?? "入口"}：{result.Error ?? result.Status.ToString()}");
            lastEntryRunSucceeded = true;
            Log($"冒险家公会任务完成：副本挑战 {state.DungeonRuns} 次");
            State($"冒险家公会任务完成，副本挑战 {state.DungeonRuns} 次");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex) { Log($"冒险家公会任务失败：{ex}", LogLevel.Error); State($"冒险家公会任务未完成：{ex.Message}"); }
        finally
        {
            try { await GuildCleanupOpenScreensAsync(state, CancellationToken.None); }
            catch (Exception ex) { Warn($"冒险家公会：界面善后未完成：{ex.Message}"); }
            popupHandling = false;
        }
    }

    async Task<MaaPipelineRecognitionResult> RecognizeGuildTaskAsync(string name, GuildTaskState s, CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        if (name is "Wish" or "Shop" or "Dungeon")
            return (name == "Wish" ? s.Config.GuildWish : name == "Shop" ? s.Config.GuildCrystalShop : s.Config.GuildDungeon)
                ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss("未选择");
        if (name is "SkipWish" or "SkipShop" or "SkipDungeon")
            return (name == "SkipWish" ? !s.Config.GuildWish : name == "SkipShop" ? !s.Config.GuildCrystalShop : !s.Config.GuildDungeon)
                ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss();
        if (name == "GuildMapReady")
        {
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            return await GuildMapReadyAsync(frame, token) ? MaaPipelineRecognitionResult.Hit(detail: "公会标题与地图关闭按钮均已出现")
                : MaaPipelineRecognitionResult.Miss("尚未同时确认公会标题和地图关闭按钮");
        }
        return MaaPipelineRecognitionResult.Hit();
    }

    async Task<MaaPipelineActionResult> ExecuteGuildTaskAsync(string name, GuildTaskState s, CancellationToken token)
    {
        switch (name)
        {
            case "EnterGuild":
                var currentMap = await adb.ReadMap();
                if (currentMap is null || !MapRunTask.IsReturnDestination(currentMap))
                    return MaaPipelineActionResult.Failure("当前不在巴萨坦或冒险家公会地图");
                if (GuildIsTown(currentMap, guild: true))
                {
                    Log("冒险家公会：当前已在公会，跳过巴萨坦地图传送");
                }
                else if (GuildIsTown(currentMap, guild: false))
                {
                    Log("冒险家公会：当前在巴萨坦，打开地图并点击公会入口");
                    await GuildEnsureMapAsync("巴萨坦", token);
                    await GuildClickTargetAsync("bastan-guild-entry", token);
                    if (!await GuildWaitMapAsync(true, token)) return MaaPipelineActionResult.Failure("点击公会入口后未切换到公会");
                    Log("冒险家公会：已确认切换到公会地图");
                }
                else return MaaPipelineActionResult.Failure($"当前地图无法识别为巴萨坦或公会：{currentMap.MapName}，TownMapId={currentMap.TownMapId}");
                Log("冒险家公会：检查进阶弹窗（最多 10 秒）");
                await GuildDismissAdvancementAsync(token);
                break;
            case "OpenGuildMap":
                Log("冒险家公会：打开公会地图并识别标题");
                await GuildEnsureMapAsync("冒险家公会", token);
                s.MapOpen = true;
                break;
            case "Wish":
                Log("冒险家公会：开始金币许愿，读取按钮剩余次数");
                if (!await GuildWishesAsync(s, token)) return MaaPipelineActionResult.Failure("金币许愿未完成");
                break;
            case "Shop":
                Log("冒险家公会：开始水晶商店免费购买");
                if (!await GuildShopAsync(s, token)) return MaaPipelineActionResult.Failure("水晶商店免费购买未完成");
                break;
            case "Dungeon":
                Log($"冒险家公会：开始公会副本，选择 Boss {s.Config.GuildBoss}");
                if (!await GuildDungeonAsync(s, token)) return MaaPipelineActionResult.Failure("公会副本未完成");
                break;
            case "GuildMapAfterDungeon":
                Log("冒险家公会：副本任务结束，打开公会地图准备回城");
                await GuildEnsureMapAsync("冒险家公会", token);
                s.MapOpen = true;
                break;
            case "ReturnTown":
                Log("冒险家公会：所选任务完成，传送回巴萨坦");
                await GuildEnsureMapAsync("冒险家公会", token);
                s.MapOpen = true;
                await GuildClickTargetAsync("guild-return-entry", token);
                s.MapOpen = false;
                if (!await GuildWaitMapAsync(false, token)) return MaaPipelineActionResult.Failure("传送后未返回巴萨坦");
                if (!await CloseReturnTownDialogsAsync(token)) return MaaPipelineActionResult.Failure("回城弹窗未关闭");
                Log("冒险家公会：已返回巴萨坦并完成弹窗检查");
                break;
        }
        return MaaPipelineActionResult.Success();
    }

    async Task GuildEnsureMapAsync(string expected, CancellationToken token)
    {
        if (expected == "巴萨坦")
        {
            await BastanMapOpening.EnsureOpenAsync(adb, message => Log(message), token);
            return;
        }
        async Task<bool> ReadyAsync()
        {
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            return await GuildMapReadyAsync(frame, token);
        }
        async Task<bool> StableReadyAsync()
        {
            if (!await ReadyAsync()) return false;
            await Task.Delay(350, token);
            return await ReadyAsync();
        }
        if (await StableReadyAsync()) { Log($"{expected}地图：已确认打开"); return; }
        for (var attempt = 1; attempt <= 3; attempt++)
        {
            var markerClock = Stopwatch.StartNew();
            var clicked = false;
            while (markerClock.Elapsed < TimeSpan.FromSeconds(5))
            {
                token.ThrowIfCancellationRequested();
                if (await StableReadyAsync()) { Log($"{expected}地图：已确认打开"); return; }
                using var frame = await adb.CaptureScreenForAutomationAsync(token);
                var marker = BuiltInUiTemplateCatalog.FindMinimapPlayer(frame);
                if (marker is not null && marker.Score >= .55)
                {
                    Log($"{expected}地图：第 {attempt} 次点击右上角小地图按钮 ({marker.Center.X},{marker.Center.Y})，分数 {marker.Score:F3}");
                    await adb.TapScreen(marker.Center.X / (double)frame.Width, marker.Center.Y / (double)frame.Height);
                    clicked = true;
                    break;
                }
                await Task.Delay(250, token);
            }
            if (!clicked) continue;
            var clock = Stopwatch.StartNew();
            while (clock.Elapsed < TimeSpan.FromSeconds(attempt == 3 ? 8 : 3))
            {
                token.ThrowIfCancellationRequested();
                if (await StableReadyAsync()) { Log($"{expected}地图：点击后已二次确认打开"); return; }
                await Task.Delay(250, token);
            }
            Log($"{expected}地图：第 {attempt} 次点击后未确认打开，重新识别小地图按钮");
        }
        throw new InvalidOperationException($"未能确认{expected}地图打开，停止点击地图入口");
    }

    async Task<bool> GuildMapReadyAsync(Bitmap frame, CancellationToken token)
    {
        if (GuildFind(frame, "guild-map-close") is null) return false;
        if (GuildFind(frame, "guild-map-title") is not null || GuildFind(frame, "guild-map-body") is not null) return true;
        var title = await GuildTextAsync(frame, 350, 35, 320, 95, token);
        return title.Contains("冒险家公会");
    }

    async Task<bool> GuildWaitMapAsync(bool guild, CancellationToken token)
    {
        var clock = Stopwatch.StartNew();
        while (clock.Elapsed < TimeSpan.FromSeconds(18))
        {
            token.ThrowIfCancellationRequested();
            var map = await adb.ReadMap();
            if (map is not null && MapRunTask.IsReturnDestination(map) && GuildIsTown(map, guild)) return true;
            await Task.Delay(350, token);
        }
        return false;
    }

    static bool GuildIsTown(MapDump map, bool guild) => guild
        ? map.TownMapId == 10002 || (map.MapName?.Contains("公会") ?? false)
        : map.TownMapId == 10001 || (map.MapName?.Contains("巴萨坦") ?? false);

    async Task GuildDismissAdvancementAsync(CancellationToken token)
    {
        var clock = Stopwatch.StartNew();
        while (clock.Elapsed < TimeSpan.FromSeconds(10))
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            var words = await adb.ReadOcrWordsAsync(frame, token);
            var text = string.Concat(words.Select(w => OcrTextLocator.Compact(w.Text)));
            if (PopupRecognition.IsCharacterAdvancementDialogText(text))
            {
                Log("冒险家公会：检测到进阶弹窗，点击 ×");
                await GuildClickTargetAsync("advancement-close", token);
                await Task.Delay(300, token);
                return;
            }
            await Task.Delay(250, token);
        }
        Log("冒险家公会：10 秒内未出现进阶弹窗，继续任务");
    }

    async Task<bool> GuildWishesAsync(GuildTaskState s, CancellationToken token)
    {
        await GuildEnsureMapAsync("冒险家公会", token); s.MapOpen = true;
        await GuildClickTargetAsync("guild-wish-entry", token); s.MapOpen = false; s.PanelOpen = true; s.PanelKind = "wish";
        await GuildWaitTargetAsync("wish-panel-title", token);
        var clock = Stopwatch.StartNew();
        for (var attempt = 0; attempt < 12 && clock.Elapsed < TimeSpan.FromSeconds(35); attempt++)
        {
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            var text = await GuildTextAsync(frame, 270, 385, 205, 65, token);
            var count = Regex.Match(text, @"铜质幸运币\(?([0-3])/3\)?");
            if (!count.Success) { Log($"公会许愿：未读到金币次数，OCR={text}"); await Task.Delay(400, token); continue; }
            Log($"公会许愿：金币剩余 {count.Groups[1].Value}/3");
            if (count.Groups[1].Value == "0")
            {
                await GuildClickOutsideAsync("wish", token); s.PanelOpen = false; s.PanelKind = null;
                await GuildCloseMapAsync(s, token);
                Log("公会许愿：按钮次数为 0，任务完成");
                return true;
            }
            await GuildClickTargetAsync("wish-gold-button", token);
            await Task.Delay(350, token);
            using (var dialog = await adb.CaptureScreenForAutomationAsync(token))
            {
                var dialogText = await GuildTextAsync(dialog, 310, 155, 390, 255, token);
                if (dialogText.Contains("确定")) await GuildClickTargetAsync("wish-confirm", token, "确定");
            }
            await Task.Delay(350, token);
            using (var reward = await adb.CaptureScreenForAutomationAsync(token))
            {
                var rewardText = await GuildTextAsync(reward, 275, 165, 460, 230, token);
                if (rewardText.Contains("恭喜") || rewardText.Contains("奖励")) await GuildClickOutsideAsync("wish", token, false);
            }
            await Task.Delay(400, token);
        }
        return false;
    }

    async Task<bool> GuildShopAsync(GuildTaskState s, CancellationToken token)
    {
        await GuildEnsureMapAsync("冒险家公会", token); s.MapOpen = true;
        await GuildClickTargetAsync("guild-shop-entry", token); s.MapOpen = false; s.PanelOpen = true; s.PanelKind = "shop";
        var entranceClock = Stopwatch.StartNew();
        var shopOpen = false;
        while (entranceClock.Elapsed < TimeSpan.FromSeconds(6))
        {
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            var tabs = await GuildTextAsync(frame, 850, 90, 110, 200, token);
            if (tabs.Contains("贡献商店") && tabs.Contains("水晶商店")) { shopOpen = true; break; }
            await Task.Delay(250, token);
        }
        if (!shopOpen) { Log("公会水晶商店：点击入口后未检测到商店界面", LogLevel.Error); return false; }
        Log("公会水晶商店：已确认商店界面打开，切换水晶商店页签");
        await GuildClickTargetAsync("shop-crystal-tab", token, "水晶商店");
        var clock = Stopwatch.StartNew();
        var crystalReady = false;
        while (clock.Elapsed < TimeSpan.FromSeconds(8))
        {
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            var tab = await GuildTextAsync(frame, 850, 220, 105, 60, token);
            var goods = await GuildTextAsync(frame, 125, 88, 720, 360, token);
            if (tab.Contains("水晶商店") && (goods.Contains("下次进货时间") || goods.Contains("级符文石礼包")))
            {
                crystalReady = true;
                if (GuildFind(frame, "shop-sold-out") is not null)
                {
                    Log("公会水晶商店：免费商品已售罄，视为任务完成");
                    break;
                }
                var button = await GuildTextAsync(frame, 120, 470, 200, 70, token);
                if (button.Contains("售罄")) { Log("公会水晶商店：免费商品已售罄，视为任务完成"); break; }
                if (!button.Contains('0')) { Log($"公会水晶商店：免费按钮未识别，OCR={button}", LogLevel.Error); return false; }
                await GuildClickTargetAsync("shop-free-button", token);
                using var confirm = await adb.CaptureScreenForAutomationAsync(token);
                var dialog = await GuildTextAsync(confirm, 300, 150, 390, 260, token);
                if (!dialog.Contains("确认购买") || !dialog.Contains('0')) return false;
                Log("公会水晶商店：已确认价格为 0，点击购买确认");
                await GuildClickTargetAsync("shop-confirm", token);
                await Task.Delay(450, token);
                break;
            }
            await Task.Delay(250, token);
        }
        if (!crystalReady) { Log("公会水晶商店：未确认水晶商店页签已切换", LogLevel.Error); return false; }
        Log("公会水晶商店：关闭商店界面");
        await GuildClickOutsideAsync("shop", token); s.PanelOpen = false; s.PanelKind = null;
        await GuildCloseMapAsync(s, token);
        return true;
    }

    async Task<bool> GuildDungeonAsync(GuildTaskState s, CancellationToken token)
    {
        for (var run = 0; run < 3; run++)
        {
            await GuildEnsureMapAsync("冒险家公会", token); s.MapOpen = true;
            await GuildClickTargetAsync("guild-dungeon-entry", token); s.MapOpen = false; s.PanelOpen = true; s.PanelKind = "dungeon";
            await GuildWaitTargetAsync("dungeon-challenge", token);
            await Task.Delay(500, token);
            using (var frame = await adb.CaptureScreenForAutomationAsync(token))
            {
                var text = await GuildTextAsync(frame, 685, 490, 180, 60, token);
                var match = Regex.Match(text, @"挑战\s*[:：]\s*([0-3])\s*/\s*3");
                if (!match.Success) { Log($"公会副本：未读到挑战次数，OCR={text}", LogLevel.Error); return false; }
                Log($"公会副本：当前剩余 {match.Groups[1].Value}/3 次");
                if (match.Groups[1].Value == "0")
                {
                    await GuildClickOutsideAsync("dungeon", token); s.PanelOpen = false; s.PanelKind = null;
                    await GuildCloseMapAsync(s, token);
                    return true;
                }
            }
            await GuildSelectBossAsync(Math.Clamp(s.Config.GuildBoss, 1, 5), token);
            Log($"公会副本：已选择 Boss {s.Config.GuildBoss}，点击挑战");
            await GuildClickTargetAsync("dungeon-challenge", token, "前往挑战");
            if (!await GuildWaitDungeonEntryAsync(token)) { Log("公会副本：挑战后 15 秒内未切换地图", LogLevel.Error); return false; }
            Log("公会副本：已确认进入副本，启动现有跑图任务");
            s.PanelOpen = false; s.PanelKind = null;
            entryRunMovementScope = true; lastMapRunSucceeded = false; popupHandling = false;
            try { await RunMovementScope(token, StartRunCore, startupProbePaused: true); }
            finally { entryRunMovementScope = false; popupHandling = true; }
            if (!lastMapRunSucceeded) return false;
            s.DungeonRuns++;
            Log($"公会副本：第 {s.DungeonRuns} 次跑图完成");
            if (!await GuildWaitMapAsync(true, token))
            {
                await GuildEnsureMapAsync("巴萨坦", token);
                await GuildClickTargetAsync("bastan-guild-entry", token);
                if (!await GuildWaitMapAsync(true, token)) return false;
            }
        }
        return true;
    }

    async Task<bool> GuildWaitDungeonEntryAsync(CancellationToken token)
    {
        var clock = Stopwatch.StartNew();
        while (clock.Elapsed < TimeSpan.FromSeconds(15))
        {
            token.ThrowIfCancellationRequested();
            var map = await adb.ReadMap();
            if (map is not null && !MapRunTask.IsReturnDestination(map) && map.Width > 0 && map.Height > 0) return true;
            await Task.Delay(350, token);
        }
        return false;
    }

    async Task GuildCloseMapAsync(GuildTaskState state, CancellationToken token)
    {
        await GuildEnsureMapAsync("冒险家公会", token);
        state.MapOpen = true;
        await GuildClickTargetAsync("guild-map-close", token);
        var clock = Stopwatch.StartNew();
        var missing = 0;
        while (clock.Elapsed < TimeSpan.FromSeconds(5))
        {
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            missing = await GuildMapReadyAsync(frame, token) ? 0 : missing + 1;
            if (missing >= 2)
            {
                state.MapOpen = false;
                Log("冒险家公会：已确认关闭公会地图");
                return;
            }
            await Task.Delay(250, token);
        }
        throw new InvalidOperationException("点击关闭后公会地图仍然打开");
    }

    async Task GuildCleanupOpenScreensAsync(GuildTaskState state, CancellationToken token)
    {
        if (!state.PanelOpen && !state.MapOpen) return;
        if (state.PanelOpen && state.PanelKind is { } panel)
        {
            var anchor = panel switch
            {
                "wish" => "wish-panel-title",
                "shop" => "shop-crystal-tab",
                "dungeon" => "dungeon-challenge",
                _ => null
            };
            if (anchor is not null)
            {
                using var frame = await adb.CaptureScreenForAutomationAsync(token);
                if (GuildFind(frame, anchor) is not null)
                {
                    try { await GuildClickOutsideAsync(panel, token); }
                    catch (InvalidOperationException)
                    {
                        Log($"冒险家公会：点击面板外未关闭{panel}，尝试返回键");
                        await adb.PressBack();
                        await Task.Delay(400, token);
                        using var retryFrame = await adb.CaptureScreenForAutomationAsync(token);
                        if (GuildFind(retryFrame, anchor) is not null)
                            throw new InvalidOperationException($"{panel}面板善后失败，返回键后仍可见");
                    }
                    Log($"冒险家公会：善后已关闭{panel}面板");
                }
            }
            state.PanelOpen = false;
            state.PanelKind = null;
        }

        var clock = Stopwatch.StartNew();
        while (clock.Elapsed < TimeSpan.FromSeconds(5))
        {
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            if (await GuildMapReadyAsync(frame, token))
            {
                await GuildClickTargetAsync("guild-map-close", token);
                var closed = false;
                for (var check = 0; check < 10; check++)
                {
                    await Task.Delay(250, token);
                    using var next = await adb.CaptureScreenForAutomationAsync(token);
                    if (!await GuildMapReadyAsync(next, token)) { closed = true; break; }
                }
                if (!closed) throw new InvalidOperationException("点击后公会地图仍然打开");
                state.MapOpen = false;
                Log("冒险家公会：善后已关闭公会地图");
                return;
            }
            await Task.Delay(250, token);
        }
        if (state.MapOpen) throw new InvalidOperationException("未能确认公会地图，无法完成关闭");
    }

    async Task<string> GuildTextAsync(Bitmap frame, int x, int y, int width, int height, CancellationToken token)
    {
        var words = await adb.ReadOcrWordsAsync(frame, token);
        return string.Concat(words.Where(w => w.Center.X >= x / 1004d * frame.Width &&
            w.Center.X <= (x + width) / 1004d * frame.Width &&
            w.Center.Y >= y / 565d * frame.Height &&
            w.Center.Y <= (y + height) / 565d * frame.Height)
            .OrderBy(w => w.Center.Y).ThenBy(w => w.Left).Select(w => w.Text.Trim()));
    }

}
