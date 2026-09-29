using System.Collections.Generic;

namespace AdbMapController;

/// <summary>
/// 将机关完成状态限定在当前观察到的楼层内。
/// 重新读取或替换同一楼层的地图快照时，不能清除该状态。
/// </summary>
public sealed class FloorMechanismState
{
    readonly HashSet<Cell> visited = [];

    public int Level { get; private set; } = -1;
    public IReadOnlySet<Cell> Visited => visited;

    public bool ObserveLevel(int level)
    {
        if (Level < 0)
        {
            Level = level;
            return false;
        }
        if (Level == level) return false;

        Level = level;
        visited.Clear();
        return true;
    }

    public bool Add(Cell cell) => visited.Add(cell);
    public bool Contains(Cell cell) => visited.Contains(cell);

    public void Reset()
    {
        Level = -1;
        visited.Clear();
    }
}
