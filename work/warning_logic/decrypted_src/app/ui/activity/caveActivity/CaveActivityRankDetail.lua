-- CaveActivityRankDetail.lua
-- Author:zp
-- 2019年1月9日
-- Using:排行榜的表现

require "app.ui.activity.caveActivity.CaveActivityRankCell"

local winSize = cc.Director:getInstance():getWinSize()

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local CaveActivityRankDetail = class("CaveActivityRankDetail", UI.CenterWin)
UI.CaveActivityRankDetail = CaveActivityRankDetail

local DEBUG = true
local VIEW_WIDTH = 708
local VIEW_HEIGHT = 527
-- 资源文件
local COM_RES_LIST = {
    "ui_town_activity.plist",
    "ui_town_ranking.plist",
}

function CaveActivityRankDetail:ctor()
    CaveActivityRankDetail.super.ctor(self, UIType.ACTIVITY, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT)
end

function CaveActivityRankDetail:onEnter()
    CaveActivityRankDetail.super.onEnter(self)
    self:registerListener();
end

function CaveActivityRankDetail:onExit()
    CaveActivityRankDetail.super.onExit(self)
    self:unRegisterListener();
end

function CaveActivityRankDetail:init(data)
    -- print("CaveActivityRankDetail:init", data)
    self.data = data
    CaveActivityRankDetail.super.init(self)

    self:setInterceptTouches(true)
    self:setTouchEnable(true)
    self:open()
end

function CaveActivityRankDetail:dtor()
    CaveActivityRankDetail.super.dtor(self)

end

function CaveActivityRankDetail:onInitView()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_activity_banner_bg.png")
    bg:centerBottom(0)
    self:addChild(bg)

    local titleBg = UI.Image:create()
    titleBg:init("ui_activity_banner_bg_title.png")
    titleBg:centerUp(43 - titleBg:getContentSize().height/2)
    self:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1212078, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(titleBg:getContentSize().height/2 - titleText:getContentSize().height/2 - 3)
    titleBg:addChild(titleText)

    -- 排列标题
    local rankTitleText = UI.Text:create()
    rankTitleText:init(LanguageManager:getInstance():getLocalString(1110542), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    rankTitleText:leftUp(133 - rankTitleText:getContentSize().width/2, 98 - rankTitleText:getContentSize().height/2)
    self:addChild(rankTitleText)

    local rewardTitleText = UI.Text:create()
    rewardTitleText:init(UI.TEXT_1212086, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    rewardTitleText:leftUp(436 - rewardTitleText:getContentSize().width/2, 98 - rewardTitleText:getContentSize().height/2)
    self:addChild(rewardTitleText)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine:setContentSize(650, 2)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(350, 411)
    self:addChild(splitLine)

    -- 显示列表
    self._tableView = UI.TableView.new({}, 590, 380)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftUp(48, 120)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)

        return 590, 89
    end) 

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        if(cell == nil) then 
            xpcall(function()
                cell = UI.CaveActivityRankCell.new()
                cell:init(self.data[idx + 1], self._tableView)
            end, 
            function(e) 
                printError("------------------------CaveActivityRankDetail:tableCellAtIndex-----------------error")
            end, 1) 
        else 
            cell:reloadData(self.data[idx + 1])
        end
        
        return cell
    end)
    self._tableView:onUpdateCellNumbers(function ()
        if(self.data) then 
            return table.nums(self.data) 
        end

        return 0
    end)
    self._tableView:onTableCellTouched(function(table, cell)
        
    end)
    self:addChild(self._tableView, 20)
    self._tableView:reloadData()

    -- 添加周围的装饰物
    local leftImage  = UI.Image:create()
    leftImage:init("ui_activity_banner_bg_1.png")
    leftImage:leftBottom(-138, -16)
    self:addChild(leftImage)

    local rightImage  = UI.Image:create()
    rightImage:init("ui_activity_banner_bg_2.png")
    rightImage:rightBottom(-85, -9)
    self:addChild(rightImage)
end

-- 注册监听事件(可选)
function CaveActivityRankDetail:registerListener()
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityChange)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL_BACK, self, self.backShow)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

-- 注销监听事件(可选)
function CaveActivityRankDetail:unRegisterListener()
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityChange)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL_BACK, self, self.backShow)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end
