# 架构说明

> 2026-10-08 第二阶段：下文描述部分既有边界及设计约束，不表示当前迁移全部完成。ADB新组件未接管旧调用，主项目目前无法编译；MainForm仍承载用例编排，Domain存在Navigation反向引用。当前实测见 [REFACTOR_BASELINE.md](../REFACTOR_BASELINE.md)，待执行目标见 [TARGET_ARCHITECTURE.md](../TARGET_ARCHITECTURE.md)。

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
