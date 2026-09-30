using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Win32;

namespace AdbMapController;

public sealed partial class MainForm : Form
{
    readonly AdbClient adb = new(); readonly TouchController touch; readonly MapPanel mapPanel = new() { Dock = DockStyle.Fill };
    readonly PipelineWebServer pipelineWebServer;
    readonly ComboBox devices = new ThemedComboBox { Width = 150, DropDownStyle = ComboBoxStyle.DropDownList };
    readonly Label state = new() { AutoSize = true, Text = "未连接", Tag = ThemeRole.AccentText };
    readonly Label warningState = new() { AutoSize = true, Text = "预警 --", Padding = new(8, 6, 0, 0), Tag = ThemeRole.WarningText };
    readonly Label stats = new() { AutoSize = true, Tag = ThemeRole.MutedText };
    readonly Label assistantState = new() { AutoSize = true, Text = "助手未检测", Padding = new(4, 6, 0, 0), Tag = ThemeRole.WarningText };
    readonly ThemedNumericUpDown stallTimeout = new() { Minimum = 300, Maximum = 5000, Increment = 100, Value = 1000, Width = 70 };
    readonly ThemedNumericUpDown singleCellPulseHold = new() { Minimum = 1, Maximum = 500, Increment = 5, Value = 50, Width = 65 };
    // 正值会在到达预期格子前释放；负值会在到达后继续保持该方向这么多毫秒。
    readonly ThemedNumericUpDown movementReleaseLead = new() { Minimum = -500, Maximum = 500, Increment = 5, Value = 30, Width = 65 };
    readonly ThemedNumericUpDown interactionHold = new() { Minimum = 20, Maximum = 2000, Increment = 50, Value = 300, Width = 65 };
    readonly ThemedNumericUpDown newFloorStartDelay = new() { Minimum = 0, Maximum = 10000, Increment = 100, Value = 1500, Width = 70 };
    readonly ThemedNumericUpDown routeRecoveryAttempts = new() { Minimum = 0, Maximum = 10, Increment = 1, Value = 3, Width = 55 };
    readonly ThemedNumericUpDown targetStopFloor = new() { Minimum = 0, Maximum = 999, Increment = 1, Value = 0, Width = 55 };
    readonly ComboBox entryMapChoice = new ThemedComboBox { Width = 110, DropDownStyle = ComboBoxStyle.DropDownList };
    readonly ComboBox entryChoice = new ThemedComboBox { Width = 90, DropDownStyle = ComboBoxStyle.DropDownList };
    readonly ComboBox entryDifficulty = new ThemedComboBox { Width = 78, DropDownStyle = ComboBoxStyle.DropDownList, AccessibleName = "自动进图难度" };
    readonly ComboBox themeChoice = new ThemedComboBox { Width = 105, DropDownStyle = ComboBoxStyle.DropDownList };
    readonly CheckBox alwaysOnTop = Box("窗口置顶");
    readonly ListBox bonusPriority = new() { Width = 230, Height = 104, IntegralHeight = false, AllowDrop = true, SelectionMode = SelectionMode.One,
        BorderStyle = BorderStyle.FixedSingle, Tag = ThemeRole.Input };
    readonly ToolStripDropDown bonusPriorityPopup = new() { AutoClose = true, AutoSize = false, Padding = new Padding(3) };
    readonly Button bonusPriorityToggle = Btn("加成优先级", ThemeRole.SecondaryButton);
    readonly CheckBox mining = Box("挖矿");
    readonly CheckBox cardMining = Box("卡矿（自动匹配）");
    readonly CheckBox cardLayer = Box("卡层（自动匹配）");
    readonly CheckBox attackBoss = Box("攻击Boss"), monsters = Box("全清小怪"), elites = Box("清除精英"), chests = Box("箱子"), pots = Box("罐子"), bones = Box("石堆"), gold = Box("金币"), runes = Box("符文/点金台"), chambers = Box("密室");
    readonly TextBox log = new ThemedTextBox { Dock = DockStyle.Fill, Multiline = true, ReadOnly = true, ScrollBars = ScrollBars.Vertical, Tag = ThemeRole.Log };
    readonly System.Windows.Forms.Timer refreshTimer = new() { Interval = 500 };
    readonly SemaphoreSlim refreshLock = new(1, 1);
    long lastOverlayUnknownLogAt;
    readonly SemaphoreSlim clickNavigationSwitch = new(1, 1);
    CancellationTokenSource? runCts; CancellationTokenSource? entryCts; MapDump? currentMap;
    readonly MotionInterruptState motionInterrupt = new();
    readonly object movementSliceGate = new();
    CancellationTokenSource? currentMovementSlice;
    Task? activeMovement;
    Task? activeEntry;
    Task? shutdownTask;
    readonly HashSet<Task> uiOperations = [];
    bool closing, closeReady, stopping, scanning;
    readonly RouteSession routeSession = new();
    List<Cell> route { get => routeSession.Route; set => routeSession.Route = value; }
    readonly HashSet<Cell> blocked = []; Cell? lastBlockedAttempt; int unchangedCount;
    List<PlannedInteraction> plannedInteractions { get => routeSession.Interactions; set => routeSession.Interactions = value; }
    HashSet<TargetKey> plannedTargetUniverse { get => routeSession.TargetUniverse; set => routeSession.TargetUniverse = value; }
    readonly HashSet<TargetKey> confirmedCompletedTargets = [];
    // 游戏没有提供稳定且可供 Lua 读取的“机关点亮”字段。
    // 当实际观察到玩家站在机关格上时，按楼层记录确认状态；
    // 该状态可跨越地图刷新，从而避免反复为同一个机关重新规划。
    readonly FloorMechanismState mechanismState = new();
    IReadOnlySet<Cell> visitedMechanisms => mechanismState.Visited;
    readonly HashSet<Cell> interactedChambers = [];
    readonly HashSet<Cell> expectedTaskRoadChanges = [];
    Dictionary<Cell, bool> plannedWalkability { get => routeSession.Walkability; set => routeSession.Walkability = value; }
    int? plannedOptionsSignature { get => routeSession.OptionsSignature; set => routeSession.OptionsSignature = value; }
    readonly FloorStateMachine floorState = new();
    readonly PortalJumpGraph portalJumps = new();
    readonly PortalUnlockGraph portalUnlocks = new();
    // 包含已经交互过的传送门，以及刚刚落地的传送门。
    // 传送目的地不能立即再次触发，否则一对传送门可能永远在 A -> B -> A 之间往返。
    readonly HashSet<Cell> attemptedRoomPortals = [];
    FloorPhase floorPhase { get => floorState.Current; set => floorState.Transition(value); }
    int observedLevel = -1, portalConfirmCount;
    int routeRecoveryUsed;
    long floorChangedAt;
    Cell? lastAcceptedPlayerCell;
    long lastAcceptedPlayerAt;
    readonly Random random = new();
    TargetKey? portalCandidate;
    bool runeSelectionVisible;
    NextFloorDialogKind pendingNextFloorDialog;
    bool pendingGreedySelectionReturnOnly;
    bool serverErrorDialogVisible;
    volatile bool popupHandling;
    // 启动预检和移动 watchdog 不能同时抢占截图/OCR 管线。
    // 预检完成后立即释放该门控，避免把 watchdog 整个运行期关闭。
    volatile bool startupPreparing;
    int runeSelectionCard = -1;
    int runeSelectionClickAttempts;
    int runeSelectionMisses;
    long runeSelectionLastClickAt;
    long runeSelectionStartedAt;
    long portalDialogPausedMs;
    long roomPortalInteractionAt;
    TargetKey? pendingRoomPortal;
    Cell? roomPortalOrigin;
    bool portalInteractionBlockedByGem;
    long portalInteractionAt;
    readonly CoroutineRunner coroutines = new();
    Coroutine? portalChoiceCoroutine;
    bool pulseFallbackNavigation;
    bool shortcutDeferredByTargets;
    bool targetFloorStopped;
    int floorMiningCompletedLevel = -1;
    int floorMiningSkippedLevel = -1;
    // 游戏原始单位/秒；游戏会将其除以 1000，得到每个地图格的单位数。
    double currentMoveSpeed = 1000;
    int clickNavigationVersion;
    readonly EntryTemplateStore entryTemplates = new(Path.Combine(AppContext.BaseDirectory, "entry-templates.json"));
    MiniMapForm? miniMapForm;
    bool miniWindowMode;
    ThemePalette currentPalette = ThemePalette.Light;
    bool applyingTheme;

    static CheckBox Box(string text) => new ThemedCheckBox { Text = text, AutoSize = true };
    static Button Btn(string text, ThemeRole role) => new()
    {
        Text = text,
        AutoSize = true,
        FlatStyle = FlatStyle.Flat,
        Tag = role,
    };
    static readonly string[] BonusKinds = ["增益效果", "魔法材料", "回复药剂", "道具"];
    // 换层弹窗有入场动画，不能在一次截图失败后直接按三选一坐标盲点。
    // 每轮按固定顺序检查三类换层界面，全部未识别时短暂等待后持续重试。
    const int PortalDialogRetryDelayMs = 160;

    public MainForm()
    {
        touch = new TouchController(adb);
        pipelineWebServer = new(
            Path.Combine(AppContext.BaseDirectory, "pipeline-traces"),
            Path.Combine(AppContext.BaseDirectory, "web"));
        touch.InputFailed += ex => { runCts?.Cancel(); entryCts?.Cancel(); Error(ex); };
        Text = "洞窟地图 ADB 控制器"; Width = 946; Height = 643; MinimumSize = new(946, 643);
        AutoScaleMode = AutoScaleMode.Dpi;
        Font = new Font("Segoe UI", 9F, FontStyle.Regular, GraphicsUnit.Point);
        attackBoss.Checked = true;
        themeChoice.Items.AddRange(["浅色", "深色", "跟随系统"]);
        themeChoice.SelectedIndex = 0;
        entryDifficulty.Items.AddRange(["普通", "精英", "噩梦"]);
        entryDifficulty.SelectedIndex = (int)DungeonDifficulty.Normal;
        bonusPriority.Items.AddRange(BonusKinds); bonusPriority.SelectedIndex = 0;
        entryMapChoice.Items.AddRange(DungeonEntryCatalog.Maps.Select(x => x.Name).Cast<object>().ToArray());
        entryChoice.Items.AddRange(DungeonEntryCatalog.EntriesForMap(DungeonEntryCatalog.TimeGateMapId).Select(x => x.Name).Cast<object>().ToArray());
        entryMapChoice.SelectedIndex = 0; entryChoice.SelectedIndex = 0;
        entryMapChoice.SelectedIndexChanged += (_, _) =>
        {
            var selectedEntryId = Math.Max(1, entryChoice.SelectedIndex + 1);
            var map = SelectedEntryMap;
            entryChoice.Items.Clear();
            entryChoice.Items.AddRange(DungeonEntryCatalog.EntriesForMap(map.Id)
                .Select(x => x.Name).Cast<object>().ToArray());
            entryChoice.SelectedIndex = Math.Clamp(selectedEntryId - 1, 0, Math.Max(0, entryChoice.Items.Count - 1));
            entryDifficulty.Enabled = map.SupportsDifficulty;
            if (!map.SupportsDifficulty) entryDifficulty.SelectedIndex = (int)DungeonDifficulty.Normal;
        };
        LoadSettings();
        TopMost = alwaysOnTop.Checked;
        UpdateBonusPriorityCaption();
        bonusPriorityPopup.Items.Add(new ToolStripControlHost(bonusPriority)
        {
            AutoSize = false,
            Margin = Padding.Empty,
            Padding = Padding.Empty,
            Size = bonusPriority.Size,
            BackColor = bonusPriority.BackColor
        });
        bonusPriorityPopup.Size = new Size(
            bonusPriority.Width + bonusPriorityPopup.Padding.Horizontal,
            bonusPriority.Height + bonusPriorityPopup.Padding.Vertical);
        bonusPriority.MouseDown += (_, e) => { if (e.Button == MouseButtons.Left && bonusPriority.IndexFromPoint(e.Location) >= 0) bonusPriority.DoDragDrop(bonusPriority.IndexFromPoint(e.Location), DragDropEffects.Move); };
        bonusPriority.DragOver += (_, e) => e.Effect = DragDropEffects.Move;
        bonusPriority.DragDrop += (_, e) => { var from = (int)e.Data!.GetData(typeof(int))!; var to = bonusPriority.IndexFromPoint(bonusPriority.PointToClient(new Point(e.X, e.Y))); if (to < 0) to = bonusPriority.Items.Count - 1; var item = bonusPriority.Items[from]; bonusPriority.Items.RemoveAt(from); bonusPriority.Items.Insert(to, item); bonusPriority.SelectedIndex = to; SaveSettings(); };
        var top = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink,
            Padding = new(10, 8, 10, 6), WrapContents = true, Tag = ThemeRole.Surface };
        var scan = Btn("扫描设备", ThemeRole.SecondaryButton); var refresh = Btn("刷新地图", ThemeRole.SecondaryButton);
        var plan = Btn("规划路线", ThemeRole.InfoButton); var start = Btn("开始", ThemeRole.SuccessButton); var pause = Btn("暂停", ThemeRole.WarningButton); var step = Btn("单步", ThemeRole.InfoButton); var stop = Btn("急停", ThemeRole.DangerButton);
        var autoEnter = Btn("识图自动进图", ThemeRole.SuccessButton); var calibrateEntry = Btn("更新入口模板", ThemeRole.UtilityButton);
        var miniWindow = Btn("小窗口", ThemeRole.SecondaryButton); var openWebMonitor = Btn("Web监控", ThemeRole.InfoButton);
        var detectAssistant = Btn("检测助手", ThemeRole.UtilityButton); var installAssistant = Btn("安装助手", ThemeRole.UtilityButton); var restoreAssistant = Btn("恢复原版", ThemeRole.DangerButton); var openTestPanel = Btn("打开测试面板", ThemeRole.WarningButton);
        var mine = Btn("挖矿", ThemeRole.WarningButton);
        top.Controls.AddRange([refresh, plan, start, mine, pause, step, stop, autoEnter, calibrateEntry, miniWindow, openWebMonitor, alwaysOnTop]);
        var settingsTop = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink,
            Padding = new(10, 8, 10, 6), WrapContents = true, Tag = ThemeRole.Surface };
         settingsTop.Controls.AddRange([new Label { Text = "设备", AutoSize = true, Padding = new(0, 6, 0, 0) }, devices, scan, detectAssistant, installAssistant, restoreAssistant, openTestPanel, assistantState,
            new Label { Text = "主题", AutoSize = true, Padding = new(10, 6, 0, 0) }, themeChoice]);
        var options = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink, Padding = new(10, 9, 10, 4), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        options.Controls.AddRange([new Label { Text = "目标（钥匙必选）：", AutoSize = true }, attackBoss, monsters, elites, chests, pots, bones, gold, runes, chambers, bonusPriorityToggle]);
        var floorStop = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink, Padding = new(10, 4, 10, 4), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        floorStop.Controls.AddRange([new Label { Text = "指定层停住：", AutoSize = true }, targetStopFloor, new Label { Text = "层（0=关闭，完成所选目标后自动停住）", AutoSize = true }, mining, cardMining, cardLayer]);
        var entryOptions = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink, Padding = new(10, 4, 10, 4), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        entryOptions.Controls.AddRange([new Label { Text = "自动进图：", AutoSize = true }, entryMapChoice, entryChoice, entryDifficulty, new Label { Text = "入口识别：内置图标或当前地图场景模板", AutoSize = true, Padding = new(4, 5, 0, 0), Tag = ThemeRole.WarningText }]);
        var timing = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink, Padding = new(10, 7, 10, 5), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        timing.Controls.AddRange([new Label { Text = "时间参数：", AutoSize = true }, new Label { Text = "单格脉冲按住(ms)", AutoSize = true }, singleCellPulseHold, new Label { Text = "提前/延迟松开(ms)", AutoSize = true }, movementReleaseLead, new Label { Text = "交互按住(ms)", AutoSize = true }, interactionHold, new Label { Text = "卡住超时(ms)", AutoSize = true }, stallTimeout, new Label { Text = "新层启动延迟(ms)", AutoSize = true }, newFloorStartDelay, new Label { Text = "规划容错次数", AutoSize = true }, routeRecoveryAttempts]);
        var split = new SplitContainer
        {
            Dock = DockStyle.Fill,
            Orientation = Orientation.Vertical,
            SplitterDistance = 760,
            SplitterWidth = 1,
            BorderStyle = BorderStyle.None,
            Tag = ThemeRole.Default,
        };
        split.Panel1.Controls.Add(mapPanel); split.Panel2.Controls.Add(log);
        var runPage = new ThemedTabPage { Text = "运行", Padding = new(0), Tag = ThemeRole.Default };
        runPage.Controls.Add(split); runPage.Controls.Add(top);
        var settingsPage = new ThemedTabPage { Text = "设置", Padding = new(0), Tag = ThemeRole.Default };
        settingsPage.Controls.Add(CreateMiningSettings());
        settingsPage.Controls.Add(timing); settingsPage.Controls.Add(floorStop); settingsPage.Controls.Add(entryOptions); settingsPage.Controls.Add(options); settingsPage.Controls.Add(settingsTop);
        var tabs = new ThemedTabControl { Dock = DockStyle.Fill, Tag = ThemeRole.Default };
        tabs.TabPages.Add(runPage); tabs.TabPages.Add(settingsPage);
        Controls.Add(tabs);
        scan.Click += async (_, _) => await RunUi(Scan); refresh.Click += async (_, _) => await RunUi(() => RefreshMap()); plan.Click += async (_, _) => await RunUi(Replan); start.Click += async (_, _) => await RunUi(StartRun); pause.Click += async (_, _) => await RunUi(async () => { await StopMovement(); State("已暂停"); }); step.Click += async (_, _) => await RunUi(Step); stop.Click += async (_, _) => await RunUi(EmergencyStopAndClear);
        autoEnter.Click += async (_, _) => await RunUi(AutoEnter); calibrateEntry.Click += async (_, _) => await RunUi(CalibrateEntry);
        mine.Click += async (_, _) => await RunUi(StartMining);
        miniWindow.Click += (_, _) => ToggleMiniWindowMode();
        openWebMonitor.Click += (_, _) => OpenPipelineWebMonitor();
        alwaysOnTop.CheckedChanged += (_, _) => { ApplyAlwaysOnTop(); SaveSettings(); };
         detectAssistant.Click += async (_, _) => await RunUi(DetectAssistant); installAssistant.Click += async (_, _) => await RunUi(InstallAssistant); restoreAssistant.Click += async (_, _) => await RunUi(RestoreAssistant); openTestPanel.Click += async (_, _) => await RunUi(OpenTestPanel);
        bonusPriorityToggle.Click += (_, _) =>
        {
            if (bonusPriorityPopup.Visible)
            {
                bonusPriorityPopup.Close();
                return;
            }

            UpdateBonusPriorityCaption();
            var popupLocation = bonusPriorityToggle.PointToScreen(new Point(0, bonusPriorityToggle.Height));
            bonusPriorityPopup.Show(popupLocation);
            bonusPriority.Focus();
        };
        bonusPriority.SelectedIndexChanged += (_, _) => UpdateBonusPriorityCaption();
        themeChoice.SelectedIndexChanged += (_, _) =>
        {
            if (applyingTheme) return;
            ApplyTheme();
            SaveSettings();
        };
        SystemEvents.UserPreferenceChanged += OnUserPreferenceChanged;
        ApplyTheme();
        mapPanel.CellClicked += async (_, e) => await RunMapClick(e.Cell);
        devices.SelectionChangeCommitted += async (_, _) =>
        {
            if (closing || string.IsNullOrWhiteSpace(devices.Text)) return;
            await RunUi(() => ConnectDeviceAsync(devices.Text));
        };
        refreshTimer.Tick += async (_, _) =>
        {
            // This is a background snapshot, not a user operation. Going
            // through RunUi would toggle the device ComboBox Enabled state
            // every 500 ms and make the selector visibly flicker.
            if (runCts is null && activeEntry is null && uiOperations.Count == 0)
                await RefreshMap(false, lockDeviceSelection: false);
        }; Shown += async (_, _) => await RunUi(async () => { await Scan(); await RefreshMap(); if (!closing) refreshTimer.Start(); });
        foreach (var control in new Control[] { attackBoss, monsters, elites, chests, pots, bones, gold, runes, chambers, bonusPriority, singleCellPulseHold, movementReleaseLead, interactionHold, stallTimeout, newFloorStartDelay, routeRecoveryAttempts, targetStopFloor, mining, cardMining, cardLayer, entryMapChoice, entryChoice, entryDifficulty })
            control.Validated += (_, _) => SaveSettings();
        foreach (var control in new Control[] { attackBoss, monsters, elites, chests, pots, bones, gold, runes, chambers })
        {
            control.Validated += (_, _) => targetFloorStopped = false;
            if (control is CheckBox checkBox) checkBox.CheckedChanged += (_, _) => targetFloorStopped = false;
        }
        foreach (var control in new Control[] { targetStopFloor })
            control.Validated += (_, _) => targetFloorStopped = false;
        targetStopFloor.ValueChanged += (_, _) => targetFloorStopped = false;
        mining.CheckedChanged += (_, _) => targetFloorStopped = false;
        cardMining.CheckedChanged += (_, _) => targetFloorStopped = false;
        cardLayer.CheckedChanged += (_, _) => targetFloorStopped = false;
        try
        {
            pipelineWebServer.Start();
            Log($"MAA Pipeline 本地 Web 监控已启动：{pipelineWebServer.Url}");
        }
        catch (Exception ex)
        {
            Log($"MAA Pipeline 本地 Web 监控启动失败：{ex.Message}");
        }
        FormClosing += async (_, e) =>
        {
            if (closeReady) return;
            e.Cancel = true;
            await ShutdownAsync();
        };
    }

    internal Task ShutdownAsync() => shutdownTask ??= ShutdownCore();

    async Task ShutdownCore()
    {
        closing = true; Enabled = false; refreshTimer.Stop(); SaveSettings();
        miniWindowMode = false;
        if (miniMapForm is { IsDisposed: false }) miniMapForm.CloseFromOwner();
        // 移动任务失败时不能跳出异步 FormClosing 事件，
        // 也不能跳过 ADB Shell 的释放。
        try { await StopMovement(); } catch (Exception ex) { Error(ex); }
        try { await Task.WhenAll(uiOperations.ToArray()); } catch (Exception ex) { Error(ex); }
        await refreshLock.WaitAsync();
        try
        {
            try { touch.Dispose(); } catch (Exception ex) { Error(ex); }
            try { adb.Dispose(); } catch (Exception ex) { Error(ex); }
            try { await pipelineWebServer.DisposeAsync(); } catch (Exception ex) { Error(ex); }
        }
        finally { refreshLock.Release(); }
        refreshTimer.Dispose();
        closeReady = true;
        Close();
    }
    void UpdateDeviceAvailability() => devices.Enabled = !closing && uiOperations.Count == 0
        && !scanning && activeMovement is not { IsCompleted: false } && activeEntry is not { IsCompleted: false };

    async Task RunUi(Func<Task> action)
    {
        if (closing) return;
        Task? operation = null;
        devices.Enabled = false;
        try
        {
            operation = action();
            uiOperations.Add(operation);
            await operation;
        }
        catch (Exception ex) { Error(ex); }
        finally
        {
            if (operation is not null) uiOperations.Remove(operation);
            UpdateDeviceAvailability();
        }
    }

    void UpdateBonusPriorityCaption()
    {
        var order = bonusPriority.Items.Cast<string>().ToArray();
        bonusPriorityToggle.Text = order.Length > 0 ? $"加成：{order[0]}（点击调整）" : "加成优先级";
    }

    void OpenPipelineWebMonitor()
    {
        if (string.IsNullOrWhiteSpace(pipelineWebServer.Url))
        {
            Log("MAA Pipeline 本地 Web 监控不可用");
            return;
        }

        try
        {
            Process.Start(new ProcessStartInfo(pipelineWebServer.Url) { UseShellExecute = true });
            Log($"已打开 MAA Pipeline Web 监控：{pipelineWebServer.Url}");
        }
        catch (Exception ex) { Error(ex); }
    }

    static string SettingsPath => Path.Combine(AppContext.BaseDirectory, "settings.json");
    ThemeMode CurrentThemeMode => (ThemeMode)Math.Clamp(themeChoice.SelectedIndex, 0, 2);
    DungeonMapOption SelectedEntryMap => DungeonEntryCatalog.Maps[Math.Clamp(
        entryMapChoice.SelectedIndex, 0, DungeonEntryCatalog.Maps.Count - 1)];

    void ApplyTheme()
    {
        if (IsDisposed || Disposing) return;
        applyingTheme = true;
        try
        {
            currentPalette = ThemePalette.Resolve(CurrentThemeMode);
            ThemeManager.Apply(this, currentPalette);
            ThemeManager.Apply(bonusPriorityPopup, currentPalette);
            mapPanel.ApplyTheme(currentPalette);
            state.ForeColor = currentPalette.AccentText;
            warningState.ForeColor = currentPalette.WarningText;
            stats.ForeColor = currentPalette.MutedText;
            assistantState.ForeColor = currentPalette.WarningText;
            if (miniMapForm is { IsDisposed: false }) miniMapForm.ApplyTheme(currentPalette);
        }
        finally { applyingTheme = false; }
    }

    void OnUserPreferenceChanged(object? sender, UserPreferenceChangedEventArgs e)
    {
        if (CurrentThemeMode != ThemeMode.System || IsDisposed || Disposing) return;
        if (!IsHandleCreated) return;
        try { BeginInvoke(ApplyTheme); } catch (InvalidOperationException) { }
    }

    void LoadSettings()
    {
        var s = SettingsStore.Load(SettingsPath);
        if (s is null) return;
        themeChoice.SelectedIndex = Math.Clamp((int)s.Theme, 0, 2);
        alwaysOnTop.Checked = s.AlwaysOnTop;
        attackBoss.Checked = s.AttackBoss; monsters.Checked = s.Monsters; elites.Checked = s.Elites; chests.Checked = s.Chests; pots.Checked = s.Pots;
        bones.Checked = s.Bones; gold.Checked = s.Gold; runes.Checked = s.Runes; chambers.Checked = s.Chambers;
        SetValue(singleCellPulseHold, s.SingleCellPulseHold); SetValue(movementReleaseLead, s.MovementReleaseLead);
        SetValue(interactionHold, s.InteractionHold); SetValue(stallTimeout, s.StallTimeout); SetValue(newFloorStartDelay, s.NewFloorStartDelay); SetValue(routeRecoveryAttempts, s.RouteRecoveryAttempts);
        SetValue(targetStopFloor, s.TargetStopFloor); cardLayer.Checked = s.CardLayer;
        mining.Checked = s.Mining; cardMining.Checked = s.CardMining;
        SetValue(miningTileWidth, s.MiningTileWidth); SetValue(miningTileHeight, s.MiningTileHeight); SetValue(miningInterval, s.MiningInterval);
        var savedMapId = s.EntryMapId;
        var savedEntryId = s.EntryId;
        // 旧版本把时光之门英雄图存成普通时光之门的第 19～24 个节点，
        // 迁移到独立的“时光之门(英雄)”地图选项。
        if (savedMapId == DungeonEntryCatalog.TimeGateMapId && savedEntryId is >= 19 and <= 24)
        {
            savedMapId = DungeonEntryCatalog.TimeGateHeroMapId;
            savedEntryId -= 18;
        }
        var savedMapIndex = DungeonEntryCatalog.Maps
            .Select((map, index) => (map, index))
            .FirstOrDefault(x => x.map.Id == savedMapId).index;
        entryMapChoice.SelectedIndex = Math.Clamp(savedMapIndex, 0, Math.Max(0, entryMapChoice.Items.Count - 1));
        entryChoice.SelectedIndex = Math.Clamp(savedEntryId - 1, 0, Math.Max(0, entryChoice.Items.Count - 1));
        var entryDifficultyIndex = Math.Clamp((int)s.EntryDifficulty, (int)DungeonDifficulty.Normal, (int)DungeonDifficulty.Nightmare);
        if (entryDifficultyIndex == (int)DungeonDifficulty.Normal && s.EntryEliteMode)
            entryDifficultyIndex = (int)DungeonDifficulty.Elite;
        entryDifficulty.SelectedIndex = entryDifficultyIndex;
        if (s.BonusPriority is { Count: > 0 } && s.BonusPriority.All(x => BonusKinds.Contains(x))) { bonusPriority.Items.Clear(); bonusPriority.Items.AddRange(s.BonusPriority.Concat(BonusKinds.Where(x => !s.BonusPriority.Contains(x))).ToArray()); bonusPriority.SelectedIndex = 0; }
        if (!string.IsNullOrWhiteSpace(s.Device)) devices.Text = s.Device;
    }
    static void SetValue(ThemedNumericUpDown control, decimal value)
        => control.Value = Math.Clamp(value, control.Minimum, control.Maximum);
    void SaveSettings()
    {
        var s = new ControllerSettings { Theme = CurrentThemeMode, AlwaysOnTop = alwaysOnTop.Checked, AttackBoss = attackBoss.Checked, Monsters = monsters.Checked, Elites = elites.Checked, Chests = chests.Checked,
            Pots = pots.Checked, Bones = bones.Checked, Gold = gold.Checked, Runes = runes.Checked, Chambers = chambers.Checked,
            SingleCellPulseHold = singleCellPulseHold.Value, MovementReleaseLead = movementReleaseLead.Value,
            MiningTileWidth = miningTileWidth.Value, MiningTileHeight = miningTileHeight.Value, MiningInterval = miningInterval.Value,
            InteractionHold = interactionHold.Value, StallTimeout = stallTimeout.Value, NewFloorStartDelay = newFloorStartDelay.Value, RouteRecoveryAttempts = routeRecoveryAttempts.Value,
            TargetStopFloor = (int)targetStopFloor.Value, CardLayer = cardLayer.Checked,
            Mining = mining.Checked, CardMining = cardMining.Checked,
            EntryMapId = SelectedEntryMap.Id, EntryId = Math.Max(1, entryChoice.SelectedIndex + 1),
            EntryDifficulty = (DungeonDifficulty)Math.Clamp(entryDifficulty.SelectedIndex, (int)DungeonDifficulty.Normal, (int)DungeonDifficulty.Nightmare),
            EntryEliteMode = entryDifficulty.SelectedIndex == (int)DungeonDifficulty.Elite,
            Device = devices.Text, BonusPriority = bonusPriority.Items.Cast<string>().ToList() };
        SettingsStore.Save(SettingsPath, s);
    }

    void ResetDeviceState()
    {
        currentMap = null; mapPanel.Map = null; routeSession.Clear();
        blocked.Clear(); mechanismState.Reset(); interactedChambers.Clear();
        confirmedCompletedTargets.Clear(); expectedTaskRoadChanges.Clear();
        observedLevel = -1; currentMoveSpeed = 1000; lastAcceptedPlayerCell = null;
        floorPhase = FloorPhase.Explore; portalCandidate = null; targetFloorStopped = false;
        floorMiningCompletedLevel = -1;
        floorMiningSkippedLevel = -1;
        portalJumps.Clear(); portalUnlocks.Clear();
        attemptedRoomPortals.Clear(); pendingRoomPortal = null; roomPortalOrigin = null; roomPortalInteractionAt = 0;
        ClearRiftGemSelectionState();
        serverErrorDialogVisible = false;
        pendingNextFloorDialog = NextFloorDialogKind.None;
        pendingGreedySelectionReturnOnly = false;
        mapPanel.Invalidate();
    }

    async Task ConnectDeviceAsync(string deviceSerial)
    {
        if (string.IsNullOrWhiteSpace(deviceSerial)) return;
        var alreadyConnected = adb.Serial == deviceSerial && adb.IsTouchReady;
        if (adb.Serial != deviceSerial) ResetDeviceState();

        var directRoot = await adb.ConnectAsync(deviceSerial);
        if (!alreadyConnected)
        {
            Log((directRoot ? "ADB 已切换为直接 Root 模式，不再调用 su" : "设备不支持 Root ADB，使用持续 su 会话") +
                $"；触摸设备 {adb.TouchDescription}");
            State("设备已连接");
        }
    }

    void ApplyAlwaysOnTop()
    {
        TopMost = alwaysOnTop.Checked;
        if (miniMapForm is { IsDisposed: false }) miniMapForm.TopMost = alwaysOnTop.Checked;
    }

    void ToggleMiniWindowMode()
    {
        if (closing) return;
        if (miniWindowMode)
        {
            ExitMiniWindowMode();
            return;
        }

        miniMapForm ??= new MiniMapForm(
            () => currentMap,
            () => route,
            () => alwaysOnTop.Checked,
            value => SetAlwaysOnTop(value),
            ExitMiniWindowMode);
        miniMapForm.ApplyTheme(currentPalette);

        if (miniMapForm.WindowState == FormWindowState.Minimized)
            miniMapForm.WindowState = FormWindowState.Normal;
        miniWindowMode = true;
        miniMapForm.ShowMini();
        var area = Screen.FromPoint(Cursor.Position).WorkingArea;
        miniMapForm.Location = new Point(
            Math.Max(area.Left, area.Right - miniMapForm.Width - 8),
            Math.Max(area.Top, area.Bottom - miniMapForm.Height - 8));
        Hide();
    }

    void ExitMiniWindowMode()
    {
        if (closing) return;
        miniWindowMode = false;
        SetAlwaysOnTop(false);
        if (miniMapForm is { IsDisposed: false }) miniMapForm.Hide();
        Show();
        Activate();
    }

    void SetAlwaysOnTop(bool value)
    {
        if (alwaysOnTop.Checked != value) alwaysOnTop.Checked = value;
        else
        {
            ApplyAlwaysOnTop();
            SaveSettings();
        }
    }

    static string AssistantFile(string name) => Path.Combine(AppContext.BaseDirectory, "assistant", name);
    async Task DetectAssistant()
    {
        try
        {
            adb.Serial = devices.Text; var s = await adb.GetAssistantStatus(AssistantFile("MiniMapDrawer.template.lua"));
            assistantState.Text = s.Installed ? $"助手已安装  备份:{(s.BackupExists ? "有" : "无")}  测试面板:{(s.TestPanelSupported ? "支持" : "需重装")}" : $"助手未安装  备份:{(s.BackupExists ? "有" : "无")}";
            assistantState.ForeColor = s.Installed ? currentPalette.SuccessText : currentPalette.WarningText;
            Log($"助手检测：{assistantState.Text.Trim()}，目标 {s.Target}，当前 {s.CurrentHash[..12]}，格式 {s.Format}");
        }
        catch (Exception ex) { Error(ex); }
    }
    async Task InstallAssistant()
    {
        if (MessageBox.Show("将先备份原文件，再以 Root 权限写入地图助手。游戏需重启后生效。继续吗？", "安装地图助手", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) != DialogResult.Yes) return;
        try { adb.Serial = devices.Text; await adb.InstallAssistant(AssistantFile("MiniMapDrawer.template.lua")); Log("已读取设备当前 Lua 源码、注入并按原格式加密校验；请重启游戏"); await DetectAssistant(); }
        catch (Exception ex) { Error(ex); }
    }
    async Task RestoreAssistant()
    {
        if (MessageBox.Show("将用设备端备份恢复原版文件。游戏需重启后生效。继续吗？", "恢复原版", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) != DialogResult.Yes) return;
        try { adb.Serial = devices.Text; await adb.RestoreAssistant(AssistantFile("MiniMapDrawer.template.lua")); Log("原版文件已恢复；请重启游戏"); await DetectAssistant(); }
        catch (Exception ex) { Error(ex); }
    }
    async Task OpenTestPanel()
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) { Log("打开测试面板失败：尚未选择设备"); return; }
        if (activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false })
        {
            Log("打开测试面板失败：请先暂停或停止自动运行");
            MessageBox.Show("请先暂停或停止自动运行，再打开测试面板。", "打开测试面板", MessageBoxButtons.OK, MessageBoxIcon.Information);
            return;
        }
        try
        {
            adb.Serial = devices.Text;
            var status = await adb.GetAssistantStatus(AssistantFile("MiniMapDrawer.template.lua"));
            if (!status.Installed)
            {
                Log("打开测试面板失败：地图助手未安装");
                MessageBox.Show("请先安装地图助手并重启游戏。", "打开测试面板", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (!status.TestPanelSupported)
            {
                Log("打开测试面板失败：当前设备上的助手版本不支持，请重新安装助手并重启游戏");
                MessageBox.Show("当前设备上的助手版本不支持该功能，请重新安装助手并重启游戏。", "打开测试面板", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            await adb.RequestOpenTestPanel();
            Log("已请求打开测试面板；游戏将在助手脚本下一次轮询时打开，请确认游戏已重启并加载助手");
        }
        catch (Exception ex) { Error(ex); }
    }

    async Task Scan()
    {
        if (closing || stopping || scanning || activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false }) return;
        scanning = true;
        await refreshLock.WaitAsync();
        try
        {
            var found = await adb.Devices();
            if (closing || activeMovement is { IsCompleted: false }) return;

            var currentSerial = adb.Serial;
            var currentStillPresent = found.Contains(currentSerial, StringComparer.Ordinal);
            if (adb.IsTouchReady && !currentStillPresent)
            {
                adb.Disconnect();
                ResetDeviceState();
            }

            devices.Items.Clear();
            devices.Items.AddRange(found.Cast<object>().ToArray());
            if (found.Count > 0)
            {
                var selected = currentStillPresent ? currentSerial : found[0];
                devices.SelectedItem = selected;
                await ConnectDeviceAsync(selected);
            }
            else
            {
                adb.Disconnect();
                ResetDeviceState();
                State("设备 0");
                return;
            }
            State($"设备 {found.Count}");
        }
        catch (Exception ex) { Error(ex); }
        finally { scanning = false; refreshLock.Release(); }
    }

    async Task<bool> RefreshMap(bool writeLog = true, bool waitForLock = false, Action? onMapReady = null, bool lockDeviceSelection = true)
    {
        if (closing || activeEntry is { IsCompleted: false }) return false;
        // WinForms Timer 不会等待异步 Tick 处理程序。如果 ADB 卡住，
        // 过去每 500 毫秒就会启动一次新的刷新，每次都可能留下一个
        // adb screencap 进程，直到 Windows 耗尽提交内存。
        // 刷新只是获取快照，因此应跳过重叠请求，而不是排队形成不断增长的积压。
        if (waitForLock) await refreshLock.WaitAsync();
        else if (!await refreshLock.WaitAsync(0)) return false;
        if (lockDeviceSelection) devices.Enabled = false;
        try { return await RefreshMapCore(writeLog, onMapReady); }
        finally { refreshLock.Release(); UpdateDeviceAvailability(); }
    }

    async Task<bool> RefreshMapCore(bool writeLog, Action? onMapReady)
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) return false;
        adb.Serial = devices.Text;
        if (onMapReady is not null)
        {
            var ready = await NavigationStartup.PrepareAsync(
                () => RefreshMapSnapshot(writeLog), () => RefreshOverlayState(writeLog, failSafe: true),
                onMapReady, runCts?.Token ?? default);
            if (!ready || runeSelectionVisible) return ready;

            // OCR 在冷启动时可能耗时数秒。在允许输入前只重新读取开销较低的
            // 地图/玩家导出数据，不再执行另一轮 OCR。如果期间玩家或目标发生变化，
            // 则重新计算。
            var planned = MapSnapshot.Capture(currentMap!);
            if (!await RefreshMapSnapshot(false)) return false;
            var latest = routeSession.Snapshot!;
            if (planned.Level != latest.Level || planned.Player != latest.Player ||
                planned.StructureHash != latest.StructureHash ||
                planned.Map.BossSeal.Ready != latest.Map.BossSeal.Ready ||
                planned.Map.BossSeal.CurScore != latest.Map.BossSeal.CurScore)
                onMapReady();
            return true;
        }

        // 普通启动/刷新只读取并提交地图。弹窗检查属于“开始”动作的
        // 安全预检，不应在控制器刚打开或定时刷新时启动 OCR。
        return await RefreshMapSnapshot(writeLog);
    }

    void LogOverlayUnknown()
    {
        var now = Environment.TickCount64;
        if (now - Interlocked.Read(ref lastOverlayUnknownLogAt) < 2000) return;
        Interlocked.Exchange(ref lastOverlayUnknownLogAt, now);
        Log("弹窗状态未知");
    }

    async Task<bool> RefreshOverlayState(bool writeLog, bool failSafe = false)
    {
        // 点击“开始”后的路线预检先检查会拦截触摸的覆盖层。
        // 转场或刚打开的弹窗可能会短暂地使这些文件不可用；
        // 弹窗处理仍必须能够继续。
        try
        {
            adb.Serial = devices.Text;
            // 在同一帧检查两个覆盖层，避免重复截图。
            var frameId = adb.NextPopupFrameId();
            using var screen = await adb.CaptureMovementPopupFrameAsync(frameId, runCts?.Token ?? default);
            var runPopupPipeline = writeLog || runeSelectionVisible;
            var popup = MovementPopupKind.None;
            PopupUiPipelineResult? popupPipeline = null;
            if (runPopupPipeline)
            {
                popupPipeline = await adb.RunPopupUiPipelineAsync(screen, frameId);
                popup = popupPipeline.Value;
            }
            else if (await adb.HasServerErrorDialog(screen))
            {
                popup = MovementPopupKind.ServerError;
            }

            if (popup == MovementPopupKind.ServerError)
            {
                if (!serverErrorDialogVisible)
                    Log("检测到服务器连接异常弹窗，已停止运行；请重新进入游戏");
                serverErrorDialogVisible = true;
                await touch.EmergencyRelease();
                runCts?.Cancel();
                State("服务器连接异常，已停止运行");
                return false;
            }
            serverErrorDialogVisible = false;

            // 用户按下开始时，游戏可能停留在居中的“是否进入下一层？”对话框上。
            // 在同一次启动覆盖层检查中识别它，避免过期的地图传送门路线在模态框下方
            // 发送移动输入。交由 SelectBonus 接管后，下面的协程会实际点击按钮并执行
            // 确认循环。
            if (writeLog && floorPhase is not (FloorPhase.SelectBonus or FloorPhase.VerifyTransition) &&
                popup == MovementPopupKind.NextFloorDialog)
            {
                var nextFloorDialog = popupPipeline?.NextFloorDialog ?? NextFloorDialogKind.None;
                if (nextFloorDialog != NextFloorDialogKind.None)
                {
                    pendingNextFloorDialog = nextFloorDialog;
                    pendingGreedySelectionReturnOnly = popupPipeline?.GreedySelectionReturnOnly ?? false;
                    floorPhase = FloorPhase.SelectBonus;
                    portalInteractionAt = portalInteractionAt > 0 ? portalInteractionAt : Environment.TickCount64;
                    portalDialogPausedMs = 0;
                    runeSelectionVisible = false;
                    Log($"启动时检测到换层界面：{nextFloorDialog}，暂停路线并接管弹窗");
                    State("检测到换层弹窗，暂停移动等待处理");
                    return true;
                }
            }

            RefreshRiftSelectionState(writeLog, popup == MovementPopupKind.RiftGemSelection);
            if (writeLog)
            {
                if (popupPipeline is not null)
                    Log($"弹窗管线诊断：结果 {popupPipeline.Value}，节点 {popupPipeline.NodeName ?? "无匹配"}，" +
                        $"节点={popupPipeline.AttemptSummary}，OCR全屏={PopupUiPipelineResult.SummarizeText(popupPipeline.FullFrameText)}");
                Log($"秘境宝石选择 本帧命中={(popup == MovementPopupKind.RiftGemSelection ? "是" : "否")}，" +
                    $"锁存={(runeSelectionVisible ? "是" : "否")}，宝石标题 {adb.GemTitleDetectionMode} {adb.LastRiftGemTitle ?? "--"}");
            }
            return true;
        }
        catch (Exception)
        {
            // 地图刷新不依赖弹窗识别；预检失败只记录状态未知，
            // 运行中的路线仍需停机，避免在模态框下发送移动输入。
            LogOverlayUnknown();
            if (!failSafe) return true;
            runCts?.Cancel();
            try { await touch.EmergencyRelease(); } catch { }
            State("弹窗状态未知，已停止运行");
            return false;
        }
    }

    async Task<bool> RefreshMapSnapshot(bool writeLog)
    {
        try
        {
            adb.Serial = devices.Text; var previousMap = currentMap; var map = await adb.ReadMap(); var player = await adb.ReadPlayer();
            // JSON 容错诊断仍会被收集，但暂时不在界面日志中输出，避免
            // 正常的默认值修正淹没移动和规划日志。
            _ = JsonDiagnostics.Drain();
            if (player.MoveSpeed > 0) currentMoveSpeed = player.MoveSpeed;
            RouteExecutor.ApplyPlayerStatus(map, player);
            if (previousMap is not null)
                foreach (var unlock in portalUnlocks.Observe(previousMap, map))
                    Log($"检测到传送门解锁：{unlock.Portal}，关联消失小怪 {string.Join(", ", unlock.DefeatedMonsters)}");
            if (pendingRoomPortal is { } roomPortal && previousMap is not null && roomPortalOrigin is { } origin &&
                map.Level == previousMap.Level && PortalJumpGraph.KeyOf(map) == PortalJumpGraph.KeyOf(previousMap))
            {
                var now = new Cell(map.Player.X, map.Player.Y);
                if (portalJumps.Observe(previousMap, roomPortal.Cell, map, out var destination, roomPortalOrigin))
                {
                    // 将落地传送门视为本楼层自动探索流程中已消耗。
                    // 这样可以防止下一次规划立即激活双传送门循环的反向边。
                    attemptedRoomPortals.Add(destination);
                    var sourceRole = previousMap.ByCell.TryGetValue(roomPortal.Cell, out var sourceTile)
                        ? sourceTile.Roles.FirstOrDefault(role => role.Kind == roomPortal.Kind)
                        : null;
                    var description = sourceRole is null ? "层内传送门" : PortalRouting.Describe(sourceRole);
                    Log($"层内传送已确认：{roomPortal.Cell} -> {destination}（{description}，已记录 {portalJumps.EdgeCount(map)} 条边）");
                    pendingRoomPortal = null; roomPortalOrigin = null; roomPortalInteractionAt = 0;
                }
                else if (now != origin && now != roomPortal.Cell)
                {
                    if (PortalRouting.NearestRoomPortal(map, now) is { } landingPortal)
                        attemptedRoomPortals.Add(landingPortal);
                    Log($"层内传送已发生：{roomPortal.Cell} -> {now}，落点附近没有可确认的传送门，保留当前位置重新寻路");
                    pendingRoomPortal = null; roomPortalOrigin = null; roomPortalInteractionAt = 0;
                }
            }
            mechanismState.ObserveLevel(map.Level);
            currentMap = map; routeSession.Snapshot = MapSnapshot.Capture(map); mapPanel.Map = map; mapPanel.Route = route; mapPanel.Invalidate();
            RecordMechanismVisit(map);
            var tiles = map.Tiles.SelectMany(x => x).Where(t => t.Walkable).ToList();
            var seal = map.BossSeal;
            var warning = seal.Present
                ? $"  预警 {seal.CurScore}/{seal.WakeScore} ({seal.Percent}%) {(seal.Ready ? "守层Boss可攻击" : "守层Boss未解锁")}" 
                : "  预警 --";
            warningState.Text = warning.Trim();
            warningState.ForeColor = seal.Present && seal.Ready ? currentPalette.SuccessText : currentPalette.WarningText;
            stats.Text = $"层 {map.Level}  人物 ({map.Player.X},{map.Player.Y})";
            mapPanel.InfoText = stats.Text;
            if (writeLog) Log("地图已刷新");
            return true;
        }
        catch (Exception ex) { if (writeLog) Error(ex); return false; }
    }

    void RefreshRiftSelectionState(bool writeLog, bool visible)
    {
        // 宝石选择覆盖层是真正会拦截触摸的 UI 层。
        // 新弹窗由独立的 PopupWatchdog 负责探测；这里仅在显式刷新或已经
        // 锁存为可见时用标题确认状态，避免路线循环反复启动整帧 OCR。
        var checkRunePopup = writeLog || runeSelectionVisible;
        if (!checkRunePopup) return;

        var wasVisible = runeSelectionVisible;
        if (visible)
        {
            LatchRiftGemSelection();
        }
        else if (wasVisible)
        {
            // PaddleOCR 在主进程中运行。连续两次未识别后才能判定覆盖层已关闭，
            // 否则单个慢帧可能会错误释放其下方的路线。
            runeSelectionMisses++;
            if (runeSelectionMisses >= 2)
            {
                if (runeSelectionStartedAt > 0)
                    portalDialogPausedMs += Math.Max(0, Environment.TickCount64 - runeSelectionStartedAt);
                Log("秘境宝石选择界面已关闭");
                runeSelectionVisible = false;
                runeSelectionMisses = 0;
                runeSelectionCard = -1;
                runeSelectionClickAttempts = 0;
                runeSelectionLastClickAt = 0;
                if (portalInteractionBlockedByGem)
                {
                    // 宝石覆盖层消耗了传送门点击。不要等待这次交互并未产生的转场对话框；
                    // 返回传送门并重试。
                    portalInteractionBlockedByGem = false;
                    floorPhase = FloorPhase.GoToPortal;
                    portalCandidate = null;
                    portalConfirmCount = 0;
                    route = [];
                    plannedInteractions = [];
                    plannedTargetUniverse.Clear();
                    mapPanel.Route = route;
                    mapPanel.Invalidate();
                    Log("秘境宝石选择已完成；传送门交互被遮挡，重新前往传送门");
                }
            }
        }
        else if (writeLog && !string.IsNullOrWhiteSpace(adb.LastRiftGemTitle))
        {
            Log($"秘境宝石标题未匹配：{adb.LastRiftGemTitle}");
        }
    }

    // SendInteraction 只会在规划器有意停在非战斗任务旁边后使用。
    // 穿过即可拾取的目标不会进入此路径。
    // 其持续时间应独立于移动速度和脉冲时序。
    static bool IsCombatInteraction(string kind) => kind is "小怪" or "群怪" or "精英" or "小Boss" or "Boss";
    Cell InputDelta(Cell desired)
        => currentMap is null ? desired : DirectionMapper.ApplyConfusion(desired, currentMap.Confused, currentMap.ConfuseDirections);
    async Task<bool> SendInteraction((Cell Delta, string Kind) interaction, CancellationToken ownerToken)
    {
        var duration = (int)interactionHold.Value;
        var interrupted = await RunMovementSlice(ownerToken,
            token => touch.HoldInteraction(InputDelta(interaction.Delta), duration, token));
        if (interrupted) return true;
        Log($"{interaction.Kind} 交互按住 {duration}ms（独立于人物速度）");
        return false;
    }

    async Task<bool> FightWhileHolding(PlannedInteraction task, CancellationToken ownerToken)
    {
        return await RunMovementSlice(ownerToken, token => FightWhileHoldingCore(task, token));
    }

    async Task FightWhileHoldingCore(PlannedInteraction task, CancellationToken token)
    {
        if (currentMap is null) return;
        var start = new Cell(currentMap.Player.X, currentMap.Player.Y);
        var delta = new Cell(task.Target.Cell.X - start.X, task.Target.Cell.Y - start.Y);
        var inputDelta = InputDelta(delta);
        if (Math.Abs(delta.X) + Math.Abs(delta.Y) != 1)
        {
            Log($"战斗停靠点失效：人物 {start}，目标 {task.Target.Cell}，等待重新规划");
            return;
        }

        State($"持续按住战斗 {task.Target.Kind}，方向 {delta.X},{delta.Y}");
        Log($"开始持续按住战斗：{start} -> {task.Target.Cell}");
        await touch.TouchDown(inputDelta, token);
        try
        {
            var startedAt = Environment.TickCount64;
            var nextMapReadAt = 0L;
            var targetGone = false;
            long targetGoneAt = 0;
            while (Environment.TickCount64 - startedAt < 30_000)
            {
                token.ThrowIfCancellationRequested();
                await Task.Delay(5, token);
                var player = await adb.ReadPlayer();
                if (player.MoveSpeed > 0) currentMoveSpeed = player.MoveSpeed;
                var position = new Cell(player.Player.X, player.Player.Y);
                currentMap.Player = player.Player;
                mapPanel.Invalidate();

                // 被占据的怪物格变得可通行后，仍按住的方向会自然提交移动。
                // 在坐标首次变化时释放，避免继续移动到下一个地图格。
                if (position != start)
                {
                    Log($"战斗后人物开始进格：{start} -> {position}，立即松开");
                    return;
                }

                var now = Environment.TickCount64;
                if (now < nextMapReadAt) continue;
                nextMapReadAt = now + 100;
                var map = await adb.ReadMap();
                RouteExecutor.ApplyPlayerStatus(map, player);
                currentMap = map; mapPanel.Map = map; mapPanel.Route = route; mapPanel.Invalidate();
                // 与怪物接触后，游戏可能在玩家坐标变化前切换到战斗场景。
                // 立即释放方向；战斗过程中绝不能继续移动角色。
                if (map.InBattle)
                {
                    State("战斗中，已停止移动");
                    Log("已进入战斗，停止发送方向操作");
                    return;
                }
                targetGone = !map.ByCell.TryGetValue(task.Target.Cell, out var tile)
                    || !tile.Roles.Any(role => role.Kind == task.Target.Kind);
                if (targetGone)
                {
                    if (targetGoneAt == 0)
                    {
                        targetGoneAt = Environment.TickCount64;
                        State($"{task.Target.Kind} 已消失，保持方向直到人物进格");
                    }
                    // 怪物被击败后，其所在格通常会变得可通行，按住的方向也会立即推进玩家。
                    // 如果在配置的卡顿窗口内没有观察到坐标变化，继续按住可能会让 UI
                    // 卡在旧的 30 秒战斗超时中。此时释放方向，让常规循环刷新并重新协调路线。
                    if (Environment.TickCount64 - targetGoneAt >= Math.Max(300L, (long)stallTimeout.Value))
                    {
                        Log($"{task.Target.Kind} 已消失但人物未进格，超过卡住超时，停止当前方向并重新校准");
                        return;
                    }
                }
                else targetGoneAt = 0;
            }
            Log(targetGone
                ? $"{task.Target.Kind} 已消失但人物尚未进格，本轮释放后继续确认"
                : $"{task.Target.Kind} 战斗持续 30 秒，分段释放并继续确认");
        }
        finally { await touch.TouchUp(); }
    }
    PlanOptions Options()
    {
        return new PlanOptions
        {
            // 6101 是纯战斗房间。该楼型不依赖用户的“全清小怪/清除精英”勾选，
            // 进入后统一交给怪物追猎规划器；普通楼层仍完全遵循 UI 选项。
            AttackBoss = attackBoss.Checked ||
                (currentMap is not null && FloorPlanningPolicy.IsMonsterHuntRoom(currentMap)),
            Monsters = monsters.Checked ||
                (currentMap is not null && FloorPlanningPolicy.IsMonsterHuntRoom(currentMap)),
            Elites = elites.Checked || (currentMap is not null && FloorPlanningPolicy.IsMonsterHuntRoom(currentMap)),
            Chests = chests.Checked,
            Pots = pots.Checked,
            Bones = bones.Checked,
            Gold = gold.Checked,
            Runes = runes.Checked,
            Chambers = chambers.Checked
        };
    }
    static bool IsSelected(RoleInfo role, PlanOptions o) => TargetPolicy.IsSelected(role, o);
    Dictionary<Cell, bool> WalkabilitySnapshot(MapDump map) => map.Tiles.SelectMany(row => row)
        .ToDictionary(tile => new Cell(tile.X, tile.Y), tile => tile.Walkable && !blocked.Contains(new Cell(tile.X, tile.Y)));
    static int OptionsSignature(PlanOptions o) => HashCode.Combine(
        HashCode.Combine(o.AttackBoss, o.Monsters, o.Elites, o.Chests, o.Pots, o.Bones, o.Gold),
        HashCode.Combine(o.Runes, o.Chambers, o.VisionRadius));
    void RecordMechanismVisit(MapDump map)
    {
        var player = new Cell(map.Player.X, map.Player.Y);
        if (!map.ByCell.TryGetValue(player, out var tile)) return;
        if (!tile.Roles.Any(role => role.Kind == "机关")) return;
        if (mechanismState.Add(player))
            Log($"已记录机关踩中：{player}（以实际人物坐标确认）");
    }

    HashSet<TargetKey> SelectedTargets(MapDump map, PlanOptions options, bool includeLockedBoss = false) => map.Tiles.SelectMany(row => row)
        .SelectMany(tile => tile.Roles.Where(role => TargetPolicy.IsSelected(role, options) && !(role.RoleType == 5 && role.Opened) &&
            (role.Kind != "机关" || (!tile.Reached && !visitedMechanisms.Contains(new Cell(tile.X, tile.Y)))) &&
            (includeLockedBoss || role.Kind is not ("Boss" or "小Boss") || Planner.IsBossAttackable(map, role)))
            .Select(role => new TargetKey(new Cell(tile.X, tile.Y), role.Kind))).ToHashSet();

    HashSet<TargetKey> ActiveTargets(MapDump map, PlanOptions options) => SelectedTargets(map, options);

    HashSet<TargetKey> ReachableActiveTargets(MapDump map, PlanOptions options)
        => Planner.ReachableTargets(map, ActiveTargets(map, options), blocked);

    bool IsTargetStopFloor(MapDump map)
    {
        var manualTargetReached = targetStopFloor.Value > 0 && map.Level == (int)targetStopFloor.Value;
        // 卡矿在未启用挖矿时退化为卡层：到达自动匹配的最高层后，
        // 即使“卡层”本身未勾选，也不能继续进入下一层。
        var cardTarget = (cardLayer.Checked || (cardMining.Checked && !mining.Checked))
            ? CardFloorPolicy.Resolve(map) : null;
        // 两种设置彼此独立：只开一个时使用对应条件；同时开启时，
        // 任一目标层都复用同一套“完成所选目标后停住”流程。
        var cardTargetReached = cardTarget is { } target && map.Level == target;
        return manualTargetReached || cardTargetReached;
    }

    bool TargetFloorStopReady(MapDump map)
    {
        if (!IsTargetStopFloor(map)) return false;
        if (map.InBattle) return false;
        // 挖矿优先于卡层：到达停层位置时，先把本层应执行的挖矿做完。
        if (ShouldMineBeforeFloorTransition(map)) return false;
        // 指定层复用普通“目标”选项；未勾选的可选目标不阻止停住，
        // 钥匙仍由 TargetPolicy 强制视为目标。锁定中的 Boss 也必须保留，
        // 防止封印尚未打开时误判为目标已完成。
        return SelectedTargets(map, Options(), includeLockedBoss: true).Count == 0;
    }

    bool IsCardMiningFloor(MapDump map)
        => cardMining.Checked && CardFloorPolicy.Resolve(map) is { } target && map.Level == target;

    bool ShouldMineBeforeFloorTransition(MapDump map)
    {
        if (!mining.Checked || floorMiningCompletedLevel == map.Level || floorMiningSkippedLevel == map.Level) return false;
        // 卡矿优先级高于普通挖矿：只有自动匹配的最高层允许使用道具。
        return !cardMining.Checked || IsCardMiningFloor(map);
    }

    async Task<bool> TryStopAtTargetFloor()
    {
        if (targetFloorStopped || currentMap is null || !TargetFloorStopReady(currentMap)) return false;

        var level = currentMap.Level;
        await touch.EmergencyRelease();
        targetFloorStopped = true;
        routeSession.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();
        Log($"已到达指定层 {level}，所选目标已完成，停止运行");
        State($"指定层 {level} 已完成所选目标");
        return true;
    }
    bool HasTarget(TargetKey target) => currentMap is not null && currentMap.ByCell.TryGetValue(target.Cell, out var tile) &&
        tile.Roles.Any(role => role.Kind == target.Kind) && (target.Kind != "机关" || (!tile.Reached && !visitedMechanisms.Contains(target.Cell)));
    bool IsAtPlannedInteractionStop(Cell cell)
        => plannedInteractions.Any(task => task.Stop == cell &&
            (HasTarget(task.Target) || PortalRouting.IsPortalKind(task.Target.Kind)));
    void ArmRoomPortalTransition()
    {
        if (currentMap is null || pendingRoomPortal is not null || route.Count < 2) return;
        var current = new Cell(currentMap.Player.X, currentMap.Player.Y);
        var task = plannedInteractions.FirstOrDefault(value => value.Target.Kind == "秘境传送门" &&
            value.Stop != current && route.Contains(value.Stop));
        if (task == default) return;
        attemptedRoomPortals.Add(task.Target.Cell);
        pendingRoomPortal = task.Target;
        roomPortalOrigin = current;
        roomPortalInteractionAt = Environment.TickCount64;
        Log($"已挂起层内传送等待：{task.Target.Cell}，从 {current} 进入后再确认跳转");
    }
    bool IsRoomPortalTarget(TargetKey target)
        => currentMap is not null && currentMap.ByCell.TryGetValue(target.Cell, out var tile) &&
           tile.Roles.Any(role => role.Kind == target.Kind && PortalRouting.IsRoomToRoom(role));
    void ReconcileCompletedTasks()
    {
        if (currentMap is null) return;
        var active = ActiveTargets(currentMap, Options());
        var newlyCompleted = plannedTargetUniverse.Where(target => Planner.IsCompletedTarget(target, active) && confirmedCompletedTargets.Add(target)).ToList();
        foreach (var target in newlyCompleted) expectedTaskRoadChanges.Add(target.Cell);
        var removed = plannedInteractions.RemoveAll(task => confirmedCompletedTargets.Contains(task.Target));
        if (newlyCompleted.Count > 0) Log($"已确认完成 {newlyCompleted.Count} 个计划任务，移除 {removed} 个停靠动作并保留剩余完整路线");
    }

    bool PortalPrerequisitesMet(MapDump map)
    {
        // 已存在的封印具有权威性：在其分数达到唤醒阈值前，守护 Boss 必须继续作为战斗目标。
        if (map.BossSeal.Present && !map.BossSeal.Ready) return false;
        if (map.Tiles.SelectMany(r => r).SelectMany(t => t.Roles)
            .Any(r => r.Kind is "Boss" or "小Boss")) return false;
        // 探索进度不是下楼的前置条件。满足战斗/目标前置条件后，
        // 即使仍有未发现的可通行格，也可以使用楼层入口。
        // 导出的地图中可能仍存在过期或被阻塞的角色；当不存在可到达的交互停靠点时，
        // 它不是真正的前置条件。
        if (ReachableActiveTargets(map, Options()).Count > 0) return false;
        return true;
    }

    bool UpdateFloorPhase()
    {
        if (currentMap is null) return false;
        var map = currentMap;
        if (observedLevel < 0) observedLevel = map.Level;
        if (map.Level != observedLevel)
        {
            CancelPortalChoiceCoroutine();
            observedLevel = map.Level; floorPhase = FloorPhase.WaitingFloorLoad; floorChangedAt = Environment.TickCount64;
            floorMiningCompletedLevel = -1;
            floorMiningSkippedLevel = -1;
            routeRecoveryUsed = 0;
            blocked.Clear(); lastBlockedAttempt = null; unchangedCount = 0;
            lastAcceptedPlayerCell = null;
            lastAcceptedPlayerAt = 0;
            interactedChambers.Clear();
            shortcutDeferredByTargets = false;
            targetFloorStopped = false;
            portalCandidate = null; portalConfirmCount = 0; routeSession.Clear();
            attemptedRoomPortals.Clear(); pendingRoomPortal = null; roomPortalOrigin = null; roomPortalInteractionAt = 0;
            confirmedCompletedTargets.Clear(); expectedTaskRoadChanges.Clear();
            Log($"检测到进入新层：{map.Level}，重置本层路线和目标");
            return true;
        }
        if (floorPhase == FloorPhase.WaitingFloorLoad)
        {
            if (Environment.TickCount64 - floorChangedAt < (long)newFloorStartDelay.Value) return true;
            floorPhase = FloorPhase.Explore;
            Log("新层遮罩等待完成，开始规划路线");
        }

        // 6101 没有普通洞窟的下楼/探索阶段。即使快照中偶尔残留传送门角色，
        // 也不能让通用楼层状态机把房间切换到 GoToPortal。
        if (FloorPlanningPolicy.IsMonsterHuntRoom(map))
        {
            portalCandidate = null;
            portalConfirmCount = 0;
            if (floorPhase != FloorPhase.Explore)
            {
                floorPhase = FloorPhase.Explore;
                Log("进入 6101 怪物房间，切换为直接找怪战斗规划");
            }
            return false;
        }

        // 换层弹窗出现后，地图快照仍可能保留弹窗下方的旧目标。
        // 这时不能再用楼层前置条件覆盖 SelectBonus/VerifyTransition，
        // 否则主循环永远到不了 SelectBonusRoutine，只会反复识别同一个弹窗。
        if (floorPhase is FloorPhase.SelectBonus or FloorPhase.VerifyTransition)
            return true;

        var portal = map.Tiles.SelectMany(r => r)
            .SelectMany(t => t.Roles.Where(PortalRouting.IsFloorTransition)
                .Select(r => new TargetKey(new Cell(t.X, t.Y), r.Kind)))
            .OrderBy(t => Math.Abs(t.Cell.X - map.Player.X) + Math.Abs(t.Cell.Y - map.Player.Y))
            .FirstOrDefault();
        if (portal == default)
        {
            portalCandidate = null; portalConfirmCount = 0;
            floorPhase = map.BossSeal.Present && !map.BossSeal.Ready ? FloorPhase.CollectWarning : FloorPhase.Explore;
            return false;
        }
        if (portalCandidate == portal) portalConfirmCount++; else { portalCandidate = portal; portalConfirmCount = 1; }
        if (!PortalPrerequisitesMet(map))
        {
            floorPhase = map.BossSeal.Present && !map.BossSeal.Ready ? FloorPhase.CollectWarning : FloorPhase.Explore;
            return false;
        }
        if (portalConfirmCount < 2) { floorPhase = FloorPhase.ConfirmPortal; return false; }
        if (floorPhase is not (FloorPhase.GoToPortal or FloorPhase.InteractPortal or FloorPhase.SelectBonus or FloorPhase.VerifyTransition))
        {
            floorPhase = FloorPhase.GoToPortal;
            var blockedBefore = blocked.Count;
            var plan = Planner.PlanToPortalRecoveringTemporaryBlocks(map, blocked, !monsters.Checked, portalUnlocks);
            if (blockedBefore > 0 && blocked.Count == 0)
                Log($"临时封锁导致出口不可达，已撤销 {blockedBefore} 个封锁并恢复路线");
            route = plan.Route; plannedInteractions = plan.Interactions; plannedTargetUniverse = plan.TargetUniverse;
            mapPanel.Route = route; mapPanel.Invalidate();
            Log(route.Count > 1 ? $"传送门已确认，锁定下楼路线 {route.Count - 1} 步" : "传送门已确认，但当前不可达");
        }
        return true;
    }

    bool HasPlanningWork(MapDump map)
    {
        var options = Options();
        return Planner.HasReachableUnexplored(map, blocked) ||
            ReachableActiveTargets(map, options).Count > 0 ||
            (map.BossSeal.Present && !map.BossSeal.Ready && !options.Monsters && map.BossSeal.WakeScore > map.BossSeal.CurScore);
    }

    static bool HasMapDownstairsEntrance(MapDump map)
        => map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles)
            .Any(PortalRouting.IsFloorTransition);

    bool TryPlanExplorationRoute()
    {
        if (currentMap is null || floorPhase != FloorPhase.Explore ||
            FloorPlanningPolicy.IsMonsterHuntRoom(currentMap)) return false;
        var map = currentMap;
        var options = Options();
        var plan = Planner.PlanExploration(map, options.VisionRadius, blocked, !options.Monsters);
        if (plan.Route.Count < 2) return false;

        route = plan.Route;
        plannedInteractions = [];
        // 当这条路线只用于揭示地图时，保持目标集合为空。
        // 新出现且已勾选的目标必须在下一次刷新时触发正常的完整规划，
        // 而不能被探索流程隐藏。
        plannedTargetUniverse = [];
        plannedWalkability = WalkabilitySnapshot(map);
        plannedOptionsSignature = OptionsSignature(options);
        routeSession.PlannedNavigationHash = routeSession.Snapshot?.NavigationHash;
        routeSession.PlannedRoadMonsters = [.. map.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
        expectedTaskRoadChanges.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();
        Log($"无可达勾选目标且没有下楼入口，直接探索地图：{route.Count - 1} 步，寻找勾选目标");
        State("探索地图，寻找勾选目标");
        return true;
    }

    bool TryPlanRoomPortalRoute()
    {
        if (currentMap is null || floorPhase != FloorPhase.Explore || HasMapDownstairsEntrance(currentMap) ||
            pendingRoomPortal is not null) return false;
        var plan = Planner.PlanToRoomPortal(currentMap, blocked, !monsters.Checked, attemptedRoomPortals);
        if (plan.Interactions.Count == 0)
        {
            var unlockPlan = Planner.PlanToPortalUnlockMonster(currentMap, blocked, portalUnlocks);
            if (unlockPlan.Route.Count < 2 && unlockPlan.Interactions.Count == 0) return false;
            route = unlockPlan.Route; plannedInteractions = unlockPlan.Interactions; plannedTargetUniverse = unlockPlan.TargetUniverse;
            routeSession.PlannedRoadMonsters = [.. currentMap.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
            mapPanel.Route = route; mapPanel.Invalidate();
            var unlockTarget = unlockPlan.Interactions.FirstOrDefault().Target;
            var unlockKind = string.IsNullOrWhiteSpace(unlockTarget.Kind) ? "小怪" : unlockTarget.Kind;
            Log($"层内传送门仍锁定，先规划击败 {unlockKind} {unlockTarget.Cell}");
            State("前往小怪解锁传送门");
            return true;
        }
        route = plan.Route; plannedInteractions = plan.Interactions; plannedTargetUniverse = plan.TargetUniverse;
        routeSession.PlannedRoadMonsters = [.. currentMap.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
        mapPanel.Route = route; mapPanel.Invalidate();
        Log($"层内传送寻路：前往 {plan.Interactions[0].Target.Cell}，路线 {Math.Max(0, route.Count - 1)} 步，等待记录跳转边");
        State("前往层内传送门");
        return true;
    }

    async Task<bool> TryExploreWithoutTarget(CancellationToken token)
    {
        // TryUseNextFloorShortcut 已在此回退逻辑前立即执行。
        // 只有 Explore 符合条件，因此活动中的传送门/转场阶段绝不会被随机移动替代。
        if (currentMap is null || floorPhase != FloorPhase.Explore ||
            FloorPlanningPolicy.IsMonsterHuntRoom(currentMap)) return false;
        var origin = new Cell(currentMap.Player.X, currentMap.Player.Y);
        var candidates = new[] { new Cell(0, -1), new Cell(1, 0), new Cell(0, 1), new Cell(-1, 0) }
            .Select(delta => new Cell(origin.X + delta.X, origin.Y + delta.Y))
            .Where(cell => currentMap.ByCell.TryGetValue(cell, out var tile) && tile.Walkable && !blocked.Contains(cell))
            .ToList();
        if (candidates.Count == 0) return false;

        if (!monsters.Checked)
        {
            var safeCandidates = candidates.Where(cell => !Planner.HasRoadMonster(currentMap.ByCell[cell])).ToList();
            if (safeCandidates.Count > 0) candidates = safeCandidates;
        }
        var unexplored = candidates.Where(cell => !currentMap.ByCell[cell].Explored).ToList();
        var pool = unexplored.Count > 0 ? unexplored : candidates;
        var next = pool.OrderBy(_ => random.Next()).First();
        var delta = new Cell(next.X - origin.X, next.Y - origin.Y);
        Log($"无可达勾选目标且没有下楼入口，执行单格探索：方向 {delta.X},{delta.Y}");
        State("探索地图，寻找勾选目标");
        if (await RunMovementSlice(token,
                sliceToken => touch.PulseOneCell(InputDelta(delta), (int)singleCellPulseHold.Value, sliceToken)))
        {
            await HandleMovementPopupInterrupt(token);
            return true;
        }
        await Task.Delay(80, token);
        await RefreshMap(false, waitForLock: true);
        if (currentMap is not null) EnsureRoute(true);
        return true;
    }

    async Task<bool> TryPlanningRecovery(CancellationToken token)
    {
        if (currentMap is null || !HasPlanningWork(currentMap) || routeRecoveryUsed >= (int)routeRecoveryAttempts.Value) return false;
        var origin = new Cell(currentMap.Player.X, currentMap.Player.Y);
        var candidates = new[] { new Cell(0, -1), new Cell(1, 0), new Cell(0, 1), new Cell(-1, 0) }
            .Where(d => currentMap.ByCell.TryGetValue(new Cell(origin.X + d.X, origin.Y + d.Y), out var t) && t.Walkable && !blocked.Contains(new Cell(origin.X + d.X, origin.Y + d.Y)))
            .OrderBy(_ => random.Next()).ToList();
        if (candidates.Count == 0) return false;
        var delta = candidates[0]; routeRecoveryUsed++;
        Log($"路线无有效结果，执行随机容错移动 {routeRecoveryUsed}/{(int)routeRecoveryAttempts.Value}：方向 {delta.X},{delta.Y}");
        if (await RunMovementSlice(token,
                sliceToken => touch.PulseOneCell(InputDelta(delta), (int)singleCellPulseHold.Value, sliceToken)))
        {
            await HandleMovementPopupInterrupt(token);
            return true;
        }
        await Task.Delay(80, token);
        await RefreshMap(false, waitForLock: true);
        if (currentMap is not null) EnsureRoute(true);
        return true;
    }

    async Task<bool> TryUseNextFloorShortcut(CancellationToken token)
    {
        // 右侧快捷入口是另一种传送门入口。玩家到达传送门前它就可能出现，
        // 因此优先级必须高于常规路线规划。转场对话框正在处理时绝不能探测它，
        // 否则同一个按钮可能在弹窗流程中被反复点击。
        if (floorPhase is FloorPhase.WaitingFloorLoad or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)
            return false;
        if (currentMap is not null && FloorPlanningPolicy.IsMonsterHuntRoom(currentMap))
            return false;
        if (!await adb.HasNextFloorButton()) return false;

        var map = currentMap;
        if (map is null) return false;
        var options = Options();
        var allPending = ActiveTargets(map, options);
        var pending = ReachableActiveTargets(map, options);
        var unreachable = allPending.Count - pending.Count;
        if (unreachable > 0 && !shortcutDeferredByTargets)
            Log($"忽略 {unreachable} 个不可达目标，不阻塞下一层入口");
        // ActiveTargets 有意省略被锁定的 Boss，使其不会在预警阈值前被规划。
        // 但对于快捷入口的门控，已勾选的 Boss 仍然是必需任务；
        // 在游戏移除该 Boss 节点前，必须阻止进入下一层。
        var hasRequiredBoss = options.AttackBoss && map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles)
            .Any(role => role.Kind is "Boss" or "小Boss");
        var pendingCount = pending.Count + (hasRequiredBoss ? 1 : 0);
        if (pendingCount > 0)
        {
            if (!shortcutDeferredByTargets)
                Log($"检测到右侧‘前往下层’入口，但仍有 {pendingCount} 个已勾选目标未完成，暂不点击");
            shortcutDeferredByTargets = true;
            return false;
        }
        shortcutDeferredByTargets = false;

        // 快捷入口出现时也要先执行换层前的挖矿，尤其是没有显式传送门路线的楼型。
        // 放在目标门控之后，保证“完成目标后再挖矿”的顺序不被打乱。
        if (await TryMineBeforeFloorTransition(token, transitionAvailable: true)) return true;
        if (IsTargetStopFloor(map) && !TargetFloorStopReady(map))
        {
            if (!shortcutDeferredByTargets)
                Log($"检测到右侧‘前往下层’入口，但指定层停止条件尚未满足，暂不点击");
            shortcutDeferredByTargets = true;
            return false;
        }
        shortcutDeferredByTargets = false;

        await touch.EmergencyRelease();
        await adb.TapScreen(0.890625, 0.498);
        route = [];
        plannedInteractions = [];
        plannedTargetUniverse.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();
        floorPhase = FloorPhase.SelectBonus;
        portalInteractionAt = Environment.TickCount64;
        Log("检测到右侧‘前往下层’快捷入口，未前往传送门，已直接点击");
        State("已点击前往下层，等待确认/加成");
        return true;
    }

    void EnsurePortalRoute()
    {
        if (currentMap is null) return;
        var player = new Cell(currentMap.Player.X, currentMap.Player.Y);
        // GoToPortal 有意跳过常规完整路线规划。
        // 但它仍需要独立的有效性检查，否则一次超调就会让执行器永远重试同一条过期传送门路线。
        var routeIndex = route.FindIndex(cell => cell == player);
        if (route.Count > 1 && !HasNewRoadMonsters(currentMap) && Planner.CanContinueRoute(currentMap, route, player, blocked))
        {
            // CanContinueRoute 接受已经走到锁定传送门路线中途的玩家。
            // 但执行器要求 route[0] 必须是玩家实际所在格。
            // 因此只保留剩余后缀，避免卡顿或超调的传送门路线因原始起点格而永远被拒绝。
            if (routeIndex > 0) route = route.Skip(routeIndex).ToList();
            mapPanel.Route = route;
            mapPanel.Invalidate();
            return;
        }

        var blockedBefore = blocked.Count;
        var plan = Planner.PlanToPortalRecoveringTemporaryBlocks(currentMap, blocked, !monsters.Checked, portalUnlocks);
        if (blockedBefore > 0 && blocked.Count == 0)
            Log($"临时封锁导致出口不可达，已撤销 {blockedBefore} 个封锁并恢复路线");
        route = plan.Route;
        plannedInteractions = plan.Interactions;
        plannedTargetUniverse = plan.TargetUniverse;
        routeSession.PlannedRoadMonsters = [.. currentMap.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
        mapPanel.Route = route;
        mapPanel.Invalidate();
        Log(plan.Interactions.FirstOrDefault().Target.Kind is "小怪" or "群怪" or "精英"
            ? $"传送门仍锁定，先规划击败 {plan.Interactions[0].Target.Kind} {plan.Interactions[0].Target.Cell}"
            : route.Count > 1
            ? $"传送门路线失效，已按当前位置重新规划：{route.Count - 1} 步"
            : $"传送门路线失效，当前不可达：{plan.FailureReason}");
    }

    bool HasNewRoadMonsters(MapDump map) => !FloorPlanningPolicy.IsMonsterHuntRoom(map) && !monsters.Checked && map.ByCell.Any(pair =>
        Planner.HasRoadMonster(pair.Value) && !routeSession.PlannedRoadMonsters.Contains(pair.Key));

    void EnsureRoute(bool force = false)
    {
        if (currentMap is null)
        {
        // 保持此处的显式检查：过去规划器可能在首次成功获取快照前被调用
        // （例如设备列表或 root Shell 仍在稳定时），然后悄悄让 UI 显示空路线。
            Log("规划跳过：当前没有有效地图快照，请先刷新地图并确认助手数据已生成");
            State("地图未就绪");
            return;
        }
        var options = Options(); var walkability = WalkabilitySnapshot(currentMap); var optionSignature = OptionsSignature(options); var player = new Cell(currentMap.Player.X, currentMap.Player.Y);
        // 运行时导出器可能在战斗或脉冲后短暂暴露前一个格子。
        // 如果该采样比上次接受的位置落后一步，且不在锁定路线中，
        // 不要将其视为真实偏离；改为等待下一次玩家状态采样。
        if (!force && lastAcceptedPlayerCell is { } accepted && player != accepted &&
            Environment.TickCount64 - lastAcceptedPlayerAt < 600 &&
            Math.Abs(player.X - accepted.X) + Math.Abs(player.Y - accepted.Y) == 1 &&
            route.Contains(accepted) && !route.Contains(player))
        {
            currentMap.Player = new PlayerInfo { X = accepted.X, Y = accepted.Y };
            Log($"忽略疑似滞后坐标：{player}，保持已确认位置 {accepted}");
            return;
        }
        lastAcceptedPlayerCell = player;
        lastAcceptedPlayerAt = Environment.TickCount64;
        var activeTargets = ActiveTargets(currentMap, options);
        var routeIndex = route.FindIndex(cell => cell == player);
        var changedRoadCells = plannedWalkability.Count == 0 ? [] : walkability.Keys.Union(plannedWalkability.Keys)
            .Where(cell => !walkability.TryGetValue(cell, out var now) || !plannedWalkability.TryGetValue(cell, out var before) || now != before).ToList();
        var expectedRoadUpdate = changedRoadCells.Count > 0 && changedRoadCells.All(expectedTaskRoadChanges.Contains);
        if (expectedRoadUpdate)
        {
            plannedWalkability = walkability;
            Log($"接受 {changedRoadCells.Count} 个计划任务引起的道路状态变化，不重新规划");
        }
        var navigationChanged = routeSession.PlannedNavigationHash is not null &&
            routeSession.Snapshot is not null && routeSession.PlannedNavigationHash != routeSession.Snapshot.NavigationHash;
        var roadChanged = (changedRoadCells.Count > 0 || navigationChanged) && !expectedRoadUpdate || HasNewRoadMonsters(currentMap);
        expectedTaskRoadChanges.Clear();
        var optionsChanged = plannedOptionsSignature is not null && plannedOptionsSignature != optionSignature;
        var newTargets = activeTargets.Where(target => !plannedTargetUniverse.Contains(target)).ToList();
        var canContinue = Planner.CanContinueRoute(currentMap, route, player, blocked);
        if (!force && !roadChanged && !optionsChanged && newTargets.Count == 0 && canContinue)
        {
            if (routeIndex > 0) route = route.Skip(routeIndex).ToList();
            Log($"道路和计划外目标未变化，复用完整路线剩余 {route.Count - 1} 步");
        }
        else
        {
            var reason = force ? "手动" : plannedWalkability.Count == 0 ? "首次" : roadChanged ? "计划外道路变化" : optionsChanged ? "选项变化" : newTargets.Count > 0 ? $"出现 {newTargets.Count} 个计划外目标" : "人物偏离或剩余路线结束";
            var blockedBefore = blocked.Count;
            var plan = Planner.PlanForFloorRecoveringTemporaryBlocks(currentMap, options, blocked, visitedMechanisms);
            if (blockedBefore > 0 && blocked.Count == 0)
                Log($"临时封锁切断全部目标路线，已撤销 {blockedBefore} 个封锁并恢复规划");
            route = plan.Route; plannedInteractions = plan.Interactions; plannedTargetUniverse = plan.TargetUniverse;
            confirmedCompletedTargets.Clear(); expectedTaskRoadChanges.Clear(); plannedWalkability = walkability; plannedOptionsSignature = optionSignature;
            routeSession.PlannedNavigationHash = routeSession.Snapshot?.NavigationHash;
            routeSession.PlannedRoadMonsters = [.. currentMap.ByCell.Where(pair => Planner.HasRoadMonster(pair.Value)).Select(pair => pair.Key)];
            Log($"{reason}完整规划：{Math.Max(0, route.Count - 1)} 步，交互节点 {plannedInteractions.Count}，目标 {plannedTargetUniverse.Count}");
            if (!string.IsNullOrWhiteSpace(plan.FailureReason))
                Log($"规划诊断：{plan.FailureReason}，可走 {plan.WalkableCells}，未探索 {plan.UnexploredCells}，不可达目标 {plan.UnreachableTargets.Count}");
        }
        mapPanel.Route = route; mapPanel.Invalidate();
    }
    async Task Replan()
    {
        // 路线执行器移动时会轮询玩家状态，但完整地图（尤其是 tile.Explored）
        // 按独立的节奏导出。强制/手动重新规划前始终获取新的设备快照，
        // 否则规划器可能复用运行开始时捕获的迷雾状态。
        await RefreshMap(false, waitForLock: true);
        if (serverErrorDialogVisible || runCts?.IsCancellationRequested == true) return;
        ReplanFromCurrentMap();
    }

    void ReplanFromCurrentMap()
    {
        if (currentMap is null)
        {
            Log("规划失败：当前没有有效地图快照（设备、Root 会话或助手地图数据未就绪）");
            State("地图未就绪");
            return;
        }
        if (blocked.Count > 0)
        {
            var cleared = blocked.Count;
            blocked.Clear(); lastBlockedAttempt = null; unchangedCount = 0;
            Log($"手动重新规划：已清除 {cleared} 个临时封锁");
        }
        // 手动重新规划也必须先更新楼层阶段。特殊副本可能只有出口/前往下一层
        // 节点，普通完整规划会刻意排除出口，导致误报“没有可规划目标”。
        UpdateFloorPhase();
        if (floorPhase is FloorPhase.ConfirmPortal or FloorPhase.GoToPortal or FloorPhase.InteractPortal or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)
        {
            if (floorPhase is FloorPhase.ConfirmPortal or FloorPhase.GoToPortal)
            {
                var portalPlan = Planner.PlanToPortalRecoveringTemporaryBlocks(currentMap, blocked, !monsters.Checked, portalUnlocks);
                route = portalPlan.Route; plannedInteractions = portalPlan.Interactions; plannedTargetUniverse = portalPlan.TargetUniverse;
                mapPanel.Route = route; mapPanel.Invalidate();
                if (route.Count > 1) Log($"重新规划前往出口：{route.Count - 1} 步");
                else Log($"出口路线为空：{portalPlan.FailureReason}，可走 {portalPlan.WalkableCells}");
            }
            else Log($"当前处于 {floorPhase} 阶段，保留现有换层流程");
            return;
        }
        var map = currentMap; var options = Options();
        var walkable = map.Tiles.SelectMany(row => row).Count(t => t.Walkable);
        var unexplored = map.Tiles.SelectMany(row => row).Count(t => t.Walkable && !t.Explored);
        var active = ActiveTargets(map, options).Count;
        var diagnosticTargets = ActiveTargets(map, options).OrderBy(t => t.Cell.Y).ThenBy(t => t.Cell.X)
            .Select(t => $"{t.Kind}@({t.Cell.X},{t.Cell.Y})");
        Log($"planning targets: {string.Join(" | ", diagnosticTargets)}");
        var warningNeed = map.BossSeal.Present && !map.BossSeal.Ready && !options.Monsters
            ? Math.Max(0, (int)Math.Ceiling((map.BossSeal.WakeScore - map.BossSeal.CurScore) / 11d)) : 0;
        Log($"规划诊断：阶段 {floorPhase}，可走 {walkable}，未探索 {unexplored}，已选目标 {active}，预警还需 {warningNeed} 个小怪");
        EnsureRoute(true);
        Log(route.Count > 1 ? $"路线：{route.Count - 1} 步，目标 {route[^1]}" : "没有可规划目标");
    }

    Task StartRun() => RunMovement(StartRunCore, startupProbePaused: true);

    async Task NavigateToMapCell(Cell target)
    {
        // 拒绝无效点击，但不要干扰活动路线。有效点击采用最新请求优先：
        // 只串行化交接过程，而不是整个导航过程，这样另一次点击可以立即抢占。
        if (currentMap is null || !currentMap.ByCell.TryGetValue(target, out var tile) || !Planner.IsClickableTarget(tile))
        {
            State("该位置不可导航");
            Log($"地图点击已忽略：{target} 不是可行走道路或可交互目标，当前路线保持不变");
            return;
        }
        var requestVersion = Interlocked.Increment(ref clickNavigationVersion);
        var deferredLogged = false;
        while (requestVersion == Volatile.Read(ref clickNavigationVersion))
        {
            // 游戏战斗场景中的地图点击只会排队。这里不要取消当前运行或释放输入；
            // 等待现有战斗循环观察到战斗结束。
            if (currentMap?.InBattle == true)
            {
                if (!deferredLogged)
                {
                    State($"战斗中，已记录导航目标 {target}");
                    Log($"战斗期间暂不执行地图点击；脱离战斗后切换至 {target}");
                    deferredLogged = true;
                }
                await Task.Delay(120);
                continue;
            }

            Task? navigation = null;
            await clickNavigationSwitch.WaitAsync();
            try
            {
                if (requestVersion != Volatile.Read(ref clickNavigationVersion)) return;
                // 获取切换锁后重新检查：此请求在等待前一个点击期间，战斗可能已经开始。
                if (currentMap?.InBattle == true) continue;
                if (activeMovement is { IsCompleted: false })
                {
                    State($"切换导航目标至 {target}");
                    await StopMovement();
                }
                if (requestVersion != Volatile.Read(ref clickNavigationVersion)) return;
                navigation = RunMovement(() => NavigateToMapCellCore(target, requestVersion));
            }
            finally { clickNavigationSwitch.Release(); }
            if (navigation is not null) await navigation;
            return;
        }
    }

    async Task RunMapClick(Cell target)
    {
        if (closing) return;
        Task? operation = null;
        try
        {
            operation = NavigateToMapCell(target);
            uiOperations.Add(operation);
            await operation;
        }
        catch (Exception ex) { Error(ex); }
        finally
        {
            if (operation is not null) uiOperations.Remove(operation);
            UpdateDeviceAvailability();
        }
    }

    async Task NavigateToMapCellCore(Cell target, int requestVersion)
    {
        var owner = new CancellationTokenSource();
        runCts = owner;
        touch.MovementCancellation = owner.Token;
        try
        {
            var startup = Stopwatch.StartNew();
            State($"正在读取地图并规划至 {target}");
            RoutePlan? initialPlan = null;
            var ready = await RefreshMap(true, waitForLock: true, onMapReady: () =>
            {
                var planning = Stopwatch.StartNew();
                initialPlan = Planner.PlanToTarget(currentMap!, target, monsters.Checked, blocked);
                route = initialPlan.Route; plannedInteractions = initialPlan.Interactions;
                plannedTargetUniverse = initialPlan.TargetUniverse;
                mapPanel.Route = route; mapPanel.Invalidate();
                Log($"点击导航规划就绪 {startup.ElapsedMilliseconds} ms，其中路径规划 {planning.ElapsedMilliseconds} ms");
                State("路线已规划，等待弹窗检查完成");
            });
            owner.Token.ThrowIfCancellationRequested();
            if (serverErrorDialogVisible) return;
            if (!ready || currentMap is null) { State("地图未就绪"); return; }
            Log($"点击导航启动检查完成 {startup.ElapsedMilliseconds} ms");
            if (!currentMap.ByCell.TryGetValue(target, out var clickedTile) || !Planner.IsClickableTarget(clickedTile))
            {
                State("该位置不可导航");
                Log($"地图点击已忽略：{target} 不是可行走道路或可交互目标");
                return;
            }

            var clickedKind = clickedTile.Roles.Select(role => role.Kind)
                .FirstOrDefault(kind => kind.Length > 0 && kind != "未知");
            Log($"地图点击导航：{target}{(string.IsNullOrEmpty(clickedKind) ? "（道路）" : $"（{clickedKind}）")}，全清小怪={(monsters.Checked ? "是" : "否")}");
            var useInitialSnapshot = true;
            while (!owner.IsCancellationRequested && requestVersion == Volatile.Read(ref clickNavigationVersion))
            {
                if (useInitialSnapshot) useInitialSnapshot = false;
                else await RefreshMap(false, waitForLock: true);
                owner.Token.ThrowIfCancellationRequested();
                if (serverErrorDialogVisible) return;
                if (runeSelectionVisible)
                {
                    initialPlan = null;
                    await HandleRiftGemSelection(owner.Token);
                    continue;
                }
                if (currentMap is null) { State("地图未就绪"); return; }
                if (currentMap.InBattle)
                {
                    initialPlan = null;
                    await touch.EmergencyRelease();
                    State("战斗中，已停止移动");
                    await Task.Delay(120, owner.Token);
                    continue;
                }

                var player = new Cell(currentMap.Player.X, currentMap.Player.Y);
                var targetStillPresent = !string.IsNullOrEmpty(clickedKind) && currentMap.ByCell.TryGetValue(target, out var liveTargetTile) &&
                    liveTargetTile.Roles.Any(role => role.Kind == clickedKind);
                if ((string.IsNullOrEmpty(clickedKind) && player == target) || (!string.IsNullOrEmpty(clickedKind) && !targetStillPresent))
                {
                    State($"已到达点击目标 {target}");
                    Log($"地图点击导航完成：{target}");
                    return;
                }

                var plan = initialPlan ?? Planner.PlanToTarget(currentMap, target, monsters.Checked, blocked);
                initialPlan = null;
                route = plan.Route;
                plannedInteractions = plan.Interactions;
                plannedTargetUniverse = plan.TargetUniverse;
                mapPanel.Route = route;
                mapPanel.Invalidate();
                if (!string.IsNullOrWhiteSpace(plan.FailureReason))
                {
                    State(plan.FailureReason);
                    Log($"地图点击导航失败：{target}，{plan.FailureReason}");
                    return;
                }

                var task = plannedInteractions.FirstOrDefault(interaction => interaction.Stop == player && HasTarget(interaction.Target));
                if (task != default)
                {
                    if (requestVersion != Volatile.Read(ref clickNavigationVersion)) return;
                    var delta = new Cell(task.Target.Cell.X - player.X, task.Target.Cell.Y - player.Y);
                    State($"点击导航交互 {task.Target.Kind}，方向 {delta.X},{delta.Y}");
                    var popupInterrupted = IsCombatInteraction(task.Target.Kind)
                        ? await FightWhileHolding(task, owner.Token)
                        : await SendInteraction((delta, task.Target.Kind), owner.Token);
                    if (popupInterrupted)
                    {
                        await HandleMovementPopupInterrupt(owner.Token);
                        continue;
                    }
                    if (task.Target.Cell == target && !IsCombatInteraction(task.Target.Kind))
                    {
                        State($"已交互点击目标 {target}");
                        Log($"地图点击导航完成：已交互 {task.Target.Kind} {target}");
                        return;
                    }
                    await Task.Delay(80, owner.Token);
                    continue;
                }

                if (route.Count < 2)
                {
                    State(player == target ? $"已到达点击目标 {target}" : "点击目标不可达");
                    return;
                }
                State($"自动导航至 {target}，剩余 {route.Count - 1} 步");
                var routeResult = await ExecuteRouteSlice(owner.Token);
                if (routeResult.InterruptedByPopup)
                {
                    await HandleMovementPopupInterrupt(owner.Token);
                    continue;
                }
                if (routeResult.RequiresReplan)
                {
                // RouteExecutor 已拒绝该路线，且没有发送另一条移动指令。
                // 在下一次点击导航迭代前刷新权威玩家位置并丢弃失败的规划；
                // 下一次会从该位置构建新路线。
                    await RefreshMap(false, waitForLock: true);
                    route = [];
                    plannedInteractions = [];
                    plannedTargetUniverse.Clear();
                    mapPanel.Route = route;
                    mapPanel.Invalidate();
                }
                await Task.Delay(20, owner.Token);
            }
        }
        catch (OperationCanceledException) { }
        finally
        {
            coroutines.StopAll(); portalChoiceCoroutine = null;
            try { await touch.TouchUp(); } catch (Exception ex) { Error(ex); }
            if (ReferenceEquals(runCts, owner)) runCts = null;
            owner.Dispose();
        }
    }

    bool PopupProbeEnabled()
        => !popupHandling && !startupPreparing && !runeSelectionVisible &&
           floorPhase is not (FloorPhase.SelectBonus or FloorPhase.VerifyTransition);

    string PopupProbeDisabledReason()
    {
        if (popupHandling) return "当前正在处理弹窗";
        if (startupPreparing) return "启动地图/OCR检查中";
        if (runeSelectionVisible) return "秘境宝石选择已锁存，等待点击/关闭确认";
        return floorPhase switch
        {
            FloorPhase.SelectBonus => "当前处于换层弹窗流程（OCR确认/加成选择）",
            FloorPhase.VerifyTransition => "当前处于换层确认流程",
            _ => "专用流程未结束"
        };
    }

    bool CancelCurrentMovementSlice()
    {
        lock (movementSliceGate)
        {
            if (currentMovementSlice is null) return false;
            try { currentMovementSlice.Cancel(); return true; }
            catch (ObjectDisposedException) { return false; }
        }
    }

    void SetCurrentMovementSlice(CancellationTokenSource? slice)
    {
        lock (movementSliceGate) currentMovementSlice = slice;
    }

    async Task<RouteExecutionResult> ExecuteRouteSlice(CancellationToken ownerToken)
    {
        using var slice = CancellationTokenSource.CreateLinkedTokenSource(ownerToken);
        SetCurrentMovementSlice(slice);
        try
        {
            var result = await CreateRouteExecutor().ExecuteDetailed(slice.Token, () => motionInterrupt.Reason);
            SetCurrentMovementSlice(null);
            return motionInterrupt.Reason == MotionInterruptReason.Popup
                ? new RouteExecutionResult(RouteExecutionStatus.InterruptedByPopup)
                : result;
        }
        finally { SetCurrentMovementSlice(null); }
    }

    async Task<bool> RunMovementSlice(CancellationToken ownerToken, Func<CancellationToken, Task> action)
    {
        using var slice = CancellationTokenSource.CreateLinkedTokenSource(ownerToken);
        SetCurrentMovementSlice(slice);
        try
        {
            await action(slice.Token);
            SetCurrentMovementSlice(null);
            if (motionInterrupt.Reason == MotionInterruptReason.Popup) return true;
            return false;
        }
        catch (OperationCanceledException) when (motionInterrupt.Reason == MotionInterruptReason.Popup)
        {
            return true;
        }
        finally { SetCurrentMovementSlice(null); }
    }

    async Task HandleMovementPopupInterrupt(CancellationToken ownerToken)
    {
        popupHandling = true;
        try
        {
            var kind = motionInterrupt.PopupKind;
            if (kind == MovementPopupKind.None) return;

        await touch.EmergencyRelease();
        Log($"检测到弹窗：{kind}，已释放触摸并暂停当前路线");
        route = [];
        plannedInteractions = [];
        plannedTargetUniverse.Clear();
        mapPanel.Route = route;
        mapPanel.Invalidate();

        if (kind == MovementPopupKind.ServerError)
        {
            serverErrorDialogVisible = true;
            runCts?.Cancel();
            State("服务器连接异常，已停止运行");
            return;
        }

        if (kind == MovementPopupKind.RiftGemSelection)
        {
            // 看门狗已经通过共享管线完成标题识别；这里仅锁存状态，
            // 由主循环执行点击并确认覆盖层关闭。
            LatchRiftGemSelection();
        }
        else if (kind == MovementPopupKind.NextFloorDialog)
        {
            // 共享管线已经在同一帧给出了具体子类型。不要丢掉它后再
            // 重新截图识别，否则转场动画会把已确认的弹窗变成超时。
            pendingNextFloorDialog = motionInterrupt.NextFloorDialogKind;
            pendingGreedySelectionReturnOnly = motionInterrupt.GreedySelectionReturnOnly;
            floorPhase = FloorPhase.SelectBonus;
            portalInteractionAt = portalInteractionAt > 0 ? portalInteractionAt : Environment.TickCount64;
            portalDialogPausedMs = 0;
            State("检测到换层弹窗，暂停移动等待处理");
        }
        // 会拦截触摸的覆盖层打断移动后，刷新非弹窗状态。
        // 这样下一次规划能获得权威的玩家/地图快照；上面的弹窗专用标志
        // 则能在地图导出暂时过期时保留正确的处理分支。
        await RefreshMap(false, waitForLock: true);
        if (!ownerToken.IsCancellationRequested && !serverErrorDialogVisible)
            State("弹窗已接管，等待处理完成后继续");
        }
        finally
        {
            motionInterrupt.Clear();
            popupHandling = false;
        }
    }

    async Task RunMovement(Func<Task> action, bool startupProbePaused = false)
    {
        if (closing || stopping || scanning || activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false }) return;
        if (startupProbePaused) startupPreparing = true;
        devices.Enabled = false;
        motionInterrupt.Clear();
        using var watchdogCts = new CancellationTokenSource();
        var watchdog = new PopupWatchdog(adb, touch, motionInterrupt, PopupProbeEnabled, CancelCurrentMovementSlice,
            popup => Log($"弹窗监控已锁存：{popup}，等待主循环接管"),
            ex => Log($"移动弹窗监控暂时失败：{ex.Message}"),
            message => Log(message),
            PopupProbeDisabledReason);
        var watchdogTask = watchdog.RunAsync(watchdogCts.Token);
        try { activeMovement = action(); await activeMovement; }
        finally
        {
            watchdogCts.Cancel();
            try { await watchdogTask; } catch (OperationCanceledException) { }
            motionInterrupt.Clear();
            touch.MovementCancellation = default;
            if (startupProbePaused) startupPreparing = false;
            UpdateDeviceAvailability();
        }
    }

    async Task StopMovement()
    {
        stopping = true;
        try
        {
            runCts?.Cancel();
            entryCts?.Cancel();
            try { await touch.EmergencyRelease(); } catch (Exception ex) { Error(ex); }
            if (activeMovement is not null) await activeMovement;
            if (activeEntry is not null) await activeEntry;
        }
        finally
        {
            // StopMovement 是一次新的运行/导航请求的边界。若上一次宝石弹窗
            // 在点击后被急停，PopupWatchdog 已停止探测，而锁存状态会一直
            // 遗留到下一次启动，导致普通战斗画面仍显示“宝石选择”。
            ClearRiftGemSelectionState();
            stopping = false;
        }
    }

    async Task CalibrateEntry()
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) throw new InvalidOperationException("请先连接设备");
        if (runCts is not null || activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false })
            throw new InvalidOperationException("请先暂停当前运行，再进行入口标定");
        var map = SelectedEntryMap;
        using var screenshot = await adb.CaptureScreenForAutomationAsync();
        using var dialog = new EntryCalibrationForm(screenshot, map.Name);
        dialog.ApplyTheme(currentPalette);
        if (dialog.ShowDialog(this) != DialogResult.OK || dialog.SelectedPoint is not Point point ||
            dialog.SelectedTemplateBounds is not Rectangle bounds) return;
        entryTemplates.Save(map.TemplateId, VisualTemplate.Create(screenshot, bounds),
            EntryTemplateStore.GetTargetOffset(bounds, point));
        Log(map.UsesSharedEntrance
            ? $"已保存特殊副本公共入口场景模板（{map.Name}共用）；会以场景定位、锚点点击并二次确认"
            : $"已保存“{map.Name}”入口场景模板；会以场景定位并按锚点点击");
        State("入口模板已保存");
    }

    async Task AutoEnter()
    {
        if (string.IsNullOrWhiteSpace(devices.Text)) throw new InvalidOperationException("请先连接设备");
        if (runCts is not null || activeMovement is { IsCompleted: false })
            throw new InvalidOperationException("请先暂停或停止地图导航，再自动进图");
        if (activeEntry is { IsCompleted: false }) return;

        var owner = new CancellationTokenSource();
        entryCts = owner;
        var selection = new DungeonEntrySelection(
            SelectedEntryMap.Id, Math.Max(1, entryChoice.SelectedIndex + 1),
            (DungeonDifficulty)Math.Clamp(entryDifficulty.SelectedIndex, (int)DungeonDifficulty.Normal, (int)DungeonDifficulty.Nightmare));
        Task? operation = null;
        try
        {
            adb.Serial = devices.Text;
            var automation = new DungeonEntryAutomation(adb, entryTemplates, Log, State);
            var trace = new MaaPipelineTraceCollector();
            var liveTrace = new DelegateMaaPipelineTraceSink(value =>
            {
                var task = value.TaskName ?? value.TaskChain;
                switch (value.Kind)
                {
                    case MaaPipelineTraceKind.NodeStarted:
                        Log($"进图 Pipeline 节点开始：{task}");
                        break;
                    case MaaPipelineTraceKind.NodeCompleted:
                        Log($"进图 Pipeline 节点完成：{task}，耗时 {value.Duration.TotalMilliseconds:0}ms");
                        break;
                    case MaaPipelineTraceKind.NodeFailed:
                    case MaaPipelineTraceKind.TaskChainFailed:
                        Log($"进图 Pipeline 失败：{task}，{value.Error ?? value.Detail}");
                        break;
                    case MaaPipelineTraceKind.BranchSelected:
                        Log($"进图 Pipeline 分支：{task} -> {value.Detail ?? "结束"}");
                        break;
                }
            });
            var entryOperation = automation.RunAsync(selection, owner.Token, new MaaPipelineTraceMultiplexer([trace, liveTrace]));
            operation = entryOperation;
            activeEntry = entryOperation;
            var result = await entryOperation;
            try
            {
                var tracePath = Path.Combine(AppContext.BaseDirectory, "pipeline-traces", $"dungeon-entry-{result.RunId}.json");
                trace.SaveJson(tracePath);
                Log($"进图 Pipeline 节点诊断已保存：{tracePath}");
            }
            catch (Exception ex) { Log($"进图 Pipeline 节点诊断保存失败：{ex.Message}"); }

            if (result.Status == MaaPipelineExecutionStatus.Canceled)
            {
                Log("自动进图已取消");
                State("自动进图已取消");
            }
            else if (!result.Succeeded)
            {
                Log($"自动进图失败：{result.Error ?? result.Status.ToString()}");
                State("自动进图失败");
            }
        }
        catch (OperationCanceledException) { Log("自动进图已取消"); State("自动进图已取消"); }
        finally
        {
            if (ReferenceEquals(activeEntry, operation)) activeEntry = null;
            if (ReferenceEquals(entryCts, owner)) entryCts = null;
            owner.Dispose();
            UpdateDeviceAvailability();
        }
    }

    async Task StartRunCore()
    {
        MaaPipelineCatalog catalog;
        try
        {
            var path = Path.Combine(AppContext.BaseDirectory, "pipelines", "map-run-pipeline.json");
            catalog = MaaPipelineCatalogLoader.Load(path);
        }
        catch (Exception ex)
        {
            Error(ex);
            State("任务流水线配置无效");
            return;
        }

        var trace = new MaaPipelineTraceCollector();
        var liveTrace = new DelegateMaaPipelineTraceSink(value =>
        {
            var task = value.TaskName ?? value.TaskChain;
            switch (value.Kind)
            {
                case MaaPipelineTraceKind.CandidateRecognized:
                    Log($"MAA Pipeline 识别：{task}，命中={value.Matched}，得分={value.Score:0.000}，详情={value.Detail ?? "-"}");
                    break;
                case MaaPipelineTraceKind.NodeStarted:
                    Log($"MAA Pipeline 节点开始：{task}，第 {value.ExecutionCount} 次");
                    break;
                case MaaPipelineTraceKind.ActionStarted:
                    Log($"MAA Pipeline 动作：{task} / {value.Action}");
                    break;
                case MaaPipelineTraceKind.NodeCompleted:
                    Log($"MAA Pipeline 节点完成：{task}，耗时 {value.Duration.TotalMilliseconds:0}ms");
                    break;
                case MaaPipelineTraceKind.NodeFailed:
                case MaaPipelineTraceKind.TaskChainFailed:
                    Log($"MAA Pipeline 失败：{task}，{value.Error ?? value.Detail}");
                    break;
                case MaaPipelineTraceKind.BranchSelected:
                    Log($"MAA Pipeline 分支：{task} -> {value.Detail ?? "停止"}");
                    break;
                case MaaPipelineTraceKind.Retrying:
                    Log($"MAA Pipeline 重试：{value.Detail}");
                    break;
            }
        });
        var pipeline = new MaaPipeline<MainForm>(
            catalog,
            [new DelegateMaaPipelineHandler<MainForm>(
                "RunDungeon",
                (_, _, _) => Task.FromResult(MaaPipelineRecognitionResult.Hit(detail: "JustReturn")),
                async (_, _, context, token) =>
                {
                    var result = await context.State.RunDungeonTaskCore(token);
                    return result.Succeeded
                        ? MaaPipelineActionResult.Success()
                        : MaaPipelineActionResult.Failure(result.Error ?? "跑图任务失败");
                })],
            new MaaPipelineExecutionOptions { TaskChain = "MapRun", RetryTimes = 0 },
            new MaaPipelineTraceMultiplexer([trace, liveTrace, pipelineWebServer]));

        var result = await pipeline.RunAsync(this, ["RunDungeon"]);
        try
        {
            var tracePath = Path.Combine(AppContext.BaseDirectory, "pipeline-traces", $"map-run-{result.RunId}.json");
            trace.SaveJson(tracePath);
            Log($"MAA Pipeline 节点诊断已保存：{tracePath}");
        }
        catch (Exception ex) { Log($"MAA Pipeline 节点诊断保存失败：{ex.Message}"); }
        if (!result.Succeeded && result.Status != MaaPipelineExecutionStatus.Canceled)
        {
            State("任务流水线失败");
            Log($"MAA Pipeline 已停止：{result.Status}，{result.Error}");
        }
    }

    async Task<TaskPipelineNodeResult> RunDungeonTaskCore(CancellationToken pipelineToken)
    {
        if (runCts is not null) return TaskPipelineNodeResult.Failure("已有跑图任务正在运行");
        // 停层标记只属于上一次运行。停止后玩家可能已手动重新进图，
        // 每次开始都必须刷新地图，再按当前楼层和剩余目标判断是否停住。
        targetFloorStopped = false;
        floorMiningCompletedLevel = -1;
        floorMiningSkippedLevel = -1;
        using var linkedOwner = CancellationTokenSource.CreateLinkedTokenSource(pipelineToken);
        var owner = linkedOwner;
        runCts = owner;
        touch.MovementCancellation = owner.Token;
        try
        {
            var startup = Stopwatch.StartNew();
            State("开始前刷新地图并强制规划");
            bool ready;
            try
            {
                ready = await RefreshMap(true, waitForLock: true, onMapReady: () =>
                {
                    var planning = Stopwatch.StartNew();
                    ReplanFromCurrentMap();
                    Log($"导航规划就绪 {startup.ElapsedMilliseconds} ms，其中路径规划 {planning.ElapsedMilliseconds} ms");
                    State("路线已规划，等待弹窗检查完成");
                });
            }
            finally
            {
                // RefreshMap 已完成启动时的截图/OCR预检；从这里开始让 watchdog
                // 负责新出现的覆盖层，并保持移动期间的独立探测。
                startupPreparing = false;
            }
            if (motionInterrupt.Reason == MotionInterruptReason.Popup)
                await HandleMovementPopupInterrupt(owner.Token);
            if (serverErrorDialogVisible || owner.IsCancellationRequested)
            {
                if (runCts == owner) runCts = null;
                owner.Dispose();
                return serverErrorDialogVisible
                    ? TaskPipelineNodeResult.Failure("服务器连接异常")
                    : TaskPipelineNodeResult.Success();
            }
            // 刷新已经等待完成的标题 OCR（包括模型启动）。
            // 重复执行否定检查会拖慢每次正常启动；移动开始后由移动看门狗监控新覆盖层。
            if ((!ready || currentMap is null) && !runeSelectionVisible && floorPhase != FloorPhase.SelectBonus)
            {
                State("地图未就绪");
                runCts = null;
                owner.Dispose();
                return TaskPipelineNodeResult.Failure("地图未就绪");
            }
            // 宝石选择覆盖层会消耗所有触摸输入。不要在其下方构建或启动移动路线；
            // RunLoop 会先执行有界的点击/重试序列，关闭后再恢复。
            if (runeSelectionVisible)
            {
                route = [];
                plannedInteractions = [];
                plannedTargetUniverse.Clear();
                mapPanel.Route = route;
                mapPanel.Invalidate();
                State("秘境宝石选择：等待自动选择");
                Log("启动检查已锁存秘境宝石选择，先执行一次专用点击流程");
                await HandleRiftGemSelection(owner.Token);
                await RunLoop(owner, useInitialSnapshot: true);
                return TaskPipelineNodeResult.Success();
            }
            if (floorPhase != FloorPhase.WaitingFloorLoad && await TryStopAtTargetFloor())
            {
                if (runCts == owner) runCts = null;
                owner.Dispose();
                return TaskPipelineNodeResult.Success();
            }
            Log($"导航启动检查完成 {startup.ElapsedMilliseconds} ms");
            if (owner.IsCancellationRequested || runCts != owner)
            {
                owner.Dispose();
                return TaskPipelineNodeResult.Success();
            }
            State("运行中");
            await RunLoop(owner, useInitialSnapshot: true);
            return TaskPipelineNodeResult.Success();
        }
        catch (OperationCanceledException)
        {
            startupPreparing = false;
            if (runCts == owner) runCts = null;
            owner.Dispose();
            return TaskPipelineNodeResult.Success();
        }
        catch (Exception ex)
        {
            startupPreparing = false;
            if (runCts == owner) runCts = null;
            owner.Dispose();
            Error(ex);
            return TaskPipelineNodeResult.Failure(ex.Message);
        }
    }
    async Task RunLoop(CancellationTokenSource owner, bool useInitialSnapshot = false)
    {
        // 使用一次启动时刚检查过的快照；后续迭代继续执行常规的地图/覆盖层刷新。
        var skipRefreshForConfirmedTaskStop = useInitialSnapshot;
        try
        {
            while (!owner.IsCancellationRequested)
            {
                if (motionInterrupt.Reason == MotionInterruptReason.Popup)
                {
                    await HandleMovementPopupInterrupt(owner.Token);
                    continue;
                }
                // RouteExecutor 已在每个分段边界执行释放后的玩家状态读取。
                // 当该读取确认已到达规划的任务停靠点时，直接使用该结果，
                // 不必在发送交互前再次进行完整的地图/弹窗刷新。
                // 下面的交互分支仍会执行自己的最终释放和坐标检查。
                if (skipRefreshForConfirmedTaskStop) skipRefreshForConfirmedTaskStop = false;
                else await RefreshMap(false);
                if (serverErrorDialogVisible || owner.IsCancellationRequested) break;
                // 看门狗在宝石选择锁存期间暂停探测；由主循环复用同一套
                // OCR/弹窗管线确认它已关闭，避免点击后永久停留在宝石状态。
                if (runeSelectionVisible)
                {
                    await RefreshOverlayState(false, failSafe: true);
                    if (serverErrorDialogVisible || owner.IsCancellationRequested) break;
                }
                if (runeSelectionVisible)
                {
                    await HandleRiftGemSelection(owner.Token);
                    continue;
                }
                if (currentMap is null)
                {
                    State("地图未就绪，等待弹窗/地图数据");
                    await Task.Delay(120, owner.Token);
                    continue;
                }
                // InBattle 由游戏运行时导出，是唯一必须暂停路线执行的状态。
                // 保留现有路线和目标，使移动能在胜利或逃跑后恢复，而不必无谓地重新规划。
                if (currentMap.InBattle)
                {
                    await touch.EmergencyRelease();
                    State("战斗中，已停止移动");
                    await Task.Delay(120, owner.Token);
                    continue;
                }
                UpdateFloorPhase();
                if (pendingRoomPortal is { } waitingRoomPortal && roomPortalOrigin is { } roomOrigin)
                {
                    var now = new Cell(currentMap.Player.X, currentMap.Player.Y);
                    if (now == roomOrigin && Environment.TickCount64 - roomPortalInteractionAt < 5000)
                    {
                        State($"等待层内传送门跳转 {waitingRoomPortal.Cell}");
                        await Task.Delay(80, owner.Token);
                        continue;
                    }
                    // 到达传送门格但没有自动跳转，仍是有效的中间状态：
                    // 保留规划的交互，以便下一个分支触发它。
                    if (now != waitingRoomPortal.Cell)
                    {
                        if (now == roomOrigin)
                            Log($"层内传送门 {waitingRoomPortal.Cell} 超时未改变坐标，按当前位置恢复寻路");
                        pendingRoomPortal = null; roomPortalOrigin = null; roomPortalInteractionAt = 0;
                        route = []; plannedInteractions = []; plannedTargetUniverse.Clear();
                        mapPanel.Route = route; mapPanel.Invalidate();
                    }
                }
                if (floorPhase == FloorPhase.WaitingFloorLoad)
                {
                    State($"等待新层加载 {(newFloorStartDelay.Value / 1000):0.##} 秒");
                    await Task.Delay(80, owner.Token); continue;
                }
                if (await TryStopAtTargetFloor()) break;
                // 已满足的楼层门控优先于探索。快捷入口会自行检查活动目标/Boss，
                // 即使当前地图仍有迷雾，也允许继续前进。
                if (await TryUseNextFloorShortcut(owner.Token))
                {
                    await Task.Delay(80, owner.Token);
                    continue;
                }
                ReconcileCompletedTasks();
                // 传送门停靠点是一个同步点。玩家到达该格后，
                // 必须先完成交互，再让普通规划将路线视为耗尽并替换它。
                var atPlannedInteractionStop = IsAtPlannedInteractionStop(new Cell(currentMap.Player.X, currentMap.Player.Y));
                if (!atPlannedInteractionStop)
                {
                    if (floorPhase == FloorPhase.GoToPortal) EnsurePortalRoute();
                    else if (floorPhase is not (FloorPhase.InteractPortal or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)) EnsureRoute();
                }
                if (floorPhase == FloorPhase.SelectBonus)
                {
                    portalChoiceCoroutine ??= coroutines.Start(SelectBonusRoutine, owner.Token);
                    var yieldedTask = coroutines.Tick(portalChoiceCoroutine, Environment.TickCount64);
                    if (yieldedTask is not null) await yieldedTask.WaitAsync(owner.Token);
                    if (portalChoiceCoroutine.IsCompleted)
                        portalChoiceCoroutine = null;
                    await Task.Delay(10, owner.Token);
                    continue;
                }
                if (floorPhase == FloorPhase.VerifyTransition)
                {
                    if (Environment.TickCount64 - portalInteractionAt > 8000)
                    {
                        Log("选择加成后 8 秒仍未检测到换层，重新确认传送门入口"); floorPhase = FloorPhase.GoToPortal; portalCandidate = null; portalConfirmCount = 0;
                    }
                    await Task.Delay(50, owner.Token); continue;
                }
                var currentCell = new Cell(currentMap.Player.X, currentMap.Player.Y);
                var plannedTask = plannedInteractions.FirstOrDefault(task => task.Stop == currentCell &&
                    (HasTarget(task.Target) || PortalRouting.IsPortalKind(task.Target.Kind)));
                if (plannedTask != default)
                {
                    // 路线可能在长按分段后立即结束。
                    // 在任务停靠点强制执行第二次同步释放，避免交互准备期间
                    // 飞行中的方向指令提交额外的地图格。
                    await touch.TouchUp();
                    await Task.Delay(20, owner.Token);
                    var interactionStatus = await adb.ReadPlayer();
                    if (interactionStatus.MoveSpeed > 0) currentMoveSpeed = interactionStatus.MoveSpeed;
                    var settledCell = new Cell(interactionStatus.Player.X, interactionStatus.Player.Y);
                    currentMap.Player = interactionStatus.Player;
                    mapPanel.Invalidate();
                    if (settledCell != currentCell)
                    {
                        Log($"交互位置坐标复核不一致：期望 {currentCell}，实际 {settledCell}，重新规划");
                        // 不要在此处退出 RunLoop。任务停靠点的超调会同时使路线和交互停靠点失效，
                        // 但自动化必须继续运行，并从权威位置重新构建。
                        await RefreshMap(false, waitForLock: true);
                        route = [];
                        plannedInteractions = [];
                        plannedTargetUniverse.Clear();
                        mapPanel.Route = route;
                        mapPanel.Invalidate();
                        if (PortalRouting.IsPortalKind(plannedTask.Target.Kind) && !IsRoomPortalTarget(plannedTask.Target))
                        {
                            floorPhase = FloorPhase.GoToPortal;
                            EnsurePortalRoute();
                        }
                        else EnsureRoute(true);
                        await Task.Delay(10, owner.Token);
                        continue;
                    }
                    currentCell = settledCell;
                    var delta = new Cell(plannedTask.Target.Cell.X - currentCell.X, plannedTask.Target.Cell.Y - currentCell.Y);
                    State($"任务交互 {plannedTask.Target.Kind}，方向 {delta.X},{delta.Y}");
                    var isRoomPortal = IsRoomPortalTarget(plannedTask.Target);
                    if (isRoomPortal)
                    {
                        if (await SendInteraction((delta, plannedTask.Target.Kind), owner.Token))
                        {
                            await HandleMovementPopupInterrupt(owner.Token);
                            continue;
                        }
                        attemptedRoomPortals.Add(plannedTask.Target.Cell);
                        pendingRoomPortal = plannedTask.Target;
                        roomPortalOrigin = currentCell;
                        roomPortalInteractionAt = Environment.TickCount64;
                    }
                    else if (PortalRouting.IsPortalKind(plannedTask.Target.Kind))
                    {
                        // 到达楼层传送门后，必须在任何换层动作前完成挖矿判断。
                        // 这里既覆盖传送门交互，也覆盖同一位置出现的右侧快捷入口，
                        // 防止先触发“前往下一层”弹窗后才进入挖矿流程。
                        if (await TryMineBeforeFloorTransition(owner.Token, transitionAvailable: true))
                        {
                            await Task.Delay(20, owner.Token);
                            continue;
                        }
                        // 常规循环会在路线执行前检查目标楼层，但此传送门任务是路线停止后
                        // 到达的第二条转场路径。在任何传送门交互前立即重新检查，
                        // 避免快捷入口绕过楼层停止设置。
                        if (currentMap is not null && IsTargetStopFloor(currentMap))
                        {
                            if (await TryStopAtTargetFloor()) break;
                            if (!shortcutDeferredByTargets)
                                Log("已到达指定层，但停层条件尚未满足，暂不交互传送门");
                            shortcutDeferredByTargets = true;
                            floorPhase = FloorPhase.Explore;
                            route = [];
                            plannedInteractions = [];
                            plannedTargetUniverse.Clear();
                            mapPanel.Route = route;
                            mapPanel.Invalidate();
                            await Task.Delay(80, owner.Token);
                            continue;
                        }

                        var hasShortcut = await adb.HasNextFloorButton();
                        Log($"传送门快捷入口检测：{(hasShortcut ? "存在" : "不存在")}");
                        if (hasShortcut)
                        {
                            await adb.TapScreen(0.890625, 0.498);
                            Log("检测到右侧‘前往下层’快捷入口，已点击");
                        }
                        else if (await SendInteraction((delta, plannedTask.Target.Kind), owner.Token))
                        {
                            await HandleMovementPopupInterrupt(owner.Token);
                            continue;
                        }
                    }
                    else if (IsCombatInteraction(plannedTask.Target.Kind))
                    {
                        if (await FightWhileHolding(plannedTask, owner.Token))
                        {
                            await HandleMovementPopupInterrupt(owner.Token);
                            continue;
                        }
                    }
                    else if (await SendInteraction((delta, plannedTask.Target.Kind), owner.Token))
                    {
                        await HandleMovementPopupInterrupt(owner.Token);
                        continue;
                    }
                    if (plannedTask.Target.Kind == "密室")
                    {
                        interactedChambers.Add(plannedTask.Target.Cell);
                        Log($"已记录密室交互：{plannedTask.Target.Cell}，等待游戏地图刷新");
                    }
                    // 任务停靠点是一个同步点。到达任务且没有再次摆动后，
                    // 恢复常规连续移动模式，执行下一个分段。
                    pulseFallbackNavigation = false;
                    Log($"触发计划任务 {plannedTask.Target.Kind} {plannedTask.Target.Cell}，等待地图确认；不重规划");
                    if (isRoomPortal)
                    {
                        plannedInteractions.Remove(plannedTask);
                        route = []; plannedTargetUniverse.Clear(); floorPhase = FloorPhase.Explore;
                        mapPanel.Route = route; mapPanel.Invalidate();
                        State("已交互层内传送门，等待服务端跳转");
                    }
                    else if (PortalRouting.IsPortalKind(plannedTask.Target.Kind))
                    {
                        plannedInteractions.Remove(plannedTask); floorPhase = FloorPhase.SelectBonus;
                        portalInteractionAt = Environment.TickCount64;
                        portalDialogPausedMs = 0;
                        State("已交互传送门，等待换层弹窗");
                    }
                    await Task.Delay(50, owner.Token);
                    continue;
                }
                if (route.Count < 2)
                {
                    var reachableTargets = ReachableActiveTargets(currentMap, Options());
                    if (floorPhase == FloorPhase.Explore && reachableTargets.Count == 0)
                    {
                        // 当前没有可到达的目标时，探索是主要动作。
                        // 在检查下一层快捷入口前先执行探索；否则当前地图仍有未发现路径时，
                        // 快捷入口可能会抢先执行。
                        if (TryPlanExplorationRoute())
                        {
                            await Task.Delay(20, owner.Token);
                            continue;
                        }
                        if (await TryExploreWithoutTarget(owner.Token)) continue;
                    }
                    // 探索规划失败时，不能在右侧下一层快捷入口出现前终止运行。
                    // 这是探索已经没有剩余路线时的回退逻辑。
                    if (await TryUseNextFloorShortcut(owner.Token))
                    {
                        await Task.Delay(80, owner.Token);
                        continue;
                    }
                    if (floorPhase == FloorPhase.GoToPortal)
                    {
                        State("传送门暂不可达，等待道路更新");
                        portalCandidate = null; portalConfirmCount = 0;
                        await Task.Delay(100, owner.Token); continue;
                    }
                    if (floorPhase == FloorPhase.Explore && reachableTargets.Count == 0)
                    {
                        State("探索地图，等待发现勾选目标");
                        await Task.Delay(180, owner.Token);
                        continue;
                    }
                    if (await TryPlanningRecovery(owner.Token)) continue;
                    if (reachableTargets.Count == 0)
                    {
                        State("无有效目标，等待下一层入口");
                        await Task.Delay(180, owner.Token);
                        continue;
                    }
                    State("无目标"); break;
                }
                ArmRoomPortalTransition();
                var routeResult = await ExecuteRouteSlice(owner.Token);
                if (routeResult.InterruptedByPopup)
                {
                    await HandleMovementPopupInterrupt(owner.Token);
                    continue;
                }
                if (routeResult.RequiresReplan)
                {
                    // 执行器已经采样了玩家实际所在格，但替换失败路线前也要刷新格子表。
                    // 这样可以防止超调/偏离后在紧循环中重试过期路线。
                    await RefreshMap(false, waitForLock: true);
                    if (floorPhase == FloorPhase.GoToPortal) EnsurePortalRoute();
                    else if (floorPhase is not (FloorPhase.InteractPortal or FloorPhase.SelectBonus or FloorPhase.VerifyTransition)) EnsureRoute(true);
                }
                else if (currentMap is not null)
                {
                    var arrived = new Cell(currentMap.Player.X, currentMap.Player.Y);
                    skipRefreshForConfirmedTaskStop = plannedInteractions.Any(task => task.Stop == arrived &&
                        (HasTarget(task.Target) || PortalRouting.IsPortalKind(task.Target.Kind)));
                    if (skipRefreshForConfirmedTaskStop) continue;
                }
                await Task.Delay(10, owner.Token);
            }
        }
        catch (OperationCanceledException) { }
        catch (Exception ex) { Error(ex); }
        finally
        {
            coroutines.StopAll(); portalChoiceCoroutine = null;
            try { await touch.TouchUp(); } catch (Exception ex) { Error(ex); }
            if (ReferenceEquals(runCts, owner)) runCts = null;
            owner.Dispose();
        }
    }

    async Task HandleRiftGemSelection(CancellationToken token)
    {
        await touch.EmergencyRelease();
        var now = Environment.TickCount64;
        const int maxAttempts = 5;
        const int retryIntervalMs = 700;
        if (runeSelectionClickAttempts < maxAttempts &&
            (runeSelectionClickAttempts == 0 || now - runeSelectionLastClickAt >= retryIntervalMs))
        {
            if (runeSelectionCard < 0) runeSelectionCard = Random.Shared.Next(3);
            try
            {
                await adb.TapRiftGemCard(runeSelectionCard);
                runeSelectionClickAttempts++;
                runeSelectionLastClickAt = now;
                Log($"已识别秘境宝石标题，点击第 {runeSelectionCard + 1} 张卡片（第 {runeSelectionClickAttempts}/{maxAttempts} 次）");
                State($"秘境宝石选择：点击第 {runeSelectionCard + 1} 张，等待界面关闭");
            }
            catch (Exception ex)
            {
                runeSelectionClickAttempts++;
                runeSelectionLastClickAt = now;
                Error(ex);
            }
        }
        else if (runeSelectionClickAttempts >= maxAttempts)
        {
            State("秘境宝石选择：点击未确认，继续轮询");
        }
        else State("秘境宝石选择界面，等待关闭");
        await Task.Delay(80, token);
    }

    void LatchRiftGemSelection()
    {
        runeSelectionMisses = 0;
        if (runeSelectionVisible) return;

        runeSelectionStartedAt = Environment.TickCount64;
        if (floorPhase == FloorPhase.SelectBonus)
            portalInteractionBlockedByGem = true;
        runeSelectionCard = -1;
        runeSelectionClickAttempts = 0;
        runeSelectionLastClickAt = 0;
        runeSelectionVisible = true;
        Log($"检测到秘境宝石选择界面，标题：{adb.LastRiftGemTitle ?? "<空>"}，暂停移动等待选择");
    }

    void ClearRiftGemSelectionState()
    {
        runeSelectionVisible = false;
        runeSelectionMisses = 0;
        runeSelectionStartedAt = 0;
        runeSelectionCard = -1;
        runeSelectionClickAttempts = 0;
        runeSelectionLastClickAt = 0;
        portalInteractionBlockedByGem = false;
    }

    System.Collections.IEnumerator SelectBonusRoutine(CancellationToken token)
    {
        while (true)
        {
            token.ThrowIfCancellationRequested();

            // 一个截图内按固定顺序区分三类换层界面：
            // 1) 带红字提醒的“贪婪选择”三选一；
            // 2) 带红字提醒的“是否进入下一层？”；
            // 3) 无红字提醒的“是否进入下一层？”。
            // 后两类虽然外观文本不同，但动作都是点击绿色对勾。
            var dialog = pendingNextFloorDialog;
            var greedySelectionReturnOnly = pendingGreedySelectionReturnOnly;
            pendingNextFloorDialog = NextFloorDialogKind.None;
            pendingGreedySelectionReturnOnly = false;
            if (dialog == NextFloorDialogKind.None)
            {
                // SelectBonus 会暂停 PopupWatchdog，因此必须使用与看门狗
                // 相同的共享管线，否则宝石覆盖层可能被当成未识别的换层框。
                var popupTask = adb.ProbeMovementPopupAsync(token);
                yield return popupTask;
                var probe = popupTask.GetAwaiter().GetResult();
                var popup = probe.Value;
                if (probe.NextFloorDialogBodyText is not null)
                    Log($"换层弹窗 OCR 正文：{probe.NextFloorDialogBodyText.Replace("\r", " ").Replace("\n", "|")}");
                if (popup == MovementPopupKind.ServerError)
                {
                    serverErrorDialogVisible = true;
                    runCts?.Cancel();
                    yield break;
                }
                if (popup == MovementPopupKind.RiftGemSelection)
                {
                    LatchRiftGemSelection();
                    yield break;
                }
                dialog = popup == MovementPopupKind.NextFloorDialog
                    ? probe.NextFloorDialog
                    : NextFloorDialogKind.None;
                greedySelectionReturnOnly = probe.GreedySelectionReturnOnly;
            }
            if (dialog is NextFloorDialogKind.WarningConfirm or NextFloorDialogKind.PlainConfirm)
            {
                var tapTask = adb.TapScreen(0.591, 0.639);
                yield return tapTask;
                Log(dialog == NextFloorDialogKind.WarningConfirm
                    ? "检测到带红字提醒的‘是否进入下一层？’，已点击绿色确认按钮"
                    : "检测到无红字提醒的‘是否进入下一层？’，已点击绿色确认按钮");
                floorPhase = FloorPhase.VerifyTransition;
                portalInteractionAt = Environment.TickCount64;
                State("已确认进入下一层，等待换层");
                yield break;
            }
            if (dialog == NextFloorDialogKind.GreedySelection)
            {
                var preferred = bonusPriority.Items.Count == 0 ? "增益效果" : bonusPriority.Items[0]?.ToString() ?? "增益效果";
                var cardIndex = preferred switch { "回复药剂" => 1, "道具" or "魔法材料" => 2, _ => 0 };
                var selectTask = adb.TapScreen(cardIndex switch { 1 => 0.50, 2 => 0.6875, _ => 0.3125 }, 0.657);
                yield return selectTask;
                if (greedySelectionReturnOnly)
                {
                    Log($"弹窗按钮点击已发送：{preferred}，已选择‘安全回城’");
                    State("已选择安全回城，等待返回城镇");
                    runCts?.Cancel();
                    yield break;
                }
                Log($"弹窗按钮点击已发送：{preferred}，等待界面关闭");
                Log($"已选择下一层加成：{preferred}");
                floorPhase = FloorPhase.VerifyTransition;
                portalInteractionAt = Environment.TickCount64;
                State("已选择加成，等待进入下一层");
                yield break;
            }

            // 三类都未识别：只等待一小段时间，再从第一类重新检测。
            yield return new WaitForMilliseconds(PortalDialogRetryDelayMs);
        }
    }

    RouteExecutor CreateRouteExecutor() => new(adb, touch,
        () => currentMap, map => { currentMap = map; mapPanel.Map = map; },
        () => route, () => plannedInteractions, HasTarget, InputDelta,
        () => currentMoveSpeed, value => currentMoveSpeed = value,
        () => (int)movementReleaseLead.Value, () => (int)singleCellPulseHold.Value, () => (int)stallTimeout.Value,
        blocked, State, Log, () => mapPanel.Invalidate(),
        () => pulseFallbackNavigation, value => pulseFallbackNavigation = value);

    void Pause()
    {
        runCts?.Cancel();
        coroutines.StopAll(); portalChoiceCoroutine = null;
        State("正在暂停");
    }

    void CancelPortalChoiceCoroutine()
    {
        coroutines.Stop(portalChoiceCoroutine);
        portalChoiceCoroutine = null;
    }

    Task Step() => RunMovement(StepCore);

    async Task StepCore()
    {
        using var owner = new CancellationTokenSource();
        runCts = owner;
        touch.MovementCancellation = owner.Token;
        try
        {
            await RefreshMap(false);
            owner.Token.ThrowIfCancellationRequested();
            if (currentMap is null)
            {
                Log("单步跳过：当前没有有效地图快照，请先刷新地图");
                State("地图未就绪");
                return;
            }
            var blockedBefore = blocked.Count;
            var plan = Planner.PlanForFloorRecoveringTemporaryBlocks(currentMap, Options(), blocked, visitedMechanisms);
            if (blockedBefore > 0 && blocked.Count == 0)
                Log($"临时封锁切断全部目标路线，已撤销 {blockedBefore} 个封锁并恢复规划");
            route = plan.Route; plannedInteractions = plan.Interactions; plannedTargetUniverse = plan.TargetUniverse;
            mapPanel.Route = route; mapPanel.Invalidate(); if (route.Count < 2) { State("无目标"); Pause(); return; }
            var before = new Cell(currentMap.Player.X, currentMap.Player.Y); var next = route[1]; var delta = new Cell(next.X - before.X, next.Y - before.Y);
            var runLength = 1;
            while (runLength + 1 < route.Count)
            {
                var following = new Cell(route[runLength + 1].X - route[runLength].X, route[runLength + 1].Y - route[runLength].Y);
                if (following != delta) break;
                runLength++;
            }
            var expected = route[runLength]; var after = before; var lastChange = Environment.TickCount64; var previousPosition = before;
            State($"按住 {delta.X},{delta.Y}，等待到达 {expected}");
            var popupInterrupted = await RunMovementSlice(owner.Token, async sliceToken =>
            {
                await touch.TouchDown(InputDelta(delta), sliceToken);
                try
                {
                    while (after != expected)
                    {
                        await Task.Delay(20, sliceToken);
                        var status = await adb.ReadPlayer(); after = new Cell(status.Player.X, status.Player.Y);
                        if (after != previousPosition) { previousPosition = after; lastChange = Environment.TickCount64; }
                        var routeIndexNow = route.FindIndex(1, runLength, cell => cell == after);
                        if (after != before && routeIndexNow < 1) break;
                        if (Environment.TickCount64 - lastChange >= (long)stallTimeout.Value) break;
                    }
                }
                finally { await touch.TouchUp(); }
            });
            if (popupInterrupted)
            {
                await HandleMovementPopupInterrupt(owner.Token);
                return;
            }
            Log($"坐标触发松开：{before} -> {after}，转向/停止点 {expected}");
            if (after == before)
            {
                unchangedCount = lastBlockedAttempt == next ? unchangedCount + 1 : 1; lastBlockedAttempt = next;
                if (unchangedCount >= 2) { blocked.Add(next); unchangedCount = 0; Log($"格子 {next} 连续受阻，临时封锁并绕路"); }
                else Log("未发生位移，将重新规划");
            }
            else
            {
                unchangedCount = 0; lastBlockedAttempt = null;
                var routeIndex = route.FindIndex(1, Math.Min(runLength, route.Count - 1), cell => cell == after);
                if (routeIndex < 1) Log("实际位置不在当前直线路段，已暂停并等待重新校准");
                else if (after != expected) Log($"本次实际前进 {routeIndex} 格，下轮从真实坐标继续");
                if (routeIndex < 1) Pause();
            }
        }
        catch (OperationCanceledException) { }
        catch (Exception ex) { Error(ex); Pause(); }
        finally { if (ReferenceEquals(runCts, owner)) runCts = null; }
    }

    async Task Stop() { Pause(); try { await touch.EmergencyRelease(); } catch { } State("已急停"); Log("急停：停止发送方向操作"); }
    async Task EmergencyStopAndClear()
    {
        await StopMovement();
        floorPhase = FloorPhase.Explore;
        portalCandidate = null; portalConfirmCount = 0; portalInteractionAt = 0;
        coroutines.StopAll(); portalChoiceCoroutine = null;
        routeSession.Clear();
        pendingNextFloorDialog = NextFloorDialogKind.None;
        pendingGreedySelectionReturnOnly = false;
        blocked.Clear(); lastBlockedAttempt = null; unchangedCount = 0;
        confirmedCompletedTargets.Clear(); expectedTaskRoadChanges.Clear(); pulseFallbackNavigation = false;
        shortcutDeferredByTargets = false;
        targetFloorStopped = false;
        floorMiningCompletedLevel = -1;
        floorMiningSkippedLevel = -1;
        attemptedRoomPortals.Clear(); pendingRoomPortal = null; roomPortalOrigin = null; roomPortalInteractionAt = 0;
        portalJumps.Clear(); portalUnlocks.Clear();
        mapPanel.Route = route; mapPanel.Invalidate(); State("急停"); Log("急停：已停止移动并清除换层流程");
    }
    void Log(string text) { if (IsDisposed || Disposing) return; if (InvokeRequired) { BeginInvoke(() => Log(text)); return; } log.AppendText($"[{DateTime.Now:HH:mm:ss}] {text}\r\n"); }
    void State(string text) { if (IsDisposed || Disposing) return; if (InvokeRequired) { BeginInvoke(() => State(text)); return; } state.Text = text; mapPanel.StatusText = text; mapPanel.Invalidate(); }
    void Error(Exception ex) { CrashLog.Write("Controller operation", ex); Log("错误：" + ex.Message); State("错误"); }

    protected override void Dispose(bool disposing)
    {
        if (disposing) SystemEvents.UserPreferenceChanged -= OnUserPreferenceChanged;
        base.Dispose(disposing);
    }

    protected override void OnHandleCreated(EventArgs e)
    {
        base.OnHandleCreated(e);
        ApplyTheme();
    }
}
