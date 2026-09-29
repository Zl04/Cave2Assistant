--
-- Author: Your Name
-- Date: 2017-10-16 18:30:38
--
UI = UI or {}

local AchievementCellInfo = class("AchievementCellInfo", UI.HWBtnComponent)
local CELL_SIZE = cc.size(213, 215)

UI.AchievementCellInfo = AchievementCellInfo
local SMALL_SIZE = cc.size(306, 250)
local BIG_SIZE = cc.size(306, 340)

function AchievementCellInfo:ctor(aData, cfgData, isSmall)
    if isSmall then
	    UI.AchievementCellInfo.super.ctor(self, 0, {}, SMALL_SIZE.width, SMALL_SIZE.height)
    else
        UI.AchievementCellInfo.super.ctor(self, 0, {}, BIG_SIZE.width, BIG_SIZE.height)
    end
    self._isSmall = isSmall
    self._aData = aData
    self._cfgData = cfgData
    self._infoArea = nil
    self.rewardItems = {}
	self:init()
    self:setTouchEnable(true)
    -- self:setInterceptTouches(true)
    self:registerListener()
end

-- 析构函数
function AchievementCellInfo:dtor()
    AchievementCellInfo.super.dtor(self)
    self:unRegisterListener()
end

-- 注册监听事件(可选)
function AchievementCellInfo:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end

-- 注销监听事件(可选)
function AchievementCellInfo:unRegisterListener()
end

function AchievementCellInfo:onTouchDialogOutsizeHandler()
    self:close()
end


function AchievementCellInfo:onInitView()
    local upLayout = UI.TouchLayout:create()
    upLayout:init(0, 0, 0, 0)
    if self._isSmall then
        upLayout:setSize(SMALL_SIZE.width, SMALL_SIZE.height)
    else
        upLayout:setSize(BIG_SIZE.width, BIG_SIZE.height)
    end
    upLayout:center()
    upLayout:addTouchEvents(self)
    self:addChild(upLayout)
    self._upLayout = upLayout

    local bg = UI.Image:create()
    if self._isSmall then
        bg:init("ui_iteminfo_role_banner_box3.png")
    else
        bg:init("ui_iteminfo_role_banner_box1.png")
    end
    bg:showLucencyLight(bg:getContentSize().width, bg:getContentSize().height)
    bg:center()
    upLayout:addChild(bg)
    self._bg = bg

    local name = UI.Text:create()
    name:init(self._cfgData.name, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_249_220_103)
    name:leftUp(27, 21)
    name:setWidth(300)
    bg:addChild(name)
    name:autoAdapt()
    name:setLineSpacing(-5)

    local content = UI.Text:create()
    content:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
    content:setSize(270, 55)
    content:setTextLeftUp()
    content:setTextVerticalCenter()
    content:setLineSpacing(-4)
    bg:addChild(content)

    if self._isSmall then
        content:leftUp(27, 80)

        local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        line:setContentSize(290, 1)
        line:setAnchorPoint(0, 0)
        line:setPosition(16,130)
        bg:addChild(line)
    else
        content:leftUp(27, 100)
    
        local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        line:setContentSize(290, 1)
        line:setAnchorPoint(0, 0)
        line:setPosition(16,250)
        bg:addChild(line)

        local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        line:setContentSize(290, 1)
        line:setAnchorPoint(0, 0)
        line:setPosition(16,60)
        bg:addChild(line)
    end
    
    local maxStage = table.nums(self._cfgData.goal)
    local current = 0
    local targetNum = 0
    local stage = 0

    if self._aData ~= nil then
        current = self._aData.count
        stage = self._aData.rewardStage 
    end
    require "app.utils.PlaceholderUtil"
    local description = PlaceholderUtil:formatName(self._cfgData.description, self._cfgData.targetID)

    if self._cfgData.countType == 1 then
        targetNum = self._cfgData.goal[maxStage]
        content:setText(string.format(description,targetNum))
    else
        targetNum = self._cfgData.goal[1]
        content:setText(description)
    end
    content:autoAdapt()

    local progress = UI.Text:create()
    progress:init(string.format("%d/%d", current, targetNum), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    progress:leftUp(27, name:getUp() + name:getContentSize().height)
    bg:addChild(progress)


    if stage >= maxStage then--已经领完奖励 --显示完成时间
        local finishTitle = UI.Text:create()
        finishTitle:init(UI.TEXT_1170607, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        finishTitle:leftUp(28, 182)
        bg:addChild(finishTitle)

        local finishTime = UI.Text:create()
        finishTime:init(GameManager:getNowServerDate("%Y.%m.%d %H:%M:%S", (self._aData.reachDateSec or 0) + GameManager:getEPOCHTime()), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
        finishTime:leftUp(28, 214)
        bg:addChild(finishTime)
        progress:hide()
    else--显示奖励
        self:showReward(stage)
        progress:show()
    end
end

function AchievementCellInfo:showReward(stage)
    local rewardAllIDs = string.split(self._cfgData.rewardID,";")
    local rewardAllNums = string.split(self._cfgData.rewardNum,";")

    local rewardIDs = rewardAllIDs[stage + 1] or {}
    local rewardNums = rewardAllNums[stage + 1] or {}

    local goodsArr = {}
    local rewardIDTable = string.split(rewardIDs,",")
    local rewardNumTable = string.split(rewardNums,",")
    local virtualitemAchs = {}
    local achRewardNum = 0
    for i, v in ipairs(rewardIDTable) do
        local goodData = GoodsDataManager:createLocalGoodsData(tonumber(v))
        if(goodData) then
            goodData:setNum(tonumber(rewardNumTable[i] or 0))
            goodData:setIsNew(false)
            if  goodData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
                if goodData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemAchievementPoint then
                    table.insert(virtualitemAchs, goodData)
                    achRewardNum = tonumber(rewardNumTable[i] or 0)
                else
                    table.insert(goodsArr, goodData)
                end
            else
                table.insert(goodsArr, goodData)
            end
        end
    end
    if achRewardNum > 0 then
        local achTitle = UI.Text:create()
        achTitle:init(UI.TEXT_1170600, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        achTitle:leftBottom(27, 24)
        self._bg:addChild(achTitle)
       
        local achIcon = UI.Image:create()
        achIcon:init("ui_information_achievement.png")
        achIcon:leftBottom(achTitle:getLeft() + achTitle:getContentSize().width + 4, 27.5)
        self._bg:addChild(achIcon)

        local achNum = UI.Text:create()
        achNum:init(achRewardNum.."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_244_219_46)
        achNum:leftBottom(achIcon:getLeft() + achIcon:getContentSize().width + 3, 24)
        self._bg:addChild(achNum)
    end

    local rewardTitle = UI.Text:create()
    rewardTitle:init(UI.TEXT_111030, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    rewardTitle:leftUp(27, 170)
    self._bg:addChild(rewardTitle)
    local beginPosY = 163
    for k, v in ipairs(goodsArr) do
        local goodGrid = self:createGoodsGrid(v)
        local index = math.ceil(k / 3)
        goodGrid:leftUp(18 + (k - (index - 1) * 3 - 1) * 91, beginPosY + (index - 1) * 82)
    end
end

function AchievementCellInfo:createGoodsGrid(goodData)
    local goodGrid = UI.GoodsGrid:create()
    goodGrid:init(goodData)
    goodGrid:setInfoArea(true, false)
    self._upLayout:addChild(goodGrid)
    goodGrid:hideFlagIcon()
    goodGrid:showCountLabel()
    table.insert(self.rewardItems, goodGrid)
    return goodGrid
end


function AchievementCellInfo:onUpdateView()

end

function AchievementCellInfo:onTouchBegan(touch, event)
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location
    for k, value in ipairs(self.rewardItems) do
        if AvalonUtil:isRectContainsPoint(value, location) then
            self.selectIndex = k
            break
        end
    end
end

function AchievementCellInfo:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 
    for k, value in ipairs(self.rewardItems) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
            value:onShowInfoAreaHandler(true)
            break
        end
    end
end