--[[
    AUTHOR:ZIHANCHEN
    2017-4-26
    USING: 黄金不够的TIPS
]]

require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local GoldNotEnoughTips = class("GoldNotEnoughTips",UI.ConfirmDialog)
UI.GoldNotEnoughTips = GoldNotEnoughTips
--  ui_tips_team

--  构造函数
function GoldNotEnoughTips:ctor()
    GoldNotEnoughTips.super.ctor(self)
end

--  析构函数 调用父类的方法
function GoldNotEnoughTips:dtor()
    GoldNotEnoughTips.super.dtor(self)
end

--  初始化函数
function GoldNotEnoughTips:init()
    GoldNotEnoughTips.super.init(self)
end

--  初始化界面函数
function GoldNotEnoughTips:onInitView()
    GoldNotEnoughTips.super.onInitView(self)

    local titleText_1 = UI.Text:create()
    titleText_1:init(UI.TEXT_111015,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText_1:centerUp(17)
    self.ConfirmDialogModel.contentBg:addChild(titleText_1, 10)
         
    local crystal_Icon = UI.Image:create()
    crystal_Icon:init("symbol_gaming_money.png")
    crystal_Icon:leftUp(self.ConfirmDialogModel.contentBg:getContentSize().width / 2 - titleText_1:getContentSize().width / 2 - crystal_Icon:getContentSize().width, 20)
    self.ConfirmDialogModel.contentBg:addChild(crystal_Icon, 10)
end

-- 传递回调函数名字
function GoldNotEnoughTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end


-- 更新视图
function GoldNotEnoughTips:onUpdateView()

end