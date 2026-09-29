------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/02/02
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetAscendingStarView = class("PetAscendingStarView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

UI = UI or {}

UI.PetAscendingStarView = PetAscendingStarView

local COM_WIDTH = 425
local COM_HEIGHT = 500

function PetAscendingStarView:ctor()
    PetAscendingStarView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PetAscendingStarView:init( ... )
    self.innerTabIdx = 1
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetAscendingStarView.super.init(self, ... )
    
end

function PetAscendingStarView:dtor()
    PetAscendingStarView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetAscendingStarView")
end


function PetAscendingStarView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 顶部按钮条
    -- 背景图片
    local titleBG  = UI.Image:create();
    titleBG:init("ui_pets_cultivate_btn_0.png");
    titleBG:centerUp(10);
    contentLayout:addChild(titleBG, 1);

    local select1  = UI.Image:create();
    select1:init("ui_pets_cultivate_btn_1.png");
    select1:leftUp(1, 1);
    titleBG:addChild(select1);
    select1:hide()
    self.tabSelect1 = select1

    local select2  = UI.Image:create();
    select2:init("ui_pets_cultivate_btn_1.png");
    select2:leftUp(138, 1);
    titleBG:addChild(select2);
    select2:hide()
    self.tabSelect2 = select2

    local select3  = UI.Image:create();
    select3:init("ui_pets_cultivate_btn_1.png");
    select3:leftUp(275, 1);
    titleBG:addChild(select3);
    select3:hide()
    self.tabSelect3 = select3

    local touchLayer1 = UI.Layout:create();
    touchLayer1:init()
    touchLayer1:setSize(136, 38)
    touchLayer1:leftUp(0, 0)
    touchLayer1:setTouchEnable(true)
    touchLayer1:setSwallowTouches(true)
    touchLayer1:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.curTabIndex == 1 then
            return
        end

        self:updateTabList(1)
    end)
    titleBG:addChild(touchLayer1)

    local touchLayer2 = UI.Layout:create();
    touchLayer2:init()
    touchLayer2:setSize(136, 38)
    touchLayer2:leftUp(138, 0)
    touchLayer2:setTouchEnable(true)
    touchLayer2:setSwallowTouches(true)
    touchLayer2:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.curTabIndex == 2 then
            return
        end

        -- self.stopOneKeyReborn = true

        self:updateTabList(2)
    end)
    titleBG:addChild(touchLayer2)

    local touchLayer3 = UI.Layout:create();
    touchLayer3:init()
    touchLayer3:setSize(136, 38)
    touchLayer3:leftUp(276, 0)
    touchLayer3:setTouchEnable(true)
    touchLayer3:setSwallowTouches(true)
    touchLayer3:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.curTabIndex == 3 then
            return
        end

        -- self.stopOneKeyReborn = true

        self:updateTabList(3)
    end)
    titleBG:addChild(touchLayer3)

    local tabTxt1 = UI.Text:create()
    tabTxt1:init(UI.TEXT_1213604, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w1 = tabTxt1:getContentSize().width
    tabTxt1:setWidth(138)
    tabTxt1:setTextCenter()
    tabTxt1:autoAdapt()
    if w1 > 138 then
        tabTxt1:leftUp(0, 0)
    else
        tabTxt1:leftUp(0, 8)
    end
    tabTxt1:setLineSpacing(-6)
    titleBG:addChild(tabTxt1)

    local tabTxt2 = UI.Text:create()
    tabTxt2:init(UI.TEXT_1213605, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w2 = tabTxt2:getContentSize().width
    tabTxt2:setWidth(138)
    tabTxt2:setTextCenter()
    tabTxt2:autoAdapt()
    if w2 > 138 then
        tabTxt2:leftUp(138, 0)
    else
        tabTxt2:leftUp(138, 8)
    end
    tabTxt2:setLineSpacing(-6)
    titleBG:addChild(tabTxt2)

    local tabTxt3 = UI.Text:create()
    tabTxt3:init(UI.TEXT_1314058, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w3 = tabTxt3:getContentSize().width
    tabTxt3:setWidth(138)
    tabTxt3:setTextCenter()
    tabTxt3:autoAdapt()
    if w3 > 138 then
        tabTxt3:leftUp(274, 0)
    else
        tabTxt3:leftUp(274, 8)
    end
    tabTxt3:setLineSpacing(-6)
    titleBG:addChild(tabTxt3)

    self:makeTabList()
    self:updateTabList(self.innerTabIdx)

    self.innerTabIdx = nil
end


function PetAscendingStarView:bindModel()

end


function PetAscendingStarView:unbindModel()

end

function PetAscendingStarView:makeTabList()
    self.tabData = {}
    self.curTabIndex = self.innerTabIdx
    self.lastTabIndex = self.innerTabIdx

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_1213604
    tab1.select = self.innerTabIdx == 1
    tab1.showLayer = function()
        self.tabSelect1:show()
        if not self.composeLayer then
            self:showCompose()
        end
        self.composeLayer:show()
        --self.composeLayer:centerBottom(0)
    end
    tab1.hideLayer = function()
        self.tabSelect1:hide()
        if self.composeLayer then
            self.composeLayer:hide()
            --self.composeLayer:centerBottom(2000)
        end
    end

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_1213605
    tab2.select = self.innerTabIdx == 2
    tab2.showLayer = function()
        self.tabSelect2:show()
        if not self.refineLayer then
            self:showRefine()
        end
        self.refineLayer:show()
        --self.refineLayer:centerBottom(0)
    end
    tab2.hideLayer = function()
        self.tabSelect2:hide()
        if self.refineLayer then
            self.refineLayer:hide()
            --self.refineLayer:centerBottom(2000)
        end
    end

    local tab3 = {}
    tab3.idx = 3
    tab3.name = UI.TEXT_1314058
    tab3.select = self.innerTabIdx == 3
    tab3.showLayer = function()
        self.tabSelect3:show()
        if not self.inheritLayer then
            self:showInherit()
        end
        self.inheritLayer:show()
        -- self.inheritLayer:centerBottom(0)
    end
    tab3.hideLayer = function()
        self.tabSelect3:hide()
        if self.inheritLayer then
            self.inheritLayer:hide()
            -- self.inheritLayer:centerBottom(2000)
        end
    end

    table.insert(self.tabData, tab1)
    table.insert(self.tabData, tab2)
    table.insert(self.tabData, tab3)
end

function PetAscendingStarView:updateTabList(idx)
    if idx then
        self.curTabIndex = idx

        if self.tabData[self.lastTabIndex] then
            self.tabData[self.lastTabIndex].select = false
        end

        self.tabData[self.curTabIndex].select = true
        self.lastTabIndex = self.curTabIndex
    end

    for _, v in ipairs(self.tabData) do
        if v.select then
            v.showLayer()
        else
            v.hideLayer()
        end
    end
end


-- 合成
function PetAscendingStarView:showCompose()
    if not self.composeLayer then
        local composeLayer = UI.Layout:create();
        composeLayer:init()
        composeLayer:setSize(386, 436)
        composeLayer:centerBottom(0)
        -- composeLayer:enableDebugDraw()
        self.contentLayout:addChild(composeLayer, 2)
        self.composeLayer = composeLayer
    end

    -- 合成
    local composeView = self.composeLayer:getChildByName("composeView")
    if not composeView then
        composeView = UI.PetComposeView:create()
        composeView:init() 
        composeView:leftUp(-20, 0)
        composeView:setName("composeView")
        self.composeLayer:addChild(composeView, 10);
    else
        composeView:updateToShow()
    end
end

-- 炼化
function PetAscendingStarView:showRefine()
    if not self.refineLayer then
        local refineLayer = UI.Layout:create();
        refineLayer:init()
        refineLayer:setSize(386, 436)
        refineLayer:centerBottom(0)
        -- refineLayer:enableDebugDraw()
        self.contentLayout:addChild(refineLayer, 2)
        self.refineLayer = refineLayer
    end

    -- 炼化
    local refineView = self.refineLayer:getChildByName("refineView")
    if not refineView then
        refineView = UI.PetRefineView:create()
        refineView:init() 
        refineView:leftUp(-20, 0)
        refineView:setName("refineView")
        self.refineLayer:addChild(refineView, 10);
    else
        refineView:updateToShow()
    end
end

-- 传承
function PetAscendingStarView:showInherit()
    if not self.inheritLayer then
        local inheritLayer = UI.Layout:create();
        inheritLayer:init()
        inheritLayer:setSize(386, 436)
        inheritLayer:centerBottom(0)
        -- inheritLayer:enableDebugDraw()
        self.contentLayout:addChild(inheritLayer, 2)
        self.inheritLayer = inheritLayer
    end

    -- 传承
    local inheritView = self.inheritLayer:getChildByName("inheritView")
    if not inheritView then
        inheritView = UI.PetInheritView:create()
        inheritView:init() 
        inheritView:leftUp(-20, 0)
        inheritView:setName("inheritView")
        self.inheritLayer:addChild(inheritView, 10);
    else
        inheritView:updateToShow()
    end
end


return PetAscendingStarView












