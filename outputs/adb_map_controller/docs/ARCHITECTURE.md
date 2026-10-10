# 架构说明

> 2026-10-09 执行更新：ADB职责已进一步拆分。`AdbClient`作为兼容门面，分别委托`AdbCommandTransport`、`AdbScreenCapture`、`AssistantController`、`AdbTouchSession`、`AdbGameDataReader`和`AdbScreenAnalyzer`；弹窗帧缓存及Pipeline结果组装仍由门面协调。MainForm仍承载应用用例编排。当前实测见 [REFACTOR_BASELINE.md](../REFACTOR_BASELINE.md)，逐单元状态见 [REFACTOR_EXECUTION_REPORT.md](../REFACTOR_EXECUTION_REPORT.md)，目标见 [TARGET_ARCHITECTURE.md](../TARGET_ARCHITECTURE.md)。

本文是新开发者理解和扩展项目的入口。项目采用单进程 WinForms 架构，但代码按变化原因分为五类模块；目录表达依赖方向，不用无意义的基类或通用 Manager 隐藏业务。

## 依赖方向

```text
Program（组合根）
  └─ Presentation（窗体、绘制、主题）
       └─ Application（运行期组合、会话、操作生命周期）
            ├─ Navigation（规划、路线执行、楼层状态）
            ├─ Domain（地图、角色、入口等业务模型）
            └─ Infrastructure（ADB、OCR、视觉、文件、Web）

Infrastructure ──实现──> Navigation 中的设备端口
Presentation   ──实现──> Navigation 中的路线观察端口
```

约束：

- `Domain` 不创建 ADB、文件、Web、WinForms 控件或 OCR 对象。
- `Navigation` 的可变业务逻辑通过显式输入和端口工作，不依赖窗体控件。
- `Infrastructure` 负责外部 I/O 和第三方库适配，不决定路线或楼层业务。
- `Presentation` 读取控件、展示状态和转发用户意图，不拥有基础设施的构造与释放。
- `Program` 是唯一的生产组合根；新增外部依赖应先在这里或 `ControllerRuntime` 中组装。

## 关键模块

### `ControllerRuntime`

进程生命周期基础设施的所有者，集中构造和释放 `AdbClient`、`TouchController` 与 `PipelineWebServer`。`ApplicationPaths` 集中描述发布目录内的设置、Pipeline、追踪和助手资源路径。

### ADB facade与owner

`AdbClient`保留现有应用调用面并组合ADB基础设施，不再直接持有触摸会话、游戏快照解析或OCR模型状态。`AdbTouchSession`拥有连接/触摸backend及屏幕映射；`AdbGameDataReader`拥有地图/玩家JSON文件协议与解析；`AdbScreenAnalyzer`拥有PaddleOCR和截图识别。Transport、capture、assistant的owner保持独立。共享弹窗帧的FrameId缓存和单帧Pipeline结果汇总暂留在facade，避免拆散生命周期。

### `DungeonSession`

连接设备和一次地下城运行共享的可变状态所有者，包括地图、路线会话、楼层状态、传送门图、已完成目标和移动执行状态。切换设备调用 `Reset()`；急停调用 `StopAutomation()`。不要在窗体中再增加平行的路线或楼层字段。

### `RouteExecutor`

路线移动的深模块。稳定 interface 是：

- 构造时提供 `IPlayerStatusSource` 和 `IMovementInput`；
- 每次执行提供 `RouteExecutionContext`；
- 返回 `RouteExecutionResult`。

执行上下文显式包含地图、路线、移动参数、运行状态和观察端口。生产环境由 ADB/触摸 adapter 实现设备端口，测试使用内存 adapter。不要重新加入指向窗体字段的大量 `Func<>`/`Action<>` 参数。

### `ISettingsStore`

配置持久化 seam。`JsonSettingsStore` 保留旧行为：文件不存在或损坏时返回 `null`，保存使用临时文件覆盖，写入失败不影响控制流程。窗体只负责控件与 `ControllerSettings` 的映射。

RU-05增加可选失败诊断，组合根接入NonCriticalDiagnostics：全局30秒节流、100条环形保留、512字符上限，不写磁盘。地图刷新继续Drain现有JSON诊断，送到同一旁路而非移动日志。监控启动后可通过本机GET `/api/diagnostics`读取；缺文件静默、订阅失败不影响控制。Pipeline差异契约见 [PIPELINE_CONTRACTS.md](PIPELINE_CONTRACTS.md)。

### `MainForm` partial 文件

`MainForm` 仍是 WinForms 事件协调器，但按用例拆分，避免单文件承载全部知识：

| 文件 | 职责 |
| --- | --- |
| `MainForm.cs` | 控件、布局、设置映射、生命周期 |
| `MainForm.DeviceMap.cs` | 设备扫描、地图与覆盖层快照 |
| `MainForm.Planning.cs` | 目标选择、楼层策略、路线规划 |
| `MainForm.Movement.cs` | 点击导航、移动任务和中断 |
| `MainForm.Entry.cs` | 地下城入口识别与校准 |
| `MainForm.Automation.cs` | 主 Pipeline 和楼层运行循环 |
| `MainForm.Popups.cs` | 换层/宝石弹窗、急停、状态输出 |
| `MainForm.Mining.cs` | 挖矿流程 |
| `MainForm.Assistant.cs` | 助手安装、恢复和测试面板 |

partial 只用于组织同一个表现层协调器；新的可复用业务逻辑不得继续堆入 partial，应进入 `Domain`、`Navigation` 或 `Application`。

## 常见扩展方式

- 新增规划目标：先扩展 `TargetKind`/`TargetPolicy`，再调整 `Planner`；不要在窗体散落新的中文字符串判断。
- 新增移动策略：扩展 `MovementTuning` 或在 `RouteExecutor` 内形成局部策略；设备调用继续只经过两个端口。
- 新增设备输入后端：实现现有触摸 backend 或 `IMovementInput`，不要让规划层识别 ADB 命令。
- 新增配置项：加入 `ControllerSettings`，在窗体设置映射中读写；保持旧 JSON 缺字段时的默认值。
- 新增 Pipeline 节点：优先配置 JSON 和已有 handler；只有需要强类型地图决策时才进入 Navigation。
- 新增外部资源路径：加入 `ApplicationPaths`，不要在窗体中新增 `AppContext.BaseDirectory` 拼接。

## 验证

- `dotnet test tests/AdbMapController.Tests.csproj -c Release`
- 发布前先终止 `publish/` 下正在运行的程序，再执行 `dotnet publish AdbMapController.csproj -c Release`。
- 所有中间输出位于各项目自己的 `publish/.build/`；交付完成后清理 `.build/`，最终程序固定为 `publish/洞窟地图控制器.exe`。

路线执行测试通过内存端口验证 interface 行为；设置测试冻结 JSON 与失败语义；会话测试冻结重置边界。新增行为应优先在这些 seam 上测试，而不是穿透实现细节。

## 审计后当前实现补充（2026-10-09）

Application 的纯用例包括 ControllerOperations、MovementExecution、DungeonSnapshotUseCase 和 NavigationStartupUseCase；ControllerRuntime 是资源组合边界。MainForm 读取控件、展示结果并继续承载部分游戏流程，但不再持有运行取消源或移动片段取消源。

DungeonSession 持有业务状态，ControllerOperations 持有互斥自动化任务及运行取消源，MovementExecution 持有单次移动片段，TouchController 持有接触的不确定状态。Infrastructure 分别实现 IGameSnapshotSource、ITouchTransport 和 IMovementInput。纯 Application/Navigation/Domain 由 BCL-only 编译守卫验证。

MaaPipeline 的任务定义/编译、契约/trace、运行会话和 legacy 适配分文件；每次运行拥有独立 Execution 状态。TaskPipeline 和 UiPipeline 的不同语义继续保留。共享帧缓存拥有缓存持有及读者持有，Clear 开启新设备代次。

详细变更、故障行为变化和未完成的设备验证见 [FULL_REFACTOR_REPORT.md](../FULL_REFACTOR_REPORT.md)。本节描述当前源码，前面的历史记录不应被解释为本轮真机验收。
