--[[
    UI - 背包中的X选Y礼包详情界面
]]--

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.ScrollView"
local SceneManager = require("app.game.SceneManager")
UI = UI or {}
local winSize = cc.Director:getInstance():getWinSize()
local SelectGoodsBagInfoArea = class("SelectGoodsBagInfoArea", UI.HWBtnComponent)
UI.SelectGoodsBagInfoArea = SelectGoodsBagInfoArea
local PACKET_TYPE = PublicDefine.PACKET_TYPE 
local CELL_NUMBER = 3
local STATUS = {
    OPEN = 1,
    SELECT = 2,
    SELECTED = 3,
}
local SPRITE_ITEM_ICON_LOCK = "ui_iteminfo_btn_locked.png"
local SPRITE_ITEM_ICON_UNLOCK = "ui_iteminfo_btn_unlock.png"
local SPRITE_EQUIPMENT_LEVEL = "symbol_character_hero_power.png"
local proptype = UI.PROP_MATER 
-- 构造函数
function SelectGoodsBagInfoArea:ctor(fromBag)

    SelectGoodsBagInfoArea.super.ctor(self, UIType.PROP_INFO_AREA, BAG_EQUIPMENT_INFO_AREA_RES_LIST, width, height)
    
    self._fromBag = fromBag
    self._lock = nil 
    -- 是否显示锁定标志
    self._lockShow = true
    -- false未锁定，true锁定
    self._lockstate = false
    
    self._selectItems = {}
    self.allGridNode = {}
    self._maxSelectNum = 3
    self._goodsId = 20010011
    self._goodsData = nil
    self._buttonStatus = STATUS.OPEN
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)    
end

-- 析构函数
function SelectGoodsBagInfoArea:dtor()
    -- 是否显示售卖价格，这里只会在商店层显示
    self._showSellPrice = false

    SelectGoodsBagInfoArea.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- public:
-- 初始化
function SelectGoodsBagInfoArea:init(proptype)
    self._proptype = proptype 

    SelectGoodsBagInfoArea.super.init(self, data)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
end

-- 销毁
function SelectGoodsBagInfoArea:onDestroy()
    self._packetType = nil
end


function SelectGoodsBagInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function SelectGoodsBagInfoArea:getGoodsGrid()
    return self._goodsGrid
end


-- 设置的操作的包裹类型
function SelectGoodsBagInfoArea:setPacketType(packetType)
    self._packetType = packetType
end

-- 显示价格
function SelectGoodsBagInfoArea:setShowSellPrice(flag)
    self._showSellPrice = flag
    self:showSellPrice()
end

-- 锁定状态改变
function SelectGoodsBagInfoArea:lockStatusChange(data)
    UI.WaitingLayer:hideWaiting()
    if self._goodsData then
        if(self._packetType == PACKET_TYPE.PACKET_WAREHOUSE or data.packetType == PACKET_TYPE.PACKET_WAREHOUSE) then
            if(self._packetType ~= data.packetType) then
                return
            end
        end

        if(data.templateID == self._goodsData:getGoodsID()) then
            print("SelectGoodsBagInfoArea:lockStatusChange ", data.isLock, self._goodsData:getIsLock())
            self:refreshLock()
        end
    end
end

-- 关闭锁定标志
function SelectGoodsBagInfoArea:closeLockFlag()
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
function SelectGoodsBagInfoArea:openLockFlag()
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
function SelectGoodsBagInfoArea:refreshLock()
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
local function onCancelHandler(self)
    -- self:close();
    self:dispatchEvent(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, nil, nil)
end
local function onCenterCancel(self)
   self:dispatchEvent(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, nil, nil)
end
local function onUseButton(self)
    if self._buttonStatus == STATUS.OPEN then
        self._buttonStatus = STATUS.SELECT
        self:refreshButtons()
        self:refreshNums()
        for i,v in ipairs(self.allGridNode) do
            v:showChoiceStatus()
        end
    end
end
local function onOkHandler(self)
    if not self:judgeOpenSelect() then
        printError("无法在洞窟打开礼包")
        return;
    end
    if self._buttonStatus ~= STATUS.SELECTED then
        printWarn("开启礼包的时候UI状态不正确")
        return
    end
    if table.nums(self._selectItems) <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_111173)
        print("请选择物品后开启")
        return
    end
    if table.nums(self._selectItems) < self._maxSelectNum then
        UI.ScrollBar:createByText(string.format(UI.TEXT_111170,self._maxSelectNum))
        printWarn("开启礼包的时候选择数量不正确")
        return
    end
    local itemID = self._goodsData.ID
    local chooseList = {}
    -- dump(self._selectItems)
    local goodsArr = {}
    for i,v in ipairs(self._selectItems) do
        local data = v.value:getData()
        table.insert(chooseList,{pos = v.pos - 1,itemID = data.ID})

        local goodsData = {}
        goodsData.goodsID = data.ID
        goodsData.num = data:getNum() == 0 and 1 or data:getNum()
        goodsData.isGolden = true
        table.insert(goodsArr, goodsData)
    end

    local GameDataManager = require("app.game.GameDataManager")
    local isEnough, type = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    print("---=judgeEnoughPacketForGoodsArr---", isEnough, type)
    if (not isEnough) then
        if type == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
            UI.ScrollBar:createByTextID(1170218)
            return false
        else
            UI.ScrollBar:createByText(UI.TEXT_111171)
            return false
        end
    end
    printInfo(itemID,chooseList)
    Net.NetGoodsSystem:reqUseChooseBag(itemID,chooseList)
    self:dispatchEvent(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, nil, nil)
end
-- 初始化视图
function SelectGoodsBagInfoArea:onInitView()
    local left = 16 
    self:showLucencyLight()
    self:initLockORLink()

    local bg = UI.Image:create()
    bg:init("ui_iteminfo_role_banner_box1.png")
    bg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bg:computePosition()
    bg:setName("bg")
    bg:leftUp(0,0)
    local contentSize = bg:getContentSize()
    self:setSize(contentSize.width, contentSize.height)
    self:addChild(bg)
    self.bg = bg

    AvalonUtil.runTipsAppearShowAnimation(self)


    local GRID_SIZE_WIDTH  = 74 
    local GRID_SIZE_HEIGHT = 74 
    local SPRITE_GRID_RARE_1 = "box_quality_0_1.png"
    local left = 16
     -- 道具名称
    local nameOffsetX = 100
    local goodsName  = UI.Text:create()
    goodsName:init("fafafafa",UI.FONT_STANDARD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsName:leftUp(nameOffsetX, 16)
    goodsName:setTextLeft()
    goodsName:setWidth(200)
    goodsName:setLineSpacing(-5)
    bg:addChild(goodsName)
    self.goodsName = goodsName

    
    local goodsDes = UI.Text:create()
    goodsDes:init("dadadad", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsDes:leftUp(nameOffsetX, 66)
    goodsDes:setTextLeft()
    bg:addChild(goodsDes)
    self.goodsDes = goodsDes
    -- goodsDes:setText(desStr)
    
    -- 物品图标背景底框
    local spriteBg1 =  UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(left, 16)
    spriteBg1:setSize(GRID_SIZE_WIDTH, GRID_SIZE_HEIGHT)
    bg:addChild(spriteBg1) 

    -- 物品图标背景
    local spriteBg =  UI.Image:create()
    spriteBg:init(SPRITE_GRID_RARE_1)
    spriteBg:center()
    spriteBg1:addChild(spriteBg) 
    self.spriteBg = spriteBg

    -- 物品图标
    local iconSprite = UI.Image:create()
    iconSprite:init()
    iconSprite:center()
    spriteBg:addChild(iconSprite)
    self.iconSprite = iconSprite
    -- 分割线
    local line1 = UI.Image9:create()
    line1:init("ui_scale9image_banner_line_light.png",{x=0,y=0,width=20,height=20})
    line1:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    line1:setReflectPos(21, 94)
    line1:setLocalZOrder(1)
    line1:setReflectSize(283, 2)
    line1:computePosition()
    bg:addChild(line1)
    line1:setName("line1")
    self.line1 = line1


    -- 分割线
    local line1 = UI.Image9:create()
    line1:init("ui_scale9image_banner_line_light.png",{x=0,y=0,width=20,height=20})
    line1:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    line1:setReflectPos(21, 336)
    line1:setLocalZOrder(1)
    line1:setReflectSize(283, 2)
    line1:computePosition()
    bg:addChild(line1)
    line1:setName("line1")
    self.line1 = line1

    local buttonUse = UI.Button:create()
    buttonUse:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_2.png", "ui_btn_yellow3_2.png", {x=0, y=0})
    buttonUse._clickScale = false
    buttonUse._baseline = 1
    buttonUse:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    buttonUse:setReflectPos(97, 352)
    buttonUse:computePosition()
    buttonUse:setFontColor({r=50,g=50,b=44})
    buttonUse:setText(UI.TEXT_111169)
    bg:addChild(buttonUse)
    self.buttonUse = buttonUse
    buttonUse:setName("buttonUse")
    buttonUse:addEventListener(UIEvent.BUTTON_CLICK, self, onUseButton)
    buttonUse:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_110030)
    end)
    buttonUse:setVisible(false)


    local buttonCancelCenter = UI.Button:create()
    buttonCancelCenter:init("ui_btn_no2_1.png", "ui_btn_no2_2.png", "ui_btn_no2_2.png", {x=0, y=0})
    buttonCancelCenter._clickScale = false
    buttonCancelCenter._baseline = 1
    buttonCancelCenter:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    buttonCancelCenter:setReflectPos(118, 355)
    buttonCancelCenter:computePosition()
    bg:addChild(buttonCancelCenter)
    buttonCancelCenter:setName("buttonCancelCenter")
    self.buttonCancelCenter = buttonCancelCenter
    buttonCancelCenter:addEventListener(UIEvent.BUTTON_CLICK, self, onCenterCancel)
    buttonCancelCenter:setVisible(false)

    local cancelBtnBackTown = UI.Button:create()
    cancelBtnBackTown:init("ui_btn_no2_0.png", "ui_btn_no2_2.png", "ui_btn_no2_2.png", {x=0, y=0})
    cancelBtnBackTown._clickScale = false
    cancelBtnBackTown._baseline = 1
    cancelBtnBackTown:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    cancelBtnBackTown:setReflectPos(42, 355)
    cancelBtnBackTown:computePosition()
    bg:addChild(cancelBtnBackTown)
    cancelBtnBackTown:setName("cancelBtnBackTown")
    self.cancelBtnBackTown = cancelBtnBackTown
    cancelBtnBackTown:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
    cancelBtnBackTown:setVisible(false)

    
    local okButtonBackTown = UI.Button:create()
    okButtonBackTown:init("ui_btn_yes2_1.png", "ui_btn_yes2_2.png", "ui_btn_yes2_2.png", {x=0, y=0})
    okButtonBackTown._clickScale = false
    okButtonBackTown._baseline = 1
    okButtonBackTown:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    okButtonBackTown:setReflectPos(197, 355)
    okButtonBackTown:computePosition()
    bg:addChild(okButtonBackTown)
    okButtonBackTown:setName("okButtonBackTown")
    self.okButtonBackTown = okButtonBackTown
    okButtonBackTown:addEventListener(UIEvent.BUTTON_CLICK, self, onOkHandler)
    okButtonBackTown:setVisible(false)

    local scrollViewLayer = UI.Component:create()
    scrollViewLayer:init()
    scrollViewLayer:setSize(280, 208)
    scrollViewLayer:leftBottom(10, 113)
    bg:addChild(scrollViewLayer)
    scrollViewLayer:setName("scrollViewLayer")
    self.scrollViewLayer = scrollViewLayer
    
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
    
end
function SelectGoodsBagInfoArea:showGoodsView()
    if not self.goodsDataList then
        return
    end
    local itemPadding = 82
    local size = table.nums(self.goodsDataList)
    -- local noLostText = self.noGoodsText
    -- noLostText:setVisible(size == 0);
    local height = 208
    if self.selectTipsText ~= nil then
        height = 208 - self.selectTipsText:getContentSize().height
        self.scrollViewLayer:setSize(self.scrollViewLayer:getContentSize().width, height)
    end
    if(size > 0) then 
        for k, value in ipairs(self.allGridNode) do
            if not tolua.isnull(value) then
                value:removeFromParent()
            end
        end
        self.allGridNode = {}
        local height = math.ceil(size / CELL_NUMBER)
        local width = 0
        if height > 1 then
            width = CELL_NUMBER * itemPadding
        else
            width = size % CELL_NUMBER
            width = (width == 0) and CELL_NUMBER or width
            width = width* itemPadding
        end 
        height = height * itemPadding

        local scrollViewLayer = self.scrollViewLayer
        scrollViewLayer:removeAllChildren();
        -- scrollViewLayer:addTouchEvents()
        scrollViewLayer:setTouchEnable(true)
        
        -- if size > CELL_NUMBER then
        local upLayout = UI.TouchLayout:create()
        upLayout:init(0, 0, 0, 0)
        upLayout:setSize(width, height)
        upLayout:addTouchEvents(self)
        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(scrollViewLayer._width + 4, scrollViewLayer._height)
        detailedScrollView:leftUp(0, 0)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(upLayout)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setCircleVisible(false);
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(0, 0))
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        self.detailedScrollView = detailedScrollView
        scrollViewLayer:addChild(detailedScrollView)
        -- end
        local beginPosX = 26
        local index = 1
        for k, goodData in pairs(self.goodsDataList) do
            goodData:setIsNew(false)
            local goodGrid = UI.GoodsGrid:create()
            goodGrid:init(goodData)
            upLayout:addChild(goodGrid)
            goodGrid:hideFlagIcon()
            goodGrid:setInfoArea(true, false)
            goodGrid:showCountLabel()
            -- goodGrid:deleteItem()
            -- goodGrid:showChoiceStatus()

            local mode = index % CELL_NUMBER
            mode = mode == 0 and CELL_NUMBER or mode
            goodGrid:leftUp(beginPosX + (mode - 1) * itemPadding, math.floor((index - 1) / CELL_NUMBER) * itemPadding)
            table.insert(self.allGridNode, goodGrid)
            index = index + 1
        end    

        local cap = UI.Image:create()
        cap:init("ui_iteminfo_up.png")
        cap:leftBottom(-5, 0)
        scrollViewLayer:addChild(cap, 100)
    end
end
function SelectGoodsBagInfoArea:autoOpenSelect()
    if self:judgeOpenSelect() then
        self._buttonStatus = STATUS.SELECT    
    end
    
end

function SelectGoodsBagInfoArea:judgeOpenSelect()
    if(SceneManager:getInstance():isInFightScene()) then 
        return false
    else 
        return true
    end
end

function SelectGoodsBagInfoArea:refreshButtons()
    local isInTown = self:judgeOpenSelect()
    if self._buttonStatus == STATUS.SELECT and self._fromBag and isInTown and not (self._goodsData and self._goodsData:getIsLock()) then
        for i,v in ipairs(self.allGridNode) do
            v:showChoiceStatus()
        end
    else
        if not tolua.isnull(self.inSelectText) then
            self.inSelectText:removeFromParent()
        end
        for i,v in ipairs(self.allGridNode) do
            v:hideChoiceStatus()
        end
    end
    -- 如果锁定就修改状态
    if self._buttonStatus == STATUS.SELECT and (self._goodsData and self._goodsData:getIsLock()) then 
        self._buttonStatus = STATUS.OPEN
    end

    self.buttonUse:setVisible(self._buttonStatus == STATUS.OPEN and self._fromBag and isInTown) 
    self.buttonCancelCenter:setVisible(self._buttonStatus == STATUS.SELECT and self._fromBag and isInTown)
    self.cancelBtnBackTown:setVisible(self._buttonStatus == STATUS.SELECTED and self._fromBag and isInTown)
    self.okButtonBackTown:setVisible(self._buttonStatus == STATUS.SELECTED and self._fromBag and isInTown)
    -- add by zp 锁定的物品无法使用
    if(self._goodsData and self._goodsData:getIsLock()) then 
        self.buttonUse:disable()
    else 
        self.buttonUse:enable()
    end
end

function SelectGoodsBagInfoArea:refreshNums()
    local selectNum = table.nums(self._selectItems)

    if not tolua.isnull(self.inSelectText) then
        self.inSelectText:removeFromParent()
    end
    local numStr = string.format("[%d/%d]",selectNum,self._maxSelectNum)
    local str = ""
    if selectNum >= self._maxSelectNum then
        str = AvalonUtil:serializeText(UI.TEXT_111168, {r=50,g=50,b=44}, UI.FONT_SIZE_16PX, UI.FONT_STANDARD)..AvalonUtil:serializeText(numStr, {r=15,g=85,b=71}, UI.FONT_SIZE_16PX, UI.FONT_STANDARD)
    else
        str = AvalonUtil:serializeText(UI.TEXT_111168, {r=50,g=50,b=44}, UI.FONT_SIZE_16PX, UI.FONT_STANDARD)..AvalonUtil:serializeText(numStr, {r=146,g=54,b=30}, UI.FONT_SIZE_16PX, UI.FONT_STANDARD)
    end

    local inSelectText = UI.RichText:create()
    inSelectText:init(str,283,0,true)
    inSelectText:setLayoutType(UI.LayoutDefaultType.CENTER)
    inSelectText:setReflectPos(0, 110)
    inSelectText:computePosition()
    self.bg:addChild(inSelectText)
    inSelectText:setName("inSelectText")
    self.inSelectText = inSelectText
end
function SelectGoodsBagInfoArea:initLockORLink()
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

function SelectGoodsBagInfoArea:refreshLinkOrLockPosition()
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
function SelectGoodsBagInfoArea:onUpdateView(data)

    
    
    if (data and self._goodsData ~= data) then 
        self._goodsData = data
    end
    if(self.detailedScrollView) then
        self.detailedScrollView:setScrollBarWidth(6)
    end 
    -- if (data and self._goodsData ~= data) then self._goodsData = data
    -- end

    if (self._goodsData) then
        -- 初始化需要显示的数据
        self.goodsDataList = {}
        local cfg = Config.ConfigGoods:getChooseBagById(self._goodsData.ID) or {}
        self._maxSelectNum = cfg.chooseNum or 1
        local nums = cfg.goodsNum or {}
        for i,v in ipairs(cfg.goodsID or {}) do
            local goodsData = GoodsDataManager:createLocalGoodsData(v)
            if(goodsData) then
                goodsData:setNum(nums[i] or 0)
                table.insert(self.goodsDataList, goodsData)
            end
        end
        local data = self._goodsData 
        local rare = data:getGoodsRare()
        local goodsGroupType = data:getGoodsGroupType()
        self.spriteBg:setSpriteName(string.format("box_quality_%s_%s.png",goodsGroupType,rare))
        local iconName = data:getIconName()
        if (iconName) then
            if (DEBUG) then
                print(string.format("BagGrid odateView:nUp icon name is %s.", iconName))
            end
            
            self.iconSprite:setSpriteName(iconName)
            local iconSize = self.iconSprite:getContentSize()
        end

        -- 道具名字
        local name = data:getName()
        self.goodsName:setText(name)
        self.goodsName:autoAdapt()
        local type = UI.PROP_MATER.PROPINFO
        
        if (self._goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or self._goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
            -- 装备详情
            type = UI.EquipImageBgType.SMALL_TYPE
        elseif (self._goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
            -- 道具详情界面
            type = UI.PROP_MATER.PROPINFO
        elseif (self._goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                self._goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
            -- 材料详情界面
            type = UI.PROP_MATER.MATERIALINFO

        elseif (self._goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
            -- 虚拟物品详情界面
            type = UI.PROP_MATER.VIRTUALITEM_INFO
        end
        if (type == proptype.MATERIALINFO or type == proptype.TASK_MATERIAL) and data:getMaterialType() == PublicDefine.MATERIAL_TYPE.MaterialDungeonKey then
            self.goodsDes:setText(UI.TEXT_1170213)
        else 
            -- 描述
            local desStr = ""
            if(type == proptype.PROPINFO or type == proptype.TASK_PROP) then 
                desStr = UI.TEXT_111019
            elseif(type == proptype.MATERIALINFO or type == proptype.TASK_MATERIAL) then 
                desStr = UI.TEXT_111020
            elseif(type == proptype.VIRTUALITEM_INFO) then 
                -- print("PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemTitle=", self._goodsData:getVirtualType(), PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemTitle)
                if(self._goodsData and self._goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemTitle) then
                    desStr = UI.TEXT_1212037
                else 
                    desStr = UI.TEXT_111019
                end
            end 

            self.goodsDes:setText(desStr)

            if not tolua.isnull(self.selectTipsText) then
                self.selectTipsText:removeFromParent()
            end
            local numsStr = string.format("[%d]",self._maxSelectNum)
            -- 选着提示
            local str = AvalonUtil:serializeText(UI.TEXT_111166, {r=50,g=50,b=44}, UI.FONT_SIZE_16PX, UI.FONT_STANDARD)..AvalonUtil:serializeText(numsStr, {r=15,g=85,b=71}, UI.FONT_SIZE_16PX, UI.FONT_STANDARD)..AvalonUtil:serializeText(UI.TEXT_111167, {r=41,g=41,b=45}, UI.FONT_SIZE_16PX, UI.FONT_STANDARD)
            local selectTipsText = UI.RichText:create(-6)
            selectTipsText:init(str, 240, 0, false)
            selectTipsText:leftUp(35, 103)
            self.bg:addChild(selectTipsText)
            selectTipsText:setName("selectTipsText")
            self.selectTipsText = selectTipsText
        end

        self:showGoodsView()
        self:refreshButtons()
        self:showSellPrice()
        self:refreshLock()
        
    end
    
    
end

function SelectGoodsBagInfoArea:setHideLink(isHideLink)
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

function SelectGoodsBagInfoArea:showSellPrice()
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
function SelectGoodsBagInfoArea:onTouchBegan(touch, event)
    print(" SelectGoodsBagInfoArea:onTouchBegan")
    
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    local point = self.detailedScrollView:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(point.x , point.y , self.detailedScrollView:getContentSize().width,self.detailedScrollView:getContentSize().height) 
    if cc.rectContainsPoint(rect, location) then
        for k, value in ipairs(self.allGridNode) do
            if AvalonUtil:isRectContainsPoint(value, location) and value:isVisible() then
                self.selectIndex = k
                break
            end
        end
    end
end

function SelectGoodsBagInfoArea:onTouchEnded(touch, event)
    print(" SelectGoodsBagInfoArea:onTouchEnded")
    
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            
            if self._buttonStatus == STATUS.OPEN then
                print("应该显示详情")
                local pInfoArea = value:onShowInfoAreaHandler(true)
                if pInfoArea then
                    self:refreshPosition()
                    local curWorldPos = self:convertToWorldSpace(cc.p(0, 0))
                    if curWorldPos.x + self:getContentSize().width / 2 < winSize.width / 2 then
                        pInfoArea:centerLeft(curWorldPos.x + self:getContentSize().width)
                    else
                        pInfoArea:centerRight(winSize.width - curWorldPos.x)
                    end

                    if(self:getZOrder() < UI_ZORDER.TIPS) then
                        pInfoArea:setZOrder(UI_ZORDER.TIPS)
                    else
                        if pInfoArea:getZOrder() <= self:getZOrder() then
                            pInfoArea:setZOrder(self:getZOrder())
                        end 
                    end
                    -- pInfoArea:setZOrder(UI_ZORDER.TIPS)
                else
                    print("没有")
                end
            elseif self._buttonStatus == STATUS.SELECT then
                value:deleteItem()
                if value._isSelect then
                    table.insert( self._selectItems,{value = value ,pos = self.selectIndex})
                else
                    for i,v in ipairs(self._selectItems) do
                        if v.value == value then
                            table.remove( self._selectItems, i )
                            break;
                        end
                    end
                end
                if table.nums(self._selectItems) >= self._maxSelectNum then
                    self._buttonStatus = STATUS.SELECTED
                    self:refreshButtons()
                end
                self:refreshNums()
            elseif self._buttonStatus == STATUS.SELECTED then
                if value._isSelect then
                    value:deleteItem()
                    for i,v in ipairs(self._selectItems) do
                        if v.value == value then
                            table.remove( self._selectItems, i )
                            break;
                        end
                    end
                    if table.nums(self._selectItems) < self._maxSelectNum then
                        self._buttonStatus = STATUS.SELECT
                        self:refreshButtons()
                    end
                end
                self:refreshNums()
            end
            
            
            break
        end
    end
end