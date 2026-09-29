-- FestivalSignOpenCell.lua
-- Author:
-- 
-- Using:七日计划cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local FestivalSignOpenCell = class("FestivalSignOpenCell", UI.ListGrid)
UI.FestivalSignOpenCell = FestivalSignOpenCell

local COM_WIDTH = 540
local COM_HEIGHT = 425
local TASK_ITEM_H = 71

--构造函数(必备)
function FestivalSignOpenCell:ctor(viewType)
    self._viewType = viewType
    FestivalSignOpenCell.super.ctor(self)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
end

--虚构函数,destroy时调用(必备)
function FestivalSignOpenCell:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    FestivalSignOpenCell.super.dtor(self)
end

-- 初始化(必备)
function FestivalSignOpenCell:init(data)
    self.totalPrg = 0
    self._data = data
    self.taskList = self._data.activityArr
    FestivalSignOpenCell.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function FestivalSignOpenCell:onInitView()
end

function FestivalSignOpenCell:getData()
    return self._data;
end

function FestivalSignOpenCell:isClickShowInfo()
    return true
end

function FestivalSignOpenCell:onUpdateView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    -- cellLayout:enableDebugDraw()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    self:initLeftPanel()
    self:initRightPanel()
end

function FestivalSignOpenCell:initLeftPanel()
    -- 左侧panel
    -- 左侧背景
    local bg = UI.Image:create()
    bg:init("ui_welfare_paper_01.png")
    bg:leftUp(0, 0)
    self.cellLayout:addChild(bg, 10)

    local goalData = mvc.festivalSignModel:getGoalData(self._viewType)
    local titleText = self._data.nameLocal and string.format(self._data.nameLocal, self._data.ID) or "Loading..."
    if (self._viewType == 4) then
        if (self._data.nameLocal) then
            titleText = self._data.nameLocal
        end
    else
        if self._data.ID == goalData.curStage then
            titleText = UI.TEXT_1213090
        elseif self._data.ID == goalData.curStage+1 then
            titleText = UI.TEXT_1213092
        end
    end

    local dayText  = UI.Text:create()
    dayText:init(titleText, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    dayText:centerUp(4);
    bg:addChild(dayText)
    self._dayText = dayText

    local centerLayout = UI.Layout:create()
    centerLayout:init()
    centerLayout:setSize(188, 287)
    centerLayout:centerUp(60)
    -- centerLayout:enableDebugDraw()
    bg:addChild(centerLayout)

    -- local bg2 = UI.Image:create()
    -- bg2:init("ui_guild_giftbag_bg.png")
    -- bg2:setScale(0.6)
    -- bg2:center()
    -- centerLayout:addChild(bg2)

    local rewardID = self._data.stageReward.id
    local rewardNum = self._data.stageReward.num
    local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)

    -- 奖励标题
    local descText1  = UI.Text:create()
    descText1:init(goodsData:getName(), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    descText1:setWidth(170)
    descText1:setTextHorizontalCenter()
    descText1:autoAdapt()
    descText1:centerUp(210)
    bg:addChild(descText1)

    -- 奖励描述内容
    local descText2  = UI.Text:create()
    descText2:init(goodsData:getDescription(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    descText2:centerUp(236)
    descText2:setTextCenter()
    descText2:setSize(170, 70)
    -- descText2:enableDebugDraw()
    bg:addChild(descText2)

    self.stageRewardLayout = centerLayout

    self:updateStageRewardShow()
end

function FestivalSignOpenCell:updateStageRewardShow()
    local rewardID = self._data.stageReward.id
    local rewardNum = self._data.stageReward.num
    local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)

    local innerLayout = UI.Layout:create()
    innerLayout:init()
    innerLayout:setSize(60, 60)
    innerLayout:centerUp(40)
    innerLayout:setName("innerLayout")
    self.stageRewardLayout:addChild(innerLayout)

    if self._data.stageRewardState then
        local edibledImage = UI.Image:create()
        edibledImage:init("ui_catfood_seal.png")
        edibledImage:centerUp(8)
        innerLayout:addChild(edibledImage)
    
        local edibled  = UI.Text:create()
        edibled:init(UI.TEXT_1110721, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
        edibled:setAnchorPoint(0.5, 0.5)
        edibled:rotate(15)
        edibled:centerUp(38)
        edibledImage:addChild(edibled, -1)
    else
        -- 物品物品图标
        goodsData:setNum(rewardNum)
        goodsData:setIsNew(false)
        goodsData.isHaveGet = false

        -- local frameImg = UI.Image:create()
        -- frameImg:init("box_quality_box_03.png")
        -- frameImg:center()
        -- innerLayout:addChild(frameImg)

        local goodsGrid = UI.GoodsGrid:create()
        -- goodsGrid:setScale(0.8)
        goodsGrid:centerUp(10)
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(false, false)
        goodsGrid:setBG("box_quality_box_03.png")
        if (rewardNum == 0) then
            goodsGrid:hideCountLabel()
        end
        innerLayout:addChild(goodsGrid)

        -- local btnEff = UI.Animation:create()
        local btnEff = UI.Image:create()
        -- btnEff:init("effect_ui_town_sevendays_buttom.json", "effect_ui_town_sevendays_buttom.atlas", 1);
        btnEff:init("ui_welfare_ticket_01.png")
        -- btnEff:leftBottom(96, -110)
        btnEff:leftBottom(0, -95)
        self.stageRewardLayout:addChild(btnEff, 100)
        -- btnEff:setAnimation("idle_task", true)
        self.btnEff = btnEff
    
        local btnLayout = UI.Layout:create()
        btnLayout:init()
        btnLayout:setSize(200, 60)
        btnLayout:centerBottom(-65)
        self.stageRewardLayout:addChild(btnLayout, 102)
        btnLayout:setTouchEnable(true)
        self.btnLayout = btnLayout
        btnLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            if self:getCurTaskPrg() < #self.taskList then
                UI.ScrollBar:createByText(UI.TEXT_1213113)
                return
            end
    
            self:getTaskFinalReward()
        end)
    
        local lingqu = UI.Text:create()
        lingqu:init(UI.TEXT_111035, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        lingqu:center()
        btnLayout:addChild(lingqu, 101)
        self.lingqu = lingqu
    end
end

function FestivalSignOpenCell:initRightPanel()
    -- 右侧背景
    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:setSize(356, COM_HEIGHT)
    rightLayout:leftUp(178, 0)
    self.cellLayout:addChild(rightLayout)

    local rightbg = UI.Image:create()
    rightbg:init("ui_sevendays_bg_paper_2.png")
    rightbg:leftUp(0, 0)
    rightLayout:addChild(rightbg)

    local shadow = UI.Image:create()
    shadow:init("ui_sevendays_shade_0.png")
    shadow:leftUp(0, 0)
    rightLayout:addChild(shadow)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(321, 1)
    splitLine:setCapInsets(CCRectMake(1,0,1,1))
    splitLine:setPosition(185, 388)
    rightLayout:addChild(splitLine)

    local todayTask  = UI.Text:create()
    local titleText = string.format(UI.TEXT_1213111, self._data.ID)
    local goalData = mvc.festivalSignModel:getGoalData(self._viewType)
    if self._data.ID == goalData.curStage then
        titleText = UI.TEXT_1213091
    end
    todayTask:init(titleText, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    todayTask:leftUp(36, 5)
    rightLayout:addChild(todayTask)

    local todayPrg  = UI.Text:create()
    todayPrg:init(UI.TEXT_1213100, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    todayPrg:rightUp(5, 5)
    todayPrg:setWidth(200)
    todayPrg:setTextRight()
    rightLayout:addChild(todayPrg)
    self.todayPrg = todayPrg

    local taskListLayout = UI.Layout:create()
    taskListLayout:init()
    taskListLayout:setSize(322, 376)
    taskListLayout:leftUp(25, 42)
    rightLayout:addChild(taskListLayout)
    self.taskListLayout = taskListLayout

    local offset = 0
    self.totalPrg = 0
    for k, v in ipairs(self.taskList) do
        self:insertTaskItem(taskListLayout, offset, k, v)
        offset = offset + TASK_ITEM_H + 5
    end
    self.todayPrg:setText(UI.TEXT_1213100 .. " " .. self.totalPrg .. "/" .. #self.taskList)
end

function FestivalSignOpenCell:insertTaskItem(rootLayer, offset, index, data)
    local itemLayout = UI.Layout:create()
    itemLayout:init()
    itemLayout:setSize(323, TASK_ITEM_H)
    itemLayout:centerUp(offset)
    itemLayout:setName("itemLayout"..index)
    rootLayer:addChild(itemLayout)

    -- local taskbg = UI.Image:create()
    local taskbg = UI.Image9:create()
    taskbg:init("ui_sevendays_taskbar.png",CCRectMake(1,1,1,1), cc.size(321, 68))
    -- taskbg:init("ui_sevendays_taskbar.png")
    taskbg:centerLeft(0)
    itemLayout:addChild(taskbg)

    -- 物品图标
    local innerLayout = UI.Layout:create()
    innerLayout:init()
    innerLayout:setSize(60, 60)
    innerLayout:centerLeft(5)
    itemLayout:addChild(innerLayout)

    local rewardID = data.rewardid[1]
    local rewardNum = data.rewardnum[1]
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:setScale(0.8)
    goodsGrid:center()
    local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)
    goodsData:setNum(rewardNum)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    if (rewardNum == 0) then
        goodsGrid:hideCountLabel()
    end
    innerLayout:addChild(goodsGrid)

    local descText  = UI.Text:create()
    descText:init(data.descLocal or "", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    descText:centerLeft(67)
    descText:setTextLeft()
    descText:setSize(152, 71)
    descText:setLineSpacing(-4)
    itemLayout:addChild(descText)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(1, 57)
    splitLine:setCapInsets(CCRectMake(1,0,1,1))
    splitLine:setPosition(225, 31)
    itemLayout:addChild(splitLine, 10)

    self:updateTaskStateShow(itemLayout, data, index)
end

function FestivalSignOpenCell:updateTaskStateShow(rootLayer, data, index)
    local stateLayout = UI.Layout:create()
    stateLayout:init()
    stateLayout:setSize(100, 60)
    stateLayout:centerRight(0)
    -- stateLayout:enableDebugDraw()
    stateLayout:setName("stateLayout")
    rootLayer:addChild(stateLayout)

    if (data.stat == 0) then
        -- 未开启
        -- UI上不会显示出此类任务，所以不用处理
    elseif (data.stat == 1) then
        -- 进行中
        local displayCount = data.count > data.targetAmount and data.targetAmount or data.count
        local displayTotalCount = data.targetAmount
        if displayTotalCount == 0 then
            displayTotalCount = 1
        end
        local prgText  = UI.Text:create()
        prgText:init(displayCount .. "/" .. displayTotalCount, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
        prgText:setTextCenter()
        prgText:center()
        local maxWidth = 92
        if(prgText:getContentSize().width > maxWidth) then 
            prgText:setFixLineWidth(maxWidth)
        end
        stateLayout:addChild(prgText)
    elseif (data.stat == 2) then
        -- 可领奖
        local btn = UI.Button:create();
        btn:init("ui_btn_chat_0.png","ui_btn_chat_1.png","ui_btn_chat_2.png");
        btn:setText(data.buttonText)
        btn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        btn:center();
        btn.btnIndex = index
        btn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            self:getTaskReward(btn.btnIndex)
        end)
        stateLayout:addChild(btn)
        self.totalPrg = self.totalPrg+1
    elseif (data.stat == 3) then
        -- 已领奖
        local gotbg = UI.Image:create()
        gotbg:init("ui_sevendays_received.png")
        gotbg:center()
        gotbg:rotate(-7)
        stateLayout:addChild(gotbg)
    
        local gotText  = UI.Text:create()
        gotText:init(UI.TEXT_1110721, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71)
        gotText:centerUp(6)
        gotbg:addChild(gotText)
        self.totalPrg = self.totalPrg+1
    elseif (data.stat == 4) then
        -- 已过期
        -- 配置上已杜绝此状态，此处不处理
    end
end

function FestivalSignOpenCell:getTaskReward(taskIndex)
    -- 检查是否能够领取奖励
    if (not mvc.festivalSignModel:isAbleToGetReward()) then
        UI.ScrollBar:createByTextID(1111316)
        return
    end

    self.curTaskInfo = self.taskList[taskIndex]
    self.curTaskRewardIndex = taskIndex

    -- 检查背包格数
    local goodsArr = {}
    local taskRewards = self.curTaskInfo.rewardid
    local taskRewardNum = self.curTaskInfo.rewardnum
    for k, v in ipairs(taskRewards) do
        local data = {}
        data.goodsID = v
        data.num = taskRewardNum[k]
        data.isGolden = true
        table.insert(goodsArr, data)
    end

    -- 背包检查合格, 请求获取奖励; 不合格, 提示
    if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)) then
        self.isGetTaskReward = true
        Net.NetRoleSystem:requestGoalReward(self.curTaskInfo.goalID, self.curTaskInfo.stageID, self.curTaskInfo.ID)
    else
        UI.ScrollBar:createByTextID(1170081)
    end
end

function FestivalSignOpenCell:getTaskFinalReward()
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
        self.isGetTaskFinalReward = true
        Net.NetRoleSystem:requestGoalReward(self._data.goalID, self._data.ID, 0)
    else
        UI.ScrollBar:createByTextID(1170081)
    end
end

function FestivalSignOpenCell:getRewardResp(data)
    if self.isGetTaskReward then
        self.isGetTaskReward = false
        local l = self.taskListLayout:getChildByName("itemLayout"..self.curTaskRewardIndex)
        l:removeChildByName("stateLayout")
        self:updateTaskStateShow(l, self.taskList[self.curTaskRewardIndex], self.curTaskRewardIndex)
    end

    if self.isGetTaskFinalReward then
        self.isGetTaskFinalReward = false

        -- self.btnEff:setAnimation("trigger_task", false)
        self.btnEff:removeFromParent()
        self.lingqu:hide()
        self.btnLayout:setTouchEnable(false)

        self.stageRewardLayout:removeChildByName("innerLayout")
        self:updateStageRewardShow()
    end
end

function FestivalSignOpenCell:popRewards(rewards)
    local itemData = {}
    for k, v in pairs(rewards) do
        local goodData = GoodsDataManager:createLocalGoodsData(v.id)
        if(goodData) then
            goodData:setIsNew(false)
            goodData:setNum(v.num)
            table.insert(itemData, goodData)
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, nil, nil, nil, true)
end

function FestivalSignOpenCell:getCurTaskPrg()
    local finNum = 0
    for _, task in ipairs(self.taskList) do
        if task.stat > 1 then
            finNum = finNum+1
        end
    end
    return finNum
end