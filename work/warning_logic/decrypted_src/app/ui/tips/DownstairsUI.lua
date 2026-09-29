--[[
    UI - 下楼
]]

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"

UI = UI or {}

local DownstairsUI = class("DownstairsUI", UI.ConfirmDialog)
UI.DownstairsUI = DownstairsUI

-- private:
local DEBUG = false
local DEBUG_DRAW = false
local DOWN_STSIRS_RES_LIST = {
}

-- 构造函数
function DownstairsUI:ctor()
	DownstairsUI.super.ctor(self)
end

-- 析构函数
function DownstairsUI:dtor()
    DownstairsUI.super.dtor(self)
end

-- public:
-- 初始化
function DownstairsUI:init(text, okCallback, cancelCallback, forwardNode, type)
    DownstairsUI.super.init(self, text, okCallback, cancelCallback, forwardNode, type)
end

-- 初始化视图
function DownstairsUI:onInitView()
	DownstairsUI.super.onInitView(self)
    -- contentLabel:enableDebugDraw()
    local SceneManager = require("app.game.SceneManager")
    if SceneManager:getInstance():isCanShowDeadBackTip() then
        local contentLabel = self.ConfirmDialogModel.contentLabel
        local LanguageManager = require("app.game.LanguageManager")
        contentLabel:centerUp(13)
        self.mTxtPro = UI.Text:create()
        self.mTxtPro:init(LanguageManager:getInstance():getLocalString(1111476), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
        self.mTxtPro:setDimensions(320, 85)
        self.ConfirmDialogModel.contentBg:addChild(self.mTxtPro, 10000)
        self.mTxtPro:centerUp(39)
        self.mTxtPro:setTextCenter()
    end
end

-- 更新视图
function DownstairsUI:onUpdateView()

end