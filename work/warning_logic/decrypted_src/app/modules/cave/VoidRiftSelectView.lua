------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/26
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local VoidRiftSelectView = class("VoidRiftSelectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_gaming_choice.plist",
    "ui_town_inferno.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function VoidRiftSelectView:ctor()
    VoidRiftSelectView.super.ctor(
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

function VoidRiftSelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    VoidRiftSelectView.super.init(self, ... )
end

function VoidRiftSelectView:dtor()
    VoidRiftSelectView.super.dtor(self)
    self:unbindModel()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)  -- 关闭控制面板
    GameManager:enableMovingHandler(true)
    reload_script_file_mvc("app.modules.cave.VoidRiftSelectView")
end


function VoidRiftSelectView:onInitView()
    local mask = AvalonUtil.createDialogMask()
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

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
	title:init(UI.TEXT_222102, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
	title:centerLeft(56+117 - title:getContentSize().width/2)
    titleBg:addChild(title, 100)

    local relicsArr = mvc.caveModel:getVoidRiftDiamondRandom()

    local totalWidth = 672
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(totalWidth,433)
    contentLayout:leftBottom(44+13, 60)
    bg:addChild(contentLayout, 5)

    local centerBg = cc.LayerColor:create(cc.c4b(0,0,0,255))
    centerBg:setContentSize(427, 248)
    centerBg:setPosition(contentLayout:getContentSize().width / 2 - centerBg:getContentSize().width / 2, contentLayout:getContentSize().height / 2 - centerBg:getContentSize().height / 2)
    contentLayout:addChild(centerBg)

    local oneWidth = totalWidth/#relicsArr
    local startX = (oneWidth - 195)/2
    for k, goodsData in ipairs(relicsArr) do 
        goodsData.key = k
        local relicCell = UI.InfernoSelectCell:create(false, goodsData, function(cell, data)
            -- print("reqSelectInfernoRune=", data.key)
            Net.NetRoleSystem:reqSelectVoidRiftRune(data.key)
            UI.WaitingLayer:showWaiting()
        end)
        relicCell.goodsData = goodsData
        relicCell:centerLeft(startX)
        contentLayout:addChild(relicCell)
        startX = startX + oneWidth
    end

    -- local flagLeft = UI.Image:create()
    -- flagLeft:init("ui_festival_relic_choice_decorate1.png")
    -- flagLeft:leftBottom(-68, 0)
    -- bg:addChild(flagLeft, 200)

    -- local flagRight = UI.Image:create()
    -- flagRight:init("ui_festival_relic_choice_decorate2.png")
    -- flagRight:rightBottom(-30, 0)
    -- bg:addChild(flagRight, 200)

    local giveUpButton = UI.Button:create()
    giveUpButton:init("ui_inferno_btn_giveup.png", "ui_inferno_btn_giveup.png", "ui_inferno_btn_giveup.png")
    giveUpButton:centerBottom(10)
    giveUpButton:setText(UI.TEXT_110036)
    giveUpButton:setTextOffset(0, -4)
    giveUpButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    giveUpButton:setInterval(1)
    giveUpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- 取消选择
        Net.NetRoleSystem:reqSelectVoidRiftRune(0)
        UI.WaitingLayer:showWaiting()
    end)
    bg:addChild(giveUpButton, 101)
end


function VoidRiftSelectView:bindModel()

end


function VoidRiftSelectView:unbindModel()

end





return VoidRiftSelectView












