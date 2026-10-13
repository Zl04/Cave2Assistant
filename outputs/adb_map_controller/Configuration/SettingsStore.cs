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
            return JsonSerializer.Deserialize<ControllerSettings>(File.ReadAllText(path));
        }
        catch (Exception ex) { Report("Load", ex); return null; }
    }

    public void Save(ControllerSettings settings)
    {
        var temp = path + ".tmp";
        try
        {
            var document = JsonSerializer.SerializeToNode(settings, JsonOptions)!.AsObject();
            // 出售设置只保存在通用配置中；旧任务里的同名字段不再写回。
            if (document[nameof(ControllerSettings.ExecutionTasks)] is JsonArray tasks)
                foreach (var task in tasks.OfType<JsonObject>())
                    foreach (var field in new[] { nameof(ControllerSettings.AutoEquipmentSale), nameof(ControllerSettings.SellBlueWhite),
                        nameof(ControllerSettings.SellPurple), nameof(ControllerSettings.SellDarkGold), nameof(ControllerSettings.SellGold) })
                        task.Remove(field);
            File.WriteAllText(temp, document.ToJsonString(JsonOptions));
            File.Move(temp, path, true);
        }
        catch (Exception ex)
        {
            try { if (File.Exists(temp)) File.Delete(temp); } catch { }
            Report("Save", ex);
        }
    }
}
