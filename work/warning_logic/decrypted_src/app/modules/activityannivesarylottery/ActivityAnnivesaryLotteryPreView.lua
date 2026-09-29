------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/21
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityAnnivesaryLotteryPreView = class("ActivityAnnivesaryLotteryPreView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_activity_anniversary.plist"
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 593
local COM_HEIGHT = 475

function ActivityAnnivesaryLotteryPreView:ctor(data)
    ActivityAnnivesaryLotteryPreView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.config = ConfigManager:getAllAnniversaryLuckyDrawDataByID(1)
    self:bindModel()
end

function ActivityAnnivesaryLotteryPreView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activityannivesarylottery", "ActivityAnnivesaryLottery", false)
    ActivityAnnivesaryLotteryPreView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        mvc.closePanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryPre")
    end)
end

function ActivityAnnivesaryLotteryPreView:dtor()
    ActivityAnnivesaryLotteryPreView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activityannivesarylottery.ActivityAnnivesaryLotteryPreView")
end


function ActivityAnnivesaryLotteryPreView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init(self.config.pushDisplay)
    bg:center()
    contentLayout:addChild(bg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223620, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(55, 10)
    contentLayout:addChild(titleText)

    local str = languageManagerInstance:getLocalString(self.config.pushDes)
    local des = UI.Text:create()
    des:init(str, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    des:setSize(275, 75)
    des:setTextLeft()
    des:centerBottom(105, 10)
    contentLayout:addChild(des)

    local joinBtn = UI.Button:create();
    joinBtn:init("ui_anniversary_btn_2.png","ui_anniversary_btn_2.png","ui_anniversary_btn_2.png");
    joinBtn:centerBottom(-5, 10)
    joinBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    joinBtn:setText(UI.TEXT_223606)
    joinBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:onJoinBtnClick()
    end)
    contentLayout:addChild(joinBtn)
    self.joinBtn = joinBtn
end

function ActivityAnnivesaryLotteryPreView:onJoinBtnClick()
    mvc.send("ActivityAnnivesary_Open_Main_View")
end

function ActivityAnnivesaryLotteryPreView:bindModel()

end


function ActivityAnnivesaryLotteryPreView:unbindModel()

end





return ActivityAnnivesaryLotteryPreView












