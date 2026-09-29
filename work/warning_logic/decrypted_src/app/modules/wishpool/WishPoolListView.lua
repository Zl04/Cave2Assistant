------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local WishPoolListView = class("WishPoolListView", UI.HWBtnComponent)

require "app.modules.wishpool.WishPoolListCell"
require("app.ui.common.RewardLayer")

local List = Avalon.List

-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_town_guild_wishpool.plist",
    "ui_town_mailbox.plist",
    "ui_common_information.plist",
    "ui_gaming_playerstate.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 590
local ZOrder = 1

function WishPoolListView:ctor()
    WishPoolListView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.renderQueue = List:create();
    self.rankRefreshTime = tonumber(ConfigManager:getGeneralForKey("rankRefresh"))/1000;

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_LIST, self, self.updateWishList)

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function WishPoolListView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.wishpool", "WishPool", false)
    WishPoolListView.super.init(self, ... )
end

function WishPoolListView:dtor()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    self.renderQueue:destroy()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_LIST, self, self.updateWishList)

    WishPoolListView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.wishpool.WishPoolListView")
end

function WishPoolListView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:centerUp(24)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- self.contentLayout:enableDebugDraw()

    -- 背景图片
    local bg1 = UI.Image:create();
    bg1:init("ui_bg_box2.png");
    bg1:center();
    contentLayout:addChild(bg1, ZOrder);
    ZOrder = ZOrder + 1;

    -- 背景图片
    local bg2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    bg2:setContentSize(852, 534)
    bg2:setCapInsets(CCRectMake(304, 141, 1, 1))
    bg2:setPosition(cc.p(COM_WIDTH / 2 + 2, COM_HEIGHT / 2 - 8))
    contentLayout:addChild(bg2, ZOrder);
    ZOrder = ZOrder + 1;

    -- 标题图片
    local titleBG = UI.Image:create();
    titleBG:init("ui_bg_banner_box_up.png");
    titleBG:centerUp(-42);
    contentLayout:addChild(titleBG, ZOrder);
    ZOrder = ZOrder + 1;

    -- 标题图片1
    local titleBG1 = UI.Image:create();
    titleBG1:init("ui_bg_shield.png");
    titleBG1:centerUp(-46);
    contentLayout:addChild(titleBG1, 0);
    
    -- 标题图片4
    local titleBG4 = UI.Image:create();
    titleBG4:init("ui_bg_fence.png");
    titleBG4:centerUp(4);
    titleBG1:addChild(titleBG4);

    -- 标题图片2
    local titleBG2 = UI.Image:create();
    titleBG2:init("ui_bg_flag_left.png");
    titleBG2:centerLeft(-176);
    titleBG1:addChild(titleBG2);
    -- titleBG2:enableDebugDraw()

    -- 标题图片3
    local titleBG3 = UI.Image:create();
    titleBG3:init("ui_bg_flag_right.png");
    titleBG3:centerRight(-172);
    titleBG1:addChild(titleBG3);
    -- titleBG3:enableDebugDraw()

    -- 上分割线
    local line1 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    line1:setContentSize(822, 2)
    line1:setCapInsets(CCRectMake(20, 1, 1, 1))
    line1:setPosition(cc.p(COM_WIDTH / 2 - 30, COM_HEIGHT / 2 + 204))
    bg2:addChild(line1);

    -- 下分割线
    local line2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    line2:setContentSize(822, 2)
    line2:setCapInsets(CCRectMake(20, 1, 1, 1))
    line2:setPosition(cc.p(COM_WIDTH / 2 - 30, COM_HEIGHT / 2 - 264))
    bg2:addChild(line2);

    self:initList()

    -- 阴影
    local shadow = UI.Image:create();
    shadow:init("ui_guild_wishingpond_gradually.png");
    shadow:leftBottom(50, 52);
    self.contentLayout:addChild(shadow, 100)
end

function WishPoolListView:initList()
    local scrollContent = UI.Layout:create()
    scrollContent:init()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(840, 466)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:leftUp(54, 72)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarWidth(5)
    scrollView:setScrollBarColor(UI.BLACK)
    scrollView:setCircleVisible(false)
    scrollView:setName("WishList")
    -- scrollView:enableDebugDraw()
    self.contentLayout:addChild(scrollView, ZOrder)
    self.svList = scrollView

    scrollView:addInnerNode(scrollContent)
    -- scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_BEGAN, self, self.onScrollViewScrollBeginCallback)
    -- scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLLING, self, self.onScrollViewScrollingCallback)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self, self.onScrollViewScrollEndCallback)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_AUTOSCROLL_ENDED, self, self.onScrollViewScrollEndCallback)

    local wishList = mvc.wishPoolModel:getWishList().list
    local totalH = 4
    local beginOffset = 0
    local cellH = 92
    for k, v in ipairs(wishList) do
        local cell = UI.WishPoolListCell.create()
        cell:init(k, v, self)
        cell:leftUp(0, beginOffset)
        scrollContent:addChild(cell)
        cell:setTouchClipNode(scrollView)
        beginOffset = beginOffset+cellH
        totalH = totalH+cellH
    end

    scrollContent:setSize(820, totalH)
end

function WishPoolListView:onScrollViewScrollEndCallback()
    local wishList = mvc.wishPoolModel:getWishList()
    if #wishList.list >= wishList.max then
        return
    end

    Net.NetGuildSystem:reqGuildWishList(#wishList.list)
end

-- 每帧截屏3个
function WishPoolListView:update(dt)
    local limite = 3
    local size = self.renderQueue:size()
    size = size > limite and limite or size
    if size > 0 then
        for i = 1, size do
            local renderCMD = self.renderQueue:pop_front();
            if renderCMD then 
                renderCMD.execute()
            end
        end
    end

    self.rankRefreshTime = self.rankRefreshTime - dt;
end

--获取头像
function WishPoolListView:getHead(sex, faceDecodeID, callfunc, idx)
    local heroData = Data.HeroData:create()
    heroData:setNickName("")
    heroData:setLevel(0)
    heroData:setSex(sex or PublicDefine.HERO_SEX.MALE)
    heroData:setFaceDecodeID(faceDecodeID)

    local command = {
        execute = function ( ... )
            self:exportHead(heroData, callfunc);
        end,
        isExecute = false,
        idx = idx,
    }
    self.renderQueue:push_back(command)
end

function WishPoolListView:exportHead(headData, callfunc)
    Avalon.WidgetUtil:getHead(self, headData ,{}, self, handler(self,function(self,pic)
        if self and not tolua.isnull(self) then
            callfunc(pic, headData.faceDecodeID)
        end
    end),true)
end

function WishPoolListView:updateWishList()
    local wishList = self.contentLayout:getChildByName("WishList")
    if wishList then
        self.contentLayout:removeChildByName("WishList")
    end

    self:initList()
end

function WishPoolListView:bindModel()

end

function WishPoolListView:unbindModel()

end

return WishPoolListView
