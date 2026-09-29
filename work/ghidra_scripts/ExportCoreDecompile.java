// 从当前打开的 Ghidra 程序导出选定的核心函数。
// @category ReverseEngineering

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileResults;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Function;

public class ExportCoreDecompile extends GhidraScript {
    private static final String[] TARGETS = {
        "0x12e544",
        "0x12f58c",
        "0x12f60c",
        "0x12f6b0",
        "0x12f700",
        "0x12f800"
    };

    @Override
    protected void run() throws Exception {
        String[] args = getScriptArgs();
        if (args.length != 1) {
            throw new IllegalArgumentException("Expected one output-file argument");
        }

        File output = new File(args[0]);
        output.getParentFile().mkdirs();

        DecompInterface decompiler = new DecompInterface();
        decompiler.toggleCCode(true);
        decompiler.toggleSyntaxTree(true);
        if (!decompiler.openProgram(currentProgram)) {
            throw new IllegalStateException("Could not open program in decompiler");
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(output))) {
            writer.write("/* Ghidra 反编译：" + currentProgram.getName() + " */\n\n");

            for (String target : TARGETS) {
                Address address = toAddr(target);
                Function function = getFunctionAt(address);
                if (function == null) {
                    function = getFunctionContaining(address);
                }

                writer.write("/* ============================================================ */\n");
                writer.write("/* 目标：" + target + " */\n");

                if (function == null) {
                    writer.write("/* 未找到函数 */\n\n");
                    continue;
                }

                writer.write("/* Ghidra 名称：" + function.getName() + " */\n");
                writer.write("/* 入口：" + function.getEntryPoint() + " */\n");

                DecompileResults result = decompiler.decompileFunction(function, 180, monitor);
                if (!result.decompileCompleted()) {
                    writer.write("/* 反编译失败：" + result.getErrorMessage() + " */\n\n");
                    continue;
                }

                writer.write(result.getDecompiledFunction().getC());
                writer.write("\n\n");
            }
        }

        decompiler.dispose();
        println("Wrote decompilation to " + output.getAbsolutePath());
    }
}
