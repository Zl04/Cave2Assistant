using System.Text.Json;
using System.Text.RegularExpressions;

var arguments = args.ToArray();
var transcript = Environment.GetEnvironmentVariable("ADB_FIXTURE_TRANSCRIPT");
if (transcript is not null)
    File.AppendAllText(transcript, JsonSerializer.Serialize(arguments) + Environment.NewLine);

var denied = Environment.GetEnvironmentVariable("ADB_FIXTURE_ROOT_DENIED") == "1";
if (arguments.Contains("exec-out", StringComparer.Ordinal)
    && arguments.Contains("screencap", StringComparer.Ordinal))
{
    var captureMode = Environment.GetEnvironmentVariable("ADB_FIXTURE_CAPTURE_MODE");
    if (captureMode == "hang") await Task.Delay(Timeout.Infinite);
    if (captureMode == "nonzero") { Console.Error.WriteLine("fixture capture failure"); return 7; }
    if (captureMode == "empty") return 0;
    if (captureMode == "bad-png")
    {
        await Console.OpenStandardOutput().WriteAsync("not a png"u8.ToArray());
        return 0;
    }
    var gatePath = Environment.GetEnvironmentVariable("ADB_FIXTURE_CAPTURE_GATE");
    while (gatePath is not null && !File.Exists(gatePath))
        await Task.Delay(10);
    var screenshotPath = Environment.GetEnvironmentVariable("ADB_FIXTURE_SCREENSHOT")
        ?? throw new InvalidOperationException("Missing ADB_FIXTURE_SCREENSHOT");
    var screenshot = await File.ReadAllBytesAsync(screenshotPath);
    await Console.OpenStandardOutput().WriteAsync(screenshot);
    return 0;
}
if (arguments.Contains("root", StringComparer.Ordinal))
{
    if (denied) { Console.Error.WriteLine("adbd cannot run as root in production builds"); return 1; }
    return 0;
}
if (Environment.GetEnvironmentVariable("ADB_FIXTURE_COMMAND_MODE") == "nonzero"
    && arguments.Contains("devices", StringComparer.Ordinal))
{
    Console.Error.WriteLine("fixture command failure");
    return 9;
}
if (arguments.Contains("wait-for-device", StringComparer.Ordinal)) return 0;
if (arguments.Contains("push", StringComparer.Ordinal))
{
    if (Environment.GetEnvironmentVariable("ADB_FIXTURE_FAIL_PUSH") == "1")
    {
        Console.Error.WriteLine("fixture push failure");
        return 12;
    }
    var source = arguments[^2];
    var destination = RemotePath(arguments[^1]);
    Directory.CreateDirectory(Path.GetDirectoryName(destination)!);
    File.Copy(source, destination, overwrite: true);
    return 0;
}
if (arguments.Contains("pull", StringComparer.Ordinal))
{
    if (Environment.GetEnvironmentVariable("ADB_FIXTURE_FAIL_PULL") == "1")
    {
        Console.Error.WriteLine("fixture pull failure");
        return 13;
    }
    var source = RemotePath(arguments[^2]);
    if (!File.Exists(source)) { Console.Error.WriteLine("fixture remote file missing"); return 1; }
    Directory.CreateDirectory(Path.GetDirectoryName(arguments[^1])!);
    File.Copy(source, arguments[^1], overwrite: true);
    return 0;
}
if (arguments.Contains("devices", StringComparer.Ordinal))
{
    Console.WriteLine("List of devices attached");
    Console.WriteLine("fixture-device\tdevice");
    return 0;
}
if (arguments.Contains("id", StringComparer.Ordinal))
{
    Console.WriteLine(denied ? "uid=2000(shell)" : "uid=0(root)");
    return 0;
}
if (arguments.Contains("shell", StringComparer.Ordinal) && arguments.LastOrDefault() == "sh")
{
    if (Environment.GetEnvironmentVariable("ADB_FIXTURE_ROOT_SHELL_MODE") == "close") return 0;
    string? pendingMarkerCommand = null;
    string? pendingShellCommand = null;
    var lastExitCode = 0;
    var playerStatus = Environment.GetEnvironmentVariable("ADB_FIXTURE_PLAYER_JSON_MODE") switch
    {
        "invalid" => Convert.ToBase64String("{bad-json"u8.ToArray()),
        "not-ready" => "__CODEX_DATA_NOT_READY__",
        _ => Convert.ToBase64String("""
        {"level":1,"width":1,"height":1,"fogBits":"1","sequence":7,"moveSpeed":1000,"player":{"x":8,"y":3}}
        """u8)
    };
    while (Console.ReadLine() is { } line)
    {
        if (transcript is not null)
            File.AppendAllText(transcript, JsonSerializer.Serialize(new[] { "stdin", line }) + Environment.NewLine);
        if (pendingMarkerCommand is not null)
        {
            pendingMarkerCommand += "\n" + line;
            if (!pendingMarkerCommand.EndsWith("' \"$__codex_status\"", StringComparison.Ordinal))
                continue;
            line = pendingMarkerCommand;
            pendingMarkerCommand = null;
        }
        else if (pendingShellCommand is not null)
        {
            line = pendingShellCommand + "\n" + line;
            pendingShellCommand = null;
        }
        else if (line.StartsWith("if [ -f '", StringComparison.Ordinal)
            && line.Contains("printf '%s", StringComparison.Ordinal)
            && !line.Contains("; else find ", StringComparison.Ordinal))
        {
            pendingShellCommand = line;
            continue;
        }
        else if (line.StartsWith("__codex_status=$?; printf '", StringComparison.Ordinal)
            && !line.EndsWith("' \"$__codex_status\"", StringComparison.Ordinal))
        {
            pendingMarkerCommand = line;
            continue;
        }
        if (line.Contains("codex_player_status.json", StringComparison.Ordinal))
        {
            Console.WriteLine(playerStatus);
            Console.Out.Flush();
        }
        else if (!line.StartsWith("__codex_status=$?; printf '", StringComparison.Ordinal))
        {
            lastExitCode = ExecuteRemoteShell(line);
        }
        var marker = Regex.Match(line, "__CODEX_DONE_(\\d+)__");
        if (marker.Success)
        {
            Console.WriteLine($"__CODEX_DONE_{marker.Groups[1].Value}__:{lastExitCode}");
            lastExitCode = 0;
            Console.Out.Flush();
        }
    }
}
return 0;

static string RemotePath(string path)
{
    var root = Environment.GetEnvironmentVariable("ADB_FIXTURE_REMOTE_ROOT")
        ?? throw new InvalidOperationException("Missing fake remote root");
    return Path.Combine(root, path.TrimStart('/').Replace('/', Path.DirectorySeparatorChar));
}

static int ExecuteRemoteShell(string command)
{
    if (command.Contains("codex_test_panel.command", StringComparison.Ordinal)) return 0;
    if (Environment.GetEnvironmentVariable("ADB_FIXTURE_ASSISTANT_FAIL_AT") == "write-target"
        && command.Contains("codex_minimap_patch.luac' > '/data/user/0/", StringComparison.Ordinal))
    {
        Console.Error.WriteLine("fixture target write failure");
        return 1;
    }

    var find = Regex.Match(command, @"if \[ -f '([^']+)' \]; then printf '%s(?:\\n|\n)' '([^']+)'; else find ");
    if (find.Success)
    {
        var target = RemotePath(find.Groups[1].Value);
        if (File.Exists(target)) Console.WriteLine(find.Groups[2].Value);
        return 0;
    }
    var exists = Regex.Match(command, @"if \[ -f '([^']+)' \]; then echo yes; else echo no; fi");
    if (exists.Success)
    {
        Console.WriteLine(File.Exists(RemotePath(exists.Groups[1].Value)) ? "yes" : "no");
        return 0;
    }

    var cp = Regex.Match(command, @"\bcp(?: -p)? '([^']+)' '([^']+)'");
    if (cp.Success)
    {
        var source = RemotePath(cp.Groups[1].Value);
        if (!File.Exists(source)) { Console.Error.WriteLine("fixture cp source missing"); return 1; }
        var destination = RemotePath(cp.Groups[2].Value);
        Directory.CreateDirectory(Path.GetDirectoryName(destination)!);
        File.Copy(source, destination, overwrite: true);
    }
    var cat = Regex.Match(command, @"\bcat '([^']+)' > '([^']+)'");
    if (cat.Success)
    {
        var source = RemotePath(cat.Groups[1].Value);
        if (!File.Exists(source)) { Console.Error.WriteLine("fixture cat source missing"); return 1; }
        var destination = RemotePath(cat.Groups[2].Value);
        Directory.CreateDirectory(Path.GetDirectoryName(destination)!);
        File.Copy(source, destination, overwrite: true);
    }
    foreach (Match remove in Regex.Matches(command, @"\brm -f '([^']+)'") )
        try { File.Delete(RemotePath(remove.Groups[1].Value)); } catch (DirectoryNotFoundException) { }
    return 0;
}
