------------------------------------------------------------------------------
------------------------------------------------------------------------------
--author: yudong.li
--date	: 2020/05/11
--desc	: 
------------------------------------------------------------------------------
local FestivalRelicCell = class("FestivalRelicCell", UI.HWBtnComponent)
UI = UI or {}
UI.FestivalRelicCell = FestivalRelicCell
local winSize = cc.Director:getInstance():getWinSize()
-- 资源
local COM_RES_LIST = {
    "ui_common_icon_relic.plist"
}

local COM_WIDTH = 915
local COM_HEIGHT = 590

--chargeCallback：兑换响应， clickCallback：详情响应
function FestivalRelicCell:ctor(isBig, data, chargeCallback)
    if isBig then
        FestivalRelicCell.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, 228, 527)
    else
        FestivalRelicCell.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, 168, 433)
    end
    self.chargeCallback = chargeCallback
    self.isBig = isBig
    self.data = data
    self:init()
    self:bindModel()
end

function FestivalRelicCell:init( ... )
    FestivalRelicCell.super.init(self, ... )
end

function FestivalRelicCell:dtor()
    FestivalRelicCell.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.festival.FestivalRelicCell")
end


function FestivalRelicCell:onInitView()
    if not self.isBig then
        local blackbg = UI.Image:create()
        blackbg:init("ui_festival_relic_bg.png")
        blackbg:center()
        blackbg:setScale(1.25)
        self:addChild(blackbg)
    else

        local bg = cc.LayerColor:create(cc.c4b(0,0,0,153))
        bg:setPosition(self:getContentSize().width / 2 - winSize.width / 2, self:getContentSize().height / 2 - winSize.height / 2)
        bg:setContentSize(winSize.width, winSize.height)
        self:addChild(bg)

        local bgAnimation = UI.Animation:create()
        bgAnimation:init("effect_ui_festival_relic_choice_board_light.json", "effect_ui_festival_relic_choice_board_light.atlas", 1);
        bgAnimation:center()
        self:addChild(bgAnimation)
        local aniName = string.format("idle%d", self.data:getGoodsRare() - 1)
        bgAnimation:setAnimation(aniName, true)

        local blackbg = UI.Image:create()
        blackbg:init("ui_festival_relic_bg.png")
        blackbg:center()
        blackbg:setScale(1.25)
        bgAnimation:addComponent("mount_choice_board", blackbg)

        self:setTouchEnable(true)
        self:setSwallowTouches(true)
        self:setInterceptTouches(true)
        self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
    end

    local bgName = ""
    if self.isBig then
        bgName = string.format("ui_festival_relic_show_board_%d.png", self.data:getGoodsRare() - 1)
    else
        bgName = string.format("ui_festival_relic_choice_board_%d.png", self.data:getGoodsRare() - 1)
    end
    local bg = UI.Image:create()
    bg:init(bgName)
    bg:center()
    self:addChild(bg, 1)

    local bgName = string.format("ui_festival_relic_box_%d.png", self.data:getGoodsRare() - 1)
    local iconBg = UI.Image:create()
    iconBg:init(bgName)
    if self.isBig then
        iconBg:centerUp(69.5)
    else
        iconBg:centerUp(39.5)
    end
    bg:addChild(iconBg, 1)

    local icon = UI.Image:create()
    icon:init(self.data:getIconName())
    icon:center()
    iconBg:addChild(icon, 1)

    -- 标题
    local title = UI.Text:create()
    local LanguageManager = require("app.game.LanguageManager")
    if(LanguageManager:getInstance():getLanguage() == cc.LANGUAGE_CHINESE 
        or LanguageManager:getInstance():getLanguage() == cc.LANGUAGE_CHINESE_TRADITIONAL) then
        title:init(self.data:getName(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    else
        title:init(self.data:getName(), UI.FONT_BOLD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_41_41_45)
    end
    
    if self.isBig then
        title:centerUp(247 - title:getContentSize().height/2)
    else
        title:centerUp(206 - title:getContentSize().height/2)
    end
    bg:addChild(title)
    
    local descText = self.data:getDescription()
    if not self.isBig then
        if AvalonUtil:isUpLimiteStr(descText, 500, 14) then
            descText = AvalonUtil:getSubNameStrByLabel(descText, 500, 14) .. "..."
        end
    end
 
    if self.isBig then
        local desc = UI.Text:create()
        desc:init(descText, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 169, g = 209, b = 161})
        desc:center()
        desc:setWidth(166, 120)
        desc:autoAdapt()

        local scrollView = UI.ScrollView:create()
        scrollView:setSize(170, 120)
        scrollView:init(0, 0, 0, 0)
        scrollView:centerUp(270)
        bg:addChild(scrollView)

        local scrollLayout = UI.Layout:create()
        scrollLayout:init()
        scrollLayout:setSize(170, desc:getContentSize().height)
        scrollLayout:leftUp(0, 0)
        scrollView:addInnerNode(scrollLayout)
        scrollLayout:addChild(desc)
    else
        local desc = UI.Text:create()
        desc:init(descText, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 169, g = 209, b = 161})
        desc:centerUp(230)
        desc:setSize(156, 88)
        bg:addChild(desc)
        desc:setTextLeftUp()
    end
    
    if self.chargeCallback then
        local clickButton = UI.Button:create()
        clickButton:init("ui_btn_relic_choice_0.png", "ui_btn_relic_choice_1.png", "ui_btn_relic_choice_2.png")
        clickButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:chargeCallback(self.data)
        end)
        clickButton:centerBottom(55)
        bg:addChild(clickButton,5)

        local btnTip = UI.Text:create()
        btnTip:init( UI.TEXT_1150011, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        btnTip:center()
        clickButton:addChild(btnTip, 10)
    end
    
    if not self.isBig then
        local info = UI.Layout:create()
        info:init()
        info:setSize(180, 300)
        info:center()
        bg:addChild(info)
        info:setTouchEnable(true)
        info:setSwallowTouches(false)
        info:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.infoTouchBegin)
        info:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.infoTouchEnd)
    end
end

function FestivalRelicCell:infoTouchBegin(sender, touch)
    self.beginTouchPoint = touch
end

function FestivalRelicCell:infoTouchEnd(sender, touch)
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPoint, touch) then
        return
    end 
    self.beginTouchPoint = nil
    local view = UI.FestivalRelicCell:create(true, self.data)
    view:center()
    UI.UIManager:addToRootNode(view, UI_ZORDER.TIPS)
end

-- 点击外部区域的处理器(关闭)(可选)
function FestivalRelicCell:onTouchOutSizeEvent()
    self:close()
end

function FestivalRelicCell:bindModel()
end

function FestivalRelicCell:unbindModel()

end


return FestivalRelicCell












