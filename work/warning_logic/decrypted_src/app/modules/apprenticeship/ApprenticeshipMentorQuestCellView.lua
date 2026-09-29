------------------------------------------------------------------------------
--author: 
--date	: 2019/08/09
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipMentorQuestCellView = class("ApprenticeshipMentorQuestCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipMentorQuestCellView:ctor()
    ApprenticeshipMentorQuestCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipMentorQuestCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipMentorQuestCellView.super.init(self, ... )
end

function ApprenticeshipMentorQuestCellView:dtor()
    ApprenticeshipMentorQuestCellView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipMentorQuestCellView")
end


function ApprenticeshipMentorQuestCellView:onInitView()
------程序生成区块开始 node_902478803_1565321917-------
    local node_902478803_1565321917 = UI.Image9:create()
    node_902478803_1565321917:init("ui_scale9image_bg_bar.png", CCRectMake(0,0,4,4), cc.size(456, 89))
    node_902478803_1565321917.__uiComposerID = "902478803_1565321917"
    addChildAuto(self._layoutUU, self, node_902478803_1565321917, "layout_902478803_1565321917")
------程序生成区块结束 node_902478803_1565321917-------
------程序生成区块开始 node_1293827194_1565321945-------
    local node_1293827194_1565321945 = UI.Image:create()
    node_1293827194_1565321945:init('ui_mentor_banner_books.png')
    node_1293827194_1565321945.__uiComposerID = "1293827194_1565321945"
    addChildAuto(self._layoutUU, node_902478803_1565321917, node_1293827194_1565321945, "layout_1293827194_1565321945")
------程序生成区块结束 node_1293827194_1565321945-------
------程序生成区块开始 node_2036773617_1565322015-------
    local node_2036773617_1565322015 = UI.Text:create()
    node_2036773617_1565322015:init("", UI.FONT_BOLD, 18, {r = 155, g = 155, b = 155})
    node_2036773617_1565322015:autoAdapt()
    node_2036773617_1565322015.__uiComposerID = "2036773617_1565322015"
    addChildAuto(self._layoutUU, node_1293827194_1565321945, node_2036773617_1565322015, "layout_2036773617_1565322015")
    self._title = node_2036773617_1565322015 -- 暴露名字至self
------程序生成区块结束 node_2036773617_1565322015-------
------程序生成区块开始 node_1603323416_1565322102-------
    local node_1603323416_1565322102 = UI.Layout:create()
    node_1603323416_1565322102:init()
    node_1603323416_1565322102.__uiComposerID = "1603323416_1565322102"
    addChildAuto(self._layoutUU, node_902478803_1565321917, node_1603323416_1565322102, "layout_1603323416_1565322102")
------程序生成区块结束 node_1603323416_1565322102-------
------程序生成区块开始 node_20972269_1565322192-------
    local node_20972269_1565322192 = UI.Text:create()
    node_20972269_1565322192:init("", UI.FONT_STANDARD, 16, {r = 41, g = 41, b = 45})
    node_20972269_1565322192:setWidth(300)
    node_20972269_1565322192:autoAdapt()
    node_20972269_1565322192.__uiComposerID = "20972269_1565322192"
    addChildAuto(self._layoutUU, node_1603323416_1565322102, node_20972269_1565322192, "layout_20972269_1565322192")
    self._desc = node_20972269_1565322192 -- 暴露名字至self
------程序生成区块结束 node_20972269_1565322192-------
------程序生成区块开始 node_99388951_1565322309-------
    local node_99388951_1565322309 = UI.Text:create()
    node_99388951_1565322309:init("0/0", UI.FONT_STANDARD, 16, {r = 80, g = 5, b = 5})
    node_99388951_1565322309:autoAdapt()
    node_99388951_1565322309.__uiComposerID = "99388951_1565322309"
    addChildAuto(self._layoutUU, node_902478803_1565321917, node_99388951_1565322309, "layout_99388951_1565322309")
    self._textProgress = node_99388951_1565322309 -- 暴露名字至self
------程序生成区块结束 node_99388951_1565322309-------
end

function ApprenticeshipMentorQuestCellView:updateData(data)
    if (data) then
        self._data = data

        -- 标题
        if (self._data.title) then
            self._title:show()
            self._title:setText(self._data.title)
        else
            self._title:hide()
        end

        -- 解释
        if (self._data.desc) then
            self._desc:show()
            self._desc:setText(self._data.desc)
        else
            self._desc:hide()
        end

        -- 进度
        if (self._data.num and self._data.maxNum) then
            self._textProgress:show()
            local displayNum = self._data.num > self._data.maxNum and self._data.maxNum or self._data.num
            self._textProgress:setText(tostring(displayNum) .. "/" .. tostring(self._data.maxNum))
        else
            self._textProgress:hide()
        end
    end
end

function ApprenticeshipMentorQuestCellView:bindModel()

end


function ApprenticeshipMentorQuestCellView:unbindModel()

end





return ApprenticeshipMentorQuestCellView












