using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed class RouteExecutor
{
    readonly AdbClient adb;
    readonly TouchController touch;
    readonly Func<MapDump?> getMap;
    readonly Action<MapDump> setMap;
    readonly Func<List<Cell>> getRoute;
    readonly Func<List<PlannedInteraction>> getInteractions;
    readonly Func<TargetKey, bool> hasTarget;
    readonly Func<Cell, Cell> inputDelta;
    readonly Func<double> getSpeed;
    readonly Action<double> setSpeed;
    readonly Func<int> getReleaseLead, getPulseHold, getStallTimeout;
    readonly HashSet<Cell> blocked;
    readonly Action<string> state, log;
    readonly Action invalidate;
    readonly Func<bool> getPulseFallback;
    readonly Action<bool> setPulseFallback;

    public RouteExecutor(AdbClient adb, TouchController touch, Func<MapDump?> getMap, Action<MapDump> setMap,
        Func<List<Cell>> getRoute, Func<List<PlannedInteraction>> getInteractions, Func<TargetKey, bool> hasTarget,
        Func<Cell, Cell> inputDelta, Func<double> getSpeed, Action<double> setSpeed,
        Func<int> getReleaseLead, Func<int> getPulseHold, Func<int> getStallTimeout,
        HashSet<Cell> blocked, Action<string> state, Action<string> log, Action invalidate,
        Func<bool> getPulseFallback, Action<bool> setPulseFallback)
    {
        this.adb = adb; this.touch = touch; this.getMap = getMap; this.setMap = setMap;
        this.getRoute = getRoute; this.getInteractions = getInteractions; this.hasTarget = hasTarget;
        this.inputDelta = inputDelta; this.getSpeed = getSpeed; this.setSpeed = setSpeed;
        this.getReleaseLead = getReleaseLead; this.getPulseHold = getPulseHold; this.getStallTimeout = getStallTimeout;
        this.blocked = blocked; this.state = state; this.log = log; this.invalidate = invalidate;
        this.getPulseFallback = getPulseFallback; this.setPulseFallback = setPulseFallback;
    }

    // 为只需要旧版重新规划标志的调用方提供兼容性包装器。
    public async Task<bool> Execute(CancellationToken token)
        => (await ExecuteDetailed(token)).RequiresReplan;

    // 弹窗中断与错误路线有意区分。调用方必须先让弹窗处理程序消耗覆盖层，
    // 然后从权威位置构建新路线。
    public async Task<RouteExecutionResult> ExecuteDetailed(
        CancellationToken token,
        Func<MotionInterruptReason>? getInterrupt = null)
    {
        var map = getMap() ?? throw new InvalidOperationException("地图尚未加载");
        var route = getRoute();
        if (route.Count < 2) return new(RouteExecutionStatus.Completed);
        var actualStart = new Cell(map.Player.X, map.Player.Y);
        if (route[0] != actualStart)
        {
            log($"路线起点已过期：路线 {route[0]}，人物 {actualStart}，重新规划");
            return new(RouteExecutionStatus.Replan);
        }
        var index = 0; var held = false; Cell? heldDelta = null; var segmentStart = route[0]; var completed = false;
        var recentPositions = new Queue<Cell>(4);
        var executionLimit = route.Count;
        foreach (var task in getInteractions().Where(task => hasTarget(task.Target) || PortalRouting.IsPortalKind(task.Target.Kind)))
        {
            var stopIndex = route.FindIndex(1, cell => cell == task.Stop);
            if (stopIndex > 0) executionLimit = Math.Min(executionLimit, stopIndex + 1);
        }
        var enteringRoomPortal = getInteractions().Any(task => task.Target.Kind == "秘境传送门" &&
            task.Stop == route[executionLimit - 1]);
        try
        {
            while (index + 1 < executionLimit)
            {
                token.ThrowIfCancellationRequested();
                var delta = new Cell(route[index + 1].X - route[index].X, route[index + 1].Y - route[index].Y);
                var end = index + 1;
                while (end + 1 < executionLimit)
                {
                    var nextDelta = new Cell(route[end + 1].X - route[end].X, route[end + 1].Y - route[end].Y);
                    if (nextDelta != delta) break;
                    end++;
                }
                var expected = route[end]; var lastPosition = segmentStart; var lastChange = Environment.TickCount64;
                var segmentLength = end - index;
                if (getPulseFallback()) { end = index + 1; expected = route[end]; segmentLength = 1; }
                var canPreTurn = end - index >= 2 && (end < executionLimit - 1 || (executionLimit < route.Count && end == executionLimit - 1));
                var preTurned = false;
                var releaseLead = getReleaseLead();
                var cellsPerSecond = Math.Max(0.1, getSpeed() / 1000.0);
                var predictedPreTurnAt = Environment.TickCount64 +
                    (long)Math.Max(0, (segmentLength / cellsPerSecond) * 1000.0 - releaseLead);
                state(segmentLength == 1 ? $"单格脉冲 {delta.X},{delta.Y}，等待到达 {expected}" : $"按住 {delta.X},{delta.Y}，等待到达 {expected}");
                if (segmentLength == 1)
                {
                    if (held && heldDelta == delta) await touch.TouchUp();
                    else await touch.PulseOneCell(inputDelta(delta), getPulseHold(), token);
                    held = false; heldDelta = null;
                    log($"单格脉冲：{segmentStart} -> {expected}");
                }
                else if (!held) { await touch.TouchDown(inputDelta(delta), token); held = true; heldDelta = delta; }
                else if (heldDelta != delta) { await touch.ChangeDirection(inputDelta(delta), token); heldDelta = delta; }

                var after = segmentStart; var observedSequence = 0L;
                // 负 lead 表示“延迟释放”。即使坐标采样提前到达预期格，
                // 也要一直按住输入，直到计算出的释放时间戳。
                // 这样可以避免等到坐标读取过晚后才增加延迟，
                // 导致释放过迟并继续移动到下一个格子。
                while (after != expected || (releaseLead < 0 && held && Environment.TickCount64 < predictedPreTurnAt))
                {
                    await Task.Delay(5, token);
                    var status = await adb.ReadPlayer();
                    token.ThrowIfCancellationRequested();
                    observedSequence = status.Sequence;
                    if (status.MoveSpeed > 0) setSpeed(status.MoveSpeed);
                    after = new Cell(status.Player.X, status.Player.Y);
                    ApplyPlayerStatus(map, status);
                    invalidate();
                    var positionChanged = after != lastPosition;
                    if (positionChanged) { lastPosition = after; lastChange = Environment.TickCount64; }
                    if (recentPositions.Count == 4) recentPositions.Dequeue(); recentPositions.Enqueue(after);
                    if (!getPulseFallback() && recentPositions.Count == 4)
                    {
                        var p = recentPositions.ToArray();
                        if (p[0] == p[2] && p[1] == p[3] && p[0] != p[1])
                        {
                            setPulseFallback(true); if (held) { await touch.TouchUp(); held = false; heldDelta = null; }
                            log($"检测到人物反复横跳：{p[0]} <-> {p[1]}，切换为单格脉冲"); return new(RouteExecutionStatus.Replan);
                        }
                    }
                    var routeIndex = route.FindIndex(index + 1, end - index, cell => cell == after);
                    if (after != segmentStart && routeIndex < index + 1)
                    {
                        // 进入房间传送门可能在最终传送门格作为普通路线位置可见前就移动玩家。
                        // 将最终一段的坐标跳变视为成功的传送门转场；MainForm
                        // 会在刷新时验证并学习目的地。
                        if (enteringRoomPortal && end == executionLimit - 1)
                        {
                            log($"进入层内传送门后检测到坐标跳转：{segmentStart} -> {after}");
                            return new(RouteExecutionStatus.Completed);
                        }
                        log($"人物偏离路线：{after}，立即重新规划"); return new(RouteExecutionStatus.Replan);
                    }
                    if (!preTurned && held && Environment.TickCount64 >= predictedPreTurnAt &&
                        (releaseLead < 0 || (canPreTurn && after != expected)))
                    {
                        await touch.TouchUp(); held = false; heldDelta = null; preTurned = true;
                        if (releaseLead < 0)
                            log($"速度预测松开：直线 {segmentLength} 格，延迟 {-releaseLead}ms，目标 {expected}");
                        else
                            log($"速度预判松开：直线 {segmentLength} 格，提前 {releaseLead}ms，等待转向点 {expected}");
                    }
                    if (Environment.TickCount64 - lastChange >= getStallTimeout())
                    {
                        if (after == segmentStart) blocked.Add(route[index + 1]);
                        log($"移动受阻：{segmentStart} -> {expected}，立即重新规划"); return new(RouteExecutionStatus.Replan);
                    }
                }
                log(segmentLength == 1 ? $"单格位置已确认：{segmentStart} -> {expected}" : $"到达转向点 {expected}");
                // 释放后验证每个分段，包括脉冲、预测性释放和最终交互停靠点。
                {
                    if (held) { await touch.TouchUp(); held = false; heldDelta = null; }
                    var deadline = Environment.TickCount64 + 120L; PlayerStatus boundary;
                    do { await Task.Delay(5, token); boundary = await adb.ReadPlayer(); }
                    while (boundary.Sequence <= observedSequence && Environment.TickCount64 < deadline);
                    if (boundary.Sequence <= observedSequence)
                    {
                        // 输入释放后，导出器可能会短暂滞后。
                        // 不要让暂时没有更新快照的状态传递到 RunLoop，否则会停止整个自动化。
                        // 重新规划会在再次尝试路线前刷新权威状态。
                        log("松开后未收到新的人物状态，返回重规划并重试移动");
                        return new(RouteExecutionStatus.Replan);
                    }
                    if (boundary.MoveSpeed > 0) setSpeed(boundary.MoveSpeed);
                    var boundaryCell = new Cell(boundary.Player.X, boundary.Player.Y); map.Player = boundary.Player; invalidate();
                    if (boundaryCell != expected) { log($"转角坐标复核不一致：期望 {expected}，实际 {boundaryCell}，重新规划"); return new(RouteExecutionStatus.Replan); }
                }
                segmentStart = expected; index = end;
            }
            completed = index == executionLimit - 1;
        }
        catch (OperationCanceledException) when (getInterrupt?.Invoke() == MotionInterruptReason.Popup)
        {
            return new(RouteExecutionStatus.InterruptedByPopup);
        }
        finally { if (held) await touch.TouchUp(); }
        if (completed && executionLimit < route.Count) log($"到达完整路线中的任务停靠点 {segmentStart}");
        return new(RouteExecutionStatus.Completed);
    }

    public static void ApplyPlayerStatus(MapDump map, PlayerStatus status)
    {
        if (status.Level == map.Level)
        {
            map.Player = status.Player;
            map.Confused = status.Confused;
            // When confusion ends, discard the old random button order as well.
            // Otherwise a later state update can accidentally reuse the previous
            // mapping if the boolean and direction payload arrive separately.
            map.ConfuseDirections = status.Confused ? [.. status.ConfuseDirections] : [];
        }
        if (status.Level != map.Level || status.Width != map.Width || status.Height != map.Height ||
            status.FogBits.Length != status.Width * status.Height) return;
        foreach (var tile in map.Tiles.SelectMany(row => row))
        {
            var index = tile.Y * status.Width + tile.X;
            if ((uint)index < (uint)status.FogBits.Length)
                tile.Explored = status.AllExplored || status.FogBits[index] == '1';
        }
    }
}
