using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

namespace AdbMapController;

// Uses the installed LDPlayer 9 screenshot ABI (also used by MAA LDExtras).
// The x64 object has release/cap vtable entries and returns bottom-up BGR24.
// No third-party source or emulator DLL is bundled with the application.
internal sealed class LdPlayerScreenCapture : IDisposable
{
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    delegate nint Create(uint index, uint processId);
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    delegate nint CaptureFunction(nint instance);
    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    delegate void ReleaseFunction(nint instance);

    nint library, instance;
    readonly CaptureFunction capture;
    readonly ReleaseFunction release;
    readonly int width, height;
    RotateFlipType orientation;

    LdPlayerScreenCapture(nint library, nint instance, int width, int height)
    {
        (this.library, this.instance, this.width, this.height) = (library, instance, width, height);
        var table = Marshal.ReadIntPtr(instance);
        release = Marshal.GetDelegateForFunctionPointer<ReleaseFunction>(Marshal.ReadIntPtr(table));
        capture = Marshal.GetDelegateForFunctionPointer<CaptureFunction>(Marshal.ReadIntPtr(table, nint.Size));
    }

    public static LdPlayerScreenCapture? TryCreate(string serial, Bitmap reference)
    {
        var width = reference.Width;
        var height = reference.Height;
        if (!Environment.Is64BitProcess || !serial.StartsWith("emulator-", StringComparison.Ordinal) ||
            !int.TryParse(serial.AsSpan(9), out var emulatorPort) || emulatorPort < 5554 || (emulatorPort - 5554) % 2 != 0)
            return null;
        var index = (emulatorPort - 5554) / 2;
        foreach (var process in Process.GetProcessesByName("dnplayer"))
        {
            using (process)
            {
                nint library = 0;
                try
                {
                    var root = Path.GetDirectoryName(process.MainModule?.FileName);
                    if (root is null) continue;
                    var libraryPath = Path.Combine(root, "ldopengl64.dll");
                    var consolePath = Path.Combine(root, "ldconsole.exe");
                    if (!File.Exists(libraryPath) || !File.Exists(consolePath)) continue;
                    var psi = new ProcessStartInfo(consolePath)
                    {
                        UseShellExecute = false, CreateNoWindow = true,
                        RedirectStandardOutput = true, RedirectStandardError = true,
                    };
                    psi.ArgumentList.Add("list2");
                    using var console = Process.Start(psi);
                    if (console is null) continue;
                    var output = console.StandardOutput.ReadToEndAsync();
                    var errors = console.StandardError.ReadToEndAsync();
                    if (!console.WaitForExit(1000))
                    {
                        console.Kill(entireProcessTree: true);
                        continue;
                    }
                    var text = output.GetAwaiter().GetResult();
                    _ = errors.GetAwaiter().GetResult();
                    if (console.ExitCode != 0) continue;
                    var row = text.Split('\n').Select(line => line.Trim().Split(','))
                        .FirstOrDefault(parts => parts.Length >= 10 && int.TryParse(parts[0], out var value) && value == index);
                    if (row is null || row[4] != "1" || !uint.TryParse(row[6], out var pid) || pid == 0 ||
                        !long.TryParse(row[7], out var configuredWidth) || !long.TryParse(row[8], out var configuredHeight) ||
                        configuredWidth * configuredHeight != (long)width * height) continue;
                    library = NativeLibrary.Load(libraryPath);
                    var create = Marshal.GetDelegateForFunctionPointer<Create>(NativeLibrary.GetExport(library, "CreateScreenShotInstance"));
                    var instance = create((uint)index, pid);
                    if (instance == 0) { NativeLibrary.Free(library); library = 0; continue; }
                    var backend = new LdPlayerScreenCapture(library, instance, (int)configuredWidth, (int)configuredHeight);
                    // The native texture can retain portrait dimensions while
                    // Android's screen is landscape. Validate both colors and
                    // orientation against the first full-resolution ADB frame.
                    if (backend.MatchOrientation(reference)) return backend;
                    backend.Dispose();
                    library = 0;
                }
                catch (Exception ex) when (ex is not AccessViolationException)
                {
                    if (library != 0) NativeLibrary.Free(library);
                }
            }
        }
        return null;
    }

    bool MatchOrientation(Bitmap reference)
    {
        using var native = Capture();
        if (native is null) return false;
        var best = double.MaxValue;
        var bestOrientation = RotateFlipType.RotateNoneFlipNone;
        foreach (var rotation in new[] { RotateFlipType.RotateNoneFlipNone, RotateFlipType.Rotate90FlipNone,
                     RotateFlipType.Rotate180FlipNone, RotateFlipType.Rotate270FlipNone })
        {
            using var candidate = new Bitmap(native);
            candidate.RotateFlip(rotation);
            if (candidate.Size != reference.Size) continue;
            double difference = 0;
            var count = 0;
            for (var y = 0; y < reference.Height; y += 32)
                for (var x = 0; x < reference.Width; x += 32)
                {
                    var a = reference.GetPixel(x, y);
                    var b = candidate.GetPixel(x, y);
                    difference += Math.Abs(a.R - b.R) + Math.Abs(a.G - b.G) + Math.Abs(a.B - b.B);
                    count += 3;
                }
            var score = difference / count;
            if (score < best) { best = score; bestOrientation = rotation; }
        }
        if (best > 15) return false;
        orientation = bestOrientation;
        return true;
    }

    public Bitmap? Capture()
    {
        if (instance == 0) return null;
        var pixels = capture(instance);
        if (pixels == 0) return null;
        var image = new Bitmap(width, height, PixelFormat.Format24bppRgb);
        try
        {
            var data = image.LockBits(new Rectangle(0, 0, width, height), ImageLockMode.WriteOnly, PixelFormat.Format24bppRgb);
            try
            {
                var row = System.Buffers.ArrayPool<byte>.Shared.Rent(width * 3);
                try
                {
                    for (var y = 0; y < height; y++)
                    {
                        Marshal.Copy(pixels + (height - 1 - y) * width * 3, row, 0, width * 3);
                        Marshal.Copy(row, 0, data.Scan0 + y * data.Stride, width * 3);
                    }
                }
                finally { System.Buffers.ArrayPool<byte>.Shared.Return(row); }
            }
            finally { image.UnlockBits(data); }
            image.RotateFlip(orientation);
            return image;
        }
        catch { image.Dispose(); throw; }
    }

    public void Dispose()
    {
        if (instance != 0) { release(instance); instance = 0; }
        if (library != 0) { NativeLibrary.Free(library); library = 0; }
    }
}
