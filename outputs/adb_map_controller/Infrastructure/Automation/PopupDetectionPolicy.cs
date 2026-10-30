namespace AdbMapController;

/// <summary>
/// 选择单个弹窗识别结果的稳定性阈值。
/// 基于 OCR 的匹配已经包含语义信号；纯视觉匹配仍需要两帧，
/// 以避免因短暂的颜色图案而中断移动。
/// </summary>
public static class PopupDetectionPolicy
{
    public static int RequiredConsecutiveFrames(MovementPopupKind popup)
        => popup switch
        {
            MovementPopupKind.ServerError or
            MovementPopupKind.RiftGemSelection or
            MovementPopupKind.NextFloorDialog or
            MovementPopupKind.ReturnTownConfirm => 1,
            MovementPopupKind.AltarDialog or MovementPopupKind.EnchantingDialog or
            MovementPopupKind.AbyssMerchantDialog => 2,
            _ => 0
        };
}
