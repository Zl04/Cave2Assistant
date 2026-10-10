using System.Collections.Generic;

namespace AdbMapController;

public enum FloorPhase
{
    Explore, CollectWarning, FightGuard, ConfirmPortal, GoToPortal,
    InteractPortal, SelectBonus, VerifyTransition, WaitingFloorLoad
}

/// <summary>
/// 管理当前楼层生命周期状态。无效转移会被记录但仍会应用，
/// 以保持游戏特定流程的行为兼容性。
/// </summary>
public sealed class FloorStateMachine
{
    public FloorPhase Current { get; private set; } = FloorPhase.Explore;
    readonly System.Collections.Concurrent.ConcurrentQueue<string> invalidTransitions = new();
    public IReadOnlyCollection<string> InvalidTransitions => invalidTransitions.ToArray();
    public bool Transition(FloorPhase phase)
    {
        if (phase == Current) return true;
        if (!CanTransition(Current, phase))
        {
            invalidTransitions.Enqueue($"{Current}->{phase}");
            while (invalidTransitions.Count > 128) invalidTransitions.TryDequeue(out _);
        }
        Current = phase;
        return true;
    }
    public void Set(FloorPhase phase) => Current = phase;
    public void Reset() { Current = FloorPhase.Explore; invalidTransitions.Clear(); }
    static bool CanTransition(FloorPhase from, FloorPhase to) => from switch
    {
        FloorPhase.Explore => to is FloorPhase.CollectWarning or FloorPhase.ConfirmPortal or FloorPhase.GoToPortal or FloorPhase.WaitingFloorLoad,
        FloorPhase.CollectWarning => to is FloorPhase.Explore or FloorPhase.FightGuard or FloorPhase.WaitingFloorLoad,
        FloorPhase.FightGuard => to is FloorPhase.Explore or FloorPhase.CollectWarning or FloorPhase.WaitingFloorLoad,
        FloorPhase.ConfirmPortal => to is FloorPhase.GoToPortal or FloorPhase.Explore or FloorPhase.WaitingFloorLoad,
        FloorPhase.GoToPortal => to is FloorPhase.InteractPortal or FloorPhase.Explore or FloorPhase.WaitingFloorLoad,
        FloorPhase.InteractPortal => to is FloorPhase.SelectBonus or FloorPhase.VerifyTransition or FloorPhase.GoToPortal or FloorPhase.WaitingFloorLoad,
        FloorPhase.SelectBonus => to is FloorPhase.VerifyTransition or FloorPhase.GoToPortal or FloorPhase.WaitingFloorLoad,
        FloorPhase.VerifyTransition => to is FloorPhase.GoToPortal or FloorPhase.WaitingFloorLoad or FloorPhase.Explore,
        FloorPhase.WaitingFloorLoad => to is FloorPhase.Explore,
        _ => false
    };
}
