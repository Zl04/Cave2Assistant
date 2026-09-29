------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityAnnivesaryLotteryView = class("ActivityAnnivesaryLotteryView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 620
local COM_HEIGHT = 500

function ActivityAnnivesaryLotteryView:ctor()
    ActivityAnnivesaryLotteryView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)
    self:bindModel()
end

function ActivityAnnivesaryLotteryView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activityannivesarylottery", "ActivityAnnivesaryLottery", false)
    ActivityAnnivesaryLotteryView.super.init(self, ... )
    cc.UserDefault:getInstance():setBoolForKey("annivesaryLotteryShow", true)
end

function ActivityAnnivesaryLotteryView:dtor()
    ActivityAnnivesaryLotteryView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activityannivesarylottery.ActivityAnnivesaryLotteryView")
end


function ActivityAnnivesaryLotteryView:onInitView()
    local anniversaryLotteryData = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryData(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223602, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:center(50, 16)
    contentLayout:addChild(titleText)

    local petDetailBtn = UI.Button:create();
    petDetailBtn:init("ui_anniversary_check.png","ui_anniversary_check.png","ui_anniversary_check.png");
    petDetailBtn:center(-165, 200)
    petDetailBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    petDetailBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:showPetDetail()
    end)
    contentLayout:addChild(petDetailBtn)
    self.petDetailBtn = petDetailBtn

    local joinBtn = UI.Button:create();
    joinBtn:init("ui_anniversary_btn.png","ui_anniversary_btn.png","ui_anniversary_btn.png");
    joinBtn:center(70, 210)
    joinBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    joinBtn:setText(UI.TEXT_223603)
    joinBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:onJoinBtnClick()
    end)
    contentLayout:addChild(joinBtn)
    self.joinBtn = joinBtn
    
    local signDate = UI.Text:create()
    signDate:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    signDate:center(80, 156)
    contentLayout:addChild(signDate)
    self.signDate = signDate

    self:addRewardNode(anniversaryLotteryData)
    self:addDesScrollView()
    self:updateJoinBtn()
end

function ActivityAnnivesaryLotteryView:addDesScrollView()
    local config = ConfigManager:getAllAnniversaryLuckyDrawDataByID(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
    local height = 80
    local width = 330
    local desStr = languageManagerInstance:getLocalString(config.activityDes)
    local desText = UI.Text:create()
    desText:init(desStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    desText:setWidth(width)
    desText:autoAdapt()
    if(desText:getContentSize().height <= height) then 
        desText:center(140, -60)
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
        detailedScrollView:center(140, -60)

        self.contentLayout:addChild(detailedScrollView)
    end
end

function ActivityAnnivesaryLotteryView:addRewardNode(anniversaryLotteryData)
    local successRwds = anniversaryLotteryData.successRwds
    local len = #successRwds
    local rewardNode = UI.RewardPreViewUtil:create()
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    rewardNode:init(nil, len, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(5, 0))
    rewardNode:center(5+(47*(len-1)), 95)
    for k, v in pairs(successRwds) do 
        rewardNode:addGoodsId(v.id, v.num or 0)
    end
    rewardNode:showGoodsView()
    self.contentLayout:addChild(rewardNode, 19)

    local activityData = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryActivityData(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
    local signStartDate = GameManager:getNowServerDate("%m.%d %H:%M", activityData.startTime + GameManager:getEPOCHTime())
    local signEndDate = GameManager:getNowServerDate("%m.%d %H:%M", anniversaryLotteryData.signEndTime + GameManager:getEPOCHTime())
    local str = string.format(UI.TEXT_223617,signStartDate, signEndDate)
    self.signDate:setText(str)
end

function ActivityAnnivesaryLotteryView:showPetDetail()
    local petDetailView = self.contentLayout:getChildByName("petDetailView")
    if petDetailView then
        petDetailView:removeFromParent(true)
        petDetailView = nil
    end
    local config = ConfigManager:getAllAnniversaryLuckyDrawDataByID(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)

    local petData = ConfigManager:getPetDataByID(config.activityDisplay)
    petDetailView = mvc.activityAnnivesaryLotteryPetDetailView:create(petData)
    petDetailView:init()
    petDetailView:center()
    petDetailView:setName("petDetailView")
    self.contentLayout:addChild(petDetailView, 999)
end

function ActivityAnnivesaryLotteryView:updateJoinBtn()
    local data = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryData(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
    local activityData = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryActivityData(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
    if not data.isGetReward and data.rewardState == 1 and data.isSign then
        self.joinBtn:setText(UI.TEXT_223604)
    elseif data.isSign and not data.isGetReward then
        self.joinBtn:setText(UI.TEXT_223605)
    elseif data.rewardState == 0 and mvc.activityAnnivesaryLotteryModel:isSignEnd(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat) and not mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsEnd(activityData)  then
        self.joinBtn:setText(UI.TEXT_223616)
    elseif data.isGetReward or (not data.isGetReward and data.rewardState == 2 and data.isSign) then
        self.joinBtn:setText(UI.TEXT_223613)
    elseif not data.isSign and mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsEnd(activityData) then
        self.joinBtn:setText(UI.TEXT_223613)
    end
end

function ActivityAnnivesaryLotteryView:onJoinBtnClick()
    local data = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryData(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
    local activityData = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryActivityData(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
    if not data then
        return
    end
    if not data.isGetReward and data.rewardState == 1 and data.isSign then
        local num = #data.successRwds
        print("num333:", num)
        -- 判断背包是否满了
        local GameDataManager = require("app.game.GameDataManager")
        local freeNum = GameDataManager:getInstance():getFreePacketBoxNum()
        if(freeNum < num) then 
            UI.ScrollBar:createByText(UI.TEXT_1212011)
            print("bag is full")
            return 
        end
        Net.NetActivitySystem:requestActivityReward(data.ID, 1)
    elseif mvc.activityAnnivesaryLotteryModel:isAnniversaryLotteryPreShow(activityData) then
        UI.ScrollBar:createByText(UI.TEXT_223614)
    elseif data.isSign and data.rewardState == 0 then
        UI.ScrollBar:createByText(UI.TEXT_223611)
    elseif not mvc.activityAnnivesaryLotteryModel:isSignOpening(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat) then
        local signStartDate = GameManager:getNowServerDate("%m.%d %H:%M", activityData.startTime + GameManager:getEPOCHTime())
        local str = string.format(UI.TEXT_223621, signEndDate)
        UI.ScrollBar:createByText(str)
    elseif data.rewardState == 0 and mvc.activityAnnivesaryLotteryModel:isSignEnd(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat) and not mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsEnd(activityData) then
        UI.ScrollBar:createByText(UI.TEXT_223616)
    elseif data.rewardState == 0 and not data.isSign and not mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsEnd(activityData) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_CHAT_OPEN_MAIN_CHAT_WORLD_TAG, data.chatContent) 
    elseif data.isGetReward or (not data.isGetReward and data.rewardState == 2 and data.isSign) then
        mvc.openPanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryReward", data)
    elseif not data.isSign and mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsEnd(activityData) then
        Net.NetActivitySystem:requestAnnivesaryLotteryCheckRewardRoster(data.ID)
    end

end

function ActivityAnnivesaryLotteryView:bindModel()

end


function ActivityAnnivesaryLotteryView:unbindModel()

end





return ActivityAnnivesaryLotteryView












