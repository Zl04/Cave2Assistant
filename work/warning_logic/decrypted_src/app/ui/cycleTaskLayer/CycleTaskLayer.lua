-- CycleTaskLayer.lua
-- Author:zp
-- 2018年12月28日
-- Using:环形任务界面
require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.cycleTaskLayer.CollectTaskCell"
local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local CycleTaskLayer = class("CycleTaskLayer", UI.DoorWin)
UI.CycleTaskLayer = CycleTaskLayer
local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(373, 630)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_upgrade.plist",
    "ui_general_comment.plist",
    "ui_common_npcIcon.plist",
}

local GridType = {
    equip = 1,
    gem = 2
}

local GEM_KUANG_NUM = 4

--构造函数(必备)
function CycleTaskLayer:ctor(spriteID, taskData)
    --窗口大小
    CycleTaskLayer.super.ctor(
    self,UIType.CYCLE_TASK_LAYER,
    COM_RES_LIST,
    leftSize.width,    
    winSize.height
    )

    -- local taskData = Data.TaskData:create(60007)
    -- taskData.status = PublicDefine.TaskStatus.TaskStatus_IsFinish

    self.spriteID = spriteID
    self._taskData = taskData
    self.rewardItems = {}

    -- 收集当前的列表值
    self.collectNowArr = {} 
    -- 收集需要提交的值
    self.collectSubmitArr = {}

    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function CycleTaskLayer:dtor()
    CycleTaskLayer.super.dtor(self)
    self.rewardItems = nil

    self:unRegisterListener()
end

-- 初始化(必备)
function CycleTaskLayer:init()
    self:refreshCollectData()
    CycleTaskLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function CycleTaskLayer:onInitView()
    self.leftLayer = UI.Layout:create();
    self.leftLayer:init()
    self.leftLayer:setSize(leftSize.width, leftSize.height)
    self.leftLayer:leftBottom(-winSize.width, (winSize.height - leftSize.height) / 2)
    self:addChild(self.leftLayer, 3)
    
    --背景
    local bg = UI.Image:create()
    bg:init("ui_upgrade_paper_02.png")
    bg:centerBottom(0)
    self.leftLayer:addChild(bg)
    self._bg = bg

    self:initTask(bg)

    -- 底部按钮状态
    self._handleButton = UI.Button:create()
    self._handleButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    self._handleButton:setText("") --"激活"
    self._handleButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._handleButton:leftBottom(85, 24)
    self._handleButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if(self._taskData:getIsFinish()) then 
            self:sendCompleteTask()
        else 
            if(self._taskData:getTargetType() == PublicDefine.TaskTargetType.Collect) then 
                self:sendCompleteTask()
                -- UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                -- -- 这里和策划
                -- -- Net.NetTaskSystem:submitTaskCollect(self._taskData:getId(), self.collectSubmitArr)

                -- Net.NetTaskSystem:submitTaskRequest(self._taskData:getId())
            end
        end 
    end)
    bg:addChild(self._handleButton)
    self._handleButton:disable()

    self:refreshButtion()


    -- 右边背包数据
    local bagList = UI.BagGoodsPanel:create(nil,true,false)
    bagList:init(self.spriteID, GameBagUIType.NORMAL)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

    self._bagGridList = bagList
    self:addChild(bagList,2)
    bagList:setUseLock(false)
end

function CycleTaskLayer:sendCompleteTask()
    if(self._taskData == nil) then 
        return 
    end

    -- body
    local goodsArr = {}
    local rewardGoodsArr = self._taskData:getRewardGoodsArr()
    for k,goods in pairs(rewardGoodsArr) do
        local data = {}
        data.goodsID = goods.goodsID
        data.num = goods.num
        data.isGolden = true--goods.isGolden
        table.insert(goodsArr, data)
    end
        -- 判断背包是否满了
    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if not enough then   
        UI.ScrollBar:createByTextID(1110793)
        return
    end
    if self._taskData:checkIsLockCollectItem() then
        UI.ScrollBar:createByTextID(1170266)
        return
    end
    self._handleButton:disable()
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetTaskSystem:submitTaskRequest(self._taskData:getId())
end

function CycleTaskLayer:refreshButtion() 
    if(self._taskData:getTargetType() == PublicDefine.TaskTargetType.Kill 
        or self._taskData:getTargetType() == PublicDefine.TaskTargetType.Talk
        or self._taskData:getTargetType() == PublicDefine.TaskTargetType.Achievement) then 
        self._handleButton:setText(UI.TEXT_111035) -- 领取
        if(self._taskData:getIsFinish()) then
            self._handleButton:enable()
        else 
            self._handleButton:disable()
        end
    elseif (self._taskData:getTargetType() == PublicDefine.TaskTargetType.Collect) then
        print("CycleTaskLayer:refreshButtion", self._taskData:getId(), self._taskData:getIsFinish(), self._taskData.status, self._taskData:_checkAchievementIsFinish())
        if(self._taskData:getIsFinish()) then
            self._handleButton:setText(UI.TEXT_111035) 
            self._handleButton:enable()
        else 
            -- 判断是否已经拖动了物品到界面上面或者说是否有可以收集的物品可以提交
            local haveSubmit = true
            for k, v in ipairs(self.collectNowArr) do 
                if(v.reachNum + v.collectNum < v.goodsNum) then 
                    haveSubmit = false
                    break
                end
            end

            self._handleButton:setText(UI.TEXT_1212071) 
            if(haveSubmit) then 
                self._handleButton:enable()
            else
                self._handleButton:disable()
            end
        end
    end
end 

function CycleTaskLayer:initTask(bg, change)
    if(not tolua.isnull(self.upBg)) then 
        self.upBg:removeAllChildren(false)
    end
    if(change == nil) then 
        change = false
    end

    -- 底部背景
    local upBg = UI.Image:create()
    upBg:init("ui_upgrade_paper_01.png")
    upBg:leftUp(16, 14)
    if(change)then 
        upBg:setOpacity(0)
        upBg:runAction(cc.FadeIn:create(1))
    end

    bg:addChild(upBg)
    self.upBg = upBg

    -- 根据类型初始化相关的界面
    local titleTxt = UI.Text:create()
    titleTxt:init(self._taskData:getName(), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    titleTxt:leftUp(84, 33 - titleTxt:getContentSize().height/2)
    upBg:addChild(titleTxt)

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(312, 2))
    splitLine:centerUp(57)
    upBg:addChild(splitLine)

    -- 
    local upLayout = UI.Layout:create()
    upLayout:init()
    upLayout:setSize(350, 0)
    upLayout:centerUp(346)
    upBg:addChild(upLayout)

    -- print("CycleTaskLayer:initTask ", self._taskData:getTargetType(), PublicDefine.TaskTargetType.Kill, PublicDefine.TaskTargetType.Talk)
    if(self._taskData:getTargetType() == PublicDefine.TaskTargetType.Kill 
        or self._taskData:getTargetType() == PublicDefine.TaskTargetType.Talk
        or self._taskData:getTargetType() == PublicDefine.TaskTargetType.Achievement) then 
        
        local iconBg = UI.Image:create()
        iconBg:init("ui_upgrade_black.png")
        iconBg:centerBottom(46)
        upLayout:addChild(iconBg, 100)
        -- 添加表现
        if(self._taskData:getTargetType() == PublicDefine.TaskTargetType.Kill 
            or self._taskData:getTargetType() == PublicDefine.TaskTargetType.Achievement) then 
            -- targetID
            local templateID = self._taskData:getTargetID()
            if(self._taskData:getTargetType() == PublicDefine.TaskTargetType.Achievement) then 
                -- 读取成就的数据
                local achevementData = ConfigManager:getAchievement(templateID)
                if(achevementData) then 
                    -- print(":getAchevementData( =", templateID,achevementData)
                    templateID = achevementData.targetID

                    if(templateID >= MONSTER_MAX_ID) then 
                        templateID = string.sub(templateID, 3)
                    end
                end
            else
                if(templateID >= MONSTER_MAX_ID) then 
                    templateID = string.sub(templateID, 3)
                end
            end

            local clipper = cc.ClippingNode:create(cc.Sprite:createWithSpriteFrameName("ui_upgrade_line.png"))
            clipper:setPosition(294/2, 243/2)
            clipper:setAnchorPoint(0.5, 0)
            -- clipper:setAlphaThreshold(0.05)
            iconBg:addChild(clipper)

            local node = UI.Layout:create()
            node:init()
            node:centerBottom(-121.5)
            node:setSize(294, 243)
            clipper:addChild(node)

            local monsterData = RoleDataManager:createLocalMonsterDataForAllConfig(templateID)
            if(monsterData)then
                local taskSpine = UI.Animation:create()
                taskSpine:init(monsterData.spine..".json", monsterData.spine..".atlas", 1.0)
                taskSpine:setAnimation("idle1", true)
                taskSpine:updateTime(0.2)
                taskSpine:setTimeScale(0)
                
                local npcScale = self._taskData:getNpcScale()
                if(npcScale) then 
                    taskSpine:setScale(npcScale)
                end
                local offsetArr = self._taskData:getOffSet()
                if(offsetArr and #offsetArr == 2) then 
                    taskSpine:leftBottom(294/2 + offsetArr[1], 40 + offsetArr[2])
                else
                    taskSpine:leftBottom(294/2, 40)
                end
                node:addChild(taskSpine)
            end
        elseif(self._taskData:getTargetType() == PublicDefine.TaskTargetType.Talk) then 
            local triggerData = RoleDataManager:createLocalTriggerNpcData(self._taskData:getTargetID())
            if(triggerData) then 
                -- local npcIconSpriteName = "ui_comment_banner_npc13.png"
                local npcIconSpriteName = triggerData:getBust()
                if(npcIconSpriteName and npcIconSpriteName ~= "") then 
                    local taskImage = UI.Image:create()
                    taskImage:init(npcIconSpriteName..".png")
                    taskImage:centerBottom(0)
                    taskImage:setAnchorPoint(0.5, 0)
                    iconBg:addChild(taskImage)

                    local maxHeight = 230
                    if(taskImage:getContentSize().height > maxHeight) then 
                        taskImage:setScale(maxHeight / taskImage:getContentSize().height)
                    end
                end
            end
        end

        
        local reachNum = self._taskData:getReachNum()
        local targetNum = self._taskData:getTargetNum()
        if(self._taskData:getTargetType() == PublicDefine.TaskTargetType.Achievement) then 
            if(self._taskData:getIsFinish()) then 
                reachNum = targetNum
            end
        end

        -- 进度表现        
        local progressLeftTxt = UI.Text:create()
        progressLeftTxt:init(UI.TEXT_1212060, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
        progressLeftTxt:leftBottom(43, 21 - progressLeftTxt:getContentSize().height/2)
        upLayout:addChild(progressLeftTxt)

        local progressRightTxt = UI.Text:create()
        progressRightTxt:init(string.format("%s/%s", reachNum, targetNum), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
        progressRightTxt:rightBottom(24, 21 - progressRightTxt:getContentSize().height/2)
        upLayout:addChild(progressRightTxt)

        if(reachNum >= targetNum) then 
            progressLeftTxt:setFontColor(UI.FONT_COLOR_36_181_118)
            progressRightTxt:setFontColor(UI.FONT_COLOR_36_181_118)
        end

        local scaleMax = 0.5
        local progressBg = UI.Image:create()
        progressBg:init("ui_upgrade_ash.png")
        progressBg:leftBottom(39 + progressBg:getContentSize().width * scaleMax/2, 0)
        progressBg:setScaleX(1+ scaleMax)
        upLayout:addChild(progressBg)

        local percent = 0
        if(targetNum > 0) then 
            percent = reachNum*100/targetNum
        end
        local progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_upgrade_yellow.png"))
        progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        progress:setMidpoint(cc.p(0, 0))
        progress:setBarChangeRate(cc.p(1, 0))
        progress:setPercentage(percent)
        progress:setPosition(95.5, 3)
        progressBg:addChild(progress)
        self._progress = progress
    elseif (self._taskData:getTargetType() == PublicDefine.TaskTargetType.Collect) then
        self._tableView = UI.TableView.new({}, 280,280)
        self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
        self._tableView:centerBottom(5)
        self._tableView:setDelegate()
        self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
        self._tableView:setBounceable(true) 
        self._tableView:init()
        self._tableView:onUpdateCellSize(function (table,idx)

            return 280,88
        end) 

        self._tableView:onUpdateCells(function (table, idx)
            -- print("_tableView:onUpdateCells table ,idx", table, idx)
            local cell = table:dequeueCell()
            xpcall(function()
                cell = UI.CollectTaskCell.new()
                cell:init(self.collectNowArr[idx + 1], self._tableView)
            end, 
            function(e) 
                printError("------------------------ActivityPanel:tableCellAtIndex-----------------error")
            end, 1) 
            
            return cell
        end)
        self._tableView:onUpdateCellNumbers(function ()
            -- print("onUpdateCellNumbers =", self.collectNowArr)
            return table.nums(self.collectNowArr) 
        end)
        self._tableView:onTableCellTouched(function(table, cell)
            
        end)
        self._tableView:reloadData()
        upLayout:addChild(self._tableView, 10)

        local mesh = UI.Image:create()
        mesh:init("ui_upgrade_gradually_03.png")
        mesh:centerBottom(-4)
        upLayout:addChild(mesh, 10)

        local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        splitLine:setContentSize(292, 1)
        splitLine:setCapInsets(CCRectMake(1,0,1,1))
        splitLine:setAnchorPoint(0, 0)
        splitLine:setPosition(29, -2)
        upLayout:addChild(splitLine)
    end

    -- 显示下半部分的描述文字
    -- 滑动信息展示区域
    local maxHeight = 120
    local rewardLayout = UI.TouchLayout:create()
    rewardLayout:init(0, 0, 0, 0)
    rewardLayout:setSize(293, maxHeight)
    rewardLayout:addTouchEvents(self)

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(293, maxHeight)
    scrollView:init()
    scrollView:leftBottom(28, 74)
    scrollView:addInnerNode(rewardLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    upBg:addChild(scrollView, 10)
    self._taskScrollView = scrollView

    --奖励    
    local height = 0
    local goodsData = self._taskData:getRewardGoodsArr()
    size = #goodsData

    height = math.floor(size/3) * 80
    if(size%3 ~= 0) then 
        height = height + 80
    end
    
    local beginPosX = 10
    local beginPosY = 10
    local itemPadding = 80
    local addIndex = 0
    for i = 1, size do
        if(addIndex == 3) then 
            beginPosY = beginPosY + 80
            addIndex = 0
        end

        local goodData = goodsData[i]
        goodData:setIsNew(false)
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        goodGrid:setInfoArea(true, false)
        goodGrid:leftUp(beginPosX, beginPosY)
        beginPosX = beginPosX + itemPadding
        rewardLayout:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        goodGrid:showCountLabel()
        table.insert(self.rewardItems, goodGrid)
        -- goodGrid:enableDebugDraw()
        addIndex = addIndex + 1
    end

    local textStr = self._taskData:getStory()
    local desTxt = UI.Text:create()
    desTxt:init(textStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    desTxt:setWidth(265)
    -- desTxt:setTextHorizontalCenterAndBottom()
    desTxt:centerUp(height)
    desTxt:autoAdapt()
    rewardLayout:addChild(desTxt)

    height = height + desTxt:getContentSize().height + 15
    if(height > maxHeight) then 
        rewardLayout:setSize(293, height)
    end
    print("height, description=", height, self._taskData:getDescription())

    --
    local mesh = UI.Image:create()
    mesh:init("ui_upgrade_gradually_01.png")
    mesh:leftBottom(28, 73)
    upBg:addChild(mesh, 10)

    -- 左上角的icon 
    local leftUpImage = UI.Image:create()
    leftUpImage:init("ui_information_upgrade.png")
    leftUpImage:leftUp(10, -4)
    upBg:addChild(leftUpImage, 100)
end

function CycleTaskLayer:onTouchBegan(touch, event)
    -- print("--------------------------QuickExpressionLayer onTouchBegan")
    -- self.selectIndex = 0
    -- local location = touch:getLocation()
    -- self.beginTouchPosition = location

    -- --检查是否在可点击区域 邮件活动区域
    -- if not AvalonUtil:isRectContainsPoint(self._taskScrollView, location) then
    --     return
    -- end 

    -- for k, value in ipairs(self.rewardItems) do
    --     if AvalonUtil:isRectContainsPoint(value, location) then
    --         self.selectIndex = k
    --         break
    --     end
    -- end
end

function CycleTaskLayer:onTouchEnded(touch, event)
    -- local location = touch:getLocation()
    -- if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
    --     return
    -- end 

    --  --检查是否在可点击区域 邮件活动区域
    -- if not AvalonUtil:isRectContainsPoint(self._taskScrollView, location) then
    --     return
    -- end

    -- for k, value in ipairs(self.rewardItems) do
    --     if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
    --         value:onShowInfoAreaHandler(true)
    --         break
    --     end
    -- end
end

function CycleTaskLayer:bagDragBeganCallback(grid, touchPosition)
    -- if(grid) then
    --     grid:hideSelect()
    -- end

    -- local goodsData = grid:getData()
    -- if(goodsData == nil) then 
    --     return 
    -- end
end

function CycleTaskLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    -- if(self._bagGridList) then
    --     self._bagGridList:hideMove()
    --     self._bagGridList:setSpineBgVisible(false)
    -- end
    -- local goodsData = grid:getData()
    -- if(goodsData == nil) then 
    --     return 
    -- end
end 

-- 模版函数：更新组建的视图(必备)
function CycleTaskLayer:onUpdateView(data)
    if(data) then
        self._taskData = data
    end

    self:setDoorNode(self.leftLayer, self._bagGridList)
end

function CycleTaskLayer:completeTask(completeData)
    UI.WaitingLayer:hideWaiting()
    -- print("completeData =", completeData)
    -- local completeTask = completeData.completeTask
    -- print("CycleTaskLayer:completeTask 1", completeTask:getId(), self._taskData:getId())
    -- if(completeTask and completeTask:getId() == self._taskData:getId()) then
    --     print("CycleTaskLayer:completeTask 2")
    --     -- 判断是否也为当前NPC的数据

    -- else 

    -- end

    local accepteTask = completeData.accepteTask
    if(accepteTask and accepteTask:getCompleteNPCID() == self._taskData:getCompleteNPCID()) then 
        print("CycleTaskLayer:completeTask 3")
        self._taskData = accepteTask
        self:refreshCollectData()
        -- 刷新当前页面信息
        self:initTask(self._bg, true)
        self:refreshButtion()
    else
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_UPGRADE_SKILL, self.spriteID)
        self:closeWin()
    end 
end

function CycleTaskLayer:collectResult(data) 
    UI.WaitingLayer:hideWaiting()
    if(data.result == ProtobufUtil:enum_id("TaskSystem.DoCollectTaskResultType", "DoCollectTaskResultType_Suc")) then
        self:refreshCollectData()
        -- 刷新当前页面信息
        self:initTask(self._bg)
    end
    self:refreshButtion()
end

function CycleTaskLayer:goodsChange() 
    self:refreshCollectData()
    -- 刷新当前页面信息
    self:initTask(self._bg)
end

-- 注册监听事件(可选)
function CycleTaskLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.completeTask)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_COLLECT_RESULT, self, self.collectResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, self.goodsChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, self.goodsChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE, self, self.goodsChange)
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, self.goodsChange)
end

-- 注销监听事件(可选)
function CycleTaskLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.completeTask)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_COLLECT_RESULT, self, self.collectResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, self.goodsChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, self.goodsChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE, self, self.goodsChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, self.goodsChange)
end

function CycleTaskLayer:refreshCollectData()
    self.collectNowArr = {}
    self.collectSubmitArr = {}

    if(self._taskData:getTargetType() == PublicDefine.TaskTargetType.Collect) then 
        local collectArr = self._taskData:getCollectArr()
        if(collectArr) then 
            for k,v in ipairs(collectArr) do 
                local oneData = {}
                oneData.goodsID = tonumber(v.goodsIDArr[1])
                oneData.reachNum = 0

                local chaNum = v.goodsNum - v.reachNum
                -- print("CycleTaskLayer:refreshCollectData 1", chaNum)
                if(chaNum > 0) then 
                    local goodsIDArr = v.goodsIDArr
                    for _, goodsID in ipairs(goodsIDArr) do 
                        local haveNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(goodsID), true)
                        -- print("CycleTaskLayer:refreshCollectData 1.1", goodsID, haveNum)
                        if(haveNum >0) then
                            oneData.goodsID = tonumber(goodsID)
                            chaNum = chaNum > haveNum and haveNum or chaNum
                            oneData.reachNum = chaNum
                            break
                        end
                    end
                end 
                -- print("CycleTaskLayer:refreshCollectData 1.5", oneData)
                table.insert(self.collectSubmitArr, oneData)

                local nowData = {}
                nowData.goodsID = oneData.goodsID
                -- 将要捐献的数量
                nowData.collectNum = oneData.reachNum
                -- 已经捐献的数量
                nowData.reachNum = v.reachNum
                -- 需要收集的数量
                nowData.goodsNum = v.goodsNum

                table.insert(self.collectNowArr, nowData)
                -- print("CycleTaskLayer:refreshCollectData  2", self.collectNowArr)
            end 
        end
    end
end

function CycleTaskLayer:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_ITEM
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList, _usedType1)

    local _usedType2 = {}
    _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    _usedType2.type = 0
    table.insert(usedTypeList, _usedType2)

    local _usedType3 = {}
    _usedType3.goodType = PublicDefine.GOODS_TYPE.GOODS_GEM_STONE
    _usedType3.type = 0
    table.insert(usedTypeList, _usedType3)

    return usedTypeList
end