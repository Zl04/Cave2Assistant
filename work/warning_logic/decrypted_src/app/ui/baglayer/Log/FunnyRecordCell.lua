-- FunnyRecordCell.lua
-- Author:ydli
-- 2017年11月16日
-- Using:趣味数据列表 cell

local winSize = cc.Director:getInstance():getWinSize()
UI = UI or {}
local FunnyRecordCell = class("FunnyRecordCell", UI.HWBtnComponent)
UI.FunnyRecordCell = FunnyRecordCell

local COM_RES_LIST = {
}

function FunnyRecordCell:ctor()
    FunnyRecordCell.super.ctor(self, UIType.FUNNY_RECORD_CELL, COM_RES_LIST, 820, 220)
    self._funnyRecords = {}
    self._idx = nil
    self._cutSize = nil
    self:registerListener()
end

function FunnyRecordCell:dtor()
    FunnyRecordCell.super.dtor(self)
    self._funnyRecords = {}
    self._idx = nil
    self._cutSize = nil
    self:unRegisterListener()
end

-- public:
-- 初始化
function FunnyRecordCell:init(funnyRecords, idx, cutSize)
    FunnyRecordCell.super.init(self)
    self._funnyRecords = funnyRecords
    self._idx = idx
    self._cutSize = cutSize
    -- self:enableDebugDraw()
end

-- 模版函数：初始化组建的视图
function FunnyRecordCell:onInitView()    
    
end

-- 模版函数：更新组建的视图
function FunnyRecordCell:onUpdateView()
    local dataList = {}
    local beginIndex = (self._idx - 1) * self._cutSize
    for k, v in ipairs(self._funnyRecords) do
        if k > beginIndex and k <= beginIndex + self._cutSize then
            table.insert(dataList, v)
        end
    end
    for k, v in ipairs(dataList) do
        self:createOneRecord(v, k)
    end
end

function FunnyRecordCell:createOneRecord(data, i)
    -- dump(data, "----------data")
    local bg = UI.Image:create()
    bg:init("ui_log_button_paper.png")
    bg:leftBottom(36 + 200 * (i - 1), 3)
    self:addChild(bg)

    local icon = UI.Image:create()
    icon:init(data.icon)
    -- icon:init("ui_funnyRecord_icon_1.png")
    icon:centerBottom(77)
    bg:addChild(icon)

    local name = UI.Text:create()
    name:init(string.format("%s", data.name), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    name:setSize(155, 45)
    name:setTextCenter()
    name:centerBottom(33)
    bg:addChild(name)
    -- name:enableDebugDraw()
    name:setLineSpacing(-1)

    local score = UI.Text:create()
    score:init(string.format("%d", data.score), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    score:setSize(170, 25)
    score:setTextCenter()
    score:centerBottom(10)
    bg:addChild(score)
end

-- 注册监听事件(可选)
function FunnyRecordCell:registerListener()
end

-- 注销监听事件(可选)
function FunnyRecordCell:unRegisterListener()

end
