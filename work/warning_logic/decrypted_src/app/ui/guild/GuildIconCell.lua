-- GuildIconCell.lua
-- Author:zp
-- 2017年9月13日
-- Using:公会图标列表 cell

local GameDataManager = require("app.game.GameDataManager")


UI = UI or {}
local GuildIconCell = class("GuildIconCell", UI.HWBtnComponent)
UI.GuildIconCell = GuildIconCell

local COM_RES_LIST = {
    "ui_town_guild_icon.plist",
}

local _width = 97
local _height = 125
local space = 4

function GuildIconCell:ctor(data,idx)
    GuildIconCell.super.ctor(
        self,UIType.GUILD_ICON_CELL,
        COM_RES_LIST,
        _width,
        _height
    )

    self._iconList = ConfigManager:getGuildIconList()

    self.rootLayer = nil;           --root节点
    self.data = data;
    self.idx =idx

    self._icon = nil
    self._priceIcon = nil
    self._priceLabel = nil
    self._lockImage = nil

    self:init();
    self:registerListener();
end

function GuildIconCell:dtor()
    GuildIconCell.super.dtor(self)

    self:unRegisterListener();
end

-- public:
-- 初始化
function GuildIconCell:init()
    GuildIconCell.super.init(self)
end

-- 模版函数：初始化组建的视图
function GuildIconCell:onInitView()
    -- 图标
    local icon = UI.Image:create()
    icon:init("ui_guild_icon_guilgicon1.png")
    icon:centerBottom(30)
    self:addChild(icon)
    self._icon = icon

    print("GuildIconCell:onInitView ")
    
    -- 钻石图标
    local priceIcon = UI.Image:create()
    priceIcon:init("symbol_gaming_diamond.png")
    self:addChild(priceIcon)
    self._priceIcon = priceIcon

    -- 价格
    local priceLabel = UI.Text:create()
    priceLabel:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    -- priceLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    priceLabel:setTextLeft()
    -- priceLabel:setSize(0, 0)
    priceLabel:centerLeft(priceIcon:getContentSize().width + space)
    priceIcon:addChild(priceLabel, 10)
    self._priceLabel = priceLabel

    self:refreshPriceColor()

    local priceIconX = _width/2 - priceLabel:getContentSize().width /2 - space/2
    priceIcon:leftBottom(priceIconX, 8)
    -- priceLabel:leftBottom(priceIconX + priceIcon:getContentSize().width/2 + jiange, 4)

    -- 锁定图标
    local lockImage = UI.Image:create()
    lockImage:init("ui_guild_lock.png")
    icon:addChild(lockImage)
    lockImage:rightUp(0,0)
    self._lockImage = lockImage

    self:reload(self.data, self.idx)
end

-- 模版函数：更新组建的视图
function GuildIconCell:onUpdateView()
end

function GuildIconCell:buyIconResponse(status, data)
    if(status and data and self.data and tonumber(data.iconID) == tonumber(self.data.iconID)) then
        self.data.iconCost = 0
        -- 播放解锁动画
        self._lockImage:setVisible(false)
        
        self._priceIcon:setVisible(false)
        self._priceLabel:setVisible(false)

        self:reload(self.data, self.idx)
    end
end

function GuildIconCell:refreshPriceColor()
    if (self and not tolua.isnull(self) and self.data) then
        local master = GameDataManager:getInstance():getMaster()
        if(not Avalon.MathUtil:checkDiamonEnough(tonumber(self.data.iconCost), master:getDiamond())) then 
            self._priceLabel:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else 
            self._priceLabel:setFontColor(UI.FONT_COLOR_194_194_194)
        end
    end
end

-- 注册监听事件(可选)
function GuildIconCell:registerListener()
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BUY_GUILD_ICON, self, self.buyIconResponse)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshPriceColor)
end

-- 注销监听事件(可选)
function GuildIconCell:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BUY_GUILD_ICON, self, self.buyIconSuccess)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshPriceColor)
end

function GuildIconCell:reload(data,idx)
    if(data) then
        self.data = data
    end

    self.idx = idx

    if(self.data) then
        if(tonumber(self.data.iconCost) == 0) then
            self._icon:setSpriteName(self.data.iconSpriteName)
            self._priceIcon:setVisible(false)
            self._priceLabel:setVisible(false)
            self._lockImage:setVisible(false)
        else
            self._priceIcon:setVisible(true)
            self._priceLabel:setVisible(true)
            self._lockImage:setVisible(true)

            local nameArr = string.split(self.data.iconSpriteName, ".")
            local nameStr = self.data.iconSpriteName
            if(nameArr and #nameArr == 2) then 
                nameStr = nameArr[1].."-1.png"
            end
            self._icon:setSpriteName(nameStr)

            self._priceLabel:setText(tostring(self.data.iconCost))

            local priceIconX = _width/2 - (self._priceIcon:getContentSize().width + self._priceLabel:getContentSize().width) /2 - space/2
            self._priceIcon:leftBottom(priceIconX, 8)

            self:refreshPriceColor()
        end
    end
end

