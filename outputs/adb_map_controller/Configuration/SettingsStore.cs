using System.IO;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace AdbMapController;

/// <summary>
/// Settings persistence seam. The UI owns mapping controls to settings; the
/// adapter owns only durable storage and its failure semantics.
/// </summary>
public interface ISettingsStore
{
    ControllerSettings? Load();
    void Save(ControllerSettings settings);
}

public sealed class JsonSettingsStore : ISettingsStore
{
    static readonly JsonSerializerOptions JsonOptions = new() { WriteIndented = true };
    static readonly string[] CommonTaskFields =
    [
        nameof(ControllerSettings.TaskKind), nameof(ControllerSettings.TaskEnabled),
        nameof(ControllerSettings.SwitchEquipmentSet), nameof(ControllerSettings.EquipmentSet)
    ];
    static readonly string[] TargetFields =
    [
        nameof(ControllerSettings.AttackBoss), nameof(ControllerSettings.DirectBossNpc), nameof(ControllerSettings.Monsters),
        nameof(ControllerSettings.Elites), nameof(ControllerSettings.Chests),
        nameof(ControllerSettings.Pots), nameof(ControllerSettings.Bones),
        nameof(ControllerSettings.Gold), nameof(ControllerSettings.Runes), nameof(ControllerSettings.Altars),
        nameof(ControllerSettings.Chambers)
    ];
    static readonly string[] RouteFields =
    [
        nameof(ControllerSettings.TargetStopFloor), nameof(ControllerSettings.EscapeReturnFloor),
        nameof(ControllerSettings.EscapeReturnAttackBoss), nameof(ControllerSettings.Mining),
        nameof(ControllerSettings.CardMining), nameof(ControllerSettings.CardLayer)
    ];
    static readonly string[] EntryFields =
    [
        nameof(ControllerSettings.EntryMapId), nameof(ControllerSettings.EntryId),
        nameof(ControllerSettings.EntryDifficulty)
    ];
    readonly string path;
    readonly Action<string>? diagnostic;

    public JsonSettingsStore(string path) : this(path, null) { }
    public JsonSettingsStore(string path, Action<string>? diagnostic)
    {
        this.path = Path.GetFullPath(path);
        this.diagnostic = diagnostic;
    }

    void Report(string operation, Exception error)
    {
        try { diagnostic?.Invoke($"Settings {operation}: {error.GetType().Name}: {error.Message}"); } catch { }
    }

    public ControllerSettings? Load()
    {
        try
        {
            if (!File.Exists(path)) return null;
            var document = JsonNode.Parse(File.ReadAllText(path))!.AsObject();
            // 旧版“符文/点金台”由 Runes 同时控制；迁移时保留两者原有选择。
            MigrateAltars(document);
            if (document[nameof(ControllerSettings.ExecutionTasks)] is JsonArray tasks)
                foreach (var task in tasks.OfType<JsonObject>()) MigrateAltars(task);
            if (document[nameof(ControllerSettings.TaskTemplates)] is JsonArray templates)
                foreach (var template in templates.OfType<JsonObject>())
                {
                    if (template[nameof(TaskTemplate.Task)] is JsonObject oldTask) MigrateAltars(oldTask);
                    if (template[nameof(TaskTemplate.Tasks)] is JsonArray templateTasks)
                        foreach (var task in templateTasks.OfType<JsonObject>()) MigrateAltars(task);
                }
            return document.Deserialize<ControllerSettings>();
        }
        catch (Exception ex) { Report("Load", ex); return null; }
    }

    static void MigrateAltars(JsonObject settings)
    {
        if (!settings.ContainsKey(nameof(ControllerSettings.Altars)))
            settings[nameof(ControllerSettings.Altars)] = settings[nameof(ControllerSettings.Runes)]?.GetValue<bool>() ?? false;
    }

    public void Save(ControllerSettings settings)
    {
        var temp = path + ".tmp";
        try
        {
            var document = JsonSerializer.SerializeToNode(settings, JsonOptions)!.AsObject();
            // 任务只保存编辑器提供的选项；旧配置中的额外字段在下次保存时清除。
            if (document[nameof(ControllerSettings.ExecutionTasks)] is JsonArray tasks)
                foreach (var task in tasks.OfType<JsonObject>()) TrimTask(task);
            if (document[nameof(ControllerSettings.TaskTemplates)] is JsonArray templates)
                foreach (var template in templates.OfType<JsonObject>())
                {
                    template.Remove(nameof(TaskTemplate.Task));
                    if (template[nameof(TaskTemplate.Tasks)] is JsonArray templateTasks)
                        foreach (var task in templateTasks.OfType<JsonObject>()) TrimTask(task);
                }
            File.WriteAllText(temp, document.ToJsonString(JsonOptions));
            File.Move(temp, path, true);
        }
        catch (Exception ex)
        {
            try { if (File.Exists(temp)) File.Delete(temp); } catch { }
            Report("Save", ex);
        }
    }

    static void TrimTask(JsonObject task)
    {
                    var kind = Enum.TryParse<ExecutionTaskKind>(task[nameof(ControllerSettings.TaskKind)]?.GetValue<string>(), out var parsed)
                        ? parsed : ExecutionTaskKind.EntryAndRun;
                    var allowed = new HashSet<string>(CommonTaskFields);
                    if (kind is ExecutionTaskKind.EntryAndRun or ExecutionTaskKind.CardMining)
                        allowed.UnionWith(EntryFields);
                    if (kind != ExecutionTaskKind.DreamTrial)
                        allowed.UnionWith(TargetFields);
                    if (kind is ExecutionTaskKind.EntryAndRun or ExecutionTaskKind.CurrentMapRun)
                        allowed.UnionWith(RouteFields);
                    if (kind == ExecutionTaskKind.EntryAndRun)
                        allowed.Add(nameof(ControllerSettings.EntryRunCount));
                    if (kind == ExecutionTaskKind.CardMining)
                    {
                        allowed.Add(nameof(ControllerSettings.CardMiningStartAt));
                        allowed.Add(nameof(ControllerSettings.CardMiningMinimumTools));
                    }
                    if (kind == ExecutionTaskKind.DreamTrial)
                        allowed.Add(nameof(ControllerSettings.DreamTrialBossMask));
                    if (kind == ExecutionTaskKind.EternalWinterSweep)
                    {
                        allowed.Add(nameof(ControllerSettings.EternalWinterFloor));
                        allowed.Add(nameof(ControllerSettings.EternalWinterSweepCount));
                    }
                    if (kind == ExecutionTaskKind.GhostAbyss)
                    {
                        allowed.Add(nameof(ControllerSettings.GhostAbyssFloor));
                        allowed.Add(nameof(ControllerSettings.GhostAbyssDouble));
                    }
                    foreach (var field in task.Select(x => x.Key).Where(x => !allowed.Contains(x)).ToArray())
                        task.Remove(field);
    }
}
