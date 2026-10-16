using System.Drawing.Imaging;
using System.Globalization;
using System.Text.Json;

namespace AdbMapController;

public sealed partial class MainForm
{
    Task<object> HandlePipelineControllerCommandAsync(string command, string? argument)
    {
        var completion = new TaskCompletionSource<object>(TaskCreationOptions.RunContinuationsAsynchronously);
        try
        {
            BeginInvoke(new Action(async () =>
            {
                try { completion.SetResult(await ExecutePipelineControllerCommandAsync(command, argument)); }
                catch (Exception error) { completion.SetResult(new { ok = false, error = error.Message }); }
            }));
        }
        catch (Exception error) { completion.SetResult(new { ok = false, error = error.Message }); }
        return completion.Task;
    }

    async Task<object> ExecutePipelineControllerCommandAsync(string command, string? argument)
    {
        switch (command)
        {
            case "status":
                return new
                {
                    ok = true,
                    connected = adb.IsTouchReady,
                    serial = adb.Serial,
                    devices = devices.Items.Cast<object>().Select(x => x.ToString()).ToArray(),
                    running = activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false },
                    resourceDirectory = runtime.Paths.Root,
                    capabilities = new[] { "ADB", "Pipeline", "Screenshot" }
                };
            case "scan":
                await Scan();
                return new { ok = true, devices = devices.Items.Cast<object>().Select(x => x.ToString()).ToArray(), serial = adb.Serial };
            case "connect":
                if (string.IsNullOrWhiteSpace(argument)) throw new ArgumentException("请选择设备");
                await ConnectDeviceAsync(argument);
                return new { ok = adb.IsTouchReady, serial = adb.Serial };
            case "screenshot":
                if (!adb.IsTouchReady) throw new InvalidOperationException("请先连接 ADB 设备");
                using (var image = await adb.CaptureScreenForAutomationAsync())
                using (var buffer = new MemoryStream())
                {
                    image.Save(buffer, ImageFormat.Png);
                    return new { ok = true, image = "data:image/png;base64," + Convert.ToBase64String(buffer.ToArray()), width = image.Width, height = image.Height };
                }
            case "click":
                if (!adb.IsTouchReady) throw new InvalidOperationException("请先连接 ADB 设备");
                var coordinates = (argument ?? "").Split(',');
                if (coordinates.Length != 2 || !double.TryParse(coordinates[0], NumberStyles.Float, CultureInfo.InvariantCulture, out var x)
                    || !double.TryParse(coordinates[1], NumberStyles.Float, CultureInfo.InvariantCulture, out var y)
                    || x < 0 || x > 1 || y < 0 || y > 1) throw new ArgumentException("无效的截图坐标");
                await adb.TapScreen(x, y);
                return new { ok = true };
            case "start":
                if (!adb.IsTouchReady) throw new InvalidOperationException("请先连接 ADB 设备");
                if (activeMovement is { IsCompleted: false } || activeEntry is { IsCompleted: false })
                    throw new InvalidOperationException("已有任务正在运行");
                using (var request = JsonDocument.Parse(argument ?? "{}"))
                {
                    var file = request.RootElement.GetProperty("pipeline").GetString();
                    var entry = request.RootElement.GetProperty("entry").GetString();
                    switch ((file, entry))
                    {
                        case ("map-run-pipeline.json", "RunDungeon"): _ = RunUi(StartRun); break;
                        case ("entry-run-pipeline.json", "StartFromTown"): _ = RunUi(AutoEnter); break;
                        case ("dungeon-entry-pipeline.json", "开始自动进图"): _ = RunUi(EnterOnly); break;
                        default: throw new InvalidOperationException("此入口依赖专用业务上下文，不能从调试页独立启动");
                    }
                }
                return new { ok = true };
            case "stop":
                _ = RunUi(EmergencyStopAndClear);
                return new { ok = true };
            default: throw new ArgumentException("未知调试命令");
        }
    }
}
