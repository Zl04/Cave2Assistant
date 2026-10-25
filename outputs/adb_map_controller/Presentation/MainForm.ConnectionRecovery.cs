using System;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed partial class MainForm
{
    void BeginConnectionRecovery()
    {
        if (closing || connectionRecoveryTask is { IsCompleted: false }) return;
        serverErrorDialogVisible = true;
        operations.Cancel(ControllerOperationKind.Movement);
        operations.Cancel(ControllerOperationKind.Entry);
        connectionRecoveryCancellation?.Dispose();
        connectionRecoveryCancellation = new CancellationTokenSource();
        connectionRecoveryTask = RecoverConnectionAsync(connectionRecoveryCancellation.Token);
    }

    async Task RecoverConnectionAsync(CancellationToken token)
    {
        try
        {
            // Let the interrupted route release its touch session before clicking the login UI.
            var movement = activeMovement;
            var entry = activeEntry;
            if (movement is not null)
                try { await movement; } catch (OperationCanceledException) { }
            if (entry is not null && !ReferenceEquals(entry, movement))
                try { await entry; } catch (OperationCanceledException) { }

            await touch.EmergencyRelease();
            var pipeline = new ConnectionRecoveryPipeline(adb);
            var lastClickAt = 0L;
            var waitingForLoginUntil = Environment.TickCount64 + 15000;
            while (!token.IsCancellationRequested)
            {
                var elapsed = Environment.TickCount64 - lastClickAt;
                if (lastClickAt != 0 && elapsed < 2000)
                    await Task.Delay((int)(2000 - elapsed), token);

                var button = await pipeline.ClickVisibleButtonAsync(token);
                if (button is null)
                {
                    if (Environment.TickCount64 >= waitingForLoginUntil) break;
                    await Task.Delay(500, token);
                    continue;
                }

                lastClickAt = Environment.TickCount64;
                waitingForLoginUntil = lastClickAt + (button == "DisconnectConfirm" ? 15000 : 3000);
                Log($"断线恢复：已点击 {button}，仍可识别时每隔 2 秒重试");
            }
            Log("断线恢复：登录按钮已消失，停止点击");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested) { }
        catch (Exception error) { Error(error); }
    }
}
