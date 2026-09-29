-- PetMainTabCell.lua
-- Author:lzm

UI = UI or {}

local PetMainTabCell = class("PetMainTabCell", UI.TableViewCell)
UI.PetMainTabCell = PetMainTabCell

local BTN_CELL_W = 109
local BTN_CELL_H = 68


require "app.modules.pet.PetAttrView"
require "app.modules.pet.PetTrainView"
require "app.modules.pet.PetComposeView"
require "app.modules.pet.PetRefineView"
require "app.modules.pet.PetHandbookView"
require "app.modules.pet.PetLookAttrView"
require "app.modules.pet.PetInheritView"
require "app.modules.pet.PetSiteView"
require "app.modules.pet.PetSkillLearnLayer"
require "app.modules.pet.PetAscendingStarView"

function PetMainTabCell:ctor()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.selectPetUpdate)
end

function PetMainTabCell:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.selectPetUpdate)
    reload_script_file_mvc("app.modules.pet.PetAttrView")
end

function PetMainTabCell:onEnter()
    PetMainTabCell.super.onEnter(self);
end

function PetMainTabCell:onExit()
    PetMainTabCell.super.onExit(self);
end

-- isOther用来判断是否是别人的宠物
-- 如果为true 第二个参数传的是别人的宠物数据，如果为false 第二个参数传的是自己的宠物ID
function PetMainTabCell:init(data, petID, isOther)
    self._data = data;
    self.isOther = isOther or false
    self.curPetID = petID
    self:onInitView();
end

function PetMainTabCell:selectPetUpdate(petListIdx)
    if petListIdx and petListIdx > 0 then
        local petData = MasterDataManager:getBagPets()[petListIdx]
        self.curPetID = petData:getId()
    end
end

function PetMainTabCell:onInitView()
    self._cellLayout = cc.Layer:create();
    self._cellLayout:setPosition(cc.p(0,0));
    self._cellLayout:setContentSize(cc.size(BTN_CELL_W+10, BTN_CELL_H));
    self:addChild(self._cellLayout);

    self._bg = UI.Image:create()
    self._bg:init("ui_btn_gray2_0.png")
    self._bg:centerLeft(0)
    self._cellLayout:addChild(self._bg)

    local titleTxt = UI.Text:create()
    titleTxt:init(self._data.name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    titleTxt:setWidth(84)
    titleTxt:setTextCenter()
    titleTxt:autoAdapt()
    titleTxt:center()
    self.titleTxt = titleTxt
    self._bg:addChild(titleTxt)

    local redPoint = AvalonUtil.createRedPoint(self._bg, 2, 2)
    self.redPoint = redPoint
    self:updateRed(self._data)

    self:reloadData()
end

function PetMainTabCell:reloadData()
    self:updateCellShow()
    self:updateRedShow()
    if self._data.select then
        self:showUI()
    else
        self:hideUI()
    end
end

function PetMainTabCell:updateCellShow()
    if self._data.select then
        self.titleTxt:setFontColor(UI.FONT_COLOR_218_211_154)
        self._bg:setSpriteName("ui_btn_gray2_1.png")
    else
        self.titleTxt:setFontColor(UI.FONT_COLOR_41_41_45)
        self._bg:setSpriteName("ui_btn_gray2_0.png")
    end
end

function PetMainTabCell:updateCellHightLihtShow()
    self.titleTxt:setFontColor(UI.FONT_COLOR_218_211_154)
    self._bg:setSpriteName("ui_btn_gray2_1.png")
end

function PetMainTabCell:updateCellUnHightLihtShow()
    if not self._data.select then
        self.titleTxt:setFontColor(UI.FONT_COLOR_41_41_45)
        self._bg:setSpriteName("ui_btn_gray2_0.png")
    end
end

function PetMainTabCell:updateRedShow()
    self:updateRed(self._data)
end

function PetMainTabCell:updateRed(data)
    self.redPoint:hide()
    -- local stat2 = mvc.sevenDaysModel:checkCanGetFinalReward(goalID)
    -- if stat1 or stat2 then
    --     self.redPoint:show()
    -- else
    --     self.redPoint:hide()
    -- end
end

function PetMainTabCell:hasShowPetEquipment()
    if self._data ~= nil and self._data.type == "attr" and not (self._data.look == true) then 
        local uiPanel = self._data.rootLayer:getChildByName(self._data.ui)
        if uiPanel and uiPanel.hasShowPetEquipment then
            return uiPanel:hasShowPetEquipment()
        end
    end

    return false
end

function PetMainTabCell:showUI()
    local uiPanel = self._data.rootLayer:getChildByName(self._data.ui)
    if not uiPanel then
        if self._data.type == "attr" then
            if self._data.look == true then
                uiPanel = UI.PetLookAttrView:create()
            else
                uiPanel = UI.PetAttrView:create()
                uiPanel:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
                uiPanel:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
                uiPanel:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

                Avalon.MessageCenter:notice(GameMessage.MC_UI_STOP_ONE_KEY_REBORN)
            end
        elseif self._data.type == "train" then
            uiPanel = UI.PetTrainView:create()
        elseif self._data.type == "compose" then
            -- uiPanel = UI.PetComposeView:create()
            uiPanel = UI.PetAscendingStarView:create()
        elseif self._data.type == "refine" then
            uiPanel = UI.PetRefineView:create()
        elseif self._data.type == "handbook" then
            uiPanel = UI.PetHandbookView:create()
        elseif self._data.type == "inherit" then
            uiPanel = UI.PetInheritView:create()
        elseif self._data.type == "Corral" then
            uiPanel = UI.PetSiteView:create()
        elseif self._data.type == "skill" then
            uiPanel = UI.PetSkillLearnLayer:create()
        end

        uiPanel:init(self.curPetID, self._data.inputInnerTabIdx, false, 195)
        uiPanel:rightBottom(20, 20)
        uiPanel:setName(self._data.ui)
        self._data.rootLayer:addChild(uiPanel, 10)
    end
    printInfo(" uiPanel is ====== " .. self._data.type)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SORT_LIST)

    if not uiPanel then
        return
    end
    
    -- 为了刷新掉选中的宠物，需要重置一下
    if self._data.type == "refine" then
        uiPanel:updateToShow()
    end
    uiPanel:setVisible(true)

    if self._data.inputInnerTabIdx then
        self._data.inputInnerTabIdx = nil
    end

end

function PetMainTabCell:hideUI()
    local uiPanel = self._data.rootLayer:getChildByName(self._data.ui)
    if uiPanel then
        -- uiPanel:setVisible(false)
        self._data.rootLayer:removeChildByName(self._data.ui)
    end
end

function PetMainTabCell:changeInSideStatus(inSide)
    local uiPanel = self._data.rootLayer:getChildByName(self._data.ui)
    if(uiPanel) then 
        uiPanel:changeInSideStatus(inSide)
    end
end

function PetMainTabCell:bagDragBeganCallback(goodsGrid, touchPosition)
    if (self._targetForDragBegan and self._functionForDragBegan) then
        self._functionForDragBegan(self._targetForDragBegan, goodsGrid, touchPosition)
    end
end

function PetMainTabCell:bagDragMovedCallback(goodsGrid, touchPosition)
    -- print("BagGoodsPanel:bagDragMovedCallback")
    if (self._targetForDragMoved and self._functionForDragMoved) then
        self._functionForDragMoved(self._targetForDragMoved, goodsGrid, touchPosition)
    end
end

function PetMainTabCell:bagDragEndedCallback(goodsGrid, touchPosition)
    -- print("BagGoodsPanel:bagDragEndedCallback")
    if (self._targetForDragEnded and self._functionForDragEnded) then 
        Avalon.AudioManager:playSound("1505")
        self._functionForDragEnded(self._targetForDragEnded, goodsGrid, touchPosition)
    end
end

-- 添加拖拽格子开始的处理回调函数
function PetMainTabCell:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function PetMainTabCell:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function PetMainTabCell:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end
