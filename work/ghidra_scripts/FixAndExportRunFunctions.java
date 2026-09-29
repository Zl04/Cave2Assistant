// 为缺失的 JNI Run 符号创建 Thumb 函数，并导出其反编译结果。
// @category ReverseEngineering

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

import ghidra.app.cmd.disassemble.DisassembleCommand;
import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileResults;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Function;
import ghidra.program.model.symbol.Symbol;
import ghidra.program.model.symbol.SymbolIterator;

public class FixAndExportRunFunctions extends GhidraScript {
    private static final String[] NAMES = {
        "Java_com_cyjh_mqm_MQLanguageStub_Run__Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2IJ",
        "Java_com_cyjh_mqm_MQLanguageStub_Run___3BLjava_lang_String_2Ljava_lang_String_2IIJ",
        "Java_com_cyjh_mqm_MQLanguageStub_Run__Ljava_lang_String_2Ljava_lang_String_2Ljava_lang_String_2IIJ"
    };

    @Override
    protected void run() throws Exception {
        String[] args = getScriptArgs();
        if (args.length != 1) {
            throw new IllegalArgumentException("Expected one output-file argument");
        }

        List<Function> functions = new ArrayList<>();
        for (String name : NAMES) {
            SymbolIterator symbols = currentProgram.getSymbolTable().getSymbols(name);
            if (!symbols.hasNext()) {
                println("Missing symbol: " + name);
                continue;
            }

            Symbol symbol = symbols.next();
            Address raw = symbol.getAddress();
            Address entry = raw;
            if ((raw.getOffset() & 1) != 0) {
                entry = raw.subtract(1);
            }

            Function function = getFunctionAt(entry);
            if (function == null) {
                DisassembleCommand disassemble = new DisassembleCommand(entry, null, true);
                disassemble.applyTo(currentProgram, monitor);
                function = createFunction(entry, name);
            }
            if (function != null) {
                functions.add(function);
                println("Function " + function.getName() + " at " + function.getEntryPoint());
            }
        }

        File output = new File(args[0]);
        output.getParentFile().mkdirs();
        DecompInterface decompiler = new DecompInterface();
        decompiler.toggleCCode(true);
        decompiler.openProgram(currentProgram);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(output))) {
            writer.write("/* 已修复的 Thumb JNI Run 函数：" + currentProgram.getName() + " */\n\n");
            for (Function function : functions) {
                writer.write("/* ============================================================ */\n");
                writer.write("/* " + function.getName() + " @ " + function.getEntryPoint() + " */\n");
                DecompileResults result = decompiler.decompileFunction(function, 180, monitor);
                if (result.decompileCompleted()) {
                    writer.write(result.getDecompiledFunction().getC());
                }
                else {
                    writer.write("/* 失败：" + result.getErrorMessage() + " */\n");
                }
                writer.write("\n\n");
            }
        }
        decompiler.dispose();
    }
}
