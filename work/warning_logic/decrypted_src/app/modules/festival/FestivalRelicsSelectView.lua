------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2020/05/11
--desc	: 
------------------------------------------------------------------------------
require "app.modules.festival.FestivalRelicCell"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FestivalRelicsSelectView = class("FestivalRelicsSelectView", UI.HWBtnComponent)


-- 资源
local COM_RES_LIST = {
    "ui_gaming_choice.plist",
    "ui_festival_relic.plist"
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function FestivalRelicsSelectView:ctor()
    FestivalRelicsSelectView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)  -- 关闭控制面板
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CONTROL_END)
    GameManager:disableMovingHandler()
    self:bindModel()
end

function FestivalRelicsSelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.festival", "Festival", false)
    FestivalRelicsSelectView.super.init(self, ... )
end

function FestivalRelicsSelectView:dtor()
    FestivalRelicsSelectView.super.dtor(self)
    self:unbindModel()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)  -- 关闭控制面板
    GameManager:enableMovingHandler(true)
    reload_script_file_mvc("app.modules.festival.FestivalRelicsSelectView")
end


function FestivalRelicsSelectView:onInitView()
	local bg = UI.Image:create()
	bg:init("ui_bg_box1.png")
	bg:center()
	self:addChild(bg)
	self.bg = bg
    
	-- 添加中间的背景
	-- local paper = UI.Image:create()
	-- paper:init("ui_bg_paper1.png")
	-- paper:leftBottom(44, 40)
	-- bg:addChild(paper)

	local titleBg = UI.Image:create()
	titleBg:init("ui_bg_title.png")
	titleBg:leftUp(bg:getContentSize().width/2 - titleBg:getContentSize().width/2 - 8, -21)
	bg:addChild(titleBg, 10)

	local title = UI.Text:create()
	title:init(UI.TEXT_1213264, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
	title:centerLeft(56+117 - title:getContentSize().width/2)
    titleBg:addChild(title, 100)

    local relicsArr = mvc.festivalModel:getRandomLegacyArr()

    local totalWidth = 672
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(totalWidth,433)
    contentLayout:leftBottom(44, 40)
    bg:addChild(contentLayout, 100)

    local oneWidth = totalWidth/#relicsArr
    local startX = (oneWidth - 195)/2
    for k, goodsData in ipairs(relicsArr) do 
        local relicCell = UI.FestivalRelicCell:create(false, goodsData, function(cell, data)
            -- relicCell.goodsData
            Net.NetPlaySystem:huluSelectLegacy(data:getGoodsID())
            UI.WaitingLayer:showWaiting()
        end)
        relicCell.goodsData = goodsData
        relicCell:centerLeft(startX)
        contentLayout:addChild(relicCell)
        startX = startX + oneWidth
    end

    local flagLeft = UI.Image:create()
    flagLeft:init("ui_festival_relic_choice_decorate1.png")
    flagLeft:leftBottom(-68, 0)
    bg:addChild(flagLeft, 200)

    local flagRight = UI.Image:create()
    flagRight:init("ui_festival_relic_choice_decorate2.png")
    flagRight:rightBottom(-30, 0)
    bg:addChild(flagRight, 200)
end


function FestivalRelicsSelectView:bindModel()

end


function FestivalRelicsSelectView:unbindModel()

end


return FestivalRelicsSelectView












