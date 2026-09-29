local MapHelper = require "app.mapkit.MapHelper"
local MapDefine = require "app.mapkit.MapDefine"
local MapDecoration = require "app.mapkit.object.MapDecoration"
local TownMapOptimization = require "app.mapkit.MapOptimization.TownMapOptimization"
local lume = require "thirdparty.lume"
-- 可以显示在屏幕中的半径范围
local VISIBLE_RADIUS = 5

local TownMap = class("TownMap", function () return cc.Node:create() end)

function TownMap:ctor(mapData, enableOptimization)
	self.mapData = mapData
	self.mapName = mapData.appearanceConfig.name
    self.decorationPlist = mapData.appearanceConfig.decorationPlist
	self.sizeX = mapData.width or 0
	self.sizeY = mapData.height or 0
	self.tileWidth = mapData.tileWidth
    self.tileHeight = mapData.tileHeight
    self.tileWidthHalf = self.tileWidth * 0.5
    self.tileHeightHalf = self.tileHeight * 0.5
    self.width = self.sizeX * self.tileWidth
    self.height = self.sizeY * self.tileHeight
    self.centerCoordX = 0 
    self.centerCoordY = 0

    self.enableOptimization = enableOptimization or false
    self.townMapOptimization = nil

    -- add by zp 记录可以互动的装饰物列表，是否可以交互是通过获取装饰物是否有指定区域的处理。
    self.tapBoxDecorationArr = {}
    
    self:init()


    if (device.platform == "android") then
        -- 处理在安卓上一些特殊情况下(深度睡眠返回丢失GLContext)的RenderTexture渲染BUG
        local listener = cc.EventListenerCustom:create(EVENT_RENDERER_RECREATED, function(event)
            local layerCount = MapDefine.LayerCount 
            for i = 1, layerCount do
                if self.layers and not tolua.isnull(self.layers[i]) then
                    local oldScale = self.layers[i]:getScale()
                    self.layers[i]:setScale(0.9)
                    self.layers[i]:setScale(oldScale)
                end
            end
        end)
        cc.Director:getInstance():getEventDispatcher():addEventListenerWithFixedPriority(listener, 1)
    end
end

function TownMap:init()
    self:setContentSize(MapHelper.coordinateSizeToContentSize(self.sizeX, self.sizeY, self.tileWidth, self.tileHeight))
    printf("TownMap contentSize: %d,%d\n", self:getContentSize().width, self:getContentSize().height)

    local mapPlist = self.mapName .. ".plist"
    Avalon.ResHelper:loadPlistSync(mapPlist)
    local decorationPlist = self.mapName .. "_decoration.plist"
    Avalon.ResHelper:loadPlistSync(decorationPlist)

    if self.decorationPlist ~= nil then
        if type(self.decorationPlist) == "table" then
            for _, plist in ipairs(self.decorationPlist) do
                Avalon.ResHelper:loadPlistSync(plist)
            end
        elseif type(self.decorationPlist) == "string" then 
            Avalon.ResHelper:loadPlistSync(self.decorationPlist)
        end
    end

    -- -- create enough layers for map
    local textureCacheLayer = nil
    self.layers = {}
    local layerCount = MapDefine.LayerCount 
    for i = 1, layerCount do
        local layer = nil
        if (i == MapDefine.LayerIndexGround) then
            -- 缓存层 缓存整块地面
            textureCacheLayer = cc.Layer:create()
            textureCacheLayer:setToCacheTexture(true)
            textureCacheLayer:setDisableTrimCacheTexture(true)
            if (textureCacheLayer.setTextureCacheRim) then 
                textureCacheLayer:setTextureCacheRim(162, 81)
            end
            self:addChild(textureCacheLayer)

            -- 实际的层
            layer = cc.Node:create()
            textureCacheLayer:addChild(layer)
        elseif (i == MapDefine.LayerIndexNodeOnGround) then
            -- 也缓存地面上的一层
            layer = cc.Layer:create()
            if (textureCacheLayer) then
                textureCacheLayer:addChild(layer)
            else
                self:addChild(layer)
            end
        else
            -- 其他地图层不缓存
            layer = cc.Layer:create()
            self:addChild(layer)
        end
        self.layers[i] = layer
    end

    self.tileTerrainMap = {}    
    self.decorationsMap = {}
    self.mapObjectsMap = {}

    if (self.enableOptimization) then self:initWithOptimization()
    else self:initWithNoOptimization()
    end

    -- Debug coordinate
    if MapHelper.showDebugCoordinates or MapHelper.showDebugZOrders then
        for y = self.sizeY, 1, -1 do
            for x = self.sizeX, 1, -1 do
                local cx, cy = x - 1, y - 1
                local posX, posY = self:coordinateToPosition(cx, cy)
                local zOrder = self:getZOrderByCoordinate(cx, cy, 0)
                local str = ""
                if MapHelper.showDebugCoordinates then
                    str = str .. cx .. "," .. cy
                end
                if MapHelper.showDebugZOrders then
                    str = str .. "z:" .. zOrder
                end

                local label = cc.Label:createWithSystemFont(str, UI.SYS_FONT, 12)
                self:addChild(label)
                label:setColor(cc.c3b(255, 255, 255))
                local labelPosY = posY
                label:setPosition(posX, labelPosY)
                label:setLocalZOrder(zOrder + 1000)
            end
        end
    end
end

function TownMap:initWithOptimization()
    -- todo 暂时解决ipad显示不完整的问题。还需要优化,根据设备来显示。
    self.townMapOptimization = TownMapOptimization:create()
    self.townMapOptimization:init(self, 24)
end

function TownMap:initWithNoOptimization()
    for y = self.sizeY, 1, -1 do
        self.tileTerrainMap[y] = {}
        self.decorationsMap[y] = {}
        self.mapObjectsMap[y] = {}

        for x = self.sizeX, 1, -1 do
            local cx, cy = x - 1, y - 1
            local posX, posY = self:coordinateToPosition(cx, cy)
            local tileData = self.mapData:getTileDataAtCoord(cx, cy)
            if tileData ~= nil then
                -- terrain 
                local terrainData = tileData:getTerrainData()
                if  terrainData ~= nil then
                    local terrainNames = terrainData:getTerrainNames()
                    if terrainNames ~= nil and #terrainNames > 0 then
                        local texName = MapHelper.getMapTileTerrainColoredTextureName(terrainNames[1], terrainData:getCategory()) 
                        if texName ~= nil and #texName > 0 then
                            local tile = cc.Sprite:createWithSpriteFrameName(texName) 
                            if tile ~= nil then
                                self:addNodeGround(tile)
                                tile:setAnchorPoint(0.5, (tile:getContentSize().height - self.tileHeightHalf) / tile:getContentSize().height)
                                tile:setPosition(posX, posY)
                                tile:setCascadeOpacityEnabled(false)
                                tile:setCascadeColorEnabled(false)
                                tile:setName("<MapTile | x = " .. cx .. ", y = " .. cy .. ">")
                                -- tile:setVisible(false)

                                self.tileTerrainMap[cy+1][cx+1] = tile
                            end
                        end
                    end
                end

                -- print("ddddddddddddddddddvvvvddddddddddddddddd", cx, cy)

                -- town deocraitons and buildings 
                local decorationDatas = tileData.decorationDatas
                for _, decorationData in ipairs(decorationDatas) do
                    local decoration = MapDecoration:create(self, decorationData, self.tileWidth, self.tileHeight)
                    if decoration ~= nil then
                        -- local decorations = self:getDecorations(cx, cy)
                        -- if decorations == nil then
                        --     decorations = {}
                        --     self:setDecorations(cx, cy, decorations)
                        -- end 
                        decoration:setCoordinate(cx, cy)
                        -- decoration:setVisible(false)
                        -- lume.push(decorations, decoration)

                        local zOrder = self:getDecorationProperZOrder(decorationData, cx, cy)
                        local posX, posY = self:coordinateToPosition(cx, cy)
                        decoration:addToMap(self, {x = posX, y = posY}, zOrder)
                        -- decoration:setVisible(false)

                        self.decorationsMap[cy+1][cx+1] = decoration

                        if MapHelper.showDebugBoundingBox then
                            self:drawDecorationDebugBox(decoration)
                        end
                    end
                end
            end
        end
    end
end

function TownMap:screenCenterToCoord(centerCoordX, centerCoordY, animated, moveDuration, isSync, isEaseInOut, cb)
    local oldCenter = self:getCenterCoord()
    self.centerCoordX = centerCoordX
    self.centerCoordY = centerCoordY

    local mapPosX, mapPosY = self:coordinateToMapPosition(centerCoordX, centerCoordY)
    local mapOffsetY = self.tileHeightHalf * -1
    mapPosY = mapPosY + mapOffsetY;
    if animated then
        local moveAction = cc.MoveTo:create(moveDuration or MapHelper.moveOneTileDuration, {x = mapPosX, y = mapPosY})
        if (isEaseInOut) then moveAction = cc.EaseInOut:create(moveAction, MapHelper.CAMERA_MOVE_CURVE) end
        self:runAction(cc.Sequence:create(
            moveAction,
            cc.CallFunc:create(function()
                self:setPosition(mapPosX, mapPosY)
                if (cb) then cb() end
            end)))

        -- 移动途中更新地图显示, 避免走出优化位置出现空白地图
        local posX, posY = self:getPosition()
        local scale = self:getScale()
        local curCordX, curCordY = self:mapPositionToCoordinate(posX / scale, posY / scale)
        local distX = centerCoordX - curCordX
        local distY = centerCoordY - curCordY
        local dist = math.ceil(math.pow(math.pow(distX, 2) + math.pow(distY, 2), 1/2))
        if (dist > 5) then
            local unitTime = dist >= 1 and moveDuration / dist or 0
            if (dist > 0) then
                for i=1,dist do
                    local timeNow = i * unitTime
                    local progress = timeNow / moveDuration
                    performWithDelay(self, function() 
                        -- 更新地图
                        self:updateMapTileAround(math.floor(curCordX + progress * distX), math.floor(curCordY + progress * distY))
                    end, timeNow)
                end
            end 
        end
    else
        -- add by zp 这里由于打开了界面，会导致直接拖动效果会受到移动以及缩放的影响
        if(isSync) then
            self:stopAllActions()
        end
        self:setScale(1)
        self:setPosition(mapPosX, mapPosY)
        if (cb) then cb() end
    end
    return mapPosX, mapPosY
end

-- Coordinate, Position and Z Order
function TownMap:getCenterPositionOfBoundingBox(cx, cy, cz, width, height)
    return MapHelper.getCenterPositionOfBoundingBox(cx, cy, cz, width, height, self.tileWidth, self.tileHeight, MapDefine.ZAxisPixelsPerNormalizedUnit)
end

function TownMap:positionToCoordinate(x, y, z)
    z = z or 0
    local cx, cy, cz = MapHelper.positionToCoordinate(x, y, z, self.tileWidth, self.tileHeight, MapDefine.ZAxisPixelsPerNormalizedUnit)
    return cx, cy, cz
end

function TownMap:coordinateToPosition(cx, cy, cz)
    local cz = cz or 0
    local x, y, z = MapHelper.coordinateToPosition(cx, cy, cz, self.tileWidth, self.tileHeight, MapDefine.ZAxisPixelsPerNormalizedUnit)
    -- plus and half tile height to make position at center of tile
    y = y + self.tileHeightHalf
    return x, y, z
end

function TownMap:mapPositionToCoordinate(x, y, screenSize)
    local sz = screenSize or cc.Director:getInstance():getWinSize()
    local centerPosX, centerPosY = sz.width * 0.5 - x, sz.height * 0.5 - y
    local cx, cy = self:positionToCoordinate(centerPosX, centerPosY);
    return cx, cy
end

function TownMap:coordinateToMapPosition(cx, cy, screenSize)
    local sz = screenSize or cc.Director:getInstance():getWinSize()
    local centerPosX, centerPosY = self:coordinateToPosition(cx, cy)
    local mapPosX, mapPosY = -centerPosX + sz.width * 0.5, -centerPosY + sz.height * 0.5
    return mapPosX, mapPosY 
end

function TownMap:getZOrderByCoordinate(cx, cy, zOffset)
    -- assert(cx == math.floor(cx) and cy == math.floor(cy), "coordinate x and y must be integer")
    local zz = zOffset or 0 
    return (self.sizeX + self.sizeY - cx - cy) * MapDefine.ZOrderMaxOffsetPerCoordinate + zz
end

function TownMap:getBoundingProperZOrder(boundingPoint, x, y, width, height, z)
    return MapHelper.calculateZOrder(boundingPoint, x, y, width, height, 0, self.sizeX, self.sizeY)
end

function TownMap:getDecorationProperZOrder(decorationData, cx, cy)
    return self:getBoundingProperZOrder(decorationData.ZOrderBasePoint, cx, cy,  decorationData.occupySize.width, decorationData.occupySize.height)
    -- local zOrder = 0
    -- local ow = decorationData.occupySize.width
    -- local oh = decorationData.occupySize.height
    -- if ow > 0 or oh > 0 then
    --     if decorationData.ZOrderBasePoint == MapDefine.BoundingPoint.BottomLeft then
    --         zOrder = self:getZOrderByCoordinate(cx, cy, 0)
    --     elseif decorationData.ZOrderBasePoint == MapDefine.BoundingPoint.BottomRight then
    --         zOrder = self:getZOrderByCoordinate(cx + ow, cy, 0)
    --     elseif decorationData.ZOrderBasePoint == MapDefine.BoundingPoint.TopLeft then
    --         zOrder = self:getZOrderByCoordinate(cx, cy + oh, 0)
    --     elseif decorationData.ZOrderBasePoint == MapDefine.BoundingPoint.TopRight then
    --         zOrder = self:getZOrderByCoordinate(cx + ow, cy + oh, 0)
    --     elseif decorationData.ZOrderBasePoint == MapDefine.BoundingPoint.Center then
    --         zOrder = self:getZOrderByCoordinate(cx + ow / 2, cy + oh / 2, 0)
    --     end
    -- end
    -- return zOrder
end

-- map interfaces
function TownMap:getLayer(index)
    if index < 1 and index > MapDefine.LayerCount then
        return nil
    end
    return self.layers[index]
end

function TownMap:addNodeGround(node)
    local layer = self:getLayer(MapDefine.LayerIndexGround)
    if layer ~= nil then
        layer:addChild(node)
    end
end

function TownMap:addNodeOnGround(node)
    local layer = self:getLayer(MapDefine.LayerIndexNodeOnGround)
    if layer ~= nil then
        layer:addChild(node)
    end
end

function TownMap:addNodeOnMap(node)
    local layer = self:getLayer(MapDefine.LayerIndexNodeOnMap)
    if layer ~= nil then
        layer:addChild(node)
    end
end

function TownMap:addNodeBeyondMap(node)
    local layer = self:getLayer(MapDefine.LayerIndexNodeBeyondMap)
    if layer ~= nil then
        layer:addChild(node)
    end
end

function TownMap:updateTilesVisionAppearance()
end

function TownMap:isHiddenByWallAtCoord()
    return false
end

function TownMap:setMapObject(coordX, coordY, mapObject)
    if (self.enableOptimization) then
        self.townMapOptimization:setMapObject(coordX, coordY, mapObject)
    end
end

function TownMap:unsetMapObject(coordX, coordY, mapObject)
    if (self.enableOptimization) then
        self.townMapOptimization:unsetMapObject(coordX, coordY, mapObject)
    end
end

function TownMap:setPermanentVisible(coordX, coordY, mapObject)
    if (self.enableOptimization) then
        self.townMapOptimization:setPermanentVisible(coordX, coordY, mapObject)
    end
end

-- 移动过程中，更新屏幕范围内的地块
function TownMap:updateMapTileWhenMoving(centerCoordX, centerCoordY)
    if (self.enableOptimization) then
        self.townMapOptimization:updateMapTileWhenMoving(centerCoordX, centerCoordY)
    end
end
-- 显示屏幕范围内的所有地块
function TownMap:updateMapTileAround(centerCoordX, centerCoordY)
    if (self.enableOptimization) then
        self.townMapOptimization:updateMapTileAround(centerCoordX, centerCoordY)
    end
end
function TownMap:hideAllMapTileNotAround(centerCoordX, centerCoordY, progress)
    if (self.enableOptimization) then
        self.townMapOptimization:hideAllMapTileNotAround(centerCoordX, centerCoordY)
    end
end
function TownMap:addTrapDecoration(decoration)
    if(decoration) then
        table.insert(self.tapBoxDecorationArr, decoration)
    end
end

function TownMap:removeTrapDecoration(decoration)
    if(decoration) then
        for k =  #self.tapBoxDecorationArr, 1, -1 do
            local oldDecoration = self.tapBoxDecorationArr[k]
            if(oldDecoration == decoration) then
                table.remove(self.tapBoxDecorationArr, k)
            end
        end
    end
end

function TownMap:triggerClickMap(mapPosition)
    -- print("TownMap:triggerClickMap  ",mapPosition.x, mapPosition.y)
    if(self.tapBoxDecorationArr) then
        for k,decoration in ipairs(self.tapBoxDecorationArr) do 
            local spine = decoration:getSpine()
            local rect = spine:getBoudingBox("tapbox_1", false)
            -- print("TownMap:triggerClickMap click spine ",mapPosition.x, mapPosition.y, spine:getBoudingBox("tapbox_1", true))
            -- print("TownMap:triggerClickMap click spine ",mapPosition.x, mapPosition.y, spine:getBoudingBox("tapbox_1", false))
            if(rect and spine and cc.rectContainsPoint(rect, mapPosition)) then 
                --  print("TownMap:triggerClickMap click spine ddddddd ",mapPosition.x, mapPosition.y, spine:getBoudingBox("tapbox_1", false))
                decoration:clickSpine()
            end 
        end
    end 
end

-- 移除庄园装饰物
function TownMap:removeMapTileDecorationsByID(decorationID)
    if (self.enableOptimization) then
        self.townMapOptimization:removeMapTileDecorationsByID(decorationID)
    end
end

-- DEBUG 
function TownMap:drawDecorationDebugBox(decoration)
    if self.drawNode == nil then 
        self.drawNode = cc.DrawNode:create()
        self.drawNode:setLineWidth(2)
        self:addChild(self.drawNode, 999999)
    end

    local color = {r = math.random(), g = math.random(), b = math.random(), a = 1.0}
    -- local color = {r = 1.0, g = 0.0, b = 0.0, a = 1.0}

    local function convertCoordToPos(coord)
        local x, y, z = MapHelper.coordinateToPosition(coord.x, coord.y, 0, self.tileWidth, self.tileHeight, 0)
        return {x = x, y = y}
    end

    local function drawOccupyBox(bl, br, tl, tr)    
        self.drawNode:drawLine(bl, br, color)
        self.drawNode:drawLine(br, tr, color)
        self.drawNode:drawLine(tl, tr, color)
        self.drawNode:drawLine(bl, tl, color)
        -- print("===drawOccupyBox===", tostring(bl), tostring(br), tostring(tl), tostring(tr))
    end

    local occupyWidth = decoration:getOccupySize().width
    local occupyHeight = decoration:getOccupySize().height
    local cx, cy = decoration:getCoordinate()
    local bl, br, tl, tr = {}, {}, {}, {}
    bl = {x = cx, y = cy}
    br = {x = cx + occupyWidth, y = cy}
    tl = {x = cx, y = cy + occupyHeight}
    tr = {x = cx + occupyWidth, y = cy + occupyHeight}
    
    bl = convertCoordToPos(bl)
    br = convertCoordToPos(br)
    tl = convertCoordToPos(tl)
    tr = convertCoordToPos(tr)

    drawOccupyBox(bl, br, tl, tr)
end
function TownMap:removeAllElements()
    -- print("removeAllElements",self.tileTerrainMap == nil , self.decorationsMap == nil )
    if self.tileTerrainMap == nil and self.decorationsMap == nil then
        return
    end
    -- print("removeAllElements", self.sizeY,self.sizeX)
    for y = 1, self.sizeY do
        for x = 1, self.sizeX do
            local cx, cy = x - 1, y - 1
            local tileTerrain = self:getTileTerrain(cx, cy)
            if not tolua.isnull(tileTerrain) then
                tileTerrain:removeFromParent(true)
                tileTerrain:release()
                -- print("remove tile terrain at ", cx, cy)
            end
            local decorations = self:getDecorations(cx, cy)
            if decorations ~= nil and #decorations > 0 then
                for _, decoration in ipairs(decorations) do
                    decoration:destroy()
                end
                -- print("remove decorations at ", cx, cy)
            end
            -- 主城地图没有特效颜色
            -- local effectColors = self:getEffectColors(cx, cy)
            -- if effectColors ~= nil and #effectColors > 0 then
            --     for _, effectColor in ipairs(effectColors) do
            --         effectColor:destroy()
            --     end
            --     print("remove effectColors at ", cx, cy)
            -- end
            -- if MapHelper.showDebugCoordinates or MapHelper.showDebugZOrders then
            --     if self.coordLabelsMap[y] ~= nil then
            --         local label = self.coordLabelsMap[y][x]
            --         if label ~= nil then
            --             label:removeFromParent()
            --         end
            --     end
            -- end
        end
    end
    lume.clear(self.tileTerrainMap)
    lume.clear(self.decorationsMap)
    -- lume.clear(self.coordLabelsMap)
end
function TownMap:getTileTerrain(coordX, coordY)
    if self.tileTerrainMap[coordY + 1] == nil then
        return nil
    end
    return self.tileTerrainMap[coordY + 1][coordX + 1]
end
-- function TownMap:getEffectColors(coordX, coordY)
--     if self.effectColorsMap[coordY + 1] == nil then
--         return nil
--     end
--     return self.effectColorsMap[coordY + 1][coordX + 1]
-- end
function TownMap:getDecorations(coordX, coordY)
    if self.decorationsMap[coordY + 1] == nil then
        return nil
    end
    return self.decorationsMap[coordY + 1][coordX + 1]
end
-- 释放资源
function TownMap:destroy()
    print("#### TownMap:destroy")
    local mapPlist = self.mapName .. ".plist"
    Avalon.ResHelper:unloadPlist(mapPlist)
    print("#### TownMap:destroy",mapPlist)
    local decorationPlist = self.mapName .. "_decoration.plist"
    print("#### TownMap:destroy",decorationPlist)
    Avalon.ResHelper:unloadPlist(decorationPlist)

    if self.decorationPlist ~= nil then
        if type(self.decorationPlist) == "table" then
            for _, plist in ipairs(self.decorationPlist) do
                Avalon.ResHelper:unloadPlist(plist)
            end
        elseif type(self.decorationPlist) == "string" then 
            Avalon.ResHelper:unloadPlist(self.decorationPlist)
        end
    end
end

function TownMap:getCenterCoord()
    return {x = self.centerCoordX, y = self.centerCoordY}
end
return TownMap
