--[[
    DialogTextCell.lua
    use：ydli
    UI - 放聊天富文本的容器
]]--

--[[
    二次修改界面（？？？？？？？？？纠结 需不需要用继承来区分这些排榜类型）
    排版1：富文本（系统频道，维护消息）、隔离线
    排版2：频道标识、富文本（只有快捷频道有）、隔离线
    排版3：头像、职位（可选）、名字、文本底框，富文本、翻译文本底框、翻译富文本、翻译按钮 (有没翻译 和 已翻译状态)
    排版4：头像、职位（可选）、名字、文本底框，富文本、按钮（同意和拒绝）
    排版5：纯文本（显示时间 在外部处理了）
]]--



require "app.ui.common.Layout"
local SdkBox = require("utils.sdkbox.SdkBox")

--------自定义 奖励内容  处理触摸事件
local DialogTextCell = class("DialogTextCell", UI.Layout)
UI.DialogTextCell = DialogTextCell

local VERTICAL_SPACE = 2
if device.platform == "android" then
    VERTICAL_SPACE = 0
elseif device.platform == "windows" then
    VERTICAL_SPACE = 0
    spaceHeight = 4
end

function DialogTextCell:ctor()
    --窗口大小
    DialogTextCell.super.ctor(self)
    self._originRichText = nil
    self._transformRichText = nil
    self._touchLayout = nil
    self._status = CHAT_CELL_STATUS.FORBIDEN_TRAN
    
    self._data = nil
    self._layoutType = nil
    self._chatDialogLayer = nil
end

function DialogTextCell:dtor()
    print("---DialogTextCell:dtor()-----")
    --窗口大小
    DialogTextCell.super.dtor(self)
    self._originRichText = nil
    self._transformRichText = nil
    self._data = nil
    self._layoutType = nil
    self._chatDialogLayer = nil
    self._status = CHAT_CELL_STATUS.FORBIDEN_TRAN

end


--[[data = {messageType, PBType pbBytes, gTime, isSelf} 
    PBType 解包pbmessgae ChatChannelType
    messageType  消息类型  ChatMessageType
    pbBytes：数据结构 == true 为pb数据 否则文本数据  -- 要转成table  messageData
    gTime:消息生成的本地时间
    isSelf: 是否是自己本地发送的消息
]]
-- 初始化(必备)
function DialogTextCell:init()
    DialogTextCell.super.init(self)
    -- self:enableDebugDraw(UI.RED)
end

-- 模版函数：初始化组建的视图(必备)
function DialogTextCell:onInitView()
    -- self:enableDebugDraw(UI.RED)
    local touchLayout = UI.Layout:create()
    touchLayout:setName("TouchLayout")
    touchLayout:init()
    touchLayout:centerLeft(0)
    self:addChild(touchLayout, 20)
    self._touchLayout = touchLayout
end

-- 模版函数：更新组建的视图(必备)
function DialogTextCell:onUpdateView()
end

function DialogTextCell:refreshView(chatDialogLayer, layerChannelType, lType, data, width, height)
    self._chatDialogLayer = chatDialogLayer
    self._data = data
    self._layoutType = lType
    self._layerChannelType = layerChannelType
    local content = ""
    if self._layerChannelType == ChatChannelType.QUICK then
        content = self:generalContent(self._data, nil, true, false)
        content = string.gsub(content, "click", "font")
    else
        content = self:generalContent(self._data, nil, nil, true)
    end
    
    _richText = self:createRichText(content, self._data.gTime, width, height)
    if _richText then
        self:addChild(_richText, 10)
        _richText:leftUp(11, 10)
        self._showWidth = self._showWidth == nil and _richText:getContentSize().width or self._showWidth
        self:setSize(self._showWidth , _richText:getContentSize().height + 24)
        self._originRichText = _richText
    end

    if layerChannelType == ChatChannelType.WORLD or layerChannelType == ChatChannelType.TEAM or layerChannelType == ChatChannelType.GUILD
    or layerChannelType == ChatChannelType.NEAR or layerChannelType == ChatChannelType.PERSONAL then
        local bg = UI.Image9:create()
        bg:init("ui_chat_system_box_1.png", CCRectMake(20,21,1,1),  cc.size(self:getContentSize().width + 30, self:getContentSize().height - 10))
        bg:centerLeft(0)
        _richText:leftUp(13, 13)
        self:addChild(bg)
    elseif layerChannelType == ChatChannelType.QUICK then
        local upLine = UI.Image9:create()
        upLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20,21,1,1), cc.size(375, 2))
        upLine:leftUp(24, 0)
        self:addChild(upLine)
        if _richText then
            _richText:leftUp(22, 8)
        end
    else
        local bg = UI.Image9:create()
        bg:init("ui_chat_system_box_1.png", CCRectMake(20,21,1,1), cc.size(self:getContentSize().width + 30, self:getContentSize().height - 10))
        bg:centerLeft(0)
        _richText:leftUp(13, 13)
        self:addChild(bg)
    end
   
    self._touchLayout:centerRight(-18)
end

function DialogTextCell:createRichText(content, gTime, width, height)
    local _richText = nil
    local md5Key = AvalonUtil:MD5(content)..self._layerChannelType..gTime
    local success = nil
    if Game.ChatManager:getInstance():isOpenRichTextCache() and  width ~= nil then
        -- print("------OpenRichTextCache-----is true")
        _richText = Game.ChatManager:getInstance():getRichTextCache(md5Key)
        if _richText and _richText:getParent() == nil then
        else
            _richText = UI.RichText:create(-VERTICAL_SPACE)
            success = _richText:init(content, width - 12, height)
            if success == false then
                return
            end
            _richText:retain()
            Game.ChatManager:getInstance():insertRichTextCache(md5Key, _richText)
        end
    else
        _richText = UI.RichText:create(-VERTICAL_SPACE)
       if width == nil then
            success = _richText:init(content, nil, height, true)
            local tempWidth = _richText:getContentSize().width  + 40
            _richText = UI.RichText:create(-VERTICAL_SPACE)
            success = _richText:init(content, tempWidth, height)
        else
            success = _richText:init(content, width - 12, height)
        end
        if success == false then
            return
        end
    end
    _richText:setName(md5Key)
    return _richText
end

function DialogTextCell:generalContent(data, isLogo, removeLink, isHaveBg)
    if self._layoutType == CHAT_CELL_LAYOUT_TYPE.LogoRichText or isLogo then
        local proLogo = ""
        local horn = ""
        if data.channelType ==  ChatChannelType.SYSTEM then
            if data.messageType == ChatMessageType.SYSTEM_NOTICE then
                horn = AvalonUtil:serializeImage("ui_information_icon_horn.png")
            end
            proLogo = AvalonUtil:serializeImage("ui_chat_icon_system.png", UI.TEXT_1170305, UI.FONT_COLOR_WHITE, UI.FONT_SIZE_14PX, UI.SYS_FONT)
        elseif data.channelType ==  ChatChannelType.TEAM then
            proLogo = AvalonUtil:serializeImage("ui_chat_icon_teammate.png", UI.TEXT_1170306, UI.FONT_COLOR_WHITE, UI.FONT_SIZE_14PX, UI.SYS_FONT)
        elseif data.channelType ==  ChatChannelType.GUILD then
            proLogo = AvalonUtil:serializeImage("ui_chat_icon_guild.png", UI.TEXT_1110659, UI.FONT_COLOR_WHITE, UI.FONT_SIZE_14PX, UI.SYS_FONT)
        elseif data.channelType ==  ChatChannelType.PERSONAL then
            proLogo = AvalonUtil:serializeImage("ui_chat_icon_friends.png", UI.TEXT_1170308, UI.FONT_COLOR_WHITE, UI.FONT_SIZE_14PX, UI.SYS_FONT)
        elseif data.channelType ==  ChatChannelType.NEAR then
            proLogo = AvalonUtil:serializeImage("ui_chat_icon_friends.png", UI.TEXT_1170333, UI.FONT_COLOR_WHITE, UI.FONT_SIZE_14PX, UI.SYS_FONT)
        elseif data.channelType ==  ChatChannelType.WORLD then
            proLogo = AvalonUtil:serializeImage("ui_chat_icon_world.png", UI.TEXT_1213207, UI.FONT_COLOR_WHITE, UI.FONT_SIZE_14PX, UI.SYS_FONT)
        end
        if data.content == nil then
            data.content = Game.ChatManager:getInstance():unCompressString(data, removeLink, isHaveBg)
        end
        return proLogo..horn..data.content, proLogo, horn..data.content
    elseif self._layoutType == CHAT_CELL_LAYOUT_TYPE.RichText then
        local proLogo = ""
        if data.messageType == ChatMessageType.SYSTEM_NOTICE then
            proLogo = AvalonUtil:serializeImage("ui_information_icon_horn.png")
        end

        if data.content == nil then
            data.content = Game.ChatManager:getInstance():unCompressString(data, removeLink, isHaveBg)
        end
        return proLogo..data.content, proLogo, data.content
    end
end

function DialogTextCell:clickCallback()
    
end

function DialogTextCell:getRichTextMd5Key()
    if self._originRichText then
        return self._originRichText:getName()
    end
end

function DialogTextCell:getRichTextMd5KeyWithLanguageType()
    if self._originRichText then
        local LanguageManager = require("app.game.LanguageManager")
        local languageType = LanguageManager:getInstance():getLanguage()
        return self._originRichText:getName()..languageType
    end
end

function DialogTextCell:translateCallback(eventType, resultObject, isRemove)
    print("-----DialogTextCell:translateCallback()---11111--", eventType, resultObject)
end

-- 重写父类函数
function DialogTextCell:_removeFromParent(isClear)
    if self._originRichText then
        self._originRichText:removeFromParent(false)
        self._originRichText = nil
    end
    self:removeFromParent(isClear)
end

function DialogTextCell:isDialogTextCell()
    return true
end

function DialogTextCell:setStatus(status)
end

--把可以翻译的文本  从禁止翻译切换到 允许翻译
function DialogTextCell:doTranslateMode()
end


function DialogTextCell:cancleTranslateMode()
end

function DialogTextCell:isCanTranslate()
    return false
end

function DialogTextCell:isNeedTranslation(data)
    return false   
end