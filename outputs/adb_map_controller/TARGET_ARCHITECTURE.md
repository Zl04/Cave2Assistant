# 目标架构：保行为、逐边界深化

这是目标设计，不是当前代码全部已经达到的状态。前置事实和 TD 核验见 REFACTOR_BASELINE.md；任务及门槛见 REFACTOR_BACKLOG.md。RU-01已恢复构建；RU-03/11完成RouteSession归位及中性分类码，Domain的已知反向依赖已消除。ADB/MainForm迁移仍需设备门槛，不能由测试数量替代。

## 1. 最小目标与非目标

继续单进程 WinForms、单程序集及现有根命名空间；用完整用例、明确状态所有权和少量已有能力端口划分模块，不强制 DI 框架/Clean Architecture。

不统一 Pipeline，不更改 JSON 默认值、游戏规则、超时数值、触摸时序或 root 命令格式，不持久化跨实例传送门学习，不为每个类添加 interface。文件短、层数多并非验收指标。

目标依赖（箭头表示使用；实现端口是反向适配，不是业务依赖倒置回窗体）：

```text
Program / ControllerRuntime（组合与进程资源）
  ├─ Presentation ──> Application ──> Navigation ──> Domain
  └─ Infrastructure ──实现已有设备能力端口──> Navigation
          └─ 消费 Domain / 专用 Pipeline DTO

Application 的用例调用注入能力；具体 Infrastructure 只在组合根组装。
Presentation 实现 UI 观察能力，不让 Application/Navigation 持有 Form。
Pipeline runtime <TState> 不构造设备/窗体，不拥有业务 session。
```

单程序集阶段允许 ControllerRuntime 使用具体 Infrastructure（它是组合根）。RU-03/11已清除Domain→Navigation例外，测试用BCL-only编译验证Domain边界；不能由此宣称整个Application/Presentation目标依赖图已经成立。

## 2. 模块责任与迁移边界

### Presentation：控件与用户意图

- 当前职责：控件/绘图/主题/配置映射；MainForm partial 还负责 RunLoop、楼层决策、设备刷新、弹窗交接、任务和取消。
- 目标职责：读取控件形成一次用例输入，展示地图/状态/日志/操作可用性，处理 UI 事件和 WinForms 关闭握手。
- 保留职责：MapPanel、主题、mini window、用户错误提示、控件↔ControllerSettings 映射、UI SynchronizationContext。
- 迁移职责：经覆盖的完整刷新/弹窗/楼层用例进入 Application，纯决策进入 Navigation/Domain；本阶段不搬 RunLoop，不先生成大量代理属性。
- 依赖/接口：Application 用例入口；现有 IRouteExecutionObserver 由 UI adapter 实现。后续只在真实用例需要时形成 `RunAsync(input, token)`/状态观察，不先发布庞大的 IControllerService。
- 状态所有权：控件值、显示选择和 UI-only flags；DungeonSession 不再增加平行业务字段。现有跨用例旗标需先归类，不能一股脑搬进 session。
- 边界门槛：UI 回调只能在 UI 线程运行；迁移不以 Task.Run 包住整个用例。事件次序 fixture 与实际窗体关闭验证齐备后再转移。

### Application：用例编排及运行生命周期

- 当前职责：ControllerRuntime 构造/释放资源，DungeonSession 保存状态，OperationTracker 跟踪 UI 操作；复杂用例仍在窗体。
- 目标职责：一次运行的启动、预检、移动/弹窗交接、停层/等待编排；拥有 run CTS、活动任务及关闭时的等待关系，不计算图搜索。
- 保留职责：现有 Reset/Stop 两个不同清理边界，组合根；不把 ControllerRuntime 扩成业务 God Manager。
- 迁移职责：单个完整用例及其直接状态/CTS 一起迁移；先用事件记录验证，再考虑 RunningOperation 小型所有者。不能先移状态而留下双重 CTS owner。
- 依赖/接口：Domain 状态、Navigation planner/executor、能力端口；Pipeline 的 generic handler 捕获业务用例，不再把 MainForm 当业务 TState（待覆盖后执行）。
- 状态所有权：DungeonSession 是设备/地下城会话的单一业务 owner；run operation 拥有 CTS、watchdog、移动分片、入口任务。终止按原先 Stop/Reset 的差异，不统一为一个 ClearAll。
- 线程模型：第一步保持 UI 调度上下文与串行业务写入；MotionInterruptState 独立锁允许 watchdog 竞争。OperationTracker 明确 confined-to-UI，不暗中承诺任意线程安全。

### Domain：业务数据与不依赖设备的规则

- 当前职责：MapDump/PlayerStatus/RoleInfo/TileInfo、入口/楼层策略、机关访问、图标分类、快照元数据；误含 Navigation 的 RouteSession。
- 目标职责：描述地图/角色/规则/协议容错后的数据，不依赖 Form、ADB、OCR 或任务运行时；门户分类码可在中性业务常量处单一拥有。
- 保留职责：字段名与默认值、RoleInfo.Kind 兼容显示、灵活整数和 TileInfo 只读 converter、MapSnapshot 的当前引用语义。
- 迁移职责：RouteSession 归 Navigation；MapIconCatalog 只依赖中性分类码，而非 PortalRouting 策略。不要把 PlannedInteraction/RoutePlan 全塞进 Domain 消除报表中的“环”。
- 依赖/接口：BCL 数据类型和纯规则；对外 DTO/纯函数；JsonDiagnostics 不成为日志基础设施入口。
- 状态所有权：MapDump 可变实例由 DungeonSession 拥有；MapSnapshot 仅元数据捕获，现有 Map 引用不是深不可变。此阶段不引入复制导致所有权/性能变化。

### Navigation：图搜索、路线会话和移动算法

- 当前职责：Planner、TargetPolicy、PortalRouting/学习图、FloorPlanningPolicy、RouteExecutor、FloorStateMachine、方向映射及 Coroutine；RouteSession 文件错放 Domain。
- 目标职责：给定地图、选项和当前会话生成计划；通过设备端口执行计划并产生 Completed/Replan/InterruptedByPopup，报告结果而非控制 UI 生命周期。
- 保留职责：Planner 深模块、最早交互停靠、过期路线拒绝、脉冲/长按、速度预测/反复横跳、release 后序列复核、PortalJumpGraph 多目的地规则。
- 迁移职责：RouteSession 物理归位；窗体中的纯规划判定可在单独 fixture 后迁入，不先把所有委托换成 interface。
- 依赖/接口：Domain；已有 `IPlayerStatusSource.ReadPlayer()`、`IMovementInput`、`IRouteExecutionObserver`、RouteExecutionContext。继续使用这些真实测试 seam。
- 状态所有权：RouteSession、RouteExecutionRuntime、blocked、门户图属于 DungeonSession；executor 不偷偷缓存一次运行状态。FloorStateMachine 只拥有 Current/诊断，Application 拥有楼层编排。
- 异常/取消：设备异常向用例传播；owner/slice CT 区分；Popup OCE 转为 InterruptedByPopup；finally 保留释放尝试。`ReadPlayer()` 目前没有 CT，不在本阶段改签名掩盖取消延迟。

### Infrastructure/ADB：设备传输与输入后端

- 当前职责：`AdbClient` 是稳定兼容门面；传输/root shell、截图、助手、设备触摸会话、地图/玩家JSON读取、OCR/视觉识别分别由 `AdbCommandTransport`、`AdbScreenCapture`、`AssistantController`、`AdbTouchSession`、`AdbGameDataReader`、`AdbScreenAnalyzer` 持有。门面仍组合逻辑帧缓存与弹窗UI Pipeline结果。
- 目标职责：维持上述单一owner。transport 独占 serial/root shell/marker/process；touch session 独占连接锁、屏幕/旋转参数、backend启动与输入映射；game reader 独占快照文件协议、JSON converter/retry/地图归一；screen analyzer 独占 PaddleOCR 生命周期和截图语义识别；screen capture 独占截图进程及互斥；assistant 独占安装/备份/测试面板协议。
- 保留职责：`AdbClient`公开方法与调用兼容、协作者组合、FrameId/共享帧缓存与Pipeline结果组装；保持异常类型/结果、root/su回退、连接缓存、JSON回退/重试、阈值、坐标和正常/异常调用顺序。
- 迁移职责：本次已将触摸会话、地图/玩家快照读取、OCR/视觉解析迁出。后续只有发现新职责再次聚集且有独立验证收益时才继续拆分；不为降低行数拆散Pipeline帧生命周期或添加纯转发层。
- 依赖/接口：`AdbClient`→上述协作者；touch session→`AdbCommandTransport`及现有触摸backends；game reader→root命令委托；screen analyzer→`PaddleOcrEngine`/模板/视觉识别；popup pipeline继续通过兼容门面访问识别能力。Application 和 `RouteExecutor` 的调用签名不变，`Process` 不泄漏给业务。
- 状态所有权：同一设备 Serial/root session 只由 transport 持有；TouchController 持有逻辑 heldPoint；触摸 backend 持有真实 writer/agent/socket。两者不是同一状态，不能用本地 null 证明物理 up。
- 触摸抽象：保留 IMovementInput；TouchController 未来可依赖小型 touch-device 能力（ready/point/down/up/swipe），前提是协议字节和完整手势锁范围保持。不能机械把门控/映射移进每个后端。
- 安全边界：EmergencyRelease 目前是串行 TouchUp，可能等脉冲结束；加 out-of-band reset 属新语义，需要设备协议评审。Down 部分失败恢复也是另案，不在“抽象”中修复。

### Infrastructure/视觉与共享帧

- 当前职责：AdbClient 组织检测，PaddleOcrEngine 串行 native inference，ScreenFrameCache 合并同帧捕获并克隆 Bitmap，UiPipeline 按节点优先级串行识别。
- 目标职责：用 frameId/捕获时间贯穿单次探测，caller 负责释放返回 clone；保留 OCR 单实例 gate；识别规则与截图适配可单独验证。
- 保留职责：共享捕获不受某一个等待者 CT 终止，OCR native 启动后等待完成；UI 检测顺序和节点 cache；阈值不改。
- 迁移职责：先截图适配接管和回放 fixture，再评估检测组合是否值得从 facade 提取。没有性能证据不建设全局 probe 调度队列。
- 依赖/接口：截图返回受 caller 拥有的 Bitmap；检测返回既有结果 DTO；视觉/native 实现不进入 Domain/Navigation。
- 状态所有权：cache 拥有原帧和进行中的 capture，消费者拥有 clone；OCR 拥有 native runtime。取消等待不等于释放 shared capture 或 native engine。

### Pipeline 运行时：协议语义隔离，不统一调度器

- 当前职责：MAA catalog loader/继承/表达式/compiler、MAA runtime/trace 同文件；TaskPipeline legacy 运行时及 adapter；UiPipeline 单帧识别。
- 目标职责：保留三种语义边界；catalog/compiler 可保持深模块，运行实例只服务一条顺序任务链；通过 handler 注入实际动作，trace 为非关键旁路。
- 保留职责：MAA 候选优先级、父 action→sub→next、次数分支、onErrorNext、JustReturn/Stop、trace 隔离；TaskPipeline entry 跳过识别、节点 retries/cooperative timeout；UiPipeline 超时后 fallback。
- 迁移职责：MainForm handler 的业务 TState 在完整用例迁移时改为 application 用例上下文；先测试实际 JSON 资源，不先拆 parser 的所有私有函数。旧 TaskPipeline 与 adapter 不删。
- 依赖/接口：catalog、generic handler、状态 DTO、CT 和 trace sink；runtime 不拥有 AdbClient/Form/DungeonSession，不在内部更换业务状态。
- 状态所有权：每次运行 executionCounts/taskId/transitions/runId，由该运行独占。当前 Maa 实例非并发安全，先规定 new-per-run/顺序复用，不添加全局静态计数。
- 异常/取消：保持各引擎差异；trace sink 抛错隔离；MAA 的 timeout 不是 action 硬限时，RetryTimes 不代表当前识别循环次数上限。未来硬超时不能靠 WaitAsync 让残余动作继续跑却报告已停。

### 配置、监控与诊断

- 当前职责：ISettingsStore 已隔离持久化，错误吞掉；Web 监控显式回环绑定并有文件名限制；JsonDiagnostics 被 refresh Drain 丢弃。
- 目标职责：保持配置容错，提供有限诊断旁路；Web 只做本机观测，不驱动业务；保存故障来源与 trace/设备/助手指纹。
- 保留职责：Load=null、Save 不抛错及临时覆盖、127.0.0.1、端口回退、trace 订阅失败不影响任务。
- 迁移职责：增诊断而非增停止条件；本机 HTTP 边界测试。字段版本或 LAN/auth 另立功能评审。
- 依赖/接口：ISettingsStore、IMaaPipelineTraceSink 等已有 seam；不要因“分层”再包一层只转发的方法。
- 状态所有权：配置存储仅文件、监控服务持有 listener/live events；业务 session 不依赖诊断保存成功。

## 3. 状态与生命周期矩阵

| 范围 | owner | 创建/启动 | 停止/释放约定 | 不得混淆 |
| --- | --- | --- | --- | --- |
| 进程基础设施 | ControllerRuntime（Program 组合） | 程序启动 | UI 拒收、等待用例后，Touch→Adb→Web 现有顺序 | Dispose 不自动完成触摸急停 |
| 设备/地下城状态 | DungeonSession | 当前 UI/session | 设备切换 Reset；停止 StopAutomation | Stop 保留 map/机关/当前速度，Reset 清掉 |
| 一次跑图/入口 | 当前 MainForm；未来 application operation | 创建 linked owner CT，注册活动 Task | Cancel→release attempt→await work/watchdog→dispose CTS | 完整迁移前不能同时两个 owner |
| 单次路线分片 | ExecuteRouteSlice | owner 创建 linked slice | popup 只取消 slice，finally unregister/dispose | popup 不是整个任务 owner cancel |
| 物理触摸 | backend + TouchController | ready 后发送 | up 需在传输还活着时发送；等待 backend 操作 | heldPoint 非设备真相，失败 down 尚有缺口 |
| 单帧/共享截图 | cache / caller clone | capture + frameId | caller using clone；cache 释放原帧；共享工作需等待 | waiter cancel 不取消共享捕获 |
| Pipeline run | runtime 当前运行 | reset counts/new runId | handler 释放自己的资源；runtime 不释放设备 | 同一 Maa 实例不能并发 RunAsync |
| UI 操作集合 | OperationTracker/UI 上下文 | UI action 注册 | closing 拒收后等当前任务快照 | WhenIdle 不保证未来任务，也不是任意线程屏障 |

## 4. 异常责任与取消传播

```text
用户停/关闭 ──> run/entry owner CTS ──> linked movement slice + handler token
弹窗 watchdog ──> MotionInterrupt.Request ──> cancel slice ──> release ──> 主循环消费
关闭 ──> 禁止新动作 ──> StopMovement ──> UI任务 idle ──> refresh lock ──> runtime dispose
```

- Infrastructure 负责进程 timeout 后 kill、截图释放/锁、root session 失效重置；不可吞掉业务必须看见的错误。保留已明确设计为 fallback 的异常捕获。
- Navigation 将过期、偏离、无新 seq 转 Replan，popup cancel 转 InterruptedByPopup；一般 IO/OCE 不自动变“正常完成”。已有 finally release masking 行为先锁定再单独处理。
- Application 决定继续/重规划/停止；UI 展示。当前 RunLoop 吞异常和 handler Success 的不一致是已记录债务，不趁用例搬迁改变返回值。
- 非关键日志/trace/设置诊断不能再抛异常破坏控制；必须有限队列/速率限制并避免在触摸临界区做磁盘 I/O。
- 不把 CancellationToken.None 全局替换为 owner token；shared capture 和 native OCR 有刻意取消边界。Process/ReadPlayer 缺 CT 的延迟需测量和另案决策。

## 5. 可安全迁移的三个边界

1. RouteSession 文件归位：同 namespace、同字段、同清理方法；原位行为测试，不引入新状态 owner。
2. ADB 子职责：字节/结果/超时/释放对照后一次迁移一个完整 owner；保持 facade，最后才移除对应旧声明与实现。
3. MainForm 用例：先捕获输入和调用序列；一个入口、一个 CTS owner、一个 session、UI adapter；业务未明确前停在测试准备。

使用 codebase-design 的深模块原则：优先真实测试 seam 和完整 owner；对长 Planner/Compiler 保留局部完整性，避免纯粹按行数拆分。
