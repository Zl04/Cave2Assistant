
local Machine = Battle.Machine

local DEBUG = false

-- 处理执行战斗命令
function Machine:onExecuteBattleCommand(command)
    local commandType = command.type
    -- 开始战斗
    if (commandType == CommandType.BATTLE_START_BATTLE) then

        self:_handleStartBattle(command.data)
    elseif (commandType == CommandType.BATTLE_USE_SKILL) then

        -- 过滤掉非战斗状态使用
        self:_battleUseSkill(command.data)
    elseif (commandType == CommandType.BATTLE_ESCAPE) then

        self:_battleEscape()
    -- 处理战斗站位
    elseif (commandType == CommandType.BATTLE_HANDLE_STATION) then

        self:_battleHandleStation(command.data)
    -- 移除模型
    elseif (commandType == CommandType.BATTLE_REMOVE_MODEL) then

        self:_battleRemoveModel(command.modelID,command.cleanView)
    elseif (commandType == CommandType.BATTLE_OPEN_TRIGGER_NPC) then

        -- self._view:shack()
        self:_battleOpenTriggerNpc(command.spriteID, command.isMiniMap)

        -- self:testBlind()
        -- self:testLevelUp()
        -- self:testFont()
    elseif (commandType == CommandType.BATTLE_NPC_OPEN) then
        -- 处理客户端自己触发打开NPC
        self:_battleNpcOpen(command.modelID)
    elseif (commandType == CommandType.BATTLE_HANDLE_FUNCTION_TYPE) then
        local target = self._model:getRoleBySpriteID(command.spriteID)
        if(target) then
            self:_battleHandleFuntionType(target, command.functionType, command.isMiniMap)
        end
    elseif (commandType == CommandType.BATTLE_ADD_TRIGGER_DATA) then

        -- 添加触发数据
        self:_battleAddTriggerData(command.spriteID,command.coord)
    elseif (commandType == CommandType.BATTLE_ROLE_REVIVE_END) then

        self:_battleReviveEnd(command.spriteID)
    elseif (commandType == CommandType.BATTLE_ROLE_BACK_TOWN) then
        self:_battleRoleBackTown(command.data)
    --触发怪物
    elseif (commandType == CommandType.BATTLE_TRIGGER_MONSTER) then

        Net.NetRoleSystem:triggerMonster(command.data)
    -- 触发状态改变
    elseif (commandType == CommandType.BATTLE_BATTLE_STATUS_CHANGE) then

        self:_battleStatusChange(command.spriteID, command.attrType, command.value)
    -- 处理NPC显示
    elseif (commandType == CommandType.BATTLE_NPC_INFOMATION_SHOW) then

        self:_battleNPCInfomationShow(command.spriteID, command.textStr)
    -- 处理NPC隐藏
    elseif (commandType == CommandType.BATTLE_NPC_INFOMATION_HIDE) then

        self:_battleNPCInfomationHide(command.spriteID)
    elseif (commandType == CommandType.BATTLE_NPC_FUNC_BTN_INFORMATION_PAUSE) then
        self:_battleFuncBtnPauseNPCInfomation(command.spriteID)
    elseif (commandType == CommandType.BATTLE_NPC_FUNC_BTN_INFORMATION_RESUME) then
        self:_battleFuncBtnResumeNPCInfomation(command.spriteID)
    elseif (commandType == CommandType.BATTLE_HERO_LOOKS) then

        self:_battleHeroLooks(command.spriteID)
    elseif (commandType == CommandType.BATTLE_ROLE_TITLE) then
        
        self:_battleHeroTitle(command.spriteID)
    elseif (commandType == CommandType.BATTLE_ROLE_GUILD_NAME) then
        self:_battleHeroGuildName(command.spriteID)
    elseif (commandType == CommandType.BATTLE_ITEM_DELUSION_INIT) then

        self:_battleItemDelusionInit(command.spriteID, command.delusion)
    elseif (commandType == CommandType.BATTLE_ITEM_DELUSION_REMOVE) then

        self:_battleItemDelusionRemove(command.spriteID, command.delusion)
    elseif (commandType == CommandType.BATTLE_TRANS_DOOR_OPEN) then

        self:_battleTransDoorTrigger(command.spriteID)
    elseif (commandType == CommandType.BATTLE_SEND_START_MOVE) then

         Net.NetRoleSystem:heroStartMoveRequest(command.coordX, command.coordY, command.direction)
    elseif (commandType == CommandType.BATTLE_ROLE_IS_HIDE_HELMET) then

        self:_battleIsHideHelmet(command.spriteID, command.isHideHelmet)
    elseif (commandType == CommandType.BATTLE_TRIGGER_NPC_FOR_TEMPLATE_ID) then

        self:_battleTriggerNpcForTemplateID(command.templateID)
    elseif (commandType == CommandType.BATTLE_NPC_ACTIVITY_CRYING) then

        self:_battleTriggerNpcActivityCrying()
    elseif (commandType == CommandType.BATTLE_STOP_MOVE) then

        self:_battleMasterStopMove(command.coordX, command.coordY)
    elseif (commandType == CommandType.BATTLE_USE_ASSIST_SKILL) then
        
        self:_battleUseAssistSkill(command.spriteID, command.skillData, command.params)
    -- 处理交互完成
    elseif (commandType == CommandType.BATTLE_NPC_INTERACTION_END) then
        self:_battleNpcInteractionEnd(command.spriteID)
    elseif (commandType == CommandType.BATTLE_PRE_RANK_CHANGE) then
        self:_battlePreRankChange(command.data, command.isAdd)
    elseif (commandType == CommandType.BATTLE_HORCRUX_EXTERIOR) then
        self:_battleHorcruxExterior(command.spriteID, command.horcruxExteriorID)
    elseif (commandType == CommandType.BATTLE_TRANS_POINT_OPEN) then
        self:_battleTransPointTrigger(command.spriteID, command.pk)
    elseif (commandType == CommandType.BATTLE_SETTING_HIDE_HORCRUX) then
        self:_battleSettingHideHorcrux(command.hideHorcrux)
    elseif (commandType == CommandType.BATTLE_SETTING_HIDE_PET) then
        self:_battleSettingHidePet(command.hidePet)
    elseif (commandType == CommandType.BATTLE_FORCE_REFRESH_PET) then
        self:_forceRefreshPetInScreen(command.spriteID)
    elseif (commandType == CommandType.BATTLE_SETTING_PERSON_COUNT) then
        self:_battleSettingPersionCount(command.num)
     elseif (commandType == CommandType.BATTLE_END) then
        self:_battleEnd(command.data)
    elseif (commandType == CommandType.CONTROL_SCREEN_HERO_START_BATTLE) then
        self:_controlScreenHeroStartBattle(command.data)
    elseif (commandType == CommandType.BATTLE_MONSTER_EVOLUTION) then
        self:_triggerMonsterEvo(command.spriteID, command.evoParts)
    -- 未处理的命令
    else
        assert(false, string.format("[ERROR] BattleMachine _onExecuteBattleCommand: command type %d is invalid.", commandType))
    end 
end

function Machine:testBlind()
    local master = RoleDataManager:getMaster()
    if(master.isBlind == true) then
        master.isBlind = false
    else
        master.isBlind = true
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_BLIND_CHANGE, master.isBlind)
end

function Machine:testLevelUp()
    local levelUpAction = Action.RoleLevelUpAction:create(true)
    levelUpAction:init(self._model:getMaster(),1,2)
    self:addAction(levelUpAction)
end

function Machine:testFont()
    local mesData = {}
    mesData.attrChange = {}

    local oneData = {}
    oneData.value = 0
    oneData.type = 0
    oneData.reason = CLIENT_ATTR_CHANGE_REASON.DAMAGE_MISS

    table.insert(mesData.attrChange, oneData)

    local oneData = {}
    oneData.value = 180
    oneData.type = 0
    oneData.reason = CLIENT_ATTR_CHANGE_REASON.DAMAGE_MAGIC

    table.insert(mesData.attrChange, oneData)

    if DEBUG then
        print("Machine:onExecuteControlCommand   CONTROL_ROLE_SKILL_MISS ",oneData.value,oneData.type,oneData.reason)
    end
    
    local renderCommand = Command.RendererCommand:create(true)
    renderCommand:initUpdateAttrCommand(self._model:getMaster():getId(), mesData)
    self:pushCommand(renderCommand)
end