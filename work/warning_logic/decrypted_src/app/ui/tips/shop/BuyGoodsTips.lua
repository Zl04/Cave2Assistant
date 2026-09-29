--[[
    AUTHOR:ZIHANCHEN
    2017-4-26
    USING: 购买物品的TIPS
]]

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
UI = UI or {}

local BuyGoodsTips = class("BuyGoodsTips",UI.HWBtnComponent)
UI.BuyGoodsTips = BuyGoodsTips
--  ui_tips_team
local LEAVE_TEAM_TIPS_PLIST = {
}

--  点击确定按钮 
local function onConfirmButton(self)
    self:close()  
    print("---确认购买") 
    -- TODO  
    if(self._okCallFun ~= nil ) then 
        self._okCallFun() 
    end
    
end

--  点击取消按钮
local function onCancleButton(self)
    self:close()   
    print("---取消购买") 
   
end

-- 点击TIPS外区域关闭
local function onTouchOutTipsUI(self)
    -- self:close()
end

--  构造函数
function BuyGoodsTips:ctor()

    BuyGoodsTips.super.ctor(self,UIType.BUY_GOODS_TIPS,LEAVE_TEAM_TIPS_PLIST,0,0)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
    self._diamondAmount = 0
    self._itemName = nil
    self._costType = nil -- 花费类型
end

--  析构函数 调用父类的方法
function BuyGoodsTips:dtor()
    self._diamondAmount = 0
    self._itemName = nil
    self._costType = nil -- 花费类型
    BuyGoodsTips.super.dtor(self)
end

--  初始化函数
function BuyGoodsTips:init(diamondAmount,itemName,costType)
    self._diamondAmount = diamondAmount
    self._itemName = itemName
    self._costType = costType
    BuyGoodsTips.super.init(self)
end

--  初始化界面函数
function BuyGoodsTips:onInitView()
    local tips = UI.Tips:create() 
    tips:init(UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.BUG_GOODS,UI.TEXT_111013..UI.TEXT_111014)
    tips:center()
    tips:getDiamondAmount(self._diamondAmount)
    tips:getCostType(self._costType)
    tips:getItemName(self._itemName)
    self:addChild(tips,UI_ZORDER.TIPS)
    self:setTouchEnable(true)

    -- 确定和取消事件监听
    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self,onConfirmButton)
    tips:addEventListener(UIEvent.DIALOG_CANCEL, self,onCancleButton)
    tips:addEventListener(UIEvent.DIALOG_OUT_SIDE, self, onTouchOutTipsUI)
end

-- 传递回调函数名字
function BuyGoodsTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end


-- 更新视图
function BuyGoodsTips:onUpdateView()

end