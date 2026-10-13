using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace AdbMapController;

public sealed partial class MainForm
{
    readonly Panel windowCaption = new() { Dock = DockStyle.Top, Height = 30 };
    readonly Label captionTitle = new() { AutoSize = false, TextAlign = ContentAlignment.MiddleLeft, Dock = DockStyle.Fill, Padding = new Padding(10, 0, 0, 0) };
    readonly CaptionButton captionPin = new(CaptionIcon.Pin);
    readonly CaptionButton captionMaximize = new(CaptionIcon.Maximize);
    readonly ToolTip captionToolTip = new();

    void BuildWindowCaption()
    {
        var buttons = new FlowLayoutPanel
        {
            Dock = DockStyle.Right,
            AutoSize = true,
            AutoSizeMode = AutoSizeMode.GrowAndShrink,
            FlowDirection = FlowDirection.LeftToRight,
            WrapContents = false,
            Margin = Padding.Empty,
            Padding = Padding.Empty
        };
        var mini = new CaptionButton(CaptionIcon.Mini);
        var minimize = new CaptionButton(CaptionIcon.Minimize);
        var close = new CaptionButton(CaptionIcon.Close);
        CaptionButton[] controls = [captionPin, mini, minimize, captionMaximize, close];
        string[] names = ["窗口置顶", "小窗口", "最小化", "最大化", "关闭"];
        for (var index = 0; index < controls.Length; index++)
        {
            var button = controls[index];
            button.Size = new Size(40, 30);
            button.Margin = Padding.Empty;
            button.AccessibleName = names[index];
            captionToolTip.SetToolTip(button, names[index]);
            buttons.Controls.Add(button);
        }
        captionPin.Selected = alwaysOnTop.Checked;
        captionPin.Click += (_, _) => SetAlwaysOnTop(!alwaysOnTop.Checked);
        mini.Click += (_, _) => ToggleMiniWindowMode();
        minimize.Click += (_, _) => WindowState = FormWindowState.Minimized;
        captionMaximize.Click += (_, _) => ToggleCaptionMaximize();
        close.Click += (_, _) => Close();
        captionTitle.Text = Text;
        TextChanged += (_, _) => captionTitle.Text = Text;
        windowCaption.Controls.Add(captionTitle);
        windowCaption.Controls.Add(buttons);
        Controls.Add(windowCaption);
        foreach (Control area in new Control[] { windowCaption, captionTitle })
        {
            area.MouseDown += (_, e) =>
            {
                if (e.Button != MouseButtons.Left) return;
                ReleaseCaptionCapture();
                SendCaptionMessage(Handle, 0x00A1, (IntPtr)2, IntPtr.Zero);
            };
            area.MouseDoubleClick += (_, e) => { if (e.Button == MouseButtons.Left) ToggleCaptionMaximize(); };
        }
        Resize += (_, _) =>
        {
            captionMaximize.Icon = WindowState == FormWindowState.Maximized ? CaptionIcon.WindowRestore : CaptionIcon.Maximize;
            captionMaximize.AccessibleName = WindowState == FormWindowState.Maximized ? "还原" : "最大化";
            captionToolTip.SetToolTip(captionMaximize, captionMaximize.AccessibleName);
            captionMaximize.Invalidate();
        };
    }

    void ToggleCaptionMaximize()
    {
        MaximizedBounds = Screen.FromHandle(Handle).WorkingArea;
        WindowState = WindowState == FormWindowState.Maximized ? FormWindowState.Normal : FormWindowState.Maximized;
    }

    void ApplyWindowCaptionTheme()
    {
        var background = currentPalette.IsDark ? Color.FromArgb(32, 32, 43) : currentPalette.Surface;
        windowCaption.BackColor = background;
        captionTitle.BackColor = background;
        captionTitle.ForeColor = currentPalette.Text;
        foreach (Control group in windowCaption.Controls)
        {
            group.BackColor = background;
            foreach (Control button in group.Controls)
            {
                button.BackColor = background;
                button.ForeColor = currentPalette.Text;
            }
        }
    }

    protected override void WndProc(ref Message m)
    {
        // 保留系统可调整大小的窗口样式，将原生标题栏替换为统一的按钮栏。
        if (m.Msg == 0x0083 && m.WParam != IntPtr.Zero)
        {
            m.Result = IntPtr.Zero;
            return;
        }
        base.WndProc(ref m);
        if (m.Msg != 0x0084 || WindowState != FormWindowState.Normal) return;
        var position = m.LParam.ToInt64();
        var point = PointToClient(new Point(unchecked((short)position), unchecked((short)(position >> 16))));
        var edge = Math.Max(4, 4 * DeviceDpi / 96);
        var left = point.X < edge;
        var right = point.X >= ClientSize.Width - edge;
        var top = point.Y < edge;
        var bottom = point.Y >= ClientSize.Height - edge;
        var hit = top && left ? 13 : top && right ? 14 : bottom && left ? 16 : bottom && right ? 17
            : left ? 10 : right ? 11 : top ? 12 : bottom ? 15 : 0;
        m.Result = (IntPtr)(hit == 0 ? 1 : hit);
    }

    [DllImport("user32.dll", EntryPoint = "ReleaseCapture")]
    static extern bool ReleaseCaptionCapture();

    [DllImport("user32.dll", EntryPoint = "SendMessageW")]
    static extern IntPtr SendCaptionMessage(IntPtr window, int message, IntPtr wParam, IntPtr lParam);
}
