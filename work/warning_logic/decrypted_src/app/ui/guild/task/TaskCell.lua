
-- TaskCell.lua
-- Author:zp
-- 2017年9月26日
-- Using:公会任务 cell

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local ProtobufUtil = require("utils.ProtobufUtil")
local GuildTitle = PublicDefine.GuildTitle
local TaskStatus = PublicDefine.TaskStatus

UI = UI or {}
local TaskCell = class("TaskCell", UI.HWBtnComponent)
UI.TaskCell = TaskCell

local COM_RES_LIST = {
}

local _width = 282
local _height = 540

function TaskCell:ctor(data,idx)
    TaskCell.super.ctor(
        self,UIType.GUILD_TASK_CELL,
        COM_RES_LIST,
        _width,
        _height
    )

    self.data = data;
    self.idx =idx

    self.replaceData = nil

    self:init();

    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.completeTask)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_REFREH_RESULT, self, self.refreshTaskResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

function TaskCell:dtor()
    TaskCell.super.dtor(self)
    -- reload_script_file("app.ui.guild.task.TaskCell")
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.completeTask)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_REFREH_RESULT, self, self.refreshTaskResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

local STATUS_LABEL = 65

-- public:
-- 初始化
function TaskCell:init()
    TaskCell.super.init(self)
end

-- 模版函数：初始化组建的视图
function TaskCell:onInitView()
    -- self:enableDebugDraw(UI.RED)
    -- 组件对象
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(_width, _height)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_guild_task_banner_box1.png")
    bg:centerUp(29)
    contentLayout:addChild(bg)
    self.bg = bg

    local monsterData = self:getMonsterData()
    local _monsterBG = UI.Image:create()
    if(monsterData) then
        _monsterBG:init("ui_guild_task_banner_box_scene"..ToolsUtil:getPageSceneID(monsterData)..".png")
    else
        _monsterBG:init("ui_guild_task_banner_box_scene1.png")
    end
    _monsterBG:leftUp(20, 88)
    contentLayout:addChild(_monsterBG)

    local leftBoard = UI.Image:create()
    leftBoard:init("ui_guild_task_banner_line_yellow.png")
    leftBoard:leftBottom(14, 128)
    contentLayout:addChild(leftBoard)
    self.leftBoard = leftBoard

    local rightBoard = UI.Image:create()
    rightBoard:init("ui_guild_task_banner_line_yellow.png")
    rightBoard:rightBottom(18, 128)
    rightBoard:setScaleX(-1)
    contentLayout:addChild(rightBoard)
    self.rightBoard = rightBoard 

    -- 角色动画
    local spineLayout = UI.Layout:create()
    spineLayout:init()
    spineLayout:centerBottom(230)
    self:addChild(spineLayout)

    self._spineLayout = cc.Node:create()
    spineLayout:addChild(self._spineLayout)

    if(monsterData) then
        local taskSpine = UI.Animation:create()
        taskSpine:init(monsterData.spine..".json", monsterData.spine..".atlas", 1.0)
        taskSpine:setAnimation("idle1", true)
        taskSpine:addEventListener(UIEvent.ANIMATION_END, self, self.animationEnd)
        -- taskSpine:addEventListener(UIEvent.ANIMATION_START, self, self.animationStart)
        self.taskSpine = taskSpine
        self._spineLayout:addChild(taskSpine)
        taskSpine:centerBottom(26)
    end

    local leftTitlePoint = UI.Image:create()
    leftTitlePoint:init("ui_guild_task_decoration1.png")
    leftTitlePoint:leftUp(20, 47)
    contentLayout:addChild(leftTitlePoint)
    self.leftTitlePoint = leftTitlePoint

    local rightTitlePoint = UI.Image:create()
    rightTitlePoint:init("ui_guild_task_decoration1.png")
    rightTitlePoint:rightUp(21, 47)
    rightTitlePoint:setScaleX(-1)
    contentLayout:addChild(rightTitlePoint)
    self.rightTitlePoint = rightTitlePoint 

    local taskNameText = UI.Text:create()
    taskNameText:init(taskNameText:numformat("10"), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    taskNameText:setTextCenter()
    taskNameText:center(-2, -175)
    taskNameText:setLineSpacing(-6)
    taskNameText:setDimensions(230, 0)
    bg:addChild(taskNameText)
    self.taskNameText = taskNameText

    local progress = UI.Text:create()
    progress:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_208_50_60)
    progress:centerBottom(-25)
    bg:addChild(progress)
    self.progress = progress

    local receiveButton = UI.Button:create()
    receiveButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    receiveButton:centerBottom(19)
    contentLayout:addChild(receiveButton, 10)
    receiveButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        if(self.data:getStatus() == TaskStatus.TaskStatus_Normal) then 
            self:refreshTask()
        else
            MasterDataManager:insertRepeatHandleData(RepeatHandleType.GUILD_TASK_REWARD, self.data.taskID, true)    
            Net.NetTaskSystem:submitTaskRequest(self.data.taskID)
        end
        self.receiveButton:disable()
    end)
    self.receiveButton = receiveButton
    receiveButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- receiveButton:setText(LanguageManager:getInstance():getLocalString(1110165))

    -- 添加金币的相关表现
    self.receiveText = UI.Text:create()
    self.receiveText:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self.receiveText:setTextLeft()
    self.receiveText:center()
    receiveButton:addChild(self.receiveText, 4)

    -- 黄金
    self._momeyImage = UI.Image:create()
    self._momeyImage:init("symbol_gaming_money.png")
    self._momeyImage:centerLeft(4)
    receiveButton:addChild(self._momeyImage, 4)

    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    self._momey:setTextLeft()
    self._momey:centerLeft(self._momeyImage:getContentSize().width + 4)
    self._momeyImage:addChild(self._momey, 4)

    local finishedAnimal  = UI.Animation:create()
    finishedAnimal:init("effect_ui_general_reward_order_postmark.json", "effect_ui_general_reward_order_postmark.atlas")
    finishedAnimal:rightBottom(-50, 23)
    spineLayout:addChild(finishedAnimal, 100)
    self._finishedAnimal = finishedAnimal
    self._finishedAnimal:hide()
    finishedAnimal:addEventListener(UIEvent.ANIMATION_START, self, self.animationStart)
  
    self:reload(self.data, self.idx)
   
    Avalon.Scheduler:scheduleUpdateOnce(self, function()
        if self.bg ~= nil and not tolua.isnull(self.bg) then
            local showAnimal  = UI.Animation:create()
            showAnimal:init("effect_ui_general_reward_order_sword.json", "effect_ui_general_reward_order_sword.atlas")
            showAnimal:rightUp(42, 30)
            self.bg:addChild(showAnimal, 100)
            showAnimal:setAnimation("begin",false)
        end
    end, 0.21)
end

-- 模版函数：更新组建的视图
function TaskCell:onUpdateView()

end

function TaskCell:completeTask(completeData)
    local completeTask = completeData.completeTask
    if(completeTask:getId() == self.data:getId()) then
        self.data:setStatus(TaskStatus.TaskStatus_IsReceived)
        if(completeData.accepteTask) then 
            self:reload(completeData.accepteTask, self.idx)
        else
        	self:refreshStatus(self.data)
        end
        self:setFinishAnimalTrue(true)
    end
end

function TaskCell:getMonsterData()
    -- 由于修改了配置怪物的ID，这里需要做相关的处理
    if self.data.targetSceneLimit == 0 then
        local chu = 100000000
        local int,monsterID = math.modf(self.data.targetID/chu)
        -- return  RoleDataManager:createLocalMonsterData(tonumber(monsterID * chu))
        -- add by zp  这里和孙雪龙策划确认，公会任务一定只会配置啥普通模式的怪物
        local templateID = self.data.targetID-int * chu

        return RoleDataManager:createLocalMonsterDataForAllConfig(templateID)
    else
        return ConfigManager:getMonsterConfig(self.data.targetID, self.data.targetSceneLimit, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    end
end

function TaskCell:animationEnd()

end

function TaskCell:animationStart(event)
    if event and event.animation == "end" then
        self:refreshSpine()
    end
end

function TaskCell:reload(data, idx)
    local change = false
    if(data and data:getId() ~= self.data:getId()) then 
        change = true
        self.data = data
    end
    self.idx = idx

    -- 刷新怪物动画
    if(change) then
        -- print("TaskCell:reload()", change)
        if(self.taskSpine) then
            self.taskSpine:removeFromParent()
            self.taskSpine = nil
        end

        local monsterData = self:getMonsterData()
        if(monsterData) then 
            local taskSpine = UI.Animation:create()
            taskSpine:init(monsterData.spine..".json", monsterData.spine..".atlas", 1.0)
            taskSpine:setAnimation("idle1", true)
            -- taskSpine:centerBottom(270)
            taskSpine:addEventListener(UIEvent.ANIMATION_END, self, self.animationEnd)
            -- taskSpine:addEventListener(UIEvent.ANIMATION_START, self, self.animationStart)
            self.taskSpine = taskSpine
            self.taskSpine._spine:setOpacity(0)
            self.taskSpine._spine:runAction(self:createFadeInAction()) 

            self._spineLayout:addChild(self.taskSpine)
            taskSpine:centerBottom(26)
        end 
    end

    -- 刷新任务名字
    -- self.taskNameText:setText(self.data:getDescription())
    self.taskNameText:setText(self.data:getName())
    self.taskNameText:setOpacity(0)
    self.taskNameText:runAction(self:createFadeInAction()) 

    -- 刷新奖励物品
    local rewardGoodsArr = self.data:getRewardGoodsArr()
    local showRewardList = {}
    local rewardGoodsList = {}
    if(rewardGoodsArr) then
        for k, virtualData in pairs(rewardGoodsArr) do
            local data = {}
            data.number = virtualData:getNum()
            if(virtualData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM and 
                virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemDiamond ) then
                data.image = "symbol_gaming_diamond.png"
                data.fontColor = UI.FONT_COLOR_45_233_245
                table.insert(showRewardList, data)
            elseif(virtualData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM and 
                virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemGuildMedal) then 
                data.image = "symbol_guild_tech_icon_medal.png"
                table.insert(showRewardList, data)
                data.fontColor = UI.FONT_COLOR_244_219_46
            else 
                -- print("fdfdf")
                virtualData:setIsNew(false)
                data.goodsData = virtualData
                data.image = virtualData:getIconName()
                table.insert(rewardGoodsList, data)
                data.fontColor = UI.FONT_COLOR_41_41_45
            end
        end
    end

    -- 移除以前显示数据
    for i=1,2 do
        local child = self.bg:getChildByName(string.format("%s%s", "reward_",tostring(i)))
        if(not tolua.isnull(child)) then 
            child:removeFromParent(true)
        end
    end
    if(self.iconList) then
        for _,icon in ipairs(self.iconList) do 
            if(icon) then 
                icon:removeFromParent(true)
            end
        end
    end

    if(self.textList) then
        for _,text in ipairs(self.textList) do 
            if(not tolua.isnull(text) and text:getParent()) then 
                text:removeFromParent(true)
            end
        end
    end
    
    local beginUp = 292 
    local coordXArr = {46, 155}
    local coordYArr = {324 + 29, 378 + 29}
    local centerX = 136

    self.iconList = {}
    self.textList = {}
    if(rewardGoodsList and #rewardGoodsList == 0) then 
        for k, v in ipairs(showRewardList) do 
            local rewardOneIcon = UI.Image:create()
            rewardOneIcon:init(v.image)
            rewardOneIcon:leftUp(centerX, coordYArr[k] - rewardOneIcon:getContentSize().height / 2)
            self.contentLayout:addChild(rewardOneIcon)
            table.insert(self.iconList, rewardOneIcon)
            rewardOneIcon:setOpacity(0)
            rewardOneIcon:runAction(self:createFadeInAction()) 

            local rewardOneText = UI.NumberText:create(tostring(v.number), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, v.fontColor, 0)
            rewardOneText:centerRight(- rewardOneText:getContentSize().width - 4)
            rewardOneIcon:addChild(rewardOneText)
            rewardOneText:setOpacity(0)
            rewardOneText:runAction(self:createFadeInAction()) 
            table.insert(self.textList, rewardOneText)

            rewardOneIcon:leftUp(centerX - (rewardOneIcon:getContentSize().width + rewardOneText:getContentSize().width + 4)/2 , coordYArr[k] - rewardOneIcon:getContentSize().height / 2)
        end
    else 
        for k, v in ipairs(showRewardList) do 
            local rewardOneIcon = UI.Image:create()
            rewardOneIcon:init(v.image)
            rewardOneIcon:leftUp(coordXArr[k], coordYArr[1] - rewardOneIcon:getContentSize().height / 2)
            self.contentLayout:addChild(rewardOneIcon)
            table.insert(self.iconList, rewardOneIcon)
            rewardOneIcon:setOpacity(0)
            rewardOneIcon:runAction(self:createFadeInAction()) 

            local rewardOneText = UI.NumberText:create(tostring(v.number), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, v.fontColor, 0)
            rewardOneText:centerRight(- rewardOneText:getContentSize().width - 4)
            rewardOneIcon:addChild(rewardOneText)
            rewardOneText:setOpacity(0)
            rewardOneText:runAction(self:createFadeInAction()) 
            table.insert(self.textList, rewardOneText)
        end

        if(rewardGoodsList and #rewardGoodsList == 1) then 
            for k, v in ipairs(rewardGoodsList) do 
                local goodGrid = UI.GoodsGrid:create()
                goodGrid:init(v.goodsData)
                goodGrid:setScale(43/68)
                self.contentLayout:addChild(goodGrid)
                goodGrid:hideFlagIcon()
                goodGrid:setInfoArea(true, false)
                goodGrid:hideCountLabel()
                goodGrid:showInfoArea(true, false)
                goodGrid:leftUp(coordXArr[k] - 14, coordYArr[2] - goodGrid:getContentSize().height / 2)
                table.insert(self.iconList, goodGrid)
                goodGrid:setOpacity(0)
                goodGrid:runAction(self:createFadeInAction()) 

                local rewardOneText = UI.Text:create()
                rewardOneText:init("X"..tostring(v.number), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, v.fontColor)
                rewardOneText:leftBottom(goodGrid:getContentSize().width + 12, 2)
                rewardOneText:setScale(68/43)
                goodGrid:addChild(rewardOneText, 1000)
                rewardOneText:setOpacity(0)
                rewardOneText:runAction(self:createFadeInAction()) 
                table.insert(self.textList, rewardOneText)

                goodGrid:leftUp(centerX - (goodGrid:getContentSize().width * goodGrid:getScale() + rewardOneText:getContentSize().width)/2, coordYArr[2] - goodGrid:getContentSize().height / 2)
            end
        else 
            -- 处理物品奖励处理逻辑
            for k, v in ipairs(rewardGoodsList) do 
                local goodGrid = UI.GoodsGrid:create()
                goodGrid:init(v.goodsData)
                goodGrid:setScale(43/68)
                self.contentLayout:addChild(goodGrid)
                goodGrid:hideFlagIcon()
                goodGrid:setInfoArea(true, false)
                goodGrid:hideCountLabel()
                goodGrid:showInfoArea(true, false)
                goodGrid:leftUp(coordXArr[k] - 14, coordYArr[2] - goodGrid:getContentSize().height / 2)
                table.insert(self.iconList, goodGrid)
                goodGrid:setOpacity(0)
                goodGrid:runAction(self:createFadeInAction()) 

                local rewardOneText = UI.Text:create()
                rewardOneText:init("X"..tostring(v.number), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, v.fontColor)
                rewardOneText:leftUp(goodGrid:getLeft() + goodGrid:getContentSize().width - 6, coordYArr[2] - rewardOneText:getContentSize().height / 2 + 10)
                self.contentLayout:addChild(rewardOneText, 1000)
                rewardOneText:setOpacity(0)
                rewardOneText:runAction(self:createFadeInAction()) 
                table.insert(self.textList, rewardOneText)
            end
        end 
    end

    self:refreshStatus(data)
    self:refreshSpine()
    self:setFinishAnimalTrue(false)
end

function TaskCell:refreshStatus(data)
    self.taskNameText:setFontColor(UI.FONT_COLOR_41_41_45)
    self.receiveButton:setFontColor(UI.FONT_COLOR_50_50_44)
    self.leftBoard:hide()
    self.rightBoard:hide()
    self.leftTitlePoint:hide()
    self.rightTitlePoint:hide()
    self.progress:hide()
    self._momeyImage:setVisible(false)
    self._momey:setVisible(false)
    if(self.receiveText) then 
        self.receiveText:center()
    end
    self._momey:setFontColor(UI.FONT_COLOR_41_41_45)
    self.receiveText:setText(LanguageManager:getInstance():getLocalString(1110165))
    if(self.data:getStatus() == TaskStatus.TaskStatus_IsReceived) then
        -- self.receiveEndBg:setVisible(true)
        self.receiveButton:disable()
        self.receiveText:setText(UI.TEXT_1110721)
        for k, v in ipairs(self.iconList) do
            v:useShader(UI.COMPONENT_GRAY_SHADER)
        end
        for k, v in ipairs(self.textList) do
            v:setFontColor(UI.FONT_COLOR_41_41_45)
        end
    elseif(self.data:getStatus() == TaskStatus.TaskStatus_IsFinish or self.data:getIsFinish()) then
        self.receiveButton:setVisible(true)
        self.taskNameText:setFontColor(UI.FONT_COLOR_244_219_46)
        self.leftBoard:show()
        self.rightBoard:show()
        self.leftTitlePoint:show()
        self.rightTitlePoint:show()
        self.receiveButton:enable()
    elseif(self.data:getStatus() == TaskStatus.TaskStatus_Normal) then
        self.receiveButton:enable(0.5)
        if(self.receiveText) then 
            self._momey:setText(tostring(self:getRefreshDiamond()))
            if(self:getRefreshDiamond() > GameDataManager:getInstance():getMaster():getCurCoin()) then
                self._momey:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            else 
                self._momey:setFontColor(UI.FONT_COLOR_41_41_45)
            end
            self.receiveText:setText(LanguageManager:getInstance():getLocalString(1111856))
            self._momeyImage:setVisible(true)
            self._momey:setVisible(true)
            local startX = (self.receiveButton:getContentSize().width - 
                (self.receiveText:getContentSize().width + self._momeyImage:getContentSize().width 
                    + self._momey:getContentSize().width + 8))/2

        
            self.receiveText:centerLeft(startX)
            startX = startX + self.receiveText:getContentSize().width + 4
            self._momeyImage:centerLeft(startX)
        end

        -- self.receiveButton:disable()
        -- self.receiveButton:setText(UI.TEXT_1212013)
        if(self.data:getCountType() == 1) then --显示计数
            self.progress:show()
            self.progress:runAction(self:createFadeInAction()) 
            self.progress:setText(string.format("%s/%s",self.data:getReachNum(), self.data:getTargetNum()))
        end 
    else

    end
end

function TaskCell:refreshSpine()
    if(self.data:getStatus() == TaskStatus.TaskStatus_IsReceived) then
        if(self.taskSpine and self.taskSpine._spine) then 
            local glProgramState = AvalonUtil:getAnimationGrayGLProgramState()
        
            -- local oldGlProgramState = self._roleAnimation._spine:getGLProgramState()
            self.taskSpine._spine:setGLProgramState(glProgramState)
            self.taskSpine:setAnimation("idle1", true)
            self.taskSpine:updateTime(0)
            self.taskSpine:setTimeScale(0)
        end 
    else

    end
end

function TaskCell:setFinishAnimalTrue(isShow)
        -- 已经完成的动画效果
    if(self.data:getStatus() == TaskStatus.TaskStatus_IsReceived) then
        self._finishedAnimal:show()
        if isShow then
            self._finishedAnimal:setAnimation("begin",false)
            self._finishedAnimal:addAnimation("end",true)
        else
            self._finishedAnimal:setAnimation("end",true)
        end
    else
        self._finishedAnimal:hide()
    end
end 

function TaskCell:refreshTask()
    local userArr = TaskDataManager:getAccepteGuildTaskArr()
    if(userArr and #userArr > 0) then 
        local taskConfig = userArr[math.random(1, #userArr)]
        if(taskConfig) then 
            -- 判断金币是否够
            if(self:getRefreshDiamond() > GameDataManager:getInstance():getMaster():getCurCoin()) then 
                UI.ScrollBar:createByText(UI.TEXT_1110389)
                return 
            end
            Net.NetTaskSystem:refreshTask(self.data:getId(), taskConfig.taskID)
        end
    end
end

function TaskCell:getRefreshDiamond()
    local config = ConfigManager:getGeneralForKey("guildTaskConsumption")
    if(config) then 
        return tonumber(config)
    end

    return 0
end

function TaskCell:refreshTaskResult(data, newTask)
    if(data and self.data:getId() == data.taskID) then 
        if(data.result == ProtobufUtil:enum_id("TaskSystem.RefreshTaskResultType", "RefreshTaskResultType_Suc") and newTask) then
            UI.ScrollBar:createByTextID(1111868)
            
            self.taskNameText:runAction(self:createFadeOutAction()) 
            if(self.iconList) then
                for _,icon in ipairs(self.iconList) do 
                    if(icon) then 
                        icon:runAction(self:createFadeOutAction()) 
                    end
                end
            end

            if(self.textList) then
                for _,text in ipairs(self.textList) do 
                    if(text) then 
                        text:runAction(self:createFadeOutAction()) 
                    end
                end
            end
            if(self.progress) then 
                self.progress:runAction(self:createFadeOutAction()) 
            end

            if(self.taskSpine and self.taskSpine._spine) then
                self.taskSpine._spine:runAction(cc.Sequence:create(self:createFadeOutAction(),cc.CallFunc:create(function()
                    -- 添加了刷新表现
                    self:reload(newTask, self.idx)
                end)))
            end
        end
    end
end

function TaskCell:onCurrencyChangeHandler()
    -- self:refreshStatus(self.data)
    if(self._momey) then 
        if(self:getRefreshDiamond() > GameDataManager:getInstance():getMaster():getCurCoin()) then
            self._momey:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else 
            self._momey:setFontColor(UI.FONT_COLOR_41_41_45)
        end
    end
end

function TaskCell:createFadeOutAction()
    local time = 0.5
    return cc.FadeOut:create(time)
end

function TaskCell:createFadeInAction()
    local time = 0.5
    return cc.FadeIn:create(time)
end