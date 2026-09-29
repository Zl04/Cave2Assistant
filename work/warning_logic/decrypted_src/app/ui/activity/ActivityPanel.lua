-- ActivityPanel.lua
-- Author:zp
-- 2017年12月19日
-- Using:运营活动界面

require("app.ui.activity.ActivityPanelCell")
require "app.ui.activity.activityDetail.ActivityDetailPanelCell"

local winSize = cc.Director:getInstance():getWinSize()

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")

UI = UI or {}

local ActivityPanel = class("ActivityPanel", UI.DownShowWin)
UI.ActivityPanel = ActivityPanel

local DEBUG = true
local VIEW_WIDTH = 716
local VIEW_HEIGHT = 532
-- 资源文件
local COM_RES_LIST = {
    "ui_town_activity.plist",
    "ui_town_world_boss.plist",
}

local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

function ActivityPanel:ctor(NPCSpriteID, sourceType)
    ActivityPanel.super.ctor(self, UIType.ACTIVITY, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT)

    self._data = MasterDataManager:getActivityDataArrWithFilter({PublicDefine.ActivityType.ActivityType_Festival,PublicDefine.ActivityType.ActivityType_ExchangeShop})
    if(self._data) then
        for k,activityData in pairs(self._data) do 
            activityData.isOpen = false
        end
    end 
    MasterDataManager:requestAllActivityWebLanguage(handler(self, self.refreshWebLanguageBack))
    Net.NetGuildSystem:reqActivityCount()

    self._sourceType = sourceType
    self._spriteID = NPCSpriteID
    self._cellArr = {}
    self._cellHeightArr = {}
    
    self:insertWorldBossEntry()

    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Activity, 1, nil, nil, self._sourceType)
end

function ActivityPanel:insertWorldBossEntry()
    if not mvc.worldBossModel:showActivityBanner() then
        return
    end

    -- worldboss检查一次
    mvc.worldBossModel:checkNeedTownNotify()

    local entry = {}
    entry.imgType = 0
    entry.isOpen = false
    entry.getIsInit = function() return true end
    entry.getType = function() return 0 end
    entry.getJumpStr = function() return end
    entry.getDecStr = function() return "[{\"text\":\"".. UI.TEXT_1212645 .. "\",\"color\":\"#29292d\",\"fontSize\":18}]" end
    entry.getStartTime = function() return 0 end
    entry.getEndTime = function() return 0 end
    entry.getQuestCondition = function() return end
    entry.getGuildQuestCondition = function() return end
    entry.getExtraDrop = function() return end
    entry.getExchange = function() return end
    entry.getImageName = function() return "ui_boss_bbanner.png" end
    entry.getName = function() return UI.TEXT_1212645 end
    entry.getIsHaveAward = function() return end
    entry.getIsNew = function() return end
    entry.getIsHot = function() return end
    entry.getStatus = function() return PublicDefine.ActivityRunningStat.ActivityRunningStat_Running end

    table.insert(self._data, 1, entry)
end

function ActivityPanel:onEnter()
    ActivityPanel.super.onEnter(self)
    self:registerListener();
end

function ActivityPanel:onExit()
    ActivityPanel.super.onExit(self)
    self:unRegisterListener();
end

function ActivityPanel:init(spriteID)
    ActivityPanel.super.init(self)

    self:setInterceptTouches(true)
    self:setTouchEnable(true)

    self._spriteID = spriteID
end

function ActivityPanel:refreshWebLanguageBack()
    MasterDataManager:refreshActivityLanguageCallback()
    if(not tolua.isnull(self) and self._willReloadData ~= true) then
        if(self and not tolua.isnull(self)) then
            -- 刷新表现逻辑
            if(self._tableView) then
                self._tableView:reloadData()
            end
        end 
    end
end

function ActivityPanel:dtor()
    ActivityPanel.super.dtor(self)

end

function ActivityPanel:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    -- contentLayout:setPos(0, LAYOUT_FUNCTION_HEIGHT/2)
    contentLayout:setSize(760, 530)
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_bg_box1.png")
    bg:center()
    contentLayout:addChild(bg, 2)

    -- 标题背景
    local titleBg = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    -- titleBg:centerUp(-21)
    titleBg:leftUp(bg:getContentSize().width/2 - titleBg:getContentSize().width/2 - 8, -21)
    bg:addChild(titleBg, 10)

    -- 活动文字
    local activityText = UI.Text:create()
    activityText:init(UI.TEXT_111023, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
    -- activityText:center()
    activityText:centerLeft(56+117 - activityText:getContentSize().width/2)
    titleBg:addChild(activityText)
    -- 背景

    --用于判断touch out 
    local bgLayout = UI.Layout:create()
    bgLayout:init()
    bgLayout:center(0)
    bgLayout:setSize(716, 532)
    bg:addChild(bgLayout)

    -- 显示内容背景
    
    local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    centerBg:setContentSize(674, 450)
    centerBg:setCapInsets(CCRectMake(304,141,1,1))
    centerBg:setPosition(cc.p(44 + centerBg:getContentSize().width/2,  35 + centerBg:getContentSize().height/2))
    bg:addChild(centerBg, 4)

    self._tableView = UI.TableView.new({},ACTIVITY_WIDTH,440)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:centerBottom(5)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        local data = self._data[idx + 1]
        -- print("_tableView:onUpdateCells", idx)
        local width = ACTIVITY_WIDTH
        local height = ACTIVITY_LITTLE_HEIGHT
        if(data) then
            if(data.imgType == 0) then
                height = ACTIVITY_LITTLE_HEIGHT
            else 
                height = ACTIVITY_BIG_HEIGHT
            end 
        end 

        if(not tolua.isnull(self._cellArr[idx])) then
            height = self._cellArr[idx]:getHeight()
            self._cellHeightArr[idx] = height
        else 
            if(self._cellHeightArr[idx]) then
                height = self._cellHeightArr[idx]
            end
        end

        if(idx == 0) then
            height = height + 10
        else 
            height = height + 10
        end
        -- print("_tableView:onUpdateCells", idx, height)

        return width,height
    end) 

    self._tableView:onUpdateCells(function (table, idx)
        -- print("_tableView:onUpdateCells table ,idx", table, idx)
        local cell = table:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell:removeFromParent()
            cell = nil
        end
        xpcall(function()
            cell = UI.ActivityDetailPanelCell.new(self._tableView)
            cell:init(self._data[idx + 1], self._tableView, self)
        end, 
        function(e) 
            printError("------------------------ActivityPanel:tableCellAtIndex-----------------error", e)
        end, 1) 
        self._cellArr[idx] = cell
        
        return cell
    end)
    self._tableView:onUpdateCellNumbers(function ()
        -- print("ActivityPanel num=",table.nums(self._data) )
        return table.nums(self._data) 
    end)
    self._tableView:onTableCellTouched(function(table, cell)
        print("ActivityPanel:tableCellTouched",cell:getIdx())
        local index = cell:getIdx()
        local updateOffset = false
        local updateOffsetY = 0
        if(cell:getTouchBegin()) then
            cell:clearTouchBegin()
            Avalon.AudioManager:playSound("1503")

            local data = self._data[index + 1]
            if(data) then
                if data:getType() == 0 then
                    -- 世界boss的入口特殊处理
                    if SceneManager:getInstance():isInFightScene() then
                        UI.ScrollBar:createByText(UI.TEXT_1212665)
                        return
                    end

                    if (not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_WorldBoss)) then 
                        UI.ScrollBar:createByText(UI.TEXT_1212652)
                        return
                    end

                    -- 若在组队中，则阻止
                    if TeamDataManager:getReadyState() then
                        UI.ScrollBar:createByText(UI.TEXT_1212055)
                        return
                    end

                    local stateData = mvc.worldBossModel:getStateData()
                    local roomData = mvc.worldBossModel:getRoomData()
                    self:closeWin()
            
                    if not roomData.roomNo or roomData.roomNo == 0 then
                        mvc.openPanel("WorldBoss", "WorldBoss")
                    elseif stateData.isFighting then
                        mvc.openPanel("WorldBoss", "WorldBoss")
                    else
                        mvc.openPanel("WorldBoss", "WorldBossRoom")
                    end

                    return
                end

                data:clearNew()
                GameManager:triggerNppActivityCrying()
                data.isOpen = not data.isOpen 
                if(data.isOpen) then
                    updateOffset = true
                    self._clickIdx = index
                    local x,y = cell:getPosition()
                    local offsetY = table:getContentOffset().y

                    if offsetY <=50 then
                        if(y <= -offsetY + 60) then
                            local up = 0
                            if(cell:getDesHeight() < 500 - cell:getTitleHeight()) then
                                up = cell:getDesHeight() -(y + offsetY)
                            else 
                                up = 500 - cell:getTitleHeight() -(y + offsetY)
                            end 
                            updateOffsetY = up
                        end
                    end
                end
                -- local SdkManager = require"app.game.SdkManager"
                -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_Activity,
                -- data:getID(),
                -- PublicDefine.WebLogType_Activity_Type.WebLogType_Activity_Detail,0,0)
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Activity, 2, data:getID(), nil, self._sourceType)
            end
            cell:updateDetail()

            self._tableView:reloadData()
            if(updateOffset) then 
                table:setContentOffset(cc.p(table:getContentOffset().x, table:getContentOffset().y + updateOffsetY), true)
            end
        end
    end)

    if(GameManager:getIsGooglePlay()) then
        self._tableView:onTableCellHighLight(function(table, cell)
            -- print("onTableCellHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx()
            if(not tolua.isnull(self._cellArr[endIndex])) then 
                self._cellArr[endIndex]:hightLight()

                Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                    if(not tolua.isnull(self)) then
                        if(self._cellArr[endIndex]) then 
                            self._cellArr[endIndex]:unHightLight()
                        end
                    end
                end, 1)
            end
        end)

        self._tableView:onTableCellUnHighLight(function(table, cell)
            -- print("onTableCellUnHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx()
            if(not tolua.isnull(self._cellArr[endIndex])) then 
                self._cellArr[endIndex]:unHightLight()
            end
        end)
    end

    centerBg:addChild(self._tableView)

    local mask  = UI.Image:create()
    mask:init("ui_activity_banner_mask.png")
    mask:centerBottom(0)
    centerBg:addChild(mask)

    self._tableView:reloadData(false, true)

    -- 没有运营活动的显示
    local noActivityText = UI.Text:create()
    noActivityText:init(LanguageManager:getInstance():getLocalString(1110935), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_170_170_170)
    noActivityText:setSize(0,0)
    noActivityText:center()
    centerBg:addChild(noActivityText)
    noActivityText:hide()
    self._noActivityText = noActivityText

    -- 添加了装饰物
    local defomation  = UI.Image:create()
    defomation:init("ui_bg_rattan.png")
    defomation:rightUp(-10, 30)
    self._contentLayout:addChild(defomation)

    local defomation  = UI.Image:create()
    defomation:init("ui_bg_rattan1.png")
    defomation:rightBottom(-42, 0)
    self._contentLayout:addChild(defomation)

    local defomation  = UI.Image:create()
    defomation:init("ui_bg_rattan2.png")
    defomation:rightBottom(-4, 143)
    self._contentLayout:addChild(defomation, 3)

    local defomation  = UI.Image:create()
    defomation:init("ui_bg_railing.png")
    defomation:rightBottom(-12, 25)
    self._contentLayout:addChild(defomation, 3)

    local flagRight = UI.Animation:create()
    flagRight:init("effect_ui_town_mailbox_right.json", "effect_ui_town_mailbox_right.atlas", 1);
    flagRight:rightBottom(35, 5)
    bg:addChild(flagRight)
    flagRight:setAnimation("idle", true)

    local flagLeft = UI.Animation:create()
    flagLeft:init("effect_ui_town_activity.json", "effect_ui_town_activity.atlas", 1);
    flagLeft:leftBottom(0, 9)
    bg:addChild(flagLeft)
    flagLeft:setAnimation("idle", true)

    self:refreshNoActivityText()
end

function ActivityPanel:refreshNoActivityText()
    if(self._noActivityText and not tolua.isnull(self._noActivityText)) then 
        if(self._data and table.nums(self._data) > 0) then
            self._noActivityText:hide()
        else 
            self._noActivityText:show()
        end
    end 
end

function ActivityPanel:activityChange(refreshStatus)
    -- print("ActivityPanel:activityChange")
    if(self and not tolua.isnull(self)) then
        local oldData = self._data
        self._data = MasterDataManager:getActivityDataArrWithFilter({PublicDefine.ActivityType.ActivityType_Festival,PublicDefine.ActivityType.ActivityType_ExchangeShop})
        self:insertWorldBossEntry()
        if(self._data and oldData) then
            -- if not refreshStatus then
                for k,activityData in pairs(self._data) do 
                    local foundIsOpen = false
                    for oldK, oldActivityData in pairs(oldData) do
                        if(oldActivityData and oldActivityData.getID and activityData.getID and oldActivityData:getID() == activityData:getID()) then 
                            foundIsOpen = oldActivityData.isOpen
                            break
                        end
                    end
                    -- if(activityData.isOpen == nil) then
                        activityData.isOpen = foundIsOpen
                    -- end
                end
            -- end
        end 
        if not refreshStatus then
            self._cellArr = {}
            self._cellHeightArr = {}
        end
        self._willReloadData = true
        MasterDataManager:requestAllActivityWebLanguage(handler(self, self.refreshWebLanguageBack))

        if(self._tableView and not tolua.isnull(self._tableView)) then
            self._tableView:reloadData()
        end
        -- 优化回执的时机
        self._willReloadData = false

        self:refreshNoActivityText()
    end
end

function ActivityPanel:backShow()
    if(self and not tolua.isnull(self)) then
        self:setVisible(true)
    end
end

function ActivityPanel:rewardResult(data)
    if( tolua.isnull(self)) then
       return 
    end

    if (data and data.result == "ActivityRewardResult_ActivityTimeOut") then
        if(self._tableView and not tolua.isnull(self._tableView)) then
            self._tableView:reloadData()
            self._cellArr = {}
        end
    end
end

-- 注册监听事件(可选)
function ActivityPanel:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL_BACK, self, self.backShow)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_CLOSE, self, self.closeWin)
end

-- 注销监听事件(可选)
function ActivityPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL_BACK, self, self.backShow)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_CLOSE, self, self.closeWin)
end

function ActivityPanel:openShow()
    self:open()
end
