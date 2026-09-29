# MaaAssistantArknights 官方仓库借鉴分析

> 分析日期：2026-09-17  
> 资料范围：仅使用 [MaaAssistantArknights/MaaAssistantArknights](https://github.com/MaaAssistantArknights/MaaAssistantArknights) 官方仓库 `dev-v2` 分支的源码、仓库文档、README、工作流与仓库内 issue。没有把第三方文章、博客或非官方实现作为依据。  
> 本文是架构研究，不修改本项目业务源码。

## 结论摘要

MAA 最值得借鉴的不是某一种 OCR 或模板匹配算法，而是把自动化系统拆成了几条相对稳定的边界：

1. `Assistant` 是稳定的任务门面，负责实例生命周期、任务队列、异步调用、停止和结构化回调。
2. `Controller` 只抽象连接、截图、点击、输入、滑动、启动/停止游戏等设备能力；ADB、Minitouch、Windows 窗口、模拟器扩展等是可替换实现。
3. `ProcessTask` 是通用流程执行器，把“识别候选 → 动作 → 子任务 → next/错误/次数分支 → 延时和重试”统一起来。
4. 任务配置与任务实现分离。`TaskData` 在运行前解析继承、虚任务和任务列表表达式，生成运行时任务对象；模板、OCR 规则、模型和任务 JSON 属于资源层。
5. 识别不是“只返回 bool”：模板匹配、OCR、特征匹配都带 ROI、命中框、得分、缓存、后处理和调试信息；动作目标与识别区域可以分开。
6. 插件是任务事件上的横切扩展点，适合做截图、统计、条件停止和额外信息；它不是把所有业务逻辑都塞进插件。
7. 发布体系把完整包、OTA、资源更新、发布准备、包分发和测试检查拆成不同工作流；仓库 issue 还明确记录了更新失败、旧文件清理和回退策略。

对 `F:\贪婪洞窟辅助` 的总建议是：保留现有地图领域模型、楼层状态机、规划器、路线执行器和 Lua 结构化状态；在它们外侧增加一个小型、强约束的 UI 阻塞流程层，并补齐统一事件、资源校验和离线回放。不要直接移植完整 MaaCore，也不要把地图寻路改写成通用 JSON 状态机。

## 1. 总体架构与模块边界

### 1.1 仓库层次

官方仓库的根目录把 `docs`、`resource`、`src`、测试、构建配置和 CI 工作流分开；`src` 下同时有 MaaCore、WPF/Avalonia/Mac GUI、CLI、更新器、语言绑定和桥接组件。这个布局表明“核心自动化能力”和“宿主 UI / 调用语言 / 发布工具”不是同一层。[仓库目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2) · [src 目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src)

`MaaCore` 自身只标注为“底层 C++ 模块”，并按 `Common`、`Config`、`Controller`、`Task`、`Ui`、`Utils`、`Vision` 分目录；它通过 `Assistant` 和 C API 对外提供能力。[MaaCore 目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore) · [MaaCore README](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/README.md) · [Assistant.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.h)

可以把主要调用关系概括为：

```text
GUI / CLI / 语言绑定
          │ 稳定 API + JSON 参数 + 回调
          ▼
      Assistant
   ┌──────┼────────┐
   │      │        │
任务队列  异步调用  消息队列
   │      │        │
   ▼      ▼        ▼
InterfaceTask  Controller  外部回调
   │           │
   ▼           ├─ ADB / Minitouch / Win32 / 模拟器扩展
PackageTask    └─ 截图、点击、输入、滑动
   │
   ▼
ProcessTask → TaskData / PipelineAnalyzer → Vision / Resource
```

这是源码结构和接口关系的归纳，不是仓库声明的一张官方架构图；依据是 `Assistant` 的任务/调用/消息线程成员、`Controller` 的能力接口以及 `ProcessTask` 对任务数据和识别分析器的调用。[Assistant.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.h) · [Controller.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Controller/Controller.h) · [ProcessTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/ProcessTask.cpp)

### 1.2 `Assistant`：稳定门面和生命周期所有者

`AsstExtAPI` / `Assistant` 暴露了进程级选项、实例级选项、连接、异步连接、异步点击、异步截图、添加任务、动态修改任务参数、启动、停止、运行状态、截图和任务列表等接口。任务调用方因此不必直接持有具体任务类。[Assistant.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.h) · [集成协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/integration.md)

`Assistant` 内部把工作线程、异步调用线程和消息线程分开，并分别维护任务列表、异步调用队列、回调消息队列及条件变量；工作线程一次从队首取任务链，消息再经过消息队列向外派发。[Assistant.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.h) · [Assistant.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.cpp)

`append_task` 先解析 JSON，再按任务类型创建 `InterfaceTask`；`start` 只负责唤醒工作线程，`stop` 进入 idle、清空任务并清理缓存。这个设计把“按钮/调用方发命令”和“具体任务运行”隔开，也使停止成为正式生命周期操作，而不是某个业务循环里的特殊异常。[Assistant.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Assistant.cpp)

### 1.3 任务分层

`Task` 目录分为通用基类、`ProcessTask`、`PackageTask`、`InterfaceTask` 和按领域组织的 `Fight`、`Infrast`、`Roguelike`、`SSS` 等；接口任务目录中还能看到 `StartUpTask`、`FightTask`、`InfrastTask`、`RecruitTask`、`RoguelikeTask`、`CustomTask` 等组合入口。[Task 目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Task) · [Interface 任务目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Task/Interface)

`AbstractTask` 统一处理启用/禁用、重试次数、停止检查、任务开始/完成/错误回调和基本信息；`InterfaceTask::run` 还会在包任务失败时保存接口调试图像。领域任务因此可以组合通用流程，而不必各自重写生命周期。[AbstractTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/AbstractTask.cpp) · [InterfaceTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/InterfaceTask.cpp)

## 2. 任务编排与状态机设计

### 2.1 `ProcessTask` 是识别驱动的流程状态机

`ProcessTask` 维护待识别任务列表，反复执行“从候选列表中找第一个命中的任务”。节点结果分为 `Success`、`RetryFailed`、`Runout`、`Interrupted`、`InternalError`：

- 成功后走当前节点的 `next`；
- 达到 `maxTimes` 后走 `exceededNext`；
- 重试耗尽后走当前节点的 `onErrorNext`；
- `Stop` 动作或停止信号产生 `Interrupted`；
- 子任务失败且未忽略时成为内部错误。

节点执行还包含 `preDelay`、动作、`postDelay`、执行次数统计和 `reduceOtherTimes`；识别失败会按任务级重试策略和间隔重新截图。[ProcessTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/ProcessTask.cpp) · [ProcessTask.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/ProcessTask.h) · [任务流程协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md)

这不是传统“枚举状态 + 每个状态写一大段 if/else”，而是“候选节点 + 命中后继”的状态机。`next` 的顺序具有优先级，并且一个节点完成后才重新识别下一组候选；因此可以将异常弹窗放在比普通按钮更优先的位置。[任务流程协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md)

### 2.2 配置加载期编译，而非运行时临时解释

`TaskData` 同时保存原始 JSON、未展开虚任务的任务信息和已经展开的运行时任务信息，并维护 `ToBeGenerate`、`Generating`、`NotExists` 等状态。访问任务时会按需生成并缓存；`baseTask`、任务列表表达式和虚任务在生成阶段被解析。[TaskData.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/TaskData.h) · [TaskData.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/TaskData.cpp)

官方任务协议支持 `baseTask` 继承、显式/隐式 `@` 任务、`#self/#back/#next` 等虚任务，以及任务列表的合并、差集和重复表达式；多文件加载还规定了同名任务的继承/覆盖规则。[任务流程协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md)

可借鉴的抽象是：

```text
JSON / 用户配置
      ↓
解析 + 默认值 + 继承
      ↓
展开引用 + 检查循环/资源/参数
      ↓
CompiledTask / CompiledPipeline
      ↓
单一 Runner 执行
```

但当前项目不需要复制全部表达式能力。对洞窟助手，三种有限覆盖已经足够：通用节点默认值、游戏版本变体、用户预设覆盖；任务图必须有节点数、嵌套深度、循环次数和总时长上限。

### 2.3 结构化回调和可观测生命周期

回调协议把消息分成全局信息、任务链信息、原子子任务信息和上报请求，明确区分开始、完成、错误、额外信息、手动停止；消息详情使用 JSON。[回调消息协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/callback-schema.md)

`AbstractTask::callback` 会先让已挂载插件按消息验证并运行，再调用外部回调；插件可以通过 `block()` 阻断后续插件。任务基本信息包含任务链、任务 ID、类名、子任务名和详情；`ProcessTask` 还把识别算法、命中结果和执行次数写入额外信息。[AbstractTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/AbstractTask.cpp) · [ProcessTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/ProcessTask.cpp)

对本项目最直接的落地形式是定义一组本地事件：`RunStarted`、`PhaseChanged`、`NodeRecognized`、`ActionStarted`、`ActionCompleted`、`Retrying`、`RecoveryStarted`、`RunStopped`、`RunFailed`。每条至少带 `run_id`、楼层、阶段、节点、快照序号、重试次数、耗时和原因；失败时关联截图、OCR 文本、Lua 状态、地图快照和路线证据。

## 3. 资源识别、OCR 与模板匹配

### 3.1 识别能力是可配置的多路选择

任务 schema 定义了 `JustReturn`、`MatchTemplate`、`OcrDetect`、`FeatureMatch` 四种基础算法，并把 `action` 单独定义为 `ClickSelf`、`ClickRect`、`Swipe`、`Input`、`DoNothing` 或 `Stop`。这使“怎么判断”和“判断后做什么”可以分离。[任务流程协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md) · [maa_tasks_schema.json](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/maa_tasks_schema.json)

`roi` 使用基准分辨率自动缩放，协议建议尽量缩小识别范围；`cache` 可以在第一次命中后复用固定位置，但只适合目标位置不变的界面。`specificRect`、`rectMove` 和识别返回的矩形承担不同含义，动作目标不必等于整个识别 ROI。[任务流程协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md)

### 3.2 模板匹配的工程化细节

模板任务支持单模板或多模板、阈值、灰度掩码、RGB/HSV 颜色计数、纯颜色模式和 NMS 距离；`Matcher` 使用 OpenCV 模板匹配，并在有掩码时使用优化路径或回退到 OpenCV。`MultiMatcher` 对多结果按阈值扫描，再按 NMS 距离保留得分更高的命中。[Matcher.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Vision/Matcher.cpp) · [MultiMatcher.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Vision/MultiMatcher.cpp) · [Vision 目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Vision)

可借鉴点不是照抄参数，而是为每个识别器记录：输入帧/截图 ID、ROI、模板名、阈值、实际得分、命中框、目标框、匹配路径和证据图。这样才能解释“为什么点了这个位置”，也能按实际得分调整阈值。

### 3.3 OCR 的分层与后处理

`OCRer::analyze` 先检查 ROI，再选择字符模型或词模型，调用 OCR 资源进行识别，随后过滤空文本/非法分数，修正坐标、去除首尾空白、执行正则替换，并按 required 文本和等价类过滤；支持全字匹配和子串匹配。[OCRer.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Vision/OCRer.cpp) · [Vision OCR 文件列表](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Vision)

任务协议还公开了 `withoutDet`、`useRaw`、`binThreshold`、`ocrReplace`、`fullMatch` 和 ASCII 文本等选项，说明 OCR 的稳定性依赖 ROI、预处理、模型选择和后处理的组合，而不是一次调用识别库。[任务流程协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md) · [maa_tasks_schema.json](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/maa_tasks_schema.json)

对当前项目建议使用三层成本顺序：

1. `DirectState`：Lua/JSON 状态、地图快照、玩家状态能回答的问题，优先不用视觉。
2. `CheapVision`：像素、颜色区域、小模板，处理方向按钮、图标和固定遮罩。
3. `ExpensiveVision`：OCR、多区域扫描、复杂特征识别，只在前两层不足时调用。

这符合当前项目已有的结构化 Lua 状态优势，也能把 OCR 保留为弹窗标题、奖励文本和未知界面的兜底，而不是让 OCR 承担地图模型职责。

## 4. 设备通信与控制器抽象

### 4.1 控制器接口边界

`ControllerAPI`/`Controller` 将连接、初始化状态、截图、点击、输入、滑动、按键、启动/停止游戏、回到主页、能力查询和缩放信息聚合为设备能力；具体控制器通过 `create_controller` 创建。任务层只调用这些能力，不需要知道底层是 ADB 还是触控服务。[Controller.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Controller/Controller.h) · [Controller 目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Controller)

当前目录中同时存在 `AdbController`、`MinitouchController`、`MaatouchController`、`Win32Controller`、`MaaFwAdbController`、`MaaFwAndroidNativeController`、`PlayToolsController` 和模拟器扩展实现。这种边界对替换输入后端、增加测试桩、处理不同分辨率很有价值。[Controller 目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Controller)

### 4.2 截图不是单一固定命令

ADB 控制器会在不同截图方法之间选择，包括 raw + nc、gzip、编码传输，以及可用时的模拟器扩展；它会记录各方法耗时并选最快方法，失败时可以重新探测/重连。[AdbController.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Controller/AdbController.cpp)

输入还要经过缩放代理：`Controller` 明确要求 click/swipe/inject input event 经过 scale proxy，以保证任务基准坐标和设备实际分辨率一致，并提供支持能力位查询。[Controller.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Controller/Controller.cpp) · [Controller.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Controller/Controller.h)

对本项目的借鉴重点是定义小接口而不是增加大量后端：

```text
IGameController
  Connect / Disconnect
  Capture
  Click / Swipe / ReleaseAll
  StartGame / StopGame / BackToHome
  GetCapabilities / GetScreenScale
```

当前 `AdbClient`、`TouchController` 和地图路线执行器应逐步通过这个接口协作；测试时用 fake controller 回放截图和动作，不让 `Planner` 直接依赖 ADB。

## 5. 配置、资源生命周期与日志

### 5.1 `ResourceLoader` 统一装配资源

`ResourceLoader` 按明确顺序加载 ONNX 模型、OCR 模型、通用配置、招募/战斗/OCR 配置、缓存、任务目录、OTA 相关数据和主题专属配置；任务配置支持 `tasks/*.json`，旧的单文件 `tasks.json` 被明确标记为弃用。资源加载失败会返回失败，不让系统悄悄使用半套资源。[ResourceLoader.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/ResourceLoader.cpp) · [ResourceLoader.h](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/ResourceLoader.h)

加载器还提供 `_custom.json` 覆盖、模板目录、用户目录缓存和异步加载队列；完成加载后生成 UUID，业务代码可以用 UUID 判断资源是否换代并刷新缓存。[ResourceLoader.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/ResourceLoader.cpp)

值得迁移到当前项目的是“内置资源 + 用户覆盖 + 运行时缓存”三层，而不是把模板、OCR 替换、地图图标和用户设置混在一个目录：

```text
内置资源        稳定随程序发布
用户覆盖资源    单独目录，优先级明确
运行时缓存      可删除、可重建，不作为真相源
```

### 5.2 配置有类型和边界

`GeneralConfig::parse` 从 JSON 读取版本、任务延时、战斗截图间隔、控制延时、ADB/Minitouch 滑动参数等，并对战斗开始超时执行最小值/最大值裁剪；这比在业务代码各处读取任意数字更容易验证。[GeneralConfig.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/GeneralConfig.cpp)

当前项目的新任务配置建议先做 schema/编译检查：未知节点、未知识别器、模板缺失、ROI 越界、非法正则、负延时、无终止循环都在启动前拒绝；运行期间只使用已经校验的不可变配置。

### 5.3 日志兼顾上下文、线程安全和诊断

MAA Core 的 `Logger` 是单例，提供 debug/trace/info/warn/error 等级；日志写入受 mutex 保护，日志行包含时间、等级、进程和线程信息，支持 scope 缩进、文件轮换、用户目录和 debug 模式控制，初始化时记录版本、构建时间和用户目录。[Logger.hpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Utils/Logger.hpp)

同一文件还定义了崩溃文件写入和信号/异常处理入口。这给当前项目的启发是把“错误日志”和“失败证据包”分开：普通日志记录事件，只有识别失败、路线死循环、ADB 超时或未处理异常才按保留策略保存截图、状态和配置摘要。[Logger.hpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Utils/Logger.hpp)

## 6. 插件、扩展与集成面

### 6.1 任务插件是横切扩展点

任务目录包含 `AbstractTaskPlugin` 以及截图、启动/停止游戏、多作业等插件类；`AbstractTask` 在回调消息时按顺序调用插件，插件可以验证消息、运行、禁用自身或阻止后续插件。[Task 目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Task) · [Miscellaneous 任务/插件目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Task/Miscellaneous) · [AbstractTask.cpp](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/AbstractTask.cpp)

适合插件化的功能包括：截图留证、任务统计、达到楼层后停止、外部报告、条件式取消和调试信息。地图图搜索、路径代价、危险目标策略等仍应由强类型领域模块负责，不应改成插件间隐式共享状态。

### 6.2 对外 API 是扩展面，不等于动态加载插件市场

README 明确列出 C、Python、Java、Rust、Go、Dart、TypeScript、Woolang 等接口，集成文档定义了 `AsstAppendTask` 等稳定调用协议；这说明 MAA 的主要扩展方式是“核心能力 + 语言绑定/宿主集成 + 任务资源”，而不是随意加载第三方 DLL。[README](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/README.md) · [集成协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/integration.md)

远程控制协议使用轮询获取任务、任务 ID 和结果回报，并明确警告公网明文 HTTP 不安全。[远程控制协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/remote-control-schema.md)

对当前项目，不宜现在就加入远程 HTTP 或动态 DLL。若将来需要自动化脚本入口，优先做本机 `status --json`、`run --once`、`stop`、`validate-config` 和 `export-diagnostics`；若以后开放网络控制，必须限制 localhost、鉴权、参数白名单、请求超时和生命周期校验。

## 7. 更新、资源发布与质量门禁

### 7.1 发布流程按职责拆分

官方仓库的工作流目录把 CI、单元测试、冒烟测试、资源同步、资源更新、发布准备、OTA、完整包分发和发布通知拆成独立工作流；这反映了“代码版本更新”和“任务/模板/游戏动态资源更新”不是一次相同的发布动作。[官方工作流目录](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/.github/workflows)

发行页同时展示完整版本包和增量/差分资产；仓库 issue 的手动更新说明要求更新失败时使用完整包修复，并警告不要把新旧目录直接覆盖，因为部分版本需要清理旧文件；资源更新也应与程序包更新区分。[官方 Releases](https://github.com/MaaAssistantArknights/MaaAssistantArknights/releases) · [官方 issue #10033：手动更新资源文件方法](https://github.com/MaaAssistantArknights/MaaAssistantArknights/issues/10033)

### 7.2 对当前项目的建议

当前项目已有 `outputs/adb_map_controller/publish/` 作为交付目录，资源发布可采用如下流程：

1. 生成资源 manifest：版本、游戏版本、资源类型、文件列表、SHA-256。
2. 下载到临时目录并完整校验；不通过就保留旧资源。
3. 在新资源目录完成 schema、模板存在性和最小识别回放检查。
4. 原子切换当前资源指针，旧版本保留一个可回退副本。
5. 更新失败时显示“继续使用旧资源/修复/导出诊断”，不要半覆盖运行目录。

这借鉴的是 MAA 的资源装配、工作流拆分和手动更新教训，不要求当前项目建立 OTA 差分包。

## 8. 与 `F:\贪婪洞窟辅助` 的现状对照

### 8.1 当前工程已经具备的强项

本项目主要程序位于 `outputs/adb_map_controller`，已经形成了清晰的 C# 分区：`Domain` 保存地图/会话模型，`Navigation` 保存楼层状态机、规划和路线执行，`Infrastructure/Adb` 负责设备通信，`Infrastructure/Automation` 负责视觉和弹窗自动化，`Presentation` 负责 WinForms，另有独立 `OcrWorker` 和多组回归测试。[项目文件目录](../../outputs/adb_map_controller) · [项目重构计划](../../outputs/adb_map_controller/REFACTOR_PLAN.md)

现有设计已经包含几项比普通截图脚本更强的领域约束：地图快照与结构 hash、楼层状态机、目标策略、路线规划、停滞/震荡/偏移恢复、触摸释放、传送门流程、Lua 导出的地图和人物状态，以及路线锁/地牢入口/崩溃/补丁等回归样本。[Domain 模型](../../outputs/adb_map_controller/Domain/Models.cs) · [MapSnapshot](../../outputs/adb_map_controller/Domain/MapSnapshot.cs) · [FloorStateMachine](../../outputs/adb_map_controller/Navigation/FloorStateMachine.cs) · [Planner](../../outputs/adb_map_controller/Navigation/Planner.cs) · [RouteExecutor](../../outputs/adb_map_controller/Navigation/RouteExecutor.cs) · [VisualNodeLocator](../../outputs/adb_map_controller/Infrastructure/Automation/VisualNodeLocator.cs) · [AdbClient](../../outputs/adb_map_controller/Infrastructure/Adb/AdbClient.cs)

项目根目录的既有记录还明确要求：地图探索和下楼是不同逻辑，未探索不能直接当作不可达，换层/弹窗期间必须暂停移动，坐标与路线需要复核；这些是本项目自己的领域真相，不应被通用任务管线覆盖。[MEMORY.md](../../MEMORY.md) · [GAME_SOURCE_ANALYSIS.md](../../GAME_SOURCE_ANALYSIS.md)

### 8.2 推荐的最小落地架构

```text
MainForm / CLI
       │ 命令、配置、事件订阅
       ▼
AutomationRunner（单一自动化所有者）
       │
       ├─ UI TaskPipeline：弹窗、奖励、传送门、复活、秘境选择、返回城镇
       │       └─ DirectState / Pixel / Template / OCR
       │
       └─ FloorStateMachine → Planner → RouteExecutor
                                  │
                                  ▼
                         IGameController → ADB / TouchController
```

建议按以下优先级实施：

| 优先级 | 借鉴 MAA 的内容 | 当前项目的适配方式 |
|---|---|---|
| P0 | `Assistant` 的命令/队列/停止语义 | 抽出 `AutomationRunner`；UI 只提交 `Start/Pause/Resume/Stop/Refresh/SingleStep`，Runner 是唯一驱动路线和弹窗的对象 |
| P0 | `Controller` 能力边界 | 用 `IGameController` 包住现有 `AdbClient` + `TouchController`；先不增加新的设备后端 |
| P0 | `ProcessTask` 的后继、重试和错误分支 | 只为阻塞式 UI 做轻量 `TaskPipeline`，节点支持识别、动作、`next`、`on_error`、次数上限和 deadline |
| P1 | `TaskData` 的加载期检查 | 启动任务前编译 JSON，检查引用、模板、ROI、正则、循环和嵌套深度；运行时使用不可变结果 |
| P1 | 统一识别结果 | 引入 `RecognitionResult`：`matched/confidence/box/target/source/frame_id/timestamp/evidence_id` |
| P1 | 回调协议和插件 | 以事件订阅实现截图留证、统计、到层停止和诊断，不把这些横切逻辑散落进每个状态 |
| P1 | `ResourceLoader` 的覆盖/缓存分层 | 内置模板与 OCR 规则、用户覆盖、可重建缓存分目录；资源用 manifest + hash + 原子切换 |
| P2 | 多语言 API / 远程控制 | 只在本地 CLI 或命名管道需求真实出现后再做；先不开放公网 HTTP |

### 8.3 不宜照搬的部分

- 不要直接引入完整 MaaCore C++、多语言 FFI、跨平台 GUI 和全部依赖。当前项目已经是 WinForms + C# + Lua + ADB，完整移植会把资源、线程、构建和部署复杂度一起引入，收益不匹配现阶段目标。
- 不要把地图规划改写成通用任务 JSON。`Planner` 的图搜索、目标优先级、危险目标和路线恢复是洞窟领域逻辑，保留强类型代码更容易维护和验证。[Planner.cs](../../outputs/adb_map_controller/Navigation/Planner.cs) · [TargetPolicy.cs](../../outputs/adb_map_controller/Navigation/TargetPolicy.cs)
- 不要在所有页面优先 OCR。当前已有 Lua/JSON 结构化状态，像素和小模板通常更快、更可控；OCR 只处理结构化状态不能覆盖的文字条件，并必须记录原文、置信度和后处理规则。
- 不要把 MAA 的复杂表达式、无限任务计数或子任务套娃原样复制。当前只需要有限继承和有界循环；所有任务都应有取消、单节点超时、全链路 deadline 和最大执行次数。
- 不要把“识别 ROI”“命中框”“实际点击目标”混成一个坐标字段。地图移动和停靠点对释放后复核很敏感，动作必须消费经过缩放和安全检查的明确 target。
- 不要直接复制官方仓库的代码、模板、图标或模型资源。README 声明主项目采用 AGPL-3.0-only，并附有额外用户协议和 logo 限制；架构思想可以参考，代码和素材需单独核对许可证与分发义务。[官方 README 的许可证与声明](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/README.md) · [LICENSE](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/LICENSE)
- 不要现在就做动态插件加载市场或公网远程控制。先用进程内接口和本地事件；远程协议的安全边界、鉴权和失败回退在需求明确后单独设计。[远程控制协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/remote-control-schema.md)

## 9. 建议的执行顺序

1. 先建立 `IGameController` 和 `AutomationRunner`，保持现有地图规划和路线行为不变；给 `Stop`、窗口关闭、ADB 超时和弹窗出现定义统一急停/释放语义。
2. 增加只处理阻塞式 UI 的 `TaskPipeline`：DirectState、像素/模板、OCR 三类识别；节点有 `next`、`on_error`、最大次数、单节点 timeout、总 deadline 和安全停止动作。
3. 为识别、动作、恢复、换层和失败证据定义结构化事件；将现有回归截图和状态 JSON 转成离线 fixture，测试“输入快照 → 识别 → 状态迁移 → 动作计划”，不依赖真实设备。
4. 再建立资源 manifest、用户覆盖目录、校验/原子切换和一键导出诊断；只有在本地 CLI 有明确需求时才增加命令行或命名管道。

最终判断：MAA 对本项目的高价值借鉴是“稳定边界 + 数据驱动的易变流程 + 有界重试 + 结构化事件 + 可回放资源”，不是“把整个项目重写成 MAA”。

## 资料索引

- [官方仓库 `dev-v2`](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2)
- [README](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/README.md)
- [MaaCore](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore)
- [任务流程协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/task-schema.md)
- [回调消息协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/callback-schema.md)
- [集成协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/integration.md)
- [远程控制协议](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/docs/zh-cn/protocol/remote-control-schema.md)
- [TaskData](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/TaskData.cpp)
- [ResourceLoader](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Config/ResourceLoader.cpp)
- [ProcessTask](https://github.com/MaaAssistantArknights/MaaAssistantArknights/blob/dev-v2/src/MaaCore/Task/ProcessTask.cpp)
- [Vision](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Vision)
- [Controller](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/src/MaaCore/Controller)
- [官方工作流](https://github.com/MaaAssistantArknights/MaaAssistantArknights/tree/dev-v2/.github/workflows)
- [官方 Releases](https://github.com/MaaAssistantArknights/MaaAssistantArknights/releases)
- [官方 issue #10033](https://github.com/MaaAssistantArknights/MaaAssistantArknights/issues/10033)
