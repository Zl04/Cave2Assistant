using System.Drawing;

namespace AdbMapController;

/// <summary>各地图的节点选择范围，坐标以 1004×565 为基准。</summary>
public static class MapSelectionRegion
{
    public static bool HasCustomBounds(int? mapId) => mapId is 0 or 1 or 4 or 5 or 6;

    // 按用户分别标注的地图红框缩放到 1004×565。
    public static Rectangle DesignBounds(int mapId) => mapId switch
    {
        DungeonEntryCatalog.TimeGateHeroMapId => Rectangle.FromLTRB(321, 37, 801, 439),
        DungeonEntryCatalog.TimeGateMapId or 1 => Rectangle.FromLTRB(321, 40, 882, 445),
        4 => Rectangle.FromLTRB(421, 100, 843, 411), // 虚空秘境
        5 => Rectangle.FromLTRB(357, 104, 817, 392), // 原初试炼
        _ => Rectangle.FromLTRB(350, 133, 853, 376)
    };
    public static Rectangle ForFrame(int mapId, int width, int height)
    {
        var bounds = DesignBounds(mapId);
        var left = Math.Clamp((int)(bounds.Left * width / 1004.0), 0, width - 1);
        var top = Math.Clamp((int)(bounds.Top * height / 565.0), 0, height - 1);
        var right = Math.Clamp((int)(bounds.Right * width / 1004.0), left + 1, width);
        var bottom = Math.Clamp((int)(bounds.Bottom * height / 565.0), top + 1, height);
        return Rectangle.FromLTRB(left, top, right, bottom);
    }
}
