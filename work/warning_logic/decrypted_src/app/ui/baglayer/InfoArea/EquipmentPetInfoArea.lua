--[[
    UI - 宠物装备详情界面
]] --

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.ScrollView"

UI = UI or {}

local EquipmentPetInfoArea = class("EquipmentPetInfoArea", UI.HWBtnComponent)
UI.EquipmentPetInfoArea = EquipmentPetInfoArea

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
    "ui_package_pets.plist"
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

local EquipImageBgType = UI.EquipImageBgType

local EquipmentPetHoleInfoArea = class("EquipmentPetHoleInfoArea", UI.HWBtnComponent)

function EquipmentPetHoleInfoArea:ctor()
    EquipmentPetHoleInfoArea.super.ctor(self, UIType.EQUIPMENT_INFO_AREA, {}, 55, 48)

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA, self, self.closeInfoArea)
end

function EquipmentPetHoleInfoArea:dtor()
    EquipmentPetHoleInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA, self, self.closeInfoArea)
end

function EquipmentPetHoleInfoArea:init()
    EquipmentPetHoleInfoArea.super.init(self)
end

function EquipmentPetHoleInfoArea:onInitView()
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

function EquipmentPetHoleInfoArea:refreshHole(holeData)
    self.holeData = holeData
    self.unlock = true

    local spriteFrameName = "ui_iteminfo_btn_runestone_petsgem_up.png"
    local downFrameName = "ui_iteminfo_btn_runestone_petsgem_dwon.png"
    -- if (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Red) then
    --     downFrameName = "ui_iteminfo_btn_runestone_red_dwon.png"
    --     spriteFrameName = "ui_iteminfo_btn_runestone_red_up.png"
    -- elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Yellow) then
    --     downFrameName = "ui_iteminfo_btn_runestone_red_dwon.png"
    --     spriteFrameName = "ui_iteminfo_btn_runestone_red_up.png"
    -- elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Blue) then
    --     downFrameName = "ui_iteminfo_btn_runestone_red_dwon.png"
    --     spriteFrameName = "ui_iteminfo_btn_runestone_red_up.png"
    -- elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then
    --     downFrameName = "ui_iteminfo_btn_runestone_colorful_dwon.png"
    --     spriteFrameName = "ui_iteminfo_btn_runestone_colorful_up.png"
    -- end

    if (spriteFrameName) then
        self.colorImage:setVisible(true)
        self.colorImage:setSpriteName(spriteFrameName)
    end
    if (downFrameName) then
        self.bg:setSpriteName(downFrameName)
    end

    self.goodsGrid:setVisible(false)
    if holeData.gemId ~= nil and holeData.gemId ~= 0 then
        holeData.entityID = 0
        local gemStoneData = mvc.petGemStoneDevelopmentModel:createPetStoneData(holeData)
        if (gemStoneData) then
            self.gemStoneData = gemStoneData
            self.goodsGrid:setVisible(true)
            self.goodsGrid:setSpriteName(gemStoneData:getIconName())
            self.goodsGrid:setScale(0.7)
            self.goodsGrid:updateView()
        end
    end
end

function EquipmentPetHoleInfoArea:closeInfoArea()
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


function EquipmentPetHoleInfoArea:onTouchLongTimeBeganHandler()
    --print("====弹出页面===  1", self._mn, self._type, self.index)
    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_CLOSE_INFO_AREA)

    if (self.holeData == nil) then
        return
    end

    self._isTouchLongTime = true
    
    --print("====弹出页面===  2")
    local goodsData = self.gemStoneData
    local pInfoArea = nil

    if not goodsData then
        return
    end
    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then

        
        pInfoArea = UI.PetStoneInfoArea:create()
        pInfoArea:init(goodsData)
        -- pInfoArea = UI.GemStoneInfoArea:create()
        -- pInfoArea:init(goodsData)
    else
        return
    end

    if not pInfoArea then
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





-- 构造函数
function EquipmentPetInfoArea:ctor()
    EquipmentPetInfoArea.super.ctor(self, UIType.EQUIPMENT_PET_INFO_AREA, BAG_EQUIPMENT_INFO_AREA_RES_LIST, 324, 414)

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

    self._packetType = nil
    self._goodsGrid = nil
    -- 是否显示售卖价格，这里只会在商店层显示
    self._showSellPrice = false
    self.holeNodeArr = {}

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- 析构函数
function EquipmentPetInfoArea:dtor()
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

    EquipmentPetInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
    reload_script_file("app.ui.baglayer.InfoArea.EquipmentPetInfoArea")
end

-- public:
-- 初始化
function EquipmentPetInfoArea:init(pngType, data, isBotttom)
    self._pngType = pngType
    self._infoBottom = isBotttom
    --print("EquipmentPetInfoArea:init(", pngType)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
    EquipmentPetInfoArea.super.init(self, data, isBotttom)
end

-- 销毁
function EquipmentPetInfoArea:onDestroy()
end

-- 点击超链接的处理
local function onActiveChatHandler(self)
    --print("====聊天超链接===")
    -- Game.ChatManager:getInstance():sendItemLink(self._goodsData)
    UI.ChatMainLayer:getInstance():reciveLinkData(self._goodsData)
end

-- 设置的操作的包裹类型
function EquipmentPetInfoArea:setPacketType(packetType)
    self._packetType = packetType
end

-- 锁定状态改变
function EquipmentPetInfoArea:lockStatusChange(data)
    UI.WaitingLayer:hideWaiting()
    if (self._goodsData) then
        if (data.entityID == self._goodsData:getEntityID()) then
            --print("EquipmentPetInfoArea:lockStatusChange ", data.isLock, self._goodsData:getIsLock())
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
function EquipmentPetInfoArea:refreshLock()
    if (self._goodsData and self._lock) then
        if (self._goodsData:getIsLock()) then
            self._lock:setSpriteName(SPRITE_ITEM_ICON_LOCK)
        else
            self._lock:setSpriteName(SPRITE_ITEM_ICON_UNLOCK)
        end
        self._lock:updateView()
    end
end

function EquipmentPetInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function EquipmentPetInfoArea:getGoodsGrid()
    return self._goodsGrid
end

-- 显示价格
function EquipmentPetInfoArea:setShowSellPrice(flag)
    self._showSellPrice = flag
    self:showSellPrice()
end

-- 初始化视图
function EquipmentPetInfoArea:onInitView(data, isBotttom)
    self:showLucencyLight()
    local pngtype = self._pngType
    self:initHole()
    self:initLockORLink()

    local goodsbg = UI.Image:create()
    goodsbg:init("ui_iteminfo_role_banner_box1.png")
    goodsbg:center()
    self:addChild(goodsbg)
    local contentSize = goodsbg:getContentSize()
    self:setSize(contentSize.width, contentSize.height)

    AvalonUtil.runTipsAppearShowAnimation(self)

    -- 装备名称
    local goodsName = UI.Text:create()
    goodsName:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    goodsName:setWidth(200)
    goodsName:leftUp(100, 25)
    goodsName:setLineSpacing(-5)
    self:addChild(goodsName, 10)
    self._goodsName = goodsName

    -- 装备评星
    local goodsStarBg = UI.Image:create()
    goodsStarBg:init("ui_pets_bg_3.png")
    goodsStarBg:leftUp(104, 62)
    self:addChild(goodsStarBg)
    self.goodsStarBg = goodsStarBg
    

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
    score:leftUp(215, 96)

    -- 武器类型图标
    local equipmentType = UI.Image:create()
    equipmentType:init()
    equipmentType:leftUp(99, 96 - 4)
    self:addChild(equipmentType)
    self._equipmentType = equipmentType

    -- 武器类型文字描述
    local equipmentText = UI.Text:create()
    equipmentText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    equipmentText:centerLeft(29)
    equipmentType:addChild(equipmentText)
    equipmentText:setFixLineWidth(80)
    self._equipmentText = equipmentText

    local left = LEFT_SPACE
    -- 物品图标背景底框
    local spriteBg1 = UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(left, 37)
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

    -- local starLV = cc.Label:createWithSystemFont(string.format("+%s", 1), font, UI.FONT_SIZE_16PX)
    -- starLV:setPosition(POSITION_X_STARLV, POSITION_Y_STARLV)
    -- self._spriteBg:addChild(starLV)
    -- self._starLV = starLV
    -- self._starLV:setVisible(false)

    local lineX = 162
    -- 上边的分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(291, 1)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineUpImage:setPosition(cc.p(lineX, 292))
    goodsbg:addChild(lineUpImage, 4)

    -- -- 中间的分割线
    -- local lineCenterImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    -- lineCenterImage:setContentSize(291, 1)
    -- lineCenterImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    -- lineCenterImage:setPosition(cc.p(lineX, 247 + 5))
    -- goodsbg:addChild(lineCenterImage, 4)
    local wearHeight = 20
    -- 下边的分割线
    local lineDownImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineDownImage:setContentSize(291, 1)
    lineDownImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineDownImage:setPosition(cc.p(lineX, 58+wearHeight))
    goodsbg:addChild(lineDownImage, 4)

    -- 属性显示区域
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    -- self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH,250)
    
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH, 230 - wearHeight)
    scrollView:init()
    scrollView:leftUp(0, 127)
    scrollView:addInnerNode(self._scrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    -- scrollView:enableDebugDraw()
    self:addChild(scrollView)

    -- 描述信息
    local equipmentDescribe = UI.Text:create()
    equipmentDescribe:init("", UI.FONT_DES, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    equipmentDescribe:setSize(274, 50)
    equipmentDescribe:setTextLeft()
    equipmentDescribe:leftBottom(left, 8+ wearHeight)
    -- equipmentDescribe:enableDebugDraw()
    goodsbg:addChild(equipmentDescribe)
    self._describe = equipmentDescribe

    -- 用于装备穿戴于那个宠物
    local wearDescribe = UI.Text:create()
    wearDescribe:init("", UI.FONT_ARIAL, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    wearDescribe:setTextLeft()
    wearDescribe:leftBottom(left, 8)
    -- wearDescribe:enableDebugDraw()
    goodsbg:addChild(wearDescribe)
    self._wearDescribe = wearDescribe

    self:initCompare(isBotttom)
    if (pngtype == EquipImageBgType.SMALL_TYPE or pngtype == EquipImageBgType.NO_GET_TYPE) then
        self:hideCompInfo()
    else
    end

    self:showSellPrice()

    self:refreshEquipmentStar()
end

function EquipmentPetInfoArea:refreshEquipmentStar()
    local starLayout = self.goodsStarBg:getChildByName("StarLayout")
    if starLayout then
        self.goodsStarBg:removeChildByName("StarLayout")
    end
    print("refreshEquipmentStar 1")
    if(self._goodsData == nil) then 
        return
    end
    print("refreshEquipmentStar 2")
    -- 星级
    local starLv = self._goodsData:getGoodsStar()
    local canLvUpNum = 0
    local nextEquipementPetData = self._goodsData:getNextEquipmentPetData()
    if(nextEquipementPetData) then 
        canLvUpNum = nextEquipementPetData:getGoodsStar() - starLv
    end

    -- 判断宠物装备是否升阶了（根据宠物转生的星际显示来配）
    local str1 = "symbol_character_hero_power.png" 
    local str2 = "symbol_character_hero_power_0.png"
    local petStoneReincarntionLv = 1
    local configDatas = ConfigManager:getAllPetReincarnationDataByID(petStoneReincarntionLv)
    if starLv >= configDatas.advancedStars then
        starLv = starLv - tonumber(configDatas.advancedStars) + 1
        --canLvUpNum = canLvUpNum - tonumber(configDatas.deductStars)advancedStars
        str1 = "ui_information_equip2.png" 
        str2 = "symbol_character_hero_power_0.png"
        -- disStar = -3
        -- disCan = 0
    end

    if starLv > 0 or canLvUpNum > 0 then
        local starLayout = UI.Layout:create();
        starLayout:init()
        starLayout:setSize(220, 30)
        starLayout:center()
        starLayout:setName("StarLayout")
        self.goodsStarBg:addChild(starLayout, 100)

        -- local starBg = UI.Image:create()
        -- starBg:init("ui_pets_star_banner.png")
        -- starBg:center()
        -- starLayout:addChild(starBg)

        local starAutoLayer = UI.Layout:create();
        starAutoLayer:init()
        starAutoLayer:center()
        starAutoLayer:enableAutoWidth()
        starAutoLayer:enableAutoHeight()
        starLayout:addChild(starAutoLayer, 50)

        for i = 1, starLv do
            local starImg = UI.Image:create()
            starImg:init(str1)
            starImg:floatLeft(-2)
            starAutoLayer:addComponent(starImg)
        end

        for i = 1, canLvUpNum do
            local starImg = UI.Image:create()
            starImg:init(str2)
            starImg:floatLeft(-2)
            starAutoLayer:addComponent(starImg)
        end
    end
end

function EquipmentPetInfoArea:initCompare(isBotttom)
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

function EquipmentPetInfoArea:initLockORLink()
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

function EquipmentPetInfoArea:refreshLinkOrLockPosition()
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
function EquipmentPetInfoArea:onUpdateView(data, activeNum)
    --print("EquipmentPetInfoArea onUpdateView:")
    if (data) then
        self._goodsData = data

        self:refreshHole()

        local rare = data:getGoodsRare()
        local goodsGroupType = data:getGoodsGroupType()
        self._spriteBg:setSpriteName(string.format("box_quality_%s_%s.png", goodsGroupType, rare))

        local iconName = data:getIconName()
        if (iconName) then
            if (DEBUG) then
                print(string.format("BagGrid odateView:nUp icon name is %s.", iconName))
            end

            self._iconSprite:setSpriteName(string.format(iconName))
            local iconSize = self._iconSprite:getContentSize()
        end

        -- 装备名字，目前先注释掉，美术看效果
        local name = data:getName()
        if not DEBUG then
            self._goodsName:setText(name)
            self._goodsName:autoAdapt()
        end

        -- 星级分数
        self._goodsScore:setText(string.format("%s", data:getCombatScore()))

        -- 装备类型
        local equipType = data:getEquipmentType()
        local languageStr = nil
        local LanguageManager = require("app.game.LanguageManager")
        -- print("equipType=", equipType)
        if (equipType == PublicDefine.PET_EQUIPMENT_TYPE.PetWeapon) then -- 武器
            self._equipmentType:setSpriteName("ui_information_location_1.png")
            languageStr = LanguageManager:getInstance():getLocalString(1111536)
        elseif (equipType == PublicDefine.PET_EQUIPMENT_TYPE.PetHelmet) then -- 头盔
            languageStr = LanguageManager:getInstance():getLocalString(1111378)
            self._equipmentType:setSpriteName("ui_information_location_2.png")
        elseif (equipType == PublicDefine.PET_EQUIPMENT_TYPE.PetChest) then -- 衣服
            self._equipmentType:setSpriteName("ui_information_location_3.png")
            languageStr = LanguageManager:getInstance():getLocalString(1111380)
        elseif (equipType == PublicDefine.PET_EQUIPMENT_TYPE.PetAmulet) then -- 饰品
            self._equipmentType:setSpriteName("ui_information_location_4.png")
            languageStr = UI.TEXT_1325901
        end

        if (languageStr) then
            self._equipmentText:setText(string.format("%s", languageStr))
        end

        local attdata = nil
        if (self._pngType == EquipImageBgType.NO_GET_TYPE) then
            attdata = data:getDetailDescription(0)
        else
            attdata = data:getDetailDescription(activeNum)
        end

        local attrWidth = 205
        -- 基础属性
        local baseArr = attdata.baseArr

        local k = 0
        local oneHeight = TEXT_VALUE_ROW
        local totalHeight = 0
        local centerOffsetUp = 13.5
        local pointOffsetY = -1
        local leftOffset = 11
        leftOffset = LEFT_SPACE
        local pointBaseOffset = 3
        local pointBaseValueOffset = 13
        for i, data in ipairs(baseArr) do
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

            totalHeight = totalHeight + baseText:getContentSize().height
            k = i
        end

        --宝石属性
        local slots = self._goodsData:getSlotsData() or {}
        for k,v in ipairs(slots) do
            local gemStone = mvc.petGemStoneDevelopmentModel:createPetStoneData(v)
            if gemStone then
                local normalDetailArr = gemStone:getNormalDetailDescription()
                if normalDetailArr then 
                    for i,data in ipairs(normalDetailArr) do
                        local centerUp = totalHeight + centerOffsetUp
        
                        local point = UI.Image:create()
                        point:init(SPRITE_EQUIPMENT_AREA_POINT)
                        point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
                        self._scrollLayout:addChild(point)
                        
                        local baseText = UI.Text:create()
                        baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
                        local textUp = centerUp - baseText:getContentSize().height/2
                        baseText:setTextLeft()
                        baseText:leftUp(leftOffset + 3 + point._width, textUp)
                        self._scrollLayout:addChild(baseText)
                        if(baseText:getContentSize().width > 180) then 
                            baseText:setWidth(180)
                            baseText:setText(string.format("%s",data[1]))
                        end
        
                        local baseValue = UI.Text:create()
                        baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
                        baseValue:leftUp(leftOffset + 13 + baseText._width, textUp)
                        self._scrollLayout:addChild(baseValue)
                        
                        totalHeight = totalHeight + baseText:getContentSize().height
                    end
                end

                local specialDes = gemStone:getSpecialDetailDescription()
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
                    
                    totalHeight = totalHeight + baseText:getContentSize().width
                    k =  k + 1
                end
            end
        end



        -- layout 的size按照内容而定
        self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)
        self._describe:setText(string.format("%s", data:getSkillDescription()))
        -- print("====穿戴等级---描述信息",data:getWearLV(),data:getDescription())
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

        local petRoleData = MasterDataManager:getPetDataForWearEquipmentID(self._goodsData:getEntityID())
        if(petRoleData) then 
            self._wearDescribe:setText(UI.TEXT_1325911..petRoleData:getNickName())
        else
            self._wearDescribe:setText("") 
        end

        self._goodsName:updateView()
        self._goodsScore:updateView()
        self._equipmentType:updateView()
        self._describe:updateView()
        self:refreshLock()

        self:showSellPrice()
        self:refreshEquipmentStar()
    end
end

-- 关闭锁定标志
function EquipmentPetInfoArea:closeLockFlag()
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
function EquipmentPetInfoArea:openLockFlag()
    self._lockShow = true
    if (self._lock) then
        self._lock:setVisible(true)
    end

    if (self._lockBtn) then
        self._lockBtn:setVisible(true)
    end
    self:refreshLinkOrLockPosition()
end

function EquipmentPetInfoArea:handlePercent(value)
    local endValue = value
    if (value < 0 and value > -0.1) then
        endValue = -0.1
    elseif (value < 0.1 and value > 0) then
        endValue = 0.1
    end

    return endValue
end

-- 试装 属性变化区域
function EquipmentPetInfoArea:updateInfo(tryGoodsData, equipmentData, isLeft)
    local pngtype = self._pngType
    if tryGoodsData then
        if (pngtype == EquipImageBgType.SMALL_TYPE) then
        else
            self:showCompInfo()
        end
        print("EquipmentPetInfoArea:updateInfo", self._compareLayout:isVisible())
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

        -- 获取要被替换的装备
        -- if(equipmentData == nil) then 
        --     local fightPet = MasterDataManager:getFightPet()
        --     if(fightPet and tryGoodsData) then 
        --         equipmentData = fightPet:getWearEquipmentForEquipType(tryGoodsData:getEquipmentType())
        --     end
        -- end
        local tryEquipmentData = tryGoodsData

        local startX = 0
        local startY = 0
        local offsetY = 20

        -- 装备之间的属性变化 TODO
        local addAllAttr = nil
        local reduceAllAttr = nil
        if (equipmentData) then
            reduceAllAttr = equipmentData:getAllAttr()
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

function EquipmentPetInfoArea:createCompareOneValue(name, value, state)
    -- print("EquipmentPetInfoArea:createCompareOneValue", name, value, state)
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

-- 初始化插槽
function EquipmentPetInfoArea:initHole()
    for index = 1, 4 do
        local holeNode = EquipmentPetHoleInfoArea:create()
        holeNode:init()
        holeNode.index = index

        self.holeNodeArr = self.holeNodeArr or {}
        table.insert(self.holeNodeArr, holeNode)

        holeNode:center()
        self:addChild(holeNode)
    end
end

-- 刷新插槽
function EquipmentPetInfoArea:refreshHole()
    local slotsData = self._goodsData:getSlotsData()

    for k, node in ipairs(self.holeNodeArr) do
        if (not tolua.isnull(node)) then
            node:setVisible(false)
        end
    end

    local normalStartX = 5
    local colorStartX = 8
    local offsetX = 60

    for k, sData in ipairs(slotsData) do
        if (sData) then
            local holeNode = self.holeNodeArr[k]
            if (holeNode == nil) then
                holeNode = EquipmentPetHoleInfoArea:create()
                holeNode:init()
                holeNode.index = index

                self.holeNodeArr = self.holeNodeArr or {}
                table.insert(self.holeNodeArr, holeNode)
                self:addChild(holeNode)
            end

            holeNode:leftBottom(normalStartX, -47)
            normalStartX = normalStartX + offsetX

            if (not tolua.isnull(holeNode)) then
                holeNode:setVisible(true)
                holeNode:refreshHole(sData)
            end
        end
    end
end

-- 隐藏装备对比
function EquipmentPetInfoArea:hideCompInfo()
    if (self._compareLayout) then
        self._compareLayout:setVisible(false)
        self._compareLayout:centerRight(-winSize.width)
    end
end

-- 显示装备对比
function EquipmentPetInfoArea:showCompInfo()
    if (self._compareLayout) then
        self._compareLayout:setVisible(true)
    end

    self:showStrength()
end

function EquipmentPetInfoArea:showStrength()

end

function EquipmentPetInfoArea:showSellPrice()

end

function EquipmentPetInfoArea:setHideLink(isHideLink)
    if isHideLink and self.linkBG then
        self.linkBG:hide()

        self:refreshLinkOrLockPosition()
    end
end