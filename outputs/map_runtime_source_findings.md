# 小地图运行时数据链结论

## 最终判断

道路识别不应继续依赖截图。游戏在生成楼层时已经创建完整二维地图，随后小地图直接
读取这份逻辑数据并渲染。最可靠方案是只读导出当前 `MapData.tileDataMap`。

## 证据表

| ID | 结论 | 源码证据 | 置信度 |
|---|---|---|---|
| E1 | 当前完整地图由单例管理器持有 | `GameMapManager:getMapData()` 返回 `_mapData`；生成后在 `loadMapDataForState()` 写入 | 确认 |
| E2 | 地图真值是二维数组 | `MapData` 创建 `tileDataMap[y][x]`，并提供 `getTileDataMap()` / `getSize()` | 确认 |
| E3 | 小地图遍历整张真值地图 | `MapView.createMapGrids()` 双循环读取 `tileDataMap[j][i]` | 确认 |
| E4 | 道路可通行性不是颜色判断 | `MapTileData:isReachable()` 检查地形、装饰、角色和占位对象 | 确认 |
| E5 | 迷雾是格子状态 | `reached`、`isExplored`、`isShowIcon` 分别由 `isReached()`、`hasExplored()`、`hasShowIcon()` 提供 | 确认 |
| E6 | 人物坐标来自角色所在格 | 每格包含 `roleDatas`；`MapGrid:hasMaster()` 用 `isMasterHero()` 判断主角 | 确认 |
| E7 | 小地图格子尺寸是 31×15.5 | 战斗场景中 `MAP_GRID_AXIS_WIDHT=32-1`、`HEIGHT=16-0.5` | 确认 |
| E8 | 屏幕位置由格坐标确定 | `computeMapGridPosition()` 后进入 `transformMapGrid()` 的等距变换 | 确认 |
| E9 | 原生 `Avalon::MapGrid` 不参与当前链 | Ghidra 对其 `parse` 查不到外部调用者，其他方法仅内部互调 | 确认 |

## 运行链

```text
MapGenerater
  -> 生成 -1/0/1 地形格网
MapDataManager.generateMap
  -> 创建 MapData / MapTileData / 角色与装饰
GameMapManager._mapData
  -> 持有完整楼层真值
MiniMap / BigMap
  -> MapView.init(mapData)
MapView.createMapGrids
  -> 遍历 tileDataMap[y][x]
MapGrid
  -> 按 terrain/reachable/explored/reached/roles 渲染
```

## 推荐实现

在游戏 Lua VM 中加载 `runtime_map_dump.lua`，调用：

```lua
local exporter = require "runtime_map_dump"
exporter.write()
```

输出 JSON 包含：地图宽高、人物格坐标、每格地形、动态可通行性、到达/探索状态、图标
显示状态，以及该格所有角色的类别、类型和 spriteID。Windows 程序只需要读取 JSON，
不再处理截图道路。

截图仍可用于人工对照，但不再是地图数据源。
