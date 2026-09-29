-- LostRealmLayer.lua
-- Author:ODEI
-- 2017年8月16日
-- Using:横向拓展框

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local SdkManager = require "app.game.SdkManager"
require "app.ui.iapshop.IapShopMonthCardLayer"
require "app.ui.UIDefine"
require "app.ui.cave.LostRealmRewardCell"

local ProtobufUtil = require("utils.ProtobufUtil")

UI = UI or {}
local LostRealmLayer = class("LostRealmLayer", UI.HWBtnComponent)
UI.LostRealmLayer = LostRealmLayer

local winSize = cc.Director:getInstance():getWinSize()

local COM_RES_LIST = {
    "ui_town_festival_lostrealm.plist",
    "ui_town_businessactivities_special_giftbag.plist",
}

local CELL_WIDTH = 55
local CELL_HEIGHT = 60
local EXTREA_WIDTH = 40
local EXTREA_SCALE = 5
local unlockType = PublicDefine.UnlockFunctionType 

function LostRealmLayer:ctor()
    LostRealmLayer.super.ctor(
        self, UIType.MAIN_UI_LOSTREALM, COM_RES_LIST, winSize.width - Avalon.issUtil:getWidthOffset(),winSize.height
    )
    self.rootLayer = nil           --root节点
    self:init()
end

-- 析构
function LostRealmLayer:dtor()
    LostRealmLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function LostRealmLayer:init()
    LostRealmLayer.super.init(self)
    self:registerListener()
end


-- 模版函数：初始化组建的视图
function LostRealmLayer:onInitView()
    local titleBg = UI.Image:create()
    titleBg:init("ui_monopoly_title.png")
    titleBg:leftUp(0, 14)
    self:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1325400, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_255_211_155)
    titleText:useDefaultShadowOnlyStype()
    titleText:setFixLineWidth(125)
    titleText:autoAdapt()
    titleText:center(-14)
    titleBg:addChild(titleText)

    -- 添加帮助按钮
    local helpData = ConfigManager:getClientHelpForID(self._type)
    if(helpData) then 
        require "app.ui.common.GeneralHelpLayer"
        local generalHelp = UI.GeneralHelpLayer:create(helpData)
        generalHelp:init()
        generalHelp:centerRight(-50)
        generalHelp:setName("GeneralHelp")
        titleBg:addChild(generalHelp, 100000)
    end

    local randomButton = UI.Button:create()
    randomButton:init()
    randomButton:rightBottom(20 + Avalon.issUtil:getRightMargin(), 47)
    randomButton:setSize(210, 210)
    randomButton:setTextFont(UI.SYS_FONT, 25, UI.FONT_COLOR_255_255_255)
    randomButton:setFontSize(25)
    randomButton:setText("")
    randomButton:setInterval(0.5)
    randomButton:setEnableMinTouchSize(false)
    randomButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:clickOperate()
    end)
    randomButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        self:clickDisableOperate()
    end)
    self:addChild(randomButton, 10)
    self.randomButton = randomButton

    local startAnimation = Avalon.Animation:create("effect_ui_town_lostrealm_startbtn.json", "effect_ui_town_lostrealm_startbtn.atlas", 1)
    startAnimation:setAnimation(0, "idle", true)
    startAnimation:setPosition(cc.p(randomButton:getContentSize().width/2, randomButton:getContentSize().height/2))
    randomButton:addChild(startAnimation)
    self.startAnimation = startAnimation

    -- 次数等显示
    local numTextImageBg = UI.Image:create()
    numTextImageBg:init("ui_monopoly_frequencybg.png")
    numTextImageBg:centerBottom(-5)
    randomButton:addChild(numTextImageBg, 3)

    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_gaming_diamond.png")
    numTextImageBg:addChild(diamondIcon)
    self.diamondIcon = diamondIcon

    local numText = UI.Text:create()
    numText:init(UI.TEXT_1325402, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_210_210_210)
    numText:center()
    numTextImageBg:addChild(numText)
    numText:autoAdapt()
    self.numText = numText

    local totalText = UI.Text:create()
    totalText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_210_210_210)
    totalText:center()
    numTextImageBg:addChild(totalText)
    totalText:autoAdapt()
    self.totalText = totalText

    -- 处理钻石的次数表现
    local numDiamondImageBg = UI.Image:create()
    numDiamondImageBg:init("ui_monopoly_frequencybg.png")
    numDiamondImageBg:centerBottom(-35)
    randomButton:addChild(numDiamondImageBg, 3)
    self.numDiamondImageBg = numDiamondImageBg
    numDiamondImageBg:setVisible(false)

    local totalDiamondText = UI.Text:create()
    totalDiamondText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_210_210_210)
    totalDiamondText:center()
    numDiamondImageBg:addChild(totalDiamondText)
    totalDiamondText:autoAdapt()
    self.totalDiamondText = totalDiamondText
    
    -- 货币表现
    local currentLayout = UI.CurrencyPanel:create(UI.FONT_COLOR_190_190_190, true)
    currentLayout:rightUp(120 + Avalon.issUtil:getRightMargin(), 30)
    self:addChild(currentLayout)
    self.currentLayout = currentLayout

    -- exit button
    local closeBtn = UI.Button:create()
    closeBtn:init('ui_specialpackage_close.png', 'ui_specialpackage_close.png')
    closeBtn:rightUp(20 + Avalon.issUtil:getRightMargin(), 30)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:exitScene()
        -- GameManager:setLostRealmOffsetCoord({x=0,y =40})
    end)
    self:addChild(closeBtn)

    local centerBtn = UI.Button:create()
    centerBtn:init()
    centerBtn:center()
    centerBtn:setSize(210, 210)
    centerBtn:setEnableMinTouchSize(false)
    centerBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:initDetailInfo()
        -- self:testCricleNum()
    end)
    self:addChild(centerBtn, 10)

    -- 蒙层
    local randomBG = cc.LayerColor:create(cc.c4b(0,0,0,153))
    randomBG:setPosition(-winSize.width, -winSize.height)
    randomBG:setContentSize(winSize.width*2, winSize.height*2)
    self:addChild(randomBG, 29)
    randomBG:setVisible(false)
    self.randomBG = randomBG


    self:refreshBtnStatus()
end

-- 模版函数：更新组建的视图
function LostRealmLayer:onUpdateView()
end

function LostRealmLayer:testCricleNum()
    local MachineManager = require("app.game.MachineManager")
    local view = MachineManager:getInstance():getMachine():getView()

    local downLayout = UI.Layout:create()
    downLayout:init()
    downLayout:centerBottom(66)
    local num = 3
    local length = string.len(num)
    local startX = -(26 * length)/2 -6
    local startY = 0
    local oneY = -6
    for i=1, length, 1 do 
        local str = string.format("ui_monopoly_number_%s.png", string.sub(num, i,i))
        local star = UI.Image:create()
        star:init(str)
        star:leftBottom(startX, startY)
        star:enableDebugDraw()
        downLayout:addComponent(star)

        startX = startX + 26
        startY = startY + oneY
    end

    view:testRealmNum({x=110, y=50}, downLayout)
end

function LostRealmLayer:exitScene()
    local tips = UI.Tips:createTips(UI.TEXT_1325405,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
    tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
        GameManager:giveUpBackTown()
    end)
end

function LostRealmLayer:refreshBtnStatus(refreshNum, startResult)
    if(self.shieldClick) then
        if(refreshNum) then
            -- self.startAnimation:setTimeScale(0.5)
            self.startAnimation:setAnimation(0, "zgjie_switch_zgjie1", false)
            self.startAnimation:addAnimation(0, "zgjie1_idle", true)
            if(self.operateData) then
                self.startAnimation:setAttachment("zgjie1",string.format("zgjie-jie2-%d", self.operateData.moveStep))
            end
            return
        end
        if not startResult then 
            return
        end
    end

    local lostRealmData = mvc.festivalModel:getLostRealmData()
    local countTotalNum = mvc.festivalModel:getLostRealmTotalCount()
    local countFreeNum = mvc.festivalModel:getLostRealmFreeCount()
    local countDiamondNum = mvc.festivalModel:getLostRealmDiamondCount()
    local oneCricleNum = #ConfigManager:getAllLostRealm()
    local textPadding = 4
    local lostExtraCount = lostRealmData.extraCount
    if(startResult and self.operateData) then 
        lostExtraCount = lostExtraCount - self.operateData.extraCount
    end
    
    -- 受限判断是否有宝箱可以领取
    self.randomButton:enable()
    local rewardBox = false
    local quanNum = math.modf(lostRealmData.currentStep/oneCricleNum)
    local runAnimationName = self.startAnimation:getAnimationName(0)
    runAnimationName = runAnimationName or ""
    -- print("refreshBtnStatus", quanNum, lostRealmData.claimedCycleReward)
    self.startAnimation:setToSetupPose()
    self.numText:setFontColor(UI.FONT_COLOR_210_210_210)
    self.numDiamondImageBg:setVisible(false)
    if(quanNum > #lostRealmData.claimedCycleReward and not startResult) then 
        -- 有奖励可以领取
        if(string.find(runAnimationName, "box_")) then 
            self.startAnimation:setAnimation(0, "box_idle", true)
        else
            self.startAnimation:setAnimation(0, "zgjie1_switch_box", false)
            self.startAnimation:addAnimation(0, "box_idle", true)
        end
        self.totalText:setVisible(false)
        self.diamondIcon:setVisible(false)
        self.numText:setText(UI.TEXT_1325404)
        self.numText:center()
        -- print("有宝箱奖励可以领取")
    elseif(lostExtraCount > 0) then 
        -- 有额外次数可以使用
        if(string.find(runAnimationName, "box_")) then 
            self.startAnimation:setAnimation(0, "box_switch_zgjie", false)
            self.startAnimation:addAnimation(0, "idle", true)
        else
            self.startAnimation:setAnimation(0, "zgjie1_switch_zgjie", false)
            self.startAnimation:addAnimation(0, "idle", true)
        end
        self.totalText:setVisible(false)
        self.diamondIcon:setVisible(false)
        self.numText:setText(UI.TEXT_1325407..":"..lostExtraCount)

        self.numText:center()
        self.numText:setFontColor({r = 101, g = 194, b = 88})
        -- print("有额外次数可以丢")
    elseif(lostRealmData.rollCount < countTotalNum) then 
        -- 还有次数可以使用
        if(string.find(runAnimationName, "box_")) then 
            self.startAnimation:setAnimation(0, "box_switch_zgjie", false)
            self.startAnimation:addAnimation(0, "idle", true)
        else
            self.startAnimation:setAnimation(0, "zgjie1_switch_zgjie", false)
            self.startAnimation:addAnimation(0, "idle", true)
        end
        local costDiamond = mvc.festivalModel:getLostRealmCost()
        self.totalText:setVisible(true)
        
        if(costDiamond == 0 ) then
            self.totalText:setText(string.format("(%d/%d)", countFreeNum - lostRealmData.rollCount, countFreeNum))
            self.diamondIcon:setVisible(false)
            self.numText:setText(UI.TEXT_1325406)
            local startX = -(self.numText:getContentSize().width + self.totalText:getContentSize().width + textPadding)/2
            -- print("startX=", startX, self.numText:getContentSize().width, self.totalText:getContentSize().width)
            self.numText:center(startX + self.numText:getContentSize().width/2)
            self.totalText:center(startX + self.numText:getContentSize().width + self.totalText:getContentSize().width/2 + textPadding)
        else
            self.numDiamondImageBg:setVisible(true)
            local LanguageManager = require("app.game.LanguageManager")
            self.totalDiamondText:setText(string.format(LanguageManager:getInstance():getLocalString(1113916), countTotalNum - lostRealmData.rollCount))
            self.diamondIcon:setVisible(true)
            self.totalText:setVisible(false)
            self.numText:setText(""..costDiamond)
            if GameDataManager:getInstance():getDiamond() < costDiamond then
                self.numText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            end
            local startX = -(self.diamondIcon:getContentSize().width + self.numText:getContentSize().width) /2
            self.diamondIcon:center(startX)
            startX = startX + self.diamondIcon:getContentSize().width
            self.numText:center(startX + self.numText:getContentSize().width/2)
            -- startX = startX + self.numText:getContentSize().width + textPadding
            -- self.totalText:center(startX + self.totalText:getContentSize().width/2)
        end
        -- print("使用正常次数")
    else
        self.startAnimation:setAnimation(0, "end", true)
        self.startAnimation:updateTime(1)
        self.randomButton:disable()

        self.totalText:setVisible(false)
        self.diamondIcon:setVisible(false)
        self.numText:setText(UI.TEXT_1325403)
        self.numText:center()
        -- print("次数已经用完")
    end
end

function LostRealmLayer:initDetailInfo()
    self.nowLevel = mvc.festivalModel:getWasRunCirle() + 1
    if(self.rightDetailLayer == nil) then 
        local lostRealmArr = ConfigManager:getAllLostRealmReward()
        
        local rightLayer = UI.Layout:create()
        rightLayer:init()
        rightLayer:center()
        rightLayer:setInterceptTouches(true)
        rightLayer:setTouchEnable(true)
        rightLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
            self.rightDetailLayer:setVisible(false)
        end)
        
        self.rightDetailLayer = rightLayer
        self:addChild(rightLayer, 10000)

        -- 变黑
        local bg = cc.LayerColor:create(cc.c4b(0,0,0,153))
        bg:setPosition(-winSize.width, -winSize.height)
        bg:setContentSize(winSize.width*2, winSize.height*2)
        rightLayer:addChild(bg)

        -- 背景
        local bg = UI.Image:create()
        bg:init("ui_monopoly_bg.png")
        bg:center()
        rightLayer:addChild(bg)
        rightLayer:setSize(bg:getContentSize().width, bg:getContentSize().height)

        -- model 图标
        local titleIcon = UI.Image:create()
        titleIcon:init("ui_monopoly_title_2.png")
        titleIcon:centerUp(46 - titleIcon:getContentSize().height/2)
        bg:addChild(titleIcon)
        self.titleIcon = titleIcon

        -- 名字
        local nameText = UI.Text:create()
        nameText:init(UI.TEXT_1325401, UI.FONT_STANDARD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_155_155_155)
        nameText:center()
        nameText:setFixLineWidth(244)
        nameText:autoAdapt()
        titleIcon:addChild(nameText)

        local splitLine = UI.Image:create()
        splitLine:init(
            "ui_monopoly_line.png"
        )
        splitLine:centerUp(101)
        bg:addChild(splitLine)

        local splitLine = UI.Image:create()
        splitLine:init(
            "ui_monopoly_line.png"
        )
        splitLine:centerBottom(30)
        bg:addChild(splitLine)

        -- 中间列表区域
        -- 称号列表本身
        self._titleTableView = UI.TableView:create({}, 604, 382)
        self._titleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
        self._titleTableView:leftUp(52, 107)
        self._titleTableView:setDelegate()
        self._titleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
        self._titleTableView:setBounceable(true)
        self._titleTableView:setOpacityModifyRGB(true)
        self._titleTableView:init()
        self._titleTableView:onUpdateCellSize(function (table,idx)
            return 604, 112
        end) 

        self._titleTableView:onUpdateCells(function (table, idx)
            -- 获取缓存的格子, 如果没有, 就新建
            local reusedCell = table:dequeueCell()
            if (not reusedCell) then
                reusedCell = UI.TableViewCell:create()
                xpcall(function()
                    local cellView = UI.LostRealmRewardCell:create()
                    cellView:init()
                    cellView:setTouchClipNode(self._titleTableView)
                    cellView:leftBottom(0, 0)
                    cellView:setName("cellView")
                    reusedCell:addChild(cellView)
                    cellView:updateData(lostRealmArr[idx + 1], self.nowLevel)
                end,
                function(e) 
                    printError("------------------------GoodsListNew:tableCellAtIndex-----------------error", e)
                end, 1);
            else 
                local cellView = reusedCell:getChildByName("cellView")
                if (cellView) then
                    cellView:updateData(lostRealmArr[idx + 1], self.nowLevel)
                end
            end

            return reusedCell
        end)

        self._titleTableView:onUpdateCellNumbers(function ()
            local totalNum = mvc.festivalModel:getWasRunCirle() + 2 
            if(totalNum > #ConfigManager:getAllLostRealmReward()) then
                totalNum = #ConfigManager:getAllLostRealmReward()
            end
            return totalNum
        end)

        self._titleTableView:onTableCellTouched(function(table, cell)
            
        end)
        bg:addChild(self._titleTableView, 0)
    else
        self.rightDetailLayer:setVisible(true)
    end
    -- 载入数据
    self._titleTableView:reloadData()
    self._titleTableView:scrollToCell(self.nowLevel + 2.5)
    self._titleTableView:fixContentOffset() 
end

function LostRealmLayer:addCount(worldPosition, count, callBack)
    local startPosition = self:convertToNodeSpace(worldPosition)
    local startMoveTime = 0.5
    local screenPosition = self.randomButton:convertToWorldSpace(cc.p(self.randomButton:getContentSize().width/2, self.randomButton:getContentSize().height/2))
    local endPosition = self:convertToNodeSpace(screenPosition)

    for i=1,count,1 do 
        local iconImage = cc.Sprite:create()
        iconImage:setSpriteFrame("ui_monopoly_stepcount_big_05.png")
        iconImage:setAnchorPoint(cc.p(0.5, 0.5))
        iconImage:setScale(0.2)
        iconImage:setPosition(startPosition.x, startPosition.y)
        self:addChild(iconImage, 100)

        local bezierConfig = {}
        local minX = 1
        local maxX = 1


        local control = cc.p((startPosition.x + endPosition.x)/2 + (- startPosition.x + endPosition.x)*1/5 - math.random(minX, maxX),(startPosition.y + endPosition.y)/2 + math.random(2, 30))
        table.insert(bezierConfig, control)
        table.insert(bezierConfig, cc.p(control.x - 1,control.y - 1))
        table.insert(bezierConfig, endPosition)
        local moveAction = cc.BezierTo:create(startMoveTime, bezierConfig)

        iconImage:runAction(cc.Sequence:create(cc.Spawn:create(moveAction, cc.Sequence:create(cc.ScaleTo:create(startMoveTime,0.55),cc.ScaleTo:create(startMoveTime,0.2))), cc.CallFunc:create(function()
            iconImage:runAction(cc.RemoveSelf:create())
            if(callBack) then 
                callBack()
                callBack = nil
            end
        end)))
    end
end

function LostRealmLayer:clickDisableOperate()
    local countTotalNum = mvc.festivalModel:getLostRealmTotalCount()
    local lostRealmData = mvc.festivalModel:getLostRealmData()
    if(lostRealmData.rollCount >= countTotalNum) then 
        self:exitScene()
    end
end

function LostRealmLayer:clickOperate()
    if(self.shieldClick) then 
        UI.ScrollBar:createByText(UI.TEXT_1170412)
        return
    end

    if(self.randomAnimation) then 
        self.randomAnimation:removeFromParent(true)
        self.randomAnimation = nil
    end
    if(self.randomUpAnimation) then 
        self.randomUpAnimation:removeFromParent(true)
        self.randomUpAnimation = nil
    end

    if(self.randomAnimation == nil) then
        local randomAnimation = Avalon.Animation:create("effect_ui_town_lostrealm_zgjie.json", "effect_ui_town_lostrealm_zgjie.atlas", 1)
        randomAnimation:setPosition(cc.p(self:getContentSize().width/2, self:getContentSize().height/2))
        self:addChild(randomAnimation, 30)
        self.randomAnimation = randomAnimation

        local randomUpAnimation = Avalon.Animation:create("effect_ui_town_lostrealm_zgjie.json", "effect_ui_town_lostrealm_zgjie.atlas", 1)
        randomUpAnimation:setPosition(cc.p(self:getContentSize().width/2, self:getContentSize().height/2))
        self:addChild(randomUpAnimation, 31)
        self.randomUpAnimation = randomUpAnimation

        randomAnimation:registerSpineEventHandler(function (event)
            if(event.animation and event.animation == "idle") then
                if(self.operateStepNum) then 
                    self.randomUpAnimation:setAnimation(0, string.format("trigger%d", self.operateStepNum))
                    self.randomUpAnimation:setVisible(true)
                    self.operateStepNum = nil

                    Avalon.Scheduler:scheduleUpdateOnce(self, function()

                        self:refreshBtnStatus(true)
                    end, 0.6)
                end
            end
        end, sp.EventType.ANIMATION_START)

        randomAnimation:registerSpineEventHandler(function (event)
            if(event.animation and event.animation == "end") then
                Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                    self:operateEnd()
                    self.randomAnimation:setVisible(false)
                    self.randomBG:setVisible(false)
                end, 0.1)
            end
        end, sp.EventType.ANIMATION_END)

        randomUpAnimation:registerSpineEventHandler(function (event)
            if(event.animation and string.find(event.animation, "trigger")) then
                self.randomUpAnimation:setVisible(false)
                Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                    self.randomAnimation:setAnimation(0, "end", false)
                end, 0.01)
            end
        end, sp.EventType.ANIMATION_END)
    end
    local lostRealmData = mvc.festivalModel:getLostRealmData()
    local countTotalNum = mvc.festivalModel:getLostRealmTotalCount()
    local oneCricleNum = #ConfigManager:getAllLostRealm()
    local textPadding = 4
    
    -- 受限判断是否有宝箱可以领取
    self.randomButton:enable()
    local rewardBox = false
    local quanNum = mvc.festivalModel:getWasRunCirle()
    local runAnimationName = self.startAnimation:getAnimationName(0)
    runAnimationName = runAnimationName or ""
    -- print("refreshBtnStatus", quanNum, lostRealmData.claimedCycleReward)

    local isShowRandom = true
    -- self.numText:setFontColor(UI.FONT_COLOR_210_210_210)

    local requestCallFunction = function()
        self.randomAnimation:setVisible(isShowRandom)
        self.randomBG:setVisible(isShowRandom)
        self.randomAnimation:setToSetupPose()
        self.randomAnimation:setAnimation(0, "begin", false)
        self.randomAnimation:addAnimation(0, "idle", true)
        if(quanNum > #lostRealmData.claimedCycleReward) then 
            Avalon.AudioManager:playSound("1032")
        else
            Avalon.AudioManager:playSound("10073")
        end

        self.operateData = nil
        self.operateStepNum = nil
        Net.NetPlaySystem:requestLostRealmOperate()
        self.currentLayout:beginCacheMode()
        self.shieldClick = true
    end

    if(quanNum > #lostRealmData.claimedCycleReward) then 
        -- 有奖励可以领取
        isShowRandom = false
        -- print("clickOperate 有宝箱奖励可以领取")
    elseif(lostRealmData.extraCount > 0) then 
        -- 有额外次数可以使用
        -- print("clickOperate 有额外次数可以丢")
    elseif(lostRealmData.rollCount < countTotalNum) then 
        -- 还有次数可以使用
        local costDiamond = mvc.festivalModel:getLostRealmCost()
        if(costDiamond > 0 ) then
            if GameDataManager:getInstance():getDiamond() < costDiamond then
                UI.TipsLayer:onDiamondNotEnough()
                return
            end

            local isNotice = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeDiamondLostRealm..GameDataManager:getInstance():getMasterPK(), true) 
            if isNotice then
                local LanguageManager = require("app.game.LanguageManager")
                self.confirmDialog = UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(LanguageManager:getInstance():getLocalString(1113914), function(isSelect)
                    self.confirmDialog = nil
                    if isSelect then
                        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeDiamondLostRealm..GameDataManager:getInstance():getMasterPK(), false)  
                    end
                    requestCallFunction()
                end, function(isSelect)
                    self.confirmDialog = nil
                end, nil, nil, true, costDiamond)
                return
            end
        end
    else
        isShowRandom = false
        return
    end

    requestCallFunction()
end

function LostRealmLayer:operateResult(data)
    -- print("LostRealmLayer:operateResult", data)
    self.operateData = data
    if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
        if(data.operateType == ProtobufUtil:enum_id("PlaySystem.LostRealmOperateType", "LostRealmOperateType_MoveForward")) then
            self.operateStepNum = data.moveStep
            self.randomAnimation:addAnimation(0, "idle", true)
            self.randomAnimation:addAnimation(0, "end", false)
            self:refreshBtnStatus(nil, true)
        else
            self.randomAnimation:setVisible(false)
            self.randomBG:setVisible(false)
            self.currentLayout:endCacheMode()
            self.shieldClick = false
            self:refreshBtnStatus()
        end
    else
        self.randomAnimation:setVisible(false)
        self.randomBG:setVisible(false)
        self.currentLayout:endCacheMode()
        self.shieldClick = false
        self:refreshBtnStatus()
    end
end

function LostRealmLayer:operateEnd()
    -- print("LostRealmLayer:operateEnd")
    -- print(debug.traceback())
    mvc.send(mvc.events.Festival_LostRealmRoleStartMove, self.operateData)
end

function LostRealmLayer:roleMoveEnd(worldPosition)
    -- print("LostRealmLayer:roleMoveEnd", worldPosition, self.operateData.extraCount)
    local rewardGoodsArr = {}
    for _,rewardData in pairs(self.operateData.rewards) do
        local goodsData = GoodsDataManager:createLocalGoodsData(rewardData.id)
        if (goodsData) then
            goodsData:setNum(rewardData.num)
            -- 这里默认给点金
            goodsData:setIsGolden(true)

            table.insert(rewardGoodsArr, goodsData)
        end
    end
    if(self.operateData.rewardMethod == 1) then
        local LanguageManager = require("app.game.LanguageManager")
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, nil, LanguageManager:getInstance():getLocalString(1111068), nil)
    else
        ToolsUtil:showGetGoodsScrollbar(rewardGoodsArr)
    end

    -- 触发
    if(self.operateData.extraCount > 0) then
        -- self:addCount(worldPosition, self.operateData.extraCount, function()
        --     self.shieldClick = false
        --     self:refreshBtnStatus()
        -- end)
        local LanguageManager = require("app.game.LanguageManager")
        UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1113917), self.operateData.extraCount))
        self.shieldClick = false
        self:refreshBtnStatus()
    else
        self.shieldClick = false
        self:refreshBtnStatus()
    end
    self.currentLayout:endCacheMode()
end

function LostRealmLayer:currentChange()
    self:refreshBtnStatus()
end
-- 注册监听事件
function LostRealmLayer:registerListener()
    --添加好友红点
    Avalon.MessageCenter:bind(GameMessage.MC_UI_LOSTREALM_OPERATE_RESULT, self, self.operateResult)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_LOSTREALM_ROLE_MOVE_END, self, self.roleMoveEnd)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.currentChange)
end


-- 注销监听事件
function LostRealmLayer:unRegisterListener()
    --添加好友红点
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_LOSTREALM_OPERATE_RESULT, self, self.operateResult)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_LOSTREALM_ROLE_MOVE_END, self, self.roleMoveEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.currentChange)
end
