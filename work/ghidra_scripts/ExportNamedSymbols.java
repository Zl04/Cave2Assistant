// 导出/反编译符号（包括尚未被识别为函数的标签）。
// @category ReverseEngineering
import java.io.*;
import ghidra.app.decompiler.*;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.Function;
import ghidra.program.model.symbol.*;

public class ExportNamedSymbols extends GhidraScript {
    @Override protected void run() throws Exception {
        String[] a=getScriptArgs();
        if(a.length<2) throw new IllegalArgumentException("output token...");
        DecompInterface d=new DecompInterface(); d.openProgram(currentProgram);
        File out=new File(a[0]); out.getParentFile().mkdirs();
        try(BufferedWriter w=new BufferedWriter(new FileWriter(out))) {
            SymbolIterator it=currentProgram.getSymbolTable().getAllSymbols(true);
            while(it.hasNext()) {
                Symbol s=it.next(); boolean match=false;
                for(int i=1;i<a.length;i++) if(s.getName(true).contains(a[i])) {match=true;break;}
                if(!match) continue;
                w.write("\n/* SYMBOL "+s.getName(true)+" @ "+s.getAddress()+" type="+s.getSymbolType()+" */\n");
                Function f=getFunctionAt(s.getAddress());
                if(f==null && s.getAddress().isMemoryAddress()) {
                    try { f=createFunction(s.getAddress(), s.getName()); } catch(Exception ignored) {}
                }
                if(f!=null) {
                    DecompileResults r=d.decompileFunction(f,180,monitor);
                    if(r.decompileCompleted()) w.write(r.getDecompiledFunction().getC());
                }
            }
        } finally {d.dispose();}
    }
}
