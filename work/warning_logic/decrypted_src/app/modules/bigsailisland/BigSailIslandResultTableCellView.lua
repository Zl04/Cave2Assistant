------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandResultTableCellView = class("BigSailIslandResultTableCellView", UI.ListGrid)

UI = UI or {}
UI.BigSailIslandResultTableCellView = BigSailIslandResultTableCellView

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_common_symbol.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function BigSailIslandResultTableCellView:ctor()
    BigSailIslandResultTableCellView.super.ctor(self)
    self:bindModel()
end

function BigSailIslandResultTableCellView:init( ... )
    --self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandResultTableCellView.super.init(self, ... )
end

function BigSailIslandResultTableCellView:dtor()
    BigSailIslandResultTableCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandResultTableCellView")
end


function BigSailIslandResultTableCellView:onInitView()
end

function BigSailIslandResultTableCellView:onUpdateView()
    if not self._data then
        return
    end
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self._cellLayout = cellLayout
    self:addChild(cellLayout)

    self:updateSkillList()
end

function BigSailIslandResultTableCellView:addOneSkill(data)
    local resultLayer = UI.Layout:create()
    resultLayer:init()
    resultLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)
    resultLayer:center()

    local resultBG = UI.Image:create()
    resultBG:init("ui_greatnavigation_battlebg_3.png")
    resultBG:center()
    resultLayer:addChild(resultBG)

    local config = ConfigManager:getAllNavigationGeneralConfigData()[1]
    local winExpend = config.victorySupplyConsume -- 胜利消耗补给
    local failExpend = config.defaultSupplyConsume -- 失败消耗补给

    local expelBaseData = mvc.bigSailIslandModel:getExpelBaseData()
    local myPower = expelBaseData.myPower -- 战斗开始前我方的战斗力
    local otherPower = expelBaseData.otherPower -- 战斗开始前敌人的战斗力

    local isRate,needNum,needNum2 = mvc.bigSailIslandModel:getConsumptionRate(otherPower,myPower)
    if isRate then
        failExpend = needNum
        winExpend = needNum2
    end

    local str =  (data.isWin and winExpend) or failExpend 
    local mySubSupplyTxt = UI.Text:create()
    mySubSupplyTxt:init(UI.TEXT_226141..tostring(str), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 140, g = 171, b = 233})
    mySubSupplyTxt:center(-145, -33)
    resultLayer:addChild(mySubSupplyTxt)

    local mySupplyPic = UI.Image.create()
    mySupplyPic:init("ui_greatnavigation_supply.png")
    mySupplyPic:center(70, -33)
    resultLayer:addChild(mySupplyPic)

    local mySupplyNum = UI.Text:create()
    mySupplyNum:init(tostring(data.mySupply), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 140, g = 171, b = 233})
    mySupplyNum:center(15, 0)
    mySupplyPic:addChild(mySupplyNum)

    local mySupplyTxt = UI.Text:create()
    mySupplyTxt:init(UI.TEXT_226142, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 140, g = 171, b = 233})
    mySupplyTxt:center(-80, 0)
    mySupplyPic:addChild(mySupplyTxt)

    local myTxt = UI.Text:create()
    myTxt:init(UI.TEXT_1213449, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
    myTxt:center(172, -45)
    resultLayer:addChild(myTxt)
    ------------------------------------------
    -- 敌方
    local str =  (data.isWin and failExpend) or winExpend 
    local otherSubSupplyTxt = UI.Text:create()
    otherSubSupplyTxt:init(UI.TEXT_226141..tostring(str), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 235, g = 121, b = 121})
    otherSubSupplyTxt:center(-60, 7)
    resultLayer:addChild(otherSubSupplyTxt)

    local otherSupplyPic = UI.Image.create()
    otherSupplyPic:init("ui_greatnavigation_supply.png")
    otherSupplyPic:center(130, 7)
    resultLayer:addChild(otherSupplyPic)

    local otherSupplyNum = UI.Text:create()
    otherSupplyNum:init(tostring(data.otherSuppy), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 235, g = 121, b = 121})
    otherSupplyNum:center(15, 0)
    otherSupplyPic:addChild(otherSupplyNum)

    local otherSupplyTxt = UI.Text:create()
    otherSupplyTxt:init(UI.TEXT_226142, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 235, g = 121, b = 121})
    otherSupplyTxt:center(-80, 0)
    otherSupplyPic:addChild(otherSupplyTxt)

    local otherTxt = UI.Text:create()
    otherTxt:init(UI.TEXT_1213450, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
    otherTxt:center(-175, -5)
    resultLayer:addChild(otherTxt)

    ------------------------------------------
    -- 结果展示
    local str2 = (data.isWin and "ui_greatnavigation_battleglag_1.png") or "ui_greatnavigation_battleglag_2.png" 
    local resultPic = UI.Image.create()
    resultPic:init(str2)
    resultPic:center(-136, 43)
    resultLayer:addChild(resultPic)

    local str2 = (data.isWin and UI.TEXT_226143) or UI.TEXT_226144
    local strColor = (data.isWin and {r = 231, g = 193, b = 83}) or {r = 191, g = 206, b = 237} 
    local resultTitleTxt = UI.Text:create()
    resultTitleTxt:init(str2, UI.FONT_BOLD, UI.FONT_SIZE_18PX, strColor)
    resultTitleTxt:center(-12,0)
    resultTitleTxt:enableShadow({r = 0, g = 0, b = 0}, {width = 2, height = 0})
    resultPic:addChild(resultTitleTxt)

    -- 查看详情按钮
    local checkAllResultBtn = UI.Button:create()
    checkAllResultBtn:init("ui_greatnavigation_btn_5.png","ui_greatnavigation_btn_5.png","ui_greatnavigation_btn_5.png")
    checkAllResultBtn:center(272, 0)
    checkAllResultBtn:setText(UI.TEXT_223606)
    checkAllResultBtn:closeClickScale()
    checkAllResultBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    checkAllResultBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local data2 = {
            isWin = data.isWin, 
            petStatistics = data.petStatistics,
            otherSuppy = data.otherSuppy,
            mySupply = data.mySupply,
            myPower = expelBaseData.myPower, -- 战斗开始前我方的战斗力
            otherPower = expelBaseData.otherPower, -- 战斗开始前敌人的战斗力
        }
        Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_PETPVPEND, data2)
    end)
    resultPic:addChild(checkAllResultBtn)

    return resultLayer
end

function BigSailIslandResultTableCellView:getData()
    return self._data
end

function BigSailIslandResultTableCellView:updateSkillList()
    local oneSkill = self:addOneSkill(self._data)
    self.oneSkill = oneSkill
    self._cellLayout:addChild(oneSkill)
end

function BigSailIslandResultTableCellView:isClickShowInfo()
    return true
end


function BigSailIslandResultTableCellView:bindModel()

end


function BigSailIslandResultTableCellView:unbindModel()

end





return BigSailIslandResultTableCellView












