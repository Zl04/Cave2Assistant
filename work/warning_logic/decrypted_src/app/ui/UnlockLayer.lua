-- UnlockLayer.lua
-- Author:zp
-- 2017年8月2日
-- Using:顶层窗口界面


require("app.ui.cave.kickedLayer.KickedPanel")

local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local UnlockLayer = class("UnlockLayer", UI.HWBtnComponent)
UI.UnlockLayer = UnlockLayer

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
}

--构造函数(必备)
function UnlockLayer:ctor(icon,text,extraData)
    print("UnlockLayer:ctor")
    --窗口大小
    UnlockLayer.super.ctor(
    self,UIType.UNLOCK_LAYER,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )
    self._icon = icon
    self._text = text
    self._extraData = extraData

    self.rootLayer = nil;           --root节点

    self:init();
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function UnlockLayer:dtor()
    Game.FunctionUnlockManager:getInstance():clearQueneLock()
    UnlockLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function UnlockLayer:init()
    UnlockLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function UnlockLayer:onInitView()
    self._dropDown = UI.Animation:create()
    self._dropDown:init("effect_ui_gaming_checkpoint.json", "effect_ui_gaming_checkpoint.atlas")
    self._dropDown:centerUp(0)
    self._dropDown:setSize(1, 1) --避免被优化不显示
    self._dropDown:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event)
        if event.animation == "idle" then
            performWithDelay(self, function() 
                Game.FunctionUnlockManager:getInstance():clearQueneLock()
                Game.FunctionUnlockManager:getInstance():noticeShowAction()
            end, 0.3)
        end
    end)
    self:addChild(self._dropDown, UI_ZORDER.MAX)

    -- 默认排版
    local defaultLayout = UI.Layout:create()
    defaultLayout:init()
    defaultLayout:setSize(440, 140)
    defaultLayout:center(0, 5)
    self._dropDown:addComponent("name", defaultLayout)
    self._layout = defaultLayout

    local iconAnchor = UI.Component:create()
    iconAnchor:init()
    iconAnchor:centerLeft(90)
    self._layout:addChild(iconAnchor)

    local iconImage = "ui_unlock_function_icon_4.png"
    local logo = UI.Image:create()
    logo:init(iconImage)
    logo:center()
    iconAnchor:addChild(logo)
    self._logo = logo

    local titleAnchor = UI.Component:create()
    titleAnchor:init()
    titleAnchor:centerRight(170)
    self._layout:addChild(titleAnchor)

    local title = UI.Text:create()
    title:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX)
    title:setSize(235, 80)
    title:center()
    title:setTextCenter()
    title:setLineSpacing(-8)
    title:setFontColor(UI.FONT_COLOR_170_170_170)
    titleAnchor:addChild(title)
    self._title = title

    local txtData = UI.Text:create()
    txtData:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX)
    txtData:setSize(250, 56)
    txtData:center()
    txtData:setTextCenter()
    txtData:setFontColor(UI.FONT_COLOR_170_170_170)
    txtData:setVisible(false)
    defaultLayout:addChild(txtData)
    self._txtData = txtData


    -- 称号排版
    self._heroTitleLayout = UI.Layout:create()
    self._heroTitleLayout:init()
    self._heroTitleLayout:enableAutoWidth()
    self._heroTitleLayout:enableAutoHeight()
    self._heroTitleLayout:center()
    self._dropDown:addComponent("name", self._heroTitleLayout)

    local titleLabel = UI.Text:create()
    titleLabel:init(UI.TEXT_DES_GOT_TITLE, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_170_170_170)
    titleLabel:floatLeft(0)
    titleLabel:setTextCenter()
    titleLabel:setFontColor(UI.FONT_COLOR_234_188_105)
    self._heroTitleLayout:addComponent(titleLabel)

    self._titleText = UI.Text:create()
    self._titleText:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_155_155_155)
    self._titleText:floatLeft(5)
    self._heroTitleLayout:addComponent(self._titleText)

    self:refreshView(self._icon,self._text,self._extraData)
end

-- 显示默认布局, 异常其他布局
function UnlockLayer:showDefaultLayout()
    self._layout:show()
    self._heroTitleLayout:hide()
end

-- 显示称号布局, 隐藏其他布局
function UnlockLayer:showHeroTitleLayout()
    self._layout:hide()
    self._heroTitleLayout:show()
end

-- 刷新布局总入口
function UnlockLayer:refreshView(iconImage,text,extraData)
    -- 如果没有额外数据就用默认排版, 有额外数据就使用额外数据判断排版
    if (extraData) then self._extraData = extraData end
    if (not self._extraData) then
        self:showDefaultLayout()
        self:defaultRefreshView(iconImage,text)
    elseif (self._extraData.titleID) then
        self:showHeroTitleLayout()
        self:titleRefreshView(self._extraData.titleID)
    end
    self._extraData = nil
end

-- 刷新称号布局
function UnlockLayer:titleRefreshView(titleID)
    local display = true
    -- 更新称号和颜色
    require "app.datas.TitleDataManager"
    local titleData = TitleDataManager:getTitleDataFromID(titleID)
    if (titleData) then
        if (titleData:getTitleFunctionType() == 51) then
            local mentor = mvc.apprenticeshipModel:getMentor()
            if (mentor) then
                titleData:setParam(mentor.nickName)
            else
                display = false
            end
        end
        self._titleText:setText("<" .. titleData:getTitleName() .. ">") -- 无称号
        self._titleText:setFontColor(titleData:getTitleColor())
    end
    self._titleText:setOutline(UI.FONT_COLOR_OUTLINE_TITLE_HERO, 1)
    self._heroTitleLayout:updateView()

    -- 播放动画
    if display and self._dropDown and (not tolua.isnull(self._dropDown)) then
        -- self._dropDown:setAnimation("idle",false)
        performWithDelay(self, function() 
            self._dropDown:setAnimation("idle",false)
        end, 0.1)
        Avalon.AudioManager:playSound("1522")
    end
end

-- 刷新默认布局
function UnlockLayer:defaultRefreshView(iconImage,text)
    Avalon.AudioManager:playSound("1522")
    
    if self._logo and (not tolua.isnull(self._logo)) then
        if iconImage then
            self._logo:setSpriteName(iconImage)
            self._logo:setVisible(true)
        else
            self._logo:setVisible(false)
        end
    end

    if self._title and (not tolua.isnull(self._title)) then
        if iconImage == nil then
            self._title:setVisible(false)
        else
            -- local width = cc.Label:CalculateStringSize(text, UI.FONT_ARIAL, self._title:getFontSize()).width
            -- if width < 235 then
            --     self._title:setSize(0, 0)
            --     self._title:autoAdapt()
            -- else
            --     self._title:setSize(235, 80)
            -- end
            self._title:setText(text)
            self._title:setVisible(true)
        end
    end

    if self._txtData and (not tolua.isnull(self._txtData)) then
        if iconImage == nil then
            self._txtData:setVisible(true)
            self._txtData:setText(text)
        else
            self._txtData:setVisible(false)
        end
    end


    if self._dropDown and (not tolua.isnull(self._dropDown)) then
        performWithDelay(self, function() 
            self._dropDown:setAnimation("idle",false)
        end, 0.2)
    end
    self._layout:updateView()

    -- local textWidth = self._title:getContentSize().width
    -- if textWidth < 120 then
    --     textWidth = 150
    -- end
    -- local left = (self._layout:getContentSize().width - self._logo:getContentSize().width - textWidth) / 2
    -- self._logo:centerLeft(left - 16)
    -- self._title:centerRight(left)
end

function UnlockLayer:show()

end

-- 模版函数：更新组建的视图(必备)
function UnlockLayer:onUpdateView()

end

-- 注册监听事件(可选)
function UnlockLayer:registerListener()
end

-- 注销监听事件(可选)
function UnlockLayer:unRegisterListener()
end
