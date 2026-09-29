-- DreamRankTipLayer.lua
-- Author:lzm
-- 2019年2月27日
-- Using:梦境排行榜规则说明

local winSize = cc.Director:getInstance():getWinSize();

UI = UI or {};

local DreamRankTipLayer = class("DreamRankTipLayer", UI.CenterWin);
UI.DreamRankTipLayer = DreamRankTipLayer;

local DEBUG = true;
local VIEW_WIDTH = 470;
local VIEW_HEIGHT = 430;
local BG_NAME1 = "ui_scale9image_banner_bg.png";
local BG_NAME2 = "ui_dreamword_task_bg.png";


-- 资源文件
local COM_RES_LIST = {

}

function DreamRankTipLayer:ctor()
    DreamRankTipLayer.super.ctor(self, UIType.DREAM_RANK_TIP_LAYER, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT);
end

function DreamRankTipLayer:dtor()
    DreamRankTipLayer.super.dtor(self);
end

function DreamRankTipLayer:init()
    DreamRankTipLayer.super.init(self)

    self:setInterceptTouches(true)
    self:setTouchEnable(true)
end

function DreamRankTipLayer:onInitView()
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(VIEW_WIDTH, VIEW_HEIGHT);
    self:addChild(contentLayout);

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName(BG_NAME1);
    bgImage:setContentSize(650, 650);
    bgImage:setCapInsets(CCRectMake(120, 107, 162, 162))
    bgImage:setAnchorPoint(cc.p(0.5, 0.5))
    bgImage:setPosition(cc.p(240, 210))
    contentLayout:addChild(bgImage)

    local bg = UI.Image:create();
    bg:init(BG_NAME2);
    bg:center();
    contentLayout:addChild(bg);

    local titleText1 = UI.Text:create();
    titleText1:init(UI.TEXT_1212296, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
    titleText1:centerUp(40);
    contentLayout:addChild(titleText1);

    local contentText1 = UI.Text:create();
    contentText1:init(UI.TEXT_1212297, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
    contentText1:setWidth(386);
    contentText1:centerUp(70);
    contentText1:setLineSpacing(-4);
    contentText1:autoAdapt()
    contentLayout:addChild(contentText1);

    local titleText2 = UI.Text:create();
    titleText2:init(UI.TEXT_1212298, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
    titleText2:centerUp(160);
    contentLayout:addChild(titleText2);

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(394, 1)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(VIEW_WIDTH/2, 240)
    contentLayout:addChild(splitLine)

    local contentText2 = UI.Text:create();
    contentText2:init(UI.TEXT_1212299, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
    contentText2:setWidth(386);
    contentText2:centerUp(195);
    contentText2:setLineSpacing(-4);
    contentText2:autoAdapt()
    contentLayout:addChild(contentText2);

    -- local scrollView = UI.ScrollView:create()
    -- scrollView:init()
    -- scrollView:center()
    -- scrollView:setSize(415, 360);
    -- scrollView:setBounceEnabled(true);
    -- scrollView:setScrollBarEnabled(false);
    -- scrollView:addInnerNode(svContent);
    -- self:addChild(scrollView, 1)
end

function DreamRankTipLayer:openShow()
    self:open();
end
