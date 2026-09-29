------------------------------------------------------------------------------
--author: 
--date	: 2019/08/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipExplainView = class("ApprenticeshipExplainView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_mentor.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipExplainView:ctor(text)
    self._text = text
    ApprenticeshipExplainView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipExplainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipExplainView.super.init(self, ... )
end

function ApprenticeshipExplainView:dtor()
    ApprenticeshipExplainView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipExplainView")
end


function ApprenticeshipExplainView:onInitView()
    self:center()
------程序生成区块开始 node_881518880_1565886820-------
    local node_881518880_1565886820 = UI.Image:create()
    node_881518880_1565886820:init('ui_mentor_detail_bg_paper.png')
    node_881518880_1565886820:showLucencyLight()
    node_881518880_1565886820.__uiComposerID = "881518880_1565886820"
    addChildAuto(self._layoutUU, self, node_881518880_1565886820, "layout_881518880_1565886820")
    node_881518880_1565886820:setTouchEnable(true)
    node_881518880_1565886820:setInterceptTouches(true)
    node_881518880_1565886820:setSwallowTouches(true)
    node_881518880_1565886820:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipExplainView, true)        
    end)
------程序生成区块结束 node_881518880_1565886820-------
------程序生成区块开始 node_1954350128_1565887027-------
    local node_1954350128_1565887027 = UI.Text:create()
    node_1954350128_1565887027:init(LanguageManager:getInstance():getLocalString(1112647) --[["详细说明"]], UI.FONT_BOLD, 18, {r = 41, g = 41, b = 45})
    node_1954350128_1565887027:autoAdapt()
    node_1954350128_1565887027.__uiComposerID = "1954350128_1565887027"
    addChildAuto(self._layoutUU, node_881518880_1565886820, node_1954350128_1565887027, "layout_1954350128_1565887027")
------程序生成区块结束 node_1954350128_1565887027-------
------程序生成区块开始 node_1907400262_1565887127-------
    local node_1907400262_1565887127 = UI.Image9:create()
    node_1907400262_1565887127:init("ui_scale9image_banner_line_long.png", CCRectMake(20,1,1,1), cc.size(283, 2))
    node_1907400262_1565887127.__uiComposerID = "1907400262_1565887127"
    addChildAuto(self._layoutUU, node_881518880_1565886820, node_1907400262_1565887127, "layout_1907400262_1565887127")
------程序生成区块结束 node_1907400262_1565887127-------

    local node_576017223_1565887327 = UI.ScrollView:create()
    node_576017223_1565887327:setSize(275, 330)
    node_576017223_1565887327:init(0, 0, 0, 0)
    node_576017223_1565887327:leftBottom(10, 10)
    addChildAuto(self._layoutUU, node_881518880_1565886820, node_576017223_1565887327, "layout_576017223_1565887327")

------程序生成区块开始 node_576017223_1565887327-------
    local node_576017223_1565887327_sub1 = UI.Text:create()
    node_576017223_1565887327_sub1:init(self._text, UI.FONT_STANDARD, 16, {r = 41, g = 41, b = 45})
    node_576017223_1565887327_sub1:setWidth(275)
    node_576017223_1565887327_sub1:autoAdapt()
    node_576017223_1565887327_sub1.__uiComposerID = "576017223_1565887327"
    node_576017223_1565887327:addInnerNode(node_576017223_1565887327_sub1)
    self._textContent = node_576017223_1565887327_sub1 -- 暴露名字至self
------程序生成区块结束 node_576017223_1565887327-------
end


function ApprenticeshipExplainView:bindModel()

end


function ApprenticeshipExplainView:unbindModel()

end





return ApprenticeshipExplainView












