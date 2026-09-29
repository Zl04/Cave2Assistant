------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RallyBoatEffectView = class("RallyBoatEffectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_rally.plist",
    "ui_town_navigation.plist",
    "ui_town_greatnavigation.plist",
}
local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function RallyBoatEffectView:ctor(data)
    RallyBoatEffectView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    print("RallyBoatEffectView:ctor boatID = ", data)
    self._boatID = data.boatID
    self._eventData = data.eventData

    self:bindModel()
end

function RallyBoatEffectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bet", "Bet", false)
    RallyBoatEffectView.super.init(self, ... )
end

function RallyBoatEffectView:dtor()
    RallyBoatEffectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bet.RallyBoatEffectView")
end


function RallyBoatEffectView:onInitView()
    self:setTouchEnable(false)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local animation = UI.Animation:create()
    animation:init("effect_ui_lalisai_ship.json", "effect_ui_lalisai_ship.atlas", 1, 1)
    animation:center()
    animation._spine:setSkin("ship"..self._boatID)
    animation:setAnimation(self._eventData.eventSpine, false)
    print("RallyBoatEffectView:onInitView boatID")
    animation:addEventListener(UIEvent.ANIMATION_END,self,function()
        UI.ScrollBar:createByText(languageManagerInstance:getLocalString(self._eventData.eventResultDes))
        self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(function()
            mvc.closePanel("Bet", "RallyBoatEffect")
        end)))
    end)
    self:addChild(animation, 1)
    -- animation:setTimeScale(3)

    
    -- local delayAction = cc.DelayTime:create(1)
    -- local finish = cc.CallFunc:create(function()
    --     UI.ScrollBar:createByText(languageManagerInstance:getLocalString(self._eventData.eventResultDes))
    -- end)
    -- local action = cc.Sequence:create(delayAction, finish)
    
    -- self:runAction(action)
end


function RallyBoatEffectView:bindModel()

end


function RallyBoatEffectView:unbindModel()

end





return RallyBoatEffectView












