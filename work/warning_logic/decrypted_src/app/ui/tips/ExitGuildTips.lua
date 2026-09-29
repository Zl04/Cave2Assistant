
require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local ExitGuildTips = class("ExitGuildTips",UI.ConfirmDialog)
UI.ExitGuildTips = ExitGuildTips
--  ui_tips_team

--  构造函数
function ExitGuildTips:ctor()
    ExitGuildTips.super.ctor(self)
end

--  析构函数 调用父类的方法
function ExitGuildTips:dtor()
    ExitGuildTips.super.dtor(self)
end

--  初始化函数
function ExitGuildTips:init(str)
    self._str = str
    ExitGuildTips.super.init(self, "", nil, nil, nil, ConfirmType.CANCEL_RED_OK_WHITE)
end

--  初始化界面函数
function ExitGuildTips:onInitView()
    ExitGuildTips.super.onInitView(self)

    local titleText_1 = UI.Text:create()
    titleText_1:init(self._str,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText_1:centerUp(17)
    titleText_1:setDimensions(350,0)
    self.ConfirmDialogModel.contentBg:addChild(titleText_1, 10)
         
    local medalIcon = UI.Image:create()
    medalIcon:init("symbol_guild_tech_icon_medal.png")
    -- medalIcon:leftUp(self.ConfirmDialogModel.contentBg:getContentSize().width / 2 - titleText_1:getContentSize().width / 2 - crystal_Icon:getContentSize().width, 20)
    self.ConfirmDialogModel.contentBg:addChild(medalIcon, 10)

    local LanguageManager = require("app.game.LanguageManager")
    local medalText = UI.Text:create()
    medalText:init(LanguageManager:getInstance():getLocalString(1111678),UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    medalText:centerLeft(medalIcon:getContentSize().width + 4)
    medalIcon:addChild(medalText)

    local height = 127
    local padingHeight = 10

    local upOffset = height /2 - (titleText_1:getContentSize().height + medalText:getContentSize().height + padingHeight)/2
    local left = (350 - (medalIcon:getContentSize().width + medalText:getContentSize().width + 4)) /2

    titleText_1:centerUp(upOffset)
    medalIcon:leftUp(10 + left, upOffset + titleText_1:getContentSize().height + padingHeight)
end

-- 传递回调函数名字
function ExitGuildTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end


-- 更新视图
function ExitGuildTips:onUpdateView()

end