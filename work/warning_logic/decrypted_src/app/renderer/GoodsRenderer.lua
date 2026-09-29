--[[
    物品的渲染器
]]--

require "app.renderer.Renderer"
require "app.object.geometric.GeometricModel"

local computeSpeedComp =  Geome.computeSpeedComp

Renderer = Renderer or {}

local GoodsRenderer = class("GoodsRenderer", Renderer.Base)
Renderer.GoodsRenderer = GoodsRenderer

-- private:
local DEBUG = false

local ATTRIBUTE_COMPONENT = {
}

-- 构造函数
function GoodsRenderer:ctor()
    GoodsRenderer.super.ctor(self)

    self._goodsAnimation = nil

    self._viewNode:setScale(0.5)
    self._flySpeed = 400
end

-- 析构函数
function GoodsRenderer:dtor()
    -- print(string.format("GoodsRenderer destructor: destroy the GoodsRenderer %s.", self)) 
    GoodsRenderer.super.dtor(self)

    self._goodsAnimation = nil
    self._startToFly = false
end

-- 初始化
function GoodsRenderer:init(iconName)
    self._fromRenderer = nil
    self._toRenderer = nil
    self._fromMount = nil
    self._toMount = nil

    self._startPosX = 0
    self._startPosY = 0
    self._startToFly = false
    assert(iconName,string.format("GoodsRenderer:init  iconName=%s",iconName))
    self._iconName = iconName

    if DEBUG then
        print("GoodsRenderer:init  iconName=",iconName)
    end

    -- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if DEBUG then
            print(" GoodsRenderer:ctor ",nodeEvent)
        end
        if (nodeEvent == "enter") then
            Avalon.ResHelper:beginLoading(self, self._onLoadedResList)
            for k,v in pairs(ATTRIBUTE_COMPONENT) do 
                Avalon.ResHelper:pushPlist(v)
            end
            Avalon.ResHelper:endLoading()
        elseif (nodeEvent == "exit") then
            
        elseif nodeEvent == "cleanup" then
            for k,v in pairs(ATTRIBUTE_COMPONENT) do 
                -- Avalon.ResHelper:unloadPlist(v)
            end
        end
    end
    self._viewNode:registerScriptHandler(onNodeEventHandler)
end

-- 设置待机视图
function GoodsRenderer:idle()

end

-- 设置获取物品的状态
function GoodsRenderer:setFlyState(openWithSelf,startPosX, startPosY, toRenderer, toMount,fromMonster)
    if DEBUG then
        print("GoodsRenderer:setFlyState ",startPosX, startPosY)
    end
    self._toRenderer = toRenderer
    self._toMount = toMount

    self._openWithSelf = openWithSelf

    if self._openWithSelf == false then
        self._startPosX = startPosX
        self._startPosY = startPosY + 140
        self:setPosition(self._startPosX, self._startPosY)

        local delayAction = cc.DelayTime:create(0.5)
        local finish = cc.CallFunc:create(function()
            if DEBUG then
                print("GoodsRenderer:setFlyState   finish")
            end
            self._startToFly = true
        end)
        local action = cc.Sequence:create(delayAction,finish)
        self._viewNode:runAction(action)
    else
        local offsetY = 15
        if fromMonster then
            offsetY = 50
        end


        self._startPosX = startPosX
        self._startPosY = startPosY + offsetY + 50
        -- TODO 需要判断是否为怪物掉落
        self:setPosition(startPosX, startPosY+offsetY)
        
        local upAction = cc.MoveTo:create(1.6,cc.p(self._startPosX,self._startPosY))
        local finish = cc.CallFunc:create(function()
            if DEBUG then 
                print("GoodsRenderer:setFlyState   finish")
            end
            self._startToFly = true
        end)
        local action = cc.Sequence:create(upAction,finish)
        self._viewNode:runAction(action)
    end


end

-- 渲染
function GoodsRenderer:onDraw(dt)
    if (self._startToFly and self._loadResourceEnd) then
        self._flySpeed = self._flySpeed + 40

        local startPosX, startPosY = self._startPosX, self._startPosY
        local endPosX, endPosY = self._toRenderer:getPositionOfSlot(self._toMount)

        -- 计算方向上上的速度
        local startCoord = {x=startPosX,y=startPosY,z = 0}
        local endCoord = {x = endPosX,y=endPosY,z=0}
        local speedX,speedY,speedZ = computeSpeedComp(startCoord,endCoord,self._flySpeed)

        local offsetX = dt * speedX
        local offsetY = dt * speedY

        local xCha = endPosX - startPosX
        if math.abs(xCha) > math.abs(offsetX) then
            startPosX = startPosX + offsetX
            startPosY = startPosY + offsetY
        else
            startPosX = startPosX + xCha
            startPosY = startPosY + (endPosY-startPosY)

            -- 处理到达效果
            local scaleTo = cc.ScaleTo:create(0.1,0.1)
            local finish = cc.CallFunc:create(function()
                self:remove()
            end)
            if self._goodsAnimation and (not tolua.isnull(self._goodsAnimation)) then
                self._goodsAnimation:runAction(cc.Sequence:create(scaleTo,finish))
            else
                assert(false)
            end
            self._startToFly = false
        end

        self:setPosition(startPosX, startPosY)

        self._startPosX = startPosX
        self._startPosY = startPosY
    end
end

function GoodsRenderer:_onLoadedResList()
    -- TODO 加载资源完成
    self._loadResourceEnd = true

    self._goodsAnimation = cc.Sprite:createWithSpriteFrameName(self._iconName)

    if (self._goodsAnimation) then
        self:addChild(self._goodsAnimation)

        self._goodsAnimation:setOpacity(0)
        self._goodsAnimation:setScale(0.01)
        local fadeInAction = cc.FadeIn:create(0.3)
        -- 这里放大，由于挂载点缩小了
        local scaleTo = cc.ScaleTo:create(0.3,1.8)
        self._goodsAnimation:runAction(cc.Spawn:create(scaleTo,fadeInAction))
    else
        assert(false, string.format("[ERROR] GoodsRenderer init: create goods animation (%s,%s,%f) failed.", skeletonFile, atlasFile, scale))
    end
end
