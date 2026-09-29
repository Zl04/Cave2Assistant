# 洞窟地图 ADB 控制器重构计划

目标：在保持现有地图识别、路线规划、方向键控制和换层行为不变的前提下，降低状态耦合，提升诊断能力和设备适配性。

## 阶段 0：数据契约稳定化（已完成）

- JSON 字段类型异常记录到 `JsonDiagnostics`。
- 异常字段继续使用原有默认值，不中断控制流程。
- 地图刷新后统一输出解析告警。
- 验证：路线回归测试、项目发布。

## 阶段 1：统一领域类型与目标策略（已完成）

- 已增加 `TargetKind` 和 `TargetPolicy`，规划器与活动目标集合已改用集中策略。
- 增加稳定的 `TargetKind`/角色分类层，减少中文字符串散落比较。
- 集中处理角色类型、宝箱类型、密室机关、出口和公会节点映射。
- `MainForm` 和 `Planner` 只依赖统一目标策略。
- 保留旧 `RoleInfo.Kind` 作为兼容显示字段，重复判断已集中到策略层。

验收：所有现有图标映射测试通过；路线目标集合与重构前一致。

## 阶段 2：拆分输入与移动执行（已完成）

- 已拆出 `DirectionMapper` 与 `TouchCoordinateMapper`，并保留 `AdbClient` 原有输入接口。
- 已增加 `TouchController` 外观层，`MainForm` 的移动和交互调用已迁移到该边界。
- `TouchController` 已接管主程序和 `TouchProbe` 的持续按住、释放、脉冲和交互生命周期；`AdbClient` 中重复的触摸实现已删除。
- 从 `AdbClient` 中继续拆出 `TouchController` 和方向输入生命周期。
- 独立管理方向按钮坐标、混乱映射、连续按住、单格脉冲和停止确认。
- `AdbClient` 仅保留 ADB 传输职责，触摸生命周期由 `TouchController` 管理。

验收：方向按钮坐标、连续移动、转角、停靠交互和急停行为保持一致。

## 阶段 3：拆分路线执行器（已完成）

- 已增加 `RouteSession`，集中持有路线、交互节点、目标集合、道路快照和选项签名；楼层切换与急停已改为统一清理入口。
- 已增加 `FloorStateMachine`，`MainForm` 的阶段字段已迁移到独立状态所有者。
- 已新建 `RouteExecutor`，运行循环已迁移到新执行器，旧 `FollowRoute` 已删除。
- 规划触发条件、路线游标和执行时序分离。
- 将人物坐标确认、偏离检测、反复横跳降级集中管理。

验收：单步、连续路线、目标交互、战斗停靠和路线复用测试通过。

## 阶段 4：独立楼层状态机（已完成）

- 将 `FloorPhase` 和换层流程迁移到 `FloorStateMachine`。
- 明确探索、预警、Boss、密室、出口、奖励弹窗和换层等待的合法转换。
- `MainForm` 只投递事件，不直接修改阶段字段。

验收：传送门、前往下一层按钮、奖励选择、回城和换层后延迟流程保持一致。

## 阶段 5：地图快照与规划结果模型（已完成）

- `RoutePlan` 已增加可走格数、未探索格数、不可达目标集合和失败原因；规划失败不再只返回空路线。
- 已增加 `MapSnapshot`，刷新时记录层级、人物位置、时间戳和结构哈希，并由 `RouteSession` 持有。
- 引入不可变 `MapSnapshot`，记录人物位置、层级、时间戳、结构哈希和导航哈希。
- 规划器返回包含失败原因、不可达目标和覆盖率的 `PlanResult`。
- 区分未知格、已探索不可走格、可走格和当前不可达格。

验收：规划失败时能够明确说明原因，不再只显示“没有可规划目标”。

## 阶段 6：UI、配置和构建收敛（已完成）

- 已增加 `ControllerSettings`/`SettingsStore`，`MainForm` 不再直接负责设置文件读写，保留原子临时文件替换行为。
- 已增加 `MapProjection`，`MapPanel` 的坐标投影与绘制逻辑已分离。
- 将配置加载/保存迁移到独立 `SettingsStore`，采用版本化和原子保存。
- `MapPanel` 拆分投影、图标资源和绘制职责。
- 将 Lua 辅助脚本校验、加密和发布纳入构建流程。
- 增加 ADB、JSON、状态机和路线执行的集成测试。

## 每阶段统一约束

1. 先补充行为测试，再迁移完整边界。
2. 不改变公开方法签名和 JSON 字段语义，除非明确增加兼容层。
3. 每阶段完成后执行 `dotnet test` 和 `dotnet publish`。
4. 发布目录固定为 `outputs/adb_map_controller/publish`。
5. 发现需要修改 Lua 协议或外部资源格式时，先单独评估，不混入当前阶段。

## 阶段 7：任务 Pipeline 外壳（已完成，保留兼容层）

- 增加受限的 `TaskPipeline<TState>`，用数据定义节点、优先级 `next`、识别门、重试、超时、`onError`、`maxTimes`/`exceededNext` 和取消语义。
- 当前完整跑图流程作为 `RunDungeon` 大任务接入，保留 `FloorStateMachine`、`Planner` 和 `RouteExecutor` 的强类型领域实现，不把地图图搜索改写成 JSON。
- 新增 `Resources/Automation/map-run-pipeline.json` 和 `task-pipeline.schema.json`；后续可先将换层弹窗、秘境选择等阻塞式子流程拆为同一 Pipeline 下的节点。
- 增加 `TaskPipelineRegression`，覆盖 next 候选、重试、错误恢复、最大次数、超时恢复和取消。

验收：主程序 Release 编译通过；任务 Pipeline 独立回归程序通过。

## 阶段 8：完整 MAA Pipeline 语义与节点诊断（已完成）

- 增加 `MaaPipelineCatalogLoader`，支持 MAA v1 任务对象格式、多文件覆盖、`baseTask`、显式/隐式 `@` 任务、虚任务和任务列表表达式。
- 增加 `MaaPipeline<TState>`，统一处理识别候选、动作、`sub`、`next`、`onErrorNext`、`exceededNext`、次数、延时、重试、停止和取消。
- 增加 `MaaPipelineTraceCollector`，记录候选识别、命中证据、节点生命周期、动作、重试、分支和最终状态；主程序同时输出窗口日志和 `pipeline-traces/*.json`。
- `map-run-pipeline.json` 已迁移为 MAA 任务格式；现有地图规划保留为 `RunDungeon` 领域 handler，不把图搜索硬编码到任务 JSON。
- 增加 `MaaPipelineRegression`，覆盖继承、隐式 `@`、表达式、`sub`、错误恢复、次数分支和节点 trace。

验收：主程序 Release 发布成功；`MaaPipelineRegression` 通过；现有 RouteLock、Vision 和 Popup 回归发布程序通过。
