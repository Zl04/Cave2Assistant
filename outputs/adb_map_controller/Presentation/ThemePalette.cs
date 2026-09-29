using System;
using System.Drawing;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace AdbMapController;

public enum ThemeMode
{
    Light,
    Dark,
    System,
}

public enum ThemeRole
{
    Default,
    Surface,
    SurfaceAlt,
    Input,
    Log,
    SecondaryButton,
    AccentButton,
    SuccessButton,
    WarningButton,
    DangerButton,
    InfoButton,
    UtilityButton,
    MutedText,
    AccentText,
    SuccessText,
    WarningText,
    Map,
}

public sealed record ThemePalette(
    Color WindowBackground,
    Color Surface,
    Color SurfaceAlt,
    Color InputBackground,
    Color Text,
    Color MutedText,
    Color AccentText,
    Color SuccessText,
    Color WarningText,
    Color Border,
    Color FocusBorder,
    Color DisabledText,
    Color SelectionBackground,
    Color SurfaceHover,
    Color ButtonSecondary,
    Color ButtonAccent,
    Color ButtonSuccess,
    Color ButtonWarning,
    Color ButtonDanger,
    Color ButtonInfo,
    Color ButtonUtility,
    Color ButtonText,
    Color MapBackground,
    Color MapUnreachable,
    Color MapExplored,
    Color MapUnexplored,
    Color MapRoute,
    Color MapPlayer,
    Color MapOverlayBackground,
    Color MapOverlayBorder,
    Color MapOverlayText,
    Color MapTownText)
{
    public bool IsDark => WindowBackground.R < 100;

    public static ThemePalette Light { get; } = new(
        WindowBackground: Color.FromArgb(248, 249, 251),
        Surface: Color.White,
        SurfaceAlt: Color.FromArgb(241, 244, 248),
        InputBackground: Color.White,
        Text: Color.FromArgb(35, 39, 47),
        MutedText: Color.FromArgb(92, 99, 112),
        AccentText: Color.FromArgb(0, 116, 170),
        SuccessText: Color.FromArgb(24, 125, 72),
        WarningText: Color.FromArgb(151, 103, 0),
        Border: Color.FromArgb(202, 209, 219),
        FocusBorder: Color.FromArgb(0, 116, 170),
        DisabledText: Color.FromArgb(146, 153, 164),
        SelectionBackground: Color.FromArgb(190, 214, 235),
        SurfaceHover: Color.FromArgb(231, 236, 242),
        ButtonSecondary: Color.FromArgb(231, 236, 242),
        ButtonAccent: Color.FromArgb(31, 123, 151),
        ButtonSuccess: Color.FromArgb(31, 133, 91),
        ButtonWarning: Color.FromArgb(177, 119, 26),
        ButtonDanger: Color.FromArgb(177, 62, 72),
        ButtonInfo: Color.FromArgb(63, 103, 165),
        ButtonUtility: Color.FromArgb(104, 80, 157),
        ButtonText: Color.White,
        MapBackground: Color.FromArgb(235, 239, 244),
        MapUnreachable: Color.FromArgb(245, 207, 211),
        MapExplored: Color.FromArgb(187, 199, 211),
        MapUnexplored: Color.FromArgb(219, 226, 234),
        MapRoute: Color.FromArgb(0, 128, 190),
        MapPlayer: Color.FromArgb(0, 139, 205),
        MapOverlayBackground: Color.FromArgb(232, 248, 250, 252),
        MapOverlayBorder: Color.FromArgb(118, 145, 166),
        MapOverlayText: Color.FromArgb(35, 39, 47),
        MapTownText: Color.FromArgb(20, 104, 58));

    public static ThemePalette Dark { get; } = new(
        WindowBackground: Color.FromArgb(30, 30, 30),
        Surface: Color.FromArgb(37, 37, 38),
        SurfaceAlt: Color.FromArgb(45, 45, 48),
        InputBackground: Color.FromArgb(60, 60, 60),
        Text: Color.FromArgb(212, 212, 212),
        MutedText: Color.FromArgb(157, 157, 157),
        AccentText: Color.FromArgb(55, 148, 255),
        SuccessText: Color.FromArgb(137, 209, 133),
        WarningText: Color.FromArgb(204, 167, 0),
        Border: Color.FromArgb(69, 69, 69),
        FocusBorder: Color.FromArgb(0, 127, 212),
        DisabledText: Color.FromArgb(106, 106, 106),
        SelectionBackground: Color.FromArgb(38, 79, 120),
        SurfaceHover: Color.FromArgb(42, 45, 46),
        ButtonSecondary: Color.FromArgb(58, 61, 65),
        ButtonAccent: Color.FromArgb(14, 99, 156),
        ButtonSuccess: Color.FromArgb(22, 130, 93),
        ButtonWarning: Color.FromArgb(128, 96, 0),
        ButtonDanger: Color.FromArgb(161, 38, 13),
        ButtonInfo: Color.FromArgb(29, 93, 155),
        ButtonUtility: Color.FromArgb(90, 74, 120),
        ButtonText: Color.White,
        MapBackground: Color.FromArgb(30, 30, 30),
        MapUnreachable: Color.FromArgb(90, 42, 42),
        MapExplored: Color.FromArgb(58, 61, 65),
        MapUnexplored: Color.FromArgb(37, 37, 38),
        MapRoute: Color.FromArgb(86, 156, 214),
        MapPlayer: Color.FromArgb(79, 193, 255),
        MapOverlayBackground: Color.FromArgb(230, 37, 37, 38),
        MapOverlayBorder: Color.FromArgb(0, 122, 204),
        MapOverlayText: Color.FromArgb(212, 212, 212),
        MapTownText: Color.FromArgb(137, 209, 133));

    public static ThemePalette Resolve(ThemeMode mode)
    {
        var dark = mode == ThemeMode.Dark || mode == ThemeMode.System && IsSystemDark();
        var fallback = dark ? Dark : Light;
        return ThemeCatalog.LoadBuiltIn(dark ? ThemeMode.Dark : ThemeMode.Light, fallback);
    }

    static bool IsSystemDark()
    {
        try
        {
            using var key = Microsoft.Win32.Registry.CurrentUser.OpenSubKey(
                @"Software\Microsoft\Windows\CurrentVersion\Themes\Personalize");
            return key?.GetValue("AppsUseLightTheme") is int value && value == 0;
        }
        catch
        {
            return false;
        }
    }
}

public static class ThemeManager
{
    public static void Apply(Control root, ThemePalette palette)
    {
        root.SuspendLayout();
        try { ApplyControl(root, palette); }
        finally { root.ResumeLayout(true); }
        ApplyNativeTheme(root, palette);
    }

    public static void Apply(ToolStripDropDown menu, ThemePalette palette)
    {
        menu.BackColor = palette.Surface;
        menu.ForeColor = palette.Text;
        foreach (ToolStripItem item in menu.Items)
        {
            item.BackColor = palette.Surface;
            item.ForeColor = palette.Text;
            if (item is ToolStripControlHost host)
                Apply(host.Control, palette);
        }
        menu.Renderer = new ToolStripProfessionalRenderer(new ThemeColorTable(palette));
    }

    static void ApplyControl(Control control, ThemePalette palette)
    {
        var role = GetRole(control);
        switch (role)
        {
            case ThemeRole.Surface:
                control.BackColor = palette.Surface;
                control.ForeColor = palette.Text;
                break;
            case ThemeRole.SurfaceAlt:
                control.BackColor = palette.SurfaceAlt;
                control.ForeColor = palette.Text;
                break;
            case ThemeRole.Input:
                control.BackColor = palette.InputBackground;
                control.ForeColor = palette.Text;
                break;
            case ThemeRole.Log:
                control.BackColor = palette.MapBackground;
                control.ForeColor = palette.Text;
                break;
            case ThemeRole.MutedText:
                control.BackColor = Color.Transparent;
                control.ForeColor = palette.MutedText;
                break;
            case ThemeRole.AccentText:
                control.BackColor = Color.Transparent;
                control.ForeColor = palette.AccentText;
                break;
            case ThemeRole.SuccessText:
                control.BackColor = Color.Transparent;
                control.ForeColor = palette.SuccessText;
                break;
            case ThemeRole.WarningText:
                control.BackColor = Color.Transparent;
                control.ForeColor = palette.WarningText;
                break;
            case ThemeRole.SecondaryButton:
            case ThemeRole.AccentButton:
            case ThemeRole.SuccessButton:
            case ThemeRole.WarningButton:
            case ThemeRole.DangerButton:
            case ThemeRole.InfoButton:
            case ThemeRole.UtilityButton:
                ApplyButtonTheme((Button)control, role, palette);
                break;
            case ThemeRole.Map:
                control.BackColor = palette.MapBackground;
                control.ForeColor = palette.Text;
                break;
            default:
                if (control is Form or TabControl or TabPage or SplitContainer)
                    control.BackColor = palette.WindowBackground;
                else if (control is Label or CheckBox or RadioButton)
                {
                    control.BackColor = Color.Transparent;
                    control.ForeColor = palette.Text;
                }
                else
                {
                    control.BackColor = palette.WindowBackground;
                    control.ForeColor = palette.Text;
                }
                break;
        }

        if (control is Button button && role == ThemeRole.Default)
        {
            button.BackColor = palette.Surface;
            button.ForeColor = palette.Text;
        }
        if (control is Button themedButton)
        {
            themedButton.UseVisualStyleBackColor = false;
            themedButton.FlatStyle = FlatStyle.Flat;
            themedButton.Padding = new Padding(9, 4, 9, 4);
            themedButton.Margin = new Padding(3, 1, 3, 1);
            // Derive the border from the button's own fill color. This keeps
            // primary, warning, danger, and utility actions in their own
            // color family instead of giving every button a blue outline.
            themedButton.FlatAppearance.BorderColor = ButtonBorderColor(themedButton.BackColor, palette.IsDark);
            themedButton.FlatAppearance.BorderSize = 1;
            themedButton.FlatAppearance.MouseOverBackColor = role == ThemeRole.Default
                ? palette.SurfaceHover
                : Lighten(themedButton.BackColor, 10);
            themedButton.FlatAppearance.MouseDownBackColor = Darken(themedButton.BackColor, 10);
        }
        else if (control is CheckBox checkBox)
        {
            checkBox.UseVisualStyleBackColor = false;
            checkBox.FlatStyle = FlatStyle.Flat;
            checkBox.FlatAppearance.BorderColor = palette.FocusBorder;
            checkBox.FlatAppearance.BorderSize = 1;
            checkBox.FlatAppearance.CheckedBackColor = palette.AccentText;
            checkBox.FlatAppearance.MouseOverBackColor = palette.SurfaceAlt;
        }
        else if (control is RadioButton radioButton)
        {
            radioButton.UseVisualStyleBackColor = false;
            radioButton.FlatStyle = FlatStyle.Flat;
            radioButton.FlatAppearance.BorderColor = palette.FocusBorder;
            radioButton.FlatAppearance.BorderSize = 1;
            radioButton.FlatAppearance.CheckedBackColor = palette.AccentText;
            radioButton.FlatAppearance.MouseOverBackColor = palette.SurfaceAlt;
        }
        else if (control is ComboBox comboBox)
        {
            comboBox.FlatStyle = FlatStyle.Flat;
            comboBox.BackColor = palette.InputBackground;
            comboBox.ForeColor = palette.Text;
        }
        else if (control is NumericUpDown numericUpDown)
        {
            numericUpDown.BorderStyle = BorderStyle.FixedSingle;
            numericUpDown.BackColor = palette.InputBackground;
            numericUpDown.ForeColor = palette.Text;
        }
        else if (role == ThemeRole.Input && (control is TextBoxBase or ComboBox or NumericUpDown or ListBox))
        {
            control.BackColor = palette.InputBackground;
            control.ForeColor = palette.Text;
        }

        if (control is ThemedTabControl themedTabs)
            themedTabs.ApplyTheme(palette);
        else if (control is TabPage tabPage)
        {
            tabPage.UseVisualStyleBackColor = false;
            NativeTheme.RemoveClientFrame(tabPage);
        }

        if (control is ThemedCheckBox themedCheckBox)
            themedCheckBox.ApplyTheme(palette);
        else if (control is ThemedComboBox themedComboBox)
            themedComboBox.ApplyTheme(palette);
        else if (control is ThemedTextBox themedTextBox)
            themedTextBox.ApplyTheme(palette);
        else if (control is ThemedNumericUpDown themedNumericUpDown)
            themedNumericUpDown.ApplyTheme(palette);

        foreach (Control child in control.Controls)
            ApplyControl(child, palette);
    }

    static void ApplyNativeTheme(Control root, ThemePalette palette)
    {
        NativeTheme.Apply(root, palette);
        foreach (Control child in root.Controls)
            ApplyNativeTheme(child, palette);
    }

    static ThemeRole GetRole(Control control)
    {
        if (control.Tag is ThemeRole role) return role;
        // A theme may change all RGB values. Infer only the framework-level
        // input default; semantic surfaces must be tagged explicitly.
        return control is TextBoxBase or ComboBox or NumericUpDown or ListBox
            ? ThemeRole.Input
            : ThemeRole.Default;
    }

    static void ApplyButtonTheme(Button button, ThemeRole role, ThemePalette palette)
    {
        button.BackColor = role switch
        {
            ThemeRole.SecondaryButton => palette.ButtonSecondary,
            ThemeRole.AccentButton => palette.ButtonAccent,
            ThemeRole.SuccessButton => palette.ButtonSuccess,
            ThemeRole.WarningButton => palette.ButtonWarning,
            ThemeRole.DangerButton => palette.ButtonDanger,
            ThemeRole.InfoButton => palette.ButtonInfo,
            ThemeRole.UtilityButton => palette.ButtonUtility,
            _ => palette.Surface,
        };
        button.ForeColor = role == ThemeRole.SecondaryButton ? palette.Text : palette.ButtonText;
    }

    static Color Lighten(Color color, int amount) => Color.FromArgb(
        Math.Min(255, color.R + amount),
        Math.Min(255, color.G + amount),
        Math.Min(255, color.B + amount));

    static Color Darken(Color color, int amount) => Color.FromArgb(
        Math.Max(0, color.R - amount),
        Math.Max(0, color.G - amount),
        Math.Max(0, color.B - amount));

    static Color ButtonBorderColor(Color fill, bool darkTheme)
        => darkTheme ? Lighten(fill, 16) : Darken(fill, 16);
}

public sealed class ThemedTabControl : TabControl
{
    const int WmPaint = 0x000F;
    const int WmNcPaint = 0x0085;
    const int GwlStyle = -16;
    const int GwlExStyle = -20;
    const long WsBorder = 0x00800000L;
    const long WsExClientEdge = 0x00000200L;
    const uint SwpNoSize = 0x0001;
    const uint SwpNoMove = 0x0002;
    const uint SwpNoZOrder = 0x0004;
    const uint SwpNoActivate = 0x0010;
    const uint SwpFrameChanged = 0x0020;
    ThemePalette palette = ThemePalette.Light;

    public ThemedTabControl()
    {
        DrawMode = TabDrawMode.OwnerDrawFixed;
        SizeMode = TabSizeMode.Fixed;
        ItemSize = new Size(72, 32);
        Padding = new Point(16, 4);
    }

    public void ApplyTheme(ThemePalette value)
    {
        palette = value;
        BackColor = value.WindowBackground;
        foreach (TabPage page in TabPages)
        {
            page.BackColor = value.WindowBackground;
            page.ForeColor = value.Text;
            page.UseVisualStyleBackColor = false;
        }
        if (IsHandleCreated)
        {
            RemoveNativeFrame();
            NativeTheme.UseCustomWindowTheme(this);
            PaintTabChrome();
        }
        Invalidate();
    }

    protected override void OnHandleCreated(EventArgs e)
    {
        base.OnHandleCreated(e);
        RemoveNativeFrame();
        NativeTheme.UseCustomWindowTheme(this);
        PaintTabChrome();
    }

    protected override void OnDrawItem(DrawItemEventArgs e)
    {
        DrawTab(e.Graphics, e.Index, e.Bounds);
    }

    protected override void WndProc(ref Message message)
    {
        base.WndProc(ref message);
        if (message.Msg == WmPaint)
            PaintTabChrome();
        else if (message.Msg == WmNcPaint)
        {
            RemoveNativeFrame();
            PaintTabChrome();
        }
    }

    void PaintTabChrome()
    {
        if (!IsHandleCreated || Width <= 0 || Height <= 0) return;

        try
        {
            using var graphics = Graphics.FromHwnd(Handle);
            var stripBottom = TabPages.Count > 0
                ? GetTabRect(0).Bottom
                : Math.Min(Height, ItemSize.Height);
            stripBottom = Math.Clamp(stripBottom, 0, Height);

            // TabControl's native renderer paints the unused part of the tab strip
            // and its page frame independently. Cover both with our surface color.
            using (var strip = new SolidBrush(palette.WindowBackground))
                graphics.FillRectangle(strip, 0, 0, Width, stripBottom + 1);

            for (var index = 0; index < TabPages.Count; index++)
                DrawTab(graphics, index, GetTabRect(index));

            using (var divider = new Pen(palette.SurfaceAlt))
                graphics.DrawLine(divider, 0, stripBottom, Math.Max(0, Width - 1), stripBottom);

            PaintPageFrame(graphics);

            using var edge = new Pen(palette.Border);
            var client = ClientRectangle;
            client.Width = Math.Max(0, client.Width - 1);
            client.Height = Math.Max(0, client.Height - 1);
            graphics.DrawRectangle(edge, client);
        }
        catch (ArgumentException)
        {
            // The handle can be recreated while the theme is being applied.
        }
    }

    void PaintPageFrame(Graphics graphics)
    {
        var page = DisplayRectangle;
        if (page.Width <= 0 || page.Height <= 0) return;

        // The native tab renderer owns a 3px page frame just outside
        // DisplayRectangle. Cover only that ring so the page contents remain
        // untouched, then redraw it with the active theme border.
        using var frame = new SolidBrush(palette.Border);
        var left = Math.Max(0, page.Left - 3);
        var top = Math.Max(0, page.Top - 3);
        var right = Math.Min(Width, page.Right + 3);
        var bottom = Math.Min(Height, page.Bottom + 3);
        graphics.FillRectangle(frame, left, top, Math.Max(0, page.Left - left), Math.Max(0, bottom - top));
        graphics.FillRectangle(frame, page.Right, top, Math.Max(0, right - page.Right), Math.Max(0, bottom - top));
        graphics.FillRectangle(frame, page.Left, top, Math.Max(0, page.Width), Math.Max(0, page.Top - top));
        graphics.FillRectangle(frame, page.Left, page.Bottom, Math.Max(0, page.Width), Math.Max(0, bottom - page.Bottom));
    }

    void RemoveNativeFrame()
    {
        if (!IsHandleCreated) return;

        var style = GetWindowLongPtr(Handle, GwlStyle).ToInt64();
        var updatedStyle = style & ~WsBorder;
        if (updatedStyle != style)
            _ = SetWindowLongPtr(Handle, GwlStyle, new IntPtr(updatedStyle));

        var exStyle = GetWindowLongPtr(Handle, GwlExStyle).ToInt64();
        var updatedExStyle = exStyle & ~WsExClientEdge;
        if (updatedExStyle != exStyle)
            _ = SetWindowLongPtr(Handle, GwlExStyle, new IntPtr(updatedExStyle));

        if (updatedStyle != style || updatedExStyle != exStyle)
        {
            _ = SetWindowPos(Handle, IntPtr.Zero, 0, 0, 0, 0,
                SwpNoSize | SwpNoMove | SwpNoZOrder | SwpNoActivate | SwpFrameChanged);
        }
    }

    [DllImport("user32.dll")]
    static extern IntPtr GetWindowLongPtr(IntPtr handle, int index);

    [DllImport("user32.dll")]
    static extern IntPtr SetWindowLongPtr(IntPtr handle, int index, IntPtr value);

    [DllImport("user32.dll", SetLastError = true)]
    static extern bool SetWindowPos(IntPtr handle, IntPtr insertAfter, int x, int y, int width, int height, uint flags);

    void DrawTab(Graphics graphics, int index, Rectangle bounds)
    {
        if (index < 0 || index >= TabPages.Count) return;

        var selected = index == SelectedIndex;
        bounds.Inflate(-1, 0);
        using (var fill = new SolidBrush(selected ? palette.Surface : palette.WindowBackground))
            graphics.FillRectangle(fill, bounds);
        if (selected)
        {
            using var accent = new SolidBrush(palette.AccentText);
            graphics.FillRectangle(accent, bounds.X, bounds.Bottom - 2, bounds.Width, 2);
        }

        TextRenderer.DrawText(
            graphics,
            TabPages[index].Text,
            Font,
            bounds,
            selected ? palette.Text : palette.MutedText,
            TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
    }
}

public sealed class ThemedTabPage : TabPage
{
    protected override void OnHandleCreated(EventArgs e)
    {
        base.OnHandleCreated(e);
        NativeTheme.RemoveClientFrame(this);
    }
}

public sealed class ThemedCheckBox : CheckBox
{
    const int WmPaint = 0x000F;
    ThemePalette palette = ThemePalette.Light;

    public ThemedCheckBox()
    {
        SetStyle(ControlStyles.UserPaint | ControlStyles.AllPaintingInWmPaint | ControlStyles.OptimizedDoubleBuffer, true);
    }

    public void ApplyTheme(ThemePalette value)
    {
        palette = value;
        BackColor = Color.Transparent;
        Invalidate();
    }

    protected override void WndProc(ref Message message)
    {
        base.WndProc(ref message);
        if (message.Msg == WmPaint) PaintThemed();
    }

    protected override void OnCheckedChanged(EventArgs e)
    {
        base.OnCheckedChanged(e);
        Invalidate();
    }

    protected override void OnEnabledChanged(EventArgs e)
    {
        base.OnEnabledChanged(e);
        Invalidate();
    }

    void PaintThemed()
    {
        if (!IsHandleCreated || Width <= 0 || Height <= 0) return;
        using var graphics = Graphics.FromHwnd(Handle);
        var background = Parent?.BackColor ?? palette.WindowBackground;
        using var back = new SolidBrush(background);
        graphics.FillRectangle(back, ClientRectangle);

        var boxSize = Math.Max(12, (int)Math.Round(14 * DeviceDpi / 96f));
        var box = new Rectangle(1, Math.Max(0, (Height - boxSize) / 2), boxSize, boxSize);
        var enabled = Enabled;
        using var boxFill = new SolidBrush(Checked ? palette.AccentText : palette.InputBackground);
        using var boxBorder = new Pen(enabled ? palette.Border : palette.MutedText);
        graphics.FillRectangle(boxFill, box);
        graphics.DrawRectangle(boxBorder, box.X, box.Y, box.Width - 1, box.Height - 1);
        if (Checked)
        {
            using var check = new Pen(palette.ButtonText, Math.Max(1.5f, DeviceDpi / 96f * 1.8f))
            { StartCap = System.Drawing.Drawing2D.LineCap.Round, EndCap = System.Drawing.Drawing2D.LineCap.Round };
            graphics.DrawLines(check,
            [
                new PointF(box.Left + box.Width * .22f, box.Top + box.Height * .52f),
                new PointF(box.Left + box.Width * .44f, box.Bottom - box.Height * .22f),
                new PointF(box.Right - box.Width * .18f, box.Top + box.Height * .22f),
            ]);
        }

        var textColor = enabled ? ForeColor : palette.MutedText;
        TextRenderer.DrawText(graphics, Text, Font,
            new Rectangle(box.Right + 5, 0, Math.Max(0, Width - box.Right - 5), Height),
            textColor, TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding | TextFormatFlags.EndEllipsis);
    }
}

public sealed class ThemedComboBox : ComboBox
{
    const int WmPaint = 0x000F;
    ThemePalette palette = ThemePalette.Light;
    bool arrowPaintQueued;

    public ThemedComboBox()
    {
        DrawMode = DrawMode.OwnerDrawFixed;
    }

    public void ApplyTheme(ThemePalette value)
    {
        palette = value;
        BackColor = value.InputBackground;
        ForeColor = value.Text;
        if (IsHandleCreated)
            NativeTheme.UseCustomTheme(this);
        QueueArrowPaint();
    }

    protected override void OnDrawItem(DrawItemEventArgs e)
    {
        if (e.Index < 0 || e.Index >= Items.Count) return;
        var selected = (e.State & DrawItemState.Selected) != 0;
        using var fill = new SolidBrush(selected ? palette.SurfaceAlt : palette.InputBackground);
        e.Graphics.FillRectangle(fill, e.Bounds);
        TextRenderer.DrawText(e.Graphics, GetItemText(Items[e.Index]), Font, e.Bounds,
            Enabled ? palette.Text : palette.MutedText,
            TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding | TextFormatFlags.EndEllipsis);
    }

    protected override void WndProc(ref Message message)
    {
        base.WndProc(ref message);
        if (message.Msg == WmPaint) QueueArrowPaint();
    }

    protected override void OnVisibleChanged(EventArgs e)
    {
        base.OnVisibleChanged(e);
        if (Visible) QueueArrowPaint();
    }

    void QueueArrowPaint()
    {
        if (!IsHandleCreated || arrowPaintQueued) return;
        arrowPaintQueued = true;
        try
        {
            BeginInvoke((MethodInvoker)(() =>
            {
                arrowPaintQueued = false;
                PaintArrow();
            }));
        }
        catch (InvalidOperationException)
        {
            arrowPaintQueued = false;
        }
    }

    void PaintArrow()
    {
        if (!IsHandleCreated || Width <= 0 || Height <= 0) return;
        using var graphics = Graphics.FromHwnd(Handle);
        var arrowWidth = Math.Max(16, (int)Math.Round(18 * DeviceDpi / 96f));
        var area = new Rectangle(Math.Max(1, Width - arrowWidth), 1,
            Math.Max(0, arrowWidth - 1), Math.Max(0, Height - 2));
        using var fill = new SolidBrush(palette.SurfaceAlt);
        using var border = new Pen(palette.Border);
        graphics.FillRectangle(fill, area);
        // Paint the outer frame after the arrow area so the fill cannot cover
        // the rightmost pixel column of the combo box border.
        graphics.DrawRectangle(border, 0, 0, Width - 1, Height - 1);
        graphics.DrawLine(border, area.Left, area.Top, area.Left, area.Bottom);
        var center = new Point(area.Left + area.Width / 2, area.Top + area.Height / 2);
        using var arrow = new SolidBrush(Enabled ? palette.Text : palette.MutedText);
        Point[] triangle = [
            new(center.X - 4, center.Y - 2),
            new(center.X + 4, center.Y - 2),
            new(center.X, center.Y + 3),
        ];
        graphics.FillPolygon(arrow, triangle);
    }
}

public sealed class ThemedTextBox : TextBox
{
    const int WmPaint = 0x000F;
    const int WmNcPaint = 0x0085;
    const int WmVScroll = 0x0115;
    const int WmSize = 0x0005;
    const int SbVert = 1;
    const uint SiAll = 0x0017;
    ThemePalette palette = ThemePalette.Light;

    public ThemedTextBox()
    {
        BorderStyle = BorderStyle.FixedSingle;
    }

    public void ApplyTheme(ThemePalette value)
    {
        palette = value;
        BackColor = value.InputBackground;
        ForeColor = value.Text;
        BorderStyle = BorderStyle.FixedSingle;
        if (IsHandleCreated)
        {
            NativeTheme.ApplyScrollbarTheme(this, value);
            PaintChrome();
        }
        Invalidate();
    }

    protected override void OnHandleCreated(EventArgs e)
    {
        base.OnHandleCreated(e);
        NativeTheme.ApplyScrollbarTheme(this, palette);
        PaintChrome();
    }

    protected override void WndProc(ref Message message)
    {
        base.WndProc(ref message);
        if (message.Msg is WmPaint or WmNcPaint or WmVScroll or WmSize)
            PaintChrome();
    }

    void PaintChrome()
    {
        if (!IsHandleCreated || Width <= 0 || Height <= 0) return;
        var dc = GetWindowDC(Handle);
        if (dc == IntPtr.Zero) return;
        try
        {
            using var graphics = Graphics.FromHdc(dc);
            PaintScrollbar(graphics);
            using var border = new Pen(Enabled ? palette.Border : palette.MutedText);
            graphics.DrawRectangle(border, 0, 0, Width - 1, Height - 1);
        }
        finally
        {
            _ = ReleaseDC(Handle, dc);
        }
    }

    void PaintScrollbar(Graphics graphics)
    {
        if (!Multiline || (ScrollBars != ScrollBars.Vertical && ScrollBars != ScrollBars.Both)) return;

        var scrollbarWidth = Math.Max(14, SystemInformation.VerticalScrollBarWidth);
        var area = new Rectangle(Math.Max(0, Width - scrollbarWidth - 1), 1,
            Math.Min(scrollbarWidth, Width), Math.Max(0, Height - 2));
        if (area.Width <= 0 || area.Height <= 0) return;

        using var track = new SolidBrush(palette.InputBackground);
        graphics.FillRectangle(track, area);

        var info = new ScrollInfo
        {
            cbSize = (uint)Marshal.SizeOf<ScrollInfo>(),
            fMask = SiAll,
        };
        var hasScrollInfo = GetScrollInfo(Handle, SbVert, ref info);
        var range = hasScrollInfo ? Math.Max(1, info.nMax - info.nMin + 1) : 1;
        var page = hasScrollInfo ? Math.Clamp((int)info.nPage, 0, range) : range;
        var scrollable = Math.Max(0, range - page);
        if (!hasScrollInfo || scrollable <= 0) return;

        var buttonHeight = Math.Min(16, Math.Max(10, area.Height / 4));
        var trackTop = area.Top + buttonHeight;
        var trackBottom = area.Bottom - buttonHeight;
        var trackHeight = Math.Max(1, trackBottom - trackTop);
        using var arrow = new SolidBrush(Enabled ? palette.MutedText : palette.Border);
        var centerX = area.Left + area.Width / 2;
        graphics.FillPolygon(arrow, new Point[]
        {
            new(centerX - 4, area.Top + buttonHeight / 2 + 2),
            new(centerX + 4, area.Top + buttonHeight / 2 + 2),
            new(centerX, area.Top + buttonHeight / 2 - 3),
        });
        graphics.FillPolygon(arrow, new Point[]
        {
            new(centerX - 4, area.Bottom - buttonHeight / 2 - 2),
            new(centerX + 4, area.Bottom - buttonHeight / 2 - 2),
            new(centerX, area.Bottom - buttonHeight / 2 + 3),
        });

        var thumbHeight = Math.Clamp(trackHeight * page / range, 12, trackHeight);
        var thumbTravel = Math.Max(0, trackHeight - thumbHeight);
        var position = Math.Clamp(info.nPos - info.nMin, 0, scrollable);
        var thumbTop = trackTop + thumbTravel * position / scrollable;
        using var thumb = new SolidBrush(palette.Border);
        graphics.FillRectangle(thumb, new Rectangle(area.Left + 3, thumbTop,
            Math.Max(1, area.Width - 6), thumbHeight));
    }

    [StructLayout(LayoutKind.Sequential)]
    struct ScrollInfo
    {
        public uint cbSize;
        public uint fMask;
        public int nMin;
        public int nMax;
        public uint nPage;
        public int nPos;
        public int nTrackPos;
    }

    [DllImport("user32.dll")]
    static extern bool GetScrollInfo(IntPtr handle, int bar, ref ScrollInfo info);

    [DllImport("user32.dll")]
    static extern IntPtr GetWindowDC(IntPtr handle);

    [DllImport("user32.dll")]
    static extern int ReleaseDC(IntPtr handle, IntPtr dc);
}

public sealed class ThemedNumericUpDown : UserControl
{
    readonly TextBox editor = new()
    {
        BorderStyle = BorderStyle.None,
        TextAlign = HorizontalAlignment.Left,
        TabStop = true,
    };
    ThemePalette palette = ThemePalette.Light;
    decimal value;
    decimal minimum;
    decimal maximum = 100;
    decimal increment = 1;
    bool updatingEditor;

    public event EventHandler? ValueChanged;

    public decimal Minimum
    {
        get => minimum;
        set
        {
            minimum = value;
            if (maximum < minimum) maximum = minimum;
            Value = this.value;
        }
    }

    public decimal Maximum
    {
        get => maximum;
        set
        {
            maximum = Math.Max(value, minimum);
            Value = this.value;
        }
    }

    public decimal Increment
    {
        get => increment;
        set => increment = value > 0 ? value : 1;
    }

    public decimal Value
    {
        get => value;
        set
        {
            var clamped = Math.Clamp(value, minimum, maximum);
            if (this.value == clamped)
            {
                UpdateEditor();
                return;
            }

            this.value = clamped;
            UpdateEditor();
            ValueChanged?.Invoke(this, EventArgs.Empty);
            Invalidate();
        }
    }

    public ThemedNumericUpDown()
    {
        Tag = ThemeRole.Input;
        Height = 23;
        TabStop = true;
        SetStyle(ControlStyles.UserPaint | ControlStyles.AllPaintingInWmPaint |
            ControlStyles.OptimizedDoubleBuffer | ControlStyles.ResizeRedraw, true);

        editor.BackColor = palette.InputBackground;
        editor.ForeColor = palette.Text;
        editor.Font = Font;
        editor.TextChanged += (_, _) => ParseEditorValue();
        editor.KeyDown += EditorKeyDown;
        editor.Leave += (_, _) => UpdateEditor();
        Controls.Add(editor);
        UpdateEditor();
    }

    public void ApplyTheme(ThemePalette value)
    {
        palette = value;
        BackColor = value.InputBackground;
        ForeColor = value.Text;
        editor.BackColor = value.InputBackground;
        editor.ForeColor = value.Text;
        Invalidate();
    }

    protected override void OnLayout(LayoutEventArgs e)
    {
        base.OnLayout(e);
        var arrowWidth = GetArrowWidth();
        editor.Bounds = new Rectangle(4, 2,
            Math.Max(1, Width - arrowWidth - 7), Math.Max(1, Height - 4));
    }

    protected override void OnFontChanged(EventArgs e)
    {
        base.OnFontChanged(e);
        editor.Font = Font;
        PerformLayout();
    }

    protected override void OnEnabledChanged(EventArgs e)
    {
        base.OnEnabledChanged(e);
        editor.Enabled = Enabled;
        Invalidate();
    }

    protected override void OnMouseDown(MouseEventArgs e)
    {
        base.OnMouseDown(e);
        if (e.Button != MouseButtons.Left || e.X < Width - GetArrowWidth()) return;

        Value = e.Y < Height / 2 ? Value + Increment : Value - Increment;
        Focus();
    }

    protected override void OnMouseWheel(MouseEventArgs e)
    {
        base.OnMouseWheel(e);
        if (!Focused) return;
        Value = e.Delta > 0 ? Value + Increment : Value - Increment;
    }

    protected override void OnPaint(PaintEventArgs e)
    {
        base.OnPaint(e);
        var graphics = e.Graphics;
        using var input = new SolidBrush(palette.InputBackground);
        using var border = new Pen(Enabled ? palette.Border : palette.MutedText);
        graphics.FillRectangle(input, ClientRectangle);

        var arrowWidth = GetArrowWidth();
        var area = new Rectangle(Math.Max(0, Width - arrowWidth), 1,
            Math.Min(arrowWidth, Width), Math.Max(0, Height - 2));
        using var arrowBackground = new SolidBrush(palette.SurfaceAlt);
        graphics.FillRectangle(arrowBackground, area);
        graphics.DrawRectangle(border, 0, 0, Math.Max(0, Width - 1), Math.Max(0, Height - 1));
        if (area.Width <= 0 || area.Height <= 0) return;

        graphics.DrawLine(border, area.Left, area.Top, area.Left, area.Bottom);
        var middle = area.Top + area.Height / 2;
        graphics.DrawLine(border, area.Left, middle, area.Right - 1, middle);
        using var arrow = new SolidBrush(Enabled ? palette.Text : palette.MutedText);
        var centerX = area.Left + area.Width / 2;
        var upperCenter = area.Top + Math.Max(4, area.Height / 4);
        var lowerCenter = middle + Math.Max(4, (area.Bottom - middle) / 2);
        graphics.FillPolygon(arrow, new Point[]
        {
            new(centerX - 4, upperCenter + 2),
            new(centerX + 4, upperCenter + 2),
            new(centerX, upperCenter - 3),
        });
        graphics.FillPolygon(arrow, new Point[]
        {
            new(centerX - 4, lowerCenter - 2),
            new(centerX + 4, lowerCenter - 2),
            new(centerX, lowerCenter + 3),
        });
    }

    void EditorKeyDown(object? sender, KeyEventArgs e)
    {
        if (e.KeyCode == Keys.Up || e.KeyCode == Keys.Down)
        {
            Value += e.KeyCode == Keys.Up ? Increment : -Increment;
            e.Handled = true;
            e.SuppressKeyPress = true;
        }
        else if (e.KeyCode == Keys.Enter)
        {
            UpdateEditor();
            e.Handled = true;
            e.SuppressKeyPress = true;
        }
    }

    void ParseEditorValue()
    {
        if (updatingEditor) return;
        if (decimal.TryParse(editor.Text, NumberStyles.Number, CultureInfo.CurrentCulture, out var parsed) ||
            decimal.TryParse(editor.Text, NumberStyles.Number, CultureInfo.InvariantCulture, out parsed))
            Value = parsed;
    }

    void UpdateEditor()
    {
        var text = value.ToString("0.####", CultureInfo.InvariantCulture);
        if (editor.Text == text) return;
        updatingEditor = true;
        editor.Text = text;
        editor.SelectionStart = editor.TextLength;
        updatingEditor = false;
    }

    int GetArrowWidth() => Math.Max(18, (int)Math.Round(20 * DeviceDpi / 96f));
}

sealed class ThemeColorTable(ThemePalette palette) : ProfessionalColorTable
{
    public override Color ToolStripDropDownBackground => palette.Surface;
    public override Color ToolStripBorder => palette.Border;
    public override Color MenuBorder => palette.Border;
    public override Color MenuItemBorder => palette.Border;
    public override Color MenuItemSelected => palette.SurfaceAlt;
    public override Color MenuItemSelectedGradientBegin => palette.SurfaceAlt;
    public override Color MenuItemSelectedGradientEnd => palette.SurfaceAlt;
    public override Color ToolStripContentPanelGradientBegin => palette.Surface;
    public override Color ToolStripContentPanelGradientEnd => palette.Surface;
    public override Color ImageMarginGradientBegin => palette.Surface;
    public override Color ImageMarginGradientMiddle => palette.Surface;
    public override Color ImageMarginGradientEnd => palette.Surface;
}

static class NativeTheme
{
    const int DwmwaUseImmersiveDarkMode = 20;
    const int DwmwaBorderColor = 34;
    const int DwmwaCaptionColor = 35;
    const int DwmwaTextColor = 36;
    const int GwlStyle = -16;
    const int GwlExStyle = -20;
    const long WsBorder = 0x00800000L;
    const long WsExClientEdge = 0x00000200L;
    const uint SwpNoSize = 0x0001;
    const uint SwpNoMove = 0x0002;
    const uint SwpNoZOrder = 0x0004;
    const uint SwpNoActivate = 0x0010;
    const uint SwpFrameChanged = 0x0020;

    [DllImport("dwmapi.dll")]
    static extern int DwmSetWindowAttribute(IntPtr hwnd, int attribute, ref int value, int valueSize);

    [DllImport("uxtheme.dll", CharSet = CharSet.Unicode)]
    static extern int SetWindowTheme(IntPtr hwnd, string? subAppName, string? subIdList);

    [DllImport("user32.dll", EntryPoint = "GetWindowLongPtr", SetLastError = true)]
    static extern IntPtr GetWindowLongPtr(IntPtr handle, int index);

    [DllImport("user32.dll", EntryPoint = "SetWindowLongPtr", SetLastError = true)]
    static extern IntPtr SetWindowLongPtr(IntPtr handle, int index, IntPtr value);

    [DllImport("user32.dll", SetLastError = true)]
    static extern bool SetWindowPos(IntPtr handle, IntPtr insertAfter, int x, int y, int width, int height, uint flags);

    [UnmanagedFunctionPointer(CallingConvention.Winapi)]
    delegate bool EnumChildProc(IntPtr hwnd, IntPtr lParam);

    [DllImport("user32.dll")]
    static extern bool EnumChildWindows(IntPtr parentHandle, EnumChildProc callback, IntPtr lParam);

    public static void Apply(Control control, ThemePalette palette)
    {
        if (!control.IsHandleCreated && control.Parent?.IsHandleCreated == true)
        {
            try { control.CreateControl(); }
            catch (InvalidOperationException) { }
        }
        if (!control.IsHandleCreated) return;

        if (control is Form)
        {
            SetDwmAttribute(control.Handle, DwmwaUseImmersiveDarkMode, palette.IsDark ? 1 : 0);
            SetDwmAttribute(control.Handle, DwmwaCaptionColor, ToColorRef(palette.Surface));
            SetDwmAttribute(control.Handle, DwmwaBorderColor, ToColorRef(palette.Border));
            SetDwmAttribute(control.Handle, DwmwaTextColor, ToColorRef(palette.Text));
        }

        if (NeedsCommonControlTheme(control))
        {
            var themeName = palette.IsDark ? "DarkMode_Explorer" : "Explorer";
            _ = SetWindowTheme(control.Handle, themeName, null);
            EnumChildWindows(control.Handle, (child, _) =>
            {
                _ = SetWindowTheme(child, themeName, null);
                return true;
            }, IntPtr.Zero);
            control.Invalidate(true);
        }
    }

    internal static void UseCustomTheme(Control control)
    {
        if (!control.IsHandleCreated) return;

        _ = SetWindowTheme(control.Handle, string.Empty, string.Empty);
        EnumChildWindows(control.Handle, (child, _) =>
        {
            _ = SetWindowTheme(child, string.Empty, string.Empty);
            return true;
        }, IntPtr.Zero);
        control.Invalidate(true);
    }

    internal static void UseCustomWindowTheme(Control control)
    {
        if (!control.IsHandleCreated) return;

        _ = SetWindowTheme(control.Handle, string.Empty, string.Empty);
        control.Invalidate(true);
    }

    internal static void RemoveClientFrame(Control control)
    {
        if (!control.IsHandleCreated) return;

        var style = GetWindowLongPtr(control.Handle, GwlStyle).ToInt64();
        var updatedStyle = style & ~WsBorder;
        if (updatedStyle != style)
            _ = SetWindowLongPtr(control.Handle, GwlStyle, new IntPtr(updatedStyle));

        var exStyle = GetWindowLongPtr(control.Handle, GwlExStyle).ToInt64();
        var updatedExStyle = exStyle & ~WsExClientEdge;
        if (updatedExStyle != exStyle)
            _ = SetWindowLongPtr(control.Handle, GwlExStyle, new IntPtr(updatedExStyle));

        if (updatedStyle != style || updatedExStyle != exStyle)
        {
            _ = SetWindowPos(control.Handle, IntPtr.Zero, 0, 0, 0, 0,
                SwpNoSize | SwpNoMove | SwpNoZOrder | SwpNoActivate | SwpFrameChanged);
            control.Invalidate(true);
        }
    }

    internal static void ApplyScrollbarTheme(Control control, ThemePalette palette)
    {
        if (!control.IsHandleCreated) return;

        var themeName = palette.IsDark ? "DarkMode_Explorer" : "Explorer";
        _ = SetWindowTheme(control.Handle, themeName, null);
        EnumChildWindows(control.Handle, (child, _) =>
        {
            _ = SetWindowTheme(child, themeName, null);
            return true;
        }, IntPtr.Zero);
        control.Invalidate(true);
    }

    static bool NeedsCommonControlTheme(Control control)
    {
        if (control is ThemedComboBox or ThemedTextBox or ThemedNumericUpDown or ThemedTabControl)
            return false;

        return control is not Form && (control is Button or TextBoxBase or ComboBox or NumericUpDown or ListBox or
            TabControl or ListView or TreeView or TrackBar or ScrollableControl);
    }

    static void SetDwmAttribute(IntPtr handle, int attribute, int value)
    {
        try { _ = DwmSetWindowAttribute(handle, attribute, ref value, sizeof(int)); }
        catch (DllNotFoundException) { }
        catch (EntryPointNotFoundException) { }
    }

    static int ToColorRef(Color color) => color.R | color.G << 8 | color.B << 16;
}
