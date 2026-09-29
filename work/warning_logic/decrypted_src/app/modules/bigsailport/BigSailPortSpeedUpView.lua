------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/27
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortSpeedUpView = class("BigSailPortSpeedUpView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_general_shop.plist",
    "ui_common_symbol.plist",
    "ui_town_greatnavigation.plist",
    "ui_common_btn.plist",
    "ui_common_icon_item.plist",
}

local COM_WIDTH = 447
local COM_HEIGHT = 305
local winSize = cc.Director:getInstance():getWinSize()

function BigSailPortSpeedUpView:ctor(data)
    BigSailPortSpeedUpView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.timeRemaining = 0 -- 本次航行剩余时间
    self.data = data
    self.distance = 0 -- 距离终点距离
    self.diamondNum = GameDataManager:getInstance():getDiamond()
    self:bindModel()
end

function BigSailPortSpeedUpView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailPortSpeedUpView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        mvc.closePanel("BigSailPort", "BigSailPortSpeedUp")
        --self:close()
    end)
end

function BigSailPortSpeedUpView:dtor()
    BigSailPortSpeedUpView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailport.BigSailPortSpeedUpView")
end


function BigSailPortSpeedUpView:onInitView()
    self:center(0,0)
    --self:enableDebugDraw()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0,0)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(COM_WIDTH / 2, COM_HEIGHT / 2)
    self.contentLayout:addChild(mask, 0)

    local bgImage = UI.Image:create()
    bgImage:init("ui_greatnavigation_paper_5.png")
    bgImage:center(0, 0)
    self.contentLayout:addChild(bgImage)

    -- local title  = UI.Image:create()
    -- title:init("ui_setup_banner_box4.png")
    -- title:center(0, -165)
    -- self.contentLayout:addChild(title)

    -- UNSUCCESS_TAB 缺少ui.text12312
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226114, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    titleText:center(0, -113)
    self.contentLayout:addChild(titleText)

    -- -- 等级变化显示
    -- local levelLimitBanner = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box4.png")
    -- levelLimitBanner:setContentSize(300, 28)
    -- levelLimitBanner:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT / 2 + 160))
    -- self.contentLayout:addChild(levelLimitBanner)

    --self:refreshDistance()
    local timeRemaingStr = self:getTimeRemaing()

    -- UNSUCCESS_TAB 缺少ui.text12312
    local nowSupplyText = UI.Text:create()
    nowSupplyText:init(timeRemaingStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    nowSupplyText:center(-30,-50)
    self.contentLayout:addChild(nowSupplyText)

    local nowSupplyText2 = UI.Text:create()
    nowSupplyText2:init(UI.TEXT_226154, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    nowSupplyText2:center(-10,-10)
    self.contentLayout:addChild(nowSupplyText2)

    -- -- UNSUCCESS_TAB 缺少补给道具图片
    -- local nowSupplyPic = UI.Image:create()
    -- nowSupplyPic:init("ui_information_achievement.png")
    -- nowSupplyPic:center(-230,0)
    -- self.contentLayout:addChild(nowSupplyPic)

    -- UNSUCCESS_TAB 一键完成按钮
    local successBtn = UI.Button:create()
    successBtn:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png")
    successBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.diamondNum >= self.timeRemaining then
            local messageData = {
                boatId = self.data.boatId,
            }
            Net.NetBigSailSystem:reqSpeedUp(messageData)
            UI.ScrollBar:createByText(UI.TEXT_226176)
            mvc.closePanel("BigSailPort", "BigSailPortSpeedUp")
        else
            UI.ScrollBar:createByText(UI.TEXT_1110399)
        end
    end)
    successBtn:center(100, 100)
    successBtn:closeClickScale()
    self.contentLayout:addChild(successBtn)

    -- UNSUCCESS_TAB 一键完成按钮
    local cancelBtn = UI.Button:create()
    cancelBtn:init("ui_btn_no1_0.png", "ui_btn_no1_0.png")
    cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("BigSailPort", "BigSailPortSpeedUp")
    end)
    cancelBtn:center(-100, 100)
    cancelBtn:closeClickScale()
    self.contentLayout:addChild(cancelBtn)

    -- 消耗
    local costText = UI.Text:create()
    costText:init(UI.TEXT_223908..":", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    costText:center(-70,44)
    self.contentLayout:addChild(costText)


    -- UNSUCCESS_TAB 钻石图片
    local config = ConfigManager:getAllNavigationGeneralConfigData()[1].speedUpConsume
    local strName = string.split(config, ",")
    local goodObj = GoodsDataManager:createLocalGoodsData(tonumber(strName[1]))
    local iconName = goodObj:getSmallIconName()
    local diamondPic = UI.Image:create()
    diamondPic:init(iconName)
    diamondPic:center(40,44)
    self.contentLayout:addChild(diamondPic)

    -- 钻石数量
    local diamondTxt1 = UI.Text:create()
    diamondTxt1:init(tostring(self.timeRemaining* tonumber(strName[2])), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    diamondTxt1:setTextLeft()
    diamondTxt1:centerLeft(diamondPic:getContentSize().width + 10)
    diamondPic:addChild(diamondTxt1)

    -- --- 右上角购买按钮
    -- local shopButton = UI.Button:create()
    -- shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    -- shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, 1, nil,
    --         PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_Bag)
    -- end)
    -- shopButton:center(300, -240)
    -- self.contentLayout:addChild(shopButton)

    -- -- 钻石数量
    -- local diamondTxt = UI.Text:create()
    -- diamondTxt:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    -- diamondTxt:setTextLeft()
    -- -- self._diamond:leftUp(220 + 28, curreyY)
    -- diamondTxt:centerLeft(shopButton:getContentSize().width + 4)
    -- diamondTxt:setText(diamondTxt:numformat(string.format("%d",self.diamondNum)))
    -- shopButton:addChild(diamondTxt)
    
end

function BigSailPortSpeedUpView:getTimeRemaing()
    local timeStr = ""

    -- local nowSpeed = 1
    -- local basrData = mvc.bigSailPortModel:getBaseData()
    -- for k,v in pairs(basrData.useBoats) do
    --     if v.boatId == self.data.boatId then
    --         nowSpeed = v.speed
    --         break
    --     end
    -- end

    local allSeconds = 0
    local basrData = mvc.bigSailPortModel:getBaseData()
    for k,v in pairs(basrData.useBoats) do
        if v.boatId == self.data.boatId then
            allSeconds = v.leftSailSeconds
        end
    end

    local time = AvalonUtil:getNewFullFormatTime(allSeconds + GameManager:getNormalServerTime(), Game.TIME_LEVEL.TIME_LEVEL_MINUTE)
    print("basrData===>: ", time)
    timeStr = UI.TEXT_226153..time

    print("basrData==222=>: ", allSeconds)
    local minute = math.modf(allSeconds/SECONDS_ONE_MINUTES)
    allSeconds = allSeconds % SECONDS_ONE_MINUTES
    if(allSeconds > 0) then 
        minute = minute + 1
    end
    self.timeRemaining = minute

    -- local timeMins = allSeconds -- 航行到达岛屿剩余时间(/分钟)
    -- self.timeRemaining = math.ceil(timeMins)
    -- local hourse = math.floor(timeMins / 60)
    -- timeMins = math.ceil(timeMins - hourse * 60)
    -- timeStr = string.format(UI.TEXT_226116, tostring(hourse), tostring(timeMins))
    return timeStr
end

function BigSailPortSpeedUpView:refreshDistance()
    -- local positonConfig = ConfigManager:getIslandsByID(self.data.landId).position
    -- local positon = string.split(positonConfig, ",")
    -- local coefficient = ConfigManager:getNavigationGeneralConfigByID(1).distanceCoefficient
    -- self.distance = math.sqrt(positon[1] * positon[1] + positon[2] * positon[2])*coefficient
    -- print("BigSailPortSpeedUpView  distance-->: ", self.distance)

    -- local basrData = mvc.bigSailPortModel:getBaseData()
    -- for k,v in pairs(basrData.useBoats) do
    --     if v.boatId == self.data.boatId then
    --         self.distance = self.distance - v.distance -- 总路程 - 已航行路程
    --     end
    -- end
end


function BigSailPortSpeedUpView:bindModel()
end

function BigSailPortSpeedUpView:unbindModel()
end


return BigSailPortSpeedUpView












