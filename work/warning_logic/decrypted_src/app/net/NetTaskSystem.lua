-- NetTaskSystem.lua
-- Author: zp
-- 

require "utils.MathUtil"

local SceneManager = require("app.game.SceneManager")
local ProtobufUtil = require("utils.ProtobufUtil")

local TaskType = PublicDefine.TaskType

Net = Net or {}
local NetTaskSystem = {}
Net.NetTaskSystem = NetTaskSystem

require "app.datas.TaskDataManager"

local DEBUG = false

-- 请求接受任务
function NetTaskSystem:accepTaskRequest(taskIDArr, placeIDArr)
    if DEBUG then
        print ("[Net.NetTaskSystem] accepTaskRequest =", taskIDArr, placeIDArr)
    end

    local messageData = {}
    messageData.task = {}
    for k,taskID in pairs(taskIDArr) do
        local task = {};
        task.taskID = taskID
        if(placeIDArr and #placeIDArr >= k) then
            task.replaceTaskID = placeIDArr[k]
        end

        table.insert(messageData.task, task)

        if(DEBUG) then
            print("NetTaskSystem:accepTaskRequest taskID=", taskID, task.replaceTaskID)
        end
    end

    Net.Helper:sendMessage(NetMessageType.TASK_ACCEPT_TASK, messageData)
end

-- 请求交任务
function NetTaskSystem:submitTaskRequest(taskID)
    if DEBUG then
        print ("[Net.NetTaskSystem] submitTaskRequest taskID=", taskID)
    end

    local messageData = {}
    messageData.taskID = taskID

    -- 根据当前任务ID获取一个新得任务
    local taskType = TaskDataManager:getTaskTypeForTaskID(taskID)

    local acceptTaskID = nil
    if(taskType == TaskType.Plot) then
        acceptTaskID = TaskDataManager:getOneAccepteThreadTaskID(taskID)
    elseif (taskType == TaskType.Daily) then
        acceptTaskID = TaskDataManager:getOneAccepteDailyTaskID()
    elseif (taskType == TaskType.Guild) then
        acceptTaskID = TaskDataManager:getOneAccepteGuildTaskID()
    elseif (taskType == TaskType.CaveHero) then
        acceptTaskID = TaskDataManager:getOneAccepteHeroCaveTaskID()
    elseif (taskType == TaskType.Cycle) then
        acceptTaskID = TaskDataManager:getOneAccepteCycleTaskID(taskID)
    elseif (taskType == TaskType.LimitDaily) then
        acceptTaskID = TaskDataManager:getOneAccepteLimitDailyTaskID()
    elseif (taskType == TaskType.DistortedSpace) then
        acceptTaskID = TaskDataManager:getOneAccepteDistortedSpaceTaskID(taskID)
    elseif (taskType == TaskType.Inferno) then
        acceptTaskID = TaskDataManager:getOneAccepteInfernoTaskID(taskID)
    elseif (taskType == TaskType.VoidRift) then
        acceptTaskID = TaskDataManager:getOneAccepteInfernoTaskID(taskID)
    elseif (taskType == TaskType.Viking) then
        acceptTaskID = TaskDataManager:getOneAccepteViKingTaskID(taskID)
    elseif (taskType == TaskType.EverWinterRift) then
        acceptTaskID = TaskDataManager:getOneAccepteEverWinterTaskID(taskID)
    elseif (taskType == TaskType.Chaos) then
        acceptTaskID = TaskDataManager:getOneAccepteChaosTaskID(taskID)
    elseif (taskType == TaskType.Wormhole) then
        acceptTaskID = TaskDataManager:getOneAccepteWormholeTaskID(taskID)
    end
    if(acceptTaskID) then
        messageData.acceptTaskID = acceptTaskID
        if DEBUG then
            print ("[Net.NetTaskSystem] submitTaskRequest acceptTaskID=", acceptTaskID)
        end
    end

    Net.Helper:sendMessage(NetMessageType.TASK_COMPLETE_TASK_REQUEST, messageData)    
end

function NetTaskSystem:submitTaskCollect(taskID, arr)
    if(DEBUG) then
        print("NetTaskSystem:submitTaskCollect", taskID, arr)
    end
    local messageData = {}
    messageData.taskID = taskID
    messageData.collectGoods = {}
    if(arr) then 
        for k,v in ipairs(arr) do 
            if(v.reachNum ~= 0) then 
                local oneData = {}
                oneData.collectID = v.goodsID
                oneData.collectPost = k - 1
                oneData.num = v.reachNum

                table.insert(messageData.collectGoods, oneData)
            end 
        end
    end
    if(DEBUG) then
        print("NetTaskSystem:submitTaskCollect data=", messageData)
    end
    Net.Helper:sendMessage(NetMessageType.TASK_DO_COLLECT_TASK, messageData)    
end

function NetTaskSystem:refreshTask(taskID, replaceTaskID)
    if(DEBUG) then
        print("NetTaskSystem:refreshTask", taskID, replaceTaskID)
    end
    local messageData = {}
    messageData.taskID = taskID
    messageData.replaceId = replaceTaskID

    if(DEBUG) then
        print("NetTaskSystem:refreshTask data=", messageData)
    end
    Net.Helper:sendMessage(NetMessageType.TASK_REFRESH_TASK, messageData)    
end
     
-- task消息处理
function NetTaskSystem:onTaskMessageHandler(no, data)
    print(string.format("[Net.NetTaskSystem] onTaskMessageHandler no:%d.", no))

    if (DEBUG) then
        if data and type(data) == "table" then
            for k,v in pairs(data) do 
                if type(v) == "table" then
                    print("[Net.NetTaskSystem] onTaskMessageHandler  k="..k.."  v=")
                end
            end
        end
    end

    -- 当前任务列表
    if (no == NetMessageType.TASK_HERO_ACCEPT_TASK.NO) then
        if(DEBUG) then
            print("NetTaskSystem  TASK_HERO_ACCEPT_TASK ", data)
        end
        TaskDataManager:handleInitTask(data)
    -- 当前完成
    elseif (no == NetMessageType.TASK_HERO_DELIVERED_TASK.NO) then
        if(DEBUG) then
            print("NetTaskSystem  TASK_HERO_DELIVERED_TASK ", data)
        end

        TaskDataManager:handleCompleteTask(data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NPC_TASK_REFRESH)
        SceneManager:getInstance():pushCommand(command)
    -- 接任务返回
    elseif (no == NetMessageType.TASK_ACCEPT_TASK.NO) then
        if(DEBUG) then
            print("NetTaskSystem  TASK_ACCEPT_TASK ",data)
        end

        TaskDataManager:handleAcceptTask(data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NPC_TASK_REFRESH)
        SceneManager:getInstance():pushCommand(command)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_REFRESH_ALL_TASK)
    -- 提交任务返回
    elseif (no == NetMessageType.TASK_COMPLETE_TASK_RESPONSE.NO) then
        if(DEBUG) then
            print("NetTaskSystem  TASK_COMMIT_TASK_RESPONSE ", data)
        end
        UI.WaitingLayer:hideWaiting()
        TaskDataManager:handleCompleteTaskResponse(data)

        MasterDataManager:removeRepeatHandleData(RepeatHandleType.TASK_REWARD, data.taskID)
        MasterDataManager:removeRepeatHandleData(RepeatHandleType.GUILD_TASK_REWARD, data.taskID)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NPC_TASK_REFRESH)
        SceneManager:getInstance():pushCommand(command)

        TaskDataManager:refreshFinishTaskFlag()
    -- 任务数据改变
    elseif (no == NetMessageType.TASK_TASK_CHANGE.NO) then
        if(DEBUG) then
            print("NetTaskSystem  TASK_TASK_CHANGE ", data)
        end
        local taskData = TaskDataManager:handleTaskChange(data)
        if(taskData) then 
            -- 任务状态改变
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_NPC_TASK_REFRESH, taskData)
            SceneManager:getInstance():pushCommand(command)
            --  系统聊天 打点
            if taskData:getIsFinish() then
                if taskData:isGuild() then -- 公会任务
                    Game.ChatManager:getInstance():sendSystemMsg(string.format(UI.TEXT_1170331, taskData:getDescription()), ChatMessageType.SYSTEM_MESSAGE)
                elseif (taskData:isCycle()) then
                    Game.ChatManager:getInstance():sendSystemMsg(string.format(UI.TEXT_1212087, taskData:getDescription()), ChatMessageType.SYSTEM_MESSAGE)
                elseif (taskData:isDistortedSpace()) then
                    Game.ChatManager:getInstance():sendSystemMsg(string.format(UI.TEXT_1212838, taskData:getDescription()), ChatMessageType.SYSTEM_MESSAGE)
                else
                    Game.ChatManager:getInstance():sendSystemMsg(string.format(UI.TEXT_1170329, taskData:getDescription()), ChatMessageType.SYSTEM_MESSAGE)
                end
                TaskDataManager:refreshFinishTaskFlag()
            else
                Game.ChatManager:getInstance():sendSystemMsg(string.format(UI.TEXT_1170330, taskData:getDescription(), taskData:getReachNum(), taskData:getTargetNum()), ChatMessageType.SYSTEM_MESSAGE)
            end
            Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_REFRESH_ALL_TASK)
        end 
    -- 删除任务
    elseif (no == NetMessageType.TASK_DELETE_TASK.NO) then
        if(DEBUG) then
            print("NetTaskSystem  TASK_DELETE_TASK ")
        end
        TaskDataManager:handleDeleteTask(data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NPC_TASK_REFRESH)
        SceneManager:getInstance():pushCommand(command)
    -- 收集任务结果消息
    elseif (no == NetMessageType.TASK_DO_COLLECT_TASK_RESULT.NO) then
        -- 处理收集信息结果
        if(DEBUG) then
            print("NetTaskSystem  TASK_DO_COLLECT_TASK_RESULT ", data)
        end
        if(data.result == ProtobufUtil:enum_id("TaskSystem.DoCollectTaskResultType", "DoCollectTaskResultType_Suc")) then
            TaskDataManager:handleTaskCollect(data) 
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_COLLECT_RESULT, data)
    elseif (no == NetMessageType.TASK_REFRESH_TASK_RESULT.NO) then
        -- print("TASK_REFRESH_TASK_RESULT=", data)
        local newTask = nil
        if(data.result == ProtobufUtil:enum_id("TaskSystem.RefreshTaskResultType", "RefreshTaskResultType_Suc")) then
            newTask = TaskDataManager:handleTaskRefresh(data) 
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_REFREH_RESULT, data, newTask)
        GameErrorManager:showError(data.result)
    elseif (no == NetMessageType.TASK_SYNC_TASK_DATA_MESSAGE.NO) then
        print("这里 !!!!!  ")
        TaskDataManager:refreshTaskDataMessage(data) 
    else
        assert(false, string.format("[Net.NetTaskSystem] onTaskMessageHandler no %d is invaild.", no))
    end   
end

