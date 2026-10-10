# 保行为测试计划与当前覆盖

日期：2026-10-08（RU-02后更新）。测试冻结当前语义，包括已知不理想行为；测试通过不授权更改业务规则。RU-02只调整测试工程和文档，未触碰生产源码或设备。

阶段结论补记（2026-10-09）：用户确认实际跑图/自动进图正常，并明确触摸时序、弹窗抢占、RunLoop可视为核验通过；当前阶段不要求相关剩余自动化/设备trace或RU-09/10/13、RU-12闭环。验证报告必须区分用户实际使用确认与自动化覆盖；关闭交接、视觉缺样本、局部时间常量命名仍是已知非阻塞项。

RU-15前历史执行记录：RU-03/04/05/06/07/08/11/14生产接管或保障完成；RU-09/10/13仍有自动化覆盖缺口，RU-12未开始但当前阶段不要求闭环。Debug与Release主142/142、baseline52/52均通过，0失败/0跳过。主工程新增88例。用户确认实际跑图、自动进图、触摸时序、弹窗抢占、RunLoop均正常，作为本阶段用户实际使用核验通过；这不等同于所有专项硬件trace。关闭交接、视觉缺失样本和其余时间常量命名均保留为非阻塞已知缺口。

RU-15后最新Release完整验证（2026-10-09）：主测试156/156、独立baseline51/51，0失败/0跳过；两套均直接按各自工程配置执行。独立用例比历史记录少1，是已有工作区修改删除一条LootConfirm InlineData，本次重构没有改测试。新增加的生产模块边界仍由现有AdbClient生产程序集测试覆盖。设备行为的用户实际使用核验与自动化证据分开记录；当前阶段按用户要求接受已有验证，不要求补全剩余trace。

## 1. 可复现命令与结果

在项目根目录执行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/Verify-RefactorBaseline.ps1
# 默认包含生产项目与两套测试。当前预期exit 0。
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/Verify-RefactorBaseline.ps1 -CoreOnly
# 仅用于明确标识的局部表征测试；不能作为发布或生产重构准入。
# 下一阶段恢复完整基线后：
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/Verify-RefactorBaseline.ps1 -Publish
```

SDK 8.0.401 / VSTest 17.11.0。Debug与Release生产引用测试均 **142/142**、独立baseline均 **52/52**；完整Release验证脚本exit 0，Release build 0 warning/0 error。本轮未发布；正式publish目录内native部署/装载仍未验证。

主工程通过ProjectReference使用真实生产类型，RU-02阶段五份baseline手写测试（48例）加原有6例共54例。此后新增88例均只加入主工程，当前预计142例。独立工程复用原有4例及新增48例，共52例；原SettingsStoreTests两例只在主工程，故两工程数量不同。主工程不链接生产源文件并排除baseline生成源码；Fixture复制到输出目录。未改业务断言或预期。

源码链接式 fallback 的局限：同一个测试程序集编译选定生产源文件，不能发现主 csproj 的资源/native 装载、生产程序集边界、漏掉的设备类或真正的 UI 行为；链接后 internal 可见性与真实程序集不同，因此新增用例只调用 public seam。独立项目不复制/修改生产代码，不替代原 ProjectReference 测试。

脚本及 Directory.Build.props 将主/原测试/独立测试的输出分别放在各自 publish；构建开始前按精确应用名+项目路径检查并停止本项目程序。结果文件在本次 `.verification-<guid>` 中；解析 Counters 后 finally 删除，`.build` 同样清理，不改旧 publish 交付物。

## 2. 已实现自动保障清单

| 来源 | 用例数 | 已锁定行为 | 不代表什么 |
| --- | --- | --- | --- |
| 原 RouteExecutorTests / DungeonSessionTests / OperationTrackerTests 的源码链接 | 4 | 过期路线不输入；单格脉冲+seq 确认；Reset 基础字段；单个活动任务等待 | 原生产项目成功运行、多任务并发、设备 touch |
| baseline/StateAndJsonBaselineTests.cs | 20 | 非法 Transition 应用+记录，Set 绕过；Stop 与 Reset 差异；中断 first winner/输入复制/32竞争请求；弹性 int 5 类输入；tile 容错/只读写入；跨层/坏雾长度/混乱清理；snapshot 非深不可变；弹窗 5 类确认阈值 | ReadMap 原子性、完整 JSON 重试、真实 watchdog、楼层流程 |
| baseline/RouteSafetyBaselineTests.cs | 8 | 空路线即使取消仍 Completed；持有后读错/取消/偏离释放；popup 返回独立状态；down失败不补up；up失败覆盖原异常；120ms 无新 seq 重规划 | 触摸后端物理配对、负 lead、真实紧急停止 |
| baseline/PipelineBaselineTests.cs | 12 | MAA action→sub→next/maxTimes/顺序重跑/Stop/trace异常；MAA action不受timeout限制，候选超时后onError；owner取消handler finally；Task entry跳过识别/失败重试/协作超时/取消不重试/忽略取消仍可成功；UI共享帧fallback | 全部 MAA 继承表达式、真实资源运行、硬超时、非协作handler终止 |
| baseline/PortalLearningBaselineTests.cs | 5 | 一格邻近落点学习；Reset清边；不移动/两格外/跨层拒绝；随机才静态候选fallback | 解锁关联、随机多目的地、MainForm防回跳 |
| baseline/SettingsFailureBaselineTests.cs | 3 | 缺失/损坏=null，失败保存不抛错且无tmp，覆盖保留值 | 设置诊断新增功能、所有权限/磁盘故障类型 |
| VisualFrameReplayTests / VisualFixtures | 2 | 一张真实游戏负帧；用户提供的6张帧覆盖普通/警告换层、宝石、贪婪继续-only/回城-only/混合卡，并验证颜色与卡片索引 | server-error/Loot正例、purpose-built近似负例、其它分辨率/动画及OCR/native准确率 |

Fixture：`Fixtures/maa-semantics.json`（虚拟 handler、无设备动作）和 `tolerant-tile.json`（合成字段异常，不冒充设备快照）。复制到测试输出后使用；设置测试仅在输出目录下创建唯一临时目录并 finally/Dispose 删除。JSON 全局诊断的用例禁止与其它 collection 并行。异步超时用例使用 CT 驱动，不断言毫秒级墙钟；外层 WaitAsync(5s) 仅是失败保护，不是生产硬超时契约。

## 3. 核心契约 C01-C09

每个表覆盖正常 I/O、状态、异常、取消/超时、资源、顺序与回归方法。源码是描述现状，不是理想行为规范。

### C01 MainForm.RunLoop

证据：Presentation/MainForm.Automation.cs:190-512，RunDungeonTaskCore:91-188；DeviceMap:191-242；Planning 各门控。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | ready map + route + owner；循环规划/执行/交互直到停层、取消或停止；RunLoop 无结果值，handler 可能返回 Success |
| 状态变化 | session地图/路线/目标、floorPhase、pending portal、coroutine、停止标记；战斗只释放和等待，保留路线及目标 |
| 异常路径 | RefreshMap失败可能留下旧map；循环一般异常 Error后吞掉，未必使Pipeline失败；不能在迁移时改成统一throw |
| 取消/超时 | owner控制整体；popup只交接slice；nullmap/战斗等待120ms、转场等待80ms、房间门5000ms、VerifyTransition8000ms均保持 |
| 资源 | finally StopAll coroutine、TouchUp尝试、清runCts引用、dispose owner；重复Dispose CTS当前存在，迁移时先明确唯一owner |
| 调用顺序 | popup→刷新(可能跳一次)→overlay/gem→mapready→battle→floor更新→pending portal/load→目标停层→快捷入口→reconcile/route→bonus/verify→交互或移动。交互前up→20ms→ReadPlayer→坐标检查；Replan先强制刷新再规划 |
| 回归方案 | 待补事件日志fixture：battle→恢复、任务停靠过冲、refresh false旧map、popup/owner同时到来、目标停层优先于快捷门、异常映射Success；当前纯测试只间接覆盖路线端口，不覆盖主循环 |

### C02 RouteExecutor.ExecuteDetailed

证据：Navigation/RouteExecutor.cs:26-193。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | <2格Completed；过期起点Replan且零输入；多格直线down，单格pulse；最早有效任务/portal停靠限制执行范围；结果区分Completed/Replan/Popup |
| 状态变化 | 更新地图player/confusion/fog、runtime speed/pulsefallback、blocked；只同层应用player，fog还需尺寸及长度一致；boundary分支直接赋player，不能假装与ApplyPlayerStatus完全相同 |
| 异常路径 | IO/observer错误冒泡；down await成功才held=true；up finally错误可覆盖原错，这是待修缺口 |
| 取消/超时 | token在等待和读后检查；ReadPlayer不接受CT；popup OCE变Interrupted；普通OCE传播；release后等seq最多120ms，无新seqReplan而不终止整个跑图 |
| 资源 | 逻辑held在finally调用up；这不覆盖失败的partial down，不覆盖pulse后端异常的物理held |
| 调用顺序 | 输入→5ms/ReadPlayer→状态应用→偏离/横跳/预测/受阻→release→5ms后新seq复核→下一段；最终房间门跳变可能直接Completed再由主循环确认学习 |
| 回归方案 | 已实现原2+新增8及状态应用用例；待补turn、负lead、stall/blocked、四点横跳、停靠限制、portal跳变、boundary跨层、observer/up抛错组合；真机验证输入字节/时序 |

### C03 PopupWatchdog

证据：Infrastructure/Automation/PopupWatchdog.cs:47-151；PopupDetectionPolicy.cs:10；Movement.cs:344-367。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | enabled且无interrupt时采一帧、跑同帧pipeline；无匹配清candidate；server/gem/nextfloor一帧，loot两帧；watchdog不自行点击 |
| 状态变化 | candidate+frames属于此次watchdog；MotionInterrupt first winner携带对话类型/返回卡；无活动slice也必须锁存 |
| 异常路径 | probe失败节流2s报告后继续；EmergencyRelease错误报告后仍detected；回调抛错可能进入外层处理，不能假定所有回调绝不失败 |
| 取消/超时 | 自己的CT取消循环及120ms delay；native OCR/共享capture可能还在完成；popup不得取消整个owner |
| 资源 | using释放返回frame clone；RunMovement finally取消并await watchdog；不能仅cancel然后Dispose ADB/OCR |
| 调用顺序 | frameId→capture→pipeline→确认帧数→Request赢得锁存→cancelCurrentMovement→(活动则)EmergencyRelease→detected；主循环先消费后恢复 |
| 回归方案 | 已测MotionInterrupt+阈值；新增fake ADB生产程序集测试覆盖同FrameId共享、waiter独立取消、不同FrameId重捕、Disconnect清缓存及Bitmap clone；仍不是PopupWatchdog集成。待fake probe脚本None/A/A、disabled、idle latch、release fail、owner cancel；保持序列及shared frame；M03真机 |

### C04 FloorStateMachine / 楼层转场

证据：FloorStateMachine.cs:21-47、MainForm.Automation.cs:244-305、Planning.cs 的 UpdateFloorPhase。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | Transition总返回true；same phase不追加诊断；非法仍应用；Set直接应用；不能改为拒绝或默认抛错 |
| 状态变化 | Current+invalid queue；session还拥有level、portal candidate、确认次数/时间，FSM没有独占全部楼层状态 |
| 异常路径 | 非法转换仅诊断；当前MainForm.cs:74 setter调用Transition，会记录非法转换；等待超时在RunLoop恢复GoToPortal并清候选/次数；无“非法就停”的约定 |
| 取消/超时 | FSM同步无CT；owner取消由外部等待流程控制；新楼层等待配置及8s核验期限保持 |
| 资源 | 无外部资源；诊断队列目前不随Reset清空，不可偷偷清掉后宣称完全等价 |
| 调用顺序 | 更新地图/level→floor判定→处理等待/门控→portal交互→奖励→verify→检测新层/加载延时；Set和Transition调用不能互换 |
| 回归方案 | 当前测合法/非法/same/Set；待实际阶段序列fixture、换层成功/失败/恢复、加成弹窗暂停时钟、stop/reset轨迹；M04 |

### C05 AdbClient（含断线重连与JSON）

证据：AdbClient.cs:50-61,153-355,359-458,748-954；新增transport/capture仅候选实现。当前不能构建，以下是旧方法体的静态语义，非当前可运行实测。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | Serial、root检测、屏幕/SDK/后端ready、map/player/screenshot/助手；Connect同serial+ready使用缓存；同serial Setter无reset，断线重连需Disconnect/reset边界 |
| 状态变化 | 切Serial清旧backend、root/session、尺寸/触摸payload/cache等；新旧transport状态不能双owner；JSON地图/player分别读，不保证同一个原子快照 |
| 异常路径 | root/su fallback、非零退出/root marker错抛错；不存在导出文件转FileNotFound；base64 FormatException回退raw；JsonException最多20次后InvalidData；字段容错仍默认值。Tile=false进入converter返回墙，但reference converter默认不处理JSON null，null仍为null，不能误称所有空tile都被规范化 |
| 取消/超时 | command5000ms、持久shell锁/逐行3000ms、screenshot5000ms；一般Run/ReadPlayer无CT；截图可CT并kill；timeout不是整条用例的统一期限 |
| 资源 | 进程stdout/stderr、shell、backend、capture锁、cache、OCR由设备owner释放；现Dispose还引用被移除锁且没接管新组件，需迁移成对处理 |
| 调用顺序 | gate→Serial/reset→root→touch ready；切换必须先停止旧活动用例；map→player→合并状态→学习portal→replace session；root command→status printf→flush→读marker |
| 回归方案 | RU-01先编译；待fake adb进程参数/输出/超时kill/标记partial/rawfallback/缺文件/20次JSON重试；真实断线同serial重连、不同设备切换、root权限变化M01 |

### C06 MaaPipeline

证据：MaaPipeline.cs:893-1192、loader:134-640。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | catalog+handler+entries→Succeeded/Failed/Canceled/Stopped/TransitionLimitReached；入口按候选识别，JustReturn跳识别；第一个命中优先 |
| 状态变化 | 每run重置runId/taskId/transitions/counts，matched节点在action前增次数；same实例只顺序复用，不能并发 |
| 异常路径 | 识别非OCE/动作错误进Failed/onErrorNext；trace异常吞掉；sub失败依SubErrorIgnored；owner取消OCE返回Canceled；其它OCE路径不可泛化为Canceled |
| 取消/超时 | token传给handler和delay；上一任务TimeoutMs作用于next候选多轮未匹配的等待，entry timeout参数为0；不强停recognizer或action；RetryTimes当前不用于识别循环次数约束 |
| 资源 | runtime不拥有设备；handler负责自身finally/帧；不因报告Canceled就假定native动作已退出 |
| 调用顺序 | recognize→maxTimes判断→increment→predelay→action→sub顺序执行→postdelay/reduce→next；error/limit/Stop采用各自分支和trace |
| 回归方案 | 已实现7个MAA用例；待compiler继承/@/表达式、多文件覆盖、sub错误忽略、onError识别异常、入口多候选、transitionlimit、真实资源加载、非协作handler标记；M07 |

### C07 TaskPipeline

证据：TaskPipeline.cs:234-384，定义loader:411起。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | definition/handlers/state→四种状态；entry直接执行不调用CanRun；next候选顺序CanRun；节点失败按MaxAttempts重试 |
| 状态变化 | hitCounts为run-local，成功才增加；maxTimes→exceededNext；与MAA count/action语义不相同 |
| 异常路径 | execute一般异常转失败/重试/onError；CanRun异常没有相同捕获边界；event sink异常隔离 |
| 取消/超时 | node linked CTS CancelAfter是协作式；handler无响应就仍等待；没有统一postreturn取消检查，最终节点忽略cancel可Success；owner OCE终止不重试 |
| 资源 | 每attempt nodeCTS using释放；handler释放资源；不能因timeout丢弃Task让设备动作继续脱管 |
| 调用顺序 | first-attempt predelay→NodeStarted→execute→成功计数/失败记录→retry/postdelay→candidate selection；entry/next门禁差异保留 |
| 回归方案 | 已实现4个Task用例；待next优先级/onError/ExceededNext/transitionlimit/CanRun错误/loader兼容；不删除legacy；与MAA对照但不要求相同结果 |

### C08 DungeonSession.Reset、Stop 与多任务关闭

证据：DungeonSession.cs:37-96；MainForm.cs:281-299；Movement.cs:344-389；ControllerRuntime.cs:35-41；OperationTracker.cs:13-23。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | Reset设备边界清Map/路线/runtime/机关/门图/目标/楼层/中断；StopAutomation保留Map、机关、InteractedChambers、ObservedLevel、时间与速度但清路线、目标、门图和fallback |
| 状态变化 | Reset/Stop不是互换别名；FloorState诊断仍保留；UI flags/coroutine另有owner，不在session里自动Dispose |
| 异常路径 | shutdown Stop/idle/Dispose异常分别报告并尽力继续；StopMovement若await activeMovement抛错，可能跳过后面的activeEntry await，finally只清旗标；必须用测试确认，不能假定已等全部 |
| 取消/超时 | close先closing拒收→cancel run/entry→release→await；没有整体close超时；WhenIdle等当下Task快照，不处理未来新增；当前UI上下文约束 |
| 资源 | refreshLock后runtime释放Touch/Adb/Web；Touch.Dispose不发up；等待watchdog/OCR/capture边界未证实完全安全；不得先Dispose再等Task |
| 调用顺序 | 拒收/停timer/保存→StopMovement→uiOperations idle→refresh lock→runtime Dispose→timer Dispose→Close；device change必须先停旧运行再Reset |
| 回归方案 | 已有单tracker+Reset/Stop用例；缺多任务取消/异常后继续等其它任务、synchronous action throw、关闭重复事件、活动OCR/native、取消后fixture资源零泄漏；M08 |

### C09 TouchController / backend 配对与紧急停止

证据：TouchController.cs:23-108；TouchBackends.cs:58-118。

| 项目 | 必须保护的当前语义 |
| --- | --- |
| 正常输入/输出 | down/turn先ready→release旧接触→取消检查→发down→记held；up无cancel以允许清理；pulse整体swipe，时长至少1ms，backend clamp保持 |
| 状态变化 | heldPoint为成功down的逻辑状态；ReleaseCore发up之前清null，失败后不保留held；MovementCancellation仅在显式token不可取消时fallback，不是二者链接 |
| 异常路径 | Send失败调用InputFailed再rethrow；订阅者若抛错可覆盖原错；partial down和swipe异常没有自动finally up保证，不新增静默补发 |
| 取消/超时 | lifecycle gate不接受CT；gesture内部delay不接受CT；EmergencyRelease排队，不是抢占；pulse完成后才检查取消 |
| 资源 | gate finally Release；Touch.Dispose只清本地hold；agent/socket/writer由backend Dispose；必须在backend还活着时release |
| 调用顺序 | lifecycle完整手势锁→旧up→newdown/swipe→gate释放；不得把锁缩为单次发包导致急停插入半手势 |
| 回归方案 | 当前只测RouteExecutor请求配对，未测TouchController本体；待fake触摸通道byte transcript/部分写入/订阅错误、持续down急停、pulse期间急停、断线时up及后端重建；M02 |

## 4. 尚未覆盖的高风险行为及准入门槛

| 门槛 | 未覆盖范围 | 需要的证据 | 阻止的重构 |
| --- | --- | --- | --- |
| G0 | 生产编译/原测试已绿；native资源发布尚未验证 | 当前完整脚本成功；正式交付前需标准根publish/运行依赖核验 | 涉及发布/依赖装载的重构及交付 |
| G1 | ADB断线/重连/root/标记/进程kill | fake进程transcript+M01设备日志 | transport/assistant替换 |
| G2 | partial down、up失败、pulse/急停物理配对 | fake backend byte序列+M02；异常状态恢复获业务确认 | touch抽象/取消/锁/时序调整 |
| G3 | watchdog与move交接、战斗等待、刷新失败旧map | 同一事件trace+M03/M05 | MainForm编排迁移 |
| G4 | floor/gem转场、停层门控、门户解锁/多边/防回跳 | map/phase序列fixture+M04/M06 | 楼层和portal用例迁移 |
| G5 | MAA编译协议、真实资源、native OCR/frame生命周期 | 资源golden+正负截图+M07 | Pipeline拆分或probe队列 |
| G6 | 多任务取消/关闭/native工作耗时/释放 | UI上下文测试+M08进程/资源记录 | 生命周期owner转移 |

## 5. 设备回归手册（待单独授权执行）

执行前记录设备serial、Android SDK、root方式、touch后端、屏幕尺寸/旋转、游戏及助手hash、pipeline/model/template指纹。采用安全地图/测试账号；测试过程中不安装新的助手、不改设备协议、不对陌生设备操作。

| ID | 操作场景 | 观察与验收 |
| --- | --- | --- |
| M01 | 运行前断线、长按中断线、同serial重连、切另一设备 | 原命令错误/超时、shell/backend重建、旧hold/session不跨设备；root/su行为一致；记录不保证瞬时up的缺口 |
| M02 | 单格、长直线、转角、负lead、持续down急停、pulse期间急停、up发送失败 | 请求/设备字节及释放时间线；同一后端配对；急停实际延迟与现有规则相符，不设未经确认的新SLA |
| M03 | 长按/空闲时server/gem/loot/nextfloor覆盖；连续帧与disabled专用流程 | latch→slice cancel→release→主循环消费；owner不误取消；空闲也latch；无overlay下误报单独统计 |
| M04 | 换层成功、加成选择、服务器延迟/不换层、停层目标 | floor phase和时间线；8s恢复、新层加载延时、最终停层顺序一致 |
| M05 | 行走进战斗、胜利/逃跑、地图读取失败和过期路线 | battle先release并保留路线；恢复由权威坐标执行/重规划，不能复用过期起点 |
| M06 | 固定/随机房间门、一格邻近落点、无可确认落点、解锁后怪物消失 | 只学习同key证据、多边不压成单边；目的端防立即反向回跳；Stop/Reset清图 |
| M07 | 候选永不匹配、动作/识别卡顿、重试错误恢复、owner取消 | trace真实顺序；区分candidate timeout与action耗时；停止后没有后台设备动作假装结束 |
| M08 | 地图刷新+跑图/入口+watchdog时关闭；异常任务和重复关闭 | 拒收新任务、cancel/release/await顺序、无残余项目agent/OCR工作在Dispose对象上运行；无Task/Bitmap/句柄泄漏证据 |

记录前后版本、输入序列和trace，不只写“通过”。设备错误恢复或既有容错是否应改变，由用户另立功能/修复决策；本阶段不得以消除测试告警为由修改业务。
