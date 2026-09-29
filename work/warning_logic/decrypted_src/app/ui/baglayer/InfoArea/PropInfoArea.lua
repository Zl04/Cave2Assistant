--[[
    UI - 背包中的道具详情界面
]]--

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.ScrollView"
require "app.ui.baglayer.InfoArea.PropInfoCountSelectTips"
require "app.datas.RoleDataManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local PropInfoArea = class("PropInfoArea", UI.HWBtnComponent)
UI.PropInfoArea = PropInfoArea

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
-- 背包资源
local BAG_EQUIPMENT_INFO_AREA_RES_LIST = {

}

local SPRITE_GRID_RARE_1 = "box_quality_0_1.png"
local SPRITE_EQUIPMENT_ALL = "icon-equip_large_21010010.png"
local SPRITE_EQUIPMENT_NAME = "icon-equip_large_210%s0010.png"
local SPRITE_EQUIPMENT_WEAPON = "icon-equip_large_210%s0010_%s.png"

-- 背景1
local SPRITE_EQUIPMENT_AREA_BG_UP = "ui_iteminfo_role_banner_box3.png" 
-- 属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT = "ui_iteminfo_icon_point_01.png"
-- 套装属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT_SUIT = "ui_iteminfo_icon_point_02.png"
-- 锁按钮的三个状态
local SPRITE_ITEM_ICON_LOCK = "ui_iteminfo_btn_locked.png"
local SPRITE_ITEM_ICON_UNLOCK = "ui_iteminfo_btn_unlock.png"
local SPRITE_EQUIPMENT_LEVEL = "symbol_character_hero_power.png"
-- 布局的宽
local LAYOUT_SIZE_WIDTH  = 300 

local LEFT_SPACE = 30

local upLayout = nil
local fontsize = UI.FONT_SIZE_16PX
local font     = UI.FONT_ARIAL

local VIRTUAL_ITEM_TYPE = PublicDefine.VIRTUAL_ITEM_TYPE

-- 构造函数
function PropInfoArea:ctor(isHideBtn)

    PropInfoArea.super.ctor(self, UIType.PROP_INFO_AREA, BAG_EQUIPMENT_INFO_AREA_RES_LIST, width, height)
    
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
    if isHideBtn == nil then
        self._isHideBtn = true
    else
        self._isHideBtn = isHideBtn --聊天界面打开的超链接 要屏蔽掉使用按钮
    end
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)    
end

-- 析构函数
function PropInfoArea:dtor()

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

    PropInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- public:
-- 初始化
function PropInfoArea:init(proptype,data)
    self._proptype = proptype 
    self._goodsData = data

    PropInfoArea.super.init(self, data)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
end

-- 销毁
function PropInfoArea:onDestroy()
    self._packetType = nil
end


function PropInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function PropInfoArea:getGoodsGrid()
    return self._goodsGrid
end


-- 设置的操作的包裹类型
function PropInfoArea:setPacketType(packetType)
    self._packetType = packetType
end

-- 显示价格
function PropInfoArea:setShowSellPrice(flag)
    self._showSellPrice = flag
    self:showSellPrice()
end

-- 锁定状态改变
function PropInfoArea:lockStatusChange(data)
    UI.WaitingLayer:hideWaiting()
    if self._goodsData then
        if(self._packetType == PACKET_TYPE.PACKET_WAREHOUSE or data.packetType == PACKET_TYPE.PACKET_WAREHOUSE) then
            if(self._packetType ~= data.packetType) then
                return
            end
        end

        if(data.templateID == self._goodsData:getGoodsID()) then
            -- print("PropInfoArea:lockStatusChange ", data.isLock, self._goodsData:getIsLock())
            self:refreshLock()
        end
    end
end

-- 关闭锁定标志
function PropInfoArea:closeLockFlag()
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
function PropInfoArea:openLockFlag()
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
function PropInfoArea:refreshLock()
    if(self._goodsData and self._lock) then
        if(self._goodsData:getIsLock()) then
            self._lock:setSpriteName(SPRITE_ITEM_ICON_LOCK)
        else
            self._lock:setSpriteName(SPRITE_ITEM_ICON_UNLOCK)
        end
        self._lock:updateView()
    end

    self:refreshButtons()
end

function PropInfoArea:judgeOpenSelect()
    if(SceneManager:getInstance():isInFightScene()) then 
        return false
    else 
        return true
    end
end

function PropInfoArea:refreshButtons()
    if (self.buttonAddExpUse) then
        local isInTown = self:judgeOpenSelect()
        self.buttonAddExpUse:setVisible(isInTown) 
        -- add by zp 锁定的物品无法使用
        if(self._goodsData and self._goodsData:getIsLock()) then 
            self.buttonAddExpUse:disable()
        else 
            self.buttonAddExpUse:enable()
        end
    end
end

-- 初始化视图
function PropInfoArea:onInitView()
    local left = 16 
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
    local nameOffsetX = 100
    local  goodsName  = UI.Text:create()
    goodsName:init("",UI.FONT_STANDARD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsName:leftUp(nameOffsetX, 16)
    goodsName:setTextLeft()
    goodsName:setWidth(200)
    goodsName:setLineSpacing(-5)
    self:addChild(goodsName)
    self._goodsName = goodsName

    local type = self._proptype
    local goodsDes = UI.Text:create()
    goodsDes:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsDes:leftUp(nameOffsetX, 66)
    -- goodsDes:setFontSize(16)
    -- goodsDes:setFontColor(UI.FONT_COLOR_41_41_45)
    goodsDes:setTextLeft()
    self:addChild(goodsDes)
    self._goodsDes = goodsDes
    -- goodsDes:setText(desStr)
    
    -- 物品图标背景底框
    local spriteBg1 =  UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(left, 16)
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
    lineUpImage:setPosition(cc.p(lineX, 183))
    goodsbg:addChild(lineUpImage, 4)

    -- 属性显示区域
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH,68)
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH,68)
    scrollView:init()
    scrollView:leftUp(left, 101)
    scrollView:addInnerNode(self._scrollLayout)
    scrollView:useDefaultScrollBar()
    self:addChild(scrollView)    

    -- 描述信息
    local  equipmentDescribe  = UI.Text:create()
    equipmentDescribe:init("",UI.FONT_DES, UI.FONT_SIZE_16PX, UI.FONT_COLOR_82_82_82)
    -- equipmentDescribe:setFontSize(15)
    -- equipmentDescribe:setFontColor(UI.FONT_COLOR_140_43_27)
    equipmentDescribe:setSize(280,70)
    equipmentDescribe:setTextLeftUp()
    equipmentDescribe:leftUp(left + 4, 181)
    self:addChild(equipmentDescribe)
    self._describe = equipmentDescribe

    local lineBottomImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineBottomImage:setContentSize(281, 1)
    lineBottomImage:setCapInsets(CCRectMake(1,0,1,1))
    lineBottomImage:setPosition(cc.p(lineX, 105))
    goodsbg:addChild(lineBottomImage, 4)

    -- 售卖价格
    local sellIcon = UI.Image:create()
    sellIcon:init("symbol_gaming_money.png")
    sellIcon:leftBottom(left, 8)
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
 
    local buttonUse = UI.Button:create()
    buttonUse:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png")
    buttonUse._clickScale = false
    buttonUse:centerBottom(14)
    buttonUse:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    buttonUse:setText(UI.TEXT_111169)
    self:addChild(buttonUse)

    buttonUse:addEventListener(UIEvent.BUTTON_CLICK, self, self.onUseButton)
    buttonUse:setVisible(false)
    self.buttonUse = buttonUse

    local buttonGo = UI.Button:create()
    buttonGo:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png")
    buttonGo._clickScale = false
    buttonGo:centerBottom(14)
    buttonGo:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    buttonGo:setText(UI.TEXT_111169)
    self:addChild(buttonGo)
    buttonGo:hide()
    self.buttonGo = buttonGo
end

function PropInfoArea:initLockORLink()
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
        lockBtn:setScale(0.9)

        local lock = UI.Image:create()
        lock:init(SPRITE_ITEM_ICON_UNLOCK)
        lock:center()
        lockBtn:addChild(lock, 20)
        self._lock = lock
        self._lockBtn = lockBtn
        startX = startX - offsetX
        
        if (type == proptype.TASK_PROP  or type == proptype.TASK_MATERIAL )then 
            self._lock:setVisible(false)
        else
            if(self._lockShow == false) then
                self._lockBtn:setVisible(false)
            else 
                self._lockBtn:setVisible(true)
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
        self.linkBG = link
        link:setScale(0.9)

        if(type == proptype.VIRTUALITEM_INFO) then
            self.linkBG:hide()
        end
    end

    self:refreshLinkOrLockPosition()
end

function PropInfoArea:refreshLinkOrLockPosition()
    local startX = 20
    local offsetX = 50
    local startY = -34
    local haveLink = false 
    local haveLock = false

    if(not tolua.isnull(self._lockBtn)) then 
        haveLock = true
    end

    if(not tolua.isnull(self.linkBG)) then 
        haveLink = true
        startX = startX + offsetX
    end

    if(haveLock) then 
        self._lockBtn:rightUp(startX, startY)
        startX = startX - offsetX
    end

    if(haveLink) then 
        self.linkBG:rightUp(startX, startY)
        startX = startX - offsetX
    end
end

-- 更新视图
function PropInfoArea:onUpdateView(data)
    if (data and self._goodsData ~= data) then self._goodsData = data
    end

    if (self._goodsData) then
        -- 刷新，这里宠物蛋不用锁定
        -- self:openLockFlag()
        if(self._goodsData and self._goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
            if self._goodsData:getItemType() == PublicDefine.ITEM_TYPE.PetEgg then
                self:closeLockFlag()
            end
        end


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
        end

        -- 道具名字
        local name = data:getName()
        self._goodsName:setText(name)
        self._goodsName:autoAdapt()
        -- 描述信息
        self._describe:setText(string.format("%s",data:getDescription()))
        self._describe:updateView()

        local totalHeight = 0
        local type = self._proptype

        if(type == proptype.PROPINFO 
            or type == proptype.TASK_PROP 
            or type == proptype.VIRTUALITEM_INFO) then --道具
            if self:getChildByName("baseText") then
                self:removeChildByName("baseText")
            end
            local baseText = UI.Text:create()
            baseText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            baseText:setWidth(270)
            baseText:setTextLeft()
            baseText:leftUp(18, 105)
            baseText:setText(data:geteffecDescription())
            baseText:setName("baseText")
            self:addChild(baseText)
            if(type == proptype.VIRTUALITEM_INFO) then
                self.linkBG:hide()
                self:refreshLinkOrLockPosition()
            end
            totalHeight = totalHeight + baseText:getContentSize().height

            if (data.getItemType and data:getItemType() == PublicDefine.ITEM_TYPE.AddExp and not self._isHideBtn) then

                local buttonUse = UI.Button:create()
                buttonUse:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png", {x=0, y=0})
                buttonUse._clickScale = false
                buttonUse._baseline = 1
                buttonUse:setLayoutType(UI.LayoutDefaultType.DEFAULT)
                buttonUse:centerBottom(14)
                buttonUse:setFontColor({r=50,g=50,b=44})
                buttonUse:setText(UI.TEXT_111169)
                self:addChild(buttonUse)
                self.buttonAddExpUse = buttonUse
                buttonUse:setName("buttonUse")
                buttonUse:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                    

                    local heroData = RoleDataManager:getMaster()
                    if(heroData) then
                        if (heroData:getIsMaxLevel()) then
                            UI.ScrollBar:createByText(UI.TEXT_221203)
                        else
                            local maxNum = self._goodsData:getNum()
                            local tips = UI.PropInfoCountSelectTips:create()
                            tips:init(maxNum)
                            function okCallback(num)
                                local useNum = 0
                                if(num ~= nil) then
                                    useNum = num
                                end
                                Net.NetGoodsSystem:useItemRequest(self._goodsData:getGoodsID(),self._goodsData:getIsGolden(),heroData:getSpriteID(),nil,nil,useNum)
                                if self and (not tolua.isnull(self)) then
                                    self:close()
                                end
                            end
                            tips:callfunName(okCallback, function()
                            end)
                            self:addChild(tips, 1000)


                            -- local tips = UI.Tips:createTips(string.format(UI.TEXT_221202, self._goodsData._localConfig.extendValue1),UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
                            -- -- 确定和取消事件监听
                            -- tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
                            --     local master = GameDataManager:getInstance():getMaster()
                            --     AudioUtil:playUseItemSound(self._goodsData:getGoodsID())
                            --     Net.NetGoodsSystem:useItemRequest(
                            --         self._goodsData:getGoodsID(),
                            --         self._goodsData:getIsGolden(),
                            --         master:getSpriteID()
                            --     )
                            --     self:close()
                            -- end)
                        end
                    end
                end)
            elseif (data.getItemType and (data:getItemType() == PublicDefine.ITEM_TYPE.StarCard 
            or data:getItemType() == PublicDefine.ITEM_TYPE.TransCard) and not self._isHideBtn) then
                local buttonUse = UI.Button:create()
                buttonUse:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png", {x=0, y=0})
                buttonUse._clickScale = false
                buttonUse._baseline = 1
                buttonUse:setLayoutType(UI.LayoutDefaultType.DEFAULT)
                buttonUse:centerBottom(14)
                buttonUse:setFontColor({r=50,g=50,b=44})
                buttonUse:setText(UI.TEXT_111169)
                self:addChild(buttonUse)
                self.buttonAddExpUse = buttonUse
                buttonUse:setName("buttonUse")
                buttonUse:addEventListener(UIEvent.BUTTON_CLICK, self, function()

                    local tStr = UI.TEXT_222622

                    if data:getItemType() == PublicDefine.ITEM_TYPE.TransCard then
                        tStr = UI.TEXT_223300
                    end
                    local tips = UI.Tips:createTips(tStr,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
                    -- 确定和取消事件监听
                    tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
                        local master = GameDataManager:getInstance():getMaster()
                        AudioUtil:playUseItemSound(self._goodsData:getGoodsID())
                        Net.NetGoodsSystem:useItemRequest(
                            self._goodsData:getGoodsID(),
                            self._goodsData:getIsGolden(),
                            master:getSpriteID()
                        )
                        self:close()
                    end)
                end)
            end


        elseif(type == proptype.MATERIALINFO or type == proptype.TASK_MATERIAL) then --材料
            local  attdata =  data:getDetailDescription()
            if(attdata) then
                self._scrollLayout:removeAllChildren()
                for i,data in ipairs(attdata) do 
                    -- 道具相关的描述 前面带点的
                    -- local point = UI.Image:create()
                    -- point:init(SPRITE_EQUIPMENT_AREA_POINT)
                    -- point:leftUp(0, totalHeight + 12.5)
                    -- self._scrollLayout:addChild(point)
                    
                    -- print("----",data,data)
                    local  baseText  = UI.Text:create()
                    baseText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                    -- baseText:setFontSize(15)
                    baseText:setTextLeft()
                    baseText:setWidth(LAYOUT_SIZE_WIDTH - 20)
                    -- baseText:setFontColor(UI.FONT_COLOR_88_65_34)
                    -- baseText:leftUp(point._width + 3, totalHeight + 5)
                    baseText:leftUp(4, totalHeight + 5)
                    baseText:setText(data)
                    self._scrollLayout:addChild(baseText)
                    totalHeight = totalHeight + baseText:getContentSize().height + 5
                end 
            end 

            -- 原石等级  symbol_character_hero_power_0     ui_information_equip2
            if data.materialType == PublicDefine.MATERIAL_TYPE.MaterialPrimogem then
                -- local config = ConfigManager:getGlyphByID(data.goodsID)
                local left = 145 
                for i=1,3 do
                    if data.starType >= i then
                        local glyphLevelPic = UI.Image:create()
                        glyphLevelPic:init("ui_information_equip2.png")
                        glyphLevelPic:leftUp(left + i * 20 + 60, 65)
                        self:addChild(glyphLevelPic) 
                    else
                        local glyphLevelPic = UI.Image:create()
                        glyphLevelPic:init("symbol_character_hero_power_0.png")
                        glyphLevelPic:leftUp(left + i * 20 + 60, 68)
                        self:addChild(glyphLevelPic) 
                    end
                end
            end
        end
        if(totalHeight < 68) then 
            totalHeight = 68
        end
        self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)

        if (type == proptype.MATERIALINFO or type == proptype.TASK_MATERIAL) and data:getMaterialType() == PublicDefine.MATERIAL_TYPE.MaterialDungeonKey then
            self._goodsDes:setText(UI.TEXT_1170213)
        else 
            -- 描述
            local desStr = ""
            if(type == proptype.PROPINFO or type == proptype.TASK_PROP) then 
                desStr = UI.TEXT_111019
            elseif(type == proptype.MATERIALINFO or type == proptype.TASK_MATERIAL) then 
                if self._goodsData.materialType == PublicDefine.MATERIAL_TYPE.MaterialPrimogem then
                    if (self._goodsData.partType == PublicDefine.EQUIPMENT_TYPE.Helmet) then -- 头盔 1 8 4 3是角色左边的装备
                        languageID = 1111378
                    elseif (self._goodsData.partType == PublicDefine.EQUIPMENT_TYPE.Weapon) then -- 武器
                        local weaponType = self._goodsData.occupationType -- 获取武器类型
                        languageID = 1111375
                        if (weaponType == 1) then
                            languageID = 1111376
                        elseif (weaponType == 2) then
                            languageID = 1111375
                        elseif (weaponType == 3) then
                            languageID = 1111377
                        end
                    elseif (self._goodsData.partType == PublicDefine.EQUIPMENT_TYPE.Gloves) then -- 手套
                        languageID = 1111381
                    elseif (self._goodsData.partType == PublicDefine.EQUIPMENT_TYPE.Shoulders) then -- 肩甲
                        languageID = 1111379
                    elseif (self._goodsData.partType == PublicDefine.EQUIPMENT_TYPE.Amulet) then -- 项链
                        languageID = 1111383
                    elseif (self._goodsData.partType == PublicDefine.EQUIPMENT_TYPE.Ring) then -- 戒指
                        languageID = 1111384
                    elseif (self._goodsData.partType == PublicDefine.EQUIPMENT_TYPE.Chest) then -- 胸甲
                        languageID = 1111380
                    elseif (self._goodsData.partType == PublicDefine.EQUIPMENT_TYPE.Boots) then -- 鞋子
                        languageID = 1111382
                    end
                    local LanguageManager = require "app.game.LanguageManager"
                    local languageManagerInstance = LanguageManager:getInstance()
                    desStr = languageManagerInstance:getLocalString(languageID)
                else
                    desStr = UI.TEXT_111020
                end
                
            elseif(type == proptype.VIRTUALITEM_INFO) then 
                -- print("PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemTitle=", self._goodsData:getVirtualType(), PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemTitle)
                if(self._goodsData and self._goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemTitle) then
                    desStr = UI.TEXT_1212037
                else 
                    desStr = UI.TEXT_111019
                end
            end 

            self._goodsDes:setText(desStr)
        end

        if not self._isHideBtn and self._goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM and self._goodsData:getItemType() == PublicDefine.ITEM_TYPE.PetHPPotion then  
            self.buttonUse:show()
        end
    end

    self:refreshLock()
    self:showSellPrice()

    self:refreshButtons()
end

function PropInfoArea:setHideLink(isHideLink)
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

function PropInfoArea:showSellPrice()
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

function PropInfoArea:onUseButton()
    if self._goodsData:getIsLock() then
        UI.ScrollBar:createByText(UI.TEXT_110030)
        return
    end

    local master = RoleDataManager:getMaster()
    if #MasterDataManager:getBagPets() == 0 then 
        UI.ScrollBar:createByText(UI.TEXT_1213726)
        return
    end

    local remainBlood = master:getPetHpStorage() - master:getPetCurHpStorage()
    local perSupply = self._goodsData.extendValue2
    local goodNum = self._goodsData:getNum()
    if remainBlood > 0 then

        local maxNum = math.ceil(remainBlood / perSupply)
        local tips = UI.PropInfoCountSelectTips:create()
        tips:init(math.min(maxNum, goodNum))
        function okCallback(num)
            local useNum = 0
            if(num ~= nil) then
                useNum = num
            end
            --CO-17760
-- 连续两次一次性使用99个饼干会掉线，试过很多次，每次连续两次99必定掉线（客户端）
            -- for i = 1, useNum do 
                Net.NetGoodsSystem:useItemRequest(self._goodsData:getGoodsID(),self._goodsData:getIsGolden(),master:getSpriteID(),nil,nil,useNum)
                if self and (not tolua.isnull(self)) then
                    self:close()
                end
            -- end
        end
        tips:callfunName(okCallback, function()
        end)
        self:addChild(tips, 1000)
    else
        UI.ScrollBar:createByText(UI.TEXT_1213727)
    end
end

function PropInfoArea:setButtonGoShow(callBack)
    if not self.buttonGo then
        return
    end

    self.buttonGo:addEventListener(UIEvent.BUTTON_CLICK, self, callBack)
    self.buttonGo:show()
end