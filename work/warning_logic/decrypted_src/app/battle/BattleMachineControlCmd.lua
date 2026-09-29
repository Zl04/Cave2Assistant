
-- 地图
-- local MapDefine = require "app.mapkit.MapDefine"
-- local MapDataManager = require "app.mapkit.model.MapDataManager"
-- local GameDataManager = require("app.game.GameDataManager")
-- local MachineManager = require("app.game.MachineManager")
-- local ProtobufUtil = require "utils.ProtobufUtil"
local GameMapManager = require("app.game.GameMapManager")
-- local SceneManager = require("app.game.SceneManager")

-- local TRIGGER_TYPE = GameTriggerType
-- local TRACKS_INDEX = GameTracksIndex
-- local SPRITE_STATUS = PublicDefine.SPRITE_STATUS
-- local SCREEN_TYPE = GameScreenType

local Machine = Battle.Machine

local DEBUG = false

-- 处理执行控制命令
function Machine:onExecuteControlCommand(command)
    local commandType = command.type
    -- print(string.format("Machine:onExecuteControlCommand  commandType=%d",commandType))
    -- 加载场景 
    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        if DEBUG then
            for k,v in pairs(command.data) do
                print(" Machine:onExecuteControlCommand  k=",k," v=",v)
            end
        end

        self:_controlCheckPoint(command.data)
        self:_controlLoadScene(command.data)
    -- 处理已探索视区数据
    elseif commandType == CommandType.CONTROL_EXPLOREDVIEWAREA then
        if DEBUG then
            local data = command.data
            for i, v in ipairs(data.viewAreaValue) do
                print (string.format("Machie:onExecuteControlCommand CONTROL_EXPLOREDVIEWAREA viewAreaValue index:%d value:%d", i, v))
            end
        end

        self._model:updateMapDataWithExploredViewAreaData(command.data)
    -- 转变为可到达的地图块
    elseif commandType == CommandType.CONTROL_TRANSFORMEDGROUND then
        if DEBUG then
            local data = command.data
            for i, v in ipairs(data.viewAreaValue) do
                print (string.format("Machie:onExecuteControlCommand CONTROL_TRANSFORMEDGROUND viewAreaValue index:%d value:%d", i, v))
            end
        end
        self._model:updateMapDataWithTransformedGround(command.data)
    -- 进入场景
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:_controlEnterScene()
    -- 同屏英雄
    elseif (commandType == CommandType.CONTROL_SCREENHERO) then
        if DEBUG then
            local data = command.data
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_SCREENHERO k,v=",k,v)
            end
        end

        self:_controlScreenHero(command.data)
       -- 同屏宠物
    elseif (commandType == CommandType.CONTROL_SCREENPET) then
        self:_controlScreenPet(command.data)
    -- 设置引导箭头
    elseif (commandType == CommandType.CONTROL_SET_GUIDE_POINTER) then
        self:_controlSetGuidePointer(command.data)
    -- 处理显示角色昵称
    elseif (commandType == CommandType.CONTROL_EDIT_NICK_NAME) then
        -- local heroData = command.data
        -- if(heroData) then
        --     local role = self._model:getRoleBySpriteID(heroData:getSpriteID())
        --     if(role) then
        --         local nameCommand = Command.RendererCommand:create(true)
        --         nameCommand:initRoleName(role:getId(), role:getName(), true, role:isMaster())
        --         self._battleMachine:pushCommand(nameCommand)
        --     end
        -- end
        self:_controlEditNickName(command.data)
    -- 全局怪物
    elseif (commandType == CommandType.CONTROL_GLOBALMONSTER) then

        self:_controlGlobalMonster(command.data)
    -- 同屏怪物
    elseif (commandType == CommandType.CONTROL_SCREENMONSTER) then

        self:_controlScreenMonster(command.data)
    -- 同屏小狐仙变身
    elseif (commandType == CommandType.CONTROL_SCREEN_PET_TRANSTORM) then
        self:_controlScreenPetTransform(command.data)
    -- 全局触发NPC
    elseif (commandType == CommandType.CONTROL_GLOBAL_TRIGGERNPC) then

        self:_controlGlobalTriggerNPC(command.data)
    -- 同屏触发NPC  
    elseif (commandType == CommandType.CONTROL_SCREEN_TRIGGERNPC) then

        self:_controlScreenTriggerNPC(command.data)
    -- 怪物详情
    elseif (commandType == CommandType.CONTROL_MONSTER_DETAIL) then
        local monsterData = RoleDataManager:handleMonsterData(command.data, GameMapManager:getInstance():getModel(), GameMapManager:getInstance():getDifficulty())

        local monster = self._model:addOrUpdateRole(Category.ROLE, RoleType.Monster, monsterData)
        if (monster) then
            -- 这里通知页面修改
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_MONSTER_DATA, monster:getData())
        end
    -- 角色属性改变
    elseif (commandType == CommandType.CONTROL_ROLE_ATTR_CHANGE) then
        if DEBUG_ATTR then
            local data = command.data
            print("Machine:onExecuteControlCommand  CONTROL_ROLE_ATTR_CHANGE spriteID, timeStamp=",data.spriteID,AvalonUtil.getCurrentTime())
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_ROLE_ATTR_CHANGE k,v=",k,v)
            end
        end

        self:_controlRoleAttrChange(command.data)
    -- 移除同屏角色
    elseif (commandType == CommandType.CONTROL_REMOVESCREENROLE) then
        if DEBUG then
            print("Machine:onExecuteControlCommand  CONTROL_REMOVESCREENROLE spriteID,roleType=",command.data.spriteID,command.data.roleType)
        end
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
        local data = command.data
        if DEBUG then   
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_HERO_POSITION_SYNC k,v=",k,v)
            end
        end

        self:_controlHeroPositionSync(command.data)
    elseif (commandType == CommandType.CONTROL_HERO_START_BATTLE_RESULT) then

        self:_controlHeroStartBattleResult(command.data)
    elseif (commandType == CommandType.CONTROL_HERO_SWITCH_BATTLE_RESULT) then

        self:_controlHeroSwitchBattleResult(command.data)
    elseif (commandType == CommandType.CONTROL_SCREEN_HERO_START_BATTLE) then

        self:_controlScreenHeroStartBattle(command.data)
    elseif (commandType == CommandType.CONTROL_NOTIFY_START_USE_SKILL) then

        self:_controlNotifyStartUseSkill(command.data)
    -- 处理角色技能MISS
    elseif (commandType == CommandType.CONTROL_ROLE_SKILL_MISS) then

        self:_controlRoleSkillMiss(command.data)
    -- 通知英雄开始战斗
    elseif (commandType == CommandType.CONTROL_NOTIFY_ROLE_SKILL_STATUS) then
        local data = command.data
       
        if DEBUG then
            print(string.format("BattleMachine onExecuteControlCommand: player %d change skill %d status %d, attack target %d.", data.spriteID, data.skillID, data.skillState, data.targetSpriteID),GameManager:getNowServerTimestamp())
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_NOTIFY_ROLE_SKILL_STATUS k,v=",k,v)
            end
        end

        self:_controlNofifyRoleSkillStatus(command.data)
    -- 技能中断
    elseif (commandType == CommandType.CONTROL_NOTIFY_ROLE_SKILL_BREAK) then
        local data = command.data
        if DEBUG then
            print(string.format("BattleMachine onExecuteControlCommand: player %d break skill %d.", data.spriteID, data.skillID))
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_NOTIFY_ROLE_SKILL_BREAK k,v=",k,v)
            end
        end
        
        self:_controlNotifyRoleSkillBreak(command.data)
    elseif (commandType == CommandType.CONTROL_SKILL_USE_RESULT) then
        local data = command.data
        if DEBUG then
            print(string.format("BattleMachine CONTROL_SKILL_USE_RESULT: player %d break skill %d.", data.spriteID, data.skillID))
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_SKILL_USE_RESULT k,v=",k,v)
            end
        end

        self:_controlNotifyRoleSkillResult(command.data)    
    -- 技能开始冷却
    elseif (commandType == CommandType.CONTROL_NOTIFY_ROLE_SKILL_START_EFFECT) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SKILL_START_COOLDOWN,command.data.skillID, command.data.isOpen, command.data.spriteID)
    -- 技能冷却
    elseif (commandType == CommandType.CONTROL_NOTIFY_ROLE_SKILL_COOLDOWN) then
        local data = command.data
        -- if DEBUG then
        --     for k,v in pairs(data) do
        --         print("Machine:onExecuteControlCommand  CONTROL_NOTIFY_ROLE_SKILL_COOLDOWN k,v=",k,v)
        --     end
        -- end
        -- 通知技能UI冷却
        local ProtobufUtil = require "utils.ProtobufUtil"
        if ProtobufUtil:checkFieldIsInit(data, "spriteID") then
            local petSkillPanl = UI.UIManager.mMainUILayer._petSkillPanl
            if not petSkillPanl or tolua.isnull(petSkillPanl) then
                SkillDataManager:setPetEnterFightSkillCoolDownList(data.skillID, data.residualTime)
            end
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN,data.skillID, data.residualTime, data.spriteID)
        else
            -- CO-18933 技能配置进战CD，冷却不显示
            local skillPanl = UI.UIManager.mMainUILayer._skillPanl
            if not skillPanl or tolua.isnull(skillPanl) then
                SkillDataManager:setEnterFightSkillCoolDownList(data.skillID, data.residualTime)
            end
            ---------------------------
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN,data.skillID, data.residualTime)
        end
    -- 技能呤唱
    elseif (commandType == CommandType.CONTROL_NOTIFY_ROLE_SKILL_ACCUMULATE) then

        self:_controlNotifyRoleSkillAccumulate(command.data)
    -- 添加buffer效果
    elseif (commandType == CommandType.CONTROL_ADD_BUFFER) then
        -- print(string.format("BattleMachine add buffer: buffer id: %d, entity id: %d.", command.data.buffID, command.data.entityID))
        local data = command.data   
        if DEBUG then
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_ADD_BUFFER k,v=",k,v)
            end
        end

        self:_controlAddBuff(command.data, command.isRecover)
    elseif (commandType == CommandType.CONTROL_REMAIN_BUFF) then
        self:_controlRemainBufferByInstID(command.data)
    -- 移除buffer效果
    elseif (commandType == CommandType.CONTROL_REMOVE_BUFFER) then
        if(DEBUG) then
            print(string.format("BattleMachine remove buffer: target id: %d, entity id: %d.", command.data.targetSpriteID, command.data.entityID))
        end

        local data = command.data
        if DEBUG then
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_REMOVE_BUFFER k,v=",k,v)
            end
        end

        self:_controlRemoveBuffer(command.data)
    -- 添加effect
    elseif (commandType == CommandType.CONTROL_ADD_EFFECT) then
        if(DEBUG) then
            print(string.format("BattleMachine add effect: effect id: %d, target sprite id: %d.", command.data.effectID, command.data.targetSpriteID))
        end

        local data = command.data
        if DEBUG then
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_ADD_EFFECT k,v=",k,v)
            end
        end

        self:_controlAddEffect(command.data)
    elseif (commandType == CommandType.CONTROL_REFRESH_BUFFER_BY_KIND) then 
        if(DEBUG) then
            print(string.format("BattleMachine CONTROL_REFRESH_BUFFER_BY_KIND: buffType: %d, target sprite id: %d.", command.data.buffType, command.data.spriteID))
        end

        self:_controlRefreshBufferByKind(command.data)
    elseif (commandType == CommandType.CONTROL_REFRESH_BUFFER_BY_EFFECT) then 
        self:_controlRefreshBufferByEffect(command.data)
    elseif (commandType == CommandType.CONTROL_REFRESH_BUFF_FOR_INST_ID) then  

        self:_controlRefreshBufferByInstID(command.data)
    elseif (commandType == CommandType.CONTROL_REMOVE_AFFIX_FOR_ALL_MONSTER) then  

        self:_controlRemoveAffixFromAllMonster(command.data)
    elseif (commandType == CommandType.CONTROL_REFRESH_ALL_SKILL_CD) then 
        if(DEBUG) then
            print(string.format("BattleMachine CONTROL_REFRESH_ALL_SKILL_CD "))
        end

        self:_controlRefreshAllSkillCD(command.data)
    elseif (commandType == CommandType.CONTROL_REMOVE_ALL_FX) then
        -- 移除所有得buff 效果

        self:_controlRemoveAllFX(command.data)
    elseif (commandType == CommandType.CONTROL_HERO_ESCAPE_FAILED) then
        -- 处理玩家逃跑失败
        self:_controlEscapeFailed(command.data)
    elseif (commandType == CommandType.CONTROL_NOTIFY_HERO_ESCAPE) then
        -- 处理英雄逃跑
        local data = command.data
        if DEBUG then
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_NOTIFY_HERO_ESCAPE k,v=",k,v)
            end
        end

        self:_controlNotifyHeroEscape(command.data)
    elseif (commandType == CommandType.CONTORL_NOTIFY_HERO_CANCEL_ESCAPE) then
        self:_controlNotifyHeroCancelEscape(command.data)
    elseif (commandType == CommandType.CONTROL_ROLE_LEAVE_BATTLE) then
        local data = command.data
        -- 处理角色离开战斗
        if DEBUG then
            if data then
                for k,v in pairs(data) do
                    print("Machine:onExecuteControlCommand  CONTROL_ROLE_LEAVE_BATTLE k,v=",k,v)
                end
            else
                print("Machine:onExecuteControlCommand  CONTROL_ROLE_LEAVE_BATTLE  data is nil.")
            end
        end

        self:_controlRoleLeaveBattle(command.data)        
    elseif (commandType == CommandType.CONTROL_ROLE_DIE) then
        local data = command.data
        -- 处理角色死亡
        if DEBUG then
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_ROLE_DIE k,v=",k,v)
            end
        end

        self:_controlRoleDie(command.data)
    -- NPC 打开
    elseif (commandType == CommandType.CONTROL_NPC_OPEN) then
        local data = command.data
        if DEBUG then
            print("Machine:onExecuteControlCommand  CONTROL_NPC_OPEN spriteID=",data.spriteID)
        end
        self:_controlNpcOpen(command.data)
    elseif (commandType == CommandType.CONTROL_TRIGGER_NPC_FAILS) then
        self:_controlTriggerNpcFailed(command.data)
    -- 获取物品
    elseif (commandType == CommandType.CONTROL_ACHIEVE_GOODS) then

        self:_handleAchieveGoods(command.data)
    -- 穿戴装备切换
    elseif (commandType == CommandType.CONTROL_WEAR_EQUIPMENT_CHANEG) then
        -- 穿戴装备改变
        self:_controlWearEquipmentChange(command.data)
    -- 皮肤和面部
    elseif (commandType == CommandType.CONTROL_SKIN_AND_FACE_CHANEG) then
        -- 皮肤和面部修改
        self:_controlSkinAndFaceChange(command.data)
    -- 挖墙后的地图改变
    elseif (commandType == CommandType.CONTROL_DIG_WALL) then
        self:_controlDigWall(command.data)
    -- 处理技能瞬移操作
    elseif (commandType == CommandType.CONTROL_HERO_TRANSFER) then
        self:_controlHeroTransfer(command.data)
    -- 处理复活
    elseif (commandType == CommandType.CONTROL_ROLE_REVIVE) then
        self:_controlRevive(command.data)
    -- 处理群怪复活
    elseif (commandType == CommandType.CONTROL_GROUP_MONSTER_REVIVE) then
        self:_controlGroupMonsterRevive(command.data)
    -- 处理复活返回值
    elseif (commandType == CommandType.CONTROL_REVIVE_RESPONSE) then
        self:_controlReviveResponse(command.data)
    -- 处理复活完成
    elseif (commandType == CommandType.CONTROL_REVIVE_COMPLETE) then
        self:_controlReviveComplete(command.data)
    elseif (commandType == CommandType.CONTROL_ROLE_BACK_TOWN) then
        self:_controlBackTown()
    -- 角色升级
    elseif (commandType == CommandType.CONTROL_ROLE_LEVEL_UP) then
        self:_controlRoleLevelUp(command.data)
    -- 密室打开
    elseif (commandType == CommandType.CONTROL_CHAMBER_OPEN) then
        if DEBUG then
            local data = command.data
            print("Machine:onExecuteControlCommand  CONTROL_CHAMBER_OPEN spriteID=",data.chamberID)
            for k,v in pairs(data) do
                print("Machine:onExecuteControlCommand  CONTROL_CHAMBER_OPEN  k,v=",k,v)
            end
        end

       self:_controlChamberOpen(command.data)
    -- 触发NPC 解锁
    elseif (commandType == CommandType.CONTROL_TRIGGER_NPC_UNLOCK) then

        self:_controlTriggerNpcUnlock(command.data)
    -- 机关密室门解锁
    elseif (commandType == CommandType.CONTROL_CHAMBER_ENTRANCE_UNLOCK) then
        -- 触发机关密室门解锁震动和营销
        self:_controlChamberEntranceUnlock(command.data)
    elseif (commandType == CommandType.CONTROL_NPC_GOLD_TOUCHED_REFRESH) then

        self:_controlGoldTouchedRefresh(command.data)
    -- 处理任务刷新
    elseif (commandType == CommandType.CONTROL_NPC_TASK_REFRESH) then

        self:_controlTaskRefresh(command.data)
    -- 触发陷阱效果 
    elseif (commandType == CommandType.CONTROL_NPC_TRAP_EFFECT) then

        self:_controlNpcTrapEffect(command.data)
    -- 处理开始使用物品
    elseif (commandType == CommandType.CONTROL_ROLE_BEGIN_USE_ITEM) then
        -- 处理开始使用道具
        self:_controlBeginUseItem(command.data)
    -- 使用道具失败
    elseif (commandType == CommandType.CONTROL_USE_ITEM_FAILED) then
        -- 处理使用道具失败
        self:_controlUseItemFailed(command.data)
    -- 处理开始BOSS剧情
    elseif (commandType == CommandType.CONTROL_BOSS_BEGIN_SCENARIO) then

        self:_controlBossBeginScenario(command.data)
    -- 处理结束BOSS剧情
    elseif (commandType == CommandType.CONTROL_BOSS_END_SCENARIO) then     

        self:_controlBossEndScenario(command.data)
    -- 同屏脸型改变
    elseif (commandType == CommandType.CONTROL_SCREEN_FACE_CHANGE) then  

        self:_controlScreenFaceChange(command.data)
    elseif (commandType == CommandType.CONTROL_TRIGGER_MONSTER) then

        self:_triggerMonster(command.data)
    -- 处理显示小地图图标
    elseif (commandType == CommandType.CONTROL_SHOW_MINI_MAP_ICON) then

        self:_showMiniMapIcon(command.data)
    -- 地图全开
    elseif (commandType == CommandType.CONTROL_ROLE_I_SEE_DEAD_PEOPLE) then

        self:_showISeeDeadPeople()
    -- 角色站立
    elseif (commandType == CommandType.CONTROL_MASTER_IDLE) then

        self:hideTownTransDoorTrigger()
        self:_controlMasterIdle()
    -- 陷阱移除
    elseif (commandType == CommandType.CONTORL_TRAP_REMOVE) then

        self:_controlTrapRemove(command.data)
    elseif (commandType == CommandType.CONTORL_END_TRANS_SCENE) then
        self:_controlEndTransScene(command.data)
    elseif (commandType == CommandType.CONTORL_UNLOCK_FUNCTION) then
        self:_controlAddUnlockFuncEvent(command.data)
    elseif (commandType == CommandType.CONTORL_FINISH_ACHIEVEMENT) then
        self:_controlFinishAchEvent(command.data)
    elseif (commandType == CommandType.CONTORL_CHECK_POINT) then
    elseif (commandType == CommandType.IAP_ON_PURCHASERESULT) then
        local awards = command.data
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awards.goods, handler(self, function()
            Avalon.MessageCenter:notice(AvalonMessage.MC_ON_TIPS_CLOSE_BUTTON ,awards)  
        end))
    elseif (commandType == CommandType.CONTROL_WAITING_BEGIN_SYNC) then
        
    elseif (commandType == CommandType.CONTROL_DUNGEON_UNLOCK_TRANSDOOR) then
        self:_controlDungeonUnlockTransdoor(command.data)
    elseif (commandType == CommandType.CONTROL_SKILL_ADVANCED) then 
        self:_controlSkillAdvanced(command.data)
    elseif (commandType == CommandType.CONTROL_REFRESH_ALL_GUILD_BOSS) then 
        self:_controlGuildBossRereshAll()
    elseif (commandType == CommandType.CONTROL_REFRESH_GUILD_BOSS_STATUS) then 
        self:_controlGuildBossStatusChange()
    elseif (commandType == CommandType.CONTROL_MAZE_POINT) then 
        self:_controlMazePoint(command.data)
    elseif (commandType == CommandType.CONTROL_MAZE_FUN_EXPLORE) then 
        self:_controlMazeFunExplore(command.data)
    elseif (commandType == CommandType.CONTROL_QUICK_DOWN) then 
        self:_controlQuickDown(command.data)
    elseif (commandType == CommandType.CONTROL_SCENE_PAUSEORRESUME_STATUS) then
        self:_controlScenePauseOrResume(command.data)
    elseif (commandType == CommandType.CONTROL_ROLE_ANIMATIONS_BY_SPRITEID) then
        self:_controlRoleRunAnimation(command.data)
    elseif (commandType == CommandType.CONTROL_PLAY_LOSTREALM_MOVE) then
        self:_controlLostRealmRun(command.data)
    elseif (commandType == CommandType.CONTROL_GHOSTABYSS_NOTIFY) then
        self:_controlGhostAbyss(command.data)
    elseif (commandType == CommandType.CONTROL_SUMMONED_BOSS_CHANGE_PANNEL) then
        self:_controlChangeSummonedBossState(command.data)
    else
        print(string.format("[ERROR] Battle machine onExecuteControlCommand: command type %d is invalid.", commandType))
    end

    return true
end
