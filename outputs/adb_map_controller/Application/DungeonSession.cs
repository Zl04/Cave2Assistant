namespace AdbMapController;

/// <summary>
/// Owns all mutable state whose lifetime is one connected device/dungeon run.
/// UI controls and process-lifetime dependencies deliberately stay outside.
/// </summary>
public sealed class DungeonSession
{
    private const int SurveyCoverageRadius = 4;
    public MapDump? Map { get; set; }
    public MotionInterruptState MotionInterrupt { get; } = new();
    public RouteSession Route { get; } = new();
    public RouteExecutionRuntime RouteExecution { get; } = new();
    public HashSet<Cell> Blocked { get; } = [];
    public Cell? LastBlockedAttempt { get; set; }
    public int UnchangedCount { get; set; }
    public HashSet<TargetKey> ConfirmedCompletedTargets { get; } = [];
    public HashSet<Cell> InteractedChambers { get; } = [];
    public Dictionary<Cell, (int LastCount, int Failures)> MechanismAttempts { get; } = [];
    public Dictionary<Cell, (int PreviousCount, long PassedAt)> PendingMechanismPasses { get; } = [];
    public HashSet<Cell> StalledMechanisms { get; } = [];
    public long LockedChamberWaitSince { get; set; }
    public HashSet<Cell> ExpectedTaskRoadChanges { get; } = [];
    public FloorStateMachine FloorState { get; } = new();
    public PortalJumpGraph PortalJumps { get; } = new();
    public PortalUnlockGraph PortalUnlocks { get; } = new();
    public HashSet<Cell> AttemptedRoomPortals { get; } = [];
    public HashSet<Cell> RoomSurveyCoverage { get; } = [];
    public int RoomSurveyLevel { get; set; } = -1;
    public int ObservedLevel { get; set; } = -1;
    public int PortalConfirmCount { get; set; }
    public int RouteRecoveryUsed { get; set; }
    public long FloorChangedAt { get; set; }
    public Cell? LastAcceptedPlayerCell { get; set; }
    public long LastAcceptedPlayerAt { get; set; }
    public TargetKey? PortalCandidate { get; set; }
    public long RoomPortalInteractionAt { get; set; }
    public TargetKey? PendingRoomPortal { get; set; }
    public Cell? RoomPortalOrigin { get; set; }
    public long RoomPortalResumeAt { get; set; }
    public Cell? RoomPortalSettlingCell { get; set; }
    public bool ShortcutDeferredByTargets { get; set; }
    public bool TargetFloorStopped { get; set; }
    public int FloorMiningCompletedLevel { get; set; } = -1;
    public int FloorMiningSkippedLevel { get; set; } = -1;
    public int AltarAttemptedLevel { get; set; } = -1;

    public void RecordSurveyCoverage(MapDump map, IEnumerable<Cell> traversed)
    {
        if (!AbyssRoutePlanner.IsAbyss(map)) return;
        if (RoomSurveyLevel != map.Level)
        {
            RoomSurveyCoverage.Clear();
            RoomSurveyLevel = map.Level;
        }
        var tiles = map.ByCell;
        foreach (var position in traversed)
        {
            if (!tiles.TryGetValue(position, out var start) || !start.Walkable) continue;
            var queue = new Queue<(Cell Cell, int Distance)>();
            var seen = new HashSet<Cell> { position };
            queue.Enqueue((position, 0));
            while (queue.TryDequeue(out var item))
            {
                RoomSurveyCoverage.Add(item.Cell);
                if (item.Distance == SurveyCoverageRadius) continue;
                foreach (var next in new[] {
                    new Cell(item.Cell.X - 1, item.Cell.Y), new Cell(item.Cell.X + 1, item.Cell.Y),
                    new Cell(item.Cell.X, item.Cell.Y - 1), new Cell(item.Cell.X, item.Cell.Y + 1) })
                    if (seen.Add(next) && tiles.TryGetValue(next, out var tile) && tile.Walkable)
                        queue.Enqueue((next, item.Distance + 1));
            }
        }
    }

    public void Reset()
    {
        Map = null;
        Route.Clear();
        RouteExecution.Reset();
        Blocked.Clear();
        LastBlockedAttempt = null;
        UnchangedCount = 0;
        ConfirmedCompletedTargets.Clear();
        InteractedChambers.Clear();
        MechanismAttempts.Clear();
        PendingMechanismPasses.Clear();
        StalledMechanisms.Clear();
        LockedChamberWaitSince = 0;
        ExpectedTaskRoadChanges.Clear();
        FloorState.Reset();
        PortalJumps.Clear();
        PortalUnlocks.Clear();
        AttemptedRoomPortals.Clear();
        RoomSurveyCoverage.Clear();
        RoomSurveyLevel = -1;
        ObservedLevel = -1;
        PortalConfirmCount = 0;
        RouteRecoveryUsed = 0;
        FloorChangedAt = 0;
        LastAcceptedPlayerCell = null;
        LastAcceptedPlayerAt = 0;
        PortalCandidate = null;
        RoomPortalInteractionAt = 0;
        PendingRoomPortal = null;
        RoomPortalOrigin = null;
        RoomPortalResumeAt = 0;
        RoomPortalSettlingCell = null;
        ShortcutDeferredByTargets = false;
        TargetFloorStopped = false;
        FloorMiningCompletedLevel = -1;
        FloorMiningSkippedLevel = -1;
        AltarAttemptedLevel = -1;
        MotionInterrupt.Clear();
    }

    public void StopAutomation()
    {
        FloorState.Transition(FloorPhase.Explore);
        PortalCandidate = null;
        PortalConfirmCount = 0;
        Route.Clear();
        Blocked.Clear();
        LastBlockedAttempt = null;
        UnchangedCount = 0;
        ConfirmedCompletedTargets.Clear();
        ExpectedTaskRoadChanges.Clear();
        RouteExecution.ClearPulseFallback();
        ShortcutDeferredByTargets = false;
        TargetFloorStopped = false;
        FloorMiningCompletedLevel = -1;
        FloorMiningSkippedLevel = -1;
        AltarAttemptedLevel = -1;
        AttemptedRoomPortals.Clear();
        RoomSurveyCoverage.Clear();
        RoomSurveyLevel = -1;
        PendingRoomPortal = null;
        RoomPortalOrigin = null;
        RoomPortalInteractionAt = 0;
        RoomPortalResumeAt = 0;
        RoomPortalSettlingCell = null;
        PortalJumps.Clear();
        PortalUnlocks.Clear();
        MotionInterrupt.Clear();
    }
}
