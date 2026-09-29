using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Loader;

namespace AdbMapController;

/// <summary>
/// Loads OpenCvSharp from the self-contained OpenCV directory used by the
/// published application.
/// </summary>
internal static class OpenCvRuntime
{
    static readonly object SyncRoot = new();
    static bool initialized;

    public static void Initialize()
    {
        lock (SyncRoot)
        {
            if (initialized) return;
            initialized = true;

            var runtimeRoot = Path.Combine(AppContext.BaseDirectory, "OpenCV");
            var wrapperPath = Path.Combine(runtimeRoot, "OpenCvSharp.dll");
            var nativeRoot = Path.Combine(runtimeRoot, "native");
            if (!File.Exists(wrapperPath) || !Directory.Exists(nativeRoot)) return;

            var wrapperAssembly = AppDomain.CurrentDomain.GetAssemblies()
                .FirstOrDefault(assembly => string.Equals(
                    assembly.GetName().Name,
                    "OpenCvSharp",
                    StringComparison.OrdinalIgnoreCase))
                ?? AssemblyLoadContext.Default.LoadFromAssemblyPath(wrapperPath);

            NativeLibrary.SetDllImportResolver(
                wrapperAssembly,
                (libraryName, _, _) => LoadOpenCvNativeLibrary(nativeRoot, libraryName));
        }
    }

    static nint LoadOpenCvNativeLibrary(string nativeRoot, string libraryName)
    {
        var simpleName = Path.GetFileNameWithoutExtension(libraryName);
        if (!string.Equals(simpleName, "OpenCvSharpExtern", StringComparison.OrdinalIgnoreCase))
            return nint.Zero;

        var path = Path.Combine(nativeRoot, "OpenCvSharpExtern.dll");
        return File.Exists(path) ? NativeLibrary.Load(path) : nint.Zero;
    }
}
