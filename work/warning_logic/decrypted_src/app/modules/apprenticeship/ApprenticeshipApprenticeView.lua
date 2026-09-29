------------------------------------------------------------------------------
--author: 
--date	: 2019/07/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipApprenticeView = class("ApprenticeshipApprenticeView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_mentor.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
function ApprenticeshipApprenticeView:ctor()
    ApprenticeshipApprenticeView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipApprenticeView:dtor()
    ApprenticeshipApprenticeView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipApprenticeView")
end

function ApprenticeshipApprenticeView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipApprenticeView.super.init(self, ...)
    mvc.apprenticeshipController:apprenticeUpdateMentorInfo()
end

function ApprenticeshipApprenticeView:postAddChild()
end

function ApprenticeshipApprenticeView:onInitView()
------程序生成区块开始 node_111105854_1565163119-------
    local node_111105854_1565163119 = UI.Image:create()
    node_111105854_1565163119:init('ui_bg_box1.png')
    node_111105854_1565163119.__uiComposerID = "111105854_1565163119"
    addChildAuto(self._layoutUU, self, node_111105854_1565163119, "layout_111105854_1565163119")
    mvc.apprenticeshipApprenticePanel.ui:setSize(node_111105854_1565163119:getSize())
    mvc.apprenticeshipApprenticePanel.ui:center()
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
------程序生成区块开始 node_218251281_1565322930-------
    local node_218251281_1565322930 = UI.Animation:create()
    node_218251281_1565322930:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas", 1);
    node_218251281_1565322930:setAnimation("idle", true)
    node_218251281_1565322930.__uiComposerID = "218251281_1565322930"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_218251281_1565322930, "layout_218251281_1565322930")
    self._btnTutorial = node_218251281_1565322930 -- 暴露名字至self
    node_218251281_1565322930:setTouchEnable(true)
    node_218251281_1565322930:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if (mvc.apprenticeshipController.apprenticeshipExplainView) then
            mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipExplainView, true)
        else
            mvc.apprenticeshipController:showView(
                mvc.apprenticeshipApprenticePanel, 
                mvc.apprenticeshipExplainView, 
                100, 
                LanguageManager:getInstance():getLocalString(1112627))
        end
    end)
    -- node_218251281_1565322930:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
    --     mvc.apprenticeshipController:showView(
    --         mvc.apprenticeshipApprenticePanel, 
    --         mvc.apprenticeshipExplainView, 
    --         100, 
    --         LanguageManager:getInstance():getLocalString(1112627))
    -- end)
    -- node_218251281_1565322930:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
    --     mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipExplainView, true)
    -- end)
------程序生成区块结束 node_218251281_1565322930-------
------程序生成区块开始 node_2119858475_1565533930-------
    local node_2119858475_1565533930 = UI.Button:create()
    node_2119858475_1565533930:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    node_2119858475_1565533930:setText(LanguageManager:getInstance():getLocalString(1112641) --[["上报导师"]])
    node_2119858475_1565533930:setTextFont(UI.FONT_BOLD, 18, {r = 41, g = 41, b = 45})
    node_2119858475_1565533930:setInterval(1)
    node_2119858475_1565533930:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.apprenticeshipController:apprenticeConfirmQuest()
    end)
    node_2119858475_1565533930:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if (mvc.apprenticeshipModel:apprenticeIsQuestCommitted()) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112642) --[["任务已经提交, 等待导师确认中..."]])
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112643) --[["完成所有任务后才能提交"]])
        end
    end)
    node_2119858475_1565533930.__uiComposerID = "2119858475_1565533930"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_2119858475_1565533930, "layout_2119858475_1565533930")
    self._btnCommit = node_2119858475_1565533930 -- 暴露名字至self
------程序生成区块结束 node_2119858475_1565533930-------
------程序生成区块开始 node_1264180240_1565320821-------
    local node_1264180240_1565320821 = UI.Image9:create()
    node_1264180240_1565320821:init("ui_scale9image_banner_line_long.png", CCRectMake(20,1,1,1), cc.size(468, 2))
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
------程序生成区块开始 node_211409044_1565858315-------
    local node_211409044_1565858315 = UI.Layout:create()
    node_211409044_1565858315:init()
    node_211409044_1565858315:setSize(186, 376)
    node_211409044_1565858315.__uiComposerID = "211409044_1565858315"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_211409044_1565858315, "layout_211409044_1565858315")
------程序生成区块结束 node_211409044_1565858315-------
------程序生成区块开始 node_1200317275_1565858808-------
    local node_1200317275_1565858808 = UI.Animation:create()
    node_1200317275_1565858808:init("effect_ui_general_mentor_qizi.json", "effect_ui_general_mentor_qizi.atlas", 1);
    node_1200317275_1565858808:setAnimation("idle", true)
    node_1200317275_1565858808.__uiComposerID = "1200317275_1565858808"
    addChildAuto(self._layoutUU, node_211409044_1565858315, node_1200317275_1565858808, "layout_1200317275_1565858808")
------程序生成区块结束 node_1200317275_1565858808-------
------程序生成区块开始 node_884864452_1565858340-------
    local node_884864452_1565858340 = UI.Image:create()
    node_884864452_1565858340:init('ui_information_headframe_box2.png')
    node_884864452_1565858340:setLocalZOrder(2)
    node_884864452_1565858340.__uiComposerID = "884864452_1565858340"
    addChildAuto(self._layoutUU, node_211409044_1565858315, node_884864452_1565858340, "layout_884864452_1565858340")
    node_884864452_1565858340:setTouchEnable(true)
    node_884864452_1565858340:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:toggleCancelMentorButton()
    end)
------程序生成区块结束 node_884864452_1565858340-------
------程序生成区块开始 node_32982274_1565858340-------
    local node_32982274_1565858340 = UI.Image:create()
    node_32982274_1565858340:init('ui_information_headframe_grade.png')
    node_32982274_1565858340.__uiComposerID = "32982274_1565858340"
    addChildAuto(self._layoutUU, node_884864452_1565858340, node_32982274_1565858340, "layout_32982274_1565858340")
------程序生成区块结束 node_32982274_1565858340-------
------程序生成区块开始 node_30002666_1565858340-------
    local node_30002666_1565858340 = UI.Text:create()
    node_30002666_1565858340:init("16", UI.FONT_STANDARD, 16, {r = 189, g = 167, b = 136})
    node_30002666_1565858340.__uiComposerID = "30002666_1565858340"
    addChildAuto(self._layoutUU, node_32982274_1565858340, node_30002666_1565858340, "layout_30002666_1565858340")
    self._mentorLV = node_30002666_1565858340 -- 暴露名字至self
------程序生成区块结束 node_30002666_1565858340-------
------程序生成区块开始 node_2022750034_1565858564-------
    local node_2022750034_1565858564 = UI.Image:create()
    node_2022750034_1565858564:init('ui_information_headframe_box.png')
    node_2022750034_1565858564:setLocalZOrder(1)
    node_2022750034_1565858564.__uiComposerID = "2022750034_1565858564"
    addChildAuto(self._layoutUU, node_211409044_1565858315, node_2022750034_1565858564, "layout_2022750034_1565858564")
------程序生成区块结束 node_2022750034_1565858564-------
------程序生成区块开始 node_544918020_1565858586-------
    local node_544918020_1565858586 = UI.Component:create()
    node_544918020_1565858586:init()
    node_544918020_1565858586.__uiComposerID = "544918020_1565858586"
    addChildAuto(self._layoutUU, node_211409044_1565858315, node_544918020_1565858586, "layout_544918020_1565858586")
    self._headAnchor = node_544918020_1565858586 -- 暴露名字至self

    -- 用一个包裹节点来确保快速刷新时不会错位
    local headWrapper = UI.Component:create()
    headWrapper:init()
    self._headAnchor:addChild(headWrapper)

    Avalon.WidgetUtil:getHeadByData(self, 1, 2020401, {}, self, handler(self, function(self, pic)
        if (not tolua.isnull(headWrapper)) then
            headWrapper:addChild(pic)
        end
    end))
------程序生成区块结束 node_544918020_1565858586-------
------程序生成区块开始 node_1160609870_1565858630-------
    local node_1160609870_1565858630 = UI.Button:create()
    node_1160609870_1565858630:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    node_1160609870_1565858630:setText(LanguageManager:getInstance():getLocalString(1112644) --[["解除关系"]])
    node_1160609870_1565858630:setTextFont(UI.FONT_BOLD, 20, {r = 50, g = 50, b = 44})
    node_1160609870_1565858630:setInterval(1)
    node_1160609870_1565858630:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(LanguageManager:getInstance():getLocalString(1112645) --[["确定要断绝关系?"]], function()
            mvc.apprenticeshipController:cancelMentor()
        end)
    end)
    node_1160609870_1565858630:setLocalZOrder(10)
    node_1160609870_1565858630:hide()
    node_1160609870_1565858630.__uiComposerID = "1160609870_1565858630"
    addChildAuto(self._layoutUU, node_211409044_1565858315, node_1160609870_1565858630, "layout_1160609870_1565858630")
    self._cancelMentor = node_1160609870_1565858630 -- 暴露名字至self
------程序生成区块结束 node_1160609870_1565858630-------
------程序生成区块开始 node_1564946250_1565858697-------
    local node_1564946250_1565858697 = UI.Text:create()
    node_1564946250_1565858697:init(LanguageManager:getInstance():getLocalString(1112646) --[["导师名字"]], UI.SYS_FONT, 16, {r = 41, g = 41, b = 45})
    node_1564946250_1565858697:useDefaultOutLineShadowStyle()
    node_1564946250_1565858697.__uiComposerID = "1564946250_1565858697"
    addChildAuto(self._layoutUU, node_211409044_1565858315, node_1564946250_1565858697, "layout_1564946250_1565858697")
    self._mentorName = node_1564946250_1565858697 -- 暴露名字至self
------程序生成区块结束 node_1564946250_1565858697-------
------程序生成区块开始 node_34894140_1565884709-------
    local node_34894140_1565884709 = UI.Button:create()
    node_34894140_1565884709:init("ui_mentor_box.png", "ui_mentor_box.png", "ui_mentor_box.png")
    node_34894140_1565884709:setInterval(1)
    node_34894140_1565884709:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.apprenticeshipController:apprenticeMentorInteract(1)
    end)
    node_34894140_1565884709.__uiComposerID = "34894140_1565884709"
    addChildAuto(self._layoutUU, node_211409044_1565858315, node_34894140_1565884709, "layout_34894140_1565884709")
    self._btnMentorGood = node_34894140_1565884709 -- 暴露名字至self

    local normal = UI.Image:create()
    normal:init("ui_mentor_icon_good_0.png")
    normal:center(4, -1)
    node_34894140_1565884709:setNormalNode(normal)

    local active = UI.Image:create()
    active:init("ui_mentor_icon_good_1.png")
    active:center(4, -1)
    node_34894140_1565884709:setSelectedNode(active)
------程序生成区块结束 node_34894140_1565884709-------
------程序生成区块开始 node_1277345129_1565885153-------
    local node_1277345129_1565885153 = UI.Button:create()
    node_1277345129_1565885153:init("ui_mentor_box.png", "ui_mentor_box.png", "ui_mentor_box.png")
    node_1277345129_1565885153:setInterval(1)
    node_1277345129_1565885153:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.apprenticeshipController:apprenticeMentorInteract(2)
    end)
    node_1277345129_1565885153.__uiComposerID = "1277345129_1565885153"
    addChildAuto(self._layoutUU, node_211409044_1565858315, node_1277345129_1565885153, "layout_1277345129_1565885153")
    self._btnMentorBad = node_1277345129_1565885153 -- 暴露名字至self

    local normal = UI.Image:create()
    normal:init("ui_mentor_icon_lose_0.png")
    normal:center(1, 3)
    node_1277345129_1565885153:setNormalNode(normal)

    local active = UI.Image:create()
    active:init("ui_mentor_icon_lose_1.png")
    active:center(1, 3)
    node_1277345129_1565885153:setSelectedNode(active)
------程序生成区块结束 node_1277345129_1565885153-------
end

function ApprenticeshipApprenticeView:onUpdateView()
    self:updateMentorData()
    self:updateQuestDone()
    self:updateCommitStateView()

    -- if (self._closeFromUpdate) then
    --     performWithDelay(self, function() 
    --         mvc.closePanel("Apprenticeship", "apprenticeshipApprentice")
    --     end, 0.01)
    -- end
end 

-- 更新显示奖励界面
function ApprenticeshipApprenticeView:updateCommitStateView()
    if (mvc.apprenticeshipModel:apprenticeIsAbleToGetQuestReward() or mvc.apprenticeshipModel:apprenticeIsAllCommitted()) then
        mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipApprenticeQuestView, true)   
        mvc.apprenticeshipController:showView(mvc.apprenticeshipApprenticePanel, mvc.apprenticeshipApprenticeResultView)
    else
        mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipApprenticeResultView, true)   
        mvc.apprenticeshipController:showView(mvc.apprenticeshipApprenticePanel, mvc.apprenticeshipApprenticeQuestView)
    end
end

-- 更新显示上报按钮
function ApprenticeshipApprenticeView:updateQuestDone()
    self._btnCommit:show()
    if (mvc.apprenticeshipModel:apprenticeIsAbleToGetQuestReward() or mvc.apprenticeshipModel:apprenticeIsAllCommitted()) then
        self._btnCommit:hide()
        return
    elseif (mvc.apprenticeshipModel:apprenticeIsQuestCommitted()) then
        self._btnCommit:disable()
        return
    end

    if (mvc.apprenticeshipModel:apprenticeIsSelfQuestDone()) then
        self._btnCommit:enable()
    else
        self._btnCommit:disable()
    end
end

-- 更新显示导师信息
function ApprenticeshipApprenticeView:updateMentorData()
    local mentorData = mvc.apprenticeshipModel:getMentor()
    if (mentorData) then
        -- 更新头像
        if (mentorData.sex and mentorData.faceDecodeID) then
            self._headAnchor:show()
            self._headAnchor:removeAllChildren()
            
            -- 用一个包裹节点来确保快速刷新时不会错位
            local headWrapper = UI.Component:create()
            headWrapper:init()
            self._headAnchor:addChild(headWrapper)

            Avalon.WidgetUtil:getHeadByData(self, mentorData.sex, mentorData.faceDecodeID, {}, self, handler(self, function(self, pic)
                if (not tolua.isnull(headWrapper)) then
                    headWrapper:addChild(pic)
                end
            end))
        else
            self._headAnchor:hide()
        end

        -- 更新名字
        if (mentorData.nickName) then
            self._mentorName:show()
            self._mentorName:setText(mentorData.nickName)
        else
            self._mentorName:hide()
        end

        -- 更新等级
        if (mentorData.roleLV) then
            self._mentorLV:show()
            self._mentorLV:setText(mentorData.roleLV)
        else
            self._mentorLV:hide()
        end
    else
        self._headAnchor:hide()
        self._mentorName:hide()
        self._mentorLV:hide()
        self._closeFromUpdate = true
    end
end

-- 显示隐藏解除关系按钮
function ApprenticeshipApprenticeView:toggleCancelMentorButton()
    self._cancelMentor:setVisible(not self._cancelMentor:isVisible()) 
end


function ApprenticeshipApprenticeView:bindModel()

end


function ApprenticeshipApprenticeView:unbindModel()

end





return ApprenticeshipApprenticeView












