// 导出引用指定数据符号的函数。
// @category ReverseEngineering
import java.io.*; import java.util.*;
import ghidra.app.decompiler.*; import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.*; import ghidra.program.model.symbol.*;
public class ExportDataReferences extends GhidraScript {
 public void run() throws Exception {
  String[] a=getScriptArgs(); Set<Function> fs=new LinkedHashSet<>();
  SymbolIterator si=currentProgram.getSymbolTable().getAllSymbols(true);
  while(si.hasNext()){Symbol s=si.next(); boolean m=false; for(int i=1;i<a.length;i++)if(s.getName(true).contains(a[i]))m=true;
   if(!m)continue; ReferenceIterator ri=currentProgram.getReferenceManager().getReferencesTo(s.getAddress());
   while(ri.hasNext()){Function f=getFunctionContaining(ri.next().getFromAddress());if(f!=null)fs.add(f);}}
  DecompInterface d=new DecompInterface();d.openProgram(currentProgram);File o=new File(a[0]);o.getParentFile().mkdirs();
  try(BufferedWriter w=new BufferedWriter(new FileWriter(o))){for(Function f:fs){w.write("\n/* === "+f.getName()+" @ "+f.getEntryPoint()+" === */\n");DecompileResults r=d.decompileFunction(f,180,monitor);if(r.decompileCompleted())w.write(r.getDecompiledFunction().getC());}}
  finally{d.dispose();} println("functions="+fs.size());
 }
}
