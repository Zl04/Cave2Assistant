--[[
    UI - 装备详情界面
]] --

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.ScrollView"

UI = UI or {}

local LanguageManager = require("app.game.LanguageManager")
local EquipmentInfoArea = class("EquipmentInfoArea", UI.HWBtnComponent)
UI.EquipmentInfoArea = EquipmentInfoArea

local winSize = cc.Director:getInstance():getWinSize()

-- private:
local DEBUG = false
local DEBUG_DRAW = true
-- 尺寸
local holeWidth = 0
local width = 324 + holeWidth
local height = 418
local TEXT_VALUE_SPACE = 10
local TEXT_VALUE_ROW = 20
local GRID_SIZE_WIDTH = 74
local GRID_SIZE_HEIGHT = 74
-- 描述信息的宽度
local TEXT_DESCRIBE_WIDTH = 250
-- 一排的Y坐标
local WEIGHT_POSTION_Y = 80
-- 背包资源
local BAG_EQUIPMENT_INFO_AREA_RES_LIST = {
    "ui_package_skill.plist",
    "ui_town_blacksmith.plist",
    "ui_common_information.plist",
    "ui_common_icon_material.plist",
    "ui_town_glyphs.plist",
}

local SPRITE_GRID_RARE_1 = "box_quality_0_1.png"
local SPRITE_EQUIPMENT_ALL = "icon-equip_large_21010010.png"
local SPRITE_EQUIPMENT_NAME = "icon-equip_large_210%s0010.png"
local SPRITE_EQUIPMENT_WEAPON = "icon-equip_large_210%s0010_%s.png"

-- 属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT = "ui_iteminfo_icon_point_01.png"
-- 套装属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT_SUIT = "ui_iteminfo_icon_point_02.png"

-- 锁按钮的三个状态
local SPRITE_ITEM_ICON_LOCK = "ui_iteminfo_btn_locked.png"
local SPRITE_ITEM_ICON_UNLOCK = "ui_iteminfo_btn_unlock.png"
-- 装备评分图标
local SPRITE_EQUIPMENT_LEVEL = "symbol_character_hero_power.png"

local HAMMER = "ui_information_remodel.png" -- 锤子
-- 分割线的size
local ITEMINFO_LINE_SIZE_WIDTH = 306
local ITEMINFO_LINE_SIZE_HEIGHT = 1
-- 布局的宽
local LAYOUT_SIZE_WIDTH = 318
-- 顶部区域的高
local self_SIZE_HEIGHT = 180
local SCROLLLAYOUT_SIZE_HEIGHT = 140

local BAG_GRID_LIST_POSX = 8
local BAG_GRID_LIST_POSY = 8
local LEFT_SPACE = 18
local UP_SPACE = 30
-- 星炼等级
local POSITION_X_STAR = 10
local POSITION_Y_STAR = 10
local POSITION_X_STARLV = 50
local POSITION_Y_STARLV = 10

local ATTACK_VALUE_SIZE_WIDTH = 100
local ATTACK_VALUE_SIZE_HEIGHT = 20
local LEFT_SPACE_ATTACK_VALUE = 120

local self = nil
local fontsize = UI.FONT_SIZE_16PX
local font = UI.FONT_ARIAL

UI.EquipImageBgType = {
    BIG_TYPE = 1,
    SMALL_TYPE = 2,
    BAG_TYPE = 3,
    NO_GET_TYPE = 4 -- 还没有获得的物品
}
local EquipImageBgType = UI.EquipImageBgType

local EquipmentHoleInfoArea = class("EquipmentHoleInfoArea", UI.HWBtnComponent)

function EquipmentHoleInfoArea:ctor()
    EquipmentHoleInfoArea.super.ctor(self, UIType.EQUIPMENT_INFO_AREA, {}, 55, 48)

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA, self, self.closeInfoArea)
end

function EquipmentHoleInfoArea:dtor()
    EquipmentHoleInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA, self, self.closeInfoArea)
end

function EquipmentHoleInfoArea:init()
    EquipmentHoleInfoArea.super.init(self)
end

function EquipmentHoleInfoArea:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_iteminfo_btn_runestone_colorful_dwon.png")
    bg:setSize(44, 45)
    bg:center()
    self:addChild(bg)

    -- 图标
    local goodsGrid = UI.Image:create()
    goodsGrid:init("ui_iteminfo_btn_locked.png")
    goodsGrid:setSize(44, 45)
    goodsGrid:center()
    goodsGrid:leftUp(2, 1)
    bg:addChild(goodsGrid, 10)

    --
    local colorImage = UI.Image:create()
    colorImage:init("ui_iteminfo_btn_runestone_colorful_up.png")
    colorImage:setSize(44, 45)
    bg:addChild(colorImage, 10)
    colorImage:center()

    bg:setTouchEnable(true)
    bg:addEventListener(
        UI.Event.COMPONENT_CLICK,
        self,
        function()
            self:onTouchLongTimeBeganHandler()
        end
    )

    local function onTouchBegan(touch, event)
        if (not tolua.isnull(self)) then
            if (self._visible == false) then
                return false
            end
        end

        local posStarTouch = touch:getLocation()
        local point = self:convertToWorldSpace(cc.p(0, 0))
        local width = self:getContentSize().width
        local height = self:getContentSize().height
        local rect = cc.rect(point.x, point.y, width, height)
        if cc.rectContainsPoint(rect, posStarTouch) then
            self:onTouchLongTimeBeganHandler()
            return true
        end

        return false
    end

    local function onTouchEnded(touch, event)
        local posTouch = touch:getLocation()
        if (self._isTouchLongTime) then
            self._isTouchLongTime = false
        end
        if self._pInfoArea then
            self._pInfoArea:removeSelf()
            self._pInfoArea = nil
        end

        if self._holeInfo then
            self._holeInfo:removeSelf()
            self._holeInfo = nil
        end
    end

    -- local listener = cc.EventListenerTouchOneByOne:create()
    -- listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    -- listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    -- listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_CANCELLED )

    -- local eventDispatcher = self:getEventDispatcher()
    -- eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    -- listener:setSwallowTouches(true)

    self.bg = bg
    self.colorImage = colorImage
    self.goodsGrid = goodsGrid
end

function EquipmentHoleInfoArea:refreshHole(holeData, unlock)
    self.holeData = holeData
    self.unlock = unlock

    local spriteFrameName = nil
    local downFrameName = nil
    if (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Red) then
        downFrameName = "ui_iteminfo_btn_runestone_red_dwon.png"
        spriteFrameName = "ui_iteminfo_btn_runestone_red_up.png"
    elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Yellow) then
        downFrameName = "ui_iteminfo_btn_runestone_red_dwon.png"
        spriteFrameName = "ui_iteminfo_btn_runestone_red_up.png"
    elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Blue) then
        downFrameName = "ui_iteminfo_btn_runestone_red_dwon.png"
        spriteFrameName = "ui_iteminfo_btn_runestone_red_up.png"
    elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then
        downFrameName = "ui_iteminfo_btn_runestone_colorful_dwon.png"
        spriteFrameName = "ui_iteminfo_btn_runestone_colorful_up.png"
    end

    if (spriteFrameName) then
        self.colorImage:setVisible(true)
        self.colorImage:setSpriteName(spriteFrameName)
    end
    if (downFrameName) then
        self.bg:setSpriteName(downFrameName)
    end

    if (unlock or holeData:getHoleType() ~= PublicDefine.GemStoneType.GemStoneType_Colourful) then
        self.goodsGrid:setVisible(false)
        local gemStoneData = holeData:getGemStoneData()
        if (gemStoneData) then
            self._mn = "dddd"
            self.gemStoneData = gemStoneData
            self.goodsGrid:setVisible(true)
            self.goodsGrid:setSpriteName(gemStoneData:getIconName())
            self.goodsGrid:setScale(0.7)
            -- self.goodsGrid:centerUp(-4)
            self.goodsGrid:updateView()
        end
    else
        -- 锁定
        self.goodsGrid:setSpriteName("ui_iteminfo_btn_locked.png")
    end
end

function EquipmentHoleInfoArea:closeInfoArea()
    if self._pInfoArea then
        self._pInfoArea:setVisible(false)
        self._pInfoArea:removeFromParent()
        self._pInfoArea = nil
    end

    if (self._holeInfo) then
        self._holeInfo:setVisible(false)
        self._holeInfo:removeFromParent()
        self._holeInfo = nil
    end
end

function EquipmentHoleInfoArea:setGoodsData(goodsData)
    self.goodsData = goodsData
end

function EquipmentHoleInfoArea:onTouchLongTimeBeganHandler()
    --print("====弹出页面===  1", self._mn, self._type, self.index)
    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA)

    if (self.holeData == nil) then
        return
    end

    self._isTouchLongTime = true
    if not self.gemStoneData then
        local showStr = nil
        if (self.unlock or self.holeData:getHoleType() ~= PublicDefine.GemStoneType.GemStoneType_Colourful) then
            -- 显示可以镶嵌的颜色
            local textStr = UI.TEXT_1201020
            local formatStr = UI.TEXT_1201014
            local holeData = self.holeData
            if (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Red) then
                formatStr = UI.TEXT_1201014
            elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Yellow) then
                formatStr = UI.TEXT_1201015
            elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Blue) then
                formatStr = UI.TEXT_1201016
            elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then
                formatStr = UI.TEXT_1201017
            end

            showStr = string.format(textStr, formatStr)
        else
            -- 提示为解锁
            if (self.goodsData) then
                showStr = string.format(UI.TEXT_1201019, self.goodsData:getColorHoleUnlockLevel())
            else
                showStr = UI.TEXT_1201019
            end
        end

        if (showStr) then
            local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_background1.png")
            bg:setCapInsets(CCRectMake(12, 12, 2, 2))
            bg:setAnchorPoint(0, 0)
            bg:setContentSize(cc.size(280, 50))

            local showText = UI.Text:create()
            showText:init(showStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
            showText:center()
            local maxWidth = 280
            if (showText:getContentSize().width > 260) then
                showText:setWidth(260)
            else
                maxWidth = showText:getContentSize().width + 20
            end

            bg:addChild(showText)
            bg:setContentSize(cc.size(maxWidth, showText:getContentSize().height + 30))
            bg:setPosition(self:getPositionX() + 10, 30)
            self:getParent():addChild(bg, UI_ZORDER.TIPS)
            self._holeInfo = bg

            local function showOutSizeTouchHandler(self, obj, touchPosition)
                -- 更新装备对比区域数据
                if (not tolua.isnull(self._holeInfo)) then
                    self._holeInfo:removeFromParent(true)
                    self._holeInfo = nil
                end
            end

            local layout = UI.Layout:create()
            layout:init()
            layout:setSize(maxWidth, showText:getContentSize().height + 30)
            bg:addChild(layout)
            layout:center()
            layout:setTouchEnable(true)
            layout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, showOutSizeTouchHandler)

            Avalon.AudioManager:playSound("1503")
        end
        return
    end
    --print("====弹出页面===  2")
    local goodsData = self.gemStoneData
    local pInfoArea = nil
    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
        pInfoArea = UI.GemStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then
        pInfoArea = UI.GlyphInfoArea:create()
        pInfoArea:init(goodsData)
    else
        return
    end
    pInfoArea:setHideLink(true)
    -- local worldPos = self:convertToWorldSpace(cc.p(0,0))
    local worldPos = self:getParent():convertToWorldSpace(cc.p(0, 0))
    local positionY = self:getParent():getContentSize().height / 2 - pInfoArea:getContentSize().height / 2

    if worldPos.x < winSize.width / 2 then
        pInfoArea:leftBottom(self:getParent():getContentSize().width, positionY)
    else
        pInfoArea:leftBottom(-pInfoArea:getContentSize().width, positionY)
    end

    pInfoArea:setTouchEnable(true)
    local function infoOutSizeTouchHandler(self, obj, touchPosition)
        -- 更新装备对比区域数据
        if (not tolua.isnull(self._pInfoArea)) then
            self._pInfoArea:close()
            self._pInfoArea = nil
        end
    end
    pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, infoOutSizeTouchHandler)

    pInfoArea:setVisible(true)
    pInfoArea:updateView(goodsData)
    pInfoArea:closeLockFlag()
    self._pInfoArea = pInfoArea
    self:getParent():addChild(pInfoArea, UI_ZORDER.TIPS)
    Avalon.AudioManager:playSound("1503")
end

--------------------------------------------------------------------------------------
local EquipmentGlyphInfoArea = class("EquipmentGlyphInfoArea", UI.HWBtnComponent)

function EquipmentGlyphInfoArea:ctor()
    EquipmentGlyphInfoArea.super.ctor(self, UIType.EQUIPMENT_INFO_AREA, {}, 55, 48)

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA, self, self.closeInfoArea)
end

function EquipmentGlyphInfoArea:dtor()
    EquipmentGlyphInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA, self, self.closeInfoArea)
end

function EquipmentGlyphInfoArea:init()
    EquipmentGlyphInfoArea.super.init(self)
end

function EquipmentGlyphInfoArea:onInitView()
    local bg_down = UI.Image:create()
    bg_down:init("ui_glyphs_box_down.png")
    bg_down:setSize(44, 45)
    bg_down:center(0,-12)
    self:addChild(bg_down)

    local bg_up = UI.Image:create()
    bg_up:init("ui_glyphs_box_up.png")
    bg_up:setSize(44, 45)
    bg_up:center(0,-12)
    self:addChild(bg_up)

    local bg = UI.Image:create()
    bg:init("ui_iteminfo_btn_runestone_colorful_dwon.png")
    bg:setSize(44, 45)
    bg:center(0,-12)
    self:addChild(bg)

    bg:setTouchEnable(true)
    bg:addEventListener(
        UI.Event.COMPONENT_CLICK,
        self,
        function()
            self:onTouchLongTimeBeganHandler()
        end
    )

    self.bg = bg

    self.bg:setScale(0.8)
    --self.colorImage = colorImage
end

function EquipmentGlyphInfoArea:refreshGlyph(glyphData)
    self.glyphData = glyphData

    local downFrameName = nil
    if (glyphData:calculateGlyphType() == PublicDefine.GlyphType.GlyphType_Blue) then
        downFrameName = "icon_52020001.png"
    elseif (glyphData:calculateGlyphType() == PublicDefine.GlyphType.GlyphType_Gold) then
        downFrameName = "icon_52030001.png"
    elseif (glyphData:calculateGlyphType() == PublicDefine.GlyphType.GlyphType_DarkGold) then
        downFrameName = "icon_52040001.png"
    elseif (glyphData:calculateGlyphType() == PublicDefine.GlyphType.GlyphType_Purple) then
        downFrameName = "icon_52050001.png"
    end

    if (downFrameName) then
        self.bg:setVisible(true)
        self.bg:setSpriteName(downFrameName)
    end
end

function EquipmentGlyphInfoArea:closeInfoArea()
    if self._pInfoArea then
        self._pInfoArea:setVisible(false)
        self._pInfoArea:removeFromParent()
        self._pInfoArea = nil
    end

    if (self._glyphInfo) then
        self._glyphInfo:setVisible(false)
        self._glyphInfo:removeFromParent()
        self._glyphInfo = nil
    end
end

function EquipmentGlyphInfoArea:onTouchLongTimeBeganHandler()
    --print("====弹出页面===  1", self._mn, self._type, self.index)
    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA)

    if (self.glyphData == nil) then
        return
    end

    self._isTouchLongTime = true
    --print("====弹出页面===  2")
    local goodsData = self.glyphData
    local pInfoArea = nil
    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
        pInfoArea = UI.GemStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then
        pInfoArea = UI.GlyphInfoArea:create()
        pInfoArea:init(goodsData)
    else
        return
    end
    pInfoArea:setHideLink(true)
    -- local worldPos = self:convertToWorldSpace(cc.p(0,0))
    local worldPos = self:getParent():convertToWorldSpace(cc.p(0, 0))
    local positionY = self:getParent():getContentSize().height / 2 - pInfoArea:getContentSize().height / 2

    if worldPos.x < winSize.width / 2 then
        pInfoArea:leftBottom(self:getParent():getContentSize().width, positionY)
    else
        pInfoArea:leftBottom(-pInfoArea:getContentSize().width, positionY)
    end

    pInfoArea:setTouchEnable(true)
    local function infoOutSizeTouchHandler(self, obj, touchPosition)
        -- 更新装备对比区域数据
        if (not tolua.isnull(self._pInfoArea)) then
            self._pInfoArea:close()
            self._pInfoArea = nil
        end
    end
    pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, infoOutSizeTouchHandler)

    pInfoArea:setVisible(true)
    pInfoArea:updateView(goodsData)
    pInfoArea:closeLockFlag()
    self._pInfoArea = pInfoArea
    self:getParent():addChild(pInfoArea, UI_ZORDER.TIPS)
    Avalon.AudioManager:playSound("1503")
end
--------------------------------------------------------------------------------------

-- 构造函数
function EquipmentInfoArea:ctor()
    -- print(debug.traceback())
    EquipmentInfoArea.super.ctor(self, UIType.EQUIPMENT_INFO_AREA, BAG_EQUIPMENT_INFO_AREA_RES_LIST, 324, 414)

    -- 装备名字
    self._goodsName = nil
    self._spriteBg = nil
    -- 图标
    self._iconSprite = nil
    -- 星级分数
    self._goodsScore = nil
    -- 装备类型
    self._equipmentType = nil
    -- 描述信息
    self._describe = nil
    self._level = nil
    self._lock = nil
    self._lockBg = nil
    -- 是否显示锁定标志
    self._lockShow = true

    -- false未锁定，true锁定
    self._lockstate = false
    -- 滑动窗口的显示信息
    self._scrollLayout = nil
    -- 物品信息
    self._goodsData = nil
    self._pngType = nil
    self._intensify = nil -- 强化次数

    self._packetType = nil
    self._goodsGrid = nil
    -- 是否显示售卖价格，这里只会在商店层显示
    self._showSellPrice = false
    self.holeNodeArr = {}
    self.glyphNode = nil

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- 析构函数
function EquipmentInfoArea:dtor()
    -- 装备名字
    self._goodsName = nil
    self._spriteBg = nil
    -- 图标
    self._iconSprite = nil
    -- 星级分数
    self._goodsScore = nil
    -- 装备类型
    self._equipmentType = nil
    -- 描述信息
    self._describe = nil
    self._level = nil
    self._lock = nil
    self._lockBtn = nil
    self._lockBg = nil
    -- 是否显示锁定标志
    self._lockShow = true

    -- false未锁定，true锁定
    self._lockstate = false
    self._scrollLayout = nil
    self._goodsData = nil

    self._bgheight = 0
    -- self._pngType = 0
    self._packetType = nil

    self._goodsGrid = nil
    self.holeNodeArr = {}
    self.glyphNode = nil

    EquipmentInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- public:
-- 初始化
function EquipmentInfoArea:init(pngType, data, isBotttom)
    self._pngType = pngType
    self._infoBottom = isBotttom
    --print("EquipmentInfoArea:init(", pngType)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
    EquipmentInfoArea.super.init(self, data, isBotttom)
end

-- 销毁
function EquipmentInfoArea:onDestroy()
end

-- 点击超链接的处理
local function onActiveChatHandler(self)
    --print("====聊天超链接===")
    -- Game.ChatManager:getInstance():sendItemLink(self._goodsData)
    UI.ChatMainLayer:getInstance():reciveLinkData(self._goodsData)
end

-- 设置的操作的包裹类型
function EquipmentInfoArea:setPacketType(packetType)
    self._packetType = packetType
end

-- 锁定状态改变
function EquipmentInfoArea:lockStatusChange(data)
    UI.WaitingLayer:hideWaiting()
    if (self._goodsData) then
        if (data.entityID == self._goodsData:getEntityID()) then
            --print("EquipmentInfoArea:lockStatusChange ", data.isLock, self._goodsData:getIsLock())
            self:refreshLock()
        end
    end
end

-- 点击锁定按钮处理
local function onActiveGoodsLockHandler(self)
    if (self._pngType == EquipImageBgType.BAG_TYPE) then
    else
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        GameManager:lockGoodsHandler(self._goodsData, self._packetType)
    end
end

-- 刷新锁定显示
function EquipmentInfoArea:refreshLock()
    if (self._goodsData and self._lock) then
        if (self._goodsData:getIsLock()) then
            self._lock:setSpriteName(SPRITE_ITEM_ICON_LOCK)
        else
            self._lock:setSpriteName(SPRITE_ITEM_ICON_UNLOCK)
        end
        self._lock:updateView()
    end
end

function EquipmentInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function EquipmentInfoArea:getGoodsGrid()
    return self._goodsGrid
end

-- 显示价格
function EquipmentInfoArea:setShowSellPrice(flag)
    self._showSellPrice = flag
    self:showSellPrice()
end

-- 初始化视图
function EquipmentInfoArea:onInitView(data, isBotttom)
    -- self:showLucencyLight()
    local pngtype = self._pngType
    self:initHole()
    self:initGlyph()
    self:initLockORLink()

    local goodsbg = UI.Image:create()
    goodsbg:init("ui_iteminfo_role_banner_box1.png")
    goodsbg:center()
    self:addChild(goodsbg)
    self.goodsbg = goodsbg
    local contentSize = goodsbg:getContentSize()
    self:setSize(contentSize.width, contentSize.height)

    AvalonUtil.runTipsAppearShowAnimation(self)

    -- 幻化标签
    self._equipIllusionIcon = UI.Image:create()
    self._equipIllusionIcon:init("ui_information_deformation.png")
    self._equipIllusionIcon:leftUp(15, 10)
    self._equipIllusionIcon:hide()
    self:addChild(self._equipIllusionIcon, 5)

    -- 装备名称
    local goodsName = UI.Text:create()
    goodsName:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    goodsName:setWidth(200)
    goodsName:leftUp(100, 12)
    goodsName:setLineSpacing(-5)
    self:addChild(goodsName, 10)
    self._goodsName = goodsName

    -- 装备评分
    local score = UI.Image:create()
    score:init(SPRITE_EQUIPMENT_LEVEL)
    self:addChild(score)
    self.scoreIcon = score

    local goodsScore = UI.NumberText:create("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsScore:centerLeft(score:getContentSize().width + 4)
    score:addChild(goodsScore)
    self._goodsScore = goodsScore

    -- score:leftUp((self:getContentSize().width - holeWidth) / 2 - score:getContentSize().width / 2 - goodsScore:getContentSize().width / 2 - 10 + 36, 60)
    score:leftUp(215, 62)

    -- 武器类型图标
    local equipmentType = UI.Image:create()
    equipmentType:init()
    equipmentType:leftUp(99, 60)
    self:addChild(equipmentType)
    self._equipmentType = equipmentType

    -- 武器类型文字描述
    local equipmentText = UI.Text:create()
    equipmentText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    equipmentText:centerLeft(25)
    equipmentType:addChild(equipmentText)
    equipmentText:setFixLineWidth(80)
    self._equipmentText = equipmentText

    local left = LEFT_SPACE
    -- 物品图标背景底框
    local spriteBg1 = UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(left, 13)
    self:addChild(spriteBg1)
    -- 物品图标背景
    local spriteBg = UI.Image:create()
    spriteBg:init(SPRITE_GRID_RARE_1)
    spriteBg:center()
    spriteBg1:addChild(spriteBg)
    self._spriteBg = spriteBg
    -- 物品图标
    local iconSprite = UI.Image:create()
    iconSprite:init()
    iconSprite:center()
    spriteBg:addChild(iconSprite)
    self._iconSprite = iconSprite

    local starLV = cc.Label:createWithSystemFont(string.format("+%s", 1), font, fontsize)
    starLV:setPosition(POSITION_X_STARLV, POSITION_Y_STARLV)
    self._spriteBg:addChild(starLV)
    self._starLV = starLV
    self._starLV:setVisible(false)

    local lineX = 162
    -- 上边的分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(291, 1)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineUpImage:setPosition(cc.p(lineX, 323 + 5))
    self.lineUpImage = lineUpImage
    goodsbg:addChild(lineUpImage, 4)

    -- 中间的分割线
    local lineCenterImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineCenterImage:setContentSize(291, 1)
    lineCenterImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineCenterImage:setPosition(cc.p(lineX, 247 + 5))
    self.lineCenterImage = lineCenterImage
    goodsbg:addChild(lineCenterImage, 4)

    -- 下边的分割线
    local lineDownImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineDownImage:setContentSize(291, 1)
    lineDownImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineDownImage:setPosition(cc.p(lineX, 90))
    self.lineDownImage = lineDownImage
    goodsbg:addChild(lineDownImage, 4)

    -- 属性显示区域
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    -- self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH,250)

    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH, 139 + 10)
    scrollView:init()
    scrollView:leftUp(0, 177 - 5)
    scrollView:addInnerNode(self._scrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    self.scrollView = scrollView
    self:addChild(scrollView)

    -- 描述信息
    local equipmentDescribe = UI.Text:create()
    equipmentDescribe:init("", UI.FONT_DES, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    equipmentDescribe:setSize(274, 50)
    equipmentDescribe:setTextLeft()
    equipmentDescribe:leftUp(left, 330)
    goodsbg:addChild(equipmentDescribe)
    self._describe = equipmentDescribe

    --鱼竿装备的特殊描述内容  
    local fishEquipmentDescribe = UI.Text:create()
    fishEquipmentDescribe:init(LanguageManager:getInstance():getLocalString(1060620), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    fishEquipmentDescribe:setTextLeftUp()
    fishEquipmentDescribe:setSize(280, 70)
    fishEquipmentDescribe:leftUp(left, 110)
    goodsbg:addChild(fishEquipmentDescribe)
    self._fishEquipmentDescribe = fishEquipmentDescribe
    self._fishEquipmentDescribe:setVisible(false)


    local offsetBottomY = 8
    -- 可强化次数
    local intensify = UI.Text:create()
    intensify:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    -- intensify:setFontColor(UI.FONT_COLOR_88_65_34)
    intensify:leftBottom(left, offsetBottomY)
    self._intensify = intensify
    self:addChild(intensify)
    self._intensify:setVisible(false)

    -- 售卖价格
    local sellIcon = UI.Image:create()
    sellIcon:init("symbol_gaming_money.png")
    sellIcon:leftBottom(left, offsetBottomY)
    self:addChild(sellIcon)
    self._sellIcon = sellIcon

    local sellText = UI.Text:create()
    sellText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    -- sellText:setFontSize(14 * (1/0.8))
    sellText:centerLeft(5 + sellIcon:getContentSize().width)
    -- sellText:setFontColor(UI.FONT_COLOR_88_65_34)
    sellIcon:addChild(sellText)
    self._sellText = sellText

    -- 等级需求
    local level = UI.Text:create()
    level:init(UI.TEXT_DES_LEVEL_NEED, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
    self._levelText = level
    self:addChild(level)
    level:updateView()

    self._level = UI.Text:create()
    self._level:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    self._level:setTextLeft()
    self._level:leftBottom(self._levelText:getContentSize().width, 0)
    self._levelText:addChild(self._level)

    self._levelText:rightBottom(30 + self._level:getContentSize().width + holeWidth, offsetBottomY)

    self:initCompare(isBotttom)
    if (pngtype == EquipImageBgType.SMALL_TYPE or pngtype == EquipImageBgType.NO_GET_TYPE) then
        self:hideCompInfo()
    else
    end

    self:showSellPrice()
end

function EquipmentInfoArea:initCompare(isBotttom)
    local compareLayout = UI.Layout:create()
    compareLayout:init()
    compareLayout:setTouchEnable(true)
    compareLayout:setSize(205, 205)
    self:addChild(compareLayout)
    if isBotttom then
        compareLayout:rightBottom(0, 0)
    else
        compareLayout:centerRight(0)
    end
    self._compareLayout = compareLayout
    -- 添加背景
    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_bg_black.png")
    bgImage:setContentSize(205, 205)
    bgImage:setCapInsets(CCRectMake(14, 17, 4, 4))
    bgImage:setPosition(cc.p(102.5, 102.5))
    self._compareLayout:addChild(bgImage)

    local function onTouchBegan(touch, event)
        if (not tolua.isnull(compareLayout)) then
            if (compareLayout:isVisible() == false) then
                return false
            end
        end

        local posStarTouch = touch:getLocation()
        local point = compareLayout:convertToWorldSpace(cc.p(0, 0))
        local size = compareLayout:getContentSize()
        local width = size.width
        local height = size.height
        local rect = cc.rect(point.x, point.y, width, height)
        if cc.rectContainsPoint(rect, posStarTouch) then
            return true
        end
        return false
    end

    local function onTouchEnded(touch, event)
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_CANCELLED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, compareLayout)
    listener:setSwallowTouches(true)

    -- 装备后的差异
    local text = UI.Text:create()
    text:init(UI.TEXT_DES_EQUIPMENT_CONTRAST, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    text:centerUp(7)
    self._compareLayout:addChild(text)
    -- self._compText = text

    --
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(183, 1)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineUpImage:setPosition(cc.p(103, 171))
    self._compareLayout:addChild(lineUpImage, 4)

    self._compareScrollLayout = UI.Layout:create()
    self._compareScrollLayout:init()

    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(194 + 15, 155)
    scrollView:init()
    scrollView:leftBottom(7, 7)
    scrollView:addInnerNode(self._compareScrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarWidth(5)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    self._compareLayout:addChild(scrollView)
end

function EquipmentInfoArea:initLockORLink()
    local pngtype = self._pngType
    local startX = 20
    local startY = -34
    local offsetX = 50
    local haveLink = false
    local haveLock = false
    if (pngtype == EquipImageBgType.BAG_TYPE) then
    else
        haveLink = true
        startX = startX + offsetX
    end

    if (pngtype == EquipImageBgType.BAG_TYPE or pngtype == EquipImageBgType.NO_GET_TYPE) then
    else
        haveLock = true
    end

    if (haveLock) then
        local lockBtn = UI.Button:create()
        lockBtn:init("ui_goods_button_bg_up_0.png", "ui_goods_button_bg_up_1.png")
        lockBtn:addEventListener(UIEvent.BUTTON_CLICK, self, onActiveGoodsLockHandler)
        self:addChild(lockBtn)
        lockBtn:rightUp(startX, startY)
        lockBtn:setScale(0.9)

        local lock = UI.Image:create()
        lock:init(SPRITE_ITEM_ICON_UNLOCK)
        lock:center()
        lockBtn:addChild(lock, 20)
        self._lock = lock
        self._lockBtn = lockBtn
        startX = startX - offsetX
        if (self._lockShow == false) then
            self._lockBtn:setVisible(false)
        end
    end

    if (haveLink) then
        local link = UI.ButtonExt:create()
        -- 这里必须先设置，否者可能没有添加进去
        link:extInit("ui_iteminfo_btn_link.png", "ui_iteminfo_btn_link.png")
        link:init("ui_goods_button_bg_up_0.png", "ui_goods_button_bg_up_1.png")
        link:rightUp(startX, startY)
        startX = startX - offsetX
        link:addEventListener(UIEvent.BUTTON_CLICK, self, onActiveChatHandler)
        self:addChild(link)
        self.linkBG = link
        link:setScale(0.9)
    end

    self:refreshLinkOrLockPosition()
end

function EquipmentInfoArea:refreshLinkOrLockPosition()
    local startX = 20
    local offsetX = 50
    local startY = -34
    local haveLink = false
    local haveLock = false

    if (not tolua.isnull(self._lockBtn)) then
        haveLock = true
    end

    if (not tolua.isnull(self.linkBG)) then
        haveLink = true
        startX = startX + offsetX
    end

    if (haveLock) then
        self._lockBtn:rightUp(startX, startY)
        startX = startX - offsetX
    end

    if (haveLink) then
        self.linkBG:rightUp(startX, startY)
        startX = startX - offsetX
    end
end

-- 更新视图
function EquipmentInfoArea:onUpdateView(data, activeNum)
    --print("EquipmentInfoArea onUpdateView:")
    if (data) then
        -- 装备类型
        local equipType = data:getEquipmentType()

        if (equipType == PublicDefine.EQUIPMENT_TYPE.Fish and self.goodsbg) then
            self.goodsbg:setSpriteName("ui_iteminfo_role_banner_box3.png")
            local contentSize = self.goodsbg:getContentSize()
            self:setSize(contentSize.width, contentSize.height)

            self:hideCompInfo()

            self.lineUpImage:setPositionY(183)
            self.lineCenterImage:setPositionY(105)
            self.lineDownImage:setVisible(false)
            self._describe:leftUp(LEFT_SPACE, 175)

            self.scrollView:setVisible(false)

            if self._fishEquipmentDescribe then
                self._fishEquipmentDescribe:setVisible(true)
            end
        end



        local getIsTransform = data:getIsTransform()
        self._goodsData = data
        self:refreshHole()
        self:refreshGlyph()

        -- 强化次数
        local intensifyValue =
            string.format(UI.TEXT_1110391, data:getStrengthenLeve() .. "/" .. data:getStrengthenMaxLv())
        self._intensify:setText(intensifyValue)

        local rare = data:getGoodsRare()
        local goodsGroupType = data:getGoodsGroupType()
        -- 混沌虫洞装备特殊处理
        if self._goodsData.createLevel and self._goodsData.createLevel > 0 then
            -- rare = rare + 1
            rare = self._goodsData.randomGoodsRare 
        end
        self._spriteBg:setSpriteName(string.format("box_quality_%s_%s.png", goodsGroupType, rare))
        local starData = data:getStarData()
        if starData.goldStar ~= 0 then
            self._starLV:setString(string.format("+%s", starData.goldStar))
            self._star:setVisible(true)
            self._starLV:setVisible(true)
        elseif starData.silverStar ~= 0 then
            self._star:setVisible(true)
            self._starLV:setString(string.format("+%s", starData.silverStar))
            self._starLV:setVisible(true)
        end

        local iconName = data:getIconName()
        if (iconName) then
            if (DEBUG) then
                print(string.format("BagGrid odateView:nUp icon name is %s.", iconName))
            end

            self._iconSprite:setSpriteName(string.format(iconName))
            local iconSize = self._iconSprite:getContentSize()
        -- self._iconSprite:setScale(
        --     GRID_SIZE_WIDTH / iconSize.width,
        --     GRID_SIZE_HEIGHT/ iconSize.height
        -- )
        end

        -- 装备名字，目前先注释掉，美术看效果
        local name = data:getName()
        if not DEBUG then
            self._goodsName:setText(name)
            self._goodsName:autoAdapt()
        end
        self._equipIllusionIcon:setVisible(data:getIllusionID() ~= 0 and data:getIllusionID() ~= nil)

        --print("===equipmemt score",data:getCombatScore())
        -- 星级分数
        if (self._pngType ~= EquipImageBgType.NO_GET_TYPE) then
            self._goodsScore:setText(string.format("%s", data:getCombatScore()))
        else
            self._goodsScore:setText("???")
        end

        -- 装备类型
        -- local equipType = data:getEquipmentType()
        local equipmentType = ""
        local languageID = nil
        -- local LanguageManager = require("app.game.LanguageManager")
        if (equipType == PublicDefine.EQUIPMENT_TYPE.Helmet) then -- 头盔 1 8 4 3是角色左边的装备
            self._equipmentType:setSpriteName("icon-equip_large_21010010.png")
            languageID = 1111378
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Weapon) then -- 武器
            local weaponType = data:getWeaponType() -- 获取武器类型
            equipmentType = string.format(SPRITE_EQUIPMENT_WEAPON, equipType, weaponType)
            languageID = 1111375
            if (weaponType == 1) then
                languageID = 1111376
            elseif (weaponType == 2) then
                languageID = 1111375
            elseif (weaponType == 3) then
                languageID = 1111377
            end

            self._equipmentType:setSpriteName(equipmentType)
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Gloves) then -- 手套
            self._equipmentType:setSpriteName("icon-equip_large_21040010.png")
            languageID = 1111381
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Shoulders) then -- 肩甲
            self._equipmentType:setSpriteName("icon-equip_large_21030010.png")
            languageID = 1111379
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Amulet) then -- 项链
            self._equipmentType:setSpriteName("icon-equip_large_21060010.png")
            languageID = 1111383
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Ring) then -- 戒指
            self._equipmentType:setSpriteName("icon-equip_large_21070010.png")
            languageID = 1111384
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Chest) then -- 胸甲
            self._equipmentType:setSpriteName("icon-equip_large_21020010.png")
            languageID = 1111380
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Boots) then -- 鞋子
            self._equipmentType:setSpriteName("icon-equip_large_21050010.png")
            languageID = 1111382
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Fish) then -- 鱼竿
            self._equipmentType:setSpriteName("icon-equip_large_21090010.png")
            languageID = 1114672
        end

        if (languageID) then
            self._equipmentText:setText(string.format("%s", LanguageManager:getInstance():getLocalString(languageID)))
        end

        local attdata = nil
        if (self._pngType == EquipImageBgType.NO_GET_TYPE) then
            attdata = data:getDetailDescription(0)
        else
            attdata = data:getDetailDescription(activeNum)
        end

        local attrWidth = 205
        -- 基础属性，随机属性，附魔属性，套装属性，特殊属性
        local baseArr = attdata.baseArr
        local randomArr = attdata.randomArr
        local enchanting = attdata.enchanting
        local rateArr = attdata.rateArr -- 比例属性
        local equipmentArr = attdata.equipmentArr
        local specialArr = attdata.specialArr
        local primogemArr = nil
        if data.primogemId > 0 then
            primogemArr = attdata.primogemArr
        end

        local isRefine = data.refineNum > 0

        local equipRefineAttr = data.equipRefineAttr
        local tmp = string.split(data.equipRefineValue, ";")
        local equipRefineValue = string.split(tmp[data.refineNum] or "", ",")
        local createLevel = data.createLevel

        -- 装备右边的属性
        local POSITION_Y_TEXT = 118 - 5
        if baseArr then
            local leftIcon = LEFT_SPACE
            local leftValue = 180 - 80
            local refineValue = 210
            local createOneBaseAttr = function(attr, centerUp)
                local baseText = UI.Text:create()
                baseText:init(attr[1], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                baseText:setSize(70, 25)
                baseText:setTextLeft()
                baseText:leftUp(leftIcon, centerUp - baseText:getContentSize().height / 2)
                self:addChild(baseText)

                local layout = UI.Layout:create()
                layout:init()
                layout:enableAutoWidth()
                layout:enableAutoHeight()

                local isAtkAttr = ToolsUtil:attrNameToLanguageString("atk") == attr[1]
                local min, max
                if not isAtkAttr or not isRefine then
                    local baseValue = UI.Text:create()
                    baseValue:init(attr[2], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                    baseValue:setTextLeft()
                    baseValue:floatLeft(0)
                    local maxWidth = 222
                    if(baseValue:getContentSize().width > maxWidth) then 
                        baseValue:setFixLineWidth(maxWidth)
                    end
                    layout:addComponent(baseValue)
                else
                    local splits = string.split(attr[2], "-")
                    if #splits == 2 then --attack min ,max
                        min = splits[1]
                        max = splits[2]
                    end
                end
                

                if isRefine then
                    --修改主属性
                    if not isAtkAttr then
                        for j = 1, #equipRefineAttr do
                            if attr[4] == equipRefineAttr[j] then
                                local str =
                                    "(+" .. ToolsUtil:calculationAttrShowValue(attr[4], equipRefineValue[j]) .. ")"
                                if createLevel and createLevel > 0 then
                                    local attrType = attr[4]
                                    local config = ConfigManager:getEquipRefineValueByID(attrType)
                
                                    local refineCreateLevel = clone(createLevel)
                                    local levelLimiteList = string.split(data.equipRequireLvIntervals, ";")
                                    local randLevelLimite = string.split(levelLimiteList[8], ",")
                                    local lowerLimite = tonumber(randLevelLimite[1])
                                    local upperLimite = tonumber(randLevelLimite[2])
                                    refineCreateLevel = math.max(refineCreateLevel, lowerLimite + data.qualityGrade)
                                    refineCreateLevel = math.min(refineCreateLevel, upperLimite + data.qualityGrade)
                
                                    local alreadyAddNum = 0
                                    local equipRefineValueNew = config.firstequipRefineValueByLV[refineCreateLevel]
                                    if data.refineNum == 1 then
                                        alreadyAddNum = config.firstequipRefineValueByLV[refineCreateLevel]
                                        equipRefineValueNew = config.secondequipRefineValueByLV[refineCreateLevel]
                                    elseif data.refineNum == 2 then
                                        alreadyAddNum = config.secondequipRefineValueByLV[createLevel]
                                        
                                    end
                                    
                                    local add = equipRefineValueNew - (alreadyAddNum or 0)
                                    str = "(+" .. ToolsUtil:calculationAttrShowValue(attrType, add) .. ")"
                        
                                    if alreadyAddNum then
                                        str = "(+" .. ToolsUtil:calculationAttrShowValue(attrType, alreadyAddNum) .. ")"
                                    else
                                        str = ""
                                    end
                                end
                                local baseValue = UI.Text:create()
                                baseValue:init(str, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71)
                                baseValue:setTextLeft()
                                baseValue:floatLeft(1)
                                layout:addComponent(baseValue)
                            end
                        end
                    else
                        local addMin, addMax = 0,0
                        for j = 1, #equipRefineAttr do
                            if PublicDefine.ATTR_TYPE.atkMin == equipRefineAttr[j] then
                                addMin = equipRefineValue[j]
                            elseif PublicDefine.ATTR_TYPE.atkMax == equipRefineAttr[j] then
                                addMax = equipRefineValue[j]
                            end
                        end

                        local baseValue = UI.Text:create()
                        baseValue:init(min, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                        baseValue:setTextLeft()
                        baseValue:floatLeft(0)
                        layout:addComponent(baseValue)

                        if addMin then
                            local baseValue = UI.Text:create()
                            baseValue:init("(+" .. addMin .. ")", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71)
                            baseValue:setTextLeft()
                            baseValue:floatLeft(1)
                            layout:addComponent(baseValue)
                        end

                        local baseValue = UI.Text:create()
                        baseValue:init("-"..max, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                        baseValue:setTextLeft()
                        baseValue:floatLeft(0)
                        layout:addComponent(baseValue)

                        if addMax then
                            local baseValue = UI.Text:create()
                            baseValue:init("(+" .. addMax .. ")", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71)
                            baseValue:setTextLeft()
                            baseValue:floatLeft(1)
                            layout:addComponent(baseValue)
                        end
                    end
                end
                self:addChild(layout)
                layout:leftUp(leftValue, centerUp - layout:getContentSize().height / 2)
            end


            for i, data in ipairs(baseArr) do
                if #baseArr == 3 then
                    local centerUp = POSITION_Y_TEXT + (i - 1) * TEXT_VALUE_ROW - 27 + 10 + 11.5
                    createOneBaseAttr(data, centerUp)
                end
                if #baseArr == 2 then
                    local centerUp = POSITION_Y_TEXT + (i - 1) * TEXT_VALUE_ROW - 7 + 11.5
                    createOneBaseAttr(data, centerUp)
                end
                if #baseArr == 1 then
                    local centerUp = POSITION_Y_TEXT + (i - 1) * TEXT_VALUE_ROW + 1 + 11.5
                    createOneBaseAttr(data, centerUp)
                end
            end
        end

        -- 随机属性
        local k = 0
        local oneHeight = TEXT_VALUE_ROW
        local totalHeight = 0
        -- print("--随机属性")
        -- dump(randomArr)
        if (self._pngType == EquipImageBgType.NO_GET_TYPE) then
            randomArr = {}

            local attrNum = 0
            local goodRare = self._goodsData:getGoodsRare()
            if (goodRare == PublicDefine.GOODS_RARE.RARE_WHITE_1) then
                attrNum = 0
            elseif (goodRare == PublicDefine.GOODS_RARE.RARE_BLUE_2) then
                attrNum = 1
            elseif (goodRare == PublicDefine.GOODS_RARE.RARE_GOLDEN_3) then
                attrNum = 2
            elseif (goodRare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4) then
                attrNum = 3
            elseif (goodRare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_BORDERS_5) then
                -- else
                --     attrNum = 4
                -- end
                -- if(equipmentArr) then
                attrNum = 2
            elseif (goodRare == PublicDefine.GOODS_RARE.RARE_DARKRED) then
                attrNum = 3
            else
                attrNum = tonumber(goodRare) - 1
            end

            for i = 1, attrNum do
                table.insert(randomArr, {"???", ""})
            end
        end

        local centerOffsetUp = 13.5
        local pointOffsetY = -1

        local leftOffset = 11
        leftOffset = LEFT_SPACE
        local pointBaseOffset = 3
        local pointBaseValueOffset = 13
        if randomArr then
            for i, data in ipairs(randomArr) do
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                local baseText = UI.Text:create()
                baseText:init(string.format("%s", data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                baseText:setTextLeft()
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                self._scrollLayout:addChild(baseText)

                local baseValue = UI.Text:create()
                baseValue:init(
                    string.format("%s", data[2]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_41_41_45
                )
                baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)
                self._scrollLayout:addChild(baseValue)

                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                    baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth, textUp)
                end

                local hammer = UI.Image:create()
                hammer:init(HAMMER)
                hammer:leftUp(
                    leftOffset + pointBaseValueOffset + baseText._width + baseValue._width + 3,
                    centerUp - hammer:getContentSize().height / 2
                )
                self._scrollLayout:addChild(hammer)
                hammer:setVisible(data[3])

                totalHeight = totalHeight + baseText:getContentSize().height
                k = i
            end
        end

        if data.primogemId > 0 and primogemArr then
            for i, data in ipairs(primogemArr) do
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                local baseText = UI.Text:create()
                baseText:init(string.format("%s", data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_40_62_106)
                baseText:setTextLeft()
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                self._scrollLayout:addChild(baseText)

                local baseValue = UI.Text:create()
                baseValue:init(
                    string.format("%s", data[2]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_40_62_106
                )
                baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)
                self._scrollLayout:addChild(baseValue)

                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                    baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth, textUp)
                end

                local hammer = UI.Image:create()
                hammer:init(HAMMER)
                hammer:leftUp(
                    leftOffset + pointBaseValueOffset + baseText._width + baseValue._width + 3,
                    centerUp - hammer:getContentSize().height / 2
                )
                self._scrollLayout:addChild(hammer)
                hammer:setVisible(data[3])

                totalHeight = totalHeight + baseText:getContentSize().height
                k = i
            end
        end

        -- 附魔属性
        -- print("--附魔属性")
        -- dump(enchanting)
        if enchanting then
            local centerUp = totalHeight + centerOffsetUp

            local point = UI.Image:create()
            point:init(SPRITE_EQUIPMENT_AREA_POINT)
            point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
            self._scrollLayout:addChild(point)

            local baseText = UI.Text:create()
            baseText:init(enchanting[1], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_40_62_106)
            local textUp = centerUp - baseText:getContentSize().height / 2
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
            baseText:setTextLeft()
            self._scrollLayout:addChild(baseText)

            local baseValue = UI.Text:create()
            baseValue:init(enchanting[2], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_40_62_106)
            baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)
            self._scrollLayout:addChild(baseValue)

            if (baseText._width > attrWidth) then
                baseText:setWidth(attrWidth)
                baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth, textUp)
            end

            totalHeight = totalHeight + baseText:getContentSize().height
            k = k + 1
        end
        --  比例属性
        -- print("--比例属性")
        -- dump(rateArr)
        if rateArr then
            for i, data in ipairs(rateArr) do
                local centerUp = totalHeight + centerOffsetUp
                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                local baseText = UI.Text:create()
                baseText:init(data[1], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                baseText:setTextLeft()
                self._scrollLayout:addChild(baseText)

                local baseValue = UI.Text:create()
                baseValue:init(data[2], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
                baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)
                self._scrollLayout:addChild(baseValue)

                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                    baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth, textUp)
                end

                totalHeight = totalHeight + baseText:getContentSize().height
                k = k + 1
            end
        end

        -- 套装属性
        -- print("--套装属性")
        -- dump(equipmentArr)
        if equipmentArr then
            local centerUp = totalHeight + centerOffsetUp

            local point = UI.Image:create()
            point:init(SPRITE_EQUIPMENT_AREA_POINT_SUIT)
            point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
            self._scrollLayout:addChild(point)

            local equipmentName = UI.Text:create()
            equipmentName:init(
                string.format("%s", equipmentArr.setName),
                UI.FONT_STANDARD,
                UI.FONT_SIZE_16PX,
                UI.FONT_COLOR_42_103_85
            )
            local textUp = centerUp - equipmentName:getContentSize().height / 2
            equipmentName:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
            self._scrollLayout:addChild(equipmentName)

            local equipmentNum = UI.Text:create()
            equipmentNum:init(
                string.format("%s", equipmentArr.activeStr),
                UI.FONT_STANDARD,
                UI.FONT_SIZE_16PX,
                UI.FONT_COLOR_42_103_85
            )
            equipmentNum:leftUp(leftOffset + pointBaseValueOffset + equipmentName._width, textUp)
            self._scrollLayout:addChild(equipmentNum)

            k = k + 1
            totalHeight = totalHeight + equipmentName:getContentSize().height

            for i = 1, #equipmentArr.activationArr do
                local oneAttr = equipmentArr.activationArr[i]
                local centerUp = totalHeight + centerOffsetUp
                -- 标点
                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT_SUIT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                -- 描述
                local baseText = UI.Text:create()
                baseText:init(
                    string.format("%s", oneAttr[1]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_42_103_85
                )
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                baseText:setTextLeftUp()
                self._scrollLayout:addChild(baseText)

                -- 数值
                local baseValue = UI.Text:create()
                baseValue:init(
                    string.format("[%s]", oneAttr[2]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_42_103_85
                )
                baseValue:setSize(30, 20)
                baseValue:setTextLeftUp()
                baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)

                self._scrollLayout:addChild(baseValue)

                -- 根据相关数据来计算激活个数
                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                    baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth, textUp)
                end

                totalHeight = totalHeight + baseText:getContentSize().height
            end

            for i = 1, #equipmentArr.noActivationArr do
                local oneAttr = equipmentArr.noActivationArr[i]
                local centerUp = totalHeight + centerOffsetUp
                -- 标点
                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT_SUIT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                -- 描述
                local baseText = UI.Text:create()
                baseText:init(
                    string.format("%s", oneAttr[1]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_102_102_102
                )
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                baseText:setTextLeftUp()
                self._scrollLayout:addChild(baseText)

                -- 数值
                local baseValue = UI.Text:create()
                baseValue:init(
                    string.format("[%s]", oneAttr[2]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_102_102_102
                )
                -- baseValue:setFontSize(15)
                -- baseValue:setFontColor(UI.FONT_COLOR_107_99_91)
                baseValue:setSize(30, 20)
                baseValue:setTextLeftUp()
                baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)

                self._scrollLayout:addChild(baseValue)

                -- 根据相关数据来计算激活个数
                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                    baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth, textUp)
                end
                totalHeight = totalHeight + baseText:getContentSize().height
            end
        end

        -- 特殊属性
        -- print("--特殊属性")
        -- dump(specialArr)
        if specialArr then
            for i, data in ipairs(specialArr) do
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                local baseText = UI.Text:create()
                baseText:init(string.format("%s", data), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
                baseText:setTextLeft()
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                baseText:setLineSpacing(-4)
                baseText:setWidth(245)
                baseText:setText(string.format("%s", data))
                self._scrollLayout:addChild(baseText)

                k = k + 1

                totalHeight = totalHeight + baseText:getContentSize().height
            end
        end

        -- 添加宝石叠加的属性
        local gemNormalDesArr = {}
        local gemSpecialDesArr = {}
        local holeDatas = data:getHoleDatas()
        for _, holeData in ipairs(holeDatas) do
            local gemStoneData = holeData:getGemStoneData()
            if (gemStoneData) then
                local arr = gemStoneData:getNormalDetailDescription()
                for k, v in ipairs(arr) do
                    table.insert(gemNormalDesArr, v)
                end

                local specialDes = gemStoneData:getSpecialDetailDescription()
                if (specialDes) then
                    table.insert(gemSpecialDesArr, specialDes)
                end

                local linkDetailArr, isUnlock = gemStoneData:getLinkDetailDescription()
                if isUnlock then
                    for k, v in ipairs(linkDetailArr) do
                        table.insert(gemNormalDesArr, v)
                    end
                end
            end
        end

        if gemNormalDesArr then
            for i, data in ipairs(gemNormalDesArr) do
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                local baseText = UI.Text:create()
                baseText:init(
                    string.format("%s", data[1]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_85_49_114
                )
                baseText:setTextLeft()
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                if (baseText:getContentSize().width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setText(string.format("%s", data[1]))
                end
                self._scrollLayout:addChild(baseText)

                local baseValue = UI.Text:create()
                baseValue:init(
                    string.format("%s", data[2]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_85_49_114
                )
                baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)
                self._scrollLayout:addChild(baseValue)

                totalHeight = totalHeight + baseText:getContentSize().height
                k = k + 1
            end
        end

        if gemSpecialDesArr then
            for i, specialDes in ipairs(gemSpecialDesArr) do
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                local baseText = UI.Text:create()
                baseText:init(specialDes, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
                baseText:setTextLeft()
                baseText:leftUp(
                    leftOffset + pointBaseOffset + point._width,
                    centerUp - baseText:getContentSize().height / 2
                )
                baseText:setWidth(attrWidth + 20)
                baseText:setText(specialDes)
                self._scrollLayout:addChild(baseText)

                totalHeight = totalHeight + baseText:getContentSize().height
                k = k + 1
            end
        end

        -- 添加雕纹属性
        local glyphNormalDesArr = {}
        local glyphSpecialDesArr = {}
        local glyphData = nil
        local equipmentGlyphDatas = data:getGlyphDatas()
        for _, equipmentGlyphData in ipairs(equipmentGlyphDatas) do
            glyphData = equipmentGlyphData:getGlyphData()
            if (glyphData) then
                local arr = glyphData:getNormalDetailDescription()
                for k, v in ipairs(arr) do
                    table.insert(glyphNormalDesArr, v)
                end
            end
        end

        if glyphNormalDesArr then
            for i, data in ipairs(glyphNormalDesArr) do
                local attributeConfig = ConfigManager:getGlyphAttributeByID(tonumber(data[3]))
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)

                local baseText = UI.Text:create()
                baseText:init(
                    string.format("%s", data[1]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_85_49_114
                )
                baseText:setTextLeft()
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                if (baseText:getContentSize().width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setText(string.format("%s", data[1]))
                end
                self._scrollLayout:addChild(baseText)

                local baseValue = UI.Text:create()
                
                local pInfoArea = UI.GlyphInfoArea:create()
                local attributeValueMax = 0
                if self._goodsData.heroData then
                    attributeValueMax = pInfoArea:getAttributeMaxValueFromeOther(attributeConfig, glyphData, self._goodsData.heroData)
                else
                    attributeValueMax = pInfoArea:getAttributeMaxValue(attributeConfig, glyphData)
                end

                baseValue:init(
                    string.format("%s",data[2]).." ("..attributeValueMax..")",
                    --string.format("%s", data[2]),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    UI.FONT_COLOR_85_49_114
                )
                baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)
                self._scrollLayout:addChild(baseValue)

                totalHeight = totalHeight + baseText:getContentSize().height
                k = k + 1
            end
        end

        -- layout 的size按照内容而定
        self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)
        -- end string.format("%s",data:getDescription())

        self._describe:setText(string.format("%s", data:getDescription()))
        -- print("====穿戴等级---描述信息",data:getWearLV(),data:getDescription())
        local equipShowLevel = data:getWearLV()
        if self._goodsData.createLevel and self._goodsData.createLevel > 0 then
            equipShowLevel = self._goodsData.createLevel - self._goodsData.qualityGrade--RoleDataManager:getMaster():getLevel()
        end
        local level, reinLv = RoleDataManager:getUIShowLvByItemData(equipShowLevel)
        local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
        self._level:setText(string.format("%s", showLv))
        self._level:updateView()
        if (self._pngType == EquipImageBgType.BAG_TYPE or self._pngType == EquipImageBgType.NO_GET_TYPE) then
        else
            if data:getIsLock() then
                self._lock:setSpriteName(SPRITE_ITEM_ICON_LOCK)
                self._lockstate = true
            else
                self._lockstate = false
                self._lock:setSpriteName(SPRITE_ITEM_ICON_UNLOCK)
            end
        end

        self._goodsName:updateView()
        self._goodsScore:updateView()
        self._equipmentType:updateView()
        self._describe:updateView()
        if (self._pngType == EquipImageBgType.SMALL_TYPE or self._pngType == EquipImageBgType.NO_GET_TYPE) then
            self._levelText:rightBottom(
                30 + self._level:getContentSize().width + holeWidth,
                self._levelText:getBottom()
            )
        else
            self._levelText:rightBottom(
                30 + self._level:getContentSize().width + holeWidth,
                self._levelText:getBottom()
            )
        end

        self:refreshLock()

        if RoleDataManager:getMaster():getLevel() < data:getWearLV() then
            self._level:setFontColor(UI.FONT_COLOR_80_5_5)
            self._levelText:setFontColor(UI.FONT_COLOR_80_5_5)
        else
            self._level:setFontColor(UI.FONT_COLOR_41_41_45)
            self._levelText:setFontColor(UI.FONT_COLOR_41_41_45)
        end

        self:showSellPrice()
        self:showRecastFlag()
    end
end

-- 初始化插槽
function EquipmentInfoArea:initHole()
    for index = 1, 3 do
        local holeNode = EquipmentHoleInfoArea:create()
        holeNode:init()
        holeNode.index = index

        self.holeNodeArr = self.holeNodeArr or {}
        table.insert(self.holeNodeArr, holeNode)

        holeNode:center()
        self:addChild(holeNode)
    end
end

-- 刷新插槽
function EquipmentInfoArea:refreshHole()
    local unlock = self._goodsData:getIsUnlockColorHole()
    local holeDatas = self._goodsData:getHoleDatas()

    for k, node in ipairs(self.holeNodeArr) do
        if (not tolua.isnull(node)) then
            node:setVisible(false)
        end
    end

    local normalStartX = 5
    local colorStartX = 8
    local offsetX = 60

    for k, holeData in ipairs(holeDatas) do
        if (holeData) then
            local holeNode = self.holeNodeArr[k]
            if (holeNode == nil) then
                holeNode = EquipmentHoleInfoArea:create()
                holeNode:init()
                holeNode.index = index

                self.holeNodeArr = self.holeNodeArr or {}
                table.insert(self.holeNodeArr, holeNode)
                self:addChild(holeNode)
            end

            if (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then
                holeNode:rightBottom(colorStartX, -47)
            else
                holeNode:leftBottom(normalStartX, -47)
                normalStartX = normalStartX + offsetX
            end
            if (not tolua.isnull(holeNode)) then
                holeNode:setGoodsData(self._goodsData)
                holeNode:setVisible(true)
                holeNode:refreshHole(holeData, unlock)
            end
        end
    end
end

-- 初始化雕纹槽
function EquipmentInfoArea:initGlyph()
    local glyphNode = EquipmentGlyphInfoArea:create()
    glyphNode:init()
    glyphNode:center(118, 163)
    self:addChild(glyphNode, 20)
    self.glyphNode = glyphNode
end

-- 刷新雕纹
function EquipmentInfoArea:refreshGlyph()
    local equipmentGlyphDatas = self._goodsData:getGlyphDatas()

    if (not tolua.isnull(self.glyphNode)) then
        self.glyphNode:setVisible(false)
    end

    for _, equipmentGlyphData in ipairs(equipmentGlyphDatas) do
        local glyphData = equipmentGlyphData:getGlyphData()
        if (glyphData) then
            if not self.glyphNode then
                self:initGlyph()
            end
            if (not tolua.isnull(self.glyphNode)) then
                self.glyphNode:setVisible(true)
                self.glyphNode:refreshGlyph(glyphData)
            end

        end
    end
end

function EquipmentInfoArea:getHoleWidth()
    -- if(self._goodsData) then
    --     local holeDatas = self._goodsData:getHoleDatas()
    --     if(holeDatas and #holeDatas > 0) then
    --         return 65
    --     end
    -- end

    return 0
end

-- 关闭锁定标志
function EquipmentInfoArea:closeLockFlag()
    self._lockShow = false
    if (self._lock) then
        self._lock:setVisible(false)
    end

    if (self._lockBtn) then
        self._lockBtn:setVisible(false)
    end

    self:refreshLinkOrLockPosition()
end

--打开锁定标志
function EquipmentInfoArea:openLockFlag()
    self._lockShow = true
    if (self._lock) then
        self._lock:setVisible(true)
    end

    if (self._lockBtn) then
        self._lockBtn:setVisible(true)
    end
    self:refreshLinkOrLockPosition()
end

function EquipmentInfoArea:handlePercent(value)
    local endValue = value
    if (value < 0 and value > -0.1) then
        endValue = -0.1
    elseif (value < 0.1 and value > 0) then
        endValue = 0.1
    end

    return endValue
end

-- 试装 属性变化区域
function EquipmentInfoArea:updateInfo(data, isLeft)
    local pngtype = self._pngType
    if data then
        if (pngtype == EquipImageBgType.SMALL_TYPE) then
        else
            self:showCompInfo()
        end
        if (self._compareLayout:isVisible()) then
            if self._infoBottom then
                if (isLeft) then
                    self._compareLayout:leftBottom(-204, 0)
                else
                    self._compareLayout:rightBottom(-204, 0)
                end
            else
                if (isLeft) then
                    self._compareLayout:centerLeft(-200)
                else
                    self._compareLayout:centerRight(-200)
                end
            end
        else
            self._compareLayout:centerRight(-winSize.width)
            return
        end

        local attack = data.attackPower
        local spellEffect = data.magicEffect
        local tough = data.toughness
        local unEquipArr = data.unEquipArr
        local tryEquipmentData = data.tryEquipmentData

        --  获取英雄数据
        local roleData = RoleDataManager:getMaster()
        self._attackStrength = roleData:getAttackStrength()
        self._spellEffect = roleData:getSpellEffect()
        self._tough = roleData:getTough()

        local attackValue = (attack - self._attackStrength) / self._attackStrength * 100.0
        local spellEffectValue = (spellEffect - self._spellEffect) / self._spellEffect * 100.0
        local toughValue = (tough - self._tough) / self._tough * 100.0

        attackValue = self:handlePercent(attackValue)
        spellEffectValue = self:handlePercent(spellEffectValue)
        toughValue = self:handlePercent(toughValue)

        -- 搜集异常
        -- if (math.abs(attackValue) > 10000) then
        --     printError("try equipment warn  attackValue = %.2f", attackValue)
        -- end

        -- if (math.abs(spellEffectValue) > 10000) then
        --     printError("try equipment warn  spellEffectValue = %.2f", spellEffectValue)
        -- end

        -- if (math.abs(toughValue) > 10000) then
        --     printError("try equipment warn  toughValue = %.2f", toughValue)
        -- end

        local startX = 0
        local startY = 0
        local offsetY = 20
        -- 三围
        local value = ""
        local state = 1
        if attackValue > 0 then
            value = string.format("+%s%%", string.format("%0.1f", attackValue))
        elseif attackValue < 0 then
            state = -1
            value = string.format("%s%%", string.format("%0.1f", attackValue))
        else
            value = "0%"
            state = 0
        end

        local layout = self:createCompareOneValue(UI.TEXT_DES_ATTACK_STRENGTH, value, state)
        layout:leftUp(startX, startY)
        self._compareScrollLayout:addChild(layout)
        startY = startY + offsetY

        value = ""
        state = 1
        if spellEffectValue > 0 then
            value = string.format("+%s%%", string.format("%0.1f", spellEffectValue))
        elseif spellEffectValue < 0 then
            state = -1
            value = string.format("%s%%", string.format("%0.1f", spellEffectValue))
        else
            value = "0%"
            state = 0
        end
        local layout = self:createCompareOneValue(UI.TEXT_DES_MAGIC_STRENGTH, value, state)
        layout:leftUp(startX, startY)
        self._compareScrollLayout:addChild(layout)
        startY = startY + offsetY

        value = ""
        state = 1
        if toughValue > 0 then
            value = string.format("+%s%%", string.format("%0.1f", toughValue))
        elseif toughValue < 0 then
            state = -1
            value = string.format("%s%%", string.format("%0.1f", toughValue))
        else
            value = "0%"
            state = 0
        end
        local layout = self:createCompareOneValue(UI.TEXT_DES_TENACITY_STRENGTH, value, state)
        layout:leftUp(startX, startY)
        self._compareScrollLayout:addChild(layout)
        startY = startY + offsetY

        -- 装备之间的属性变化 TODO
        local addAllAttr = nil
        local reduceAllAttr = nil
        if (unEquipArr) then
            if (unEquipArr[1]) then
                reduceAllAttr = unEquipArr[1]:getAllAttr()
            end
        end
        if (tryEquipmentData) then
            addAllAttr = tryEquipmentData:getAllAttr()
        end

        local attrPriorityAttr = ToolsUtil:getAttrPriority()
        if (attrPriorityAttr) then
            local allAttrArr = {}

            for _, key in pairs(attrPriorityAttr) do
                local keyValue = PublicDefine.ATTR_TYPE[key]

                local oneAttr = {}
                oneAttr.key = key

                oneAttr.baseValue = 0

                if (addAllAttr) then
                    for k, equipmentArr in ipairs(addAllAttr) do
                        if
                            equipmentArr:getAttrType() == keyValue and
                                equipmentArr:getAttrValueType() == PublicDefine.VALUE_TYPE.Value
                         then
                            oneAttr.baseValue = oneAttr.baseValue + equipmentArr:getAttrValue()
                        end
                    end
                end

                if (reduceAllAttr) then
                    for k, equipmentArr in ipairs(reduceAllAttr) do
                        if
                            equipmentArr:getAttrType() == keyValue and
                                equipmentArr:getAttrValueType() == PublicDefine.VALUE_TYPE.Value
                         then
                            oneAttr.baseValue = oneAttr.baseValue - equipmentArr:getAttrValue()
                        end
                    end
                end
                if (oneAttr.baseValue ~= 0) then
                    table.insert(allAttrArr, oneAttr)
                end
            end

            if (#allAttrArr > 0) then
                for _, attr in ipairs(allAttrArr) do
                    local state = -1
                    if (attr.baseValue > 0) then
                        state = 1
                    elseif (attr.baseValue == 0) then
                        state = 0
                    end

                    local valueStr =
                        ToolsUtil:calculationAttrShowValue(PublicDefine.ATTR_TYPE[attr.key], attr.baseValue)
                    if (state >= 0) then
                        valueStr = string.format("+%s", valueStr)
                    end

                    local layout =
                        self:createCompareOneValue(ToolsUtil:attrNameToLanguageString(attr.key), valueStr, state)
                    layout:leftUp(startX, startY)
                    self._compareScrollLayout:addChild(layout)
                    startY = startY + offsetY
                end
            end
        end

        self._compareScrollLayout:setSize(182, startY)
    end
end

function EquipmentInfoArea:createCompareOneValue(name, value, state)
    -- print("EquipmentInfoArea:createCompareOneValue", name, value, state)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(182, 20)

    -- value = "+437833%"

    local nameTxt = UI.Text:create()
    nameTxt:init(name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    -- nameTxt:setTextLeft()
    -- nameTxt:setWidth(70)
    nameTxt:centerLeft(2)
    layout:addChild(nameTxt)

    local valueTxt = UI.Text:create()
    if (state > 0) then
        valueTxt:init(tostring(value), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
    elseif (state < 0) then
        valueTxt:init(tostring(value), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_208_50_60)
    else
        valueTxt:init(tostring(value), UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    end
    valueTxt:centerRight(20)
    valueTxt:setFixLineWidth(76)
    valueTxt:updateView()
    layout:addChild(valueTxt)

    -- 标签
    if (state ~= 0) then
        local pointImage = UI.Image:create()
        if (state > 0) then
            pointImage:init("ui_information_arrow_up.png")
        else
            pointImage:init("ui_information_arrow_dwon.png")
        end
        pointImage:centerRight(0)
        layout:addChild(pointImage)
    end

    return layout
end

-- 隐藏装备对比
function EquipmentInfoArea:hideCompInfo()
    if (self._compareLayout) then
        self._compareLayout:setVisible(false)
        self._compareLayout:centerRight(-winSize.width)
    end

    -- self._compText:hide()
    -- self._attackText:hide()
    -- self._magicText:hide()
    -- self._tenacityText:hide()
    -- self._attackCompValue:hide()
    -- self._magicCompValue:hide()
    -- self._tenacityCompValue:hide()
    -- self._compText:hide()
    -- self:setSize(width, 429)
end

-- 显示装备对比
function EquipmentInfoArea:showCompInfo()

    local canVisible = self:goodsDataCanVisible()

    if not canVisible then
        return
    end

    if (self._compareLayout) then
        self._compareLayout:setVisible(true)
    end

    -- self._compText:show()
    -- self._attackText:show()
    -- self._magicText:show()
    -- self._tenacityText:show()
    -- self._attackCompValue:show()
    -- self._magicCompValue:show()
    -- self._tenacityCompValue:show()
    -- self._compText:show()
    -- -- self._bg:centerUp( self._bgheight - 3)
    -- self._intensify:setVisible(true)
    self:showStrength()
end

function EquipmentInfoArea:showStrength()
    -- body
    if (not tolua.isnull(self._intensify)) then
        -- if (self._pngType == EquipImageBgType.SMALL_TYPE  or self._pngType == EquipImageBgType.NO_GET_TYPE) then
        --     self._intensify:leftBottom(LEFT_SPACE, 20)
        -- else
        --     self._intensify:leftBottom(LEFT_SPACE, 4)
        -- end

        local canVisible = self:goodsDataCanVisible()

        if canVisible then
            self._intensify:setVisible(true)
        end
    end
end

function EquipmentInfoArea:goodsDataCanVisible()
    local canVisible = true
    if  self._goodsData then
        local equipType = self._goodsData:getEquipmentType()
        if (equipType == PublicDefine.EQUIPMENT_TYPE.Fish) then
            canVisible = false
        end
    end
    return canVisible
end

function EquipmentInfoArea:showSellPrice()
    if (self._sellText and self._sellIcon) then
        if (self._showSellPrice) then
            if (self._goodsData) then
                self._sellText:setText(tostring(self._goodsData:getSellPrice()))
                self._sellIcon:setVisible(true)
                self._sellText:setVisible(true)
            end
        else
            self._sellIcon:setVisible(false)
            self._sellText:setVisible(false)
        end
    end
end

function EquipmentInfoArea:setHideLink(isHideLink)
    if isHideLink and self.linkBG then
        self.linkBG:hide()

        self:refreshLinkOrLockPosition()
    end
end

--展现重铸标识 可重铸、不可重铸、已重铸
function EquipmentInfoArea:showRecastFlag()
    if self._goodsData == nil then
        return
    end
    local recast = self._goodsData:getEquipRecastData()
    if recast then
        local flag = self:getChildByName("RecastFlag")
        if flag then
            flag:removeFromParent()
        end
        local imageName = "ui_information_recasting1.png"
        if self._goodsData.recastNum ~= nil and self._goodsData.recastNum > 0 then
            imageName = "ui_information_recasting.png"
        else
            imageName = "ui_information_recasting1.png"
        end
        flag = UI.Image:create()
        flag:init(imageName)
        flag:rightUp(10, 15)
        flag:setName("RecastFlag")
        self:addChild(flag, 5)
        self._goodsName:setWidth(180)

        if self._goodsData.recastNum ~= nil and self._goodsData.recastNum > 0 then
            local number = UI.Text:create()
            number:init(self._goodsData.recastNum .. "", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_51_51_51)
            number:center()
            flag:addChild(number)
        end
    end
end
