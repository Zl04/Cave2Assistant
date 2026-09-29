-- CreateGuild.lua
-- Author:zp
-- 2017年9月13日
-- Using:创建公会

require("app.ui.guild.ChoiceGuildIconPanel")

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local CreateGuild = class("CreateGuild", UI.HWBtnComponent)
UI.CreateGuild = CreateGuild

local winSize = cc.Director:getInstance():getWinSize()

local LAYOUT_DESIGN_WIDTH = 537
local LAYOUT_DESIGN_HEIGHT = 372

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_guild_icon.plist",
    "ui_town_guild_icon.plist"
}

--构造函数(必备)
function CreateGuild:ctor()
	--窗口大小
    CreateGuild.super.ctor(
    self,UIType.CREATE_GUILD,
    COM_RES_LIST,
    LAYOUT_DESIGN_WIDTH,	
    LAYOUT_DESIGN_HEIGHT
    )

    self._icon = nil
    self._choiceIconID = nil
    self._guildNameEdit = nil
    self._preNum = 0
    self._waitingInput = false

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init()
    self:registerListener()
end

--虚构函数,destroy时调用(必备)
function CreateGuild:dtor()
    CreateGuild.super.dtor(self)
    self:unRegisterListener()
    self._waitingInput = false
end

-- 初始化(必备)
function CreateGuild:init()
    CreateGuild.super.init(self)

end

-- 模版函数：初始化组建的视图(必备)
function CreateGuild:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    -- contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 添加背景
    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box2.png")
    bg:center()
    self._contentLayout:addChild(bg)

    -- 公会图标
    -- TODO 随机一个图标
    local iconList = ConfigManager:getGuildIconList()
    dump(iconList)
    local userArr = {}
    for k, v in pairs(iconList) do 
        if(tonumber(v.iconCost) == 0) then
            table.insert(userArr, v)
        end
    end
    
    local index = math.random(1, #userArr)
    local iconConfig = userArr[index]
    self._choiceIconID = iconConfig.iconID

    local iconBg = UI.Image:create()
    iconBg:init("ui_guild_headframe_big.png")
    bg:addChild(iconBg)

    local icon = UI.Image:create()
    icon:init(iconConfig.iconSpriteName)
    icon:center()
    icon:setTouchEnable(true)
    icon:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        -- 处理选择公会图标
        self:choiceGuildIcon()
    end)
    iconBg:addChild(icon)
    self._icon = icon

    iconBg:centerBottom(220 + icon:getContentSize().height/2 - iconBg:getContentSize().width/2)

    -- 文本输入框
    local searcheBG = UI.Image:create()
    searcheBG:init("ui_guild_create_banner_search2.png")
    searcheBG:centerBottom(114)
    bg:addChild(searcheBG)

    -- 输入文字框
    local searchEdit = cc.EditBox:create({width = 301, height = 23}, "placeholder.png")
    searchEdit:setFontSize(18)
    searchEdit:setPlaceHolder(LanguageManager:getInstance():getLocalString(1110516))
    searchEdit:setPlaceholderFontSize(18)
    searchEdit:setPlaceholderFontColor(UI.FONT_COLOR_77_77_84)
    searchEdit:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
    searchEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    searchEdit:setFontColor(UI.FONT_COLOR_41_41_45)
    searchEdit:setPosition(12 + 301/2, 31 - 2)
    searcheBG:addChild(searchEdit)
    searchEdit:registerScriptEditBoxHandler(handler(self, self.editboxHandle))

    self._guildNameEdit = searchEdit

    local diamonForCreation = ConfigManager:getDiamondForCreation()
    local master = GameDataManager:getInstance():getMaster()

    -- 创建按钮
    local createButton = UI.Button:create()
    createButton:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
    createButton:centerBottom(41)
    createButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        if(not Avalon.MathUtil:checkDiamonEnough(diamonForCreation, master:getDiamond())) then
            UI.TipsLayer:onDiamondNotEnough()
        else
            -- 处理点击创建公会
            self:createGuild()
        end
    end)
    self._contentLayout:addChild(createButton)
    self._createButton = createButton

    local createLabel = UI.Text:create()
    createLabel:init(LanguageManager:getInstance():getLocalString(1110517), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    createLabel:centerLeft(5)
    createLabel:setSize(116-10, 0)
    createLabel:setTextHorizontalCenter()
    createButton:addChild(createLabel, 10)
    self._createLabel = createLabel

    self:refreshCreateButton()
    
    -- 钻石图标
    local priceIcon = UI.Image:create()
    priceIcon:init("symbol_gaming_diamond.png")
    priceIcon:centerLeft(116)
    createButton:addChild(priceIcon, 10)
    -- self._contentLayout:addChild(priceIcon)

    -- 价格数量
    local priceLabel = UI.Text:create()
    priceLabel:init(tostring(diamonForCreation), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    priceIcon:addChild(priceLabel, 10)
    self._priceLabel = priceLabel
    local jiange =4
    priceLabel:centerLeft(priceIcon:getContentSize().width + jiange)
    
    
    self._contentLayout:setTouchEnable(true)
    self._contentLayout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        print("CreateOrJoinPanel:onInitView self._contentLayout COMPONENT_TOUCH_OUTSIDE")
        if(self._waitingInput == false) then
            self:exitCreateGuild()
        end
    end)
end

-- 模版函数：更新组建的视图(必备)
function CreateGuild:onUpdateView()
    local diamonForCreation = ConfigManager:getDiamondForCreation()
    -- 判断钻石数量是否够用，来显示价格的文字
    local master = GameDataManager:getInstance():getMaster()
    if(not Avalon.MathUtil:checkDiamonEnough( diamonForCreation, master:getDiamond())) then 
        self._priceLabel:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    else 
        self._priceLabel:setFontColor(UI.FONT_COLOR_50_50_44)
    end
end

function CreateGuild:editboxHandle(strEventName, sender)
    -- print("CreateGuild:editboxHandle", strEventName, sender)
    
    if(strEventName == "began") then

    elseif (strEventName == "ended") then

    elseif (strEventName == "return") then
        local message = self._guildNameEdit:getText() or ""
        -- print("CreateGuild:editboxHandle  0", message, type(message))

        if AvalonUtil:isEmoji(message) then
            UI.ScrollBar:createByText(UI.TEXT_1170936)
            return
        end

        -- message = string.trim(message)
        message = ToolsUtil:replaceNameStr(message)
        
        -- 处理敏感字
        local mark = false
        message = ToolsUtil:roleNameFilter(message)
        message,mark = ToolsUtil:checkMaskword(message)
        if mark then
            UI.ScrollBar:createByText(UI.TEXT_1170415)
        end

        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
        end

        if AvalonUtil:isUpLimiteStr(message, 160, 22) then
            message = AvalonUtil:getSubNameStrByLabel(message, 160, 22)
        end

        self._guildNameEdit:setText(message)
        self._guildNameEdit:setPlaceHolder(LanguageManager:getInstance():getLocalString(1110516))
        
        self:refreshCreateButton()
    elseif (strEventName == "changed") then
        local message = self._guildNameEdit:getText() or ""
        -- message = string.gsub(message, " ", "")
        message = ToolsUtil:replaceNameStr(message)
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
            self._guildNameEdit:setText(message)
            AvalonUtil.closeKeyBoard(self._guildNameEdit)
            return
        end

        if AvalonUtil:isUpLimiteStr(message, 160, 22) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110609))
            AvalonUtil.closeKeyBoard(self._guildNameEdit)
        end
        -- self._preNum = AvalonUtil.utf8len(message)

        -- -- 输入内容改变时调用
        -- local inputText = self._guildNameEdit:getText()
        -- if(inputText) then
        --     -- inputText = string.gsub(inputText, "\n", "")
        --     -- inputText = string.gsub(inputText, " ", "")
        --     -- self._guildNameEdit:setText(inputText)
        --     if(AvalonUtil.utf8len(inputText) > self._preNum) then
        --         if(AvalonUtil.utf8len(inputText)>7) then
        --             UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110609))
        --         end
        --     end
        --     self._preNum = AvalonUtil.utf8len(inputText)
        -- end
    end
end

function CreateGuild:refreshCreateButton()
    local inputText = self._guildNameEdit:getText()
    if(inputText) then
        if(string.len(inputText) >0) then
            self._createButton:enable()
            self._createLabel:setFontColor(UI.FONT_COLOR_50_50_44)
            return 
        end
    end

    -- self._createButton:disable()
    -- self._createLabel:setFontColor(UI.FONT_COLOR_182_201_201)
end

function CreateGuild:exitCreateGuild()
    self:close()
    -- self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
end

function CreateGuild:closeAllCreateOrJoinGuild()
    self:exitCreateGuild()
end

function CreateGuild:createStatus(createStatus)
    self:hideWaiting()
    if(createStatus) then
        self:exitCreateGuild()
    end 
end
-- 监听钻石变化
function CreateGuild:onCurrencyChangeHandler()
    self:onUpdateView()
end
-- 注册监听事件(可选)
function CreateGuild:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CLOSE_ALL_CREATE_OR_JOIN_GUILD, self, self.closeAllCreateOrJoinGuild)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_CREATE_STATUS, self, self.createStatus)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

-- 注销监听事件(可选)
function CreateGuild:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CLOSE_ALL_CREATE_OR_JOIN_GUILD, self, self.closeAllCreateOrJoinGuild)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_CREATE_STATUS, self, self.createStatus)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

function CreateGuild:createGuild()
    local func = function(intpuText)
        self._createButton:enable()
        local intpuText = intpuText or ""
        if(intpuText and string.len(intpuText) > 0) then
            if AvalonUtil:isEmoji(intpuText) then
                UI.ScrollBar:createByText(UI.TEXT_1170936)
                return
            end
            intpuText = ToolsUtil:replaceNameStr(intpuText)
            local mark = false
            intpuText,mark = ToolsUtil:checkMaskword(intpuText)
            self._guildNameEdit:setText(intpuText)
            if mark then
                UI.ScrollBar:createByText(UI.TEXT_1170415)
                return
            end

            if AvalonUtil:isUpLimiteStr(intpuText, 160, 22) then
                local message = AvalonUtil:getSubNameStrByLabel(intpuText, 160, 22)
                self._guildNameEdit:setText(message)
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110609))
                return
            end

            local master = GameDataManager:getInstance():getMaster()
            self:showWaiting()
            Net.NetGuildSystem:createGuild(master:getPK(), intpuText, self._choiceIconID)
        else 
            -- 提示输入公会名字
            UI.ScrollBar:createByText(UI.TEXT_1170711)
        end
    end


    local gameWordDetectionManager = require"app.game.GameWordDetectionManager"
    local nickName = self._guildNameEdit:getText() or ""
    self._createButton:disable()
    gameWordDetectionManager:getInstance():nicknameDetection(nickName,func,function()
        self._createButton:enable()
    end)
end

function CreateGuild:showWaiting()
    UI.WaitingLayer:showWaiting(true, self, GAME_NET_DELAY_UI)
end 

function CreateGuild:hideWaiting()
    UI.WaitingLayer:hideWaiting()
end

function CreateGuild:choiceGuildIcon()
    -- 处理选择公会图标
    local choiceGuildPanel = UI.ChoiceGuildIconPanel:create()

    local iconList = ConfigManager:getGuildIconList()
    -- 去掉需要收费的
    local dataList = {}
    for k, v in pairs(iconList) do
        if(tonumber(v.iconCost) == 0) then
            table.insert(dataList, v)
        end
    end

    choiceGuildPanel:init(clone(dataList), function(choiceIconData)
        -- print("CreateGuild ", choiceIconData.iconID)
        -- dump(choiceIconData)

        self._choiceIconID = choiceIconData.iconID
        self._icon:setSpriteName(choiceIconData.iconSpriteName)
    end)
    choiceGuildPanel:centerBottom(85)
    self:addChild(choiceGuildPanel, 10000)
end