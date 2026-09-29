"""Remove minimap icons from a screenshot and reconstruct covered road pixels."""

from __future__ import annotations

import argparse
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter
from scipy import ndimage


DEFAULT_SOURCE = Path(
    r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-4734ae92-3d7b-40e0-925e-a4bf9d311c80.png"
)
DEFAULT_REFERENCE = Path(
    r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-309aa9d3-6f0d-4039-a4fb-49ec8c25bded.png"
)
DEFAULT_OUTPUT = Path(__file__).with_name("full_map_roads_only.png")
ROI = (290, 175, 985, 535)


def dilate(mask: np.ndarray, radius: int) -> np.ndarray:
    image = Image.fromarray((mask * 255).astype(np.uint8), "L")
    return np.asarray(image.filter(ImageFilter.MaxFilter(radius * 2 + 1))) > 0


def erode(mask: np.ndarray, radius: int) -> np.ndarray:
    image = Image.fromarray((mask * 255).astype(np.uint8), "L")
    return np.asarray(image.filter(ImageFilter.MinFilter(radius * 2 + 1))) > 0


def icon_mask(image: Image.Image) -> tuple[np.ndarray, np.ndarray]:
    rgb = np.asarray(image.convert("RGB"), dtype=np.int16)
    high, low = rgb.max(axis=2), rgb.min(axis=2)
    chroma = high - low
    # 每个活动地下城图标都包含高饱和度彩色核心。将此操作限制在地图区域内，
    # 可以防止装饰性 UI 进入掩码。
    saturated = (chroma >= 40) & (high >= 92)
    pale_icon = (high >= 180) & (low >= 125) & (chroma >= 15)
    core = saturated | pale_icon
    limited = np.zeros(core.shape, dtype=bool)
    x1, y1, x2, y2 = ROI
    limited[y1:y2, x1:x2] = core[y1:y2, x1:x2]
    # 只向合理属于图标的像素扩展。这样可以捕获黑色轮廓和浅色高光，
    # 而不会擦除相邻道路表面。
    near_core = dilate(limited, 3)
    mean = rgb.mean(axis=2)
    plausible_icon = limited | (high >= 165) | (mean <= 38) | (chroma >= 35)
    mask = dilate(near_core & plausible_icon, 1)

    # 移除孤立的彩色噪声；真实图标附近有明显的核心区域。
    density = np.asarray(
        Image.fromarray((limited * 255).astype(np.uint8), "L")
        .filter(ImageFilter.BoxBlur(5))
    )
    supported = dilate(density >= 3, 4)
    mask &= supported
    return limited, mask


def diffuse_fill(rgb: np.ndarray, mask: np.ndarray, iterations: int = 34) -> np.ndarray:
    """Fill masked pixels by repeatedly propagating surrounding map colors."""
    work = rgb.astype(np.float32).copy()
    mean = rgb.mean(axis=2)
    chroma = rgb.max(axis=2) - rgb.min(axis=2)
    # 只传播两种棕色/灰色表面配色。深色道路轮廓不能渗入图标形状的空洞。
    known = ~mask & (mean >= 82) & (chroma <= 34)
    for _ in range(iterations):
        total = np.zeros_like(work)
        count = np.zeros(mask.shape, dtype=np.float32)
        for dy, dx in ((-1, 0), (1, 0), (0, -1), (0, 1)):
            shifted_values = np.roll(work, (dy, dx), axis=(0, 1))
            shifted_known = np.roll(known, (dy, dx), axis=(0, 1))
            total += shifted_values * shifted_known[..., None]
            count += shifted_known
        frontier = mask & ~known & (count > 0)
        if not frontier.any():
            break
        work[frontier] = total[frontier] / count[frontier, None]
        known[frontier] = True
    result = rgb.copy()
    result[mask] = np.clip(work[mask], 0, 255).astype(np.uint8)
    return result


def restore_lines(
    original: np.ndarray,
    mask: np.ndarray,
    filled: np.ndarray,
    *,
    exclusion_mask: np.ndarray | None = None,
    allow_corners: bool = True,
) -> np.ndarray:
    mean = original.mean(axis=2)
    chroma = original.max(axis=2) - original.min(axis=2)
    excluded = mask if exclusion_mask is None else exclusion_mask
    road_line = (mean >= 35) & (mean <= 73) & (chroma <= 15) & ~excluded
    result = filled.copy()
    h, w = mask.shape
    bridge = np.zeros_like(mask)
    search_mask = dilate(mask, 1)

    def draw_segment(x0: int, y0: int, x1: int, y1: int) -> None:
        steps = max(abs(x1 - x0), abs(y1 - y0)) + 1
        xs = np.rint(np.linspace(x0, x1, steps)).astype(int)
        ys = np.rint(np.linspace(y0, y1, steps)).astype(int)
        valid = (xs >= 0) & (xs < w) & (ys >= 0) & (ys < h)
        bridge[ys[valid], xs[valid]] = True

    # 只从掩码间隙前紧邻的真实线像素开始。沿一条等距轴向前移动；
    # 间隙后的第一个可见像素自身必须是深色道路线像素。
    # 这是受约束的延续，而不是最近道路连接。
    line_points = list(zip(*np.nonzero(road_line)))
    for dy, dx in ((1, 2), (-1, 2), (0, 1)):
        for y, x in line_points:
            entered = False
            masked_steps = 0
            for step in range(1, 27):
                xx, yy = x + dx * step, y + dy * step
                if not (1 <= xx < w - 1 and 1 <= yy < h - 1):
                    break
                is_gap = bool(search_mask[yy, xx])
                if is_gap:
                    entered = True
                    masked_steps += 1
                    continue
                if not entered:
                    break
                # 允许垂直于轴向的一个像素光栅化误差。
                if dy == 0:
                    endpoint = road_line[yy - 1:yy + 2, xx].any()
                else:
                    endpoint = road_line[yy - 1:yy + 2, xx - 1:xx + 2].any()
                if endpoint and masked_steps >= 2:
                    draw_segment(x, y, xx, yy)
                break

    # 重建被图标完全遮挡的拐角。只有当端点的下一格进入特定的连通掩码组件时，
    # 才接受该端点。
    labels, _ = ndimage.label(search_mask)
    endpoints: dict[int, dict[str, list[tuple[int, int, int, int]]]] = {}
    orientations = {
        "plus": ((2, 1), (-2, -1)),
        "minus": ((2, -1), (-2, 1)),
    }
    for family, directions in orientations.items():
        for dx, dy in directions:
            for y, x in line_points:
                xx, yy = x + dx, y + dy
                if not (0 <= xx < w and 0 <= yy < h):
                    continue
                component = int(labels[yy, xx])
                if component == 0:
                    continue
                invariant = 2 * y - x if family == "plus" else 2 * y + x
                endpoints.setdefault(component, {}).setdefault(family, []).append(
                    (x, y, dx, dy, invariant))

    def mostly_inside(x0: int, y0: int, x1: int, y1: int, component: int) -> bool:
        steps = max(abs(x1 - x0), abs(y1 - y0)) + 1
        xs = np.rint(np.linspace(x0, x1, steps)).astype(int)
        ys = np.rint(np.linspace(y0, y1, steps)).astype(int)
        inside = labels[ys, xs] == component
        return float(inside[1:].mean()) >= 0.58 if len(inside) > 1 else False

    for component, families in endpoints.items() if allow_corners else ():
        plus = families.get("plus", [])
        minus = families.get("minus", [])
        candidates = []
        for px, py, pdx, pdy, pc in plus:
            for mx, my, mdx, mdy, mc in minus:
                ix = (mc - pc) / 2.0
                iy = (mc + pc) / 4.0
                rx, ry = int(round(ix)), int(round(iy))
                if not (0 <= rx < w and 0 <= ry < h) or labels[ry, rx] != component:
                    continue
                dp = float(np.hypot(rx - px, ry - py))
                dm = float(np.hypot(rx - mx, ry - my))
                if dp > 34 or dm > 34:
                    continue
                if (rx - px) * pdx + (ry - py) * pdy <= 0:
                    continue
                if (rx - mx) * mdx + (ry - my) * mdy <= 0:
                    continue
                if not mostly_inside(px, py, rx, ry, component):
                    continue
                if not mostly_inside(mx, my, rx, ry, component):
                    continue
                candidates.append((dp + dm, px, py, mx, my, rx, ry))
        # 紧凑图标组件通常最多隐藏一个道路拐角。
        # 只保留几何上有效且最短的假设。
        if candidates:
            _, px, py, mx, my, rx, ry = min(candidates)
            draw_segment(px, py, rx, ry)
            draw_segment(mx, my, rx, ry)

    bridge = dilate(bridge & mask, 1) & mask
    # 使用真实线像素的中位颜色，保留游戏配色。
    line_color = np.median(original[road_line], axis=0).astype(np.uint8)
    result[bridge] = line_color
    return result, bridge


def split_deferred_regions(mask: np.ndarray) -> tuple[np.ndarray, np.ndarray]:
    """Delay composite/adjacent icon blobs until the road model is stable.

    A normal minimap icon occupies roughly 24x24 pixels in this capture.  Blobs
    much larger than that contain adjacent or overlapping icons, where treating
    dark icon outlines as road endpoints creates false corners.
    """
    labels, count = ndimage.label(mask)
    deferred = np.zeros_like(mask)
    for component in range(1, count + 1):
        ys, xs = np.nonzero(labels == component)
        if not len(xs):
            continue
        area = len(xs)
        width = int(xs.max() - xs.min() + 1)
        height = int(ys.max() - ys.min() + 1)
        if area >= 700 or width >= 32 or height >= 32:
            deferred[labels == component] = True
    return mask & ~deferred, deferred


def process(source: Path, output: Path, reference: Path | None = DEFAULT_REFERENCE) -> None:
    image = Image.open(source).convert("RGB")
    original = np.asarray(image)
    core, mask = icon_mask(image)
    patched = original.copy()
    remaining = mask.copy()
    recovered = np.zeros_like(mask)
    if reference is not None and reference.exists():
        reference_image = Image.open(reference).convert("RGB")
        reference_rgb = np.asarray(reference_image)
        _, reference_icons = icon_mask(reference_image)
        reference_mean = reference_rgb.mean(axis=2)
        reference_chroma = reference_rgb.max(axis=2) - reference_rgb.min(axis=2)
        road_surface = np.linalg.norm(
            reference_rgb.astype(np.int16) - np.array([121, 105, 95]), axis=2) <= 18
        road_outline = ((reference_mean >= 35) & (reference_mean <= 73)
                        & (reference_chroma <= 15))
        base_surface = ((reference_mean >= 82) & (reference_mean <= 170)
                        & (reference_chroma <= 40))
        explored_near_road = dilate(road_surface | road_outline, 18)
        recovered = (mask & ~reference_icons & explored_near_road
                     & (base_surface | road_outline))
        patched[recovered] = reference_rgb[recovered]
        remaining &= ~recovered

    simple_mask, deferred_mask = split_deferred_regions(remaining)

    # 阶段 1：移除孤立图标并重建其直线/拐角分段。
    # 所有图标像素仍排除在端点检测之外，避免延迟处理的图块污染稳定道路模型。
    simple_filled = diffuse_fill(patched, simple_mask)
    stage_one, simple_lines = restore_lines(
        patched, simple_mask, simple_filled,
        exclusion_mask=remaining, allow_corners=True)

    # 阶段 2（最后）：移除相邻/重叠图标。
    # 此时只接受保守的直线延续；不能在有歧义的复合图块内部臆造新拐角。
    deferred_filled = diffuse_fill(stage_one, deferred_mask)
    restored, deferred_lines = restore_lines(
        stage_one, deferred_mask, deferred_filled,
        exclusion_mask=deferred_mask, allow_corners=False)
    reconstructed_lines = simple_lines | deferred_lines
    Image.fromarray(restored).save(output)

    overlay = image.copy()
    paint = Image.new("RGBA", image.size, (0, 0, 0, 0))
    alpha = Image.fromarray((mask * 125).astype(np.uint8), "L")
    paint.paste((255, 0, 255, 125), (0, 0, image.width, image.height), alpha)
    overlay = Image.alpha_composite(overlay.convert("RGBA"), paint)
    overlay.save(output.with_name(output.stem + "_mask.png"))

    debug = image.copy().convert("RGBA")
    line_layer = Image.new("RGBA", image.size, (0, 0, 0, 0))
    line_alpha = Image.fromarray((reconstructed_lines * 220).astype(np.uint8), "L")
    line_layer.paste((0, 255, 0, 220), (0, 0, image.width, image.height), line_alpha)
    Image.alpha_composite(debug, line_layer).save(
        output.with_name(output.stem + "_reconstructed_lines.png"))

    deferred_debug = image.copy().convert("RGBA")
    deferred_layer = Image.new("RGBA", image.size, (0, 0, 0, 0))
    deferred_alpha = Image.fromarray((deferred_mask * 175).astype(np.uint8), "L")
    deferred_layer.paste(
        (255, 128, 0, 175), (0, 0, image.width, image.height), deferred_alpha)
    Image.alpha_composite(deferred_debug, deferred_layer).save(
        output.with_name(output.stem + "_deferred_regions.png"))

    crop = (285, 175, 985, 535)
    before = image.crop(crop)
    after = Image.fromarray(restored).crop(crop)
    comparison = Image.new("RGB", (before.width * 2, before.height), "black")
    comparison.paste(before, (0, 0))
    comparison.paste(after, (before.width, 0))
    ImageDraw.Draw(comparison).text((8, 8), "BEFORE", fill="white")
    ImageDraw.Draw(comparison).text((before.width + 8, 8), "ROADS ONLY", fill="white")
    comparison.save(output.with_name(output.stem + "_comparison.png"))
    print(f"core_pixels={int(core.sum())}, mask_pixels={int(mask.sum())}, "
          f"recovered_from_reference={int(recovered.sum())}, "
          f"remaining={int(remaining.sum())}, simple={int(simple_mask.sum())}, "
          f"deferred={int(deferred_mask.sum())}, output={output}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("source", nargs="?", type=Path, default=DEFAULT_SOURCE)
    parser.add_argument("output", nargs="?", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--reference", type=Path, default=DEFAULT_REFERENCE)
    args = parser.parse_args()
    process(args.source, args.output, args.reference)
