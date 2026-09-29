------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/22
--desc	: 
------------------------------------------------------------------------------

local WorldBossDieResultView = class("WorldBossDieResultView", UI.HWBtnComponent)
local winSize = cc.Director:getInstance():getWinSize()
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

local REVIVE_BTN_NOMRL = "ui_btn_yellow4_0.png"
local REVIVE_BTN_CLICK = "ui_btn_yellow4_1.png"
local REVIVE_BTN_DISABLE = "ui_btn_yellow4_2.png"

local DIAMON_ICON_SPRITE = "symbol_gaming_diamond.png"


-- 资源
local COM_RES_LIST = {
}

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
local layoutUtil
--param = {notShowBtns: 不显示按钮， countdown ：倒计时秒}
function WorldBossDieResultView:ctor(param)
    WorldBossDieResultView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    layoutUtil = UIUtil:createAutoUILayout("WorldBossDieResultView","app.modules.worldboss.WorldBossPosConfig", false)
    self._countDown = param and param.countDown or 90
    self.isShowBtn = true
    if param and param.notShowBtns then
        self.isShowBtn = false
    end
end

function WorldBossDieResultView:dtor()
    WorldBossDieResultView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.worldboss.WorldBossDieResultView")
end


function WorldBossDieResultView:onInitView()

    -- local img = UI.Image:create()
    -- img:init('ui_goods_icon_backpack.png')
    -- addChildAuto(layoutUU, self, img, "img")

    -- 添加一个半透明背景
    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,120))
    blackBg:setContentSize(winSize.width, winSize.height)
    self:addChild(blackBg)

    -- 添加结算页面
    local reviveAnimation = Avalon.Animation:create("effect_ui_gaming_count_dead.json", "effect_ui_gaming_count_dead.atlas", 1);
    reviveAnimation:setAnimation(0, "start",false)
    reviveAnimation:addAnimation(0, "idle1", true)
    reviveAnimation:setPosition(cc.p(winSize.width/2, winSize.height /2))
    reviveAnimation:setScale(ToolsUtil:getAdaptationMaxScale())
    self:addChild(reviveAnimation)
    self._reviveAnimation = reviveAnimation
    

    local slotLayout = UI.Layout:create()
    slotLayout:init(0, 0)
    self:addChild(slotLayout)
    slotLayout:centerBottom(winSize.height/2 + 750/2 - 65)

    local slotAnimation = Avalon.Animation:create("effect_ui_gaming_count_dead.json", "effect_ui_gaming_count_dead.atlas", 1);
    slotAnimation:setAnimation(0, "idle2", true)
    slotLayout:addChild(slotAnimation)
    -- slotAnimation:setPosition(cc.p(winSize.width/2, winSize.height /2))
    slotAnimation:setPosition(cc.p(0, 0))
    
    self._slotAnimation = slotAnimation

    if self._countDown < 0 then
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            mvc.closePanel("WorldBoss", "WorldBossDie")
        end, 0.1)
        return
    end
    -- 添加挂载点
    print("RevivePanel  create label")
    local countTimeLabel = cc.LabelAtlas:create(string.format("%d",self._countDown), "ui_dead_number.png", 80, 120, 48)
    countTimeLabel:setAnchorPoint(cc.p(0.5, 0.5))
    countTimeLabel:setPosition(cc.p(0,-160))
    slotAnimation:addComponent("count-dead-number1", countTimeLabel)
    countTimeLabel:setScale(0.8)
    Avalon.AudioManager:playSound("506")
    
    local this = self
    slotAnimation:registerSpineEventHandler(function (event)
        if(self._countDown > 0) then                            
            self._countDown = self._countDown - 1
            Avalon.AudioManager:playSound("506")
        end
        -- 更新倒计时显示
        countTimeLabel:setString(string.format("%d",self._countDown))

        -- 判断切换倒计时完成
        if self._countDown == 1 then
            -- 播放最后的动画
            self._reviveAnimation:setAnimation(0, "end", false)
        end

        if(self._countDown == 0) then
            mvc.send(mvc.events.WorldBoss_Revive_Immediately)
        end
    end, sp.EventType.ANIMATION_COMPLETE)

    if self.isShowBtn then
        self.centerLayout = UI.Layout:create()
        self.centerLayout:init()
        self.centerLayout:setSize(709,315)
        self.centerLayout:center()
        self:addChild(self.centerLayout)


        -- 上下边界
        local upLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
        upLine:setContentSize(683, 1.1)
        upLine:setCapInsets(CCRectMake(1,0,1,1))
        upLine:setPosition(cc.p(683/2, self.centerLayout:getContentSize().height))
        self.centerLayout:addChild(upLine)

        local bottomLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
        bottomLine:setContentSize(683, 1.1)
        bottomLine:setCapInsets(CCRectMake(1,0,1,1))
        bottomLine:setPosition(cc.p(683/2, 0))
        self.centerLayout:addChild(bottomLine)

        local okLabel = UI.Text:create()
        okLabel:init(UI.TEXT_1212623, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_255_255)
        okLabel:centerBottom(32)
        self.centerLayout:addChild(okLabel)
            

        local okLabel = UI.Text:create()
        okLabel:init(UI.TEXT_1212622, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_255_255_255)
        okLabel:centerUp(-60)
        self.centerLayout:addChild(okLabel)

        self:createBtnArea()
    else
        local okLabel = UI.Text:create()
        okLabel:init(UI.TEXT_1213445, UI.FONT_STANDARD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_255_255_255)
        okLabel:center(0, -130)
        blackBg:addChild(okLabel)
    end
end

function WorldBossDieResultView:pauseAnimation()
    self._slotAnimation:setTimeScale(0)
    self._reviveAnimation:setTimeScale(0)
end

function WorldBossDieResultView:showLoading()
    UI.WaitingLayer:showWaiting(true, self, GAME_NET_DELAY_UI)
end

function WorldBossDieResultView:resureAnimation()
    self._slotAnimation:setTimeScale(1)
    self._reviveAnimation:setTimeScale(1)
end
function WorldBossDieResultView:createBtnArea()

    local reviveButton = UI.Button:create()
    reviveButton:init(REVIVE_BTN_NOMRL, REVIVE_BTN_CLICK, REVIVE_BTN_DISABLE)
    local masterData = GameDataManager:getInstance():getMaster()
    local diamond = mvc.worldBossModel:getReviveCostDiamond()
    reviveButton:centerBottom(winSize.height/2-258)
    
    reviveButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        Avalon.AudioManager:playSound("1503")

        if (DEBUG) then
            print("RevivePanel click the button of revive.")
        end
        if Avalon.MathUtil:checkDiamonEnough(diamond, GameDataManager:getInstance():getDiamond()) then
            -- self:pauseAnimation()

            -- 处理相关逻辑
            -- GameManager:battleReviveHelp(masterData:getSpriteID(), diamond)
            mvc.send(mvc.events.WorldBoss_Revive_Immediately, diamond)

        else 
            -- 显示钻石不够
            -- self:pauseAnimation()
            -- local okCallback = function()
            --     print("onDiamondNotEnough  ok click")
            --     if(self and not tolua.isnull(self)) then
            --         -- TODO 跳转到商店层
            --         self:resureAnimation()
            --     end
            -- end

            local cancelCallback = function()
                if(self and not tolua.isnull(self)) then
                    self:resureAnimation()
                end
            end
            
            -- 处理这里的层级
            local tips = UI.TipsLayer:onDiamondNotEnough(nil, cancelCallback,true)
            if(tips) then 
                tips:setZOrder(UI_ZORDER.MAX)
            end
            tips:removeFromParent(false)
            UI.UIManager:getRootNode():addChild(tips)
        end
    end)

    self:addChild(reviveButton,1)
    self._reviveButton = reviveButton

    local okLabel = UI.Text:create()
    okLabel:init(UI.TEXT_1212624, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    okLabel:centerLeft(20)
    self._reviveButton:addChild(okLabel, 10)

    local iconSprite = UI.Image:create()
    iconSprite:init(DIAMON_ICON_SPRITE)
    self._reviveButton:addChild(iconSprite, 10)

    local diamondLabel = UI.Text:create()
    diamondLabel:init(string.format("%d", diamond), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._reviveButton:addChild(diamondLabel, 10)

    -- 计算三个组件的坐标
    local totalWidth = okLabel:getContentSize().width + iconSprite:getContentSize().width + diamondLabel:getContentSize().width + 20
    local allWidth = self._reviveButton:getContentSize().width
    okLabel:centerLeft(allWidth /2 - totalWidth/2, 0)
    iconSprite:centerLeft(allWidth/2 - totalWidth/2 + okLabel:getContentSize().width + 10, 0)
    diamondLabel:centerLeft(allWidth/2 - totalWidth/2 + okLabel:getContentSize().width + iconSprite:getContentSize().width +10 + 4, 0)
  
    self._diamondLabel = diamondLabel

    self:refreshDiamondFontColor()
end

function WorldBossDieResultView:refreshDiamondFontColor()
    local diamond = mvc.worldBossModel:getReviveCostDiamond()
    if Avalon.MathUtil:checkDiamonEnough(tonumber(diamond), GameDataManager:getInstance():getDiamond()) then
        if(self._diamondLabel) then
            self._diamondLabel:setFontColor(UI.FONT_COLOR_50_50_44)
        end
    else
        if(self._diamondLabel) then
            self._diamondLabel:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
    end
end

function WorldBossDieResultView:resumeCountDown()
    if(self and not tolua.isnull(self)) then
        -- 恢复倒计时
        self:resureAnimation()
    end
end

function WorldBossDieResultView:bindModel()
    if self.isShowBtn then
        Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshDiamondFontColor)
        Avalon.MessageCenter:bind(AvalonMessage.MC_IPASHOP_CLOSE, self, self.resumeCountDown)
    end
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.reviveEnd)
end


function WorldBossDieResultView:unbindModel()
    if self.isShowBtn then
        Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshDiamondFontColor)
        Avalon.MessageCenter:unbind(AvalonMessage.MC_IPASHOP_CLOSE, self, self.resumeCountDown)
    end
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.reviveEnd)
end

function WorldBossDieResultView:reviveEnd(heroData)
    if(heroData and heroData:isMasterHero()) then
        if  SceneManager:getInstance():isWorldBossCave() 
            or SceneManager:getInstance():isInEaster() 
            or SceneManager:getInstance():isInBigCrack()
        then
            mvc.closePanel("WorldBoss", "WorldBossDieResult")
        end
    end
end




return WorldBossDieResultView












