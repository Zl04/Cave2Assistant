using System;
using System.Drawing;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AdbMapController;

public sealed partial class MainForm
{
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
        Cell? lastClickedWall = null;
        var repeatedWallClicks = 0;
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
                    ? await ReadCardMiningToolStatusAsync(token)
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
                mapPanel.Route = route; mapPanel.Invalidate();
                var player = new Cell(map.Player.X, map.Player.Y);
                var fight = plannedInteractions.FirstOrDefault(task => task.Stop == player);
                if (fight != default)
                {
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

                if (lastClickedWall == plan.Wall && repeatedWallClicks > 3)
                {
                    Log($"挖矿连续 {repeatedWallClicks} 次点击同一格 {plan.Wall}，先移动角色再重新规划");
                    if (!await MoveRandomlyForMiningRetry(token))
                    { State("挖矿：同一格反复尝试后无法移动，已停止"); return MiningPassResult.Failed; }
                    lastClickedWall = null;
                    repeatedWallClicks = 0;
                    continue;
                }

                await touch.TouchUp();
                // 等待松开和镜头跟随后再读取人物位置，避免沿用移动前的点击偏差。
                await Task.Delay(200, token);
                if (!await RefreshMap(false, waitForLock: true))
                { State("挖矿：点击前地图读取失败"); return MiningPassResult.Failed; }
                token.ThrowIfCancellationRequested();
                if (!CanMineNow(initial, miningRange, player, plan.Wall)) continue;
                var point = MiningScreenCoordinates.Wall(player, plan.Wall,
                    (double)miningTileWidth.Value, (double)miningTileHeight.Value);
                var clicked = false;
                var interrupted = await RunMovementSlice(token, async sliceToken =>
                {
                    sliceToken.ThrowIfCancellationRequested();
                    var tool = MiningScreenCoordinates.ToolSlot;
                    selectionMayBeOpen = true;
                    await adb.TapScreen(tool.X, tool.Y);
                    await Task.Delay(250, sliceToken);
                    // 道具面板打开后再次复核坐标。失败时停止，不在未知界面继续移动。
                    if (!await RefreshMap(false, waitForLock: true)) return;
                    sliceToken.ThrowIfCancellationRequested();
                    if (!CanMineNow(initial, miningRange, player, plan.Wall)) return;
                    await adb.TapScreen(point.X, point.Y);
                    clicked = true;
                    Log($"挖矿点击：人物 {player}，墙体 {plan.Wall}，屏幕比例 ({point.X:F4}, {point.Y:F4})");
                    selectionMayBeOpen = false;
                });
                if (interrupted)
                {
                    State("挖矿被弹窗中断，已停止");
                    return MiningPassResult.Failed;
                }
                if (!clicked) continue;
                repeatedWallClicks = lastClickedWall == plan.Wall ? repeatedWallClicks + 1 : 1;
                lastClickedWall = plan.Wall;
                mined++;
                recovery = 0;
                ClearMiningRoute();
                State($"已使用镐子 {mined} 次，等待道具冷却");
                await Task.Delay((int)miningInterval.Value, token);
            }
        }
        finally
        {
            if (selectionMayBeOpen)
            {
                try
                {
                    await touch.EmergencyRelease();
                    if (await adb.HasMiningCancelIconAsync())
                    {
                        await adb.TapScreen(.956, .92);
                        Log("挖矿失败后已取消道具选择");
                    }
                }
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

    bool CanMineNow(MapDump initial, MiningRange miningRange, Cell player, Cell wall)
        => dungeon.Map is { InBattle: false, IsDead: false } map && SameMiningMap(initial, map) &&
            miningRange.Contains(wall) &&
            !serverErrorDialogVisible && !runeSelectionVisible && floorPhase != FloorPhase.SelectBonus &&
            dungeon.MotionInterrupt.Reason == MotionInterruptReason.None &&
            new Cell(map.Player.X, map.Player.Y) == player &&
            MiningPlanner.IsWall(map, wall) && MiningPlanner.InRange(player, wall);

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
