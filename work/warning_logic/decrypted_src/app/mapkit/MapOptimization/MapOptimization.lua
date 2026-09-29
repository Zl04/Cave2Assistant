--[[
    场景地图优化
]]

local DEBUG = false

local lume = require "thirdparty.lume"
local MapDefine = require "app.mapkit.MapDefine"

local MapOptimization = class("MapOptimization")

-- 城镇地块随机概率配置表
-- @categorys 地块类型类别
-- @rate 出现概率
local TOWN_TERRAIN_RANDOM_CONFIG = {
    [1] = {
        categorys = {1, 2},
        rate = 50
    },
    [2] = {
        categorys = {3, 4, 5},
        rate = 6
    },
    [3] = {
        categorys = {6, 7, 8, 9},
        rate = 6
    },
    [4] = {
        categorys = {10},
        rate = 1
    }
}

local GUILD_TERRAIN_RANDOM_CONFIG = {
    [1] = {
        categorys = {1, 2},
        rate = 50
    },
    [2] = {
        categorys = {3, 4, 5},
        rate = 3
    },
    [3] = {
        categorys = {6, 7, 8},
        rate = 3
    },
    [4] = {
        categorys = {9},
        rate = 1
    }
}

local function isTownOrGuild(sceneType) 
    return sceneType == PublicDefine.SCENE_TYPE.TOWN 
        or sceneType == PublicDefine.SCENE_TYPE.GUILD
        or sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE
        or sceneType == PublicDefine.SCENE_TYPE.MANOR
        or sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT
end

-- 城镇地块是否反转的概率
local TOWN_TERRAIN_FLIP_RANDOM = 0.5

local function randomMapTerrainCategory(sceneType)
    -- 随机地块算法
    local groupsCountMap = {}
    local categorysCountMap = {}
    local totalRate = 0
    local terrainRandomConfig = nil
    if sceneType == PublicDefine.SCENE_TYPE.TOWN then 
        terrainRandomConfig = TOWN_TERRAIN_RANDOM_CONFIG
    elseif sceneType == PublicDefine.SCENE_TYPE.GUILD then 
        terrainRandomConfig = GUILD_TERRAIN_RANDOM_CONFIG
    elseif sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE then 
        terrainRandomConfig = GUILD_TERRAIN_RANDOM_CONFIG
    elseif sceneType == PublicDefine.SCENE_TYPE.MANOR then 
        terrainRandomConfig = GUILD_TERRAIN_RANDOM_CONFIG
    elseif sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT then 
        terrainRandomConfig = GUILD_TERRAIN_RANDOM_CONFIG
    end 
    if terrainRandomConfig == nil then
        local err = string.format("terrain random config missing for sceneType %d", sceneType)
       assert(false, err)
    end
    local groupsCount = #terrainRandomConfig
    for i = 1, groupsCount do
        groupConfig = terrainRandomConfig[i]
        totalRate = totalRate + groupConfig.rate
    end

    local category = 1
    local groupsCount = #terrainRandomConfig
    if (groupsCount >= 1) then
        local startRate = 0
        local endRate = 0
        local groupRate = math.random(1, totalRate)
        -- print("randomMapTerrainCategory1 ", groupRate)
        for i = 1, groupsCount do
            groupConfig = terrainRandomConfig[i]
            -- 检测是否命中
            endRate = startRate + groupConfig.rate
            -- print("randomMapTerrainCategory2 ", i, groupRate, startRate, endRate)
            if (groupRate >= startRate + 1 and groupRate <= endRate) then
                local categorysCount = #groupConfig.categorys
                if (categorysCount >= 1) then
                    local categoryIndex = math.random(1, categorysCount)
                    category = groupConfig.categorys[categoryIndex]
                    -- print("randomMapTerrainCategory3 ", categoryIndex, category)

                    local groupCount = groupsCountMap[i] or 0
                    groupsCountMap[i] = groupCount + 1
                    local categoryCount = categorysCountMap[category] or 0
                    categorysCountMap[category] = categoryCount + 1
                end

                break
            end
            startRate = endRate
        end
    end
    -- print("randomMapTerrainCategory4 ", category)
    return category
end

-- 检测矩形范围是否可见
local function checkRectCollion(rectLeft1, rectRight1, rectBottom1, retctUp1, rectLeft2, rectRight2, rectBottom2, rectUp2)
    return rectLeft1 <= rectRight2 and rectLeft2 <= rectRight1 and
           rectBottom1 <= rectUp2 and rectBottom2 <= retctUp1
end

-- 添加一个角色
local function onAddModelHandler(self, data)
    -- why do this fucking logic ???
    -- Hysteria think we should distict town and cave map here
    if self.isCave then 
        if (data) then
            local coordX, coordY = data.coordX, data.coordY
            self:removeMapTileDecorations(coordX, coordY)
        end
    end
end


-- 检测地块是否在屏幕内
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
local function checkMapTileVisible(self, coordX, coordY)
    local offsetX = math.abs(coordX - self._centerCoordX)
    local offsetY = math.abs(coordY - self._centerCoordY)

    return offsetX + offsetY <= self._visibleRadius

    -- local visionLeft = self._centerCoordX - self._visibleRadius
    -- local visionRight = self._centerCoordX + self._visibleRadius
    -- local visionUp = self._centerCoordY + self._visibleRadius
    -- local visionBottom = self._centerCoordY - self._visibleRadius
    
    -- local sizeX, sizeY = 1,1
    -- local decorationLeft, decorationBottom = coordX, coordY
    -- local decorationRight = coordX + sizeX - 1
    -- local decorationUp = coordY + sizeY - 1

    -- return checkRectCollion(visionLeft, visionRight, visionBottom, visionUp, 
    --             decorationLeft, decorationRight, decorationBottom, decorationUp)
end

-- 显示地块
-- @coordX 地块x坐标
-- @coordY 地块y坐标
local function showMapTile(self, coordX, coordY)
    if (coordX < 0 or coordY < 0 or coordX >= self._mapSizeX or coordY >= self._mapSizeY) then return end
    if (DEBUG) then
        print("MapOptimization showMapTile: ", coordX, coordY)
    end

    local index = self:coordToIndex(coordX, coordY)
    local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)

    -- 显示地块的地形
    local tileTerrain = self._tileTerrainMap[index]
    if (not tileTerrain and mapTileData) then
        tileTerrain = self:createMapTileTerrain(coordX, coordY)
        if (tileTerrain) then
            self._tileTerrainMap[index] = tileTerrain
        end
    end
    if (tileTerrain) then
        tileTerrain:setVisible(true)
    end

    -- 显示地块的颜色效果
    local effectColors = self._tileEffectColorsMap[index]
    if (not effectColors) then
        effectColors = self:createMapTileEffectColors(coordX, coordY)
        if (effectColors) then
            self._tileEffectColorsMap[index] = effectColors
        end
    end
    if (effectColors) then
        for i = 1, #effectColors do
            effectColors[i]:setVisible(true)
        end
    end

    -- 显示地块对象
    local mapObjects = self._mapObjectsMap[index]
    if (mapObjects) then
        for i = 1, #mapObjects do
            local mapObject = mapObjects[i]
            mapObject:setVisible(true)
        end
    end
end

-- 隐藏地块
-- @coordX 地块x坐标
-- @coordY 地块y坐标
local function hideMapTile(self, coordX, coordY)
    if (coordX < 0 or coordY < 0 or coordX >= self._mapSizeX or coordY >= self._mapSizeY) then return end
    if (DEBUG) then
        print("MapOptimization hideMapTile: ", coordX, coordY)
    end

    local index = self:coordToIndex(coordX, coordY)

    -- 隐藏地块的地形
    local tileTerrain = self._tileTerrainMap[index]
    if (tileTerrain) then 
        self:removeMapTileTerrain(tileTerrain, coordX, coordY)
        self._tileTerrainMap[index] = nil
    end

    -- 隐藏地块的颜色效果
    local effectColors = self._tileEffectColorsMap[index]
    if (effectColors) then
        self:removeMapTileEffectColors(effectColors, coordX, coordY)
        self._tileEffectColorsMap[index] = nil
    end

    -- 隐藏地块对象
    local mapObjects = self._mapObjectsMap[index]
    if (mapObjects) then
        for i = 1, #mapObjects do
            local mapObject = mapObjects[i]
            if (self._permanentMapobjectsMap[index] == mapObject) then
                print("visible ", coordX, coordY)
            else 
                mapObject:setVisible(false) 
            end
        end
    end
end

-- 初始化
-- @map 地图对象
-- @visibleRadius 可视范围（半径）
function MapOptimization:init(map, visibleRadius)
    self._map = map
    self._mapData = map.mapData
    self._visibleRadius = visibleRadius

    if (self._mapData) then
        self._mapSizeX = self._mapData.width
        self._mapSizeY = self._mapData.height
        self._tileWidth = self._mapData.tileWidth
        self._tileHeight = self._mapData.tileHeight
    else
        assert(false)
    end
    self._centerCoordX = 0
    self._centerCoordY = 0

    -- 可视区域起始坐标的索引
    self._startIndex = 0
    -- 地块地形的索引表
    self._tileTerrainMap = {}
    -- 地块装饰物的索引表
    self._decorationDataList = {}
    self._decorationList = {}
    
    local sceneType = self._mapData.sceneType
    local groundCategoryCount = self._mapData.appearanceConfig.groundCategoryCount
    for y = self._mapSizeY, 1, -1 do
        for x = self._mapSizeX, 1, -1 do
            local coordX, coordY = x - 1, y - 1
            local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)
            if (mapTileData) then
                -- 随机地块样式
                if (isTownOrGuild(sceneType) and self._mapData.caveMode ~= PublicDefine.CAVE_MODE.MODE_PET) then
                    local upCategory = 0
                    local rightCategory = 0
                    local rightUpCategory = 0
                    local upMapTileData = self._mapData:getTileDataAtCoord(coordX, coordY + 1)
                    if (upMapTileData) then
                        local terrainData = upMapTileData:getTerrainData()
                        upCategory = terrainData:getCategory()
                    end
                    local rightMapTileData = self._mapData:getTileDataAtCoord(coordX + 1, coordY)
                    if (rightMapTileData) then
                        local terrainData = rightMapTileData:getTerrainData()
                        rightCategory = terrainData:getCategory()
                    end 
                    local rightUpTileData = self._mapData:getTileDataAtCoord(coordX + 1, coordY + 1)
                    if (rightUpTileData) then
                        local terrainData = rightUpTileData:getTerrainData()
                        rightUpCategory = terrainData:getCategory()
                    end 

                    local category = 0
                    repeat
                        category = randomMapTerrainCategory(sceneType)
                        if (category == 1 or category == 2) then break end
                        if (category ~= upCategory and category ~= rightCategory and category ~= rightUpCategory) then break end
                    until (false)

                    local isFlipped = (math.random(1, 10) / 10) <= TOWN_TERRAIN_FLIP_RANDOM

                    -- local category = randomMapTerrainCategory()
                    local terrainData = mapTileData:getTerrainData()
                    terrainData:setCategory(category)
                    terrainData:setFlippedX(isFlipped)
                end

                -- 提取装饰物的数据
                local decorationDatas = mapTileData.decorationDatas
                for _, decorationData in pairs(decorationDatas) do
                    local size = decorationData:getOccupySize()

                    decorationData.x = coordX
                    decorationData.y = coordY
                    decorationData.width = size.width
                    decorationData.height = size.height
                    lume.push(self._decorationDataList, decorationData)
                end
            end
        end
    end
    -- print("create map tile ")
    -- dump(groupsCountMap)
    -- dump(categorysCountMap)

    -- 地块上的颜色效果
    self._tileEffectColorsMap = {}
    -- 地块对象的索引表
    self._mapObjectIndexMap = {}
    self._mapObjectsMap = {}
    -- 永久显示的对象
    self._permanentMapobjectsMap = {}

    -- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
        elseif (nodeEvent == "exit") then
            print("MapOptimization onExit ")
            self:destroy()
        else end
    end
    map:registerScriptHandler(onNodeEventHandler)

    Avalon.MessageCenter:bind(GameMessage.MC_BATTLE_ADD_GAME_MODEL, self, onAddModelHandler)
end

-- 销毁
function MapOptimization:destroy()
    
    for i, decoration in pairs(self._decorationList) do
        if not tolua.isnull(decoration) then
            decoration:destroy()
        end
    end
    for k,decoration in pairs(self._permanentMapobjectsMap) do
        if not tolua.isnull(decoration) then
            decoration:removeFromParent(true)    
        end
    end
    for k,object in pairs(self._tileTerrainMap) do
        if object.destroy then
            object:destroy()
        else
            if not tolua.isnull(object) then
                object:removeFromParent(true)
            end
        end
        
        
    end
    -- dump(self._tileTerrainMap,"",10)
    Avalon.MessageCenter:unbind(GameMessage.MC_BATTLE_ADD_GAME_MODEL, self, onAddModelHandler)
end

-- 移动过程中，更新屏幕周围的地块
-- @centerCoordX 中心地块的x坐标
-- @centerCoordY 中心地块的y坐标
function MapOptimization:updateMapTileWhenMoving(centerCoordX, centerCoordY)
    if (DEBUG) then
        print("MapOptimization updateMapTileWhenMoving: ", centerCoordX, centerCoordY, self._centerCoordX, self._centerCoordY)
    end

    local offsetX = centerCoordX - self._centerCoordX
    local offsetY = centerCoordY - self._centerCoordY

    if (math.floor(centerCoordX) ~= centerCoordX or math.floor(centerCoordY) ~= centerCoordY) or 
       (not ((math.abs(offsetX) == 1 and offsetY == 0) or (math.abs(offsetY) == 1 and offsetX == 0))) or
       (offsetY == 0 and offsetX == 0) then
        -- printError(string.format("[ERROR] MapOptimization updateMapTileWhenMoving: coord is invalid, from (%f,%f) to (%f,%f).", 
            -- self._centerCoordX, self._centerCoordY, centerCoordX, centerCoordY))

        if(centerCoordX ==0 and centerCoordY == 0) then 
            -- add by zp 这里业务逻辑上不应该能够走到这个地块去
            self:updateMapTileAround(centerCoordX, centerCoordY)
        else 
            self:updateMapTileAround(centerCoordX, centerCoordY)
        end
    else 
        local lastCenterCoordX = self._centerCoordX
        local lastCenterCoordY = self._centerCoordY
        self._centerCoordX = centerCoordX
        self._centerCoordY = centerCoordY

        local showStartCoordX = 0 showStartCoordY = 0
        local hideStartCoordX = 0 hideStartCoordY = 0
        if (offsetX ~= 0) then
            showStartCoordX = centerCoordX
            hideStartCoordX = lastCenterCoordX

            for i = 0, self._visibleRadius do
                local showCoordX = showStartCoordX + i * offsetX
                local hideCoordX = hideStartCoordX - i * offsetX
                local coordY_up = centerCoordY + self._visibleRadius - i
                local coordY_down = centerCoordY + i - self._visibleRadius

                showMapTile(self, showCoordX, coordY_up)
                showMapTile(self, showCoordX, coordY_down)
                hideMapTile(self, hideCoordX, coordY_up)
                hideMapTile(self, hideCoordX, coordY_down)
            end
        end
        if (offsetY ~= 0) then
            showStartCoordY = centerCoordY
            hideStartCoordY = lastCenterCoordY

            for i = 0, self._visibleRadius do
                local showCoordY = showStartCoordY + i * offsetY
                local hideCoordY = hideStartCoordY - i * offsetY
                local coordX_left = centerCoordX + self._visibleRadius - i
                local coordX_right = centerCoordX + i - self._visibleRadius

                showMapTile(self, coordX_left, showCoordY)
                showMapTile(self, coordX_right, showCoordY)
                hideMapTile(self, coordX_left, hideCoordY)
                hideMapTile(self, coordX_right, hideCoordY)
            end
        end
    end
end

-- 静止时，更新中心坐标周围的地块
-- @centerCoordX 中心地块的x坐标
-- @centerCoordY 中心地块的y坐标
function MapOptimization:updateMapTileAround(centerCoordX, centerCoordY)
    if (DEBUG) then
        print("MapOptimization updateMapTileAround: ", centerCoordX, centerCoordY, self._centerCoordX, self._centerCoordY)
    end

    if (math.floor(centerCoordX) ~= centerCoordX or math.floor(centerCoordY) ~= centerCoordY) then
        print(string.format("[ERROR] MapOptimization updateMapTileAround: coord (%f,%f) is invalid.", 
            centerCoordX, centerCoordY))

        centerCoordX = math.floor(centerCoordX)
        centerCoordY = math.floor(centerCoordY)
    end

    local startX = centerCoordX - self._visibleRadius
    local startY = centerCoordY - self._visibleRadius
    local endX = centerCoordX + self._visibleRadius
    local endY = centerCoordY + self._visibleRadius

    self._centerCoordX = centerCoordX
    self._centerCoordY = centerCoordY
    self._startIndex = self:coordToIndex(startX, startY)

    for i = startX, endX do
        for j = startY, endY do
            local coordX = i
            local coordY = j
            if (checkMapTileVisible(self, coordX, coordY)) then 
                showMapTile(self, coordX, coordY) 
            end
        end
    end
end
-- 静止时，隐藏没有在显示范围内的所有地块(适用于传送)
-- @centerCoordX 中心地块的x坐标
-- @centerCoordY 中心地块的y坐标
function MapOptimization:hideAllMapTileNotAround(centerCoordX, centerCoordY)
    if (DEBUG) then
        print("MapOptimization hideMapTileAround: ", centerCoordX, centerCoordY, self._centerCoordX, self._centerCoordY)
    end
    local startX = centerCoordX - self._visibleRadius
    local startY = centerCoordY - self._visibleRadius
    local endX = centerCoordX + self._visibleRadius
    local endY = centerCoordY + self._visibleRadius

    local co = coroutine.create(function ()
        for y = 1,self._mapSizeY do
            for x = 1,self._mapSizeX do
                local coordX = x
                local coordY = y
                -- if (coordX <= startX or coordX >= endX) or (coordY <= startY or coordY >= endY) then
                    if (not checkMapTileVisible(self, coordX, coordY)) then 
                        hideMapTile(self, coordX, coordY) 
                    end
                -- end
            end
        end
    end)
    coroutine.resume(co)
    

end
-- 设置地图显示对象的索引
-- @coordX 地块x坐标
-- @coordY 地块y坐标
-- @mapObject 显示对象
function MapOptimization:setMapObject(coordX, coordY, mapObject)
    if (coordX >= 0 and coordY >= 0 and mapObject) then
        -- 从之前的引用中移除
        local lastIndex = self._mapObjectIndexMap[mapObject]
        if (lastIndex) then
            local mapObjects = self._mapObjectsMap[lastIndex]
            if (mapObjects) then
                for i = 1, #mapObjects do
                    local _mapObject = mapObjects[i]
                    if (_mapObject == mapObject) then
                        table.remove(mapObjects, i)
                        if (DEBUG) then
                            print(string.format("MapOptimization setMapObject: last index:%d %d %d %s ", lastIndex, coordX, coordY, mapObject))
                        end
                        break
                    end
                end
            else
                assert(false)
            end
        end

        -- 创建新的引用
        local index = self:coordToIndex(coordX, coordY)
        local mapObjects = self._mapObjectsMap[index]
        if (not mapObjects) then
            self._mapObjectsMap[index] = {}
            mapObjects = self._mapObjectsMap[index]
        end
            
        local visible = checkMapTileVisible(self, coordX, coordY)
        mapObject:setVisible(visible)
        table.insert(mapObjects, mapObject)
        self._mapObjectIndexMap[mapObject] = index

        if (self._permanentMapobjectsMap[index] == mapObject) then
            mapObject:setVisible(true)
        end

        if (DEBUG) then
            print(string.format("MapOptimization setMapObject: index:%d %d %d %s ", index, coordX, coordY, mapObject))
        end
    else
        assert(false)
    end
end

-- 取消设置地图显示对象的索引
-- @coordX 地块x坐标
-- @coordY 地块y坐标
-- @mapObject 显示对象
function MapOptimization:unsetMapObject(coordX, coordY, mapObject)
    if (coordX >= 0 and coordY >= 0 and mapObject) then
        local lastIndex = self._mapObjectIndexMap[mapObject]
        if (lastIndex) then
            local mapObjects = self._mapObjectsMap[lastIndex]
            if (mapObjects) then
                for i = 1, #mapObjects do
                    local _mapObject = mapObjects[i]
                    if (_mapObject == mapObject) then
                        table.remove(mapObjects, i)
                        if (DEBUG) then
                            print(string.format("MapOptimization unsetMapObject: last index:%d %d %d %s ", lastIndex, coordX, coordY, mapObject))
                        end
                        break
                    end
                end
            else
                assert(false)
            end
        end
    else
        assert(false)
    end
end

-- 加入永久显示列表
function MapOptimization:setPermanentVisible(coordX, coordY, mapObject)
    local index = self:coordToIndex(coordX, coordY)

    if (self._permanentMapobjectsMap[index] == nil) then
        self._permanentMapobjectsMap[index] = mapObject
        mapObject:setVisible(true)
    else
        assert(false)
    end
end

-- 获取地图地形
function MapOptimization:getTileTerrain(coordX, coordY)
    local index = self:coordToIndex(coordX, coordY)
    return self._tileTerrainMap[index]
end

-- 计算坐标的索引
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function MapOptimization:coordToIndex(coordX, coordY)
    return coordY * self._mapSizeX + coordX
end

-- 添加装饰物数据
function MapOptimization:addMapTileDecorationDatas(mapTileData)
    if (mapTileData) then
        local decorationDatas = mapTileData.decorationDatas
        for _, decorationData in pairs(decorationDatas) do
            local size = decorationData:getOccupySize()
            local coordX, coordY = mapTileData.x, mapTileData.y

            decorationData.x = coordX
            decorationData.y = coordY
            decorationData.width = size.width
            decorationData.height = size.height
            lume.push(self._decorationDataList, decorationData)
            -- printfmt("addMapTileDecorationDatas %s %d at %d,%d", decorationData.skin, decorationData.ID, coordX, coordY)
        end
    else
        assert(false)
    end
end

-- 检测装饰物的可见性
function MapOptimization:checkDecorationVisible(decoration)
    local heroBoundingboxLeft = self._centerCoordX - self._visibleRadius
    local heroBoundingboxRight = self._centerCoordX + self._visibleRadius
    local heroBoundingboxUp = self._centerCoordY + self._visibleRadius
    local heroBoundingboxBottom = self._centerCoordY - self._visibleRadius

    local decorationBoundingboxLeft, decorationBoundingboxBottom = decoration:getCoordinate()
    local decorationSize = decoration:getOccupySize()
    local decorationBoundingboxRight = decorationBoundingboxLeft + decorationSize.width - 1
    local decorationBoundingboxUp = decorationBoundingboxBottom + decorationSize.height - 1

    local visible = heroBoundingboxLeft <= decorationBoundingboxRight and
                    decorationBoundingboxLeft <= heroBoundingboxRight and
                    heroBoundingboxBottom <= decorationBoundingboxUp and
                    decorationBoundingboxBottom <= heroBoundingboxUp
    decoration:setVisible(visible)
end

-- 检查所有装饰物的可见性
function MapOptimization:checkDecorationsVisible()
    local visionLeft = self._centerCoordX - self._visibleRadius
    local visionRight = self._centerCoordX + self._visibleRadius
    local visionUp = self._centerCoordY + self._visibleRadius
    local visionBottom = self._centerCoordY - self._visibleRadius

    for i, decorationData in pairs(self._decorationDataList) do
        if (decorationData) then
            local coordX, coordY = decorationData.x, decorationData.y
            local sizeX, sizeY = decorationData.width, decorationData.height

            local decorationLeft, decorationBottom = coordX, coordY
            local decorationRight = coordX + sizeX - 1
            local decorationUp = coordY + sizeY - 1

            local decoration = self._decorationList[i]
            local visible = false
            if (sizeX > 1 or sizeY > 1) then
                -- visible = cc.rectIntersection(cc.rect(visionLeft, visionBottom, self._visibleRadius * 2, self._visibleRadius * 2), cc.rect(decorationLeft, decorationBottom, sizeX, sizeY))

                visible = checkRectCollion(visionLeft, visionRight, visionBottom, visionUp, 
                decorationLeft, decorationRight, decorationBottom, decorationUp)
            else
                visible = checkMapTileVisible(self, coordX, coordY)
            end

            -- if (DEBUG) then
                -- printfmt("checkDecorations %s Visible %s at %d,%d,%d,%d ", decorationData.skin, tostring(visible), coordX, coordY, sizeX, sizeY)
            -- end

            if (visible) then
                if (not decoration) then
                    decoration = self:createMapTileDecoration(decorationData, coordX, coordY)
                    if (decoration) then
                        if (DEBUG) then
                            print("TownMapOpimization checkDecorationsVisible add : ", coordX, coordY)
                        end

                        self._decorationList[i] = decoration
                    else
                        assert(false)
                    end
                else
                    decoration:addToMap()
                    decoration:setVisible(visible)
                end
            else
                if (decoration) then
                    if (DEBUG) then
                        print("TownMapOpimization checkDecorationsVisible remove : ", coordX, coordY)
                    end

                    decoration:removeFromMap()
                    -- add by zp 这里前面移除了，但是对象并没有被销毁。
                    if AvalonUtil.isSmallMemoryDevice() then
                        decoration:destroy()
                        self._decorationList[i] = nil;
                    end
                end
            end
        else
            assert(false)
        end
    end
end

-- 删除装饰物
function MapOptimization:removeMapTileDecorations(coordX, coordY)
    -- if (DEBUG) then
        -- printfmt("MapOptimization removeMapTileDecorations: %d,%d", coordX, coordY)
    -- end

    for i, decorationData in pairs(self._decorationDataList) do
        if (decorationData) then
            if (decorationData.x == coordX and decorationData.y == coordY) then
                self._decorationDataList[i] = nil
                local decoration = self._decorationList[i]
                if (decoration) then
                    decoration:destroy()
                    self._decorationList[i] = nil
                else
                    -- assert(false)
                end

                -- if (DEBUG) then
                    -- printfmt("removeMapTileDecorations: %s %d at %d, %d ", decorationData.skin, decorationData.ID, coordX, coordY)
                -- end
            end
        end
    end
end

-- 删除装饰物
function MapOptimization:removeMapTileDecorationsByID(decorationID)
    -- if (DEBUG) then
        -- printfmt("MapOptimization removeMapTileDecorations: %d,%d", coordX, coordY)
    -- end
    -- printfmt("MapOptimization removeMapTileDecorations: %d,%d", decorationID, decorationID)
    for i, decorationData in pairs(self._decorationDataList) do
        if (decorationData) then
            if (decorationData.ID == decorationID) then
                -- self._decorationDataList[i] = nil
                local decoration = self._decorationList[i]
                if (decoration) then
                    decoration:destroy()
                    self._decorationList[i] = nil
                else
                    -- assert(false)
                end
                -- printfmt("removeMapTileDecorations: %s %d ", decorationData.skin, decorationData.ID )
                -- if (DEBUG) then
                    -- printfmt("removeMapTileDecorations: %s %d at %d, %d ", decorationData.skin, decorationData.ID, coordX, coordY)
                -- end
            end
        end
    end
end

-- 创建一个地块的地形对象
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function MapOptimization:createMapTileTerrain(coordX, coordY)
    assert(false, "MapOptimization createMapTileTerrain: this method should be overrided.")
    return nil
end

-- 移除一个地块的地形对象
-- @mapTileTerrain 被移除的地块地形
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function MapOptimization:removeMapTileTerrain(mapTileTerrain, coordX, coordY)
   assert(false, "MapOptimization removeMapTileTerrain: this method should be overrided.")
end

-- 更新一个地块的地形对象
function MapOptimization:updateMapTileTerrain(mapTileData, coordX, coordY)
   assert(false, "MapOptimization updateMapTileTerrain: this method should be overrided.")
end

-- 创建一个地块上的装饰物
-- @decorationData 装饰物数据
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function MapOptimization:createMapTileDecoration(decorationData, coordX, coordY)
   assert(false, "MapOptimization createMapTileDecoration: this method should be overrided.")
    return nil
end

-- 创建一个地块上的effectcolors
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function MapOptimization:createMapTileEffectColors(coordX, coordY)
    assert(false, "MapOptimization createMapTileEffectColors: this method should be overrided.")
    return nil
end

-- 移除一个地块上的effectcolors
-- @mapTileEffectColors 装饰物列表
-- @coordX 地块的x坐标
-- @coordY 地块的y坐标
function MapOptimization:removeMapTileEffectColors(mapTileEffectColors, coordX, coordY, clean)
    assert(false, "MapOptimization removeMapTileEffectColors: this method should be overrided.")
end

-- 更新一个地块上的effectcolors
function MapOptimization:updateMapTileEffectColors(mapTileData, coordX, coordY)
end

-- 更新一个地块
function MapOptimization:updateMapTile(mapTileData, coordX, coordY)
    if (mapTileData) then
        -- if (DEBUG) then
        --    printfmt("updateMapTile: %d,%d", coordX, coordY)
        -- end

        local index = self:coordToIndex(coordX, coordY)

        -- 更新地形
        self:updateMapTileTerrain(mapTileData, coordX, coordY)

        -- 删除旧的装饰物
        self:removeMapTileDecorations(coordX, coordY)
        -- 添加新的装饰物数据
        self:addMapTileDecorationDatas(mapTileData)

        -- 删除旧的effectcolor
        local effectColors = self._tileEffectColorsMap[index]
        if (effectColors) then
            self:removeMapTileEffectColors(effectColors, coordX, coordY, true)
            self._tileEffectColorsMap[index] = nil
        end
        -- 添加新的effectcolor
        -- self:createMapTileEffectColors(coordX, coordY)
    end
end

return MapOptimization