------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/06/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MonthlySignView = class("MonthlySignView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_welfare_monthly_sign.plist",
    "ui_town_daily.plist",
}

local COM_WIDTH = 970
local COM_HEIGHT = 615

local COM_WIDTH_CELL_LAYOUT = 700
local COM_HEIGHT_CELL_LAYOUT = 370

local CELL_WIDTH = 90
local CELL_HEIGHT = 91

local PROG_WIDTH = 652

local SIGN_TICKET_SPRITE = "symbol_gaming_signin.png"

function MonthlySignView:ctor()
    MonthlySignView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.gameMonth = nil
    self.monthlySignConfig = {}
    self.month = nil
    self:bindModel()
end

function MonthlySignView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.monthlysign", "MonthlySign", false)
    self.gameMonth = mvc.monthlySignModel:getFlagByGameMonth()
    self.monthlySignConfig = mvc.monthlySignModel:getMonthlyConfig()--ConfigManager:getAllMonthlySignDataByID(gameMonth)
    self.month = nil
    MonthlySignView.super.init(self, ... )
end

function MonthlySignView:dtor()
    MonthlySignView.super.dtor(self)
    self.gameMonth = nil
    self.monthlySignConfig = {}
    self:unbindModel()
    reload_script_file_mvc("app.modules.monthlysign.MonthlySignView")
end


function MonthlySignView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_monthlysign_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    local line = UI.Image:create()
    line:init("ui_monthlysign_line.png")
    line:centerUp(70)
    contentLayout:addChild(line)

    local titleBg = UI.Image:create()
    titleBg:init("ui_monthlysign_title.png")
    titleBg:centerUp(-20)
    contentLayout:addChild(titleBg)

    local title  = UI.Text:create()
    title:init("", UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_255_255_255)
    title:center(0, 5)
    titleBg:addChild(title)
    self.title = title

    local curreyY = 40
    -- 补签券
    local signTicket = UI.Image:create()
    signTicket:init(SIGN_TICKET_SPRITE)
    signTicket:rightUp(450, curreyY)
    self.contentLayout:addChild(signTicket, 4)
    -- 补签券数量
    self._ticket = UI.Text:create()
    self._ticket:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._ticket:setTextLeft()
    -- self._ticket:leftUp(220 + 28, curreyY)
    self._ticket:centerLeft(signTicket:getContentSize().width + 7)
    signTicket:addChild(self._ticket, 4)


    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_gaming_diamond.png")
    diamondImage:rightUp(320, curreyY+6)
    self.contentLayout:addChild(diamondImage, 4)
    -- 钻石数量
    self._diamond = UI.Text:create()
    self._diamond:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._diamond:setTextLeft()
    -- self._diamond:leftUp(220 + 28, curreyY)
    self._diamond:centerLeft(diamondImage:getContentSize().width + 7)
    diamondImage:addChild(self._diamond, 4)

    -- 剩余水晶补签次数
    self.usedDiamondCount = UI.Text:create()
    self.usedDiamondCount:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self.usedDiamondCount:setTextLeft()
    -- self._diamond:leftUp(220 + 28, curreyY)
    self.usedDiamondCount:rightUp(580, curreyY+6)
    contentLayout:addChild(self.usedDiamondCount, 4)

    -- 进度条布局
    local prgContentLayout = UI.Layout:create();
    prgContentLayout:init()
    prgContentLayout:setSize(PROG_WIDTH, 20)
    prgContentLayout:leftBottom(80, 68)
    -- prgContentLayout:enableDebugDraw()
    contentLayout:addChild(prgContentLayout)
    self.prgContentLayout = prgContentLayout
    self:creatSignList()
    self:updateMoneyView()
end

function MonthlySignView:creatSignList()
    self.gameMonth, self.month = mvc.monthlySignModel:getFlagByGameMonth()
    self.monthlySignConfig = mvc.monthlySignModel:getMonthlyConfig()--ConfigManager:getAllMonthlySignDataByID(self.gameMonth)
    local cellLayout = self.contentLayout:getChildByName("cellContentLayout")
    self.title:setText(string.format(UI.TEXT_222401, self.month))
    if cellLayout then
        cellLayout:removeFromParent(true)
    end
    -- CELL内容面板
    local cellContentLayout = UI.Layout:create();
    cellContentLayout:init()
    cellContentLayout:setSize(COM_WIDTH_CELL_LAYOUT, COM_HEIGHT_CELL_LAYOUT)
    cellContentLayout:center(-20, -42)
    cellContentLayout:setName("cellContentLayout")
    self.contentLayout:addChild(cellContentLayout, 100)

    local dailyRewardList = string.split(self.monthlySignConfig.consecutiveSignRewards, ";")
    self.dailyRewardList = dailyRewardList

    if (dailyRewardList) then
        local startX = 0
        local onePaddingX = 102
        local onePaddingY = 98

        for k, v in ipairs(dailyRewardList) do
            local cell = mvc.monthlySignCellView:create()
            cell:init(v, k)
            local idx  = math.floor(k/7)
            if((k-1)%7 == 0 or k == 1) then
                cell:leftUp(startX , onePaddingY*idx)
            else
                local ratio = k%7 == 0 and 7 or k%7
                idx = k%7 == 0 and idx-1 or idx
                cell:leftUp(startX + (ratio-1)*onePaddingX, onePaddingY*idx)
            end
            cellContentLayout:addChild(cell)
        end
    end
    self:updateTicketView()
    self:initProgress()
end

function MonthlySignView:initProgress()
    local accumulativeSignRewardsList = string.split(self.monthlySignConfig.accumulativeSignRewards, ";")
    local progressBar = self.prgContentLayout:getChildByName("progressBar")
    local signInDay = mvc.monthlySignModel:getSignDays()
    if progressBar then
        progressBar:removeFromParent(true)
        progressBar = nil
    end

    -- 进度条
    self._progressBar = UI.ProgressTimer:create()
    self._progressBar:init("ui_monthlysign_progressbar_bg.png", "ui_monthlysign_progressbar.png", "ui_monthlysign_progressbar.png")
    self._progressBar:center()
    self._progressBar:setName("progressBar")
    self.prgContentLayout:addChild(self._progressBar)
    
    local daysNum = table.nums(signInDay)
    self._progressBar:setPercent(daysNum/#self.dailyRewardList)

    local firstStage = UI.Image:create()
    firstStage:init("ui_monthlysign_additional_bg_1.png")
    firstStage:centerLeft(-10, 0)
    self.prgContentLayout:addChild(firstStage)

    local dayText  = UI.Text:create()
    dayText:init(string.format(UI.TEXT_1213961, tostring(daysNum)), UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    dayText:center();
    firstStage:addChild(dayText)

    local dayBg = UI.Image:create()
    dayBg:init("ui_monthlysign_bg_2.png")
    dayBg:centerBottom(-10)
    firstStage:addChild(dayBg, 101)
    
    local dayText1  = UI.Text:create()
    dayText1:init(UI.TEXT_1212441, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
    dayText1:center()
    dayBg:addChild(dayText1)

    for k, v in pairs(accumulativeSignRewardsList) do
        local stageIcon = self:createStageIcon(v)
        self.prgContentLayout:addChild(stageIcon)
    end

end

function MonthlySignView:createStageIcon(data)
    local signRewardsList = string.split(data, ",")
    local len = #self.dailyRewardList
    local rate = signRewardsList[1]/len

    local signInDay = mvc.monthlySignModel:getSignDays()
    local daysNum = table.nums(signInDay)
    local cumulativeData = mvc.monthlySignModel:getCumulativeData()

    local stageLayout = UI.Layout:create()
    stageLayout:init()
    stageLayout:centerLeft(PROG_WIDTH*rate, 0)
    stageLayout:setSize(80, 80)
    -- self.prgContentLayout:addChild(stageLayout)

    -- 背景
    local stageBg = UI.Image:create()
    stageBg:init("ui_monthlysign_additional_bg_2.png")
    stageBg:center()
    stageLayout:addChild(stageBg)

    local cliamedSign = UI.Image:create()
    cliamedSign:init("ui_monthlysign_received.png")
    cliamedSign:rightUp(0, 0)
    stageLayout:addChild(cliamedSign, 100)
    cliamedSign:hide()

    local dayBg = UI.Image:create()
    dayBg:init("ui_monthlysign_bg_3.png")
    dayBg:centerBottom(-10)
    stageLayout:addChild(dayBg, 101)

     local dayText  = UI.Text:create()
    dayText:init(string.format(UI.TEXT_1213961, signRewardsList[1]), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
    dayText:center()
    dayBg:addChild(dayText)

    local goodsData = string.split(self.data, ",")
    local rewardID = tonumber(signRewardsList[2])
    local rewardNum = tonumber(signRewardsList[3])
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:center()
    local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)
    goodsData:setNum(rewardNum)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsGrid:init(goodsData)
    if (num == 0) then
        goodsGrid:hideCountLabel()
    end
    goodsGrid:hideBG()
    goodsGrid:hideRare()
    stageLayout:addChild(goodsGrid)
    for k, v in pairs(cumulativeData)do
        if v == tonumber(signRewardsList[1]) then
            cliamedSign:show()
        end
    end
    stageLayout:setTouchEnable(true)
    stageLayout:addEventListener(UIEvent.COMPONENT_CLICK, stageLayout, function()
        if #cumulativeData > 0 then
            for k, v in pairs(cumulativeData)do
                if v == tonumber(signRewardsList[1]) then
                    cliamedSign:show()
                    UI.ScrollBar:createByText(UI.TEXT_1110721)
                    return
                end
            end
        end
        if daysNum < tonumber(signRewardsList[1]) then
            UI.ScrollBar:createByText(UI.TEXT_222400)
            return
        end
        
        mvc.send(mvc.events.MonthlySign_Cliam_Req, tonumber(signRewardsList[1]), data, rewardID)
    end)


    return stageLayout
end

function MonthlySignView:updateMoneyView()
    self._diamond:setText(self._diamond:numformat(string.format("%d",GameDataManager:getInstance():getDiamond())))
    self._diamond:updateView()
    local times = mvc.monthlySignModel:getUseDiamondMaxCount() - mvc.monthlySignModel:getUseDiamondCount() < 0 and "0" or mvc.monthlySignModel:getUseDiamondMaxCount() - mvc.monthlySignModel:getUseDiamondCount()
    self.usedDiamondCount:setText(string.format(UI.TEXT_222405, times))
    self.usedDiamondCount:updateView()
end

function MonthlySignView:updateTicketView()
    -- self._ticket:setText(self._ticket:numformat(string.format("%d",GameDataManager:getInstance():getCurCoin())))
    local pk = RoleDataManager:getMaster():getPK()
    self._ticket:setText(self._ticket:numformat(string.format("%d",GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, 22072040))))
    self._ticket:updateView()
end

function MonthlySignView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.updateMoneyView)
end


function MonthlySignView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.updateMoneyView)
end





return MonthlySignView












