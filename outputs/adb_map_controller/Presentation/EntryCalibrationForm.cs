using System;
using System.Drawing;
using System.Windows.Forms;

namespace AdbMapController;

/// <summary>
/// 从当前巴萨坦地图截图标定入口：入口锚点决定点击位置，场景框决定匹配内容。
/// 两者分离后，场景框可以避开会随人物移动的蓝色标记。
/// </summary>
public sealed class EntryCalibrationForm : Form
{
    readonly PictureBox preview = new() { Dock = DockStyle.Fill, SizeMode = PictureBoxSizeMode.Zoom, BackColor = Color.Black };
    readonly Label hint = new() { Dock = DockStyle.Top, Height = 48, Padding = new(8, 7, 8, 4) };
    readonly RadioButton targetMode = new() { Text = "1. 标记入口", AutoSize = true, Checked = true };
    readonly RadioButton sceneMode = new() { Text = "2. 框选周边场景", AutoSize = true };
    readonly Bitmap source;
    ThemePalette theme = ThemePalette.Light;
    Point dragStart;
    bool dragging;

    public Point? SelectedPoint { get; private set; }
    public Rectangle? SelectedTemplateBounds { get; private set; }

    public EntryCalibrationForm(Bitmap screenshot, string mapName)
    {
        source = new Bitmap(screenshot);
        Text = $"标定 {mapName} 入口";
        Width = 1100; Height = 700; MinimumSize = new(800, 520);
        preview.Image = source;
        preview.MouseDown += PreviewMouseDown;
        preview.MouseMove += PreviewMouseMove;
        preview.MouseUp += PreviewMouseUp;
        preview.Paint += PreviewPaint;

        var modePanel = new FlowLayoutPanel
        {
            Dock = DockStyle.Top,
            Height = 34,
            Padding = new(8, 5, 8, 2),
            Tag = ThemeRole.SurfaceAlt
        };
        modePanel.Controls.AddRange([targetMode, sceneMode]);
        targetMode.CheckedChanged += (_, _) => UpdateHint();
        sceneMode.CheckedChanged += (_, _) => UpdateHint();

        var cancel = new Button { Text = "取消", AutoSize = true, DialogResult = DialogResult.Cancel };
        var save = new Button { Text = "保存场景模板", AutoSize = true, DialogResult = DialogResult.OK };
        save.Click += (_, _) =>
        {
            if (SelectedPoint is null || SelectedTemplateBounds is null)
            {
                MessageBox.Show(this, "请先标记入口中心，再框选一块稳定的周边地图场景。", "标定未完成",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                DialogResult = DialogResult.None;
            }
        };
        var buttons = new FlowLayoutPanel { Dock = DockStyle.Bottom, Height = 46, FlowDirection = FlowDirection.RightToLeft, Padding = new(8, 6, 8, 6), Tag = ThemeRole.Surface };
        buttons.Controls.Add(cancel); buttons.Controls.Add(save);
        Controls.Add(preview); Controls.Add(buttons); Controls.Add(modePanel); Controls.Add(hint);
        AcceptButton = save; CancelButton = cancel;
        UpdateHint();
        FormClosed += (_, _) => { preview.Image = null; source.Dispose(); };
    }

    public void ApplyTheme(ThemePalette palette)
    {
        if (IsDisposed || Disposing) return;
        theme = palette;
        ThemeManager.Apply(this, palette);
    }

    void UpdateHint()
    {
        hint.Text = targetMode.Checked
            ? "先在入口实际位置单击，保存点击锚点。随后选择“框选周边场景”。"
            : "拖拽框选入口附近不变的地形/建筑纹理；请避开青蓝色人物标记及红点。场景框不必包含入口图标。";
    }

    void PreviewMouseDown(object? sender, MouseEventArgs e)
    {
        if (!TryGetImagePoint(e.Location, out var point)) return;
        if (targetMode.Checked)
        {
            SelectedPoint = point;
            preview.Invalidate();
            UpdateHint();
            return;
        }
        if (e.Button != MouseButtons.Left) return;
        dragStart = point;
        SelectedTemplateBounds = new Rectangle(point, Size.Empty);
        dragging = true;
        preview.Capture = true;
        preview.Invalidate();
    }

    void PreviewMouseMove(object? sender, MouseEventArgs e)
    {
        if (!dragging || !TryGetImagePoint(e.Location, out var point)) return;
        SelectedTemplateBounds = NormalizeRectangle(dragStart, point);
        preview.Invalidate();
    }

    void PreviewMouseUp(object? sender, MouseEventArgs e)
    {
        if (!dragging) return;
        dragging = false;
        preview.Capture = false;
        if (TryGetImagePoint(e.Location, out var point))
        {
            var bounds = NormalizeRectangle(dragStart, point);
            if (bounds.Width >= 32 && bounds.Height >= 32) SelectedTemplateBounds = bounds;
            else SelectedTemplateBounds = null;
        }
        preview.Invalidate();
        UpdateHint();
    }

    void PreviewPaint(object? sender, PaintEventArgs e)
    {
        var imageRect = ImageRectangle(preview, source.Size);
        if (imageRect.IsEmpty) return;
        var scaleX = imageRect.Width / (float)source.Width;
        var scaleY = imageRect.Height / (float)source.Height;
        if (SelectedTemplateBounds is { } bounds)
        {
            var screenBounds = Rectangle.Round(new RectangleF(
                imageRect.Left + bounds.Left * scaleX,
                imageRect.Top + bounds.Top * scaleY,
                bounds.Width * scaleX,
                bounds.Height * scaleY));
            using var pen = new Pen(Color.Lime, 2);
            e.Graphics.DrawRectangle(pen, screenBounds);
        }
        if (SelectedPoint is { } point)
        {
            var x = imageRect.Left + point.X * scaleX;
            var y = imageRect.Top + point.Y * scaleY;
            using var pen = new Pen(Color.Red, 2);
            e.Graphics.DrawLine(pen, x - 10, y, x + 10, y);
            e.Graphics.DrawLine(pen, x, y - 10, x, y + 10);
        }
    }

    bool TryGetImagePoint(Point location, out Point point)
    {
        var imageRect = ImageRectangle(preview, source.Size);
        if (!imageRect.Contains(location))
        {
            point = default;
            return false;
        }
        var x = (int)Math.Round((location.X - imageRect.Left) * source.Width / (double)imageRect.Width);
        var y = (int)Math.Round((location.Y - imageRect.Top) * source.Height / (double)imageRect.Height);
        point = new Point(Math.Clamp(x, 0, source.Width - 1), Math.Clamp(y, 0, source.Height - 1));
        return true;
    }

    static Rectangle NormalizeRectangle(Point a, Point b)
        => Rectangle.FromLTRB(Math.Min(a.X, b.X), Math.Min(a.Y, b.Y), Math.Max(a.X, b.X) + 1, Math.Max(a.Y, b.Y) + 1);

    static Rectangle ImageRectangle(PictureBox box, Size imageSize)
    {
        if (box.ClientSize.Width < 1 || box.ClientSize.Height < 1) return Rectangle.Empty;
        var scale = Math.Min(box.ClientSize.Width / (double)imageSize.Width, box.ClientSize.Height / (double)imageSize.Height);
        var width = (int)Math.Round(imageSize.Width * scale);
        var height = (int)Math.Round(imageSize.Height * scale);
        return new Rectangle((box.ClientSize.Width - width) / 2, (box.ClientSize.Height - height) / 2, width, height);
    }

    protected override void OnHandleCreated(EventArgs e)
    {
        base.OnHandleCreated(e);
        ApplyTheme(theme);
    }
}
