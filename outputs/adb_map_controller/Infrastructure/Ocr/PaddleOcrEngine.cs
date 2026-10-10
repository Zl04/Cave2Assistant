using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using PaddleOCRSDK;

namespace AdbMapController;

/// <summary>
/// In-process PaddleOCR adapter. The NuGet SDK calls the native PaddleOCR
/// runtime directly; there is deliberately no Python process or pipe protocol.
/// </summary>
public sealed class PaddleOcrEngine : IDisposable
{
    const string DetectionModel = "PP-OCRv5_mobile_det_infer";
    const string RecognitionModel = "PP-OCRv5_mobile_rec_infer";
    const string OrientationModel = "PP-LCNet_x1_0_textline_ori";

    readonly string modelsPath;
    readonly SemaphoreSlim gate = new(1, 1);
    readonly OcrFrameCache frameCache = new();
    OCRService? service;
    int disposed;

    public PaddleOcrEngine(string? modelsPath = null)
    {
        PaddleOcrRuntime.Initialize();
        this.modelsPath = modelsPath ?? ResolveDefaultModelsPath();
    }

    static string ResolveDefaultModelsPath()
        => "models";

    public async Task<PaddleOcrRecognition> RecognizeAsync(
        Bitmap image,
        CancellationToken token = default)
    {
        if (image is null) throw new ArgumentNullException(nameof(image));
        ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
        token.ThrowIfCancellationRequested();

        using var copy = new Bitmap(image);
        using var encoded = new MemoryStream();
        copy.Save(encoded, ImageFormat.Png);
        var imageBytes = encoded.ToArray();

        await gate.WaitAsync(token).ConfigureAwait(false);
        try
        {
            ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
            token.ThrowIfCancellationRequested();
            if (frameCache.Find(imageBytes) is { } cached) return cached;
            // OCRService.Detect is synchronous and enters native inference. Keep
            // it off the WinForms synchronization context while preserving the
            // single-engine guarantee required by the native runtime.
            var result = await Task.Run(() => RecognizeCore(imageBytes), CancellationToken.None)
                .ConfigureAwait(false);
            frameCache.Store(imageBytes, result);
            return result;
        }
        finally { gate.Release(); }
    }

    PaddleOcrRecognition RecognizeCore(byte[] imageBytes)
    {
        EnsureInitialized();
        var result = service!.Detect(imageBytes);
        if (result.Code == 0)
            throw new InvalidOperationException(
                string.IsNullOrWhiteSpace(result.ErrorMsg)
                    ? "PaddleOCR 识别失败"
                    : result.ErrorMsg);

        var words = result.WordsResult
            .Where(item => !string.IsNullOrWhiteSpace(item.Words))
            .Select(item => ToWord(item))
            .Where(item => item is not null)
            .Select(item => item!)
            .ToArray();
        var text = string.Join("\n", result.WordsResult
            .Select(item => item.Words?.Trim())
            .Where(item => !string.IsNullOrWhiteSpace(item)));
        return new PaddleOcrRecognition(text, words);
    }

    void EnsureInitialized()
    {
        ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
        if (service is not null) return;

        // Keep the paths passed to the native SDK relative to the published
        // application directory. The entry point sets that directory before
        // initializing OCR, so localized installation paths never reach the
        // PaddleOCR model loader.
        var modelRoot = modelsPath;
        // The SDK's own helper builds model paths with '/', so keep the same
        // relative spelling instead of letting Windows expand it first.
        var detectionPath = $"{modelRoot}/{DetectionModel}";
        var recognitionPath = $"{modelRoot}/{RecognitionModel}";
        var orientationPath = $"{modelRoot}/{OrientationModel}";
        var missing = new[]
        {
            (Path: detectionPath, Name: DetectionModel),
            (Path: recognitionPath, Name: RecognitionModel),
            (Path: orientationPath, Name: OrientationModel),
        }.Where(item => !Directory.Exists(item.Path)).Select(item => item.Name).ToArray();
        if (missing.Length > 0)
            throw new DirectoryNotFoundException(
                $"PaddleOCR 模型目录缺失：{string.Join("、", missing)}；模型根目录：{modelsPath}");

        var candidate = new OCRService();
        candidate.EnableLog(false);
        candidate.EnableASCIIResult(false);
        candidate.EnableJsonResult(true);

        var parameter = new InitParamater
        {
            det_infer = detectionPath,
            cls_infer = orientationPath,
            rec_infer = recognitionPath,
            paraType = EnumParaType.Class,
            ocrpara = new OCRParameter
            {
                det = true,
                rec = true,
                cls = false,
                use_gpu = false,
                use_tensorrt = false,
                cpu_mem = 0,
                cpu_threads = Math.Max(1, Environment.ProcessorCount),
                enable_mkldnn = true,
                max_side_len = 960,
                det_db_thresh = 0.20f,
                det_db_box_thresh = 0.35f,
                det_db_unclip_ratio = 1.6f,
                use_angle_cls = false,
                rec_batch_num = 6,
                rec_img_h = 48,
                rec_img_w = 320,
                visualize = false,
                return_word_box = false,
                ocr_instance_count = 1,
            },
        };

        try
        {
            if (!candidate.Init(parameter))
                throw new InvalidOperationException(candidate.GetError());
            service = candidate;
        }
        catch (Exception exception)
        {
            try { candidate.FreeEngine(); } catch { }
            throw new InvalidOperationException(
                $"PaddleOCR 初始化失败：实际模型目录={modelRoot}；" +
                $"检测={detectionPath}；方向={orientationPath}；识别={recognitionPath}；" +
                $"原始错误={exception.Message}", exception);
        }
    }

    static PaddleOcrWord? ToWord(JsonResult item)
    {
        var points = item.Location?
            .Where(point => point.x.HasValue && point.y.HasValue)
            .Select(point => (X: point.x!.Value, Y: point.y!.Value))
            .ToArray() ?? [];
        if (points.Length == 0) return null;

        var left = points.Min(point => point.X);
        var top = points.Min(point => point.Y);
        var right = points.Max(point => point.X);
        var bottom = points.Max(point => point.Y);
        if (right <= left || bottom <= top) return null;
        return new PaddleOcrWord(
            item.Words.Trim(),
            left,
            top,
            right - left,
            bottom - top,
            Math.Clamp((item.Score ?? 0) * 100d, 0, 100));
    }

    public void Dispose()
    {
        if (Interlocked.Exchange(ref disposed, 1) != 0) return;
        // Native inference cannot be interrupted. Close admission first, then
        // join the current invocation before freeing its engine. Keep the
        // managed semaphore valid for already queued callers to reject safely.
        gate.Wait();
        try { service?.FreeEngine(); }
        finally { service = null; frameCache.Clear(); gate.Release(); }
    }
}

public sealed record PaddleOcrRecognition(string Text, IReadOnlyList<PaddleOcrWord> Words);

public sealed record PaddleOcrWord(
    string Text,
    int Left,
    int Top,
    int Width,
    int Height,
    double Confidence);
