from pathlib import Path
import struct

INPUT_DIR = Path(r"outputs/lc_chunks")
OUTPUT_DIR = Path(r"outputs/lc_chunks_normalized")

# MQM 操作码 -> 标准 Lua 5.2 操作码。操作码 31 和 33 需要重写操作数。
OPMAP = {
    0: 13, 1: 14, 2: 15, 3: 16, 4: 17, 5: 18,
    6: 19, 7: 20, 8: 21, 9: 22, 10: 23,
    11: 24, 12: 25, 13: 26, 14: 27, 15: 28,
    16: 29, 17: 30, 18: 31, 19: 32, 20: 33,
    21: 34, 22: 35, 23: 36, 24: 37,
    25: 0, 26: 1, 27: 3, 28: 4, 29: 5,
    30: 39, 31: 6, 32: 7, 33: 8, 34: 9,
    35: 10, 36: 11, 37: 12, 38: 38,
}

class Chunk:
    def __init__(self, data):
        self.data = bytearray(data)
        self.pos = 18  # 这些分块使用的确切头部大小
        assert self.data[:5] == b"\x1bLuaR"

    def u8(self):
        v = self.data[self.pos]
        self.pos += 1
        return v

    def u32(self):
        v = struct.unpack_from("<I", self.data, self.pos)[0]
        self.pos += 4
        return v

    def skip(self, n):
        self.pos += n

    def string(self):
        n = self.u32()
        if n:
            self.skip(n)

    @staticmethod
    def abc(op, a, b, c):
        return op | (a << 6) | (c << 14) | (b << 23)

    def instruction(self, offset):
        word = struct.unpack_from("<I", self.data, offset)[0]
        op = word & 0x3f
        a = (word >> 6) & 0xff
        c = (word >> 14) & 0x1ff
        b = (word >> 23) & 0x1ff
        if op not in OPMAP:
            raise ValueError(f"unknown opcode {op} at {offset:#x}")
        if op == 31:  # 自定义 GETGLOBAL A,C -> GETTABUP A,0,C
            word = self.abc(6, a, 0, c)
        elif op == 33:  # 自定义 SETGLOBAL A,C -> SETTABUP 0,C,A
            word = self.abc(8, 0, c, a)
        else:
            word = (word & ~0x3f) | OPMAP[op]
        struct.pack_into("<I", self.data, offset, word)

    def function(self):
        self.skip(8)       # 行定义、末行定义
        self.skip(2)       # 参数、可变参数
        # 某些有意构造错误且不可达的辅助原型引用了其声明栈的上一个寄存器。
        # 放宽该声明，使 unluac 能继续处理有用函数。
        self.data[self.pos] = 250
        self.skip(1)       # 最大栈
        ncode = self.u32()
        for _ in range(ncode):
            offset = self.pos
            self.instruction(offset)
            self.skip(4)

        nconst = self.u32()
        for _ in range(nconst):
            kind = self.u8()
            if kind == 0:
                pass
            elif kind == 1:
                self.skip(1)
            elif kind == 3:
                self.skip(8)
            elif kind == 4:
                self.string()
            else:
                raise ValueError(f"unknown constant type {kind} at {self.pos - 1:#x}")

        nproto = self.u32()
        for _ in range(nproto):
            self.function()

        nup = self.u32()
        self.skip(nup * 2)

        self.string()      # Lua 5.2 中源码名称位于 upvalue 描述符之后
        nline = self.u32()
        self.skip(nline * 4)
        nlocal = self.u32()
        for _ in range(nlocal):
            self.string()
            self.skip(8)
        nupname = self.u32()
        for _ in range(nupname):
            self.string()

    def normalize(self):
        self.function()
        if self.pos != len(self.data):
            raise ValueError(f"parse ended at {self.pos:#x}, file ends at {len(self.data):#x}")
        return bytes(self.data)

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
for source in INPUT_DIR.glob("*.luac"):
    target = OUTPUT_DIR / source.name
    normalized = Chunk(source.read_bytes()).normalize()
    target.write_bytes(normalized)
    print(source.name, len(normalized))
