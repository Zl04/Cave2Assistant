using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;

namespace AdbMapController;

/// <summary>
/// Stages the bundled PaddleOCR runtime in an ASCII-only working directory.
/// The native SDK rejects the resolved physical path when the application is
/// installed below a localized directory. The application still ships the
/// SDK and models under PaddleOCR; only the native SDK's working copy is
/// staged for compatibility.
/// </summary>
internal static class PaddleOcrRuntime
{
    const string RuntimeDirectoryName = "AdbMapController-PaddleOCR-runtime-v4";
    static readonly object SyncRoot = new();
    static bool initialized;

    public static void Initialize()
    {
        lock (SyncRoot)
        {
            if (initialized) return;
            initialized = true;

            var runtimeRoot = PrepareAsciiRuntimeRoot();
            if (runtimeRoot is null) return;

            // All paths passed to PaddleOCRSDK, including the native DLL path
            // handled by the resolver, are relative to this ASCII root.
            Directory.SetCurrentDirectory(runtimeRoot);
            const string sdkPath = "PaddleOCRSDK.dll";
            const string nativeRoot = ".";
            if (!File.Exists(sdkPath) || !Directory.Exists(nativeRoot)) return;

            var sdkAssembly = AppDomain.CurrentDomain.GetAssemblies()
                .FirstOrDefault(assembly => string.Equals(
                    assembly.GetName().Name,
                    "PaddleOCRSDK",
                    StringComparison.OrdinalIgnoreCase))
                ?? Assembly.LoadFrom(sdkPath);

            NativeLibrary.SetDllImportResolver(
                sdkAssembly,
                (libraryName, _, _) => LoadPaddleNativeLibrary(nativeRoot, libraryName));
        }
    }

    static string? PrepareAsciiRuntimeRoot()
    {
        var bundledRoot = Path.Combine(AppContext.BaseDirectory, "PaddleOCR");
        var bundledSdkPath = Path.Combine(bundledRoot, "PaddleOCRSDK.dll");
        var bundledNativeRoot = Path.Combine(bundledRoot, "native");
        var bundledModelsRoot = Path.Combine(bundledRoot, "paddle-models");
        if (!File.Exists(bundledSdkPath)
            || !Directory.Exists(bundledNativeRoot)
            || !Directory.Exists(bundledModelsRoot))
            return null;

        var tempRoot = Path.GetTempPath().TrimEnd(
            Path.DirectorySeparatorChar,
            Path.AltDirectorySeparatorChar);
        if (!IsAsciiPath(tempRoot))
            throw new InvalidOperationException(
                $"PaddleOCR 需要 ASCII 临时目录，但系统临时目录包含非 ASCII 字符：{tempRoot}");

        var runtimeRoot = Path.Combine(tempRoot, RuntimeDirectoryName);
        Directory.CreateDirectory(runtimeRoot);
        File.Copy(
            bundledSdkPath,
            Path.Combine(runtimeRoot, "PaddleOCRSDK.dll"),
            overwrite: true);
        MirrorDirectory(
            bundledNativeRoot,
            runtimeRoot);
        MirrorDirectory(
            bundledModelsRoot,
            Path.Combine(runtimeRoot, "models"));
        return runtimeRoot;
    }

    static void MirrorDirectory(string sourceRoot, string destinationRoot)
    {
        foreach (var sourceFile in Directory.EnumerateFiles(sourceRoot, "*", SearchOption.AllDirectories))
        {
            var relativePath = Path.GetRelativePath(sourceRoot, sourceFile);
            var destinationFile = Path.Combine(destinationRoot, relativePath);
            var destinationDirectory = Path.GetDirectoryName(destinationFile);
            if (!string.IsNullOrEmpty(destinationDirectory))
                Directory.CreateDirectory(destinationDirectory);

            var sourceInfo = new FileInfo(sourceFile);
            var destinationInfo = new FileInfo(destinationFile);
            if (!destinationInfo.Exists
                || destinationInfo.Length != sourceInfo.Length
                || sourceInfo.LastWriteTimeUtc > destinationInfo.LastWriteTimeUtc)
            {
                File.Copy(sourceFile, destinationFile, overwrite: true);
            }
        }
    }

    static bool IsAsciiPath(string path) => path.All(character => character <= 0x7f);

    static nint LoadPaddleNativeLibrary(string nativeRoot, string libraryName)
    {
        var simpleName = Path.GetFileNameWithoutExtension(libraryName);
        if (!string.Equals(simpleName, "PaddleOCR", StringComparison.OrdinalIgnoreCase))
            return nint.Zero;

        var path = Path.Combine(nativeRoot, "PaddleOCR.dll");
        return File.Exists(path) ? NativeLibrary.Load(path) : nint.Zero;
    }
}
