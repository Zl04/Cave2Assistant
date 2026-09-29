--[[
    角色动画命令
]]--

require "app.command.Command"
require "app.pool.Pool"

Command = Command or {}

local RendererCommand = class("RendererCommand", Command.Base)
Command.RendererCommand = RendererCommand

-- private:
-- 对象池
local RendererCommandPool = nil

-- public:
-- 创建对象
function RendererCommand:create(reused, ...)
    if (reused) then
        if (not RendererCommandPool) then
            RendererCommandPool = Pool.Pool:create(RendererCommand)
        end
        return RendererCommandPool:applyObject()
    else
        return RendererCommand.new(...)
    end
end

-- 构造函数
function RendererCommand:ctor()
    RendererCommand.super.ctor(self, CommandCategory.RENDERER, CommandType.NONE)
end

-- 销毁
function RendererCommand:dtor()
    RendererCommand.super.dtor(self)

    self.target = nil
    self.attackTarget = nil
    self.skill = nil
    self.bulletFromTarget = nil
    self.bulletToTarget = nil
    self.bulletFromMount = nil
    self.bulletToMount = nil
    self.animationName = nil
    self.mountName = nil
    self.coordList = nil
    self.mountNameList = nil
    self.mountAnimationPrefixList = nil
end

-- 清理
function RendererCommand:clear()
    RendererCommand.super.clear(self)

    self.type = CommandType.NONE
    self.target = nil
    self.attackTarget = nil
    self.skill = nil
    self.startCoordX = 0
    self.startCoordY = 0
    self.startCoordZ = 0
    self.coordX = 0
    self.coordY = 0
    self.coordZ = 0
    self.nextCoordX = 0
    self.nextCoordY = 0
    self.nextCoordZ = 0
    self.moveMap = true
    self.syncPosition = false
    self.direction = 0
    self.animationType = CommandAnimationType.NONE
    self.bulletFromTarget = nil
    self.bulletToTarget = nil
    self.bulletFlyTime = 0
    self.bulletFromMount = nil
    self.bulletToMount = nil
    self.offset = 0
    self.bufferID = 0
    self.animationName = nil
    self.mountName = nil
    self.coordList = nil
    self.timeScale = 1.0
    self.mountNameList = nil
    self.mountAnimationPrefixList = nil
end

-- 初始化没有参数的渲染命令（通用）
function RendererCommand:initCommand(commandType)
    self.type = commandType
end

-- 更新角色spine动画播放速率
function RendererCommand:initUpdateSpineTimeScale(modelID, timeScale)
    self.type = CommandType.RENDERER_SPINE_TIME_SCALE
    
    self.modelID = modelID
    self.timeScale = timeScale
end

-- 初始化更新坐标命令
function RendererCommand:initUpdatePositionCommand(modelID, coord, moveMap)
    self.type = CommandType.RENDERER_POSITION
    self.modelID = modelID
    self.coordX = coord.x
    self.coordY = coord.y
    self.coordZ = coord.z
    if (moveMap == nil) then self.moveMap = false
    else self.moveMap = moveMap end
end

-- 初始化更新方向命令
function RendererCommand:initUpdateDirectionCommand(modelID, direction)
    self.type = CommandType.RENDERER_DIRECTION
    self.modelID = modelID
    self.direction = direction
end

-- 更新z序的命令
function RendererCommand:initUpdateZOrderCommand(modelID, coord, offset)
    self.type = CommandType.RENDERER_ZORDER

    self.modelID = modelID
    self.coordX = coord.x
    self.coordY = coord.y
    self.coordZ = coord.z
    self.offset = (offset == nil) and 0 or offset
end

function RendererCommand:initNPCChangeCoordCommand(modelID, coord)
    self.type = CommandType.RENDERER_NPC_CHANGE_COORD
    self.modelID = modelID
    self.coordX = coord.x
    self.coordY = coord.y
    self.coordZ = coord.z
end


-- 进入地块中心点的命令
function RendererCommand:initEnterCenterCoordCommand(modelID, coord, syncPosition)
    self.type = CommandType.RENDERER_ENTER_CENTER_COORD
    self.modelID = modelID
    self.coordX = coord.x
    self.coordY = coord.y
    self.coordZ = coord.z
    self.syncPosition = syncPosition or false

    if(self.coordX == 0 and self.coordY == 0) then 
        print("RendererCommand:initEnterCenterCoordCommand",self.type, coord.x, coord.y, coord.z, self.syncPosition)
        -- printError("RendererCommand:initEnterCenterCoordCommand coord is Invilad.")
    end
end

-- 初始化更新动画命令
function RendererCommand:initUpdateAnimationCommand(modelID, animationType, timeScale, animationName)
    self.type = CommandType.RENDERER_ANIMATION
    self.modelID = modelID
    self.animationType = animationType
    self.timeScale = timeScale or 1.0
    self.animationName = animationName
end

-- 显示待机动画命令
function RendererCommand:initIDLEAnimationCommand(modelID)
    self.type = CommandType.RENDERER_IDLE
    self.modelID = modelID
end

-- 初始化战斗属性改变指令，
function RendererCommand:initUpdateAttrCommand(modelID, data, direction)
    self.type = CommandType.RENDERER_ATTR
    self.modelID = modelID
    self.data = data
    self.direction = direction
end


-- 初始化战斗属性改变指令，
function RendererCommand:initUpdateCommonAttrCommand(modelID, data)
    self.type = CommandType.RENDERER_ATTR_COMMON
    self.modelID = modelID
    self.data = data
end


-- 初始化蓄力或者呤唱技能动画的命令
function RendererCommand:initPrepareSkillCommand(modelID, skill)
    self.type = CommandType.RENDERER_PREPARE_SKILL
    self.modelID = modelID
    self.skill = skill
end

-- 初始化释放技能动画的命令
function RendererCommand:initReleaseSkillCommand(modelID, skill)
    self.type = CommandType.RENDERER_RELEASE_SKILL
    self.modelID = modelID
    self.skill = skill
end

-- 初始化释放辅助技能
function RendererCommand:initReleaseAssistSkillCommand(modelID, skill)
    self.type = CommandType.RENDERER_RELEASE_ASSIST_SKILL
    self.modelID = modelID
    self.skill = skill
end

-- 释放技能效果
function RendererCommand:initReleaseActAnimationCommand(modelID, fromSpriteID, spineName, mountName, delayTime, timeScale, direction, isSelf)
    self.type = CommandType.RENDERER_RELEASE_ACT_ANIMATION
    self.modelID = modelID
    self.fromSpriteID = fromSpriteID
    self.spineName = spineName
    self.mountName = mountName
    self.delayTime = delayTime
    self.timeScale = timeScale
    self.direction = direction
    self.isSelf = isSelf
end

-- 技能指令相关的逻辑
function RendererCommand:initReleaseActAnimationRemoveCommand(modelID, fromSpriteID)
    self.type = CommandType.RENDERER_RELEASE_ACT_ANIMATION_REMOVE
    self.modelID = modelID
    self.fromSpriteID = fromSpriteID
end

-- 初始化完成技能动画的命令
function RendererCommand:initFinishSkillCommand(modelID, skill)
    self.type = CommandType.RENDERER_FINISH_SKILL
    self.modelID = modelID
    self.skill = skill
end

function RendererCommand:initNormalSkillCommand(modelID, skill, speedUp)
    self.type = CommandType.RENDERER_NORMAL_SKILL
    self.modelID = modelID
    self.skill = skill
    self.speedUp = speedUp
end 

-- 初始化添加 buffer 动画命令
function RendererCommand:initAddBufferCommand(modelID, bufferID, loop, animationName, mountNameList, mountAnimationPrefixList,fxFlip)
    self.type = CommandType.RENDERER_ADD_BUFF
    self.modelID = modelID
    self.bufferID = bufferID
    self.loop = loop
    self.animationName = animationName
    self.mountNameList = mountNameList
    self.mountAnimationPrefixList = mountAnimationPrefixList
    self.fxFlip = fxFlip
end

-- 初始化添加 buffer 动画命令
function RendererCommand:initRemoveBufferCommand(modelID, bufferID, mountAnimationPrefixList)
    self.type = CommandType.RENDERER_REMOVE_BUFF
    self.modelID = modelID
    self.bufferID = bufferID
    self.mountAnimationPrefixList = mountAnimationPrefixList
end

-- 初始化添加 effect 动画命令
function RendererCommand:initAddEffectCommand(modelID, effect)
    self.type = CommandType.RENDERER_ADD_EFFECT
    self.modelID = modelID
    self.effect = effect
end

-- 准备技能特效的动画命令
function RendererCommand:initPrepareSkillFXCommand(modelID, skill)
    self.type = CommandType.RENDERER_PREPARE_SKILL_FX
    self.modelID = modelID
    self.skill = skill
end

-- 结束技能准备的特效的动画命令
function RendererCommand:initFinishPrepareSkillFXCommand(modelID, skill)
    self.type = CommandType.RENDERER_FINISH_PREPARE_SKILL_FX
    self.modelID = modelID
    self.skill = skill
end

-- 释放技能特效的动画命令
function RendererCommand:initReleaseSkillFXCommand(modelID, skill)
    self.type = CommandType.RENDERER_RELEASE_SKILL_FX
    self.modelID = modelID
    self.skill = skill
end

-- 取消技能特效的命令
function RendererCommand:initBreakSkillFXCommand(modelID, skill)
    self.type = CommandType.RENDERER_BREAK_SKILL_FX
    self.modelID = modelID
    self.skill = skill
end

-- 清理角色身上的特效
function RendererCommand:initClearSkillFXCommmand(modelID)
    self.type = CommandType.RENDERER_CLEAR_SKILL_FX
    self.modelID = modelID
end

-- 设置飞行道具的状态，包括起始和终点目标，飞行时间等
function RendererCommand:initBulletStateCommand(modelID, fromTargetModelID, fromMount, toTargetModelID, toMount, flyTime)
    self.type = CommandType.RENDERER_BULLET_STATE
    self.modelID = modelID
    self.bulletFromTargetModelID = fromTargetModelID
    self.bulletToTargetModelID = toTargetModelID
    self.bulletFlyTime = flyTime
    self.bulletFromMount = fromMount
    self.bulletToMount = toMount
end

-- 设置获取物品特效所需的状态
function RendererCommand:initAddGoodsStateCommmand(modelID, openWithSelf, startCoord, toTargetModelID, toMount,fromMonster)
    self.type = CommandType.RENDERER_ADD_GOODS_FX
    self.modelID = modelID
    self.openWithSelf = openWithSelf
    self.startCoord = startCoord
    self.fromMonster = fromMonster
    self.toTargetModelID = toTargetModelID
    self.toMount = toMount
end

-- 设置角色死亡处理
function RendererCommand:initDeadCommand(modelID,recoverDead, showRevive, hitratMonsterRefresh,isRemoveSelf)
    self.type = CommandType.RENDERER_ROLE_DEAD
    self.modelID = modelID
    self.recoverDead = recoverDead
    self.showRevive = showRevive
    self.isRemoveSelf = isRemoveSelf
    self.hitratMonsterRefresh = hitratMonsterRefresh
end

-- 设置触发宝箱，钱袋等npc 效果
function RendererCommand:initOpenItCommand(modelID,recoverOpen, pk)
    self.type = CommandType.RENDERER_OPEN_IT_NPC
    self.modelID = modelID
    self.recoverOpen = recoverOpen
    self.pk = pk
end

-- 处理隐藏传送门触发
function RendererCommand:initHideTransdoorTrigger(modelID)
    self.type = CommandType.RENDERER_NPC_HIDE_TRANSDOOR_TRIGGER

    self.modelID = modelID
end

-- 处理复活
function RendererCommand:initRoleRevive(modelID, coord)
    self.type = CommandType.RENDERER_ROLE_REVIVE
    
    self.modelID = modelID
    self.coord = coord
end

-- 处理复活完成
function RendererCommand:initRoleEndRevive(modelID)
    self.type = CommandType.RENDERER_END_REVIVE
    
    self.modelID = modelID
end

-- 处理移除回城效果
function RendererCommand:initRoleRemoveBackTown(modelID)
    self.type = CommandType.RENDERER_ROLE_REMOVE_BACK_TOWN
    self.modelID = modelID
end

-- 处理控制角色称号
function RendererCommand:initForRoleTitle(modelID,titleID,param)
    self.type = CommandType.RENDERER_ROLE_TITLE

    self.modelID = modelID
    self.titleID = titleID
    self.param = param
end

-- 处理公会名字
function RendererCommand:initForRoleGuildName(modelID,guildName,isShow)
    self.type = CommandType.RENDERER_GUILD_NAME

    self.modelID = modelID
    self.guildName = guildName
    self.isShow = isShow
end

-- 设置引导指向标
function RendererCommand:initGuidePointer(modelID,isShow,title,x,y)
    self.type = CommandType.RENDERER_SET_GUIDE_POINTER

    self.modelID = modelID
    self.isShow = isShow
    self.title = title
    self.x = x
    self.y = y
end

-- 处理控制角色名字
function RendererCommand:initRoleName(modelID,name,isShow,isMaster,color)
    self.type = CommandType.RENDERER_ROLE_NAME

    self.modelID = modelID
    self.name = name
    self.isShow = isShow
    self.isMaster = isMaster
    self.color = color
end

-- 打开宝箱获得暗金装备的效果
function RendererCommand:initGetDarkGoldenCommand(modelID,isDarkGolden,openWithSelf,flyTargetModelID,flyStartCoord,flyToTargetModelID,flyToMount,flyTime)
    self.type = CommandType.RENDERER_GET_DARKGOLDEN_EFFECT
    self.modelID = modelID
    self.isDarkGolden = isDarkGolden
    self.openWithSelf = openWithSelf
    self.flyTargetModelID = flyTargetModelID
    self.flyStartCoord = flyStartCoord
    self.flyToTargetModelID = flyToTargetModelID
    self.flyToMount = flyToMount
    self.flyTime = self.flyTime
end

-- 刷新穿戴装备效果
function RendererCommand:initRefreshWearEquipmentCommand(modelID,wearEquipmentArr)
    self.type = CommandType.RENDERER_REFRESH_WEAR_EQUPMENT
    self.modelID = modelID
    self.wearEquipmentArr = wearEquipmentArr
end

-- 刷新皮肤和面部
function RendererCommand:initRefreshSkinAndFaceCommand(modelID,dataArr)
    self.type = CommandType.RENDERER_REFRESH_SKINADNFACE
    self.modelID = modelID
    self.skinAndFaceArr = dataArr
end

-- 显示角色周围可以的地图格子
-- coords:需要高亮显示的格子坐标
function RendererCommand:initShowMapGridCommand(coordList)
    self.type = CommandType.RENDERER_SHOW_MAP_GRID
    self.coordList = coordList
end

-- 隐藏高亮显示的地图格子
function RendererCommand:initHideMapGridCommand()
    self.type = CommandType.RENDERER_HIDE_MAP_GRID
end

-- 地图格子变成地块
function RendererCommand:initMapTileChangeCommand(coordX, coordY)
    self.type = CommandType.RENDERER_MAP_TILE_CHANGE
    self.coordX = coordX
    self.coordY = coordY
end

function RendererCommand:initRoleLevelUp(modelID)
    self.type = CommandType.RENDERER_ROLE_LEVEL_UP

    self.modelID = modelID
end

function RendererCommand:initRoleLevelUpAttr(modelID,attrArr)
    self.type = CommandType.RENDERER_ROLE_LEVEL_UP_ATTR

    self.modelID = modelID
    self.attrArr = attrArr
end

function RendererCommand:initTriggerNpcUnlock(modelID)
    self.type = CommandType.RENDERER_TRIGGER_NPC_UNLOCK
    
    self.modelID = modelID
end

function RendererCommand:initStartShowRevive(modelID)
    self.type = CommandType.RENDERER_SHOW_START_REVIVE

    self.modelID = modelID
end

function RendererCommand:initNpcTrapEffect(modelID)
    self.type = CommandType.RENDERER_NPC_TRAP_EFFECT

    self.modelID = modelID
end

-- function RendererCommand:initFunctionButton(modelID, data)
--     self.type = CommandType.RENDERER_FUNCITON_BUTTON

--     self.modelID = modelID
--     self.data = data
-- end

function RendererCommand:initFaceChange(modelID, faceDecodeID)
    self.type = CommandType.RENDERER_FACE_CHANGE

    self.modelID = modelID
    self.faceDecodeID = faceDecodeID
end

-- 触发怪物
function RendererCommand:initTriggerMonster(modelID)
    self.type = CommandType.RENDERER_TRIGGER_MONSTER
    self.modelID = modelID
end

-- 显示怪物血条
function RendererCommand:initShowMonsterBlood(modelID, curHp, hp)
    self.type = CommandType.RENDERER_SHOW_MONSTER_BLOOD
    self.modelID = modelID

    self.curHp = curHp
    self.hp = hp
end

-- 更新怪物血条
function RendererCommand:initUpdateMonsterBlood(modelID, curHp, hp)
    self.type = CommandType.RENDERER_UPDATE_MONSTER_BLOOD
    self.modelID = modelID

    self.curHp = curHp
    self.hp = hp
end

-- 移除怪物血条
function RendererCommand:initRemoveMonsterBlood(modelID)
    self.type = CommandType.RENDERER_REMOVE_MONSTER_BLOOD
    self.modelID = modelID
end

-- 处理战斗状态表现
function RendererCommand:initBattleStatusAnimation(modelID, animationName, loop)
    self.type = CommandType.RENDERER_BATTLE_STATUS_ANIMATION
    self.modelID = modelID

    self.animationName = animationName
    self.loop = loop
    if(self.loop == nil) then
        self.loop = false
    end
end

-- 添加一个表现
function RendererCommand:initAddEffectView(modelID, fxAnimName, fxMountPoint, fxFlip)
    self.type = CommandType.RENDERER_ADD_EFFECT_VIEW
    self.modelID = modelID
    
    self.fxAnimName = fxAnimName
    self.fxMountPoint = fxMountPoint
    self.fxFlip = fxFlip
end

-- 移除装饰物
function RendererCommand:initRemoveDecoration(modelID, coordX, coordY, decorationID)
    self.type = CommandType.RENDERER_REMOVE_DECORATIONS
    self.modelID = modelID

    self.coordX = coordX
    self.coordY = coordY
    self.decorationID = decorationID
end

function RendererCommand:initNPCInfomationShow(modelID, textStr, talkDucation)
    self.type = CommandType.RENDERER_NPC_INFOMATION_SHOW
    self.modelID = modelID

    self.textStr = textStr
    self.talkDucation = talkDucation
end

function RendererCommand:initPeddlerInfomationShow(modelID, textStr, saleID, giveID, givePrice, talkDucation)
    self.type = CommandType.RENDERER_PEDDLER_INFOMATION_SHOW
    self.modelID = modelID

    self.textStr = textStr
    self.saleID = saleID
    self.giveID = giveID
    self.givePrice = givePrice
    self.talkDucation = talkDucation
end

function RendererCommand:initNPCInfomationHide(modelID)
    self.type = CommandType.RENDERER_NPC_INFOMATION_HIDE
    self.modelID = modelID
end

function RendererCommand:initSelectHeroShow(modelID)
    self.type = CommandType.RENDERER_TOWN_SELECT_HERO_SHOW
    self.modelID = modelID
end

function RendererCommand:initSelectHeroHide(modelID)
    self.type = CommandType.RENDERER_TOWN_SELECT_HERO_HIDE
    self.modelID = modelID
end

function RendererCommand:initInteractionStart(modelID, functionType)
    self.type = CommandType.RENDERER_NPC_INTERACTION_START
    self.modelID = modelID

    self.functionType = functionType
end

function RendererCommand:initInteractionEnd(modelID)
    self.type = CommandType.RENDERER_NPC_INTERACTION_END
    self.modelID = modelID
end

function RendererCommand:initHeroLooks(modelID, looks)
    self.type = CommandType.RENDERER_HERO_LOOKS

    self.modelID = modelID
    self.looks = looks
end

-- 变形效果显示
function RendererCommand:initItemDeformationShow(modelID, deformationData)
    self.type = CommandType.RENDERER_ITEM_DEFORMATION_SHOW

    self.modelID = modelID
    self.deformationData = deformationData
end

-- 变形效果移除
function RendererCommand:initItemDeformationRemove(modelID)
    self.type = CommandType.RENDERER_ITEM_DEFORMATION_REMOVE

    self.modelID = modelID
end

-- 快捷表情
function RendererCommand:initExpressionCommand(modelID, spineAction, direction)
    self.type = CommandType.RENDERER_HERO_EXPRESSION
    self.modelID = modelID
    self.spineAction = spineAction
    self.direction = direction
end

-- 显示变身动画
function RendererCommand:initBossShowTransfor(modelID)
    self.type = CommandType.RENDERER_BOSS_SHOW_TRANSFOR

    self.modelID = modelID
end

-- 显示变身恢复动画
function RendererCommand:initBossShowTransforRecover(modelID)
    self.type = CommandType.RENDERER_BOSS_SHOW_TRANSFOR_RECOVER
    
    self.modelID = modelID
end

-- boss 状态切换
function RendererCommand:initBossStatusChange(modelID)
    self.type = CommandType.RENDERER_BOSS_STATUS_CHANGE
    
    self.modelID = modelID
end

-- 冻结
function RendererCommand:initRoleConstraint(modelID)
    self.type = CommandType.RENDERER_ROLE_CONSTRAINT
    
    self.modelID = modelID
end

-- 从冻结中恢复
function RendererCommand:initRoleConstraintRecover(modelID)
    self.type = CommandType.RENDERER_ROLE_CONSTRAINT_RECOVER
    self.modelID = modelID
end  

-- 冻结
function RendererCommand:initRoleFrozen(modelID)
    self.type = CommandType.RENDERER_ROLE_FROZEN
    
    self.modelID = modelID
end

-- 从冻结中恢复
function RendererCommand:initRoleFrozenRecover(modelID)
    self.type = CommandType.RENDERER_ROLE_FROZEN_RECOVER
    
    self.modelID = modelID
end  

--新邮件提示
function RendererCommand:initMailNewFlag(modelID, isRemove)
    self.type = CommandType.RENDERER_NPC_NEW_MAIL
    self.modelID = modelID
    self.isRemove = isRemove
end

--新邮件提示
function RendererCommand:playDreamNpcOpenAct(modelID)
    self.type = CommandType.RENDERER_DREAM_NPC_OPEN
    self.modelID = modelID
end

-- 状态显示
function RendererCommand:initRoleStatusShow(modelID, statusID, animationName, mountName)
    self.type = CommandType.RENDERER_ROLE_STATUS_SHOW
    self.modelID = modelID
    self.statusID = statusID
    self.animationName = animationName
    self.mountName = mountName
end

-- 状态效果完成
function RendererCommand:initRoleStatusEnd(modelID, statusID)
    self.type = CommandType.RENDERER_ROLE_STATUS_END
    self.modelID = modelID

    self.statusID = statusID
end

-- 修改是否显示头盔
function RendererCommand:initRoleIsHideHelmet(modelID, isHideHelmet)
    self.type = CommandType.RENDERER_ROLE_IS_HIDE_HELMET
    self.modelID = modelID

    self.isHideHelmet = isHideHelmet
end

-- 活动吆喝表现
function RendererCommand:initActivityCrying(modelID, crying)
    self.type = CommandType.RENDERER_NPC_ACTIVITY_CRYING

    self.modelID = modelID
    self.crying = crying
end

-- 技能传送完成
function RendererCommand:initAssistTransferEnd(modelID)
    self.type = CommandType.RENDERER_ASSIST_SKILL_TRANSFER_END

    self.modelID = modelID
end

-- 辅助技能使用失败
function RendererCommand:initAssistUseFail(modelID)
    self.type = CommandType.RENDERER_ASSIST_SKILL_USE_FAIL

    self.modelID = modelID
end   

-- 初始化攻击抖动
function RendererCommand:initRoleHitShack(modelID)
    self.type = CommandType.RENDERER_ROLE_HIT_SHACK

    self.modelID = modelID
end

-- 初始技能进阶
function RendererCommand:initSkillAdvanced(modelID)
    self.type = CommandType.RENDERER_SKILL_ADVANCED

    self.modelID = modelID
end

-- 初始化角色缩放
function RendererCommand:initRoleScale(modelID, scale)
    self.type = CommandType.RENDERER_ROLE_SCALE

    self.modelID = modelID
    self.scale = scale
end

function RendererCommand:initDreamWinding(modelID, isAdd)
    self.type = CommandType.RENDERER_DREAM_WINDING

    self.modelID = modelID
    self.isAdd = isAdd
end

function RendererCommand:initDreamRankProjection(modelID)
    self.type = CommandType.RENDERER_DREAM_RANK_PROJECTION

    self.modelID = modelID
end

function RendererCommand:initHorcruxExterior(modelID, horcruxExteriorID)
    self.type = CommandType.RENDERER_HORCRUX_EXTERIOR

    self.modelID = modelID
    self.horcruxExteriorID = horcruxExteriorID
end

function RendererCommand:initExpeditionUpdate(modelID, expeditionStatus)
    self.type = CommandType.RENDERER_EXPEDITION_UPDATE

    self.modelID = modelID
    self.expeditionStatus = expeditionStatus
end

function RendererCommand:initGuildBossStatusUpdate(modelID, guildBossData)
    self.type = CommandType.RENDERER_GUILD_BOSS_STATUS_UPDATE

    self.modelID = modelID
    self.guildBossData = guildBossData
end

function RendererCommand:initBossSealInfoUpdate(modelID)
    self.type = CommandType.RENDERER_BOSS_SEAL_INFO_UPDATE
    self.modelID = modelID
end

--[[
    animationNames : {{"动画名字",是否循环}} eg:{{"idle", false}}
]]
function RendererCommand:initRoleRunAnimations(modelID, animationNames)
    self.type = CommandType.RENDERER_ROLE_RUN_ANIMATIONS
    self.modelID = modelID
    
    self.animationNames = animationNames
end

-- 初始化迷阵标记处理
function RendererCommand:initMazePoint(modelID, data)
    self.type = CommandType.RENDERER_MAZE_POINT

    self.modelID = modelID
    self.data = data
end

-- 处理通用的表现
function RendererCommand:initForTypeAndData(type, modelID, data)
    self.type = type
    self.modelID = modelID
    
    self.data = data
end