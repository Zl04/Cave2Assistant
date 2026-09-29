--[[
    屏蔽层
]]--

require "app.ui.Component"
UI = UI or {}

local ShieldingLayer = class("ShieldingLayer", UI.HWBtnComponent)
UI.ShieldingLayer = ShieldingLayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local Scheduler = Avalon.Scheduler


function ShieldingLayer:shielding()
    -- print("ShieldingLayer:shielding")
    local scene = cc.Director:getInstance():getRunningScene()
    local pShieldingLayer = scene:getChildByName("shieldingLayer")
    if not pShieldingLayer then
        pShieldingLayer = UI.ShieldingLayer:create(100000)
        pShieldingLayer:center()
        pShieldingLayer:setName("shieldingLayer")
        cc.Director:getInstance():getRunningScene():addChild(pShieldingLayer,10000);
    end
    pShieldingLayer:setSwallowTouches(true);
    performWithDelay(pShieldingLayer,function()
        -- UI.ScrollBar:createByText("时间到,自动取消屏蔽层,请考虑服务器是否有返回")
        self:noShielding()
    end,10)
    return pShieldingLayer
end

function ShieldingLayer:noShielding()
    -- print("ShieldingLayer:noShielding")
    local scene = cc.Director:getInstance():getRunningScene()
    local pShieldingLayer = scene:getChildByName("shieldingLayer")
    if pShieldingLayer ~= nil then
        pShieldingLayer:setSwallowTouches(false);
        pShieldingLayer:stopAllActions()
    end
    return pShieldingLayer
end


-- 构造函数
function ShieldingLayer:ctor()
    ShieldingLayer.super.ctor(self, UIType.SHIELDING_LAYER,{},
        winSize.width,winSize.height)
    self:init()
end

function ShieldingLayer:dtor()
    ShieldingLayer.super.dtor(self)
end

-- public:
-- 初始化
function ShieldingLayer:init()
    print("====ShieldingLayer:init====")

    ShieldingLayer.super.init(self)

    self:setTouchEnable(true);
    self:setInterceptTouches(true);

end


-- 初始化组件视图
function ShieldingLayer:onInitView(data)

end

-- 更新组件视图
function ShieldingLayer:onUpdateView(data)

end

