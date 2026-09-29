-- SevenDaysSignCell.lua
-- Author:lzm
-- 2019年8月19日
-- Using:七日签到cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local SevenDaysSignCell = class("SevenDaysSignCell", UI.ListGrid)
UI.SevenDaysSignCell = SevenDaysSignCell

local COM_WIDTH = 136
local COM_HEIGHT = 212

--构造函数(必备)
function SevenDaysSignCell:ctor(signInType)
    self._signInType = signInType
    SevenDaysSignCell.super.ctor(self, {}, COM_WIDTH, COM_HEIGHT)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, self, self.targetPrgUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.refreshNewDay)
end

--虚构函数,destroy时调用(必备)
function SevenDaysSignCell:dtor()
    SevenDaysSignCell.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, self, self.targetPrgUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.refreshNewDay)
end

-- 初始化(必备)
function SevenDaysSignCell:init(data)
    self.isGetReward = false
    self._data = data
    self.signData = self._data.activityArr[1]
    SevenDaysSignCell.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function SevenDaysSignCell:onInitView()
end

function SevenDaysSignCell:getData()
    return self._data;
end

function SevenDaysSignCell:onUpdateView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    cellLayout:setName("cellLayout")
    self:addChild(cellLayout)
    self.cellLayout = cellLayout

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_sevendays_paper_sign.png")
    bg:centerUp(0)
    cellLayout:addChild(bg)
    self.bg = bg

    -- 题头
    local dayText  = UI.Text:create()
    dayText:init(self._data.nameLocal, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    dayText:centerUp(4);
    bg:addChild(dayText)

    local bgLayout = UI.Layout:create()
    bgLayout:init()
    bgLayout:setSize(130, 123)
    bgLayout:centerUp(40)
    cellLayout:addChild(bgLayout)

    local bg2 = UI.Image:create()
    bg2:init("ui_sevendays_bg_paper_up.png")
    bg2:center()
    bg2:setImageScale(0.7)
    bgLayout:addChild(bg2)
    self.bgLayout = bgLayout

    local touchLayout = UI.Layout:create()
    touchLayout:init()
    touchLayout:setSize(132, 41)
    touchLayout:centerBottom(8)
    self.cellLayout:addChild(touchLayout, 102)
    -- touchLayout:enableDebugDraw()
    touchLayout:setTouchEnable(true)
    if GameManager:getIsGooglePlay() then
        touchLayout:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, touchLayout, function()
            self:hightLight()
            Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                if(not tolua.isnull(self)) then
                    self:unHightLight()
                end
            end, 1)
        end)

        touchLayout:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, touchLayout, function(self_, button, touchPosition)
            if not touchLayout:checkTouchPosition(touchPosition) then 
                self:unHightLight()
            end
        end)

        touchLayout:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, touchLayout, function()
            self:unHightLight()
        end)
    end

    touchLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.isGetReward then
            return
        end

        self:getReward()
    end)

    -- 按钮上的字
    local btnText = UI.Text:create()
    btnText:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    btnText:center()
    self.btnText = btnText
    touchLayout:addChild(self.btnText, 103)

    local signData = mvc.sevenDaysModel:getGoalData(self._signInType)
    local curStage = signData.curStage
    local signGameDay = signData.lastSignInGameDay
    local master = RoleDataManager:getMaster()
    local nowDay = master:getRefreshDay()
    local wenSign = false
    local totalSignID = 0
    if(signGameDay ~= nowDay) then 
        wenSign = true
        totalSignID = self:getTodaySignID()
    end

    local state = self.signData.stat
    -- print("wwwwwwwww", self._data.ID, signGameDay, nowDay, state, totalSignID)
    if (state == 0) then
        -- 未开启
        touchLayout:setTouchEnable(false)
        -- 不会有这个状态
    elseif (state == 1) then
        -- -- 进行中
        if(self._data.ID == totalSignID) then 
            touchLayout:setTouchEnable(true)
            self:showCanGetReward(true)
        else
            touchLayout:setTouchEnable(false)
            self:showCanGetReward(false)
        end
    elseif (state == 2) then
        if self._data.stageRewardState then
            touchLayout:setTouchEnable(false)
            self:showHaveGotReward()
        else
            self:showCanGetReward(true)
        end
    elseif (state == 3) then
        touchLayout:setTouchEnable(false)
        self:showHaveGotReward()
    elseif (state == 4) then
        -- 已过期
        -- 配置上已杜绝此状态，此处不处理
    end
end

function SevenDaysSignCell:getTodaySignID()
    local signData = mvc.sevenDaysModel:getGoalData(self._signInType)
    for k, v in ipairs(signData.stageArr) do
        if(v.activityArr[1].stat and v.activityArr[1].stat <= 1) then 
            return v.ID
        end
    end

    return 0
end

function SevenDaysSignCell:updateDataShow()
    
end

function SevenDaysSignCell:hightLight()
    if(self.btnEff) then
        self.btnEff:setAnimation("idle_sign03", true)
    end
end

function SevenDaysSignCell:unHightLight()
    local canResign = self._canResign
    if(canResign) then
        self.btnText:setText(UI.TEXT_1213095)
        self.btnEff:setAnimation("idle_sign01", true)
    else
        self.btnEff:setAnimation("idle_sign02", true)
        self.btnText:setText(UI.TEXT_1213096)
    end
end

function SevenDaysSignCell:showCanGetReward(canResign)
    -- 奖励物品
    local innerLayout = UI.Layout:create()
    innerLayout:init()
    innerLayout:setSize(60, 60)
    innerLayout:center()
    innerLayout:setName("innerLayout")
    self.bgLayout:addChild(innerLayout)

    local rewardID = self._data.stageReward.id
    local rewardNum = self._data.stageReward.num
    local goodsGrid = UI.GoodsGrid:create()
    -- goodsGrid:setScale(0.8)
    goodsGrid:center()
    -- print("rewardID=", rewardID)
    local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)
    goodsData:setNum(rewardNum)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    if (num == 0) then
        goodsGrid:hideCountLabel()
    end
    innerLayout:addChild(goodsGrid)

    -- 签到特效
    local btnEff = UI.Animation:create()
    btnEff:init("effect_ui_town_sevendays_buttom.json", "effect_ui_town_sevendays_buttom.atlas", 1);
    btnEff:centerBottom(46)
    self.cellLayout:addChild(btnEff, 100)
    self._canResign = canResign
    if(canResign) then
        self.btnText:setText(UI.TEXT_1213095)
        btnEff:setAnimation("idle_sign01", true)
    else
        btnEff:setAnimation("idle_sign02", true)
        self.btnText:setText(UI.TEXT_1213096)
    end
    self.btnEff = btnEff
end

function SevenDaysSignCell:showHaveGotReward()
    -- 已领奖
    -- self.bg:setSpriteName("ui_sevendays_paper_plan_1.png")

    local innerLayout = UI.Layout:create()
    innerLayout:init()
    innerLayout:setSize(60, 60)
    innerLayout:center()
    innerLayout:setName("innerLayout")
    self.bgLayout:addChild(innerLayout)

    local edibledImage = UI.Image:create()
    edibledImage:init("ui_catfood_seal.png")
    edibledImage:center()
    innerLayout:addChild(edibledImage)

    local edibled  = UI.Text:create()
    edibled:init(UI.TEXT_1110721, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
    edibled:setAnchorPoint(0.5, 0.5)
    edibled:rotate(15)
    edibled:centerUp(38)
    edibledImage:addChild(edibled, -1)
end

function SevenDaysSignCell:getReward()
    -- 检查是否能够领取奖励
    if (not mvc.sevenDaysModel:isAbleToGetReward()) then
        UI.ScrollBar:createByTextID(1111316)
        return
    end

    -- 检查背包格数
    local goodsArr = {}
    local data = {}
    data.goodsID = self._data.stageReward.id
    data.num = self._data.stageReward.num
    data.isGolden = true
    table.insert(goodsArr, data)

    -- 背包检查合格, 请求获取奖励; 不合格, 提示
    if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)) then
        self.isGetReward = true
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetRoleSystem:requestSignIn(self.signData.goalID, self.signData.stageID, 0)
    else
        UI.ScrollBar:createByTextID(1170081)
    end
end

function SevenDaysSignCell:refreshNewDay()
    local signData = mvc.sevenDaysModel:getGoalData(self._signInType)
    self.signData = signData.stageArr[self._data.ID].activityArr[1]
    if not self.isGetReward then
        self:removeChildByName("cellLayout")
        self:onUpdateView() 
        return
    end
end

function SevenDaysSignCell:getRewardResp(data)
    local signData = mvc.sevenDaysModel:getGoalData(self._signInType)
    self.signData = signData.stageArr[self._data.ID].activityArr[1]
    if not self.isGetReward then
        self:removeChildByName("cellLayout")
        self:onUpdateView() 
        return
    end

    if self.signData.goalID == data.targetID and self.signData.stageID == data.stage and self.isGetReward then
        self.isGetReward = false
        if(self.btnEff) then 
            self.btnEff:setAnimation("trigger_sign01", false)
        end
        if(self.btnText) then
            self.btnText:hide()
        end
        if(self.bgLayout) then 
            self.bgLayout:removeChildByName("innerLayout")
        end

        self:showHaveGotReward()
    else
        self:removeChildByName("cellLayout")
        self:onUpdateView() 
    end
end

function SevenDaysSignCell:targetPrgUpdate(data)
    for k, v in ipairs(data) do
        if v.targetID == self.signData.goalID and v.stage == self.signData.stageID and v.sudId == self.signData.ID then
            local signData = mvc.sevenDaysModel:getGoalData(self._signInType)
            self.signData = signData.stageArr[self._data.ID].activityArr[1]
            self:removeChildByName("cellLayout")
            self:onUpdateView()
            break
        end
    end
end
