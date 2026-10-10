using System.IO;
using System.Text.Json;

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
            File.WriteAllText(temp, JsonSerializer.Serialize(settings, JsonOptions));
            File.Move(temp, path, true);
        }
        catch (Exception ex)
        {
            try { if (File.Exists(temp)) File.Delete(temp); } catch { }
            Report("Save", ex);
        }
    }
}
