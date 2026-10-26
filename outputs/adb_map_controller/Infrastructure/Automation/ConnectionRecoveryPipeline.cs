using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace AdbMapController;

internal sealed class ConnectionRecoveryPipeline
{
    readonly MaaAdbPipelineState device;
    readonly MaaPipeline<MaaAdbPipelineState> pipeline;

    public ConnectionRecoveryPipeline(AdbClient adb)
    {
        device = new MaaAdbPipelineState(adb, saveEvidence: false);
        var path = Path.Combine(AppContext.BaseDirectory, "pipelines", "connection-recovery-pipeline.json");
        pipeline = new MaaPipeline<MaaAdbPipelineState>(MaaPipelineCatalogLoader.Load(path),
            [new MaaAdbPipelineHandler<MaaAdbPipelineState>("ConnectionAdb", state => state),
             new ConnectionDialogHandler()],
            new MaaPipelineExecutionOptions { TaskChain = "ConnectionRecovery", RetryTimes = 0 });
    }

    public async Task<string?> ClickVisibleButtonAsync(bool includeLoginButton, CancellationToken token)
    {
        var result = await pipeline.RunAsync(device,
            includeLoginButton
                ? ["DisconnectConfirm", "LoginButton", "StartGameButton"]
                : ["DisconnectConfirm", "StartGameButton"], token);
        return result.Succeeded ? result.LastTask : null;
    }

    public async Task<bool> IsGameReadyAsync(CancellationToken token)
    {
        var result = await pipeline.RunAsync(device, ["GameReady"], token);
        return result.Succeeded && result.LastTask == "GameReady";
    }

    sealed class ConnectionDialogHandler : IMaaPipelineHandler<MaaAdbPipelineState>
    {
        public string Name => "ConnectionDialog";

        public async Task<MaaPipelineRecognitionResult> RecognizeAsync(
            MaaPipelineTask task, MaaPipelineTaskContext<MaaAdbPipelineState> context, CancellationToken token)
        {
            using var frame = await context.State.Adb.CaptureScreenForAutomationAsync(token);
            return await context.State.Adb.HasServerErrorDialog(frame, token)
                ? MaaPipelineRecognitionResult.Hit()
                : MaaPipelineRecognitionResult.Miss();
        }

        public async Task<MaaPipelineActionResult> ExecuteAsync(
            MaaPipelineTask task, MaaPipelineRecognitionResult recognition,
            MaaPipelineTaskContext<MaaAdbPipelineState> context, CancellationToken token)
        {
            token.ThrowIfCancellationRequested();
            await context.State.Adb.TapScreenSecondary(.5, .639);
            return MaaPipelineActionResult.Success();
        }
    }
}
