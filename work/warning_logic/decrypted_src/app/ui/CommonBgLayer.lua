-- CommonBgLayer.lua
-- Author:ydli
-- 2018年9月18日
-- Using:共用背景  纯显示  不处理任何逻辑

UI = UI or {}

local CommonBgLayer = class("CommonBgLayer", UI.HWBtnComponent)
UI.CommonBgLayer = CommonBgLayer

local COM_WIDTH = 920
local COM_HEIGHT = 640
-- 资源列表(必备)


--构造函数(必备)
--isShowBtn: 是否需要展现假的不可点击按钮图， false：表示不显示，然后按钮交由外部实现
--isShowInnerBG: 是否显示内部的背景纸
function CommonBgLayer:ctor(isShowFakeBtn, isShowTitleIcon, isShowInnerBG)
    --窗口大小
    CommonBgLayer.super.ctor(
    self,0,
    {},
    COM_WIDTH,  
    COM_HEIGHT
    )
    if isShowFakeBtn == nil then
        self.isShowFakeBtn = true
    else
        self.isShowFakeBtn = isShowFakeBtn
    end
    if isShowTitleIcon == nil then
        self.isShowTitleIcon = true
    else
        self.isShowTitleIcon = isShowTitleIcon
    end
    if isShowInnerBG == true then
        self.isShowInnerBG = true
    end
    self:init()
end

--虚构函数,destroy时调用(必备)
function CommonBgLayer:dtor()
    CommonBgLayer.super.dtor(self)
    reload_script_file("app.ui.CommonBgLayer")
end

-- 初始化(必备)
function CommonBgLayer:init()
    CommonBgLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function CommonBgLayer:onInitView()
    -- self:enableDebugDraw()
    -- 内容面板
    local bg = UI.Image:create()
    bg:init("ui_bg_box2.png")
    bg:centerBottom(0)
    self:addChild(bg)

    if self.isShowInnerBG then
        -- 背景底图
        local bg2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
        bg2:setContentSize(866, 534)
        bg2:setCapInsets(CCRectMake(304, 141, 1, 1))
        bg2:setPosition(cc.p(COM_WIDTH / 2 + 4, COM_HEIGHT / 2 - 32))
        self:addChild(bg2)
    end

    local title1 = UI.Image:create()
    title1:init("ui_bg_fence.png")
    title1:centerUp(6)
    self:addChild(title1)

    local title2 = UI.Image:create()
    title2:init("ui_bg_shield.png")
    title2:centerUp(3)
    self:addChild(title2)

    if self.isShowFakeBtn  then
        local titleLeft = UI.Image:create()
        titleLeft:init("ui_bg_flag_left.png")
        titleLeft:leftUp(188, 0)
        self:addChild(titleLeft)

        local titleRight = UI.Image:create()
        titleRight:init("ui_bg_flag_right.png")
        titleRight:rightUp(188, 0)
        self:addChild(titleRight)
    end
    if self.isShowTitleIcon then
        local titleLogo = UI.Image:create()
        titleLogo:init("ui_bg_banner_box_up.png")
        titleLogo:centerUp(2)
        self:addChild(titleLogo)
    end
end

