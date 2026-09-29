------------------------------------------------------------------------------
--author: 
--date	: 2019/08/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipApprenticeGraduateView = class("ApprenticeshipApprenticeGraduateView", UI.HWBtnComponent)
require("utils.UIUtil")

-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_mentor.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipApprenticeGraduateView:ctor()
    ApprenticeshipApprenticeGraduateView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipApprenticeGraduateView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipApprenticeGraduateView.super.init(self, ... )
end

function ApprenticeshipApprenticeGraduateView:dtor()
    ApprenticeshipApprenticeGraduateView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipApprenticeGraduateView")
end


function ApprenticeshipApprenticeGraduateView:onInitView()
------程序生成区块开始 node_111105854_1565163119-------
    local node_111105854_1565163119 = UI.Image:create()
    node_111105854_1565163119:init('ui_bg_box1.png')
    node_111105854_1565163119.__uiComposerID = "111105854_1565163119"
    addChildAuto(self._layoutUU, self, node_111105854_1565163119, "layout_111105854_1565163119")
    mvc.apprenticeshipApprenticeGraduatePanel.ui:setSize(node_111105854_1565163119:getSize())
    mvc.apprenticeshipApprenticeGraduatePanel.ui:center()
    self:center()
------程序生成区块结束 node_111105854_1565163119-------
------程序生成区块开始 node_617069466_1565163455-------
    local node_617069466_1565163455 = UI.Image:create()
    node_617069466_1565163455:init('ui_bg_title.png')
    node_617069466_1565163455.__uiComposerID = "617069466_1565163455"
    addChildAuto(self._layoutUU, node_111105854_1565163119, node_617069466_1565163455, "layout_617069466_1565163455")
------程序生成区块结束 node_617069466_1565163455-------
------程序生成区块开始 node_2092446872_1565166475-------
    local node_2092446872_1565166475 = UI.Text:create()
    node_2092446872_1565166475:init(LanguageManager:getInstance():getLocalString(1112635) --[["师徒关系"]], UI.FONT_BOLD, 26, {r = 170, g = 170, b = 170})
    node_2092446872_1565166475.__uiComposerID = "2092446872_1565166475"
    addChildAuto(self._layoutUU, node_617069466_1565163455, node_2092446872_1565166475, "layout_2092446872_1565166475")
------程序生成区块结束 node_2092446872_1565166475-------
------程序生成区块开始 node_408672110_1565166821-------
    local node_408672110_1565166821 = UI.Image:create()
    node_408672110_1565166821:init('ui_mentor_bg_paper1.png')
    node_408672110_1565166821:setLocalZOrder(1)
    node_408672110_1565166821.__uiComposerID = "408672110_1565166821"
    addChildAuto(self._layoutUU, node_111105854_1565163119, node_408672110_1565166821, "layout_408672110_1565166821")
------程序生成区块结束 node_408672110_1565166821-------
------程序生成区块开始 node_551410630_1565543164-------
    local node_551410630_1565543164 = UI.Image:create()
    node_551410630_1565543164:init('ui_mentor_bg_paper_up.png')
    node_551410630_1565543164.__uiComposerID = "551410630_1565543164"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_551410630_1565543164, "layout_551410630_1565543164")
    ------程序生成区块结束 node_551410630_1565543164-------
------程序生成区块开始 node_360886938_1565319643-------
    local node_360886938_1565319643 = UI.Text:create()
    node_360886938_1565319643:init(LanguageManager:getInstance():getLocalString(1112636) --[["恭喜你完成了所有冒险任务, 成功出师! 快领取冒险协会为你准备的奖励吧!"]], UI.FONT_STANDARD, 16, {r = 41, g = 41, b = 45})
    node_360886938_1565319643:setWidth(550)
    node_360886938_1565319643:autoAdapt()
    node_360886938_1565319643.__uiComposerID = "360886938_1565319643"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_360886938_1565319643, "layout_360886938_1565319643")
------程序生成区块结束 node_360886938_1565319643-------
------程序生成区块开始 node_1264180240_1565320821-------
    local node_1264180240_1565320821 = UI.Image9:create()
    node_1264180240_1565320821:init("ui_scale9image_banner_line_long.png", CCRectMake(20,1,1,1), cc.size(620, 2))
    node_1264180240_1565320821.__uiComposerID = "1264180240_1565320821"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_1264180240_1565320821, "layout_1264180240_1565320821")
------程序生成区块结束 node_1264180240_1565320821-------
------程序生成区块开始 node_216647550_1565690452-------
    local node_216647550_1565690452 = UI.Animation:create()
    node_216647550_1565690452:init("effect_ui_general_mentor_lazhu.json", "effect_ui_general_mentor_lazhu.atlas", 1);
    node_216647550_1565690452:setAnimation("idle", true)
    node_216647550_1565690452.__uiComposerID = "216647550_1565690452"
    addChildAuto(self._layoutUU, node_111105854_1565163119, node_216647550_1565690452, "layout_216647550_1565690452")
------程序生成区块结束 node_216647550_1565690452-------
------程序生成区块开始 node_702872387_1565711041-------
    local node_702872387_1565711041 = UI.Animation:create()
    node_702872387_1565711041:init("effect_ui_general_mentor_baoxiang.json", "effect_ui_general_mentor_baoxiang.atlas", 1);
    node_702872387_1565711041:setAnimation("idle", true)
    node_702872387_1565711041:setSize(120, 120)
    node_702872387_1565711041.__uiComposerID = "702872387_1565711041"
    addChildAuto(self._layoutUU, node_551410630_1565543164, node_702872387_1565711041, "layout_702872387_1565711041")
    self._aniGraduation = node_702872387_1565711041 -- 暴露名字至self
------程序生成区块结束 node_702872387_1565711041-------
------程序生成区块开始 node_79672306_1565843417-------
    local node_79672306_1565843417 = UI.Button:create()
    node_79672306_1565843417:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    node_79672306_1565843417:setText(LanguageManager:getInstance():getLocalString(1112637) --[["领取"]])
    node_79672306_1565843417:setTextFont(UI.FONT_BOLD, 20, {r = 50, g = 50, b = 44})
    node_79672306_1565843417:setInterval(1)
    node_79672306_1565843417:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local timeNow = GameManager:getNormalServerTime()
        if (self._nextRewardTime and self._nextRewardTime > timeNow) then return end
        self._nextRewardTime = GameManager:getNormalServerTime() + 1

        mvc.apprenticeshipController:apprenticeGetGraduationReward()
    end)
    node_79672306_1565843417.__uiComposerID = "79672306_1565843417"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_79672306_1565843417, "layout_79672306_1565843417")
    self._btnGet = node_79672306_1565843417 -- 暴露名字至self
------程序生成区块结束 node_79672306_1565843417-------
end


function ApprenticeshipApprenticeGraduateView:bindModel()

end


function ApprenticeshipApprenticeGraduateView:unbindModel()

end





return ApprenticeshipApprenticeGraduateView












