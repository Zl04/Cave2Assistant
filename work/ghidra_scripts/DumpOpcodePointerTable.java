// 导出候选 Lua 操作码名称指针表。
// @category ReverseEngineering

import java.io.*;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.mem.Memory;

public class DumpOpcodePointerTable extends GhidraScript {
    public void run() throws Exception {
        Memory mem = currentProgram.getMemory();
        Address start = toAddr("0x4ad200");
        try (PrintWriter out = new PrintWriter(new FileWriter(getScriptArgs()[0]))) {
            for (int i = 0; i < 64; i++) {
                Address slot = start.add(i * 4L);
                long raw = Integer.toUnsignedLong(mem.getInt(slot));
                Address target = toAddr(raw);
                StringBuilder s = new StringBuilder();
                if (mem.contains(target)) {
                    for (int j = 0; j < 64; j++) {
                        int b = Byte.toUnsignedInt(mem.getByte(target.add(j)));
                        if (b == 0) break;
                        if (b < 32 || b > 126) { s.append(String.format("\\x%02x", b)); }
                        else s.append((char)b);
                    }
                }
                out.printf("%02d slot=%s ptr=%s text=%s%n", i, slot, target, s);
            }
        }
    }
}
