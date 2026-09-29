------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/07/19
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")
require "app.ui.shoplayer.BagGoodsPanel"

local RecastRemoveLevelView = class("RecastRemoveLevelView", UI.DoorWin)
local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {
    "ui_town_recasting.plist",
}

local COM_WIDTH = 350
local COM_HEIGHT = 640
local layoutUU
function RecastRemoveLevelView:ctor(param, param2)
    RecastRemoveLevelView.super.ctor(
    	self,
    	UI.Type.EQUIPMENT_RECAST_REMOVE_LEVEL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.spriteID = param
    print("RecastRemoveLevelView param=", param, param2)
    self.mGoodsGrid = nil;          --装备框
    self.mCanRecast = true;       --是否能重铸
    -- self:setTouchEnable(true);
    self:setInterceptTouches(false);

    self:bindModel()
    layoutUU = UIUtil:createAutoUILayout("RecastRemoveLevelView","app.modules.recast.RecastPosConfig", false)
end

function RecastRemoveLevelView:dtor()
    RecastRemoveLevelView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.recast.RecastRemoveLevelView")
end

function RecastRemoveLevelView:close()
    RecastRemoveLevelView.super.close(self)
    mvc.closePanel("Recast", "RecastRemoveLevel")
end

function RecastRemoveLevelView:onInitView()
    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:setSize(winSize.width, winSize.height)
    rootLayout:center()
    self:addChild(rootLayout)

    local leftLayer = UI.Layout:create()
    leftLayer:init()
    leftLayer:setSize(352, 595)
    leftLayer:centerLeft(0)
    rootLayout:addChild(leftLayer)
    self.leftLayer = leftLayer
    -- leftLayer:enableDebugDraw()

    local bg = UI.Image:create()
    bg:init("ui_recasting_bg.png")
    bg:center()
    self.leftLayer:addChild(bg)

    local titleBg = UI.Image:create()
    titleBg:init("ui_recasting_title.png")
    titleBg:centerUp(-30)
    self.leftLayer:addChild(titleBg, 10)

    local titleStr = UI.Text:create()
    titleStr:init(UI.TEXT_1212308, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    titleStr:centerBottom(11)
    titleBg:addChild(titleStr)
    self.titleStr = titleStr

    local scale = 225 / cc.Label:CalculateStringSize(self.titleStr:getText(), UI.FONT_ARIAL, self.titleStr:getFontSize()).width
    scale = scale > 1 and 1 or scale
    self.titleStr:setScale(scale)

    -- 提示文字
    local centerBgImage = UI.Image:create()
    centerBgImage:init("ui_recasting_decorate_01.png")
    centerBgImage:centerBottom(113)
    self.leftLayer:addChild(centerBgImage)

    local centerTitleStr = UI.Text:create()
    centerTitleStr:init(UI.TEXT_1212862, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    centerTitleStr:centerUp(25 - centerTitleStr:getContentSize().height/2)
    centerBgImage:addChild(centerTitleStr)

    -- 中间展示区域
    local centerBg = UI.Image:create()
    centerBg:init("ui_recasting_decorate_03.png")
    centerBg:centerBottom(123)
    self.leftLayer:addChild(centerBg)

    local centeLayout = UI.Layout:create()
    centeLayout:init()
    centeLayout:setSize(centerBg:getContentSize().width, centerBg:getContentSize().height)
    centeLayout:center()
    centerBg:addChild(centeLayout)
    self.centeLayout = centeLayout

    --spine
    self.recastAnimation = UI.Animation:create()
    self.recastAnimation:init("effect_ui_twon_recast_top.json", "effect_ui_twon_recast_top.atlas", 1);
    self.recastAnimation:centerUp(102)
    self.leftLayer:addChild(self.recastAnimation)
    self.recastAnimation:setAnimation("idle", false)

    self.iconAnimation = UI.Animation:create()
    self.iconAnimation:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    self.iconAnimation:centerUp(102)
    self.leftLayer:addChild(self.iconAnimation)

    self.lightAnimation = UI.Animation:create()
    self.lightAnimation:init("effect_ui_twon_recast_top_light.json", "effect_ui_twon_recast_top_light.atlas", 1);
    self.lightAnimation:centerUp(100)
    self.leftLayer:addChild(self.lightAnimation, 200)

    self.downAnimation = UI.Animation:create()
    self.downAnimation:init("effect_ui_twon_recast_down.json", "effect_ui_twon_recast_down.atlas", 1);
    self.downAnimation:centerBottom(39)
    self.leftLayer:addChild(self.downAnimation)
    self.downAnimation:setAnimation("idle", false)
    --spine end

    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:centerUp(68)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:showInfoArea();
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid));
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.leftLayer:addChild(self.mGoodsGrid, 100)


    --右边背包数据
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0 --"all"
    _usedType1.needRemoveLevel = true -- 是否需要筛选可以等级移除
    table.insert(usedTypeList, _usedType1)

    local bagList = UI.BagGoodsPanel:create(usedTypeList, false, false)
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
    rootLayout:addChild(bagList, 5)
    local bagListW, bagListH = bagList:getSize()
    bagList:centerLeft(0)
    bagList:changeBagDefaultIndex(2)
    bagList:setUseLock(false)
    -- bagList:enableDebugDraw()

    -- 下面的操作区域
    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_2.png")
    executeButton:centerBottom(6)
    self.leftLayer:addChild(executeButton, 10)
    executeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    executeButton:setText(UI.TEXT_1212860)
    executeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRemoveLevelClick)
    self.executeButton = executeButton

    local executeButtonIcon = UI.Image:create()
    executeButtonIcon:init("symbol_gaming_diamond.png")
    executeButtonIcon:centerLeft(90)
    executeButton:addChild(executeButtonIcon, 10)
    self.executeButtonIcon = executeButtonIcon

    local executeButtonPrice = UI.NumberText:create("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51, 10)
    executeButtonPrice:centerLeft(130)
    executeButton:addChild(executeButtonPrice, 10)
    self.executeButtonPrice = executeButtonPrice

    self:setDoorNode(self.leftLayer, bagList)
    self:open()
    -- self:showInitAttr()
    self:refreshButton()
end

function RecastRemoveLevelView:refreshButton(isEnable)
    if(self.mGoodsData) then
        self.executeButton._text:hide()
        self.executeButtonPrice:show()
        self.executeButtonIcon:show()
    else 
        self.executeButton._text:show()
        self.executeButtonPrice:hide()
        self.executeButtonIcon:hide()
    end
    if(isEnable) then 
        self.executeButton:enable()
    else 
        self.executeButton:disable()
    end
end

function RecastRemoveLevelView:onRemoveLevelClick()
    if not self.mCanRecast then
        return
    end
    if self.mGoodsData == nil then
        return
    end
     --检查角色  行为是否合法
    if RoleBehaviorManager:equipTownNpcCheck() then
        printWarn(" been blocked when using equipment npc recastData function !")
        return
    end

    -- 检查材料是否够用

    -- local cost = recastData.cost[self.mGoodsData.recastNum + 1] or recastData.cost[maxCount]
    -- if GameDataManager:getInstance():getCurCoin() < cost then
    --     UI.ScrollBar:createByText(UI.TEXT_1110389)
    --     return
    -- end

    local isNoticeRecast = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.EquipRemoveLevel..GameDataManager:getInstance():getMasterPK(), true)  
    --二次确认
    if isNoticeRecast then
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1212863, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.EquipRemoveLevel..GameDataManager:getInstance():getMasterPK(), false)  
            end
            self.mCanRecast = false
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            mvc.send(mvc.events.RecastRemoveLevel_Remove_Request, {goodsData = self.mGoodsData, spriteID = self.spriteID})
            -- Net.NetNPCSystem:reqEquipRemoveLevel(self.mGoodsData) 
            self._bagGridList:updateCanDrag(false)
        end, function(isSelect)
            
        end, nil, nil, true)
        return
    end  
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    mvc.send(mvc.events.RecastRemoveLevel_Remove_Request, {goodsData = self.mGoodsData, spriteID = self.spriteID})
    -- Net.NetNPCSystem:reqEquipRemoveLevel(self.mGoodsData)
    self._bagGridList:updateCanDrag(false)
    self.mCanRecast = false
    -- NetNPCSystem:reqEquipRemoveLevel(self.mGoodsData)
end

function RecastRemoveLevelView:onTouchBeganByGoodsGrid(grid)
    if not self.mCanRecast then
        return false
    end
    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
    self.iconAnimation:setAnimation("ready1", false)
    return true
end

function RecastRemoveLevelView:onTouchEndedByGoodsGrid(grid, isInSide)
    if not self.mCanRecast then
        return
    end
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    if isInSide then
        self.mGoodsGrid:centerUp(68)
        self.mGoodsGrid:show()
        self.iconAnimation:setAnimation("putin1", false)
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()
        local goodsData = grid:getData()
        self.mGoodsData._changeNum = 0

        self._bagGridList:changeBagIndex(self._bagGridList:getChangeBagIndexByGoodsData(goodsData))

        self.mGoodsData = nil
        self:refreshGoodsGrid()
        self._bagGridList:refreshView()
        self.iconAnimation:setAnimation("ready3", false)
    end
end

--刷新移除需要的材料
function RecastRemoveLevelView:refreshGoodsGrid()
    self.centeLayout:removeAllChildren()
    if self.mGoodsData == nil then
        self.mGoodsGrid:hide()
        self:refreshButton()
        return
    end
    self.mGoodsGrid:setData(self.mGoodsData)
    self.mGoodsGrid:updateView()
    local isEnable = true

    -- 刷新需求物品表现
    local removeLevelConfig = self.mGoodsData:getEquipRemoveConfig()
    if(removeLevelConfig) then 
        local useGoodsDataArr = {}
        local cost = nil
        local costNum = 0
        if(#removeLevelConfig.costGoodsID == #removeLevelConfig.costGoodsNum) then 
            for k,ID in ipairs(removeLevelConfig.costGoodsID) do 
                if(ID == Game.ConstGoods.Diamond or ID == Game.ConstGoods.Coin) then 
                    cost = ID
                    costNum = removeLevelConfig.costGoodsNum[k]
                else 
                    local goodsData = GoodsDataManager:createLocalGoodsData(ID)
                    if(goodsData) then 
                        goodsData.haveUseNum = removeLevelConfig.costGoodsNum[k]
                        goodsData:setIsNew(false)
                        table.insert(useGoodsDataArr, goodsData)
                    end
                end
            end
        end

        if(useGoodsDataArr and #useGoodsDataArr > 0) then 
            for k,goodsData in ipairs(useGoodsDataArr) do 
                local goodGrid = UI.GoodsGrid:create()
                goodGrid:init(goodsData)
                goodGrid:hideFlagIcon()
                goodGrid:showGemLevel()
                goodGrid:showInfoArea(true, false);

                -- 添加需求表现
                local haveNum, warehouse = GameDataManager:getGoodsDataNumForGoodsID(goodsData:getGoodsID(), true, true) 
                haveNum = haveNum + warehouse
             

                local costNumText = UI.Text:create()
                costNumText:init(string.format("%d/%d", haveNum, goodsData.haveUseNum), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
                costNumText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
                if(goodsData.haveUseNum > haveNum) then
                    isEnable = false
                    costNumText:setFontColor({r = 244,g = 18, b = 33})
                end
                costNumText:rightBottom(0, 0)
                goodGrid:addChild(costNumText, 100)
                self.centeLayout:addChild(goodGrid)

                if(#useGoodsDataArr == 1) then 
                    goodGrid:centerUp(40)
                elseif (#useGoodsDataArr == 2) then 
                    if(k == 1) then 
                        goodGrid:leftUp(19, 42)
                    elseif(k ==2) then
                        goodGrid:rightUp(19, 42)
                    end
                elseif (#useGoodsDataArr == 3) then 
                    if(k == 1) then 
                        goodGrid:rightUp(22, -10)
                    elseif (k == 2) then
                        goodGrid:leftUp(22, -10)
                    elseif (k == 3) then
                        goodGrid:centerUp(111)
                    end
                end
            end
        end

        if(cost and costNum) then 
            local priceSpriteName = "symbol_gaming_diamond.png"
            if(cost == Game.ConstGoods.Coin) then 
                priceSpriteName = "symbol_gaming_money.png"
            end
            self.executeButtonIcon:setSpriteName(priceSpriteName)

            self.executeButtonPrice:setText(costNum)
            local left = (self.executeButton:getContentSize().width - self.executeButtonIcon:getContentSize().width - 4 - self.executeButtonPrice:getContentSize().width) / 2
            self.executeButtonIcon:centerLeft(left)
            self.executeButtonPrice:centerLeft(left + self.executeButtonIcon:getContentSize().width + 4)

            local isEnough = true
            if(cost == Game.ConstGoods.Coin) then 
                if GameDataManager:getInstance():getCurCoin() < costNum then
                    isEnough = false
                end
            elseif(cost == Game.ConstGoods.Diamond) then 
                if GameDataManager:getInstance():getDiamond() < costNum then
                    isEnough = false
                end
            end

            if not isEnough then
                isEnable = false
                self.executeButtonPrice:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            else
                self.executeButtonPrice:setFontColor(UI.FONT_COLOR_51_51_51)
            end
        end
    else 
        isEnable = false
    end

    self:refreshButton(isEnable)
end

function RecastRemoveLevelView:updateBtnState()
    -- body
end


function RecastRemoveLevelView:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end
    
    self.iconAnimation:setAnimation("ready1", false)
    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
end

function RecastRemoveLevelView:bagDragMovedCallback(grid, touchPosition)

end

function RecastRemoveLevelView:bagDragEndedCallback(grid, touchPosition, isInBag)
    print("RecastRemoveLevelView:bagDragEndedCallback")
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()

    if goodsData and goodsData:getIsRemoveLevel() == false then
        UI.ScrollBar:createByText(UI.TEXT_1212861)
        self.iconAnimation:setAnimation("ready3", false)
        return
    end
    
    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))
    if not isInBag then
        self.iconAnimation:setAnimation("putin1", false)
        local _randomArr = goodsData._randomArr
        if self.mGoodsData ~= nil then
            self.mGoodsData._changeNum = 0
        end
        self.mGoodsGrid:show()

        goodsData._changeNum = -1
        self.mGoodsData = goodsData
        self._bagGridList:refreshView()
        self:refreshGoodsGrid()

        if self.npcInfomationNum == 0 then
            self.npcInfomationNum = self.npcInfomationNum + 1
        end
    else
        self.iconAnimation:setAnimation("ready3", false)
    end
end 

function RecastRemoveLevelView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshGoodsGrid)
end

function RecastRemoveLevelView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshGoodsGrid)
end

function RecastRemoveLevelView:removeLevelResult(data)
    local isSuccess = false
    if(data and data.err == "EquipErrorNo_OK") then 
        isSuccess = true
    end
    UI.WaitingLayer:hideWaiting()
    local delayTime = 1.5
    if isSuccess then
        self.recastAnimation:setAnimation("success", false)
        self.lightAnimation:setAnimation("success", false)
        self.downAnimation:setAnimation("success", false)
        delayTime = 2
    else
        self.recastAnimation:setAnimation("fail", false)
        self.lightAnimation:setAnimation("fail", false)
        self.downAnimation:setAnimation("fail", false)
        delayTime = 1.5
    end

    if(isSuccess) then 
        UI.ScrollBar:createByText(UI.TEXT_1212865)
    else 
        UI.ScrollBar:createByText(UI.TEXT_1212864)
    end

    Avalon.Scheduler:scheduleUpdateOnce(self, function ()
        if tolua.isnull(self) then
            return
        end

        if(isSuccess) then 
            self.iconAnimation:setAnimation("end", false)
            if(self.mGoodsData) then
                self.mGoodsData._changeNum = 0
            end
            self.mGoodsData = nil
        end

        self._bagGridList:updateCanDrag(true)
        self.mCanRecast = true
        self._bagGridList:refreshView()
        self:refreshGoodsGrid()
    end, delayTime)

    Avalon.Scheduler:scheduleUpdateOnce(self, function ()
        if isSuccess then
            Avalon.AudioManager:playSound("1517")
        else
            Avalon.AudioManager:playSound("1518")
        end
    end, 1.3)
end

return RecastRemoveLevelView