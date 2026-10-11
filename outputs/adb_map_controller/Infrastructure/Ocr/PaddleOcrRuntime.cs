using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;

namespace AdbMapController;

/// <summary>
/// Loads PaddleOCR from an ASCII path. Prefer the runtime bundled with the
/// application, using its Windows short path when the install path is
/// localized. A process-private staging directory is the fallback when short
/// paths are unavailable.
/// </summary>
internal static class PaddleOcrRuntime
{
    const string RuntimeDirectoryName = "AdbMapController-PaddleOCR-runtime-v5";
    static readonly object SyncRoot = new();
    static bool initialized;
    static string? modelsRoot;

    [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true, ExactSpelling = true)]
    static extern uint GetShortPathName(string longPath, StringBuilder shortPath, uint bufferLength);

    public static void Initialize()
    {
        lock (SyncRoot)
        {
            if (initialized) return;

            var runtimeRoot = ResolveAsciiRuntimeRoot();
            if (runtimeRoot is null)
                throw new DirectoryNotFoundException("PaddleOCR 运行时目录缺失或不完整");

            var nativeRoot = Path.Combine(runtimeRoot, "native");
            Directory.SetCurrentDirectory(runtimeRoot);
            var sdkPath = Path.Combine(runtimeRoot, "PaddleOCRSDK.dll");
            if (!File.Exists(sdkPath) || !Directory.Exists(nativeRoot))
                throw new DirectoryNotFoundException($"PaddleOCR SDK 或本机库目录缺失：{runtimeRoot}");

            var sdkAssembly = AppDomain.CurrentDomain.GetAssemblies()
                .FirstOrDefault(assembly => string.Equals(
                    assembly.GetName().Name,
                    "PaddleOCRSDK",
                    StringComparison.OrdinalIgnoreCase))
                ?? Assembly.LoadFrom(sdkPath);

            NativeLibrary.SetDllImportResolver(
                sdkAssembly,
                (libraryName, _, _) => LoadPaddleNativeLibrary(nativeRoot, libraryName));
            var bundledModelsRoot = Path.Combine(runtimeRoot, "paddle-models");
            modelsRoot = Directory.Exists(bundledModelsRoot)
                ? bundledModelsRoot
                : Path.Combine(runtimeRoot, "models");
            if (!Directory.Exists(modelsRoot))
                throw new DirectoryNotFoundException($"PaddleOCR 模型目录缺失：{modelsRoot}");
            initialized = true;
        }
    }

    public static string GetModelsRoot()
    {
        Initialize();
        return modelsRoot!;
    }

    static string? ResolveAsciiRuntimeRoot()
    {
        var bundledRoot = Path.Combine(AppContext.BaseDirectory, "PaddleOCR");
        var bundledSdkPath = Path.Combine(bundledRoot, "PaddleOCRSDK.dll");
        var bundledNativeRoot = Path.Combine(bundledRoot, "native");
        var bundledModelsRoot = Path.Combine(bundledRoot, "paddle-models");
        if (!File.Exists(bundledSdkPath)
            || !Directory.Exists(bundledNativeRoot)
            || !Directory.Exists(bundledModelsRoot))
            return null;

        if (IsAsciiPath(bundledRoot)) return bundledRoot;

        var shortPath = TryGetAsciiShortPath(bundledRoot);
        if (shortPath is not null) return shortPath;

        var tempRoot = Path.GetTempPath().TrimEnd(
            Path.DirectorySeparatorChar,
            Path.AltDirectorySeparatorChar);
        if (!IsAsciiPath(tempRoot))
            throw new InvalidOperationException(
                $"PaddleOCR 需要 ASCII 临时目录，但系统临时目录包含非 ASCII 字符：{tempRoot}");

        // Never overwrite a staged DLL: another controller may have it loaded.
        // Per-process roots also make simultaneous first launches independent.
        var runtimeRoot = Path.Combine(
            tempRoot,
            $"{RuntimeDirectoryName}-{Environment.ProcessId}-{Guid.NewGuid():N}");
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

    static string? TryGetAsciiShortPath(string path)
    {
        var capacity = 512;
        while (capacity <= 32768)
        {
            var buffer = new StringBuilder(capacity);
            var length = GetShortPathName(path, buffer, (uint)buffer.Capacity);
            if (length == 0) return null;
            if (length < buffer.Capacity)
            {
                var shortPath = buffer.ToString();
                return IsAsciiPath(shortPath) && Directory.Exists(shortPath) ? shortPath : null;
            }
            capacity = checked((int)length + 1);
        }
        return null;
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
