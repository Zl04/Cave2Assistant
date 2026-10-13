using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;

namespace AdbMapController;

internal enum CaptionIcon { Pin, Restore, Mini, Minimize, Maximize, WindowRestore, Close }

internal sealed class CaptionButton(CaptionIcon icon) : Button
{
    public CaptionIcon Icon { get; set; } = icon;
    bool hovered;
    bool selected;
    public bool Selected
    {
        get => selected;
        set { if (selected == value) return; selected = value; Invalidate(); }
    }

    protected override void OnMouseEnter(EventArgs e) { hovered = true; base.OnMouseEnter(e); Invalidate(); }
    protected override void OnMouseLeave(EventArgs e) { hovered = false; base.OnMouseLeave(e); Invalidate(); }

    static readonly Dictionary<string, Bitmap> iconImages = new();

    static Bitmap GetIconImage(string name)
    {
        if (iconImages.TryGetValue(name, out var image)) return image;
        using var original = Image.FromFile(Path.Combine(AppContext.BaseDirectory, "assets", "caption-icons", name));
        image = new Bitmap(original);
        iconImages.Add(name, image);
        return image;
    }

    protected override void OnPaint(PaintEventArgs e)
    {
        e.Graphics.Clear(hovered ? Icon == CaptionIcon.Close ? Color.FromArgb(190, 48, 58) : Color.FromArgb(51, 51, 66) : BackColor);
        var scale = Math.Clamp((int)Math.Ceiling(DeviceDpi / 96f), 1, 3);
        var name = $"{Icon}{(Icon == CaptionIcon.Pin && selected ? "Selected" : "")}@{scale}x.png";
        var image = GetIconImage(name);
        var color = hovered ? Color.White : selected ? ForeColor : Color.FromArgb(159, 159, 177);
        using var attributes = new ImageAttributes();
        attributes.SetColorMatrix(new ColorMatrix
        {
            Matrix00 = color.R / 255f,
            Matrix11 = color.G / 255f,
            Matrix22 = color.B / 255f,
            Matrix33 = 1,
            Matrix44 = 1
        });
        var size = (int)Math.Round(14 * DeviceDpi / 96f);
        var bounds = new Rectangle((Width - size) / 2, (Height - size) / 2, size, size);
        e.Graphics.DrawImage(image, bounds, 0, 0, image.Width, image.Height, GraphicsUnit.Pixel, attributes);
        if (Focused && ShowFocusCues) ControlPaint.DrawFocusRectangle(e.Graphics, new Rectangle(4, 4, Width - 8, Height - 8));
    }
}
