--[[
  战斗界面快捷物品layer  
]]--

require "app.ui.itemquickuselayer.QuickBagGrid"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}
local ItemMazePanel = class("ItemMazePanel",UI.HWBtnComponent)
UI.ItemMazePanel = ItemMazePanel

local size = cc.Director:getInstance():getWinSize()

local itemIsOpen = 0 -- 快捷栏是否展开 0为false

-- 快捷栏的SIZE
local GAME_ITEM_INIT_INFO = {
  X = 0,
  Y = 0,
  WIDTH = 580,
  HEIGHT = 540
}

UI.gridType = {
    NONE = 0,
    BAR  = 1,
    BAG  = 2,
}
GridType = UI.gridType

-- 快捷栏用到的资源
local GAME_ITEM_RES_LIST = {
}

-- 快捷栏用到的资源
local GAME_ITEM_SPRITE_FRAME_MAP = {
   ITEM_BG =  "ui_quickPanel_banner_itemlist.png",--道具物品背景图片大
   QUICK_BG_0 = "ui_quickPanel_banner_quickbar.png",--黑色背景工具栏
   ITEM_BG_1 = "ui_quickPanel_banner_itemuse.png", -- 快捷背包中道具、物品背景图片 70* 70
}

-- 构造函数 必须继承
function ItemMazePanel:ctor(type)

    ItemMazePanel.super.ctor(
    self,UIType.ItemMazePanel,
    GAME_ITEM_RES_LIST,
    GAME_ITEM_INIT_INFO.WIDTH,
    GAME_ITEM_INIT_INFO.HEIGHT
    )

    -- 刷新快捷栏数据
    local master = RoleDataManager:getMaster()
    if(master) then
        local itemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM, PublicDefine.PACKET_SUB_TYPE.PACKET_SUB_TYPE_2)
        if(itemArr) then 
            local index = 1
            for k,itemData in ipairs(itemArr) do 
                if(itemData:isUseInMaze()) then
                    GoodsDataManager:updateShortcutBarMaze(index, itemData:getGoodsID())
                    index = index + 1
                end
            end
        end
    end

    
    self._quick_Bar_Grid = nil
    self._clickTime = 0 -- 点击的时间
    self._BarListView = nil
    self._BagListView = nil

    self.itemTitle = nil
    self.itemTitleDes  = nil

    self._dragQuickBagGrid = nil -- 拖动的快捷背包格子
    self._dragQuickBarGrid = nil -- 拖动的快捷动作条格子
    self._dragQuickBagGridBeganPos = nil --拖动的快捷背包格子的初始位置
    self._dragQuickBagGridEndPos = nil --拖动的快捷背包格子的END位置

    self._bar_Item_Data = nil -- 快捷动作条单个格子数据
    self._bag_Item_Data = nil -- 快捷背包单个格子数据
    self._bagList = {}
    self._itemBagList = {} -- 
    self._itemBarList = {} -- 

    self._barGridList = {}
    self._bagGridList = {}

    self._barGridTable = {}   --   快捷栏 技能table
    self._bagGridTable = {}   --   快捷背包 技能table
    self._barGridTableItem = {}
    self._bagGridTableItem = {}   --   快捷背包 道具table
    self._isDirect = true -- 指向性数据 否

    self._enable = true

    self._lastBarGrid = nil -- 记录点击的快捷动作条格子
    self._lastBagGrid = nil -- 记录点击的快捷背包格子
    self._barGridToBarGrid = nil --记录从快捷动作条拖动到快捷动作条格子
    self._bagGridToBarGrid = nil --记录从快捷背包拖到快捷动作条的格子

    self._data = nil
end

-- 析构函数 必须继承
function ItemMazePanel:dtor()
    ItemMazePanel.super.dtor(self)
    self.itemTitle = nil
    self.itemTitleDes  = nil

    self._dragQuickBagGrid = nil
    self._dragQuickBagGridBeganPos = nil
    self._dragQuickBagGridEndPos = nil
    self._bar_Item_Data = nil
    self._lastActiveBarGrid = nil

    self._barGridTable = nil
    self._bagGridTable = nil
    self._data = nil
    self._bagGridTableItem = nil
    self:unRegisterListener();
end

function ItemMazePanel:init(data)
    self._data = data

    ItemMazePanel.super.init(self)
    self:registerListener();
    -- self:setToCacheTexture(true)
    -- self:enableDebugDraw()
end

-- 初始化快捷栏视图
function ItemMazePanel:onInitView(data)
    local data = self._data
    self:addTouchEvents()
    itemIsOpen = 0

    self.quickPack = UI.Layout.create()
    self.quickPack:init()
    self.quickPack:setSize(495, 470)
    self.quickPack:setVisible(false)
    self.quickPack:centerBottom(-GAME_ITEM_INIT_INFO.HEIGHT)
    self:addChild(self.quickPack)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_quickPanel_banner_itemlist.png")
    lineUpImage:setContentSize(495 + 72*2,  470 + 72)
    lineUpImage:setCapInsets(CCRectMake(228,196,1,1))
    lineUpImage:setPosition(cc.p(self.quickPack:getContentSize().width/2, self.quickPack:getContentSize().height/2 + 72/2))
    self.quickPack:addChild(lineUpImage)


    -- 存放快捷背包的24个格子的LAYOUT大小
    self.bagItemLaytout = UI.Layout:create()
    self.bagItemLaytout:init()
    self.bagItemLaytout:setSize(495, 470 - 88)
    self.bagItemLaytout:centerUp(88)
    self.quickPack:addChild(self.bagItemLaytout)

    -- 存放快捷动作条的节点
    self.quickBarAllNode = cc.Node:create()
    self.quickBarAllNode:setContentSize(580, 106)
    self:addChild(self.quickBarAllNode)
    
    -- 快捷动作条(0) 不透明
    -- local quickSelectBar = cc.Scale9Sprite:createWithSpriteFrameName(GAME_ITEM_SPRITE_FRAME_MAP.QUICK_BG_0)
    -- quickSelectBar:setContentSize(552, 133 + 100)
    -- quickSelectBar:setCapInsets(CCRectMake(274,117,1,1))
    -- self.quickBarAllNode:addChild(quickSelectBar)
    -- quickSelectBar:setPosition(cc.p(5 - 20, -4 - 2 - 47 - 100))
    -- quickSelectBar:setAnchorPoint(0,0)
    -- self.quickSelectBar_0 = quickSelectBar

    -- 存放快捷动作条6个格子的LAYOUT大小
    self.barItemLaytout = UI.Layout:create()
    self.barItemLaytout:init()
    self.barItemLaytout:setSize(580, 89)
    self.barItemLaytout:centerBottom(2)
    self.quickBarAllNode:addChild(self.barItemLaytout,2)
    self.barItemLaytout:setTouchEnable(true)

    -- 物品名称
    self.itemTitle = UI.Text:create()
    self.itemTitle:init("",UI.FONT_STANDARD,UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    self.itemTitle:centerUp(7)
    self.itemTitle:setVisible(false)
    self.quickPack:addChild(self.itemTitle)
    
    -- 物品描述信息
    self.itemTitleDes = UI.Text:create()
    self.itemTitleDes:init("",UI.FONT_STANDARD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    -- self.itemTitleDes:setSize(413, 45)
    self.itemTitleDes:setWidth(413)
    self.itemTitleDes:setLineSpacing(-5)
    self.itemTitleDes:setTextCenter()
    self.itemTitleDes:centerUp(27 + 5)
    self.itemTitleDes:setVisible(false)
    self.quickPack:addChild(self.itemTitleDes)

    --打开快捷背包按钮  
    local quickBagBtn = UI.Button:create(UIType.BUTTON_ITEM_MAZE)
    quickBagBtn:init("ui_role_bth_details_0.png", "ui_role_bth_details_1.png")
    quickBagBtn:rotate(0)
    quickBagBtn:rightBottom(-10 + 15, -15 + 44)
    quickBagBtn:setRenderGroupTag(2)
    self.quickBagBtn = quickBagBtn
    -- btnArrow:rotate(270)
    self:addChild(quickBagBtn, 10)
    self.quickBagBtn:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.5,cc.p(0,-8)),cc.MoveBy:create(0.5,cc.p(0,8)))))
    
    -- 打开和关闭按钮的响应事件
    local function menuCallback(sender)
        if (self._enable) then
            if  itemIsOpen == 1  then     
                self:closeQuickPack() 
                self._BarListView:disableToDragGrid()  --禁用拖拽  
            else
                
                -- self._BarListView:enableToDragGrid()   --启用拖拽
                -- add by yys 不再关闭摇杆
                -- Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)         --关闭遥杆（移动方式在UIManager中做了判断）
                -- self.quickBagBtn:rotate(180)
                self.quickPack:setVisible(true)
                local remove = cc.CallFunc:create(function()
                    local storyManager = require "app.story.StoryManager"
                    storyManager:getInstance():onQuickPackShowHide(true)
                    -- itemIsOpen = 1
                end)
                itemIsOpen = 1
                local px =  12 
                local itemList = GameDataManager:getInstance():getShortcutBagMazeData()
                local itemHeight = math.ceil(#itemList / 6) * 77
                local py = self.barItemLaytout:getContentSize().height + itemHeight - 362--根据当前数量计算
                self.quickPack:stopAllActions()
                self.quickPack:runAction(
                    cc.Sequence:create(
                        cc.MoveTo:create(0.1, cc.p(px,py)),remove
                        )
                    )
            end 
        end
    end
    quickBagBtn:addEventListener(UIEvent.BUTTON_CLICK, self, menuCallback)
 

    self:initQuickBagGrid()
    self:initQuickBarGrid()
    self:onUpdateQuickBarGrid(data,GridType.BAR)
    self:onUpdateQuickBagGrid(data,GridType.BAG)
    self:addItemBarCap()
    -- self:enableDebugDraw(UI.YELLOW)

    self:updateTigerEffect()
end

function ItemMazePanel:addItemBarCap()
    local barList = self._BarListView:getGridList()
    for i = 1 ,#barList do  
        local gridData = barList[i]:getData()
        if gridData:isSkill() then

        end 
    end

end

function ItemMazePanel:useItem(QuickBagGrid)
    if (self._enable) then
        -- 关闭背包状态 监听单机事件 使用物品
        gridData = QuickBagGrid:getData()
        if(itemIsOpen == 0) then
            if(gridData:isNull() == false and gridData:getNum() ~= 0 ) then
                self._BarListView:disableToDragGrid()  --禁用拖拽  
                -- print("关闭背包gridData存在数量是==,%s",gridData:getNum())
                     -- 道具
                if(gridData:isItem() == true)  then 
                    local getDisableSituation = gridData:getData():getDisableSituation()
                    local checkInDisableSituation, languageId =  GameDataManager:getInstance():checkInDisableSituation(getDisableSituation)
                    if(checkInDisableSituation == true ) then 
                        UI.ScrollBar:createByTextID(languageId)
                    else 
                        -- 使用道具动画
                        local isUsed = QuickBagGrid:useItem(gridData:getData())
                        -- print("-----------isUsed",isUsed)
                        if(isUsed) then
                            self:_useItem(QuickBagGrid, gridData:getData())
                        end 
                    end 
                    -- QuickBagGrid:barItemUseSpine()    
                end 
        -- 技能
        elseif (gridData:getNum() == 0  ) then
            -- print("关闭背包快捷动作条中的gridData:getNUM == 0")   
            if(gridData:getData()) then
                 if(gridData:isSkill() == true) then
                    -- 判断消耗的魔法值是否足够
                    -- gridData:getData()
                    -- 判断当前的状态战斗中探险技能无法使用
                    local getDisableSituation = gridData:getData():getDisableSituation()
                    local checkInDisableSituation =  GameDataManager:getInstance():checkInDisableSituation(getDisableSituation)
                    -- print("---self:skillIsUsable()--",self:skillIsUsable())
                    if self:skillIsUsable() then 
                        local skillID = gridData:getData():getId()     
                        local heroData = RoleDataManager:getMaster()
                        if(heroData:getCurMp() <gridData:getData():getMPCost()) then 
                            -- print("--当前英雄蓝量小于技能释放的蓝量、变灰且不可点击")
                        elseif(checkInDisableSituation == true ) then 
                        else         
                            local isUsed = QuickBagGrid:useSkill(gridData:getData())
                            if isUsed then 
                                self:_useSkill(skillID)
                            end
                        end 
                    end                  
                end      
            end
        else
            -- print("----技能关闭背包快捷动作条中的gridData不存在")
            QuickBagGrid:barItemSelectDownSpine()
        end
    -- 打开背包状态 监听单机事件
    else  
        if(self._lastBagGrid) then
            self._lastBagGrid:setVisiableFalse()
        end
        if(self._lastBarGrid) then
            self._lastBarGrid:setVisibleFalseSpine()
        end
        if(self._bagGridToBarGrid) then
            self._bagGridToBarGrid:setVisibleFalseSpine()
        end
        if(self._barGridToBarGrid) then
            self._barGridToBarGrid:setVisibleFalseSpine()
        end
        if (gridData:isNull() == false) then
            QuickBagGrid:showItemSelectDownSpine() --点击动画
            self._lastBarGrid = QuickBagGrid
            -- print("打开背包情况下，格子数据存在的情况下。单击动作条显示物品信息")
            self.itemTitle:setText(gridData:getName())
            if(gridData:isItem() == true) then
                self.itemTitleDes:setText(gridData:geteffecDescription())
            else
                self.itemTitleDes:setText(gridData:getDescription())
            end  
            self.itemTitle:setVisible(true) 
            self.itemTitleDes:setVisible(true) 
        elseif(gridData:getNum() == 0) then
            if(gridData:isSkill() == true) then      
                local skillID = gridData:getData():getId() 
                if self:skillIsUsable() then 
                    if isUsed then 
                        self:_useSkill(skillID)
                    end                   
                    local isUsed = QuickBagGrid:useSkill(gridData:getData())
                end            
            end
            QuickBagGrid:showItemSelectDownSpine() --点击动画
            self._lastBarGrid = QuickBagGrid
            self.itemTitle:setVisible(false) 
            self.itemTitleDes:setVisible(false) 
            end
        end
    end
end


function ItemMazePanel:playCdAction(itemType, itemData, heroData)
    local allGridTableItem = {}
    for k,button in pairs(self._barGridTableItem) do
        local data = {}
        data.button = button
        data.isItem = button:getData():isItem()
        data.itemData = button:getData():getData()
        table.insert(allGridTableItem, data)
    end
    for k,button in pairs(self._bagGridTableItem) do
        local data = {}
        data.button = button
        if button:getData():getCategory() == Category.GOODS then
            data.isItem = true
        else
            data.isItem = false
        end
        data.itemData = button:getData()
        table.insert(allGridTableItem, data)
    end
    
    local function playSelfCDAction(_itemType, _value, _itemData, _heroData)
        if (_itemType == PublicDefine.ITEM_TYPE.IronPickaxe) then -- 铁锹
            _value.button:ToUseTQPublicCDTime(_itemData.cooldown)
        elseif (_itemType == PublicDefine.ITEM_TYPE.ItemFunTrap) then -- 陷阱
            _value.button:ToUseTQPublicCDTime(_itemData.cooldown)
        elseif (_itemType == PublicDefine.ITEM_TYPE.ItemFunMark) then -- 标记
            _value.button:ToUseTQPublicCDTime(_itemData.cooldown)
        elseif (_itemType == PublicDefine.ITEM_TYPE.EscapeScroll) then -- 回城卷轴                      
            _value.button:ToTownUsePublicCDTime(_itemData.cooldown)
        elseif (_itemType == PublicDefine.ITEM_TYPE.RestorePotion) then -- 回复药剂
            if(_itemData:getRemarksField() == 1) then 
                if(_heroData:getCurHp() < _heroData.hp) then 
                    _value.button:runCoolDownByTime(_itemData:getCooldown())
                end 
            elseif (_itemData:getRemarksField() == 2) then 
                if (_heroData:getCurMp() < _heroData.mp) then 
                    _value.button:runCoolDownByTime(_itemData:getCooldown())
                end 
            end 
        elseif (_itemType == PublicDefine.ITEM_TYPE.ForgetSkillPotion) then -- 遗忘药剂
            _value.button:runCoolDownByTime(_itemData:getCooldown())
        elseif (_itemType == PublicDefine.ITEM_TYPE.Mushroom) then -- 蘑菇
            _value.button:runCoolDownByTime(_itemData:getCooldown())
        elseif (_itemType == PublicDefine.ITEM_TYPE.OpenMapShadowScroll) then -- 灵视卷轴
            _value.button:runCoolDownByTime(_itemData:getCooldown())
        elseif (_itemType == PublicDefine.ITEM_TYPE.TransferScroll) then -- 传送卷轴
            _value.button:runCoolDownByTime(_itemData:getCooldown())
        elseif (_itemType == PublicDefine.ITEM_TYPE.FlyScroll) then -- 漂浮卷轴
            _value.button:runCoolDownByTime(_itemData:getCooldown())
        elseif (_itemType == PublicDefine.ITEM_TYPE.RunScroll) then -- 疾跑卷轴
            _value.button:runCoolDownByTime(_itemData:getCooldown())
        elseif (_itemType == PublicDefine.ITEM_TYPE.MagicScroll) then -- 法术卷]
            _value.button:runCoolDownByTime(_itemData:getCooldown())
        else
            _value.button:runCoolDownByTime(_itemData:getCooldown())
        end   
    end


    for k,value in pairs(allGridTableItem) do
        if itemType == value.itemData:getItemType() then
            playSelfCDAction(itemType, value, itemData, heroData)
        elseif value.itemData:getPublicCdType() == itemData:getPublicCdType() then
            if (itemType == PublicDefine.ITEM_TYPE.RestorePotion) then -- 回复药剂
                if(itemData:getRemarksField() == 1) then 
                    if(heroData:getCurHp() < heroData.hp) then 
                        value.button:runPublicCD()
                    end 
                elseif (itemData:getRemarksField() == 2) then 
                    if (heroData:getCurMp() < heroData.mp) then 
                        value.button:runPublicCD()
                    end 
                end
            elseif (itemType == PublicDefine.ITEM_TYPE.IronPickaxe) then
                value.button:ToUseTQPublicCDTime(ConfigManager:getPublicCDTime())
            elseif (itemType == PublicDefine.ITEM_TYPE.ItemFunTrap) then
                value.button:ToUseTQPublicCDTime(ConfigManager:getPublicCDTime())
            elseif (itemType == PublicDefine.ITEM_TYPE.ItemFunMark) then
                value.button:ToUseTQPublicCDTime(ConfigManager:getPublicCDTime())
            elseif (itemType == PublicDefine.ITEM_TYPE.EscapeScroll) then
                value.button:ToTownUsePublicCDTime(ConfigManager:getPublicCDTime())
            else
                value.button:runPublicCD()
            end
        end
    end 
end


-- 初始化快捷动作条格子
function  ItemMazePanel:initQuickBarGrid(data)
    local QuickBarListView = UI.ListView:create()
    QuickBarListView:init(UI.QuickBagGrid, 6, 1, 78, 78, 5)
    -- QuickBarListView:centerLeft(15+ 2)
    self.barItemLaytout:addChild(QuickBarListView)
    -- QuickBarListView:enableDebugDraw(UI.RED)
    self._BarListView = QuickBarListView
    QuickBarListView:setCountFlag(false)
    QuickBarListView:leftBottom(15 + 2, self.barItemLaytout:getContentSize().height/2 - 44.5 -1)
      
    for i = 1 ,#self._itemBarList do  
        QuickBarListView:addGrid(self._itemBarList[i])
    end
    QuickBarListView:setTouchEnable(true)
    QuickBarListView:addEventListener(UIEvent.LIST_VIEW_GRID_CLICK, self, function(self,QuickBagGrid)
        self:useItem(QuickBagGrid)
    end)

    -- 打开背包情况下 监听双击事件 使用物品
    QuickBarListView:addEventListener(UIEvent.LIST_VIEW_GRID_DOUBLE_CLICK, self, function(self,QuickBagGrid)

    end)

    -- 拖动开始
    QuickBarListView:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_BEGAN, self, function(self,QuickBagGrid,touchPosition)
        if (self._enable) then
            local barGrid = self._BarListView:getGridByPosition(touchPosition)
            local gridData = QuickBagGrid:getData() 
            if (gridData:isNull() == false) then
                local localPostion = QuickBagGrid:convertToNodeSpace(touchPosition)
                local LocalPostion = self:convertToNodeSpace(touchPosition)
                -- print("BEGAN===",localPostion.x ,localPostion.y)
                -- 复制一个相同的快捷栏格子
                self._dragQuickBarGrid = QuickBagGrid:copy(GridType.BAR)
                self._dragQuickBarGrid:setVisibleFalse()
                self:addChild(self._dragQuickBarGrid)
                self._dragQuickBarGrid:setPosition(cc.p(-100,-100))
                -- QuickBarGrid:setVisible(false)
                -- 拖动开始的本地坐标 
                self.dragQuickBarGrid_Began_x = localPostion.x 
                self.dragQuickBarGrid_Began_y = localPostion.y 
                -- 拖动开始的屏幕坐标
                self.X= LocalPostion.x
                self.Y= LocalPostion.y
                QuickBagGrid:startSelectDownSpine()
                QuickBagGrid:setVisibleFalse()

                self.itemTitle:setText(gridData:getName())
                if(gridData:isItem() == true) then
                    self.itemTitleDes:setText(gridData:geteffecDescription())
                else
                    self.itemTitleDes:setText(gridData:getDescription())
                end 
                self.itemTitle:setVisible(true) -- 设置物品标题可见
                self.itemTitleDes:setVisible(true) -- 设置物品描述可见
            end
        end
    end)
    -- 拖动中
    QuickBarListView:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self, function(self,QuickBagGrid,touchPosition)
        if (self._enable) then
            -- QuickBarGrid:itemSelectDownSpine()
            local gridData = QuickBagGrid:getData() 
            if (gridData:isNull() == false) then
                local localPostion = self:convertToNodeSpace(touchPosition)
                -- print("MOVED===",localPostion.x,localPostion.y)
                self._dragQuickBarGrid:setVisibleTrueIcon()
                self._dragQuickBarGrid:setPosition(localPostion.x -self.dragQuickBarGrid_Began_x,
                localPostion.y - self.dragQuickBarGrid_Began_y )
                QuickBagGrid:moveSelectDownSpine()
            end
        end
    end)

    -- 拖动结束 
    QuickBarListView:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self, function(self,QuickBagGrid,touchPosition)
        if (self._enable) then
            local gridData = QuickBagGrid:getData() 
            if (gridData:isNull() == false) then
                local localPostion = self._BagListView:convertToNodeSpace(touchPosition)
                local W,H = self._BagListView:getSize()
                -- print("ENDED==",localPostion.x,localPostion.y,W,H)
            
                local barGrid = self._BarListView:getGridByPosition(touchPosition)
                local bagGrid = self._BagListView:getGridByPosition(touchPosition)
                if(barGrid) then  -- 从快捷动作条拖动到快捷动作条 交换数据
                    local barData = {}
                    if(self._lastBarGrid) then
                        self._lastBarGrid:setVisibleFalseSpine()
                    end  
                    if(self._lastBagGrid) then
                        self._lastBagGrid:setVisiableFalse()
                    end
                    if(self._barGridToBarGrid) then
                        self._barGridToBarGrid:setVisibleFalseSpine()
                    end
                    if(self._bagGridToBarGrid) then
                        self._bagGridToBarGrid:setVisibleFalseSpine()
                    end
                    barData.oneIndex = QuickBagGrid:getIndex()
                    barData.twoIndex = barGrid:getIndex()
                    -- Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_SWITCH, barData)
                    GameManager:shortcutBarSwitch(barData)
                    barGrid:startSelectDownSpine()
                    barGrid:moveSelectDownSpine()
                    self._barGridToBarGrid  = barGrid
                    self._dragQuickBarGrid:removeFromParent()
                    barGrid:setVisible(true)
                    QuickBagGrid:setVisible(true)
                    QuickBagGrid:endSelectDownSpine()
                    self.itemTitle:setVisible(true)
                    self.itemTitleDes:setVisible(true)
                elseif (bagGrid) then-- 拖到快捷背包 or gridData:getNum() == 0
                    -- Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_DELETE, QuickBagGrid:getIndex())
                    GameManager:shortcutBarDelete(QuickBagGrid:getIndex())
                    self._dragQuickBarGrid:removeFromParent()
                    QuickBagGrid:endSelectDownSpine()
                    self.itemTitle:setVisible(false)
                    self.itemTitleDes:setVisible(false)
                    if(self._lastBarGrid) then
                        self._lastBarGrid:setVisibleFalseSpine()
                    end
                else -- 拖到其它区域，还是移除
                    -- Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_DELETE, QuickBagGrid:getIndex())
                    GameManager:shortcutBarDelete(QuickBagGrid:getIndex())
                    self._dragQuickBarGrid:removeFromParent()
                    QuickBagGrid:endSelectDownSpine()
                    self.itemTitle:setVisible(false)
                    self.itemTitleDes:setVisible(false)
                end
            end
        end
    end)
    
end

-- 初始化快捷背包格子
function  ItemMazePanel:initQuickBagGrid(data)
    local QuickBagListView = UI.ListView:create(left)
    QuickBagListView:init(UI.QuickBagGrid,6,4,70,70,7,6,0)
    -- QuickBagListView:leftUp(20,-45 - 35)
    QuickBagListView:leftUp(20, 8)
    -- QuickBagListView:enableDebugDraw(UI.YELLOW)
    self.bagItemLaytout:addChild(QuickBagListView)
    self._BagListView = QuickBagListView
    QuickBagListView:setCountFlag(false)

    -- self._BagListView:enableToDragGrid() -- 启用拖拽
    self._BagListView:setTouchEnable(true)
    -- 监听双击事件 使用物品
    self._BagListView:addEventListener(UIEvent.LIST_VIEW_GRID_DOUBLE_CLICK, self, function(self,QuickBagGrid)
        -- local isUsed = QuickBagGrid:useItem()
        -- if (self._enable and isUsed) then
        --     local gridData = QuickBagGrid:getData() 
            
        --     -- add by zp
        --     -- Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_CLICK, gridData)
        --     GameManager:bagClickGoodsHandler(gridData)

        --     self._bag_Item_Data = gridData
        --     if (gridData) then
        --     local getDisableSituation = gridData:getDisableSituation()
        --     local checkInDisableSituation, languageId =  GameDataManager:getInstance():checkInDisableSituation(getDisableSituation)
        --     -- 如果点击的是技能
        --     local heroData = RoleDataManager:getMaster()
        --         if gridData:getCategory() == Category.SKILL then
        --             if (gridData:getIsDirection() == true) then
        --                 self:closeQuickPack()
        --             end
                    
        --             if self:skillIsUsable() then 
        --                 if(heroData:getCurMp() <gridData:getMPCost()) then 
        --                     -- print("--当前英雄蓝量小于技能释放的蓝量、变灰且不可点击")
        --                 elseif checkInDisableSituation == true  then

        --                 else 
        --                     self:_useSkill(gridData:getSkillID())
        --                     QuickBagGrid:useSkill(gridData)
        --                 end 
        --              end
        --         elseif checkInDisableSituation == true  then 
        --             UI.ScrollBar:createByTextID(languageId)
        --         else 
        --             if (gridData:getIsDirection() == true) then
        --                 self._isDirect = true
        --                 self:closeQuickPack()
        --             elseif(gridData:getIsDirection() == false) then
        --                 self._isDirect = false
        --             else
        --                 print("快捷背包中的gridData不存在")
        --             end
        --             self:_useItem(QuickBagGrid, gridData)
        --         end
        --     end
        -- end
    end)
    -- 监听单击事件 查看物品详细信息
    self._BagListView:addEventListener(UIEvent.LIST_VIEW_GRID_CLICK, self, function(self, QuickBagGrid)
        if (self._enable) then
            local gridData = QuickBagGrid:getData() 
            -- local barGrid = self._BarListView:getGridByPosition(touchPosition)
            if (gridData) then
                if(self._lastBagGrid) then
                    self._lastBagGrid:setVisiableFalse()
                end
                self.itemTitle:setText(gridData:getName())
                if(gridData:getCategory() == Category.GOODS) then
                    self.itemTitleDes:setText(gridData:geteffecDescription())
                else
                    self.itemTitleDes:setText(gridData:getDescription())
                end 
                self.itemTitle:setVisible(true) -- 设置物品标题可见
                self.itemTitleDes:setVisible(true) -- 设置物品描述可见
                QuickBagGrid:showItemSelectSpine()
                self._lastBagGrid = QuickBagGrid
                if(self._lastBarGrid) then
                    self._lastBarGrid:setVisibleFalseSpine()
                end
                if(self._bagGridToBarGrid) then
                    self._bagGridToBarGrid:setVisibleFalseSpine()
                end  
                
                -- add by zp
                -- Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_CLICK, gridData)
                GameManager:bagClickGoodsHandler(gridData)
            else
                -- print("2222快捷背包的格子SPINE消失")
                self.itemTitle:setVisible(false) 
                self.itemTitleDes:setVisible(false)

                if(self._lastBarGrid) then
                    self._lastBarGrid:setVisibleFalseSpine()
                end  
                if(self._lastBagGrid) then
                    self._lastBagGrid:setVisiableFalse()
                end
                if(self._barGridToBarGrid) then
                    self._barGridToBarGrid:setVisibleFalseSpine()
                end
                if(self._bagGridToBarGrid) then
                    self._bagGridToBarGrid:setVisibleFalseSpine()
                end
            end
        end
    end)
    -- 拖动开始
    self._BagListView:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_BEGAN, self, function(self,QuickBagGrid,touchPosition)
        if (self._enable) then
            local gridData = QuickBagGrid:getData() 
            if (gridData) then
                -- if(gridData:getIsDirection() == true) then 
                --     print("保存指向性数据")
                    -- self._isDirect = true
                    local localPostion = QuickBagGrid:convertToNodeSpace(touchPosition)
                    local LocalPostion = self:convertToNodeSpace(touchPosition)
                    -- print("BEGAN===",localPostion.x ,localPostion.y)
                    -- 创建一个相同的格子
                    self._dragQuickBagGrid = QuickBagGrid:copy(GridType.BAG)
                    self._dragQuickBagGrid:setVisibleTrueIcon()
                    self:addChild(self._dragQuickBagGrid)
                    self._dragQuickBagGrid:setPosition(cc.p(-1000,-1000))

                    -- 拖动开始的本地坐标 
                    self.dragQuickBagGrid_Began_x = localPostion.x 
                    self.dragQuickBagGrid_Began_y = localPostion.y 
                    -- 拖动开始的屏幕坐标
                    self.X= LocalPostion.x
                    self.Y= LocalPostion.y
                    QuickBagGrid:startItemSelectSpine()

                    self.itemTitle:setText(gridData:getName())
                    if(gridData:getCategory() == Category.GOODS) then
                        self.itemTitleDes:setText(gridData:geteffecDescription())
                    else
                        self.itemTitleDes:setText(gridData:getDescription())
                    end 
                    self.itemTitle:setVisible(true) -- 设置物品标题可见
                    self.itemTitleDes:setVisible(true) -- 设置物品描述可见
                    if(self._lastBarGrid) then
                        self._lastBarGrid:setVisibleFalseSpine()
                    end
                    if(self._lastBagGrid) then
                        self._lastBagGrid:setVisiableFalse()
                    end
                    if(self._barGridToBarGrid) then
                        self._barGridToBarGrid:setVisibleFalseSpine()
                    end
                    if(self._bagGridToBarGrid) then
                        self._bagGridToBarGrid:setVisibleFalseSpine()
                    end
                    self:showSlotSpine()
            end
        end
    end)
    -- 拖动中
    self._BagListView:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self, function(self,QuickBagGrid,touchPosition)
        if (self._enable) then
            local gridData = QuickBagGrid:getData() 
            if (gridData) then
                -- self.item_Slot:addAnimation(0,"loop", true)
                if(not tolua.isnull(self._dragQuickBagGrid)) then
                    local localPostion = self:convertToNodeSpace(touchPosition)
                    -- print("MOVED===",localPostion.x,localPostion.y)
                    self._dragQuickBagGrid:setVisibleTrueIcon()
                    self._dragQuickBagGrid:setPosition(localPostion.x -self.dragQuickBagGrid_Began_x,
                                                    localPostion.y - self.dragQuickBagGrid_Began_y )
                end
                -- QuickBagGrid:startItemSelectSpine()
                QuickBagGrid:moveItemSelectSpine()
                -- QuickBagGrid:startItemSelectSpine()
            end
        end
    end)

    -- 拖动结束  从上往下面拖动
    self._BagListView:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self, function(self,QuickBagGrid,touchPosition)
        if (self._enable) then
            if(tolua.isnull(self._dragQuickBagGrid)) then
                self._dragQuickBagGrid = nil
                return
            end

            local gridData = QuickBagGrid:getData() 
            if (gridData) then
                -- self.item_Slot:addAnimation(0,"end", false)
                self:hideSlotSpine()
                local localPostion = self._BarListView:convertToNodeSpace(touchPosition)
                local W,H = self._BarListView:getSize()
                -- print("ENDED===",localPostion.x,localPostion.y,W,H)
                local barGrid = self._BarListView:getGridByPosition(touchPosition)
                
                if (barGrid) then
                    -- barGrid:setData(self._dragQuickBagGrid:getData())
                    -- barGrid:updateView()
                    if(gridData:getIsDirection() == true) then 
                        if(self._bagGridToBarGrid) then
                            self._bagGridToBarGrid:setVisibleFalseSpine()
                        end
                        self._isDirect = true
                        local barData = {}
                        barData.index = barGrid:getIndex()
                        barData.ID = self._dragQuickBagGrid:getData():getId()
                        -- Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_ADD, barData)
                        GameManager:shortcutBarAdd(barData)
                        barGrid:setVisible(true)
                        self._dragQuickBagGrid:removeFromParent()
                        QuickBagGrid:endItemSelectSpine()
                        barGrid:startSelectDownSpine()
                        barGrid:moveSelectDownSpine()
                        if(self._barGridToBarGrid) then
                            self._barGridToBarGrid:setVisibleFalseSpine()
                        end
                        -- self.itemTitle:setVisible(false)
                        -- self.itemTitleDes:setVisible(false)
                        self._bagGridToBarGrid = barGrid
                    else
                        if(self._bagGridToBarGrid) then
                            self._bagGridToBarGrid:setVisibleFalseSpine()
                        end
                        self._isDirect = false
                        local barData = {}
                        barData.index = barGrid:getIndex()
                        barData.ID = self._dragQuickBagGrid:getData():getId()
                        -- Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_ADD, barData)
                        GameManager:shortcutBarAdd(barData)
                        barGrid:setVisible(true)
                        self._dragQuickBagGrid:removeFromParent()
                        QuickBagGrid:endItemSelectSpine()
                        if(self._barGridToBarGrid) then
                            self._barGridToBarGrid:setVisibleFalseSpine()
                        end
                        barGrid:startSelectDownSpine()
                        barGrid:moveSelectDownSpine()
                        self._bagGridToBarGrid = barGrid
                        -- self.itemTitle:setVisible(false)
                        -- self.itemTitleDes:setVisible(false)
                    end
       
                else
                    self._dragQuickBagGrid:runAction(
                    cc.Sequence:create(
                    cc.MoveTo:create(0.15, cc.p( self.X-self.dragQuickBagGrid_Began_x,self.Y-self.dragQuickBagGrid_Began_y)),cc.RemoveSelf:create()))
                    QuickBagGrid:endItemSelectSpine()
                    self.itemTitle:setVisible(true)
                    self.itemTitleDes:setVisible(true)
                end
            end
            self._dragQuickBagGrid = nil
        end
    end)
end

function ItemMazePanel:_useSkill(skillID)
    for k,button in pairs(self._barGridTable) do
        if(button) then
            if(button:getData():getId() == skillID) then
                if (skillID == TRANSFER_SKILL_ID) then
                    button:ToUseTWSkillCDTime(ConfigManager:getPublicCDTime())
                else
                    button:lockUse()
                end
            else 
                if (skillID == TRANSFER_SKILL_ID) then
                    button:usePublicCDTime()
                else
                    button:runPublicCD()
                end   
            end
        end
    end
    for k,button in pairs(self._bagGridTable) do
        if(button) then
            if(button:getData():getId() == skillID) then
                if (skillID == TRANSFER_SKILL_ID) then
                    button:ToUseTWSkillCDTime(ConfigManager:getPublicCDTime())
                else
                    button:lockUse()
                end
            else 
                if (skillID == TRANSFER_SKILL_ID) then
                    button:usePublicCDTime()
                else
                    button:runPublicCD()
                end 
            end
        end
    end
    
end

function ItemMazePanel:_useItem(QuickBagGrid, gridData)
    local itemType = gridData:getItemType()
    local heroData = RoleDataManager:getMaster()
    if(itemType == PublicDefine.ITEM_TYPE.IronPickaxe) then 
        UI.UIManager:useGoods(gridData, true)
        QuickBagGrid:barItemUseSpine() 
    elseif (itemType == PublicDefine.ITEM_TYPE.ItemFunTrap) then
        UI.UIManager:useGoods(gridData, true)
        QuickBagGrid:barItemUseSpine() 
    elseif (itemType == PublicDefine.ITEM_TYPE.ItemFunMark) then
        UI.UIManager:useGoods(gridData, true)
        QuickBagGrid:barItemUseSpine() 
    elseif (itemType == PublicDefine.ITEM_TYPE.EscapeScroll) then
        UI.UIManager:useGoods(gridData, true)
        QuickBagGrid:barItemUseSpine() 
    elseif (itemType == PublicDefine.ITEM_TYPE.RestorePotion) then -- 回复药剂
        if(gridData:getRemarksField() == 1) then 
            if(heroData:getCurHp() < heroData.hp) then 
                UI.UIManager:useGoods(gridData, true)
                QuickBagGrid:barItemUseSpine() 
            else
                UI.ScrollBar:createByText(UI.TEXT_1170919)
            end 
        elseif (gridData:getRemarksField() == 2) then 
            if (heroData:getCurMp() < heroData.mp) then 
                UI.UIManager:useGoods(gridData, true)
                QuickBagGrid:barItemUseSpine() 
            else
                UI.ScrollBar:createByText(UI.TEXT_1170919)
            end 
        end
    else
        UI.UIManager:useGoods(gridData, true)
        QuickBagGrid:barItemUseSpine() 
    end
    self:playCdAction(itemType, gridData, heroData)
end
-- 更新快捷动作条数据
function ItemMazePanel:onUpdateQuickBarGrid(data,gridType)
    local itemList = GameDataManager:getInstance():getMazeShortcutBarData()
    -- local storyManager = require "app.story.StoryManager"
    -- storyManager:getInstance():onQuickBarContentUpdate(itemList)

    -- 

    self._itemBarList = itemList
    --dump(self._itemBarList)
    self._barGridTable = {}
    self._barGridTableItem = {}
    local barList = self._BarListView:getGridList()
    for i = 1 ,#barList do  
        if(self._itemBarList[i]) then
            -- barList[i]:setData(self._itemBarList[i])
            -- print("====bar==更新==")
            barList[i]:updateView(self._itemBarList[i],gridType)
            if self._itemBarList[i]:isSkill() then 
                table.insert(self._barGridTable,barList[i])
            elseif self._itemBarList[i]:isItem() then 
                table.insert(self._barGridTableItem,barList[i])
            end 
        else
            barList[i]:setItemCount()
        end
        barList[i]:setShapeType(BORDER_SHAPE.CIRCULAR)
    end
end

-- 更新快捷背包数据
function ItemMazePanel:onUpdateQuickBagGrid(data,gridType)
    -- self:initQuickBagGrid(data)
    local itemList = GameDataManager:getInstance():getShortcutBagMazeData()
    self._itemBagList = itemList
    
    -- dump(self._itemBagList)
    self._bagGridTable = {}
    self._bagGridTableItem = {}
    local bagList = self._BagListView:getGridList()
    for i = 1 ,#bagList do  
        if(self._itemBagList[i]) then
            -- bagList[i]:setData(self._itemBagList[i])
            -- print("====bag==更新==")
            bagList[i]:updateView(self._itemBagList[i],gridType)
            
            if self._itemBagList[i]:getCategory() == Category.SKILL then 
                table.insert(self._bagGridTable,bagList[i])
            else
                table.insert(self._bagGridTableItem,bagList[i])
            end 

        elseif(self._itemBagList[i] == nil) then
            bagList[i]:setItemCount()
            bagList[i]:clearIcon()
            bagList[i]:clearData()
        end
        bagList[i]:setShapeType(BORDER_SHAPE.SQUARE)
    end
end

-- 数据驱动更新视图
function ItemMazePanel:onUpdateView(data)
--    print("ItemMazePanel:onUpdateView")
end

-- 关闭快捷背包
function ItemMazePanel:closeQuickPack()
    self.quickPack:stopAllActions()
    local remove = cc.CallFunc:create(function() 
                    self.quickPack:setVisible(false)
                    local storyManager = require "app.story.StoryManager"
                    storyManager:getInstance():onQuickPackShowHide(false)
                end)
    itemIsOpen = 0
    self.quickPack:runAction(
        cc.Sequence:create(
            cc.MoveTo:create(0.15, cc.p(12,-512)),remove
            )
        ) 
    -- add by yys 不再关闭摇杆
    -- Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)          --打开遥杆 
    self._BarListView:disableToDragGrid()  --禁用拖拽
    -- self.quickBagBtn:rotate(0)
    -- self.quickSelectBar_1:setVisible(false) -- 快捷动作条背景（1）透明设置不可见
    -- self.quickPack:setVisible(false) -- 设置快捷背包背景不可见
    -- self.quickPack:setVisible(false) -- 设置快捷背包背景不可见
    self.itemTitle:setVisible(false) -- 设置物品标题不可见
    self.itemTitleDes:setVisible(false) -- 设置物品描述不可见

    if(self._lastBarGrid) then
        self._lastBarGrid:setVisibleFalseSpine()
    end  
    if(self._lastBagGrid) then
        self._lastBagGrid:setVisiableFalse()
    end
    if(self._barGridToBarGrid) then
        self._barGridToBarGrid:setVisibleFalseSpine()
    end
    if(self._bagGridToBarGrid) then
        self._bagGridToBarGrid:setVisibleFalseSpine()
    end
end

-- 快捷动作条和快捷背包点击事件
function ItemMazePanel:addTouchEvents()

    local function onTouchBegan(touch, event)
        local isOpended = (itemIsOpen == 1)
            -- 关闭快捷栏执行 打开遥杆
            if itemIsOpen == 1 then
                self:closeQuickPack()
            end
        -- end
        return isOpended
    end

    local function onTouchMoved(touch, event)
        self.touchMovePosition = touch:getLocation()
    end

    local function onTouchEnded(touch, event)
        self.touchEndedPosition = touch:getLocation()
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    listener:setSwallowTouches(true)
end

-- 拖动快捷背包中物品的时候，快捷动作条产生的SPINE效果
function ItemMazePanel:showSlotSpine()
    -- self:initQuickBagGrid(data)
    local barList = self._BarListView:getGridList()
    for i = 1 ,#barList do  
        barList[i]:setVisibleFalseSpine()
        barList[i]:showItemSelectDownSpine()
    end
end

function ItemMazePanel:hideSlotSpine()
    local barList = self._BarListView:getGridList()
    for i = 1 ,#barList do  
        barList[i]:setVisibleFalseSpine()
    end
end


--使用探险技能前的判断
function ItemMazePanel:skillIsUsable()
    local heroData = RoleDataManager:getMaster()
    local state = heroData:getState()
    -- 战斗状态屏蔽探险技能
    if FSMState.BATTLE == state then 
        return false
    else
        return true    
    end
end

function ItemMazePanel:enable()
    self._enable = true
end

function ItemMazePanel:disable()
    self._enable = false
end

function ItemMazePanel:showBar(time)
    time = time or 0
    if(self._showPosX == nil) then
        self._showPosX, self._showPosY = self:getPosition()
        self._hidePosX, self._hidePosY = self._showPosX, self._showPosY - 200
    end 
    self:stopAllActions()
    self:runAction(cc.Sequence:create(cc.MoveTo:create(time, cc.p(self._showPosX, self._showPosY)),null))
end

function ItemMazePanel:hideBar(time)
    time = time or 0
    if(self._showPosX == nil) then
        self._showPosX, self._showPosY = self:getPosition()
        self._hidePosX, self._hidePosY = self._showPosX, self._showPosY - 200
    end 
    self:stopAllActions()
    self:runAction(cc.Sequence:create(cc.MoveTo:create(time, cc.p(self._hidePosX, self._hidePosY)),null))
end


-- 刷新快捷动作条界面
function ItemMazePanel:onUpdateQuickBarItem(goodsData)
    print("onUpdateQuickBarItem", self.cacheRefreshBar)
    if self.cacheRefreshBar == nil then
        self.cacheRefreshBar = true
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            if not tolua.isnull(self) then
                print("onUpdateQuickBarItem 1=")
                local itemList = GameDataManager:getInstance():getMazeShortcutBarData()
                local tempList = {}
                for _,v in pairs(itemList) do 
                    table.insert(tempList, v)
                end

                local gridList = self._BarListView:getGridList()
                local master = RoleDataManager:getMaster()
                if(master) then
                    local itemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM, PublicDefine.PACKET_SUB_TYPE.PACKET_SUB_TYPE_2)
                    if(itemArr) then 
                        -- 把没有放入的给放入快捷栏
                        local noHandle = {}
                        for k,itemData in pairs(itemArr) do 
                            if(itemData:isUseInMaze()) then
                                local found = false
                                for k,v in pairs(tempList) do 
                                    if(itemData:getGoodsID() == v:getId()) then 
                                        found = true
                                        break
                                    end
                                end
                                if(not found) then 
                                    table.insert(noHandle, itemData)
                                end
                            end
                        end

                        for k,itemData in pairs(noHandle) do 
                            for k,grid in pairs(gridList) do 
                                if grid:getData() == nil or grid:getData():isNull() then 
                                    GoodsDataManager:updateShortcutBarMaze(k, itemData:getId())
                                end
                            end
                        end
                        -- 踢出没有匹配的
                        local itemList = GameDataManager:getInstance():getMazeShortcutBarData()
                        tempList = {}
                        for _,v in pairs(itemList) do 
                            table.insert(tempList, v)
                        end

                        for k,itemData in pairs(itemArr) do 
                            if(itemData:isUseInMaze()) then
                                for k,v in pairs(tempList) do 
                                    if(itemData:getGoodsID() == v:getId()) then 
                                        table.remove(tempList, k)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end

                for k,v in pairs(tempList) do 
                    GoodsDataManager:updateShortcutBarMaze(v:getIndex(), 0)
                end

                if(gridList) then 
                    for k,grid in pairs(gridList) do 
                        if grid:getData() == nil or grid:getData():isNull() then 
                            GoodsDataManager:updateShortcutBarMaze(k, 0)
                            grid:clearIcon()
                            grid:removeData()
                            grid:updateView()
                        end
                    end
                end
                
                self.cacheRefreshBar = nil
                self:onUpdateQuickBarGrid(goodsData,GridType.BAR)
                -- TODO 处理等待移动处理逻辑
                
            end
        end, 0.1)
    end
end

-- 刷新快捷背包界面
function ItemMazePanel:onUpdateQuickBagItem(goodsData)
    if self.cacheRefreshBag == nil then
        self.cacheRefreshBag = true
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            if not tolua.isnull(self) then
                self.cacheRefreshBag = nil
                self:onUpdateQuickBagGrid(goodsData,GridType.BAG)
            end
        end, 0.1)
    end
end

-- 角色状态改变
function ItemMazePanel:onUpdateRoleStateHandler(roleData)
    if roleData and RoleDataManager:getMasterSpriteID() == roleData:getSpriteID() then
        -- print("ItemMazePanel:onUpdateRoleStateHandler", debug.traceback())
        self:onUpdateQuickBagGrid()
        self:onUpdateQuickBarGrid()
    end
end

function ItemMazePanel:onSkillStartCooldown(skillID)
    for k,button in pairs(self._barGridTable) do
        if(button) then
            if(button:getData():getId() == skillID) then
                button:runCoolDown()
            end
        end
    end
    for k,button in pairs(self._bagGridTable) do
        if(button) then
            if(button:getData():getId() == skillID) then
                button:runCoolDown()
            end
        end
    end
end

function ItemMazePanel:onItemStartCooldown(itemID)

end

function ItemMazePanel:updateTigerEffect()
    if self.quickSelectBar_0 then
        self.quickSelectBar_0:removeFromParent()
        self.quickSelectBar_0 = nil
    end

    -- local isTiger = false

    -- local masterData = GameDataManager:getInstance():getMaster()
    -- if masterData then
    --     local eData = masterData:getGameUIEquippedDecorates()

    --     for k,v in pairs(eData) do
    --         if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
    --             if v.value == 1 then --虎年
    --                 isTiger = true
    --             end
    --         end
    --     end
    -- end

    local isTiger,appendStr = self:initUseUIValue()

    

    local batStr = GAME_ITEM_SPRITE_FRAME_MAP.QUICK_BG_0
    if (isTiger) then
        batStr = "ui_quickPanel_banner_quickbar" .. appendStr .. ".png"
        local quickSelectStr = "ui_quickPanel_banner_quickbar_down"  .. appendStr .. ".png"
        local quickSelectBar = cc.Scale9Sprite:createWithSpriteFrameName(quickSelectStr)
        quickSelectBar:setContentSize(552, 133 + 100)
        quickSelectBar:setCapInsets(CCRectMake(274,117,1,1))
        self.quickBarAllNode:addChild(quickSelectBar,-1)
        quickSelectBar:setPosition(cc.p(-15 - 21, -153))
        quickSelectBar:setAnchorPoint(0,0)

    end
    local quickSelectBar = cc.Scale9Sprite:createWithSpriteFrameName(batStr)
    quickSelectBar:setContentSize(552, 133 + 100)
    quickSelectBar:setCapInsets(CCRectMake(274,117,1,1))
    self.quickBarAllNode:addChild(quickSelectBar)
    quickSelectBar:setPosition(cc.p(-15, -153))
    quickSelectBar:setAnchorPoint(0,0)
    self.quickSelectBar_0 = quickSelectBar

end

function ItemMazePanel:isDecorateValue(dValue)
    local useValue = PublicDefine.UseUIDecorateValue.DecorateValue_Default
    local masterData = GameDataManager:getInstance():getMaster()
    if not masterData then
        return useValue
    end

    local eData = masterData:getGameUIEquippedDecorates()
    for k,v in pairs(eData) do
        if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
            if v.value == dValue then
                useValue = dValue
                break;
            end
        end
    end

    return useValue
end

function ItemMazePanel:initUseUIValue()
    local isTiger = false
    local appendStr = ""
    for i = PublicDefine.UseUIDecorateValue.DecorateValue_Tiger, PublicDefine.UseUIDecorateValue.DecorateValue_Max - 1, 1 do
        local useValue = self:isDecorateValue(i)
        if useValue ~= PublicDefine.UseUIDecorateValue.DecorateValue_Default then
            isTiger = true
            if useValue == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger then
                appendStr = "_tiger"
            elseif useValue == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate then
                appendStr = "_pirate"
            end
        end
    end
    return isTiger,appendStr
end

-- 注册监听事件
function ItemMazePanel:registerListener()
    -- 更新快捷动作条
    Avalon.MessageCenter:bind(AvalonMessage.MC_SHORTCUT_BAR_CHANGE, self, self.onUpdateQuickBarItem)
    -- 更新快捷背包
    Avalon.MessageCenter:bind(AvalonMessage.MC_SHORTCUT_BAG_CHANGE, self, self.onUpdateQuickBagItem)
    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)

    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:bind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateRoleStateHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateRoleStateHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateRoleStateHandler)
    --服务器通知使用技能 开始cd倒计时
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_START_COOLDOWN, self, self.onSkillStartCooldown)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
end


-- 注销监听事件
function ItemMazePanel:unRegisterListener()
    -- 更新快捷动作条
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SHORTCUT_BAR_CHANGE, self, self.onUpdateQuickBarItem)
    -- 更新快捷背包
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SHORTCUT_BAG_CHANGE, self, self.onUpdateQuickBagItem)
    -- 角色状态更新 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:unbind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateRoleStateHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateRoleStateHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateRoleStateHandler)
    --服务器通知使用技能 开始cd倒计时
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_START_COOLDOWN, self, self.onSkillStartCooldown)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
end

