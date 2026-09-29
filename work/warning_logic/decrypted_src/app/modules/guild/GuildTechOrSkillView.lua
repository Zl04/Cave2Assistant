------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/09/27
--desc	: 
------------------------------------------------------------------------------

require("app.modules.guild.GuildTechLayer")
require("app.modules.guild.GuildSkillLayer")
require "app.ui.CommonBgLayer"

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
local GuildTechOrSkillView = class("GuildTechOrSkillView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_guild_skill.plist",
    "ui_town_guild_tech_skill.plist"
}

-- 图片名字
local HORCURX_SPRITE = {
    BUTTON_NORMAL = "ui_btn_gray2_0.png",
    BUTTON_ACTIVE = "ui_btn_gray2_1.png",
    BUTTON_DISABLE = "ui_btn_gray2_2.png",
}

local HORCRUX_LAYOUT = {
    TAB_LIST_LEFT = 870,
    TAB_LIST_UP = 120,
    TAB_ITEM_SPACE = 3,
    TAB_ITEM_WIDTH = 114,
    TAB_ITEM_HEIGHT = 64,
}

local COM_WIDTH = 920
local COM_HEIGHT = 640


-- 激活tab
local function onActiveTabHandler(self, tabIndex, lastTabIndex)
    print("self._tabList:getIndex()--",tabIndex)
    -- print(debug.traceback())
    if (tabIndex == 1) then
        print("----点击科技")
        if (RoleBehaviorManager:guildTaskOrSkillCheck()) then 
            if (self.pGuildSkillLayer) then
                self.pGuildSkillLayer:setVisible(false)
                self.pGuildSkillLayer:centerLeft(-10000)
            end

            if (not self.pGuildTechLayer) then
                self.pGuildTechLayer = UI.GuildTechLayer:create(self.spriteID)
                self._rootLayout:addChild(self.pGuildTechLayer)
            end
            self.pGuildTechLayer:setVisible(true)
            self.pGuildTechLayer:centerBottom(0)

            self.pGuildTechLayer:hideTechInfo()
            -- Net.NetGuildSystem:reqGuildTech()
        end 
    -- 成就
    elseif (tabIndex == 2) then
        if MasterDataManager:getGuildTech() == nil then
            return
        end
        print("----点击天赋")
        if (RoleBehaviorManager:guildTaskOrSkillCheck()) then 
            if (self.pGuildTechLayer) then
                self.pGuildTechLayer:setVisible(false)
                self.pGuildTechLayer:centerLeft(-10000)
            end

            if (not self.pGuildSkillLayer) then
                self.pGuildSkillLayer = UI.GuildSkillLayer:create(self.spriteID)
                self._rootLayout:addChild(self.pGuildSkillLayer)
            end
            self.pGuildSkillLayer:setVisible(true)
            self.pGuildSkillLayer:centerBottom(0)

            if MasterDataManager:getGuildSkill() == nil then
                Net.NetGuildSystem:reqGuildSkill()
                self.pGuildSkillLayer:hideSkill()
            else
                self.pGuildSkillLayer:refresh()
            end
            self.bShowSkillLayer = true
        end 
    else
        assert(false)
    end
end

function GuildTechOrSkillView:ctor(spriteID)
    GuildTechOrSkillView.super.ctor(
    	self,
    	UI.Type.GUILD_TECH_OR_SKILL_LAYER,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.rootLayer = nil;           --root节点
    self.spriteID = spriteID
    self.bShowSkillLayer = false

    Net.NetGuildSystem:reqGuildTech()
    Net.NetGuildSystem:reqGuildSkill()
    Net.NetGuildSystem:reqGuildTeamMedal()

    self:bindModel()
    self:setTouchEnable(true);
    -- self:setInterceptTouches(true);
end

function GuildTechOrSkillView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.guild", "Guild", false)
    GuildTechOrSkillView.super.init(self, ... )
end

function GuildTechOrSkillView:dtor()
    GuildTechOrSkillView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.guild.GuildTechOrSkillView")
end


function GuildTechOrSkillView:onInitView()
    local bg = UI.CommonBgLayer:create(false, false)
    bg:center()
    self:addChild(bg)

    local title1 = UI.Image:create()
    title1:init("ui_bg_banner_box_up.png")
    title1:centerUp(6)
    self:addChild(title1, 100)

------程序生成区块开始 node_443842367_1569740122-------
    local node_443842367_1569740122 = UI.Layout:create()
    node_443842367_1569740122:init()
    node_443842367_1569740122:setSize(853, 537)
    node_443842367_1569740122:setLocalZOrder(1)
    node_443842367_1569740122.__uiComposerID = "443842367_1569740122"
    addChildAuto(self._layoutUU, self, node_443842367_1569740122, "layout_443842367_1569740122")
    self._rootLayout = node_443842367_1569740122 -- 暴露名字至self
------程序生成区块结束 node_443842367_1569740122-------
------程序生成区块开始 node_31308436_1569740521-------
    local node_31308436_1569740521 = UI.Image9:create()
    node_31308436_1569740521:init("ui_bg_paper2.png", CCRectMake(304,141,1,1), cc.size(853, 537))
    node_31308436_1569740521.__uiComposerID = "31308436_1569740521"
    addChildAuto(self._layoutUU, node_443842367_1569740122, node_31308436_1569740521, "layout_31308436_1569740521")
------程序生成区块结束 node_31308436_1569740521-------


    local functionTabList = UI.TabList:create()
    functionTabList:init(
        HORCRUX_LAYOUT.TAB_ITEM_SPACE, 
        HORCRUX_LAYOUT.TAB_ITEM_WIDTH,
        HORCRUX_LAYOUT.TAB_ITEM_HEIGHT
    )
    functionTabList:leftUp(
        HORCRUX_LAYOUT.TAB_LIST_LEFT,
        HORCRUX_LAYOUT.TAB_LIST_UP
    )
    functionTabList:setTouchEnable(true)
    functionTabList:setReverseOrder(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, onActiveTabHandler)
    functionTabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    self._tabList = functionTabList
    self:addChild(functionTabList)
    local textList = {UI.TEXT_1170715, UI.TEXT_1170716}
    for i = 1, #textList do
        local textStr = textList[i] or ""
        local tab = UI.FunctionTabItem:create()
        tab:init(HORCURX_SPRITE.BUTTON_NORMAL, HORCURX_SPRITE.BUTTON_ACTIVE, HORCURX_SPRITE.BUTTON_DISABLE, textStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX)
        functionTabList:addToTab(tab, i)
        tab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
    end

    -- 激活标签时的延迟加载会导致排版BUG, 暂时提前初始化最开始的页面来避过这个BUG
    self.pGuildTechLayer = UI.GuildTechLayer:create(self.spriteID)
    self._rootLayout:addChild(self.pGuildTechLayer)

    -- 初始化选择标签, 注意如果要改的上面那个初始页面也要一起改, 否则会有排版BUG
    self._tabList:setDefaultIndex(1)
    

------程序生成区块开始 node_382606940_1569846181-------
    local node_382606940_1569846181 = UI.Layout:create()
    node_382606940_1569846181:init()
    node_382606940_1569846181:setSize(333, 26)
    node_382606940_1569846181:setLocalZOrder(10)
    node_382606940_1569846181.__uiComposerID = "382606940_1569846181"
    addChildAuto(self._layoutUU, node_443842367_1569740122, node_382606940_1569846181, "layout_382606940_1569846181")
    self._currencyLayout = node_382606940_1569846181 -- 暴露名字至self
------程序生成区块结束 node_382606940_1569846181-------
------程序生成区块开始 node_127918465_1569846235-------
    local node_127918465_1569846235 = UI.Image:create()
    node_127918465_1569846235:init('symbol_guild_tech_icon_medal.png')
    node_127918465_1569846235.__uiComposerID = "127918465_1569846235"
    addChildAuto(self._layoutUU, node_382606940_1569846181, node_127918465_1569846235, "layout_127918465_1569846235")
    self._guildTechMedalIcon = node_127918465_1569846235
------程序生成区块结束 node_127918465_1569846235-------
------程序生成区块开始 node_1582853916_1569846398-------
    local node_1582853916_1569846398 = UI.Text:create()
    node_1582853916_1569846398:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
    node_1582853916_1569846398:autoAdapt()
    node_1582853916_1569846398.__uiComposerID = "1582853916_1569846398"
    addChildAuto(self._layoutUU, node_382606940_1569846181, node_1582853916_1569846398, "layout_1582853916_1569846398")
    self._guildTechMedalText = node_1582853916_1569846398
------程序生成区块结束 node_1582853916_1569846398-------
------程序生成区块开始 node_477985453_1569846457-------
    local node_477985453_1569846457 = UI.Image:create()
    node_477985453_1569846457:init('symbol_guild_contribution_icon_medal.png')
    node_477985453_1569846457:setLocalZOrder(10)
    node_477985453_1569846457.__uiComposerID = "477985453_1569846457"
    addChildAuto(self._layoutUU, node_382606940_1569846181, node_477985453_1569846457, "layout_477985453_1569846457")
------程序生成区块结束 node_477985453_1569846457-------
------程序生成区块开始 node_91054580_1569846612-------
    local node_91054580_1569846612 = UI.Text:create()
    node_91054580_1569846612:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
    node_91054580_1569846612:autoAdapt()
    node_91054580_1569846612.__uiComposerID = "91054580_1569846612"
    addChildAuto(self._layoutUU, node_382606940_1569846181, node_91054580_1569846612, "layout_91054580_1569846612")
    self._guildContribText = node_91054580_1569846612
------程序生成区块结束 node_91054580_1569846612-------

    self:refreshGuildMedalOrContrib()
end

function GuildTechOrSkillView:refreshGuildMedalOrContrib()
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member and self._guildTechMedalText then
        self._guildTechMedalText:hide()
        self._guildTechMedalIcon:hide()
    end

    local masterData = GameDataManager:getInstance():getMaster()
    if(masterData) then 
        if(self._guildTechMedalText) then 
            local guildData = MasterDataManager:getGuildData()
            self._guildTechMedalText:setText(tostring(guildData.guildTeamMedal))
        end 

        if(self._guildContribText) then 
            self._guildContribText:setText(tostring(masterData:getGuildContrib()))
        end
    end
end

function GuildTechOrSkillView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_QUIT_GUILD, self, self.close)
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self, self.refreshGuildMedalOrContrib)
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_CHNAGE_GUILD_CONTRIB, self, self.refreshGuildMedalOrContrib)
end

function GuildTechOrSkillView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_QUIT_GUILD, self, self.close)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self, self.refreshGuildMedalOrContrib)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_CHNAGE_GUILD_CONTRIB, self, self.refreshGuildMedalOrContrib)
end

-- 模版函数：更新组建的视图
function GuildTechOrSkillView:onUpdateView()
end

function GuildTechOrSkillView:openShow()
    self:open()
end

function GuildTechOrSkillView:guildTechResult()
    if(self.pGuildTechLayer) then 
        self.pGuildTechLayer:guildTechResult()
    end
    if(self.pGuildSkillLayer) then 
        self.pGuildSkillLayer:refreshLeftChoiceBtn()
    end
end

return GuildTechOrSkillView












