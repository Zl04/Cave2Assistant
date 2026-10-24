using System;
using System.Linq;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed partial class MainForm
{
    Cell? lastMiningRetryOrigin;
    long pendingCardMiningToolReadStartedAt;
    int? cardMiningEstimatedTools;
    bool cardMiningEstimateUsed;

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
        cardMiningEstimatedTools = null;
        cardMiningEstimateUsed = false;
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
                var status = await ReadCardMiningToolStatusWithFallbackAsync(token);
                if (status is null)
                { State("卡矿任务：镐子读取超时，等待可用数量"); await Task.Delay(1000, token); continue; }
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
                var status = await ReadCardMiningToolStatusWithFallbackAsync(token);
                if (status is null)
                { State("卡矿任务：镐子读取超时，等待本次读取完成"); await Task.Delay(1000, token); continue; }
                if (status.Quantity is 0)
                {
                    if (await ConfirmCardMiningToolsExhaustedAsync(token) || InferredCardMiningToolsExhausted()) break;
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
                status = await ReadCardMiningToolStatusWithFallbackAsync(token);
                if (status is null)
                { State("卡矿任务：镐子读取超时，等待本次读取完成"); await Task.Delay(1000, token); continue; }
                if (status.Quantity is 0)
                {
                    if (await ConfirmCardMiningToolsExhaustedAsync(token) || InferredCardMiningToolsExhausted()) break;
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
            Log("卡矿任务：已发送第 1 次返回城镇确认点击，开始循环核对");
            var confirmationTapCount = 1;
            for (var attempt = 0; attempt < 30; attempt++)
            {
                await Task.Delay(500, token);
                var map = await adb.ReadMap();
                var returnedToTown = MapRunTask.IsReturnDestination(map);
                var confirmationStillVisible = false;
                if (!returnedToTown)
                {
                    using var frame = await adb.CaptureScreenForAutomationAsync(token);
                    confirmationStillVisible = PopupRecognition.LooksLikeCenteredGreenConfirmation(frame);
                }
                switch (CardMiningReturnConfirmationPolicy.Decide(
                    returnedToTown, confirmationStillVisible, attempt + 1))
                {
                    case CardMiningReturnConfirmationAction.Completed:
                        if (!await CloseReturnTownDialogsAsync(token))
                        {
                            State("卡矿任务：已返回城镇，但战利品或提示弹窗未确认关闭");
                            return;
                        }
                        lastEntryRunSucceeded = true;
                        State("卡矿任务完成：镐子已耗尽，已返回城镇且弹窗已关闭");
                        return;
                    case CardMiningReturnConfirmationAction.RetryTap:
                        confirmationTapCount++;
                        await adb.TapScreen(.591, .712);
                        Log($"卡矿任务：返回城镇确认框仍存在，执行第 {confirmationTapCount} 次确认点击");
                        break;
                }
            }
            State($"卡矿任务：返回城镇确认循环超时，共发送 {confirmationTapCount} 次确认点击");
        }
        finally
        {
            pendingCardMiningToolRead = null;
            pendingCardMiningToolReadStartedAt = 0;
            cardMiningEstimatedTools = null;
            cardMiningEstimateUsed = false;
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
                if (pendingCardMiningToolRead is null)
                {
                    pendingCardMiningToolRead = adb.ReadMiningToolStatusAsync(token);
                    pendingCardMiningToolReadStartedAt = Stopwatch.GetTimestamp();
                }
                var status = await pendingCardMiningToolRead.WaitAsync(TimeSpan.FromSeconds(8), token);
                pendingCardMiningToolRead = null;
                pendingCardMiningToolReadStartedAt = 0;
                if (status.Quantity is not null) return status;
                if (!status.IconPresent) return status;
            }
            catch (TimeoutException)
            {
                var elapsed = Stopwatch.GetElapsedTime(pendingCardMiningToolReadStartedAt);
                Warn($"卡矿任务读取镐子数量超时，原读取仍未完成（已等待 {elapsed.TotalSeconds:F0} 秒）");
                if (elapsed >= TimeSpan.FromSeconds(60)) return null;
            }
            catch { pendingCardMiningToolRead = null; pendingCardMiningToolReadStartedAt = 0; throw; }
            await Task.Delay(350, token);
        }
        return null;
    }

    async Task<MiningToolStatus?> ReadCardMiningToolStatusWithFallbackAsync(CancellationToken token)
    {
        // An OCR call can remain in native code after the caller's timeout. Keep
        // one pending read; a second call would only queue behind the same OCR gate.
        if (pendingCardMiningToolRead is { IsCompleted: false } &&
            Stopwatch.GetElapsedTime(pendingCardMiningToolReadStartedAt) >= TimeSpan.FromSeconds(60))
            return EstimatedCardMiningToolStatus();

        MiningToolStatus? status;
        try { status = await ReadCardMiningToolStatusAsync(token); }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
        catch (Exception ex)
        {
            Warn($"卡矿任务读取镐子数量失败，使用上次数量继续：{ex.Message}");
            pendingCardMiningToolRead = null;
            pendingCardMiningToolReadStartedAt = 0;
            return EstimatedCardMiningToolStatus();
        }
        if (status is { IconPresent: true, Quantity: >= 0 })
        {
            if (status.Quantity > 0)
            {
                cardMiningEstimatedTools = status.Quantity;
                cardMiningEstimateUsed = false;
            }
            return status;
        }
        return EstimatedCardMiningToolStatus() ?? status;
    }

    MiningToolStatus? EstimatedCardMiningToolStatus()
    {
        if (cardMiningEstimatedTools is not { } quantity) return null;
        cardMiningEstimateUsed = true;
        State($"卡矿任务：镐子读取失败，按上次数量估算剩余 {quantity}，继续挖矿");
        return new MiningToolStatus(true, quantity);
    }

    void RecordConfirmedCardMiningUse()
    {
        if (!cardMiningTaskRunning || cardMiningEstimatedTools is not { } quantity) return;
        cardMiningEstimatedTools = Math.Max(0, quantity - 1);
        Log($"卡矿任务：确认挖矿成功，估算镐子剩余 {cardMiningEstimatedTools}");
    }

    bool InferredCardMiningToolsExhausted()
    {
        if (!cardMiningEstimateUsed || cardMiningEstimatedTools is not 0) return false;
        Warn("卡矿任务：数量识别不可用，按上次可信数量和已确认的挖矿次数推定镐子耗尽");
        return true;
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
                if (status.Quantity is > 0)
                {
                    cardMiningEstimatedTools = status.Quantity;
                    cardMiningEstimateUsed = false;
                }
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
        cardMiningEstimatedTools = status.Quantity;
        cardMiningEstimateUsed = false;
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
