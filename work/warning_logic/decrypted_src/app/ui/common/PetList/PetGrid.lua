--[[
    UI - 宠物背包格子
]]--

require "app.ui.Component"

UI = UI or {}

local PetGrid = class("PetGrid", UI.ListGrid)
UI.PetGrid = PetGrid
local scheduler=cc.Director:getInstance():getScheduler()

-- 背包格子的状态
UI.PetGridState = {
    USED = 1,  -- 被占用
    EMPTY = 2, -- 空格子
}
PetGridState = UI.PetGridState

-- 尺寸
local COM_WIDTH = 68
local COM_HEIGHT = 68

-- 背包资源
local RES_LIST = {
    "ui_common_information.plist",
    "ui_common_grid.plist",
    "ui_common_monsterhead.plist",
}

-- 选中的动画
local FX_ITEMLIST_ITEMSELECT_JSON =  "effect_ui_gaming_itemselect.json"
local FX_ITEMLIST_ITEMSELECT_ATLAS = "effect_ui_gaming_itemselect.atlas"

-- 星级显示的位置
local POSITION_X_COUNT = 50
local POSITION_Y_COUNT = 2
-- 等级显示的位置
local POSITION_X_LOCK = 5
local POSITION_Y_LOCK = 2

-- 子节点的z序
local ZORDER_BAG_GRID_BG = 1
local ZORDER_BAG_GRID_FRAME = 2
local ZORDER_BAG_GRID_ICON = 3
local ZORDER_BAG_GRID_FIGHT = 4
local ZORDER_BAG_GRID_ANIMATION = 5
local ZORDER_BAG_GRID_LEVEL = 6
local ZORDER_BAG_GRID_START = 7
local ZORDER_BAG_GRID_NEW_FLAG = 8
local ZORDER_BAG_GRID_CHOICE_STATUS_FLAG = 9
local ZORDER_BAG_GRID_CHOICE_IMG = 10

-- 构造函数
function PetGrid:ctor()
    PetGrid.super.ctor(self, RES_LIST, COM_WIDTH, COM_HEIGHT)

    -- 格子数据
    self._data = nil
    -- 格子索引
    self._index = 0
    -- 格子状态
    self._state = PetGridState.EMPTY
    -- 是否被选中(多选标识)
    -- self._data.petGridData._isCheck = false
    self._isIconVisible = true

    -- 背景图片
    self._bgSprite = nil
    -- 格子中的宠物
    self._iconSprite = nil
    -- 新标识
    self._newSprite = nil
    -- 稀有度
    self._rareSprite = nil
    -- 星级数量
    self._startNode = nil
    self._showStartNode = true
    -- 等级表现
    self._levelNode = nil
    self._showLevelNode = true

    -- 选中时候的动画
    self._selectItem = nil
    -- 等待勾选的框
    self._choiceStatus = nil
    -- 勾选标识图
    self._checkItem = nil
    -- 展示多选标识
    self._showChoiceStatus = false

    self._infoItem = nil
    self._showRare = false

    self._dragAnimation = nil

    self._preZorder = 1

    self.mSchedulerID = 0

end

-- 析构函数
function PetGrid:dtor()
    PetGrid.super.dtor(self)
    self._LevelText = nil
    if(not tolua.isnull(self._choiceStatus)) then 
        self._choiceStatus:removeFromParent(true)
        self._choiceStatus = nil
    end

    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
        self.mSchedulerID = 0
    end

    if (not tolua.isnull(self.dragCloneNode)) then
        self.dragCloneNode:removeFromParent()
        self.dragCloneNode = nil
    end
    reload_script_file("app.ui.common.PetList.PetGrid")
end

-- 初始化
function PetGrid:init(data)
    if (data) then
        self:setData(data)
    end

    PetGrid.super.init(self)
end

-- 设置可用
function PetGrid:setAvailable(available)
    if (available) then
        self._state = GoodsGridState.EMPTY
    else
        self._state = GoodsGridState.USED
    end
end

-- 是否可用
function PetGrid:isAvailable()
    return self._state == PetGridState.EMPTY
end

-- 是否已经被使用
function PetGrid:isUsed()
    return self._state == PetGridState.USED
end

--返回道具是否可用状态
function PetGrid:getCanUseState()
    -- 目前有即可选用
    return self._state == PetGridState.USED
end

-- 是否可以显示信息
function PetGrid:isClickShowInfo()
    return true
end

-- 设置数据
function PetGrid:setData(data)
    if (data) then
        self:reset()
        self._data = data
        self._state = data.emptySlot and PetGridState.EMPTY or PetGridState.USED
    end
end

-- 回复
function PetGrid:reset()
    self._state = GoodsGridState.EMPTY
    self._data = nil
    if self._data and self._data.petGridData and self._data.petGridData._isCheck then
        self._data.petGridData._isCheck = false
    end
    if self._checkItem and not tolua.isnull(self._checkItem) then
        self._checkItem:hide()
    end
end

-- 获取数据
function PetGrid:getData()
    return self._data
end

-- 星级显示控制
function PetGrid:showStartLabel()
    self._showStartNode = true
    if (self._startNode) then self._startNode:setVisible(true) end
end

function PetGrid:hideStartNode()
    self._showStartNode = false
    if (self._startNode) then self._startNode:setVisible(false) end
end

-- 等级显示控制
function PetGrid:showLevelNode()
    self._showLevelNode = true
    if (self._levelNode) then self._levelNode:setVisible(true) end
end

function PetGrid:hideStartLabel()
    self._showLevelNode = false
    if (self._levelNode) then self._levelNode:setVisible(false) end
end

-- 克隆
function PetGrid:createDraggedView()
    -- printInfo("--------------PetGrid:createDraggedView")
    local newPetGrid = UI.PetGrid:create()
    newPetGrid:init(self._data)
    newPetGrid:setSize(self._width, self._height)
    newPetGrid:setIndex(self._index)
    return newPetGrid
end

-- 初始化视图
function PetGrid:onInitView()
    if self._bgSprite ~= nil then
        printError("---repeat onInitView in PetGrid:onInitView()-------------")
    end
    -- 格子背景
    self._bgSprite = UI.Image:create()
    self._bgSprite:init("box_quality_box_01.png")
    self._bgSprite:center()
    self:addChild(self._bgSprite , ZORDER_BAG_GRID_BG)

    if(self._isGray) then
        self._iconSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
        self._bgSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
    end
end

-- 更新视图
function PetGrid:onUpdateView()

    self:clearSelect()

    if (self._state == PetGridState.USED) then
        local data = self._data

        -- 宠物底图
        if not self._frameSprite then
            self._frameSprite = UI.Image:create()
            self._frameSprite:init(self:getQualityBgImg())
            self._frameSprite:center()
            self:addChild(self._frameSprite , ZORDER_BAG_GRID_FRAME)
        else
            self._frameSprite:setSpriteName(self:getQualityBgImg())
            self._frameSprite:show()
        end

        -- 宠物图片
        if not self._iconSprite then
            self._iconSprite = UI.Image:create()
            self._iconSprite:init(data:getIcon())
            self._iconSprite:center()
            self:addChild(self._iconSprite , ZORDER_BAG_GRID_ICON)
        else
            self._iconSprite:setSpriteName(data:getIcon())
            self._iconSprite:show()
        end

        local petQuality = self._data:getPetQuality()
        if petQuality ~= PublicDefine.PetQualityType.Platinum then
            if self.platinumEff then
                self.platinumEff:removeFromParent(false)
                self.platinumEff = nil
            end
        end
        if not self._abovePetSprite then
            self._abovePetSprite = UI.Image:create()
            self._abovePetSprite:init(self:getAbovePetImg())
            self._abovePetSprite:center()
            self:addChild(self._abovePetSprite , ZORDER_BAG_GRID_ICON)

            -- local petQuality = self._data:getPetQuality()
            if petQuality == PublicDefine.PetQualityType.Platinum then
                local platinumEff = UI.Animation:create()
                platinumEff:init("effect_ui_common_box_quality_platinum.json", "effect_ui_common_box_quality_platinum.atlas")
                platinumEff:center()
                platinumEff:setAnimation("idle", true)
                self._abovePetSprite:addChild(platinumEff, 99)
                self.platinumEff = platinumEff
            end
        else
            self._abovePetSprite:setSpriteName(self:getAbovePetImg())
            self._abovePetSprite:show()

            if petQuality == PublicDefine.PetQualityType.Platinum then
                if not self.platinumEff then
                    if petQuality == PublicDefine.PetQualityType.Platinum then
                        local platinumEff = UI.Animation:create()
                        platinumEff:init("effect_ui_common_box_quality_platinum.json", "effect_ui_common_box_quality_platinum.atlas")
                        platinumEff:center()
                        platinumEff:setAnimation("idle", true)
                        self._abovePetSprite:addChild(platinumEff, 99)
                        self.platinumEff = platinumEff
                    end
                end
            end

            
        end
        -- 出战状态
        if data and data:isFight() then
            if self._fightBoader then
                self._fightBoader:show()
            else
                self._fightBoader = UI.Image:create()
                self._fightBoader:init("ui_pets_fight.png");
                self._fightBoader:center();
                self:addChild(self._fightBoader, ZORDER_BAG_GRID_FIGHT)
            end

            -- if self._battleAnimation then
            --     local fightPetData = MasterDataManager:getFightPetbyId(data.spriteID)
            --     print("fightPetData:_battleAnimationhave", fightPetData:getSiteId(), data.spriteID)
            --     self._battleAnimation:show()
            -- end
            if self:getChildByName("battleAnimationFight") then
                -- self._battleAnimation:show()
                self:removeChildByName("battleAnimationFight")
                self._battleAnimation = nil
            end
            -- else
            self._battleAnimation = UI.Animation:create()
            -- self._battleAnimation:init("effect_ui_town_guild_guildfuben_fighting.json", "effect_ui_town_guild_guildfuben_fighting.atlas")
            local fightPetData = RoleDataManager:getFightPetbyId(data.spriteID)--MasterDataManager:getFightPetbyId(data.spriteID)--getFightPetbyId(data.spriteID)
            if fightPetData and fightPetData:getSiteId() and fightPetData:getSiteId() ~= 0 then
                self._battleAnimation:init("effect_ui_town_guild_guildfuben_fighting01.json", "effect_ui_town_guild_guildfuben_fighting01.atlas")
            else 
                self._battleAnimation:init("effect_ui_town_guild_guildfuben_fighting.json", "effect_ui_town_guild_guildfuben_fighting.atlas")
            end
            self._battleAnimation:rightUp(22, 22)
            self._battleAnimation:setAnimation("idle", true)
            self._battleAnimation:setScaleX(0.7)
            self._battleAnimation:setScaleY(0.7)
            self._battleAnimation:setName("battleAnimationFight")
            self:addChild(self._battleAnimation, ZORDER_BAG_GRID_FIGHT)
            -- end
        else
            if self._fightBoader then
                self._fightBoader:hide()
            end

            if self._battleAnimation then
                self._battleAnimation:hide()
            end
        end

        -- 等级
        if self._levelNode and not tolua.isnull(self._levelNode) then
            self._levelNode:removeFromParent(true)
            self._levelNode = nil
        end
        self._levelNode = UI.Layout:create();
        self._levelNode:init()
        self._levelNode:setSize(50, 20)
        self:addChild(self._levelNode, ZORDER_BAG_GRID_LEVEL)

        local lvImg = UI.Image:create()
        lvImg:init("ui_home_banner_lv.png")
        lvImg:centerLeft(0)
        self._levelNode:addChild(lvImg)

        --local lvInnerLayout = AvalonUtil:getStyledNumberNode(data:getLevel())
        local lvInnerLayout = AvalonUtil:getStyledNumberNode(data:getUIShowLv())
        lvInnerLayout:centerLeft(25)
        self._levelNode:addChild(lvInnerLayout)

        self._levelNode:leftUp(-2, 4)
        self._levelNode:setScaleX(0.6)
        self._levelNode:setScaleY(0.6)

        -- 星级
        if not self._startNode then
            self._startNode = UI.Layout:create();
            self._startNode:init()
            self._startNode:setSize(50, 20)
            self._startNode:rightBottom(10, 10)
            self:addChild(self._startNode, ZORDER_BAG_GRID_START)

            local starTxt = UI.Text:create()
            starTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_230_210_190)
            starTxt:rightBottom(5, 2)
            starTxt:setName("starTxt")
            self._startNode:addChild(starTxt)

            local starImg = UI.Image:create()
            starImg:init("ui_pets_box_star.png")
            starImg:setName("starImg")
            self._startNode:addChild(starImg)
        end
        self._startNode:show()
        self._startNode:getChildByName("starTxt"):setText(tostring(data:getStarLv()))
        local txtW = self._startNode:getChildByName("starTxt"):getContentSize().width
        self._startNode:getChildByName("starImg"):rightBottom(txtW+5, 4)

        -- 是否是新物品
        -- self:showNewIcon()

    elseif (self._state == PetGridState.EMPTY) then
        
        if self._frameSprite then
            self._frameSprite:hide()
        end

        if self._iconSprite then
            self._iconSprite:hide()
        end

        if self._abovePetSprite then
            self._abovePetSprite:hide()
        end

        if self._fightBoader then
            self._fightBoader:hide()
        end

        if self._battleAnimation then
            self._battleAnimation:hide()
        end

        if self._levelNode and not tolua.isnull(self._levelNode) then
            self._levelNode:removeFromParent(false)
        end

        if self._startNode then
            self._startNode:hide()
        end
    end

    self:refreshCanUseState()
end

function PetGrid:refreshCanUseState()
    if not self._data then
        return
    end

    if self._data.petGridData and not self._data.petGridData.disableCheck then
        local children = self:getChildren()
        if (children) then
            for i = 1, #children do
                children[i]:setOpacity(255)
            end
        end

        if(self._showChoiceStatus) then
            if(self._choiceStatus) then
                self._choiceStatus:setVisible(true)
            end
        else
            if(self._choiceStatus) then
                self._choiceStatus:setVisible(false)
            end

            if self._checkItem and self._data.petGridData and self._data.petGridData._isCheck then
                self._data.petGridData._isCheck = false
                self._checkItem:hide()
            end
        end
    else
        if(self._choiceStatus) then
            self._choiceStatus:setVisible(false)
        end

        if self._checkItem and self._data.petGridData and self._data.petGridData._isCheck then
            self._data.petGridData._isCheck = false
            self._checkItem:hide()
        end

        local children = self:getChildren()
        if (children) then
            if self._showChoiceStatus then
                for i = 1, #children do
                    children[i]:setOpacity(85)
                end
            else
                for i = 1, #children do
                    children[i]:setOpacity(255)
                end
            end
        end
    end
end

function PetGrid:updateCanUseStateAndDelayRefresh(canCheck, dalayTime)
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
    self._data.petGridData.disableCheck = canCheck and false or true
    self.mSchedulerID = scheduler:scheduleScriptFunc(function()
        self:refreshCanUseState()
    end ,dalayTime, false)
end

--设置道具是否可用
function PetGrid:updateCanUseState(canCheck)
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
    self._data.petGridData.disableCheck = canCheck and false or true
    self:refreshCanUseState()
end

function PetGrid:showChoiceStatus()
    self._showChoiceStatus = true
    if (self._state == PetGridState.USED and not self._data.petGridData.disableCheck) then
        if(self._choiceStatus == nil) then
            self._choiceStatus = UI.Image:create()
            self._choiceStatus:init("ui_information_box.png")
            self:addChild(self._choiceStatus, ZORDER_BAG_GRID_CHOICE_STATUS_FLAG)
            self._choiceStatus:rightUp(0, 0)
            self._choiceStatus:show()
        end

        if self._data.petGridData and self._data.petGridData._isCheck then
            if (not self._checkItem) then
                self._checkItem = UI.Image:create()
                self._checkItem:init("ui_information_btn_yes.png")
                self._checkItem:rightUp(-8, -3)
                self:addChild(self._checkItem, ZORDER_BAG_GRID_CHOICE_IMG)
            end
            self._checkItem:show()
        end
    else
        if self._choiceStatus then
            if self._checkItem and self._data.petGridData and self._data.petGridData._isCheck then
                self._data.petGridData._isCheck = false
                self._checkItem:hide()
            end
            self._choiceStatus:hide()
        end
    end
end

function PetGrid:hideChoiceStatus()
    self._showChoiceStatus = false
    if(self._choiceStatus) then
        if self._data and self._data.petGridData and self._data.petGridData._isCheck then
            self._data.petGridData._isCheck = false
            if self._checkItem then
                self._checkItem:hide()
            end
        end
        self._choiceStatus:hide()
    end
end

function PetGrid:getQualityBgImg()
    -- local star = 0
    -- local bgImg = "box_quality_0_1.png"
    -- if not self._showStartNode or self._data.emptySlot then
    --     return bgImg
    -- end

    -- star = self._data:getStarLv()

    -- if star == 0 or star == 1 then
    --     bgImg = "box_quality_0_1.png"
    -- elseif star == 2 or star == 3 then
    --     bgImg = "box_quality_0_2.png"
    -- elseif star == 4 or star == 5 then
    --     bgImg = "box_quality_0_3.png"
    -- elseif star == 6 or star == 7 then
    --     bgImg = "box_quality_0_4.png"
    -- elseif star == 8 or star == 9 then
    --     bgImg = "box_quality_0_5.png"
    -- end


    local petQuality = self._data:getPetQuality()
    local bgImg = "box_quality_0_1.png"
    if not self._showStartNode or self._data.emptySlot then
        return bgImg
    end
    if petQuality == PublicDefine.PetQualityType.Blue then
        bgImg = "box_quality_1_2.png"
    elseif petQuality == PublicDefine.PetQualityType.Golden then
        bgImg = "box_quality_1_3.png"
    elseif petQuality == PublicDefine.PetQualityType.HiddenGold then
        bgImg = "box_quality_1_4.png"
    elseif petQuality == PublicDefine.PetQualityType.Violet then
        bgImg = "box_quality_1_5.png"
    elseif petQuality == PublicDefine.PetQualityType.Red then
        bgImg = "box_quality_1_6.png"
    elseif petQuality == PublicDefine.PetQualityType.Platinum then
        bgImg = "box_quality_1_7.png"
    end

    return bgImg
end

function PetGrid:getAbovePetImg()
    local petQuality = self._data:getPetQuality()
    local abovePetImg = "box_quality_4_2.png"
    if not self._showStartNode or self._data.emptySlot then
        return abovePetImg
    end

    if petQuality == PublicDefine.PetQualityType.Blue then
        abovePetImg = "box_quality_4_2.png"
    elseif petQuality == PublicDefine.PetQualityType.Golden then
        abovePetImg = "box_quality_4_3.png"
    elseif petQuality == PublicDefine.PetQualityType.HiddenGold then
        abovePetImg = "box_quality_4_4.png"
    elseif petQuality == PublicDefine.PetQualityType.Violet then
        abovePetImg = "box_quality_4_5.png"
    elseif petQuality == PublicDefine.PetQualityType.Red then
        abovePetImg = "box_quality_4_6.png"
    elseif petQuality == PublicDefine.PetQualityType.Platinum then
        abovePetImg = "box_quality_4_7.png"
    end

    return abovePetImg
end

function PetGrid:showSelect()

    self:handleSelectItem()
    if self._showChoiceStatus and self._data.petGridData.disableCheck then
        return
    end

    if (not self._selectItem) then
        self._selectItem  = UI.Animation:create()
        self._selectItem:init(FX_ITEMLIST_ITEMSELECT_JSON, FX_ITEMLIST_ITEMSELECT_ATLAS)
        self._selectItem:center()
        self:addChild(self._selectItem, ZORDER_BAG_GRID_ANIMATION)
    end

    self._selectItem:show()
    self._selectItem:setAnimation("start_square", false)
    self._selectItem:addAnimation("loop_square", true)

    self:refreshCanUseState()
end

function PetGrid:hideSelect()
    if (self._selectItem) then
        self._selectItem:setAnimation("end_square", false)
    end

    self:refreshCanUseState()
end

function PetGrid:clearSelect()
    if (self._selectItem) then
        self._selectItem:hide()
    end
end

function PetGrid:handleSelectItem()
    if not self._showChoiceStatus or self._data.petGridData.disableCheck then
        return
    end

    if (not self._checkItem) then
        self._checkItem = UI.Image:create()
        self._checkItem:init("ui_information_btn_yes.png")
        self._checkItem:rightUp(-8, -3)
        self:addChild(self._checkItem, ZORDER_BAG_GRID_CHOICE_IMG)
    end

    if self._data.petGridData._isCheck == false then
        self._data.petGridData._isCheck = true

        self._checkItem:show()
    else
        self._data.petGridData._isCheck = false

        self._checkItem:hide()
    end
end

function PetGrid:getIsDelete()
    return self._data.petGridData._isCheck
end

-- isNoGet 是否获得,默认为false   showEquipComp:是否显示装备对比信息，默认为true
function PetGrid:showInfoArea(isNoGet, showEquipComp)
    -- print("PetsGrid:showInfoArea ", isNoGet, showEquipComp)
    self:setInfoArea(isNoGet, showEquipComp)
    self:enableDrage();
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onShowInfoAreaHandler)
end

function PetGrid:enableDrage()
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
    self:addEventListener(UIEvent.COMPONENT_DRAG_BEGAN, self, self.onDragBeganByPetsGrid)
    self:addEventListener(UIEvent.COMPONENT_DRAG_MOVED, self, self.onDragMoveByPetsGrid)
    self:addEventListener(UIEvent.COMPONENT_DRAG_ENDED, self, self.onDragEndedByPetsGrid)
    if CONFIG_DOUBLIE_CLICK then
        self:addEventListener(UIEvent.COMPONENT_DOUBLE_CLICK, self, self.onDoubleClickByPetsGrid)
    end
end

function PetGrid:onShowInfoAreaHandler(isHideLink)
end

function PetGrid:onDragBeganByPetsGrid(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end
    
    if self.dragBeginCallback then
        self.mCanDrag = self.dragBeginCallback(self)
        if self.mCanDrag == nil then
            self.mCanDrag = true
        end
    else 
        self.mCanDrag = false
    end
    
    if not self.mCanDrag then
        return
    end

    -- 创建一个克隆的节点，放到最上层来拖动，避免层级之间的遮挡
    if self.dragCloneNode == nil then
        self.dragCloneNode = self:createDraggedView();
        UI.UIManager:addToRootNode(self.dragCloneNode, 100000)
    end
    self.dragCloneNode:hideBG()
    self.dragCloneNode:hideFlagIcon()

    local wPos = self:convertToWorldSpace(self:getAnchorPointInPoints())
    wPos.x = wPos.x - self:getContentSize().width / 2
    self.dragCloneNode:setPosition(wPos)
    self:setVisible(false)
end

function PetGrid:onDragMoveByPetsGrid(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end

    if self.mCanDrag == false then
        return
    end

    if self.dragMoveCallback then
        self.dragMoveCallback(self);
    end

    if(not tolua.isnull(self.dragCloneNode)) then
        local x, y = self.dragCloneNode:getPosition();
        local delta = touch:getDelta();
        self.dragCloneNode:setPosition(cc.p(x + delta.x, y + delta.y))
    end

    if self.dragOutAreaJudgeNode == nil then
        assert(false, "setDragOutAreaJudgeNode() not set")
        return
    end

    if(not tolua.isnull(self._dragAnimation)) then
        local pos = self.dragOutAreaJudgeNode:convertToNodeSpace(touchPosition)
        local size = self.dragOutAreaJudgeNode:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local inSide = cc.rectContainsPoint(rect, pos)

        self._dragAnimation:changeInSideStatus(not inSide)
    end
end

function PetGrid:onDragEndedByPetsGrid(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end

    if (not tolua.isnull(self.dragCloneNode)) then
        self.dragCloneNode:removeFromParent()
        self.dragCloneNode = nil
    end
    self:setVisible(true)

    if(not tolua.isnull(self._dragAnimation)) then
        self._dragAnimation:removeFromParent(true)
        self._dragAnimation = nil
    end

    if self.mCanDrag == false then
        return
    end

    -- 拖动结束时， 必须要有一个父节点来判断是否在某个区域内
    if self.dragOutAreaJudgeNode == nil then
        assert(false, "setDragOutAreaJudgeNode() not set")
        return
    end

    local pos = self.dragOutAreaJudgeNode:convertToNodeSpace(touchPosition)
    local size = self.dragOutAreaJudgeNode:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    local inSide = cc.rectContainsPoint(rect, pos)

    if self.dragEndCallback then
        self.dragEndCallback(self, inSide, touchPosition);
    end
    
    Avalon.AudioManager:playSound("1505")
end



