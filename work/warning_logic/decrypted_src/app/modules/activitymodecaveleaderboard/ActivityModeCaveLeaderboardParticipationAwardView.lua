------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveLeaderboardParticipationAwardView = class("ActivityModeCaveLeaderboardParticipationAwardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 1026
local COM_HEIGHT = 571

function ActivityModeCaveLeaderboardParticipationAwardView:ctor(trialModelID)
    ActivityModeCaveLeaderboardParticipationAwardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._trialModelID = trialModelID or 1
    self._indexKey = 0
end

function ActivityModeCaveLeaderboardParticipationAwardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecaveleaderboard", "ActivityModeCaveLeaderboard", false)
    ActivityModeCaveLeaderboardParticipationAwardView.super.init(self, ... )
end

function ActivityModeCaveLeaderboardParticipationAwardView:dtor()
    ActivityModeCaveLeaderboardParticipationAwardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecaveleaderboard.ActivityModeCaveLeaderboardParticipationAwardView")
end


function ActivityModeCaveLeaderboardParticipationAwardView:onInitView()
    self:center()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local rankingBanner = UI.Image:create()
    rankingBanner:init("ui_trial_ranking_banner.png")
    rankingBanner:centerUp(58)
    contentLayout:addChild(rankingBanner)

    local rankingLine = UI.Image:create()
    rankingLine:init("ui_trial_ranking_line.png")
    rankingLine:centerUp(238)
    contentLayout:addChild(rankingLine)

    local rBg = UI.Image:create()
    rBg:init("ui_trial_ranking_bg2.png")
    rBg:leftUp(135, 250)
    contentLayout:addChild(rBg)

    local desLayout = UI.Layout:create();
    desLayout:init()
    desLayout:enableAutoWidth()
    desLayout:enableAutoHeight()
    desLayout:centerLeft(5)
    rBg:addChild(desLayout)

    local desText = UI.Text:create()
    desText:init(UI.TEXT_223505, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 220, g = 220, b = 220})
    desText:floatLeft(0)
    desLayout:addComponent(desText)

    local numText = UI.Text:create()
    numText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 247, g = 183, b = 84})
    numText:floatLeft(5)
    desLayout:addComponent(numText)
    self._numText = numText

    local bottomBg = UI.Image:create()
    bottomBg:init("ui_trial_ranking_paper2.png")
    bottomBg:centerBottom(40)
    contentLayout:addChild(bottomBg)
    self._bottomBg = bottomBg


    self._progressBar = UI.ProgressTimer:create()
    self._progressBar:init("ui_trial_ranking_schedulebg.png", "ui_trial_ranking_schedule.png", "ui_trial_ranking_schedule.png")
    self._progressBar:leftUp(135, 304)
    contentLayout:addChild(self._progressBar)


    self:updateBtnLayout()
    self:updateAwardView(1)

end

function ActivityModeCaveLeaderboardParticipationAwardView:updateBtnLayout()

    if self.btnContentLayout then
        self.btnContentLayout:removeAllChildren()
        self.btnContentLayout:removeFromParent()
        self.btnContentLayout = nil
    end

    local btnContentLayout = UI.Layout:create()
    btnContentLayout:init()
    btnContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    btnContentLayout:center()
    self:addChild(btnContentLayout)
    self.btnContentLayout = btnContentLayout

    self._boxTable = {}
    self.sData = ConfigManager:getAllParticipateScheduleData()
    local trialModelConf = ConfigManager:getAllTrialModelDataByID(self._trialModelID)
    if self.sData then
        for k,v in ipairs(self.sData) do
            local isReceive = mvc.activityModeCaveLeaderboardModel:isReceiveParticipate(trialModelConf.participateType,v.ID)
            local canReceive = mvc.activityModeCaveLeaderboardModel:canReceiveParticipate(trialModelConf.participateType,v.ID,tonumber(v.target))

            self._boxTable[k] = {}
            self._boxTable[k].ID = v.ID
            self._boxTable[k].award = v.award
            self._boxTable[k].target = tonumber(v.target)
            self._boxTable[k].isReceive = isReceive
            self._boxTable[k].canReceive = canReceive

            local btnLayout = UI.Layout:create()
            btnLayout:init()
            btnLayout:setSize(100, 100)
            btnContentLayout:addChild(btnLayout)
            self._boxTable[k].btnLayout = btnLayout
            self.btnLayout = btnLayout

            local boxBtn = UI.Button:create()
            boxBtn:init('ui_trial_ranking_award.png', 'ui_trial_ranking_award.png', 'ui_trial_ranking_award.png')
            boxBtn:center()
            boxBtn:closeClickScale()
            boxBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                self:updateAwardView(k)
            end)
            btnLayout:addChild(boxBtn)

            self._boxTable[k].boxBtn = boxBtn

            local numText = UI.Text:create()
            numText:init(v.target, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 247, g = 183, b = 84})
            numText:centerBottom(7)
            btnLayout:addChild(numText)

            local receivedImge = UI.Image:create()
            receivedImge:init("ui_trial_ranking_received.png")
            receivedImge:rightUp(5,5)
            btnLayout:addChild(receivedImge)
            self._boxTable[k].receivedImge = receivedImge

            local selectSpine = UI.Animation:create()
            selectSpine:init("effect_ui_town_selected.json", "effect_ui_town_selected.atlas", 1);
            selectSpine:center(0,-5)
            btnLayout:addChild(selectSpine, -1)
            self._boxTable[k].selectSpine = selectSpine
            selectSpine:hide()


        end
    end
end

function ActivityModeCaveLeaderboardParticipationAwardView:updateAwardView(indexKey, isForce, showAward)

    if self._indexKey == indexKey and not isForce then
        return
    end

    if not indexKey then
        indexKey = self._indexKey
    end

    self._indexKey = indexKey

    if self.bottomLayout then
        self.bottomLayout:removeAllChildren()
        self.bottomLayout:removeFromParent()
        self.bottomLayout = nil
    end
    
    self.bottomLayout = UI.Layout:create()
    self.bottomLayout:init()
    self.bottomLayout:enableAutoWidth()
    self.bottomLayout:enableAutoHeight()
    self.bottomLayout:center(0,-13)
    self._bottomBg:addChild(self.bottomLayout)


    local boxData = nil
    self._progressNum = 0
    local trialModelConf = ConfigManager:getAllTrialModelDataByID(self._trialModelID)
    local cumulativeCount = mvc.activityModeCaveLeaderboardModel:getCumulativeCount(trialModelConf and trialModelConf.participateType or 1)
    self._numText:setText(tostring(cumulativeCount))

    local preWidth = 758 / #self._boxTable
    for k,v in ipairs(self._boxTable) do
        if v.isReceive then
            v.receivedImge:show()
        else
            v.receivedImge:hide()
        end

        v.btnLayout:leftUp(135 - 80 + k * preWidth, 304 - 33)

        if cumulativeCount >= v.target then
            self._progressNum = self._progressNum + 1
        end

        if k == indexKey then
            boxData = v

            self._boxTable[k].selectSpine:show()
            self._boxTable[k].selectSpine:setAnimation("trigger", false)
            self._boxTable[k].selectSpine:addAnimation("idle", true)
        else
            self._boxTable[k].selectSpine:hide()
        end
    end

    self._progressBar:setPercent(self._progressNum / #self._boxTable)


    local rewardGoodsArr = {}
    local canReceive = false
    local isReceive = false
    --奖励道具展示
    if boxData then
        canReceive = boxData.canReceive
        isReceive = boxData.isReceive
        local awardTable = AvalonUtil:splitStr(boxData.award, ";")

        for k,v in ipairs(awardTable) do
            local awardData = AvalonUtil:splitStr(v, ",")
            local itemId = tonumber(awardData[1])
            local itemNum = tonumber(awardData[2])

            local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
            if(goodsData) then
                goodsData:setNum(itemNum)
                goodsData:setIsNew(false)

                local goodsGrid = UI.GoodsGrid:create()
                goodsGrid:init(goodsData)
                if k == 1 then
                    goodsGrid:floatLeft(0)
                else
                    goodsGrid:floatLeft(33)
                end
                goodsGrid:showInfoArea(true, false)
                self.bottomLayout:addComponent(goodsGrid)

                if showAward then
                    table.insert(rewardGoodsArr, goodsData)
                end
            end
        end
    end

    if showAward then
        if rewardGoodsArr then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, nil, UI.TEXT_111030, nil)  
        end
    end

    --领奖按钮
    if self._receiveBtn then
        self._receiveBtn:removeFromParent()
        self._receiveBtn = nil
    end
    self._receiveBtn = UI.Button:create()
    self._receiveBtn:init('ui_trial_ranking_btn.png', 'ui_trial_ranking_btn.png', 'ui_trial_ranking_btn.png')
    self._receiveBtn:centerBottom(-15)
    self._receiveBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    self._receiveBtn:setText("")
    self._receiveBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        
        if canReceive and not isReceive then
            --领取奖励
            local trialModelConf = ConfigManager:getAllTrialModelDataByID(self._trialModelID)
            Net.NetPlaySystem:requestClaimParticipateAward(trialModelConf.participateType, boxData.ID)
            -- --刷新界面
            -- self:updateAwardView(self._indexKey,true)
        elseif isReceive then
            UI.ScrollBar:createByText(UI.TEXT_223506)
        end
    end)
    self._bottomBg:addChild(self._receiveBtn)

    if canReceive and not isReceive then
        self._receiveBtn:setText(UI.TEXT_1212001)
    elseif not canReceive then
        self._receiveBtn:hide()
    elseif isReceive then
        self._receiveBtn:setText(UI.TEXT_1110721)
    end

end

function ActivityModeCaveLeaderboardParticipationAwardView:bindModel()

end


function ActivityModeCaveLeaderboardParticipationAwardView:unbindModel()

end





return ActivityModeCaveLeaderboardParticipationAwardView












