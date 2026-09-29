# 游戏源码分析记录

最后更新：2026-09-04

## 文档规则

- 本文件专门保存《贪婪洞窟 2》及相关游戏运行时源码的分析结果。
- 后续分析到新的源码行为、字段、消息、状态机分支、弹窗条件或交互流程时，继续追加到本文件。
- 每条结论记录源码文件、函数或大致行号，并区分“源码确认”“运行时观察”和“推测”。
- 后续实验推翻旧结论时，保留原结论并标注失效原因，同时追加替代结论。

## 战斗结束与弹窗源码结论（2026-09-04）

### 战斗结束分支

- `BattleMachineCommon:_controlRoleLeaveBattle` 根据 `leaveBattleReason` 分支处理：
  - `LeaveBattleReason_victory`：调用 `action:win()`；主角可能先移动到攻击后的站位或返回原点，再完成战斗动作。
  - `LeaveBattleReason_escape`：调用 `action:lose()`，返回战斗前原点并恢复待机。
  - `LeaveBattleReason_dead`：直接完成战斗动作；死亡表现由 `_fsmDie`/`DeadStateAction` 处理。
  - `leaveTeam`、`settle`、`useSkill` 是其它离战斗原因，不能简单当作胜利。
  - 证据：`work/warning_logic/decrypted_src/app/battle/BattleMachineCommon.lua`，约 1240-1320 行。
- `BattleStateActionForHero:win/lose` 会先设置 `_endBattle=true`，胜利/逃跑的收尾移动完成后才 `complete()`；因此控制器的 `inBattle` 在收尾期间仍应保持为真。
  - 证据：`work/warning_logic/decrypted_src/app/action/fsm/battle/BattleStateActionForHero.lua`，约 287-393 行。

### 胜利后可能出现的界面或表现

- 普通战斗没有统一的“胜利弹窗”。常见顺序是：怪物死亡动画 → 可能的掉落提示 → 继续探索。
- 怪物死亡使用 `RENDERER_ROLE_DEAD`，并可能触发 Boss 专用剧情、变身恢复或楼层脚本。
  - 证据：`work/warning_logic/decrypted_src/app/battle/BattleMachineCommon.lua`，约 1330-1450 行；`work/warning_logic/decrypted_src/app/battle/BattleView.lua`，约 1250 行。
- 收到 `MC_ROLE_GET_GOODS` 时，`MainUILayer:showItemDropLayer` 显示短暂的物品掉落提示；它不是每场战斗必弹。
  - 证据：`work/warning_logic/decrypted_src/app/ui/MainUILayer.lua`，约 2855 行、3927-3928 行。
- 副本、梦境、公会 Boss 等特殊模式可能在返回城镇后打开正式奖励结算界面，而不是在普通战斗退出瞬间打开。
  - `TownLayer` 根据 `REWARD_NORMAL`、`REWARD_DUNGEON`、`REWARD_GUILD_BOSS`、`REWARD_GHOSTABYSS` 发送 `MC_BATTLE_REWARD`。
  - 证据：`work/warning_logic/decrypted_src/app/scene/townscene/TownLayer.lua`，约 458-474 行。
  - 奖励界面：`work/warning_logic/decrypted_src/app/ui/dungeon/DungeonBattleRewardLayer.lua`。

### 角色死亡后的界面或处理

- `BattleMachineCommon:_fsmDie` 设置 `target:setIsDead(true)`，停止战斗动作，推送死亡渲染命令；主角还会发送 `MC_ROLE_MASTER_DEAD`。
  - 证据：`work/warning_logic/decrypted_src/app/battle/BattleMachineCommon.lua`，约 2426-2515 行。
- `DeadStateAction:onStart` 切换到 `FSMState.DIE`，普通角色死亡表现持续约 6 秒；`onEnd` 再按场景分流。
  - 证据：`work/warning_logic/decrypted_src/app/action/fsm/DeadStateAction.lua`，约 48-70 行。
- 普通洞窟：发送 `MC_BATTLE_REVIVE`，打开 `RevivePanel`，包含倒计时、免费/钻石复活按钮和放弃复活按钮。
- 副本、梦境、公会 Boss 等场景：主角通常走自动回城/放弃存档流程，普通复活按钮可能被隐藏；队友可能收到协助复活提示。
- 剧情场景：直接调用复活请求，不一定显示普通复活弹窗。
- 复活时钻石不足会打开钻石不足提示层；复活失败会显示错误消息；队友复活分支可能打开确认对话框。
  - 证据：`work/warning_logic/decrypted_src/app/ui/battlelayer/RevivePanel.lua`，约 390-570 行；`work/warning_logic/decrypted_src/app/battle/BattleMachineCommon.lua`，约 1690-1756 行。

### 逃跑后的界面或处理

- 逃跑成功：没有专用结果弹窗；`runAway` 完成后服务器以 `LeaveBattleReason_escape` 通知，角色返回原点并恢复待机。
- 逃跑失败：发送 `MC_UI_ESCAPE_FAILED`，移除逃跑进度条并重新启用道具栏、技能栏和逃跑按钮；本质是状态恢复，不是独立确认窗口。
- 取消逃跑：发送 `MC_UI_ESCAPE_CANCEL`，复用与逃跑失败相同的 UI 恢复逻辑。
  - 证据：`work/warning_logic/decrypted_src/app/battle/BattleMachineCommon.lua`，约 1207-1237 行；`work/warning_logic/decrypted_src/app/ui/battlelayer/MonsterPanel.lua`，约 1287-1349 行；群怪对应 `GroupMonsterPanel.lua`。

### 虚空秘境宝石选择界面

- 界面名称：`Cave / VoidRiftSelect`，视图为 `VoidRiftSelectView`。
- 客户端打开条件：收到 `ROLE_SYNC_VOIDRIFT_RUNE` 后，`data.runeData.selectableRunes` 被保存，且：
  - 当前不在加载场景；
  - 可选宝石数量大于 0。
- 这不是由客户端直接判断“战斗胜利”触发的；具体何时弹出由服务器何时发送 `ROLE_SYNC_VOIDRIFT_RUNE` 决定。因此它可能出现在战斗胜利后、换层后、重新进入地图或重新同步数据时。
- 进入虚空秘境地图时，如果模型中仍有未选择宝石，也会在地图加载完成后延迟约 0.2 秒检查并打开。
- 界面会关闭移动控件：发送 `MC_UI_CLOSE_CONTROL_PAD`、`MC_UI_CONTROL_END`，并调用 `GameManager:disableMovingHandler()`；关闭界面后恢复移动。
- 点击宝石提交其数组下标；底部放弃按钮提交索引 `0`。服务器返回成功后关闭界面，失败则显示错误。
  - 证据：`work/warning_logic/decrypted_src/app/net/NetRoleSystem.lua`，约 3350-3380 行；`work/warning_logic/decrypted_src/app/modules/cave/VoidRiftSelectView.lua`，约 20-123 行；`work/warning_logic/decrypted_src/app/modules/cave/CaveModel.lua`，约 529-549 行；`work/warning_logic/decrypted_src/app/machine/ShareMachineFunction.lua`，约 2578 行。

### 控制器应识别的高层阻塞状态

- `inBattle`：角色进入战斗后，直到胜利/逃跑收尾动作完成前保持为真。
- `isDead`：角色死亡标志。
- `hasBlockingPopup`（建议的后续扩展）：复活界面、虚空秘境宝石选择、奖励结算、钻石不足提示、Boss 剧情/过场等阻止移动的界面或遮罩。
- 不能只用 `inBattle=false` 作为恢复移动的条件；战斗结束后仍可能立即出现虚空秘境宝石选择或奖励结算界面。

## 秘境宝石配置分析（2026-09-04）

### 结论先行

- 当前 APK 客户端通过协议明确支持三套“秘境宝石”选择流程：深红炼狱、虚空秘境、维京时代。
- 客户端没有在秘境模块中硬编码“本局候选宝石列表”。服务器通过 `selectableRunes` 下发候选 ID，通过 `equippedRunes` 下发本局已经装备/累积的宝石 ID。
- 静态物品表中，秘境宝石是 `2323xxxx` 段的虚拟物品（`type = 23`），共 204 条记录；其中 `23230001` 是无名称的徽记记录，不计入宝石，因此是 203 个可配置宝石变体、71 个名称组。
- 当前客户端静态表没有 `caveMode` 字段，不能仅凭 `ProfileVirtualGoods` 把每个 ID 可靠地归属到某一个秘境；归属关系由服务器发送的 `ROLE_SYNC_*_RUNE` 消息决定。

### 协议和运行时流程（源码确认）

| 秘境 | 模型/字段 | 同步消息 | 选择请求 | 选择界面 |
|---|---|---|---|---|
| 深红炼狱（MODE_INFERNO=12） | `CaveModel.runeData`、`infernoRuneDataArr` | `ROLE_SYNC_INFERNO_RUNE` | `ROLE_REQ_SELECT_INFERNO_RUNE` | `Cave/InfernoSelect` |
| 试炼之地（MODE_TRIAL_LAND=15） | 复用炼狱宝石池（界面模型也按炼狱处理） | 同上 | 同上 | `Cave/InfernoSelect` |
| 虚空秘境（MODE_VOID_RIFT=14） | `CaveModel.voidRiftRuneData`、`voidRiftRuneDataArr` | `ROLE_SYNC_VOIDRIFT_RUNE` | `ROLE_REQ_SELECT_VOIDRIFT_RUNE` | `Cave/VoidRiftSelect` |
| 维京时代（MODE_VIKING=16） | `ViKingModel.viKingRuneData`、`viKingRuneDataArr` | `ROLE_SYNC_VIKING_RUNE` | `ROLE_REQ_SELECT_VIKING_RUNE` | `ViKing/ViKingSelect` |
| 混沌虫洞（MODE_CHAOS=23） | 有 `ChaosWormholeModel:handleChaosWormholeRune` 的存储代码 | 当前 `role_system.pb` 未发现对应同步/选择消息 | 未发现请求函数 | 当前 APK 没有接通选择流程 |

`Hero*RuneData` 的协议字段为：`equippedRunes`（重复宝石 ID）、`selectableRunes`（重复候选宝石 ID）、`extraRatioOfRune`（额外倍率字段）。点击界面中的宝石时提交的是候选数组下标，不是宝石 ID；提交 `0` 表示放弃选择。证据：`work/warning_logic/decrypted_src/utils/net/NetMessage.lua` 约 2409-2430、8023-8080；`work/warning_logic/decrypted_src/app/net/NetRoleSystem.lua` 约 739-759、3242-3388；`work/warning_logic/decrypted_src/app/modules/cave/CaveModel.lua` 约 46-54、529-563；`work/warning_logic/decrypted_src/app/modules/viking/ViKingModel.lua` 约 31-65；`work/warning_logic/decrypted_src/app/modules/cave/InfernoSelectView.lua`、`VoidRiftSelectView.lua`、`work/warning_logic/decrypted_src/app/modules/viking/ViKingSelectView.lua`。

### 选择弹窗标题（源码与语言表核对，2026-09-10）

弹窗顶部标题不是当前三张卡片的宝石名称，而是视图/副本模式的标题。源码中的 `UI.TEXT_*` 最终通过 `LanguageManager:getLocalString` 查语言表，当前 APK 的中文值如下：

| 标题 | 语言 ID | 来源/出现位置 |
|---|---:|---|
| `属性宝石` | 1115454 | `InfernoSelectView.lua` 的 `UI.TEXT_223412`；炼狱/试炼选择界面 |
| `元素炼狱宝石` | 1113934 | `CaveStateBagView.lua` 在 `MODE_INFERNO` 下使用 `UI.TEXT_1325503` |
| `虚空秘境宝石` | 1114802 | `VoidRiftSelectView.lua` 的 `UI.TEXT_222102` |
| `原初试炼宝石` | 1115484 | `ViKingSelectView.lua` 的 `UI.TEXT_223802`；维京界面复用了该中文标题 |

`CaveStateBagView.lua` 对未列出的模式使用 `属性宝石` 作为回退标题。`UIDes.lua` 中 `TEXT_1325503` 的旧注释写作“深红炼狱宝石”，但当前语言表实际值是“元素炼狱宝石”；控制器保留“深红炼狱宝石”作为旧版本兼容别名。证据：`work/warning_logic/decrypted_src/app/ui/UIDes.lua` 约 2643、2941、3132、3191 行；`work/warning_logic/decrypted_src/app/modules/cave/CaveStateBagView.lua` 约 58-66 行；`work/warning_logic/decrypted_src/app/modules/cave/InfernoSelectView.lua` 约 67-74 行；`work/warning_logic/decrypted_src/app/modules/cave/VoidRiftSelectView.lua` 约 65-72 行；`work/warning_logic/decrypted_src/app/modules/viking/ViKingSelectView.lua` 约 66-73 行；`outputs/runtime_hook/profile_extract/ProfileLanguage.dec` 对应语言条目。

控制器现在按“`<模式名>宝石`”规则匹配：已知标题优先精确匹配，同时允许未来新增模式只要标题以“宝石”结尾；OCR 末尾少量拉丁杂字符可以容忍。`宝石仓库`、`宝石合成`、`普通宝石`、`装备宝石`、`宠物宝石`等管理界面被排除，避免把普通界面误判为阻塞弹窗。

### 静态表字段

从 APK 的 `assets/res/Resource/profiles/commonProfile/ProfileVirtualGoods.luac` 解密得到的记录（工作副本：`outputs/runtime_hook/profile_extract/ProfileVirtualGoods.dec`）具有以下规律：

- 文件头标明生成源为 `virtualGoods.xlsx`（不是 `gemstone.xlsx`）；因此这里的 2323 段是“秘境选择用虚拟物品/遗物”配置。

- `ID`：落在 `23230002` 至 `23230204` 范围内（中间有空号），实际记录 203 条；
- `type = 23`：由 `GoodsDataManager:getGoodsTypeForGoodsID` 判定为虚拟物品；
- `name`：语言表 ID，已用 `assets/res/ResourceCN/ProfileLanguage.luac` 解出中文名称；
- `icon`：`icon_relilc_01.png` 至 `icon_relilc_37.png`，同一名称组通常共用图标；
- `goodsRare`：记录的稀有度/品质字段，常见为 2、3、4；
- `description` / `effecDescription`：效果说明语言 ID；
- `value1`：对应效果/规则 ID（例如 `30080010` 等）；
- `isServing = 0`、`isActivityServing = 0`：说明它们不是普通背包可用物，而是由秘境流程临时展示和结算。

排除 `23230001` 徽记后，203 个变体按 `goodsRare` 统计为：2 品质 107 条、3 品质 38 条、4 品质 58 条；这些数字是静态表记录数，不代表一次选择界面会同时出现这么多项。

另有一个容易混淆的文件 `ProfileGemstoneCave.luac`（工作副本：`outputs/runtime_hook/profile_extract/ProfileGemstoneCave.dec`）。它配置的是“宝石洞窟成长等级”，不是战斗结束时弹出的秘境宝石：共 8 个 `caveLV`，每级有 3 个 `gemstoneCaveId`，依次为 `{101,102,103}`、`{112,122,132}`、…、`{118,128,138}`，并带有经验/积分系数。

### 全部名称组及 ID

下面列出静态表中全部 71 个名称组；同一行的多个 ID 是同一宝石的不同品质或同类变体，末尾为图标文件名。`23230001 (icon_badge.png)` 是徽记，不列入宝石。

| 名称 | ID（全部变体） | 图标 |
|---|---|---|
| 齐贝林的财宝 | 23230002, 23230003, 23230004 | icon_relilc_01.png |
| 白浪面包 | 23230005, 23230006, 23230007 | icon_relilc_02.png |
| 卡美洛禁咒 | 23230008, 23230009, 23230010 | icon_relilc_03.png |
| 丹顿律法 | 23230011, 23230012, 23230013, 23230096 | icon_relilc_04.png |
| 太阳之剑 | 23230014, 23230015, 23230016, 23230097, 23230098, 23230099 | icon_relilc_05.png |
| 冰酒堡烈酒 | 23230017, 23230018, 23230019, 23230102, 23230103 | icon_relilc_06.png |
| 古德汉歌谱 | 23230020, 23230021, 23230022 | icon_relilc_07.png |
| 甘霖露滴 | 23230023, 23230024, 23230025, 23230084, 23230085, 23230086 | icon_relilc_08.png |
| 法力号角 | 23230026, 23230027, 23230028, 23230087, 23230088, 23230089 | icon_relilc_09.png |
| 折叠匕首 | 23230029, 23230030, 23230031, 23230090, 23230091, 23230092 | icon_relilc_10.png |
| 刺目水晶 | 23230032 | icon_relilc_11.png |
| 汲取之爪 | 23230033, 23230034, 23230035, 23230093, 23230094, 23230095 | icon_relilc_12.png |
| 冲锋战旗 | 23230036, 23230037, 23230038 | icon_relilc_13.png |
| 回生之泪 | 23230039 | icon_relilc_14.png |
| 金色戒指 | 23230040, 23230165 | icon_relilc_15.png |
| 红色戒指 | 23230041, 23230166 | icon_relilc_16.png |
| 绿色戒指 | 23230042, 23230167 | icon_relilc_17.png |
| 魅惑符咒 | 23230043 | icon_relilc_18.png |
| 飞驰之靴 | 23230044, 23230045, 23230046, 23230100, 23230101 | icon_relilc_19.png |
| 多元之力 | 23230047, 23230048, 23230049, 23230050 | icon_relilc_20.png |
| 红色泪滴 | 23230051, 23230052, 23230053 | icon_relilc_21.png |
| 守护者雕像 | 23230054, 23230055, 23230056 | icon_relilc_22.png |
| 白魔项链 | 23230057 | icon_relilc_23.png |
| 连击之书 | 23230058 | icon_relilc_24.png |
| 盾击之书 | 23230059 | icon_relilc_25.png |
| 雷霆之书 | 23230060 | icon_relilc_26.png |
| 固守之书 | 23230061 | icon_relilc_27.png |
| 暗辉之书 | 23230062 | icon_relilc_28.png |
| 战神之书 | 23230063 | icon_relilc_29.png |
| 击毁之书 | 23230064 | icon_relilc_30.png |
| 鬼剑之书 | 23230065 | icon_relilc_31.png |
| 愤怒之书 | 23230066 | icon_relilc_32.png |
| 冰弹之书 | 23230067 | icon_relilc_33.png |
| 吞噬之书 | 23230068 | icon_relilc_34.png |
| 灾祸之书 | 23230069 | icon_relilc_35.png |
| 炎爆之书 | 23230070 | icon_relilc_36.png |
| 灌注之书 | 23230071 | icon_relilc_37.png |
| 物理弱化 | 23230072, 23230073, 23230074 | icon_relilc_03.png |
| 元素弱化 | 23230075, 23230076, 23230077 | icon_relilc_01.png |
| 魔法弱化 | 23230078, 23230079, 23230080 | icon_relilc_02.png |
| 幸运儿 | 23230081, 23230082, 23230083 | icon_relilc_07.png |
| 坚不可摧 | 23230104-23230108 | icon_relilc_18.png |
| 制裁之力 | 23230109-23230113 | icon_relilc_27.png |
| 魔力充盈 | 23230114-23230118 | icon_relilc_37.png |
| 燎原 | 23230119-23230123 | icon_relilc_23.png |
| 冰霜 | 23230124-23230128 | icon_relilc_23.png |
| 割裂 | 23230129-23230133 | icon_relilc_23.png |
| 耀光 | 23230134-23230138 | icon_relilc_23.png |
| 永夜 | 23230139-23230143 | icon_relilc_23.png |
| 浴火 | 23230144-23230148 | icon_relilc_25.png |
| 致命灼烧 | 23230149, 23230150, 23230151 | icon_relilc_14.png |
| 侵蚀作用 | 23230152, 23230153, 23230154 | icon_relilc_14.png |
| 自然秩序 | 23230155, 23230156, 23230157 | icon_relilc_14.png |
| 光明之心 | 23230158, 23230159, 23230160 | icon_relilc_14.png |
| 虚空力量 | 23230161, 23230162, 23230163 | icon_relilc_14.png |
| 绝对信仰 | 23230164 | icon_relilc_32.png |
| 背水一战 | 23230170 | icon_relilc_30.png |
| 熟练 | 23230171 | icon_relilc_33.png |
| 战斗狂人 | 23230172 | icon_relilc_34.png |
| 丛生 | 23230173 | icon_relilc_36.png |
| 魔法元素 | 23230174 | icon_relilc_35.png |
| 先知守护 | 23230175 | icon_relilc_22.png |
| 凝固 | 23230176-23230180 | icon_relilc_25.png |
| 干扰 | 23230181-23230185 | icon_relilc_25.png |
| 渎神 | 23230186-23230190 | icon_relilc_25.png |
| 黎明 | 23230191-23230195 | icon_relilc_25.png |
| 武力对抗 | 23230196, 23230199, 23230202 | icon_relilc_21.png |
| 武术专精 | 23230197, 23230200, 23230203 | icon_relilc_26.png |
| 熔断 | 23230198, 23230201, 23230204 | icon_relilc_28.png |
| 神圣祝福 | 23230168 | icon_relilc_29.png |
| 圣光注入 | 23230169 | icon_relilc_31.png |

### 效果类别和可见内容

- 早期组（例如“齐贝林的财宝”“白浪面包”“卡美洛禁咒”）主要是每场战斗叠加攻击、抗性、格挡、暴击、回复等效果；同名的 2/3/4 品质使用不同 `description`/`effecDescription` 和 `value1`。
- “连击之书”至“灌注之书”是技能规则改写类宝石，例如改变技能触发条件、伤害倍率、吟唱或魔法消耗。
- “物理弱化”“元素弱化”“魔法弱化”是对目标弱点/攻击属性的削弱类宝石；“幸运儿”是收益/概率类效果。
- “坚不可摧”至“浴火”、以及“凝固”至“熔断”等新增组使用连续 5 个 ID，当前品质字段多为 2；实际效果必须读取对应 `description`/`effecDescription` 语言项，不能只凭图标判断。
- 例如语言表已确认：`1102543` = “每次战斗增加元素攻击2.5%，上限10%”；`1102575` = “每次战斗增加元素攻击5%，上限20%”；`1044261` = “目标的物理攻击降低5%”。

### 对助手实现的影响

1. 读取宝石候选时应保存 `(caveMode, selectableRunes 原始 ID 顺序)`，不要用图标或名称反推秘境归属。
2. 展示名称/图标时按 ID 查询虚拟物品表；未知 ID 显示问号并记录原始 ID，不能静默映射到普通宝石。
3. 识别“已选择/已装备”时比较 `equippedRunes` 的 ID 集合；不要把 `selectableRunes` 当成已经生效的宝石。
4. 对混沌虫洞只能标记为“源码存在模型存储，但当前 APK 未接通协议”，除非后续抓到新的服务端消息或更新 APK。

### 证据文件

- `work/warning_logic/decrypted_src/app/datas/PublicDefine.lua` 约 185-210 行：秘境模式枚举。
- `work/warning_logic/decrypted_src/app/datas/GoodsDataManager.lua` 约 883-912、1560-1590 行：`2323xxxx` 按前缀识别为 `GOODS_VIRTUALITEM`。
- `outputs/runtime_hook/profile_extract/ProfileVirtualGoods.dec` 2443-2646 行：全部 `2323xxxx` 静态虚拟物品记录；原始 APK 条目为 `assets/res/Resource/profiles/commonProfile/ProfileVirtualGoods.luac`。
- `outputs/runtime_hook/profile_extract/ProfileLanguage.dec` 15127-15367、17777-17854 行：名称和效果说明的中文语言表；原始 APK 条目为 `assets/res/ResourceCN/ProfileLanguage.luac`。
- `outputs/runtime_hook/profile_extract/role_system.pb`：`HeroInfernoRuneData`、`HeroVoidRiftRuneData`、`HeroVikingRuneData` 及三套请求/返回/同步消息；未发现 Chaos Wormhole 对应的 Rune 消息。

## 另一个辅助的“是否可以移动”判定（2026-09-04）

### 结论

源码没有一个统一的“当前是否有界面覆盖”布尔值。移动是否被允许，主要由以下三层共同决定：

1. `ShareMachine._enableRoleMoving`：全局移动开关；
2. `HeroData:judegeToMove()`：主角是否被冻结、眩晕、被约束，FSM 是否处于 `MOVE/IDLE`，以及是否死亡；
3. 少数特殊玩法的倒计时：打地鼠、裂隙、记忆翻牌等活动在倒计时未结束时禁止移动。

因此，“界面可见”本身并不等价于“禁止移动”。某个界面只有在主动调用 `GameManager:disableMovingHandler()` 时，才会把第 1 层开关置为 false；界面关闭时再调用 `enableMovingHandler()` 恢复。

### 源码确认的调用链

方向键/摇杆最终调用 `GameManager:startMoveHandler(direction)`，它创建 `GENERATION_START_MOVE` 命令；命令在 `ShareMachineGenerationCmd` 中进入 `_battleStartMove()`，再调用 `_judegeToMove(master)`，通过后才执行 `_fsmDirectionMove()`。

`_judegeToMove()` 的顺序是：

```text
_enableRoleMoving == false        -> 禁止
特殊玩法 fightRemindCD > 0        -> 禁止
master:judegeToMove() == false     -> 禁止
否则                              -> 允许
```

证据：`work/warning_logic/decrypted_src/app/machine/ShareMachineGenerationCmd.lua` 约 147-173、`work/warning_logic/decrypted_src/app/machine/ShareMachineFunction.lua` 约 3955-3970、`work/warning_logic/decrypted_src/app/game/GameClientMessageManager.lua` 约 51-66、763-781。

主角层的 `judegeToMove()` 只检查：冻结 `getIsFrozen()`、眩晕 `getIsStun()`、约束 `getIsConstraint()`；FSM 状态为 `FSMState.MOVE` 或 `FSMState.IDLE`；`getIsDead() == false`。它没有检查任意 UI 节点是否显示。证据：`work/warning_logic/decrypted_src/app/datas/role/HeroData.lua` 约 2149-2158。

### 界面覆盖为什么仍可能继续操作

这是源码中可以确认的几个原因：

- 界面是否阻止移动采用“协作式”做法，而不是由 `UIManager` 统一仲裁。比如虚空秘境宝石选择界面在构造时显式 `disableMovingHandler()`，析构时显式 `enableMovingHandler(true)`；证据：`work/warning_logic/decrypted_src/app/modules/cave/VoidRiftSelectView.lua` 约 20-43。
- 另一些界面只调用 `GameManager:stopMoveHandler()`，没有关闭 `_enableRoleMoving`。例如 NPC 对话初始化时只停止当前移动：`work/warning_logic/decrypted_src/app/ui/common/NpcDialog.lua` 约 132-140；这不保证后续新的开始移动命令会被拒绝。
- 全屏触摸阻挡层 `UIBlockingLayer` 只负责吞掉触摸事件，监听的是 `MC_SET_BLOCKING_TOUCHES`；它不直接读取或修改主角 FSM。证据：`work/warning_logic/decrypted_src/app/ui/UIBlockingLayer.lua` 约 85-105、137-151。
- 摇杆的触摸入口本身也不是严格的全局门禁：`ControlPad:onTouchBegan` 在 `canUseControlMove()==false` 时，原本应 `return false` 的语句被注释掉；真正开始移动是在 `startRockerNew()` 中再次检查 `canUseControlMove()`。证据：`work/warning_logic/decrypted_src/app/ui/battlelayer/ControlPad.lua` 约 486-510、1063-1086。
- 点击地图的拖动路径与点击结束路径也不完全相同。`_onTouchMapTileMoved()` 主要检查 `canUseClickMove()` 和主角 FSM/死亡状态；点击结束时才额外调用 `MapClickBlockUtil:isBlocked()`，而该工具只检查顶层 `pNpcDialog` 和 `pIndicateUILayer` 两个节点。证据：`work/warning_logic/decrypted_src/app/machine/ShareMachineGenerationCmd.lua` 约 179-190、285-315、365-397；`work/warning_logic/decrypted_src/app/utils/MapClickBlockUtil.lua` 约 8-33。

### “另一个辅助”最可能采用的方式

仓库中保存的另一套辅助脚本（反编译文件 `outputs/module_primary_decompiled.lua`）可以直接看到：它的路线执行分支没有调用 `GameManager:canUseControlMove()` 或 `_judegeToMove()`，而是从共享变量 `路径` 取出方向码，按固定屏幕坐标调用 `LuaAuxLib.TouchOperation`。例如方向码 `0/3/1/2` 分别按 `(223,235)/(60,230)/(213,88)/(58,89)`，每步执行“按下 → `Sleep(移动间隔+66)` → 松开 → `Sleep(移动间隔)`”；证据：`outputs/module_primary_decompiled.lua` 约 24397-24407、24431-24472。

它在移动前确实做过一次多点找色判断（区域约 `595,245–640,429`），但该判断只是在两套移动节奏/特殊处理分支之间选择，并不是通用的“弹窗存在则停止”门禁。遇到路径项 `怪` 时它会松开并进入打怪流程；`门`、`点金`、`神秘商人买卖窗口` 等则在路线结束后按类型处理。它没有对所有界面节点做枚举，也没有把 `UIBlockingLayer` 的状态纳入移动条件。

所以观察到“有界面覆盖仍然操作”时，最稳妥的解释是：该辅助只要路线数组非空就继续注入固定方向触控；它不依赖游戏内部的 `_enableRoleMoving`/FSM 门禁。若弹窗没有覆盖左下角方向按钮，触控会照常被游戏控件接收；即使弹窗覆盖了地图，方向控件仍可能继续响应。若其原生注入层绕过了 Cocos 触摸分发，则全屏遮罩也无法阻止它——这一点需要该辅助的原生输入实现才能最终确认。

这部分是基于调用链的行为推断；源码能直接确认的是“移动判定不读取通用 UI 覆盖状态”，以及“部分界面只停止当前移动、不关闭全局移动开关”。

### 对当前控制器的启示

当前 ADB 控制器如果要复现另一辅助的行为，不能用“检测到任何窗口就停”作为规则；应至少区分：

- 可继续移动的覆盖：不拦截方向键、没有改变 `_enableRoleMoving`/主角 FSM 的界面；
- 必须停移动的状态：战斗、死亡、冻结/眩晕/约束、换层/奖励/宝石选择、Boss 过场，以及明确的全屏阻挡层；
- 外部 ADB 触摸绕过游戏 UI 时，必须自行补一层弹窗状态识别，否则会出现“界面已经盖住但仍在走”的现象。

建议将“角色能否移动”和“当前是否允许自动化输入”拆成两个状态：前者尽量对应游戏的 `_judegeToMove`，后者再叠加控制器自己识别的阻塞界面与流程阶段。

## 原辅助如何选择秘境宝石（2026-09-04）

### 先修正触摸层结论

前面把“注入层可能绕过界面”说得过强。若辅助最终调用的是模拟触摸/点击，事件仍会经过 Android 输入和游戏控件的命中测试；全屏遮罩或弹窗覆盖了点击位置时，点击不能凭空穿透。辅助能做到的只是：等待界面出现后，把点击发到界面上的按钮坐标；它不能跳过宝石选择界面直接让游戏换层。

### 游戏自身的宝石选择流程（源码确认）

1. 服务器发送 `ROLE_SYNC_*_RUNE`，消息中的 `runeData.selectableRunes` 是本次可选 ID 数组，`equippedRunes` 是已经生效的 ID 数组。
2. `NetRoleSystem` 收到同步消息后把数组交给对应模型；只要不在加载场景且候选数组非空，就打开 `Cave/InfernoSelect`、`Cave/VoidRiftSelect` 或 `ViKing/ViKingSelect`。
3. 选择界面把候选数组按顺序生成卡片。每张卡片的点击按钮调用 `reqSelect*Rune(data.key)`，其中 `data.key` 是数组下标（1、2、3），不是宝石 ID；放弃按钮提交 0。
4. 服务器返回成功后客户端关闭选择界面，等待层消失并恢复移动控件。因此正确的自动化顺序必须是“确认弹窗存在 → 点击某张卡片 → 轮询弹窗消失/返回成功”，而不是只发送一次点击后立即继续移动。

证据：`work/warning_logic/decrypted_src/app/net/NetRoleSystem.lua` 约 3242-3389；`work/warning_logic/decrypted_src/app/modules/cave/VoidRiftSelectView.lua` 约 75-126；`work/warning_logic/decrypted_src/app/modules/cave/InfernoSelectView.lua` 约 77-128；`work/warning_logic/decrypted_src/app/modules/cave/InfernoSelectCell.lua` 约 162-175；`work/warning_logic/decrypted_src/app/modules/cave/CaveModel.lua` 约 529-563。

### 对原辅助脚本的核查结果

在当前可读的反编译文件 `outputs/module_primary_decompiled.lua` 中，没有找到调用 `reqSelectVoidRiftRune`、`reqSelectInfernoRune`、`reqSelectViKingRune` 或按 `2323xxxx` 宝石 ID 决策的代码。也没有发现“读取三张卡片名称/效果后再选择”的 OCR 或文本解析分支。因此不能把它描述成“按宝石属性智能选择”。

能直接确认的是另一类四格选择：函数在约 24615-24637 行只有在目标类型为 `"箱子"` 且刚发生过战斗时执行，根据路径数组中保存的字符串 `0/1/2/3`，点击四个固定坐标 `(385,735)`、`(248,534)`、`(365,539)`、`(251,733)` 中的一个，并等待 300ms。这个分支是箱子/战斗奖励处理，不是秘境宝石三选一；它也说明该辅助采用“截图找色 + 固定坐标点击”，而非跳过上层界面。

同一脚本中的 `"BUFF"` 只用于小地图道路扫描（约 23970-24048 行），表示地图上的增益节点；它不是战斗结束时的秘境宝石选择。战利品页面则通过颜色特征识别后点击确认（约 24904-24919 行），仍然是普通模拟点击。

由于反编译结果存在重命名和缺失上下文，不能排除辅助的其它模块或配置文件另有宝石分支；但就目前这份主脚本，**没有足够证据证明它能够识别宝石内容**。最保守的行为模型是：检测选择界面的颜色/布局，按预设卡片序号点击（或者根本不处理该界面），再通过界面消失判断完成。

### 实现时应采用的可验证方案

- 先用截图特征确认宝石选择遮罩、标题和三张卡片均已出现；未确认到弹窗时不点击卡片坐标。
- 卡片位置按游戏布局计算，不写死原辅助的四格箱子坐标：弹窗内容区宽 672；三张卡片槽宽 `672/3=224`，卡片按钮位于各卡片底部约 55 像素处。设备分辨率变化时按弹窗实际边界缩放。
- 点击后轮询 `ROLE_RESP_SELECT_*_RUNE` 对应的界面结果（外部辅助只能用截图判断）：等待层/弹窗消失，或候选图标消失后才恢复路线；超时应停止移动并重新截图。
- 若要按“优先效果”选择，必须先从当前候选卡片读取名称/效果（优先使用运行时 `selectableRunes` ID，再查 `ProfileVirtualGoods`），不能只依据通用宝石图标，因为同一图标可能对应多个 ID 和品质。

### 当前模拟器实测的弹窗特征（2026-09-04）

当前设备截图显示标题“原初试炼宝石”，中央有三张横向卡片，每张卡片上半部都有大面积橙色遗物面板，下半部有“选择”按钮，底部有“放弃”。控制器新增的 `HasRiftGemSelection` 使用三个归一化窗口（约 `x=18%~38%`、`39%~61%`、`62%~82%`，`y=13%~43%`）分别检测三张遗物面板，必须三块同时满足橙色特征才判定弹窗存在。实测截图中三块匹配率约为 0.275、0.221、0.202；普通地图和“返回城镇/下一层”三卡片弹窗的对应匹配率均低于 0.01，因此不会仅凭下方按钮颜色误判。

这项检测只负责阻止方向输入并等待界面关闭，暂不自动猜测宝石优先级；卡片的语义选择仍需使用候选 ID/名称/效果数据或由用户指定卡片序号。

## 贪婪抉择的回城分支（2026-09-24）

### 源码确认

- `PublicDefine.GreedyEvent` 定义了 `GreedyEvent_Down = 1`（下楼）、`GreedyEvent_Return = 2`（回城）和 `GreedyEvent_Special = 3`（特殊回城）。证据：`work/warning_logic/decrypted_src/app/datas/PublicDefine.lua` 约 1124-1128 行。
- `GreedySelectView:createOneItem` 根据服务器下发的 `eventIdx` 设置卡片标题和按钮：事件 1 显示“继续探险/前往下一层”，事件 2 显示“返回城镇/安全回城”，事件 3 显示“返回城镇/特殊回城”；三类事件都通过 `GREEDY_SELECT_DO_SELECT` 提交卡片索引。证据：`work/warning_logic/decrypted_src/app/modules/greedyselect/GreedySelectView.lua` 约 46-53、54-155 行；`work/warning_logic/decrypted_src/app/ui/UIDes.lua` 约 2020-2027 行。
- 底部“再考虑一下”提交 `isSelect=false`，不是回城操作；回城必须点击对应卡片底部按钮。证据：`GreedySelectView.lua` 约 218-227 行、`GreedySelectController.lua` 约 14-28 行。

### 控制器处理结论

- “贪婪抉择”弹窗不能一律按下一层处理。若 OCR 在卡片区域识别到回城文案且未识别到“继续探险/前往下一层”，应点击卡片的安全回城按钮，并结束当前跑图任务，等待游戏返回城镇。
