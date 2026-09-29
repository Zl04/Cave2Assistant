--[[--
控制器BigCrackController，view已经注入,可以通过mvc.bigCrackProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongjian.yang
-- date	: 2019/11/01
-- desc	: 
------------------------------------------------------------------------------
local BigCrackController = class("BigCrackController", mvc.GameController)
local ProtobufUtil = require "utils.ProtobufUtil"
local MachineManager = require("app.game.MachineManager")
local SceneManager = require("app.game.SceneManager")

-- mvc.events.COLLECT_START 处理函数
function BigCrackController:noticeCOLLECTSTART(notification, collect, isClose)
    if not self.bigCrackCaveView then
        return
    end
    if isClose then
        local isBreak = self.bigCrackCaveView:hideCollection()
        if isBreak and self.lastSpriteId then
            Net.NetNPCSystem:reqCollectCancel(self.lastSpriteId)
            self.lastSpriteId = nil
        end
    else
        self.lastSpriteId = collect.spriteID
        Net.NetNPCSystem:reqCollectStart(collect.spriteID)
        self.bigCrackCaveView:showCollection(collect.collectionTime)
    end
end


-- openTriggerNpcRequest

-- mvc.events.COLLECT_END 处理函数
function BigCrackController:noticeCOLLECTEND(notification)
    if self.lastSpriteId then
        Net.NetNPCSystem:openTriggerNpcRequest(self.lastSpriteId)
    end
end



-- mvc.events.COLLECT_RESULT 处理函数
function BigCrackController:noticeCOLLECTRESULT(notification, data)
    --清理model
    -- local spriteID = data.spriteID
    -- local model = MachineManager:getInstance():getMachine():getModel()
    -- local role = model:getRoleBySpriteID(spriteID)
    -- -- model:removeModel(role)
    -- if role then
    --     MachineManager:getInstance():pushRemoveModelCommand(role:getId(), false)
    -- end

    local command = Command.ControlCommand:create(true)
    command:initForTypeAndData(CommandType.CONTROL_REMOVESCREENROLE, data)
    SceneManager:getInstance():pushCommand(command)

    if not self.bigCrackCaveView then
        return
    end
    local npcId = data.npcid
   
    if npcId and npcId > 0 then
        local collectData = ConfigManager:getTriggerNpcConfigByID(npcId)
        if collectData then
            local masterPK = RoleDataManager:getMasterPK()
            
            UI.ScrollBar:createByText(string.format(UI.TEXT_1213442, UIUtil:lang(collectData.name), data.collecterName))
            if self.lastSpriteId == data.spriteID and pk ~= masterPK then
                self.bigCrackCaveView:doCollectFailure(data.spriteID)
            end
            local isMyCamp = ProtobufUtil:enum_id("PublicDefine.Camp", data.camp) == mvc.bigCrackModel:getCampId()
            local target = ""
            if collectData.target == 1 then
                target =  isMyCamp and UI.TEXT_1213449 or UI.TEXT_1213450
            else
                target =  isMyCamp and UI.TEXT_1213450 or UI.TEXT_1213449
            end
            Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function() 
                UI.ScrollBar:createByTextWithDelay(tostring(target) .. UIUtil:lang(collectData.tips), 4)
            end, 1)

            if isMyCamp  then
                local icon = collectData.icon or "effect_buff_freeze"
                self.bigCrackCaveView:showGetBuffs( icon .. "_big.png")
            end
            return
        end
    else
        UI.ScrollBar:createByText(UI.TEXT_1213440)
        return
    end
end



return BigCrackController