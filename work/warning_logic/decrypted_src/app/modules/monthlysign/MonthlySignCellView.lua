------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/06/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MonthlySignCellView = class("MonthlySignCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 90
local COM_HEIGHT = 91

function MonthlySignCellView:ctor()
    MonthlySignCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.index = nil
    self.bgAnimation = nil
    self:bindModel()
end

function MonthlySignCellView:init( data, index )
    self.data = data
    self.index = index
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.monthlysign", "MonthlySign", false)
    MonthlySignCellView.super.init(self )
end

function MonthlySignCellView:dtor()
    self.index = nil
    self.bgAnimation = nil
    MonthlySignCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.monthlysign.MonthlySignCellView")
end


function MonthlySignCellView:onInitView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    cellLayout:setName("cellLayout")
    self:addChild(cellLayout)
    self.cellLayout = cellLayout

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_monthlysign_paper.png")
    bg:center()
    cellLayout:addChild(bg)

    local bgAnimation = UI.Animation:create()
    bgAnimation:init("effect_ui_town_signin.json", "effect_ui_town_signin.atlas", 1);
    bgAnimation:center()
    cellLayout:addChild(bgAnimation)
    bgAnimation:setAnimation("idle", true)
    self.bgAnimation = bgAnimation
    
    self:initGoodsGridView()
end

function MonthlySignCellView:initGoodsGridView()
    local gridLayout = UI.Layout:create()
    gridLayout:init()
    gridLayout:setSize(60, 60)
    gridLayout:center()
    gridLayout:setName("gridLayout")
    self.cellLayout:addChild(gridLayout)
    -- self.gridLayout = gridLayout 

    local month,day = mvc.monthlySignModel:getCurDate()
    local signInDays = mvc.monthlySignModel:getSignDays()
    local canEplenishSign = mvc.monthlySignModel:checkCanSignIn(self.index)

    local goodsData = string.split(self.data, ",")
    local rewardID = tonumber(goodsData[1])
    local rewardNum = tonumber(goodsData[2])
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
    gridLayout:addChild(goodsGrid)
    -- goodsGrid:updateCanUseState(self.index <= day)
    self.bgAnimation:setVisible(self.index == day and not signInDays[self.index])
    gridLayout:setTouchEnable(not canEplenishSign)
    if not canEplenishSign and not signInDays[self.index] then
        gridLayout:addEventListener(UIEvent.COMPONENT_CLICK, gridLayout, function()
            -- if loginDays <= signInDay or toDay == lastSignInDay then
            --     UI.ScrollBar:createByText(UI.TEXT_222402)
            --     return
            -- end
            -- if not self:canUseTickets() and mvc.monthlySignModel:getUseDiamondCount() == mvc.monthlySignModel:getUseDiamondMaxCount() and not day == self.index then
            --     UI.ScrollBar:createByText(UI.TEXT_222404)
            --     return
            -- end

            if day == self.index then
                mvc.send(mvc.events.MonthlySign_In_Req, self.data, self.index, rewardID)
            end
        end)
    end

    goodsGrid:setVisible(not signInDays[self.index])

    local edibledImage = UI.Image:create()
    edibledImage:init("ui_catfood_seal.png")
    edibledImage:centerUp(-18)
    gridLayout:addChild(edibledImage)

    local edibled  = UI.Text:create()
    edibled:init(UI.TEXT_1110721, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
    edibled:setAnchorPoint(0.5, 0.5)
    edibled:rotate(15)
    edibled:centerUp(38)
    edibledImage:addChild(edibled, -1)
    edibledImage:setScale(0.8)
    edibledImage:setVisible(signInDays[self.index])

    local signInBtn = UI.Button:create()
    signInBtn:init("ui_monthlysign_btn.png", "ui_monthlysign_btn.png", "ui_monthlysign_btn.png")
    signInBtn:center()
    signInBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    signInBtn:setText(UI.TEXT_1213851)
    gridLayout:addChild(signInBtn, 30)
    signInBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onSignIn)
    signInBtn:setVisible(canEplenishSign)
end

function MonthlySignCellView:onSignIn()
    local refillConsumption = tonumber(ConfigManager:getGeneralForKey("refillConsumption"))
    local str = string.format(UI.TEXT_222403, refillConsumption)--mvc.monthlySignModel:getUseDiamondCount() < mvc.monthlySignModel:getUseDiamondMaxCount() and UI.TEXT_222403 or UI.TEXT_222406
    if self:canUseTickets() then
        str = UI.TEXT_222406
    end
    local tips = UI.Tips:createTips(
        str,
        UI.TipsType.CONFIRM_AND_CANCEL,
        UI.TipsUiType.NORMAL
    )

    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        -- if GameDataManager:getInstance():getDiamond() < refillConsumption then
        --     UI.TipsLayer:onDiamondNotEnough()
        --     return
        -- end
        local goodsData = string.split(self.data, ",")
        local rewardID = tonumber(goodsData[1])
        mvc.send(mvc.events.MonthlySign_In_Req, self.data, self.index, rewardID)
    end)
    
end

function MonthlySignCellView:canUseTickets()
    local can = false
    local pk = RoleDataManager:getMaster():getPK()
    local tickets = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, 22072040)
    if tickets and tickets > 0 then
        can = true
    end
    return can
end

function MonthlySignCellView:bindModel()

end


function MonthlySignCellView:unbindModel()

end





return MonthlySignCellView












