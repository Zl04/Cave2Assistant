--[[
    AUTHOR:
    2019-6-18
    USING: 钻石购买提示
]]

require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local DiamondBuyTips = class("DiamondBuyTips", UI.ConfirmDialog)
UI.DiamondBuyTips = DiamondBuyTips

function DiamondBuyTips:ctor(buyText, diamond)
    DiamondBuyTips.super.ctor(self)
    self._buyText = buyText
    self._diamond = diamond
end

--  析构函数 调用父类的方法
function DiamondBuyTips:dtor()
    DiamondBuyTips.super.dtor(self)
end

--  初始化函数
function DiamondBuyTips:init()
    DiamondBuyTips.super.init(self)
end

--  初始化界面函数
function DiamondBuyTips:onInitView()
    DiamondBuyTips.super.onInitView(self)
      -- 不足 TEXT_111015 
    self.ConfirmDialogModel.contentLabel:setText("");
    self.ConfirmDialogModel.contentLabel:centerUp(45)

    local titleText_1 = UI.Text:create()
    titleText_1:init(self._buyText,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText_1:centerUp(17)
    titleText_1:setWidth(350)
    titleText_1:setTextCenter()
    self.ConfirmDialogModel.contentBg:addChild(titleText_1, 10)

    local up = titleText_1:getContentSize().height + 27
         
    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_gaming_diamond.png")
    self.ConfirmDialogModel.contentBg:addChild(diamondImage, 10)

    local diamondText = UI.Text:create()
    diamondText:init(self._diamond,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    diamondText:centerRight(-diamondText:getContentSize().width - 4)
    diamondImage:addChild(diamondText, 10)

    local startX = self.ConfirmDialogModel.contentBg:getContentSize().width / 2 - diamondImage:getContentSize().width / 2 - diamondText:getContentSize().width/2
    diamondImage:leftUp(startX, up)
end


-- 更新视图
function DiamondBuyTips:onUpdateView()

end

-- 传递回调函数名字
function DiamondBuyTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end

function DiamondBuyTips:ok()
    DiamondBuyTips.super.ok(self)
end


