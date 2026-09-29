using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed class AdbClient : IDisposable
{
    const string Root = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline";
    const string TestPanelCommandPath = Root + "/codex_test_panel.command";
    const string TestPanelCommandTempPath = TestPanelCommandPath + ".tmp";
    const string TestPanelResultPath = Root + "/codex_test_panel.result";
    static readonly JsonSerializerOptions JsonOptions = CreateOptions();
    static JsonSerializerOptions CreateOptions()
    {
        var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
        options.Converters.Add(new FlexibleIntConverter());
        return options;
    }
    string serial = "emulator-5556";
    Process? rootShell;
    IAndroidTouchBackend? touchBackend;
    readonly SemaphoreSlim rootShellLock = new(1, 1);
    readonly SemaphoreSlim deviceConnectionLock = new(1, 1);
    readonly SemaphoreSlim touchPayloadLock = new(1, 1);
    readonly SemaphoreSlim screenCaptureLock = new(1, 1);
    readonly ScreenFrameCache popupFrameCache = new();
    readonly PaddleOcrEngine paddleOcr = new();
    readonly Lazy<VisualTemplate?> miningToolTemplate = new(LoadMiningToolTemplate);
    long rootCommandId;
    bool touchPayloadsReady;
    bool adbRunsAsRoot;
    int screenWidth;
    int screenHeight;
    int touchOrientation;
    int androidSdk;
    long popupFrameSequence;
    string? touchBackendDescription;
    const int AdbCommandTimeoutMs = 5000;
    const int PersistentShellTimeoutMs = 3000;
    const int ScreenCaptureTimeoutMs = 5000;
    public string TouchDescription => screenWidth == 0 || touchBackendDescription is null
        ? "未检测"
        : touchBackendDescription;
    public bool IsTouchReady => touchPayloadsReady && touchBackend is not null;
    public string? LastRiftGemTitle { get; private set; }
    public string GemTitleDetectionMode { get; private set; } = "未检测";
    internal NextFloorDialogKind LastNextFloorDialogKind { get; private set; }
    public string Serial
    {
        get => serial;
        set
        {
            if (serial == value) return;
            serial = value;
            ResetDeviceSession();
        }
    }

    async Task<string> ReadPaddleTextAsync(Bitmap image, CancellationToken token = default)
        => (await paddleOcr.RecognizeAsync(image, token)).Text.Trim();

    public async Task<MiningToolStatus> ReadMiningToolStatusAsync(CancellationToken token = default)
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕", token);
        return await ReadMiningToolStatusAsync(bitmap, token);
    }

    internal async Task<MiningToolStatus> ReadMiningToolStatusAsync(Bitmap source, CancellationToken token = default)
    {
        var iconPresent = HasMiningToolIcon(source);
        var quantityText = await ReadMiningToolQuantityTextAsync(source, token);
        return new(iconPresent, MiningToolGuard.ParseQuantityText(quantityText));
    }

    static VisualTemplate? LoadMiningToolTemplate()
    {
        var path = Path.Combine(AppContext.BaseDirectory, "vision", "mining_tool_slot.png");
        if (!File.Exists(path)) return null;
        try
        {
            var template = VisualTemplate.FromFile(path);
            // The tight template is 97x81 at 1920x1080; matching scales from
            // the shorter display dimension so the guard also works at other sizes.
            template.PatchWidthRatio = 97d / 1080d;
            template.PatchHeightRatio = 81d / 1080d;
            return template;
        }
        catch { return null; }
    }

    bool HasMiningToolIcon(Bitmap source)
    {
        var template = miningToolTemplate.Value;
        if (template is null) return false;
        var expectedX = source.Width * MiningScreenCoordinates.ToolSlot.X;
        var expectedY = source.Height * MiningScreenCoordinates.ToolSlot.Y;
        return template.FindAll(source, .84, 16).Any(match =>
            Math.Abs(match.Center.X - expectedX) <= source.Width * .10 &&
            Math.Abs(match.Center.Y - expectedY) <= source.Height * .10);
    }

    async Task<string> ReadMiningToolQuantityTextAsync(Bitmap source, CancellationToken token)
    {
        // QuickBagGrid places the count at the lower-right of the 70x70 bar
        // cell. Enlarge the small digit before PaddleOCR sees it.
        var sx = Math.Clamp((int)Math.Round(source.Width * .375), 0, source.Width - 1);
        var sy = Math.Clamp((int)Math.Round(source.Height * .945), 0, source.Height - 1);
        var sw = Math.Clamp((int)Math.Round(source.Width * .045), 1, source.Width - sx);
        var sh = Math.Clamp((int)Math.Round(source.Height * .055), 1, source.Height - sy);
        using var crop = source.Clone(new Rectangle(sx, sy, sw, sh), PixelFormat.Format24bppRgb);
        string? lastText = null;
        // The digit is only a few pixels high in a 1920x1080 frame.  Fourfold
        // nearest-neighbor enlargement can turn a 7 into a letter-like shape
        // for PaddleOCR; twofold preserves the original stroke better.  Keep
        // an eightfold retry for frames where the first pass has no digit.
        foreach (var scale in new[] { 2, 8 })
        {
            using var enlarged = new Bitmap(crop.Width * scale, crop.Height * scale, PixelFormat.Format24bppRgb);
            using (var graphics = Graphics.FromImage(enlarged))
            {
                graphics.InterpolationMode = InterpolationMode.NearestNeighbor;
                graphics.PixelOffsetMode = PixelOffsetMode.Half;
                graphics.DrawImage(crop, new Rectangle(0, 0, enlarged.Width, enlarged.Height));
            }
            var text = await ReadPaddleTextAsync(enlarged, token);
            lastText = text;
            if (MiningToolGuard.ParseQuantityText(text) is not null)
                return text;
        }
        return lastText ?? string.Empty;
    }

    public Task<IReadOnlyList<OcrWord>> ReadOcrWordsAsync(Bitmap image)
        => ReadOcrWordsAsync(image, default);

    public async Task<IReadOnlyList<OcrWord>> ReadOcrWordsAsync(
        Bitmap image,
        CancellationToken token)
    {
        var response = await paddleOcr.RecognizeAsync(image, token);
        return response.Words
            .Where(word => !string.IsNullOrWhiteSpace(word.Text) && word.Width > 0 && word.Height > 0)
            .Select(word => new OcrWord(word.Text.Trim(), word.Left, word.Top, word.Width, word.Height, word.Confidence))
            .ToArray();
    }

    public sealed record AssistantStatus(string Target, string CurrentHash, string PatchHash, bool Installed, bool BackupExists, string Format, bool TestPanelSupported);

    async Task<string> Run(params string[] args)
    {
        var psi = new ProcessStartInfo("adb") { RedirectStandardOutput = true, RedirectStandardError = true, UseShellExecute = false, CreateNoWindow = true };
        psi.ArgumentList.Add("-s"); psi.ArgumentList.Add(Serial);
        foreach (var arg in args) psi.ArgumentList.Add(arg);
        using var process = Process.Start(psi) ?? throw new InvalidOperationException("无法启动 adb");
        var stdout = process.StandardOutput.ReadToEndAsync();
        var stderr = process.StandardError.ReadToEndAsync();
        try
        {
            await process.WaitForExitAsync().WaitAsync(TimeSpan.FromMilliseconds(AdbCommandTimeoutMs));
        }
        catch (TimeoutException)
        {
            try { if (!process.HasExited) process.Kill(entireProcessTree: true); } catch { }
            throw new TimeoutException($"ADB 命令超时（>{AdbCommandTimeoutMs}ms）");
        }
        var error = await stderr;
        if (process.ExitCode != 0) throw new InvalidOperationException(error.Trim());
        return await stdout;
    }

    void EnsureRootShell()
    {
        if (rootShell is { HasExited: false }) return;
        DisposeRootShell();
        var psi = new ProcessStartInfo("adb") { RedirectStandardInput = true, RedirectStandardOutput = true, UseShellExecute = false, CreateNoWindow = true };
        psi.ArgumentList.Add("-s"); psi.ArgumentList.Add(Serial); psi.ArgumentList.Add("shell");
        if (!adbRunsAsRoot) { psi.ArgumentList.Add("su"); psi.ArgumentList.Add("0"); }
        psi.ArgumentList.Add("sh");
        rootShell = Process.Start(psi) ?? throw new InvalidOperationException("无法建立持续 Root ADB shell");
    }

    async Task<string> RunRoot(string command)
    {
        if (!await rootShellLock.WaitAsync(TimeSpan.FromMilliseconds(PersistentShellTimeoutMs)))
            throw new TimeoutException($"Root ADB 命令锁等待超时（>{PersistentShellTimeoutMs}ms）");
        try
        {
            EnsureRootShell();
            var marker = $"__CODEX_DONE_{Interlocked.Increment(ref rootCommandId)}__";
            await rootShell!.StandardInput.WriteLineAsync(command);
            await rootShell.StandardInput.WriteLineAsync($"__codex_status=$?; printf '\\n{marker}:%s\\n' \"$__codex_status\"");
            await rootShell.StandardInput.FlushAsync();
            var lines = new List<string>();
            while (true)
            {
                var line = await rootShell.StandardOutput.ReadLineAsync().WaitAsync(TimeSpan.FromMilliseconds(PersistentShellTimeoutMs))
                    ?? throw new IOException("持续 Root ADB shell 已断开");
                if (line.StartsWith(marker + ":", StringComparison.Ordinal))
                {
                    if (!line.EndsWith(":0", StringComparison.Ordinal)) throw new InvalidOperationException($"Root 命令失败（状态 {line[(marker.Length + 1)..]}）");
                    return string.Join('\n', lines);
                }
                lines.Add(line);
            }
        }
        catch { DisposeRootShell(); throw; }
        finally { rootShellLock.Release(); }
    }

    // 触摸边界使用的传输接缝。将 ADB 参数细节保留在此处，
    // 可以让后端启动器共享同一个选定设备，而不必向应用其余部分暴露 Shell 语法。
    internal Task<string> RunAdb(params string[] args) => Run(args);
    // 触控生命周期由 ConnectAsync 管理；这里仅验证连接状态，不能隐式启动后端。
    internal Task EnsureTouchReady()
    {
        RequireTouchReady();
        return Task.CompletedTask;
    }
    internal (int X, int Y) TouchPoint(Cell delta) => TouchCoordinateMapper.ToPixels(delta, screenWidth, screenHeight);
    internal Task SendTouchDown((int X, int Y) point)
        => touchBackend?.TouchDownAsync(point) ?? throw new InvalidOperationException("Android 触控后端尚未启动");
    internal Task SendTouchUp()
        => touchBackend?.TouchUpAsync() ?? Task.CompletedTask;
    internal Task SendTouchPulse((int X, int Y) point, int milliseconds)
        => touchBackend?.SwipeAsync(point, point, milliseconds)
            ?? throw new InvalidOperationException("Android 触控后端尚未启动");

    public async Task<List<string>> Devices()
    {
        var text = await Run("devices");
        return text.Split('\n').Skip(1).Select(x => x.Trim().Split('\t')).Where(x => x.Length == 2 && x[1] == "device").Select(x => x[0]).ToList();
    }

    public async Task<bool> EnableAdbRoot()
    {
        DisposeRootShell();
        try
        {
            await Run("root");
            await Run("wait-for-device");
            var identity = await Run("shell", "id");
            adbRunsAsRoot = identity.Contains("uid=0", StringComparison.Ordinal);
        }
        catch { adbRunsAsRoot = false; }
        return adbRunsAsRoot;
    }

    /// <summary>
    /// 建立一个设备会话。设备选择、Root 能力检查和触控后端启动都属于连接阶段，
    /// 普通操作不再隐式改变设备会话。
    /// </summary>
    public async Task<bool> ConnectAsync(string deviceSerial)
    {
        if (string.IsNullOrWhiteSpace(deviceSerial))
            throw new ArgumentException("设备序列号不能为空", nameof(deviceSerial));

        await deviceConnectionLock.WaitAsync();
        try
        {
            if (!string.Equals(Serial, deviceSerial, StringComparison.Ordinal))
                Serial = deviceSerial;
            if (IsTouchReady) return adbRunsAsRoot;

            var directRoot = await EnableAdbRoot();
            await InitializeTouchBackendAsync();
            return directRoot;
        }
        finally { deviceConnectionLock.Release(); }
    }

    /// <summary>
    /// 标记当前设备会话已失效。即使设备稍后以相同 Serial 重连，
    /// 也必须重新探测屏幕参数并启动新的触控后端。
    /// </summary>
    public void Disconnect()
    {
        ResetDeviceSession();
    }

    void ResetDeviceSession()
    {
        popupFrameCache.Clear();
        touchPayloadsReady = false;
        screenWidth = screenHeight = 0;
        touchOrientation = androidSdk = 0;
        touchBackendDescription = null;
        DisposeTouchBackend();
        adbRunsAsRoot = false;
        DisposeRootShell();
    }

    public async Task<MapDump> ReadMap()
    {
        var map = await ReadJson<MapDump>($"{Root}/codex_map_dump.json");
        for (var y = 0; y < map.Tiles.Count; y++)
        for (var x = 0; x < map.Tiles[y].Count; x++)
        {
            var tile = map.Tiles[y][x];
            if (tile.X == 0 && tile.Y == 0 && (x != 0 || y != 0)) { tile.X = x; tile.Y = y; }
        }
        // 只使用游戏导出的探索信号。服务器标记为已到达的格子，
        // 在规划时视为已探索；ISeeDeadPeople/allExplored 表示整张地图可见。
        map.ApplyGameExplorationState();
        return map;
    }

    public async Task<PlayerStatus> ReadPlayer()
    {
        return await ReadJson<PlayerStatus>($"{Root}/codex_player_status.json");
    }

    async Task<T> ReadJson<T>(string path)
    {
        const int maxAttempts = 20;
        JsonException? lastJsonError = null;
        for (var attempt = 0; attempt < maxAttempts; attempt++)
        {
            var json = await ReadAtomicJson(path);
            try
            {
                return JsonSerializer.Deserialize<T>(json, JsonOptions)
                    ?? throw new InvalidDataException($"设备端 JSON 为空：{path}");
            }
            catch (JsonException ex)
            {
                lastJsonError = ex;
                if (attempt + 1 < maxAttempts) await Task.Delay(5);
            }
        }
        var detail = lastJsonError is null ? "未知解析错误" : lastJsonError.Message;
        throw new InvalidDataException($"设备端 JSON 在重试后仍无法解析：{path}；最后错误：{detail}", lastJsonError);
    }

    async Task<string> ReadAtomicJson(string path)
    {
        // 通过持久 Shell 以 Base64 读取文件。这样可以使传输内容保持 ASCII，
        // 避免较大的单行 JSON 负载被误认为 Shell 输出或命令标记。
        const string notReady = "__CODEX_DATA_NOT_READY__";
        // 在完整重启游戏加载新安装的 Lua 辅助程序前，导出文件不存在是预期状态。
        // 保持 root 命令成功，并将该状态转换为控制器可以处理的消息。
        var result = await RunRoot($"i=0; ok=1; while [ $i -lt 20 ]; do if [ -f '{path}' ]; then if command -v base64 >/dev/null 2>&1; then base64 '{path}' 2>/dev/null; else cat '{path}' 2>/dev/null; fi; status=$?; else status=1; fi; if [ $status -eq 0 ]; then ok=0; break; fi; i=$((i+1)); sleep 0.005; done; if [ $ok -ne 0 ]; then printf '%s' '{notReady}'; fi");
        if (result.Trim() == notReady)
            throw new FileNotFoundException("助手地图数据尚未生成。若刚安装助手，请彻底结束并重新启动游戏，然后进入地图。");
        try
        {
            return Encoding.UTF8.GetString(Convert.FromBase64String(result));
        }
        catch (FormatException)
        {
            // 对没有可用 base64 命令的设备使用兼容性回退。
            return result;
        }
    }

    async Task InitializeTouchBackendAsync()
    {
        await touchPayloadLock.WaitAsync();
        try
        {
            var size = await Run("shell", "wm", "size");
            var matches = Regex.Matches(size, @"(?<width>\d+)x(?<height>\d+)");
            if (matches.Count == 0) throw new InvalidOperationException("无法读取设备屏幕尺寸");
            var selected = matches[^1];
            var a = int.Parse(selected.Groups["width"].Value);
            var b = int.Parse(selected.Groups["height"].Value);
            screenWidth = Math.Max(a, b); screenHeight = Math.Min(a, b);
            var sdkText = await Run("shell", "getprop", "ro.build.version.sdk");
            _ = int.TryParse(sdkText.Trim(), out androidSdk);
            var inputState = await Run("shell", "dumpsys", "input");
            var viewport = Regex.Match(inputState,
                @"Viewport: displayId=0, orientation=(?<orientation>[0-3]), logicalFrame=\[0, 0, (?<width>\d+), (?<height>\d+)\]");
            touchOrientation = viewport.Success &&
                int.Parse(viewport.Groups["width"].Value) == screenWidth &&
                int.Parse(viewport.Groups["height"].Value) == screenHeight
                    ? int.Parse(viewport.Groups["orientation"].Value) : 0;
            var backends = androidSdk >= 29
                ? new IAndroidTouchBackend[]
                {
                    new MaaTouchBackend(Serial, RunAdb),
                    new MinitouchBackend(Serial, RunAdb)
                }
                : new IAndroidTouchBackend[]
                {
                    new MinitouchBackend(Serial, RunAdb),
                    new MaaTouchBackend(Serial, RunAdb)
                };
            var failures = new List<Exception>();
            foreach (var backend in backends)
            {
                try
                {
                    var info = await backend.StartAsync(screenWidth, screenHeight, touchOrientation);
                    touchBackend = backend;
                    touchBackendDescription = $"{info.Name} ({screenWidth}x{screenHeight}, Android API {androidSdk})";
                    touchPayloadsReady = true;
                    return;
                }
                catch (Exception ex)
                {
                    failures.Add(new InvalidOperationException($"{backend.Name}: {ex.Message}", ex));
                    backend.Dispose();
                }
            }
            throw new InvalidOperationException(
                $"无法启动 Android 触控后端（API {androidSdk}）。" + Environment.NewLine +
                string.Join(Environment.NewLine, failures.Select(x => x.Message)), failures.FirstOrDefault());
        }
        finally { touchPayloadLock.Release(); }
    }

    void RequireTouchReady()
    {
        if (!IsTouchReady)
            throw new InvalidOperationException("当前设备尚未连接或触控后端尚未启动");
    }

    public async Task TapScreen(double normalizedX, double normalizedY)
    {
        RequireTouchReady();
        var x = Math.Clamp((int)Math.Round(normalizedX * screenWidth), 0, screenWidth - 1);
        var y = Math.Clamp((int)Math.Round(normalizedY * screenHeight), 0, screenHeight - 1);
        await (touchBackend?.TapAsync((x, y))
            ?? throw new InvalidOperationException("Android 触控后端尚未启动"));
    }

    public Task PressBack()
        => Run("shell", "input", "keyevent", "4");

    /// <summary>
    /// 点击原始辅助程序 720x1280 竖屏坐标空间中的坐标。
    /// Android 以横屏显示游戏，因此在最后一刻转换坐标，
    /// 而不是将设备分辨率固化到入口选择器中。
    /// </summary>
    public async Task TapGameCoordinate(int x, int y)
    {
        RequireTouchReady();
        var point = GameScreenCoordinates.ToDisplay(x, y, screenWidth, screenHeight);
        await (touchBackend?.TapAsync((point.X, point.Y))
            ?? throw new InvalidOperationException("Android 触控后端尚未启动"));
    }

    public async Task SwipeScreen(double normalizedX0, double normalizedY0,
        double normalizedX1, double normalizedY1, int durationMs)
    {
        RequireTouchReady();
        var x0 = Math.Clamp((int)Math.Round(normalizedX0 * screenWidth), 0, screenWidth - 1);
        var y0 = Math.Clamp((int)Math.Round(normalizedY0 * screenHeight), 0, screenHeight - 1);
        var x1 = Math.Clamp((int)Math.Round(normalizedX1 * screenWidth), 0, screenWidth - 1);
        var y1 = Math.Clamp((int)Math.Round(normalizedY1 * screenHeight), 0, screenHeight - 1);
        await (touchBackend?.SwipeAsync((x0, y0), (x1, y1), durationMs)
            ?? throw new InvalidOperationException("Android 触控后端尚未启动"));
    }

    public async Task<Bitmap> CaptureScreenForAutomationAsync()
        => await CaptureScreenAsync("无法截取设备屏幕");

    public async Task<bool> HasNextFloorButton()
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕");
        // 场景稳定期间按钮会变暗；使用观察到的棕/金色调，而不只依赖亮色像素。
        return OpenCvPopupColorAnalysis.Ratio(bitmap, (.78, .985, .45, .57),
            PopupColorKind.GoldButton) > .30;
    }

    /// <summary>
    /// 检测居中的“服务器连接异常，即将退出，请重新进入游戏”模态框。
    /// 即使下方的宝石/传送门画面变暗，其浅色中央面板和绿色确认按钮仍保持稳定。
    /// 该覆盖层会消耗所有触摸输入，因此控制器必须停止，
    /// 不能继续在其下方发送移动或宝石选择点击。
    /// </summary>
    public async Task<bool> HasServerErrorDialog()
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕");
        return await HasServerErrorDialog(bitmap);
    }

    internal async Task<bool> HasServerErrorDialog(Bitmap bitmap)
    {
        if (!LooksLikeServerErrorCandidate(bitmap)) return false;
        // 颜色只是一种低成本候选过滤条件。普通地下城楼层在这些区域也可能同时
        // 存在大面积浅色区域和绿色传送门；把这种配色当作确定依据，
        // 会让控制器在没有对话框时停止。模态框文字才是权威信号，
        // 因此候选结果还必须通过 OCR。
        var text = await ReadScreenTextAsync(bitmap, (.25, .75, .24, .74), "服务器异常弹窗");
        return IsServerErrorText(text);
    }

    internal Task<bool> HasServerErrorDialog(Bitmap bitmap, string? ocrText)
    {
        if (!LooksLikeServerErrorCandidate(bitmap)) return Task.FromResult(false);
        return Task.FromResult(IsServerErrorText(ocrText));
    }

    static bool LooksLikeServerErrorCandidate(Bitmap source)
    {
        var panel = OpenCvPopupColorAnalysis.Ratio(source, (.30, .70, .28, .72),
            PopupColorKind.LightNeutralPanel);
        var confirm = OpenCvPopupColorAnalysis.Ratio(source, (.43, .57, .59, .70),
            PopupColorKind.GreenButton);
        return panel >= .45 && confirm >= .20;
    }

    internal static bool IsServerErrorText(string? text)
    {
        if (string.IsNullOrWhiteSpace(text)) return false;
        var normalized = Regex.Replace(text, @"[^\p{L}\p{N}]", "");
        return normalized.Contains("服务器连接异常", StringComparison.Ordinal) ||
            (normalized.Contains("连接异常", StringComparison.Ordinal) &&
             normalized.Contains("重新进入游戏", StringComparison.Ordinal));
    }

    async Task<string?> ReadScreenTextAsync(
        Bitmap source,
        (double X0, double X1, double Y0, double Y1) region,
        string description,
        CancellationToken token = default)
    {
        // OCR 直接调用主进程中的 PaddleOCR SDK；将源图像保留在内存中。
        var sx = Math.Clamp((int)(source.Width * region.X0), 0, source.Width - 1);
        var sy = Math.Clamp((int)(source.Height * region.Y0), 0, source.Height - 1);
        var sw = Math.Clamp((int)(source.Width * (region.X1 - region.X0)), 1, source.Width - sx);
        var sh = Math.Clamp((int)(source.Height * (region.Y1 - region.Y0)), 1, source.Height - sy);
        using var screenCrop = source.Clone(new Rectangle(sx, sy, sw, sh), PixelFormat.Format24bppRgb);
        return await ReadPaddleTextAsync(screenCrop, token);
    }

    public async Task<bool> HasLootConfirmButton()
    {
        using var bitmap = await CaptureScreenAsync("无法截图设备屏幕");
        return LooksLikeLootConfirmButton(bitmap);
    }

    internal static bool LooksLikeLootConfirmButton(Bitmap source)
        => OpenCvPopupColorAnalysis.Ratio(source, (.38, .62, .84, .96),
            PopupColorKind.GoldButton) > .35;

    public async Task<bool> HasEnterNextFloorConfirm()
    {
        // 神秘商人/特殊地图的“是否进入下一层？”确认框右侧按钮为绿色。
        using var bitmap = await CaptureScreenAsync("无法截图设备屏幕");
        return OpenCvPopupColorAnalysis.Ratio(bitmap, (.52, .68, .56, .72),
            PopupColorKind.GreenButton) > .15;
    }

    /// <summary>
    /// 仅通过顶部标题“贪婪抉择”检测下一层三选一覆盖层。
    /// 不使用卡片或按钮颜色，避免普通地图/战斗画面误判。
    /// </summary>
    public async Task<bool> HasNextFloorBonusSelection()
    {
        using var bitmap = await CaptureScreenAsync("无法截图设备屏幕");
        var title = await ReadPopupTitleTextAsync(bitmap);
        return PopupRecognition.IsGreedySelectionTitle(title);
    }

    /// <summary>
    /// 从一张截图中识别三种下一层覆盖层，顺序与游戏流程一致：贪婪三选一、
    /// 预警确认，以及不带红色警告文字的普通确认变体。
    /// </summary>
    public async Task<NextFloorDialogKind> DetectNextFloorDialog()
    {
        using var bitmap = await CaptureScreenAsync("无法截图设备屏幕");
        var title = await ReadPopupTitleTextAsync(bitmap);
        var body = await ReadScreenTextAsync(bitmap, (.20, .80, .20, .70), "换层弹窗");
        return DetectNextFloorDialog(bitmap, title, body);
    }

    internal Task<NextFloorDialogKind> DetectNextFloorDialog(Bitmap bitmap)
        => DetectNextFloorDialog(bitmap, CancellationToken.None);

    internal async Task<NextFloorDialogKind> DetectNextFloorDialog(
        Bitmap bitmap,
        CancellationToken token)
        => await DetectNextFloorDialog(bitmap, token, null);

    internal async Task<NextFloorDialogKind> DetectNextFloorDialog(
        Bitmap bitmap,
        CancellationToken token,
        Action<string?>? bodyObserved)
    {
        var title = await ReadPopupTitleTextAsync(bitmap, token);
        var body = await ReadScreenTextAsync(bitmap, (.20, .80, .20, .70), "换层弹窗", token);
        bodyObserved?.Invoke(body);
        return DetectNextFloorDialog(bitmap, title, body);
    }

    internal NextFloorDialogKind DetectNextFloorDialog(Bitmap bitmap, string? ocrText)
    {
        return DetectNextFloorDialog(bitmap, ocrText, ocrText);
    }

    internal NextFloorDialogKind DetectNextFloorDialog(
        Bitmap bitmap,
        string? titleText,
        string? bodyText)
    {
        LastNextFloorDialogKind = PopupRecognition.ClassifyNextFloorDialog(bitmap, titleText, bodyText);
        return LastNextFloorDialogKind;
    }

    NextFloorDialogKind ClassifyNextFloorDialog(Bitmap bitmap, string? ocrText)
    {
        LastNextFloorDialogKind = PopupRecognition.ClassifyNextFloorDialog(bitmap, ocrText);
        return LastNextFloorDialogKind;
    }

    internal Task<string?> ReadPopupTitleTextAsync(Bitmap frame, CancellationToken token = default)
        => ReadScreenTextAsync(frame, (.35, .65, .03, .18), "贪婪抉择标题", token);

    /// <summary>
    /// 通过 OCR 匹配标题检测秘境宝石选择覆盖层。
    /// 特意不使用卡片图案和按钮颜色。
    /// </summary>
    public async Task<bool> HasRiftGemSelection()
    {
        using var bitmap = await CaptureScreenAsync("无法截取设备屏幕");
        return await HasRiftGemSelection(bitmap);
    }

    internal async Task<bool> HasRiftGemSelection(Bitmap bitmap)
    {
        LastRiftGemTitle = null;
        GemTitleDetectionMode = "PaddleOCR";
        // 标题是该覆盖层的权威语义条件；不要用卡片颜色或按钮布局提前否决它。
        var title = await ReadGemTitleAsync(bitmap);
        return HasRiftGemSelectionText(title);
    }

    internal bool HasRiftGemSelectionText(string? title)
    {
        GemTitleDetectionMode = "PaddleOCR";
        LastRiftGemTitle = title;
        return !string.IsNullOrWhiteSpace(title) && IsRiftGemTitle(title);
    }

    /// <summary>
    /// 获取一张串行化截图，只执行可能打断移动的弹窗检查。
    /// 看门狗使用这个单帧探测，使缓慢的 OCR 检查不会与另一张完整截图竞争，
    /// 并确保所有检测器描述的是同一个视觉时刻。
    /// </summary>
    internal async Task<PopupUiPipelineResult> ProbeMovementPopupAsync(CancellationToken token = default)
    {
        var frameId = NextPopupFrameId();
        using var bitmap = await CaptureMovementPopupFrameAsync(frameId, token);
        return await RunPopupUiPipelineAsync(bitmap, frameId, token);
    }

    /// <summary>
    /// 为一次弹窗检测循环生成逻辑帧号。
    /// 这不是固定频率采样，而是调用方开始一次检测时显式推进的编号。
    /// </summary>
    internal long NextPopupFrameId()
        => Interlocked.Increment(ref popupFrameSequence);

    /// <summary>
    /// 在调用方已经捕获的同一帧上运行统一弹窗 UI Pipeline。
    /// 启动检查和移动 watchdog 都必须通过这里识别，避免同一弹窗分叉到两套规则。
    /// </summary>
    internal async Task<PopupUiPipelineResult> RunPopupUiPipelineAsync(
        Bitmap frame, CancellationToken token = default)
    {
        NextFloorDialogKind nextFloorDialog = NextFloorDialogKind.None;
        string? fullFrameText = null;
        string? nextFloorDialogBody = null;
        var pipeline = await PopupUiPipeline.Create(this,
                fullFrameTextObserved: text => fullFrameText = text,
                nextFloorDialogDetected: (kind, body) =>
                {
                    nextFloorDialog = kind;
                    nextFloorDialogBody = body;
                })
            .RunAsync(frame, token);
        return new PopupUiPipelineResult(pipeline, nextFloorDialog, fullFrameText, nextFloorDialogBody,
            nextFloorDialog == NextFloorDialogKind.GreedySelection &&
            PopupRecognition.IsGreedySelectionReturnOnly(nextFloorDialogBody));
    }

    internal async Task<PopupUiPipelineResult> RunPopupUiPipelineAsync(
        Bitmap frame, long frameId, CancellationToken token = default)
    {
        NextFloorDialogKind nextFloorDialog = NextFloorDialogKind.None;
        string? fullFrameText = null;
        string? nextFloorDialogBody = null;
        var pipeline = await PopupUiPipeline.Create(this,
                fullFrameTextObserved: text => fullFrameText = text,
                nextFloorDialogDetected: (kind, body) =>
                {
                    nextFloorDialog = kind;
                    nextFloorDialogBody = body;
                })
            .RunAsync(frame, frameId, token);
        return new PopupUiPipelineResult(pipeline, nextFloorDialog, fullFrameText, nextFloorDialogBody,
            nextFloorDialog == NextFloorDialogKind.GreedySelection &&
            PopupRecognition.IsGreedySelectionReturnOnly(nextFloorDialogBody));
    }

    internal async Task<string> ReadPopupFrameTextAsync(Bitmap frame, CancellationToken token = default)
    {
        token.ThrowIfCancellationRequested();
        var text = await ReadPaddleTextAsync(frame, token);
        token.ThrowIfCancellationRequested();
        return text;
    }

    /// <summary>
    /// 捕获移动弹窗管线使用的一帧画面。
    /// 将其独立出来，可以让 PopupWatchdog 复用管线实例，同时由截图锁将设备截图
    /// 与常规刷新串行化。
    /// </summary>
    internal async Task<Bitmap> CaptureMovementPopupFrameAsync(CancellationToken token)
    {
        return await CaptureMovementPopupFrameAsync(NextPopupFrameId(), token);
    }

    /// <summary>
    /// 获取指定逻辑帧的弹窗检测截图。
    /// 同一 FrameId 的重复或并发请求共享一次真实 ADB 截图；下一轮检测必须传入新编号。
    /// </summary>
    internal Task<Bitmap> CaptureMovementPopupFrameAsync(long frameId, CancellationToken token)
        => popupFrameCache.GetAsync(
            frameId,
            captureToken => CaptureScreenAsync("无法截取设备屏幕", captureToken),
            token);

    /// <summary>在三卡宝石选择覆盖层中随机点击一张卡片。</summary>
    public async Task<int> TapRandomRiftGemCard()
    {
        RequireTouchReady();
        var index = Random.Shared.Next(3);
        await TapRiftGemCard(index);
        return index + 1;
    }

    /// <summary>
    /// 使用稳定的“选择”按钮中心点击指定卡片。
    /// 保留索引后，点击失败时可以重试，而不会在每次轮询时选择不同的奖励。
    /// </summary>
    public async Task TapRiftGemCard(int index)
    {
        RequireTouchReady();
        index = Math.Clamp(index, 0, 2);
        var x = index switch { 0 => .268, 1 => .466, _ => .661 };
        await TapScreen(x, .648);
    }

    internal static bool IsRiftGemTitle(string text)
        => GemTitleMatcher.IsSelectionTitle(text);

    async Task<string?> ReadGemTitleAsync(Bitmap source)
    {
        return await ReadGemTitlePassAsync(source);
    }

    async Task<string?> ReadGemTitlePassAsync(Bitmap source)
    {
        // PaddleOCR 的检测器需要标题周围的版式上下文。实测完整 1920x1080
        // 截图能识别“原初试炼宝石”，而只保留中间 20% x 顶部 12% 的裁剪图
        // 只返回乱码。因此这里保留原始整帧，让标题匹配负责语义判断。
        return await ReadPaddleTextAsync(source);
    }

    async Task<Bitmap> CaptureScreenAsync(string errorMessage, CancellationToken token = default)
    {
        await screenCaptureLock.WaitAsync(token);
        try
        {
            var psi = new ProcessStartInfo("adb")
            {
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
                CreateNoWindow = true,
                ErrorDialog = false
            };
            psi.ArgumentList.Add("-s"); psi.ArgumentList.Add(Serial);
            psi.ArgumentList.Add("exec-out"); psi.ArgumentList.Add("screencap"); psi.ArgumentList.Add("-p");
            using var process = Process.Start(psi) ?? throw new InvalidOperationException(errorMessage);
            using var data = new MemoryStream();
            var copyTask = process.StandardOutput.BaseStream.CopyToAsync(data, token);
            var errorTask = process.StandardError.ReadToEndAsync(token);
            try
            {
                await process.WaitForExitAsync(token).WaitAsync(TimeSpan.FromMilliseconds(ScreenCaptureTimeoutMs), token);
                await copyTask.WaitAsync(TimeSpan.FromMilliseconds(ScreenCaptureTimeoutMs), token);
            }
            catch (TimeoutException)
            {
                try { if (!process.HasExited) process.Kill(entireProcessTree: true); } catch { }
                throw new TimeoutException($"ADB 截图超时（>{ScreenCaptureTimeoutMs}ms），已终止卡住的 adb 进程");
            }
            catch (OperationCanceledException)
            {
                try { if (!process.HasExited) process.Kill(entireProcessTree: true); } catch { }
                throw;
            }
            var error = (await errorTask).Trim();
            if (process.ExitCode != 0)
                throw new InvalidOperationException(string.IsNullOrWhiteSpace(error) ? errorMessage : $"{errorMessage}：{error}");
            if (data.Length == 0) throw new InvalidDataException($"{errorMessage}：ADB 返回了空截图");
            data.Position = 0;
            using var captured = new Bitmap(data);
            return new Bitmap(captured);
        }
        finally { screenCaptureLock.Release(); }
    }

    async Task<string> FindAssistantTarget()
    {
        var expected = $"{Root}/Hotfix/src/app/ui/minimap/MiniMapDrawer.luac";
        // 在 LDPlayer 9 上，find|head 管线可能返回 find 的 SIGPIPE 状态，
        // 而不是 head 的成功状态。优先使用稳定的热更新位置，
        // 仅在位置不同时使用不带管道的回退搜索。
        var output = await RunRoot($"if [ -f '{expected}' ]; then printf '%s\\n' '{expected}'; else find '{Root}' -type f -name 'MiniMapDrawer.luac' -print; fi");
        var path = output.Split(['\r', '\n'], StringSplitOptions.RemoveEmptyEntries).FirstOrDefault()?.Trim() ?? "";
        if (string.IsNullOrWhiteSpace(path)) throw new FileNotFoundException("设备中未找到 MiniMapDrawer.luac，请先启动游戏并完成资源更新");
        return path;
    }

    static string Sha256(string path)
    {
        using var stream = File.OpenRead(path);
        return Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(stream)).ToLowerInvariant();
    }

    static string Sha256(byte[] bytes)
        => Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(bytes)).ToLowerInvariant();

    async Task<byte[]> ReadRootBinary(string path)
    {
        var token = Guid.NewGuid().ToString("N");
        var remote = $"/data/local/tmp/codex_read_{token}.luac";
        var local = Path.Combine(Path.GetTempPath(), $"codex-read-{token}.luac");
        try
        {
            await RunRoot($"set -e; cp '{path}' '{remote}'; chmod 644 '{remote}'");
            await Run("pull", remote, local);
            return await File.ReadAllBytesAsync(local);
        }
        finally
        {
            try { await RunRoot($"rm -f '{remote}'"); } catch { }
            try { File.Delete(local); } catch { }
        }
    }

    async Task WriteRootBinary(string path, byte[] bytes)
    {
        var token = Guid.NewGuid().ToString("N");
        var remote = $"/data/local/tmp/codex_write_{token}.luac";
        var local = Path.Combine(Path.GetTempPath(), $"codex-write-{token}.luac");
        try
        {
            await File.WriteAllBytesAsync(local, bytes);
            await Run("push", local, remote);
            // 通过现有 inode 写入，以保留应用文件现有的所有者/标签。
            // 安装前应停止游戏；此操作完成后由 UI 请求重启。
            await RunRoot($"set -e; cat '{remote}' > '{path}'; chmod 600 '{path}'");
        }
        finally
        {
            try { await RunRoot($"rm -f '{remote}'"); } catch { }
            try { File.Delete(local); } catch { }
        }
    }

    async Task<bool> RemoteFileExists(string path)
    {
        return (await RunRoot($"if [ -f '{path}' ]; then echo yes; else echo no; fi")).Trim() == "yes";
    }

    public async Task<AssistantStatus> GetAssistantStatus(string templateFile)
    {
        var target = await FindAssistantTarget();
        var currentBytes = await ReadRootBinary(target);
        var current = Sha256(currentBytes);
        var backup = await RemoteFileExists(target + ".codex_original.bak");
        var sourceAvailable = LuaAssistantPatcher.TryDecodeSource(currentBytes, out var source, out var format);
        var installed = sourceAvailable && LuaAssistantPatcher.IsPatchedSource(source);
        var testPanelSupported = sourceAvailable && LuaAssistantPatcher.SupportsTestPanelCommand(source);
        var templateHash = File.Exists(templateFile) ? Sha256(await File.ReadAllBytesAsync(templateFile)) : "";
        return new(target, current, templateHash, installed, backup, format, testPanelSupported);
    }

    public async Task RequestOpenTestPanel()
    {
        await RunRoot($"set -e; rm -f '{TestPanelCommandPath}' '{TestPanelCommandPath}.processing' '{TestPanelResultPath}'; printf '%s' 'open_test_panel' > '{TestPanelCommandTempPath}'; mv -f '{TestPanelCommandTempPath}' '{TestPanelCommandPath}'");
    }

    public async Task<AssistantStatus> InstallAssistant(string templateFile)
    {
        if (!File.Exists(templateFile))
            throw new FileNotFoundException("地图助手模板缺失，请重新发布或修复程序安装目录", templateFile);
        var target = await FindAssistantTarget();
        var currentBytes = await ReadRootBinary(target);
        var hasBackup = await RemoteFileExists(target + ".codex_original.bak");
        var currentIsSource = LuaAssistantPatcher.TryDecodeSource(currentBytes, out var currentSource, out var currentFormat);
        var currentIsPatched = currentIsSource && LuaAssistantPatcher.IsPatchedSource(currentSource);
        var baseBytes = currentBytes;
        var refreshBackup = false;

        if (currentIsPatched || currentSource.Contains("codexExportCurrentMap", StringComparison.Ordinal))
        {
            if (!hasBackup) throw new InvalidOperationException("设备上已有旧版地图助手，但没有原版备份，未覆盖游戏文件");
            baseBytes = await ReadRootBinary(target + ".codex_original.bak");
        }
        else if (currentIsSource)
        {
            // 上次安装后，游戏可能下载了更新版本的 MiniMapDrawer。
            // 使用这个确切版本刷新备份。
            refreshBackup = true;
        }
        else if (hasBackup)
        {
            // 仅当旧版字节码补丁的原始备份可以解码为源码时，才从该补丁恢复。
            baseBytes = await ReadRootBinary(target + ".codex_original.bak");
        }
        else
        {
            throw new InvalidDataException($"设备脚本解密后不是 Lua 源码（{currentFormat}），且没有可恢复的原版备份");
        }

        var template = await File.ReadAllTextAsync(templateFile, Encoding.UTF8);
        var patched = LuaAssistantPatcher.BuildEncryptedPatch(baseBytes, template);
        await WriteRootBinary("/data/local/tmp/codex_minimap_patch.luac", patched);
        try
        {
            // WriteRootBinary 使用绝对路径；通过持久 root Shell 将暂存文件移入目标位置，
            // 并保留权限。
            await RunRoot($"set -e; if [ '{(refreshBackup ? "yes" : "no")}' = 'yes' ]; then cp -p '{target}' '{target}.codex_original.bak'; fi; cat '/data/local/tmp/codex_minimap_patch.luac' > '{target}'; chmod 600 '{target}'; rm -f '/data/local/tmp/codex_minimap_patch.luac'");
        }
        finally
        {
            try { await RunRoot("rm -f '/data/local/tmp/codex_minimap_patch.luac'"); } catch { }
        }
        var result = await GetAssistantStatus(templateFile);
        if (!result.Installed) throw new IOException($"写入后未检测到源码注入标记（载荷格式：{result.Format}）");
        return result;
    }

    public async Task<AssistantStatus> RestoreAssistant(string templateFile)
    {
        var target = await FindAssistantTarget();
        var backupPath = target + ".codex_original.bak";
        if (!await RemoteFileExists(backupPath)) throw new FileNotFoundException("设备端没有原版备份，未执行恢复");
        var backupBytes = await ReadRootBinary(backupPath);
        if (!LuaAssistantPatcher.TryDecodeSource(backupBytes, out _, out var format))
            throw new InvalidDataException($"设备端备份不是 Lua 源码（{format}），未执行恢复");
        await WriteRootBinary(target, backupBytes);
        return await GetAssistantStatus(templateFile);
    }

    void DisposeRootShell()
    {
        var process = rootShell; rootShell = null;
        if (process is null) return;
        try { if (!process.HasExited) process.Kill(true); } catch { }
        process.Dispose();
    }

    void DisposeTouchBackend()
    {
        var backend = touchBackend;
        touchBackend = null;
        touchBackendDescription = null;
        try { backend?.Dispose(); } catch { }
    }

    public void Dispose() { popupFrameCache.Dispose(); paddleOcr.Dispose(); DisposeTouchBackend(); DisposeRootShell(); deviceConnectionLock.Dispose(); rootShellLock.Dispose(); touchPayloadLock.Dispose(); screenCaptureLock.Dispose(); }
}
