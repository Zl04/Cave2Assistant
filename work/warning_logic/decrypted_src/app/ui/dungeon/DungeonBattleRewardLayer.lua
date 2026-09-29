-- DungeonBattleRewardLayer.lua
-- Author:ydli
-- 2017年09月06日
-- Using:大秘境 战斗结束 奖励界面

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local DungeonBattleRewardLayer = class("DungeonBattleRewardLayer", UI.HWBtnComponent)
UI.DungeonBattleRewardLayer = DungeonBattleRewardLayer
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local FightResultUtil = require("app.ui.cave.fightResult.FightResultUtil")
local SHARE_MODULE = PublicDefine.SHARE_MODULE
local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_dungeon.plist",
    "ui_general_uishare.plist",
    "ui_town_ranking.plist",
    "ui_gaming_settlement.plist",
}

local cellHeight = 110
local CELL_NUMBER = 5

--构造函数(必备)
function DungeonBattleRewardLayer:ctor(closeCallBack, rewardType)
    --窗口大小
    DungeonBattleRewardLayer.super.ctor(
        self, UIType.DUNGEON_BATTLE_REWARD_LAYER,
        COM_RES_LIST,
        winSize.width,    
        winSize.height
    )
    self._rewardType = rewardType

    self.rootLayer = nil         --root节点
    self._closeCallBack = closeCallBack
    self.isUsingMail = false
    self.allGridNode = {}
    self:init()
    self:setTouchEnable(true);
    self:registerListener()
end

--虚构函数,destroy时调用(必备)
function DungeonBattleRewardLayer:dtor()
    DungeonBattleRewardLayer.super.dtor(self)
    self:unRegisterListener()
    self.allGridNode = {}
    Avalon.Scheduler:unscheduleUpdate(self, self.skip)
end

-- 初始化(必备)
function DungeonBattleRewardLayer:init()
    if(self._rewardType == UI.RewardType.REWARD_NORMAL 
        or self._rewardType == UI.RewardType.REWARD_GUILD_BOSS) then
        FightResultUtil:getInstance():initData();
    end
    DungeonBattleRewardLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function DungeonBattleRewardLayer:onInitView()
    -- 背景灰色层
    self.bgLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 200))
    self.bgLayer:setContentSize(winSize.width, winSize.height)
    self.bgLayer:setPosition(cc.p(0,0))
    self:addChild(self.bgLayer)

    -- 宿主层
    self.rootLayer = UI.Component:create()
    self.rootLayer:init()
    self.rootLayer:setSize(1136, 640)
    self.rootLayer:center()
    self:addChild(self.rootLayer)

    local settlementBgAnimation = UI.Animation:create()
    settlementBgAnimation:init("effect_ui_common_settlement.json", "effect_ui_common_settlement.atlas")
    settlementBgAnimation:leftBottom(568, 509)
    self.rootLayer:addChild(settlementBgAnimation)

    -- 标题动画
    self.banner = UI.Animation:create()
    self.banner:init("effect_ui_town_dungeon_reward.json", "effect_ui_town_dungeon_reward.atlas")
    self.banner:center()
    self.rootLayer:addChild(self.banner)

    -- 标题文字
    local titleStr = self:getTitleName()
    local logoName = UI.Text:create()
    logoName:init(titleStr, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_255_224_115)
    logoName:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -3))
    logoName:centerBottom(-11)
    self.banner:addChild(logoName)

    -- 烟花动画, 上层
    self.fireworksUp = UI.Animation:create()
    self.fireworksUp:init("effect_ui_town_dungeon_settlement.json", "effect_ui_town_dungeon_settlement.atlas")
    self.fireworksUp:center()
    self.rootLayer:addChild(self.fireworksUp, 100)

    -- 播放动画完成后向服务器请求获取奖励
    self:playBannerAnimation(nil, function() 
        settlementBgAnimation:setAnimation("begin", false)
        settlementBgAnimation:addAnimation("idle", true)

        if(self._rewardType == UI.RewardType.REWARD_DUNGEON) then
            -- 判断背包是否满了
            local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr({})
            if not enough then
                UI.UIManager.mTipsLayer:onBagIsFull()
                return
            end

            -- 接收奖励
            -- GameManager:recieveDungeonBatlleRewardRequest()
            local rewardData = FightResultUtil:getInstance():getDungeonBattleReward()
            if(rewardData) then
                self:openRequestCallback(rewardData)
            end
            FightResultUtil:getInstance():clearDungeonBattleReward()
        elseif(self._rewardType == UI.RewardType.REWARD_NORMAL) then
            local goldData = {}
            goldData.number = FightResultUtil:getInstance().mGold

            -- 
            if(goldData.number == nil) then 
                goldData.number = 0
            end

            local inscriptionData = {}
            inscriptionData.number = FightResultUtil:getInstance().mInscription

            -- 
            if(inscriptionData.number == nil) then 
                inscriptionData.number = 0
            end

            -- dump(FightResultUtil:getInstance().mData, "wwwwwwww")
            local rankData = GameDataManager:getInstance():getActivityRankData()
            if(rankData) then 
                -- rankData.rank = 45
                self:showRewardDetail(rankData.goodsArr, nil, goldData, rankData.rank, true, nil, inscriptionData)
                GameDataManager:getInstance():clearActivityRankData()
            else 
                self:showRewardDetail(FightResultUtil:getInstance().mData, nil, goldData, 0, false, FightResultUtil:getInstance().mSellDataArr, inscriptionData)
            end
        elseif(self._rewardType == UI.RewardType.REWARD_GUILD_BOSS) then
            local goldData = {}
            goldData.number = 0

            self:showRewardDetail(GameDataManager:getInstance():getGuildBossRewardData(), nil, goldData, 0, false, nil)
            GameDataManager:getInstance():clearGuildBossRewardData()
        elseif(self._rewardType == UI.RewardType.REWARD_DEEPLINK) then
            local rewardArr, goldNum = self:getDeepLinkReward()
            local goldData = {}
            goldData.number = goldNum
            self:showRewardDetail(rewardArr, nil, goldData, 0, false, nil)
        elseif(self._rewardType == UI.RewardType.REWARD_SWEEP) then
            local rewardArr, isToMail = self:getSweepReward() 
            if(isToMail) then 
                self.isUsingMail = isToMail
            end
            self:showRewardDetail(rewardArr, nil, nil, 0, false, nil)
        elseif(self._rewardType == UI.RewardType.REWARD_GHOSTABYSS) then
            local rewardArr, isToMail = self:getGhostAbyssData() 
            if(isToMail) then 
                self.isUsingMail = isToMail
            end
            self:showRewardDetail(rewardArr, nil, nil, 0, false, nil)
        else 

        end
    end)
end

-- 模版函数：更新组建的视图(必备)
function DungeonBattleRewardLayer:onUpdateView()

end

-- 运行标题的打开动画, moveDoneCallback 为移动到顶部完成后的回调, 让衔接的动画更顺畅; animationDoneCallback 为所有动画完成
function DungeonBattleRewardLayer:playBannerAnimation(moveDoneCallback, animationDoneCallback)
    self.banner:setAnimation("begin", false)
    self.banner:addAnimation("idle", true)

    -- 同时播放位移和缩放动画
    performWithDelay(self, function()
        -- 动画参数
        local totalDuration = 0.7
        local moveTimeFactor = 1 / 3
        local bounceTimeFactor = 1 - moveTimeFactor
        local easeCurvePower = 1.5

        -- 组装移动动作
        local moveToAction = cc.MoveTo:create(totalDuration * moveTimeFactor, cc.p(568, 509))
        local easeMoveToAction = cc.EaseInOut:create(moveToAction, easeCurvePower)

        -- 组装缩放动作
        local scaleInAction = cc.ScaleTo:create(totalDuration * moveTimeFactor, 3)
        local easeScaleInAction = cc.EaseIn:create(scaleInAction, easeCurvePower)
        local scaleOutAction = cc.ScaleTo:create(totalDuration * bounceTimeFactor, 1)
        local easeScaleOutAction = cc.EaseElasticOut:create(scaleOutAction)
        local sequenceScaleAction = cc.Sequence:create(easeScaleInAction, easeScaleOutAction)

        -- 组装移动完成回调
        local moveDoneCallbackAction = cc.CallFunc:create(function()
            if (moveDoneCallback) then moveDoneCallback() end
        end)
        local delayedMoveDoneCallbackAction = cc.Sequence:create(cc.DelayTime:create(totalDuration * moveTimeFactor), moveDoneCallbackAction)

        -- 组装动画完成回调
        local animationDoneCallbackAction = cc.CallFunc:create(function()
            if (animationDoneCallback) then animationDoneCallback() end
        end)
        local delayedanimationDoneCallbackAction = cc.Sequence:create(cc.DelayTime:create(totalDuration + 0.2), animationDoneCallbackAction)

        -- 运行动作
        self.banner:runAction(easeMoveToAction)
        self.banner:runAction(sequenceScaleAction)
        self.banner:runAction(delayedMoveDoneCallbackAction)
        self.banner:runAction(delayedanimationDoneCallbackAction)
    end, 0.2)

    performWithDelay(self, function()
        self.fireworksUp:setAnimation("begin_up", false)
        self.fireworksUp:addAnimation("idle_up", true)

        -- self.fireworksDown:setAnimation("idle_down", true)
        -- self.fireworksDown:setScale(0)
        -- self.fireworksDown:runAction(cc.EaseBackOut:create(cc.ScaleTo:create(0.3, 1)))
    end, 0.9)
end

-- 救人数跳动
function DungeonBattleRewardLayer:skip(dt)
    if(self._startNum and self._maxNum and self._maxNum > self._startNum and self._rescueText) then
        self._waitingTime = self._waitingTime + dt
        if(self._waitingTime > 0.1) then
            self._startNum = self._startNum + self._stepNum
            if(self._startNum > self._maxNum) then 
                self._startNum = self._maxNum
            end
            self._rescueText:setText(tostring(math.floor(self._startNum)))
            self._rescueText:runAction(cc.Sequence:create(cc.ScaleTo:create(0.05,1.6), cc.ScaleTo:create(0.05,1)))
            self._waitingTime = self._waitingTime - 0.1
        end
     end
end

-- 注册监听事件(可选)
function DungeonBattleRewardLayer:registerListener()
    --大秘境结算界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_DUNGEON_END_REWARD_SHOW, self, self.openRequestCallback)
end

-- 注销监听事件(可选)
function DungeonBattleRewardLayer:unRegisterListener()
    -- 大秘境结算界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_DUNGEON_END_REWARD_SHOW, self, self.openRequestCallback)
end

-- 请求获取奖励回调
function DungeonBattleRewardLayer:openRequestCallback(data)
    printInfo("DungeonBattleRewardLayer:openRequestCallback(")
    UI.WaitingLayer:hideWaiting()
    -- dump(data)
    -- if self.treasureSpine ~= nil then
    --     self.treasureSpine:clearTrack()
    --     self.treasureSpine:destroy()
    -- end
    -- if(data.result ~= "ReceiveDungeonRewardResult_Succeed") then
    --     self:handleClose()
    --     return
    -- end
    
    -- 添加测试数据
    -- local data = {}
    -- data.coin = 1000000
    -- data.dungeonKeyID = 22060010
    -- data.goodsID = {}
    -- for i=1,20 do
    --     local oneData = {}
    --     oneData.entityID = 0
    --     oneData.templateID = 21080150
    --     oneData.num = 1
    --     table.insert(data.goodsID, oneData)
    -- end
    -- data.rescuedSurvivorCount = 99

    
    local itemData = {}
    local keyData = {}
    local goldData = nil
    if data.coin ~= nil and data.coin ~= 0 then
        goldData = {}
        goldData.number = data.coin
    end

    -- 秘境钥匙
    if data.dungeonKeyID ~= nil and data.dungeonKeyID ~= 0 then
        local goodData = GoodsDataManager:createLocalGoodsData(data.dungeonKeyID)
        if(goodData) then
            goodData:setNum(1)
            -- goodData:setIsGolden(true)
            table.insert(keyData, goodData)
        end
    end

    -- 获得的物品
    if data.goodsID ~= nil and #data.goodsID ~= 0 then
        for k, v in pairs(data.goodsID) do
            local goodData = GoodsDataManager:getEquipmentForEntityID(v.entityID)
            if goodData ~= nil then
                table.insert(itemData, goodData)
            elseif v.templateID ~= 0 then
                local goodData = GoodsDataManager:createLocalGoodsData(v.templateID)
                if(goodData) then
                    goodData:setNum(v.num)
                    table.insert(itemData, goodData)
                end
            end
        end
    end
    -- add by zp 深渊2.0 
    -- 救出被困着个数
    local rescueNum = data.rescuedSurvivorCount
    self:showRewardDetail(itemData, keyData, goldData, rescueNum, false, nil)

    if data.isUsingMail ~= nil then
        self.isUsingMail = data.isUsingMail
    end
end

function DungeonBattleRewardLayer:showRewardDetail(itemData, keyData, goldData, rescueNum, isRank, autoSellArr, inscriptionData)
    self.itemData = itemData or {}
    self.keyData = keyData or {}
    self.goldData = goldData or {}
    self.rescueNum = rescueNum or 0
    self.inscriptionData = inscriptionData or {}
    -- print("self.itemData=", #self.itemData)
    if(isRank == nil) then 
        isRank = false
    end
    if(autoSellArr == nil) then 
        autoSellArr = {}
    end

    self.isRank = isRank
    local allGrid = {}
    local timeStep = 0.05
    local delayTime = 0.1
    local itemGridDelayTime = delayTime
    local buttonAreaDelayTime = delayTime

    if(isRank) then 
        local bottomOffset = 395
        local rank = self.rescueNum
        local titleText = UI.Text:create()
        titleText:init(LanguageManager:getInstance():getLocalString(1111570), UI.FONT_BOLD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_207_182_89)
        titleText:rightBottom(585, bottomOffset - titleText:getContentSize().height/2) -- 注意这里是右下基点, 为了多语言长度适配
        self.rootLayer:addChild(titleText)
        titleText:setOpacity(0)
        table.insert(allGrid, {node=titleText, time = delayTime})
        delayTime = delayTime + timeStep

        if(rank >0 and rank < 4) then 
            local spriteName = "ui_rankinglist_gold.png"
            if(rank == 1) then 
                spriteName = "ui_rankinglist_gold.png"
            elseif (rank == 2) then 
                spriteName = "ui_rankinglist_silver.png"
            elseif (rank == 3) then 
                spriteName = "ui_rankinglist_copper.png"
            end

            -- 排行图标
            local rescueImage = UI.Image:create()
            rescueImage:init(spriteName)
            rescueImage:leftBottom(560, bottomOffset - rescueImage:getContentSize().height/2)
            self.rootLayer:addChild(rescueImage)
            rescueImage:setOpacity(0)
            table.insert(allGrid, {node=rescueImage, time = delayTime})
            delayTime = delayTime + timeStep
        else 
            -- 排行图标
            local str = string.format("%s", rank)
            local rankText = nil
            if(rank == 0) then 
                str = LanguageManager:getInstance():getLocalString(1110620)

                rankText = UI.Text:create()
                rankText:init(str, UI.FONT_BOLD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_207_182_89)
                rankText:center() -- 注意这里是右下基点, 为了多语言长度适配
                rankText:setOpacity(0)
            else 
                rankText = cc.LabelAtlas:create(str, "ui_home_unmber.png", 17, 23, 48)
                rankText:setAnchorPoint(cc.p(0.5, 0.5))
                rankText:setOpacity(0)
            end

            local rankLayout = UI.Layout:create()
            rankLayout:init()
            rankLayout:leftBottom(560 + rankText:getContentSize().width/2, bottomOffset - rankLayout:getContentSize().height/2)
            self.rootLayer:addChild(rankLayout)

            rankLayout:addChild(rankText)
            table.insert(allGrid, {node=rankText, time = delayTime})
            delayTime = delayTime + timeStep
        end
    end   

    -- 计算物品格子排版
    local itemPaddingH = 95
    local itemPaddingV = 80
    local upLayout = nil
    local detailScrollBg = nil
    local size = table.nums(self.itemData)
    if(size > 0) then
        local height = math.ceil(size / CELL_NUMBER)
        local width = 0
        if height > 1 then
            width = CELL_NUMBER * itemPaddingH
        else
            width = size % CELL_NUMBER
            width = (width == 0) and CELL_NUMBER or width
            width = width* itemPaddingH
        end 
        height = height * itemPaddingV

        -- 物品详情内容宿主
        upLayout = UI.TouchLayout:create()
        upLayout:init(0, 0, 0, 0)
        upLayout:setSize(width, height)
        upLayout:addTouchEvents(self)
        upLayout:centerUp(68)

        detailScrollBg = UI.Image9:create()
        detailScrollBg:init("ui_scale9image_banner_bg2.png", CCRectMake(18,18,1,1), cc.size(588, 198))
        detailScrollBg:centerBottom(166)
        self.rootLayer:addChild(detailScrollBg)

        -- 物品详情
        self.detailedScrollView = UI.ScrollView:create()
        self.detailedScrollView:init(0,0,0,0)
        self.detailedScrollView:setSize(460 + 100, 178)
        self.detailedScrollView:center()
        self.detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        self.detailedScrollView:addInnerNode(upLayout)
        self.detailedScrollView:setScrollBarEnabled(true)
        self.detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        self.detailedScrollView:setScrollBarWidth(4)
        detailScrollBg:addChild(self.detailedScrollView, 2)
    end

    local index = 1

    local rankData = GameDataManager:getInstance():getActivityRankData()
    if(rankData and rankData.bagFull == true) then 
        -- 显示
        local noLostText = UI.Text:create()
        noLostText:init(LanguageManager:getInstance():getLocalString(1111039),UI.FONT_STANDARD,UI.FONT_SIZE_20PX,UI.FONT_COLOR_255_247_202)
        noLostText:setSize(530, 198)
        noLostText:setTextCenter()
        noLostText:leftBottom(331, 156)
        self.rootLayer:addChild(noLostText, 2)
    else 
        if(size > 0) then
            for k, goodData in pairs(self.itemData) do
                goodData:setIsNew(false)
                local goodGrid = UI.GoodsGrid:create()
                goodGrid:init(goodData)
                upLayout:addChild(goodGrid)
                goodGrid:hideFlagIcon()
                goodGrid:showGemLevel()
                if goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                    and goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
                    goodGrid:showCountLabel()
                end
                goodGrid:setInfoArea(false, false)
                local mode = index % CELL_NUMBER
                mode = mode == 0 and CELL_NUMBER or mode
                goodGrid:leftUp((mode - 1) * itemPaddingH + 50, math.floor((index - 1) / CELL_NUMBER) * itemPaddingV)
                table.insert(self.allGridNode, goodGrid)
                table.insert(allGrid, {node=goodGrid, time = itemGridDelayTime, isItemCell = true})
                itemGridDelayTime = itemGridDelayTime + 0.05

                goodGrid:setOpacity(0)
                index = index + 1
            end
        end
    end

    -- 同步等待物品栏和救人栏动画完成过后再继续播放下面的动画
    delayTime = buttonAreaDelayTime

    -- -- 分割线
    -- local splitLine = UI.Image9:create()
    -- splitLine:init("ui_scale9image_banner_line_dark.png", CCRectMake(0,0,1,1), cc.size(567, 2))
    -- splitLine:centerBottom(144)
    -- splitLine:setOpacity(0)
    -- table.insert(allGrid, {node=splitLine, time = delayTime, isSplitLine = true})
    -- delayTime = delayTime + timeStep
    -- self.rootLayer:addChild(splitLine)

    -- 处理自动卖掉的物品列表
    if(self._rewardType == UI.RewardType.REWARD_NORMAL and isRank == false) then
        -- autoSellArr = {}
        if(autoSellArr) then
            for k, goodData in pairs(autoSellArr) do
                if((goodData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_ITEM 
                    and goodData:getItemType() == PublicDefine.ITEM_TYPE.EscapeScroll 
                    and FightResultUtil:getInstance().kickOutTownScroll == true)) then
                    table.remove(autoSellArr, k)
                    break
                end
            end

            if #autoSellArr > 0 then
                -- 添加获得物品的背景以及修改列表位置
                if(detailScrollBg) then
                    detailScrollBg:centerBottom(278)
                end

                local scale = 0.75

                -- 添加卖掉列表
                local autoSellImage = UI.Image:create()
                autoSellImage:init("ui_settlement_bg.png")
                autoSellImage:leftBottom(114, 83)
                self.rootLayer:addChild(autoSellImage, 2)

                table.insert(allGrid, {node=autoSellImage, time = itemGridDelayTime, isItemCell = true})
                itemGridDelayTime = itemGridDelayTime + 0.05

                -- 添加提示语言
                local sellMoneyTips = UI.Text:create()
                sellMoneyTips:init(LanguageManager:getInstance():getLocalString(1111679), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
                sellMoneyTips:leftBottom(453 - sellMoneyTips:getContentSize().width/2, 162)
                autoSellImage:addChild(sellMoneyTips)

                size = #autoSellArr
                local height = math.ceil(size / CELL_NUMBER)
                local width = 0
                if height > 1 then
                    width = CELL_NUMBER * itemPaddingH * scale
                else
                    width = size % CELL_NUMBER
                    width = (width == 0) and CELL_NUMBER or width
                    width = width* itemPaddingH * scale
                end 
                height = height * itemPaddingV * scale

                local autoSellLayout = UI.TouchLayout:create()
                autoSellLayout:init(0, 0, 0, 0)
                autoSellLayout:setSize(width, height)
                autoSellLayout:addTouchEvents(self)
                autoSellLayout:centerUp(0)

                local autoSellScrollView = UI.ScrollView:create()
                autoSellScrollView:init(0,0,0,0)
                autoSellScrollView:setSize(365 + 30, 85)
                autoSellScrollView:leftBottom(269, 75)
                autoSellScrollView:setScrollType(UI.ScrollType.VERTICAL)
                autoSellScrollView:addInnerNode(autoSellLayout)
                autoSellScrollView:setScrollBarEnabled(true)
                autoSellScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
                autoSellScrollView:setScrollBarWidth(4)
                autoSellImage:addChild(autoSellScrollView, 2)
                self._autoSellScrollView = autoSellScrollView

                local sellTotalCoin = 0
                local index = 1
                for k, goodData in pairs(autoSellArr) do
                    goodData:setIsNew(false)
                    local goodGrid = UI.GoodsGrid:create()
                    goodGrid:init(goodData)
                    goodGrid:setScale(scale)
                    autoSellLayout:addChild(goodGrid)
                    goodGrid:hideFlagIcon()
                    goodGrid:showGemLevel()
                    if goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                        and goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
                        goodGrid:showCountLabel()
                    end
                    goodGrid:setInfoArea(false, false)
                    local mode = index % CELL_NUMBER
                    mode = mode == 0 and CELL_NUMBER or mode
                    goodGrid:leftUp((mode - 1) * itemPaddingH * scale, math.floor((index - 1) / CELL_NUMBER) * itemPaddingV * scale)
                    index = index + 1
                    table.insert(self.allGridNode, goodGrid)
                    if(goodData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                        and goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                        sellTotalCoin = sellTotalCoin + goodData:getSellPrice()
                    else
                        sellTotalCoin = sellTotalCoin + goodData:getSellPrice() * goodData:getNum()
                    end
                end

                -- 显示金币价格
                local sellMoneyImage = UI.Image:create()
                sellMoneyImage:init("ui_settlement_money.png")
                sellMoneyImage:leftBottom(681 - sellMoneyImage:getContentSize().width /2, 93)
                autoSellImage:addChild(sellMoneyImage, 2)

                local settlementJinbi = UI.Animation:create()
                settlementJinbi:init("effect_ui_common_settlement_jinbi.json", "effect_ui_common_settlement_jinbi.atlas")
                settlementJinbi:leftBottom(681, 93 + sellMoneyImage:getContentSize().height/2)
                autoSellImage:addChild(settlementJinbi)
                settlementJinbi:setAnimation("begin", false)
                settlementJinbi:addAnimation("idle", true)
                settlementJinbi:setScale(1.1)

                local sellMoneyText = UI.Text:create()
                sellMoneyText:init(string.format("+%s", sellMoneyText:numformat(string.format("%d", sellTotalCoin))), UI.FONT_BOLD,UI.FONT_SIZE_17PX, UI.FONT_COLOR_250_211_124)
                sellMoneyText:leftBottom(sellMoneyImage:getContentSize().width / 2 + 10, -5) -- 注意这里是右下基点, 为了多语言长度适配
                sellMoneyImage:addChild(sellMoneyText)
                -- self._momey:setText(self._momey:numformat(string.format("%d",GameDataManager:getInstance():getCurCoin())))
            end
        end
    end

    if(isRank == false 
        and self._rewardType ~= UI.RewardType.REWARD_DEEPLINK
        and self._rewardType ~= UI.RewardType.REWARD_SWEEP) then 
        -- 金币背景
        local bg = UI.Image:create()
        bg:init("ui_information_hero_box_up.png")
        bg:centerBottom(100)
        bg:setOpacity(0)
        table.insert(allGrid, {node=bg, time = delayTime})
        delayTime = delayTime + timeStep
        self.rootLayer:addChild(bg)
        
        local settlementJinbi = UI.Animation:create()
        settlementJinbi:init("effect_ui_common_settlement_jinbi.json", "effect_ui_common_settlement_jinbi.atlas")
        settlementJinbi:centerLeft(0)
        bg:addChild(settlementJinbi)
        settlementJinbi:setAnimation("begin", false)
        settlementJinbi:addAnimation("idle", true)
        settlementJinbi:setScale(1.35)

        -- 黄金图标
        local glodIcon = UI.Image:create()
        glodIcon:init("icon_gold.png")
        glodIcon:centerLeft(-glodIcon:getContentSize().width/2)
        glodIcon:setScale(0.8)
        bg:addChild(glodIcon)

        -- 金币数字
        local number = UI.Text:create()
        number:init(checkint(self.goldData.number).."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
        -- number:centerLeft(glodIcon:getContentSize().width + 4)
        number:center()
        number:setTextCenter()
        bg:addChild(number)

        if self.inscriptionData and self.inscriptionData.number ~= 0 then
            bg:centerBottom(100, -150)
            -- 铭文背景
            local inscriptionBg = UI.Image:create()
            inscriptionBg:init("ui_information_hero_box_up.png")
            inscriptionBg:centerBottom(100, 150)
            inscriptionBg:setOpacity(0)
            table.insert(allGrid, {node=inscriptionBg, time = delayTime})
            delayTime = delayTime + timeStep
            self.rootLayer:addChild(inscriptionBg)
            
            -- local settlementJinbi = UI.Animation:create()
            -- settlementJinbi:init("effect_ui_common_settlement_jinbi.json", "effect_ui_common_settlement_jinbi.atlas")
            -- settlementJinbi:centerLeft(0)
            -- bg:addChild(settlementJinbi)
            -- settlementJinbi:setAnimation("begin", false)
            -- settlementJinbi:addAnimation("idle", true)
            -- settlementJinbi:setScale(1.35)

            -- 黄金图标
            local inscriptionIcon = UI.Image:create()
            inscriptionIcon:init("icon_23470001.png")
            inscriptionIcon:centerLeft(-inscriptionIcon:getContentSize().width/2)
            inscriptionIcon:setScale(0.8)
            inscriptionBg:addChild(inscriptionIcon)

            -- 金币数字
            local number = UI.Text:create()
            number:init(checkint(self.inscriptionData.number).."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
            -- number:centerLeft(glodIcon:getContentSize().width + 4)
            number:center()
            number:setTextCenter()
            inscriptionBg:addChild(number)
        end
    elseif self._rewardType == UI.RewardType.REWARD_DEEPLINK
        or (self._rewardType == UI.RewardType.REWARD_SWEEP and self.isUsingMail) then
        local number = UI.Text:create()
        number:init(LanguageManager:getInstance():getLocalString(1113658), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_208_50_60)
        -- number:centerLeft(glodIcon:getContentSize().width + 4)
        number:centerBottom(100)
        number:setTextCenter()
        self.rootLayer:addChild(number)
    end

    -- 确认按钮
    self.confirmBtn = UI.Button:create()
    self.confirmBtn:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_2.png")
    self.confirmBtn:centerBottom(41)
    self.confirmBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onConfirmClick)
    self.confirmBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self.confirmBtn:setText(UI.TEXT_1170211)
    self.confirmBtn:setOpacity(0)
    self.confirmBtn:setScale(0)
    self.rootLayer:addChild(self.confirmBtn)
    
    print("allGrid=", #allGrid)
    -- 逐个延迟运行浮现
    for k, v in ipairs(allGrid) do
        local delayTime = v.time
        local fadeInDuration = 0.1

        -- 给某些节点加入特殊效果
        if (v.isItemCell) then
            -- 物品节点加缩小效果
            v.node:setScale(1.5)
            v.node:runAction(cc.Sequence:create(
                cc.DelayTime:create(delayTime),
                cc.ScaleTo:create(0.1, 1)))
        elseif (v.isSplitLine) then
            -- 分割线加入放大效果
            v.node:setScale(0)
            v.node:runAction(cc.Sequence:create(
                cc.DelayTime:create(delayTime),
                cc.EaseElasticInOut:create(cc.ScaleTo:create(1, 1))))
        end

        -- 其他元素渐入
        v.node:runAction(cc.Sequence:create(
            cc.DelayTime:create(delayTime), 
            cc.FadeIn:create(fadeInDuration), 
            cc.CallFunc:create(function() 
                if k == #allGrid then
                    self.confirmBtn:runAction(cc.FadeIn:create(fadeInDuration))
                    self.confirmBtn:runAction(cc.EaseBackOut:create(cc.ScaleTo:create(0.3, 1)))
                    -- self:showCommentLayer()
                end
            end)))
    end 

    local sharePanel = self:showShareBtn()
    sharePanel:rightBottom(100, -10)
    self.rootLayer:addChild(sharePanel,1000)
end

-- 展示引导评论
function DungeonBattleRewardLayer:showCommentLayer()
    local SdkManager = require"app.game.SdkManager"
    if(self._rewardType == UI.RewardType.REWARD_DUNGEON) then
        if GameDataManager:getInstance():getEscapeScrollBackTownShowComment() then
            SdkManager:checkCommentEvent(COMMENT_TYPE.USE_ESCAPE_ITEM)
        else
            SdkManager:checkCommentEvent(COMMENT_TYPE.DUNGEON_SEASON_REWARD)
        end
    elseif(self._rewardType == UI.RewardType.REWARD_NORMAL) then
        if GameDataManager:getInstance():getSuccessBackTownShowComment() then
            SdkManager:checkCommentEvent(COMMENT_TYPE.PASS_CAVE)
        elseif GameDataManager:getInstance():getEscapeScrollBackTownShowComment() then
            SdkManager:checkCommentEvent(COMMENT_TYPE.USE_ESCAPE_ITEM)
        end
    elseif(self._rewardType == UI.RewardType.REWARD_GUILD_BOSS) then
        
    end
end

-- 处理确认按钮点击
function DungeonBattleRewardLayer:onConfirmClick()
    if(self._rewardType == UI.RewardType.REWARD_DUNGEON) then
        if self.isUsingMail then
            UI.ScrollBar:createByTextID(1111039)
        end
        FightResultUtil:getInstance():clearDungeonBattleReward()
        self:handleClose()
    elseif(self._rewardType == UI.RewardType.REWARD_GUILD_BOSS) then
        GameDataManager:getInstance():clearGuildBossRewardData()
        self:handleClose()
    elseif(self._rewardType == UI.RewardType.REWARD_NORMAL) then
        if self._closeCallBack then
            local isSuccess = self._closeCallBack()
            print("-----------------isSuccess", isSuccess)
            if not isSuccess then
                self:showCommentLayer()
            end
        else
            self:showCommentLayer()
        end
        GameDataManager:getInstance():setIsShowReward(false)
        self:handleClose()
    elseif(self._rewardType == UI.RewardType.REWARD_SWEEP) then
        if self.isUsingMail then
            UI.ScrollBar:createByTextID(1111039)
        end
        self:handleClose()
    elseif(self._rewardType == UI.RewardType.REWARD_GHOSTABYSS) then
        mvc.caveModel:handleGhostEndReward(nil)
        if self.isUsingMail then
            UI.ScrollBar:createByTextID(1111039)
        end
        self:handleClose()
    else
        self:handleClose()
    end
end

-- 关闭页面
function DungeonBattleRewardLayer:handleClose()
    if self._closeCallBack then
        self._closeCallBack()
    end
    self:close()
end

-- 道具框点击开始
function DungeonBattleRewardLayer:onTouchBegan(touch, event)
    printInfo("DungeonBattleRewardLayer:onTouchBegan")
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    if(self.detailedScrollView) then 
        local point = self.detailedScrollView:convertToWorldSpace(cc.p(0, 0))
        local rect = cc.rect(point.x , point.y , self.detailedScrollView:getContentSize().width,self.detailedScrollView:getContentSize().height) 

        if cc.rectContainsPoint(rect, location) then
            for k, value in ipairs(self.allGridNode) do
                if AvalonUtil:isRectContainsPoint(value, location) and value:isVisible() then
                    self.selectIndex = k
                    break
                end
            end
        end
    end

    if(self._autoSellScrollView and self.selectIndex == 0) then 
        local point = self._autoSellScrollView:convertToWorldSpace(cc.p(0, 0))
        local rect = cc.rect(point.x , point.y , self._autoSellScrollView:getContentSize().width,self._autoSellScrollView:getContentSize().height) 

        if cc.rectContainsPoint(rect, location) then
            for k, value in ipairs(self.allGridNode) do
                if AvalonUtil:isRectContainsPoint(value, location) and value:isVisible() then
                    self.selectIndex = k
                    break
                end
            end
        end
    end
end

-- 道具框点击结束
function DungeonBattleRewardLayer:onTouchEnded(touch, event)
    printInfo(" DungeonBattleRewardLayer:onTouchEnded")
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            local goodsData = value:getData();
            local pInfoArea = nil;

            if not tolua.isnull(self._infoItem) then 
                self._infoItem:removeFromParent(true)
                self._infoItem = nil
            end

            if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                -- 装备详情
                pInfoArea = UI.EquipmentInfoArea:create()
                if(self._rewardType == UI.RewardType.REWARD_DUNGEON) then
                    pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
                else 
                    pInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                end
                pInfoArea:hideCompInfo()
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                -- 装备详情
                pInfoArea = UI.EquipmentPetInfoArea:create()
                if(self._rewardType == UI.RewardType.REWARD_DUNGEON) then
                    pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
                else 
                    pInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                end
                pInfoArea:hideCompInfo()
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
                -- 道具详情界面
                pInfoArea = UI.PropInfoArea:create(true)
                pInfoArea:init(UI.PROP_MATER.PROPINFO)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                    goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
                -- 材料详情界面
                pInfoArea = UI.PropInfoArea:create(true)
                pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
                -- 虚拟物品详情界面
                if(goodsData:getCanBeView()) then 
                    pInfoArea = UI.PropInfoArea:create(true)
                    pInfoArea:init(UI.PROP_MATER.VIRTUALITEM_INFO)
                else
                    return 
                end
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
                pInfoArea = UI.GemStoneInfoArea:create()
                pInfoArea:init(goodsData)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
                pInfoArea = UI.StarPrayInfoArea:create()
                pInfoArea:init(goodsData)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
                pInfoArea = UI.PetStoneInfoArea:create()
                pInfoArea:init(goodsData)
            else
                return
            end
            pInfoArea:setHideLink(isHideLink)
            local worldPos = value:convertToWorldSpace(cc.p(0,0))

            if worldPos.x < winSize.width/2 then
                pInfoArea:centerLeft(worldPos.x + value:getSize() + 20)
            else
                pInfoArea:centerLeft(worldPos.x - pInfoArea:getSize() - 20)
            end

            pInfoArea:setVisible(true)
            pInfoArea:updateView(goodsData)
            pInfoArea:closeLockFlag()
            pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self,obj,touchPosition)
                self._infoItem = nil
                if not tolua.isnull(obj:getGoodsGrid()) then
                    local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
                    local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

                    if cc.rectContainsPoint(rect, touchPosition) then
                        obj:setInterceptTouches(false)
                    end
                end
                
                pInfoArea:close();
            end)

            self:addChild(pInfoArea,100000)
            break
        end
    end
end

function DungeonBattleRewardLayer:showShareBtn()
    local sharePanel = UI.SharePanel:create(handler(self, self.shareClick), PublicDefine.SHARE_MODULE.SHARE_MODULE_BATTLE_RESULT, false)
    return sharePanel
end

function DungeonBattleRewardLayer:shareClick(shareChannel)
    print("------DungeonBattleRewardLayer:shareClick(platform)-----  shareChannel = "..shareChannel)  
    local shareDatas = ConfigManager:getShareConfigByType(PublicDefine.SHARE_MODULE.SHARE_MODULE_BATTLE_RESULT, shareChannel)
    dump(shareDatas, "----shareDatas----")
    if shareDatas == nil then
        printWarn("----!!!! error !!!! treaseure shareDatas is nnil")
        return
    end
    if not tolua.isnull(self._ShareNode) then
        self._ShareNode:removeFromParent(true)
    end
    local contentBg, shareNode = AvalonUtil.getPublicShareBg(shareDatas, shareChannel)
    local npc = contentBg:getChildByName("npcBg"):getChildByName("npc")
    npc:setSpriteName("ui_share_npc_1.png")

    local npcDialog = contentBg:getChildByName("npcDialogBg"):getChildByName("npcDialog")
    npcDialog:setText(LanguageManager:getInstance():getLocalString(1192003))
    self._ShareNode = shareNode

---内容
    -- 标题动画
    local animation = UI.Animation:create()
    animation:init("effect_ui_town_dungeon_reward.json", "effect_ui_town_dungeon_reward.atlas")
    animation:centerUp(130)
    contentBg:addChild(animation)
    animation:addAnimation("idle", false)

    -- 标题文字
    local titleStr = self:getTitleName()
    local logoName = UI.Text:create()
    logoName:init(titleStr, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_255_224_115)
    logoName:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -3))
    logoName:centerBottom(-11)
    animation:addChild(logoName)

    if(self.isRank) then 
        local rank = self.rescueNum
        local titleText = UI.Text:create()
        titleText:init(LanguageManager:getInstance():getLocalString(1111570), UI.FONT_BOLD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_207_182_89)
        titleText:rightBottom(585, 385 - titleText:getContentSize().height/2) -- 注意这里是右下基点, 为了多语言长度适配
        contentBg:addChild(titleText)

        if(rank < 4) then 
            local spriteName = "ui_rankinglist_gold.png"
            if(rank == 1) then 
                spriteName = "ui_rankinglist_gold.png"
            elseif (rank == 2) then 
                spriteName = "ui_rankinglist_silver.png"
            elseif (rank == 3) then 
                spriteName = "ui_rankinglist_copper.png"
            end

            -- 排行图标
            local rescueImage = UI.Image:create()
            rescueImage:init(spriteName)
            rescueImage:leftBottom(560, 385 - rescueImage:getContentSize().height/2)
            contentBg:addChild(rescueImage)
        else 
            -- 排行图标
            local rankText = cc.LabelAtlas:create(string.format("%s", rank), "ui_home_unmber.png", 17, 23, 48)
            rankText:setAnchorPoint(cc.p(0.5, 0.5))

            local rankLayout = UI.Layout:create()
            rankLayout:init()
            rankLayout:leftBottom(560 + rankText:getContentSize().width/2, 385 - rankLayout:getContentSize().height/2)
            contentBg:addChild(rankLayout)

            rankLayout:addChild(rankText)
        end
    end


    local up = 250
    local showRowNum = 3

    -- 计算物品格子排版
    local size = table.nums(self.itemData)
    local itemPaddingH = 100
    local itemPaddingV = 80

    local height = math.ceil(size / CELL_NUMBER)
    local width = 0
    if height > 1 then
        width = CELL_NUMBER * itemPaddingH
    else
        width = size % CELL_NUMBER
        width = (width == 0) and CELL_NUMBER or width
        width = width* itemPaddingH
    end 
    height = height * itemPaddingV

    -- 物品详情内容宿主
    local upLayout = UI.Layout:create()
    upLayout:init(0, 0, 0, 0)
    upLayout:setSize(width, height)
    upLayout:centerUp(up)
    contentBg:addChild(upLayout)

    local index = 1
    for k, goodData in pairs(self.itemData) do
        goodData:setIsNew(false)
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        upLayout:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        goodGrid:showGemLevel()
        if goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            and goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
            goodGrid:showCountLabel()
        end
        local mode = index % CELL_NUMBER
        mode = mode == 0 and CELL_NUMBER or mode
        goodGrid:leftUp((mode - 1) * itemPaddingH, math.floor((index - 1) / CELL_NUMBER) * itemPaddingV)
        index = index + 1
        if index > showRowNum * 5 then
            break
        end
    end

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_dark.png", CCRectMake(0,0,1,1), cc.size(567, 2))
    splitLine:centerBottom(144)
    contentBg:addChild(splitLine)

    -- 金币背景
    local bg = UI.Image:create()
    bg:init("ui_information_hero_box_up.png")
    bg:centerBottom(100)
    contentBg:addChild(bg)

    -- 黄金图标
    local glodIcon = UI.Image:create()
    glodIcon:init("symbol_gaming_money.png")
    glodIcon:centerLeft(50)
    bg:addChild(glodIcon)

    -- 金币数字
    local number = UI.Text:create()
    number:init(checkint(self.goldData.number).."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
    number:centerLeft(glodIcon:getContentSize().width + 4)
    number:setTextCenter()
    glodIcon:addChild(number)
    glodIcon:centerLeft(bg:getContentSize().width /2 - (glodIcon:getContentSize().width + number:getContentSize().width + 4)/2)
--内容
end

function DungeonBattleRewardLayer:getTitleName()
    local str = UI.TEXT_1170210
    if(self._rewardType == UI.RewardType.REWARD_DEEPLINK) then
        str = LanguageManager:getInstance():getLocalString(1113657)
    end

    return str
end

function DungeonBattleRewardLayer:getDeepLinkReward()
    local deepLinkReward = ConfigManager:getGeneralForKey("deepLinkReward")
    local rewardGoodsArr = {} 
    local goldNum = 0
    if(deepLinkReward) then
        local rewardArr = string.split(deepLinkReward, ";")
        if(rewardArr) then 
            for k,v in ipairs(rewardArr) do
                local oneArr = string.split(v,",")
                if(oneArr[1]) then
                    -- if(tonumber(oneArr[1]) == Game.ConstGoods.Coin) then 
                    --     goldNum = tonumber(oneArr[2])
                    -- else
                        local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(oneArr[1]))
                        goodsData:setIsNew(false)
                        goodsData:setNum(tonumber(oneArr[2]))
                        table.insert(rewardGoodsArr, goodsData)
                    -- end
                end
            end
        end
    end

    return rewardGoodsArr, goldNum
end

function DungeonBattleRewardLayer:getSweepReward()
    local data = FightResultUtil:getInstance():getSweepReward()
    print("getSweepReward", data)
    local rewardArr = {}
    local isToMail = false
    if(data) then 
        if data.awards then 
            for k, v in pairs(data.awards) do 
                local goodsData = GoodsDataManager:createLocalGoodsData(v.id)
                goodsData:setNum(v.num)
                goodsData:setIsNew(false)

                table.insert(rewardArr, goodsData)
                print("getSweepReward  2", v)
            end
        end
        if(data.isToMail) then 
            isToMail = true
        end
    end

    return rewardArr, isToMail
end

function DungeonBattleRewardLayer:getGhostAbyssData()
    local data = mvc.caveModel:getGhostAbyssRewardData()
    print("getGhostAbyssData", data)
    local rewardArr = {}
    local isToMail = false
    if(data) then 
        if data.awards then 
            for k, v in pairs(data.awards) do 
                local goodsData = GoodsDataManager:createLocalGoodsData(v.id)
                goodsData:setNum(v.num)
                goodsData:setIsNew(false)

                table.insert(rewardArr, goodsData)
            end
        end
        if(data.isInMail) then 
            isToMail = true
        end
    end

    return rewardArr, isToMail
end