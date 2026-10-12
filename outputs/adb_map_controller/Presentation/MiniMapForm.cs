using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;

namespace AdbMapController;

/// <summary>
/// 控制器可分离的 minimap 窗口。它读取与 MainForm 相同的实时地图和路线对象，
/// 因此打开该视图不会创建第二份地图状态或第二个规划器。
/// </summary>
public sealed class MiniMapForm : Form
{
    readonly Func<MapDump?> mapProvider;
    readonly Func<IReadOnlyList<Cell>> routeProvider;
    readonly Func<bool> alwaysOnTopProvider;
    readonly Action<bool> alwaysOnTopChanged;
    readonly Action returnToController;
    readonly MapPanel mapPanel = new() { Dock = DockStyle.Fill, CompactMode = true };
    readonly System.Windows.Forms.Timer refreshTimer = new() { Interval = 200 };
    readonly Panel captionBar = new() { Dock = DockStyle.Top, Height = 30, BackColor = Color.FromArgb(32, 32, 43) };
    readonly CaptionButton pinButton = new(CaptionIcon.Pin);
    ThemePalette theme = ThemePalette.Light;
    bool closingFromOwner;

    public MiniMapForm(
        Func<MapDump?> mapProvider,
        Func<IReadOnlyList<Cell>> routeProvider,
        Func<bool> alwaysOnTopProvider,
        Action<bool> alwaysOnTopChanged,
        Action returnToController)
    {
        this.mapProvider = mapProvider;
        this.routeProvider = routeProvider;
        this.alwaysOnTopProvider = alwaysOnTopProvider;
        this.alwaysOnTopChanged = alwaysOnTopChanged;
        this.returnToController = returnToController;

        Text = "洞窟地图 · 小窗口";
        StartPosition = FormStartPosition.Manual;
        FormBorderStyle = FormBorderStyle.None;
        ShowInTaskbar = true;
        MinimizeBox = true;
        MaximizeBox = false;
        MinimumSize = new Size(150, 100);
        ClientSize = new Size(150, 100);
        KeyPreview = true;

        mapPanel.ContextMenuStrip = BuildContextMenu();
        Controls.Add(mapPanel);
        BuildCaptionBar();
        Controls.Add(captionBar);
        refreshTimer.Tick += (_, _) => SyncNow();
        KeyDown += (_, e) =>
        {
            if (e.KeyCode != Keys.Escape) return;
            returnToController();
            e.Handled = true;
            e.SuppressKeyPress = true;
        };
        FormClosing += OnFormClosing;
    }

    public void ShowMini()
    {
        SyncNow();
        TopMost = alwaysOnTopProvider();
        if (!Visible) Show();
        refreshTimer.Start();
        BringToFront();
        Activate();
    }

    public void ApplyTheme(ThemePalette palette)
    {
        if (IsDisposed || Disposing) return;
        theme = palette;
        ThemeManager.Apply(this, palette);
        mapPanel.ApplyTheme(palette);
        if (mapPanel.ContextMenuStrip is { } menu) ThemeManager.Apply(menu, palette);
        captionBar.BackColor = Color.FromArgb(32, 32, 43);
        foreach (Control button in captionBar.Controls)
            button.BackColor = captionBar.BackColor;
    }

    public void CloseFromOwner()
    {
        closingFromOwner = true;
        refreshTimer.Stop();
        Close();
    }

    public void SyncNow()
    {
        if (IsDisposed || Disposing) return;
        mapPanel.Map = mapProvider();
        mapPanel.Route = routeProvider();
        pinButton.Selected = alwaysOnTopProvider();
        TopMost = pinButton.Selected;
        // CompactMode 有意省略控制器状态、预警和坐标覆盖层：窗口只包含标题和 minimap。
        mapPanel.StatusText = "";
        mapPanel.InfoText = "";
        mapPanel.Invalidate();
    }

    ContextMenuStrip BuildContextMenu()
    {
        var menu = new ContextMenuStrip();
        var pin = new ToolStripMenuItem("窗口置顶") { CheckOnClick = true };
        var returnItem = new ToolStripMenuItem("返回控制器");

        menu.Opening += (_, _) => pin.Checked = alwaysOnTopProvider();
        pin.CheckedChanged += (_, _) =>
        {
            if (pin.Checked != alwaysOnTopProvider()) alwaysOnTopChanged(pin.Checked);
        };
        returnItem.Click += (_, _) => returnToController();

        menu.Items.Add(pin);
        menu.Items.Add(new ToolStripSeparator());
        menu.Items.Add(returnItem);
        return menu;
    }

    void BuildCaptionBar()
    {
        captionBar.MouseDown += (_, e) =>
        {
            if (e.Button != MouseButtons.Left) return;
            ReleaseCapture();
            SendMessage(Handle, 0x00A1, (IntPtr)2, IntPtr.Zero);
        };
        var restore = new CaptionButton(CaptionIcon.Restore);
        var minimize = new CaptionButton(CaptionIcon.Minimize);
        var close = new CaptionButton(CaptionIcon.Close);
        pinButton.AccessibleName = "窗口置顶";
        restore.AccessibleName = "返回控制器";
        minimize.AccessibleName = "最小化";
        close.AccessibleName = "关闭小窗口";
        pinButton.Click += (_, _) =>
        {
            alwaysOnTopChanged(!alwaysOnTopProvider());
            SyncNow();
        };
        restore.Click += (_, _) => returnToController();
        minimize.Click += (_, _) => WindowState = FormWindowState.Minimized;
        close.Click += (_, _) => Close();
        captionBar.Controls.AddRange([pinButton, restore, minimize, close]);
        captionBar.Resize += (_, _) => LayoutCaptionButtons();
        LayoutCaptionButtons();
    }

    void LayoutCaptionButtons()
    {
        const int buttonWidth = 35;
        var left = captionBar.ClientSize.Width - buttonWidth * 4;
        for (var index = 0; index < captionBar.Controls.Count; index++)
            captionBar.Controls[index].Bounds = new Rectangle(left + index * buttonWidth, 0, buttonWidth, captionBar.Height);
    }

    protected override void WndProc(ref Message m)
    {
        const int wmNcHitTest = 0x0084;
        base.WndProc(ref m);
        if (m.Msg != wmNcHitTest || WindowState != FormWindowState.Normal) return;
        var point = PointToClient(new Point(unchecked((short)m.LParam.ToInt64()), unchecked((short)(m.LParam.ToInt64() >> 16))));
        const int edge = 4;
        var left = point.X < edge;
        var right = point.X >= ClientSize.Width - edge;
        var top = point.Y < edge;
        var bottom = point.Y >= ClientSize.Height - edge;
        var hit = top && left ? 13 : top && right ? 14 : bottom && left ? 16 : bottom && right ? 17
            : left ? 10 : right ? 11 : top ? 12 : bottom ? 15 : 0;
        if (hit != 0) m.Result = (IntPtr)hit;
        else if (point.Y < captionBar.Height && captionBar.GetChildAtPoint(point) is null)
            m.Result = (IntPtr)2;
    }

    enum CaptionIcon { Pin, Restore, Minimize, Close }

    [System.Runtime.InteropServices.DllImport("user32.dll")]
    static extern bool ReleaseCapture();

    [System.Runtime.InteropServices.DllImport("user32.dll")]
    static extern IntPtr SendMessage(IntPtr window, int message, IntPtr wParam, IntPtr lParam);

    sealed class CaptionButton(CaptionIcon icon) : Button
    {
        bool hovered;
        bool selected;
        public bool Selected
        {
            get => selected;
            set { if (selected == value) return; selected = value; Invalidate(); }
        }

        protected override void OnMouseEnter(EventArgs e) { hovered = true; base.OnMouseEnter(e); Invalidate(); }
        protected override void OnMouseLeave(EventArgs e) { hovered = false; base.OnMouseLeave(e); Invalidate(); }

        protected override void OnPaint(PaintEventArgs e)
        {
            e.Graphics.Clear(hovered ? icon == CaptionIcon.Close ? Color.FromArgb(190, 48, 58) : Color.FromArgb(51, 51, 66) : BackColor);
            e.Graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
            using var pen = new Pen(selected || hovered ? Color.White : Color.FromArgb(159, 159, 177), 1);
            var cx = Width / 2f;
            var cy = Height / 2f;
            e.Graphics.TranslateTransform(cx - 6, cy - 6);
            switch (icon)
            {
                case CaptionIcon.Pin:
                    if (selected)
                    {
                        using var fill = new SolidBrush(Color.FromArgb(159, 159, 177));
                        e.Graphics.FillPolygon(fill, [new PointF(7, 0), new PointF(12, 5), new PointF(9, 7), new PointF(8, 10), new PointF(2, 4), new PointF(5, 3)]);
                    }
                    e.Graphics.DrawLines(pen, [new PointF(7, 0), new PointF(12, 5), new PointF(9, 7), new PointF(8, 10), new PointF(2, 4), new PointF(5, 3), new PointF(7, 0)]);
                    e.Graphics.DrawLine(pen, 5, 7, 1, 11);
                    break;
                case CaptionIcon.Restore:
                    e.Graphics.DrawLines(pen, [new PointF(5, 2), new PointF(2, 2), new PointF(2, 10), new PointF(10, 10), new PointF(10, 7)]);
                    e.Graphics.DrawLines(pen, [new PointF(7, 1), new PointF(11, 1), new PointF(11, 5)]);
                    e.Graphics.DrawLine(pen, 6, 6, 11, 1);
                    break;
                case CaptionIcon.Minimize: e.Graphics.DrawLine(pen, 2, 6, 10, 6); break;
                case CaptionIcon.Close:
                    e.Graphics.DrawLine(pen, 2, 2, 10, 10);
                    e.Graphics.DrawLine(pen, 10, 2, 2, 10);
                    break;
            }
            e.Graphics.ResetTransform();
            if (Focused && ShowFocusCues) ControlPaint.DrawFocusRectangle(e.Graphics, new Rectangle(4, 4, Width - 8, Height - 8));
        }
    }

    void OnFormClosing(object? sender, FormClosingEventArgs e)
    {
        if (closingFromOwner) return;
        e.Cancel = true;
        refreshTimer.Stop();
        Hide();
        returnToController();
    }

    protected override void Dispose(bool disposing)
    {
        if (disposing) refreshTimer.Dispose();
        base.Dispose(disposing);
    }

    protected override void OnHandleCreated(EventArgs e)
    {
        base.OnHandleCreated(e);
        ApplyTheme(theme);
    }
}
