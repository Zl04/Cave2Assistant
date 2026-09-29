-- DreamRankCell.lua
-- Author:lzm
-- 2019年2月26日
-- Using:梦境排行榜cell

local GameDataManager = require("app.game.GameDataManager");
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local DreamRankCell = class("DreamRankCell", UI.TableViewCell)
UI.DreamRankCell = DreamRankCell

local BG_BIG = "ui_activity_banner_no_found_big.png"
local BG_LITTLE = "ui_activity_banner_no_found_little.png"

local CELL_WIDTH = ACTIVITY_WIDTH;
local RANK_CELL_W = 695;
local RANK_CELL_H = 72;
local rankImgName = {"ui_rankinglist_gold.png", "ui_rankinglist_silver.png", "ui_rankinglist_copper.png"}

function DreamRankCell:ctor()

end

function DreamRankCell:onEnter()
    DreamRankCell.super.onEnter(self);
end

function DreamRankCell:onExit()
    DreamRankCell.super.onExit(self);
end

function DreamRankCell:init(data)
    self._data = data;
    self:onInitView();
end

function DreamRankCell:onInitView()
    self._rankCellLayout = cc.Layer:create();
    self._rankCellLayout:setPosition(cc.p(0,0));
    self._rankCellLayout:setContentSize(cc.size(RANK_CELL_W, RANK_CELL_H));
    self:addChild(self._rankCellLayout);

    self:initCellData();
end

function DreamRankCell:initCellData()
    local wArr = {90, 85, 190, 200, 130};
    local deltaXArr = {0, 90, 175, 365, 565};
    local layoutIndex = 1;
    local layoutArr = {};
    for k, v in ipairs(deltaXArr) do
        local range = UI.Layout:create();
        range:init();
        range:setSize(wArr[k], RANK_CELL_H);
        range:centerLeft(v);
        layoutArr[k] = range;
        self._rankCellLayout:addChild(range);
    end

    if self._data.rank == 0 then
        local rankNum = UI.Text:create();
        rankNum:init(UI.TEXT_1212289, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:center();
        layoutArr[layoutIndex]:addChild(rankNum);
    elseif self._data.rank > #rankImgName then
        local rankNum = UI.Text:create();
        rankNum:init(tostring(self._data.rank), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:center();
        layoutArr[layoutIndex]:addChild(rankNum);
    else
        local picRankNum = UI.Image:create()
        picRankNum:init(rankImgName[self._data.rank])
        picRankNum:center();
        picRankNum:setName("picRankNum")
        layoutArr[layoutIndex]:addChild(picRankNum);
    end

    layoutIndex = layoutIndex + 1;

    local headBg = UI.Image:create()
    headBg:init("ui_information_headframe_bottom.png")
    headBg:center();
    headBg:setName("headBg")
    headBg:setScale(0.8)
    layoutArr[layoutIndex]:addChild(headBg);

    local headCap = UI.Image:create()
    headCap:init("ui_information_headframe_box.png")
    headCap:center()
    headBg:addChild(headCap);
    self.headBg = headBg;

    self._data.rootLayer:getHead(self._data.sex, self._data.faceId, handler(self, self.refreshFace), self._data.rank-1)

    layoutIndex = layoutIndex + 1;

    local guildName = UI.Text:create();
    guildName:init(ToolsUtil:replaceShowNickNameStr(self._data.guildName), UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
    guildName:center();
    layoutArr[layoutIndex]:addChild(guildName);

    layoutIndex = layoutIndex + 1;

    local playerName = UI.Text:create();
    playerName:init(ToolsUtil:replaceShowNickNameStr(self._data.nickName or UI.TEXT_1170313), UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
    playerName:center();
    layoutArr[layoutIndex]:addChild(playerName);

    layoutIndex = layoutIndex + 1;

    local scroe = UI.Text:create();
    scroe:init(tostring(self._data.score), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45);
    scroe:center();
    layoutArr[layoutIndex]:addChild(scroe);

    layoutIndex = layoutIndex + 1;

    if not self._data.isSelf then
        local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        splitLine:setContentSize(695, 1)
        splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
        splitLine:setPosition(RANK_CELL_W/2, 1)
        self._rankCellLayout:addChild(splitLine)
    end
end

function DreamRankCell:refreshFace(pic, aceDecodeID)
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
