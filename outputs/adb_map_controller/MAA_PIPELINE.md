# MAA Pipeline

项目现在使用 `Infrastructure/Automation/MaaPipeline.cs` 提供 MAA v1 风格的任务编译和运行时。

当前协议层按 MaaFramework Pipeline v1/v2 兼容：支持 `recognition`/`action`、v2 的
`{ "type": ..., "param": ... }` 写法，并兼容项目历史使用的 `algorithm`、
`onErrorNext` 等字段。设备侧通用识别和动作由 `MaaAdbPipelineHandler` 提供；
仅地图入口候选、地图节点等游戏特有逻辑保留在领域 handler 中。

## 支持的任务语义

- `JustReturn`、`MatchTemplate`、`OcrDetect`、`FeatureMatch`
- `DoNothing`、`ClickSelf`、`ClickRand`、`ClickRect`、`Swipe`、`Input`、`Stop`
- `baseTask` 继承、显式/隐式 `@` 任务
- `#self`、`#back`、`#none` 和 `A#next` 等虚任务引用
- `+` 合并、`^` 差集、`*N` 重复的任务列表表达式
- `sub`、`subErrorIgnored`、`next`、`onErrorNext`、`exceededNext`
- `maxTimes`、`preDelay`、`postDelay`、`reduceOtherTimes`
- ROI、模板、阈值、颜色尺度、OCR 替换、FeatureMatch 参数和输入校验

`handler` 是本项目的扩展字段。MAA 任务协议定义识别算法和动作，但洞窟地图规划、Lua 状态读取和触摸设备控制属于本项目领域能力，因此通过 handler 注册表接入，而不是把领域代码塞进 JSON。

## 节点级测试观测

运行时会为每个候选任务写出：

- 候选开始识别、命中/未命中、分数、ROI、文本、帧号和证据路径；
- 节点开始、动作开始、节点完成、失败、重试和次数耗尽；
- `next`、`onErrorNext`、`exceededNext` 的实际分支；
- 任务链开始、完成、停止、取消和最终错误。

主程序运行后会把结构化结果保存到：

```text
publish/pipeline-traces/map-run-{run_id}.json
```

同时，主窗口日志会显示节点级摘要。测试程序可以直接使用 `MaaPipelineTraceCollector.Events`，或调用 `SaveJson` 保存完整回放数据。

## 本地 Web 监控

主程序启动时会启动一个只监听本机回环地址的只读页面，默认地址为：

~~~
http://127.0.0.1:17830/
~~~

如果默认端口被占用，程序会依次尝试后面的 9 个端口，并在主窗口日志中记录实际地址。点击主窗口的“Web监控”按钮可以打开页面。

页面包含：

- 当前运行状态、Run ID、当前节点和事件数量；
- 运行中的实时 Trace，按秒刷新；
- `publish/pipeline-traces` 中的历史运行记录；
- 节点识别、动作、完成、失败、分支和耗时等事件明细。

服务只绑定 `127.0.0.1`，不接受局域网或公网访问，也没有控制任务、点击设备或修改配置的接口。页面使用的只读接口为：

~~~
GET /api/health
GET /api/live
GET /api/runs
GET /api/runs/{trace-file-name}
~~~

## 当前主流程

`Resources/Automation/map-run-pipeline.json` 已改为 MAA 任务格式。`RunDungeon` 是一个领域入口任务，实际地图探索仍由 `FloorStateMachine`、`Planner` 和 `RouteExecutor` 执行。

自动进图使用 `Resources/Automation/dungeon-entry-pipeline.json`，节点链为：

```text
开始自动进图
  -> 确保主城地图已打开
  -> 主城标题已识别 / 点击小地图按钮
  -> 主城地图打开失败（超时或次数耗尽）
  -> 进入目标地图
  -> 判断当前地图类型
      -> 当前地图标题匹配目标（OCR命中，跳过切换）
      -> 切换地图类型（OCR未命中时）
  -> 选择关卡难度
  -> 识别并选择关卡
  -> 点击挑战
  -> 确认进入地图（可选，超时后走 on_error）
  -> 等待副本地图加载
```

Pipeline 负责节点顺序、候选循环、超时回退、取消、生命周期和 trace；挑战按钮、确认按钮和等待加载已经使用通用 `MaaAdbPipelineHandler`，而地图入口候选、地图节点等游戏特有逻辑仍由 `DungeonEntryAutomation` 的领域 handler 执行。

点击“进图并跑图”会执行 `Resources/Automation/entry-run-pipeline.json`：

```text
EnterDungeon -> RunDungeonCycle -> LoopGate
                                  └─ 未达到跑图次数时回到 EnterDungeon
```

设置中的“跑图次数”大于 0 时，`LoopGate` 在完成指定轮数后正常停止；设为 0 时，普通难度持续循环，精英/噩梦难度 OCR 读取所选关卡难度按钮上方的可挑战次数，并以此决定轮数。每轮点击挑战前还会核对剩余次数；不足以完成剩余轮数时会在点击前失败停止。若启动时已在副本内，会先跑完当前副本，回到城镇进入指定关卡后再读取次数；剩余次数加上已完成轮数作为本次总轮数，剩余次数为 0 时正常结束。进图或跑图失败时 Pipeline 直接失败，不会自动开启下一轮。可通过修改该资源的 `next` 关系调整任务顺序；具体游戏动作仍由已注册的 `EntryRunCycle` handler 执行。

其中“主城标题已识别”由领域 handler 识别巴萨坦主城标题；标题模板命中即认为地图面板已打开，不额外依赖地图节点数量或其它面板元素。“当前地图标题匹配目标”会 OCR 关卡面板左上角标题；命中目标地图时直接进入难度与关卡识别，未命中时才运行“切换地图类型”。

自动进图目录中，`时光之门` 与 `时光之门(英雄)` 是两个独立的地图选项：普通项提供 `1层`～`171层`，英雄项提供 `图一[遗忘之穴]`、`图二[巨石旷野]`、`图三[淤泥回廊]`、`图四[大裂缝]`、`图五[旧神庇护所]`、`图六[幽魂废都]`。英雄项复用时光之门入口模板，但进入后会按左上角标题确认英雄页签；只有当前页签不符合目标时才打开上方切换入口并选择卡片。

## 入口场景模板

“更新入口模板”会截取当前设备上的巴萨坦地图。先标记入口实际点击位置，再框选入口附近稳定的地形或建筑纹理；运行时以场景模板匹配，并通过保存的锚点偏移还原点击位置。场景框可以避开人物青蓝色标记，因此人物覆盖入口图标时不依赖被遮挡的图标轮廓。

原初试炼已作为独立入口加入选择列表，并提供内置入口截图模板；如游戏 UI 变化，仍可在已打开的巴萨坦地图中执行上述场景标定覆盖它。

打包目录将素材明确分开：`icons/` 只保存游戏原始图标，`templates/entrances/` 保存入口截图模板，`entry-templates/` 只保存用户手动采集的场景覆盖模板。入口截图模板包含时光之门、沙之眼、共用入口与原初试炼；时光之门截图中的青蓝人物像素已作为透明掩码处理，不参与匹配评分。

回归入口：

```text
tests/MaaPipelineRegression/publish/MaaPipelineRegression.exe
```
