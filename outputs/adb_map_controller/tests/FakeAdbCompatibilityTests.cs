using System.Drawing;
using System.Reflection;
using System.Text.Json;

namespace AdbMapController.Tests;

[CollectionDefinition("Fake ADB process", DisableParallelization = true)]
public sealed class FakeAdbProcessCollection { }

[Collection("Fake ADB process")]
public sealed class FakeAdbCompatibilityTests
{
    [Theory]
    [InlineData("empty", typeof(InvalidDataException))]
    [InlineData("bad-png", typeof(ArgumentException))]
    [InlineData("nonzero", typeof(InvalidOperationException))]
    public async Task CandidateScreenCapturePreservesEmptyInvalidAndNonzeroFailures(string mode, Type exceptionType)
    {
        using var environment = new FakeAdbEnvironment();
        Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_MODE", mode);
        using var capture = CreateInternal("AdbScreenCapture");
        var call = capture.GetType().GetMethod("CaptureAsync")!;
        var task = (Task<Bitmap>)call.Invoke(capture, ["fixture-capture", "fixture screenshot error", CancellationToken.None])!;
        var error = await Record.ExceptionAsync(async () => await task);
        Assert.IsType(exceptionType, error);
        if (mode == "nonzero") Assert.Contains("fixture capture failure", error!.Message, StringComparison.Ordinal);
    }

    [Fact]
    public async Task CandidateScreenCaptureTimeoutKillsHungFakeProcess()
    {
        using var environment = new FakeAdbEnvironment();
        Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_MODE", "hang");
        using var capture = CreateInternal("AdbScreenCapture");
        var call = capture.GetType().GetMethod("CaptureAsync")!;
        var task = (Task<Bitmap>)call.Invoke(capture, ["fixture-capture", "fixture screenshot error", CancellationToken.None])!;
        var error = await Assert.ThrowsAsync<TimeoutException>(() => task);
        Assert.Contains("截图超时", error.Message, StringComparison.Ordinal);
    }

    [Fact]
    public async Task CandidateTransportReportsRootShellEofAndCommandFailure()
    {
        using var environment = new FakeAdbEnvironment();
        Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_SHELL_MODE", "close");
        var transport = CreateInternal("AdbCommandTransport");
        try
        {
            var type = transport.GetType();
            var rootTask = (Task<string>)type.GetMethod("RunRootAsync")!.Invoke(transport, ["echo fixture"])!;
            var rootError = await Assert.ThrowsAsync<IOException>(() => rootTask);
            Assert.Contains("已断开", rootError.Message, StringComparison.Ordinal);

            Environment.SetEnvironmentVariable("ADB_FIXTURE_COMMAND_MODE", "nonzero");
            var commandTask = (Task<string>)type.GetMethod("RunAsync")!.Invoke(transport, [new[] { "devices" }])!;
            var commandError = await Assert.ThrowsAsync<InvalidOperationException>(() => commandTask);
            Assert.Equal("fixture command failure", commandError.Message);
        }
        finally { ((IDisposable)transport).Dispose(); }
    }

    [Fact]
    public async Task PlayerJsonParseRetriesKeepTwentyAttemptsAndFiveMillisecondDelay()
    {
        using var environment = new FakeAdbEnvironment();
        Environment.SetEnvironmentVariable("ADB_FIXTURE_PLAYER_JSON_MODE", "invalid");
        using var client = new AdbClient { Serial = "fixture-json-retry" };

        var error = await Assert.ThrowsAsync<InvalidDataException>(() => client.ReadPlayer());
        Assert.Contains("在重试后仍无法解析", error.Message, StringComparison.Ordinal);
        var reads = File.ReadAllLines(environment.Transcript)
            .Select(line => JsonSerializer.Deserialize<string[]>(line)!)
            .Where(args => args.Length == 2 && args[0] == "stdin" && args[1].Contains("codex_player_status.json", StringComparison.Ordinal))
            .ToArray();
        Assert.Equal(20, reads.Length);
    }

    [Fact]
    public async Task MissingPlayerSnapshotKeepsAtomicShellRetryCommandAndError()
    {
        using var environment = new FakeAdbEnvironment();
        Environment.SetEnvironmentVariable("ADB_FIXTURE_PLAYER_JSON_MODE", "not-ready");
        using var client = new AdbClient { Serial = "fixture-json-not-ready" };

        var error = await Assert.ThrowsAsync<FileNotFoundException>(() => client.ReadPlayer());
        Assert.Contains("尚未生成", error.Message, StringComparison.Ordinal);
        var read = File.ReadAllLines(environment.Transcript)
            .Select(line => JsonSerializer.Deserialize<string[]>(line)!)
            .Single(args => args.Length == 2 && args[0] == "stdin" && args[1].Contains("codex_player_status.json", StringComparison.Ordinal));
        Assert.Contains("-lt 20", read[1], StringComparison.Ordinal);
        Assert.Contains("sleep 0.005", read[1], StringComparison.Ordinal);
    }

    [Fact]
    public async Task AssistantFacadeEmitsAtomicTestPanelCommandWithoutTouchingDeviceUi()
    {
        using var environment = new FakeAdbEnvironment();
        using var client = new AdbClient { Serial = "fixture-assistant-panel" };
        await client.RequestOpenTestPanel();

        var transcript = Environment.GetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT")!;
        var commands = File.ReadAllLines(transcript)
            .Select(line => JsonSerializer.Deserialize<string[]>(line)!)
            .ToArray();
        Assert.Contains(commands, args => args.Length == 2 && args[0] == "stdin"
            && args[1] == "set -e; rm -f '/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_test_panel.command' '/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_test_panel.command.processing' '/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_test_panel.result'; printf '%s' 'open_test_panel' > '/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_test_panel.command.tmp'; mv -f '/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_test_panel.command.tmp' '/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_test_panel.command'" );
    }

    [Fact]
    public async Task AssistantInstallRejectsMissingTemplateBeforeStartingAdb()
    {
        using var environment = new FakeAdbEnvironment();
        using var client = new AdbClient { Serial = "fixture-assistant-missing-template" };
        var missing = Path.Combine(AppContext.BaseDirectory, Guid.NewGuid().ToString("N"), "missing.lua");
        await Assert.ThrowsAsync<FileNotFoundException>(() => client.InstallAssistant(missing));
        var transcript = Environment.GetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT")!;
        Assert.False(File.Exists(transcript));
    }

    [Fact]
    public async Task AssistantInstallFailureKeepsOriginalAndBackupAndRemovesTemporaryPayload()
    {
        using var environment = new FakeAdbEnvironment();
        var (remoteTarget, remoteBackup, template) = environment.UseAssistantFixture();
        var original = await File.ReadAllBytesAsync(remoteTarget);
        var originalHash = Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(original));
        Environment.SetEnvironmentVariable("ADB_FIXTURE_ASSISTANT_FAIL_AT", "write-target");
        using var client = new AdbClient { Serial = "fixture-assistant-failed-write" };

        var error = await Assert.ThrowsAsync<InvalidOperationException>(() => client.InstallAssistant(template));
        Assert.Equal("Root 命令失败（状态 1）", error.Message);
        Assert.Equal(originalHash, Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteTarget))));
        Assert.Equal(originalHash, Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteBackup))));
        Assert.Empty(Directory.GetFiles(environment.RemoteRoot, "codex_minimap_patch.luac", SearchOption.AllDirectories));
    }

    [Fact]
    public async Task AssistantFakeRemoteInstallAndRepeatedRestorePreserveBackupBytes()
    {
        using var environment = new FakeAdbEnvironment();
        var (remoteTarget, remoteBackup, template) = environment.UseAssistantFixture();
        var originalHash = Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteTarget)));
        using var client = new AdbClient { Serial = "fixture-assistant-roundtrip" };

        var installed = await client.InstallAssistant(template);
        Assert.True(installed.Installed);
        Assert.True(installed.BackupExists);
        Assert.Equal(originalHash, Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteBackup))));

        var restored = await client.RestoreAssistant(template);
        Assert.False(restored.Installed);
        var restoredAgain = await client.RestoreAssistant(template);
        Assert.False(restoredAgain.Installed);
        Assert.Equal(originalHash, Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteTarget))));
        Assert.Equal(originalHash, Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteBackup))));
        Assert.Empty(Directory.GetFiles(environment.RemoteRoot, "codex_minimap_patch.luac", SearchOption.AllDirectories));
    }

    [Fact]
    public async Task AssistantRestoreRejectsCorruptBackupWithoutChangingTarget()
    {
        using var environment = new FakeAdbEnvironment();
        var (remoteTarget, remoteBackup, template) = environment.UseAssistantFixture();
        var originalHash = Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteTarget)));
        await File.WriteAllBytesAsync(remoteBackup, [0x01, 0x02, 0x03]);
        using var client = new AdbClient { Serial = "fixture-assistant-corrupt-backup" };

        await Assert.ThrowsAsync<InvalidDataException>(() => client.RestoreAssistant(template));
        Assert.Equal(originalHash, Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteTarget))));
    }

    [Fact]
    public async Task AssistantStatusPullFailureRemovesRemoteReadCopy()
    {
        using var environment = new FakeAdbEnvironment();
        environment.UseAssistantFixture();
        Environment.SetEnvironmentVariable("ADB_FIXTURE_FAIL_PULL", "1");
        using var client = new AdbClient { Serial = "fixture-assistant-pull-failure" };

        var error = await Assert.ThrowsAsync<InvalidOperationException>(() => client.GetAssistantStatus("unused-template.lua"));
        Assert.Equal("fixture pull failure", error.Message);
        Assert.Empty(Directory.GetFiles(environment.RemoteRoot, "codex_read_*.luac", SearchOption.AllDirectories));
    }

    [Fact]
    public async Task AssistantInstallPushFailureLeavesTargetAndBackupUntouched()
    {
        using var environment = new FakeAdbEnvironment();
        var (remoteTarget, remoteBackup, template) = environment.UseAssistantFixture();
        var originalHash = Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteTarget)));
        Environment.SetEnvironmentVariable("ADB_FIXTURE_FAIL_PUSH", "1");
        using var client = new AdbClient { Serial = "fixture-assistant-push-failure" };

        var error = await Assert.ThrowsAsync<InvalidOperationException>(() => client.InstallAssistant(template));
        Assert.Equal("fixture push failure", error.Message);
        Assert.Equal(originalHash, Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteTarget))));
        Assert.Equal(originalHash, Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(await File.ReadAllBytesAsync(remoteBackup))));
        Assert.Empty(Directory.GetFiles(environment.RemoteRoot, "codex_write_*.luac", SearchOption.AllDirectories));
    }

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public async Task PopupWatchdogReplaysUserFrameAndLatchesGreedyReturnOnly(bool activeMovement)
    {
        using var environment = new FakeAdbEnvironment();
        environment.UseScreenshot(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Visual", "greedy-return-only.png"));
        using var adb = new AdbClient { Serial = "fixture-popup-watchdog" };
        using var touch = new TouchController(adb);
        using var cancel = new CancellationTokenSource();
        var interrupt = new MotionInterruptState();
        var detected = new TaskCompletionSource<MovementPopupKind>(TaskCreationOptions.RunContinuationsAsynchronously);
        var cancelCallbackCalled = false;
        var watchdog = new PopupWatchdog(adb, touch, interrupt,
            probeEnabled: () => true,
            cancelCurrentMovement: () => { cancelCallbackCalled = true; return activeMovement; },
            detected: popup => detected.TrySetResult(popup),
            probeFailed: error => detected.TrySetException(error));

        var run = watchdog.RunAsync(cancel.Token);
        var popup = await detected.Task.WaitAsync(TimeSpan.FromSeconds(20));
        cancel.Cancel();
        await run;

        Assert.Equal(MovementPopupKind.NextFloorDialog, popup);
        Assert.Equal(MotionInterruptReason.Popup, interrupt.Reason);
        Assert.Equal(NextFloorDialogKind.GreedySelection, interrupt.NextFloorDialogKind);
        Assert.True(interrupt.GreedySelectionReturnOnly);
        Assert.Equal(new[] { 0, 1, 2 }, interrupt.GreedySelectionReturnCards);
        Assert.True(cancelCallbackCalled);
    }

    [Fact]
    public async Task PopupWatchdogDoesNotCaptureWhileDedicatedOverlayFlowDisablesProbe()
    {
        using var environment = new FakeAdbEnvironment();
        using var adb = new AdbClient { Serial = "fixture-popup-disabled" };
        using var touch = new TouchController(adb);
        using var cancel = new CancellationTokenSource();
        var disabled = new TaskCompletionSource(TaskCreationOptions.RunContinuationsAsynchronously);
        var watchdog = new PopupWatchdog(adb, touch, new MotionInterruptState(),
            probeEnabled: () => false,
            cancelCurrentMovement: () => throw new InvalidOperationException("disabled probe must not interrupt movement"),
            detected: _ => throw new InvalidOperationException("disabled probe must not detect a popup"),
            probeFailed: error => throw error,
            probeStatus: message =>
            {
                if (message.Contains("等待专用弹窗流程结束", StringComparison.Ordinal)) disabled.TrySetResult();
            },
            probeDisabledReason: () => "fixture overlay owner");

        var run = watchdog.RunAsync(cancel.Token);
        await disabled.Task.WaitAsync(TimeSpan.FromSeconds(5));
        cancel.Cancel();
        await run;

        Assert.False(File.Exists(environment.Transcript), "A disabled probe must not launch adb or capture a frame");
    }

    [Fact]
    public async Task CacheDisposeDuringCaptureRejectsLateFrameAndCompletesWaiter()
    {
        var cacheType = typeof(AdbClient).Assembly.GetType("AdbMapController.ScreenFrameCache", throwOnError: true)!;
        var cache = Activator.CreateInstance(cacheType, nonPublic: true)!;
        var pendingImage = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
        Func<CancellationToken, Task<Bitmap>> capture = _ => pendingImage.Task;
        var get = cacheType.GetMethod("GetAsync")!;
        var waiter = (Task<Bitmap>)get.Invoke(cache, [5L, capture, CancellationToken.None])!;

        cacheType.GetMethod("Dispose")!.Invoke(cache, null);
        pendingImage.SetResult(new Bitmap(2, 2));

        await Assert.ThrowsAsync<ObjectDisposedException>(() => waiter);
    }

    [Fact]
    public async Task FacadeDisposeDuringRealCaptureRejectsLateFrameAndAllowsCaptureToDrain()
    {
        using var environment = new FakeAdbEnvironment();
        var fixtureDirectory = AppContext.BaseDirectory;
        var gate = Path.Combine(fixtureDirectory, "adb-dispose-gate-" + Guid.NewGuid().ToString("N") + ".tmp");
        var imagePath = Path.Combine(fixtureDirectory, "Fixtures", "Visual", "active-play-negative-1080x1920.png");
        environment.UseGatedScreenshot(imagePath, gate);
        var client = new AdbClient { Serial = "fixture-dispose-capture" };
        var capture = typeof(AdbClient).GetMethod("CaptureMovementPopupFrameAsync",
            BindingFlags.Instance | BindingFlags.NonPublic, binder: null,
            types: [typeof(long), typeof(CancellationToken)], modifiers: null)!;
        var pending = (Task<Bitmap>)capture.Invoke(client, [701L, CancellationToken.None])!;
        var transcript = Environment.GetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT")!;
        try
        {
            await WaitForCaptureCommand(transcript);
            client.Dispose();
            File.WriteAllText(gate, "release");
            await Assert.ThrowsAsync<ObjectDisposedException>(() => pending);
            var afterDispose = (Task<Bitmap>)capture.Invoke(client, [702L, CancellationToken.None])!;
            await Assert.ThrowsAsync<ObjectDisposedException>(() => afterDispose);
            Assert.Single(File.ReadAllLines(transcript)
                .Select(line => JsonSerializer.Deserialize<string[]>(line)!),
                args => args.Contains("exec-out", StringComparer.Ordinal));
        }
        finally
        {
            File.WriteAllText(gate, "release");
            client.Dispose();
            File.Delete(gate);
        }
    }

    [Fact]
    public async Task SharedFrameCaptureSurvivesOneWaiterCancelAndReturnsIndependentBitmaps()
    {
        var fixtureDirectory = AppContext.BaseDirectory;
        var serial = "fixture-shared-frame";
        var previousPath = Environment.GetEnvironmentVariable("PATH");
        var previousTranscript = Environment.GetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT");
        var previousRootMode = Environment.GetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED");
        var previousScreenshot = Environment.GetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT");
        var previousGate = Environment.GetEnvironmentVariable("ADB_FIXTURE_CAPTURE_GATE");
        var transcript = Path.Combine(fixtureDirectory, "adb-transcript-" + Guid.NewGuid().ToString("N") + ".jsonl");
        var gate = Path.Combine(fixtureDirectory, "adb-capture-gate-" + Guid.NewGuid().ToString("N") + ".tmp");
        var screenshot = Path.Combine(fixtureDirectory, "Fixtures", "Visual", "active-play-negative-1080x1920.png");
        try
        {
            Environment.SetEnvironmentVariable("PATH", fixtureDirectory + Path.PathSeparator + previousPath);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT", transcript);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED", "0");
            Environment.SetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT", screenshot);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_GATE", gate);

            using var client = new AdbClient();
            client.Serial = serial;
            var capture = typeof(AdbClient).GetMethod("CaptureMovementPopupFrameAsync",
                BindingFlags.Instance | BindingFlags.NonPublic, binder: null,
                types: [typeof(long), typeof(CancellationToken)], modifiers: null)!;
            var first = (Task<Bitmap>)capture.Invoke(client, [42L, CancellationToken.None])!;

            await WaitForCaptureCommand(transcript);

            using var canceledWaiter = new CancellationTokenSource();
            var canceled = (Task<Bitmap>)capture.Invoke(client, [42L, canceledWaiter.Token])!;
            canceledWaiter.Cancel();
            await Assert.ThrowsAnyAsync<OperationCanceledException>(async () => await canceled);
            File.WriteAllText(gate, "release");

            var firstFrame = await first;
            Assert.Equal((1920, 1080), (firstFrame.Width, firstFrame.Height));
            var cachedFrame = (Task<Bitmap>)capture.Invoke(client, [42L, CancellationToken.None])!;
            var secondFrame = await cachedFrame;
            Assert.NotSame(firstFrame, secondFrame);
            var pixel = firstFrame.GetPixel(10, 10);
            firstFrame.Dispose();
            Assert.Equal(pixel, secondFrame.GetPixel(10, 10));

            var nextFrameTask = (Task<Bitmap>)capture.Invoke(client, [43L, CancellationToken.None])!;
            var nextFrame = await nextFrameTask;
            Assert.Equal((1920, 1080), (nextFrame.Width, nextFrame.Height));
            Assert.Equal(pixel, secondFrame.GetPixel(10, 10));

            var afterEvictionTask = (Task<Bitmap>)capture.Invoke(client, [42L, CancellationToken.None])!;
            var afterEvictionFrame = await afterEvictionTask;
            Assert.Equal((1920, 1080), (afterEvictionFrame.Width, afterEvictionFrame.Height));

            client.Disconnect();
            var afterResetTask = (Task<Bitmap>)capture.Invoke(client, [42L, CancellationToken.None])!;
            var afterResetFrame = await afterResetTask;
            Assert.Equal((1920, 1080), (afterResetFrame.Width, afterResetFrame.Height));

            var transcriptLines = await ReadCompletedTranscript(transcript, expectedLines: 4);
            var commands = transcriptLines
                .Select(line => JsonSerializer.Deserialize<string[]>(line)!)
                .ToArray();
            Assert.Equal(4, commands.Count(args => args.SequenceEqual(["-s", serial, "exec-out", "screencap", "-p"])));
            secondFrame.Dispose();
            nextFrame.Dispose();
            afterEvictionFrame.Dispose();
            afterResetFrame.Dispose();
        }
        finally
        {
            Environment.SetEnvironmentVariable("PATH", previousPath);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT", previousTranscript);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED", previousRootMode);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT", previousScreenshot);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_GATE", previousGate);
            File.Delete(transcript);
            File.Delete(gate);
        }
    }

    [Fact]
    public async Task LegacyFacadeAndCandidateTransportUseEquivalentRootMarkerInput()
    {
        var fixtureDirectory = AppContext.BaseDirectory;
        var previousPath = Environment.GetEnvironmentVariable("PATH");
        var previousTranscript = Environment.GetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT");
        var previousRootMode = Environment.GetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED");
        var transcript = Path.Combine(AppContext.BaseDirectory, "adb-transcript-" + Guid.NewGuid().ToString("N") + ".jsonl");
        try
        {
            Environment.SetEnvironmentVariable("PATH", fixtureDirectory + Path.PathSeparator + previousPath);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT", transcript);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED", "0");

            using (var client = new AdbClient())
            {
                client.Serial = "fixture-transport-compare";
                var player = await client.ReadPlayer();
                Assert.Equal(7, player.Sequence);
            }

            var transportType = typeof(AdbClient).Assembly.GetType("AdbMapController.AdbCommandTransport", throwOnError: true)!;
            using var transport = (IDisposable)Activator.CreateInstance(transportType, nonPublic: true)!;
            transportType.GetProperty("Serial")!.SetValue(transport, "fixture-transport-compare");
            var enableRoot = (Task<bool>)transportType.GetMethod("EnableRootAsync")!.Invoke(transport, null)!;
            Assert.True(await enableRoot);
            var runRoot = (Task<string>)transportType.GetMethod("RunRootAsync")!.Invoke(transport, ["echo fixture-probe"])!;
            Assert.Equal(string.Empty, await runRoot);

            var input = File.ReadAllLines(transcript)
                .Select(line => JsonSerializer.Deserialize<string[]>(line)!)
                .Where(args => args.Length == 2 && args[0] == "stdin")
                .Select(args => args[1])
                .ToArray();
            var markerCommands = input
                .Where(line => line.StartsWith("__codex_status=$?; printf", StringComparison.Ordinal)
                    && line.Contains("__CODEX_DONE_1__", StringComparison.Ordinal))
                .ToArray();
            Assert.Equal(2, markerCommands.Length);
            Assert.Equal(markerCommands[0], markerCommands[1]);
            Assert.Contains("\\n__CODEX_DONE_1__:%s\\n", markerCommands[0], StringComparison.Ordinal);
        }
        finally
        {
            Environment.SetEnvironmentVariable("PATH", previousPath);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT", previousTranscript);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED", previousRootMode);
            File.Delete(transcript);
        }
    }

    [Theory]
    [InlineData(false)]
    [InlineData(true)]
    public async Task PublicFacadePreservesSerialArgumentDevicesAndRootMarkerRoundTrip(bool denyRoot)
    {
        var fixtureDirectory = AppContext.BaseDirectory;
        Assert.True(File.Exists(Path.Combine(fixtureDirectory, "adb.exe")));
        var previousPath = Environment.GetEnvironmentVariable("PATH");
        var previousTranscript = Environment.GetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT");
        var previousRootMode = Environment.GetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED");
        var transcript = Path.Combine(AppContext.BaseDirectory, "adb-transcript-" + Guid.NewGuid().ToString("N") + ".jsonl");
        try
        {
            Environment.SetEnvironmentVariable("PATH", fixtureDirectory + Path.PathSeparator + previousPath);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT", transcript);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED", denyRoot ? "1" : "0");

            using (var client = new AdbClient())
            {
                client.Serial = "fixture serial with spaces";
                Assert.Equal(new[] { "fixture-device" }, await client.Devices());
                Assert.Equal(!denyRoot, await client.EnableAdbRoot());
                var player = await client.ReadPlayer();
                Assert.Equal(8, player.Player.X);
                Assert.Equal(3, player.Player.Y);
                Assert.Equal(7, player.Sequence);

                client.Serial = "fixture second serial";
                var switchedPlayer = await client.ReadPlayer();
                Assert.Equal(7, switchedPlayer.Sequence);
                client.Serial = "fixture serial with spaces";
                var returnedPlayer = await client.ReadPlayer();
                Assert.Equal(7, returnedPlayer.Sequence);
            }

            var commands = File.ReadAllLines(transcript)
                .Select(line => JsonSerializer.Deserialize<string[]>(line)!)
                .ToArray();
            Assert.Contains(commands, args => args.SequenceEqual(["-s", "fixture serial with spaces", "devices"]));
            Assert.Contains(commands, args => args.SequenceEqual(["-s", "fixture serial with spaces", "root"]));
            Assert.Contains(commands, args => args.Length == 2 && args[0] == "stdin"
                && args[1].Contains("__CODEX_DONE_1__", StringComparison.Ordinal));
            var shells = commands
                .Where(args => args.Length > 2 && args[^1] == "sh" && args.Contains("shell", StringComparer.Ordinal))
                .ToArray();
            Assert.Equal(3, shells.Length);
            Assert.Equal("fixture serial with spaces", shells[0][Array.IndexOf(shells[0], "-s") + 1]);
            Assert.Equal(denyRoot, Array.Exists(shells[0], arg => arg == "su"));
            Assert.Equal("fixture second serial", shells[1][Array.IndexOf(shells[1], "-s") + 1]);
            Assert.Contains("su", shells[1]);
            Assert.Equal("fixture serial with spaces", shells[2][Array.IndexOf(shells[2], "-s") + 1]);
            Assert.Contains("su", shells[2]);
        }
        finally
        {
            Environment.SetEnvironmentVariable("PATH", previousPath);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT", previousTranscript);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED", previousRootMode);
            File.Delete(transcript);
        }
    }

    static IDisposable CreateInternal(string name)
    {
        var type = typeof(AdbClient).Assembly.GetType("AdbMapController." + name, throwOnError: true)!;
        return (IDisposable)Activator.CreateInstance(type, nonPublic: true)!;
    }

    sealed class FakeAdbEnvironment : IDisposable
    {
        readonly string? path = Environment.GetEnvironmentVariable("PATH");
        readonly string? transcript = Environment.GetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT");
        readonly string? captureMode = Environment.GetEnvironmentVariable("ADB_FIXTURE_CAPTURE_MODE");
        readonly string? commandMode = Environment.GetEnvironmentVariable("ADB_FIXTURE_COMMAND_MODE");
        readonly string? shellMode = Environment.GetEnvironmentVariable("ADB_FIXTURE_ROOT_SHELL_MODE");
        readonly string? screenshot = Environment.GetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT");
        readonly string? captureGate = Environment.GetEnvironmentVariable("ADB_FIXTURE_CAPTURE_GATE");
        readonly string? remoteRoot = Environment.GetEnvironmentVariable("ADB_FIXTURE_REMOTE_ROOT");
        readonly string? assistantFailure = Environment.GetEnvironmentVariable("ADB_FIXTURE_ASSISTANT_FAIL_AT");
        readonly string? playerJsonMode = Environment.GetEnvironmentVariable("ADB_FIXTURE_PLAYER_JSON_MODE");
        readonly string? failPull = Environment.GetEnvironmentVariable("ADB_FIXTURE_FAIL_PULL");
        readonly string? failPush = Environment.GetEnvironmentVariable("ADB_FIXTURE_FAIL_PUSH");
        readonly string transcriptPath = Path.Combine(AppContext.BaseDirectory, "adb-transcript-" + Guid.NewGuid().ToString("N") + ".jsonl");
        readonly string remoteRootPath = Path.Combine(AppContext.BaseDirectory, "adb-remote-" + Guid.NewGuid().ToString("N"));
        public string RemoteRoot => remoteRootPath;
        public string Transcript => transcriptPath;

        public FakeAdbEnvironment()
        {
            Environment.SetEnvironmentVariable("PATH", AppContext.BaseDirectory + Path.PathSeparator + path);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT", transcriptPath);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_MODE", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_COMMAND_MODE", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_SHELL_MODE", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_GATE", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_REMOTE_ROOT", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ASSISTANT_FAIL_AT", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_PLAYER_JSON_MODE", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_FAIL_PULL", null);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_FAIL_PUSH", null);
        }

        public (string target, string backup, string template) UseAssistantFixture()
        {
            Environment.SetEnvironmentVariable("ADB_FIXTURE_REMOTE_ROOT", remoteRootPath);
            var target = Path.Combine(remoteRootPath, "data", "user", "0", "com.avalon.caveonline.cn.huawei", "files", "CaveOnline", "Hotfix", "src", "app", "ui", "minimap", "MiniMapDrawer.luac");
            Directory.CreateDirectory(Path.GetDirectoryName(target)!);
            File.WriteAllBytes(target, LuaAssistantPatcher.EncryptSource("function MiniMapDrawer:ctor()\n    self:init()\nend\nfunction MiniMapDrawer:dtor()\nend\n"));
            var backup = target + ".codex_original.bak";
            File.Copy(target, backup);
            return (target, backup, Path.Combine(AppContext.BaseDirectory, "Fixtures", "Assistant", "MiniMapDrawer.template.lua"));
        }

        public void UseGatedScreenshot(string imagePath, string gatePath)
        {
            Environment.SetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT", imagePath);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_GATE", gatePath);
        }

        public void UseScreenshot(string imagePath)
            => Environment.SetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT", imagePath);

        public void Dispose()
        {
            Environment.SetEnvironmentVariable("PATH", path);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT", transcript);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_MODE", captureMode);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_COMMAND_MODE", commandMode);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ROOT_SHELL_MODE", shellMode);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT", screenshot);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_CAPTURE_GATE", captureGate);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_REMOTE_ROOT", remoteRoot);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_ASSISTANT_FAIL_AT", assistantFailure);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_PLAYER_JSON_MODE", playerJsonMode);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_FAIL_PULL", failPull);
            Environment.SetEnvironmentVariable("ADB_FIXTURE_FAIL_PUSH", failPush);
            File.Delete(transcriptPath);
            if (Directory.Exists(remoteRootPath)) Directory.Delete(remoteRootPath, recursive: true);
        }
    }

    static async Task WaitForCaptureCommand(string transcript)
    {
        var watch = System.Diagnostics.Stopwatch.StartNew();
        while (true)
        {
            try
            {
                if (File.Exists(transcript)
                    && File.ReadAllText(transcript).Contains("exec-out", StringComparison.Ordinal))
                    return;
            }
            catch (IOException) { }
            if (watch.Elapsed > TimeSpan.FromSeconds(5))
                throw new TimeoutException("Fake screenshot process did not reach capture gate");
            await Task.Delay(10);
        }
    }

    static async Task<string[]> ReadCompletedTranscript(string transcript, int expectedLines)
    {
        var watch = System.Diagnostics.Stopwatch.StartNew();
        while (true)
        {
            try
            {
                if (File.Exists(transcript))
                {
                    var lines = File.ReadAllLines(transcript);
                    if (lines.Length >= expectedLines) return lines;
                }
            }
            catch (IOException) { }
            if (watch.Elapsed > TimeSpan.FromSeconds(5))
                throw new TimeoutException("Fake ADB transcript did not finish writing");
            await Task.Delay(10);
        }
    }
}
