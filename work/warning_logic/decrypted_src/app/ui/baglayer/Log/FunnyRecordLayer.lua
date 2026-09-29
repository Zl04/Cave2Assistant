-- FunnyRecordLayer.lua
-- Author:ydli
-- 2017年11月16日
-- Using:日志界面——趣味数据（玩家自己的趣味数据）
UI = UI or {}

local FunnyRecordLayer = class("FunnyRecordLayer", UI.HWBtnComponent)
UI.FunnyRecordLayer = FunnyRecordLayer
local GameDataManager = require("app.game.GameDataManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local LanguageManager = require("app.game.LanguageManager")

require("app.ui.baglayer.Log.FunnyRecordCell")
require("app.ui.common.SharePanel")
-- private:
local winSize = cc.Director:getInstance():getWinSize()

-- 尺寸
local COM_WIDTH = 852
local COM_HEIGHT = 534
local DATA_SIZE_IN_CELL = 4 -- 一个cell 放四个数据结构
local FIRST_SHOW_SIZE = 2 -- 第一帧 渲染的cell 数量
local SIZE_IN_SHARE = 5 -- 分享界面 每排放5个

local COM_RES_LIST = {
    "ui_package_log_funnyRecord.plist",
    "ui_package_log.plist",
    "ui_general_uishare.plist"
}


local function onScrollViewScrollBeganHandler(self, scrollView)

    
end

-- 列表滚动视图滚动的处理器
local function onScrollViewScrollingHandler(self, scrollView, percent)
    self._isScrolling = true
end

-- 列表滚动视图滚动结束的处理器
local function onScrollViewScrollEndedHandler(self, scrollView)
    self._isScrolling = false
end


-- 构造函数
function FunnyRecordLayer:ctor(isPlayTableAct)
    FunnyRecordLayer.super.ctor(self, UIType.FUNNY_RECORD_LAYER, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self._isScrolling = false   -- 列表是否正在滚动
    self._tscrollView = nil  -- 列表的滚动视图
    self._scrollLayout = nil
    if isPlayTableAct == nil then
        self._isPlayTableAct = true
    else
        self._isPlayTableAct = false
    end
    self.funnyRecords = {} 
end

--析构函数
function FunnyRecordLayer:dtor()
    FunnyRecordLayer.super.dtor(self)
    self._isScrolling = false   -- 列表是否正在滚动
    self._scrollView = nil  -- 列表的滚动视图
    self._scrollLayout = nil
    self.funnyRecords = {}
end

-- 初始化
function FunnyRecordLayer:init()
    FunnyRecordLayer.super.init(self)
    self.funnyRecords = GameDataManager:getFunnyRecords()
    -- self:showLucencyLight(COM_WIDTH, COM_HEIGHT)
    -- self:enableDebugDraw()
    -- dump(self.funnyRecords, "------self.funnyRecords")
end

-- 初始化视图
function FunnyRecordLayer:onInitView()
    -- 滑动信息展示区域
    local scrollLayout = UI.Layout:create()
    scrollLayout:init()
    self._scrollLayout = scrollLayout
    
    local bg =  cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png", CCRectMake(303,136,4,2))
    bg:setContentSize(COM_WIDTH, COM_HEIGHT)
    bg:setAnchorPoint(0, 0)
    bg:setPosition(0, 0)
    self:addChild(bg, 1)

    local funyTableView = cc.TableView:create(cc.size(COM_WIDTH - 16, COM_HEIGHT -15))
    funyTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    funyTableView:setPosition(0,10)
    funyTableView:setDelegate()
    funyTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    funyTableView:initScrollBar(false)
    funyTableView:setScrollBarWidth(5)
    funyTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    self:addChild(funyTableView, 20)

    funyTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    funyTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    funyTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    funyTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    funyTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    funyTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    funyTableView:registerScriptHandler(handler(self,self.tableCellWillRecycle),cc.TABLECELL_WILL_RECYCLE)
    self.funyTableView = funyTableView

    local bottom = UI.Image:create()
    bottom:init("ui_bg_paper_mask1.png")
    bottom:centerBottom(0)
    self:addChild(bottom, 30)
end

-- 更新视图
function FunnyRecordLayer:onUpdateView()  
    if self._isPlayTableAct then
        self.funyTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    else
        self.funyTableView:reloadData()
    end
end


function FunnyRecordLayer:numberOfCellsInTableView(table)
    return math.ceil(#self.funnyRecords / DATA_SIZE_IN_CELL)
end

function FunnyRecordLayer:scrollViewDidScroll(view)
end

function FunnyRecordLayer:scrollViewDidZoom(view)
    
end

function FunnyRecordLayer:tableCellTouched(tableView,cell)

end

function FunnyRecordLayer:tableCellWillRecycle(tableView,cell)
    -- print("---AchievementLayer:tableCellWillRecycle------")
end

function FunnyRecordLayer:cellSizeForTable(table,idx)
    return 850, 218
end

function FunnyRecordLayer:tableCellAtIndex(tableView,idx)
    -- print("FunnyRecordLayer:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    if cell == nil then
        cell = cc.TableViewCell:new()
    else
        cell:removeChildByName("cell");
    end
    xpcall(function()
        local funyCell = self:createCell(idx + 1)
        funyCell:setName("cell")
        funyCell:leftBottom(0, 0)
        cell:addChild(funyCell)
        -- funyCell:enableDebugDraw()
    end, 
    function(e) 
        printError("-----FunnyRecordLayer:tableCellAtIndex--------error")
    end, 1)  
    return cell
end

function FunnyRecordLayer:createCell(i)  
    local funnyCell = UI.FunnyRecordCell:create()
    funnyCell:init(self.funnyRecords, i, DATA_SIZE_IN_CELL)
    -- funnyCell:enableDebugDraw(UI.RED)
    return funnyCell
end

function FunnyRecordLayer:shareClick(platform)  
    local shareDatas = ConfigManager:getShareConfigByType(PublicDefine.SHARE_MODULE.SHARE_MODULE_PLAYER_LOG,platform)
    if shareDatas == nil then
        printWarn("----!!!! error !!!! funnyRecord shareDatas is nnil")
        return
    end

    local funnyRecords = {}
    for k, v in ipairs(self.funnyRecords) do
        table.insert(funnyRecords, v)
    end
    local scale = 1
    local SizeShare = 3
    print("FunnyRecordLayer:createShareInfo ==> platform",platform)
    if not tolua.isnull(self._ShareNode) then
        self._ShareNode:removeFromParent(true)
    end
    local _ShareNode = cc.Node:create()
    _ShareNode:setPosition(5000, 0)
    -- _ShareNode:setPosition(300, 0)
    cc.Director:getInstance():getRunningScene():addChild(_ShareNode, -1)
    _ShareNode:setScale(scale)
    self._ShareNode = _ShareNode
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_share_banner_2.png")
    bg:setCapInsets(cc.rect(0,587,640,2))
    local heightSize = math.ceil(#funnyRecords / SizeShare)
    if heightSize > 3 then
        bg:setContentSize(cc.size(640, 1160 + (heightSize - 3) * 220))
    end 
    -- bg:setAnchorPoint(0, 0)
    bg:setPosition(bg:getContentSize().width / 2, bg:getContentSize().height / 2)
    _ShareNode:addChild(bg)

    local titleName = UI.Text:create() 
    if LanguageManager:getInstance():isCJKUnicode() then
        titleName:init(string.format(UI.TEXT_1150014,RoleDataManager:getMaster():getNickName())..UI.TEXT_1170912,UI.FONT_ARIAL)
    else
        titleName:init(string.format(UI.TEXT_1150014,RoleDataManager:getMaster():getNickName()).." "..UI.TEXT_1170912,UI.FONT_ARIAL)
    end
    titleName:setFontSize(36)
    titleName:setFontColor(UI.FONT_COLOR_255_204_0)
    titleName:rightUp(22, 98)
    titleName:setSize(350,120)
    titleName:setTextCenter()
    bg:addChild(titleName)
    
     -- 公司LOGO
    local logo = UI.Image:create()
    logo:init("ui_share_logo2.png")
    logo:rightUp(60, 30)
    bg:addChild(logo)

    local sprite = SdkBox:getInstance():createQRSprite(shareDatas.url);
    sprite:setPosition(45, 48)
    sprite:setScale(75 / sprite:getContentSize().width)
    bg:addChild(sprite)
    -- 公司LOGO
    local logo = UI.Image:create()
    logo:init("ui_share_logo.png")
    logo:rightBottom(10, 20)
    bg:addChild(logo)

    local left = 3
    local up = 110
    for k, v in ipairs(funnyRecords) do
        local xIndex = k % SizeShare
        local yIndex = math.ceil(k / SizeShare)
        local recordNode = self:createOneShareNode(v)
        recordNode:leftUp(left + xIndex * 210, up + yIndex * 220)
        bg:addChild(recordNode)
    end
    performWithDelay(_ShareNode,function()
        SdkBox:getInstance():createImage(bg,"share.png",function(path)
            SdkBox:getInstance():share({

                channel = platform,
                link = shareDatas.url,
                content =  LanguageManager:getInstance():getLocalString(shareDatas.content[math.random(1,table.nums(shareDatas.content))]),
                type = PublicDefine.SHARE_CONTENT_TYPE.IMAGE,
                title = LanguageManager:getInstance():getLocalString(shareDatas.title[math.random(1,table.nums(shareDatas.title))]),
                thumb = AvalonUtil.getShareThumbPath(shareDatas),
                image = path,
            })
            if _ShareNode and not tolua.isnull(_ShareNode) then
                _ShareNode:setVisible(false)
                _ShareNode:runAction(cc.RemoveSelf:create())
            end
        end)
    end, 0.05)
end

function FunnyRecordLayer:createOneShareNode(data)
    -- dump(data, "----------data")
    local bg = UI.Layout:create()
    bg:init()
    bg:setSize(210, 220)
    
    local bgImg = UI.Image:create()
    bgImg:init("ui_share_box.png")
    bgImg:centerBottom(0)
    bg:addChild(bgImg)

    local icon = UI.Image:create()
    icon:init(data.icon)
    icon:centerBottom(48)
    bg:addChild(icon)

    local name = UI.Text:create()
    name:init(string.format("%s", data.name), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    name:setSize(150, 50)
    name:setTextHorizontalCenterAndBottom()
    name:centerUp(0)
    bg:addChild(name)
    name:setLineSpacing(-6)

    local score = UI.Text:create()  
    score:init(AvalonUtil:getSimpleNumber(data.score, 6), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_226_183_86)
    score:setSize(170, 25)
    score:setTextCenter()
    score:centerBottom(30)
    bg:addChild(score)
    return bg
end

function FunnyRecordLayer:showShareBtn(parentNode)
    --分享布局
    parentNode:showShareBtn(handler(self, self.shareClick), PublicDefine.SHARE_MODULE.SHARE_MODULE_PLAYER_LOG)
end