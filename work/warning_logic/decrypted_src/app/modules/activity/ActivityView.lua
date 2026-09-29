--[[--
视图ActivityView
可以发送消息 dispose 处理资源释放,dispose只是UI暂时失去,视图本身不会释放,initUI 处理UI初始化
重写父类函数时，切记调用父类函数 如 ActivityView.super.initUI(self)
]]
local GamePanel = require(mvc.PACKAGE_APP_CORE..".GamePanel")

local ActivityView = class("ActivityView",GamePanel)
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

require("app.ui.activity.ActivityPanelCell")
require "app.ui.activity.activityDetail.ActivityDetailPanelCell"

local VIEW_WIDTH = 716
local VIEW_HEIGHT = 532

function ActivityView:onRegister()
   	self:init(ViewStyle.ViewStyle_DownShowWin, mvc.VIEW_TYPE.PANEL)
end

function ActivityView:initUI()
	ActivityView.super.initUI(self)
	Avalon.ResHelper:loadPlistSync("ui_town_activity.plist")
	-- Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
	mvc.facade:send(mvc.events.Bridge_Hide_Main_Layer)

	self.ui:setSize(VIEW_WIDTH, VIEW_HEIGHT)
	self.ui:open()

    self._cellArr = {}
    self._cellHeightArr = {}

	-- self._data = MasterDataManager:getActivityDataArr()
	self._data = mvc.activityModel:getActivityDataArr()

    if(self._data) then
        for k,activityData in pairs(self._data) do 
            activityData.isOpen = false
        end
    end 

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
            cell = UI.ActivityDetailPanelCell.new()
            cell:init(self._data[idx + 1], self._tableView, self)
        end, 
        function(e) 
            printError("------------------------ActivityView:tableCellAtIndex-----------------error")
        end, 1) 
        self._cellArr[idx] = cell
        
        return cell
    end)
    self._tableView:onUpdateCellNumbers(function ()
        -- print("ActivityView num=",table.nums(self._data) )
        return table.nums(self._data) 
    end)
    self._tableView:onTableCellTouched(function(table, cell)
        print("ActivityView:tableCellTouched",cell:getIdx())
        local index = cell:getIdx()
        local updateOffset = false
        local updateOffsetY = 0
        if(cell:getTouchBegin()) then
            cell:clearTouchBegin()
            Avalon.AudioManager:playSound("1503")

            local data = self._data[index + 1]
            if(data) then
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
            end
            cell:updateDetail()

            self._tableView:reloadData()
            if(updateOffset) then 
                table:setContentOffset(cc.p(table:getContentOffset().x, table:getContentOffset().y + updateOffsetY), true)
            end
        end
    end)

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



function ActivityView:dispose()
	ActivityView.super.dispose(self)
end



function ActivityView:refreshNoActivityText()
    if(self._noActivityText and not tolua.isnull(self._noActivityText)) then 
        if(self._data and table.nums(self._data) > 0) then
            self._noActivityText:hide()
        else 
            self._noActivityText:show()
        end
    end 
end

function ActivityView:activityChange()
    -- print("ActivityView:activityChange")
    if(self and not tolua.isnull(self)) then
        self._data = mvc.activityModel:getActivityDataArr()
        if(self._data) then
            for k,activityData in pairs(self._data) do 
                -- if(activityData.isOpen == nil) then
                    activityData.isOpen = false
                -- end
            end
        end 

        self._cellArr = {}
        self._cellHeightArr = {}
        self._willReloadData = true
        -- MasterDataManager:requestAllActivityWebLanguage(handler(self, self.refreshWebLanguageBack))
        mvc.activityModel:requestAllActivityWebLanguage(handler(self, self.refreshWebLanguageBack))

        if(self._tableView and not tolua.isnull(self._tableView)) then
            self._tableView:reloadData()
        end
        -- 优化回执的时机
        self._willReloadData = false

        self:refreshNoActivityText()
    end
end

-- function ActivityView:backShow()
--     if(self and not tolua.isnull(self)) then
--         self:setVisible(true)
--     end
-- end

function ActivityView:rewardResult(data)
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

-- -- 注册监听事件(可选)
-- function ActivityView:registerListener()
--     Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityChange)
--     Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL_BACK, self, self.backShow)
--     Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
--     Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_CLOSE, self, self.closeWin)
-- end


return ActivityView