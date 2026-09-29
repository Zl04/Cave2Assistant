using System;

namespace AdbMapController;

public enum MovementPopupKind
{
    None,
    ServerError,
    RiftGemSelection,
    NextFloorDialog,
    LootConfirm
}

public enum NextFloorDialogKind
{
    None,
    GreedySelection,
    WarningConfirm,
    PlainConfirm
}

public enum MotionInterruptReason
{
    None,
    Popup
}

public enum RouteExecutionStatus
{
    Completed,
    Replan,
    InterruptedByPopup
}

public readonly record struct RouteExecutionResult(RouteExecutionStatus Status)
{
    public bool RequiresReplan => Status == RouteExecutionStatus.Replan;
    public bool InterruptedByPopup => Status == RouteExecutionStatus.InterruptedByPopup;
}

/// <summary>
/// 移动中断的唯一获胜者。弹窗看门狗写入该状态，移动循环只读取它。
/// 将此状态与所有者的取消令牌分开，可以让弹窗暂停当前路线，
/// 而不取消整个地下城运行。
/// </summary>
public sealed class MotionInterruptState
{
    readonly object gate = new();
    MovementPopupKind popupKind;
    NextFloorDialogKind nextFloorDialogKind;
    bool greedySelectionReturnOnly;

    public MovementPopupKind PopupKind
    {
        get { lock (gate) return popupKind; }
    }

    public NextFloorDialogKind NextFloorDialogKind
    {
        get { lock (gate) return nextFloorDialogKind; }
    }

    public bool GreedySelectionReturnOnly
    {
        get { lock (gate) return greedySelectionReturnOnly; }
    }

    public MotionInterruptReason Reason
    {
        get { lock (gate) return popupKind == MovementPopupKind.None ? MotionInterruptReason.None : MotionInterruptReason.Popup; }
    }

    public bool Request(MovementPopupKind kind)
        => Request(kind, NextFloorDialogKind.None, false);

    public bool Request(MovementPopupKind kind, NextFloorDialogKind nextFloorDialog)
        => Request(kind, nextFloorDialog, false);

    public bool Request(
        MovementPopupKind kind,
        NextFloorDialogKind nextFloorDialog,
        bool greedySelectionReturnOnly)
    {
        if (kind == MovementPopupKind.None) return false;
        lock (gate)
        {
            if (popupKind != MovementPopupKind.None) return false;
            nextFloorDialogKind = nextFloorDialog;
            this.greedySelectionReturnOnly = greedySelectionReturnOnly;
            popupKind = kind;
            return true;
        }
    }

    public void Clear()
    {
        lock (gate)
        {
            popupKind = MovementPopupKind.None;
            nextFloorDialogKind = NextFloorDialogKind.None;
            greedySelectionReturnOnly = false;
        }
    }
}
