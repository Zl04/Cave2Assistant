--[[
    行为轨道：将所有行为对象分配到相应的执行轨道上
     － 支持链式执行
     － 支持多轨道执行
]]--

require "app.action.ActionEntry"

Action = Action or {}

local ActionTrack = class("ActionTrack")
Action.ActionTrack = ActionTrack

-- private:
local DEBUG = false

-- 查找action
function ActionTrack:_getActionEntry(trackIndex, entryId)
    local tracks = self._tracks
    
    local entries = tracks[trackIndex]
    if (entries) then
        return entries[entryId]
    end
    return nil
end

-- 清理某个轨道上的所有action
function ActionTrack:_clearTrack(trackIndex)
    local tracks = self._tracks

    local entries = tracks[trackIndex]
    if (entries) then
        for entryId, entry in pairs(entries) do
            entry:destroy()
            entries[entryId] = nil
        end
    else
        print(string.format("[WARNING] ActionTrack clearTrack: no action found in this track %d.", trackIndex))
    end
end

-- 清理某个轨道上的某个action
function ActionTrack:_clearAction(trackIndex, entryId)
    local tracks = self._tracks

    local entries = tracks[trackIndex]
    if (entries) then
        local entry = entries[entryId]
        if (entry) then
            entry:destroy()
            entries[entryId] = nil
        end
    else
        print("[WARNING] ActionTrack clearAction: no action found for entry %d in this track %d.", entryId, trackIndex)
    end
end

-- 清理所有轨道上的action
function ActionTrack:_clearTracks()
    local tracks = self._tracks

    for trackIndex, entries in pairs(tracks) do
        self:_clearTrack(trackIndex)
        tracks[trackIndex] = nil
    end
end

-- 移动到下一个action entry
function ActionTrack:_nextActionEntry(trackIndex, currentEntry)
    local action = currentEntry:popAction()
    if (action) then
        action:destroy()
    else
        assert(false, "[ERROR] ActionTrack _nextActionEntry: action is nil.")
    end
end

-- public:
-- 构造函数
function ActionTrack:ctor()
    self._tracks = {}
end

-- 销毁
function ActionTrack:destroy()
    self:_clearTracks()
    self._tracks = nil
end

-- 初始化
function ActionTrack:init()
    
end

-- 清理
function ActionTrack:clear()
    self:_clearTracks()
end

-- 执行action
function ActionTrack:execute(dt)
    local tracks = self._tracks
    
    for trackIndex, actionEntries in pairs(tracks) do
        local nums = 0;
        for entryId, currentEntry in pairs(actionEntries) do
            -- print(string.format("ActionMachine update: track %d, id %d.", trackIndex, entryId))
            nums = nums + 1
            if (currentEntry:size() > 0) then
                local action = currentEntry:getAction()
                if (action) then
                    action:update(dt)
                    if (action:isComplete() or
                        action:isInterrupted() or 
                        action:isFailure()) then
                        self:_nextActionEntry(trackIndex, currentEntry)
                    end
                else
                    print(string.format("[ERROR] ActionTrack execute: action (track:%d, entry:%d) is nil. ", trackIndex, entryId))
                end
            else    
                if (DEBUG) then
                    print(string.format("ActionMachine update: track %d, id %d, done.", trackIndex, entryId))
                end

                currentEntry:destroy()
                actionEntries[entryId] = nil
            end
        end
        -- add by yys 清理掉空的表,避免多余的遍历
        if nums <= 0 then
            tracks[trackIndex] = nil;
        end
    end
end

-- 在轨道上设置action
function ActionTrack:setAction(trackIndex, entryId, action)
    if (DEBUG) then
        print(string.format("ActionTrack setAction: set the action, track index:%d, entry id:%d, action:%s.", trackIndex, entryId, action))
    end

    local tracks = self._tracks

    local entries = tracks[trackIndex]
    if (not entries) then
        entries = {}
        tracks[trackIndex] = entries
    end

    local currentEntry = entries[entryId]
    if (not currentEntry) then
        currentEntry = Action.ActionEntry:create(true)
    end
    entries[entryId] = currentEntry

    currentEntry:clear()
    currentEntry:pushAction(action)
end

-- 添加轨道上添加action
function ActionTrack:addAction(trackIndex, entryId, action)
    local currentEntry = self:_getActionEntry(trackIndex, entryId)
    if (currentEntry) then
        if (DEBUG) then
            print(string.format("ActionTrack addAction: add the action, track index:%d, entry id:%d, action:%s.", trackIndex, entryId, action))
        end

        currentEntry:pushAction(action)
    else
        self:setAction(trackIndex, entryId, action)
    end
end

-- 清理对应对象所有的action
function ActionTrack:clearActionForEntryId(entryId)
    for k,entries in pairs(self._tracks) do
        local currentEntry = entries[entryId]
        if (currentEntry) then
            currentEntry:clear()
        end
    end
end

-- 根据轨道索引以及对象编号获取当前执行的action 
function ActionTrack:getFisrtAction(trackIndex, entryId)
     local currentEntry = self:_getActionEntry(trackIndex, entryId)

     if (currentEntry) then
        return currentEntry:getAction()
     else
        return nil
     end
end

-- 根据轨道索引以及对象编号获取最后一个action 
function ActionTrack:getLastAction(trackIndex, entryId)
    local currentEntry = self:_getActionEntry(trackIndex, entryId)

     if (currentEntry) then
        return currentEntry:getLastAction()
     else
        return nil
     end
end

-- 根据轨道索引以及对象编号获取最后一个非idle action 
function ActionTrack:getLastNoIdleAction(trackIndex, entryId)
    local currentEntry = self:_getActionEntry(trackIndex, entryId)

     if (currentEntry) then
        return currentEntry:findAction(function(action)
            if action:getType() ~= ActionType.FSM_IDLE then
                return true
            end
            return false
        end,true)
     else
        return nil
     end
end

-- 获取轨道上的所有action
function ActionTrack:getActionListByTrackIndex(trackIndex)
    if (DEBUG) then
        print(string.format("ActionTrack getActionListByTrackIndex: get all the action in track:%d.", trackIndex))
    end

    local entries = self._tracks[trackIndex]
    if (entries) then
        local actionList = {}
        local index = 0

        for entryId, entry in pairs(entries) do
            local entryActionList = entry:getActionList()
            if (DEBUG) then
                print(string.format("ActionTrack getActionListByTrackIndex: entry id:%d, action list count %d.", entryId, #entryActionList))
            end

            for i = 1, #entryActionList do
                index = index + 1
                actionList[index] = entryActionList[i]
            end
        end
        return actionList
    else
        if (DEBUG) then
            print(string.format("ActionTrack getActionListByTrackIndex: no track index %d found", trackIndex))
        end
    end
    return nil
end

-- 获取轨道上的某个entry中的所有action
function ActionTrack:getActionListByTrackIndexAndEntryID(trackIndex, entryId)
    if (DEBUG) then
        print(string.format("ActionTrack getActionListByTrackIndexAndEntryID: get all the action in track:%d by entry id %d.", trackIndex, entryId))
    end

    local entries = self._tracks[trackIndex]
    if (entries) then
        local entry = entries[entryId]
        if (entry) then
            return entry:getActionList()
        else
            if (DEBUG) then
                print(string.format("ActionTrack getActionListByTrackIndexAndEntryID: no entry id %d found", entryId))
            end
        end
    else
        if (DEBUG) then
            print(string.format("ActionTrack getActionListByTrackIndexAndEntryID: no track index %d found", trackIndex))
        end
    end
    return nil
end
