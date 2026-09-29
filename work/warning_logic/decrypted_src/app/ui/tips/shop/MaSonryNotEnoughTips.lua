--[[
    AUTHOR:ZIHANCHEN
    2017-4-26
    USING: 砖石不够的TIPS
]]

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
UI = UI or {}

local MaSonryNotEnoughTips = class("MaSonryNotEnoughTips",UI.HWBtnComponent)
UI.MaSonryNotEnoughTips = MaSonryNotEnoughTips
--  ui_tips_team
local LEAVE_TEAM_TIPS_PLIST = {
}

--  点击确定按钮 
local function onConfirmButton(self)
    self:close()  
    print("---确认购买")
    -- TODO  
    
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
function MaSonryNotEnoughTips:ctor()

    MaSonryNotEnoughTips.super.ctor(self,UIType.MA_SONRY_NOT_ENOUGH_TIPS,LEAVE_TEAM_TIPS_PLIST,0,0)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
end

--  析构函数 调用父类的方法
function MaSonryNotEnoughTips:dtor()
    MaSonryNotEnoughTips.super.dtor(self)
end

--  初始化函数
function MaSonryNotEnoughTips:init()
    MaSonryNotEnoughTips.super.init(self)
end

--  初始化界面函数
function MaSonryNotEnoughTips:onInitView()
    local tips = UI.Tips:create() 
    tips:init(UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.MASONRY_NOT_ENOUGH)
    tips:center()
    self:addChild(tips)
    self:setTouchEnable(true)

    -- 确定和取消事件监听
    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self,onConfirmButton)
    tips:addEventListener(UIEvent.DIALOG_CANCEL, self,onCancleButton)
    tips:addEventListener(UIEvent.DIALOG_OUT_SIDE, self, onTouchOutTipsUI)
end

-- 传递回调函数名字
function MaSonryNotEnoughTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end


-- 更新视图
function MaSonryNotEnoughTips:onUpdateView()

end