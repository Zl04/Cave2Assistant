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

local TownMapOpimization = class("TownMapOpimization", MapOptimization)

-- 初始化
-- @map 地图对象
-- @visibleRadius 可视范围（半径）
function TownMapOpimization:init(map, visibleRadius)
    self.isCave = false

    TownMapOpimization.super.init(self, map, visibleRadius)

    -- 地块地形对象池
    self._mapTileTerrainPool = ObjectPool:create(
        function()
            local sprite = cc.Sprite:create()
            sprite:retain()
            return sprite
        end,
        function(mapTileTerrain)
            if (mapTileTerrain) then 
                if (mapTileTerrain:getParent()) then
                    mapTileTerrain:removeFromParent()
                end
                mapTileTerrain:release()
            else 
                assert(false)
            end
        end,
        1,
        60
    )
end

-- 销毁
function TownMapOpimization:destroy()
    TownMapOpimization.super.destroy(self)
    
    self._mapTileTerrainPool:destroy()
    self._map:removeAllElements();
end

-- 创建一个地块的地形对象
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function TownMapOpimization:createMapTileTerrain(coordX, coordY)
    local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)

    if (mapTileData) then
        if (DEBUG) then
            print("TownMapOpimization createMapTileTerrain: ", coordX, coordY, coordZ, posX, posY)
        end

        local terrainData = mapTileData:getTerrainData()
        if (terrainData) then
            local posX, posY = self._map:coordinateToPosition(coordX, coordY)
            local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)

            local terrainNames = terrainData:getTerrainNames()
            if (terrainNames and #terrainNames > 0) then
                local texName = MapHelper.getMapTileTerrainColoredTextureName(terrainNames[1], terrainData:getCategory()) 
                if (texName and #texName > 0) then
                    local tile = self._mapTileTerrainPool:getObject()
                    if tile ~= nil then
                        tile:setSpriteFrame(texName)
                        tile:setAnchorPoint(0.5, (tile:getContentSize().height - self._tileHeight / 2) / tile:getContentSize().height)
                        tile:setPosition(posX, posY)
                        tile:setLocalZOrder(zOrder)
                        tile:setCascadeOpacityEnabled(false)
                        tile:setCascadeColorEnabled(false)
                        tile:setFlippedX(terrainData:getFilippedX())
                        tile:setName("<MapTile | x = " .. coordX .. ", y = " .. coordY .. ">")
                        self._map:addNodeGround(tile)

                        if (self._map.tileTerrainMap[coordY + 1] == nil) then
                            self._map.tileTerrainMap[coordY + 1] = {}
                        end
                        self._map.tileTerrainMap[coordY + 1][coordX + 1] = tile

                        return tile
                    end
                end
            end
        end
    end
    return nil
end

-- 移除一个地块的地形对象
-- @mapTileTerrain 被移除的地块地形
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function TownMapOpimization:removeMapTileTerrain(mapTileTerrain, coordX, coordY)
    if (mapTileTerrain) then
        mapTileTerrain:removeFromParent()
        self._mapTileTerrainPool:returnObject(mapTileTerrain)

        self._map.tileTerrainMap[coordY + 1][coordX + 1] = nil

        if (DEBUG) then
            print("TownMapOpimization removeMapTileTerrain: ", coordX, coordY)
        end
    end
end

-- 更新一个地块的地形对象
function TownMapOpimization:updateMapTileTerrain(mapTileData, coordX, coordY)
    -- TODO
end

-- 创建一个地块上的装饰物
-- @decorationData 装饰物数据
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function TownMapOpimization:createMapTileDecoration(decorationData, coordX, coordY)
    local posX, posY = self._map:coordinateToPosition(coordX, coordY)
    local zOrder = self._map:getDecorationProperZOrder(decorationData, coordX, coordY)

    local decoration = MapDecoration:create(self._map, decorationData, self._tileWidth, self._tileHeight)
    if decoration ~= nil then
        if (DEBUG) then
            print("TownMapOpimization createMapTileDecoration: ", coordX, coordY, zOrder)
        end

        decoration:setCoordinate(coordX, coordY)
        decoration:addToMap(self._map, {x = posX, y = posY}, zOrder)

        if MapHelper.showDebugBoundingBox then
            self._map:drawDecorationDebugBox(decoration)
        end

        if (self._map.decorationsMap[coordY + 1] == nil) then
            self._map.decorationsMap[coordY + 1] = {}
        end
        local decorations = self._map.decorationsMap[coordY + 1][coordX + 1]
        if (not decorations) then
            decorations = {}
            self._map.decorationsMap[coordY + 1][coordX + 1] = decorations
        end
        lume.push(decorations, decoration)

        return decoration
    end
    return nil
end

-- 创建一个地块上的effectcolors
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function TownMapOpimization:createMapTileEffectColors(coordX, coordY)
    return nil
end

-- 移除一个地块上的effectcolors
-- @mapTileEffectColors 装饰物列表
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function TownMapOpimization:removeMapTileEffectColors(mapTileEffectColors, coordX, coordY)
end

-- 移动过程中，更新屏幕周围的地块
-- @centerCoordX 中心地块的x坐标
-- @centerCoordY 中心地块的y坐标
function TownMapOpimization:updateMapTileWhenMoving(centerCoordX, centerCoordY)
    TownMapOpimization.super.updateMapTileWhenMoving(self, centerCoordX, centerCoordY)

    self:checkDecorationsVisible()
end
function TownMapOpimization:hideAllMapTileNotAround(centerCoordX, centerCoordY)
    TownMapOpimization.super.hideAllMapTileNotAround(self, centerCoordX, centerCoordY)
end
-- 静止时，更新中心坐标周围的地块
-- @centerCoordX 中心地块的x坐标
-- @centerCoordY 中心地块的y坐标
function TownMapOpimization:updateMapTileAround(centerCoordX, centerCoordY)
    TownMapOpimization.super.updateMapTileAround(self, centerCoordX, centerCoordY)

    self:checkDecorationsVisible()
end

function TownMapOpimization:removeMapTileDecorationsByID(decorationID)
    TownMapOpimization.super.removeMapTileDecorationsByID(self, decorationID)

    self:checkDecorationsVisible()
end

return TownMapOpimization