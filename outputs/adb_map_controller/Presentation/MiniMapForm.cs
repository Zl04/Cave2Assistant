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
        // 工具窗口边框会在 Windows 上隐藏系统最小化按钮。
        // 使用普通可调整大小的边框，使 MinimizeBox 显示在 Close 旁边。
        FormBorderStyle = FormBorderStyle.Sizable;
        ShowInTaskbar = true;
        MinimizeBox = true;
        MaximizeBox = false;
        MinimumSize = new Size(150, 100);
        ClientSize = new Size(150, 100);
        KeyPreview = true;

        mapPanel.ContextMenuStrip = BuildContextMenu();
        Controls.Add(mapPanel);
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
