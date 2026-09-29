from pathlib import Path

DATA = Path(r"work/dk_apktool/assets/script.lc").read_bytes()

def varint(data, pos):
    value = 0
    shift = 0
    start = pos
    while pos < len(data) and shift < 70:
        byte = data[pos]
        pos += 1
        value |= (byte & 0x7f) << shift
        if byte < 0x80:
            return value, pos
        shift += 7
    raise ValueError(f"bad varint at {start:#x}")

def fields(data, limit=10000000):
    pos = 0
    out = []
    while pos < len(data) and len(out) < limit:
        start = pos
        tag, pos = varint(data, pos)
        number, wire = tag >> 3, tag & 7
        if number == 0:
            raise ValueError(f"field zero at {start:#x}")
        if wire == 0:
            value, pos = varint(data, pos)
            out.append((start, number, wire, value, pos))
        elif wire == 1:
            pos += 8
            out.append((start, number, wire, None, pos))
        elif wire == 2:
            size, pos = varint(data, pos)
            end = pos + size
            if end > len(data):
                raise ValueError(f"field {number} overruns at {start:#x}: {size}")
            out.append((start, number, wire, (pos, size), end))
            pos = end
        elif wire == 5:
            pos += 4
            out.append((start, number, wire, None, pos))
        else:
            raise ValueError(f"unsupported wire {wire} at {start:#x}")
    return out

top = fields(DATA)
print("size", len(DATA), "top_fields", len(top))
from collections import Counter
print("field_counts", Counter((x[1], x[2]) for x in top))
interesting = [x for x in top if x[1] != 2]
print("interesting", len(interesting))
for item in interesting:
    start, number, wire, value, end = item
    if wire == 2:
        payload, size = value
        preview = DATA[payload:payload + min(size, 60)]
        print(f"{start:08x} field={number} len={size} payload={payload:08x} preview={preview!r}")
    else:
        print(f"{start:08x} field={number} wire={wire} value={value}")

for item in top:
    if item[1] == 6 and item[2] == 2:
        payload, size = item[3]
        nested = fields(DATA[payload:payload + size])
        print("field6_nested_counts", Counter((x[1], x[2]) for x in nested))
        for n in nested[:20]:
            print("nested", n)
