> 2026-10-13 清理更新：已移除旧 TaskPipeline 执行器/适配器、旧模板采样字段及扫描实现、旧进图配置和编号迁移。以下历史分析中的相应风险及源码路径不再适用于当前实现。

# adb_map_controller 项目说明书与风险审计

> 第二阶段核验（2026-10-08）：本文为第一阶段静态分析，TD 风险和建议不是已验证事实。当前源码完整构建失败（ADB迁移缺失声明），独立源码子集52用例通过不等于主程序通过；非法状态拒绝、收紧JSON容错、门户持久化及Web认证等建议须按 [REFACTOR_BASELINE.md](../REFACTOR_BASELINE.md) 的逐项结论修正。执行范围与顺序以 [REFACTOR_BACKLOG.md](../REFACTOR_BACKLOG.md) 为准，尚未启动生产重构。

分析基线：2026-10-08。范围为 `outputs/adb_map_controller` 的源码、资源、测试和现有设计文档；排除了 `publish/` 运行时发布副本，未把 APK 反编译产物视为控制器源码。

当前规模：75 个生产 C# 文件、约 16,212 行生产代码；5 个测试 C# 文件、186 行测试代码。项目是单程序集 .NET 8 WinForms 程序，运行目标为 Windows x64，通过 ADB 控制 Android 游戏，并依靠设备端 Lua 助手导出地图和人物状态。

## 结论摘要

- 业务主线是“设备连接 → 读取 Lua 导出的地图/人物 JSON → 规划路线 → 触摸执行 → 弹窗接管/重新规划 → 传送门或楼层转场”。
- 目录已经表达出 Domain、Navigation、Infrastructure、Presentation、Application 五类职责，但所有代码仍在同一个程序集、同一个根命名空间，编译器不能阻止反向依赖。
- 已确认一个逻辑层循环：`Domain/RouteSession.cs` 持有 `Navigation/Planner.cs` 定义的 `PlannedInteraction`、`TargetKey`，而 `Planner` 又依赖 Domain 地图模型。这是当前最明确的架构风险。
- 控制器没有关系型数据库、SQLite 驱动、迁移脚本或 `CREATE TABLE`。持久化全部是 JSON、图片、Lua 和 Pipeline 资源；因此“数据库表清单”为 0，下面提供实际 JSON 数据契约作为替代说明。
- 最大风险集中在 `MainForm` 运行循环、`AdbClient` 设备门面、`MaaPipeline`/`TaskPipeline` 双运行时、视觉/OCR/触摸的真实设备时序，以及大量依赖游戏版本的常量。
- 现有测试覆盖配置存取、会话重置、路线执行端口和异步操作跟踪，但没有覆盖真实 ADB、触控后端、OCR、弹窗、入口识别、传送门学习、挖矿和楼层转场。

## 1. 整体架构分层

架构图：

![adb_map_controller 架构图](diagrams/architecture.svg)

源图：[architecture.mmd](diagrams/architecture.mmd)。

### 1.1 分层职责

| 层 | 主要目录/文件 | 职责 | 主要输出或依赖 |
| --- | --- | --- | --- |
| 进程入口 | `Program.cs` | 初始化 OpenCV/PaddleOCR、注册 UI/后台异常边界、创建运行时和主窗体 | `ControllerRuntime`、`MainForm` |
| Presentation | `Presentation/MainForm*.cs`、`MapPanel.cs`、`MiniMapForm.cs`、`Theme*.cs` | WinForms 控件、用户操作、跑图循环编排、地图绘制、状态和日志展示 | 调用 Application、Navigation、Infrastructure |
| Application | `Application/ControllerRuntime.cs`、`DungeonSession.cs`、`OperationTracker.cs` | 进程级资源生命周期、一次设备/地牢运行的可变状态、UI 异步操作跟踪 | 持有 ADB、触摸、Web 监控；聚合 Domain/Navigation 状态 |
| Domain | `Domain/Models.cs`、`MapSnapshot.cs`、`RouteSession.cs`、`FloorMechanismState.cs`、`DungeonEntry.cs`、`CardFloorPolicy.cs` | 地图、角色、目标、楼层策略、快照和运行状态模型 | 被 Navigation、Presentation、ADB JSON 解码使用 |
| Navigation | `Navigation/Planner.cs`、`RouteExecutor.cs`、`FloorStateMachine.cs`、`MiningPlanner.cs` | 图搜索、目标选择、路线执行、楼层状态、传送门和挖矿策略 | 依赖 Domain；通过 `IPlayerStatusSource`/`IMovementInput` 使用设备能力 |
| Infrastructure/Adb | `AdbClient.cs`、`AdbCommandTransport.cs`、`AdbScreenCapture.cs`、`Touch*.cs` | ADB 进程、持续 root shell、截图、触摸后端、设备状态读取 | Android 游戏、Lua 助手、Navigation 端口 |
| Infrastructure/Automation | `MaaPipeline.cs`、`TaskPipeline.cs`、`UiPipeline.cs`、`VisionPipeline.cs`、`OpenCv*.cs`、`PaddleOcr*.cs` | Pipeline 解析/运行、视觉匹配、OCR、入口识别、弹窗识别和看门狗 | ADB 截图/触摸、JSON Pipeline 资源 |
| Infrastructure/Patching | `AssistantController.cs`、`LuaAssistantPatcher.cs` | 读取、安装、恢复设备端 `MiniMapDrawer` Lua 助手 | root shell、Lua 加密/解密、远端备份 |
| Infrastructure/Web | `PipelineWebServer.cs` | 回环地址只读的 Pipeline 监控页面和追踪文件服务 | `pipeline-traces/*.json`、`web/pipeline.html` |
| Configuration | `ControllerSettings.cs`、`SettingsStore.cs` | `settings.json` 的加载、保存和 UI 设置模型 | 文件系统 |

### 1.2 实际依赖方向

```text
Program
 ├─> ControllerRuntime ──> AdbClient ──> ADB / Android 游戏 / Lua 助手
 │                      ├─> TouchController
 │                      └─> PipelineWebServer ──> pipeline-traces/*.json + web/
 └─> MainForm
       ├─> DungeonSession / OperationTracker / ControllerSettings
       ├─> Planner / RouteExecutor / FloorStateMachine
       ├─> AdbClient / TouchController / PopupWatchdog / EntryAutomation
       └─> MapPanel / MiniMap / Theme / JsonSettingsStore

Navigation ──> Domain 地图和目标模型
Infrastructure.AdB ──> Domain JSON 模型 + Navigation 的设备端口
Infrastructure.Automation ──> AdbClient + OpenCV/PaddleOCR + JSON Pipeline
Domain.RouteSession ──> Navigation.Planner 中的 PlannedInteraction/TargetKey  [反向依赖]
```

`ControllerRuntime` 是组合根，集中创建和释放 `AdbClient`、`TouchController`、`PipelineWebServer`。`DungeonSession` 已经收拢了大部分单次运行状态，但弹窗、入口、取消令牌和部分楼层控制标志仍保留在 `MainForm`，所以状态所有权尚未完全闭合。

### 1.3 循环依赖标记

#### 已确认：Domain ↔ Navigation，风险高

- `Domain/RouteSession.cs:12` 的 `Interactions` 类型为 `List<PlannedInteraction>`，`PlannedInteraction` 和 `TargetKey` 定义在 `Navigation/Planner.cs:15-16`。
- `Navigation/Planner.cs` 同时使用 `MapDump`、`TileInfo`、`RoleInfo`、`Cell` 等 Domain 类型。
- 结果是 Domain 状态模型不能独立复用，未来拆程序集或单独测试 Domain 时会被 Navigation 拖入。

建议把 `TargetKey`、`PlannedInteraction`、`RoutePlan` 迁到 Domain/Navigation.Contracts，或让 `RouteSession` 只持有一个独立的路线数据契约。

#### 已确认：运行时回调环，风险中高

`MainForm → RouteExecutor → IRouteExecutionObserver(MainForm)`，以及 `MainForm → PopupWatchdog → Action/Func 回调(MainForm)`。这不是 C# 程序集循环，但会形成 UI、取消令牌、触摸释放、弹窗锁存之间的重入路径；新增回调时容易出现重复释放、重复刷新或异常覆盖。

#### 未发现：直接的数据库/服务层循环

静态检索未发现 Infrastructure 反向调用 Planner 决策的直接代码；ADB 和视觉模块实现 Navigation 端口属于适配器依赖，不应再向 Navigation 加入具体 UI 或游戏流程判断。

## 2. 数据流走向

运行时数据流图：

![adb_map_controller 运行时数据流](diagrams/runtime-flow.svg)

源图：[runtime-flow.mmd](diagrams/runtime-flow.mmd)。

### 2.1 启动和连接

1. `Program.Main` 将当前目录切到发布目录，注册 `UnhandledException`、`UnobservedTaskException` 和 WinForms `ThreadException`。
2. 初始化 PaddleOCR/OpenCV，创建 `ControllerRuntime` 和 `JsonSettingsStore`，再创建 `MainForm`。
3. `MainForm.Scan` 调用 `AdbClient.Devices()` 执行 `adb devices`。
4. `ConnectAsync` 负责设备序列号切换、`adb root`/root shell 检查、屏幕尺寸和 Android SDK 检测，并按版本优先尝试 MaaTouch 或 minitouch。
5. 设备掉线会调用 `AdbClient.Disconnect()` 和 `DungeonSession.Reset()`，清理设备级触摸/地图/路线状态。

### 2.2 地图读取、规范化和规划

1. `AdbClient.ReadMap()` 从设备应用目录读取 `codex_map_dump.json`，`ReadPlayer()` 读取 `codex_player_status.json`。读取通过持续 root shell 传输，优先 Base64，最多重试 JSON 解析 20 次。
2. `MapDump` 经过 `FlexibleIntConverter`、`TileInfoConverter` 容错解码；`AllExplored` 或 Tile 的 `Reached` 会被转换成控制器的 `Explored`。
3. `RouteExecutor.ApplyPlayerStatus` 将人物坐标、速度、迷雾和混乱方向合并到地图；`MapSnapshot.Capture` 生成结构 hash 和导航 hash。
4. `Planner` 根据 `PlanOptions` 和 `DungeonSession` 中的 blocked/已完成目标生成 `RoutePlan`：路线、交互点、目标集合、不可达目标和失败原因。
5. `MainForm` 将路线写入 `DungeonSession.Route`，同时更新 `MapPanel` 和状态栏。

### 2.3 移动执行和闭环重规划

1. `RouteExecutor.ExecuteDetailed` 先校验路线起点是否等于当前人物坐标；过期路线不发送触摸输入，直接返回 `Replan`。
2. 直线段使用按住方向并按速度预测提前/延迟释放；单格或检测到来回横跳时切换为脉冲模式。
3. 每个分段循环读取 `PlayerStatus`，更新坐标、速度、迷雾和地图显示；停滞、偏离路线、序列号未更新或释放后坐标不一致都会触发重规划。
4. `MainForm.RunLoop` 在路线结束时执行目标交互、战斗、传送门、楼层转场、挖矿和停层策略，然后重新读取权威地图。

### 2.4 弹窗并行流

`PopupWatchdog` 每 120ms 轮询截图和 `popup-watchdog.json` 定义的 UI Pipeline，识别服务器错误、秘境宝石选择和下一层对话框。检测到覆盖层后：

- 请求取消当前移动分片；
- 尝试紧急释放触摸；
- 将 `MotionInterrupt` 锁存给主循环；
- 主循环转入 `SelectBonus`、宝石处理或停止运行；
- 处理完成后从最新的设备状态重新规划。

看门狗不会自行点击弹窗，避免后台线程绕过楼层状态机直接改变游戏流程。

### 2.5 进图、补丁和监控流

- 自动进图：`DungeonEntryAutomation.RunAsync` 读取 `dungeon-entry-pipeline.json`，用模板/OCR/特定 Handler 完成主城地图打开、地图卡片、难度、层数和挑战确认。
- 助手补丁：`AssistantController` 查找设备端 `MiniMapDrawer.luac`，读取/解密/检查原版备份，应用 `MiniMapDrawer.template.lua`，再写回远端并验证注入标记。
- 监控：MAA Pipeline 事件经过 `MaaPipelineTraceCollector` 和 `PipelineWebServer`，落盘到 `pipeline-traces/*.json`，回环 HTTP 页面只读展示。

## 3. 模块依赖与接口清单

### 3.1 稳定的内部端口

| 接口/契约 | 定义位置 | 实现/使用 | 作用 |
| --- | --- | --- | --- |
| `IPlayerStatusSource` | `Navigation/RouteExecutionContracts.cs:6` | `AdbClient` | 路线执行期间读取人物坐标、速度、序列号和迷雾 |
| `IMovementInput` | `Navigation/RouteExecutionContracts.cs:11` | `TouchController` | TouchDown、TouchUp、ChangeDirection、PulseOneCell |
| `IRouteExecutionObserver` | `Navigation/RouteExecutionContracts.cs:19` | `MainForm` | 路线状态、日志、地图重绘回调 |
| `ISettingsStore` | `Configuration/SettingsStore.cs:9` | `JsonSettingsStore` | 配置加载/保存和失败语义 |
| `IAndroidTouchBackend` | `Infrastructure/Adb/TouchBackends.cs:8` | MaaTouch、minitouch | 触摸协议适配；内部可替换 |
| `IMaaPipelineHandler<TState>` | `Infrastructure/Automation/MaaPipeline.cs` | ADB、领域、委托 Handler | MAA 节点识别和动作执行 |
| `IMaaPipelineTraceSink` | `Infrastructure/Automation/MaaPipeline.cs` | 文件收集器、Web、多路复用器 | Pipeline 运行诊断输出 |
| `UiPipelineNode<TFrame,TValue>` | `Infrastructure/Automation/UiPipeline.cs` | 弹窗识别 | 对一帧图像按顺序识别节点、重试和超时 |

### 3.2 主要业务入口

| 入口 | 调用意义 |
| --- | --- |
| `MainForm.Scan` / `ConnectDeviceAsync` | 扫描设备并建立 ADB/触摸会话 |
| `MainForm.RefreshMap` | 串行化地图/人物刷新，避免 WinForms Timer 重叠启动 ADB 进程 |
| `Planner.PlanFull` | 按目标、探索、机关、Boss 和楼层策略规划完整路线 |
| `Planner.PlanExploration` | 以视野覆盖收益为目标探索未探索区域 |
| `Planner.PlanMonsterHunt` | 6101 特殊房间只规划可见怪物 |
| `Planner.PlanToPortal` / `PlanToRoomPortal` | 规划层间或层内传送门路线 |
| `Planner.PlanToTarget` | 响应地图点击导航 |
| `RouteExecutor.ExecuteDetailed` | 执行路线、复核坐标和决定是否重规划 |
| `DungeonEntryAutomation.RunAsync` | 视觉/OCR 自动进图 |
| `AdbClient.GetAssistantStatus` / `InstallAssistant` / `RestoreAssistant` | 助手检测、安装、恢复 |
| `PipelineWebServer` | 提供本地只读 Pipeline 监控 API |

### 3.3 Web 接口

服务器默认绑定 `127.0.0.1:17830`，端口占用时最多尝试后续 10 个端口。只有 GET 路由：

| 路径 | 返回 |
| --- | --- |
| `/`、`/index.html` | `web/pipeline.html` |
| `/api/health` | `{ ok, url, now }` |
| `/api/live` | 当前 RunId、运行状态、最近最多 2000 个事件 |
| `/api/runs` | `pipeline-traces/map-run-*.json` 摘要列表 |
| `/api/runs/{fileName}` | 经过文件名校验后的单次追踪详情 |

当前是回环只读服务，没有认证；它不应被改造成远程控制入口而继续复用现有监听器。

### 3.4 ADB 外部接口

控制器使用的外部命令包括：`adb devices`、`adb root`、`adb wait-for-device`、`adb shell id`、`adb shell wm size`、`adb shell getprop`、`adb shell dumpsys input`、`adb push`、`adb pull`、`adb forward`、`adb shell input keyevent`，以及持续 root shell 中的文件读取、复制、删除和临时文件写入。

这些命令不是通用 Android API，而是对当前游戏包路径、root 能力、触控 agent 和 Lua 助手协议的强绑定。

## 4. 数据模型、持久化和数据库结论

### 4.1 数据库表结论

| 检查项 | 结论 |
| --- | --- |
| `outputs/adb_map_controller` 内 SQLite/数据库驱动 | 未发现 |
| `CREATE TABLE`、SQL migration、ORM DbContext | 未发现 |
| 控制器关系型数据库表 | 0 张 |
| 控制器持久化方式 | JSON 文件、Pipeline JSON、图片模板、Lua 脚本和运行追踪 |
| 硬编码 SQL | 控制器范围内未发现 |

仓库其它 APK/Lua 反编译资料中确实存在 `sqlite3` 辅助函数和厂商埋点表，但它们不是 `adb_map_controller` 的数据访问代码，表名和字段也不是控制器业务契约，不能混入本项目的表说明。若后续要审计 APK 内 SQLite，应另立“游戏端/第三方 SDK 数据库审计”范围。

### 4.2 实际持久化文件

#### `settings.json`

由 `JsonSettingsStore` 负责读写；保存使用 `.tmp` 临时文件替换。缺文件、JSON 损坏、读取或写入异常均返回空/静默忽略。

| 字段组 | 字段 | 含义与约束 |
| --- | --- | --- |
| 外观 | `Theme`、`AlwaysOnTop` | 主题模式和窗口置顶 |
| 目标 | `AttackBoss`、`Monsters`、`Elites`、`Chests`、`Pots`、`Bones`、`Gold`、`Runes`、`Chambers` | 规划器目标开关；Boss 默认开启，其余按 UI 选择 |
| 挖矿 | `MiningTileWidth`、`MiningTileHeight`、`MiningInterval`、`Mining`、`CardMining` | 点击网格、间隔和自动匹配卡矿 |
| 移动 | `SingleCellPulseHold`、`MovementReleaseLead`、`InteractionHold`、`StallTimeout` | 正负 `MovementReleaseLead` 分别表示提前释放/到达后延迟释放；数值范围由控件限制 |
| 楼层 | `NewFloorStartDelay`、`RouteRecoveryAttempts`、`TargetStopFloor`、`CardLayer` | 换层等待、恢复次数、目标层；0 表示不启用目标层停止 |
| 进图 | `EntryMapId`、`EntryId`、`EntryDifficulty` | 难度由 `EntryDifficulty` 指定；地图/入口 ID 来自 `DungeonEntryCatalog` |
| 传送门 | `BonusPriority` | 贪婪抉择加成优先级列表 |
| 设备 | `Device` | 上次选中的 ADB 序列号 |

#### `codex_map_dump.json` → `MapDump`

这是设备端 Lua 助手导出的权威地图快照，不是本地数据库表。

| 字段 | 含义 | 业务约束 |
| --- | --- | --- |
| `width`、`height` | 地图尺寸 | 与 `tiles` 坐标和人物状态尺寸应一致 |
| `level` | 当前层/特殊房间编号 | `6101` 被识别为只打怪的特殊房间 |
| `sceneType` | 场景类型 | `1` 代表城镇地图路径，城镇图标坐标可能不是角色逻辑坐标 |
| `caveMode` | 特殊地图模式 | 被 `CardFloorPolicy` 用于卡层上限 |
| `mapName` | 游戏本地化地图标题 | 与 `level/width/height/caveMode` 一起作为传送门学习的地图键 |
| `timestamp` | 助手导出时间/版本序列信息 | 用于诊断，不直接作为路线版本号 |
| `player` | `PlayerInfo {x,y}` | 规划起点和路线停靠点复核依据 |
| `inBattle`、`isDead`、`confused` | 战斗、死亡、混乱状态 | `inBattle` 会强制停止移动；混乱方向由 `confuseDirections` 配套使用 |
| `allExplored` | 游戏全图可见信号 | 为 true 时所有可通行格视为已探索 |
| `confuseDirections` | 混乱时随机方向顺序 | 混乱结束时必须清空旧方向，避免复用旧映射 |
| `bossSeal` | 守层 Boss 封印/预警 | 未 `ready` 前，Boss 不应成为可执行攻击目标 |
| `townIcons` | 城镇图标显示坐标和资源标识 | 通过 Sprite/Template 与逻辑角色匹配 |
| `tiles` | 二维 Tile 列表 | Tile 坐标应唯一；`MapDump.ByCell` 重复坐标会抛异常 |

#### `TileInfo`、`RoleInfo` 和占位关系

| 对象 | 字段 | 含义 |
| --- | --- | --- |
| `TileInfo` | `x`、`y` | 地图格坐标 |
| `TileInfo` | `terrainType` | `0` 才可能是地面；其它值视为不可走地形 |
| `TileInfo` | `explored`、`reached`、`reachable` | 当前快照探索、服务器已到达、可达标记；最终 `Walkable = terrainType == 0 && reachable` |
| `TileInfo` | `roles` | 该格的逻辑角色列表 |
| `TileInfo` | `placeholders` | 多格角色、对话范围或占位格；Trigger NPC 可通过 `associatedX/Y` 指回逻辑格 |
| `RoleInfo` | `className`、`roleType`、`minimapType` | 游戏角色类别和小地图类型，是 `Kind` 推导的原始信号 |
| `RoleInfo` | `spriteID`、`templateID` | 图标/资源匹配标识 |
| `RoleInfo` | `transdoorType`、`isRandomTransfer`、`locked` | 传送门模式、是否随机、是否锁定 |
| `RoleInfo` | `treasureType` | 罐子、石堆、木箱、金箱等资源类型 |
| `RoleInfo` | `occupyWidth/Height`、`talkRange` | 多格占用和交互范围 |
| `RoleInfo` | `opened`、怪物布尔标记 | 已开启交互物和普通/群怪/精英/Boss 分类 |
| `RoleInfo.Kind` | 派生字段 | 通过 `MapIconCatalog` 和 `className/roleType/treasureType` 映射成中文业务目标，不是原始 JSON 字段 |

关系和约束：

- `MapDump.tiles[*].roles` 是 Tile 到 Role 的一对多关系；Role 没有独立主键，实际定位依赖所在 Tile 坐标及 Sprite/Template 等组合信息。
- `MapPlaceholderInfo.associatedX/Y` 指向真实逻辑 Tile；点击显示位置前要调用 `MapDump.ResolveInteractiveCell`。
- 城镇 `TownIconInfo` 只存显示位置，`Matches(RoleInfo)` 通过 SpriteID 或 TemplateID 找回逻辑角色。
- `RoleInfo.Kind` 是规划器和 UI 共同使用的字符串兼容层，改动映射会同时影响绘制、目标选择和交互。
- `opened && TriggerNpcData && roleType in {2,3,8}` 会返回空 Kind；已开启资源可能因此从目标集中消失。

#### `codex_player_status.json` → `PlayerStatus`

| 字段 | 含义 | 约束 |
| --- | --- | --- |
| `level` | 人物所在层 | 必须与 MapDump 层一致，跨层状态不会覆盖旧地图 |
| `width`、`height` | 迷雾位图尺寸 | `fogBits.Length` 应等于 `width * height` |
| `fogBits` | 每格可见位图 | `1` 或 `allExplored` 会更新 Tile.Explored |
| `allExplored` | 全图可见 | 覆盖逐格 fog 判断 |
| `sequence` | 人物状态序列号 | 路线释放后必须看到新序列，防止旧快照被当作已停止 |
| `player` | 最新人物坐标 | 更新 MapDump.Player，是重规划的权威起点 |
| `moveSpeed` | 游戏原始单位/秒 | RouteExecutor 用于直线段释放时间预测，单位换算基准为每格 1000 |
| `confused`、`confuseDirections` | 混乱状态和方向顺序 | 与 MapDump 状态合并时，混乱结束需清空方向 |

#### 运行时路线和传送门状态

`DungeonSession` 不是持久化表，而是单次设备/地牢运行的内存状态。核心对象关系如下：

```text
DungeonSession
 ├─ MapDump? Map
 ├─ RouteSession Route ──> RoutePlan.Route + PlannedInteraction[]
 ├─ RouteExecutionRuntime ──> MoveSpeed / PulseFallback
 ├─ Blocked / ConfirmedCompletedTargets / InteractedChambers
 ├─ FloorStateMachine ──> Explore → ... → VerifyTransition
 ├─ PortalJumpGraph ──> source portal -> learned destination portal(s)
 └─ PortalUnlockGraph ──> unlocked portal -> observed defeated monsters
```

传送门目的地由服务器拥有，`PortalJumpGraph.Observe` 通过前后两次快照、人物坐标变化和目的地附近传送门推断；固定房间传送门没有客户端可见目的地，随机传送门在未学习前会把其它房间传送门作为候选。这是重要的业务约束，也是误判风险来源。

## 5. 结构化业务说明

### 5.1 业务功能

| 功能 | 入口 | 说明 |
| --- | --- | --- |
| 设备管理 | 扫描设备、连接、断开 | ADB 序列号管理、root 能力和触摸后端初始化 |
| 地图读取与显示 | 刷新地图、地图面板、小窗口 | 读取助手 JSON，绘制地形、角色、目标、路线和 Boss 预警 |
| 自动规划 | 规划路线、开始 | 组合目标策略、探索收益、机关/宝箱/Boss/出口和楼层策略 |
| 点击导航 | 点击可走 Tile 或交互目标 | 最新请求优先；战斗中排队；完成后不影响通用跑图状态 |
| 移动执行 | 长按、换向、单格脉冲 | 速度预测、停滞检测、路线偏离、释放后序列复核和重新规划 |
| 战斗/交互 | 怪物、宝箱、机关、密室、资源 | 交互点由 Planner 生成；道路怪物作为同步点分段处理 |
| 楼层转场 | 出口/传送门/下一层弹窗 | `FloorStateMachine` 管理弹窗、加成选择、换层确认和新层加载 |
| 挖矿 | 挖矿、卡矿 | 视觉/OCR 检查工具，按 Tile 网格点击，并在传送门转场前优先判断 |
| 自动进图 | 识图自动进图 | MAA 风格 Pipeline + OCR/模板匹配完成入口流程 |
| 助手管理 | 检测/安装/恢复助手 | 对设备端 Lua 文件做备份、注入、完整性检查和恢复 |
| 诊断监控 | Web 监控 | 本地查看实时 Pipeline 事件和历史追踪 |

### 5.2 楼层状态机

状态定义在 `Navigation/FloorStateMachine.cs`：

```text
Explore
 ├─> CollectWarning ──> FightGuard ──> Explore
 ├─> ConfirmPortal ──> GoToPortal ──> InteractPortal
 └─> WaitingFloorLoad ──> Explore

InteractPortal ──> SelectBonus ──> VerifyTransition ──> WaitingFloorLoad
       └────────> VerifyTransition
```

注意：`Transition` 对非法转移只记录字符串，仍然会应用新状态；它是“可观测状态机”而不是“强制状态机”。

### 5.3 设计上的隐藏逻辑坑点

| 编号 | 坑点 | 影响 |
| --- | --- | --- |
| L-01 | `MapDump.ByCell` 使用 `ToDictionary`，重复或错误坐标会直接抛异常 | 助手输出一条坏 Tile 就可能中断刷新和规划 |
| L-02 | `TileInfoConverter` 对异常字段采用默认值，`RefreshMapSnapshot` 又主动 Drain 并丢弃诊断 | 上游协议漂移可能被“可运行的错误地图”掩盖 |
| L-03 | `TileInfoConverter.Write` 明确抛 `NotSupportedException` | 任何意外的 Tile 序列化路径都会失败 |
| L-04 | `RoleInfo.Kind` 同时承担资源分类、绘制和规划兼容层 | 改一个角色映射可能改变目标是否被选中、是否显示和是否可交互 |
| L-05 | 城镇图标坐标和逻辑角色坐标可能不同 | 不先 `ResolveInteractiveCell` 会点击错误位置 |
| L-06 | `AllExplored` 是游戏拥有的全图可见信号，不是控制器访问集合 | 不能用它推断“玩家实际走过所有格子” |
| L-07 | `SceneType=1`、`CaveMode`、`TransdoorType`、`MinimapType` 均来自游戏内部协议 | 游戏版本改变枚举值时，编译不会报错但路线语义会改变 |
| L-08 | 房间传送门目的地服务器决定，控制器通过坐标跳变和邻近门学习 | 落点不在门旁、转场延迟或快照过期会学习错误边 |
| L-09 | `PortalUnlockGraph` 将一次快照间消失的所有普通怪物关联到新解锁门 | 多个怪物/多个门同时变化时约束可能过宽，导致错误的“门已解锁原因” |
| L-10 | `RouteExecutor` 释放后等待新 `sequence` 最多约 120ms；状态导出慢时会反复重规划 | 真实设备负载高时可能出现路线抖动而非故障 |
| L-11 | 负 `MovementReleaseLead` 表示到达目标后继续按住，正值表示提前释放 | 配置含义反直觉，迁移 UI 或默认值时容易反向修改 |
| L-12 | `PopupWatchdog`、启动预检和地图刷新都依赖截图/OCR时序 | OCR 慢帧、转场动画和截图锁竞争会造成误报或漏报 |
| L-13 | 宝石选择和下一层对话框必须在路线前接管；误把弹窗当普通地图会产生危险触摸 | 必须保持 `runeSelectionVisible`、`SelectBonus` 和 `VerifyTransition` 的优先级 |
| L-14 | `FloorStateMachine` 非法转移仍生效 | 日志中有 invalid transition 不代表行为被阻止，排查时不能只看异常记录 |
| L-15 | `DungeonSession.Reset()` 与 `StopAutomation()` 清理边界不同 | 换设备会清地图；急停保留地图。新增状态若放错清理函数会跨运行泄漏或丢失学习结果 |
| L-16 | ADB root shell 通过字符串拼接命令 | 当前路径大多是内部常量，但未来把用户输入带入命令会产生 shell 注入和引号错误 |
| L-17 | Pipeline 追踪服务默认无认证 | 当前只绑定回环地址；若修改绑定地址，追踪内容会变成未授权信息接口 |
| L-18 | `MaaPipeline` 和旧 `TaskPipeline` 并存且有 adapter | 同名的重试、超时、分支和完成语义可能在迁移中不一致 |

## 6. 高风险代码标记

### 6.1 超长文件/函数

以 2026-10-08 工作树统计，以下是最需要优先关注的代码热点。文件较长本身不是缺陷，但这些文件同时承担协议、状态或时序职责时风险会放大。

| 风险 | 位置 | 规模/问题 |
| --- | --- | --- |
| 高 | `Infrastructure/Automation/MaaPipeline.cs` | 1,234 行；包含协议模型、JSON 解析、节点运行、分支、重试、追踪和旧 Pipeline adapter |
| 高 | `Presentation/ThemePalette.cs` | 1,207 行；主题模型、控件样式、绘制器和大量 UI 细节混在一个文件 |
| 高 | `Infrastructure/Adb/AdbClient.cs` | 955 行；ADB 进程、root shell、JSON、截图、OCR、助手补丁入口和触控生命周期汇聚 |
| 高 | `Infrastructure/Automation/VisualTemplate.cs` | 814 行；模板格式兼容、采样/匹配、入口模板持久化和视觉判断混合 |
| 高 | `Presentation/MainForm.Planning.cs` | 680 行；目标交互、战斗、楼层策略、快捷入口、恢复和路线规划编排混合 |
| 高 | `Navigation/Planner.cs` | 668 行；多个规划模式、Dijkstra 类搜索、目标停靠和领域规则集中 |
| 高 | `Infrastructure/Automation/DungeonEntryAutomation.cs` | 614 行；进图 Pipeline、视觉模板、OCR、重试和点击坐标混合 |
| 高 | `Presentation/MainForm.Automation.cs:190` `RunLoop` | 约 324 行；一次循环处理刷新、战斗、传送门、宝石、挖矿、停层、交互和恢复 |
| 高 | `Presentation/MainForm.Movement.cs:81` `NavigateToMapCellCore` | 约 141 行；点击导航、地图刷新、战斗等待、交互和路线切片 |
| 高 | `Navigation/RouteExecutor.cs:26` `ExecuteDetailed` | 约 147 行；输入时序、坐标复核、速度预测、停滞和弹窗取消聚合 |
| 中 | `Infrastructure/Automation/TaskPipeline.cs:230` `RunAsync` | 约 125 行；另一个完整 Pipeline 运行语义 |
| 中 | `Presentation/MainForm.Mining.cs:66` `MineFloorCore` | 约 124 行；挖矿扫描、工具检查、点击和地图一致性判断 |

### 6.2 硬编码 SQL、魔法数字和外部协议常量

#### 硬编码 SQL

控制器项目内未发现 SQL 语句、SQLite/ORM 访问或数据库表定义，因此该项在控制器范围为“未发现”。仓库中 APK/Lua 反编译资料的 `sqlite3 %s 'select/insert/update/delete ...'` 属于另一个审计对象；它使用字符串格式拼接，若未来纳入产品代码应按高风险 SQL 注入/转义问题处理。

#### 高影响硬编码

| 风险 | 位置 | 示例 | 问题 |
| --- | --- | --- | --- |
| 高 | `AdbClient.cs:16`、`AssistantController.cs` | `/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline` | 游戏包名/应用数据目录版本强绑定 |
| 高 | `AdbClient.cs`、`TouchBackends.cs` | `/data/local/tmp/codex_*`、`maatouch`、`minitouch`、`app_process` | 设备权限、ABI、agent 协议和清理行为强绑定 |
| 高 | `GameScreenCoordinates.cs`、`VisionPipeline.cs` | 游戏坐标 `720x1280`、设计坐标和横竖屏旋转 | 分辨率/布局版本改变时识别和点击同时失效 |
| 高 | `PortalRouting.cs`、`CardFloorPolicy.cs`、`FloorPlanningPolicy.cs` | `TransdoorType`、`CaveMode`、6101、地图上限 | 游戏协议值改变时静默产生错误业务决策 |
| 中 | `PopupWatchdog.cs`、`MainForm.*.cs` | 120ms、160ms、500ms、1,000ms、1,500ms、8,000ms 等等待/超时 | 时序参数分散，难以统一调优或解释 |
| 中 | `PipelineWebServer.cs` | 17830、最多 10 次尝试、最多 2,000 个事件 | 运行环境冲突和内存边界未配置化 |
| 中 | `Planner.cs` | 绕开道路怪物的 7 步代价、目标评分 18 | 业务启发式没有集中配置或解释性测试 |

### 6.3 异常捕获不足或异常语义危险

| 风险 | 位置 | 观察 |
| --- | --- | --- |
| 高 | `AdbClient.ReadMap`、`ReadPlayer` | 设备 I/O/解析异常向上抛出，依赖 UI 调用方捕获；新增调用方若遗漏边界会直接终止流程 |
| 高 | `RouteExecutor.ExecuteDetailed` | 只将“弹窗取消”转换为结果，其它输入/读取异常继续向上冒泡；`finally` 中的 `TouchUp` 失败还可能覆盖原始结果 |
| 中 | `SettingsStore.cs:24-42` | Load/Save 对所有异常静默吞掉，用户看不到设置损坏、权限拒绝或磁盘失败 |
| 中 | `PipelineWebServer.ListenLoopAsync` | 非取消异常 `catch { continue; }`，监听线程可永久丢失错误原因 |
| 中 | `MainForm.DeviceMap.cs:177-185` | 弹窗预检失败只记录“未知”，在 fail-safe 分支急停；诊断信息不足以区分 OCR、截图还是设备故障 |
| 中 | `TouchBackends.cs` 多处清理 | 停止 agent、删除远端临时文件、释放流时大量 best-effort `catch {}`，可能遗留设备进程或临时文件 |
| 低/中 | `JsonDiagnostics` | 诊断队列是全局静态对象，调用方 Drain 后丢失；多设备/并发测试难以关联来源 |

## 7. 当前技术债务清单与风险等级

| 编号 | 技术债务 | 风险 | 直接后果 | 建议处理 |
| --- | --- | --- | --- | --- |
| TD-01 | Domain 与 Navigation 反向类型依赖 | 高 | 无法独立编译/复用 Domain，改路线契约容易扩散 | 迁移路线数据契约，增加程序集或至少建立 Contracts 目录 |
| TD-02 | `MainForm` 仍是业务流程总协调器，partial 只是文件拆分 | 高 | 状态、取消、UI、设备和业务规则难以隔离测试 | 将 `RunLoop`、楼层编排、弹窗编排拆到 Application 用例服务 |
| TD-03 | `AdbClient` 是设备 I/O God facade | 高 | ADB、root shell、OCR、截图、触摸和助手协议互相影响 | 分离 `GameStateReader`、`RootFileTransport`、`ScreenProbe`、`AssistantGateway` |
| TD-04 | 两套 Pipeline 运行时并存 | 高 | 重试/分支/超时语义重复，迁移时出现行为漂移 | 冻结一套协议，逐步删除旧 `TaskPipeline` 或明确边界 |
| TD-05 | 真实设备端到端回归缺失 | 高 | 触摸时序、OCR、弹窗、入口、传送门问题只能人工复现 | 增加截图回放、ADB fake、Pipeline fixture、状态机和路线时序测试 |
| TD-06 | 游戏协议/包路径/坐标/超时散落硬编码 | 高 | 游戏版本、分辨率或布局变化会静默失效 | 集中到版本化 `GameProtocol`/`ScreenProfile`/`TimingProfile` |
| TD-07 | 容错解码会把坏快照变成默认地图 | 高 | 协议漂移可能导致错误移动，而不是快速失败 | 保留诊断并按字段分级：必需字段失败即停止，非关键字段可降级 |
| TD-08 | 楼层状态机只记录非法转移、不阻止非法转移 | 高 | 状态日志看似有告警，实际流程仍可能进入错误分支 | 区分 `TryTransition` 和内部强制恢复，非法转移默认拒绝 |
| TD-09 | Root shell 命令使用字符串拼接 | 高 | 动态参数扩展后有 shell 注入、转义和路径破坏风险 | 引入参数化 shell 命令/白名单路径构造；对远端路径统一转义 |
| TD-10 | `OperationTracker` 的 `HashSet<Task>` 无同步 | 中 | 并发启动/结束操作时存在竞态，Shutdown 可能漏等任务 | 使用锁、并发集合或单一 UI 调度上下文，并增加并发测试 |
| TD-11 | 设置文件异常静默吞掉 | 中 | 配置损坏或保存失败无可见反馈 | 记录结构化日志，区分“首次缺失”和“损坏/权限失败” |
| TD-12 | 弹窗监控与地图刷新共享设备资源但缺少统一调度抽象 | 中 | 高负载时截图/OCR竞争、重复识别、取消时序复杂 | 建立设备探测队列和每类 probe 的优先级/互斥策略 |
| TD-13 | 视觉规则缺少固定样本回放测试 | 中 | 模板、颜色阈值、OCR 文案变化带来误报/漏报 | 将 `Resources` 样本和失败截图转为自动化识别 fixture |
| TD-14 | `PortalJumpGraph`/`PortalUnlockGraph` 只在内存保存 | 中 | 重启后丢失已学习传送门关系，且无法审计学习依据 | 设计版本化本地 JSON 学习缓存，附快照 hash 和置信度 |
| TD-15 | `MapDump`、`PlayerStatus` 无显式 schema/version | 中 | 助手与控制器独立升级时兼容性不可见 | 在 JSON 根增加 schemaVersion、producerVersion 和必需字段校验 |
| TD-16 | Web 监控只做回环地址假设 | 中 | 后续改成局域网监听会意外暴露运行追踪 | 绑定地址和认证策略显式配置；默认拒绝非回环访问 |
| TD-17 | `ThemePalette.cs`、`VisualTemplate.cs` 等低业务优先级大文件 | 低 | 修改样式或视觉算法成本高、代码导航困难 | 按绘制器/模板格式/持久化 seam 拆分，避免只为减行数拆分 |
| TD-18 | 单程序集、全局根命名空间和目录约束依赖评审 | 低/中 | 反向依赖只能靠人工发现 | 至少增加架构测试，禁止 Domain 引用 Presentation/Infrastructure |

## 8. 建议修复优先级

### P0：先降低误操作和不可诊断故障

1. 为 `MainForm.RunLoop`、`RouteExecutor.ExecuteDetailed`、`PopupWatchdog` 建立截图/人物 JSON/触摸事件回放测试。
2. 保留并显示 `JsonDiagnostics`，把必需字段错误与可降级字段错误区分开。
3. 给 ADB root shell、触摸释放、远端临时文件清理增加结构化错误码和上下文日志。
4. 把 `FloorStateMachine` 的非法转移改为拒绝，恢复流程使用明确的 `ForceReset`/`Recover`。

### P1：消除结构性耦合

1. 抽出 `Domain.Contracts`，修复 `RouteSession → Navigation.Planner` 的反向依赖。
2. 将 `MainForm` 的自动化循环迁移到 Application service，UI 只实现 observer。
3. 将 `AdbClient` 拆成设备传输、游戏状态读取、屏幕探测、助手网关四个模块。
4. 统一 MAA/Task Pipeline，保留一套重试、超时、事件和取消语义。

### P2：提高版本适应性和运营可维护性

1. 建立 `GameProtocol`、`ScreenProfile`、`TimingProfile`，集中枚举、包路径、坐标和时序常量。
2. 给地图/人物 JSON 加版本字段和 schema 校验。
3. 为传送门学习、视觉识别、OCR 识别和挖矿建立样本回放/回归数据。
4. 将设置、追踪和学习缓存的失败从静默吞掉改为可见但不打断主流程的诊断事件。

## 9. 验证边界

本次任务为静态架构和数据契约审计，未修改业务源代码，也未执行构建或发布流程。现有 `docs/ARCHITECTURE.md`、`docs/REFACTOR_AUDIT.md` 和 `REFACTOR_PLAN.md` 被作为背景材料，同时对当前源码重新统计了文件规模、调用入口、持久化路径、异常处理和依赖关系。

结论中涉及真实设备时序、游戏服务器传送目的地和 Lua 导出协议的部分，属于基于源码和注释的行为推断；要把它们提升为确定结论，需要连接真实设备或使用已保存的截图/JSON/追踪样本进行回放。
