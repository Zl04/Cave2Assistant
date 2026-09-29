--[[
    日志系统
]]--
Avalon = Avalon or {}

local Log = {}
Avalon.Log = Log

-- 日志级别
LOG_LEVEL = {
    NORMAL = 1,   -- 普通
    WARNING = 2,  -- 警告
    ERROR = 3     -- 错误
}

-- private:
local DEBUG_PRINT = true
local DEBUG_WRITE = true

-- 记录标志，防止多次记录重复日志，一次奔溃记录一次
local isCrash = false
-- 日志级别
local level = LOG_LEVEL.NORMAL

-- 日志信息队列
local infoList = {}
local infoSize = 0



-- 生成信息格式
local function generateLogInfo(level, info)
    local date = os.date("%Y-%m-%d %H:%M:%S");
    local logInfo = nil

    if (level == LOG_LEVEL.NORMAL) then
        logInfo = string.format("[%s] [Avalon Info] %s \n", date, info)
    elseif (level == LOG_LEVEL.WARNING) then
        logInfo = string.format("[%s] [WARNING] [Avalon Info] %s \n", date, info)
    elseif (level == LOG_LEVEL.ERROR) then
        logInfo = string.format("[%s] [ERROR] [Avalon Info] \n %s \n\n", date, info)
    end


    return logInfo
end

-- 推入日志信息
local function pushLogInfo(logInfo)
    if (DEBUG_WRITE) then
        table.insert(infoList, logInfo)
        infoSize = infoSize + 1
    end
end

-- 清理日志信息
local function clearLogInfo()
    if (DEBUG_WRITE) then
        infoList = {}
        infoSize = 0
    end
end

-- 写日志文件
local function writeInfoFile(level)
    if (infoSize > 0) then
        local date = os.date("%Y-%m-%d");
        local fileName = date..".log"
        if (level == LOG_LEVEL.NORMAL) then
            fileName = "normal."..date..".log"
        elseif(level == LOG_LEVEL.WARNING) then
            fileName = "warning."..date..".log"
        elseif(level == LOG_LEVEL.ERROR) then
            fileName = "error."..date..".log"
        end
        local buffer = table.concat(infoList, "\n")
        Avalon.FileManager:writeLogFile(fileName, buffer)

        clearLogInfo()
    end
end

-- public:
-- 初始化
function Log:init()
    infoList = {}

    print("Log: init log system.")
end

-- 销毁
function Log:destroy()
    infoList = nil

    print("Log: destroy log system.")
end

-- 记录日志
function Log:record(info)
    if (not isCrash) then
        isCrash = true

        -- 生成日志
        local logInfo = generateLogInfo(LOG_LEVEL.ERROR, info)
        pushLogInfo(logInfo)
        -- 写日志文件
        writeInfoFile(LOG_LEVEL.ERROR)
    end
end

-- DEBUG 日志信息
function Log:debug(info)
    -- 生成日志
    local logInfo = generateLogInfo(LOG_LEVEL.NORMAL, info)
    pushLogInfo(logInfo)
    writeInfoFile(LOG_LEVEL.NORMAL)
end

-- 写入日志到文件
function Log:writeInfoFile()
    writeInfoFile(LOG_LEVEL.NORMAL)
end

function Log:getInfoList()
    return infoList();
end



