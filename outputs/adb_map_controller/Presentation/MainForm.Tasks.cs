using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace AdbMapController;

public sealed partial class MainForm
{
    readonly List<ControllerSettings> scheduledTasks = [];
    readonly TaskSelectionListView taskList = new() { Dock = DockStyle.Fill, View = View.Details, FullRowSelect = true,
        MultiSelect = true, CheckBoxes = true, HideSelection = false, AllowDrop = true, Tag = ThemeRole.Input,
        AccessibleName = "执行任务列表" };
    bool lastEntryRunSucceeded;
    bool taskQueueRunning;
    bool synchronizingTaskChecks;

    TabPage CreateTaskListPage()
    {
        var page = new ThemedTabPage { Text = "任务列表", Tag = ThemeRole.Default };
        foreach (var column in new[] { ("启用 / 顺序", 90), ("任务 / 地图 / 入口", 240), ("难度", 65), ("次数", 120), ("停层 / 挖矿", 145), ("目标", 340) })
            taskList.Columns.Add(column.Item1, column.Item2);
        var bar = new FlowLayoutPanel { Dock = DockStyle.Top, AutoSize = true, Padding = new(10, 8, 10, 8), Tag = ThemeRole.Surface };
        var taskType = new ThemedComboBox { Width = 135, DropDownStyle = ComboBoxStyle.DropDownList, AccessibleName = "添加任务类型" };
        taskType.Items.AddRange(["进图并跑图", "当前地图跑图"]); taskType.SelectedIndex = 0;
        var add = Btn("添加任务", ThemeRole.SecondaryButton);
        var update = Btn("编辑任务", ThemeRole.SecondaryButton);

        var remove = Btn("删除", ThemeRole.DangerButton);
        var up = Btn("上移", ThemeRole.SecondaryButton);
        var down = Btn("下移", ThemeRole.SecondaryButton);
        var run = Btn("执行列表", ThemeRole.SuccessButton);
        var stop = Btn("停止列表", ThemeRole.WarningButton);
        bar.Controls.AddRange([taskType, add, update, remove, up, down, run, stop]);
        var hint = new Label { Dock = DockStyle.Top, Height = 72, Padding = new(12, 6, 12, 6),
            Text = "选择类型并添加任务；双击或点击“编辑任务”修改设置；拖拽调整顺序。\nShift/Ctrl 多选后，点击任一选中项的勾选框统一启用/禁用；仅执行启用项。\n按列表顺序执行所选类型；失败或停层时停止列表。普通自动次数会无限运行，阻塞后续任务。", Tag = ThemeRole.MutedText };
        page.Controls.Add(taskList); page.Controls.Add(hint); page.Controls.Add(bar);
        bool Editable() => !taskQueueRunning && activeEntry is not { IsCompleted: false } && activeMovement is not { IsCompleted: false };
        int Selected() => taskList.SelectedIndices.Count == 0 ? -1 : taskList.SelectedIndices[0];
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
            if (synchronizingTaskChecks) return;
            if (!Editable()) { e.NewValue = e.CurrentValue; return; }
            SetEnabled(e.Index, e.NewValue == CheckState.Checked);
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
            var config = CaptureSettings(); config.TaskKind = (ExecutionTaskKind)taskType.SelectedIndex;
            if (!ShowTaskEditor(config, "添加任务")) return;
            scheduledTasks.Add(config); RefreshTaskList(scheduledTasks.Count - 1); SaveSettings();
        };
        void EditSelected()
        {
            var i = Selected(); if (!Editable() || i < 0) return;
            var config = System.Text.Json.JsonSerializer.Deserialize<ControllerSettings>(System.Text.Json.JsonSerializer.Serialize(scheduledTasks[i]))!;
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
                        var config = scheduledTasks[i];
                        if (!config.TaskEnabled) continue;
                        config.Theme = original.Theme; config.AlwaysOnTop = original.AlwaysOnTop; config.Device = original.Device;
                        ApplySettings(config); RefreshTaskList(i);
                        Log($"执行任务列表：第 {i + 1}/{scheduledTasks.Count} 项");
                        if (config.TaskKind == ExecutionTaskKind.EntryAndRun) await RunEntryRunPipelineAsync(token);
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
            finally { ApplySettings(original); UpdateBonusPriorityCaption(); taskQueueRunning = false; bar.Enabled = true; if (settingsPage is not null) settingsPage.Enabled = true; SaveSettings(); }
        });
        stop.Click += async (_, _) => await RunUi(EmergencyStopAndClear);
        bar.Controls.Remove(stop);
        var stopBar = new FlowLayoutPanel { Dock = DockStyle.Bottom, AutoSize = true, Padding = new(10, 6, 10, 6), Tag = ThemeRole.Surface };
        stopBar.Controls.Add(stop); page.Controls.Add(stopBar);
        RefreshTaskList();
        return page;
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
        if (config.TaskKind == ExecutionTaskKind.EntryAndRun)
        {
            var maps = DungeonEntryCatalog.Maps;
            var map = new ThemedComboBox { Width = 150, DropDownStyle = ComboBoxStyle.DropDownList };
            var entry = new ThemedComboBox { Width = 130, DropDownStyle = ComboBoxStyle.DropDownList };
            var difficulty = new ThemedComboBox { Width = 100, DropDownStyle = ComboBoxStyle.DropDownList };
            var rebuilding = false;
            void Rebuild()
            {
                rebuilding = true;
                var selectedMap = maps[Math.Max(0, map.SelectedIndex)];
                var entries = DungeonEntryCatalog.EntriesForMap(selectedMap.Id);
                entry.Items.Clear(); entry.Items.AddRange(entries.Select(x => (object)x.Name).ToArray());
                entry.SelectedIndex = Math.Max(0, entries.ToList().FindIndex(x => x.Id == config.EntryId));
                var difficulties = selectedMap.Difficulties;
                difficulty.Items.Clear(); difficulty.Items.AddRange(difficulties.Select(x => (object)new[] { "普通", "精英", "噩梦" }[(int)x]).ToArray());
                difficulty.SelectedIndex = Math.Max(0, difficulties.ToList().IndexOf(config.EntryDifficulty));
                config.EntryMapId = selectedMap.Id; config.EntryId = entries[entry.SelectedIndex].Id;
                config.EntryDifficulty = difficulties[difficulty.SelectedIndex]; rebuilding = false;
            }
            map.Items.AddRange(maps.Select(x => (object)x.Name).ToArray());
            map.SelectedIndex = Math.Max(0, maps.ToList().FindIndex(x => x.Id == config.EntryMapId)); Rebuild();
            map.SelectedIndexChanged += (_, _) => { Rebuild(); };
            entry.SelectedIndexChanged += (_, _) => { if (rebuilding) return; config.EntryId = DungeonEntryCatalog.EntriesForMap(config.EntryMapId)[entry.SelectedIndex].Id; };
            difficulty.SelectedIndexChanged += (_, _) => { if (rebuilding) return; config.EntryDifficulty = maps[map.SelectedIndex].Difficulties[difficulty.SelectedIndex]; };
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
        if (config.TaskKind == ExecutionTaskKind.EntryAndRun) Number(nameof(config.EntryRunCount), "跑图次数（0=自动，普通无限）", 0, 9999);
        Number(nameof(config.TargetStopFloor), "停住楼层（0=关闭）", 0, 999);
        var checks = new List<Control>();
        foreach (var field in new[] { ("AttackBoss", "Boss"), ("Monsters", "小怪"), ("Elites", "精英"), ("Chests", "箱子"), ("Pots", "罐子"), ("Bones", "石堆"), ("Gold", "金币"), ("Runes", "符文/点金台"), ("Chambers", "密室"), ("Mining", "挖矿"), ("CardMining", "卡矿"), ("CardLayer", "卡层") })
        {
            var property = typeof(ControllerSettings).GetProperty(field.Item1)!;
            var check = Box(field.Item2); check.Checked = (bool)property.GetValue(config)!;
            check.CheckedChanged += (_, _) => { property.SetValue(config, check.Checked); }; checks.Add(check);
        }
        Row("目标（钥匙必选）", checks.ToArray());
        ThemeManager.Apply(dialog, currentPalette);
        if (dialog.ShowDialog(this) != DialogResult.OK) return false;
        dialog.ValidateChildren();
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
            var item = new ListViewItem(new[] { (i + 1).ToString(), s.TaskKind == ExecutionTaskKind.CurrentMapRun ? "当前地图跑图" : $"进图并跑图 · {map?.Name ?? s.EntryMapId.ToString()} / {entry?.Name ?? s.EntryId.ToString()}",
                s.TaskKind == ExecutionTaskKind.CurrentMapRun ? "—" : new[] { "普通", "精英", "噩梦" }[Math.Clamp((int)s.EntryDifficulty, 0, 2)], s.TaskKind == ExecutionTaskKind.CurrentMapRun ? "1 次" : count,
                $"{(s.TargetStopFloor > 0 ? s.TargetStopFloor + "层停" : "不停层")}{(s.Mining ? " · 挖矿" : "")}{(s.CardMining ? " · 卡矿" : "")}{(s.CardLayer ? " · 卡层" : "")}",
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
