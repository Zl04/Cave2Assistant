# 重构执行记录

日期：2026-10-08。起点 HEAD `1805700b623a505675d5635f5b9be36cc1dfa0e5`。保留已有暂存/工作区增量；不提交、不推送、不发布、不启动控制器。按用户明确授权在LDPlayer上执行ADB root/重连、内存截图及助手脚本安装/恢复验证；未触摸或操作游戏内UI。

## 单元状态

| Unit | 状态 | 已执行或缺少的准入证据 |
| --- | --- | --- |
| RU-01/02 | 已完成，保持绿色 | 前阶段完成；生产程序集回归仍在主测试内 |
| RU-03 | 完成 | RouteSession 移至 Navigation；去除行尾差异后与 HEAD 内容逐字一致；主/独立54/52通过 |
| RU-04 | 完成测试保障单元 | 新增16例配置/控制流/真实资源离线测试及 docs/PIPELINE_CONTRACTS.md；三种 runtime 均保留，没有统一超时语义 |
| RU-05 | 完成 | 限长512字符、最多100条、全局30秒节流的进程内诊断；配置失败报告隔离、缺失静默；JSON Drain 位置与默认值不变；GET /api/diagnostics 只读消费，无磁盘日志 |
| RU-06 | 完成 | AdbClient传输/root owner移交给AdbCommandTransport并删除旧进程/锁。Fake ADB覆盖serial切换、argv、root/su、marker、EOF及命令失败；LDPlayer root启用后同serial恢复，生产facade Disconnect前后均可读玩家状态，游戏进程仍运行 |
| RU-07 | 完成 | AdbScreenCapture成为唯一截图进程owner；生产测试覆盖缓存共享/淘汰/取消/Disconnect/Dispose，fake覆盖错误边界。LDPlayer生产facade内存截图1920×1080成功；PaddleOCR native runtime离线加载用户弹窗帧并返回检测框。未保存设备截图 |
| RU-08 | 生产接管/验收完成；失败矩阵尚可扩充 | AssistantController接管公开facade且旧重复实现删除。LDPlayer Status→Restore→Install→Restore→Install成功，安装hash回到原值、备份保留。Fake远端文件系统覆盖pull失败清理、push失败保护、目标写入失败保护及payload清理、损坏备份拒绝、重复Restore幂等；另锁test-panel命令文本及模板缺失。chmod/cleanup自身失败未逐类注入；未触发游戏内test-panel UI |
| RU-09 | 用户实际使用核验通过；自动化部分完成 | 用户确认实际跑图/自动进图及触摸时序、弹窗抢占、RunLoop正常；4例STA tracker和生产PopupWatchdog离线回放仍提供自动化保障；ShutdownCore/native关闭交接无独立测试，本阶段接受 |
| RU-10 | 部分完成；当前阶段接受缺口 | 一张真实游戏负帧+用户6张弹窗帧；贪婪回城帧经native OCR和生产UI pipeline命中且被Watchdog锁存。缺server-error/Loot正例、近似负例和更多分辨率/动画，宽松子串误报未修复；不阻塞当前阶段 |
| RU-11 | 完成 | 中性PortalProtocol保留数值3，PortalRouting保留public const别名；Domain仅依赖BCL的Roslyn编译守卫及3类反向依赖负例；12传送模式/4图标分类用例 |
| RU-12 | 未开始；当前阶段不要求 | 仍无单一Application迁移的具体维护目标；不为清单完成率迁移MainForm |
| RU-13 | 部分完成；当前阶段接受 | AdbClient JSON读取重试常量已命名并有Fake ADB验证；RouteExecutor/PopupWatchdog/触摸数值不变，后续纯命名整理可选 |
| RU-14 | 完成 | 7例本机HTTP测试：GET/非GET、固定回环、两个测试listener端口回退、trace路径和编码分隔符拒绝、Dispose后精确prefix可重占 |
| RU-15 | 完成（2026-10-09） | AdbClient约695行拆分为稳定facade；连接/触摸、游戏JSON、OCR/视觉识别分别迁入AdbTouchSession、AdbGameDataReader、AdbScreenAnalyzer；调用面保持。Release verifier主156/156、独立51/51通过并发布成功 |

## 行为及差异范围

RU-05新增的观测数据不进入业务决策；诊断回调异常被隔离。30秒全局节流会舍弃密集诊断（含不同字段），不是无损日志，不包含源JSON或设置全文。诊断仅在当前进程内保留，默认无文件输出；仅当监控启动后才能读取接口。

除AdbClient JSON读取重试值提取为同值常量外，TouchController/backend、RouteExecutor、PopupWatchdog、Maa/Task/Ui runtime方法体未改。JSON解析仍20次/5ms，设备文件available shell循环仍20次/0.005s；等待位置、命令文本及异常路径由Fake ADB golden测试锁定。设备协议与移动/触摸时序未改变。RouteSession文件移动，门户常量引用归位，SettingsStore保留原单参数构造/API及临时覆盖流程。Web保留原双参数构造/回环监听，只增加可选诊断源与只读路由。

RU-15将`AdbClient`中的设备连接/触摸backend初始化交给`AdbTouchSession`，地图与玩家快照读取/解析交给`AdbGameDataReader`，PaddleOCR与挖矿工具/弹窗/宝石检测交给`AdbScreenAnalyzer`。公开facade、PopupWatchdog/PopupUiPipeline调用签名和现有图像阈值/命令/延时保持；FrameId共享缓存及单帧Pipeline结果汇总仍由AdbClient协调。未修改触摸时序、ADB协议、检测规则或测试断言。

回滚以单元增量为边界：RU-03移回文件；RU-04撤新增测试/资源映射；RU-05撤诊断类、配置回调、组合根/刷新接线及只读路由；RU-11撤分类码引用和边界测试；RU-14撤HTTP测试。不要恢复整份含RU-02改动的测试csproj或重置用户工作区。

## 验证

- 主项目Release build：0 warning、0 error。
- 主测试新增88例：Pipeline16、Domain20、诊断3、Web7、STA生命周期4、视觉15、fake ADB23；总数142。独立baseline52，新增测试只在生产ProjectReference工程执行。
- Debug与Release主142/142、独立52/52；完整Release脚本exit 0，0失败/0跳过。Release build为0 warning/0 error。原有断言/业务预期未修改。Fake ADB新增助手远端文件失败/恢复测试、PopupWatchdog生命周期离线回放及JSON重试golden；同步竞争与模拟边界均已修正。
- LDPlayer `emulator-5554`：授权执行adb root并重枚举，设备serial恢复、shell uid=0、游戏PID保持；AdbClient生产facade Disconnect前后ReadPlayer成功；生产facade截图1920×1080成功。助手目标脚本初始SHA256 `1d4196ef5b89f3c9b840b5faec837ffc03132eccc56143e498af4dcb30d2650b`，备份SHA256 `412d7fe304b69e70e76b9dbce5fed0b813125fa2eb8a1ee59d21b2f984d6cd88`；Restore后目标等于备份，Install后回到初始哈希，再次restore/install后仍为初始哈希，备份仍在。未触摸/操纵游戏，未调用test-panel UI。
- `Verify-RefactorBaseline.ps1` 清理四个项目内 `.build` 与TRX临时目录；标准publish产物未改写。未发布、未提交。当前工作区其它既有改动保持原样。
- 最终只读设备检查确认游戏进程PID 2730仍在，画面为地下城一层且显示“全力战斗自动运行中”，角色周围有敌人；因此没有发送任何Touch命令或改变局内状态。临时截图位于项目publish/.build，检查后已删除。助手目标与备份哈希分别仍为 `1d4196ef5b89f3c9b840b5faec837ffc03132eccc56143e498af4dcb30d2650b` 和 `412d7fe304b69e70e76b9dbce5fed0b813125fa2eb8a1ee59d21b2f984d6cd88`。

## 解锁剩余任务需要的输入（2026-10-08历史记录）

1. RU-08 follow-up：fake remote filesystem已覆盖pull/push失败、损坏备份、目标写失败、临时payload清理及Restore幂等；仍可补chmod/cleanup各阶段独立故障注入。
2. G2/M02：后端/屏幕尺寸，长按和pulse急停、partial down/up失败的请求及物理结果；模拟器当前在自动战斗且角色邻近敌人，需由用户先给出/准备无风险的安全场景。保持原异常恢复语义，任何修复另立决策。
3. G3/G4/G6：以可观察/可回放方式覆盖弹窗与移动抢占同一时间线、战斗等待/恢复、刷新失败、floor/gem/portal转场、关闭时多任务/native结束和释放顺序。可继续从LDPlayer验证，但必须控制实际游戏状态并记录步骤。
4. RU-10：需服务器异常/Loot正例、截图近似负例、不同楼层/动画样本；native runtime仅已验证可加载与返回框，不代表OCR准确率。文本边界误报须先确认业务语义，不自行收紧。用户素材原生分辨率/frameId未知。
5. RU-12：在G2/G3/G4/G6证据后选择单一应用用例；不扩大为全部MainForm重写。

以上是2026-10-08记录的工程验收门槛；本节由下方2026-10-09阶段结论更新，不再表示当前阶段阻塞。

## 2026-10-09 阶段结论补记

用户确认：其已使用该控制器完成实际跑图和自动进图，一切正常；并明确触摸时序、弹窗抢占、RunLoop三项均可视作核验通过。按用户要求，本阶段不再要求RU-09/10/13的剩余项或RU-12闭环。

- RU-09：上述三项按用户实际设备使用核验通过接受；这是用户报告的运行证据，不代表本仓库新增了Touch包trace、EmergencyRelease失败注入、RunLoop事件回放或ShutdownCore/native关闭交接测试。关闭交接仍未独立验证，但不阻塞本阶段。
- RU-10：视觉样本基线保持部分覆盖；缺少的ServerError/Loot正例、近似负例及多分辨率/动画素材不再是本阶段门槛。未据此修改分类规则。
- RU-13：AdbClient JSON重试常量已命名；移动/Watchdog/触摸时间值维持原样。后续命名整理可选，不属于本阶段必须重构。
- RU-12：未开始且不要求执行；没有具体维护痛点前不迁移MainForm用例。
- 当前阶段无剩余强制闭环项。既有Release发布、142/142主测试与52/52独立测试结果保持本报告前文记录；此次只更新文档，没有生产代码或测试变更。
- 随后用户指出AdbClient仍过于臃肿并要求整体重写，遂新增并完成RU-15。停止并重启了经确认属于本项目的控制器进程；`Verify-RefactorBaseline.ps1 -Publish` Release成功，主工程156/156、独立baseline 51/51，均0失败/0跳过；发布到标准`publish/`根目录成功。51而非历史52是因为此前已有工作区改动从`StateAndJsonBaselineTests.cs`移除一条LootConfirm InlineData，本轮未改测试文件/断言。发布后启动控制器，未执行真实设备输入。

## 2026-10-09：审计后全面重构

用户已重新授权生产重构和底层缺陷修复，允许正常关闭控制器后构建测试。本阶段详细记录见 [FULL_REFACTOR_REPORT.md](FULL_REFACTOR_REPORT.md)。此前 RU 与设备记录属于此前版本，不自动推定适用于本轮版本。当前 Application 统一运行生命周期、移动片段和快照观察；共享帧、native OCR、root shell、触摸故障接触状态与 Pipeline 运行状态均已重建所有权。未提交、未发布、未开展真机回归。
