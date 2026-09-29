-- TaskData.lua
-- Author: zp
-- 2017-6-5
-- 任务数据结构

require "app.datas.GameData"
require "app.utils.PlaceholderUtil"
require "app.ui.baglayer.TaskLayer.TaskLayer"
local LanguageManager = require("app.game.LanguageManager")
local TaskType = PublicDefine.TaskType
local TaskStatus = PublicDefine.TaskStatus


------------------------------------开始定义任务处理逻辑-------------------------------------------

local TaskSpeak = class("TaskSpeak")
function TaskSpeak:ctor()
    self.npcID = 0
    self.speakType = 1          -- 1 走进，2 触碰
    self.showType = 1           -- 1 NPC头上， 2 调用对话框
    self.textArr = {}           -- 逻辑字段

    self.triggerMaxNum = -1
    self.triggerNum = 0
end

function TaskSpeak:initData(npcID, speakType, showType, textArr, views)
    self.npcID = npcID
    self.speakType = speakType          
    self.showType = showType          
    self.textArr = textArr    
    if(views and type(views) == "number") then 
        self.triggerMaxNum = tonumber(views)
    else 
        self.triggerMaxNum = -1
    end
end

function TaskSpeak:getNpcID()
    return self.npcID
end

function TaskSpeak:checkComeUpSpeakType()
    if(self.speakType == 1) then 
        return true 
    end

    return false
end

function TaskSpeak:checkClickSpeakType()
    if(self.speakType == 2) then 
        return true 
    end

    return false
end

function TaskSpeak:getRandomText()
    if(self.triggerMaxNum == -1 or self.triggerMaxNum > self.triggerNum) then 
        return self.textArr[math.random(1, #self.textArr)]
    else 
        return nil
    end
end

function TaskSpeak:triggerShow() 
    self.triggerNum = self.triggerNum + 1
end

------------------------------------开始定义任务-------------------------------------------

-- 任务数据
local TaskData = class("TaskData",GameData.Base)

Data = Data or {}
Data.TaskData = TaskData

-- private:

-- 构造函数(会自动调用)  
function TaskData:ctor(taskID, taskUIType, jumpID)
    TaskData.super.ctor(self, Category.TASK)

    self.taskID = taskID
    self.reachNum = 0
    self.isBetter = false
    self.isFinish = false
    self.status = TaskStatus.TaskStatus_Normal

    -- 收集值
    self.collectArr = {}

    self.taskSpeakArr = {}

    self.taskDataType = nil
    --print("TaskData-->: ", taskUIType)
    if taskUIType then
        self.taskDataType = taskUIType
    end

    self.jumpID = 0
    if jumpID then
        self.jumpID = jumpID
    end

    self:conbinationLocalData()
end

function TaskData:getId()
    return self.taskID
end

function TaskData:getTouchOffNPCID()
    -- return self.touchOffNPC
    return self.targetID
end

function TaskData:getCompleteNPCID()
    return self.completeNPC
end

function TaskData:getInfluencesNPC()
    return self.influencesNPC
end

function TaskData:getSpeakArr()
    return self.taskSpeakArr
end

function TaskData:getSpeakInternal()
    if(self.playInterval and #self.playInterval == 2) then 
        return math.random(tonumber(self.playInterval[1]), tonumber(self.playInterval[2]))
    end 

    return 999999999
end 

function TaskData:getShowTime()

    return self.showTime
end 

-- 获取已经完成数量
function TaskData:getReachNum()
    return self.reachNum
end

-- 获取该任务是否奖励钻石
function TaskData:getIsDiamond()
    return self.isBetter
end

function TaskData:isNormalState()
    -- return self.isFinish
    if(self.status == TaskStatus.TaskStatus_Normal) then
        if(self:_checkAchievementIsFinish()) then 
            return false
        end

        if(self:_checkGuestIsFinish()) then 
            return false
        end

        return true
    else
        return false
    end
end

-- 获取是否完成
function TaskData:getIsFinish()
    -- return self.isFinish
    if(self.status == TaskStatus.TaskStatus_IsFinish) then
        return true
    else
        if(self:_checkAchievementIsFinish()) then 
            return true
        end

        if(self:_checkGuestIsFinish()) then 
            return true
        end

        return false
    end
end

function TaskData:_checkGuestIsFinish()
    if(self.status == TaskStatus.TaskStatus_Normal) then
        if(self:getTargetType() == PublicDefine.TaskTargetType.Bind) then 
            local SdkBox = require("utils.sdkbox.SdkBox")
            if(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) then 
                local gameLoginManager = require("app.game.GameLoginManager")
                local currentVersionAccount = checkint(gameLoginManager:getInstance():getVersionAccount())
                if PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST ~= currentVersionAccount then 
                    return true
                end
            elseif (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_ADS) and not SdkBox:getInstance():isGuest() then 
                return true
            end
        end
    end

    return false
end

function TaskData:_checkAchievementIsFinish()
    if(self.status == TaskStatus.TaskStatus_Normal) then
        if(self:getTargetType() == PublicDefine.TaskTargetType.Achievement) then 
            return MasterDataManager:isFinishAchevementData(self.targetID)
        end
    end

    return false
end

-- 是否可以直接完成，不用点击领取
function TaskData:getIsDirectCompletion()
    if(self.isDirectCompletion == nil or self.isDirectCompletion == 0) then
        return false
    end

    return true
end

function TaskData:getCollectArr()
    return self.collectArr
end

function TaskData:getNpcScale()
    return self.NpcScale / RATIO_NUMBER
end

function TaskData:getOffSet()
    return self.offSet
end

-- 获取是否已经领取
function TaskData:getIsReceived()
    if(self.status == TaskStatus.TaskStatus_IsReceived) then
        return true
    else
        return false
    end
end

-- 获取任务类型  详见 TaskType 定义
function TaskData:getTaskType()
    return self.taskType
end

-- 获取任务目标类型  详见 TaskTargetType 定义
function TaskData:getTargetType()
    return self.type
end

-- 获取是否显示
function TaskData:getIsShowView()
    if(self:isCycle()) then 
        if(self:getTargetType() == PublicDefine.TaskTargetType.Collect 
            or self:getTargetType() == PublicDefine.TaskTargetType.Kill
            or self:getTargetType() == PublicDefine.TaskTargetType.Talk 
            or self:getTargetType() == PublicDefine.TaskTargetType.Achievement) then 
            
            return true 
        end 
    end

    return false
end

-- 获取任务状态
function TaskData:getStatus()
    if(self:_checkAchievementIsFinish()) then 
        return TaskStatus.TaskStatus_IsFinish
    end

    if(self:_checkGuestIsFinish()) then 
        return TaskStatus.TaskStatus_IsFinish
    end

    return self.status
end

-- 判断是否为日常任务
function TaskData:isDaily()
    if self.taskType == TaskType.Daily then
        return true
    end

    return false
end

-- 判断是否为主线
function TaskData:isThread()
    if self.taskType == TaskType.Plot then
        return true
    end

    return false 
end

-- 判断是否为公会任务
function TaskData:isGuild()
    if self.taskType == TaskType.Guild then
        return true
    end

    return false 
end

-- 判断是否为每日限制任务
function TaskData:isLimitDaily()
    if self.taskType == TaskType.LimitDaily then
        return true
    end

    return false 
end

-- 判断是否为英雄模式任务
function TaskData:isHeroCave()
    if self.taskType == TaskType.CaveHero then
        return true
    end
    return false 
end

-- 判断是否为环形任务
function TaskData:isCycle()
    if self.taskType == TaskType.Cycle then
        return true
    end

    return false 
end

-- 判断是否为扭曲空间任务
function TaskData:isDistortedSpace()
    if self.taskType == TaskType.DistortedSpace then
        return true
    end

    return false 
end

-- 判断是否为后扭曲空间（深红炼狱）任务
function TaskData:isInferno()
    if self.taskType == TaskType.Inferno then
        return true
    end

    return false 
end

-- 判断是否为虚空秘境任务
function TaskData:isVoidRift()
    if self.taskType == TaskType.VoidRift then
        return true
    end

    return false 
end

-- 判断是否为维京时代任务
function TaskData:isViKing()
    if self.taskType == TaskType.Viking then
        return true
    end

    return false 
end

-- 判断是否为永冬裂缝任务
function TaskData:isEverWinter()
    if self.taskType == TaskType.EverWinterRift then
        return true
    end

    return false 
end

-- 判断是否为大航海港口任务
function TaskData:isBigSailPort()
    if self.taskType == TaskType.BIGSAILPORT then
        return true
    end

    return false 
end

-- 判断是否为大航海港口任务
function TaskData:isChaos()
    if self.taskType == TaskType.Chaos then
        return true
    end

    return false 
end

-- 判断是否为虫洞深处任务
function TaskData:isWormhole()
    if self.taskType == TaskType.Wormhole then
        return true
    end

    return false 
end

function TaskData:getTargetID()
    return self.targetID
end

-- 获取名字
function TaskData:getName()
    return self.name
end

-- 获取描述
function TaskData:getDescription()
    return self.description
end

-- 获取描述
function TaskData:getStory()
    return self.story
end


-- 获取统计类型
function TaskData:getCountType()
    return self.countType
end

-- 获取任务总数量
function TaskData:getTargetNum()
    return self.targetNum
end

-- 获取奖励物品列表
function TaskData:getRewardGoodsArr()

    return self._rewardGoodsArr
end

-- 获取奖励钻石
function TaskData:getRewardDiamond()
    if(self:isDaily()) then
        if(self.isBetter) then
            return self.crystalRewards
        end
        return 0
    else
        return self.crystalRewards
    end
end

-- 获取奖励金币
function TaskData:getRewardGold()
    return self.goldRewards
end

-- 获取奖励经验
function TaskData:getRewardEXP()
    return self.EXPRewards
end

-- 获取奖励经验
function TaskData:getJumpId()
    return self.jumpID
end

-- 初始化网络数据
function TaskData:initNet(mesData)
    -- 根据网络数据初始化
    local oldTaskID = self.taskID
    self.taskID = mesData.taskID or -1

    self.reachNum = mesData.reachNum
    self.isBetter = mesData.isBetter
    self.isFinish = mesData.isFinish
    self.status = mesData.status

    self:triggerAutoCompletion()

    if oldTaskID ~= mesData.taskID then
        self:conbinationLocalData()
    end

    -- 初始化搜集的进度
    if(self:getTaskType() == PublicDefine.TaskType.Cycle) then 
        if(self:getTargetType() == PublicDefine.TaskTargetType.Collect) then 
            local ProtobufUtil = require "utils.ProtobufUtil"
            local countData = ProtobufUtil:decode("TaskSystem.CollectExtendData", mesData.extend)
            if(DEBUG) then
                print("ActivityData handleRandomShop",countData)
            end
            if(countData and countData.reachNum and #countData.reachNum > 0) then 
                for k,v in ipairs(countData.reachNum) do 
                    if(self.collectArr[k]) then
                        self.collectArr[k].reachNum = tonumber(v)
                    end
                end
            end
        end
    end
end

function TaskData:updateCount(data)
    for k,v in ipairs(data.reachNum) do 
        if(self.collectArr[k]) then
            self.collectArr[k].reachNum = tonumber(v)
        end
    end

    if(data.isOver) then 
        if(self:isNormalState()) then
            self:setStatus(TaskStatus.TaskStatus_IsFinish)
        end
    end
end

function TaskData:setStatus(status)
    self.status = status
    self:triggerAutoCompletion()
end

function TaskData:triggerAutoCompletion()
    -- add by zp 1.4.0 环形任务
    if(self:getIsFinish() and self:getIsDirectCompletion()) then 
        print("TaskDataManager:handleTaskChange ", self:getId())
        Net.NetTaskSystem:submitTaskRequest(self:getId())
    end
end 

function TaskData:initLocal(data)
    if not data then
        return 
    end

    if self.taskID ~= data.taskID then
        self:setLocalConfigData(data)
        self:_refreshData()
    end
end

function TaskData:conbinationLocalData()
    if (self.taskID ~= -1) and self.taskDataType ~= UI.TaskLayerType.TASKLAYER_PORT then
        local data = ConfigManager:getTaskConfigForTaskID(self.taskID)
        if(data == nil) then 
            printError("TaskData:conbinationLocalData not found task config.   taskID=", self.taskID)
            return 
        end
        -- for k,v in pairs(data) do 
        --     self[k] = v
        -- end
        self:setLocalConfigData(data)
        self:_refreshData()
    else
        local data = ConfigManager:getNavigationTaskByID(self.taskID)
        if(data == nil) then 
            printError("TaskData:conbinationLocalData not found task config.   taskID=", self.taskID)
            return 
        end
        -- for k,v in pairs(data) do 
        --     self[k] = v
        -- end
        self.taskType = PublicDefine.TaskType.BigSailPort
        self:setLocalConfigData(data)
        self:_refreshData()
    end
end

-- 刷新数据
function TaskData:_refreshData()
    self.name = nil
    if self.targetID ~= 0 and self.name then
        local name = PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(self.name),self.targetID)
        if(name) then
            name = string.format( name,self.targetNum)
            self.name = name
        else 
            self.name = ""
        end
    else
        if self.name then
            self.name = LanguageManager:getInstance():getLocalString(self.name)
        else
            self.name = ""
        end
    end
    
    self.description = nil

    -- --日常任务描述单独处理
    if self.type == PublicDefine.TaskTargetType.KillMonster then
        if self.description then
            self.description = string.format(LanguageManager:getInstance():getLocalString(self.description), self:getExtendValue(),self:getExtendValue2())
        end
    else
        if self.targetID ~= 0 and self.description then
            local description = PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(self.description),self.targetID)
            description = string.format( description,self.targetNum)
            self.description = description
        else
            if self.description then
                self.description = LanguageManager:getInstance():getLocalString(self.description)
            else
                self.description = ""
            end
        end
    end

    
    

    self.story = nil
    if self.targetID ~= 0 and self.story then
        local story = PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(self.story),self.targetID)
        story = string.format( story,self.targetNum)
        self.story = story
    else
        if self.story then
            self.story = LanguageManager:getInstance():getLocalString(self.story)
        else
            self.story = ""
        end
    end

    -- 处理奖励物品
    self._rewardGoodsArr = {}
    if(self.goodsRewards and self.goodsRewardsNum) then 
        for i=1,#self.goodsRewards do
            local goodsData = GoodsDataManager:createLocalGoodsData(self.goodsRewards[i])
            if (goodsData) then
                goodsData:setNum(self.goodsRewardsNum[i])
                -- 这里默认给点金
                goodsData:setIsGolden(true)

                table.insert(self._rewardGoodsArr, goodsData)
            end
        end
    else 
        printError("TaskData:_refreshData goodsRewards is nil. taskID=", self.taskID)
    end

    if self.taskType ~= PublicDefine.TaskType.BigSailPort or (not self.taskType) then
        self.taskType = TaskDataManager:getTaskTypeForTaskID(self.taskID)
    end
    -- self.taskType = TaskDataManager:getTaskTypeForTaskID(self.taskID)

    self.taskSpeakArr = {}
    if(self.influencesNPC and self.speakType and self.showType and self.dialougeTxt and self.views) then
        local fluenArr = self.influencesNPC
        local speakType = self.speakType
        local showType = self.showType
        local dialougeTxt = self.dialougeTxt
        local views = self.views
        local dialougeArr = string.split(dialougeTxt, ";")

        if(#fluenArr == #speakType and #speakType == #showType and #showType == #dialougeArr) then 
            for k, npcID in ipairs(fluenArr) do  
                local diaArr = string.split(dialougeArr[k], ",")
                if(diaArr and #diaArr >0 ) then 
                    local taskSpeak = TaskSpeak:create()
                    taskSpeak:initData(npcID, speakType[k], showType[k], diaArr, views[k])

                    table.insert(self.taskSpeakArr, taskSpeak)
                end
            end
        end
    else 
        printError("TaskData:_refreshData influencesNPC is nil. taskID=", self.taskID)
    end 

    -- 收集
    self.collectArr = {}
    if(self.collectValue and self.collectNum) then 
        local collectValue = self.collectValue
        local collectNum = self.collectNum
        if(collectValue and collectNum and #collectNum > 0) then 
            local collectArr = string.split(collectValue, ";")
            if(#collectArr == #collectNum) then 
                for k,v in ipairs(collectArr) do 
                    local oneCollect = {}
                    oneCollect.goodsIDArr = {}
                    oneCollect.goodsNum = collectNum[k]
                    oneCollect.reachNum = 0

                    local ids = string.split(v, ",")
                    if(ids) then 
                        for k,v in ipairs(ids) do 
                            table.insert(oneCollect.goodsIDArr, tonumber(v))
                        end
                    end 

                    table.insert(self.collectArr, oneCollect)
                end
            else
                printError("TaskData:_refreshData collectNum and collectValue dont match.", self.taskID)
            end
        end
    else  
        printError("TaskData:_refreshData influencesNPC is nil. taskID=", self.taskID)
    end
end

function TaskData:getExtendValue()
    return self.extendValue
end

function TaskData:getExtendValue2()
    return self.extendValue2
end

-- 判断提交任务的道具是否被锁住
function TaskData:checkIsLockCollectItem()
    if(self.collectValue and self.collectNum) then 
        local collectValue = self.collectValue
        local collectNum = self.collectNum
        if(collectValue and collectNum and #collectNum > 0) then 
            local collectArr = string.split(collectValue, ";")
            if(#collectArr == #collectNum) then 
                for k,v in ipairs(collectArr) do 

                    local oneCollect = {}
                    oneCollect.goodsIDArr = {}
                    oneCollect.goodsNum = collectNum[k]
                    oneCollect.reachNum = 0

                    local ids = string.split(v, ",")
                    if(ids) then 
                        for k,v in ipairs(ids) do 
                            local itemData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, tonumber(v), false, 0)
                            if itemData and itemData:getIsLock() then
                                return true
                            end                    
                        end
                    end 
                end
            else
                return false
            end
        end
    else  
        return false
    end
end