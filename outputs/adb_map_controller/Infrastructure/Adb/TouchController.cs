using System;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// 面向应用的触摸边界。移动代码依赖这个小型契约，而不必了解 ADB 如何按住、脉冲或释放接触点。
/// AdbClient 提供底层 ADB 传输。
/// </summary>
public sealed class TouchController : IDisposable
{
    readonly AdbClient adb;
    readonly SemaphoreSlim lifecycle = new(1, 1);
    (int X, int Y)? heldPoint;
    public event Action<Exception>? InputFailed;
    public CancellationToken MovementCancellation { get; set; }
    public TouchController(AdbClient adb) => this.adb = adb;

    CancellationToken OperationCancellation(CancellationToken token)
        => token.CanBeCanceled ? token : MovementCancellation;

    public async Task TouchDown(Cell delta, CancellationToken cancellationToken = default)
    {
        await lifecycle.WaitAsync();
        try
        {
            await adb.EnsureTouchReady();
            await ReleaseCore();
            OperationCancellation(cancellationToken).ThrowIfCancellationRequested();
            var point = adb.TouchPoint(delta);
            await SendTouchDown(point);
            heldPoint = point;
        }
        finally { lifecycle.Release(); }
    }

    public async Task TouchUp()
    {
        await lifecycle.WaitAsync();
        try { await ReleaseCore(); }
        finally { lifecycle.Release(); }
    }

    async Task ReleaseCore()
    {
        var point = heldPoint;
        heldPoint = null;
        if (point is null) return;
        try
        {
            await SendTouchUp();
        }
        catch
        {
            // 释放失败时不要将其视为本地仍处于按住状态。
            // 传输错误会停止路线并重新创建 Shell。
            throw;
        }
    }

    public Task ChangeDirection(Cell delta, CancellationToken cancellationToken = default)
        => TouchDown(delta, cancellationToken);

    public async Task PulseOneCell(Cell delta, int milliseconds, CancellationToken cancellationToken = default)
    {
        await lifecycle.WaitAsync();
        try
        {
            await adb.EnsureTouchReady(); await ReleaseCore();
            OperationCancellation(cancellationToken).ThrowIfCancellationRequested();
            var point = adb.TouchPoint(delta);
            await SendTouchPulse(point, Math.Max(1, milliseconds));
            OperationCancellation(cancellationToken).ThrowIfCancellationRequested();
        }
        finally { lifecycle.Release(); }
    }

    public Task HoldInteraction(Cell delta, int milliseconds, CancellationToken cancellationToken = default)
        => PulseOneCell(delta, milliseconds, cancellationToken);

    public Task EmergencyRelease() => TouchUp();

    async Task SendTouchPulse((int X, int Y) point, int milliseconds)
    {
        try { await adb.SendTouchPulse(point, milliseconds); }
        catch (Exception ex) { InputFailed?.Invoke(ex); throw; }
    }

    async Task SendTouchDown((int X, int Y) point)
    {
        try { await adb.SendTouchDown(point); }
        catch (Exception ex) { InputFailed?.Invoke(ex); throw; }
    }

    async Task SendTouchUp()
    {
        try { await adb.SendTouchUp(); }
        catch (Exception ex) { InputFailed?.Invoke(ex); throw; }
    }

    public void Dispose()
    {
        // 同步释放绝不能等待 UI 同步上下文。
        // 窗体会在释放传输前等待 EmergencyRelease。
        heldPoint = null;
    }
}
