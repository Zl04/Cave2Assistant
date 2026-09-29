--[[
    场景地图优化 - 城镇地图
]]

local MapTileTerrain = require "app.mapkit.object.MapTileTerrain"
local MapTileEffectColor = require "app.mapkit.object.MapTileEffectColor"
local MapDecoration = require "app.mapkit.object.MapDecoration"
local MapOptimization = require "app.mapkit.MapOptimization.MapOptimization"
local MapDefine = require "app.mapkit.MapDefine"
local MapHelper = require "app.mapkit.MapHelper"
local ObjectPool = require "utils.ObjectPool"
local lume = require "thirdparty.lume"

local DEBUG = false

local CaveMapOptimization = class("CaveMapOptimization", MapOptimization)

-- 初始化
-- @map 地图对象
-- @visibleRadius 可视范围（半径）
function CaveMapOptimization:init(map)
    self.isCave = true
    CaveMapOptimization.super.init(self, map, self:getVisibleRadius(map))

    -- 地块地形对象池
    self._mapTileTerrainPool = ObjectPool:create(
        function()
            return MapTileTerrain:create(nil, self._tileWidth, self._tileHeight, MapDefine.FarestTileColorLevel)
        end,
        function(mapTileTerrain)
            if (mapTileTerrain) then mapTileTerrain:destroy()
            else assert(false)
            end
        end,
        1,
        60
    )
    -- 地块上的effectcolor的缓存池
    self._mapTileEffectColorsCache = {}
end

-- 销毁
function CaveMapOptimization:destroy()
    CaveMapOptimization.super.destroy(self)

    self._mapTileTerrainPool:destroy()
    
    for index, effectColors in pairs(self._mapTileEffectColorsCache) do
        if (effectColors) then
            for i = 1, #effectColors do
                local effectColor = effectColors[i]
                if (effectColor) then
                    effectColor:destroy()
                end
            end
        end
    end
    self._map:removeAllElements();
end

-- 创建一个地块的地形对象
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function CaveMapOptimization:createMapTileTerrain(coordX, coordY)
    local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)

    if (mapTileData) then
        if (DEBUG) then
            print("CaveMapOptimization createMapTileTerrain: ", coordX, coordY, coordZ, posX, posY)
        end

        local coordZ = mapTileData:getZ()
        local posX, posY, offsetY = self._map:coordinateToPosition(coordX, coordY, coordZ)
        local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
        posY = posY + offsetY
        
        local tileTerrain = self._mapTileTerrainPool:getObject()
        if (tileTerrain) then         
            local terrainData = mapTileData.terrainData
            terrainData.x = coordX
            terrainData.y = coordY
            tileTerrain:set(terrainData, self._tileWidth, self._tileHeight, self._map)                                                             
            tileTerrain:addToMap(self._map, {x = posX, y = posY, coordX = coordX, coordY = coordY}, zOrder)

            self._map:setTileTerrain(coordX, coordY, tileTerrain)

            return tileTerrain
        end
    end
    return nil
end

-- 移除一个地块的地形对象
-- @mapTileTerrain 被移除的地块地形
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function CaveMapOptimization:removeMapTileTerrain(mapTileTerrain, coordX, coordY)
    if (mapTileTerrain) then
        mapTileTerrain:removeFromMap()
        self._mapTileTerrainPool:returnObject(mapTileTerrain)

        self._map:setTileTerrain(coordX, coordY, nil)

        if (DEBUG) then
            print("CaveMapOptimization removeMapTileTerrain: ", coordX, coordY)
        end
    end
end

-- 更新一个地块的地形对象
function CaveMapOptimization:updateMapTileTerrain(mapTileData, coordX, coordY)
    local index = self:coordToIndex(coordX, coordY)
    -- 显示地块的地形
    local tileTerrain = self._tileTerrainMap[index]
    if (tileTerrain) then
        mapTileData.terrainData.x = coordX
        mapTileData.terrainData.y = coordY
        tileTerrain:setTerrainData(mapTileData.terrainData)
    end
end

-- 创建一个地块上的装饰物
-- @decorationData 装饰物数据
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function CaveMapOptimization:createMapTileDecoration(decorationData, coordX, coordY)
    local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)
    local coordZ = mapTileData and mapTileData:getZ() or 0
    local posX, posY, offsetY = self._map:coordinateToPosition(coordX, coordY, coordZ)
    -- local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
    local zOrder = self._map:getDecorationProperZOrder(decorationData, coordX, coordY)
    posY = posY + offsetY

    local decoration = MapDecoration:create(self._map, decorationData, self._tileWidth, self._tileHeight)
    if (decoration) then
        -- if (DEBUG) then
            -- printfmt("createMapTileDecoration: %s at %d,%d ", decorationData.skin, coordX, coordY)
        -- end

        decoration:setCoordinate(coordX, coordY)
        decoration:addToMap(self._map, {x = posX, y = posY}, zOrder)

        if MapHelper.showDebugBoundingBox then
            self._map:drawDecorationDebugBox(decoration)
        end

        local decorations = self._map:getDecorations(coordX, coordY)
        if (not decorations) then 
            decorations = {} 
            self._map:setDecorations(coordX, coordY, decorations)
        end
        lume.push(decorations, decoration)
        if not decorationData:isSkinPNG() then 
            lume.push(self._map.animatedDecorations, decoration)
        end
        return decoration
    end
    return nil
end

-- 创建一个地块上的effectcolors
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function CaveMapOptimization:createMapTileEffectColors(coordX, coordY)
    local index = self:coordToIndex(coordX, coordY)

    local effectColors = self._mapTileEffectColorsCache[index]
    if (effectColors) then
        for i = 1, #effectColors do
            local effectColor = effectColors[i]
            if (effectColor) then
                if (DEBUG) then
                    print("CaveMapOptimization createMapTileEffectColors add: ", coordX, coordY)
                end

                effectColor:addToMap()
            end
        end
        return effectColors
    else
        local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)
        if (mapTileData) then
            local effectColorDatas = self._mapData:getEffectColorDatasAtCoord(coordX, coordY)
            local tileTerrainData = mapTileData:getTerrainData()

            if (effectColorDatas ~= nil and #effectColorDatas > 0 and tileTerrainData ~= nil) then
                effectColors = {}
                self._map:setEffectColors(coordX, coordY, effectColors)
                self._mapTileEffectColorsCache[index] = effectColors

                local coordZ = mapTileData:getZ()
                local posX, posY, offsetY = self._map:coordinateToPosition(coordX, coordY, coordZ)
                local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
                posY = posY + offsetY

                if (DEBUG) then
                    print("CaveMapOptimization createMapTileEffectColors create: ", coordX, coordY)
                end

                for _, effectColorData in ipairs(effectColorDatas) do
                    local effectColor = MapTileEffectColor:create(tileTerrainData, effectColorData, self._tileWidth, self._tileHeight)
                    
                    if effectColor ~= nil then
                        effectColor:setCoordinate(coordX, coordY)
                        effectColor:addToMap(self._map, {x = posX, y = posY}, zOrder)

                        lume.push(effectColors, effectColor)
                    end
                end
                return effectColors
            end
        end
    end
    return nil
end

-- 移除一个地块上的effectcolors
-- @mapTileEffectColors 装饰物列表
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function CaveMapOptimization:removeMapTileEffectColors(mapTileEffectColors, coordX, coordY, clean)
    if (mapTileEffectColors) then
        if (DEBUG) then
            print("CaveMapOptimization removeMapTileEffectColors: ", coordX, coordY)
        end
        
        for i = 1, #mapTileEffectColors do
            local mapTileEffectColor = mapTileEffectColors[i]
            if (clean == nil) then
                mapTileEffectColor:removeFromMap()
            else
                mapTileEffectColor:destroy()
            end
        end
        if (clean) then
            local index = self:coordToIndex(coordX, coordY)
            self._mapTileEffectColorsCache[index] = nil
            self._map:setEffectColors(coordX, coordY, nil)
        end
    end
end
function CaveMapOptimization:hideAllMapTileNotAround(centerCoordX, centerCoordY)
    CaveMapOptimization.super.hideAllMapTileNotAround(self, centerCoordX, centerCoordY)
end
-- 更新一个地块上的effectcolors
function CaveMapOptimization:updateMapTileEffectColors(mapTileData, coordX, coordY)

end

-- 移动过程中，更新屏幕周围的地块
-- @centerCoordX 中心地块的x坐标
-- @centerCoordY 中心地块的y坐标
function CaveMapOptimization:updateMapTileWhenMoving(centerCoordX, centerCoordY)
    CaveMapOptimization.super.updateMapTileWhenMoving(self, centerCoordX, centerCoordY)

    self:checkDecorationsVisible()
end

-- 静止时，更新中心坐标周围的地块
-- @centerCoordX 中心地块的x坐标
-- @centerCoordY 中心地块的y坐标
function CaveMapOptimization:updateMapTileAround(centerCoordX, centerCoordY)
    CaveMapOptimization.super.updateMapTileAround(self, centerCoordX, centerCoordY)

    self:checkDecorationsVisible()
end


function MapOptimization:getVisibleRadius(map)
    local winSize = cc.Director:getInstance():getWinSize()
    local hwRatio = winSize.width / winSize.height    
    -- release_print("testtesttest, getVisibleRadius", winSize.width, winSize.height, winSize.width / winSize.height, 16 / 9, 1334/750, map.mapData:getLevel())
    if map.mapData:getLevel() == PublicDefine.CONST_DEFINITION.RAT_MAP_ID
        or map.mapData:getLevel() == PublicDefine.CONST_DEFINITION.PUZZLE_MAP_ID then
        return 15
    end
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isInLostRealm()) then 
        return 15
    end

    -- 把适应只iPad 4:3屏幕的比例分设备屏幕比例适配地图比例.
    -- 并且在90层以上地块颜色较浅, 扩大一级范围
    if (hwRatio > 1.7 and hwRatio < 1.8) then
        if (map.mapData and map.mapData:getLevel() % 30 > 19) then
            return 7
        else
            return 8
        end
    end
    return 9
end

return CaveMapOptimization