"""V3 offset-color road model.

Unlike V2, this model does not treat the broad brown floor color as walkable.
It samples the stable dark route color at directional offsets and only retains
pixels supported by a horizontal or vertical run.
"""

from __future__ import annotations

import numpy as np
from PIL import Image

from map_model_v2 import MapModel as V2MapModel, _dilate, _erode, _remove_small, _shift


def _directional_close(mask: np.ndarray, radius: int) -> np.ndarray:
    horizontal = np.zeros_like(mask)
    vertical = np.zeros_like(mask)
    for delta in range(-radius, radius + 1):
        horizontal |= _shift(mask, delta, 0)
        vertical |= _shift(mask, 0, delta)
    for delta in range(-radius, radius + 1):
        horizontal &= _shift(horizontal, delta, 0)
        vertical &= _shift(vertical, 0, delta)
    return mask | horizontal | vertical


class MapModel(V2MapModel):
    """Drop-in replacement exposing the same small interface as V2."""

    GRID = 6
    ROUTE_MIN = 34
    ROUTE_MAX = 72
    CHROMA_MAX = 12

    def _road_pixels(self, canvas: Image.Image) -> np.ndarray:
        rgb = np.asarray(canvas.convert("RGB").crop(self.engine.MAP_CROP), dtype=np.int16)
        high = rgb.max(axis=2)
        low = rgb.min(axis=2)
        mean = rgb.mean(axis=2)
        base = (mean >= self.ROUTE_MIN) & (mean <= self.ROUTE_MAX) & ((high - low) <= self.CHROMA_MAX)

        # 偏移颜色共识。有效路线像素必须沿一个主方向获得同色支持；
        # 孤立且弯曲的图标轮廓无法通过。
        h_support = ((_shift(base, 2, 0) & _shift(base, -2, 0)) |
                     (_shift(base, 4, 0) & _shift(base, -4, 0)))
        v_support = ((_shift(base, 0, 2) & _shift(base, 0, -2)) |
                     (_shift(base, 0, 4) & _shift(base, 0, -4)))
        route = base & (h_support | v_support)
        route = _directional_close(route, 5)
        route = _remove_small(route, 25)

        # 计算变换：只使用最近邻，保留硬边缘。
        binary = Image.fromarray((route * 255).astype(np.uint8), "L")
        binary = binary.resize((round(binary.width * self.engine.X_SCALE), binary.height), Image.Resampling.NEAREST)
        binary = binary.rotate(self.engine.ANGLE, resample=Image.Resampling.NEAREST, expand=True, fillcolor=0)
        corrected = np.asarray(binary) > 0
        corrected = _directional_close(corrected, 4)
        corrected = _remove_small(corrected, 20)
        return corrected

    def _to_grid(self, road: np.ndarray) -> np.ndarray:
        # V3 存储细路线图，因此只要有受支持的线采样穿过某个网格格子就接受；
        # 不执行大范围地面填充。
        h = (road.shape[0] // self.GRID) * self.GRID
        w = (road.shape[1] // self.GRID) * self.GRID
        count = road[:h, :w].reshape(h//self.GRID, self.GRID, w//self.GRID, self.GRID).sum(axis=(1, 3))
        from map_model_v2 import Cell
        state = np.full(count.shape, Cell.UNKNOWN, dtype=np.uint8)
        state[count >= 2] = Cell.ROAD
        return state
