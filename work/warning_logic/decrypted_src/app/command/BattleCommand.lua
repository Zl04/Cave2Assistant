--[[
     战斗指令
]]--

require "app.command.Command"
require "app.pool.Pool"

Command = Command or {}

local BattleCommand = class("BattleCommand", Command.Base)
Command.BattleCommand = BattleCommand

-- private:
-- 对象池
local BattleCommandPool = nil

-- public:
-- 创建对象
function BattleCommand:create(reused, ...)
    if (reused) then
        if (not BattleCommandPool) then
            BattleCommandPool = Pool.Pool:create(BattleCommand)
        end
        return BattleCommandPool:applyObject()
    else
        return BattleCommand.new(...)
    end
end

-- 构造函数
function BattleCommand:ctor()
    BattleCommand.super.ctor(self, CommandCategory.BATTLE, CommandType.NONE)

    -- 携带数据
    self.data = nil
end

-- 销毁
function BattleCommand:dtor()
    BattleCommand.super.dtor(self)

    self.data = nil
end

-- 清理
function BattleCommand:clear()
    BattleCommand.super.clear(self)

    self.data = nil
end

function BattleCommand:initForTypeAndData(type,data)
    self.type = type

    self.data = data
end

-- 移除游戏模型
-- modelID：即将被移除的模型，这里没法使用spriteID
-- cleanView：是否清理视图，默认值：true
function BattleCommand:initForRemoveModel(modelID, cleanView)
    self.type = CommandType.BATTLE_REMOVE_MODEL
    self.modelID = modelID
    self.cleanView = (cleanView == nil) and true or cleanView
end

-- 触发触发NPC
function BattleCommand:initForOpenTriggerNpc(spriteID, isMiniMap)
    self.type = CommandType.BATTLE_OPEN_TRIGGER_NPC
    self.spriteID = spriteID
    self.isMiniMap = isMiniMap
end

-- 处理客户端直接打开触发NPC
function BattleCommand:initForNpcOpen(modelID)
    self.type = CommandType.BATTLE_NPC_OPEN
    self.modelID = modelID
end

function BattleCommand:initForHandleFunctionType(spriteID, functionType, isMiniMap)
    self.type = CommandType.BATTLE_HANDLE_FUNCTION_TYPE

    self.spriteID = spriteID
    self.functionType = functionType
    self.isMiniMap = isMiniMap
end

-- 处理添加触发判定
function BattleCommand:initForAddTriggerData(spriteID,coord)
    self.type = CommandType.BATTLE_ADD_TRIGGER_DATA 
    self.spriteID = spriteID
    self.coord = coord
end

-- 添加角色视图
function BattleCommand:initForAddRoleView(spriteID)
    self.type = CommandType.BATTLE_ADD_ROLE_VIEW
    
    self.spriteID = spriteID
end

-- 触发复活
function BattleCommand:initForRoleReviveEnd(spriteID)
    self.type = CommandType.BATTLE_ROLE_REVIVE_END

    self.spriteID = spriteID
end

-- 战斗状态改变
function BattleCommand:initForBattleChange(spriteID, attrType, value)
    self.type = CommandType.BATTLE_BATTLE_STATUS_CHANGE

    self.spriteID = spriteID
    self.attrType = attrType
    self.value = value
end

function BattleCommand:initNPCInfomationShow(spriteID, textStr)
    self.type = CommandType.BATTLE_NPC_INFOMATION_SHOW

    self.spriteID = spriteID
    self.textStr = textStr
end

function BattleCommand:initNPCInfomationHide(spriteID)
    self.type = CommandType.BATTLE_NPC_INFOMATION_HIDE

    self.spriteID = spriteID
end

function BattleCommand:initNPCFuncBtnInformationPause(spriteID)
    self.type = CommandType.BATTLE_NPC_FUNC_BTN_INFORMATION_PAUSE

    self.spriteID = spriteID
end

function BattleCommand:initNPCFuncBtnInformationResume(spriteID)
    self.type = CommandType.BATTLE_NPC_FUNC_BTN_INFORMATION_RESUME

    self.spriteID = spriteID
end

function BattleCommand:initSelectHeroHide(spriteID)
    self.type = CommandType.BATTLE_SELECT_HERO_HIDE

    self.spriteID = spriteID
end

function BattleCommand:initNpcInteractionEnd(spriteID)
    self.type = CommandType.BATTLE_NPC_INTERACTION_END

    self.spriteID = spriteID
end

function BattleCommand:initHeroLooks(spriteID)
    self.type = CommandType.BATTLE_HERO_LOOKS

    self.spriteID = spriteID
end

function BattleCommand:initForRoleTitle(spriteID)
    self.type = CommandType.BATTLE_ROLE_TITLE

    self.spriteID = spriteID
end

function BattleCommand:initForRoleGuildName(spriteID)
    self.type = CommandType.BATTLE_ROLE_GUILD_NAME

    self.spriteID = spriteID
end

function BattleCommand:initItemDelusionInit(spriteID, delusion)
    self.type = CommandType.BATTLE_ITEM_DELUSION_INIT

    self.spriteID = spriteID
    self.delusion = delusion
end

function BattleCommand:initItemDelusionRemove(spriteID, delusion)
    self.type = CommandType.BATTLE_ITEM_DELUSION_REMOVE

    self.spriteID = spriteID
    self.delusion = delusion
end

function BattleCommand:initTransDoorTrigger(spriteID)
    self.type = CommandType.BATTLE_TRANS_DOOR_OPEN
    self.spriteID = spriteID
end

function BattleCommand:initTransPointTrigger(spriteID, PK)
    self.type = CommandType.BATTLE_TRANS_POINT_OPEN
    self.spriteID = spriteID
    self.pk = PK
end


function BattleCommand:initSendStartMove(x, y, direction)
    self.type = CommandType.BATTLE_SEND_START_MOVE
    
    self.coordX = x
    self.coordY = y 
    self.direction = direction
end

function BattleCommand:initIsHideHelmet(spriteID, isHideHelmet)
    self.type = CommandType.BATTLE_ROLE_IS_HIDE_HELMET
    self.spriteID = spriteID
    self.isHideHelmet = isHideHelmet
end

function BattleCommand:initTriggerNpcForTemplateID(templateID)
    self.type = CommandType.BATTLE_TRIGGER_NPC_FOR_TEMPLATE_ID

    self.templateID = templateID
end

function BattleCommand:initTriggerNpcActivityCrying()
    self.type = CommandType.BATTLE_NPC_ACTIVITY_CRYING
end

function BattleCommand:initMasterStopMove(coordX, coordY)
    self.type = CommandType.BATTLE_STOP_MOVE

    self.coordX = coordX
    self.coordY = coordY
end

function BattleCommand:initUseAssistSkil(spriteID, skillData, params)
    self.type = CommandType.BATTLE_USE_ASSIST_SKILL

    self.spriteID =  spriteID
    self.skillData = skillData
    self.params = params
end

function BattleCommand:initPreRankChange(data, isAdd)
    self.type = CommandType.BATTLE_PRE_RANK_CHANGE

    self.data =  data
    -- 是否新加，否则是移除
    self.isAdd = isAdd
end

function BattleCommand:initTriggerHorcruxExterior(spriteID, horcruxExteriorID)
    self.type = CommandType.BATTLE_HORCRUX_EXTERIOR

    self.spriteID = spriteID
    self.horcruxExteriorID = horcruxExteriorID
end

function BattleCommand:initSettingHideHorcrux(hideHorcrux)
    self.type = CommandType.BATTLE_SETTING_HIDE_HORCRUX

    self.hideHorcrux = hideHorcrux
end

function BattleCommand:initSettingHidePet(hidePet)
    self.type = CommandType.BATTLE_SETTING_HIDE_PET

    self.hidePet = hidePet
end

function BattleCommand:initRefreshPetInScreen(spriteID)
    self.type = CommandType.BATTLE_FORCE_REFRESH_PET
    self.spriteID = spriteID
end

function BattleCommand:initPersonCount()
    self.type = CommandType.BATTLE_SETTING_PERSON_COUNT
end

function BattleCommand:initTriggerMonsterEvo(spriteID, evoParts)
    self.type = CommandType.BATTLE_MONSTER_EVOLUTION

    self.spriteID = spriteID
    self.evoParts = evoParts
end






