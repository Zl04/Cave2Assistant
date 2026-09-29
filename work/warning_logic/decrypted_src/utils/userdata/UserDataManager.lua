--[[
    用户数据操作工具
    - 一种类型的用户数据，存储在一个文件中
]]--

Avalon = Avalon or {}

local UserDataManager = {}
Avalon.UserDataManager = UserDataManager

-- 用户数据类型
Avalon.USER_DATA_TYPE = {
    GAME = "GameData",    -- 保存的数据和玩家没有关系
    BAG = "UserDataBag",
    GOODS = "GoodsUserData",
    GLOBAL = "GlobalUserData",
    GAME_IN_CAVE = "GameInCaveData",
    PURCHASE = "Purchase", -- 内购相关
}
USER_DATA_TYPE = Avalon.USER_DATA_TYPE

-- private:
local DEBUG = false
local USER_DATA_FILE_GAME = "game.ud"
local USER_DATA_FILE_BAG = "bag.ud"
local USER_DATA_FILE_GOODS = "goods.ud"
local USER_DATA_FILE_GLOBAL = "global.ud"
local USER_DATA_FILE_GAME_IN_CAVE = "gameInCave.ud"
local USER_DATA_FILE_PURCHASE = "purchase.ud"

-- 缓存用户数据
local userDataCache = {}

-- 通过用户数据类型获取文件名
local function getFileNameByUserDataType(userDataType, uuid)
    local fileName = uuid.."/"

    -- 处理文件目录的创建
    local filePath = ""
    if (userDataType == USER_DATA_TYPE.GAME) then
        filePath = Avalon.FileManager:getPublicDataDirection()..fileName
    else
        filePath = Avalon.FileManager:getUserDataDirection()..fileName
    end
    Avalon.FileManager:createDirectory(filePath)

    if (userDataType == USER_DATA_TYPE.GAME) then
        fileName = fileName..USER_DATA_FILE_GAME
    elseif (userDataType == USER_DATA_TYPE.BAG) then
        fileName = fileName..USER_DATA_FILE_BAG
    elseif (userDataType == USER_DATA_TYPE.GOODS) then
        fileName = fileName..USER_DATA_FILE_GOODS
    elseif (userDataType == USER_DATA_TYPE.GLOBAL) then
        fileName = fileName..USER_DATA_FILE_GLOBAL
    elseif (userDataType == USER_DATA_TYPE.GAME_IN_CAVE) then
        fileName = fileName..USER_DATA_FILE_GAME_IN_CAVE
    elseif (userDataType == USER_DATA_TYPE.PURCHASE) then
        fileName = fileName..USER_DATA_FILE_PURCHASE
    else
        assert(false, string.format("UserDataManager getFileNameByUserDataType: user data type %s is invalid.", userDataType))
    end

    return fileName
end

-- 创建玩家数据模型
local function createUseDataModel(userDataType,uuid)
    local userDataModel = nil
    if (userDataType == USER_DATA_TYPE.GAME) then
        require "utils.userdata.GameData"
        userDataModel = Avalon.GameData:create()
    elseif (userDataType == USER_DATA_TYPE.BAG) then
        require "utils.userdata.BagUserData"
        userDataModel = Avalon.BagUserData:create()
    elseif (userDataType == USER_DATA_TYPE.GOODS) then
        require "utils.userdata.GoodsUserData"
        userDataModel = Avalon.GoodsUserData:create()
    elseif (userDataType == USER_DATA_TYPE.GLOBAL) then
        require "utils.userdata.GlobalUserData"
        userDataModel = Avalon.GlobalUserData:create()
    elseif (userDataType == USER_DATA_TYPE.GAME_IN_CAVE) then
        require "utils.userdata.GameInCaveData"
        userDataModel = Avalon.GameInCaveData:create()
    elseif (userDataType == USER_DATA_TYPE.PURCHASE) then
        require "utils.userdata.PurchaseData"
        userDataModel = Avalon.PurchaseData:create()
    else
        assert(false)
    end

    userDataModel:setUUID(uuid)

    return userDataModel
end

-- 读取文件
function UserDataManager:readDataFromFile(userDataType, uuid)
    local fileName = getFileNameByUserDataType(userDataType, uuid)
    local jsonString = ""
    if userDataType == USER_DATA_TYPE.GAME then
        jsonString = Avalon.FileManager:readPublicDataFile(fileName)
    else
        jsonString = Avalon.FileManager:readUserDataFile(fileName)
    end
    
    if (DEBUG) then
        print("UserDataManager:readDataFromFile", fileName)
        print(string.format("UserDataManager readDataFromFile: read data %s for type %s:", jsonString, userDataType))
    end
    
    if userDataType == USER_DATA_TYPE.PURCHASE then
        jsonString = AvalonUtil:decryptXXTEA(jsonString, uuid)
    end

    return jsonString
end

-- 存入文件中
function UserDataManager:saveDataToFile(userDataType)
    local userDataModel = userDataCache[userDataType]
    if (userDataModel) then
        local data = userDataModel:getData()
        local fileName = getFileNameByUserDataType(userDataType, userDataModel:getUUID())
        -- 写文件
        local jsonString = json.encode(data)
        if (DEBUG) then
            print("UserDataManager:saveDataToFile fileName=", fileName)
            print(string.format("UserDataManager saveDataToFile: save user data %s for type %s:", jsonString, userDataType))
        end

        if userDataType == USER_DATA_TYPE.PURCHASE then
            jsonString = AvalonUtil:encryptXXTEA(jsonString, userDataModel:getUUID())
        end
        if userDataType == USER_DATA_TYPE.GAME then
            Avalon.FileManager:writePublicDataFile(fileName, jsonString)
        else
            Avalon.FileManager:writeUserDataFile(fileName, jsonString)
        end
    else
        assert(false, string.format("[ERROR] UserDataManager saveDataToFile: no user data found for type %s.", userDataType))
    end
end

-- 删除指定类型文件
function UserDataManager:deleteDataToFile(userDataType, uuid)
    local fileName = getFileNameByUserDataType(userDataType, uuid)
    if(fileName) then 
        if(userDataType == USER_DATA_TYPE.GAME) then 
            Avalon.FileManager:deletePublicDataFile(fileName)
        else
            Avalon.FileManager:deleteFile(fileName)
        end
    end
end

-- public:
-- 初始化
function UserDataManager:init()
    
end

-- 销毁
function UserDataManager:destroy()
    self:save()
end

-- 清理缓存
function UserDataManager:clearAllCache()
    userDataCache = {}
end

-- 读取用户数据
function UserDataManager:readUserData(userDataType, uuid)
    if(DEBUG) then
        print("UserDataManager:readUserData", userDataType, uuid)
    end
    local userDataModel = userDataCache[userDataType]
    -- add by zp 这里对于数据做一次严格的校验，如果不满足条件就重新读取符合条件的数据
    if(userDataModel) then 
        if(userDataModel:getUUID() ~= uuid) then 
            userDataModel = nil
        end
    end

    if (not userDataModel) then
        local handleStatus =  cc.UserDefault:getInstance():getBoolForKey(userDataType,false)
        if(handleStatus) then 
            -- 这里该类数据出错了，需要删除存储的文件
            print(string.format("fileName=%s", userDataType), handleStatus)
            self:deleteDataToFile(userDataType, uuid)
            printError("remove error userdata.")
        end
     
        cc.UserDefault:getInstance():setBoolForKey(userDataType, true)
        cc.UserDefault:getInstance():flush()
        local jsonString = self:readDataFromFile(userDataType, uuid)
        if (jsonString) then
            local userData = json.decode(jsonString)
            cc.UserDefault:getInstance():setBoolForKey(userDataType, false)
            cc.UserDefault:getInstance():flush()
            if (userData) then
                userDataModel = createUseDataModel(userDataType,uuid)
                userDataCache[userDataType] = userDataModel
                   
                userDataModel:setData(userData)
            else
                printError(string.format("[ERROR] UserDataManager readUserData: decode the json of user data failed for type %s.", userDataType))
            end
        else 
            cc.UserDefault:getInstance():setBoolForKey(userDataType, false)
            cc.UserDefault:getInstance():flush()
        end
    end
    -- 判断是否有对应的值
    if userDataModel == nil then
        userDataModel = createUseDataModel(userDataType,uuid)
        userDataCache[userDataType] = userDataModel
    end

    return userDataModel
end

-- 写用户数据
function UserDataManager:writeUserData(uuid, userData)
    local type = userData:getType()
    userDataCache[type] = userData

    self:save()
end

-- 存入文件中
function UserDataManager:save()
    if(DEBUG) then
        print("UserDataManager:save ")
    end
    for type, userDataMap in pairs(userDataCache) do
        if (userDataMap) then

            self:saveDataToFile(type)
        else
            assert(false)
        end
    end
end