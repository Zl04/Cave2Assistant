using System;
using System.Drawing;

namespace AdbMapController;

public static class GameScreenCoordinates
{
    const double GameWidth = 720;
    const double GameHeight = 1280;

    /// <summary>
    /// 宏脚本使用竖屏坐标，而 Android 游戏截图为横屏。
    /// 这是附带的巴萨坦地图截图中可见的 90 度旋转。
    /// </summary>
    public static Point ToDisplay(int gameX, int gameY, int displayWidth, int displayHeight)
    {
        if (displayWidth < 1 || displayHeight < 1) throw new ArgumentOutOfRangeException(nameof(displayWidth));
        var x = Math.Clamp((int)Math.Round(gameY / GameHeight * (displayWidth - 1)), 0, displayWidth - 1);
        var y = Math.Clamp((int)Math.Round((GameWidth - gameX) / GameWidth * (displayHeight - 1)), 0, displayHeight - 1);
        return new Point(x, y);
    }
}
