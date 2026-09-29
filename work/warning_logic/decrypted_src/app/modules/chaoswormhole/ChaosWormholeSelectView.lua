------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/08/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ChaosWormholeSelectView = class("ChaosWormholeSelectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 353
local COM_HEIGHT = 310
local winSize = cc.Director:getInstance():getWinSize()

function ChaosWormholeSelectView:ctor(params)
    ChaosWormholeSelectView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    local params = params or {}
    print(" params ===   ",params.extraPara,params.maxSelectIndex)

    self.extraPara = params.extraPara or 1
    self.maxSelectIndex = params.maxSelectIndex or 1
    self:bindModel()
end

function ChaosWormholeSelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.chaoswormhole", "ChaosWormhole", false)
    ChaosWormholeSelectView.super.init(self, ... )
end

function ChaosWormholeSelectView:dtor()
    ChaosWormholeSelectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.chaoswormhole.ChaosWormholeSelectView")
end


function ChaosWormholeSelectView:onInitView()

    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_chaoswormhole_popups.png")
    bg:center()
    contentLayout:addChild(bg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226503, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 212, g = 202, b = 198})
    titleText:centerUp(33)
    bg:addChild(titleText)


    local tabLayout = UI.Layout:create();
    tabLayout:init()
    tabLayout:setSize(210, 200)
    tabLayout:centerUp(70) 
    bg:addChild(tabLayout)

    print("self.maxSelectIndex ==== ",self.maxSelectIndex)
    for i = 1, self.maxSelectIndex do
        local tab = UI.Button:create()
        tab:init("ui_btn_screening_0.png", "ui_btn_screening_1.png", "ui_btn_screening_0.png")
        tab:floatUp(18)
        tab:closeClickScale()
        tab:setText(string.format(UI.TEXT_226502, i))
        tab:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        tab:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_CHAOS_WORMHO, i)
            self:close()
        end)
        -- 加入列表
        tabLayout:addComponent(tab)

        if i == self.extraPara then
            tab:press(false)
        end
    end

end


function ChaosWormholeSelectView:bindModel()

end


function ChaosWormholeSelectView:unbindModel()

end





return ChaosWormholeSelectView












