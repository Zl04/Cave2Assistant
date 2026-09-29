-- 地图
local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")

local TRIGGER_TYPE = GameTriggerType
local TRACKS_INDEX = GameTracksIndex
local SPRITE_STATUS = PublicDefine.SPRITE_STATUS
local SCREEN_TYPE = GameScreenType

local Machine = Town.Machine

function Machine:onExecuteControlCommand(command)
     local commandType = command.type
    -- 加载场景 
    if (commandType == CommandType.CONTROL_LOADSCENCE) then

        self:_controlLoadScene(command.data)
    -- 处理已探索视区数据
    elseif commandType == CommandType.CONTROL_EXPLOREDVIEWAREA then
        local data = command.data

        self._model:updateMapDataWithExploredViewAreaData(command.data)
    -- 转变为可到达的地图块
    elseif commandType == CommandType.CONTROL_TRANSFORMEDGROUND then
        local data = command.data
        -- if DEBUG then
        --     for i, v in ipairs(data.viewAreaValue) do
        --         print (string.format("TownMachine:onExecuteControlCommand CONTROL_TRANSFORMEDGROUND viewAreaValue index:%d value:%d", i, v))
        --     end
        -- end
        self._model:updateMapDataWithTransformedGround(command.data)
    -- 进入场景
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:_controlEnterScene()
    -- 同屏英雄
    elseif (commandType == CommandType.CONTROL_SCREENHERO) then
        self:_controlScreenHero(command.data)
    -- 同屏宠物
    elseif (commandType == CommandType.CONTROL_SCREENPET) then
        self:_controlScreenPet(command.data)
    -- 全局触发NPC
    elseif (commandType == CommandType.CONTROL_GLOBAL_TRIGGERNPC) then

        self:_controlGlobalTriggerNPC(command.data)
    -- 同屏触发NPC  
    elseif (commandType == CommandType.CONTROL_SCREEN_TRIGGERNPC) then

        self:_controlScreenTriggerNPC(command.data)
    -- 角色属性改变
    elseif (commandType == CommandType.CONTROL_ROLE_ATTR_CHANGE) then
        local data = command.data
        -- if DEBUG_ATTR then
        --     print("TownMachine:onExecuteControlCommand  CONTROL_ROLE_ATTR_CHANGE spriteID, timeStamp=",data.spriteID,AvalonUtil.getCurrentTime())
        --     for k,v in pairs(data) do
        --         print("TownMachine:onExecuteControlCommand  CONTROL_ROLE_ATTR_CHANGE k,v=",k,v)
        --     end
        -- end

        self:_controlRoleAttrChange(command.data)
    -- 移除同屏角色
    elseif (commandType == CommandType.CONTROL_REMOVESCREENROLE) then
        -- if DEBUG then
        --     print("TownMachine:onExecuteControlCommand  CONTROL_REMOVESCREENROLE spriteID,roleType=",command.data.spriteID,command.data.roleType)
        -- end
        self:_controlRemoveScreenRole(command.data)
    elseif (commandType == CommandType.CONTROL_REMOVEALLOTHERSCREENROLE) then
        self:_controlRemoveAllOtherScreenRole(command.data)
    -- 通知英雄开始移动
    elseif (commandType == CommandType.CONTROL_NOTIFY_HERO_START_MOVE) then

        self:_controlNotifyHeroStartMove(command.data)
    -- 通知英雄停止移动
    elseif (commandType == CommandType.CONTROL_NOTIFY_HERO_STOP_MOVE) then

        self:_controlNotifyHeroStopMove(command.data)
    -- 英雄位置同步
    elseif (commandType == CommandType.CONTROL_HERO_POSITION_SYNC) then

        self:_controlHeroPositionSync(command.data)
    -- 技能开始冷却
    elseif (commandType == CommandType.CONTROL_NOTIFY_ROLE_SKILL_START_EFFECT) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SKILL_START_COOLDOWN,command.data.skillID)
    -- 技能冷却
    elseif (commandType == CommandType.CONTROL_NOTIFY_ROLE_SKILL_COOLDOWN) then
        local data = command.data
        
        -- 通知技能UI冷却
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN,data.skillID, data.residualTime)
        -- 添加buffer效果
    elseif (commandType == CommandType.CONTROL_ADD_BUFFER) then
        -- print(string.format("TownMachine add buffer: buffer id: %d, entity id: %d.", command.data.buffID, command.data.entityID))
        
        self:_controlAddBuff(command.data, command.isRecover)
    elseif (commandType == CommandType.CONTROL_REMAIN_BUFF) then
        self:_controlRemainBufferByInstID(command.data)
    -- 移除buffer效果
    elseif (commandType == CommandType.CONTROL_REMOVE_BUFFER) then
        -- print(string.format("TownMachine remove buffer: target id: %d, entity id: %d.", command.data.targetSpriteID, command.data.entityID))

        self:_controlRemoveBuffer(command.data)
    -- 添加effect
    elseif (commandType == CommandType.CONTROL_ADD_EFFECT) then
        -- print(string.format("TownMachine add effect: effect id: %d, target sprite id: %d.", command.data.effectID, command.data.targetSpriteID))

        self:_controlAddEffect(command.data)
    -- 穿戴装备切换
    elseif (commandType == CommandType.CONTROL_WEAR_EQUIPMENT_CHANEG) then
        -- 穿戴装备改变
        self:_controlWearEquipmentChange(command.data)
    -- 皮肤和面部
    elseif (commandType == CommandType.CONTROL_SKIN_AND_FACE_CHANEG) then
        -- 皮肤和面部修改
        self:_controlSkinAndFaceChange(command.data)
        -- 获取物品
    elseif (commandType == CommandType.CONTROL_ACHIEVE_GOODS) then
        -- self:_handleAchieveGoods(command.data)

        -- 角色升级
    elseif (commandType == CommandType.CONTROL_ROLE_LEVEL_UP) then
        self:_controlRoleLevelUp(command.data)

    -- 处理任务刷新
    elseif (commandType == CommandType.CONTROL_NPC_TASK_REFRESH) then
        self:_controlTaskRefresh(command.data)
    -- 设置引导箭头
    elseif (commandType == CommandType.CONTROL_SET_GUIDE_POINTER) then
        self:_controlSetGuidePointer(command.data)
    -- 处理显示角色昵称
    elseif (commandType == CommandType.CONTROL_EDIT_NICK_NAME) then
        self:_controlEditNickName(command.data)
    -- 同屏脸型改变
    elseif (commandType == CommandType.CONTROL_SCREEN_FACE_CHANGE) then     
        self:_controlScreenFaceChange(command.data)
    -- 角色站立
    elseif (commandType == CommandType.CONTROL_MASTER_IDLE) then
        self:hideTownTransDoorTrigger()
        self:_controlMasterIdle()
    elseif (commandType == CommandType.CONTORL_END_TRANS_SCENE) then
        self:_controlEndTransScene(command.data)
    elseif (commandType == CommandType.CONTORL_UNLOCK_FUNCTION) then
        self:_controlAddUnlockFuncEvent(command.data)
    elseif (commandType == CommandType.CONTORL_FINISH_ACHIEVEMENT) then
        self:_controlFinishAchEvent(command.data)
    elseif (commandType == CommandType.CONTORL_CHECK_POINT) then
        
    elseif (commandType == CommandType.CONTROL_NPC_CATFOOD) then

        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_CATFOOD, command.data)
    elseif (commandType == CommandType.IAP_ON_PURCHASERESULT) then
        local awards = command.data
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, awards.goods, handler(self, function()
            Avalon.MessageCenter:notice(AvalonMessage.MC_ON_TIPS_CLOSE_BUTTON ,awards)  
        end))
    elseif (commandType == CommandType.CONTROL_WAITING_BEGIN_SYNC) then
        
    elseif (commandType == CommandType.CONTROL_REFRESH_BUFF_FOR_INST_ID) then  
        -- print("CONTROL_REFRESH_BUFF_FOR_INST_ID =", command.data)
        self:_controlRefreshBufferByInstID(command.data)
    elseif (commandType == CommandType.CONTROL_REFRESH_BUFFER_BY_KIND) then

        self:_controlRefreshBufferByKind(command.data)
    elseif (commandType == CommandType.CONTROL_REFRESH_BUFFER_BY_EFFECT) then 
        self:_controlRefreshBufferByEffect(command.data)
    elseif (commandType == CommandType.CONTROL_SKILL_ADVANCED) then 
        self:_controlSkillAdvanced(command.data)
    elseif (commandType == CommandType.CONTROL_SHOW_MATCH_TEAM) then 
        self:_controlShowTeamReady(command.data)
    elseif (commandType == CommandType.CONTROL_SHOW_TEAM_CONFIRE) then
        self:_controlShowTeamConfire(command.data)
    elseif (commandType == CommandType.CONTROL_OPEN_UILAYER) then
        Avalon.MessageCenter:notice(command.data, 0)
    elseif (commandType == CommandType.CONTROL_REFRESH_ALL_GUILD_BOSS) then 
        self:_controlGuildBossRereshAll()
    elseif (commandType == CommandType.CONTROL_REFRESH_GUILD_BOSS_STATUS) then 
        self:_controlGuildBossStatusChange()
    elseif (commandType == CommandType.CONTROL_MAZE_POINT) then 
        self:_controlMazePoint(command.data)
    elseif (commandType == CommandType.CONTROL_MAZE_FUN_EXPLORE) then 
        self:_controlMazeFunExplore(command.data)
    -- 使用道具失败
    elseif (commandType == CommandType.CONTROL_USE_ITEM_FAILED) then
        -- 处理使用道具失败
        self:_controlUseItemFailed(command.data)
    elseif (commandType == CommandType.CONTROL_QUICK_DOWN) then 
        self:_controlQuickDown(command.data)
    elseif (commandType == CommandType.CONTROL_SCREENMONSTER) then
        self:_controlScreenMonster(command.data)
    elseif (commandType == CommandType.CONTROL_END_PET_PVP) then
        self:_refreshPatrolNpc()
    else
        print(string.format("[ERROR] TownMachine onExecuteControlCommand: command type %d is invalid.", commandType))
    end

    return true
end