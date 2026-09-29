-- WorldBossRoomCell.lua
-- Author:lzm
-- 2019年2月28日
-- Using:梦境商店cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local WorldBossRoomCell = class("WorldBossRoomCell", UI.ListGrid)
UI.WorldBossRoomCell = WorldBossRoomCell

local COM_WIDTH = 168
local COM_HEIGHT = 180

--构造函数(必备)
function WorldBossRoomCell:ctor()
    WorldBossRoomCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function WorldBossRoomCell:dtor()
    WorldBossRoomCell.super.dtor(self)
end

-- 初始化(必备)
function WorldBossRoomCell:init(data)
    self._data = data
    WorldBossRoomCell.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function WorldBossRoomCell:onInitView()
end

function WorldBossRoomCell:getData()
    return self._data;
end

function WorldBossRoomCell:isClickShowInfo()
    return true
end

function WorldBossRoomCell:onUpdateView(data)
    if not self._data then
        return
    end

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self:addChild(cellLayout)

    if self._data.isSelf then
        -- 自己的背景
        local bgMe = UI.Image:create()
        bgMe:init("ui_boss_paper_me.png")
        bgMe:center()
        cellLayout:addChild(bgMe)
    else
        -- 背景
        local bg = UI.Image:create()
        bg:init("ui_boss_paper.png")
        bg:center()
        cellLayout:addChild(bg)
    end

    local upLayout = UI.Layout:create()
    upLayout:init()
    upLayout:setSize(COM_WIDTH, 130)
    upLayout:centerUp(6)
    cellLayout:addChild(upLayout)

    -- 玩家头像
    local headBg = UI.Image:create()
    headBg:init("ui_information_headframe_bottom.png")
    headBg:centerUp(16);
    headBg:setName("headBg")
    -- headBg:setScale(0.8)
    upLayout:addChild(headBg)
    self.headBg = headBg;

    local headCap = UI.Image:create()
    headCap:init("ui_information_headframe_box.png")
    headCap:center()
    headBg:addChild(headCap, 1)

    self._data.rootLayer:getHead(self._data.sex, self._data.faceId, handler(self, self.refreshFace), self._data.idx)

    local lvBg = UI.Image:create()
    lvBg:init("ui_information_headframe_grade.png")
    lvBg:leftBottom(-8, -8)
    headBg:addChild(lvBg, 10)

    local lvTxtShadow = UI.Text:create()
    lvTxtShadow:init(tostring(self._data.lv), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_45_42)
    lvTxtShadow:setSize(100, 50)
    lvTxtShadow:centerLeft(-35)
    lvTxtShadow:setTextCenter()
    lvBg:addChild(lvTxtShadow)

    local lvTxt = UI.Text:create()
    lvTxt:init(tostring(self._data.lv), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_189_167_136)
    lvTxt:setSize(100, 50)
    lvTxt:centerLeft(-36)
    lvTxt:setTextCenter()
    lvBg:addChild(lvTxt)

    local nameTxt = UI.Text:create()
    nameTxt:init(self._data.nickName, UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    nameTxt:centerBottom(8)
    upLayout:addChild(nameTxt)

    local downLayout = UI.Layout:create()
    downLayout:init()
    downLayout:centerBottom(6)
    cellLayout:addChild(downLayout)

    local star = UI.Image:create()
    star:init("symbol_character_hero_power.png")
    star:floatLeft(0)
    downLayout:addComponent(star)

    local numTxt = UI.Text:create()
    numTxt:init(tostring(self._data.power), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    numTxt:floatLeft(2)
    downLayout:addComponent(numTxt)

    local w1 = star:getSize()
    local w2 = numTxt:getSize()
    downLayout:setSize(w1+w2+2, 36)

    local select = UI.Image:create()
    select:init("ui_boss_paper_click.png")
    select:center()
    select:hide()
    cellLayout:addChild(select)
    self.select = select
end

function WorldBossRoomCell:refreshFace(pic, aceDecodeID)
    if tolua.isnull(self.headBg) then
        return
    end

    if self.headBg and self.headBg:getChildByName("heorIcon") then
        self.headBg:removeChildByName("heorIcon", true)
    end
    pic:setPosition(self.headBg:getContentSize().width / 2, self.headBg:getContentSize().height / 2)
    pic:setName("heorIcon")
    self.headBg:addChild(pic, 5)
    self.headBg:show()
end

function WorldBossRoomCell:cellClick()
    self.select:show()

    if self._data.isSelf then
        return
    end

    if self._data.userID == 0 then
        UI.ScrollBar:createByText(UI.TEXT_1170603)
    else
        GameManager:heroDetailRequest(self._data.pk, self._data.userID)
    end
end

function WorldBossRoomCell:clearSelect()
    self.select:hide()
end
