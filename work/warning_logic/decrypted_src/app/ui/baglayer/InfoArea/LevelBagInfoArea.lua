--[[
    UI - 背包等级礼包
]]--

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.ScrollView"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
UI = UI or {}
local winSize = cc.Director:getInstance():getWinSize()
local LevelBagInfoArea = class("LevelBagInfoArea", UI.HWBtnComponent)
UI.LevelBagInfoArea = LevelBagInfoArea
local PACKET_TYPE = PublicDefine.PACKET_TYPE 
local CELL_NUMBER = 4
local STATUS = {
    OPEN = 1,
    SELECT = 2,
    SELECTED = 3,
}
local SPRITE_ITEM_ICON_LOCK = "ui_iteminfo_btn_locked.png"
local SPRITE_ITEM_ICON_UNLOCK = "ui_iteminfo_btn_unlock.png"
local SPRITE_EQUIPMENT_LEVEL = "symbol_character_hero_power.png"
local proptype = UI.PROP_MATER 

local width = 387
local height = 373
-- 构造函数
function LevelBagInfoArea:ctor(fromBag)
    LevelBagInfoArea.super.ctor(self, UIType.PROP_INFO_AREA, BAG_EQUIPMENT_INFO_AREA_RES_LIST, width, height)
    self._fromBag = fromBag
    self._lock = nil 
    -- 是否显示锁定标志
    self._lockShow = true
    -- false未锁定，true锁定
    self._lockstate = false
    
    self._selectItems = {}
    self.allGridNode = {}
    self._goodsId = 20010011
    self._goodsData = nil
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)    
end

-- 析构函数
function LevelBagInfoArea:dtor()
    -- 是否显示售卖价格，这里只会在商店层显示
    self._showSellPrice = false
    -- reload_script_file("app.ui.baglayer.InfoArea.LevelBagInfoArea")
    LevelBagInfoArea.super.dtor(self)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
end

-- public:
-- 初始化
function LevelBagInfoArea:init(proptype)
    self._proptype = proptype 

    LevelBagInfoArea.super.init(self, data)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
end

-- 销毁
function LevelBagInfoArea:onDestroy()
    self._packetType = nil
end


function LevelBagInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function LevelBagInfoArea:getGoodsGrid()
    return self._goodsGrid
end


-- 设置的操作的包裹类型
function LevelBagInfoArea:setPacketType(packetType)
    self._packetType = packetType
end

-- 显示价格
function LevelBagInfoArea:setShowSellPrice(flag)
    self._showSellPrice = flag
    self:showSellPrice()
end

-- 锁定状态改变
function LevelBagInfoArea:lockStatusChange(data)
    UI.WaitingLayer:hideWaiting()
end

-- 关闭锁定标志
function LevelBagInfoArea:closeLockFlag()

end

--打开锁定标志
function LevelBagInfoArea:openLockFlag()

end

-- 点击超链接的处理
local function onActiveChatHandler(self)
    print("====聊天超链接=== ")
    -- UI.ChatMainLayer:getInstance():reciveLinkData(self._goodsData)
end
  
-- 点击锁定按钮处理
local function onActiveGoodsLockHandler(self)
    -- UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    -- GameManager:lockGoodsHandler(self._goodsData, self._packetType)
end

-- 刷新锁定显示
function LevelBagInfoArea:refreshLock()
    -- if(self._goodsData and self._lock) then
    --     if(self._goodsData:getIsLock()) then
    --         self._lock:setSpriteName(SPRITE_ITEM_ICON_LOCK)
    --     else
    --         self._lock:setSpriteName(SPRITE_ITEM_ICON_UNLOCK)
    --     end
    --     self._lock:updateView()
    -- end
end

local function onUseButton(self)
    if(not self:getIsLevelStatus()) then 
        UI.ScrollBar:createByText(UI.TEXT_1212594)
        return 
    end

    -- 处理背包是否满了
    if not (SceneManager:getInstance():isNotInFightScene()) then
        local GameDataManager = require("app.game.GameDataManager")
        local freeNum = GameDataManager:getInstance():getFreePacketBoxNum()
        if(freeNum < #self.goodsDataList) then 
            UI.ScrollBar:createByText(UI.TEXT_1212011)
            return 
        end
    end

    local itemID = self._goodsData:getId()
    local chooseList = {}
    for i,v in ipairs(self.goodsDataList) do
        table.insert(chooseList,{pos = i - 1,itemID = v.ID})
    end

    Net.NetGoodsSystem:reqUseChooseBag(itemID,chooseList)
    -- self:dispatchEvent(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, nil, nil)
    self:close()
end

-- 初始化视图
function LevelBagInfoArea:onInitView()
    local left = 16 
    self:showLucencyLight()

    local bg = UI.Image:create()
    bg:init("ui_tips_levelbag_box.png")
    bg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    bg:computePosition()
    bg:setName("bg")
    bg:center()
    local contentSize = bg:getContentSize()
    self:setSize(contentSize.width, contentSize.height)
    self:addChild(bg)
    self.bg = bg

    print("contentSize.width, contentSize.height=", contentSize.width, contentSize.height)
    AvalonUtil.runTipsAppearShowAnimation(self)

    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:setSize(308, 316)
    rootLayout:leftBottom(55 - 14, 47 - 15)
    bg:addChild(rootLayout)

    -- 添加标题以及提示语言
    local titleText = UI.Text:create()
    titleText:init("32", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    titleText:centerUp(20 - titleText:getContentSize().height/2)
    rootLayout:addChild(titleText)
    self._titleText = titleText

    local openText = UI.Text:create()
    openText:init("23", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    openText:centerUp(55 - openText:getContentSize().height/2)
    rootLayout:addChild(openText)
    self._openText = openText

    -- 分割线
    local line1 = UI.Image9:create()
    line1:init("ui_scale9image_banner_line_light.png")
    line1:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    line1:centerBottom(238)
    line1:setLocalZOrder(1)
    line1:setReflectSize(308, 2)
    line1:computePosition()
    rootLayout:addChild(line1)
    line1:setName("line1")
    self.line1 = line1

    -- 分割线
    local line1 = UI.Image9:create()
    line1:init("ui_scale9image_banner_line_light.png")
    line1:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    line1:centerBottom(75)
    line1:setLocalZOrder(1)
    line1:setReflectSize(308, 2)
    line1:computePosition()
    rootLayout:addChild(line1)
    line1:setName("line1")
    self.line1 = line1

    local buttonUse = UI.Button:create()
    buttonUse:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    buttonUse._clickScale = false
    buttonUse:centerBottom(14)
    buttonUse:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    buttonUse:setText(UI.TEXT_111169)
    rootLayout:addChild(buttonUse)
    self.buttonUse = buttonUse
    buttonUse:setName("buttonUse")
    buttonUse:addEventListener(UIEvent.BUTTON_CLICK, self, onUseButton)
    buttonUse:setVisible(false)

    -- 打开物品列表
    local scrollViewLayer = UI.Component:create()
    scrollViewLayer:init()
    scrollViewLayer:setSize(308, 157)
    scrollViewLayer:centerBottom(78)
    rootLayout:addChild(scrollViewLayer)
    scrollViewLayer:setName("scrollViewLayer")
    self.scrollViewLayer = scrollViewLayer
end

function LevelBagInfoArea:showGoodsView()
    if not self.goodsDataList then
        return
    end
    local itemPadding = 78
    local size = table.nums(self.goodsDataList)
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
        scrollViewLayer:setTouchEnable(true)
        
        if(size > CELL_NUMBER) then
            local upLayout = UI.TouchLayout:create()
            -- local upLayout = UI.Layout:create()
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
            local beginPosX = 0
            local index = 1
            for k, goodData in pairs(self.goodsDataList) do
                goodData:setIsNew(false)
                local goodGrid = UI.GoodsGrid:create()
                goodGrid:init(goodData)
                upLayout:addChild(goodGrid)
                goodGrid:hideFlagIcon()
                goodGrid:setInfoArea(true, false)
                goodGrid:showCountLabel()

                local mode = index % CELL_NUMBER
                mode = mode == 0 and CELL_NUMBER or mode
                goodGrid:leftUp(beginPosX + (mode - 1) * itemPadding, math.floor((index - 1) / CELL_NUMBER) * itemPadding)
                table.insert(self.allGridNode, goodGrid)
                index = index + 1
            end   
        else 
            local upLayout = UI.TouchLayout:create()
            upLayout:init(0, 0, 0, 0)
            upLayout:setSize(width, height)
            upLayout:center()
            upLayout:addTouchEvents(self)
            scrollViewLayer:addChild(upLayout)

            -- end
            local beginPosX = 0
            local index = 1
            for k, goodData in pairs(self.goodsDataList) do
                goodData:setIsNew(false)
                local goodGrid = UI.GoodsGrid:create()
                goodGrid:init(goodData)
                upLayout:addChild(goodGrid)
                goodGrid:hideFlagIcon()
                goodGrid:setInfoArea(true, false)
                goodGrid:showCountLabel()

                local mode = index % CELL_NUMBER
                mode = mode == 0 and CELL_NUMBER or mode
                goodGrid:leftUp(beginPosX + (mode - 1) * itemPadding, math.floor((index - 1) / CELL_NUMBER) * itemPadding)
                table.insert(self.allGridNode, goodGrid)
                index = index + 1
            end  
        end

        -- local cap = UI.Image:create()
        -- cap:init("ui_iteminfo_up.png")
        -- cap:leftBottom(-5, 0)
        -- scrollViewLayer:addChild(cap, 100)
    end
end

function LevelBagInfoArea:judgeOpenSelect()
    if(self._disableUse) then 
        return false
    else 
        if GameDataManager:getInstance():checkInDisableSituation(self._goodsData:getDisableSituation()) then 
            return false
        end

        return true
    end
end

function LevelBagInfoArea:refreshStatus()
    local isInTown = self:judgeOpenSelect()
    self.buttonUse:setVisible(isInTown)

    local cfg = Config.ConfigGoods:getChooseBagById(self._goodsData.ID)
    local level = self:getIsLevelStatus()
    if(level) then 
        self.buttonUse:setNormal("ui_btn_yellow_0.png")
        self.buttonUse:setSelected("ui_btn_yellow_1.png")
    else 
        self.buttonUse:setNormal("ui_btn_yellow_2.png")
        self.buttonUse:setSelected("ui_btn_yellow_2.png")
    end

    -- 刷新等级限制
    if(level) then 
        self._openText:setFontColor(UI.FONT_COLOR_41_41_45)
    else 
        self._openText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    end
end

function LevelBagInfoArea:getIsLevelStatus()
    local cfg = self.cfg
    local masterData = RoleDataManager:getMaster()
    if(cfg and masterData) then 
        if cfg.levellimt <= masterData:getLevel() then 
            return true
        end
    end

    return false 
end

-- 更新视图
function LevelBagInfoArea:onUpdateView(data)
    if (data and self._goodsData ~= data) then 
        self._goodsData = data
        self.cfg = Config.ConfigGoods:getChooseBagById(self._goodsData.ID)
    end
    if(self.detailedScrollView) then
        self.detailedScrollView:setScrollBarWidth(5)
    end 

    if (self._goodsData) then
        -- 初始化需要显示的数据
        self.goodsDataList = {}
        local cfg = Config.ConfigGoods:getChooseBagById(self._goodsData.ID) or {}
        local nums = cfg.goodsNum or {}
        for i=1,1,1 do 
            for i,v in ipairs(cfg.goodsID or {}) do
                local goodsData = GoodsDataManager:createLocalGoodsData(v)
                if(goodsData) then
                    goodsData:setNum(nums[i] or 0)
                    table.insert(self.goodsDataList, goodsData)
                end
            end
        end
        local data = self._goodsData 

        -- 道具名字
        local name = data:getName()
        self._titleText:setText(name)
        self._titleText:autoAdapt()
        
        if(cfg) then
            local level, reinLv = RoleDataManager:getUIShowLvByItemData(cfg.levellimt)
            local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
            self._openText:setText(string.format(UI.TEXT_1212598, showLv))
        else 
            self._openText:setText("")
        end
        self._openText:autoAdapt()

        self:showGoodsView()
        self:refreshStatus()
        self:refreshLock()
    end
end

function LevelBagInfoArea:setHideLink(isHideLink)

end

function LevelBagInfoArea:lockNextLevelBag()
    self._lockNextLevelBag = true
    if(self.buttonUse) then
        self:refreshStatus()
    end
end

function LevelBagInfoArea:unlockNextLevelBag()
    self._lockNextLevelBag = false
    if(self.buttonUse) then
        self:refreshStatus()
    end
end

function LevelBagInfoArea:disableUse()
    self._disableUse = true
    if(self.buttonUse) then
        self:refreshStatus()
    end
end

function LevelBagInfoArea:enableUse()
    self._disableUse = false
    if(self.buttonUse) then
        self:refreshStatus()
    end
end

function LevelBagInfoArea:onTouchBegan(touch, event)
    print(" LevelBagInfoArea:onTouchBegan")
    
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    local point = self.scrollViewLayer:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(point.x , point.y , self.scrollViewLayer:getContentSize().width,self.scrollViewLayer:getContentSize().height) 
    if cc.rectContainsPoint(rect, location) then
        for k, value in ipairs(self.allGridNode) do
            if AvalonUtil:isRectContainsPoint(value, location) and value:isVisible() then
                self.selectIndex = k
                break
            end
        end
    end
end

function LevelBagInfoArea:onTouchEnded(touch, event)
    -- print(" LevelBagInfoArea:onTouchEnded")
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            if(self._lockNextLevelBag) then 
                -- 屏蔽了多层打开等级礼包
                local goodsData = value:getData()
                if(goodsData) then 
                    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM and 
                        goodsData:getItemType() == PublicDefine.ITEM_TYPE.LevelBag) then 
                        break 
                    end
                end
            end
            value:setIsHideUseBtn(true)
            local pInfoArea = value:onShowInfoAreaHandler(nil)
            if pInfoArea then
                if(pInfoArea.lockNextLevelBag) then 
                    pInfoArea:lockNextLevelBag()
                    pInfoArea:disableUse()
                end
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
            else
                print("没有")
            end
            break
        end
    end
end

function LevelBagInfoArea:autoOpenSelect()
    
end

function LevelBagInfoArea:showSellPrice()
    
end