# 地图图标映射审计

依据：解密后的游戏 `MapGrid.lua` 中 `updateMapElement` 分支、运行时地图 JSON 样本，以及游戏原始 `ui_minimap_icon_*.png` 资源。

| 程序类型 | 确认条件 | 游戏图标 |
|---|---|---|
| 人物 | `HeroData.masterHero=true` | `ui_minimap_icon_me.png` |
| 小怪 | `MonsterData.normalMonster=true` | `ui_minimap_icon_blame01.png` |
| 群怪 | `MonsterData.groupMonster=true` | `ui_minimap_icon_blame03.png` |
| 精英 | `MonsterData.eliteMonster=true` | `ui_minimap_icon_blame02.png` |
| 小Boss | `MonsterData.smallBoss=true` | `ui_minimap_icon_boss01.png` |
| Boss | `MonsterData.bigBoss=true` | `ui_minimap_icon_boss02.png` |
| 罐子 | `roleType=2, treasureType=1` | `ui_minimap_icon_jar.png` |
| 石堆 | `roleType=2, treasureType=2` | `ui_minimap_icon_material.png` |
| 木箱 | `roleType=2, treasureType=3` | `ui_minimap_icon_ordinary.png` |
| 金箱 | `roleType=2, treasureType=4` | `ui_minimap_icon_chest.png` |
| 金币 | `roleType=3` | `ui_minimap_icon_gold.png` |
| 符文 | `roleType=8, minimapType=5` | `ui_minimap_icon_rune.png` |
| 点金台 | `roleType=7, minimapType=6` | `ui_minimap_icon_dianjin.png` |
| 附魔台 | `roleType=7, minimapType=7` | `ui_minimap_icon_enchanting.png` |
| 商人 | `roleType=7, minimapType=8` | `ui_minimap_icon_businessman.png` |
| 出口/楼梯 | `roleType=1, minimapType=1` | `ui_minimap_icon_stairs.png` |
| 传送门 | `roleType=1, minimapType=18` | `ui_minimap_icon_transfer.png` |
| 秘境房间传送门 | `roleType=1, minimapType=22` | `ui_minimap_icon_room.png` |
| 秘境随机房间传送门 | `roleType=1, minimapType=22, transdoorType=3, isRandomTransfer=true` | `ui_minimap_icon_room_purple.png` |
| 锁定传送门 | 任意传送门且 `locked=true` | 对应传送门图标 + 锁标记；不作为可通行路径节点 |
| 钥匙 | `roleType=18` | `ui_minimap_icon_key.png` |
| 陷阱（助手扩展） | `roleType=12` | `ui_minimap_icon_cross2.png` |

游戏源码中的 `PublicDefine.TRANS_DOOR_TYPE` 定义 `ROOM_TO_ROOM=3`；`TriggerNpc:getSpineName()` 和 `MapGrid:getIconName()` 都使用
`transdoorType=3 && isRandomTransfer=true` 选择紫色房间传送门。助手现已导出这两个字段并使用同样条件绘制图标。

客户端源码没有传送目标坐标：交互请求只发送 `spriteID`，目标由服务端决定。控制器因此在层内传送交互前后比较地图快照，识别落点附近的另一个 `minimapType=22` 节点并记录 `A -> B`；随机传送门在尚无观测边时以同层其它房间传送门作为候选集合。

客户端源码也没有暴露稳定的“哪只小怪绑定哪扇门”的静态 ID。`TriggerNpcData` 的 `isReachable()`、`canBeNodeOfPath()` 和 `canBeEndOfPath()` 会拒绝锁定门；深渊服务端通过 `ROLE_DUNGEON_UNLOCK_TRANSDOOR` 推送解锁。控制器遇到锁定的层间门时先规划击败普通小怪，再比较前后快照，把“由锁变为未锁”的门与同时消失的小怪记录为解锁前置关系，并优先复用已学习的关系。

其他未命中上述严格条件的 `TriggerNpcData` 或无法确认类别的 `MonsterData` 显示问号。`HeroData`、`PetRoleData` 不作为地图对象显示。
