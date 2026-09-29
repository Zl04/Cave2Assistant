-- SevenDayGoalCell.lua
-- Author:CMonk
-- 2019年04月09日

require "app.ui.common.Text"
require "utils.AvalonUtil"

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local SevenDayGoalCell = class("SevenDayGoalCell", UI.TableViewCell)
UI.SevenDayGoalCell = SevenDayGoalCell

SevenDayGoalCell.CELL_WIDTH = 237
SevenDayGoalCell.CELL_HEIGHT = 68

local BTN_TXT_ENABLED_COLOR = UI.FONT_COLOR_50_50_44
local BTN_TXT_DISABLED_COLOR = {r = 191, g = 175, b =171}

function SevenDayGoalCell:ctor(parentTable)
    SevenDayGoalCell.super.ctor(self)

    self._parentTable = parentTable
    self:onInitView()
end

function SevenDayGoalCell:onInitView()
    -- 内容运载层
    self._rootLayer = UI.Image:create()
    self._rootLayer:init()
    self._rootLayer:setSize(UI.SevenDayGoalCell.CELL_WIDTH, UI.SevenDayGoalCell.CELL_HEIGHT)
    self._rootLayer:leftBottom(0, 0)
    self:addChild(self._rootLayer)

    -- 按钮
    self._btn = UI.Button:create()
    self._btn:init("ui_btn_yellow13_0.png", "ui_btn_yellow13_1.png", "ui_btn_yellow13_2.png")
    self._btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._btn:centerUp(2)
    self._btn:closeClickScale()
    self._btn:setSwallowTouches(false)
    self._btn:setTouchClipNode(self._parentTable)
    self._btn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if (self._clickCB) then self._clickCB(self._btn) end
    end)
    self._rootLayer:addChild(self._btn)

    -- 禁用外观
    local disabledNode = UI.Layout:create()
    disabledNode:init()
    disabledNode:center()
    self._btn:setDisabledNode(disabledNode)

    -- 禁用锁
    local lock = UI.Image:create()
    lock:init("ui_sevendays_lock.png")
    lock:center(-55, 0)
    disabledNode:addChild(lock)

    -- 红点
    self._redPoint = AvalonUtil.createRedPoint(self._btn, 0, 0)
    self._redPoint:hide()
end











-------------SevenDayLayer 接口--------------
function SevenDayGoalCell:reset()
    
end

function SevenDayGoalCell:setClickCallback(cb)
    self._clickCB = cb
end

function SevenDayGoalCell:updateData(data)
    self._data = data
    if (self._data) then
        -- 解锁?
        if (self._data.isLocked) then
            self._btn:disable()
            self._btn:setText("???")
            self._btn._sprite:setOpacity(80)
            self._btn:setFontColor(BTN_TXT_DISABLED_COLOR)
        elseif (self._data.nameLocal) then
            self._btn:enable()
            self._btn:setText(self._data.nameLocal)
            self._btn._sprite:setOpacity(255)
            self._btn:setFontColor(BTN_TXT_ENABLED_COLOR)
        end

        -- 点击激活?
        if (self._data.isActive) then
            self._btn:press()
            self._btn:keepActivated(true)
            self._redPoint:rightUp(-2, -2)
        else
            self._btn:release()
            self._btn:keepActivated(false)
            self._redPoint:rightUp(0, 0)
        end

        -- 有没有可以领取的东西?
        if (self._data.isFinishStatExist) then
            self._redPoint:show()
        else
            self._redPoint:hide()
        end
    end
end