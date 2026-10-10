> 历史审计快照：本文基于用户授权全面重构之前的工作区。本轮生产源码已发生后续变化；当前迁移、修复和验证结论见 [FULL_REFACTOR_REPORT.md](FULL_REFACTOR_REPORT.md)。本文的旧源码路径、风险和测试数量保留作为历史证据。

# 全项目重构最终审计

审计日期：2026-10-09（Asia/Shanghai）。对象：`F:\Cave2Assistant\outputs\adb_map_controller` 当前工作区。本文取代此前同名文档的混合阶段结论；历史记录仍保留在 REFACTOR_BASELINE.md、REFACTOR_EXECUTION_REPORT.md 与 Git 中。本次仅审计、离线验证和输出四份文档，未修改生产或已有测试源码、未提交、未发布、未操作真实设备。

## 1. 最终判断

**B. 有条件通过。** 主要的最小架构目标已经落实：生产引用测试恢复、Domain 反向依赖消除、设备组件单一所有权成立、路线执行通过能力端口隔离、Pipeline 语义明确、诊断有实际消费方。Release 构建和两套测试本次实测成功。但Domain架构守卫仍可放行WinForms引用，完整 Application 用例目标尚未落实，设备异常矩阵与 native 关闭证据仍不足，且新增审计实验复现了共享帧缓存的两个生命周期问题。

不接受“RU-01～RU-14 全部完成”的前提作为事实。Backlog 当前明确记载 RU-09/10/13 部分完成，RU-12 未开始且有意延期，另有 RU-15。按本次验收口径：6 项通过、7 项有条件通过、1 项不通过（RU-12 未实施；不表示应强制实施或项目整体失败）。若要求原始 14 项范围全部实现及 G0～G6/M01～M08 全闭环，则当前不能签署无条件通过。

### 六个直接回答

1. **改善什么：** RouteExecutor 从依赖具体设备和约二十项构造参数，变为两个能力端口及显式执行上下文；会话和进程资源集中拥有；AdbClient 的传输、截图、助手、触摸会话、JSON、视觉职责有真实实现边界；Domain 的已知反向引用消除并有隔离编译测试；真实生产程序集得到 165 例自动化保障。
2. **过度设计：** 未发现需要拆除的大规模过度设计。兼容门面存在转发，但各下层拥有真实逻辑/资源；MainForm 代理属性直接读写同一 DungeonSession，不是重复业务状态。少量重复 Reset 调用和 AssistantStatus 对门面的类型依赖可接受，不值得再加接口层。
3. **必须继续解决：** 缓存完成/克隆/淘汰生命周期缺陷应进入后续小范围修复；签署全量业务验收前须补设备与 native 关闭证据；“保行为”结论须明确区分已有业务修复/API 删除。触摸失败恢复、RunLoop 成功状态歧义需单独确定业务契约，不能偷偷改变。
4. **保持现状：** 三类 Pipeline、单程序集、Planner/Compiler 深模块、JSON 容错、非法楼层转换的诊断语义、运行内传送门学习、UI 上下文 OperationTracker，以及尚无维护需求的 RU-12 延期。
5. **第二轮重构：** 不推荐全面启动。推荐有限缺陷修复与验收补证；只在真实修改需求出现后迁移一个已覆盖用例。
6. **若继续前三项：** ①共享帧缓存所有权与失效边界；②M02/M03/M08 触摸异常、抢占和关闭证据；③Domain 架构守卫的引用筛选漏洞。ServerError 样本范围与跑图结果语义随后单独补契约/测试，是否改变行为另案决定。

## 2. 输入、版本与证据等级

完整核对了 `docs/PROJECT_ANALYSIS.md`（题设文件的实际位置）、REFACTOR_BASELINE.md、TARGET_ARCHITECTURE.md、REFACTOR_BACKLOG.md、REFACTOR_TEST_PLAN.md。还检查源码目录、测试/Fixture、项目配置、验证脚本、现有审计与执行记录、Git 历史/工作区，以及存量 Pipeline trace。

| 身份 | 用途与限制 |
| --- | --- |
| `7f9ff2bc3e46f3f46178b3ac4a70617b2f1eaee0` | 可获取的重构前结构参照：无 Application 目录，MainForm/AdbClient 内联职责，RouteExecutor 直接依赖设备；并非初始 RU-01 红色工作区快照 |
| `b8d5f78fa76eac9a38b658a7ca1e8829a574a8e0` | 恢复/提取混合提交；git show 实际还增加组件字段、Serial 委托和 IPlayerStatusSource，不能仅按提交标题理解为声明恢复 |
| `1805700b623a505675d5635f5b9be36cc1dfa0e5`（HEAD） | 已提交提取及测试基线；不包含当前未提交 RU 接管、RU-15和其他后续变更 |
| 当前工作区 | 本次真正审计/测试对象；含未提交源码、资源、测试和既有发布文件；暂存区为空 |

**无法可靠恢复“全部 RU 前那个未提交红色工作区”的精确版本。** 不用初始提交或旧发布 exe 推断其行为。本次旧/新结构比较使用可获取的 7f9ff2b 与当前源码，接管及规则差异另对照 HEAD；没有构建或运行历史生产版本，故不声称完成跨版本动态行为等价验证。详细差异见 ARCHITECTURE_COMPARISON.md。

证据等级：本次构建/测试/定向实验 > 当前源码和可取 Git blob > 有版本局限的历史设备记录 > 文档转述的用户实际使用反馈。最后两类不替代本次独立设备验收。工作区未提交本身不是架构缺陷；主要限制是变更归因和审计身份。

本次源码清单指纹见 REGRESSION_REPORT.md。既有审计文本曾含“165/163/156”等混合分母、“关闭漏等”旧结论和后续发布记录，本次按当前测试 TRX 和源码重新裁定，不追溯性称那些操作发生在本次。

## 3. RU-01～RU-14逐项验收

下表的源文件/行号均为本次工作区，历史行号不作为当前证据。测试数量是主测试内分类，不与独立 Baseline 相加当作独立覆盖。通用检查包括旧实现引用、重复 owner、转发层、反向依赖、状态及行为变化；专项结果见随后矩阵。

| RU | 原始问题 | 实际修改与当前源码证据 | 架构改善效果 | 本次测试证据 | 剩余风险 | 验收 |
| --- | --- | --- | --- | --- | --- | --- |
| RU-01 | 迁移中断导致声明缺失/生产不可构建 | 当前 AdbClient.cs:43～50 构造完整协作者，53～77 委托并重置；原声明已随接管删除，不要求恢复它们 | 恢复完整生产验证入口；早期仅恢复编译不是职责改善 | Release build 0警告/0错误，主165/165；历史声明恢复仅由 Git/执行记录佐证 | 原始红工作区无法重建，不能逐条动态复验当时增量 | 通过（当前可构建目标） |
| RU-02 | 52例源链接测试不能证明生产程序集 | tests/AdbMapController.Tests.csproj 保留生产 ProjectReference，仅纳入五份 baseline 手写测试；独立工程明确 source-linked | 主测试真正走生产编译/类型/native路径；不复制生产类型 | 主165/165，独立51/51；Fixture从输出读取 | baseline与主工程大量重叠，非216个独立业务案例；Loot理论用例删除须说明 | 通过 |
| RU-03 | Domain/RouteSession引用Navigation计划类型 | Navigation/RouteSession.cs:10～38；原 Domain 文件不存在；与 HEAD 原文件归一行尾后全文相同 | 是合理的所有权归位，单元本来就不要求算法改造；无新层/owner | RouteSafety 8、Session 1、State/JSON 19，以及Domain编译守卫 | 根namespace保留，目录隔离靠守卫而非程序集 | 通过 |
| RU-04 | Pipeline入口和不同超时语义混淆 | MainForm.Automation.cs:61 用MAA；DungeonEntryAutomation.cs:50 用MAA；MaaPipeline.cs:1212保留legacy handler adapter；UiPipeline.cs:101单帧识别 | 三种职责隔离，有真实资源及字段契约；不是统一/删除引擎 | PipelineContract 26、PipelineBaseline 12；实际3份Automation资源加载/顺序执行 | 离线handler不是设备动作；后续Custom与入口资源已有行为修复，不能混入纯结构等价 | 通过（语义保障范围） |
| RU-05 | JSON诊断丢弃、设置失败不可见 | MainForm.DeviceMap.cs:194～196消费Drain；NonCriticalDiagnostics.cs:6～29容量100、512字符、30s节流；SettingsStore与Program接线；Web /api/diagnostics | 有实际HTTP消费方和有界内存，不增停止条件；非空壳日志接口 | Diagnostics 3、SettingsFailure 3、SettingsStore 2、Web 7 | 全局节流丢事件；上游JsonDiagnostics仍是无界静态队列，不能称全链路有界 | 通过（有限旁路目标） |
| RU-06 | 两套命令/root session实现及状态迁移风险 | AdbCommandTransport.cs:14～18唯一root锁/进程/root能力/serial；AdbClient.cs:52～53委托，旧root实现不再存在 | 完整资源owner接管，普通/root命令不懂地图或UI；重复Reset幂等调用不形成双owner | FakeADB分类23例含argv/serial/root/su/marker/EOF/非零；历史LDPlayer记录另列 | 缺长按断线/真实跨设备/超时整矩阵；按行读的3s不是整用例硬期限 | 有条件通过 |
| RU-07 | 双截图实现与Bitmap共享/释放缺少验证 | AdbScreenCapture.cs:9,19～63唯一capture锁和进程；AdbClient.cs:230～235唯一popupFrameCache；ScreenFrameCache.cs:59～165 | 截图传输与共享原帧/clone分离，截图gate和缓存gate保护不同对象 | Fake空流/坏PNG/非零/超时；共享帧/取消/迟到Dispose；本次额外实验复现2个缓存缺陷 | 完成后Clear/淘汰可先Dispose再clone；Clear不使在途capture失效，旧帧可重入缓存（V2-01） | 有条件通过（不得签资源完全安全） |
| RU-08 | 助手协议新旧双实现、恢复安全边界 | AssistantController.cs:14～139集中target/备份/加密/hash/安装/恢复；AdbClient.cs:256～266委托旧公开面 | 真正移出协议实现，门面无第二套安装状态；AssistantStatus仍依门面类型是小型内部耦合 | Fake pull/push/目标写失败、损坏备份、幂等恢复和临时清理；历史设备哈希往返 | chmod/cleanup、部分实际写入、test-panel UI未完整覆盖；模拟cat失败发生在写前不能证明部分写原子性 | 有条件通过 |
| RU-09 | RunLoop/抢占/关闭缺少确定事件Fixture | OperationLifecycleTests/ShutdownResourceTests/PopupWatchdog离线集成存在；MainForm.Movement.cs:377～384现用WhenAll等两任务 | 强化保障，未转移owner；移动故障后漏等入口的旧缺陷已修复 | STA tracker4、Shutdown4、Touch故障5、Fake watchdog；当前Shutdown异常等待测试通过 | 无完整RunLoop/battle/refresh失败事件序列；Shutdown tests用反射注入私有任务，偏离原“不绕反射”计划但属低侵入表征取舍；未测活动native | 有条件通过 |
| RU-10 | 控制流测试无法判断实际视觉正确率 | VisualFrameReplayTests；tests/VisualFixtures/README.md有来源/分辨率/hash；8张PNG，7张用于已有回放，idle断线样本未作检测正例 | 正负真实图片回放和native OCR可运行，文本输入与OCR结果明确分开 | Visual15；Fake watchdog真实greedy帧/native/UI Pipeline；8张hash核对一致 | server正例、图像近似负例、动画、多分辨率缺口；idle断线规则不匹配（V2-02）；Loot检测已删除，无需强补废弃功能样本 | 有条件通过 |
| RU-11 | MapIconCatalog引用PortalRouting；Domain边界仅人工约定 | Domain/PortalProtocol.cs常量3；MapIconCatalog.cs:192直接引用；PortalRouting.cs:34兼容别名；DomainBoundaryTests.cs:10～28 BCL编译 | 清掉已知Domain反向依赖；不是把Navigation所有计划塞进Domain | DomainBoundary20例，含独立编译、3种禁止引用负例、图标和12种传送分类 | 同筛选规则的WinForms负例探针0编译错误（V2-06）；守卫还只涵盖Domain/*.cs，未来子目录需调整 | 有条件通过 |
| RU-12 | MainForm业务编排/CTS仍混在UI | Application目前仅Runtime/Session/Tracker；MainForm.Automation.cs:190～514、DeviceMap.cs:190仍是业务用例 | **未落实一个Application用例迁移**，不存在可验收修改；延期可避免无依据迁移 | 没有所迁用例的golden/设备对照；既有165例不证明该任务已做 | 最终Application目标未全达成；Backlog明确有意不执行，本次不强行补做 | 不通过（未实施；接受延期，不作为整体阻断） |
| RU-13 | 时间/协议数字难以解释 | AdbGameDataReader.cs:15～19已命名20/5ms/20/0.005s；RouteExecutor.cs:87,144及其他模块仍有局部时间值 | JSON子单元读者可理解单位，未泛化TimingProfile | Fake JSON失败20次、shell命令20/0.005s和异常；基线默认值 | 其余命名未做，不能标全完成；现值无设备逐项时序对照 | 有条件通过 |
| RU-14 | 回环/路径/释放约束缺测试 | PipelineWebServer显式127.0.0.1、GET及trace文件名限制；WebBoundaryTests受控目录和端口 | 证明现有边界，不因“无认证”扩大服务 | Web7例实际HTTP、诊断、路径拒绝、非GET、端口回退及Dispose重占 | 本机客户端仍能读；LAN部署不是当前支持范围 | 通过 |

### 十项横向检查补充

| 检查 | 当前结果 |
| --- | --- |
| 原问题/目标落地 | 逐项见上表；RU-12未实施，09/10/13部分，不以标记代替验收 |
| 只移动代码 | RU-03刻意无行为改动但修正层归属；MainForm partial仅改善导航，真实改善来自Session/Runtime/Executor及ADB owner |
| 额外转发层 | AdbClient compatibility facade、RouteExecutor.Execute布尔兼容方法、PortalRouting常量别名有明确调用/API用途；未发现值得立刻拆除的无意义Service |
| 新反向依赖 | Domain已无已知反向引用；Application Runtime使用具体Infrastructure是目标允许的组合根例外；AssistantController引用AdbClient.AssistantStatus仍为组件内部耦合 |
| 重复实现 | 旧RunRoot/Capture/助手实现均移除；Pipeline实现语义不同，不能机械认重复；两个游戏Root路径仍重复（reader/assistant），低风险可保留 |
| 废弃实现引用 | Domain/RouteSession旧文件无残留；LootConfirm/HasLootConfirmButton已删除无现代码引用；legacy TaskPipeline类型/adapter有意保留，并非废代码误调用 |
| 重复状态owner | Serial/root唯一transport；screen/backend唯一touchSession；UI属性别名非副本；弹窗interrupt与UI消费状态是交接的两个阶段，仍有隐式同步成本 |
| 行为变化 | 入口资源/HasEnteredDungeon、原初试炼模式16→10层、Loot公开API删除、关闭WhenAll是当前相对HEAD可见变化；诊断为旁路，详见比较文档 |
| 充分测试 | 当前自动化绿；RU-07定向实验发现绿测试遗漏，G/M矩阵仍部分；无全项目设备E2E等价证明 |
| 分类与维护收益 | 不对所有长文件/catch/接口下缺陷判断；可接受债务与已复现实现问题分别列TECH_DEBT_V2 |

额外 **RU-15**：AdbClient目前约277行（含末尾空行），AdbTouchSession/AdbGameDataReader/AdbScreenAnalyzer拥有真实连接、JSON、视觉/native职责，并非只把门面移进另一个门面。构造/Dispose按资源次序接线。结构方向合理，主测试全绿；但有跨组件异步工作与关闭前置契约，且无本次设备重验，判有条件通过。它不计入14项统计。

## 4. 目标架构符合性

### Presentation

MainForm仍是主要编排热点：RunLoop同时控制刷新、战斗、弹窗、楼层、挖矿、路线和恢复；Planning读取控件并作选目标/门控。生产不再由窗体直接持有root Process或native OCR engine，但具体Adb/Touch调用仍在UI用例中。因此完整“Presentation只表达意图”未达到；目标文档本身也明确本阶段不搬RunLoop。维护成本是改一条转场规则需要同时理解UI flags、session和CTS，而不只是文件长。

最有价值的未来独立边界是RefreshMapSnapshot的读取→ApplyPlayerStatus→portal观察→session替换用例，或楼层确认/超时恢复用例。当前不强制实施；先补输入快照和事件trace，避免几十个getter代理。

### Application、Domain与Navigation

ControllerRuntime只组合进程资源，不计算路线，不是God Manager；DungeonSession持有地图、RouteSession、RouteExecutionRuntime、楼层/门户/目标状态，Reset和Stop具有不同清理语义。OperationTracker在UI同步上下文跟踪当前任务快照，不承诺跨线程安全。run/entry/slice CTS及watchdog生命周期仍在MainForm；没有第二个Application run CTS owner，问题是用例分散而非双CTS。

MainForm route/floorPhase等属性直接转到session；MapPanel.Map是显示引用，MapSnapshot.Map是共享引用/捕获元数据，均不能当深不可变副本。interrupt中的待处理类型与MainForm已消费flags不是两个并行权威，但消费/清理顺序尚无完整trace。

当前Domain源码未见具体ADB、UI、Navigation策略依赖；独立编译测试本次通过，但引用筛选实际允许WindowsDesktop System.*，不能当成严格BCL-only证明。JSON属性/converter与游戏字段同模型仍是协议耦合：目前没有多版本DTO转换需求，增加映射层收益不足。

Planner接受地图/options/blocked，内部图搜索和TargetPolicy组合，无设备/UI资源生命周期；PortalRouting与两种学习图拥有规则/观察，而不是触摸。RouteExecutor通过IPlayerStatusSource/IMovementInput/observer执行，输入context明确；RouteSession保存计划，runtime由session持有。observer回调回UI是端口实现，不能当程序集循环。执行异常/取消仍有历史边界：ReadPlayer无CT、finally TouchUp可盖原异常、boundary复核直接写Player不做全层校验，均非此次新增回归证明。

### Infrastructure与Pipeline

资源及锁核验：transport root锁保护持久shell；touchSession connection/payload锁保护连接/启动；TouchController lifecycle保护完整逻辑手势；backend WriteLock保护协议写入；capture锁保护截图进程；cache gate/imageGate保护索引与Bitmap；OCR gate保护native推理。它们保护不同资源，不是“双重同一锁”。确有重复Reset调用，但没有双serial/root/backend/cache。UI Pipeline的context cache存识别节点结果，与ScreenFrameCache存原图不是同一缓存。

AdbClient Dispose不等待所有异步工作；capture.Dispose仅禁止新capture，OCR.Dispose直接FreeEngine，transport.Dispose直接关shell。因此安全关闭依赖MainForm先cancel/await watchdog、入口/移动、UI任务与refreshLock。当前正常/异常两owner等待已测，活动native/在途共享工作整链尚未独立验证。V2-01说明cache本身还未完整解决等待者所有权。

MAA是catalog/compiler/任务分支+trace；Task是legacy节点重试/协作CancelAfter；UI是单帧优先识别+超时后fallback。生产主入口创建new-per-run MAA，runtime不构造Form/Adb或拥有session；MainForm作为TState由handler捕获，是未迁应用用例的耦合，不等于generic runtime引用WinForms。未发现生产直接实例化TaskPipeline主引擎；结果DTO和handler adapter保留。三者无需合并。

## 5. 完整工程与质量核验

Release成功，主165/165、独立51/51（全部执行，0失败/0跳过）。架构20、Pipeline契约26、视觉15、FakeADB23、触摸5、关闭4、UI生命周期4、Web7均包含于主测试，不额外重复计总数。资源加载覆盖当前Automation配置、助手模板、视觉Fixture和部分native模型；未覆盖全部主题/模板/触摸agent/最终发布部署组合。

新实验仅实例化生产ScreenFrameCache及静态文本分类，不构造设备、不跑ADB；它复现了失败，不能记为“全测试通过故资源安全”。现有suite绿与实验发现并不矛盾。

空catch大多属于best-effort清理、fallback和非关键trace/sink；RunLoop吞异常后外层Success是明确结果歧义。静态全局重点为JsonDiagnostics、FloorStateMachine诊断队列及PaddleOcrRuntime改变CurrentDirectory；有真实生命周期成本，详见债务文档。未发现需上DI框架或全面引入interface的证据。

G0～G6、M01～M08与13类业务证据详见 REGRESSION_REPORT.md。整体建议停止泛化重构；保留明确验证缺口，不把“现有使用正常”提升为所有异常/端到端路径通过。
