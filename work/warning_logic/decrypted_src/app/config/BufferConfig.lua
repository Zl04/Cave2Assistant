--[[
    buffer配置文件
]]--

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local Buffer = {}
Config.Buffer = Buffer

-- 缓存效果配置数据
local bufferDataCache = nil

-- 获取所有的效果配置数据
function Buffer:getAllBuffer()
    if (not bufferDataCache) then
        bufferDataCache = require("profiles/commonProfile/ProfileBuff")
        
        if(bufferDataCache == nil) then
            printError("[ERROR] Buffer getAllBuffer: could not get all the buffer config.")
        end
    end
    return bufferDataCache
end

-- 根据效果id获取配置数据
function Buffer:getBuffer(bufferID)
    local allBufferData = self:getAllBuffer()
    if (allBufferData) then
        local buffer = allBufferData[bufferID]
        if (buffer) then
            buffer.effectTimeList = {}

            local effectTriggerTiming = buffer.effectTriggerTiming
            local effectTimeList = AvalonUtil:splitStr(effectTriggerTiming, ",")
            for i = 1, #effectTimeList do
                local effectTime = effectTimeList[1]
                buffer.effectTimeList[i] = AvalonUtil:strToNumber(effectTime)
            end

            -- 处理多语言转换
            buffer.description = LanguageManager:getInstance():getLocalString(buffer.description)
            buffer.name = LanguageManager:getInstance():getLocalString(buffer.name)
        else
            print("bufferID =", bufferID)
            printError("Buffer getBuffer: could not found config.")
        end

        return allBufferData[bufferID]
    else
        printError("Buffer getBuffer: no buffer config file.")
        return nil
    end
end

-- 清理
function Buffer:clear()
    reload_script_file("profiles/commonProfile/ProfileBuff")
    bufferDataCache = nil
end