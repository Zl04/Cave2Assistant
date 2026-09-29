local grids = require "app.mapkit.grids"
local Grid = require "thirdparty.jumper.grid"
local Pathfinder = require "thirdparty.jumper.pathfinder"
local TextureAtlasOverlayer = require "app.mapkit.TextureAtlasOverlayer"
local lume = require "thirdparty.lume"
local MapHelper = require "app.mapkit.MapHelper"
local MapDefine = require "app.mapkit.MapDefine"
local MapTileTerrain = require "app.mapkit.object.MapTileTerrain"
local MapTileEffectColor = require "app.mapkit.object.MapTileEffectColor"
local MapDecoration = require "app.mapkit.object.MapDecoration"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local CaveMapOptimization = require "app.mapkit.MapOptimization.CaveMapOptimization"
local SceneManager = require("app.game.SceneManager")
local CaveMap = class("CaveMap", function () return cc.Node:create() end)

local GroundType = MapDefine.TerrainType.Ground
local WallType = MapDefine.TerrainType.Wall
local visionRadius = MapDefine.visionRadius
local wallShrinkCheckRadius = MapDefine.wallShrinkCheckRadius
local winSize = cc.Director:getInstance():getWinSize()

local oldtostring = CaveMap.__tostring
function CaveMap.__tostring(t)
    local name = t.mapName or "?"
    return string.format("CaveMap named '%s' %s", name, oldtostring(t))
end

function CaveMap:ctor(mapData, enableOptimization)
    self.mapData = mapData
	self.mapName = mapData.appearanceConfig.name
	self.sizeX = mapData.width or 0
	self.sizeY = mapData.height or 0
	self.tileWidth = mapData.tileWidth
    self.tileHeight = mapData.tileHeight
    self.tileWidthHalf = self.tileWidth * 0.5
    self.tileHeightHalf = self.tileHeight * 0.5
    self.width = self.sizeX * self.tileWidth
    self.height = self.sizeY * self.tileHeight
    self.randomOffect = checkint(mapData.appearanceConfig.nonAltitude) == 0
    -- center coordinate can be double, some times should call math.floor before using
    self.centerCoordX = 0 
    self.centerCoordY = 0

    self.lastCenterCoordX = 0
    self.lastCenterCoordY = 0
    self.showMapTileFlag = false

    self.pathLengthMapsCache = {}

    self.enableOptimization = enableOptimization or false
    self.caveMapOptimization = nil

    local GameDataManager = require("app.game.GameDataManager")
    print("caveMapOptimization ", enableOptimization, self.enableOptimization)

    self.tapBoxDecorationArr = {}
    
    self.globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
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
    -- self:scheduleUpdateWithPriorityLua(function (dt) 
    --     self:update(dt)
    -- end, 0.0)
end

-- function CaveMap:update(dt)
-- end

function CaveMap:init()
    self:setContentSize(MapHelper.coordinateSizeToContentSize(self.sizeX, self.sizeY, self.tileWidth, self.tileHeight))
    print("CaveMap contentSize: ", self:getContentSize().width, self:getContentSize().height)

    self.isInHitRat = SceneManager:getInstance():isInHitRat()

    -- create enough layers for map
    self.layers = {}
    local layerCount = MapDefine.LayerCount 
    local textureCacheLayer = nil
    for i = 1, layerCount do
        local layer = nil
        if (i == MapDefine.LayerIndexGround) then            
            -- 缓存整块地面
            textureCacheLayer = cc.Node:create()
            textureCacheLayer:setToCacheTexture(true)
            textureCacheLayer:setDisableTrimCacheTexture(true)
            -- if (textureCacheLayer.setTextureCacheRim) then 
            --     textureCacheLayer:setTextureCacheRim(162, 81)
            -- end

            -- 实际的地面层
            layer = cc.Layer:create()
            textureCacheLayer:addChild(layer)
        else
            layer = cc.Layer:create();
            -- 其他地图层不缓存
            textureCacheLayer = layer
        end

        self.layers[i] = layer;
        self:addChild(textureCacheLayer);
    end

    -- preload texture atlas
    if self.mapData.decorationPlist ~= nil then
        if type(self.mapData.decorationPlist) == "table" then
            for _, plist in ipairs(self.mapData.decorationPlist) do
                Avalon.ResHelper:loadPlistSync(plist)
            end
        elseif type(self.mapData.decorationPlist) == "string" then 
            Avalon.ResHelper:loadPlistSync(self.mapData.decorationPlist)
        end
    end
    local decorationPlist = self.mapName .. "_decoration.plist"
    if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():fullPathForFilename(decorationPlist)) then
        Avalon.ResHelper:loadPlistSync(decorationPlist)
    end
    if self.mapData.hasChamber then 
        local chamberPlist = self.mapName .. "_chamber.plist"
        if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():fullPathForFilename(chamberPlist)) then
            Avalon.ResHelper:loadPlistSync(chamberPlist)
        end
    end
    if self.mapData.sceneType == PublicDefine.SCENE_TYPE.BOSS then 
        local bossfloorPlist = self.mapName .. "_bossfloor.plist"
        if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():fullPathForFilename(bossfloorPlist)) then
            Avalon.ResHelper:loadPlistSync(bossfloorPlist)
        end
    end

    self.tileTerrainMap = {}    
    self.decorationsMap = {}
    self.effectColorsMap = {}
    self.coordLabelsMap = {}

    self.animatedDecorations = {}
    self:setUpDeocraitonAnimaitonFunc()

    -- 是否启用优化
    if (self.enableOptimization) then self:initWithOptimization()
    else self:initWithNoOptimization()
    end

    if MapHelper.showDebugCoordinates or MapHelper.showDebugZOrders then
        for y = self.sizeY, 1, -1 do
            for x = self.sizeX, 1, -1 do
                local cx, cy = x - 1, y - 1

                local posX, posY = self:coordinateToPosition(cx, cy)
                local zOrder = self:getZOrderByCoordinate(cx, cy)

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

function CaveMap:initWithOptimization()
    for y = self.sizeY, 1, -1 do
        for x = self.sizeX, 1, -1 do
            local cx, cy = x - 1, y - 1
            local posX, posY = self:coordinateToPosition(cx, cy)
            
            local tileData = self.mapData:getTileDataAtCoord(cx, cy)
            if tileData ~= nil then
                -- Terrain 
                local terrainData = tileData.terrainData
                if terrainData:getTerrainType() == MapDefine.TerrainType.Ground and self.randomOffect then
                    local yOffset = lume.random(-MapDefine.TileZAxisOffsetMax, 0)
                    posY = posY + yOffset
                    local z = select(-1, self:positionToCoordinate(0, 0, yOffset))
                    if z == nil then
                        assert(false, string.format("tile z can not be nil x=%d, y=%d", cx, cy))
                    else
                        tileData:setZ(z)
                    end
                end
            end
        end
    end

    self.caveMapOptimization = CaveMapOptimization:create()
    self.caveMapOptimization:init(self)
end

function CaveMap:initWithNoOptimization()     
    -- create tiles from top down to bottom, 
    -- in order to make the bottom tiles is rendered before the top ones
    for y = self.sizeY, 1, -1 do
        self.tileTerrainMap[y] = {}
        self.decorationsMap[y] = {}
        self.effectColorsMap[y] = {}
        self.coordLabelsMap[y] = {}
        for x = self.sizeX, 1, -1 do
            local cx, cy = x - 1, y - 1
            local posX, posY = self:coordinateToPosition(cx, cy)
            local zOrder = self:getZOrderByCoordinate(cx, cy)
            local tileData = self.mapData:getTileDataAtCoord(cx, cy)
            if tileData ~= nil then
                -- Terrain 
                local terrainData = tileData.terrainData
                if terrainData:getTerrainType() == MapDefine.TerrainType.Ground and self.randomOffect then
                    local yOffset = lume.random(-MapDefine.TileZAxisOffsetMax, 0)
                    posY = posY + yOffset
                    local z = select(-1, self:positionToCoordinate(0, 0, yOffset))
                    if z == nil then
                        assert(false, string.format("tile z can not be nil  x=%d, y=%d", cx, cy))
                    else
                        tileData:setZ(z)
                    end
                end
                local tileTerrain = MapTileTerrain:create(terrainData, self.tileWidth, self.tileHeight, MapDefine.FarestTileColorLevel)
                if tileTerrain ~= nil then
                    -- if self.type ~= PublicDefine.SCENE_TYPE.TOWN then
                        -- tileTerrain:setVisionLevel(MapDefine.FarestTileColorLevel)
                    -- end                                                                                        
                    tileTerrain:addToMap(self, {x = posX, y = posY, coordX = cx, coordY = cy}, zOrder) 
                    -- tileTerrain:setVisible(false)
                    -- print(string.format("tileTerrain:addToMap at coordinate (%d,%d) z %d", cx, cy, zOrder))
                end
                self:setTileTerrain(cx, cy, tileTerrain)
                -- Decoration
                local decorationDatas = tileData.decorationDatas
                for _, decorationData in ipairs(decorationDatas) do
                    local decoration = MapDecoration:create(self, decorationData, self.tileWidth, self.tileHeight)
                    if decoration ~= nil then
                        local decorations = self:getDecorations(cx, cy)
                        if decorations == nil then
                            decorations = {}
                            self:setDecorations(cx, cy, decorations)
                        end 
                        decoration:setCoordinate(cx, cy)
                        -- decoration:setVisible(false)
                        lume.push(decorations, decoration)
                        if not decorationData:isSkinPNG() then 
                            lume.push(self.animatedDecorations, decoration)
                        end

                        if MapHelper.showDebugBoundingBox then
                            self:drawDecorationDebugBox(decoration)
                        end
                    end
                end

                -- Effect Color 
                local effectColorDatas = self.mapData:getEffectColorDatasAtCoord(cx, cy)
                if effectColorDatas ~= nil and #effectColorDatas > 0 and tileData:getTerrainData() ~= nil then
                    for _, effectColorData in ipairs(effectColorDatas) do
                        local effectColor = MapTileEffectColor:create(tileData:getTerrainData(), effectColorData, self.tileWidth, self.tileHeight)
                        if effectColor ~= nil then
                            local effectColors = self:getEffectColors(cx, cy)
                            if effectColors == nil then
                                effectColors = {}
                                self:setEffectColors(cx, cy, effectColors)
                            end
                            effectColor:setCoordinate(cx, cy)
                            effectColor:addToMap(self, {x = posX, y = posY}, zOrder)
                            -- effectColor:setVisible(false)
                            lume.push(effectColors, effectColor)
                        end
                    end
                end
                
                -- if MapHelper.showDebugCoordinates or MapHelper.showDebugZOrders then
                --     local str = ""
                --     if MapHelper.showDebugCoordinates then
                --         str = str .. cx .. "," .. cy
                --     end
                --     if MapHelper.showDebugZOrders then
                --         str = str .. "z:" .. zOrder
                --     end
    
                --     local label = cc.Label:createWithSystemFont(str, UI.SYS_FONT, 12)
                --     self:addChild(label)
                --     self.coordLabelsMap[y][x] = label
                --     label:setColor(cc.c3b(255, 255, 255))
                --     local labelPosY = posY
                --     label:setPosition(posX, labelPosY)
                --     label:setLocalZOrder(zOrder + 1000)
                -- end
            end

        end
    end

    -- everything generation done, time to add Decoration to map
    for y = 1, self.sizeY do
        for x = 1, self.sizeX do
            local coordX, coordY = x - 1, y - 1
            local tileData = self.mapData:getTileDataAtCoord(coordX, coordY)
            local decorations = self:getDecorations(coordX, coordY)
            if tileData ~= nil and decorations ~= nil and #decorations > 0 then
                local posX, posY = self:coordinateToPosition(coordX, coordY)
                for _, decoration in ipairs(decorations) do
                    local zOrder = self:getDecorationProperZOrder(decoration.data, coordX, coordY)
                    local z = tileData:getZ()
                    local yOffset = select(-1, self:coordinateToPosition(0, 0, z))
                    decoration:addToMap(self, {x = posX, y = posY + yOffset}, zOrder)

                    -- printfmt("add decoration %s ID %d at %d,%d z %d", decoration.data.skin, decoration.data.ID, coordX, coordY, zOrder);
                end
            end
        end
    end
end

function CaveMap:setUpDeocraitonAnimaitonFunc()
    for k, v in pairs(MapDefine.DecorationAnimName) do
        local funcName = string.format("runDecorationAnimation%s", k)
        CaveMap[funcName] = function (coord) self:runDecorationAnimation(v, coord) end 
    end
end

function CaveMap:runDecorationAnimation(animName, coord)
    print("runDecorationAnimation ", animName)
    if #self.animatedDecorations > 0 then 
        for _, decoration in ipairs(self.animatedDecorations) do 
            if coord == nil or type(coord) ~= "table" then 
                decoration:runAnim(animName)
            else
                local x, y = decoration:getCoordinate()
                if x == coord.x and y == coord.y then
                    decoration:runAnim(animName)
                end
            end
        end
    end
end

function CaveMap:removeAllElements()
    if self.tileTerrainMap == nil and self.decorationsMap == nil and self.effectColorsMap == nil then
        return
    end
    for y = 1, self.sizeY do
        for x = 1, self.sizeX do
            local cx, cy = x - 1, y - 1
            local tileTerrain = self:getTileTerrain(cx, cy)
            if tileTerrain ~= nil then
                tileTerrain:destroy()
                -- print("remove tile terrain at ", cx, cy)
            end
            local decorations = self:getDecorations(cx, cy)
            if decorations ~= nil and #decorations > 0 then
                for _, decoration in ipairs(decorations) do
                    decoration:destroy()
                end
                -- print("remove decorations at ", cx, cy)
            end
            local effectColors = self:getEffectColors(cx, cy)
            if effectColors ~= nil and #effectColors > 0 then
                for _, effectColor in ipairs(effectColors) do
                    effectColor:destroy()
                end
                -- print("remove effectColors at ", cx, cy)
            end
            if MapHelper.showDebugCoordinates or MapHelper.showDebugZOrders then
                if self.coordLabelsMap[y] ~= nil then
                    local label = self.coordLabelsMap[y][x]
                    if label ~= nil then
                        label:removeFromParent()
                    end
                end
            end
        end
    end
    lume.clear(self.tileTerrainMap)
    lume.clear(self.decorationsMap)
    lume.clear(self.effectColorsMap)
    lume.clear(self.coordLabelsMap)
end

function CaveMap:getLayer(index)
    if index < 1 and index > MapDefine.LayerCount then
        return nil
    end
    return self.layers[index]
end

function CaveMap:addNodeGround(node)
    local layer = self:getLayer(MapDefine.LayerIndexGround)
    if layer ~= nil then
        layer:addChild(node)
    end
end

function CaveMap:addNodeOnGround(node)
    local layer = self:getLayer(MapDefine.LayerIndexNodeOnGround)
    if layer ~= nil then
        layer:addChild(node)
    end
end

function CaveMap:addNodeOnMap(node,isTile)
    if (self.isInHitRat and isTile) then --异鼠必须死和宠物pvp，特殊处理，不显示墙
        return
    end
    local layer = self:getLayer(MapDefine.LayerIndexNodeOnMap)
    if layer ~= nil then
        layer:addChild(node)
    end
end

function CaveMap:addNodeBeyondMap(node)
    local layer = self:getLayer(MapDefine.LayerIndexNodeBeyondMap)
    if layer ~= nil then
        layer:addChild(node)
    end
end

function CaveMap:triggerClickMap(coordX, coordY)
    if(self.tapBoxDecorationArr) then
        for k,decoration in ipairs(self.tapBoxDecorationArr) do 
            local spine = decoration:getSpine()
            local rect = spine:getBoudingBox("tapbox_1", false)
            if(rect and spine and cc.rectContainsPoint(rect, {x=coordX, y=coordY})) then 
                decoration:clickSpine()
            end 
        end
    end 
end

function CaveMap:updateMap()
    if #self.mapData.dirtyTileDatas > 0 then
        -- printfmt ("map update dirty tile datas")

        local centerCoordX = math.floor(self.centerCoordX)
        local centerCoordY = math.floor(self.centerCoordY)

        -- if not (centerCoordX == 0 and centerCoordY == 0) then
        --     self:doPathLengthMapAtCoord(centerCoordX, centerCoordY)
        -- end

        if (not self.enableOptimization) then
            local curCenterPathLengthMapUpdated = false
            for _, tileData in ipairs(self.mapData.dirtyTileDatas) do
                self:updateTile(tileData)
                if math.abs(tileData.x - centerCoordX) <= visionRadius and math.abs(tileData.y - centerCoordY) <= visionRadius then
                    if not curCenterPathLengthMapUpdated then
                        local coordIndex = self:getCoordIndex(centerCoordX, centerCoordY)
                        local pathLengthMap = self:calculatePathLengthMapAtCoord(centerCoordX, centerCoordY)
                        self.pathLengthMapsCache[coordIndex] = pathLengthMap

                        curCenterPathLengthMapUpdated = true
                    end
                end
            end
        else
            -- print("CaveMap updateMap: optimization ", centerCoordX, centerCoordY)

            local curCenterPathLengthMapUpdated = false
            for _, tileData in ipairs(self.mapData.dirtyTileDatas) do
                local coordX, coordY = tileData.x, tileData.y
                -- 更新地块
                self.caveMapOptimization:updateMapTile(tileData, coordX, coordY)
                -- 更新光效数据
                if math.abs(tileData.x - centerCoordX) <= visionRadius and math.abs(tileData.y - centerCoordY) <= visionRadius then
                    if not curCenterPathLengthMapUpdated then
                        local coordIndex = self:getCoordIndex(centerCoordX, centerCoordY)
                        local pathLengthMap = self:calculatePathLengthMapAtCoord(centerCoordX, centerCoordY)
                        self.pathLengthMapsCache[coordIndex] = pathLengthMap

                        curCenterPathLengthMapUpdated = true
                    end
                end
            end

            self:updateMapTileAround(centerCoordX, centerCoordY)
            -- self:updateTileVisionAppearanceForCurrentCenterCoordinateAtCoord(centerCoordX, centerCoordY)
            -- for _, tileData in ipairs(self.mapData.dirtyTileDatas) do
            --     local coordX, coordY = tileData.x, tileData.y
            --     self:updateTileVisionAppearanceForCurrentCenterCoordinateAtCoord(coordX, coordY)
            -- end
            self:updateTilesVisionAppearanceForCenterCoord(centerCoordX, centerCoordY, 1.0)
        end

        lume.clear(self.mapData.dirtyTileDatas)
    end
end

function CaveMap:addTrapDecoration(decoration)
    if(decoration) then
        table.insert(self.tapBoxDecorationArr, decoration)
    end
end

function CaveMap:removeTrapDecoration(decoration)
    if(decoration) then
        for k = #self.tapBoxDecorationArr, 1, -1 do
            local oldDecoration = self.tapBoxDecorationArr[k]
            if(oldDecoration == decoration) then
                table.remove(self.tapBoxDecorationArr, k)
            end
        end
    end
end

function CaveMap:updateTileAtCoord(coordX, coordY, animated)
    local tileData = self.mapData:getTileDataAtCoord(coordX, coordY)
    if tileData == nil then
        print ("no tile data", coordX, coordY)
        return false
    end
    self:updateTile(tileData, animated)
end

function CaveMap:updateTile(tileData, animated)
    local coordX, coordY = tileData.x, tileData.y
    local terrainData = tileData:getTerrainData()
    if terrainData == nil then
        print ("no terrain data", coordX, coordY)
        return false
    end

    local tileTerrain = self:getTileTerrain(coordX, coordY)
    if tileTerrain == nil then
        tileTerrain = MapTileTerrain:create(terrainData, self.tileWidth, self.tileHeight, MapDefine.FarestTileColorLevel)
        if tileTerrain == nil then
            print ("no tile terrain", coordX, coordY)
            return false
        end
        local zOrder = self:getZOrderByCoordinate(coordX, coordY)
        local posX, posY = self:coordinateToPosition(coordX, coordY)
        tileTerrain:addToMap(self, {x = posX, y = posY, coordX = coordX, coordY = coordY}, zOrder) 
        self:setTileTerrain(coordX, coordY, tileTerrain)
        -- print ("create new tile terrain at ", coordX, coordY)
    end
    -- print ("updateTileAtCoord ", coordX, coordY, terrainData:getTerrainType(), tostring(terrainData:getTerrainNames()), tostring(tileData))
    tileTerrain:setTerrainData(terrainData, self)
    tileTerrain:setVisible(true)
    
    -- remove decorations on this tile
    local decorations = self:getDecorations(coordX, coordY)
    if decorations ~= nil and #decorations > 0 then
        for _, decoration in ipairs(decorations) do
            decoration:removeFromMap(animated)
        end
        self:setDecorations(coordX, coordY, nil)
    end
    -- if (self.enableOptimization) then
    --     self.caveMapOptimization:removeMapTileDecorations(coordX, coordY)
    -- end

    -- remove effect colors on this tile
    local effectColors = self:getEffectColors(coordX, coordY)
    if effectColors ~= nil and #effectColors > 0 then
        for _, effectColor in ipairs(effectColors) do  
            effectColor:removeFromMap()
        end
        lume.clear(effectColors)
        self:setEffectColors(coordX, coordY, nil)
    end
    
    -- recreate the decorations
    local posX, posY = self:coordinateToPosition(coordX, coordY)
    local z = tileData:getZ()
    local yOffset = select(-1, self:coordinateToPosition(0, 0, z))

    local decorationDatas = tileData:getDecorationDatas()
    for _, decorationData in ipairs(decorationDatas) do
        local decoration = MapDecoration:create(self, decorationData, self.tileWidth, self.tileHeight)
        if decoration ~= nil then
            local decorations = self:getDecorations(coordX, coordY) 
            if decorations == nil then
                decorations = {}
                self:setDecorations(coordX, coordY, decorations)
            end 

            decoration:setCoordinate(coordX, coordY)
            lume.push(decorations, decoration)

            local zOrder = self:getDecorationProperZOrder(decorationData, coordX, coordY)
            decoration:addToMap(self, {x = posX, y = posY + yOffset}, zOrder)
            -- print(string.format("decoration:addToMap at coordinate (%d,%d) z %d skin %s", coordX, coordY, zOrder, decoration.data.skin))
        end
    end

    -- recreate the tile effect colors
    local effectColorDatas = self.mapData:getEffectColorDatasAtCoord(coordX, coordY)
    if effectColorDatas ~= nil and #effectColorDatas > 0 then
        for _, effectColorData in ipairs(effectColorDatas) do
            local effectColor = MapTileEffectColor:create(terrainData, effectColorData, self.tileWidth, self.tileHeight)
            if effectColor ~= nil then
                local effectColors = self:getEffectColors(coordX, coordY)
                if effectColors == nil then
                    effectColors = {}
                    self:setEffectColors(coordX, coordY, effectColors)
                end
                effectColor:setCoordinate(coordX, coordY)
                effectColor:addToMap(self, {x = posX, y = posY + yOffset}, zOrder)
                lume.push(effectColors, effectColor)
            end
        end
    end
    -- if self.type ~= PublicDefine.SCENE_TYPE.TOWN then
        -- finally, update tile terrain to porper vision level
        self:updateTileVisionAppearanceForCurrentCenterCoordinateAtCoord(coordX, coordY)
    -- end

    return true
end

-- function CaveMap:transformTileToReachableAtCoord(coordX, coordY)
--     local tileData = self.mapData:getTileDataAtCoord(coordX, coordY)
--     -- print(tostring(tileData))
--     -- print("transform wall to ground at ", coordX, coordY)
--     self:updateTileAtCoord(coordX, coordY)
    
--     local AroundOffsets = MapDefine.AroundOffsets
--     for _, offset in ipairs(AroundOffsets) do
--         local aroundCoordX = coordX + offset.x
--         local aroundCoordY = coordY + offset.y
--         local aroundTileData = self.mapData:getTileDataAtCoord(aroundCoordX, aroundCoordY)
--         if aroundTileData ~= nil then
--             -- print(tostring(aroundTileData))
--             self:updateTileAtCoord(aroundCoordX, aroundCoordY) 
--         -- else 
--         --     print("no tile data at", aroundCoordX, aroundCoordY)
--         end
--     end
-- end

function CaveMap:getMaxPathLen()
    return self.sizeX * self.sizeY
end

function CaveMap:getCoordIndex(cx, cy)
    return cy * self.sizeX + cx + 1
end

function CaveMap:getCoord(coordIndex)
    return (coordIndex - 1 - cx) / cy
end

function CaveMap:getIsSplit()
    return self.mapData.isSplit
end

-- function CaveMap:calculatePathLengthMapAtCoord(cx, cy)
--     local visionGroundMap = {}
--     for y = cy - visionRadius, cy + visionRadius do
--         local iy = y - cy + visionRadius + 1
--         visionGroundMap[iy] = {}
--         for x = cx - visionRadius, cx + visionRadius do
--             local ix = x - cx + visionRadius + 1
--             if self:isInBounds(x + 1, y + 1) then
--                 local tileData = self.mapData:getTileDataAtCoord(x, y)
--                 if tileData ~= nil then
--                     visionGroundMap[iy][ix] = tileData:getTerrainData():getTerrainType()
--                 else 
--                     visionGroundMap[iy][ix] = -1
--                 end
--             else 
--                 visionGroundMap[iy][ix] = -1
--             end
--         end
--     end
--     -- print("visionGroundMap:")
--     -- grids.print(visionGroundMap, 11, 11)

--     local visionWallMap = {}
--     for y = cy - visionRadius, cy + visionRadius do
--         local iy = y - cy + visionRadius + 1
--         visionWallMap[iy] = {}
--         for x = cx - visionRadius, cx + visionRadius do
--             local ix = x - cx + visionRadius + 1
--             if self:isInBounds(x + 1, y + 1) then
--                 visionWallMap[iy][ix] = 0
--             else 
--                 visionWallMap[iy][ix] = -1
--             end
--         end
--     end
--     -- print("visionWallMap:")
--     -- grids.print(visionWallMap, 11, 11)

--     local groundGrid = Grid(visionGroundMap)
--     local groundWalkable = 0
--     local groundFinder = Pathfinder(groundGrid, 'ASTAR', groundWalkable) 
--     groundFinder:setMode("ORTHOGONAL")
    
--     local wallGrid = Grid(visionWallMap)
--     local wallWalkable = 0
--     local wallFinder = Pathfinder(wallGrid, 'ASTAR', wallWalkable) 
--     wallFinder:setMode("ORTHOGONAL")

--     local maxLen = self:getMaxPathLen()
--     local pathLenMap = grids.make(visionRadius * 2 + 1, visionRadius * 2 + 1, maxLen)
--     for iy = 1, visionRadius * 2 + 1 do
--         for ix = 1, visionRadius * 2 + 1 do
--             local x = ix + cx - visionRadius - 1
--             local y = iy + cy - visionRadius - 1
--             if self:isInBounds(x + 1, y + 1) then
--                 local tileData = self.mapData:getTileDataAtCoord(x, y)
--                 if tileData ~= nil then
--                     local path = nil
--                     if tileData:getTerrainData():getTerrainType() == MapDefine.TerrainType.Wall then
--                         path = wallFinder:getPath(visionRadius + 1, visionRadius + 1, ix, iy)
--                     elseif tileData:getTerrainData():getTerrainType() == MapDefine.TerrainType.Ground then
--                         path = groundFinder:getPath(visionRadius + 1, visionRadius + 1, ix, iy)
--                     end

--                     if path ~= nil then
--                         local pathLen = math.floor(path:getLength())
--                         if pathLen == nil then
--                             print (("find path length nil from %d,%d to %d,%d"):format(pathLen, cx, cy, x, y))
--                         end
--                         pathLenMap[iy][ix] = pathLen 
--                         -- print (("find path length %d from %d,%d to %d,%d"):format(pathLen, cx, cy, x, y))
--                     end
--                 end
--             end 
--         end
--     end
--     return pathLenMap
-- end

function CaveMap:calculatePathLengthMapAtCoord(cx, cy)
-- function CaveMap:doPathLengthMapAtCoord(cx, cy)
    -- printf(string.format("path len map at %d,%d", cx, cy))
    local maxLen = self:getMaxPathLen()
    local map = grids.make(visionRadius * 2 + 1, visionRadius * 2 + 1, MapDefine.FarestTileColorLevel)
    map[visionRadius + 1][visionRadius + 1] = 0

    local tile = self.mapData:getTileDataAtCoord(cx, cy)
    local checkList = {}
    lume.push(checkList, tile)

    while #checkList > 0 do
        local rmlist = lume.clone(checkList)
        for _, tile in ipairs(checkList) do 
            local ix = tile.x - cx + visionRadius + 1
            local iy = tile.y - cy + visionRadius + 1
            local cost = map[iy][ix]
            for _, offset in ipairs(MapDefine.AdjacentOffsets) do 
                local x, y = tile.x + offset.x, tile.y + offset.y
                
                local ix = x - cx + visionRadius + 1
                local iy = y - cy + visionRadius + 1
                if ix > 0 and iy > 0 and ix < 2 * visionRadius + 1 and iy < 2 * visionRadius + 1 then
                    -- printf("check at %d,%d i%d,%d c%d m%d", x, y, ix, iy, cost + 1, map[iy][ix])
                    if cost + 1 <= visionRadius + 1 then
                        local adjacentTile = self.mapData:getTileDataAtCoord(x, y)
                        if adjacentTile ~= nil and adjacentTile:isReachable() then
                            if (map[iy][ix] == -1 or cost + 1 < map[iy][ix]) then
                                map[iy][ix] = cost + 1
                                lume.push(checkList, adjacentTile)
                                -- printf("push tile to check list at %d,%d i%d,%d", x, y, ix, iy)
                            end
                        end
                        -- printf("update cost at %d,%d i%d,%d c%d", x, y, ix, iy, cost + 1)
                    end
                end
            end
        end
        for _, tile in ipairs(rmlist) do
            lume.remove(checkList, tile)
        end
    end

    for ix = 1, 2 * visionRadius + 1 do 
        for iy = 1, 2 * visionRadius + 1 do 
            local x = ix + cx - visionRadius - 1
            local y = iy + cy - visionRadius - 1
            local tileData = self.mapData:getTileDataAtCoord(x, y)
            if tileData ~= nil and not tileData:isReachable() then
                local cost = math.abs(x - cx) + math.abs(y - cy)
                map[iy][ix] = cost;
                -- printf("update unreachable tile cost at %d,%d i%d,%d c%d", x, y, ix, iy, cost)
            end
        end
    end
    
    -- grids.print(map, visionRadius * 2 + 1, visionRadius * 2 + 1)
    return map
end

-- function CaveMap:cacheVisionColorLevelMaps()
--     for cy = 0, self.sizeY - 1 do
--         for cx = 0, self.sizeX - 1 do
--             local pathLengthMap = self:calculatePathLengthMapAtCoord(cx, cy)
--             self.pathLengthMapsCache[cy + 1][cx + 1] = pathLengthMap
--             -- print("cache vision color level map for coord %d,%d", cy, cx)
--             -- for k, v in pairs(pathLengthMap) do
--             --     print (k, v)
--             -- end
--         end
--     end
-- end

function CaveMap:isCoordInWallShrinkCheckBounds(cx, cy, x, y)
    local pathLen = self:getPathLenToCoord(cx, cy, x, y)
    return pathLen <= wallShrinkCheckRadius
end

function CaveMap:isCoordInVision(cx, cy, x, y)
    local pathLen = self:getPathLenToCoord(cx, cy, x, y)
    return pathLen <= visionRadius
end

function CaveMap:getPathLenToCoord(cx, cy, x, y)
    local visionColorLevelMap = self:getPathLengthMapAtCoord(cx, cy)
    if(visionColorLevelMap == nil) then
        print("CaveMap:getPathLenToCoord", cx, cy)
        assert(visionColorLevelMap)
        return self:getMaxPathLen()
    end 
    -- 

    local lx = x - cx + visionRadius + 1
    local ly = y - cy + visionRadius + 1
    if not grids.isInBounds(lx, ly, visionRadius * 2 + 1, visionRadius * 2 + 1) then
        -- print ("local coord not in bounds", lx, ly)
        return self:getMaxPathLen()
    end

    if(visionColorLevelMap[ly] == nil or visionColorLevelMap[ly][lx] == nil) then
        return self:getMaxPathLen()
    end

    local pathLen = visionColorLevelMap[ly][lx]
    if pathLen == nil then
        -- print ("local coord too far away", lx, ly)
        return self:getMaxPathLen()
    end
    return pathLen
end

function CaveMap:updateTileVisionAppearanceForCurrentCenterCoordinateAtCoord(coordX, coordY)
    local centerCoordX = math.floor(self.centerCoordX)
    local centerCoordY = math.floor(self.centerCoordY)
    if math.abs(centerCoordX - coordX) > visionRadius or math.abs(centerCoordY - coordY) > visionRadius then
        -- print(("coordinate %d,%d is out of center %d,%d vision range, no need to update"):format(coordX, coordY, centerCoordX, centerCoordY))
        return
    end
    local tileData = self.mapData:getTileDataAtCoord(coordX, coordY)
    if tileData ~= nil then
        local pathLengthMap = self:getPathLengthMapAtCoord(centerCoordX, centerCoordY)
        if pathLengthMap ~= nil then
            local iy = coordY - centerCoordY + visionRadius + 1
            local ix = coordX - centerCoordX + visionRadius + 1
            if iy < #pathLengthMap and ix < #pathLengthMap[iy] then
                local colorLevel = self:getVisionLevel(pathLengthMap, ix, iy)
                self:updateTileVisionAppearance(tileData, colorLevel, centerCoordX, centerCoordY, 1.0)
            end
        end
    end
end

function CaveMap:updateTileVisionAppearance_new(tileData, progress)
    local x,y = tileData.x, tileData.y
    local tileTerrain = self:getTileTerrain(x, y)

    if tileTerrain ~= nil then
        if tileData:getTerrainType() == MapDefine.TerrainType.Wall then
            tileTerrain:updateAppearance(progress)

            -- need to hide deocrations on wall if wall is shrinked 
            local decorations = self:getDecorations(x, y)
            if decorations ~= nil then 
                for _, decoration in ipairs(decorations) do
                    decoration:updateAppearance(progress)
                end
            end
        else 
            tileTerrain:updateAppearance(progress)
        end
    end

    local effectColors = self:getEffectColors(x, y)
    if effectColors ~= nil and #effectColors > 0 then
        for _, effectColor in ipairs(effectColors) do
            effectColor:updateAppearance(progress)
        end
    end
end

function CaveMap:updateTileVisionAppearance(tileData, colorLevel, centerCoordX, centerCoordY, progress)
    local x,y = tileData.x, tileData.y
    local tileTerrain = self:getTileTerrain(x, y)
    local isHideWall = false
    
    if self.globalUserData then
        isHideWall = self.globalUserData:isHideWall() 
    end
    if tileTerrain ~= nil then
        local co = coroutine.create(function ()
            if tileData:getTerrainType() == MapDefine.TerrainType.Wall then
                local shouldShrink = self:shouldWallShrinkAtCoord(centerCoordX, centerCoordY, x, y)
                -- CO-5314如果选择了隐藏墙体,强制隐藏
                if isHideWall then
                    tileTerrain:transformToVisionLevel(colorLevel, true, progress)
                else    
                    tileTerrain:transformToVisionLevel(colorLevel, shouldShrink, progress)
                end
                
                -- printf("transformToVisionLevel at %d,%d %d %s %d", x, y, colorLevel, shouldShrink, progress)
                -- need to hide deocrations on wall if wall is shrinked 
                local decorations = self:getDecorations(x, y)
                if decorations ~= nil then 
                    for _, decoration in ipairs(decorations) do
                        -- CO-5314如果选择了隐藏墙体,强制隐藏墙上的装饰物,以免穿帮.
                        if isHideWall then
                            decoration:fadeAction(false, 1)
                        else
                            decoration:fadeAction(not shouldShrink, progress)
                        end
                    end
                end
            else 
                tileTerrain:transformToVisionLevel(colorLevel, false, progress)
            end
            -- print("协程1 执行完毕")
        end)
        coroutine.resume(co)
    else
        -- assert(false, string.format("---------- %d %d ", x, y))
    end

    local effectColors = self:getEffectColors(x, y)
    if effectColors ~= nil and #effectColors > 0 then
        local co = coroutine.create(function ()
            for _, effectColor in ipairs(effectColors) do
                if tileData:getTerrainType() == MapDefine.TerrainType.Wall then
                    local shouldShrink = self:shouldWallShrinkAtCoord(centerCoordX, centerCoordY, x, y)
                    -- CO-5314如果选择了隐藏墙体,强制隐藏
                    if isHideWall then
                        effectColor:transformToVisionLevel(colorLevel, true, progress)
                    else
                        effectColor:transformToVisionLevel(colorLevel, shouldShrink, progress)
                    end
                else
                    effectColor:transformToVisionLevel(colorLevel, shouldShrink, progress)
                end
            end
        end)
        coroutine.resume(co)
    end
end


function CaveMap:isHiddenByWallAtCoord(centerCoordX, centerCoordY, x, y)
    local bottomWallOffsets = {
        {x = -1, y = -1},
    }
    local checkInt = function (n) return math.floor(n) == n end
    if checkInt(centerCoordX) and checkInt(centerCoordY) and checkInt(x) and checkInt(y) then 
        -- print ("isHiddenByWallAtCoord:check int pass")
        if self:isInBounds(x + 1, y + 1) then
            local hiddenByWall = true
            for i = 1, #bottomWallOffsets do
                local nx = x + bottomWallOffsets[i].x 
                local ny = y + bottomWallOffsets[i].y
                if self:shouldWallShrinkAtCoord(centerCoordX, centerCoordY, nx, ny) then
                    hiddenByWall = false
                    break
                end
            end 
            return hiddenByWall
        end
    end
    -- print("isHiddenByWallAtCoord:", centerCoordX, centerCoordY, x, y)
    return false
end

local bottomGroundOffsets = {
    {x = 1, y = 0},
    {x = 1, y = 1},
    {x = 0, y = 1},
    {x = 2, y = 0},
    {x = 2, y = 1},
    {x = 2, y = 2},
    {x = 1, y = 2},
    {x = 0, y = 2},
}
function CaveMap:shouldWallShrinkAtCoord(centerCoordX, centerCoordY, x, y)    
    local haveGround = false
    for i = 1, #bottomGroundOffsets do
        local nx = x + bottomGroundOffsets[i].x 
        local ny = y + bottomGroundOffsets[i].y

        if self:isInBounds(nx + 1, ny + 1) then 
            local tileData = self.mapData:getTileDataAtCoord(nx, ny)
            if tileData ~= nil then
                
                if tileData.terrainData:getTerrainType() == GroundType then
                    -- print ("CaveMap:shouldWallShrinkAtCoord is ground ",  tileData.terrainData:getTerrainType(), tileData.x, tileData.y, nx, ny)
                    if self:isCoordInWallShrinkCheckBounds(centerCoordX, centerCoordY, nx, ny) then
                        -- print ("CaveMap:shouldWallShrinkAtCoord in bounds: ", nx, ny)
                        haveGround = true
                        break
                    end
                -- else 
                --     print ("CaveMap:shouldWallShrinkAtCoord is not ground ",  tileData.terrainData:getTerrainType(), tileData.x, tileData.y, nx, ny)
                end
            -- else 
                -- print ("CaveMap:shouldWallShrinkAtCoord tiledata nil", nx, ny)
            end 
        end
    end
    -- print ("CaveMap:shouldWallShrinkAtCoord false ", x, y)
    return haveGround
end

function CaveMap:getPathLengthMapAtCoord(cx, cy)
    local coordIndex = self:getCoordIndex(cx, cy)
    local pathLengthMap = self.pathLengthMapsCache[coordIndex]
    if pathLengthMap == nil then
        -- print (("------ no color level map cache for %d,%d"):format(cx, cy))
        pathLengthMap = self:calculatePathLengthMapAtCoord(cx, cy)
        self.pathLengthMapsCache[coordIndex] = pathLengthMap
    else 
    --     print (("------ get color level map cache for %d,%d"):format(cx, cy))
    end
    return pathLengthMap
end

function CaveMap:updateTilesVisionAppearanceForCenterCoord_new(centerCoordX, centerCoordY, progress)
    local sizeX = self.sizeX sizeY = self.sizeY
    if (progress <= 0.0 or progress >= 1.0) then
        local pathLengthMap = self:getPathLengthMapAtCoord(centerCoordX, centerCoordY)
        
        for y = centerCoordY - visionRadius, centerCoordY + visionRadius do
            local iy = y - centerCoordY + visionRadius + 1
            for x = centerCoordX - visionRadius, centerCoordX + visionRadius do
                local ix = x - centerCoordX + visionRadius + 1
                
                local _x = x + 1 
                local _y = y + 1
                if (_x >= 1 and _x <= sizeX and _y >= 1 and _y <= sizeY) then
                    local tileData = self.mapData.tileDataMap[_y][_x]
                    if tileData ~= nil then
                        local colorLevel = pathLengthMap[iy][ix] + 1
                        self:updateTileVisionAppearance(tileData, colorLevel, centerCoordX, centerCoordY, progress)
                    end
                end
            end
        end
    else 
        for y = centerCoordY - visionRadius, centerCoordY + visionRadius do
            local iy = y - centerCoordY + visionRadius + 1
            for x = centerCoordX - visionRadius, centerCoordX + visionRadius do
                local ix = x - centerCoordX + visionRadius + 1
                
                local _x = x + 1 
                local _y = y + 1
                if (_x >= 1 and _x <= sizeX and _y >= 1 and _y <= sizeY) then
                    local tileData = self.mapData.tileDataMap[_y][_x]
                    if tileData ~= nil then
                        self:updateTileVisionAppearance_new(tileData, progress)
                    end
                end
            end
        end
    end
end

function CaveMap:updateTilesVisionAppearanceForCenterCoord(centerCoordX, centerCoordY, progress)
    local pathLengthMap = self:getPathLengthMapAtCoord(centerCoordX, centerCoordY)
    for y = centerCoordY - visionRadius, centerCoordY + visionRadius do
        local iy = y - centerCoordY + visionRadius + 1
        for x = centerCoordX - visionRadius, centerCoordX + visionRadius do
            local ix = x - centerCoordX + visionRadius + 1
            local tileData = self.mapData:getTileDataAtCoord(x, y)
            if tileData ~= nil then
                local colorLevel = self:getVisionLevel(pathLengthMap, ix, iy)
                self:updateTileVisionAppearance(tileData, colorLevel, centerCoordX, centerCoordY, progress)
                -- print ("CaveMap:updateTilesVisionAppearanceWithColorLevelMap update tile", tileData.x, tileData.y, colorLevel, progress)
            end
        end
    end
end
function CaveMap:hideAllMapTileNotAround(centerCoordX, centerCoordY, progress)
    if (self.enableOptimization) then
        self.caveMapOptimization:hideAllMapTileNotAround(centerCoordX, centerCoordY)
    end
end
function CaveMap:updateTilesVisionAppearance(from, to, current)
    if(self.mapData.appearanceConfig.wallCategoryCount <= 0) then 
        return
    end

    local progress = 0.0
    if from.x == to.x and from.y == to.y then
        progress = 1.0
        -- print("CaveMap:updateTilesVisionAppearance finish progress: ", progress)
    else
        local s = lume.distance(from.x, from.y, to.x, to.y, true)
        local d = lume.distance(from.x, from.y, current.x, current.y, true)
        progress = math.min(d / s,1.0)
        -- print("CaveMap:updateTilesVisionAppearance s d update progress: ", s, d, progress)
    end
    
    -- printf("updateTilesVisionAppearanceForCenterCoord %d,%d with progress %f", to.x, to.y, progress)
    self:updateTilesVisionAppearanceForCenterCoord_new(to.x, to.y, progress)

end

function CaveMap:screenCenterToCoord(centerCoordX, centerCoordY, animated, moveDuration, isSync, isEaseInOut, cb)
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
            local curCordX, curCordY = self:mapPositionToCoordinate(self:getPosition())
            local distX = centerCoordX - curCordX
            local distY = centerCoordY - curCordY
            local dist = math.ceil(math.pow(math.pow(distX, 2) + math.pow(distY, 2), 1/2))
            local unitTime = dist >= 1 and moveDuration / dist or 0
            if (dist > 0) then
                for i=1,dist do
                    local timeNow = i * unitTime
                    local progress = timeNow / moveDuration
                    performWithDelay(self, function() 
                        -- 更新地图
                        self:updateMapTileAround(curCordX + progress * distX, curCordY + progress * distY)
                    end, timeNow)
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

function CaveMap:updateMapTileWhenMoving(centerCoordX, centerCoordY)
    if (self.enableOptimization) then
        self.caveMapOptimization:updateMapTileWhenMoving(centerCoordX, centerCoordY)
    end
end

function CaveMap:updateMapTileAround(centerCoordX, centerCoordY)
    if (centerCoordX == 0 and centerCoordY == 0) then return end

    if (self.enableOptimization) then
        self.caveMapOptimization:updateMapTileAround(centerCoordX, centerCoordY)
    end
end

function CaveMap:setMapObject(coordX, coordY, mapObject)
    if (self.enableOptimization) then
        self.caveMapOptimization:setMapObject(coordX, coordY, mapObject)
    end
end

function CaveMap:unsetMapObject(coordX, coordY, mapObject)
    if (self.enableOptimization) then
        self.caveMapOptimization:unsetMapObject(coordX, coordY, mapObject)
    end
end

function CaveMap:setPermanentVisible(coordX, coordY, mapObject)
    if (self.enableOptimization) then
        self.caveMapOptimization:setPermanentVisible(coordX, coordY, mapObject)
    end
end

-- Helper

function CaveMap:getVisionLevel(pathLenMap, x, y)
    return pathLenMap[y][x] + 1
end

function CaveMap:setTileTerrain(coordX, coordY, tileTerrain)
    if self.tileTerrainMap[coordY + 1] == nil then
        self.tileTerrainMap[coordY + 1] = {}
    end
    self.tileTerrainMap[coordY + 1][coordX + 1] = tileTerrain
end

function CaveMap:getTileTerrain(coordX, coordY)
    if self.tileTerrainMap[coordY + 1] == nil then
        return nil
    end
    return self.tileTerrainMap[coordY + 1][coordX + 1]
end

function CaveMap:setEffectColors(coordX, coordY, effectColor)
    if self.effectColorsMap[coordY + 1] == nil then
        self.effectColorsMap[coordY + 1] = {}
    end
    self.effectColorsMap[coordY + 1][coordX + 1] = effectColor
end

function CaveMap:getEffectColors(coordX, coordY)
    if self.effectColorsMap[coordY + 1] == nil then
        return nil
    end
    return self.effectColorsMap[coordY + 1][coordX + 1]
end

function CaveMap:setDecorations(coordX, coordY, decorations)
    if self.decorationsMap[coordY + 1] == nil then
        self.decorationsMap[coordY + 1] = {}
    end
    self.decorationsMap[coordY + 1][coordX + 1] = decorations
end

function CaveMap:getDecorations(coordX, coordY)
    if self.decorationsMap[coordY + 1] == nil then
        return nil
    end
    return self.decorationsMap[coordY + 1][coordX + 1]
end

function CaveMap:getDecoration(name, coordX, coordY)
    local decorations = self:getDecorations(coordX, coordY)
    if(decorations) then
        for _, decoration in ipairs(decorations) do 
            if decoration.name == name then 
                return decoration
            end
        end
    end
    return nil
end

-- Coordinate, Position and Z Order

function CaveMap:checkIsWorldPositionOnMap(x, y)
    local mapPos = self:convertToNodeSpace(cc.p(x, y))
    local coordX, coordY = self:positionToCoordinate(mapPos.x, mapPos.y)
    local mapData = self.mapData:getTileDataAtCoord(coordX, coordY)
    if (mapData ~= nil) then
        return true
    end
    return false
end

function CaveMap:checkIsMapPositionOnMap(x, y)
    local mapData = self.mapData:getTileDataAtCoord(x, y)
    if (mapData ~= nil) then
        return true
    end
    return false
end

function CaveMap:checkIsMapCoordOnMap(x, y)
    local mapData = self.mapData:getTileDataAtCoord(x, y)
    if (mapData ~= nil) then
        return true
    end
    return false
end

function CaveMap:getCenterPositionOfBoundingBox(cx, cy, cz, width, height)
    return MapHelper.getCenterPositionOfBoundingBox(cx, cy, cz, width, height, self.tileWidth, self.tileHeight, MapDefine.ZAxisPixelsPerNormalizedUnit)
end

function CaveMap:positionToCoordinate(x, y, z)
    z = z or 0
    return MapHelper.positionToCoordinate(x, y, z, self.tileWidth, self.tileHeight, MapDefine.ZAxisPixelsPerNormalizedUnit)
end

function CaveMap:coordinateToPosition(cx, cy, cz)
    cz = cz or 0
    local x, y, z = MapHelper.coordinateToPosition(cx, cy, cz, self.tileWidth, self.tileHeight, MapDefine.ZAxisPixelsPerNormalizedUnit)
    -- plus and half tile height to make position at center of tile
    y = y + self.tileHeightHalf
    return x, y, z
end

function CaveMap:mapPositionToCoordinate(x, y, screenSize)
    local sz = screenSize or winSize
    local centerPosX, centerPosY = sz.width * 0.5 - x, sz.height * 0.5 - y
    local cx, cy = self:positionToCoordinate(centerPosX, centerPosY);
    return cx, cy
end

function CaveMap:coordinateToMapPosition(cx, cy, screenSize)
    local sz = screenSize or winSize
    local centerPosX, centerPosY = self:coordinateToPosition(cx, cy)
    local mapPosX, mapPosY = -centerPosX + sz.width * 0.5, -centerPosY + sz.height * 0.5
    return mapPosX, mapPosY 
end

function CaveMap:getZOrderByCoordinate(cx, cy, zOffset)
    -- cx = math.floor(cx)
    -- cy = math.floor(cy)
    -- assert(cx == math.floor(cx) and cy == math.floor(cy), "coordinate x and y must be integer")
    local zz = zOffset or 0 
    return (self.sizeX + self.sizeY - cx - cy) * MapDefine.ZOrderMaxOffsetPerCoordinate + zz
end

function CaveMap:getBoundingProperZOrder(boundingPoint, x, y, width, height, z)
    return MapHelper.calculateZOrder(boundingPoint, x, y, width, height, 0, self.sizeX, self.sizeY)
end

function CaveMap:getDecorationProperZOrder(decorationData, cx, cy)
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
    --     else 
    --         zOrder = self:getZOrderByCoordinate(cx + ow, cy + oh, 0)
    --     end
    -- end
    -- return zOrder
end

function CaveMap:isInBounds(x, y)
    return grids.isInBounds(x, y, self.sizeX, self.sizeY)
end

-- Effect Color 
function CaveMap:makeEffectColorWithCoordinates(color, opacity, stayDuration, coordinates)
    for _, coordinate in ipairs(coordinates) do
        local cx, cy = coordinate.x, coordinate.y
        if self:isInBounds(cx + 1, cy + 1) then
            local tileTerrain = self:getTileTerrain(cx, cy)
            if tileTerrain ~= nil then
                tileTerrain:addEffectColorWithOpacity(self, color, opacity, stayDuration)
            end
        end 
    end
end

function CaveMap:makeRectangleEffectColor(color, opacity, stayDuration, rect)
    for cy = rect.y, rect.y + rect.height - 1 do
        for cx = rect.x, rect.x + rect.width - 1 do
            if self:isInBounds(cx + 1, cy + 1) then
                local tileTerrain = self:getTileTerrain(cx, cy)
                if tileTerrain ~= nil then
                    tileTerrain:addEffectColorWithOpacity(self, color, opacity, stayDuration)
                end
            end
        end
    end
end

function CaveMap:makeEffectColorWithCenterAndSize(color, opacity, stayDuration, center, size)
    local hr = math.floor(size.width / 2)
    local vr = math.floor(size.height / 2)
    for cy = center.y - vr, center.y + vr do
        for cx = center.x - hr, center.x + hr do
            if self:isInBounds(cx + 1, cy + 1) then
                local tileTerrain = self:getTileTerrain(cx, cy)
                if tileTerrain ~= nil then
                    tileTerrain:addEffectColorWithOpacity(self, color, opacity, stayDuration)
                end
            end
        end
    end
end

-- TEST
function CaveMap:makeRangeEffectAtCoordinate(coordinate)
    local radius = {3, 5, 7, 9}
    local r = lume.randomchoice(radius)
    local size = {width = r, height = r}
    local opacity = math.random(150, 255)
    local duration = lume.random(0.5, 5)
    local colors = MapDataManager:getInstance():getTotalColors()
    local color = lume.randomchoice(colors)
    color.a = 255
    self:makeEffectColorWithCenterAndSize(color, opacity, duration, coordinate, size)

    print (("make range effect coordinate:%d,%d size:%d,%d opacity:%d duration:%d color:%d,%d,%d,%d"):format(coordinate.x, coordinate.y, size.width, size.height, opacity, duration, color.r, color.g, color.b, color.a));
end

function CaveMap:makePulseRangeEffectAtCoodinate(coordinate)
    local radius = {3, 5, 7, 9}
    local r = lume.randomchoice(radius)
    local size = {width = r, height = r}
    local opacity = math.random(150, 235)
    local duration = lume.random(0.15, 3)
    local colors = MapDataManager:getInstance():getTotalColors()
    local color = lume.randomchoice(colors)
    color.a = 255

    local coordinates2DArray = {}
    lume.push(coordinates2DArray, {coordinate})
    for i = 1, r do
        local coordinates = {}
        for cy = coordinate.y - i, coordinate.y + i do
            for cx = coordinate.x - i, coordinate.x + i do
                if cy == coordinate.y - i or cy == coordinate.y + i or cx == coordinate.x - i or cx == coordinate.x + i then
                    lume.push(coordinates, {x = cx, y = cy})
                end
            end
        end
        lume.push(coordinates2DArray, coordinates)
    end

    local pulseInterval = lume.random(0.05, 0.3)

    if self.entryID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.entryID)
    end
    self.entryID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function (dt) 
        if #coordinates2DArray > 0 then
            local coordinates = coordinates2DArray[1]
            table.remove(coordinates2DArray, 1)
            self:makeEffectColorWithCoordinates(color, opacity, duration, coordinates)
        else 
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.entryID)
        end
    end, pulseInterval, false)

    print (("make pulse effect coordinate:%d,%d size:%d,%d opacity:%d stayduration:%d color:%d,%d,%d,%d pulseInterval:%d"):format(coordinate.x, coordinate.y, size.width, size.height, opacity, duration, color.r, color.g, color.b, color.a, pulseInterval));
end

-- DEBUG

function CaveMap:printTerrainsMap()
    for y = 1, self.sizeY do
        for x = 1, self.sizeX do
            if self.tileTerrainMap[y] == nil then
                io.write("r")
            else
                local tile = self.tileTerrainMap[y][x]
                if tile == nil then
                    io.write("c")
                else 
                    io.write("1")
                end
            end
        end
        io.write("\n")
    end
end

function CaveMap:drawDecorationDebugBox(decoration)
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
-- 释放资源
function CaveMap:destroy()
    -- print("#### CaveMap:destroy")
    -- dump(self.mapData)
    -- preload texture atlas
    if self.mapData.decorationPlist ~= nil then
        if type(self.mapData.decorationPlist) == "table" then
            for _, plist in ipairs(self.mapData.decorationPlist) do
                -- print("#### CaveMap:destroy",plist)
                Avalon.ResHelper:unloadPlist(plist)
            end
        elseif type(self.mapData.decorationPlist) == "string" then 
            -- print("#### CaveMap:destroy",self.mapData.decorationPlist)
            Avalon.ResHelper:unloadPlist(self.mapData.decorationPlist)
        end
    end
    local decorationPlist = self.mapName .. "_decoration.plist"
    if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():fullPathForFilename(decorationPlist)) then
        -- print("#### CaveMap:destroy",decorationPlist)
        Avalon.ResHelper:unloadPlist(decorationPlist)
    end
    if self.mapData.hasChamber then 
        local chamberPlist = self.mapName .. "_chamber.plist"
        if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():fullPathForFilename(chamberPlist)) then
            -- print("#### CaveMap:destroy",chamberPlist)
            Avalon.ResHelper:unloadPlist(chamberPlist)
        end
    end
    if self.mapData.sceneType == PublicDefine.SCENE_TYPE.BOSS then 
        local bossfloorPlist = self.mapName .. "_bossfloor.plist"
        if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():fullPathForFilename(bossfloorPlist)) then
            -- print("#### CaveMap:destroy",bossfloorPlist)
            Avalon.ResHelper:unloadPlist(bossfloorPlist)
        end
    end
end

function CaveMap:getCenterCoord()
    return {x = self.centerCoordX, y = self.centerCoordY}
end
return CaveMap

