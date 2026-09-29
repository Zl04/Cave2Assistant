-- FestivalSignCell.lua
-- Author:lzm
-- 2019年8月19日
-- Using:七日计划cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local FestivalSignCell = class("FestivalSignCell", UI.ListGrid)
UI.FestivalSignCell = FestivalSignCell

local COM_WIDTH = 196
local COM_HEIGHT = 420


--构造函数(必备)
function FestivalSignCell:ctor(signInType)
    self._signInType = signInType
    FestivalSignCell.super.ctor(self)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, self, self.targetPrgUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.refreshNewDay)
end

--虚构函数,destroy时调用(必备)
function FestivalSignCell:dtor()
    FestivalSignCell.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, self, self.targetPrgUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.refreshNewDay)
end

-- 初始化(必备)
function FestivalSignCell:init(data)
    self.isGetReward = false
    self._data = data
    self.signData = self._data.activityArr[1]
    FestivalSignCell.super.init(self)
    self.bgName = self._signInType == ANNIVERSARY_SIGN and "ui_welfare_paper_12.png" or "ui_welfare_paper_03.png"
    self.nextBg = self._signInType == ANNIVERSARY_SIGN and "ui_welfare_paper_13.png" or "ui_welfare_paper_03.png"
    self.closeBg = self._signInType == ANNIVERSARY_SIGN and "ui_welfare_paper_11.png" or "ui_welfare_paper_04.png"
    self.getBtnNormal = self._signInType == ANNIVERSARY_SIGN and "ui_welfare_ticket_12.png" or "ui_welfare_ticket_03.png"
    self.getBtnNext = self._signInType == ANNIVERSARY_SIGN and "ui_welfare_ticket_13.png" or "ui_welfare_ticket_03.png"
    -- self.getBtnClosed = self._signInType == ANNIVERSARY_SIGN and "ui_welfare_ticket_11.png" or "ui_welfare_ticket_03.png"
end

-- 模版函数：初始化组建的视图(必备)
function FestivalSignCell:onInitView()
end

function FestivalSignCell:getData()
    return self._data;
end

function FestivalSignCell:isClickShowInfo()
    return true
end

function FestivalSignCell:onUpdateView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    -- cellLayout:enableDebugDraw()
    cellLayout:setName("cellLayout")
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    local signID = self:getTodaySignID()
    -- 背景
    local bg = UI.Image:create()
    if self._data.ID == signID then
        bg:init(self.bgName)
    else
        bg:init(self.nextBg)
    end
    
    bg:centerUp(0)
    cellLayout:addChild(bg)
    self.bg = bg

    -- local goalData = mvc.festivalSignModel:getGoalData(self._signInType)
    local titleText = self._data.nameLocal or "Loading..."

    local dayText  = UI.Text:create()
    dayText:init(titleText, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    dayText:centerUp(4);
    bg:addChild(dayText)

    local bgLayout = UI.Layout:create()
    bgLayout:init()
    bgLayout:setSize(188, 152)
    bgLayout:centerUp(60)
    self.bgLayout = bgLayout
    cellLayout:addChild(bgLayout)

    -- local bg2 = UI.Image:create()
    -- bg2:init("ui_guild_giftbag_bg.png")
    -- bg2:setScale(0.6)
    -- bg2:center()
    -- bgLayout:addChild(bg2)

    local rewardID = self._data.stageReward.id
    -- local rewardNum = self._data.stageReward.num
    local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)

    local descText1  = UI.Text:create()
    descText1:init(goodsData:getName(), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    descText1:centerUp(210)
    descText1:setTextHorizontalCenter()
    descText1:autoAdapt()
    descText1:setSize(140, 70)
    bg:addChild(descText1)

    -- local descText2  = UI.Text:create()
    -- descText2:init(goodsData:getDescription(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    -- descText2:centerUp(236)
    -- descText2:setTextCenter()
    -- -- descText2:setSize(190, 60)
    -- descText2:setSize(170, 70)
    -- bg:addChild(descText2)

    -- local descText3  = UI.Text:create()
    -- descText3:init(UI.TEXT_1213112, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- descText3:centerBottom(30)
    -- bg:addChild(descText3)

    -- 物品物品图标
    -- local innerLayout = UI.Layout:create()
    -- innerLayout:init()
    -- innerLayout:setSize(60, 60)
    -- innerLayout:centerUp(40)
    -- bgLayout:addChild(innerLayout)

    -- goodsData:setNum(rewardNum)
    -- goodsData:setIsNew(false)
    -- goodsData.isHaveGet = false

    -- local goodsGrid = UI.GoodsGrid:create()
    -- -- goodsGrid:setScale(0.8)
    -- goodsGrid:center()
    -- goodsGrid:init(goodsData)
    -- goodsGrid:showInfoArea(false, false)
    -- goodsGrid:setBG("box_quality_box_03.png")
    -- if (rewardNum == 0) then
    --     goodsGrid:hideCountLabel()
    -- end
    -- innerLayout:addChild(goodsGrid)

    local touchLayout = UI.Layout:create()
    touchLayout:init()
    touchLayout:setSize(155, 108)
    touchLayout:centerBottom(-4)
    self.cellLayout:addChild(touchLayout, 102)
    -- touchLayout:enableDebugDraw()
    touchLayout:setTouchEnable(true)

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
 
     local signData = mvc.festivalSignModel:getGoalData(self._signInType)
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
     end
end


function FestivalSignCell:showCanGetReward(canResign)
    local signID = self:getTodaySignID()
    --签到按钮
    local getBtn = UI.Image:create()
    if self._data.ID == signID then
        getBtn:init(self.getBtnNormal)
    else
        getBtn:init(self.getBtnNext)
    end
    getBtn:centerBottom(-4)
    self.getBtn = getBtn
    self.cellLayout:addChild(getBtn)

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
    goodsGrid:center()
    -- print("rewardID=", rewardID)
    local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)
    goodsData:setNum(rewardNum)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsGrid:init(goodsData)
    goodsGrid:setBG("box_quality_box_03.png")
    goodsGrid:showInfoArea(false, false)
    if (rewardNum == 0) then
        goodsGrid:hideCountLabel()
    end
    innerLayout:addChild(goodsGrid)

    -- 签到特效
    -- local btnEff = UI.Animation:create()
    -- btnEff:init("effect_ui_town_sevendays_buttom.json", "effect_ui_town_sevendays_buttom.atlas", 1);
    -- btnEff:centerBottom(46)
    -- self.cellLayout:addChild(btnEff, 100)
    self._canResign = canResign
    if(canResign) then
        self.btnText:setText(UI.TEXT_1213095)
        -- self.getBtn:setSpriteName("ui_welfare_ticket_02.png")
        -- btnEff:setAnimation("idle_sign01", true)
    else
        -- btnEff:setAnimation("idle_sign02", true)
        self.btnText:setText(UI.TEXT_1213096)
    end
    -- self.btnEff = btnEff
end

function FestivalSignCell:showHaveGotReward()
    -- 已领奖
    -- self.bg:setSpriteName("ui_sevendays_paper_plan_1.png")
    self.bg:setSpriteName(self.closeBg)

    local innerLayout = UI.Layout:create()
    innerLayout:init()
    innerLayout:setSize(60, 60)
    innerLayout:center()
    innerLayout:setName("innerLayout")
    self.bgLayout:addChild(innerLayout)

    local edibledImage = UI.Image:create()
    edibledImage:init("ui_catfood_seal.png")
    -- edibledImage:init("ui_information_banner_receive.png")
    edibledImage:center()
    innerLayout:addChild(edibledImage)

    local edibled  = UI.Text:create()
    -- edibled:init(UI.TEXT_1110721, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
    edibled:init(UI.TEXT_1110721, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
    edibled:setAnchorPoint(0.5, 0.5)
    edibled:rotate(15)
    edibled:centerUp(38)
    -- edibled:center()
    edibledImage:addChild(edibled, -1)

    
end

function FestivalSignCell:getTodaySignID()
    local signData = mvc.festivalSignModel:getGoalData(self._signInType)
    for k, v in ipairs(signData.stageArr) do
        if(v.activityArr[1].stat and v.activityArr[1].stat <= 1) then 
            return v.ID
        end
    end

    return 0
end

function FestivalSignCell:refreshNewDay()
    local signData = mvc.festivalSignModel:getGoalData(self._signInType)
    self.signData = signData.stageArr[self._data.ID].activityArr[1]
    if not self.isGetReward then
        self:removeChildByName("cellLayout")
        self:onUpdateView() 
        return
    end
end

function FestivalSignCell:getReward()
    -- 检查是否能够领取奖励
    if (not mvc.festivalSignModel:isAbleToGetReward()) then
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

function FestivalSignCell:getRewardResp(data)
    local signData = mvc.festivalSignModel:getGoalData(self._signInType)
    
    self.signData = signData.stageArr[self._data.ID].activityArr[1]
    -- print("getRewardResp", self.isGetReward)
    if not self.isGetReward then
        self:removeChildByName("cellLayout")
        self:onUpdateView()
        return
    end
    if self.signData.goalID == data.targetID and self.signData.stageID == data.stage and self.isGetReward then
        self.isGetReward = false
        self.signData.stat = 3
        local ProtobufUtil = require("utils.ProtobufUtil")
        -- if ProtobufUtil:checkFieldIsInit(data, "lastSignInGameDay") then
        --     signData.lastSignInGameDay = data.lastSignInGameDay
        -- end
        if(self.getBtn) then
            self.getBtn:hide()
            -- self.btnEff:setAnimation("trigger_sign01", false)
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

-- function FestivalSignCell:targetPrgUpdate(data)
--     for k, v in ipairs(data) do
--         if v.targetID == self.signData.goalID and v.stage == self.signData.stageID and v.sudId == self.signData.ID then
--             local signData = mvc.festivalSignModel:getGoalData(self._signInType)
--             self.signData = signData.stageArr[self._data.ID].activityArr[1]
--             self:removeChildByName("cellLayout")
--             self:onUpdateView()
--             break
--         end
--     end
-- end