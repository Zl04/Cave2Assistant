--[[
    这里的城镇地图用于新版城镇，公会，家园的场景
]]
local GameDataManager = require("app.game.GameDataManager")
local GameDataManager = require("app.game.GameDataManager")
require "utils.Scheduler"
require "app.ui.minimap.MapGrid"

local MapTownLayer = class("MapTownLayer", UI.Component)

local winSize = cc.Director:getInstance():getWinSize()

local SHACKACTIONTAG = 1001

function MapTownLayer:ctor(mapData)
    -- bg:setScale(scale)

    --TODO 添加背景图片
    print("MapTownLayer:ctor(", mapData)
    Avalon.ResHelper:loadPlistSync("map_townscene.plist")
    local bg = UI.Image:create()
    bg:init(mapData.BGID)
    bg:center()
    self:addChild(bg)
    self.bg = bg

    local bgWidth, bgHeight = bg:getContentSize().width, bg:getContentSize().height
    local scale = ToolsUtil:getAdaptationMaxScaleForBg(bgWidth, bgHeight)
    bg:setScale(scale)
    
    -- 生成装饰物
    local decorationLayer = UI.Layout:create()
    decorationLayer:init()
    decorationLayer:setSize(0, 0)
    decorationLayer:center()
    bg:addChild(decorationLayer, 10)
    self.decorationLayer = decorationLayer

    -- 生成装饰物等

    -- DecorationIDlist = "ui_maincity_btn2_setup.png;ui_maincity_btn2_special_selected.png",  
    -- DecorationCoordinate = "-110,-210;210,-210",  
    --DecorationLayer = "1;3",  
    if(mapData.DecorationIDlist ~= "" and mapData.DecorationCoordinate ~= "" and mapData.DecorationLayer ~= "") then 
        local nameArr = string.split(mapData.DecorationIDlist, ";")
        local coordArr = string.split(mapData.DecorationCoordinate, ";")
        local indexArr = string.split(mapData.DecorationLayer, ";")
        if(#nameArr == #coordArr and #coordArr == #indexArr) then 
            for index,v in ipairs(nameArr) do
                local coords = string.split(coordArr[index], ",")

                local decorationImage = UI.Image:create()
                decorationImage:init(v)
                decorationImage:setLocalZOrder(tonumber(indexArr[index]))
                decorationImage:leftBottom(tonumber(coords[1]), tonumber(coords[2]))
                self.decorationLayer:addChild(decorationImage)
            end
        else
            printError("MapTownLayer ProfileClientTownMap.lua  id=%d DecorationIDlist,DecorationCoordinate, DecorationLayer number is not equal.") 
        end
    else
        printError("MapTownLayer ProfileClientTownMap.lua  id=%d DecorationIDlist,DecorationCoordinate, DecorationLayer must not nil.") 
    end


    -- 生成效果层
    local effectLayer = UI.Layout:create()
    effectLayer:init()
    effectLayer:setSize(bgWidth, bgHeight)
    effectLayer:center()
    bg:addChild(effectLayer, 100)
    self.effectLayer = effectLayer

    -- npc 通过model 生成

    -- 注册节点事件
    self:registerNodeEvent()
    self:registerListener()
end

function MapTownLayer:dtor()
    if not tolua.isnull(self.map) then
        self.map:destroy()
    end
    self:unRegisterListener()
end


-- 节点onEnter处理器
function MapTownLayer:onEnter()
    if (DEBUG) then
        print("MapTownLayer onEnter:", self._type, self._inited)
    end

end

-- 节点onExit处理器
function MapTownLayer:onExit()
    if (DEBUG) then
        print("MapTownLayer onExit:")
    end

    self:dtor()
end

function MapTownLayer:getBG()
    return self.bg
end

function MapTownLayer:getDecorationLayer()
    return self.decorationLayer
end

function MapTownLayer:getEffectLayer()
    return self.effectLayer
end

-- 注册节点事件
function MapTownLayer:registerNodeEvent()
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
function MapTownLayer:registerListener()
    --晃动
    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOT_SHACK, self, self.shack)
    --停止晃动
    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOT_STOP_SHACK, self, self.stopShack)
end


-- 注销监听事件
function MapTownLayer:unRegisterListener()
    --晃动
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOT_SHACK, self, self.shack)
    --停止晃动
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOT_STOP_SHACK, self, self.stopShack)
end

function MapTownLayer:addTouchEffect(screenPosition)
    local mapPosition = self.effectLayer:convertToNodeSpace(screenPosition)

    local deformationAnimation = Avalon.Animation:create("effect_ui_common_town_point.json", "effect_ui_common_town_point.atlas", 1)
    deformationAnimation:setAnimation(0, "point", false)
    -- Avalon.AudioManager:playSound("553")

    deformationAnimation:registerSpineEventHandler(function (event)
        deformationAnimation:runAction(cc.RemoveSelf:create())
    end, sp.EventType.ANIMATION_END)

    deformationAnimation:setPosition(mapPosition.x, mapPosition.y)

    self.effectLayer:addChild(deformationAnimation, 300)
end


function MapTownLayer:coverToBgPosition(screenPosition)
    if(self.bg) then 
        return self.bg:convertToNodeSpace(screenPosition)
    end

    return screenPosition
end

function MapTownLayer:coverToBgPositionForCenter(screenPosition)
    if(self.bg) then 
        local touchPosition = self.bg:convertToNodeSpace(screenPosition)
        return {x = touchPosition.x - self.bg:getContentSize().width/2, y = touchPosition.y - self.bg:getContentSize().height/2}
    end

    return screenPosition
end

-- 视图的地图坐标到视图在地图上位置的转换
function MapTownLayer:coordinateToPositionAndZOrder(coordX, coordY)
    local x, y = self.map:coordinateToPosition(coordX, coordY)
    -- y = y + self.map.tileThickness

    local coordX = math.floor(coordX + 0.5)
    local coordY = math.floor(coordY + 0.5)
    local z = self.map:getZOrderByCoordinate(coordX, coordY)

    return x, y, z
end

-- 根据视图的地图坐标改变地图本身相对于parent node的位置
function MapTownLayer:setMapPositionByCoordinate(coordX, coordY, isSync)
    self.map:screenCenterToCoord(coordX, coordY, nil, nil, isSync)
end

function MapTownLayer:addViewToMap(view, x, y, zOrder)
    if self.decorationLayer then
        view:setPosition(x, y)
        view:setLocalZOrder(zOrder)
        self.decorationLayer:addChild(view)
    else
        print("MapTownLayer onAddView: no map found.")
    end
end

function MapTownLayer:addViewToMapForLayout(view, x, y, zOrder)
    if self.decorationLayer then
        view:leftBottom(x, y)
        view:setLocalZOrder(zOrder)
        self.decorationLayer:addChild(view)
        -- print("fdddddddddddddddddddd= addViewToMap", x, y, zOrder)
    else
        print("MapTownLayer onAddView: no map found.")
    end
end

-- 注册地图点击时间监听器
function MapTownLayer:addTouchListener(target, func)
    self._targetOfTouchListener = target
    self._funcOfTouchListener = func
end


-- 震动效果
function MapTownLayer:shack(shackType,time)
    print("MapTownLayer:shack",shackType,time)

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
    else 
        assert(false, string.format("MapTownLayer:shack  shackType=%d not handle.", shackType))
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

function MapTownLayer:stopShack()
    if self:getActionByTag(SHACKACTIONTAG) ~= nil then
        self:stopActionByTag(SHACKACTIONTAG)
    end
    self:runAction(cc.MoveTo:create(0.01,  cc.p(0, 0)))
end


---------------------用于处理测试调试信息-------------------------

function MapTownLayer:drawRectInBg(rectPoint, drawColor)
    print("MapTownLayer:drawRectInBg", rectPoint, drawColor)
    if (not self._drawNode) then
        self._drawNode = cc.DrawNode:create()
        self.decorationLayer:addChild(self._drawNode, 1000000)
    end

    drawColor = drawColor or UI.WHITE

    if(rectPoint and #rectPoint == 4) then
        if (self._drawNode) then
            self._drawNode:drawRect(
                rectPoint[1],rectPoint[2],rectPoint[3],rectPoint[4],
                drawColor
            )
        end
    end
end


return MapTownLayer