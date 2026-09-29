-- DialogManager.lua
-- Author:ydli
-- 2017年08月29日
-- Using:黑屏动画
local DialogManager = class("DialogManager")
local LanguageManager = require("app.game.LanguageManager")
Game = Game or {}
require "app.config.ConfigManager"
require "utils.Queue"
g_dialogManager = nil;

local scheduler = cc.Director:getInstance():getScheduler()


--队列维护
local Queue = Avalon.Queue


function DialogManager:ctor()
    self.schedulerID = 0
end

function DialogManager:dtor()
    if self.schedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
end

function DialogManager:getInstance()
    if g_dialogManager == nil then
        g_dialogManager = DialogManager.new()
        g_dialogManager:init()
    end
    return g_dialogManager;
end


function DialogManager:purgeInstance()
    if g_dialogManager ~= nil then
        g_dialogManager = nil;
    end
end

function DialogManager:init()
    print("DialogManager:init")

    self.dialogQueue = Queue:create()
    self.isFree = true
    self.EventMap = self.EventMap or {}
    self:SortEventByType()
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 0.1, false)
end


function DialogManager:update(dt)
    -- print("-------DialogManager:update(dt)")
    -- dump(self.dialogQueue, "self.dialogQueue = ")
    if not self.isFree then
        return
    end
    local data = self:pop()
    if data ~= nil then
        local dialogList = self:parseLanguage(data)
        require "app.ui.blackDialogue.BlackDialogue"
        UI.BlackDialogue:addDialogList(dialogList, data.isAuto, data.handlerFunc)
    end
end

--[[
push 结构 {languageId = 1, isAuto = false}
]]
function DialogManager:push(languageId, isAuto, handlerFunc)
	-- print("--------------- DialogManager:push")
    local data = {}
    data.languageId = languageId
    data.isAuto = isAuto
    data.handlerFunc = handlerFunc
    self.dialogQueue:push(data)
    -- dump(self.dialogQueue, "self.dialogQueue =")
end

function DialogManager:pop()
	-- print("--------------- DialogManager:pop")
    return self.dialogQueue:front()
end

--[[
    根据 languageId 获得多文本
    根据多文本 分析索引
    把多文本分段  返回文本数组
]]
function DialogManager:parseLanguage(eventData)
	-- print("--------------- DialogManager:parseLanguage")
    local mainString = LanguageManager:getInstance():getLocalString(eventData.languageId)
    local nameString = PlaceholderUtil:parseMasterName(mainString)
    local dialogList = string.split(nameString, "\n")
    return dialogList
end

function DialogManager:setFree(isFree)
    self.isFree = isFree
end

--[[
    eventType:事件类型 必传参数 gamedefine.lua   BlackDialogEventType  
    modeType:战斗模式
    diffType：战斗难度
    bossId： boss ID
]]
function DialogManager:addEevnt(eventType, modeType, diffType, bossId, handlerFunc)
    modeType = modeType or 0
    diffType = diffType or 0
    bossId = bossId or 0
    local eventList = self:getEventListByType(eventType)
    local eventData = self:getLangunageFromEventData(eventList, modeType, diffType, bossId)
    if eventData == nil then
        print("languageId == 0   and eventType = "..eventType.."  /  modeType = "..modeType.."  /  diffType = "..diffType.."  /  bossId = "..bossId)
        if handlerFunc then
            handlerFunc()
        end
        return  
    end
    local isAuto = eventData.unlockType == 2 and true or false
    self:push(eventData.languageID, isAuto, handlerFunc)
end

function DialogManager:getLangunageFromEventData(eventList, modeType, diffType, bossId)
    -- print("----------DialogManager:getLangunageFromEventData")
    if #eventList == 0 then
        print("eventList is nil")
        return
    end
    if #eventList == 1 then
        return eventList[1]
    end
    for k, v in ipairs(eventList) do  
        local params = string.split(eventList[k].eventValue, ",")
        -- dump(params, "params = ")
        if #params == 3 and tonumber(params[1]) == modeType and tonumber(params[2]) == diffType and tonumber(params[3]) == bossId then
            return eventList[k]
        end
    end
    return
end

function DialogManager:SortEventByType()
    local list = ConfigManager:getAllBlackDialogEvent()
    self.EventMap = {}
    for k, v in pairs(list) do
        local eventType = v.eventType
        local eventList = self.EventMap[eventType]
        if eventList == nil then
            eventList = {}
            table.insert(eventList, v)
            self.EventMap[eventType] = eventList
        else
            table.insert(eventList, v)
        end
    end
end

function DialogManager:getEventListByType(eventType)
    -- print("----------DialogManager:getEventListByType")
    local eventList = self.EventMap[eventType] or {}
    return eventList 
end

return DialogManager













