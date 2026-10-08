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

public sealed class JsonSettingsStore(string path) : ISettingsStore
{
    static readonly JsonSerializerOptions JsonOptions = new() { WriteIndented = true };
    readonly string path = Path.GetFullPath(path);

    public ControllerSettings? Load()
    {
        try
        {
            if (!File.Exists(path)) return null;
            return JsonSerializer.Deserialize<ControllerSettings>(File.ReadAllText(path));
        }
        catch { return null; }
    }

    public void Save(ControllerSettings settings)
    {
        var temp = path + ".tmp";
        try
        {
            File.WriteAllText(temp, JsonSerializer.Serialize(settings, JsonOptions));
            File.Move(temp, path, true);
        }
        catch
        {
            try { if (File.Exists(temp)) File.Delete(temp); } catch { }
        }
    }
}
