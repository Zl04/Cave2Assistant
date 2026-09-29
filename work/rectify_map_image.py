from pathlib import Path
from PIL import Image

source = Path(r"C:\Users\WARRIO~1.ZEN\AppData\Local\Temp\codex-clipboard-4734ae92-3d7b-40e0-925e-a4bf9d311c80.png")
target = Path(r"outputs\map_rectified_up_ne_right_se.png")

image = Image.open(source).convert("RGBA")

# 截图中两条道路轴线约为 (34, -17) 和 (34, +17) 像素。
# 压缩 X，使旋转前这些轴线变为 ±45°。
# 脚本中的 8.71/17.41 常量是逻辑移动坐标，不是截图的直接像素尺寸。
x_scale = 8.71 / 17.41
stretched = image.resize(
    (round(image.width * x_scale), image.height),
    Image.Resampling.LANCZOS,
)

# 在 Pillow 中，+45° 在视觉上逆时针旋转：原右上变为上方，原右下变为右方。
corrected = stretched.rotate(
    45,
    resample=Image.Resampling.BICUBIC,
    expand=True,
    fillcolor=(0, 0, 0, 0),
)

target.parent.mkdir(parents=True, exist_ok=True)
corrected.save(target)
print(f"{target} {corrected.width}x{corrected.height} scale={x_scale:.6f}")
