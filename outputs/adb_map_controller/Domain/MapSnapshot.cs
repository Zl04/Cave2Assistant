using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

namespace AdbMapController;

public sealed record MapSnapshot(
    MapDump Map,
    int Level,
    Cell Player,
    long Timestamp,
    string StructureHash,
    string NavigationHash)
{
    public static MapSnapshot Capture(MapDump map)
    {
        var structure = map.Tiles.SelectMany(row => row)
            .Select(tile => new
            {
                tile.X, tile.Y, tile.TerrainType, tile.Reachable, tile.Explored,
                Roles = tile.Roles.Select(role => new { role.ClassName, role.RoleType, role.MinimapType, role.TransdoorType, role.IsRandomTransfer, role.TreasureType, role.Opened,
                    role.TemplateID, role.OccupyWidth, role.OccupyHeight, role.TalkRange, role.Locked,
                    role.NormalMonster, role.GroupMonster, role.EliteMonster, role.SmallBoss, role.BigBoss }).ToArray(),
                Placeholders = tile.Placeholders.Select(placeholder => new
                {
                    placeholder.TypeName, placeholder.AssociatedID, placeholder.AssociatedX, placeholder.AssociatedY,
                    placeholder.Reachable, placeholder.NodeOfPath, placeholder.EndOfPath
                }).ToArray()
            }).OrderBy(tile => tile.Y).ThenBy(tile => tile.X);
        var townIcons = map.TownIcons.Select(icon => new
        {
            icon.X, icon.Y, icon.SpriteID, icon.TemplateID, icon.RoleType, icon.MinimapType,
            icon.TreasureType, icon.Opened, icon.ClassName
        }).OrderBy(icon => icon.Y).ThenBy(icon => icon.X);
        var structureWithTownIcons = new { Tiles = structure, TownIcons = townIcons };
        var bytes = Encoding.UTF8.GetBytes(JsonSerializer.Serialize(structureWithTownIcons));
        var hash = Convert.ToHexString(SHA256.HashData(bytes));
        var navigation = map.Tiles.SelectMany(row => row)
            .Select(tile => new { tile.X, tile.Y, tile.TerrainType, tile.Reachable })
            .OrderBy(tile => tile.Y).ThenBy(tile => tile.X);
        var navigationBytes = Encoding.UTF8.GetBytes(JsonSerializer.Serialize(navigation));
        var navigationHash = Convert.ToHexString(SHA256.HashData(navigationBytes));
        return new MapSnapshot(map, map.Level, new Cell(map.Player.X, map.Player.Y), map.Timestamp, hash, navigationHash);
    }
}
