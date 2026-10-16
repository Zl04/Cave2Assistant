using System.Drawing;
using System.Drawing.Imaging;
using System.Text.Json;
using OpenCvSharp;
using CvPoint = OpenCvSharp.Point;
using DrawingPoint = System.Drawing.Point;

namespace AdbMapController;

public interface IEquipmentSaleDevice
{
    Task<Bitmap> CaptureAsync(CancellationToken token);
    Task<IReadOnlyList<OcrWord>> ReadWordsAsync(Bitmap frame, CancellationToken token);
    Task TapAsync(double x, double y);
    Task SwipeAsync(double x, double y, double endX, double endY, int durationMs);
}

sealed class AdbEquipmentSaleDevice(AdbClient adb) : IEquipmentSaleDevice
{
    public Task<Bitmap> CaptureAsync(CancellationToken token) => adb.CaptureScreenForAutomationAsync(token);
    public Task<IReadOnlyList<OcrWord>> ReadWordsAsync(Bitmap frame, CancellationToken token) => adb.ReadOcrWordsAsync(frame, token);
    public Task TapAsync(double x, double y) => adb.TapScreen(x, y);
    public Task SwipeAsync(double x, double y, double endX, double endY, int durationMs) => adb.SwipeScreen(x, y, endX, endY, durationMs);
}

public sealed record EquipmentSaleOptions(bool BlueWhite, bool Purple, bool DarkGold, bool Gold)
{
    public bool HasSelective => Purple || DarkGold || Gold;
    public bool Allows(SaleQuality quality) => quality switch
    { SaleQuality.Purple => Purple, SaleQuality.DarkGold => DarkGold, SaleQuality.Gold => Gold, _ => false };
}

public sealed class EquipmentSalePipeline : IMaaPipelineHandler<EquipmentSalePipeline>
{
    readonly IEquipmentSaleDevice device;
    readonly EquipmentSaleOptions options;
    readonly string root;
    readonly Action<string> log;
    readonly MaaPipelineCatalog catalog;
    int selected;
    SaleGrid? grid;
    bool end;
    string? lastPage;
    int stalled;
    int scans;
    readonly int scrollDistance, scrollDuration, settleDelay, maxPages;
    readonly int scrollGapColumn;
    readonly int stateRefreshRetries;
    readonly EquipmentSaleVisionSettings visionSettings;
    readonly int checkTimeoutMs, checkIntervalMs;
    readonly SelectedCheckMatcher checkMatcher;
    public string Name => "EquipmentSale";

    public EquipmentSalePipeline(AdbClient adb, EquipmentSaleOptions options, string root, string configuration, Action<string> log)
        : this(new AdbEquipmentSaleDevice(adb), options, root, configuration, log) { }

    public EquipmentSalePipeline(IEquipmentSaleDevice device, EquipmentSaleOptions options, string root, string configuration, Action<string> log)
    {
        this.device = device; this.options = options; this.root = root; this.log = log;
        catalog = MaaPipelineCatalogLoader.Load(configuration);
        using var json = JsonDocument.Parse(File.ReadAllText(configuration));
        var settings = json.RootElement.GetProperty("$settings");
        visionSettings = settings.TryGetProperty("vision", out var vision)
            ? vision.Deserialize<EquipmentSaleVisionSettings>(new JsonSerializerOptions { PropertyNameCaseInsensitive = true }) ?? new()
            : new();
        visionSettings.Validate();
        visionSettings.SelectedCheckTemplate = Path.GetFullPath(Path.Combine(root, visionSettings.SelectedCheckTemplate));
        checkMatcher = SelectedCheckMatcher.Load(visionSettings.SelectedCheckTemplate);
        checkTimeoutMs = settings.TryGetProperty("checkTimeoutMs", out var checkTimeout) ? checkTimeout.GetInt32() : 2000;
        checkIntervalMs = settings.TryGetProperty("checkIntervalMs", out var checkInterval) ? checkInterval.GetInt32() : 150;
        if (checkTimeoutMs is < 300 or > 10000 || checkIntervalMs is < 50 or > 500 || checkIntervalMs >= checkTimeoutMs)
            throw new InvalidDataException("勾选确认等待配置无效");
        scrollDistance = settings.GetProperty("scrollDistance").GetInt32();
        scrollDuration = settings.GetProperty("scrollDurationMs").GetInt32();
        settleDelay = settings.GetProperty("settleDelayMs").GetInt32();
        maxPages = settings.GetProperty("maxPages").GetInt32();
        stateRefreshRetries = settings.TryGetProperty("stateRefreshRetries", out var refreshRetries) ? refreshRetries.GetInt32() : 3;
        if (stateRefreshRetries is < 1 or > 8) throw new InvalidDataException("装备状态刷新次数必须在 1 至 8 之间");
        scrollGapColumn = settings.TryGetProperty("scrollGapColumn", out var gapColumn) ? gapColumn.GetInt32() : 2;
        if (scrollGapColumn is < 1 or > 4) throw new InvalidDataException("慢拖列间隙配置必须在 1 至 4 之间");
        if (scrollDistance is < 8 or > 180 || scrollDuration is < 600 or > 5000 || settleDelay is < 200 or > 5000 || maxPages is < 1 or > 1000)
            throw new InvalidDataException("出售 Pipeline 的慢拖或页面上限配置无效");
    }

    public async Task<MaaPipelineExecutionResult> RunAsync(CancellationToken token, IMaaPipelineTraceSink? trace = null)
    {
        var result = await new MaaPipeline<EquipmentSalePipeline>(catalog, [this],
            new MaaPipelineExecutionOptions { TaskChain = "EquipmentSale", RetryTimes = 0, MaxTransitions = maxPages * 4 + 40 }, trace)
            .RunAsync(this, ["Prepare"], token);
        if (result.Succeeded || token.IsCancellationRequested) return result;
        log("出售失败善后：识图返回并关闭背包");
        using var cleanupTimeout = new CancellationTokenSource(TimeSpan.FromSeconds(20));
        try
        {
            var cleanup = await new MaaPipeline<EquipmentSalePipeline>(catalog, [this],
                new MaaPipelineExecutionOptions { TaskChain = "EquipmentSaleCleanup", RetryTimes = 0, MaxTransitions = 30 }, trace)
                .RunAsync(this, ["Cleanup"], cleanupTimeout.Token);
            log(cleanup.Succeeded ? "出售失败善后：背包已关闭" : $"出售失败善后：背包关闭未确认，{cleanup.Error}");
            return cleanup.Succeeded ? result : result with { Error = $"{result.Error}；善后关闭未确认：{cleanup.Error}" };
        }
        catch (Exception ex) { log($"出售失败善后：{ex.Message}"); return result with { Error = $"{result.Error}；善后关闭失败：{ex.Message}" }; }
    }

    async Task<Bitmap> Capture(CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        using var source = await device.CaptureAsync(token);
        token.ThrowIfCancellationRequested();
        return EquipmentSaleVision.Normalize(source);
    }

    public async Task<MaaPipelineRecognitionResult> RecognizeAsync(MaaPipelineTask task,
        MaaPipelineTaskContext<EquipmentSalePipeline> context, CancellationToken token)
    {
        if (task.Name is "Prepare" or "FailClose" or "Cleanup") return MaaPipelineRecognitionResult.Hit();
        if (task.Name == "SkipBlueWhite") return options.BlueWhite
            ? await OptionalQuickAbsent(context, token) : MaaPipelineRecognitionResult.Hit(detail: "蓝白出售已关闭");
        if (task.Name == "SkipSelective") return options.HasSelective ? MaaPipelineRecognitionResult.Miss() : MaaPipelineRecognitionResult.Hit();
        if (task.Name == "SelectedSubmit" && selected == 0 || task.Name == "EmptySelectionExit" && selected != 0)
            return MaaPipelineRecognitionResult.Miss();
        if (task.Name == "Scroll") return !end ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss();
        if (task.Name == "Scan") return MaaPipelineRecognitionResult.Hit();
        using var frame = await Capture(token);
        var evidencePath = PipelineEvidenceStore.Save(frame, context.RunId, context.TaskId, log);
        if (task.Name is "InventoryOpen" or "InventoryReady" or "InventoryClosed")
        {
            var result = task.Name == "InventoryClosed"
                ? RecognizeInventoryClosed(frame)
                : await RecognizeInventory(frame, token);
            return result with { EvidencePath = evidencePath };
        }
        if (task.Name == "BlueWhiteDialog")
        {
            using var crop = frame.Clone(new Rectangle(338, 187, 325, 110), PixelFormat.Format24bppRgb);
            var words = await device.ReadWordsAsync(crop, token);
            var text = OcrTextLocator.Compact(string.Concat(words.Select(w => w.Text)));
            return (text.Contains("出售所有蓝色") && text.Contains("白色装备")
                ? MaaPipelineRecognitionResult.Hit(text: text) : MaaPipelineRecognitionResult.Miss(text))
                with { EvidencePath = evidencePath };
        }
        if (task.Name == "BlueWhite") return (options.BlueWhite ? MatchQuickButton(frame) : MaaPipelineRecognitionResult.Miss()) with { EvidencePath = evidencePath };
        if (task.Name is "SelectedSubmit" or "EmptySelectionExit" && !end) return MaaPipelineRecognitionResult.Miss(evidencePath: evidencePath);
        return Match(frame, task) with { EvidencePath = evidencePath };
    }

    async Task<MaaPipelineRecognitionResult> OptionalQuickAbsent(MaaPipelineTaskContext<EquipmentSalePipeline> context, CancellationToken token)
    {
        using var frame = await Capture(token);
        var evidencePath = PipelineEvidenceStore.Save(frame, context.RunId, context.TaskId, log);
        // 仅在装备页仍有效时允许跳过，不能把识别到弹窗/丢失界面当作按钮不存在。
        return (Match(frame, catalog.Get("EquipmentActive")).Matched && !MatchQuickButton(frame).Matched
            ? MaaPipelineRecognitionResult.Hit(detail: "当前装备页没有蓝白出售按钮") : MaaPipelineRecognitionResult.Miss())
            with { EvidencePath = evidencePath };
    }

    MaaPipelineRecognitionResult MatchQuickButton(Bitmap frame)
    {
        var quick = Match(frame, catalog.Get("BlueWhite"));
        if (!quick.Matched || quick.Box is not { } quickBox) return quick;
        // 单按钮布局会把逐件出售移到蓝白按钮的位置。灰色图标背景相似，
        // 必须让同一位置的两种模板竞争，不能仅凭蓝白模板超过阈值就点击。
        var selective = Match(frame, catalog.Get("SaleIdle"));
        if (selective.Matched && selective.Box is { } selectiveBox &&
            Math.Abs(quickBox.X - selectiveBox.X) < 12 && Math.Abs(quickBox.Y - selectiveBox.Y) < 12 &&
            selective.Score >= quick.Score)
            return MaaPipelineRecognitionResult.Miss("右侧图标实际为逐件出售，跳过蓝白出售");
        return quick;
    }

    MaaPipelineRecognitionResult RecognizeInventoryClosed(Bitmap frame)
    {
        var active = Match(frame, catalog.Get("EquipmentActive")).Matched;
        var tab = Match(frame, catalog.Get("EquipmentTab")).Matched;
        var bag = Match(frame, catalog.Get("OpenBag")).Matched;
        var detail = $"装备高亮={(active ? "是" : "否")}；装备页签={(tab ? "是" : "否")}；背包按钮={(bag ? "是" : "否")}";
        return !active && !tab && bag ? MaaPipelineRecognitionResult.Hit(detail: detail) : MaaPipelineRecognitionResult.Miss(detail);
    }

    async Task<MaaPipelineRecognitionResult> RecognizeInventory(Bitmap frame, CancellationToken token)
    {
        var active = Match(frame, catalog.Get("EquipmentActive")).Matched;
        var tab = Match(frame, catalog.Get("EquipmentTab")).Matched;
        if (!active && !tab)
            return MaaPipelineRecognitionResult.Miss("装备高亮=否；装备页签=否；未进入角色标题检查");
        var title = Match(frame, catalog.Get("RoleTitle")).Matched;
        if (title)
            return MaaPipelineRecognitionResult.Hit(detail: $"装备高亮={(active ? "是" : "否")}；装备页签={(tab ? "是" : "否")}；角色标题=是");
        using var crop = frame.Clone(new Rectangle(90, 4, 150, 43), PixelFormat.Format24bppRgb);
        var words = await device.ReadWordsAsync(crop, token);
        var recognizedText = string.Concat(words.Select(word => word.Text));
        var ocrMatched = words.Any(word => OcrTextLocator.Compact(word.Text).Contains("角色"));
        var detail = $"装备高亮={(active ? "是" : "否")}；装备页签={(tab ? "是" : "否")}；角色标题模板=否；OCR={recognizedText}";
        return ocrMatched ? MaaPipelineRecognitionResult.Hit(text: recognizedText, detail: detail) : MaaPipelineRecognitionResult.Miss(detail);
    }

    MaaPipelineRecognitionResult Match(Bitmap frame, MaaPipelineTask task)
    {
        if (task.Templates.Count == 0) return MaaPipelineRecognitionResult.Miss();
        var area = task.Roi is { } roi ? new Rectangle(roi.X, roi.Y, roi.Width, roi.Height) : new Rectangle(0, 0, 1004, 565);
        using var crop = frame.Clone(area, PixelFormat.Format24bppRgb);
        using var memory = new MemoryStream(); crop.Save(memory, ImageFormat.Png);
        using var image = Cv2.ImDecode(memory.ToArray(), ImreadModes.Color);
        foreach (var template in task.Templates)
        {
            using var needle = Cv2.ImRead(Path.Combine(root, template), ImreadModes.Color);
            if (needle.Empty()) throw new FileNotFoundException("出售模板不存在", template);
            using var scores = new Mat(); Cv2.MatchTemplate(image, needle, scores, TemplateMatchModes.SqDiffNormed);
            Cv2.MinMaxLoc(scores, out var minimum, out _, out CvPoint location, out _);
            if (1 - minimum >= task.TemplateThresholds[0])
                return MaaPipelineRecognitionResult.Hit(1 - minimum,
                    new MaaRect(area.X + location.X, area.Y + location.Y, needle.Width, needle.Height));
        }
        return MaaPipelineRecognitionResult.Miss();
    }

    public async Task<MaaPipelineActionResult> ExecuteAsync(MaaPipelineTask task, MaaPipelineRecognitionResult recognition,
        MaaPipelineTaskContext<EquipmentSalePipeline> context, CancellationToken token)
    {
        token.ThrowIfCancellationRequested(); log($"出售 Pipeline：{task.Name}，已选 {selected}");
        if (task.Name == "Prepare")
            log($"出售品质：蓝白={options.BlueWhite}，紫={options.Purple}，暗金={options.DarkGold}，金={options.Gold}");
        if (task.Name == "FailClose") return MaaPipelineActionResult.Failure("背包返回按钮重试达到上限");
        if (task.Name == "Scan") return await Scan(token);
        if (task.Name == "Scroll")
        {
            if (grid is null) return MaaPipelineActionResult.Failure("滚动前没有有效网格");
            // Bounds 的左右边界来自灰色间隙中心；沿内侧列间隙慢拖，
            // 避免在装备内部按下/松开时被游戏同时当成勾选。
            var x = grid.Cells.OrderBy(c => c.Bounds.Y).ThenBy(c => c.Bounds.X).ElementAt(scrollGapColumn).Bounds.Left;
            log($"出售慢拖：列间隙={scrollGapColumn}，({x},380)→({x},{380 - scrollDistance})，{scrollDuration}ms");
            await device.SwipeAsync(x / 1004d, 380d / 565, x / 1004d, (380d - scrollDistance) / 565, scrollDuration);
            await Task.Delay(settleDelay, token); return MaaPipelineActionResult.Success();
        }
        if (task.Action == MaaPipelineAction.ClickSelf)
        {
            if (recognition.Box is not { } box) return MaaPipelineActionResult.Failure("点击目标缺失");
            await device.TapAsync((box.X + box.Width / 2d) / 1004, (box.Y + box.Height / 2d) / 565);
            if (task.Name == "SelectedSubmit") log($"出售成功：已点击确认，累计勾选 {selected}，返回关闭背包");
        }
        return MaaPipelineActionResult.Success();
    }

    public static async Task<string?> ReadInventoryCountAsync(Bitmap frame,
        Func<Bitmap, CancellationToken, Task<IReadOnlyList<OcrWord>>> readWords, CancellationToken token = default)
    {
        using var crop = frame.Clone(new Rectangle(596, 477, 110, 28), PixelFormat.Format24bppRgb);
        var text = string.Concat((await readWords(crop, token)).Select(w => w.Text));
        var match = System.Text.RegularExpressions.Regex.Match(text, @"\d+\s*/\s*\d+");
        if (match.Success)
        {
            var value = System.Text.RegularExpressions.Regex.Replace(match.Value, @"\s", "");
            var parts = value.Split('/');
            return int.TryParse(parts[0], out var usedCount) && int.TryParse(parts[1], out var totalCount) &&
                totalCount > 0 && usedCount <= totalCount ? value : null;
        }
        // 小字体 OCR 会丢失斜杠。先从像素中确认独立、向右上倾斜的分隔符，再分别 OCR 两侧；
        // 不能猜测 230265 应如何拆分，也不把容量写死为 265。
        var separators = new List<Rectangle>(); var visited = new bool[crop.Width, crop.Height];
        for (var y = 0; y < crop.Height; y++)
        for (var x = 8; x < crop.Width; x++)
        {
            if (visited[x, y] || crop.GetPixel(x, y).GetBrightness() >= .39) continue;
            var component = new List<DrawingPoint>(); var pending = new Queue<DrawingPoint>(); pending.Enqueue(new(x, y)); visited[x, y] = true;
            while (pending.TryDequeue(out var point))
            {
                component.Add(point);
                foreach (var dx in new[] { -1, 0, 1 })
                foreach (var dy in new[] { -1, 0, 1 })
                {
                    var xx = point.X + dx; var yy = point.Y + dy;
                    if (xx < 8 || yy < 0 || xx >= crop.Width || yy >= crop.Height || visited[xx, yy] || crop.GetPixel(xx, yy).GetBrightness() >= .39) continue;
                    visited[xx, yy] = true; pending.Enqueue(new(xx, yy));
                }
            }
            var bounds = Rectangle.FromLTRB(component.Min(p => p.X), component.Min(p => p.Y),
                component.Max(p => p.X) + 1, component.Max(p => p.Y) + 1);
            var meanX = component.Average(p => p.X); var meanY = component.Average(p => p.Y);
            var covariance = component.Average(p => (p.X - meanX) * (p.Y - meanY));
            if (bounds.Width is >= 3 and <= 8 && bounds.Height is >= 13 and <= 19 &&
                bounds.Height > bounds.Width * 1.8 && covariance < -1 && component.Count is >= 15 and <= 60)
                separators.Add(bounds);
        }
        if (separators.Count != 1) return null;
        var separator = separators[0];
        if (separator.Left <= 8 || separator.Right >= crop.Width - 8) return null;
        async Task<string?> Digits(Rectangle rect)
        {
            using var part = crop.Clone(rect, PixelFormat.Format24bppRgb);
            using var enlarged = new Bitmap(part, new System.Drawing.Size(part.Width * 3, part.Height * 3));
            var value = OcrTextLocator.Compact(string.Concat((await readWords(enlarged, token)).Select(w => w.Text)));
            return System.Text.RegularExpressions.Regex.IsMatch(value, @"^\d{1,4}$") ? value : null;
        }
        var used = await Digits(new Rectangle(8, 0, separator.Left - 8, crop.Height));
        var capacity = await Digits(new Rectangle(separator.Right, 0, crop.Width - separator.Right, crop.Height));
        return used is not null && capacity is not null && int.Parse(used) <= int.Parse(capacity) ? $"{used}/{capacity}" : null;
    }

    async Task<MaaPipelineActionResult> Scan(CancellationToken token, int refreshAttempt = 0)
    {
        if (++scans > maxPages) return MaaPipelineActionResult.Failure("未发现空格，已达到扫描上限");
        using var frame = await Capture(token);
        var equipmentActive = Match(frame, catalog.Get("EquipmentActive")).Matched;
        var selectedSubmit = Match(frame, catalog.Get("SelectedSubmit")).Matched;
        var selectionActive = Match(frame, catalog.Get("SelectionActive")).Matched;
        if (!equipmentActive || !(selectedSubmit || selectionActive))
        {
            log($"出售扫描界面确认失败：重扫={refreshAttempt}/{stateRefreshRetries}，装备页={equipmentActive}，提交按钮={selectedSubmit}，选择状态={selectionActive}");
            return MaaPipelineActionResult.Failure("装备选择界面未确认");
        }
        grid = EquipmentSaleVision.Detect(frame, visionSettings);
        if (grid is null) return MaaPipelineActionResult.Failure("网格拟合未通过，未执行装备点击");
        var toCancel = grid.Cells.Where(c => c.Selected && (!options.Allows(c.Quality) || selected == 0)).ToArray();
        foreach (var cell in toCancel)
        {
            var correction = await CancelSelection(cell, token);
            if (!correction.Succeeded) return correction;
        }
        if (toCancel.Length > 0)
        {
            using var corrected = await Capture(token);
            if (Match(corrected, catalog.Get("SelectionActive")).Matched &&
                !Match(corrected, catalog.Get("SelectedSubmit")).Matched) selected = 0;
            return await RefreshScan(token, refreshAttempt, "取消勾选后重新拟合网格");
        }
        // 空格需要相隔稳定等待的两帧确认，且仍须处理同页的其余格子。
        end = false;
        if (grid.Cells.Any(c => c.Empty))
        {
            await Task.Delay(settleDelay, token); using var stable = await Capture(token);
            var second = EquipmentSaleVision.Detect(stable, visionSettings);
            end = second is not null && grid.Cells.Where(c => c.Empty).Any(c =>
                second.Cells.Any(d => d.Empty && Math.Abs(c.Bounds.X - d.Bounds.X) < 3 && Math.Abs(c.Bounds.Y - d.Bounds.Y) < 3));
        }
        var signature = string.Join(";", grid.Cells.Select(c => $"{c.Bounds.Y}:{c.Quality}:{c.Empty}:" +
            frame.GetPixel(c.Bounds.Left + 30, c.Bounds.Top + 30).ToArgb()));
        if (refreshAttempt == 0) { stalled = signature == lastPage ? stalled + 1 : 0; lastPage = signature; }
        if (!end && stalled >= 3) return MaaPipelineActionResult.Failure("慢拖后网格内容连续未变化，未把停滞当作末页");
        foreach (var cell in grid.Cells)
        {
            if (cell.Empty || cell.Selected || cell.Checkbox is null || !options.Allows(cell.Quality)) continue;
            // 每次点击前重新截图；只点当前仍未勾选且品质一致的方框。
            using var fresh = await Capture(token);
            var currentGrid = EquipmentSaleVision.Detect(fresh, visionSettings);
            var center = new DrawingPoint(cell.Bounds.Left + cell.Bounds.Width / 2, cell.Bounds.Top + cell.Bounds.Height / 2);
            var now = currentGrid?.Cells.FirstOrDefault(c => c.Bounds.Contains(center));
            if (now is null || Math.Abs(now.Bounds.X - cell.Bounds.X) > 2 || Math.Abs(now.Bounds.Y - cell.Bounds.Y) > 2)
                return await RefreshScan(token, refreshAttempt, $"点击前网格位置变化，原格子={cell.Bounds}");
            if (now.Selected) continue;
            if (now.Quality == SaleQuality.Unknown)
            {
                log($"跳过未知品质装备：格子={now.Bounds}，继续检查后续装备");
                continue;
            }
            if (now.Checkbox is not DrawingPoint target || now.Quality != cell.Quality)
                return await RefreshScan(token, refreshAttempt,
                    $"点击前装备状态变化：格子={cell.Bounds}，品质={cell.Quality}→{now.Quality}，未选方框={now.Checkbox is not null}");
            await device.TapAsync(target.X / 1004d, target.Y / 565d);
            var checkArea = new Rectangle(target.X - 18, target.Y - 18, 36, 36);
            var timer = System.Diagnostics.Stopwatch.StartNew();
            var confirmed = false; var checkScore = 0d;
            while (timer.ElapsedMilliseconds < checkTimeoutMs)
            {
                await Task.Delay(checkIntervalMs, token);
                using var after = await Capture(token);
                checkScore = checkMatcher.Score(after, checkArea);
                if (checkScore >= visionSettings.SelectedCheckThreshold) { confirmed = true; break; }
            }
            log($"勾选确认：({target.X},{target.Y})，匹配={checkScore:0.000}，等待={timer.ElapsedMilliseconds}ms，命中={confirmed}");
            if (!confirmed)
                return MaaPipelineActionResult.Failure("装备勾选未确认，停止以免反复切换");
            selected++;
        }
        return MaaPipelineActionResult.Success();
    }

    async Task<MaaPipelineActionResult> RefreshScan(CancellationToken token, int attempt, string reason)
    {
        log($"出售重新扫描：{reason}，刷新 {attempt + 1}/{stateRefreshRetries}");
        if (attempt >= stateRefreshRetries)
            return MaaPipelineActionResult.Failure($"装备状态连续不稳定，重新扫描达到上限：{reason}");
        await Task.Delay(settleDelay, token);
        return await Scan(token, attempt + 1);
    }

    async Task<MaaPipelineActionResult> CancelSelection(SaleCell cell, CancellationToken token)
    {
        using var fresh = await Capture(token);
        var current = EquipmentSaleVision.Inspect(fresh, cell.Bounds, visionSettings);
        if (!current.Selected) return MaaPipelineActionResult.Success();
        var target = new DrawingPoint(cell.Bounds.Right - 16, cell.Bounds.Top + 12);
        log($"取消装备勾选：{cell.Quality}，({target.X},{target.Y})");
        await device.TapAsync(target.X / 1004d, target.Y / 565d);
        var timer = System.Diagnostics.Stopwatch.StartNew();
        while (timer.ElapsedMilliseconds < checkTimeoutMs)
        {
            await Task.Delay(checkIntervalMs, token);
            using var after = await Capture(token);
            var now = EquipmentSaleVision.Inspect(after, cell.Bounds, visionSettings);
            if (!now.Selected && now.Checkbox is not null)
            {
                log("取消装备勾选：已确认恢复未选方框");
                return MaaPipelineActionResult.Success();
            }
        }
        return MaaPipelineActionResult.Failure("取消装备勾选未确认，未提交出售");
    }
}
