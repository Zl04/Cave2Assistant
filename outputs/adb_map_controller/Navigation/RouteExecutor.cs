using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed class RouteExecutor
{
    readonly IPlayerStatusSource playerStatus;
    readonly IMovementInput movement;

    public RouteExecutor(IPlayerStatusSource playerStatus, IMovementInput movement)
    {
        this.playerStatus = playerStatus ?? throw new ArgumentNullException(nameof(playerStatus));
        this.movement = movement ?? throw new ArgumentNullException(nameof(movement));
    }

    // 弹窗中断与错误路线有意区分。调用方必须先让弹窗处理程序消耗覆盖层，
    // 然后从权威位置构建新路线。
    public async Task<RouteExecutionResult> ExecuteDetailed(
        RouteExecutionContext context,
        CancellationToken token,
        Func<MotionInterruptReason>? getInterrupt = null)
    {
        var map = context.Map;
        var route = context.Session.Route;
        var interactions = context.Session.Interactions;
        var observer = context.Observer;
        var runtime = context.Runtime;
        var tuning = context.Tuning;
        if (route.Count < 2) return new(RouteExecutionStatus.Completed);
        var actualStart = new Cell(map.Player.X, map.Player.Y);
        if (route[0] != actualStart)
        {
            observer.WriteLog($"路线起点已过期：路线 {route[0]}，人物 {actualStart}，重新规划");
            return new(RouteExecutionStatus.Replan);
        }
        var index = 0; var held = false; Cell? heldDelta = null; var segmentStart = route[0]; var completed = false;
        runtime.ObservePosition(actualStart);
        var executionLimit = route.Count;
        foreach (var task in interactions.Where(task => context.TargetExists(task.Target) || PortalRouting.IsPortalKind(task.Target.Kind)))
        {
            var stopIndex = route.FindIndex(1, cell => cell == task.Stop);
            if (stopIndex > 0) executionLimit = Math.Min(executionLimit, stopIndex + 1);
        }
        var enteringRoomPortal = interactions.Any(task => task.Target.Kind == "秘境传送门" &&
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
                if (runtime.PulseFallback) { end = index + 1; expected = route[end]; segmentLength = 1; }
                var canPreTurn = end - index >= 2 && (end < executionLimit - 1 || (executionLimit < route.Count && end == executionLimit - 1));
                var preTurned = false;
                var releaseLead = tuning.ReleaseLeadMs;
                var cellsPerSecond = Math.Max(0.1, runtime.MoveSpeed / 1000.0);
                var predictedPreTurnAt = Environment.TickCount64 +
                    (long)Math.Max(0, (segmentLength / cellsPerSecond) * 1000.0 - releaseLead);
                observer.SetState(segmentLength == 1 ? $"单格脉冲 {delta.X},{delta.Y}，等待到达 {expected}" : $"按住 {delta.X},{delta.Y}，等待到达 {expected}");
                if (segmentLength == 1)
                {
                    if (held && heldDelta == delta) await movement.TouchUp();
                    else await movement.PulseOneCell(context.MapInput(delta), tuning.PulseHoldMs, token);
                    held = false; heldDelta = null;
                    observer.WriteLog($"单格脉冲：{segmentStart} -> {expected}");
                }
                else if (!held) { await movement.TouchDown(context.MapInput(delta), token); held = true; heldDelta = delta; }
                else if (heldDelta != delta) { await movement.ChangeDirection(context.MapInput(delta), token); heldDelta = delta; }

                var after = segmentStart; var observedSequence = 0L;
                // 负 lead 表示“延迟释放”。即使坐标采样提前到达预期格，
                // 也要一直按住输入，直到计算出的释放时间戳。
                // 这样可以避免等到坐标读取过晚后才增加延迟，
                // 导致释放过迟并继续移动到下一个格子。
                while (after != expected || (releaseLead < 0 && held && Environment.TickCount64 < predictedPreTurnAt))
                {
                    await Task.Delay(5, token);
                    var status = await playerStatus.ReadPlayer();
                    token.ThrowIfCancellationRequested();
                    observedSequence = status.Sequence;
                    if (status.MoveSpeed > 0) runtime.MoveSpeed = status.MoveSpeed;
                    after = new Cell(status.Player.X, status.Player.Y);
                    ApplyPlayerStatus(map, status);
                    observer.MapChanged();
                    var positionChanged = after != lastPosition;
                    if (positionChanged) { lastPosition = after; lastChange = Environment.TickCount64; }
                    if (runtime.ObservePosition(after))
                    {
                        if (held) { await movement.TouchUp(); held = false; heldDelta = null; }
                        observer.WriteLog($"检测到人物反复横跳：切换为单格脉冲，当前位置 {after}");
                        return new(RouteExecutionStatus.Replan);
                    }
                    var routeIndex = route.FindIndex(index + 1, end - index, cell => cell == after);
                    if (after != segmentStart && routeIndex < index + 1)
                    {
                        // 进入房间传送门可能在最终传送门格作为普通路线位置可见前就移动玩家。
                        // 将最终一段的坐标跳变视为成功的传送门转场；MainForm
                        // 会在刷新时验证并学习目的地。
                        if (enteringRoomPortal && end == executionLimit - 1)
                        {
                            observer.WriteLog($"进入层内传送门后检测到坐标跳转：{segmentStart} -> {after}");
                            return new(RouteExecutionStatus.Completed);
                        }
                        observer.WriteLog($"人物偏离路线：{after}，立即重新规划"); return new(RouteExecutionStatus.Replan);
                    }
                    if (!preTurned && held && Environment.TickCount64 >= predictedPreTurnAt &&
                        (releaseLead < 0 || (canPreTurn && after != expected)))
                    {
                        await movement.TouchUp(); held = false; heldDelta = null; preTurned = true;
                        if (releaseLead < 0)
                            observer.WriteLog($"速度预测松开：直线 {segmentLength} 格，延迟 {-releaseLead}ms，目标 {expected}");
                        else
                            observer.WriteLog($"速度预判松开：直线 {segmentLength} 格，提前 {releaseLead}ms，等待转向点 {expected}");
                    }
                    if (Environment.TickCount64 - lastChange >= tuning.StallTimeoutMs)
                    {
                        if (after == segmentStart) context.Blocked.Add(route[index + 1]);
                        observer.WriteLog($"移动受阻：{segmentStart} -> {expected}，立即重新规划"); return new(RouteExecutionStatus.Replan);
                    }
                }
                observer.WriteLog(segmentLength == 1 ? $"单格位置已确认：{segmentStart} -> {expected}" : $"到达转向点 {expected}");
                // 释放后验证每个分段，包括脉冲、预测性释放和最终交互停靠点。
                {
                    if (held) { await movement.TouchUp(); held = false; heldDelta = null; }
                    var deadline = Environment.TickCount64 + 120L; PlayerStatus boundary;
                    do { await Task.Delay(5, token); boundary = await playerStatus.ReadPlayer(); }
                    while (boundary.Sequence <= observedSequence && Environment.TickCount64 < deadline);
                    if (boundary.Sequence <= observedSequence)
                    {
                        // 输入释放后，导出器可能会短暂滞后。
                        // 不要让暂时没有更新快照的状态传递到 RunLoop，否则会停止整个自动化。
                        // 重新规划会在再次尝试路线前刷新权威状态。
                        observer.WriteLog("松开后未收到新的人物状态，返回重规划并重试移动");
                        return new(RouteExecutionStatus.Replan);
                    }
                    if (boundary.MoveSpeed > 0) runtime.MoveSpeed = boundary.MoveSpeed;
                    var boundaryCell = new Cell(boundary.Player.X, boundary.Player.Y); map.Player = boundary.Player; observer.MapChanged();
                    if (runtime.ObservePosition(boundaryCell))
                    {
                        observer.WriteLog($"检测到人物反复横跳：切换为单格脉冲，当前位置 {boundaryCell}");
                        return new(RouteExecutionStatus.Replan);
                    }
                    if (boundaryCell != expected) { observer.WriteLog($"转角坐标复核不一致：期望 {expected}，实际 {boundaryCell}，重新规划"); return new(RouteExecutionStatus.Replan); }
                }
                segmentStart = expected; index = end;
            }
            completed = index == executionLimit - 1;
        }
        catch (OperationCanceledException) when (getInterrupt?.Invoke() == MotionInterruptReason.Popup)
        {
            return new(RouteExecutionStatus.InterruptedByPopup);
        }
        finally { if (held) await movement.TouchUp(); }
        if (completed && executionLimit < route.Count) observer.WriteLog($"到达完整路线中的任务停靠点 {segmentStart}");
        return new(RouteExecutionStatus.Completed);
    }

    public static void ApplyPlayerStatus(MapDump map, PlayerStatus status)
    {
        if (status.Level == map.Level)
        {
            map.Player = status.Player;
            map.Confused = status.Confused;
            map.Reversed = status.Reversed;
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
