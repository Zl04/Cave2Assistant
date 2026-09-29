------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/09/19
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GreedySelectView = class("GreedySelectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    -- "ui_town_activity.plist"
    "ui_town_catfood.plist",
    "ui_gaming_choice.plist",
    "ui_general_minimap_icon.plist",
}

local GreedyEvent = PublicDefine.GreedyEvent

local COM_WIDTH = 852
local COM_HEIGHT = 534

function GreedySelectView:ctor()
    GreedySelectView.super.ctor(
    	self,
    	UI.Type.GREEDY_SELECT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:center()
    self:bindModel()
end

function GreedySelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.greedyselect", "GreedySelect", __EDIT_)
    GreedySelectView.super.init(self, ... )
end

function GreedySelectView:dtor()
    GreedySelectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.greedyselect.GreedySelectView")
end
--     GreedyEvent_Down = 1;       // 下楼
--     GreedyEvent_Return = 2;     // 回城
--     GreedyEvent_Special = 3;    // 特殊回城
local langMap = {
    [1] = {UI.TEXT_1213259, UI.TEXT_1213260},
    [2] = {UI.TEXT_1213261, UI.TEXT_1213262},
    [3] = {UI.TEXT_1213261, UI.TEXT_1213266},
}
function GreedySelectView:createOneItem(idx)
    local eventIdx, goodsId = mvc.greedySelectModel:getServerSelectInfo(idx)
    -- goodsId = 100001
    local config = mvc.greedySelectModel:getGreedyGoodsConfig(goodsId)
    local com = UI.Component:create()
    com:init()
    com:setSize(180,220)

	local bg = UI.Image:create()
	bg:init("ui_choice_paper.png")
	bg:center()
    com:addChild(bg)
    

    local langArr = langMap[eventIdx]
    local title = UI.Text:create()
    local lang 
    if config.goodsID[1] == 20050010 then
        lang = UIUtil:lang(1090018)
    else
        lang = langArr[1]
    end

    if eventIdx == 2 or eventIdx == 3 then
        title:init(lang, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_170_170_170)
    else
        title:init(lang, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    end
    bg:addChild(title, 5)


    local titleImg 
    if config.goodsID[1] == 20050010 then
        titleImg = "ui_choice_title_1.png"
        title:setFontColor(UI.FONT_COLOR_BLACK)
    elseif eventIdx == 2 or eventIdx == 3 then
        titleImg = "ui_choice_title_2.png"
    end
    if titleImg then
        local titleBg = UI.Image:create()
        titleBg:init(titleImg)
        titleBg:centerUp(0)
        title:centerUp(2)
        bg:addChild(titleBg)
    else
        local splitLine2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        splitLine2:setContentSize(135, 1.1)
        splitLine2:setCapInsets(CCRectMake(1,0,1,1))
        splitLine2:setPosition(85, 185)
        bg:addChild(splitLine2, 10)
        title:centerUp(6)
    end

	local goodsImg = UI.Image:create()
    goodsImg:init(config.icon)
    goodsImg:setScale(0.8)
	goodsImg:center()
    bg:addChild(goodsImg,10)
    

    local nameTxt = UI.Text:create()
    nameTxt:init(UIUtil:lang(config.description), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    nameTxt:centerBottom(22)
    bg:addChild(nameTxt)
    nameTxt:setMaxLineWidth(170)

    local btn = UI.Button:create()
    btn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.send(mvc.events.GREEDY_SELECT_DO_SELECT, true, idx - 1)
        mvc.closePanel("GreedySelect", "GreedySelect")
    end)
    btn:centerBottom(-60)
    com:addChild(btn)
    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    local icon = UI.Image:create()
    
    if eventIdx == 2 or eventIdx == 3 then
        icon:init("ui_choice_icon_1_1.png")
    else
        icon:init("ui_choice_icon_2_2.png")
    end
    icon:floatLeft(0)
    layout:addComponent(icon)

    local title = UI.Text:create()
    title:init(langArr[2], UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    title:floatLeft(0)
    layout:addComponent(title)
    layout:center()
    btn:addChild(layout,101)

    local crystal = UI.Animation:create()
    crystal:init("effect_ui_gaming_greedychoose.json", "effect_ui_gaming_greedychoose.atlas", 1);
    crystal:center()
    bg:addChild(crystal)
    crystal:setAnimation("idle", true)
    
    return com, 1 == eventIdx
end

function GreedySelectView:onInitView()

	local bg = UI.Image:create()
	bg:init("ui_bg_box1.png")
	bg:center()
	self:addChild(bg)
	self.bg = bg
    
	-- 添加中间的背景
	local paper = UI.Image:create()
	paper:init("ui_bg_paper1.png")
	paper:leftBottom(44, 40)
	bg:addChild(paper)

	local titleBg = UI.Image:create()
	titleBg:init("ui_bg_title.png")
	titleBg:leftUp(bg:getContentSize().width/2 - titleBg:getContentSize().width/2 - 8, -21)
	bg:addChild(titleBg, 10)

	local title = UI.Text:create()
	title:init(UI.TEXT_1213264, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
	title:centerLeft(56+117 - title:getContentSize().width/2)
    titleBg:addChild(title, 100)

    -- 装饰物
    local decoretion = UI.Image:create()
    decoretion:init("ui_catfood_gavelock2.png")
    decoretion:rightBottom(30, 30)
    self:addChild(decoretion, 100)

    local crystal = UI.Animation:create()
    crystal:init("effect_ui_town_catfood_right.json", "effect_ui_town_catfood_right.atlas", 1);
    crystal:rightBottom(80, 10)
    self:addChild(crystal, 100)
    crystal:setAnimation("idle", true)
    
    local crystal = UI.Animation:create()
    crystal:init("effect_ui_gaming_greedychoose_zhilupai.json", "effect_ui_gaming_greedychoose_zhilupai.atlas", 1);
    crystal:leftBottom(36, 10)
    self:addChild(crystal, 100)
    crystal:setAnimation("idle", true)


    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()

    local icon = UI.Image:create()
    icon:init("ui_information_reminder.png")
    icon:floatLeft(0)
    layout:addComponent(icon)

    local title = UI.Text:create()
    title:init(UI.TEXT_1213265, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    title:floatLeft(2)
    layout:addComponent(title)
    layout:center()
    addChildAuto(self._layoutUU, self, layout, "reminder", "center",88)

    local btn = UI.Button:create()
    btn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.send(mvc.events.GREEDY_SELECT_DO_SELECT, false)
        mvc.closePanel("GreedySelect", "GreedySelect")
    end)
    btn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    btn:setText(UI.TEXT_1213263)
    btn:centerBottom(60)
    self:addChild(btn)
    

    local item, isBack = self:createOneItem(1)
    addChildAuto(self._layoutUU, self, item, "item3", "center")
    if isBack then
        layout:setVisible(false)
    end
    local item, isBack = self:createOneItem(2)
    addChildAuto(self._layoutUU, self, item, "item1", "center")
    if isBack then
        layout:setVisible(false)
    end

    local item, isBack = self:createOneItem(3)
    addChildAuto(self._layoutUU, self, item, "item2", "center")
    if isBack then
        layout:setVisible(false)
    end
end


function GreedySelectView:bindModel()

end


function GreedySelectView:unbindModel()

end



return GreedySelectView












