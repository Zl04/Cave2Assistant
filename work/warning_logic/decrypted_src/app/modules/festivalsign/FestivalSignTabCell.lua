-- FestivalSignTabCell.lua
-- Author:lzm
-- 2019年8月16日
-- Using:七日目标 tab cell

UI = UI or {}

local FestivalSignTabCell = class("FestivalSignTabCell", UI.TableViewCell)
UI.FestivalSignTabCell = FestivalSignTabCell

local BTN_CELL_W = 109
local BTN_CELL_H = 68

function FestivalSignTabCell:ctor()
    
end

function FestivalSignTabCell:onEnter()
    FestivalSignTabCell.super.onEnter(self);
end

function FestivalSignTabCell:onExit()
    FestivalSignTabCell.super.onExit(self);
end

function FestivalSignTabCell:init(data)
    self._data = data;
    self:onInitView();
end

function FestivalSignTabCell:onInitView()
    self._cellLayout = cc.Layer:create();
    self._cellLayout:setPosition(cc.p(0,0));
    self._cellLayout:setContentSize(cc.size(BTN_CELL_W+10, BTN_CELL_H));
    self:addChild(self._cellLayout);

    self:initCellData();
end

function FestivalSignTabCell:hightLight()
    self.titleTxt:setFontColor(UI.FONT_COLOR_218_211_154)
    self._bg:setSpriteName("ui_btn_gray2_1.png")
end

function FestivalSignTabCell:unHightLight()
    if(not self._select) then
        self.titleTxt:setFontColor(UI.FONT_COLOR_41_41_45)
        self._bg:setSpriteName("ui_btn_gray2_0.png")
    end
end

function FestivalSignTabCell:initCellData()
    self._bg = UI.Image:create()
    self._bg:init("ui_btn_gray2_0.png")
    self._bg:centerLeft(0)
    self._cellLayout:addChild(self._bg)

    local titleTxt = UI.Text:create()
    titleTxt:init(self._data.name, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleTxt:center()
    self.titleTxt = titleTxt
    self:updateCellShow(self._data.select)
    self._bg:addChild(titleTxt)

    local redPoint = AvalonUtil.createRedPoint(self._bg, 2, 2)
    self.redPoint = redPoint
    self:updateRed(self._data)
end

function FestivalSignTabCell:updateCellShow(select)
    self._select = select
    if select then
        self.titleTxt:setFontColor(UI.FONT_COLOR_218_211_154)
        self._bg:setSpriteName("ui_btn_gray2_1.png")
    else
        self.titleTxt:setFontColor(UI.FONT_COLOR_41_41_45)
        self._bg:setSpriteName("ui_btn_gray2_0.png")
    end
end

function FestivalSignTabCell:updateRedShow()
    self:updateRed(self._data)
end

function FestivalSignTabCell:updateRed(data)
    local goalID = data.goalIdx
    local stat1 = false
    -- print("FestivalSignTabCell:updateRed", data)
    if(goalID == SEVEN_DAY_GIFT) then 
        local stat2 = mvc.festivalSignModel:checkCanGetFinalReward(goalID)
        if stat1 or stat2 then
            self.redPoint:show()
        else
            self.redPoint:hide()
        end
    else
        if (data.isSignInGoal) then
            stat1 = mvc.festivalSignModel:getSignFinishStateForGoal(goalID)
        else
            stat1 = mvc.festivalSignModel:getFinishStat(goalID)
        end

        local stat2 = mvc.festivalSignModel:checkCanGetFinalReward(goalID)
        if stat1 or stat2 then
            self.redPoint:show()
        else
            self.redPoint:hide()
        end
    end
end
