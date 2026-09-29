-- GuildGiantBoxContentCell.lua
-- Author:CMonk
-- 2019年04月09日

require "app.ui.common.Text"
require "utils.AvalonUtil"

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local GuildGiantBoxContentCell = class("GuildGiantBoxContentCell", UI.TableViewCell)
UI.GuildGiantBoxContentCell = GuildGiantBoxContentCell

GuildGiantBoxContentCell.CELL_WIDTH = 258
GuildGiantBoxContentCell.CELL_HEIGHT = 88

function GuildGiantBoxContentCell:ctor(parentTable)
    GuildGiantBoxContentCell.super.ctor(self)

    self._parentTable = parentTable
    self:onInitView()
end

function GuildGiantBoxContentCell:onInitView()
    -- 内容运载层
    self._rootLayer = UI.Layout:create()
    self._rootLayer:init()
    self._rootLayer:setSize(UI.GuildGiantBoxContentCell.CELL_WIDTH, UI.GuildGiantBoxContentCell.CELL_HEIGHT)
    self._rootLayer:leftBottom(0, 0)
    self:addChild(self._rootLayer)

    -- 背景 centerUp 0
    local bg = UI.Image:create()
    bg:init("ui_shopping_banner_box1_paper.png")
    bg:centerUp(0)
    self._rootLayer:addChild(bg)

    -- 道具ICON centerLeft 14
    self._itemIcon = UI.GoodsGrid:create()
    self._itemIcon:init()
    self._itemIcon:centerLeft(14)
    self._itemIcon:setTouchEnable(true)
    self._itemIcon:setSwallowTouches(false)
    self._itemIcon:setTouchClipNode(self._parentTable)
    self._rootLayer:addChild(self._itemIcon)

    -- 隔断 centerLeft 100 h77w1
    local splitter = UI.Image9:create()
    splitter:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(1, 77))
    splitter:centerLeft(100)
    splitter:setOpacity(115)
    self._rootLayer:addChild(splitter)

    -- 名字 leftUp 105, 10
    self._itemName = UI.Text:create()
    self._itemName:init("钻石666asdfaaasdf asdf 1231", UI.FONT_STANDARD, UI.FONT_SIZE_15PX, UI.FONT_COLOR_41_41_45)
    self._itemName:setWidth(145)
    self._itemName:leftUp(110, 10)
    self._itemName:autoAdapt()
    self._rootLayer:addChild(self._itemName)

    -- 数量 leftBottom 105, 7
    self._itemNum = UI.Text:create()
    self._itemNum:init("x0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._itemNum:leftBottom(110, 7)
    self._rootLayer:addChild(self._itemNum)
end

function GuildGiantBoxContentCell:getDummyItemData(id)
    require "app.datas.GoodsDataManager"
    local goodData = GoodsDataManager:createLocalGoodsData(id) --23030001
    if goodData then
        goodData:setNum(0)
        goodData:setIsNew(false)
        goodData.isHaveGet = false
    end
    return goodData
end








-------------SevenDayLayer 接口--------------
function GuildGiantBoxContentCell:reset()
    
end

function GuildGiantBoxContentCell:setClickCallback(cb)
    self._clickCB = cb
end

function GuildGiantBoxContentCell:updateData(data)
    self._data = data
    if (self._data) then
        local itemID = data.ID
        if (itemID) then
            local goodData = self:getDummyItemData(itemID)
            if (goodData) then
                -- ICON
                local num = data.num or 0
                local guildData = MasterDataManager:getGuildData()
                local isActive = false
                if guildData then
                    isActive = guildData:isActiveWrit(PublicDefine.WritID.WritID_GuildBox)
                end
                if isActive then
                    num = num * 2
                end
                goodData:setNum(num)
                self._itemIcon:hide()
                self._itemIcon:show()
                self._itemIcon:reset()
                self._itemIcon:setData(goodData)
                self._itemIcon:hideNewIcon()
                self._itemIcon:showInfoArea()
                if (num == 0) then
                    self._itemIcon:hideCountLabel()
                else
                    self._itemIcon:showCountLabel()
                end

                -- 名字
                local name = goodData:getName()
                if (name) then
                    self._itemName:setText(name)
                end

                -- 数量
                local num = goodData:getNum()
                if (num) then
                    self._itemNum:setText("x"..num)
                end
            end
        end
    end
end