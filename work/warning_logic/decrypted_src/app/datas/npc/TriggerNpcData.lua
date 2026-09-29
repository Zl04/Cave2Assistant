--TriggerNpcData.lua
--2017-04-27
--Author:zp
--处理触发类属性定义

require "app.datas.npc.NpcData"

local TriggerNpcData = class("TriggerNpcData",Data.NpcData)  

Data = Data or {}
Data.TriggerNpcData = TriggerNpcData  

local BOX_TYPE = PublicDefine.BOX_TYPE
local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE
  
-- 构造函数(会自动调用)  
-- 外界构造时可以传任意参数XXX.new(...)  
function TriggerNpcData:ctor(templateID)
    self.templateID = templateID
    self.linkTaskArr = {}
    self._monsterData = nil --monsterNpc
    self:init()
    -- 计算触发类NPC类型
    TriggerNpcData.super.ctor(self, Category.TRIGGER_NPC, self:_getNPCType())
end  

-- 模版函数：
function TriggerNpcData:getId()

	return self.templateID
end

-- 获取是否为宝箱
function TriggerNpcData:getIsChest()
    if(self.extendValue == 3 or self.extendValue == 4) then
        return true
    end

    return false
end

-- 获取幽灵深渊NPC类型
function TriggerNpcData:getGhostType()
    local type = self.extendValue

    return type
end

-- 获取宝藏类型
function TriggerNpcData:getTreasureType()
    local type = self.extendValue

    return type
end

-- 获取掉落藏宝图碎片
function TriggerNpcData:getFragmentID()
    return self.extendValue
end

-- 获取传送门类型
function TriggerNpcData:getTransdoorType()
    return self.extendValue
end

-- 获取传送点类型
function TriggerNpcData:getTransPointType()
    return self.extendValue
end

-- 获取传送点类型
function TriggerNpcData:getIsSystemTransPointType()
    if(self.extendValue == PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_SYS_BIRTH 
        or self.extendValue == PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_SYS_RAND) then 
        return true 
    end

    return false
end

-- 获取触发时间
function TriggerNpcData:getDoEffectTiming()
    return self.doEffectTiming
end

-- 是否有光环
function TriggerNpcData:getHalo()
    if(self.halo == 1) then
        return true
    end
    
    return false
end

-- 获取功能类型数值
function TriggerNpcData:getFunctionTypeArr()
    -- if (not self._functionTypeList) then
    --     self._functionTypeList = ToolsUtil:splitFunctionType(self.extendValue)
    -- end

    return self.functionFlag
end

-- 检测是否有某种功能
function TriggerNpcData:hasFunction(functionType)
    -- if (not self._functionTypeList) then
    --     self._functionTypeList = ToolsUtil:splitFunctionType(self.extendValue)
    -- end

    if(self.functionFlag) then
        for i = 1, #self.functionFlag do
            local _functionType = self.functionFlag[i]
            if (_functionType == functionType) then
                return true
            end
        end
    end
    return false
end

-- 获取主要功能
function TriggerNpcData:getMainFunction()

    return self.mainFunction
end

-- 获取精灵ID
function TriggerNpcData:getSpriteID()
	return self.spriteID
end

function TriggerNpcData:getBust()
    return self.bust
end

-- 模版函数：
function TriggerNpcData:isReachable()
    local npcType = self:getType()
    local isOpen = self:getIsOpen()
    local isLock = self:getIsLock()

    -- print("isReachable   npcType ======= ",npcType)
    
    if npcType == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE then
        if(isLock) then
            return false
        else
            return true
        end
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRAP then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.NPC_TYPE_ACTOR then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.QUICK_DOWN then 
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.COLLECT then 
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FISH then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.SAIL_PORT then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR then
        if(isLock) then
            return false
        end
    end

    if self.reachable == 0 then
        return false
    else
        return true
    end
end

function TriggerNpcData:canBeNodeOfPath()
    -- TODO 根据数据判断
    local npcType = self:getType()
    local isOpen = self:getIsOpen()
    local isLock = self:getIsLock()
    -- print ("TriggerNpcData canBeNodeOfPath", npcType, isOpen, isLock)

    if npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR then
        if(self:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.ROOM_TO_ROOM) then
            if(isLock) then
                return false
            else
                return true
            end
        else
            return false
        end
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX then
        return false
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FISH then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.QUICK_DOWN then 
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.GOLD_BAG then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE then
        return false
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_TRIGGER then
        -- if isOpen then
        --     return true
        -- end
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE then
        if(isOpen) then
            return true
        else
            return false
        end
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC then
        return false
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.RUNE then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE then
        if(isLock) then
            return false
        else
            return true
        end
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.BOSS_SCENARIO_TRIGGER then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_TREASURE_MAP then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRAP then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.DUNGEON_ROOM_TRIGGER then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.DISAPPEAR_OBSTACLE then
        return false

    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.PATROL_NPC then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.NPC_TYPE_ACTOR then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.COLLECT then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_MOLD then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.SAIL_PORT then
        return true
    else
        -- printError(string.format("TriggerNpcData:canBeNodeOfPath  no handle npcType=%d",npcType))
    end

    return false
end

function TriggerNpcData:canBeEndOfPath()
    -- TODO 根据数据判断
    local npcType = self:getType()
    local isOpen = self:getIsOpen()
    local isLock = self:getIsLock()
    
    -- print ("TriggerNpcData canBeEndOfPath", npcType, isOpen, isLock)
    if npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR then
        if(isLock) then
            return false
        else
            return true
        end
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FISH then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.QUICK_DOWN then 
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.GOLD_BAG then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_TRIGGER then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE then
        if(isLock) then
            return false
        else
            return true
        end
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.RUNE then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE then
        if(isLock) then
            return false
        else
            return true
        end
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.BOSS_SCENARIO_TRIGGER then
        return true

    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_TREASURE_MAP then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRAP then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.DUNGEON_ROOM_TRIGGER then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.DISAPPEAR_OBSTACLE then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.PATROL_NPC then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.NPC_TYPE_ACTOR then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.COLLECT then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_MOLD then
        return true
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.SAIL_PORT then
        return true
    else
        -- assert(false,string.format("TriggerNpcData:canBeEndOfPath  no handle npcType=%d", npcType))
    end

	return false
end


-- 获取怪物
function TriggerNpcData:getMonsterSubType()
    if(self._deformationData) then
        return self._deformationData:getMonsterSubType()
    end

    printError("TriggerNpcData:getMonsterSubType _deformationData is nil.")

    return PublicDefine.MonsterSubType.InvalidMonsterSubtype
end

-- 获取是否触发，仅用于相关boss，触发怪等
function TriggerNpcData:getIsTrigger()
    if(self._deformationData) then
        return self._deformationData:getIsTrigger()
    end
    printError("TriggerNpcData:getIsTrigger _deformationData is nil.")

    return false
end

-- 普通怪
function TriggerNpcData:isNormalMonster()
    if(self._deformationData) then
        return self._deformationData:isNormalMonster()
    end

    printError("TriggerNpcData:isNormalMonster _deformationData is nil.")
    return false
end

-- 精英怪
function TriggerNpcData:isEliteMonster()
    if(self._deformationData) then
        return self._deformationData:isEliteMonster()
    end

    printError("TriggerNpcData:isEliteMonster _deformationData is nil.")
    return false
end

-- 小boss
function TriggerNpcData:isSmallBoss()
    if(self._deformationData) then
        return self._deformationData:isSmallBoss()
    end

    printError("TriggerNpcData:isSmallBoss _deformationData is nil.")
    return false
end

-- 大boss
function TriggerNpcData:isBigBoss()
    if(self._deformationData) then
        return self._deformationData:isBigBoss()
    end

    printError("TriggerNpcData:isBigBoss _deformationData is nil.")

    return false
end

-- 获取虚幻后的分类
function TriggerNpcData:getDeformationCategory()
    if(self:isDeformation()) then
        return self._deformationData:getCategory()
    else
        return self._category
    end
end

-- 获取虚幻后的类型
function TriggerNpcData:getDeformationType()
    if(self:isDeformation()) then
        return self._deformationData:getType()
    else
        return self._type
    end
end

-- 获取虚幻后的小地图
function TriggerNpcData:getDeformationTypeForMinimap()
    if(self:isDeformation()) then
        return self._deformationData:getTypeForMinimap()
    else
        return self:getTypeForMinimap()
    end
end

-- 判断是否变形
function  TriggerNpcData:isDeformation()
    if(self._deformationData) then
        return true
    end

    return false
end

-- 获取结束对话框
function TriggerNpcData:getEndDialogue()
    return self.endDialogue
end

-- 获取迷惑变型数据
function TriggerNpcData:getIsNormalDeformation()
    if self._deformationData then 
        return true 
    else 
        return false 
    end 
end

-- 获取变形后的数据
function TriggerNpcData:getDeformationData()

    return self._deformationData
end

-- 设置变形的数据  nil 代表清空变形效果
function TriggerNpcData:setDeformationID(deformationID)
    -- 这里获取相关怪物数据
    if(deformationID) then
        self._deformationData = RoleDataManager:createLocalMonsterData(deformationID)
        if(self._deformationData) then
            self.monsterMiniMapIcon = self._deformationData.monsterMiniMapIcon
        end
    else
        self._deformationData = nil
        self.monsterMiniMapIcon = ""
    end
end

-- 判断是否锁定
function TriggerNpcData:getIsLock()
    return self.isLock
end

function TriggerNpcData:getIsRandomTransfer()
    return self.isRandomTransfer
end

-- 获取是否有任务需要提交 或者成就可以领取
function TriggerNpcData:getHaveComplete()
    local have = TaskDataManager:getHaveNoGuildTaskComplete() or MasterDataManager:hasOneAchevementComplete()
    return have
end

-- 获取是否有公会任务完成
function TriggerNpcData:getHaveGuildTaskComplete()
    return TaskDataManager:getHaveGuildTaskComplete()
end

-- 获取是否要在触发后移除
function TriggerNpcData:getRemoveAfterTrigger()
    if(self.removeAfterTrigger == 1) then
        return true
    end

    return false
end
-- 是否触发有对话框
function TriggerNpcData:getDialogue()
    return self.dialogue
end
-- 获取皮肤名字
function TriggerNpcData:getSkinName()
    return self.skin
end
-- 判断是否被打开
function TriggerNpcData:getIsOpen()
	if(self.triggerCountMax >0) then
        if(self.triggeredCount >= self.triggerCountMax) then
            return true
        else
            return false
        end
    elseif self.triggerCountMax == -1 then
        return false
    else
        return false
    end
end

function TriggerNpcData:trigger()
    self.triggeredCount = self.triggeredCount + 1
end

-- 解锁 
function TriggerNpcData:unlock()
    self.isLock = false
end

function TriggerNpcData:init()
    --
    self.spriteID = -1

    self.coordX = 0
    self.coordY = 0

    self.triggeredCount = 0
    self.isLock = false
    self.isRandomTransfer = false

    self.monsterMiniMapIcon = ""
    -- 是否处于引导阶段
    self._guideInfomationFlag = false
    -- 是否处于function按钮类型
    self._functionBtnInfomationFlag = false

    self:conbinationLocalData()

    self:initTaskData()
end

function TriggerNpcData:conbinationLocalData()
    if (self.templateID ~= -1) then        
        -- self._functionTypeList = nil
        -- 处理模板数据读取
        local boxData = ConfigManager:getTriggerNpcConfigByID(self.templateID)

        self:setLocalConfigData(boxData)

        -- 处理相关的逻辑处理
        self._chatData = nil

        if(self.automaticSpeaking and self.automaticSpeaking ~= "")  then 
            local haveSpeak = false
            local arr = string.split(self.automaticSpeaking, ";")
            local chatData = {}
            if(arr and #arr == 2) then 
                local timeArr = string.split(arr[1], ",")
                if(timeArr and #timeArr == 2) then 
                    chatData.timeMin = tonumber(timeArr[1])
                    chatData.timeMax = tonumber(timeArr[2])

                    local languageArr = string.split(arr[2], ",")
                    chatData.languageArr = {}
                    if(languageArr) then
                        for _,ID in ipairs(languageArr) do 
                            table.insert(chatData.languageArr, tonumber(ID))
                        end
                        haveSpeak = true
                    end
                end
            end

            if(haveSpeak) then
                self._chatData = chatData
                self._npcChatTriggerWaitingTime = 0
                self._chatInternal = math.random(self._chatData.timeMin, self._chatData.timeMax)/1000
            end 
        end
    end
end

function TriggerNpcData:changeInit(data)
    if type(data) ~= "table" then
        return
    end
    local boxID = self.templateID

    for k,v in pairs(data) do 
        if type(v) ~= "table" then
            self[k] = v
        else 
            --TODO 处理table属性的处理
            
        end
    end

    -- print("TriggerNpcData:changeInit  boxID,data.templateID=",boxID,data.templateID)

    if data.templateID and (boxID ~= data.templateID) and (data.templateID ~= -1) then
        self:conbinationLocalData()
    end
end

function TriggerNpcData:initTaskData()
    self.linkTaskArr = {}
    local taskArr = TaskDataManager:getAllCycleTaskArr()
    if(taskArr) then 
        for k,taskData in ipairs(taskArr) do  
            self:addTaskData(taskData)
        end
    end

    local taskArr = TaskDataManager:getAllDistortedSpaceTaskArr()
    if(taskArr) then 
        for k,taskData in ipairs(taskArr) do  
            self:addTaskData(taskData)
        end
    end
end

function TriggerNpcData:addTaskData(taskData)
    if(taskData == nil) then return end

    local found = false
    for k,v in ipairs(self.linkTaskArr) do  
        if(v:getId() ~= taskData:getId()) then 
            found = true
            break
        end
    end

    if(found == false and self:checkInTemplateID(taskData)) then 
        table.insert(self.linkTaskArr, taskData)
    end
end

function TriggerNpcData:removeTaskData(taskData)
    if(taskData == nil) then return end

    for k,v in ipairs(self.linkTaskArr) do  
        if(v:getId() ~= taskData:getId()) then 
            table.remove(self.linkTaskArr, k)
            break
        end
    end
end 

function TriggerNpcData:checkInFluencesNPC(taskData)
    if(taskData == nil) then return false end

    local fluenceNPC = taskData:getInfluencesNPC()
    if(fluenceNPC) then 
        for k,npcID in ipairs(fluenceNPC) do 
            if(self:getId() == npcID) then 
                return true
            end
        end
    end

    return false
end

function TriggerNpcData:checkInTemplateID(taskData)
    if(taskData == nil) then return false end

    if((self:getId() == taskData:getTouchOffNPCID() or self:getId() == taskData:getCompleteNPCID())) then 
        return true 
    end

    local fluenceNPC = taskData:getInfluencesNPC()
    if(fluenceNPC) then 
        for k,npcID in ipairs(fluenceNPC) do 
            if(self:getId() == npcID) then 
                return true
            end
        end
    end

    return false
end

function TriggerNpcData:getComeUpChat()
    local taskArr = self:_getInfluencesTaskArr()
    if(taskArr) then 
        for k,taskData in ipairs(taskArr) do 
            local speakArr = taskData:getSpeakArr()
            for k, speak in ipairs(speakArr) do 
                if(speak:getNpcID() == self:getId() and speak:checkComeUpSpeakType()) then 
                    self._chatInternal = taskData:getSpeakInternal()
                    return speak, taskData
                end
            end
        end
    end

    return nil, nil
end

function TriggerNpcData:getClickChat()
    local taskArr = self:_getInfluencesTaskArr()
    if(taskArr) then 
        for k,taskData in ipairs(taskArr) do 
            local speakArr = taskData:getSpeakArr()
            for k, speak in ipairs(speakArr) do 
                if(speak:getNpcID() == self:getId() and speak:checkClickSpeakType()) then 
                    return speak, taskData
                end
            end
        end
    end

    return nil, nil
end

function TriggerNpcData:getClickTaskData()
    local taskArr = self:_getLinkTaskArr()
    if(taskArr) then 
        for k,taskData in ipairs(taskArr) do 
            if(self:getId() == taskData:getCompleteNPCID()) then 
                return taskData
            end
        end
    end

    return nil
end

function TriggerNpcData:_getInfluencesTaskArr()
    local nowArr = {}
    local taskArr = TaskDataManager:getAllCycleTaskArr()
    if(taskArr) then 
        for k, taskData in ipairs(taskArr) do 
            if self:checkInFluencesNPC(taskData) then 
                table.insert(nowArr, taskData)
            end
        end
    end

    local taskArr = TaskDataManager:getAllDistortedSpaceTaskArr()
    if(taskArr) then 
        for k, taskData in ipairs(taskArr) do 
            if self:checkInFluencesNPC(taskData) then 
                table.insert(nowArr, taskData)
            end
        end
    end

    return nowArr
end 

function TriggerNpcData:_getLinkTaskArr()
    local nowArr = {}
    local taskArr = TaskDataManager:getAllCycleTaskArr()
    if(taskArr) then 
        for k, taskData in ipairs(taskArr) do 
            if self:checkInTemplateID(taskData) then 
                table.insert(nowArr, taskData)
            end
        end
    end

    local taskArr = TaskDataManager:getAllDistortedSpaceTaskArr()
    if(taskArr) then 
        for k, taskData in ipairs(taskArr) do 
            if self:checkInTemplateID(taskData) then 
                table.insert(nowArr, taskData)
            end
        end
    end

    return nowArr
end 

-- 获取触发尺寸
function TriggerNpcData:getOccupySize()
    if(self:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
        return self.triggerRange
    else
        return self.occupySize
    end
end

-- 获取效果类型， 这里目前用于客户端做临时效果表现
function TriggerNpcData:getTrapEffectType()
    return self.effectType
end

function TriggerNpcData:getTrapType()
    return self.trapType
end
-- 获取触发NPC气泡半径
function TriggerNpcData:getTalkRange()
    return self.talkRange
end

function TriggerNpcData:getTalkDuration()
    return self.talkDuration
end

function TriggerNpcData:getGuideTalkDucation()
    return self.guideTalkDuration
end

function TriggerNpcData:getLockFuncTip()
    return self.lockFuncTip
end

function TriggerNpcData:getLockFuncTipTime()
    return self.lockFuncTipTime
end

-- 获取气泡的位置
function TriggerNpcData:getInformationLocation()
    return self.informationLocation
end

-- 获取NPC 气泡的状态
function TriggerNpcData:getNPCInfomationStatus()
    return self._npcInfomationStatus
end

-- 设置npc 气泡的状态
function TriggerNpcData:setNPCInfomationStatus(status)
    -- print("TriggerNpcData:setNPCInfomationStatus ", status)
    self._npcInfomationStatus = status
end

-- 获取聊天多语言
function TriggerNpcData:getChatRoom()
    return self.chatRoom
end

-- 获取信息功能
function TriggerNpcData:getInformationFunction()
    return self.informationFunction
end

-- 获取Z轴基准点
function TriggerNpcData:getZOrderBasePoint()
    return self.ZOrderBasePoint
end

-- 获取是否有抖动
function TriggerNpcData:getHitFeedBack()
    if(self:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
        return self.hitFeedBack
    else 
        return 0
    end
end

-- 屏幕抖动
function TriggerNpcData:getHitShake()
    if(self:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
        return self.hitShake
    else 
        return 0
    end 
end

-- 定帧时间
function TriggerNpcData:getHitFreeze()
    if(self:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
        return self.hitFreeze/ TIME_UNIT
    else 
        return 0
    end
end

-- 获取是否为装饰陷阱
function TriggerNpcData:getIsDecoretionTrap()
    if(self:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
        if(self.decorationType == 1) then
            return true
        else 
            return false
        end
    else 
        return false
    end
end

-- 判断是否可以重新触发
function TriggerNpcData:judgeNPCInfomationTrigger()
    if(self._npcInfomationStatus) then
        return false
    end 

    if(self._npcInfomationTriggerTime == nil) then
        return true
    end 

    if(AvalonUtil:getCurrentTime() - self._npcInfomationTriggerTime >= self.chatInterval) then
        return true
    end

    return false
end

function TriggerNpcData:setNpcGuideInfomationFlag(flag)
    self._guideInfomationFlag = flag
end

function TriggerNpcData:setFunctionBtnInformationFlag(flag)
    self._functionBtnInfomationFlag = flag
end

function TriggerNpcData:setNPCInfomationTriggerTime()
    self._npcInfomationTriggerTime = AvalonUtil:getCurrentTime()
    self._npcChatTriggerWaitingTime = 0
end

function TriggerNpcData:getIsTriggerAutoSpeaking()
    if(self._chatData) then 
        return true 
    end

    return false
end

function TriggerNpcData:triggerTime(dt) 
    if(self._guideInfomationFlag) then 
        return false, nil
    end

    if(self._functionBtnInfomationFlag) then 
        return false, nil
    end

    if(self._npcInfomationTriggerTime) then
        if(AvalonUtil:getCurrentTime() - self._npcInfomationTriggerTime < self.chatInterval) then
            return false, nil
        end
    end 

    -- print("TriggerNpcData:triggerTime", dt, self._npcChatTriggerWaitingTime,  self._chatInternal)
    self._npcChatTriggerWaitingTime = self._npcChatTriggerWaitingTime + dt
    if(self._npcChatTriggerWaitingTime >= self._chatInternal) then 
        self._npcChatTriggerWaitingTime = 0

        -- add by zp 1.4.0 环形任务添加
        local speak, taskData = self:getComeUpChat()
        local txt = nil
        local time = nil
        if(speak and taskData)then
            txt = speak:getRandomText()
            time = taskData:getShowTime()
        end

        if(txt and time) then
            -- speak:triggerShow()
            return true, txt
        end

        self._chatInternal = math.random(self._chatData.timeMin, self._chatData.timeMax) /1000
        local language = self._chatData.languageArr[math.random(1, #self._chatData.languageArr)]

        return true,language
    end

    return false, nil
end

function TriggerNpcData:_getNPCType()
    return self.NPCType
end

-- 获取npc的类型（小地图专用）
function TriggerNpcData:getTypeForMinimap()
    -- if self:isMonsterNpc() then
    --     return "ui_minimap_icon_boss02.png"
    -- end
    return self.miniMapShow
end

function TriggerNpcData:setGuildBossData(guildBossData)
    self.guildBossData = guildBossData
    if(guildBossData) then
        self:setMonsterId(guildBossData:getBossID())
    end
end

function TriggerNpcData:getGuildBossData()
    return self.guildBossData
end

function TriggerNpcData:setMonsterId(monsterId)
    -- print("TriggerNpcData:setMonsterId", monsterId)
    self._monsterData = Data.MonsterData:create(monsterId, PublicDefine.CAVE_MODE.MODE_GUILD_BOSS, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
end

function TriggerNpcData:isMonsterNpc()
    -- if self:hasFunction(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_GUILDBOSS) then
    --     return true
    -- end
    return false
end

function TriggerNpcData:getMonsterNpcData()
    return self._monsterData
end


-- 获取话痨表现
function TriggerNpcData:getChat()
    -- body
    return self.chat
end

-- 获取新场景npc 未解锁的提示语言
function TriggerNpcData:getUnlockNotice()
    -- body
    return self.UnlockNotice
end

-- 获取是否需要判断解救逻辑
function TriggerNpcData:wasCheckResuce()
    if( self:_getNPCType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR
        and self:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.CAVE_TO_TOWN ) then 
            return true
        end

    return false
end

function TriggerNpcData:getIsUnlock()
    if(not self._allFunctionType) then 
        self:_handleSelectType()
    end

    if self._allFunctionType then 
        local unlockArr = FunctionUnlockManager:getInstance():checkNpcFunction(self._allFunctionType)
        if(unlockArr and #unlockArr > 0) then 
            return true
        end
    end

    return false
end

function TriggerNpcData:getAllFunctionType()
    if(not self._allFunctionType) then 
        self:_handleSelectType()
    end

    return self._allFunctionType
end

function TriggerNpcData:getSelectData()
    if(not self._selectFuntionData) then 
        self:_handleSelectType()
    end

    return self._selectFuntionData
end

function TriggerNpcData:_handleSelectType()
    local selectType = self.selectType
    if(selectType) then
        local LanguageManager = require "app.game.LanguageManager"
        local functionChoiceArr = {}
        local allFunctionType = {}
        local stringArr = string.split(selectType,";")
        for k,v in ipairs(stringArr) do
            local oneArr = string.split(v, ":")

            local data = {}
            data.title = LanguageManager:getInstance():getLocalString(tonumber(oneArr[1]))
            data.functionArr = {}
            if(oneArr[2]) then
                local functionArr = string.split(oneArr[2], ",")
                for k1,v1 in ipairs(functionArr) do 
                    local oneData = {}
                    oneData.functionType = tonumber(v1)
                    oneData.functionIconData = ConfigManager:getFunctionNPCButtonByFunctionType(oneData.functionType)

                    table.insert(allFunctionType, oneData.functionType)
                    table.insert(data.functionArr, oneData)
                end
            end
            table.insert(functionChoiceArr, data)
        end
        self._selectFuntionData = functionChoiceArr
        self._allFunctionType = allFunctionType
    end
end

function TriggerNpcData:getTouchRect()
    if(self.touchRectArr == nil) then 
        local str = self.ClickArea
        local pointStrArr = string.split(str, ";")
        local pointArr = {}
        if(pointStrArr and #pointStrArr > 0) then 
            for k,v in ipairs(pointStrArr) do 
                local coordArr = string.split(v, ",")
                table.insert(pointArr, {x=tonumber(coordArr[1]), y=tonumber(coordArr[2])})
            end
        end
        self.touchRectArr = pointArr
    end

    return self.touchRectArr
end

--[[
    设置新的场景的相关数据
    data:{index=1}
]]
function TriggerNpcData:setNewSceneData(data)
    self._newSceneData = data
end

function TriggerNpcData:getNewSceneData()
    return self._newSceneData
end

function TriggerNpcData:getNpcIndex()
    if self._newSceneData then 
        return self._newSceneData.index or 0
    end

    return 0
end