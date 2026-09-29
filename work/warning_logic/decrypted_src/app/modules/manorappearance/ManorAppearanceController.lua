--[[--
控制器ManorAppearanceController，view已经注入,可以通过mvc.manorAppearanceProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/07/21
-- desc	: 
------------------------------------------------------------------------------
local ManorAppearanceController = class("ManorAppearanceController", mvc.GameController)

-- mvc.events.Manor_Appearance_Show_Layer 处理函数
function ManorAppearanceController:noticeManorAppearanceShowLayer(notification, name, parent)
    local layer
    if name == "ManorAppearanceLayer" then
        local PetPacketLayer = require "app.modules.manorappearance.ManorAppearanceLayer"
        self.ManorAppearanceLayer = PetPacketLayer:create()
        layer = self.ManorAppearanceLayer
    elseif name == "MannorUpgradeLayer" then
        local MannorUpgradeLayer = require "app.modules.manorappearance.MannorUpgradeLayer"
        self.MannorUpgradeLayer = MannorUpgradeLayer:create(PublicDefine.ManorBuildID.BuildID_Manor)
        layer = self.MannorUpgradeLayer

    elseif name == "ManorWholeFacaLayer" then
        local ManorWholeFacaLayer = require "app.modules.manorappearance.ManorWholeFacaLayer"
        self.ManorWholeFacaLayer = ManorWholeFacaLayer:create("mannor")
        layer = self.ManorWholeFacaLayer
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end



-- mvc.events.Manor_Appearance_Click_Tab 处理函数
function ManorAppearanceController:noticeManorAppearanceClickTab(notification, clickIndex)
    if not self.manorAppearanceMainView then
        return
    end

    self.manorAppearanceMainView.curTabIndex = clickIndex
    print("Manor_Appearance_Click_Tab:", self.manorAppearanceMainView.curTabIndex, clickIndex)
    self.manorAppearanceMainView.btnData[self.manorAppearanceMainView.curTabIndex].select = true
    self.manorAppearanceMainView._tableView:updateCellAtIndex(self.manorAppearanceMainView.curTabIndex - 1)

    if self.manorAppearanceMainView.lastTabIndex > 0 then
        if self.manorAppearanceMainView.lastTabIndex == clickIndex then
            return
        end
        self.manorAppearanceMainView.btnData[self.manorAppearanceMainView.lastTabIndex].select = false
        self.manorAppearanceMainView._tableView:updateCellAtIndex(self.manorAppearanceMainView.lastTabIndex - 1)
    end

    local nowPageId = self.manorAppearanceMainView.curTabIndex
    local lastPageId = self.manorAppearanceMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    local name = ""
    if nowPageId == 1 then
        name = "ManorAppearanceLayer"
    elseif nowPageId == 2 then
        name = "MannorUpgradeLayer"
    elseif nowPageId == 3 then
        name = "ManorWholeFacaLayer"
    end
    mvc.send("Manor_Appearance_Show_Layer", name, self.manorAppearanceMainView)

    if lastPageId == 1 and self.ManorAppearanceLayer and not tolua.isnull(self.ManorAppearanceLayer) then
        self.ManorAppearanceLayer:removeFromParent(true)
        self.ManorAppearanceLayer = nil
    elseif lastPageId == 2 and self.MannorUpgradeLayer and not tolua.isnull(self.MannorUpgradeLayer) then
        self.MannorUpgradeLayer:removeFromParent(true)
        self.MannorUpgradeLayer = nil
    elseif lastPageId == 3 and self.ManorWholeFacaLayer and not tolua.isnull(self.ManorWholeFacaLayer) then
        self.ManorWholeFacaLayer:removeFromParent(true)
        self.ManorWholeFacaLayer = nil
    
    end

    self.manorAppearanceMainView.lastTabIndex = self.manorAppearanceMainView.curTabIndex
end



-- mvc.events.Manor_Appearance_Open_Main_View 处理函数
function ManorAppearanceController:noticeManorAppearanceOpenMainView(notification, layerName)
    mvc.openPanel("ManorAppearance", "ManorAppearanceMain")
    local pageIndex = 1
    if layerName == "ManorAppearanceLayer" then
        pageIndex = 1
    elseif layerName == "MannorUpgradeLayer" then
        pageIndex = 2
    elseif layerName == "ManorWholeFacaLayer" then
        pageIndex = 3
    end

    mvc.send("Manor_Appearance_Click_Tab", pageIndex)
end



-- mvc.events.Manor_Appearance_Resp_Change_Build_Facade 处理函数
function ManorAppearanceController:noticeManorAppearanceRespChangeBuildFacade(notification, data)
    local GameInManorManager = require "app.game.GameInManorManager"
    local map = GameInManorManager:getInstance():getBuildID2FunctionMap()
    local funtionID = map[data.buildId]
    local animeName = ""
    if data.facadeId ~= 0 then
        local shapeConfig = ConfigManager:getAllOtherShapeDataByID(data.facadeId)
        animeName = shapeConfig.replaceResource
    else
        local allShapeConfig = ConfigManager:getAllOtherShapeData()
        for k, v in pairs(allShapeConfig) do
            if data.buildId == v.type and v.isDefaultSkin == 1 then
                local shapeConfig = v--ConfigManager:getAllOtherShapeDataByID(k)
                animeName = shapeConfig.replaceResource
                break
            end
        end
    end
    -- local shapeConfig = ConfigManager:getAllOtherShapeDataByID(data.facadeId)
    -- animeName = shapeConfig.replaceResource
    -- print("animeName:", animeName)
    GameInManorManager:getInstance():changeNPCSpine(funtionID, animeName)
    -- self.ManorAppearanceLayer:updateCells()
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FACA_LAYER_VIEW)
end



-- mvc.events.Manor_Appearance_Resp_Change_Mannor_Facade 处理函数
function ManorAppearanceController:noticeManorAppearanceRespChangeMannorFacade(notification, data)
    local GameInManorManager = require "app.game.GameInManorManager"
    GameInManorManager:getInstance():updateMannorBaseDataFacadeId(data.facadeId)
    local shapeConfig 
    if data.facadeId ~= 0 then
        shapeConfig = ConfigManager:getAllMannorShapeDataByID(data.facadeId)
    else
        local allShapeConfig = ConfigManager:getAllMannorShapeData()
        for k, v in pairs(allShapeConfig) do
            if v.isDefaultSkin == 1 then
                shapeConfig = v--ConfigManager:getAllOtherShapeDataByID(k)
                break
            end
        end
    end
    -- shapeConfig = ConfigManager:getAllMannorShapeDataByID(data.facadeId)
    GameInManorManager:getInstance():changeMannorDecoration(shapeConfig)
    self.ManorWholeFacaLayer:updateCells()
end



-- mvc.events.Manor_Appearance_Resp_Refresh_Mannor_Facade 处理函数
function ManorAppearanceController:noticeManorAppearanceRespRefreshMannorFacade(notification, data)
    for _, v in pairs(data.facadeIds) do
        mvc.manorAppearanceModel:setUnlockFacades(v)
    end
end



return ManorAppearanceController