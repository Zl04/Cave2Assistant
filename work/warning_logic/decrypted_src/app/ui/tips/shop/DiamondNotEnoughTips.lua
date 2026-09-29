--[[
    AUTHOR:ZIHANCHEN
    2017-4-26
    USING: 砖石不够的TIPS
]]

require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local DiamondNotEnoughTips = class("DiamondNotEnoughTips", UI.ConfirmDialog)
UI.DiamondNotEnoughTips = DiamondNotEnoughTips

function DiamondNotEnoughTips:ctor(addToTopLayer)
    DiamondNotEnoughTips.super.ctor(self)
    self._addToTopLayer = addToTopLayer
end

--  析构函数 调用父类的方法
function DiamondNotEnoughTips:dtor()
    DiamondNotEnoughTips.super.dtor(self)
end

--  初始化函数
function DiamondNotEnoughTips:init()
    DiamondNotEnoughTips.super.init(self)
end

--  初始化界面函数
function DiamondNotEnoughTips:onInitView()
    DiamondNotEnoughTips.super.onInitView(self)
      -- 不足 TEXT_111015 
    self.text = UI.TEXT_111016
    self.ConfirmDialogModel.contentLabel:setText(self.text);
    self.ConfirmDialogModel.contentLabel:centerUp(45)

    local titleText_1 = UI.Text:create()
    titleText_1:init(UI.TEXT_111015,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText_1:centerUp(17)
    self.ConfirmDialogModel.contentBg:addChild(titleText_1, 10)
         
    local crystal_Icon = UI.Image:create()
    crystal_Icon:init("symbol_gaming_diamond.png")
    crystal_Icon:leftUp(self.ConfirmDialogModel.contentBg:getContentSize().width / 2 - titleText_1:getContentSize().width / 2 - crystal_Icon:getContentSize().width, 20)
    self.ConfirmDialogModel.contentBg:addChild(crystal_Icon, 10)

end


-- 更新视图
function DiamondNotEnoughTips:onUpdateView()

end

-- 传递回调函数名字
function DiamondNotEnoughTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end

function DiamondNotEnoughTips:ok()
    local SdkBox = require("utils.sdkbox.SdkBox")
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    
    -- 屏蔽内购
    
    
    if (self._addToTopLayer) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP_IN_REVIVE)
    else
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, 1, nil, 
            PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_DiamondNotEnough)
    end

    DiamondNotEnoughTips.super.ok(self)
end


