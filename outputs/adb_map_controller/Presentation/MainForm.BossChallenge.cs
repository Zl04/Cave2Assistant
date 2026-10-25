using System;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

public sealed partial class MainForm
{
    string? bossChallengeSkipReason;

    async Task RunBossChallengeAsync(CancellationToken token)
    {
        lastEntryRunSucceeded = false;
        bossChallengeSkipReason = null;
        adb.Serial = devices.Text;
        Log("首领挑战：开始执行，检查当前地图");
        var town = await adb.ReadMap();
        if (!MapRunTask.IsReturnDestination(town))
        {
            Log($"首领挑战：当前位于 {town.MapName}，任务需要从城镇开始", LogLevel.Error);
            State("首领挑战：请从城镇开始");
            return;
        }

        var state = new MaaAdbPipelineState(adb, log: Log, saveEvidence: false);
        var catalog = MaaPipelineCatalogLoader.Load(runtime.Paths.Pipeline("boss-challenge-pipeline.json"));
        var progress = new DelegateMaaPipelineTraceSink(value =>
        {
            if (value.Kind == MaaPipelineTraceKind.NodeCompleted)
                Log($"首领挑战：{BossChallengeStep(value.TaskName)}完成");
            else if (value.Kind is MaaPipelineTraceKind.NodeFailed or MaaPipelineTraceKind.TaskChainFailed)
                Log($"首领挑战：{BossChallengeStep(value.TaskName)}失败：{value.Error ?? value.Detail}", LogLevel.Error);
        });
        var pipeline = new MaaPipeline<MainForm>(catalog,
            [new MaaAdbPipelineHandler<MainForm>("BossAdb", _ => state),
             new DelegateMaaPipelineHandler<MainForm>("BossChallenge",
                 (task, _, ct) => RecognizeBossChallengeAsync(task.Name, ct),
                 (task, _, _, ct) => ExecuteBossChallengeAsync(task.Name, ct))],
            new MaaPipelineExecutionOptions { TaskChain = "首领挑战", RetryTimes = 0, MaxTransitions = 30 },
            new MaaPipelineTraceMultiplexer([progress, pipelineWebServer]));
        try
        {
            var result = await pipeline.RunAsync(this, ["OpenActivities"], token);
            token.ThrowIfCancellationRequested();
            if (!result.Succeeded) throw new InvalidOperationException($"{result.LastTask ?? "入口"}：{result.Error ?? result.Status.ToString()}");
            lastEntryRunSucceeded = true;
            if (bossChallengeSkipReason is { } reason)
            {
                Log($"首领挑战：{reason}，善后已完成，继续下一个任务", LogLevel.Warning);
                State($"首领挑战已跳过：{reason}");
                return;
            }
            Log("首领挑战：跑图完成，已返回城镇");
            State("首领挑战完成：已返回城镇");
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested)
        {
            Log("首领挑战：用户取消任务");
            throw;
        }
        catch (Exception ex)
        {
            Log($"首领挑战未完成：{ex}", LogLevel.Error);
            State($"首领挑战未完成：{ex.Message}");
        }
    }

    static string BossChallengeStep(string? name) => name switch
    {
        "OpenActivities" => "打开活动入口",
        "ActivitiesReady" => "识别活动页面",
        "OpenInvasion" => "点击首领入侵横幅",
        "RetryInvasionGate" => "首次未找到首领入侵，准备二次识别",
        "ConfirmInvasion" => "二次识别首领入侵横幅",
        "CloseActivities" or "CloseActivitiesAgain" => "点击空白处关闭活动面板",
        "VerifyActivitiesClosed" or "VerifyActivitiesClosedFinal" => "确认活动面板已关闭",
        "ReportInvasionUnavailable" => "确认当前没有首领入侵活动",
        "CloseExpiredChallenge" or "CloseExpiredChallengeAgain" => "点击空白处关闭已截止的挑战详情",
        "VerifyChallengeClosed" or "VerifyChallengeClosedFinal" => "确认挑战详情已关闭",
        "ChallengeReady" => "识别首领入侵详情",
        "Expired" or "ReportExpired" => "检查报名截止状态",
        "JoinAvailable" => "点击立即加入",
        "WaitForMap" => "等待地图切换",
        "RunMap" => "跑图并返回城镇",
        _ => name ?? "未知步骤"
    };

    async Task<MaaPipelineRecognitionResult> RecognizeBossChallengeAsync(string name, CancellationToken token)
    {
        if (name is "VerifyActivitiesClosed" or "VerifyActivitiesClosedFinal" or
            "VerifyChallengeClosed" or "VerifyChallengeClosedFinal")
        {
            using var frame = await adb.CaptureScreenForAutomationAsync(token);
            var words = await adb.ReadOcrWordsAsync(frame, token);
            var challenge = name is "VerifyChallengeClosed" or "VerifyChallengeClosedFinal";
            var title = OcrTextLocator.Find(words, challenge ? "首领入侵" : "活动", word =>
                word.Center.X >= frame.Width * .42 && word.Center.X <= frame.Width * .58 &&
                word.Center.Y >= frame.Height * .04 && word.Center.Y <= frame.Height * .15);
            return title is null
                ? MaaPipelineRecognitionResult.Hit(detail: challenge ? "挑战标题已消失" : "活动标题已消失")
                : MaaPipelineRecognitionResult.Miss(challenge ? "挑战详情仍然打开" : "活动面板仍然打开");
        }
        if (name != "WaitForMap") return MaaPipelineRecognitionResult.Hit();
        token.ThrowIfCancellationRequested();
        var map = await adb.ReadMap();
        return MapRunTask.IsReturnDestination(map)
            ? MaaPipelineRecognitionResult.Miss("仍在城镇，等待切换地图")
            : MaaPipelineRecognitionResult.Hit(detail: $"已进入 {map.MapName}");
    }

    async Task<MaaPipelineActionResult> ExecuteBossChallengeAsync(string name, CancellationToken token)
    {
        if (name == "RetryInvasionGate")
            Log("首领挑战：首次未识别到首领入侵，进行二次确认");
        if (name == "ReportInvasionUnavailable")
        {
            Log("首领挑战：两次均未识别到首领入侵，活动面板已关闭", LogLevel.Warning);
            bossChallengeSkipReason = "当前活动页面未找到首领入侵";
            return MaaPipelineActionResult.Success();
        }
        if (name == "ReportExpired")
        {
            Log("首领挑战：活动报名已截止，挑战详情已关闭", LogLevel.Warning);
            bossChallengeSkipReason = "活动报名已截止";
            return MaaPipelineActionResult.Success();
        }
        if (name != "RunMap") return MaaPipelineActionResult.Success();
        Log("首领挑战：已进入挑战地图，开始跑图");
        entryRunMovementScope = true;
        try { await RunMovementScope(token, StartRunCore, startupProbePaused: true); }
        finally { entryRunMovementScope = false; }
        Log(lastMapRunSucceeded ? "首领挑战：跑图已返回城镇" : "首领挑战：跑图未完成", lastMapRunSucceeded ? LogLevel.Info : LogLevel.Error);
        return lastMapRunSucceeded
            ? MaaPipelineActionResult.Success()
            : MaaPipelineActionResult.Failure("跑图未完成或尚未返回城镇");
    }
}
