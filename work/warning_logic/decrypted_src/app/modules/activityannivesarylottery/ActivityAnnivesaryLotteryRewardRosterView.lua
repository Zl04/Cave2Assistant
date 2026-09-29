------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityAnnivesaryLotteryRewardRosterView = class("ActivityAnnivesaryLotteryRewardRosterView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_activity_anniversary.plist"
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 767
local COM_HEIGHT = 379

function ActivityAnnivesaryLotteryRewardRosterView:ctor(data)
    ActivityAnnivesaryLotteryRewardRosterView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function ActivityAnnivesaryLotteryRewardRosterView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activityannivesarylottery", "ActivityAnnivesaryLottery", false)
    ActivityAnnivesaryLotteryRewardRosterView.super.init(self, ... )
end

function ActivityAnnivesaryLotteryRewardRosterView:dtor()
    ActivityAnnivesaryLotteryRewardRosterView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activityannivesarylottery.ActivityAnnivesaryLotteryRewardRosterView")
end


function ActivityAnnivesaryLotteryRewardRosterView:onInitView()
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
    bg:init("ui_anniversary_bg_8.png")
    bg:center()
    contentLayout:addChild(bg)
    self.bg = bg

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223622, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(8, 15)
    contentLayout:addChild(titleText)
    self.titleText = titleText

    self:addRewardRoster()
end

function ActivityAnnivesaryLotteryRewardRosterView:addRewardRoster()
    -- 内容面板
    local rosterLayout = UI.Layout:create();
    rosterLayout:init()
    rosterLayout:setSize(280, 220)
    rosterLayout:center(15, 20)
    self.contentLayout:addChild(rosterLayout)

    local roster = mvc.activityAnnivesaryLotteryModel:getLotteryRewardRosterByType(self.data.signType)
    -- roster.luckName = {
    --     "达到顶峰萨维斯",
    --     "挂号费发个图",
    --     "BVR都敢哥哥",
    --     "了看就看撒",
    --     "第三方的撒谎"
    -- }
    if roster.luckName then
        for k, v in pairs(roster.luckName) do
            local name = UI.Text:create()
            name:init(v, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
            name:centerUp(-40+k*45)
            rosterLayout:addChild(name)
        end
    end
end

function ActivityAnnivesaryLotteryRewardRosterView:bindModel()

end


function ActivityAnnivesaryLotteryRewardRosterView:unbindModel()

end





return ActivityAnnivesaryLotteryRewardRosterView












