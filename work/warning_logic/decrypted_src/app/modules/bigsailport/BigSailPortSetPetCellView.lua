------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/19
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortSetPetCellView = class("BigSailPortSetPetCellView", UI.HWBtnComponent)
local PortPetPacketLayer = require("app.modules.bigsailport.PortPetPacketLayer")
local GameDataManager = require("app.game.GameDataManager")
require "app.modules.bigsailport.BigSailSeamanLayer"
require "app.datas.MasterDataManager"

-- 资源
local COM_RES_LIST = {
    "ui_common_information.plist",
}

-- 船只状态
local BigSailBoatStatus = 
{
    None = 0,
    BigSailBoating = 1, -- 大航海出海中
    BigSailBoatingWaitFinish = 2, -- 航行完成等待占领
    BigSailBoatingCaptured = 3,   -- 占领岛屿
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 852
local COM_HEIGHT = 534

function BigSailPortSetPetCellView:ctor(data)
    BigSailPortSetPetCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.data = data
    self.newestPets = nil
end

function BigSailPortSetPetCellView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailPortSetPetCellView.super.init(self, ... )
end

function BigSailPortSetPetCellView:dtor()
    self:sendReqSetBoatPets()

    BigSailPortSetPetCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailport.BigSailPortSetPetCellView")
end

function BigSailPortSetPetCellView:sendReqSetBoatPets()
    -- 判断船只是有满足派遣条件
    local data = {}
    local pets = {}
    local cellList = self.seamanSideBar:getSeamanCellList()
    for k,v in pairs(cellList) do
        local seamanCell = v:getChildByName("seamanCell")
        local petData = seamanCell:getPetData()
        if petData then
            pets[k] = petData.spriteID
        else
            pets[k] = 0
        end
    end
    data.boatId = self.data.ID
    data.petId = pets
    Net.NetBigSailSystem:reqSetBoatPets(data)
end

function BigSailPortSetPetCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(300, 0)
    self:addChild(contentLayout, 5)
    self.contentLayout = contentLayout

    -- 解锁条件面板
    local unlockLayout = UI.Layout:create()
    unlockLayout:init()
    unlockLayout:setSize(335, 100)
    unlockLayout:centerBottom(15)
    contentLayout:addChild(unlockLayout, 5)
    self.unlockLayout = unlockLayout

    -- 效果描述面板
    local effectLayout = UI.Layout:create()
    effectLayout:init()
    effectLayout:setSize(345, 70)
    effectLayout:center(0, 80)
    contentLayout:addChild(effectLayout, 5)
    self.effectLayout = effectLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local bg = UI.Image.create()
    bg:init("ui_navigation_popups_2.png")
    bg:center()
    contentLayout:addChild(bg)

    local frame = UI.Image.create()
    frame:init("ui_navigation_floorbg_2.png")
    frame:centerUp(85)
    contentLayout:addChild(frame, 10)

    local decorate = UI.Image.create()
    decorate:init("ui_navigation_floorbg_up.png")
    decorate:rightBottom(12, 10)
    frame:addChild(decorate)
    self.frame = frame

    local image = UI.Image.create()
    image:init("")
    image:rightBottom(-7, 10)
    frame:addChild(image)
    self.image = image

    local name = UI.Text:create()
    name:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_204_204_204)
    name:centerUp(40)
    contentLayout:addChild(name)
    self.name = name

    local boatStatus = UI.Text:create()
    boatStatus:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 240, g = 168, b = 168})
    boatStatus:centerUp(40)
    contentLayout:addChild(boatStatus)
    self.boatStatus = boatStatus

    -- -- 临时按钮，将设置好了的船员的船只随机派遣
    -- local dispatch = UI.Button:create()
    -- dispatch:init("ui_distortedSpace_saodang_sign_01.png","ui_distortedSpace_saodang_sign_01.png","ui_distortedSpace_saodang_sign_01.png")
    -- dispatch:leftUp(100, 550)
    -- dispatch:setText("派遣船只")
    -- dispatch:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- dispatch:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     -- 判断船只是有满足派遣条件
    --     local boatId = self.data.ID
    --     local islandId = 23
    --     --local petShopData = ConfigManager:getAllIslandsData()
    --     --local islandId = math.random(2, #petShopData)
    --     if self:isAllowDispatch(self.data.ID, islandId) then
    --         -- 派遣船只id,要到的岛屿id
    --         local data = {}
    --         data.boatId = boatId
    --         data.islandId = islandId
    --         Net.NetBigSailSystem:reqSetSail(data)
    --         -- -- 判断下派遣的时候，玩家是否在工会中
    --         -- if GameDataManager:getInstance():getIsJoinGuild() then
    --         --     Net.NetBigSailSystem:reqSetSail(data)
    --         -- else
    --         --     UI.ScrollBar:createByText("不在公会中")
    --         -- end
    --     end
    -- end)
    -- contentLayout:addChild(dispatch)

    -- -- 临时按钮，设置船员
    -- local dispatch2 = UI.Button:create()
    -- dispatch2:init("ui_distortedSpace_saodang_sign_01.png","ui_distortedSpace_saodang_sign_01.png","ui_distortedSpace_saodang_sign_01.png")
    -- dispatch2:leftUp(200, 550)
    -- dispatch2:setText("设置船员")
    -- dispatch2:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- dispatch2:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     -- 判断船只是有满足派遣条件
    --     local data = {}
    --     local pets = {}
    --     local cellList = self.seamanSideBar:getSeamanCellList()
    --     for k,v in pairs(cellList) do
    --         local seamanCell = v:getChildByName("seamanCell")
    --         local petData = seamanCell:getPetData()
    --         if petData then
    --             pets[k] = petData.spriteID
    --         else
    --             pets[k] = 0
    --         end
    --     end
    --     data.boatId = self.data.ID
    --     data.petId = pets
    --     Net.NetBigSailSystem:reqSetBoatPets(data)
    --     --self.newestPets = pets
    -- end)
    -- contentLayout:addChild(dispatch2)

    -- -- 临时按钮，取消占领岛屿
    -- local dispatch3 = UI.Button:create()
    -- dispatch3:init("ui_distortedSpace_saodang_sign_01.png","ui_distortedSpace_saodang_sign_01.png","ui_distortedSpace_saodang_sign_01.png")
    -- dispatch3:leftUp(300, 550)
    -- dispatch3:setText("取消占领")
    -- dispatch3:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- dispatch3:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     local landId = self:isAllowCancleSail(self.data.ID)
    --     --if landId == 0 then
    --         --UI.ScrollBar:createByText("不在岛屿中")
    --     --else
    --         local data = {}
    --         data.boatId = self.data.ID
    --         data.landId = landId
    --         Net.NetBigSailSystem:reqCancelSail(data)
    --     --end

    -- end)
    -- contentLayout:addChild(dispatch3)

    -- -- 临时按钮，一键加速
    -- local dispatch4 = UI.Button:create()
    -- dispatch4:init("ui_distortedSpace_saodang_sign_01.png","ui_distortedSpace_saodang_sign_01.png","ui_distortedSpace_saodang_sign_01.png")
    -- dispatch4:leftUp(400, 550)
    -- dispatch4:setText("一键加速")
    -- dispatch4:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- dispatch4:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     local landId = self:isAllowSpeedUp(self.data.ID)
    --     local data = {}
    --     data.boatId = self.data.ID
    --     data.landId = landId

    --     if landId == 0 then
    --         UI.ScrollBar:createByText("无法加速，船只在港口中")
    --     else
    --         mvc.openPanel("BigSailPort", "BigSailPortSpeedUp", data)
    --     end
    -- end)
    -- contentLayout:addChild(dispatch4)

    -- 左侧拖动船员界面
    self:updateByData()
    -- 右侧刷新船员界面
    self:updateCellInfo()

    -- 刷新当前船只状态
    --self:refreshNowBoatStatue()
end

function BigSailPortSetPetCellView:updateCellInfo()
    local skinConfig = ConfigManager:getVirtualItemConfigByID(tonumber(self.data.ID))
    local iconList = string.split(self.data.icon, ";") 
    self.image:setSpriteName(iconList[2])
    self.name:setText(skinConfig.name)

    -- local unlockDesList = string.split(self.data.unlockDesc, ",")
    -- for k ,v in pairs(unlockDesList) do
    --     local unlockDesStr = string.format(UI.TEXT_222714, languageManagerInstance:getLocalString(tonumber(v))) 
    --     local unlockDes = UI.Text:create()
    --     unlockDes:init(unlockDesStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    --     unlockDes:setSize(250, 25)
    --     unlockDes:setTextLeft()
    --     unlockDes:center(20, 35*(k-1)-30)
    --     unlockDes:setFixLineWidth(265)
    --     self.unlockLayout:addChild(unlockDes)
    -- end

    local effectDesList = string.split(self.data.effectDesc, ",")
    for k ,v in pairs(effectDesList) do
        local image = UI.Image.create()
        image:init("ui_navigation_square.png")
        image:center(-110, 30*(k-1)-20)
        self.effectLayout:addChild(image)

        local effectDesStr = string.format(UI.TEXT_222713, languageManagerInstance:getLocalString(tonumber(v))) 
        local effectDes = UI.Text:create()
        effectDes:init(effectDesStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        effectDes:setSize(250, 25)
        effectDes:setTextLeft()
        effectDes:center(35, 30*(k-1)-20)
        self.effectLayout:addChild(effectDes)
    end

    local animeName = self.data.spine
    if animeName and animeName ~="" then
        local previewAnime = UI.Animation:create()
        previewAnime:init(animeName..".json", animeName..".atlas", 1);
        previewAnime:center(-100, 60)
        self.frame:addChild(previewAnime, 101)
        previewAnime:setAnimation("idle3", true)
        previewAnime:setScale(0.7)
    end

    self:addSeamanEmbattling()
end

-- 挂上任务快捷栏
function BigSailPortSetPetCellView:addSeamanEmbattling()
    local seamanSideBar = UI.BigSailSeamanLayer:create(self.data.ID)
    seamanSideBar:init()
    seamanSideBar:center(0, 100)
    self.effectLayout:addChild(seamanSideBar, 400)
    self.seamanSideBar = seamanSideBar
end

function BigSailPortSetPetCellView:updateByData()
    local bagPets = mvc.bigSailPortModel:getPacketPets(true,self.data.ID)
    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        packetLayer:show()
        local petArr = bagPets
        packetLayer:updateByData(petArr)
    else
        local petArr = bagPets
        local packetLayer = PortPetPacketLayer:create()
        packetLayer:init(petArr)
        --packetLayer:init(petArr, "DockSailLayer")
        packetLayer:center(-500, 0)
        packetLayer:setName("packetLayer")
        self.contentLayout:addChild(packetLayer, 400)
    end
end

function BigSailPortSetPetCellView:slotDragEnd(data)
    if self.seamanSideBar then
        self.seamanSideBar:slotDragEnd(data)
    end

    self:refreshPetBagView()
end

function BigSailPortSetPetCellView:refreshPetBagView()
    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        local petArr = mvc.bigSailPortModel:getPacketPets(false,self.data.ID)
        packetLayer:updateByData(petArr)
    end
end

function BigSailPortSetPetCellView:refreshPacketAndSlot(data)
    self:slotDragEnd(data)
end

function BigSailPortSetPetCellView:isAllowDispatch(BoatId, isLand)
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
            UI.ScrollBar:createByText(UI.TEXT_226168)
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

    return isAllow
end

function BigSailPortSetPetCellView:isAllowCancleSail(BoatId)
    -- 判断船只是否满足取消占领条件,返回占领岛屿id(为0则表示没有占领岛屿)
    local landId = 0
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    for k,v in pairs(baseInfo.useBoats) do
        if v.boatId == BoatId and v.status == BigSailBoatStatus.BigSailBoatingCaptured then
            landId = v.islandId
            return landId
        end
    end

    return landId
end

function BigSailPortSetPetCellView:isAllowSpeedUp(BoatId)
    -- 判断船只是否满足一键加速条件,返回占领岛屿id(为0则表示没有占领岛屿)
    local landId = 0
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    for k,v in pairs(baseInfo.useBoats) do
        if v.boatId == BoatId and v.status == BigSailBoatStatus.BigSailBoating then
            landId = v.islandId
            return landId
        end
    end

    return landId
end

function BigSailPortSetPetCellView:refreshNowBoatStatue()
    local status = 0
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    for k,v in pairs(baseInfo.useBoats) do
        if v.boatId == self.data.ID then
            status = v.status
            break
        end
    end

    if status == BigSailBoatStatus.None then
        self.boatStatus:setText(UI.TEXT_226109)
    elseif status == BigSailBoatStatus.BigSailBoating then
        self.boatStatus:setText(UI.TEXT_226110)
    elseif status == BigSailBoatStatus.BigSailBoatingWaitFinish then
        self.boatStatus:setText(UI.TEXT_226111)
    else
        self.boatStatus:setText(UI.TEXT_226112)
    end
end

function BigSailPortSetPetCellView:successSyncBaseInfo()
    -- local baseInfo = mvc.bigSailPortModel:getBaseData()
    -- for k,v in pairs(baseInfo.useBoats) do
    --     if v.boatId == self.boatId then
    --         -- 设置船员成功后刷新基础信息。
    --         baseInfo.useBoats[k].pets = self.newestPets
    --         mvc.bigSailPortModel:saveBaseData(self.baseData)
    --         -- 提示设置成功
    --         UI.ScrollBar:createByText(UI.TEXT_1213795)
    --     end
    -- end
end

function BigSailPortSetPetCellView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_SYNC_REFRESH_BOAT_INFO, self, self.refreshPacketAndSlot)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_SYNC_REFRESH_BAG_PETS, self, self.refreshPetBagView)
end

function BigSailPortSetPetCellView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_SYNC_REFRESH_BOAT_INFO, self, self.refreshPacketAndSlot)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_SYNC_REFRESH_BAG_PETS, self, self.refreshPetBagView)
end

return BigSailPortSetPetCellView