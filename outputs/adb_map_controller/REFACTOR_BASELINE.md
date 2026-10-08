# 第二阶段：审计核验与工程基线

核验日期：2026-10-08。对象是当前工作区源码，不是历史发布程序。此文与 TARGET_ARCHITECTURE.md、REFACTOR_BACKLOG.md、REFACTOR_TEST_PLAN.md 共同构成第二阶段交付；遇到历史文档冲突，以本次实测及源码为准。

## 1. 基线身份、RU-01 前后结果与限制

- HEAD：`7f9ff2bc3e46f3f46178b3ac4a70617b2f1eaee0`；工作区包含用户此前暂存的拆分、测试、文档及发布文件，不能用 HEAD 代表当前实现。本阶段不重置、不提交这些改动。
- 环境：Windows，.NET SDK 8.0.401，VSTest 17.11.0；项目 net8.0-windows / win-x64。
- RU-01 前，主项目和原测试因 AdbClient 缺失声明报 CS0103，原 6 个用例未运行；完整脚本退出码 1。修复前结果保留作审计历史。
- RU-01 当前仅在 `Infrastructure/Adb/AdbClient.cs` 恢复旧实现所需字段、信号量、计数器、超时常量和测试面板路径声明；没有修改主项目、Directory.Build.props 或其它生产文件。
- RU-01 后 `dotnet build AdbMapController.csproj -c Release`：成功，0 警告、0 错误。
- 原测试 `dotnet test tests/AdbMapController.Tests.csproj -c Release`：**6/6 通过、0 跳过**，通过真实 ProjectReference 构建生产项目。
- 独立 `tests/baseline/AdbMapController.Baseline.Tests.csproj`：**52/52 通过、0 跳过**。它直接链接 Domain、Navigation、会话、配置、三类 Pipeline 等源码，不证明设备行为。
- `scripts/Verify-RefactorBaseline.ps1` 完整验证：退出码 **0**；原测试 6/6，独立基线 52/52。没有加 `-Publish`；按本次指令未发布。
- 未执行成功发布、未启动旧 exe、未连接 ADB、未安装/恢复助手、未更改 Pipeline 或设备协议。现有 publish 文件不能作为当前源码通过证据。
- 脚本先按 csproj 的程序集名及绝对项目路径边界检查/停止本项目程序；本次检查未发现运行中的本项目进程。所有构建和 TRX 在各项目 publish 内；脚本 finally 清理限定的 `.build` 和本次 `.verification-<guid>`，保留用户发布文件。

关键生产源码 SHA256（核验后未变化）：

| 文件 | SHA256 |
| --- | --- |
| Infrastructure/Adb/AdbClient.cs（RU-01后） | 00528925871DBBDEAC4B1A97184F1CF3930D543C5CC08A84DAEF278DABA62DBF |
| Presentation/MainForm.Automation.cs | 4BD65048EEA129A0DC1167EDE2E1A10154978E40854862CA9E8EB96B7E3F2E8C |
| Infrastructure/Automation/MaaPipeline.cs | 408CE1C9F762E35F59653826D12C56BF8B20A6E458D391B7913F8B62B9B6A7B0 |

## 2. ADB 迁移现状：RU-01 已恢复构建，接管仍未完成

证据：AdbClient.cs:27-29 已创建 AdbCommandTransport、AdbScreenCapture、AssistantController；:52-61 仅 Serial 和构造使用新 transport。Run(:164)、RunRoot(:197)、截图(:761)、助手操作(:804 起)、Dispose(:965) 仍使用旧实现。RU-01 已恢复旧实现依赖的声明并通过构建；这些方法还没有迁移到新组件。

原缺失符号包括 `rootShell`、`rootShellLock`、`rootCommandId`、`adbRunsAsRoot`、`screenCaptureLock`、三类超时常量及三条 TestPanel 路径，现已按 HEAD 中类型、初值与常量值恢复。路径临时文件名沿用现有调用/历史声明 `TestPanelCommandTempPath`。新组件“存在”不代表调用已接管；构建通过也不代表已完成ADB迁移。

后续迁移仍须按单元执行。新的 RunRootAsync 与旧 RunRoot 的 printf 换行转义文本不同，未经字节级/假进程核验，直接委托可能改变边界标记协议。

## 3. TD-01 至 TD-18 逐项核验

风险指当前实现和测试缺口；“推荐”不是执行授权。未发现不等于已证明绝对不存在。没有异常捕获、文件长、魔法数字等均需结合边界与容错语义判断，不能按文本命中机械认定缺陷。

### TD-01：Domain 与 Navigation 的反向依赖

- 真实性/证据：真实的目录级依赖环；Domain/RouteSession.cs:12-13,32 引用 Planner.cs 中 PlannedInteraction、TargetKey、RoutePlan；Domain/MapIconCatalog.cs:192 引用 PortalRouting 常量；Navigation/RouteExecutor.cs:33 及 Planner 使用 Domain 模型。不是两个程序集的循环引用，目前只有一个程序集。
- 当前行为/局部修复：RouteExecutor 已有端口和显式上下文，但 RouteSession 放置位置仍不合理。回调观察端口本身不是循环依赖证据。
- 真实风险/等级：中；影响模块独立验证、导航契约修改的范围，不是现有运行崩溃证据。
- 建议/更小方案：先把 RouteSession 移到 Navigation，保持类型名/命名空间/字段/方法不变；Portal 分类码另一个小单元处理。无需立刻拆程序集或新建泛用 Contracts 包。
- 收益/行为风险：消除最明显的反向所有权；物理移动风险低，序列化/API 不应改变。
- 验证方式：RU-03 路线和 Reset 测试、符号引用比对、目录依赖例外清单；RU-11 才关闭 MapIconCatalog 例外。
- 是否推荐：是，分两步；不声称一次移动已完全消除依赖环。

### TD-02：MainForm 业务编排过重

- 真实性/证据：真实；MainForm.Automation.cs:190-512 RunLoop；Planning.cs 680 行；Movement.cs:344-389 同时协调 watchdog、取消、设备可用性和活动任务。九个 MainForm 文件共 3,137 行，partial 不是服务边界。
- 当前行为/局部修复：ControllerRuntime、DungeonSession、OperationTracker、RouteExecutor 端口已经外移部分职责，不能认定完全没有分层。
- 真实风险/等级：高；窗体控件值和业务判断共用上下文，难覆盖抢占、交互停靠和转场顺序。
- 建议/更小方案：先记录 RunLoop 输入/观察事件；经测试后搬一个完整且已理解的用例，优先非交互纯决策。暂不整体搬 RunLoop，不创建几十个 getter/setter 委托。
- 收益/行为风险：可测试用例边界；UI 同步上下文、刷新并行及 CTS 所有权改变风险高。
- 验证方式：REFACTOR_TEST_PLAN 的 C01/C03/C08 与设备 M01-M06；RU-09 先建事件记录。
- 是否推荐：准备工作是；大循环迁移待真实顺序覆盖及业务确认。

### TD-03：AdbClient 职责聚合且迁移中断

- 真实性/证据：真实并存在编译阻断；AdbClient.cs:153-355,359-458,625-790,793-954；新 transport、capture、assistant 并未接管。
- 当前行为/局部修复：TouchController 分离输入生命周期；新三个内部组件已写出但旧调用、旧 Dispose 残留。RU-01 已恢复主项目构建，尚未验证真机行为。
- 真实风险/等级：高；首先是无法构建，其次双实现的锁、Serial、root 状态和资源释放可能不一致。
- 建议/更小方案：RU-01 已恢复缺失声明；随后按 Run/RunRoot、截图、助手三个单元逐一对照和迁移。
- 收益/行为风险：先恢复验证通路，后降低跨职责修改；root 标记、su 回退、设备枚举、缓存清理、Dispose 改变均是潜在不兼容。
- 验证方式：完整编译/原测试、ADB 命令 golden 记录、fake process 超时及真机断线重连。
- 是否推荐：RU-01 已完成；组件迁移必须在专属测试门槛之后。

### TD-04：多 Pipeline 语义并存

- 真实性/证据：源码真实并存，但“生产同时运行两套主任务引擎”未证实；MainForm.Automation.cs:61、DungeonEntryAutomation.cs:48 使用 MaaPipeline；TaskPipeline.cs:188 和 MaaPipeline.cs:1210 的 legacy adapter/结果类型保留。
- 当前行为/局部修复：MAA 已成为主入口；UiPipeline 刻意串行识别单帧，与任务引擎职责不同。MAA TimeoutMs 控制上一节点后继候选等待，动作没有 CancelAfter；TaskPipeline:287 为协作式节点超时；UiPipeline:128 后检超时。
- 真实风险/等级：中（动作卡住则高）；误把 timeout 统一成同一语义会产生行为漂移。Maa options RetryTimes 存在但 FindAndRunAsync:989-1060 不用它控制重试次数，不能据 RetryTimes=0 推断无重试。
- 建议/更小方案：RU-04 冻结语义、资源 fixture、调用入口和不允许同实例并发的边界，不删除旧实现，不统一引擎。
- 收益/行为风险：明确运维超时预期；引入硬超时会遗留正在运行的动作并改变业务，属另案。
- 验证方式：PipelineBaselineTests 12 用例；尚需继承/表达式/真实资源/sub 失败矩阵。
- 是否推荐：是，隔离与测试；否，直接删除/合并旧 Pipeline。

### TD-05：设备端到端保障缺失

- 真实性/证据：当前原测试有 6 用例并已通过；RouteExecutorTests.cs:8,29 使用内存输入，不能验证 Android 收到 up。历史计划所说各 Regression 可执行程序不能算当前测试项目验证。
- 当前行为/局部修复：已有可注入路线端口；独立源码子集 52 用例通过，不宣称设备 E2E 已完成。
- 真实风险/等级：高；脉冲被取消、ADB 消失、OCR 阻塞、急停等必须测真实链路。
- 建议/更小方案：先 fake transcript + 截图回放，再用隔离测试设备按 M01-M08 手工记录。无需一开始建设复杂自动设备农场。
- 收益/行为风险：迁移具备可比对证据；设备测试可能产生游戏输入，需单独执行指令与安全地图。
- 验证方式：日志/触摸协议、状态序列、进程/图像资源检查，明确设备、分辨率、后端、游戏版本。
- 是否推荐：最高优先级保障，不能用 pure test 替代。

### TD-06：硬编码协议、坐标与时间

- 真实性/证据：真实；AdbClient.cs:19 包路径、:318 重试 20、:343 shell 重试；RouteExecutor.cs:87,144 5ms/120ms；PopupWatchdog.cs:15-16 120ms/2s；TouchBackends.cs:86-87 5000ms/16ms。
- 当前行为/局部修复：MovementTuning、TouchCoordinateMapper、ApplicationPaths、配置已有集中边界；不是每个数字都无语义。
- 真实风险/等级：中；未经覆盖修改设备时间常量的风险高，但把所有常量设为可调不等于收益。
- 建议/更小方案：RU-13 先命名并注明来源，值及运算顺序不变；屏幕 profile、协议版本另案，不开放任意计时调节。
- 收益/行为风险：导航/协议参数可追踪；单位转换、取整、默认值变化都可能影响移动。
- 验证方式：默认值/golden 输入序列一致、M01-M04；不得只跑编译。
- 是否推荐：有测试的命名整理是；改值或新配置否。

### TD-07：JSON 容错与诊断丢弃

- 真实性/证据：真实但风险表述需修正；Domain/Models.cs:163-238 弹性 int/tile 解码；AdbClient.cs:316-355 有 JsonException 20 次重试及 base64 回退；DeviceMap.cs:197 明确 Drain 后丢弃诊断。
- 当前行为/局部修复：JsonDiagnostics 已收集；语法损坏最终抛错，不是所有坏 JSON 都变“正常地图”。字段不兼容可转 0、false、墙、空 roles。
- 真实风险/等级：高（可观测性与协议漂移）；停止/默认策略的业务必要性尚未证实。
- 建议/更小方案：RU-05 有限、非抛错的诊断旁路；沿用返回值/重试/默认值。不要把必需字段“失败即停”混入重构。
- 收益/行为风险：诊断可见且不淹没 UI；同步日志、无限队列、订阅异常会增加时序风险。
- 验证方式：StateAndJsonBaselineTests 容错 fixture；另需 ReadJson 重试与缺文件/半写内容端到端。
- 是否推荐：保语义诊断是；收紧容错否。

### TD-08：非法楼层转换被应用

- 真实性/证据：真实且有明确兼容注释；FloorStateMachine.cs:23-31 Transition 记录后应用，Set 绕过检查；当前 MainForm.cs:74 的 floorPhase setter 使用 Transition，不是 Set。
- 当前行为/局部修复：状态对象已提取，但不是完整事件驱动楼层编排器；非法转换是诊断事件，不是被拒绝的业务操作。
- 真实风险/等级：中；队列持续增长，公开 Set 可绕过诊断但未据此证实生产调用绕过；不能从“非法”日志自动推导发生了错误流程。
- 建议/更小方案：冻结 Transition/Set 行为，补全实际转换序列和恢复入口；以后可限制诊断存储，不先引入 TryTransition 拒绝。
- 收益/行为风险：区分设计期图与实际游戏恢复流程；拒绝跳转风险高。
- 验证方式：当前非法/合法/Set 用例 + C04 楼层回放。
- 是否推荐：测试/诊断是；默认拒绝否（需要新业务决策）。

### TD-09：shell 字符串拼接

- 真实性/证据：真实；AdbClient.cs:345,872、AdbCommandTransport.cs:71；常量 Root、GUID 临时文件、find 的路径被嵌入 shell 单引号字符串；Process 参数使用 ArgumentList。
- 当前行为/局部修复：宿主进程参数已分项传递，设备 shell 命令仍是文本；未证明用户可控不可信输入能到达危险命令。
- 真实风险/等级：中；路径含单引号的正确性/未来扩展注入风险，不宣称已有可利用的高危漏洞。
- 建议/更小方案：RU-06 先记录现有命令字节与参数来源；独立单元才统一路径引用，不泛用“参数化 shell”替换现有命令。
- 收益/行为风险：明确输入信任边界；转义、printf 标记、换行及 su 包装改变都可能断开读取。
- 验证方式：带空格/引号/Unicode fixture、stderr/非零退出、root 标记和回退；真机对照。
- 是否推荐：测试与来源梳理是；未核验直接重写否。

### TD-10：OperationTracker 无同步

- 真实性/证据：HashSet 无锁真实（OperationTracker.cs:9-23）；但 MainForm.cs:305 RunUi、Movement.cs:67 RunMapClick 来自 UI 上下文且关闭先 closing=true，未发现生产 Task.Run 并发调用此集合。
- 当前行为/局部修复：已集中等待；WhenIdle 是当前任务快照，非“直到未来所有任务结束”的屏障。
- 真实风险/等级：低（脱离 UI 使用则中）；不能把潜在线程安全误用当已复现竞态。
- 建议/更小方案：RU-09 先注明/UI 断言约束和关闭拒收测试；将来迁移后台线程才明确加锁语义，不能仅换 Concurrent 集合。
- 收益/行为风险：保存上下文约束；锁中 action/await、重复 Task 去重和任务新增时序可能改变等待行为。
- 验证方式：原 Tracking 用例仅单任务；多任务/关闭/失败待 C08。MotionInterrupt 并发测试不是 OperationTracker 并发保障。
- 是否推荐：约束和用例是；目前直接加锁不是首选。

### TD-11：配置异常静默

- 真实性/证据：真实；Configuration/SettingsStore.cs:23-43 Load catch=null、Save catch 清理 tmp 后不抛错。
- 当前行为/局部修复：ISettingsStore 隔离持久化，Save 用 tmp+Move 覆盖；路径构造发生在 catch 外，非所有异常都会吞掉。
- 真实风险/等级：中；用户误以为配置已保存，损坏与缺失无法区分。
- 建议/更小方案：RU-05 增加可选失败诊断，Load/Save 签名、默认值与不抛错语义不改，首缺文件不作为异常。
- 收益/行为风险：保留控制不中断的容错而能定位失败；诊断订阅异常需隔离。
- 验证方式：新增 3 个配置失败/覆盖用例；原生产引用测试待恢复。
- 是否推荐：是，仅增可观测性。

### TD-12：共享截图/OCR 竞争

- 真实性/证据：部分真实；AdbClient.cs:750 截图锁，PaddleOcrEngine.cs:24,49-58 串行 OCR；ScreenFrameCache.cs:68-89 锁及同 FrameId 合并、:99 共享捕获不随单等待者取消；UiPipeline.cs:89 注明串行理由。
- 当前行为/局部修复：已有多层互斥/缓存，不能称“毫无调度”；OCR native inference 启动后不响应 CT；共享截图等待者取消不终止捕获。
- 真实风险/等级：中；不同 FrameId 并发、缓存淘汰和 OCR 原生调用使延迟/释放边界复杂；不能据静态代码确定实际竞争频率。
- 建议/更小方案：先测延迟、同/异帧缓存生命周期，RU-07 只收敛截图适配；不添加万能优先级设备队列。
- 收益/行为风险：消除重复截图实现；取消共享工作/改变锁范围会破坏其它等待者。
- 验证方式：屏幕缓存多等待者、淘汰/Dispose 竞态、原生 OCR 延迟和占用；当前 52 用例不包含 Bitmap/native。
- 是否推荐：专项验证是；统一队列暂不推荐。

### TD-13：视觉样本回放缺失

- 真实性/证据：Resources 中模板存在，但不等于包含正负帧期望值的测试集；AdbClient.cs:461-705 识别依赖截图/OCR，tests 无图像回放。
- 当前行为/局部修复：UiPipeline 测试验证节点次序/超时，不验证视觉准确度。
- 真实风险/等级：中；模板或版本变更无法自动发现误报/漏报。
- 建议/更小方案：RU-10 保存经确认的正/负/近似弹窗帧及 frame provenance；先固定一个检测器，不引入新 OCR 算法。
- 收益/行为风险：检测器改动有回归阈值；合成输入不得充当真实样本，截图隐私需检查。
- 验证方式：固定分辨率、结果、阈值、框、节点优先级；native 环境和模型指纹记录。
- 是否推荐：是，缺素材时登记缺口而不是伪造覆盖。

### TD-14：传送门学习不持久化

- 真实性/证据：真实存储方式，不是已证明缺陷；PortalRouting.cs:117-175,176-230 为内存图；DungeonSession.cs:58-59,92-93 在 Reset/Stop 清空。
- 当前行为/局部修复：按 PortalMapKey 隔离，房间门户可多目的地、相邻落点容忍一格；Key 无地下城实例标识。
- 真实风险/等级：低；持久化反而可能复用另一实例/布局的学习边，收益未得到业务验证。
- 建议/更小方案：保持 run/device 范围，记录观察依据和拒绝原因即可；缓存持久化是新功能、另案评估。
- 收益/行为风险：诊断能重放；跨实例误边风险高。
- 验证方式：新增 PortalLearningBaselineTests 5 用例；尚缺 unlock 相关消失怪物证据及随机多边。
- 是否推荐：保持并测是；持久化否。

### TD-15：快照无显式版本

- 真实性/证据：真实；Models.cs:238 MapDump、:306 PlayerStatus，Lua export 与控制器通过字段约定配合；未发现 schemaVersion 根字段。
- 当前行为/局部修复：缺字段默认值/可选字段保持旧助手兼容；MapSnapshot 是控制器本地元数据，不是设备协议版本。
- 真实风险/等级：中；版本差异诊断弱，但协议重构会同时影响助手及控制器。
- 建议/更小方案：先在本地诊断中记录助手 hash、游戏/模型版本，RU-05 可支持；添加设备字段及停止条件另案，不在本阶段做。
- 收益/行为风险：可追踪组合；强制版本检查会拒绝旧助手。
- 验证方式：旧字段缺失、新可选字段、异常类型；后续协议矩阵另设兼容测试。
- 是否推荐：本地诊断是；强制协议版本暂缓。

### TD-16：Web 回环与认证

- 真实性/证据：前审计推断过度；PipelineWebServer.cs:57 显式绑定 127.0.0.1；:240 检查 trace 文件名，:119 起请求处理。没有当前监听局域网的证据。
- 当前行为/局部修复：端口 17830 起尝试 10 个；GET 与文件名控制已存在，不能说“仅假设回环”。
- 真实风险/等级：低；本机不可信进程仍可读监控，未来非回环部署另当别论。
- 建议/更小方案：测试只能回环、非法路径拒绝、Dispose；不增加监听配置或认证工程扩大暴露面。
- 收益/行为风险：明确默认安全边界；引入认证会改变浏览器访问/工具兼容。
- 验证方式：RU-14 本机 HTTP/path fixture，禁止在验证中开启 LAN。
- 是否推荐：边界测试是；现在改认证/绑定策略否。

### TD-17：大文件与超长函数

- 真实性/证据：文件长真实；Automation.cs:190-512 RunLoop 323 行，Planner.cs:34 起规划深模块、MaaPipeline.cs:134 起 catalog compiler、VisualTemplate.cs:17 起算法与格式，ThemePalette 控件族。
- 当前行为/局部修复：MainForm 已 partial，RouteExecutor 显式输入；长函数中不少是完整算法，不自动等于高风险。
- 真实风险/等级：低；RunLoop 的高风险按 TD-02 处理，不能按行数重复扩大风险。
- 建议/更小方案：命名局部阶段/补 fixture/整理索引，等变化原因明确才搬完整单元；不设“所有函数低于 N 行”验收。
- 收益/行为风险：定位和回归便利；形式拆分会增加隐式状态和跨文件跳转。
- 验证方式：调用序列、图搜索输出或渲染 golden 对比，而不是减行数。
- 是否推荐：相关测试是；单纯拆大文件暂缓。

### TD-18：单程序集和目录约束

- 真实性/证据：真实；AdbMapController.csproj:3-12 单 WinExe 根命名空间，Directory.Build.props 仅配置产物；目前没有编译期分层屏障。
- 当前行为/局部修复：已有 docs/ARCHITECTURE.md 规则，端口允许局部源链接验证，不等于独立 Domain 编译成功。
- 真实风险/等级：低/中（本次定中）；目录容易继续反向耦合，但立即多程序集会扩大 Windows/native 发布验证范围。
- 建议/更小方案：RU-11 建禁止新增反向引用的架构测试/评审 allowlist，已知例外逐项消除；暂不拆程序集/改全部 namespace。
- 收益/行为风险：新增债务及时发现；仅正则扫描不是完整 C# 语义证明，允许迁移阶段例外需说明。
- 验证方式：架构测试负例能失败、例外不可增长；以后如拆程序集必须验证资源和 native 查找。
- 是否推荐：轻量边界守卫是；多程序集不是当前首选。

## 4. 本次补充发现及不可误改点

| ID | 源码证据 | 当前事实 | 风险及下一步 |
| --- | --- | --- | --- |
| B-01 | AdbClient.cs:174,188,199,761,883,965 | RU-01恢复了旧声明；Release构建及测试通过 | 编译阻断已解除；ADB内部仍是新旧双实现，迁移需G1 |
| B-02 | RouteExecutor.cs:81,168；TouchController.cs:31-33,47-48；TouchBackends.cs:84-116 | Down 完成后才记 held；失败途中设备可能收到部分 down；本地 up 清状态先于发包；脉冲锁内不支持取消，急停排队 | 高；纯测试记录缺口，不宣称配对端到端保证；需要真机/后端 fake 明确恢复语义 |
| B-03 | RunLoop:501-510；RunDungeonTaskCore:171-181 | 循环异常被 Error 后吞掉，返回到 handler 时可能仍 Success；取消也可能 Success | 高可观测性/结果歧义；不在结构重构中偷偷改变成功判定 |
| B-04 | MapSnapshot.cs:8-14,46 | record 内 MapDump 是共享可变引用，Player/Level/hash 是捕获值 | 中；不是深不可变快照，已经用测试锁定；以后 immutable 改造需另案 |
| B-05 | MaaPipeline.cs:875-910；PaddleOcrEngine.cs:49-58；ScreenFrameCache.cs:99 | 同 Maa 实例有运行可变字段；原生 OCR 和共享截图不能由单个等待者强停 | 中/高；单实例顺序使用，关闭不能仅取消等待后立即 Dispose |

## 5. 准入结论

RU-01 的源码/build/test准入已完成；标准 publish/native交付未验证且本次按要求未发布。RU-02 的生产引用前置条件已满足，下一步可独立执行；随后 RU-03 小范围归位 RouteSession。ADB transport/capture/assistant、MainForm用例迁移必须通过各自设备/顺序门槛。

本阶段只是准备和基线，未修复上述生产缺陷。推荐不是自动执行；完整可执行顺序、验收和回滚见 REFACTOR_BACKLOG.md。
