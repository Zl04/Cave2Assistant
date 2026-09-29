"""V5: registered temporal fusion and long-run route recognition."""

from __future__ import annotations

import importlib.util
from pathlib import Path

import numpy as np
from PIL import Image

from map_model_v2 import _dilate, _remove_small
from map_model_v4 import MapModel as V4MapModel, _bridge_masked_gaps


def _long_runs(mask: np.ndarray, minimum: int = 7) -> np.ndarray:
    """Keep pixels belonging to long horizontal or vertical runs."""
    h, w = mask.shape
    keep = np.zeros_like(mask)
    for y in range(h):
        xs = np.flatnonzero(mask[y])
        if not len(xs):
            continue
        starts = np.r_[0, np.flatnonzero(np.diff(xs) > 1) + 1]
        ends = np.r_[starts[1:], len(xs)]
        for a, b in zip(starts, ends):
            if b - a >= minimum:
                keep[y, xs[a]:xs[b - 1] + 1] = True
    for x in range(w):
        ys = np.flatnonzero(mask[:, x])
        if not len(ys):
            continue
        starts = np.r_[0, np.flatnonzero(np.diff(ys) > 1) + 1]
        ends = np.r_[starts[1:], len(ys)]
        for a, b in zip(starts, ends):
            if b - a >= minimum:
                keep[ys[a]:ys[b - 1] + 1, x] = True
    return keep


def _registration_mask(engine, image: Image.Image) -> np.ndarray:
    mask = engine.road_mask(image)
    y1, y2 = engine.MAP_CROP[1], engine.MAP_CROP[3]
    x1, x2 = engine.MAP_CROP[0], engine.MAP_CROP[2]
    limited = np.zeros_like(mask)
    limited[y1:y2, x1:x2] = mask[y1:y2, x1:x2]
    return limited


def _register_to_reference(engine, source: Image.Image, reference: Image.Image, radius: int = 12):
    source_mask = _registration_mask(engine, source)
    reference_mask = _dilate(_registration_mask(engine, reference), 1)
    ys, xs = np.nonzero(source_mask)
    best = (-1.0, 0, 0)
    for dy in range(-radius, radius + 1):
        for dx in range(-radius, radius + 1):
            yy, xx = ys + dy, xs + dx
            valid = (yy >= 0) & (yy < reference_mask.shape[0]) & (xx >= 0) & (xx < reference_mask.shape[1])
            score = float(reference_mask[yy[valid], xx[valid]].mean())
            # 分数相同时优先选择变换量较小的结果。
            candidate = (score, -(abs(dx) + abs(dy)), dx, dy)
            current = (best[0], -(abs(best[1]) + abs(best[2])), best[1], best[2])
            if candidate > current:
                best = (score, dx, dy)
    return best


class MapModel(V4MapModel):
    GRID = 6

    @classmethod
    def from_images(cls, images, engine_path: Path | None = None):
        if not images:
            raise ValueError("至少需要一张截图")
        engine_path = engine_path or Path(__file__).with_name("build_map_from_four_screenshots.py")
        spec = importlib.util.spec_from_file_location("map_engine_v5", engine_path)
        engine = importlib.util.module_from_spec(spec)
        assert spec.loader
        spec.loader.exec_module(engine)
        rgba = [image.convert("RGBA") for image in images]
        reference = rgba[-1]
        registrations = [_register_to_reference(engine, image, reference) for image in rgba[:-1]]
        offsets = [(dx, dy) for _, dx, dy in registrations] + [(0, 0)]
        scores = [score for score, _, _ in registrations]
        score = min(scores) if scores else 1.0

        local = [engine.find_player(image) for image in rgba]
        mapped = [(p[0] + o[0], p[1] + o[1]) for p, o in zip(local, offsets)]
        # 同一个逻辑节点：配准后，动画/抗锯齿抖动通常不超过 2 像素。
        # 将其对齐到最新观察结果。
        canonical = []
        for point in mapped:
            match = next((known for known in reversed(canonical)
                          if (point[0]-known[0])**2 + (point[1]-known[1])**2 <= 9), None)
            canonical.append(match or point)
        # 后续参考点可能是某个聚类更准确的代表。
        for i in range(len(canonical)):
            if (mapped[i][0]-mapped[-1][0])**2 + (mapped[i][1]-mapped[-1][1])**2 <= 9:
                canonical[i] = mapped[-1]
        players = list(zip(local, canonical))
        return cls(engine, rgba, offsets, players, score)

    def _road_pixels(self, canvas: Image.Image) -> np.ndarray:
        rgb = np.asarray(canvas.convert("RGB").crop(self.engine.MAP_CROP), dtype=np.int16)
        high, low = rgb.max(axis=2), rgb.min(axis=2)
        mean, chroma = rgb.mean(axis=2), high - low
        dark = (mean >= 32) & (mean <= 76) & (chroma <= 14)

        colorful = (chroma >= 32) & (high >= 95)
        yellow = (rgb[..., 0] >= 135) & (rgb[..., 1] >= 70) & (rgb[..., 2] <= 100)
        cyan = (rgb[..., 2] >= 120) & (rgb[..., 1] >= 95) & (rgb[..., 0] <= 120)
        icons = _dilate(colorful | yellow | cyan, 6)

        dark_image = Image.fromarray((dark * 255).astype(np.uint8), "L")
        icon_image = Image.fromarray((icons * 255).astype(np.uint8), "L")
        size = (round(dark_image.width * self.engine.X_SCALE), dark_image.height)
        dark_image = dark_image.resize(size, Image.Resampling.NEAREST).rotate(
            self.engine.ANGLE, Image.Resampling.NEAREST, expand=True, fillcolor=0)
        icon_image = icon_image.resize(size, Image.Resampling.NEAREST).rotate(
            self.engine.ANGLE, Image.Resampling.NEAREST, expand=True, fillcolor=0)
        corrected = np.asarray(dark_image) > 0
        corrected_icons = np.asarray(icon_image) > 0

        # 几何形状在校正后评估，此时有效道路近似水平/垂直，图标轮廓仍短且弯曲。
        route = _long_runs(corrected & ~corrected_icons, 7)
        route = _bridge_masked_gaps(route, corrected_icons, 28)
        route = _long_runs(route, 5)
        return _remove_small(route, 18)
