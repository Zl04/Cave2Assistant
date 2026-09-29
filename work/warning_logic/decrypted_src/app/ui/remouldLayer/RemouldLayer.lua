-- RemouldLayer.lua
-- Author:ODEI
-- 2017年7月13日
-- Using:改造 

require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.remouldLayer.RemouldCloseLayer"
require "app.datas.goods.EquipmentData"
local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.EquipWorkshop")

UI = UI or {}

local RemouldLayer = class("RemouldLayer", UI.DoorWin)
UI.RemouldLayer = RemouldLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_blacksmith.plist",
    "ui_town_home.plist",
}

local PageType = {
    Remould = 1,
    Inherit = 2,
    Max = 3,
}

local gridXOffset = 1;
local gridYOffset = -1;

--构造函数(必备)
function RemouldLayer:ctor(spriteID)
    --窗口大小
    RemouldLayer.super.ctor(
    self,UIType.REMOULD_LAYER,
    COM_RES_LIST,
    318,    
    winSize.height
    )
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.mGoodsData = nil;          --装备
    self.mGoodsGrid = nil;          --装备框

    self.mSelectArrIndex = 0;            --选中的属性

    self.mPropertyBtnList = {};     --属性列表

    -- 标签页面
    self._pageType = PageType.Remould
    self._pageTable = {}

    self.remouldLayer = nil

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();

    self.mCanRemould = true;       --是否能改造

    self.npcInfomationNum = 0
    self.npcInfomationNumByArr = 0

    self.mGoodsDataChange = nil;          --改造装备属性
    self.mGoodsDataGet = nil;             --继承装备属性

    self.mCloseLayer = nil
    self.mIsRunningInherit = false -- 是否有继承完毕没有选择的替换

    self.mCanInherit = true;       --是否能继承，防止连点

    self.mInheritData = {} -- 继承后的结果展示数据
end

--虚构函数,destroy时调用(必备)
function RemouldLayer:dtor()
    RemouldLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function RemouldLayer:init()
    RemouldLayer.super.init(self)
    self:setCloseStartCallBack(handler(self, self.createCloseLayer))
end

function RemouldLayer:createCloseLayer()
    if self.mIsRunningInherit then
        if not self.mCloseLayer then
            self.mCloseLayer = UI.RemouldCloseLayer:create()
            self.mCloseLayer:init()
            self.mCloseLayer:center(winSize.width / 2 + 240, - winSize.height / 2 + 100)
            self:addChild(self.mCloseLayer, 50)
        else
            self.mCloseLayer:show()
        end
        return false
    else
        return true
    end
end

-- 模版函数：初始化组建的视图(必备)
function RemouldLayer:onInitView()
    -- self:addColorBG()        --灰色遮罩层

    --root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width, winSize.height))
    self:addChild(self.rootLayer)

    self.makeEquipModel = model.createmakeEquipNode()
    self.leftLayer = self.makeEquipModel.root
    self.rootLayer:addChild(self.makeEquipModel.root, 10)


    ---------------------
    local makeEquipBg = UI.Image:create()
    makeEquipBg:init("ui_blacksmith_fireplace1.png")

    local pageName = {
        [PageType.Remould] = UI.TEXT_226607,
        [PageType.Inherit] = UI.TEXT_226608,
    }

    local index = 0
    for i = PageType.Remould, PageType.Max - 1 do
        local pageBtn = UI.Button:create()
        pageBtn:init('ui_home_retrofit_bookmark_normal.png', 'ui_home_retrofit_bookmark_normal.png', 'ui_home_retrofit_bookmark_checked.png')
        pageBtn:leftBottom(makeEquipBg:getContentSize().width - 38, makeEquipBg:getContentSize().height - 70 - index*65)
        pageBtn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 114, g = 109, b = 116})
        pageBtn:setText(pageName[i])
        pageBtn:setTextOffset(-14,0)
        pageBtn:closeClickScale()
        
        pageBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:updatePageView(i)

            for k,v in pairs(self._pageTable) do
                if i == k then
                    v:disable()
                    v:setFontColor({r = 220, g = 182, b = 80})
                else
                    v:enable()
                    v:setFontColor({r = 114, g = 109, b = 116})
                end
            end

        end)
        self.leftLayer:addChild(pageBtn)
        self._pageTable[i] = pageBtn

        if i == self._pageType then
            pageBtn:disable()
            pageBtn:setFontColor({r = 220, g = 182, b = 80})
        else
            pageBtn:enable()
            pageBtn:setFontColor({r = 114, g = 109, b = 116})
        end

        index = index + 1
    end
    ---------------------

    self:createRemouldLayer()
    self:createInheritLayer()
    --self:updatePageView(PageType.Remould)
    -- self.remouldLayer = model.create("RemouldLayer")
    -- self.remouldLayer.root:leftUp(96, 0)
    -- self.remouldLayer.root:setVisible(true)
    -- self.makeEquipModel.root:addChild(self.remouldLayer.root)

    self.fireAnimation = self.makeEquipModel.fireAnimation
    --self.fireAnimation:addEventListener(UIEvent.ANIMATION_END, self, self.FireAnimationCallback)
    self.fireAnimation2 = self.makeEquipModel.fireAnimationFront

    self.mTxtEquipName = self.makeEquipModel.titleStr
    self.makeEquipModel.btnBg:show()
 
    --改造btn
    self.mBtnConfireRemould = self.makeEquipModel.executeButton
    --self.mBtnConfireRemould:addEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireRemould)
    AvalonUtil.addBracketsAnimationToButton(self.mBtnConfireRemould)
    self.mBtnConfireRemould:disable()

    self.mBtnReplace = self.makeEquipModel.executeButtonRep
    --self.mBtnReplace:addEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireRemould)
    self.mBtnReplace:show()
    self.mBtnReplace:leftBottom(59, 25)
    self.mBtnReplace:setText(UI.TEXT_1212211)

    self.mBtnContiue = self.makeEquipModel.executeButtonContiue
    --self.mBtnContiue:addEventListener(UIEvent.BUTTON_CLICK, self, self.onContiueRemould)
    self.mBtnContiue:show()
    self.mBtnContiue:rightBottom(59, 25)

    local contiueStr = UI.Text:create()
    contiueStr:init(UI.TEXT_1212212, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    contiueStr:leftBottom(235 - contiueStr:getContentSize().width / 2, 62)
    self.makeEquipModel.makeEquipBg:addChild(contiueStr)
    self.contiueStr = contiueStr

    self.mTxtRemould = self.makeEquipModel.executeButtonLabel
    self.mTxtRemould:setText(UI.TEXT_110203)
    self.mTxtRemould:show()
    -- self.mGoodsGrid = UI.GoodsGrid:create()
    -- self.mGoodsGrid:init()
    -- self.mGoodsGrid:center(gridXOffset, gridYOffset)
    -- self.mGoodsGrid:hide()
    -- self.mGoodsGrid:hideCountLabel()
    -- self.mGoodsGrid:hideNewIcon()
    -- self.mGoodsGrid:setTouchEnable(true)
    -- self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    -- self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid));
    -- self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))

    -- self.mGoodsGrid:showInfoArea();
    -- self.remouldLayer.materalNode:addChild(self.mGoodsGrid, 10)

    local selectMode = UI.Layout:create()
    selectMode:init()
    selectMode:setSize(self.leftLayer:getContentSize().width, self.leftLayer:getContentSize().height)
    selectMode:center()
    self.leftLayer:addChild(selectMode)
    self.selectMode = selectMode
    for i = 1, 3 do
        local itemModel = model.create("AttRemouldModel")
        local btnProperty = itemModel.root
        btnProperty.itemModel = itemModel
        btnProperty:setPos(47, 170 + 85 * i)
        btnProperty:addEventListener(UIEvent.BUTTON_CLICK,self,self.onSelectedArr)
        btnProperty:setTag(i)

        self.selectMode:addChild(btnProperty)
        btnProperty:disable()

        local txtProperty = itemModel.attRemouldDes
        txtProperty:setVisible(false)

        itemModel.attBuildIndicator:setVisible(false)
        table.insert(self.mPropertyBtnList,btnProperty)
    end

    local tempAttrMode = UI.Layout:create()
    tempAttrMode:init()
    tempAttrMode:setSize(self.leftLayer:getContentSize().width, self.leftLayer:getContentSize().height)
    tempAttrMode:centerLeft(-winSize.width)
    self.leftLayer:addChild(tempAttrMode)
    self.tempAttrMode = tempAttrMode
    
    local titleStr = UI.Text:create()
    titleStr:init(UI.TEXT_1212205, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    titleStr:centerUp(235)
    tempAttrMode:addChild(titleStr)
    self.choseTitleStr = titleStr

    local oldAttr = self:createAttrPanel(true)
    oldAttr:centerUp(275)
    tempAttrMode:addChild(oldAttr)
    oldAttr:setName("OLDATTR")

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine:setContentSize(213, 1)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(180, 284)
    tempAttrMode:addChild(splitLine)

    local line = UI.Image:create()
    line:init("ui_blacksmith_choose_0.png")
    line:centerBottom(1)
    tempAttrMode:addChild(line)
    
    local newAttr = self:createAttrPanel(false)
    newAttr:centerUp(365)
    tempAttrMode:addChild(newAttr)
    newAttr:setName("NEWATTR")
    tempAttrMode:hide()

    self.mTxtDiamondNum = self.makeEquipModel.executeButtonPrice
    self.mTxtDiamondNum:setText(0)

    -- --改造特效
    -- self.remouldSpine = UI.Animation:create()
    -- self.remouldSpine:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    -- self.remouldSpine:center()
    -- self.remouldLayer.materalNode:addChild(self.remouldSpine,10)

    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0 --"all"
    table.insert(usedTypeList, _usedType1)

    --右边背包数据
    local bagList = UI.BagGoodsPanel:create(usedTypeList, true, false)
    bagList:setHideBagType(
            {
                UI.BagGoodsPanel.BAG_TYPE.ALL,
                UI.BagGoodsPanel.BAG_TYPE.ITEM,
                UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
                UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
                UI.BagGoodsPanel.BAG_TYPE.RELIC,
                -- UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP
            }
        )
    bagList:setShowBagTagExt(
        {
            UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
        }
    )
    
    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self.rootLayer:addChild(bagList, 5)
    local bagListW, bagListH = bagList:getSize()
    bagList:leftBottom(winSize.width + bagListW, 300 - bagListH / 2)
    bagList:changeBagDefaultIndex(2)


    self.remouldSpine:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "audio_action" then
                Avalon.AudioManager:playSound("1517")
            elseif event.eventData.name == "audio_prepare" then
                Avalon.AudioManager:playSound("1512")
            end
        end
    end)

    self:setDoorNode(self.leftLayer, bagList)

    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110429))
    self:resetSpineAnimation()
    self:updatePageView(PageType.Remould, true)
end

function RemouldLayer:updatePageView(pageType, isForce)
    if (pageType == nil or pageType == self._pageType) and not isForce then
        return
    end
    
    self._pageType = pageType

    self:createLeftView()
    self:createRightView()
    self:refreshAllStatus()
end

function RemouldLayer:createLeftView()
    if self._pageType == PageType.Remould then
        self:createRemouldLayer()
        self:changeButtonListener(PageType.Remould)
    else
        self:createInheritLayer()
        self:changeButtonListener(PageType.Inherit)
    end
end

function RemouldLayer:changeButtonListener(pageTypeIndex)
    if pageTypeIndex == PageType.Remould then
        self.fireAnimation:removeEventListener(UIEvent.ANIMATION_END, self, self.inheritFireAnimationCallback)
        self.mBtnConfireRemould:removeEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireInherit)
        self.mBtnReplace:removeEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireInherit)
        self.mBtnContiue:removeEventListener(UIEvent.BUTTON_CLICK, self, self.onContiueInherit)

        self.fireAnimation:addEventListener(UIEvent.ANIMATION_END, self, self.FireAnimationCallback)
        self.mBtnConfireRemould:addEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireRemould)
        self.mBtnReplace:addEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireRemould)
        self.mBtnContiue:addEventListener(UIEvent.BUTTON_CLICK, self, self.onContiueRemould)

        self.mBtnReplace:setText(UI.TEXT_1212211)
        self.mTxtRemould:setText(UI.TEXT_110203)
        self.choseTitleStr:setText(UI.TEXT_1212205)

    elseif pageTypeIndex == PageType.Inherit then
        self.fireAnimation:removeEventListener(UIEvent.ANIMATION_END, self, self.FireAnimationCallback)
        self.mBtnConfireRemould:removeEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireRemould)
        self.mBtnReplace:removeEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireRemould)
        self.mBtnContiue:removeEventListener(UIEvent.BUTTON_CLICK, self, self.onContiueRemould)

        self.fireAnimation:addEventListener(UIEvent.ANIMATION_END, self, self.inheritFireAnimationCallback)
        self.mBtnConfireRemould:addEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireInherit)
        self.mBtnReplace:addEventListener(UIEvent.BUTTON_CLICK, self, self.onConfireInherit)
        self.mBtnContiue:addEventListener(UIEvent.BUTTON_CLICK, self, self.onContiueInherit)
        
        self.mBtnReplace:setText(UI.TEXT_110012)
        self.mTxtRemould:setText(UI.TEXT_226609)
        self.choseTitleStr:setText(UI.TEXT_226612)

    end
end

function RemouldLayer:createRemouldLayer()
    if self.remouldLayer and self.InheritLayerChange and self.InheritLayerGet then
        self.remouldLayer.RemouldLayer:show()
        self.InheritLayerChange.RemouldLayer:hide()
        self.InheritLayerGet.RemouldLayer:hide()
        return
    end

    self.remouldLayer = model.create("RemouldLayer")
    self.remouldLayer.root:leftUp(96, 0)
    self.remouldLayer.root:setVisible(true)
    self.makeEquipModel.root:addChild(self.remouldLayer.root)
 
    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:center(gridXOffset, gridYOffset)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setTouchEnable(true)
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid));
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))

    self.mGoodsGrid:showInfoArea();
    self.remouldLayer.materalNode:addChild(self.mGoodsGrid, 10)

    --改造特效
    self.remouldSpine = UI.Animation:create()
    self.remouldSpine:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    self.remouldSpine:center()
    self.remouldLayer.materalNode:addChild(self.remouldSpine,10)
end

function RemouldLayer:createInheritLayer()
    if self.remouldLayer and self.InheritLayerChange and self.InheritLayerGet then
        self.remouldLayer.RemouldLayer:hide()
        self.InheritLayerChange.RemouldLayer:show()
        self.InheritLayerGet.RemouldLayer:show()
        return
    end

    self.InheritLayerChange = model.create("RemouldLayer")
    self.InheritLayerChange.root:leftUp(35, 0)
    self.InheritLayerChange.root:setVisible(true)
    self.InheritLayerChange.materalIcon:setSpriteName("ui_blacksmith_platform.png")
    self.makeEquipModel.root:addChild(self.InheritLayerChange.root)

    self.mGoodsGridChange = UI.GoodsGrid:create()
    self.mGoodsGridChange:init()
    self.mGoodsGridChange:center(gridXOffset, gridYOffset)
    self.mGoodsGridChange:hide()
    self.mGoodsGridChange:hideCountLabel()
    self.mGoodsGridChange:hideNewIcon()
    self.mGoodsGridChange:setTouchEnable(true)
    self.mGoodsGridChange:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGridChange:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid));
    self.mGoodsGridChange:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridChange))

    self.mGoodsGridChange:showInfoArea();
    self.InheritLayerChange.materalNode:addChild(self.mGoodsGridChange, 10)

    -- 转换背景提示
    local convertBg = UI.Image:create()
    convertBg:init("ui_blacksmith_arrow0.png")
    convertBg:center(gridXOffset + 60, gridYOffset)
    convertBg:setImageRotation(180)
    self.InheritLayerChange.materalNode:addChild(convertBg, 10)

    --改造特效
    self.remouldSpineChange = UI.Animation:create()
    self.remouldSpineChange:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    self.remouldSpineChange:center()
    self.InheritLayerChange.materalNode:addChild(self.remouldSpineChange,10)


    self.InheritLayerGet = model.create("RemouldLayer")
    self.InheritLayerGet.root:leftUp(155, 0)
    self.InheritLayerGet.root:setVisible(true)
    self.InheritLayerGet.materalIcon:setSpriteName("ui_blacksmith_inherit.png")
    self.makeEquipModel.root:addChild(self.InheritLayerGet.root)

    self.mGoodsGridGet = UI.GoodsGrid:create()
    self.mGoodsGridGet:init()
    self.mGoodsGridGet:center(gridXOffset, gridYOffset)
    self.mGoodsGridGet:hide()
    self.mGoodsGridGet:hideCountLabel()
    self.mGoodsGridGet:hideNewIcon()
    self.mGoodsGridGet:setTouchEnable(true)
    self.mGoodsGridGet:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGridGet:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid));
    self.mGoodsGridGet:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridGet))

    self.mGoodsGridGet:showInfoArea();
    self.InheritLayerGet.materalNode:addChild(self.mGoodsGridGet, 10)

    --改造特效
    self.remouldSpineGet = UI.Animation:create()
    self.remouldSpineGet:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    self.remouldSpineGet:center()
    self.InheritLayerGet.materalNode:addChild(self.remouldSpineGet,10)
end

function RemouldLayer:createRightView()
    
end

function RemouldLayer:createAttrPanel(isOld, attr)
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(263, 82)
    local text = UI.TEXT_1212207
    if isOld then
        text = UI.TEXT_1212206
    end 
    panel:setTouchEnable(true)
    panel:addEventListener(UIEvent.COMPONENT_CLICK, panel, function(panel)
        self:showAllPropertyByPanelName(panel:getName())
    end)
    -- panel:enableDebugDraw()
    local bg = UI.Image:create()
    bg:init("ui_blacksmith_choose_0.png")
    bg:centerBottom(20)
    panel:addChild(bg)
    bg:setName("BG")
    if isOld then
        bg:hide()
    end

    local titleStr = UI.Text:create()
    titleStr:init(text, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    titleStr:centerUp(7)
    panel:addChild(titleStr)
    titleStr:setName("TITLE")

    local attrText = UI.Text:create()
    attrText:init("----", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    attrText:centerBottom(17)
    panel:addChild(attrText)
    if attr then
        local _DetailDescription = attr:getDetailDescription()
        attrText:setText(_DetailDescription[1].._DetailDescription[2])
    end
    attrText:setName("ATTR")
    self.attrPanelList = self.attrPanelList or {}
    table.insert(self.attrPanelList, panel)
    return panel
end

function RemouldLayer:attrPanelSelect(attrPanel)
    for k, v in ipairs(self.attrPanelList) do
        if attrPanel:getName() == v:getName() then
            v:getChildByName("BG"):setSpriteName("ui_blacksmith_choose_1.png")
            v:getChildByName("BG"):centerBottom(13)
            v:getChildByName("TITLE"):setFontSize(21)
            v:getChildByName("ATTR"):setFontSize(21)
            self.mSelectArrIndex = k
        else
            v:getChildByName("BG"):setSpriteName("ui_blacksmith_choose_0.png")
            v:getChildByName("BG"):centerBottom(20)
            v:getChildByName("TITLE"):setFontSize(UI.FONT_SIZE_20PX)
            v:getChildByName("ATTR"):setFontSize(UI.FONT_SIZE_20PX)
        end
    end
end

function RemouldLayer:resetSpineAnimation()
    self.fireAnimation:setAnimation("begin", false)
    self.fireAnimation2:setAnimation("begin", false)
    self.remouldSpine:setAnimation("begin", false)
    self:refreshGoodsGrid(true)

    self.remouldSpineGet:setAnimation("begin", false)
    self.remouldSpineChange:setAnimation("begin", false)
end

function RemouldLayer:runReadyAnimtion(isDragOut)
    if isDragOut ~= nil and isDragOut == true then
        self.fireAnimation:setAnimation("putin3", false)
        self.fireAnimation:addAnimation("ready2", true)
    else
        self.fireAnimation:setAnimation("ready1", false)
        self.fireAnimation:addAnimation("ready2", true)
        self.remouldSpine:setAnimation("ready1", false)
        self.fireAnimation2:setAnimation("ready1", false)
    end
    self.mGoodsGrid:setLocalZOrder(20)
end

function RemouldLayer:runCancelReadyAnimtion()
    self.fireAnimation:setAnimation("ready3", false)
    self.fireAnimation2:setAnimation("ready3", false)
    self.remouldSpine:setAnimation("ready3", false)
end

function RemouldLayer:runPutAnimtion()
    self.fireAnimation:setAnimation("putin1", false)
    self.fireAnimation:addAnimation("putin2", true)
    self.fireAnimation2:setAnimation("putin1", false)
    self.remouldSpine:setAnimation("putin1", false)
    self.mGoodsGrid:setLocalZOrder(0)
end

function RemouldLayer:runSuccessAnimtion()
    self.fireAnimation:setAnimation("trigger2", false)
    self.fireAnimation:addAnimation("putin2", true)
    self.fireAnimation2:setAnimation("trigger2", false)
    self.remouldSpine:setAnimation("trigger", false)
    if self._pageType == PageType.Remould then
        UI.ScrollBar:createByText(UI.TEXT_1212030)
    else
        UI.ScrollBar:createByText(UI.TEXT_226611)
    end
end

function RemouldLayer:FireAnimationCallback(event, obj)
    if event.animation == "trigger2" then
        self.mCanRemould = true
        self._bagGridList:updateCanDrag(true)
        self:refreshGoodsGrid(true)
    end
end

function RemouldLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end
    
    if self._pageType == PageType.Inherit then
        if not self.mGoodsDataChange then
            -- 自动放入空的装备改造框内
            self:runInheritReadyAnimtion(false, true)
        elseif not self.mGoodsDataGet then
            -- 自动放入空的装备继承框内
            self:runInheritReadyAnimtion(false, false)
        else
        end
    else
        self:runReadyAnimtion()
    end
    --self:runReadyAnimtion()

    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
end

function RemouldLayer:bagDragMovedCallback(grid, touchPosition)
    -- print("RemouldLayer:bagDragMovedCallback",touchPosition.x,touchPosition.y)
end

function RemouldLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))

    if not isInBag then
        if self:inLogicInherit(grid, touchPosition) then
            return 
        end

        local goodsData = grid:getData()

        local _randomArr = goodsData._randomArr

        if #_randomArr == 0 then
            UI.ScrollBar:createByText(UI.TEXT_110205)
            self:runCancelReadyAnimtion()
            return
        end

        if self.mGoodsData ~= nil then
            self.mGoodsData._changeNum = 0
        end

        self:runPutAnimtion();

        goodsData._changeNum = -1
        self.mGoodsData = goodsData
        self._bagGridList:refreshView()
        self:refreshGoodsGrid(false)


        if self.npcInfomationNum == 0 then
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110430))
            self.npcInfomationNum = self.npcInfomationNum + 1
        end
    else
        --self:runCancelReadyAnimtion();
        if self._pageType == PageType.Inherit then
            if not self.mGoodsDataChange then
                -- 自动放入空的装备改造框内
                self:runInheritCancelReadyAnimtion(true, false)
            elseif not self.mGoodsDataGet then
                -- 自动放入空的装备继承框内
                self:runInheritCancelReadyAnimtion(false, false)
            else
            end
        else
            self:runCancelReadyAnimtion()
        end
    end
end 

-- 模版函数：更新组建的视图(必备)
function RemouldLayer:onUpdateView()
  
end

--刷新改造材料
function RemouldLayer:refreshGoodsGrid(isHideAllProperty)
    self.tempAttrMode:hide()
    self.tempAttrMode:centerLeft(-winSize.width)
    self.selectMode:show()
    self.selectMode:center()
    if self.mGoodsGrid == nil then
        self:updateBtnState()
        return
    end

    if self.mGoodsData == nil then
        for i = 1,#self.mPropertyBtnList do
            local item = self.mPropertyBtnList[i]
            local txtProperty = item.itemModel.attRemouldDes
            local picRemouldMark = item.itemModel.attBuildIndicator
            txtProperty:setVisible(false)
            picRemouldMark:setVisible(false)
            self.mPropertyBtnList[i]:disable()
        end
        self:updateArrBtnSelected(0, isHideAllProperty)
        self.mGoodsGrid:hide()
        self:updateBtnState()
        return
    end
    self.mGoodsGrid:setData(self.mGoodsData)
    self.mGoodsGrid:updateView()
    self.mGoodsGrid:show()
    self.mGoodsGrid:center(gridXOffset, gridYOffset)
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:hideBG()

    self.mTxtEquipName:setText(UI.TEXT_1212027)

    if self.mGoodsData:isHaveTmpRemodelAttr() then
        self.tempAttrMode:show()
        self.tempAttrMode:center()
        self.selectMode:hide()
        self.selectMode:centerLeft(-winSize.width)
        local attrList =  self.mGoodsData:getTmpRemodelAttr()
        for k, v in ipairs(self.attrPanelList) do
            local data = attrList[k]
            if data then
                local _DetailDescription = data:getDetailDescription()
                v:getChildByName("ATTR"):setText(_DetailDescription[1].._DetailDescription[2])
            end
        end
        self:attrPanelSelect(self.attrPanelList[#self.attrPanelList]) 
    else
        --改造标识
        local remouldMark = false
        local _randomArr = self.mGoodsData._randomArr
        local isHaveTransForm = false
        for k, v in ipairs(_randomArr) do
            if v.isTransform then
                isHaveTransForm = true
                break
            end
        end

        for i = 1,#self.mPropertyBtnList do
            local item = self.mPropertyBtnList[i]
            local txtProperty = item.itemModel.attRemouldDes
            local picRemouldMark = item.itemModel.attBuildIndicator
            if _randomArr[i] ~= nil then
                txtProperty:setVisible(true)
                local _DetailDescription = _randomArr[i]:getDetailDescription()
                txtProperty:setText(_DetailDescription[1].._DetailDescription[2])
                if isHaveTransForm then
                    if _randomArr[i].isTransform then 
                        picRemouldMark:setVisible(true)
                        self.mPropertyBtnList[i]:enable()

                        --设置选中状态
                        self:updateArrBtnSelected(i, isHideAllProperty)
                    else
                        picRemouldMark:setVisible(false)
                        self.mPropertyBtnList[i]:disable()
                    end
                else
                    self:updateArrBtnSelected(0, isHideAllProperty)
                    picRemouldMark:setVisible(false) 
                    self.mPropertyBtnList[i]:enable()
                end
            else
                txtProperty:setVisible(false)
                picRemouldMark:setVisible(false)
                self.mPropertyBtnList[i]:disable()
            end
        end
    end
    self:updateBtnState()
end

--选择属性
function RemouldLayer:onSelectedArr(sender)
    self:updateArrBtnSelected(sender:getTag(), false)

    if self._pageType == PageType.Remould then
        self:updateBtnState()
    else
        self:updateInheritBtnState()
    end

    if self.npcInfomationNumByArr == 0 then
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110431))
        self.npcInfomationNumByArr = self.npcInfomationNumByArr + 1
    end
end

--改变属性状态
function RemouldLayer:updateArrBtnSelected(index, isHideAllProperty)
    print("RemouldLayer:updateArrBtnSelected",index)
    for i = 1,#self.mPropertyBtnList do
        if self.mPropertyBtnList[i]._state ~= ButtonState.DISABLE then
            
            if i == index then
                self.mPropertyBtnList[i]:setNormal("ui_btn_mosaic1_1.png")
            else
                self.mPropertyBtnList[i]:setNormal("ui_btn_mosaic1_0.png")
            end
        end
    end
    self.mSelectArrIndex = index
    if not isHideAllProperty then
        self:showAllPropertyByIndex(index)
    end
end

--刷新改造消耗水晶
function RemouldLayer:updateDiamondNum()
    if self.mGoodsGrid == nil or self.mGoodsData == nil then
        self.makeEquipModel.titleStr:setText(UI.TEXT_1300000)
        self.makeEquipModel.executeButtonLabel:setFontColor(UI.FONT_COLOR_182_201_201)
        self.makeEquipModel.executeButtonPrice:setVisible(false)
        self.makeEquipModel.executeButtonIcon:setVisible(false)
        self.makeEquipModel.executeButtonLabel:center()
        return
    end

    if not self.mGoodsData:isHaveTmpRemodelAttr() then
        local remodelNum = self.mGoodsData.remodelNum + 1
        if remodelNum > tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamonDIncreaseTime")) then
            remodelNum = tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamonDIncreaseTime"))
        end

        local diamondNum = remodelNum * tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamondBase"))
        self.mTxtDiamondNum:setText(tostring(diamondNum))

        if not Avalon.MathUtil:checkDiamonEnough(diamondNum, GameDataManager:getInstance():getDiamond()) then
            self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            self.mTxtRemould:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            if self.mCanRemould == false then--or self.mSelectArrIndex == 0 then
                self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_182_201_201)
                self.mTxtRemould:setFontColor(UI.FONT_COLOR_182_201_201)
            else
                self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_220_182_80)
                self.mTxtRemould:setFontColor(UI.FONT_COLOR_220_182_80)
            end
        end
        self.makeEquipModel.executeButtonLabel:setText(UI.TEXT_110203)
        self.makeEquipModel.executeButtonPrice:setVisible(true)
        self.makeEquipModel.executeButtonIcon:setVisible(true)
        AvalonUtil.updateIconStringLayout(self.makeEquipModel.priceLayer)
        self.makeEquipModel.executeButtonLabel:centerLeft(75 - self.makeEquipModel.executeButtonLabel:getContentSize().width / 2)
        self.makeEquipModel.priceLayer:centerRight(75 - self.makeEquipModel.priceLayer:getContentSize().width / 2)
    else
        local remodelNum = self.mGoodsData.remodelNum + 1
        if remodelNum > tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamonDIncreaseTime")) then
            remodelNum = tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamonDIncreaseTime"))
        end

        local diamondNum = remodelNum * tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamondBase"))
        self.makeEquipModel.executeButtonRepPrice:setText(tostring(diamondNum))
        self.makeEquipModel.executeButtonRepPrice:center(15,0)

        local diamondIcon = self.makeEquipModel.contiuePriceLayer:getChildByName("executeButtonIcon")
        diamondIcon:setVisible(true)

        if not Avalon.MathUtil:checkDiamonEnough(diamondNum, GameDataManager:getInstance():getDiamond()) then
            self.makeEquipModel.executeButtonRepPrice:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            self.makeEquipModel.executeButtonRepPrice:setFontColor(UI.FONT_COLOR_50_50_44)
        end
        AvalonUtil.updateIconStringLayout(self.makeEquipModel.contiuePriceLayer)
    end
end

--刷新改造按钮
function RemouldLayer:updateBtnState()
    if self.mCanRemould == false or self.mGoodsData == nil then--or self.mSelectArrIndex == 0 then
        self.mBtnConfireRemould:disable()
        self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_182_201_201)
        self.mTxtRemould:setFontColor(UI.FONT_COLOR_182_201_201)
        self.mBtnReplace:hide()
        self.mBtnContiue:hide()
        self.mBtnReplace:disable()
        self.mBtnContiue:disable()
        self.contiueStr:hide()
    else
        if self.mGoodsData:isHaveTmpRemodelAttr() then
            self.mBtnReplace:show()
            self.mBtnContiue:show()
            self.mBtnReplace:enable()
            self.mBtnContiue:enable()
            self.contiueStr:show()
            self.mBtnConfireRemould:hide()
        else
            self.mBtnReplace:hide()
            self.mBtnContiue:hide()
            self.mBtnReplace:disable()
            self.mBtnContiue:disable()
            self.contiueStr:hide()
            self.mBtnConfireRemould:show()
            self.mBtnConfireRemould:enable()
            self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_220_182_80)
            self.mTxtRemould:setFontColor(UI.FONT_COLOR_220_182_80)
        end
    end
    self:updateDiamondNum()
end

function RemouldLayer:onTouchBeganByGoodsGrid(grid)
    if self.mCanRemould == false or self.mCanInherit == false then
        return false
    end
    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
    
    self:runReadyAnimtion(true)
    return true
end

function RemouldLayer:onTouchEndedByGoodsGrid(grid, isInSide)

    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if isInSide then
        self:runPutAnimtion();
        self.mGoodsGrid:center(gridXOffset, gridYOffset)
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        local goodsData = grid:getData()
        self.mGoodsData._changeNum = 0

        -- self._bagGridList:changeBagIndex(self._bagGridList:getChangeBagIndexByGoodsData(goodsData))

        self.mGoodsData = nil
        self:refreshGoodsGrid(false)
        self._bagGridList:refreshView()
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110429))
        self.npcInfomationNumByArr = 0
        self.npcInfomationNum = 0
        self:runCancelReadyAnimtion()
    end
end

function RemouldLayer:onContiueRemould()
    self:onRemould(true)
end

--改造
function RemouldLayer:onConfireRemould()
    if self.mCanRemould == false or self.mGoodsData == nil then
        return
    end

     --检查角色  行为是否合法
    if RoleBehaviorManager:equipTownNpcCheck() then
        printWarn(" been blocked when using equipment npc remould function !")
        return
    end

    if self.mGoodsData:isHaveTmpRemodelAttr() then
        if self.mSelectArrIndex == 0 then
            --这里需要飘字未选择属性
            UI.ScrollBar:createByText(UI.TEXT_1212208)
            return
        end

        if RoleBehaviorManager:equipTownNpcCheck() then
            printWarn(" been blocked when using equipment npc remould function !")
            return
        end
        local attrData = self.mGoodsData:getTmpRemodelAttr()[1]
        if self.mSelectArrIndex == 1 then
            Net.NetNPCSystem:reqSureRemould(self.mGoodsData, attrData:getAttrType(), self.spriteID, true)
        else
            Net.NetNPCSystem:reqSureRemould(self.mGoodsData, attrData:getAttrType(), self.spriteID, false)
        end
    else
        self:onRemould()
    end
end

--改造
function RemouldLayer:onRemould(isContiue)
    if self.mCanRemould == false or self.mGoodsData == nil then
        return
    end

    --检查角色  行为是否合法
    if RoleBehaviorManager:equipTownNpcCheck() then
        printWarn(" been blocked when using equipment npc remould function !")
        return
    end
    if self.mSelectArrIndex == 0 then
        --这里需要飘字未选择属性
        UI.ScrollBar:createByText(UI.TEXT_110204)
        return
    end

    local remodelNum = self.mGoodsData.remodelNum + 1
    if remodelNum > tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamonDIncreaseTime")) then
        remodelNum = tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamonDIncreaseTime"))
    end
    local diamondNum = remodelNum * tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamondBase"))

    if not Avalon.MathUtil:checkDiamonEnough(diamondNum, GameDataManager:getInstance():getDiamond()) then
        UI.TipsLayer:onDiamondNotEnough()
        return
    end
    
    local isNoticeRemould = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeRemould..GameDataManager:getInstance():getMasterPK(), true)  
    --二次确认
    if self.mGoodsData:getRemodelCount() >= checkint(ConfigManager:getGeneralForKey("RebuildingCoolWarning")) and isNoticeRemould then
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212209, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeRemould..GameDataManager:getInstance():getMasterPK(), false)  
            end

            local remodelNum = self.mGoodsData.remodelNum + 1
            if remodelNum > tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamonDIncreaseTime")) then
                remodelNum = tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamonDIncreaseTime"))
            end
            local diamondNum = remodelNum * tonumber(ConfigManager:getGeneralForKey("remodelRandCostDiamondBase"))

            if not Avalon.MathUtil:checkDiamonEnough(diamondNum, GameDataManager:getInstance():getDiamond()) then
                UI.TipsLayer:onDiamondNotEnough()
                return
            end
            --改造
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            if isContiue then
                local attrData = self.mGoodsData:getTmpRemodelAttr()[1]
                Net.NetNPCSystem:sendRemodel(self.mGoodsData, attrData:getAttrType(), self.spriteID)
            else
                local _randomArr = self.mGoodsData._randomArr
                Net.NetNPCSystem:sendRemodel(self.mGoodsData,_randomArr[self.mSelectArrIndex].attrType, self.spriteID)
            end
            self._bagGridList:updateCanDrag(false)
            self.mCanRemould = false
            self:updateBtnState()
            self:updateGridState(false, true)

        end, function(isSelect)
            
        end, nil, nil, true)
        return
    end
   
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    if isContiue then
        local attrData = self.mGoodsData:getTmpRemodelAttr()[1]
        Net.NetNPCSystem:sendRemodel(self.mGoodsData, attrData:getAttrType(), self.spriteID)
    else
        local _randomArr = self.mGoodsData._randomArr
        Net.NetNPCSystem:sendRemodel(self.mGoodsData,_randomArr[self.mSelectArrIndex].attrType, self.spriteID)
    end
    self._bagGridList:updateCanDrag(false)
    self.mCanRemould = false
    self:updateBtnState()
    self:updateGridState(false, true)
end

--改造网络回调 isConfireRep: 是否是二次确认回调
function RemouldLayer:remouldCallBack(data, isConfireRep, isCancle)
    UI.WaitingLayer:hideWaiting() 
    self.mSelectArrIndex = 0
    if isConfireRep then
        self:refreshGoodsGrid(true)
    else
        self:updateGridState(true, false)
        if data.flag == "RemodelResultType_Succeed" then
            self:runSuccessAnimtion();
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RemodelResultType",data.flag))
            self.mCanRemould = true
            self._bagGridList:updateCanDrag(true)
        end
    end
end

function RemouldLayer:remouldFailCallBack()
    UI.WaitingLayer:hideWaiting()
    self:updateGridState(true, false)
    self.mCanRemould = true
    self._bagGridList:updateCanDrag(true)
end

-- 注册监听事件(可选)
function RemouldLayer:registerListener()
    --改造结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_REMODEL, self, self.remouldCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_REMODEL_FAIL, self, self.remouldFailCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)

    --改造继承
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_REMODEL_INHERIT, self, self.inheritSuccessCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_REMODEL_INHERIT_REPLACE, self, self.inheritReplaceSuccessCallBack)

end

-- 注销监听事件(可选)
function RemouldLayer:unRegisterListener()
    --改造结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_REMODEL, self, self.remouldCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_REMODEL_FAIL, self, self.remouldFailCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)

    --改造继承
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_REMODEL_INHERIT, self, self.inheritSuccessCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_REMODEL_INHERIT_REPLACE, self, self.inheritReplaceSuccessCallBack)
end

-- 角色金币和钻石变化
function RemouldLayer:onCurrencyChangeHandler()
    self:updateBtnState()
end

--[[锁住左边格子， isDelay 仅表示延时刷新变灰状态（展示效果）]]
function RemouldLayer:updateGridState(isCanUse, isDelay)
    print("-----------updateCanUseState")
    if not isDelay then
        self.mGoodsGrid:updateCanUseState(isCanUse)
    else 
        self.mGoodsGrid:updateCanUseStateAndDelayRefresh(isCanUse, 0.3)
    end
end

function RemouldLayer:showAllPropertyByIndex(index)
    if index == 0 then
        return
    end
    local removeAttr = {}
    local _randomArr = {}
    local forceShowArr = {} -- 强行展示的属性范围，这里有值就不显示随机属性范围

    -- 是否在装备属性继承的逻辑中
    if self._pageType == PageType.Inherit then
        _randomArr = self.mGoodsDataGet._randomArr
        local showArrList = self.mGoodsDataChange:getRemodelAttr()
        for k,v in pairs(showArrList) do
            table.insert(forceShowArr, v:getAttrType())
        end
    else
        _randomArr = self.mGoodsData._randomArr
    end

    for k, v in ipairs(_randomArr) do
        if k ~= index then
            table.insert(removeAttr, v.attrType)
        end
    end

    -- 是否在装备属性继承的逻辑中
    if self._pageType == PageType.Inherit then
        self:showAllProperty(75 * (index - 1), removeAttr, self.mGoodsDataGet, forceShowArr)
    else
        self:showAllProperty(75 * (index - 1), removeAttr, self.mGoodsData, forceShowArr)
    end
end

function RemouldLayer:showAllPropertyByPanelName(name)
    if name == "" or name == nil then
        return
    end
    local selectIndex = 1
    for k, v in ipairs(self.attrPanelList) do
        if name == v:getName() then
            selectIndex = k
            break
        end
    end

    local removeAttr = {}
    local _randomArr = {}
    local forceShowArr = {} -- 强行展示的属性范围，这里有值就不显示随机属性范围
    local goodsData = nil
    --local _randomArr = self.mGoodsData._randomArr

    -- 是否在装备属性继承的逻辑中
    if self._pageType == PageType.Inherit then
        _randomArr = self.mGoodsDataGet._randomArr
        goodsData = self.mGoodsDataGet
        local showArrList = self.mGoodsDataChange:getRemodelAttr()
        for k,v in pairs(showArrList) do
            table.insert(forceShowArr, v:getAttrType())
        end
    else
        _randomArr = self.mGoodsData._randomArr
        goodsData = self.mGoodsData
    end

    for k, v in pairs(_randomArr) do
        local isHave = false
        for k2, v2 in pairs(goodsData:getTmpRemodelAttr()) do
            if v.attrType == v2:getAttrType() then
                isHave = true
                break;
            end
        end
        if not isHave then
            table.insert(removeAttr, v.attrType)
        end
    end
    self:showAllProperty(0, removeAttr, goodsData, forceShowArr)
end

--展示 所有有可能产生的随机属性
function RemouldLayer:showAllProperty(offsetY, removeAttr, GoodsData, forceShowArr)
   print("---------removeAttr--", removeAttr)
   print("---------removeAttr-2222-", forceShowArr)
    -- local randomPool = {51,52,56,57,58,70,71,72,60,61,62,63,64,65,66,67,68,69,59,53,54,8}
    local key = tonumber(ConfigManager:getGeneralForKey("remodelRandAttributeGroupID"))
    local randomPool = clone(ConfigManager:getRandAttributeGroupByKey(key))

    --去重
    local tempPool = {}
    for k, v in ipairs(randomPool) do
        local isHave = false
        for k2, v2 in ipairs(tempPool) do
            if v2 == v then
                isHave = true
                break
            end
        end
        if not isHave then
            table.insert(tempPool, v)
        end
    end
    randomPool = tempPool
    
    local infoBg = UI.UIManager:getRootNode():getChildByName("RemouldTipModel")
    if infoBg then
         UI.UIManager:getRootNode():removeChildByName("RemouldTipModel")
    end

    local tipModel = model.create("RemouldTipModel")
    local infoBg = tipModel.root
    infoBg:showLucencyLight(infoBg._width, infoBg._height)

    local worldPos = self:convertToWorldSpace(cc.p(0,0))
    infoBg:leftUp(worldPos.x + self:getContentSize().width, self:getContentSize().height / 2 - infoBg:getContentSize().height / 2  - 50 + offsetY)
    UI.UIManager:addToRootNode(infoBg, UI_ZORDER.TIPS)
    AvalonUtil.runTipsAppearShowAnimation(infoBg);
    infoBg:setTouchEnable(true)
    infoBg:setInterceptTouches(true)
    infoBg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, infoBg, function()
       infoBg:removeFromParent(true)
    end)

    local _randomArr = GoodsData._randomArr
    for k, attrType in ipairs(removeAttr) do
        for k2 = #randomPool, 1, -1 do
            if randomPool[k2] == attrType then
                table.remove(randomPool, k2)
            end
        end
    end

    if #forceShowArr > 0 then
        randomPool = forceShowArr
    end

    local randAttributeLV = GoodsData.randAttributeLV
    if GoodsData.createLevel and GoodsData.createLevel > 0 then
        local createLevel = clone(GoodsData.createLevel)
        local levelLimiteList = string.split(GoodsData.equipRequireLvIntervals, ";")
        local randLevelLimite = string.split(levelLimiteList[3], ",")
        local lowerLimite = tonumber(randLevelLimite[1])
        local upperLimite = tonumber(randLevelLimite[2])
        createLevel = math.max(createLevel, lowerLimite + GoodsData.qualityGrade)
        createLevel = math.min(createLevel, upperLimite + GoodsData.qualityGrade)

        randAttributeLV = createLevel
    end
    local size = #randomPool
    tipModel.remouldTipScrollLayer:removeAllChildren()
    local propertyLayout = tipModel.remouldTipScrollLayer
    if size > 7 then 
        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(propertyLayout._width, propertyLayout._height)
        detailedScrollView:centerUp(0)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        propertyLayout:addChild(detailedScrollView)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarWidth(5)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(1, 0))

        --detailedScrollView:enableDebugDraw();

        local contentLayer = UI.Component:create()
        contentLayer:leftBottom(0, 0)
        contentLayer:init()
        contentLayer:setSize(propertyLayout._width, 22 * size)
        detailedScrollView:addInnerNode(contentLayer)
        --contentLayer:enableDebugDraw();
        propertyLayout = contentLayer
    end

    for k, attrType in ipairs(randomPool) do
        local strengthenConfig = ConfigManager:getEquipmentRandAttrStrengthen(attrType)
        local randArr = strengthenConfig.strengthenValuesByLV
        local addNumber = randArr[randAttributeLV] or 0
        addNumber = addNumber * GoodsData.strengthenLevel

        local attributeCfg = ConfigManager:getRandAttributeByID(attrType)
        local languageStr = ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[attrType])
        local minValue = attributeCfg.minValuesByLV[randAttributeLV] + addNumber
        local maxValue = attributeCfg.maxValuesByLV[randAttributeLV] + addNumber

        -- 判断是否为继承
        if self._pageType == PageType.Inherit then
            local inheritAttributeRange = ConfigManager:getGeneralForKey("inheritAttributeRange")
            local rangeConfig = string.split(inheritAttributeRange,",")
            local baseValue = minValue
            minValue = baseValue * (tonumber(rangeConfig[1]))/ 10000
            -- 这里的最大值随机属性现在固定在改造继承时，取最小值
            maxValue = baseValue * (tonumber(rangeConfig[2]))/ 10000
            --maxValue = maxValue * (tonumber(rangeConfig[2]))/ 10000
        end

        local tipItemModel = model.create("remouldTipAttMoule")
        tipItemModel.root:leftUp(6, 22 * (k - 1))
        tipItemModel.remouldTipAttMoule:setText(languageStr);
        tipItemModel.remouldTipAttRightLabel:setText(string.format("%d~%d", minValue, maxValue));
        tipItemModel.remouldTipAttRightLabel:leftBottom(tipItemModel.remouldTipAttMoule._width + 8, 0);
        propertyLayout:addChild(tipItemModel.root)

        local titleWidth = tipItemModel.remouldTipAttMoule:getContentSize().width
        local attrWidth = tipItemModel.remouldTipAttRightLabel:getContentSize().width
        local maxWidth = propertyLayout:getContentSize().width
        if(titleWidth + attrWidth + 18 > maxWidth) then 
            local scale = (maxWidth - 9 - titleWidth)/attrWidth
            tipItemModel.remouldTipAttRightLabel:setScale(scale)
            tipItemModel.remouldTipAttRightLabel:leftBottom(tipItemModel.remouldTipAttMoule._width + 4 - attrWidth * (1- scale) /2, 0);
        end
    end
end

function RemouldLayer:inLogicInherit(grid, touchPosition)
    -- 是否在装备属性继承的逻辑中
    if self._pageType == PageType.Inherit then

        local goodsData = grid:getData()

        -- 判断是否在格子内替换
        local isSuccess = false
        if self:isInheritRect(self.mGoodsGridChange, touchPosition) then
            isSuccess = self:choseInheritBox(true, goodsData)
        elseif self:isInheritRect(self.mGoodsGridGet, touchPosition) then
            isSuccess = self:choseInheritBox(false, goodsData)
        else
            if not self.mGoodsDataChange then
                -- 自动放入空的装备改造框内
                isSuccess = self:choseInheritBox(true, goodsData)
            elseif not self.mGoodsDataGet then
                -- 自动放入空的装备继承框内
                isSuccess = self:choseInheritBox(false, goodsData)
            else
                UI.ScrollBar:createByText(UI.TEXT_226603)
                self._bagGridList:refreshView()
                return true
            end
        end

        self:refreshGoodsGridAnimation()

        return true
    end
    return false
end

function RemouldLayer:isAllowReplaceChange(goodsData)
    -- 满足装备放入改造槽
    local _randomArr = goodsData._randomArr
    if #_randomArr == 0 then
        UI.ScrollBar:createByText(UI.TEXT_110205)
        self:runInheritCancelReadyAnimtion(true)
        return false
    end

    if not goodsData:getIsTransform() then
        UI.ScrollBar:createByText(UI.TEXT_226601)
        if not self.mGoodsDataChange then
            self:runInheritCancelReadyAnimtion(true)
        end
        --self:runInheritCancelReadyAnimtion(true)
        return false
    end

    -- 改造属性不能与继承随机属性一致
    if self.mGoodsDataGet then
        for k,v in pairs(self.mGoodsDataGet._randomArr) do
            for k1,v1 in pairs(_randomArr) do
                if v1:getIsTransform() then
                    if v1:getAttrType() == v:getAttrType() and (not v:getIsTransform()) then
                        UI.ScrollBar:createByText(UI.TEXT_226602)
                        --self:runCancelReadyAnimtion()
                        if not self.mGoodsDataChange then
                            self:runInheritCancelReadyAnimtion(true)
                        end
                        return false
                    end
                end
            end
        end
    end

    return true
end

function RemouldLayer:isAllowReplaceGet(goodsData)
    -- 满足装备放入继承槽
    local _randomArr = goodsData._randomArr
    if #_randomArr == 0 then
        UI.ScrollBar:createByText(UI.TEXT_110205)
        self:runInheritCancelReadyAnimtion(false)
        return false
    end

    if goodsData._tmpRemodelAttr then
        UI.ScrollBar:createByText(UI.TEXT_226600)
        if not self.mGoodsDataGet then
            self:runInheritCancelReadyAnimtion(false)
        end
        return false
    end
    

    if self.mGoodsDataChange then
        for k,v in pairs(_randomArr) do
            for k1,v1 in pairs(self.mGoodsDataChange._randomArr) do
                if v1:getIsTransform() then
                    if v1:getAttrType() == v:getAttrType() and (not v:getIsTransform()) then
                        UI.ScrollBar:createByText(UI.TEXT_226602)
                        --self:runCancelReadyAnimtion()
                        if not self.mGoodsDataGet then
                            self:runInheritCancelReadyAnimtion(false)
                        end
                        return false
                    end
                end
            end
        end
    end

    return true
end

function RemouldLayer:choseInheritBox(isChage, goodsData)
    local isSuccess = true

    if isChage then
        isSuccess = self:isAllowReplaceChange(goodsData)
        if isSuccess then
            -- 若装备槽原来就有装备，则将装备替换掉，并将替换的装备放回背包
            if self.mGoodsDataChange ~= nil then
                self.mGoodsDataChange._changeNum = 0
            end
            self:runInheritPutAnimtion(true)
            --self:runPutAnimtion();
            goodsData._changeNum = -1
            self.mGoodsDataChange = goodsData
            self._bagGridList:refreshView()

            self.mGoodsGridChange:setData(self.mGoodsDataChange)
            self.mGoodsGridChange:updateView()
            self.mGoodsGridChange:hideCountLabel()
            self.mGoodsGridChange:hideNewIcon()
            self.mGoodsGridChange:hideBG()
            self.mGoodsGridChange:show()
            self:refreshInheritGrid()
        end
    else
        isSuccess = self:isAllowReplaceGet(goodsData)
        if isSuccess then
            -- 若装备槽原来就有装备，则将装备替换掉，并将替换的装备放回背包
            if self.mGoodsDataGet ~= nil then
                self.mGoodsDataGet._changeNum = 0
            end
            self:runInheritPutAnimtion(false)
            --self:runPutAnimtion();
            goodsData._changeNum = -1
            self.mGoodsDataGet = goodsData
            self._bagGridList:refreshView()

            self.mGoodsGridGet:setData(self.mGoodsDataGet)
            self.mGoodsGridGet:updateView()
            self.mGoodsGridGet:hideCountLabel()
            self.mGoodsGridGet:hideNewIcon()
            self.mGoodsGridGet:hideBG()
            self.mGoodsGridGet:show()
            self:refreshInheritGrid()
        end
    end

    if not isSuccess then
        --self:runCancelReadyAnimtion()
        self._bagGridList:refreshView()
    end

    return isSuccess
end

function RemouldLayer:isInheritRect(goodsGrid, touchPosition)
    local isInBag = false
    local pos = goodsGrid:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(pos.x, pos.y, goodsGrid._width, goodsGrid._height)
    isInBag = cc.rectContainsPoint(rect, touchPosition)

    return isInBag
end

function RemouldLayer:onTouchEndedByGoodsGridChange(grid, isInSide, touchPosition)

    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if isInSide then
        local inRect = self:isInheritRect(self.mGoodsGridGet, touchPosition)
        if inRect then
            local isSccess = self:choseInheritBox(false, self.mGoodsDataChange)
            if isSccess then
                self.mGoodsDataChange = nil
                self.mGoodsGridChange:hide()
                self:refreshInheritGrid()
                self:runInheritCancelReadyAnimtion(true)
                self.mInheritData = {} -- 继承后的结果展示数据
                self.mIsRunningInherit = false -- 是否有继承完毕没有选择的替换
            end
        else
            self:runPutAnimtion();
            self.mGoodsGridGet:center(gridXOffset, gridYOffset)
        end
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        local goodsData = grid:getData()
        self.mGoodsDataChange._changeNum = 0

        self.mGoodsDataChange = nil
        self._bagGridList:refreshView()
        self.mGoodsGridChange:hide()
        self:runInheritCancelReadyAnimtion(true)
        self:refreshInheritGrid()
        self.mInheritData = {} -- 继承后的结果展示数据
        self.mIsRunningInherit = false -- 是否有继承完毕没有选择的替换
    end
    self:refreshGoodsGridAnimation()
end

function RemouldLayer:onTouchEndedByGoodsGridGet(grid, isInSide, touchPosition)

    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if isInSide then
        local inRect = self:isInheritRect(self.mGoodsGridChange, touchPosition)
        if inRect then
            local isSccess = self:choseInheritBox(true, self.mGoodsDataGet)
            if isSccess then
                self.mGoodsDataGet = nil
                self.mGoodsGridGet:hide()
                self:refreshInheritGrid()
                self:runInheritCancelReadyAnimtion(false)
                self.mInheritData = {} -- 继承后的结果展示数据
                self.mIsRunningInherit = false -- 是否有继承完毕没有选择的替换
            end
        else
            self:runPutAnimtion();
            self.mGoodsGridGet:center(gridXOffset, gridYOffset)
        end
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        local goodsData = grid:getData()
        self.mGoodsDataGet._changeNum = 0

        -- self._bagGridList:changeBagIndex(self._bagGridList:getChangeBagIndexByGoodsData(goodsData))

        self.mGoodsDataGet = nil
        --self:refreshGoodsGrid(false)
        self._bagGridList:refreshView()
        self.mGoodsGridGet:hide()
        self:runInheritCancelReadyAnimtion(false)
        self:refreshInheritGrid()
        self.mInheritData = {} -- 继承后的结果展示数据
        self.mIsRunningInherit = false -- 是否有继承完毕没有选择的替换
    end
    self:refreshGoodsGridAnimation()
end

--刷新改造材料
function RemouldLayer:refreshInheritGrid(isHideAllProperty)
    self.tempAttrMode:hide()
    self.tempAttrMode:centerLeft(-winSize.width)
    self.selectMode:show()
    self.selectMode:center()
    if self.mGoodsDataGet == nil or self.mGoodsDataChange == nil then
        for i = 1,#self.mPropertyBtnList do
            local item = self.mPropertyBtnList[i]
            local txtProperty = item.itemModel.attRemouldDes
            local picRemouldMark = item.itemModel.attBuildIndicator
            txtProperty:setVisible(false)
            picRemouldMark:setVisible(false)
            self.mPropertyBtnList[i]:disable()
        end
        self:updateArrBtnSelected(0, isHideAllProperty)
        self:updateBtnState()
        self:updateInheritBtnState()
        return
    end

    self.mTxtEquipName:setText(UI.TEXT_1212027)
    if self.mIsRunningInherit then
        self.tempAttrMode:show()
        self.tempAttrMode:center()
        self.selectMode:hide()
        self.selectMode:centerLeft(-winSize.width)
        local attrList = self.mInheritData
        --local attrList =  self.mGoodsDataGet:getTmpRemodelAttr()
        for k, v in ipairs(self.attrPanelList) do
            local data = attrList[k]
            if data then
                --local _DetailDescription = data
                local _DetailDescription = data:getDetailDescription()
                v:getChildByName("ATTR"):setText(_DetailDescription[1].._DetailDescription[2])
            end
        end
        self:attrPanelSelect(self.attrPanelList[#self.attrPanelList]) 
    else
        --改造标识
        local remouldMark = false
        local _randomArr = self.mGoodsDataGet._randomArr
        local isHaveTransForm = false
        for k, v in ipairs(_randomArr) do
            if v.isTransform then
                isHaveTransForm = true
                break
            end
        end

        for i = 1,#self.mPropertyBtnList do
            local item = self.mPropertyBtnList[i]
            local txtProperty = item.itemModel.attRemouldDes
            local picRemouldMark = item.itemModel.attBuildIndicator
            if _randomArr[i] ~= nil then
                txtProperty:setVisible(true)
                local _DetailDescription = _randomArr[i]:getDetailDescription()
                txtProperty:setText(_DetailDescription[1].._DetailDescription[2])
                if isHaveTransForm then
                    if _randomArr[i].isTransform then 
                        picRemouldMark:setVisible(true)
                        self.mPropertyBtnList[i]:enable()

                        --设置选中状态
                        self:updateArrBtnSelected(i, isHideAllProperty)
                    else
                        picRemouldMark:setVisible(false)
                        self.mPropertyBtnList[i]:disable()
                    end
                else
                    self:updateArrBtnSelected(0, isHideAllProperty)
                    picRemouldMark:setVisible(false) 
                    self.mPropertyBtnList[i]:enable()
                end
            else
                txtProperty:setVisible(false)
                picRemouldMark:setVisible(false)
                self.mPropertyBtnList[i]:disable()
            end
        end
    end
    self:updateBtnState()
    self:updateInheritBtnState()
end

function RemouldLayer:runInheritReadyAnimtion(isDragOut, isChange)
    if isDragOut ~= nil and isDragOut == true then
        self.fireAnimation:setAnimation("putin3", false)
        self.fireAnimation:addAnimation("ready2", true)
    else
        self.fireAnimation:setAnimation("ready1", false)
        self.fireAnimation:addAnimation("ready2", true)
        --self.remouldSpine:setAnimation("ready1", false)
        self.fireAnimation2:setAnimation("ready1", false)

        if isChange then
            self.remouldSpineChange:setAnimation("ready1", false)
        else
            self.remouldSpineGet:setAnimation("ready1", false)
        end
    end
end

function RemouldLayer:runInheritCancelReadyAnimtion(isChange, cancelAll)
    self.fireAnimation:setAnimation("ready3", false)
    self.fireAnimation2:setAnimation("ready3", false)
    --self.remouldSpine:setAnimation("ready3", false)

    if isChange then
        self.remouldSpineChange:setAnimation("ready3", false)
    else
        self.remouldSpineGet:setAnimation("ready3", false)
    end
end

function RemouldLayer:runInheritPutAnimtion(isChange)
    self.fireAnimation:setAnimation("putin1", false)
    self.fireAnimation:addAnimation("putin2", true)
    self.fireAnimation2:setAnimation("putin1", false)
    --self.remouldSpine:setAnimation("putin1", false)

    if isChange then
        self.remouldSpineChange:setAnimation("putin1", false)
    else
        self.remouldSpineGet:setAnimation("putin1", false)
    end
end

function RemouldLayer:refreshGoodsGridAnimation()
    if (not self.mGoodsDataGet) and (not self.mGoodsDataChange) then
        -- 请放入装备
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110429))
        self.mTxtEquipName:setText(UI.TEXT_1300000)
    elseif (not self.mGoodsDataGet) and (self.mGoodsDataChange) then
        -- 请放入继承装备
        GameManager:showNPCInfomation(self.spriteID, UI.TEXT_226605)
        self:runInheritCancelReadyAnimtion(false)
        self.mTxtEquipName:setText(UI.TEXT_226605)
    elseif (self.mGoodsDataGet) and (not self.mGoodsDataChange) then
        -- 请放入改造装备
        GameManager:showNPCInfomation(self.spriteID, UI.TEXT_226604)
        self:runInheritCancelReadyAnimtion(true)
        self.mTxtEquipName:setText(UI.TEXT_226604)
    else
        -- 请选择属性
        GameManager:showNPCInfomation(self.spriteID, UI.TEXT_226610)
        self.mTxtEquipName:setText(UI.TEXT_226610)
    end
end

function RemouldLayer:refreshAllStatus()
    -- 刷新所有状态
    self.fireAnimation:setAnimation("begin", false)
    self.fireAnimation2:setAnimation("begin", false)
    self.remouldSpine:setAnimation("begin", false)
    self.remouldSpineGet:setAnimation("begin", false)
    self.remouldSpineChange:setAnimation("begin", false)

    -- 改造格子清空
    if self.mGoodsData ~= nil then
        self.mGoodsData._changeNum = 0
        self.mGoodsData = nil
    end

    if self.mGoodsDataChange ~= nil then
        self.mGoodsDataChange._changeNum = 0
        self.mGoodsDataChange = nil
    end

    if self.mGoodsDataGet ~= nil then
        self.mGoodsDataGet._changeNum = 0
        self.mGoodsDataGet = nil
    end

    self.mGoodsGrid:hide()
    self.mGoodsGridChange:hide()
    self.mGoodsGridGet:hide()

    self.mCloseLayer = nil
    self.mIsRunningInherit = false -- 是否有继承完毕没有选择的替换
    self.mInheritData = {} -- 继承后的结果展示数据
    
    self._bagGridList:refreshView()

    -- 选择格子清空
    for i = 1,#self.mPropertyBtnList do
        local item = self.mPropertyBtnList[i]
        local txtProperty = item.itemModel.attRemouldDes
        local picRemouldMark = item.itemModel.attBuildIndicator
        txtProperty:setVisible(false)
        picRemouldMark:setVisible(false)
        self.mPropertyBtnList[i]:disable()
    end

    self.mCanInherit = true
    self.mCanRemould = true

    self:updateBtnState()
    self:updateInheritBtnState()
    self:refreshInheritGrid()
    self:refreshGoodsGridAnimation()

    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110429))
end

function RemouldLayer:inheritFireAnimationCallback(event, obj)
    if event.animation == "trigger2" then
        self.mCanInherit = true
        self._bagGridList:updateCanDrag(true)
        self:refreshInheritGrid()
    end
end

function RemouldLayer:onConfireInherit()
    if self.mCanInherit == false or self.mGoodsDataChange == nil or self.mGoodsDataGet == nil then
        return
    end

    if self.mIsRunningInherit then
        -- 点击取消按钮
        self.mIsRunningInherit = false
        self:refreshInheritGrid()
        self.mCanInherit = true
    else
        -- 点击继承按钮
        if self.mSelectArrIndex == 0 then
            --这里需要飘字未选择属性
            UI.ScrollBar:createByText(UI.TEXT_110204)
            return
        end

        local diamondNum = self:getDiamondCostInherit()
        if not Avalon.MathUtil:checkDiamonEnough(diamondNum, GameDataManager:getInstance():getDiamond()) then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end

        if self.mGoodsDataChange:getEntityID() == self.mGoodsDataGet:getEntityID() then
            --同一个装备不能自己继承自己
            UI.ScrollBar:createByText(UI.TEXT_226602)
            return
        end


        self.mIsRunningInherit = true
        local _randomArr = self.mGoodsDataGet._randomArr
        local data = {}
        data.leftData = {remodelEquipInstID = self.mGoodsDataChange:getEntityID(), GoodsData = self.mGoodsDataChange}
        data.rightData = {remodelEquipInstID = self.mGoodsDataGet:getEntityID(), GoodsData = self.mGoodsDataGet}
        data.inheritType = {inheritAttrType = _randomArr[self.mSelectArrIndex].attrType}
        Net.NetNPCSystem:sendRemodelInherit(data, self.spriteID)

        -- 继承屏蔽连点
        self._bagGridList:updateCanDrag(false)
        self:runSuccessAnimtion()
        self.mCanInherit = false
    end
end

function RemouldLayer:onContiueInherit()
    if self.mIsRunningInherit then
        local data = {}
        data.equipInstanceID = self.mGoodsDataGet:getEntityID()
        data.GoodsData = self.mGoodsDataGet

        Net.NetNPCSystem:sendRemodelInheritReplace(data, self.spriteID)
    end
end

--刷新改造按钮
function RemouldLayer:updateInheritBtnState()
    if self.mGoodsDataChange == nil or self.mGoodsDataGet == nil or (self.mCanInherit == false) then--or self.mSelectArrIndex == 0 then
        self.mBtnConfireRemould:disable()
        self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_182_201_201)
        self.mTxtRemould:setFontColor(UI.FONT_COLOR_182_201_201)
        self.mBtnReplace:hide()
        self.mBtnContiue:hide()
        self.mBtnReplace:disable()
        self.mBtnContiue:disable()
        self.contiueStr:hide()
    else
        if self.mIsRunningInherit then
            self.mBtnReplace:show()
            self.mBtnContiue:show()
            self.mBtnReplace:enable()
            self.mBtnContiue:enable()
            --self.contiueStr:show()
            self.contiueStr:hide()
            self.mBtnConfireRemould:hide()
        else
            self.mBtnReplace:hide()
            self.mBtnContiue:hide()
            self.mBtnReplace:disable()
            self.mBtnContiue:disable()
            self.contiueStr:hide()
            self.mBtnConfireRemould:show()
            self.mBtnConfireRemould:enable()
            self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_220_182_80)
            self.mTxtRemould:setFontColor(UI.FONT_COLOR_220_182_80)
        end
    end
    self:updateInheritDiamondNum()
end

--刷新改造消耗水晶
function RemouldLayer:updateInheritDiamondNum()
    if self.mGoodsDataChange == nil or self.mGoodsDataGet == nil or (self.mCanInherit == false) then
        self.makeEquipModel.titleStr:setText(UI.TEXT_1300000)
        self.makeEquipModel.executeButtonLabel:setFontColor(UI.FONT_COLOR_182_201_201)
        self.makeEquipModel.executeButtonPrice:setVisible(false)
        self.makeEquipModel.executeButtonIcon:setVisible(false)
        self.makeEquipModel.executeButtonLabel:center()
        return
    end

    if not self.mIsRunningInherit then
        local diamondNum = self:getDiamondCostInherit()
        self.mTxtDiamondNum:setText(tostring(diamondNum))

        if not Avalon.MathUtil:checkDiamonEnough(diamondNum, GameDataManager:getInstance():getDiamond()) then
            self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            self.mTxtRemould:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            if self.mCanInherit == false then--or self.mSelectArrIndex == 0 then
                self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_182_201_201)
                self.mTxtRemould:setFontColor(UI.FONT_COLOR_182_201_201)
            else
                self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_220_182_80)
                self.mTxtRemould:setFontColor(UI.FONT_COLOR_220_182_80)
            end
        end
        self.makeEquipModel.executeButtonLabel:setText(UI.TEXT_226609)
        self.makeEquipModel.executeButtonPrice:setVisible(true)
        self.makeEquipModel.executeButtonIcon:setVisible(true)
        AvalonUtil.updateIconStringLayout(self.makeEquipModel.priceLayer)
        self.makeEquipModel.executeButtonLabel:centerLeft(75 - self.makeEquipModel.executeButtonLabel:getContentSize().width / 2)
        self.makeEquipModel.priceLayer:centerRight(75 - self.makeEquipModel.priceLayer:getContentSize().width / 2)
    else
        local diamondNum = self:getDiamondCostInherit()

        self.makeEquipModel.executeButtonRepPrice:setText(UI.TEXT_1212211)
        self.makeEquipModel.executeButtonRepPrice:center(0,0)

        local diamondIcon = self.makeEquipModel.contiuePriceLayer:getChildByName("executeButtonIcon")
        diamondIcon:setVisible(false)

        if not Avalon.MathUtil:checkDiamonEnough(diamondNum, GameDataManager:getInstance():getDiamond()) then
            self.makeEquipModel.executeButtonRepPrice:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            self.makeEquipModel.executeButtonRepPrice:setFontColor(UI.FONT_COLOR_50_50_44)
        end
        AvalonUtil.updateIconStringLayout(self.makeEquipModel.contiuePriceLayer)
    end
end

function RemouldLayer:inheritSuccessCallBack(data)
    self.mIsRunningInherit = true -- 是否有继承完毕没有选择的替换
    --self.mCanInherit = true

    local showArrList = self.mGoodsDataGet:getRemodelAttr()
    local netAttr = data.attr
    local oneEquipment = self.mGoodsDataGet:createEquipmentAttr(netAttr)

    self.mInheritData = {showArrList[1], oneEquipment}
    -- self.mInheritData = {{"\229\133\137\233\152\178\229\190\161", "8", true, 68},
    --                       {"\231\148\159\229\145\189\229\128\188", "88", true, 51}}
end

function RemouldLayer:inheritReplaceSuccessCallBack(data)
    if self.mGoodsDataGet:getEntityID() == data.equipInstanceID then
        self.mGoodsDataGet:replaceRemodelInheritAttr(self.mInheritData[2], data.inheritAttrType)
        self.mIsRunningInherit = false -- 是否有继承完毕没有选择的替换
        self:refreshInheritGrid()
        self.mCanInherit = true
        return
    end
    print("inheritReplaceSuccessCallBack  error")
end

function RemouldLayer:getDiamondCostInherit()
    local configConsume = ConfigManager:getGeneralForKey("inheritConsume")
    --local inheritAttributeRange = ConfigManager:getGeneralForKey("inheritAttributeRange")
    local splitConsume = string.split(configConsume,";")

    local goodsGetLv = self.mGoodsDataGet:getWearLV()
    local goodsChangeLv = self.mGoodsDataChange:getWearLV()

    local diamondNum = 0
    if goodsGetLv < goodsChangeLv then
        local config = string.split(splitConsume[1],",")
        diamondNum = tonumber(config[2])
    else
        local config = string.split(splitConsume[2],",")
        local config2 = string.split(splitConsume[1],",")
        diamondNum = tonumber(config2[2]) + tonumber(config[2]) * (goodsGetLv - goodsChangeLv)
    end

    return diamondNum
end