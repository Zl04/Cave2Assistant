using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;

namespace AdbMapController;

public sealed class MapPanel : Panel
{
    const float MinZoom = .5f;
    const float DefaultZoom = 1f;
    const float MaxZoom = 4f;
    const float ZoomStep = 1.15f;
    const float PanMargin = 180f;
    readonly Dictionary<string, Image> icons = LoadIcons();
    MapDump? map;
    PointF panOffset;
    float zoom = DefaultZoom;
    Cell? lastCenteredPlayer;
    Cell? lastObservedPlayer;
    bool manualPanActive;
    Point dragStart;
    PointF dragStartOffset;
    bool dragging;
    bool dragMoved;
    bool compactMode;
    Size lastCenteredViewport;
    ThemePalette theme = ThemePalette.Light;
    public event EventHandler<MapCellClickedEventArgs>? CellClicked;
    /// <summary>
    /// 镜像游戏的跟随玩家 minimap。紧凑模式下，面板只显示地图标题和地图内容，
    /// 并将玩家保持在视口中心，即使玩家靠近地图边缘也是如此。
    /// </summary>
    public bool CompactMode
    {
        get => compactMode;
        set
        {
            if (compactMode == value) return;
            compactMode = value;
            lastCenteredPlayer = null;
            lastCenteredViewport = Size.Empty;
            manualPanActive = false;
            Invalidate();
        }
    }
    public MapDump? Map
    {
        get => map;
        set
        {
            if (HasMapIdentityChanged(map, value))
            {
                panOffset = PointF.Empty;
                lastCenteredPlayer = null;
                lastObservedPlayer = null;
                lastCenteredViewport = Size.Empty;
                manualPanActive = false;
            }
            map = value;
        }
    }
    public IReadOnlyList<Cell> Route { get; set; } = [];
    public string StatusText { get; set; } = "未连接";
    public string InfoText { get; set; } = "";
    public MapPanel()
    {
        DoubleBuffered = true;
        SetStyle(ControlStyles.StandardClick | ControlStyles.StandardDoubleClick, true);
        Tag = ThemeRole.Map;
        ResizeRedraw = true;
        Cursor = Cursors.Hand;
    }

    public void ApplyTheme(ThemePalette palette)
    {
        theme = palette;
        BackColor = palette.MapBackground;
        Invalidate();
    }

    protected override void OnMouseDown(MouseEventArgs e)
    {
        base.OnMouseDown(e);
        if (CompactMode || e.Button != MouseButtons.Left || Map is null) return;
        Focus();
        dragging = true;
        dragMoved = false;
        dragStart = e.Location;
        dragStartOffset = panOffset;
        Cursor = Cursors.SizeAll;
        Capture = true;
    }

    protected override void OnMouseMove(MouseEventArgs e)
    {
        base.OnMouseMove(e);
        if (!dragging) return;
        if (Math.Abs(e.X - dragStart.X) + Math.Abs(e.Y - dragStart.Y) >= 5)
        {
            dragMoved = true;
            manualPanActive = true;
        }
        panOffset = new PointF(
            dragStartOffset.X + e.X - dragStart.X,
            dragStartOffset.Y + e.Y - dragStart.Y);
        ClampPanOffset();
        Invalidate();
    }

    protected override void OnMouseUp(MouseEventArgs e)
    {
        base.OnMouseUp(e);
        if (e.Button != MouseButtons.Left) return;
        var wasClick = dragging && !dragMoved;
        dragging = false;
        Capture = false;
        Cursor = Cursors.Hand;
        if (wasClick && TryHitCell(e.Location, out var cell))
            CellClicked?.Invoke(this, new MapCellClickedEventArgs(cell));
    }

    protected override void OnMouseWheel(MouseEventArgs e)
    {
        base.OnMouseWheel(e);
        if (CompactMode || Map is null || (ModifierKeys & Keys.Control) == 0) return;

        var ground = GroundTiles();
        if (ground.Count == 0) return;
        ClampPanOffset();

        var before = new MapProjection(ground, Width, Height, panOffset, zoom);
        var mapPosition = before.MapPositionAt(e.Location);
        var steps = e.Delta / 120f;
        var nextZoom = Math.Clamp(zoom * MathF.Pow(ZoomStep, steps), MinZoom, MaxZoom);
        if (Math.Abs(nextZoom - zoom) < .0001f) return;

        zoom = nextZoom;
        if (Math.Abs(zoom - DefaultZoom) < .0001f) lastCenteredPlayer = null;
        var after = new MapProjection(ground, Width, Height, panOffset, zoom);
        var anchor = after.PointAt(mapPosition.X, mapPosition.Y);
        panOffset = new PointF(panOffset.X + e.X - anchor.X, panOffset.Y + e.Y - anchor.Y);
        ClampPanOffset();
        Invalidate();
    }

    bool TryHitCell(Point point, out Cell cell)
    {
        cell = default;
        if (Map is null) return false;
        var ground = GroundTiles();
        if (ground.Count == 0) return false;
        ClampPanOffset();
        var projection = new MapProjection(ground, Width, Height, panOffset, zoom);
        var candidate = projection.CellAt(point);
        if (!Map.ByCell.TryGetValue(candidate, out var tile)) return false;
        var center = projection.Point(candidate);
        if (Math.Abs(point.X - center.X) > projection.Scale / 2 || Math.Abs(point.Y - center.Y) > projection.Scale / 2) return false;
        // 占位格在游戏中不是独立的交互目标。
        // 将其解析到锚定角色，使点击任意被占据的方格都打开相同的 NPC 交互。
        cell = Map.ResolveInteractiveCell(candidate);
        return true;
    }

    protected override void OnMouseDoubleClick(MouseEventArgs e)
    {
        base.OnMouseDoubleClick(e);
        if (e.Button != MouseButtons.Left) return;
        ResetMapPosition();
    }

    void ResetMapPosition()
    {
        panOffset = PointF.Empty;
        zoom = DefaultZoom;
        lastCenteredPlayer = null;
        lastCenteredViewport = Size.Empty;
        manualPanActive = false;
        Invalidate();
    }

    protected override void Dispose(bool disposing)
    {
        if (disposing)
        {
            foreach (var image in icons.Values) image.Dispose();
            icons.Clear();
        }
        base.Dispose(disposing);
    }

    protected override void OnPaint(PaintEventArgs e)
    {
        base.OnPaint(e); if (Map is null) return;
        var ground = GroundTiles(); if (ground.Count == 0) return;
        CenterPlayerAfterMovement(ground);
        if (!CompactMode) ClampPanOffset();
        var projection = new MapProjection(ground, Width, Height, panOffset, zoom);
        var scale = projection.Scale;
        PointF P(Cell c) => projection.Point(c);
        var mapRoles = ground.SelectMany(tile => tile.Roles).ToList();
        var positionedTownIcons = (Map.SceneType == 1 ? Map.TownIcons : [])
            .Where(icon => icon.HasPosition)
            .Select(icon => (Icon: icon, Role: mapRoles.FirstOrDefault(icon.Matches) ?? icon.ToRoleInfo()))
            .Select(pair => MapIconCatalog.TryGetTownIcon(pair.Role, out var townIcon)
                ? (pair.Icon, pair.Role, TownIcon: (TownMapIcon?)townIcon)
                : (pair.Icon, pair.Role, TownIcon: (TownMapIcon?)null))
            .Where(pair => pair.TownIcon is not null)
            .ToList();
        var positionedTownRoles = positionedTownIcons.Select(pair => pair.Role).ToHashSet();
        foreach (var tile in ground)
        {
            var p = P(new(tile.X, tile.Y));
            using var brush = new SolidBrush(!tile.Reachable ? theme.MapUnreachable : tile.Explored ? theme.MapExplored : theme.MapUnexplored);
            e.Graphics.FillRectangle(brush, p.X - scale / 2 + 1, p.Y - scale / 2 + 1, scale - 2, scale - 2);
            if (!tile.Reachable) e.Graphics.DrawLine(Pens.IndianRed, p.X - scale * .28f, p.Y - scale * .28f, p.X + scale * .28f, p.Y + scale * .28f);
            var roleIndex = 0;
            foreach (var role in tile.Roles.Where(r => r.Kind.Length > 0 && !positionedTownRoles.Contains(r)))
                DrawRole(e.Graphics, role, p, Math.Max(10, scale * 1.15f), roleIndex++);
        }
        for (var index = 0; index < positionedTownIcons.Count; index++)
        {
            var positioned = positionedTownIcons[index];
            if (!Map.ByCell.ContainsKey(new Cell(positioned.Icon.X, positioned.Icon.Y))) continue;
            DrawTownRole(e.Graphics, positioned.TownIcon!, positioned.Role,
                P(new Cell(positioned.Icon.X, positioned.Icon.Y)), Math.Max(10, scale * 1.15f), index);
        }
        if (Route.Count > 1)
        {
            using var pen = new Pen(theme.MapRoute, Math.Max(2, scale * .18f));
            e.Graphics.DrawLines(pen, Route.Select(P).ToArray());
        }
        var player = P(new(Map.Player.X, Map.Player.Y));
        if (icons.TryGetValue("人物", out var playerIcon)) DrawCentered(e.Graphics, playerIcon, player, Math.Max(14, scale * 1.35f), 0);
        else { using var playerBrush = new SolidBrush(theme.MapPlayer); e.Graphics.FillEllipse(playerBrush, player.X - scale * .42f, player.Y - scale * .42f, scale * .84f, scale * .84f); }
        if (CompactMode)
        {
            DrawMapNameOverlay(e.Graphics);
            using var border = new Pen(theme.MapOverlayBorder, 1);
            e.Graphics.DrawRectangle(border, 0, 0, Math.Max(0, Width - 1), Math.Max(0, Height - 1));
            return;
        }
        if (BossSealPolicy.AppliesTo(Map)) DrawWarningOverlay(e.Graphics, Map.BossSeal);
        DrawMapNameOverlay(e.Graphics);
        DrawInfoOverlay(e.Graphics);
        DrawTownSummary(e.Graphics);
        DrawStatusOverlay(e.Graphics);
    }

    void ClampPanOffset()
    {
        var ground = GroundTiles();
        if (ground.Count == 0) return;
        var projection = new MapProjection(ground, Width, Height, panOffset, zoom);
        panOffset = projection.ClampOffset(panOffset, PanMargin);
    }

    List<TileInfo> GroundTiles() => Map?.Tiles.SelectMany(row => row).Where(tile => tile.Ground).ToList() ?? [];

    void CenterPlayerAfterMovement(IReadOnlyList<TileInfo> ground)
    {
        if (Map is null) return;
        var projection = new MapProjection(ground, Width, Height, panOffset, zoom);
        var player = new Cell(Map.Player.X, Map.Player.Y);
        var playerMoved = lastObservedPlayer is null || lastObservedPlayer.Value != player;
        lastObservedPlayer = player;

        // 完整地图已经可见时，跟随玩家只会产生不必要的移动，并可能撤销用户有意进行的平移。
        if (!CompactMode && projection.FitsViewport)
        {
            lastCenteredPlayer = null;
            return;
        }

        if (!CompactMode && !playerMoved && manualPanActive) return;
        if (!CompactMode && !playerMoved && lastCenteredPlayer == player && lastCenteredViewport == Size) return;
        if (playerMoved) manualPanActive = false;

        var playerPosition = projection.Point(player);
        var targetOffset = new PointF(
            panOffset.X + Width / 2f - playerPosition.X,
            panOffset.Y + Height / 2f - playerPosition.Y);
        panOffset = CompactMode ? targetOffset : projection.ClampOffset(targetOffset, PanMargin);

        var centeredProjection = new MapProjection(ground, Width, Height, panOffset, zoom);
        var centeredPosition = centeredProjection.Point(player);
        lastCenteredPlayer = Math.Abs(centeredPosition.X - Width / 2f) < 1f &&
            Math.Abs(centeredPosition.Y - Height / 2f) < 1f ? player : null;
        lastCenteredViewport = Size;
    }

    static bool HasMapIdentityChanged(MapDump? previous, MapDump? current) =>
        previous is null || current is null ||
        previous.Level != current.Level ||
        previous.SceneType != current.SceneType ||
        previous.TownMapId != current.TownMapId ||
        previous.CaveMode != current.CaveMode ||
        previous.MapName != current.MapName ||
        previous.Width != current.Width ||
        previous.Height != current.Height;

    void DrawMapNameOverlay(Graphics g)
    {
        var text = MapDisplayName.Format(Map!);
        var fontSize = CompactMode ? 9 : 14;
        using var font = new Font(FontFamily.GenericSansSerif, fontSize, FontStyle.Bold, GraphicsUnit.Pixel);
        var maxTextWidth = Math.Max(100, Width - 38);
        var measured = TextRenderer.MeasureText(g, text, font, new Size(maxTextWidth, 0),
            TextFormatFlags.NoPadding | TextFormatFlags.EndEllipsis);
        var x = CompactMode
            ? Math.Max(8, (Width - measured.Width - 18) / 2)
            : Math.Max(8, Width - measured.Width - 28);
        var rect = new Rectangle(x, 10, measured.Width + 18, measured.Height + 10);
        using var back = new SolidBrush(theme.MapOverlayBackground);
        using var border = new Pen(theme.AccentText, 1);
        g.FillRectangle(back, rect); g.DrawRectangle(border, rect);
        TextRenderer.DrawText(g, text, font, new Rectangle(rect.X + 9, rect.Y + 5, rect.Width - 18, rect.Height),
            theme.AccentText, TextFormatFlags.NoPadding | TextFormatFlags.EndEllipsis | TextFormatFlags.Right);
    }

    void DrawInfoOverlay(Graphics g)
    {
        var text = CurrentInfoText();
        if (string.IsNullOrWhiteSpace(text)) return;
        using var font = new Font(FontFamily.GenericSansSerif, 12, FontStyle.Regular, GraphicsUnit.Pixel);
        var lines = text.Split('\n');
        var width = lines.Max(line => TextRenderer.MeasureText(line, font).Width);
        var lineHeight = TextRenderer.MeasureText("Ag", font).Height;
        var rect = new Rectangle(10, InfoOverlayTop(), width + 18, lineHeight * lines.Length + 10);
        using var back = new SolidBrush(theme.MapOverlayBackground);
        using var border = new Pen(theme.MapOverlayBorder, 1);
        g.FillRectangle(back, rect); g.DrawRectangle(border, rect);
        TextRenderer.DrawText(g, text, font, new Rectangle(rect.X + 9, rect.Y + 5, width, lineHeight * lines.Length), theme.MapOverlayText, TextFormatFlags.NoPadding);
    }

    string CurrentInfoText()
    {
        if (Map is null || CompactMode) return InfoText;
        var status = Map.Confused && Map.Reversed ? "混乱/迷惑"
            : Map.Confused ? "混乱"
            : Map.Reversed ? "迷惑"
            : "正常";
        return string.IsNullOrWhiteSpace(InfoText)
            ? $"状态：{status}"
            : $"{InfoText}\n状态：{status}";
    }

    void DrawStatusOverlay(Graphics g)
    {
        if (string.IsNullOrWhiteSpace(StatusText)) return;
        using var font = new Font(FontFamily.GenericSansSerif, 13, FontStyle.Bold, GraphicsUnit.Pixel);
        var text = StatusText.Length > 48 ? StatusText[..48] + "…" : StatusText;
        var size = TextRenderer.MeasureText(text, font);
        var rect = new Rectangle(Math.Max(8, Width - size.Width - 28), Math.Max(8, Height - size.Height - 22), size.Width + 18, size.Height + 10);
        using var back = new SolidBrush(theme.MapOverlayBackground);
        using var border = new Pen(theme.MapRoute, 1);
        g.FillRectangle(back, rect); g.DrawRectangle(border, rect);
        TextRenderer.DrawText(g, text, font, new Rectangle(rect.X + 9, rect.Y + 5, size.Width, size.Height),
            theme.MapOverlayText, TextFormatFlags.NoPadding | TextFormatFlags.VerticalCenter | TextFormatFlags.Right);
    }

    void DrawTownSummary(Graphics g)
    {
        if (Map?.SceneType != 1) return;
        var townIcons = Map.Tiles.SelectMany(row => row).SelectMany(tile => tile.Roles)
            .Where(role => MapIconCatalog.TryGetTownIcon(role, out _))
            .GroupBy(role => role.Kind)
            .ToList();
        if (townIcons.Count == 0) return;

        using var font = new Font(FontFamily.GenericSansSerif, 11, FontStyle.Bold, GraphicsUnit.Pixel);
        var text = $"城镇图标 {townIcons.Sum(group => group.Count())} 个 / {townIcons.Count} 类";
        var size = TextRenderer.MeasureText(text, font);
        var infoTop = string.IsNullOrWhiteSpace(InfoText) ? Height : InfoOverlayTop();
        var y = Math.Max(8, infoTop - size.Height - 16);
        var rect = new Rectangle(10, y, size.Width + 18, size.Height + 10);
        using var back = new SolidBrush(theme.MapOverlayBackground);
        using var border = new Pen(theme.MapTownText, 1);
        g.FillRectangle(back, rect); g.DrawRectangle(border, rect);
        TextRenderer.DrawText(g, text, font, new Rectangle(rect.X + 9, rect.Y + 5, size.Width, size.Height),
            theme.MapTownText, TextFormatFlags.NoPadding | TextFormatFlags.VerticalCenter);
    }

    int InfoOverlayTop()
    {
        using var infoFont = new Font(FontFamily.GenericSansSerif, 12, FontStyle.Regular, GraphicsUnit.Pixel);
        var lineHeight = TextRenderer.MeasureText("Ag", infoFont).Height;
        return Math.Max(8, Height - lineHeight * CurrentInfoText().Split('\n').Length - 22);
    }

    void DrawWarningOverlay(Graphics g, BossSealInfo seal)
    {
        var text = seal.Present
            ? $"预警 {seal.CurScore}/{seal.WakeScore} ({seal.Percent}%) {(seal.Ready ? "Boss可攻击" : "Boss未解锁")}"
            : "预警 --";
        using var font = new Font(FontFamily.GenericSansSerif, 14, FontStyle.Bold, GraphicsUnit.Pixel);
        var size = TextRenderer.MeasureText(text, font);
        var rect = new Rectangle(10, 10, size.Width + 18, size.Height + 10);
        var color = seal.Present && seal.Ready ? theme.SuccessText : theme.WarningText;
        using var back = new SolidBrush(theme.MapOverlayBackground);
        using var border = new Pen(color, 1);
        g.FillRectangle(back, rect); g.DrawRectangle(border, rect);
        TextRenderer.DrawText(g, text, font, new Rectangle(rect.X + 9, rect.Y + 5, size.Width, size.Height),
            color,
            TextFormatFlags.NoPadding | TextFormatFlags.VerticalCenter);
    }

    void DrawRole(Graphics g, RoleInfo role, PointF p, float size, int index)
    {
        if (role.IsTouchTriggerMonster) return;
        var kind = role.Kind;
        if (MapIconCatalog.TryGetTownIcon(role, out var townIcon))
        {
            DrawTownRole(g, townIcon, role, p, size, index);
            return;
        }
        if (role.RoleType == 5 && role.ClassName == "TriggerNpcData")
        {
            var triggered = !MechanismChamberPolicy.IsPendingTrigger(role);
            var offset = index == 0 ? 0 : (index % 2 == 0 ? -1 : 1) * size * .28f;
            var diameter = size * .78f;
            var center = new PointF(p.X + offset, p.Y);
            using var fill = new SolidBrush(triggered ? Color.FromArgb(39, 175, 100) : Color.FromArgb(245, 191, 46));
            using var border = new Pen(Color.White, Math.Max(1f, size * .075f));
            g.FillEllipse(fill, center.X - diameter / 2, center.Y - diameter / 2, diameter, diameter);
            g.DrawEllipse(border, center.X - diameter / 2, center.Y - diameter / 2, diameter, diameter);
            if (triggered)
            {
                using var centerFill = new SolidBrush(Color.White);
                g.FillEllipse(centerFill, center.X - size * .12f, center.Y - size * .12f, size * .24f, size * .24f);
            }
            return;
        }
        if (icons.TryGetValue(kind, out var icon)) { DrawCentered(g, icon, p, size, index); return; }
        if (kind == "未知")
        {
            if (!MapIconCatalog.ShouldDrawUnknownMarker(role)) return;
            var offset = index == 0 ? 0 : (index % 2 == 0 ? -1 : 1) * size * .28f;
            var rect = new RectangleF(p.X - size * .42f + offset, p.Y - size * .42f, size * .84f, size * .84f);
            using var background = new SolidBrush(Color.FromArgb(220, 126, 76, 190));
            using var border = new Pen(Color.White, Math.Max(1f, size * .06f));
            using var font = new Font(FontFamily.GenericSansSerif, Math.Max(7f, size * .55f), FontStyle.Bold, GraphicsUnit.Pixel);
            g.FillEllipse(background, rect); g.DrawEllipse(border, rect);
            TextRenderer.DrawText(g, "?", font, Rectangle.Round(rect), Color.White, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
            return;
        }
        var color = kind switch { "小怪" or "精英" or "小Boss" or "Boss" => Color.Orange, "陷阱" => Color.Red, "木箱" or "金箱" => Color.Gold, "传送门" or "出口" => Color.Cyan, "金币" => Color.Khaki, _ => Color.LightGreen };
        using var b = new SolidBrush(color); g.FillEllipse(b, p.X - size / 3, p.Y - size / 3, size * 2 / 3, size * 2 / 3);
    }

    void DrawTownRole(Graphics g, TownMapIcon townIcon, RoleInfo role, PointF p, float size, int index)
    {
        var assetName = MapIconCatalog.GetAssetName(role);
        Image? icon = null;
        if (assetName is not null) icons.TryGetValue(assetName, out icon);

        // 洞窟 NPC 在 MapIconCatalog 中使用原始图集帧名称，但控制器也附带共用的语义别名
        // （例如 merchant.png 和 exit.png）。优先使用源码帧；该帧未打包时使用语义别名，
        // 否则有效的 merchant/exit/portal 角色会退化为普通圆点。
        if (icon is null) icons.TryGetValue(role.Kind, out icon);
        if (icon is not null)
        {
            DrawCentered(g, icon, p, size, index);
            if (role.Locked) DrawLockedBadge(g, p, size, index);
            return;
        }

        // 如果未来游戏版本新增 minimap 类型，但尚未提取其图集帧，
        // 保留一个可见且无文字的回退图标。
        var offset = index == 0 ? 0 : (index % 2 == 0 ? -1 : 1) * size * .28f;
        var diameter = size * .92f;
        var rect = new RectangleF(p.X - diameter / 2 + offset, p.Y - diameter / 2, diameter, diameter);
        using var background = new SolidBrush(TownPaletteColor(townIcon.Palette));
        using var border = new Pen(Color.FromArgb(238, 250, 255), Math.Max(1f, size * .065f));
        g.FillEllipse(background, rect);
        g.DrawEllipse(border, rect);
        if (role.Locked) DrawLockedBadge(g, p, size, index);
    }

    static void DrawLockedBadge(Graphics g, PointF p, float size, int index)
    {
        var offset = index == 0 ? 0 : (index % 2 == 0 ? -1 : 1) * size * .28f;
        var badge = new RectangleF(p.X + size * .18f + offset, p.Y + size * .18f, size * .36f, size * .36f);
        using var fill = new SolidBrush(Color.FromArgb(235, 50, 55, 64));
        using var border = new Pen(Color.White, Math.Max(1f, size * .045f));
        using var font = new Font(FontFamily.GenericSansSerif, Math.Max(6f, size * .28f), FontStyle.Bold, GraphicsUnit.Pixel);
        g.FillEllipse(fill, badge); g.DrawEllipse(border, badge);
        TextRenderer.DrawText(g, "锁", font, Rectangle.Round(badge), Color.White,
            TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
    }

    static Color TownPaletteColor(MapIconPalette palette) => palette switch
    {
        MapIconPalette.Amber => Color.FromArgb(211, 143, 33),
        MapIconPalette.Azure => Color.FromArgb(42, 142, 205),
        MapIconPalette.Emerald => Color.FromArgb(35, 166, 119),
        MapIconPalette.Violet => Color.FromArgb(128, 83, 190),
        MapIconPalette.Rose => Color.FromArgb(201, 76, 108),
        _ => Color.FromArgb(87, 111, 137),
    };

    static void DrawCentered(Graphics g, Image image, PointF p, float size, int index)
    {
        var offset = index == 0 ? 0 : (index % 2 == 0 ? -1 : 1) * size * .28f;
        g.DrawImage(image, p.X - size / 2 + offset, p.Y - size / 2, size, size);
    }

    static Dictionary<string, Image> LoadIcons()
    {
        var names = new Dictionary<string, string> { ["人物"]="player", ["小怪"]="monster", ["群怪"]="group_monster", ["精英"]="elite", ["小Boss"]="small_boss", ["Boss"]="boss", ["罐子"]="pot", ["石堆"]="bone", ["木箱"]="wood_chest", ["金箱"]="gold_chest", ["金币"]="gold", ["钥匙"]="key", ["符文"]="rune", ["点金台"]="altar", ["附魔台"]="enchanting", ["商人"]="merchant", ["陷阱"]="trap", ["出口"]="exit", ["传送门"]="portal", ["秘境传送门"]="chamber", ["密室"]="chamber", ["机关密室"]="chamber", ["公会科技"]="ui_minimap_icon_town_upgrade", ["公会商人"]="ui_minimap_icon_town_guildshop", ["公会布告板"]="ui_minimap_icon_town_pipe", ["许愿池"]="guild_wishingpond", ["公会拍卖师"]="guild_auction", ["公会副本"]="guild_selectfloor" };
        var result = new Dictionary<string, Image>(); var folder = Path.Combine(AppContext.BaseDirectory, "icons");
        if (!Directory.Exists(folder)) return result;
        foreach (var pair in names) { var path = Path.Combine(folder, pair.Value + ".png"); if (File.Exists(path)) result[pair.Key] = Image.FromFile(path); }
        // 同时从游戏的 minimap 图集中加载原始帧名称。
        // 这样 MapIconCatalog 就能根据 minimapType 选择城镇/洞窟变体。
        foreach (var path in Directory.EnumerateFiles(folder, "*.png"))
        {
            var frameName = Path.GetFileNameWithoutExtension(path);
            if (!result.ContainsKey(frameName)) result[frameName] = Image.FromFile(path);
        }
        return result;
    }
}

public sealed class MapCellClickedEventArgs(Cell cell) : EventArgs
{
    public Cell Cell { get; } = cell;
}
