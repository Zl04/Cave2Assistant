from pathlib import Path
from collections import deque
from PIL import Image
import numpy as np

IMAGES = [
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-07047e42-5c74-4aff-be2d-ad4ccfa06b8a.png"),
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-2a2a0b57-5f41-40dd-b5f5-23482e870c83.png"),
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-309aa9d3-6f0d-4039-a4fb-49ec8c25bded.png"),
    Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-4734ae92-3d7b-40e0-925e-a4bf9d311c80.png"),
]

def components(mask):
    h, w = mask.shape
    seen = np.zeros_like(mask, dtype=bool)
    result = []
    for y, x in zip(*np.nonzero(mask)):
        if seen[y, x]:
            continue
        stack = [(x, y)]
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
        if len(pts) >= 8:
            xs = [p[0] for p in pts]
            ys = [p[1] for p in pts]
            result.append((len(pts), min(xs), min(ys), max(xs), max(ys), sum(xs)/len(xs), sum(ys)/len(ys)))
    return sorted(result, reverse=True)

for i, path in enumerate(IMAGES, 1):
    rgb = np.asarray(Image.open(path).convert("RGB"))
    r, g, b = rgb[..., 0], rgb[..., 1], rgb[..., 2]
    cyan = (b > 145) & (g > 115) & (r < 105) & ((b.astype(int) - r) > 70)
    comps = components(cyan)
    print(i, rgb.shape[1], rgb.shape[0])
    for c in comps[:12]:
        print(" ", c)
