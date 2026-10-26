using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace AdbMapController;

public sealed partial class MainForm
{
    List<ControllerSettings> scheduledTasks = [];
    readonly List<TaskTemplate> taskTemplates = [];
    ThemedComboBox? taskTemplateChoice;
    readonly TaskSelectionListView taskList = new() { Dock = DockStyle.Fill, View = View.Details, FullRowSelect = true,
        MultiSelect = true, CheckBoxes = true, HideSelection = false, AllowDrop = true, Tag = ThemeRole.Input,
        AccessibleName = "执行任务列表" };
    bool lastEntryRunSucceeded;
    bool taskQueueRunning;
    int activeTaskNumber;
    readonly Label taskExecutionProgress = new()
    {
        AutoSize = false,
        Dock = DockStyle.Fill,
        TextAlign = ContentAlignment.MiddleRight,
        Padding = new(8, 0, 8, 0),
        Tag = ThemeRole.AccentText
    };
    bool synchronizingTaskChecks;
    bool cardMiningTaskRunning;
    bool cardMiningEarlyStop;
    long cardMiningNextToolCheck;
    ControllerSettings? activeCardMiningConfig;
    Task<MiningToolStatus>? pendingCardMiningToolRead;

    TabPage CreateTaskListPage()
    {
        var page = new ThemedTabPage { Text = "任务列表", Tag = ThemeRole.Default };
        foreach (var column in new[] { ("序号", 42), ("", 22), ("", 32), ("任务名称", 190), ("难度", 48), ("次数", 117), ("停层 / 挖矿", 144), ("目标", 220) })
            taskList.Columns.Add(new ColumnHeader { Text = column.Item1, Width = column.Item2, TextAlign = column.Item1 == "任务名称" ? HorizontalAlignment.Center : HorizontalAlignment.Left });
        var toolbar = new TableLayoutPanel { Dock = DockStyle.Top, AutoSize = true, ColumnCount = 1, RowCount = 3, Padding = new(10, 8, 10, 8), Tag = ThemeRole.Surface };
        toolbar.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100));
        for (var row = 0; row < 3; row++) toolbar.RowStyles.Add(new RowStyle(SizeType.AutoSize));
        var templateBar = new FlowLayoutPanel { Dock = DockStyle.Fill, AutoSize = true, WrapContents = false, Margin = Padding.Empty, Tag = ThemeRole.Surface };
        var taskBar = new FlowLayoutPanel { Dock = DockStyle.Fill, AutoSize = true, WrapContents = false, Margin = Padding.Empty, Tag = ThemeRole.Surface };
        var itemBar = new FlowLayoutPanel { Dock = DockStyle.Fill, AutoSize = true, WrapContents = false, Margin = Padding.Empty, Tag = ThemeRole.Surface };
        var taskType = new ThemedComboBox { Width = 135, DropDownStyle = ComboBoxStyle.DropDownList, AccessibleName = "添加任务类型" };
        taskType.Items.AddRange(["进图并跑图", "当前地图跑图", "卡矿任务", "梦境试炼", "培养魂器", "免费祈祷", "福利活动", "领取深渊钥匙", "扫荡永冬裂缝", "扫荡深渊秘境", "每日签到", "幽灵深渊", "冒险家公会", "首领挑战", "定时启动"]); taskType.SelectedIndex = 0;
        var templateChoice = new ThemedComboBox { Width = 160, DropDownStyle = ComboBoxStyle.DropDownList, AccessibleName = "任务模板" };
        taskTemplateChoice = templateChoice;
        var newTemplate = Btn("新建模板", ThemeRole.SecondaryButton);
        var editTemplate = Btn("修改模板", ThemeRole.SecondaryButton);
        var deleteTemplate = Btn("删除模板", ThemeRole.DangerButton);
        var add = Btn("添加任务", ThemeRole.SecondaryButton);
        var update = Btn("编辑任务", ThemeRole.SecondaryButton);

        var remove = Btn("删除", ThemeRole.DangerButton);
        var up = Btn("上移", ThemeRole.SecondaryButton);
        var down = Btn("下移", ThemeRole.SecondaryButton);
        var selectAll = Btn("全选", ThemeRole.SecondaryButton);
        var invertSelection = Btn("反选", ThemeRole.SecondaryButton);
        var run = Btn("执行列表", ThemeRole.SuccessButton);
        templateBar.Controls.AddRange([templateChoice, newTemplate, editTemplate, deleteTemplate]);
        taskBar.Controls.AddRange([taskType, add, update, remove]);
        itemBar.Controls.AddRange([run, selectAll, invertSelection, up, down]);
        toolbar.Controls.Add(templateBar, 0, 0);
        toolbar.Controls.Add(taskBar, 0, 1);
        toolbar.Controls.Add(itemBar, 0, 2);
        page.Controls.Add(taskList); page.Controls.Add(toolbar);
        bool Editable() => !closing && !stopping && !taskQueueRunning && activeEntry is not { IsCompleted: false } && activeMovement is not { IsCompleted: false };
        void RefreshTemplates(int selected = -1)
        {
            templateChoice.Items.Clear();
            foreach (var template in taskTemplates) templateChoice.Items.Add(template.Name);
            var saved = taskTemplates.FindIndex(x => x.Name == selectedTaskTemplateName);
            templateChoice.SelectedIndex = selected >= 0 && selected < taskTemplates.Count ? selected : saved >= 0 ? saved : taskTemplates.Count > 0 ? 0 : -1;
        }
        templateChoice.SelectedIndexChanged += (_, _) => SelectTaskTemplate(templateChoice.SelectedIndex);
        RefreshTemplates();
        newTemplate.Click += (_, _) =>
        {
            if (!Editable()) return;
            var name = NextTemplateName();
            taskTemplates.Add(new TaskTemplate { Name = name });
            RefreshTemplates(taskTemplates.Count - 1); SaveSettings();
        };
        editTemplate.Click += (_, _) =>
        {
            var index = templateChoice.SelectedIndex;
            if (!Editable() || index < 0) return;
            var template = taskTemplates[index];
            if (!ShowTemplateNameEditor(template.Name, index, out var name)) return;
            template.Name = name;
            RefreshTemplates(index); SaveSettings();
        };
        deleteTemplate.Click += (_, _) =>
        {
            var index = templateChoice.SelectedIndex;
            if (!Editable() || index < 0 || index >= taskTemplates.Count) return;
            var template = taskTemplates[index];
            if (MessageBox.Show(this, $"确定删除模板“{template.Name}”及其中的 {template.Tasks.Count} 个任务吗？此操作无法撤销。",
                    "删除模板", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) != DialogResult.Yes) return;

            taskTemplates.RemoveAt(index);
            var nextIndex = Math.Min(index, taskTemplates.Count - 1);
            RefreshTemplates(nextIndex);
            SaveSettings();
        };
        int Selected() => taskList.SelectedIndices.Count == 0 ? -1 : taskList.SelectedIndices[0];
        void SetAllEnabled(bool invert)
        {
            if (!Editable() || scheduledTasks.Count == 0) return;
            synchronizingTaskChecks = true;
            taskList.BeginUpdate();
            try
            {
                for (var i = 0; i < scheduledTasks.Count; i++)
                {
                    var enabled = !invert || !scheduledTasks[i].TaskEnabled;
                    scheduledTasks[i].TaskEnabled = enabled;
                    taskList.Items[i].Checked = enabled;
                }
            }
            finally
            {
                synchronizingTaskChecks = false;
                taskList.EndUpdate();
            }
            SaveSettings();
        }
        selectAll.Click += (_, _) => SetAllEnabled(invert: false);
        invertSelection.Click += (_, _) => SetAllEnabled(invert: true);
        void SetEnabled(int index, bool enabled)
        {
            if (!Editable() || index < 0 || index >= scheduledTasks.Count) return;
            var indices = taskList.Items[index].Selected
                ? taskList.SelectedIndices.Cast<int>().ToArray() : new[] { index };
            synchronizingTaskChecks = true;
            try
            {
                foreach (var i in indices)
                {
                    scheduledTasks[i].TaskEnabled = enabled;
                    taskList.Items[i].Checked = enabled;
                }
            }
            finally { synchronizingTaskChecks = false; }
            SaveSettings();
        }
        taskList.CheckClicked += index => SetEnabled(index, !scheduledTasks[index].TaskEnabled);
        taskList.RunClicked += index => StartTaskQueue(index);
        taskList.StopClicked += () => _ = RunUi(EmergencyStopAndClear);
        taskList.ItemCheck += (_, e) =>
        {
            if (synchronizingTaskChecks || taskList.RestoringChecks) return;
            // 仅允许 SetEnabled 发起状态变更，取消原生 ListView 在行双击等操作中产生的自动切换。
            e.NewValue = e.CurrentValue;
        };
        taskList.KeyDown += (_, e) =>
        {
            if (e.KeyCode != Keys.Space || taskList.SelectedIndices.Count == 0) return;
            e.Handled = true; e.SuppressKeyPress = true;
            var index = taskList.FocusedItem?.Index ?? Selected();
            SetEnabled(index, !scheduledTasks[index].TaskEnabled);
        };
        add.Click += (_, _) =>
        {
            if (!Editable()) return;
            var index = templateChoice.SelectedIndex;
            if (index < 0) { MessageBox.Show(this, "请先选择或新建一个模板。", "添加任务", MessageBoxButtons.OK, MessageBoxIcon.Information); return; }
            var config = CaptureSettings(); config.TaskKind = (ExecutionTaskKind)taskType.SelectedIndex;
            if (config.TaskKind == ExecutionTaskKind.DreamTrial) EnforceDreamTrialOptions(config);
            if (config.TaskKind == ExecutionTaskKind.CardMining) EnforceCardMiningOptions(config);
            if (!ShowTaskEditor(config, "添加任务")) return;
            scheduledTasks.Add(config); RefreshTaskList(scheduledTasks.Count - 1); SaveSettings();
        };
        void EditSelected()
        {
            var i = Selected(); if (!Editable() || i < 0) return;
            var config = CloneTask(scheduledTasks[i]);
            if (!ShowTaskEditor(config, $"编辑任务 {i + 1}")) return;
            scheduledTasks[i] = config; RefreshTaskList(i); SaveSettings();
        }
        update.Click += (_, _) => EditSelected();
        taskList.DoubleClick += (_, _) => EditSelected();
        remove.Click += (_, _) => { var i = Selected(); if (!Editable() || i < 0) return; scheduledTasks.RemoveAt(i); RefreshTaskList(Math.Min(i, scheduledTasks.Count - 1)); SaveSettings(); };
        up.Click += (_, _) => { if (Editable()) MoveScheduledTask(Selected(), Selected() - 1); };
        down.Click += (_, _) => { if (Editable()) MoveScheduledTask(Selected(), Selected() + 1); };
        taskList.ItemDrag += (_, e) => { if (Editable() && e.Item is ListViewItem item) taskList.DoDragDrop(item, DragDropEffects.Move); };
        taskList.DragOver += (_, e) => e.Effect = Editable() && e.Data?.GetData(typeof(ListViewItem)) is ListViewItem item && item.ListView == taskList ? DragDropEffects.Move : DragDropEffects.None;
        taskList.DragDrop += (_, e) =>
        {
            if (!Editable() || e.Data?.GetData(typeof(ListViewItem)) is not ListViewItem item || item.ListView != taskList) return;
            var target = taskList.GetItemAt(taskList.PointToClient(new Point(e.X, e.Y)).X, taskList.PointToClient(new Point(e.X, e.Y)).Y);
            MoveScheduledTask(item.Index, target?.Index ?? scheduledTasks.Count - 1);
        };
        run.Click += (_, _) =>
        {
            if (taskQueueRunning) _ = RunUi(EmergencyStopAndClear);
            else StartTaskQueue();
        };
        void StartTaskQueue(int? singleTaskIndex = null) => _ = RunUi(async () =>
        {
            if (!Editable()) throw new InvalidOperationException("请先停止当前任务");
            if (singleTaskIndex is null && !scheduledTasks.Any(x => x.TaskEnabled)) throw new InvalidOperationException("请先添加并启用至少一个任务");
            if (string.IsNullOrWhiteSpace(devices.Text)) throw new InvalidOperationException("请先连接设备");
            var original = CaptureSettings();
            taskQueueRunning = true;
            run.Text = "停止执行";
            run.Tag = ThemeRole.WarningButton;
            ThemeManager.Apply(run, currentPalette);
            foreach (var container in new Control[] { templateBar, taskBar, itemBar })
                foreach (Control control in container.Controls)
                    if (control != run) control.Enabled = false;
            var settingsPage = (page.Parent as TabControl)?.TabPages.Cast<TabPage>().FirstOrDefault(x => x.Text == "设置");
            if (settingsPage is not null) settingsPage.Enabled = false;
            try
            {
                await operations.RunAsync(ControllerOperationKind.Entry, async token =>
                {
                    for (var i = 0; i < scheduledTasks.Count; i++)
                    {
                        token.ThrowIfCancellationRequested();
                        var task = scheduledTasks[i];
                        if (singleTaskIndex is int target ? i != target : !task.TaskEnabled) continue;
                        var config = ResolveTaskSettings(original, task);
                        activeTaskNumber = i + 1;
                        ClearStoppedAutomation();
                        State($"任务列表：正在启动第 {i + 1} 项");
                        taskList.ActiveRunIndex = i;
                        UpdateTaskExecutionProgress(1, GetInitialTaskExecutionCount(config));
                        ApplySettings(config, applyEquipmentSale: false); RefreshTaskList(i);
                        Log($"执行任务列表：第 {i + 1}/{scheduledTasks.Count} 项");
                        if (config.TaskKind == ExecutionTaskKind.ScheduledConnectionRecovery)
                        {
                            await RunScheduledConnectionRecoveryAsync(config.ScheduledRecoveryStartAt, token);
                            lastEntryRunSucceeded = true;
                            continue;
                        }
                        var retries = 0;
                        while (true)
                        {
                            token.ThrowIfCancellationRequested();
                            await WaitForConnectionRecoveryAsync(token);
                            using var attempt = CancellationTokenSource.CreateLinkedTokenSource(token);
                            taskAttemptCancellation = attempt;
                            var restartAtStart = taskRestartGeneration;
                            using var monitorCancellation = CancellationTokenSource.CreateLinkedTokenSource(token);
                            var connectionMonitor = MonitorTaskConnectionAsync(monitorCancellation.Token);
                            lastEntryRunSucceeded = false;
                            try
                            {
                                var attemptToken = attempt.Token;
                                if (config.SwitchEquipmentSet && config.TaskKind is not (ExecutionTaskKind.SoulArtifactCultivation or ExecutionTaskKind.FreePrayer or ExecutionTaskKind.FreeWelfare or ExecutionTaskKind.AbyssKey or ExecutionTaskKind.AbyssSweep or ExecutionTaskKind.DailySignIn or ExecutionTaskKind.GuildTasks)) await TrySwitchTaskEquipmentAsync(config.EquipmentSet, attemptToken);
                                if (config.TaskKind == ExecutionTaskKind.SoulArtifactCultivation) await RunSoulArtifactCultivationAsync(attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.FreePrayer) await RunFreePrayerAsync(attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.FreeWelfare) await RunFreeWelfareAsync(attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.AbyssKey) await RunAbyssKeyAsync(attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.DailySignIn) await RunDailySignInAsync(attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.EternalWinterSweep) await RunEternalWinterSweepAsync(config, attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.AbyssSweep) await RunAbyssSweepAsync(attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.GhostAbyss) await RunGhostAbyssAsync(config, attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.GuildTasks) await RunGuildTasksAsync(config, attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.CardMining) await RunCardMiningTaskAsync(config, attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.DreamTrial) await RunDreamTrialTaskAsync(config, attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.BossChallenge) await RunBossChallengeAsync(attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.EntryAndRun) await RunEntryRunPipelineAsync(attemptToken);
                                else if (config.TaskKind == ExecutionTaskKind.CurrentMapRun)
                                {
                                    await RunMovementScope(attemptToken, StartRunCore, startupProbePaused: true);
                                    lastEntryRunSucceeded = lastMapRunSucceeded;
                                }
                                else { State("任务列表停止：不支持的任务类型"); return; }
                            }
                            catch (Exception ex) when (!token.IsCancellationRequested && restartAtStart != taskRestartGeneration)
                            {
                                Log($"断线恢复：第 {i + 1} 项已中断，将从该项重新执行（{ex.Message}）");
                            }
                            finally
                            {
                                monitorCancellation.Cancel();
                                try { await connectionMonitor; }
                                catch (OperationCanceledException) when (monitorCancellation.IsCancellationRequested) { }
                                if (ReferenceEquals(taskAttemptCancellation, attempt)) taskAttemptCancellation = null;
                            }
                            token.ThrowIfCancellationRequested();
                            if (restartAtStart != taskRestartGeneration)
                            {
                                if (++retries > 3) throw new InvalidOperationException($"第 {i + 1} 项连续断线超过 3 次，已停止任务列表");
                                await WaitForConnectionRecoveryAsync(token);
                                Log($"断线恢复：重新执行第 {i + 1} 项（第 {retries} 次重试）");
                                continue;
                            }
                            if (!lastEntryRunSucceeded) { State($"任务列表停止：第 {i + 1} 项未完成"); return; }
                            break;
                        }
                    }
                    State("已启用的任务全部完成");
                });
            }
            catch (OperationCanceledException ex) when (ex.CancellationToken.IsCancellationRequested)
            {
                Log("任务列表已停止，不再执行后续任务");
                if (!stopping) State("列表已停止");
            }
            finally
            {
                ApplySettings(original); UpdateBonusPriorityCaption(); taskQueueRunning = false; activeTaskNumber = 0; taskList.ActiveRunIndex = -1;
                foreach (var container in new Control[] { templateBar, taskBar, itemBar })
                    foreach (Control control in container.Controls) control.Enabled = true;
                run.Text = "执行列表";
                run.Tag = ThemeRole.SuccessButton;
                ThemeManager.Apply(run, currentPalette);
                if (settingsPage is not null) settingsPage.Enabled = true;
                SaveSettings();
            }
        });
        var stopBar = new TableLayoutPanel { Dock = DockStyle.Bottom, AutoSize = true, Padding = new(10, 6, 10, 6), Tag = ThemeRole.Surface, ColumnCount = 1, RowCount = 1 };
        stopBar.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100));
        stopBar.Controls.Add(taskExecutionProgress, 0, 0);
        page.Controls.Add(stopBar);
        RefreshTaskList();
        return page;
    }

    string GetInitialTaskExecutionCount(ControllerSettings config) => config.TaskKind switch
    {
        ExecutionTaskKind.EntryAndRun when config.EntryRunCount > 0 => config.EntryRunCount.ToString(),
        ExecutionTaskKind.EntryAndRun when config.EntryDifficulty == DungeonDifficulty.Normal => "∞",
        ExecutionTaskKind.EntryAndRun => "读取中",
        ExecutionTaskKind.EternalWinterSweep => config.EternalWinterSweepCount.ToString(),
        _ => "1"
    };

    void UpdateTaskExecutionProgress(int currentCount, string totalCount)
    {
        if (!taskQueueRunning || activeTaskNumber <= 0 || IsDisposed || Disposing) return;
        if (InvokeRequired)
        {
            BeginInvoke(() => UpdateTaskExecutionProgress(currentCount, totalCount));
            return;
        }
        taskExecutionProgress.Text = $"当前任务：{activeTaskNumber}　当前次数：{currentCount}/{totalCount}";
    }

    static ControllerSettings CloneTask(ControllerSettings source) =>
        System.Text.Json.JsonSerializer.Deserialize<ControllerSettings>(System.Text.Json.JsonSerializer.Serialize(source))!;

    void RefreshLoadedTemplates()
    {
        if (taskTemplateChoice is null) return;
        taskTemplateChoice.Items.Clear();
        foreach (var template in taskTemplates) taskTemplateChoice.Items.Add(template.Name);
        var index = taskTemplates.FindIndex(x => x.Name == selectedTaskTemplateName);
        taskTemplateChoice.SelectedIndex = index >= 0 ? index : taskTemplateChoice.Items.Count > 0 ? 0 : -1;
    }

    string selectedTaskTemplateName = "";

    void SelectTaskTemplate(int index)
    {
        scheduledTasks = index >= 0 && index < taskTemplates.Count ? taskTemplates[index].Tasks : [];
        selectedTaskTemplateName = index >= 0 && index < taskTemplates.Count ? taskTemplates[index].Name : "";
        RefreshTaskList();
    }

    string NextTemplateName()
    {
        for (var number = 1; ; number++)
        {
            var name = $"新模板 {number}";
            if (!taskTemplates.Any(x => string.Equals(x.Name, name, StringComparison.OrdinalIgnoreCase))) return name;
        }
    }

    bool ShowTemplateNameEditor(string current, int editingIndex, out string name)
    {
        name = current;
        var editedName = current;
        using var dialog = new Form { Text = "修改模板名称", ClientSize = new(360, 115),
            StartPosition = FormStartPosition.CenterParent, FormBorderStyle = FormBorderStyle.FixedDialog,
            MaximizeBox = false, MinimizeBox = false, ShowInTaskbar = false, Font = Font };
        var input = new TextBox { Text = current, Left = 12, Top = 12, Width = 335, AccessibleName = "模板名称" };
        var save = Btn("确定", ThemeRole.SuccessButton); save.Left = 175; save.Top = 55;
        var cancel = Btn("取消", ThemeRole.SecondaryButton); cancel.Left = 265; cancel.Top = 55; cancel.DialogResult = DialogResult.Cancel;
        save.Click += (_, _) =>
        {
            var candidate = input.Text.Trim();
            if (candidate.Length == 0) { MessageBox.Show(dialog, "模板名称不能为空。"); return; }
            if (taskTemplates.Where((_, i) => i != editingIndex).Any(x => string.Equals(x.Name, candidate, StringComparison.OrdinalIgnoreCase)))
            { MessageBox.Show(dialog, "模板名称已存在，请换一个名称。"); return; }
            editedName = candidate; dialog.DialogResult = DialogResult.OK;
        };
        dialog.Controls.AddRange([input, save, cancel]); dialog.AcceptButton = save; dialog.CancelButton = cancel;
        ThemeManager.Apply(dialog, currentPalette);
        if (dialog.ShowDialog(this) != DialogResult.OK) return false;
        name = editedName;
        return true;
    }

    // 任务只覆盖编辑器中提供的选项；其它运行参数始终取列表开始时的当前设置。
    static ControllerSettings ResolveTaskSettings(ControllerSettings current, ControllerSettings task)
    {
        var result = System.Text.Json.JsonSerializer.Deserialize<ControllerSettings>(
            System.Text.Json.JsonSerializer.Serialize(current))!;
        result.TaskKind = task.TaskKind;
        result.TaskEnabled = task.TaskEnabled;
        result.ScheduledRecoveryStartAt = task.ScheduledRecoveryStartAt;
        result.SwitchEquipmentSet = task.SwitchEquipmentSet;
        result.EquipmentSet = task.EquipmentSet;
        result.EternalWinterFloor = task.EternalWinterFloor;
        result.EternalWinterSweepCount = task.EternalWinterSweepCount;
        result.GhostAbyssFloor = task.GhostAbyssFloor;
        result.GhostAbyssDouble = task.GhostAbyssDouble;
        result.GuildWish = task.GuildWish;
        result.GuildCrystalShop = task.GuildCrystalShop;
        result.GuildDungeon = task.GuildDungeon;
        result.GuildBoss = task.GuildBoss;
        if (task.TaskKind is ExecutionTaskKind.EntryAndRun or ExecutionTaskKind.CardMining)
        {
            result.EntryMapId = task.EntryMapId;
            result.EntryId = task.EntryId;
            result.EntryDifficulty = task.EntryDifficulty;
        }
        if (task.TaskKind == ExecutionTaskKind.EntryAndRun)
            result.EntryRunCount = task.EntryRunCount;
        if (task.TaskKind is ExecutionTaskKind.EntryAndRun or ExecutionTaskKind.CurrentMapRun)
        {
            result.TargetStopFloor = task.TargetStopFloor;
            result.EscapeReturnFloor = task.EscapeReturnFloor;
            result.EscapeReturnAttackBoss = task.EscapeReturnAttackBoss;
        }
        if (task.TaskKind != ExecutionTaskKind.DreamTrial)
        {
            result.AttackBoss = task.AttackBoss;
            result.DirectBossNpc = task.DirectBossNpc;
            result.Monsters = task.Monsters;
            result.Elites = task.Elites;
            result.WoodChests = task.WoodChests;
            result.OtherChests = task.OtherChests;
            result.Pots = task.Pots;
            result.Bones = task.Bones;
            result.Gold = task.Gold;
            result.Runes = task.Runes;
            result.Altars = task.Altars;
            result.Chambers = task.Chambers;
        }
        if (task.TaskKind != ExecutionTaskKind.CardMining && task.TaskKind != ExecutionTaskKind.DreamTrial)
        {
            result.Mining = task.Mining;
            result.CardMining = task.CardMining;
            result.CardLayer = task.CardLayer;
        }
        if (task.TaskKind == ExecutionTaskKind.CardMining)
        {
            result.CardMiningStartAt = task.CardMiningStartAt;
            result.CardMiningMinimumTools = task.CardMiningMinimumTools;
            EnforceCardMiningOptions(result);
        }
        if (task.TaskKind == ExecutionTaskKind.DreamTrial)
        {
            result.DreamTrialBossMask = task.DreamTrialBossMask;
            EnforceDreamTrialOptions(result);
        }
        return result;
    }

    bool ShowTaskEditor(ControllerSettings config, string title)
    {
        using var dialog = new Form { Text = title, ClientSize = new(740, 280), MinimumSize = new(640, 320),
            StartPosition = FormStartPosition.CenterParent, ShowInTaskbar = false, MinimizeBox = false, MaximizeBox = false,
            AutoScaleMode = AutoScaleMode.Dpi, Font = Font };
        var taskEditor = new FlowLayoutPanel { Dock = DockStyle.Fill, AutoScroll = true, FlowDirection = FlowDirection.TopDown,
            WrapContents = false, Padding = new(10), Tag = ThemeRole.SurfaceAlt };
        var buttons = new FlowLayoutPanel { Dock = DockStyle.Bottom, AutoSize = true, FlowDirection = FlowDirection.RightToLeft, Padding = new(10) };
        var save = Btn("保存", ThemeRole.SuccessButton); save.DialogResult = DialogResult.OK;
        var cancel = Btn("取消", ThemeRole.SecondaryButton); cancel.DialogResult = DialogResult.Cancel;
        buttons.Controls.AddRange([save, cancel]); dialog.Controls.Add(taskEditor); dialog.Controls.Add(buttons);
        dialog.AcceptButton = save; dialog.CancelButton = cancel;
        void Row(string caption, params Control[] controls)
        {
            var row = new FlowLayoutPanel { AutoSize = true, WrapContents = true, MaximumSize = new(700, 0), Margin = new(0, 0, 0, 8) };
            row.Controls.Add(new Label { Text = caption, AutoSize = true, Padding = new(0, 5, 6, 0) });
            row.Controls.AddRange(controls); taskEditor.Controls.Add(row);
        }
        if (config.TaskKind is ExecutionTaskKind.EntryAndRun or ExecutionTaskKind.CardMining)
        {
            var maps = DungeonEntryCatalog.Maps;
            var map = new ThemedComboBox { Width = 150, DropDownStyle = ComboBoxStyle.DropDownList };
            var entry = new ThemedComboBox { Width = 130, DropDownStyle = ComboBoxStyle.DropDownList };
            var difficulty = new ThemedComboBox { Width = 100, DropDownStyle = ComboBoxStyle.DropDownList };
            var rebuilding = false;
            void Rebuild()
            {
                if (map.SelectedIndex < 0 || map.SelectedIndex >= maps.Count) return;
                rebuilding = true;
                try
                {
                    var selectedMap = maps[map.SelectedIndex];
                    var entries = DungeonEntryCatalog.EntriesForMap(selectedMap.Id);
                    entry.Items.Clear(); entry.Items.AddRange(entries.Select(x => (object)x.Name).ToArray());
                    if (entries.Count > 0)
                    {
                        entry.SelectedIndex = Math.Max(0, entries.ToList().FindIndex(x => x.Id == config.EntryId));
                        config.EntryId = entries[entry.SelectedIndex].Id;
                    }
                    var difficulties = selectedMap.Difficulties;
                    difficulty.Items.Clear();
                    if (difficulties.Count == 0)
                    {
                        difficulty.Items.Add("不分难度");
                        difficulty.SelectedIndex = 0;
                        difficulty.Enabled = false;
                        config.EntryDifficulty = DungeonDifficulty.Normal;
                    }
                    else
                    {
                        difficulty.Items.AddRange(difficulties.Select(x => (object)new[] { "普通", "精英", "噩梦" }[(int)x]).ToArray());
                        difficulty.SelectedIndex = Math.Max(0, difficulties.ToList().IndexOf(config.EntryDifficulty));
                        difficulty.Enabled = selectedMap.SupportsDifficulty;
                        config.EntryDifficulty = difficulties[difficulty.SelectedIndex];
                    }
                    config.EntryMapId = selectedMap.Id;
                }
                finally { rebuilding = false; }
            }
            map.Items.AddRange(maps.Select(x => (object)x.Name).ToArray());
            map.SelectedIndex = Math.Max(0, maps.ToList().FindIndex(x => x.Id == config.EntryMapId)); Rebuild();
            map.SelectedIndexChanged += (_, _) => { Rebuild(); };
            entry.SelectedIndexChanged += (_, _) => { if (rebuilding || entry.SelectedIndex < 0) return; config.EntryId = DungeonEntryCatalog.EntriesForMap(config.EntryMapId)[entry.SelectedIndex].Id; };
            difficulty.SelectedIndexChanged += (_, _) => { if (rebuilding || map.SelectedIndex < 0 || difficulty.SelectedIndex < 0) return; var options = maps[map.SelectedIndex].Difficulties; if (difficulty.SelectedIndex < options.Count) config.EntryDifficulty = options[difficulty.SelectedIndex]; };
            Row("地图 / 入口 / 难度", map, entry, difficulty);
        }
        void Number(string property, string caption, decimal minimum, decimal maximum)
        {
            var info = typeof(ControllerSettings).GetProperty(property)!;
            var value = Convert.ToDecimal(info.GetValue(config) ?? 0);
            var control = new ThemedNumericUpDown { Minimum = minimum, Maximum = maximum, Value = Math.Clamp(value, minimum, maximum), Width = 85, AccessibleName = caption };
            control.ValueChanged += (_, _) => { info.SetValue(config, info.PropertyType == typeof(decimal) ? (object)control.Value : (int)control.Value); };
            Row(caption, control);
        }
        void EquipmentSelection()
        {
            var switchEquipment = Box("装备检测"); switchEquipment.Checked = config.SwitchEquipmentSet;
            var equipmentSets = new FlowLayoutPanel { AutoSize = true, WrapContents = false, Margin = new(0), Enabled = switchEquipment.Checked };
            var setOptions = new List<RadioButton>();
            void RefreshEquipmentSetAppearance()
            {
                foreach (var option in setOptions)
                {
                    var selected = option.Checked;
                    option.Text = $"{(selected ? "✓ " : "")}{option.Tag}";
                    option.BackColor = selected ? currentPalette.ButtonAccent : currentPalette.InputBackground;
                    option.ForeColor = selected ? currentPalette.ButtonText : currentPalette.Text;
                    option.FlatAppearance.BorderColor = selected ? currentPalette.FocusBorder : currentPalette.Border;
                    option.FlatAppearance.BorderSize = selected ? 2 : 1;
                }
            }
            for (var number = 1; number <= 3; number++)
            {
                var selectedSet = number;
                var option = new RadioButton { Text = $"方案{number}", Tag = $"方案{number}", Appearance = Appearance.Button,
                    FlatStyle = FlatStyle.Flat, TextAlign = ContentAlignment.MiddleCenter, AutoSize = false,
                    Width = 88, Height = 28, Margin = new(2, 0, 2, 0), AccessibleName = $"装备方案{number}",
                    Checked = Math.Clamp(config.EquipmentSet, 1, 3) == number };
                option.CheckedChanged += (_, _) => { if (option.Checked) config.EquipmentSet = selectedSet; RefreshEquipmentSetAppearance(); };
                setOptions.Add(option);
                equipmentSets.Controls.Add(option);
            }
            switchEquipment.CheckedChanged += (_, _) => { config.SwitchEquipmentSet = switchEquipment.Checked; equipmentSets.Enabled = switchEquipment.Checked; };
            Row("装备", switchEquipment, equipmentSets);
            dialog.Shown += (_, _) => RefreshEquipmentSetAppearance();
        }
        if (config.TaskKind == ExecutionTaskKind.ScheduledConnectionRecovery)
        {
            config.SwitchEquipmentSet = false;
            var now = DateTime.Now;
            config.ScheduledRecoveryStartAt = new DateTime(now.Year, now.Month, now.Day, now.Hour, now.Minute, 0);
            var start = new DateTimePicker { Width = 190, Format = DateTimePickerFormat.Custom,
                CustomFormat = "yyyy-MM-dd HH:mm", Value = config.ScheduledRecoveryStartAt };
            start.ValueChanged += (_, _) => config.ScheduledRecoveryStartAt = start.Value;
            Row("开始时间", start);
            Row("流程", new Label { Text = "等待至指定时间 → 断线重连并确认游戏就绪 → 继续列表", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.BossChallenge)
        {
            EquipmentSelection();
            Row("流程", new Label { Text = "活动 → 首领入侵 → 立即加入 → 跑图至回城", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.SoulArtifactCultivation)
        {
            config.SwitchEquipmentSet = false;
            Row("流程", new Label { Text = "打开背包 → 魂器 → 普通培养至次数耗尽 → 关闭", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.FreePrayer)
        {
            config.SwitchEquipmentSet = false;
            Row("流程", new Label { Text = "打开神迹许愿 → 免费祈祷 → 点击右侧空白处关闭并跳过动画 → 重复至不免费", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.FreeWelfare)
        {
            config.SwitchEquipmentSet = false;
            Row("流程", new Label { Text = "福利活动 → 超值礼包领取所有免费礼包 → 特权礼包领取月卡和终身卡 → 点击右侧空白处关闭", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.AbyssKey)
        {
            config.SwitchEquipmentSet = false;
            Row("流程", new Label { Text = "打开商店 → 宝箱 → 查找深渊钥匙 → 未售罄时领取 → 确认奖励并关闭", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.DailySignIn)
        {
            config.SwitchEquipmentSet = false;
            Row("流程", new Label { Text = "识别入口 → 每日签到 → 核对累计天数及已领取勾选 → 领取阶段奖励 → 关闭", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.EternalWinterSweep)
        {
            config.SwitchEquipmentSet = false;
            Number(nameof(config.EternalWinterFloor), "永冬裂缝层数", 1, 99);
            Number(nameof(config.EternalWinterSweepCount), "扫荡次数", 1, 999);
            Row("流程", new Label { Text = "打开巴萨坦地图和永冬裂缝，选择层数后按次数扫荡；次数不足或未解锁时关闭界面", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.AbyssSweep)
        {
            config.SwitchEquipmentSet = false;
            Row("流程", new Label { Text = "打开地图 → 深渊秘境 → 确认深渊模式 → 按钥匙数量选择扫荡次数 → 二次确认 → 领取战利品", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.GhostAbyss)
        {
            EquipmentSelection();
            Number(nameof(config.GhostAbyssFloor), "幽灵深渊层数", 1, 999);
            var doubleChallenge = Box("双倍挑战"); doubleChallenge.Checked = config.GhostAbyssDouble;
            doubleChallenge.CheckedChanged += (_, _) => config.GhostAbyssDouble = doubleChallenge.Checked;
            Row("挑战方式", doubleChallenge);
            Row("流程", new Label { Text = "选择目标层并挑战；双倍可用时仅跑一轮，否则按剩余次数重复普通挑战", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        if (config.TaskKind == ExecutionTaskKind.GuildTasks)
        {
            EquipmentSelection();
            var wish = Box("金币许愿"); wish.Checked = config.GuildWish;
            wish.CheckedChanged += (_, _) => config.GuildWish = wish.Checked;
            var shop = Box("水晶商店免费"); shop.Checked = config.GuildCrystalShop;
            shop.CheckedChanged += (_, _) => config.GuildCrystalShop = shop.Checked;
            var dungeon = Box("公会副本"); dungeon.Checked = config.GuildDungeon;
            dungeon.CheckedChanged += (_, _) => config.GuildDungeon = dungeon.Checked;
            Row("可选任务", wish, shop, dungeon);
            var bossOptions = new FlowLayoutPanel { AutoSize = true, WrapContents = false, Margin = new(0), Enabled = dungeon.Checked };
            var bossButtons = new List<RadioButton>();
            void RefreshBossAppearance()
            {
                foreach (var button in bossButtons)
                {
                    var selected = button.Checked;
                    button.Text = $"{(selected ? "✓ " : "")}Boss {button.Tag}";
                    button.BackColor = selected ? currentPalette.ButtonAccent : currentPalette.InputBackground;
                    button.ForeColor = selected ? currentPalette.ButtonText : currentPalette.Text;
                    button.FlatAppearance.BorderColor = selected ? currentPalette.FocusBorder : currentPalette.Border;
                    button.FlatAppearance.BorderSize = selected ? 2 : 1;
                }
            }
            for (var number = 1; number <= 5; number++)
            {
                var selectedBoss = number;
                var button = new RadioButton { Tag = number, Appearance = Appearance.Button,
                    FlatStyle = FlatStyle.Flat, TextAlign = ContentAlignment.MiddleCenter, AutoSize = false,
                    Width = 88, Height = 28, Margin = new(2, 0, 2, 0), AccessibleName = $"副本 Boss {number}",
                    Checked = Math.Clamp(config.GuildBoss, 1, 5) == number };
                button.CheckedChanged += (_, _) => { if (button.Checked) config.GuildBoss = selectedBoss; RefreshBossAppearance(); };
                bossButtons.Add(button);
                bossOptions.Controls.Add(button);
            }
            dungeon.CheckedChanged += (_, _) => bossOptions.Enabled = dungeon.Checked;
            Row("副本 Boss", bossOptions);
            dialog.Shown += (_, _) => RefreshBossAppearance();
            Row("流程", new Label { Text = "读取剩余次数；所选任务完成后传送回巴萨坦", AutoSize = true });
            ThemeManager.Apply(dialog, currentPalette);
            return dialog.ShowDialog(this) == DialogResult.OK;
        }
        EquipmentSelection();
        if (config.TaskKind == ExecutionTaskKind.EntryAndRun) Number(nameof(config.EntryRunCount), "跑图次数（0=自动，普通无限）", 0, 9999);
        if (config.TaskKind is not (ExecutionTaskKind.CardMining or ExecutionTaskKind.DreamTrial)) Number(nameof(config.TargetStopFloor), "停住楼层（0=关闭）", 0, 999);
        if (config.TaskKind is not (ExecutionTaskKind.CardMining or ExecutionTaskKind.DreamTrial)) Number(nameof(config.EscapeReturnFloor), "卷轴主动回城楼层（0=关闭）", 0, 999);
        if (config.TaskKind == ExecutionTaskKind.CardMining)
        {
            config.CardMiningStartAt = DateTime.Today.AddDays(1);
            var start = new DateTimePicker { Width = 190, Format = DateTimePickerFormat.Custom, CustomFormat = "yyyy-MM-dd HH:mm", Value = config.CardMiningStartAt };
            start.ValueChanged += (_, _) => config.CardMiningStartAt = start.Value;
            Row("开始挖矿时间", start);
            Number(nameof(config.CardMiningMinimumTools), "开始挖矿所需镐子数", 1, 9999);
        }
        if (config.TaskKind == ExecutionTaskKind.DreamTrial)
        {
            var names = new[] { "Troll", "DastardBot", "EldestOne", "Shoggoth", "GodsSpirit", "Mad King" };
            config.DreamTrialBossMask = NormalizeDreamTrialBossMask(config.DreamTrialBossMask);
            var selected = new List<CheckBox>();
            var synchronizingBossChecks = false;
            for (var i = 0; i < names.Length; i++)
            {
                var index = i;
                var check = Box(names[i]);
                check.Checked = (config.DreamTrialBossMask & (1 << i)) != 0;
                check.CheckedChanged += (_, _) =>
                {
                    if (synchronizingBossChecks) return;
                    config.DreamTrialBossMask = check.Checked
                        ? (1 << (index + 1)) - 1
                        : (1 << index) - 1;
                    synchronizingBossChecks = true;
                    try
                    {
                        for (var boss = 0; boss < selected.Count; boss++)
                            selected[boss].Checked = (config.DreamTrialBossMask & (1 << boss)) != 0;
                    }
                    finally { synchronizingBossChecks = false; }
                };
                selected.Add(check);
            }
            Row("依次挑战 Boss", selected.Cast<Control>().ToArray());
        }
        var returnBoss = Box("卷轴回城前攻击Boss"); returnBoss.Checked = config.EscapeReturnAttackBoss;
        returnBoss.CheckedChanged += (_, _) => config.EscapeReturnAttackBoss = returnBoss.Checked;
        if (config.TaskKind is not (ExecutionTaskKind.CardMining or ExecutionTaskKind.DreamTrial)) Row("主动回城", returnBoss);
        var checks = new List<Control>();
        foreach (var field in config.TaskKind == ExecutionTaskKind.DreamTrial ? Array.Empty<(string, string)>() : new[] { ("AttackBoss", "Boss"), ("DirectBossNpc", "直接挑战Boss"), ("Monsters", "小怪"), ("Elites", "精英"), ("WoodChests", "木箱子"), ("OtherChests", "金箱子"), ("Pots", "罐子"), ("Bones", "石堆"), ("Gold", "金币"), ("Runes", "符文"), ("Altars", "点金台"), ("Chambers", "密室"), ("Mining", "挖矿"), ("CardMining", "卡矿"), ("CardLayer", "卡层") })
        {
            if (config.TaskKind == ExecutionTaskKind.CardMining && field.Item1 is "Mining" or "CardMining" or "CardLayer") continue;
            var property = typeof(ControllerSettings).GetProperty(field.Item1)!;
            var check = Box(field.Item2); check.Checked = (bool)property.GetValue(config)!;
            check.CheckedChanged += (_, _) => { property.SetValue(config, check.Checked); }; checks.Add(check);
        }
        if (config.TaskKind != ExecutionTaskKind.DreamTrial) Row("目标（钥匙必选）", checks.ToArray());
        if (config.TaskKind == ExecutionTaskKind.CardMining) Row("固定规则", new Label { Text = "卡矿、常规挖矿、指定层停住、卷轴回城关闭", AutoSize = true });
        ThemeManager.Apply(dialog, currentPalette);
        if (dialog.ShowDialog(this) != DialogResult.OK) return false;
        dialog.ValidateChildren();
        if (config.TaskKind == ExecutionTaskKind.CardMining) EnforceCardMiningOptions(config);
        if (config.TaskKind == ExecutionTaskKind.DreamTrial) EnforceDreamTrialOptions(config);
        return true;
    }

    void MoveScheduledTask(int from, int to)
    {
        if (from < 0 || to < 0 || from >= scheduledTasks.Count || to >= scheduledTasks.Count || from == to) return;
        var item = scheduledTasks[from]; scheduledTasks.RemoveAt(from); scheduledTasks.Insert(to, item);
        RefreshTaskList(to); SaveSettings();
    }

    void AddTaskRow(ListViewItem item)
    {
        var sequence = item.Text;
        item.Text = "";
        item.Tag = sequence;
        item.SubItems.Insert(1, new ListViewItem.ListViewSubItem(item, ""));
        item.SubItems.Insert(2, new ListViewItem.ListViewSubItem(item, ""));
        taskList.Items.Add(item);
    }

    void RefreshTaskList(int selected = -1)
    {
        synchronizingTaskChecks = true;
        taskList.BeginUpdate(); taskList.Items.Clear();
        for (var i = 0; i < scheduledTasks.Count; i++)
        {
            var s = scheduledTasks[i];
            var map = DungeonEntryCatalog.Maps.FirstOrDefault(x => x.Id == s.EntryMapId);
            var entry = DungeonEntryCatalog.EntriesForMap(s.EntryMapId).FirstOrDefault(x => x.Id == s.EntryId);
            var targets = new[] { (s.AttackBoss, "Boss"), (s.Monsters, "小怪"), (s.Elites, "精英"), (s.WoodChests, "木箱子"), (s.OtherChests, "金箱子"), (s.Pots, "罐子"), (s.Bones, "石堆"), (s.Gold, "金币"), (s.Runes, "符文"), (s.Altars, "点金台"), (s.Chambers, "密室") };
            var count = s.EntryRunCount > 0 ? $"{s.EntryRunCount} 次" : s.EntryDifficulty == DungeonDifficulty.Normal ? "自动（无限）" : "剩余次数";
            if (s.TaskKind == ExecutionTaskKind.ScheduledConnectionRecovery)
            {
                var timed = new ListViewItem(new[] { (i + 1).ToString(), "定时启动", "—",
                    $"{s.ScheduledRecoveryStartAt:yyyy-MM-dd HH:mm}", "到点重连", "游戏就绪后继续列表" });
                timed.Checked = s.TaskEnabled; AddTaskRow(timed);
                if (i == selected) { timed.Selected = true; timed.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.DreamTrial)
            {
                var names = new[] { "Troll", "DastardBot", "EldestOne", "Shoggoth", "GodsSpirit", "Mad King" };
                var selectedBosses = string.Join("、", Enumerable.Range(0, 6).Where(index => (s.DreamTrialBossMask & (1 << index)) != 0).Select(index => names[index]));
                var dream = new ListViewItem(new[] { (i + 1).ToString(), "梦境试炼", "—", "依次挑战", "胜利回城后继续", selectedBosses });
                dream.Checked = s.TaskEnabled;
                AddTaskRow(dream);
                if (i == selected) { dream.Selected = true; dream.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.SoulArtifactCultivation)
            {
                var soul = new ListViewItem(new[] { (i + 1).ToString(), "培养魂器", "—", "剩余次数", "普通培养", "完成后关闭背包" });
                soul.Checked = s.TaskEnabled;
                AddTaskRow(soul);
                if (i == selected) { soul.Selected = true; soul.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.FreePrayer)
            {
                var prayer = new ListViewItem(new[] { (i + 1).ToString(), "免费祈祷", "—", "直到不免费", "神迹许愿", "每次关闭并跳过动画" });
                prayer.Checked = s.TaskEnabled;
                AddTaskRow(prayer);
                if (i == selected) { prayer.Selected = true; prayer.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.FreeWelfare)
            {
                var welfare = new ListViewItem(new[] { (i + 1).ToString(), "福利活动", "—", "1 次", "福利活动", "超值礼包与特权礼包" });
                welfare.Checked = s.TaskEnabled;
                AddTaskRow(welfare);
                if (i == selected) { welfare.Selected = true; welfare.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.AbyssKey)
            {
                var key = new ListViewItem(new[] { (i + 1).ToString(), "领取深渊钥匙", "—", "每日限购 1", "宝箱", "已售罄则跳过" });
                key.Checked = s.TaskEnabled;
                AddTaskRow(key);
                if (i == selected) { key.Selected = true; key.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.DailySignIn)
            {
                var signIn = new ListViewItem(new[] { (i + 1).ToString(), "每日签到", "—", "1 次", "签到", "含累计天数奖励" });
                signIn.Checked = s.TaskEnabled;
                AddTaskRow(signIn);
                if (i == selected) { signIn.Selected = true; signIn.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.EternalWinterSweep)
            {
                var sweep = new ListViewItem(new[] { (i + 1).ToString(), "扫荡永冬裂缝", "—", $"{s.EternalWinterSweepCount} 次", $"{s.EternalWinterFloor} 层", "次数不足或未解锁时结束" });
                sweep.Checked = s.TaskEnabled;
                AddTaskRow(sweep);
                if (i == selected) { sweep.Selected = true; sweep.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.AbyssSweep)
            {
                var sweep = new ListViewItem(new[] { (i + 1).ToString(), "扫荡深渊秘境", "—", "按钥匙数量", "深渊模式", "按界面上限选择，完成后领取战利品" });
                sweep.Checked = s.TaskEnabled;
                AddTaskRow(sweep);
                if (i == selected) { sweep.Selected = true; sweep.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.GhostAbyss)
            {
                var abyss = new ListViewItem(new[] { (i + 1).ToString(), "幽灵深渊", s.SwitchEquipmentSet ? $"方案{s.EquipmentSet}" : "—", s.GhostAbyssDouble ? "优先双倍" : "普通次数", $"{s.GhostAbyssFloor} 层", "进入后跑图" });
                abyss.Checked = s.TaskEnabled;
                AddTaskRow(abyss);
                if (i == selected) { abyss.Selected = true; abyss.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.GuildTasks)
            {
                var selectedActions = string.Join("、", new[] { (s.GuildWish, "许愿"), (s.GuildCrystalShop, "水晶商店"), (s.GuildDungeon, $"副本 Boss {s.GuildBoss}") }.Where(x => x.Item1).Select(x => x.Item2));
                var guild = new ListViewItem(new[] { (i + 1).ToString(), "冒险家公会", s.SwitchEquipmentSet ? $"方案{s.EquipmentSet}" : "—", "按界面次数", "公会地图", selectedActions });
                guild.Checked = s.TaskEnabled; AddTaskRow(guild);
                if (i == selected) { guild.Selected = true; guild.EnsureVisible(); }
                continue;
            }
            if (s.TaskKind == ExecutionTaskKind.BossChallenge)
            {
                var bossChallenge = new ListViewItem(new[] { (i + 1).ToString(), "首领挑战", s.SwitchEquipmentSet ? $"方案{s.EquipmentSet}" : "—", "1 次", "回城结束", "首领入侵" });
                bossChallenge.Checked = s.TaskEnabled; AddTaskRow(bossChallenge);
                if (i == selected) { bossChallenge.Selected = true; bossChallenge.EnsureVisible(); }
                continue;
            }
            var taskName = s.TaskKind switch
            {
                ExecutionTaskKind.CurrentMapRun => "当前地图跑图",
                ExecutionTaskKind.EntryAndRun => map?.IsHeroVariant == true
                    ? entry?.Name ?? s.EntryId.ToString()
                    : $"{map?.Name ?? s.EntryMapId.ToString()} {entry?.Name ?? s.EntryId.ToString()}",
                _ => "卡矿任务"
            };
            var item = new ListViewItem(new[] { (i + 1).ToString(), taskName,
                s.TaskKind == ExecutionTaskKind.CurrentMapRun ? "—" : new[] { "普通", "精英", "噩梦" }[Math.Clamp((int)s.EntryDifficulty, 0, 2)], s.TaskKind == ExecutionTaskKind.CurrentMapRun ? "1 次" : s.TaskKind == ExecutionTaskKind.CardMining ? $"{s.CardMiningStartAt:MM-dd HH:mm} / ≥{s.CardMiningMinimumTools}镐" : count,
                s.TaskKind == ExecutionTaskKind.CardMining ? "条件满足即挖 · 最迟目标层" : $"{(s.TargetStopFloor > 0 ? s.TargetStopFloor + "层停" : "不停层")}{(s.EscapeReturnFloor > 0 ? $" · {s.EscapeReturnFloor}层卷轴回城" : "")}{(s.Mining ? " · 挖矿" : "")}{(s.CardMining ? " · 卡矿" : "")}{(s.CardLayer ? " · 卡层" : "")}",
                "钥匙、" + string.Join("、", targets.Where(x => x.Item1).Select(x => x.Item2)) });
            item.Checked = s.TaskEnabled;
            AddTaskRow(item);
            if (i == selected) { item.Selected = true; item.EnsureVisible(); }
        }
        taskList.EndUpdate();
        synchronizingTaskChecks = false;
    }
}


// 在原生 ListView 更改选择前处理勾选框点击，保留 Shift/Ctrl 已建立的多选集合。
sealed class TaskSelectionListView : ListView
{
    public event Action<int>? CheckClicked;
    public event Action<int>? RunClicked;
    public event Action? StopClicked;
    public bool RestoringChecks { get; private set; }
    int activeRunIndex = -1;
    public int ActiveRunIndex { get => activeRunIndex; set { activeRunIndex = value; Invalidate(); } }

    Rectangle CheckButtonBounds(ListViewItem item) => new(item.Bounds.Left + Columns[0].Width + (Columns[1].Width - 18) / 2, item.Bounds.Top + (item.Bounds.Height - 18) / 2, 18, 18);
    Rectangle RunButtonBounds(ListViewItem item) => new(item.Bounds.Left + Columns[0].Width + Columns[1].Width + (Columns[2].Width - 24) / 2, item.Bounds.Top + 1, 24, Math.Max(20, item.Bounds.Height - 2));

    protected override void OnHandleCreated(EventArgs e)
    {
        // 原生列表初始化和重建会重新应用已有项的勾选状态，此时允许恢复。
        RestoringChecks = true;
        try { base.OnHandleCreated(e); }
        finally { RestoringChecks = false; }
    }


    protected override void WndProc(ref Message message)
    {
        const int LeftButtonDown = 0x0201;
        const int LeftButtonDoubleClick = 0x0203;
        const int Paint = 0x000F;
        if (message.Msg is LeftButtonDown or LeftButtonDoubleClick)
        {
            var packed = message.LParam.ToInt64();
            var point = new Point((short)(packed & 0xffff), (short)((packed >> 16) & 0xffff));
            var hit = HitTest(point);
            if (hit.Item is not null && CheckButtonBounds(hit.Item).Contains(point))
            {
                if (message.Msg == LeftButtonDown) { Focus(); CheckClicked?.Invoke(hit.Item.Index); }
                return;
            }
            if (hit.Item is not null && RunButtonBounds(hit.Item).Contains(point))
            {
                if (message.Msg == LeftButtonDown)
                {
                    Focus();
                    if (hit.Item.Index == ActiveRunIndex) StopClicked?.Invoke();
                    else RunClicked?.Invoke(hit.Item.Index);
                }
                return;
            }
            if (hit.Item is not null && (hit.Location & ListViewHitTestLocations.StateImage) != 0)
            {
                // 原生状态图仍在第一列，但序号列由下方自绘覆盖。
                return;
            }
        }
        base.WndProc(ref message);
        if (message.Msg == Paint && IsHandleCreated && Items.Count > 0)
        {
            using var graphics = CreateGraphics();
            foreach (ListViewItem item in Items)
            {
                var firstCell = new Rectangle(item.Bounds.Left, item.Bounds.Top, Columns[0].Width, item.Bounds.Height);
                using (var background = new SolidBrush(item.Selected ? SystemColors.Highlight : BackColor)) graphics.FillRectangle(background, firstCell);
                TextRenderer.DrawText(graphics, item.Tag?.ToString() ?? "", Font, firstCell,
                    item.Selected ? SystemColors.HighlightText : ForeColor,
                    TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
                var nameCell = new Rectangle(item.Bounds.Left + Columns[0].Width + Columns[1].Width + Columns[2].Width,
                    item.Bounds.Top, Columns[3].Width, item.Bounds.Height);
                using (var background = new SolidBrush(item.Selected ? SystemColors.Highlight : BackColor)) graphics.FillRectangle(background, nameCell);
                TextRenderer.DrawText(graphics, item.SubItems.Count > 3 ? item.SubItems[3].Text : "", Font, nameCell,
                    item.Selected ? SystemColors.HighlightText : ForeColor,
                    TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding | TextFormatFlags.EndEllipsis);
                var check = CheckButtonBounds(item);
                ControlPaint.DrawCheckBox(graphics, check, item.Checked ? ButtonState.Checked : ButtonState.Normal);
                var bounds = RunButtonBounds(item);
                if (bounds.Bottom < 0 || bounds.Top > ClientSize.Height) continue;
                var active = item.Index == ActiveRunIndex;
                var color = active ? Color.FromArgb(220, 155, 62) : Color.FromArgb(66, 172, 110);
                using var brush = new SolidBrush(color);
                using var pen = new Pen(color, 2.5f) { StartCap = System.Drawing.Drawing2D.LineCap.Round, EndCap = System.Drawing.Drawing2D.LineCap.Round };
                graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                if (active)
                {
                    graphics.DrawLine(pen, bounds.Left + 8, bounds.Top + 5, bounds.Left + 8, bounds.Bottom - 5);
                    graphics.DrawLine(pen, bounds.Right - 8, bounds.Top + 5, bounds.Right - 8, bounds.Bottom - 5);
                }
                else
                {
                    var centerY = bounds.Top + bounds.Height / 2;
                    graphics.FillPolygon(brush, new Point[] { new(bounds.Left + 8, centerY - 7), new(bounds.Left + 8, centerY + 7), new(bounds.Right - 5, centerY) });
                }
            }
        }
    }
}
