# 可执行重构 Backlog

状态（2026-10-09，最新）：RU-01至RU-08、RU-11/14已完成；本轮新增RU-15（AdbClient职责拆分）已完成。RU-09/10/13保留部分自动化覆盖，RU-12未开始且当前阶段不要求闭环。用户确认控制器实际跑图、自动进图、触摸时序、弹窗抢占和RunLoop正常，设备核验按用户实际使用验证接受；无独立trace的项不伪称自动化覆盖。Release全量验证最新结果为主测试156/156、独立测试51/51，均0失败/0跳过；独立测试数减少来自本轮前已有工作区改动删除一条LootConfirm理论用例，本轮未修改测试。当前阶段无强制遗留重构项；其它缺口作为未来可选改进。详见REFACTOR_EXECUTION_REPORT.md。

依据：REFACTOR_BASELINE.md 的 TD-01..18/B-01..05、REFACTOR_TEST_PLAN.md 的 C01..09/G0..6。目标设计见 TARGET_ARCHITECTURE.md。未知业务语义必须先确认，不能用重构消除告警。

## 1. 排序方法与依赖

综合严重度、收益、依赖、实现复杂度、测试强度、独立提交和回滚成本；不按风险单排序。低侵入且有明确验证的文件归位早于高风险RunLoop迁移；先恢复生产测试通路，才能信任其它小单元。

| 顺序 | Unit | 收益/复杂度 | 测试与回滚 | 前置 |
| --- | --- | --- | --- | --- |
| 1 | RU-01 最小恢复编译 | 必须/低 | 编译客观、声明增量可回退 | 无 |
| 2 | RU-02 接回生产引用回归 | 高/低 | 只改测试工程、可单独回退 | RU-01 |
| 3 | RU-03 RouteSession目录归位 | 中/低 | 现有端口测试、无API改变 | RU-02 |
| 4（可并行准备） | RU-04 Pipeline语义隔离保障 | 高/中 | 配置/运行golden，不删legacy | RU-02 |
| 5 | RU-05 非关键诊断旁路 | 中高/低中 | 失败语义测试、诊断可撤销 | RU-02 |
| 6 | RU-06 ADB传输对照与接管 | 高/中高 | G1先满足；完整owner一次迁移 | RU-01/02，设备fixture |
| 7 | RU-07 截图适配接管 | 中/中 | 多等待者/Bitmap测试、G5 | RU-06 |
| 8 | RU-08 助手协议适配接管 | 中/中高 | 命令golden、G1及隔离设备 | RU-06 |
| 保障支线 | RU-09 用例/生命周期顺序fixture | 高/中 | 先测试后owner搬迁 | RU-02 |
| 保障支线 | RU-10 视觉回放集 | 高/素材依赖 | 正负真实帧；非业务修改 | RU-02 |
| 目录支线 | RU-11 中性分类码及边界守卫 | 中/低中 | 非新增namespace工程；负例测试 | RU-03 |
| 最后/条件执行 | RU-12 单个应用用例迁移 | 高/高 | G2/G3/G4/G6；一用例一提交 | RU-09及相关设备保障 |
| 低侵入支线 | RU-13 命名已验证常量 | 中/低 | 默认/单位/输入序列一致 | RU-02；受影响设备门槛 |
| 安全支线 | RU-14 Web回环/路径边界测试 | 中/低 | localhost测试、代码无需变 | RU-02 |
| 门面瘦身 | RU-15 AdbClient职责拆分 | 高/中 | 生产ProjectReference全测、单元可回退 | RU-06/07/08 |

默认推荐首先执行 **RU-01、RU-02、RU-03**。RU-09/10 的素材和事件记录可以提前准备，但不会替代G0，也不能据此提前迁移生产编排。

## 2. Refactor Units

### RU-01 — 恢复 ADB 未完成迁移导致的构建失败

- 问题：TD-03/B-01，旧方法仍用已删除声明，无法编译。
- 当前位置：Infrastructure/Adb/AdbClient.cs:19-42,153-214,238-293,748-790,872,938-954。
- 目标设计：先恢复旧实现所需声明，形成可验证基线；维持现有新组件与公开facade，不直接切换 transport/capture/assistant。
- 修改文件范围：仅 AdbClient.cs 缺失声明；验证摘要更新 REFACTOR_BASELINE.md。不得覆盖整个文件或HEAD之后的方法改动。
- 前置依赖：下一阶段明确执行指令；保存/比对工作区增量，HEAD声明仅作证据。
- 预计影响：源码可构建性；旧root/screenshot/testpanel运行状态恢复，无新命令或计时。
- 兼容性风险：低/中；暂存版本可能还缺其它迁移片段；修复后新旧内部组件仍并存，不能称全部职责接管。
- 回归测试：完整生产引用6用例、独立52用例、Release主项目编译、标准publish；G1设备后续验，不凭编译宣称重连安全。
- 验收标准：零编译错误；所有现有/新增用例通过；旧命令文本/延时/Serial getter行为无改动。源码和测试准入已满足；标准publish属于交付验收，本次按明确指令未执行，后续发布另行核验；中间产物留在项目publish/.build并已清理。
- 回滚策略：只撤销本单元新增的声明和摘要增量；回到已知红基线也需明确报告。若已发布，按执行前备份/提交身份恢复标准根下上一交付，不重置用户其它暂存内容。
- 执行记录（2026-10-08）：恢复11类旧声明；Release build 0 warning/0 error，原测试6/6、独立测试52/52，完整验证脚本exit 0。未发布、未提交、未做真机验证。
- 推荐：已完成；后续可进入RU-02，详细步骤见第4节（执行记录优先于“未执行”原计划步骤）。

### RU-02 — 将表征测试接回真正的生产程序集

- 问题：TD-05；当前52测试是源链接fallback，无法证明生产程序集和主工程。
- 当前位置：tests/AdbMapController.Tests.csproj；tests/baseline/*.cs、Fixtures；scripts/Verify-RefactorBaseline.ps1。
- 目标设计：原ProjectReference测试成为主准入；新增测试编译到原测试工程，不复制生产源码。独立fallback保留为明确标记的排障工具。
- 修改文件范围：原测试csproj显式包含 baseline 的手写测试文件（继续排除其publish/生成源码）、fixture复制至Fixtures；脚本/测试文档。禁止链接Domain到原ProjectReference工程形成重复类型。
- 前置依赖：RU-01生产编译恢复。
- 预计影响：测试编译/fixture路径；预计原6+新增48=54例（52的4个复用例不能重复加入）。
- 兼容性风险：低；main程序集internal不可见、框架/native装载差异可能暴露测试误设，不能为了通过而修改生产语义。
- 回归测试：全54例无跳过，独立52例；检查测试发现数量、Fixture来源和集合并行限制。
- 验收标准：主测试直接引用真实生产程序集且全绿；fallback和主测试报告分开；从无.build环境可重现；生产文件零修改。
- 回滚策略：仅回退测试工程include/fixture映射及脚本调整，保留新增测试源。
- 执行记录（2026-10-08）：原测试工程显式纳入五个 baseline 手写测试文件，保留生产 ProjectReference，两个 Fixture 映射至输出 Fixtures/。Release/Debug 主测试54/54、独立52/52，失败及跳过均0；完整脚本两次exit 0，第二次清洁构建验证通过。无生产源码修改、无新增测试跳过；未发布、未提交、未操作设备。
- 推荐：已完成；RU-03 前置满足，等待单独执行指令。

### RU-03 — RouteSession归属Navigation

执行状态：完成。文件已移到 Navigation，内容与 HEAD 原文件逐字一致（忽略行尾）；54/52测试通过。baseline 的 Domain/Navigation 通配符无需调整，旧文件没有残留。下述“当前位置”为执行前证据。

- 问题：TD-01最直接的Domain→Navigation反向类型依赖。
- 当前位置：Domain/RouteSession.cs:12-13,32；Navigation/Planner.cs中计划类型。
- 目标设计：将RouteSession整体移动到Navigation，不改namespace、可见性、字段、Clear/SetPlan逻辑。
- 修改文件范围：RouteSession.cs路径及文档；必要的源码链接路径/架构allowlist测试。
- 前置依赖：RU-02。
- 预计影响：文件归属，原调用代码自动Compile；状态和序列化形状保持。
- 兼容性风险：低；显式文件列表或外部脚本可能依赖旧路径；MapIconCatalog的反向常量仍是已知例外。
- 回归测试：路线、session Reset/Stop、快照、门户；编译及符号/API对比；目录边界检查。
- 验收标准：运行时行为/类型完整名不变，无Domain/RouteSession残留；不重复定义；TD-01标记部分解除而非全部完成。
- 回滚策略：只移回文件并还原文档/路径列表，不回退其它导航改动。
- 推荐：第三项；不为它新建Contracts程序集。

### RU-04 — 锁定Pipeline入口、配置与三种超时语义

执行状态：完成测试保障单元。新增 PipelineContractTests 16例，真实MAA/Popup资源复制和离线黄金路径通过，运行约束及字段说明见 docs/PIPELINE_CONTRACTS.md。未修改或删除生产runtime。

- 问题：TD-04/B-05；历史计划混淆超时/重试且覆盖不足。
- 当前位置：MaaPipeline.cs:893-1127、TaskPipeline.cs:234-384、UiPipeline.cs:115-166；Resources/Automation；MainForm.Automation:61。
- 目标设计：三种runtime职责隔离；声明Maa实例顺序使用；配置/编译/trace与handler测试先齐备，不统一引擎。
- 修改文件范围：测试、fixtures、运行时语义文档；生产修改仅在下一次独立unit确认必要边界后提出，当前unit不删实现。
- 前置依赖：RU-02。
- 预计影响：测试保障与入口文档；无设备动作。
- 兼容性风险：低；测试不能错误要求MAA动作硬超时、RetryTimes当循环上限或Task取消永远Canceled。
- 回归测试：继承、@/表达式、多文件覆盖、subErrorIgnored、优先级、limit、onError、trace、实际生产资源静态加载及fake handler运行。
- 验收标准：每个资源和特殊字段有明确定义与golden；三种runtime差异测试通过；生产引用legacy清单明确；不删除TaskPipeline。
- 回滚策略：撤销该批新增fixtures/用例/文档，无生产行为可回退。
- 推荐：是，可在目录整理后独立提交。

### RU-05 — 保容错的有限诊断旁路

执行状态：完成。NonCriticalDiagnostics采用进程内100条/512字符/30秒全局节流，配置失败和JSON消费点接线；本机GET /api/diagnostics为实际消费方，无新增磁盘I/O。3例新增测试及既有JSON/配置测试通过；回调异常隔离，缺文件静默，默认值/临时覆盖保持。

- 问题：TD-07/11/15、B-03；JSON诊断丢弃、配置失败无可见证据。
- 当前位置：MainForm.DeviceMap.cs:197；Domain/Models.cs:18-27；Configuration/SettingsStore.cs:23-43。
- 目标设计：将已产生诊断写到有限/节流非关键旁路；配置可选报告缺失以外的失败。默认返回值/重试/控制结果保持；不把RunLoop异常映射顺便改掉。
- 修改文件范围：上述诊断消费点、SettingsStore可选sink与组合点、专项tests；不修改Tile/FlexibleInt默认逻辑、设备协议或UI主状态判定。
- 前置依赖：RU-02；诊断接口需证明有真实消费方，不制造统一日志框架。
- 预计影响：附加诊断；队列容量、速率与sink异常隔离需明确。
- 兼容性风险：中；日志同步I/O或抛错拖慢/打断输入。不得在触摸临界区写磁盘，不新增自动停止条件。
- 回归测试：坏字段输出仍一致；缺设置静默、坏设置可诊断、save失败仍不抛错；sink throw/满/重复无行为变化。
- 验收标准：容错黄金值不变、有界内存/日志、失败订阅不传播、正常默认修正不刷屏。
- 回滚策略：移除可选sink消费/接线，原容错实现不动；诊断文件不作为运行必需品。
- 推荐：是，低侵入收益高；具体诊断范围须单独评审。

### RU-06 — ADB传输golden与单owner接管

执行状态：完成。`AdbClient`的Run/RunRoot/root能力/reset/dispose已委托唯一`AdbCommandTransport`，旧root进程与锁已删除。Fake ADB生产引用测试覆盖argv/serial切换、devices、root拒绝转su、玩家JSON、EOF/非零退出及marker golden。LDPlayer `emulator-5554`（Android 9/API 28）经授权执行root启用及adbd重枚举；同serial恢复、shell uid=0、生产facade `ReadPlayer`在Disconnect前后成功且serial保持，设备游戏进程未终止。没有触摸或改变游戏状态。Debug/Release主测试全绿。

- 问题：TD-03/09、B-01；重复Run/RunRoot、标记转义差异。
- 当前位置：AdbClient.cs:153-214,232-293；AdbCommandTransport.cs:20-156。
- 目标设计：Serial/root state/Process/marker归transport，AdbClient保持facade；先golden再一次接管对应方法及reset/dispose。
- 修改文件范围：这两个文件和fake process/transcript tests；不触touch/swipe、OCR、截图、助手业务。
- 前置依赖：RU-01/02 + G1；确认旧/新printf实际命令字节、su、device枚举与错误类型。
- 预计影响：全部依赖Run的ADB I/O，影响虽广但职责边界完整。
- 兼容性风险：高；双Serial/root缓存、持久shell边界、timeout/kill/stdout读取、Dispose次序。
- 回归测试：serial参数含空格、devices、root成功/失败su、marker分行、非零状态、EOF/timeout/kill、同serial重连、不同serial清理、M01。
- 验收标准：命令/错误/timeout对照一致；仅一个root owner；原方法委托后对应旧字段/实现才删除；禁止留下双锁/双session。
- 回滚策略：一个独立接管提交；回退该委托和owner迁移整体，不单独保留半数方法；标准交付同步回滚。
- 推荐：有门槛后执行，不紧跟编译恢复自动开始。

### RU-07 — 截图适配接管与shared frame验证

执行状态：完成。生产`AdbClient`截图委托唯一`AdbScreenCapture` owner，旧capture进程与锁已移除。生产引用测试覆盖同FrameId共享捕获、waiter独立取消、不同FrameId/淘汰后重捕、Disconnect清缓存、Bitmap clone、Dispose期间迟到帧；fake ADB覆盖空流/坏PNG/非零退出/超时。LDPlayer上生产facade内存截图成功（1920×1080）；用户弹窗帧通过捆绑PaddleOCR native运行时离线调用并返回有效框。本轮未保存设备截图文件。

- 问题：TD-03/12；AdbScreenCapture已存在而旧Capture仍运行，帧/取消/淘汰未覆盖。
- 当前位置：AdbClient.cs:748-790；AdbScreenCapture.cs:9-65；ScreenFrameCache.cs:60-166。
- 目标设计：capture组件独占capture锁/进程；保留frame cache共享捕获和返回clone语义，调用方using释放。
- 修改文件范围：capture/adbfacade接线与dispose、Bitmap/cache专项测试；不得新增probe全局队列。
- 前置依赖：RU-06、G5图像/native环境fixture；保持共享capture CancellationToken.None语义。
- 预计影响：所有截图消费者/缓存等待者。
- 兼容性风险：中高；取消一个waiter影响其它人、缓存原帧提前Dispose、进程stdout复制未完成。
- 回归测试：超时和cancel kill、png错误、多个同frameID只捕一次、不同frameID/淘汰/Dispose、clone独立、取消waiter仍供另一个、M03/M07。
- 验收标准：图像尺寸/内容、命令、锁范围/timeout保持；每clone释放，shared原帧只释放一次；没有后台工作访问已Dispose资源。
- 回滚策略：回退完整capture委托与所有权变更，fixture保留；不可保留两套capture锁。
- 推荐：专项保障后是。

### RU-08 — 助手gateway接管，不修改设备协议

执行状态：生产接管与正/负向代表路径完成。`AdbClient`公开助手API现委托`AssistantController`并删除旧重复实现；LDPlayer上Status→Restore→Install→Restore→Install成功，target哈希恢复原值，备份仍在。Fake ADB远端文件树测试覆盖安装写目标失败时原目标/备份保持及临时payload清理、成功安装后重复Restore幂等、损坏备份拒绝且原目标不变；另覆盖test-panel命令文本和本地模板缺失。未逐一注入pull/push/copy/chmod/cleanup每种失败；设备未触发test-panel UI。此项生产接管验收通过，失败矩阵可后续增补。

- 问题：TD-03/09；AssistantController候选实现未替代旧安装/恢复/测试面板代码。
- 当前位置：AdbClient.cs:793-934；Infrastructure/Patching/AssistantController.cs。
- 目标设计：助手远端文件/备份/hash/安装/恢复/testpanel协议成为完整内部模块；facade结果字段及错误路径一致。
- 修改文件范围：上述两文件、状态DTO适配必要最小部分、协议fixture/tests。
- 前置依赖：RU-06；隔离设备和可恢复助手备份；G1命令golden。
- 预计影响：助手安装/恢复和测试面板，不包含游戏JSON字段变化。
- 兼容性风险：高；覆盖游戏文件、shell quote、临时文件清理、状态记录格式和结果DTO。
- 回归测试：发现/未安装/备份/已安装hash、每一步失败的cleanup、测试面板命令marker、restore幂等、无base64回退；真实设备另授权。
- 验收标准：与旧命令和结果一致；恢复路径可用；原facade签名不变；接管后旧代码删除而非双维护。
- 回滚策略：回退单元接线及owner代码；如设备文件已改，使用事先确认备份恢复（不能仅git回滚冒充设备回滚）。
- 推荐：后置；禁止在本阶段安装助手。

### RU-09 — RunLoop、抢占与关闭顺序Fixture

执行状态：本阶段接受通过（用户实际使用核验）；自动化/事件trace覆盖仍部分完成。4例真实STA同步上下文tracker测试覆盖多任务失败、取消finally、快照边界和同步失败；生产`PopupWatchdog`离线集成测试覆盖专用流程disabled时不启动ADB，以及贪婪回城帧经Fake ADB/native OCR/真实UI Pipeline后idle锁存类别/卡索引和两个movement-cancel分支返回值。用户确认实际跑图、自动进图，以及触摸时序、弹窗抢占和RunLoop均正常；此为用户设备使用核验，不等同于本仓库新增Touch transcript或RunLoop事件trace。ShutdownCore/native关闭交接仍未独立验证。用户明确当前阶段不要求RU-09剩余测试闭环。

- 问题：TD-02/05/10、B-02/03/05；复杂事件时序与多任务释放缺乏测试。
- 当前位置：MainForm.Automation:190、Movement:233-389、MainForm:283-319、PopupWatchdog:47、OperationTracker:13。
- 目标设计：建立确定事件记录与控件输入快照；先复现当前调用顺序和结果歧义，不先迁移所有owner。
- 修改文件范围：测试/fixtures/可读事件说明；若必须增加生产测试seam，另提最小变更单独授权，本单元不绕反射写私有状态。
- 前置依赖：RU-02；确认UI SynchronizationContext与设备动作安全范围。
- 预计影响：只增加保障；记录事件不改变调度。
- 兼容性风险：低/中；夹具应保留UI线程、避免测试设计要求更强的取消/WhenIdle语义。
- 回归测试：C01/C03/C08：idle popup、slice popup、battle保路线、refresh false旧map、异常后handler Success、多任务关闭/异常/重复close、native延迟。
- 验收标准：同步/异步路径都能稳定重放；事件及状态可比较；明确G3/G6剩余device缺口；不把合成夹具当真机。
- 回滚策略：只回退fixtures/用例/诊断测试接线，生产行为不变。
- 推荐：尽早准备；owner迁移仍需G2/G3/G4/G6。

### RU-10 — 视觉正负帧回放基线

执行状态：部分完成；当前阶段接受遗留覆盖缺口，不要求闭环。真实游戏负帧及用户六张1004×565弹窗帧覆盖普通/警告换层、宝石、贪婪继续-only/回城-only/混合卡。贪婪回城-only样本经native OCR和生产UI Pipeline识别并由PopupWatchdog锁存卡索引；此单一样本不代表整体OCR准确率。部分公告/缺标题文本可能误分类，规则保持未改。ServerError/Loot正例、近似负例、更多分辨率/动画仍缺，作为未来可选样本补充，不阻塞当前阶段。

- 问题：TD-05/13；UI Pipeline节点控制流不验证识别正确率。
- 当前位置：AdbClient.cs:461-705；VisualTemplate.cs；PopupUiPipeline及Resources/Vision/Templates。
- 目标设计：每帧固定来源/分辨率/frameId/结果/阈值/节点优先级，离线跑现有算法；不训练/更换模型。
- 修改文件范围：tests视觉fixture manifest、脱敏真实图片、回放runner、环境说明。
- 前置依赖：RU-02、经确认的截图素材和native依赖；无素材不得伪造“覆盖完成”。
- 预计影响：测试数据体积/运行成本；不更改生产模板。
- 兼容性风险：低；图像隐私、过拟合、不同native版本数值差异需标明。
- 回归测试：正常战斗/宝石/下一层/loot/server、近似颜色负例、分辨率/动画边缘；报告误报/漏报与score。
- 验收标准：至少每检测器正/负/近似负例，来源/hash可追踪，明确非支持分辨率；共享帧不混用；不以宽阈值掩盖失败。
- 回滚策略：删除本单元fixture/runner映射，不改生产资源；临时截图用完清理。
- 推荐：是，素材受限时标待补。

### RU-11 — 清剩余反向常量并建立架构守卫

执行状态：完成。PortalProtocol拥有分类码3，PortalRouting保留常量别名；Domain仅用BCL编译守卫及Navigation/Infrastructure/Presentation负例通过，无allowlist。新增共20例边界/传送分类测试，未拆程序集。

- 问题：TD-01/18；MapIconCatalog依PortalRouting常量，目录约束只能靠文档。
- 当前位置：Domain/MapIconCatalog.cs:192；Navigation/PortalRouting.cs:30起常量；csproj。
- 目标设计：按真实语义把门户分类码归中性Domain常量/已有类型（最少方案），两边引用同一个值；禁止新增Domain→Presentation/Infrastructure/Navigation，维护明确暂时例外。
- 修改文件范围：两文件/小常量文件（确有必要才建）、架构tests/allowlist及文档；不搬整个Planner契约、不拆程序集。
- 前置依赖：RU-03/02；freeze角色分类输出及原常量数字。
- 预计影响：角色图标/portal分类的引用归属；API兼容常量必要时保留alias。
- 兼容性风险：低中；const值/角色Kind不允许变；文本扫描无法证明全部依赖，需负例或语义扫描补充。
- 回归测试：全部角色/传送模式分类黄金样本；新增反向引用测试负例失败、allowlist不可增长。
- 验收标准：已知Domain反向引用消除，分类输出一致，guard在CI/脚本可运行；没有无意义新层。
- 回滚策略：回退常量归属及守卫增量，保持值；RU-03文件归位无需连带回退。
- 推荐：是，作为小范围结构单元而非大规模namespace整理。

### RU-12 — 仅迁移一个已覆盖的Application用例

当前阶段结论：未开始且不要求执行。用户确认本阶段不再要求遗留项闭环；没有具体生产维护痛点前，不为完成清单而迁移MainForm用例。

- 问题：TD-02；窗体还拥有业务编排和CTS生命周期。
- 当前位置：MainForm.DeviceMap的刷新/合并/观察用例，或Automation某个已完整定义子流程；最终范围需下一次评审择一。
- 目标设计：一个明确输入/输出与状态owner的完整用例，UI adapter负责展示；run CTS owner一次转移，MainForm薄委托。
- 修改文件范围：选定partial中的完整方法及一个Application用例、必要adapter/测试；禁止横跨全部MainForm、AdbClient与Pipeline重写。
- 前置依赖：RU-09、受影响G2/G3/G4/G6真实门槛；用户确认未知业务语义；先选定具体用例，不把本项当随意改造授权。
- 预计影响：所选业务场景/线程上下文；其余跑图流程不变。
- 兼容性风险：高；刷新并行、UI线程/回调顺序、返回false旧map和异常Success、取消/Dispose。
- 回归测试：该用例golden事件trace、状态前后、异常/取消/设备对照、重复start/stop。
- 验收标准：事件/状态/时序规则相同、一个CTS/session owner、UI适配无业务分支，旧同职责路径移除；若仍一堆跨窗体getter就停止重估。
- 回滚策略：该用例迁移完整一个提交回退，保留测试；不连带撤其它独立模块。
- 推荐：条件执行，非第一批；未过门槛不得开始。

### RU-13 — 命名并注明已有时间/协议常量

执行状态：部分完成（AdbClient JSON重试子单元）；当前阶段接受该状态，不要求继续改名。JSON解析重试的20次/5ms及设备文件可用性轮询的20次/0.005s已提为类内命名常量，Fake ADB锁定次数、命令和异常语义。RouteExecutor/PopupWatchdog/触摸时间值仍保留现状。用户对实际触摸/弹窗/RunLoop行为的确认作为设备使用证据，但不自动授权或要求重排/调整数值；剩余纯命名整理属于未来可选维护。

- 问题：TD-06/17；散落数字不易理解单位/来源。
- 当前位置：RouteExecutor.cs的5ms/120ms/1000单位，PopupWatchdog的120ms/2s，AdbClient路径/重试（先择一个文件）。
- 目标设计：文件局部有意义命名或已有MovementTuning；保留相同值、单位、比较与计算顺序，不全开放配置。
- 修改文件范围：一次一个已覆盖模块+默认值/序列测试，来源说明。
- 前置依赖：RU-02；设备时间常量要通过受影响G2/G3；无需等MainForm迁移。
- 预计影响：源码可读性；运行行为应零变化。
- 兼容性风险：低中；取整、单位换算、负lead或常量替换表达式易漂移。
- 回归测试：旧表达式边界值、负lead、duration clamp、默认配置、命令序列一致。
- 验收标准：数值/运算顺序/API不变；命名能解释来源，diff不含规则修改；不以减少魔法数字数量为唯一标准。
- 回滚策略：回退该文件命名增量，测试可留。
- 推荐：有覆盖的局部修改是；调参或版本化profile另案。

### RU-14 — Web本机监听与路径安全测试

执行状态：完成。7例离线HTTP测试通过，覆盖回环、读取、非GET、编码路径、端口回退及释放；只使用测试自建listener与唯一目录，不读取用户trace。

- 问题：TD-16；当前回环绑定/路径限制需防止未来扩展误改，不是已发现LAN暴露。
- 当前位置：PipelineWebServer.cs:47-75,119-245,281-292。
- 目标设计：锁定127.0.0.1/端口回退/GET/安全trace文件名/Dispose；无auth或新监听配置。
- 修改文件范围：HTTP/文件路径fixture与tests，必要环境说明；默认生产不需改变。
- 前置依赖：RU-02；避免占用用户现有服务，端口冲突用测试独占受控资源。
- 预计影响：只测试监控HTTP边界。
- 兼容性风险：低；测试listener/文件清理，不能开启LAN、使用真实用户trace作为可写fixture。
- 回归测试：端口占用回退、GET正常、非GET、../及编码路径/非法文件名、不存在trace、cancel/Dispose关闭。
- 验收标准：仅本机地址访问、非法路径拒绝、不读越界文件、资源结束后无listener残留。
- 回滚策略：仅移除测试/fixture增量。
- 推荐：是，低侵入保障支线。

### RU-15 — AdbClient职责拆分为稳定兼容门面

执行状态：完成（2026-10-09）。原`AdbClient`约695行，混合设备会话/触摸、地图与玩家JSON、OCR/视觉识别、截图缓存与弹窗Pipeline组合。现在门面约276行；新增`AdbTouchSession`（设备连接、触摸backend和坐标映射）、`AdbGameDataReader`（快照读取、JSON容错与地图归一）、`AdbScreenAnalyzer`（PaddleOCR、挖矿/弹窗/宝石识别）。现有`AdbCommandTransport`、`AdbScreenCapture`、`AssistantController`继续是单一owner。FrameId缓存与弹窗Pipeline结果汇总保留在facade作为跨识别流程协调边界。

- 问题：AdbClient职责过多，任何设备/JSON/视觉改动均集中在同一类，难以独立理解和验证。
- 当前代码位置：`Infrastructure/Adb/AdbClient.cs`及新建三个协作者；相关既有owner在`AdbCommandTransport.cs`、`AdbScreenCapture.cs`、`Infrastructure/Patching/AssistantController.cs`。
- 目标设计：facade只维护公开兼容面与协作者组合；会话、数据解析、图像解释各自拥有状态/生命周期，禁止重复实现。
- 修改文件范围：AdbClient及三个新协作者；更新目标架构、架构入口、基线与执行记录。没有修改业务规则/测试断言/协议。
- 前置依赖：RU-06/07/08，主测试直接引用生产程序集。
- 预计影响范围：所有现存AdbClient调用；公开/内部兼容方法保留并转发，RouteExecutor、PopupWatchdog、MainForm调用方不改。
- 行为兼容性风险：中；连接锁/触摸backend顺序、坐标换算、JSON重试/回退、OCR裁剪和检测阈值、同FrameId捕获缓存及Dispose顺序必须保持。
- 回归测试：Release完整验证；本次主测试156/156、独立baseline 51/51通过。已有Fake ADB验证同serial重连、JSON重试、截图缓存、助手与弹窗路径；历史设备使用反馈确认跑图/自动进图和触摸/抢占/RunLoop正常。
- 验收标准：`AdbClient`不再自行执行设备会话、解析地图JSON或持有OCR引擎；调用签名和识别/移动规则不变；单owner无旧重复实现；构建/两套测试通过。
- 回滚策略：作为一个整体恢复`AdbClient`的原内联实现并移除三个新协作者；不要回退此前RU-06/07/08的transport/capture/assistant owner或整份用户工作区。

## 3. 明确不纳入保行为重构的事项

- TD-07：坏字段立刻停止；TD-08：非法转换默认拒绝；TD-14：跨运行持久化门户图；TD-15：强制设备schema版本；TD-16：新增LAN监听/认证。这些是业务/协议/部署改动，需另案。
- B-02：部分down失败后的物理恢复、pulse可抢占/急停SLA、up失败重试；B-03：取消/循环异常的Success改为Canceled/Failed；B-04：快照深复制；B-05：硬终止native/共享任务。这些是潜在修复，不自动混入架构任务。
- 不为了清警告替换所有catch、取消默认值、缩短全部长函数或删除旧Pipeline。诊断与生产行为变更分开提交。

## 4. 首个单元RU-01详细执行计划与执行记录

以下计划的源码恢复和测试步骤已执行。发布步骤因本阶段指令明确禁止发布而未执行；它不影响 RU-02 的生产引用测试前置条件，但 native 发布验证仍属交付前门槛。

本节仅记录RU-01当时的范围与执行边界；其中“新组件尚未接管”的表述仅指RU-01完成时点。RU-06/07/08后续已完成对应facade接管，当前状态见Backlog顶部及REFACTOR_EXECUTION_REPORT.md。

1. **冻结输入**：记录git status、AdbClient SHA256、当前暂存/工作区diff；与BASELINE比对，若用户继续修改了同一区域先核对。不要commit/reset/restore整个用户工作区。
2. **复现红基线**：运行完整Verify脚本，确认CS0103仍是旧声明缺失；独立52用例仍绿。先检查/停止本项目进程。
3. **逐符号对照**：只读 `git show 7f9ff2b:outputs/adb_map_controller/Infrastructure/Adb/AdbClient.cs`。列出11类缺失声明：rootShell/rootShellLock/rootCommandId/adbRunsAsRoot/screenCaptureLock；AdbCommandTimeoutMs=5000/PersistentShellTimeoutMs=3000/ScreenCaptureTimeoutMs=5000；TestPanelCommandPath/TempPath/ResultPath（原Root后缀）。对照其当前所有引用，确认无第二份同名声明。
4. **最小patch**：在AdbClient恢复这些私有字段/const；不恢复旧serial字段（当前Serial由transport持有），不改Serial setter、Run/RunRoot/Connect/Capture/助手方法体、catch、delay、root标记或Dispose顺序。不直接委托新模块，不删除新文件。
5. **静态差异复核**：diff仅新增对应声明；核对常量值、类型/初值与旧实现一致。若出现新的非缺声明错误，停止扩张范围，先说明其证据与另一个最小补丁是否需要批准。
6. **绿色验证**：完整脚本；原6测试、独立52测试、Release生产编译；成功后`-Publish`直更标准publish根，停止进程并清除仅构建中间产物。只在批准执行本单元时做生产发布，当前阶段没有发布。
7. **核验并记录**（RU-01当时）：程序路径固定`publish/洞窟地图控制器.exe`；记录源码身份/构建时间/计数/SDK/native依赖。RU-01当时未做真机、未完成新组件接管；后续RU-06/07/08已经有单独设备证据，当前事实见本Backlog顶部与执行报告。
8. **独立提交候选**：仅stage本单元增量，不把用户已暂存其它改动并入；在用户未要求提交时只给diff与结果。提交或发布前确认可恢复的上版交付，不建版本化publish子目录。
9. **失败/回滚**：未构建成功不发布；构建恢复改动可逐hunk回退而不碰用户其它变更。若发布已成功后验收失败，恢复事先确定的上一交付到同一标准根，再确认当前二进制身份；不得回滚设备文件，因为本单元不改设备。

RU-01 已完成。RU-02 的前置条件（生产项目Release可构建、原ProjectReference测试可运行且通过）已满足；可在下一步单独执行。不得自动扩张为ADB全接管或MainForm架构重写。
