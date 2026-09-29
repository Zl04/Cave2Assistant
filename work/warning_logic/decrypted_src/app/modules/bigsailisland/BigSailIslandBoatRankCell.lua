-- BigSailIslandBoatRankCell.lua
-- Author:siyu

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local BigSailIslandBoatRankCell = class("BigSailIslandBoatRankCell", UI.TableViewCell)

UI = UI or {}
UI.BigSailIslandBoatRankCell = BigSailIslandBoatRankCell

local COM_WIDTH = 576
local COM_HEIGHT = 90

local rankImgName = {"ui_rankinglist_gold.png", "ui_rankinglist_silver.png", "ui_rankinglist_copper.png"}

--构造函数(必备)
function BigSailIslandBoatRankCell:ctor()
    BigSailIslandBoatRankCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function BigSailIslandBoatRankCell:dtor()
    BigSailIslandBoatRankCell.super.dtor(self)
end

-- 初始化(必备)
function BigSailIslandBoatRankCell:init(data)
    if data then
        self._data = data
    end
end

-- 模版函数：初始化组建的视图(必备)
function BigSailIslandBoatRankCell:onInitView()
    self:onUpdateView()
end

function BigSailIslandBoatRankCell:onUpdateView()
    --print("BigSailIslandBoatRankCell --->: ", self._data)
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

function BigSailIslandBoatRankCell:getData()
    return self._data
end

function BigSailIslandBoatRankCell:cellClick()
end

function BigSailIslandBoatRankCell:hide()
end

function BigSailIslandBoatRankCell:isClickShowInfo()
    return true
end

function BigSailIslandBoatRankCell:clearSelect()
end


function BigSailIslandBoatRankCell:updateSkillList()
    local oneSkill = self:addOneSkill(self._data)
    self.oneSkill = oneSkill
    self._cellLayout:addChild(oneSkill)
end

function BigSailIslandBoatRankCell:addOneSkill(data)
    local rankLayer = UI.Layout:create()
    rankLayer:init()
    rankLayer:setSize(COM_WIDTH, COM_HEIGHT)
    --skillLayer:leftUp(data.x, data.y)
    rankLayer:center()

    -- local rankBG = UI.Image:create()
    -- rankBG:init("ui_greatnavigation_list.png")
    -- rankBG:center()
    -- rankLayer:addChild(rankBG)

    -- 排名
    if data.selfRank == 0 then
        local rankNum = UI.Text:create();
        rankNum:init(UI.TEXT_1212289, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:center(-240, -13);
        rankLayer:addChild(rankNum);
    elseif data.selfRank > #rankImgName then
        local rankNum = UI.Text:create();
        rankNum:init(tostring(data.selfRank), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:center(-240, -13);
        rankLayer:addChild(rankNum);
    else
        local picRankNum = UI.Image:create()
        picRankNum:init(rankImgName[data.selfRank])
        picRankNum:center(-240, -13);
        picRankNum:setName("picRankNum")
        rankLayer:addChild(picRankNum);
    end

    -- 公会图标
    local iconName = GameDataManager:getInstance():getGuildIconForIconID(data.iconID)
    local guildIcon = UI.Image:create()
    guildIcon:init(iconName)
    guildIcon:center(-80, -13)
    rankLayer:addChild(guildIcon)

    -- 公会名字
    local presidentName = UI.Text:create()
    presidentName:init(tostring(data.rolename), UI.SYS_FONT, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    presidentName:center(80, -13)
    presidentName:setTextLeftUp()
    rankLayer:addChild(presidentName)

    -- 公会/会长名字
    -- local guildPic = UI.Image:create()
    -- guildPic:init("ui_greatnavigation_line.png")
    -- guildPic:center(-75, 0)
    -- rankLayer:addChild(guildPic)

    -- local presidentName = UI.Text:create()
    -- presidentName:init(tostring(data.rolename), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 59, g = 57, b = 59})
    -- presidentName:center(-64, -16)
    -- presidentName:setTextLeftUp()
    -- rankLayer:addChild(presidentName)

    -- -- 科技总等级
    -- local technologyLevelTxt = UI.Text:create()
    -- technologyLevelTxt:init(tostring(data.techLevel), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 59, g = 57, b = 59})
    -- technologyLevelTxt:center(-64, -16)
    -- technologyLevelTxt:setTextLeftUp()
    -- rankLayer:addChild(technologyLevelTxt)

    -- -- 公会人数
    -- local guildPersonNum = UI.Text:create()
    -- guildPersonNum:init(tostring(data.personNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 59, g = 57, b = 59})
    -- guildPersonNum:center(-64, 16)
    -- guildPersonNum:setTextLeftUp()
    -- rankLayer:addChild(guildPersonNum)

    -- 总产量
    local totalNum = UI.Text:create()
    totalNum:init(tostring(data.totalOutput), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
    totalNum:center(230, -13)
    totalNum:setTextLeftUp()
    rankLayer:addChild(totalNum)

    -- 分割线
    local iconSplite = UI.Image:create()
    iconSplite:init("ui_greatnavigation_line_3.png")
    iconSplite:center(0, 30)
    rankLayer:addChild(iconSplite)

    return rankLayer
end

function BigSailIslandBoatRankCell:onClickBtn()
    -- 这里应该获取 self._data.detailDes值， 目前策划还没配，暂时用 1010001
    --print("onClickBtn--->: ", self._data.pk)
end