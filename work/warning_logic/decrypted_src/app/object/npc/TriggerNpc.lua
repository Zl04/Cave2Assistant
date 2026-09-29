--TriggerNpc.lua
--2017-04-27
--Author:zp
--触发NPC模型

require "app.object.npc.Npc"
require "app.object.GameModel"
require "app.object.fsm.TriggerNpcFSM"
require "app.object.geometric.GeometricRect"

local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")

Model = Model or {}

local TriggerNpc = class("TriggerNpc", Model.Npc)
Model.TriggerNpc = TriggerNpc

-- private:
-- 构造函数
function TriggerNpc:ctor()
    
    TriggerNpc.super.ctor(self, Category.TRIGGER_NPC, 0)
end

-- 析构函数
function TriggerNpc:dtor()
    TriggerNpc.super.dtor(self)
end

-- public:
 -- 创建对象
local TriggerNpcPool = nil
function TriggerNpc:create(reused, ...)
    if (reused) then
        if (not TriggerNpcPool) then
            TriggerNpcPool = Pool.Pool:create(TriggerNpc)
        end
        return TriggerNpcPool:applyObject()
    else
        return TriggerNpc.new(...)
    end
end

-- 初始化
function TriggerNpc:init(triggerNPCData)
    local fsm = FSM.TriggerNpcFSM:create(triggerNPCData)
    fsm:init(self)

    local geometric = Geome.GeometricRect:create(triggerNPCData)
    geometric:init()

    TriggerNpc.super.init(self, triggerNPCData ,fsm, geometric)
    -- print("TriggerNpc:init  ",triggerNPCData:getType())
    -- dump(triggerNPCData)
    self:setType(triggerNPCData:getType())

    if(triggerNPCData and triggerNPCData:getIsTriggerAutoSpeaking()) then 
        if (self.schedulerID == nil) then
            self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.triggerTime), 1, false)
        end
    end

    self:peddlerInitTriggerTime(triggerNPCData)
end

-- 清理
function TriggerNpc:clear()
    TriggerNpc.super.clear(self)

    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

-- 获取动画配置数据
function TriggerNpc:getAnimationData()
    local monsterData = self._npcData

    if(self:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR 
            and self._npcData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.ROOM_TO_ROOM
            and self._npcData:getIsRandomTransfer()) then 
        return "role_npc_treasure_stage_portal_zise.json", "role_npc_treasure_stage_portal_zise.atlas", monsterData.scale
    elseif monsterData:isMonsterNpc() and monsterData:getMonsterNpcData() then
        local MNData = monsterData:getMonsterNpcData()
        return MNData.spine..".json", MNData.spine..".atlas", 1
    else
        return monsterData.skeleton, monsterData.atlas, monsterData.scale
    end 
end

-- set动画配置数据
function TriggerNpc:setAnimationData(animeName)
    self._npcData.skeleton = animeName..".json"
    self._npcData.atlas = animeName..".atlas"
end

function TriggerNpc:isMonsterNpc()
    return self._npcData:isMonsterNpc()
end

function TriggerNpc:getMonsterNpcData()
    return self._npcData:getMonsterNpcData()
end

-- 获取配置名字
function TriggerNpc:getSpineName()
    if(self._npcData) then
        -- add by zp CO-5794【深渊】随机传送门和普通传送门做一个颜色的区分, 由于该流程走完整的NPC类型服务器修改会很大，就才去这样取巧的方式处理
        if(self:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR 
            and self._npcData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.ROOM_TO_ROOM
            and self._npcData:getIsRandomTransfer()) then 
            
            return "role_npc_treasure_stage_portal_zise"
        else
            return self._npcData.spine
        end
    end

    return ""
end

-- 获取是否锁定
function TriggerNpc:getIsLock()
    return self._npcData:getIsLock()
end

-- 解锁
function TriggerNpc:unlock()
    if(self._npcData) then 
        self._npcData:unlock()
    end 

    return true
end

-- 是否随机传送
function TriggerNpc:getIsRandomTransfer()
    if(self._npcData) then 
        self._npcData:getIsRandomTransfer()
    end 

    return false
end

-- 获取是否为宝箱
function TriggerNpc:getIsChest()
   return self._npcData:getIsChest()
end

-- 获取是否打开
function TriggerNpc:getIsOpen()
    if(self._npcData) then 
        return self._npcData:getIsOpen()
    end

    return false
end

-- 获取是否在触发后移除
function TriggerNpc:getRemoveAfterTrigger()

    return self._npcData:getRemoveAfterTrigger()
end

-- 获取气泡位置
function TriggerNpc:getInformationLocation()
    return self._npcData:getInformationLocation()
end

-- 获取欢迎气泡持续时间
function TriggerNpc:getTalkDuration()
    return self._npcData:getTalkDuration()
end

-- 获取引导气泡持续时间
function TriggerNpc:getGuideTalkDucation()
    return self._npcData:getGuideTalkDucation()
end

-- 判断是否变形
function TriggerNpc:isDeformation()
    return self._npcData:isDeformation()
end

-- 获取迷惑变型数据
function TriggerNpc:getIsNormalDeformation()
    if self._npcData then 
        return self._npcData:getIsNormalDeformation()
    else 
        return false 
    end 
end

-- 获取变形后的数据
function TriggerNpc:getDeformationData()
    if (self._npcData) then 
        return self._npcData:getDeformationData()
    end 

    return false
end

-- 设置变形的数据  nil 代表清空变形效果
function TriggerNpc:setDeformationID(deformationID)
    self._npcData:setDeformationID(deformationID)
end

-- 获取结束对话框
function TriggerNpc:getEndDialogue()
    if(self._npcData) then
        return self._npcData:getEndDialogue()
    end

    return 0
end

-- 是否有光环
function TriggerNpc:getHalo()
    if(self._npcData) then
        return self._npcData:getHalo()
    end
    
    return false
end

function TriggerNpc:triggerTime(dt)  
    if(self._npcData) then 
        local status,language = self._npcData:triggerTime(dt)
        if(status and language) then 
            -- 触发一次自言自语
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initNPCInfomationShow(self:getId(), LanguageManager:getInstance():getLocalString(tonumber(language)), self._npcData:getTalkDuration())
            SceneManager:getInstance():pushCommand(renderCommand)
        end
    end
end

function TriggerNpc:peddlerInitTriggerTime(triggerNpcData)
    local has = triggerNpcData:hasFunction(PublicDefine.FUNCTION_TYPE.FUNCTION_TRAVELING_BUSINESSMAN)
    if has then
        local GameInManorManager = require "app.game.GameInManorManager"
        local purchaseItem = GameInManorManager:getInstance():getPeddlerShopData()
        if purchaseItem ~= nil then
            Avalon.Scheduler:scheduleUpdateOnce(self, function()  
                local renderCommand = Command.RendererCommand:create(true)

                local sellContentStr = ""
                local goodData = GoodsDataManager:createLocalGoodsData(purchaseItem.saleID)
                if goodData then
                    sellContentStr = string.format(UI.TEXT_221801, goodData:getName())
                end

                renderCommand:initPeddlerInfomationShow(self:getId(), sellContentStr, purchaseItem.saleID, purchaseItem.giveID, purchaseItem.givePrice, self._npcData:getTalkDuration())
                SceneManager:getInstance():pushCommand(renderCommand)
            end, 2) 
            
        end
    end
end