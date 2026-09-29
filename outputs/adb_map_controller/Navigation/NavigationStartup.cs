using System;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

internal static class NavigationStartup
{
    // 规划只消费地图。输入必须等待两个分支都完成，
    // 包括任一分支失败或所属运行被取消的情况。
    public static async Task<bool> PrepareAsync(Func<Task<bool>> readMap,
        Func<Task<bool>> checkOverlays, Action plan, CancellationToken token)
    {
        async Task<bool> ReadAndPlan()
        {
            if (!await readMap()) return false;
            token.ThrowIfCancellationRequested();
            plan();
            return true;
        }

        async Task<bool> CheckOverlays() => await checkOverlays();

        var overlays = CheckOverlays();
        var planning = ReadAndPlan();
        await Task.WhenAll(planning, overlays);
        token.ThrowIfCancellationRequested();
        return planning.Result && overlays.Result;
    }
}
