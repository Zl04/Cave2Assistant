------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2024/01/02
--desc	: 
------------------------------------------------------------------------------

require("app.modules.bet.BetInfoCell")

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BetInfoView = class("BetInfoView", UI.HWBtnComponent)

local scheduler = cc.Director:getInstance():getScheduler()

-- 资源
local COM_RES_LIST = {
    "ui_town_navigation.plist",
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 890
local COM_HEIGHT = 459

function BetInfoView:ctor()
    BetInfoView.super.ctor(
    self,
    UI.Type.TIPS,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)
self.schedulerID = 0;
self:bindModel()
end

function BetInfoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bet", "Bet", false)
    BetInfoView.super.init(self, ... )
end

function BetInfoView:dtor()
    BetInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bet.BetInfoView")
end


function BetInfoView:onInitView()
    -- 上面提示信息
    -- 倒计时
    local timeBg = UI.Image:create()
    timeBg:init("ui_rally_lable_time.png")
    timeBg:leftUp(29, 8)
    self:addChild(timeBg)
    
    local timeText = UI.Text:create()
    timeText:init(UI.TEXT_227610, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_WHITE)
    timeText:centerLeft(20)
    timeBg:addChild(timeText)
    self._timeText = timeText
    
    -- 领取每日竞猜币
    local jumpRallyButton = UI.Button:create()
    jumpRallyButton:init("ui_rally_btn_jump.png", "ui_rally_btn_jump.png", "ui_rally_btn_jump.png", cc.p(0, 42))
    jumpRallyButton:centerBottom(92)
    jumpRallyButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        Net.NetBigSailSystem:reqBetBaseInfo(0)
        mvc.openPanel("Bet", "RallyGame")
        Net.NetRoleSystem:reqOpenFuntionTypeUI(PublicDefine.FUNCTION_TYPE.FUNCTION_RALLYGAME)
    end)
    jumpRallyButton:setVisible(false)
    jumpRallyButton:setText(UI.TEXT_227648)
    jumpRallyButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 217, g = 255, b = 177})
    self:addChild(jumpRallyButton, 1000)
    self._jumpRallyButton = jumpRallyButton
    
    
    -- 竞猜币
    local guessLayout = UI.Layout:create();
    guessLayout:init()
    guessLayout:enableAutoWidth()
    guessLayout:enableAutoHeight()
    guessLayout:rightUp(42, 23)
    self:addChild(guessLayout)
    self._guessLayout = guessLayout
    
    local guessTitle = UI.Text:create()
    guessTitle:init(UI.TEXT_227608, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- guessTitle:centerRight(130)
    -- guessLayout:addChild(guessTitle)
    guessTitle:floatLeft(5)
    guessLayout:addComponent(guessTitle, 10)
    
    local rallyBetGoodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.RALLY_BET)
    local guessImage = UI.Image:create()
    guessImage:init(rallyBetGoodsData:getSmallIconName())
    -- guessImage:centerRight(105)
    -- guessLayout:addChild(guessImage, 10)
    guessImage:floatLeft(5)
    guessLayout:addComponent(guessImage, 10)
    
    local betItemNum = 100000
    if(mvc.bigSailPortModel:getBaseData() ~= nil) then
        betItemNum = mvc.bigSailPortModel:getBaseData().betItemNum
    end
    
    local guessNum = UI.Text:create()
    guessNum:init(tostring(AvalonUtil:getCommaNumber(betItemNum)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- guessNum:setWidth(100)
    -- guessNum:centerRight(5)
    -- guessLayout:addChild(guessNum)
    guessNum:floatLeft(5)
    guessLayout:addComponent(guessNum, 10)
    self._guessNum = guessNum
    
    -- local addButton = UI.Button:create()
    -- addButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    
    -- addButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
    --     print("处理跳转竞猜币逻辑")
    -- end) 
    -- -- addButton:centerRight(0)
    -- -- guessLayout:addChild(addButton)
    -- addButton:floatLeft(10)
    -- guessLayout:addComponent(addButton, 10)
    
    -- 横线
    local line  = UI.Image:create()
    line:init("ui_navigation_line_4.png")
    line:centerUp(56)
    self:addChild(line)
    
    -- 中间列表区域
    self._infoList = {}
    
    for i=1,4 do 
        local info = UI.BetInfoCell:create()
        info:init()
        info:leftUp(220 * (i-1) + 12, 69)
        -- info:updateData()
        self._infoList[i] = info
        
        self:addChild(info)
    end
    
    -- 下面的提示信息
    local noticeLayout = UI.Layout:create();
    noticeLayout:init()
    noticeLayout:enableAutoWidth()
    noticeLayout:enableAutoHeight()
    noticeLayout:centerBottom(20)
    -- noticeLayout:setName("costLayer")
    self:addChild(noticeLayout)
    self._noticeLayout = noticeLayout
    
    local iconImage  = UI.Image:create();
    iconImage:init("ui_shopping_banner_prompt.png");
    iconImage:floatLeft(0)
    noticeLayout:addComponent(iconImage, 10)
    
    local noticeTxt = UI.Text:create()
    noticeTxt:init(string.format(UI.TEXT_227609,mvc.betModel:getGameTimeStr()), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 73, g = 24, b = 24})
    noticeTxt:floatLeft(10)
    noticeLayout:addComponent(noticeTxt, 10)
    self._noticeTxt = noticeTxt
    
    -- 领取每日竞猜币
    local receiveButton = UI.Button:create()
    receiveButton:init("ui_rally_icon.png", "ui_rally_icon.png", "ui_rally_icon.png")
    receiveButton:rightBottom(0, -15)
    receiveButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        print("处理领取竞猜币")
        Net.NetBigSailSystem:reqBetGetItemNum(mvc.betModel:getCurBetID())
    end)
    self:addChild(receiveButton)
    self._receiveButton = receiveButton
    
    self:refreshView()
end


function BetInfoView:bindModel()
    if(self.schedulerID == 0) then 
        self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 1, false)
    end
    
end

function BetInfoView:unbindModel()
    if self.schedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
end

function BetInfoView:update()
    self:refreshBetTime()
    self:updateBetIntemNum()
end

function BetInfoView:refreshView()
    self:refreshBetTime()
    self:updateBetIntemNum()
    self:refreshReceiveBtn()
    for i=1,4 do 
        self._infoList[i]:updateData(mvc.betModel:getBetInfo(i))
    end
end

function BetInfoView:refreshBetTime()
    local betTime = mvc.betModel:getInBetTime()
    self._noticeTxt:setText(string.format(UI.TEXT_227609,mvc.betModel:getGameTimeStr()))
    --print("BetInfoView:refreshBetTime", betTime, AvalonUtil:_getFullFormatTime(betTime, false, true))
    self._jumpRallyButton:setVisible(false)
    if(betTime > 0) then 
        self._timeText:setText(string.format(UI.TEXT_227610, AvalonUtil:_getFullFormatTime(betTime, false, true)))
    elseif (mvc.betModel:getInGameTime() > 0) then
        self._timeText:setText(string.format(UI.TEXT_227610, UI.TEXT_227618))
        self._jumpRallyButton:setVisible(true)
    else
        local restTime = mvc.betModel:getInGameRestTime()
        if(restTime > 0) then 
            self._timeText:setText(string.format(UI.TEXT_227642, AvalonUtil:_getFullFormatTime(restTime, false, true)))
        else
            self._timeText:setText(string.format(UI.TEXT_227642, UI.TEXT_227619))
        end
        self._noticeTxt:setText(UI.TEXT_227619)
    end
    
    self._noticeTxt:updateView() 
    self._noticeLayout:updateView()
end

function BetInfoView:updateBetIntemNum()
    self._guessNum:setText(tostring(AvalonUtil:getCommaNumber(mvc.bigSailPortModel:getBaseData().betItemNum)))
    -- self._guessNum:setText(tostring(AvalonUtil:getCommaNumber(1000)))
    self._guessLayout:updateView()
end

function BetInfoView:refreshReceiveBtn()
    if(self._receiveButton ~= nil) then
        if(mvc.betModel:checkRewardBet() and mvc.betModel:getInBetTime()) then
            self._receiveButton:setVisible(true)
        else 
            self._receiveButton:setVisible(false)
        end
    end
end


return BetInfoView












