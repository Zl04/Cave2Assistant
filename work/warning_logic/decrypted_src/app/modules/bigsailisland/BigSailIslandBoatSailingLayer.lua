------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandBoatSailingLayer = class("BigSailIslandBoatSailingLayer", UI.HWBtnComponent)
require "app.modules.bigsailisland.BigSailIslandInfoView"

UI = UI or {}

UI.BigSailIslandBoatSailingLayer = BigSailIslandBoatSailingLayer

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 410
local COM_HEIGHT = 172

local CELL_WIDTH = 95
local CELL_HEIGHT = 140

-- 船只状态
local BigSailBoatStatus = PublicDefine.BigSailBoatStatus

function BigSailIslandBoatSailingLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH, self, self.switchClick)
end

function BigSailIslandBoatSailingLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH, self, self.switchClick)
end

function BigSailIslandBoatSailingLayer:ctor(parent)
    BigSailIslandBoatSailingLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.parent = parent
    self.switchBtnState = nil
    self.cellList = {}
    self:bindModel()
end

function BigSailIslandBoatSailingLayer:init( ... )
    BigSailIslandBoatSailingLayer.super.init(self, ... )
    self.isEmbattling = false
end

function BigSailIslandBoatSailingLayer:dtor()
    BigSailIslandBoatSailingLayer.super.dtor(self)
    self:unbindModel()
    self.isEmbattling = false
    self.switchBtnState = nil
    self.cellList = {}
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandBoatSailingLayer")
end

function BigSailIslandBoatSailingLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_greatnavigation_taskbg.png")
    bg:center()
    contentLayout:addChild(bg)


    local switchBtnClose = UI.Button:create()
    switchBtnClose:init("ui_greatnavigation_taskbtn2.png", "ui_greatnavigation_taskbtn2.png")
    -- local w, h = switchBtnClose:getSize()
    switchBtnClose:centerRight(-34)
    switchBtnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    contentLayout:addChild(switchBtnClose)
    switchBtnClose:closeClickScale()
    self.switchBtnClose = switchBtnClose
    self.switchBtnClose:hide()

    local switchBtnOpen = UI.Button:create()
    switchBtnOpen:init("ui_greatnavigation_taskbtn1.png", "ui_greatnavigation_taskbtn1.png")
    -- local w, h = switchBtnOpen:getSize()
    switchBtnOpen:centerRight(-34)
    switchBtnOpen:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    contentLayout:addChild(switchBtnOpen)
    switchBtnOpen:closeClickScale()
    self.switchBtnOpen = switchBtnOpen
    self.switchBtnOpen:hide()

    self:updateSwitchBtnShow()
    self:initBoatInfoView()
end

function BigSailIslandBoatSailingLayer:initBoatInfoView()
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    local index = 0
    for k,v in pairs(baseInfo.useBoats) do
        if v.status == BigSailBoatStatus.BigSailBoating
            or v.status == BigSailBoatStatus.BigSailBoatingCaptured then
            local infoCell = self:createBoatInfoCell(v)
            infoCell:center(0, index*70 - 30)
            self.contentLayout:addChild(infoCell)   
            index = index + 1
            if index == 1 then
                self:switchClick()
            end
        end
    end
end



function BigSailIslandBoatSailingLayer:switchClick()
    if self.switchBtnState == 1 then
        self.switchBtnState = 0

        self:stopAllActions()

        self.runActioning = true
        self:runAction(cc.Sequence:create(
            cc.MoveTo:create(0.1, cc.p(-COM_WIDTH+13,11)),
            cc.CallFunc:create(function()
                self.runActioning = false
                self:updateSwitchBtnShow()
            end))
        )

    else
        self.switchBtnState = 1

        self:stopAllActions()

        self.runActioning = true
        self:runAction(cc.Sequence:create(
            cc.MoveTo:create(0.1, cc.p(12,11)),
            cc.CallFunc:create(function()
                self.runActioning = false
                self:updateSwitchBtnShow()
            end))
        )
        
    end

end

function BigSailIslandBoatSailingLayer:updateSwitchBtnShow()
    if self.switchBtnState == 1 then
        local w = self.switchBtnClose:getSize()
        self.switchBtnClose:centerRight(-34)
        -- self.contentLayout:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

        self.switchBtnClose:show()
        self.switchBtnOpen:hide()
    else
        local w = self.switchBtnOpen:getSize()
        self.switchBtnOpen:centerRight(-34)
        -- self.contentLayout:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

        self.switchBtnClose:hide()
        self.switchBtnOpen:show()
    end
end

function BigSailIslandBoatSailingLayer:createBoatInfoCell(data)
    local boatConfig = ConfigManager:getAllBoatDataByID(data.boatId)
    local isCaptured = data.status == BigSailBoatStatus.BigSailBoatingCaptured
    -- 内容面板
    local infoLayout = UI.Layout:create()
    infoLayout:init()
    infoLayout:setSize(380, 68)
    infoLayout:center()
    -- self.contentLayout:addChild(infoLayout)
    -- self.infoLayout = infoLayout
    -- infoLayout:enableDebugDraw()

    -- 背景图片
    local infoBg  = UI.Image:create()
    infoBg:init("ui_greatnavigation_task_list.png")
    infoBg:centerUp()
    infoLayout:addChild(infoBg)

    -- local boatImgName = "ui_greatnavigation_boat"..data.boatId-23290000
    local boatImg  = UI.Image:create()
    boatImg:init(boatConfig.navigationShow)
    boatImg:centerLeft(5, 0)
    infoLayout:addChild(boatImg)
    
    local islandConfig = ConfigManager:getIslandsByID(data.islandId)
    local islandName = languageManagerInstance:getLocalString(islandConfig.name)
    local showText = isCaptured and string.format(UI.TEXT_226218, islandName) or string.format(UI.TEXT_226207, islandName)
    local sailDex = UI.Text:create()
    sailDex:init(showText, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    sailDex:center(0, -10)
    infoLayout:addChild(sailDex)

    if not isCaptured then
        local time = AvalonUtil:getNewFullFormatTime(data.leftSailSeconds + GameManager:getNormalServerTime(), Game.TIME_LEVEL.TIME_LEVEL_MINUTE)
        local showStr = string.format(UI.TEXT_226214, time)
        local leftTime = UI.Text:create()
        leftTime:init(showStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
        leftTime:center(0, 10)
        infoLayout:addChild(leftTime)
    end
    
    local btnText = isCaptured and UI.TEXT_226219 or UI.TEXT_226206
    local speedUpBtn = UI.Button:create()
    speedUpBtn:init("ui_greatnavigation_btn_7.png", "ui_greatnavigation_btn_7.png")
    speedUpBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    speedUpBtn:setText(btnText)
    speedUpBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if isCaptured then
            local islandsData = {}
            islandsData.landId = data.islandId

            -- 请求对应岛屿的信息
            Net.NetBigSailSystem:reqIslandInfo(islandsData)

            local data2 = {islandsData}
            -- data里面要有选中岛屿的id
            local bigSailIslandInfoView = UI.BigSailIslandInfoView:create(data2)
            bigSailIslandInfoView:init()
            bigSailIslandInfoView:center(0, 0)
            bigSailIslandInfoView:setName("bigSailIslandInfoView")
            self.parent:addChild(bigSailIslandInfoView, 10)
        else
            self:onSpeedUp(data.boatId)
        end
        
    end)
    speedUpBtn:centerRight(15)
    infoLayout:addChild(speedUpBtn)

    return infoLayout
end

function BigSailIslandBoatSailingLayer:onSpeedUp(boatID)
    local landId = self:isAllowSpeedUp(boatID)
    local data = {}
    data.boatId = boatID
    data.landId = landId

    if landId == 0 then
        UI.ScrollBar:createByText(UI.TEXT_226208)
    else
        mvc.openPanel("BigSailPort", "BigSailPortSpeedUp", data)
    end
end

function BigSailIslandBoatSailingLayer:isAllowSpeedUp(BoatId)
    -- 判断船只是否满足一键加速条件,返回占领岛屿id(为0则表示没有占领岛屿)
    local landId = 0
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    for k,v in pairs(baseInfo.useBoats) do
        if v.boatId == BoatId and v.status == BigSailBoatStatus.BigSailBoating then
            landId = v.islandId
            return landId
        end
    end

    return landId
end

return BigSailIslandBoatSailingLayer












