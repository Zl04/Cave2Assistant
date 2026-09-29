// 导出名称包含任意请求词的函数调用方。
// @category ReverseEngineering

import java.io.*;
import java.util.*;
import ghidra.app.decompiler.*;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.*;

public class ExportCallers extends GhidraScript {
    @Override protected void run() throws Exception {
        String[] args = getScriptArgs();
        if (args.length < 2) throw new IllegalArgumentException("output token...");
        Set<Function> targets = new LinkedHashSet<>(), callers = new LinkedHashSet<>();
        FunctionIterator it = currentProgram.getFunctionManager().getFunctions(true);
        while (it.hasNext()) {
            Function f = it.next();
            for (int i=1;i<args.length;i++) if (f.getName().contains(args[i])) { targets.add(f); break; }
        }
        for (Function target : targets) {
            ReferenceIterator refs = currentProgram.getReferenceManager().getReferencesTo(target.getEntryPoint());
            while (refs.hasNext()) {
                Function caller = getFunctionContaining(refs.next().getFromAddress());
                if (caller != null) callers.add(caller);
            }
        }
        DecompInterface d = new DecompInterface(); d.openProgram(currentProgram);
        File out = new File(args[0]); out.getParentFile().mkdirs();
        try (BufferedWriter w = new BufferedWriter(new FileWriter(out))) {
            w.write("/* 目标数："+targets.size()+"，调用方数："+callers.size()+" */\n");
            for (Function f: callers) {
                w.write("\n/* === "+f.getName()+" @ "+f.getEntryPoint()+" === */\n");
                DecompileResults r=d.decompileFunction(f,180,monitor);
                w.write(r.decompileCompleted()?r.getDecompiledFunction().getC():"/* 失败 */\n");
            }
        } finally { d.dispose(); }
        println("Wrote callers to "+out);
    }
}
