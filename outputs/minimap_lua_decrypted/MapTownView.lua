--[[
    显示地图,
    显示城镇的大地图
]]

require "app.ui.Component"
require "app.ui.minimap.MapGrid"
require "app.object.geometric.GeometricModel"
local SceneManager = require("app.game.SceneManager")
local MapDefine = require "app.mapkit.MapDefine"
local ObjectPool = require "utils.ObjectPool"
local DirectionType = Geome.Direction.Type
local MIN_TOUCH_SIZE = cc.size(60, 60)
UI = UI or {}

local MapTownView = class("MapTownView", UI.HWBtnComponent)
UI.MapTownView = MapTownView

-- private:
local DEBUG = false
local DEBUG_DRAW = false
local DEBUG_MAP_GRID = nil

-- 资源
local COM_RES_LIST = {
}

-- 坐标信号动画
local ANIMATION_JSON_SIGNAL = "effect_ui_common_signal.json"
local ANIMATION_ATLAS_SIGNAL = "effect_ui_common_signal.atlas" 

local ANIMATION_JSON_SIGNAL_GENERAL = "effect_ui_general_minimap_signal.json"
local ANIMATION_ATLAS_SIGNAL_GENERAL = "effect_ui_general_minimap_signal.atlas" 

local ANIMATION_NAME_SIGNAL_IDLE = "idle2"
local ANIMATION_NAME_UNLOCK_IDLE = "idle1"

-- 格子尺寸
local MAP_GRID_AXIS_WIDHT = 32 - 1 --  损失精度1 保证地块的重叠
local MAP_GRID_AXIS_HEIGHT = 16 - 0.5 --  损失精度0.5 保证地块的重叠
local MAP_GRID_THICKNESS = 3
local MAP_GRID_SIDE = math.sqrt((MAP_GRID_AXIS_HEIGHT/2)*(MAP_GRID_AXIS_HEIGHT/2) + (MAP_GRID_AXIS_WIDHT/2)*(MAP_GRID_AXIS_WIDHT/2))
local MAP_GRID_WIDTH = MAP_GRID_SIDE
local MAP_GRID_HEIGHT = MAP_GRID_SIDE
-- 变换参数
local MAP_GRID_TRANFORM_RADIAN = math.atan(MAP_GRID_AXIS_HEIGHT / MAP_GRID_AXIS_WIDHT)
local MAP_GRID_TRANFORM_COS_VALUE = math.cos(MAP_GRID_TRANFORM_RADIAN)
local MAP_GRID_TRANFORM_SIN_VALUE = math.sin(MAP_GRID_TRANFORM_RADIAN)
-- 矩阵
local MAP_GRID_TRANSFORM_MAT4 = {
    MAP_GRID_TRANFORM_COS_VALUE, MAP_GRID_TRANFORM_SIN_VALUE, 0, 0,
    -1 * MAP_GRID_TRANFORM_COS_VALUE, MAP_GRID_TRANFORM_SIN_VALUE, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
}
-- 地图格子上sprite的类型
local MAP_GRID_SPRITE_TYPE = UI.MapGrid.SPRITE_TYPE




----------------------------------------------------------
-- 对象池
local SPRITE_POOL_ALL = {}
local SPRITE_POOL_COUNT = 0
local SPRITE_POOL = {}
local SPRITE_POOL_SIZE = 0
-- 获取一个对象
local function getSpriteFromPool()
    if (SPRITE_POOL_SIZE == 0) then
        for i = 1, 100 do 
            local sprite = UI.Image:create()
            sprite:init("minimap-small-00.png")
            sprite:retain()

            SPRITE_POOL_SIZE = SPRITE_POOL_SIZE + 1
            SPRITE_POOL[SPRITE_POOL_SIZE] = sprite

            SPRITE_POOL_COUNT = SPRITE_POOL_COUNT + 1
            SPRITE_POOL_ALL[SPRITE_POOL_COUNT] = sprite
        end
    end
    local sprite = SPRITE_POOL[SPRITE_POOL_SIZE]
    SPRITE_POOL_SIZE = SPRITE_POOL_SIZE - 1
    return sprite
end
-- 返还一个对象
local function returnSpriteToPool(sprite)
    if (sprite) then
        SPRITE_POOL_SIZE = SPRITE_POOL_SIZE + 1
        SPRITE_POOL[SPRITE_POOL_SIZE] = sprite
    end
end
-- 销毁目前对象池中的对象
local function destroySpritePool()
    for i = 1, SPRITE_POOL_SIZE do
        SPRITE_POOL[i] = nil
    end
    for i = 1, SPRITE_POOL_COUNT do
        local sprite = SPRITE_POOL_ALL[i]
        sprite:release()

        SPRITE_POOL_ALL[i] = nil
    end

    SPRITE_POOL_SIZE = 0
    SPRITE_POOL_COUNT = 0
end
----------------------------------------------------------


----------------------------------------------------------
-- 删除格子的sprite
local function removeSprite(self, mapGrid, spriteType)
    local sprite = mapGrid:getSprite(spriteType)
    if (not tolua.isnull(sprite)) then
        if (sprite:getParent() ~= nil) then
            sprite:removeFromParent()
        end
        local texture = cc.Texture2D:new()
        if (not tolua.isnull(sprite)) then
            sprite:setTexture(texture)
            -- add yueyingsong 一定要清理掉
            sprite.__frameName = nil;
            -- returnSpriteToPool(sprite)
            self._mapGridSpritePool:returnObject(sprite)
        end
        
        mapGrid:setSprite(spriteType, nil)
    end

    local spineIcon = mapGrid.spineIcon
    if spriteType == 2 and spineIcon and not tolua.isnull(spineIcon) then
        if (spineIcon:getParent() ~= nil) then
            spineIcon:removeFromParent()
        end
        
        mapGrid.spineIcon = nil
    end
end
-- 更新格子的sprite
local function updateSprite(self, mapGrid, spriteType)
    -- 如果采用渲染格子纹理的机制，不创建sprite
    if (self._renderMapGridTexture and spriteType == MAP_GRID_SPRITE_TYPE.GRID) then return end

    local isVisible = mapGrid:isVisible()
    local spriteName = mapGrid:getSpriteName(spriteType)

    
    local coordX, coordY = mapGrid:getCoord()
    if (isVisible and spriteName) then
        local sprite = mapGrid:getSprite(spriteType)
        if (not sprite) then
            sprite = self._mapGridSpritePool:getObject()
            if(SceneManager:getInstance():isGuild()
                or SceneManager:getInstance():isHome()
                or SceneManager:getInstance():isManor()
                or SceneManager:getInstance():isPort()) then 
                sprite:setScale(0.58)
            end
            mapGrid:setSprite(spriteType, sprite)
            -- @yueyingsong 从对象池拿出来的 可能是未显示的
            -- 人物头像也是用的这个对象。在判断到纹理不在的时候会隐藏掉它
            -- 这样就会导致再次复用的时候是隐藏状态
            sprite:setVisible(true)
        end


        if mapGrid.spineIcon ~= nil then
            if (not tolua.isnull(mapGrid.spineIcon)) then
                mapGrid.spineIcon:removeFromParent()
            end
            mapGrid.spineIcon = nil
        end

        mapGrid:updateSprite(spriteType)

        if (sprite:getParent() == nil) then
            if (spriteType == MAP_GRID_SPRITE_TYPE.GRID) then
                self._mapGridsNode:addChild(sprite)
            elseif (spriteType == MAP_GRID_SPRITE_TYPE.ELEMENT) then

            else
                self._mapElementsNode:addChild(sprite)
            end
        end

        if mapGrid._elementSpriteName ~= nil then
            if string.find(mapGrid._elementSpriteName,".png") == nil and mapGrid.spineIcon ~= nil and mapGrid.spineIcon:getParent() == nil then
                -- print("########",mapGrid:hasShowIcon())
                if mapGrid:hasShowIcon() then
                    self._mapSpinesNode:addChild(mapGrid.spineIcon)
                end
            end

        end
    else
        removeSprite(self, mapGrid, spriteType)
    end
end
-- 更新格子的sprite
local function updateMapGridSprite(self, mapGrid)
    if (mapGrid) then
        updateSprite(self, mapGrid, MAP_GRID_SPRITE_TYPE.GRID)
        updateSprite(self, mapGrid, MAP_GRID_SPRITE_TYPE.ELEMENT)
        updateSprite(self, mapGrid, MAP_GRID_SPRITE_TYPE.HERO)
    end
end
----------------------------------------------------------


----------------------------------------------------------
-- 直线方程
local function line(self, x1, y1, x2, y2)
    local a = y2 - y1
    local b = x1 - x2
    local c = x2 * y1 - x1 * y2
    return a, b, c
end
-- 计算可视范围坚持需要的数据
local function computeVisibleRangeParamters(self)
    -- local width = self._visibleRangeWidthForPerformance
    -- local height = self._visibleRangeHeightForPerformance
    -- local cx = self._centerCoordX
    -- local cy = self._centerCoordY

    -- self._minCoordX = cx - width - height
    -- self._maxCoordX = cx + width + height
    -- self._minCoordY = cy - width - height
    -- self._maxCoordY = cy + width + height

    -- local lbx = cx - width - height
    -- local lby = cy + width - height
    -- local ltx = cx - width + height
    -- local lty = cy + width + height
    -- local rbx = cx + width - height
    -- local rby = cy - width - height
    -- local rtx = cx + width + height
    -- local rty = cy - width + height
    -- self._a1, self._b1, self._c1 = line(self, lbx, lby, ltx, lty)
    -- self._a2, self._b2, self._c2 = line(self, ltx, lty, rtx, rty)
    -- self._a3, self._b3, self._c3 = line(self, rtx, rty, rbx, rby)
    -- self._a4, self._b4, self._c4 = line(self, rbx, rby, lbx, lby)

    -- if (DEBUG) then
    --     print(string.format("MapTownView computeVisibleRangeParamters: min coord:(%f,%f) max coord:(%f,%f).", self._minCoordX, self._minCoordY, self._maxCoordX, self._maxCoordY))
    --     print(string.format("MapTownView computeVisibleRangeParamters: line1:(%f,%f,%f) line2:(%f,%f,%f) line3:(%f,%f,%f) line4:(%f,%f,%f).",
    --         self._a1, self._b1, self._c1,
    --         self._a2, self._b2, self._c2,
    --         self._a3, self._b3, self._c3,
    --         self._a4, self._b4, self._c4
    --     ))
    -- end
end
-- 是否在显示范围内
local function isInVisibleRange(self, coordX, coordY)
    return true
end
----------------------------------------------------------


----------------------------------------------------------
-- 检查格子的可见性
local function checkMapGridVisible(self, mapGrid)
    return

    -- if (not mapGrid) then return end

    -- local coordX, coordY = mapGrid:getCoord()
    -- local visible = false
    -- -- 是否有战争迷雾
    -- if (not self._hasFog) then 
    --     mapGrid:setOpacity(1.0)
    --     visible = true
    -- else 
    --     -- 是否到达过
    --     local isReached = mapGrid:isReached()
    --     -- 是否被探索过
    --     local isExplored = mapGrid:isExplored()

    --     -- 是否显示
    --     local isShowIcon = mapGrid:hasShowIcon()

    --     if (isReached or isShowIcon) then 
    --         mapGrid:setOpacity(1.0)
    --     end
        
    --     visible = false or isReached or isExplored or isShowIcon
    --     -- print("checkMapGridVisible",coordX, coordY,isReached , isExplored , isShowIcon,visible)
    -- end

    -- -- 是否在性能优化的可视范围内
    -- if (visible and self._enableVisibleRangeForPerformance) then
    --     visible = isInVisibleRange(self, coordX, coordY)
    -- end

    -- if (DEBUG) then 
    --     print(string.format("MapTownView checkMapGridVisible: map grid %f %f, visible %s.", coordX, coordY, visible))
    -- end

    -- if (visible) then
    --     mapGrid:show()
    -- else
    --     mapGrid:hide()
    -- end

    -- updateMapGridSprite(self, mapGrid)
end 
-- 显示格子
local function showMapGrid(self, coordX, coordY)
    if (DEBUG) then
        print(string.format("MapTownView showMapGrid: map grid coord %f %f.", coordX, coordY))
    end

    local mapGrid = self:getMapGrid(coordX, coordY)
    if (mapGrid) then
        -- @yueyingsong 已经明确需要显示的,不明白为何还要再次做判断。先暂时关闭判断。可能会引起其他问题
        mapGrid:show()
        updateMapGridSprite(self, mapGrid)
    else
        if (DEBUG) then
            print(string.format("MapTownView showMapGrid: no map grid found at coord %f %f.", coordX, coordY))
        end
    end
end
-- 隐藏格子
local function hideMapGrid(self, coordX, coordY)
    -- if (DEBUG) then
    --     print(string.format("MapTownView hideMapGrid: map grid coord %f %f.", coordX, coordY))
    -- end

    -- local mapGrid = self:getMapGrid(coordX, coordY)
    -- if (mapGrid) then
    --     mapGrid:hide()

    --     updateMapGridSprite(self, mapGrid)
    -- else
    --     if (DEBUG) then
    --         print(string.format("MapTownView hideMapGrid: no map grid found at coord %f %f.", coordX, coordY))
    --     end
    -- end
end
----------------------------------------------------------

----------------------------------------------------------

local function updateVisibleRange(self, coordX, coordY)
    local visibleRange = self._visibleRange
    for i = 1, visibleRange do
        for j = 1, visibleRange - i + 1 do
            -- 可视范围内的格子坐标
            local _relativeCoordX = j - 1
            local _relativeCoordY = i - 1
            local mapGrid1 = self:getMapGrid(coordX + _relativeCoordX, coordY + _relativeCoordY)
            -- 左对称的格子
            local mapGrid2 = nil
            local _relativeCoordX1 = -1 * _relativeCoordX
            if (_relativeCoordX1 < 0) then
                mapGrid2 = self:getMapGrid(coordX + _relativeCoordX1, coordY + _relativeCoordY)
            end
            -- 左下对称的格子
            local mapGrid3 = nil
            local _relativeCoordX2 = -1 * _relativeCoordX
            local _relativeCoordY2 = -1 * _relativeCoordY
            if (_relativeCoordX2 < 0 and _relativeCoordY2 < 0) then
                mapGrid3 = self:getMapGrid(coordX + _relativeCoordX2, coordY + _relativeCoordY2)
            end
            -- 下对称的格子
            local mapGrid4 = nil
            local _relativeCoordY3 = -1 * _relativeCoordY
            if (_relativeCoordY3 < 0) then
                mapGrid4 = self:getMapGrid(coordX + _relativeCoordX, coordY + _relativeCoordY3)
            end

            local opacity = 0.0
            if (i + j == visibleRange) then opacity = 0.75
            elseif (i + j == visibleRange + 1) then opacity = 0.5
            else opacity = 1.0
            end
        end
    end
end
----------------------------------------------------------


----------------------------------------------------------
-- 根据格子坐标计算位置（格子的中心点）
local function computeMapGridPosition(self, coordX, coordY)
    local hw = MAP_GRID_WIDTH / 2
    local hh = MAP_GRID_HEIGHT / 2
    return coordX * MAP_GRID_WIDTH + hw, coordY * MAP_GRID_HEIGHT + hh
end
-- 对格子坐标进行变换
local function transformMapGrid(self, posX, posY)
    if (self._isPerspective) then
        --[[
        local mat = cc.mat4.new(MAP_GRID_TRANSFORM_MAT4)
        local point = {x = 0, y = 0}
        point = mat4_transformVector(mat, {
            x = posX, y = posY
        }, point)
        return point.x, point.y
        ]]--

        local viewPosX = (posX - posY) * MAP_GRID_TRANFORM_COS_VALUE
        local viewPosY = (posX + posY) * MAP_GRID_TRANFORM_SIN_VALUE
        return viewPosX, viewPosY
    else
        return posX, posY
    end
end
----------------------------------------------------------


----------------------------------------------------------
-- 检测四周是否有墙
local function checkGround(self, coordX, coordY)
    local tileDataMap = self._mapData:getTileDataMap()
    local mapTileData = nil
    if (tileDataMap[coordY+1]) then
        mapTileData = tileDataMap[coordY+1][coordX+1]
    end
    if (mapTileData) then
        if mapTileData:getTerrainType() == MapDefine.TerrainType.Ground then
            for k,v in pairs(mapTileData:getDecorationDatas()) do
                if (v:isReachable() == false) then
                    return false
                end
            end

            for k,v in pairs(mapTileData:getPlaceholderDatas()) do
                if (v:isReachable() == false) then
                    return false
                end
            end

            return true
        else
            return false
        end
    end
    return false
end
local function checkWallAround(self, coordX, coordY)
    local tileDataMap = self._mapData:getTileDataMap()

    local up, right, bottom, left = false, false, false, false
    -- 上方的地块
    local upCoordY = coordY + 1
    up = checkGround(self, coordX, upCoordY)
    -- 右方的地块
    local rightCoordX = coordX + 1
    right = checkGround(self, rightCoordX, coordY)
    -- 下方的地块
    local bottomCoordY = coordY - 1
    bottom = checkGround(self, coordX, bottomCoordY)
    -- 左方的地块
    local leftCoordX = coordX - 1
    left = checkGround(self, leftCoordX, coordY)
    return up, right, bottom, left
end
----------------------------------------------------------

-- 离线绘制地块
local function renderMapGridTexture(self)
     local imageName = nil
    if(SceneManager:getInstance():isInTown()) then 
        imageName = "ui_minimap_town_map"
    elseif(SceneManager:getInstance():isGuild()) then 
        imageName = "ui_minimap_guild_map"
    elseif(SceneManager:getInstance():isHome()) then 
        imageName = "ui_minimap_home_map"
    elseif (SceneManager:getInstance():isManor()) then
        imageName = "ui_minimap_house_map"
    elseif (SceneManager:getInstance():isPort()) then
        imageName = "ui_minimap_port_map"
    end
    if(imageName) then
        local mySprite = cc.Sprite:createWithSpriteFrameName(imageName..".png")
        mySprite:setAnchorPoint(0.5, 0.5)
        mySprite:setPosition(self._hw, self._hh)
        self._mapGridSpriteNode:addChild(mySprite)

        self._mySprite = mySprite
        mySprite:setVisible(false)
    end
end

----------------------------------------------------------
-- 创建地图格子
local function createMapGrid(self, coordX, coordY, mapGridData)
    local mapGrid = self:getMapGrid(coordX, coordY)
    if (not mapGrid) then
        -- 计算z序
        local totalCount = self._mapWidth * self._mapHeight
        local index = coordY * self._mapWidth + coordX
        local zorder = totalCount - index
        -- 计算坐标
        -- @wujun
        local posX, posY = computeMapGridPosition(self, coordX, coordY)
        posX, posY = transformMapGrid(self, posX, posY)

        -- 创建格子对象
        mapGrid = UI.MapGrid:create()
        mapGrid:init(mapGridData, coordX, coordY)
        mapGrid:setIndex(index)
        mapGrid:setPos(posX, posY)
        mapGrid:setZOrder(zorder)
        local up, right, bottom, left = checkWallAround(self, coordX, coordY)
        mapGrid:setWallAround(up, right, bottom, left)
        mapGrid:showTeammate(self._showTeammate)
        mapGrid:update()


        local roleDataList = mapGridData:getRoleDatas()
        if (roleDataList) then
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                local spriteID = roleData:getSpriteID()
                -- self._roleGridMap[spriteID] = mapGrid
                local category = roleData:getCategory()
                local type = roleData:getType()
                if (category == Category.ROLE and type == RoleType.Hero) then
                    -- print("createMapGrid self._roleGridMap[spriteID]",spriteID)
                    self._roleGridMap[spriteID] = mapGrid
                -- elseif category == Category.TRIGGER_NPC then
                --     self._NPCGridMap[spriteID] = mapGrid
                end
            end
        end
        self._mapGridList[index] = mapGrid

        if (DEBUG) then
            print(string.format("MapTownView createMapGrid: min pos:(%f,%f) max pos:(%f,%f) grid pos:(%f,%f).",
                self._minViewPosX, self._minViewPosY, self._maxViewPosX, self._maxViewPosY, posX, posY));
        end

        -- 更新坐标格子的坐标范围
        if (posX < self._minViewPosX) then self._minViewPosX = posX end
        if (posX > self._maxViewPosX) then self._maxViewPosX = posX end
        if (posY < self._minViewPosY) then self._minViewPosY = posY end
        if (posY > self._maxViewPosY) then self._maxViewPosY = posY end

        if (not self._hasFog) then
            mapGrid:show()
            mapGrid:setOpacity(1.0)
            updateMapGridSprite(self, mapGrid)
        end
    else
        assert(false)
    end
    return mapGrid
end
-- 更新地图格子 
local function updateMapGrid(self, coordX, coordY)
    local mapGrid = self:getMapGrid(coordX, coordY)
    if (mapGrid) then 
        local up, right, bottom, left = checkWallAround(self, coordX, coordY)
        mapGrid:setWallAround(up, right, bottom, left)
        mapGrid:update()

        updateMapGridSprite(self, mapGrid)
    end
end
----------------------------------------------------------


----------------------------------------------------------
-- 更新地图的尺寸和坐标
local function updateMapGridsNode(self)
    -- 计算地图尺寸
    local width, height = 0, 0
    local minPosX, minPosY = 0, 0
    local maxPosX, maxPosY = 0, 0
    minPosX = self._minViewPosX - MAP_GRID_WIDTH
    maxPosX = self._maxViewPosX + MAP_GRID_WIDTH
    minPosY = self._minViewPosY - MAP_GRID_HEIGHT
    maxPosY = self._maxViewPosY + MAP_GRID_HEIGHT
    if (maxPosX >= minPosX) then width = maxPosX - minPosX end
    if (maxPosY >= minPosY) then height = maxPosY - minPosY end
    self:setSize(width, height)

    if (DEBUG) then
        print(string.format("MapTownView updateMapGridsNode: min pos:(%f,%f) max pos:(%f,%f) size:(%f,%f).",
                self._minViewPosX, self._minViewPosY, self._maxViewPosX, self._maxViewPosY, width, height));
    end

    -- 修正地图格子的显示位置
    if (self._isPerspective) then
        self._mapGridsNode:setPosition(-1 * minPosX, -1 * minPosY)

        print("updateMapGridsNode",self._renderMapGridTexture,self._visibleRange)
        if self._renderMapGridTexture then
            self._mapElementsNode:setPosition(-1 * minPosX + 175, -1 * minPosY - 56)
            -- 由于公会地图有位置改变，这里专门调整的一下显示逻辑。
            if(SceneManager:getInstance():isGuild()) then 
                self._mapElementsNode:setPosition(-1 * minPosX + 175 + 21, -1 * minPosY - 56 - 60)
            elseif SceneManager:getInstance():isHome() then 
                self._mapElementsNode:setPosition(-1 * minPosX + 175, -1 * minPosY - 56)
            elseif SceneManager:getInstance():isManor() then
                self._mapElementsNode:setPosition(-1 * minPosX + 175 + 21, -1 * minPosY - 56 - 60)
            elseif SceneManager:getInstance():isPort() then
                self._mapElementsNode:setPosition(-1 * minPosX + 175 + 21, -1 * minPosY - 56 - 60)
            end
        else
            self._mapElementsNode:setPosition(-1 * minPosX, -1 * minPosY)
        end
    end
end
-- 从地图数据中提取信息
local function extractMapData(self)
    if (self._mapData) then
        local tileDataMap = self._mapData:getTileDataMap()
        local mapWidth, mapHeight = self._mapData:getSize()

        -- 获取地图尺寸信息
        self._mapWidth = mapWidth
        self._mapHeight = mapHeight

        -- 获取英雄信息
        for j = 1, mapHeight do
            for i = 1, mapWidth do
                local coordX, coordY = i - 1, j - 1

                local mapTileData = tileDataMap[j][i]
                if (mapTileData) then
                    local roleDataList = mapTileData:getRoleDatas()
                    if (roleDataList) then
                        for i = 1, #roleDataList do
                            local roleData = roleDataList[i]
                            if (roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Hero) then
                                if (roleData:isMasterHero()) then
                                    self._centerCoordX = coordX 
                                    self._centerCoordY = coordY
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
-- 清理旧的地图格子
local function clearMapGrids(self)
    table.clear(self._mapGridList)
    table.clear(self._roleGridMap)
    table.clear(self._heroGridMap)

    self._minViewPosX = 0xFFFFFFFF
    self._maxViewPosX = 0
    self._minViewPosY = 0xFFFFFFFF
    self._maxViewPosY = 0

    self._mapGridSpriteNode:removeAllChildren()
    self._mapGridsNode:removeAllChildren()
end

local function createOneIcon(self, triggerNpcData)
    -- 生成所有的功能图标
    local sprite = cc.Sprite:create()
    sprite:retain()
    local roleSpriteName, elementSpriteName, hasRole, hasElement = UI.MapGrid:getIconName(triggerNpcData, true)
    if(elementSpriteName) then
        sprite:setSpriteFrame(elementSpriteName)
    end
    sprite.triggerNpcData = triggerNpcData

    -- 点击开始
    local function onTouchBegan(touch, event)
        if (not sprite:isVisible()) then return false end
        
        local touchPosition = touch:getLocation()
        local localPosition = sprite:convertToNodeSpace(touchPosition)

        local rect = nil
        local touchSize = cc.size(sprite:getContentSize().width, sprite:getContentSize().height)
        local startPos = cc.p(0, 0)
        if self._enableMinTouchSize then
            if touchSize.width < MIN_TOUCH_SIZE.width then
                startPos.x = (touchSize.width - MIN_TOUCH_SIZE.width) / 2
                touchSize.width = MIN_TOUCH_SIZE.width
            end

            if touchSize.height < MIN_TOUCH_SIZE.height then
                startPos.y = (touchSize.height - MIN_TOUCH_SIZE.height) / 2
                touchSize.height = MIN_TOUCH_SIZE.height
            end
        end
        rect = cc.rect(startPos.x, startPos.y, touchSize.width, touchSize.height)

        local check = cc.rectContainsPoint(rect, localPosition)
        return check
    end
    -- 点击移动
    local function onTouchMoved(touch, event)

    end
    -- 点击结束
    local function onTouchEnded(touch, event)
        local touchPosition = touch:getLocation()
        -- 发送点击组件外侧的事件
        if (self._enableDrag and self:isEventRegisterd(UIEvent.COMPONENT_DRAG_ENDED)) then

        else
            local touchCheck = self:checkTouch(touch)

            -- if (touchCheck) then
                -- 发送点击组件的事件
                -- print("MapTownView  is click")
                Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                    local MachineManager = require("app.game.MachineManager")
                    local machine = MachineManager:getInstance():getMachine()
                    if(machine) then
                        machine:_pushOpenTriggerNpcCommand(triggerNpcData, true)
                    end

                    Avalon.AudioManager:playSound(self.clickAudioID)
                end, 0.01)
            -- end
        end
    end

    -- 注册点击监听事件
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_CANCELLED)
    listener:setSwallowTouches(true)
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    -- local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, sprite)

    -- @yueyingsong 从对象池拿出来的 可能是未显示的
    -- 人物头像也是用的这个对象。在判断到纹理不在的时候会隐藏掉它
    -- 这样就会导致再次复用的时候是隐藏状态
    sprite:setVisible(true)

    return sprite
end

-- 创建所有的地图格子
local function createMapGrids(self)
    if (self._mapData) then
        local tileDataMap = self._mapData:getTileDataMap()
        local mapWidth, mapHeight = self._mapData:getSize()
        -- 创建新的格子
        for j = 1, mapHeight do
            for i = 1, mapWidth do
                local coordX, coordY = i - 1, j - 1
                local mapGridData = tileDataMap[j][i]
                if (mapGridData) then
                    createMapGrid(self, coordX, coordY, mapGridData)
                end
            end
        end

        -- 添加了自己设定的NPC
        for k, triggerNpcData in ipairs(self.functionNpcDataArr) do 
            if (triggerNpcData) then
                local roleData = triggerNpcData
                local coord = {}
                coord.x = roleData.iconMap.position[1]
                coord.y = roleData.iconMap.position[2]
                local mapGrid = self:getMapGrid(coord.x, coord.y)
                -- local coord = roleData:getCoord()
                -- local mapGrid = self:getMapGrid(coord.x, coord.y)
                if (mapGrid) then
                    local sprite = createOneIcon(self, roleData)
                    if(sprite) then
                        self._mapElementsNode:addChild(sprite)
                        -- local roleSpriteName, elementSpriteName, hasRole, hasElement = UI.MapGrid:getIconName(roleData, true)
                        -- sprite:setSpriteFrame(elementSpriteName)
                        mapGrid._elementSpriteName = nil
                        if(SceneManager:getInstance():isGuild()
                            or SceneManager:getInstance():isHome()
                            or SceneManager:getInstance():isManor()
                            or SceneManager:getInstance():isPort()) then 
                            sprite:setScale(0.58)
                        end

                        mapGrid:setSprite(UI.MapGrid.SPRITE_TYPE.ELEMENT_FUNCTION, sprite)
                        mapGrid:updateSprite(UI.MapGrid.SPRITE_TYPE.ELEMENT_FUNCTION)
                        local spriteID = roleData:getSpriteID()
                        -- self._roleGridMap[spriteID] = mapGrid
                        local category = roleData:getCategory()
                        local type = roleData:getType()
                        if category == Category.TRIGGER_NPC then
                            self._NPCGridMap[spriteID] = mapGrid
                        end
                    end
                end
            end
        end

        -- 更新整个地图节点
        updateMapGridsNode(self)
    end
end
----------------------------------------------------------


----------------------------------------------------------
local function setMapGridOpacity(self, mapGrid, opacity)
    if (mapGrid) then
        -- if (mapGrid:isExplored()) then
        --     local currentOpacity = mapGrid:getOpacity()
        --     if (opacity >= currentOpacity) then
        --         mapGrid:setOpacity(opacity)
        --     end
        -- else    
        --     mapGrid:setOpacity(opacity)
        --     mapGrid:explore()
        -- end

        local currentOpacity = mapGrid:getOpacity()
        if (opacity >= currentOpacity) then
            mapGrid:setOpacity(opacity)
        end
        
        mapGrid:explore()
        if currentOpacity ~= 1 then
            mapGrid:show()
            updateMapGridSprite(self, mapGrid)
        end
    end
end
local function exploreMapGridsLayer(self, coordX, coordY, distance, direction, opacity)
    local visibleRange = self._visibleRange
    local mapGrid = nil

    if (direction == DirectionType.NORTH or 
        direction == DirectionType.SOUTH) then
        local symbol = (direction == DirectionType.NORTH) and (1) or (-1)
        
        for i = 1, distance - 1 do
            local coordX_1 = coordX - distance + i
            local coordY_1 = coordY + symbol * (i - 1)
            mapGrid = self:getMapGrid(coordX_1, coordY_1)
            setMapGridOpacity(self, mapGrid, opacity)

            local coordX_2 = coordX + distance - i 
            local coordY_2 = coordY_1
            mapGrid = self:getMapGrid(coordX_2, coordY_2)
            setMapGridOpacity(self, mapGrid, opacity)

            -- print("exploreMapGridsLayer1 ", coordX_1, coordY_1, coordX_2, coordY_2)
        end   

        local coordX_3 = coordX
        local coordY_3 = coordY + symbol * (distance - 1)
        mapGrid = self:getMapGrid(coordX_3, coordY_3)
        setMapGridOpacity(self, mapGrid, opacity)
        -- print("exploreMapGridsLayer1 ", coordX_3, coordY_3)
    else
        local symbol = (direction == DirectionType.EAST) and (1) or (-1)

        for i = 1, distance - 1 do
            local coordX_1 = coordX + symbol * (i - 1)
            local coordY_1 = coordY - distance + i
            mapGrid = self:getMapGrid(coordX_1, coordY_1)
            setMapGridOpacity(self, mapGrid, opacity)

            local coordX_2 = coordX_1
            local coordY_2 = coordY + distance - i
            mapGrid = self:getMapGrid(coordX_2, coordY_2)
            setMapGridOpacity(self, mapGrid, opacity)
            -- print("exploreMapGridsLayer2 ", coordX_1, coordY_1, coordX_2, coordY_2)
        end  

        local coordX_3 = coordX + symbol * (distance - 1)
        local coordY_3 = coordY
        mapGrid = self:getMapGrid(coordX_3, coordY_3)
        setMapGridOpacity(self, mapGrid, opacity)
        -- print("exploreMapGridsLayer2 ", coordX_3, coordY_3)
    end
end
-- 探索新的地块
local function exploreMapGrids(self, coordX, coordY, direction)
    -- print("exploreMapGrids ", coordX, coordY, direction, self._visibleRange)

    local visibleRange = self._visibleRange
    exploreMapGridsLayer(self, coordX, coordY, visibleRange, direction, 0.3)
    exploreMapGridsLayer(self, coordX, coordY, visibleRange - 1, direction, 0.5)
    exploreMapGridsLayer(self, coordX, coordY, visibleRange - 2, direction, 1.0)
end
-- 移动角色
local function moveRole(self, coord, isMaster, spriteID, direction)
    if (coord) then
        -- 更新中心坐标
        if (isMaster) then
            self._lastCenterCoordX = self._centerCoordX
            self._lastCenterCoordY = self._centerCoordY
            self._centerCoordX = coord.x
            self._centerCoordY = coord.y
        end

        local coordX = math.floor(coord.x)
        local coordY = math.floor(coord.y)
        -- 只有移动了整个格子才更新
        -- print("moveRole@@@@@@@@@@@",coordX,coordY)
        if (coordX == coord.x and coordY == coord.y) then
            local mapGrid = self:getMapGrid(coordX, coordY)
            local lastMapGrid = nil
            if (mapGrid) then
                -- 更新当前格子
                mapGrid:update()
                -- 更新上一个格子
                local roleDataList = mapGrid:getRoleDataList()
                if (roleDataList) then
                    for i = 1, #roleDataList do
                        local roleData = roleDataList[i]
                        local roleSpriteID = roleData:getSpriteID()

                        if (spriteID == roleSpriteID) then
                            lastMapGrid = self._roleGridMap[spriteID]
                            if (lastMapGrid) then
                                lastMapGrid:update()
                            end
                            -- print("moveRole self._roleGridMap[spriteID]",spriteID)
                            self._roleGridMap[spriteID] = mapGrid
                            
                            break
                        end
                    end
                end

                updateMapGridSprite(self, mapGrid)
                updateMapGridSprite(self, lastMapGrid)

                -- 是否以角色为中心进行显示小地图
                if (isMaster and self._isCenterByMaster) then 
                    self:setCenterCoord(coordX, coordY)
                end
                -- 如果有战争迷雾，更新视野范围
                if (self._hasFog) then
                    if (direction == nil) then
                        self:updateVisibleRange(coordX, coordY)
                    else
                        exploreMapGrids(self, coordX, coordY, direction)
                    end
                end
                -- 更新信号位置
                local animation = self._animationMap[spriteID]
                if (animation) then
                    local coordX, coordY = mapGrid:getCoord()
                    local posX, posY = self:getRelativePosition(coordX, coordY)
                    animation:leftBottom(posX, posY)
                end
            else
                -- assert(false, string.format("MapTownView moveRole: invalid coord (%f,%f).", coord.x, coord.y))
            end
        else
        
        end
    else
        -- assert(false)
    end
end
----------------------------------------------------------


----------------------------------------------------------
-- 角色移动完格子的处理器
local function onRoleMoveHandler(self, coord, isMaster, spriteID, direction)
    -- 移动角色
    moveRole(self, coord, isMaster, spriteID, direction)

    self:dispatchEvent(UIEvent.MINI_MAP_ROLE_POSITION_CHANGED, coord, isMaster, spriteID)
end
-- 角色idle的处理器
local function onRoleIDLEHandler(self, coord, isMaster, spriteID)
    -- 移动角色
    moveRole(self, coord, isMaster, spriteID)

    self:dispatchEvent(UIEvent.MINI_MAP_ROLE_POSITION_CHANGED, coord, isMaster, spriteID)
end
-- 添加游戏模型
local function onAddModelHandler(self, modelData)
    if (modelData) then
        local category = modelData:getCategory()
        local type = modelData:getType()

        if (category == Category.ROLE or category == Category.NPC or category == Category.TRIGGER_NPC) then
            local coord = modelData:getCoord()
            if not coord then
                dump(modelData,"添加错误")
                return
            end
            updateMapGrid(self, coord.x, coord.y)

            if (category == Category.ROLE and type == RoleType.Hero) then 
                local isMaster = modelData:isMasterHero()
                local spriteID = modelData:getSpriteID()           
                local mapGrid = self:getMapGrid(coord.x, coord.y)
                self._roleGridMap[spriteID] = mapGrid

                self:dispatchEvent(UIEvent.MINI_MAP_ROLE_POSITION_CHANGED, coord, isMaster, spriteID)
            end
        else
            assert(false)
        end
    else
        assert(false)
    end
end
-- 移除游戏模型
local function onRemoveModelHandler(self, modelData)
    if (modelData) then
        local category = modelData:getCategory()
        local type = modelData:getType()

        if (category == Category.ROLE or category == Category.NPC or category == Category.TRIGGER_NPC) then
            local coord = modelData:getCoord()
            updateMapGrid(self, coord.x, coord.y)
            if (category == Category.ROLE and type == RoleType.Hero) then
                local mapGrid = self:getMapGrid(coord.x, coord.y)
                for spriteID, roleGrid in pairs(self._roleGridMap) do
                    if (roleGrid == mapGrid) then
                        self._roleGridMap[spriteID] = nil

                        local isMaster = modelData:isMasterHero()
                        self:dispatchEvent(UIEvent.MINI_MAP_ROLE_POSITION_CHANGED, coord, isMaster, spriteID)

                        break
                    end
                end
            end
        else
            assert(false)
        end
    else
        assert(false)
    end
end
-- 触发npc的处理器
local function onOpenNpcHandler(self, npcData)
    if (npcData) then
        local coord = npcData:getCoord()
        updateMapGrid(self, coord.x, coord.y)
    else
        assert(false)
    end
end
-- 更新npc的状态
local function onNPCStatusChangedHandler(self, npcData)
    local type = npcData:getType()
    if (type == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
        local coord = npcData:getCoord()
        updateMapGrid(self, coord.x, coord.y)
    else
        assert(false)
    end
end
-- 更新单个地块的处理器（爆炸）
local function onUpdateMapTileHandler(self, coord)
    if (coord) then
        print(string.format("MapTownView onUpdateMapTileHandler: update coord:(%f,%f).", coord.x, coord.y))

        -- 获取需要更新的地块
        local toUpdateTileDataList = self._mapData:getDirtyTileDatas()
        if (toUpdateTileDataList) then
            for i = 1, #toUpdateTileDataList do
                local tileData = toUpdateTileDataList[i]
                local coordX, coordY = tileData.x, tileData.y

                -- 检测是否需要创建新的格子
                local mapGrid = self:getMapGrid(coordX, coordY)
                if (not mapGrid) then 
                    mapGrid = createMapGrid(self, coordX, coordY, tileData)
                end
            end
        else
            assert(false)
        end
        -- 更新当前格子和周围格子
        local coordX, coordY = coord.x, coord.y
        updateMapGrid(self, coordX, coordY)
        updateMapGrid(self, coordX, coordY + 1)
        updateMapGrid(self, coordX + 1, coordY)
        updateMapGrid(self, coordX, coordY - 1)
        updateMapGrid(self, coordX - 1, coordY)

        -- 更新整个地图节点
        updateMapGridsNode(self)

        if (self._isCenterByMaster) then 
            self:setCenterCoord(self._centerCoordX, self._centerCoordY)
        end
    else
        assert(false)
    end
end
-- 更新整个地图（打开密室）
local function onUpdateMapHandler(self, dirtyMapDataList)
    print("MapTownView onUpdateMapHandler: update map.")

    -- 获取需要更新的地块
    if (dirtyMapDataList) then
        for i = 1, #dirtyMapDataList do
            local tileData = dirtyMapDataList[i]
            local coordX, coordY = tileData.x, tileData.y

            -- 检测是否需要创建新的格子
            local mapGrid = self:getMapGrid(coordX, coordY)
            if (not mapGrid) then mapGrid = createMapGrid(self, coordX, coordY, tileData)
            end
        end
        for i = 1, #dirtyMapDataList do
            local tileData = dirtyMapDataList[i]
            local coordX, coordY = tileData.x, tileData.y

            -- 更新当前格子和周围格子
            updateMapGrid(self, coordX, coordY)
            updateMapGrid(self, coordX, coordY + 1)
            updateMapGrid(self, coordX + 1, coordY)
            updateMapGrid(self, coordX, coordY - 1)
            updateMapGrid(self, coordX - 1, coordY)
        end
    else
        assert(false)
    end
    -- 如果有战争迷雾，更新视野范围
    if (self._hasFog) then
        self:updateVisibleRange(self._centerCoordX, self._centerCoordY)
    end

    -- 更新整个地图节点
    updateMapGridsNode(self)

    if (self._isCenterByMaster) then 
        self:setCenterCoord(self._centerCoordX, self._centerCoordY)
    end
end
-- 处理点击
local function onClickMapViewHandler(self, self, touchPosition)
    local localPosition = self._mapGridsNode:convertToNodeSpace(touchPosition)

    local point = {x = 0, y = 0}
    if (self._isPerspective) then
        -- 将局部坐标进行逆变换
        local mat = cc.mat4.new(MAP_GRID_TRANSFORM_MAT4)
        mat = mat4_getInversed(mat)
        point = mat4_transformVector(mat, {
            x = localPosition.x, y = localPosition.y
        }, point)
    else
        -- 如果没有使用透视，不需要变换
        point.x = localPosition.x
        point.y = localPosition.y
    end
    -- 计算所点击的格子坐标
    local coordX = math.ceil(point.x / MAP_GRID_WIDTH) - 1
    local coordY = math.ceil(point.y / MAP_GRID_HEIGHT) - 1
    local mapGrid = self:getMapGrid(coordX, coordY)

    if (DEBUG) then
        local coord = mapGrid:getCoord()
        local gridCoordX = coord.x 
        local gridCoordY = coord.y
        print(string.format("MapTownView onClickMapViewHandler: click coord (%f,%f), map grid coord (%f,%f).", coordX, coordY, gridCoordX, gridCoordY))
    end
end



----------------------------------------------------------

-- 构造函数
function MapTownView:ctor(mapType, functionNpcDataArr, targetID)
    MapTownView.super.ctor(self, UIType.MAP_VIEW, COM_RES_LIST, 0, 0)

    self._mapType = mapType

    -- 获取地图上面的所有数据
    self.functionNpcDataArr = functionNpcDataArr
    self.targetID = targetID

    -- 地图数据
    self._mapData = nil
    -- 地图尺寸
    self._mapWidth = 0
    self._mapHeight = 0
    -- 可视范围
    self._visibleRange = 0 
    -- 是否适用透视效果
    self._isPerspective = false
    -- 是否打开战争迷雾
    self._hasFog = true
    -- 是否启用以主角为中心
    self._isCenterByMaster = true
    -- 是否是脏数据
    self._isDirty = true

    -- 保存地图的范围数据
    self._minViewPosX = 0xFFFFFFFF
    self._maxViewPosX = 0
    self._minViewPosY = 0xFFFFFFFF
    self._maxViewPosY = 0

    -- 所有格子的列表
    self._mapGridList = {}
    -- 有角色的格子的列表
    self._roleGridMap = {} 
    -- 队友的列表
    self._heroGridMap = {}
    -- NPC的列表
    self._NPCGridMap = {}

    -- 中心坐标
    self._centerCoordX = 0
    self._centerCoordY = 0
    self._lastCenterCoordX = 0
    self._lastCenterCoordY = 0

    -- 地图格子整张纹理的节点
    self._mapGridSpriteNode = nil
    -- 地图格子的节点
    self._mapGridsNode = nil
    -- 地图格子上元素的节点
    self._mapElementsNode = nil
    -- 显示角色信号的节点
    self._signalLayer = nil

    -- 是否渲染整张地图格子的纹理
    self._renderMapGridTexture = false

    -- 是否显示队友
    self._showTeammate = true

    -- 信号动画列表
    self._animationMap = {}

    -- 解锁信号列表
    self._unlockAnimationList = {}

    -- 性能优化（以主角为中心）
    -------------------------------------------------
    self._enableVisibleRangeForPerformance = false -- 启用标志
    self._visibleRangeWidthForPerformance = 0      -- 可视范围宽度（矩形）
    self._visibleRangeHeightForPerformance = 0     -- 可是范围高度（矩形）
    self._minCoordX = 0
    self._maxCoordX = 0
    self._minCoordY = 0
    self._maxCoordY = 0
    self._a1 = 0
    self._b1 = 0
    self._c1 = 0
    self._a2 = 0
    self._b2 = 0
    self._c2 = 0
    self._a3 = 0
    self._b3 = 0
    self._c3 = 0
    self._a4 = 0
    self._b4 = 0
    self._c4 = 0
    -------------------------------------------------

     -- 地块地形对象池
    self._mapGridSpritePool = ObjectPool:create(
        function()
            local sprite = cc.Sprite:create()
            sprite:retain()
            return sprite
        end,
        function(mapGridSprite)
            if (mapGridSprite) then 
                if (mapGridSprite:getParent()) then
                    mapGridSprite:removeFromParent()
                end
                mapGridSprite:release()
            else 
                assert(false)
            end
        end,
        1,
        50
    )

    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_UPDATE_COORD, self, onRoleMoveHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_IDLE, self, onRoleIDLEHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_BATTLE_ADD_GAME_MODEL, self, onAddModelHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_BATTLE_REMOVE_GAME_MODEL, self, onRemoveModelHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_BATTLE_OPEN_NPC, self, onOpenNpcHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_NPC_STATUS_CHANGE, self, onNPCStatusChangedHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_MAP_UPDATE_MAP_TILE, self, onUpdateMapTileHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_MAP_UPDATE_MAP, self, onUpdateMapHandler)
    --触发怪物
    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_TRIGGER_MONSTER, self, self.onTriggerMonster)
    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_CHANGE_TYPE, self, self.onChangeType)

    --显示小地图icon
    Avalon.MessageCenter:bind(GameMessage.MC_UI_MINI_SHOW_ICON, self, self.updateMapGridList)

    --是否能领取大秘境奖励
    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_CAN_RECIVE_SEASON_REWARD, self, self.updateCanReciveSeasonReward)

    --系统解锁
    Avalon.MessageCenter:bind(GameMessage.MC_UI_FUNCTION_UNLOCK, self, self.unLockfunction)
    --系统解锁 移除new动画
    Avalon.MessageCenter:bind(GameMessage.MC_UI_FUNCTION_REMOVE_NEW, self, self.removeUnLockfunction)
end



--是否能领取大秘境奖励,更新视图
function MapTownView:updateCanReciveSeasonReward()
    if SceneManager:getInstance():isInTown() then
        print("MapTownView:updateCanReciveSeasonReward")
        local mapGrid = self:getMapGrid(NPC_TYPE_GUARD_POS_X,NPC_TYPE_GUARD_POS_Y)          --士兵位置
        if(mapGrid) then
            mapGrid:updateMapElement()
            checkMapGridVisible(self,mapGrid)
        else 
            print("MapTownView:updateCanReciveSeasonReward  not found mapGrid x,y=", NPC_TYPE_GUARD_POS_X,NPC_TYPE_GUARD_POS_Y)
        end
    end
end

function MapTownView:updateMapGridList(bShow,data)
    -- print("MapTownView:updateMapGridList",bShow)
    for k,v in pairs(data) do
        local mapGrid = self:getMapGrid(v.x,v.y)
        if(mapGrid) then
            mapGrid:updateMapElement()
            checkMapGridVisible(self,mapGrid)
        else 
            print("MapTownView:updateMapGridList  not found mapGrid x,y=", v.x, v.y)
        end 
    end
end

-- 析构函数
function MapTownView:dtor()
    MapTownView.super.dtor(self) 

    -- 销毁地图格子的对象池
    -- destroySpritePool()
    self._mapGridSpritePool:destroy()

    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_UPDATE_COORD, self, onRoleMoveHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_IDLE, self, onRoleIDLEHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_BATTLE_ADD_GAME_MODEL, self, onAddModelHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_BATTLE_REMOVE_GAME_MODEL, self, onRemoveModelHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_BATTLE_OPEN_NPC, self, onOpenNpcHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_NPC_STATUS_CHANGE, self, onNPCStatusChangedHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_MAP_UPDATE_MAP_TILE, self, onUpdateMapTileHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_MAP_UPDATE_MAP, self, onUpdateMapHandler)

    --触发怪物
    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_TRIGGER_MONSTER, self, self.onTriggerMonster)
    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_CHANGE_TYPE, self, self.onChangeType)

    --显示小地图icon
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_MINI_SHOW_ICON, self, self.updateMapGridList)

    --是否能领取大秘境奖励
    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_CAN_RECIVE_SEASON_REWARD, self, self.updateCanReciveSeasonReward)

    --系统解锁
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_FUNCTION_UNLOCK, self, self.unLockfunction)
    --系统解锁 移除new动画
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_FUNCTION_REMOVE_NEW, self, self.removeUnLockfunction)
end

-- public:
-- 初始化
function MapTownView:init(data, visibleRange)
    self._mapData = data or nil
    self._visibleRange = visibleRange or 0
    local isInTown = SceneManager:getInstance():isInTown()
    --城镇 地图 是固定尺寸的低图  所以格子尺寸也得固定
    if isInTown then
        MAP_GRID_AXIS_WIDHT = 36
        MAP_GRID_AXIS_HEIGHT = 17
    
        MAP_GRID_SIDE = math.sqrt((MAP_GRID_AXIS_HEIGHT/2)*(MAP_GRID_AXIS_HEIGHT/2) + (MAP_GRID_AXIS_WIDHT/2)*(MAP_GRID_AXIS_WIDHT/2))
        MAP_GRID_WIDTH = MAP_GRID_SIDE
        MAP_GRID_HEIGHT = MAP_GRID_SIDE
    else
        MAP_GRID_AXIS_WIDHT = 32 - 1 --  损失精度1 保证地块的重叠
        MAP_GRID_AXIS_HEIGHT = 16 - 0.5 --  损失精度0.5 保证地块的重叠
        MAP_GRID_SIDE = math.sqrt((MAP_GRID_AXIS_HEIGHT/2)*(MAP_GRID_AXIS_HEIGHT/2) + (MAP_GRID_AXIS_WIDHT/2)*(MAP_GRID_AXIS_WIDHT/2))
        MAP_GRID_WIDTH = MAP_GRID_SIDE
        MAP_GRID_HEIGHT = MAP_GRID_SIDE
    end

    MapTownView.super.init(self)
end

-- 初始化视图
function MapTownView:onInitView()
    self._mapGridSpriteNode = cc.Node:create()
    self:addChild(self._mapGridSpriteNode)

    self._mapGridsNode = cc.Node:create()
    self:addChild(self._mapGridsNode)
    self._mapElementsNode = cc.Node:create()
    self:addChild(self._mapElementsNode)

    -- self._mapGridsNode:setScale(1.3)
    -- self._mapElementsNode:setScale(1.3)

    self._signalLayer = cc.Node:create()
    self:addChild(self._signalLayer)

    self._mapSpinesNode = cc.Node:create()
    self:addChild(self._mapSpinesNode)
end

-- 更新视图
function MapTownView:onUpdateView()
    -- print("MapTownView:onUpdateView",self._mapData)
    if (self._mapData) then
        -- 如果地图更新，创建新的格子
        if (self._isDirty) then
            -- 提取地图数据
            extractMapData(self)
            -- 清理地图格子
            clearMapGrids(self)
            -- 创建地图格子
            createMapGrids(self)

            -- @wujun
            if (self._enableVisibleRangeForPerformance) then
                computeVisibleRangeParamters(self)
            end

            self._isDirty = false
        end

        -- 更新格子
        if (self._hasFog) then
            -- print("MapTownView:onUpdateView111111")
            local parentPosX, parentPosY = self._mapGridsNode:getPosition()
            local mapWidth, mapHeight = self._mapWidth, self._mapHeight
            for j = 1, mapHeight do
                for i = 1, mapWidth do
                    local coordX, coordY = i - 1, j - 1
                    local mapGrid = self:getMapGrid(coordX, coordY)
                    if (mapGrid) then
                        -- print("MapTownView:onUpdateView22222")
                        -- 更新格子的可见性
                        checkMapGridVisible(self, mapGrid)

                        -- 更新视野周围的格子透明度
                        local mapTileData = mapGrid:getData()
                        if (mapTileData) then
                            -- print("MapTownView:onUpdateView3333")
                            if (mapTileData:isReached()) then
                                -- print("MapTownView:onUpdateView4444")
                                moveRole(self, {
                                    x = coordX,
                                    y = coordY
                                }, false)
                            end
                        end
                    end
                end
            end
    
            moveRole(self, {x = self._centerCoordX, y = self._centerCoordY}, true)
        else
            if (self._isCenterByMaster) then 
                self:setCenterCoord(self._centerCoordX, self._centerCoordY)
            end
        end
        -- print("self._renderMapGridTexture =", self._renderMapGridTexture)
        if (self._renderMapGridTexture) then
            renderMapGridTexture(self)
        end


        if (self._mapSpinesNode) then
            self._mapSpinesNode:setPosition(self._mapGridsNode:getPosition())
        end

        for k,v in pairs(self._NPCGridMap) do
            -- print(k,v.__cname)
            -- local roleDataList = v._mapGridData:getRoleDatas()
            -- if roleDataList then
            --     for i = 1, #roleDataList do
            --         local roleData = roleDataList[i]
                    local sprite = v:getSprite(UI.MapGrid.SPRITE_TYPE.ELEMENT_FUNCTION)
                    if(sprite) then 
                        local roleData = sprite.triggerNpcData
                        local roleType = roleData:getType()
                        if roleType == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC and roleData.__cname == "TriggerNpcData" then
                            -- print(roleData.__cname)
                            local functionTypeArr = roleData:getFunctionTypeArr()
                            if(#functionTypeArr >=2) then
                                -- TODO 处理有多重功能的触发NPC 处理逻辑 
                                local mainFunction = roleData:getMainFunction()
                                if(mainFunction ~= 0) then
                                    functionTypeArr = {}
                                    table.insert(functionTypeArr,mainFunction)
                                end
                            end
                            if Game.FunctionUnlockManager:getInstance():isShowMiniMapAction(functionTypeArr) then
                                self:showUnLockSignal(k)
                            end
                            break
                        end
                    end

            --     end
            -- end
        end
        -- dump(self._roleGridMap)  
    end

    -- 显示处理表现
    self:showTaskTalkSignal(self.targetID)
end

-- 设置地图数据
function MapTownView:setData(mapData)
    assert(mapData, "MapView setData: map data is invalid.")

    self._mapData = mapData
    self._isDirty = true
end

-- 获取地图格子
local dm = DEVELOPMENT_MODE
function MapTownView:getMapGrid(coordX, coordY)
    -- assert(type(coordX) == "number", "MapView getMapGrid: coordX is invalid.")
    -- assert(type(coordY) == "number", "MapView getMapGrid: coordY is invalid.")

    if (coordX < 0 or coordY < 0 or coordX >= self._mapWidth or coordY >= self._mapHeight) then return nil end

    local index = coordY * self._mapWidth + coordX
    if (index >= 0) then
        local mapGrid = self._mapGridList[index]
        if (mapGrid) then
            return mapGrid
        end
    end
    return nil
end

-- 获取地图格子相对于地图的位置
function MapTownView:getRelativePosition(coordX, coordY)
    assert(type(coordX) == "number", "MapView getMapGrid: coordX is invalid.")
    assert(type(coordY) == "number", "MapView getMapGrid: coordY is invalid.")

    local posX, posY = computeMapGridPosition(self, coordX, coordY)
    posX, posY = transformMapGrid(self, posX, posY)

    local parentPosX, parentPosY = self._mapGridsNode:getPosition()

    if self._renderMapGridTexture then
        return parentPosX + posX + 175  , parentPosY + posY - 56
    else
        return parentPosX + posX, parentPosY + posY
    end
end

-- 设置中心位置
function MapTownView:setCenterCoord(coordX, coordY)
    assert(type(coordX) == "number", string.format("MapView getMapGrid: coordX %d is invalid.", coordX))
    assert(type(coordY) == "number", string.format("MapView getMapGrid: coordY %d is invalid.", coordY))

    -- 将地图视图位置调整到以格子为中心的位置
    local gridPosX, gridPosY = self:getRelativePosition(coordX, coordY)
    local width, height = 0, 0
    if (self:getParent()) then 
        local size = self:getParent():getContentSize()
        width = size.width
        height = size.height
    end

    if(DEBUG) then
        print("MapTownView:setCenterCoord",width,height,gridPosX,gridPosY)
    end

    local mapViewPosX, mapViewPosY = width / 2 - gridPosX, height / 2 - gridPosY
    self:leftBottom(mapViewPosX, mapViewPosY)
    
    local mapGrid = self:getMapGrid(coordX, coordY)
    if (mapGrid) then
        if (DEBUG_DRAW) then
            if (DEBUG_MAP_GRID) then
                DEBUG_MAP_GRID:updateView()
            end
            mapGrid:enableDebugDraw(UI.RED)
            DEBUG_MAP_GRID = mapGrid
        end
    end
end

-- 更新可视区域
function MapTownView:updateVisibleRange(coordX, coordY)
    -- 更新可视格子
    if (self._hasFog) then
        updateVisibleRange(self, coordX, coordY)
    end
end

-- 是否透视
function MapTownView:enablePerspective()
    self._isPerspective = true
end

-- 关闭战争迷雾
function MapTownView:disableFog()
    self._hasFog = false
end

-- 禁用以主角为中心
function MapTownView:disableCenterByMaster()
    self._isCenterByMaster = false
end

-- 获取所有格子
function MapTownView:getMapGridList()
    return self._mapGridList
end

-- 获取入口格子
function MapTownView:getEnteranceMapGrid()
    if (self._mapGridList) then
        for i = 1, #self._mapGridList do
            local mapGrid = self._mapGridList[i]
            if (mapGrid and mapGrid:isEnterance()) then
                return mapGrid
            end
        end
    end
    return nil
end

-- 启用性能优化，设置显示的半径
function MapTownView:setVisibleRangeForPerformance(visibleRangeWidth, visibleRangeHeight)
    self._enableVisibleRangeForPerformance = true
    self._visibleRangeWidthForPerformance = visibleRangeWidth
    self._visibleRangeHeightForPerformance = visibleRangeHeight
end

-- 获取地图上玩家自己的坐标
function MapTownView:getMasterCoord()
    return self._centerCoordX, self._centerCoordY
end

-- 显示坐标信号
function MapTownView:showCoordSignal(spriteID)
    local mapGrid = self._roleGridMap[spriteID]
    if (mapGrid) then   
        local coordX, coordY = mapGrid:getCoord()
        local posX, posY = self:getRelativePosition(coordX, coordY)

        local showTimes = 0
        local animation = self._animationMap[spriteID]
        if (not animation) then 
            animation = UI.Animation:create() 
            animation:init(ANIMATION_JSON_SIGNAL, ANIMATION_ATLAS_SIGNAL, 1.0)
            animation:play(ANIMATION_NAME_SIGNAL_IDLE, true)
            animation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(self)
                showTimes = showTimes + 1
                if (showTimes >= 3) then 
                    animation:close()

                    self._animationMap[spriteID] = nil
                end
            end)
            self._signalLayer:addChild(animation)

            self._animationMap[spriteID] = animation
        end
        animation:leftBottom(posX, posY)
        print("MapTownView:showCoordSignal",coordX, coordY,posX, posY)
    else
        assert(false)
    end
end

--显示解锁动画
function MapTownView:showTaskTalkSignal(targetID)
    if(targetID) then
        local targetRoleData = nil
        for k, roleData in ipairs(self.functionNpcDataArr) do 
            if(roleData:getId() == targetID) then 
                targetRoleData = roleData
                break
            end
        end

        if (targetRoleData and targetRoleData.iconMap and targetRoleData.iconMap.position) then   
            local coordX, coordY = targetRoleData.iconMap.position[1], targetRoleData.iconMap.position[2]
            local posX, posY = self:getRelativePosition(coordX, coordY)

            local showTimes = 0
            local animation = self._unlockAnimationList[spriteID]
            if (not animation or tolua.isnull(animation)) then 
                animation = UI.Animation:create() 
                if(SceneManager:getInstance():isInFightScene()) then
                    animation:init(ANIMATION_JSON_SIGNAL, ANIMATION_ATLAS_SIGNAL, 1.0)
                else
                    animation:init(ANIMATION_JSON_SIGNAL_GENERAL, ANIMATION_ATLAS_SIGNAL_GENERAL, 1.0)
                end
                animation:play(ANIMATION_NAME_UNLOCK_IDLE, true)
                self._signalLayer:addChild(animation)
                self._unlockAnimationList[targetRoleData:getSpriteID()] = animation
            end
            animation:leftBottom(posX, posY + 10)
            -- print("MapTownView:showUnLockSignal",coordX, coordY,posX, posY)
        else
            assert(false)
        end
    end
end

--显示解锁动画
function MapTownView:showUnLockSignal(spriteID)
    -- print("MapTownView:showUnLockSignal",spriteID)
    local mapGrid = self._NPCGridMap[spriteID]
    if (mapGrid) then   
        local coordX, coordY = mapGrid:getCoord()
        local posX, posY = self:getRelativePosition(coordX, coordY)

        local showTimes = 0
        local animation = self._unlockAnimationList[spriteID]
        if (not animation or tolua.isnull(animation)) then 
            animation = UI.Animation:create() 
            if(SceneManager:getInstance():isInFightScene()) then
                animation:init(ANIMATION_JSON_SIGNAL, ANIMATION_ATLAS_SIGNAL, 1.0)
            else
                animation:init(ANIMATION_JSON_SIGNAL_GENERAL, ANIMATION_ATLAS_SIGNAL_GENERAL, 1.0)
            end
            animation:play(ANIMATION_NAME_UNLOCK_IDLE, true)
            self._signalLayer:addChild(animation)
            self._unlockAnimationList[spriteID] = animation
        end
        animation:leftBottom(posX, posY + 10)
        -- print("MapTownView:showUnLockSignal",coordX, coordY,posX, posY)
    else
        assert(false)
    end
end

--移除解锁动画
function MapTownView:removeUnLockSignal(spriteID)
    -- print("MapTownView:removeUnLockSignal",spriteID)
    local mapGrid = self._NPCGridMap[spriteID]
    if (mapGrid) then   
        local coordX, coordY = mapGrid:getCoord()
        local posX, posY = self:getRelativePosition(coordX, coordY)

        local showTimes = 0
        local animation = self._unlockAnimationList[spriteID]
        if animation and not tolua.isnull(animation)  then 
            animation:close()
        end
    else
        assert(false)
    end
end


--系统解锁
function MapTownView:unLockfunction(unLockFunctionType)
    -- print("MapTownView:unLockfunction",unLockFunctionType,Game.FunctionUnlockManager:getInstance():lockTypeToNPCFuncType(unLockFunctionType))
    if unLockFunctionType and RoleDataManager:isUnlockByFunctionType(unLockFunctionType) then
        local npcFuncTypeList = Game.FunctionUnlockManager:getInstance():lockTypeToNPCFuncType(unLockFunctionType)
        if npcFuncTypeList then
            for j,npcFuncType in pairs(npcFuncTypeList) do
                for k,v in pairs(self._NPCGridMap) do
                    -- print(k,v.__cname)
                    local roleDataList = v._mapGridData:getRoleDatas()
                    if roleDataList then
                        for i = 1, #roleDataList do
                            local roleData = roleDataList[i]
                            local roleType = roleData:getType()
                            if roleType == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC and roleData.__cname == "TriggerNpcData" then
                                local functionTypeArr = roleData:getFunctionTypeArr()

                                for k1, npcType in pairs(functionTypeArr) do
                                    if npcType == npcFuncType then
                                        self:showUnLockSignal(k)
                                        -- return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

--系统解锁 移除new动画
function MapTownView:removeUnLockfunction(unLockFunctionType)
    print("MapTownView:removeUnLockfunction",unLockFunctionType)
    if unLockFunctionType then
        local npcFuncTypeList = Game.FunctionUnlockManager:getInstance():lockTypeToNPCFuncType(unLockFunctionType)
        if npcFuncTypeList then
            for j,npcFuncType in pairs(npcFuncTypeList) do
                for k,v in pairs(self._NPCGridMap) do
                    -- print(k,v.__cname)
                    local roleDataList = v._mapGridData:getRoleDatas()
                    if roleDataList then
                        for i = 1, #roleDataList do
                            local roleData = roleDataList[i]
                            local roleType = roleData:getType()
                            -- print("MapTownView:removeUnLockfunction",npcFuncType,roleType)
                            if roleType == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC and roleData.__cname == "TriggerNpcData" then
                                local functionTypeArr = roleData:getFunctionTypeArr()
                                -- dump(functionTypeArr)
                                for k1, npcType in pairs(functionTypeArr) do
                                    if npcType == npcFuncType then

                                        if(#functionTypeArr >=2) then
                                            -- TODO 处理有多重功能的触发NPC 处理逻辑 
                                            local mainFunction = roleData:getMainFunction()
                                            if(mainFunction ~= 0) then
                                                functionTypeArr = {}
                                                table.insert(functionTypeArr,mainFunction)
                                            end
                                        end
                                        if Game.FunctionUnlockManager:getInstance():isShowMiniMapAction(functionTypeArr) then
                                            self:showUnLockSignal(k)
                                        else
                                            self:removeUnLockSignal(k)
                                        end
                                        -- return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end





-- 获取所有角色的坐标
function MapTownView:getHeroGridMap()
    return self._roleGridMap
end

-- 是否将地块渲染成整张纹理
function MapTownView:enableRenderMapGridTexture()
    self._renderMapGridTexture = true
end

-- 更新单个地块
function MapTownView:updateMapGrid(mapGrid)
    checkMapGridVisible(self, mapGrid)
end

-- 是否显示队友
function MapTownView:setTeammateShow(visible)
    self._showTeammate = visible
end

function MapTownView:onTriggerMonster(modelData)
    if (modelData) then
        local category = modelData:getCategory()
        local type = modelData:getType()

        if category == Category.ROLE then
            local coord = modelData:getCoord()
            updateMapGrid(self, coord.x, coord.y)
        end
    else
        assert(false)
    end
end
