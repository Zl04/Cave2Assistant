-- GeneralHelpLayer.lua
-- Author:zhengping
-- 2019年11月11日
-- Using:公共帮助配置

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"

UI = UI or {}
local GeneralHelpLayer = class("GeneralHelpLayer", UI.HWBtnComponent)
UI.GeneralHelpLayer = GeneralHelpLayer

local COM_RES_LIST = {
    "ui_common_information.plist",
    "ui_common_scale9image.plist"
}

function GeneralHelpLayer:ctor(data)
    -- print("GeneralHelpLayer:ctor")
    self.data = data
    GeneralHelpLayer.super.ctor(
        self, 0,
        COM_RES_LIST,
        0,
        0
        )

end

function GeneralHelpLayer:dtor()
    -- reload_script_file("app.ui.common.GeneralHelpLayer")
    GeneralHelpLayer.super.dtor(self)
    self:unRegisterListener()
end

-- public:
-- 初始化
function GeneralHelpLayer:init()
    GeneralHelpLayer.super.init(self)
    self:registerListener()
end

-- 模版函数：初始化组建的视图
function GeneralHelpLayer:onInitView()
    self:center()
    -- 玩法说明
    local starButton = UI.Button:create() 
    starButton:init()
    starButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showStarInfo)
    starButton:setSize(50,50)
    starButton:center()
    self:addChild(starButton, 100)

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    if(self.data and self.data.hintType == 2) then 
        detailAnimation:setAnimation("idle2", true)
    else
        detailAnimation:setAnimation("idle", true)
    end
    detailAnimation:center()
    starButton:addChild(detailAnimation, 10)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
        self:closeLayer()
    end)
end

function GeneralHelpLayer:closeLayer()
    if self.callback then
        self.callback()
    end
    self:close()
end

-- 模版函数：更新组建的视图
function GeneralHelpLayer:onUpdateView()

end

function GeneralHelpLayer:showStarInfo()
    if self.infoPanel == nil or tolua.isnull(self.infoPanel) then
        if(self.data and self.data.showType == 2) then 
            self:initBannerDetail()
        else
            self:initNormalDetail()
        end

        if(self.infoPanel) then 
            self.infoPanel:leftUp(self.data.openPosition[1], self.data.openPosition[2])
            self.infoPanel:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
                if self.infoPanel then
                    self.infoPanel:removeFromParent()
                    self.infoPanel = nil
                    -- self.infoPanel:setTouchEnable(false)
                    -- self.infoPanel:setInterceptTouches(false)
                end
            end)
            self.infoPanel:setTouchEnable(true)
            self.infoPanel:setInterceptTouches(true)
        end
    else
        self.infoPanel:show()
        -- self.infoPanel:setTouchEnable(true)
        -- self.infoPanel:setInterceptTouches(true)
    end
end

function GeneralHelpLayer:initNormalDetail()
    if self.infoPanel then
        self.infoPanel:removeFromParent()
    end
    self.infoPanel = UI.Layout:create()
    self.infoPanel:init()
    self.infoPanel:setSize(280, 50)
    self.infoPanel:center(0)
    self:addChild(self.infoPanel, 1000)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_background1.png")
    bg:setCapInsets(CCRectMake(12, 12, 2, 2))
    bg:setAnchorPoint(0, 0)
    bg:setContentSize(cc.size(280, 50))
    bg:setPosition(0, 0)
    bg:setName("bg")
    self.infoPanel:addChild(bg)
    -- local direction = UI.Image:create()
    -- direction:init("ui_information_banner_background2.png")
    -- direction:setScaleX(-1)
    -- direction:leftUp(-direction:getContentSize().width + 1, 30)
    -- self.infoPanel:addChild(direction)

    self.infoPanel:show()
    local height = 10
    local cellSpace = 5

    local cell = self:createOneCell(LanguageManager:getInstance():getLocalString(self.data.tips), false)
    if cell then
        cell:leftUp(0, height)
        self.infoPanel:addChild(cell)
        height = height + cell:getContentSize().height + cellSpace
    end

    self.infoPanel:leftUp(315, -15)
    if height then
        local bg = self.infoPanel:getChildByName("bg")
        bg:setContentSize(280, height + 5)
        self.infoPanel:setSize(280, height + 5)
    end
end

function GeneralHelpLayer:initBannerDetail()
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(323, 431)
    panel:centerLeft(132)
    self:addChild(panel, 100)
    self.infoPanel = panel

    local bg = UI.Image:create()
    bg:init("ui_information_banner_details.png")
    bg:center()
    panel:addChild(bg)

    local xAdd = 0
    local yAdd = 0
    local title = UI.Text:create()
    title:init(LanguageManager:getInstance():getLocalString(1112499), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    panel:addChild(title) 
    title:centerUp(20)

    local line  = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    line:setContentSize(282, 2)
    line:setCapInsets(CCRectMake(20,1,1,1))
    line:setPosition(160+xAdd, 373+yAdd)
    panel:addChild(line)

    local desc = UI.Text:create()
    desc:init(LanguageManager:getInstance():getLocalString(self.data.tips), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    desc:setWidth(280)
    desc:autoAdapt()
    desc:centerUp(1)

    local height = desc:getContentSize().height
    height = height < 320 and 320 or height
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(280, height)
    if height > 320 then
        local scrollView = UI.ScrollView:create()
        scrollView:setSize(290, 320)
        scrollView:init()
        scrollView:leftUp(25+xAdd, 67+yAdd)
        scrollView:addInnerNode(layout)
        scrollView:useDefaultScrollBar()
        panel:addChild(scrollView)    
    else
        layout:leftUp(25+xAdd, 67+yAdd)
        panel:addChild(layout)
    end
    layout:addChild(desc)

    local touch = UI.Component:create()
    touch:init()
    touch:setSize(310,410)
    touch:center()
    panel:addChild(touch)
end

function GeneralHelpLayer:createOneCell(content, isRich)
    local success = false
    local _richText = nil
    local cell = nil
    if isRich then
        _richText = UI.RichText:create()
        success = _richText:init(content, 240, UI.FONT_SIZE_16PX)
    elseif content ~= "" then
        success = true
        _richText = UI.Text:create()
        _richText:init(content, UI.SYS_FONT, UI.FONT_SIZE_16PX)
        -- _richText:setTextLeft()
        _richText:setWidth(240)
        _richText:autoAdapt()
    end
    if success then
        cell = UI.Layout:create()
        cell:init()
        _richText:centerLeft(26)
        cell:setSize(260, _richText:getContentSize().height)
        cell:addChild(_richText)
        -- local picDes = UI.Image:create()
        -- picDes:init("ui_checkpoint_banner_diamond.png")
        -- picDes:leftUp(12, 4)
        -- cell:addChild(picDes, 10)
    end
    return cell
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    print("---onTouchDialogOutsizeHandler-----")
    if self.callback then
        self.callback()
    end
    self:close()
end

-- 注册监听事件
function GeneralHelpLayer:registerListener()
    --监听窗口外关闭事件
    
end

-- 注销监听事件
function GeneralHelpLayer:unRegisterListener()
  
end
