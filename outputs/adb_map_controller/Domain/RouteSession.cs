using System.Collections.Generic;

namespace AdbMapController;

/// <summary>
/// 管理一条已规划路线的可变状态。
/// MainForm 中的兼容性属性使现有执行调用点保持不变。
/// </summary>
public sealed class RouteSession
{
    public List<Cell> Route { get; set; } = [];
    public List<PlannedInteraction> Interactions { get; set; } = [];
    public HashSet<TargetKey> TargetUniverse { get; set; } = [];
    public Dictionary<Cell, bool> Walkability { get; set; } = [];
    public int? OptionsSignature { get; set; }
    public string? PlannedNavigationHash { get; set; }
    public HashSet<Cell> PlannedRoadMonsters { get; set; } = [];
    public MapSnapshot? Snapshot { get; set; }

    public void Clear()
    {
        Route = [];
        Interactions = [];
        TargetUniverse.Clear();
        Walkability = [];
        OptionsSignature = null;
        PlannedNavigationHash = null;
        PlannedRoadMonsters.Clear();
        Snapshot = null;
    }

    public void SetPlan(RoutePlan plan)
    {
        Route = plan.Route;
        Interactions = plan.Interactions;
        TargetUniverse = plan.TargetUniverse;
    }
}
