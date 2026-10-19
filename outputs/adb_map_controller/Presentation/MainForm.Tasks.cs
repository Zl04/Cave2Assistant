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
    bool synchronizingTaskChecks;
    bool cardMiningTaskRunning;
    bool cardMiningEarlyStop;
    long cardMiningNextToolCheck;
    ControllerSettings? activeCardMiningConfig;
    Task<MiningToolStatus>? pendingCardMiningToolRead;

    TabPage CreateTaskListPage()
    {
        var page = new ThemedTabPage { Text = "任务列表", Tag = ThemeRole.Default };
        foreach (var column in new[] { ("启用 / 顺序", 90), ("任务 / 地图 / 入口", 240), ("难度", 65), ("次数", 120), ("停层 / 挖矿", 145), ("目标", 340) })
            taskList.Columns.Add(column.Item1, column.Item2);
        var bar = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, Padding = new(10, 8, 10, 8), Tag = ThemeRole.Surface };
        var taskType = new ThemedComboBox { Width = 135, DropDownStyle = ComboBoxStyle.DropDownList, AccessibleName = "添加任务类型" };
        taskType.Items.AddRange(["进图并跑图", "当前地图跑图", "卡矿任务", "梦境试炼"]); taskType.SelectedIndex = 0;
        var templateChoice = new ThemedComboBox { Width = 160, DropDownStyle = ComboBoxStyle.DropDownList, AccessibleName = "任务模板" };
        taskTemplateChoice = templateChoice;
        var newTemplate = Btn("新建模板", ThemeRole.SecondaryButton);
        var editTemplate = Btn("修改模板", ThemeRole.SecondaryButton);
        var add = Btn("添加任务", ThemeRole.SecondaryButton);
        var update = Btn("编辑任务", ThemeRole.SecondaryButton);

        var remove = Btn("删除", ThemeRole.DangerButton);
        var up = Btn("上移", ThemeRole.SecondaryButton);
        var down = Btn("下移", ThemeRole.SecondaryButton);
        var selectAll = Btn("全选", ThemeRole.SecondaryButton);
        var invertSelection = Btn("反选", ThemeRole.SecondaryButton);
        var run = Btn("执行列表", ThemeRole.SuccessButton);
        var stop = Btn("停止列表", ThemeRole.WarningButton);
        bar.Controls.AddRange([templateChoice, newTemplate, editTemplate, add, update, remove, up, down, selectAll, invertSelection, run, stop]);
        var hint = new Label { Dock = DockStyle.Top, Height = 72, Padding = new(12, 6, 12, 6),
            Text = "选择模板后管理其中的任务；新建模板会创建空列表，修改模板可重命名。双击任务修改设置；拖拽调整顺序。\n全选启用全部任务，反选切换全部任务的启用状态；Shift/Ctrl 多选后可统一勾选；仅执行启用项。\n按列表顺序执行所选类型；失败或停层时停止列表。普通自动次数会无限运行，阻塞后续任务。", Tag = ThemeRole.MutedText };
        page.Controls.Add(taskList); page.Controls.Add(hint); page.Controls.Add(bar);
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
        taskList.StateImageClicked += index => SetEnabled(index, !scheduledTasks[index].TaskEnabled);
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
        run.Click += async (_, _) => await RunUi(async () =>
        {
            if (!Editable()) throw new InvalidOperationException("请先停止当前任务");
            if (!scheduledTasks.Any(x => x.TaskEnabled)) throw new InvalidOperationException("请先添加并启用至少一个任务");
            if (string.IsNullOrWhiteSpace(devices.Text)) throw new InvalidOperationException("请先连接设备");
            var original = CaptureSettings();
            taskQueueRunning = true;
            bar.Enabled = false; stop.Enabled = true;
            var settingsPage = (page.Parent as TabControl)?.TabPages.Cast<TabPage>().FirstOrDefault(x => x.Text == "设置");
            if (settingsPage is not null) settingsPage.Enabled = false;
            // 停止按钮留在独立容器，确保运行时仍能取消。
            try
            {
                await operations.RunAsync(ControllerOperationKind.Entry, async token =>
                {
                    for (var i = 0; i < scheduledTasks.Count; i++)
                    {
                        token.ThrowIfCancellationRequested();
                        var task = scheduledTasks[i];
                        if (!task.TaskEnabled) continue;
                        var config = ResolveTaskSettings(original, task);
                        ApplySettings(config, applyEquipmentSale: false); RefreshTaskList(i);
                        Log($"执行任务列表：第 {i + 1}/{scheduledTasks.Count} 项");
                        if (config.SwitchEquipmentSet) await TrySwitchTaskEquipmentAsync(config.EquipmentSet, token);
                        if (config.TaskKind == ExecutionTaskKind.CardMining) await RunCardMiningTaskAsync(config, token);
                        else if (config.TaskKind == ExecutionTaskKind.DreamTrial) await RunDreamTrialTaskAsync(config, token);
                        else if (config.TaskKind == ExecutionTaskKind.EntryAndRun) await RunEntryRunPipelineAsync(token);
                        else if (config.TaskKind == ExecutionTaskKind.CurrentMapRun)
                        {
                            await RunMovementScope(token, StartRunCore, startupProbePaused: true);
                            lastEntryRunSucceeded = lastMapRunSucceeded;
                        }
                        else { State("任务列表停止：不支持的任务类型"); return; }
                        token.ThrowIfCancellationRequested();
                        if (!lastEntryRunSucceeded) { State($"任务列表停止：第 {i + 1} 项未完成"); return; }
                    }
                    State("已启用的任务全部完成");
                });
            }
            catch (OperationCanceledException ex) when (ex.CancellationToken.IsCancellationRequested)
            {
                Log("任务列表已停止，不再执行后续任务");
                if (!stopping) State("列表已停止");
            }
            finally { ApplySettings(original); UpdateBonusPriorityCaption(); taskQueueRunning = false; bar.Enabled = true; if (settingsPage is not null) settingsPage.Enabled = true; SaveSettings(); }
        });
        stop.Click += async (_, _) => await RunUi(EmergencyStopAndClear);
        bar.Controls.Remove(stop);
        var stopBar = new FlowLayoutPanel { Dock = DockStyle.Bottom, AutoSize = true, Padding = new(10, 6, 10, 6), Tag = ThemeRole.Surface };
        stopBar.Controls.Add(stop); page.Controls.Add(stopBar);
        RefreshTaskList();
        return page;
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
        result.SwitchEquipmentSet = task.SwitchEquipmentSet;
        result.EquipmentSet = task.EquipmentSet;
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
            result.Monsters = task.Monsters;
            result.Elites = task.Elites;
            result.Chests = task.Chests;
            result.Pots = task.Pots;
            result.Bones = task.Bones;
            result.Gold = task.Gold;
            result.Runes = task.Runes;
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
        if (config.TaskKind == ExecutionTaskKind.EntryAndRun) Number(nameof(config.EntryRunCount), "跑图次数（0=自动，普通无限）", 0, 9999);
        if (config.TaskKind is not (ExecutionTaskKind.CardMining or ExecutionTaskKind.DreamTrial)) Number(nameof(config.TargetStopFloor), "停住楼层（0=关闭）", 0, 999);
        if (config.TaskKind is not (ExecutionTaskKind.CardMining or ExecutionTaskKind.DreamTrial)) Number(nameof(config.EscapeReturnFloor), "卷轴主动回城楼层（0=关闭）", 0, 999);
        if (config.TaskKind == ExecutionTaskKind.CardMining)
        {
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
        foreach (var field in config.TaskKind == ExecutionTaskKind.DreamTrial ? Array.Empty<(string, string)>() : new[] { ("AttackBoss", "Boss"), ("Monsters", "小怪"), ("Elites", "精英"), ("Chests", "箱子"), ("Pots", "罐子"), ("Bones", "石堆"), ("Gold", "金币"), ("Runes", "符文/点金台"), ("Chambers", "密室"), ("Mining", "挖矿"), ("CardMining", "卡矿"), ("CardLayer", "卡层") })
        {
            if (config.TaskKind == ExecutionTaskKind.CardMining && field.Item1 is "Mining" or "CardMining" or "CardLayer") continue;
            var property = typeof(ControllerSettings).GetProperty(field.Item1)!;
            var check = Box(field.Item2); check.Checked = (bool)property.GetValue(config)!;
            check.CheckedChanged += (_, _) => { property.SetValue(config, check.Checked); }; checks.Add(check);
        }
        if (config.TaskKind != ExecutionTaskKind.DreamTrial) Row("目标（钥匙必选）", checks.ToArray());
        if (config.TaskKind == ExecutionTaskKind.CardMining) Row("固定规则", new Label { Text = "卡矿、常规挖矿、指定层停住、卷轴回城关闭", AutoSize = true });
        ThemeManager.Apply(dialog, currentPalette);
        RefreshEquipmentSetAppearance();
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

    void RefreshTaskList(int selected = -1)
    {
        synchronizingTaskChecks = true;
        taskList.BeginUpdate(); taskList.Items.Clear();
        for (var i = 0; i < scheduledTasks.Count; i++)
        {
            var s = scheduledTasks[i];
            var map = DungeonEntryCatalog.Maps.FirstOrDefault(x => x.Id == s.EntryMapId);
            var entry = DungeonEntryCatalog.EntriesForMap(s.EntryMapId).FirstOrDefault(x => x.Id == s.EntryId);
            var targets = new[] { (s.AttackBoss, "Boss"), (s.Monsters, "小怪"), (s.Elites, "精英"), (s.Chests, "箱子"), (s.Pots, "罐子"), (s.Bones, "石堆"), (s.Gold, "金币"), (s.Runes, "符文"), (s.Chambers, "密室") };
            var count = s.EntryRunCount > 0 ? $"{s.EntryRunCount} 次" : s.EntryDifficulty == DungeonDifficulty.Normal ? "自动（无限）" : "自动（剩余次数）";
            var equipment = s.SwitchEquipmentSet ? $" · 装备检测/方案{Math.Clamp(s.EquipmentSet, 1, 3)}" : "";
            if (s.TaskKind == ExecutionTaskKind.DreamTrial)
            {
                var names = new[] { "Troll", "DastardBot", "EldestOne", "Shoggoth", "GodsSpirit", "Mad King" };
                var selectedBosses = string.Join("、", Enumerable.Range(0, 6).Where(index => (s.DreamTrialBossMask & (1 << index)) != 0).Select(index => names[index]));
                var dream = new ListViewItem(new[] { (i + 1).ToString(), "梦境试炼" + equipment, "—", "依次挑战", "胜利回城后继续", selectedBosses });
                dream.Checked = s.TaskEnabled;
                taskList.Items.Add(dream);
                if (i == selected) { dream.Selected = true; dream.EnsureVisible(); }
                continue;
            }
            var item = new ListViewItem(new[] { (i + 1).ToString(), (s.TaskKind == ExecutionTaskKind.CurrentMapRun ? "当前地图跑图" : $"{(s.TaskKind == ExecutionTaskKind.CardMining ? "卡矿任务" : "进图并跑图")} · {map?.Name ?? s.EntryMapId.ToString()} / {entry?.Name ?? s.EntryId.ToString()}") + equipment,
                s.TaskKind == ExecutionTaskKind.CurrentMapRun ? "—" : new[] { "普通", "精英", "噩梦" }[Math.Clamp((int)s.EntryDifficulty, 0, 2)], s.TaskKind == ExecutionTaskKind.CurrentMapRun ? "1 次" : s.TaskKind == ExecutionTaskKind.CardMining ? $"{s.CardMiningStartAt:MM-dd HH:mm} / ≥{s.CardMiningMinimumTools}镐" : count,
                s.TaskKind == ExecutionTaskKind.CardMining ? "条件满足即挖 · 最迟目标层" : $"{(s.TargetStopFloor > 0 ? s.TargetStopFloor + "层停" : "不停层")}{(s.EscapeReturnFloor > 0 ? $" · {s.EscapeReturnFloor}层卷轴回城" : "")}{(s.Mining ? " · 挖矿" : "")}{(s.CardMining ? " · 卡矿" : "")}{(s.CardLayer ? " · 卡层" : "")}",
                "钥匙、" + string.Join("、", targets.Where(x => x.Item1).Select(x => x.Item2)) });
            item.Checked = s.TaskEnabled;
            taskList.Items.Add(item);
            if (i == selected) { item.Selected = true; item.EnsureVisible(); }
        }
        taskList.EndUpdate();
        synchronizingTaskChecks = false;
    }
}


// 在原生 ListView 更改选择前处理勾选框点击，保留 Shift/Ctrl 已建立的多选集合。
sealed class TaskSelectionListView : ListView
{
    public event Action<int>? StateImageClicked;
    public bool RestoringChecks { get; private set; }

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
        if (message.Msg is LeftButtonDown or LeftButtonDoubleClick)
        {
            var packed = message.LParam.ToInt64();
            var point = new Point((short)(packed & 0xffff), (short)((packed >> 16) & 0xffff));
            var hit = HitTest(point);
            if (hit.Item is not null && (hit.Location & ListViewHitTestLocations.StateImage) != 0)
            {
                if (message.Msg == LeftButtonDown)
                {
                    Focus();
                    StateImageClicked?.Invoke(hit.Item.Index);
                }
                return;
            }
        }
        base.WndProc(ref message);
    }
}
