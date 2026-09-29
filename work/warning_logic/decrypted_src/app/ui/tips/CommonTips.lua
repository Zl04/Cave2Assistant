-- --[[
--     通用的提示性TIPS
-- ]]

-- require "app.ui.Component"
-- require "app.ui.common.Dialog.Tips"

-- UI = UI or {}

-- local CommonTips = class("CommonTips", UI.HWBtnComponent)
-- UI.CommonTips = CommonTips

-- -- private:
-- local DEBUG = false
-- local DEBUG_DRAW = false
-- local DOWN_STSIRS_RES_LIST = {
-- }

-- -- 点击确定按钮监听
-- local function onConfirmButtonHandler(self)
--     if(self._okCallFun) then
--         self._okCallFun()
--     end
--     Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)         --打开遥杆 
--     self:close()
-- end

-- -- 点击取消按钮监听
-- local function onCancelButtonHandler(self)
--     if (self._cancelCallFun) then
--         self._cancelCallFun()
--     end
--     Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)         --打开遥杆 
--     self:close()
-- end

-- -- 点击外部关闭
-- local function onTouchDialogOutsizeHandler(self)
--     Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)          --打开遥杆 
-- end

-- -- 构造函数
-- function CommonTips:ctor(justShowOK)
--     CommonTips.super.ctor(self, UIType.COMMON_TIPS, DOWN_STSIRS_RES_LIST, 0, 0)
--     self._cancelCallFun = nil 
--     self._okCallFun = nil 
--     self._touchDialogOutsizeClose = false
--     self._text = nil
--     self._justShowOK = (justShowOK == nil and {false} or {true})[1]
-- end

-- -- 析构函数
-- function CommonTips:dtor()
--     CommonTips.super.dtor(self)
-- end

-- -- public:
-- -- 初始化
-- function CommonTips:init(text)
--     self._text = text
--     CommonTips.super.init(self)
-- end

-- -- 设置显示语句
-- function CommonTips:setText(text)
--     self._text = text
-- end

-- function CommonTips:setTouchDialogOutSizeClose(outSizeClose)
--     self._touchDialogOutsizeClose = outSizeClose
-- end

-- -- 初始化视图
-- function CommonTips:onInitView()
--     local text = nil
--     if(self._text) then
--         text = self._text
--     else 
--         text = ""
--     end

--     local tips = nil 
--     if(self._justShowOK) then 
--         tips = UI.ConfirmDialog.showConfrimOnly(text, nil, nil, nil, nil)--  UI.Tips:create()
--     else 
--         tips = UI.ConfirmDialog.show(text, nil, nil, nil, nil, nil)
--     end
--     tips:center()
--     self:addChild(tips, UI_ZORDER.TIPS)
    
--     self:setTouchEnable(true)
--     tips.touchDialogOutsizeClose = self._touchDialogOutsizeClose
--     -- self:setInterceptTouches(true)
--     -- 确定和取消事件监听
--     tips:addEventListener(UIEvent.DIALOG_CONFIRM, self,onConfirmButtonHandler)
--     tips:addEventListener(UIEvent.DIALOG_CANCEL, self,onCancelButtonHandler)
--     tips:addEventListener(UIEvent.DIALOG_OUT_SIDE, self, onTouchDialogOutsizeHandler)
-- end

-- -- 传递回调函数名字
-- function CommonTips:callfunName(okCallFun,cancelCallFun)  
--     self._okCallFun = okCallFun
--     self._cancelCallFun = cancelCallFun
-- end

-- -- 更新视图
-- function CommonTips:onUpdateView()

-- end