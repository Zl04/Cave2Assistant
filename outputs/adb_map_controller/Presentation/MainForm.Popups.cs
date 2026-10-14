using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Win32;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task HandleRiftGemSelection(CancellationToken token)
    {
        await touch.EmergencyRelease();
        var now = Environment.TickCount64;
        const int maxAttempts = 5;
        const int retryIntervalMs = 700;
        if (runeSelectionClickAttempts < maxAttempts &&
            (runeSelectionClickAttempts == 0 || now - runeSelectionLastClickAt >= retryIntervalMs))
        {
            if (runeSelectionCard < 0) runeSelectionCard = Random.Shared.Next(3);
            try
            {
                await adb.TapRiftGemCard(runeSelectionCard);
                runeSelectionClickAttempts++;
                runeSelectionLastClickAt = now;
                Log($"已识别秘境宝石标题，点击第 {runeSelectionCard + 1} 张卡片（第 {runeSelectionClickAttempts}/{maxAttempts} 次）");
                State($"秘境宝石选择：点击第 {runeSelectionCard + 1} 张，等待界面关闭");
            }
            catch (Exception ex)
            {
                runeSelectionClickAttempts++;
                runeSelectionLastClickAt = now;
                Error(ex);
            }
        }
        else if (runeSelectionClickAttempts >= maxAttempts)
        {
            State("秘境宝石选择：点击未确认，继续轮询");
        }
        else State("秘境宝石选择界面，等待关闭");
        await Task.Delay(80, token);
    }

    void LatchRiftGemSelection()
    {
        runeSelectionMisses = 0;
        if (runeSelectionVisible) return;

        runeSelectionStartedAt = Environment.TickCount64;
        if (floorPhase == FloorPhase.SelectBonus)
            portalInteractionBlockedByGem = true;
        runeSelectionCard = -1;
        runeSelectionClickAttempts = 0;
        runeSelectionLastClickAt = 0;
        runeSelectionVisible = true;
        Log($"检测到秘境宝石选择界面，标题：{adb.LastRiftGemTitle ?? "<空>"}，暂停移动等待选择");
    }

    void ClearRiftGemSelectionState()
    {
        runeSelectionVisible = false;
        runeSelectionMisses = 0;
        runeSelectionStartedAt = 0;
        runeSelectionCard = -1;
        runeSelectionClickAttempts = 0;
        runeSelectionLastClickAt = 0;
        portalInteractionBlockedByGem = false;
    }

    System.Collections.IEnumerator SelectBonusRoutine(CancellationToken token)
    {
        var routineTimer = Stopwatch.StartNew();
        var probeCount = 0;
        while (true)
        {
            token.ThrowIfCancellationRequested();
            var sinceInteractionMs = portalInteractionAt > 0
                ? Environment.TickCount64 - portalInteractionAt : -1;
            Log($"换层弹窗诊断：第 {++probeCount} 轮开始，距入口点击/交互={sinceInteractionMs}ms，流程累计={routineTimer.ElapsedMilliseconds}ms");

            // 一个截图内按固定顺序区分三类换层界面：
            // 1) 带红字提醒的“贪婪选择”三选一；
            // 2) 带红字提醒的“是否进入下一层？”；
            // 3) 无红字提醒的“是否进入下一层？”。
            // 后两类虽然外观文本不同，但动作都是点击绿色对勾。
            var dialog = pendingNextFloorDialog;
            var greedySelectionReturnOnly = pendingGreedySelectionReturnOnly;
            var greedySelectionReturnCards = pendingGreedySelectionReturnCards;
            pendingNextFloorDialog = NextFloorDialogKind.None;
            pendingGreedySelectionReturnOnly = false;
            pendingGreedySelectionReturnCards = Array.Empty<int>();
            if (dialog == NextFloorDialogKind.None)
            {
                // SelectBonus 会暂停 PopupWatchdog，因此必须使用与看门狗
                // 相同的共享管线，否则宝石覆盖层可能被当成未识别的换层框。
                var popupTask = adb.ProbeMovementPopupAsync(token,
                    message => Log($"换层弹窗诊断：第 {probeCount} 轮，{message}"),
                    prioritizeNextFloor: true);
                yield return popupTask;
                var probe = popupTask.GetAwaiter().GetResult();
                var popup = probe.Value;
                Log($"换层弹窗诊断：第 {probeCount} 轮识别完成，距入口点击/交互={(portalInteractionAt > 0 ? Environment.TickCount64 - portalInteractionAt : -1)}ms，结果={popup}，子类型={probe.NextFloorDialog}");
                if (probe.NextFloorDialogBodyText is not null)
                    Log($"换层弹窗 OCR 正文：{probe.NextFloorDialogBodyText.Replace("\r", " ").Replace("\n", "|")}");
                if (popup == MovementPopupKind.ServerError)
                {
                    serverErrorDialogVisible = true;
                    operations.Cancel(ControllerOperationKind.Movement);
                    yield break;
                }
                if (popup == MovementPopupKind.RiftGemSelection)
                {
                    LatchRiftGemSelection();
                    yield break;
                }
                dialog = popup == MovementPopupKind.NextFloorDialog
                    ? probe.NextFloorDialog
                    : NextFloorDialogKind.None;
                greedySelectionReturnOnly = probe.GreedySelectionReturnOnly;
                greedySelectionReturnCards = probe.GreedySelectionReturnCards;
            }
            if (dialog is NextFloorDialogKind.WarningConfirm or NextFloorDialogKind.PlainConfirm)
            {
                if (dungeon.Map is not null && ShouldReturnFromGreedySelection(dungeon.Map))
                {
                    var releaseTask = touch.EmergencyRelease();
                    yield return releaseTask;
                    Log("指定层未出现贪婪抉择回城卡，未确认进入下一层");
                    State("指定层等待贪婪抉择回城选项");
                    operations.Cancel(ControllerOperationKind.Movement);
                    yield break;
                }
                var actionTimer = Stopwatch.StartNew();
                var tapTask = adb.TapScreen(0.591, 0.639);
                yield return tapTask;
                Log($"换层弹窗诊断：确认按钮点击={actionTimer.ElapsedMilliseconds}ms，距入口点击/交互={(portalInteractionAt > 0 ? Environment.TickCount64 - portalInteractionAt : -1)}ms");
                Log(dialog == NextFloorDialogKind.WarningConfirm
                    ? "检测到带红字提醒的‘是否进入下一层？’，已点击绿色确认按钮"
                    : "检测到无红字提醒的‘是否进入下一层？’，已点击绿色确认按钮");
                floorPhase = FloorPhase.VerifyTransition;
                portalInteractionAt = Environment.TickCount64;
                State("已确认进入下一层，等待换层");
                yield break;
            }
            if (dialog == NextFloorDialogKind.GreedySelection)
            {
                var returnAtTargetFloor = dungeon.Map is not null && ShouldReturnFromGreedySelection(dungeon.Map);
                if (returnAtTargetFloor && !greedySelectionReturnOnly && greedySelectionReturnCards.Count == 0)
                {
                    // 看门狗锁存的帧可能正好处于入场动画；重新取一帧只为补充
                    // 三张卡片中哪些是红色“回城”卡，不改变选择流程。
                    var cardProbeTask = adb.ProbeMovementPopupAsync(token,
                        message => Log($"换层弹窗诊断：第 {probeCount} 轮补充卡片识别，{message}"));
                    yield return cardProbeTask;
                    var cardProbe = cardProbeTask.GetAwaiter().GetResult();
                    if (cardProbe.NextFloorDialog == NextFloorDialogKind.GreedySelection)
                    {
                        greedySelectionReturnOnly = cardProbe.GreedySelectionReturnOnly;
                        greedySelectionReturnCards = cardProbe.GreedySelectionReturnCards;
                    }
                }
                if (returnAtTargetFloor && !greedySelectionReturnOnly && greedySelectionReturnCards.Count == 0)
                {
                    Log("指定层已检测到贪婪抉择，但暂未识别回城卡，等待重试");
                    yield return new WaitForMilliseconds(PortalDialogRetryDelayMs);
                    continue;
                }

                var preferred = bonusPriority.Items.Count == 0 ? "增益效果" : bonusPriority.Items[0]?.ToString() ?? "增益效果";
                var cardIndex = returnAtTargetFloor
                    ? (greedySelectionReturnCards.Count > 0 ? greedySelectionReturnCards[0] : 0)
                    : preferred switch
                    {
                        "回复药剂" => 1,
                        "道具" or "魔法材料" or "物资" or "锻造材料" or "附魔材料" => 2,
                        _ => 0
                    };
                var actionTimer = Stopwatch.StartNew();
                var selectTask = adb.TapScreen(cardIndex switch { 1 => 0.50, 2 => 0.6875, _ => 0.3125 }, 0.657);
                yield return selectTask;
                Log($"换层弹窗诊断：卡片点击={actionTimer.ElapsedMilliseconds}ms，距入口点击/交互={(portalInteractionAt > 0 ? Environment.TickCount64 - portalInteractionAt : -1)}ms");
                var selectedReturnCard = greedySelectionReturnOnly ||
                    (returnAtTargetFloor && greedySelectionReturnCards.Contains(cardIndex));
                if (selectedReturnCard)
                {
                    Log(returnAtTargetFloor
                        ? $"弹窗按钮点击已发送：第 {cardIndex + 1} 张回城卡，已选择‘安全回城’"
                        : $"弹窗按钮点击已发送：{preferred}，已选择‘安全回城’");
                    floorPhase = FloorPhase.WaitingReturnTown;
                    route = []; plannedInteractions = []; plannedTargetUniverse.Clear();
                    mapPanel.Route = route; mapPanel.Invalidate();
                    State("已选择安全回城，等待返回城镇");
                    // 弹窗由主循环接管时，路线移动片段已经结束。保留 owner operation，
                    // 让 RunLoop 等待城镇地图并完成战利品弹窗检查。
                    yield break;
                }
                Log($"弹窗按钮点击已发送：{preferred}，等待界面关闭");
                Log($"已选择下一层加成：{preferred}");
                floorPhase = FloorPhase.VerifyTransition;
                portalInteractionAt = Environment.TickCount64;
                State("已选择加成，等待进入下一层");
                yield break;
            }

            // 三类都未识别：只等待一小段时间，再从第一类重新检测。
            Log($"换层弹窗诊断：第 {probeCount} 轮无匹配，等待 {PortalDialogRetryDelayMs}ms 后重试");
            yield return new WaitForMilliseconds(PortalDialogRetryDelayMs);
        }
    }

    RouteExecutionContext CreateRouteExecutionContext() => new(
        dungeon.Map ?? throw new InvalidOperationException("地图尚未加载"),
        dungeon.Route,
        dungeon.Blocked,
        new MovementTuning(
            (int)movementReleaseLead.Value,
            (int)singleCellPulseHold.Value,
            (int)stallTimeout.Value),
        dungeon.RouteExecution,
        HasTarget,
        InputDelta,
        this);

    void Pause()
    {
        operations.Cancel(ControllerOperationKind.Movement);
        coroutines.StopAll(); portalChoiceCoroutine = null;
        State("正在暂停");
    }

    void CancelPortalChoiceCoroutine()
    {
        coroutines.Stop(portalChoiceCoroutine);
        portalChoiceCoroutine = null;
    }

    Task Step() => RunMovement(StepCore);

    async Task StepCore()
    {
        var owner = operations.CurrentToken;
        try
        {
            await RefreshMap(false);
            owner.ThrowIfCancellationRequested();
            if (dungeon.Map is null)
            {
                Log("单步跳过：当前没有有效地图快照，请先刷新地图");
                State("地图未就绪");
                return;
            }
            var blockedBefore = dungeon.Blocked.Count;
            var plan = Planner.PlanForFloorRecoveringTemporaryBlocks(dungeon.Map, Options(), dungeon.Blocked, visitedMechanisms);
            if (blockedBefore > 0 && dungeon.Blocked.Count == 0)
                Log($"临时封锁切断全部目标路线，已撤销 {blockedBefore} 个封锁并恢复规划");
            route = plan.Route; plannedInteractions = plan.Interactions; plannedTargetUniverse = plan.TargetUniverse;
            mapPanel.Route = route; mapPanel.Invalidate(); if (route.Count < 2) { State("无目标"); Pause(); return; }
            var before = new Cell(dungeon.Map.Player.X, dungeon.Map.Player.Y); var next = route[1]; var delta = new Cell(next.X - before.X, next.Y - before.Y);
            var runLength = 1;
            while (runLength + 1 < route.Count)
            {
                var following = new Cell(route[runLength + 1].X - route[runLength].X, route[runLength + 1].Y - route[runLength].Y);
                if (following != delta) break;
                runLength++;
            }
            var expected = route[runLength]; var after = before; var lastChange = Environment.TickCount64; var previousPosition = before;
            State($"按住 {delta.X},{delta.Y}，等待到达 {expected}");
            var popupInterrupted = await RunMovementSlice(owner, async sliceToken =>
            {
                await touch.TouchDown(InputDelta(delta), sliceToken);
                try
                {
                    while (after != expected)
                    {
                        await Task.Delay(20, sliceToken);
                        var status = await adb.ReadPlayer(); after = new Cell(status.Player.X, status.Player.Y);
                        if (after != previousPosition) { previousPosition = after; lastChange = Environment.TickCount64; }
                        var routeIndexNow = route.FindIndex(1, runLength, cell => cell == after);
                        if (after != before && routeIndexNow < 1) break;
                        if (Environment.TickCount64 - lastChange >= (long)stallTimeout.Value) break;
                    }
                }
                finally { await touch.TouchUp(); }
            });
            if (popupInterrupted)
            {
                await HandleMovementPopupInterrupt(owner);
                return;
            }
            Log($"坐标触发松开：{before} -> {after}，转向/停止点 {expected}");
            if (after == before)
            {
                dungeon.UnchangedCount = dungeon.LastBlockedAttempt == next ? dungeon.UnchangedCount + 1 : 1; dungeon.LastBlockedAttempt = next;
                if (dungeon.UnchangedCount >= 2) { dungeon.Blocked.Add(next); dungeon.UnchangedCount = 0; Warn($"格子 {next} 连续受阻，临时封锁并绕路"); }
                else Warn("未发生位移，将重新规划");
            }
            else
            {
                dungeon.UnchangedCount = 0; dungeon.LastBlockedAttempt = null;
                var routeIndex = route.FindIndex(1, Math.Min(runLength, route.Count - 1), cell => cell == after);
                if (routeIndex < 1) Warn("实际位置不在当前直线路段，已暂停并等待重新校准");
                else if (after != expected) Log($"本次实际前进 {routeIndex} 格，下轮从真实坐标继续");
                if (routeIndex < 1) Pause();
            }
        }
        catch (OperationCanceledException) { }
        catch (Exception ex) { Error(ex); Pause(); }

    }

    async Task Stop() { Pause(); try { await touch.EmergencyRelease(); } catch { } State("已急停"); Log("急停：停止发送方向操作"); }
    async Task EmergencyStopAndClear()
    {
        State("正在停止");
        operations.Cancel(ControllerOperationKind.Movement);
        operations.Cancel(ControllerOperationKind.Entry);
        ClearStoppedAutomation(clearSession: false);
        try { await StopMovement(); }
        finally { ClearStoppedAutomation(); }
        mapPanel.Route = route; mapPanel.Invalidate(); State("已停止"); Log("急停：任务已退出，已释放触控并清除换层流程");
    }

    void ClearStoppedAutomation(bool clearSession = true)
    {
        // The active executor may still reference the route while unwinding.
        // Clear its session only after its finally blocks have completed.
        if (clearSession) dungeon.StopAutomation();
        portalInteractionAt = 0;
        coroutines.StopAll(); portalChoiceCoroutine = null;
        pendingNextFloorDialog = NextFloorDialogKind.None;
        pendingGreedySelectionReturnOnly = false;
        pendingGreedySelectionReturnCards = Array.Empty<int>();
    }
    void State(string text) { if (IsDisposed || Disposing) return; if (InvokeRequired) { BeginInvoke(() => State(text)); return; } state.Text = text; mapPanel.StatusText = text; mapPanel.Invalidate(); }
    void Error(Exception ex) { CrashLog.Write("Controller operation", ex); Log("错误：" + ex.Message, LogLevel.Error); State("错误"); }

    void IRouteExecutionObserver.SetState(string text) => State(text);
    void IRouteExecutionObserver.WriteLog(string text) => Log(text);
    void IRouteExecutionObserver.MapChanged() => mapPanel.Invalidate();
}
