using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public interface IPlayerStatusSource
{
    Task<PlayerStatus> ReadPlayer();
}

public interface IMovementInput
{
    Task TouchDown(Cell delta, CancellationToken cancellationToken = default);
    Task TouchUp();
    Task ChangeDirection(Cell delta, CancellationToken cancellationToken = default);
    Task PulseOneCell(Cell delta, int milliseconds, CancellationToken cancellationToken = default);
}

public interface IRouteExecutionObserver
{
    void SetState(string text);
    void WriteLog(string text);
    void MapChanged();
}

public sealed record MovementTuning(int ReleaseLeadMs, int PulseHoldMs, int StallTimeoutMs);

public sealed class RouteExecutionRuntime
{
    const long OscillationWindowMs = 5000;
    readonly Queue<Cell> recentPositionChanges = new(4);
    long? lastPositionChangeAt;
    public double MoveSpeed { get; set; } = 1000;
    public bool PulseFallback { get; set; }

    public bool ObservePosition(Cell position, long? observedAt = null)
    {
        var now = observedAt ?? Environment.TickCount64;
        if (lastPositionChangeAt is long last && now - last > OscillationWindowMs)
            recentPositionChanges.Clear();
        if (recentPositionChanges.Count > 0 && recentPositionChanges.Last() == position) return false;
        if (recentPositionChanges.Count == 4) recentPositionChanges.Dequeue();
        recentPositionChanges.Enqueue(position);
        lastPositionChangeAt = now;
        if (PulseFallback || recentPositionChanges.Count < 4) return false;
        var positions = recentPositionChanges.ToArray();
        if (positions[0] != positions[2] || positions[1] != positions[3]) return false;
        PulseFallback = true;
        return true;
    }

    public void ClearPulseFallback()
    {
        PulseFallback = false;
        recentPositionChanges.Clear();
        lastPositionChangeAt = null;
    }

    public void Reset()
    {
        MoveSpeed = 1000;
        ClearPulseFallback();
    }
}

/// <summary>
/// Everything that varies for one route execution. The executor itself is
/// reusable and depends only on the device ports supplied at construction.
/// </summary>
public sealed class RouteExecutionContext(
    MapDump map,
    RouteSession session,
    HashSet<Cell> blocked,
    MovementTuning tuning,
    RouteExecutionRuntime runtime,
    Func<TargetKey, bool> targetExists,
    Func<Cell, Cell> mapInput,
    IRouteExecutionObserver observer)
{
    public MapDump Map { get; } = map ?? throw new ArgumentNullException(nameof(map));
    public RouteSession Session { get; } = session ?? throw new ArgumentNullException(nameof(session));
    public HashSet<Cell> Blocked { get; } = blocked ?? throw new ArgumentNullException(nameof(blocked));
    public MovementTuning Tuning { get; } = tuning ?? throw new ArgumentNullException(nameof(tuning));
    public RouteExecutionRuntime Runtime { get; } = runtime ?? throw new ArgumentNullException(nameof(runtime));
    public Func<TargetKey, bool> TargetExists { get; } = targetExists ?? throw new ArgumentNullException(nameof(targetExists));
    public Func<Cell, Cell> MapInput { get; } = mapInput ?? throw new ArgumentNullException(nameof(mapInput));
    public IRouteExecutionObserver Observer { get; } = observer ?? throw new ArgumentNullException(nameof(observer));
}
