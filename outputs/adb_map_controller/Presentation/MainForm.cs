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

public sealed partial class MainForm : Form, IRouteExecutionObserver
{
    readonly ControllerRuntime runtime;
    readonly ISettingsStore settingsStore;
    readonly AdbClient adb;
    readonly TouchController touch;
    readonly RouteExecutor routeExecutor;
    readonly DungeonSession dungeon = new();
    readonly MapPanel mapPanel = new() { Dock = DockStyle.Fill };
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
    readonly ThemedNumericUpDown entryRunCount = new() { Minimum = 0, Maximum = 9999, Increment = 1, Value = 0, Width = 62 };
    readonly ComboBox themeChoice = new ThemedComboBox { Width = 105, DropDownStyle = ComboBoxStyle.DropDownList };
    readonly CheckBox alwaysOnTop = Box("窗口置顶");
    readonly ListBox bonusPriority = new()
    {
        Width = 230,
        Height = 104,
        IntegralHeight = false,
        AllowDrop = true,
        SelectionMode = SelectionMode.One,
        BorderStyle = BorderStyle.FixedSingle,
        Tag = ThemeRole.Input
    };
    readonly ToolStripDropDown bonusPriorityPopup = new() { AutoClose = true, AutoSize = false, Padding = new Padding(3) };
    readonly Button bonusPriorityToggle = Btn("加成优先级", ThemeRole.SecondaryButton);
    readonly CheckBox mining = Box("挖矿");
    readonly CheckBox cardMining = Box("卡矿（自动匹配）");
    readonly CheckBox cardLayer = Box("卡层（自动匹配）");
    readonly CheckBox attackBoss = Box("攻击Boss"), monsters = Box("全清小怪"), elites = Box("清除精英"), chests = Box("箱子"), pots = Box("罐子"), bones = Box("石堆"), gold = Box("金币"), runes = Box("符文/点金台"), chambers = Box("密室");
    readonly ThemedRichTextBox log = new() { Dock = DockStyle.Fill, Multiline = true, ReadOnly = true, ScrollBars = RichTextBoxScrollBars.Vertical, Tag = ThemeRole.Log };
    readonly System.Windows.Forms.Timer refreshTimer = new() { Interval = 500 };
    readonly SemaphoreSlim refreshLock = new(1, 1);
    long lastOverlayUnknownLogAt;
    readonly SemaphoreSlim clickNavigationSwitch = new(1, 1);
    readonly ControllerOperations operations = new();
    readonly MovementExecution movementExecution;
    Task? activeMovement => operations.TaskFor(ControllerOperationKind.Movement);
    Task? activeEntry => operations.TaskFor(ControllerOperationKind.Entry);
    Task? shutdownTask;
    readonly OperationTracker uiOperations = new();
    bool closing, closeReady, stopping, scanning;
    bool lastMapRunSucceeded;
    bool entryRunMovementScope;
    List<Cell> route { get => dungeon.Route.Route; set => dungeon.Route.Route = value; }
    List<PlannedInteraction> plannedInteractions { get => dungeon.Route.Interactions; set => dungeon.Route.Interactions = value; }
    HashSet<TargetKey> plannedTargetUniverse { get => dungeon.Route.TargetUniverse; set => dungeon.Route.TargetUniverse = value; }
    // 游戏没有提供稳定且可供 Lua 读取的“机关点亮”字段。
    // 当实际观察到玩家站在机关格上时，按楼层记录确认状态；
    // 该状态可跨越地图刷新，从而避免反复为同一个机关重新规划。
    IReadOnlySet<Cell> visitedMechanisms => dungeon.Mechanisms.Visited;
    Dictionary<Cell, bool> plannedWalkability { get => dungeon.Route.Walkability; set => dungeon.Route.Walkability = value; }
    int? plannedOptionsSignature { get => dungeon.Route.OptionsSignature; set => dungeon.Route.OptionsSignature = value; }
    // 包含已经交互过的传送门，以及刚刚落地的传送门。
    // 传送目的地不能立即再次触发，否则一对传送门可能永远在 A -> B -> A 之间往返。
    FloorPhase floorPhase { get => dungeon.FloorState.Current; set => dungeon.FloorState.Transition(value); }
    readonly Random random = new();
    bool runeSelectionVisible;
    NextFloorDialogKind pendingNextFloorDialog;
    bool pendingGreedySelectionReturnOnly;
    IReadOnlyList<int> pendingGreedySelectionReturnCards = Array.Empty<int>();
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
    bool portalInteractionBlockedByGem;
    long portalInteractionAt;
    readonly CoroutineRunner coroutines = new();
    Coroutine? portalChoiceCoroutine;
    // 游戏原始单位/秒；游戏会将其除以 1000，得到每个地图格的单位数。
    int clickNavigationVersion;
    readonly EntryTemplateStore entryTemplates;
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
    static readonly string[] BonusKinds = [
        "增益效果",
        "魔法材料",
        "回复药剂",
        "道具",
        "物资",
        "锻造材料",
        "附魔材料"
    ];
    // 换层弹窗有入场动画，不能在一次截图失败后直接按三选一坐标盲点。
    // 每轮按固定顺序检查三类换层界面，全部未识别时短暂等待后持续重试。
    const int PortalDialogRetryDelayMs = 160;

    public MainForm(ControllerRuntime runtime, ISettingsStore settingsStore)
    {
        this.runtime = runtime ?? throw new ArgumentNullException(nameof(runtime));
        this.settingsStore = settingsStore ?? throw new ArgumentNullException(nameof(settingsStore));
        adb = runtime.Adb;
        touch = runtime.Touch;
        movementExecution = new MovementExecution(dungeon.MotionInterrupt);
        routeExecutor = new RouteExecutor(adb, touch);
        pipelineWebServer = runtime.PipelineMonitor;
        entryTemplates = new EntryTemplateStore(runtime.Paths.EntryTemplates);
        touch.InputFailed += ex => { operations.Cancel(ControllerOperationKind.Movement); operations.Cancel(ControllerOperationKind.Entry); Error(ex); };
        Text = "洞窟地图 ADB 控制器"; Width = 786; Height = 643; MinimumSize = new(786, 643);
        AutoScaleMode = AutoScaleMode.Dpi;
        Font = new Font("Segoe UI", 9F, FontStyle.Regular, GraphicsUnit.Point);
        attackBoss.Checked = true;
        themeChoice.Items.AddRange(["浅色", "深色", "跟随系统"]);
        themeChoice.SelectedIndex = 0;
        bonusPriority.Items.AddRange(BonusKinds); bonusPriority.SelectedIndex = 0;
        entryMapChoice.Items.AddRange(DungeonEntryCatalog.Maps.Select(x => x.Name).Cast<object>().ToArray());
        entryChoice.Items.AddRange(DungeonEntryCatalog.EntriesForMap(DungeonEntryCatalog.TimeGateMapId).Select(x => x.Name).Cast<object>().ToArray());
        entryMapChoice.SelectedIndex = 0; entryChoice.SelectedIndex = 0;
        RefreshEntryDifficulties(SelectedEntryMap, DungeonDifficulty.Normal);
        entryMapChoice.SelectedIndexChanged += (_, _) =>
        {
            var selectedEntryId = Math.Max(1, entryChoice.SelectedIndex + 1);
            var map = SelectedEntryMap;
            entryChoice.Items.Clear();
            entryChoice.Items.AddRange(DungeonEntryCatalog.EntriesForMap(map.Id)
                .Select(x => x.Name).Cast<object>().ToArray());
            entryChoice.SelectedIndex = Math.Clamp(selectedEntryId - 1, 0, Math.Max(0, entryChoice.Items.Count - 1));
            RefreshEntryDifficulties(map, SelectedEntryDifficulty);
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
        var top = new FlowLayoutPanel
        {
            Dock = DockStyle.Top,
            AutoSize = true,
            AutoSizeMode = AutoSizeMode.GrowAndShrink,
            Padding = new(10, 8, 10, 6),
            WrapContents = true,
            Tag = ThemeRole.Surface
        };
        var scan = Btn("扫描设备", ThemeRole.SecondaryButton); var refresh = Btn("刷新地图", ThemeRole.SecondaryButton);
        var plan = Btn("规划路线", ThemeRole.InfoButton); var start = Btn("开始", ThemeRole.SuccessButton); var pause = Btn("暂停", ThemeRole.WarningButton); var step = Btn("单步", ThemeRole.InfoButton); var stop = Btn("急停", ThemeRole.DangerButton);
        var autoEnter = Btn("进图并跑图", ThemeRole.SuccessButton); var calibrateEntry = Btn("更新入口模板", ThemeRole.UtilityButton);
        var openWebMonitor = Btn("Web监控", ThemeRole.InfoButton);
        var detectAssistant = Btn("检测助手", ThemeRole.UtilityButton); var installAssistant = Btn("安装助手", ThemeRole.UtilityButton); var restoreAssistant = Btn("恢复原版", ThemeRole.DangerButton); var openTestPanel = Btn("打开测试面板", ThemeRole.WarningButton);
        var mine = Btn("挖矿", ThemeRole.WarningButton);
        top.Controls.AddRange([refresh, plan, start, mine, pause, step, stop, autoEnter, calibrateEntry, openWebMonitor]);
        var settingsTop = new FlowLayoutPanel
        {
            Dock = DockStyle.Top,
            AutoSize = true,
            AutoSizeMode = AutoSizeMode.GrowAndShrink,
            Padding = new(10, 8, 10, 6),
            WrapContents = true,
            Tag = ThemeRole.Surface
        };
        settingsTop.Controls.AddRange([new Label { Text = "设备", AutoSize = true, Padding = new(0, 6, 0, 0) },
            devices,
            scan,
            detectAssistant,
            installAssistant,
            restoreAssistant,
            openTestPanel,
            assistantState,
            new Label { Text = "主题", AutoSize = true, Padding = new(10, 6, 0, 0) },
            themeChoice]);
        var options = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink, Padding = new(10, 9, 10, 4), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        options.Controls.AddRange([new Label { Text = "目标（钥匙必选）：", AutoSize = true }, attackBoss, monsters, elites, chests, pots, bones, gold, runes, chambers, bonusPriorityToggle]);
        var floorStop = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink, Padding = new(10, 4, 10, 4), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        floorStop.Controls.AddRange([new Label { Text = "指定层停住：", AutoSize = true }, targetStopFloor, new Label { Text = "层（0=关闭，完成所选目标后自动停住）", AutoSize = true }, mining, cardMining, cardLayer]);
        var entryOptions = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink, Padding = new(10, 4, 10, 4), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        entryOptions.Controls.AddRange([new Label { Text = "自动进图：", AutoSize = true }, entryMapChoice, entryChoice, entryDifficulty, new Label { Text = "跑图次数（0=自动）", AutoSize = true, Padding = new(4, 5, 0, 0) }, entryRunCount, new Label { Text = "自动时：普通无限；限次难度按关卡余量", AutoSize = true, Padding = new(4, 5, 0, 0), Tag = ThemeRole.WarningText }, new Label { Text = "入口识别：内置图标或当前地图场景模板", AutoSize = true, Padding = new(4, 5, 0, 0), Tag = ThemeRole.WarningText }]);
        var timing = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, AutoSizeMode = AutoSizeMode.GrowAndShrink, Padding = new(10, 7, 10, 5), WrapContents = true, Tag = ThemeRole.SurfaceAlt };
        timing.Controls.AddRange([new Label { Text = "时间参数：", AutoSize = true }, new Label { Text = "单格脉冲按住(ms)", AutoSize = true }, singleCellPulseHold, new Label { Text = "提前/延迟松开(ms)", AutoSize = true }, movementReleaseLead, new Label { Text = "交互按住(ms)", AutoSize = true }, interactionHold, new Label { Text = "卡住超时(ms)", AutoSize = true }, stallTimeout, new Label { Text = "新层启动延迟(ms)", AutoSize = true }, newFloorStartDelay, new Label { Text = "规划容错次数", AutoSize = true }, routeRecoveryAttempts]);
        var runPage = new ThemedTabPage { Text = "运行", Padding = new(0), Tag = ThemeRole.Default };
        runPage.Controls.Add(mapPanel); runPage.Controls.Add(top);
        var logPage = new ThemedTabPage { Text = "日志", Padding = new(0), Tag = ThemeRole.Default };
        logPage.Controls.Add(CreateLogView());
        var settingsPage = new ThemedTabPage { Text = "设置", Padding = new(0), Tag = ThemeRole.Default };
        settingsPage.Controls.Add(CreateMiningSettings());
        settingsPage.Controls.Add(timing); settingsPage.Controls.Add(floorStop); settingsPage.Controls.Add(entryOptions); settingsPage.Controls.Add(options); settingsPage.Controls.Add(settingsTop);
        var tabs = new ThemedTabControl { Dock = DockStyle.Fill, Tag = ThemeRole.Default };
        tabs.TabPages.Add(runPage); tabs.TabPages.Add(CreateTaskListPage()); tabs.TabPages.Add(settingsPage); tabs.TabPages.Add(logPage);
        Controls.Add(tabs);
        scan.Click += async (_, _) => await RunUi(Scan); refresh.Click += async (_, _) => await RunUi(() => RefreshMap()); plan.Click += async (_, _) => await RunUi(Replan); start.Click += async (_, _) => await RunUi(StartRun); pause.Click += async (_, _) => await RunUi(async () => { await StopMovement(); State("已暂停"); }); step.Click += async (_, _) => await RunUi(Step); stop.Click += async (_, _) => await RunUi(EmergencyStopAndClear);
        autoEnter.Click += async (_, _) => await RunUi(AutoEnter); calibrateEntry.Click += async (_, _) => await RunUi(CalibrateEntry);
        mine.Click += async (_, _) => await RunUi(StartMining);
        BuildWindowCaption();
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
            if (activeMovement is null && activeEntry is null && !uiOperations.IsBusy)
                await RefreshMap(false, lockDeviceSelection: false);
        }; Shown += async (_, _) => await RunUi(async () => { await Scan(); await RefreshMap(); if (!closing) refreshTimer.Start(); });
        foreach (var control in new Control[] { attackBoss, monsters, elites, chests, pots, bones, gold, runes, chambers, bonusPriority, singleCellPulseHold, movementReleaseLead, interactionHold, stallTimeout, newFloorStartDelay, routeRecoveryAttempts, targetStopFloor, mining, cardMining, cardLayer, entryMapChoice, entryChoice, entryDifficulty, entryRunCount })
            control.Validated += (_, _) => SaveSettings();
        foreach (var control in new Control[] { attackBoss, monsters, elites, chests, pots, bones, gold, runes, chambers })
        {
            control.Validated += (_, _) => dungeon.TargetFloorStopped = false;
            if (control is CheckBox checkBox) checkBox.CheckedChanged += (_, _) => dungeon.TargetFloorStopped = false;
        }
        foreach (var control in new Control[] { targetStopFloor })
            control.Validated += (_, _) => dungeon.TargetFloorStopped = false;
        targetStopFloor.ValueChanged += (_, _) => dungeon.TargetFloorStopped = false;
        mining.CheckedChanged += (_, _) => dungeon.TargetFloorStopped = false;
        cardMining.CheckedChanged += (_, _) => dungeon.TargetFloorStopped = false;
        cardLayer.CheckedChanged += (_, _) => dungeon.TargetFloorStopped = false;
        try
        {
            pipelineWebServer.Start();
            Log($"MAA Pipeline 本地 Web 监控已启动：{pipelineWebServer.Url}");
        }
        catch (Exception ex)
        {
            Log($"MAA Pipeline 本地 Web 监控启动失败：{ex.Message}", LogLevel.Error);
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
        try { await uiOperations.WhenIdleAsync(); } catch (Exception ex) { Error(ex); }
        await refreshLock.WaitAsync();
        try
        {
            try { await runtime.DisposeAsync(); } catch (Exception ex) { Error(ex); }
        }
        finally { refreshLock.Release(); }
        refreshTimer.Dispose();
        closeReady = true;
        Close();
    }
    void UpdateDeviceAvailability() => devices.Enabled = !closing && !uiOperations.IsBusy
        && !scanning && activeMovement is not { IsCompleted: false } && activeEntry is not { IsCompleted: false };

    async Task RunUi(Func<Task> action)
    {
        if (closing) return;
        devices.Enabled = false;
        try
        {
            await uiOperations.RunAsync(action);
        }
        catch (Exception ex) { Error(ex); }
        finally
        {
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
            Warn("MAA Pipeline 本地 Web 监控不可用");
            return;
        }

        try
        {
            Process.Start(new ProcessStartInfo(pipelineWebServer.Url) { UseShellExecute = true });
            Log($"已打开 MAA Pipeline Web 监控：{pipelineWebServer.Url}");
        }
        catch (Exception ex) { Error(ex); }
    }

    ThemeMode CurrentThemeMode => (ThemeMode)Math.Clamp(themeChoice.SelectedIndex, 0, 2);
    DungeonMapOption SelectedEntryMap => DungeonEntryCatalog.Maps[Math.Clamp(
        entryMapChoice.SelectedIndex, 0, DungeonEntryCatalog.Maps.Count - 1)];
    DungeonDifficulty SelectedEntryDifficulty => entryDifficulty.SelectedItem is string name
        ? name switch
        {
            "精英" => DungeonDifficulty.Elite,
            "噩梦" => DungeonDifficulty.Nightmare,
            _ => DungeonDifficulty.Normal
        }
        : DungeonDifficulty.Normal;

    void RefreshEntryDifficulties(DungeonMapOption map, DungeonDifficulty preferred)
    {
        var difficulties = map.Difficulties;
        var names = difficulties.Select(difficulty => difficulty switch
        {
            DungeonDifficulty.Elite => "精英",
            DungeonDifficulty.Nightmare => "噩梦",
            _ => "普通"
        }).ToArray();
        if (names.Length == 0)
            names = ["不分难度"];

        entryDifficulty.BeginUpdate();
        try
        {
            entryDifficulty.Items.Clear();
            entryDifficulty.Items.AddRange(names);
            var selected = difficulties.Contains(preferred) ? preferred : DungeonDifficulty.Normal;
            var selectedIndex = Array.IndexOf(difficulties.ToArray(), selected);
            entryDifficulty.SelectedIndex = selectedIndex >= 0 ? selectedIndex : 0;
            entryDifficulty.Enabled = map.SupportsDifficulty;
        }
        finally { entryDifficulty.EndUpdate(); }
    }

    void ApplyTheme()
    {
        if (IsDisposed || Disposing) return;
        applyingTheme = true;
        try
        {
            currentPalette = ThemePalette.Resolve(CurrentThemeMode);
            ThemeManager.Apply(this, currentPalette);
            ApplyWindowCaptionTheme();
            ThemeManager.Apply(bonusPriorityPopup, currentPalette);
            mapPanel.ApplyTheme(currentPalette);
            state.ForeColor = currentPalette.AccentText;
            warningState.ForeColor = currentPalette.WarningText;
            stats.ForeColor = currentPalette.MutedText;
            assistantState.ForeColor = currentPalette.WarningText;
            if (miniMapForm is { IsDisposed: false }) miniMapForm.ApplyTheme(currentPalette);
            RenderLogs();
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
        var s = settingsStore.Load();
        if (s is null) return;
        scheduledTasks.AddRange(s.ExecutionTasks ?? []);
        ApplySettings(s);
    }
    void ApplySettings(ControllerSettings s)
    {
        themeChoice.SelectedIndex = Math.Clamp((int)s.Theme, 0, 2);
        alwaysOnTop.Checked = s.AlwaysOnTop;
        SetValue(entryRunCount, s.EntryRunCount ?? 0);
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
        RefreshEntryDifficulties(SelectedEntryMap, (DungeonDifficulty)entryDifficultyIndex);
        if (s.BonusPriority is { Count: > 0 } && s.BonusPriority.All(x => BonusKinds.Contains(x))) { bonusPriority.Items.Clear(); bonusPriority.Items.AddRange(s.BonusPriority.Concat(BonusKinds.Where(x => !s.BonusPriority.Contains(x))).ToArray()); bonusPriority.SelectedIndex = 0; }
        if (!string.IsNullOrWhiteSpace(s.Device)) devices.Text = s.Device;
    }
    static void SetValue(ThemedNumericUpDown control, decimal value)
        => control.Value = Math.Clamp(value, control.Minimum, control.Maximum);
    void SaveSettings()
    {
        var s = CaptureSettings();
        s.ExecutionTasks = scheduledTasks.ToList();
        settingsStore.Save(s);
    }
    ControllerSettings CaptureSettings()
    {
        return new ControllerSettings
        {
            Theme = CurrentThemeMode,
            AlwaysOnTop = alwaysOnTop.Checked,
            EntryRunCount = (int)entryRunCount.Value,
            AttackBoss = attackBoss.Checked,
            Monsters = monsters.Checked,
            Elites = elites.Checked,
            Chests = chests.Checked,
            Pots = pots.Checked,
            Bones = bones.Checked,
            Gold = gold.Checked,
            Runes = runes.Checked,
            Chambers = chambers.Checked,
            SingleCellPulseHold = singleCellPulseHold.Value,
            MovementReleaseLead = movementReleaseLead.Value,
            MiningTileWidth = miningTileWidth.Value,
            MiningTileHeight = miningTileHeight.Value,
            MiningInterval = miningInterval.Value,
            InteractionHold = interactionHold.Value,
            StallTimeout = stallTimeout.Value,
            NewFloorStartDelay = newFloorStartDelay.Value,
            RouteRecoveryAttempts = routeRecoveryAttempts.Value,
            TargetStopFloor = (int)targetStopFloor.Value,
            CardLayer = cardLayer.Checked,
            Mining = mining.Checked,
            CardMining = cardMining.Checked,
            EntryMapId = SelectedEntryMap.Id,
            EntryId = Math.Max(1, entryChoice.SelectedIndex + 1),
            EntryDifficulty = (DungeonDifficulty)Math.Clamp(entryDifficulty.SelectedIndex, (int)DungeonDifficulty.Normal, (int)DungeonDifficulty.Nightmare),
            EntryEliteMode = entryDifficulty.SelectedIndex == (int)DungeonDifficulty.Elite,
            Device = devices.Text,
            BonusPriority = bonusPriority.Items.Cast<string>().ToList()
        };
    }

    void ResetDeviceState()
    {
        dungeon.Reset();
        mapPanel.Map = null;
        ClearRiftGemSelectionState();
        serverErrorDialogVisible = false;
        pendingNextFloorDialog = NextFloorDialogKind.None;
        pendingGreedySelectionReturnOnly = false;
        pendingGreedySelectionReturnCards = Array.Empty<int>();
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
        captionPin.Selected = alwaysOnTop.Checked;
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
            () => dungeon.Map,
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

    string AssistantFile(string name) => runtime.Paths.Assistant(name);

    protected override void Dispose(bool disposing)
    {
        if (disposing)
        {
            SystemEvents.UserPreferenceChanged -= OnUserPreferenceChanged;
            captionToolTip.Dispose();
            alwaysOnTop.Dispose();
        }
        base.Dispose(disposing);
    }

    protected override void OnHandleCreated(EventArgs e)
    {
        base.OnHandleCreated(e);
        ApplyTheme();
    }
}
