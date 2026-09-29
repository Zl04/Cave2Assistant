-- ExtraDropPanel.lua
-- Author:zp
-- 2017年12月22日
-- Using:额外奖励活动单个页面

local winSize = cc.Director:getInstance():getWinSize()

require "app.utils.PlaceholderUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local ExtraDropPanel = class("ExtraDropPanel", UI.HWBtnComponent)
UI.ExtraDropPanel = ExtraDropPanel

local DEBUG = true

local CELL_WIDTH = ACTIVITY_WIDTH

-- 资源文件
local COM_RES_LIST = {
}

local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

function ExtraDropPanel:ctor()
    ExtraDropPanel.super.ctor(self, UIType.ACTIVTIY_DETAIL_EXTRA_DROP, COM_RES_LIST, 0, 0)

    self.height = 0
end

function ExtraDropPanel:init(data, lastOne, listView)
    self._data = data
    self._lastOne = lastOne
    if(self._lastOne == nil) then 
        self._lastOne = false
    end
    self.listView = listView
    ExtraDropPanel.super.init(self)
end


function ExtraDropPanel:dtor()
    ExtraDropPanel.super.dtor(self)

end

function ExtraDropPanel:onInitView()
    self.height = 0

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 标题文字
    local titleLayout = UI.Layout:create()
    titleLayout:init()
    titleLayout:setSize(600, 33)
    titleLayout:leftUp(25,10)
    -- local titleBg = UI.Image:create()
    -- titleBg:init("ui_activity_banner_books.png")
    -- titleBg:leftUp(25,10)
    self._contentLayout:addChild(titleLayout)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_activity_banner_books.png")
    lineUpImage:setContentSize(600, 33)
    lineUpImage:setCapInsets(CCRectMake(159,15,1,1))
    lineUpImage:setPosition(cc.p(300, 33/2))
    titleLayout:addChild(lineUpImage)


    local nameText = UI.Text:create()
    nameText:init(self:getTitle(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    -- nameText:leftUp(25,5)
    nameText:centerLeft(4)
    titleLayout:addChild(nameText)
    self.height = self.height + 33 + 18
    
    local start = self.height
    local rewards = self._data:getRewards()
    if(rewards) then
        local index = 1
        for i=1,#rewards do 
            if(rewards[index]) then
                for i=1,2 do
                    if(rewards[index]) then
                        local rewardPanel = self:createOneRewardPanel(rewards[index])
                        if(rewardPanel) then
                            rewardPanel:leftUp((i-1)*190 + 25, self.height)
                            self._contentLayout:addChild(rewardPanel)
                        end
                        index = index + 1
                    else
                        break
                    end 
                end

                self.height = self.height + 80
            end 
        end
    end

    self._contentLayout:setSize(CELL_WIDTH, self.height)
    self:setSize(CELL_WIDTH, self.height)
    -- 添加跳转页面
    self:initJumpButton(start + 75/2)

    if(self._lastOne == false) then
        local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
        lineUpImage:setContentSize(630, 1)
        lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
        lineUpImage:setPosition(cc.p(630/2, 1))
        self:addChild(lineUpImage)
    end
end

function ExtraDropPanel:getExtraDropHeight()
    return self.height
end

function ExtraDropPanel:initJumpButton(startCenter)
    if(self._rightLayout) then
        self._rightLayout:removeFromParent(true)
        self._rightLayout = nil
    end

    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:rightUp(0, startCenter)
    self._contentLayout:addChild(rightLayout)
    self._rightLayout = rightLayout

    -- 根据类型来计算按钮文字
    if(self._data:getIsComplete()) then
        local bg = UI.Image:create()
        bg:init("ui_information_banner_receive.png")
        bg:centerRight(30)
        rightLayout:addChild(bg)

        local completeText = UI.Text:create()
        completeText:init(UI.TEXT_111021, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
        completeText:center()
        completeText:setRotationSkewX(-9.0)
        completeText:setRotationSkewY(-9.0)
        bg:addChild(completeText)
    else 
        local jumpStr = self._data:getJumpStr()
        if(jumpStr and jumpStr ~= "") then
            local jumpButton = UI.Button:create()
            jumpButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
            jumpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                -- TODO 根据条件来判断如何处理该逻辑
                GameManager:openUrl(jumpStr)
            end)

            local text = UI.Text:create()
            text:init(LanguageManager:getInstance():getLocalString(1110941), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
            text:center()
            jumpButton:addChild(text,10)
            jumpButton:centerRight(30)
            rightLayout:addChild(jumpButton)
        end 
    end 
end

function ExtraDropPanel:createOneRewardPanel(reward)
    if(reward) then
        local goodsData = GoodsDataManager:createLocalGoodsData(reward.id)
        if(goodsData) then
            goodsData:setNum(reward.num)
            goodsData:setIsNew(false)

            local contentLayout = UI.Layout:create()
            contentLayout:init()
            contentLayout:setSize(195, 70)

            local goodsGrid = UI.GoodsGrid:create()
            goodsGrid:setTouchClipNode(self.listView)
            self._goodsGrid = goodsGrid
            self._goodsGrid:centerLeft(0)
            self._goodsGrid:init(goodsData)
            contentLayout:addChild(self._goodsGrid, 1)

            goodsGrid:showInfoArea(true, false)

            -- 显示当前数值
            local numText = UI.Text:create()

            -- 优化显示表现
            local dropNum = reward.dropNum 
            if(dropNum > reward.max) then
                dropNum = reward.max
            end
            numText:init(string.format("%d/%d", dropNum, reward.max),UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_209_190_140)
            numText:centerLeft(80)
            contentLayout:addChild(numText, 1)

            return contentLayout
        end

    end

    return nil 
end

function ExtraDropPanel:getTitle()
    local type = self._data:getType()
    local littleType = self._data:getLittleType()

    local typeData = 100000000
    local titleStr = ""
    if(type == PublicDefine.QuestConditionType.QuestConditionType_Killing) then
        --杀怪(目标ID 0为所有)
        if(littleType == 0) then
            titleStr = LanguageManager:getInstance():getLocalString(1270001)
        else
            local diffculty = math.modf(littleType / typeData)
            local templateID = littleType - diffculty * typeData
            local mode = math.modf(diffculty / 100)
            diffculty = diffculty - mode * 100
            -- print("QuestConditionType_Killing =", mode, diffculty, templateID)
            -- local modelStr = ToolsUtil:getModeStr(mode)
            -- local diffcultyStr = ToolsUtil:getDiffcultyStr(diffculty)
            -- -- print("ddfdfdfd =", templateID, string.format(LanguageManager:getInstance():getLocalString(1270002), diffcultyStr))
            -- titleStr = PlaceholderUtil:formatName(string.format(LanguageManager:getInstance():getLocalString(1270002), modelStr), templateID, mode, diffculty)
            local modelStr = ToolsUtil:getModeStr(mode)
            local diffcultyStr = ToolsUtil:getDiffcultName(diffculty)
            titleStr = PlaceholderUtil:formatName(string.format(LanguageManager:getInstance():getLocalString(1271002), AvalonUtil:_getModeStr(mode,diffculty)), templateID, mode, diffculty)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_KillingBoss) then 
        --击杀BOSS ()
        local diffculty = math.modf(littleType / typeData)
        local templateID = littleType - diffculty * typeData
        local mode = math.modf(diffculty / 100)
        diffculty = diffculty - mode * 100
        local modelStr = ToolsUtil:getModeStr(mode)

        titleStr = string.format(LanguageManager:getInstance():getLocalString(1271003), AvalonUtil:_getModeStr(mode, diffculty))
        -- titleStr = string.format(LanguageManager:getInstance():getLocalString(1270003), modelStr)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_NPCOper) then 
        --完成NPC操作(FUNCTION_TYPE) 
        if(littleType == PublicDefine.FUNCTION_TYPE.LUCKYWHEEL_TURN) then 
            -- 使用转盘有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270004)
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN then
            titleStr = LanguageManager:getInstance():getLocalString(1270005)
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_DECOMPOSE then
            titleStr = LanguageManager:getInstance():getLocalString(1270007)
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_REMODEL then
            titleStr = LanguageManager:getInstance():getLocalString(1270008)
        elseif littleType == PublicDefine.FUNCTION_TYPE.BLACK_MARKET then
            titleStr = LanguageManager:getInstance():getLocalString(1270009)
        elseif littleType == PublicDefine.FUNCTION_TYPE.CAT_FOOD then
            titleStr = LanguageManager:getInstance():getLocalString(1270010)
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_FORGE then
            titleStr = LanguageManager:getInstance():getLocalString(1270011)
        elseif littleType == PublicDefine.FUNCTION_TYPE.ENCHANT then
            titleStr = LanguageManager:getInstance():getLocalString(1270006)
        elseif littleType == PublicDefine.FUNCTION_TYPE.GOLD_TOUCH then
            titleStr = LanguageManager:getInstance():getLocalString(1270012)
        elseif littleType == PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_GET then
            titleStr = LanguageManager:getInstance():getLocalString(1112802) --"使用占星有机会获得"
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIP_RECAST then
            titleStr = LanguageManager:getInstance():getLocalString(1112803) --"使用重铸有机会获得"
        end

    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_NPCOperSuc) then 
        -- 处理NPC成功触发
        if(littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN) then
            -- 强化成功有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270013)
        elseif (littleType == PublicDefine.FUNCTION_TYPE.ENCHANT) then
            -- 附魔成功有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270014)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Collection) then 
        --完成收集 (目标ID 0为所有)
        if(littleType == 0) then 
            titleStr = LanguageManager:getInstance():getLocalString(1270015)
        else
            titleStr = PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(1270016), littleType)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_CollectionCoin) then 
        -- 完成收集金币 
        titleStr = LanguageManager:getInstance():getLocalString(1270017)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_LoginOut) then 
        --登录 (1 连续登录 2累计登录)
        if(littleType == 1) then 
            titleStr = LanguageManager:getInstance():getLocalString(1270018)
        elseif littleType == 2 then
            titleStr = LanguageManager:getInstance():getLocalString(1270019)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_DiamodCost) then 
        --水晶消耗   
        if littleType == 1 then
            -- 累积消耗
            titleStr = LanguageManager:getInstance():getLocalString(1270020)
        elseif littleType == 2 then
            -- 黑市消耗水晶
            titleStr = LanguageManager:getInstance():getLocalString(1270021)
        elseif littleType == 3 then
            -- 料理消耗水晶
            titleStr = LanguageManager:getInstance():getLocalString(1270022)
        elseif littleType == 4 then
            -- 改造消耗水晶
            titleStr = LanguageManager:getInstance():getLocalString(1270023)
        elseif littleType == 5 then
            -- 黑市水晶够买有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270024)
        elseif littleType == 6 then
            -- 购买宝箱消耗水晶有机会获得
            titleStr = UI.TEXT_1172020
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_EnterCave) then 
        -- 进洞探险(1.进入普通洞窟 3.进入大秘境 2组队进入大秘境 )
        if(littleType == 1) then
            -- 探索洞窟有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270025)
        elseif (littleType == 2) then 
            -- 参与大秘境有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270026)
        elseif (littleType == 3) then 
            -- 参与大秘境（组队）有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270027)
        elseif (littleType == 4) then 
            -- 进入英雄洞窟(单人+组队)
            titleStr = UI.TEXT_1172031
        elseif (littleType == 5) then 
            -- 进入沙之眼洞窟(单人+组队))    组队探索深渊有机会获得
            titleStr = LanguageManager:getInstance():getLocalString(1112804)--"探索沙之眼有机会获得："
        elseif (littleType == 6) then 
            -- 进入扭曲空间洞窟(单人+组队)) 
            titleStr = LanguageManager:getInstance():getLocalString(1112805)--"探索扭曲空间有机会获得："
        elseif (littleType == 7) then 
            -- 进入扭曲空间困难洞窟(单人+组队))
            titleStr = LanguageManager:getInstance():getLocalString(1112806)--"探索扭曲空间(困难)有机会获得："
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_LeaveCave) then 
        -- 探险完成(1,单人普通成功2组队普通成功  )
        if(littleType == 1) then
            -- 成功探索洞窟有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270028)
        elseif (littleType == 2) then
            -- 成功探索洞窟（组队）有机会获得：
            titleStr = LanguageManager:getInstance():getLocalString(1270029)
        elseif (littleType == 3) then
            titleStr = UI.TEXT_1172029
        elseif (littleType == 4) then
            -- 成功探索沙之眼洞窟成功（单人+组队）)
            titleStr = LanguageManager:getInstance():getLocalString(1112807) --"成功探索沙之眼有机会获得："
        elseif (littleType == 5) then
            -- 成功探索扭曲空间洞窟成功（单人+组队） )
            titleStr = LanguageManager:getInstance():getLocalString(1112808) --"成功探索扭曲空间有机会获得："
        elseif (littleType == 6) then
            -- 成功探索扭曲空间困难洞窟成功（单人+组队） )
            titleStr = LanguageManager:getInstance():getLocalString(1112809) --"成功探索扭曲空间（困难）有机会获得："
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_ArrivalLevel) then 
        --到达指定层数(模式难度层数复合字段)
        -- TODO 拆分字段   01:01:1001  模式:难度:层数
        local caveMode = 1
        local diffculty = 1
        local level = 23

        local value = checkint(littleType)
        caveMode = math.modf(value/1000000)
        value = value - 1000000 * caveMode
        diffculty = math.modf(value/10000)
        value = value - 10000 * diffculty    
        level = value

        local modeStr = ToolsUtil:getModeStr(caveMode)
        local levelStr = tostring(level)
        local diffcultyStr = ToolsUtil:getDiffcultName(diffculty)

        titleStr = string.format(LanguageManager:getInstance():getLocalString(1270030), AvalonUtil:_getModeStr(caveMode, diffculty), levelStr, diffcultyStr)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_AchievementPoint) then 
        --成就
        titleStr = LanguageManager:getInstance():getLocalString(1270031)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_EquipScore) then 
        --装备
        titleStr = string.format(LanguageManager:getInstance():getLocalString(1270032),littleType)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Guild) then  
        --公会
        titleStr = LanguageManager:getInstance():getLocalString(1270033)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Rechage) then  
        --充值
        if(littleType == 0) then 
            titleStr = LanguageManager:getInstance():getLocalString(1270034)
        else 
            titleStr = string.format(LanguageManager:getInstance():getLocalString(1270035), littleType)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_BoxBought) then
        titleStr = UI.TEXT_1172020
    -- elseif (type == PublicDefine.QuestConditionType.QuestConditionType_GemStoneType) then

    -- elseif (type == PublicDefine.QuestConditionType.QuestConditionType_GemStoneLevel) then
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_OpenBox) then
        local targetStr = ""
        -- 陶罐
        if(littleType == PublicDefine.BOX_TYPE.BOX_POT) then 
            targetStr = UI.TEXT_1212520
        -- 骨头堆
        elseif (littleType == PublicDefine.BOX_TYPE.BOX_BONE) then 
            targetStr = UI.TEXT_1212521
        -- 木宝箱
        elseif (littleType == PublicDefine.BOX_TYPE.BOX_WOOD) then 
            targetStr = UI.TEXT_1212522
        -- 金宝箱
        elseif (littleType == PublicDefine.BOX_TYPE.BOX_GOLD) then 
            targetStr = UI.TEXT_1212523
        end

        titleStr = string.format(UI.TEXT_1212518, targetStr) 
    else 
        printError("ExtraDropPanel no handle type=", type)
    end
    -- TODO 后续需要处理的

    return titleStr
end

