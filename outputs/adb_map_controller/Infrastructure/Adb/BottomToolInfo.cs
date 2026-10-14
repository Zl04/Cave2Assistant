namespace AdbMapController;

public enum BottomToolKind
{
    Mining,
    FogReveal,
    EscapeScroll,
}

/// <summary>Position uses screen-relative coordinates; a null quantity means OCR did not read a number.</summary>
public sealed record BottomToolInfo(BottomToolKind Kind, double X, double Y, int? Quantity);
