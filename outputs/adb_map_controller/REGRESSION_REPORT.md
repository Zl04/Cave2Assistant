> 历史审计快照：本文基于用户授权全面重构之前的工作区。本轮生产源码已发生后续变化；当前迁移、修复和验证结论见 [FULL_REFACTOR_REPORT.md](FULL_REFACTOR_REPORT.md)。本文的旧源码路径、风险和测试数量保留作为历史证据。

# 回归与工程验收报告

日期：2026-10-09（Asia/Shanghai）。对象：HEAD `1805700b623a505675d5635f5b9be36cc1dfa0e5` 加当前工作区，Windows/.NET SDK8.0.401，生产目标net8.0-windows/win-x64。结论：本次工程及已有测试通过；完整设备验收与共享帧生命周期不能判通过。

## 1. 执行边界与实际命令

只读Get-CimInstance检查项目路径下的进程，未发现项目实例，没有Stop-Process。检查Verify-RefactorBaseline.ps1发现它在默认/CoreOnly路径也先调用Stop-ProjectApplication，-Publish还会覆盖标准发布根。因此按本次限制暂停该脚本，**没有执行它的任何模式**。未运行dotnet publish、未启动控制器、未连接真实ADB设备、未发送真实触摸、未安装助手或修改设备文件。

本次直接执行以下命令（项目根下）；输出与中间产物由Directory.Build.props置于各自publish/.build，TRX置于publish/.audit-results。没有把任何Build副本交付到标准发布根。

```powershell
dotnet build AdbMapController.csproj -c Release --nologo
dotnet test tests/AdbMapController.Tests.csproj -c Release --nologo --logger 'trx;LogFileName=main.trx' --results-directory publish/.audit-results
dotnet test tests/baseline/AdbMapController.Baseline.Tests.csproj -c Release --nologo --logger 'trx;LogFileName=baseline.trx' --results-directory publish/.audit-results
```

FakeADB用tests/FakeAdb生成的adb.exe，测试将其所在输出目录放到PATH首位，使用fixture serial、临时远端文件树及transcript；生成/复制假adb已检查成功。TouchControllerFault使用DispatchProxy注入backend，仅记录方法调用。ShutdownResource用STA同步上下文、临时路径和内存设置，反射注入任务。Web测试仅用受控127.0.0.1目录/端口。它们不操作真实设备。

## 2. 本次实测结果

| 项目 | 发现/执行 | 通过 | 失败 | 跳过/未执行 | 结果/限制 |
| --- | ---: | ---: | ---: | ---: | --- |
| Release生产构建 | 不适用 | 成功 | 0错误 | 不适用 | 0警告、0错误；构建exit0，不发布 |
| 主工程Release | 165/165 | 165 | 0 | 0/0 | exit0，TRX total/executed/passed=165，error/timeout/aborted=0；测试时间约47s |
| 独立Baseline Release | 51/51 | 51 | 0 | 0/0 | exit0，约218ms；source-linked子集，不代表完整生产程序集 |
| 定向审计实验 | 4个观察场景 | 不作为suite计数 | 见下文2个cache问题 | 无 | 对真实生产类型离线调度，第三场景确认文本识别缺口、第四确认守卫漏洞；不是“4个测试全绿” |
| Debug | 未运行 | — | — | — | 本次未重复执行；历史记录不能写成本次通过 |
| 验证脚本/发布 | 未运行 | — | — | — | 脚本副作用不允许，未停用户程序/覆盖发布根 |
| 真实设备 | 未运行 | — | — | — | 本次明确禁用，不把缺口当跳过测试来计数 |

主工程ProjectReference为`..\AdbMapController.csproj`，FakeAdb ProjectReference的ReferenceOutputAssembly=false；五份baseline手写测试只引用到测试工程，生产源代码没有重复Compile。独立工程直接链接Domain/Navigation及选定Application/Configuration/Pipeline源码，它的internal可见性和资源范围不同。主工程165与Baseline51重叠较多，不能相加称216项独立业务保障。

### 主测试分类（由本次TRX分组）

| 分类 | 用例数 | 证据类型/边界 |
| --- | ---: | --- |
| CardFloorPolicyTests | 5 | 纯规则，含原初试炼当前上限 |
| DiagnosticsTests | 3 | 容量/节流/sink异常、设置诊断 |
| DomainBoundaryTests | 20 | BCL独立编译、3种禁止引用负例、图标/12种传送模式 |
| DungeonSessionTests | 1 | 会话清理 |
| FakeAdbCompatibilityTests | 23 | 假进程、真实facade、JSON/screenshot/assistant及少量native/watchdog |
| OperationLifecycleTests | 4 | STA多任务、失败/取消/finally/快照边界 |
| OperationTrackerTests | 1 | 操作注册/等待 |
| PipelineBaselineTests | 12 | MAA/Task/UI不同超时、取消、分支等表征 |
| PipelineContractTests | 26 | compiler/字段/继承、生产资源、入口离线handler分支 |
| PortalLearningBaselineTests | 5 | 内存地图/落点/图学习；非真实门户 |
| RouteExecutorTests | 2 | 路线端口fake |
| RouteSafetyBaselineTests | 8 | 过期路线、取消/输入/状态表征 |
| SettingsFailureBaselineTests | 3 | 缺失/损坏/失败兼容 |
| SettingsStoreTests | 2 | 配置roundtrip/default |
| ShutdownResourceTests | 4 | cache迟到Dispose、runtime幂等、MainForm正常/故障两owner等待 |
| StateAndJsonBaselineTests | 19 | FSM、Reset/Stop、JSON/快照/interrupt等 |
| TouchControllerFaultTests | 5 | 方法顺序和故障语义，非真实backend字节/Android接触 |
| VisualFrameReplayTests | 15 | 图像回放+手工文本边界+native OCR有效框 |
| WebBoundaryTests | 7 | 实际本机HTTP/path/Dispose |
| **合计** | **165** | 各专项包含于主测试全量，未额外筛选重跑 |

独立51例=原Session/Tracker/Route4例+五份baseline目前47例；原来52少掉LootConfirm理论1例。该删例与当前枚举/废弃API删除一致，不归因于测试发现故障；当前不是遗漏/跳过。

## 3. Fixture、Golden、资源及trace核验

- baseline/Fixtures的maa-semantics.json、tolerant-tile.json被映射到测试输出；本次运行黄金分支和容错字段预期成功。
- 主测试复制当前3份Resources/Automation JSON、Assistant/MiniMapDrawer.template.lua、Domain/*.cs、VisualFixtures图片。生产catalog/字段、节点优先级、timeout及离线动作次序通过；真实handler/设备动作不可由fake handler证明。
- FakeADB transcript核验当前argv/serial含空格、root/su、root marker、JSON重试20次与0.005s命令、EOF/非零错误；LegacyFacadeAndCandidateTransportUseEquivalentRootMarkerInput对当前facade委托与transport做对比，但并未执行独立历史7f版本。测试名含Legacy/Candidate不自动成为跨版本golden。
- 屏幕空流/坏PNG/非零/5s超时，clone独立、同帧共享、waiter独立取消/Disconnect清缓存/迟到Dispose已有用例通过，仍未覆盖本次发现的完成→淘汰→旧waiter窗口。
- 所有8张VisualFixtures PNG实测SHA256与README记录一致。6张用户1004×565弹窗图、1张1920×1080正常游戏负图有既有回放；server-idle-disconnect.png保存但未作为识别正例测试。用户原始设备分辨率/frameId未知，不推断。
- UserSuppliedPopupFrames...的大量文本断言是手工传入注释文字，不能写成“native OCR读取六图全部正确”。BundledPaddleOcrNativeRuntime...证明一图返回有效框，Fake watchdog另有greedy回城样本native链路；不表示整体准确率。
- 资源配置加载已验证上述范围及测试使用的native依赖，不包含完整最终发布目录所有themes/icons/TouchAgents/模板组合，也未启动发布程序。
- 读取了存量publish/pipeline-traces：dungeon-entry-140bbacd...53事件与d0736960...81事件结束于Kind10/WaitForMapLoad；e02ea180...69事件为Kind11入口候选未命中；部分旧记录完成于OpenMapButton，另有取消/失败；map-run记录均8事件到RunDungeon完成。这些可证明历史handler报告的分支，缺源码/设备指纹和逐步输入，不构成本次新旧业务golden；RunLoop内部吞错意味着map-run“完成”不能证明游戏过程成功。未改动/删除用户trace或日志。

没有统一的新旧设备输入输出录制可用于完整差分。本次可对照的是当前自动化golden、Git源码及RouteSession归位全文一致，不能宣称重构前后所有行为相同。

## 4. 定向实验：已有绿测试的遗漏

临时可执行审计Harness只加载当前构建程序集，通过反射实例化internal ScreenFrameCache、调用生产静态文本规则。代码、输出和中间产物只在项目publish内生成，已转录证据；删除操作被自动审批拒绝，暂时保留；没有永久修改已有测试。运行exit0只表示观察程序完成，不表示被观察行为正确。

### E01 完成后清缓存、等待者尚未克隆

确定性顺序：安装自定义SynchronizationContext，其Post入队不自动执行；GetAsync(1,capture)等待未完成TaskCompletionSource<Bitmap>；完成capture并只泵一次回调，执行CaptureAndPublish；等待者continuation仍在队列；调用Clear释放cached；再泵等待者。

实测输出：

```text
clear-before-clone: System.ArgumentException: Parameter is not valid.
```

ScreenFrameCache.cs:89～90等待结果后CloneImage；Clear/淘汰的Dispose与clone之间没有有效lease。imageGate仅序列化执行，无法使已Dispose的Image重新可用。真实影响频率未测，不能说设备一定触发，但本地生产类型的异常已稳定复现。HEAD同实现，属遗留。

### E02 捕获期间Clear后仍发布旧结果

GetAsync(2,capture)在途→Clear→完成capture→await clone→再次GetAsync(2,同capture)。计数委托仅被调用1次：

```text
clear-during-capture: captures=1 (pre-clear capture republished)
```

Clear没有generation或active失效机制，缓存被先前工作重新填充。它不一定导致实际旧设备画面被消费（生产通常为新frameId），但“Clear后旧会话工作绝不进入新缓存”的隔离契约目前不存在。

### E03 闲置断线文案

反射调用生产AdbScreenAnalyzer.IsServerErrorText(`闲置时间过长,已和服务器断开连接.`)，无native推理/设备：

```text
idle-disconnect-text: False
```

这与README记录一致。由于视觉green候选之外还要求该文本规则，即使OCR完全准确也不会命中此类文案。后续应先明确是否支持该弹窗变体，再做完整图片/native/UI Pipeline/watchdog验收。

### E04 Domain守卫的System.*筛选放行WinForms

主测试runtimeconfig引用Microsoft.WindowsDesktop.App。使用与DomainBoundaryTests.cs:19～23相同的TRUSTED_PLATFORM_ASSEMBLIES筛选（System.*加System/mscorlib/netstandard），编译 `public class Forbidden { public System.Windows.Forms.Form Value; }`，实测输出：

```text
domain-reference-filter-accepts-WinForms: errors=0
```

该探针只用同参考集合编译负例，并未写入Domain或改变现有测试；当前Domain源码没有Form依赖。问题是架构测试的约束范围，不能将“MainForm负例失败”扩大为“所有Presentation/WinForms依赖被禁止”。详见V2-06。

### E01/E02可复现核心代码

下列`type`由`typeof(AdbClient).Assembly.GetType("AdbMapController.ScreenFrameCache", true)`获得，构造`Activator.CreateInstance(type,true)`；Bitmap在clone返回后using释放，最后Dispose cache。

```csharp
sealed class QueuedContext : SynchronizationContext
{
    public readonly BlockingCollection<(SendOrPostCallback, object)> Queue = new();
    public override void Post(SendOrPostCallback callback, object state)
        => Queue.Add((callback, state));
    public void PumpOne()
    {
        if (!Queue.TryTake(out var item, 5000)) throw new TimeoutException();
        item.Item1(item.Item2);
    }
}
// E01
var context = new QueuedContext();
SynchronizationContext.SetSynchronizationContext(context);
var source = new TaskCompletionSource<Bitmap>(TaskCreationOptions.RunContinuationsAsynchronously);
Func<CancellationToken, Task<Bitmap>> capture = _ => source.Task;
var waiter = (Task<Bitmap>)type.GetMethod("GetAsync")!.Invoke(
    cache, new object[] { 1L, capture, CancellationToken.None })!;
source.SetResult(new Bitmap(2, 2));
context.PumpOne();
type.GetMethod("Clear")!.Invoke(cache, null);
context.PumpOne();
// waiter.GetAwaiter().GetResult() => ArgumentException
SynchronizationContext.SetSynchronizationContext(null);
// E02: 对新cache开始GetAsync(2)，在完成source前Clear；完成并await；
// 再GetAsync(2)。capture中Interlocked.Increment计数，实测总计1。
```

## 5. 13项业务兼容性矩阵

“自动已验证”仅限列出的行为，不把整项功能判通过。“模拟”包含假ADB进程/内存状态/方法代理。“历史设备记录”指已有文档/trace，不代表本次独立重跑；文档转述的用户反馈单列其限制。

| 业务项 | 本次自动化已验证 | 模拟设备/端口已验证 | 真实设备证据 | 尚未验证/限制 |
| --- | --- | --- | --- | --- |
| 1 ADB连接/断开/重连 | root/su、serial、错误和玩家读取、Disconnect/cache路径 | Fake argv/持久shell/截图 | 历史LDPlayer root同serial恢复/Disconnect前后ReadPlayer | 完整Connect后backend探测、长按掉线/恢复，当前版本独立设备重验未做 |
| 2 序列号切换 | facade serial含空格及A→B→A shell重建 | Fake多serial读取 | 无独立跨真实设备记录 | 两设备触摸held/session/在途截图隔离，E02风险 |
| 3 Root shell执行退出 | marker文本、root/su、EOF/非零 | Fake shell进程 | 历史shell uid0/同serial | 部分marker/连续输出总超时/kill全部矩阵、真实失权限 |
| 4 down/up/急停 | 方法配对、转向、失败held、排队、pulse故障 | DispatchProxy backend，不是字节 | 文档转述用户触摸/实际使用正常 | Android收到up、partial write、长pulse急停延迟与up失败恢复 |
| 5 路线/停滞/重规划 | 过期起点、取消释放、部分状态/路线结果 | IPlayerStatusSource/IMovementInput fake | 用户跑图正常反馈 | stall/负lead/横跳/portal/boundary异常完整序列和输入时间线 |
| 6 地图/人物JSON | 容错golden、缺文件/20重试、player合并 | 假JSON/root命令 | 历史真实ReadPlayer | 生产ReadMap所有结构/坏坐标/跨层组合、新旧动态输出差分 |
| 7 弹窗抢占/动作取消 | greedy idle/slice回调、disabled不启动ADB、interrupt winner | 假截图+真实native/UI Pipeline | 用户抢占正常反馈 | 所有server/gem变体、release失败/owner取消、E01/E03，M03时线 |
| 8 战斗等待 | 部分地图/状态纯逻辑；没有完整用例测试 | 未完成战斗事件回放 | 泛化跑图反馈不能证明专门M05 | release保路线、战胜/逃跑/旧map恢复完整用例 |
| 9 门学习 | 5例观察/key/邻近落点等 | 合成MapDump序列 | 无独立M06记录 | 固定/随机多边、解锁/防回跳整链实际证据 |
| 10 楼层转场恢复 | FSM合法/非法/same/Set、session清理 | 状态对象fixture | 泛化跑图反馈不等专门M04 | gem停钟、8s恢复、服务器延迟/新层等待/停层事件 |
| 11 自动进图Pipeline | 真实配置离线分支、optional确认/map-switch predicate | 假handler，不是生产整个入口 | 用户反馈及历史WaitForMapLoad完成trace | 当前新增行为的多地图/超时/取消/设备版本可比较对照 |
| 12 OCR/视觉 | native有效框、6图视觉/文本和负图、greedy真实OCR链 | 图片回放，无设备 | 历史真实内存截图1920×1080 | 整体OCR准确率/server正例/近似负例/多分辨率动画；idle未支持 |
| 13 释放与关闭 | STA正常/故障两owner等待、runtime幂等、迟到cacheDispose | 人工任务/bitmap + 生产ShutdownAsync | 旧审计文档有启动/正常关闭转述 | 活动native/真实触摸/agent/截图并发、句柄/Bitmap/Task泄漏定量证据 |

本次真实设备测试全部未执行。历史根设备操作/助手往返有明确范围；用户正常使用反馈是有效补充，但没有严谨源码指纹/故障场景/时间线，不能把表中未验证列自动勾选通过。

## 6. G0～G6准入完成矩阵

| 门槛 | 自动化/工程证据 | 设备/完整交接证据 | 判定 | 后续验收条件 |
| --- | --- | --- | --- | --- |
| G0生产/资源交付 | Release0/0；165/51；实际资源/native部分加载 | 历史发布记载，当前未发布/启动 | 部分满足 | 本次工程绿色；正式交付前另行授权标准publish/native部署核验 |
| G1ADB/root/助手 | Fake argv/root/marker/EOF/错误/助手往返 | 历史LDPlayer部分，非完整M01 | 有条件满足 | 长按断线/真实跨serial/root权限变化、故障矩阵与版本指纹 |
| G2touch/急停 | 方法代理5例+路线fake | 用户使用反馈；无byte/物理时间线 | 未闭环 | M02 partial写/up失败/pulse急停，同backend完整字节与延迟 |
| G3watchdog/战斗/刷新 | greedy native锁存/disabled、interrupt，其他部分 | 用户反馈；无统一M03/M05事件记录 | 未闭环 | server/gem/slice/idle、battle/refreshfalse以及owner取消时线 |
| G4floor/portal | FSM/Session/门学习纯测试 | 无专门M04/M06独立记录 | 未闭环 | 转场/gem/超时恢复、多边门学习、停层全过程 |
| G5Pipeline/视觉/native | 契约26/基线12、资源、native图回放 | 历史截图/入口使用反馈；发布组合未重验 | 部分满足 | 完整正负样本、动作耗时/取消与M07；修V2-01及确认V2-02范围 |
| G6取消/关闭 | trackerSTA4/Shutdown4，WhenAll故障等待已测 | 无活动native/agent资源M08记录 | 未闭环 | 关闭时native/截图/触摸在途，重复close/fault，资源前后基线 |

未闭环的门槛阻止对应高风险owner/时序改造，不要求当前为清单完成而迁移。旧“用户接受缺口”只支持有条件阶段结论，不等于G全部通过。

## 7. M01～M08设备回归完成矩阵

| ID | 已有证据 | 本次设备执行 | 完成状态 | 仍需观察 |
| --- | --- | --- | --- | --- |
| M01断线/重连/切设备 | 历史root启用后同serial、ReadPlayer；Fake切serial | 未执行 | 部分历史验证 | 长按掉线、另设备、旧backend/root/hold隔离 |
| M02触摸/急停 | Touch方法代理和用户正常使用反馈 | 未执行 | 部分；专项未验证 | 实际bytes/down-up、负lead、pulse急停延迟、发送失败 |
| M03模态抢占 | greedy native/watchdog，用户反馈 | 未执行 | 部分；专项未验证 | 全部模态样式、idle/slice、实际release；闲置断线变体 |
| M04楼层/奖励/恢复 | FSM纯测试、泛化跑图反馈 | 未执行 | 尚未专项验证 | 8s恢复、gem停钟、新层delay、停层/失败 |
| M05战斗/旧路线 | 过期路线fake、泛化跑图反馈 | 未执行 | 尚未专项验证 | 先release保路线、胜利/逃跑、读取失败、权威坐标恢复 |
| M06门户学习 | 合成MapDump 5例 | 未执行 | 尚未设备验证 | 随机多边、邻近/无法确认落点、unlock、防回跳 |
| M07入口/Pipeline耗时 | contract/native离线；存量入口成功/失败trace | 未执行 | 部分历史验证 | 源码指纹、候选无匹配/动作卡顿/取消无残余设备动作 |
| M08关闭 | STA生产Shutdown正常/移动失败等待；历史正常关闭转述 | 未执行 | 部分；活动资源未验证 | 并发刷新/跑图/入口/watchdog/native，句柄/Bitmap/agent泄漏 |

后续执行必须另行获得设备操作授权，并记录serial、Android/API、root方式、touch backend、屏幕/旋转、游戏/助手/pipeline/model/template hash、源码身份、输入序列、时间线、资源前后计数。不能只写“跑图正常”。本次不发起设备操作。

## 8. 审计身份与清理

源码身份清单：从仓库根用rg列出本项目*.cs/*.csproj/*.props/*.ps1，排除所有publish；包含tests/FakeAdb；按路径排序、路径反斜杠改斜杠，每行`path SHA256`，以LF连接再UTF8计算SHA256：

`BA0BC3CB87041FD0D3403CAEDD24248809950AA31AD5FFC253FF1830D831A30E`

| 关键文件 | SHA256 |
| --- | --- |
| Infrastructure/Adb/AdbClient.cs | B23F7B3DBFA1914343FB012BF39600671D8CF20CBB8352B2A33B3C0CAAB6798D |
| Infrastructure/Automation/ScreenFrameCache.cs | D72E357EB247E36D8F0AD780175512A6295D96CA0444D435F3A4CF79A8FFC773 |
| Presentation/MainForm.Movement.cs | 4FAED647E196BD403372186972F8D5481777E8C05B2966DA122957BDDAAD0E74 |
| tests/AdbMapController.Tests.csproj | 8FD7D9F6D1C8F2196A68DCC5C860BF42B7AEC116A4134E3E2F6F664E3A9BCDA7 |

该指纹不涵盖所有资源/native库，不能用它取代模型/pipeline/设备指纹。当前源码清单结束时复核不变。RouteSession与HEAD旧Domain文件归一CR/LF后全文一致。

本次构建产物路径为`publish/.build/AdbMapController/bin/Release/net8.0-windows/win-x64/洞窟地图控制器.dll`，仅用于测试；清理被工具策略拒绝，当前仍保留；没有新的可执行交付。标准`publish/洞窟地图控制器.exe`是既有程序，本次未发布更新，不能作为本次编译交付结果。

本次已转录结果，并检查六个清理目标的绝对路径均在精确项目publish范围内、不是重解析链接。递归清理先以校验后的路径、再以明确字面量路径尝试，均被自动审批拒绝，返回“blocked by policy”，没有更具体的原因；未改用其他API绕过。当前publish/.audit-harness、publish/.audit-results及生产/tests/baseline/FakeAdb各自publish/.build仍保留，须后续在允许清理的环境删除。未删除publish根、用户日志/trace/config、VisualFixtures或共享native缓存。永久交付为四份审计文档；额外目录仅是本次临时实验/构建/TRX，不能当成发布程序。



末次只读进程复查发现既有标准发布程序正在运行（PID 88044）。本次没有启动或停止它；初始构建前检查未发现实例，二者是不同时间点。没有对该进程进行设备或业务操作。


## 全面重构后的最终验证（2026-10-09）

- Release 构建：通过，0 warning / 0 error；输出位于 `publish\.build\AdbMapController\bin\Release\net8.0-windows\win-x64\洞窟地图控制器.dll`。本轮未执行 Publish，因此没有覆盖标准交付根目录。
- 主测试工程：196/196 通过，0 failed，0 skipped；TRX：`tests\publish\test-results\refactor-final-full.trx`。
- 独立 Baseline：51/51 通过，0 failed，0 skipped；TRX：`tests\baseline\publish\test-results\refactor-final-baseline.trx`。
- 架构、资源、操作、视觉专项：14/14 通过；TRX：`tests\publish\test-results\refactor-final-boundaries.trx`。
- 视觉与架构专项：48/48 通过；TRX：`tests\publish\test-results\refactor-vision-architecture.trx`。
- 未运行真实设备、未安装助手、未发送设备触摸、未修改设备文件；未使用会自动 Force Stop 的验证脚本。

## 最终准入矩阵

| 条件 | 结果 | 证据/限制 |
| --- | --- | --- |
| G0 Release 编译 | 通过 | 0 警告、0 错误 |
| G1 主测试 | 通过 | 196/196 |
| G2 Baseline | 通过 | 51/51，来源链接真实生产源 |
| G3 架构边界 | 通过 | Domain/Application/Navigation 负例守卫、资源所有权专项 |
| G4 Pipeline/配置/资源 | 通过 | 主测试与 Baseline；Pipeline 定义和运行状态分离 |
| G5 native 视觉回放 | 有条件通过 | Idle disconnect 实际 OCR 回放通过；未覆盖设备动画、多分辨率和真机链路 |
| G6 真实设备回归 | 未验证 | 需要 M01～M08 受控设备记录 |

M01～M08 均保持“尚未验证”，因为本轮没有自动连接、触摸或修改设备。编译、Fake ADB、native 截图回放不替代设备证据。
