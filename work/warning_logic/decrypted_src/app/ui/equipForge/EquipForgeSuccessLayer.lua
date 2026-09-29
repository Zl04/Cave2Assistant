-- EquipForgeSuccessLayer.lua
-- Author:lzm
-- 2019年3月21日
-- Using:梦境排行榜规则说明

local winSize = cc.Director:getInstance():getWinSize();

UI = UI or {};

local EquipForgeSuccessLayer = class("EquipForgeSuccessLayer", UI.CenterWin);
UI.EquipForgeSuccessLayer = EquipForgeSuccessLayer;

local DEBUG = true;
local VIEW_WIDTH = 538;
local VIEW_HEIGHT = 372;
local BG_NAME1 = "ui_scale9image_banner_bg.png";
local BG_NAME2 = "ui_dreamword_task_bg.png";


-- 资源文件
local COM_RES_LIST = {

}

function EquipForgeSuccessLayer:ctor()
    EquipForgeSuccessLayer.super.ctor(self, UIType.EQUIP_FORGE_SUC_LAYER, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT);
end

function EquipForgeSuccessLayer:dtor()
    EquipForgeSuccessLayer.super.dtor(self);
end

function EquipForgeSuccessLayer:init(id)
    self._data = id

    EquipForgeSuccessLayer.super.init(self)

    self:setInterceptTouches(true)
    self:setTouchEnable(true)
end

function EquipForgeSuccessLayer:onInitView()
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(VIEW_WIDTH, VIEW_HEIGHT);
    self:addChild(contentLayout);

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    contentLayout:addChild(mask)

    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box2.png")
    bg:center()
    contentLayout:addChild(bg)

    local title = UI.Text:create();
    title:init(UI.TEXT_1212364, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
    title:centerUp(21);
    contentLayout:addChild(title);

    local splitLin1 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    splitLin1:setContentSize(425, 1)
    splitLin1:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLin1:setPosition(VIEW_WIDTH/2, 315)
    bg:addChild(splitLin1)

    -- 独有背景
    local bg1 = UI.Image:create()
    bg1:init("ui_blacksmith_forging_dwon2.png")
    bg1:centerUp(70)
    bg:addChild(bg1)

    local goodsGrid = UI.GoodsGrid:create()
    -- goodsGrid:setScale(0.85)
    goodsGrid:setTouchClipNode(contentLayout)
    goodsGrid:center()
    local goodsData = GoodsDataManager:getEquipmentForEntityID(self._data);
    goodsData:setIsNew(false)
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    bg1:addChild(goodsGrid)

    local splitLine2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    splitLine2:setContentSize(425, 1)
    splitLine2:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine2:setPosition(VIEW_WIDTH/2, 90)
    bg:addChild(splitLine2)

    -- 按钮
    local btn = UI.Button:create();
    btn:init("ui_btn_yellow2_0.png","ui_btn_yellow2_1.png","ui_btn_yellow2_2.png");
    btn:centerBottom(34);
    btn:setText(UI.TEXT_1170211)
    btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    btn:closeClickScale()
    bg:addChild(btn)
    btn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:closeWin();
    end)
end

function EquipForgeSuccessLayer:openShow()
    self:open();
end
