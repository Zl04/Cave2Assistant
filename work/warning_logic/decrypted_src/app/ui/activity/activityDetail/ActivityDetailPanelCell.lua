-- ActivityDetailPanelCell.lua
-- Author:zp
-- 2017年12月20日
-- Using:任务活动详情 cell

require "app.ui.activity.activityDetail.ExtraDropPanel"
require "app.ui.activity.activityDetail.QuestConditionPanel"
require "app.ui.activity.activityDetail.GuildQuestConditionPanel"
require "app.ui.activity.ActivityDetailNode"
require "app.ui.activity.activityDetail.EmailBindPanel"
require "app.ui.activity.activityDetail.CaveActivityCell"
require "app.ui.activity.activityDetail.ExchangeActivityPanel"
require "app.ui.activity.activityDetail.ActivitySharePanel"

local LanguageManager = require("app.game.LanguageManager")
local SdkManager = require"app.game.SdkManager"
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local ActivityDetailPanelCell = class("ActivityDetailPanelCell",UI.TableViewCell)
UI.ActivityDetailPanelCell = ActivityDetailPanelCell

local BG_BIG = "ui_activity_banner_no_found_big.png"
local BG_LITTLE = "ui_activity_banner_no_found_little.png"

local CELL_WIDTH = ACTIVITY_WIDTH

function ActivityDetailPanelCell:ctor(tableView)
    self._totalHeight = 0
    self._titleHeight = 0

    self._touchBegin = false
    self._tableView = tableView
end

function ActivityDetailPanelCell:onEnter()
    ActivityDetailPanelCell.super.onEnter(self)
    -- print("ActivityDetailPanelCell:onEnter")
end

function ActivityDetailPanelCell:onExit()
    ActivityDetailPanelCell.super.onExit(self)
    -- print("GuildManagerPanel:onExit")
    self._touchBegin = false
    self._loading = nil
end

function ActivityDetailPanelCell:init(data, listView, activityPanel)
    self._data = data
    self.listView = listView
    self.activityPanel = activityPanel
    self:onInitView()
end

function ActivityDetailPanelCell:hightLight()
    if(self.touchImage == nil) then 
        self.touchImage = UI.Image9:create()
        self.touchImage:init("ui_information_selectedbox.png", CCRectMake(16,15,1,1), cc.size(CELL_WIDTH, self._baseHight))
        self.touchImage:centerUp(0)
        self._activityLayout:addChild(self.touchImage, 100)
    end
    self.touchImage:setVisible(true)
end

function ActivityDetailPanelCell:unHightLight()
    if(self.touchImage) then 
        self.touchImage:setVisible(false)
    end
end

function ActivityDetailPanelCell:onInitView()
    self._totalHeight = 0
    self._titleHeight = 0

    local activityLayout = UI.Layout:create()
    activityLayout:init()

    local baseHeight = ACTIVITY_LITTLE_HEIGHT

    if(self._data.imgType == 0) then 
        baseHeight = ACTIVITY_LITTLE_HEIGHT
    else 
        baseHeight = ACTIVITY_BIG_HEIGHT
    end 

    self._baseHight = baseHeight
    activityLayout:setSize(CELL_WIDTH, baseHeight)
    self:addChild(activityLayout)
    self._activityLayout = activityLayout

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(CELL_WIDTH, baseHeight)
    
    self._activityLayout:addChild(contentLayout)
    self._contentLayout = contentLayout

    self:initActivityTitle()

    self:initActivityDetail()
    self:initQuestCondition()
    self:initGuildQuestCondition()
    self:initExtraDrop()
    self:initCaveActivity()
    self:initExchange()
    self:initBindEmail()
    self:initActivityShare()

    

    -- 添加下边框
    self._totalHeight = self._totalHeight + 5

    -- yuanImage:setContentSize(CELL_WIDTH + 22 - 6, self._totalHeight)

    -- print(" ActivityDetailPanelCell:  ", self._totalHeight, self._titleHeight)
    contentLayout:setSize(CELL_WIDTH, self._totalHeight)
    contentLayout:leftBottom(-8, 0)
    contentLayout:refreshPosition()

    if(self._data.isOpen) then
        self._activityLayout:setSize(CELL_WIDTH, self._totalHeight + self._titleHeight)
    else 
        self._activityLayout:setSize(CELL_WIDTH, self._titleHeight)
    end
    activityLayout:leftBottom(0, 0)

    -- 添加了一个加载数据中的处理
    if(self._data:getIsInit() == false) then 
        local loadingPanel = UI.WaitingLayer:createLittleWaitingWithSize(cc.size(CELL_WIDTH, baseHeight), self._activityLayout, 120)
        loadingPanel:center()
        -- loadingPanel:setVisible(false)
        self._loading = loadingPanel
    end 

    self._activityLayout:refreshPosition()

    self:updateDetail()
end

function ActivityDetailPanelCell:updateDetail()
    if(self._data.isOpen) then
        self._contentLayout:setSize(CELL_WIDTH, self._totalHeight)
        self._contentLayout:leftBottom(-8, 0)
        self._contentLayout:refreshPosition()
        self._contentLayout:setVisible(true)
        -- self._yuanImage:setVisible(true)
        if(self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_MailBinding_Open)
            Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_MailBinding, 1, self._data.id)
        end
    else
        self._contentLayout:setVisible(false)

        self._contentLayout:setSize(CELL_WIDTH, self._totalHeight)
        self._contentLayout:leftBottom(-1000008, 0)
        self._contentLayout:refreshPosition()
        -- Avalon.Scheduler:scheduleUpdateOnce(self, function()
        --     self._contentLayout:removeAllChildren()
        -- end, 0)
        

        -- self._yuanImage:setVisible(false)
    end 
end

function ActivityDetailPanelCell:getHeight()
    if(self._data.isOpen) then
        return self._totalHeight + self._titleHeight
    else 
        return self._titleHeight
    end
end

function ActivityDetailPanelCell:getOpenHeight()
    return self._totalHeight + self._titleHeight
end

function ActivityDetailPanelCell:getDesHeight()
    return self._totalHeight
end

function ActivityDetailPanelCell:getTitleHeight()
    return self._titleHeight
end

function ActivityDetailPanelCell:getTouchBegin()
    return self._touchBegin
end

function ActivityDetailPanelCell:clearTouchBegin()
    self._touchBegin = false
end

function ActivityDetailPanelCell:initActivityTitle()
    local titleGrap = 0
    -- 计算大小
    local bgHeight = ACTIVITY_BIG_HEIGHT
    local bgSpriteName = BG_BIG
    if(self._data.imgType == 0) then 
        bgSpriteName = BG_LITTLE
        bgHeight = ACTIVITY_LITTLE_HEIGHT
    end

    local bg = UI.Image:create()
    bg:init(bgSpriteName)
    -- bg:leftUp(16-3, 0)
    bg:leftUp(0, 0)
    self._activityLayout:addChild(bg, 2)

    local activityDetailNode = UI.ActivityDetailNode:create()
    activityDetailNode:init(self._data)
    activityDetailNode:centerLeft(0)
    bg:addChild(activityDetailNode,2)
    
    self:handleTouchBegin(bg)

    self._totalHeight = self._totalHeight + bgHeight + titleGrap
    self._titleHeight = self._totalHeight
    self._totalHeight = 0
end

function ActivityDetailPanelCell:handleTouchBegin(node)
    -- 点击开始
    local function onTouchBegan(touch, event)
        if(self._loading) then 
            return false
        end
        local touchPosition = touch:getLocation()
        node:setTouchClipNode(self.listView)
        local touched = node:checkTouch(touch)
        
        if (touched) then
            self._touchBegin = true
        else 
            self._touchBegin = false
        end
        -- print("ActivityDetailPanelCell:handleTouchBegin", self._touchBegin)

        return false
    end
    -- 点击移动
    local function onTouchMoved(touch, event)
        
    end
    -- 点击结束
    local function onTouchEnded(touch, event)
        
    end

    -- 注册点击监听事件
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_CANCELLED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node)
end

-- 初始化活动描述
function ActivityDetailPanelCell:initActivityDetail()
    local height = 0
    local contentGap = 10
    local timeGap = 20

    -- 处理总的跳转
    local jumpStr = self._data:getJumpStr()
    local addJumBtn = false
    if self._data:getType() == PublicDefine.ActivityType.ActivityType_LuckyLottery then
        local jumpButton = UI.Button:create()
        jumpButton:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
        jumpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            if self._data:getLotteryData():getLevelLimit() > RoleDataManager:getMaster():getLevel() then
                UI.ScrollBar:createByTextID(1170125)
                return
            end
            self.activityPanel:close()
            mvc.openPanel("TradeActivity", "TradeActivityMain", PublicDefine.TradeActivityIDList.TradeActivityLottery)
            -- mvc.openPanel("ActivityLottery", "ActivityLottery")
        end)
        jumpButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            UI.ScrollBar:createByText(UI.TEXT_1212609)
        end)

        jumpButton:setText(LanguageManager:getInstance():getLocalString(1110940), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        jumpButton:setTouchClipNode(self.listView)
        jumpButton:centerUp(self._totalHeight + height + 2)
        self._contentLayout:addChild(jumpButton, 2)
        timeGap = 20
        if self._data:isInEffect() and SceneManager:getInstance():isInTownOrInHome() then
            jumpButton:enable()
        else
            jumpButton:disable()
        end
        addJumBtn = true
    elseif (self._data:getType() == PublicDefine.ActivityType.ActivityType_Share) then
        -- local jumpButton = UI.Button:create()
        -- jumpButton:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
        -- jumpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        --     --弹出
        -- end)

        -- jumpButton:setText(UI.TEXT_1325600, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        -- jumpButton:setTouchClipNode(self.listView)
        -- jumpButton:centerUp(self._totalHeight + height + 2)
        -- self._contentLayout:addChild(jumpButton, 2)
        self:createShareGroup(height);
        timeGap = 20
        addJumBtn = true
        
    elseif(jumpStr and jumpStr ~= "") then 
        local jumpGap = 8
        local jumpButton = UI.Button:create()
        jumpButton:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
        jumpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            -- 处理条状逻辑
            GameManager:openUrl(jumpStr)
        end)
        
        local text = UI.Text:create()
        text:init(LanguageManager:getInstance():getLocalString(1110940), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        text:setFontSize(20)
        text:center()
        jumpButton:addChild(text,10)
        jumpButton:setTouchClipNode(self.listView)
        jumpButton:centerUp(self._totalHeight + height + jumpGap)
        self._contentLayout:addChild(jumpButton, 2)
        timeGap = 20

        if(not SceneManager:getInstance():isInTownOrInHome()) then 
            jumpButton:disable()
        end
        addJumBtn = true
    end
    if(addJumBtn) then
        height = height + 50
    else
        height = height + 20
    end


    local offsetXWidth = 14
    -- 活动详情描述
    local contentRichText = nil
    -- print("wwww=", self._data:getDecStr())
    if(self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
        contentRichText = UI.Text:create()
        contentRichText:init(self._data:getDecStr(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        contentRichText:setWidth(CELL_WIDTH - offsetXWidth * 2)
        contentRichText:autoAdapt()
        contentRichText:leftUp(offsetXWidth, self._totalHeight + height + contentGap)
        self._contentLayout:addChild(contentRichText, 2)
        -- print("wwww=", self._data:getDecStr())

        height = height + contentRichText:getContentSize().height + contentGap * 2
        timeGap = 20
    else 
        contentRichText = UI.RichText:create()
        local success = contentRichText:initForNetJson(self._data:getDecStr(), CELL_WIDTH - offsetXWidth*2, 0, false, 100)
        if success then
            contentRichText:leftUp(offsetXWidth, self._totalHeight + height + contentGap)
            self._contentLayout:addChild(contentRichText, 2)
            
            height = height + contentRichText:getRichTextHeight() + contentGap * 2
            timeGap = 20
        end
    end

    -- 活动的时间逻辑
    local timeHeight = 31
    if(self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
        local timeHeight = 11
        local timeLayout = UI.Layout:create()
        timeLayout:init()
        timeLayout:setSize(CELL_WIDTH, timeHeight)
        timeLayout:rightUp(0, height)
        self._contentLayout:addChild(timeLayout, 2)

        local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
        splitLine:setContentSize(650, 2)
        splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
        splitLine:setPosition(cc.p(splitLine:getContentSize().width / 2 + 3, -2))
        timeLayout:addChild(splitLine)

        height = height + timeHeight + 4
    else 
        local timeLayout = UI.Layout:create()
        timeLayout:init()
        timeLayout:setSize(CELL_WIDTH, timeHeight)
        timeLayout:rightUp(0, height)
        self._contentLayout:addChild(timeLayout, 2)

        -- 添加活动日期
        local startDate = GameManager:getNowServerDate("%Y.%m.%d", self._data:getStartTime() + GameManager:getEPOCHTime())
        local endDate = GameManager:getNowServerDate("%Y.%m.%d", self._data:getEndTime() + GameManager:getEPOCHTime())
        local dateText = UI.Text:create()
        dateText:init(string.format(UI.TEXT_1170929, startDate , endDate), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        dateText:centerRight(30)
        dateText:setTextRight()
        timeLayout:addChild(dateText, 2)
        height = height + timeHeight + 4

        local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
        splitLine:setContentSize(650, 2)
        splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
        splitLine:setPosition(cc.p(splitLine:getContentSize().width / 2 + 3, -2))
        timeLayout:addChild(splitLine)
    end 

    -- 添加时间点
    self._totalHeight = self._totalHeight + height
end

-- 初始化任务活动列表
function ActivityDetailPanelCell:initQuestCondition()
    if(self._data) then
        local questCondition = self._data:getQuestCondition()
        if(questCondition) then
            local totalNum = #questCondition
            local lastOne = false
            for k,questConditionData in pairs(questCondition) do 
                if(totalNum == k) then 
                    lastOne = true
                end
                -- 创建一个任务奖励列表
                local questConditionPanel = UI.QuestConditionPanel:create()
                questConditionPanel:init(self._data, questConditionData, lastOne, self.listView)
                questConditionPanel:centerUp(self._totalHeight)
                self._contentLayout:addChild(questConditionPanel, 2)

                self._totalHeight = self._totalHeight + questConditionPanel:getQuestConditionHeight()
            end
        end
    end
end

-- 初始化公会任务活动列表
function ActivityDetailPanelCell:initGuildQuestCondition()
    if(self._data) then
        local questCondition = self._data:getGuildQuestCondition()
        if(questCondition) then
            local totalNum = #questCondition
            local lastOne = false
            for k,questConditionData in pairs(questCondition) do 
                if(totalNum == k) then 
                    lastOne = true
                end
                -- 创建一个任务奖励列表
                local questConditionPanel = UI.GuildQuestConditionPanel:create()
                questConditionPanel:init(self._data, questConditionData, lastOne, self.listView)
                questConditionPanel:centerUp(self._totalHeight)
                self._contentLayout:addChild(questConditionPanel, 2)

                self._totalHeight = self._totalHeight + questConditionPanel:getQuestConditionHeight()
            end
        end
    end
end

-- 初始化额外掉落列表
function ActivityDetailPanelCell:initExtraDrop()
    if(self._data) then
        local extraDrop = self._data:getExtraDrop()
        if(extraDrop and self._data:getIsShowExtraDropDetail()) then
            local totalNum = #extraDrop
            local lastOne = false
            for k,extraDropData in pairs(extraDrop) do 
                if(totalNum == k) then 
                    lastOne = true
                end
                -- 创建一个额外掉落列表
                local extraDropPanel = UI.ExtraDropPanel:create()
                extraDropPanel:init(extraDropData, lastOne, self.listView)
                extraDropPanel:centerUp(self._totalHeight)

                self._contentLayout:addChild(extraDropPanel, 2)

                self._totalHeight = self._totalHeight + extraDropPanel:getExtraDropHeight()
            end
        end
    end
end

function ActivityDetailPanelCell:initCaveActivity()
    if(self._data and self._data:getType() == PublicDefine.ActivityType.ActivityType_Cave) then
        local caveActivityPanel = UI.CaveActivityCell:create()
        caveActivityPanel:init(self._data, self.listView, self.activityPanel)
        caveActivityPanel:centerUp(self._totalHeight)
        self._contentLayout:addChild(caveActivityPanel, 2)

        self._totalHeight = self._totalHeight + caveActivityPanel:getActivityHeight()
    end
end

function ActivityDetailPanelCell:initExchange()
    if(self._data) then
        local questCondition = self._data:getExchange()
        if(questCondition) then
            local totalNum = #questCondition
            local lastOne = false
            for k,questConditionData in pairs(questCondition) do 
                if(totalNum == k) then 
                    lastOne = true
                end
                
                local questConditionPanel = UI.ExchangeActivityPanel:create(self._tableView)
                questConditionPanel:init(self._data, questConditionData, lastOne, self.listView)
                questConditionPanel:centerUp(self._totalHeight)
                self._contentLayout:addChild(questConditionPanel, 2)

                self._totalHeight = self._totalHeight + questConditionPanel:getQuestConditionHeight()
            end
        end
    end
end


function ActivityDetailPanelCell:initBindEmail()
    if(self._data and self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then
        local bindEmailPanel = UI.EmailBindPanel:create()
        bindEmailPanel:init(self._data:getEmailBindData(), self.listView)
        bindEmailPanel:centerUp(self._totalHeight)
        self._contentLayout:addChild(bindEmailPanel, 2)

        self._totalHeight = self._totalHeight + bindEmailPanel:getEmailBindHeight()
    end
end

function ActivityDetailPanelCell:initActivityShare()
    if(self._data and self._data:getType() == PublicDefine.ActivityType.ActivityType_Share) then

        local shareActivityData = self._data:getShareActivityData()
        if(shareActivityData) then
            local activitySharePanel = UI.ActivitySharePanel:create(self._tableView)
            activitySharePanel:init(self._data, shareActivityData, self.listView)
            activitySharePanel:centerUp(self._totalHeight)
            self._contentLayout:addChild(activitySharePanel, 2)

            self._totalHeight = self._totalHeight + activitySharePanel:getShareHeight()
        end
        
    end
end

function ActivityDetailPanelCell:createShareGroup(height)
    local sharePanel = UI.SharePanel:create(function(platform)

        if(not SceneManager:getInstance():isInTownOrInHome()) then
            UI.ScrollBar:createByText(UI.TEXT_1325602)
            return
        end

        local SdkBox = require("utils.sdkbox.SdkBox")

        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_ACTIVITY_SHARE_UI)

        local shareImage = cc.Sprite:create()
		shareImage:setAnchorPoint(0, 0)
		shareImage:setPosition(0, 0)
		cc.Director:getInstance():getRunningScene():addChild(shareImage, -1)
        
        local imageUrl = ""
        local shareActivityData = self._data:getShareActivityData()

        if (shareActivityData) then
            imageUrl = shareActivityData.pictureLink
        end
        
        print("imageUrl ======= ",imageUrl)
        print("shareActivityData ======= ",shareActivityData)

		ImageDownLoadUtil:downLoadImage(imageUrl, shareImage, function(localUrl, imgName)
            UI.WaitingLayer:hideWaiting()

			if(not tolua.isnull(shareImage) and imgName and imgName ~= "") then
				shareImage:setTexture(imgName)

                performWithDelay(self, function()
                    
                    local shareDatas = ConfigManager:getShareConfigByType(PublicDefine.SHARE_MODULE.SHARE_MODULE_ACTIVITY, platform)

                    print("shareDatas ============== ",shareDatas)
        
                    SdkBox:getInstance():createImage(shareImage,"share.png",function(path)
                        SdkBox:getInstance():share({
                            channel = platform,
                            link = shareDatas.url,
                            content =  table.nums(shareDatas.content) > 0 and LanguageManager:getInstance():getLocalString(shareDatas.content[math.random(1,table.nums(shareDatas.content))]) or "",
                            type = PublicDefine.SHARE_CONTENT_TYPE.IMAGE,
                            title = LanguageManager:getInstance():getLocalString(shareDatas.title[math.random(1,table.nums(shareDatas.title))]),
                            thumb = AvalonUtil.getShareThumbPath(shareDatas),
                            image = path,
                        })
                        if shareImage and not tolua.isnull(shareImage) then
                            shareImage:setVisible(false)
                            shareImage:runAction(cc.RemoveSelf:create())
                        end

                        Net.NetActivitySystem:requestSetShareTime(self._data:getID())
                    end)
                end, 0.05)
			end
		end)

    end, PublicDefine.SHARE_MODULE.SHARE_MODULE_ACTIVITY, false)

    sharePanel:setTouchClipNode(self.listView)
    local startX = 0
    if (#sharePanel.shareBtns > 1) then
        startX = ((#sharePanel.shareBtns - 1) * 70) / 2;
    end

    sharePanel:centerRight(self._contentLayout:getContentSize().width / 2 - startX,-self._contentLayout:getContentSize().height / 2 - sharePanel:getContentSize().height + 50)
    -- sharePanel:enableDebugDraw()
    -- self._contentLayout:enableDebugDraw()

    self._contentLayout:addChild(sharePanel, 2)

end