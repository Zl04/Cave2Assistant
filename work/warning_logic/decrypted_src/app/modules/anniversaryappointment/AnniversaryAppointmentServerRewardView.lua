------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local AnniversaryAppointmentServerRewardView = class("AnniversaryAppointmentServerRewardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 980
local COM_HEIGHT = 540
local INNER_WIDTH = 686
local INNER_HEIGHT = 459
local CELL_WIDTH = 630
local CELL_HEIGHT = 140

local coinID = 23370001

function AnniversaryAppointmentServerRewardView:ctor()
    AnniversaryAppointmentServerRewardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function AnniversaryAppointmentServerRewardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.anniversaryappointment", "AnniversaryAppointment", false)
    AnniversaryAppointmentServerRewardView.super.init(self, ... )
end

function AnniversaryAppointmentServerRewardView:dtor()
    AnniversaryAppointmentServerRewardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.anniversaryappointment.AnniversaryAppointmentServerRewardView")
end


function AnniversaryAppointmentServerRewardView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(3, 25)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_anniversary_paper.png")
    centerBg:center()
    contentLayout:addChild(centerBg)

    -- 主题banner
    local themeBanner  = UI.Image:create()
    themeBanner:init("ui_anniversary_illustration.png")
    themeBanner:centerUp(50)
    contentLayout:addChild(themeBanner)

    -- line
    local line  = UI.Image:create()
    line:init("ui_anniversary_line_1.png")
    line:centerUp(280)
    contentLayout:addChild(line)

    -- fade Out bottom
    local bottomImg  = UI.Image:create()
    bottomImg:init("ui_anniversary_up.png")
    bottomImg:centerUp(460)
    contentLayout:addChild(bottomImg, 199)
    
    self.configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityAppointmentServerReward)
    self:initThemeView()
    self:createTaskLayer()
end

function AnniversaryAppointmentServerRewardView:initThemeView()
    local whiteTitle = UI.Text:create()
    whiteTitle:init(UI.TEXT_223205, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_255_255_255)
    whiteTitle:leftUp(180, 110)
    self.contentLayout:addChild(whiteTitle)

    local activityCountDown = UI.Text:create()
    activityCountDown:init(UI.TEXT_1213112, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_69_227_154)
    activityCountDown:leftUp(180, 150)
    self.contentLayout:addChild(activityCountDown)
    self.activityCountDown = activityCountDown
    
    local startDate = GameManager:getClientDateByConfigTimeStr(self.configData.startTime, "%Y.%m.%d")
    local endDate = GameManager:getClientDateByConfigTimeStr(self.configData.endTime, "%Y.%m.%d")
    local dateStr = string.format(UI.TEXT_1170929, startDate, endDate)
    local taskDate = UI.Text:create()
    taskDate:init(dateStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    taskDate:center(170, 0)
    self.contentLayout:addChild(taskDate)

    local des = languageManagerInstance:getLocalString(self.configData.description)
    taskStory = UI.Text:create()
    taskStory:init(des, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    taskStory:centerUp(190)
    if(taskStory:getContentSize().width > 370 * 3) then 
        local str = AvalonUtil:getSubNameStr(des, 1080, UI.FONT_SIZE_16PX, true)
        taskStory:setText(str)
    end
    taskStory:setSize(640, 60)
    taskStory:setTextLeft()
    self.contentLayout:addChild(taskStory)
    taskStory:setLineSpacing(-4)

    local coinNum = RoleDataManager:getMaster():getAnniversaryCoin()

    local coinBg = UI.Image:create()
    coinBg:init("ui_anniversary_bg_3.png")
    coinBg:center(255, -107)
    self.contentLayout:addChild(coinBg)

    -- coin
    local coin  = UI.Image:create()
    coin:init("symbol_anniversary_23370002.png")
    coin:centerLeft(0, 0)
    coinBg:addChild(coin)

    local coinNumTxt = UI.Text:create()
    coinNumTxt:init(coinNum, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_255_255)
    coinNumTxt:center(0, 0)
    coinBg:addChild(coinNumTxt)
    self.coinNumTxt = coinNumTxt

    self:getCountDownIsShow()
end

function AnniversaryAppointmentServerRewardView:updateActivityCountDown()
    local endTimeStamp = GameManager:getUnixTimeByConfigTimeStr(self.configData.endTime)
    -- local remainTime = endTimeStamp - GameManager:getNormalServerTime()
    -- print("updateActivityCountDown2", remainTime, endTimeStamp, GameManager:getNormalServerTime())
    local remainTimeStr = AvalonUtil:getNewFullFormatTime(endTimeStamp, Game.TIME_LEVEL.TIME_LEVEL_MINUTE)
    self.activityCountDown:setText(string.format(UI.TEXT_223206, remainTimeStr))
end

-- 活动是否在开启时间内
function AnniversaryAppointmentServerRewardView:getCountDownIsShow()
    local nowTime = GameManager:getNormalServerTime()
    local startTime = GameManager:getUnixTimeByConfigTimeStr(self.configData.startTime)
    local endTime = GameManager:getUnixTimeByConfigTimeStr(self.configData.endTime)
    -- 比较时间为标准时间
    if nowTime >= startTime and nowTime <= endTime then
        self:updateActivityCountDown()
    elseif nowTime >= endTime then
        self.activityCountDown:setText(UI.TEXT_223207)
    end
end

function AnniversaryAppointmentServerRewardView:createTaskLayer(layout)
    local targetList = mvc.anniversaryAppointmentModel:getServerRewardConfig()--self.configData.exchange
    self._taskTableView = UI.TableView.new({}, CELL_WIDTH, 190)
    self._taskTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._taskTableView:centerUp(290)
    self._taskTableView:setDelegate()
    self._taskTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._taskTableView:setBounceable(true)
    self._taskTableView:init()
    self._taskTableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT
    end)

    self._taskTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createTaskCell(index, targetList)
            end,
            function(e)
                printError("------------------------AnniversaryAppointmentServerRewardView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local taskCell = cell:getChildByName("taskCell")
            if taskCell and tolua.isnull(taskCell) then
                taskCell:removeFromParent()
                taskCell = nil
            end
            cell:removeFromParent()
            cell = self:createTaskCell(index, targetList)
        end

        return cell
    end)

    self._taskTableView:onUpdateCellNumbers(function ()
        return #targetList
    end)

    self.contentLayout:addChild(self._taskTableView, 99)
    self._taskTableView:reloadData(true)
end

function AnniversaryAppointmentServerRewardView:createTaskCell(index, data)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))
    local targetConfig = data[index]
    local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityAppointmentServerReward)
    local taskCell = mvc.anniversaryAppointmentTaskCellView:create(targetConfig, PublicDefine.TradeActivityIDList.TradeActivityAppointmentServerReward, index, configData)
    taskCell:init()
    taskCell:centerUp(-20)
    taskCell:setName("taskCell")
    cell:addChild(taskCell)
    return cell
end

function AnniversaryAppointmentServerRewardView:updateCoinNum()
    local coinNum = RoleDataManager:getMaster():getAnniversaryCoin()
    self.coinNumTxt:setText(coinNum)
end

function AnniversaryAppointmentServerRewardView:bindModel()

end


function AnniversaryAppointmentServerRewardView:unbindModel()

end





return AnniversaryAppointmentServerRewardView












