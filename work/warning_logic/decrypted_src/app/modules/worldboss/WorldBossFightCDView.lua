------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/06/05
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local WorldBossFightCDView = class("WorldBossFightCDView", UI.HWBtnComponent)
local SceneManager = require("app.game.SceneManager")

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local layoutUtil
function WorldBossFightCDView:ctor(getTimeFunc)
    WorldBossFightCDView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:center()
    self.getTimeFunc = getTimeFunc
    layoutUtil = UIUtil:createAutoUILayout("WorldBossFightCDView","app.modules.worldboss.WorldBossPosConfig", false)
end

function WorldBossFightCDView:dtor()
    WorldBossFightCDView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.worldboss.WorldBossFightCDView")
end


function WorldBossFightCDView:onInitView()

    local img = UI.Image:create()
    img:init("ui_boss_countdown.png")
    img:center()
    self:addChild(img)
    

    local slotLayout = UI.Layout:create()
    slotLayout:init(0, 0)
    img:addChild(slotLayout)
    slotLayout:centerBottom(235)


    local text = UI.Text:create()
    text:init(UIUtil:lang(1112342), UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_255_255_255)
    if SceneManager:getInstance():isInPuzzle() then
        text:setText(UI.TEXT_1324401)
    end
    text:centerUp(42)
    img:addChild(text)

    local slotAnimation = Avalon.Animation:create("effect_ui_gaming_count_dead.json", "effect_ui_gaming_count_dead.atlas", 1);
    slotAnimation:setAnimation(0, "idle2", true)
    slotLayout:addChild(slotAnimation)
    slotAnimation:setPosition(cc.p(0, 0))
    
    self._slotAnimation = slotAnimation

    -- 添加挂载点
    local countTimeLabel = cc.LabelAtlas:create(string.format("%d",self.getTimeFunc()), "ui_dead_number.png", 80, 120, 48)
    -- local countTimeLabel = cc.LabelAtlas:create(string.format("%d",11), "ui_dead_number.png", 80, 120, 48)
    countTimeLabel:setAnchorPoint(cc.p(0.5, 0.5))
    countTimeLabel:setPosition(cc.p(0,0))
    slotAnimation:addComponent("count-dead-number1", countTimeLabel)
    -- countTimeLabel:setScale(0.8)
    Avalon.AudioManager:playSound("506")
    
    local this = self
    slotAnimation:registerSpineEventHandler(function (event)
        local cd = self.getTimeFunc()
        -- local cd = 10
        if(cd > 0) then                            
            Avalon.AudioManager:playSound("506")
        end
        -- 更新倒计时显示
        countTimeLabel:setString(string.format("%d",cd))

        -- 判断切换倒计时完成
        if cd < 1 then
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                mvc.closePanel("WorldBoss", "WorldBossFightCD")
            end, 0.1)
        end

    end, sp.EventType.ANIMATION_COMPLETE)
    
end


function WorldBossFightCDView:bindModel()

end


function WorldBossFightCDView:unbindModel()

end





return WorldBossFightCDView












