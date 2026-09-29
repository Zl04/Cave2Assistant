// 为名称包含任意请求词的函数导出反编译结果。
// @category ReverseEngineering

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileResults;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionIterator;

public class ExportNamedFunctions extends GhidraScript {
    @Override
    protected void run() throws Exception {
        String[] args = getScriptArgs();
        if (args.length < 2) {
            throw new IllegalArgumentException("Usage: output-file token [token ...]");
        }

        List<Function> matches = new ArrayList<>();
        FunctionIterator functions = currentProgram.getFunctionManager().getFunctions(true);
        while (functions.hasNext()) {
            Function function = functions.next();
            String name = function.getName();
            for (int i = 1; i < args.length; i++) {
                if (name.contains(args[i])) {
                    matches.add(function);
                    break;
                }
            }
        }
        matches.sort(Comparator.comparing(Function::getEntryPoint));

        File output = new File(args[0]);
        output.getParentFile().mkdirs();
        DecompInterface decompiler = new DecompInterface();
        decompiler.toggleCCode(true);
        decompiler.toggleSyntaxTree(true);
        if (!decompiler.openProgram(currentProgram)) {
            throw new IllegalStateException("Could not open program in decompiler");
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(output))) {
            writer.write("/* Ghidra 命名反编译：" + currentProgram.getName() + " */\n");
            writer.write("/* 匹配数：" + matches.size() + " */\n\n");
            for (Function function : matches) {
                writer.write("/* ============================================================ */\n");
                writer.write("/* " + function.getName() + " @ " + function.getEntryPoint() + " */\n");
                DecompileResults result = decompiler.decompileFunction(function, 180, monitor);
                if (result.decompileCompleted()) {
                    writer.write(result.getDecompiledFunction().getC());
                } else {
                    writer.write("/* 失败：" + result.getErrorMessage() + " */\n");
                }
                writer.write("\n\n");
            }
        } finally {
            decompiler.dispose();
        }
        println("Wrote " + matches.size() + " functions to " + output.getAbsolutePath());
    }
}
