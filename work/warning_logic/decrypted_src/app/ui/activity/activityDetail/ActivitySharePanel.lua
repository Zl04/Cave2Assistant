-- ActivitySharePanel.lua
-- Author:llf
-- 2021年3月8日
-- Using:集换活动子类单个页面

local winSize = cc.Director:getInstance():getWinSize()

require "app.utils.PlaceholderUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local ProtobufUtil = require "utils.ProtobufUtil"

UI = UI or {}

local ActivitySharePanel = class("ActivitySharePanel", UI.HWBtnComponent)
UI.ActivitySharePanel = ActivitySharePanel

local CELL_WIDTH = ACTIVITY_WIDTH

-- 资源文件
local COM_RES_LIST = {
}

local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

function ActivitySharePanel:ctor(tableView)
    ActivitySharePanel.super.ctor(self, UIType.ACTIVITY_DETAIL_EXCHANGE, COM_RES_LIST, 0, 0)

    self.height = 0
    self._startX = 0

    self._touchTableView = tableView

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

function ActivitySharePanel:init(activityData, data, listView)
    self._activityData = activityData
    self._activityID = activityData:getID()
    self._data = data
    self.listView = listView
    ActivitySharePanel.super.init(self)
end

function ActivitySharePanel:dtor()
    ActivitySharePanel.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

function ActivitySharePanel:onInitView()
    self.height = 0

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 标题文字
    local titleBg = UI.Layout:create()
    titleBg:init()
    titleBg:setSize(600, 33)
    titleBg:leftUp(25,10)
    self._contentLayout:addChild(titleBg)

    local maxWidth = 440
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_activity_banner_books.png")
    lineUpImage:setContentSize(maxWidth, 33)
    lineUpImage:setCapInsets(CCRectMake(159,15,1,1))
    lineUpImage:setPosition(cc.p(maxWidth/2, 33/2))
    titleBg:addChild(lineUpImage)

    local nameText = UI.Text:create()
    

    local titleStr = self:getTitle() 
    nameText:init(titleStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    nameText:centerLeft(4)
    titleBg:addChild(nameText)
    self._nameText = nameText
    if(maxWidth - 8 < nameText:getContentSize().width) then 
        nameText:setFixLineWidth(maxWidth - 8)
    end

    self.height = self.height + 33 + 18
    local start = self.height
    local rewards = self._data:getRewards()
    if(rewards) then
        local index = 1
        for i=1,#rewards do 
            if(rewards[index]) then
                for i=1,4 do
                    if(rewards[index]) then
                        local rewardPanel = self:createOneRewardPanel(rewards[index])
                        if(rewardPanel) then
                            rewardPanel:leftUp((i-1)*80 + 25, self.height)
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
    self:refreshJumpButton(start + 75/2)
    self._startX = start + 75/2

    local bottom = UI.Layout:create()
    bottom:init()
    bottom:setSize(630, 1)
    bottom:centerUp(self.height - 1)
    self._contentLayout:addChild(bottom)


    -- if(self._lastOne == false) then
        local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        lineUpImage:setContentSize(630, 1)
        lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
        lineUpImage:setPosition(cc.p(630/2, 1))
        bottom:addChild(lineUpImage)
    -- end
end

function ActivitySharePanel:getShareHeight()
    return self.height
end

function ActivitySharePanel:refreshJumpButton(startCenter)
    if(self._rightLayout) then
        self._rightLayout:removeFromParent(true)
        self._rightLayout = nil
    end

    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:rightUp(0, startCenter)
    self._contentLayout:addChild(rightLayout)
    self._rightLayout = rightLayout


    -- 判断是否为洞穴内，如果为洞穴内就显示盖章的可领取
    if(not SceneManager:getInstance():isInTownOrInHome()) then
        if(self._data:isHaveAward()) then --可领取
            local bg = UI.Image:create()
            bg:init("ui_information_banner_receive.png")
            bg:centerRight(30)
            rightLayout:addChild(bg)

            local completeText = UI.Text:create()
            completeText:init(UI.TEXT_1170937, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
            completeText:center()
            completeText:setRotationSkewX(-9.0)
            completeText:setRotationSkewY(-9.0)
            bg:addChild(completeText)

        elseif(self._data:getIsReceiveEnd()) then --已完成
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
        else --未完成
            local bg = UI.Image:create()
            bg:init("ui_information_banner_unfinished1.png")
            bg:centerRight(30)
            rightLayout:addChild(bg)

            local completeText = UI.Text:create()
            completeText:init(UI.TEXT_111022, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
            completeText:center()
            completeText:setRotationSkewX(-9.0)
            completeText:setRotationSkewY(-9.0)
            bg:addChild(completeText)
        end 
    else 
        local jumpButton = UI.Button:create()
        jumpButton:setTouchClipNode(self._touchTableView)
        jumpButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
        jumpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            -- -- 请求领取奖励
            -- -- 判断背包是否已经满
            -- local goodsArr = {}
            -- local goodsDataArr = {}
            -- local rewards = self._data:getRewards()
            -- if(rewards) then
            --     for i=1,#rewards do 
            --         local reward = rewards[i]
            --         if(reward) then
            --             local data = {}
            --             data.goodsID = reward.id
            --             data.num = reward.num
            --             data.isGolden = true
            --             table.insert(goodsArr, data)
            --             local goodsData = GoodsDataManager:createLocalGoodsData(reward.id)
            --             if(goodsData) then 
            --                 goodsData:setNum(reward.num)
            --                 table.insert(goodsDataArr, goodsData)
            --             end
            --         end
            --     end
            -- end

            -- local  useGoodsData = GoodsDataManager:createLocalGoodsData(self._data:getCostID())
            -- useGoodsData:setNum(self._data:getCostNum())
            -- require "app.ui.tips.ExchaneGoodsTips"
            -- -- reload_script_file("app.ui.tips.ExchaneGoodsTips")
            -- local tips = UI.ExchaneGoodsTips:create()
            -- tips:init(useGoodsData, goodsDataArr)
            -- tips:center()
            -- tips:callfunName(function()
            --     if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) == false) then 
            --         UI.ScrollBar:createByTextID(1110793)
            --         return
            --     else 
            --         if (RoleBehaviorManager:activityRewardCheck() and not tolua.isnull(self)) then 
            --             Net.NetActivitySystem:requestActivityReward(self._activityID, 0)
            --             Avalon.AudioManager:playSound("1509")
            --             jumpButton:disable()
            --         end 
            --     end
            -- end)

            -- UI.UIManager:getRootNode():addChild(tips, UI_ZORDER.EQUIPMENTINFO)

            -- 请求领取奖励
            -- 判断背包是否已经满
            local goodsArr = {}
            local rewards = self._data:getRewards()
            if(rewards) then
                for i=1,#rewards do 
                    local reward = rewards[i]
                    if(reward) then
                        local data = {}
                        data.goodsID = reward.id
                        data.num = reward.num
                        data.isGolden = true
                        table.insert(goodsArr, data)
                    end
                end
            end

            if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) == false) then 
                UI.ScrollBar:createByTextID(1110793)
                return
            else 
                if (RoleBehaviorManager:activityRewardCheck()) then 
                    Net.NetActivitySystem:requestActivityReward(self._activityID, 0)
                    Avalon.AudioManager:playSound("1509")
                    jumpButton:disable()
                end 
            end
        end)

        local text = UI.Text:create()
        text:init(UI.TEXT_1212001, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        text:center()
        jumpButton:addChild(text,10)
        jumpButton:centerRight(30)
        rightLayout:addChild(jumpButton)

        if (self._data:isHaveAward()) then
            text:setText(UI.TEXT_1212001)
        elseif (self._data:getIsReceiveEnd()) then
            text:setText(UI.TEXT_1110721)
            jumpButton:disable()
        else
            text:setText(UI.TEXT_111022)
            jumpButton:disable()
        end

        -- if (self._data:isHaveAward() == false and self._data:getIsReceiveEnd()) then
        --     text:setText(UI.TEXT_1110721)
        --     jumpButton:disable()
        -- elseif (self._data:isHaveAward() == false and self._data:getIsReceiveEnd() == false) then
        --     text:setText(UI.TEXT_111022)
        --     jumpButton:disable()
        -- end

        -- local key = self._activityID..":"..self._data:getID()

        -- local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.ACTIVITY_REWARD)
        -- if(repeatData and repeatData[key] or self._activityData:isInEffect() == false or self._data:getIsReward() == false or self._data:getIsReceiveEnd()) then
        --     jumpButton:disable()
        -- end
    end 
end

function ActivitySharePanel:rewardResult(data)
    if(tolua.isnull(self)) then
        return
    end
    if(self._activityData:getID() ~= data.id) then
        return
    end
    -- if(self._data:getID() == data.subId) then
    --     if(data.result == "ActivityRewardResult_Succeed") then 
    --         -- Avalon.AudioManager:playSound("1509") --音效改为在点击过后立马播放
    --     else 
    --         GameErrorManager:showError(ProtobufUtil:enum_id("ActivitySystem.ActivityRewardResultType", data.result))
    --     end
    --     -- print("ActivitySharePanel:rewardResult handle")
        
    -- end 
    self:refreshJumpButton(self._startX)

    if(not tolua.isnull(self._nameText)) then 
        self._nameText:setText(self:getTitle())
    end
end

function ActivitySharePanel:createOneRewardPanel(reward)
    if(reward) then
        local goodsData = GoodsDataManager:createLocalGoodsData(reward.id)
        if(goodsData) then
            goodsData:setNum(reward.num)
            goodsData:setIsNew(false)

            local goodsGrid = UI.GoodsGrid:create()
            goodsGrid:setTouchClipNode(self.listView)
            goodsGrid:centerUp(0)
            goodsGrid:init(goodsData)
            
            goodsGrid:showInfoArea(true, false)

            return goodsGrid
        end

    end

    return nil 
end

function ActivitySharePanel:getTitle()
    return UI.TEXT_1325601
end