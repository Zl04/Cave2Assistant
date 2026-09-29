local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local Task = {}
Config.Task = Task 

local TASK_CACHE = nil
local TASK_MAIN_CACHE = nil
local TASK_GROUP_CACHE = {}
local TASK_GROUP_GUILD_CACHE = {}
local TASK_GROUP_LIMIT_DAILY_CACHE = {}


-- 根据任务ID获取任务数据
function Task:getTaskForID(taskID)
    local allTask = self:getAllTask()

    local task = allTask[taskID]
    -- assert(task, string.format("Task:getTaskForID taskID=%d not found config.", taskID)) 

    return task
end

-- 处理日常任务得分类缓存
function Task:getTaskForGroupID(groupID)
    local groupArr = TASK_GROUP_CACHE[groupID]
    if(groupArr == nil) then
        groupArr = {}
        TASK_GROUP_CACHE[groupID] = groupArr

        local allTask = self:getAllTask()
        for _,taskData in pairs(allTask) do
            if type(taskData)  == "table" then
                -- if((taskData.taskGroupID == groupID or taskData.taskGroupID == 0) and taskData.ID > 30000 and taskData.ID <= 39999) then
                -- CO-22187 日常任务优化, 区间改为 36900~39999
                if((taskData.taskGroupID == groupID or taskData.taskGroupID == 0) and taskData.ID >= 36900 and taskData.ID <= 39999) then
                    table.insert(groupArr, taskData)
                end
            end
        end
    end

    return clone(groupArr)
end

-- 处理日常任务得分类缓存
function Task:getGuildTaskForGroupID(groupID)
    local groupArr = TASK_GROUP_GUILD_CACHE[groupID]
    if(groupArr == nil) then
        groupArr = {}
        TASK_GROUP_GUILD_CACHE[groupID] = groupArr

        local allTask = self:getAllTask()
        for _,taskData in pairs(allTask) do
            if type(taskData)  == "table" then
                if((taskData.taskGroupID == groupID or taskData.taskGroupID == 0) and taskData.ID > 40000 and taskData.ID <= 49999) then
                    table.insert(groupArr, taskData)
                end
            end
        end
    end

    return clone(groupArr)
end

function Task:getLimitDailyConfigForGroupID(groupID)
    local groupArr = TASK_GROUP_LIMIT_DAILY_CACHE[groupID]
    if(groupArr == nil) then
        groupArr = {}
        TASK_GROUP_LIMIT_DAILY_CACHE[groupID] = groupArr

        local allTask = self:getAllTask()
        for _,taskData in pairs(allTask) do
            if type(taskData)  == "table" then
                if((taskData.taskGroupID == groupID or taskData.taskGroupID == 0) and taskData.ID > 70000 and taskData.ID <= 79999) then
                    table.insert(groupArr, taskData)
                end
            end
        end
    end

    return clone(groupArr)
end


-- 处理主线任务得筛选
function Task:getAllMainTask()
    if TASK_MAIN_CACHE == nil then
        TASK_MAIN_CACHE = {}
        local allTask = self:getAllTask()
        for _,taskData in pairs(allTask) do
            if type(taskData)  == "table" then
                if(taskData.ID < 30000 and taskData.ID > 20000) then
                    table.insert(TASK_MAIN_CACHE, taskData)
                end
            end
        end
    end
    return clone(TASK_MAIN_CACHE)
end

-- 处理主线任务得筛选
function Task:getAllCaveHeroTask()
    local allTask = self:getAllTask()
    local heroCaveTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 50000 and taskData.ID < 60000) then
                table.insert(heroCaveTask, taskData)
            end
        end
    end
    return clone(heroCaveTask)
end


-- 处理环任务得筛选
function Task:getAllCycleTask()
    local allTask = self:getAllTask()
    local cycleTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 60000 and taskData.ID < 70000) then
                table.insert(cycleTask, taskData)
            end
        end
    end
    return clone(cycleTask)
end

function Task:getAllDistortedSpaceTask()
    local allTask = self:getAllTask()
    local cycleTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 80000 and taskData.ID < 90000) then
                table.insert(cycleTask, taskData)
            end
        end
    end
    return clone(cycleTask)
end

function Task:getAllInfernoTask()
    local allTask = self:getAllTask()
    local cycleTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 90000 and taskData.ID < 100000) then
                table.insert(cycleTask, taskData)
            end
        end
    end
    return clone(cycleTask)
end

function Task:getAllVoidRiftTask()
    local allTask = self:getAllTask()
    local cycleTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 100000 and taskData.ID < 110000) then
                table.insert(cycleTask, taskData)
            end
        end
    end
    return clone(cycleTask)
end

function Task:getAllViKingTask()
    local allTask = self:getAllTask()
    local cycleTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 110000 and taskData.ID < 120000) then
                table.insert(cycleTask, taskData)
            end
        end
    end
    return clone(cycleTask)
end

function Task:getAllEverWinterTask()
    local allTask = self:getAllTask()
    local cycleTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 120000 and taskData.ID < 130000) then
                table.insert(cycleTask, taskData)
            end
        end
    end
    return clone(cycleTask)
end

function Task:getAllChaosTask()
    local allTask = self:getAllTask()
    local cycleTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 130000 and taskData.ID < 140000) then
                table.insert(cycleTask, taskData)
            end
        end
    end
    return clone(cycleTask)
end

function Task:getAllWormholeTask()
    local allTask = self:getAllTask()
    local cycleTask = {}
    for _,taskData in pairs(allTask) do
        if type(taskData)  == "table" then
            if(taskData.ID >= 150000 and taskData.ID < 160000) then
                table.insert(cycleTask, taskData)
            end
        end
    end
    return clone(cycleTask)
end

--获取所有任务数据
function Task:getAllTask()
    if TASK_CACHE == nil then
        -- 获取所有技能
        local taskAttr = require("profiles/commonProfile/ProfileTask")

        local temp = {}
        for k,v in pairs(taskAttr) do
            if (type(v) == "table") then
                v.taskID = v.ID
                -- 如果分享是关闭的
                if not CONFIG_SHARE and checkint(v.type) == PublicDefine.TaskTargetType.Share then
                    table.insert(temp, v.ID)
                end
                if CAVEOL_TARGET ~= CAVEOL_TARGET_GLOBAL and checkint(v.type) == PublicDefine.TaskTargetType.Follow then
                    table.insert(temp, v.ID)
                end
            end
            
        end
        -- 删除分享任务
        for i,ID in ipairs(temp) do
            for k,v in pairs(taskAttr) do
                if (type(v) == "table") then
                    if v.ID == ID then
                        taskAttr[k] = nil;
                        break;
                    end
                end
            end
        end
        TASK_CACHE = taskAttr
    end

    return TASK_CACHE
end

-- 清理
function Task:clear()
    reload_script_file("profiles/commonProfile/ProfileTask")
    TASK_CACHE = nil
    TASK_MAIN_CACHE = nil
    TASK_GROUP_CACHE = {}
    TASK_GROUP_GUILD_CACHE = {}
    TASK_GROUP_LIMIT_DAILY_CACHE = {}
end
