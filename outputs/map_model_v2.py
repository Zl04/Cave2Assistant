"""Conservative minimap fusion model.

The public interface is intentionally small:
    model = MapModel.from_images(images)
    snapshot = model.snapshot(frame_index)

Unknown pixels are never converted to walls merely because a screenshot is blank.
The calculation raster uses nearest-neighbour transforms; smoothing is display-only.
"""

from __future__ import annotations

from dataclasses import dataclass
from enum import IntEnum
from pathlib import Path
from typing import Sequence

import importlib.util
import numpy as np
from PIL import Image, ImageDraw, ImageFilter


class Cell(IntEnum):
    UNKNOWN = 0
    ROAD = 1
    WALL = 2


@dataclass(frozen=True)
class MapSnapshot:
    frame: int
    player_local: tuple[float, float]
    player_map: tuple[float, float]
    player_grid: tuple[int, int]
    offset: tuple[int, int]
    registration_score: float
    occupancy: np.ndarray
    road_mask: np.ndarray
    skeleton: np.ndarray
    frontiers: tuple[tuple[int, int], ...]
    nodes: tuple[tuple[int, int], ...]
    edges: tuple[tuple[int, int], ...]
    new_road_pixels: int
    total_road_pixels: int


def _shift(mask: np.ndarray, dx: int, dy: int) -> np.ndarray:
    result = np.zeros_like(mask)
    sy1, sy2 = max(0, -dy), min(mask.shape[0], mask.shape[0] - dy)
    sx1, sx2 = max(0, -dx), min(mask.shape[1], mask.shape[1] - dx)
    dy1, dy2 = sy1 + dy, sy2 + dy
    dx1, dx2 = sx1 + dx, sx2 + dx
    result[dy1:dy2, dx1:dx2] = mask[sy1:sy2, sx1:sx2]
    return result


def _dilate(mask: np.ndarray, radius: int) -> np.ndarray:
    result = np.zeros_like(mask)
    for dy in range(-radius, radius + 1):
        for dx in range(-radius, radius + 1):
            result |= _shift(mask, dx, dy)
    return result


def _erode(mask: np.ndarray, radius: int) -> np.ndarray:
    result = np.ones_like(mask)
    for dy in range(-radius, radius + 1):
        for dx in range(-radius, radius + 1):
            result &= _shift(mask, dx, dy)
    return result


def _remove_small(mask: np.ndarray, minimum: int = 45) -> np.ndarray:
    h, w = mask.shape
    seen = np.zeros_like(mask)
    output = np.zeros_like(mask)
    for y, x in zip(*np.nonzero(mask)):
        if seen[y, x]:
            continue
        stack = [(int(x), int(y))]
        seen[y, x] = True
        points = []
        while stack:
            px, py = stack.pop()
            points.append((px, py))
            for ny in range(max(0, py - 1), min(h, py + 2)):
                for nx in range(max(0, px - 1), min(w, px + 2)):
                    if mask[ny, nx] and not seen[ny, nx]:
                        seen[ny, nx] = True
                        stack.append((nx, ny))
        if len(points) >= minimum:
            for px, py in points:
                output[py, px] = True
    return output


def _largest_component(mask: np.ndarray) -> np.ndarray:
    """Keep the connected road network and discard detached icon fragments."""
    h, w = mask.shape
    seen = np.zeros_like(mask)
    largest = []
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
        if len(points) > len(largest):
            largest = points
    output = np.zeros_like(mask)
    for x, y in largest:
        output[y, x] = True
    return output


def _skeletonize(binary: np.ndarray) -> np.ndarray:
    """Zhang-Suen thinning; produces a one-pixel topology raster."""
    image = binary.astype(np.uint8).copy()
    changed = True
    while changed:
        changed = False
        for phase in (0, 1):
            p2 = _shift(image, 0, 1); p3 = _shift(image, -1, 1)
            p4 = _shift(image, -1, 0); p5 = _shift(image, -1, -1)
            p6 = _shift(image, 0, -1); p7 = _shift(image, 1, -1)
            p8 = _shift(image, 1, 0); p9 = _shift(image, 1, 1)
            neighbours = p2+p3+p4+p5+p6+p7+p8+p9
            transitions = ((p2 == 0) & (p3 == 1)).astype(np.uint8)
            for a, b in ((p3,p4),(p4,p5),(p5,p6),(p6,p7),(p7,p8),(p8,p9),(p9,p2)):
                transitions += ((a == 0) & (b == 1)).astype(np.uint8)
            common = (image == 1) & (neighbours >= 2) & (neighbours <= 6) & (transitions == 1)
            if phase == 0:
                remove = common & ((p2*p4*p6) == 0) & ((p4*p6*p8) == 0)
            else:
                remove = common & ((p2*p4*p8) == 0) & ((p2*p6*p8) == 0)
            if np.any(remove):
                image[remove] = 0
                changed = True
    return image.astype(bool)


class MapModel:
    GRID = 8
    ROAD_COLOR = np.array([121, 105, 95], dtype=np.int16)

    def __init__(self, engine, images, offsets, players, score):
        self.engine = engine
        self.images = images
        self.offsets = offsets
        self.players = players
        self.score = score
        self._snapshots = self._build()

    @classmethod
    def from_images(cls, images: Sequence[Image.Image], engine_path: Path | None = None):
        if not images:
            raise ValueError("至少需要一张截图")
        engine_path = engine_path or Path(__file__).with_name("build_map_from_four_screenshots.py")
        spec = importlib.util.spec_from_file_location("map_engine_v2", engine_path)
        engine = importlib.util.module_from_spec(spec)
        assert spec.loader
        spec.loader.exec_module(engine)
        rgba = [image.convert("RGBA") for image in images]
        local = [engine.find_player(image) for image in rgba]
        if len(rgba) > 1 and rgba[0].size != rgba[-1].size:
            score, dx, dy = engine.register_first_to_reference(rgba[0], rgba[-1])
        else:
            score, dx, dy = 1.0, 0, 0
        offsets = [(dx, dy)] + [(0, 0)] * (len(rgba) - 1)
        players = [(p, (p[0] + o[0], p[1] + o[1])) for p, o in zip(local, offsets)]
        return cls(engine, rgba, offsets, players, score)

    def __len__(self):
        return len(self._snapshots)

    def snapshot(self, frame: int) -> MapSnapshot:
        return self._snapshots[frame]

    def render(self, frame: int, scale: int = 3) -> Image.Image:
        snap = self.snapshot(frame)
        state = snap.occupancy
        colors = np.zeros((*state.shape, 4), dtype=np.uint8)
        colors[state == Cell.UNKNOWN] = (16, 20, 28, 255)
        colors[state == Cell.WALL] = (77, 86, 101, 255)
        colors[state == Cell.ROAD] = (59, 181, 245, 255)
        image = Image.fromarray(colors, "RGBA").resize((state.shape[1]*scale, state.shape[0]*scale), Image.Resampling.NEAREST)
        draw = ImageDraw.Draw(image)
        for x, y in snap.frontiers:
            draw.rectangle((x*scale, y*scale, (x+1)*scale-1, (y+1)*scale-1), fill=(255, 174, 66, 255))
        for i in range(frame + 1):
            point = self._snapshots[i].player_grid
            x, y = point[0]*scale + scale//2, point[1]*scale + scale//2
            r = max(3, scale)
            draw.ellipse((x-r, y-r, x+r, y+r), fill=(255, 72, 106, 255), outline="white")
            draw.text((x+r+2, y-r-2), f"P{i+1}", fill="white", stroke_width=2, stroke_fill="black")
        return image

    def _road_pixels(self, canvas: Image.Image) -> np.ndarray:
        crop = np.asarray(canvas.convert("RGB").crop(self.engine.MAP_CROP), dtype=np.int16)
        distance = np.max(np.abs(crop - self.ROAD_COLOR), axis=2)
        # 道路地面是稳定的纯游戏颜色。图标只会在其中挖出空洞。
        road = distance <= 5
        road = _dilate(road, 3)
        road = _erode(road, 3)
        road = _remove_small(road, 80)
        binary = Image.fromarray((road * 255).astype(np.uint8), "L")
        binary = binary.resize((round(binary.width * self.engine.X_SCALE), binary.height), Image.Resampling.NEAREST)
        binary = binary.rotate(self.engine.ANGLE, resample=Image.Resampling.NEAREST, expand=True, fillcolor=0)
        road = np.asarray(binary) > 0
        road = _erode(_dilate(road, 2), 2)
        return _largest_component(road)

    def _to_grid(self, road: np.ndarray) -> np.ndarray:
        h = (road.shape[0] // self.GRID) * self.GRID
        w = (road.shape[1] // self.GRID) * self.GRID
        ratio = road[:h, :w].reshape(h//self.GRID, self.GRID, w//self.GRID, self.GRID).mean(axis=(1, 3))
        state = np.full(ratio.shape, Cell.UNKNOWN, dtype=np.uint8)
        state[ratio >= 0.18] = Cell.ROAD
        # WALL 仍保留给未来适配器明确检测到的边界。
        return state

    def _graph(self, skeleton: np.ndarray):
        grid = self._to_grid(_dilate(skeleton, 1)) == Cell.ROAD
        nodes = tuple((int(x), int(y)) for y, x in zip(*np.nonzero(grid)))
        index = {point: i for i, point in enumerate(nodes)}
        edges = []
        for i, (x, y) in enumerate(nodes):
            # 需要对角相邻，因为光栅化旋转线时可能在水平和对角网格格之间交替。
            for neighbour in ((x+1,y), (x,y+1), (x+1,y+1), (x-1,y+1)):
                if neighbour in index:
                    edges.append((i, index[neighbour]))
        degree = [0] * len(nodes)
        for a, b in edges:
            degree[a] += 1; degree[b] += 1
        frontiers = tuple(nodes[i] for i, value in enumerate(degree) if value == 1)
        return nodes, tuple(edges), frontiers

    def _player_grid(self, point, shape):
        crop_size = (self.engine.MAP_CROP[2]-self.engine.MAP_CROP[0], self.engine.MAP_CROP[3]-self.engine.MAP_CROP[1])
        rect = self.engine.rectify_point((point[0]-self.engine.MAP_CROP[0], point[1]-self.engine.MAP_CROP[1]), crop_size)
        return (max(0, min(shape[1]-1, int(rect[0]//self.GRID))), max(0, min(shape[0]-1, int(rect[1]//self.GRID))))

    def _build(self):
        cumulative = None
        snapshots = []
        canvas_size = self.images[-1].size
        for frame, (image, offset, player_pair) in enumerate(zip(self.images, self.offsets, self.players)):
            canvas = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
            canvas.alpha_composite(image, dest=offset)
            observed = self._road_pixels(canvas)
            previous = np.zeros_like(observed) if cumulative is None else cumulative
            cumulative = observed if cumulative is None else (cumulative | observed)
            new_count = int((cumulative & ~previous).sum())
            skeleton = _skeletonize(cumulative)
            occupancy = self._to_grid(cumulative)
            nodes, edges, frontiers = self._graph(skeleton)
            local, mapped = player_pair
            snapshots.append(MapSnapshot(
                frame=frame, player_local=local, player_map=mapped,
                player_grid=self._player_grid(mapped, occupancy.shape), offset=offset,
                registration_score=self.score if frame == 0 else 1.0,
                occupancy=occupancy.copy(), road_mask=cumulative.copy(), skeleton=skeleton,
                frontiers=frontiers, nodes=nodes, edges=edges,
                new_road_pixels=new_count, total_road_pixels=int(cumulative.sum()),
            ))
        return snapshots
