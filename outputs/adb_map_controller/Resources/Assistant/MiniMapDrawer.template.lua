-- CODEX_MAP_HELPER_BEGIN
-- 注入游戏 MiniMapDrawer 的只读逻辑地图导出器。
local function codexSafeCall(object, method, default)
    if object == nil or type(object[method]) ~= "function" then return default end
    local ok, value = pcall(object[method], object)
    if ok then return value end
    return default
end

-- 混乱状态和按钮排列必须来自同一次人物状态读取。
-- 方向排列是洞窟内缓存，不能只看残留的排列数组判断混乱是否仍然生效。
local function codexReadConfusionState()
    local confused = false
    local confuseDirections = {}
    pcall(function()
        local GameDataManager = require "app.game.GameDataManager"
        local gameDataManager = GameDataManager and GameDataManager:getInstance() or nil
        local masterData = gameDataManager and codexSafeCall(gameDataManager, "getMaster", nil) or nil
        confused = masterData and codexSafeCall(masterData, "isConfuse", false) == true or false
    end)
    pcall(function()
        -- MasterDataManager 通过全局表暴露接口；显式 require，避免轻量导出
        -- 先于战斗 UI 初始化时只能看到 nil。
        pcall(require, "app.datas.MasterDataManager")
        if type(MasterDataManager) ~= "table" then return end
        local caveData = codexSafeCall(MasterDataManager, "getSaveGameInCaveData", nil)
        local arr = caveData and codexSafeCall(caveData, "getConfuseDirection", {}) or {}
        for i, direction in ipairs(arr or {}) do confuseDirections[i] = direction end
    end)
    if not confused then confuseDirections = {} end
    return confused, confuseDirections
end

local function codexRoleOccupySize(role)
    local size = codexSafeCall(role, "getOccupySize", nil)
    if type(size) ~= "table" then return 1, 1 end
    local width = tonumber(size[1] or size.width) or 1
    local height = tonumber(size[2] or size.height) or 1
    return math.max(1, width), math.max(1, height)
end

local function codexJsonEncode(value)
    local valueType = type(value)
    if valueType == "nil" then return "null" end
    if valueType == "boolean" then return value and "true" or "false" end
    if valueType == "number" then
        if value ~= value or value == math.huge or value == -math.huge then return "null" end
        return tostring(value)
    end
    if valueType == "string" then
        return '"' .. value:gsub('[%z\1-\31\\"]', function(character)
            local escapes = {['"']='\\"', ['\\']='\\\\', ['\b']='\\b', ['\f']='\\f', ['\n']='\\n', ['\r']='\\r', ['\t']='\\t'}
            return escapes[character] or string.format('\\u%04x', string.byte(character))
        end) .. '"'
    end
    if valueType ~= "table" then return codexJsonEncode(tostring(value)) end
    local count, maximum, isArray = 0, 0, true
    for key in pairs(value) do
        count = count + 1
        if type(key) ~= "number" or key < 1 or key % 1 ~= 0 then isArray = false; break end
        if key > maximum then maximum = key end
    end
    local parts = {}
    if isArray and maximum == count then
        for index = 1, maximum do parts[#parts + 1] = codexJsonEncode(value[index]) end
        return "[" .. table.concat(parts, ",") .. "]"
    end
    for key, item in pairs(value) do
        parts[#parts + 1] = codexJsonEncode(tostring(key)) .. ":" .. codexJsonEncode(item)
    end
    return "{" .. table.concat(parts, ",") .. "}"
end

local function codexCommitFile(temporary, target)
    local ok, renamed = pcall(os.rename, temporary, target)
    if ok and renamed then return end
    os.remove(target)
    assert(os.rename(temporary, target))
end

-- CODEX_TEST_PANEL_COMMAND_BEGIN
-- 桌面助手通过应用私有目录投递一次性命令，避免依赖测试按钮在屏幕上的位置。
local codexTestPanelCommandPath = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_test_panel.command"
local codexTestPanelCommandWorkPath = codexTestPanelCommandPath .. ".processing"
local codexTestPanelResultPath = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_test_panel.result"

local function codexWriteTestPanelResult(message)
    local temporary = codexTestPanelResultPath .. ".tmp"
    local file = io.open(temporary, "wb")
    if not file then return end
    file:write(tostring(os.time()) .. " " .. tostring(message))
    file:close()
    pcall(function() codexCommitFile(temporary, codexTestPanelResultPath) end)
end

local function codexPollTestPanelCommand()
    -- rename 在同一目录内作为轻量 claim，避免城镇/洞窟同时存在多个 MiniMapDrawer
    -- 时重复消费同一个请求。
    local claimed = os.rename(codexTestPanelCommandPath, codexTestPanelCommandWorkPath)
    if not claimed then return end

    local file = io.open(codexTestPanelCommandWorkPath, "rb")
    if not file then
        pcall(function() os.rename(codexTestPanelCommandWorkPath, codexTestPanelCommandPath) end)
        return
    end
    local command = file:read("*a")
    file:close()

    if command ~= "open_test_panel" then
        os.remove(codexTestPanelCommandWorkPath)
        codexWriteTestPanelResult("unknown command")
        return
    end

    local ok, errorMessage = pcall(function()
        if UI == nil or UI.UIManager == nil or type(UI.UIManager.addNewTestComponent) ~= "function" then
            error("UIManager:addNewTestComponent unavailable")
        end
        UI.UIManager:addNewTestComponent()
    end)
    if ok then
        os.remove(codexTestPanelCommandWorkPath)
        codexWriteTestPanelResult("ok")
    else
        -- 面板尚未初始化时保留请求，下一次轮询继续尝试。
        pcall(function() os.rename(codexTestPanelCommandWorkPath, codexTestPanelCommandPath) end)
        codexWriteTestPanelResult("failed: " .. tostring(errorMessage))
    end
end
-- CODEX_TEST_PANEL_COMMAND_END

-- Boss 缓存可能跨楼层转场保留。只有在当前地图键有效期间缓存发生变化后，
-- 才接受其中的值。
local codexBossMapKey = nil
local codexBossCacheRef = nil
local codexBossSnapshot = nil

local function codexCollectTownIcons()
    local townIcons = {}
    pcall(function()
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        local model = machine and (machine._model or codexSafeCall(machine, "getModel", nil))
        local modelArr = model and codexSafeCall(model, "getAllFunctionNpcArr", {}) or {}
        local seen = {}
        for _, modelData in ipairs(modelArr or {}) do
            local role = codexSafeCall(modelData, "getData", modelData)
            local templateID = codexSafeCall(role, "getId", -1)
            local iconMap = nil
            pcall(function()
                if ConfigManager and type(ConfigManager.getIconMapByID) == "function" then
                    iconMap = ConfigManager:getIconMapByID(templateID)
                end
            end)
            local position = iconMap and iconMap.position or nil
            if type(position) == "table" then
                local x = tonumber(position[1] or position.x) or -1
                local y = tonumber(position[2] or position.y) or -1
                local spriteID = codexSafeCall(role, "getSpriteID", 0)
                local key = spriteID ~= 0 and tostring(spriteID) or tostring(templateID)
                if x >= 0 and y >= 0 and not seen[key] then
                    seen[key] = true
                    townIcons[#townIcons + 1] = {
                        x = x, y = y,
                        spriteID = spriteID,
                        templateID = templateID,
                        className = role.__cname,
                        roleType = codexSafeCall(role, "getType", -1),
                        minimapType = codexSafeCall(role, "getTypeForMinimap", -1),
                        treasureType = codexSafeCall(role, "getTreasureType", -1),
                        opened = codexSafeCall(role, "getIsOpen", false),
                    }
                end
            end
        end
    end)
    return townIcons
end

local function codexExportCurrentMap()
    local statusPath = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_map_status.txt"
    local function writeStatus(message)
        local statusFile = io.open(statusPath, "wb")
        if statusFile then
            statusFile:write(tostring(os.time()) .. " " .. tostring(message))
            statusFile:close()
        end
    end
    local ok, result = pcall(function()
        local GameMapManager = require "app.game.GameMapManager"
        local mapData = GameMapManager:getInstance():getMapData()
        if mapData == nil then writeStatus("MapData=nil"); return end
        local width, height = mapData:getSize()
        local source = mapData:getTileDataMap()
        local bossSeal = { spriteID = 0, curScore = 0, wakeScore = 0, present = false }
        pcall(require, "app.datas.MasterDataManager")
        if MasterDataManager then
            local cache = MasterDataManager._curCaveBossInfoCache
            if cache then
                -- bossSeal 仅在本次导出调用中有效，因此每次调用都复制当前缓存，
                -- 而不是依赖过期快照。
                local spriteID = tonumber(cache.spriteID) or 0
                local curScore = tonumber(cache.curScore) or 0
                local wakeScore = tonumber(cache.wakeScore) or 0
                bossSeal.spriteID, bossSeal.curScore, bossSeal.wakeScore = spriteID, curScore, wakeScore
                bossSeal.present = spriteID ~= 0 or wakeScore ~= 0
            end
        end
        bossSeal.percent = bossSeal.wakeScore > 0
            and math.min(100, math.floor(bossSeal.curScore * 100 / bossSeal.wakeScore)) or 0
        bossSeal.ready = bossSeal.wakeScore > 0 and bossSeal.curScore >= bossSeal.wakeScore

        local rows, player, masterRole = {}, nil, nil
        local townIcons = codexCollectTownIcons()
        local allExplored = false
        pcall(function() allExplored = mapData.ISeeDeadPeople == true end)
        local mapTitle = codexSafeCall(mapData, "getTitle", "")
        local mapName = ""
        pcall(function()
            local LanguageManager = require "app.game.LanguageManager"
            local localized = LanguageManager:getInstance():getLocalString(mapTitle)
            if localized ~= nil then mapName = tostring(localized) end
        end)
        if mapName == "" and type(mapTitle) == "string" then mapName = mapTitle end

        local masterFsmState, masterDead = -1, false
        pcall(function()
            local MachineManager = require("app.game.MachineManager")
            local machine = MachineManager:getInstance():getMachine()
            local model = machine and machine:getModel()
            local master = model and model:getMaster()
            if master then
                masterFsmState = codexSafeCall(master, "getState", -1)
                masterDead = codexSafeCall(master, "getIsDead", false)
            end
        end)

        for y = 0, height - 1 do
            local row = {}
            for x = 0, width - 1 do
                local tile = source[y + 1] and source[y + 1][x + 1] or nil
                if tile then
                    local roles = {}
                    local placeholders = {}
                    for _, role in ipairs(codexSafeCall(tile, "getRoleDatas", {}) or {}) do
                        local masterHero = codexSafeCall(role, "isMasterHero", false)
                        local occupyWidth, occupyHeight = codexRoleOccupySize(role)
                        roles[#roles + 1] = {
                            className = role.__cname,
                            spriteID = codexSafeCall(role, "getSpriteID", 0),
                            templateID = codexSafeCall(role, "getId", -1),
                            category = codexSafeCall(role, "getCategory", -1),
                            roleType = codexSafeCall(role, "getType", -1),
                            -- TriggerNpcData:getTransdoorType() 返回服务器提供的 extendValue。
                            -- 客户端使用 ROOM_TO_ROOM=3 加上 isRandomTransfer，
                            -- 选择紫色随机房间传送门动画。
                            transdoorType = codexSafeCall(role, "getTransdoorType", -1),
                            isRandomTransfer = codexSafeCall(role, "getIsRandomTransfer", false),
                            deformationCategory = codexSafeCall(role, "getDeformationCategory", -1),
                            deformationType = codexSafeCall(role, "getDeformationType", -1),
                            minimapType = codexSafeCall(role, "getTypeForMinimap", -1),
                            treasureType = codexSafeCall(role, "getTreasureType", -1),
                            occupyWidth = occupyWidth,
                            occupyHeight = occupyHeight,
                            talkRange = codexSafeCall(role, "getTalkRange", 0),
                            locked = codexSafeCall(role, "getIsLock", false),
                            opened = codexSafeCall(role, "getIsOpen", false),
                            monsterType = codexSafeCall(role, "getMonsterType", -1),
                            monsterSubType = codexSafeCall(role, "getMonsterSubType", -1),
                            normalMonster = codexSafeCall(role, "isNormalMonster", false),
                            eliteMonster = codexSafeCall(role, "isEliteMonster", false),
                            smallBoss = codexSafeCall(role, "isSmallBoss", false),
                            bigBoss = codexSafeCall(role, "isBigBoss", false),
                            groupMonster = codexSafeCall(role, "getIsGroupMonster", false),
                            masterHero = masterHero,
                        }
                        if masterHero then player = {x = x, y = y}; masterRole = role end
                    end
                    for _, placeholder in ipairs(codexSafeCall(tile, "getPlaceholderDatas", {}) or {}) do
                        local associatedCoord = placeholder.associatedCoord or {}
                        placeholders[#placeholders + 1] = {
                            typeName = codexSafeCall(placeholder, "getTypeName", placeholder.typeName or ""),
                            associatedID = codexSafeCall(placeholder, "getAssocialtedID", placeholder.associatedID or 0),
                            associatedX = tonumber(associatedCoord.x or associatedCoord[1]) or -1,
                            associatedY = tonumber(associatedCoord.y or associatedCoord[2]) or -1,
                            reachable = codexSafeCall(placeholder, "isReachable", false),
                            nodeOfPath = codexSafeCall(placeholder, "canBeNodeOfPath", false),
                            endOfPath = codexSafeCall(placeholder, "canBeEndOfPath", false),
                        }
                    end
                    row[x + 1] = {
                        x = x, y = y,
                        terrainType = codexSafeCall(tile, "getTerrainType", -1),
                        reachable = codexSafeCall(tile, "isReachable", false),
                        reached = codexSafeCall(tile, "isReached", false),
                        explored = codexSafeCall(tile, "hasExplored", false),
                        showIcon = codexSafeCall(tile, "hasShowIcon", false),
                        roles = roles,
                        placeholders = placeholders,
                    }
                else
                    row[x + 1] = false
                end
            end
            rows[y + 1] = row
        end

        local confused, confuseDirections = codexReadConfusionState()
        local snapshot = {
            schema = 1, timestamp = os.time(),
            width = width, height = height,
            level = codexSafeCall(mapData, "getLevel", 0),
            sceneType = codexSafeCall(mapData, "getSceneType", -1),
            caveMode = codexSafeCall(mapData, "getCaveMode", -1),
            mapName = mapName,
            player = player, tiles = rows, bossSeal = bossSeal,
            allExplored = allExplored,
            inBattle = masterFsmState == 3,
            isDead = masterDead or masterFsmState == 4,
            confused = confused,
            confuseDirections = confuseDirections,
            townIcons = townIcons,
        }
        local target = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_map_dump.json"
        local temporary = target .. ".tmp"
        local file = assert(io.open(temporary, "wb"))
        file:write(codexJsonEncode(snapshot))
        file:close()
        codexCommitFile(temporary, target)
        writeStatus("ok " .. width .. "x" .. height)
    end)
    if not ok then
        writeStatus("failed: " .. tostring(result))
        print("codex map export failed: " .. tostring(result))
    end
end

-- 轻量级移动反馈。此处避免遍历完整格子表，
-- 使该回调可以以 20 Hz 运行。
local codexPlayerSequence = 0
local function codexExportPlayerStatus()
    pcall(function()
        local GameDataManager = require "app.game.GameDataManager"
        local GameMapManager = require "app.game.GameMapManager"
        local mapData = GameMapManager:getInstance():getMapData()
        if mapData == nil then return end
        local width, height = mapData:getSize()
        local source = mapData:getTileDataMap()
        local player = nil
        for y = 0, height - 1 do
            local row = source[y + 1]
            if row then
                for x = 0, width - 1 do
                    local tile = row[x + 1]
                    if tile then
                        for _, role in ipairs(codexSafeCall(tile, "getRoleDatas", {}) or {}) do
                            if codexSafeCall(role, "isMasterHero", false) then
                                player = {x = x, y = y}
                                break
                            end
                        end
                    end
                    if player then break end
                end
            end
            if player then break end
        end
        codexPlayerSequence = codexPlayerSequence + 1
        local confused, confuseDirections = codexReadConfusionState()
        local gameDataManager = GameDataManager and GameDataManager:getInstance() or nil
        local moveSpeed = codexSafeCall(gameDataManager, "getMoveSpeed", 0)
        local snapshot = {
            schema = 1,
            sequence = codexPlayerSequence,
            timestamp = os.time(),
            level = codexSafeCall(mapData, "getLevel", 0),
            player = player,
            moveSpeed = tonumber(moveSpeed) or 0,
            confused = confused,
            confuseDirections = confuseDirections,
        }
        local target = "/data/user/0/com.avalon.caveonline.cn.huawei/files/CaveOnline/codex_player_status.json"
        local temporary = target .. ".tmp"
        local file = assert(io.open(temporary, "wb"))
        file:write(codexJsonEncode(snapshot))
        file:close()
        codexCommitFile(temporary, target)
    end)
end
-- CODEX_MAP_HELPER_END

-- CODEX_MAP_SCHEDULERS_BEGIN
    self._codexMapScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(codexExportCurrentMap, 0.5, false)
    self._codexPlayerScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(codexExportPlayerStatus, 0.05, false)
    self._codexTestPanelScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(codexPollTestPanelCommand, 0.2, false)
-- CODEX_MAP_SCHEDULERS_END

-- CODEX_MAP_CLEANUP_BEGIN
    if self._codexMapScheduler ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._codexMapScheduler)
        self._codexMapScheduler = nil
    end
    if self._codexPlayerScheduler ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._codexPlayerScheduler)
        self._codexPlayerScheduler = nil
    end
    if self._codexTestPanelScheduler ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._codexTestPanelScheduler)
        self._codexTestPanelScheduler = nil
    end
-- CODEX_MAP_CLEANUP_END
