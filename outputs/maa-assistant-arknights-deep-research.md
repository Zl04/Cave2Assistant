# MaaAssistantArknights 深度源码分析与迁移建议

分析日期：2026-09-16

分析范围：MAA `dev-v2` 源码、MaaFramework `main` 的 Pipeline / Project Interface 文档，以及当前 `F:\贪婪洞窟辅助` 的 C# WinForms + Lua + ADB 地图助手。

## 先给判断

MAA 的真正壁垒不是“用了模板匹配/OCR”，而是把自动化拆成了几个稳定边界：

1. 控制器只负责连接、截图和输入。
2. 任务入口只负责排队、启动、停止和参数更新。
3. Pipeline 负责识别、动作、分支、重试和时间预算。
4. 业务任务负责组合通用流程。
5. 插件负责统计、截图、条件停止和额外信息。
6. 资源包负责游戏版本、模板、OCR、任务配置和客户端差异。

当前项目的地图领域逻辑已经比普通“截图点按脚本”更强：Lua 提供运行时状态，`MapSnapshot` 有结构 hash，`FloorStateMachine` 管理楼层阶段，`Planner` 做图搜索，`RouteExecutor` 做实时移动和恢复。因此最合理的迁移不是替换现有核心，而是把 `MainForm` 中的易变 UI 流程抽出来，放到一个受限的任务执行层。

## 一、MAA 的真实运行时模型

### 1. 一个 Assistant 实例不是一个简单的 while 循环

`Assistant` 初始化时分别启动工作线程、消息线程和异步调用线程；任务列表、消息队列、异步调用队列和完成通知各自有锁与条件变量。任务执行线程一次只取一个任务链，但外部仍可以更新正在运行任务的参数；回调不会直接在工作线程同步调用，而是先进入消息队列，再由消息线程向外部派发。

参考：[Assistant.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.h)、[Assistant.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.cpp)

可迁移的设计不是“多开几个线程”，而是建立明确的所有权：

```text
命令入口 ──> CommandQueue ──> 唯一 Runner ──> Controller
                                  │
                                  └──> EventQueue ──> UI / 日志 / 诊断
```

对当前项目尤其重要，因为 `MainForm` 同时承担 UI、刷新调度、楼层状态、路线执行、交互和停止清理。建议让 Runner 成为唯一能驱动自动化状态的对象，UI 只提交命令和订阅事件。

### 2. 任务接口具有“排队后可更新”的语义

MAA 的外部接口支持 `append_task(type, params)`、`set_task_params(task_id, params)`、`start`、`stop`、`running`、获取任务列表、异步截图和异步点击。[AsstCaller.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/include/AsstCaller.h) 的接口说明了这种稳定的任务门面。

这给当前项目的启发是：不要让按钮事件直接调用 `StartRunCore`、`StopMovement`、`RefreshMap` 等内部方法，而是先转成命令：

```text
StartRun(profile)
PauseRun()
ResumeRun()
StopRun(reason)
RefreshSnapshot()
RunSingleStep(target)
```

命令带 `run_id` 和 `request_id`，Runner 串行处理；这样可以避免“暂停和定时刷新同时触碰 ADB”“关闭窗口时后台操作仍在写 UI”等竞态。

### 3. 停止不是异常，而是正式的生命周期状态

MAA 的 `stop` 会让任务队列进入 idle、清空待执行任务和状态缓存；工作线程在任务边界检查状态，最终发送停止/完成事件。当前项目也有 `CancellationToken`、`EmergencyRelease` 和 `ShutdownAsync`，但这些动作还分布在 `MainForm`、协程和 `RouteExecutor` 中。

建议统一成四个生命周期阶段：`Created → Running → Stopping → Stopped`，并规定：

- `Stop` 幂等；重复调用不抛错。
- 进入 `Stopping` 后禁止新的点击、滑动和交互。
- 必须执行触摸释放、取消轮询、等待后台任务结束。
- UI 关闭只等待 Runner 的停止任务，不直接操作内部 CTS。
- `Stopped` 后不得复用旧的 `run_id` 或旧快照。

## 二、Pipeline 并不是配置化的 if/else

### 1. `next` 是有优先级的候选分支

MaaFramework Pipeline 的执行逻辑是：当前节点按 `next` 顺序识别候选节点；一轮中命中第一个就立即执行，未命中则按 `rate_limit` 继续轮询；超时进入 `on_error`。动作成功后进入被命中节点的 `next`，而不是把所有候选节点顺序执行。[Pipeline Protocol](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

这个细节很适合当前的弹窗处理。例如同一时刻可能出现：服务器错误、复活、战利品确认、秘境三选一、普通换层确认。候选顺序应体现安全优先级：

```text
异常/停止类弹窗
  > 战斗/死亡确认
  > 换层/奖励确认
  > 普通页面按钮
```

不能把这些逻辑写成多个并行 `Task.Run`，否则一个旧截图可能在危险弹窗出现后仍发送移动或点击。

### 2. 一个节点有多个时间概念

框架区分识别轮询间隔 `rate_limit`、节点超时 `timeout`、动作前后延时、重复动作间隔，以及等待画面稳定 `pre_wait_freezes` / `post_wait_freezes`。[Pipeline 时间与稳定等待](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

当前项目已有类似实践：地图刷新有并发锁，秘境选择有 250ms 检查间隔和连续 miss 确认，换层弹窗有总超时和最大尝试次数，路线执行则需要 5ms 级状态轮询。下一步应该把这些“散落的数字”变成节点级策略：

```text
poll_interval       识别轮询间隔
action_timeout      单次 ADB/触摸动作上限
recognition_timeout 当前节点等待上限
settle_time         动作后画面稳定时间
overall_deadline    整个任务链上限
```

不要用一个 `timeout` 同时表示 ADB 超时、OCR 超时、弹窗等待和全局停止时间。

### 3. ROI、命中框和动作目标必须分开

Pipeline 明确区分：`roi` 是识别区域，`box` 是识别返回的命中框，`target` 是实际点击/滑动目标；目标可以是当前命中框、固定点、固定矩形或之前节点的命中结果。[ROI/box/target 说明](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

这能解决当前项目中常见的两个风险：

- 识别到一个大区域，但真正应该点的是区域内的确认按钮。
- OCR 识别标题成功，但点击位置应该使用对应卡片，而不是文字框中心。

建议 `RecognitionResult` 至少保存：

```text
Matched, Confidence, Box, Target, Source, FrameId, Timestamp, EvidenceId
```

动作层只接受 `Target`，不接受“识别器内部随便返回的坐标”。

### 4. `JumpBack` 和 Anchor 是异常处理的关键机制

Pipeline 支持让某个临时节点处理完成后回到父节点继续识别，也支持将最近一次命中的节点保存为 Anchor，后续动作引用这个动态目标。[Node Attributes](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

对本项目最有价值的不是照搬语法，而是引入“可插入的全局异常处理器”：

```text
主流程：等待地图/移动/交互
  ├─ 检测到服务器异常 → 释放触摸 → 停止
  ├─ 检测到秘境选择 → 暂停路线 → 选择 → 回到主流程
  ├─ 检测到战斗 → 释放触摸 → 等待 InBattle=false → 回到主流程
  └─ 检测到未知遮罩 → 截图诊断 → 安全停止
```

这比在 `RunLoop` 中不断增加 `if (popup) ... continue` 更容易控制优先级和恢复路径。

### 5. 识别候选不应只有“是否命中”

框架支持多结果排序，例如按坐标、得分、面积、文字长度或 expected 顺序选取结果；也支持 `And` / `Or` 和自定义识别。[Recognition 与排序](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

当前项目可借鉴为三层识别优先级：

1. `DirectState`：读取 Lua 状态、地图 JSON、玩家状态。
2. `CheapVision`：像素、颜色连通域、小模板。
3. `ExpensiveVision`：OCR、复杂模板、多区域扫描。

只有前一层无法回答问题时才进入下一层，并记录使用了哪一层。这样可以保留 Lua 状态的稳定性，同时让 UI 弹窗继续有视觉兜底。

## 三、MAA 如何处理任务继承与配置编译

### 1. 原始 JSON 与可执行任务不是一回事

`TaskData` 会保存原始任务、展开后的任务和任务生成状态；支持 `baseTask`、模板任务、隐式任务和任务表达式。生成时会先解析依赖，再构造最终任务对象；任务处于 `Generating` 状态再次被访问时会报告循环生成。[TaskData.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/TaskData.h)、[TaskData.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/TaskData.cpp)

这里的本质是“加载期编译”：

```text
JSON 资源
  → 解析
  → 合并默认值/继承
  → 展开引用
  → 检查未知节点、循环、正则和资源
  → 生成不可变运行时对象
```

当前项目如果增加 Pipeline，不能在每次运行节点时临时查 JSON。应在启动任务前生成 `CompiledPipeline`，并拒绝：

- 未知节点引用；
- 未知识别器/动作；
- 环引用；
- 超过最大节点数；
- 超过最大嵌套深度；
- 不存在的模板/OCR 资源；
- 非法正则和越界坐标；
- 无终止条件的循环。

### 2. 继承要有限，不要复制 MAA 的全部表达式

MAA 的继承和表达式能力很强，能用少量 JSON 派生大量版本变体；代价是阅读、调试和静态分析复杂度增加。当前项目只需要三种继承：

- `base`: 复制通用节点默认值；
- `variant`: 按游戏版本/界面皮肤覆盖模板与 ROI；
- `profile`: 按用户预设覆盖参数。

暂时不要实现 `@`、`#`、`*`、`+`、`^` 等复杂字符串表达式。用普通 JSON 数组和显式 `extends` 更容易由 C# schema 验证，也更适合以后编写编辑器。

### 3. 默认配置应该有明确优先级

MaaFramework 的默认 Pipeline 支持全局默认、按识别算法默认、按动作默认和节点显式覆盖，优先级逐层下降；多资源包加载时还要考虑加载顺序和已加载节点是否受后续默认值影响。[Default Pipeline](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

当前项目建议固定为：

```text
节点显式值
  > 当前 profile
  > 当前游戏版本 variant
  > 识别器/动作类型默认值
  > 全局安全默认值
```

其中安全默认值必须偏保守：点击次数有限、动作有超时、未知状态停止，不允许“没有配置就无限等待/无限点击”。

## 四、MAA 的业务任务为什么没有全部写成 Pipeline

### 1. 高层任务是强类型组合，Pipeline 是其中一个零件

`FightTask` 会组合启动、关卡导航、战斗和特殊剧情等子任务，同时挂载掉落统计、战斗次数、药剂计数和截图插件；它不是一个巨大的 JSON 文件。[FightTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/Interface/FightTask.cpp)

这给当前项目一个明确边界：

- 地图建模、目标选择、图搜索、移动控制：继续使用强类型 C#。
- 页面弹窗、按钮识别、奖励选择、启动/返回流程：使用 Pipeline。
- 统计、诊断、截图、自动停止、性能指标：使用插件/事件订阅。

如果把 `Planner` 也改成 Pipeline，会失去 `MapSnapshot`、`NavigationHash`、临时封锁、Boss 预警和路线恢复的类型安全。

### 2. 插件是横切能力的正确位置

MAA 的插件可以监听子任务回调，并通过 `block()` 影响流程；插件还负责掉落、截图、次数、药剂等与主流程正交的功能。[AbstractTask](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/AbstractTask.cpp)

当前项目适合先抽出以下插件：

- `SafetyReleasePlugin`：动作异常、窗口切换、战斗开始时释放触摸。
- `EvidencePlugin`：失败时保存截图、地图、玩家状态和当前节点。
- `StopConditionPlugin`：指定楼层、Boss 前、全部目标完成时请求停止。
- `MetricsPlugin`：识别耗时、ADB 耗时、重规划次数、路线恢复次数。
- `StateReconcilePlugin`：动作后验证玩家坐标、楼层和地图 hash。

插件只通过事件和受限上下文工作，不能随意调用 UI 控件或绕过 Runner 直接发 ADB 命令。

## 五、资源加载机制中最容易被忽略的细节

### 1. 资源包是可叠加的，而不是简单替换目录

Project Interface V2 允许一个资源配置包含多个路径，并按顺序加载，后加载资源覆盖前面的资源；资源还可以声明支持哪些控制器，并带 hash 校验。[Project Interface V2](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/zh_cn/3.3-ProjectInterfaceV2%E5%8D%8F%E8%AE%AE.md)

对当前项目可落地为：

```text
resources/base                  稳定模板和通用任务
resources/game-version-x        游戏版本差异
resources/controller-adb        ADB/模拟器差异
resources/overrides             用户本地覆盖
```

加载顺序固定并显示在诊断中；每个最终资源记录来源文件和 hash。用户覆盖只允许覆盖白名单字段，不能替换动作类型、shell 命令或安全策略。

### 2. 资源更新要可回滚

MAA 把动态资源放进独立的 `MaaResource` 仓库，降低核心程序与游戏数据变化的耦合。[MaaResource README](https://github.com/MaaAssistantArknights/MaaResource/blob/main/README.md)

当前项目不一定需要在线更新，但应先建立本地版本模型：

```text
manifest.json
  version
  game_build
  files[]: path, sha256, size
  compatible_controller
```

更新流程必须是：下载到临时目录 → 校验 manifest 和每个文件 → 编译/验证 Pipeline → 原子切换版本 → 失败保留旧版本。不要先删除当前资源再解压新包。

### 3. 不要把调试输出当长期资源

失败截图、OCR 中间图、识别标注图和 ADB 原始输出应有 `run_id`、数量/大小上限和清理策略。当前项目的 AGENTS 规则也要求截图与分析临时产物及时清除；Pipeline 的调试证据应默认短期保留，只有用户显式导出时才复制到诊断包。

## 六、针对当前代码的具体切口

### 1. `MainForm` 已经显示出需要拆分的边界

当前 [`MainForm.cs`](/F:/贪婪洞窟辅助/outputs/adb_map_controller/Presentation/MainForm.cs) 同时包含：刷新锁、设备连接、弹窗检测、楼层阶段、目标重算、路线启动、移动循环、传送门交互、秘境选择、UI 更新和关闭清理。`RunLoop` 里既有 10ms/50ms/80ms/120ms/180ms 等节奏控制，也有路线执行和 UI 弹窗业务。

建议拆成：

```text
MainForm
  └─ AutomationCoordinator
       ├─ SnapshotService
       ├─ OverlayPipelineRunner
       ├─ DungeonRunCoordinator
       │    ├─ FloorStateMachine
       │    ├─ Planner
       │    └─ RouteExecutor
       ├─ ControllerGateway
       └─ Event/Diagnostics bus
```

第一步不必移动所有代码：先将 `SelectBonusRoutine`、`HandleRiftGemSelection`、服务器异常弹窗和换层确认抽为 `OverlayPipelineRunner`，由 `RunLoop` 只接收 `OverlayResult`。

### 2. 当前最适合先配置化的流程

优先级从高到低：

1. 秘境宝石选择：识别标题/卡片 → 选卡 → 验证弹窗消失。
2. 换层确认：三类弹窗 → 确认/选择加成 → 验证楼层改变。
3. 战利品确认：识别确认按钮 → 点击 → 验证界面关闭。
4. 服务器异常：识别 → 释放触摸 → 取消运行 → 保存证据。
5. Boss 警告/复活/回城等后续流程。

这些流程都有清晰的 UI 状态和终止条件，适合验证 Pipeline；地图寻路本身暂时不要动。

### 3. 推荐的本项目最小协议

```json
{
  "name": "SelectNextFloorBonus",
  "entry": "DetectDialog",
  "nodes": {
    "DetectDialog": {
      "next": ["ServerError", "GreedySelection", "WarningConfirm", "PlainConfirm"],
      "poll_interval_ms": 150,
      "timeout_ms": 8000,
      "on_error": ["SafeStop"]
    },
    "GreedySelection": {
      "recognition": { "type": "direct_or_template", "key": "greedy_dialog" },
      "action": { "type": "select_bonus", "source": "profile.bonus_priority" },
      "post_settle_ms": 300,
      "next": ["VerifyFloorChanged"],
      "on_error": ["SafeStop"]
    },
    "VerifyFloorChanged": {
      "recognition": { "type": "lua_state", "predicate": "level != context.old_level" },
      "timeout_ms": 10000,
      "on_error": ["RetryPortal", "SafeStop"]
    }
  }
}
```

这个协议有意比 MAA 简单：没有字符串宏，没有任意 shell，没有无限等待，没有动态执行代码。`select_bonus`、`lua_state` 和 `RetryPortal` 是受控的 C# 扩展点。

### 4. 移动期间的弹窗必须是“可抢占监督层”

这是当前项目与普通页面自动化最大的区别。`MainForm.RunLoop` 在进入循环时检查弹窗，但一旦调用 `RouteExecutor.Execute`，执行器会在内部持续读取人物状态、保持触摸并等待路线段完成；因此弹窗可能在路线段中途出现，而外层 Pipeline 尚未得到执行机会。

正确模型不是两个线程同时随意操作 ADB，而是：

```text
MovementTask ────────────────┐
                              ├─ ControllerGateway（唯一输入出口）
PopupWatchdog ──> Interrupt ─┘
       │
       └─ 发现弹窗 → 取消移动 → 立即释放触摸 → 处理弹窗 → 复核状态 → 恢复/重规划
```

推荐分两级检测：

1. 高频、低成本：Lua 状态中的遮罩/场景/战斗/弹窗标志，或共享截图中的少量像素区域。
2. 低频、昂贵：模板识别和 OCR，只在低成本信号疑似命中时执行。

所有截图应由单一 `FrameHub` 采集并复用，不能让移动线程、弹窗线程和 UI 各自启动 `adb screencap`。所有点击、滑动和释放则由 `ControllerGateway` 串行化；弹窗检测线程只能发出 `InterruptRequest`，不能绕过网关直接点击。

`RouteExecutor` 可以增加一个受限的 `checkpoint` / `IInterruptProbe`：在现有 5ms 状态轮询点调用它，但 Probe 内部自行限频；发现高优先级弹窗时返回 `MotionInterrupt.Popup`。执行器先保证释放触摸，再结束当前移动调用，由上层处理弹窗。弹窗处理完成后必须重新读取权威玩家状态和地图 hash，不能从旧路线继续盲走。

需要区分三种结果：`Completed`（路线完成）、`Replan`（路线失效）、`InterruptedByPopup`（被弹窗抢占）。第三种不是错误，也不能被当作路线失败累计封锁格子。

## 七、性能取舍：当前项目不应复制“全屏 OCR 循环”

MAA Pipeline 明确提供识别速率限制、ROI、结果排序和画面稳定等待；这说明高性能助手的关键是减少无效识别，不是单纯换更大的模型。[Pipeline Protocol](https://github.com/MaaXYZ/MaaFramework/blob/main/docs/en_us/3.1-PipelineProtocol.md)

当前项目还多了一个优势：游戏 Lua 已经能输出地图和玩家状态。因此建议使用分层采样预算：

```text
高频：触摸释放/玩家位置/战斗状态
中频：地图快照/楼层阶段/可达目标
低频：弹窗模板/像素识别
更低频：OCR/复杂诊断
```

并加入三个优化：

- 同一个 `FrameId` 上多个节点共享截图，不重复 `screencap`。
- 结构化状态 hash 未变化时，不重建地图规划。
- OCR Worker 做持久进程或严格节流，不能在每轮轮询中冷启动。

当前已有 [`MapSnapshot.cs`](/F:/贪婪洞窟辅助/outputs/adb_map_controller/Domain/MapSnapshot.cs) 的结构 hash/导航 hash 和 [`RouteExecutor.cs`](/F:/贪婪洞窟辅助/outputs/adb_map_controller/Navigation/RouteExecutor.cs) 的高频位置复核，可以把它们作为 Pipeline 的共享观测缓存，而不是重新设计一套截图缓存。

## 八、可靠性与安全边界

MAA 有公开的代码审计 issue；该 issue 明确说明报告由 AI 生成、可能存在误报，但列出的风险类型仍然具有参考价值，包括命令注入、更新包完整性、下载地址校验、线程安全、无限循环/递归、远程控制权限等。[Issue #16829](https://github.com/MaaAssistantArknights/MaaAssistantArknights/issues/16829)

当前项目的 Pipeline 必须在协议层禁止以下事情：

- 任意字符串拼接 shell 命令；
- 未经白名单的外部程序执行；
- 无总时限的循环和等待；
- 任意 JSON 递归导致栈溢出；
- 识别不确定时的盲点；
- 后台线程直接访问 WinForms 控件；
- 资源更新覆盖用户配置或旧版本；
- 诊断文件无限累积。

特别是当前项目存在持续触摸/滑动控制，安全策略应该比一般“点击助手”更严格：任何识别失败、状态文件暂时不可读、分辨率变化、窗口失焦或设备连接异常，都应先释放触摸，再决定是否重试。

## 九、最终实施路线

### P0：抽出 Runner 和事件，不改变游戏策略

- 统一 `Start/Pause/Stop/Refresh` 命令。
- 统一 `run_id`、阶段、节点、重试和停止原因。
- 把所有 ADB/触摸调用经过一个 `ControllerGateway`。
- 先把当前秘境/换层流程包成强类型 `OverlayTask`，验证生命周期和证据记录。

### P1：引入有限 Pipeline

- JSON schema + 加载期编译。
- `DirectState`、Pixel、Template、OCR 四类识别。
- Click、Hold、Swipe、Wait、Release、SafeStop 六类动作。
- `next`、`on_error`、有限重试、总时限、稳定等待。
- 离线 fixture 回放测试。

### P2：资源与产品化

- 基础资源/版本变体/用户覆盖三层资源。
- manifest/hash/原子回滚。
- 预设配置和 `status --json`。
- 需要时再做 CLI、命名管道或 localhost API。

## 不应该借鉴的部分

- 不要现在引入完整 MaaFramework/C++ 核心。
- 不要把地图规划器改成通用 JSON 图。
- 不要复制 MAA 的复杂任务表达式语法。
- 不要因为 MAA 支持神经网络，就为当前地图助手强行引入模型。
- 不要未经许可证核查复制 MAA 的代码、模板或资源；主仓库是 AGPL-3.0-only，并附带额外条款。[MAA LICENSE](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/LICENSE)

## 深挖后的核心结论

MAA 最值得复制的是“把自动化做成一个有编译阶段、有时间预算、有事件协议、有资源版本和有安全边界的运行时”。对当前项目而言，最佳下一步不是增加识别算法，而是把 `MainForm.RunLoop` 里的 UI 阻塞流程变成一个受限、可测试、可回放的 `OverlayPipelineRunner`，并让地图规划与路线执行继续保持强类型领域实现。
