--[[
    文件管理器
]]--

Avalon = Avalon or {}

local FileManager = {}
Avalon.FileManager = FileManager

-- private:
-- 游戏目录
local AVALON_DIRECTION_ROOT = "CaveOnline/"
local AVALON_DIRECTION_LUA = "CaveOnline/Lua/"
local AVALON_DIRECTION_LOG = "CaveOnline/Log/"
local AVALON_DIRECTION_USER_DATA = "CaveOnline/Cache/"
local AVALON_DIRECTION_RES = "CaveOnline/Res/"
local AVALON_DIRECTION_HOTFIX = "CaveOnline/Hotfix/"
local AVALON_DIRECTION_HOTFIX_TEMP = "CaveOnline/Hotfix_temp/"
FileManager.AVALON_DIRECTION_RES = AVALON_DIRECTION_RES
FileManager.AVALON_DIRECTION_ROOT = AVALON_DIRECTION_ROOT
FileManager.AVALON_DIRECTION_USER_DATA = AVALON_DIRECTION_USER_DATA
-- 游戏路径
local gamePath = nil

-- 获取可写路径
local function getGamePath()
    if (gamePath == nil) then
        gamePath = cc.FileUtils:getInstance():getWritablePath()
    end
    return gamePath
end

-- 创建目录
local function createDirectory(filePath)
    return cc.FileUtils:getInstance():createDirectory(filePath)
end

-- 检查游戏的目录
local function checkDirection()
    local path = getGamePath()

    local hasRootPath = createDirectory(path..AVALON_DIRECTION_ROOT)
    local hasLuaPath = createDirectory(path..AVALON_DIRECTION_LUA)
    local hasLogPath = createDirectory(path..AVALON_DIRECTION_LOG)
    local hasUserDataPath = createDirectory(path..AVALON_DIRECTION_USER_DATA)
    local hasResPath = createDirectory(path..AVALON_DIRECTION_RES)
    local hasHotfixPath = createDirectory(path..AVALON_DIRECTION_HOTFIX)

    return hasRootPath and hasLuaPath and hasLogPath and hasUserDataPath and hasHotfixPath
end

-- 获取文件全路径
local function getFullPath(filePath)
    return cc.FileUtils:getInstance():fullPathForFilename(filePath)
end

-- 从文件读取数据
function FileManager:readDataFromFile(filePath)
    -- local file = io.open(filePath, "rb")
    -- if (file) then
    --     local fileContent = file:read()
    --     file:close()

    --     return fileContent
    -- end
    -- return nil

    if cc.FileUtils:getInstance():isFileExist(filePath) then
        local buff = cc.FileUtils:getInstance():getDataFromFile(filePath)
        if buff == nil or buff == "" then
            return nil
        else
            return buff
        end
    end

    return nil
end

-- 写数据到文件中
function FileManager:writeDataToFile(fileContent, filePath)
    local file = io.open(filePath, "wb")
    if (file) then
        file:write(fileContent)
        file:close()

        return true
    end
    return false
end

-- 追加数据到文件中
function FileManager:appendDataToFile(fileContent, filePath)
    local file = io.open(filePath, "a")
    if (file) then
        file:write(fileContent)
        file:close()

        return true
    end
    return false
end

-- public:
-- 初始化
function FileManager:init()
    if (not checkDirection()) then
        assert(false, "[ERROR] FileManager init: the file direction error.")
    else
        local rootPath = getGamePath()..AVALON_DIRECTION_ROOT
        local resPath = getGamePath()..AVALON_DIRECTION_RES

        cc.FileUtils:getInstance():addSearchPath(rootPath)
        cc.FileUtils:getInstance():addSearchPath(resPath)
        
        -- 每次打开删除map缓存,避免覆盖安装的问题
        Avalon.FileManager:removeDirectory(Avalon.FileManager:getResDirection())
        Avalon.FileManager:createDirectory(Avalon.FileManager:getResDirection())    
        
        
    end
end

-- 销毁
function FileManager:destroy()

end

-- 创建目录
function FileManager:createDirectory(filePath)
    createDirectory(filePath)
end

-- 删除目录
function FileManager:removeDirectory(filePath)
    cc.FileUtils:getInstance():removeDirectory(filePath)
end

-- 删除文件
function FileManager:deleteFile(fileName)
    local filePath = self:getUserDataDirection()..fileName
    if(filePath) then
        cc.FileUtils:getInstance():removeFile(filePath)
    end
end

function FileManager:deletePublicDataFile(fileName)
    local filePath = self:getPublicDataDirection()..fileName
    if(filePath) then 
        cc.FileUtils:getInstance():removeFile(filePath)
    end
end

-- 删除文件
function FileManager:removeFileByAbsPath(fileAbsPath)
    return cc.FileUtils:getInstance():removeFile(fileAbsPath)
end

-- 获取根目录
function FileManager:getRootDirection()
    return getGamePath()..AVALON_DIRECTION_ROOT
end

-- 获取脚本目录
function FileManager:getLuaDirection()
    return getGamePath()..AVALON_DIRECTION_LUA
end

-- 获取日志目录
function FileManager:getLogDirection()
    return getGamePath()..AVALON_DIRECTION_LOG
end

-- 获取用户数据目录
function FileManager:getUserDataDirection()
    require("app.utils.ServerConfigUtil")
    return getGamePath()..AVALON_DIRECTION_USER_DATA..ServerConfigUtil:getProjectId().."/"
end

-- 获取用户数据目录
function FileManager:getPublicDataDirection()
    return getGamePath()..AVALON_DIRECTION_USER_DATA
end

-- 获取资源目录
function FileManager:getResDirection()
    return getGamePath()..AVALON_DIRECTION_RES
end

-- 获取热更新目录
function FileManager:getHotfixDirection()
    return getGamePath()..AVALON_DIRECTION_HOTFIX
end

-- 获取热更新目录
function FileManager:getHotfixTempDirection()
    return getGamePath()..AVALON_DIRECTION_HOTFIX_TEMP
end


-- 写日志文件
function FileManager:writeLogFile(fileName, fileContent)
    local filePath = self:getLogDirection()..fileName
    return self:appendDataToFile(fileContent, filePath)
end

-- 从文件读取用户数据
function FileManager:readUserDataFile(fileName)
    local filePath = self:getUserDataDirection()..fileName
    return self:readDataFromFile(filePath)
end

function FileManager:readPublicDataFile(fileName)
    local filePath = self:getPublicDataDirection()..fileName
    return self:readDataFromFile(filePath)
end
-- 写用户数据文件
function FileManager:writeUserDataFile(fileName, fileContent)
    local filePath = self:getUserDataDirection()..fileName
    return self:writeDataToFile(fileContent, filePath)
end

function FileManager:writePublicDataFile(fileName, fileContent)
    local filePath = self:getPublicDataDirection()..fileName
    return self:writeDataToFile(fileContent, filePath)
end


-- 读取资源文件
function FileManager:readResDataFile(fileName)
    local filePath = getFullPath(fileName)
    if (filePath) then
        local fileContent = self:readDataFromFile(filePath)
        if (fileContent) then
            return fileContent
        end
        return nil
    end
end

function FileManager:getFile(file_name)
    local f = assert(io.open(file_name, 'r'))
    local string = f:read("*all")
    f:close()
    return string
 end



 function FileManager:write_content( fileName,content )
     local f = assert(io.open(fileName, 'w'))
     f:write(content)
     f:close()
 end


function FileManager:filecopy1(source,destination)
     local stt=self:getFile(source)
     self:write_content( destination,stt)
end

--存取map 结构  到本地
function FileManager:saveMapDataToLocal(cacheMap, fileName, isPrivate)
    local GameDataManager = require("app.game.GameDataManager")
    local content = ""
    local list = {}
    for k, v in pairs(cacheMap) do 
        local data = {}
        if type(k) == "number" then
            data.id = string.format("%d", k)
        else
             data.id = k
        end
        data.value = v
        table.insert(list, data)
    end
    if cacheMap ~= nil then
        content = json.encode(list)
    end
    local saveUserKey = ""
    if isPrivate then
        saveUserKey = GameDataManager:getInstance():getSaveUserKey()
    end
    local filePath = self:getUserDataDirection()..saveUserKey.."/"..fileName
    local isSuccess = self:writeDataToFile(content ,filePath)
    if not isSuccess then
        cc.FileUtils:getInstance():createDirectory(self:getUserDataDirection()..saveUserKey.."/")
        self:writeDataToFile(content ,filePath)
    end
end

function FileManager:readMapDataFromLocal(fileName, isPrivate, keyIsNumber)
    local map = {}
    xpcall(function()
        map = self:_readMapDataFromLocal(fileName, isPrivate, keyIsNumber)
    end, 
    function(e) 
        self:saveMapDataToLocal({}, fileName, isPrivate)
    end, 1)  
    return map
end

function FileManager:_readMapDataFromLocal(fileName, isPrivate, keyIsNumber)
    local GameDataManager = require("app.game.GameDataManager")
    local saveUserKey = ""
    if isPrivate then
        saveUserKey = GameDataManager:getInstance():getSaveUserKey()
    end
    if keyIsNumber == nil then
        keyIsNumber = true
    end
    local filePath = self:getUserDataDirection()..saveUserKey.."/"..fileName
    local map = {}
    local content = self:readDataFromFile(filePath)
    if content ~= nil then
        local list = json.decode(content) or {}
        if keyIsNumber then
            for k, v in pairs(list) do 
                map[tonumber(v.id)] = v.value
            end
        else
            for k, v in pairs(list) do 
                map[v.id] = v.value
            end
        end
    end
    return map
end
