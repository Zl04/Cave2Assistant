--[[
    资源管理器
]]--

Avalon = Avalon or {}

local ResHelper = {}
Avalon.ResHelper = ResHelper

-- private:
local DEBUG = false
local loadedResCallbackMap = nil
local RES_INSTANCE_COUNT = 0
local director = cc.Director:getInstance()
local textureCache = director:getTextureCache()
-- 生成id
local function generateResID()
    RES_INSTANCE_COUNT = RES_INSTANCE_COUNT + 1
    return RES_INSTANCE_COUNT
end

-- 执行回调函数
local function onExecuteHandler(id, ...)
    if (id > 0) then
        local handler = loadedResCallbackMap[id]
        if (handler) then
            handler[2](handler[1], ...)
            loadedResCallbackMap[id] = nil
        else
            -- assert(false, string.format("[ERROR] ResHelper: could not find handler id %d.", id))
        end
    end
end

-- 加载资源集合完成
local function onLoadedResSet(handlerId)
    -- print(string.format("ResHelper: loaded res set."))

    onExecuteHandler(handlerId)
end

-- 加载plist完成
local function onLoadedPlist(plist, handlerId)
    print(string.format("ResHelper: loaded plist %s.", plist))
    onExecuteHandler(handlerId, plist)
end

-- 加载图片完成
local function onLoadedImage(imageFile, handlerId)
    -- print(string.format("ResHelper: loaded image %s.", imageFile))

    onExecuteHandler(handlerId, imageFile)
end

-- 加载spine完成
local function onLoadedSpine(skeletonFile, atlasFile, scale, handlerId)
    -- print(string.format("ResHelper: loaded spine %s %s %f.", skeletonFile, atlasFile, scale))

    onExecuteHandler(handlerId, skeletonFile, atlasFile, scale)
end

-- 注册回调函数
local function registerCallback(target, callback)
    if (not loadedResCallbackMap) then
        loadedResCallbackMap = {}
    end

    local id = 0
    if (callback) then
        id = generateResID()
        local handler = {
            [1] = target,
            [2] = callback
        }
        loadedResCallbackMap[id] = handler
    end
    return id
end

-- 取消回调函数
local function cancelCallback(target, callback)
    if (loadedResCallbackMap) then
        for id, handler in pairs(loadedResCallbackMap) do
            if (handler[1] == target and
                handler[2] == callback) then
                loadedResCallbackMap[id] = nil

                return
            end
        end
    end
end

-- public:
-- 初始化
function ResHelper:init()
    avalon.ResManager:getInstance():cancelCallback()
    avalon.ResManager:getInstance():stopLoading()
    avalon.ResManager:getInstance():setCallback(onLoadedPlist, onLoadedImage, onLoadedSpine, onLoadedResSet)

    print("ResHelper: init resource helper.")
end
-- 销毁
function ResHelper:destroy()
    avalon.ResManager:getInstance():cancelCallback()
    avalon.ResManager:getInstance():stopLoading()
    loadedResCallbackMap = nil

    print("ResHelper: destory resource helper.")
end

-- 取消资源加载回调函数的注册
function ResHelper:unregisterCallback(target, callback)
    cancelCallback(target, callback)
end

-- plist
----------------------------------------------------------------
-- 将plist资源推入队列
function ResHelper:pushPlist(plist, target, callback)
    assert(plist and type(plist) == "string", "[ERROR] ResHelper: plist must be a string.")

    local id = registerCallback(target, callback)
    avalon.ResManager:getInstance():pushPlist(plist, id)
end

-- 加载plist
function ResHelper:loadPlist(plist, target, callback)
    self:pushPlist(plist, target, callback)
    avalon.ResManager:getInstance():startLoading()
end

-- 同步加载plist
function ResHelper:loadPlistSync(plist)
    assert(plist and type(plist) == "string", "[ERROR] ResHelper: plist must be a string.")

    avalon.ResManager:getInstance():loadPlist(plist)
end

-- 卸载plist
function ResHelper:unloadPlist(plist, target, callback)
    assert(plist and type(plist) == "string", "[ERROR] ResHelper: plist must be a string.")

    cancelCallback(target, callback)
    avalon.ResManager:getInstance():unloadPlist(plist)
end

-- 是否加载过plist
function ResHelper:isLoadedForPlist(plist)
    assert(plist and type(plist) == "string", "[ERROR] ResHelper: plist must be a string.")

    return avalon.ResManager:getInstance():isLoadedForPlist(plist)
end
----------------------------------------------------------------

-- 图片
----------------------------------------------------------------
-- 将图片资源推入队列
function ResHelper:pushImage(imageFile, target, callback)
    assert(imageFile and type(imageFile) == "string", "[ERROR] ResHelper: imageFile must be a string.")

    local id = registerCallback(target, callback)
    avalon.ResManager:getInstance():pushImage(imageFile, id)
end

-- 加载图片
function ResHelper:loadImage(imageFile, target, callback)
    self:pushImage(plist, target, callback)
    avalon.ResManager:getInstance():startLoading()
end

-- 同步加载图片
function ResHelper:loadImageSync(imageFile)
    assert(imageFile and type(imageFile) == "string", "[ERROR] ResHelper: imageFile must be a string.")

    avalon.ResManager:getInstance():loadImage(imageFile)
end

-- 卸载图片
function ResHelper:unloadImage(imageFile, target, callback)
    assert(imageFile and type(imageFile) == "string", "[ERROR] ResHelper: imageFile must be a string.")

    cancelCallback(target, callback)
    avalon.ResManager:getInstance():unloadImage(imageFile)
end

-- 是否加载过图片
function ResHelper:isLoadedForImage(imageFile)
    assert(imageFile and type(imageFile) == "string", "[ERROR] ResHelper: imageFile must be a string.")

    return avalon.ResManager:getInstance():isLoadedForImage(imageFile)
end
----------------------------------------------------------------

-- spine
----------------------------------------------------------------
-- 将spine资源推入队列
function ResHelper:pushSpine(skeletonFile, atlasFile, scale, target, callback)
    assert(skeletonFile and type(skeletonFile) == "string", "[ERROR] ResHelper: skeletonFile must be a string.")
    assert(atlasFile and type(atlasFile) == "string", "[ERROR] ResHelper: atlasFile must be a string.")
    assert(scale and type(scale) == "number", "[ERROR] ResHelper: scale must be a number.")
    assert(skeletonFile ~= ".json" and skeletonFile ~= " .json", string.format("ResHelper:pushSpine skeletonFile=%s",skeletonFile))
    assert(atlasFile ~= ".atlas" and atlasFile ~= " .atlas", string.format("ResHelper:pushSpine atlasFile=%s",atlasFile))
    if(skeletonFile and skeletonFile ~= "" and atlasFile and atlasFile ~= "" and scale and type(scale) == "number") then 
        local id = registerCallback(target, callback)
        avalon.ResManager:getInstance():pushSpine(skeletonFile, atlasFile, scale, id)
    else 
        printError("ResHelper:pushSpine =", skeletonFile, atlasFile, scale)
    end
end

-- 加载spine
function ResHelper:loadSpine(skeletonFile, atlasFile, scale, target, callback)
    self:pushSpine(skeletonFile, atlasFile, scale, target, callback)
    avalon.ResManager:getInstance():startLoading()
end

-- 同步加载spine
function ResHelper:loadSpineSync(skeletonFile, atlasFile, scale)
    assert(skeletonFile and type(skeletonFile) == "string", "[ERROR] ResHelper: skeletonFile must be a string.")
    assert(atlasFile and type(atlasFile) == "string", "[ERROR] ResHelper: atlasFile must be a string.")
    assert(scale and type(scale) == "number", "[ERROR] ResHelper: scale must be a number.")
    assert(skeletonFile ~= ".json" and skeletonFile ~= " .json", string.format("ResHelper:loadSpineSync skeletonFile=%s",skeletonFile))
    assert(atlasFile ~= ".atlas" and atlasFile ~= " .atlas", string.format("ResHelper:loadSpineSync atlasFile=%s",atlasFile))

    if(skeletonFile and skeletonFile ~= "" and atlasFile and atlasFile ~= "" and scale and type(scale) == "number") then 
        avalon.ResManager:getInstance():loadSpine(skeletonFile, atlasFile, scale)
    else 
        printError("ResHelper:loadSpineSync =", skeletonFile, atlasFile, scale)
    end
end

-- 卸载spine
function ResHelper:unloadSpine(skeletonFile, atlasFile, scale, target, callback)
    assert(skeletonFile and type(skeletonFile) == "string", "[ERROR] ResHelper: skeletonFile must be a string.")
    assert(atlasFile and type(atlasFile) == "string", "[ERROR] ResHelper: atlasFile must be a string.")
    assert(scale and type(scale) == "number", "[ERROR] ResHelper: scale must be a number.")

    if(skeletonFile and skeletonFile ~= "" and atlasFile and atlasFile ~= "" and scale and type(scale) == "number") then 
        cancelCallback(target, callback)
        avalon.ResManager:getInstance():unloadSpine(skeletonFile, atlasFile, scale)
    else 
        printError("ResHelper:unloadSpine =", skeletonFile, atlasFile, scale)
    end
end

-- 是否加载过plist
function ResHelper:isLoadedForSpine(skeletonFile, atlasFile, scale)
    assert(skeletonFile and type(skeletonFile) == "string", "[ERROR] ResHelper: skeletonFile must be a string.")
    assert(atlasFile and type(atlasFile) == "string", "[ERROR] ResHelper: atlasFile must be a string.")

    if (not scale) then
        scale = 1.0
    end
    return avalon.ResManager:getInstance():isLoadedForSpine(skeletonFile, atlasFile, scale)
end
----------------------------------------------------------------

-- 资源集合
----------------------------------------------------------------
-- 加载plists
function ResHelper:loadPlists(plists, target, callback)
    assert(plists and type(plists) == "table", "[ERROR] ResHelper: plists must be a table.")

    avalon.ResManager:getInstance():beginLoading(target, callback)
    for i = 1, #plists do
        avalon.ResManager:getInstance():pushPlist(plists[i])
    end
    avalon.ResManager:getInstance():endLoading()
end

-- 加载开始资源集合
function ResHelper:beginLoading(target, callback)
    local id = registerCallback(target, callback)
    avalon.ResManager:getInstance():beginLoading(id)
end

-- 结束
function ResHelper:endLoading()
    avalon.ResManager:getInstance():endLoading()
    avalon.ResManager:getInstance():startLoading()
end


function ResHelper:unloadUIAnimationTexture(jsonFile)
    if jsonFile == nil then
        return
    end
    if not string.find( jsonFile,".json" ) then
        print("error ResHelper:unloadUIAnimationTexture ",jsonFile)
        return
    end
    local fileName = string.gsub( jsonFile,".json",".pvr.ccz" )
    -- print("卸载动画资源 ",fileName)
    textureCache:removeTextureForKey(fileName)
end
----------------------------------------------------------------





