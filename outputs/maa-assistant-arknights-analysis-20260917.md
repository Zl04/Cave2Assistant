# MaaAssistantArknights 借鉴分析与落地建议

分析日期：2026-09-17  
分析对象：`MaaAssistantArknights` `dev-v2`，以及其关联的 `MaaFramework` Pipeline / ProjectInterface 文档。  
分析目标：判断哪些工程设计适合迁移到当前“洞窟地图控制器”，不复制明日方舟业务实现。

## 一句话结论

MAA 最值得借鉴的不是某个模板匹配算法，而是把自动化做成一套有边界的运行时：

```text
控制器适配层 → 串行任务入口 → 识别/动作 Pipeline → 领域任务组合
       ↓              ↓                 ↓
    ADB/触控       队列/停止/状态       模板/OCR/资源/重试
                                  ↓
                         结构化事件与失败证据
```

当前项目已经有地图快照、Lua 状态、地图图搜索、路线执行恢复、弹窗看门狗和 OCR。最划算的方向不是重写这些核心，而是把 `MainForm` 中的易变 UI 流程抽成一个受限的任务执行层。

## MAA 的关键设计

### 1. 控制器与业务任务分离

MAA 的 `ControllerAPI` 统一抽象连接、截图、点击、输入、滑动、启动/停止游戏、返回主页、屏幕分辨率和能力查询；实现可以是 ADB、Minitouch、MaaTouch、Win32 等。输入事件还单独建模为触摸、按键、等待和提交等类型。

来源：[ControllerAPI.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Controller/ControllerAPI.h)

对本项目的启发：继续保留 `AdbClient` 和 `TouchController`，但让上层只依赖一个窄接口，例如：

```text
IGameController
  Connect / Capture / Tap / Swipe / PressBack / GetResolution
IGameStateReader
  ReadMap / ReadPlayer / ReadAssistantStatus
IOverlayDetector
  DetectMovementBlockingOverlay
```

不要让 `FloorStateMachine`、`Planner` 或将来的 Pipeline 直接拼接 ADB shell 命令。

### 2. 一个实例有明确的任务队列和生命周期

MAA 对外提供连接、追加任务、动态更新任务参数、启动、停止、运行状态查询、截图和异步调用等接口；内部把工作处理、异步调用和消息通知分开，并用队列/条件变量协调。

来源：[AsstCaller.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/include/AsstCaller.h)、[Assistant.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.h)

对本项目的启发：按钮不应长期直接编排 `StartRun`、`StopMovement`、`RefreshMap`、点击和定时器。建议加一个进程内的 `AutomationRunner`，将操作归一成命令：

```text
StartRun(profile)
PauseRun()
ResumeRun()
StopRun(reason)
RefreshSnapshot()
RunSingleStep(target)
EnterDungeon(selection)
```

所有会产生设备副作用的操作由 Runner 串行执行；UI 只提交命令和订阅事件。停止应是正式生命周期：`Created → Running → Stopping → Stopped`，并满足幂等、先释放触摸、禁止停止后的新输入、关闭窗口等待 Runner 结束。

### 3. Pipeline 用数据描述易变的页面流程

MAA 的任务协议将识别算法、动作、子任务、后继分支、错误分支、最大次数、前后延时、ROI、缓存和模板参数放到任务节点中。`next` 是有顺序的候选分支：命中一个就执行，不是把所有候选任务并行跑一遍。

来源：[任务流程协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md)、[任务 schema](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/maa_tasks_schema.json)

当前项目适合先做一个“UI Overlay Pipeline”，只覆盖：服务器异常、死亡/复活、战利品确认、秘境宝石选择、换层确认、奖励选择和城镇入口，不要把地图寻路也改成 JSON。

建议最小节点模型：

```json
{
  "name": "ConfirmNextFloor",
  "recognition": { "type": "TemplateOrOcr", "roi": "next_floor_dialog" },
  "action": { "type": "Click", "target": "matched" },
  "next": ["WaitFloorLoaded"],
  "onError": ["StopSafe"],
  "maxTimes": 3,
  "pollIntervalMs": 160,
  "timeoutMs": 10000,
  "preDelayMs": 100,
  "postDelayMs": 300
}
```

需要保留强类型实现的部分：`Planner` 的图搜索、`RouteExecutor` 的速度预测/转角复核/反复横跳检测、`PortalJumpGraph` 和楼层领域规则。

### 4. 识别、动作、等待和分支有统一语义

Pipeline 文档明确区分识别类型、动作类型、ROI、识别轮询间隔、节点超时，以及动作前后等待和画面稳定等待；这比在每个业务方法里散落 `Task.Delay` 更容易调参和回放。

来源：[MaaFramework Pipeline Protocol](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

当前项目的识别器已经有较好的基础：`VisualTemplate` 支持灰度、透明度权重、颜色和模式相关，`VisualNodeLocator` 支持颜色候选和几何过滤，OCR 有独立 Worker，入口流程还做了“点击后再次确认”。下一步应统一返回：

```text
RecognitionResult
  matched / confidence / secondScore / margin
  bounds / clickTarget / source / timestamp / evidenceId
```

同时把 `pollInterval`、`recognitionTimeout`、`actionTimeout`、`settleTime`、`overallDeadline` 分开，不要用一个 timeout 表示所有时间。

### 5. 回调不是字符串日志，而是稳定事件协议

MAA 将事件分成全局信息、任务链信息、子任务信息和异步调用信息，覆盖初始化失败、连接变化、任务开始/完成/失败/停止、截图耗时、识别结果等；详情 JSON 会带任务链、任务 ID、子任务、动作、算法、执行次数等字段。

来源：[回调消息协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/callback-schema.md)

当前项目可以定义本地事件：

```text
RunStarted
PhaseChanged
NodeRecognized
ActionStarted / ActionCompleted
Retrying
RecoveryStarted
RouteReplanned
OverlayInterrupted
RunStopped / RunFailed
```

最少携带 `runId`、设备、楼层、阶段、节点、尝试次数、耗时和原因。识别失败时可关联截图、OCR 文本、Lua 状态、地图快照、路线和识别分数。这样 UI 日志、文件日志和测试回放都消费同一份事件，不再依赖解析中文日志。

### 6. 代码、任务资源、动态资源和用户覆盖分层

MAA 主仓库把核心实现、`resource/tasks`、模板/模型等资源和对外接口分开；MaaFramework 的 ProjectInterface 又用 `interface.json` 描述项目名称、任务、选项、预设、资源和版本信息，使通用 UI 可以加载项目。

来源：[MAA 仓库目录与 README](https://github.com/MaaAssistantArknights/MaaAssistantArknights)、[Project Interface V2](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.3-ProjectInterfaceV2.md)、[术语说明](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/1.2-ExplanationOfTerms.md)

对本项目建议采用三层资源：

```text
内置资源：Resources / icons / pipelines
游戏版本资源：按 APK 或 Lua 协议版本组织
用户覆盖：publish/resources/overrides
```

每个资源包加入 `version`、`gameVersion`、`schemaVersion`、SHA-256 和清单；下载或替换时先校验，成功后原子切换，失败保留旧包。当前项目已有 `SettingsStore` 的原子保存和入口模板文件，这个方向可以自然扩展。

### 7. 扩展进程的思路可以沿用现有 OCR Worker

MaaFramework 将 UI、Core、Project Resources 和可选 Agent 分开，并支持把自定义识别/动作放在独立进程中。当前项目已经有 `OcrWorker`，这是一个很好的本地先例：耗时识别不阻塞 WinForms，协议有明确输入输出边界。

来源：[MaaFramework 术语说明](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/1.2-ExplanationOfTerms.md)、[集成说明](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/2.1-Integration.md)

可以借鉴的是“进程边界、超时、版本和失败重启”，暂时不需要建设完整插件市场或多语言 FFI。

## 与当前项目的对照

当前工程已经具备：

- `AdbClient` / `TouchController`：设备通信和触摸输入；
- `MapSnapshot`：地图结构 hash 和导航 hash；
- `FloorStateMachine`：楼层阶段；
- `Planner`：目标策略、可达性、图搜索、临时阻塞恢复；
- `RouteSession` / `RouteExecutor`：路线、交互点、速度预测、偏离检测和重规划；
- `VisualTemplate` / `VisualNodeLocator` / `OcrWorker`：模板、颜色候选、OCR；
- `PopupWatchdog`：移动期间检测阻塞弹窗并中断当前移动；
- 多个回归程序：路线锁、入口、崩溃、助手补丁、触控和显示名。

主要缺口不是识图算法，而是：

1. `MainForm` 仍是 UI、设备操作、刷新、运行编排和日志的集中入口；
2. 弹窗流程虽然已有专用方法，但没有统一的节点/重试/分支模型；
3. 识别结果、动作结果和失败证据没有统一事件契约；
4. 模板和 UI 参数仍主要通过代码与发布文件组织，没有资源清单和版本层；
5. 现有测试偏领域回归，缺少“截图/状态 fixture → 识别 → 动作计划 → 状态迁移”的离线回放层。

## 建议的落地顺序

### P0：先做运行时边界

新增 `AutomationRunner`、命令模型和事件模型；把开始、暂停、停止、刷新、单步、自动进图统一收口。现有地图规划和路线执行不改，只改变调用入口。

建议新增或整理：

```text
Infrastructure/Automation/IGameController.cs
Infrastructure/Automation/AutomationRunner.cs
Infrastructure/Automation/RunEvent.cs
Infrastructure/Automation/RetryPolicy.cs
```

### P1：做受限 UI Pipeline

先支持 `DirectState`、`Template`、`Color`、`OCR` 四种识别，`Click`、`Swipe`、`Wait`、`Refresh`、`Stop` 五种动作，以及 `next`、`onError`、`maxTimes`、ROI、轮询间隔和总时限。把换层、秘境选择、服务器异常和入口确认迁入 Pipeline；地图移动仍调用强类型 `RouteExecutor`。

### P2：资源与回放

加入资源 manifest/hash/原子切换、预设配置、离线截图回放和 `validate-config` / `status --json`。只有在确实需要多进程或外部调用时，再考虑命名管道或 localhost API。

## 不建议照搬的部分

- 不要现在引入完整 MaaCore/C++ 核心、跨语言绑定和通用 UI；当前项目规模与需求不需要这层复杂度。
- 不要把地图图搜索改造成通用 JSON。地图是本项目最有领域价值的部分，强类型规划器更容易保证规则和恢复行为。
- 不要把 OCR 或神经网络设为默认路径。Lua 导出的结构化状态优先，模板/像素识别次之，OCR 作为页面文字和兜底确认。
- 不要复制 MAA 的图片、模板、图标、代码或其 Logo。MAA 主仓库标注为 AGPL-3.0-only，并有额外用户协议；如果实际复用代码或资源，必须单独核对许可证、版权和分发义务。架构思想与直接复制实现不是一回事。

来源：[MAA LICENSE](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/LICENSE)、[MAA terms-of-service.md](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/terms-of-service.md)、[README 声明](https://github.com/MaaAssistantArknights/MaaAssistantArknights#声明)

## 最终判断

值得借鉴，优先级如下：

```text
高：单一 Runner、控制器接口、结构化事件、受限 UI Pipeline、重试/超时语义
中：资源 manifest、版本覆盖、离线回放、status --json
低：完整 MaaFramework、通用插件体系、远程控制、多语言 FFI、神经网络识别
```

推荐的最终边界是：

```text
WinForms / CLI
        ↓ 命令、预设、事件
AutomationRunner
        ├── UI Overlay Pipeline ← 模板 / 像素 / OCR / Lua 状态
        └── FloorStateMachine → Planner → RouteExecutor
                                      ↓
                         IGameController → ADB / Touch
```

这条路线能保留当前项目已经验证过的地图与移动能力，同时吸收 MAA 在可配置、可观测、可恢复和可维护方面最有价值的经验。
