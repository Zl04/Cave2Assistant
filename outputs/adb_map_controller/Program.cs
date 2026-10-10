using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AdbMapController;

internal static class Program
{
    [STAThread]
    static void Main()
    {
        Directory.SetCurrentDirectory(AppContext.BaseDirectory);

        AppDomain.CurrentDomain.UnhandledException += (_, e) =>
            CrashLog.Write("Unhandled background exception", e.ExceptionObject as Exception
                ?? new Exception(e.ExceptionObject?.ToString()));
        TaskScheduler.UnobservedTaskException += (_, e) =>
            CrashLog.Write("Unobserved task exception", e.Exception);

        MainForm? form = null;
        ControllerRuntime? runtime = null;
        var reporting = false;
        Application.SetUnhandledExceptionMode(UnhandledExceptionMode.CatchException);
        Application.ThreadException += async (_, e) =>
        {
            var path = CrashLog.Write("Unhandled UI exception", e.Exception);
            if (reporting) return;
            reporting = true;
            // 显示模态对话框前停止输入。意外异常导致状态不确定后，不要恢复路线。
            try
            {
                if (form is { IsDisposed: false }) await form.ShutdownAsync();
            }
            catch (Exception shutdownError) { CrashLog.Write("Emergency shutdown", shutdownError); }
            ShowFailure(e.Exception, path);
            Application.Exit();
        };
        try
        {
            PaddleOcrRuntime.Initialize();
            OpenCvRuntime.Initialize();
            ApplicationConfiguration.Initialize();
            runtime = new ControllerRuntime(AppContext.BaseDirectory);
            var settings = new JsonSettingsStore(runtime.Paths.Settings, runtime.Diagnostics.Record);
            form = new MainForm(runtime, settings);
            Application.Run(form);
        }
        catch (Exception ex) { ShowFailure(ex, CrashLog.Write("Application entry point", ex)); }
        finally
        {
            form?.Dispose();
            if (runtime is not null) runtime.DisposeAsync().AsTask().GetAwaiter().GetResult();
        }
    }

    static void ShowFailure(Exception exception, string? path) => MessageBox.Show(
        $"控制器发生异常，运行已中断。\n\n{exception.Message}\n\n" +
        (path is null ? "错误日志无法写入。" : $"详细错误已保存到：\n{path}"),
        "洞窟地图控制器", MessageBoxButtons.OK, MessageBoxIcon.Error);
}
