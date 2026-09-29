------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/21
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityAnnivesaryLotteryRewardView = class("ActivityAnnivesaryLotteryRewardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_activity_anniversary.plist"
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 818
local COM_HEIGHT = 282

function ActivityAnnivesaryLotteryRewardView:ctor(data)
    ActivityAnnivesaryLotteryRewardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function ActivityAnnivesaryLotteryRewardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activityannivesarylottery", "ActivityAnnivesaryLottery", false)
    ActivityAnnivesaryLotteryRewardView.super.init(self, ... )
end

function ActivityAnnivesaryLotteryRewardView:dtor()
    ActivityAnnivesaryLotteryRewardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activityannivesarylottery.ActivityAnnivesaryLotteryRewardView")
end


function ActivityAnnivesaryLotteryRewardView:onInitView()
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
    bg:init("")
    bg:center()
    contentLayout:addChild(bg)
    self.bg = bg

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223620, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(120)
    contentLayout:addChild(titleText)
    self.titleText = titleText

    local joinBtn = UI.Button:create();
    joinBtn:init("ui_anniversary_btn_4.png","ui_anniversary_btn_4.png","ui_anniversary_btn_4.png");
    joinBtn:centerBottom(-65)
    joinBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_50_50_44)
    
    joinBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:onJoinBtnClick()
    end)
    contentLayout:addChild(joinBtn)
    self.joinBtn = joinBtn


    local showRosterBtn = UI.Button:create();
    showRosterBtn:init("ui_anniversary_btn_5.png","ui_anniversary_btn_5.png","ui_anniversary_btn_5.png");
    showRosterBtn:centerBottom(-65, 280)
    showRosterBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    showRosterBtn:setText(UI.TEXT_223622)
    showRosterBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:onShowRewardRoster()
    end)
    contentLayout:addChild(showRosterBtn)
    self.showRosterBtn = showRosterBtn
    
    Net.NetActivitySystem:requestAnnivesaryLotteryReadReward(self.data.ID)
    
    self:updateRewardView()
end

function ActivityAnnivesaryLotteryRewardView:updateRewardView()
    local anniversaryLotteryData = self.data or mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryRewardStateData()

    -- if anniversaryLotteryDatarewardState == 0 then
    --     return
    -- end
    local config = ConfigManager:getAllAnniversaryLuckyDrawDataByID(anniversaryLotteryData.signType)
    local animeName = ""
    if anniversaryLotteryData.rewardState == 1 then
        self.bg:setSpriteName("ui_anniversary_bg_6.png")
        self.titleText:setText(UI.TEXT_223607)
        self.titleText:setFontColor(UI.FONT_COLOR_255_216_81)
        animeName = "effect_ui_luckdraw_4th_guang"
        if anniversaryLotteryData.isGetReward then
            self.joinBtn:setText(UI.TEXT_1110721)
        else
            self.joinBtn:setText(UI.TEXT_223609)
        end
        
    elseif anniversaryLotteryData.rewardState == 2 then
        self.bg:setSpriteName("ui_anniversary_bg_5.png")
        self.titleText:setText(UI.TEXT_223608)
        self.titleText:setFontColor(UI.FONT_COLOR_192_185_255)
        animeName = "effect_ui_luckdraw_4th_fail"
        self.joinBtn:setText(UI.TEXT_223610)

        local img  = UI.Image:create()
        img:init("ui_anniversary_decorate_cry.png")
        img:centerUp(-150, 30)
        self.contentLayout:addChild(img)
    end

    local anime = UI.Animation:create()
    anime:init(animeName..".json", animeName..".atlas", 1);
    if anniversaryLotteryData.rewardState == 1 then
        anime:centerUp(-20)
    elseif anniversaryLotteryData.rewardState == 2 then
        anime:centerUp(-20, -70)
    end
    
    self.contentLayout:addChild(anime)
    anime:setAnimation("idle", true)
    self.anime = anime

    self:addDesScrollView()
end

function ActivityAnnivesaryLotteryRewardView:addDesScrollView()
    local anniversaryLotteryData = self.data or mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryRewardStateData()
    local config = ConfigManager:getAllAnniversaryLuckyDrawDataByID(anniversaryLotteryData.signType)
    local height = 100
    local width = 480
    local desID
    
    local desText = UI.Text:create()
    desText:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    desText:setWidth(width)
    -- desText:setSize(width, height)
    desText:setTextCenter()
    desText:autoAdapt()
    if anniversaryLotteryData.rewardState == 1 then
        desID = config.awardPushDes
        desText:setFontColor(UI.FONT_COLOR_242_200_219)
    elseif anniversaryLotteryData.rewardState == 2 then
        desID = config.failPushDes
        desText:setFontColor(UI.FONT_COLOR_183_189_223)
    end
    local desStr = languageManagerInstance:getLocalString(desID)
    desText:setText(desStr)

    if(desText:getContentSize().height <= height) then 
        desText:centerBottom(20)
        self.contentLayout:addChild(desText)
    else
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(width, desText:getContentSize().height)
        desText:centerUp(3)
        layout:addChild(desText)

        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(width, height)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(layout)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarWidth(5)
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(2, 0))
        detailedScrollView:setName("Item")
        detailedScrollView:centerBottom(20)

        self.contentLayout:addChild(detailedScrollView)
    end
end

function ActivityAnnivesaryLotteryRewardView:onJoinBtnClick()
    local anniversaryLotteryData = self.data or mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryRewardStateData()
    if not anniversaryLotteryData then
        UI.ScrollBar:createByText(UI.TEXT_223615)
        return
    end
    if anniversaryLotteryData.isGetReward then
        UI.ScrollBar:createByText(UI.TEXT_1110721)
        return
    end
    if anniversaryLotteryData.rewardState == 1 then
        mvc.send("ActivityAnnivesary_Open_Main_View")
    elseif anniversaryLotteryData.rewardState == 2 then
        -- mvc.send("ActivityAnnivesary_Open_Main_View")
        Avalon.MessageCenter:notice(GameMessage.MC_TASK_SHOW_MAILLAYER, 0, PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_None)
    end
end

function ActivityAnnivesaryLotteryRewardView:onShowRewardRoster()
    local rosterData = mvc.activityAnnivesaryLotteryModel:getLotteryRewardRosterByType(self.data.signType)
    if rosterData and rosterData.luckName then
        mvc.openPanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryRewardRoster", self.data)
    else
        Net.NetActivitySystem:requestAnnivesaryLotteryCheckRewardRoster(self.data.ID)
        UI.ScrollBar:createByText(UI.TEXT_223623)
    end
end

function ActivityAnnivesaryLotteryRewardView:bindModel()

end


function ActivityAnnivesaryLotteryRewardView:unbindModel()

end





return ActivityAnnivesaryLotteryRewardView












