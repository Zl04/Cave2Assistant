namespace AdbMapController;

/// <summary>一次开始跑图，离开起始大厅后返回主城或公会才算完成。</summary>
public sealed class MapRunTask
{
    public bool HasEnteredMap { get; private set; }
    public bool Completed { get; private set; }

    public static bool IsReturnDestination(MapDump map) =>
        map.TownMapId is 10001 or 10002 ||
        (map.SceneType == 1 && map.Level == 9001) ||
        (map.SceneType == 7 && map.Level is 6001 or 6101);

    public bool Observe(MapDump map)
    {
        if (IsReturnDestination(map)) Completed |= HasEnteredMap;
        else if (map.SceneType >= 0 && map.Width > 0 && map.Height > 0) HasEnteredMap = true;
        return Completed;
    }
}
