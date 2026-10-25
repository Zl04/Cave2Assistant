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
    string? escapeReturnDiagnostic;
    long escapeReturnDiagnosticAt;

    void LogEscapeReturnDiagnostic(string message)
    {
        var now = Environment.TickCount64;
        if (message == escapeReturnDiagnostic && now - escapeReturnDiagnosticAt < 15000) return;
        escapeReturnDiagnostic = message;
        escapeReturnDiagnosticAt = now;
        Log($"卷轴回城诊断：{message}");
    }

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
                LogEscapeReturnDiagnostic($"等待确认框，OCR正文={ (string.IsNullOrEmpty(text) ? "<空>" : text) }");
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
        var target = (int)escapeReturnFloor.Value;
        var context = map is null
            ? $"设置层={target}，地图=<空>"
            : $"设置层={target}，当前层={map.Level}，地图={map.MapName}，SceneType={map.SceneType}，CaveMode={map.CaveMode}，最高层={CardFloorPolicy.MaximumFloor(map)?.ToString() ?? "未知"}，战斗={map.InBattle}，阶段={floorPhase}，回城前攻击Boss={escapeReturnAttackBoss.Checked}";
        string? blocked = null;
        if (map is null) blocked = "地图未就绪";
        else if (!IsEscapeReturnFloor(map))
            blocked = target <= 0 ? "功能关闭" :
                CardFloorPolicy.MaximumFloor(map) is not { } maximum ? "玩法最高层未知" :
                target >= maximum ? "设置层必须低于最高层" : map.Level < target ? "尚未到达设置层" : "当前层已到达或超过最高层";
        else if (map.InBattle) blocked = "正在战斗";
        else if (floorPhase is FloorPhase.WaitingFloorLoad or FloorPhase.WaitingReturnTown or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)
            blocked = "等待换层、奖励或回城流程结束";
        else if (map.Level == target)
        {
            var remaining = SelectedTargets(map, Options(), includeLockedBoss: true);
            if (remaining.Count > 0)
                blocked = $"设置层所选目标未完成，剩余={remaining.Count}";
        }
        if (blocked is not null || map is null)
        {
            LogEscapeReturnDiagnostic($"{blocked}；{context}");
            return false;
        }

        var now = Environment.TickCount64;
        if (now - escapeScrollLastProbeAt < 1200)
        {
            await Task.Delay(120, token);
            return true;
        }
        escapeScrollLastProbeAt = now;

        var tool = await adb.FindBottomToolAsync(BottomToolKind.EscapeScroll, token);
        if (tool is null)
        {
            LogEscapeReturnDiagnostic($"未识别到底栏逃脱卷轴；{context}");
            State($"已到 {map.Level} 层，等待获得逃脱卷轴");
            await touch.EmergencyRelease();
            await Task.Delay(120, token);
            return true;
        }
        if (tool.Quantity is not > 0)
        {
            LogEscapeReturnDiagnostic($"已识别卷轴但数量不满足，数量={tool.Quantity?.ToString() ?? "未识别"}，坐标=({tool.X:F4},{tool.Y:F4})；{context}");
            State(tool.Quantity is 0
                ? $"已到 {map.Level} 层，卷轴数量为零，等待卷轴，不再下楼"
                : $"已到 {map.Level} 层，卷轴数量未识别，等待识别成功，不再下楼");
            await touch.EmergencyRelease();
            await Task.Delay(120, token);
            return true;
        }

        LogEscapeReturnDiagnostic($"条件满足，准备点击卷轴，数量={tool.Quantity}，坐标=({tool.X:F4},{tool.Y:F4})；{context}");
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
