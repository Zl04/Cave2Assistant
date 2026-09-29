------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2021/10/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GhostabyssDiffcultyChoiceView = class("GhostabyssDiffcultyChoiceView", UI.HWBtnComponent)
local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 660
local COM_HEIGHT = 402

function GhostabyssDiffcultyChoiceView:ctor()
    GhostabyssDiffcultyChoiceView.super.ctor(
    	self,
    	UI.Type.GHOSTABYSS_DIFFCULTY_SELECT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function GhostabyssDiffcultyChoiceView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    GhostabyssDiffcultyChoiceView.super.init(self, ... )
end

function GhostabyssDiffcultyChoiceView:dtor()
    GhostabyssDiffcultyChoiceView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.cave.GhostabyssDiffcultyChoiceView")
end


function GhostabyssDiffcultyChoiceView:onInitView()
    self:center()
    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:removeEventListenerByName(UIEvent.COMPONENT_TOUCH_OUTSIDE)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                mvc.send(mvc.events.CloseGhostabyssDiffcultyChoice)
            end
        end, 0.01) 
    end)

    local halfBg = UI.Image9:create()
    halfBg:init("ui_ghostabyss_up_02.png", CCRectMake(2,2,1,1), cc.size(winSize.width*2, winSize.height*2))
    halfBg:center()
    self:addChild(halfBg)

    self.haveNum = mvc.caveModel:getGhostAbyssExchangeNum()

    self:initLeft()
    self:initRight()
end

function GhostabyssDiffcultyChoiceView:initLeft()
    local bg = UI.Image:create()
    bg:init("ui_ghostabyss_bg_04.png")
    bg:centerLeft(0)
    self:addChild(bg)

    local titleImage = UI.Image:create()
    titleImage:init("ui_ghostabyss_title_02.png")
    titleImage:centerUp(9)
    bg:addChild(titleImage)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1328005, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_WHITE)
    titleText:center(0,-7)
    titleImage:addChild(titleText)
    
    -- 消耗描述
    local desText = UI.Text:create()
    desText:init(UI.TEXT_1328008.." X1", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_BLACK)
    desText:centerBottom(83-desText:getContentSize().height/2)
    bg:addChild(desText)

    -- 按钮
    local exchangeBtn = UI.Button:create()
    exchangeBtn:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    exchangeBtn:centerBottom(13)
    exchangeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.exchangeBtnClick)
    exchangeBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1212646)
    end)
    bg:addChild(exchangeBtn)

    exchangeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_51_51_51)
    exchangeBtn:setText(UI.TEXT_1328007)
    if(self.haveNum <1) then
        exchangeBtn:disable()
    else
        exchangeBtn:enable() 
    end
end

function GhostabyssDiffcultyChoiceView:initRight()
    local bg = UI.Image:create()
    bg:init("ui_ghostabyss_bg_04.png")
    bg:centerRight(0)
    self:addChild(bg)

    local titleImage = UI.Image:create()
    titleImage:init("ui_ghostabyss_title_03.png")
    titleImage:centerUp(9)
    bg:addChild(titleImage)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1328006, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_WHITE)
    titleText:center(0,-7)
    titleImage:addChild(titleText)

    -- 特殊说明
    local specialImage = UI.Image:create()
    specialImage:init("ui_ghostabyss_title_04.png")
    specialImage:centerBottom(102)
    bg:addChild(specialImage)
    
    local specialText = UI.Text:create()
    specialText:init(UI.TEXT_1328009, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=255,g=216,b=80})
    specialText:center()
    specialImage:addChild(specialText)

    -- 消耗描述
    local desText = UI.Text:create()
    desText:init(UI.TEXT_1328008.." X2", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_BLACK)
    desText:centerBottom(82-desText:getContentSize().height/2)
    bg:addChild(desText)

    -- 按钮
    local exchangeBtn = UI.Button:create()
    exchangeBtn:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    exchangeBtn:centerBottom(13)
    exchangeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.doubleExchangeBtnClick)
    exchangeBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if(self.haveNum > 0) then
            UI.ScrollBar:createByText(UI.TEXT_1328010)
        else
            UI.ScrollBar:createByText(UI.TEXT_1212646)
        end
    end)
    bg:addChild(exchangeBtn)

    exchangeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_51_51_51)
    exchangeBtn:setText(UI.TEXT_1328007)
    if(self.haveNum < 2) then
        exchangeBtn:disable()
    else
        exchangeBtn:enable() 
    end
end

function GhostabyssDiffcultyChoiceView:exchangeBtnClick()
    Net.NetRoleSystem:heroEnterCaveSceneRequest(
        PublicDefine.GAME_MODE.MODE_SOLO,
        PublicDefine.CAVE_MODE.MODE_GHOST_ABYSS,
        PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
        mvc.caveModel:getCurrentGhostabyssData().ID,
        self.spriteID,false)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

function GhostabyssDiffcultyChoiceView:doubleExchangeBtnClick()
    Net.NetRoleSystem:heroEnterCaveSceneRequest(
        PublicDefine.GAME_MODE.MODE_SOLO,
        PublicDefine.CAVE_MODE.MODE_GHOST_ABYSS,
        PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
        mvc.caveModel:getCurrentGhostabyssData().ID,
        self.spriteID, true)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

function GhostabyssDiffcultyChoiceView:bindModel()

end


function GhostabyssDiffcultyChoiceView:unbindModel()

end





return GhostabyssDiffcultyChoiceView












