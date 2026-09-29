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
        var panel = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true,
            Padding = new(10, 7, 10, 5), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        Label Caption(string text) => new() { Text = text, AutoSize = true, Padding = new(0, 5, 0, 0) };
        panel.Controls.AddRange([Caption("挖矿：格宽/高（1280×720）"), miningTileWidth, miningTileHeight,
            Caption("使用间隔(ms)"), miningInterval, Caption("人物以屏幕中心计算，使用底栏第二格道具")]);
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

    async Task MineCore()
    {
        using var owner = new CancellationTokenSource();
        runCts = owner;
        touch.MovementCancellation = owner.Token;
        var mined = 0;
        var recovery = 0;
        var selectionMayBeOpen = false;
        try
        {
            State("挖矿：检查地图和弹窗");
            var ready = await RefreshMap(true, waitForLock: true, onMapReady: ClearMiningRoute);
            startupPreparing = false;
            owner.Token.ThrowIfCancellationRequested();
            if (!ready || currentMap is null) { State("挖矿：地图未就绪"); return; }
            var initial = currentMap;
            blocked.Clear();
            while (true)
            {
                owner.Token.ThrowIfCancellationRequested();
                if (!await RefreshMap(false, waitForLock: true))
                { State("挖矿：地图读取失败，已停止"); return; }
                owner.Token.ThrowIfCancellationRequested();
                var map = currentMap!;
                if (serverErrorDialogVisible || runeSelectionVisible ||
                    motionInterrupt.Reason == MotionInterruptReason.Popup || floorPhase == FloorPhase.SelectBonus)
                { State("挖矿：检测到弹窗，已停止"); return; }
                if (!SameMiningMap(initial, map) || map.SceneType == 1 || map.IsDead)
                { State("挖矿：地图已切换、位于城镇或人物死亡，已停止"); return; }
                if (map.InBattle)
                {
                    await touch.EmergencyRelease();
                    State("挖矿：等待战斗结束");
                    await Task.Delay(120, owner.Token);
                    continue;
                }

                var toolStatus = await adb.ReadMiningToolStatusAsync(owner.Token);
                if (MiningToolGuard.StopReason(toolStatus) is { } toolStopReason)
                {
                    Log($"挖矿道具检查停止：图标={(toolStatus.IconPresent ? "已放置" : "未放置")}，数量={(toolStatus.Quantity?.ToString() ?? "未识别")}");
                    State(toolStopReason);
                    return;
                }

                var plan = MiningPlanner.Plan(map, blocked);
                if (plan is null)
                {
                    State($"挖矿结束：没有可达的挖矿位置，已挖 {mined} 格");
                    return;
                }
                route = plan.Movement.Route;
                plannedInteractions = plan.Movement.Interactions;
                plannedTargetUniverse = plan.Movement.TargetUniverse;
                mapPanel.Route = route; mapPanel.Invalidate();
                var player = new Cell(map.Player.X, map.Player.Y);
                var fight = plannedInteractions.FirstOrDefault(task => task.Stop == player);
                if (fight != default)
                {
                    if (await FightWhileHolding(fight, owner.Token))
                    { State("挖矿：战斗交互被弹窗中断，已停止"); return; }
                    continue;
                }
                if (player != plan.Stop)
                {
                    State($"挖矿：移动至 {plan.Stop}，目标墙体 {plan.Wall}");
                    var result = await ExecuteRouteSlice(owner.Token);
                    if (result.InterruptedByPopup)
                    { State("挖矿：移动被弹窗中断，已停止"); return; }
                    if (result.RequiresReplan && ++recovery > (int)routeRecoveryAttempts.Value)
                    { State("挖矿：移动连续失败，已停止"); return; }
                    if (!result.RequiresReplan) recovery = 0;
                    continue;
                }

                await touch.TouchUp();
                // 等待松开和镜头跟随后再读取人物位置，避免沿用移动前的点击偏差。
                await Task.Delay(200, owner.Token);
                if (!await RefreshMap(false, waitForLock: true))
                { State("挖矿：点击前地图读取失败"); return; }
                owner.Token.ThrowIfCancellationRequested();
                if (!CanMineNow(initial, player, plan.Wall)) continue;
                var point = MiningScreenCoordinates.Wall(player, plan.Wall,
                    (double)miningTileWidth.Value, (double)miningTileHeight.Value);
                var confirmed = false;
                var interrupted = await RunMovementSlice(owner.Token, async token =>
                {
                    token.ThrowIfCancellationRequested();
                    var tool = MiningScreenCoordinates.ToolSlot;
                    selectionMayBeOpen = true;
                    await adb.TapScreen(tool.X, tool.Y);
                    await Task.Delay(250, token);
                    // 道具面板打开后再次复核坐标。失败时停止，不在未知界面继续移动。
                    if (!await RefreshMap(false, waitForLock: true)) return;
                    token.ThrowIfCancellationRequested();
                    if (!CanMineNow(initial, player, plan.Wall)) return;
                    await adb.TapScreen(point.X, point.Y);
                    Log($"挖矿点击：人物 {player}，墙体 {plan.Wall}，屏幕比例 ({point.X:F4}, {point.Y:F4})");
                    var deadline = Environment.TickCount64 + 5000;
                    while (Environment.TickCount64 < deadline)
                    {
                        await Task.Delay(150, token);
                        var refreshed = await RefreshMap(false, waitForLock: true);
                        token.ThrowIfCancellationRequested();
                        if (!refreshed) continue;
                        if (!SameMiningMap(initial, currentMap!)) return;
                        if (currentMap!.ByCell.TryGetValue(plan.Wall, out var tile) && tile.Ground)
                        { confirmed = true; selectionMayBeOpen = false; return; }
                    }
                });
                if (interrupted || !confirmed)
                {
                    State("挖矿未确认，已停止：请检查道具数量、冷却或点击校准");
                    return;
                }
                mined++;
                recovery = 0;
                ClearMiningRoute();
                State($"挖矿成功 {mined} 格，等待道具冷却");
                Log($"已确认墙体 {plan.Wall} 变为道路");
                await Task.Delay((int)miningInterval.Value, owner.Token);
            }
        }
        catch (OperationCanceledException) when (owner.IsCancellationRequested)
        { State($"挖矿已暂停，已挖 {mined} 格"); }
        finally
        {
            startupPreparing = false;
            try { await touch.TouchUp(); }
            finally
            {
                ClearMiningRoute();
                if (ReferenceEquals(runCts, owner)) runCts = null;
                if (selectionMayBeOpen) Log("挖矿选择界面可能仍然打开；请先在游戏中取消道具选择，再继续其它操作。");
            }
        }
    }

    bool CanMineNow(MapDump initial, Cell player, Cell wall)
        => currentMap is { InBattle: false, IsDead: false } map && SameMiningMap(initial, map) &&
            !serverErrorDialogVisible && !runeSelectionVisible && floorPhase != FloorPhase.SelectBonus &&
            motionInterrupt.Reason == MotionInterruptReason.None &&
            new Cell(map.Player.X, map.Player.Y) == player &&
            MiningPlanner.IsWall(map, wall) && MiningPlanner.InRange(player, wall);

    static bool SameMiningMap(MapDump first, MapDump second)
        => first.Level == second.Level && first.SceneType == second.SceneType && first.CaveMode == second.CaveMode &&
            first.Width == second.Width && first.Height == second.Height;

    void ClearMiningRoute()
    {
        routeSession.OptionsSignature = null;
        routeSession.PlannedNavigationHash = null;
        routeSession.Walkability.Clear();
        routeSession.PlannedRoadMonsters.Clear();
        route = []; plannedInteractions = []; plannedTargetUniverse.Clear();
        mapPanel.Route = route; mapPanel.Invalidate();
    }
}
