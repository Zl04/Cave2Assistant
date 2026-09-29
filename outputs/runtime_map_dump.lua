-- CaveOnline 逻辑地图的只读运行时导出器。
-- 在 GameMapManager 创建当前 MapData 后加载此模块。

local cjson = require "cjson"
local GameMapManager = require "app.game.GameMapManager"

local M = {}

local function call(object, method, default)
    if object == nil or type(object[method]) ~= "function" then
        return default
    end
    local ok, value = pcall(object[method], object)
    if ok then return value end
    return default
end

local function exportRole(role)
    return {
        className = role.__cname,
        spriteID = call(role, "getSpriteID", 0),
        id = call(role, "getId", 0),
        category = call(role, "getCategory", -1),
        type = call(role, "getType", -1),
        deformationCategory = call(role, "getDeformationCategory", -1),
        deformationType = call(role, "getDeformationType", -1),
        reachable = call(role, "isReachable", true),
        masterHero = call(role, "isMasterHero", false),
    }
end

local function exportTile(tile, x, y)
    local roles = {}
    local player = nil
    for _, role in ipairs(call(tile, "getRoleDatas", {}) or {}) do
        local value = exportRole(role)
        roles[#roles + 1] = value
        if value.masterHero then player = {x = x, y = y, spriteID = value.spriteID} end
    end

    return {
        x = x,
        y = y,
        terrainType = call(tile, "getTerrainType", -1),
        reachable = call(tile, "isReachable", false),
        reached = call(tile, "isReached", false),
        explored = call(tile, "hasExplored", false),
        showIcon = call(tile, "hasShowIcon", false),
        decorations = #(call(tile, "getDecorationDatas", {}) or {}),
        placeholders = #(call(tile, "getPlaceholderDatas", {}) or {}),
        roles = roles,
    }, player
end

function M.snapshot()
    local mapData = GameMapManager:getInstance():getMapData()
    assert(mapData ~= nil, "current MapData is nil")

    local width, height = mapData:getSize()
    local source = mapData:getTileDataMap()
    local rows = {}
    local player = nil

    for y = 0, height - 1 do
        local row = {}
        for x = 0, width - 1 do
            local tile = source[y + 1] and source[y + 1][x + 1] or nil
            if tile ~= nil then
                local value, foundPlayer = exportTile(tile, x, y)
                row[x + 1] = value
                if foundPlayer then player = foundPlayer end
            else
                row[x + 1] = cjson.null
            end
        end
        rows[y + 1] = row
    end

    return {
        schema = 1,
        width = width,
        height = height,
        level = call(mapData, "getLevel", 0),
        sceneType = call(mapData, "getSceneType", -1),
        caveMode = call(mapData, "getCaveMode", -1),
        player = player,
        tiles = rows,
    }
end

function M.write(path)
    local target = path or (cc.FileUtils:getInstance():getWritablePath() .. "codex_map_dump.json")
    local file, err = io.open(target, "wb")
    assert(file ~= nil, err)
    file:write(cjson.encode(M.snapshot()))
    file:close()
    print("runtime map exported: " .. target)
    return target
end

return M
