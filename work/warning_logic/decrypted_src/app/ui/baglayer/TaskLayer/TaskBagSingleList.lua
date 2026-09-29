--[[
    --任务界面的单个列表UI控件
    AHTHOR:CZH
]]


require "app.ui.Component"
require "app.ui.baglayer.TaskLayer.TaskAwardList"
UI = UI or {}

local TaskBagSingleList = class("TaskBagSingleList", UI.HWBtnComponent)
UI.TaskBagSingleList = TaskBagSingleList
local winSize = cc.Director:getInstance():getWinSize()
local GameDataManager = require("app.game.GameDataManager")
local scheduler = cc.Director:getInstance():getScheduler()
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
local GameMapManager = require("app.game.GameMapManager")
local DEBUG = false
local DEBUG_DRAW = true
local resList = {
}
-- 领取奖励的动画
local SEAL_JSON  = "effect_ui_common_stamp_rect_green.json"
local SEAL_ATLAS = "effect_ui_common_stamp_rect_green.atlas"

UI.TASK_TYPE = {
    ACTIVITY_TASK = 1, -- 活动任务
    DAYTODAY_TASK = 2, -- 日常任务
    MAINLINE_TASK = 3, -- 主线任务
    GUILD_TASK = 4,    -- 公会任务
    HREO_TASK = 5,    -- 英雄模式任务
    CYCLE_TASK = 6,    -- 环形任务
    LIMIT_DAILY_TASK = 7,    -- 每日限量
    DISTORTED_SPACE_TASK = 8,    -- 扭曲空间
    VOIDRIFT = 10,      -- 虚空秘境
    BIGSAILPORT = 13,      -- 大航海港口
}
local task_type = UI.TASK_TYPE 
function TaskBagSingleList:ctor(width, height, cellIdx)
    TaskBagSingleList.super.ctor(self, UIType.TASK_BAG_SINGLE_LIST, resList, width, height)
    self._taskType = nil    -- 任务类型
    self._data = nil        -- 任务数据
    self._taskLayerType = nil       -- 任务界面类型 背包里的任务界面或者城镇的背包界面
    self._taskScrollView = nil       -- 显示道具详情的LAYER
    self.schedulerID = nil
    self.parentLayer = nil
    self.rewardItems = {}
    self.cellIdx = cellIdx
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.remove) 
    -- self:enableDebugDraw()
end

function TaskBagSingleList:dtor()
    TaskBagSingleList.super.dtor(self)  
    self._taskType = nil    -- 任务类型
    self._taskLayerType = nil       -- 任务界面类型 背包里的任务界面或者城镇的背包界面
    self._taskScrollView = nil       -- 显示道具详情的LAYER
    self._data = nil 
    self.rewardItems = {}
    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    if self.parentLayer and self.parentLayer.setCanClickTableView then
        self.parentLayer:setCanClickTableView(true, false)
    end
    self.parentLayer = nil
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.remove)   
end

function TaskBagSingleList:init(taskdata,taskScrollView,taskLayerType)
    self._taskScrollView = taskScrollView
    self._taskLayerType = taskLayerType
    self:resetData(taskdata)
    TaskBagSingleList.super.init(self)
end


function TaskBagSingleList:resetData(newTask)
    self._data = newTask 
    self:removeAllChildren(true)
    self._finishedAnimal = nil
    self.rewardItems = {}
    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    if(self._data:isThread()) then     -- 主线任务
        self._taskType = UI.TASK_TYPE.MAINLINE_TASK
    elseif(self._data:isDaily()) then  -- 日常任务  
        self._taskType = UI.TASK_TYPE.DAYTODAY_TASK
    elseif(self._data:isGuild()) then  -- 公会任务  
        self._taskType = UI.TASK_TYPE.GUILD_TASK
    elseif (self._data:isHeroCave()) then
        self._taskType = UI.TASK_TYPE.HREO_TASK
    elseif (self._data:isCycle()) then
        self._taskType = UI.TASK_TYPE.CYCLE_TASK
    elseif (self._data:isLimitDaily()) then
        self._taskType = UI.TASK_TYPE.LIMIT_DAILY_TASK
    elseif (self._data:isDistortedSpace()) then
        self._taskType = UI.TASK_TYPE.DISTORTED_SPACE_TASK
    elseif (self._data:isInferno()) then
        self._taskType = UI.TASK_TYPE.INFERNO
    elseif (self._data:isVoidRift()) then
        self._taskType = UI.TASK_TYPE.VOIDRIFT
    elseif (self._data:isBigSailPort()) then
        self._taskType = UI.TASK_TYPE.BIGSAILPORT
    -- elseif (self._data:isWormhole()) then
    --     self._taskType = UI.TASK_TYPE.WORMHOLE
    end 

    if self._taskType == UI.TASK_TYPE.DAYTODAY_TASK then
        self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 1, false)
    end
    self:setFinishAnimalFalse()
    self:setDoingAnimalFalse()
    if self._data.canPlayFinish then
        self:setFinishAnimalTrue()
        self._data.canPlayFinish = false
    elseif self._data:getTargetType() == PublicDefine.TaskTargetType.Follow then

    elseif self._data:isNormalState() then
        self:setDoingAnimalTrue()
    end
end

function TaskBagSingleList:update(dt)
    if self.refreshTime ~= nil then
        self:refreshTime()
    end
end

function TaskBagSingleList:onInitView(data)
    
end

function TaskBagSingleList:onUpdateView()
    local taskdata = self._data
    local iconImgName = "ui_task_icon_books.png"
    local tileBgImgName = "ui_task_banner_books.png"
    local iconScale = 1
    if (self._taskType == task_type.HREO_TASK) then -- 活动任务
        iconImgName = "ui_task_icon_notebook.png"
    elseif (self._taskType == task_type.MAINLINE_TASK) then -- 主线任务
        iconImgName = "ui_task_icon_books.png"
    elseif (self._taskType == task_type.DAYTODAY_TASK or self._taskType == task_type.ACTIVITY_TASK) then -- 日常任务
        iconImgName = "ui_task_icon_volume.png"
    elseif (self._taskType == task_type.GUILD_TASK) then -- 公会任务
        iconImgName = "ui_task_icon_paper.png"
    elseif (self._taskType == task_type.CYCLE_TASK) then -- 循环任务
        -- add by zp 修改了功能
        iconImgName = "ui_information_upgrade.png"
        iconScale = 0.8
    elseif (self._taskType == task_type.LIMIT_DAILY_TASK) then
        iconImgName = "ui_task_icon_limited.png"
    elseif (self._taskType == task_type.DISTORTED_SPACE_TASK) then
        iconImgName = "ui_information_upgrade.png"
        iconScale = 0.8
    elseif (self._taskType == task_type.BIGSAILPORT) then
        iconImgName = "ui_task_icon_books.png"
    end  

    local icon = UI.Image:create()
    icon:init(iconImgName)
    icon:setAnchorPoint(0, 1)
    icon:setScale(iconScale)
    icon:leftUp(18, 3)
    self:addChild(icon, 1)

    local tileBg = UI.Image:create()
    tileBg:init(tileBgImgName)
    tileBg:leftUp(40, 10)
    self:addChild(tileBg)

    local taskTypeStr = ""

    if(self._taskType == task_type.DAYTODAY_TASK) then 
        taskTypeStr = LanguageManager:getInstance():getLocalString(1122032)
    elseif(self._taskType == task_type.MAINLINE_TASK) then 
        taskTypeStr = LanguageManager:getInstance():getLocalString(1122031)
    elseif(self._taskType == task_type.GUILD_TASK) then 
        taskTypeStr = LanguageManager:getInstance():getLocalString(1122033)
    elseif(self._taskType == task_type.HREO_TASK) then 
        taskTypeStr = LanguageManager:getInstance():getLocalString(1122034)
    elseif(self._taskType == task_type.CYCLE_TASK) then 
        taskTypeStr = LanguageManager:getInstance():getLocalString(1122035)
    elseif(self._taskType == task_type.LIMIT_DAILY_TASK) then 
        taskTypeStr = LanguageManager:getInstance():getLocalString(1111869)
    elseif(self._taskType == task_type.DISTORTED_SPACE_TASK) then 
        taskTypeStr = LanguageManager:getInstance():getLocalString(1122068)
    elseif(self._taskType == task_type.BIGSAILPORT) then 
    end 

    local taskTitle = UI.Text:create()
    taskTitle:init(taskTypeStr .. taskdata:getName(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    taskTitle:centerLeft(32)
    tileBg:addChild(taskTitle)

    taskContent = UI.Text:create()
    taskContent:init(taskdata:getDescription(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    taskContent:leftUp(81,48)
    self:addChild(taskContent)
    local maxContent = 280
    if(taskContent:getContentSize().width > maxContent) then 
        taskContent:setAnchorPoint(0, 0.5)
        taskContent:setScale(maxContent/taskContent:getContentSize().width)
    end

    taskStory = UI.Text:create()
    taskStory:init(taskdata:getStory(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    taskStory:leftUp(33,72)
    if(taskStory:getContentSize().width > 370 * 3) then 
        local str = AvalonUtil:getSubNameStr(taskdata:getStory(), 1080, UI.FONT_SIZE_16PX, true)
        taskStory:setText(str)
    end
    taskStory:setSize(370, 60)
    taskStory:setTextLeft()
    self:addChild(taskStory)
    taskStory:setLineSpacing(-4)

    -- 任务数量完成值
    local finishedTaskNumText = UI.Text:create()
    finishedTaskNumText:init("1111/1111", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    finishedTaskNumText:rightUp(434, 48)
    self._finishedTaskNumText = finishedTaskNumText
    self:addChild(finishedTaskNumText)

    -- 已经完成的背景
    local finishedTaskBg = UI.Image:create()
    finishedTaskBg:init("ui_information_banner_receive.png")
    finishedTaskBg:rightUp(18,40)
    finishedTaskBg:hide()
    self:addChild(finishedTaskBg)
    self._finishedTaskBg = finishedTaskBg
    -- 已完成文字
    local finishedTaskText = UI.Text:create()  
    finishedTaskText:init(UI.TEXT_111036, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
    finishedTaskText:center()
    finishedTaskText:setRotationSkewX(-9.0)
    finishedTaskText:setRotationSkewY(-9.0)
    finishedTaskBg:addChild(finishedTaskText)

    local noFinishedTaskBg = UI.Image:create()
    noFinishedTaskBg:init("ui_information_banner_unfinished1.png")
    noFinishedTaskBg:rightUp(18,40)
    noFinishedTaskBg:setVisible(false)
    self:addChild(noFinishedTaskBg)
    self._noFinishedTaskBg = noFinishedTaskBg

    local noFinishedTaskText = UI.Text:create()
    noFinishedTaskText:init(UI.TEXT_111022, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
    noFinishedTaskText:center()
    noFinishedTaskBg:addChild(noFinishedTaskText)


    -- ---------------------------------------------------
    local reachNum = taskdata:getReachNum()
    local targetNum = taskdata:getTargetNum()
    if(taskdata:getTargetType() == PublicDefine.TaskTargetType.Achievement) then 
        if(taskdata:getIsFinish()) then 
            reachNum = targetNum
        end
    end

    self._finishedTaskNumText:setText(string.format("%s/%s",taskdata:getReachNum(),taskdata:getTargetNum()))
    if reachNum >= targetNum then
        self._finishedTaskNumText:setFontColor(UI.FONT_COLOR_36_181_118)
    else
        self._finishedTaskNumText:setFontColor(UI.FONT_COLOR_80_5_5)
    end
    if(not self:getIsReceive(taskdata)) then
        if taskdata:getTargetType() == PublicDefine.TaskTargetType.Collect or taskdata:getTargetNum() == 0 then 
            self._finishedTaskNumText:setText("")
        end
    end

    --奖励    
    local masterData = GameDataManager:getInstance():getMaster()
    local limitFlag,limitGoodsID = false, 0
    if(masterData) then 
        limitFlag,limitGoodsID = masterData:getBookDailyData()
    end
    -- print("limitFlag,limitGoodsID=",limitFlag,limitGoodsID, taskdata:getId(), self._taskType, task_type.DAYTODAY_TASK)
    local goodsData = taskdata:getRewardGoodsArr()
    local size = #goodsData
    if size >= 0 and self._taskType == task_type.DAYTODAY_TASK then
        for i = size, 1, -1 do
            local virtualData = goodsData[i]
            -- print("limitFlag,", limitFlag,virtualData:getGoodsID(), limitGoodsID, size)
            if(virtualData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM 
                and virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemDiamond 
                and not taskdata:getIsDiamond()) then
                table.remove(goodsData, i)
            elseif(virtualData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM 
                and virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemExp) then
                local removeFlag = false
                if(not taskdata:getIsDiamond()) then 
                    removeFlag = true
                end 
                
                local masterData = GameDataManager:getInstance():getMaster()
                local masterLevel = 0
                if(masterData) then 
                    masterLevel = masterData:getLevel()
                end
                virtualData:setNum(0)
                local expConfig = ConfigManager:getGeneralForKey("taskExpAward")
                if(expConfig and expConfig ~= "") then 
                    local expConfigArr = string.split(expConfig, ";")
                    if(expConfigArr) then 
                        for _,value in ipairs(expConfigArr) do 
                            local oneExpArr = string.split(value, ",")
                            if(oneExpArr and #oneExpArr ==2) then 
                                if(tonumber(oneExpArr[1]) == masterLevel) then 
                                    virtualData:setNum(tonumber(oneExpArr[2]))
                                    break
                                end 
                            end 
                        end 
                    end 
                end

                if(virtualData:getNum() == 0) then 
                    removeFlag = true
                end
                -- print("removeFlag =", removeFlag, virtualData:getNum(), masterLevel, not taskdata:getIsDiamond())
                if(removeFlag) then 
                    table.remove(goodsData, i)
                end
            elseif(limitFlag and virtualData:getGoodsID() == limitGoodsID) then 
                table.remove(goodsData, i)
            end
        end
    end 

    -- 把金币给放到最后
    size = #goodsData
    local iconGoodsData = nil
    for i = size, 1, -1 do
        local virtualData = goodsData[i]
        if(virtualData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM
            and virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemCoin) then 
            iconGoodsData = virtualData
            table.remove(goodsData, i)
            break
        end
    end
    if(iconGoodsData) then 
        table.insert(goodsData, iconGoodsData)
    end

    size = #goodsData
    local beginPosX = 0
    local itemPadding = 75
    local width = beginPosX + size * itemPadding
    local rewardLayout = UI.TouchLayout:create()
    rewardLayout:init(0, 0, 0, 0)
    rewardLayout:setSize(width, itemPadding)
    rewardLayout:addTouchEvents(self)
    if size <= 3 then 
        rewardLayout:leftBottom(427, 17)
        self:addChild(rewardLayout)
    else --滑动展示
        local taskscrollView = UI.ScrollView:create()
        taskscrollView:setSize(itemPadding * 3 + 10,itemPadding)
        taskscrollView:init(0,0,0,0)
        taskscrollView:leftBottom(427, 17)
        taskscrollView:addInnerNode(rewardLayout)
        -- taskscrollView:enableDebugDraw(UI.GREEN)
        taskscrollView:setScrollType(UI.ScrollType.HORIZONTAL)
        self.detailedScrollView = taskscrollView
        self:addChild(taskscrollView)
        taskscrollView:scrollToLeft()
    end
    for i = 1, size do
        local goodData = goodsData[i]
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        goodGrid:setInfoArea(true, false)
        goodGrid:centerLeft(beginPosX)
        beginPosX = beginPosX + itemPadding
        rewardLayout:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        goodGrid:showCountLabel()
        -- goodGrid:hideBG()
        table.insert(self.rewardItems, goodGrid)
        -- goodGrid:enableDebugDraw()
    end

    --按钮
    if(taskdata:getIsFinish()) then  -- 完成任务
        local SceneManager = require("app.game.SceneManager")
        if((SceneManager:getInstance():isNotInFightScene()) and self:getIsReceive(taskdata)) then 
        -- if(self._taskLayerType == UI.TaskLayerType.TASKLAYER_TOWN and self:getIsReceive(taskdata)) then 
            self._finishedTaskNumText:setVisible(false)

            local buttonAccept = UI.Button:create()
            buttonAccept:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
            buttonAccept:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                self:completeTastRequest(taskdata, buttonAccept)
            end)
                 
            buttonAccept:openClickScale()
            buttonAccept:rightUp(13, 45)
            self:addChild(buttonAccept)
            self._button_Accept = buttonAccept

            local buttonAcceptText =  UI.Text:create()
            buttonAcceptText:init(UI.TEXT_111035, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
            -- buttonAcceptText:setOutline(UI.FONT_COLOR_OUTLINE_39_16_3)
            buttonAcceptText:center()
            buttonAccept:addChild(buttonAcceptText,100)
            self._button_Accept_Text = buttonAcceptText

            self._finishedTaskBg:setVisible(false)
        else
            self._finishedTaskNumText:setVisible(false)
            -- self._finishedTaskBg:setVisible(true)

            local buttonAccept = UI.Button:create()
            buttonAccept:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
            buttonAccept:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                self:clickHandler(taskdata, buttonAccept)
            end)
    
            buttonAccept:openClickScale()
            buttonAccept:rightUp(13, 45)
            self:addChild(buttonAccept)

            local buttonAcceptText =  UI.Text:create()
            buttonAcceptText:init(UI.TEXT_111035, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
            buttonAcceptText:center()
            buttonAccept:addChild(buttonAcceptText,100)
        end 
    else   -- 未完成任务 两种UI表现
        if taskdata:getTargetType() == PublicDefine.TaskTargetType.Follow then
            self._noFinishedTaskBg:setVisible(false)
            self._finishedTaskNumText:setVisible(false)

            local buttonFollow = UI.Button:create()
            buttonFollow:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
            buttonFollow:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                self:follow(taskdata)
            end)
            buttonFollow:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
            buttonFollow:setText(UI.TEXT_1212099)
            buttonFollow:rightUp(13, 45)
            self:addChild(buttonFollow)
        else
            if(taskdata:getCountType() == 1) then --显示计数
                if(self._taskLayerType == UI.TaskLayerType.TASKLAYER_BAG) then 
                    self._finishedTaskNumText:setVisible(true)
                end
            elseif (taskdata:getCountType() == 2) then 
                self._noFinishedTaskBg:setVisible(true)
                self._finishedTaskNumText:setVisible(false)
            end        
        end
    end 
    --倒计时
    if  (self._taskType == task_type.DAYTODAY_TASK) then -- 日常任务
        self._remainTime = UI.Layout:create()
        self._remainTime:init()
        self._remainTime:setSize(200, 35)
        self:addChild(self._remainTime)
        self._remainTime:leftUp(376, 11)

        -- 时
        local remainTimeText =  UI.Text:create()
        remainTimeText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
        remainTimeText:setName("remainTimeText")
        remainTimeText:centerLeft(75)
        self._remainTime:addChild(remainTimeText)
        -- remainTimeText:enableDebugDraw()
        self:refreshTime()
    end

    if taskdata:getIsFinish() and self._button_Accept then
        local redPoint = AvalonUtil.createRedPoint(self._button_Accept, 0, 0, 9999)
        redPoint:leftUp(0, 0)
    end
    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    line:setContentSize(815, 1)
    line:setAnchorPoint(0, 0)
    line:setPosition(16,1)
    self:addChild(line)

    local line2 = UI.Image:create()
    line2:init("ui_task_banner_line.png")
    line2:rightUp(173, 0)
    line2:setScaleY(0.95)
    self:addChild(line2, 10)
end

function TaskBagSingleList:refreshTime()
    local remainTimeText = self._remainTime:getChildByName("remainTimeText")
    local time = GameDataManager:getRefreshWaitingTime()
    local hours = math.ceil(time / SECONDS_ONE_HOUR)
    -- hours = 1
    if hours <= 1 then
        remainTimeText:setFontColor(UI.FONT_COLOR_80_5_5)
        remainTimeText:setText("<1"..UI.TEXT_111033)
        
        if self._remainTime:getChildByName("clockIcon") ~= nil then
            self._remainTime:removeChildByName("clockIcon")
        end
        if self._remainTime:getChildByName("clockAnim") == nil then
            local clockAnim = UI.Animation:create()
            clockAnim:init("effect_ui_package_task_banner_clock.json", "effect_ui_package_task_banner_clock.atlas")
            clockAnim:leftBottom(61, 13)
            self._remainTime:addChild(clockAnim)
            clockAnim:setAnimation("idle",true)
            clockAnim:setName("clockAnim")
        end
    else
        remainTimeText:setFontColor(UI.FONT_COLOR_41_41_45)
        local timeStr = AvalonUtil:_getFullFormatTime(time, true)
        remainTimeText:setText(timeStr)
        
        if self._remainTime:getChildByName("clockAnim") ~= nil then
            self._remainTime:removeChildByName("clockAnim")
        end
        if self._remainTime:getChildByName("clockIcon") == nil then
            local clockIcon = AvalonUtil.createClockAnimation()
            clockIcon:centerLeft(45)
            self._remainTime:addChild(clockIcon)
            clockIcon:setName("clockIcon")
        end
    end
end

function TaskBagSingleList:setFinishAnimalTrue()
        -- 已经完成的动画效果
    if self._finishedAnimal == nil then
        local finishedAnimal  = UI.Animation:create()
        finishedAnimal:init(SEAL_JSON, SEAL_ATLAS)
        finishedAnimal:rightUp(82,62)
        self._finishedAnimal = finishedAnimal
        self:addChild(finishedAnimal)

        local text = UI.Text:create()
        text:init(UI.TEXT_111021,UI.FONT_STANDARD)
        text:setFontSize(16)
        text:center()
        text:setFontColor(UI.FONT_COLOR_15_85_71)
        self._finishedAnimal:addComponent("seal-zi", text)
    end

    self._finishedAnimal:setVisible(true)
    self._finishedAnimal:setAnimation("begin",false)
    self._finishedAnimal:addAnimation("end",true)
end 

function TaskBagSingleList:setDoingAnimalTrue()
    -- 替换成"跳转"按钮
    if self._doingAnimal == nil then
        local buttonGoto = UI.Button:create()
        buttonGoto:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
        buttonGoto:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            self:clickHandler()
        end)

        buttonGoto:openClickScale()
        buttonGoto:rightUp(13, 45)
        self:addChild(buttonGoto)
        self._doingAnimal = buttonGoto

        local buttonGotoText =  UI.Text:create()
        buttonGotoText:init(LanguageManager:getInstance():getLocalString(1111614), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        buttonGotoText:center()
        buttonGoto:addChild(buttonGotoText,100)
    end

    self._doingAnimal:setVisible(true)
end

-- local TaskTargetType ={
--     Kill = 1;    --杀怪
--     Golden = 2;  --点金
--     Talk = 3;    --对话
--     Explore = 4; --探索
--     Share = 5;   --分享
--     Collect = 6; --收集
--     Achievement = 7; --成就
--     Follow = 8; --关注
--     Strengthen = 9; --强化
--     Enchant = 10; --附魔
--     Bind = 11; --绑定任务
-- }
function TaskBagSingleList:clickHandler(taskdata, buttonAccept)
    local targetType = self._data:getTargetType()
    local targetID = self._data:getTargetID()
    if SceneManager:getInstance():isInFightScene() then
        -- add by zp CO-14439【正式服】战斗中可以打开分享按钮，能触发各种BUG
        if RoleBehaviorManager:checkMasterIsInBattle() then 
            UI.ScrollBar:createByText(UI.TEXT_1212708)
            return
        end

        -- 洞内
        if self._data:getIsFinish() then
            UI.ScrollBar:createByText(UI.TEXT_1213233)
        else
            if self._data.taskType == PublicDefine.TaskType.CaveHero or
                self._data.taskType == PublicDefine.TaskType.Plot or
                self._data.taskType == PublicDefine.TaskType.DistortedSpace or
                self._data.taskType == PublicDefine.TaskType.Inferno or
                self._data.taskType == PublicDefine.TaskType.VoidRift or
                self._data.taskType == PublicDefine.TaskType.Cycle then
                -- 剧情任务、英雄模式任务、扭曲空间个人任务:提示描述
                UI.ScrollBar:createByText(self._data:getDescription())
                return
            end

            if targetType == PublicDefine.TaskTargetType.Kill then
                -- 击杀任务：该怪物属于本层，提示击败该怪物；如果不在本层，提示该怪物不在这里
                local mapData = GameMapManager:getInstance():getMapData()
                local caveMode = mapData.caveMode
                local difficult = mapData.difficulty
                local level = mapData.level
                local caveLevel = GameDataManager:_getCaveLevel(caveMode, level)
                local targetMonsterID = targetID%1000000000

                local mapConfig = ConfigManager:getMapLevelConfig(caveLevel, caveMode, difficult)
                local found = false
                if mapConfig then
                    local monsterID = mapConfig.monsterID

                    for _, v in ipairs(mapConfig.monsterID) do
                        if v == targetMonsterID then
                            found = true
                            break
                        end
                    end
                end

                if found then
                    UI.ScrollBar:createByText(self._data:getName())
                else
                    UI.ScrollBar:createByText(UI.TEXT_1213232)
                end
            elseif targetType == PublicDefine.TaskTargetType.Golden then
                -- 点金任务：提示“请寻找点金神像点金”
                UI.ScrollBar:createByText(UI.TEXT_1213234)
            elseif targetType == PublicDefine.TaskTargetType.Enchant then
                -- 附魔任务：提示“请寻找附魔台附魔”
                UI.ScrollBar:createByText(UI.TEXT_1213235)
            elseif targetType == PublicDefine.TaskTargetType.Strengthen then
                -- 强化任务：提示“请回城镇后进行强化”
                UI.ScrollBar:createByText(UI.TEXT_1213236)
            elseif targetType == PublicDefine.TaskTargetType.Share then
                -- 分享任务：打开背包界面，展示分享条
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_BAG_PANEL_OPEN_SHARE)
            elseif targetType == PublicDefine.TaskTargetType.Achievement then
                -- 成就任务：提示“请达成成就XXX”
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Talk then
                -- 对话任务：提示任务描述
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Explore then
                -- 进度任务：提示“请前往XXX”
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Collect or targetType == PublicDefine.TaskTargetType.Follow then
                -- 其他任务：提示任务描述
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Bind then
                -- 绑定账号
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND)
            elseif targetType == PublicDefine.TaskTargetType.OpenUI then
                -- print("PublicDefine.TaskTargetType.OpenUI", targetID)
                -- 打开页面
                if Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(targetID) then
                    local MachineManager = require("app.game.MachineManager")
                    local machine = MachineManager:getInstance():getMachine()
                    local isActivateFuncSucc = machine:_openUIByFunctionType(targetID)
                else
                    local cfgData = ConfigManager:getFunctionUnlockCfgData(Game.FunctionUnlockManager:getInstance():npcTypeToLockType(targetID))
                    if cfgData then
                        UI.ScrollBar:createByTextID(cfgData.unlockdes)
                        return 
                    end
                end
            end
        end
    elseif SceneManager:getInstance():isNotInFightScene() and (not SceneManager:getInstance():isInPort()) then
        -- 城镇
        -- local CAVE_MODE = {
        --     MODE_NORMAL = 1;     -- 时光之门（普通模式）
        --     MODE_HERO = 4;       -- 时光之门（英雄模式）
        --     MODE_DESERT_EYES = 8;   --沙之眼 模式
        --     MODE_DISTORTED_SPACE = 9;   --扭曲空间
        -- }
        if self._data:getIsFinish() then
            if not self:getIsReceive(self._data) then
                -- 已完成可提交
                if self._data.taskType == PublicDefine.TaskType.Cycle then
                    local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.SKILL_ADVANCED)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CYCLE_TASK, spriteID, self._data)
                elseif self._data.taskType == PublicDefine.TaskType.DistortedSpace then
                    local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.DISTORTED_SPACE)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
                elseif self._data.taskType == PublicDefine.TaskType.Inferno then
                    local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.INFERNO)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
                    mvc.openPanel("Cave", "InfernoLevelSelect")
                    -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_INFERNO_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
                elseif self._data.taskType == PublicDefine.TaskType.VoidRift then
                    local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.VOIDRIFT)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
                    mvc.openPanel("Cave", "VoidRiftLevelSelect")
                elseif self._data.taskType == PublicDefine.TaskType.Viking then
                    local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.FUNCTION_VIKING)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
                    mvc.openPanel("ViKing", "ViKingLevelSelect")
                elseif self._data.taskType == PublicDefine.TaskType.Chaos then
                    local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.FUNCTION_CHAOS)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
                    mvc.openPanel("ChaosWormhole", "ChaosWormholeLevelSelect")
                elseif self._data.taskType == PublicDefine.TaskType.Wormhole then
                    -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
                    -- mvc.openPanel("DeepInWormhole", "DeepInWormholeMain")
                    self:completeTastRequest(taskdata, buttonAccept)
                end
            end
        else
            if self._data.taskType == PublicDefine.TaskType.CaveHero then
                -- 通关任务：打开副本界面
                self:openLevelSelect(PublicDefine.CAVE_MODE.MODE_HERO)
                return
            end
            
            if targetType == PublicDefine.TaskTargetType.Kill or targetType == PublicDefine.TaskTargetType.KillMonster then
                if self._data.taskType == PublicDefine.TaskType.Plot or
                    self._data.taskType == PublicDefine.TaskType.DistortedSpace or
                    self._data.taskType == PublicDefine.TaskType.Inferno or
                    self._data.taskType == PublicDefine.TaskType.VoidRift or
                    self._data.taskType == PublicDefine.TaskType.Cycle then
                    -- 剧情任务、英雄模式任务、扭曲空间个人任务:提示描述
                    UI.ScrollBar:createByText(self._data:getDescription())
                    return
                end

                -- 击杀任务：打开副本界面
                if SceneManager:getInstance():isGuild() then
                    UI.ScrollBar:createByText(UI.TEXT_1213237)
                else
                    local config = ConfigManager:getTaskConfigForTaskID(self._data.taskID)
                    local caveMode = math.floor(config.taskGroupID/10000)
                    self:openLevelSelect(caveMode)
                end
            elseif targetType == PublicDefine.TaskTargetType.Golden then
                -- 点金任务：提示“请寻找点金神像点金”
                UI.ScrollBar:createByText(UI.TEXT_1213231)
            elseif targetType == PublicDefine.TaskTargetType.Enchant then
                -- 附魔任务：直接打开附魔台界面
                local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.ENCHANT)
                if spriteID then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_IN_CAVE_ENCHANTMENT, spriteID)
                else
                    UI.ScrollBar:createByText(UI.TEXT_1213237)
                end
            elseif targetType == PublicDefine.TaskTargetType.Strengthen then
                -- 强化任务：直接打开强化界面
                local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN)
                if spriteID then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_STRENGTHEN, spriteID)
                else
                    UI.ScrollBar:createByText(UI.TEXT_1213236)
                end
            elseif targetType == PublicDefine.TaskTargetType.Share then
                -- 分享任务：打开背包界面，展示分享条
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_BAG_PANEL_OPEN_SHARE)
            elseif targetType == PublicDefine.TaskTargetType.Achievement then
                -- 成就任务：提示“请达成成就XXX”
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Talk then
                -- 对话任务：在小地图上添加提示标识
                local machine = MachineManager:getInstance():getMachine()
                local modelArr = {}
                if(machine and machine._model) then 
                    modelArr = machine._model:getNpcsForTemplateID(targetID)
                end
                if #modelArr > 0 then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_OPEN_BIG_MAP, targetID)
                else
                    UI.ScrollBar:createByText(self._data:getDescription())
                end
            elseif targetType == PublicDefine.TaskTargetType.Explore then
                -- 进度任务：打开副本界面
                if SceneManager:getInstance():isGuild() then
                    UI.ScrollBar:createByText(UI.TEXT_1213237)
                else
                    local caveMode = math.floor(targetID/1000000)
                    self:openLevelSelect(caveMode)
                end
            elseif targetType == PublicDefine.TaskTargetType.Collect or targetType == PublicDefine.TaskTargetType.Follow then
                -- 其他任务：提示任务描述
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Bind then
                -- 绑定账号
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND)
            elseif targetType == PublicDefine.TaskTargetType.OpenUI or 
                    targetType == PublicDefine.TaskTargetType.StarPrayWear or 
                    targetType == PublicDefine.TaskTargetType.EverWinterPass or 
                    targetType == PublicDefine.TaskTargetType.GemWear or 
                    targetType == PublicDefine.TaskTargetType.DungeonPass or 
                    targetType == PublicDefine.TaskTargetType.RelicWear then
                        
                print("PublicDefine.TaskTargetType.OpenUI", targetID, Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(targetID))
                -- 打开页面
                if Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(targetID) then
                    local MachineManager = require("app.game.MachineManager")
                    local machine = MachineManager:getInstance():getMachine()
                    local isActivateFuncSucc = machine:_openUIByFunctionType(targetID)
                    if(not isActivateFuncSucc 
                        and not SceneManager:getInstance():checkFunctionCondition(targetID)) then
                        UI.ScrollBar:createByText(self._data:getDescription())
                    end
                else
                    local cfgData = ConfigManager:getFunctionUnlockCfgData(Game.FunctionUnlockManager:getInstance():npcTypeToLockType(targetID))
                    if cfgData then
                        UI.ScrollBar:createByTextID(cfgData.unlockdes)
                        return 
                    end
                end
            end
        end
    elseif SceneManager:getInstance():isInPort() then
        -- 大航海港口的任务系统是单独的，跟其他任务不同，由服务器控制。
        if self._data.taskType == PublicDefine.TaskType.BigSailPort then
            print("PublicDefine.TaskType.Port")
            if self._data:getIsFinish() then
                -- 已完成,点击领取
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_TASK_RECEIVED, self._data)
            elseif self._data:getIsReceived() then
                -- 已领取
            elseif self._data:getJumpId() > 0 then
                -- 前往完成
                if self._data:getJumpId() == 1 then
                    if not mvc.bigSailPortModel:getIsPortClose() then
                        mvc.closePanel("BigSailPort", "BigSailPort")
                        mvc.openPanel("BigSailIsland", "BigSailIslandShowMap")
                    else
                        UI.ScrollBar:createByText(UI.TEXT_226216)
                    end
                elseif self._data:getJumpId() == 2 then
                    mvc.closePanel("BigSailPort", "BigSailPort")
                    --大航海码头
                    local initIndex = {typeIndex = PublicDefine.FUNCTION_TYPE.FUNCTION_NAVIGATION_SUPPLY}
                    mvc.openPanel("BigSailPort", "BigSailPort", initIndex)
                elseif self._data:getJumpId() == 3 then
                    if not mvc.bigSailPortModel:getIsPortClose() then
                        mvc.closePanel("BigSailPort", "BigSailPort")
                        mvc.openPanel("BigSailIsland", "BigSailIslandShowMap")
                        mvc.openPanel("BigSailIsland", "BigSailIslandFreshMonster")
                    else
                        UI.ScrollBar:createByText(UI.TEXT_226216)
                    end
                elseif self._data:getJumpId() == 4 then
                    -- if Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_BET) then
                        mvc.openPanel("Bet", "BetMain")
                    -- else

                    -- end
                end
            end
        end
    end
end

function TaskBagSingleList:openLevelSelect(caveMode)
    if caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
        -- 普通模式
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Normal_Plot)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        -- 英雄模式
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, {layerType = Game.LevelSelectLayerType.Normal_Plot, caveMode = PublicDefine.CAVE_MODE.MODE_HERO})    
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
        -- 沙之眼
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.DESERT_EYE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Desert_Eye)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
        -- 扭曲空间
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.DISTORTED_SPACE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
        -- 元素炼狱
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.MODE_INFERNO)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("Cave", "InfernoLevelSelect")
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
        -- 虚空秘境
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.MODE_VOID_RIFT)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("Cave", "VoidRiftLevelSelect")
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
        -- 维京时代
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.FUNCTION_VIKING)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("ViKing", "ViKingLevelSelect")
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
        -- 泰坦之路
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Titan_Road)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        -- 英雄模式
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, {layerType = Game.LevelSelectLayerType.Titan_Road, caveMode = PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO})
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        -- 干涸之泉
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.MODE_DRIED_SPRING)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Dried_Spring)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then
        -- 混沌虫洞
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.FUNCTION_CHAOS)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("ChaosWormhole", "ChaosWormholeLevelSelect")
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then
        -- 混沌虫洞
        -- local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.FUNCTION_CHAOS)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("DeepInWormhole", "DeepInWormholeMain")
    end
end

function TaskBagSingleList:getSpriteID(functionType)
    local machine = MachineManager:getInstance():getMachine()
    local modelArr = {}
    if(machine and machine._model) then 
        modelArr = machine._model:getAllFunctionNpcArr()
    end
    for _, v in ipairs(modelArr) do 
        local spriteID = v:getSpriteID()
        local typeArr = nil
        if(GameManager:getIsInNewScene()) then
            typeArr = v:getNpcData():getAllFunctionType()
        else
            typeArr = v:getNpcData():getFunctionTypeArr()
        end
        if typeArr then
            for _, funcType in ipairs(typeArr) do
                if funcType == functionType then
                    return spriteID
                end
            end
        end
    end

    if SceneManager:getInstance():checkFunctionCondition(functionType) then
        return 0
    end

    return nil
end

function TaskBagSingleList:setFinishAnimalFalse()
    if self._finishedAnimal then
        self._finishedAnimal:setVisible(false)
    end
end

function TaskBagSingleList:setDoingAnimalFalse()
    if self._doingAnimal then
        self._doingAnimal:setVisible(false)
    end
end

function TaskBagSingleList:follow(taskdata)
    if taskdata == nil or taskdata:getIsFinish() then
        return
    end
    if not self.parentLayer:isCanClickTableView() then
        return
    end
    if self._taskScrollView:isActionRunning() then
        return
    end
    if RoleBehaviorManager:taskRewardNpcCheck() then
        printWarn(" been blocked when using task reward npc function !")
        return
    end
    GameManager:openUrl(taskdata.collectValue)
    TaskDataManager:beginFollowTask(taskdata:getId())
end

function TaskBagSingleList:completeTastRequest(taskdata, button)
    print("--点击领取奖励---")
    if taskdata == nil or not taskdata:getIsFinish() then
        return
    end
    if not self.parentLayer:isCanClickTableView() then
        return
    end
    if self._taskScrollView:isActionRunning() then
        return
    end
    -- local SceneManager = require("app.game.SceneManager")
    -- if(taskdata:isGuild() and not SceneManager:getInstance():isGuild()) then 
    --     UI.ScrollBar:createByTextID(1112533)
    --     return
    -- end

    -- if(not taskdata:isGuild() and not SceneManager:getInstance():isInTown()) then 
    --     UI.ScrollBar:createByTextID(1112532)
    --     return
    -- end

    local goodsArr = {}
    for k,goods in pairs(taskdata._rewardGoodsArr) do
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
    if RoleBehaviorManager:taskRewardNpcCheck() then
        printWarn(" been blocked when using task reward npc function !")
        return
    end

    if taskdata:checkIsLockCollectItem() then
        UI.ScrollBar:createByTextID(1170266)
        return 
    end
    button:hide()
    self.parentLayer:setCanClickTableView(false, false)
    GameManager:completeTastRequest(taskdata)
    MasterDataManager:insertRepeatHandleData(RepeatHandleType.TASK_REWARD, taskdata:getId(), 1)
    Avalon.AudioManager:playSound("1509")
end

function TaskBagSingleList:onTouchBegan(touch, event)
    -- print("--------------------------QuickExpressionLayer onTouchBegan")
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    --检查是否在可点击区域 邮件活动区域
    if not AvalonUtil:isRectContainsPoint(self._taskScrollView, location) then
        return
    end 

    --检查是否在可点击区域 奖励滑动区域
    if (self.detailedScrollView and not tolua.isnull(self.detailedScrollView)) and not AvalonUtil:isRectContainsPoint(self.detailedScrollView, location) then
        return
    end 

    for k, value in ipairs(self.rewardItems) do
        if AvalonUtil:isRectContainsPoint(value, location) then
            self.selectIndex = k
            break
        end
    end
end

function TaskBagSingleList:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

     --检查是否在可点击区域 邮件活动区域
    if not AvalonUtil:isRectContainsPoint(self._taskScrollView, location) then
        return
    end  

     --检查是否在可点击区域 奖励滑动区域
    if (self.detailedScrollView and not tolua.isnull(self.detailedScrollView)) and not AvalonUtil:isRectContainsPoint(self.detailedScrollView, location) then
        return
    end 

    for k, value in ipairs(self.rewardItems) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
            value:onShowInfoAreaHandler(true)
            break
        end
    end
end

function TaskBagSingleList:remove(completeData)
    if self._data == nil then
        return
    end
    if completeData.completeTask and completeData.completeTask:getId() == self._data:getId() then
        self:setDoingAnimalFalse()
        self:setFinishAnimalTrue()
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            if self ~= nil and not tolua.isnull(self) then
                if completeData.accepteTask == nil then
                    print("self._taskScrollView:removeCellAtIndexAndPlayAction(self.cellIdx = "..self.cellIdx)
                    self._taskScrollView:removeCellAtIndexAndPlayAction(self.cellIdx, 0.2)
                    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                        if self.parentLayer then
                            self.parentLayer:setCanClickTableView(true, true)
                        end
                    end, 0.24)
                else
                    self:okCallBack(completeData.completeTask, completeData.accepteTask)
                end
            end
        end, 0.8)
    end
end

function TaskBagSingleList:okCallBack(oldTask, newTask)
    Avalon.MessageCenter:notice(GameMessage.MC_GOODS_NEW_TASK_UITAG)
    local remove = cc.CallFunc:create(function()
        if self ~= nil and not tolua.isnull(self) and oldTask:getId() == self._data:getId() then
            self:setPosition(self:getPositionX() + 930 * 2 ,self:getPositionY())
            -- Avalon.AudioManager:playSound("1509") --音效改为在点击过后立马播放
            self:resetData(newTask)
            self:onUpdateView()
            self:runAction(cc.MoveTo:create(0.15, cc.p(0,self:getPositionY())))
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                if self.parentLayer then
                    self.parentLayer:setCanClickTableView(true, true)
                end
            end, 0.2)
        end
    end) 
    self:runAction(cc.Sequence:create(cc.MoveTo:create(0.15, cc.p(self:getPositionX() - 930 ,self:getPositionY())),remove))
end

function TaskBagSingleList:setParentLayer(layer)
    self.parentLayer = layer
end

function TaskBagSingleList:getIsReceive(taskData)
    if(taskData) then 
        if(taskData:isCycle() 
            or taskData:isDistortedSpace()
            or taskData:isInferno()
            or taskData:isVoidRift()
            or taskData:isBigSailPort()) then 
            return false
        end
    end

    return true
end
