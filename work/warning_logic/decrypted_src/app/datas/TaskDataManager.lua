-- TaskDataManager.lua
-- Author: zp
-- 2017-6-5
-- 任务系统数据管理

require "app.config.ConfigManager"
require "app.datas.task.TaskData"

local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local ProtobufUtil = require("utils.ProtobufUtil")

local DEBUG = false

local CAVE_MODE = PublicDefine.CAVE_MODE
local CAVE_DIFFICULTY = PublicDefine.CAVE_DIFFICULTY
local CONST_DEFINITION = PublicDefine.CONST_DEFINITION
local TaskType = PublicDefine.TaskType

TaskDataManager = TaskDataManager or {}

function TaskDataManager:init()
    -- TODO 初始化任务数据
    
    -- 完成任务ID map taskID:taskID
    self._completeTaskIDMap = {}
    -- 是否初始化了任务
    self._initTask = false
    -- 当前任务列表 {taskData}
    self._taskDataArr = {}

    -- 还没有刷出的主线任务
    self._threadThool = nil
    -- 还没有刷出的环任务
    self._cycleArr = nil

    self.newTaskFlag = {} --新任务标识
    self.followTime = {} --关注类型 任务触发的时间标记

    self.updateExpeditionMode = nil
    self.updateExpeditionCheckPoint = nil

    --日常任务完成次数
    self.dailyTaskFinishedNum = 0
end

function TaskDataManager:clear()
    table.clear(self._completeTaskIDMap)
    table.clear(self._taskDataArr)
    self._initTask = false
    self._threadThool = nil
    self._cycleArr = nil
    self.newTaskFlag = {} --新任务标识
    self.updateExpeditionMode = nil
    self.updateExpeditionCheckPoint = nil
end

function TaskDataManager:refreshTaskDataMessage(data)
    if (data.dailyTaskFinishedNum) then
        self.dailyTaskFinishedNum = data.dailyTaskFinishedNum
    end
end

function TaskDataManager:getHaveMonthDay()
    local heroData = RoleDataManager:getMaster()
    local currentDay = heroData:getRefreshDay() or 0
    local monthCardDay = heroData:getMonthCardDay() or 0
    local day = monthCardDay - currentDay

    print("  daydaydayday =====  ",day, monthCardDay, currentDay)
    if (day > 0) then
        return true
    else
        return false
    end
end

-- 进入下一层清理数据
function TaskDataManager:nextFloorClear()

end

-- 回档（恢复）清理数据
function TaskDataManager:restoreClear()
    -- TODO 回档（恢复）清理数据
    self._taskDataArr = {}
    self._initTask = false
    self._threadThool = nil
    self._cycleArr = nil
     self.newTaskFlag = {}--新任务标识
end

-- 根据 PK和spriteID 清理数据
function TaskDataManager:clearDataForPKANDSpriteID(pk, spriteID)

end

function TaskDataManager:clearUpdateExpeditionData()
    self.updateExpeditionMode = nil
    self.updateExpeditionCheckPoint = nil
end

function TaskDataManager:getUpdateExpeditionData()
    return self.updateExpeditionMode, self.updateExpeditionCheckPoint
end

-- 设置任务为可以触发
function TaskDataManager:enableTaskTrigger()
    self._initTask = true
end

-- 清理掉公会任务
function TaskDataManager:clearGuildTask()
    for i=#self._taskDataArr,1,-1 do
        local taskData = self._taskDataArr[i]
        if(taskData and taskData:isGuild()) then
            table.remove(self._taskDataArr, i)
        end
    end
end

-- 获取是否有任务完成
function TaskDataManager:getHaveTaskComplete()
    local haveComplete = false
    for _,taskData in ipairs(self._taskDataArr) do
        if(taskData:getIsFinish()) then
            haveComplete = true
            break
        end
    end

    return haveComplete
end

-- 获取是否有非（公会+循环）任务完成 
function TaskDataManager:getHaveNoGuildTaskComplete()
    for k, taskData in pairs(self._taskDataArr) do
        if(not taskData:isGuild() 
            and not taskData:isCycle() 
            and not taskData:isDistortedSpace() 
            and not taskData:isInferno() 
            and not taskData:isVoidRift() 
            and not taskData:isViKing()
            and not taskData:isEverWinter() 
            and not taskData:isChaos()
            and not taskData:isWormhole()
            and taskData:getIsFinish()) then
            return true
        end
    end

    return false
end

-- 获取是否有公会完成任务
function TaskDataManager:getHaveGuildTaskComplete()
    for k, taskData in pairs(self._taskDataArr) do
        if(taskData:isGuild() and taskData:getIsFinish()) then
            return true
        end
    end

    return false
end

-- 获取是否有任务完成 (不算工会任务)
function TaskDataManager:getTaskHaveCompleteNum()
    local number = 0
    for _,taskData in ipairs(self._taskDataArr) do
        if(taskData:getIsFinish() and not taskData:isGuild()) then
            number = number + 1
        end
    end
    return number
end


-- 获取当前任务列表
function TaskDataManager:getNowTaskArr()
    if(DEBUG) then
        print("TaskDataManager:getNowTaskArr")
        dump(self._taskDataArr)
    end

    return self._taskDataArr
end

-- 获取所有的公会任务
function TaskDataManager:getAllGuildTaskArr()
    local guildArr = {}
    for k, taskData in pairs(self._taskDataArr) do
        if(taskData:isGuild()) then
            table.insert(guildArr, taskData)
        end
    end

    return guildArr
end

-- 获取所有的环形任务
function TaskDataManager:getAllCycleTaskArr()
    local guildArr = {}
    for k, taskData in pairs(self._taskDataArr) do
        if(taskData:isCycle()) then
            table.insert(guildArr, taskData)
        end
    end

    return guildArr
end

-- 获取所有的扭曲空间任务
function TaskDataManager:getAllDistortedSpaceTaskArr()
    local guildArr = {}
    for k, taskData in pairs(self._taskDataArr) do
        if(taskData:isDistortedSpace()) then
            table.insert(guildArr, taskData)
        end
    end

    return guildArr
end

function TaskDataManager:getDistortedSpaceTaskByLevel(levelId)
    local taskList = self:getAllDistortedSpaceTaskArr()
    for k, taskData in pairs(taskList) do
        if taskData.taskGroupID == levelId then
            return taskData
        end
    end
end

-- 获取所有的扭曲空间任务
function TaskDataManager:getAllInfernoTaskArr()
    local guildArr = {}
    for k, taskData in pairs(self._taskDataArr) do
        -- print("getAllInfernoTaskArr", taskData:getId(), taskData:isInferno())
        if(taskData:isInferno()) then
            table.insert(guildArr, taskData)
        end
    end

    return guildArr
end

function TaskDataManager:getInfernoTaskByLevel(levelId)
    local taskList = self:getAllInfernoTaskArr()
    for k, taskData in pairs(taskList) do
        if taskData:getExtendValue() == levelId then
            return taskData
        end
    end

    return nil
end

-- 获取所有的虚空秘境任务
function TaskDataManager:getAllVoidRiftTaskArr()
    local guildArr = {}
    for k, taskData in pairs(self._taskDataArr) do
        -- print("getAllVoidRiftTaskArr", taskData:getId(), taskData:isInferno())
        if(taskData:isVoidRift()) then
            table.insert(guildArr, taskData)
        end
    end

    return guildArr
end

function TaskDataManager:getVoidRiftTaskByLevel(levelId)
    local taskList = self:getAllVoidRiftTaskArr()
    for k, taskData in pairs(taskList) do
        if taskData:getExtendValue() == levelId then
            return taskData
        end
    end

    return nil
end

-- 获取所有的维京时代任务
function TaskDataManager:getAllViKingTaskArr()
    local guildArr = {}
    for k, taskData in pairs(self._taskDataArr) do
        -- print("getAllViKingTaskArr", taskData:getId(), taskData:isInferno())
        if(taskData:isViKing()) then
            table.insert(guildArr, taskData)
        end
    end

    return guildArr
end

function TaskDataManager:getViKingTaskByLevel(levelId)
    local taskList = self:getAllViKingTaskArr()
    for k, taskData in pairs(taskList) do
        if taskData:getExtendValue() == levelId then
            return taskData
        end
    end

    return nil
end

-- 获取所有的永冬裂缝任务
function TaskDataManager:getAllEverWinterTaskArr()
    local guildArr = {}
    for k, taskData in pairs(self._taskDataArr) do
        -- print("getAllEverWinterTaskArr", taskData:getId(), taskData:isInferno())
        if(taskData:isEverWinter()) then
            table.insert(guildArr, taskData)
        end
    end

    return guildArr
end

function TaskDataManager:getEverWinterTaskByLevel(levelId)
    local taskList = self:getAllEverWinterTaskArr()
    for k, taskData in pairs(taskList) do
        if taskData:getExtendValue() == levelId then
            return taskData
        end
    end

    return nil
end

-- 获取所有的混沌虫洞任务
function TaskDataManager:getAllChaosTaskArr()
    local guildArr = {}
    for k, taskData in pairs(self._taskDataArr) do
        -- print("getAllChaosTaskArr", taskData:getId(), taskData:isInferno())
        if(taskData:isChaos()) then
            table.insert(guildArr, taskData)
        end
    end

    return guildArr
end

function TaskDataManager:getChaosTaskByLevel(levelId)
    local taskList = self:getAllChaosTaskArr()
    for k, taskData in pairs(taskList) do
        if taskData:getExtendValue() == levelId then
            return taskData
        end
    end

    return nil
end

-- 获取一个可以接取得主任务
function TaskDataManager:getOneAccepteThreadTaskID(completeTaskID)
    local userArr = self:getAcceptThreadTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取环线任务
function TaskDataManager:getOneAccepteCycleTaskID(completeTaskID)
    local userArr = self:getAcceptCycleTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取扭曲空间任务
function TaskDataManager:getOneAccepteDistortedSpaceTaskID(completeTaskID)
    local userArr = self:getAcceptDistortedSpaceTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取深红炼狱任务
function TaskDataManager:getOneAccepteInfernoTaskID(completeTaskID)
    local userArr = self:getAcceptInfernoTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取深红炼狱任务
function TaskDataManager:getOneAccepteVoidRiftTaskID(completeTaskID)
    local userArr = self:getAcceptVoidRiftTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取维京时代任务
function TaskDataManager:getOneAccepteViKingTaskID(completeTaskID)
    local userArr = self:getAcceptViKingTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取永冬裂缝任务
function TaskDataManager:getOneAccepteEverWinterTaskID(completeTaskID)
    local userArr = self:getAcceptEverWinterTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取混沌虫洞任务
function TaskDataManager:getOneAccepteChaosTaskID(completeTaskID)
    local userArr = self:getAcceptChaosTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取虫洞深处任务
function TaskDataManager:getOneAccepteWormholeTaskID(completeTaskID)
    local userArr = self:getAcceptWormholeTask(completeTaskID)
    if(userArr and #userArr > 0) then
        return userArr[1].taskID
    end

    return nil
end

-- 获取一个可以接取日常任务
function TaskDataManager:getOneAccepteDailyTaskID()
    if self:dailyTaskCanRefresh() then
        local userArr = self:getAccepteDailyTaskArr()
        if(userArr and #userArr > 0) then
            userArr = table.shuffle(userArr)
            return userArr[1].taskID
        end
    end
    return nil
end

function TaskDataManager:dailyTaskCanRefresh()
    local can = false
    --每日最大日常任务刷新数量
    local maxNum = tonumber(ConfigManager:getGeneralForKey("dailyCrystalTaskNum"))
    local heroData = GameDataManager:getInstance():getMaster()
    if heroData ~= nil and self:getHaveMonthDay() then
        maxNum = maxNum + 1
    end

    can = self.dailyTaskFinishedNum < maxNum

    return can
end

function TaskDataManager:getDailyTaskRestAmount()
    --当天还可以接取日常任务的数量
    local maxNum = tonumber(ConfigManager:getGeneralForKey("dailyCrystalTaskNum"))
    local heroData = GameDataManager:getInstance():getMaster()
    if heroData ~= nil and self:getHaveMonthDay() then
        maxNum = maxNum + 1
    end

    return maxNum - self.dailyTaskFinishedNum
end

-- 获取一个可以接取公会任务
function TaskDataManager:getOneAccepteGuildTaskID()
    local master = RoleDataManager:getMaster()
    if(master and master.guildTaskDailyFinishNum < 3) then
        local userArr = self:getAccepteGuildTaskArr()
        if(userArr and #userArr >0) then
            userArr = table.shuffle(userArr)
            return userArr[1].taskID
        end
    end

    return nil
end

-- 获取一个可以接取每日限制任务
function TaskDataManager:getOneAccepteLimitDailyTaskID()
    local master = RoleDataManager:getMaster()
    if(master and master.dailyLimitTaskAcceptNum < 3) then
        local userArr = self:getAccepteLimitDailyTaskArr()
        if(userArr and #userArr >0) then
            userArr = table.shuffle(userArr)
            return userArr[1].taskID
        end
    end

    return nil
end

-- 获取一个可以接取英雄模式任务
function TaskDataManager:getOneAccepteHeroCaveTaskID()
    local master = RoleDataManager:getMaster()
    if(master and master.heroCaveTaskDailyAcceptNum < 2) then
        local userArr = self:getAccepteHeroCaveTaskArr()
        if(userArr and #userArr >0) then
            userArr = table.shuffle(userArr)
            return userArr[1].taskID
        end
    end

    return nil
end


-- 刷新任务排序
function TaskDataManager:refreshTaskRank()
    local saveTaskArr = self:_getSaveTaskArr()

    local mainArr = {}
    local dailyArr = {}
    local guildArr = {}
    local heroCaveArr = {}
    local cycleArr = {}
    local limitDaily = {}
    local distortedSpaceArr = {}
    local infernoArr = {}
    local voidRiftArr = {}
    local viKingArr = {}
    local everWinterArr = {}
    local chaosArr = {}
    local wormholeArr = {}
    for _,taskData in ipairs(self._taskDataArr) do
        if(taskData:isDaily()) then
            table.insert(dailyArr, taskData)
        elseif taskData:isThread() then
            table.insert(mainArr, taskData)
        elseif taskData:isGuild() then
            table.insert(guildArr, taskData)
        elseif taskData:isHeroCave() then
            table.insert(heroCaveArr, taskData)
        elseif taskData:isCycle() then
            table.insert(cycleArr, taskData)
        elseif taskData:isLimitDaily() then
            table.insert(limitDaily, taskData)
        elseif taskData:isDistortedSpace() then
            table.insert(distortedSpaceArr, taskData)
        elseif taskData:isInferno() then
            table.insert(infernoArr, taskData)
        elseif taskData:isVoidRift() then
            table.insert(voidRiftArr, taskData)
        elseif taskData:isViKing() then
            table.insert(viKingArr, taskData)
        elseif taskData:isEverWinter() then
            table.insert(everWinterArr, taskData)
        elseif taskData:isChaos() then
            table.insert(chaosArr, taskData)
        elseif taskData:isWormhole() then
            table.insert(wormholeArr, taskData)
        end
    end

    if(DEBUG) then
        print("TaskDataManager:refreshTaskRank  pre")
        dump(self._taskDataArr)
    end

    self._taskDataArr = {}

    -- 环线任务
    for k, taskData in ipairs(cycleArr) do
         table.insert(self._taskDataArr, taskData)
    end

    -- 处理主线任务
    for k, taskData in ipairs(mainArr) do
         table.insert(self._taskDataArr, taskData)
    end

    -- 深红炼狱个人任务
    for k, taskData in ipairs(infernoArr) do
        table.insert(self._taskDataArr, taskData)
    end

    -- 虚空秘境个人任务
    for k, taskData in ipairs(voidRiftArr) do
        table.insert(self._taskDataArr, taskData)
    end

    -- 维京时代个人任务
    for k, taskData in ipairs(viKingArr) do
        table.insert(self._taskDataArr, taskData)
    end

    -- 永冬裂缝个人任务
    for k, taskData in ipairs(everWinterArr) do
        table.insert(self._taskDataArr, taskData)
    end

    -- 混沌虫洞个人任务
    for k, taskData in ipairs(chaosArr) do
        table.insert(self._taskDataArr, taskData)
    end

    -- 虫洞深处个人任务
    for k, taskData in ipairs(wormholeArr) do
        table.insert(self._taskDataArr, taskData)
    end

    -- 处理日常任务
    for k, taskData in ipairs(dailyArr) do
         table.insert(self._taskDataArr, taskData)
    end

    -- 公会任务
    for k, taskData in ipairs(guildArr) do
         table.insert(self._taskDataArr, taskData)
    end

    -- 英雄模式任务
    for k, taskData in ipairs(heroCaveArr) do
         table.insert(self._taskDataArr, taskData)
    end

    -- 每日限制任务
    for k, taskData in ipairs(limitDaily) do
         table.insert(self._taskDataArr, taskData)
    end

    -- 扭曲空间个人任务
    for k, taskData in ipairs(distortedSpaceArr) do
        table.insert(self._taskDataArr, taskData)
    end

    if(DEBUG) then
        print("TaskDataManager:refreshTaskRank  end")
        dump(self._taskDataArr)
    end

    self:_refreshAllTaskSave()
end

-- 根据任务ID获取任务类型
function TaskDataManager:getTaskTypeForTaskID(taskID)
    if (taskID >= 20000 and taskID < 30000) then
        return TaskType.Plot
    elseif (taskID >= 30000 and taskID < 40000) then
        return TaskType.Daily
    elseif (taskID >= 40000 and taskID < 50000) then
        return TaskType.Guild
    elseif (taskID >= 50000 and taskID < 60000) then
        return TaskType.CaveHero
    elseif (taskID >= 60000 and taskID < 70000) then
        return TaskType.Cycle
    elseif (taskID >= 70000 and taskID < 80000) then
        return TaskType.LimitDaily
    elseif (taskID >= 80000 and taskID < 90000) then
        return TaskType.DistortedSpace
    elseif (taskID >= 90000 and taskID < 100000) then
        return TaskType.Inferno
    elseif (taskID >= 100000 and taskID < 110000) then
        return TaskType.VoidRift
    elseif (taskID >= 110000 and taskID < 120000) then
        return TaskType.Viking
    elseif (taskID >= 120000 and taskID < 130000) then
        return TaskType.EverWinterRift
    elseif (taskID >= 1 and taskID < 100) then
        return TaskType.BigSailPort
    elseif (taskID >= 130000 and taskID < 140000) then
        return TaskType.Chaos
    elseif (taskID >= 150000 and taskID < 160000) then
        return TaskType.Wormhole
    else
        printError(string.format("taskID=%d no define taskType.", taskID))
    end

    return nil
end

-- 触发接取任务
function TaskDataManager:triggerAcceptTask()
    if(self._initTask) then 
        self:_triggerAcceptTask()
    end
end

---------------------------------以下为处理网络数据--------------------------------

-- 处理初始化
function TaskDataManager:handleInitTask(data)
    if(data == nil) then return end
    self._taskDataArr = {}
    self._initTask = true
    if(data ~= "") then
        for _,task in pairs(data.task) do
            if(task.taskID ~= 0) then
                -- 剔除重复数据
                local found = false
                for _,taskData in pairs(self._taskDataArr) do
                    if(taskData:getId() == task.taskID) then
                        found = true
                        break
                    end
                end

                if(found == false) then
                    if(ConfigManager:getTaskConfigForTaskID(task.taskID)) then 
                        local taskData = Data.TaskData:create(task.taskID)
                        taskData:initNet(task)
                        table.insert(self._taskDataArr,taskData)
                    else 
                        printError("TaskDataManager:handleInitTask not found task config. taskID=", task.taskID)
                    end
                end
            end
        end
    end

    -- -- TODO 添加测试模式任务
    -- local taskData = Data.TaskData:create(60002)
    -- -- taskData:initNet({})
    -- table.insert(self._taskDataArr,taskData)

    self:refreshTaskRank()

    -- 把任务下发到NPC的列表里面
    self:handleTriggerInitTriggerNpc()

    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    -- self:_triggerAcceptTask()
end

function TaskDataManager:handleTriggerInitTriggerNpc()
    for k,taskData in ipairs(self._taskDataArr) do 
        self:addTaskDataTrigger(taskData)
    end
end

function TaskDataManager:addTaskDataTrigger(taskData)
    if(taskData and taskData:isCycle()) then 
        local triggerNpcArr = RoleDataManager:getTriggerNpcArr()
        if(triggerNpcArr) then 
            for k, triggerNpc in ipairs(triggerNpcArr) do  
                triggerNpc:addTaskData(taskData)
            end
        end
    end

    if(taskData and taskData:isDistortedSpace()) then 
        local triggerNpcArr = RoleDataManager:getTriggerNpcArr()
        if(triggerNpcArr) then 
            for k, triggerNpc in ipairs(triggerNpcArr) do  
                triggerNpc:addTaskData(taskData)
            end
        end
    end
end

function TaskDataManager:removeTaskDataTrigger(taskData)
    if(taskData and taskData:isCycle()) then 
        local triggerNpcArr = RoleDataManager:getTriggerNpcArr()
        if(triggerNpcArr) then 
            for k, triggerNpc in pairs(triggerNpcArr) do  
                triggerNpc:removeTaskData(taskData)
            end
        end
    end

    if(taskData and taskData:isDistortedSpace()) then 
        local triggerNpcArr = RoleDataManager:getTriggerNpcArr()
        if(triggerNpcArr) then 
            for k, triggerNpc in pairs(triggerNpcArr) do  
                triggerNpc:removeTaskData(taskData)
            end
        end
    end
end

-- 处理已经完成任务处理
function TaskDataManager:handleCompleteTask(data)
    if(data == nil) then return end 
    
    if(data ~= "") then
        for _,taskID in ipairs(data.taskID) do 
            self._completeTaskIDMap[taskID] = taskID;
        end
    end
    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end

-- 处理删除任务
function TaskDataManager:handleDeleteTask(data)
    -- 处理删除任务
    if(data == nil or data == "") then return end 

    for _,taskID in pairs(data.taskID) do
        for key,taskData in pairs(self._taskDataArr) do
            if(taskData:getId() == taskID) then
                table.remove(self._taskDataArr, key)
                self:removeTaskDataTrigger(taskData)

                self:_removeTaskFromSave(taskData)
                Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_DELETE_TASK, taskData)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
                break
            end
        end
    end

    self:_triggerAcceptTask()
end

-- 处理接受任务返回值
function TaskDataManager:handleAcceptTask(data)
    -- 处理接受任务
    if(data == nil) then return end

    if data ~= "" then
        for _,task in pairs(data.task) do
            local taskType = self:getTaskTypeForTaskID(task.taskID)
            if(taskType == TaskType.Guild) then
                local master = RoleDataManager:getMaster()
                if(master) then 
                    master.guildTaskDailyFinishNum = master.guildTaskDailyFinishNum + 1
                else 
                    -- 这里接收到该消息的时机不对
                    printError("The time to receive the message is not right.")
                end
            end
            if(taskType == TaskType.LimitDaily) then
                local master = RoleDataManager:getMaster()
                if(master) then 
                    master.dailyLimitTaskAcceptNum = master.dailyLimitTaskAcceptNum + 1
                else 
                    -- 这里接收到该消息的时机不对
                    printError("The time to receive the message is not right.")
                end
            end


            local found = false
            local foundTaskData = nil
            for _,taskData in pairs(self._taskDataArr) do
                if(taskData:getId() == task.taskID) then
                    found = true
                    taskData:initNet(task)
                    foundTaskData = taskData
                    break
                end
            end

            if(found == false and task.replaceTaskID ~= 0) then
                for _,taskData in pairs(self._taskDataArr) do
                    if(taskData:getId() == task.replaceTaskID) then
                        found = true
                        taskData:initNet(task)
                        foundTaskData = taskData
                        break
                    end
                end
            end

            if(found == false) then
                if(ConfigManager:getTaskConfigForTaskID(task.taskID)) then 
                    local taskData = Data.TaskData:create(task.taskID)
                    taskData:initNet(task)
                    table.insert(self._taskDataArr,taskData)

                    self:addTaskDataTrigger(taskData)

                    self.newTaskFlag[task.taskID] = 1
                    self:refreshTaskRank()

                    Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_ADD_TASK, taskData)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
                else 
                    printError("TaskDataManager:handleAcceptTask not found task config. taskID=", task.taskID)
                end
            else 
                if(foundTaskData) then 
                    self:addTaskDataTrigger(foundTaskData)
                end 
            end
        end
    end
end

-- 处理完成任务返回
function TaskDataManager:handleCompleteTaskResponse(data)
    if (data.result == "TaskType_Succeed" or data.result == "TaskType_TaskRewarded") then
        local completeTaskID = data.taskID
        local completeTask = nil
        local removeKey = nil
        for k, taskData in pairs(self._taskDataArr) do
            if(taskData:getId() == completeTaskID) then
                completeTask = taskData

                -- 客户端添加主线任务完成
                if(completeTask 
                    and (completeTask:isThread() or completeTask:isCycle() 
                        or completeTask:isDistortedSpace()
                        or completeTask:isInferno()
                        or completeTask:isVoidRift()
                        or completeTask:isViKing()
                        or completeTask:isEverWinter()
                        or completeTask:isChaos()
                        or completeTask:isWormhole()) and data.result ~= "TaskType_TaskRewarded") then
                    self._completeTaskIDMap[completeTask:getId()] = completeTask:getId()
                end

                -- 判断是否属于任务数据
                if(completeTask:isGuild()) then
                    completeTask:setStatus(PublicDefine.TaskStatus.TaskStatus_IsReceived)
                    if(data.task) then
                        local task = data.task
                        if(task.taskID ~= 0) then
                            table.remove(self._taskDataArr, k)
                            self:removeTaskDataTrigger(taskData)
                            removeKey = k
                        end
                    end
                else
                    table.remove(self._taskDataArr, k)
                    self:removeTaskDataTrigger(taskData)
                    removeKey = k
                end
                break
            end
        end

        local newTask = nil
        if(data.task and removeKey) then
            local task = data.task
            -- local taskData = Data.TaskData:create(task.taskID)
            if(task.taskID ~= 0) then
                -- newTask = clone(completeTask)
                if(ConfigManager:getTaskConfigForTaskID(task.taskID)) then 
                    newTask = Data.TaskData:create(task.taskID)
                    newTask:initNet(task)

                    if(newTask:isGuild()) then
                        local master = RoleDataManager:getMaster()
                        if(master) then
                            master.guildTaskDailyFinishNum = master.guildTaskDailyFinishNum + 1
                        end
                    end
                    
                    table.insert(self._taskDataArr,removeKey,newTask)
                    self:addTaskDataTrigger(newTask)
                    self.newTaskFlag[task.taskID] = 1
                    self:_refreshAllTaskSave()
                else 
                    printError("TaskDataManager:handleCompleteTaskResponse not found task config. taskID=", task.taskID)
                end
            end
        end

        -- 处理获得的奖励
        local rewardData = {}
        rewardData.gold = data.gold
        rewardData.diamond = data.diamond
        rewardData.exp = data.exp

        rewardData.goods = {}
        if data.rewardGoods then
            local rewardGoods = data.rewardGoods
            for i=1, #rewardGoods do
                local rewardGood = rewardGoods[i]
                -- 判断数据是否有
                local goodsData = GoodsDataManager:createLocalGoodsData(rewardGood.goodsID)
                if(goodsData) then
                    goodsData:setNum(rewardGood.num)
                    goodsData:setIsGolden(true)

                    table.insert(rewardData.goods,goodsData)
                end
            end
        end

        -- 任务完成后得通知消息
        local completeData = {}
        -- 获取的奖励数据
        completeData.rewardData = rewardData
        -- 完成的任务
        completeData.completeTask = completeTask
        -- 接取的任务
        completeData.accepteTask = newTask
        Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_COMPLETE_TASK, completeData)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        self:_triggerAcceptTask()

        if(completeTask and completeTask:isThread() and data.result ~= "TaskType_TaskRewarded") then
            self:showCommentLayer()
        end
        self:refreshFinishTaskFlag()
    end
    if (data.result ~= "TaskType_Succeed") then
        GameErrorManager:showError(ProtobufUtil:enum_id("TaskSystem.CompleteTaskResultType",data.result))            
    end
end

function TaskDataManager:showCommentLayer()
    if self:isFinishAllThreadTask() then
        local SdkManager = require"app.game.SdkManager"
        SdkManager:checkCommentEvent(COMMENT_TYPE.FINISH_ALL_MAIN_TASK)
    end
end

-- 处理任务改变
function TaskDataManager:handleTaskChange(data)
    -- 处理任务改变
    local task = data.task
    for _,taskData in pairs(self._taskDataArr) do
        if (taskData:getId() == task.taskID) then
            taskData:initNet(task)
            
            --  发送任务改变消息
            Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_CHANGE_TASK, taskData)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
            return taskData
        end
    end

    dump(data)
    printError("Client and server task data are out of sync.")

    return nil
end

function TaskDataManager:handleTaskCollect(data) 
    for _,taskData in pairs(self._taskDataArr) do
        if (taskData:getId() == data.taskID) then
            taskData:updateCount(data)

            return taskData
        end
    end
end

function TaskDataManager:handleTaskRefresh(data) 
    for _,taskData in pairs(self._taskDataArr) do
        if (taskData:getId() == data.taskID) then
            if(ConfigManager:getTaskConfigForTaskID(data.replaceTask.taskID)) then 
                local newTask = Data.TaskData:create(data.replaceTask.taskID)
                newTask:initNet(data.replaceTask)
                table.remove( self._taskDataArr, _)
                table.insert(self._taskDataArr, _, newTask)
                return newTask
            end 

            return nil
        end
    end

    return nil
end

function TaskDataManager:handleSaveMaxLevel()
    -- print("TaskDataManager:handleSaveMaxLevel")
    local heroData = RoleDataManager:getMaster()
    if heroData then
        -- add by zp 佣兵模式不保存进度
        if(TeamDataManager:hasMercenaryTeam()) then 
            return
        end

        local SceneManager = require("app.game.SceneManager")
        if (GameMapManager:getInstance():getUpdateCheckPT() or 
            (SceneManager:getInstance():isInDungeon() and not SceneManager:getInstance():isInBlackHouse())) then 
            local mapData = GameMapManager:getInstance():getMapData()
            local caveMode = mapData.caveMode
            local difficult = mapData.difficulty
            local level = mapData.level

            local caveLevel = GameDataManager:_getCaveLevel(caveMode, level)
            print("TaskDataManager:handleSaveMaxLevel  caveMode, difficult, level, caveLevel=", caveMode, difficult, level, caveLevel)
            
            if(caveMode == PublicDefine.CAVE_MODE.MODE_HERO) then 
                heroData:updateHeroCaveStageMaxLevel(caveLevel)
            end

            if(caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then 
                heroData:updateTitanHeroCaveStageMaxLevel(caveLevel)
            end

            local maxLevelData = heroData:getMaxLevelData(caveMode, difficult)
            if(maxLevelData) then
                if maxLevelData:getMaxLevel() < caveLevel then
                    maxLevelData:setMaxLevel(caveLevel)
                    -- print("TaskDataManager=",caveMode, caveLevel, RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Expedition))
                    -- add by zp 处理在城镇里面处理弹出提示是否同步探险队最新进度
                    -- 判断是否解锁了下一个模式
                    local nextCaveMode = ToolsUtil:getNextCaveMode(caveMode)
                    if(nextCaveMode == nil) then 
                        return 
                    end
                    local breakFlag = false
                    if(nextCaveMode ~= caveMode ) then 
                        local nowCheckPoint = heroData:getCheckpointData(nextCaveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
                        if(nowCheckPoint and nowCheckPoint:getCheckpoint() > 0) then 
                            breakFlag = true
                        end
                    end

                    if not breakFlag and difficult == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1 then
                        self.updateExpeditionMode = caveMode
                        self.updateExpeditionCheckPoint = mvc.expeditionModel:maxLevelCoverToCheckpoint(caveMode, caveLevel)
                    end
                end
            else
                print("TaskDataManager:handleSaveMaxLevel  not found maxLevelData")
            end
        end
    else
        -- printError("TaskDataManager:handleSaveMaxLevel  not found master")
    end
end

function TaskDataManager:_getCaveLevel(caveMode, level)
    -- add by zp 这里需要在外部判定不是在小黑屋
    if(caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON) then 
        return level
    end
    local SceneManager = require("app.game.SceneManager")

    if(level >= CONST_DEFINITION.CAVE_LEVEL_MIN and level <= CONST_DEFINITION.CAVE_LEVEL_MAX) then
        return level
    elseif (level >= CONST_DEFINITION.BOSS_LEVEL_MIN and level <= CONST_DEFINITION.BOSS_LEVEL_MAX) then
        if( SceneManager:getInstance():checkModeIsNewCave(caveMode)) then
            return (level - CONST_DEFINITION.BOSS_LEVEL_MIN + 1)  * BOSS_DISTORTED_SPACE_INTERVAL
        else
            return (level - CONST_DEFINITION.BOSS_LEVEL_MIN + 1)  * BOSS_INTERVAL
        end
    elseif (level >= CONST_DEFINITION.SHOP_LEVEL_MIN and level <= CONST_DEFINITION.SHOP_LEVEL_MAX) then
        -- add by zp 这里为了和服务器处理方式保持一致，只要进入第一个商店层，就把leve 强制设置成1
        -- return (level - CONST_DEFINITION.SHOP_LEVEL_MIN)  * SHOP_INTERVAL
        if(level == CONST_DEFINITION.SHOP_LEVEL_MIN) then 
            return 1
        end

        return (level - CONST_DEFINITION.SHOP_LEVEL_MIN)  * SHOP_INTERVAL
    end
    return 0
end

---------------------------------以上为处理网络数据--------------------------------
function TaskDataManager:_refreshAllTaskSave()
    self:_removeAllTaskFromSave()
    for _, taskData in ipairs(self._taskDataArr) do
        self:_addTaskToSave(taskData)
    end
end

-- 获取所有保存的任务列表
function TaskDataManager:_getSaveTaskArr()
    local globalData = self:_getGlobalData()
    if(globalData) then
        return globalData:getAcceptTaskArr()
    end

    return {}
end

-- 添加一个任务保存列表
function TaskDataManager:_addTaskToSave(taskData)
    local globalData = self:_getGlobalData()
    if(globalData) then
        return globalData:addTask(taskData)
    end
end

-- 从保存任务列表删除一个任务
function TaskDataManager:_removeTaskFromSave(taskData)
    local globalData = self:_getGlobalData()
    if(globalData) then
       globalData:removeTask(taskData)
    end
end

-- 清理掉所有保存任务列表
function TaskDataManager:_removeAllTaskFromSave()
    local globalData = self:_getGlobalData()
    if(globalData) then
       globalData:clearAllTaskData()
    end
end

-- 获取全局存储消息
function TaskDataManager:_getGlobalData()
    local GameDataManager = require("app.game.GameDataManager")
    return Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
end

-- 触发接新任务
function TaskDataManager:_triggerAcceptTask()
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Task) == false then 
        return
    end

    -- 在玩家未初始化的时候不应该触发任务的刷新
    -- TODO 这里需要对于触发任务的接取做一个好的方案
    local master = RoleDataManager:getMaster()
    if(master == nil) then 
        return 
    end

    local SceneManager = require("app.game.SceneManager")
    if SceneManager:getInstance():isInStory() then 
        return
    end

    -- 处理是否需要接新的任务
    local mainArr = {}
    local dailyArr = {}
    local guildArr = {}
    local heroCaveArr = {}
    local limitDailyArr = {}

    for _,taskData in ipairs(self._taskDataArr) do
        if(taskData:isDaily()) then
            table.insert(dailyArr, taskData)
        elseif taskData:isThread() then
            table.insert(mainArr, taskData)
        elseif taskData:isGuild() then
            table.insert(guildArr, taskData)
        elseif taskData:isHeroCave() then
            table.insert(heroCaveArr, taskData)
        elseif taskData:isLimitDaily() then
            table.insert(limitDailyArr, taskData)
        end
    end

    -- 判断主线任务是否需要接
    local maxThreadNum = 3
    if(#mainArr < maxThreadNum) then
        local userArr = self:getAcceptThreadTask()
        if #userArr > 0 then
            -- 处理主线刷新
            local acceptTaskIDArr = {}
            for i=1,maxThreadNum-#mainArr do
                if(#userArr >= i) then
                    table.insert(acceptTaskIDArr, userArr[i].ID)
                end
            end

            -- 发送主线任务刷新请求
            Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
        else 
            -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
        end
    end

    -- 处理环线任务的接取
    local userArr = self:getAcceptCycleTask()
    if #userArr > 0 then
        -- 处理主线刷新
        local acceptTaskIDArr = {}
        for k, task in ipairs(userArr) do
            table.insert(acceptTaskIDArr, task.ID)
        end

        -- 发送环线任务刷新请求
        Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    -- 处理扭曲空间任务的接取
    local userArr = self:getAcceptDistortedSpaceTask()
    print("DistortedSpace userNum=", #userArr)
    if #userArr > 0 then
        -- 处理主线刷新
        local acceptTaskIDArr = {}
        for k, task in ipairs(userArr) do
            table.insert(acceptTaskIDArr, task.ID)
        end

        -- 发送扭曲空间任务刷新请求
        print("DistortedSpace", acceptTaskIDArr)
        Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    -- 处理扭曲空间任务的接取
    local userArr = self:getAcceptInfernoTask()
    print("Inferno userNum=", #userArr)
    if #userArr > 0 then
        -- 处理主线刷新
        local acceptTaskIDArr = {}
        for k, task in ipairs(userArr) do
            table.insert(acceptTaskIDArr, task.ID)
        end

        -- 发送扭曲空间任务刷新请求
        print("Inferno", acceptTaskIDArr)
        Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    -- 处理虚空秘境任务的接取
    local userArr = self:getAcceptVoidRiftTask()
    print("VoidRift userNum=", #userArr)
    if #userArr > 0 then
        -- 处理主线刷新
        local acceptTaskIDArr = {}
        for k, task in ipairs(userArr) do
            table.insert(acceptTaskIDArr, task.ID)
        end

        -- 发送虚空秘境任务刷新请求
        print("VoidRift", acceptTaskIDArr)
        Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    -- 处理维京时代任务的接取
    local userArr = self:getAcceptViKingTask()
    print("Viking userNum=", #userArr)
    if #userArr > 0 then
        -- 处理主线刷新
        local acceptTaskIDArr = {}
        for k, task in ipairs(userArr) do
            table.insert(acceptTaskIDArr, task.ID)
        end

        -- 发送虚空秘境任务刷新请求
        print("Viking", acceptTaskIDArr)
        Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    -- 处理永冬裂缝任务的接取
    local userArr = self:getAcceptEverWinterTask()
    print("EverWinter userNum=", #userArr)
    if #userArr > 0 then
        -- 处理主线刷新
        local acceptTaskIDArr = {}
        for k, task in ipairs(userArr) do
            table.insert(acceptTaskIDArr, task.ID)
        end

        -- 发送虚空秘境任务刷新请求
        print("EverWinter", acceptTaskIDArr)
        Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    -- 处理混沌虫洞任务的接取
    local userArr = self:getAcceptChaosTask()
    print("Chaos userNum=", #userArr)
    if #userArr > 0 then
        -- 处理主线刷新
        local acceptTaskIDArr = {}
        for k, task in ipairs(userArr) do
            table.insert(acceptTaskIDArr, task.ID)
        end

        -- 发送虚空秘境任务刷新请求
        print("Chaos", acceptTaskIDArr)
        Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    -- 处理虫洞深处任务的接取
    local userArr = self:getAcceptWormholeTask()
    print("Wormhole userNum=", #userArr)
    if #userArr > 0 then
        -- 处理主线刷新
        local acceptTaskIDArr = {}
        for k, task in ipairs(userArr) do
            table.insert(acceptTaskIDArr, task.ID)
        end

        -- 发送虫洞深处任务刷新请求
        print("Wormhole", acceptTaskIDArr)
        Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    -- 日常任务接取
    local maxDailyNum = 4
    -- 判断日常任务是否需要接
    -- if(#dailyArr < maxDailyNum) then
    if self:dailyTaskCanRefresh() and (#dailyArr < maxDailyNum) then
        -- 获取那些任务可以刷新出来
        local userArr = self:getAccepteDailyTaskArr()

        if #userArr > 0 then
            local acceptTaskIDArr = {}

            local fNum = maxDailyNum - #dailyArr
            local rNum = self:getDailyTaskRestAmount()
            if fNum > rNum then
                fNum = rNum
            end

            -- for i=1, maxDailyNum - #dailyArr do
            for i=1, fNum do
                if(#userArr >= i) then
                    table.insert(acceptTaskIDArr, userArr[i].ID)
                end
            end

            -- 发送日常任务刷新请求
            Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr)
        else 
            -- print("TaskDataManager:_triggerAcceptTask 没有新日常任务可以接")
        end
    end

    if GameDataManager:getInstance():getIsJoinGuild() then
        local maxGuildNum = 3
        local master = RoleDataManager:getMaster()
        if(master and master.guildTaskDailyFinishNum < maxGuildNum) then
            -- 判断公会任务是否需要接
            local replaceArr = {}
            for k,taskData in pairs(guildArr) do 
                if(taskData:getIsReceived()) then
                    table.insert(replaceArr, taskData)
                end
            end

            if(#guildArr < maxGuildNum or #replaceArr > 0) then
                -- 获取那些任务可以刷新出来
                local userArr = self:getAccepteGuildTaskArr()
                -- print("TaskDataManager  _triggerAcceptTask", #userArr)
                if #userArr > 0 then
                    local acceptTaskIDArr = {}
                    local placeIDArr = {}

                    local addNum = maxGuildNum - #guildArr + #replaceArr
                    if(addNum > maxGuildNum - master.guildTaskDailyFinishNum) then
                        addNum = maxGuildNum - master.guildTaskDailyFinishNum
                    end
                    -- print("TaskDataManager  _triggerAcceptTask", addNum, master.guildTaskDailyFinishNum)

                    userArr = table.shuffle(userArr)
                    local size = #userArr
                    size = size < addNum and size or addNum
                    
                    local replaceNum = 0
                    if(#guildArr + size > maxGuildNum) then 
                        replaceNum = #guildArr + size - maxGuildNum
                    end

                    for i = 1, size do
                        table.insert(acceptTaskIDArr, userArr[i].ID)
                        if(#replaceArr >= i and replaceNum > 0) then  
                            replaceNum = replaceNum - 1                          
                            table.insert(placeIDArr, replaceArr[i].taskID)
                        else
                            table.insert(placeIDArr, 0)
                         end
                    end

                    -- 发送公会任务刷新请求
                    Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr, placeIDArr)
                else 
                    -- print("TaskDataManager:_triggerAcceptTask 没有新公会任务可以接")
                end
            end
        end
    end

    local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    if unLockHeroMode then
        local maxHeroNum = 2
        local master = RoleDataManager:getMaster()
        if(master and master.heroCaveTaskDailyAcceptNum < maxHeroNum) then
            -- 判断公会任务是否需要接
            local replaceArr = {}
            for k,taskData in pairs(heroCaveArr) do 
                if(taskData:getIsReceived()) then
                    table.insert(replaceArr, taskData)
                end
            end

            if(#heroCaveArr < maxHeroNum or #replaceArr > 0) then
                -- 获取那些任务可以刷新出来
                local userArr = self:getAccepteHeroCaveTaskArr()
                if #userArr > 0 then
                    local acceptTaskIDArr = {}
                    local placeIDArr = {}

                    local addNum = maxHeroNum - #heroCaveArr + #replaceArr
                    if(addNum > maxHeroNum - master.heroCaveTaskDailyAcceptNum) then
                        addNum = maxHeroNum - master.heroCaveTaskDailyAcceptNum
                    end
                    userArr = table.shuffle(userArr)
                    local size = #userArr
                    size = size < addNum and size or addNum
                    for i = 1, size do
                        table.insert(acceptTaskIDArr, userArr[i].ID)
                        if(#replaceArr >= i) then
                            table.insert(placeIDArr, replaceArr[i].taskID)
                        else
                            table.insert(placeIDArr, 0)
                        end
                    end
                    -- 发送公会任务刷新请求
                    Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr, placeIDArr)
                else 
                    -- print("TaskDataManager:_triggerAcceptTask 没有新公会任务可以接")
                end
            end
        end
    end

    local maxLimitDailyNum = 3
    local master = RoleDataManager:getMaster()
    -- print("dailyLimitTaskAcceptNum", master.dailyLimitTaskAcceptNum, maxLimitDailyNum)
    if(master and master.dailyLimitTaskAcceptNum < maxLimitDailyNum) then
        -- 判断公会任务是否需要接
        local replaceArr = {}
        for k,taskData in pairs(limitDailyArr) do 
            if(taskData:getIsReceived()) then
                table.insert(replaceArr, taskData)
            end
        end

        if(#limitDailyArr < maxLimitDailyNum or #replaceArr > 0) then
            -- 获取那些任务可以刷新出来
            local userArr = self:getAccepteLimitDailyTaskArr()
            -- print("dailyLimitTaskAcceptNum   333", #userArr)
            if #userArr > 0 then
                local acceptTaskIDArr = {}
                local placeIDArr = {}

                local addNum = maxLimitDailyNum - #limitDailyArr + #replaceArr
                if(addNum > maxLimitDailyNum - master.dailyLimitTaskAcceptNum) then
                    addNum = maxLimitDailyNum - master.dailyLimitTaskAcceptNum
                end

                local size = #userArr
                size = size < addNum and size or addNum
                for i = 1, size do
                    table.insert(acceptTaskIDArr, userArr[i].ID)
                    if(#replaceArr >= i) then                                
                        table.insert(placeIDArr, replaceArr[i].taskID)
                    else
                        table.insert(placeIDArr, 0)
                    end
                end
                -- print("dailyLimitTaskAcceptNum   333")
                -- 发送公会任务刷新请求
                Net.NetTaskSystem:accepTaskRequest(acceptTaskIDArr, placeIDArr)
            end
        end
    end
end

-- 获取接受的主线任务
function TaskDataManager:getAcceptThreadTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    local mainArr = {}
    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isThread() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}
    self._threadThool = ConfigManager:getAllThreadTask()

    -- 过滤已经完成
    self._threadThool = self:filterCompleteTask(self._threadThool, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end

    self._threadThool = self:filterCompleteTask(self._threadThool, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    for k,task in pairs(self._threadThool) do
        -- print("unlockLevel,preTaskID,level=",task.unlockLevel,task.preTaskID,level,self._completeTaskIDMap[table.preTaskID])
        if self:_checkUnlockLevel(task, level) then
            if(task.preTaskID ~= 0) then
                if(self._completeTaskIDMap[task.preTaskID] ~= nil) then
                    table.insert(userArr, task)
                end
            else
                table.insert(userArr, task)
            end
        end
    end

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    if #userArr > 0 then
        -- 对主线任务排序
        table.sort(userArr,function (a,b) 
            if(#a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
        
        --针对主线任务进行优先级排序
        table.sort(userArr,function (a,b) 
            return a.mainPriority < b.mainPriority
        end)

    else 
        -- print("TaskDataManager:_triggerAcceptTask 没有新得主线任务可以接")
    end

    return userArr
end

-- 获取可以接得日常任务
function TaskDataManager:getAccepteDailyTaskArr()
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    local dailyArr = {}
    for _,taskData in ipairs(self._taskDataArr) do
        if(taskData:isDaily()) then
            table.insert(dailyArr, taskData)
        end
    end

    -- 获取那些任务可以刷新出来
    local userArr = {}

    -- 计算当前可以刷新那个阶段的日常任务
    local groupID = GameDataManager:getInstance():getTaskGroupID()
    local level = RoleDataManager:getMaster():getLevel()
    local dailyConfigArr = ConfigManager:getDailyConfigForGroupID(groupID)
    if(dailyConfigArr) then
        userArr = self:_filterConditions(dailyConfigArr, dailyArr)
    end
    return userArr
end

-- 获取可以接得公会任务
function TaskDataManager:getAccepteGuildTaskArr()
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    local guildArr = {}

    for _,taskData in ipairs(self._taskDataArr) do
        if(taskData:isGuild()) then
            table.insert(guildArr, taskData)
        end
    end
    -- 获取那些任务可以刷新出来
    local userArr = {}
    -- 计算当前可以刷新那个阶段的任务
    local groupID = GameDataManager:getInstance():getTaskGroupID()
    if(DEBUG) then
        print("TaskDataManager:getAccepteGuildTaskArr groupID=", groupID)
    end

    local level = RoleDataManager:getMaster():getLevel()

    local guildConfigArr = ConfigManager:getGuildConfigForGroupID(groupID)
    -- print("TaskDataManager:getAccepteGuildTaskArr groupID=", groupID, #guildConfigArr)
    if(guildConfigArr) then
        userArr = self:_filterConditions(guildConfigArr, guildArr)
    end
    -- print("TaskDataManager:getAccepteGuildTaskArr groupID=", groupID, #userArr)

    return userArr
end

-- 获取可以截取的限制类任务
function TaskDataManager:getAccepteLimitDailyTaskArr()
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    local limitDailyArr = {}

    for _,taskData in ipairs(self._taskDataArr) do
        if(taskData:isLimitDaily()) then
            table.insert(limitDailyArr, taskData)
        end
    end

    -- 获取那些任务可以刷新出来
    local userArr = {}
    -- 计算当前可以刷新那个阶段的任务
    local groupID = GameDataManager:getInstance():getTaskGroupID()
    local guildConfigArr = ConfigManager:getLimitDailyConfigForGroupID(groupID)
    -- print("guildConfigArr=", #guildConfigArr)
    if(guildConfigArr) then
        userArr = self:_filterConditions(guildConfigArr, limitDailyArr)
    end

    return userArr
end

function TaskDataManager:_filterConditions(taskArr, filterArr)
    local userArr = {}
    if(taskArr) then 
        local level = 0
        local masterData = RoleDataManager:getMaster()
        if(masterData) then 
            level = masterData:getLevel()
        end
        for i= 1, #taskArr do
            local found = false
            local task = taskArr[i]
            if(filterArr) then 
                for j= 1, #filterArr do
                    if(task.ID == filterArr[j]:getId()) then
                        found = true
                        break
                    end
                end
            end

            if(found == false and self:_checkUnlockLevel(task, level)) then
                if(task.preTaskID ~= 0 or task.taskscenesID ~= 0) then
                    local addArrFlag = true
                    if(task.preTaskID ~= 0) then 
                        if(self._completeTaskIDMap[task.preTaskID] == nil) then
                            addArrFlag = false
                        end
                    end

                    if(task.taskscenesID ~= 0) then 
                        if(math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE
                            or math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_INFERNO
                            or math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_VOID_RIFT
                            or math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_VIKING
                            or math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT
                            or math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
                            or math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
                            or math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_CHAOS
                            or math.modf(task.taskGroupID/10000) == PublicDefine.CAVE_MODE.MODE_WORMHOLE ) then 
                            local taskGroupID = task.taskGroupID
                            local tenThreen = 10000
                            local mode = math.modf(taskGroupID/tenThreen)
                            taskGroupID = taskGroupID - mode * tenThreen
                            -- 这里由于扭曲空间把组合字段修改为了 mode*10000 + level * 100 + diffcult
                            local nowLevel = math.modf(taskGroupID/100)
                            local difficult = taskGroupID - nowLevel * 100
                            local maxLevelData = masterData:getMaxLevelData(mode, difficult)
                            if(maxLevelData) then 
                                if(maxLevelData:getMaxLevel() == 0) then 
                                    if task.taskscenesID ~= -1 then 
                                        addArrFlag = false
                                    end
                                else 
                                    if task.taskscenesID ~= maxLevelData:getMaxLevel() then 
                                        addArrFlag = false
                                    end
                                end
                            else
                                addArrFlag = false
                            end
                        else 
                            if(masterData and not masterData:checkCaveIndex(task.taskscenesID)) then 
                                addArrFlag = false
                            end
                        end
                    end

                    if(addArrFlag) then
                        table.insert(userArr, task)
                    end
                else
                    table.insert(userArr, task)
                end 
            end
        end
    end
    -- print("userArr=", userArr)
    userArr = table.shuffle(userArr)

    return userArr
end

-- 获取可以接得英雄模式任务
function TaskDataManager:getAccepteHeroCaveTaskArr()
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    local heroCaveArr = {}
    -- print("askDataManager:getAccepteHeroCaveTaskArr 1", #self._taskDataArr)
    for _,taskData in ipairs(self._taskDataArr) do
        if(taskData:isHeroCave() and not taskData:getIsReceived()) then
            table.insert(heroCaveArr, taskData)
        end
    end

    local userArr = {}

    local heroTaskList = ConfigManager:getAllCaveHeroTask()
    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(heroCaveArr) do
        table.insert(removeArr, taskData:getId())
    end
    heroTaskList = self:filterCompleteTask(heroTaskList, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()

    for k,task in pairs(heroTaskList) do
        if self:_checkUnlockLevel(task, level) then
            table.insert(userArr, task)
        end
    end
    return userArr
end

-- 获取接受的环线任务
function TaskDataManager:getAcceptCycleTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    local mainArr = {}
    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isCycle() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}

    self._cycleArr = ConfigManager:getAllCycleTask()

    -- 过滤已经完成
    self._cycleArr = self:filterCompleteTask(self._cycleArr, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end

    self._cycleArr = self:filterCompleteTask(self._cycleArr, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    -- print("TaskDataManager:getAcceptCycleTask 2-1 level=",level)
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    self._cycleArr = self:_filterConditions(self._cycleArr)

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    if #self._cycleArr > 0 then
        -- 对主线任务排序
        table.sort(self._cycleArr,function (a,b) 
            if(a.unlockLevel and b.unlockLevel and #a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
    end

    return self._cycleArr
end

-- 获取接受的扭曲空间
function TaskDataManager:getAcceptDistortedSpaceTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    -- print("TaskDataManager:getAcceptDistortedSpaceTask 0")
    local mainArr = {}
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace) == false then 
        return mainArr
    end

    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isDistortedSpace() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}
    local distortedSpaceArr = ConfigManager:getAllDistortedSpaceTask()
    -- 过滤已经完成
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    -- print("TaskDataManager:getAcceptDistortedSpaceTask 2-1 level=",level)
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    distortedSpaceArr = self:_filterConditions(distortedSpaceArr)

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    -- 根据扭曲空间开门事件来判断是否可以截取任务
    local userArr = {}
    for _,taskData in ipairs(distortedSpaceArr) do
        if(taskData.taskGroupID == 0) then
            table.insert(userArr, taskData)
        else
            local worldEventData = MasterDataManager:getWorldEventDataForID(taskData.taskGroupID) 
            if(worldEventData and worldEventData:getState() == PublicDefine.DistortedSpaceEventState.DistortedSpaceEventState_Opened) then 
                table.insert(userArr, taskData)
            end
        end
    end
    distortedSpaceArr = userArr

    if #distortedSpaceArr > 0 then
        -- 对任务排序
        table.sort(distortedSpaceArr,function (a,b) 
            if(a.unlockLevel and b.unlockLevel and #a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
    end

    return distortedSpaceArr
end


-- 获取接受的扭曲空间
function TaskDataManager:getAcceptInfernoTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    -- print("TaskDataManager:getAcceptInfernoTask 0")
    local mainArr = {}
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno) == false then 
        return mainArr
    end

    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isInferno() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}
    local distortedSpaceArr = ConfigManager:getAllInfernoTask()
    -- 过滤已经完成
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    -- print("TaskDataManager:getAcceptInfernoTask 2-1 level=",level)
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    distortedSpaceArr = self:_filterConditions(distortedSpaceArr)

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    -- 根据扭曲空间开门事件来判断是否可以截取任务
    local userArr = {}
    for _,taskData in ipairs(distortedSpaceArr) do
        if(taskData.taskGroupID == 0) then
            table.insert(userArr, taskData)
        else
            -- local worldEventData = MasterDataManager:getWorldEventDataForID(taskData.taskGroupID) 
            -- if(worldEventData and worldEventData:getState() == PublicDefine.DistortedSpaceEventState.DistortedSpaceEventState_Opened) then 
                table.insert(userArr, taskData)
            -- end
        end
    end
    distortedSpaceArr = userArr

    if #distortedSpaceArr > 0 then
        -- 对任务排序
        table.sort(distortedSpaceArr,function (a,b) 
            if(a.unlockLevel and b.unlockLevel and #a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
    end

    return distortedSpaceArr
end

-- 获取接受的虚空秘境任务
function TaskDataManager:getAcceptVoidRiftTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    -- print("TaskDataManager:getAcceptInfernoTask 0")
    local mainArr = {}
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) == false then 
        return mainArr
    end

    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isVoidRift() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}
    local distortedSpaceArr = ConfigManager:getAllVoidRiftTask()
    -- 过滤已经完成
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    -- print("TaskDataManager:getAcceptInfernoTask 2-1 level=",level)
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    distortedSpaceArr = self:_filterConditions(distortedSpaceArr)

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    -- 根据扭曲空间开门事件来判断是否可以截取任务
    local userArr = {}
    for _,taskData in ipairs(distortedSpaceArr) do
        if(taskData.taskGroupID == 0) then
            table.insert(userArr, taskData)
        else
            -- local worldEventData = MasterDataManager:getWorldEventDataForID(taskData.taskGroupID) 
            -- if(worldEventData and worldEventData:getState() == PublicDefine.DistortedSpaceEventState.DistortedSpaceEventState_Opened) then 
                table.insert(userArr, taskData)
            -- end
        end
    end
    distortedSpaceArr = userArr

    if #distortedSpaceArr > 0 then
        -- 对任务排序
        table.sort(distortedSpaceArr,function (a,b) 
            if(a.unlockLevel and b.unlockLevel and #a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
    end

    return distortedSpaceArr
end

-- 获取接受的维京时代任务
function TaskDataManager:getAcceptViKingTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    -- print("TaskDataManager:getAcceptInfernoTask 0")
    local mainArr = {}
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking) == false then 
        return mainArr
    end

    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isViKing() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}
    local distortedSpaceArr = ConfigManager:getAllViKingTask()
    -- 过滤已经完成
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    -- print("TaskDataManager:getAcceptInfernoTask 2-1 level=",level)
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    distortedSpaceArr = self:_filterConditions(distortedSpaceArr)

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    -- 根据扭曲空间开门事件来判断是否可以截取任务
    local userArr = {}
    for _,taskData in ipairs(distortedSpaceArr) do
        if(taskData.taskGroupID == 0) then
            table.insert(userArr, taskData)
        else
            -- local worldEventData = MasterDataManager:getWorldEventDataForID(taskData.taskGroupID) 
            -- if(worldEventData and worldEventData:getState() == PublicDefine.DistortedSpaceEventState.DistortedSpaceEventState_Opened) then 
                table.insert(userArr, taskData)
            -- end
        end
    end
    distortedSpaceArr = userArr

    if #distortedSpaceArr > 0 then
        -- 对任务排序
        table.sort(distortedSpaceArr,function (a,b) 
            if(a.unlockLevel and b.unlockLevel and #a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
    end

    return distortedSpaceArr
end

-- 获取接受的维京时代任务
function TaskDataManager:getAcceptEverWinterTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    -- print("TaskDataManager:getAcceptInfernoTask 0")
    local mainArr = {}
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_EverWinterRift) == false then 
        return mainArr
    end

    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isEverWinter() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}
    local distortedSpaceArr = ConfigManager:getAllEverWinterTask()
    -- 过滤已经完成
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    -- print("TaskDataManager:getAcceptInfernoTask 2-1 level=",level)
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    distortedSpaceArr = self:_filterConditions(distortedSpaceArr)

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    -- 根据扭曲空间开门事件来判断是否可以截取任务
    local userArr = {}
    for _,taskData in ipairs(distortedSpaceArr) do
        if(taskData.taskGroupID == 0) then
            table.insert(userArr, taskData)
        else
            -- local worldEventData = MasterDataManager:getWorldEventDataForID(taskData.taskGroupID) 
            -- if(worldEventData and worldEventData:getState() == PublicDefine.DistortedSpaceEventState.DistortedSpaceEventState_Opened) then 
                table.insert(userArr, taskData)
            -- end
        end
    end
    distortedSpaceArr = userArr

    if #distortedSpaceArr > 0 then
        -- 对任务排序
        table.sort(distortedSpaceArr,function (a,b) 
            if(a.unlockLevel and b.unlockLevel and #a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
    end

    return distortedSpaceArr
end

-- 获取接受的混沌虫洞任务
function TaskDataManager:getAcceptChaosTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    -- print("TaskDataManager:getAcceptInfernoTask 0")
    local mainArr = {}
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS) == false then 
        return mainArr
    end

    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isChaos() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}
    local distortedSpaceArr = ConfigManager:getAllChaosTask()
    -- 过滤已经完成
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    -- print("TaskDataManager:getAcceptInfernoTask 2-1 level=",level)
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    distortedSpaceArr = self:_filterConditions(distortedSpaceArr)

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    -- 根据扭曲空间开门事件来判断是否可以截取任务
    local userArr = {}
    for _,taskData in ipairs(distortedSpaceArr) do
        if(taskData.taskGroupID == 0) then
            table.insert(userArr, taskData)
        else
            -- local worldEventData = MasterDataManager:getWorldEventDataForID(taskData.taskGroupID) 
            -- if(worldEventData and worldEventData:getState() == PublicDefine.DistortedSpaceEventState.DistortedSpaceEventState_Opened) then 
                table.insert(userArr, taskData)
            -- end
        end
    end
    distortedSpaceArr = userArr

    if #distortedSpaceArr > 0 then
        -- 对任务排序
        table.sort(distortedSpaceArr,function (a,b) 
            if(a.unlockLevel and b.unlockLevel and #a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
    end

    return distortedSpaceArr
end

-- 获取接受的虫洞深处任务
function TaskDataManager:getAcceptWormholeTask(completeTaskID)
    if(RoleDataManager:getMaster() == nil) then 
        return {}
    end
    -- print("TaskDataManager:getAcceptInfernoTask 0")
    local mainArr = {}
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Wromhole) == false then 
        return mainArr
    end

    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isWormhole() then
            table.insert(mainArr, taskData)
        end
    end

    local userArr = {}
    local distortedSpaceArr = ConfigManager:getAllWormholeTask()
    -- 过滤已经完成
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, self._completeTaskIDMap)

    -- 过滤当前列表里面的
    local removeArr = {} 
    for _,taskData in ipairs(mainArr) do
        table.insert(removeArr, taskData:getId())
    end
    distortedSpaceArr = self:filterCompleteTask(distortedSpaceArr, removeArr)

    -- 过滤当前可以刷新的主线任务
    local level = RoleDataManager:getMaster():getLevel()
    -- print("TaskDataManager:getAcceptInfernoTask 2-1 level=",level)
    local rebackNil = false
    if(completeTaskID and self._completeTaskIDMap[completeTaskID] == nil) then
        rebackNil = true
        self._completeTaskIDMap[completeTaskID] = completeTaskID
    end

    distortedSpaceArr = self:_filterConditions(distortedSpaceArr)

    if(rebackNil) then
        self._completeTaskIDMap[completeTaskID] = nil
    end

    -- 根据扭曲空间开门事件来判断是否可以截取任务
    local userArr = {}
    for _,taskData in ipairs(distortedSpaceArr) do
        if(taskData.taskGroupID == 0) then
            table.insert(userArr, taskData)
        else
            -- local worldEventData = MasterDataManager:getWorldEventDataForID(taskData.taskGroupID) 
            -- if(worldEventData and worldEventData:getState() == PublicDefine.DistortedSpaceEventState.DistortedSpaceEventState_Opened) then 
                table.insert(userArr, taskData)
            -- end
        end
    end
    distortedSpaceArr = userArr

    if #distortedSpaceArr > 0 then
        -- 对任务排序
        table.sort(distortedSpaceArr,function (a,b) 
            if(a.unlockLevel and b.unlockLevel and #a.unlockLevel == 2 and #b.unlockLevel == 2) then 
                if a.unlockLevel[1] < b.unlockLevel[1] then
                    return true
                elseif a.unlockLevel[1] == b.unlockLevel[1] and a.ID < b.ID then
                    return true
                end
            else 
                if(a.ID < b.ID) then 
                    return true
                end
            end

            return false
        end)
    end

    return distortedSpaceArr
end

--[[
    过滤某些任务
    thoolArr: 被过滤的列表
    filterIDArr: 要过滤的ID列表
]]
function TaskDataManager:filterCompleteTask(thoolArr, filterIDArr)
    -- 过滤当前可以刷新的主线任务
    for _,taskID in pairs(filterIDArr) do
        for k,task in pairs(thoolArr) do
            if taskID == task.ID then
                table.remove(thoolArr, k)
                break
            end
        end
    end

    return thoolArr
end

function TaskDataManager:isFinishAllThreadTask()
    local mainArr = {}
    for _,taskData in ipairs(self._taskDataArr) do
        if taskData:isThread() then
            table.insert(mainArr, taskData)
        end
    end

    local threadThool = ConfigManager:getAllThreadTask()
    threadThool = self:filterCompleteTask(threadThool, self._completeTaskIDMap)
    if table.nums(threadThool) == 0 then
        return true
    end
    return false
end

function TaskDataManager:isNewTask(taskId)
    return self.newTaskFlag[taskId] ~= nil
end

--是否有完成还没领奖的任务
function TaskDataManager:haveFinishTask(isHaveGuildTask)
    if isHaveGuildTask then
        local isFinishGuild = self:getHaveGuildTaskComplete()
        local otherTaskNum = self:getTaskHaveCompleteNum()
        if isFinishGuild or otherTaskNum > 0 then
            return true
        end
    else
        local number = self:getTaskHaveCompleteNum()
        if number > 0 then
            return true
        end
    end
    return false
end

function TaskDataManager:refreshFinishTaskFlag()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_TASK_POINT_RED_POINT)
end

--false:只显示告示板任务 true:显示所有任务
--完成了非公告任务 返回true 
function TaskDataManager:isUnlockShow()
    for k , v in pairs(self._completeTaskIDMap) do
        local taskData = Data.TaskData:create(v)
        if taskData:isThread() then
            return true
        end
    end
    return false
end

function TaskDataManager:getTaskById(taskId)
    for _, taskData in ipairs(self._taskDataArr) do
        if taskData:getId() == taskId then
            return taskData
        end
    end
    return 
end

function TaskDataManager:beginFollowTask(taskId)
    local taskData = self:getTaskById(taskId)
    if taskData and taskData:getTargetType() == PublicDefine.TaskTargetType.Follow and not taskData:getIsFinish() then
        self.followTime[taskId] = os.time()
    end
end

--间隔时间 12s, 触发后清除掉所有纪录（该次操作行为结束）
function TaskDataManager:endFollowTask()
    if table.nums(self.followTime) == 0 then
        return
    end
    local curTime = os.time()
    for taskId, v in pairs(self.followTime) do
        if curTime - v >= 10 then
            Net.NetRoleSystem:finishTask(taskId)
        end
    end
    self.followTime = {}
end

function TaskDataManager:_checkUnlockLevel(taskConfig, masterLevel)
    if(taskConfig and masterLevel) then 
        if taskConfig.unlockLevel then
            if(#taskConfig.unlockLevel == 2) then 
                if(taskConfig.unlockLevel[1] <= masterLevel and taskConfig.unlockLevel[2] >= masterLevel) then 
                    return true
                end
            elseif (#taskConfig.unlockLevel == 0) then 
                return true
            end
        end
    end

    return false
end

function TaskDataManager:checkTaskIsCompleteByID(taskID)
    local isComplete = false
    for k, v in pairs(self._completeTaskIDMap) do
        if self._completeTaskIDMap[taskID] then
            isComplete = true
            break
        end
    end
    return isComplete
end

function TaskDataManager:checkTaskIsReceivedByID(taskID)
    local IsReceived = false
    local taskData = self:getTaskById(taskID)
    if taskData and taskData:getStatus() == PublicDefine.TaskStatus.TaskStatus_IsReceived then
        IsReceived = true
    end
    return IsReceived
end


--默认初始化
TaskDataManager:init()








