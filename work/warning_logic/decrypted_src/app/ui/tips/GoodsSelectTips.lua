
-- GoodsSelectTips.lua
-- Author:yys
-- 2018年6月29日
-- Using:物品选择tips
local winSize = cc.Director:getInstance():getWinSize()

require "app.ui.Component"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local model = require("app.uiExport.ConfirmDialogModel")

local CELL_NUMBER = 3

UI = UI or {}

local GoodsSelectTips = class("GoodsSelectTips",UI.HWBtnComponent)
UI.GoodsSelectTips = GoodsSelectTips

local COM_RES_LIST = {
}
local STATUS = {
    OPEN = 1,
    SELECT = 2,
    SELECTED = 3,
}
local function onCancelHandler(self)

    self:close();
end
local function onCenterCancel(self)
   self:close()
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
    -- if(self._okCallFun) then 
    --     self._okCallFun()
    -- end

    -- print(table.nums(self._selectItems),self._maxSelectNum)
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
    for i,v in ipairs(self._selectItems) do
        -- dump(v)
        local data = v.value:getData()
        table.insert(chooseList,{pos = v.pos - 1,itemID = data.ID})
    end
    printInfo(itemID,chooseList)
    Net.NetGoodsSystem:reqUseChooseBag(itemID,chooseList)
    self:close();
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    if self._buttonStatus == STATUS.OPEN then
        self:close();
    end
    
end

--  构造函数
function GoodsSelectTips:ctor()
    GoodsSelectTips.super.ctor(self,UIType.SETTING_BACK_TOWN_TIPS, COM_RES_LIST, 537, 372)
    self.iconData = nil
    self._cancelCallFun = nil 
    self._okCallFun = nil 
    self._selectItems = {}
    self.allGridNode = {}
    self._maxSelectNum = 3
    self._goodsId = 20010011
    self._goodsData = nil
    self._buttonStatus = STATUS.OPEN
end

--  析构函数 调用父类的方法
function GoodsSelectTips:dtor()
    GoodsSelectTips.super.dtor(self)
end

--  初始化函数
function GoodsSelectTips:init(goodsData)
    -- 初始化需要显示的数据
    self.goodsDataList = {}
    local cfg = Config.ConfigGoods:getChooseBagById(goodsData.ID) or {}
    self._maxSelectNum = cfg.chooseNum or 1
    local nums = cfg.goodsNum or {}
    for i,v in ipairs(cfg.goodsID or {}) do
        local goodsData = GoodsDataManager:createLocalGoodsData(v)
        goodsData:setNum(nums[i] or 0)
        table.insert(self.goodsDataList, goodsData)
    end
    self._goodsData = goodsData

    GoodsSelectTips.super.init(self)
end

--  初始化界面函数
function GoodsSelectTips:onInitView()

    self.ConfirmDialogModel = model.create("GoodsSelectDialog")
    self.rootLayer = self.ConfirmDialogModel.root
    self.rootLayer:center()
    self:setSize(self.rootLayer._width, self.rootLayer._height);

    local mask = AvalonUtil.createDialogMask()
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    self:addChild(self.rootLayer)

    self.rootLayer:setTouchEnable(true)
    self.rootLayer:setInterceptTouches(true)

    local numsStr = string.format("[%d]",self._maxSelectNum)
    -- 选着提示
    local str = AvalonUtil:serializeText(UI.TEXT_111166 , {r=50,g=50,b=44}, 18)..AvalonUtil:serializeText(numsStr, {r=15,g=85,b=71}, 18)..AvalonUtil:serializeText(UI.TEXT_111167, {r=41,g=41,b=45}, 18)
    local selectTipsText = UI.RichText:create()
    selectTipsText:init(str,283,30,true)
    selectTipsText:setLayoutType(UI.LayoutDefaultType.CENTER)
    selectTipsText:setReflectPos(0, -97)
    selectTipsText:computePosition()
    self.ConfirmDialogModel.root:addChild(selectTipsText)
    selectTipsText:setName("selectTipsText")
    

    self:showGoodsView()

    -- local tipsStr = "测试 测试 测试 测试"

    -- local tipsText = self.ConfirmDialogModel.contentLabelbackTown
    -- tipsText:setVisible(tipsStr ~= nil)
    -- if(tipsStr) then 
    --     tipsText:setText(tipsStr)
    --     tipsText:setSize(390, 70)
    -- end

    -- 取消按钮
    local button = self.ConfirmDialogModel.cancelBtnBackTown
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)

    -- 确认购买按钮
    local button = self.ConfirmDialogModel.okButtonBackTown
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onOkHandler)

    local button = self.ConfirmDialogModel.buttonCancelCenter
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onCenterCancel)


    local button = self.ConfirmDialogModel.buttonUse
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onUseButton)

    self.rootLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)

    self:refreshButtons()
end
function GoodsSelectTips:refreshButtons()
    self.ConfirmDialogModel.buttonUse:setVisible(self._buttonStatus == STATUS.OPEN)
    self.ConfirmDialogModel.buttonCancelCenter:setVisible(self._buttonStatus == STATUS.SELECT)
    self.ConfirmDialogModel.cancelBtnBackTown:setVisible(self._buttonStatus == STATUS.SELECTED)
    self.ConfirmDialogModel.okButtonBackTown:setVisible(self._buttonStatus == STATUS.SELECTED)
    
    -- self.ConfirmDialogModel.inSelectText:setVisible(table.nums(self._selectItems) < self._maxSelectNum)
    -- self.ConfirmDialogModel.doneSelectText:setVisible(table.nums(self._selectItems) >= self._maxSelectNum)

end
function GoodsSelectTips:refreshNums()
    local selectNum = table.nums(self._selectItems)

    if not tolua.isnull(self.inSelectText) then
        self.inSelectText:removeFromParent()
    end
    local numStr = string.format("[%d/%d]",selectNum,self._maxSelectNum)
    local str = ""
    if selectNum >= self._maxSelectNum then
        str = AvalonUtil:serializeText(UI.TEXT_111168, {r=50,g=50,b=44}, 18)..AvalonUtil:serializeText(numStr, {r=15,g=85,b=71}, 18)
    else
        str = AvalonUtil:serializeText(UI.TEXT_111168, {r=50,g=50,b=44}, 18)..AvalonUtil:serializeText(numStr, {r=146,g=54,b=30}, 18)
    end

    local inSelectText = UI.RichText:create()
    inSelectText:init(str,283,30,true)
    inSelectText:setLayoutType(UI.LayoutDefaultType.CENTER)
    inSelectText:setReflectPos(0, 110)
    inSelectText:computePosition()
    self.ConfirmDialogModel.root:addChild(inSelectText)
    inSelectText:setName("inSelectText")
    self.inSelectText = inSelectText
end
-- 传递回调函数名字
function GoodsSelectTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end

-- 更新视图
function GoodsSelectTips:onUpdateView(data)
    if(self.detailedScrollView) then
        self.detailedScrollView:setScrollBarWidth(6)
    end 
    -- if (data and self._goodsData ~= data) then self._goodsData = data
    -- end

    if (self._goodsData) then
        local data = self._goodsData 
        local rare = data:getGoodsRare()
        local goodsGroupType = data:getGoodsGroupType()
        self.ConfirmDialogModel.spriteBg:setSpriteName(string.format("box_quality_%s_%s.png",goodsGroupType,rare))
        local iconName = data:getIconName()
        if (iconName) then
            if (DEBUG) then
                print(string.format("BagGrid odateView:nUp icon name is %s.", iconName))
            end
            
            self.ConfirmDialogModel.iconSprite:setSpriteName(iconName)
            local iconSize = self.ConfirmDialogModel.iconSprite:getContentSize()
        end

        -- 道具名字
        local name = data:getName()
        self.ConfirmDialogModel.goodsName:setText(name)
        self.ConfirmDialogModel.goodsName:autoAdapt()
        local type = UI.PROP_MATER.PROPINFO
        local proptype = UI.PROP_MATER 
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
            self.ConfirmDialogModel.goodsDes:setText(UI.TEXT_1170213)
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

            self.ConfirmDialogModel.goodsDes:setText(desStr)
        end
    end
end

function GoodsSelectTips:showGoodsView()
    local itemPadding = 82
    local size = table.nums(self.goodsDataList)
    -- local noLostText = self.ConfirmDialogModel.noGoodsText
    -- noLostText:setVisible(size == 0);
    if(size > 0) then 
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

        local scrollViewLayer = self.ConfirmDialogModel.scrollViewLayer
        scrollViewLayer:removeAllChildren();
        -- scrollViewLayer:addTouchEvents()
        scrollViewLayer:setTouchEnable(true)
        local upLayout = scrollViewLayer
        if size > CELL_NUMBER then
            upLayout = UI.TouchLayout:create()
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
        end
        local beginPosX = 26
        local index = 1
        for k, goodData in pairs(self.goodsDataList) do
            goodData:setIsNew(false)
            local goodGrid = UI.GoodsGrid:create()
            goodGrid:init(goodData)
            upLayout:addChild(goodGrid)
            goodGrid:hideFlagIcon()
            goodGrid:setInfoArea(false, false)
            -- goodGrid:showSelect()
            -- goodGrid:deleteItem()
            -- goodGrid:showChoiceStatus()

            local mode = index % CELL_NUMBER
            mode = mode == 0 and CELL_NUMBER or mode
            goodGrid:leftUp(beginPosX + (mode - 1) * itemPadding, math.floor((index - 1) / CELL_NUMBER) * itemPadding)
            table.insert(self.allGridNode, goodGrid)
            index = index + 1
        end    
    end
end

function GoodsSelectTips:onTouchBegan(touch, event)
    -- print(" GoodsSelectTips:onTouchBegan")
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

function GoodsSelectTips:onTouchEnded(touch, event)
    -- print(" GoodsSelectTips:onTouchEnded")
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            if self._buttonStatus == STATUS.OPEN then
                local pInfoArea = value:onShowInfoAreaHandler(true)
                if pInfoArea then
                    local leftX = winSize.width / 2 - self.rootLayer:getContentSize().width / 2 - pInfoArea:getContentSize().width + 66
                    if(leftX < Avalon.issUtil:getLeftMargin() + 2) then 
                        leftX = Avalon.issUtil:getLeftMargin() + 2
                    end
                    pInfoArea:centerLeft(leftX)
                    pInfoArea:setZOrder(UI_ZORDER.TIPS)
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