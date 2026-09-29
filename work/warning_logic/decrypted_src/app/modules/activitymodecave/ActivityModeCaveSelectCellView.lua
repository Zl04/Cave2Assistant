------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/28
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveSelectCellView = class("ActivityModeCaveSelectCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 285
local COM_HEIGHT = 465

function ActivityModeCaveSelectCellView:ctor(data, config)
    ActivityModeCaveSelectCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.config = config
    self:bindModel()
end

function ActivityModeCaveSelectCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecave", "ActivityModeCave", false)
    ActivityModeCaveSelectCellView.super.init(self, ... )

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:openChallengeView()
    end)
end

function ActivityModeCaveSelectCellView:dtor()
    ActivityModeCaveSelectCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecave.ActivityModeCaveSelectCellView")
end


function ActivityModeCaveSelectCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_trial_bg_2.png")
    bg:center()
    contentLayout:addChild(bg)

    local headBg = UI.Image:create()
    headBg:init("ui_trial_illustration.png")
    headBg:centerUp(70)
    contentLayout:addChild(headBg)

    local dateBg = UI.Image:create()
    dateBg:init("ui_trial_list_5.png")
    dateBg:centerUp(250)
    contentLayout:addChild(dateBg)

    local str = languageManagerInstance:getLocalString(tonumber(self.config.name))
    local title = UI.Text:create()
    title:init(str, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    title:centerUp(50)
    contentLayout:addChild(title, 199)

    local startDate = GameManager:getClientDateByConfigTimeStr(self.config.startTime, "%m.%d")
    local endDate = GameManager:getClientDateByConfigTimeStr(self.config.endTime, "%m.%d")
    local dateStr = string.format(UI.TEXT_223408, startDate, endDate)
    local date = UI.Text:create()
    date:init(dateStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_255_255)
    date:center(0, 0)
    dateBg:addChild(date)

    local isOpening = mvc.activityModeCaveModel:getCaveModeIsOpening(self.config)
    local desStr = isOpening and UI.TEXT_223401 or UI.TEXT_223410
    local des = UI.Text:create()
    des:init(desStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    des:center(0, 65)
    contentLayout:addChild(des)
    self.des = des

    local enterDes = UI.Text:create()
    enterDes:init(UI.TEXT_223413, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    enterDes:centerBottom(45);
    contentLayout:addChild(enterDes)
    self.enterDes = enterDes
    enterDes:setVisible(false)

    -- 领取描述面板
    local getDesLayout = UI.Layout:create();
    getDesLayout:init()
    getDesLayout:setSize(146, 82)
    getDesLayout:centerBottom(75)
    self.contentLayout:addChild(getDesLayout)
    self.getDesLayout = getDesLayout
    getDesLayout:setVisible(false)

    local getDesBg = UI.Image:create()
    getDesBg:init("ui_trial_receivemark.png")
    getDesBg:center()
    getDesLayout:addChild(getDesBg)
    getDesBg:setScale(0.9)

    local getDes = UI.Text:create()
    getDes:init(UI.TEXT_1110721, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_154_21_30)
    getDes:center();
    getDesLayout:addChild(getDes)
    getDes:rotate(-16)

    if isOpening and self.data then
        self:addDailyReward()
    end
end

function ActivityModeCaveSelectCellView:addDailyReward()
    local level = RoleDataManager:getMaster():getLevel()
    local range = self:getRewardRangeByLevel(level)
    local idList = {}
    local numList = {}
    local rewardRangeList = string.split(self.config.firstPassReward, ":")
    local rewardList = string.split(rewardRangeList[range], ";")
    for k, v in pairs(rewardList) do
        local itemData = string.split(v, ",")
        table.insert(idList, tonumber(itemData[1]))
        table.insert(numList, tonumber(itemData[2]))
    end
    local len = #idList
    local rewardNode = UI.RewardPreViewUtil:create()
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    rewardNode:init(nil, len, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(5, 0))
    rewardNode:centerBottom(80)
    for k, v in pairs(idList) do 
        rewardNode:addGoodsId(v, numList[k] or 0)
    end
    rewardNode:setScale(0.8)
    rewardNode:showGoodsView()
    self.contentLayout:addChild(rewardNode, 99)
    self.rewardNode = rewardNode

    -- 按钮功能
    local getBtn = UI.Button:create()
    getBtn:init("ui_trial_ranking_btn2.png", "ui_trial_ranking_btn2.png", "ui_trial_ranking_btn3.png")
    getBtn:centerBottom(45);
    getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    getBtn:setText(UI.TEXT_111035)
    -- getBtn:setVisible(self.data.trialLand.dailyRewardFlag == 1)
    getBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.data.trialLand then
            if self.data.trialLand.dailyRewardFlag == 1 then
                Net.NetPlaySystem:requestClaimTrialLandDailyReward(PublicDefine.ActivityModeCaveType.TrialLand, self.config.ID)
            end
        end
    end)
    self.contentLayout:addChild(getBtn)
    self.getBtn = getBtn
    self:updateGetBtn()
end

function ActivityModeCaveSelectCellView:getRewardRangeByLevel(level)
    local range = 1
    local gradeInterval = self.config.gradeInterval
    local gradeIntervalRangeList = string.split(gradeInterval, ":")
    for k, gradeIntervalRange in pairs(gradeIntervalRangeList) do
        local gradeIntervalRangeLevelList = string.split(gradeIntervalRange, ",")
        if level >= tonumber(gradeIntervalRangeLevelList[1]) and level <= tonumber(gradeIntervalRangeLevelList[2]) then
            range = k
        end
    end
    return range
end

function ActivityModeCaveSelectCellView:updateGetBtn()
    local allData = mvc.activityModeCaveModel:getModeCaveData(PublicDefine.ActivityModeCaveType.TrialLand)
    local caveData = allData[self.config.ID]
    if caveData and caveData.trialLand then
        if caveData.trialLand.dailyRewardFlag == 1  then
            self.getBtn:enable()
            self.getBtn:setVisible(true)
            self.enterDes:setVisible(false)
        elseif caveData.trialLand.dailyRewardFlag == 0  then
            self.getBtn:disable()
            self.getBtn:setVisible(false)
            self.enterDes:setVisible(true)
        elseif caveData.trialLand.dailyRewardFlag == 2  then
            self.getBtn:disable()
            self.getBtn:setVisible(false)
            self.enterDes:setVisible(true)
            self.rewardNode:setVisible(false)
            self.getDesLayout:setVisible(true)
        end
    end
end

function ActivityModeCaveSelectCellView:disableGetBtn()
    local isOpening = mvc.activityModeCaveModel:getCaveModeIsOpening(self.config)
    if not isOpening or not self.data then
        return
    end
    self:updateGetBtn()
    UI.ScrollBar:createByText(UI.TEXT_1212026)
    -- self.getBtn:disable()
    -- self.getBtn:setVisible(false)
end

function ActivityModeCaveSelectCellView:openChallengeView()
    local isOpening = mvc.activityModeCaveModel:getCaveModeIsOpening(self.config)
    if not isOpening or not self.data then
        return
    end
    -- mvc.openPanel("ActivityModeCave", "ActivityModeCaveChallenge")
    mvc.send("ActivityModeCave_Open_Challenge_View", self.data, self.config)
end


function ActivityModeCaveSelectCellView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_TRIAL_LAND_REFRESH_GET_BTN, self, self.updateGetBtn)
end


function ActivityModeCaveSelectCellView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TRIAL_LAND_REFRESH_GET_BTN, self, self.updateGetBtn)
end





return ActivityModeCaveSelectCellView












