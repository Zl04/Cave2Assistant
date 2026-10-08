# 全量架构审计与重构记录

> 2026-10-08 第二阶段核验：本文件的“发布成功/测试通过”是历史记录，不能代表当前工作区；当前ADB未完成迁移导致编译失败。逐项核验与真实测试范围见 [REFACTOR_BASELINE.md](../REFACTOR_BASELINE.md)、[REFACTOR_TEST_PLAN.md](../REFACTOR_TEST_PLAN.md)。新计划尚未执行，历史已完成标签不应作为准入依据。

## 审计范围与基线

- 主项目约 60 个 C# 文件、15,555 行生产代码。
- 基线 Release 发布成功；项目原有 `tests/` 目录为空，没有可执行回归测试。
- 重点追踪了启动与释放、设备连接、地图刷新、路线规划、路线执行、楼层状态、弹窗接管、自动进图、挖矿、设置读写和发布路径。
- 本轮不修改 Lua 协议、JSON 字段、Pipeline 配置格式、点击坐标、超时值、事件顺序或公开的游戏业务规则。

## 主要发现

### 1. 表面分层，实际依赖汇聚到窗体

原目录已有 Domain / Navigation / Infrastructure / Presentation，但 `MainForm` 仍有 2,821 行，直接构造基础设施并持有地图、路线、楼层、传送门、弹窗、进图、采矿、配置、Web 监控和异步任务状态。目录无法阻止新增功能继续进入窗体。

处理：引入生产组合根 `ControllerRuntime`，集中基础设施生命周期；引入 `DungeonSession` 和 `OperationTracker`；按用例拆分表现层文件，并记录新增逻辑的放置规则。

### 2. `RouteExecutor` interface 比 implementation 更难理解

原构造函数需要 18 个具体对象或委托，其中多数是对窗体可变字段的 getter/setter。调用方必须知道执行器内部状态需求，测试也只能复制整套窗体状态，属于典型浅模块和隐式依赖。

处理：执行器现在只在构造时依赖 `IPlayerStatusSource`、`IMovementInput` 两个真实 seam；每次执行接收 `RouteExecutionContext`，变化参数集中在 `MovementTuning`，跨次运行状态集中在 `RouteExecutionRuntime`。日志/UI 更新经 `IRouteExecutionObserver` 返回表现层。

### 3. 配置和资源路径是全局静态依赖

原配置存储是静态类，窗体自行拼接 `AppContext.BaseDirectory`。这使失败语义难以测试，也让发布结构知识散落到表现层。

处理：使用 `ISettingsStore`/`JsonSettingsStore`；发布资源路径集中到 `ApplicationPaths`。旧配置 JSON、默认值和失败吞吐语义保持不变。

### 4. 运行状态没有单一所有者

设备切换和急停分别手工清理大量字段，新增状态很容易只在一处清理，形成跨运行泄漏。

处理：`DungeonSession.Reset()` 定义设备切换边界，`StopAutomation()` 定义保留当前地图的急停边界。路线、楼层、传送门、目标和移动运行状态不再由窗体平行持有。

### 5. 测试基础缺失

原重构计划声称存在回归测试，但仓库中的 `tests/` 实际为空。

处理：建立 xUnit 项目，当前覆盖：配置往返/损坏文件、过期路线拒绝输入、单格路线通过注入端口执行、异步操作跟踪、地下城会话重置。

## 继承与抽象审查

- 业务层没有需要保留的继承树；本轮没有引入业务基类。
- WinForms 的 `Form`、`Panel`、`TabControl`、输入控件继承用于框架绘制和消息生命周期，具有真实行为，保留。
- ADB 和触摸使用组合；路线执行依赖能力端口，不继承具体设备类。
- 纯函数策略（`TargetPolicy`、`FloorPlanningPolicy`、`DirectionMapper` 等）保持静态，不为“可注入”而制造只有一个 adapter 的 interface。
- `ControllerRuntime` 只拥有三个进程级依赖，不承载业务决策，避免形成新的 God Manager。

## 行为保持依据

- 路线循环主体、延时、速度预测、受阻判定、弹窗中断和最终坐标复核未改算法，仅将数据访问改为上下文/端口。
- `JsonSettingsStore` 保持文件不存在或解析失败返回 `null`、临时文件覆盖、保存失败不抛出的原语义。
- `MainForm` 拆分按完整方法边界移动，方法体、事件绑定和调用顺序未变。
- `DungeonSession.StopAutomation()` 按原急停字段清单迁移；地图保留行为不变。
- 每个完整边界迁移后均执行 Release 构建和回归测试。

## 有意保留的结构

- `Planner` 和 MAA Pipeline 仍是独立的深模块：前者集中图搜索，后者集中协议解析与运行语义。仅因文件较长继续拆分会增加跨文件跳转，没有产生新的 seam，因此本轮不做形式化拆分。
- `AdbClient` 继续作为设备 facade，内部聚合连接、截图、辅助脚本和弹窗识别。它仍是下一轮最值得深化的模块，但在没有第二种设备 adapter、且外部行为依赖真实设备的情况下，本轮不把每个方法机械包装成 interface。
- `MainForm` 仍负责复杂用例编排，但状态和基础设施所有权已外移，文件按用例分开。后续可在真实设备回归覆盖扩大后，将 `Automation` 与 `Planning` 中的完整流程继续迁入 Application。

## 剩余风险

- 单程序集和统一根命名空间尚不能在编译期阻止反向依赖；当前依靠目录规则、组合根和评审约束。
- 弹窗 OCR、自动进图、采矿和长路线仍需要真实设备端到端验证；单元测试不能替代设备时序验证。
- `AdbClient`、`MaaPipeline`、`ThemePalette` 文件仍较大，但分别聚合设备 facade、协议运行时和 WinForms 主题控件族；应按真实变化 seam 深化，避免只为缩短文件制造浅包装。
