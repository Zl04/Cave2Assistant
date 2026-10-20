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
    const double BastanMapBodyThreshold = .85;
    readonly AdbClient adb;
    readonly IMovementInput movement;
    readonly int pulseHoldMs;
    readonly EntryTemplateStore templates;
    readonly VisionPipeline vision;
    readonly VisionTaskCatalog? visionTasks;
    readonly Action<string> log;
    readonly Action<string> state;
    readonly Func<int, bool>? difficultyAttemptsRecognized;
    readonly int? requiredDifficultyAttempts;
    readonly bool stopBeforeChallenge;
    MapDump? mapBeforeChallenge;
    string? lastDungeonMapProbe;
    string? activeEvidenceRunId;
    int activeEvidenceTaskId;
    string? lastFailureEvidencePath;

    public DungeonEntryAutomation(AdbClient adb, IMovementInput movement, int pulseHoldMs, EntryTemplateStore templates,
        Action<string> log, Action<string> state,
        Func<int, bool>? difficultyAttemptsRecognized = null,
        int? requiredDifficultyAttempts = null,
        bool stopBeforeChallenge = false)
    {
        this.adb = adb;
        this.movement = movement;
        this.pulseHoldMs = pulseHoldMs;
        this.templates = templates;
        this.log = log;
        this.state = state;
        this.difficultyAttemptsRecognized = difficultyAttemptsRecognized;
        this.requiredDifficultyAttempts = requiredDifficultyAttempts;
        this.stopBeforeChallenge = stopBeforeChallenge;
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
        mapBeforeChallenge = null;
        lastDungeonMapProbe = null;
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
                TaskChain = "开始自动进图",
                RetryTimes = 0,
                RetryInterval = TimeSpan.Zero
            },
            trace);

        log($"自动进图 Pipeline 启动：目标 {selection.Map.Name} / {selection.Entry.Name} / {selection.Difficulty}");
        var result = await pipeline.RunAsync(this, ["开始自动进图"], token);
        if (result.Status == MaaPipelineExecutionStatus.Stopped && stopBeforeChallenge && result.LastTask == "识别并选择关卡")
            log("已选中关卡，停在点击挑战前");
        else if (result.Succeeded)
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
            async (task, context, token) =>
            {
                if (task.Name == "点击小地图按钮")
                {
                    using var markerFrame = await adb.CaptureScreenForAutomationAsync();
                    var marker = BuiltInUiTemplateCatalog.FindMinimapPlayer(markerFrame);
                    var evidence = PipelineEvidenceStore.Save(markerFrame, context.RunId, context.TaskId, log);
                    return marker is null
                        ? MaaPipelineRecognitionResult.Miss(detail: "未在小地图区域识别到玩家标记", evidencePath: evidence)
                        : MaaPipelineRecognitionResult.Hit(
                            score: marker.Score,
                            box: new MaaRect(
                                (int)Math.Round(marker.Center.X * VisionPipeline.DesignWidth / (double)markerFrame.Width),
                                (int)Math.Round(marker.Center.Y * VisionPipeline.DesignHeight / (double)markerFrame.Height),
                                1, 1),
                            detail: $"多比例模板命中小地图玩家标记，得分 {marker.Score:0.000}", evidencePath: evidence);
                }
                if (task.Name == "等待副本地图加载")
                {
                    token.ThrowIfCancellationRequested();
                    var current = await adb.ReadMap();
                    var previousId = mapBeforeChallenge?.Level;
                    var probe = $"挑战前层ID={previousId?.ToString() ?? "未知"}，当前层ID={current.Level}";
                    var entered = HasEnteredDungeon(mapBeforeChallenge, current);
                    if (entered)
                        log($"层ID已变化，确认进图：{probe}");
                    else if (!string.Equals(lastDungeonMapProbe, probe, StringComparison.Ordinal))
                        log($"等待层ID变化：{probe}");
                    lastDungeonMapProbe = probe;
                    return entered
                        ? MaaPipelineRecognitionResult.Hit(detail: $"层ID已变化；{probe}")
                        : MaaPipelineRecognitionResult.Miss(detail: $"层ID尚未变化；{probe}");
                }
                if (task.Name == "确认噩梦继续挑战")
                    return await RecognizeNightmareContinueDialog(selection, token);
                if (task.Name == "确认宝箱已搜取提示")
                    return await RecognizeLootedChestDialog(token);
                if (task.Name == "检查所选难度次数")
                    return await RecognizeDifficultyAttempts(selection, context, token);
                if (!string.Equals(task.Name, "主城标题已识别", StringComparison.Ordinal))
                {
                    if (task.Name == "当前地图标题匹配目标")
                        return await RecognizeCurrentTargetMapAsync(task, selection, token);
                    return MaaPipelineRecognitionResult.Hit(detail: "Pipeline 节点由领域 handler 执行");
                }

                var check = await CheckBastanMapOpenAsync(token);
                using var frame = check.Frame;
                var titleEvidence = PipelineEvidenceStore.Save(frame, context.RunId, context.TaskId, log);
                return check.Matched
                    ? MaaPipelineRecognitionResult.Hit(detail: check.Detail, evidencePath: titleEvidence)
                    : MaaPipelineRecognitionResult.Miss(detail: check.Detail, evidencePath: titleEvidence);
            },
            async (task, recognition, context, token) =>
            {
                activeEvidenceRunId = context.RunId;
                activeEvidenceTaskId = context.TaskId;
                lastFailureEvidencePath = null;
                if (task.Name == "检查所选难度次数")
                {
                    if (recognition.Detail == "自动跑图次数已耗尽，正常结束")
                        return MaaPipelineActionResult.Stop();
                    return MaaPipelineActionResult.Failure(
                        recognition.Detail ?? "未能确认所选难度的剩余次数，未点击挑战",
                        recognition.EvidencePath);
                }
                if (task.Name == "点击小地图按钮")
                {
                    if (recognition.Box is not { } marker)
                        return MaaPipelineActionResult.Failure("小地图玩家标记没有可用坐标");
                    await adb.TapScreen(marker.X / (double)VisionPipeline.DesignWidth,
                        marker.Y / (double)VisionPipeline.DesignHeight);
                    return MaaPipelineActionResult.Success();
                }
                try { await ExecutePipelineStepAsync(task.Name, selection, token); }
                catch (OperationCanceledException) when (token.IsCancellationRequested) { throw; }
                catch (Exception error)
                {
                    var evidence = lastFailureEvidencePath;
                    if (evidence is null)
                    {
                        try
                        {
                            using var failureFrame = await adb.CaptureScreenForAutomationAsync(token);
                            evidence = PipelineEvidenceStore.Save(failureFrame, context.RunId, context.TaskId, log);
                        }
                        catch (Exception captureError) { log($"失败现场截图未保存：{captureError.Message}"); }
                    }
                    return MaaPipelineActionResult.Failure(error.Message, evidence);
                }
                if (stopBeforeChallenge && task.Name == "识别并选择关卡")
                    return MaaPipelineActionResult.Stop();
                return MaaPipelineActionResult.Success();
            });

    async Task ExecutePipelineStepAsync(string taskName, DungeonEntrySelection selection, CancellationToken token)
    {
        switch (taskName)
        {
            case "开始自动进图":
            case "主城标题已识别":
            case "确认噩梦继续挑战":
                return;
            case "主城地图打开失败":
                throw new InvalidOperationException("未能识别主城标题或小地图玩家标记，已停止进图；请确认仍在巴萨坦主城并检查游戏分辨率/缩放");
            case "点击噩梦继续绿色勾":
                await ConfirmNightmareContinue(selection, token);
                return;
            case "确认宝箱已搜取提示":
                return;
            case "点击宝箱提示绿色勾":
                await ConfirmLootedChestDialog(token);
                return;
            case "进入目标地图":
                await EnterDungeon(selection, token);
                return;
            case "判断当前地图类型":
            case "当前地图标题匹配目标":
                return;
            case "切换地图类型":
                await SelectMapVariantIfNeeded(selection, token);
                return;
            case "选择关卡难度":
                if (selection.Map.SupportsDifficulty)
                    await SelectDifficulty(selection.Difficulty, token);
                else
                    log("当前进图不需要切换难度");
                return;
            case "识别并选择关卡":
                state($"识别{selection.Map.Name}层节点");
                if (!await LocateAndSelectLayer(selection, token))
                    throw new InvalidOperationException($"已进入“{selection.Map.Name}”，但未能通过识图和 OCR 确认“{selection.Entry.Name}”节点，未执行盲点");
                mapBeforeChallenge = await adb.ReadMap();
                return;
            case "等待副本地图加载":
                log("已确认地图切换，自动进图成功");
                state("自动进图成功");
                return;
            default:
                throw new InvalidDataException($"进图 Pipeline 未知节点：{taskName}");
        }
    }

    static bool HasEnteredDungeon(MapDump? previous, MapDump current)
        => previous is not null && current.Level != previous.Level;

    async Task<MaaPipelineRecognitionResult> RecognizeDifficultyAttempts(
        DungeonEntrySelection selection, MaaPipelineTaskContext<DungeonEntryAutomation> context,
        CancellationToken token)
    {
        if (selection.Difficulty == DungeonDifficulty.Normal)
            return MaaPipelineRecognitionResult.Miss(detail: "普通难度没有次数限制，继续挑战");

        token.ThrowIfCancellationRequested();
        using var frame = await adb.CaptureScreenForAutomationAsync();
        var evidencePath = PipelineEvidenceStore.Save(frame, context.RunId, context.TaskId, log);
        var words = await adb.ReadOcrWordsAsync(frame);
        var difficultyName = selection.Difficulty == DungeonDifficulty.Nightmare ? "噩梦" : "精英";
        var label = OcrTextLocator.Find(words, difficultyName,
            word => word.Center.X >= frame.Width * .68 && word.Center.Y >= frame.Height * .25);
        if (label is null)
        {
            var failure = $"未能识别{difficultyName}难度按钮，无法确认剩余次数；为避免误消耗次数，未点击挑战";
            log(failure);
            return MaaPipelineRecognitionResult.Hit(text: difficultyName, detail: failure, evidencePath: evidencePath);
        }

        var nearbyCountWords = words.Where(word => word.Center.X >= frame.Width * .68 &&
                Math.Abs(word.Center.X - label.Center.X) <= frame.Width * .14 &&
                word.Center.Y < label.Center.Y &&
                label.Center.Y - word.Center.Y <= frame.Height * .14)
            .OrderBy(word => word.Top).ThenBy(word => word.Left).ToArray();
        var countText = OcrTextLocator.Compact(string.Concat(nearbyCountWords.Select(word => word.Text)));
        var countMatch = Regex.Match(countText, @"可挑战(?<count>\d+)次");
        if (!countMatch.Success || !int.TryParse(countMatch.Groups["count"].Value, out var remaining))
        {
            var failure = $"已定位{difficultyName}难度按钮，但未识别到其上方剩余次数（OCR：{(countText.Length == 0 ? "<空>" : countText)}）；未点击挑战";
            log(failure);
            return MaaPipelineRecognitionResult.Hit(text: countText, detail: failure, evidencePath: evidencePath);
        }

        log($"挑战前检查次数：{difficultyName}可挑战{remaining}次");
        if (difficultyAttemptsRecognized?.Invoke(remaining) == true)
            return MaaPipelineRecognitionResult.Hit(text: countText, detail: "自动跑图次数已耗尽，正常结束", evidencePath: evidencePath);
        if (requiredDifficultyAttempts is > 0 && remaining < requiredDifficultyAttempts.Value)
        {
            var insufficient = $"所选关卡的{difficultyName}剩余{remaining}次，少于本次任务尚需的{requiredDifficultyAttempts.Value}次；未点击挑战";
            log(insufficient);
            return MaaPipelineRecognitionResult.Hit(text: countText, detail: insufficient, evidencePath: evidencePath);
        }
        if (remaining > 0)
            return MaaPipelineRecognitionResult.Miss(detail: $"{difficultyName}剩余{remaining}次，允许挑战", evidencePath: evidencePath);

        var exhausted = $"{difficultyName}难度可挑战次数不足（剩余0次），已停止进图，未点击挑战";
        log(exhausted);
        return MaaPipelineRecognitionResult.Hit(text: countText, detail: exhausted, evidencePath: evidencePath);
    }

    async Task<MaaPipelineRecognitionResult> RecognizeNightmareContinueDialog(
        DungeonEntrySelection selection, CancellationToken token)
    {
        if (selection.Difficulty != DungeonDifficulty.Nightmare)
            return MaaPipelineRecognitionResult.Miss(detail: "当前难度不是噩梦，跳过噩梦确认弹窗识别");

        token.ThrowIfCancellationRequested();
        using var frame = await adb.CaptureScreenForAutomationAsync();
        var words = await adb.ReadOcrWordsAsync(frame);
        var text = OcrTextLocator.Compact(string.Concat(
            words.OrderBy(word => word.Top).ThenBy(word => word.Left).Select(word => word.Text)));
        var promptMatched = text.Contains("是否继续挑战", StringComparison.Ordinal) ||
            (text.Contains("噩梦难度", StringComparison.Ordinal) && text.Contains("继续挑战", StringComparison.Ordinal));
        var greenRatio = OpenCvPopupColorAnalysis.Ratio(frame, (.50, .70, .54, .75),
            PopupColorKind.GreenButton);
        var panelRatio = OpenCvPopupColorAnalysis.Ratio(frame, (.28, .72, .25, .78),
            PopupColorKind.LightNeutralPanel);
        var matched = promptMatched && greenRatio >= .08 && panelRatio >= .30;
        log($"识别噩梦继续挑战弹窗：OCR={(text.Length == 0 ? "<空>" : text)}，绿色按钮比例={greenRatio:0.00}，面板比例={panelRatio:0.00}，匹配={matched}");
        return matched
            ? MaaPipelineRecognitionResult.Hit(text: text, detail: "已确认噩梦继续挑战弹窗及绿色确认按钮")
            : MaaPipelineRecognitionResult.Miss(detail: "未同时确认噩梦继续挑战文字、弹窗和绿色按钮");
    }

    async Task ConfirmNightmareContinue(DungeonEntrySelection selection, CancellationToken token)
    {
        if (selection.Difficulty != DungeonDifficulty.Nightmare)
            throw new InvalidOperationException("当前难度不是噩梦，拒绝点击噩梦确认按钮");

        using var frame = await adb.CaptureScreenForAutomationAsync();
        var words = await adb.ReadOcrWordsAsync(frame);
        var text = OcrTextLocator.Compact(string.Concat(
            words.OrderBy(word => word.Top).ThenBy(word => word.Left).Select(word => word.Text)));
        var promptMatched = text.Contains("是否继续挑战", StringComparison.Ordinal) ||
            (text.Contains("噩梦难度", StringComparison.Ordinal) && text.Contains("继续挑战", StringComparison.Ordinal));
        var greenRatio = OpenCvPopupColorAnalysis.Ratio(frame, (.50, .70, .54, .75),
            PopupColorKind.GreenButton);
        var panelRatio = OpenCvPopupColorAnalysis.Ratio(frame, (.28, .72, .25, .78),
            PopupColorKind.LightNeutralPanel);
        if (!promptMatched || greenRatio < .08 || panelRatio < .30)
            throw new InvalidOperationException("噩梦确认弹窗在点击前已消失或绿色确认按钮无法确认，未执行点击");

        // 绿色勾位于确认弹窗右侧；在 OCR 与颜色双重确认后点击按钮中心。
        const double confirmX = .59;
        const double confirmY = .64;
        log($"已确认噩梦继续挑战弹窗，点击绿色勾：({confirmX * frame.Width:0},{confirmY * frame.Height:0})");
        await adb.TapScreen(confirmX, confirmY);
        await Delay(token, 600);
    }

    async Task<MaaPipelineRecognitionResult> RecognizeLootedChestDialog(CancellationToken token)
    {
        token.ThrowIfCancellationRequested();
        using var frame = await adb.CaptureScreenForAutomationAsync();
        var words = await adb.ReadOcrWordsAsync(frame);
        var text = OcrTextLocator.Compact(string.Concat(words.OrderBy(word => word.Top)
            .ThenBy(word => word.Left).Select(word => word.Text)));
        var greenRatio = OpenCvPopupColorAnalysis.Ratio(frame, (.50, .70, .54, .75),
            PopupColorKind.GreenButton);
        var panelRatio = OpenCvPopupColorAnalysis.Ratio(frame, (.28, .72, .25, .78),
            PopupColorKind.LightNeutralPanel);
        var matched = IsLootedChestPrompt(text) && greenRatio >= .08 && panelRatio >= .30;
        log($"识别宝箱已搜取提示：文字匹配={IsLootedChestPrompt(text)}，绿色按钮比例={greenRatio:0.00}，面板比例={panelRatio:0.00}");
        return matched
            ? MaaPipelineRecognitionResult.Hit(text: text, detail: "已确认宝箱已搜取提示及绿色确认按钮")
            : MaaPipelineRecognitionResult.Miss(detail: "未确认宝箱已搜取提示");
    }

    async Task ConfirmLootedChestDialog(CancellationToken token)
    {
        var recognition = await RecognizeLootedChestDialog(token);
        if (!recognition.Matched)
            throw new InvalidOperationException("宝箱已搜取提示在点击前已消失或无法确认绿色按钮，未执行点击");
        const double confirmX = .59;
        const double confirmY = .64;
        log("已确认宝箱已搜取提示，点击绿色勾");
        await adb.TapScreen(confirmX, confirmY);
        await Delay(token, 600);
    }

    internal static bool IsLootedChestPrompt(string text)
        => text.Contains("宝箱已经被搜取", StringComparison.Ordinal) &&
           text.Contains("是否继续", StringComparison.Ordinal);

    async Task EnterDungeon(DungeonEntrySelection selection, CancellationToken token)
    {
        state("识别巴萨坦主城入口");
        if (selection.Map.UsesSharedEntrance)
        {
            await EnsureSharedEntranceUncovered(selection.Map.TemplateId, token);
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
            if (selection.Map.Id == 5)
                await SelectOriginalTrialOption(token);
            else
                await Delay(token, 1500);
        }
    }

    async Task EnsureSharedEntranceUncovered(int templateMapId, CancellationToken token)
    {
        for (var attempt = 0; attempt <= 3; attempt++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            if (!IsBastanMapFrame(frame))
                throw new InvalidOperationException("移动角色前未确认巴萨坦地图已打开");
            var visible = templates.FindAll(templateMapId, frame, .70, 4).FirstOrDefault();
            if (visible is not null)
            {
                log($"共享入口图标无遮挡：({visible.Center.X},{visible.Center.Y})，相似度 {visible.Score:0.000}");
                return;
            }

            if (attempt == 3) break;
            state($"入口图标被角色遮挡，移动角色 ({attempt + 1}/3)");
            await MoveTownPlayerSeveralCells(token);
            await EnsureBastanMapOpen(token);
        }
        throw new InvalidOperationException("角色移动后仍未识别到共享入口图标，请检查地图页面或入口模板");
    }

    async Task MoveTownPlayerSeveralCells(CancellationToken token)
    {
        var map = await adb.ReadMap();
        if (map.SceneType != 1 || map.InBattle)
            throw new InvalidOperationException("当前不是可移动的巴萨坦主城状态，未执行角色移动");
        var current = new Cell(map.Player.X, map.Player.Y);
        await adb.PressBack();
        await Delay(token, 250);
        // 与跑图相同：方向键单格脉冲，按游戏导出的坐标确认累计移动。
        // 只要求下一格可走，不限制目的地周围的建筑。
        var directions = new[] { new Cell(1, 0), new Cell(0, 1), new Cell(-1, 0), new Cell(0, -1) };
        foreach (var direction in directions)
        {
            var last = current;
            for (var step = 0; step < 8; step++)
            {
                token.ThrowIfCancellationRequested();
                var liveMap = await adb.ReadMap();
                if (liveMap.SceneType != 1 || liveMap.InBattle)
                    throw new InvalidOperationException("移动中已离开巴萨坦主城或进入战斗，已停止入口识别");
                var position = new Cell(liveMap.Player.X, liveMap.Player.Y);
                var next = new Cell(position.X + direction.X, position.Y + direction.Y);
                if (!liveMap.ByCell.TryGetValue(next, out var tile) || !tile.Walkable) break;
                var button = DirectionMapper.ButtonPosition(direction,
                    liveMap.Confused, liveMap.Reversed, liveMap.ConfuseDirections);
                var input = TouchCoordinateMapper.ButtonPositionToDelta(button);
                await movement.PulseOneCell(input, pulseHoldMs, token);
                await Delay(token, 100);
                var status = await adb.ReadPlayer();
                last = new Cell(status.Player.X, status.Player.Y);
                var moved = Math.Abs(last.X - current.X) + Math.Abs(last.Y - current.Y);
                if (moved >= 3)
                {
                    log($"巴萨坦角色移动结果：{current} -> {last}，位移 {moved} 格");
                    return;
                }
            }
            log($"巴萨坦方向 ({direction.X},{direction.Y}) 尝试后角色位于 {last}");
        }
        throw new InvalidOperationException("方向键尝试四个方向后角色仍未移动三格，已停止入口识别");
    }

    async Task SelectOriginalTrialOption(CancellationToken token)
    {
        const int maxPasses = 12;
        var optionTemplatePath = Path.Combine(AppContext.BaseDirectory,
            "templates", "entrances", "original-trial-option.png");
        if (!File.Exists(optionTemplatePath))
            throw new FileNotFoundException("原初试炼2号入口图标模板缺失", optionTemplatePath);
        var optionTemplate = VisualTemplate.FromFile(optionTemplatePath, .087, .091);
        for (var pass = 1; pass <= maxPasses; pass++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            var words = await adb.ReadOcrWordsAsync(frame);
            var text = OcrTextLocator.Compact(string.Concat(
                words.OrderBy(word => word.Top).ThenBy(word => word.Left).Select(word => word.Text)));
            var hasOriginalTrialLabel = text.Contains("原初试炼", StringComparison.Ordinal);
            var panelRatio = OpenCvPopupColorAnalysis.Ratio(frame, (.25, .25, .75, .70),
                PopupColorKind.LightNeutralPanel);
            if (hasOriginalTrialLabel && panelRatio >= .30)
            {
                // OCR 与面板颜色确认弹窗后，再在中部区域用用户提供的图标模板定位 2 号入口。
                var option = optionTemplate.FindAll(frame, .68, 8)
                    .Where(match => match.Center.X >= frame.Width * .36 && match.Center.X <= frame.Width * .60 &&
                                    match.Center.Y >= frame.Height * .32 && match.Center.Y <= frame.Height * .66)
                    .OrderByDescending(match => match.Score)
                    .FirstOrDefault();
                if (option is null)
                {
                    log($"已识别原初试炼入口弹窗，但未匹配到2号图标模板 ({pass}/{maxPasses})");
                    if (pass < maxPasses) await Delay(token, 250);
                    continue;
                }

                log($"OCR与面板颜色确认原初试炼入口弹窗；模板匹配2号图标：({option.Center.X},{option.Center.Y})，相似度={option.Score:0.000}");
                await adb.TapScreen(option.Center.X / (double)frame.Width,
                    option.Center.Y / (double)frame.Height);
                await Delay(token, 900);

                for (var verifyPass = 1; verifyPass <= 8; verifyPass++)
                {
                    token.ThrowIfCancellationRequested();
                    using var selectedFrame = await adb.CaptureScreenForAutomationAsync();
                    var selected = await ReadSelectedEntry(selectedFrame, 5);
                    if (selected is not null)
                    {
                        log($"已进入原初试炼选关界面，左上角层标题：{selected.Name}");
                        state("已进入原初试炼选关界面");
                        return;
                    }
                    if (verifyPass < 8) await Delay(token, 250);
                }

                throw new InvalidOperationException("已点击原初试炼弹窗2号图标，但未能通过左上角层标题 OCR 确认选关界面");
            }

            if (pass == 1 || pass == maxPasses || pass % 4 == 0)
                log($"等待原初试炼入口弹窗 ({pass}/{maxPasses})：OCR={(text.Length == 0 ? "<空>" : text)}，中央面板比例={panelRatio:0.00}");
            if (pass < maxPasses) await Delay(token, 250);
        }

        throw new InvalidOperationException("点击原初试炼1号入口后未识别到选择2号图标的弹窗");
    }

    async Task SelectMapVariantIfNeeded(DungeonEntrySelection selection, CancellationToken token)
    {
        // 当前地图 OCR 判断由 Pipeline 的 CurrentTargetMap 节点完成；
        // 只有该节点未命中时才会走到这里执行切页。
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

    async Task<MaaPipelineRecognitionResult> RecognizeCurrentTargetMapAsync(
        MaaPipelineTask task, DungeonEntrySelection selection, CancellationToken token)
    {
        if (!selection.Map.UsesSharedEntrance)
            return MaaPipelineRecognitionResult.Miss(detail: "目标地图不使用共享特殊地图入口");

        token.ThrowIfCancellationRequested();
        using var frame = await adb.CaptureScreenForAutomationAsync();
        var roi = task.Roi ?? new MaaRect(0, 28, 435, 205);
        var x = (int)Math.Round(roi.X * frame.Width / (double)VisionPipeline.DesignWidth);
        var y = (int)Math.Round(roi.Y * frame.Height / (double)VisionPipeline.DesignHeight);
        var width = (int)Math.Round(roi.Width * frame.Width / (double)VisionPipeline.DesignWidth);
        var height = (int)Math.Round(roi.Height * frame.Height / (double)VisionPipeline.DesignHeight);
        x = Math.Clamp(x, 0, frame.Width - 1);
        y = Math.Clamp(y, 0, frame.Height - 1);
        width = Math.Clamp(width, 1, frame.Width - x);
        height = Math.Clamp(height, 1, frame.Height - y);
        using var titleCrop = frame.Clone(new Rectangle(x, y, width, height),
            System.Drawing.Imaging.PixelFormat.Format24bppRgb);
        var words = await adb.ReadOcrWordsAsync(titleCrop);
        var title = OcrTextLocator.Compact(string.Concat(
            words.OrderBy(word => word.Top).ThenBy(word => word.Left).Select(word => word.Text)));
        var expected = OcrTextLocator.Compact(selection.Map.Name);
        var matches = title.Contains(expected, StringComparison.Ordinal);
        log($"Pipeline OCR读取左上角地图标题：{(title.Length == 0 ? "<空>" : title)}；目标={selection.Map.Name}，匹配={matches}");
        if (matches)
        {
            state($"已在{selection.Map.Name}，识别目标层节点");
            return MaaPipelineRecognitionResult.Hit(text: title, detail: "当前标题已匹配目标地图，跳过切换");
        }

        return MaaPipelineRecognitionResult.Miss(detail: $"当前标题未匹配目标地图：{title}");
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
            var check = await CheckBastanMapOpenAsync(token);
            using var frame = check.Frame;
            if (check.Matched)
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

            log($"点击候选 ({candidate.Center.X},{candidate.Center.Y}) 后未确认特殊地图切换图标，关闭当前弹窗并尝试下一个");
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
                if (attempt == 12 && activeEvidenceRunId is not null)
                    lastFailureEvidencePath = PipelineEvidenceStore.Save(first, activeEvidenceRunId, activeEvidenceTaskId, log);
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
            if (attempt == 12 && activeEvidenceRunId is not null)
                lastFailureEvidencePath = PipelineEvidenceStore.Save(second, activeEvidenceRunId, activeEvidenceTaskId, log);
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

    bool IsBastanMapFrame(Bitmap frame)
    {
        var title = BuiltInUiTemplateCatalog.FindBastanTitle(frame);
        if (title is not null)
        {
            log($"图片确认巴萨坦标题：({title.Center.X},{title.Center.Y})，相似度 {title.Score:0.000}");
            return true;
        }
        var score = BuiltInUiTemplateCatalog.MatchBastanMapBody(frame);
        if (score < BastanMapBodyThreshold) return false;
        log($"整张地图确认巴萨坦地图面板：相似度 {score:0.000}");
        return true;
    }

    async Task<(bool Matched, string Detail, Bitmap Frame)> CheckBastanMapOpenAsync(CancellationToken token)
    {
        var timer = System.Diagnostics.Stopwatch.StartNew();
        while (true)
        {
            token.ThrowIfCancellationRequested();
            var frame = await adb.CaptureScreenForAutomationAsync(token);
            var title = BuiltInUiTemplateCatalog.FindBastanTitle(frame);
            if (title is not null)
            {
                log($"图片确认巴萨坦标题：({title.Center.X},{title.Center.Y})，相似度 {title.Score:0.000}");
                return (true, "主城标题已确认", frame);
            }
            if (timer.ElapsedMilliseconds >= 3000)
            {
                var score = BuiltInUiTemplateCatalog.MatchBastanMapBody(frame);
                if (score >= BastanMapBodyThreshold)
                {
                    log($"标题 3 秒未命中，整张地图确认巴萨坦地图面板：相似度 {score:0.000}");
                    return (true, $"整张地图已确认，相似度 {score:0.000}", frame);
                }
                return (false, $"标题 3 秒未命中，整张地图相似度 {score:0.000}", frame);
            }
            frame.Dispose();
            await Task.Delay((int)Math.Min(300, 3000 - timer.ElapsedMilliseconds), token);
        }
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

        OcrTextMatch? difficultyWord = null;
        var frameWidth = 0;
        var frameHeight = 0;
        const int maxPasses = 4;
        for (var pass = 1; pass <= maxPasses; pass++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            frameWidth = frame.Width;
            frameHeight = frame.Height;
            var x = (int)Math.Round(frame.Width * .58);
            var y = (int)Math.Round(frame.Height * .30);
            var roi = new Rectangle(x, y, frame.Width - x, frame.Height - y);
            using var crop = frame.Clone(roi, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
            var localWords = await adb.ReadOcrWordsAsync(crop);
            var words = localWords.Select(word => word with
            {
                Left = word.Left + roi.Left,
                Top = word.Top + roi.Top
            }).ToArray();
            difficultyWord = OcrTextLocator.Find(words, difficultyName,
                word => word.Center.X >= frame.Width * .62 && word.Center.Y >= frame.Height * .30);
            var recognizedText = OcrTextLocator.Compact(string.Concat(
                words.OrderBy(word => word.Top).ThenBy(word => word.Left).Select(word => word.Text)));
            log($"OCR查找{difficultyName}难度按钮 ({pass}/{maxPasses})：{(recognizedText.Length == 0 ? "<空>" : recognizedText)}");
            if (difficultyWord is not null) break;
            if (pass < maxPasses) await Delay(token, 180);
        }

        if (difficultyWord is null)
            throw new InvalidOperationException($"未识别到{difficultyName}难度按钮，未执行点击");

        var center = difficultyWord.Center;
        log($"已定位{difficultyName}难度按钮，点击一次：({center.X},{center.Y})；不检查当前选中状态");
        await adb.TapScreen(center.X / (double)frameWidth, center.Y / (double)frameHeight);
        await Delay(token, 350);
    }

    async Task<bool> LocateAndSelectLayer(DungeonEntrySelection selection, CancellationToken token)
    {
        DungeonEntryOption? currentEntry = null;
        System.Drawing.Point? selectedBadgeCenter = null;
        var visitedBadgeCenters = new List<System.Drawing.Point>();
        var discoveredEntryIds = new HashSet<int>();
        var passesWithoutProgress = 0;
        var emptyRecognitionPasses = 0;
        await WaitForMapToSettle(token);
        for (var pass = 0; ; pass++)
        {
            token.ThrowIfCancellationRequested();
            using var frame = await adb.CaptureScreenForAutomationAsync();
            var selectedOnScreen = await ReadSelectedEntry(frame, selection.MapId);
            if (selectedOnScreen is not null) currentEntry = selectedOnScreen;
            if (currentEntry is not null) discoveredEntryIds.Add(currentEntry.Id);
            if (currentEntry?.Id == selection.Entry.Id)
            {
                state($"已确认目标节点 {selection.Entry.Name}");
                return true;
            }
            var coloredBadges = selection.Map.IsTimeGate
                ? VisualNodeLocator.FindBlueNodeBadges(frame)
                : VisualNodeLocator.FindGoldNodeBadges(frame);
            var genericNodes = VisualNodeLocator.FindMapNodes(frame);
            var selectedIcon = VisualNodeLocator.FindSelectedMapNode(frame, genericNodes);
            var hasSelectedIcon = selectedIcon is not null;
            selectedBadgeCenter = hasSelectedIcon ? selectedIcon!.Center : null;
            if (!hasSelectedIcon)
            {
                // 画面中没有选中节点时，不沿用上一帧的位置；任一可见节点均可作为起点。
                visitedBadgeCenters.Clear();
            }
            // 颜色掩码会漏掉灰色或被高亮覆盖的节点；两种识别结果应合并，而非二选一。
            var candidates = coloredBadges.Concat(genericNodes.Where(node => coloredBadges.All(badge =>
                Math.Abs(node.Center.X - badge.Center.X) > frame.Width * 35.0 / 1004 ||
                Math.Abs(node.Center.Y - badge.Center.Y) > frame.Height * 35.0 / 565))).ToArray();
            var sweepButtons = GetSweepExclusionRegions(frame, selectedBadgeCenter);
            var source = selection.Map.IsTimeGate ? "蓝色徽章及通用地图节点" : "金色徽章及通用地图节点";
            state($"识别到 {candidates.Length} 个{source}（第 {pass + 1} 轮）");
            log($"{source}识别：{string.Join("、", candidates.Select(x => $"{x.Center.X},{x.Center.Y}"))}");

            if (candidates.Length == 0)
            {
                emptyRecognitionPasses++;
                if (emptyRecognitionPasses < 3)
                {
                    log($"地图节点暂未识别，保持视口并重新截图 ({emptyRecognitionPasses}/3)");
                    await Delay(token, 400);
                    continue;
                }
                candidates = BuildMapScanCandidates(frame.Width, frame.Height, selection.Map.IsTimeGate);
                log($"连续3帧未识别到节点，逐点检查地图区域 {candidates.Length} 个点；每次点击后核对左侧关卡标题");
            }
            else emptyRecognitionPasses = 0;

            var towardRight = currentEntry is not null && selection.Entry.Id > currentEntry.Id;
            var currentCenter = selectedBadgeCenter;
            var unvisitedCandidates = candidates.Where(x => visitedBadgeCenters.All(visited =>
                Math.Abs(x.Center.X - visited.X) > frame.Width * 35.0 / 1004 ||
                Math.Abs(x.Center.Y - visited.Y) > frame.Height * 35.0 / 565)).ToArray();
            // 普通地图关卡从左到右递增：只有本帧确实看到选中图标时，才收窄到朝目标一侧的徽章。
            var directionalCandidates = hasSelectedIcon && !selection.Map.IsTimeGate &&
                currentEntry is not null && currentCenter is not null
                ? unvisitedCandidates.Where(x => towardRight
                    ? x.Center.X > currentCenter.Value.X + frame.Width * 25.0 / 1004
                    : x.Center.X < currentCenter.Value.X - frame.Width * 25.0 / 1004).ToArray()
                : unvisitedCandidates;
            var orderedCandidates = !hasSelectedIcon || currentCenter is null
                ? unvisitedCandidates.AsEnumerable()
                : selection.Map.IsTimeGate
                    ? unvisitedCandidates.OrderBy(x =>
                        Math.Pow(x.Center.X - currentCenter.Value.X, 2) +
                        Math.Pow(x.Center.Y - currentCenter.Value.Y, 2))
                    : directionalCandidates.OrderBy(x => Math.Abs(x.Center.X - currentCenter.Value.X));
            if (!orderedCandidates.Any())
                log("当前视口内没有可点击的候选徽章，直接拖拽地图继续搜索");
            var bestDistance = currentEntry is null
                ? int.MaxValue : Math.Abs(selection.Entry.Id - currentEntry.Id);
            var improved = false;
            foreach (var candidate in orderedCandidates)
            {
                var tap = candidate.Center;
                var coveringButton = sweepButtons.FirstOrDefault(button => button.Contains(tap));
                if (coveringButton != System.Drawing.Rectangle.Empty)
                {
                    var upperIconY = coveringButton.Top - Math.Max(4, (int)(frame.Height * 8.0 / 565));
                    if (upperIconY < candidate.Bounds.Top + candidate.Bounds.Height / 5)
                    {
                        log($"跳过候选 ({tap.X},{tap.Y})：与扫荡按钮重叠，无法安全点击徽章");
                        continue;
                    }
                    tap = new System.Drawing.Point(tap.X, upperIconY);
                    if (sweepButtons.Any(button => button.Contains(tap)))
                    {
                        log($"跳过候选 ({candidate.Center.X},{candidate.Center.Y})：安全点击点仍落在扫荡按钮内");
                        continue;
                    }
                    log($"候选中心落在扫荡按钮内，改点徽章上半部：({tap.X},{tap.Y})");
                }
                await adb.TapScreen(tap.X / (double)frame.Width, tap.Y / (double)frame.Height);
                await Delay(token, 380);

                using var selectedFrame = await adb.CaptureScreenForAutomationAsync();
                var selected = await ReadSelectedEntry(selectedFrame, selection.MapId);
                if (selected is null || selected.Id == currentEntry?.Id)
                {
                    await Delay(token, 250);
                    using var retryFrame = await adb.CaptureScreenForAutomationAsync();
                    selected = await ReadSelectedEntry(retryFrame, selection.MapId) ?? selected;
                }
                if (selected is null)
                {
                    log($"点击节点 ({candidate.Center.X},{candidate.Center.Y}) 后未得到可确认的层标题");
                    continue;
                }
                log(selected.Id == currentEntry?.Id
                    ? $"点击候选 ({candidate.Center.X},{candidate.Center.Y}) 后层标题仍为{selected.Name}，候选未切换当前选择"
                    : $"点击候选 ({candidate.Center.X},{candidate.Center.Y}) 后 OCR 标题为{selected.Name}");
                if (selected.Id == selection.Entry.Id)
                {
                    state($"已确认目标节点 {selected.Name}");
                    return true;
                }
                if (selected.Id == currentEntry?.Id) continue;

                var distance = Math.Abs(selection.Entry.Id - selected.Id);
                var closerToTarget = distance < bestDistance;
                if (selectedBadgeCenter is not null) visitedBadgeCenters.Add(selectedBadgeCenter.Value);
                selectedBadgeCenter = candidate.Center;
                currentEntry = selected;
                discoveredEntryIds.Add(selected.Id);
                // 扫荡按钮跟随选中节点移动，用刚截的这一帧刷新禁区。
                sweepButtons = GetSweepExclusionRegions(selectedFrame, selectedBadgeCenter);
                if (!closerToTarget)
                {
                    log($"候选 ({candidate.Center.X},{candidate.Center.Y}) 选中 {selected.Name}，比上一节点更远离目标 {selection.Entry.Name}，继续尝试本视口其它候选");
                    continue;
                }
                log($"候选 ({candidate.Center.X},{candidate.Center.Y}) 选中 {selected.Name}，更接近目标 {selection.Entry.Name}，重新识别当前视口");
                bestDistance = distance;
                improved = true;
                break;
            }

            // 只有点击确实推进了进度才重新识别；整轮没有进展时必须拖拽地图换视野。
            if (improved)
            {
                passesWithoutProgress = 0;
                continue;
            }
            passesWithoutProgress++;
            if (passesWithoutProgress % 5 == 0)
                state($"已连续 {passesWithoutProgress} 轮没有推进到更接近 {selection.Entry.Name} 的关卡，继续拖动地图搜索");

            var targetIsRight = currentEntry is null || selection.Entry.Id > currentEntry.Id;
            // 地图惯性可能把视口甩到两端；每次只小幅移动，之后重新截图并逐点核对。
            var (fromX, toX) = targetIsRight ? (.58, .42) : (.42, .58);
            var currentName = currentEntry?.Name ?? "未知";
            var direction = targetIsRight ? "右侧" : "左侧";
            var fingerDirection = targetIsRight ? "从右向左" : "从左向右";
            state($"当前节点{currentName}，目标{selection.Entry.Name}在{direction}；缓慢拖动地图继续搜索（第 {pass + 1} 轮）");
            log($"按关卡顺序判断：当前={currentName}(ID {currentEntry?.Id.ToString() ?? "未知"})，目标={selection.Entry.Name}(ID {selection.Entry.Id})，目标在{direction}；手指{fingerDirection}缓慢拖动约屏幕宽度的16%后重新识别");
            // 手指拖动方向与视口露出的地图方向相反：向左拖露出右侧，向右拖露出左侧。
            // 每次滑动后重新识别节点，避免在地图边缘继续向错误方向拖动。
            await adb.SwipeScreen(fromX, .57, toX, .57, 1600);
            await WaitForMapToSettle(token);
            selectedBadgeCenter = null;
            visitedBadgeCenters.Clear();
        }
    }

    static VisualNodeCandidate[] BuildMapScanCandidates(int width, int height, bool isTimeGate)
    {
        // 仅在连续识别失败时使用：以小于徽章直径的间距覆盖地图画布，
        // 点击后仍须由左侧标题 OCR 确认，扫荡按钮由点击前的禁区检查挡住。
        var (left, top, right, bottom) = isTimeGate
            ? (325, 85, 875, 415)
            : (375, 155, 825, 355);
        var grid = new List<(int X, int Y)>();
        for (var y = top; y <= bottom; y += 36)
        for (var x = left; x <= right; x += 36)
        {
            if (x >= 815 && y >= 290) continue; // 右侧难度按钮
            grid.Add((x, y));
        }
        // 每次盲扫控制在 24 个点以内，避免一个回合点击+OCR 耗时过长。
        const int maxPoints = 24;
        var stride = Math.Max(1, (int)Math.Ceiling(grid.Count / (double)maxPoints));
        var candidates = new List<VisualNodeCandidate>();
        for (var index = 0; index < grid.Count; index += stride)
        {
            var (x, y) = grid[index];
            var centerX = (int)Math.Round(x * width / 1004.0);
            var centerY = (int)Math.Round(y * height / 565.0);
            var halfWidth = (int)Math.Round(20.0 * width / 1004);
            var halfHeight = (int)Math.Round(20.0 * height / 565);
            candidates.Add(new VisualNodeCandidate(new System.Drawing.Point(centerX, centerY),
                new System.Drawing.Rectangle(centerX - halfWidth, centerY - halfHeight,
                    halfWidth * 2, halfHeight * 2), 0));
        }
        return candidates.ToArray();
    }

    static IReadOnlyList<System.Drawing.Rectangle> GetSweepExclusionRegions(Bitmap frame,
        System.Drawing.Point? selectedCenter)
    {
        var regions = VisualNodeLocator.FindSweepButtonRegions(frame).ToList();
        if (selectedCenter is not null)
        {
            // 有些地图的“扫荡”条是灰色，颜色掩码无法识别；它总在当前剑形图标下方。
            var halfWidth = (int)Math.Ceiling(55.0 * frame.Width / 1004);
            var topOffset = (int)Math.Ceiling(15.0 * frame.Height / 565);
            var bottomOffset = (int)Math.Ceiling(65.0 * frame.Height / 565);
            regions.Add(new System.Drawing.Rectangle(selectedCenter.Value.X - halfWidth,
                selectedCenter.Value.Y + topOffset, halfWidth * 2, bottomOffset - topOffset));
        }
        return regions;
    }

    async Task WaitForMapToSettle(CancellationToken token)
    {
        state("等待地图停止滚动");
        await Delay(token, 350);
        var deadline = DateTime.UtcNow.AddSeconds(10);
        var stablePairs = 0;
        double displacement = 0, response = 0;
        var previous = await adb.CaptureScreenForAutomationAsync();
        try
        {
            while (DateTime.UtcNow < deadline)
            {
                token.ThrowIfCancellationRequested();
                await Delay(token, 250);
                var current = await adb.CaptureScreenForAutomationAsync();
                bool still;
                try { still = VisualNodeLocator.IsMapStill(previous, current, out displacement, out response); }
                finally { previous.Dispose(); previous = current; }
                stablePairs = still ? stablePairs + 1 : 0;
                if (stablePairs < 3) continue;
                log($"地图已稳定：连续{stablePairs}帧位移不超过阈值，末次位移={displacement:0.00}，相关度={response:0.00}");
                return;
            }
        }
        finally { previous.Dispose(); }
        throw new InvalidOperationException($"地图在10秒内未稳定，末次位移={displacement:0.00}，相关度={response:0.00}；未点击关卡");
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
