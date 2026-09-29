using System;
using System.Linq;
using System.Text.RegularExpressions;

namespace AdbMapController;

/// <summary>
/// 识别三卡秘境宝石选择对话框的标题。
/// 与 ADB/OCR 解耦，以便对匹配规则进行回归测试。
/// </summary>
public static class GemTitleMatcher
{
    static readonly string[] KnownTitles =
    [
        "属性宝石",       // InfernoSelectView / Trial Land
        "炼狱宝石",   // CaveStateBagView，当前语言表
        "秘境宝石",   // VoidRiftSelectView
        "试炼宝石",   // VikingSelectView（共用本地化文本）
    ];

    public static bool IsSelectionTitle(string text)
    {
        var compact = Regex.Replace(text ?? "", @"[\s\p{P}\p{S}]", "");
        // 游戏灰色标题字体下，OCR 可能将“宝”误识别为“玉”
        // （例如 属性宝石 -> 属性玉石），因此规范化这个确切后缀。
        // 只规范化完整的后缀对，比对任意 OCR 文本进行模糊匹配更安全。
        compact = compact.Replace("玉石", "宝石", StringComparison.Ordinal);
        // PaddleOCR 可能在真实标题周围返回多余的拉丁字符，
        // 因此将源码确认的标题作为子字符串匹配。
        if (KnownTitles.Any(compact.Contains)) return true;

        // 兼容未来仍遵循“<mode>宝石”约定的新模式。
        // 不要接受每个“宝石”出现位置：宝石仓库/宝石合成等普通标题
        // 不能让无关面板下方的移动暂停。
        var marker = compact.LastIndexOf("宝石", StringComparison.Ordinal);
        if (marker < 2) return false;
        var prefix = compact[..marker];
        if (prefix.Length > 16 || new[] { "普通", "装备", "宠物", "仓库", "合成", "镶嵌", "转换", "商店" }.Any(prefix.Contains)) return false;
        var suffix = compact[(marker + 2)..];
        // OCR 可能追加少量拉丁字符（例如“eo”），但后续出现中文词时，
        // 说明这不是以“宝石”结尾的标题。
        if (suffix.Length > 4 || suffix.Any(c => c >= '\u3400' && c <= '\u9fff')) return false;
        return true;
    }
}
