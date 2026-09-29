"""Render sparse FindMultiColor rules recovered from the decompiled script."""

from pathlib import Path
from PIL import Image, ImageDraw, ImageFont


RULES = [
    ("怪物·颜色锚点", "49A1FE", ""),
    ("红怪/BOSS", "3837EC", ""),
    ("罐子", "88C5F1", "1|8|88C5F1,3|4|88C5F1,9|3|88C5F1"),
    ("石头", "BAB98B", "5|1|BBBA8C,2|3|BBBA8B,6|9|BAB98C"),
    ("点金机·1", "7FA7B9", "-3|-1|80A7B9,-3|3|80A7B9"),
    ("点金机·2", "8ABFD4", "-5|0|8BC0D5,-3|-2|8ABFD4,-2|3|8BBFD3"),
    ("点金机·3", "96D9EF", "4|-3|95D8EE,4|2|94D7ED,6|-1|95D8EE"),
    ("门·绿色型", "67A07C", "-5|-3|66A17D,-7|0|689B7F,-4|8|66A07C"),
    ("门·黄色型", "FFC461", "4|0|FFC461,7|-5|E7B767,5|5|FEB842"),
    ("BUFF·1", "E8F18E", "1|6|E3EC8C,3|3|E6EF8D,8|3|E7F18E"),
    ("BUFF·2", "E4ED8D", "0|-7|E6F08E,7|-7|E0E98C,7|-3|E8F18F,7|0|E3EC8E"),
    ("BUFF·3", "E5EE8D", "4|-3|E1EA8B,7|1|E0E98B,5|3|DFE88A"),
    ("金币", "60C9FF", "4|2|60C9FE,12|2|60C9FF,10|7|60C6FA,12|12|60C9FF"),
    ("钥匙", "60C9FF", "4|2|60C9FE,12|2|60C9FF,10|7|60C6FA,12|12|60C9FF"),
    ("箱子·普通模板", "537CD6", "2|6|547DDB,2|5|547DDB,2|8|547DDB"),
    ("箱子·金色模板", "4AA2FF", "-4|6|5DB8F9,2|4|49A1FE,2|7|49A1FE"),
    ("箱子·模板3", "4F75CC", "3|1|4F75CD,4|4|4E75CC,5|8|4E75CC"),
    ("箱子·模板4", "5E78AF", "0|4|5E78AF,1|7|5E78AF"),
    ("箱子·模板5", "2A375D", "5|0|446AA5,3|-7|446AA5,5|6|446AA5"),
    ("箱子·模板6", "4DB5F7", "6|0|58BEFF,1|-7|58BEFF,7|6|56BAFB"),
    ("箱子·模板7", "55B9F9", "5|1|58BDFE,5|-4|58BDFE,2|-9|58BDFE"),
    ("附魔机", "5FC9F1", "7|3|2D5C87,2|9|5FC9F1"),
]


def color_from_bgr(value):
    value = value.split("-")[0]
    b, g, r = int(value[0:2], 16), int(value[2:4], 16), int(value[4:6], 16)
    return r, g, b


def render_rule(name, first, offsets, size=(250, 155)):
    image = Image.new("RGB", size, (25, 30, 40))
    draw = ImageDraw.Draw(image)
    font = ImageFont.truetype(r"C:\Windows\Fonts\msyh.ttc", 18)
    small = ImageFont.truetype(r"C:\Windows\Fonts\msyh.ttc", 13)
    draw.text((12, 9), name, font=font, fill=(238, 244, 252))
    draw.text((12, 35), f"首色 {first} (BGR)", font=small, fill=(142, 171, 201))
    origin = (size[0] // 2, 95)
    draw.line((origin[0]-75, origin[1], origin[0]+75, origin[1]), fill=(55, 65, 78))
    draw.line((origin[0], origin[1]-43, origin[0], origin[1]+43), fill=(55, 65, 78))
    points = [(0, 0, first)]
    for item in filter(None, offsets.split(",")):
        x, y, color = item.split("|")
        points.append((int(x), int(y), color))
    scale = 6
    for index, (x, y, color) in enumerate(points):
        px, py = origin[0] + x*scale, origin[1] + y*scale
        fill = color_from_bgr(color)
        radius = 7 if index == 0 else 5
        draw.rectangle((px-radius, py-radius, px+radius, py+radius), fill=fill, outline="white")
        draw.text((px+radius+2, py-radius-2), str(index), font=small, fill="white")
    return image


def main():
    columns = 4
    card_size = (250, 155)
    rows = (len(RULES) + columns - 1) // columns
    sheet = Image.new("RGB", (card_size[0]*columns, card_size[1]*rows), (12, 15, 21))
    for index, rule in enumerate(RULES):
        card = render_rule(*rule, card_size)
        sheet.paste(card, ((index % columns)*card_size[0], (index // columns)*card_size[1]))
    output = Path(__file__).with_name("source_multipoint_color_templates.png")
    sheet.save(output)
    print(output)


if __name__ == "__main__":
    main()
