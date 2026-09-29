------------------------------------------------------------------------------
--author: 
--date	: 2019/07/31
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipApplyView = class("ApprenticeshipApplyView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_mentor.plist",
    "ui_town_teammate.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
function ApprenticeshipApplyView:ctor()
    ApprenticeshipApplyView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipApplyView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipApplyView.super.init(self, ...) 
    mvc.apprenticeshipController:requestRecommendTutorList()
end

function ApprenticeshipApplyView:dtor() 
    ApprenticeshipApplyView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipApplyView")
end

function ApprenticeshipApplyView:onInitView()
------程序生成区块开始 node_1967701085_1565363603-------
    local node_1967701085_1565363603 = UI.Image:create()
    node_1967701085_1565363603:init('ui_team_banner_board.png')
    node_1967701085_1565363603.__uiComposerID = "1967701085_1565363603"
    addChildAuto(self._layoutUU, self, node_1967701085_1565363603, "layout_1967701085_1565363603")
    mvc.apprenticeshipApplyPanel.ui:setSize(node_1967701085_1565363603:getSize())
    mvc.apprenticeshipApplyPanel.ui:center()
    self:center()
------程序生成区块结束 node_1967701085_1565363603-------
------程序生成区块开始 node_1630748166_1565363635-------
    local node_1630748166_1565363635 = UI.Button:create()
    node_1630748166_1565363635:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    node_1630748166_1565363635:setText(LanguageManager:getInstance():getLocalString(1112630) --[["查看资料"]])
    node_1630748166_1565363635:setTextFont(UI.FONT_BOLD, 20, {r = 50, g = 50, b = 44})
    node_1630748166_1565363635:setInterval(1)
    node_1630748166_1565363635:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (not self._selectedIdx) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112631) --[["请选择导师"]])
            return 
        end

        mvc.apprenticeshipController:viewRecommendMentorDetail(self._selectedIdx)
    end)
    node_1630748166_1565363635.__uiComposerID = "1630748166_1565363635"
    addChildAuto(self._layoutUU, node_1967701085_1565363603, node_1630748166_1565363635, "layout_1630748166_1565363635")
    self._btnDetail = node_1630748166_1565363635 -- 暴露名字至self
------程序生成区块结束 node_1630748166_1565363635-------
------程序生成区块开始 node_399528582_1565363638-------
    local node_399528582_1565363638 = UI.Button:create()
    node_399528582_1565363638:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    node_399528582_1565363638:setText(LanguageManager:getInstance():getLocalString(1112628) --[["申请指导"]])
    node_399528582_1565363638:setTextFont(UI.FONT_BOLD, 20, {r = 50, g = 50, b = 44})
    node_399528582_1565363638:setInterval(1)
    node_399528582_1565363638:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (not self._selectedIdx) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112631) --[["请选择导师"]])
            return 
        end
        mvc.apprenticeshipController:applyForMentor(self._selectedIdx)
        mvc.closePanel("Apprenticeship", "ApprenticeshipApply")
    end)
    node_399528582_1565363638.__uiComposerID = "399528582_1565363638"
    addChildAuto(self._layoutUU, node_1967701085_1565363603, node_399528582_1565363638, "layout_399528582_1565363638")
    self._btnApply = node_399528582_1565363638 -- 暴露名字至self
------程序生成区块结束 node_399528582_1565363638-------
------程序生成区块开始 node_74990422_1565363858-------
    local node_74990422_1565363858 = UI.Text:create()
    node_74990422_1565363858:init(LanguageManager:getInstance():getLocalString(1112632) --[["导师推荐"]], UI.FONT_BOLD, 20, {r = 41, g = 41, b = 45})
    node_74990422_1565363858.__uiComposerID = "74990422_1565363858"
    addChildAuto(self._layoutUU, node_1967701085_1565363603, node_74990422_1565363858, "layout_74990422_1565363858")
------程序生成区块结束 node_74990422_1565363858-------
------程序生成区块开始 node_1049112444_1565363869-------
    local node_1049112444_1565363869 = UI.Button:create()
    node_1049112444_1565363869:init("ui_btn_try_0.png", "ui_btn_try_0.png", "ui_btn_try_0.png")
    node_1049112444_1565363869:setInterval(1)
    self._refreshBtn = node_1049112444_1565363869 -- 暴露名字至self
    node_1049112444_1565363869.__uiComposerID = "1049112444_1565363869"
    addChildAuto(self._layoutUU, node_1967701085_1565363603, node_1049112444_1565363869, "layout_1049112444_1565363869")
    node_1049112444_1565363869:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.apprenticeshipController:requestRecommendTutorList(true)
    end)
------程序生成区块结束 node_1049112444_1565363869-------
------程序生成区块开始 node_78464540_1565458948-------
    local node_78464540_1565458948 = UI.Layout:create()
    node_78464540_1565458948:init()
    node_78464540_1565458948:setSize(171, 196)
    node_78464540_1565458948.__uiComposerID = "78464540_1565458948"
    addChildAuto(self._layoutUU, node_1967701085_1565363603, node_78464540_1565458948, "layout_78464540_1565458948")
    self._mentorLayout1 = node_78464540_1565458948 -- 暴露名字至self
    self._mentorLayout1:setTouchEnable(true)
    self._mentorLayout1:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:setSelected(1)
    end)
------程序生成区块结束 node_78464540_1565458948-------
------程序生成区块开始 node_765579157_1565458967-------
    local node_765579157_1565458967 = UI.Image:create()
    node_765579157_1565458967:init('ui_team_banner_portrait_01.png')
    node_765579157_1565458967:setLocalZOrder(1)
    node_765579157_1565458967.__uiComposerID = "765579157_1565458967"
    addChildAuto(self._layoutUU, node_78464540_1565458948, node_765579157_1565458967, "layout_765579157_1565458967")
------程序生成区块结束 node_765579157_1565458967-------
------程序生成区块开始 node_1226201689_1565459019-------
    local node_1226201689_1565459019 = UI.Component:create()
    node_1226201689_1565459019:init()
    node_1226201689_1565459019.__uiComposerID = "1226201689_1565459019"
    addChildAuto(self._layoutUU, node_78464540_1565458948, node_1226201689_1565459019, "layout_1226201689_1565459019")
    self._headAnchor1 = node_1226201689_1565459019 -- 暴露名字至self
------程序生成区块结束 node_1226201689_1565459019-------
------程序生成区块开始 node_1827397260_1565459573-------
    local node_1827397260_1565459573 = UI.Text:create()
    node_1827397260_1565459573:init("lv.16", UI.FONT_BOLD, 16, {r = 41, g = 41, b = 45})
    node_1827397260_1565459573:autoAdapt()
    node_1827397260_1565459573.__uiComposerID = "1827397260_1565459573"
    addChildAuto(self._layoutUU, node_765579157_1565458967, node_1827397260_1565459573, "layout_1827397260_1565459573")
    self._mentorLv1 = node_1827397260_1565459573 -- 暴露名字至self
------程序生成区块结束 node_1827397260_1565459573-------
------程序生成区块开始 node_679846057_1565460614-------
    local node_679846057_1565460614 = UI.Text:create()
    node_679846057_1565460614:init(LanguageManager:getInstance():getLocalString(1112634) --[["玩家名字八个字哟"]], UI.SYS_FONT, 16, {r = 41, g = 41, b = 45})
    node_679846057_1565460614:autoAdapt()
    node_679846057_1565460614.__uiComposerID = "679846057_1565460614"
    addChildAuto(self._layoutUU, node_765579157_1565458967, node_679846057_1565460614, "layout_679846057_1565460614")
    self._mentorName1 = node_679846057_1565460614 -- 暴露名字至self
------程序生成区块结束 node_679846057_1565460614-------
------程序生成区块开始 node_286956205_1565460646-------
    local node_286956205_1565460646 = UI.Layout:create()
    node_286956205_1565460646:init()
    node_286956205_1565460646:setSize(171, 196)
    node_286956205_1565460646.__uiComposerID = "286956205_1565460646"
    addChildAuto(self._layoutUU, node_1967701085_1565363603, node_286956205_1565460646, "layout_286956205_1565460646")
    self._mentorLayout2 = node_286956205_1565460646 -- 暴露名字至self
    self._mentorLayout2:setTouchEnable(true)
    self._mentorLayout2:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:setSelected(2)
    end)
------程序生成区块结束 node_286956205_1565460646-------
------程序生成区块开始 node_936429350_1565460646-------
    local node_936429350_1565460646 = UI.Image:create()
    node_936429350_1565460646:init('ui_team_banner_portrait_01.png')
    node_936429350_1565460646:setLocalZOrder(1)
    node_936429350_1565460646.__uiComposerID = "936429350_1565460646"
    addChildAuto(self._layoutUU, node_286956205_1565460646, node_936429350_1565460646, "layout_936429350_1565460646")
------程序生成区块结束 node_936429350_1565460646-------
------程序生成区块开始 node_1036863326_1565460646-------
    local node_1036863326_1565460646 = UI.Text:create()
    node_1036863326_1565460646:init("lv.16", UI.FONT_BOLD, 16, {r = 41, g = 41, b = 45})
    node_1036863326_1565460646:autoAdapt()
    node_1036863326_1565460646.__uiComposerID = "1036863326_1565460646"
    addChildAuto(self._layoutUU, node_936429350_1565460646, node_1036863326_1565460646, "layout_1036863326_1565460646")
    self._mentorLv2 = node_1036863326_1565460646 -- 暴露名字至self
------程序生成区块结束 node_1036863326_1565460646-------
------程序生成区块开始 node_468664464_1565460646-------
    local node_468664464_1565460646 = UI.Text:create()
    node_468664464_1565460646:init(LanguageManager:getInstance():getLocalString(1112634) --[["玩家名字八个字哟"]], UI.SYS_FONT, 16, {r = 41, g = 41, b = 45})
    node_468664464_1565460646:autoAdapt()
    node_468664464_1565460646.__uiComposerID = "468664464_1565460646"
    addChildAuto(self._layoutUU, node_936429350_1565460646, node_468664464_1565460646, "layout_468664464_1565460646")
    self._mentorName2 = node_468664464_1565460646 -- 暴露名字至self
------程序生成区块结束 node_468664464_1565460646-------
------程序生成区块开始 node_1252091463_1565460646-------
    local node_1252091463_1565460646 = UI.Component:create()
    node_1252091463_1565460646:init()
    node_1252091463_1565460646.__uiComposerID = "1252091463_1565460646"
    addChildAuto(self._layoutUU, node_286956205_1565460646, node_1252091463_1565460646, "layout_1252091463_1565460646")
    self._headAnchor2 = node_1252091463_1565460646 -- 暴露名字至self
------程序生成区块结束 node_1252091463_1565460646-------
------程序生成区块开始 node_1594844372_1565460912-------
    local node_1594844372_1565460912 = UI.Layout:create()
    node_1594844372_1565460912:init()
    node_1594844372_1565460912:setSize(171, 196)
    node_1594844372_1565460912.__uiComposerID = "1594844372_1565460912"
    addChildAuto(self._layoutUU, node_1967701085_1565363603, node_1594844372_1565460912, "layout_1594844372_1565460912")
    self._mentorLayout3 = node_1594844372_1565460912 -- 暴露名字至self
    self._mentorLayout3:setTouchEnable(true)
    self._mentorLayout3:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:setSelected(3)
    end)
------程序生成区块结束 node_1594844372_1565460912-------
------程序生成区块开始 node_339340926_1565460912-------
    local node_339340926_1565460912 = UI.Image:create()
    node_339340926_1565460912:init('ui_team_banner_portrait_01.png')
    node_339340926_1565460912:setLocalZOrder(1)
    node_339340926_1565460912.__uiComposerID = "339340926_1565460912"
    addChildAuto(self._layoutUU, node_1594844372_1565460912, node_339340926_1565460912, "layout_339340926_1565460912")
------程序生成区块结束 node_339340926_1565460912-------
------程序生成区块开始 node_1452141140_1565460912-------
    local node_1452141140_1565460912 = UI.Text:create()
    node_1452141140_1565460912:init("lv.16", UI.FONT_BOLD, 16, {r = 41, g = 41, b = 45})
    node_1452141140_1565460912:autoAdapt()
    node_1452141140_1565460912.__uiComposerID = "1452141140_1565460912"
    addChildAuto(self._layoutUU, node_339340926_1565460912, node_1452141140_1565460912, "layout_1452141140_1565460912")
    self._mentorLv3 = node_1452141140_1565460912 -- 暴露名字至self
------程序生成区块结束 node_1452141140_1565460912-------
------程序生成区块开始 node_1382270584_1565460912-------
    local node_1382270584_1565460912 = UI.Text:create()
    node_1382270584_1565460912:init(LanguageManager:getInstance():getLocalString(1112634) --[["玩家名字八个字哟"]], UI.SYS_FONT, 16, {r = 41, g = 41, b = 45})
    node_1382270584_1565460912:autoAdapt()
    node_1382270584_1565460912.__uiComposerID = "1382270584_1565460912"
    addChildAuto(self._layoutUU, node_339340926_1565460912, node_1382270584_1565460912, "layout_1382270584_1565460912")
    self._mentorName3 = node_1382270584_1565460912 -- 暴露名字至self
------程序生成区块结束 node_1382270584_1565460912-------
------程序生成区块开始 node_714358302_1565460912-------
    local node_714358302_1565460912 = UI.Component:create()
    node_714358302_1565460912:init()
    node_714358302_1565460912.__uiComposerID = "714358302_1565460912"
    addChildAuto(self._layoutUU, node_1594844372_1565460912, node_714358302_1565460912, "layout_714358302_1565460912")
    self._headAnchor3 = node_714358302_1565460912 -- 暴露名字至self
------程序生成区块结束 node_714358302_1565460912-------
------程序生成区块开始 node_403394397_1565636287-------
    local node_403394397_1565636287 = UI.Animation:create()
    node_403394397_1565636287:init("effect_ui_general_mentor_xuanzhong.json", "effect_ui_general_mentor_xuanzhong.atlas", 1);
    node_403394397_1565636287:setAnimation("idle", true)
    node_403394397_1565636287:setLocalZOrder(5)
    node_403394397_1565636287.__uiComposerID = "403394397_1565636287"
    addChildAuto(self._layoutUU, node_78464540_1565458948, node_403394397_1565636287, "layout_403394397_1565636287")
    self._aniSelected1 = node_403394397_1565636287 -- 暴露名字至self
------程序生成区块结束 node_403394397_1565636287-------
------程序生成区块开始 node_1260782059_1565636427-------
    local node_1260782059_1565636427 = UI.Animation:create()
    node_1260782059_1565636427:init("effect_ui_general_mentor_xuanzhong.json", "effect_ui_general_mentor_xuanzhong.atlas", 1);
    node_1260782059_1565636427:setAnimation("idle", true)
    node_1260782059_1565636427:setLocalZOrder(5)
    node_1260782059_1565636427.__uiComposerID = "1260782059_1565636427"
    addChildAuto(self._layoutUU, node_286956205_1565460646, node_1260782059_1565636427, "layout_1260782059_1565636427")
    self._aniSelected2 = node_1260782059_1565636427 -- 暴露名字至self
------程序生成区块结束 node_1260782059_1565636427-------
------程序生成区块开始 node_462707503_1565636498-------
    local node_462707503_1565636498 = UI.Animation:create()
    node_462707503_1565636498:init("effect_ui_general_mentor_xuanzhong.json", "effect_ui_general_mentor_xuanzhong.atlas", 1);
    node_462707503_1565636498:setAnimation("idle", true)
    node_462707503_1565636498:setLocalZOrder(5)
    node_462707503_1565636498.__uiComposerID = "462707503_1565636498"
    addChildAuto(self._layoutUU, node_1594844372_1565460912, node_462707503_1565636498, "layout_462707503_1565636498")
    self._aniSelected3 = node_462707503_1565636498 -- 暴露名字至self
------程序生成区块结束 node_462707503_1565636498-------
end

function ApprenticeshipApplyView:onUpdateView()
    self:updateRecommendView()
end

function ApprenticeshipApplyView:updateRecommendView()
    self._selectedIdx = nil
    self:updateSelectedView()

    local mentorData = mvc.apprenticeshipModel:getMentorRecommendationList()
    if (not mentorData) then mentorData = {} end

    local mentorLayouts = {self._mentorLayout1, self._mentorLayout2, self._mentorLayout3}
    local mentorNames = {self._mentorName1, self._mentorName2, self._mentorName3}
    local mentorLvs = {self._mentorLv1, self._mentorLv2, self._mentorLv3}
    local headAnchors = {self._headAnchor1, self._headAnchor2, self._headAnchor3}
    local selectAnis = {self._aniSelected1, self._aniSelected2, self._aniSelected3}
    for i=1,3 do
        local data = mentorData[i]
        local layout = mentorLayouts[i]
        local name = mentorNames[i]
        local lv = mentorLvs[i]
        local headAnchor = headAnchors[i]
        local selectedAni = selectAnis[i]
        if (data) then
            layout:show()

            -- 更新名字显示
            if (data.nickName) then
                name:show()
                name:setText(data.nickName)
            else
                name:hide()
            end

            -- 更新等级显示
            if (data.roleLV) then
                lv:show()
                lv:setText("Lv." .. data.roleLV)
            else
                lv:hide()
            end

            -- 更新头像显示
            if (data.sex and data.faceDecodeID) then
                headAnchor:removeAllChildren()
                
                -- 用一个包裹节点来确保快速刷新时不会错位
                local headWrapper = UI.Component:create()
                headWrapper:init()
                headAnchor:addChild(headWrapper)

                Avalon.WidgetUtil:getHeadByData(self, data.sex, data.faceDecodeID, {}, self, handler(self, function(self, pic)
                    if (not tolua.isnull(headWrapper)) then
                        headWrapper:addChild(pic)
                    end
                end))
            end
        else
            layout:hide()
        end
    end
end

function ApprenticeshipApplyView:updateSelectedView()
    -- 更新选中动画
    local selectedAnis = {self._aniSelected1, self._aniSelected2, self._aniSelected3}
    for i,selectedAni in ipairs(selectedAnis) do
        if (self._selectedIdx == i) then
            selectedAni:show()
        else
            selectedAni:hide()
        end
    end
end

function ApprenticeshipApplyView:setSelected(idx)
    self._selectedIdx = idx
    self:updateSelectedView()
end

function ApprenticeshipApplyView:bindModel()

end


function ApprenticeshipApplyView:unbindModel()

end





return ApprenticeshipApplyView












