from pathlib import Path
from PIL import Image, ImageDraw, ImageFont
import csv
import math
import shutil
import numpy as np

SOURCES = [
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-07047e42-5c74-4aff-be2d-ad4ccfa06b8a.png"),
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-2a2a0b57-5f41-40dd-b5f5-23482e870c83.png"),
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-309aa9d3-6f0d-4039-a4fb-49ec8c25bded.png"),
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-4734ae92-3d7b-40e0-925e-a4bf9d311c80.png"),
]
OUT = Path(r"outputs")
STAGES = OUT / "map_build_stages"
MAP_CROP = (280, 160, 1000, 550)  # 截图 2-4 使用的公共地图画布
X_SCALE = 0.5
ANGLE = 45.0

def connected_components(mask):
    h, w = mask.shape
    seen = np.zeros_like(mask, dtype=bool)
    result = []
    for y, x in zip(*np.nonzero(mask)):
        if seen[y, x]:
            continue
        stack = [(int(x), int(y))]
        seen[y, x] = True
        pts = []
        while stack:
            px, py = stack.pop()
            pts.append((px, py))
            for ny in range(max(0, py - 1), min(h, py + 2)):
                for nx in range(max(0, px - 1), min(w, px + 2)):
                    if mask[ny, nx] and not seen[ny, nx]:
                        seen[ny, nx] = True
                        stack.append((nx, ny))
        if len(pts) >= 20:
            xs = [p[0] for p in pts]
            ys = [p[1] for p in pts]
            result.append({
                "area": len(pts), "x1": min(xs), "y1": min(ys),
                "x2": max(xs), "y2": max(ys),
                "cx": sum(xs) / len(xs), "cy": sum(ys) / len(ys),
            })
    return sorted(result, key=lambda c: c["area"], reverse=True)

def find_player(image):
    rgb = np.asarray(image.convert("RGB"))
    r, g, b = rgb[..., 0], rgb[..., 1], rgb[..., 2]
    cyan = (b > 145) & (g > 115) & (r < 105) & ((b.astype(int) - r) > 70)
    comps = connected_components(cyan)
    # 玩家标记是两个面积最大的、垂直对齐的青色部分。
    candidates = [c for c in comps if 150 <= c["area"] <= 500]
    if len(candidates) < 2:
        raise RuntimeError("player marker not found")
    best = None
    for a in candidates:
        for bpart in candidates:
            if a is bpart or abs(a["cx"] - bpart["cx"]) > 5:
                continue
            upper, lower = sorted((a, bpart), key=lambda c: c["cy"])
            if not 4 <= lower["cy"] - upper["cy"] <= 25:
                continue
            score = upper["area"] + lower["area"]
            if best is None or score > best[0]:
                best = (score, upper, lower)
    if best is None:
        raise RuntimeError("paired player marker not found")
    _, upper, lower = best
    return ((upper["cx"] + lower["cx"]) / 2, float(lower["y2"]))

def road_mask(image):
    rgb = np.asarray(image.convert("RGB"))
    hi = rgb.max(axis=2).astype(int)
    lo = rgb.min(axis=2).astype(int)
    mean = rgb.mean(axis=2)
    # 中性深色道路轮廓；通过色度排除彩色图标。
    return (mean < 105) & ((hi - lo) < 28)

def dilate(mask, radius=2):
    out = np.zeros_like(mask)
    for dy in range(-radius, radius + 1):
        for dx in range(-radius, radius + 1):
            y1, y2 = max(0, dy), min(mask.shape[0], mask.shape[0] + dy)
            x1, x2 = max(0, dx), min(mask.shape[1], mask.shape[1] + dx)
            out[y1:y2, x1:x2] |= mask[y1 - dy:y2 - dy, x1 - dx:x2 - dx]
    return out

def register_first_to_reference(first, reference):
    src = road_mask(first)
    ref = dilate(road_mask(reference), 2)
    # 截图 1 只使用实际地图区域。
    ys, xs = np.nonzero(src)
    keep = (xs >= 450) & (xs <= 730) & (ys >= 260) & (ys <= 420)
    xs, ys = xs[keep], ys[keep]
    best = (-1.0, 0, 0)
    for dy in range(20, 81):
        ry = ys + dy
        valid_y = (ry >= 0) & (ry < ref.shape[0])
        for dx in range(130, 211):
            rx = xs + dx
            valid = valid_y & (rx >= 0) & (rx < ref.shape[1])
            if not np.any(valid):
                continue
            score = float(ref[ry[valid], rx[valid]].mean())
            if score > best[0]:
                best = (score, dx, dy)
    return best

def font(size):
    for path in [r"C:\Windows\Fonts\msyh.ttc", r"C:\Windows\Fonts\arial.ttf"]:
        if Path(path).exists():
            return ImageFont.truetype(path, size)
    return ImageFont.load_default()

def rectify(image):
    stretched = image.resize((round(image.width * X_SCALE), image.height), Image.Resampling.LANCZOS)
    return stretched.rotate(ANGLE, resample=Image.Resampling.BICUBIC, expand=True, fillcolor=(0, 0, 0, 0))

def rectify_point(point, input_size):
    # 复现缩放以及 Pillow 正角度旋转（包含扩展边界）。
    sw, sh = round(input_size[0] * X_SCALE), input_size[1]
    x, y = point[0] * X_SCALE, point[1]
    cx, cy = sw / 2.0, sh / 2.0
    a = math.radians(ANGLE)
    ca, sa = math.cos(a), math.sin(a)
    def rotate(px, py):
        dx, dy = px - cx, py - cy
        return ca * dx + sa * dy, -sa * dx + ca * dy
    corners = [rotate(0, 0), rotate(sw, 0), rotate(0, sh), rotate(sw, sh)]
    minx = min(p[0] for p in corners)
    miny = min(p[1] for p in corners)
    rx, ry = rotate(x, y)
    return rx - minx, ry - miny

def main():
    OUT.mkdir(parents=True, exist_ok=True)
    STAGES.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(Path(__file__), OUT / "build_map_from_four_screenshots.py")
    images = [Image.open(p).convert("RGBA") for p in SOURCES]
    local_players = [find_player(im) for im in images]
    score, dx1, dy1 = register_first_to_reference(images[0], images[3])
    offsets = [(dx1, dy1), (0, 0), (0, 0), (0, 0)]
    global_players = [(p[0] + o[0], p[1] + o[1]) for p, o in zip(local_players, offsets)]

    # 为每张识别到的截图导出一个可检查结果。游戏地图是累积的，
    # 因此每张截图都表示该时刻已知的地图。帧 1 平移到 1280x720 公共画布上；
    # 帧 2-4 已经使用该画布。
    colors = [(255, 70, 70, 255), (255, 210, 30, 255), (70, 255, 120, 255), (255, 80, 220, 255)]
    for i, (source, local, offset, globalp) in enumerate(zip(images, local_players, offsets, global_players), 1):
        canvas = Image.new("RGBA", images[3].size, (0, 0, 0, 255))
        canvas.alpha_composite(source, dest=(offset[0], offset[1]))
        stage = canvas.copy()
        stage_draw = ImageDraw.Draw(stage)
        # 绘制截至当前帧观察到的所有位置。
        for j in range(i):
            px, py = global_players[j]
            color = colors[j]
            stage_draw.ellipse((px - 8, py - 8, px + 8, py + 8), outline=color, width=4)
            stage_draw.text((px + 11, py - 15), f"P{j+1}", fill=color,
                            font=font(22), stroke_width=2, stroke_fill=(0, 0, 0, 255))
        for a, b in zip(global_players[:i], global_players[1:i]):
            stage_draw.line((a[0], a[1], b[0], b[1]), fill=(255, 255, 255, 210), width=3)
        info = (f"Frame {i}  local=({local[0]:.2f}, {local[1]:.2f})  "
                f"offset=({offset[0]}, {offset[1]})  map=({globalp[0]:.2f}, {globalp[1]:.2f})")
        stage_draw.rectangle((10, 10, 870, 52), fill=(0, 0, 0, 190))
        stage_draw.text((20, 17), info, fill=(255, 255, 255, 255), font=font(18))
        stage.save(STAGES / f"frame_{i}_recognized_and_built.png")

        rectified_stage = rectify(stage.crop(MAP_CROP))
        rectified_stage.save(STAGES / f"frame_{i}_rectified.png")

    # 带标注的参考截图。
    annotated = images[3].copy()
    draw = ImageDraw.Draw(annotated)
    for i, (x, y) in enumerate(global_players):
        color = colors[i]
        draw.ellipse((x - 8, y - 8, x + 8, y + 8), outline=color, width=4)
        draw.text((x + 11, y - 15), f"P{i+1}", fill=color, font=font(22), stroke_width=2, stroke_fill=(0, 0, 0, 255))
    for a, b in zip(global_players, global_players[1:]):
        draw.line((a[0], a[1], b[0], b[1]), fill=(255, 255, 255, 210), width=3)
    annotated.save(OUT / "constructed_map_reference_with_track.png")

    # 裁剪到地图画布，再将其校正到上/右坐标轴。
    cropped = annotated.crop(MAP_CROP)
    corrected = rectify(cropped)
    corrected.save(OUT / "constructed_map_rectified_with_track.png")

    rows = []
    crop_w, crop_h = MAP_CROP[2] - MAP_CROP[0], MAP_CROP[3] - MAP_CROP[1]
    for i, (local, offset, globalp) in enumerate(zip(local_players, offsets, global_players), 1):
        crop_point = (globalp[0] - MAP_CROP[0], globalp[1] - MAP_CROP[1])
        rect = rectify_point(crop_point, (crop_w, crop_h))
        rows.append({
            "frame": i,
            "local_x": round(local[0], 2), "local_y_tip": round(local[1], 2),
            "registration_dx": offset[0], "registration_dy": offset[1],
            "map_x": round(globalp[0], 2), "map_y": round(globalp[1], 2),
            "rectified_x": round(rect[0], 2), "rectified_y": round(rect[1], 2),
        })
    with (OUT / "character_positions.csv").open("w", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(f, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)

    print("registration", {"score": round(score, 4), "dx": dx1, "dy": dy1})
    for row in rows:
        print(row)

if __name__ == "__main__":
    main()
