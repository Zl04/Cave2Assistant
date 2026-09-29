--[[
    宽屏
]]--
require "utils.message.MessageCenter"
require "app.ui.Component"
require "app.ui.UIDes"
UI = UI or {}

local WideScreenLayer = class("WideScreenLayer", UI.HWBtnComponent)
UI.WideScreenLayer = WideScreenLayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local Scheduler = Avalon.Scheduler

-- 构造函数
function WideScreenLayer:ctor(showSkipBtn)
    WideScreenLayer.super.ctor(self, UIType.WIDE_SCREEN_LAYER,{},
        winSize.width,winSize.height)
    self:init()
end

function WideScreenLayer:dtor()
    WideScreenLayer.super.dtor(self)
end

-- public:
-- 初始化
function WideScreenLayer:init()
    print("====WideScreenLayer:init====")
    WideScreenLayer.super.init(self)

    self:setName("WideScreenLayer")
end


-- 初始化组件视图
function WideScreenLayer:onInitView(data)
    self.topColorLayer = cc.LayerColor:create(cc.c4b(0,0,0,255))
    self.topColorLayer:setPosition(cc.p(0,winSize.height - 100))
    self.topColorLayer:setContentSize(winSize.width,100)
    self:addChild(self.topColorLayer)

    self.bottomColorLayer = cc.LayerColor:create(cc.c4b(0,0,0,255))
    self.bottomColorLayer:setPosition(cc.p(0,0))
    self.bottomColorLayer:setContentSize(winSize.width,100)
    self:addChild(self.bottomColorLayer)

    if showSkipBtn == 1 then

        local btnSkip = UI.Button:create()
        btnSkip:init()
        btnSkip:rightBottom(0, 20)
        btnSkip:setSize(200, 60)
        btnSkip:setFontSize(25)
        btnSkip:setText(UI.TEXT_111029)
        btnSkip:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            --TODO 这里需要处理宽屏跳过的类型
            GameManager:bossSkipScenario(2)
        end)
        self.bottomColorLayer:addChild(btnSkip, 10)
    end
end

-- 更新组件视图
function WideScreenLayer:onUpdateView(data)
    -- print(self:getPositionX(),self:getPositionY())
end


function WideScreenLayer:showWideScreenLayer(time)
    self.topColorLayer:stopAllActions()
    self.topColorLayer:runAction(cc.MoveTo:create(time,cc.p(0,winSize.height - 100)))

    self.bottomColorLayer:stopAllActions()
    self.bottomColorLayer:runAction(cc.MoveTo:create(time,cc.p(0,0)))
end

function WideScreenLayer:hideWideScreenLayer(time)
    self.topColorLayer:stopAllActions()
    self.topColorLayer:runAction(cc.MoveTo:create(time,cc.p(0,winSize.height)))

    self.bottomColorLayer:stopAllActions()
    self.bottomColorLayer:runAction(cc.MoveTo:create(time,cc.p(0,-100)))
end




