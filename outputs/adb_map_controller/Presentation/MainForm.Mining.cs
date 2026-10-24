using System;
using System.Drawing;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AdbMapController;

public sealed partial class MainForm
{
    bool miningRouteDisplaySuppressed;
    readonly ThemedNumericUpDown miningTileWidth = new() { Minimum = 20, Maximum = 500, Value = 200, Width = 65 };
    readonly ThemedNumericUpDown miningTileHeight = new() { Minimum = 20, Maximum = 300, Value = 100, Width = 65 };
    readonly ThemedNumericUpDown miningInterval = new() { Minimum = 500, Maximum = 30000, Increment = 500, Value = 3000, Width = 75 };

    Control CreateMiningSettings()
    {
        var panel = new FlowLayoutPanel
        {
            Dock = DockStyle.Top,
            AutoSize = true,
            Padding = new(10, 7, 10, 5),
            WrapContents = true,
            Tag = ThemeRole.SurfaceAlt
        };
        Label Caption(string text) => new() { Text = text, AutoSize = true, Padding = new(0, 5, 0, 0) };
        panel.Controls.AddRange([Caption("挖矿：格宽/高（1280×720）"),
            miningTileWidth,
            miningTileHeight,
            Caption("使用间隔(ms)"),
            miningInterval,
            Caption("人物以屏幕中心计算，使用底栏第二格道具")]);
        foreach (var control in new[] { miningTileWidth, miningTileHeight, miningInterval })
            control.ValueChanged += (_, _) => SaveSettings();
        return panel;
    }

    async Task StartMining()
    {
        if (activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false })
        { State("请先暂停当前任务，再开始挖矿"); return; }
        await RunMovement(MineCore, startupProbePaused: true);
    }

    enum MiningPassResult { Completed, Failed }

    async Task MineCore()
    {
        var owner = operations.CurrentToken;
        try
        {
            State("挖矿：检查地图和弹窗");
            var ready = await RefreshMap(true, waitForLock: true, onMapReady: ClearMiningRoute);
            startupPreparing = false;
            owner.ThrowIfCancellationRequested();
            if (!ready || dungeon.Map is null) { State("挖矿：地图未就绪"); return; }
            dungeon.Blocked.Clear();
            await MineFloorCore(owner, dungeon.Map);
        }
        catch (OperationCanceledException) when (owner.IsCancellationRequested)
        { State("挖矿已暂停"); }
        finally
        {
            startupPreparing = false;
            try { await touch.TouchUp(); }
            finally
            {
                ClearMiningRoute();
            }
        }
    }

    async Task<MiningPassResult> MineFloorCore(CancellationToken token, MapDump initial)
    {
        // 只读取一次入场地图边界；后续扩图补出的墙不属于本轮范围。
        var miningRange = new MiningRange(initial.Width - 1, initial.Height - 1);
        var mined = 0;
        var recovery = 0;
        lastMiningRetryOrigin = null;
        miningRouteDisplaySuppressed = true;
        mapPanel.Route = [];
        mapPanel.Invalidate();
        var selectionMayBeOpen = false;
        try
        {
            while (true)
            {
                token.ThrowIfCancellationRequested();
                if (!await RefreshMap(false, waitForLock: true))
                { State("挖矿：地图读取失败，已停止"); return MiningPassResult.Failed; }
                token.ThrowIfCancellationRequested();
                var map = dungeon.Map!;
                if (serverErrorDialogVisible || runeSelectionVisible ||
                    dungeon.MotionInterrupt.Reason == MotionInterruptReason.Popup || floorPhase == FloorPhase.SelectBonus)
                { State("挖矿：检测到弹窗，已停止"); return MiningPassResult.Failed; }
                if (!SameMiningMap(initial, map) || map.SceneType == 1 || map.IsDead)
                { State("挖矿：地图已切换、位于城镇或人物死亡，已停止"); return MiningPassResult.Failed; }
                if (map.InBattle)
                {
                    await touch.EmergencyRelease();
                    State("挖矿：等待战斗结束");
                    await Task.Delay(120, token);
                    continue;
                }

                var toolStatus = cardMiningTaskRunning
                    ? await ReadCardMiningToolStatusWithFallbackAsync(token)
                    : await adb.ReadMiningToolStatusAsync(token);
                if (toolStatus is null)
                { State("挖矿：镐子数量暂时无法确认，准备重新读取"); return MiningPassResult.Failed; }
                if (toolStatus.Quantity is 0)
                {
                    Log(cardMiningTaskRunning
                        ? $"挖矿道具首次读为 0：已挖 {mined} 格，交由卡矿任务再次核对"
                        : $"挖矿道具已用完：已挖 {mined} 格");
                    State(cardMiningTaskRunning
                        ? "挖矿暂停：核对镐子是否真正耗尽"
                        : $"挖矿完成：道具已用完，已挖 {mined} 格");
                    return MiningPassResult.Completed;
                }
                if (MiningToolGuard.StopReason(toolStatus) is { } toolStopReason)
                {
                    Log($"挖矿道具检查停止：图标={(toolStatus.IconPresent ? "已放置" : "未放置")}，数量={(toolStatus.Quantity?.ToString() ?? "未识别")}");
                    State(toolStopReason);
                    return MiningPassResult.Failed;
                }

                var plan = MiningPlanner.Plan(map, dungeon.Blocked, miningRange);
                if (plan is null)
                {
                    State($"挖矿结束：没有可达的挖矿位置，已挖 {mined} 格");
                    return MiningPassResult.Completed;
                }
                route = plan.Movement.Route;
                plannedInteractions = plan.Movement.Interactions;
                plannedTargetUniverse = plan.Movement.TargetUniverse;
                var player = new Cell(map.Player.X, map.Player.Y);
                var fight = plannedInteractions.FirstOrDefault(task => task.Stop == player);
                if (fight != default)
                {
                    if (!await ConfirmInteractionStop(player, token)) continue;
                    if (await FightWhileHolding(fight, token))
                    { State("挖矿：战斗交互被弹窗中断，已停止"); return MiningPassResult.Failed; }
                    continue;
                }
                if (player != plan.Stop)
                {
                    State($"挖矿：移动至 {plan.Stop}，目标墙体 {plan.Wall}");
                    var result = await ExecuteRouteSlice(token);
                    if (result.InterruptedByPopup)
                    { State("挖矿：移动被弹窗中断，已停止"); return MiningPassResult.Failed; }
                    if (result.RequiresReplan && ++recovery > (int)routeRecoveryAttempts.Value)
                    { State("挖矿：移动连续失败，已停止"); return MiningPassResult.Failed; }
                    if (!result.RequiresReplan) recovery = 0;
                    continue;
                }

                await touch.TouchUp();
                // 等待松开和镜头跟随后再读取人物位置，避免沿用移动前的点击偏差。
                await Task.Delay(200, token);
                if (!await RefreshMap(false, waitForLock: true))
                { State("挖矿：点击前地图读取失败"); return MiningPassResult.Failed; }
                token.ThrowIfCancellationRequested();
                if (!CanMineNow(initial, miningRange, player, plan.Wall)) continue;
                var clicked = false;
                var confirmed = false;
                var mapChanged = false;
                var noHighlight = false;
                var beforeMap = dungeon.Map!;
                var interrupted = await RunMovementSlice(token, async sliceToken =>
                {
                    sliceToken.ThrowIfCancellationRequested();
                    // A previous selection may still be closing. Never use an
                    // already highlighted frame as the difference baseline.
                    if (await adb.HasMiningCancelIconAsync(sliceToken))
                    {
                        if (!await CancelMiningSelectionAsync(sliceToken)) return;
                        await Task.Delay(350, sliceToken);
                    }
                    using var before = await adb.CaptureScreenForAutomationAsync(sliceToken);
                    var tool = MiningScreenCoordinates.ToolSlot;
                    selectionMayBeOpen = true;
                    await adb.TapScreen(tool.X, tool.Y);
                    MiningHighlight? highlight = null;
                    var cancelSeen = false;
                    var inspectedFrames = 0;
                    var selectionDeadline = Environment.TickCount64 + 5000;
                    while (Environment.TickCount64 < selectionDeadline)
                    {
                        await Task.Delay(150, sliceToken);
                        using var after = await adb.CaptureScreenForAutomationAsync(sliceToken);
                        inspectedFrames++;
                        if (!adb.HasMiningCancelIcon(after)) continue;
                        cancelSeen = true;
                        highlight = MiningHighlightDetector.Find(before, after);
                        if (highlight is not null) break;
                    }
                    if (highlight is null)
                    {
                        noHighlight = true;
                        Log($"挖矿高亮未命中：取消按钮={(cancelSeen ? "已出现" : "未出现")}，检查帧数={inspectedFrames}");
                        return;
                    }
                    // Confirm that the player is still in the same safe game state.
                    if (!await RefreshMap(false, waitForLock: true)) return;
                    sliceToken.ThrowIfCancellationRequested();
                    if (!CanMineNow(initial, miningRange, player, plan.Wall)) return;
                    var point = highlight.Value.Click;
                    await adb.TapScreen(point.X / (double)before.Width, point.Y / (double)before.Height);
                    clicked = true;
                    Log($"挖矿高亮点击：人物 {player}，位置 ({point.X}, {point.Y})，高亮面积 {highlight.Value.Area:F0}");
                    var deadline = Environment.TickCount64 + 5000;
                    while (Environment.TickCount64 < deadline)
                    {
                        await Task.Delay(150, sliceToken);
                        if (!await RefreshMap(false, waitForLock: true)) continue;
                        sliceToken.ThrowIfCancellationRequested();
                        if (!SameMiningMap(initial, dungeon.Map!))
                        {
                            mapChanged = true;
                            return;
                        }
                        if (HasNewlyMinedWall(beforeMap, dungeon.Map!))
                        {
                            confirmed = true;
                            selectionMayBeOpen = false;
                            return;
                        }
                    }
                });
                if (interrupted)
                {
                    State("挖矿被弹窗中断，已停止");
                    return MiningPassResult.Failed;
                }
                if (!clicked)
                {
                    if (!await CancelMiningSelectionAsync(token))
                    { State("挖矿选择未能取消，已停止"); return MiningPassResult.Failed; }
                    selectionMayBeOpen = false;
                    if (!noHighlight) continue;
                    Log("未识别到明显的挖矿高亮，随机移动一格后重试");
                    if (!await MoveRandomlyForMiningRetry(token))
                    { State("未识别到高亮且无法移动，已停止"); return MiningPassResult.Failed; }
                    continue;
                }
                if (mapChanged)
                {
                    State("挖矿确认时地图已切换，已停止");
                    return MiningPassResult.Failed;
                }
                if (!confirmed)
                {
                    if (!await CancelMiningSelectionAsync(token))
                    { State("挖矿选择未能取消，已停止"); return MiningPassResult.Failed; }
                    selectionMayBeOpen = false;
                    Log("高亮墙体在 5 秒内未确认变为道路，随机移动后继续挖矿");
                    State("挖矿未确认，随机移动后继续尝试");
                    if (!await MoveRandomlyForMiningRetry(token))
                    {
                        State("挖矿未确认且无法随机移动，已停止");
                        return MiningPassResult.Failed;
                    }
                    await Task.Delay((int)miningInterval.Value, token);
                    continue;
                }
                mined++;
                RecordConfirmedCardMiningUse();
                recovery = 0;
                ClearMiningRoute();
                State($"挖矿成功 {mined} 格，等待道具冷却");
                Log("已确认挖矿后墙体变为道路");
                await Task.Delay((int)miningInterval.Value, token);
            }
        }
        finally
        {
            miningRouteDisplaySuppressed = false;
            if (selectionMayBeOpen)
            {
                try { await CancelMiningSelectionAsync(CancellationToken.None); }
                catch (Exception ex) { Error(ex); }
            }
        }
    }

    async Task<bool> TryMineBeforeFloorTransition(CancellationToken token, bool transitionAvailable = false)
    {
        if (dungeon.Map is null || dungeon.Map.InBattle || dungeon.Map.IsDead) return false;
        if (!transitionAvailable && floorPhase != FloorPhase.GoToPortal) return false;
        var initial = dungeon.Map;
        if (!ShouldMineBeforeFloorTransition(initial)) return false;

        // 导航阶段的临时封锁只用于恢复路线；进入“用完道具”的专用阶段时，
        // 重新从完整可走区域寻找矿墙，避免某次导航失败让本层提前结束挖矿。
        dungeon.Blocked.Clear();
        dungeon.LastBlockedAttempt = null;
        dungeon.UnchangedCount = 0;
        Log($"换层前开始挖矿：当前 {initial.Level} 层{(cardMining.Checked ? "（卡矿目标层）" : "")}");
        var result = await MineFloorCore(token, initial);
        ClearMiningRoute();
        if (result == MiningPassResult.Completed)
        {
            dungeon.FloorMiningCompletedLevel = initial.Level;
            State($"第 {initial.Level} 层挖矿完成，继续跑图");
        }
        else
        {
            // 道具检测可能被当前弹窗遮挡。挖矿只是换层前的附加阶段，
            // 失败时放弃本层这次挖矿，不得取消外层跑图任务；换层后自动允许再次尝试，
            // 用户也可以在弹窗关闭后用手动“挖矿”按钮重新启动。
            dungeon.FloorMiningSkippedLevel = initial.Level;
            try { await touch.EmergencyRelease(); } catch (Exception ex) { Error(ex); }
            Warn($"第 {initial.Level} 层本次挖矿失败，已放弃挖矿并继续跑图");
            State("本次挖矿失败，已放弃，继续跑图");
        }
        return true;
    }

    async Task<bool> CancelMiningSelectionAsync(CancellationToken token)
    {
        await touch.EmergencyRelease();
        if (!await adb.HasMiningCancelIconAsync(token)) return true;
        await adb.TapScreen(.956, .92);
        await Task.Delay(120, token);
        if (await adb.HasMiningCancelIconAsync(token)) return false;
        Log("挖矿已取消残留的道具选择");
        return true;
    }

    bool CanMineNow(MapDump initial, MiningRange miningRange, Cell player, Cell wall)
        => dungeon.Map is { InBattle: false, IsDead: false } map && SameMiningMap(initial, map) &&
            miningRange.Contains(wall) &&
            !serverErrorDialogVisible && !runeSelectionVisible && floorPhase != FloorPhase.SelectBonus &&
            dungeon.MotionInterrupt.Reason == MotionInterruptReason.None &&
            new Cell(map.Player.X, map.Player.Y) == player &&
            MiningPlanner.IsWall(map, wall) && MiningPlanner.InRange(player, wall);

    static bool HasNewlyMinedWall(MapDump before, MapDump after)
        => before.ByCell.Any(pair => pair.Value.TerrainType == 1 &&
            after.ByCell.TryGetValue(pair.Key, out var tile) && tile.Ground);

    static bool SameMiningMap(MapDump first, MapDump second)
        => first.Level == second.Level && first.SceneType == second.SceneType && first.CaveMode == second.CaveMode &&
            first.MapName == second.MapName;

    void ClearMiningRoute()
    {
        dungeon.Route.OptionsSignature = null;
        dungeon.Route.PlannedNavigationHash = null;
        dungeon.Route.Walkability.Clear();
        dungeon.Route.PlannedRoadMonsters.Clear();
        route = []; plannedInteractions = []; plannedTargetUniverse.Clear();
        mapPanel.Route = route; mapPanel.Invalidate();
    }
}
