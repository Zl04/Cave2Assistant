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
        CancellationTokenSource? releaseCancellation = null;
        Task? scheduledRelease = null;
        async Task StopScheduledRelease()
        {
            if (releaseCancellation is null) return;
            releaseCancellation.Cancel();
            try { if (scheduledRelease is not null) await scheduledRelease; }
            catch (OperationCanceledException) when (releaseCancellation.IsCancellationRequested) { }
            finally
            {
                releaseCancellation.Dispose();
                releaseCancellation = null;
                scheduledRelease = null;
            }
        }
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
                var releaseLead = tuning.ReleaseLeadMs;
                var cellsPerSecond = Math.Max(0.1, runtime.MoveSpeed / 1000.0);
                var predictedPreTurnAt = Environment.TickCount64 +
                    (long)Math.Max(0, (segmentLength / cellsPerSecond) * 1000.0 - releaseLead);
                var segmentStartedAt = Environment.TickCount64;
                void MotionLog(string detail) => observer.WriteLog($"移动诊断：{segmentStart}->{expected}，+{Environment.TickCount64 - segmentStartedAt}ms，{detail}");
                MotionLog($"开始，格数={segmentLength}，速度={runtime.MoveSpeed:F0}，提前={releaseLead}ms，预测松开=+{predictedPreTurnAt - segmentStartedAt}ms，单格按住={tuning.PulseHoldMs}ms");
                observer.SetState(segmentLength == 1 ? $"单格脉冲 {delta.X},{delta.Y}，等待到达 {expected}" : $"按住 {delta.X},{delta.Y}，等待到达 {expected}");
                if (segmentLength == 1)
                {
                    if (held && heldDelta == delta) await movement.TouchUp();
                    else await movement.PulseOneCell(context.MapInput(delta), tuning.PulseHoldMs, token);
                    held = false; heldDelta = null;
                    MotionLog("单格输入已松开");
                    observer.WriteLog($"单格脉冲：{segmentStart} -> {expected}");
                }
                else if (!held) { await movement.TouchDown(context.MapInput(delta), token); held = true; heldDelta = delta; }
                else if (heldDelta != delta) { await movement.ChangeDirection(context.MapInput(delta), token); heldDelta = delta; }
                if (segmentLength > 1)
                {
                    MotionLog($"方向输入已按下，距预测松开={predictedPreTurnAt - Environment.TickCount64}ms");
                    // 触摸松开与 ADB 状态读取独立计时。完成或中断此段时必须先收尾，
                    // 防止旧定时任务松开下一段的方向输入。
                    releaseCancellation = CancellationTokenSource.CreateLinkedTokenSource(token);
                    var releaseToken = releaseCancellation.Token;
                    scheduledRelease = Task.Run(ReleaseAtDeadline);
                    async Task ReleaseAtDeadline()
                    {
                        var interrupted = false;
                        try
                        {
                            var remaining = predictedPreTurnAt - Environment.TickCount64;
                            if (remaining > 0) await Task.Delay(TimeSpan.FromMilliseconds(remaining), releaseToken).ConfigureAwait(false);
                            releaseToken.ThrowIfCancellationRequested();
                        }
                        catch (OperationCanceledException) when (releaseToken.IsCancellationRequested)
                        {
                            interrupted = true;
                        }
                        // 先释放，再记录日志；同步写日志不能占用角色仍在移动的时间。
                        var releaseStartedAt = Environment.TickCount64;
                        await movement.TouchUp().ConfigureAwait(false);
                        MotionLog($"{(interrupted ? "移动中断或到点松开" : "预测松开指令完成")}，开始较预测晚={releaseStartedAt - predictedPreTurnAt}ms，指令耗时={Environment.TickCount64 - releaseStartedAt}ms");
                        if (interrupted) return;
                        if (releaseLead < 0)
                            observer.WriteLog($"速度预测松开：直线 {segmentLength} 格，延迟 {-releaseLead}ms，目标 {expected}");
                        else
                            observer.WriteLog($"速度预判松开：直线 {segmentLength} 格，提前 {releaseLead}ms，等待转向点 {expected}");
                    }
                }

                var after = segmentStart; var observedSequence = 0L;
                // 负 lead 表示“延迟释放”。即使坐标采样提前到达预期格，
                // 也要一直按住输入，直到计算出的释放时间戳。
                // 这样可以避免等到坐标读取过晚后才增加延迟，
                // 导致释放过迟并继续移动到下一个格子。
                while (after != expected || (releaseLead < 0 && held && Environment.TickCount64 < predictedPreTurnAt))
                {
                    await Task.Delay(5, token);
                    var readStartedAt = Environment.TickCount64;
                    var status = await playerStatus.ReadPlayer();
                    var readElapsedMs = Environment.TickCount64 - readStartedAt;
                    if (readElapsedMs >= 50) MotionLog($"人物状态读取耗时={readElapsedMs}ms");
                    token.ThrowIfCancellationRequested();
                    if (scheduledRelease?.IsCompleted == true)
                    {
                        await scheduledRelease;
                        held = false; heldDelta = null;
                    }
                    observedSequence = status.Sequence;
                    if (status.MoveSpeed > 0) runtime.MoveSpeed = status.MoveSpeed;
                    after = new Cell(status.Player.X, status.Player.Y);
                    ApplyPlayerStatus(map, status);
                    observer.MapChanged();
                    var positionChanged = after != lastPosition;
                    if (positionChanged)
                    {
                        MotionLog($"坐标 {lastPosition}->{after}，序号={observedSequence}，输入按住={held}，速度={runtime.MoveSpeed:F0}");
                        lastPosition = after; lastChange = Environment.TickCount64;
                    }
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
                    if (Environment.TickCount64 - lastChange >= tuning.StallTimeoutMs)
                    {
                        if (after == segmentStart) context.Blocked.Add(route[index + 1]);
                        observer.WriteLog($"移动受阻：{segmentStart} -> {expected}，立即重新规划"); return new(RouteExecutionStatus.Replan);
                    }
                }
                observer.WriteLog(segmentLength == 1 ? $"单格位置已确认：{segmentStart} -> {expected}" : $"到达转向点 {expected}");
                // 释放后验证每个分段，包括脉冲、预测性释放和最终交互停靠点。
                {
                    await StopScheduledRelease();
                    if (held) { MotionLog($"到点松开，坐标={after}"); await movement.TouchUp(); held = false; heldDelta = null; MotionLog("到点松开指令完成"); }
                    var deadline = Environment.TickCount64 + 120L; PlayerStatus boundary;
                    do { await Task.Delay(5, token); boundary = await playerStatus.ReadPlayer(); }
                    while (boundary.Sequence <= observedSequence && Environment.TickCount64 < deadline);
                    MotionLog($"松开后复核，坐标={new Cell(boundary.Player.X, boundary.Player.Y)}，序号={boundary.Sequence}，前次序号={observedSequence}");
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
        finally { await StopScheduledRelease(); if (held) await movement.TouchUp(); }
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
