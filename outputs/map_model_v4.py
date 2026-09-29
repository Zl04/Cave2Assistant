"""V4 route model: icon filtering plus occlusion-aware line repair."""

from __future__ import annotations

import numpy as np
from PIL import Image

from map_model_v2 import _dilate, _remove_small, _shift
from map_model_v3 import MapModel as V3MapModel, _directional_close


def _bridge_masked_gaps(route: np.ndarray, occlusion: np.ndarray, maximum: int = 28) -> np.ndarray:
    """Bridge a gap only when route evidence exists at both ends and an icon masks the gap."""
    result = route.copy()
    h, w = route.shape
    for y in range(h):
        xs = np.flatnonzero(route[y])
        for left, right in zip(xs, xs[1:]):
            gap = right - left - 1
            if 0 < gap <= maximum and occlusion[y, left + 1:right].mean() >= 0.28:
                result[y, left:right + 1] = True
    for x in range(w):
        ys = np.flatnonzero(route[:, x])
        for top, bottom in zip(ys, ys[1:]):
            gap = bottom - top - 1
            if 0 < gap <= maximum and occlusion[top + 1:bottom, x].mean() >= 0.28:
                result[top:bottom + 1, x] = True
    return result


class MapModel(V3MapModel):
    """Same interface as V2/V3; intended for screenshots 3 and 4 only."""

    def _road_pixels(self, canvas: Image.Image) -> np.ndarray:
        rgb = np.asarray(canvas.convert("RGB").crop(self.engine.MAP_CROP), dtype=np.int16)
        high = rgb.max(axis=2)
        low = rgb.min(axis=2)
        mean = rgb.mean(axis=2)
        chroma = high - low

        dark_neutral = (mean >= self.ROUTE_MIN) & (mean <= self.ROUTE_MAX) & (chroma <= self.CHROMA_MAX)

        # 彩色图标：骷髅、物品/玩家标记。它们的深色轮廓靠近这些彩色核心，
        # 因此在提取路线前扩展掩码。
        colorful = (chroma >= 32) & (high >= 95)
        yellow_orange = (rgb[..., 0] >= 135) & (rgb[..., 1] >= 70) & (rgb[..., 2] <= 95)
        cyan_blue = (rgb[..., 2] >= 120) & (rgb[..., 1] >= 95) & (rgb[..., 0] <= 115)
        icon_core = colorful | yellow_orange | cyan_blue
        icon_mask = _dilate(icon_core, 7)

        base = dark_neutral & ~icon_mask
        h_support = ((_shift(base, 2, 0) & _shift(base, -2, 0)) |
                     (_shift(base, 4, 0) & _shift(base, -4, 0)))
        v_support = ((_shift(base, 0, 2) & _shift(base, 0, -2)) |
                     (_shift(base, 0, 4) & _shift(base, 0, -4)))
        route = base & (h_support | v_support)
        route = _directional_close(route, 4)
        route = _remove_small(route, 18)

        route_image = Image.fromarray((route * 255).astype(np.uint8), "L")
        icon_image = Image.fromarray((icon_mask * 255).astype(np.uint8), "L")
        size = (round(route_image.width * self.engine.X_SCALE), route_image.height)
        route_image = route_image.resize(size, Image.Resampling.NEAREST).rotate(
            self.engine.ANGLE, Image.Resampling.NEAREST, expand=True, fillcolor=0)
        icon_image = icon_image.resize(size, Image.Resampling.NEAREST).rotate(
            self.engine.ANGLE, Image.Resampling.NEAREST, expand=True, fillcolor=0)
        corrected = np.asarray(route_image) > 0
        corrected_icons = np.asarray(icon_image) > 0

        # 只恢复图标两侧端点都保留下来的直线分段。绝不跨越空白/迷雾间隙。
        corrected = _bridge_masked_gaps(corrected, corrected_icons, 26)
        corrected = _directional_close(corrected, 3)
        return _remove_small(corrected, 16)
