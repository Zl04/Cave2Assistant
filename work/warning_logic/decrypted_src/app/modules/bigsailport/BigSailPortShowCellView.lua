------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/16
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortShowCellView = class("BigSailPortShowCellView", UI.HWBtnComponent)
local GameInPortManager = require "app.game.GameInPortManager"
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
UI.BigSailPortShowCellView = BigSailPortShowCellView

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
}

-- 船只状态
-- 船只状态
local BigSailBoatStatus = PublicDefine.BigSailBoatStatus
-- local BigSailBoatStatus = 
-- {
--     None = 0,
--     BigSailBoating = 1, -- 大航海出海中
--     BigSailBoatingWaitFinish = 2, -- 航行完成等待占领
--     BigSailBoatingCaptured = 3,   -- 占领岛屿
-- }

local COM_WIDTH = 236
local COM_HEIGHT = 138

function BigSailPortShowCellView:ctor(data, facaType, isFightCell, isSupply)
    BigSailPortShowCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.type = facaType
    self.isFightCell = isFightCell
    self.isSupply = isSupply
    self.boatInfo = {}
    local bigSailPortBaseData = mvc.bigSailPortModel:getBaseData()
    for k,v in pairs(bigSailPortBaseData.useBoats) do
        if v.boatId == self.data.ID then
            self.boatInfo = v
        end
    end
    self:bindModel()
end

function BigSailPortShowCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailPortShowCellView.super.init(self, ... )
end

function BigSailPortShowCellView:dtor()
    BigSailPortShowCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailport.BigSailPortShowCellView")
end


function BigSailPortShowCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(30,15)
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
    round:init("ui_greatnavigation_supply.png")
    round:center(-73, -53)
    contentLayout:addChild(round)

    local useText2 = UI.Text:create()
    useText2:init(tostring(self.boatInfo.supplyAmount), UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 212, g = 177, b = 72})
    useText2:center(18,-1)
    round:addChild(useText2)

    -- 根据船只状态显示为在庄园出海中。航行或占领岛屿的船只——显示为占领岛屿中。空闲的船只——显示按钮【添加补给】
    local useText = UI.Text:create()
    useText:init(UI.TEXT_226108, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    useText:centerBottom(-50, 0)
    contentLayout:addChild(useText)
    if self.boatInfo.status == BigSailBoatStatus.None and not self.isFightCell and not self.isSupply then
        -- 显示按钮【添加补给】 / 派遣
        local str1 = self.data.dispatchBoat and UI.TEXT_226149 or UI.TEXT_226108
        local unLockBtn = UI.Button:create();
        unLockBtn:init("ui_navigation_btn_2.png","ui_navigation_btn_2.png","ui_navigation_btn_2.png")
        unLockBtn:centerBottom(-50, 0)
        unLockBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        unLockBtn:setText(str1)
        unLockBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickUnlock)
        unLockBtn:setSwallowTouches(false)
        contentLayout:addChild(unLockBtn)
        self.unLockBtn = unLockBtn
    -- elseif self.boatInfo.status == BigSailBoatStatus.BigSailBoating and not self.isFightCell then
    --     -- 大航海出海中
    --     useText:setVisible(true)
    --     useText:setText(UI.TEXT_226110)
    -- elseif self.boatInfo.status == BigSailBoatStatus.BigSailBoatingWaitFinish and not self.isFightCell then
    --     -- 航行完成等待占领
    --     useText:setVisible(true)
    --     useText:setText(UI.TEXT_226111)
    elseif self:isChangeIslandDispatch(useText) then
        -- -- 大航海出海中
        -- useText:setVisible(true)
        -- useText:setText(UI.TEXT_226110)
    elseif self.isFightCell then
        useText:setVisible(false)
        local unLockBtn = UI.Button:create();
        unLockBtn:init("ui_navigation_btn_2.png","ui_navigation_btn_2.png","ui_navigation_btn_2.png")
        unLockBtn:centerBottom(-50, 0)
        unLockBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        unLockBtn:setText(UI.TEXT_226215)
        unLockBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickFight)
        unLockBtn:setSwallowTouches(false)
        contentLayout:addChild(unLockBtn)
    elseif self.boatInfo.status == BigSailBoatStatus.None and not self.isFightCell and not self.isSupply then
        -- 显示按钮【派遣】
        local str1 = self.data.dispatchBoat and UI.TEXT_226149 or UI.TEXT_226108
        local unLockBtn = UI.Button:create();
        unLockBtn:init("ui_glyphs_btn_2.png","ui_glyphs_btn_2.png","ui_glyphs_btn_2.png")
        unLockBtn:centerBottom(-50, 0)
        unLockBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        unLockBtn:setText(str1)
        unLockBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickUnlock)
        unLockBtn:setSwallowTouches(false)
        contentLayout:addChild(unLockBtn)
        self.unLockBtn = unLockBtn
    elseif self.isSupply then
        -- 显示按钮【返航】
        local unLockBtn = UI.Button:create();
        unLockBtn:init("ui_glyphs_btn_2.png","ui_glyphs_btn_2.png","ui_glyphs_btn_2.png")
        unLockBtn:centerBottom(-50, 0)
        unLockBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        unLockBtn:setText(UI.TEXT_226900)
        unLockBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickReversal)
        unLockBtn:setSwallowTouches(false)
        contentLayout:addChild(unLockBtn)
        self.unLockBtn = unLockBtn
    else
        -- 占领岛屿
        useText:setVisible(true)
        useText:setText(UI.TEXT_226112)
    end

    self:showPetsHead()

    contentLayout:setTouchEnable(true)
    contentLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, self.showInfoCell)
    contentLayout:setSwallowTouches(false)
    self:updateCellInfo()
end

function BigSailPortShowCellView:showPetsHead()
    if self.petsLayout then
        self.contentLayout:removeChildByName("petsLayout")
    end
    -- 宠物船员面板
    local petsLayout = UI.Layout:create()
    petsLayout:init()
    petsLayout:setSize(335, 100)
    petsLayout:centerBottom(15)
    self.contentLayout:addChild(petsLayout, 5)
    petsLayout:setName("petsLayout")
    self.petsLayout = petsLayout

    local imageBg = UI.Image.create()
    imageBg:init("ui_greatnavigation_petsbox.png")
    imageBg:center(105, -5)
    petsLayout:addChild(imageBg)
    self.boatInfo.pets = self.boatInfo.pets or {}
    for k,v in pairs(self.boatInfo.pets) do
        if v and v ~= 0 then
            local bagPet = MasterDataManager:getBagPetById(v)
            local templateID = bagPet.templateID
            local config = ConfigManager:getPetDataByID(templateID)
            local iconStr = ""
            local strs = string.split(config.icon, ";")
            if bagPet.isVariant then
                iconStr = strs[2]
            else
                iconStr = strs[1]
            end

            local image = UI.Image.create()
            image:init((iconStr..".png"))
            image:center(0,-100 + k * 49)
            image:setScale(0.4)
            imageBg:addChild(image)
        end
    end
end

function BigSailPortShowCellView:clickUnlock()
    -- 超过时间关闭界面
    if mvc.bigSailPortModel:getIsPortClose() then
        mvc.closePanel("BigSailIsland", "BigSailIslandDispatch")
        mvc.closePanel("BigSailIsland", "BigSailIslandInfo")
        UI.ScrollBar:createByText(UI.TEXT_226216)
        return
    end


    if self.data.dispatchBoat then
        -- 发送派遣消息
        -- 判断船只是有满足派遣条件
        local boatId = self.data.ID
        local islandId = self.data.islandId
        if self:isAllowDispatch(self.data.ID, islandId) then
            -- 派遣船只id,要到的岛屿id
            local data = {}
            data.boatId = boatId
            data.islandId = islandId
            Net.NetBigSailSystem:reqSetSail(data)
        end
    else
        -- 发送船只补给页面打开消息
        local maxCount = ConfigManager:getAllNavigationGeneralConfigData()[1].boatSupplyMax
        local nowBoatNum = 0
        nowBoatNum = self.boatInfo.supplyAmount

        print("nowBoatNum-->: ", nowBoatNum)
        if nowBoatNum >= maxCount then
            UI.ScrollBar:createByText(UI.TEXT_226163)
            return
        end

        local nowSupplyNum = mvc.bigSailPortModel:getBaseData().supplyAmount
        if nowSupplyNum < maxCount then
            if nowSupplyNum + nowBoatNum < maxCount then
                maxCount = nowSupplyNum + nowBoatNum
            end
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SUPPLY, {
            nowNum = nowBoatNum,
            maxNum = maxCount,
            minNum = 0,
            type = "add",
            boatId = self.data.ID,
        })
    end

    -- -- 发送船只补给页面打开消息
    -- local maxCount = ConfigManager:getAllNavigationGeneralConfigData()[1].boatSupplyMax
    -- local nowBoatNum = 0
    -- nowBoatNum = self.boatInfo.supplyAmount
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SUPPLY, {
    --     nowNum = nowBoatNum,
    --     maxNum = maxCount,
    --     minNum = 0,
    --     type = "add",
    --     boatId = self.data.ID,
    -- })
    -- local buildData
    -- local isUnlock 
    -- if self.type == "mannor" then
    --     buildData = GameInManorManager:getInstance():getMannorBaseData()
    --     isUnlock = mvc.manorAppearanceModel:checkFacadeIsUnlock(self.data, buildData)
    -- elseif self.type == "boat" then
    --     buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.data.type)
    --     isUnlock = mvc.dockModel:checkBoatIsUnlock(self.data.ID)
    -- else
    --     buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.data.type)
    --     isUnlock = mvc.manorAppearanceModel:checkFacadeIsUnlock(self.data, buildData)
    -- end
    
    -- if isUnlock then
    --     local map = GameInManorManager:getInstance():getBuildID2FunctionMap()
    --     local funtionID = map[self.data.type]
    --     local data = {
    --         buildId = self.data.type,
    --         facadeId = self.data.ID
    --     }
    --     -- local facadeId = self.data.isDefaultSkin == 1 and 0 or self.data.ID
    --     local facadeId = self.data.ID
    --     if self.type == "mannor" then   
    --         -- facadeId = self.data.isDefaultSkin == 1 and 0 or self.data.ID
    --         Net.NetManorSystem:reqChangeMannorFacade(facadeId)
    --     elseif self.type == "boat" then   
    --         if mvc.dockModel:isSailing() then
    --             UI.ScrollBar:createByText(UI.TEXT_222719)
    --             return
    --         end
    --         Net.NetManorSystem:reqChangeBoat(self.data.ID)
    --     else
    --         Net.NetManorSystem:reqChangeBuildFacade(self.data.type, facadeId)
    --     end
        
    -- else
    --     if self.data.isCanBuyWithDiamond == 0 then
    --         mvc.openPanel("ManorAppearance", "ManorAppearanceInfoCell", self.data)
    --     else
    --         local buyFacaTips = UI.Tips:createTips(string.format(UI.TEXT_222717, self.data.isCanBuyWithDiamond),UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
    --         buyFacaTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
    --             local curDiamond = RoleDataManager:getMaster():getDiamond()
    --             if (Avalon.MathUtil:checkDiamonEnough(tonumber(self.data.isCanBuyWithDiamond), curDiamond)) then
    --                 if self.type == "mannor" then   
    --                     Net.NetManorSystem:reqBuyMannorFacade(self.data.ID)
    --                 elseif self.type == "boat" then   
    --                     Net.NetManorSystem:reqBuyBoatFacade(self.data.ID)
    --                 else
    --                     Net.NetManorSystem:reqBuyBuildFacade(self.data.ID)
    --                 end
                        
    --             else
    --                 UI.TipsLayer:onDiamondNotEnough()
    --             end
    --         end) 
    --     end
        
    -- end
end

function BigSailPortShowCellView:clickReversal()
    -- 返航
    local islandId = nil
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    for k, v in pairs(baseInfo.useBoats) do
        if v.boatId == self.data.ID then
            islandId = v.islandId
        end
    end

    local message = {}
    message.boatId = self.data.ID
    message.landId = islandId
    Net.NetBigSailSystem:reqCancelSail(message)

    UI.ScrollBar:createByText(UI.TEXT_226132)
    self.unLockBtn:removeEventListener(UIEvent.BUTTON_CLICK, self, self.clickReversal)
    self.unLockBtn:setText(UI.TEXT_226108)
    self.unLockBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickUnlock)
end

function BigSailPortShowCellView:createRichText()
    local textLayout = UI.Layout:create()
    textLayout:init()
    textLayout:setSize(354, 120)
    -- textLayout:enableDebugDraw()
    textLayout:center()

    local limitLayout = UI.Layout:create()
    limitLayout:init()
    limitLayout:center()
    textLayout:addChild(limitLayout)

    local longText = UI.Text:create()
    longText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    longText:centerUp(-30)
    longText:autoAdapt()
    longText:setWidth(280)
    --longText:hide()
    limitLayout:addChild(longText)

    local limitText = UI.Text:create()
    limitText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    limitText:centerUp(8)
    limitText:setWidth(354)
    limitText:hide()
    limitLayout:addChild(limitText)

    local limitImg = UI.Image:create()
    limitImg:init("ui_information_btn_yes.png")
    limitImg:center()
    limitImg:hide()
    limitLayout:addChild(limitImg)

    local str = ""
    if self.boatInfo.islandId > 0 then
        -- 岛屿名称
        -- 获取配置表里的基本岛屿信息
        local config = ConfigManager:getIslandsByID(self.boatInfo.islandId)
        local lslandName = languageManagerInstance:getLocalString(tonumber(config.name))
        str = string.format(UI.TEXT_226183, lslandName)
    end

    longText:setText(str)

    return textLayout
end

function BigSailPortShowCellView:isAllowDispatch(BoatId, isLand)
    -- 判断船只是否满足派遣条件
    local isAllow = false
    local baseInfo = mvc.bigSailPortModel:getBaseData()

    -- 判断船员是否满员
    for k,v in pairs(baseInfo.useBoats) do
        if v.boatId == BoatId then
            -- 船员满足人数条件
            for k,v in pairs(v.pets) do
                if v == 0 then
                    isAllow = false
                    UI.ScrollBar:createByText(UI.TEXT_226166)
                    return isAllow
                end
            end
            isAllow = true
        end
    end

    -- 判断船只补给是否为0
    for k,v in pairs(baseInfo.useBoats) do
        if v.boatId == BoatId then
            if v.supplyAmount == 0 then
                isAllow = false
                UI.ScrollBar:createByText(UI.TEXT_226175)
                return isAllow
            end
            isAllow = true
        end
    end

    -- 判断是否在公会中
    if GameDataManager:getInstance():getIsJoinGuild() then
        isAllow = true
    else
        isAllow = false
        UI.ScrollBar:createByText(UI.TEXT_226167)
        return isAllow
    end

    -- 判断是否对同一个岛屿派遣多只船
    for k,v in pairs(baseInfo.useBoats) do
        if v.islandId == isLand then
            isAllow = false
            UI.ScrollBar:createByText(UI.TEXT_226174)
            return isAllow
        else
            isAllow = true
        end
    end

    -- 判断是否达到派遣上限船只数量
    local limitMax = ConfigManager:getAllNavigationGeneralConfigData()[1].boatDispatchMax
    local boatHave = 0
    for k,v in pairs(baseInfo.useBoats) do
        if v.status ~= 0 then
            boatHave = boatHave + 1
        end
        if boatHave >= limitMax then
            isAllow = false
            UI.ScrollBar:createByText(UI.TEXT_226179)
            return isAllow
        else
            isAllow = true
        end
    end

    -- 判断派遣到当前岛屿时，是否战力满足上岛
    local powerMax = ConfigManager:getIslandsByID(isLand).powerLimit
    for k,v in pairs(baseInfo.useBoats) do
        if v.boatId == BoatId then
            -- 船员满足人数条件
            local nowPower = 0
            for k,v in pairs(v.pets) do
                local petData = MasterDataManager:getBagPetById(v)
                nowPower = nowPower + petData:getPower()
            end
            if powerMax > nowPower then
                isAllow = false
                local richTextLayout = string.format(UI.TEXT_226905, powerMax)
                local okCallBack = function ()
                end
                UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(richTextLayout, okCallBack, nil)
                return isAllow
            else
                isAllow = true
            end
        end
    end

    local supplyLimit = ConfigManager:getIslandsByID(isLand).supplyLimit
    if self.boatInfo and self.boatInfo.supplyAmount >= supplyLimit then
        isAllow = true
    else
        isAllow = false
        UI.ScrollBar:createByText(string.format(UI.TEXT_226188,supplyLimit))
    end

    return isAllow
end

function BigSailPortShowCellView:showInfoCell()
    if self.isFightCell then
        return 
    end

    if self.boatInfo.status ~= BigSailBoatStatus.None then
        UI.ScrollBar:createByText(UI.TEXT_226185)
        return
    end
    mvc.openPanel("BigSailPort", "BigSailPortSetPetCell", self.data)
end

function BigSailPortShowCellView:updateCellInfo()
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
    -- if buildData.facadeId == 0 then
    --     self.unLockBtn:setVisible(self.data.isDefaultSkin ~= 1)
    --     self.lockImage:setVisible(self.data.isDefaultSkin == 1)
    --     self.useLayout:setVisible(self.data.isDefaultSkin == 1)
    -- elseif buildData.facadeId then
    --     self.unLockBtn:setVisible(buildData.facadeId ~= self.data.ID)
    --     self.lockImage:setVisible(buildData.facadeId == self.data.ID)
    --     self.useLayout:setVisible(buildData.facadeId == self.data.ID)
    -- end

    local isUnlock 
    if self.type == "boat" then
        isUnlock = mvc.dockModel:checkBoatIsUnlock(self.data.ID)
    else
        isUnlock = mvc.manorAppearanceModel:checkFacadeIsUnlock(self.data, buildData)
    end
    
    -- if isUnlock then
    --     self.unLockBtn:setText(UI.TEXT_111169)
    -- else
    --     self.unLockBtn:setText(UI.TEXT_222610)
    -- end
end

function BigSailPortShowCellView:clickFight()
    local message = {}
    message.islandid = self.data.islandId
    message.boatid = self.data.ID

    Net.NetBigSailSystem:reqBossBattle(message)
end

function  BigSailPortShowCellView:isChangeIslandDispatch(useText)
    -- body
    if (self.boatInfo.status == BigSailBoatStatus.BigSailBoating or
        self.boatInfo.status == BigSailBoatStatus.BigSailBoatingWaitFinish or 
        self.boatInfo.status == BigSailBoatStatus.BigSailBoatingCaptured)
        and not self.isFightCell 
        and self.boatInfo.islandId ~= self.data.islandId 
        and self.data.islandId then
        -- 判断当前的船只所占领的岛屿是否和当前所打开的岛屿是同一个
        -- 若不是，则可以更改船只到当前岛屿上
        local changeBtn = UI.Button:create();
        changeBtn:init("ui_navigation_btn_2.png","ui_navigation_btn_2.png","ui_navigation_btn_2.png")
        changeBtn:centerBottom(-50, 0)
        changeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        changeBtn:setText(UI.TEXT_226182)
        changeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickChangeIsland)
        self.contentLayout:addChild(changeBtn)

        return true

    elseif self.boatInfo.status == BigSailBoatStatus.BigSailBoating and not self.isFightCell then
        -- 大航海出海中
        useText:setVisible(true)
        useText:setText(UI.TEXT_226110)
        return true
    elseif self.boatInfo.status == BigSailBoatStatus.BigSailBoatingWaitFinish and not self.isFightCell then
        -- 航行完成等待占领
        useText:setVisible(true)
        useText:setText(UI.TEXT_226111)
        return true
    end

    return false
end

function BigSailPortShowCellView:clickChangeIsland()
    --print(string.format("clickChangeIsland--->: %d,   %d", self.boatInfo.islandId, self.data.islandId))

    -- 判断派遣到当前岛屿时，是否战力满足上岛
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    local powerMax = ConfigManager:getIslandsByID(self.data.islandId).powerLimit
    for k,v in pairs(baseInfo.useBoats) do
        if v.boatId == self.boatInfo.boatId then
            -- 船员满足人数条件
            local nowPower = 0
            for k,v in pairs(v.pets) do
                local petData = MasterDataManager:getBagPetById(v)
                nowPower = nowPower + petData:getPower()
            end
            if powerMax > nowPower then
                local richTextLayout = string.format(UI.TEXT_226905, powerMax)
                local okCallBack = function ()
                end
                UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(richTextLayout, okCallBack, nil)
                return
            end
        end
    end


    local richTextLayout = self:createRichText()
    local okCallBack = function ()
        local supplyLimit = ConfigManager:getIslandsByID(self.data.islandId).supplyLimit
        if self.boatInfo.supplyAmount < supplyLimit then
            UI.ScrollBar:createByText(string.format(UI.TEXT_226188,supplyLimit))
            return
        end

        -- 派遣船只id,要到的岛屿id
        local data = {}
        data.fromIslandid = self.boatInfo.islandId
        data.toIslandid = self.data.islandId
        data.boatid = self.boatInfo.boatId

        if self.boatInfo.status == BigSailBoatStatus.BigSailBoatingCaptured then
            -- 已经占领岛屿了的船只发送CO消息
            Net.NetBigSailSystem:reqChangeIsland(data)
        else
            -- 正在航行中的船只发送CS消息
            Net.NetBigSailSystem:reqChangeIslandRunning(data)
        end
    end

    UI.TipsLayer:onShowCommonRichTextHandler(richTextLayout, okCallBack, nil, nil, false)
end

function BigSailPortShowCellView:bindModel()

end


function BigSailPortShowCellView:unbindModel()

end





return BigSailPortShowCellView












