using System;
using System.Drawing;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed partial class MainForm
{
    async Task RunScheduledConnectionRecoveryAsync(DateTime startAt, CancellationToken token)
    {
        Log($"定时启动：等待至 {startAt:yyyy-MM-dd HH:mm}");
        while (true)
        {
            token.ThrowIfCancellationRequested();
            var remaining = startAt - DateTime.Now;
            if (remaining <= TimeSpan.Zero) break;
            State($"等待定时启动：{startAt:yyyy-MM-dd HH:mm}（剩余 {remaining:hh\\:mm\\:ss}）");
            await Task.Delay(remaining < TimeSpan.FromSeconds(30) ? remaining : TimeSpan.FromSeconds(30), token);
        }

        State("定时启动：正在恢复游戏连接");
        Log("定时启动：已到设置时间，开始断线重连");
        serverErrorDialogVisible = true;
        try
        {
            await RecoverConnectionAsync(token);
            token.ThrowIfCancellationRequested();
            if (serverErrorDialogVisible) throw new IOException("定时启动：游戏尚未就绪");
            State("定时启动：游戏已就绪，继续任务列表");
        }
        finally
        {
            // Waiting/cancellation belongs to this list item, not the background recovery monitor.
            serverErrorDialogVisible = false;
        }
    }

    void StartConnectionRecoveryTest()
    {
        if (!adb.IsTouchReady || string.IsNullOrWhiteSpace(devices.Text))
        {
            Warn("测试重连：请先连接 ADB 设备");
            return;
        }
        if (closing || stopping || taskQueueRunning || activeMovement is { IsCompleted: false } ||
            activeEntry is { IsCompleted: false } || connectionRecoveryTask is { IsCompleted: false })
        {
            Warn("测试重连：请先停止当前任务或正在进行的重连");
            return;
        }
        Log("手动测试断线重连：从当前游戏画面启动恢复流程");
        BeginConnectionRecovery();
        if (connectionRecoveryTask is { } recovery) _ = ObserveConnectionRecoveryTestAsync(recovery);
    }

    async Task ObserveConnectionRecoveryTestAsync(Task recovery)
    {
        try { await recovery; Log("手动测试断线重连完成"); }
        catch (OperationCanceledException) { Log("手动测试断线重连已取消"); }
        catch (Exception ex) { Log($"手动测试断线重连失败：{ex.Message}", LogLevel.Error); }
    }

    void BeginConnectionRecovery()
    {
        if (closing || connectionRecoveryTask is { IsCompleted: false }) return;
        serverErrorDialogVisible = true;
        // An interrupted list item is retried from its entry point. A map run keeps
        // its owner token and resumes after reading the authoritative map again.
        if (!mapRunActiveDuringRecovery)
        {
            taskRestartGeneration++;
            taskAttemptCancellation?.Cancel();
        }
        dungeon.MotionInterrupt.Request(MovementPopupKind.ServerError);
        movementExecution.Interrupt();
        connectionRecoveryCancellation?.Dispose();
        connectionRecoveryCancellation = new CancellationTokenSource();
        connectionRecoveryTask = RecoverConnectionAsync(connectionRecoveryCancellation.Token);
    }

    bool mapRunActiveDuringRecovery;
    int taskRestartGeneration;
    CancellationTokenSource? taskAttemptCancellation;

    async Task WaitForConnectionRecoveryAsync(CancellationToken token)
    {
        if (!serverErrorDialogVisible) return;
        var recovery = connectionRecoveryTask ?? throw new IOException("断线恢复尚未启动");
        await recovery.WaitAsync(token);
        token.ThrowIfCancellationRequested();
        if (serverErrorDialogVisible) throw new IOException("断线恢复后游戏仍未就绪");
    }

    async Task MonitorTaskConnectionAsync(CancellationToken token)
    {
        while (!token.IsCancellationRequested)
        {
            await Task.Delay(1000, token);
            if (serverErrorDialogVisible || mapRunActiveDuringRecovery) continue;
            try
            {
                using Bitmap frame = await adb.CaptureScreenForAutomationAsync(token);
                if (await adb.HasServerErrorDialog(frame, token)) BeginConnectionRecovery();
            }
            catch (OperationCanceledException) when (token.IsCancellationRequested) { break; }
            catch (Exception ex) { Warn($"任务断线监控暂时失败：{ex.Message}"); }
        }
    }

    async Task RecoverConnectionAsync(CancellationToken token)
    {
        try
        {
            await touch.EmergencyRelease();
            var pipeline = new ConnectionRecoveryPipeline(adb);
            var lastClickAt = 0L;
            var waitingForLoginUntil = Environment.TickCount64 + 1500;
            var deadline = Environment.TickCount64 + 120000;
            var readyFrames = 0;
            var startGameSeen = false;
            var loginFlowSeen = false;
            (int SceneType, int TownMapId, int Level)? lastScene = null;
            long lastWaitingLogAt = 0;
            void ReportWaiting(string message)
            {
                var now = Environment.TickCount64;
                if (now - lastWaitingLogAt < 3000) return;
                lastWaitingLogAt = now;
                Log($"断线恢复：{message}");
            }
            long previousMapTimestamp = 0;
            try { previousMapTimestamp = (await adb.ReadMap()).Timestamp; }
            catch (Exception ex) { Log($"断线恢复：尚无旧地图快照：{ex.Message}"); }
            while (!token.IsCancellationRequested)
            {
                if (Environment.TickCount64 >= deadline)
                    throw new TimeoutException("断线恢复超过 2 分钟，游戏仍未就绪");
                var elapsed = Environment.TickCount64 - lastClickAt;
                if (lastClickAt != 0 && elapsed < 2000)
                    await Task.Delay((int)(2000 - elapsed), token);

                ReportWaiting("正在识别登录按钮及当前画面");
                // 城镇活动文字也可能包含“登录”。先处理回城弹窗，
                // 游戏设置按钮可见时直接检查地图，不再点击登录入口。
                var townPopup = await TryCloseReturnTownPopupAsync(token, "断线恢复：");
                if (townPopup is not false)
                {
                    readyFrames = 0;
                    await Task.Delay(500, token);
                    continue;
                }
                // The settings icon remains visible behind the disconnect modal.
                // Close the modal before treating that icon as proof the game is ready.
                var button = !loginFlowSeen && await pipeline.ClickDisconnectConfirmAsync(token)
                    ? "DisconnectConfirm"
                    : null;
                if (button is null && (!startGameSeen || !await pipeline.IsGameReadyAsync(token)))
                    button = await pipeline.ClickVisibleButtonAsync(!startGameSeen, token);
                if (button is null)
                {
                    if (Environment.TickCount64 >= waitingForLoginUntil)
                    {
                        try
                        {
                            var map = await adb.ReadMap();
                            token.ThrowIfCancellationRequested();
                            if (map.SceneType >= 0 && map.Width > 0 && map.Height > 0)
                            {
                                var scene = (map.SceneType, map.TownMapId, map.Level);
                                if (lastScene is { } previous && previous != scene)
                                {
                                    readyFrames = 0;
                                    Log($"断线恢复：地图从 {previous} 切换到 {scene}，重新检查当前场景弹窗");
                                }
                                lastScene = scene;
                                var mapFresh = previousMapTimestamp == 0 || map.Timestamp > previousMapTimestamp;
                                if (!await ClearRecoveryPopupsAsync(map, mapFresh, token))
                                {
                                    readyFrames = 0;
                                    ReportWaiting($"正在处理当前画面的弹窗，场景={scene}");
                                }
                                else if (!mapFresh)
                                {
                                    readyFrames = 0;
                                    ReportWaiting($"等待新地图数据，旧时间戳={previousMapTimestamp}，当前={map.Timestamp}");
                                }
                                else if (startGameSeen && await pipeline.IsGameReadyAsync(token))
                                {
                                    if (++readyFrames >= 2)
                                    {
                                        serverErrorDialogVisible = false;
                                        State("已重新连接，继续当前任务");
                                        Log("断线恢复：当前场景弹窗已处理，连续识别到右上角设置按钮");
                                        return;
                                    }
                                    ReportWaiting("设置按钮已识别，等待再次确认");
                                }
                                else
                                {
                                    readyFrames = 0;
                                    ReportWaiting($"等待右上角设置按钮，场景={scene}");
                                }
                            }
                            else
                            {
                                readyFrames = 0;
                                ReportWaiting("等待有效地图数据");
                            }
                        }
                        catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
                        catch (Exception ex) { ReportWaiting($"等待游戏界面及弹窗处理：{ex.Message}"); }
                    }
                    await Task.Delay(500, token);
                    continue;
                }

                lastClickAt = Environment.TickCount64;
                waitingForLoginUntil = lastClickAt + (button == "DisconnectConfirm" ? 15000 : 3000);
                readyFrames = 0;
                lastScene = null;
                if (button is "LoginButton" or "StartGameButton") loginFlowSeen = true;
                if (button == "StartGameButton")
                {
                    startGameSeen = true;
                    try { previousMapTimestamp = Math.Max(previousMapTimestamp, (await adb.ReadMap()).Timestamp); }
                    catch (Exception ex) { Log($"断线恢复：等待新地图快照：{ex.Message}"); }
                }
                Log($"断线恢复：已点击 {button}，仍可识别时每隔 2 秒重试");
                if (button == "StartGameButton") Log("断线恢复：等待地图切换、弹窗处理及设置按钮出现");
            }
            token.ThrowIfCancellationRequested();
        }
        catch (Exception error) when (error is not OperationCanceledException)
        {
            Error(error);
            throw;
        }
    }

    async Task<bool> ClearRecoveryPopupsAsync(MapDump map, bool mapFresh, CancellationToken token)
    {
        // The exporter may still report the previous scene during loading.
        // Probe both popup families every round, using the current scene only
        // to choose which one to try first. A later map switch changes that order.
        dungeon.Map = map;
        if (MapRunTask.IsReturnDestination(map))
        {
            var town = await TryCloseReturnTownPopupAsync(token, "断线恢复：");
            if (town is not false) return false;
            return await ProbeRunRecoveryPopupAsync(mapFresh, token) is false;
        }

        var run = await ProbeRunRecoveryPopupAsync(mapFresh, token);
        if (run is not false) return false;
        return await TryCloseReturnTownPopupAsync(token, "断线恢复：") is false;
    }

    async Task<bool?> ProbeRunRecoveryPopupAsync(bool mapFresh, CancellationToken token)
    {
        var popup = await adb.ProbeMovementPopupAsync(token);
        if (popup.Value == MovementPopupKind.None) return false;
        if (popup.Value == MovementPopupKind.ServerError) return null;
        if (popup.Value == MovementPopupKind.NextFloorDialog && !mapFresh)
        {
            Log("断线恢复：已识别换层弹窗，等待新地图数据后处理");
            return null;
        }
        if (await HandleIndependentPopup(popup, token))
        {
            Log($"断线恢复：已处理跑图弹窗 {popup.Value}，等待界面稳定");
            return true;
        }
        return null;
    }
}
