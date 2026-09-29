from PIL import Image, ImageDraw, ImageFont

src = r"outputs/adb_map_controller/void-rift-selection-current.png"
dst = r"outputs/adb_map_controller/void-rift-selection-annotated.png"
im = Image.open(src).convert("RGBA")
overlay = Image.new("RGBA", im.size, (0, 0, 0, 0))
draw = ImageDraw.Draw(overlay, "RGBA")

try:
    font = ImageFont.truetype("C:/Windows/Fonts/msyh.ttc", 28)
    small = ImageFont.truetype("C:/Windows/Fonts/msyh.ttc", 22)
except OSError:
    font = ImageFont.load_default()
    small = font

def box(rect, color, label, text_xy, fill=None, width=5):
    draw.rectangle(rect, outline=color, width=width, fill=fill)
    x, y = text_xy
    bbox = draw.textbbox((x, y), label, font=font)
    draw.rounded_rectangle((bbox[0]-6, bbox[1]-4, bbox[2]+6, bbox[3]+4), radius=5, fill=(0,0,0,210))
    draw.text((x, y), label, font=font, fill=color)

# 完整视觉卡片边界。
cards = [
    ((347, 136, 679, 814), (255, 70, 70, 255), "宝石卡 1：飞驰之靴", (350, 105)),
    ((738, 136, 1067, 814), (255, 70, 70, 255), "宝石卡 2：冰酒堡烈酒", (741, 105)),
    ((1139, 136, 1468, 814), (255, 70, 70, 255), "宝石卡 3：丹顿律法", (1142, 105)),
]
for rect, color, label, pos in cards:
    box(rect, color, label, pos)

# 实际的归一化检测器采样窗口（橙色像素区域）。
rois = [
    ((346, 140, 729, 464), (255, 210, 40, 255), "检测区 1", (350, 145)),
    ((749, 140, 1171, 464), (255, 210, 40, 255), "检测区 2", (753, 145)),
    ((1190, 140, 1574, 464), (255, 210, 40, 255), "检测区 3", (1194, 145)),
]
for rect, color, label, pos in rois:
    box(rect, color, label, pos, fill=(255, 210, 40, 28), width=3)

# 选择按钮和放弃按钮。
buttons = [
    ((370, 674, 658, 728), (60, 210, 255, 255), "选择 1", (378, 680)),
    ((785, 674, 1003, 728), (60, 210, 255, 255), "选择 2", (793, 680)),
    ((1167, 674, 1454, 728), (60, 210, 255, 255), "选择 3", (1175, 680)),
    ((764, 839, 1025, 916), (180, 120, 255, 255), "放弃", (835, 848)),
]
for rect, color, label, pos in buttons:
    box(rect, color, label, pos, width=4)

im = Image.alpha_composite(im, overlay)
draw = ImageDraw.Draw(im, "RGBA")

# 图例。
legend = "红框=识别到的完整卡片  黄框=算法取色检测区  蓝框=选择按钮  紫框=放弃"
lb = draw.textbbox((20, 20), legend, font=small)
draw.rounded_rectangle((lb[0]-10, lb[1]-7, lb[2]+10, lb[3]+7), radius=6, fill=(0,0,0,200))
draw.text((20, 20), legend, font=small, fill=(255,255,255,255))

im.convert("RGB").save(dst, quality=95)
print(dst)
