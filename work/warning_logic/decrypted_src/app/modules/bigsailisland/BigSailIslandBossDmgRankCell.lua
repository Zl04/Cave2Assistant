-- BigSailIslandBossDmgRankCell.lua
-- Author:siyu

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local BigSailIslandBossDmgRankCell = class("BigSailIslandBossDmgRankCell", UI.TableViewCell)

UI = UI or {}
UI.BigSailIslandBossDmgRankCell = BigSailIslandBossDmgRankCell

local COM_WIDTH = 576
local COM_HEIGHT = 90

local rankImgName = {"ui_rankinglist_gold.png", "ui_rankinglist_silver.png", "ui_rankinglist_copper.png"}

--构造函数(必备)
function BigSailIslandBossDmgRankCell:ctor()
    BigSailIslandBossDmgRankCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function BigSailIslandBossDmgRankCell:dtor()
    BigSailIslandBossDmgRankCell.super.dtor(self)
end

-- 初始化(必备)
function BigSailIslandBossDmgRankCell:init(data)
    if data then
        self._data = data
    end
end

-- 模版函数：初始化组建的视图(必备)
function BigSailIslandBossDmgRankCell:onInitView()
    self:onUpdateView()
end

function BigSailIslandBossDmgRankCell:onUpdateView()
    if not self._data then
        return
    end

    local cellLayout = cc.Layer:create();
    cellLayout:setPosition(cc.p(0,0));
    cellLayout:setContentSize(cc.size(COM_WIDTH, COM_HEIGHT));
    self:addChild(cellLayout);
    self._cellLayout = cellLayout


    self:initCellView()
end

function BigSailIslandBossDmgRankCell:getData()
    return self._data
end

function BigSailIslandBossDmgRankCell:cellClick()
end

function BigSailIslandBossDmgRankCell:hide()
end

function BigSailIslandBossDmgRankCell:isClickShowInfo()
    return true
end

function BigSailIslandBossDmgRankCell:clearSelect()
end


function BigSailIslandBossDmgRankCell:initCellView()
    local cellView = self:addCellView(self._data)
    self.cellView = cellView
    self._cellLayout:addChild(cellView)
end

function BigSailIslandBossDmgRankCell:addCellView(data)
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

    -- 头像
    local iconButton = UI.Button:create()
    iconButton:init("ui_information_headframe_bottom.png", "ui_information_headframe_bottom.png")
    iconButton:center(-80, -13)
    iconButton:setScale(0.8)
    iconButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:showHeroDetail()
    end)
    rankLayer:addChild(iconButton)
    self._iconButton = iconButton

    local heroData = Data.HeroData:create()
    heroData:setNickName("")
    heroData:setLevel(0)
    heroData:setSex(data.sex or PublicDefine.HERO_SEX.MALE)
    heroData:setFaceDecodeID(data.faceId)

    Avalon.WidgetUtil:getHead(self, heroData, {},self,handler(self,function(self,pic)
        if self._iconButton and not tolua.isnull(self._iconButton) then
            pic:setPosition(42, 35)
            pic:setScale(0.9)
            self._iconButton:addChild(pic, 2) 
        end
    end))

    --  昵称
    local presidentName = UI.Text:create()
    presidentName:init(tostring(data.rolename), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    presidentName:center(80, -13)
    presidentName:setTextLeftUp()
    rankLayer:addChild(presidentName)

    -- 累计伤害
    local totalNum = UI.Text:create()
    totalNum:init(tostring(data.totalOutput), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
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

function BigSailIslandBossDmgRankCell:onClickBtn()
    -- 这里应该获取 self._data.detailDes值， 目前策划还没配，暂时用 1010001
    --print("onClickBtn--->: ", self._data.pk)
end

function BigSailIslandBossDmgRankCell:showHeroDetail()
    if self._data.pk ~= RoleDataManager:getMasterPK() then
        Net.NetRoleSystem:heroDetailRequest(self._data.pk, 1,nil,nil,PublicDefine.RankType.RANKTYPE_BIGSAIL_BOSS_DAMAGE)
    end
end

