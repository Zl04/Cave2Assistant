--[[--
数据模型QuickSideBarModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/09/06
--desc	: QuickSideBarModel
------------------------------------------------------------------------------

local QuickSideBarModel = class("QuickSideBarModel",mvc.GameModel)
local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")

require("app.datas.TeamDataManager")

function QuickSideBarModel:initData()
	
end

function QuickSideBarModel:sortTasks(isInCave)
    local taskArr = GameDataManager:getInstance():getTaskArr()
    local retArray = self:handleSortTask(taskArr, isInCave)

    return retArray
end

-- 这里采用统一的方式来排序
function QuickSideBarModel:handleSortTask(taskArr, isInCave)
    local retArray = {}
    local finishArr = {}
    local notFinishArr = {}
    if(taskArr) then
        for k, taskData in pairs(taskArr) do 
            -- 过滤掉已经领取的任务
            if (taskData:getIsReceived() == false) then
                if taskData:getIsFinish() then
                    table.insert(finishArr, taskData)
                else
                    table.insert(notFinishArr, taskData)
                end

                -- 重新定义类型
                -- 进阶>扭曲>主线>经验>金币>公会>通关>日常
                local taskType = taskData:getTaskType()
                if taskType == PublicDefine.TaskType.Daily then
                    if self:checkIsExpTask(taskData) then
                        taskData.newType = 4
                    else
                        taskData.newType = 8
                    end
                elseif taskType == PublicDefine.TaskType.Plot then
                    taskData.newType = 3
                elseif taskType == PublicDefine.TaskType.LimitDaily then
                    taskData.newType = 5
                elseif taskType == PublicDefine.TaskType.Guild then
                    taskData.newType = 6
                elseif taskType == PublicDefine.TaskType.Cycle then
                    taskData.newType = 1
                elseif taskType == PublicDefine.TaskType.DistortedSpace then
                    taskData.newType = 2
                elseif taskType == PublicDefine.TaskType.CaveHero then
                    taskData.newType = 7
                else
                    taskData.newType = 99
                end
            end
        end

        table.sort(finishArr, function(a, b)
            if a.newType == b.newType then
                if a:getReachNum() > b:getReachNum() then
                    return true
                end
            else
                return a.newType < b.newType
            end
        end)

        table.sort(notFinishArr, function(a, b)
            if a.newType == b.newType then
                if a:getReachNum() > b:getReachNum() then
                    return true
                end
            else
                return a.newType < b.newType
            end
        end)
    end

    if isInCave then
        for k, v in ipairs(notFinishArr) do
            table.insert(retArray, v)
        end

        for k, v in ipairs(finishArr) do
            table.insert(retArray, v)
        end
    else
        for k, v in ipairs(finishArr) do
            table.insert(retArray, v)
        end

        for k, v in ipairs(notFinishArr) do
            table.insert(retArray, v)
        end
    end

    local SdkBox = require("utils.sdkbox.SdkBox")

    local versionTarget = SdkBox:getInstance():getVersionTarget()

    if (target == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL) then

        -- 剔除分享任务(临时处理 Facebook下架问题)
        local tempArray = {}
        for k,v in ipairs(retArray) do
            if v:getTargetType() ~= 5 and v:getTargetType() ~= 8 then
                table.insert(tempArray,v)
            end
        end

        -- return retArray
        return tempArray
    else
        return retArray
    end
end

function QuickSideBarModel:checkHasTeam()
    local teamList = TeamDataManager:getTeamData()
    local teamLen = 0
    for k, v in pairs(teamList) do
        teamLen = teamLen + 1
    end

    if TeamDataManager:hasTeam() and teamLen > 1 then
        return true
    end

    return false
end

function QuickSideBarModel:checkIsExpTask(taskdata)
    local goodsData = taskdata:getRewardGoodsArr()
    local size = #goodsData
    if size == 0 then
        return false
    end

    for i = size, 1, -1 do
        local virtualData = goodsData[i]
        if(virtualData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM
            and virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemExp) then
            local masterData = GameDataManager:getInstance():getMaster()
            local masterLevel = 0
            if masterData then 
                masterLevel = masterData:getLevel()
            end

            local expConfig = ConfigManager:getGeneralForKey("taskExpAward")
            if(expConfig and expConfig ~= "") then 
                local expConfigArr = string.split(expConfig, ";")
                if(expConfigArr) then 
                    for _,value in ipairs(expConfigArr) do 
                        local oneExpArr = string.split(value, ",")
                        if(oneExpArr and #oneExpArr ==2) then 
                            if(tonumber(oneExpArr[1]) == masterLevel) then 
                                if taskdata:getIsDiamond() then
                                    return true
                                end
                            end 
                        end 
                    end 
                end 
            end
        end
    end

    return false
end

function QuickSideBarModel:needShow()
    local cfgStr = ConfigManager:getGeneralForKey("nonTeamPanelMode")
    if not cfgStr or cfgStr == "" then
        return true
    end

    local cfgArr = string.split(cfgStr, ";")
    local mapData = GameMapManager:getInstance():getMapData()
    if(mapData) then
        local caveMode = tonumber(mapData.caveMode)
        for _, v in ipairs(cfgArr) do
            if tonumber(v) == caveMode then
                return false
            end
        end
    end

    return true
end

return QuickSideBarModel