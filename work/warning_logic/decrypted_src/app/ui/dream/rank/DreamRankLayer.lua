-- DreamRankLayer.lua
-- Author:lzm
-- 2019年2月26日
-- Using:梦境排行榜

require("app.ui.dream.rank.DreamRankTipLayer")
require("app.ui.dream.rank.DreamRankCell")
require "app.ui.common.Tab.SpineTabItem"

local winSize = cc.Director:getInstance():getWinSize();

local GameDataManager = require("app.game.GameDataManager");
local LanguageManager = require("app.game.LanguageManager");
local SceneManager = require("app.game.SceneManager");

UI = UI or {};

local DreamRankLayer = class("DreamRankLayer", UI.DownShowWin);
UI.DreamRankLayer = DreamRankLayer;

local List = Avalon.List

local DEBUG = false;
local VIEW_WIDTH = 1000;
local VIEW_HEIGHT = 580;

local RANK_CELL_W = 695;
local RANK_CELL_H = 72;

local BG_NAME1 = "ui_dreamword_bg_2.png";
local BG_NAME2 = "ui_dreamword_paper_1.png";
-- 关闭按钮
local MENU_CLOSE_SPINE_BG_NAME = "effect_ui_package_title_back_bg"
local MENU_CLOSE_SPINE_ICON_NAME = "effect_ui_package_title_back_icon"

local ZOrder = 1;

-- 资源文件
local COM_RES_LIST = {
    "ui_common_scale9image.plist",
    "ui_town_dream_btn.plist",
    "ui_town_dream_common.plist",
    "ui_town_dream_rank.plist",
    "ui_town_ranking.plist",
    "ui_town_activity.plist"
}

function DreamRankLayer:ctor()
    DreamRankLayer.super.ctor(self, UIType.DREAM_RANK_LAYER, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT);

    self:registerListener();

    self.initOver = false;
    self.rankList = {};
    self.tabIndex = 2;  -- 默认显示本周
    self.btnArr = {};
    self.renderQueue = List:create();
    self.rankRefreshTime = tonumber(ConfigManager:getGeneralForKey("rankRefresh"))/1000;

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function DreamRankLayer:dtor()
    DreamRankLayer.super.dtor(self);

    self:unRegisterListener();

    self.initOver = false;
    self.rankList = {};
    self.tabIndex = 2;
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    self.renderQueue:destroy()
end

function DreamRankLayer:init()
    DreamRankLayer.super.init(self)

    self:setInterceptTouches(true)
    self:setTouchEnable(true)
end

function DreamRankLayer:initCurWeekRank(rankData)
    self.curWeekRankList = {};
    local len = #rankData.rankList;
    for i = 1, len do
        local rankInfo = {};
        rankInfo.pk = rankData.rankList[i].pk;
        rankInfo.rank = rankData.rankList[i].rank;
        rankInfo.sex = rankData.rankList[i].sex;
        rankInfo.faceId = rankData.rankList[i].faceId;
        rankInfo.guildName = rankData.rankList[i].guildName;
        rankInfo.nickName = ToolsUtil:replaceShowNickNameStr(rankData.rankList[i].nickName)
        rankInfo.score = rankData.rankList[i].score;
        rankInfo.rootLayer = self;
        rankInfo.isSelf = false;
        self.curWeekRankList[i] = rankInfo;
    end

    self.rankList = self.curWeekRankList;
end

function DreamRankLayer:refreshCurWeekRank(rankData)
    self._data = rankData;

    -- 自己的累积梦境碎片值修正
    if self._data.selfScore == 0 then
        -- 如果 selfScore 为0,有可能表示自己没有上榜，所以需要再取一次自己属性里面的数值
        self._data.selfScore = RoleDataManager:getMaster().weeklyDreamChip
    end

    self:initCurWeekRank(rankData);

    if not self.initOver then
        self.initOver = true;
        self:initRankList(self.bg2);
        self:initMyRank(self.bg2);
    else
        self._tableView:reloadData(true, true);
    end
end

function DreamRankLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(VIEW_WIDTH, VIEW_HEIGHT);
    contentLayout:center();
    self:addChild(contentLayout);
    self.contentLayout = contentLayout;

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init(BG_NAME1);
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;
    -- bg:enableDebugDraw()

    -- 显示内容背景
    local bg2 = UI.Image:create();
    bg2:init(BG_NAME2);
    bg2:leftUp(91, 82);
    bg:addChild(bg2);
    self.bg2 = bg2;
    -- bg2:enableDebugDraw()

    -- title文字
    local titleText = UI.Text:create();
    titleText:init(UI.TEXT_110047, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_244_172_246);
    titleText:leftUp(442, 38);
    bg:addChild(titleText);

    self:initBtns(bg);
    self:updateTabBtnShow();
    self:initUIEffect(bg);
    self:initTitles(bg2);

    Net.NetRankSystem:requestRankList(PublicDefine.RankType.RankType_Dream)
end

function DreamRankLayer:initBtns(rootNode)
    local btnNameArr = {UI.TEXT_1212290, UI.TEXT_1212291};
    local distance = {{40, 120}, {40, 187}, {80, 350}};

    for k, v in ipairs(btnNameArr) do
        local btn = UI.Button:create();
        btn:init("ui_dreamword_rankinglist_btn_0.png","ui_dreamword_rankinglist_btn_1.png","ui_dreamword_rankinglist_btn_2.png");
        btn:rightUp(distance[k][1], distance[k][2]);
        btn.tag = k
        btn:closeClickScale()

        local btnText = UI.Text:create();
        btnText:init(v, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
        btnText:setWidth(80);
        btnText:center();
        btnText:setLineSpacing(-4);
        btnText:setTextCenter()
        btnText:autoAdapt()
        btn:addChild(btnText, 10);

        -- 设置普通标签图标
        local normal = UI.Image:create()
        normal:init("ui_dreamword_rankinglist_btn_0.png")
        normal:centerLeft(0)
        btn:setNormalNode(normal, 2)

        -- 设置激活标签图标
        local active = UI.Image:create()
        active:init("ui_dreamword_rankinglist_btn_1.png")
        active:centerLeft(5)
        btn:setSelectedNode(active, 2)

        -- 设置未激活标签图标
        local disable = UI.Image:create()
        disable:init("ui_dreamword_rankinglist_btn_2.png")
        disable:centerLeft(0)
        btn:setDisabledNode(disable, 2)

        rootNode:addChild(btn);
        self.btnArr[k] = btn;

        btn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
            if not self._data then
                printError("[ERROR] self._data is invalid.")
                return
            end

            local btnText = btn:getText();
            if btn.tag == 1 then
                if self.tabIndex == 1 then
                    self:updateTabBtnShow();
                    return
                end

                self.tabIndex = 1;

                self:updateTabBtnShow();

                if self and not tolua.isnull(self) and self.myRankLayout then
                    self.myRankLayout:hide();
                end

                local rankData = MasterDataManager:getPreRankDataArr();
                self.rankList = {};
                for k, v in ipairs(rankData) do
                    local rankInfo = {};
                    rankInfo.pk = v.pk;
                    rankInfo.rank = v.rank;
                    rankInfo.sex = v.sex;
                    rankInfo.faceId = v.faceId;
                    rankInfo.guildName = ToolsUtil:replaceShowNickNameStr(v.guildName)
                    rankInfo.nickName = ToolsUtil:replaceShowNickNameStr(v.nickName)
                    rankInfo.score = v.score;
                    rankInfo.rootLayer = self;
                    rankInfo.isSelf = false;

                    self.rankList[k] = rankInfo;
                end

                self._tableView:reloadData(true, false);
                self._tableView:show();
            elseif btn.tag == 2 then
                if self.tabIndex == 2 then
                    self:updateTabBtnShow();
                    return
                end

                self.tabIndex = 2;
                
                self:updateTabBtnShow()

                if self and not tolua.isnull(self) and self.myRankLayout then
                    self.myRankLayout:show();
                end

                if self.rankRefreshTime < 0 then
                    self.rankRefreshTime = tonumber(ConfigManager:getGeneralForKey("rankRefresh"))/1000;

                    Net.NetRankSystem:requestRankList(PublicDefine.RankType.RankType_Dream);
                else
                    self.rankList = self.curWeekRankList;
                    self._tableView:reloadData(true, false);
                end
            end
        end)
    end

    -- 关闭按钮
    local closeButton = UI.SpineTabItem:create()
    closeButton:init(
        MENU_CLOSE_SPINE_BG_NAME, 
        MENU_CLOSE_SPINE_ICON_NAME,
        nil,
        nil
    )
    closeButton:setSize(120, 52)
    closeButton:addEventListener(UIEvent.TAB_CLICK, self, function(self)
        self:closeWin()
    end)
    closeButton:rightUp(70, 7)
    closeButton:onActive()
    closeButton:setSingle(true)
    rootNode:addChild(closeButton, -1)

    -- tips按钮
    local tipBtn = UI.Button:create() 
    tipBtn:init()
    tipBtn:setSize(50,50)
    tipBtn:rightBottom(70, 185)
    rootNode:addChild(tipBtn, 2)
    tipBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        local tipLayer = UI.DreamRankTipLayer:create()
        tipLayer:center();
        tipLayer:init()
        tipLayer:setName("DreamRankTipLayer")
        self.contentLayout:addChild(tipLayer, UI_ZORDER.ACTIVITY);
        tipLayer:openShow();
        tipLayer:setGoBackWin(self);
    end)

    local tipAnimation = UI.Animation:create()
    tipAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    tipAnimation:setAnimation("idle", true)
    tipAnimation:center()
    tipBtn:addChild(tipAnimation, 10)
end

function DreamRankLayer:updateTabBtnShow()
    for k, v in ipairs(self.btnArr) do
        if k == self.tabIndex then
            v:press(false)
        else
            v:release()
        end
    end
end

function DreamRankLayer:initUIEffect(rootNode)
    local flag = UI.Animation:create()
    flag:init("effect_ui_town_dreamword_duihuan_flag.json", "effect_ui_town_dreamword_duihuan_flag.atlas", 1);
    flag:leftUp(75, 55)
    rootNode:addChild(flag)
    flag:setAnimation("idle", true)

    local bianfu = UI.Animation:create()
    bianfu:init("effect_ui_town_dreamword_duihuan_bianfu.json", "effect_ui_town_dreamword_duihuan_bianfu.atlas", 1);
    bianfu:leftBottom(70, 30)
    rootNode:addChild(bianfu)
    bianfu:setAnimation("idle", true)

    local book = UI.Animation:create()
    book:init("effect_ui_town_dreamword_duihuan_book.json", "effect_ui_town_dreamword_duihuan_book.atlas", 1);
    book:rightBottom(95, 80)
    rootNode:addChild(book)
    book:setAnimation("idle", true)
end

function DreamRankLayer:initTitles(rootNode)
    local btnNameArr = {UI.TEXT_1212293, UI.TEXT_1212015, UI.TEXT_110050, UI.TEXT_1212295, UI.TEXT_1212292};
    local wArr = {90, 85, 190, 200, 130};
    local deltaXArr = {0, 90, 175, 365, 565};

    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(RANK_CELL_W, 45);
    contentLayout:centerUp(0);
    rootNode:addChild(contentLayout);

    for k, v in ipairs(deltaXArr) do
        local range = UI.Layout:create();
        range:init();
        range:setSize(wArr[k], 45);
        range:centerLeft(v);

        local title = UI.Text:create();
        title:init(btnNameArr[k], UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45);
        title:center();
        range:addChild(title)
        contentLayout:addChild(range);
    end

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine:setContentSize(729, 2)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(RANK_CELL_W/2, 2)
    contentLayout:addChild(splitLine)
end

function DreamRankLayer:initRankList(rootNode)
    self._tableView = UI.TableView.new({}, RANK_CELL_W, 335);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:centerUp(45);
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(true);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return RANK_CELL_W, RANK_CELL_H;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.DreamRankCell.new();
            cell:init(self.rankList[idx + 1]);
        end,
        function(e) 
            printError("------------------------DreamRankLayer:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.rankList);
    end);

    self._tableView:onTableCellTouched(function(table, cell)
        print("DreamRankLayer:tableCellTouched",cell:getIdx());
        local rank = cell:getIdx() + 1;
        if rank == self._data.selfRank then
            return
        end

        local data = self.rankList[rank];
        if not data or not data.pk then
            return
        end

        if self.tabIndex == 1 then
            Net.NetRoleSystem:heroDetailRequest(data.pk, 1, nil, nil, PublicDefine.RankType.RankType_Dream, true)
        else
            Net.NetRoleSystem:heroDetailRequest(data.pk, 1, nil, nil, PublicDefine.RankType.RankType_Dream, false)
        end
    end);

    rootNode:addChild(self._tableView);
    -- self._tableView:enableDebugDraw()

    local mask  = UI.Image:create();
    mask:init("ui_dreamword_rank_mask.png");
    mask:centerBottom(78);
    rootNode:addChild(mask);

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(RANK_CELL_W, 1)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(753/2, 2)
    mask:addChild(splitLine)

    self._tableView:reloadData(true, true);
end

function DreamRankLayer:initMyRank(rootNode)
    local myRankBG = UI.Layout:create();
    myRankBG:init();
    myRankBG:setSize(RANK_CELL_W, RANK_CELL_H);
    myRankBG:centerBottom(5);
    self.myRankLayout = myRankBG;

    local mask  = UI.Image:create();
    mask:init("ui_dreamword_me.png");
    mask:centerBottom(0);
    myRankBG:addChild(mask);

    local myRank = UI.DreamRankCell.new();
    local obj = {};
    local guildName = UI.TEXT_1170313;
    if GameDataManager:getInstance():getIsJoinGuild() then
        guildName = MasterDataManager:getGuildData().name;
    end
    obj.rank = self._data.selfRank or 0;
    obj.faceId = RoleDataManager:getMaster():getFaceDecodeID();
    obj.sex = RoleDataManager:getMaster():getSex();
    obj.guildName = ToolsUtil:replaceShowNickNameStr(guildName);
    obj.nickName = ToolsUtil:replaceShowNickNameStr(RoleDataManager:getMaster():getNickName())
    obj.score = self._data.selfScore or 0;
    obj.rootLayer = self;
    obj.isSelf = true;
    myRank:init(obj);
    myRankBG:addChild(myRank);

    rootNode:addChild(myRankBG);
end

-- 每帧截屏3个
function DreamRankLayer:update(dt)
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
function DreamRankLayer:getHead(sex, faceDecodeID, callfunc, idx)
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

function DreamRankLayer:exportHead(headData, callfunc)
    Avalon.WidgetUtil:getHead(self, headData ,{}, self, handler(self,function(self,pic)
        if self and not tolua.isnull(self) then
            callfunc(pic, headData.faceDecodeID)
        end
    end),true)
end

-- 注册监听事件(可选)
function DreamRankLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_LIST, self, self.refreshCurWeekRank)
end

-- 注销监听事件(可选)
function DreamRankLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RANK_LIST, self, self.refreshCurWeekRank)
end

function DreamRankLayer:openShow()
    self:open()
end
