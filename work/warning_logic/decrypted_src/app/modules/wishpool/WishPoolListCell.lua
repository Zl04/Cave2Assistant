-- WishPoolListCell.lua
-- Author:lzm
-- Using:许愿池许愿薄 cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
UI = UI or {}

local WishPoolListCell = class("WishPoolListCell", UI.HWBtnComponent)
UI.WishPoolListCell = WishPoolListCell

local COM_WIDTH = 820
local COM_HEIGHT = 92

--构造函数(必备)
function WishPoolListCell:ctor()
    WishPoolListCell.super.ctor(self)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SIDEBAR_CELL_CANCEL_CLICK, self, self.cellCancelClick)
end

--虚构函数,destroy时调用(必备)
function WishPoolListCell:dtor()
    WishPoolListCell.super.dtor(self)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SIDEBAR_CELL_CANCEL_CLICK, self, self.cellCancelClick)
end

-- 初始化(必备)
function WishPoolListCell:init(idx, data, rootLayer)
    WishPoolListCell.super.init(self)
    self._idx = idx
    self._data = data
    self.rootLayer = rootLayer

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:leftUp(0, 0)
    -- cellLayout:enableDebugDraw()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    -- 分隔条
    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(710, 1)
    splitLine:setCapInsets(CCRectMake(1,0,1,1))
    splitLine:setPosition(cc.p(COM_WIDTH / 2+40, 0))
    self.cellLayout:addChild(splitLine, 5)

    -- 头像
    local headBg = UI.Image:create()
    headBg:init("ui_information_headframe_bottom.png")
    headBg:centerLeft(12);
    headBg:setName("headBg")
    self.cellLayout:addChild(headBg, 10);

    local headCap = UI.Image:create()
    headCap:init("ui_information_headframe_box.png")
    headCap:center()
    headBg:addChild(headCap);
    self.headBg = headBg;

    local touchLayout = UI.Layout:create()
    touchLayout:init()
    touchLayout:setSize(100, 100)
    touchLayout:leftUp(0, 0)
    -- touchLayout:enableDebugDraw()
    touchLayout:setTouchEnable(true)
    touchLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        local pk = GameDataManager:getInstance():getMasterPK()
        if pk == self._data.heropk then
            return
        end

        GameManager:heroDetailRequest(self._data.heropk, self._data.herouserid)
    end)
    self.cellLayout:addChild(touchLayout)

    -- 等级背景图
    self._grade_BG = UI.Image:create()
    self._grade_BG:init("ui_information_headframe_grade.png")
    self._grade_BG:leftBottom(4, 4)
    self.cellLayout:addChild(self._grade_BG, 100)
    
    -- 等级
    self._lvLabel = UI.Text:create()
    self._lvLabel:init(self._data.herolevel.."",UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_189_167_136)
    self._lvLabel:setSize(100, 50)
    self._lvLabel:center()
    self._lvLabel:setTextCenter()
    self._grade_BG:addChild(self._lvLabel,101)

    self.rootLayer:getHead(self._data.herosex, self._data.herofaceid, handler(self, self.refreshFace), self._idx)

    local nameBg = UI.Image:create();
    nameBg:init("ui_mailbox_text.png");
    nameBg:leftUp(100, 10);
    self.cellLayout:addChild(nameBg);

    local name = UI.Text:create();
    name:init(self._data.heroname, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155);
    name:centerLeft(2);
    nameBg:addChild(name)

    local pinglun = UI.Text:create();
    pinglun:init(self._data.wishcontent, UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
    pinglun:setWidth(590)
    pinglun:leftUp(100, 45);
    pinglun:autoAdapt()
    -- pinglun:enableDebugDraw()
    self.cellLayout:addChild(pinglun)

    local time = UI.Text:create();
    time:init(self:getFormatedTime(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45);
    time:rightUp(14, 10);
    self.cellLayout:addChild(time)
end

function WishPoolListCell:refreshFace(pic, aceDecodeID)
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

function WishPoolListCell:getFormatedTime()
    local secondsInMinutes = 60
    local secondsInHour = secondsInMinutes * 60
    local secondsInDay = 24 * secondsInHour

    local curTime = GameManager:getNormalServerTime()
    local delta = curTime - self._data.wishtime

    if delta < secondsInDay then
        -- 当天的时间直接显示
        local timeString = GameManager:getNowServerDate("%H:%M:%S", self._data.wishtime + GameManager:getEPOCHTime())
        return timeString
    end

    -- 大于一天的显示多少天前
    local days = math.floor(delta / secondsInDay)
    return string.format(UI.TEXT_1213275, days)
end

-- 模版函数：初始化组建的视图(必备)
function WishPoolListCell:onInitView()
end

function WishPoolListCell:getData()
    return self._data;
end

function WishPoolListCell:onUpdateView()

end
