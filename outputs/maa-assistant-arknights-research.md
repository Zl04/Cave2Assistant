# MaaAssistantArknights 借鉴分析

分析日期：2026-09-16

## 结论

MaaAssistantArknights（MAA）最值得借鉴的不是某个识图算法，而是一套把“游戏流程自动化”工程化的方式：控制器抽象、数据驱动任务流、可组合的识别与动作、结构化回调、资源与代码分离，以及可扩展的任务配置协议。

当前项目已经拥有地图快照、楼层状态机、路径规划、路线执行恢复、Lua 状态导出、ADB 控制和 OCR 等核心能力。因此不建议照搬 MAA 的完整 C++/多语言框架；更合适的路线是在现有 `Planner` / `RouteExecutor` 外侧补一层轻量的 UI 任务管线，并逐步把动态配置、观测结果和故障恢复标准化。

## 官方项目结构中值得借鉴的部分

### 1. 任务流是数据，而不是全部写死在业务代码中

MAA 的任务协议将识别、动作、子任务、后继分支、错误分支、重试次数、延时和 ROI 等组合成任务节点；任务还可以通过 `baseTask` 继承和覆盖。任务 schema 与任务实现分离，任务资源可以独立演进。

参考：

- [MAA task schema](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/maa_tasks_schema.json)
- [MAA task-flow protocol](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md)
- [MAA built-in tasks](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/resource/tasks/tasks.json)

对本项目的直接启发是增加一个有限范围的 `TaskPipeline`，先覆盖阻塞式 UI 流程：复活、奖励/传送门、秘境选择、Boss 警告、城镇返回和异常弹窗。地图寻路仍由现有规划器负责，不要把图搜索也塞进 JSON。

建议节点最小模型：

```json
{
  "name": "ConfirmPortal",
  "recognition": { "type": "template", "name": "portal_confirm" },
  "action": { "type": "click", "target": "self" },
  "next": ["InteractPortal"],
  "on_error": ["RefreshScreen", "StopSafe"],
  "max_times": 3,
  "pre_delay_ms": 100,
  "post_delay_ms": 300
}
```

### 2. 稳定入口 + 任务队列 + 横切插件

除任务节点外，MAA 还通过稳定的 C ABI 暴露资源加载、实例创建、任务追加、参数更新、启动/停止、异步截图和回调；高层任务则由 `PackageTask` 组合通用流程，并挂载截图、统计、条件停止等插件。

参考：[AsstCaller.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/include/AsstCaller.h)、[Assistant.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.cpp)、[FightTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/Interface/FightTask.cpp)

本项目可以先做一个进程内的 `AutomationRunner`，统一接收任务、返回 `run_id`、排队执行和停止，不急着做 C ABI。截图记录、统计、到层停止、诊断导出等应作为插件/订阅者接入，避免散落在每个状态分支中。将来需要 CLI 或其它语言调用时，再把这个入口稳定化。

### 3. 控制器与任务逻辑分层

MAA 的 `ControllerAPI` 把连接、截图、点击、输入、滑动、启动/停止游戏、返回主页和能力查询等定义为控制器接口；任务层不需要知道底层是 ADB、minitouch 还是其它平台控制方式。

参考：[MaaCore ControllerAPI](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Controller/ControllerAPI.h)

本项目目前虽然以 ADB 为主，但应把 `AdbMapController` 使用的能力进一步收敛到类似 `IGameController` 的接口：截图、点击、滑动、按键、输入、启动/停止、读取运行时状态。这样以后更换模拟器、增加桌面控制或做测试桩时，不会牵动楼层状态机和任务策略。

### 4. 识别结果有统一形态，并支持组合识别

MAA/MaaFramework 将模板匹配、特征匹配、颜色匹配、OCR、神经网络和自定义识别统一成节点协议，同时区分 ROI、识别框和点击目标，并支持 `And` / `Or` 等组合。

参考：[MaaFramework Pipeline Protocol](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

本项目的 `VisualNodeLocator` 已经有候选点筛选、连通区域合并、尺寸/宽高比/区域过滤等实践。下一步应将其输出标准化为 `RecognitionResult`：`matched`、`confidence`、`box`、`target`、`timestamp`、`source`、`evidence_id`。这样一个“找到图标”与“应该点击哪里”就不会混在一起，也便于组合条件和日志回放。

推荐识别类型：`Direct`（Lua/状态文件）、`Template`、`Pixel`、`OCR`、`Any`、`All`。优先使用游戏内 Lua 导出的结构化状态，截图识别作为补充和兜底。

### 5. 子任务、重试、错误分支和生命周期统一

MAA 的 `AbstractTask` 统一处理启用状态、重试、延迟、任务开始/完成/失败回调；`PackageTask` 负责顺序执行子任务、检查停止信号、传播失败和处理可忽略子任务。

参考：[AbstractTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/AbstractTask.cpp)、[PackageTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/PackageTask.cpp)

本项目的 `RouteExecutor` 已经实现了偏移、停滞、震荡、释放后校验和重新规划等恢复逻辑，但这些策略与 `MainForm` 的流程控制耦合较多。可以抽出共享的 `RetryPolicy` / `RecoveryAction`：每个动作声明最大尝试次数、失败后刷新方式、是否允许重规划、是否安全停止；状态机只消费结果，不自行拼接大量恢复分支。

### 6. 结构化回调与可观测性

MAA 的回调协议覆盖任务链和子任务的开始、完成、失败、停止、额外信息，以及整体任务完成事件，并携带任务名、动作、算法、执行次数等结构化信息。

参考：[MAA callback schema](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/callback-schema.md)

本项目建议定义本地事件模型：`RunStarted`、`PhaseChanged`、`NodeRecognized`、`ActionStarted`、`ActionCompleted`、`Retrying`、`RecoveryStarted`、`RunStopped`、`RunFailed`。事件至少携带 `run_id`、楼层、阶段、节点、重试次数、耗时和错误原因。识别失败时保存“截图 + OCR 文本 + Lua 状态 + 地图快照 + 当前路线”，并设置保留策略，避免调试产物无限增长。

### 7. 代码、任务资源、动态数据分离

MAA 将核心代码、任务/模板/识别配置和动态资源拆开；`MaaResource` 用于独立同步随游戏更新而变化的资源文件。项目接口协议还支持资源叠加、控制器过滤、任务分组、预设、选项和 hash 校验。

参考：[MaaResource README](https://github.com/MaaAssistantArknights/MaaResource/blob/main/README.md)、[MaaFramework Project Interface V2](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/zh_cn/3.3-ProjectInterfaceV2%E5%8D%8F%E8%AE%AE.md)

本项目可以按以下边界整理：

- 稳定逻辑：`Domain`、状态机、规划器、路线执行器。
- 游戏变化资源：模板、颜色阈值、OCR 替换、弹窗任务、地图/图标定义。
- 用户覆盖资源：单独的 `publish/resources/overrides` 或配置目录，不直接改内置文件。

资源更新应有 manifest、版本、SHA-256 和原子替换；下载后先校验再切换，失败保留旧版本。

### 8. 预设和配置协议

MAA 的任务接口支持选项、复选框、输入、快捷键、分组、预设和导入，且规定了任务、控制器、资源、全局配置的合并优先级。

参考：[Project Interface V2 的 task/options/preset 章节](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/zh_cn/3.3-ProjectInterfaceV2%E5%8D%8F%E8%AE%AE.md)

本项目不必马上做通用动态 UI，但可以先把当前设置组合成几个明确预设：`安全探索`、`速刷出口`、`只收集目标`、`到指定楼层停止`、`Boss 前停留`。预设落到 JSON 后，UI 只是编辑器，运行时读取同一份配置，便于复现和测试。

### 9. CLI、无界面运行和状态查询

MAA 主项目明确支持 CLI、脚本和 headless server；独立的 `maa-cli` 支持预定义/自定义任务、资源和核心更新。这种入口对于长时间运行、远程调度和故障排查很有价值。

参考：[MAA README](https://github.com/MaaAssistantArknights/MaaAssistantArknights)、[maa-cli](https://github.com/MaaAssistantArknights/maa-cli)

本项目后续可增加低风险的本地 CLI：`run --once`、`stop`、`status --json`、`validate-config`、`export-diagnostics`。先做单机命令行或命名管道，不要一开始开放远程 HTTP 控制；若将来需要 HTTP，必须限定 localhost、做鉴权、参数白名单和生命周期校验。

MAA 的远程控制协议还区分“排队任务”和“截图/停止/心跳”等即时任务，并通过任务 ID 去重；这对将来的本地控制面有参考价值，但不能直接当作安全设计。参考：[remote-control schema](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/remote-control-schema.md)

### 10. 测试、资源校验和回归样本

MAA 仓库包含 MaaCore 单元测试、任务资源 schema 和多条 CI/资源同步工作流，说明这类助手不能只靠“在模拟器上跑通一次”。

参考：[MAA unit tests](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/unit_test)、[MAA workflows](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/.github/workflows)

本项目已有多类回归测试，建议进一步建立“截图/状态 fixture → 识别结果 → 状态迁移/动作计划”的离线回放测试。每次遇到弹窗误判、路线死循环、传送门交互失败，都把最小样本加入 fixture；任务 JSON 则做 schema 验证、循环上限和最大嵌套深度检查。

## 面向当前项目的落地优先级

### P0：先补 UI 任务管线

新增轻量 `TaskPipeline` 和 JSON schema，只处理 UI/阻塞流程，不替换地图规划器。首批节点包括 Direct 状态检查、模板/OCR/像素识别、点击/滑动/等待、`next`、`on_error`、`max_times`。同时接入结构化事件日志和失败证据。

### P1：再做识别与资源层标准化

统一 `RecognitionResult`，加入 `Any/All` 组合；把模板、OCR 规则、颜色参数和任务 JSON 移出业务代码；加入资源 manifest、hash、版本和用户覆盖层；抽取统一恢复策略。

### P2：最后做操作面和扩展性

增加 `status --json` / `validate-config` 等 CLI，加入预设和离线回放；再考虑控制器适配器、可选本地 API 或多语言集成。

## 不建议直接照搬的部分

- 暂时不要引入完整 MaaFramework/C++ 核心和多语言 FFI。当前游戏已经能通过 Lua 暴露部分结构化状态，先把现有优势用足。
- 不要在所有地方优先 OCR。OCR 应是结构化状态、模板和像素识别之后的补充。
- 不要把地图图搜索改造成通用任务 JSON；当前 `Planner` 的领域模型和 `RouteExecutor` 的恢复机制更适合保留为强类型代码。
- 不要未经验证复制 MAA 的代码、模板、图标或资源。主仓库是 AGPL-3.0-only，并附有额外使用条款；若借用实现或资产，需单独核对许可证和分发义务。架构思想可以借鉴，代码和素材应优先自行重实现。

参考：[MAA LICENSE](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/LICENSE)

## 安全与工程教训

MAA 仓库有一份公开的 AI 生成代码审计 issue，作者明确提示其中可能有误报，但其中列出的风险类型很值得本项目提前规避：ADB/shell 参数注入、更新包完整性、下载域名校验、后台线程触碰 UI、无限循环/无限嵌套、远程控制校验和 Python `eval` 等。

参考：[MAA code audit issue #16829](https://github.com/MaaAssistantArknights/MaaAssistantArknights/issues/16829)

对应到本项目，至少应做到：动作和 shell 参数使用参数化接口；任务图有循环次数/总时长/嵌套深度上限；资源更新先验 hash 再原子替换；所有 UI 更新回到 UI 线程；停止和销毁可重复调用；诊断文件按大小和数量清理。

## 与当前项目的对照

当前项目已经有一部分 MAA 式能力：`FloorStateMachine` 负责楼层阶段，`Planner` 负责地图图搜索和目标选择，`RouteExecutor` 负责偏移/停滞/震荡检测与路线恢复，`VisualNodeLocator` 负责视觉候选点筛选，Lua 状态导出提供比 OCR 更稳定的运行时信息，测试目录也已经包含路线锁、地牢入口、崩溃和补丁回归样本。

因此最小改造边界应是：

```text
MainForm / CLI
        ↓ 任务队列、预设、事件
UI TaskPipeline  ← 模板 / OCR / 像素 / Lua 状态资源
        ↓ 需要移动时
FloorStateMachine → Planner → RouteExecutor
        ↓
IGameController → ADB / 未来控制器
```

这能保留现有强项：地图规划和移动控制继续使用强类型领域代码；只把易变的页面流程、模板、OCR 词表和弹窗处理变成可校验资源。

## 最终判断

可以借鉴，且收益很高，但借鉴重点应是“协议化、可观测、可恢复、资源可替换”的工程方法。当前项目最划算的增量不是重写识图或控制内核，而是给现有地图自动化系统补一个小而强的 UI Pipeline，并把状态、事件、资源和回归样本组织起来。
