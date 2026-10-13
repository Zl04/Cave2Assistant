# Pipeline 运行契约（RU-04）

日期：2026-10-08。依据当前源码及生产程序集测试，不采用上游协议对本地实现作推断。

## 入口与隔离

MainForm.Automation 构造 MaaPipeline<MainForm>，入口 RunDungeon；DungeonEntryAutomation 构造自己的 MaaPipeline，入口“开始自动进图”。PopupWatchdog 使用 UiPipeline 单帧节点。2026-10-13 已删除无业务调用的 TaskPipeline、定义加载器、适配器及旧 schema；跑图动作直接返回 MaaPipelineActionResult。

MAA 实例包含 runId、taskId、transitions 和 executionCounts，必须顺序复用或每次新建。计数锁不代表整个 RunAsync 可并发。运行时不拥有设备，handler 负责释放自身资源并观察 token。UiPipeline 一次运行共用 frame/context。

## 资源与离线黄金路径

| 生产资源 | 加载器 | 自动验证 |
| --- | --- | --- |
| map-run-pipeline.json | MaaPipelineCatalogLoader | RunDungeon，JustReturn、handler、maxTimes；fake handler 完成一次链 |
| dungeon-entry-pipeline.json | MaaPipelineCatalogLoader | 两种协议字段规范化，所有引用提前编译；特殊地图在“判断当前地图类型”后先走“当前地图标题匹配目标”OCR，命中时直接去“选择关卡难度”，未命中时通过“切换地图类型”切页；fake hit 路径“开始自动进图”→“确保主城地图已打开”→“主城标题已识别”→“进入目标地图”→“判断当前地图类型”→“当前地图标题匹配目标”→“选择关卡难度”→“识别并选择关卡”→“点击挑战”→“确认进入地图”→“等待副本地图加载” |
| popup-watchdog.json | UiPipelineDefinitionLoader | ServerError→RiftGemSelection→NextFloorDialog，优先级10/20/30、各1次、3500ms |
| ui-pipeline.schema.json | schema说明文件 | 不是可运行任务资源，不传入 catalog 执行；实际加载器的验证规则仍以源码为准 |

两份 MAA 资源的测试只替换 handler，不修改资源中的 delay 或分支。它们不证明识别正确率或 Android 收到点击。复制资源采用测试工程 None 项，测试行为始终引用生产程序集。

## 配置字段与现有语义

- baseTask：继承；多文件同名无 baseTask 时合并字段，有 baseTask 时替换该任务定义。显式/隐式 @ 继承给未覆盖列表添加前缀。
- sub/next/onErrorNext/exceededNext/reduceOtherTimes：展开表达式，去重且保留首次顺序。支持 +、^、*、括号、#self/#none/#back 和 Task#next 等字段引用；重复表达式最终列表去重，不意味着重复执行。
- algorithm/recognition：JustReturn/DirectHit、MatchTemplate/TemplateMatch、OcrDetect/OCR、FeatureMatch；action 对象的 type/param 被规范化。已有本地字段优先于别名/嵌套参数。
- timeout：上一成功任务的后继候选等待期限；entry 初始等待为0。不是动作或识别硬限时。rateLimit 为候选循环间隔，未设时使用 runtime RetryInterval。RetryTimes 不约束当前循环次数。
- enabled：候选跳过；maxTimes：识别命中后、动作前检查，达到后走 exceededNext。执行前增加次数；reduceOtherTimes 在成功动作、sub、postDelay 之后减计数。
- action→sub→next：父动作先执行，每个 sub 顺序执行；sub 自身 next 不作为父链继续执行。subErrorIgnored 为真时忽略子任务失败/未命中/Stop 返回，否则父失败；owner 的取消异常仍传播。
- Stop 跳过 handler action；onErrorNext 处理当前动作/识别失败或上一节点候选等待失败；MaxTransitions 限制链循环，不能终止正在执行的非协作 handler。
- preDelay/postDelay：0–300000ms，随 token 取消。maxTimes/timeout/rateLimit 的取整、夹取及默认值保持当前加载器行为。
- roi/cache/rectMove/specificRect/specialParams/highResolutionSwipeFix、template/templThreshold/maskRange/colorScales/colorWithClose/pureColor/method/nmsDistance/index/orderBy、text/ocrReplace/fullMatch/replaceFull/isAscii/withoutDet/useRaw/binThreshold、count/ratio/detector/inputText：编译后的 handler 参数。新增测试冻结参数规范化和别名优先级；不是 runtime 对所有字段自行执行的承诺。
- trace 异常隔离；不保证 trace 保存成功。实际设备/native handler 耗时、继承表达式的全部组合仍需专项矩阵，不能将有限用例称为穷尽验证。

TaskPipeline 的 entry 不调用 CanRun，失败重试和 timeout 使用协作式 linked CTS；handler 忽略取消仍可能成功。UiPipeline 协作超时重试后继续 fallback，使用相同 frameId。既有12例 baseline 与新增16例 PipelineContractTests 共同冻结这些差异。
