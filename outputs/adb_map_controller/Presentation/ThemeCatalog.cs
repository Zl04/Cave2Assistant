using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace AdbMapController;

/// <summary>
/// Stable names exposed by a theme file. The names intentionally follow the
/// semantic/component split used by VS Code workbench colors: a control asks
/// for what a color means, not which RGB value it should use.
/// </summary>
public static class ThemeColorKeys
{
    public const string WindowBackground = "window.background";
    public const string Foreground = "foreground";
    public const string MutedForeground = "foreground.muted";
    public const string AccentForeground = "accent.foreground";
    public const string SuccessForeground = "status.success";
    public const string WarningForeground = "status.warning";
    public const string ErrorForeground = "status.error";
    public const string Border = "border";
    public const string FocusBorder = "focus.border";
    public const string DisabledForeground = "foreground.disabled";
    public const string SelectionBackground = "selection.background";

    public const string SurfaceBackground = "surface.background";
    public const string SurfaceAlternativeBackground = "surface.alternativeBackground";
    public const string SurfaceHoverBackground = "surface.hoverBackground";
    public const string InputBackground = "input.background";

    public const string SecondaryButtonBackground = "button.secondary.background";
    public const string PrimaryButtonBackground = "button.primary.background";
    public const string SuccessButtonBackground = "button.success.background";
    public const string WarningButtonBackground = "button.warning.background";
    public const string DangerButtonBackground = "button.danger.background";
    public const string InfoButtonBackground = "button.info.background";
    public const string UtilityButtonBackground = "button.utility.background";
    public const string ButtonForeground = "button.foreground";

    public const string MapBackground = "map.background";
    public const string MapUnreachable = "map.unreachable";
    public const string MapExplored = "map.explored";
    public const string MapUnexplored = "map.unexplored";
    public const string MapRoute = "map.route";
    public const string MapPlayer = "map.player";
    public const string MapOverlayBackground = "map.overlay.background";
    public const string MapOverlayBorder = "map.overlay.border";
    public const string MapOverlayForeground = "map.overlay.foreground";
    public const string MapTownForeground = "map.town.foreground";
}

public sealed class ThemeDefinition
{
    [JsonPropertyName("id")]
    public string Id { get; init; } = "";

    [JsonPropertyName("type")]
    public string Type { get; init; } = "dark";

    [JsonPropertyName("colors")]
    public Dictionary<string, string> Colors { get; init; } = new(StringComparer.OrdinalIgnoreCase);
}

public static class ThemeCatalog
{
    static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNameCaseInsensitive = true,
        ReadCommentHandling = JsonCommentHandling.Skip,
        AllowTrailingCommas = true,
    };

    public static ThemePalette LoadBuiltIn(ThemeMode mode, ThemePalette fallback)
    {
        var id = mode == ThemeMode.Dark ? "dark" : "light";
        var path = Path.Combine(AppContext.BaseDirectory, "themes", id + ".json");
        if (!File.Exists(path)) return fallback;

        try
        {
            var definition = JsonSerializer.Deserialize<ThemeDefinition>(File.ReadAllText(path), JsonOptions);
            return definition is null ? fallback : ThemePaletteFactory.FromDefinition(definition, fallback);
        }
        catch
        {
            // An optional theme must never prevent the controller from starting.
            return fallback;
        }
    }
}

static class ThemePaletteFactory
{
    public static ThemePalette FromDefinition(ThemeDefinition definition, ThemePalette fallback)
    {
        var colors = definition.Colors;
        return new ThemePalette(
            WindowBackground: Read(colors, ThemeColorKeys.WindowBackground, fallback.WindowBackground),
            Surface: Read(colors, ThemeColorKeys.SurfaceBackground, fallback.Surface),
            SurfaceAlt: Read(colors, ThemeColorKeys.SurfaceAlternativeBackground, fallback.SurfaceAlt),
            InputBackground: Read(colors, ThemeColorKeys.InputBackground, fallback.InputBackground),
            Text: Read(colors, ThemeColorKeys.Foreground, fallback.Text),
            MutedText: Read(colors, ThemeColorKeys.MutedForeground, fallback.MutedText),
            AccentText: Read(colors, ThemeColorKeys.AccentForeground, fallback.AccentText),
            SuccessText: Read(colors, ThemeColorKeys.SuccessForeground, fallback.SuccessText),
            WarningText: Read(colors, ThemeColorKeys.WarningForeground, fallback.WarningText),
            ErrorText: Read(colors, ThemeColorKeys.ErrorForeground, fallback.ErrorText),
            Border: Read(colors, ThemeColorKeys.Border, fallback.Border),
            FocusBorder: Read(colors, ThemeColorKeys.FocusBorder, fallback.FocusBorder),
            DisabledText: Read(colors, ThemeColorKeys.DisabledForeground, fallback.DisabledText),
            SelectionBackground: Read(colors, ThemeColorKeys.SelectionBackground, fallback.SelectionBackground),
            SurfaceHover: Read(colors, ThemeColorKeys.SurfaceHoverBackground, fallback.SurfaceHover),
            ButtonSecondary: Read(colors, ThemeColorKeys.SecondaryButtonBackground, fallback.ButtonSecondary),
            ButtonAccent: Read(colors, ThemeColorKeys.PrimaryButtonBackground, fallback.ButtonAccent),
            ButtonSuccess: Read(colors, ThemeColorKeys.SuccessButtonBackground, fallback.ButtonSuccess),
            ButtonWarning: Read(colors, ThemeColorKeys.WarningButtonBackground, fallback.ButtonWarning),
            ButtonDanger: Read(colors, ThemeColorKeys.DangerButtonBackground, fallback.ButtonDanger),
            ButtonInfo: Read(colors, ThemeColorKeys.InfoButtonBackground, fallback.ButtonInfo),
            ButtonUtility: Read(colors, ThemeColorKeys.UtilityButtonBackground, fallback.ButtonUtility),
            ButtonText: Read(colors, ThemeColorKeys.ButtonForeground, fallback.ButtonText),
            MapBackground: Read(colors, ThemeColorKeys.MapBackground, fallback.MapBackground),
            MapUnreachable: Read(colors, ThemeColorKeys.MapUnreachable, fallback.MapUnreachable),
            MapExplored: Read(colors, ThemeColorKeys.MapExplored, fallback.MapExplored),
            MapUnexplored: Read(colors, ThemeColorKeys.MapUnexplored, fallback.MapUnexplored),
            MapRoute: Read(colors, ThemeColorKeys.MapRoute, fallback.MapRoute),
            MapPlayer: Read(colors, ThemeColorKeys.MapPlayer, fallback.MapPlayer),
            MapOverlayBackground: Read(colors, ThemeColorKeys.MapOverlayBackground, fallback.MapOverlayBackground),
            MapOverlayBorder: Read(colors, ThemeColorKeys.MapOverlayBorder, fallback.MapOverlayBorder),
            MapOverlayText: Read(colors, ThemeColorKeys.MapOverlayForeground, fallback.MapOverlayText),
            MapTownText: Read(colors, ThemeColorKeys.MapTownForeground, fallback.MapTownText));
    }

    static Color Read(IReadOnlyDictionary<string, string> colors, string key, Color fallback)
    {
        if (!colors.TryGetValue(key, out var value) || string.IsNullOrWhiteSpace(value)) return fallback;
        return TryParseColor(value, out var parsed) ? parsed : fallback;
    }

    static bool TryParseColor(string value, out Color color)
    {
        color = Color.Empty;
        var hex = value.Trim();
        if (!hex.StartsWith('#')) return false;
        hex = hex[1..];

        if (hex.Length is 3 or 4)
        {
            var expanded = new char[hex.Length * 2];
            for (var i = 0; i < hex.Length; i++)
            {
                expanded[i * 2] = hex[i];
                expanded[i * 2 + 1] = hex[i];
            }
            hex = new string(expanded);
        }

        if (hex.Length is not (6 or 8) || !uint.TryParse(hex, System.Globalization.NumberStyles.HexNumber, null, out var raw))
            return false;

        if (hex.Length == 6)
        {
            color = Color.FromArgb(
                (int)((raw >> 16) & 0xff),
                (int)((raw >> 8) & 0xff),
                (int)(raw & 0xff));
            return true;
        }

        // Theme files use the VS Code convention #RRGGBBAA.
        color = Color.FromArgb(
            (int)(raw & 0xff),
            (int)((raw >> 24) & 0xff),
            (int)((raw >> 16) & 0xff),
            (int)((raw >> 8) & 0xff));
        return true;
    }
}
