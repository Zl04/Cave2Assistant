from __future__ import annotations

import argparse
import plistlib
import re
import struct
import zlib
from pathlib import Path

from PIL import Image


DELTA = 0x9E3779B9
MASK = 0xFFFFFFFF


def _mx(z: int, y: int, total: int, key: tuple[int, ...], p: int, e: int) -> int:
    return ((((z >> 5) ^ (y << 2)) + ((y >> 3) ^ (z << 4))) ^
            ((total ^ y) + (key[(p & 3) ^ e] ^ z))) & MASK


def generate_cocos_key(parts: tuple[int, int, int, int]) -> list[int]:
    """Generate cocos2d-x's 1024-word PVR XOR stream using XXTEA."""
    values = [0] * 1024
    rounds = 6 + 52 // len(values)
    total = 0
    z = values[-1]
    while rounds:
        rounds -= 1
        total = (total + DELTA) & MASK
        e = (total >> 2) & 3
        for p in range(len(values) - 1):
            y = values[p + 1]
            values[p] = (values[p] + _mx(z, y, total, parts, p, e)) & MASK
            z = values[p]
        y = values[0]
        p = len(values) - 1
        values[p] = (values[p] + _mx(z, y, total, parts, p, e)) & MASK
        z = values[p]
    return values


def decrypt_cczp(blob: bytes, parts: tuple[int, int, int, int]) -> bytes:
    if blob[:4] != b"CCZp":
        return blob
    out = bytearray(blob)
    stream = generate_cocos_key(parts)
    # 第一个加密字是 +0x0c 处的 CCZ 解压长度字段。
    # +0x08 处的 32 位字段是校验和/保留值，保持不变。
    encrypted_offset = 12
    word_count = (len(out) - encrypted_offset) // 4
    key_index = 0
    for word_index in range(min(word_count, 512)):
        offset = encrypted_offset + word_index * 4
        value = struct.unpack_from("<I", out, offset)[0] ^ stream[key_index % len(stream)]
        struct.pack_into("<I", out, offset, value)
        key_index += 1
    for word_index in range(512, word_count, 64):
        offset = encrypted_offset + word_index * 4
        value = struct.unpack_from("<I", out, offset)[0] ^ stream[key_index % len(stream)]
        struct.pack_into("<I", out, offset, value)
        key_index += 1
    out[3] = ord("!")
    return bytes(out)


def decompress_ccz(blob: bytes) -> bytes:
    if blob[:4] != b"CCZ!":
        raise ValueError(f"not a decrypted CCZ stream: {blob[:16].hex()}")
    compression, version = struct.unpack_from(">HH", blob, 4)
    expected = struct.unpack_from(">I", blob, 12)[0]
    if compression != 0 or version > 2:
        raise ValueError(f"unsupported CCZ header compression={compression}, version={version}")
    raw = zlib.decompress(blob[16:])
    if expected and len(raw) != expected:
        raise ValueError(f"CCZ size mismatch: expected {expected}, got {len(raw)}")
    return raw


def pvr3_to_image(raw: bytes) -> Image.Image:
    if raw[:4] != b"PVR\x03":
        raise ValueError(f"unsupported PVR header: {raw[:16].hex()}")
    pixel_format = struct.unpack_from("<Q", raw, 8)[0]
    height, width = struct.unpack_from("<II", raw, 24)
    metadata_size = struct.unpack_from("<I", raw, 48)[0]
    pixels = raw[52 + metadata_size:]
    # 未压缩的 8 位 RGBA/BGRA PVR3 将通道字母存储在低双字中，
    # 将通道位宽存储在高双字中。
    channels = struct.pack("<I", pixel_format & MASK).rstrip(b"\0").decode("ascii")
    depths = struct.pack("<I", pixel_format >> 32)
    if depths[:4] != b"\x08\x08\x08\x08" or channels not in {"rgba", "bgra", "argb", "abgr"}:
        raise ValueError(f"unsupported PVR pixel format 0x{pixel_format:016x}")
    image = Image.frombytes("RGBA", (width, height), pixels[:width * height * 4], "raw", channels.upper())
    return image


def parse_pair(text: str) -> tuple[int, int]:
    values = [int(v) for v in re.findall(r"-?\d+", text)]
    return values[0], values[1]


def parse_rect(text: str) -> tuple[int, int, int, int]:
    values = [int(v) for v in re.findall(r"-?\d+", text)]
    return values[0], values[1], values[2], values[3]


def extract_frames(sheet: Image.Image, plist_path: Path, output: Path) -> None:
    data = plistlib.loads(plist_path.read_bytes())
    output.mkdir(parents=True, exist_ok=True)
    for name, frame in data["frames"].items():
        rect_text = frame.get("frame", frame.get("textureRect"))
        x, y, width, height = parse_rect(rect_text)
        crop = sheet.crop((x, y, x + width, y + height))
        if frame.get("rotated", frame.get("textureRotated", False)):
            crop = crop.transpose(Image.Transpose.ROTATE_90)
        source_width, source_height = parse_pair(
            frame.get("sourceSize", frame.get("spriteSourceSize")))
        offset_x, offset_y = parse_pair(frame.get("offset", frame.get("spriteOffset")))
        canvas = Image.new("RGBA", (source_width, source_height))
        left = (source_width - crop.width) // 2 + offset_x
        top = (source_height - crop.height) // 2 - offset_y
        canvas.alpha_composite(crop, (left, top))
        canvas.save(output / name)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("ccz", type=Path)
    parser.add_argument("plist", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    # Cocos2dxHelper.decryptKey 会反转 ZipUtils::inflateCCZBuffer 使用的每个十进制字符串，
    # 从而得到这四个无符号密钥部分。
    parts = (0x3EC6DE31, 0xC4D969DB, 0x34B42791, 0x6C3BFBE0)
    decrypted = decrypt_cczp(args.ccz.read_bytes(), parts)
    raw = decompress_ccz(decrypted)
    sheet = pvr3_to_image(raw)
    args.output.mkdir(parents=True, exist_ok=True)
    sheet.save(args.output / "_atlas.png")
    extract_frames(sheet, args.plist, args.output)
    print(f"atlas={sheet.size}, frames={len(list(args.output.glob('*.png'))) - 1}, output={args.output}")


if __name__ == "__main__":
    main()
