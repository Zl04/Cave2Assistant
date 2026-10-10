> 历史审计快照：本文基于用户授权全面重构之前的工作区。本轮生产源码已发生后续变化；当前迁移、修复和验证结论见 [FULL_REFACTOR_REPORT.md](FULL_REFACTOR_REPORT.md)。本文的旧源码路径、风险和测试数量保留作为历史证据。

# 第二轮技术债务评估

日期：2026-10-09。对象：当前源码及本次Release165/51自动化验证。总评B有条件通过。不自动开始第二轮重构或生产修复；建议停止大范围结构改造，针对已复现缺陷和高风险验收缺口安排小范围后续工作。

分类中的“已解决”限原问题范围，“有意保留”不等于理想设计；“新发现”不等于“重构中新引入”。严重度：高=可能影响设备输入/关键结果或生命周期，中=可靠性/维护验证成本，低=局部可读性/有边界约束的债务。未复现的风险明确按风险记录。

## 1. 原TD-01～TD-18重新核验

| ID | 当前分类 | 风险 | 当前源码/测试证据 | 根因、维护成本与是否继续 |
| --- | --- | --- | --- | --- |
| TD-01 Domain反向引用 | 已解决 | 低（防回退） | Navigation/RouteSession.cs；Domain/PortalProtocol.cs；MapIconCatalog.cs:192；DomainBoundary20例 | 路线owner归位、分类码中性拥有；保持守卫即可，不再新建Contracts程序集 |
| TD-02 MainForm编排过重 | 部分解决 | 中高 | MainForm.Automation.cs:190～514、Planning.cs、DeviceMap.cs:190；Runtime/Session/Executor已提取 | 控件值、flags、用例/CTS仍共上下文，改楼层规则需跨模块理解；RU-12未实施。先trace再按真实需求迁一个完整用例，当前不全面搬RunLoop |
| TD-03 AdbClient聚合/迁移中断 | 已解决（结构范围） | 中（异步边界） | AdbClient.cs:15～50,268～275及6协作者；Release/FakeADB通过 | 旧root/capture/助手实现移除，JSON/视觉/触摸会话也迁出；无需为门面转发继续拆分。生命周期细节归V2-01/TD-12 |
| TD-04 多Pipeline | 部分解决；并存有意保留 | 低中 | MAA主入口，Task handler adapter，UiPipeline单帧；PipelineContract26/Baseline12 | 原“必须合并”建议不再需要处理；文档/保障已增强。MAA候选timeout、Task协作节点timeout、UI识别fallback不同，不合并 |
| TD-05 设备E2E缺失 | 部分解决 | 高（验证缺口） | FakeADB23、Touch5、Shutdown4、视觉15；REGRESSION_REPORT G/M矩阵 | 离线大幅增补，历史设备/用户记录存在，但异常矩阵和版本指纹不完整。补证据收益最高，不要求设备农场 |
| TD-06 散落协议/时间 | 部分解决 | 中 | AdbGameDataReader.cs:15～19、GameScreenCoordinates、MovementTuning；RouteExecutor.cs:87,144 | 局部命名和已有映射边界足够；其余数字按维护需求命名。暂不全配置化、不调时序，不引入泛用TimingProfile |
| TD-07 容错坏字段/诊断 | 部分解决；容错有意保留 | 中高 | Models.cs:18～27及converter；DeviceMap.cs:196；NonCriticalDiagnostics.cs | 语法错误重试后抛错；字段默认值是兼容策略。旁路可见但上游静态queue仍无界/跨来源，见V2-05。改为强制停止需协议决策 |
| TD-08 非法楼层转换仍应用 | 有意保留 | 中 | FloorStateMachine.cs:18～26；StateAndJsonBaselineTests | 明确Transition诊断后应用、Set直接设置；不能把业务恢复强改拒绝。无界diagnostic另见V2-05；先记录实际转场序列 |
| TD-09 root shell文本拼接 | 有意保留 | 中 | AdbCommandTransport.cs:70～85；AssistantController.cs:91～134；reader原子命令 | 宿主ArgumentList正确，远端路径来自常量/find；find返回含引号路径可能错误。未证明不可信用户输入漏洞。未来动态路径扩展时补转义/边界，不全面重写marker |
| TD-10 OperationTracker无锁 | 有意保留 | 低 | OperationTracker.cs:9～23；MainForm.RunUi/UI事件；OperationLifecycle4 | UI上下文串行访问未见真实跨线程调用；WhenIdle是快照。新增后台用途前需显式契约，当前不盲换Concurrent集合 |
| TD-11 设置失败静默 | 已解决（观测入口） | 低中 | SettingsStore可选sink/Report、Program接线；Diagnostics3+Settings5+Web7 | 首缺文件仍静默、损坏/保存失败有有限旁路；不是可靠持久日志。无需为了失败诊断改变控制结果 |
| TD-12 截图/OCR共享资源 | 部分解决 | 中高 | capture单owner，cache共享原帧，OCR gate；定向实验V2-01 | 无“双重同资源缓存”；仍有等待者与原帧释放缺陷。先局部修所有权，不建万能probe队列；native关闭补M08 |
| TD-13 缺视觉回放 | 部分解决 | 中 | VisualFrameReplay15、8张PNG及README hash；Fake贪婪native回放 | 有效覆盖有限类别；idle断线样本不匹配规则，server正例/动画/近似负例缺。Loot废弃后不再需要补Loot样本 |
| TD-14 门学习不持久化 | 有意保留 | 低 | PortalRouting.cs两图；DungeonSession.cs Reset/Stop清图；PortalLearning5 | 门由服务器决定，key无副本实例ID；跨运行缓存可能复用错误边。保持内存，不作为必修债务 |
| TD-15 JSON无schemaVersion | 未解决（有意暂缓协议） | 中 | Models.cs MapDump/PlayerStatus、AdbGameDataReader；MapSnapshot是本地元数据 | 旧助手兼容使强制字段有风险；先本地记录游戏/助手/模型指纹，再另立版本协议需求；不因重构加停止条件 |
| TD-16 Web回环/认证 | 不再需要处理原“缺回环约束”问题 | 低 | Web显式127.0.0.1、GET/path校验；Web7实际HTTP | 原风险被过度推断。边界已验证；局域网部署未支持，无需现在加认证工程 |
| TD-17 大文件/复杂函数 | 有意保留 | 低（RunLoop另归TD-02） | Planner.cs图搜索、MaaPipeline compiler/runtime、VisualTemplate、ThemePalette | 深算法/控件族本身较复杂，拆小文件常增跳转。仅业务变化原因明确才拆，不按行数排任务 |
| TD-18 单程序集/目录约束 | 部分解决；单程序集有意保留 | 中 | DomainBoundary BCL编译/负例；csproj单WinForms程序集 | Domain有隔离编译守卫但System.*筛选放行WinForms（V2-06），其余目录边界仍评审约束；Domain新增子目录要更新fixture包含。不立即多程序集扩大native发布风险 |

## 2. 真正值得后续处理的问题

### V2-01：共享帧等待者未拥有可用Bitmap生命周期

- **类型/严重度：** 已复现实现缺陷，中高；当前与HEAD的ScreenFrameCache实现相同，属于重构前已存在的残留问题，不是RU-15新引入。
- **影响范围：** 并发同/异FrameId等待者、Clear/Disconnect、缓存淘汰及Dispose；可导致弹窗探测异常或旧会话帧重新成为缓存。当前UI通常串行使用能降低发生率，未在真实设备复现。
- **源码证据：** ScreenFrameCache.cs:89～90 await后直接CloneImage；:112～126替换cached并Dispose旧帧后完成Task；:138～147 Clear只释放cached，未失效active；AdbClient.cs:73～77 Disconnect触发Clear。
- **本次复现：** 受控SynchronizationContext让capture先发布、等待者续体暂不执行，Clear后续体克隆即`System.ArgumentException: Parameter is not valid.`；在途capture先Clear再完成，第二次同FrameId请求捕获计数仍1，证明Clear前工作重入缓存。完整过程见REGRESSION_REPORT（临时实验目录清理被工具策略拒绝，暂时保留）。
- **根因：** imageGate只保护同一时刻读/释放，不能保证“对象已释放后才开始克隆”的有效性；Task结果与cache的所有权寿命相同，等待者没有lease；Clear缺session generation。
- **建议：** 小范围建立等待者独立clone/lease生命周期及失效代次。明确Clear对现有等待者应返回旧clone、取消还是显式失效；旧代捕获不得发布到新代cache；保留单waiter取消不影响其他人的契约。不新增全局设备调度器。
- **收益/风险：** 修正已复现异常和设备切换帧隔离；风险为重复捕获、内存clone增长、取消/Dispose语义变化。
- **测试前置：** completion→Clear→clone、异帧淘汰前旧waiter恢复、Clear期间在途capture、切serial的迟到帧、共享waiter取消与最终Bitmap释放；必须使用确定调度，不能靠循环碰运气。真实M03/M08验证在另行授权后进行。
- **是否值得：** 是，最高优先小修；当前审计不实施。

### V2-02：现有闲置断线样本不在ServerError识别范围

- **类型/严重度：** 重新确认已有识别缺口，中；非新引入回归。是否所有断线样式必须抢占，尚无明确产品契约。
- **影响范围：** ServerError watchdog在该模态框下不能按此节点锁存；设备输入/RunLoop实际后果未验证，不能声称已发生错误点击。
- **源码证据：** AdbScreenAnalyzer.cs:106～136先要求green button候选，再匹配“服务器连接异常”或“连接异常+重新进入游戏”。tests/VisualFixtures/server-idle-disconnect.png与README为橙/红按钮，“闲置时间过长,已和服务器断开连接.”；即使OCR准确文本仍不匹配。
- **实测：** 对生产静态IsServerErrorText输入该精确文案，返回False（无OCR、无设备）。样本SHA256 `78559493F69080D89EF759A1483617A8911BAAC7B4D83EFA52A340B5EF700081`。
- **根因/建议：** 检测器针对较窄的连接异常布局设计；先定义需支持的断线弹窗类别，再增加真实正例/相近正常公告负例，必要时改该规则与抢占流程。不要只扩大子串/颜色阈值。
- **收益/风险：** 覆盖实际样本，避免未识别模态框；风险为误报公告/误取消路线。
- **前置测试：** native OCR→真实UI Pipeline→watchdog idle/slice两路径；断线正例、多分辨率/动画及近似颜色负例；M03安全设备记录。
- **是否值得：** 是，先补范围和样本；不作为纯结构重构继续拆类。

### V2-03：RunLoop内部错误/取消可呈现Pipeline成功

- **类型/严重度：** 历史行为/结果契约债务，中高（可观测性），尚非本次实际RunLoop故障重放。
- **源码：** MainForm.Automation.cs:504～505吞OCE/一般异常并Error，外层:171～172 await后Success，:174～179取消也Success；handler:68～72映射到MAA成功。
- **影响/根因：** 业务用例只返回Task，无法传递“正常停止/用户取消/运行错误”；8事件map-run trace只表示handler报告完成，不能证明完整业务成功。
- **建议：** 单独确定停止/取消/失败契约，先加事件序列和表征用例，再选择小型结果类型，不顺便迁移全部RunLoop。
- **收益/风险：** 诊断和验收结果真实；改变Success会影响UI文案/历史trace/重试策略，属于行为修复。
- **测试前置：** 启动失败、运行中ReadMap/Input异常、普通停止、owner取消、弹窗slice取消、停层自然结束；验证result与释放/状态时序一致。
- **是否值得：** 是，先锁定语义；不直接把所有OCE改Canceled。

### V2-04：触摸失败与native关闭的证据/恢复契约不足

- **类型/严重度：** 历史约束及高风险验证缺口，高；不以风险推断存在新增设备回归。
- **源码：** TouchController.cs:31～32成功down后才held，:46～49先清held再发up；:68～76整个pulse在锁内、EmergencyRelease排队；RouteExecutor.cs:168 finally up可覆盖异常。PaddleOcrEngine.cs:49～58 native启动后不受token终止，:181～187 Dispose不等待gate。AdbClient.Dispose依赖所有者先await。
- **当前保障：** TouchControllerFault5例锁定上述方法调用顺序和异常语义；ShutdownResource4例证明两owner等待及runtime幂等，不含真实partial bytes、活动native或句柄基线；当前WhenAll已消除移动失败漏等entry，不能再次报告该旧缺陷。
- **建议：** 优先M02/M03/M08记录，再确定down部分失败/up失败的backend重建或补偿契约。native关闭保持cancel→await→Dispose，不用WaitAsync超时后遗弃动作。
- **收益/风险：** 明确急停实际延迟和释放安全；抢占pulse/自动补发up/重新初始化均可能改变设备协议及行为。
- **测试前置：** byte transcript部分写、socket断线、subscriber抛错、长pulse期间急停、活动native关闭/重复close、进程/Bitmap/句柄前后记录。
- **是否值得：** 是，作为验收和受控故障修复，不作为增加抽象的理由。

### V2-05：诊断源队列与有限旁路的范围不一致

- **类型/严重度：** 残留观测/内存债务，低中；有限sink已实现，不是本次新增无界日志。
- **源码：** Domain/Models.cs:18～27静态ConcurrentQueue/Drain；FloorStateMachine.cs:18～23无限invalidTransitions且Reset不清；NonCriticalDiagnostics.cs容量100/30s全局节流。
- **影响/根因：** 坏字段在消费者Drain之外可累计；楼层非法转移长期累计；全局Drain无设备/来源隔离，节流抑制不同事件。当前单设备/定期Drain减小风险，无内存泄漏量化实测。
- **建议：** 有长运行故障证据时限制诊断源队列，按来源保留计数/最后异常；维持原默认值/Transition和非抛错旁路。不要构造可靠日志框架。
- **收益/风险：** 防高频失败占内存并改善诊断；丢弃策略影响历史Drain/InvalidTransitions表征。
- **前置测试：** flood、多来源消费、Reset兼容、sink异常、容量/节流、诊断永不改变设备控制。
- **是否值得：** 可选低侵入项，不阻塞当前结构验收。

## 3. 可接受债务与不建议新增任务

- MapSnapshot.Map为可变引用：已用表征测试记录；深复制会影响性能/数据身份，当前保持。
- AdbClient门面转发、PortalRouting常量别名、RouteExecutor布尔包装：保护现调用点，成本小。
- Reader和Assistant重复游戏Root路径：各自文件协议使用常量，当前无第三种实现/版本profile需求；不为两处文本建设配置系统。
- AdbTouchSession.Connect中的重复transport reset与facade setter reset：冗余幂等，无双owner；只在维护该流程时整理。
- AssistantController返回AdbClient.AssistantStatus：内部协作者可接受耦合，不值得造多个DTO层。
- MAA非并发安全：生产new-per-run，顺序使用已有文档；没有证据要求改并发runtime。
- PaddleOcrRuntime使用固定ASCII临时目录并改变进程CurrentDirectory：native兼容约束，当前ApplicationPaths绝对路径降低影响；本次不清除共享运行时缓存、不把它当审计临时文件。多实例运行/资源部署若出现需求再测，避免将静态初始化改成大服务。
- 当前测试使用反射注入internal cache/backend和MainForm私有任务：增加内部布局变更维护成本，但避免生产seam污染；未来已有真实生命周期端口时再替代，当前不为测试专门引入interface。

未发现可证实的“为了修一处而新增God Manager/全面DI/新的Domain循环”问题。枚举/API删除、自动进图与卡层修复是混合工作区的行为变更；它们相对HEAD是新增差异，但没有足够版本归因证明由哪一个RU引入。不得硬填“重构中新引入缺陷”分类。

## 4. 推荐边界

停止全面第二轮重构。优先处理V2-01，同时小范围补强V2-06；随后补V2-04/G2/G3/G6证据，再核定V2-02和V2-03行为契约。TD-02/RU-12只有真实维护痛点与足够事件/设备保障时再开启；TD-08/14/16/17的泛化改造不值得当前投入。

这里的建议不是执行授权。本轮没有实现这些修复、没有增加永久测试项目、没有提交或发布；等待下一步指令。

## 5. V2-06：Domain架构守卫的框架引用筛选过宽

- **类型/严重度：** 测试保障实现缺口，中；本轮重构新增守卫本身的约束漏洞，而非当前Domain新增UI依赖。
- **范围/源码：** DomainBoundaryTests.cs:19～23将TPA中所有System.*程序集作为BCL引用；测试主runtimeconfig同时引用WindowsDesktop。System.Windows.Forms.dll符合筛选。
- **本次证据：** 按相同筛选编译`public class Forbidden { public System.Windows.Forms.Form Value; }`，错误数0。原20例仍绿；MainForm/AdbClient/PortalRouting应用类型负例失败，只证明那些类型被阻止。
- **根因/成本：** 用名称前缀代替明确框架边界；未来Domain能直接依赖Form/Drawing而测试不报警，削弱架构验收可信度。当前源码检索未见Form/ADB依赖。
- **建议：** 明确允许的基础框架reference assembly范围；为System.Windows.Forms.Form、需要禁止的System.Drawing/资源类型及Domain新子目录增加确定负例。用同一guard函数验证，禁止为了绿测试降低断言；不必拆生产程序集。
- **收益/风险：** 低成本让守卫符合文档承诺；风险是误禁原已允许的纯BCL类型，需明确规则，避免“System.*全禁”式修复。
- **测试前置：** 全部当前Domain正例编译仍通过，三个现应用类型负例与WinForms负例均产生预期错误；新子目录源码确实纳入；主生产ProjectReference不受影响。
- **是否值得：** 是，小范围测试保障修复；RU-11因此有条件通过，不签署严格BCL-only边界保证。本次只记录，未修改已有测试或生产。



## 重构后状态

本轮将 V2-01、V2-03、V2-04、V2-05 相关生命周期与状态风险纳入底层边界修复，并将 V2-02 的闲置断线样本接入实际 native OCR 回放。V2-06 架构守卫改为 .NETCore-only 引用并增加 WinForms/Bitmap 负例。MainForm 仍保留部分游戏流程，因此 Presentation 不是纯视图层；这属于有意保留的业务约束，不应继续用转发类掩盖。

是否继续第二轮重构：暂不推荐立即开始。先完成 M01～M08 真机回归和变更评审；若真机记录显示 RunLoop 或楼层转场仍有状态缺陷，再按完整用例迁移。

当前最值得处理的前三项（按真机证据触发）：
1. 真实设备重连/切换期间的 AdbTouchSession、root shell 和 pending capture 联合回归。
2. RunLoop 的战斗、楼层转场、弹窗抢占事件回放，确认取消/失败结果与 Pipeline trace 一致。
3. 若前两项稳定，再拆出 MainForm 中剩余的楼层/战斗用例，保持单一 DungeonSession 状态所有者。
