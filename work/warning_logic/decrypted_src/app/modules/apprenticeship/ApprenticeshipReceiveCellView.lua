------------------------------------------------------------------------------
--author: 
--date	: 2019/08/07
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipReceiveCellView = class("ApprenticeshipReceiveCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipReceiveCellView:ctor()
    ApprenticeshipReceiveCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipReceiveCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipReceiveCellView.super.init(self, ... )
end

function ApprenticeshipReceiveCellView:dtor()
    ApprenticeshipReceiveCellView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipReceiveCellView")
end


function ApprenticeshipReceiveCellView:onInitView()
------程序生成区块开始 node_1560305519_1565204406-------
    local node_1560305519_1565204406 = UI.Image9:create()
    node_1560305519_1565204406:init("ui_scale9image_bg_bar.png", CCRectMake(0,0,4,4), cc.size(627, 88))
    node_1560305519_1565204406.__uiComposerID = "1560305519_1565204406"
    addChildAuto(self._layoutUU, self, node_1560305519_1565204406, "layout_1560305519_1565204406")
------程序生成区块结束 node_1560305519_1565204406-------
------程序生成区块开始 node_1307934770_1565204922-------
    local node_1307934770_1565204922 = UI.Image:create()
    node_1307934770_1565204922:init('ui_information_headframe_bottom.png')
    node_1307934770_1565204922.__uiComposerID = "1307934770_1565204922"
    addChildAuto(self._layoutUU, node_1560305519_1565204406, node_1307934770_1565204922, "layout_1307934770_1565204922")
------程序生成区块结束 node_1307934770_1565204922-------
------程序生成区块开始 node_1373462571_1565205015-------
    local node_1373462571_1565205015 = UI.Text:create()
    node_1373462571_1565205015:init(LanguageManager:getInstance():getLocalString(1112650) --[["玩家名字"]], UI.SYS_FONT, 18, {r = 41, g = 41, b = 45})
    node_1373462571_1565205015.__uiComposerID = "1373462571_1565205015"
    addChildAuto(self._layoutUU, node_1560305519_1565204406, node_1373462571_1565205015, "layout_1373462571_1565205015")
    self._applierName = node_1373462571_1565205015 -- 暴露名字至self
------程序生成区块结束 node_1373462571_1565205015-------
------程序生成区块开始 node_783811946_1565205129-------
    local node_783811946_1565205129 = UI.Text:create()
    node_783811946_1565205129:init("lv.2", UI.FONT_STANDARD, 18, {r = 41, g = 41, b = 45})
    node_783811946_1565205129.__uiComposerID = "783811946_1565205129"
    addChildAuto(self._layoutUU, node_1560305519_1565204406, node_783811946_1565205129, "layout_783811946_1565205129")
    self._applierLv = node_783811946_1565205129 -- 暴露名字至self
------程序生成区块结束 node_783811946_1565205129-------
------程序生成区块开始 node_628545255_1565205255-------
    local node_628545255_1565205255 = UI.Button:create()
    node_628545255_1565205255:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    node_628545255_1565205255:setText(LanguageManager:getInstance():getLocalString(1112651) --[["同意"]])
    node_628545255_1565205255:setTextFont(UI.FONT_STANDARD, 20, {r = 50, g = 50, b = 44})
    node_628545255_1565205255.__uiComposerID = "628545255_1565205255"
    addChildAuto(self._layoutUU, node_1560305519_1565204406, node_628545255_1565205255, "layout_628545255_1565205255")
    self._btnAgree = node_628545255_1565205255 -- 暴露名字至self
    self._btnAgree:setInterval(1)
    self._btnAgree:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (self._cb) then self._cb() end
    end)
------程序生成区块结束 node_628545255_1565205255-------
------程序生成区块开始 node_652740646_1565257335-------
    local node_652740646_1565257335 = UI.Component:create()
    node_652740646_1565257335:init()
    node_652740646_1565257335.__uiComposerID = "652740646_1565257335"
    addChildAuto(self._layoutUU, node_1307934770_1565204922, node_652740646_1565257335, "layout_652740646_1565257335")
    self._headAnchor = node_652740646_1565257335
------程序生成区块结束 node_652740646_1565257335-------
------程序生成区块开始 node_1920202213_1565257356-------
    local node_1920202213_1565257356 = UI.Image:create()
    node_1920202213_1565257356:init('ui_information_headframe_box.png')
    node_1920202213_1565257356:setLocalZOrder(10)
    node_1920202213_1565257356.__uiComposerID = "1920202213_1565257356"
    addChildAuto(self._layoutUU, node_1307934770_1565204922, node_1920202213_1565257356, "layout_1920202213_1565257356")
------程序生成区块结束 node_1920202213_1565257356-------
end


function ApprenticeshipReceiveCellView:updateData(data)
    if (data) then
        self._data = data
        -- 更新名字
        if (self._data.nickName) then
            self._applierName:show()
            self._applierName:setText(self._data.nickName)
        else
            self._applierName:hide()
        end

        -- 更新等级
        if (self._data.roleLV) then
            self._applierLv:show()
            self._applierLv:setText("Lv." .. self._data.roleLV)
        else
            self._applierLv:hide()
        end

        -- 更新脸
        if (self._data.sex and self._data.faceDecodeID) then
            self._headAnchor:removeAllChildren()

            -- 用一个包裹节点来确保快速刷新时不会错位
            local headWrapper = UI.Component:create()
            headWrapper:init()
            self._headAnchor:addChild(headWrapper)

            Avalon.WidgetUtil:getHeadByData(self, self._data.sex, self._data.faceDecodeID, {}, self, handler(self, function(self, pic)
                if (not tolua.isnull(headWrapper)) then
                    pic:setScaleX(-1)
                    headWrapper:addChild(pic)
                end
            end))
        end
    end
end

function ApprenticeshipReceiveCellView:setCallback(cb)
    self._cb = cb
end

function ApprenticeshipReceiveCellView:bindModel()

end


function ApprenticeshipReceiveCellView:unbindModel()

end





return ApprenticeshipReceiveCellView












