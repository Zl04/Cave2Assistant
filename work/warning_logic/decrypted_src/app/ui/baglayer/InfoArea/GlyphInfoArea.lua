-- GlyphInfoArea.lua
-- Author:siyu
-- 2023年9月19日
-- Using:雕文详情

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.ScrollView"

UI = UI or {}

local GlyphInfoArea = class("GlyphInfoArea", UI.HWBtnComponent)
UI.GlyphInfoArea = GlyphInfoArea

local PACKET_TYPE = PublicDefine.PACKET_TYPE 

-- private:
local DEBUG = false
local DEBUG_DRAW = true
-- 尺寸
local width = 324
local height = 279
local TEXT_VALUE_SPACE = 10 
local TEXT_VALUE_ROW   = 20 
local POSITION_X_TEXT  = 115 
local POSITION_Y_TEXT  = 90
local GRID_SIZE_WIDTH  = 74 
local GRID_SIZE_HEIGHT = 74 
-- 描述信息的宽度
local TEXT_DESCRIBE_WIDTH = 250
-- 一排的Y坐标
local WEIGHT_POSTION_Y = 80

local SPRITE_GRID_RARE_1 = "box_quality_0_1.png"
local SPRITE_EQUIPMENT_NAME = "icon-equip_large_210%s0010.png"
local SPRITE_EQUIPMENT_WEAPON = "icon-equip_large_210%s0010_%s.png"

-- 属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT = "ui_iteminfo_icon_point_01.png"

-- 锁按钮的三个状态
local SPRITE_ITEM_ICON_LOCK = "ui_iteminfo_btn_locked.png"
local SPRITE_ITEM_ICON_UNLOCK = "ui_iteminfo_btn_unlock.png"

-- 布局的宽
local LAYOUT_SIZE_WIDTH  = 300 
-- 顶部区域的高
local UPLAYOUT_SIZE_HEIGHT = 180
local SCROLLLAYOUT_SIZE_HEIGHT = 140

local BAG_GRID_LIST_POSX = 8
local BAG_GRID_LIST_POSY = 8
local LEFT_SPACE = 30

local ATTACK_VALUE_SIZE_WIDTH = 100
local ATTACK_VALUE_SIZE_HEIGHT = 20
local LEFT_SPACE_ATTACK_VALUE = 120

local VIRTUAL_ITEM_TYPE = PublicDefine.VIRTUAL_ITEM_TYPE

local ATTRIBUTE_COLOR = {
    BULE = {r = 43, g = 65, b = 106},
    GOLD = {r = 122, g = 102, b = 56},
    DARK_GOLD = {r = 179, g = 101, b = 44},
    PURPLE = {r = 86, g = 50, b = 115},
}

local ATTRIBUTE_PERCENT = {
    BULE = 0.4,
    GOLD = 0.8,
    DARK_GOLD = 1.0,
    PURPLE = 1.0,
}

-- 资源
local COM_RES_LIST = {
    "ui_common_information.plist",
}

-- 构造函数
function GlyphInfoArea:ctor()

    GlyphInfoArea.super.ctor(self, UIType.GLYPH_INFO_AREA, COM_RES_LIST, width, height)
    
    -- 装备名字
    self._goodsName = nil 
    self._spriteBg = nil 
    -- 图标
    self._iconSprite = nil 
    -- 描述信息
    self._describe = nil 
    self._level   = nil 
    self._lock = nil 
    -- 是否显示锁定标志
    self._lockShow = true
    -- false未锁定，true锁定
    self._lockstate = false
    -- 滑动窗口的显示信息
    self._scrollLayout = nil 
    -- 物品信息
    self._goodsData = nil 

    self._goodsDes = nil

    self._packetType = PACKET_TYPE.PACKET_GLYPH
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)    
end

-- 析构函数
function GlyphInfoArea:dtor()

    -- 装备名字
    self._goodsName = nil 
    self._goodsDes = nil
    self._spriteBg = nil 
    -- 图标
    self._iconSprite = nil 
    -- 描述信息
    self._describe = nil 
    self._level   = nil 
    self._lock = nil 
    -- 是否显示锁定标志
    self._lockShow = true
    -- false未锁定，true锁定
    self._lockstate = false 
    self._scrollLayout = nil
    self._goodsData = nil  

    self._packetType = nil
    
    self._point1 = nil 
    self._baseText1 = nil 
    self._bgheight = 0 

    -- 是否显示售卖价格，这里只会在商店层显示
    self._showSellPrice = false

    GlyphInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- public:
-- 初始化
function GlyphInfoArea:init(data)
    self._goodsData = data

    GlyphInfoArea.super.init(self, data)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
end

-- 销毁
function GlyphInfoArea:onDestroy()
    self._packetType = nil
end


function GlyphInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function GlyphInfoArea:getGoodsGrid()
    return self._goodsGrid
end


-- 设置的操作的包裹类型
function GlyphInfoArea:setPacketType(packetType)
    self._packetType = packetType
end

-- 显示价格
function GlyphInfoArea:setShowSellPrice(flag)
    self._showSellPrice = flag
    self:showSellPrice()
end

-- 锁定状态改变
function GlyphInfoArea:lockStatusChange(data)
    UI.WaitingLayer:hideWaiting()
    if self._goodsData then
        if(self._packetType == PACKET_TYPE.PACKET_WAREHOUSE or data.packetType == PACKET_TYPE.PACKET_WAREHOUSE) then
            if(self._packetType ~= data.packetType) then
                return
            end
        end

        if(data.templateID == self._goodsData:getGoodsID()) then
            -- print("GlyphInfoArea:lockStatusChange ", data.isLock, self._goodsData:getIsLock())
            self:refreshLock()
        end
    end
end

-- 关闭锁定标志
function GlyphInfoArea:closeLockFlag()
    self._lockShow = false
    if(self._lock) then
        self._lock:setVisible(false)
    end 
    
    if(self._lockBtn) then 
        self._lockBtn:setVisible(false)
    end

    self:refreshLinkOrLockPosition()
end

--打开锁定标志
function GlyphInfoArea:openLockFlag()
    self._lockShow = true
    if(self._lock) then
        self._lock:setVisible(true)
    end

    if(self._lockBtn) then 
        self._lockBtn:setVisible(true)
    end
    self:refreshLinkOrLockPosition()
end

-- 点击超链接的处理
local function onActiveChatHandler(self)
    UI.ChatMainLayer:getInstance():reciveLinkData(self._goodsData)
end
  
-- 点击锁定按钮处理
local function onActiveGoodsLockHandler(self)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    GameManager:lockGoodsHandler(self._goodsData, self._packetType)
end

-- 刷新锁定显示
function GlyphInfoArea:refreshLock()
    if(self._goodsData) then
        if(self._goodsData:getIsLock()) then
            self._lock:setSpriteName(SPRITE_ITEM_ICON_LOCK)
        else
            self._lock:setSpriteName(SPRITE_ITEM_ICON_UNLOCK)
        end
        self._lock:updateView()
    end
end

-- 初始化视图
function GlyphInfoArea:onInitView()
    local left = 15 
    self:showLucencyLight()
    self:initLockORLink()

    -- 面板背景
    local goodsbg = UI.Image:create()
    goodsbg:init("ui_iteminfo_role_banner_box3.png")
    goodsbg:leftUp(-5,0)
    self:addChild(goodsbg)
    
    local contentSize = goodsbg:getContentSize()
    self:setSize(contentSize.width, contentSize.height)
    self._bgheight = goodsbg._height
    AvalonUtil.runTipsAppearShowAnimation(self)

    local offsetX = 100
    -- 道具名称
    local  goodsName  = UI.Text:create()
    goodsName:init("",UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    goodsName:leftUp(offsetX, 14)
    -- goodsName:setFontSize(18)
    -- goodsName:setFontColor(UI.FONT_COLOR_41_41_45)
    -- goodsName:setTextCenter()
    -- goodsName:setWidth(180)
    goodsName:setSize(200,50)
    goodsName:setLineSpacing(-5)
    self:addChild(goodsName)
    self._goodsName = goodsName

    -- 物品图标背景底框
    local spriteBg1 =  UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:setSize(GRID_SIZE_WIDTH, GRID_SIZE_HEIGHT)
    spriteBg1:leftUp(left, 14)
    self:addChild(spriteBg1) 

    -- 物品图标背景
    local spriteBg =  UI.Image:create()
    spriteBg:init(SPRITE_GRID_RARE_1)
    spriteBg:center()
    spriteBg1:addChild(spriteBg) 
    self._spriteBg = spriteBg
    
    -- 物品图标
    local iconSprite = UI.Image:create()
    iconSprite:init()
    iconSprite:center()
    self._spriteBg:addChild(iconSprite)
    self._iconSprite = iconSprite

    -- 雕纹等级  symbol_character_hero_power_0     ui_information_equip2
    local config = ConfigManager:getGlyphByID(self._goodsData.goodsID)
    for i=1,5 do
        if config.goodsRare >= i then
            local glyphLevelPic = UI.Image:create()
            glyphLevelPic:init("ui_information_equip2.png")
            glyphLevelPic:leftUp(left + i * 20 + 60, 60)
            self:addChild(glyphLevelPic) 
        else
            local glyphLevelPic = UI.Image:create()
            glyphLevelPic:init("symbol_character_hero_power_0.png")
            glyphLevelPic:leftUp(left + i * 20 + 60, 60)
            self:addChild(glyphLevelPic) 
        end
    end

    -- 装备评分
    local score = UI.Image:create()
    score:init("symbol_character_hero_power.png")
    self:addChild(score)
    self.scoreIcon = score
    
    local goodsScore = UI.NumberText:create("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsScore:centerLeft(score:getContentSize().width + 4)
    score:addChild(goodsScore)
    self._goodsScore = goodsScore
    score:leftUp(230, 60)

    local lineX = 162
    -- 上边的分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(281, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(lineX, 181))
    goodsbg:addChild(lineUpImage, 4)

    -- 属性显示区域
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH,117)
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH,129)
    scrollView:init()
    scrollView:leftUp(left, 100)
    scrollView:addInnerNode(self._scrollLayout)
    self:addChild(scrollView)    

    local lineBottomImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineBottomImage:setContentSize(281, 1)
    lineBottomImage:setCapInsets(CCRectMake(1,0,1,1))
    lineBottomImage:setPosition(cc.p(lineX, 50))
    goodsbg:addChild(lineBottomImage, 4)

    local offsetBottomY = 8 
    -- -- 等级需求
    -- local level, reinLv = RoleDataManager:getUIShowLvByItemData(self._goodsData:getRequireLevel())
    -- local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
    -- local level = UI.Text:create()
    -- level:init(UI.TEXT_DES_LEVEL_NEED..showLv, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    -- level:rightBottom(30, offsetBottomY)
    -- self:addChild(level)
    -- self.level = level

    -- if RoleDataManager:getMaster():getLevel() < self._goodsData:getRequireLevel() then
    --     level:setFontColor(UI.FONT_COLOR_80_5_5)
    -- else
    --     level:setFontColor(UI.FONT_COLOR_41_41_45)
    -- end

    -- -- 售卖价格
    -- local sellIcon = UI.Image:create()
    -- sellIcon:init("symbol_gaming_money.png")
    -- sellIcon:leftBottom(left, offsetBottomY)
    -- self:addChild(sellIcon)
    -- self._sellIcon = sellIcon

    -- local sellText = UI.Text:create()
    -- sellText:init("",UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    -- -- sellText:setFontSize(15)
    -- sellText:centerLeft(5+ sellIcon:getContentSize().width)
    -- -- sellText:setFontColor(UI.FONT_COLOR_88_65_34)
    -- sellIcon:addChild(sellText)
    -- self._sellText = sellText

    -- self:showSellPrice()
end

function GlyphInfoArea:initLockORLink()
    local startX = 20
    local startY = -34
    local offsetX = 50
    local haveLink = true
    local haveLock = true
    startX = startX + offsetX

    if(haveLock) then 
        local lockBtn = UI.Button:create()
        lockBtn:init("ui_goods_button_bg_up_0.png", "ui_goods_button_bg_up_1.png")
        lockBtn:addEventListener(UIEvent.BUTTON_CLICK, self,onActiveGoodsLockHandler)
        self:addChild(lockBtn)
        lockBtn:rightUp(startX, startY)

        local lock = UI.Image:create()
        lock:init(SPRITE_ITEM_ICON_UNLOCK)
        lock:center()
        lockBtn:addChild(lock, 20)
        self._lock = lock
        self._lockBtn = lockBtn
        lockBtn:setScale(0.9)
        startX = startX - offsetX
        if(self._lockShow == false) then
            self._lockBtn:setVisible(false)
        end
    end

    if(haveLink) then 
        local link  = UI.ButtonExt:create()
        -- 这里必须先设置，否者可能没有添加进去
        link:extInit("ui_iteminfo_btn_link.png",  "ui_iteminfo_btn_link.png")
        link:init("ui_goods_button_bg_up_0.png", "ui_goods_button_bg_up_1.png")
        link:rightUp(startX, startY)
        startX = startX - offsetX
        link:addEventListener(UIEvent.BUTTON_CLICK, self,onActiveChatHandler)
        self:addChild(link)
        link:setScale(0.9)
    end
end

function GlyphInfoArea:refreshLinkOrLockPosition()
    local startX = 20
    local startY = -34
    local offsetX = 50
    local haveLink = false 
    local haveLock = false

    if(not tolua.isnull(self._lock)) then 
        haveLock = true
    end

    if(not tolua.isnull(self.linkBG)) then 
        haveLink = true
        startX = startX + offsetX
    end

    if(haveLock) then 
        self._lock:rightUp(startX, startY)
        startX = startX - offsetX
    end

    if(haveLink) then 
        self.linkBG:rightUp(startX, startY)
        startX = startX - offsetX
    end
end

-- 更新视图
function GlyphInfoArea:onUpdateView(data)
    if (data and self._goodsData ~= data) then self._goodsData = data
    end
    if (self._goodsData) then
        self._scrollLayout:removeAllChildren()

        local data = self._goodsData 
        local rare = data:getGoodsRare()
        local goodsGroupType = data:getGoodsGroupType()
        self._spriteBg:setSpriteName(string.format("box_quality_%s_%s.png",goodsGroupType,rare))
        local iconName = data:getIconName()
        print("GlyphInfoArea --->: ", iconName)
        if (iconName) then
            if (DEBUG) then
                print(string.format("BagGrid odateView:nUp icon name is %s.", iconName))
            end
            
            self._iconSprite:setSpriteName(iconName)
            -- self._iconSprite:setPosition(GRID_SIZE_WIDTH/2,GRID_SIZE_HEIGHT/2)
            local iconSize = self._iconSprite:getContentSize()
            self._iconSprite:setScale(
                GRID_SIZE_WIDTH / iconSize.width,
                GRID_SIZE_HEIGHT/ iconSize.height
            )
        end
        -- 道具名字
        local name = data:getName()
        self._goodsName:setText(name)
        -- self._goodsName:setText("发送扥囧带饭骚粉色的繁琐扥将扫浪费带扫繁琐带肯将扫了反动返矿森")
        self._goodsName:autoAdapt()
        self._goodsScore:setText(tostring(self._goodsData:getCombatScore()))

        -- 显示属性信息
        local totalHeight = 0
        local leftOffset = 0
        local oneHeight = 20
        local k = 0

        local centerOffsetUp = 13.5
        local pointOffsetY = - 1

        local normalDetailArr = data:getNormalDetailDescription()
        if normalDetailArr then 
            for i,data in ipairs(normalDetailArr) do
                if not tonumber(data[2]) then
                    -- 这里服务器可能会传 "" 空字符串,加个报错判断
                    data[2] = "0"
                end

                local attributeConfig = ConfigManager:getGlyphAttributeByID(tonumber(data[3]))
                local levelColor = self:getAttributeColor(attributeConfig, tonumber(data[2]), self._goodsData)

                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
                self._scrollLayout:addChild(point)
                
                -- UI.FONT_COLOR_41_41_45
                local baseText = UI.Text:create()
                baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, levelColor)
                local textUp = centerUp - baseText:getContentSize().height/2
                baseText:setTextLeft()
                baseText:leftUp(leftOffset + 3 + point._width, textUp)
                self._scrollLayout:addChild(baseText)
                if(baseText:getContentSize().width > 180) then 
                    baseText:setWidth(180)
                    baseText:setText(string.format("%s",data[1]))
                end

                local baseValue = UI.Text:create()
                local attributeValueMax = self:getAttributeMaxValue(attributeConfig, self._goodsData)
                baseValue:init(string.format("%s",data[2]).." ("..attributeValueMax..")", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, levelColor)
                baseValue:leftUp(leftOffset + 13 + baseText._width, textUp)
                self._scrollLayout:addChild(baseValue)
                
                totalHeight = totalHeight + baseText:getContentSize().height
            end
        end

        self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)
    end

    self:refreshLock()
    --self:showSellPrice()
end

function GlyphInfoArea:getAttributeColor(attributeConfig, dataValue, glyphData)
    local attributeValueMax = self:getAttributeMaxValue(attributeConfig, glyphData)

    if dataValue < attributeValueMax * ATTRIBUTE_PERCENT.BULE then
        return ATTRIBUTE_COLOR.BULE
    elseif dataValue < attributeValueMax * ATTRIBUTE_PERCENT.GOLD then
        return ATTRIBUTE_COLOR.GOLD
    elseif dataValue < attributeValueMax * ATTRIBUTE_PERCENT.DARK_GOLD then
        return ATTRIBUTE_COLOR.DARK_GOLD
    else
        return ATTRIBUTE_COLOR.PURPLE
    end   
end

function GlyphInfoArea:getAttributeMaxValue(attributeConfig, glyphData)
    local heroData = RoleDataManager:getMaster()

    local glyphLevel = glyphData:getGlyphType()
    if glyphLevel == PublicDefine.GlyphType.GlyphType_Blue then
        local finalAttr = string.split(attributeConfig.glyphAttributeByLV2, ",")
        return tonumber(finalAttr[heroData:getLevel()])
    elseif glyphLevel == PublicDefine.GlyphType.GlyphType_Gold then
        local finalAttr = string.split(attributeConfig.glyphAttributeByLV3, ",")
        return tonumber(finalAttr[heroData:getLevel()])
    elseif glyphLevel == PublicDefine.GlyphType.GlyphType_DarkGold then
        local finalAttr = string.split(attributeConfig.glyphAttributeByLV4, ",")
        return tonumber(finalAttr[heroData:getLevel()])
    elseif glyphLevel == PublicDefine.GlyphType.GlyphType_Purple then
        local finalAttr = string.split(attributeConfig.glyphAttributeByLV5, ",")
        return tonumber(finalAttr[heroData:getLevel()])
    end

    return 0
end

function GlyphInfoArea:getAttributeMaxValueFromeOther(attributeConfig, glyphData, othersHeroData)
    local glyphLevel = glyphData:getGlyphType()
    if glyphLevel == PublicDefine.GlyphType.GlyphType_Blue then
        local finalAttr = string.split(attributeConfig.glyphAttributeByLV2, ",")
        return tonumber(finalAttr[othersHeroData:getLevel()])
    elseif glyphLevel == PublicDefine.GlyphType.GlyphType_Gold then
        local finalAttr = string.split(attributeConfig.glyphAttributeByLV3, ",")
        return tonumber(finalAttr[othersHeroData:getLevel()])
    elseif glyphLevel == PublicDefine.GlyphType.GlyphType_DarkGold then
        local finalAttr = string.split(attributeConfig.glyphAttributeByLV4, ",")
        return tonumber(finalAttr[othersHeroData:getLevel()])
    elseif glyphLevel == PublicDefine.GlyphType.GlyphType_Purple then
        local finalAttr = string.split(attributeConfig.glyphAttributeByLV5, ",")
        return tonumber(finalAttr[othersHeroData:getLevel()])
    end

    return 0
end

function GlyphInfoArea:setHideLink(isHideLink)
    if isHideLink and not tolua.isnull(self.linkBG) then
        self.linkBG:hide()
    end
end

function GlyphInfoArea:showSellPrice()
    if(self._sellText and self._sellIcon) then 
        if(self._showSellPrice) then
            if(self._goodsData) then 
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