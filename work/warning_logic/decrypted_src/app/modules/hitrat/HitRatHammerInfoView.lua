------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/16
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local HitRatHammerInfoView = class("HitRatHammerInfoView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_festival_hitrat.plist",
    "ui_general_friends.plist",
}

local COM_WIDTH = 400
local COM_HEIGHT = 134

function HitRatHammerInfoView:ctor()
    HitRatHammerInfoView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function HitRatHammerInfoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.hitrat", "HitRat", false)
    HitRatHammerInfoView.super.init(self, ... )
end

function HitRatHammerInfoView:dtor()
    HitRatHammerInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.hitrat.HitRatHammerInfoView")
end


function HitRatHammerInfoView:onInitView()
    -- 标题背景
    local bg = UI.Image:create()
    bg:init("ui_information_headframe_bottom.png")
    bg:center()
    self:addChild(bg, 10)
    local pBg = UI.Image:create()
    pBg:init("ui_hitrat_frame _0.png")
    pBg:center()
    bg:addChild(pBg, 10)
    
    local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_hitrat_frame _1.png"))
    timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    timer:setPosition(cc.p(36,36))
    timer:setPercentage(0)
    bg:addChild(timer) 
    self.timer = timer
    local hammerIcon = UI.Image:create()
    hammerIcon:init("ui_hitrat_icon_".. mvc.hitRatModel:getHammerId() ..".png")
    hammerIcon:center()
    hammerIcon:setScale(0.4)
    bg:addChild(hammerIcon, 10)
    self.hammerIcon = hammerIcon

    self.hotImg = UI.Image:create()
    self.hotImg:init("ui_friends_shield.png")
    self.hotImg:center()
    bg:addChild(self.hotImg, 11)

    self.hotImg:setVisible(mvc.hitRatModel:isOverloadHot())

    self:createInfoContentLayer()

    self:updateHammerCountDown()
end

function HitRatHammerInfoView:updateHammerCountDown()
    if self.hammerCountDownTimer then
        self.hammerCountDownTimer:removeFromParent()
        self.hammerCountDownTimer = nil
    end
    if mvc.hitRatModel:getHammerId() ~= 1 then
        local com = UI.Component:create()
        com:init()
        com:centerBottom(7)
        self:addChild(com)
        local per, countdown = mvc.hitRatModel:getHammerCountDownPer()

        local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_hitrat_strip.png"))
        timer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        timer:setPercentage(per * 100)
        timer:setMidpoint(cc.p(0.5, 0.5))
        timer:setBarChangeRate(cc.p(1, 0))
        com:addChild(timer) 
        local action = cc.ProgressTo:create(countdown, 0) 
        timer:runAction(action)
        self.hammerCountDownTimer = com
    end
end

function HitRatHammerInfoView:createInfoContentLayer()
    local hammerId = mvc.hitRatModel:getHammerId()
    local img = UI.Image:create()
    img:init("ui_hitrat_particulars_".. hammerId ..".png")
    img:center(-135, 5)
    self:addChild(img, 10)
    self.hammerAreaImg = img


    

    local hammerName = UI.Text:create()
    hammerName:init(mvc.hitRatModel:getHammerName(), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    hammerName:centerUp(4)
    img:addChild(hammerName)

    self.hammerName = hammerName
end

function HitRatHammerInfoView:hotValChanged()
    local per, time = mvc.hitRatModel:getHotValuePer()
    self.timer:setPercentage(per*100)
    local action = cc.ProgressTo:create(time, 0) 
    self.timer:runAction(action)
end

function HitRatHammerInfoView:isHotActChanged(isHotAct)
    self.hotImg:setVisible(isHotAct)
end

function HitRatHammerInfoView:hammerChanged(idx)
    self.hammerIcon:setSpriteName("ui_hitrat_icon_".. idx ..".png")
    self.hammerAreaImg:setSpriteName("ui_hitrat_particulars_".. idx ..".png")
    local name = mvc.hitRatModel:getHammerName()
    self.hammerName:setText(name)
    if idx ~= 1 then
        UI.ScrollBar:createByText(string.format(UIUtil:lang(1112947), name))
    end
    self:updateHammerCountDown()
end

function HitRatHammerInfoView:bindModel()
    mvc.hitRatModel:bind("hotValue",self, self.hotValChanged)
    mvc.hitRatModel:bind("hammerId",self, self.hammerChanged)
    mvc.hitRatModel:bind("isHotAct",self, self.isHotActChanged)
end


function HitRatHammerInfoView:unbindModel()
    mvc.hitRatModel:unbind("hotValue",self, self.hotValChanged)
    mvc.hitRatModel:unbind("hammerId",self, self.hammerChanged)
    mvc.hitRatModel:unbind("isHotAct",self, self.isHotActChanged)
end





return HitRatHammerInfoView












