------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/23
--desc	: /Users/yhj/Project/CaveOnline/trunk/client/src/app/modules/starpray/StarPrayBagLayer.lua
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local StarPrayBagLayer = class("StarPrayBagLayer", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 450
local COM_HEIGHT = 534

function StarPrayBagLayer:ctor(bagData,target, bagDragBeganCallback, bagDragMovedCallback, bagDragEndedCallback,height)
    StarPrayBagLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.bagDragBeganCallback = bagDragBeganCallback
    self.bagDragEndedCallback = bagDragEndedCallback
    self.bagDragMovedCallback = bagDragMovedCallback
    self._data = bagData
    self._target = target
    self.bagHeight = height or 426
end    
function StarPrayBagLayer:dtor()
    StarPrayBagLayer.super.dtor(self)
         -- 更新装备对比区域数据
    if(not tolua.isnull(self._infoArea)) then
        self._infoArea:close()
        self._infoArea = nil
    end
end




function StarPrayBagLayer:resetGoodsData()
    for k,v in pairs(self._data.haveEquipmentArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveItemArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveMaterialArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveGemStoneArr) do
        v._changeNum = 0
        v.canUseState = true
    end
end


function StarPrayBagLayer:createBag()
    local bagList = UI.GoodsList:create(5)
    bagList:init(self._data, self.bagHeight, 0)
    bagList:hideBGImageCover()
    -- bagList:setPos(390, 40)
    bagList:setCallbackForGridClick(self, self.bagClickCallback)
    bagList:setCallbackForGridDragBegan(self._target, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self._target, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self._target, self.bagDragEndedCallback)
    -- bagList:setCallbackForGridDoubleClick(self, self.bagCellDoubleClickCallback)
    self._bagGridList = bagList
    self:addChild(bagList)
end
-- 装备详情的touch事件的处理
local function onInfoAreaTouchHandler(self,obj,touchPosition)
    if obj and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    -- 更新装备对比区域数据
    if(not tolua.isnull(self._infoArea)) then
        self._infoArea:close()
        self._infoArea = nil
    end

    -- if (not tolua.isnull(self._selectedBagGrid)) then
    --     self._selectedBagGrid:hideSelect()
    --     self._selectedBagGrid = nil
    -- end
end

function StarPrayBagLayer:bagClickCallback(bagGrid)
    local goodsData = nil
    if (bagGrid) then
        goodsData = bagGrid:getData()
        if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then
            local gemInfoArea = UI.StarPrayInfoArea:create()
            gemInfoArea:init(goodsData)
            self._infoArea = gemInfoArea
        end 
        if goodsData:getIsNew() then
            -- 如果是新物品，发送消息
            GameManager:bagClickGoodsHandler(goodsData)
        end
                
        if self._infoArea then
            local worldPos = bagGrid:convertToWorldSpace(cc.p(0,0))
            if worldPos.x < winSize.width/2 then
                self._infoArea:centerLeft(worldPos.x + bagGrid:getSize() + 20)
            else
                self._infoArea:centerLeft(worldPos.x - bagGrid:getSize() - 20)
            end
            self._infoArea:centerRight(585)
            UI.UIManager:addToRootNode(self._infoArea,UI_ZORDER.EQUIPMENTINFO)
            self._infoArea:setGoodsGrid(bagGrid)
            
            self._infoArea:setVisible(true)
            self._infoArea:updateView(goodsData)
            self._infoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onInfoAreaTouchHandler)
        end
    end
end


function StarPrayBagLayer:onInitView()
    self:createBag()
end

return StarPrayBagLayer












