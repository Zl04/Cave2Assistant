// 查找 Lua 操作码名称字符串及其所有引用。
// @category ReverseEngineering

import java.io.*;
import java.util.*;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.data.StringDataInstance;
import ghidra.program.model.listing.Data;
import ghidra.program.model.symbol.Reference;

public class FindOpcodeTables extends GhidraScript {
    private static final Set<String> NAMES = new HashSet<>(Arrays.asList(
        "MOVE", "LOADK", "LOADBOOL", "LOADNIL", "GETUPVAL", "GETGLOBAL",
        "GETTABLE", "SETGLOBAL", "SETUPVAL", "SETTABLE", "NEWTABLE", "SELF",
        "ADD", "SUB", "MUL", "DIV", "MOD", "POW", "UNM", "NOT", "LEN",
        "CONCAT", "JMP", "EQ", "LT", "LE", "TEST", "TESTSET", "CALL",
        "TAILCALL", "RETURN", "FORLOOP", "FORPREP", "TFORCALL", "TFORLOOP",
        "SETLIST", "CLOSE", "CLOSURE", "VARARG", "EXTRAARG"));

    public void run() throws Exception {
        String outName = getScriptArgs()[0];
        try (PrintWriter out = new PrintWriter(new FileWriter(outName))) {
            for (Data d : currentProgram.getListing().getDefinedData(true)) {
                StringDataInstance sdi = StringDataInstance.getStringDataInstance(d);
                String value = sdi.getStringValue();
                if (value == null || !NAMES.contains(value)) continue;
                Address a = d.getAddress();
                out.println(value + " @ " + a);
                for (Reference ref : getReferencesTo(a)) {
                    out.println("  ref " + ref.getFromAddress() + " " + ref.getReferenceType());
                }
            }
        }
    }
}
