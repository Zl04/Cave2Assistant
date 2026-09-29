-- RelicBagLayer.lua
-- by:hongyi.yan
-- time:2020.09.06
require("app.config.ConfigManager")
require "app.ui.baglayer.Relic.RelicInfoArea"
local winSize = cc.Director:getInstance():getWinSize()
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local RelicBagLayer = class("RelicBagLayer", UI.HWBtnComponent)
UI.RelicBagLayer = RelicBagLayer

-- 关卡选择资源
local COM_RES_LIST = {}

local COM_WIDTH = 400
local COM_HEIGHT = 550

local SELECT_IMG_0 = "ui_goods_button_dustbin_0.png"
local SELECT_IMG_1 = "ui_goods_button_dustbin_1.png"
local SELECT_IMG_2 = "ui_goods_button_hook.png"

-- 右上角展示的资源id列表
local RESOURCE_ID_LIST = {
    23020001,   -- 击毙金币
    22070600,   -- 时序之尘
    22070610,   -- 时序精华
}

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

function RelicBagLayer:ctor(target, height)
    RelicBagLayer.super.ctor(
    self,
    UIType.RELIC_BAG_LAYER,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
    )

    self._target = target
    self._data = RelicDataManager:getRelicBagData()
    self.bagHeight = height or 426
    self._deleteState = false

    self:registerListener()
end

function RelicBagLayer:dtor()
    RelicBagLayer.super.dtor(self)

    self:unRegisterListener()

    reload_script_file("app.ui.baglayer.Relic.RelicBagLayer")
end
-- 注册监听事件(可选)
function RelicBagLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RELIC_BAG_SLOTDRAG, self, self.slotDragEnd)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, self.updateRelicSlot)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, self, self.updateRelicSlot)
end

-- 注销监听事件(可选)
function RelicBagLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RELIC_BAG_SLOTDRAG, self, self.slotDragEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, self.updateRelicSlot)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, self, self.updateRelicSlot)
end


-- 初始化视图
function RelicBagLayer:onInitView()
    -- self:enableDebugDraw()

    -- 添加底板
    local bagBG = UI.Image:create()
    bagBG:init("ui_goods_banner_large_down.png")
    bagBG:center(12, 0)
    self:addChild(bagBG)

    local selectBtn = UI.Button:create()
    selectBtn:init("ui_goods_button_bg_up_0.png","ui_goods_button_bg_up_1.png")
    selectBtn:rightBottom(40, 508)
    selectBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    selectBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:selectBtnClick()
    end)
    self:addChild(selectBtn)

    local selectImg = UI.Image:create()
    selectImg:init(SELECT_IMG_0)
    selectImg:center()
    selectBtn:addChild(selectImg, 100)
    self.selectImg = selectImg

    local bagList = UI.GoodsListNew:create(5)
    bagList:init(self._data, self.bagHeight)
    -- bagList:hideBGImageCover()
    bagList:setCallbackForGridClick(self, self.bagClickCallback)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    bagList:setCallbackForGridDoubleClick(self, self.bagCellDoubleClickCallback)
    bagList:setDoubleClickAsDragEnd(true)
    -- bagList:showMask()
    bagList:center(-26, 0)
    self._bagGridList = bagList
    self:addChild(bagList)

     -- 上边的分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(387, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(16 + lineUpImage:getContentSize().width/2, 456))
    self:addChild(lineUpImage, 4)

    local lineDownImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineDownImage:setContentSize(387, 1)
    lineDownImage:setCapInsets(CCRectMake(1,0,1,1))
    lineDownImage:setPosition(cc.p(16 + lineDownImage:getContentSize().width/2, 70))
    self:addChild(lineDownImage, 4)

    -- 物品分类按钮
    local goodsTabList = UI.TabList:create()
    goodsTabList:init(
        3,
        56,
        60
    )
    goodsTabList:setSize(
        250,
        60
    )
    goodsTabList:leftBottom(65 - 20, 1)
    goodsTabList:setItemToFloatLeft()
    bagBG:addChild(goodsTabList)
    -- 所有装备
    local allGoodsTab = UI.GoodsTabItem:create()
    allGoodsTab:init("ui_goods_button_bg_down_0.png", "ui_goods_button_bg_down_1.png", "ui_goods_button_relic_0.png", "ui_goods_button_relic_1.png")
    goodsTabList:addTab(allGoodsTab)
end

function RelicBagLayer:bagClickCallback(bagGrid)
    if self._isDraging then
        return
    end

    local goodsData = nil
    if (bagGrid) then
        goodsData = bagGrid:getData()

        -- 分解选择
        if self._deleteState == true then
            if goodsData and bagGrid:getCanUseState() then
                if bagGrid:deleteItem() then
                    table.insert(self._deleteItemTable,goodsData)
                else
                    for i=#self._deleteItemTable, 1, -1 do
                        if self._deleteItemTable[i] == goodsData then
                            table.remove(self._deleteItemTable,i)
                        end
                    end
                end

                if #self._deleteItemTable == 0 then
                    self.selectImg:setSpriteName(SELECT_IMG_1)
                else
                    self.selectImg:setSpriteName(SELECT_IMG_2)
                end
            end

            self._bagGridList:refrehDeleteGrid(self._deleteItemTable, false)
        end

        -- 详情
        if goodsData then
            if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                local gemInfoArea = UI.RelicInfoArea:create()
                gemInfoArea:init(goodsData)
                self._infoArea = gemInfoArea
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

        -- 展示选中
        if self._selectedBagGrid ~= bagGrid then
            if self._selectedBagGrid then
                self._selectedBagGrid:hideSelect()
                self._selectedBagGrid = nil
            end
            if goodsData then
                if self._deleteState == false then
                    bagGrid:showSelect()
                end
                if goodsData:getIsNew() then
                    -- 如果是新物品，发送消息
                    GameManager:bagClickGoodsHandler(goodsData)
                end
            end

            self._selectedBagGrid = bagGrid
        end
    end
end

function RelicBagLayer:bagDragBeganCallback(grid, touchPosition)
    if not grid then
        return false
    end
    if self._isDraging then
        return false
    end

    self._isDraging = true
    self._target:showRoleEquipIndexAni(grid:getData():getRelicType())

    return true
end

function RelicBagLayer:bagDragMovedCallback(grid, touchPosition)
end

function RelicBagLayer:bagDragEndedCallback(grid, touchPosition)
    if not grid then
        return
    end
    if not self._isDraging then
        return
    end
    self._isDraging = false
    Avalon.MessageCenter:notice(GameMessage.MC_RELIC_EQUIP_SLOTDRAG, grid, touchPosition, true)
end

function RelicBagLayer:bagCellDoubleClickCallback()
end

function RelicBagLayer:slotDragEnd(grid, touchPosition, bool)
    if not grid then
        return
    end

    -- 不在城镇或公会中
    if not (SceneManager:getInstance():isNotInFightScene()) then
        UI.ScrollBar:createByText(UI.TEXT_1213665)
        return
    end

    if GameDataManager:getInstance():getFreePacketBoxNum() < 1 then
        UI.ScrollBar:createByText(UI.TEXT_1212011)
        return
    end

    local pos = self:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    local size = self:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        UI.WaitingLayer:showWaiting(true, nil, 5)
        Net.NetGoodsSystem:requestRelicWear(grid:getData():getEntityID(), false)
    end
end

function RelicBagLayer:updateRelicSlot()
    self._data = RelicDataManager:getRelicBagData()
    self._bagGridList:setData(self._data)
    self._bagGridList:updateView()
end

function RelicBagLayer:selectBtnClick()
    if not self._deleteState then
        -- 在查看装备时，点击删除按钮，选中的动画不消失
        self._bagGridList:showChoiceStatus()
        self._bagGridList:showDestory()

        if  self._selectedBagGrid then
            self._selectedBagGrid:hideSelect()
            self._selectedBagGrid = nil
        end
        self._deleteState = true

        self._bagGridList:updateCanDrag(false)

        self._deleteItemTable = {}
        self.selectImg:setSpriteName(SELECT_IMG_1)

        -- 设置吞噬事件
        self:setInterceptTouches(true)

        -- 关闭拖动
        self._isDeleting = true

        -- 刷新显示
        self._bagGridList:setData(self._data)
        self._bagGridList:updataGridCanUseState(false, false, self._deleteState, nil)
    else
        if not self._deleteItemTable or #self._deleteItemTable == 0 then
            self:outSelectDecompose()
        elseif self:checkBagIsFull() then
            UI.ScrollBar:createByText(UI.TEXT_1212011)
            return
        else
            -- 二次确认
            local richText = self:getDecomposeRichList()
            local okCallBack = function ()
                -- UI.WaitingLayer:showWaiting(true, nil, 5)
                GameManager:sellGoodsArrHandler(self._deleteItemTable)

                self._deleteItemTable = {}
                self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)
                self:outSelectDecompose()
            end
            local cancelCallBack = function ()
                self._deleteItemTable = {}
                self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)

                self:outSelectDecompose()
            end
            UI.TipsLayer:onShowCommonRichTextHandler(richText, okCallBack, cancelCallBack)
        end
    end
end

function RelicBagLayer:checkBagIsFull()
    -- 计算分解所得 {{goodsID:1,num:1,isGolden:false},{goodsID:2,num:1,isGolden:true}}
    local decomposeAwards = {}
    for _, v in ipairs(self._deleteItemTable) do
        local strengthConfig = ConfigManager:getRelicLevelConfigByID(v:getLevel())
        local composeList = string.split(strengthConfig.materialGet, ";")
        for _, n in ipairs(composeList) do
            local goodInfo = string.split(n, ",")
            if not decomposeAwards[tonumber(goodInfo[1])] then
                decomposeAwards[tonumber(goodInfo[1])] = 0
            end
            decomposeAwards[tonumber(goodInfo[1])] = decomposeAwards[tonumber(goodInfo[1])] + tonumber(goodInfo[2])
        end
    end

    local goodsArr = {}
    for k, v in pairs(decomposeAwards) do
        local data = {}
        data.goodsID = k
        data.num = v
        data.isGolden = false
        table.insert(goodsArr, data)
    end

    -- 判断背包是否满了
    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) == true then
        return true
    end
    return false
end

function RelicBagLayer:outSelectDecompose()
    self.selectImg:setSpriteName(SELECT_IMG_0)
    self._bagGridList:updateCanDrag(true)

    self._deleteItemTable = {}

    self._bagGridList:hideChoiceStatus()
    self._bagGridList:hideDestory()

    self._deleteState = false
    self._isDeleting = false

    self:setInterceptTouches(false)

    -- 刷新显示
    self._bagGridList:setData(self._data)
    self._bagGridList:updataGridCanUseState(false, true, self._deleteState, nil)
end

function RelicBagLayer:getDecomposeRichList()
    -- 计算分解所得
    local decomposeAwards = {}
    for _, v in ipairs(self._deleteItemTable) do
        local strengthConfig = ConfigManager:getRelicLevelConfigByID(v:getLevel())
        local composeList = string.split(strengthConfig.materialGet, ";")
        for _, n in ipairs(composeList) do
            local goodInfo = string.split(n, ",")
            if not decomposeAwards[tonumber(goodInfo[1])] then
                decomposeAwards[tonumber(goodInfo[1])] = 0
            end
            decomposeAwards[tonumber(goodInfo[1])] = decomposeAwards[tonumber(goodInfo[1])] + tonumber(goodInfo[2])
        end
    end

    -- 创建富文本元素
    local richTextList = {}
    local element = UI.Text:create()
    element:init(UI.TEXT_1212583, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    element:center()
    table.insert(richTextList, element)

    local textLineNum = 0

    for k, v in pairs(decomposeAwards) do
        local goldData = GoodsDataManager:createLocalGoodsData(k)
        goldData:setNum(v)

        local elementText = UI.Text:create()
        elementText:init("\n"..UI.TEXT_1314063, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
        elementText:center()
        table.insert(richTextList, elementText)

        local elementImg = UI.Image:create()
        elementImg:init(goldData:getSmallIconName())
        elementImg:center()
        table.insert(richTextList, elementImg)

        local elementNum = UI.Text:create()
        elementNum:init(" "..tostring(goldData:getNum()), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
        elementNum:center()
        table.insert(richTextList, elementNum)

        textLineNum = textLineNum + 1
    end

    local richText = UI.imitateRichText:create(360)
    richText:init(richTextList, 358, 120, (3 - textLineNum) * 20)
    richText:setTextCenter()

    return richText
end

-- 更新视图
function RelicBagLayer:onUpdateView()
end