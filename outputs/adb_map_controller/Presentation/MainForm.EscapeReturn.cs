using System;
using System.Drawing;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed partial class MainForm
{
    bool escapeScrollPending;
    long escapeScrollUsedAt;
    long escapeScrollLastProbeAt;

    async Task<bool> TryReturnWithEscapeScroll(CancellationToken token)
    {
        if (escapeScrollPending)
        {
            using var dialogFrame = await adb.CaptureScreenForAutomationAsync(token);
            var body = CropRatio(dialogFrame, .345, .347, .315, .175);
            using (body)
            {
                var text = OcrTextLocator.Compact(string.Concat((await adb.ReadOcrWordsAsync(body, token))
                    .OrderBy(word => word.Top).ThenBy(word => word.Left).Select(word => word.Text)));
                if (text.Contains("是否使用", StringComparison.Ordinal) &&
                    text.Contains("逃脱卷轴", StringComparison.Ordinal) &&
                    text.Contains("返回城镇", StringComparison.Ordinal))
                {
                    await adb.TapScreen(.591, .639);
                    escapeScrollPending = false;
                    dungeon.FloorState.Set(FloorPhase.WaitingReturnTown);
                    dungeon.Route.Clear();
                    mapPanel.Route = route;
                    mapPanel.Invalidate();
                    Log($"已确认‘{text}’，点击绿色按钮，等待返回城镇");
                    State("已使用逃脱卷轴，等待回城");
                    return true;
                }
            }
            if (Environment.TickCount64 - escapeScrollUsedAt > 8000)
                throw new InvalidOperationException("逃脱卷轴使用后未识别到回城确认文字，已停止以避免误触");
            await Task.Delay(180, token);
            return true;
        }

        var map = dungeon.Map;
        if (map is null || !IsEscapeReturnFloor(map) || map.InBattle ||
            floorPhase is FloorPhase.WaitingFloorLoad or FloorPhase.WaitingReturnTown or FloorPhase.SelectBonus or FloorPhase.VerifyTransition ||
            (map.Level == (int)escapeReturnFloor.Value &&
             SelectedTargets(map, Options(), includeLockedBoss: true).Count > 0))
            return false;

        var now = Environment.TickCount64;
        if (now - escapeScrollLastProbeAt < 1200) return false;
        escapeScrollLastProbeAt = now;

        var tool = await adb.FindBottomToolAsync(BottomToolKind.EscapeScroll, token);
        if (tool is null)
        {
            State($"已到 {map.Level} 层，等待获得逃脱卷轴");
            return false;
        }
        if (tool.Quantity is not > 0)
        {
            State($"已到 {map.Level} 层，卷轴数量未确认，继续跑图");
            return false;
        }

        await touch.EmergencyRelease();
        await adb.TapScreen(tool.X, tool.Y);
        escapeScrollPending = true;
        escapeScrollUsedAt = Environment.TickCount64;
        Log($"第 {map.Level} 层发现逃脱卷轴，数量 {tool.Quantity}，已点击并等待文字确认");
        await Task.Delay(250, token);
        return true;
    }

    static Bitmap CropRatio(Bitmap frame, double x, double y, double width, double height)
    {
        var bounds = Rectangle.Intersect(new Rectangle(
            (int)Math.Round(frame.Width * x), (int)Math.Round(frame.Height * y),
            (int)Math.Round(frame.Width * width), (int)Math.Round(frame.Height * height)),
            new Rectangle(Point.Empty, frame.Size));
        return frame.Clone(bounds, frame.PixelFormat);
    }
}
