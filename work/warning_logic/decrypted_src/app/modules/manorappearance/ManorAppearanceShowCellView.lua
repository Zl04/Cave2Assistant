------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/21
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorAppearanceShowCellView = class("ManorAppearanceShowCellView", UI.HWBtnComponent)
local GameInManorManager = require "app.game.GameInManorManager"
UI = UI or {}
UI.ManorAppearanceShowCellView = ManorAppearanceShowCellView

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 236
local COM_HEIGHT = 138

function ManorAppearanceShowCellView:ctor(data, facaType)
    ManorAppearanceShowCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.type = facaType
    self:bindModel()
end

function ManorAppearanceShowCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorappearance", "ManorAppearance", false)
    ManorAppearanceShowCellView.super.init(self, ... )
end

function ManorAppearanceShowCellView:dtor()
    ManorAppearanceShowCellView.super.dtor(self)
    self:unbindModel()
    self.data = nil
    reload_script_file_mvc("app.modules.manorappearance.ManorAppearanceShowCellView")
end


function ManorAppearanceShowCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local useLayout = UI.Layout:create()
    useLayout:init()
    useLayout:setSize(COM_WIDTH, 30)
    useLayout:centerBottom(-40, 0)
    contentLayout:addChild(useLayout)
    self.useLayout = useLayout

    local frame = UI.Image.create()
    frame:init("ui_navigation_floorbg.png")
    frame:center()
    frame:setName("frame")
    contentLayout:addChild(frame)

    local clipperInnerNode = UI.Layout:create()
    clipperInnerNode:init()
    clipperInnerNode:setSize(230, 132)
    clipperInnerNode:centerUp(-10)
    self.clipperInnerNode = clipperInnerNode

    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(230, 132)
    clipper:addInnerNode(clipperInnerNode)
    clipper:center()
    contentLayout:addChild(clipper)
    -- clipper:enableDebugDraw()

    local image = UI.Image.create()
    image:init("")
    image:center()
    clipperInnerNode:addChild(image, 100)
    self.image = image

    local nameBg = UI.Image.create()
    nameBg:init("ui_navigation_title_2.png")
    nameBg:centerBottom(10)
    contentLayout:addChild(nameBg)

    local lock = UI.Image.create()
    lock:init("ui_navigation_btn_used.png")
    lock:rightUp(4, 1)
    contentLayout:addChild(lock)
    lock:setVisible(false)
    self.lockImage = lock

    local name = UI.Text:create()
    name:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    name:center()
    nameBg:addChild(name)
    self.name = name

    local round = UI.Image.create()
    round:init("ui_navigation_round.png")
    round:center(-55, 0)
    useLayout:addChild(round)

    local useText = UI.Text:create()
    useText:init(UI.TEXT_222712, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    useText:center()
    useLayout:addChild(useText)
    useLayout:setVisible(false)

    local unLockBtn = UI.Button:create();
    unLockBtn:init("ui_navigation_btn_2.png","ui_navigation_btn_2.png","ui_navigation_btn_2.png")
    unLockBtn:centerBottom(-50, 0)
    unLockBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    unLockBtn:setText(UI.TEXT_111169)
    unLockBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickUnlock)
    contentLayout:addChild(unLockBtn)
    self.unLockBtn = unLockBtn

    contentLayout:setTouchEnable(true)
    -- contentLayout:setInterceptTouches(true)
    contentLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, self.showInfoCell)
    self:updateCellInfo()
end

function ManorAppearanceShowCellView:updateCellInfo()
    local buildData
    print("updateCellInfo:", self.type)
    if self.type == "mannor" then
        local data = {}
        data = clone(GameInManorManager:getInstance():getManorSceneCommonData().commonData)--GameInManorManager:getInstance():getMannorBaseData()
        data.facades = GameInManorManager:getInstance():getMannorBaseData().facades
        buildData = data
    elseif self.type == "boat" then
        buildData = mvc.dockModel:getBoatData()
    else
        buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.data.type)
    end
    local iconList = string.split(self.data.icon, ";") 
    self.image:setSpriteName(iconList[1])
    local skinConfig = ConfigManager:getVirtualItemConfigByID(tonumber(self.data.ID))
    self.name:setText(skinConfig.name)
    if buildData.facadeId == 0 then
        self.unLockBtn:setVisible(self.data.isDefaultSkin ~= 1)
        self.lockImage:setVisible(self.data.isDefaultSkin == 1)
        self.useLayout:setVisible(self.data.isDefaultSkin == 1)
    elseif buildData.facadeId then
        self.unLockBtn:setVisible(buildData.facadeId ~= self.data.ID)
        self.lockImage:setVisible(buildData.facadeId == self.data.ID)
        self.useLayout:setVisible(buildData.facadeId == self.data.ID)
    end

    local isUnlock 
    if self.type == "boat" then
        isUnlock = mvc.dockModel:checkBoatIsUnlock(self.data.ID)
    else
        isUnlock = mvc.manorAppearanceModel:checkFacadeIsUnlock(self.data, buildData)
    end
    
    if isUnlock then
        self.unLockBtn:setText(UI.TEXT_111169)
    else
        self.unLockBtn:setText(UI.TEXT_222610)
    end
end

function ManorAppearanceShowCellView:updateCellInfoByGetNewFacade()
    local buildData

    if self.type == "mannor" then
        buildData = GameInManorManager:getInstance():getMannorBaseData()
    elseif self.type == "boat" then
        buildData = mvc.dockModel:getBoatData()
    else
        buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.data.type)
    end
    local iconList = string.split(self.data.icon, ";") 
    self.image:setSpriteName(iconList[1])
    local skinConfig = ConfigManager:getVirtualItemConfigByID(tonumber(self.data.ID))
    self.name:setText(skinConfig.name)

    if buildData.facadeId == 0 then
        self.unLockBtn:setVisible(self.data.isDefaultSkin ~= 1)
        self.lockImage:setVisible(self.data.isDefaultSkin == 1)
        self.useLayout:setVisible(self.data.isDefaultSkin == 1)
    elseif buildData.facadeId then
        self.unLockBtn:setVisible(buildData.facadeId ~= self.data.ID)
        self.lockImage:setVisible(buildData.facadeId == self.data.ID)
        self.useLayout:setVisible(buildData.facadeId == self.data.ID)
    end

    local isUnlock 
    if self.type == "boat" then
        isUnlock = mvc.dockModel:checkBoatIsUnlock(self.data.ID)
    else
        isUnlock = mvc.manorAppearanceModel:checkFacadeIsUnlock(self.data, buildData)
    end
    
    if isUnlock then
        self.unLockBtn:setText(UI.TEXT_111169)
    else
        self.unLockBtn:setText(UI.TEXT_222610)
    end
end

function ManorAppearanceShowCellView:showInfoCell()
    mvc.openPanel("ManorAppearance", "ManorAppearanceInfoCell", self.data)
end

function ManorAppearanceShowCellView:clickUnlock()
    local buildData
    local isUnlock 
    if self.type == "mannor" then
        buildData = GameInManorManager:getInstance():getMannorBaseData()
        isUnlock = mvc.manorAppearanceModel:checkFacadeIsUnlock(self.data, buildData)
    elseif self.type == "boat" then
        buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.data.type)
        isUnlock = mvc.dockModel:checkBoatIsUnlock(self.data.ID)
    else
        buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.data.type)
        isUnlock = mvc.manorAppearanceModel:checkFacadeIsUnlock(self.data, buildData)
    end
    
    if isUnlock then
        local map = GameInManorManager:getInstance():getBuildID2FunctionMap()
        local funtionID = map[self.data.type]
        local data = {
            buildId = self.data.type,
            facadeId = self.data.ID
        }
        -- local facadeId = self.data.isDefaultSkin == 1 and 0 or self.data.ID
        local facadeId = self.data.ID
        if self.type == "mannor" then   
            -- facadeId = self.data.isDefaultSkin == 1 and 0 or self.data.ID
            Net.NetManorSystem:reqChangeMannorFacade(facadeId)
        elseif self.type == "boat" then   
            if mvc.dockModel:isSailing() then
                UI.ScrollBar:createByText(UI.TEXT_222719)
                return
            end
            Net.NetManorSystem:reqChangeBoat(self.data.ID)
        else
            Net.NetManorSystem:reqChangeBuildFacade(self.data.type, facadeId)
        end
        
    else
        if self.data.isCanBuyWithDiamond == 0 then
            mvc.openPanel("ManorAppearance", "ManorAppearanceInfoCell", self.data)
        else
            local buyFacaTips = UI.Tips:createTips(string.format(UI.TEXT_222717, self.data.isCanBuyWithDiamond),UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
            buyFacaTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                local curDiamond = RoleDataManager:getMaster():getDiamond()
                if (Avalon.MathUtil:checkDiamonEnough(tonumber(self.data.isCanBuyWithDiamond), curDiamond)) then
                    if self.type == "mannor" then   
                        Net.NetManorSystem:reqBuyMannorFacade(self.data.ID)
                    elseif self.type == "boat" then   
                        Net.NetManorSystem:reqBuyBoatFacade(self.data.ID)
                    else
                        Net.NetManorSystem:reqBuyBuildFacade(self.data.ID)
                    end
                        
                else
                    UI.TipsLayer:onDiamondNotEnough()
                end
            end) 
        end
        
    end
end

-- function ManorAppearanceShowCellView:onChangeBuildFacade(data)
--     local map = GameInManorManager:getInstance():getBuildID2FunctionMap()
--     local funtionID = map[data.buildId]
--     local animeName --= self.data.spine
--     if data.facadeId ~= 0 then
--         local shapeConfig = ConfigManager:getAllOtherShapeDataByID(data.facadeId)
--         animeName = shapeConfig.replaceResource
--     else
--         local allShapeConfig = ConfigManager:getAllOtherShapeData()
--         local facadeId = 0
--         for k, v in pairs(shapeConfig) do
--             if v.isDefaultSkin == 1 then
--                 local shapeConfig = ConfigManager:getAllOtherShapeDataByID(k)
--                 animeName = shapeConfig.replaceResource
--             end
--         end
--         animeName = shapeConfig.replaceResource
--     end
--     GameInManorManager:getInstance():changeNPCSpine(funtionID, animeName)
-- end


function ManorAppearanceShowCellView:bindModel()

end


function ManorAppearanceShowCellView:unbindModel()

end





return ManorAppearanceShowCellView












