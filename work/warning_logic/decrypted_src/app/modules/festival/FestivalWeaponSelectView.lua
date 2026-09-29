------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/05/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FestivalWeaponSelectView = class("FestivalWeaponSelectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_catfood.plist",
    "ui_gaming_choice.plist",
    "ui_town_festival_hulu_weaponchoice.plist"
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function FestivalWeaponSelectView:ctor()
    FestivalWeaponSelectView.super.ctor(
    	self,
    	UI.Type.FESTIVAL_HULU_WEAPON_CHOICE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function FestivalWeaponSelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.festival", "Festival", false)
    FestivalWeaponSelectView.super.init(self, ... )
end

function FestivalWeaponSelectView:dtor()
    FestivalWeaponSelectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.festival.FestivalWeaponSelectView")
end


--     GreedyEvent_Down = 1;       // 下楼
--     GreedyEvent_Return = 2;     // 回城
--     GreedyEvent_Special = 3;    // 特殊回城
local langMap = {
    [1] = {UI.TEXT_1324001, UI.TEXT_1213260, "ui_hulu_armschoice_shield.png"},
    [2] = {UI.TEXT_1324000, UI.TEXT_1213260, "ui_hulu_armschoice_sword.png"},
    [3] = {UI.TEXT_1324002, UI.TEXT_1213260, "ui_hulu_armschoice_wand.png"},
}
function FestivalWeaponSelectView:createOneItem(weaponType)
    local com = UI.Component:create()
    com:init()
    com:setSize(180,220)

	local bg = UI.Image:create()
	bg:init("ui_choice_paper.png")
	bg:center()
    com:addChild(bg)
    
    local langArr = langMap[weaponType]
    local title = UI.Text:create()
    title:init(langArr[1], UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    bg:addChild(title, 5)

    local splitLine2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine2:setContentSize(135, 1.1)
    splitLine2:setCapInsets(CCRectMake(1,0,1,1))
    splitLine2:setPosition(85, 185)
    bg:addChild(splitLine2, 10)
    title:centerUp(6)

	local goodsImg = UI.Image:create()
    goodsImg:init(langArr[3])
    goodsImg:setScale(0.8)
	goodsImg:center()
    bg:addChild(goodsImg,10)


    local btn = UI.Button:create()
    btn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.send(mvc.events.Festival_WeaponSelect, weaponType)
        mvc.closePanel("Festival", "FestivalWeaponSelect")
    end)
    btn:centerBottom(-60)
    com:addChild(btn)
    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    local icon = UI.Image:create()
    icon:init("ui_choice_icon_2_2.png")
    icon:floatLeft(0)
    layout:addComponent(icon)

    local title = UI.Text:create()
    title:init(langArr[2], UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    title:floatLeft(0)
    layout:addComponent(title)
    layout:center()
    btn:addChild(layout,101)

    -- local crystal = UI.Animation:create()
    -- crystal:init("effect_ui_gaming_greedychoose.json", "effect_ui_gaming_greedychoose.atlas", 1);
    -- crystal:center()
    -- bg:addChild(crystal)
    -- crystal:setAnimation("idle", true)
    
    return com, 1 == eventIdx
end

function FestivalWeaponSelectView:onInitView()
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
	title:init(UI.TEXT_1324003, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
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

    local btn = UI.Button:create()
    btn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- mvc.send(mvc.events.GREEDY_SELECT_DO_SELECT, false)
        mvc.closePanel("Festival", "FestivalWeaponSelect")
    end)
    btn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    btn:setText(UI.TEXT_1213263)
    btn:centerBottom(60)
    self:addChild(btn)

    print("====", PublicDefine.WEAPON_TYPE.SWORD_SHIELD, PublicDefine.WEAPON_TYPE.GREAT_SWORD, PublicDefine.WEAPON_TYPE.MAGIC_STAFF)
    local item, isBack = self:createOneItem(PublicDefine.WEAPON_TYPE.SWORD_SHIELD)
    addChildAuto(self._layoutUU, self, item, "item1", "center")
    local item, isBack = self:createOneItem(PublicDefine.WEAPON_TYPE.GREAT_SWORD)
    addChildAuto(self._layoutUU, self, item, "item2", "center")
    local item, isBack = self:createOneItem(PublicDefine.WEAPON_TYPE.MAGIC_STAFF)
    addChildAuto(self._layoutUU, self, item, "item3", "center")

end


function FestivalWeaponSelectView:bindModel()

end

function FestivalWeaponSelectView:unbindModel()

end


return FestivalWeaponSelectView












