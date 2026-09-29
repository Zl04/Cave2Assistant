# `libmqm.so` 反汇编报告（阶段 1）

## 样本

- APK：`dk3.7.0-23.12.8.apk`
- 原生库：`lib/armeabi-v7a/libmqm.so`
- 架构：ARM 32-bit，主要代码为 Thumb-2
- ELF 动态/静态符号条目：1293
- 脚本：`assets/script.lc`

## JNI 执行入口

发现三个 `MQLanguageStub.Run` 重载：

| 地址 | 符号 | 作用 |
|---|---|---|
| `0x23D7D` | `Run(String,String,String,String,String,int,long)` | 多字符串参数封装入口 |
| `0x23F35` | `Run(byte[],String,String,int,int,long)` | 字节数组脚本入口，包含重复执行循环 |
| `0x240DD` | `Run(String,String,String,int,int,long)` | 文件路径脚本入口，包含重复执行循环 |

暂停、恢复、停止入口：

| 地址 | 符号 |
|---|---|
| `0x23245` | `MQLanguageStub_Pause` |
| `0x23281` | `MQLanguageStub_Resume` |
| `0x232BD` | `MQLanguageStub_Stop` |

## 文件路径版 `Run` 的执行结构

`0x240DC` 是 Java 当前调用签名对应的外层函数。它不直接解释字节码，而是根据重复次数调用单次执行函数 `0x23F94`：

```text
0x240F8  r4 = 0
0x240FC  跳转到循环条件

0x240FE  准备 duration/encryptKey 等栈参数
0x24116  BL 0x23F94       ; 单次执行
0x2411A  如果返回非 0，退出
0x2411C  r4++
0x2411E  判断 repeat 参数
0x24132  条件成立则继续
```

可读伪代码：

```c
int RunFile(JNIEnv *env, jobject self,
            jstring lcPath, jstring atcPath, jstring uiPath,
            int repeat, int duration, long encryptKey) {
    int result = 0;
    int index = 0;

    do {
        result = RunFileOnce(env, self, lcPath, atcPath, uiPath,
                             duration, encryptKey);
        if (result != 0) {
            break;
        }
        index++;
    } while (repeat <= 0 || index < repeat);

    return result;
}
```

`repeat <= 0` 在这里表现为持续循环，直到脚本返回错误、主动停止或外部状态使单次执行返回非零。

## 单次 JNI 执行：`0x23F94`

该函数做 JNI 与 C++ 参数桥接：

1. 使用 `CJavaToString` 将三个 `jstring` 转成 C++ 字符串；
2. 建立脚本执行器对象；
3. 从 Java 对象读取/写回 `m_RunnerPointer`；
4. 调用内部入口 `0x43C18`；
5. 释放 Java 字符串和临时 C++ 对象。

关键调用：

```text
0x23FB6  BL 0x231FE   ; CJavaToString(lcPath)
0x23FC0  BL 0x231FE   ; CJavaToString(atcPath)
0x23FCC  BL 0x231FE   ; CJavaToString(uiPath)
0x2405E  BL 0x43C18   ; 路径/流解析后的公共执行入口
```

## 时长转换入口：`0x43CFC`

这个函数非常短：

```asm
0x43CFC  PUSH    {r4,r5,lr}
0x43CFE  MOVS    r5,#60
0x43D00  LDR     r4,[sp,#0x14]
0x43D02  MULS    r4,r5,r4
0x43D04  STR     r4,[sp,#0x0C]
0x43D12  B.W     0x43C18
```

含义：将传入的分钟数乘以 60，转换成秒，然后尾调用公共执行入口 `0x43C18`。

## 公共执行入口：`0x43C18`

该函数负责把脚本路径或内存数据转换为统一输入流：

```text
0x43C32  构造输入/执行参数对象
0x43C42  比较输入头部的 12 字节
0x43C60  将输入流绑定到解析对象
0x43C68  检查流状态
0x43C96  BL 0x438C4       ; 进入核心执行器
0x43C9E  错误时返回 0x66
```

伪代码：

```c
int RunCommon(Runner *runner, Input input, Args args) {
    ParsedInput parsed;
    Stream stream(input);

    if (!ValidateHeaderOrStream(stream)) {
        return 0x66;
    }

    parsed.Attach(stream);
    return ExecuteScript(runner, parsed, args);  // 0x438C4
}
```

## 核心执行器：`0x438C4`

这是当前发现的核心函数，长度约 700 字节。执行阶段如下：

### 1. 初始化运行器

```text
0x438EC  构造临时容器 A
0x438F8  构造临时容器 B
0x43904  将运行器与容器关联
```

### 2. 加载脚本

```text
0x43916  BL 0x43548
0x43920  检查返回值
```

`0x43548` 是下一阶段最重要的目标：它接收脚本输入和加密键等参数，返回非零时整个执行过程立即进入错误清理。因此可将它暂命名为：

```text
LoadOrDecodeScript()
```

### 3. 建立内嵌运行时

随后函数保存脚本路径、附件路径和运行参数，并初始化一个 Lua 风格 VM。库中存在大量 `lua_*` 实现和 `LuaAuxLib.*` 命令映射，例如：

```text
LuaAuxLib.FindColor
LuaAuxLib.FindMultiColorEx
LuaAuxLib.FindPicture
LuaAuxLib.GetScreenData
LuaAuxLib.Ocr
LuaAuxLib.SmartOcr
LuaAuxLib.Tap
LuaAuxLib.TouchOperation
```

所以 `script.lc` 的执行模型可以确认是：

```text
专有 LC 输入 → 加载/翻译 → 内嵌 Lua VM → LuaAuxLib 原生能力
```

### 4. VM 执行与恢复循环

核心调用和循环：

```text
0x439D4  BL 0x66428      ; 初次 VM 调用
0x43A7E  准备恢复/事件参数
0x43A82  BL 0x42A32      ; 执行一轮事件或恢复脚本
0x43A9C  BL 0x66428      ; 再次 VM 调用
0x43B04  读取 VM 状态
0x43B0C  未完成则回到 0x43ADC
```

暂定伪代码：

```c
int ExecuteScript(Runner *runner, ParsedInput *input, Args args) {
    int status = LoadOrDecodeScript(runner, input, args);
    if (status != 0) {
        return status;
    }

    InitLuaRuntime(runner);
    RegisterLuaAuxLib(runner);
    SetScriptArguments(runner, args);

    status = StartVm(runner);

    while (VmHasPendingWork(runner)) {
        status = ResumeVmOrDispatchEvent(runner, status);
        if (status indicates fatal error) {
            break;
        }
    }

    DestroyVm(runner);
    return NormalizeStatus(status);
}
```

## 返回码

核心执行器明确使用 `0x65` 至 `0x6A` 一组内部返回码：

| 返回码 | 当前推定含义 |
|---|---|
| `0x65` | 运行器/VM 创建失败 |
| `0x66` | 输入流或脚本头校验失败 |
| `0x69` | VM 执行/恢复失败 |
| `0x6A` | 时长或外部限制终止 |

具体名称仍需结合 Java 回调枚举和 `0x41478` 的错误映射继续确认。

## 编译入口

`0x2352D` 为：

```text
Java_com_cyjh_mqm_MQLanguageStub_Compile
```

该函数会构造 `CMQMCompiler`，调用内部 `0x4B448` 编译脚本，并遍历：

```text
std::list<CMQMCompiler::SCompileError>
```

把编译错误逐条回传 Java。这个入口证明 APK 内置了完整或近完整的 MQ 脚本编译器组件，也为恢复 `script.lc` 格式提供了另一条路线：逆向编译器的输出函数通常比从 VM 执行循环反推操作码更容易。

## 与地图导航源码的关系

目前已经定位“脚本如何进入 VM”，但人物定位和地图坐标连接函数仍在 `script.lc` 内。下一阶段需要继续分析：

1. `0x43548`：LC 加载/解密/反序列化；
2. `0x4B448`：编译器主入口；
3. 编译器的文件写出函数，恢复 LC 文件布局；
4. 字符串表、函数表和指令区之间的偏移关系；
5. 为 `script.lc` 编写反汇编器，输出 `找角色`、`地图坐标连接` 等函数的操作码。

## 已生成的辅助工具

工作区中生成了一个基于 `pyelftools + Capstone` 的 ARM/Thumb 反汇编脚本：

```text
work/disasm_mqm.py
```

它支持按 ELF 符号或虚拟地址反汇编，并可查询目标地址附近的符号。
