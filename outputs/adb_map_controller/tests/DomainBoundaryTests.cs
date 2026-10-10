using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;

namespace AdbMapController.Tests;

public sealed class DomainBoundaryTests
{
    // Compile a separate in-memory guard with BCL references only. The behavioral
    // tests still exercise the production ProjectReference; this does not replace it.
    static Diagnostic[] Errors(string? negative = null, bool includeUseCases = false)
    {
        var sources = Directory.GetFiles(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Architecture", "Domain"), "*.cs", SearchOption.AllDirectories);
        Assert.NotEmpty(sources);
        var trees = sources.Select(path => CSharpSyntaxTree.ParseText(File.ReadAllText(path), path: path)).ToList();
        if (includeUseCases)
            foreach (var module in new[] { "Navigation", "Application" })
                trees.AddRange(Directory.GetFiles(Path.Combine(AppContext.BaseDirectory, "Fixtures", "Architecture", module), "*.cs", SearchOption.AllDirectories)
                    .Select(path => CSharpSyntaxTree.ParseText(File.ReadAllText(path), path: path)));
        trees.Add(CSharpSyntaxTree.ParseText("global using System; global using System.IO; global using System.Linq; global using System.Collections.Generic; global using System.Threading; global using System.Threading.Tasks;"));
        if (negative is not null) trees.Add(CSharpSyntaxTree.ParseText(negative));
        var paths = ((string)AppContext.GetData("TRUSTED_PLATFORM_ASSEMBLIES")!).Split(Path.PathSeparator);
        var coreRuntime = Path.GetDirectoryName(typeof(object).Assembly.Location);
        var references = paths.Where(path => string.Equals(Path.GetDirectoryName(path), coreRuntime, StringComparison.OrdinalIgnoreCase))
            .Select(path => MetadataReference.CreateFromFile(path));
        return CSharpCompilation.Create("DomainBoundary", trees, references,
                new CSharpCompilationOptions(OutputKind.DynamicallyLinkedLibrary, nullableContextOptions: NullableContextOptions.Enable))
            .GetDiagnostics().Where(x => x.Severity == DiagnosticSeverity.Error).ToArray();
    }

    [Fact]
    public void DomainBuildsWithOnlyBclAndNoArchitectureAllowlist() => Assert.Empty(Errors());

    [Fact]
    public void NavigationAndApplicationUseCasesBuildWithoutInfrastructureOrDesktop() => Assert.Empty(Errors(includeUseCases: true));

    [Theory]
    [InlineData("AdbClient")]
    [InlineData("MainForm")]
    [InlineData("System.Windows.Forms.Form")]
    public void UseCaseGuardRejectsConcreteInfrastructureAndDesktop(string type)
        => Assert.NotEmpty(Errors($"namespace AdbMapController; public class Forbidden {{ public {type}? Value; }}", includeUseCases: true));

    [Theory]
    [InlineData("System.Windows.Forms.Form")]
    [InlineData("System.Drawing.Bitmap")]
    public void GuardRejectsDesktopFrameworkEvenWhenInstalled(string type)
        => Assert.NotEmpty(Errors($"namespace AdbMapController; public class Forbidden {{ public {type}? Value; }}"));

    [Theory]
    [InlineData("PortalRouting")]
    [InlineData("AdbClient")]
    [InlineData("MainForm")]
    public void GuardRejectsNavigationInfrastructureAndPresentationReferences(string type)
        => Assert.Contains(Errors($"namespace AdbMapController; public class Forbidden {{ public {type}? Value; }}"),
            x => x.Id == "CS0246" && x.GetMessage().Contains(type));

    [Theory]
    [InlineData(1, false, "ui_minimap_icon_room")]
    [InlineData(3, false, "ui_minimap_icon_room")]
    [InlineData(3, true, "ui_minimap_icon_room_purple")]
    [InlineData(0, true, "ui_minimap_icon_room")]
    public void RoomPortalAssetClassificationKeepsProtocolValues(int mode, bool random, string asset)
    {
        var role = new RoleInfo { ClassName = "TriggerNpcData", RoleType = 1, MinimapType = 22, TransdoorType = mode, IsRandomTransfer = random };
        Assert.Equal("秘境传送门", role.Kind);
        Assert.Equal(asset, MapIconCatalog.GetAssetName(role));
        Assert.Equal(3, PortalRouting.RoomToRoomTransdoorType);
    }

    [Theory]
    [InlineData(1, PortalTransferMode.NextLevel)]
    [InlineData(2, PortalTransferMode.CaveToTown)]
    [InlineData(3, PortalTransferMode.RoomToRoom)]
    [InlineData(4, PortalTransferMode.GuildToTown)]
    [InlineData(5, PortalTransferMode.TownToGuild)]
    [InlineData(6, PortalTransferMode.BlackHouseToTown)]
    [InlineData(7, PortalTransferMode.TownCaveToTown)]
    [InlineData(8, PortalTransferMode.TownToTownCave)]
    [InlineData(9, PortalTransferMode.TownToManor)]
    [InlineData(10, PortalTransferMode.ManorToTown)]
    [InlineData(11, PortalTransferMode.TownToBigSailPort)]
    [InlineData(12, PortalTransferMode.BigSailPortToTown)]
    public void AllTransferModesKeepClassification(int mode, PortalTransferMode expected)
        => Assert.Equal(expected, PortalRouting.GetTransferMode(new RoleInfo { ClassName = "TriggerNpcData", RoleType = 1, MinimapType = 18, TransdoorType = mode }));
}
