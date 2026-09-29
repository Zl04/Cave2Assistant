--[[
    AUTHOR:ZIHANCHEN
    2017-4-26
    USING: 出售装备的TIPS
]]

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
UI = UI or {}

local SalesEquipmentTips = class("SalesEquipmentTips", UI.ConfirmDialog)
UI.SalesEquipmentTips = SalesEquipmentTips
--  ui_tips_team
local LEAVE_TEAM_TIPS_PLIST = {
}

--  点击确定按钮 
local function onConfirmButton(self)
    --  
    if(self._okCallFun ~= nil ) then 
        self._okCallFun() 
    end
end

--  点击取消按钮
local function onCancleButton(self)
   
end

-- 点击TIPS外区域关闭
local function onTouchOutTipsUI(self)
    self:close()
end

--  构造函数
function SalesEquipmentTips:ctor()
    SalesEquipmentTips.super.ctor(self)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
    self._amount = 0
end

--  析构函数 调用父类的方法
function SalesEquipmentTips:dtor()
    self._amount = nil
    SalesEquipmentTips.super.dtor(self)
end

--  初始化函数
function SalesEquipmentTips:init(amount)
    self._amount = amount
    SalesEquipmentTips.super.init(self)
end

--  初始化界面函数
function SalesEquipmentTips:onInitView()
    SalesEquipmentTips.super.onInitView(self)

    local titleText_1 = UI.Text:create() 
    titleText_1:init(UI.TEXT_111012,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText_1:centerUp(17)
    titleText_1:setWidth(360)
    titleText_1:setTextCenter()
    self.ConfirmDialogModel.contentBg:addChild(titleText_1, 10)

    local titleText_2 = UI.Text:create() 
    titleText_2:init(UI.TEXT_111017,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText_2:centerUp(titleText_1:getUp() + titleText_1:getContentSize().height)
    self.ConfirmDialogModel.contentBg:addChild(titleText_2, 10)

    -- 黄金图标
    local glod_Icon = UI.Image:create()
    glod_Icon:init("symbol_gaming_money.png")
    glod_Icon:centerLeft(titleText_2:getContentSize().width +4)
    titleText_2:addChild(glod_Icon, 10)

    -- 黄金数量
    local glod_Amount = UI.Text:create() 
    glod_Amount:init(""..self._amount,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    glod_Amount:centerLeft(glod_Icon:getContentSize().width + 4)
    glod_Icon:addChild(glod_Amount, 10)

    titleText_2:leftUp(370 / 2 - (titleText_2:getContentSize().width + glod_Icon:getContentSize().width + glod_Amount:getContentSize().width + 8)/2, titleText_1:getUp() + titleText_1:getContentSize().height)


    -- local tips = UI.Tips:create() 
    -- tips:init(UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.SALES_EQUIPMENT,UI.TEXT_111012,UI.TipsButtonType.NO_TEXT_BUTTON)
    -- tips:center()
    -- tips:getGoldAmount(self._amount)
    -- self:addChild(tips)
    -- self:setTouchEnable(true)

    -- 确定和取消事件监听
    self:addEventListener(UIEvent.DIALOG_CONFIRM, self,onConfirmButton)
    self:addEventListener(UIEvent.DIALOG_CANCEL, self,onCancleButton)
end

-- 传递回调函数名字
function SalesEquipmentTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end

-- 更新视图
function SalesEquipmentTips:onUpdateView()

end