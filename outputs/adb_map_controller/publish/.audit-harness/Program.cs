using System.Collections.Concurrent;
using System.Drawing;
using AdbMapController;

class QueuedContext : SynchronizationContext
{
    public readonly BlockingCollection<(SendOrPostCallback, object)> Queue = new();
    public override void Post(SendOrPostCallback callback, object state) => Queue.Add((callback, state));
    public void PumpOne() { if (!Queue.TryTake(out var item, 5000)) throw new TimeoutException(); item.Item1(item.Item2); }
}
class Program
{
    static void Main()
    {
        var type = typeof(AdbClient).Assembly.GetType("AdbMapController.ScreenFrameCache", true);
        var cache = Activator.CreateInstance(type, true);
        var context = new QueuedContext();
        SynchronizationContext.SetSynchronizationContext(context);
        var source = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
        Func<CancellationToken, Task<Bitmap>> capture = _ => source.Task;
        var waiter = (Task<Bitmap>)type.GetMethod("GetAsync").Invoke(cache, new object[] { 1L, capture, CancellationToken.None });
        source.SetResult(new Bitmap(2, 2));
        context.PumpOne(); // CaptureAndPublish publishes; waiter continuation is now queued.
        type.GetMethod("Clear").Invoke(cache, null);
        context.PumpOne(); // Waiter clones the frame disposed by Clear.
        try { using var frame = waiter.GetAwaiter().GetResult(); Console.WriteLine("clear-before-clone: unexpected success"); }
        catch (Exception ex) { Console.WriteLine("clear-before-clone: " + ex.GetType().FullName + ": " + ex.Message); }
        ((IDisposable)cache).Dispose();
        SynchronizationContext.SetSynchronizationContext(null);

        cache = Activator.CreateInstance(type, true);
        source = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
        int captures = 0;
        capture = _ => { Interlocked.Increment(ref captures); return source.Task; };
        waiter = (Task<Bitmap>)type.GetMethod("GetAsync").Invoke(cache, new object[] { 2L, capture, CancellationToken.None });
        type.GetMethod("Clear").Invoke(cache, null);
        source.SetResult(new Bitmap(2, 2));
        using var first = waiter.GetAwaiter().GetResult();
        var second = (Task<Bitmap>)type.GetMethod("GetAsync").Invoke(cache, new object[] { 2L, capture, CancellationToken.None });
        using var next = second.GetAwaiter().GetResult();
        Console.WriteLine("clear-during-capture: captures=" + captures + " (pre-clear capture republished)");
        ((IDisposable)cache).Dispose();
        var analyzer = typeof(AdbClient).Assembly.GetType("AdbMapController.AdbScreenAnalyzer", true);
        var textRule = analyzer.GetMethod("IsServerErrorText");
        Console.WriteLine("idle-disconnect-text: " + textRule.Invoke(null, new object[] { "闲置时间过长,已和服务器断开连接." }));
        var paths = ((string)AppContext.GetData("TRUSTED_PLATFORM_ASSEMBLIES")).Split(Path.PathSeparator);
        var refs = paths.Where(path => Path.GetFileName(path).StartsWith("System.", StringComparison.Ordinal)
            || Path.GetFileName(path) is "System.dll" or "mscorlib.dll" or "netstandard.dll")
            .Select(path => Microsoft.CodeAnalysis.MetadataReference.CreateFromFile(path));
        var tree = Microsoft.CodeAnalysis.CSharp.CSharpSyntaxTree.ParseText("namespace AdbMapController; public class Forbidden { public System.Windows.Forms.Form Value; }");
        var compilation = Microsoft.CodeAnalysis.CSharp.CSharpCompilation.Create("GuardProbe", new[] { tree }, refs,
            new Microsoft.CodeAnalysis.CSharp.CSharpCompilationOptions(Microsoft.CodeAnalysis.OutputKind.DynamicallyLinkedLibrary));
        Console.WriteLine("domain-reference-filter-accepts-WinForms: errors=" + compilation.GetDiagnostics().Count(d => d.Severity == Microsoft.CodeAnalysis.DiagnosticSeverity.Error));
    }
}
