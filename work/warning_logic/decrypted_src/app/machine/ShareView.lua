-- ShareView.lua
-- Author:zp
-- 2017年4月13日
-- Using:通用view

local MapLayer = require "app.mapkit.layers.MapLayer"
local MapDefine = require "app.mapkit.MapDefine"
require "app.renderer.component.ClickFloorEffectComponent"
require "app.renderer.component.HighlightMapGridComponent"
require "app.renderer.component.WallBreakComponent"

Machine = Machine or {}

local ShareView = class("ShareView", Machine.View)
Machine.ShareView = ShareView

-- private:
local DEBUG = false

-- 显示视图的z序偏移量
local OBJECT_ZORDER_OFFSET = 5
local CLICK_FX_ZORDER_OFFSET = 10000

-- 战斗场景层级
local BATTLE_LAYER_ZORDER_MAP = 1
-- 城镇中每次添加的角色个数
local TOWN_VIEW_TICK_NUM = 1
-- 回收内存的时间间隔
local RECYCLE_MEMEROY_TIME = 1200

-- public:
-- 构造函数
function ShareView:ctor()
    -- 视图根节点
    self._viewNode = nil
    -- 地图节点
    self._mapNode = nil
    self._map = nil
    self._mapData = nil

    -- 点击操作效果
    self._clickFloorEffect = nil
    self._clickFloorInvisbleEffect = nil
    self._clickFloorVisbleEffect = nil
    self._choiceClickFloorEffect = nil
    self._initClickEffect = false
    -- 高亮显示地块的效果
    self._highlightMapGridList = {}

    -- 渲染器集合
    self._rendererMap = nil
    -- 被延迟移除的渲染器集合
    self._delayToRemoveMap = nil
    -- 等待添加的的角色
    self._waitingAddModel = {}
    self._tickAddModelNum = 0
    -- lostrealm 动画表现列表 {key:"x:y",value:animation}
    self._lostRealmAnimationArr = {}

    if AvalonUtil.isSmallMemoryDevice() then
        RECYCLE_MEMEROY_TIME = 60
    end
end

-- 销毁
function ShareView:destroy()
    self:clear()

    self._viewNode = nil
    self._rendererMap = nil
    self._delayToRemoveMap = nil
    self._lostRealmAnimationArr = {}
end

-- 初始化
function ShareView:init(model, viewNode)
    if (viewNode and model) then
        self._model = model
        self._viewNode = viewNode
        -- by CMonk, 机器人运行优化, 可以直接删除
        if (Auto and Auto.Robot and Auto.Robot:isOp()) then self._viewNode:hide() end
        -- eo CMonk

        -- 初始化点击操作效果
        self._clickFloorEffect = Component.ClickFloorEffectComponent:create()
        self._clickFloorEffect:retain()

        -- 初始化不可见效果
        self._clickFloorInvisbleEffect = Component.ClickFloorEffectComponent:create()
        self._clickFloorInvisbleEffect:retain()

        -- 初始化点击墙壁可见效果
        self._clickFloorVisbleEffect = Component.ClickFloorEffectComponent:create()
        self._clickFloorVisbleEffect:retain()

        self._rendererMap = {}
        self._delayToRemoveMap = {}
    else
        printError("[ERROR] ShareView init: view node is nil.")
    end
end

-- 清理
function ShareView:clear()
    -- 销毁点击特效
    if self._clickFloorEffect then
        if (self._clickFloorEffect:getParent()) then
            self._clickFloorEffect:removeFromParent(true)
        else
            self._clickFloorEffect:destroy()
        end
        self._clickFloorEffect:release()
        self._clickFloorEffect = nil
    end
    if self._clickFloorInvisbleEffect then
        if (self._clickFloorInvisbleEffect:getParent()) then
            self._clickFloorInvisbleEffect:removeFromParent(true)
        else
            self._clickFloorInvisbleEffect:destroy()
        end
        self._clickFloorInvisbleEffect:release()
        self._clickFloorInvisbleEffect = nil
    end
    if self._clickFloorVisbleEffect then
        if (self._clickFloorVisbleEffect:getParent()) then
            self._clickFloorVisbleEffect:removeFromParent(true)
        else
            self._clickFloorVisbleEffect:destroy()
        end
        self._clickFloorVisbleEffect:release()
        self._clickFloorVisbleEffect = nil
    end
    self._choiceClickFloorEffect = nil
    self._initClickEffect = false

    -- 销毁渲染器
    local rendererMap = self._rendererMap
    for id, renderer in pairs(rendererMap) do
        renderer:destroy()
        rendererMap[id] = nil
    end
    local delayToRemoveMap = self._delayToRemoveMap
    for id, renderer in pairs(delayToRemoveMap) do
        renderer:destroy()
        delayToRemoveMap[id] = nil
    end

    -- 销毁高亮显示的地块
    self:removeHighlightMapGrid()
    self._highlightMapGridList = nil

    -- 销毁地图
    if (self._mapNode) then
        self._mapNode:removeFromParent(true)
        self._mapNode = nil
        self._map = nil
        self._mapData = nil
    end

    -- 销毁根节点
    self._viewNode = nil
end

-- ab
-- 创建render并加入地图
function ShareView:createRenderAndAddToMap(model)
    printError(" ShareView:createRenderAndAddToMap method should be overrided.")
    return nil
end

-- 获取地图视图
function ShareView:getMap()
    return self._map
end

-- 获取地块数据
function ShareView:getMapTileData(x, y)
	return self._mapData.tileDataMap[y + 1][x + 1]
end

-- 获取地块的z坐标
function ShareView:getMapTileCoordZ(coordX, coordY)
    local x, y = math.floor(coordX + 0.5), math.floor(coordY + 0.5)
    local mapTileY = self._mapData.tileDataMap[y + 1]
    if mapTileY then
        local mapTile = mapTileY[x + 1]
        if (mapTile) then
            return mapTile.z
        end
    end
    return 0
end

-- 获取地块的显示位置
function ShareView:getMapTilePosition(coordX, coordY, coordZ)
    local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
    return sx, sy + sz
end

-- 获取地块的z序
function ShareView:getMapTileZOrder(coordX, coordY)
    return self._map:getZOrderByCoordinate(coordX, coordY)
end

-- 判断某个地块是否被遮挡
function ShareView:isHiddenByWall(centerX, centerY, coordX, coordY)
    return self._map:isHiddenByWallAtCoord(centerX, centerY, coordX, coordY)
end

-- 将屏幕坐标转换成地块坐标
function ShareView:convertPositionToCoord(screenPosition)
    local mapPosition = self._map:convertToNodeSpace(screenPosition)
    local coordX, coordY = self._map:positionToCoordinate(mapPosition.x, mapPosition.y)
    return coordX, coordY
end

-- 将地块坐标转换成屏幕坐标
function ShareView:convertCoordToPosition(mapCoord)
    local nodeX, nodeY = self._map:coordinateToPosition(mapCoord.x, mapCoord.y)
    local screenPosition = self._map:convertToWorldSpace(cc.p(nodeX, nodeY))
    return screenPosition.x, screenPosition.y
end

-- 将视图添加到地图上
function ShareView:addViewToMap(model, view, coordX, coordY, coordZ, zOrderOffset)
    if (not coordZ) then
        coordZ = self:getMapTileCoordZ(coordX, coordY)
    end

    if(model and model:getCategory() == Category.TRIGGER_NPC) then
        local npcData = model:getNpcData()
        local size = npcData:getOccupySize()
        if( model:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
            local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
            view:setPosition(sx, sy + sz)
            
        else
            local sx, sy = self._map:getCenterPositionOfBoundingBox(coordX, coordY, coordZ, size[1], size[2])
            view:setPosition(sx, sy)
            
            -- local isRank = false
            -- if(npcData:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
                -- isRank = npcData:hasFunction(PublicDefine.FUNCTION_TYPE.LEADERBOARD)

                -- if(isRank) then
                --     -- print("ShareView  isRank=", isRank, coordX, coordY)
                --     -- 这里对NPC做了特殊处理
                --     local zOrder = self._map:getBoundingProperZOrder(MapDefine.BoundingPoint.BottomRight,coordX, coordY, size[1], size[2],0)

                --     view:setZOrder(zOrder)
                --     self._map:addNodeOnMap(view)
                --     return 
                -- end

                -- if(model:getNpcData().ID == 10407001) then 
                --     print("TRIGGER_NPC_TYPE.FUNCTION_NPC  offsetZorder=", offsetZorder)
                --     local zOrder = self._map:getBoundingProperZOrder(MapDefine.BoundingPoint.BottomRight,coordX, coordY, size[1], size[2],0)

                --     view:setZOrder(zOrder)
                --     self._map:addNodeOnMap(view)
                --     return 
                -- end
            -- end
        end

        -- 这里根据配置文件来处理重心点
        if(npcData:getZOrderBasePoint()~= "" and npcData:getZOrderBasePoint()~= nil) then 
            local zOrder = self._map:getBoundingProperZOrder(npcData:getZOrderBasePoint(),coordX, coordY, size[1], size[2],0)
            view:setZOrder(zOrder)
            self._map:addNodeOnMap(view)
            return 
        end
    elseif(model and model:getCategory() == Category.ROLE) then
        -- print("addViewToMap  offsetCoord=", model:getType() == RoleType.Role, model:isMaster())
        if(model:getType() == RoleType.Monster) then
            local data = model:getData()
            local size = data:getOccupySize()

            local sx, sy = self._map:getCenterPositionOfBoundingBox(coordX, coordY, coordZ, size[1], size[2])
            local offsetCoord = {x =0, y =0}
            view:setPosition(sx+ offsetCoord.x, sy + offsetCoord.y)
        elseif (model:getType() == RoleType.Hero and model:isMaster()) then
            local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
            local offsetCoord = {x =0, y =0}
            local SceneManager = require("app.game.SceneManager")
            if(SceneManager:getInstance():isInLostRealm()) then
                offsetCoord = GameManager:getLostRealmOffsetCoord()
                -- print("addViewToMap  offsetCoord=", offsetCoord)
            end
            view:setPosition(sx+ offsetCoord.x, sy + offsetCoord.y)
        else
            local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
            view:setPosition(sx, sy + sz)
        end
    else
        local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
        view:setPosition(sx, sy + sz)
    end

    local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
    zOrderOffset = zOrderOffset or 0
    view:setZOrder(zOrder + OBJECT_ZORDER_OFFSET + zOrderOffset)
    -- by CMonk, 机器人运行优化, 可以直接删除
    if (Auto and Auto.Robot and Auto.Robot:isOp()) then return end
    -- eo CMonk
    self._map:addNodeOnMap(view)
end

-- 把视图添加地面上
function ShareView:addViewToOnGroundMap(model, view, coordX, coordY, coordZ, zOrderOffset, isCenterPosition)
    if (not coordZ) then
        coordZ = self:getMapTileCoordZ(coordX, coordY)
    end

    if(isCenterPosition == nil) then
        isCenterPosition = true
    end

    if(model and model:getCategory() == Category.TRIGGER_NPC) then
        if( model:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
            local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
            view:setPosition(sx, sy + sz)
        else
            if(isCenterPosition) then
                local npcData = model:getNpcData()
                local size = npcData:getOccupySize()

                local sx, sy = self._map:getCenterPositionOfBoundingBox(coordX, coordY, coordZ, size[1], size[2])
                view:setPosition(sx, sy)
            else 
                local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
                view:setPosition(sx, sy + sz)
            end
        end
    else
        local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
        view:setPosition(sx, sy + sz)
    end

    local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
    zOrderOffset = zOrderOffset or 0
    view:setZOrder(zOrder + OBJECT_ZORDER_OFFSET + zOrderOffset)
    -- by CMonk, 机器人运行优化, 可以直接删除
    if (Auto and Auto.Robot and Auto.Robot:isOp()) then return end
    -- eo CMonk
    self._map:addNodeOnGround(view)
end

-- 将视图添加到地图最顶层
function ShareView:addViewToBeyondMap(model, view, coordX, coordY, coordZ, zOrderOffset)
    if (not coordZ) then
        coordZ = self:getMapTileCoordZ(coordX, coordY)
    end

    if(model and model:getCategory() == Category.TRIGGER_NPC) then
        if( model:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
            local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
            view:setPosition(sx, sy + sz)
        else
            local npcData = model:getNpcData()
            local size = npcData:getOccupySize()

            local sx, sy = self._map:getCenterPositionOfBoundingBox(coordX, coordY, coordZ, size[1], size[2])
            view:setPosition(sx, sy)
        end
    else

        local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
        -- print(sx, sy, sz,coordX, coordY, coordZ)
        view:setPosition(sx, sy + sz)
    end

    local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
    zOrderOffset = zOrderOffset or 0
    view:setZOrder(zOrder + OBJECT_ZORDER_OFFSET + zOrderOffset)
    -- by CMonk, 机器人运行优化, 可以直接删除
    if (Auto and Auto.Robot and Auto.Robot:isOp()) then return end
    -- eo CMonk
    self._map:addNodeBeyondMap(view)
end

-- 添加游戏模型的视图
function ShareView:addView(model)
    local modelCategory = model:getCategory()
    local modelType = model:getType()
    local modelId = model:getId()
    -- if DEBUG then
    --     print(string.format("ShareView addView: add view for model, category:%d, type:%d, id:%d.", modelCategory, modelType, modelId))
    -- end

    local renderer = nil
    local spriteID = 0

    -- 判断是否已经存在
    if self._rendererMap[modelId] then
        -- if DEBUG then
        --     print("ShareView addView:  have SpriteID")
        -- end

        -- 为了处理BOSS的切换状态的逻辑
        if(model and model.getIsChangeTemplateID and model.getIsWake) then 
            if(model:getIsChangeTemplateID() or model:getIsWake()) then 
                print("ShareView:addView   run one boss status change")
                local SceneManager = require("app.game.SceneManager")
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initBossStatusChange(model:getId())
                SceneManager:getInstance():pushCommand(animationCommand)
            end
        end
        return
    end

    -- 判断是否需要缓存创建消息, 这里值缓存城镇的，洞窟内不缓存
    local SceneManager = require("app.game.SceneManager")
    if(not SceneManager:getInstance():isInFightScene() and self._tickAddModelNum >= TOWN_VIEW_TICK_NUM) then 
        if not (modelCategory == Category.ROLE and modelType == RoleType.Hero and model:isMaster())  
        and not (modelCategory == Category.ROLE and modelType == RoleType.Pet and model:getMaster():isMaster()) then
            table.insert(self._waitingAddModel, model)
            return
        end
    end
    self._tickAddModelNum = self._tickAddModelNum + 1

    renderer = self:createRenderAndAddToMap(model)

    if (renderer) then
        self._rendererMap[modelId] = renderer
    else
        printError("[ERROR] ShareView addView: no renderer to created. modelCategory, modelType, modelId=", modelCategory, modelType, modelId)
    end
end

function ShareView:refresTrapView(model)
    local modelCategory = model:getCategory()
    local modelType = model:getType()
    local modelId = model:getId()

    if self._rendererMap[modelId] then
        self:addTrapView(model, self._rendererMap[modelId], model:getNpcData().trapSize)
    end
end

-- 删除游戏模型的视图
function ShareView:removeView(model, cleanView)
    cleanView = (cleanView == nil) and true or cleanView
    if(self._waitingAddModel and #self._waitingAddModel >0) then 
        for k, v in ipairs(self._waitingAddModel) do 
            if(v:getId() == model:getId()) then 
                table.remove(self._waitingAddModel, k)
                break
            end
        end
    end

    local modelCategory = model:getCategory()
    local modelType = model:getType()
    local modelId = model:getId()
    local coord = model:getCoord()

    -- print(string.format("ShareView removeView: remove the view of model, category:%d, type:%d, id:%d, clean:%s.", modelCategory, modelType, modelId, cleanView))

    local renderer = self._rendererMap[modelId]
    if (renderer) then
        self._map:unsetMapObject(coord.x, coord.y, renderer:getView())
        -- 多视图节点的渲染器
        local viewList = renderer:getViewList()
        if (viewList) then
            for i, view in pairs(viewList) do
                self._map:unsetMapObject(coord.x, coord.y, view)
            end
        end

        if (cleanView) then
            renderer:destroy()
        else
            self:addDelayRenderer(model, renderer)
        end
        self._rendererMap[modelId] = nil
    else
        -- printError("[ERROR] ShareView removeView: no renderer found for model. modelCategory, modelType, modelId=", modelCategory, modelType, modelId)
    end
end

-- 获取渲染器
function ShareView:getRenderer(modelId)
    -- local modelId = model:getId()
    -- if DEBUG then
    --     print(string.format("ShareView getRenderer: get the renderer for model %d.", modelId))
    -- end

    -- return self._rendererMap[modelId]

    local renderer = self._rendererMap[modelId]
    if(renderer == nil) then
        renderer = self._delayToRemoveMap[modelId]
    end

    return renderer
end

-- 添加渲染器
function ShareView:addDelayRenderer(model, renderer)
    if model then
        local modelID = model:getId()
        if (not self._delayToRemoveMap[modelID]) then
            if(renderer and renderer.clearAllFX) then 
                renderer:clearAllFX()
            end

            self._delayToRemoveMap[modelID] = renderer
            if DEBUG then
                print(string.format("ShareView addDelayRenderer: delay to remove the modelID %d.", modelID))
            end
        else
           printError(string.format("[ERROR] ShareView addDelayRenderer: the modelID %d found.", modelID))
        end
    else
       printError("[ERROR] ShareView addDelayRenderer: the model is nil.")
    end

end

-- 初始化地图
function ShareView:showMap(mapData, target, callback)
    if (mapData) then
        self._mapNode = MapLayer:create(mapData)
        if (self._mapNode) then
            self._map = self._mapNode.map
            self._mapData = mapData
            self._viewNode:addChild(self._mapNode, BATTLE_LAYER_ZORDER_MAP)
            -- self._mapNode:setScale(0.5)

            if (target and type(callback) == "function") then
                callback(target)
            end
        end
    else
       printError("[ERROR] ShareView showMap: map data is nil.")
    end
end

--[[
    coord:中心点坐标
    animated: 是否有动画
]]
function ShareView:setNewCenterCoordinate(startCoord,endCoord,nowCoord)
    -- print("ShareView:setNewCenterCoordinate ",startCoord.x,startCoord.y,endCoord.x,endCoord.y,nowCoord.x,nowCoord.y)
    -- 添加地图快上面的调用
    if(self._mapNode and self._mapNode.map) then
        self._mapNode.map:updateTilesVisionAppearance(startCoord, endCoord, nowCoord)
    end
end

-- 设置人物在地图上面的位置
function ShareView:setMapPositionByCoordinate(coord, isSync)
    if self._mapNode then
        self._mapNode:setMapPositionByCoordinate(coord.x, coord.y, isSync)
    end
end

-- 设置地图缩放
function ShareView:setMapScale(mapScale)
    if self._mapNode then
        self._mapNode:setScale(mapScale)
    end
end

function ShareView:showFunctionLight(model, renderer, size)
    if(model:getHalo() == false) then
        return 
    end
    -- print("ShareView:showFunctionLight", size[1], size[2])
    local coord = model:getCoord()
-- 2;2
-- 1;1
-- 3;1
-- 3;3
-- 1;2
-- 3;2

    local animationName = ""
    local rotate = 0
    if(size[1] == 1) then 
        if(size[2] == 1) then 
            -- 1,1 
            animationName = "idle_1"
        elseif(size[2] == 2)then 
            animationName = "idle_7"
        elseif(size[2] == 3)then 
            animationName = "idle_8"
        elseif(size[2] == 3)then 
            animationName = "idle_10"
        end
    elseif (size[1] == 2) then 
        if(size[2] == 1) then 
            animationName = "idle_2"
        elseif(size[2] == 2)then 
            animationName = "idle_3"
        elseif(size[2] == 3)then 
            animationName = "idle_11"
        end
    elseif (size[1] == 3) then 
        if(size[2] == 1) then 
            animationName = "idle_5"
        elseif(size[2] == 2)then 
            animationName = "idle_4"
        elseif(size[2] == 3)then 
            animationName = "idle_6"
        end
     elseif (size[1] == 4) then 
        if(size[2] == 1) then 
            animationName = "idle_9"
        elseif(size[2] == 2)then 
            animationName = "idle_12"
        end
    end

    if(animationName == "") then 
        printError("ShareView:showFunctionLight no handle size.", size[1], size[2])
        return 
    end 

    -- body
    local trapViewNodeList = renderer:createLightViewList(animationName, rotate)
    if (trapViewNodeList) then
        local zOrderOffset = 0
        if (not isDown) then
            zOrderOffset = 9995
        end
        -- print("ShareView:showFunctionLight", #trapViewNodeList)
        local startCoordX, startCoordY = coord.x , coord.y

        local mapTileData = self._mapData:getTileDataAtCoord(startCoordX, startCoordY)
        if (mapTileData and not mapTileData:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR)) then
            local trapViewNode = trapViewNodeList[1]
            if(not trapViewNode:getParent()) then
                -- 这里为了处理相关的逻辑
                local coordZ = self:getMapTileCoordZ(startCoordX, startCoordY)
                local sz = 0
                local sx, sy = self._map:getCenterPositionOfBoundingBox(coord.x, coord.y, coordZ, size[1], size[2])
                trapViewNode:setPosition(sx, sy + sz)
                self._map:addNodeOnMap(trapViewNode, 0)
                self._map:setMapObject(startCoordX, startCoordY, trapViewNode)
            end
        end
        
        -- local index = 0
        -- for i=0, size[1]-1 do 
        --     for j=0, size[2]-1 do 
        --         local coordX = startCoordX + i
        --         local coordY = startCoordY + j

        --         local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)
        --         -- print("ShareView:showFunctionLight 1",startCoordX, startCoordY, coordX, coordY)
        --         if (mapTileData and not mapTileData:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR)) then
        --             local trapViewNode = trapViewNodeList[index + 1]
        --             -- print("ShareView:showFunctionLight 2", #trapViewNodeList)
        --             if(not trapViewNode:getParent()) then
        --                 -- print("ShareView:showFunctionLight 3", #trapViewNodeList)
        --                 -- 这里为了处理相关的逻辑
                            

        --                 local coordZ = self:getMapTileCoordZ(coordX, coordY)
        --                 local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
        --                 trapViewNode:setPosition(sx, sy + sz)
        --                 self._map:addNodeOnMap(trapViewNode, 0)

        --                 -- zOrderOffset = 99999
        --                 -- self:addViewToOnGroundMap(model, trapViewNode, coordX, coordY, nil, zOrderOffset, false)

        --                 self._map:setMapObject(coordX, coordY, trapViewNode)
        --             end
        --         end
        --         index = index + 1
        --     end
        -- end


        -- for i = 0, #trapViewNodeList - 1 do
        --     local coordX = startCoordX + (i % size[1])
        --     local coordY = startCoordY + (math.floor(i / size[2]))

        --     local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)
        --     -- todo add by yys 这里为什么要判断可以行走才创建陷阱呢？如果是这样的话,如果墙上有迷雾或者毒气
        --     -- 就不会被创建,在墙被挖开之后不会显示出来
        --     print("ShareView:showFunctionLight 1", coordX, coordY)
        --     if (mapTileData and not mapTileData:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR)) then
        --         local trapViewNode = trapViewNodeList[i + 1]
        --         print("ShareView:showFunctionLight 2", #trapViewNodeList)
        --         if(not trapViewNode:getParent()) then
        --             print("ShareView:showFunctionLight 3", #trapViewNodeList)
        --                 -- 这里为了处理相关的逻辑
        --                 zOrderOffset = 99999

        --                 self:addViewToOnGroundMap(model, trapViewNode, coordX, coordY, nil, zOrderOffset)

        --             self._map:setMapObject(coordX, coordY, trapViewNode)
        --         end
        --     end
        -- end
    end
end

--[[
    移动点击
    coord:
    moveType: 1 可以走动  2 不能走动，不是墙 3，4，5，6 墙的周围不同状态
    viewVisible: false 不可见  true 可见
]]
function ShareView:moveClick(coordX, coordY, moveType, viewVisible)
    -- 初始化点击特效
    if (not self._initClickEffect and self._map) then
        -- self._map:addNodeOnGround(self._clickFloorEffect)
        self._map:addNodeOnMap(self._clickFloorEffect)
        self._map:addNodeBeyondMap(self._clickFloorInvisbleEffect)
        self._map:addNodeOnMap(self._clickFloorVisbleEffect)
        -- self._map:addNodeBeyondMap(self._clickFloorVisbleEffect)
        

        self._initClickEffect = true
    end

    self._clickFloorEffect:removeEffect()
    self._clickFloorInvisbleEffect:removeEffect()
    self._clickFloorVisbleEffect:removeEffect()

    local choiceClickFloorEffect = nil
    local zOrderOffset = 0
    if viewVisible then
        if moveType >= 3 then
            choiceClickFloorEffect = self._clickFloorVisbleEffect
            zOrderOffset = - 4999
        else
            choiceClickFloorEffect = self._clickFloorEffect
            zOrderOffset = - 4999
        end
    else
        choiceClickFloorEffect = self._clickFloorInvisbleEffect
    end
    if moveType == 1 then
        choiceClickFloorEffect:showHitEffect(viewVisible)
    elseif moveType == 2 then
        choiceClickFloorEffect:showInvalidEffect(viewVisible)
    elseif moveType == 3 then
        choiceClickFloorEffect:showInvalidEffect(false)
    elseif moveType == 4 then
        choiceClickFloorEffect:showClickWallLeftRightRoad()
    elseif moveType == 5 then
        choiceClickFloorEffect:showClickWallLeftRoad()
    elseif moveType == 6 then
        choiceClickFloorEffect:showClickWallRightRoad()
    else
        printError("[ERROR] ShareView moveClick: move type is invalid.  moveType=", moveType)
    end

    -- 计算点击特效的显示位置和z序
    -- local coordX, coordY = coord.x, coord.y
    local coordZ = self:getMapTileCoordZ(coordX, coordY)
    local posX, posY = self:getMapTilePosition(coordX, coordY, coordZ)
    choiceClickFloorEffect:setPosition(posX, posY)
    local zOrder = 0
    if viewVisible == true then
        zOrder = self:getMapTileZOrder(coordX, coordY) + zOrderOffset
        choiceClickFloorEffect:setLocalZOrder(zOrder)
    end

    -- 当前使用的地面点击特效
    self._choiceClickFloorEffect = choiceClickFloorEffect

    -- if (DEBUG) then
    --     print(string.format("ShareView moveClick: coord:(%f,%f,%f) zOrder:%d viewVisible:%s moveType:%d", coordX, coordY, coordZ, zOrder, viewVisible, moveType))
    -- end
end

-- 移动点击效果运行
function ShareView:moveClickShow()
    if self._choiceClickFloorEffect then
        self._choiceClickFloorEffect:runEffect()
    end
end

-- 移除移动点击效果
function ShareView:moveClickRemove()
    if self._choiceClickFloorEffect then
        self._choiceClickFloorEffect:removeEffect()
    end
end

-- 高亮显示地块
function ShareView:showHighlightMapGrid(coordList)
    if (coordList) then
        for i = 1, #coordList do
            local coord = coordList[i]
            local coordX, coordY = coord.x, coord.y
            
            local highlightGrid = Component.HighlightMapGridComponent:create()
            local coordZ = self:getMapTileCoordZ(coordX, coordY)
            local posX, posY = self:getMapTilePosition(coordX, coordY, coordZ)
            highlightGrid:setPosition(posX, posY)
            self._map:addNodeBeyondMap(highlightGrid)

            table.insert(self._highlightMapGridList, highlightGrid)
        end
    end
end

-- 移除高亮显示的地块
function ShareView:removeHighlightMapGrid()
    for i = 1, #self._highlightMapGridList do
        local highlightGrid = self._highlightMapGridList[i]
        highlightGrid:removeFromParent()

        self._highlightMapGridList[i] = nil
    end
end

-- 更新
function ShareView:update(dt)
    -- by CMonk, 机器人运行优化, 可以直接删除
    if (Auto and Auto.Robot and Auto.Robot:isOp()) then return end
    -- eo CMonk

    -- add by zp 在游戏中整个lua对象没有回收，导致内存逐渐增加很多
    if(self.waitingCollectTime == nil) then 
        self.waitingCollectTime = 0
    end
    self.waitingCollectTime = self.waitingCollectTime + dt 
    if(self.waitingCollectTime > RECYCLE_MEMEROY_TIME) then 
        self.waitingCollectTime = 0
        collectgarbage("collect")
    end

    -- 添加一次缓存的数据
    if(self._tickAddModelNum < TOWN_VIEW_TICK_NUM and #self._waitingAddModel > 0) then 
        local addModel = self._waitingAddModel[1]
        table.remove(self._waitingAddModel, 1)
        if(addModel) then 
            self:addView(addModel)
        end
    end

    self._tickAddModelNum = 0
    -- 渲染器更新
    local rendererMap = self._rendererMap
    for id, renderer in pairs(rendererMap) do
        renderer:draw(dt)
    end

    -- 延迟移除的渲染器
    local delayToRemoveMap = self._delayToRemoveMap
    for id, renderer in pairs(delayToRemoveMap) do
        if (renderer:isToRemove()) then
            print(string.format("ShareView update: delay to remove the renderer %d.", id))

            renderer:destroy()
            delayToRemoveMap[id] = nil
        else
            renderer:draw(dt)
        end
    end
end

--获取地图的长宽像素
function ShareView:getMapViewSize()
    return self._map.width, self._map.height 
end

--获取地图的 X、Y轴 地块 数量
function ShareView:getMapTileSize()
    return self._map.sizeX, self._map.sizeY 
end


-- 触发陷阱的效果
function ShareView:triggerTrap(model, renderer)
    if (renderer) then
        local coord = model:getCoord()

        local effectViewNodeList, isDown = renderer:trigger(model:getIsOpen())
        if (effectViewNodeList) then
            local zOrderOffset = 0
            if (not isDown) then
                zOrderOffset = 4995
            end

            local size = renderer:getEffectSize()
            local startCoordX, startCoordY = coord.x - (size[1] - 1) / 2, coord.y - (size[2] - 1) / 2
            for i = 0, #effectViewNodeList - 1 do
                local coordX = startCoordX + (i % size[1])
                local coordY = startCoordY + (math.floor(i / size[2]))

                local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)
                if (mapTileData and mapTileData:isReachable() and self._mapData:isCoordInChamber(mapTileData.x, mapTileData.y) == false) then
                    local effectViewNode = effectViewNodeList[i + 1]
                    self:addViewToMap(model, effectViewNode, coordX, coordY, nil, zOrderOffset)
                end
            end
        end
    end
end


function ShareView:initLostRealmAnimation(lostRealmArr)
    for k, animation in pairs(self._lostRealmAnimationArr) do 
        if(not tolua.isnull(animation)) then 
            animation:runAction(cc.RemoveSelf:create())
        end
    end
    self._lostRealmAnimationArr = {}
    self._lostRealmCenterAnimation = nil
    if(lostRealmArr) then 
        for k, oneData in pairs(lostRealmArr) do 
            if(oneData.ShowIcon and oneData.ShowIcon ~= "") then
                local key = oneData.Location[1]..":"..oneData.Location[2]
                local skeleton = "effect_ui_town_lostrealm_reward.json"
                local atlas = "effect_ui_town_lostrealm_reward.atlas"
                local fxNode = Avalon.Animation:create(skeleton, atlas, 1.0);
                fxNode:setUnloadResFlag(false)
                fxNode.animationName = oneData.ShowIcon
                fxNode:setVisible(false)
                self._lostRealmAnimationArr[key] = fxNode
                self._mapNode:addViewToMapByOffset(fxNode, oneData.Location[1], oneData.Location[2], GameManager:getLostRealmOffsetCoord())
            end
        end

        local centerAnimation = Avalon.Animation:create("effect_ui_town_lostrealm_baoxiang.json", "effect_ui_town_lostrealm_baoxiang.atlas", 1.0);
        centerAnimation:setUnloadResFlag(false)
        centerAnimation:setAnimation(0, "iron_idle", true)
        local centerCoord = {x = 4, y = 4}
        local str = ConfigManager:getGeneralForKey("LostRealmCenter")
        local strArr = string.split(str, ",")
        if(strArr and #strArr == 2)then
            centerCoord = {x = tonumber(strArr[1]), y = tonumber(strArr[2])}
        end
        self._mapNode:addViewToMapByOffset(centerAnimation, centerCoord.x, centerCoord.y, GameManager:getLostRealmOffsetCoord())
        self._lostRealmCenterAnimation = centerAnimation

        self:refreshLostRealmCenterAnimation()
    end

    -- 处理圈数显示
    Avalon.ResHelper:loadPlistSync("ui_town_festival_lostrealm.plist")
    local brandImage = cc.Sprite:create()
    brandImage:setSpriteFrame("ui_monopoly_brand.png")
    self._mapNode:addViewToMapByOffset(brandImage, 5, 4, {x=110, y=50})
    self._lostRealmBrand = brandImage

    self:refreshLostRealmCircle(mvc.festivalModel:getWasRunCirle())
end

function ShareView:testRealmNum(offsetX, node)
    if(self._lostRealmBrand) then 
        self._lostRealmBrand:removeFromParent()
        self._lostRealmBrand = nil
    end

    local brandImage = cc.Sprite:create()
    brandImage:setSpriteFrame("ui_monopoly_brand.png")
    self._mapNode:addViewToMapByOffset(brandImage, 5, 4, offsetX)
    self._lostRealmBrand = brandImage
    if(node) then
        self._lostRealmBrand:addChild(node)
    end
end

function ShareView:refreshLostRealmCircle(num)
    if(self._lostRealmBrand) then
        self._lostRealmBrand:removeAllChildren()

        local downLayout = UI.Layout:create()
        downLayout:init()
        downLayout:centerBottom(66)
        self._lostRealmBrand:addChild(downLayout)
        local num = tostring(num + 1)
        local length = string.len(num)
        local startX = -(26 * length)/2 -6
        local startY = 0
        local oneY = -6
        for i=1, length, 1 do 
            local str = string.format("ui_monopoly_number_%s.png", string.sub(num, i,i))
            local star = UI.Image:create()
            star:init(str)
            star:leftBottom(startX, startY)
            downLayout:addComponent(star)

            startX = startX + 26
            startY = startY + oneY
        end
    end
end

function ShareView:triggerLostRealm(coordX, coordY, isInit)
    self:refreshLostRealmCircle(mvc.festivalModel:getWasRunCirle())
    local key = coordX..":"..coordY
    if self._lostRealmAnimationArr[key] then 
        if(isInit) then
            -- self._lostRealmAnimationArr[key]:setAnimation(0, "open1", false)
            -- self._lostRealmAnimationArr[key]:updateTime(10000)
        else
            self._lostRealmAnimationArr[key]:setVisible(true)
            self._lostRealmAnimationArr[key]:setAnimation(0, self._lostRealmAnimationArr[key].animationName, false)
            Avalon.AudioManager:playSound("10074")
        end
    end

    self:refreshLostRealmCenterAnimation()
end

function ShareView:resetLostRealm()
    -- for k, animation in pairs(self._lostRealmAnimationArr) do 
    --     if(not tolua.isnull(animation)) then 
    --         animation:setAnimation(0, "idle", true)
    --     end
    -- end
end

function ShareView:refreshLostRealmCenterAnimation()
    local cirleNum = mvc.festivalModel:getWasRunCirle()
    if(cirleNum) then
        local cirleNum = mvc.festivalModel:getWasRunCirle()
        local animationName = "iron_idle"
        if(cirleNum<2) then
            animationName = "iron_idle"
        elseif(cirleNum<4) then
            animationName = "gold_idle"
        else
            animationName = "silver_idle"
        end
        self._lostRealmCenterAnimation:setAnimation(0, animationName, true)
    end
end

function ShareView:setVisible(visible)
    self._viewNode:setVisible(visible)
    self._mapNode:setVisible(visible)
end

function ShareView:pause()
    for k, v in pairs(self._rendererMap) do
        if(not tolua.isnull(v)) then 
            v:pause()
        end
    end
    for k, v in pairs(self._delayToRemoveMap) do
        if(not tolua.isnull(v)) then 
            v:pause()
        end
    end
end

function ShareView:resume()
    for k, v in pairs(self._rendererMap) do
        if(not tolua.isnull(v)) then 
            v:resume()
        end
    end
    for k, v in pairs(self._delayToRemoveMap) do
        if(not tolua.isnull(v)) then 
            v:resume()
        end
    end
end
