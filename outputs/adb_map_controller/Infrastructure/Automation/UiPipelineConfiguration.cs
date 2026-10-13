using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.Json;

namespace AdbMapController;

public sealed class UiPipelineDefinition
{
    public int Version { get; set; }
    public string Name { get; set; } = "";
    public List<UiPipelineNodeDefinition> Nodes { get; set; } = [];
}

public sealed class UiPipelineNodeDefinition
{
    public string Name { get; set; } = "";
    public string Result { get; set; } = "";
    public string Recognizer { get; set; } = "";
    public int Priority { get; set; }
    public bool Enabled { get; set; } = true;
    public int MaxAttempts { get; set; } = 1;
}

public static class UiPipelineDefinitionLoader
{
    static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNameCaseInsensitive = true,
        ReadCommentHandling = JsonCommentHandling.Skip,
        AllowTrailingCommas = true
    };

    public static UiPipelineDefinition Load(string path)
    {
        if (string.IsNullOrWhiteSpace(path)) throw new ArgumentException("UI Pipeline 配置路径不能为空", nameof(path));
        if (!File.Exists(path)) throw new FileNotFoundException("UI Pipeline 配置不存在", path);

        UiPipelineDefinition? definition;
        try
        {
            definition = JsonSerializer.Deserialize<UiPipelineDefinition>(File.ReadAllText(path), JsonOptions);
        }
        catch (JsonException ex)
        {
            throw new InvalidDataException($"UI Pipeline 配置 JSON 无法解析：{path}", ex);
        }

        if (definition is null) throw new InvalidDataException($"UI Pipeline 配置为空：{path}");
        Validate(definition, path);
        definition.Nodes = definition.Nodes
            .Where(node => node.Enabled)
            .OrderBy(node => node.Priority)
            .ToList();
        return definition;
    }

    static void Validate(UiPipelineDefinition definition, string path)
    {
        if (definition.Version != 1)
            throw new InvalidDataException($"不支持的 UI Pipeline 版本 {definition.Version}：{path}");
        if (string.IsNullOrWhiteSpace(definition.Name))
            throw new InvalidDataException($"UI Pipeline 缺少 name：{path}");
        if (definition.Nodes.Count == 0)
            throw new InvalidDataException($"UI Pipeline 没有启用节点：{path}");

        var names = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        foreach (var node in definition.Nodes)
        {
            if (string.IsNullOrWhiteSpace(node.Name))
                throw new InvalidDataException($"UI Pipeline 存在空节点名：{path}");
            if (!names.Add(node.Name))
                throw new InvalidDataException($"UI Pipeline 节点名重复：{node.Name}（{path}）");
            if (string.IsNullOrWhiteSpace(node.Result))
                throw new InvalidDataException($"节点 {node.Name} 缺少 result：{path}");
            if (string.IsNullOrWhiteSpace(node.Recognizer))
                throw new InvalidDataException($"节点 {node.Name} 缺少 recognizer：{path}");
            if (node.MaxAttempts < 1 || node.MaxAttempts > 10)
                throw new InvalidDataException($"节点 {node.Name} 的 maxAttempts 必须在 1~10：{path}");
        }
    }
}
