-- JumpToCommentTips.lua
-- Author:ydli
-- 2017年12月05日
-- Using:跳转 评论提示框 
require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
UI = UI or {}
local JumpToCommentTips = class("JumpToCommentTips",UI.HWBtnComponent)
UI.JumpToCommentTips = JumpToCommentTips
local winSize = cc.Director:getInstance():getWinSize()

local PLIST = {
}

--  点击确定按钮 
local function onConfirmButton(self)
    self:close()  
    -- TODO  
    if(self._okCallFun) then 
        self._okCallFun()
    end
end

--  点击取消按钮
local function onCancleButton(self)
    self:close()   
    if(self._cancelCallFun) then 
        self._cancelCallFun()
    end
end

-- 点击TIPS外区域关闭
local function onTouchOutTipsUI(self)
    -- self:close()
end

--  构造函数
function JumpToCommentTips:ctor()
    JumpToCommentTips.super.ctor(self,UIType.JUMP_TO_COMMENT_TIPS,PLIST,429,286)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
end

--  析构函数 调用父类的方法
function JumpToCommentTips:dtor()
    JumpToCommentTips.super.dtor(self)
end

--  初始化函数
function JumpToCommentTips:init()
    JumpToCommentTips.super.init(self)
end

--  初始化界面函数
function JumpToCommentTips:onInitView()
    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,125))
    colorLayer:setIgnoreAnchorPointForPosition(false)
    colorLayer:setAnchorPoint(cc.p(0.5,0.5))
    colorLayer:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)
    colorLayer:setContentSize(winSize.width, winSize.height)
    self:addChild(colorLayer,-1)

    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box3.png")
    bg:center()
    self:addChild(bg)

    -- 描述语言
    local desBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_setup_banner_box_up.png", cc.rect(0,0,1,1))
    desBg:setContentSize(cc.size(370, 130))  
    desBg:setAnchorPoint(cc.p(0, 0))
    desBg:setPosition(cc.p(30, 125))
    bg:addChild(desBg)
        
    local titleText = UI.Text:create() 
    titleText:init(UI.TEXT_1170915, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(38)
    titleText:setSize(350,120)
    titleText:setTextCenter()
    bg:addChild(titleText, 10)
    -- titleText:enableDebugDraw()

    local agreeButton = UI.Button:create()
    agreeButton:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png")
    agreeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        self:close()
        if self._okCallFun then
            self:_okCallFun()
        end
    end)
    agreeButton:leftBottom(50, 40)
    agreeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    agreeButton:setText(UI.TEXT_1170913)
    self:addChild(agreeButton)

    local confuseButton = UI.Button:create()
    confuseButton:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png")
    confuseButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        self:close()
        if self._cancelCallFun then
            self:_cancelCallFun()
        end
    end)
    confuseButton:rightBottom(50, 40)
    confuseButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    confuseButton:setText(UI.TEXT_1170914)
    self:addChild(confuseButton)
end

-- 传递回调函数名字
function JumpToCommentTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end

-- 更新视图
function JumpToCommentTips:onUpdateView()

end