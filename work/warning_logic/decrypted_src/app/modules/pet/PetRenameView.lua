------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/31
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")
local PetRenameView = class("PetRenameView", UI.HWBtnComponent)

require "app.utils.ToolsUtil"

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_common_scale9image.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_common_symbol.plist",
}

local COM_WIDTH = 430
local COM_HEIGHT = 290
local winSize = cc.Director:getInstance():getWinSize()

function PetRenameView:ctor(petID)
    PetRenameView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.petID = petID
end

function PetRenameView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetRenameView.super.init(self, ... )
end

function PetRenameView:dtor()
    PetRenameView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetRenameView")
end

function PetRenameView:onInitView()
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box2.png")
    bg:setCapInsets(CCRectMake(190,96,5,5))
    bg:setContentSize(COM_WIDTH, COM_HEIGHT)
    bg:setAnchorPoint(cc.p(0.5, 0.5))
    bg:setPosition(cc.p(COM_WIDTH / 2, COM_HEIGHT / 2))
    self:addChild(bg, 1)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local titleText = UI.Text:create() 
    titleText:init(UI.TEXT_1213728, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(25)
    bg:addChild(titleText)

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light2.png")
    line:setContentSize(375, 2)
    line:setAnchorPoint(cc.p(0, 0.5))
    line:setPosition(cc.p(24, 217))
    bg:addChild(line)

    -- 输入
    local libIDEdit = UI.EditBox:create(320, 61)
    libIDEdit:init("", cc.EDITBOX_INPUT_MODE_SINGLELINE, "ui_activity_banner_mailbox.png", 21, 14)
    libIDEdit:leftUp(self:getContentSize().width / 2 - 164, 110)
    bg:addChild(libIDEdit)
    libIDEdit:setFontSize(20)
    libIDEdit:setFontColor(UI.FONT_COLOR_155_155_155)
    libIDEdit:setChangeCallback(function()
        self:judeInputTextLength(self.libIDEdit:getText())
    end)
    libIDEdit:setReturnCallback(function()
        self:checkEditorText()
    end)
    libIDEdit:setEditEndedCallback(function()
        self:checkEditorText()
    end)
    self.libIDEdit = libIDEdit

    local confirmBtn = UI.Button:create()
    confirmBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
    confirmBtn:centerBottom(30)
    confirmBtn:closeClickScale()
    confirmBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self:checkEditorText() then
            local func = function(nameStr)
                local newName = nameStr or ""--self.libIDEdit:getText()

                if Avalon.MathUtil:checkDiamonEnough(tonumber(self.costDiamond), GameDataManager:getInstance():getDiamond()) then
                    Net.NetPetSystem:requestPetRename(self.petID, newName)
                else
                    -- 钻石不足
                    local tips = UI.TipsLayer:onDiamondNotEnough()
                    if(tips) then 
                        tips:setZOrder(UI_ZORDER.MAX)
                    end
                    tips:removeFromParent(false)
                    UI.UIManager:getRootNode():addChild(tips)
                end  
                mvc.closePanel("Pet", "PetRename")
            end

            local gameWordDetectionManager = require"app.game.GameWordDetectionManager"
            local nickName = self.libIDEdit:getText() or ""
            confirmBtn:disable()
            gameWordDetectionManager:getInstance():nicknameDetection(nickName,func,function()
                confirmBtn:enable()
            end)

        end
    end)
    bg:addChild(confirmBtn)

    local priceLayout = UI.Layout:create()
    priceLayout:init()
    priceLayout:enableAutoWidth()
    priceLayout:enableAutoHeight()
    priceLayout:center()
    confirmBtn:addChild(priceLayout, 1000)

    local diamond = UI.Image:create()
    diamond:init("symbol_gaming_diamond.png")
    diamond:floatLeft(0)
    priceLayout:addComponent(diamond)

    local diamondNum = UI.Text:create()
    diamondNum:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    diamondNum:floatLeft(4)
    priceLayout:addComponent(diamondNum)

    local cost = string.split(ConfigManager:getGeneralForKey("PetChangeNameCost"), ",")
    local curPet = MasterDataManager:getBagPetById(self.petID)
    local nametime = curPet:getNameTimes()
    if nametime + 1 <= #cost then
        self.costDiamond = cost[nametime + 1]
    elseif nametime + 1 > #cost then
        nametime = #cost
        self.costDiamond = cost[nametime]
    end
    diamondNum:setText(self.costDiamond)
end


function PetRenameView:checkEditorText()
    local text = self.libIDEdit:getText()
    if not text then
        text = ""
    end

    if AvalonUtil:isEmoji(text) then
        UI.ScrollBar:createByText(UI.TEXT_1170936)
        return false
    end

    text = ToolsUtil:replaceNameStr(text)

    local formatStr, mark = ToolsUtil:checkMaskword(text)
    if mark then
        UI.ScrollBar:createByText(UI.TEXT_1170415)
        self.libIDEdit:setText(formatStr)
        -- 即使有非法输入，替换完后仍然继续发送
        return true
    else
        local msg = self:judeInputTextLength(formatStr)
        self.libIDEdit:setText(msg)
        return true
    end
end

function PetRenameView:judeInputTextLength(message)
    local isHave = string.find(message, "\n")
    if isHave ~= nil then
        message = string.gsub(message, "\n", "")
        self.libIDEdit:setText(message)
        return message
    end

    if AvalonUtil:isUpLimiteStr(message, 145, 18) then
        message = AvalonUtil:getSubNameStrByLabel(message, 145, 18)
        self.libIDEdit:setText(message)
        UI.ScrollBar:createByText(UI.TEXT_1170311)
        return message
    end

    return message
end

function PetRenameView:bindModel()

end


function PetRenameView:unbindModel()

end





return PetRenameView












