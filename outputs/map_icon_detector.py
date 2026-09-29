"""Template-based detector for the nine supplied minimap icons."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

import numpy as np
from PIL import Image, ImageFilter


@dataclass(frozen=True)
class IconDetection:
    kind: str
    label: str
    x: float
    y: float
    confidence: float
    box: tuple[int, int, int, int]


TEMPLATES = [
    ("monster", "怪物", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-90ca869d-6e14-4ca7-8d72-a5ce6d86d14d.png"),
    ("boss", "红怪/BOSS", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-fa9051a8-1f59-4892-bb39-98e38c434b38.png"),
    ("pot", "罐子", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-810af66d-7171-49b2-bc88-c9f5b9176fe0.png"),
    ("stone", "石头", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-152dcd76-a9a6-4982-bd70-2edfb528565b.png"),
    ("chest_normal", "普通箱子", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-59fb3d68-e159-41bf-81ce-dc15deb84d3a.png"),
    ("chest_gold", "金箱子", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-1fc4cc95-0647-444c-ab9c-633dcc3cfd12.png"),
    ("alchemy", "点金机", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-cbde525b-78f2-484e-8c8c-6d07e199851e.png"),
    ("buff", "BUFF/增益事件", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-2360cf48-eb92-446e-9e2b-865eee9f7c64.png"),
    ("coin", "金币", r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-5c192089-c603-469c-96e5-21fa4b76e0cd.png"),
]


def _components(mask: np.ndarray):
    seen = np.zeros_like(mask)
    result = []
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
        result.append(points)
    return result


class IconDetector:
    def __init__(self, templates=TEMPLATES):
        self.templates = []
        for kind, label, path in templates:
            image = Image.open(path).convert("RGB")
            rgb = np.asarray(image, dtype=np.int16)
            chroma = rgb.max(axis=2) - rgb.min(axis=2)
            colorful = (chroma >= 24) & (rgb.max(axis=2) >= 95)
            components = [c for c in _components(colorful) if len(c) >= 5]
            cx, cy = image.width / 2, image.height / 2
            component = min(components, key=lambda c: min((x-cx)**2 + (y-cy)**2 for x, y in c))
            core = np.zeros(colorful.shape, dtype=np.uint8)
            for x, y in component:
                core[y, x] = 255
            # 包含附近的抗锯齿和轮廓像素，但不要包含被裁剪进给定模板的无关图标。
            mask = np.asarray(Image.fromarray(core).filter(ImageFilter.MaxFilter(3))) > 0
            ys, xs = np.nonzero(mask)
            scores = chroma[ys, xs] + rgb[ys, xs].max(axis=1) / 4
            anchor_i = int(np.argmax(scores))
            anchor = (int(xs[anchor_i]), int(ys[anchor_i]))
            self.templates.append((kind, label, rgb, mask, anchor))

    def detect(self, image: Image.Image, region=(280, 160, 1000, 550)):
        screen = np.asarray(image.convert("RGB"), dtype=np.int16)
        detections = []
        x1, y1, x2, y2 = region
        for kind, label, template, mask, anchor in self.templates:
            th, tw = template.shape[:2]
            ax, ay = anchor
            anchor_color = template[ay, ax]
            area = screen[y1:y2, x1:x2]
            candidate = np.max(np.abs(area - anchor_color), axis=2) <= 12
            for ry, rx in zip(*np.nonzero(candidate)):
                left, top = x1 + int(rx) - ax, y1 + int(ry) - ay
                if left < 0 or top < 0 or left + tw > screen.shape[1] or top + th > screen.shape[0]:
                    continue
                patch = screen[top:top+th, left:left+tw]
                difference = np.abs(patch[mask] - template[mask])
                mae = float(difference.mean())
                good = float((difference.max(axis=1) <= 18).mean())
                confidence = max(0.0, min(1.0, 0.55 * good + 0.45 * (1.0 - mae / 35.0)))
                if confidence >= 0.78:
                    detections.append(IconDetection(
                        kind, label, left + tw/2, top + th/2, confidence,
                        (left, top, left+tw, top+th)))
        # 非极大值抑制，包括跨类别碰撞。
        kept = []
        for detection in sorted(detections, key=lambda d: d.confidence, reverse=True):
            if any((detection.x-k.x)**2 + (detection.y-k.y)**2 < 11**2 for k in kept):
                continue
            kept.append(detection)
        return sorted(kept, key=lambda d: (d.y, d.x))
