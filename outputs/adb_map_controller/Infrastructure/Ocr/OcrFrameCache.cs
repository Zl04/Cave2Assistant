namespace AdbMapController;

/// <summary>Retains only the last successful OCR input and its result.</summary>
internal sealed class OcrFrameCache
{
    byte[]? image;
    PaddleOcrRecognition? recognition;

    // Called under the OCR engine's gate, including updates after inference.
    public PaddleOcrRecognition? Find(byte[] candidate)
        => image is not null && candidate.AsSpan().SequenceEqual(image) ? recognition : null;

    public void Store(byte[] candidate, PaddleOcrRecognition result)
    {
        image = candidate;
        recognition = result;
    }

    public void Clear()
    {
        image = null;
        recognition = null;
    }
}
