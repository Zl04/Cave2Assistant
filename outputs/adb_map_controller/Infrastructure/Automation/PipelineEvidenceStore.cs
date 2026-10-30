using System.Drawing;
using System.Drawing.Imaging;

namespace AdbMapController;

internal static class PipelineEvidenceStore
{
    public static bool SaveRoutineScreenshots { get; set; } = true;

    public static string? SaveRoutine(Bitmap frame, string runId, int taskId, Action<string>? log = null)
        => SaveRoutineScreenshots ? Save(frame, runId, taskId, log) : null;

    public static string? Save(Bitmap frame, string runId, int taskId, Action<string>? log = null)
    {
        try
        {
            var directory = Path.Combine(AppContext.BaseDirectory, "pipeline-traces", "evidence");
            Directory.CreateDirectory(directory);
            var fileName = $"{runId}-{taskId}-{Guid.NewGuid():N}.jpg";
            frame.Save(Path.Combine(directory, fileName), ImageFormat.Jpeg);
            return fileName;
        }
        catch (Exception error)
        {
            log?.Invoke($"Pipeline 截图保存失败：{error.Message}");
            return null;
        }
    }
}
