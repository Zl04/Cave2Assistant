------------------------------------------------------------------------------
--author: 
--date	: 2019/08/09
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipMentorResultCellView = class("ApprenticeshipMentorResultCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipMentorResultCellView:ctor(apprenticeIdx)
    self._apprenticeIdx = apprenticeIdx
    ApprenticeshipMentorResultCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipMentorResultCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipMentorResultCellView.super.init(self, ... )
end

function ApprenticeshipMentorResultCellView:dtor()
    ApprenticeshipMentorResultCellView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipMentorResultCellView")
end


function ApprenticeshipMentorResultCellView:onInitView()
------程序生成区块开始 node_902478803_1565321917-------
    local node_902478803_1565321917 = UI.Image9:create()
    node_902478803_1565321917:init("ui_scale9image_bg_bar.png", CCRectMake(0,0,4,4), cc.size(456, 89))
    node_902478803_1565321917.__uiComposerID = "902478803_1565321917"
    addChildAuto(self._layoutUU, self, node_902478803_1565321917, "layout_902478803_1565321917")
------程序生成区块结束 node_902478803_1565321917-------
------程序生成区块开始 node_124633468_1565330209-------
    local node_124633468_1565330209 = UI.Text:create()
    node_124633468_1565330209:init("", UI.FONT_STANDARD, 18, {r = 41, g = 41, b = 45})
    node_124633468_1565330209:autoAdapt()
    node_124633468_1565330209.__uiComposerID = "124633468_1565330209"
    addChildAuto(self._layoutUU, node_902478803_1565321917, node_124633468_1565330209, "layout_124633468_1565330209")
    self._desc = node_124633468_1565330209 -- 暴露名字至self
------程序生成区块结束 node_124633468_1565330209-------
------程序生成区块开始 node_1923011236_1565330301-------
    local node_1923011236_1565330301 = UI.Button:create()
    node_1923011236_1565330301:init("ui_btn_chat_0.png", "ui_btn_chat_1.png", "ui_btn_chat_2.png")
    node_1923011236_1565330301:setText(LanguageManager:getInstance():getLocalString(1112637) --[[领取]])
    node_1923011236_1565330301:setTextFont(UI.FONT_BOLD, 20, {r = 50, g = 50, b = 44})
    node_1923011236_1565330301:setInterval(1)
    node_1923011236_1565330301.__uiComposerID = "1923011236_1565330301"
    addChildAuto(self._layoutUU, node_902478803_1565321917, node_1923011236_1565330301, "layout_1923011236_1565330301")
    self._btnGetReward = node_1923011236_1565330301 -- 暴露名字至self
    self._btnGetReward:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (self._cb) then self._cb() end
    end)
------程序生成区块结束 node_1923011236_1565330301-------
------程序生成区块开始 node_1153537657_1565330482-------
    local node_1153537657_1565330482 = UI.Image:create()
    node_1153537657_1565330482:init('ui_information_banner_receive.png')
    node_1153537657_1565330482.__uiComposerID = "1153537657_1565330482"
    addChildAuto(self._layoutUU, node_902478803_1565321917, node_1153537657_1565330482, "layout_1153537657_1565330482")
    self._receiveBg = node_1153537657_1565330482 -- 暴露名字至self
------程序生成区块结束 node_1153537657_1565330482-------
------程序生成区块开始 node_1972438087_1565796854-------
    local node_1972438087_1565796854 = UI.Text:create()
    node_1972438087_1565796854:init(LanguageManager:getInstance():getLocalString(1112670) --[["已完成"]], UI.FONT_STANDARD, 18, {r = 15, g = 85, b = 71})
    node_1972438087_1565796854:autoAdapt()
    node_1972438087_1565796854:setRotationSkewX(-9.0)
    node_1972438087_1565796854:setRotationSkewY(-9.0)
    node_1972438087_1565796854.__uiComposerID = "1972438087_1565796854"
    addChildAuto(self._layoutUU, node_1153537657_1565330482, node_1972438087_1565796854, "layout_1972438087_1565796854")
------程序生成区块结束 node_1972438087_1565796854-------
end

-- 更新下标和显示
function ApprenticeshipMentorResultCellView:updateIndex(idx)
    self._idx = idx
    self:updateLevel()
    self:updateRewardStatView()
end

-- 更新显示
function ApprenticeshipMentorResultCellView:updateLevel()
    if (not self._idx) then return end

    local data = mvc.apprenticeshipModel:mentorGetResultRewardByIndex(self._idx)
    if (data) then
        -- 更新标题等级
        if (data.lv) then
            self._desc:show()
            self._desc:setText(string.format(LanguageManager:getInstance():getLocalString(1112669)--[["学员达到%s级"]], data.lv))
        else
            self._desc:hide()
        end
    end
end

-- 更新奖励获取和按钮状态
function ApprenticeshipMentorResultCellView:updateRewardStatView()
    if (not self._idx) then return end

    -- 更新完成状态
    local isValid = mvc.apprenticeshipModel:mentorIsResultRewardValidByIndex(self._apprenticeIdx, self._idx)
    local isReceived = mvc.apprenticeshipModel:mentorIsResultRewardReceivedByIndex(self._apprenticeIdx, self._idx)
    if (isReceived) then
        self._btnGetReward:hide()
        self._receiveBg:show()
    else
        self._receiveBg:hide()
        self._btnGetReward:show()
        if (isValid) then
            self._btnGetReward:enable()
        else
            self._btnGetReward:disable()
        end
    end
end

function ApprenticeshipMentorResultCellView:setCallback(cb)
    self._cb = cb
end

function ApprenticeshipMentorResultCellView:bindModel()

end


function ApprenticeshipMentorResultCellView:unbindModel()

end

return ApprenticeshipMentorResultCellView












