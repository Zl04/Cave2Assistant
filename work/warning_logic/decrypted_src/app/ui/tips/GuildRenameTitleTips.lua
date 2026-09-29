--[[
    AUTHOR:ZIHANCHEN, CMonk
    2018-02-21
    USING: 公会职级自定义确认框
]]

local LanguageManager = require("app.game.LanguageManager")

require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local GuildRenameTitleTips = class("GuildRenameTitleTips", UI.ConfirmDialog)
UI.GuildRenameTitleTips = GuildRenameTitleTips

function GuildRenameTitleTips:ctor(cost)
    GuildRenameTitleTips.super.ctor(self)
    self._cost = cost or 0
end

--  析构函数 调用父类的方法
function GuildRenameTitleTips:dtor()
    GuildRenameTitleTips.super.dtor(self)
end

--  初始化函数
function GuildRenameTitleTips:init()
    GuildRenameTitleTips.super.init(self)
end

--  初始化界面函数
function GuildRenameTitleTips:onInitView()
    GuildRenameTitleTips.super.onInitView(self)

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
    titleText_1:init(UI.TEXT_1213866, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
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
function GuildRenameTitleTips:onUpdateView()

end

-- 传递回调函数名字
function GuildRenameTitleTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end


