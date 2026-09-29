local CaveMap = require "app.mapkit.CaveMap"
local TownMap = require "app.mapkit.TownMap"
local MapGen = require "app.mapkit.MapGenerater"
local MapParser = require "app.mapkit.MapParser"
local grids = require "app.mapkit.grids"
local MapHelper = require "app.mapkit.MapHelper"
local GameDataManager = require("app.game.GameDataManager")
local MapDataManager = require "app.mapkit.model.MapDataManager"
local TextureAtlasOverlayer = require "app.mapkit.TextureAtlasOverlayer"
local MapDefine = require "app.mapkit.MapDefine"
local GameDataManager = require("app.game.GameDataManager")
local Grid = require "thirdparty.jumper.grid"
local Pathfinder = require "thirdparty.jumper.pathfinder"
local lume = require "thirdparty.lume"
require "utils.Scheduler"

local MapLayer = class("MapLayer", function ()
    local layer = cc.Layer:create()
    return layer
end)

local winSize = cc.Director:getInstance():getWinSize()
local moveDuration = MapHelper.moveOneTileDuration

local SHACKACTIONTAG = 1001

function MapLayer:ctor(mapData)
    local enableOptimization = true

    if mapData.sceneType == PublicDefine.SCENE_TYPE.TOWN 
        or mapData.sceneType == PublicDefine.SCENE_TYPE.GUILD
        or mapData.sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE 
        or mapData.sceneType == PublicDefine.SCENE_TYPE.MANOR 
        or mapData.sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT then
        if mapData.caveMode == PublicDefine.CAVE_MODE.MODE_PET then
            printfmt("use pet pvp map")
            self.map = CaveMap:create(mapData, enableOptimization)
        else
            printfmt("use town map")
            self.map = TownMap:create(mapData, enableOptimization)
        end
    else
        if (mapData.sceneType == PublicDefine.SCENE_TYPE.BOSS) then
            enableOptimization = false
        end
        printfmt("use cave map")
        self.map = CaveMap:create(mapData, enableOptimization)
    end
    self:addChild(self.map)
    -- 注册节点事件
    self:registerNodeEvent()
    self:registerListener()
end

function MapLayer:dtor()
    if not tolua.isnull(self.map) then
        self.map:destroy()
    end
    self:unRegisterListener()
end


-- 节点onEnter处理器
function MapLayer:onEnter()
    if (DEBUG) then
        print("MapLayer onEnter:", self._type, self._inited)
    end

end

-- 节点onExit处理器
function MapLayer:onExit()
    if (DEBUG) then
        print("MapLayer onExit:")
    end

    self:dtor()
end

-- 注册节点事件
function MapLayer:registerNodeEvent()
    -- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
            self:onEnter()
        elseif (nodeEvent == "exit") then
            self:onExit()
        else end
    end
    self:registerScriptHandler(onNodeEventHandler)
end

-- 注册监听事件
function MapLayer:registerListener()
    --晃动
    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOT_SHACK, self, self.shack)
    --停止晃动
    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOT_STOP_SHACK, self, self.stopShack)
end


-- 注销监听事件
function MapLayer:unRegisterListener()
    --晃动
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOT_SHACK, self, self.shack)
    --停止晃动
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOT_STOP_SHACK, self, self.stopShack)
end


-- 视图的地图坐标到视图在地图上位置的转换
function MapLayer:coordinateToPositionAndZOrder(coordX, coordY)
    local x, y = self.map:coordinateToPosition(coordX, coordY)
    -- y = y + self.map.tileThickness

    local coordX = math.floor(coordX + 0.5)
    local coordY = math.floor(coordY + 0.5)
    local z = self.map:getZOrderByCoordinate(coordX, coordY)

    return x, y, z
end

-- 根据视图的地图坐标改变地图本身相对于parent node的位置
function MapLayer:setMapPositionByCoordinate(coordX, coordY, isSync)
    self.map:screenCenterToCoord(coordX, coordY, nil, nil, isSync)
end

function MapLayer:addViewToMap(view, coordX, coordY)
    if self.map then
        
        local sx, sy, zOrder = self:coordinateToPositionAndZOrder(coordX, coordY)
        view:setPosition(sx, sy)
        view:setLocalZOrder(zOrder)
        self.map:addNodeOnMap(view)
    else
        print("MapLayer onAddView: no map found.")
    end
end

function MapLayer:addViewToMapByOffset(view, coordX, coordY, offsetCoord)
    if self.map then
        
        local sx, sy, zOrder = self:coordinateToPositionAndZOrder(coordX, coordY)
        view:setPosition(sx+ offsetCoord.x, sy + offsetCoord.y)
        view:setLocalZOrder(zOrder)
        self.map:addNodeOnMap(view)
    else
        print("MapLayer addViewToMapByOffset: no map found.")
    end
end

-- 注册地图点击时间监听器
function MapLayer:addTouchListener(target, func)
    self._targetOfTouchListener = target
    self._funcOfTouchListener = func
end


-- 震动效果
function MapLayer:shack(shackType,time)
    print("MapLayer:shack",shackType,time)

    if self:getActionByTag(SHACKACTIONTAG) ~= nil then
        self:stopActionByTag(SHACKACTIONTAG)
        self:setPosition(cc.p(0, 0))
    end


    local x,y = self:getPosition()
    local d = 0.04
    shackType = tonumber(shackType)
    local allAction = {}

    if shackType == 1 then
        --  处理震动效果

        local amplitude = -20

        for j = 1,math.floor(time/d/4) do
            local mt1 = cc.MoveTo:create(d*2,cc.p(x, y+amplitude));
            local mt2 = cc.MoveTo:create(d*2,cc.p(x, y));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction,endActon)

    elseif shackType == 2 then

        table.insert(allAction, cc.MoveTo:create(d,cc.p(x, y-60)))
        table.insert(allAction, cc.MoveTo:create(d*2,cc.p(x, y+30)))
        table.insert(allAction, cc.MoveTo:create(d*2,cc.p(x, y-40)))
        table.insert(allAction, cc.MoveTo:create(d*3,cc.p(x, y+15)))
        table.insert(allAction, cc.MoveTo:create(d*5,cc.p(x, y)))
        table.insert(allAction, cc.MoveTo:create(d,cc.p(0, 0)))
        
    elseif shackType == 3 then
        local num = math.floor(time/d/7)
        local startX = 30
        local endX = 20
        local startY = 60
        local endY = 20

        local oneX = (startX - endX ) / num
        local oneY = (startY - endY) / num

        for j = 1,num do
            local offsetX = startX - j*oneX
            local offsetY = startY - j*oneY

            table.insert(allAction, cc.MoveTo:create(d*3,cc.p(x+offsetX, y-offsetY)))
            table.insert(allAction, cc.MoveTo:create(d*4,cc.p(x, y)))

            -- table.insert(allAction, cc.MoveTo:create(d*3,cc.p(x+20, y-30)))
            -- table.insert(allAction, cc.MoveTo:create(d*4,cc.p(x, y)))
            -- table.insert(allAction, cc.CallFunc:create(function() 
            --     print("dddddddddddd  wwww")
            -- end))
        end

        table.insert(allAction, cc.MoveTo:create(d,cc.p(0, 0)))
        
    elseif shackType == 4 then
        --  处理震动效果
        local amplitude = 5

        local startAction = cc.DelayTime:create(1000/2/GameDataManager:getInstance():getMoveSpeed())
        table.insert(allAction,startAction)

        for i=1,4,1 do
            local mt1 = cc.MoveTo:create(d,  cc.p(x+amplitude, y));
            local mt2 = cc.MoveTo:create(d,  cc.p(x, y+amplitude));
            local mt3 = cc.MoveTo:create(d,  cc.p(x-amplitude, y));
            local mt4 = cc.MoveTo:create(d,  cc.p(x, y-amplitude));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
            table.insert(allAction, mt3)
            table.insert(allAction, mt4)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction,endActon)

    elseif shackType == 5 then
        -- 用于打开密室门
        local amplitude = -20
        for j = 1,math.floor(time/d/4) do
            local mt1 = cc.MoveTo:create(d*2,cc.p(x, y+amplitude));
            local mt2 = cc.MoveTo:create(d*2,cc.p(x, y));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction,endActon)
    elseif shackType == 11 then   -- 这里是用于打击感优化的震动
        local amplitude = 2
        local time = 0.3
        local d = 0.03
        -- local startAction = cc.DelayTime:create(1000/2/GameDataManager:getInstance():getMoveSpeed())
        -- table.insert(allAction,startAction)

        for i=1,math.floor(time/(d*4)),1 do
            local mt1 = cc.MoveTo:create(d,  cc.p(x+amplitude, y));
            local mt2 = cc.MoveTo:create(d,  cc.p(x, y+amplitude));
            local mt3 = cc.MoveTo:create(d,  cc.p(x-amplitude, y));
            local mt4 = cc.MoveTo:create(d,  cc.p(x, y-amplitude));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
            table.insert(allAction, mt3)
            table.insert(allAction, mt4)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction,endActon)

    elseif shackType == 12 then
        local amplitude = 3
        local time = 0.3
        local d = 0.03
        -- local startAction = cc.DelayTime:create(1000/2/GameDataManager:getInstance():getMoveSpeed())
        -- table.insert(allAction,startAction)

        for i=1,math.floor(time/(d*4)),1 do
            local mt1 = cc.MoveTo:create(d,  cc.p(x+amplitude, y));
            local mt2 = cc.MoveTo:create(d,  cc.p(x, y+amplitude));
            local mt3 = cc.MoveTo:create(d,  cc.p(x-amplitude, y));
            local mt4 = cc.MoveTo:create(d,  cc.p(x, y-amplitude));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
            table.insert(allAction, mt3)
            table.insert(allAction, mt4)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction,endActon)
    elseif shackType == 13 then
        local amplitude = 4
        local time = 0.4
        local d = 0.04
        -- local startAction = cc.DelayTime:create(1000/2/GameDataManager:getInstance():getMoveSpeed())
        -- table.insert(allAction,startAction)

        for i=1,math.floor(time/(d*4)),1 do
            local mt1 = cc.MoveTo:create(d,  cc.p(x+amplitude, y));
            local mt2 = cc.MoveTo:create(d,  cc.p(x, y+amplitude));
            local mt3 = cc.MoveTo:create(d,  cc.p(x-amplitude, y));
            local mt4 = cc.MoveTo:create(d,  cc.p(x, y-amplitude));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
            table.insert(allAction, mt3)
            table.insert(allAction, mt4)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction,endActon)
    elseif shackType == 14 then
        local amplitude = 5
        local time = 0.64
        local d = 0.04
        -- local startAction = cc.DelayTime:create(1000/2/GameDataManager:getInstance():getMoveSpeed())
        -- table.insert(allAction,startAction)

        for i=1,math.floor(time/(d*4)),1 do
            local mt1 = cc.MoveTo:create(d,  cc.p(x+amplitude, y));
            local mt2 = cc.MoveTo:create(d,  cc.p(x, y+amplitude));
            local mt3 = cc.MoveTo:create(d,  cc.p(x-amplitude, y));
            local mt4 = cc.MoveTo:create(d,  cc.p(x, y-amplitude));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
            table.insert(allAction, mt3)
            table.insert(allAction, mt4)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction,endActon)
    
    -- 新春boss 吼叫
    elseif shackType == 20 then
        local amplitude = 5
        local time = 1.4
        local d = 0.04
        for i=1,math.floor(time/(d*4)),1 do
            local mt1 = cc.MoveTo:create(d,  cc.p(x+amplitude, y));
            local mt2 = cc.MoveTo:create(d,  cc.p(x, y+amplitude));
            local mt3 = cc.MoveTo:create(d,  cc.p(x-amplitude, y));
            local mt4 = cc.MoveTo:create(d,  cc.p(x, y-amplitude));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
            table.insert(allAction, mt3)
            table.insert(allAction, mt4)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction,endActon)
    -- 新春boss 践踏
    elseif shackType == 21 then
        -- local time = 0.5
        -- local num = math.floor(time/d/7)
        -- local startX = 30
        -- local endX = 20
        -- local startY = 60
        -- local endY = 20

        -- local oneX = (startX - endX ) / num
        -- local oneY = (startY - endY) / num

        -- for j = 1,num do
        --     local offsetX = startX - j*oneX
        --     local offsetY = startY - j*oneY

        --     table.insert(allAction, cc.MoveTo:create(d*3,cc.p(x+offsetX, y-offsetY)))
        --     table.insert(allAction, cc.MoveTo:create(d*4,cc.p(x, y)))
        -- end

        -- table.insert(allAction, cc.MoveTo:create(d,cc.p(0, 0)))

        local amplitude = 5
        local time = 0.64
        local d = 0.04
        -- local startAction = cc.DelayTime:create(1000/2/GameDataManager:getInstance():getMoveSpeed())
        -- table.insert(allAction,startAction)

        for i=1,math.floor(time/(d*4)),1 do
            local mt1 = cc.MoveTo:create(d,  cc.p(x+amplitude, y));
            local mt2 = cc.MoveTo:create(d,  cc.p(x, y+amplitude));
            local mt3 = cc.MoveTo:create(d,  cc.p(x-amplitude, y));
            local mt4 = cc.MoveTo:create(d,  cc.p(x, y-amplitude));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
            table.insert(allAction, mt3)
            table.insert(allAction, mt4)
        end

        local endActon = cc.MoveTo:create(d, cc.p(0,0));
        table.insert(allAction, endActon)

    -- 沙之眼第一次死亡后的处理逻辑
    elseif shackType == 22 then
        local amplitude = 5
        local time = 999999999
        local d = 0.04

        local actionArr = {}
        local mt1 = cc.MoveTo:create(d,  cc.p(x+amplitude, y));
        local mt2 = cc.MoveTo:create(d,  cc.p(x, y+amplitude));
        local mt3 = cc.MoveTo:create(d,  cc.p(x-amplitude, y));
        local mt4 = cc.MoveTo:create(d,  cc.p(x, y-amplitude));

        table.insert(actionArr, mt1)
        table.insert(actionArr, mt2)
        table.insert(actionArr, mt3)
        table.insert(actionArr, mt4)

        allAction = cc.RepeatForever:create(cc.Sequence:create(actionArr))

    elseif shackType == 23 then
        d = 0.02
        local num = math.floor(time/d/7)
        local startX = 30
        local endX = 20
        local startY = 60
        local endY = 20

        local oneX = (startX - endX ) / num
        local oneY = (startY - endY) / num

        for j = 1,num do
            local offsetX = startX - j*oneX
            local offsetY = startY - j*oneY

            table.insert(allAction, cc.MoveTo:create(d*3,cc.p(x+offsetX, y-offsetY)))
            table.insert(allAction, cc.MoveTo:create(d*4,cc.p(x, y)))
        end

        table.insert(allAction, cc.MoveTo:create(d,cc.p(0, 0)))
    else 
        assert(false, string.format("MapLayer:shack  shackType=%d not handle.", shackType))
    end

    if(type(allAction) == "table") then 
        local _action = cc.Sequence:create(allAction)
        _action:setTag(SHACKACTIONTAG)
        self:runAction(_action)
    else 
        allAction:setTag(SHACKACTIONTAG)
        self:runAction(allAction)
    end
end

function MapLayer:stopShack()
    if self:getActionByTag(SHACKACTIONTAG) ~= nil then
        self:stopActionByTag(SHACKACTIONTAG)
    end
    self:runAction(cc.MoveTo:create(0.01,  cc.p(0, 0)))
end

return MapLayer