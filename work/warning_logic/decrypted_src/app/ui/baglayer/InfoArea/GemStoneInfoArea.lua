-- GemStoneInfoArea.lua
-- Author:zp
-- 2018年6月19日
-- Using:宝石详情

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.ScrollView"

UI = UI or {}

local GemStoneInfoArea = class("GemStoneInfoArea", UI.HWBtnComponent)
UI.GemStoneInfoArea = GemStoneInfoArea

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

-- 构造函数
function GemStoneInfoArea:ctor()

    GemStoneInfoArea.super.ctor(self, UIType.GEM_STONE_INFO_AREA, {}, width, height)
    
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
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)    
end

-- 析构函数
function GemStoneInfoArea:dtor()

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

    GemStoneInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- public:
-- 初始化
function GemStoneInfoArea:init(data)
    self._goodsData = data

    GemStoneInfoArea.super.init(self, data)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
end

-- 销毁
function GemStoneInfoArea:onDestroy()
    self._packetType = nil
end


function GemStoneInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function GemStoneInfoArea:getGoodsGrid()
    return self._goodsGrid
end


-- 设置的操作的包裹类型
function GemStoneInfoArea:setPacketType(packetType)
    self._packetType = packetType
end

-- 显示价格
function GemStoneInfoArea:setShowSellPrice(flag)
    self._showSellPrice = flag
    self:showSellPrice()
end

-- 锁定状态改变
function GemStoneInfoArea:lockStatusChange(data)
    UI.WaitingLayer:hideWaiting()
    if self._goodsData then
        if(self._packetType == PACKET_TYPE.PACKET_WAREHOUSE or data.packetType == PACKET_TYPE.PACKET_WAREHOUSE) then
            if(self._packetType ~= data.packetType) then
                return
            end
        end

        if(data.templateID == self._goodsData:getGoodsID()) then
            -- print("GemStoneInfoArea:lockStatusChange ", data.isLock, self._goodsData:getIsLock())
            self:refreshLock()
        end
    end
end

-- 关闭锁定标志
function GemStoneInfoArea:closeLockFlag()
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
function GemStoneInfoArea:openLockFlag()
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
function GemStoneInfoArea:refreshLock()
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
function GemStoneInfoArea:onInitView()
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

    -- 宝石等级 
    local goodsDes = UI.Text:create()
    goodsDes:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsDes:setTextLeft()
    if(self._goodsData:getNextLVID() == 0) then 
        goodsDes:setText("[Lv max]")
    else
        goodsDes:setText(string.format("[Lv %d]", self._goodsData:getStoneLV()))
    end
    goodsDes:leftUp(offsetX, 76 - goodsDes:getContentSize().height/2)
    self:addChild(goodsDes) 

    -- 装备评分
    local score = UI.Image:create()
    score:init("symbol_character_hero_power.png")
    self:addChild(score)
    self.scoreIcon = score
    
    local goodsScore = UI.NumberText:create("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsScore:centerLeft(score:getContentSize().width + 4)
    score:addChild(goodsScore)
    self._goodsScore = goodsScore
    score:leftUp(215, 65)

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
    scrollView:setSize(LAYOUT_SIZE_WIDTH + 10,129)
    scrollView:init()
    scrollView:leftUp(left - 10, 100)
    scrollView:addInnerNode(self._scrollLayout)
    self:addChild(scrollView)

    local lineBottomImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineBottomImage:setContentSize(281, 1)
    lineBottomImage:setCapInsets(CCRectMake(1,0,1,1))
    lineBottomImage:setPosition(cc.p(lineX, 50))
    goodsbg:addChild(lineBottomImage, 4)

    local offsetBottomY = 8 
    -- 等级需求
    local level, reinLv = RoleDataManager:getUIShowLvByItemData(self._goodsData:getRequireLevel())
    local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
    local level = UI.Text:create()
    level:init(UI.TEXT_DES_LEVEL_NEED..showLv, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    level:rightBottom(30, offsetBottomY)
    self:addChild(level)
    self.level = level

    if RoleDataManager:getMaster():getLevel() < self._goodsData:getRequireLevel() then
        level:setFontColor(UI.FONT_COLOR_80_5_5)
    else
        level:setFontColor(UI.FONT_COLOR_41_41_45)
    end

    -- 售卖价格
    local sellIcon = UI.Image:create()
    sellIcon:init("symbol_gaming_money.png")
    sellIcon:leftBottom(left, offsetBottomY)
    self:addChild(sellIcon)
    self._sellIcon = sellIcon

    local sellText = UI.Text:create()
    sellText:init("",UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    -- sellText:setFontSize(15)
    sellText:centerLeft(5+ sellIcon:getContentSize().width)
    -- sellText:setFontColor(UI.FONT_COLOR_88_65_34)
    sellIcon:addChild(sellText)
    self._sellText = sellText

    self:showSellPrice()
end

function GemStoneInfoArea:initLockORLink()
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

function GemStoneInfoArea:refreshLinkOrLockPosition()
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
function GemStoneInfoArea:onUpdateView(data)
    if (data and self._goodsData ~= data) then self._goodsData = data
    end
    if (self._goodsData) then
        self._scrollLayout:removeAllChildren()

        local data = self._goodsData 
        local rare = data:getGoodsRare()
        local goodsGroupType = data:getGoodsGroupType()
        self._spriteBg:setSpriteName(string.format("box_quality_%s_%s.png",goodsGroupType,rare))
        local iconName = data:getIconName()
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
        local leftOffset = 8
        local oneHeight = 20
        local k = 0

        local centerOffsetUp = 13.5
        local pointOffsetY = - 1

        local normalDetailArr = data:getNormalDetailDescription()
        if normalDetailArr then 
            for i,data in ipairs(normalDetailArr) do
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
                self._scrollLayout:addChild(point)
                
                local baseText = UI.Text:create()
                baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                local textUp = centerUp - baseText:getContentSize().height/2
                baseText:setTextLeft()
                baseText:leftUp(leftOffset + 3 + point._width, textUp)
                self._scrollLayout:addChild(baseText)
                if(baseText:getContentSize().width > 180) then 
                    baseText:setWidth(180)
                    baseText:setText(string.format("%s",data[1]))
                end

                local baseValue = UI.Text:create()
                baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                baseValue:leftUp(leftOffset + 13 + baseText._width, textUp)
                self._scrollLayout:addChild(baseValue)
                
                totalHeight = totalHeight + baseText:getContentSize().height
            end
        end

        -- 符文链接属性展示
        local linkDetailArr, isUnlock = data:getLinkDetailDescription()
        if linkDetailArr then
            for i,data in ipairs(linkDetailArr) do
                local centerUp = totalHeight + centerOffsetUp
                local point = UI.Image:create()
                if isUnlock then
                    point:init(SPRITE_EQUIPMENT_AREA_POINT)
                    point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
                else
                    point:init("ui_iteminfo_runelink_locked.png")
                    point:setScale(0.75)
                    point:leftUp(leftOffset - 3, centerUp - point:getContentSize().height/2 + pointOffsetY + 1)
                end
                
                self._scrollLayout:addChild(point)
                
                local point2 = UI.Image:create()
                point2:init(SPRITE_EQUIPMENT_AREA_POINT)
                local baseText = UI.Text:create()
                if isUnlock then
                    baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
                else
                    baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_109_103_105)
                end
                local textUp = centerUp - baseText:getContentSize().height/2
                baseText:setTextLeft()
                baseText:leftUp(leftOffset + 3 + point2._width, textUp)
                self._scrollLayout:addChild(baseText)
                if(baseText:getContentSize().width > 180) then 
                    baseText:setWidth(180)
                    baseText:setText(string.format("%s",data[1]))
                end

                local baseValue = UI.Text:create()
                if isUnlock then
                    baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
                else
                    baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_109_103_105)
                end
                baseValue:leftUp(leftOffset + 13 + baseText._width, textUp)
                self._scrollLayout:addChild(baseValue)

                if not isUnlock then
                    local lockImg = UI.Button:create()
                    lockImg:init("ui_iteminfo_runelink_btn_duty.png", "ui_iteminfo_runelink_btn_duty.png")
                    lockImg:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                        --展示tips
                        UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(UI.TEXT_227906)
                    end)
                    lockImg:leftUp(leftOffset+ 18 + baseText._width + baseValue._width, centerUp - lockImg:getContentSize().height/2 + pointOffsetY)

                    self._scrollLayout:addChild(lockImg)
                end
                
                totalHeight = totalHeight + baseText:getContentSize().height
            end
        end

        local specialDes = data:getSpecialDetailDescription()
        -- specialDes = "DFDSFSDFSDFDSFDSFdddfdffffff"
        if specialDes then 
            local centerUp = totalHeight + centerOffsetUp

            local point = UI.Image:create()
            point:init(SPRITE_EQUIPMENT_AREA_POINT)
            point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
            self._scrollLayout:addChild(point)
            
            local baseText = UI.Text:create()
            baseText:init(specialDes, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
            baseText:setTextLeft()
            baseText:leftUp(leftOffset + 3 + point._width, centerUp - baseText:getContentSize().height/2)
            baseText:setWidth(220)
            baseText:setText(specialDes)
            self._scrollLayout:addChild(baseText)
            
            totalHeight = totalHeight + baseText:getContentSize().height
            k =  k + 1
        end

        self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)
    end

    self:refreshLock()
    self:showSellPrice()
end

function GemStoneInfoArea:setHideLink(isHideLink)
    if isHideLink and not tolua.isnull(self.linkBG) then
        self.linkBG:hide()
    end
end

function GemStoneInfoArea:showSellPrice()
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