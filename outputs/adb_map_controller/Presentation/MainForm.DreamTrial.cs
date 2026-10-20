using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed partial class MainForm
{
    bool dreamTrialRunning;
    bool dreamTrialVictoryObserved;

    static int NormalizeDreamTrialBossMask(int mask)
    {
        for (var index = 5; index >= 0; index--)
            if ((mask & (1 << index)) != 0) return (1 << (index + 1)) - 1;
        return 0;
    }

    static void EnforceDreamTrialOptions(ControllerSettings config)
    {
        config.DreamTrialBossMask = NormalizeDreamTrialBossMask(config.DreamTrialBossMask);
        config.AttackBoss = true;
        config.Monsters = false;
        config.Elites = false;
        config.Chests = false;
        config.Pots = false;
        config.Bones = false;
        config.Gold = false;
        config.Runes = false;
        config.Altars = false;
        config.Chambers = false;
        config.AutoEquipmentSale = false;
        config.Mining = false;
        config.CardMining = false;
        config.CardLayer = false;
        config.TargetStopFloor = 0;
        config.EscapeReturnFloor = 0;
        config.EscapeReturnAttackBoss = false;
    }

    async Task RunDreamTrialTaskAsync(ControllerSettings config, CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        if ((config.DreamTrialBossMask & 63) == 0)
        {
            State("梦境试炼：未选择 Boss");
            return;
        }
        EnforceDreamTrialOptions(config);
        ApplySettings(config, applyEquipmentSale: false);
        dreamTrialRunning = true;
        entryRunMovementScope = true;
        try
        {
            var panelOpen = await IsDreamTrialPanelOpenAsync(token);
            var firstBoss = Enumerable.Range(0, 6).First(index => (config.DreamTrialBossMask & (1 << index)) != 0);
            for (var boss = firstBoss; boss < 6; boss++)
            {
                token.ThrowIfCancellationRequested();
                if ((config.DreamTrialBossMask & (1 << boss)) == 0)
                {
                    // 六位 Boss 必须顺序挑战；遇到未选择的下一位即结束。
                    if (panelOpen) await CloseDreamTrialPanelAsync(token);
                    lastEntryRunSucceeded = true;
                    State("梦境试炼完成：已到达未选择的 Boss");
                    return;
                }
                if (!panelOpen && !await OpenDreamTrialPanelAsync(token))
                {
                    State("梦境试炼：未能打开挑战界面");
                    return;
                }
                panelOpen = true;
                dreamTrialVictoryObserved = false;
                await adb.TapScreen(new[] { .195, .305, .415, .525, .640, .755 }[boss], .50);
                await Task.Delay(250, token);
                await adb.TapScreen(.500, .870);
                Log($"梦境试炼：开始挑战第 {boss + 1} 位 Boss");
                if (!await WaitForDreamTrialEntryAsync(token))
                {
                    State("梦境试炼：挑战后未进入地图");
                    return;
                }
                if (!await AcceptDreamTrialQuestAsync(token))
                {
                    State("梦境试炼：未能接取挑战任务");
                    return;
                }
                await RunMovementScope(token, StartRunCore, startupProbePaused: true);
                token.ThrowIfCancellationRequested();
                if (!lastMapRunSucceeded)
                {
                    State("梦境试炼：跑图未完成");
                    return;
                }
                // 胜利页可能回城后不自动重开挑战界面，不能仅凭弹窗缺席判断战败。
                panelOpen = await WaitForDreamTrialPanelAsync(token);
                if (!panelOpen)
                {
                    if (!dreamTrialVictoryObserved)
                    {
                        lastEntryRunSucceeded = true;
                        State("梦境试炼完成：战败回城，未出现胜利页和挑战界面");
                        return;
                    }
                    Log($"梦境试炼：第 {boss + 1} 位 Boss 已胜利，但回城后挑战界面未自动弹出");
                    var nextSelected = boss + 1 < 6 && (config.DreamTrialBossMask & (1 << (boss + 1))) != 0;
                    if (!nextSelected)
                    {
                        lastEntryRunSucceeded = true;
                        State("梦境试炼完成：最后一位已选 Boss 胜利");
                        return;
                    }
                    panelOpen = await OpenDreamTrialPanelAsync(token);
                    if (!panelOpen)
                    {
                        State("梦境试炼：胜利后未能重新打开挑战界面");
                        return;
                    }
                }
                else if (!dreamTrialVictoryObserved)
                    Log($"梦境试炼：第 {boss + 1} 位 Boss 回城后出现挑战界面，判定挑战成功");
            }
            await CloseDreamTrialPanelAsync(token);
            lastEntryRunSucceeded = true;
            State("梦境试炼：六位 Boss 挑战完成");
        }
        finally
        {
            dreamTrialRunning = false;
            entryRunMovementScope = false;
        }
    }

    async Task<string> ReadDreamTrialScreenTextAsync(CancellationToken token)
    {
        using var frame = await adb.CaptureScreenForAutomationAsync(token);
        var words = await adb.ReadOcrWordsAsync(frame, token);
        return string.Concat(words.Select(word => OcrTextLocator.Compact(word.Text)));
    }

    async Task<bool> IsDreamTrialPanelOpenAsync(CancellationToken token)
    {
        using var frame = await adb.CaptureScreenForAutomationAsync(token);
        var levelArea = new Rectangle((int)(frame.Width * .065), (int)(frame.Height * .075),
            (int)(frame.Width * .145), (int)(frame.Height * .165));
        using var levelImage = frame.Clone(levelArea, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
        var levelWords = await adb.ReadOcrWordsAsync(levelImage, token);
        var levelText = string.Concat(levelWords.Select(word => OcrTextLocator.Compact(word.Text)));
        return levelText.Contains("梦境等级", StringComparison.Ordinal) &&
            System.Text.RegularExpressions.Regex.IsMatch(levelText, @"\d{2,4}");
    }

    async Task<bool> WaitForDreamTrialPanelAsync(CancellationToken token)
    {
        for (var attempt = 0; attempt < 12; attempt++)
        {
            if (await IsDreamTrialPanelOpenAsync(token)) return true;
            await Task.Delay(350, token);
        }
        return false;
    }

    async Task<bool> OpenDreamTrialPanelAsync(CancellationToken token)
    {
        for (var attempt = 0; attempt < 8; attempt++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            if (BuiltInUiTemplateCatalog.FindBastanTitle(frame) is not null)
            {
                await adb.TapScreen(.495, .247);
                await Task.Delay(450, token);
                return await WaitForDreamTrialPanelAsync(token);
            }
            var marker = BuiltInUiTemplateCatalog.FindMinimapPlayer(frame);
            if (marker is not null && marker.Score >= .55)
            {
                await adb.TapScreen(marker.Center.X / (double)frame.Width, marker.Center.Y / (double)frame.Height);
                await Task.Delay(500, token);
            }
            else await Task.Delay(300, token);
        }
        return false;
    }

    async Task CloseDreamTrialPanelAsync(CancellationToken token)
    {
        await adb.TapScreen(.028, .968);
        await Task.Delay(250, token);
    }

    async Task<bool> WaitForDreamTrialEntryAsync(CancellationToken token)
    {
        for (var attempt = 0; attempt < 50; attempt++)
        {
            token.ThrowIfCancellationRequested();
            var map = await adb.ReadMap();
            if (map.CaveMode == 5 && !MapRunTask.IsReturnDestination(map) &&
                map.MapName.Contains("神秘商人", StringComparison.Ordinal))
                return true;
            await Task.Delay(300, token);
        }
        return false;
    }

    async Task<bool> AcceptDreamTrialQuestAsync(CancellationToken token)
    {
        for (var attempt = 0; attempt < 16; attempt++)
        {
            token.ThrowIfCancellationRequested();
            if (!await RefreshMap(false, waitForLock: true) || dungeon.Map is not { } map) return false;
            if (map.CaveMode != 5 || !map.MapName.Contains("神秘商人", StringComparison.Ordinal)) return false;
            var merchants = map.Tiles.SelectMany(row => row)
                .Where(tile => tile.Roles.Any(role => role.Kind == "商人"))
                .Select(tile => new Cell(tile.X, tile.Y)).ToArray();
            var npc = map.Tiles.SelectMany(row => row)
                .Where(tile => tile.Roles.Any(role => role.ClassName == "TriggerNpcData" &&
                    role.Kind == "未知"))
                .OrderBy(tile => merchants.Length == 0 ? 0 : merchants.Min(merchant =>
                    Math.Abs(merchant.X - tile.X) + Math.Abs(merchant.Y - tile.Y)))
                .FirstOrDefault();
            if (npc is null) { Warn("梦境试炼：神秘商人旁未找到挑战 NPC"); return false; }
            var target = new Cell(npc.X, npc.Y);
            var player = new Cell(map.Player.X, map.Player.Y);
            if (Math.Abs(target.X - player.X) + Math.Abs(target.Y - player.Y) == 1)
            {
                await SendInteraction((new Cell(target.X - player.X, target.Y - player.Y), "挑战任务 NPC"), token);
                await Task.Delay(450, token);
                var text = await ReadDreamTrialScreenTextAsync(token);
                if (!text.Contains("挑战任务", StringComparison.Ordinal)) continue;
                await adb.TapScreen(.595, .710);
                Log("梦境试炼：已点击挑战任务绿色勾");
                await Task.Delay(400, token);
                return true;
            }
            var stops = new[] { new Cell(target.X - 1, target.Y), new Cell(target.X + 1, target.Y),
                new Cell(target.X, target.Y - 1), new Cell(target.X, target.Y + 1) }
                .Where(cell => map.ByCell.TryGetValue(cell, out var tile) && tile.Walkable)
                .Select(cell => Planner.PlanToTarget(map, cell, clearRoadMonsters: false, dungeon.Blocked))
                .Where(plan => string.IsNullOrWhiteSpace(plan.FailureReason) && plan.Route.Count > 0)
                .OrderBy(plan => plan.Route.Count).FirstOrDefault();
            if (stops is null) return false;
            route = stops.Route;
            plannedInteractions = stops.Interactions;
            plannedTargetUniverse = stops.TargetUniverse;
            mapPanel.Route = route;
            mapPanel.Invalidate();
            if (route.Count < 2) return false;
            var result = await ExecuteRouteSlice(token);
            if (result.InterruptedByPopup) await HandleMovementPopupInterrupt(token);
        }
        return false;
    }

    async Task<bool> TryHandleDreamTrialVictoryAsync(CancellationToken token)
    {
        if (!dreamTrialRunning) return false;
        var text = await ReadDreamTrialScreenTextAsync(token);
        if (!text.Contains("返回城镇", StringComparison.Ordinal) ||
            !text.Contains("梦境等级", StringComparison.Ordinal)) return false;
        dreamTrialVictoryObserved = true;
        await touch.EmergencyRelease();
        await adb.TapScreen(.585, .630);
        Log("梦境试炼：Boss 胜利，已点击返回城镇");
        await Task.Delay(350, token);
        return true;
    }
}
