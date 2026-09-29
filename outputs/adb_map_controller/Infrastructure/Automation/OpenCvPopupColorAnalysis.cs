using System.Drawing.Imaging;
using OpenCvSharp;

namespace AdbMapController;

public enum PopupColorKind
{
    LightNeutralPanel,
    GreenButton,
    RedWarning,
    GoldButton
}

/// <summary>
/// OpenCV-backed color-region analysis used by popup recognition. This is not
/// feature-point matching: it converts the frame to HSV, builds a binary mask,
/// and calculates the matching-pixel ratio over the requested ROI.
/// </summary>
public static class OpenCvPopupColorAnalysis
{
    public static double Ratio(
        System.Drawing.Bitmap source,
        (double X0, double X1, double Y0, double Y1) region,
        PopupColorKind kind)
    {
        using var image = ToMat(source);
        if (image.Empty()) return 0;
        var x0 = Math.Clamp((int)Math.Round(image.Width * region.X0), 0, image.Width - 1);
        var y0 = Math.Clamp((int)Math.Round(image.Height * region.Y0), 0, image.Height - 1);
        var x1 = Math.Clamp((int)Math.Round(image.Width * region.X1), x0 + 1, image.Width);
        var y1 = Math.Clamp((int)Math.Round(image.Height * region.Y1), y0 + 1, image.Height);
        using var hsv = image.CvtColor(ColorConversionCodes.BGR2HSV);
        using var roi = new Mat(hsv, new Rect(x0, y0, x1 - x0, y1 - y0));
        using var mask = BuildMask(roi, kind);
        return Cv2.CountNonZero(mask) / (double)(mask.Width * mask.Height);
    }

    private static Mat ToMat(System.Drawing.Bitmap bitmap)
    {
        using var stream = new MemoryStream();
        bitmap.Save(stream, ImageFormat.Png);
        return Cv2.ImDecode(stream.ToArray(), ImreadModes.Color);
    }

    static Mat BuildMask(Mat hsv, PopupColorKind kind)
    {
        return kind switch
        {
            PopupColorKind.LightNeutralPanel =>
                hsv.InRange(new Scalar(0, 0, 105), new Scalar(180, 115, 255)),
            PopupColorKind.GreenButton =>
                hsv.InRange(new Scalar(35, 35, 80), new Scalar(100, 255, 255)),
            PopupColorKind.GoldButton =>
                hsv.InRange(new Scalar(0, 90, 140), new Scalar(35, 255, 255)),
            PopupColorKind.RedWarning => RedMask(hsv),
            _ => throw new ArgumentOutOfRangeException(nameof(kind), kind, null)
        };
    }

    static Mat RedMask(Mat hsv)
    {
        using var lower = hsv.InRange(new Scalar(0, 80, 105), new Scalar(15, 255, 255));
        using var upper = hsv.InRange(new Scalar(165, 80, 105), new Scalar(180, 255, 255));
        var result = new Mat();
        Cv2.BitwiseOr(lower, upper, result);
        return result;
    }
}
