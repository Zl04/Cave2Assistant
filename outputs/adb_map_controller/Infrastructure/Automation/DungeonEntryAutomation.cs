using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed class DungeonEntryAutomation
{
    readonly AdbClient adb;
    readonly EntryTemplateStore templates;
    readonly VisionPipeline vision;
    readonly VisionTaskCatalog? visionTasks;
    readonly Action<string> log;
    readonly Action<string> state;

    public DungeonEntryAutomation(AdbClient adb, EntryTemplateStore templates,
        Action<string> log, Action<string> state)
    {
        this.adb = adb;
        this.templates = templates;
        this.log = log;
        this.state = state;
        vision = new VisionPipeline(adb.ReadOcrWordsAsync);
        var taskPath = Path.Combine(AppContext.BaseDirectory, "vision", "tasks.json");
        if (File.Exists(taskPath))
        {
            try { visionTasks = VisionTaskCatalog.Load(taskPath); }
            catch (Exception ex) { log($"识图任务配置加载失败，将使用内置默认值：{ex.Message}"); }
        }
    }

    public async Task<MaaPipelineExecutionResult> RunAsync(
        DungeonEntrySelection selection,
        CancellationToken token,
        IMaaPipelineTraceSink? trace = null)
    {
        var template = templates.Get(selection.Map.TemplateId)
            ?? throw new InvalidOperationException($"未找到“{selection.Map.Name}”的入口场景模板；请先打开巴萨坦地图，再点击“更新入口模板”采集周边场景");
        if (!template.IsValid) throw new InvalidDataException("入口识图模板损坏，请重新标定");

        var pipelinePath = Path.Combine(AppContext.BaseDirectory, "pipelines", "dungeon-entry-pipeline.json");
        var catalog = MaaPipelineCatalogLoader.Load(pipelinePath);
        var pipeline = new MaaPipeline<DungeonEntryAutomation>(
            catalog,
            [
                CreatePipelineHandler(selection),
                new MaaAdbPipelineHandler<DungeonEntryAutomation>(
                    "MaaAdb",
                    value => value.CreateMaaAdbPipelineState())
            ],
            new MaaPipelineExecutionOptions
            {
                TaskChain = "DungeonEntry",
                RetryTimes = 0,
                RetryInterval = TimeSpan.Zero
            },
            trace);

        log($"自动进图 Pipeline 启动：目标 {selection.Map.Name} / {selection.Entry.Name} / {selection.Difficulty}");
        var result = await pipeline.RunAsync(this, ["DungeonEntry"], token);
        if (result.Succeeded)
            log("自动进图 Pipeline 完成；后续由地图助手刷新并接管路线");
        else if (result.Status != MaaPipelineExecutionStatus.Canceled)
            log($"自动进图 Pipeline 停止：{result.Status}，{result.Error ?? "未知错误"}");
        return result;
    }

    internal MaaAdbPipelineState CreateMaaAdbPipelineState()
        => new(adb, AppContext.BaseDirectory, log);

    IMaaPipelineHandler<DungeonEntryAutomation> CreatePipelineHandler(DungeonEntrySelection selection)
        => new DelegateMaaPipelineHandler<DungeonEntryAutomation>(
            "DungeonEntryStep",
            async (task, _, token) =>
            {
                if (!string.Equals(task.Name, "BastanMapOpened", StringComparison.Ordinal))
                    return MaaPipelineRecognitionResult.Hit(detail: "Pipeline 节点由领域 handler 执行");

                using var frame = await adb.CaptureScreenForAutomationAsync();
                var title = BuiltInUiTemplateCatalog.FindBastanTitle(frame);
                return title is not null
                    ? MaaPipelineRecognitionResult.Hit(detail: "主城标题已确认")
                    : MaaPipelineRecognitionResult.Miss(detail: "未确认主城标题");
            },
            async (task, _, _, token) =>
            {
                await ExecutePipelineStepAsync(task.Name, selection, token);
                return MaaPipelineActionResult.Success();
            });

    async Task ExecutePipelineStepAsync(string taskName, DungeonEntrySelection selection, CancellationToken token)
    {
        switch (taskName)
        {
            case "DungeonEntry":
            case "BastanMapOpened":
                return;
            case "EnterDungeon":
                await EnterDungeon(selection, token);
                return;
            case "SelectMapVariant":
                await SelectMapVariantIfNeeded(selection, token);
                return;
            case "SelectDifficulty":
                if (selection.Difficulty != DungeonDifficulty.Normal && selection.Map.SupportsDifficulty)
                    await SelectDifficulty(selection.Difficulty, token);
                else
                    log("当前进图不需要切换难度");
                return;
            case "SelectLayer":
                state($"识别{selection.Map.Name}层节点");
                if (!await LocateAndSelectLayer(selection, token))
                    throw new InvalidOperationException($"已进入“{selection.Map.Name}”，但未能通过识图和 OCR 确认“{selection.Entry.Name}”节点，未执行盲点");
                return;
            default:
                throw new InvalidDataException($"进图 Pipeline 未知节点：{taskName}");
        }
    }

    async Task EnterDungeon(DungeonEntrySelection selection, CancellationToken token)
    {
        state("识别巴萨坦主城入口");
        if (selection.Map.UsesSharedEntrance)
        {
            // 共用图标的轮廓接近符文图标。不要盲信视觉评分最高的候选：
            // 按分数顺序点击候选，仅在特殊地图界面（或其弹窗回退）确认转场后接受。
            await TapAndConfirmSharedEntrance(selection.Map.TemplateId, token);
        }
        else
        {
            var cityTarget = await LocateConfirmedCityEntrance(selection.Map.TemplateId, selection.Map.Name, token);
            state($"已确认入口坐标 ({cityTarget.Center.X},{cityTarget.Center.Y})");
            log($"识图确认入口：({cityTarget.Center.X},{cityTarget.Center.Y})，相似度 {cityTarget.Score:0.000}，余量 {cityTarget.Margin:0.000}");
            await adb.TapScreen(cityTarget.Center.X / (double)cityTarget.FrameWidth, cityTarget.Center.Y / (double)cityTarget.FrameHeight);
            await Delay(token, 1500);
        }
    }

    async Task SelectMapVariantIfNeeded(DungeonEntrySelection selection, CancellationToken token)
    {
        // 扭曲空间、元素炼狱、虚空秘境共用一个城内入口，进入后
        // 必须点击左上地图名称，再从三张卡片中识别并切换目标地图。
        if (selection.Map.UsesSharedEntrance)
        {
            await SelectMapVariant(selection.Map.Name, token);
            return;
        }

        // 时光之门普通/英雄也共用城内入口。进入后先读左上角标题：
        // “第X层”是普通页，地图名称是英雄页。只有不符合目标时才切页。
        if (selection.Map.IsTimeGate)
        {
            await EnsureTimeGateVariant(selection, token);
            return;
        }

        log("当前进图不需要切换地图分支");
    }

    async Task EnsureTimeGateVariant(DungeonEntrySelection selection, CancellationToken token)
    {
        var expected = selection.Map.IsHeroVariant || TimeGateVariantClassifier.IsHeroEntry(selection.Entry.Name)
            ? TimeGateVariant.Hero
            : TimeGateVariant.Normal;
        var expectedName = expected == TimeGateVariant.Hero ? "时光之门(英雄)" : "时光之门";

        for (var attempt = 1; attempt <= 2; attempt++)
        {
            var (current, title) = await ReadTimeGateVariant(token);
            if (current == expected)
            {
                state($"已确认时光之门页签：{expectedName}（左上角“{title}”）");
                return;
            }

            if (current == TimeGateVariant.Unknown)
                throw new InvalidOperationException("进入时光之门后未能稳定识别左上角标题，无法判断普通/英雄地图，未执行盲点");

            log($"时光之门页签不符合目标：当前“{title}”={current}，目标={expectedName}；准备打开上方切换入口");
            state($"切换时光之门页签为 {expectedName} ({attempt}/2)");
            await SelectMapVariant(expectedName, token);

            var (verified, verifiedTitle) = await ReadTimeGateVariant(token);
            if (verified == expected)
            {
                state($"已复核时光之门页签：{expectedName}（左上角“{verifiedTitle}”）");
                return;
            }

            if (verified == TimeGateVariant.Unknown)
                throw new InvalidOperationException($"切换到“{expectedName}”后无法识别左上角标题，未执行后续进图");

            log($"切换后页签仍不符合目标：左上角“{verifiedTitle}”={verified}");
        }

        throw new InvalidOperationException($"时光之门页签未能切换并复核为“{expectedName}”，未执行后续进图");
    }

    async Task<(TimeGateVariant Variant, string Title)> ReadTimeGateVariant(CancellationToken token)
    {
        const int maxPasses = 6;
        for (var pass = 1; pass <= maxPasses; pass++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            var y = (int)(frame.Height * .08);
            var width = Math.Max(1, (int)(frame.Width * .30));
            var height = Math.Max(1, (int)(frame.Height * .38));
            using var titleCrop = frame.Clone(new Rectangle(0, y, width, height),
                System.Drawing.Imaging.PixelFormat.Format24bppRgb);
            var words = await adb.ReadOcrWordsAsync(titleCrop);
            var title = OcrTextLocator.Compact(string.Concat(
                words.Where(word => word.Top <= titleCrop.Height * .50)
                    .OrderBy(word => word.Top)
                    .ThenBy(word => word.Left)
                    .Select(word => word.Text)));
            var variant = TimeGateVariantClassifier.Classify(title);
            log($"OCR读取时光之门左上角标题 ({pass}/{maxPasses})：{(title.Length == 0 ? "<空>" : title)} => {variant}");
            if (variant != TimeGateVariant.Unknown)
                return (variant, title);

            if (pass < maxPasses)
                await Delay(token, 250);
        }

        return (TimeGateVariant.Unknown, string.Empty);
    }

    async Task EnsureBastanMapOpen(CancellationToken token)
    {
        for (var attempt = 1; attempt <= 10; attempt++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            if (IsBastanMapFrame(frame))
            {
                state("已确认巴萨坦地图面板打开");
                return;
            }

            var marker = BuiltInUiTemplateCatalog.FindMinimapPlayer(frame);
            if (marker is null || marker.Score < .55)
            {
                state($"等待识别游戏内小地图按钮 ({attempt}/10)");
                await Delay(token, 300);
                continue;
            }

            log($"识图确认小地图按钮：({marker.Center.X},{marker.Center.Y})，相似度 {marker.Score:0.000}");
            await adb.TapScreen(marker.Center.X / (double)frame.Width, marker.Center.Y / (double)frame.Height);
            await Delay(token, 700);
        }
        throw new InvalidOperationException("未能通过识别小地图按钮打开巴萨坦主城地图面板");
    }

    async Task<LocatedVisualMatch> LocateConfirmedCityEntrance(int templateMapId, string mapName, CancellationToken token)
    {
        var candidates = await LocateConfirmedCityEntranceCandidates(templateMapId, mapName, token);
        return candidates.FirstOrDefault()
            ?? throw new InvalidOperationException("未能在巴萨坦主城中唯一确认入口图标，请检查地图页面、模板或重新标定");
    }

    async Task TapAndConfirmSharedEntrance(int templateMapId, CancellationToken token)
    {
        var tried = new List<Point>();
        const int maxCandidates = 18;
        for (var attempt = 1; attempt <= maxCandidates; attempt++)
        {
            token.ThrowIfCancellationRequested();
            var candidates = await LocateConfirmedCityEntranceCandidates(templateMapId, "共享特殊地图", token, maxCandidates);
            var candidate = candidates.FirstOrDefault(x =>
                tried.All(previous => Distance(previous, x.Center) > Math.Max(24, x.FrameWidth * .025)));
            if (candidate is null)
            {
                throw new InvalidOperationException("未能在巴萨坦主城中找到可验证的特殊地图入口图标，请检查地图页面或入口模板");
            }

            tried.Add(candidate.Center);
            state($"确认特殊入口候选 ({attempt}/{maxCandidates})");
            log($"识图确认入口候选：({candidate.Center.X},{candidate.Center.Y})，相似度 {candidate.Score:0.000}，余量 {candidate.Margin:0.000}");
            await adb.TapScreen(candidate.Center.X / (double)candidate.FrameWidth, candidate.Center.Y / (double)candidate.FrameHeight);
            await Delay(token, 450);

            // 共用入口不一定会在弹窗中显示地图名称。它可能已经转场到实际的特殊地图界面，
            // 此时可靠的状态标记是左上角的大地图切换图标。先检查该状态；
            // 否则正确的点击会被当作未命中，Back 会将我们带回巴萨坦城镇地图。
            if (await ConfirmSharedEntryInterface(token))
            {
                state($"已确认特殊入口坐标 ({candidate.Center.X},{candidate.Center.Y})");
                log($"识图确认已进入共享特殊地图界面：({candidate.Center.X},{candidate.Center.Y})");
                await Delay(token, 1500);
                return;
            }

            // 保留弹窗 OCR 作为较慢/旧版 UI 状态的回退。
            // 它不再是主要成功条件，因为特殊地图界面可能完全省略“扭曲空间”文字。
            if (await ConfirmCityPopup("扭曲空间", token))
            {
                state($"已确认特殊入口坐标 ({candidate.Center.X},{candidate.Center.Y})");
                log($"OCR确认共享入口为“扭曲空间”：({candidate.Center.X},{candidate.Center.Y})");
                await Delay(token, 1500);
                return;
            }

            log($"点击候选 ({candidate.Center.X},{candidate.Center.Y}) 后未确认“扭曲空间”，关闭当前弹窗并尝试下一个");
            await adb.PressBack();
            await Delay(token, 250);
            using var frame = await adb.CaptureScreenForAutomationAsync();
            if (!IsBastanMapFrame(frame))
                await EnsureBastanMapOpen(token);
        }
        throw new InvalidOperationException("未能确认已进入共享特殊地图界面，未执行盲点");
    }

    async Task<IReadOnlyList<LocatedVisualMatch>> LocateConfirmedCityEntranceCandidates(
        int templateMapId, string mapName, CancellationToken token, int maxResults = 24)
    {
        for (var attempt = 1; attempt <= 12; attempt++)
        {
            token.ThrowIfCancellationRequested();
            using var first = await adb.CaptureScreenForAutomationAsync();
            var firstCandidates = templates.FindAll(templateMapId, first, .45, maxResults)
                .Where(x => x.Score >= .55)
                .ToArray();
            if (firstCandidates.Length == 0)
            {
                state($"搜索“{mapName}”入口图标 ({attempt}/12)");
                await Delay(token, 250);
                continue;
            }

            await Delay(token, 120);
            using var second = await adb.CaptureScreenForAutomationAsync();
            var secondCandidates = templates.FindAll(templateMapId, second, .45, maxResults)
                .Where(x => x.Score >= .55)
                .ToArray();
            var tolerance = Math.Max(12, Math.Min(second.Width, second.Height) * .035);
            var stable = firstCandidates
                .Select(candidate => secondCandidates
                    .Where(other => Distance(candidate.Center, other.Center) <= tolerance)
                    .OrderByDescending(other => other.Score)
                    .FirstOrDefault())
                .Where(x => x is not null)
                .Select(x => new LocatedVisualMatch(x!, second.Width, second.Height))
                .GroupBy(x => x.Center)
                .Select(group => group.OrderByDescending(x => x.Score).First())
                .OrderByDescending(x => x.Score)
                .ToArray();
            if (stable.Length > 0) return stable;
        }
        return [];
    }

    async Task<bool> ConfirmSharedEntryInterface(CancellationToken token)
    {
        // 从城镇地图转场到特殊地图可能需要多帧。
        // 要求地图切换标记，而不是固定坐标或标题 OCR，
        // 这样下一步才能安全地切换到请求的变体（元素炼狱/扭曲空间/虚空秘境）。
        for (var pass = 0; pass < 5; pass++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            var icon = VisualNodeLocator.FindMapSwitchIcon(frame);
            if (icon is not null)
            {
                log($"识图确认共享特殊地图切换图标：({icon.Center.X},{icon.Center.Y})，像素量 {icon.PixelCount}");
                return true;
            }

            if (pass < 4) await Delay(token, 180);
        }

        return false;
    }

    async Task<bool> ConfirmCityPopup(string expected, CancellationToken token)
    {
        var target = OcrTextLocator.Compact(expected);
        for (var pass = 0; pass < 3; pass++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            var x = (int)(frame.Width * .20);
            var y = (int)(frame.Height * .30);
            var width = Math.Min(frame.Width - x, (int)(frame.Width * .60));
            var height = Math.Min(frame.Height - y, (int)(frame.Height * .42));
            using var crop = frame.Clone(new Rectangle(x, y, width, height),
                System.Drawing.Imaging.PixelFormat.Format24bppRgb);
            var words = await adb.ReadOcrWordsAsync(crop);
            if (OcrTextLocator.Find(words, expected) is not null) return true;
            var text = OcrTextLocator.Compact(string.Concat(words.OrderBy(word => word.Top).ThenBy(word => word.Left).Select(word => word.Text)));
            if (text.Contains(target, StringComparison.Ordinal)) return true;
            if (text.Contains("符文", StringComparison.Ordinal)) return false;
            if (pass < 2) await Delay(token, 120);
        }
        return false;
    }

    bool IsBastanMapFrame(Bitmap frame)
    {
        var title = BuiltInUiTemplateCatalog.FindBastanTitle(frame);
        if (title is null)
        {
            return false;
        }

        log($"图片确认巴萨坦标题：({title.Center.X},{title.Center.Y})，相似度 {title.Score:0.000}");
        return true;
    }

    async Task SelectMapVariant(string variant, CancellationToken token)
    {
        for (var attempt = 1; attempt <= 8; attempt++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            var icon = VisualNodeLocator.FindMapSwitchIcon(frame);
            if (icon is null)
            {
                state($"等待识别左上地图切换图标 ({attempt}/8)");
                await Delay(token, 250);
                continue;
            }

            log($"识图确认地图切换图标：({icon.Center.X},{icon.Center.Y})，像素量 {icon.PixelCount}");
            await adb.TapScreen(icon.Center.X / (double)frame.Width, icon.Center.Y / (double)frame.Height);
            await Delay(token, 400);
            var card = await LocateStableText(variant, .25, .78, allowScroll: false, token,
                word => word.Center.X >= frame.Width * .08 && word.Center.X <= frame.Width * .95);
            if (card is null)
            {
                await Delay(token, 250);
                continue;
            }

            state($"确认地图页签“{variant}”坐标 ({card.Center.X},{card.Center.Y})");
            log($"OCR确认地图页签：{variant}，坐标 ({card.Center.X},{card.Center.Y})，置信度 {card.Confidence:0.0}");
            await adb.TapScreen(card.Center.X / (double)card.FrameWidth, card.Center.Y / (double)card.FrameHeight);
            await Delay(token, 900);
            return;
        }
        throw new InvalidOperationException($"未能打开左上地图切换页并确认“{variant}”页签，未执行盲点");
    }

    async Task SelectDifficulty(DungeonDifficulty difficulty, CancellationToken token)
    {
        var difficultyName = difficulty switch
        {
            DungeonDifficulty.Elite => "精英",
            DungeonDifficulty.Nightmare => "噩梦",
            _ => "普通",
        };
        var difficultyWord = await LocateStableText(difficultyName, .48, .94, allowScroll: false, token);
        if (difficultyWord is null) throw new InvalidOperationException($"已选择{difficultyName}难度，但未识别到对应按钮，未执行盲点");
        log($"OCR确认{difficultyName}难度按钮：({difficultyWord.Center.X},{difficultyWord.Center.Y})");
        await adb.TapScreen(difficultyWord.Center.X / (double)difficultyWord.FrameWidth, difficultyWord.Center.Y / (double)difficultyWord.FrameHeight);
        await Delay(token, 350);
    }

    async Task<bool> LocateAndSelectLayer(DungeonEntrySelection selection, CancellationToken token)
    {
        var tried = new List<Point>();
        const int maxPasses = 8;
        for (var pass = 0; pass < maxPasses; pass++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            var candidates = VisualNodeLocator.FindMapNodes(frame);
            state($"识别到 {candidates.Count} 个层节点 ({pass + 1}/{maxPasses})");
            log($"地图节点识别：{string.Join("、", candidates.Select(x => $"{x.Center.X},{x.Center.Y}"))}");

            foreach (var candidate in candidates)
            {
                if (tried.Any(x => Distance(x, candidate.Center) <= Math.Max(32, frame.Width * .018))) continue;
                tried.Add(candidate.Center);
                await adb.TapScreen(candidate.Center.X / (double)frame.Width, candidate.Center.Y / (double)frame.Height);
                await Delay(token, 380);

                using var selectedFrame = await adb.CaptureScreenForAutomationAsync();
                var selected = await ReadSelectedEntry(selectedFrame, selection.MapId);
                if (selected is null)
                {
                    log($"点击节点 ({candidate.Center.X},{candidate.Center.Y}) 后未得到可确认的层标题");
                    continue;
                }
                log($"OCR确认当前节点：{selected.Name}，点击坐标 ({candidate.Center.X},{candidate.Center.Y})");
                if (selected.Id != selection.Entry.Id) continue;

                state($"已确认目标节点 {selected.Name}");
                return true;
            }

            if (pass >= maxPasses - 1) break;
            state($"当前画面没有目标层，识图拖动地图继续搜索 ({pass + 1}/{maxPasses - 1})");
            // 这是视口手势，而不是目标坐标。下一帧总会重新识别，且每次点击都通过 OCR 确认。
            await adb.SwipeScreen(.84, .57, .38, .57, 555);
            await Delay(token, 600);
        }
        return false;
    }

    async Task<DungeonEntryOption?> ReadSelectedEntry(Bitmap frame, int mapId)
    {
        var y = (int)(frame.Height * .08);
        var width = Math.Max(1, (int)(frame.Width * .30));
        var height = Math.Max(1, (int)(frame.Height * .38));
        using var title = frame.Clone(new Rectangle(0, y, width, height), System.Drawing.Imaging.PixelFormat.Format24bppRgb);
        var words = await adb.ReadOcrWordsAsync(title);
        var compact = OcrTextLocator.Compact(string.Concat(words.OrderBy(x => x.Top).ThenBy(x => x.Left).Select(x => x.Text)));

        var layer = Regex.Match(compact, @"(?:第)?(?<value>\d{1,3})层");
        if (layer.Success && int.TryParse(layer.Groups["value"].Value, out var value))
        {
            var named = DungeonEntryCatalog.EntriesForMap(mapId)
                .FirstOrDefault(x => OcrTextLocator.Compact(x.Name) == $"{value}层");
            if (named is not null) return named;
        }

        var hero = Regex.Match(compact, @"图(?<value>[1-6一二三四五六])");
        if (hero.Success)
        {
            var heroId = hero.Groups["value"].Value switch
            {
                "1" or "一" => 1,
                "2" or "二" => 2,
                "3" or "三" => 3,
                "4" or "四" => 4,
                "5" or "五" => 5,
                "6" or "六" => 6,
                _ => 0
            };
            var named = DungeonEntryCatalog.EntriesForMap(mapId)
                .FirstOrDefault(x => x.Id == heroId);
            if (named is not null) return named;
        }
        return null;
    }

    async Task<LocatedTextMatch?> LocateStableText(string target, double minY, double maxY,
        bool allowScroll, CancellationToken token, Func<OcrWord, bool>? extraFilter = null)
    {
        const int maxPasses = 8;
        for (var pass = 0; pass < maxPasses; pass++)
        {
            token.ThrowIfCancellationRequested();
            using var first = await adb.CaptureScreenForAutomationAsync();
            var a = await FindText(first, target, minY, maxY, extraFilter);
            if (a is not null)
            {
                await Delay(token, 100);
                using var second = await adb.CaptureScreenForAutomationAsync();
                var b = await FindText(second, target, minY, maxY, extraFilter);
                if (b is not null && Distance(a.Center, b.Center) <= Math.Max(18, second.Width * .04))
                    return new LocatedTextMatch(b.Text, b.Bounds, b.Confidence, second.Width, second.Height);
            }

            if (!allowScroll || pass >= maxPasses - 1) break;
            state($"未看到“{target}”，滚动关卡列表 ({pass + 1}/{maxPasses - 1})");
            await adb.SwipeScreen(.50, .82, .50, .28, 450);
            await Delay(token, 550);
        }
        return null;
    }

    async Task<OcrTextMatch?> FindText(Bitmap frame, string target, double minY, double maxY,
        Func<OcrWord, bool>? extraFilter)
    {
        VisionTask task;
        if (string.Equals(target, "挑战", StringComparison.Ordinal) && visionTasks is not null &&
            visionTasks.Names.Contains("ChallengeButton", StringComparer.OrdinalIgnoreCase))
        {
            task = visionTasks.Get("ChallengeButton");
        }
        else
        {
            task = new VisionTask
            {
                Name = $"OCR:{target}",
                Algorithm = VisionAlgorithm.OcrDetect,
                Text = [target],
                Roi = new Rectangle(0,
                    (int)Math.Round(VisionPipeline.DesignHeight * minY),
                    VisionPipeline.DesignWidth,
                    Math.Max(1, (int)Math.Round(VisionPipeline.DesignHeight * (maxY - minY))))
            };
        }
        var result = await vision.RecognizeAsync(task, frame,
            word => extraFilter?.Invoke(word) ?? true);
        return result.TextMatch;
    }

    static double Distance(Point a, Point b)
        => Math.Sqrt(Math.Pow(a.X - b.X, 2) + Math.Pow(a.Y - b.Y, 2));

    static Task Delay(CancellationToken token, int milliseconds)
        => Task.Delay(milliseconds, token);
}

public sealed record LocatedVisualMatch(VisualMatch Match, int FrameWidth, int FrameHeight)
{
    public Point Center => Match.Center;
    public double Score => Match.Score;
    public double Margin => Match.Margin;
}

public sealed record LocatedTextMatch(string Text, Rectangle Bounds, double Confidence, int FrameWidth, int FrameHeight)
{
    public Point Center => new(Bounds.Left + Bounds.Width / 2, Bounds.Top + Bounds.Height / 2);
}
