"""Build helper-compatible Lua 5.2 chunks and inject the navigation module.

The helper uses stock Lua 5.2 chunk structure with a permuted opcode table.
This script performs the inverse of normalize_mqm_lua52.py, verifies an exact
opcode round trip, applies the container byte transform, and appends a named
field-6 module without changing any existing protobuf fields.
"""

from __future__ import annotations

import argparse
import struct
import subprocess
from pathlib import Path
from dataclasses import dataclass, field


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_LUAC = ROOT / "work/tools/lua52-win32/luac52.exe"

# MQM 操作码 -> 标准 Lua 5.2 操作码。
OPMAP = {
    0: 13, 1: 14, 2: 15, 3: 16, 4: 17, 5: 18, 6: 19, 7: 20,
    8: 21, 9: 22, 10: 23, 11: 24, 12: 25, 13: 26, 14: 27, 15: 28,
    16: 29, 17: 30, 18: 31, 19: 32, 20: 33, 21: 34, 22: 35,
    23: 36, 24: 37, 25: 0, 26: 1, 27: 3, 28: 4, 29: 5,
    30: 39, 31: 6, 32: 7, 33: 8, 34: 9, 35: 10, 36: 11,
    37: 12, 38: 38,
}
INVERSE = {stock: custom for custom, stock in OPMAP.items()}


class ChunkTransformer:
    def __init__(self, data: bytes, direction: str):
        self.data = bytearray(data)
        self.pos = 18
        self.direction = direction
        if self.data[:18] != bytes.fromhex("1b4c7561520001040404080019930d0a1a0a"):
            raise ValueError("chunk is not 32-bit Lua 5.2")

    def u8(self) -> int:
        value = self.data[self.pos]
        self.pos += 1
        return value

    def u32(self) -> int:
        value = struct.unpack_from("<I", self.data, self.pos)[0]
        self.pos += 4
        return value

    def skip(self, amount: int) -> None:
        self.pos += amount

    def string(self) -> None:
        length = self.u32()
        self.skip(length)

    @staticmethod
    def abc(op: int, a: int, b: int, c: int) -> int:
        return op | (a << 6) | (c << 14) | (b << 23)

    def instruction(self, offset: int) -> None:
        word = struct.unpack_from("<I", self.data, offset)[0]
        op, a = word & 0x3F, (word >> 6) & 0xFF
        c, b = (word >> 14) & 0x1FF, (word >> 23) & 0x1FF
        if self.direction == "canonical":
            # MQM 的 GETGLOBAL/SETGLOBAL 不记录哪个闭包槽位保存 _ENV。
            # Lua 编译器可能为嵌套闭包中的 _ENV 分配不同槽位，
            # 因此将这个无关选择器规范化后再比较。
            if op == 6:
                word = self.abc(6, a, 0, c)
            elif op == 8:
                word = self.abc(8, 0, b, c)
        elif self.direction == "to_custom":
            if op == 6:  # GETTABUP A,env,C -> 自定义 GETGLOBAL A,C
                word = self.abc(31, a, 0, c)
            elif op == 8:  # SETTABUP env,B,C -> 自定义 SETGLOBAL C,B
                word = self.abc(33, c, 0, b)
            else:
                if op not in INVERSE:
                    raise ValueError(f"stock opcode {op} has no MQM mapping")
                word = (word & ~0x3F) | INVERSE[op]
        else:
            if op == 31:
                word = self.abc(6, a, 0, c)
            elif op == 33:
                word = self.abc(8, 0, c, a)
            else:
                if op not in OPMAP:
                    raise ValueError(f"MQM opcode {op} has no stock mapping")
                word = (word & ~0x3F) | OPMAP[op]
        struct.pack_into("<I", self.data, offset, word)

    def function(self) -> None:
        self.skip(8)  # 行定义、末行定义
        self.skip(3)  # 参数、可变参数、最大栈
        for _ in range(self.u32()):
            offset = self.pos
            self.instruction(offset)
            self.skip(4)
        for _ in range(self.u32()):
            kind = self.u8()
            if kind == 1:
                self.skip(1)
            elif kind == 3:
                self.skip(8)
            elif kind == 4:
                self.string()
            elif kind != 0:
                raise ValueError(f"unknown constant kind {kind} at {self.pos - 1:#x} in prototype {result.start:#x}")
        for _ in range(self.u32()):
            self.function()
        self.skip(self.u32() * 2)  # upvalue 描述符
        self.string()  # 源码
        self.skip(self.u32() * 4)  # 行信息
        for _ in range(self.u32()):
            self.string()
            self.skip(8)
        for _ in range(self.u32()):
            self.string()

    def transform(self) -> bytes:
        self.function()
        if self.pos != len(self.data):
            raise ValueError(f"chunk ended at {self.pos:#x}, expected {len(self.data):#x}")
        return bytes(self.data)


def varint(value: int) -> bytes:
    result = bytearray()
    while value >= 0x80:
        result.append((value & 0x7F) | 0x80)
        value >>= 7
    result.append(value)
    return bytes(result)


def field_bytes(number: int, payload: bytes) -> bytes:
    return varint((number << 3) | 2) + varint(len(payload)) + payload


def container_transform(payload: bytes) -> bytes:
    return bytes(value if value in (0, 0xFF) else 0xFF - value for value in payload)


def named_module(name: str, custom_chunk: bytes) -> bytes:
    nested = field_bytes(1, name.encode("utf-8")) + field_bytes(2, container_transform(custom_chunk))
    return field_bytes(6, nested)


@dataclass
class PrototypeSpan:
    start: int
    end: int = 0
    constants: set[str] = field(default_factory=set)
    children: list["PrototypeSpan"] = field(default_factory=list)


class ChunkIndex:
    """Index function byte ranges without interpreting instructions."""

    def __init__(self, data: bytes):
        self.data = data
        self.pos = 18

    def u8(self) -> int:
        value = self.data[self.pos]
        self.pos += 1
        return value

    def u32(self) -> int:
        value = struct.unpack_from("<I", self.data, self.pos)[0]
        self.pos += 4
        return value

    def string(self) -> bytes:
        length = self.u32()
        value = self.data[self.pos:self.pos + length]
        self.pos += length
        return value[:-1] if value.endswith(b"\0") else value

    def function(self) -> PrototypeSpan:
        result = PrototypeSpan(self.pos)
        self.pos += 11
        code_count = self.u32()
        self.pos += code_count * 4
        constant_count = self.u32()
        for _ in range(constant_count):
            kind = self.u8()
            if kind == 1:
                self.pos += 1
            elif kind == 3:
                self.pos += 8
            elif kind == 4:
                value = self.string()
                try:
                    result.constants.add(value.decode("utf-8"))
                except UnicodeDecodeError:
                    pass
            elif kind != 0:
                raise ValueError(f"unknown constant kind {kind} at {self.pos - 1:#x} in prototype {result.start:#x}")
        prototype_count = self.u32()
        for _ in range(prototype_count):
            result.children.append(self.function())
        upvalue_count = self.u32()
        self.pos += upvalue_count * 2
        self.string()
        line_count = self.u32()
        self.pos += line_count * 4
        local_count = self.u32()
        for _ in range(local_count):
            self.string()
            self.pos += 8
        upvalue_name_count = self.u32()
        for _ in range(upvalue_name_count):
            self.string()
        result.end = self.pos
        return result

    def index(self) -> PrototypeSpan:
        root = self.function()
        if self.pos != len(self.data):
            raise ValueError("prototype index did not consume chunk")
        return root


def flatten(prototype: PrototypeSpan):
    yield prototype
    for child in prototype.children:
        yield from flatten(child)


def replace_movement_prototype_by_constants(primary: bytes, replacement_chunk: bytes, required: set[str]) -> tuple[bytes, PrototypeSpan]:
    primary_root = ChunkIndex(primary).index()
    candidates = [item for item in flatten(primary_root) if required <= item.constants]
    if len(candidates) != 1:
        raise RuntimeError(f"expected one movement prototype, found {len(candidates)}")
    replacement_root = ChunkIndex(replacement_chunk).index()
    if len(replacement_root.children) != 1:
        raise RuntimeError("movement replacement source must return exactly one function")
    target, replacement = candidates[0], replacement_root.children[0]
    return primary[:target.start] + replacement_chunk[replacement.start:replacement.end] + primary[target.end:], target


def read_varint(data: bytes, position: int) -> tuple[int, int]:
    value, shift = 0, 0
    while True:
        byte = data[position]
        position += 1
        value |= (byte & 0x7F) << shift
        if byte < 0x80:
            return value, position
        shift += 7


def rewrite_container(original: bytes, primary_custom: bytes, modules: list[tuple[str, bytes]]) -> bytes:
    result = bytearray()
    position, replaced = 0, False
    while position < len(original):
        start = position
        tag, position = read_varint(original, position)
        number, wire = tag >> 3, tag & 7
        if wire == 0:
            _, position = read_varint(original, position)
        elif wire == 1:
            position += 8
        elif wire == 2:
            length, payload_start = read_varint(original, position)
            position = payload_start + length
        elif wire == 5:
            position += 4
        else:
            raise ValueError(f"unsupported protobuf wire type {wire}")
        if number == 3 and wire == 2:
            result.extend(field_bytes(3, container_transform(primary_custom)))
            replaced = True
        else:
            result.extend(original[start:position])
    if not replaced:
        raise RuntimeError("container has no primary field")
    for name, module in modules:
        result.extend(named_module(name, module))
    return bytes(result)


def compile_source(luac: Path, source: Path, output: Path) -> bytes:
    subprocess.run([str(luac), "-o", str(output), str(source)], check=True)
    return output.read_bytes()


def embedded_target_source(build_dir: Path) -> Path:
    """Put navigation and adapter code inside the replaced target prototype.

    MQM field-6 modules require compiler-generated symbol metadata in addition
    to their name and bytecode.  Appending only those two fields makes normal
    Lua require() ignore the module, so the replacement must be self-contained.
    """
    runtime = (ROOT / "outputs/auxiliary_v2/runtime_navigation.lua").read_text(encoding="utf-8")
    runtime = runtime.replace("return RuntimeNavigation\n", "local Navigation = RuntimeNavigation\n")
    adapter = (ROOT / "outputs/auxiliary_v2/original_movement_adapter.lua").read_text(encoding="utf-8")
    adapter = adapter.replace("return Adapter\n", "")
    entry = (ROOT / "outputs/auxiliary_v2/target_selection_entry.lua").read_text(encoding="utf-8")
    marker = "return function()\n"
    if marker not in entry:
        raise RuntimeError("target selection entry has no returned function")
    entry = entry.replace(
        marker,
        marker + runtime + "\n" + adapter + "\n",
        1,
    )
    entry = entry.replace('  local Navigation = require("runtime_navigation")\n', "", 1)
    entry = entry.replace('  local Adapter = require("original_movement_adapter")\n', "", 1)
    output = build_dir / "target_selection_embedded.lua"
    output.write_text(entry, encoding="utf-8", newline="\n")
    return output


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--luac", type=Path, default=DEFAULT_LUAC)
    parser.add_argument("--container", type=Path, default=ROOT / "work/dk_apktool/assets/script.original.lc")
    parser.add_argument("--output", type=Path, default=ROOT / "outputs/auxiliary_v2/script.with_runtime_navigation.lc")
    args = parser.parse_args()

    build_dir = ROOT / "outputs/auxiliary_v2/build"
    build_dir.mkdir(parents=True, exist_ok=True)
    source = ROOT / "outputs/auxiliary_v2/runtime_navigation.lua"
    stock_path = build_dir / "runtime_navigation.stock.luac"
    stock = compile_source(args.luac, source, stock_path)
    custom = ChunkTransformer(stock, "to_custom").transform()
    restored = ChunkTransformer(custom, "to_stock").transform()
    canonical = ChunkTransformer(stock, "canonical").transform()
    if restored != canonical:
        raise RuntimeError("opcode round trip changed non-environment operands")
    (build_dir / "runtime_navigation.mqm.luac").write_bytes(custom)

    # 从已知的原始容器中提取/恢复主字段。
    # 有意保留该字段：不替换辅助程序的移动/交互函数，
    # 运行时模块会继续使用已有的路径契约。
    position, primary = 0, None
    original = args.container.read_bytes()
    while position < len(original):
        tag, position = read_varint(original, position)
        number, wire = tag >> 3, tag & 7
        if wire == 0:
            _, position = read_varint(original, position)
        elif wire == 1:
            position += 8
        elif wire == 2:
            length, payload_start = read_varint(original, position)
            payload = original[payload_start:payload_start + length]
            position = payload_start + length
            if number == 3:
                primary = container_transform(payload)
        elif wire == 5:
            position += 4
    if primary is None:
        raise RuntimeError("could not extract primary chunk")
    adapter_stock = compile_source(args.luac, ROOT / "outputs/auxiliary_v2/original_movement_adapter.lua", build_dir / "original_movement_adapter.stock.luac")
    adapter_custom = ChunkTransformer(adapter_stock, "to_custom").transform()
    entry_source = embedded_target_source(build_dir)
    entry_stock = compile_source(args.luac, entry_source, build_dir / "target_selection_entry.stock.luac")
    entry_custom = ChunkTransformer(entry_stock, "to_custom").transform()
    patched_primary, target = replace_movement_prototype_by_constants(
        primary, entry_custom, {"路径", "有方向", "看小图数", "线程启动", "关闭小地图"}
    )
    movement_stock = compile_source(
        args.luac,
        ROOT / "outputs/auxiliary_v2/self_movement_entry.lua",
        build_dir / "self_movement_entry.stock.luac",
    )
    movement_custom = ChunkTransformer(movement_stock, "to_custom").transform()
    patched_primary, movement_target = replace_movement_prototype_by_constants(
        patched_primary,
        movement_custom,
        {"开始答题", "路径", "需要重置线程", "移动间隔输入框", "开始移动"},
    )
    coordinator_stock = compile_source(args.luac, ROOT / "outputs/auxiliary_v2/navigation_coordinator_entry.lua", build_dir / "navigation_coordinator_entry.stock.luac")
    coordinator_custom = ChunkTransformer(coordinator_stock, "to_custom").transform()
    patched_primary, coordinator_target = replace_movement_prototype_by_constants(
        patched_primary, coordinator_custom,
        {"打开了小地图", "没检测到小地图,将要打开", "小图有角色", "小图没角色"}
    )
    (build_dir / "module_primary.target_selector.mqm.luac").write_bytes(patched_primary)
    patched = rewrite_container(original, patched_primary, [])
    args.output.write_bytes(patched)
    print(f"stock={len(stock)} custom={len(custom)} original={len(original)} patched={len(patched)}")
    print(f"target-selector={target.start:#x}:{target.end:#x} replaced")
    print(f"movement-consumer={movement_target.start:#x}:{movement_target.end:#x} replaced")
    print(f"navigation-coordinator={coordinator_target.start:#x}:{coordinator_target.end:#x} replaced")
    print(f"roundtrip=semantic-exact output={args.output}")


if __name__ == "__main__":
    main()
