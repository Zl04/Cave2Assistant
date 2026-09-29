from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

source = Path("outputs/game_minimap_icons")
output = Path("outputs/game_minimap_icons_preview.png")
tokens = (
    "blame", "boss", "chest", "dianjin", "gold", "jar", "material",
    "ordinary", "rune", "me.png", "stairs", "transfer", "pipe", "gem",
)
paths = [p for p in sorted(source.glob("*.png"))
         if p.name != "_atlas.png" and any(t in p.name for t in tokens)]

font = ImageFont.load_default()
cell_w, cell_h, columns = 250, 78, 4
rows = (len(paths) + columns - 1) // columns
sheet = Image.new("RGB", (cell_w * columns, cell_h * rows), "#242424")
draw = ImageDraw.Draw(sheet)
for index, path in enumerate(paths):
    x = index % columns * cell_w
    y = index // columns * cell_h
    icon = Image.open(path).convert("RGBA").resize((60, 60), Image.Resampling.NEAREST)
    sheet.paste(icon, (x + 7, y + 7), icon)
    draw.text((x + 73, y + 29), path.stem, fill="white", font=font)
sheet.save(output)
print(f"icons={len(paths)}, output={output}")
