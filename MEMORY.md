# 洞窟地图助手工作记忆

最后更新：2026-09-20

## 源码分析文档维护规则

- 本文件保存项目运行记忆、控制器约定和分析文档索引。
- 游戏源码逆向分析统一保存到 [GAME_SOURCE_ANALYSIS.md](C:/Users/Warrior.zeng/Documents/Codex/2026-08-26/ni/GAME_SOURCE_ANALYSIS.md)。
- 后续每次分析到新的游戏源码行为、字段、消息、状态机分支、弹窗条件或交互流程，都必须追加到该文档；不得只留在对话中。
- 每条新增结论应记录源码文件、关键函数或大致行号，并区分“源码确认”“运行时观察”和“推测”。
- 若后续实验推翻旧结论，应保留旧结论并标注已失效原因，同时写出替代结论。

## 项目与发布

- Windows 控制器工程：`outputs/adb_map_controller/`
- 后续发布统一放在：`outputs/adb_map_controller/publish/`
- 发布前先关闭正在运行的“洞窟地图控制器”进程。
- 主程序通过 ADB 控制 Root 模拟器，当前主要使用 `emulator-5554`/`emulator-5556`。
- 游戏包路径和数据目录使用华为包：`com.avalon.caveonline.cn.huawei`，数据位于其 `files/CaveOnline/`。

## 地图与目标模型

- 地图数据由运行时 Lua 助手导出为 `codex_map_dump.json`。
- 人物状态由助手导出为 `codex_player_status.json`，当前包含层数、格坐标、混乱状态、混乱方向和 `moveSpeed`。
- 地图使用逻辑格坐标；`reachable` 表示可移动性，`explored` 只表示探索状态，不能把未探索区域当作边界。
- 地图探索与下楼是两套独立逻辑，不能把探索进度当作下楼条件。
- 下楼条件满足时，直接规划到下楼入口或使用右侧快捷入口，即使地图仍有未探索区域。
- 只有下楼条件未满足且当前没有可规划目标时，才运行完整探索路线；发现可规划目标后应切换到目标路线。
- 只有道路结构或目标集合变化才重新规划。迷雾探索数量变化、任务完成状态等不应单独触发重规划。
- Boss/守层 Boss 必须处理；预警值存在时，达到要求前不能把守层 Boss 当作可攻击目标。
- 传送门/出口流程：到达停靠点 → 交互 → 等待弹窗 → 选择加成或回城 → 必要时点击战利品确认 → 轮询确认换层。
- 换层后应延迟约 3 秒再开始移动规划，避免遮罩影响方向按钮。
- 密室入口需要停靠和交互；机关只需经过，不应作为停靠点。机关已踩过记录不能因普通重规划清空。

## 图标与类型

- 图标类型必须优先依据游戏源码中的角色数据字段判断，不能用 `spriteID` 判断类型。
- 未被源码条件确认的角色显示为问号，不要强行映射成已知道具。
- 普通箱、金箱、特殊宝箱均归入箱子目标；商人、陷阱、传送门、出口必须区分。
- 公会地图类型已确认：41 公会副本、23 公会科技、25 公会布告板、24 公会商人、38 许愿池、40 公会拍卖师。

## 游戏移动源码结论

- 主要源码：`work/warning_logic/decrypted_src/app/action/fsm/move/BattleMoveStateActionForMe.lua`。
- 玩家移动每帧读取 `self._target:getMoveSpeed()`，计算速度分量并累计连续坐标；累计跨过 1 格时才更新逻辑格坐标。
- `MAP_COORD_COVERT_DISTANCE = 1000`，因此：
  - 格/秒约为 `moveSpeed / 1000`
  - 一格耗时约为 `1000 / moveSpeed` 毫秒
  - N 格直线耗时约为 `N * 1000 / moveSpeed` 毫秒
- 方向移动初始化时没有固定加速；多走一格主要来自触摸命令在设备端仍在执行、ADB 释放延迟和坐标读取时序。
- 到达转角和所有停靠交互点都必须在释放输入后重新读取坐标；坐标不一致时放弃当前段并重新规划。
- 当前控制器保留持续长按、转角提前松开、单格脉冲和反复横跳回退逻辑。

## 速度读取方案

- 游戏已有安全入口：`GameDataManager:getMoveSpeed()`，它返回主角当前 `moveSpeed`。
- 不要调用 `masterData:getMoveSpeed()`，也不要直接读取 `masterData.moveSpeed`，此前这类助手改动曾导致黑屏风险。
- 助手应在 20Hz 状态导出中通过 `codexSafeCall(GameDataManager:getInstance(), "getMoveSpeed", 0)` 读取速度。
- 助手文件的正确格式是：`svednolava` 签名 + XXTEA 加密的 Lua 源码文本。文件名虽然是 `.luac`，内部载荷并不是标准 Lua 字节码。
- 构建时只可用 `luac52 -p` 检查语法；禁止用 `luac52 -o` 生成载荷。应把 `MiniMapDrawer.huawei.lua` 源码直接交给 `cocos_xxtea.py encrypt`。
- 发布前必须同时验证：外层前 10 字节是 `svednolava`；解密后开头是 Lua 源码（当前为 `--[[`，字节 `2D 2D 5B 5B`）；解密载荷 SHA-256 与源文件完全一致。解密后若以 `\x1bLua` 开头，禁止安装。
- 修改 Lua 源码时保持 UTF-8 编码；PowerShell 终端显示中文乱码不代表 Lua 字符串本身可随意改写，尽量只做最小 ASCII 锚点修改，避免破坏原有中文字符串。
- 已确认此前黑屏的首要原因：Windows `luac52` 生成的 Lua 5.2 字节码与游戏加载环境不兼容，而正常原版和 `fast` 助手解密后都是 Lua 源码。出现黑屏时先检查解密载荷类型，再考虑 Lua 运行时异常。
- 当前已恢复已验证助手，因此速度字段暂时不会出现在状态 JSON 中。后续速度获取应采用不替换主模块的独立读取/运行时校准方案。

## ADB 与阻塞防护

- `outputs/adb_map_controller/Infrastructure/Adb/AdbClient.cs` 使用普通 ADB、持续 Root shell 和持续输入 shell。
- 普通 ADB 命令必须有超时；当前为 5 秒。
- 持续 shell 的锁等待和 `ReadLineAsync` 必须有超时；当前为 3 秒。
- 超时后销毁异常 shell，下一个命令重新建立连接，不能让 `StopHoldLoop()` 永久等待。
- 触摸方向按钮坐标按屏幕尺寸归一化；不要改回背包等固定错误坐标。

### 2026-09-20 控制器运行时观察

- 运行时观察：开始执行时可能已经停在居中的“是否进入下一层？”确认框；若启动覆盖层检查不接管该界面，规划出的传送门路线会在弹窗下方移动并反复报移动受阻。
- 控制器实现：`Infrastructure/Adb/AdbClient.cs` 的下一层确认识别先用面板/绿色确认按钮视觉候选，再用 OCR 确认标题；`Presentation/MainForm.cs` 启动覆盖层检查发现后直接进入 `SelectBonus`，把识别结果交给换层协程，不能让路线执行先于弹窗处理。
- 已失效（2026-09-20）：普通启动画面不能无条件 OCR 秘境宝石标题；旧实现曾先用三张卡片按钮和放弃按钮的视觉候选过滤，导致候选误判时标题 OCR 根本不运行。替代结论见本节末尾。
- 运行时观察：换层弹窗出现在路线移动期间时，日志会先出现“单格脉冲/移动受阻”并反复重规划，却没有“移动期间检测到弹窗”。源码链路显示换层识别包含 OCR，单次识别可能接近一个移动卡住超时；监控原先还要求连续两帧，并在 `movementActive()` 变为假后停止探测，因此 OCR 返回时可能已经错过当前移动切片。
- 控制器实现：`Infrastructure/Automation/PopupDetectionPolicy.cs` 对服务器异常、秘境宝石和换层弹窗使用单个语义命中即可接管，纯颜色战利品确认仍需两帧；`Presentation/MainForm.cs` 在路线返回需重规划后追加一次序列化弹窗补偿检测，再决定是否刷新地图和重规划。
- 源码确认（2026-09-20，替代上面“宝石标题先经视觉候选过滤”的旧结论）：`Infrastructure/Adb/AdbClient.cs` 的 `ReadGemTitlePassAsync` 曾把截图裁成屏幕中间 20% × 顶部 12% 后再交给 PaddleOCR；实测完整 1920×1080 截图能识别出 `原初试炼宝石`，该窄裁剪只返回乱码。因此秘境宝石弹窗必须直接用标题匹配，不能用卡片/按钮颜色提前否决标题。当前实现把整帧传给 PaddleOCR；`Presentation/MainForm.cs` 仅在显式刷新或弹窗已由独立 watchdog 锁存时做标题确认，避免路线循环反复启动整帧 OCR。
- 运行时观察与修复（2026-09-20）：标题已能正确识别，但启动时 `NavigationStartup.PrepareAsync` 的地图规划分支与覆盖层分支并行，路线规划日志可能先于宝石状态完成；watchdog 随后因 `runeSelectionVisible` 为真而按设计暂停探测。若启动流程只设置该标志而未立即进入点击处理，就会出现“已识别、已规划、watchdog 一直等待”。`StartRunCore` 现已在该状态下清空待执行路线、先调用一次 `HandleRiftGemSelection`，再进入 `RunLoop`；watchdog 等待日志同时输出具体原因。
- 架构修复（2026-09-20）：启动覆盖层检查和移动 `PopupWatchdog` 现在都调用 `AdbClient.RunPopupUiPipelineAsync`，共享同一个 JSON 顺序和识别器；`MainForm` 不再直接调用 `HasRiftGemSelection(screen)`。Pipeline 只负责识别 `MovementPopupKind`，识别结果再交给宝石点击/换层确认处理器执行动作，避免把触摸副作用塞进识别节点。
- 性能修复（2026-09-20）：`PopupUiPipeline` 对同一帧的全屏 PaddleOCR 结果使用上下文缓存，服务器异常、换层和秘境宝石识别器复用同一份 OCR 文本；仍只用宝石标题做语义匹配，不增加卡片/按钮等额外否决条件。这样普通牌桌画面即使 OCR 无匹配，也不会在同一轮探测中重复 OCR。
- 帧采集重构（2026-09-20）：弹窗检测不使用固定频率后台采集；`PopupWatchdog` 每轮检测开始时通过 `NextPopupFrameId()` 递增逻辑帧号，`ScreenFrameCache` 按该编号合并同帧的串行/并发截图请求。启动覆盖层检查也使用同一帧接口；不同检测轮次必须传入新编号，入口标定等需要强制新画面的流程不走该缓存。
- 源码确认（2026-09-20）：同帧 OCR 缓存目前写入点在 `PopupUiPipeline.ReadFrameTextAsync` 的 `ReadPopupFrameTextAsync` 正常返回之后；但 `UiPipeline` 给服务器异常、换层和秘境宝石节点分别设置 3500ms 超时，`AdbClient.ReadPopupFrameTextAsync` 的实际 PaddleOCR 请求不接受可取消等待，只在 OCR 完成后检查 token。冷启动全屏 OCR 超过节点超时后会抛出取消异常，缓存不会写入，三个语义节点会对同一张图重复 OCR，最终约 100 秒后返回 `None`。应让一帧 OCR 只启动一次并独立于节点超时缓存结果，或把语义 OCR 作为单独的有界/可观测阶段；必须增加“慢 OCR + 三节点”回归测试。
- 运行时观察（2026-09-20）：对当前 `publish/` 的 1920x1080 实际设备截图独立调用 PaddleOCR Worker 能返回 `原初试炼宝石`，因此本次“宝石标题未检测”不是 `GemTitleMatcher` 漏匹配。用户日志中的 watchdog 在启动地图规划同时开始探测，且发布程序构建时间早于源码中的 `startupPreparing` 启动期暂停逻辑，说明当次运行使用了过期发布物；历史 `errors-20260920.log` 另记录过 Worker 退出导致的 `EndOfStreamException`，需与“无匹配”状态分开处理。
- 运行时竞态修复（2026-09-20）：`RunMovement` 会在调用 action 前同步启动 `PopupWatchdog`，因此仅在 `StartRunCore` 内设置暂停标志仍会漏掉第一轮截图/OCR。`StartRun` 现在以 `startupProbePaused` 先锁住 `startupPreparing`，启动 `RefreshMap` 的截图/OCR预检完成后再释放；普通点击导航和单步流程不受影响。该回归覆盖“路线已规划但仍等待弹窗检查”的启动状态。

## 当前已知问题

- 直线或停靠点偶发多走一格仍需通过“速度预测 + 释放后坐标复核 + 输入队列清理”继续校准。
- 速度字段首次读取不到时控制器应显示 `速度 --` 并使用保守默认值，不得阻塞地图或移动。
- 修改助手后必须重新加密、重新安装助手并完全重启游戏；只替换裸 `.luac` 不可用。
