------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 宠物背包公用面板
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetPacketLayer = class("PetPacketLayer", UI.BaseWin)

require "app.modules.pet.PetMainListCell"
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

UI.PetPacketLayer = PetPacketLayer

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_information.plist",
    "ui_common_scale9image.plist",
}

local COM_WIDTH = 420
local COM_HEIGHT = 510
local DUST_ID = 22070570

function PetPacketLayer:ctor()
    PetPacketLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REMOVE, self, self.petsUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SORT_LIST, self, self.sortList)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_DRAG_HIDE_SLOT_BEGAIN, self, self.hideSort)
end

function PetPacketLayer:init(rootLayer, ... )
    self.rootLayer = rootLayer

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetPacketLayer.super.init(self, ... )
end

function PetPacketLayer:dtor()
    PetPacketLayer.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REMOVE, self, self.petsUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SORT_LIST, self, self.sortList)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_DRAG_HIDE_SLOT_BEGAIN, self, self.hideSort)

    reload_script_file_mvc("app.modules.pet.PetPacketLayer")
end

function PetPacketLayer:hideSort(hidePets)
    printInfo("hideSort")
    local bagPets = clone(MasterDataManager:getBagPets())

    for _, v in pairs(hidePets) do
        for key, value in pairs(bagPets) do
            if v and value:getId() == v then
                table.remove(bagPets, key)
                break
            end
        end
    end

    local petData = {}
    petData.petsArr = bagPets
    petData.packetMinShowGridNum = 20
    self.petList:setData(petData)

    local scrollToCellIndex = 0
    for k, v in ipairs(petData.petsArr) do
        if v:isFight() then
            scrollToCellIndex = math.ceil(k/4)
        end
    end
    self.petList:scrollToCell(scrollToCellIndex, 3)
end

function PetPacketLayer:petsUpdate()
    printInfo("petsUpdate")
    local petData = {}
    petData.petsArr = clone(MasterDataManager:getBagPets())
    petData.packetMinShowGridNum = 20
    self.petList:setData(petData)

    local scrollToCellIndex = 0
    for k, v in ipairs(petData.petsArr) do
        if v:isFight() then
            scrollToCellIndex = math.ceil(k/4)
        end
    end
    self.petList:scrollToCell(scrollToCellIndex, 3)
end

function PetPacketLayer:sortList(petTemID, _petIDs)
    printInfo("sortList")
    local sortedPets = {}
    if petTemID then
        local allPets = MasterDataManager:getBagPets()
        for k, v in ipairs(allPets) do
            if v.templateID == petTemID or v.templateID == tonumber(ConfigManager:getGeneralForKey("PetCommonID")) then
                local find = false
                for m, n in ipairs(_petIDs) do
                    if v:getId() == n then
                        table.remove(_petIDs, m)
                        find = true
                        break
                    end
                end

                if not find then
                    table.insert(sortedPets, v)
                end
            end
        end
    else
        sortedPets = MasterDataManager:getBagPets()
    end

    local petData = {}
    petData.petsArr = sortedPets
    petData.packetMinShowGridNum = 20
    self.petList:setData(petData)

    local scrollToCellIndex = 0
    for k, v in ipairs(petData.petsArr) do
        if v:isFight() then
            scrollToCellIndex = math.ceil(k/4)
        end
    end
    self.petList:scrollToCell(scrollToCellIndex, 3)
end

function PetPacketLayer:onInitView()
    self.curPetListIdx = 0
    self.lastPetListIdx = 0
    self.petIDs = {}

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg  = UI.Image:create()
    bg:init("ui_pets_merge_bg.png")
    bg:center()
    self.contentLayout:addChild(bg)

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213680, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_202_168_128)
    titleTxt:setWidth(300)
    titleTxt:setTextCenter()
    titleTxt:autoAdapt()
    titleTxt:leftUp(58, 20)
    self.contentLayout:addChild(titleTxt)

    local petData = {}
    petData.petsArr = MasterDataManager:getBagPets()
    petData.packetMinShowGridNum = 20

    local petList = UI.PetList:create(4)
    self.petList = petList
    petList:init(petData)
    petList:center(0, 20)
    petList:setCallbackForGridClick(self, self.cellClickCallback)
    petList:setCallbackForGridDragBegan(self, self.dragBeganCallback)
    petList:setCallbackForGridDragMoved(self, self.dragMovedCallback)
    petList:setCallbackForGridDragEnded(self, self.dragEndedCallback)
    self.contentLayout:addChild(petList, 2)
    petList:showMask()

    local scrollToCellIndex = 0
    for k, v in ipairs(petData.petsArr) do
        if v:isFight() then
            scrollToCellIndex = math.ceil(k/4)
        end
    end
    self.petList:scrollToCell(scrollToCellIndex, 3)
end

function PetPacketLayer:getPetList()
    return self.petList
end

function PetPacketLayer:showSelectBtn()
    if not self.selectBtn then
        local selectBtn = UI.Button:create()
        selectBtn:init("ui_pets_conversion_chose_0.png","ui_pets_conversion_chose_1.png","ui_pets_conversion_chose_1.png")
        selectBtn:leftUp(12, 22)
        selectBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        selectBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            self:setSelectBtnClick()
        end)
        self.contentLayout:addChild(selectBtn)
        self.selectBtn = selectBtn
    end
    self.selectBtn:show()
end

function PetPacketLayer:hideSelectBtn()
    if self.selectBtn then
        self.selectBtn:hide()
        self.selectBtn:setNormal("ui_pets_conversion_chose_0.png")
    end

    self.deleteItemTable = {}

    self.deleteState = false
    self.petList:hideChoiceStatus()

    self.allCheckFlag = false

    if self.confirmLayout then
        self.confirmLayout:hide()
    end
end

function PetPacketLayer:setSelectBtnClick()
    if not self.deleteState then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_CLEAR_REFINE_SELECT)

        self.deleteState = true
        self.selectBtn:setNormal("ui_pets_conversion_chose_1.png")

        self.petList:showChoiceStatus()

        if not self.confirmLayout then
            local confirmLayout = UI.Layout:create();
            confirmLayout:init()
            confirmLayout:setSize(COM_WIDTH, 100)
            confirmLayout:centerBottom(-16)
            -- confirmLayout:enableDebugDraw()
            self.contentLayout:addChild(confirmLayout, 10)
            self.confirmLayout = confirmLayout

            local confirmBg = UI.Image:create()
            confirmBg:init("ui_pets_conversion_batch_banner.png")
            confirmBg:center()
            self.confirmLayout:addChild(confirmBg)

            local lineImg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_50%black.png", cc.rect(0,0,1,1))
            lineImg:setContentSize(cc.size(380, 1))
            lineImg:setPosition(cc.p(210, 80))
            self.confirmLayout:addChild(lineImg)

            local confirmBtn = UI.Button:create()
            confirmBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png")
            confirmBtn:center()
            confirmBtn:setText(UI.TEXT_1213605)
            confirmBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
            confirmBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                self:confirmSelect()
            end)
            self.confirmLayout:addChild(confirmBtn)
            self.confirmBtn = confirmBtn

            local allCheckBg = UI.Image:create()
            allCheckBg:init("ui_information_box.png")
            allCheckBg:rightBottom(90, 30)
            allCheckBg:setTouchEnable(true)
            allCheckBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
                self:allCheckBg()
            end)
            self.confirmLayout:addChild(allCheckBg)

            local checkImg = UI.Image:create()
            checkImg:init("ui_information_btn_yes.png")
            checkImg:center()
            allCheckBg:addChild(checkImg)
            self.checkImg = checkImg
            self.checkImg:hide()

            local checkText = UI.Text:create()
            checkText:init(UI.TEXT_1212580, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
            checkText:leftUp(28, 2)
            allCheckBg:addChild(checkText, 10)
        end
        self.confirmLayout:show()
        self.confirmBtn:disable()
        self:allCheckBg()
    else
        self.deleteState = false
        self.selectBtn:setNormal("ui_pets_conversion_chose_0.png")

        self.deleteItemTable = {}

        self.petList:hideChoiceStatus()

        self.allCheckFlag = false

        self.confirmLayout:hide()
    end
end

function PetPacketLayer:allCheckBg()
    self.deleteItemTable = {}
    self.disableCheckNum = 0
    local petData = {}
    petData.petsArr = clone(MasterDataManager:getBagPets())
    petData.packetMinShowGridNum = 20

    if not self.allCheckFlag then
        self.variantNum = 0

        self.allCheckFlag = true

        self.checkImg:show()

        for k, v in ipairs(petData.petsArr) do
            if self:getIsDisableCheck(v) then
                v.petGridData.disableCheck = true
                self.disableCheckNum = self.disableCheckNum + 1
            elseif v.isVariant then
                self.variantNum = self.variantNum + 1
                v.petGridData._isCheck = false
            else
                v.petGridData._isCheck = true
                table.insert(self.deleteItemTable, v)
            end
        end
    else
        self.allCheckFlag = false

        self.checkImg:hide()

        for k, v in ipairs(petData.petsArr) do
            if self:getIsDisableCheck(v) then
                self.disableCheckNum = self.disableCheckNum + 1
                v.petGridData.disableCheck = true
            else
                v.petGridData._isCheck = false
            end
        end
    end

    self.petList:setData(petData)

    if #self.deleteItemTable > 0 then
        self.confirmBtn:enable()
    else
        self.confirmBtn:disable()
    end
end

function PetPacketLayer:confirmSelect()
    local petNum = #self.deleteItemTable
    local dustNum = 0
    local goldNum = 0

    for _, v in ipairs(self.deleteItemTable) do
        dustNum = dustNum + tonumber(mvc.petModel:getRefineReturnDust(v:getId())[2])
        goldNum = goldNum + tonumber(mvc.petModel:getRefineReturnMoney(v:getId()))

        if(v) then 
            local arr = v:getWearEquipmentArr()
            if(arr and #arr > 0) then
                UI.ScrollBar:createByText(UI.TEXT_1325910)
                return 
            end
        end
    end

    -- 判断背包是否够用（粉尘必定占用一个格子）
    local awards = {}
    awards[1] = {goodsID = DUST_ID, num = tonumber(dustNum), isGolden = false}
    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(awards) then
        UI.ScrollBar:createByTextID(1170081)
        return
    end

    local textLayout = UI.Layout:create()
    textLayout:init()
    textLayout:setSize(354, 120)
    textLayout:center()

    local limitLayout = UI.Layout:create()
    limitLayout:init()
    limitLayout:center()
    textLayout:addChild(limitLayout)

    local longText = UI.Text:create()
    longText:init(string.format(UI.TEXT_1314062, petNum), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    longText:centerUp(8)
    longText:autoAdapt()
    longText:hide()
    limitLayout:addChild(longText)

    local limitText = UI.Text:create()
    limitText:init(string.format(UI.TEXT_1314062, petNum), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    limitText:centerUp(8)
    limitText:setWidth(354)
    limitText:hide()
    limitLayout:addChild(limitText)

    local limitImg = UI.Image:create()
    limitImg:init("ui_information_btn_yes.png")
    limitImg:center()
    limitImg:hide()
    limitLayout:addChild(limitImg)

    local promptText = UI.Text:create()
    promptText:init(string.format(UI.TEXT_1314062, petNum), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    promptText:centerUp(12)
    promptText:setWidth(354)
    promptText:setTextHorizontalCenter()
    textLayout:addChild(promptText)

    local content = AvalonUtil:serializeText(UI.TEXT_1314063, UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)
    content = content .. AvalonUtil:serializeImage("symbol_gaming_souldust.png")
    content = content .. AvalonUtil:serializeText(longText:numformat(tostring(dustNum)), UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)

    local textWidth = 0
    longText:setText(UI.TEXT_1314063)
    textWidth = textWidth + longText:getContentSize().width
    limitImg:setSpriteName("symbol_gaming_souldust.png")
    textWidth = textWidth + limitImg:getContentSize().width
    longText:setText(longText:numformat(tostring(dustNum)))
    textWidth = textWidth + longText:getContentSize().width

    local richtext = UI.RichText:create()
    local success = richtext:init(content, textWidth + 2, 28, false)
    if success then
        richtext:centerUp(50)
        textLayout:addChild(richtext)
    end

    local content = AvalonUtil:serializeText(UI.TEXT_1314063, UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)
    content = content .. AvalonUtil:serializeImage("symbol_gaming_money.png")
    content = content .. AvalonUtil:serializeText(longText:numformat(tostring(goldNum)), UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)

    local textWidth = 0
    longText:setText(UI.TEXT_1314063)
    textWidth = textWidth + longText:getContentSize().width
    limitImg:setSpriteName("symbol_gaming_money.png")
    textWidth = textWidth + limitImg:getContentSize().width
    longText:setText(longText:numformat(tostring(goldNum)))
    textWidth = textWidth + longText:getContentSize().width

    local richtext = UI.RichText:create()
    local success = richtext:init(content, textWidth + 2, 28, false)
    if success then
        richtext:centerUp(82)
        textLayout:addChild(richtext)
    end

    limitLayout:removeFromParent(false)

    UI.TipsLayer:onShowCommonRichTextHandler(
        textLayout,
        function()
            local petId = {}
            for _, v in pairs(self.deleteItemTable) do
                table.insert(petId, v:getId())
            end

            Net.NetPetSystem:multipleRefine(petId)

            self:setSelectBtnClick()
        end
    )
end

function PetPacketLayer:cellClickCallback(grid, touchPosition)
    local gridData = grid:getData()
    if not grid:isUsed() then
        return
    end

    if self._isDraging then
        return
    end

    if self.deleteState == true then
        if gridData and not gridData.petGridData.disableCheck then
            if gridData.petGridData._isCheck then
                table.insert(self.deleteItemTable, gridData)
            else
                for index = #self.deleteItemTable, 1, -1 do 
                    if self.deleteItemTable[index]:getId() == gridData:getId() then
                        table.remove(self.deleteItemTable, index)
                    end
                end
            end
        end

        if #self.deleteItemTable > 0 then
            self.confirmBtn:enable()
        else
            self.confirmBtn:disable()
        end

        if #self.deleteItemTable + self.disableCheckNum + self.variantNum >= #clone(MasterDataManager:getBagPets()) then
            self.allCheckFlag = true
            self.checkImg:show()
        else
            self.allCheckFlag = false
            self.checkImg:hide()
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_BRIEF_INFO, gridData:getId(), false)
end

function PetPacketLayer:dragBeganCallback(grid, touchPosition)
    printInfo("PetPacketLayer:dragBeganCallback")
    if not grid then
        return
    end
    local gridData = grid:getData()

    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_DRAG_PET_SLOT_BEGAIN, gridData:getId(), touchPosition.x, touchPosition.y)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_BRIEF_INFO)
    self._isDraging = true
end

function PetPacketLayer:dragEndedCallback(grid, touchPosition)
    -- printInfo("PetPacketLayer:dragEndedCallback")
    self._isDraging = false
    if not grid then
        return
    end

    self:cellClickCallback(grid)

    local gridData = grid:getData()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_DRAG_PET_SLOT_END, gridData:getId(), touchPosition.x, touchPosition.y)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_BRIEF_INFO)

    if self.deleteState then
        local pos = self.contentLayout:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
        local size = self.contentLayout:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        if not cc.rectContainsPoint(rect, pos) then
            self:setSelectBtnClick()
        end
    end
end

function PetPacketLayer:getIsDisableCheck(pet)
    if pet:getLevel() ~= 1 or 
    pet:getCurExp() > 0 or 
    pet:isFight() or 
    pet:getPetQuality() > 2 or 
    pet.templateID == tonumber(ConfigManager:getGeneralForKey("PetCommonID")) then
        return true
    else
        return false
    end
end

function PetPacketLayer:bindModel()

end

function PetPacketLayer:unbindModel()

end

return PetPacketLayer
