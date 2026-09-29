------------------------------------------------------------------------------
--author: 
--date	: 2019/07/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipMentorView = class("ApprenticeshipMentorView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_mentor.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local TAB_INDICES = {
    QUEST = 1,
    RESULT = 2
}


function ApprenticeshipMentorView:ctor(apprenticeIdx)
    self._apprenticeIdx = apprenticeIdx
    ApprenticeshipMentorView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipMentorView:dtor()
    ApprenticeshipMentorView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipMentorView")
end

function ApprenticeshipMentorView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipMentorView.super.init(self, ...)
    mvc.apprenticeshipController:mentorUpdateApprenticeInfoByIndex(self._apprenticeIdx)
end


function ApprenticeshipMentorView:onInitView()
------程序生成区块开始 node_111105854_1565163119-------
    local node_111105854_1565163119 = UI.Image:create()
    node_111105854_1565163119:init('ui_bg_box1.png')
    node_111105854_1565163119.__uiComposerID = "111105854_1565163119"
    addChildAuto(self._layoutUU, self, node_111105854_1565163119, "layout_111105854_1565163119")
    mvc.apprenticeshipMentorPanel.ui:setSize(node_111105854_1565163119:getSize())
    mvc.apprenticeshipMentorPanel.ui:center()
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
------程序生成区块开始 node_837035066_1565260236-------
    local node_837035066_1565260236 = UI.Layout:create()
    node_837035066_1565260236:init()
    node_837035066_1565260236:setSize(186, 376)
    node_837035066_1565260236.__uiComposerID = "837035066_1565260236"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_837035066_1565260236, "layout_837035066_1565260236")
------程序生成区块结束 node_837035066_1565260236-------
------程序生成区块开始 node_1077044860_1565859983-------
    local node_1077044860_1565859983 = UI.Animation:create()
    node_1077044860_1565859983:init("effect_ui_general_mentor_qizi.json", "effect_ui_general_mentor_qizi.atlas", 1);
    node_1077044860_1565859983:setAnimation("idle", true)
    node_1077044860_1565859983.__uiComposerID = "1077044860_1565859983"
    addChildAuto(self._layoutUU, node_837035066_1565260236, node_1077044860_1565859983, "layout_1077044860_1565859983")
------程序生成区块结束 node_1077044860_1565859983-------
------程序生成区块开始 node_1125760208_1565260400-------
    local node_1125760208_1565260400 = UI.Component:create()
    node_1125760208_1565260400:init()
    node_1125760208_1565260400.__uiComposerID = "1125760208_1565260400"
    addChildAuto(self._layoutUU, node_837035066_1565260236, node_1125760208_1565260400, "layout_1125760208_1565260400")
    self._headAnchor = node_1125760208_1565260400 -- 暴露名字至self

    -- 用一个包裹节点来确保快速刷新时不会错位
    local headWrapper = UI.Component:create()
    headWrapper:init()
    node_1125760208_1565260400:addChild(headWrapper)

    Avalon.WidgetUtil:getHeadByData(self, 1, 2020401, {}, self, handler(self, function(self, pic)
        if (not tolua.isnull(headWrapper)) then
            headWrapper:addChild(pic)
        end
    end))
------程序生成区块结束 node_1125760208_1565260400-------
------程序生成区块开始 node_2129253936_1565260442-------
    local node_2129253936_1565260442 = UI.Image:create()
    node_2129253936_1565260442:init('ui_information_headframe_box.png')
    node_2129253936_1565260442:setLocalZOrder(1)
    node_2129253936_1565260442.__uiComposerID = "2129253936_1565260442"
    addChildAuto(self._layoutUU, node_837035066_1565260236, node_2129253936_1565260442, "layout_2129253936_1565260442")
------程序生成区块结束 node_2129253936_1565260442-------
------程序生成区块开始 node_861936980_1565264809-------
    local node_861936980_1565264809 = UI.Image:create()
    node_861936980_1565264809:init('ui_information_headframe_box2.png')
    node_861936980_1565264809:setLocalZOrder(2)
    node_861936980_1565264809.__uiComposerID = "861936980_1565264809"
    addChildAuto(self._layoutUU, node_837035066_1565260236, node_861936980_1565264809, "layout_861936980_1565264809")
    node_861936980_1565264809:setTouchEnable(true)
    node_861936980_1565264809:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:toggleCancelMentorButton()
    end)
------程序
------程序生成区块结束 node_861936980_1565264809-------
------程序生成区块开始 node_1788732973_1565264864-------
    local node_1788732973_1565264864 = UI.Image:create()
    node_1788732973_1565264864:init('ui_information_headframe_grade.png')
    node_1788732973_1565264864.__uiComposerID = "1788732973_1565264864"
    addChildAuto(self._layoutUU, node_861936980_1565264809, node_1788732973_1565264864, "layout_1788732973_1565264864")
------程序生成区块结束 node_1788732973_1565264864-------
------程序生成区块开始 node_530247515_1565266573-------
    local node_530247515_1565266573 = UI.Text:create()
    node_530247515_1565266573:init("16", UI.FONT_STANDARD, 16, {r = 189, g = 167, b = 136})
    node_530247515_1565266573.__uiComposerID = "530247515_1565266573"
    addChildAuto(self._layoutUU, node_1788732973_1565264864, node_530247515_1565266573, "layout_530247515_1565266573")
    self._apprenticeLV = node_530247515_1565266573 -- 暴露名字至self
------程序生成区块结束 node_530247515_1565266573-------
------程序生成区块开始 node_178013305_1565266674-------
    local node_178013305_1565266674 = UI.Text:create()
    node_178013305_1565266674:init(LanguageManager:getInstance():getLocalString(1112674) --[["徒弟名字"]], UI.SYS_FONT, 16, {r = 41, g = 41, b = 45})
    node_178013305_1565266674:useDefaultOutLineShadowStyle()
    node_178013305_1565266674.__uiComposerID = "178013305_1565266674"
    addChildAuto(self._layoutUU, node_837035066_1565260236, node_178013305_1565266674, "layout_178013305_1565266674")
    self._apprenticeName = node_178013305_1565266674 -- 暴露名字至self
------程序生成区块结束 node_178013305_1565266674-------
------程序生成区块开始 node_1950906253_1565290086-------
    local node_1950906253_1565290086 = UI.TabList:create()
    node_1950906253_1565290086:init(2, nil, nil, true)
    node_1950906253_1565290086.__tabWidth = 109
    node_1950906253_1565290086.__tabHeight = 68
    node_1950906253_1565290086:setTouchEnable(true)
    node_1950906253_1565290086:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex, lastIndex)
        self:switchView(tabIndex, lastIndex)
    end)
    node_1950906253_1565290086:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    node_1950906253_1565290086:setReverseOrder(true)
    self._tabLayout = node_1950906253_1565290086 -- 暴露名字至self
    node_1950906253_1565290086.__uiComposerID = "1950906253_1565290086"
    addChildAuto(self._layoutUU, node_111105854_1565163119, node_1950906253_1565290086, "layout_1950906253_1565290086")
    
    local node_1950906253_1565290086_sub1 = UI.TabItem:create()
    node_1950906253_1565290086_sub1:init("ui_btn_gray2_0.png", "ui_btn_gray2_1.png")
    node_1950906253_1565290086_sub1:setSize(node_1950906253_1565290086.__tabWidth, node_1950906253_1565290086.__tabHeight)
    node_1950906253_1565290086_sub1:alignLeft(true)
    node_1950906253_1565290086_sub1:setSwallowTouches(true)
    node_1950906253_1565290086_sub1:setChangeScale(false)
    node_1950906253_1565290086:addToTab(node_1950906253_1565290086_sub1, 1)
    node_1950906253_1565290086_sub1.__uiComposerID = "1950906253_1565290086_sub1"
    self._layoutUU:autoPos(node_1950906253_1565290086_sub1, "layout_1950906253_1565290086_sub1")
------程序生成区块结束 node_1950906253_1565290086-------
------程序生成区块开始 node_1330082600_1565291622-------
    local node_1330082600_1565291622 = UI.TabItem:create()
    node_1330082600_1565291622:init("ui_btn_gray2_0.png", "ui_btn_gray2_1.png")
    node_1330082600_1565291622:setSize(node_1950906253_1565290086.__tabWidth, node_1950906253_1565290086.__tabHeight)
    node_1330082600_1565291622:alignLeft(true)
    node_1330082600_1565291622:setSwallowTouches(true)
    node_1330082600_1565291622:setChangeScale(false)
    node_1950906253_1565290086:addToTab(node_1330082600_1565291622, 2)
    node_1330082600_1565291622.__uiComposerID = "1330082600_1565291622"
    self._layoutUU:autoPos(node_1330082600_1565291622, "layout_1330082600_1565291622")
------程序生成区块结束 node_1330082600_1565291622-------
------程序生成区块开始 node_2098425623_1565291915-------
    local node_2098425623_1565291915 = UI.Text:create()
    node_2098425623_1565291915:init(LanguageManager:getInstance():getLocalString(1112675) --[["任务"]], UI.FONT_BOLD, 20, {r = 41, g = 41, b = 45})
    node_2098425623_1565291915.__uiComposerID = "2098425623_1565291915"
    addChildAuto(self._layoutUU, node_1950906253_1565290086_sub1, node_2098425623_1565291915, "layout_2098425623_1565291915")
    self._textQuestTab = node_2098425623_1565291915 -- 暴露名字至self
------程序生成区块结束 node_2098425623_1565291915-------
------程序生成区块开始 node_1056516261_1565291984-------
    local node_1056516261_1565291984 = UI.Text:create()
    node_1056516261_1565291984:init(LanguageManager:getInstance():getLocalString(1112676) --[["成果"]], UI.FONT_BOLD, 20, {r = 41, g = 41, b = 45})
    node_1056516261_1565291984.__uiComposerID = "1056516261_1565291984"
    addChildAuto(self._layoutUU, node_1330082600_1565291622, node_1056516261_1565291984, "layout_1056516261_1565291984")
    self._textResultTab = node_1056516261_1565291984 -- 暴露名字至self
------程序生成区块结束 node_1056516261_1565291984-------
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
                mvc.apprenticeshipMentorPanel, 
                mvc.apprenticeshipExplainView, 
                100, 
                LanguageManager:getInstance():getLocalString(1112627))
        end
    end)
    -- node_218251281_1565322930:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
    --     mvc.apprenticeshipController:showView(
    --         mvc.apprenticeshipMentorPanel, 
    --         mvc.apprenticeshipExplainView, 
    --         100, 
    --         LanguageManager:getInstance():getLocalString(1112626))
    -- end)
    -- node_218251281_1565322930:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
    --     mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipExplainView, true)
    -- end)
------程序生成区块结束 node_218251281_1565322930-------
------程序生成区块开始 node_1264180240_1565320821-------
    local node_1264180240_1565320821 = UI.Image9:create()
    node_1264180240_1565320821:init("ui_scale9image_banner_line_long.png", CCRectMake(20,1,1,1), cc.size(468, 2))
    node_1264180240_1565320821.__uiComposerID = "1264180240_1565320821"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_1264180240_1565320821, "layout_1264180240_1565320821")
------程序生成区块结束 node_1264180240_1565320821-------
------程序生成区块开始 node_2119858475_1565533930-------
    local node_2119858475_1565533930 = UI.Button:create()
    node_2119858475_1565533930:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    node_2119858475_1565533930:setText(LanguageManager:getInstance():getLocalString(1112677) --[["任务确认"]])
    node_2119858475_1565533930:setTextFont(UI.FONT_BOLD, 18, {r = 41, g = 41, b = 45})
    node_2119858475_1565533930:setInterval(1)
    node_2119858475_1565533930:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.apprenticeshipController:mentorConfirmQuestByIndex(self._apprenticeIdx)
    end)
    node_2119858475_1565533930:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if (mvc.apprenticeshipModel:mentorIsSelfQuestCommittedByIndex(self._apprenticeIdx)) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112678) --[["任务已经确认, 等待学徒确认中..."]])
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112679) --[["学徒完成所有任务后才能确认提交"]])
        end
    end)
    node_2119858475_1565533930.__uiComposerID = "2119858475_1565533930"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_2119858475_1565533930, "layout_2119858475_1565533930")
    self._btnCommit = node_2119858475_1565533930 -- 暴露名字至self
------程序生成区块结束 node_2119858475_1565533930-------
------程序生成区块开始 node_1925931382_1565800309-------
local node_1925931382_1565800309 = UI.Button:create()
    node_1925931382_1565800309:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    node_1925931382_1565800309:setText(LanguageManager:getInstance():getLocalString(1112644) --[["解除关系"]])
    node_1925931382_1565800309:setTextFont(UI.FONT_BOLD, 20, {r = 50, g = 50, b = 44})
    node_1925931382_1565800309:setInterval(1)
    node_1925931382_1565800309:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(LanguageManager:getInstance():getLocalString(1112645) --[["确定要断绝关系?"]], function()
            mvc.apprenticeshipController:cancelApprenticeByIdx(self._apprenticeIdx)
        end)
    end)
    node_1925931382_1565800309:setLocalZOrder(10)
    node_1925931382_1565800309:hide()
    node_1925931382_1565800309.__uiComposerID = "1925931382_1565800309"
    addChildAuto(self._layoutUU, node_837035066_1565260236, node_1925931382_1565800309, "layout_1925931382_1565800309")
    self._cancelMentor = node_1925931382_1565800309 -- 暴露名字至self
------程序生成区块结束 node_1925931382_1565800309-------
end

function ApprenticeshipMentorView:onUpdateView()
    -- 刷新角色数据
    self:updateApprenticeData()
    -- 刷新提交按钮
    self:updateQuestButton()
    -- 刷新页面
    self:updateViewState()

    if (self._closeFromUpdate) then
        performWithDelay(self, function() 
            mvc.closePanel("Apprenticeship", "ApprenticeshipMentor")
        end, 0.01)
    end
end

-- 更新显示提交任务按钮
function ApprenticeshipMentorView:updateQuestButton()
    self._btnCommit:show()
    if (mvc.apprenticeshipModel:mentorIsApprenticeAbleToGetQuestRewardByIndex(self._apprenticeIdx) or
        mvc.apprenticeshipModel:mentorIsAllCommittedByIndex(self._apprenticeIdx)) 
    then
        self._btnCommit:hide()
        return
    elseif (mvc.apprenticeshipModel:mentorIsSelfQuestCommittedByIndex(self._apprenticeIdx)) then
        self._btnCommit:disable()
        return
    end

    if (mvc.apprenticeshipModel:mentorIsApprenticeQuestDoneByIndex(self._apprenticeIdx)) then
        self._btnCommit:enable()
    else
        self._btnCommit:disable()
    end
end

-- 更新徒弟信息
function ApprenticeshipMentorView:updateApprenticeData()
    local apprenticeData = mvc.apprenticeshipModel:getApprenticeByIndex(self._apprenticeIdx)
    if (apprenticeData) then
        -- 更新头像
        if (apprenticeData.sex and apprenticeData.faceDecodeID) then
            self._headAnchor:show()
            self._headAnchor:removeAllChildren()
            
            -- 用一个包裹节点来确保快速刷新时不会错位
            local headWrapper = UI.Component:create()
            headWrapper:init()
            self._headAnchor:addChild(headWrapper)

            Avalon.WidgetUtil:getHeadByData(self, apprenticeData.sex, apprenticeData.faceDecodeID, {}, self, handler(self, function(self, pic)
                if (not tolua.isnull(headWrapper)) then
                    headWrapper:addChild(pic)
                end
            end))
        else
            self._headAnchor:hide()
        end

        -- 更新名字
        if (apprenticeData.nickName) then
            self._apprenticeName:show()
            self._apprenticeName:setText(apprenticeData.nickName)
        else
            self._apprenticeName:hide()
        end

        -- 更新等级
        if (apprenticeData.roleLV) then
            self._apprenticeLV:show()
            self._apprenticeLV:setText(apprenticeData.roleLV)
        else
            self._apprenticeLV:hide()
        end
    else
        self._headAnchor:hide()
        self._apprenticeName:hide()
        self._apprenticeLV:hide()
        self._closeFromUpdate = true
    end
end

-- 更新界面显示
function ApprenticeshipMentorView:updateViewState()
    if (TAB_INDICES.QUEST == self._tabIndex) then
        mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipMentorResultView, true)
        if (mvc.apprenticeshipModel:mentorIsApprenticeAbleToGetQuestRewardByIndex(self._apprenticeIdx) or
            mvc.apprenticeshipModel:mentorIsAllCommittedByIndex(self._apprenticeIdx)) 
        then
            mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipMentorQuestView, true)
            mvc.apprenticeshipController:showView(mvc.apprenticeshipMentorPanel, mvc.apprenticeshipMentorResultDailyView, nil, self._apprenticeIdx)
        else
            mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipMentorResultDailyView, true)
            mvc.apprenticeshipController:showView(mvc.apprenticeshipMentorPanel, mvc.apprenticeshipMentorQuestView, nil, self._apprenticeIdx)
        end
    elseif (TAB_INDICES.RESULT == self._tabIndex) then
        mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipMentorResultDailyView, true)
        mvc.apprenticeshipController:hideView(mvc.apprenticeshipController.apprenticeshipMentorQuestView, true)
        mvc.apprenticeshipController:showView(mvc.apprenticeshipMentorPanel, mvc.apprenticeshipMentorResultView, nil, self._apprenticeIdx)
    end
end

-- 显示隐藏解除关系按钮
function ApprenticeshipMentorView:toggleCancelMentorButton()
    self._cancelMentor:setVisible(not self._cancelMentor:isVisible()) 
end

function ApprenticeshipMentorView:bindModel()

end


function ApprenticeshipMentorView:unbindModel()

end

function ApprenticeshipMentorView:switchView(tabIndex, lastIndex)
    self._tabIndex = tabIndex
    self:updateViewState()

    if (tabIndex == 1) then
        self._textQuestTab:setFontColor({r = 220, g = 211, b = 147})
        self._textQuestTab:center(10, 0)
        self._textResultTab:setFontColor({r = 41, g = 41, b = 45})
        self._textResultTab:center(0, 0)
    elseif (tabIndex == 2) then
        self._textQuestTab:setFontColor({r = 41, g = 41, b = 45})
        self._textQuestTab:center(0, 0)
        self._textResultTab:setFontColor({r = 220, g = 211, b = 147})
        self._textResultTab:center(10, 0)
    end
end



return ApprenticeshipMentorView
