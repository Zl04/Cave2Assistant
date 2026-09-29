"""Extract reusable color/offset features from the nine supplied icon crops."""

from __future__ import annotations

import json
from collections import Counter
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont


ROOT = Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp")
ITEMS = [
    ("monster", "怪物", "90ca869d-6e14-4ca7-8d72-a5ce6d86d14d"),
    ("boss", "红怪/BOSS", "fa9051a8-1f59-4892-bb39-98e38c434b38"),
    ("pot", "罐子", "810af66d-7171-49b2-bc88-c9f5b9176fe0"),
    ("stone", "石头", "152dcd76-a9a6-4982-bd70-2edfb528565b"),
    ("chest_normal", "普通箱子", "59fb3d68-e159-41bf-81ce-dc15deb84d3a"),
    ("chest_gold", "金箱子", "1fc4cc95-0647-444c-ab9c-633dcc3cfd12"),
    ("alchemy", "点金机", "cbde525b-78f2-484e-8c8c-6d07e199851e"),
    ("buff", "BUFF/增益", "2360cf48-eb92-446e-9e2b-865eee9f7c64"),
    ("coin", "金币", "5c192089-c603-469c-96e5-21fa4b76e0cd"),
]


def components(mask):
    seen = np.zeros_like(mask)
    found = []
    h, w = mask.shape
    for y, x in zip(*np.nonzero(mask)):
        if seen[y, x]:
            continue
        stack = [(int(x), int(y))]; seen[y, x] = True; points = []
        while stack:
            px, py = stack.pop(); points.append((px, py))
            for ny in range(max(0, py-1), min(h, py+2)):
                for nx in range(max(0, px-1), min(w, px+2)):
                    if mask[ny, nx] and not seen[ny, nx]:
                        seen[ny, nx] = True; stack.append((nx, ny))
        found.append(points)
    return found


def bgr(rgb):
    return f"{rgb[2]:02X}{rgb[1]:02X}{rgb[0]:02X}"


def extract(image):
    rgb = np.asarray(image.convert("RGB"), dtype=np.int16)
    h, w = rgb.shape[:2]
    border = np.concatenate((rgb[0], rgb[-1], rgb[:, 0], rgb[:, -1]))
    background = np.median(border, axis=0)
    chroma = rgb.max(axis=2) - rgb.min(axis=2)
    distance = np.max(np.abs(rgb - background), axis=2)
    seed = (chroma >= 35) & (rgb.max(axis=2) >= 90) & (distance >= 14)
    groups = [group for group in components(seed) if len(group) >= 4]
    center = (w/2, h/2)
    group = min(groups, key=lambda g: min((x-center[0])**2+(y-center[1])**2 for x, y in g))
    core = np.zeros((h, w), dtype=np.uint8)
    for x, y in group:
        core[y, x] = 255
    expanded = np.asarray(Image.fromarray(core).filter(ImageFilter.MaxFilter(5))) > 0
    foreground = expanded & (distance >= 11)
    ys, xs = np.nonzero(foreground)
    core_ys, core_xs = np.nonzero(core)

    # 以最具辨识度的彩色像素为锚点，匹配 FindMultiColor 的首色约定。
    distinct = chroma[core_ys, core_xs] * 2 + distance[core_ys, core_xs]
    anchor_index = int(np.argmax(distinct))
    anchor = (int(core_xs[anchor_index]), int(core_ys[anchor_index]))

    # 最远点选择会产生空间分布均匀的偏移采样点。
    candidates = list(zip(core_xs.tolist(), core_ys.tolist()))
    points = [anchor]
    while len(points) < min(10, len(candidates)):
        best = max(candidates, key=lambda p: min((p[0]-q[0])**2+(p[1]-q[1])**2 for q in points))
        if best in points:
            break
        points.append(best)

    palette = []
    counts = Counter(tuple(map(int, value)) for value in rgb[core.astype(bool)])
    for color, count in counts.most_common(8):
        palette.append({"rgb": "#%02X%02X%02X" % color, "bgr": bgr(color), "count": count})
    samples = []
    for x, y in points:
        color = tuple(map(int, rgb[y, x]))
        samples.append({"dx": x-anchor[0], "dy": y-anchor[1], "rgb": "#%02X%02X%02X" % color, "bgr": bgr(color)})
    return {
        "size": [w, h], "background_rgb": list(map(int, background)),
        "bbox": [int(xs.min()), int(ys.min()), int(xs.max()+1), int(ys.max()+1)],
        "centroid": [round(float(xs.mean()), 2), round(float(ys.mean()), 2)],
        "anchor": list(anchor), "palette": palette, "samples": samples,
    }, foreground


def main():
    font = ImageFont.truetype(r"C:\Windows\Fonts\msyh.ttc", 18)
    small = ImageFont.truetype(r"C:\Windows\Fonts\msyh.ttc", 13)
    cards = []
    output = {"format": "supplied-icon-features-v1", "icons": []}
    for kind, label, identifier in ITEMS:
        path = ROOT / f"codex-clipboard-{identifier}.png"
        image = Image.open(path).convert("RGB")
        feature, mask = extract(image)
        feature.update({"kind": kind, "label": label, "source": str(path)})
        output["icons"].append(feature)

        scale = 5
        preview = image.resize((image.width*scale, image.height*scale), Image.Resampling.NEAREST)
        card = Image.new("RGB", (330, 215), (28, 34, 45))
        card.paste(preview, (12, 42))
        draw = ImageDraw.Draw(card)
        draw.text((12, 10), label, font=font, fill="white")
        ax, ay = feature["anchor"]
        for index, sample in enumerate(feature["samples"]):
            x = 12 + (ax + sample["dx"])*scale
            y = 42 + (ay + sample["dy"])*scale
            draw.ellipse((x-5, y-5, x+5, y+5), outline=(255, 70, 90) if index == 0 else (80, 240, 255), width=2)
            draw.text((x+6, y-8), str(index), font=small, fill="white", stroke_width=2, stroke_fill="black")
        draw.text((175, 48), f"锚点 {feature['anchor']}", font=small, fill=(154, 188, 220))
        draw.text((175, 72), f"质心 {feature['centroid']}", font=small, fill=(154, 188, 220))
        draw.text((175, 96), f"采样点 {len(feature['samples'])}", font=small, fill=(154, 188, 220))
        cards.append(card)

    Path(__file__).with_name("supplied_icon_features.json").write_text(
        json.dumps(output, ensure_ascii=False, indent=2), encoding="utf-8")
    sheet = Image.new("RGB", (990, 645), (14, 17, 23))
    for index, card in enumerate(cards):
        sheet.paste(card, ((index % 3)*330, (index // 3)*215))
    sheet.save(Path(__file__).with_name("supplied_icon_feature_points.png"))


if __name__ == "__main__":
    main()
