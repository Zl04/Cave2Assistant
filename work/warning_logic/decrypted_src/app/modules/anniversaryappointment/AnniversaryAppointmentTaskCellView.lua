------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local AnniversaryAppointmentTaskCellView = class("AnniversaryAppointmentTaskCellView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 630
local COM_HEIGHT = 130

local coinID = 23370001

function AnniversaryAppointmentTaskCellView:ctor(data, activityId, index, configData)
    AnniversaryAppointmentTaskCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.activityId = activityId
    self.index = index
    self.configData = configData
    self:bindModel()
end

function AnniversaryAppointmentTaskCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.anniversaryappointment", "AnniversaryAppointment", false)
    AnniversaryAppointmentTaskCellView.super.init(self, ... )
end

function AnniversaryAppointmentTaskCellView:dtor()
    AnniversaryAppointmentTaskCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.anniversaryappointment.AnniversaryAppointmentTaskCellView")
end


function AnniversaryAppointmentTaskCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(3, 25)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 标题背景
    local titleBg  = UI.Image:create()
    titleBg:init("ui_anniversary_paper_2.png")
    titleBg:centerUp(0)
    contentLayout:addChild(titleBg)

    -- 标题
    local title = UI.Text:create()
    title:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_170_170_170)
    title:centerLeft(10)
    titleBg:addChild(title)
    self.title = title

    -- 标题
    local progress = UI.Text:create()
    progress:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_170_170_170)
    progress:centerRight(10)
    titleBg:addChild(progress)
    self.progress = progress

    -- line
    local line  = UI.Image:create()
    line:init("ui_anniversary_line_2.png")
    line:centerBottom(0)
    contentLayout:addChild(line)

    self:initTargetView()
    
end

function AnniversaryAppointmentTaskCellView:initTargetView()
    local groupInfo = self.activityId == PublicDefine.TradeActivityIDList.TradeActivityAppointmentServerReward and mvc.anniversaryAppointmentModel:getServerRewardConfig() or mvc.tradeActivityModel:getActivityTargetByID(self.activityId)
    local curInfo = groupInfo[self.index]
    local str = string.format(languageManagerInstance:getLocalString(curInfo.desc), curInfo.target)
    self.title:setText(str)
    local target
    if curInfo.type == PublicDefine.TargetType.TargetType_MaxPoint then
        if curInfo.target ~= 0 then
            target = curInfo.target
        else
            target = 1
        end
    else
        target = curInfo.target
    end
    local progressText = string.format(UI.TEXT_222725, curInfo.count, target)
    self.progress:setText(progressText)
    if self.activityId == PublicDefine.TradeActivityIDList.TradeActivityAppointmentCoinReward then
        self.progress:hide()
    end

    for k, v in pairs(curInfo.rewardid) do
        local goodData = GoodsDataManager:createLocalGoodsData(v)
        if goodData then
            goodData:setNum(curInfo.rewardnum[k])
            goodData:setIsNew(false)
            goodData.isHaveGet = false

            local rewardGrid = UI.GoodsGrid:create()
            rewardGrid:init(goodData)
            rewardGrid:centerLeft(-70+k*80, 8)
            rewardGrid:hideNewIcon()
            rewardGrid:setTouchEnable(true)
            rewardGrid:setSwallowTouches(false )
            -- rewardGrid:setTouchClipNode(self.awardLayout)
            rewardGrid:showInfoArea(true, false)
            self.contentLayout:addChild(rewardGrid)
        end
    end

    local getBtn = UI.Button:create()
    getBtn:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    getBtn:centerRight(25, 15)
    -- getBtn:closeClickScale()
    getBtn:setText(UI.TEXT_111035)
    getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    getBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local SceneManager = require("app.game.SceneManager")
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        -- UI.WaitingLayer:showWaiting(true, nil, 5)
        -- -- 发送领奖时记录一下index方便展示领取奖励框
        -- self.getItemIndex = index
        -- Net.NetRoleSystem:sendRequestGrowFundGetAwards(configData.exchange[index])
        self:getAwards(self.index, groupInfo)
    end)
    -- getBtn:setName("getBtn")
    self.getBtn = getBtn
    self.contentLayout:addChild(getBtn)

    if self.activityId == PublicDefine.TradeActivityIDList.TradeActivityAppointmentServerReward then
        self:updateCoinAwardCellBtn()
    else
        self:updateAwardCellBtn()
    end

    self:updateAwardCellBtnState()
end

function AnniversaryAppointmentTaskCellView:getAwards(index, groupInfo)
    local SceneManager = require("app.game.SceneManager")
    if not (SceneManager:getInstance():isNotInFightScene()) then
        UI.ScrollBar:createByText(UI.TEXT_1213665)
        return
    end

    -- local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(self.activityId)
    if not groupInfo or table.nums(groupInfo) <= 0 then
        return
    end

    local targetInfo = groupInfo[index]
    if not targetInfo.rewardid or table.nums(targetInfo.rewardid) <= 0 then
        return
    end

    local rewardid = targetInfo.rewardid
    local rewardnum = targetInfo.rewardnum
    local goodsArr = {}
    for awardIndex = 1, #rewardid do
        local data = {}
        data.goodsID = rewardid[awardIndex]
        data.num = rewardnum[awardIndex]
        data.isGolden = false
        table.insert(goodsArr, data)
    end

    -- 判断背包是否满了
    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) then
        UI.ScrollBar:createByText(UI.TEXT_1212011)
        return
    end

    UI.WaitingLayer:showWaiting(true, nil, 5)

    -- 发送领奖时记录一下index方便展示领取奖励框
    -- self.getItemIndex = index
    if self.activityId == PublicDefine.TradeActivityIDList.TradeActivityAppointmentServerReward then
        Net.NetPlaySystem:requestAnniversarySubscribeClaimReward(targetInfo.ID)
    else
        Net.NetRoleSystem:sendActivityTargetGetAwards(targetInfo.sudId, targetInfo.groupId)
    end

end

function AnniversaryAppointmentTaskCellView:updateAwardCellBtn()
    local getBtn = self.getBtn--image:getChildByName("getBtn")
    if not getBtn or tolua.isnull(getBtn) then
        return
    end
    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(self.activityId)
    local curInfo = groupInfo[self.index]
    getBtn:show()
    if curInfo.stat and curInfo.stat == 3 then
        getBtn:disable()
        getBtn:setText(UI.TEXT_1110721)
    elseif curInfo.stat and curInfo.stat == 1 and not mvc.anniversaryAppointmentModel:getActivityIsOpening(self.activityId) then
        getBtn:disable()
        getBtn:setText(UI.TEXT_1213112)
    elseif curInfo.stat and curInfo.stat == 2 then
        getBtn:enable()
        getBtn:setText(UI.TEXT_111035)
    else
        getBtn:disable()
        getBtn:setText(UI.TEXT_1324508)
    end

end

function AnniversaryAppointmentTaskCellView:updateAwardCellBtnState()

    local getBtn = self.getBtn
    if not getBtn or tolua.isnull(getBtn) then
        return
    end

    if self.configData and self.configData.startTime and self.configData.endTime then
        
        local nowTime = GameManager:getNormalServerTime()
        local startTime = GameManager:getUnixTimeByConfigTimeStr(self.configData.startTime)
        local endTime = GameManager:getUnixTimeByConfigTimeStr(self.configData.endTime)

        if nowTime < startTime or nowTime > endTime then
            getBtn:disable()
            getBtn:setText(UI.TEXT_1213112)
        end
    end
end

function AnniversaryAppointmentTaskCellView:updateCoinAwardCellBtn()
    local getBtn = self.getBtn--image:getChildByName("getBtn")
    if not getBtn or tolua.isnull(getBtn) then
        return
    end
    local pk = RoleDataManager:getMaster():getPK()
    local coinNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, coinID)
    getBtn:show()
    if mvc.anniversaryAppointmentModel:checkRewardHasTaken(self.data.ID) then
        getBtn:disable()
        getBtn:setText(UI.TEXT_1110721)
    elseif self.data.count >= self.data.target then
        getBtn:enable()
        getBtn:setText(UI.TEXT_111035)
    elseif not mvc.anniversaryAppointmentModel:getActivityIsOpening(self.activityId) then
        getBtn:disable()
        getBtn:setText(UI.TEXT_1213112)
    else
        getBtn:disable()
        getBtn:setText(UI.TEXT_1324508)
    end
end

function AnniversaryAppointmentTaskCellView:bindModel()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_ACTIVITY_REFRESH, self, self.updateAwardCellBtn)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_ACTIVITY_REFRESH_SERVER_REWARD_BTN, self, self.updateCoinAwardCellBtn)
end


function AnniversaryAppointmentTaskCellView:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_ACTIVITY_REFRESH, self, self.updateAwardCellBtn)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_ACTIVITY_REFRESH_SERVER_REWARD_BTN, self, self.updateCoinAwardCellBtn)
end





return AnniversaryAppointmentTaskCellView












