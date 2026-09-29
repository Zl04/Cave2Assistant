

-- 地图
local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")

-- 行为轨道索引
local TRACKS_INDEX = GameTracksIndex

local Machine = Town.Machine

local DEBUG = true

-- 处理执行城镇自有命令
function Machine:onExecuteTownCommand(command)
    local commandType = command.type
    -- 开始战斗
    if (commandType == CommandType.GENERATION_START_MOVE) then
    
    elseif (commandType == CommandType.BATTLE_OPEN_TRIGGER_NPC) then
        print("BattleMachine _onExecuteBattleCommand:   BATTLE_OPEN_TRIGGER_NPC.",command.spriteID)
        -- self._view:shack()
        local target = self._model:getRoleBySpriteID(command.spriteID)
        -- 如果报名了worldbos，前去打副本时，需要做一次确认
        if target then
            local triggerType = target:getData():getDeformationType()
            if target:getData():hasFunction(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE) then
                -- 如果 worldboss 已报名，提醒一次
                if mvc.worldBossModel:checkCanEnterOther() then
                    self:_battleOpenTriggerNpc(command.spriteID, command.isMiniMap)
                else
                    UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                        UI.TEXT_1212663,
                        function()
                            Net.NetActivitySystem:requestWorldbossQuitRoom()
                            self:_battleOpenTriggerNpc(command.spriteID, command.isMiniMap)
                        end
                    )
                end
            elseif triggerType == PublicDefine.TRIGGER_NPC_TYPE.SAIL_PORT then--target:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.SAIL_PORT) then
                if not mvc.bigSailPortModel:getIsPortClose() then
                    mvc.openPanel("BigSailIsland", "BigSailIslandShowMap")
                else
                    UI.ScrollBar:createByText(UI.TEXT_226216)
                end
            else
                self:_battleOpenTriggerNpc(command.spriteID, command.isMiniMap)
            end
        else
            self:_battleOpenTriggerNpc(command.spriteID, command.isMiniMap)
        end
    elseif (commandType == CommandType.BATTLE_NPC_OPEN) then
        -- 处理客户端自己触发打开NPC
        self:_battleNpcOpen(command.modelID)
    elseif (commandType == CommandType.BATTLE_HANDLE_FUNCTION_TYPE) then
        local target = self._model:getRoleBySpriteID(command.spriteID)
        if(target) then
            self:_battleHandleFuntionType(target, command.functionType, command.isMiniMap)
        end
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
    -- 处理选择角色表现隐藏
    elseif (commandType == CommandType.BATTLE_SELECT_HERO_HIDE) then
        self:_battleSelectHeroHide(command.spriteID)
    -- 处理交互完成
    elseif (commandType == CommandType.BATTLE_NPC_INTERACTION_END) then
        self:_battleNpcInteractionEnd(command.spriteID)
    -- 处理战斗变形
    elseif (commandType == CommandType.BATTLE_HERO_LOOKS) then
        self:_battleHeroLooks(command.spriteID)
    -- 角色称呼
    elseif (commandType == CommandType.BATTLE_ROLE_TITLE) then
        self:_battleHeroTitle(command.spriteID)
    elseif (commandType == CommandType.BATTLE_ROLE_GUILD_NAME) then
        self:_battleHeroGuildName(command.spriteID)
    -- 幻境效果初始化
    elseif (commandType == CommandType.BATTLE_ITEM_DELUSION_INIT) then
        self:_battleItemDelusionInit(command.spriteID, command.delusion)
    -- 幻境效果移除
    elseif (commandType == CommandType.BATTLE_ITEM_DELUSION_REMOVE) then
        self:_battleItemDelusionRemove(command.spriteID, command.delusion)
    elseif (commandType == CommandType.BATTLE_SEND_START_MOVE) then
         Net.NetRoleSystem:heroStartMoveRequest(command.coordX, command.coordY, command.direction)
    elseif (commandType == CommandType.BATTLE_TRANS_DOOR_OPEN) then
        self:_battleTransDoorTrigger(command.spriteID)
    elseif (commandType == CommandType.BATTLE_BATTLE_STATUS_CHANGE) then
        -- self:_battleStatusChange(command.spriteID, command.attrType, command.value)

    elseif (commandType == CommandType.BATTLE_ROLE_IS_HIDE_HELMET) then
        self:_battleIsHideHelmet(command.spriteID, command.isHideHelmet)

    elseif (commandType == CommandType.BATTLE_TRIGGER_NPC_FOR_TEMPLATE_ID) then
        self:_battleTriggerNpcForTemplateID(command.templateID)
    elseif (commandType == CommandType.BATTLE_NPC_ACTIVITY_CRYING) then
        self:_battleTriggerNpcActivityCrying()
    elseif (commandType == CommandType.BATTLE_STOP_MOVE) then
        self:_battleMasterStopMove(command.coordX, command.coordY)
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
        self:_battleSettingPersionCount()
    else
        assert(false,string.format("[ERROR] TownMachine onExecuteTownCommand: command type %d is invalid.", commandType))
    end 
end

