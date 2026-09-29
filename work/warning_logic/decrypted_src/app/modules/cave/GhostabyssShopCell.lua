------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/10/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local GhostabyssShopCell = class("GhostabyssShopCell", UI.HWBtnComponent)
UI.GhostabyssShopCell = GhostabyssShopCell

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 384
local COM_HEIGHT = 80

function GhostabyssShopCell:ctor()
    GhostabyssShopCell.super.ctor(
    	self,
    	UI.Type.NORMAL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
end

function GhostabyssShopCell:init(data, alsoNeedPoint, ...)
    self.data = data
    self.alsoNeedPoint = alsoNeedPoint
    GhostabyssShopCell.super.init(self, ...)
end

function GhostabyssShopCell:dtor()
    GhostabyssShopCell.super.dtor(self)
    reload_script_file("app.modules.cave.GhostabyssShopCell")
end

function GhostabyssShopCell:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_ghostabyss_list_03.png")
    bg:center()
    self:addChild(bg)
    self.bg = bg 

    -- 图标
    local goodGrid = UI.GoodsGrid:create()
    goodGrid:init(nil)
    goodGrid:centerLeft(15)
    goodGrid:hideFlagIcon()
    goodGrid:hideCountLabel()
    goodGrid:showInfoArea(true, false)
    goodGrid:setName("cellView")
    goodGrid:setData(self.data)
    goodGrid:updateView()
    goodGrid:setTouchClipNode(self.touchClipNode)
    goodGrid:setSwallowTouches(false)
    bg:addChild(goodGrid)
    self.goodGrid = goodGrid

    -- 材料价值
    local priceLayout = UI.Layout:create()
    priceLayout:init()
    priceLayout:setSize(0,0)
    priceLayout:centerLeft(135)
    bg:addChild(priceLayout)

    local offset = 30
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1328013, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    titleText:centerUp(-offset)
    priceLayout:addChild(titleText)
    

    local valueText = UI.Text:create()
    valueText:init("0", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    valueText:centerLeft(titleText:getContentSize().width + 3)
    titleText:addChild(valueText)
    self.valueText = valueText


    local choiceNumText = UI.Text:create()
    choiceNumText:init("0/0", UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 220, g = 216, b = 215})
    choiceNumText:centerBottom(-offset)
    priceLayout:addChild(choiceNumText)
    self.choiceNumText = choiceNumText
    
    -- 数量选择按钮
    local reduceLayout = UI.Layout:create()
    reduceLayout:init()
    reduceLayout:setSize(70,70)
    reduceLayout:centerRight(127-reduceLayout:getContentSize().width/2)
    bg:addChild(reduceLayout)

    reduceLayout:setTouchEnable(true)
    reduceLayout:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        reduceLayout:stopAllActions()
        reduceLayout:runAction(cc.ScaleTo:create(0.0001, 1.2))
    end)
    reduceLayout:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        reduceLayout:stopAllActions()
        reduceLayout:runAction(cc.ScaleTo:create(0.0001, 1))
    end)
    reduceLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if(self.data and self.data.choiceNum > 0) then 
            local alsoNeedNum = self:getAlsoNeedNum()
            if(self.data.choiceNum > 1) then
                UI.TipsLayer:onNumChoice(function(number)   -- 确认回调
                    if not tolua.isnull(self) then
                        self.data.choiceNum = number
                        if(self.data.choiceNum < 0) then 
                            self.data.choiceNum = 0
                        end
                        mvc.send(mvc.events.RefeshGhostabyssShop)
                    end
                end, nil, 0, math.min(self.data.choiceNum + alsoNeedNum, self.data:getNum()), self.data.choiceNum, UI.TEXT_1328021)
            else
                self.data.choiceNum = self.data.choiceNum - 1
                if(self.data.choiceNum < 0) then 
                    self.data.choiceNum = 0
                end
                mvc.send(mvc.events.RefeshGhostabyssShop)
                -- self:updateData(self.data)
            end
        end
    end)

    local reduceImage = UI.Image:create()
    reduceImage:init("ui_btn_add_0.png")
    reduceImage:center()
    reduceLayout:addChild(reduceImage)
    self.reduceImage = reduceImage 
    self.reduceLayout = reduceLayout


    local increaseLayout = UI.Layout:create()
    increaseLayout:init()
    increaseLayout:setSize(70,70)
    increaseLayout:centerRight(44-increaseLayout:getContentSize().width/2)
    bg:addChild(increaseLayout)
    increaseLayout:setTouchEnable(true)

    increaseLayout:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        increaseLayout:stopAllActions()
        increaseLayout:runAction(cc.ScaleTo:create(0.0001, 1.2))
    end)
    increaseLayout:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        increaseLayout:stopAllActions()
        increaseLayout:runAction(cc.ScaleTo:create(0.0001, 1))
    end)
    increaseLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if(self.data and self.data:getNum() > 0) then 
            local alsoNeedNum = self:getAlsoNeedNum()
            if(alsoNeedNum > 0) then
                if(alsoNeedNum > 1) then 
                    UI.TipsLayer:onNumChoice(function(number)   -- 确认回调
                        if not tolua.isnull(self) then
                            self.data.choiceNum = number
                            if(self.data.choiceNum < 0) then 
                                self.data.choiceNum = 0
                            end
                            mvc.send(mvc.events.RefeshGhostabyssShop)
                        end
                    end, nil, 0, math.min(self.data.choiceNum + alsoNeedNum, self.data:getNum()), self.data.choiceNum, UI.TEXT_1328021)
                else
                    self.data.choiceNum = self.data.choiceNum + 1
                    if(self.data.choiceNum > self.data:getNum()) then 
                        self.data.choiceNum = self.data:getNum()
                    end
                    mvc.send(mvc.events.RefeshGhostabyssShop)
                    self:updateData(self.data, self.alsoNeedPoint)
                end
            end
        end
    end)

    local increaseImage = UI.Image:create()
    increaseImage:init("ui_ghostabyss_btn_reduce_01.png")
    increaseImage:center()
    increaseLayout:addChild(increaseImage)
    self.increaseImage = increaseImage 
    self.increaseLayout = increaseLayout

    self:updateData(self.data, self.alsoNeedPoint)
end

function GhostabyssShopCell:onUpdateView()
    
end


function GhostabyssShopCell:updateData(data, alsoNeedPoint)
    self.data = data
    self.alsoNeedPoint = alsoNeedPoint
    
    if (data) then
        self.valueText:setText(data.givePoint)
        
        self.choiceNumText:setText(data.choiceNum .. "/".. data:getNum())
        self.goodGrid:setData(self.data)
        
        if(data:getNum() > 0) then
            if(data.choiceNum < data:getNum() and self.alsoNeedPoint > 0) then
                self.increaseImage:setSpriteName("ui_btn_add_1.png")
            else
                self.increaseImage:setSpriteName("ui_btn_add_0.png")
            end

            if(data.choiceNum > 0) then
                self.reduceImage:setSpriteName("ui_ghostabyss_btn_reduce_02.png")
            else
                self.reduceImage:setSpriteName("ui_ghostabyss_btn_reduce_01.png")
            end
            self:setOpacity(255)
        else
            self:setOpacity(128)
            self.increaseImage:setSpriteName("ui_btn_add_0.png")
            self.reduceImage:setSpriteName("ui_ghostabyss_btn_reduce_01.png")
        end
    end

    function GhostabyssShopCell:getAlsoNeedNum()
        if(self.alsoNeedPoint > 0 and self.data) then 

            return math.ceil(self.alsoNeedPoint / self.data.givePoint)
        end

        return 0
    end
end