from pathlib import Path

SOURCE = Path(r"work/dk_apktool/assets/script.lc")
OUT = Path(r"outputs/lc_chunks")

def read_varint(data, pos):
    value = 0
    shift = 0
    while True:
        byte = data[pos]
        pos += 1
        value |= (byte & 0x7f) << shift
        if byte < 0x80:
            return value, pos
        shift += 7

def parse(data):
    pos = 0
    while pos < len(data):
        tag, pos = read_varint(data, pos)
        number, wire = tag >> 3, tag & 7
        if wire == 0:
            value, pos = read_varint(data, pos)
            yield number, wire, value
        elif wire == 1:
            yield number, wire, data[pos:pos + 8]
            pos += 8
        elif wire == 2:
            size, pos = read_varint(data, pos)
            yield number, wire, data[pos:pos + size]
            pos += size
        elif wire == 5:
            yield number, wire, data[pos:pos + 4]
            pos += 4
        else:
            raise ValueError(f"unsupported wire type {wire}")

def restore(payload):
    # libmqm.so 保持 00 和 FF 不变，并对其它每个字节取反。
    return bytes(b if b in (0x00, 0xff) else 0xff - b for b in payload)

data = SOURCE.read_bytes()
top = list(parse(data))
chunks = []
for number, wire, value in top:
    if number == 3 and wire == 2:
        chunks.append(("module_primary.luac", value))
    elif number == 6 and wire == 2:
        nested = list(parse(value))
        name = next(v.decode("utf-8") for n, w, v in nested if n == 1 and w == 2)
        code = next(v for n, w, v in nested if n == 2 and w == 2)
        chunks.append((f"module_{name}.luac", code))
    elif number == 7 and wire == 2:
        chunks.append(("module_main.luac", value))

OUT.mkdir(parents=True, exist_ok=True)
for name, payload in chunks:
    restored = restore(payload)
    path = OUT / name
    path.write_bytes(restored)
    print(name, len(restored), restored[:18].hex(" "))
