--[[
    AUTHOR:ZIHANCHEN, CMonk
    2018-02-21
    USING: 公会改名确认框
]]

local LanguageManager = require("app.game.LanguageManager")

require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local GuildRenameTips = class("GuildRenameTips", UI.ConfirmDialog)
UI.GuildRenameTips = GuildRenameTips

function GuildRenameTips:ctor(newGuildName, cost)
    GuildRenameTips.super.ctor(self)
    self._newGuildName = newGuildName or "DEADBEEF"
    self._cost = cost or 0
end

--  析构函数 调用父类的方法
function GuildRenameTips:dtor()
    GuildRenameTips.super.dtor(self)
end

--  初始化函数
function GuildRenameTips:init()
    GuildRenameTips.super.init(self)
end

--  初始化界面函数
function GuildRenameTips:onInitView()
    GuildRenameTips.super.onInitView(self)

    -- 隐藏原有文字
    self.ConfirmDialogModel.contentLabel:hide()

    -- 新提示文字布局
    local textContentLayout = UI.Layout:create()
    textContentLayout:init()
    textContentLayout:center()
    textContentLayout:enableAutoHeight()
    textContentLayout:enableAutoWidth()
    self.ConfirmDialogModel.contentBg:addChild(textContentLayout, 10)

    -- 提示内容
    local titleText_1 = UI.Text:create()
    titleText_1:init(string.format(LanguageManager:getInstance():getLocalString(1111717), self._newGuildName), UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"你确定要更改公会名字为"%s""
    titleText_1:setWidth(350)
    titleText_1:setTextHorizontalCenter()
    titleText_1:autoAdapt()
    titleText_1:floatUp(0)
    textContentLayout:addComponent(titleText_1)

    -- 花费价钱排版
    local priceLayout = UI.Layout:create()
    priceLayout:init()
    priceLayout:floatUp(0)
    priceLayout:enableAutoHeight()
    priceLayout:enableAutoWidth()
    textContentLayout:addComponent(priceLayout)

    -- 花费标签
    local costsLabel = UI.Text:create()
    costsLabel:init(UI.TEXT_111013, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"花费"
    costsLabel:floatLeft(0)
    priceLayout:addComponent(costsLabel)

    -- 水晶图标
    local crystal_Icon = UI.Image:create()
    crystal_Icon:init("symbol_gaming_diamond.png")
    crystal_Icon:floatLeft(2)
    priceLayout:addComponent(crystal_Icon)

    -- 价钱
    local costsNumberText = UI.Text:create()
    costsNumberText:init(tostring(self._cost), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"花费"
    costsNumberText:floatLeft(2)
    priceLayout:addComponent(costsNumberText)
end


-- 更新视图
function GuildRenameTips:onUpdateView()

end

-- 传递回调函数名字
function GuildRenameTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end


