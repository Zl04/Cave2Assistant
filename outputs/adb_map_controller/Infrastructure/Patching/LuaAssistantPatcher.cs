using System;
using System.IO;
using System.Text;

namespace AdbMapController;

/// <summary>
/// 根据游戏当前加密的 Lua 源码构建辅助程序。
/// 游戏热更新加载器解密后得到文本，因此即使桌面 luac 字节码是有效的 Lua 5.2，
/// 这里也明确禁止生成该字节码。
/// </summary>
public static class LuaAssistantPatcher
{
    public const string HelperBegin = "-- CODEX_MAP_HELPER_BEGIN";
    public const string HelperEnd = "-- CODEX_MAP_HELPER_END";
    public const string TestPanelCommandBegin = "-- CODEX_TEST_PANEL_COMMAND_BEGIN";
    public const string TestPanelCommandEnd = "-- CODEX_TEST_PANEL_COMMAND_END";
    public const string SchedulersBegin = "-- CODEX_MAP_SCHEDULERS_BEGIN";
    public const string SchedulersEnd = "-- CODEX_MAP_SCHEDULERS_END";
    public const string CleanupBegin = "-- CODEX_MAP_CLEANUP_BEGIN";
    public const string CleanupEnd = "-- CODEX_MAP_CLEANUP_END";

    static readonly byte[] Signature = Encoding.ASCII.GetBytes("svednolava");
    static readonly byte[] Key = Encoding.ASCII.GetBytes("8102enilnOevac");
    static readonly UTF8Encoding StrictUtf8 = new(false, true);
    const uint Delta = 0x9E3779B9;

    public static bool IsPatchedSource(string source) =>
        source.Contains(HelperBegin, StringComparison.Ordinal) &&
        source.Contains(HelperEnd, StringComparison.Ordinal) &&
        source.Contains(SchedulersBegin, StringComparison.Ordinal) &&
        source.Contains(SchedulersEnd, StringComparison.Ordinal) &&
        source.Contains(CleanupBegin, StringComparison.Ordinal) &&
        source.Contains(CleanupEnd, StringComparison.Ordinal);

    public static bool SupportsTestPanelCommand(string source) =>
        source.Contains(TestPanelCommandBegin, StringComparison.Ordinal) &&
        source.Contains(TestPanelCommandEnd, StringComparison.Ordinal);

    public static bool TryDecodeSource(byte[] encrypted, out string source, out string format)
    {
        try
        {
            var payload = DecryptPayload(encrypted);
            if (payload.Length >= 4 && payload[0] == 0x1B && payload[1] == (byte)'L' &&
                payload[2] == (byte)'u' && payload[3] == (byte)'a')
            {
                source = "";
                format = "Lua字节码（游戏热更加载器不兼容）";
                return false;
            }
            source = StrictUtf8.GetString(payload);
            if (!source.Contains("function MiniMapDrawer:ctor()", StringComparison.Ordinal))
            {
                source = "";
                format = "文本载荷，但不是 MiniMapDrawer 源码";
                return false;
            }
            format = "加密Lua源码";
            return true;
        }
        catch (Exception ex)
        {
            source = "";
            format = $"无法解密：{ex.Message}";
            return false;
        }
    }

    public static string DecodeSource(byte[] encrypted)
    {
        if (TryDecodeSource(encrypted, out var source, out var format)) return source;
        throw new InvalidDataException($"设备脚本不是可注入的游戏 Lua 源码：{format}");
    }

    public static byte[] BuildEncryptedPatch(byte[] encryptedGameFile, string template)
    {
        var gameSource = DecodeSource(encryptedGameFile);
        if (IsPatchedSource(gameSource))
            throw new InvalidOperationException("输入已经包含地图助手，必须使用设备端原版备份作为注入基线");
        if (gameSource.Contains("codexExportCurrentMap", StringComparison.Ordinal))
            throw new InvalidOperationException("检测到无法安全识别的旧版注入，未覆盖游戏文件");

        var newline = gameSource.Contains("\r\n", StringComparison.Ordinal) ? "\r\n" : "\n";
        var helper = NormalizeNewlines(ExtractBlock(template, HelperBegin, HelperEnd), newline);
        var schedulers = NormalizeNewlines(ExtractBlock(template, SchedulersBegin, SchedulersEnd), newline);
        var cleanup = NormalizeNewlines(ExtractBlock(template, CleanupBegin, CleanupEnd), newline);

        var patched = InsertBeforeUnique(gameSource, "function MiniMapDrawer:ctor()", helper + newline);
        patched = InsertAfterUnique(patched, "    self:init()", newline + schedulers);
        patched = InsertAfterUnique(patched, "function MiniMapDrawer:dtor()", newline + cleanup);

        if (!IsPatchedSource(patched))
            throw new InvalidOperationException("注入结果未通过完整性检查，未覆盖游戏文件");
        return EncryptSource(patched);
    }

    public static byte[] EncryptSource(string source)
    {
        var payload = StrictUtf8.GetBytes(source);
        var encrypted = XxteaEncrypt(payload, Key);
        var result = new byte[Signature.Length + encrypted.Length];
        Buffer.BlockCopy(Signature, 0, result, 0, Signature.Length);
        Buffer.BlockCopy(encrypted, 0, result, Signature.Length, encrypted.Length);
        return result;
    }

    public static byte[] DecryptPayload(byte[] encrypted)
    {
        if (encrypted.Length <= Signature.Length || !encrypted.AsSpan(0, Signature.Length).SequenceEqual(Signature))
            throw new InvalidDataException("缺少游戏 Lua 加密签名 svednolava");
        return XxteaDecrypt(encrypted.AsSpan(Signature.Length).ToArray(), Key);
    }

    static string ExtractBlock(string template, string begin, string end)
    {
        var start = UniqueIndexOf(template, begin);
        var finish = UniqueIndexOf(template, end);
        if (finish < start) throw new InvalidDataException($"注入模板标记顺序错误：{begin}");
        return template[start..(finish + end.Length)];
    }

    static string InsertBeforeUnique(string source, string anchor, string value)
    {
        var index = UniqueIndexOf(source, anchor);
        return source.Insert(index, value);
    }

    static string InsertAfterUnique(string source, string anchor, string value)
    {
        var index = UniqueIndexOf(source, anchor) + anchor.Length;
        return source.Insert(index, value);
    }

    static int UniqueIndexOf(string source, string value)
    {
        var index = source.IndexOf(value, StringComparison.Ordinal);
        if (index < 0) throw new InvalidDataException($"未找到唯一注入锚点：{value}");
        if (source.IndexOf(value, index + value.Length, StringComparison.Ordinal) >= 0)
            throw new InvalidDataException($"注入锚点出现多次：{value}");
        return index;
    }

    static string NormalizeNewlines(string value, string newline) =>
        value.Replace("\r\n", "\n", StringComparison.Ordinal)
            .Replace("\r", "\n", StringComparison.Ordinal)
            .Replace("\n", newline, StringComparison.Ordinal);

    static byte[] XxteaEncrypt(byte[] data, byte[] keyBytes)
    {
        var values = ToUInt32Array(data, includeLength: true);
        if (values.Length < 2) return data;
        var key = ToKey(keyBytes);
        var n = values.Length - 1;
        var rounds = 6 + 52 / (n + 1);
        uint sum = 0;
        var z = values[n];
        unchecked
        {
            while (rounds-- > 0)
            {
                sum += Delta;
                var e = (sum >> 2) & 3;
                for (var p = 0; p < n; p++)
                {
                    var y = values[p + 1];
                    values[p] += Mx(sum, y, z, p, e, key);
                    z = values[p];
                }
                var first = values[0];
                values[n] += Mx(sum, first, z, n, e, key);
                z = values[n];
            }
        }
        return ToByteArray(values, includeLength: false);
    }

    static byte[] XxteaDecrypt(byte[] data, byte[] keyBytes)
    {
        var values = ToUInt32Array(data, includeLength: false);
        if (values.Length < 2) return data;
        var key = ToKey(keyBytes);
        var n = values.Length - 1;
        var rounds = 6 + 52 / (n + 1);
        uint sum = unchecked((uint)(rounds * Delta));
        var y = values[0];
        unchecked
        {
            while (sum != 0)
            {
                var e = (sum >> 2) & 3;
                for (var p = n; p > 0; p--)
                {
                    var z = values[p - 1];
                    values[p] -= Mx(sum, y, z, p, e, key);
                    y = values[p];
                }
                var last = values[n];
                values[0] -= Mx(sum, y, last, 0, e, key);
                y = values[0];
                sum -= Delta;
            }
        }
        return ToByteArray(values, includeLength: true);
    }

    static uint Mx(uint sum, uint y, uint z, int p, uint e, uint[] key) => unchecked(
        (((z >> 5) ^ (y << 2)) + ((y >> 3) ^ (z << 4))) ^
        ((sum ^ y) + (key[(p & 3) ^ (int)e] ^ z)));

    static uint[] ToKey(byte[] keyBytes)
    {
        var padded = new byte[16];
        Buffer.BlockCopy(keyBytes, 0, padded, 0, Math.Min(keyBytes.Length, padded.Length));
        return ToUInt32Array(padded, includeLength: false);
    }

    static uint[] ToUInt32Array(byte[] data, bool includeLength)
    {
        var wordCount = (data.Length + 3) / 4;
        var result = new uint[wordCount + (includeLength ? 1 : 0)];
        for (var i = 0; i < data.Length; i++)
            result[i >> 2] |= (uint)data[i] << ((i & 3) << 3);
        if (includeLength) result[wordCount] = (uint)data.Length;
        return result;
    }

    static byte[] ToByteArray(uint[] values, bool includeLength)
    {
        var maximum = includeLength ? (values.Length - 1) * 4 : values.Length * 4;
        var length = maximum;
        if (includeLength)
        {
            var declared = values[^1];
            if (declared < maximum - 3 || declared > maximum)
                throw new InvalidDataException("XXTEA 载荷长度无效");
            length = (int)declared;
        }
        var result = new byte[length];
        for (var i = 0; i < length; i++)
            result[i] = (byte)(values[i >> 2] >> ((i & 3) << 3));
        return result;
    }
}
