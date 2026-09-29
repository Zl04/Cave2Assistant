--
-- Author: Your Name
-- Date: 2017-10-16 18:30:38
--
UI = UI or {}

local LanguageManager = require("app.game.LanguageManager")
local AchievementCell = class("AchievementCell", UI.TableViewCell)
local GameDataManager = require("app.game.GameDataManager")
require "app.ui.baglayer.TaskLayer.AchievementLayer.AchievementCellInfo"
local CELL_SIZE = cc.size(203, 205)

UI.AchievementCell = AchievementCell

local IDLE_NAME = "idle"
local OPEN_NAME = "%d_open"
local SHAKE_NAME = "shake"
local FINISH_NAME = "%d_finish"
local KEEP_NAME = "%d_keep"

function AchievementCell:ctor(spriteID, uiType, tableView)
	AchievementCell.super.ctor(self)
    self:setContentSize(cc.size(775, 215))
    self._spriteID 	= spriteID
    self._uiType = uiType
    self._tableView = tableView
	self._dataList = {}
    self._cellPanels = {}
    self._smallIcon = {}
	self:onInitView()
	Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACHIEVEMENT_RESULET,self,self.onAchievementResult)
    local addTime =  math.random(0, 0.5)
    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.playSunShineAct), 2.5 + addTime, false)
end

-- 析构函数
function AchievementCell:dtor()
    AchievementCell.super.dtor(self)
    self._cellPanels = {}
    self._dataList = {}
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACHIEVEMENT_RESULET,self,self.onAchievementResult)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function AchievementCell:onInitView()
	local upLayout = UI.TouchLayout:create()
    upLayout:init(0, 0, 0, 0)
    upLayout:setSize(775, 215)
    upLayout:center()
    upLayout:addTouchEvents(self)
    self:addChild(upLayout)
    for k = 1, 4 do
        local cell = self:createCell()
        upLayout:addChild(cell)
        cell:leftUp(32 + CELL_SIZE.width * (k - 1), 13)
        table.insert(self._cellPanels, cell)
    end
    -- self:enableDebugDraw()
end

function AchievementCell:reload(dataList)
    self._dataList = dataList
    for k = 1, 4 do
        local data = self._dataList[k]
        local cell = self._cellPanels[k]
        if data then
            cell:show()
            local iconAnimal = cell:getChildByName("iconAnimal")
            local smallIcon = self._smallIcon[k]
            -- local labelBg = cell:getChildByName("labelBg")
            local name = cell:getChildByName("name")
            smallIcon:setTag(data.ID)
            cell:setTag(data.ID)
            smallIcon:setSpriteName(string.format("%s.png", data.icon))
            
            name:setText(data.name)
            name:setTextCenter()
            local adata = MasterDataManager:getAchevementData(data.ID)
            local current = 0;
            local stage = 0;
            local targetNum = 0;
            local maxStage = table.nums(data.goal)
            if adata then
                current = adata.count
                stage = adata.rewardStage 
            end

            if stage >= maxStage then--已经领完奖励
            -- if true then
                iconAnimal:setAnimation(string.format(KEEP_NAME, data.color), false) 
                smallIcon:show()
                cell:setSpriteName("ui_task_banner_achievements2.png")
                name:setFontColor(UI.FONT_COLOR_249_220_103)
            else
                local targetNum = 0
                if data.countType == 1 then
                    targetNum = data.goal[stage + 1]
                else
                    targetNum = data.goal[1]
                end

                -- 达成目标
                if current >= targetNum then--已完成 未领奖
                    --显示抖动spine
                    iconAnimal:setAnimation(SHAKE_NAME,true) 
                    smallIcon:hide()
                    cell:setSpriteName("ui_task_banner_achievements2.png")
                else
                    iconAnimal:setAnimation(IDLE_NAME,true) 
                    smallIcon:hide()
                    cell:setSpriteName("ui_task_banner_achievements1.png")
                end
                name:setFontColor(UI.FONT_COLOR_155_155_155)
            end
        else
            cell:hide()
        end
    end
end

function AchievementCell:onUpdateView()
   
end

function AchievementCell:hightLight(bg)
    if(self.touchImage == nil) then 
        self.touchImage = UI.Image9:create()
        self.touchImage:init("ui_information_selectedbox.png", CCRectMake(16,15,1,1), cc.size(bg:getContentSize().width, bg:getContentSize().height))
        self.touchImage:center()
        self.touchImage:retain()
    end
    if(self.touchImage:getParent())then
        self.touchImage:removeFromParent(false)
    end
    bg:addChild(self.touchImage, 100)
    self.touchImage:setVisible(true)
end

function AchievementCell:unHightLight()
    if(self.touchImage) then
        self.touchImage:setVisible(false)
        self.touchImage:removeFromParent(false)
    end
end

function AchievementCell:playSunShineAct()
    -- print("---------AchievementCell:playSunShineAct")
    if self._dataList == nil then
        return
    end
    local bingo =  math.random(0, 4)
    local data = self._dataList[bingo]
    local pannel = nil
    -- print("---------------------------size = ", #self._cellPanels)
    for k, v in ipairs(self._cellPanels) do
        -- dump(v)
        -- dump(data)
        if data ~= nil and v:getTag() == data.ID then
            pannel = v
            break;
        end
    end
    if pannel ~= nil and pannel:isVisible() then
        local adata = MasterDataManager:getAchevementData(data.ID)
        local current = 0;
        local stage = 0;
        local targetNum = 0;
        local maxStage = table.nums(data.goal)
        if adata then
            current = adata.count
            stage = adata.rewardStage 
        end

        if stage >= maxStage then--已经领完奖励
            local iconAnimal = pannel:getChildByName("iconAnimal")
            iconAnimal:addAnimation(string.format(FINISH_NAME, data.color), false) 
        end
    end
end

function AchievementCell:createCell()
    local bg = UI.Image:create()
    bg:init("ui_task_banner_achievements1.png")

    if(GameManager:getIsGooglePlay()) then
        bg:setTouchEnable(true)
        bg:setSwallowTouches(false)
        bg:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, bg, function()
            self:hightLight(bg)
            Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                if(not tolua.isnull(self)) then
                    self:unHightLight(bg)
                end
            end, 1)
        end)

        bg:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, bg, function(self_, button, touchPosition)
            if not bg:checkTouchPosition(touchPosition) then 
                self:unHightLight(bg)
            end
        end)

        bg:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, panel, function()
            self:unHightLight(bg)
        end)
    end

    local btnPanel = UI.Layout:create()
    btnPanel:init()
    btnPanel:setSize(160, 150)
    btnPanel:centerUp(10)
    -- btnPanel:enableDebugDraw(UI.RED)
    btnPanel:setName("btnPanel")
    bg:addChild(btnPanel, 20)

    local name = UI.Text:create()
    name:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    name:setSize(160, 40)
    name:setTextCenter()
    name:center(0, 72)
    -- name:enableDebugDraw(UI.RED)
    name:setLineSpacing(-2)
    bg:addChild(name)
    name:setName("name")

    local iconAnimal  = UI.Animation:create()
    iconAnimal:init("effect_ui_package_task_achievements_cup.json","effect_ui_package_task_achievements_cup.atlas")
    iconAnimal:leftUp(83, 70)
    bg:addChild(iconAnimal, 30)
    iconAnimal:setName("iconAnimal")

    local smallIcon = UI.Image:create()
    smallIcon:init()
    smallIcon:center()
    iconAnimal:addComponent("icon", smallIcon)
    table.insert(self._smallIcon, smallIcon)
    return bg
end


function AchievementCell:setFinishAnimal(achievementId)
    local data = nil
    for k, v in ipairs(self._dataList) do
        if v.ID == achievementId then
            data = v
            break
        end
    end
	local pannel = nil

    for k, v in ipairs(self._cellPanels) do
        if v:getTag() == achievementId then
            pannel = v
            break;
        end
    end

    if pannel == nil or data == nil then
        return
    end
	local iconAnimal = pannel:getChildByName("iconAnimal")
    local name = pannel:getChildByName("name")
    local animationName = string.format(OPEN_NAME, data.color)
	iconAnimal:setAnimation(animationName, false) 
    iconAnimal:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(sender, event)
        if (event.animation == animationName) then
            iconAnimal:setAnimation(string.format(KEEP_NAME, data.color), false) 
            pannel:setSpriteName("ui_task_banner_achievements2.png")
            name:setFontColor(UI.FONT_COLOR_249_220_103)
            if self.rewardGoodsArr then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, self.rewardGoodsArr, nil, UI.TEXT_111030, nil)  
            end
            self.rewardGoodsArr = nil
        end
    end)

    iconAnimal:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData and event.eventData.name == "show_icon") then
            local smallIcon = nil
            for k, v in ipairs( self._smallIcon) do
                if v:getTag() == achievementId then
                    smallIcon = v
                end
            end
            if smallIcon then
                smallIcon:show()
            end

            Avalon.AudioManager:playSound("1529")
        end
    end)
end 

function AchievementCell:showInfo(index, data, cfgData, isFinish)
    local infoLayer = UI.AchievementCellInfo:create(data, cfgData, isFinish)    
    if index <= 2 then
        infoLayer:centerLeft(CELL_SIZE.width * index + 20)
    else
        infoLayer:centerRight(CELL_SIZE.width * (ACHIEVEMENT_CELL_COUNT_NUMBER + 1 - index) + 100)
    end

    self._tableView:getParent():addChild(infoLayer, 1000)
end

function AchievementCell:iconClick(index)
	-- print("---------iconClick----------- index = "..index)
	local data = self._dataList[index]
	if not data then return end

    local adata = MasterDataManager:getAchevementData(data.ID)
    local stage = 0
    local current = 0
	local maxStage = table.nums(data.goal)
	if adata then
		stage = adata.rewardStage 
		current = adata.count
	end

	if stage >= maxStage then
		self:showInfo(index, adata, data, true)
		return
	else
        local targetNum = 0
        if data.countType == 1 then
            targetNum = data.goal[stage + 1]
        else
            targetNum = data.goal[1]
        end
            -- 达成目标
        if current >= targetNum then--已完成 未领奖
        else
        	self:showInfo(index, adata, data, false)
            return
        end
    end

    local goodsArr = self:getRewards(data, stage + 1)
	local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if not enough then   
        -- UI.UIManager.mTipsLayer:onBagIsFull()
        UI.ScrollBar:createByTextID(1110793)
        return
    end

    self:reqGetResult(adata, data)
end

function AchievementCell:reqGetResult(adata, data)
    -- if self._uiType ~= UI.TaskLayerUIType.TASKLAYER_TOWN then 
    --     UI.ScrollBar:createByTextID(1111123)
    --     return
    -- end
    local SceneManager = require("app.game.SceneManager")
    if(not SceneManager:getInstance():isInTownOrInHome()) then 
        UI.ScrollBar:createByTextID(1112532)
        return
    end

    if not adata then return end
    local nextStage = adata.rewardStage + 1;
    if nextStage > 3 then
        print("领取成就奖励错误 阶段为  ---  ",nextStage)
    end
    if RoleBehaviorManager:achievementRewardNpcCheck() then
        printWarn(" been blocked when using achievement reward npc function !")
        return
    end
    Net.NetNPCSystem:sendAchievementReward(data.ID, nextStage, self._spriteID)
    MasterDataManager:insertRepeatHandleData(RepeatHandleType.NPC_ACHIEVEMENT, data.ID, true)
end

function AchievementCell:onAchievementResult(Megdata)
    local achievementId = checkint(Megdata.achievementId)
    local awardStat = checkint(Megdata.awardStat)
    if achievementId <= 0 or awardStat <=0 then
        print(string.format("完成成就 更新数据异常 achievementId = %d awardStat = %d",achievementId,awardStat))
        return
    end
    
    self:setFinishAnimal(achievementId)
    Avalon.MessageCenter:notice(GameMessage.MC_ACHIEVEMENT_CHECK_NEW)
    
    local data = nil
    for k, v in ipairs(self._dataList) do
        if v.ID == achievementId then
            data = v
            break
        end
    end
    if data == nil then return end
    local adata = MasterDataManager:getAchevementData(data.ID)
    if adata == nil then return end

    local goodsArr = self:getRewards(data, awardStat)
    local rewardGoodsArr = {}
    for k, v in ipairs(goodsArr) do
        local goodsData = GoodsDataManager:createLocalGoodsData(v.goodsID)
        if (goodsData) then
            goodsData:setNum(v.num)
            goodsData:setIsGolden(v.isGolden)
            table.insert(rewardGoodsArr, goodsData)
        end
    end

    self.rewardGoodsArr = rewardGoodsArr   
end

function AchievementCell:getRewards(data, stage)
    local rewardAllIDs = string.split(data.rewardID,";")
    local rewardAllNums = string.split(data.rewardNum,";")

    local rewardIDs = rewardAllIDs[stage]
    local rewardNums = rewardAllNums[stage]

    local goodsArr = {}
    if rewardIDs then
        local rewardIDTable = string.split(rewardIDs,",")
        local rewardNumTable = string.split(rewardNums,",")
            -- 防止出错
        if table.nums(rewardIDTable) == table.nums(rewardNumTable) then
            for i, v in ipairs( rewardIDTable ) do
                local data = {}
                data.goodsID = checkint(v)
                data.num = checkint(rewardNumTable[i] or 1)
                data.isGolden = true
                table.insert(goodsArr, data)
            end
        end
    end
    return goodsArr
end

function AchievementCell:onTouchBegan(touch, event)
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location
     local point = self._tableView:convertToWorldSpace(cc.p(0,0))
    local size = self._tableView:getViewSize()
    local rect = cc.rect(point.x, point.y, size.width, size.height)
    if not AvalonUtil:isRectContainsPoint(self._tableView, location) then
        return
    end  



    for k, value in ipairs(self._cellPanels) do
    	local node = value:getChildByName("btnPanel")
        if AvalonUtil:isRectContainsPoint(node, location) and value:isVisible() then
            self.selectIndex = k
            break
        end
    end
end

function AchievementCell:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 
    --检查是否在可点击区域 邮件活动区域
    if not AvalonUtil:isRectContainsPoint(self._tableView, location) then
        return
    end 

    for k, value in ipairs(self._cellPanels) do
    	local node = value:getChildByName("btnPanel")
        if AvalonUtil:isRectContainsPoint(node, location) and self.selectIndex == k and value:isVisible() then
            Avalon.AudioManager:playSound("1503")
            self:iconClick(k)
            break
        end
    end
end