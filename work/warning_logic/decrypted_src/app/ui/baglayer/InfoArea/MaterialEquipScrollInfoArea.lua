--[[
    UI - 背包中的图纸的详情页面
]]--

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.ScrollView"

local winSize = cc.Director:getInstance():getWinSize()

UI = UI or {}

local MaterialEquipScrollInfoArea = class("MaterialEquipScrollInfoArea", UI.HWBtnComponent)
UI.MaterialEquipScrollInfoArea = MaterialEquipScrollInfoArea

local PACKET_TYPE = PublicDefine.PACKET_TYPE 

UI.PROP_MATER = {
    PROPINFO = 1,       -- 道具
    MATERIALINFO = 2,   -- 材料
    TASK_PROP = 3,      -- 任务界面的道具详情
    TASK_MATERIAL = 4,  -- 任务界面的材料详情
    VIRTUALITEM_INFO = 5,-- 虚拟物品和道具一致
}
local proptype = UI.PROP_MATER 

-- private:
local DEBUG = false
local DEBUG_DRAW = true
-- 尺寸
local width = 324
local height = 418
local TEXT_VALUE_SPACE = 10 
local TEXT_VALUE_ROW   = 20 
local POSITION_X_TEXT  = 115 
local POSITION_Y_TEXT  = 90
local GRID_SIZE_WIDTH  = 74 
local GRID_SIZE_HEIGHT = 74 
-- 描述信息的宽度
local TEXT_DESCRIBE_WIDTH = 292
-- 一排的Y坐标
local WEIGHT_POSTION_Y = 80
-- 背包资源
local BAG_EQUIPMENT_INFO_AREA_RES_LIST = {

}

local SPRITE_GRID_RARE_1 = "box_quality_0_1.png"
local SPRITE_EQUIPMENT_ALL = "icon-equip_large_21010010.png"
local SPRITE_EQUIPMENT_NAME = "icon-equip_large_210%s0010.png"
local SPRITE_EQUIPMENT_WEAPON = "icon-equip_large_210%s0010_%s.png"

-- 背景1
local SPRITE_EQUIPMENT_AREA_BG_UP = "ui_iteminfo_role_banner_box1.png" 
-- 属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT = "ui_iteminfo_icon_point_01.png"
-- 套装属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT_SUIT = "ui_iteminfo_icon_point_02.png"

-- 锁按钮的三个状态
local SPRITE_ITEM_ICON_LOCK = "ui_iteminfo_btn_locked.png"
local SPRITE_ITEM_ICON_UNLOCK = "ui_iteminfo_btn_unlock.png"
local SPRITE_EQUIPMENT_LEVEL = "symbol_character_hero_power.png"
-- 布局的宽
local LAYOUT_SIZE_WIDTH  = 293

local VIRTUAL_ITEM_TYPE = PublicDefine.VIRTUAL_ITEM_TYPE

-- 构造函数
function MaterialEquipScrollInfoArea:ctor()

    MaterialEquipScrollInfoArea.super.ctor(self, UIType.PROP_INFO_AREA, BAG_EQUIPMENT_INFO_AREA_RES_LIST, width, height)
    
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
    self._proptype = nil 
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)    
end

-- 析构函数
function MaterialEquipScrollInfoArea:dtor()
    -- 装备名字
    self._goodsName = nil 
    self._goodsDes = nil
    self._spriteBg = nil 
    -- 图标
    self._iconSprite = nil 
    -- 星级分数
    self._goodsScore = nil 
    -- 装备类型
    self._equipmentType = nil
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
    self._proptype = nil 

    self._packetType = nil
    
    self._bgheight = 0 

    -- 是否显示售卖价格，这里只会在商店层显示
    self._showSellPrice = false

    MaterialEquipScrollInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- public:
-- 初始化
function MaterialEquipScrollInfoArea:init(proptype,data)
    self._proptype = proptype 
    self._goodsData = data

    MaterialEquipScrollInfoArea.super.init(self, data)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
end

-- 销毁
function MaterialEquipScrollInfoArea:onDestroy()
    self._packetType = nil
end


function MaterialEquipScrollInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function MaterialEquipScrollInfoArea:getGoodsGrid()
    return self._goodsGrid
end


-- 设置的操作的包裹类型
function MaterialEquipScrollInfoArea:setPacketType(packetType)
    self._packetType = packetType
end

-- 显示价格
function MaterialEquipScrollInfoArea:setShowSellPrice(flag)
    self._showSellPrice = flag
    self:showSellPrice()
end

-- 锁定状态改变
function MaterialEquipScrollInfoArea:lockStatusChange(data)
    UI.WaitingLayer:hideWaiting()
    if self._goodsData then
        if(self._packetType == PACKET_TYPE.PACKET_WAREHOUSE or data.packetType == PACKET_TYPE.PACKET_WAREHOUSE) then
            if(self._packetType ~= data.packetType) then
                return
            end
        end

        if(data.templateID == self._goodsData:getGoodsID()) then
            print("MaterialEquipScrollInfoArea:lockStatusChange ", data.isLock, self._goodsData:getIsLock())
            self:refreshLock()
        end
    end
end

-- 关闭锁定标志
function MaterialEquipScrollInfoArea:closeLockFlag()
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
function MaterialEquipScrollInfoArea:openLockFlag()
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
    print("====聊天超链接=== ")
    UI.ChatMainLayer:getInstance():reciveLinkData(self._goodsData)
end
  
-- 点击锁定按钮处理
local function onActiveGoodsLockHandler(self)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    GameManager:lockGoodsHandler(self._goodsData, self._packetType)
end

-- 刷新锁定显示
function MaterialEquipScrollInfoArea:refreshLock()
    if(self._goodsData and self._lock) then
        if(self._goodsData:getIsLock()) then
            self._lock:setSpriteName(SPRITE_ITEM_ICON_LOCK)
        else
            self._lock:setSpriteName(SPRITE_ITEM_ICON_UNLOCK)
        end
        self._lock:updateView()
    end
end

-- 初始化视图
function MaterialEquipScrollInfoArea:onInitView()
    local left = 22
    self:showLucencyLight()
    self:initLockORLink()

    -- 面板背景
    local goodsbg = UI.Image:create()
    goodsbg:init(SPRITE_EQUIPMENT_AREA_BG_UP)
    goodsbg:leftUp(0,0)
    self:addChild(goodsbg)
    local contentSize = goodsbg:getContentSize()
    self:setSize(contentSize.width, contentSize.height)
    self._bgheight = goodsbg._height
    AvalonUtil.runTipsAppearShowAnimation(self)

    -- 道具名称
    local  goodsName  = UI.Text:create()
    goodsName:init("",UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    goodsName:leftUp(105 -5, 15)
    goodsName:setTextLeft()
    goodsName:setWidth(210)
    goodsName:setLineSpacing(-5)
    self:addChild(goodsName)
    self._goodsName = goodsName

    local type = self._proptype

    -- 道具类型
    local goodsType = UI.Text:create()
    goodsType:init(string.format("%s", UI.TEXT_1170026), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsType:leftUp(105, 64 + 2)
    goodsType:setTextLeft()
    goodsbg:addChild(goodsType)
    
    -- 物品图标背景底框
    local spriteBg1 =  UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(left, 15)
    spriteBg1:setSize(GRID_SIZE_WIDTH, GRID_SIZE_HEIGHT)
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

    local lineX = 162
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(281, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(lineX, 320))
    goodsbg:addChild(lineUpImage, 4)

    local lineCenterImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineCenterImage:setContentSize(281, 1)
    lineCenterImage:setCapInsets(CCRectMake(1,0,1,1))
    lineCenterImage:setPosition(cc.p(lineX, 202))
    goodsbg:addChild(lineCenterImage, 4)

    -- 属性显示区域
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH,135)
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH,135)
    scrollView:init()
    scrollView:leftUp(left, 224)
    scrollView:addInnerNode(self._scrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarWidth(5)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    goodsbg:addChild(scrollView)    

    local lineBottomImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineBottomImage:setContentSize(281, 1)
    lineBottomImage:setCapInsets(CCRectMake(1,0,1,1))
    lineBottomImage:setPosition(cc.p(lineX, 50))
    goodsbg:addChild(lineBottomImage, 4)

    -- 描述信息
    local  equipmentDescribe  = UI.Text:create()
    equipmentDescribe:init("",UI.FONT_DES, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    -- equipmentDescribe:setFontSize(15)
    -- equipmentDescribe:setFontColor(UI.FONT_COLOR_140_43_27)
    -- equipmentDescribe:setWidth(210)
    equipmentDescribe:setSize(230,70)
    equipmentDescribe:setTextLeftUp()
    equipmentDescribe:leftBottom(left,35)
    self:addChild(equipmentDescribe)
    self._describe = equipmentDescribe

    -- 售卖价格
    local sellIcon = UI.Image:create()
    sellIcon:init("symbol_gaming_money.png")
    sellIcon:leftBottom(left, 8)
    goodsbg:addChild(sellIcon)
    self._sellIcon = sellIcon

    local sellText = UI.Text:create()
    sellText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    -- sellText:setFontSize(15)
    sellText:centerLeft(5+ sellIcon:getContentSize().width)
    -- sellText:setFontColor(UI.FONT_COLOR_41_41_45)
    sellIcon:addChild(sellText)
    self._sellText = sellText

    self:showSellPrice()
end

function MaterialEquipScrollInfoArea:initLockORLink()
    local startX = 20
    local startY = -34
    local offsetX = 50
    local haveLink = true
    local haveLock = true
    startX = startX + offsetX
    local type = self._proptype

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
        if (type == proptype.TASK_PROP  or type == proptype.TASK_MATERIAL )then 
            self._lock:setVisible(false)
        else
            if(self._lockShow == false) then
                self._lock:setVisible(false)
            else 
                self._lock:setVisible(true)
            end
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

function MaterialEquipScrollInfoArea:refreshLinkOrLockPosition()
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
function MaterialEquipScrollInfoArea:onUpdateView(data)
    if (data and self._goodsData ~= data) then self._goodsData = data
    end

    if (self._goodsData) then
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
            local iconSize = self._iconSprite:getContentSize()
            -- self._iconSprite:setScale(
            --     GRID_SIZE_WIDTH / iconSize.width,
            --     GRID_SIZE_HEIGHT/ iconSize.height
            -- )
        end

        -- 道具名字
        -- local name = data:getName()
        -- self._goodsName:setText(name)
        -- self._goodsName:autoAdapt()
       
        -- 描述信息
        self._describe:setText(string.format("%s",data:getDescription()))
        self._describe:updateView()

        local totalHeight = 0
        local type = self._proptype
        if(type == proptype.MATERIALINFO or type == proptype.TASK_MATERIAL) then --材料
            local AWARD_GLOD = "icon_gold.png"
            local AWARD_DIAMOND = "icon_diamonds.png"
            if(data:getMaterialType() == PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then 
                local nameList = data:getNameList()
                self._goodsName:setText(nameList[2])
                
                -- 配方标题
                local recipe = UI.Text:create()
                recipe:init(UI.TEXT_1170024, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                recipe:leftUp(0,totalHeight + 5)
                -- recipe:setFontSize(15)
                -- recipe:setFontColor(UI.FONT_COLOR_88_65_34)
                self._scrollLayout:addChild(recipe)
                totalHeight = totalHeight + recipe:getContentSize().height

                -- 需要的材料ID
                local value3 = AvalonUtil:splitStr(data.value3, ",")
                local value4 = AvalonUtil:splitStr(data.value4, ",")
                local nameWidth = 200
                for i=1,#value3 do 
                    -- local point = UI.Image:create()
                    -- point:init("ui_iteminfo_icon_point_01.png")
                    -- point:leftUp(0, totalHeight + 12.5)
                    -- self._scrollLayout:addChild(point)

                    -- local iconName = GoodsDataManager:createLocalGoodsData(value3_ID1):getName()
                    local materNameStr = "..."
                    local proData = GoodsDataManager:createLocalGoodsData(tonumber(value3[i]))
                    if(proData) then
                        materNameStr = proData:getName()
                    end 
                    -- materNameStr = "dddfsfewfwefwefwefewfwefwefewfewfewef"
                    local materNameText = UI.Text:create()
                    materNameText:init(materNameStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                    -- materNameText:leftUp(point._width + 3, totalHeight + 5)
                    materNameText:leftUp(0, totalHeight + 5)
                    if(materNameText:getContentSize().width > nameWidth) then 
                        materNameText:setWidth(nameWidth)
                        materNameText:setText(materNameStr)
                    end

                    self._scrollLayout:addChild(materNameText)

                    local goodsNum = GoodsDataManager:getGoodsDataNum(RoleDataManager:getMasterPK(), PACKET_TYPE.PACKET_BAG, tonumber(value3[i]), true)
                    local needNum = tonumber(value4[i])
                    local percent = MasterDataManager:getEffValueByEffType(PublicDefine.ATTR_TYPE.ForgeDiscountRate)
                    if percent > 0 then
                         needNum = math.ceil(needNum * (RATIO_NUMBER - percent) / RATIO_NUMBER)
                    end
                    goodsNum = goodsNum > needNum and needNum or goodsNum
                    local materNumText = UI.Text:create()
                    if(goodsNum >= needNum) then
                        materNumText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_15_85_71)
                    else
                        materNumText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
                    end
                    -- materNumText:setFontColor(UI.FONT_COLOR_181_32_32)
                    materNumText:setWidth(150)
                    materNumText:setTextRight()
                    -- materNumText:setFontSize(16)
                    materNumText:rightUp(21, totalHeight + 6)

                    materNumText:setText(string.format("(%d/%d)",goodsNum,needNum))
                    self._scrollLayout:addChild(materNumText)
                    -- if (goodsNum >= needNum) then
                    --     materNameText:setFontColor(UI.FONT_COLOR_88_65_34)
                    --     materNumText:setFontColor(UI.FONT_COLOR_88_65_34)
                    -- end

                    totalHeight = totalHeight + materNameText:getContentSize().height
                end 
                local result = data.value2
                local resultTable = AvalonUtil:splitStr(result, ",")
                local value1 = data.value1
                local value1Table = AvalonUtil:splitStr(value1, ",")
                local value1TableK1 =  tonumber(value1Table[1])
                local value1TableK2 =  tonumber(value1Table[2])

                local  x = tonumber(resultTable[1])
                local  y = tonumber(resultTable[2])
                
                local materNickName = "..."
                local wearLv = 100

                local materItem = GoodsDataManager:createLocalGoodsData(value1TableK1)
                if(materItem) then
                    materNickName = materItem:getName()
                    wearLv = materItem:getWearLV()
                end
                if y > 0 then
                    self._describe:show()
                else
                    self._describe:hide()
                end

                -- 集齐配方中的材料，可以合成
                local text = AvalonUtil:formartRichText(UI.FONT_COLOR_41_41_45, UI.FONT_SIZE_16PX, UI.FONT_STANDARD, UI.TEXT_1170934.."\n")
                text = text..AvalonUtil:formartRichText(UI.ITEM_QUALITY_FONT_COLOR[data:getGoodsRare()], UI.FONT_SIZE_16PX, UI.FONT_STANDARD, string.format("%s",materNickName))
                local _richText = UI.RichText:create(-3)
                local success = _richText:init(text, 200, 94)
                if success == false then
                    return
                end
                _richText:leftUp(22, 110)
                -- _richText:enableDebugDraw()
                self:addChild(_richText)

                -- 添加配方的图标
                

                -- 等级需求
                local level, reinLv = RoleDataManager:getUIShowLvByItemData(wearLv)
                local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
                local level = UI.Text:create()
                level:init(UI.TEXT_DES_LEVEL_NEED..showLv, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
                level:rightBottom(30, 8)
                self:addChild(level)

                if RoleDataManager:getMaster():getLevel() < wearLv then
                    level:setFontColor(UI.FONT_COLOR_80_5_5)
                else
                    level:setFontColor(UI.FONT_COLOR_41_41_45)
                end
            end 
        end
        if(totalHeight < 137) then 
            totalHeight = 137
        end
        self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)

        -- self._goodsDes:centerUp(self._goodsName:getUp() + self._goodsName:getContentSize().height - 1)

        -- 生成的物品
        local makeGoodsData = self._goodsData:getMakeGoodsData()
        if(makeGoodsData) then 
            local spriteBg1 =  UI.Image:create()
            spriteBg1:init("box_quality_box_01.png")
            spriteBg1:rightUp(25, 110)
            spriteBg1:setSize(GRID_SIZE_WIDTH, GRID_SIZE_HEIGHT)
            self:addChild(spriteBg1) 

            local rare = makeGoodsData:getGoodsRare()
            local goodsGroupType = makeGoodsData:getGoodsGroupType()
            local spriteBg =  UI.Image:create()
            spriteBg:init(string.format("box_quality_%s_%s.png",goodsGroupType,rare))
            spriteBg:center()
            spriteBg1:addChild(spriteBg) 
            
            -- 物品图标
            local iconSprite = UI.Image:create()
            iconSprite:init(makeGoodsData:getIconName())
            iconSprite:center()
            spriteBg:addChild(iconSprite)


            spriteBg1:setTouchEnable(true)
            spriteBg1:addEventListener(UI.Event.COMPONENT_CLICK, self,function ()
                self:onTouchLongTimeBeganHandler(makeGoodsData)       
            end)

            -- local function onTouchBegan(touch, event)   
            --     if(not tolua.isnull(spriteBg1)) then 
            --         if(spriteBg1:isVisible() == false) then 
            --             return false
            --         end
            --     end
            --     local posStarTouch = touch:getLocation()
            --     local point  = spriteBg1:convertToWorldSpace(cc.p(0,0))
            --     local width  = spriteBg1:getContentSize().width
            --     local height = spriteBg1:getContentSize().height
            --     local rect = cc.rect(point.x , point.y, width , height) 
            --     if cc.rectContainsPoint(rect, posStarTouch) then  
            --         self:onTouchLongTimeBeganHandler(makeGoodsData)
            --         return true
            --     end

            --     return false
            -- end

            -- local function onTouchEnded(touch, event)
            --     local posTouch = touch:getLocation()
            --     if (self._isTouchLongTime) then
            --         self._isTouchLongTime = false
            --     end
            -- end

            -- local listener = cc.EventListenerTouchOneByOne:create()
            -- listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
            -- listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
            -- listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_CANCELLED )

            -- local eventDispatcher = self:getEventDispatcher()
            -- eventDispatcher:addEventListenerWithSceneGraphPriority(listener, spriteBg1)
            -- listener:setSwallowTouches(true)

        end
    end

    self:refreshLock()
    self:showSellPrice()
end

function MaterialEquipScrollInfoArea:onTouchLongTimeBeganHandler(goodsData)
    if not tolua.isnull(self._pInfoArea) then
        self._pInfoArea:removeSelf()
        self._pInfoArea = nil
    end

    self._isTouchLongTime = true
    print("====弹出页面===  2")
    local pInfoArea = nil;
    pInfoArea = UI.EquipmentInfoArea:create()
    -- pInfoArea:init(goodsData)
    pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
    pInfoArea:hideCompInfo()
    pInfoArea:setHideLink(true)
    -- local worldPos = self:convertToWorldSpace(cc.p(0,0))
    local worldPos = self:convertToWorldSpace(cc.p(0,0))
    local positionY = worldPos.y - pInfoArea:getContentSize().height/2 + self:getContentSize().height/2
    
    if(positionY < Avalon.issUtil:getBottomMargin()) then
        positionY = Avalon.issUtil:getBottomMargin()
    end

    if worldPos.x < winSize.width/2 then
        pInfoArea:leftBottom(self:getContentSize().width, 0)
    else
        pInfoArea:leftBottom(0 - pInfoArea:getContentSize().width, 0)
    end

    local function infoOutSizeTouchHandler(self,obj,touchPosition)
        -- 更新装备对比区域数据
        if(not tolua.isnull(self._pInfoArea)) then
            self._pInfoArea:close()
            self._pInfoArea = nil
        end
    end
    pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, infoOutSizeTouchHandler)

    pInfoArea:setVisible(true)
    pInfoArea:updateView(goodsData)
    pInfoArea:closeLockFlag() 
    self._pInfoArea = pInfoArea
    self:addChild(pInfoArea, UI_ZORDER.TIPS)
    Avalon.AudioManager:playSound("1503")
end

function MaterialEquipScrollInfoArea:setHideLink(isHideLink)
    if(self._proptype ~= proptype.VIRTUALITEM_INFO) then
        if isHideLink and not tolua.isnull(self.linkBG) then
            self.linkBG:hide()
        end
    else 
        if(not tolua.isnull(self.linkBG)) then
            self.linkBG:hide()
        end
    end
    self:refreshLinkOrLockPosition()
end

function MaterialEquipScrollInfoArea:showSellPrice()
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