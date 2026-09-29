------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/16
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local HitRatResultView = class("HitRatResultView", UI.HWBtnComponent)

require "app.datas.GoodsDataManager"
local SceneManager = require('app.game.SceneManager')

-- 资源
local COM_RES_LIST = {
    "ui_town_festival.plist",
    "ui_town_festival_hitrat.plist",
    "ui_general_tips.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function HitRatResultView:ctor()
    HitRatResultView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function HitRatResultView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.hitrat", "HitRat", false)
    HitRatResultView.super.init(self, ... )
end

function HitRatResultView:dtor()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    HitRatResultView.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.hitrat.HitRatResultView")
end

function HitRatResultView:onInitView()
    self.refreshRoomInterval = 15

    self._data = mvc.hitRatModel:getBattleResult()

    -- 总背景
    local bg  = UI.Image:create();
    bg:init("ui_hitrat_base.png")
    bg:center()
    local bgSizeW, bgSizeH = bg:getSize()
    -- bg:enableDebugDraw()
    self.contentLayer = bg
    self:addChild(bg, 1)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 255))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local titleBG  = UI.Image:create();
    titleBG:init("ui_hitrat_title.png")
    titleBG:centerUp(-126)
    self.contentLayer:addChild(titleBG)

    -- 标题
    local titleTxt1 = UI.Text:create()
	titleTxt1:init(UI.TEXT_1213330, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_BLACK)
    titleTxt1:leftUp(225, 31)
    titleBG:addChild(titleTxt1)

    local titleTxt = UI.Text:create()
	titleTxt:init(UI.TEXT_1213330, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_249_226_151)
    titleTxt:leftUp(224, 30)
    titleBG:addChild(titleTxt)

    -- 上面的线
    local line1 = cc.Scale9Sprite:createWithSpriteFrameName("ui_hitrat_line.png")
    line1:setContentSize(winSize.width, 4)
    line1:setAnchorPoint(0.5, 0.5)
    line1:setCapInsets(CCRectMake(winSize.width/2, 2, 1, 1))
    line1:setPosition(bgSizeW/2, bgSizeH+22)
    self.contentLayer:addChild(line1, 10)

    -- 下面的线
    local line2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_hitrat_line.png")
    line2:setContentSize(winSize.width, 4)
    line2:setAnchorPoint(0.5, 0.5)
    line2:setCapInsets(CCRectMake(winSize.width/2, 2, 1, 1))
    line2:setPosition(bgSizeW/2, -22)
    self.contentLayer:addChild(line2, 10)

    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(282, 366)
    leftLayout:leftUp(-190, 0)
    -- leftLayout:enableDebugDraw()
    self.contentLayer:addChild(leftLayout, 10)

    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:setSize(282, 366)
    rightLayout:rightUp(-145, 0)
    -- rightLayout:enableDebugDraw()
    self.contentLayer:addChild(rightLayout, 10)

    local winLayout = nil
    local loseLayout = nil
    if self._data.isWin then
        winLayout = leftLayout
        loseLayout = rightLayout
    else
        winLayout = rightLayout
        loseLayout = leftLayout
    end

    -- 小背景
    local effBG1  = UI.Image:create();
    effBG1:init("ui_festival_hitrat_win_bg.png")
    effBG1:leftUp(33, 42)
    winLayout:addChild(effBG1, 10)

    -- 左侧人物
    local leftRoleAnimation = UI.RoleAnimation:create(false)
    leftRoleAnimation:init(RoleDataManager:getMaster())
    if self._data.isWin then
        leftRoleAnimation:setScaleX(-1 * leftRoleAnimation:getScaleX())
        leftRoleAnimation:centerUp(20)
    else
        leftRoleAnimation:setScaleX(-0.8 * leftRoleAnimation:getScaleX())
        leftRoleAnimation:setScaleY(0.8 * leftRoleAnimation:getScaleY())
        leftRoleAnimation:centerUp(4)
    end
    leftRoleAnimation:showBlink(true)
    performWithDelay(self, function()
        leftRoleAnimation:showHelmet(true)

        if self._data.isWin then
            leftRoleAnimation:getRoleRender():getHeroAnimation():setAnimation(0, "jiandun_shenshengguanghui", true)
        else
            leftRoleAnimation:getRoleRender():getHeroAnimation():setAnimation(0, "idle_fun_4", true)
        end
    end, 0)

    local leftCkipperSprite = nil
    if self._data.isWin then
        leftCkipperSprite = cc.Sprite:createWithSpriteFrameName( "ui_festival_hitrat_win_bg.png")
    else
        leftCkipperSprite = cc.Sprite:createWithSpriteFrameName( "ui_festival_hitrat_lose_bg.png")
    end
    local leftClipper = cc.ClippingNode:create(leftCkipperSprite)
    if self._data.isWin then
        leftClipper:setPosition(148, 208)
    else
        leftClipper:setPosition(140, 194)
    end
    leftClipper:setAlphaThreshold(0.05)
    leftClipper:addChild(leftRoleAnimation, 20)
    leftLayout:addChild(leftClipper, 11)

    -- 胜利特效
    local leftAnimation = UI.Animation:create()
    leftAnimation:init("effect_ui_gaming_hitrat_settlement.json", "effect_ui_gaming_hitrat_settlement.atlas", 1)
    leftAnimation:leftUp(154, 186)
    leftAnimation:setAnimation("begin", false)
    leftAnimation:addAnimation("idle", true)
    winLayout:addChild(leftAnimation, 12)

    local decorate1  = UI.Image:create();
    decorate1:init("ui_hitrat_left.png")
    decorate1:centerBottom(0)
    leftLayout:addChild(decorate1, 10)

    local playerLayout1 = UI.Layout:create()
    playerLayout1:init()
    playerLayout1:setSize(150, 40)
    playerLayout1:leftUp(20,13)
    decorate1:addChild(playerLayout1)

    local playerName1 = UI.Text:create()
    playerName1:init(RoleDataManager:getMaster():getNickName(), UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_196_196)
    playerName1:center()
    playerLayout1:addChild(playerName1)
    if playerName1:getContentSize().width > 150 then
        playerName1:setFontSize(UI.FONT_SIZE_16PX)
    end
    self.myName = playerName1

    local playerScoreLayout1 = UI.Layout:create()
    playerScoreLayout1:init()
    playerScoreLayout1:setSize(150, 30)
    playerScoreLayout1:leftBottom(20,13)
    decorate1:addChild(playerScoreLayout1)

    local playerScore1 = UI.Text:create()
    playerScore1:init(UI.TEXT_1213334, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_251_235_218)
    playerScore1:floatRight(70)
    playerScoreLayout1:addComponent(playerScore1)

    local playerScoreNum1 = UI.Text:create()
    playerScoreNum1:init(tostring(self._data.myScore), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_209_171_68)
    playerScoreNum1:floatLeft(82)
    playerScoreLayout1:addComponent(playerScoreNum1)
    self.myselfScore = playerScoreNum1


    -- 小背景
    local effBG2  = UI.Image:create();
    effBG2:init("ui_festival_hitrat_lose_bg.png")
    effBG2:leftUp(50, 80)
    loseLayout:addChild(effBG2, 10)

    local rightRoleAnimation = UI.RoleAnimation:create(false)
    rightRoleAnimation:init(self._data.enemyData.heroData)
    rightRoleAnimation:updateView()

    local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE

    local weaponEquipmentData = nil
    for i = 1, #self._data.enemyData.wearEquipmentArr do
        local equipmentData = self._data.enemyData.wearEquipmentArr[i]
        local equipmentType = equipmentData:getEquipmentType()
        if (equipmentType == EQUIPMENT_TYPE.Weapon) then
            weaponEquipmentData = equipmentData
        end
    end

    rightRoleAnimation:updateRoleEquipment(self._data.enemyData.wearEquipmentArr)
    rightRoleAnimation:showIDLEAnimation(weaponEquipmentData)

    if self._data.isWin then
        rightRoleAnimation:setScaleX(0.8 * rightRoleAnimation:getScaleX())
        rightRoleAnimation:setScaleY(0.8 * rightRoleAnimation:getScaleY())
        rightRoleAnimation:centerUp(4)
    else
        rightRoleAnimation:setScaleX(1 * rightRoleAnimation:getScaleX())
        rightRoleAnimation:centerUp(20)
    end
    rightRoleAnimation:showBlink(true)
    performWithDelay(self, function()
        rightRoleAnimation:showHelmet(true)

        if self._data.isWin then
            rightRoleAnimation:getRoleRender():getHeroAnimation():setAnimation(0, "idle_fun_4", true)
        else
            rightRoleAnimation:getRoleRender():getHeroAnimation():setAnimation(0, "jiandun_shenshengguanghui", true)
        end
    end, 0)

    local rightCkipperSprite = nil
    if self._data.isWin then
        rightCkipperSprite = cc.Sprite:createWithSpriteFrameName( "ui_festival_hitrat_lose_bg.png")
    else
        rightCkipperSprite = cc.Sprite:createWithSpriteFrameName( "ui_festival_hitrat_win_bg.png")
    end
    local rightClipper = cc.ClippingNode:create(rightCkipperSprite)
    if self._data.isWin then
        rightClipper:setPosition(142, 196)
    else
        rightClipper:setPosition(150, 208)
    end
    rightClipper:setAlphaThreshold(0.05)
    rightClipper:addChild(rightRoleAnimation, 20)
    rightLayout:addChild(rightClipper, 11)

    local rightAnimation = UI.Animation:create()
    rightAnimation:init("effect_ui_gaming_hitrat_settlement_losename.json", "effect_ui_gaming_hitrat_settlement_losename.atlas", 1)
    rightAnimation:centerUp(176)
    rightAnimation:setAnimation("begin", false)
    rightAnimation:addAnimation("idle", true)
    loseLayout:addChild(rightAnimation, 12)

    local decorate2  = UI.Image:create();
    decorate2:init("ui_hitrat_right.png")
    decorate2:centerBottom(12)
    rightLayout:addChild(decorate2, 10)

    local playerLayout2 = UI.Layout:create()
    playerLayout2:init()
    playerLayout2:setSize(150, 40)
    playerLayout2:leftUp(16,16)
    decorate2:addChild(playerLayout2)

    local playerName2 = UI.Text:create()
    playerName2:init(self._data.enemyName, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_214_251_255)
    playerName2:center()
    playerLayout2:addChild(playerName2)
    if playerName2:getContentSize().width > 150 then
        playerName2:setFontSize(UI.FONT_SIZE_16PX)
    end
    self.enemyName = playerName2

    local playerScoreLayout2 = UI.Layout:create()
    playerScoreLayout2:init()
    playerScoreLayout2:setSize(150, 30)
    playerScoreLayout2:leftBottom(20, 6)
    decorate2:addChild(playerScoreLayout2)

    local playerScore2 = UI.Text:create()
    playerScore2:init(UI.TEXT_1213334, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_251_235_218)
    playerScore2:floatRight(70)
    playerScoreLayout2:addComponent(playerScore2)

    local playerScoreNum2 = UI.Text:create()
    playerScoreNum2:init(tostring(self._data.enemyScore), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_209_171_68)
    playerScoreNum2:floatLeft(82)
    playerScoreLayout2:addComponent(playerScoreNum2)
    self.enemyScore = playerScoreNum2

    -- 奖励
    local rewardLayout = UI.Layout:create()
    rewardLayout:init()
    rewardLayout:setSize(410, 80)
    rewardLayout:leftBottom(-280, -120)
    -- rewardLayout:enableDebugDraw()
    self.contentLayer:addChild(rewardLayout, 10)

    local rewardMaxTime = ConfigManager:getGeneralForKey("hitratRewardTime")
    local getRewardText = UI.Text:create()
    if self._data.isWin then
        if rewardMaxTime-self._data.rewardCount <= 0 then
            getRewardText:init(UI.TEXT_1213335, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_RED)
        else
            getRewardText:init(UI.TEXT_1213336, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_181_171_171)
        end
    else
        getRewardText:init(UI.TEXT_1213337, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_181_171_171)
    end
    getRewardText:leftUp(4, 12)
    rewardLayout:addChild(getRewardText)

    local getRewardPrgText = UI.Text:create()
    getRewardPrgText:init(string.format(UI.TEXT_1213338, rewardMaxTime-self._data.rewardCount, rewardMaxTime), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_181_171_171)
    getRewardPrgText:leftBottom(4, 12)
    rewardLayout:addChild(getRewardPrgText)

    if self._data.isWin and (rewardMaxTime-self._data.rewardCount > 0) then
        local str = ConfigManager:getGeneralForKey("hitratReward")
        local rewards = str:split(";")
        local rewardsList = {}
        local offset = {170, 250, 330}
        for k, v in ipairs(rewards) do
            local reward = {}
            local cfg = v:split(",")
            local goodData = GoodsDataManager:createLocalGoodsData(tonumber(cfg[1]))
            if goodData then
                goodData:setNum(tonumber(cfg[2]))
                goodData:setIsNew(false)
                goodData.isHaveGet = false

                local rewardGrid = UI.GoodsGrid:create()
                rewardGrid:init(goodData)
                rewardGrid:leftUp(offset[k], 6)
                rewardGrid:hideNewIcon()
                rewardGrid:setTouchEnable(true)
                rewardGrid:setSwallowTouches(false)
                rewardGrid:setTouchClipNode(rewardLayout)
                rewardGrid:showInfoArea(true, false)

                rewardLayout:addChild(rewardGrid)
            end
        end
    end

    local cdLayout = UI.Layout:create()
    cdLayout:init()
    cdLayout:setSize(200, 30)
    cdLayout:rightBottom(-110, -62)
    -- cdLayout:enableDebugDraw()
    self.contentLayer:addChild(cdLayout, 10)

    local countDown = UI.Text:create()
    countDown:init(string.format(UI.TEXT_1213339, self.refreshRoomInterval), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_198_48_58)
    countDown:center()
    cdLayout:addChild(countDown)
    self.countDown = countDown

    local closeBtn = UI.Button:create();
    closeBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png");
    closeBtn:rightBottom(-110, -110);
    closeBtn:setText(UI.TEXT_1213006)
    closeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        SceneManager:getInstance():leaveWaiting()
    end)
    self.contentLayer:addChild(closeBtn)
end

function HitRatResultView:update(dt)
    -- 刷新更换房间倒计时显示
    if self.refreshRoomInterval ~= nil then
        if self.refreshRoomInterval > 0 then
            if math.modf(self.refreshRoomInterval - dt) == math.modf(self.refreshRoomInterval)-1 then
                self.countDown:setText(string.format(UI.TEXT_1213339, math.modf(self.refreshRoomInterval)-1))
            end
            self.refreshRoomInterval = self.refreshRoomInterval - dt
        else
            self.refreshRoomInterval = 0
            SceneManager:getInstance():leaveWaiting()
        end
    end
end

function HitRatResultView:bindModel()

end

function HitRatResultView:unbindModel()

end

return HitRatResultView
