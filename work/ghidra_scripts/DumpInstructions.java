// 从指定地址导出给定字节长度的指令。
// @category ReverseEngineering
import java.io.*; import ghidra.app.script.GhidraScript; import ghidra.program.model.address.Address; import ghidra.program.model.listing.Instruction;
public class DumpInstructions extends GhidraScript { public void run() throws Exception {String[] a=getScriptArgs();Address p=toAddr(a[1]);long n=Long.decode(a[2]);try(BufferedWriter w=new BufferedWriter(new FileWriter(a[0]))){Address end=p.add(n);while(p.compareTo(end)<0){Instruction i=getInstructionAt(p);if(i==null){disassemble(p);i=getInstructionAt(p);}if(i==null){p=p.add(4);continue;}w.write(i.getAddress()+"  "+i+"\n");p=i.getMaxAddress().add(1);}}}}
