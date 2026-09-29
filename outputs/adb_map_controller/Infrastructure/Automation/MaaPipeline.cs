using System.Collections.Concurrent;
using System.Globalization;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace AdbMapController;

public enum MaaPipelineAlgorithm
{
    JustReturn,
    MatchTemplate,
    OcrDetect,
    FeatureMatch
}

public enum MaaPipelineAction
{
    DoNothing,
    ClickSelf,
    ClickRand,
    Stop,
    ClickRect,
    Swipe,
    Input
}

public readonly record struct MaaRect(int X, int Y, int Width, int Height);

/// <summary>
/// 已完成继承和表达式展开的 MAA 任务。资源层使用 MAA 字段，
/// handler 是本项目的扩展绑定点，用来连接现有领域代码或设备控制器。
/// </summary>
public sealed record MaaPipelineTask
{
    public required string Name { get; init; }
    public string Handler { get; init; } = "";
    public MaaPipelineAlgorithm Algorithm { get; init; } = MaaPipelineAlgorithm.MatchTemplate;
    public MaaPipelineAction Action { get; init; } = MaaPipelineAction.DoNothing;
    public string InputText { get; init; } = "";
    public IReadOnlyList<string> Sub { get; init; } = [];
    public bool SubErrorIgnored { get; init; }
    public IReadOnlyList<string> Next { get; init; } = [];
    public int MaxTimes { get; init; } = int.MaxValue;
    public IReadOnlyList<string> ExceededNext { get; init; } = [];
    public IReadOnlyList<string> OnErrorNext { get; init; } = [];
    public bool Enabled { get; init; } = true;
    public int TimeoutMs { get; init; } = 20_000;
    public int RateLimitMs { get; init; } = 1_000;
    public int PreDelayMs { get; init; }
    public int PostDelayMs { get; init; }
    public MaaRect? Roi { get; init; }
    public bool Cache { get; init; } = true;
    public MaaRect? RectMove { get; init; }
    public IReadOnlyList<string> ReduceOtherTimes { get; init; } = [];
    public MaaRect? SpecificRect { get; init; }
    public IReadOnlyList<int> SpecialParams { get; init; } = [];
    public bool HighResolutionSwipeFix { get; init; }
    public IReadOnlyList<string> Templates { get; init; } = [];
    public IReadOnlyList<double> TemplateThresholds { get; init; } = [.8];
    public IReadOnlyList<int> MaskRange { get; init; } = [1, 255];
    public IReadOnlyList<IReadOnlyList<IReadOnlyList<int>>> ColorScales { get; init; } = [];
    public bool ColorWithClose { get; init; } = true;
    public bool PureColor { get; init; }
    public IReadOnlyList<string> Methods { get; init; } = ["Ccoeff"];
    public int NmsDistance { get; init; }
    public int Index { get; init; }
    public string OrderBy { get; init; } = "Horizontal";
    public IReadOnlyList<string> Text { get; init; } = [];
    public IReadOnlyList<IReadOnlyList<string>> OcrReplace { get; init; } = [];
    public bool FullMatch { get; init; }
    public bool ReplaceFull { get; init; }
    public bool IsAscii { get; init; }
    public bool WithoutDet { get; init; }
    public bool UseRaw { get; init; } = true;
    public IReadOnlyList<int> BinThreshold { get; init; } = [140, 255];
    public int FeatureCount { get; init; } = 4;
    public double FeatureRatio { get; init; } = .6;
    public string FeatureDetector { get; init; } = "SIFT";
}

public sealed class MaaPipelineCatalog
{
    readonly Dictionary<string, MaaPipelineTask> tasks;
    readonly Func<string, MaaPipelineTask>? lazyCompiler;

    internal MaaPipelineCatalog(
        IReadOnlyDictionary<string, MaaPipelineTask> tasks,
        Func<string, MaaPipelineTask>? lazyCompiler = null)
    {
        this.tasks = new Dictionary<string, MaaPipelineTask>(tasks, StringComparer.OrdinalIgnoreCase);
        this.lazyCompiler = lazyCompiler;
    }

    public IReadOnlyCollection<string> Names => tasks.Keys;

    public MaaPipelineTask Get(string name)
    {
        if (tasks.TryGetValue(name, out var task)) return task;
        if (lazyCompiler is null) throw new KeyNotFoundException($"MAA Pipeline 任务不存在：{name}");
        task = lazyCompiler(name);
        tasks[name] = task;
        return task;
    }

    public bool TryGet(string name, out MaaPipelineTask task)
    {
        if (tasks.TryGetValue(name, out task!)) return true;
        try
        {
            task = Get(name);
            return true;
        }
        catch (InvalidDataException)
        {
            task = null!;
            return false;
        }
    }
}

/// <summary>
/// MAA v1 任务资源加载器。支持多文件覆盖、baseTask、隐式/显式 @ 任务、
/// # 虚任务和任务列表表达式。它只编译任务，不执行设备动作。
/// </summary>
public static class MaaPipelineCatalogLoader
{
    static readonly string[] ListFields =
    ["sub", "next", "onErrorNext", "exceededNext", "reduceOtherTimes"];

    public static MaaPipelineCatalog Load(string path)
        => Load([path]);

    public static MaaPipelineCatalog Load(IEnumerable<string> paths)
    {
        ArgumentNullException.ThrowIfNull(paths);
        var raw = new Dictionary<string, JsonObject>(StringComparer.OrdinalIgnoreCase);
        foreach (var path in paths)
        {
            if (string.IsNullOrWhiteSpace(path)) throw new ArgumentException("MAA 任务文件路径不能为空", nameof(paths));
            if (!File.Exists(path)) throw new FileNotFoundException("MAA 任务文件不存在", path);
            using var document = JsonDocument.Parse(File.ReadAllText(path));
            if (document.RootElement.ValueKind != JsonValueKind.Object)
                throw new InvalidDataException($"MAA 任务根节点必须是 JSON 对象：{path}");

            foreach (var property in document.RootElement.EnumerateObject())
            {
                if (property.Name.StartsWith('$')) continue;
                if (property.Value.ValueKind != JsonValueKind.Object)
                    throw new InvalidDataException($"MAA 任务 {property.Name} 必须是 JSON 对象：{path}");
                var current = JsonNode.Parse(property.Value.GetRawText())!.AsObject();
                if (!raw.TryGetValue(property.Name, out var previous))
                {
                    raw[property.Name] = current;
                    continue;
                }

                // MAA 多文件协议：显式 baseTask 表示直接覆盖，否则在同名任务上合并字段。
                if (current.ContainsKey("baseTask")) raw[property.Name] = current;
                else
                    foreach (var field in current)
                        previous[field.Key] = field.Value?.DeepClone();
            }
        }

        var compiler = new Compiler(raw);
        var result = new Dictionary<string, MaaPipelineTask>(StringComparer.OrdinalIgnoreCase);
        foreach (var name in raw.Keys) result[name] = compiler.Compile(name);

        // 编译所有显式和隐式引用，尽早报告拼写错误，而不是运行到该分支才失败。
        var pending = new Queue<MaaPipelineTask>(result.Values);
        var checkedNames = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        while (pending.Count > 0)
        {
            var task = pending.Dequeue();
            if (!checkedNames.Add(task.Name)) continue;
            foreach (var reference in task.Sub.Concat(task.Next).Concat(task.OnErrorNext)
                         .Concat(task.ExceededNext).Concat(task.ReduceOtherTimes))
            {
                var dependency = compiler.Compile(reference);
                if (result.TryAdd(reference, dependency)) pending.Enqueue(dependency);
            }
        }

        return new MaaPipelineCatalog(result, compiler.Compile);
    }

    sealed class Compiler
    {
        readonly IReadOnlyDictionary<string, JsonObject> raw;
        readonly Dictionary<string, JsonObject> effective = new(StringComparer.OrdinalIgnoreCase);
        readonly Dictionary<string, MaaPipelineTask> compiled = new(StringComparer.OrdinalIgnoreCase);

        public Compiler(IReadOnlyDictionary<string, JsonObject> raw) => this.raw = raw;

        public MaaPipelineTask Compile(string name)
        {
            if (compiled.TryGetValue(name, out var cached)) return cached;
            var task = Parse(name, Effective(name, new HashSet<string>(StringComparer.OrdinalIgnoreCase)));
            compiled[name] = task;
            return task;
        }

        JsonObject Effective(string name, HashSet<string> stack)
        {
            if (effective.TryGetValue(name, out var cached)) return (JsonObject)cached.DeepClone();
            if (!stack.Add(name))
                throw new InvalidDataException($"MAA 任务继承/引用出现循环：{string.Join(" -> ", stack)} -> {name}");

            var explicitTask = raw.TryGetValue(name, out var direct) ? direct : null;
            var implicitBase = FindImplicitBase(name);
            if (explicitTask is null && implicitBase is null)
                throw new InvalidDataException($"MAA 任务不存在，且无法生成隐式 @ 任务：{name}");

            var source = explicitTask ?? new JsonObject();
            var baseName = ReadString(source, "baseTask") ?? implicitBase;
            var isDerivedAtTask = name.Contains('@', StringComparison.Ordinal) && baseName is not null;
            var result = baseName is null || string.Equals(baseName, "#none", StringComparison.OrdinalIgnoreCase)
                ? new JsonObject()
                : Effective(baseName, stack);

            if (isDerivedAtTask)
            {
                var prefix = name[..name.IndexOf('@')];
                foreach (var field in ListFields)
                {
                    if (source.ContainsKey(field) || !result.TryGetPropertyValue(field, out var value) || value is not JsonArray list)
                        continue;
                    var prefixed = new JsonArray();
                    foreach (var item in list)
                        prefixed.Add(PrefixReference(item?.GetValue<string>() ?? "", prefix));
                    result[field] = prefixed;
                }
            }

            foreach (var field in source)
            {
                if (string.Equals(field.Key, "baseTask", StringComparison.OrdinalIgnoreCase)) continue;
                result[field.Key] = field.Value?.DeepClone();
            }
            stack.Remove(name);
            effective[name] = (JsonObject)result.DeepClone();
            return result;
        }

        string? FindImplicitBase(string name)
        {
            for (var position = name.IndexOf('@'); position >= 0; position = name.IndexOf('@', position + 1))
            {
                var candidate = name[(position + 1)..];
                if (raw.ContainsKey(candidate) || effective.ContainsKey(candidate)) return candidate;
            }
            return null;
        }

        static string PrefixReference(string value, string prefix)
        {
            if (value.Length == 0 || value.StartsWith('#')) return value;
            return value.Contains('@', StringComparison.Ordinal) ? value : $"{prefix}@{value}";
        }

        MaaPipelineTask Parse(string name, JsonObject node)
        {
            node = NormalizeProtocolNode(node);
            var task = new MaaPipelineTask
            {
                Name = name,
                Handler = ReadString(node, "handler") ?? DefaultHandlerName(name),
                Algorithm = ParseAlgorithm(ReadString(node, "algorithm")),
                Action = ParseAction(ReadString(node, "action")),
                InputText = ReadString(node, "inputText") ?? "",
                SubErrorIgnored = ReadBool(node, "subErrorIgnored") ?? false,
                Enabled = ReadBool(node, "enabled") ?? true,
                TimeoutMs = ReadNumber(node, "timeout") is { } timeout
                    ? Math.Max(-1, (int)Math.Round(timeout))
                    : 20_000,
                RateLimitMs = ReadNumber(node, "rateLimit") is { } rateLimit
                    ? Math.Max(0, (int)Math.Round(rateLimit))
                    : 1_000,
                MaxTimes = ReadNumber(node, "maxTimes") is { } maxTimes
                    ? Math.Max(0, (int)Math.Round(maxTimes))
                    : int.MaxValue,
                PreDelayMs = ReadDelay(node, "preDelay"),
                PostDelayMs = ReadDelay(node, "postDelay"),
                Roi = ReadRect(node, "roi"),
                Cache = ReadBool(node, "cache") ?? true,
                RectMove = ReadRect(node, "rectMove"),
                SpecificRect = ReadRect(node, "specificRect"),
                SpecialParams = ReadIntList(node, "specialParams"),
                HighResolutionSwipeFix = ReadBool(node, "highResolutionSwipeFix") ?? false,
                Templates = ReadStringList(node, "template") is { Count: > 0 } templates
                    ? templates
                    : ReadString(node, "algorithm")?.Equals("JustReturn", StringComparison.OrdinalIgnoreCase) == true
                        ? []
                        : [$"{name}.png"],
                TemplateThresholds = ReadDoubleList(node, "templThreshold") is { Count: > 0 } thresholds
                    ? thresholds
                    : [.8],
                MaskRange = ReadIntList(node, "maskRange") is { Count: > 0 } mask ? mask : [1, 255],
                ColorScales = ReadColorScales(node, "colorScales"),
                ColorWithClose = ReadBool(node, "colorWithClose") ?? true,
                PureColor = ReadBool(node, "pureColor") ?? false,
                Methods = ReadStringList(node, "method") is { Count: > 0 } methods ? methods : ["Ccoeff"],
                NmsDistance = ReadNumber(node, "nmsDistance") is { } nms ? Math.Max(0, (int)Math.Round(nms)) : 0,
                Index = ReadNumber(node, "index") is { } index ? (int)Math.Round(index) : 0,
                OrderBy = ReadString(node, "orderBy") ?? "Horizontal",
                Text = ReadStringList(node, "text"),
                OcrReplace = ReadPairList(node, "ocrReplace"),
                FullMatch = ReadBool(node, "fullMatch") ?? false,
                ReplaceFull = ReadBool(node, "replaceFull") ?? false,
                IsAscii = ReadBool(node, "isAscii") ?? false,
                WithoutDet = ReadBool(node, "withoutDet") ?? false,
                UseRaw = ReadBool(node, "useRaw") ?? true,
                BinThreshold = ReadIntList(node, "binThreshold") is { Count: > 0 } threshold ? threshold : [140, 255],
                FeatureCount = ReadNumber(node, "count") is { } count ? Math.Max(1, (int)Math.Round(count)) : 4,
                FeatureRatio = ReadNumber(node, "ratio") is { } ratio ? Math.Clamp(ratio, 0, 1) : .6,
                FeatureDetector = ReadString(node, "detector") ?? "SIFT"
            };

            task = task with
            {
                Sub = ExpandList(node, "sub", name),
                Next = ExpandList(node, "next", name),
                OnErrorNext = ExpandList(node, "onErrorNext", name),
                ExceededNext = ExpandList(node, "exceededNext", name),
                ReduceOtherTimes = ExpandList(node, "reduceOtherTimes", name)
            };
            ValidateTask(task);
            return task;
        }

        static JsonObject NormalizeProtocolNode(JsonObject source)
        {
            var node = (JsonObject)source.DeepClone();

            // MaaFramework Pipeline v1/v2 use recognition/action while the
            // original local implementation used algorithm/action. Keep both
            // forms valid so existing resources remain loadable.
            if (!node.ContainsKey("algorithm") && node.TryGetPropertyValue("recognition", out var recognition))
            {
                if (recognition is JsonValue recognitionValue && recognitionValue.TryGetValue<string>(out var recognitionName))
                    node["algorithm"] = recognitionName;
                else if (recognition is JsonObject recognitionObject)
                {
                    if (recognitionObject.TryGetPropertyValue("type", out var type) && type is JsonValue typeValue &&
                        typeValue.TryGetValue<string>(out var typeName))
                        node["algorithm"] = typeName;
                    MergeProtocolParameters(node, recognitionObject);
                }
            }

            if (node.TryGetPropertyValue("action", out var action) && action is JsonObject actionObject)
            {
                if (actionObject.TryGetPropertyValue("type", out var type) && type is JsonValue typeValue &&
                    typeValue.TryGetValue<string>(out var typeName))
                    node["action"] = typeName;
                MergeProtocolParameters(node, actionObject);
            }

            CopyAlias(node, "onErrorNext", "on_error");
            CopyAlias(node, "exceededNext", "exceeded_next");
            CopyAlias(node, "maxTimes", "max_hit");
            CopyAlias(node, "preDelay", "pre_delay");
            CopyAlias(node, "postDelay", "post_delay");
            CopyAlias(node, "rateLimit", "rate_limit");
            CopyAlias(node, "templThreshold", "threshold");

            return node;
        }

        static void MergeProtocolParameters(JsonObject node, JsonObject protocolObject)
        {
            if (!protocolObject.TryGetPropertyValue("param", out var parameters) || parameters is not JsonObject parameterObject)
                return;
            foreach (var property in parameterObject)
                if (!node.ContainsKey(property.Key)) node[property.Key] = property.Value?.DeepClone();
        }

        static void CopyAlias(JsonObject node, string localName, string protocolName)
        {
            if (!node.ContainsKey(localName) && node.TryGetPropertyValue(protocolName, out var value))
                node[localName] = value?.DeepClone();
        }

        static void ValidateTask(MaaPipelineTask task)
        {
            if (task.MaxTimes < 0) throw new InvalidDataException($"任务 {task.Name} 的 maxTimes 不能小于 0");
            if (task.Action == MaaPipelineAction.ClickRect && task.SpecificRect is null)
                throw new InvalidDataException($"任务 {task.Name} 使用 ClickRect 时必须提供 specificRect");
            if (task.Action == MaaPipelineAction.Swipe && (task.SpecificRect is null || task.RectMove is null))
                throw new InvalidDataException($"任务 {task.Name} 使用 Swipe 时必须提供 specificRect 和 rectMove");
            if (task.Action == MaaPipelineAction.Input &&
                (task.Algorithm != MaaPipelineAlgorithm.JustReturn || task.InputText.Length == 0))
                throw new InvalidDataException($"任务 {task.Name} 使用 Input 时必须是 JustReturn 且提供 inputText");
            if (task.Algorithm == MaaPipelineAlgorithm.OcrDetect && task.Text.Count == 0)
                throw new InvalidDataException($"OCR 任务 {task.Name} 缺少 text");
            if (task.Algorithm == MaaPipelineAlgorithm.FeatureMatch && task.Templates.Count == 0)
                throw new InvalidDataException($"FeatureMatch 任务 {task.Name} 缺少 template");
        }

        static string DefaultHandlerName(string name)
        {
            var position = name.IndexOf('@');
            return position < 0 ? name : name[(position + 1)..];
        }

        IReadOnlyList<string> ExpandList(JsonObject node, string field, string current)
        {
            var values = ReadStringList(node, field);
            if (values.Count == 0) return [];
            var result = new List<string>();
            foreach (var value in values)
                result.AddRange(new ExpressionParser(value, atom => ResolveAtom(atom, current)).Parse());
            return Distinct(result);
        }

        IReadOnlyList<string> ResolveAtom(string atom, string current)
        {
            atom = atom.Trim();
            if (atom.Length == 0 || string.Equals(atom, "#none", StringComparison.OrdinalIgnoreCase)) return [];
            if (string.Equals(atom, "#self", StringComparison.OrdinalIgnoreCase)) return [current];
            if (string.Equals(atom, "#back", StringComparison.OrdinalIgnoreCase))
            {
                var position = current.LastIndexOf('@');
                return position < 0 ? [] : [current[..position]];
            }
            if (atom.StartsWith('#')) return [];

            var marker = atom.LastIndexOf('#');
            if (marker > 0)
            {
                var taskName = atom[..marker];
                var field = atom[(marker + 1)..].ToLowerInvariant();
                var task = Compile(taskName);
                return field switch
                {
                    "self" => [task.Name],
                    "next" => task.Next,
                    "sub" => task.Sub,
                    "on_error_next" => task.OnErrorNext,
                    "exceeded_next" => task.ExceededNext,
                    "reduce_other_times" => task.ReduceOtherTimes,
                    _ => []
                };
            }
            return [atom];
        }

        static IReadOnlyList<string> Distinct(IEnumerable<string> values)
            => values.Where(x => x.Length > 0).Distinct(StringComparer.OrdinalIgnoreCase).ToArray();

        static MaaPipelineAlgorithm ParseAlgorithm(string? value)
            => value?.ToLowerInvariant() switch
            {
                null or "matchtemplate" or "templatematch" => MaaPipelineAlgorithm.MatchTemplate,
                "justreturn" or "directhit" => MaaPipelineAlgorithm.JustReturn,
                "ocrdetect" or "ocr" => MaaPipelineAlgorithm.OcrDetect,
                "featurematch" => MaaPipelineAlgorithm.FeatureMatch,
                _ => throw new InvalidDataException($"未知 MAA Pipeline 识别算法：{value}")
            };

        static MaaPipelineAction ParseAction(string? value)
            => value?.ToLowerInvariant() switch
            {
                null or "donothing" => MaaPipelineAction.DoNothing,
                "clickself" or "click" => MaaPipelineAction.ClickSelf,
                "clickrand" => MaaPipelineAction.ClickRand,
                "stop" or "stoptask" => MaaPipelineAction.Stop,
                "clickrect" => MaaPipelineAction.ClickRect,
                "swipe" or "scroll" => MaaPipelineAction.Swipe,
                "input" or "inputtext" => MaaPipelineAction.Input,
                _ => throw new InvalidDataException($"未知 MAA Pipeline 动作：{value}")
            };

        static int ReadDelay(JsonObject node, string name)
        {
            var value = ReadNumber(node, name) ?? 0;
            if (value < 0 || value > 300_000) throw new InvalidDataException($"字段 {name} 必须在 0~300000：{value}");
            return (int)Math.Round(value);
        }

        static string? ReadString(JsonObject node, string name)
            => node.TryGetPropertyValue(name, out var value) && value is JsonValue json && json.TryGetValue<string>(out var text)
                ? text
                : null;

        static bool? ReadBool(JsonObject node, string name)
            => node.TryGetPropertyValue(name, out var value) && value is JsonValue json && json.TryGetValue<bool>(out var result)
                ? result
                : null;

        static double? ReadNumber(JsonObject node, string name)
        {
            if (!node.TryGetPropertyValue(name, out var value) || value is null) return null;
            if (value is JsonValue json && json.TryGetValue<double>(out var number)) return number;
            throw new InvalidDataException($"字段 {name} 必须是数字");
        }

        static IReadOnlyList<string> ReadStringList(JsonObject node, string name)
        {
            if (!node.TryGetPropertyValue(name, out var value) || value is null) return [];
            if (value is JsonValue json && json.TryGetValue<string>(out var text)) return [text];
            if (value is not JsonArray array) throw new InvalidDataException($"字段 {name} 必须是字符串或字符串数组");
            return array.Select(item => item?.GetValue<string>() ?? "").Where(x => x.Length > 0).ToArray();
        }

        static IReadOnlyList<double> ReadDoubleList(JsonObject node, string name)
        {
            if (!node.TryGetPropertyValue(name, out var value) || value is null) return [];
            if (value is JsonValue json && json.TryGetValue<double>(out var number)) return [number];
            if (value is not JsonArray array) throw new InvalidDataException($"字段 {name} 必须是数字或数字数组");
            return array.Select(item => item?.GetValue<double>() ?? 0).ToArray();
        }

        static IReadOnlyList<int> ReadIntList(JsonObject node, string name)
        {
            if (!node.TryGetPropertyValue(name, out var value) || value is null) return [];
            if (value is not JsonArray array) throw new InvalidDataException($"字段 {name} 必须是整数数组");
            return array.Select(item => item?.GetValue<int>() ?? 0).ToArray();
        }

        static MaaRect? ReadRect(JsonObject node, string name)
        {
            var values = ReadIntList(node, name);
            if (values.Count == 0) return null;
            if (values.Count != 4) throw new InvalidDataException($"字段 {name} 必须是 [x,y,width,height]");
            if (values[2] <= 0 || values[3] <= 0) throw new InvalidDataException($"字段 {name} 的宽高必须大于 0");
            return new MaaRect(values[0], values[1], values[2], values[3]);
        }

        static IReadOnlyList<IReadOnlyList<string>> ReadPairList(JsonObject node, string name)
        {
            if (!node.TryGetPropertyValue(name, out var value) || value is null) return [];
            if (value is not JsonArray array) throw new InvalidDataException($"字段 {name} 必须是二维字符串数组");
            return array.Select(item => item is JsonArray pair
                    ? (IReadOnlyList<string>)pair.Select(x => x?.GetValue<string>() ?? "").ToArray()
                    : throw new InvalidDataException($"字段 {name} 存在非数组项"))
                .Where(pair => pair.Count == 2)
                .ToArray();
        }

        static IReadOnlyList<IReadOnlyList<IReadOnlyList<int>>> ReadColorScales(JsonObject node, string name)
        {
            if (!node.TryGetPropertyValue(name, out var value) || value is null) return [];
            if (value is not JsonArray outer) throw new InvalidDataException($"字段 {name} 必须是颜色范围数组");
            var result = new List<IReadOnlyList<IReadOnlyList<int>>>();
            foreach (var scaleNode in outer)
            {
                if (scaleNode is not JsonArray scale || scale.Count != 2)
                    throw new InvalidDataException($"字段 {name} 的每个颜色范围必须包含上下限");
                var bounds = new List<IReadOnlyList<int>>();
                foreach (var boundNode in scale)
                {
                    if (boundNode is not JsonArray bound || (bound.Count != 1 && bound.Count != 3))
                        throw new InvalidDataException($"字段 {name} 的颜色上下限必须是 1 或 3 个整数");
                    bounds.Add(bound.Select(x => x?.GetValue<int>() ?? 0).ToArray());
                }
                result.Add(bounds);
            }
            return result;
        }
    }

    sealed class ExpressionParser
    {
        readonly string input;
        readonly Func<string, IReadOnlyList<string>> resolveAtom;
        int position;

        public ExpressionParser(string input, Func<string, IReadOnlyList<string>> resolveAtom)
        {
            this.input = input;
            this.resolveAtom = resolveAtom;
        }

        public IReadOnlyList<string> Parse()
        {
            var result = ParseAdditive();
            SkipWhitespace();
            if (position != input.Length) throw new InvalidDataException($"无法解析 MAA 任务表达式：{input}");
            return result;
        }

        List<string> ParseAdditive()
        {
            var result = ParseRepeat();
            while (true)
            {
                SkipWhitespace();
                if (position >= input.Length || (input[position] != '+' && input[position] != '^')) return result;
                var operation = input[position++];
                var right = ParseRepeat();
                if (operation == '+')
                    result = result.Concat(right).Distinct(StringComparer.OrdinalIgnoreCase).ToList();
                else
                    result = result.Where(x => !right.Contains(x, StringComparer.OrdinalIgnoreCase)).ToList();
            }
        }

        List<string> ParseRepeat()
        {
            var result = ParsePrimary();
            SkipWhitespace();
            if (position >= input.Length || input[position] != '*') return result;
            position++;
            SkipWhitespace();
            var start = position;
            while (position < input.Length && char.IsDigit(input[position])) position++;
            if (start == position) throw new InvalidDataException($"MAA 任务重复表达式缺少次数：{input}");
            var count = int.Parse(input[start..position], CultureInfo.InvariantCulture);
            if (count < 0 || count > 1000) throw new InvalidDataException($"MAA 任务重复次数超出范围：{count}");
            return Enumerable.Range(0, count).SelectMany(_ => result).ToList();
        }

        List<string> ParsePrimary()
        {
            SkipWhitespace();
            if (position < input.Length && input[position] == '(')
            {
                position++;
                var result = ParseAdditive();
                SkipWhitespace();
                if (position >= input.Length || input[position++] != ')')
                    throw new InvalidDataException($"MAA 任务表达式缺少右括号：{input}");
                return result;
            }

            var start = position;
            while (position < input.Length && !char.IsWhiteSpace(input[position]) && "+^*()".IndexOf(input[position]) < 0)
                position++;
            if (start == position) throw new InvalidDataException($"MAA 任务表达式存在空项：{input}");
            return resolveAtom(input[start..position]).ToList();
        }

        void SkipWhitespace()
        {
            while (position < input.Length && char.IsWhiteSpace(input[position])) position++;
        }
    }
}

public sealed record MaaPipelineRecognitionResult(
    bool Matched,
    double Score = 0,
    MaaRect? Box = null,
    string? Text = null,
    string? Detail = null,
    string? EvidencePath = null,
    long? FrameId = null)
{
    public static MaaPipelineRecognitionResult Miss(string? detail = null)
        => new(false, Detail: detail);

    public static MaaPipelineRecognitionResult Hit(
        double score = 1,
        MaaRect? box = null,
        string? text = null,
        string? detail = null,
        string? evidencePath = null,
        long? frameId = null)
        => new(true, score, box, text, detail, evidencePath, frameId);
}

public sealed record MaaPipelineActionResult(bool Succeeded, string? Error = null, bool Interrupted = false)
{
    public static MaaPipelineActionResult Success() => new(true);
    public static MaaPipelineActionResult Failure(string error) => new(false, error);
    public static MaaPipelineActionResult Stop() => new(true, Interrupted: true);
}

public sealed class MaaPipelineTaskContext<TState>
{
    internal MaaPipelineTaskContext(
        TState state,
        string runId,
        string taskChain,
        string taskName,
        int taskId,
        string? parentTask,
        int attempt,
        int executionCount,
        IReadOnlyDictionary<string, int> executionCounts)
    {
        State = state;
        RunId = runId;
        TaskChain = taskChain;
        TaskName = taskName;
        TaskId = taskId;
        ParentTask = parentTask;
        Attempt = attempt;
        ExecutionCount = executionCount;
        ExecutionCounts = executionCounts;
    }

    public TState State { get; }
    public string RunId { get; }
    public string TaskChain { get; }
    public string TaskName { get; }
    public int TaskId { get; }
    public string? ParentTask { get; }
    public int Attempt { get; }
    public int ExecutionCount { get; }
    public IReadOnlyDictionary<string, int> ExecutionCounts { get; }
}

public interface IMaaPipelineHandler<TState>
{
    string Name { get; }

    Task<MaaPipelineRecognitionResult> RecognizeAsync(
        MaaPipelineTask task,
        MaaPipelineTaskContext<TState> context,
        CancellationToken token);

    Task<MaaPipelineActionResult> ExecuteAsync(
        MaaPipelineTask task,
        MaaPipelineRecognitionResult recognition,
        MaaPipelineTaskContext<TState> context,
        CancellationToken token);
}

public sealed class DelegateMaaPipelineHandler<TState> : IMaaPipelineHandler<TState>
{
    readonly Func<MaaPipelineTask, MaaPipelineTaskContext<TState>, CancellationToken, Task<MaaPipelineRecognitionResult>> recognize;
    readonly Func<MaaPipelineTask, MaaPipelineRecognitionResult, MaaPipelineTaskContext<TState>, CancellationToken, Task<MaaPipelineActionResult>> execute;

    public DelegateMaaPipelineHandler(
        string name,
        Func<MaaPipelineTask, MaaPipelineTaskContext<TState>, CancellationToken, Task<MaaPipelineRecognitionResult>> recognize,
        Func<MaaPipelineTask, MaaPipelineRecognitionResult, MaaPipelineTaskContext<TState>, CancellationToken, Task<MaaPipelineActionResult>> execute)
    {
        if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("handler 名称不能为空", nameof(name));
        Name = name;
        this.recognize = recognize ?? throw new ArgumentNullException(nameof(recognize));
        this.execute = execute ?? throw new ArgumentNullException(nameof(execute));
    }

    public string Name { get; }
    public Task<MaaPipelineRecognitionResult> RecognizeAsync(MaaPipelineTask task, MaaPipelineTaskContext<TState> context, CancellationToken token)
        => recognize(task, context, token);
    public Task<MaaPipelineActionResult> ExecuteAsync(MaaPipelineTask task, MaaPipelineRecognitionResult recognition, MaaPipelineTaskContext<TState> context, CancellationToken token)
        => execute(task, recognition, context, token);
}

public enum MaaPipelineTraceKind
{
    TaskChainStarted,
    CandidateRecognizing,
    CandidateRecognized,
    NodeStarted,
    ActionStarted,
    NodeCompleted,
    NodeFailed,
    Retrying,
    LimitExceeded,
    BranchSelected,
    TaskChainCompleted,
    TaskChainFailed,
    Canceled,
    Stopped
}

public sealed record MaaPipelineTraceEvent(
    MaaPipelineTraceKind Kind,
    string RunId,
    string TaskChain,
    int TaskId,
    string? TaskName,
    string? ParentTask,
    int Attempt,
    int ExecutionCount,
    TimeSpan Duration,
    bool? Matched,
    double? Score,
    MaaRect? Box,
    string? Text,
    string? Action,
    string? Detail,
    string? Error,
    string? EvidencePath,
    long? FrameId,
    IReadOnlyList<string>? Candidates = null);

public interface IMaaPipelineTraceSink
{
    void Write(MaaPipelineTraceEvent value);
}

public sealed class DelegateMaaPipelineTraceSink : IMaaPipelineTraceSink
{
    readonly Action<MaaPipelineTraceEvent> action;

    public DelegateMaaPipelineTraceSink(Action<MaaPipelineTraceEvent> action)
        => this.action = action ?? throw new ArgumentNullException(nameof(action));

    public void Write(MaaPipelineTraceEvent value) => action(value);
}

public sealed class MaaPipelineTraceMultiplexer : IMaaPipelineTraceSink
{
    readonly IReadOnlyList<IMaaPipelineTraceSink> sinks;

    public MaaPipelineTraceMultiplexer(IEnumerable<IMaaPipelineTraceSink> sinks)
        => this.sinks = sinks?.Where(x => x is not null).ToArray()
            ?? throw new ArgumentNullException(nameof(sinks));

    public void Write(MaaPipelineTraceEvent value)
    {
        foreach (var sink in sinks)
        {
            try { sink.Write(value); } catch { /* 一个诊断订阅者不能破坏任务 */ }
        }
    }
}

public sealed class MaaPipelineTraceCollector : IMaaPipelineTraceSink
{
    readonly ConcurrentQueue<MaaPipelineTraceEvent> events = new();

    public IReadOnlyList<MaaPipelineTraceEvent> Events => events.ToArray();
    public void Write(MaaPipelineTraceEvent value) => events.Enqueue(value);

    public void SaveJson(string path)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(path);
        var directory = Path.GetDirectoryName(Path.GetFullPath(path));
        if (!string.IsNullOrWhiteSpace(directory)) Directory.CreateDirectory(directory);
        File.WriteAllText(path, JsonSerializer.Serialize(Events, new JsonSerializerOptions { WriteIndented = true }));
    }
}

public sealed record MaaPipelineExecutionResult(
    MaaPipelineExecutionStatus Status,
    string RunId,
    string? LastTask,
    int TaskId,
    int Transitions,
    string? Error)
{
    public bool Succeeded => Status == MaaPipelineExecutionStatus.Succeeded;
}

public enum MaaPipelineExecutionStatus
{
    Succeeded,
    Failed,
    Canceled,
    Stopped,
    TransitionLimitReached
}

public sealed class MaaPipelineExecutionOptions
{
    public int RetryTimes { get; init; } = 20;
    public TimeSpan RetryInterval { get; init; } = TimeSpan.FromMilliseconds(500);
    public int MaxTransitions { get; init; } = 100_000;
    public string TaskChain { get; init; } = "Custom";
}

/// <summary>
/// MAA ProcessTask 风格运行时。识别和设备动作由 handler 提供，
/// 任务编译、候选优先级、sub/next 分支、次数、重试和可观测事件由此类统一管理。
/// </summary>
public sealed class MaaPipeline<TState>
{
    readonly MaaPipelineCatalog catalog;
    readonly IReadOnlyDictionary<string, IMaaPipelineHandler<TState>> handlers;
    readonly IMaaPipelineTraceSink? trace;
    readonly MaaPipelineExecutionOptions options;
    readonly Dictionary<string, int> executionCounts = new(StringComparer.OrdinalIgnoreCase);
    readonly object countLock = new();
    int taskId;
    int transitions;
    string runId = "";
    string? lastTask;

    public MaaPipeline(
        MaaPipelineCatalog catalog,
        IEnumerable<IMaaPipelineHandler<TState>> handlers,
        MaaPipelineExecutionOptions? options = null,
        IMaaPipelineTraceSink? trace = null)
    {
        this.catalog = catalog ?? throw new ArgumentNullException(nameof(catalog));
        var list = handlers?.ToList() ?? throw new ArgumentNullException(nameof(handlers));
        this.handlers = list.ToDictionary(x => x.Name, StringComparer.OrdinalIgnoreCase);
        if (this.handlers.Count != list.Count) throw new ArgumentException("handler 名称重复", nameof(handlers));
        this.options = options ?? new MaaPipelineExecutionOptions();
        if (this.options.RetryTimes < 0 || this.options.MaxTransitions < 1)
            throw new ArgumentOutOfRangeException(nameof(options));
        this.trace = trace;
    }

    public async Task<MaaPipelineExecutionResult> RunAsync(
        TState state,
        IEnumerable<string> entryTasks,
        CancellationToken token = default)
    {
        var entries = entryTasks?.Where(x => !string.IsNullOrWhiteSpace(x)).ToArray()
            ?? throw new ArgumentNullException(nameof(entryTasks));
        if (entries.Length == 0) throw new ArgumentException("至少需要一个入口任务", nameof(entryTasks));
        foreach (var name in entries) _ = catalog.Get(name);

        runId = Guid.NewGuid().ToString("N");
        taskId = 0;
        transitions = 0;
        lastTask = null;
        lock (countLock) executionCounts.Clear();
        Emit(new(MaaPipelineTraceKind.TaskChainStarted, runId, options.TaskChain, 0, null, null, 0, 0,
            TimeSpan.Zero, null, null, null, null, null, null, null, null, null));

        IReadOnlyList<string> candidates = entries;
        IReadOnlyList<string> onErrorCandidates = [];
        var nextTimeoutMs = 0;
        var nextRateLimitMs = 0;
        try
        {
            while (candidates.Count > 0)
            {
                token.ThrowIfCancellationRequested();
                if (++transitions > options.MaxTransitions)
                {
                    var error = $"MAA Pipeline 超过最大跳转次数 {options.MaxTransitions}";
                    EmitFailure(error);
                    return new(MaaPipelineExecutionStatus.TransitionLimitReached, runId, lastTask, taskId, transitions, error);
                }

                var outcome = await FindAndRunAsync(state, candidates, token, followNext: false,
                    parentTask: null, nextTimeoutMs, nextRateLimitMs);
                switch (outcome.Kind)
                {
                    case MaaTaskRunKind.Success:
                        candidates = outcome.Task?.Next.ToArray() ?? [];
                        onErrorCandidates = outcome.Task?.OnErrorNext.ToArray() ?? [];
                        nextTimeoutMs = outcome.Task?.TimeoutMs ?? 0;
                        nextRateLimitMs = outcome.Task?.RateLimitMs ?? 0;
                        EmitBranch(outcome.Task, candidates);
                        break;
                    case MaaTaskRunKind.Runout:
                        candidates = outcome.Task?.ExceededNext.ToArray() ?? [];
                        onErrorCandidates = [];
                        nextTimeoutMs = 0;
                        nextRateLimitMs = 0;
                        EmitBranch(outcome.Task, candidates);
                        break;
                    case MaaTaskRunKind.Failed:
                        candidates = outcome.Task?.OnErrorNext.ToArray() ?? [];
                        onErrorCandidates = [];
                        nextTimeoutMs = 0;
                        nextRateLimitMs = 0;
                        if (candidates.Count == 0)
                        {
                            EmitFailure(outcome.Error ?? "任务执行失败");
                            return new(MaaPipelineExecutionStatus.Failed, runId, lastTask, taskId, transitions, outcome.Error);
                        }
                        EmitBranch(outcome.Task, candidates);
                        break;
                    case MaaTaskRunKind.NoMatch:
                        if (onErrorCandidates.Count > 0)
                        {
                            EmitBranch(outcome.Task, onErrorCandidates);
                            candidates = onErrorCandidates;
                            onErrorCandidates = [];
                            nextTimeoutMs = 0;
                            nextRateLimitMs = 0;
                            break;
                        }
                        var noMatch = "入口候选任务在重试后仍未命中";
                        EmitFailure(noMatch);
                        return new(MaaPipelineExecutionStatus.Failed, runId, lastTask, taskId, transitions, noMatch);
                    case MaaTaskRunKind.Interrupted:
                        Emit(new(MaaPipelineTraceKind.Stopped, runId, options.TaskChain, taskId, lastTask, null, 0, 0,
                            TimeSpan.Zero, null, null, null, null, "Stop", outcome.Error, outcome.Error, null, null));
                        return new(MaaPipelineExecutionStatus.Stopped, runId, lastTask, taskId, transitions, outcome.Error);
                }
            }

            Emit(new(MaaPipelineTraceKind.TaskChainCompleted, runId, options.TaskChain, taskId, lastTask, null, 0,
                0, TimeSpan.Zero, null, null, null, null, null, null, null, null, null));
            return new(MaaPipelineExecutionStatus.Succeeded, runId, lastTask, taskId, transitions, null);
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested)
        {
            Emit(new(MaaPipelineTraceKind.Canceled, runId, options.TaskChain, taskId, lastTask, null, 0, 0,
                TimeSpan.Zero, null, null, null, null, null, null, "Pipeline 已取消", null, null));
            return new(MaaPipelineExecutionStatus.Canceled, runId, lastTask, taskId, transitions, "Pipeline 已取消");
        }
    }

    async Task<MaaTaskRunOutcome> FindAndRunAsync(
        TState state,
        IReadOnlyList<string> candidates,
        CancellationToken token,
        bool followNext,
        string? parentTask,
        int timeoutMs,
        int rateLimitMs)
    {
        var overall = System.Diagnostics.Stopwatch.StartNew();
        var retry = 0;
        while (true)
        {
            foreach (var name in candidates)
            {
                token.ThrowIfCancellationRequested();
                var task = catalog.Get(name);
                if (!task.Enabled) continue;
                var handler = GetHandler(task);
                var context = CreateContext(state, task, parentTask, retry, GetCount(task.Name));
                Emit(new(MaaPipelineTraceKind.CandidateRecognizing, runId, options.TaskChain, context.TaskId, task.Name,
                    parentTask, retry, context.ExecutionCount, TimeSpan.Zero, null, null, task.Roi, null, null, null, null, null, null,
                    candidates));
                var stopwatch = System.Diagnostics.Stopwatch.StartNew();
                MaaPipelineRecognitionResult recognition;
                try
                {
                    recognition = task.Algorithm == MaaPipelineAlgorithm.JustReturn
                        ? MaaPipelineRecognitionResult.Hit(detail: "JustReturn")
                        : await handler.RecognizeAsync(task, context, token);
                }
                catch (Exception ex) when (ex is not OperationCanceledException)
                {
                    Emit(new(MaaPipelineTraceKind.NodeFailed, runId, options.TaskChain, context.TaskId, task.Name, parentTask,
                        retry, context.ExecutionCount, stopwatch.Elapsed, false, null, task.Roi, null, task.Action.ToString(), null, ex.Message, null, null));
                    return new(MaaTaskRunKind.Failed, task, ex.Message);
                }

                Emit(new(MaaPipelineTraceKind.CandidateRecognized, runId, options.TaskChain, context.TaskId, task.Name,
                    parentTask, retry, context.ExecutionCount, stopwatch.Elapsed, recognition.Matched, recognition.Score,
                    recognition.Box ?? task.Roi, recognition.Text, task.Action.ToString(), recognition.Detail, null,
                    recognition.EvidencePath, recognition.FrameId, candidates));
                if (!recognition.Matched) continue;

                if (GetCount(task.Name) >= task.MaxTimes)
                {
                    Emit(new(MaaPipelineTraceKind.LimitExceeded, runId, options.TaskChain, context.TaskId, task.Name, parentTask,
                        retry, GetCount(task.Name), stopwatch.Elapsed, true, recognition.Score, recognition.Box, recognition.Text,
                        task.Action.ToString(), $"达到 maxTimes={task.MaxTimes}", null, recognition.EvidencePath, recognition.FrameId));
                    return new(MaaTaskRunKind.Runout, task, null);
                }

                var result = await ExecuteAsync(state, task, recognition, token, parentTask, retry);
                if (result.Kind != MaaTaskRunKind.NoMatch) return result;
            }

            if (timeoutMs >= 0 && overall.ElapsedMilliseconds >= timeoutMs)
                return new(MaaTaskRunKind.NoMatch, null, null);

            retry++;
            Emit(new(MaaPipelineTraceKind.Retrying, runId, options.TaskChain, taskId, parentTask, null, retry, 0,
                overall.Elapsed, null, null, null, null, null, null, $"等待候选节点（{retry}）", null, null, null));
            var requestedDelay = rateLimitMs > 0 ? rateLimitMs : (int)Math.Max(0, options.RetryInterval.TotalMilliseconds);
            if (requestedDelay > 0)
            {
                var delay = timeoutMs < 0
                    ? requestedDelay
                    : Math.Min(requestedDelay, Math.Max(1, timeoutMs - (int)overall.ElapsedMilliseconds));
                await Task.Delay(delay, token);
            }
        }
    }

    async Task<MaaTaskRunOutcome> ExecuteAsync(
        TState state,
        MaaPipelineTask task,
        MaaPipelineRecognitionResult recognition,
        CancellationToken token,
        string? parentTask,
        int attempt)
    {
        var id = taskId++;
        var executionCount = Increment(task.Name);
        lastTask = task.Name;
        var context = CreateContext(state, task, parentTask, attempt, executionCount, id);
        var stopwatch = System.Diagnostics.Stopwatch.StartNew();
        Emit(new(MaaPipelineTraceKind.NodeStarted, runId, options.TaskChain, id, task.Name, parentTask, attempt,
            executionCount, TimeSpan.Zero, true, recognition.Score, recognition.Box, recognition.Text, task.Action.ToString(), null, null,
            recognition.EvidencePath, recognition.FrameId));

        try
        {
            if (task.PreDelayMs > 0) await Task.Delay(task.PreDelayMs, token);
            Emit(new(MaaPipelineTraceKind.ActionStarted, runId, options.TaskChain, id, task.Name, parentTask, attempt,
                executionCount, stopwatch.Elapsed, true, recognition.Score, recognition.Box, recognition.Text, task.Action.ToString(), null, null,
                recognition.EvidencePath, recognition.FrameId));

            MaaPipelineActionResult action;
            if (task.Action == MaaPipelineAction.Stop) action = MaaPipelineActionResult.Stop();
            else
            {
                var handler = GetHandler(task);
                action = await handler.ExecuteAsync(task, recognition, context, token);
            }
            if (action.Interrupted)
            {
                Emit(new(MaaPipelineTraceKind.Stopped, runId, options.TaskChain, id, task.Name, parentTask, attempt,
                    executionCount, stopwatch.Elapsed, true, recognition.Score, recognition.Box, recognition.Text, task.Action.ToString(),
                    action.Error, action.Error, recognition.EvidencePath, recognition.FrameId));
                return new(MaaTaskRunKind.Interrupted, task, action.Error);
            }
            if (!action.Succeeded) return FailNode(task, context, recognition, stopwatch.Elapsed, action.Error ?? "动作执行失败");

            foreach (var sub in task.Sub)
            {
                var child = await FindAndRunAsync(state, [sub], token, followNext: false, task.Name, 0, 0);
                if (child.Kind is MaaTaskRunKind.Failed or MaaTaskRunKind.NoMatch or MaaTaskRunKind.Interrupted)
                {
                    if (!task.SubErrorIgnored)
                        return FailNode(task, context, recognition, stopwatch.Elapsed, child.Error ?? $"子任务失败：{sub}");
                }
            }

            if (task.PostDelayMs > 0) await Task.Delay(task.PostDelayMs, token);
            foreach (var other in task.ReduceOtherTimes) Decrement(other);
            Emit(new(MaaPipelineTraceKind.NodeCompleted, runId, options.TaskChain, id, task.Name, parentTask, attempt,
                executionCount, stopwatch.Elapsed, true, recognition.Score, recognition.Box, recognition.Text, task.Action.ToString(), null, null,
                recognition.EvidencePath, recognition.FrameId));
            return new(MaaTaskRunKind.Success, task, null);
        }
        catch (OperationCanceledException) when (token.IsCancellationRequested)
        {
            throw;
        }
        catch (Exception ex)
        {
            return FailNode(task, context, recognition, stopwatch.Elapsed, ex.Message);
        }
    }

    MaaTaskRunOutcome FailNode(
        MaaPipelineTask task,
        MaaPipelineTaskContext<TState> context,
        MaaPipelineRecognitionResult recognition,
        TimeSpan duration,
        string error)
    {
        Emit(new(MaaPipelineTraceKind.NodeFailed, runId, options.TaskChain, context.TaskId, task.Name, context.ParentTask,
            context.Attempt, context.ExecutionCount, duration, true, recognition.Score, recognition.Box, recognition.Text,
            task.Action.ToString(), null, error, recognition.EvidencePath, recognition.FrameId));
        return new(MaaTaskRunKind.Failed, task, error);
    }

    IMaaPipelineHandler<TState> GetHandler(MaaPipelineTask task)
        => handlers.TryGetValue(task.Handler, out var handler)
            ? handler
            : throw new InvalidDataException($"任务 {task.Name} 没有注册 handler：{task.Handler}");

    MaaPipelineTaskContext<TState> CreateContext(
        TState state,
        MaaPipelineTask task,
        string? parentTask,
        int attempt,
        int executionCount,
        int? id = null)
        => new(state, runId, options.TaskChain, task.Name, id ?? taskId, parentTask, attempt, executionCount,
            new Dictionary<string, int>(executionCounts, StringComparer.OrdinalIgnoreCase));

    int GetCount(string name)
    {
        lock (countLock) return executionCounts.TryGetValue(name, out var value) ? value : 0;
    }

    int Increment(string name)
    {
        lock (countLock)
        {
            executionCounts[name] = GetCount(name) + 1;
            return executionCounts[name];
        }
    }

    void Decrement(string name)
    {
        lock (countLock)
            if (executionCounts.TryGetValue(name, out var value)) executionCounts[name] = Math.Max(0, value - 1);
    }

    void EmitBranch(MaaPipelineTask? task, IReadOnlyList<string> candidates)
    {
        Emit(new(MaaPipelineTraceKind.BranchSelected, runId, options.TaskChain, taskId, task?.Name, null, 0,
            task is null ? 0 : GetCount(task.Name), TimeSpan.Zero, null, null, null, null, null,
            task is null ? null : string.Join(",", candidates), null, null, null, candidates));
    }

    void EmitFailure(string error)
    {
        Emit(new(MaaPipelineTraceKind.TaskChainFailed, runId, options.TaskChain, taskId, lastTask, null, 0, 0,
            TimeSpan.Zero, null, null, null, null, null, null, error, null, null));
    }

    void Emit(MaaPipelineTraceEvent value)
    {
        try { trace?.Write(value); } catch { /* trace 不得破坏自动化 */ }
    }

    enum MaaTaskRunKind
    {
        Success,
        Runout,
        Failed,
        NoMatch,
        Interrupted
    }

    sealed record MaaTaskRunOutcome(MaaTaskRunKind Kind, MaaPipelineTask? Task, string? Error);
}

/// <summary>
/// 将现有受限 TaskPipeline handler 适配到完整 MAA 运行时，便于分阶段迁移领域任务。
/// </summary>
public static class MaaPipelineHandlerAdapter
{
    public static IMaaPipelineHandler<TState> FromLegacy<TState>(ITaskPipelineHandler<TState> handler)
    {
        ArgumentNullException.ThrowIfNull(handler);
        return new DelegateMaaPipelineHandler<TState>(
            handler.Name,
            async (_, context, token) =>
            {
                var canRun = await handler.CanRunAsync(
                    new TaskPipelineContext<TState>(context.State, context.RunId, context.TaskName,
                        context.Attempt, 0, new Dictionary<string, int>(context.ExecutionCounts, StringComparer.OrdinalIgnoreCase)), token);
                return canRun ? MaaPipelineRecognitionResult.Hit() : MaaPipelineRecognitionResult.Miss();
            },
            async (_, _, context, token) =>
            {
                var result = await handler.ExecuteAsync(
                    new TaskPipelineContext<TState>(context.State, context.RunId, context.TaskName,
                        context.Attempt, 0, new Dictionary<string, int>(context.ExecutionCounts, StringComparer.OrdinalIgnoreCase)), token);
                return result.Succeeded
                    ? MaaPipelineActionResult.Success()
                    : MaaPipelineActionResult.Failure(result.Error ?? "旧任务 handler 执行失败");
            });
    }
}
