using System.Buffers.Binary;
using System.Buffers;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net.Sockets;
using System.Text;
using System.Runtime.InteropServices;
using System.Numerics;

namespace AdbMapController;

internal sealed class AdbScreenCapture : IDisposable
{
    const int MaxBytes = 64 * 1024 * 1024;
    readonly SemaphoreSlim captureLock = new(1, 1);
    readonly CancellationTokenSource lifetime = new();
    readonly string host;
    readonly int port, timeoutMs;
    int disposed;
    LdPlayerScreenCapture? nativeCapture;
    Task<LdPlayerScreenCapture?>? nativePreparation;
    string? nativeSerial;
    bool nativeAttempted;
    public Action<string>? TimingLog { get; set; }
    public AdbScreenCapture() : this("127.0.0.1", 5037, 5000) { }
    public AdbScreenCapture(string host, int port, int timeoutMs)
        => (this.host, this.port, this.timeoutMs) = (host, port, timeoutMs);

    public async Task<Bitmap> CaptureAsync(string serial, string errorMessage, CancellationToken token = default)
    {
        ObjectDisposedException.ThrowIf(Volatile.Read(ref disposed) != 0, this);
        using var cancellation = CancellationTokenSource.CreateLinkedTokenSource(token, lifetime.Token);
        var timer = Stopwatch.StartNew();
        await captureLock.WaitAsync(cancellation.Token).ConfigureAwait(false);
        var lockMs = timer.ElapsedMilliseconds;
        cancellation.CancelAfter(timeoutMs);
        try
        {
            if (nativeSerial != serial)
            {
                ClearNativeCapture();
                nativeAttempted = false;
                nativeSerial = serial;
            }
            if (nativePreparation is { IsCompleted: true })
            {
                nativeCapture = nativePreparation.GetAwaiter().GetResult();
                nativePreparation = null;
            }
            if (nativeCapture is not null)
            {
                var native = await Task.Run(() => nativeCapture.Capture(), cancellation.Token).ConfigureAwait(false);
                if (native is not null)
                {
                    if (cancellation.IsCancellationRequested)
                    {
                        native.Dispose();
                        cancellation.Token.ThrowIfCancellationRequested();
                    }
                    TimingLog?.Invoke($"截图方式=雷电专用接口，锁等待={lockMs}ms，取帧及像素复制={timer.ElapsedMilliseconds - lockMs}ms，尺寸={native.Width}x{native.Height}");
                    return native;
                }
                nativeCapture.Dispose();
                nativeCapture = null;
            }
            // Reuse the running server/device transport. Each shell-v2 service
            // ends with its command, so a completed socket cannot be reused.
            using var client = new TcpClient { NoDelay = true };
            await client.ConnectAsync(host, port, cancellation.Token).ConfigureAwait(false);
            using var stream = client.GetStream();
            await RequestAsync(stream, $"host:transport:{serial}", cancellation.Token).ConfigureAwait(false);
            await RequestAsync(stream, "shell,v2,raw:screencap", cancellation.Token).ConfigureAwait(false);
            var readyMs = timer.ElapsedMilliseconds;
            using var data = new MemoryStream();
            using var errors = new MemoryStream();
            var header = new byte[5];
            var buffer = ArrayPool<byte>.Shared.Rent(65536);
            long? firstByteMs = null;
            try
            {
            while (true)
            {
                await stream.ReadExactlyAsync(header, cancellation.Token).ConfigureAwait(false);
                var length = BinaryPrimitives.ReadUInt32LittleEndian(header.AsSpan(1));
                if (length > MaxBytes) throw new InvalidDataException("ADB 截图数据包过大");
                if (header[0] == 3)
                {
                    if (length != 1) throw new InvalidDataException("ADB 截图退出状态无效");
                    await stream.ReadExactlyAsync(buffer.AsMemory(0, 1), cancellation.Token).ConfigureAwait(false);
                    if (buffer[0] != 0)
                        throw new InvalidOperationException($"{errorMessage}：{Encoding.UTF8.GetString(errors.ToArray()).Trim()}（退出码 {buffer[0]}）");
                    break;
                }
                var destination = header[0] switch
                {
                    1 => data,
                    2 => errors,
                    _ => throw new InvalidDataException($"ADB 截图未知通道：{header[0]}")
                };
                if (destination.Length + length > (header[0] == 1 ? MaxBytes : 65536))
                    throw new InvalidDataException("ADB 截图数据超过大小上限");
                for (var remaining = (int)length; remaining > 0;)
                {
                    var count = Math.Min(remaining, buffer.Length);
                    await stream.ReadExactlyAsync(buffer.AsMemory(0, count), cancellation.Token).ConfigureAwait(false);
                    if (header[0] == 1) firstByteMs ??= timer.ElapsedMilliseconds;
                    destination.Write(buffer, 0, count);
                    remaining -= count;
                }
            }
            }
            finally { ArrayPool<byte>.Shared.Return(buffer); }
            var receivedMs = timer.ElapsedMilliseconds;
            if (data.Length == 0) throw new InvalidDataException($"{errorMessage}：ADB 返回了空截图");
            var result = DecodeRaw(data);
            if (!nativeAttempted && host == "127.0.0.1" && port == 5037)
            {
                nativeAttempted = true;
                var reference = new Bitmap(result);
                nativePreparation = Task.Run(() =>
                {
                    using (reference) return LdPlayerScreenCapture.TryCreate(serial, reference);
                });
            }
            TimingLog?.Invoke($"截图方式=ADB原始像素：锁等待={lockMs}ms，连接及请求={readyMs - lockMs}ms，首包等待={(firstByteMs ?? receivedMs) - readyMs}ms，剩余接收={receivedMs - (firstByteMs ?? receivedMs)}ms，像素转换及后端准备={timer.ElapsedMilliseconds - receivedMs}ms，字节={data.Length}");
            return result;
        }
        catch (OperationCanceledException) when (!token.IsCancellationRequested && !lifetime.IsCancellationRequested)
        {
            throw new TimeoutException($"ADB 截图超时（>{timeoutMs}ms），已关闭协议连接");
        }
        finally { captureLock.Release(); }
    }

    internal static Bitmap DecodeRaw(MemoryStream data)
    {
        if (data.Length < 12) throw new InvalidDataException("ADB 原始截图头不完整");
        var bytes = data.GetBuffer();
        var width = BinaryPrimitives.ReadInt32LittleEndian(bytes.AsSpan(0, 4));
        var height = BinaryPrimitives.ReadInt32LittleEndian(bytes.AsSpan(4, 4));
        var format = BinaryPrimitives.ReadInt32LittleEndian(bytes.AsSpan(8, 4));
        var bpp = format switch { 1 or 2 or 5 => 4, 3 => 3, 4 => 2, _ => throw new InvalidDataException($"ADB 原始像素格式不支持：{format}") };
        var pixels = (long)width * height * bpp;
        if (width <= 0 || height <= 0 || width > 16384 || height > 16384 || pixels > MaxBytes)
            throw new InvalidDataException("ADB 原始截图尺寸无效");
        var offset = data.Length - pixels;
        if (offset is not (12 or 16)) throw new InvalidDataException("ADB 原始截图像素长度无效");
        var image = new Bitmap(width, height, PixelFormat.Format32bppArgb);
        try
        {
            var locked = image.LockBits(new Rectangle(0, 0, width, height), ImageLockMode.WriteOnly, PixelFormat.Format32bppArgb);
            try
            {
                if (bpp == 4)
                {
                    var colors = MemoryMarshal.Cast<byte, uint>(bytes.AsSpan((int)offset, (int)pixels));
                    var i = 0;
                    if (format != 5)
                    {
                        var mask = new Vector<uint>(0xff00ff00);
                        var rb = new Vector<uint>(0x00ff00ff);
                        var alpha = new Vector<uint>(format == 2 ? 0xff000000 : 0);
                        for (; i <= colors.Length - Vector<uint>.Count; i += Vector<uint>.Count)
                        {
                            var v = new Vector<uint>(colors.Slice(i));
                            ((v & mask) | ((v & rb) << 16) | ((v >> 16) & new Vector<uint>(255)) | alpha).CopyTo(colors.Slice(i));
                        }
                        for (; i < colors.Length; i++)
                        {
                            var v = colors[i];
                            colors[i] = (v & 0xff00ff00) | ((v & 255) << 16) | ((v >> 16) & 255) | (format == 2 ? 0xff000000 : 0);
                        }
                    }
                    for (var y = 0; y < height; y++)
                        Marshal.Copy(bytes, (int)offset + y * width * 4, locked.Scan0 + y * locked.Stride, width * 4);
                }
                else
                {
                    var row = ArrayPool<byte>.Shared.Rent(width * 4);
                    try
                    {
                        for (var y = 0; y < height; y++)
                        {
                            for (var x = 0; x < width; x++)
                            {
                                var source = (int)offset + (y * width + x) * bpp;
                                var target = x * 4;
                                if (format == 3)
                                {
                                    row[target] = bytes[source + 2]; row[target + 1] = bytes[source + 1]; row[target + 2] = bytes[source];
                                }
                                else
                                {
                                    var v = BinaryPrimitives.ReadUInt16LittleEndian(bytes.AsSpan(source, 2));
                                    row[target] = (byte)((v & 31) * 255 / 31);
                                    row[target + 1] = (byte)(((v >> 5) & 63) * 255 / 63);
                                    row[target + 2] = (byte)((v >> 11) * 255 / 31);
                                }
                                row[target + 3] = 255;
                            }
                            Marshal.Copy(row, 0, locked.Scan0 + y * locked.Stride, width * 4);
                        }
                    }
                    finally { ArrayPool<byte>.Shared.Return(row); }
                }
            }
            finally { image.UnlockBits(locked); }
            return image;
        }
        catch { image.Dispose(); throw; }
    }

    static async Task RequestAsync(NetworkStream stream, string request, CancellationToken token)
    {
        var bytes = Encoding.UTF8.GetBytes(request);
        if (bytes.Length > 65535) throw new InvalidDataException("ADB 请求过长");
        await stream.WriteAsync(Encoding.ASCII.GetBytes(bytes.Length.ToString("X4")), token).ConfigureAwait(false);
        await stream.WriteAsync(bytes, token).ConfigureAwait(false);
        var status = new byte[4];
        await stream.ReadExactlyAsync(status, token).ConfigureAwait(false);
        var value = Encoding.ASCII.GetString(status);
        if (value == "OKAY") return;
        if (value != "FAIL") throw new InvalidDataException("ADB 协议状态无效");
        await stream.ReadExactlyAsync(status, token).ConfigureAwait(false);
        if (!int.TryParse(Encoding.ASCII.GetString(status), System.Globalization.NumberStyles.HexNumber, null, out var length))
            throw new InvalidDataException("ADB 错误长度无效");
        var error = new byte[length];
        await stream.ReadExactlyAsync(error, token).ConfigureAwait(false);
        throw new InvalidOperationException($"ADB 截图请求失败：{Encoding.UTF8.GetString(error)}");
    }

    public void Dispose()
    {
        if (Interlocked.Exchange(ref disposed, 1) != 0) return;
        lifetime.Cancel();
        captureLock.Wait();
        try { ClearNativeCapture(); }
        finally { captureLock.Release(); }
    }

    void ClearNativeCapture()
    {
        if (nativePreparation is not null)
        {
            nativePreparation.GetAwaiter().GetResult()?.Dispose();
            nativePreparation = null;
        }
        nativeCapture?.Dispose();
        nativeCapture = null;
    }
}
