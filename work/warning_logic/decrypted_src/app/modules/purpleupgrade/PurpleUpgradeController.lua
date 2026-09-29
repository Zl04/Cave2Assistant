--[[--
控制器PurpleUpgradeController，view已经注入,可以通过mvc.purpleUpgradeProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/12/11
-- desc	: 
------------------------------------------------------------------------------
local PurpleUpgradeController = class("PurpleUpgradeController", mvc.GameController)

-- mvc.events.PurpleUpgrade_Show_Layer 处理函数
function PurpleUpgradeController:noticePurpleUpgradeShowLayer(notification, pageIndex, parent)
    local layer
    if pageIndex == 1 then
        self.PurpleUpgradeEquipView = mvc.purpleUpgradeEquipView:create()
        layer = self.PurpleUpgradeEquipView
    elseif pageIndex == 2 then
        self.PurpleUpgradeDebrisConvertView = mvc.purpleUpgradeDebrisConvertView:create()
        layer = self.PurpleUpgradeDebrisConvertView
    elseif pageIndex == 3 then
        self.PurpleUpgradeExchangeView = mvc.purpleUpgradeExchangeView:create()
        layer = self.PurpleUpgradeExchangeView
    elseif pageIndex == 4 then
        self.PurpleUpgradeResetView = mvc.purpleUpgradeResetView:create()
        layer = self.PurpleUpgradeResetView
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end



-- mvc.events.PurpleUpgrade_Click_Tab 处理函数
function PurpleUpgradeController:noticePurpleUpgradeClickTab(notification, clickIndex)
    if not self.purpleUpgradeMainView then
        return
    end
    self.purpleUpgradeMainView.curTabIndex = clickIndex
    self.purpleUpgradeMainView.btnData[self.purpleUpgradeMainView.curTabIndex].select = true
    self.purpleUpgradeMainView._tableView:updateCellAtIndex(self.purpleUpgradeMainView.curTabIndex - 1)

    if self.purpleUpgradeMainView.lastTabIndex > 0 then
        if self.purpleUpgradeMainView.lastTabIndex == clickIndex then
            return
        end
        self.purpleUpgradeMainView.btnData[self.purpleUpgradeMainView.lastTabIndex].select = false
        self.purpleUpgradeMainView._tableView:updateCellAtIndex(self.purpleUpgradeMainView.lastTabIndex - 1)
    end

    local nowPageId = self.purpleUpgradeMainView.curTabIndex
    local lastPageId = self.purpleUpgradeMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    mvc.send("PurpleUpgrade_Show_Layer", nowPageId, self.purpleUpgradeMainView)

    if lastPageId == 1 and self.PurpleUpgradeEquipView and not tolua.isnull(self.PurpleUpgradeEquipView) then
        self.PurpleUpgradeEquipView:removeFromParent(true)
        self.PurpleUpgradeEquipView = nil
    elseif lastPageId == 2 and self.PurpleUpgradeDebrisConvertView and not tolua.isnull(self.PurpleUpgradeDebrisConvertView) then
        self.PurpleUpgradeDebrisConvertView:removeFromParent(true)
        self.PurpleUpgradeDebrisConvertView = nil
    elseif lastPageId == 3 and self.PurpleUpgradeExchangeView and not tolua.isnull(self.PurpleUpgradeExchangeView) then
        self.PurpleUpgradeExchangeView:removeFromParent(true)
        self.PurpleUpgradeExchangeView = nil
    elseif lastPageId == 4 and self.PurpleUpgradeResetView and not tolua.isnull(self.PurpleUpgradeResetView) then
        self.PurpleUpgradeResetView:removeFromParent(true)
        self.PurpleUpgradeResetView = nil
    end

    self.purpleUpgradeMainView.lastTabIndex = self.purpleUpgradeMainView.curTabIndex
end



-- mvc.events.PurpleUpgrade_Open_Main_View 处理函数
function PurpleUpgradeController:noticePurpleUpgradeOpenMainView(notification,  pageIndex)
    mvc.openPanel("PurpleUpgrade", "PurpleUpgradeMain")
    local index = pageIndex or 1

    mvc.send("PurpleUpgrade_Click_Tab", index)

end



-- mvc.events.Primogem_On_Decompose_Succeed 处理函数
function PurpleUpgradeController:noticePrimogemOnDecomposeSucceed(notification, data)
    local awardsList = {}

    for k, v in pairs(data) do
        local config = ConfigManager:getMaterialConfigByID(v.templateID)
        if config then
            local getList = string.split(config.decompositionMaterial, ",")
            local getItemId = tonumber(getList[1])
            local getItemNum = tonumber(getList[2])
            
            local awarObj = GoodsDataManager:createLocalGoodsData(getItemId)
            awarObj:setNum(v.num * getItemNum)
            table.insert(awardsList, awarObj)
        end
    end

    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
    end
end



-- mvc.events.PrimogemShop_Exchange_Success 处理函数
function PurpleUpgradeController:noticePrimogemShopExchangeSuccess(notification, data)

    -- if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
    --     print("ROLE_REQ_STORE_BUY_GOODS result is err == ".. data.result)

    --     UI.WaitingLayer:hideWaiting()
    --     return
    -- end

    -- if data.storeType ~= PublicDefine.StoreType.StoreType_Primoge then
    --     return
    -- end

    if self.PurpleUpgradeExchangeView and not tolua.isnull(self.PurpleUpgradeExchangeView) then

        local awards = data.awards
        local awardsList = {}
        for _, value in ipairs(awards) do
            local awarObj = GoodsDataManager:createLocalGoodsData(value.id)
            awarObj:setNum(value.num)
            if value.num > 0 then
                table.insert(awardsList, awarObj)
            end
        end
        if #awardsList > 0 then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
        end

        UI.WaitingLayer:hideWaiting()
    end
end



-- mvc.events.PrimogemShop_Refresh_Info 处理函数
function PurpleUpgradeController:noticePrimogemShopRefreshInfo(notification)
    if self.PurpleUpgradeExchangeView and not tolua.isnull(self.PurpleUpgradeExchangeView) then
        self.PurpleUpgradeExchangeView:updateInfo()
    end

    if self.PurpleUpgradeDebrisConvertView and not tolua.isnull(self.PurpleUpgradeDebrisConvertView) then
        self.PurpleUpgradeDebrisConvertView:updateInfo()
    end
end



return PurpleUpgradeController