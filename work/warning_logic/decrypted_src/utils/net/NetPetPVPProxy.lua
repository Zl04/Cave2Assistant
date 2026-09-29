--[[
    网络助手类
    - 宠物战报代理[[从nethelp拿到战报数据后丢到这里，在这里处理后再分发到NetXXXSystem]]
--]] 

-- 宠物战斗助手
local PetPVPProxy = {}
local ProtobufUtil = require "utils.ProtobufUtil"

--更新函数
function PetPVPProxy:update(dt)
    local size = #self.fightRecords
    if size <= 0 then
        return 
    end
    self.runTime = self.runTime + dt

    local curTime = self.runTime * 1000
    local record = self.fightRecords[size]
    while size > 0 and record and curTime > record.time do
        curTime = self.runTime * 1000
        self:doRecord(record)
        table.remove(self.fightRecords, size)
        size = size - 1
        record = self.fightRecords[size]
        -- print("--update next time ", record.time)
    end    
end

-- 战斗开始时初始化
function PetPVPProxy:init()
    if self.updateHandler ~= nil then
        return
    end
    local scheduler = cc.Director:getInstance():getScheduler()
    self.fightRecords = {}
    self.fightPB = {}
    self.runTime = 0
    self.updateHandler = scheduler:scheduleScriptFunc(handler(self, self.update), 0.1, false)
end

-- 战斗结束后销毁
function PetPVPProxy:destroy()
    if (self.updateHandler) then
        local scheduler = cc.Director:getInstance():getScheduler()
        scheduler:unscheduleScriptEntry(self.updateHandler)
        self.updateHandler = nil
    end
    self.fightRecords = {}
    self.fightPB = {}
    self.runTime = 0
end

function PetPVPProxy:setFightMember(members)
    if #self.fightRecords > 0 then
        print("-----setFightMember error PetPVPProxy is running-------")
        return
    end

end

--[[处理消息分段下发]]
function PetPVPProxy:addFightRecord(recordPB)
    if #self.fightRecords > 0 then
        print("-----addFightRecord error PetPVPProxy is running-------")
        -- 添加处理为大航海驱逐多次时，一次发送很多的驱逐结束消息过来。
        local records = recordPB.records
        for k,v in pairs(records) do
            local records2 = v
            if records2 and records2.petVersusEndMsg and recordPB.isEnd then
                Net.NetPetSystem:onPetMessageHandler(NetMessageType.PET_PVP_FIGHT_END_MESSAGE.NO, records2.petVersusEndMsg)
            end
        end

        return
    end
    table.insert(self.fightPB, recordPB)
    if recordPB.isEnd then
        self:createPlayers()
        self:parseFightRecord()
    end
end

--#####私有函数 begin#######
function PetPVPProxy:createPlayers()
    --addHero
    --addPet
end

--[[倒叙排列：最先执行的战斗 放在数组尾部]]
function PetPVPProxy:parseFightRecord()
    local temp = {}
    for k, v in ipairs(self.fightPB) do
        for k2, v2 in ipairs(v.records) do
            table.insert(temp, v2)
        end
    end

    local size = #temp
    self.fightRecords = {}
    for i = size, 1, -1 do
        table.insert(self.fightRecords, temp[i])
    end
    self.fightPB = {}
    self.runTime = 0
end


--[[解析PB 并转发到 netsystem]]
function PetPVPProxy:doRecord(record)
    if ProtobufUtil:checkFieldIsInit(record, "deadMsg") then  --RoleSystem.RoleDeadMessage 死亡
        self:print("doRecord deadMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_DEAD.NO, record.deadMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "reviveMsg") then --PetReviveResponseMessage 复活
        self:print("doRecord reviveMsg", record)
        Net.NetPetSystem:onPetMessageHandler(NetMessageType.PET_REVIVE_RESPONSE_MESSAGE.NO, record.reviveMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "useSkillMsg") then --PetUseSkillResultMessage 使用技能
        self:print("doRecord useSkillMsg", record)
        Net.NetPetSystem:onPetMessageHandler(NetMessageType.PET_USE_SKILL_RESULT_MESSAGE.NO, record.useSkillMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "attrChangeMsg") then --RoleSystem.AttrChangeMessage 各种属性通知
        self:print("doRecord attrChangeMsg")
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_ATTR_CHANGE.NO, record.attrChangeMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "removeBuffMsg") then --RoleSystem.RoleRemoveBuffMessage 移除buff
        self:print("doRecord removeBuffMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_ROLE_REMOVE_BUFF.NO, record.removeBuffMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "addBuffMsg") then --RoleSystem.RoleAddBuffMessage 增加buff
        self:print("doRecord addBuffMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_ROLE_ADD_BUFF.NO, record.addBuffMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "addEffectMsg") then --RoleSystem.RoleAddEffectMessage 增加效果
        self:print("doRecord addEffectMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_ROLE_ADD_EFFECT.NO, record.addEffectMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "petSkillCDMsg") then --NotifyPetSkillCooldownMessage 技能冷却
        self:print("doRecord petSkillCDMsg", record)
        Net.NetPetSystem:onPetMessageHandler(NetMessageType.PET_NTF_SKILL_COOLDOWN_MESSAGE.NO, record.petSkillCDMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "skillStatusMsg") then --RoleSystem.NotifyRoleSkillStatusMessage 技能状态
        self:print("doRecord skillStatusMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_NOTIFY_ROLE_SKILL_STATUS.NO, record.skillStatusMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "skillBreakMsg") then --RoleSystem.NotifyRoleSkillBreakMessage 技能中断？
        self:print("doRecord skillBreakMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_NOTIFY_ROLE_SKILL_BREAK.NO, record.skillBreakMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "skillFagMsg") then --RoleSystem.SkillRelatedFlagChangeMessage 技能标记
        self:print("doRecord skillFagMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_SKILL_RELATED_FLAG_CHANGE.NO, record.skillFagMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "petSceneDataMsg") then --PetSceneDataMessage 场景数据   -- 开始
        UI.WaitingLayer:hideWaiting()
        self:print("doRecord petSceneDataMsg", record)
        -- if #record.petSceneDataMsg.pets < 6 or #record.petSceneDataMsg.heros < 2 or #record.petSceneDataMsg.monsters < 2 then
        --     UI.ScrollBar:createByText(UI.TEXT_1213963)
        --     self:destroy()
        --     return
        -- end
        Net.NetPetSystem:onPetMessageHandler(NetMessageType.PET_PVP_SCREEN_DATA_MESSAGE.NO, record.petSceneDataMsg)
        self.runTime = self.runTime - 1.6
    elseif ProtobufUtil:checkFieldIsInit(record, "petVersusEndMsg") then --PetVersusEndMessage           --结束
        self:print("doRecord petVersusEndMsg", record)
        self:destroy()
        Net.NetPetSystem:onPetMessageHandler(NetMessageType.PET_PVP_FIGHT_END_MESSAGE.NO, record.petVersusEndMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "leaveBattleMsg") then--脱离战斗 RoleSystem.RoleLeaveBattleMessage
        self:print("doRecord leaveBattleMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_LEAVE_BATTLE.NO, record.leaveBattleMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "startBattleResultMsg") then--开始战斗 RoleSystem.HeroStartBattleResultMessage
        self:print("doRecord startBattleResultMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_HERO_START_BATTLE_RESULT.NO, record.startBattleResultMsg)
    elseif ProtobufUtil:checkFieldIsInit(record, "funcFlagChangeMsg") then
        self:print("doRecord funcFlagChangeMsg", record)
        Net.NetRoleSystem:onRoleMessageHandler(NetMessageType.ROLE_FUNCTION_FLAG_CHANGE.NO, record.funcFlagChangeMsg)
    end
end

function PetPVPProxy:skipFight()
    local record = self.fightRecords[1]
    if record and record.petVersusEndMsg then
        Net.NetPetSystem:onPetMessageHandler(NetMessageType.PET_PVP_FIGHT_END_MESSAGE.NO, record.petVersusEndMsg)
    end
    print("PetPVPProxy: ", "skipFight", record)
    self:destroy()
end

function PetPVPProxy:print(msg, data)
    if DEVELOPMENT_MODE then
        print("PetPVPProxy: ", msg, data)
    end
end
--#####私有函数 end#######

Net = Net or {}
Net.PetPVPProxy = PetPVPProxy
