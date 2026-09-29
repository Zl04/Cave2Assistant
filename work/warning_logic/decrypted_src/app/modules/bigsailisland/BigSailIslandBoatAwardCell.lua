-- BigSailIslandBoatAwardCell.lua
-- Author:siyu

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local BigSailIslandBoatAwardCell = class("BigSailIslandBoatAwardCell", UI.TableViewCell)

UI = UI or {}
UI.BigSailIslandBoatAwardCell = BigSailIslandBoatAwardCell

local COM_WIDTH = 576
local COM_HEIGHT = 90

local rankImgName = {"ui_rankinglist_gold.png", "ui_rankinglist_silver.png", "ui_rankinglist_copper.png"}

--构造函数(必备)
function BigSailIslandBoatAwardCell:ctor()
    BigSailIslandBoatAwardCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function BigSailIslandBoatAwardCell:dtor()
    BigSailIslandBoatAwardCell.super.dtor(self)
end

-- 初始化(必备)
function BigSailIslandBoatAwardCell:init(data)
    if data then
        self._data = data
    end
end

-- 模版函数：初始化组建的视图(必备)
function BigSailIslandBoatAwardCell:onInitView()
    self:onUpdateView()
end

function BigSailIslandBoatAwardCell:onUpdateView()
    --print("BigSailIslandBoatAwardCell --->: ", self._data)
    if not self._data then
        return
    end

    local cellLayout = cc.Layer:create();
    cellLayout:setPosition(cc.p(0,0));
    cellLayout:setContentSize(cc.size(COM_WIDTH, COM_HEIGHT));
    self:addChild(cellLayout);
    self._cellLayout = cellLayout


    -- local cellLayout = UI.Layout:create()
    -- cellLayout:init()
    -- cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    -- cellLayout:center()
    -- self._cellLayout = cellLayout
    --self:addChild(cellLayout)

    self:updateSkillList()
end

function BigSailIslandBoatAwardCell:getData()
    return self._data
end

function BigSailIslandBoatAwardCell:cellClick()
end

function BigSailIslandBoatAwardCell:hide()
end

function BigSailIslandBoatAwardCell:isClickShowInfo()
    return true
end

function BigSailIslandBoatAwardCell:clearSelect()
end


function BigSailIslandBoatAwardCell:updateSkillList()
    local oneSkill = self:addOneSkill(self._data)
    self.oneSkill = oneSkill
    self._cellLayout:addChild(oneSkill)
end

function BigSailIslandBoatAwardCell:addOneSkill(data)
    local rankLayer = UI.Layout:create()
    rankLayer:init()
    rankLayer:setSize(COM_WIDTH, COM_HEIGHT)
    --skillLayer:leftUp(data.x, data.y)
    rankLayer:center(0,10)

    -- local rankBG = UI.Image:create()
    -- rankBG:init("ui_greatnavigation_list.png")
    -- rankBG:center()
    -- rankLayer:addChild(rankBG)

    local limit = data.limt
    local resultLit = string.split(limit, ",")
    local leftRank = tonumber(resultLit[1])
    local rightRank = tonumber(resultLit[2])

    -- 排名
    if leftRank == 0 then
        local rankNum = UI.Text:create();
        rankNum:init(UI.TEXT_1212289, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:center(-240, -13);
        rankLayer:addChild(rankNum);
    elseif rightRank > leftRank and leftRank > 3 then
        local rankNum = UI.Text:create();
        rankNum:init(tostring(leftRank).."-"..tostring(rightRank), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:center(-240, -13);
        rankLayer:addChild(rankNum);
    else
        local picRankNum = UI.Image:create()
        picRankNum:init(rankImgName[leftRank])
        picRankNum:center(-240, -13);
        picRankNum:setName("picRankNum")
        rankLayer:addChild(picRankNum);
    end

    local items = string.split(data.itemId, ",")
    local itemNums = string.split(data.itemNum, ",")
    for k,v in pairs(items) do
        local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(v))
        local goodsGrid = UI.GoodsGrid:create()
        goodsData:setNum(tonumber(itemNums[k]))
        goodsData:setIsNew(false)
        goodsGrid:init(goodsData)
        goodsGrid:center(-120 + k * 80, -13)
        goodsGrid:showInfoArea(false, false)
        rankLayer:addChild(goodsGrid, 1)
    end
    -- -- 奖励图标
    -- local iconName = GameDataManager:getInstance():getGuildIconForIconID(data.iconID)
    -- local guildIcon = UI.Image:create()
    -- guildIcon:init(iconName)
    -- guildIcon:center(-80, -13)
    -- rankLayer:addChild(guildIcon)


    -- 分割线
    local iconSplite = UI.Image:create()
    iconSplite:init("ui_greatnavigation_line_3.png")
    iconSplite:center(0, 30)
    rankLayer:addChild(iconSplite)

    return rankLayer
end

function BigSailIslandBoatAwardCell:onClickBtn()
    -- 这里应该获取 self._data.detailDes值， 目前策划还没配，暂时用 1010001
    --print("onClickBtn--->: ", self._data.pk)
end