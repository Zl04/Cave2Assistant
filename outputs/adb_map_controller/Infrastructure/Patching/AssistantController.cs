using System.Text;

namespace AdbMapController;

/// <summary>
/// Owns discovery, inspection, installation and restoration of the device-side
/// Lua assistant. Raw ADB process and Root shell details stay in the transport.
/// </summary>
internal sealed class AssistantController(AdbCommandTransport transport)
{
    const string Root = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline";
    const string TestPanelCommandPath = Root + "/codex_test_panel.command";
    const string TestPanelCommandTempPath = TestPanelCommandPath + ".tmp";
    const string TestPanelResultPath = Root + "/codex_test_panel.result";

    public async Task<AdbClient.AssistantStatus> GetStatusAsync(string templateFile)
    {
        var target = await FindTargetAsync();
        var currentBytes = await ReadRootBinaryAsync(target);
        var current = Sha256(currentBytes);
        var backup = await RemoteFileExistsAsync(target + ".codex_original.bak");
        var sourceAvailable = LuaAssistantPatcher.TryDecodeSource(currentBytes, out var source, out var format);
        var installed = sourceAvailable && LuaAssistantPatcher.IsPatchedSource(source);
        var testPanelSupported = sourceAvailable && LuaAssistantPatcher.SupportsTestPanelCommand(source);
        var templateHash = File.Exists(templateFile) ? Sha256(await File.ReadAllBytesAsync(templateFile)) : "";
        return new(target, current, templateHash, installed, backup, format, testPanelSupported);
    }

    public Task RequestOpenTestPanelAsync()
        => transport.RunRootAsync($"set -e; rm -f '{TestPanelCommandPath}' '{TestPanelCommandPath}.processing' '{TestPanelResultPath}'; printf '%s' 'open_test_panel' > '{TestPanelCommandTempPath}'; mv -f '{TestPanelCommandTempPath}' '{TestPanelCommandPath}'");

    public async Task<AdbClient.AssistantStatus> InstallAsync(string templateFile)
    {
        if (!File.Exists(templateFile))
            throw new FileNotFoundException("地图助手模板缺失，请重新发布或修复程序安装目录", templateFile);
        var target = await FindTargetAsync();
        var currentBytes = await ReadRootBinaryAsync(target);
        var hasBackup = await RemoteFileExistsAsync(target + ".codex_original.bak");
        var currentIsSource = LuaAssistantPatcher.TryDecodeSource(currentBytes, out var currentSource, out var currentFormat);
        var currentIsPatched = currentIsSource && LuaAssistantPatcher.IsPatchedSource(currentSource);
        var baseBytes = currentBytes;
        var refreshBackup = false;

        if (currentIsPatched || currentSource.Contains("codexExportCurrentMap", StringComparison.Ordinal))
        {
            if (!hasBackup) throw new InvalidOperationException("设备上已有旧版地图助手，但没有原版备份，未覆盖游戏文件");
            baseBytes = await ReadRootBinaryAsync(target + ".codex_original.bak");
        }
        else if (currentIsSource)
        {
            refreshBackup = true;
        }
        else if (hasBackup)
        {
            baseBytes = await ReadRootBinaryAsync(target + ".codex_original.bak");
        }
        else
        {
            throw new InvalidDataException($"设备脚本解密后不是 Lua 源码（{currentFormat}），且没有可恢复的原版备份");
        }

        var template = await File.ReadAllTextAsync(templateFile, Encoding.UTF8);
        var patched = LuaAssistantPatcher.BuildEncryptedPatch(baseBytes, template);
        await WriteRootBinaryAsync("/data/local/tmp/codex_minimap_patch.luac", patched);
        try
        {
            await transport.RunRootAsync($"set -e; if [ '{(refreshBackup ? "yes" : "no")}' = 'yes' ]; then cp -p '{target}' '{target}.codex_original.bak'; fi; cat '/data/local/tmp/codex_minimap_patch.luac' > '{target}'; chmod 600 '{target}'; rm -f '/data/local/tmp/codex_minimap_patch.luac'");
        }
        finally
        {
            try { await transport.RunRootAsync("rm -f '/data/local/tmp/codex_minimap_patch.luac'"); } catch { }
        }
        var result = await GetStatusAsync(templateFile);
        if (!result.Installed) throw new IOException($"写入后未检测到源码注入标记（载荷格式：{result.Format}）");
        return result;
    }

    public async Task<AdbClient.AssistantStatus> RestoreAsync(string templateFile)
    {
        var target = await FindTargetAsync();
        var backupPath = target + ".codex_original.bak";
        if (!await RemoteFileExistsAsync(backupPath)) throw new FileNotFoundException("设备端没有原版备份，未执行恢复");
        var backupBytes = await ReadRootBinaryAsync(backupPath);
        if (!LuaAssistantPatcher.TryDecodeSource(backupBytes, out _, out var format))
            throw new InvalidDataException($"设备端备份不是 Lua 源码（{format}），未执行恢复");
        await WriteRootBinaryAsync(target, backupBytes);
        return await GetStatusAsync(templateFile);
    }

    async Task<string> FindTargetAsync()
    {
        var expected = $"{Root}/Hotfix/src/app/ui/minimap/MiniMapDrawer.luac";
        var output = await transport.RunRootAsync($"if [ -f '{expected}' ]; then printf '%s\n' '{expected}'; else find '{Root}' -type f -name 'MiniMapDrawer.luac' -print; fi");
        var path = output.Split(['\r', '\n'], StringSplitOptions.RemoveEmptyEntries).FirstOrDefault()?.Trim() ?? "";
        if (string.IsNullOrWhiteSpace(path)) throw new FileNotFoundException("设备中未找到 MiniMapDrawer.luac，请先启动游戏并完成资源更新");
        return path;
    }

    async Task<byte[]> ReadRootBinaryAsync(string path)
    {
        var token = Guid.NewGuid().ToString("N");
        var remote = $"/data/local/tmp/codex_read_{token}.luac";
        var local = Path.Combine(Path.GetTempPath(), $"codex-read-{token}.luac");
        try
        {
            await transport.RunRootAsync($"set -e; cp '{path}' '{remote}'; chmod 644 '{remote}'");
            await transport.RunAsync("pull", remote, local);
            return await File.ReadAllBytesAsync(local);
        }
        finally
        {
            try { await transport.RunRootAsync($"rm -f '{remote}'"); } catch { }
            try { File.Delete(local); } catch { }
        }
    }

    async Task WriteRootBinaryAsync(string path, byte[] bytes)
    {
        var token = Guid.NewGuid().ToString("N");
        var remote = $"/data/local/tmp/codex_write_{token}.luac";
        var local = Path.Combine(Path.GetTempPath(), $"codex-write-{token}.luac");
        try
        {
            await File.WriteAllBytesAsync(local, bytes);
            await transport.RunAsync("push", local, remote);
            await transport.RunRootAsync($"set -e; cat '{remote}' > '{path}'; chmod 600 '{path}'");
        }
        finally
        {
            try { await transport.RunRootAsync($"rm -f '{remote}'"); } catch { }
            try { File.Delete(local); } catch { }
        }
    }

    async Task<bool> RemoteFileExistsAsync(string path)
        => (await transport.RunRootAsync($"if [ -f '{path}' ]; then echo yes; else echo no; fi")).Trim() == "yes";

    static string Sha256(byte[] bytes)
        => Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(bytes)).ToLowerInvariant();
}
