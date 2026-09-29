--[[
    AUTHOR:CMnok
    2019-03-02
    USING: 确认罢免
]]

require("app.ui.common.Dialog.ConfirmDialog")

UI = UI or {}

local OverthrowVoteTips = class("OverthrowVoteTips", UI.ConfirmDialog)
UI.OverthrowVoteTips = OverthrowVoteTips

function OverthrowVoteTips:ctor()
    OverthrowVoteTips.super.ctor(self)
end

--  析构函数 调用父类的方法
function OverthrowVoteTips:dtor()
    OverthrowVoteTips.super.dtor(self)
end

--  初始化函数
function OverthrowVoteTips:init()
    OverthrowVoteTips.super.init(self)
    self:setModelDialog(false)
end

--  初始化界面函数
function OverthrowVoteTips:onInitView()
    OverthrowVoteTips.super.onInitView(self)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:enableAutoHeight()
    contentLayout:enableAutoWidth()
    contentLayout:center()
    self.ConfirmDialogModel.contentBg:addChild(contentLayout, 10)

    local LanguageManager = require("app.game.LanguageManager")
    local rawText = LanguageManager:getInstance():getLocalString(1111694)
    local strs = rawText:split("\n")

    local str1 = strs[1]
    if (str1) then
        local text1 = UI.Text:create()
        text1:init(str1, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        text1:setTextCenter()
        text1:setWidth(370)
        text1:floatUp(0)
        text1:autoAdapt()
        contentLayout:addComponent(text1)
    end

    local str2 = strs[2]
    if (str2) then
        local text2 = UI.Text:create()
        text2:init(str2, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71)
        text2:setTextCenter()
        text2:setWidth(370)
        text2:floatUp(0)
        text2:autoAdapt()
        contentLayout:addComponent(text2)
    end
end


-- 更新视图
function OverthrowVoteTips:onUpdateView()

end

-- 传递回调函数名字
function OverthrowVoteTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end


