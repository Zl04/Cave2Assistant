using System;
using System.IO;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace AdbMapController;

/// <summary>
/// Reads the game-owned map and player snapshots through the privileged ADB shell.
/// It owns JSON decoding and the on-device file contract, but not ADB process lifetime.
/// </summary>
internal sealed class AdbGameDataReader
{
    const string Root = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline";
    const int JsonReadMaxAttempts = 20;
    const int JsonReadRetryDelayMs = 5;
    const int AtomicJsonAvailabilityMaxAttempts = 20;
    const string AtomicJsonAvailabilityRetryDelaySeconds = "0.005";

    static readonly JsonSerializerOptions JsonOptions = CreateOptions();
    readonly Func<string, Task<string>> runRoot;

    public AdbGameDataReader(Func<string, Task<string>> runRoot)
        => this.runRoot = runRoot ?? throw new ArgumentNullException(nameof(runRoot));

    static JsonSerializerOptions CreateOptions()
    {
        var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
        options.Converters.Add(new FlexibleIntConverter());
        return options;
    }

    public async Task<MapDump> ReadMapAsync()
    {
        var map = await ReadJsonAsync<MapDump>($"{Root}/codex_map_dump.json");
        for (var y = 0; y < map.Tiles.Count; y++)
        for (var x = 0; x < map.Tiles[y].Count; x++)
        {
            var tile = map.Tiles[y][x];
            if (tile.X == 0 && tile.Y == 0 && (x != 0 || y != 0)) { tile.X = x; tile.Y = y; }
        }
        // Only game-exported exploration signals are authoritative. A tile marked
        // reached by the server is explored; ISeeDeadPeople/allExplored reveals all.
        map.ApplyGameExplorationState();
        return map;
    }

    public Task<PlayerStatus> ReadPlayerAsync()
        => ReadJsonAsync<PlayerStatus>($"{Root}/codex_player_status.json");

    async Task<T> ReadJsonAsync<T>(string path)
    {
        JsonException? lastJsonError = null;
        for (var attempt = 0; attempt < JsonReadMaxAttempts; attempt++)
        {
            var json = await ReadAtomicJsonAsync(path);
            try
            {
                return JsonSerializer.Deserialize<T>(json, JsonOptions)
                    ?? throw new InvalidDataException($"设备端 JSON 为空：{path}");
            }
            catch (JsonException ex)
            {
                lastJsonError = ex;
                if (attempt + 1 < JsonReadMaxAttempts) await Task.Delay(JsonReadRetryDelayMs);
            }
        }
        var detail = lastJsonError is null ? "未知解析错误" : lastJsonError.Message;
        throw new InvalidDataException($"设备端 JSON 在重试后仍无法解析：{path}；最后错误：{detail}", lastJsonError);
    }

    async Task<string> ReadAtomicJsonAsync(string path)
    {
        // Base64 keeps file contents ASCII so large JSON lines cannot be confused
        // with shell output or the persistent-shell completion marker.
        const string notReady = "__CODEX_DATA_NOT_READY__";
        var result = await runRoot($"i=0; ok=1; while [ $i -lt {AtomicJsonAvailabilityMaxAttempts} ]; do if [ -f '{path}' ]; then if command -v base64 >/dev/null 2>&1; then base64 '{path}' 2>/dev/null; else cat '{path}' 2>/dev/null; fi; status=$?; else status=1; fi; if [ $status -eq 0 ]; then ok=0; break; fi; i=$((i+1)); sleep {AtomicJsonAvailabilityRetryDelaySeconds}; done; if [ $ok -ne 0 ]; then printf '%s' '{notReady}'; fi");
        if (result.Trim() == notReady)
            throw new FileNotFoundException("助手地图数据尚未生成。若刚安装助手，请彻底结束并重新启动游戏，然后进入地图。");
        try
        {
            return Encoding.UTF8.GetString(Convert.FromBase64String(result));
        }
        catch (FormatException)
        {
            // Compatibility fallback for devices without base64.
            return result;
        }
    }
}
