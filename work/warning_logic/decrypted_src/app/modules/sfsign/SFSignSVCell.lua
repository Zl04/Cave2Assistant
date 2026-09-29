-- SFSignSVCell.lua
-- Author:lzm
-- Using:春节签到cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local SFSignSVCell = class("SFSignSVCell", UI.HWBtnComponent)
UI.SFSignSVCell = SFSignSVCell

local COM_WIDTH = 80
local COM_HEIGHT = 150

local monthMap = {
    UI.TEXT_1213831, UI.TEXT_1213832, UI.TEXT_1213833, UI.TEXT_1213834, UI.TEXT_1213835, UI.TEXT_1213836,
    UI.TEXT_1213837, UI.TEXT_1213838, UI.TEXT_1213839, UI.TEXT_1213840, UI.TEXT_1213841, UI.TEXT_1213842}

--构造函数(必备)
function SFSignSVCell:ctor(signInType)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_SFSIGN_SIGN_OK, self, self.signOver)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_SFSIGN_SCROLLING, self, self.scrolling)

    self._signInType = signInType
    SFSignSVCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function SFSignSVCell:dtor()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_SFSIGN_SIGN_OK, self, self.signOver)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_SFSIGN_SCROLLING, self, self.scrolling)

    SFSignSVCell.super.dtor(self)
end

-- 初始化(必备)
function SFSignSVCell:init(data)
    self.recordingMove = false
    self.cancelClick = false
    self._data = data
    SFSignSVCell.super.init(self)

    self:setTouchEnable(true)
    self:setSwallowTouches(false)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        self.recordingMove = true
    end)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, com, touchPosition)
        if self.cancelClick then
            self.cancelClick = false
            return
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_SFSIGN_CELL_CLICK, self._data.idx)
        self:cellClick()

        self.recordingMove = false
    end)

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    cellLayout:setName("cellLayout")
    self:addChild(cellLayout)
    self.cellLayout = cellLayout

    -- 背景
    local bg = UI.Image:create()
    local bgNameList = {"ui_town_festivalsign_past_%d.png", "ui_town_festivalsign_today_%d.png", "ui_town_festivalsign_future_%d.png"}
    local bgName = string.format(bgNameList[self._data.dayState], self._data.cfg.dateResource)
    bg:init(bgName)
    bg:center()
    cellLayout:addChild(bg, 1)
    self.bg = bg

    local month = UI.Text:create()
    month:init(monthMap[self._data.date.month], UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    month:setWidth(80)
    month:setTextCenter()
    month:autoAdapt()
    month:centerUp(8)
    self.bg:addChild(month)

    local day = UI.Text:create()
    day:init(tostring(self._data.date.day), UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    day:setWidth(200)
    day:setTextCenter()
    day:autoAdapt()
    day:centerUp(46)
    self.bg:addChild(day)

    -- 1:过去已签，2:过去未签，3:今日已签，4:今日未签，5:未来
    if self._data.signState == 1 or self._data.signState == 3 then
        local signImg = UI.Image:create()
        signImg:init("ui_information_btn_yes.png")
        signImg:leftBottom(24, 10)
        self.bg:addChild(signImg)
    end
end

-- 模版函数：初始化组建的视图(必备)
function SFSignSVCell:onInitView()
end

function SFSignSVCell:getData()
    return self._data;
end

function SFSignSVCell:signOver(day)
    if self._data.cfg.ID == day then
        self._data.signState = 3

        local signImg = UI.Image:create()
        signImg:init("ui_information_btn_yes.png")
        signImg:leftBottom(24, 10)
        self.bg:addChild(signImg)
    end
end

function SFSignSVCell:scrolling()
    if self.recordingMove then
        self.cancelClick = true
    end
end

function SFSignSVCell:onUpdateView()

end

function SFSignSVCell:cellClick()
    if not self.select then
        self.select = UI.Animation:create()
        self.select:init("effect_ui_twon_qiandao_riqi.json", "effect_ui_twon_qiandao_riqi.atlas")
        self.select:center()
        self.cellLayout:addChild(self.select, 10)
    end

    self.select:show()
    self.select:setAnimation("click", false)
    self.select:addAnimation("idle", true)

    self._data.select = true
end

function SFSignSVCell:clearSelect()
    if not self.select then
        return
    end

    self.select:hide()

    self._data.select = false
end
