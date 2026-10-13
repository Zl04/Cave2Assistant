using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using System.Reflection;

namespace AdbMapController.Tests;

public sealed class EntryDifficultyRegressionTests
{
    [Theory]
    [InlineData(DungeonDifficulty.Normal)]
    [InlineData(DungeonDifficulty.Elite)]
    [InlineData(DungeonDifficulty.Nightmare)]
    public void ApplyingTaskPreservesConfiguredDifficulty(DungeonDifficulty difficulty)
    {
        // Replay the production mapping statements without starting ADB/OCR or showing a window.
        var directory = new DirectoryInfo(AppContext.BaseDirectory);
        while (directory is not null && !File.Exists(Path.Combine(directory.FullName, "Presentation", "MainForm.cs")))
            directory = directory.Parent;
        Assert.NotNull(directory);
        var source = File.ReadAllText(Path.Combine(directory!.FullName, "Presentation", "MainForm.cs"));
        var start = source.IndexOf("var entryDifficultyIndex =", StringComparison.Ordinal);
        var end = source.IndexOf("RefreshEntryDifficulties(SelectedEntryMap,", start, StringComparison.Ordinal);
        var mapping = source[start..end];
        var tree = CSharpSyntaxTree.ParseText("using System; using AdbMapController; public static class Replay { public static DungeonDifficulty Run(ControllerSettings s) { " + mapping + " return (DungeonDifficulty)entryDifficultyIndex; } }");
        var references = ((string)AppContext.GetData("TRUSTED_PLATFORM_ASSEMBLIES")!).Split(Path.PathSeparator)
            .Append(typeof(ControllerSettings).Assembly.Location).Distinct()
            .Select(path => MetadataReference.CreateFromFile(path));
        var compilation = CSharpCompilation.Create("EntryMappingReplay", [tree], references,
            new CSharpCompilationOptions(OutputKind.DynamicallyLinkedLibrary));
        using var buffer = new MemoryStream();
        var result = compilation.Emit(buffer);
        Assert.True(result.Success, string.Join("\n", result.Diagnostics));
        var run = Assembly.Load(buffer.ToArray()).GetType("Replay")!.GetMethod("Run")!;
        var actual = run.Invoke(null, [new ControllerSettings { EntryDifficulty = difficulty }]);
        Assert.Equal(difficulty, actual);
    }
}
