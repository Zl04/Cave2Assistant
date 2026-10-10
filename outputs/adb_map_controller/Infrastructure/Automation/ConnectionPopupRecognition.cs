using System.Drawing;
using System.Text.RegularExpressions;

namespace AdbMapController;

/// <summary>Two observed disconnect variants; visual layout and semantics must agree.</summary>
public static class ConnectionPopupRecognition
{
    public static bool IsCandidate(Bitmap frame)
    {
        if (OpenCvPopupColorAnalysis.Ratio(frame, (.30, .70, .28, .72), PopupColorKind.LightNeutralPanel) < .45)
            return false;
        var button = (.43, .57, .59, .70);
        return OpenCvPopupColorAnalysis.Ratio(frame, button, PopupColorKind.GreenButton) >= .20 ||
            OpenCvPopupColorAnalysis.Ratio(frame, button, PopupColorKind.GoldButton) >= .20;
    }

    public static bool IsDisconnectText(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return false;
        var normalized = Regex.Replace(text, @"[^\p{L}\p{N}]", "");
        return normalized.Contains("服务器连接异常", StringComparison.Ordinal) ||
            (normalized.Contains("连接异常", StringComparison.Ordinal) && normalized.Contains("重新进入游戏", StringComparison.Ordinal)) ||
            (normalized.Contains("闲置时间过长", StringComparison.Ordinal) && normalized.Contains("服务器断开连接", StringComparison.Ordinal));
    }
}
