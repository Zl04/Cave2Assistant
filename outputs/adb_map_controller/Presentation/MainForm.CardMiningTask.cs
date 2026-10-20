using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed partial class MainForm
{
    Cell? lastMiningRetryOrigin;

    static void EnforceCardMiningOptions(ControllerSettings config)
    {
        config.CardLayer = true;
        config.CardMining = false;
        config.Mining = false;
        config.TargetStopFloor = 0;
        config.EscapeReturnFloor = 0;
        config.EscapeReturnAttackBoss = false;
    }

    async Task RunCardMiningTaskAsync(ControllerSettings config, CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        EnforceCardMiningOptions(config);
        ApplySettings(config, applyEquipmentSale: false);
        cardMiningTaskRunning = true;
        cardMiningEarlyStop = false;
        cardMiningNextToolCheck = 0;
        activeCardMiningConfig = config;
        // 列表任务持有 Entry 操作锁；地图刷新只有在该操作授权导航时才允许执行。
        entryRunMovementScope = true;
        try
        {
            var selection = new DungeonEntrySelection(config.EntryMapId, config.EntryId, config.EntryDifficulty);
            var current = await adb.ReadMap();
            if (MapRunTask.IsReturnDestination(current))
            {
                if (await AutoEnterCore(selection, token) != AutoEnterResult.Entered)
                { State("卡矿任务：进入关卡失败"); return; }
            }
            await RunMovementScope(token, StartRunCore, startupProbePaused: true);
            token.ThrowIfCancellationRequested();
            if (!lastMapRunSucceeded || dungeon.Map is not { } floor ||
                !(cardMiningEarlyStop || dungeon.TargetFloorStopped))
            { State("卡矿任务：跑图未达到挖矿条件"); return; }
            var reachedTargetFloor = dungeon.TargetFloorStopped;

            while (DateTime.Now < config.CardMiningStartAt)
            {
                token.ThrowIfCancellationRequested();
                State($"卡矿任务：等待 {config.CardMiningStartAt:yyyy-MM-dd HH:mm} 开始挖矿");
                await Task.Delay(TimeSpan.FromSeconds(5), token);
            }
            while (!reachedTargetFloor)
            {
                token.ThrowIfCancellationRequested();
                var status = await ReadCardMiningToolStatusAsync(token);
                if (status is null)
                { State("卡矿任务：镐子读取超时，稍后重试"); await Task.Delay(1000, token); continue; }
                if (status.Quantity is 0)
                {
                    State($"卡矿任务：等待镐子达到 {config.CardMiningMinimumTools}，当前 0");
                    await Task.Delay(TimeSpan.FromSeconds(5), token);
                    continue;
                }
                if (!status.IconPresent || status.Quantity is null)
                { State("卡矿任务：无法确认镐子数量，已停止"); return; }
                if (status.Quantity < config.CardMiningMinimumTools)
                {
                    State($"卡矿任务：等待镐子达到 {config.CardMiningMinimumTools}，当前 {status.Quantity}");
                    await Task.Delay(TimeSpan.FromSeconds(5), token);
                    continue;
                }
                break;
            }

            while (true)
            {
                token.ThrowIfCancellationRequested();
                var status = await ReadCardMiningToolStatusAsync(token);
                if (status is null)
                { State("卡矿任务：镐子读取超时，稍后重试"); await Task.Delay(1000, token); continue; }
                if (status.Quantity is 0)
                {
                    if (await ConfirmCardMiningToolsExhaustedAsync(token)) break;
                    State("卡矿任务：镐子数量为 0 的识别未通过三次核对，继续挖矿");
                    continue;
                }
                if (MiningToolGuard.StopReason(status) is { } reason)
                { State($"卡矿任务：{reason}"); return; }
                if (!await RefreshMap(false, waitForLock: true) || dungeon.Map is null ||
                    !SameMiningMap(floor, dungeon.Map) || dungeon.Map.IsDead)
                { State("卡矿任务：地图状态异常，已停止"); return; }
                dungeon.Blocked.Clear();
                var pass = await MineFloorCore(token, dungeon.Map);
                token.ThrowIfCancellationRequested();
                status = await ReadCardMiningToolStatusAsync(token);
                if (status is null)
                { State("卡矿任务：镐子读取超时，稍后重试"); await Task.Delay(1000, token); continue; }
                if (status.Quantity is 0)
                {
                    if (await ConfirmCardMiningToolsExhaustedAsync(token)) break;
                    State("卡矿任务：镐子数量为 0 的识别未通过三次核对，继续挖矿");
                    continue;
                }
                if (MiningToolGuard.StopReason(status) is { } retryReason)
                { State($"卡矿任务：{retryReason}"); return; }
                Log($"挖矿未耗尽镐子（剩余 {status.Quantity}），随机移动后重试：{pass}");
                if (!await MoveRandomlyForMiningRetry(token))
                { State("卡矿任务：没有安全的随机移动位置，已停止"); return; }
            }

            await touch.EmergencyRelease();
            await adb.TapScreen(.978, .044);
            await Task.Delay(700, token);
            await adb.TapScreen(.500, .777);
            await Task.Delay(600, token);
            await adb.TapScreen(.591, .712);
            Log("卡矿任务：已点击返回城镇确认框的绿色勾");
            for (var attempt = 0; attempt < 30; attempt++)
            {
                await Task.Delay(500, token);
                var map = await adb.ReadMap();
                if (MapRunTask.IsReturnDestination(map))
                {
                    lastEntryRunSucceeded = true;
                    State("卡矿任务完成：镐子已耗尽，已返回城镇");
                    return;
                }
            }
            State("卡矿任务：已点击返回城镇，但未确认到达");
        }
        finally
        {
            pendingCardMiningToolRead = null;
            activeCardMiningConfig = null;
            cardMiningEarlyStop = false;
            entryRunMovementScope = false;
            cardMiningTaskRunning = false;
        }
    }

    async Task<MiningToolStatus?> ReadCardMiningToolStatusAsync(CancellationToken token)
    {
        for (var attempt = 0; attempt < 3; attempt++)
        {
            token.ThrowIfCancellationRequested();
            try
            {
                pendingCardMiningToolRead ??= adb.ReadMiningToolStatusAsync(token);
                var status = await pendingCardMiningToolRead.WaitAsync(TimeSpan.FromSeconds(8), token);
                pendingCardMiningToolRead = null;
                if (status.Quantity is not null) return status;
                if (!status.IconPresent) return status;
            }
            catch (TimeoutException) { Warn("卡矿任务读取镐子数量超时，等待本次读取完成"); }
            catch { pendingCardMiningToolRead = null; throw; }
            await Task.Delay(350, token);
        }
        return null;
    }

    async Task<bool> ConfirmCardMiningToolsExhaustedAsync(CancellationToken token)
    {
        for (var check = 1; check <= 3; check++)
        {
            token.ThrowIfCancellationRequested();
            await Task.Delay(500, token);
            MiningToolStatus status;
            try { status = await adb.ReadMiningToolStatusAsync(token).WaitAsync(TimeSpan.FromSeconds(8), token); }
            catch (TimeoutException)
            { Warn($"卡矿任务：第 {check}/3 次镐子耗尽核对超时"); return false; }
            if (status.Quantity is not 0)
            {
                Log($"卡矿任务：第 {check}/3 次耗尽核对未通过，数量={(status.Quantity?.ToString() ?? "未识别")}");
                return false;
            }
            Log($"卡矿任务：第 {check}/3 次独立核对确认镐子数量为 0");
        }
        return true;
    }

    async Task<bool> TryStopForCardMiningAsync(CancellationToken token)
    {
        if (!cardMiningTaskRunning || activeCardMiningConfig is not { } config ||
            dungeon.Map is not { InBattle: false, IsDead: false } map || MapRunTask.IsReturnDestination(map)) return false;
        if (CardFloorPolicy.Resolve(map) == map.Level)
        {
            await touch.EmergencyRelease();
            dungeon.TargetFloorStopped = true;
            ClearMiningRoute();
            Log($"卡矿任务到达目标层 {map.Level}，直接开始挖矿，不再等待镐子达到门槛");
            return true;
        }
        if (DateTime.Now < config.CardMiningStartAt || Environment.TickCount64 < cardMiningNextToolCheck) return false;
        cardMiningNextToolCheck = Environment.TickCount64 + 5000;
        MiningToolStatus status;
        try { status = await adb.ReadMiningToolStatusAsync(token); }
        catch (OperationCanceledException) { throw; }
        catch (Exception ex) { Warn($"卡矿任务读取镐子数量失败：{ex.Message}"); return false; }
        if (!status.IconPresent || status.Quantity is null || status.Quantity < config.CardMiningMinimumTools) return false;
        await touch.EmergencyRelease();
        cardMiningEarlyStop = true;
        ClearMiningRoute();
        Log($"卡矿任务时间与镐子数量已满足（{status.Quantity}/{config.CardMiningMinimumTools}），在第 {map.Level} 层开始挖矿");
        return true;
    }

    async Task<bool> MoveRandomlyForMiningRetry(CancellationToken token)
    {
        if (!await RefreshMap(false, waitForLock: true) || dungeon.Map is null)
        {
            if (await adb.HasMiningCancelIconAsync(token)) await CancelMiningSelectionAsync(token);
            return false;
        }
        var map = dungeon.Map;
        var start = new Cell(map.Player.X, map.Player.Y);
        var choices = new[] { new Cell(start.X + 1, start.Y), new Cell(start.X - 1, start.Y),
            new Cell(start.X, start.Y + 1), new Cell(start.X, start.Y - 1) }
            .Where(cell => map.ByCell.TryGetValue(cell, out var tile) && tile.Walkable &&
                !tile.Roles.Any(role => PortalRouting.IsPortalKind(role.Kind)))
            .OrderByDescending(cell => MiningPlanner.OpenGroundNeighbors(map, cell))
            .ThenBy(cell => cell == lastMiningRetryOrigin ? 1 : 0)
            .ThenBy(_ => Random.Shared.Next()).ToArray();
        foreach (var destination in choices)
        {
            route = [start, destination];
            plannedInteractions = [];
            plannedTargetUniverse.Clear();
            var result = await ExecuteRouteSlice(token);
            if (!result.InterruptedByPopup && dungeon.Map is { } moved &&
                new Cell(moved.Player.X, moved.Player.Y) == destination)
            { lastMiningRetryOrigin = start; ClearMiningRoute(); return true; }
        }
        ClearMiningRoute();
        // A failed movement attempt must not leave the pickaxe selected.
        if (await adb.HasMiningCancelIconAsync(token) && !await CancelMiningSelectionAsync(token))
            Warn("随机移动失败后，挖矿选择仍未能取消");
        return false;
    }
}
