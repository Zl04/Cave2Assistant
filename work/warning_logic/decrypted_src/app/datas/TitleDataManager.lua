--[[
    称号管理器
]]
------------------------------------------------------
require "app.config.ConfigManager"
require "app.datas.title.TitleData"
require "app.datas.FunctionUnlockManager"

local GameDataManager = require("app.game.GameDataManager")
local DEBUG = false

TitleDataManager = TitleDataManager or {}

-- 初始化
function TitleDataManager:init()
    self.possessingTitleIDs = {}
    self.displayTitle = {}
end

-- 网络初始化
function TitleDataManager:initNet(titleIdArray, isReload, timeLimitTitles)
    -- printInfo("TitleDataManager:initNet, 服务器推送拥有称号列表", titleIdArray, isReload, timeLimitTitles)

    -- 精神正常检查
    if (isReload) then self.possessingTitleIDs = {} end
    if (titleIdArray == nil) then
        printWarn("TitleDataManager:initNet, titleIdArray为空")
        return 
    elseif (type(titleIdArray) ~= "table") then 
        printWarn("TitleDataManager:initNet, titleIdArray返回值类型不正确, 内容为: ", titleIdArray)
        return 
    end

    -- 填充称号数据
    for i, v in ipairs(titleIdArray) do
        local tempTitle = {}
        tempTitle.id = v
        table.insert(self.possessingTitleIDs, tempTitle)
    end
    if timeLimitTitles ~= nil then
        for i, v in ipairs(timeLimitTitles) do
            local tempTitle = {}
            tempTitle.id = v.titleId
            tempTitle.endTime = v.endTime
            table.insert(self.possessingTitleIDs, tempTitle)
        end
    end

    local showTitleArray = titleIdArray
    if timeLimitTitles ~= nil then
        for i, v in ipairs(timeLimitTitles) do
            table.insert(showTitleArray, v.titleId)
        end
    end
    -- print("showTitleArray ==== ",showTitleArray)
    -- 显示新称号提示
    if (not isReload) then
        for i,v in ipairs(showTitleArray) do
            Game.FunctionUnlockManager:getInstance():addHeroTitle(v)
        end
    end 
end

-- 清空称号管理器
function TitleDataManager:clear()
    self.possessingTitleIDs = {}
    self.displayTitle = {}
end

-- 回档（恢复）清理数据
function TitleDataManager:restoreClear()
    self:clear()
end

-- 从ID获取称号数据
function TitleDataManager:getTitleDataFromID(id, param,endTime)
    local titleData = Data.TitleData:create(id, param,endTime)
    if(DEBUG and titleData) then 
        printInfo("TitleDataManager:getTitleDataFromID, 正在返回称号信息", id, titleData:getTitleName(), titleData:getTitleDescription())
    end
    return titleData
end

-- 更新显示称号
function TitleDataManager:updateDisplayTitle()
    self.displayTitle = {}

    -- 检查特殊称号状态(师徒等)
    local allTitleIDs = self:getPossessingTitleIDArray()
    for i,tData in ipairs(allTitleIDs) do
        local isDisplay = true
        local titleData = self:getTitleDataFromID(tData.id,nil,tData.endTime)
        if (titleData:getTitleFunctionType() == 51) then
            local mentor = mvc.apprenticeshipModel:getMentor()
            if (not mentor) then
                isDisplay = false
            else
                titleData:setParam(mentor.nickName)
            end
        end

        if (isDisplay) then
            table.insert(self.displayTitle, titleData)
        end
    end
end

-- 获取显示的称号列表
function TitleDataManager:getDisplayTitleArray()
    self:filterTimeOutTitle()
    return self.displayTitle
end

-- 获取显示称号的数量
function TitleDataManager:getDisplayTitleNum()
    self:filterTimeOutTitle()
    return #self.displayTitle
end

-- 过滤超时称号
function TitleDataManager:filterTimeOutTitle()
    for i = #self.displayTitle,1,-1 do
        local tData = self.displayTitle[i]
        if tData:getEndTime() ~= nil and tData:getEndTime() < GameManager:getNormalServerTime() then
            table.remove(self.displayTitle,i)
        end
    end
end

-- 获取拥有的称号列表
function TitleDataManager:getPossessingTitleIDArray()
    return self.possessingTitleIDs
end

-- 判断称号ID是否需要表现特效, 如果需要则返回相关数据, 否则返回nil
function TitleDataManager:getEffectDataByTitleID(titleID)
    local effectData = nil

    local confData = ConfigManager:getVirtualItemConfigByID(tonumber(titleID))
    if confData and confData.value2 ~= "" and confData.value3 ~= "" then
        effectData = {}
        effectData.spineNames = string.split(confData.value2,";")
        effectData.skeletons = string.split(confData.value3,";")
    end

    return effectData
end

--默认初始化
TitleDataManager:init()