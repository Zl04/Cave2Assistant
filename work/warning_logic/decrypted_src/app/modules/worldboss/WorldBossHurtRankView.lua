------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/23
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
require "app.ui.mainUi.CaveActivityDSP"
local WorldBossHurtRankView = class("WorldBossHurtRankView", UI.CaveActivityDSP)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local layoutUU
function WorldBossHurtRankView:ctor()
    layoutUU = UIUtil:createAutoUILayout("WorldBossHurtRankView","app.modules.worldboss.WorldBossPosConfig", __EDIT_)
    WorldBossHurtRankView.super.ctor(self)
    self:bindModel()
end

function WorldBossHurtRankView:dtor()
    WorldBossHurtRankView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.worldboss.WorldBossHurtRankView")
end


function WorldBossHurtRankView:onInitView()
    WorldBossHurtRankView.super.onInitView(self)
    self.costInfos = mvc.worldBossModel:getBuffCost()
    -- local img = UI.Image:create()
    -- img:init('ui_goods_icon_backpack.png')
    -- addChildAuto(layoutUU, self, img, "img")
    
 
    local btnChange = UI.Component:create()
    btnChange:init()
    btnChange:setSize(60,60)
    -- btnChange:enableDebugDraw()
    addChildAuto(layoutUU, self, btnChange, "btnChange","center")
    btnChange:setTouchEnable(true)
    -- btn:enableDebugDraw()
    btnChange:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, button, touchPosition)
        if self.isShowBuyBuff then
            self:showRank()
        else
            self:showBuyBuffContent()
        end
    end)
    
    local headAnimation = UI.Animation:create()
    headAnimation:init(
        "effect_ui_town_worldboss_buff_tips.json",
        "effect_ui_town_worldboss_buff_tips.atlas",
        1
    )
    headAnimation:center()
    btnChange:addChild(headAnimation)
    self.headAnimation = headAnimation

    self:showBuyBuffContent()
    self:showStartCD()
end

function WorldBossHurtRankView:showRank()
    self.isShowBuyBuff = false
    if self.buffLayer then
        self.buffLayer:removeFromParent()
        self.buffLayer = nil
    end

    self.headAnimation:setAnimation("idle_hurt", false)
    self.titleText:setText(UI.TEXT_1212085)
    self.rootLayer:setVisible(true)
end

function WorldBossHurtRankView:showBuyBuffContent()
    if self.buffLayer then
        self.buffLayer:removeFromParent()
    end
    self.headAnimation:setAnimation("idle_buff", false)
    self.isShowBuyBuff = true
    self.titleText:setText(UI.TEXT_1212625)
    self.rootLayer:setVisible(false)

    local size = self:getContentSize()
    self.buffLayer = UI.Layout:create()
    self.buffLayer:init()
    self.buffLayer:center()
    self.buffLayer:setSize(size.width, size.height)
    self:addChild(self.buffLayer)
    -- self.buffLayer:enableDebugDraw()
    
    local buffData, isMaxBuffMore = mvc.worldBossModel:getNextBuffData()
    local img = UI.Image:create()
    img:init("effect_buff_inspire_big.png")
    addChildAuto(layoutUU, self.buffLayer, img, "img","center")
    
    local desc = UI.Text:create()
    local str = buffData.description
    if isMaxBuffMore then
        str = UIUtil:lang(1112357) .. str
    else
        str = UIUtil:lang(1112356) .. str
    end
    desc:init(str, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    addChildAuto(layoutUU, self.buffLayer, desc, "Buffdesc","leftBottom")

    local desc = UI.Text:create()
    desc:init(string.format(UI.TEXT_1212627, mvc.worldBossModel:getCurBuyBuffNum()), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    addChildAuto(layoutUU, self.buffLayer, desc, "BuffBuyTime","leftBottom")
    
    local goldBtn = UI.Button:create()
    goldBtn:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png")
    goldBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        mvc.send(mvc.events.WorldBoss_BuyBuff_Touch, 1)
    end)
    addChildAuto(layoutUU, self.buffLayer, goldBtn, "goldBtn","leftBottom")

    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    layout:center()
    goldBtn:addChild(layout, 1001)

    local img = UI.Image:create()
    img:init('symbol_gaming_diamond.png')
    img:floatLeft(0)
    layout:addComponent(img)
    local cost = self.costInfos[2]
    local costtext = UI.GoodsCostText:create(cost[2],tonumber(cost[1]), tonumber(cost[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    costtext:floatLeft(5)
    layout:addComponent(costtext)
     
    local silverBtn = UI.Button:create()
    silverBtn:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png")
    silverBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        mvc.send(mvc.events.WorldBoss_BuyBuff_Touch, 0)
    end)
    addChildAuto(layoutUU, self.buffLayer, silverBtn, "silverBtn","leftBottom")

    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    layout:center()
    silverBtn:addChild(layout, 1001)

    local img = UI.Image:create()
    img:init('symbol_gaming_money.png')
    img:floatLeft(0)
    layout:addComponent(img)

    local cost = self.costInfos[1]
    local costtext = UI.GoodsCostText:create(cost[2],tonumber(cost[1]), tonumber(cost[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    costtext:floatLeft(5)
    layout:addComponent(costtext)
    
    local desc = UI.Text:create()
    desc:init(UI.TEXT_1212628, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    addChildAuto(layoutUU, self.buffLayer, desc, "descBottom","center")
end

function WorldBossHurtRankView:showStartCD()
    local len = mvc.worldBossModel:getFightRemindCD()
    if len > 0 then
        mvc.openPanel("WorldBoss", "WorldBossFightCD", function() return mvc.worldBossModel:getFightRemindCD() end)
    end
end

function WorldBossHurtRankView:onBuyBuffNumChanged()
    if mvc.worldBossModel:isMaxBuyBuff(mvc.worldBossModel:getCurBuyBuffNum() + 1)  then
        self:showRank()
    else
        self:showBuyBuffContent()
    end
end

function WorldBossHurtRankView:bindModel()
    mvc.worldBossModel:bind("buyBuffNum",self, self.onBuyBuffNumChanged)
    mvc.worldBossModel:bind("startTime",self, self.showStartCD)
end


function WorldBossHurtRankView:unbindModel()
    mvc.worldBossModel:unbind("buyBuffNum",self, self.onBuyBuffNumChanged)
    mvc.worldBossModel:unbind("startTime",self, self.showStartCD)
end




return WorldBossHurtRankView












