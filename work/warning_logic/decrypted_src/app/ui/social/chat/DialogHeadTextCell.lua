--[[
    DialogHeadTextCell.lua
    use：ydli
    UI - 放聊天富文本的容器
    排版3：头像、职位（可选）、名字、文本底框，富文本、翻译文本底框、翻译富文本、翻译按钮 (有没翻译 和 已翻译状态)
    排版4：头像、职位（可选）、名字、文本底框，富文本、按钮（同意和拒绝）
]]--


require "app.ui.social.chat.DialogTextCell"
local SdkBox = require("utils.sdkbox.SdkBox")

--------自定义 奖励内容  处理触摸事件
local DialogHeadTextCell = class("DialogHeadTextCell", UI.Layout)
UI.DialogHeadTextCell = DialogHeadTextCell

local VERTICAL_SPACE = 2
if device.platform == "android" then
    VERTICAL_SPACE = 0
elseif device.platform == "windows" then
    VERTICAL_SPACE = 0
    spaceHeight = 4
end

function DialogHeadTextCell:ctor()
    --窗口大小
    DialogHeadTextCell.super.ctor(self)
    self._originRichText = nil
    self._transformRichText = nil
    self._touchLayout = nil
    self._status = CHAT_CELL_STATUS.FORBIDEN_TRAN
    
    self._showWidth = nil
    self._showHight = nil
    self._data = nil
    self._layerChannelType = nil --所在聊天界面类型
    self._layoutType = nil  --布局风格
    self._chatDialogLayer = nil
end

function DialogHeadTextCell:dtor()
    print("---DialogHeadTextCell:dtor()-----")
    --窗口大小
    DialogHeadTextCell.super.dtor(self)
    self._originRichText = nil
    self._transformRichText = nil
    self._showWidth = nil
    self._showHight = nil
    self._data = nil
    self._layerChannelType = nil
    self._layoutType = nil
    self._chatDialogLayer = nil
    self._status = CHAT_CELL_STATUS.FORBIDEN_TRAN

end


-- 初始化(必备)
function DialogHeadTextCell:init()
    DialogHeadTextCell.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function DialogHeadTextCell:onInitView()
    -- self:enableDebugDraw(UI.RED)
    local touchLayout = UI.Layout:create()
    touchLayout:setName("TouchLayout")
    touchLayout:init()
    touchLayout:centerLeft(0)
    self:addChild(touchLayout, 20)
    self._touchLayout = touchLayout
    -- touchLayout:enableDebugDraw()

    --headBg
    local headBg = UI.Image:create()
    headBg:init("ui_information_headframe_bottom.png")
    headBg:leftUp(10, 10)
    self:addChild(headBg)
    headBg:setScale(0.8)
    self.headBg = headBg

    local headCap = UI.Image:create()
    headCap:init("ui_information_headframe_box.png")
    headCap:center()
    headBg:addChild(headCap, 10)
    self.headCap = headCap

    -- 等级背景图  
    local gradeBG = UI.Image:create()
    gradeBG:init("ui_information_headframe_grade.png")
    gradeBG:leftBottom(-10,-4)
    headBg:addChild(gradeBG, 100) 
    self.gradeBG = gradeBG
    
    -- 等级
    local lvLabel = UI.Text:create()
    lvLabel:init("11",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_187_167_136)
    lvLabel:setSize(100, 50)
    lvLabel:center()
    lvLabel:setTextCenter()
    gradeBG:addChild(lvLabel,101)
    self.lvLabel = lvLabel

    --bg
    local centerBg = UI.Image9:create()
    centerBg:init("ui_chat_ui_chat_world_bubble_box_1.png", CCRectMake(30,30,1,3), cc.size(67, 41))
    self:addChild(centerBg, 1)
    self.centerBg = centerBg

    --name
    local nickName = UI.Text:create()
    nickName:init("",UI.FONT_ARIAL,UI.FONT_SIZE_16PX,UI.FONT_COLOR_230_211_196)
    nickName:leftUp(104, 0)
    self:addChild(nickName,101)
    self.nickName = nickName

    --btn
    local transFlag = UI.Image:create()
    transFlag:init("ui_chat_translate_button_0.png")
    self:addChild(transFlag)
    self.transFlag = transFlag
end

-- 模版函数：更新组建的视图(必备)
function DialogHeadTextCell:onUpdateView()
end

function DialogHeadTextCell:refreshView(chatDialogLayer, layerChannelType, lType, data, width, height)
    self._chatDialogLayer = chatDialogLayer
     -- print("-=------data._status ----- =", data._status)
    self._data = data
    self._showWidth = width
    self._showHight = height
    self._layerChannelType = layerChannelType
    self._layoutType = lType

    local content, speaker, titleNickName = self:generalContent(self._data)
    self.speaker = speaker
    self.nickName:setText(titleNickName or speaker.nickName)
    -- self._layoutType = CHAT_CELL_LAYOUT_TYPE.HeadRichText

    if self.cancleBtn then
        self.cancleBtn:removeFromParent()
        self.cancleBtn = nil
    end
    if self.confirmBtn then
        self.confirmBtn:removeFromParent()
        self.confirmBtn = nil
    end
    if self.agreeLogo then
        self.agreeLogo:removeFromParent()
        self.agreeLogo = nil
    end
    if self._layoutType == CHAT_CELL_LAYOUT_TYPE.BtnRichText then
        self._status = CHAT_CELL_STATUS.FORBIDEN_TRAN
        local _richText = self:createRichText(content, self._data.gTime)
        if _richText then
            self:addChild(_richText, 10)
            _richText:leftUp(117, 17)
            if _richText:getContentSize().width < 210 then
                self.centerBg:setSize(260, _richText:getContentSize().height + 55)
            else
                self.centerBg:setSize(_richText:getContentSize().width + 48, _richText:getContentSize().height + 55)
            end
            self:setSize(self._showWidth, self.centerBg:getContentSize().height + 30)
            self._originRichText = _richText
        end

        self.cancleBtn = UI.Button:create()
        self.cancleBtn:init("ui_btn_no3_0.png", "ui_btn_no3_1.png", "ui_btn_no3_2.png")
        self.cancleBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
        self.cancleBtn:leftBottom(47, 25)
        self.cancleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self._data.isAgree = false
            self:createAgreeState()
            UI.ScrollBar:createByText(str)
        end)
        self:addChild(self.cancleBtn, 10)

        self.confirmBtn = UI.Button:create()
        self.confirmBtn:init("ui_btn_yes3_1.png", "ui_btn_yes3_2.png", "ui_btn_yes3_2.png")
        self.confirmBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
        self.confirmBtn:leftBottom(147, 25)
        self.confirmBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local guildid = nil
            local token = nil
            local chatContent = self._data.messageData.chatContent
            local ProtobufUtil = require "utils.ProtobufUtil"
            for k, v in ipairs(chatContent.tags) do
                if v.dataType == PublicDefine.TagClickTypeKey.GuildName then
                    guildid = v.data.guildID
                    token = v.data.tk
                end
            end
            print("----speaker.pk, guildid, token---", speaker.pk, guildid, token)
            self._data.isAgree = true
            self:createAgreeState()
            Net.NetGuildSystem:replyInviteJoin(speaker.pk, guildid, token)
        end)
        self:addChild(self.confirmBtn, 10)
    else
        local _richText = self:createRichText(content, self._data.gTime)
        if _richText then
            self:addChild(_richText, 10)
            _richText:leftUp(117, 27)
            self.centerBg:setSize(_richText:getContentSize().width + 48, _richText:getContentSize().height + 20)
            if self.centerBg:getContentSize().height < 75 then
                self:setSize(self._showWidth, 100)
            else
                self:setSize(self._showWidth, self.centerBg:getContentSize().height + 36)
            end
            self._originRichText = _richText
        end

        if self._data._status == nil and Game.ChatManager:getInstance():isNeedTranslation(self._data) and self._originRichText then
            self._data._status = Game.ChatManager:getInstance():getCellStatusFromCache(self._layerChannelType, self._originRichText:getName())
        end
        if Game.ChatManager:getInstance().isInTranslateMode then
            self._status = self._data._status or CHAT_CELL_STATUS.ALLOW_TRAN
            if self._status == CHAT_CELL_STATUS.FORBIDEN_TRAN and Game.ChatManager:getInstance():isNeedTranslation(data) then
                self._status = CHAT_CELL_STATUS.ALLOW_TRAN
            elseif not Game.ChatManager:getInstance():isNeedTranslation(data) then
                self._status = CHAT_CELL_STATUS.FORBIDEN_TRAN
            end
        else
            if self._data._status ~= CHAT_CELL_STATUS.FINISH_TRAN then
                self._status = CHAT_CELL_STATUS.FORBIDEN_TRAN
            else
                self._status = self._data._status
            end
        end
    end
    if self._originRichText then
        self._originRichText:setOpacity(255)
    end
    self.transFlag:hide()
    self:setStatus(self._status)
    self:refreshViewWithStatus()
    self:refreshAllPosition()
    self:createAgreeState()

    local master = RoleDataManager:getMaster()
    self.headBg:removeChildByName("heorIcon", true)
    local head = UI.Image:create()
    head:init("ui_information_banner_people.png")
    head:setName("heorIcon")
    head:center()
    self.headBg:addChild(head)
    head:setScale(2)
    Avalon.WidgetUtil:getHeadByData(self, speaker.sex, speaker.faceDecodeID, speaker.wearEquipId or {}, self, handler(self,function(obj, pic)
        if self.headBg and not tolua.isnull(self.headBg) then
            self.headBg:removeChildByName("heorIcon", true)
            pic:setPosition(38, 38)
            pic:setName("heorIcon")
            self.headBg:addChild(pic,2)
        end
    end))
    if speaker.roleLV then
        local reincarntionLv = speaker.reincarntionLv or 0
        local showLv = RoleDataManager:getUIShowLvByOtherData(speaker.roleLV, reincarntionLv)
        self.lvLabel:setText(showLv)
        if reincarntionLv > 0 then
            local headFrame, levelFrame = RoleDataManager:getHeadFrameByReinLv(reincarntionLv)
            self.headCap:setSpriteName(headFrame)
            self.gradeBG:setSpriteName(levelFrame)
        else
            self.headCap:setSpriteName("ui_information_headframe_box.png")
            self.gradeBG:setSpriteName("ui_information_headframe_grade.png")
        end
    end
end

--区分左右布局 和 翻译状态哦布局
function DialogHeadTextCell:refreshAllPosition()
    if self._data.isSelf then
        self.headBg:rightUp(0, 10)
        if self._layerChannelType == ChatChannelType.WORLD then
            self.centerBg:setSpriteName("ui_chat_ui_chat_world_bubble_box_1.png")
        else
            self.centerBg:setSpriteName("ui_chat_bubble_box_1.png")
        end
        self.centerBg:setScaleX(-1)       
        self.centerBg:rightUp(78, 25)
        self.nickName:rightUp(92, 0)
        if self._layoutType == CHAT_CELL_LAYOUT_TYPE.BtnRichText then
            if self._originRichText then
                self._originRichText:rightUp(80 + self.centerBg:getContentSize().width / 2 - self._originRichText:getContentSize().width / 2, 34)
            end
            self.cancleBtn:rightBottom(80 + self.centerBg:getContentSize().width / 2 - 73 - self.centerBg:getContentSize().width / 9, 20)
            self.confirmBtn:rightBottom(80 + self.centerBg:getContentSize().width / 2 + self.centerBg:getContentSize().width / 9, 20)
        else
            if self._originRichText then
                self._originRichText:rightUp(106, 34)
            end
            self.transFlag:rightUp(92 + self.centerBg:getContentSize().width, 15 + self.centerBg:getContentSize().height / 2)
        end
    else
        self.headBg:leftUp(10, 10)
        if self._layerChannelType == ChatChannelType.WORLD then 
            self.centerBg:setSpriteName("ui_chat_ui_chat_world_bubble_box_2.png")
        else
            self.centerBg:setSpriteName("ui_chat_bubble_box_2.png")
        end
        self.centerBg:setScaleX(1)
        self.centerBg:leftUp(88, 25)
        self.nickName:leftUp(102, 0)
        if self._layoutType == CHAT_CELL_LAYOUT_TYPE.BtnRichText then
            if self._originRichText then
                self._originRichText:leftUp(91 + self.centerBg:getContentSize().width / 2 - self._originRichText:getContentSize().width / 2, 34)
            end
            self.cancleBtn:leftBottom(91 + self.centerBg:getContentSize().width / 2 - 73 - self.centerBg:getContentSize().width / 9, 20)
            self.confirmBtn:leftBottom(91 + self.centerBg:getContentSize().width / 2 + self.centerBg:getContentSize().width / 9, 20)
        else
            if self._originRichText then
                self._originRichText:leftUp(118, 34)
            end
            self.transFlag:leftUp(102 + self.centerBg:getContentSize().width, 15 + self.centerBg:getContentSize().height / 2)
        end
    end
end

function DialogHeadTextCell:refreshViewWithStatus()
    -- print("---------------DialogHeadTextCell:refreshViewWithStatus")
    if self._status == CHAT_CELL_STATUS.FORBIDEN_TRAN then
        self._touchLayout:setSize(self._showWidth, self:getContentSize().height)
    elseif self._status == CHAT_CELL_STATUS.ALLOW_TRAN then
        self._touchLayout:setSize(self._showWidth, self:getContentSize().height)
    elseif self._status == CHAT_CELL_STATUS.TRANLATING then
        self._touchLayout:setSize(self._showWidth, self:getContentSize().height)
    elseif self._status == CHAT_CELL_STATUS.FINISH_TRAN then
        local md5Key = self._originRichText:getName()
        local LanguageManager = require("app.game.LanguageManager")
        local languageType = LanguageManager:getInstance():getLanguage()
        local strList = Game.ChatManager:getInstance():getTransFormStrTbCache(md5Key..languageType)
        -- print("------------md5Key..languageType",md5Key, languageType)
        -- dump(strList, "-----strList")
        if strList then 
            self:translateCallback(GOOGLE_TRANSLATE_EVENT.TRANSLATE_EVENT, strList, false)
        else--切回到允许翻译的状态
            strList = Game.ChatManager:getInstance():parseChatData(self._data) or {}
            local isCanTran = false
            for k, v in ipairs(strList) do
                if string.len(string.trim(v)) > 0 then
                    isCanTran = true
                    break
                end
            end
            if isCanTran then
                self:setStatus(CHAT_CELL_STATUS.ALLOW_TRAN)
                self:refreshViewWithStatus()
            else
                self:translateCallback(GOOGLE_TRANSLATE_EVENT.TRANSLATE_EVENT, strList, false)
            end
        end
    end
end

function DialogHeadTextCell:createRichText(content, gTime)
    local _richText = nil
    local md5Key = AvalonUtil:MD5(content)..self._layerChannelType..gTime
    local success = nil
    if Game.ChatManager:getInstance():isOpenRichTextCache() then
        -- print("------OpenRichTextCache-----is true")
        _richText = Game.ChatManager:getInstance():getRichTextCache(md5Key)
        if _richText and _richText:getParent() == nil then
        else
            _richText = UI.RichText:create(-VERTICAL_SPACE)
            success = _richText:init(content, nil, self._showHight, true)
            local width = _richText:getContentSize().width
            if width > 330 then
                _richText = UI.RichText:create(-VERTICAL_SPACE)
                success = _richText:init(content, 330, self._showHight)
            else
                _richText = UI.RichText:create(-VERTICAL_SPACE)
                success = _richText:init(content, width, self._showHight)
            end
            if success == false then
                return
            end
            _richText:retain()
            Game.ChatManager:getInstance():insertRichTextCache(md5Key, _richText)
        end
    else
        _richText = UI.RichText:create(-VERTICAL_SPACE)
        success = _richText:init(content, nil, self._showHight, true)
        local width = _richText:getContentSize().width
        if width > 330 then
            _richText = UI.RichText:create(-VERTICAL_SPACE)
            success = _richText:init(content, 330, self._showHight)
        else
            _richText = UI.RichText:create(-VERTICAL_SPACE)
            success = _richText:init(content, width, self._showHight)
        end
        if success == false then
            return
        end
    end
    _richText:setName(md5Key)
    -- _richText:enableDebugDraw()
    return _richText
end

function DialogHeadTextCell:generalContent(data)
    local speaker, content, titleNickName = Game.ChatManager:getInstance():unCompressStringAndSpeaker(data)
    return content, speaker, titleNickName
end

function DialogHeadTextCell:clickCallback(location)
    if AvalonUtil:isRectContainsPoint(self.headBg, location) then
        self:headClick(self.headBg:convertToWorldSpace(cc.p(0, 0)))
        return
    end
    if not self:isCanTranslate() then
        return
    end
    if Game.ChatManager:getInstance().isLockTouchTranslate then
        Game.ChatManager:getInstance().isLockTouchTranslate = false
        return
    end
    if self._originRichText == nil then
        return
    end
    if not Game.ChatManager:getInstance().isInTranslateMode then
        return
    end
    if self._transformRichText == nil then
        self:setStatus(CHAT_CELL_STATUS.TRANLATING)
        local md5Key = self._originRichText:getName()
        local LanguageManager = require("app.game.LanguageManager")
        local languageType = LanguageManager:getInstance():getLanguage()
        local strList = Game.ChatManager:getInstance():getTransFormStrTbCache(md5Key..languageType)
        if strList == nil then
            strList = Game.ChatManager:getInstance():parseChatData(self._data) or {}
            local isCanTran = false
            for k, v in ipairs(strList) do
                if string.len(string.trim(v)) > 0 then
                    isCanTran = true
                    break
                end
            end
            if isCanTran then
                SdkBox:getInstance():translate(self._layerChannelType.."_"..md5Key..languageType, strList)  
                self:refreshViewWithStatus()
            else
                self:translateCallback(GOOGLE_TRANSLATE_EVENT.TRANSLATE_EVENT, strList, true)
            end
        else
            self:translateCallback(GOOGLE_TRANSLATE_EVENT.TRANSLATE_EVENT, strList, true)
        end
        Game.ChatManager:getInstance():resetTranlateCDTime()
    end
end

function DialogHeadTextCell:getRichTextMd5Key()
    if self._originRichText then
        return self._originRichText:getName()
    end
end

function DialogHeadTextCell:getRichTextMd5KeyWithLanguageType()
    if self._originRichText then
        local LanguageManager = require("app.game.LanguageManager")
        local languageType = LanguageManager:getInstance():getLanguage()
        return self._originRichText:getName()..languageType
    end
end

function DialogHeadTextCell:translateCallback(eventType, resultObject, isRemove)
    -- print("-----DialogHeadTextCell:translateCallback()---11111--", self:getTag(), eventType, resultObject, isRemove)
    if resultObject == nil then
        return
    end
    if eventType == GOOGLE_TRANSLATE_EVENT.TRANSLATE_EVENT then
        self:setStatus(CHAT_CELL_STATUS.FINISH_TRAN)
        local content = Game.ChatManager:getInstance():unCompressStringWithTranform(self._data, resultObject)
        self._transformRichText = self:createRichText(content, self._data.gTime)
        if self._transformRichText then
            local bg = UI.Image9:create()
            bg:init("ui_chat_translate.png", CCRectMake(32,20,1,1), cc.size(self._transformRichText:getContentSize().width + 40, self._transformRichText:getContentSize().height + 15))
            self:addChild(bg, 2)
            self:addChild(self._transformRichText, 12)
            bg:setName("TranslateBg")
            
            local addHeight = bg:getContentSize().height + 10
            self:setSize(self:getContentSize().width, self:getContentSize().height + addHeight)
            if isRemove then
                self._chatDialogLayer:addHeightByIndex(false, addHeight, self:getTag())
            end
            self._touchLayout:setSize(self._showWidth, self:getContentSize().height)
            if self._data.isSelf then
                bg:rightUp(97, 33 + self.centerBg:getContentSize().height)
                self._transformRichText:rightUp(bg:getRight() + 20, bg:getUp() + 6)
            else
                bg:leftUp(100, 33 + self.centerBg:getContentSize().height)
                self._transformRichText:leftUp(bg:getLeft() + 20, bg:getUp() + 6)
            end
            self.transFlag:hide()
        end
    end
end

function DialogHeadTextCell:_removeFromParent(isClear)
    if self._originRichText then
        self._originRichText:removeFromParent(false)
        self._originRichText = nil
    end
    if self._transformRichText then
        self._transformRichText:removeFromParent(false)
        self._transformRichText = nil
    end
    local translateBg = self:getChildByName("TranslateBg")
    if translateBg then
        translateBg:removeFromParent()
    end
    self:removeFromParent(isClear)
end

function DialogHeadTextCell:setStatus(status)
    local oldStatus = self._data._status
    self._status = status
    self._data._status = status
    if status ~= oldStatus and self:isNeedTranslation(self._data) then
        local isDirty = Game.ChatManager:getInstance():insertCellStatusCache(self._layerChannelType, self._originRichText:getName(), status, true)
        if isDirty then
            Game.ChatManager:getInstance():saveCellStatusCache()
        end
    end
end

--把可以翻译的文本  从禁止翻译切换到 允许翻译
function DialogHeadTextCell:doTranslateMode()
    -- print("--------doTranslateMode-----2  ", self._status)
    self.transFlag:hide()
    if self._status == CHAT_CELL_STATUS.FORBIDEN_TRAN then
        if self:isNeedTranslation(self._data) then
            self:setStatus(CHAT_CELL_STATUS.ALLOW_TRAN)
            self:refreshViewWithStatus()
            self.transFlag:show()
        end
    end
end

function DialogHeadTextCell:cancleTranslateMode()
    if self._status == CHAT_CELL_STATUS.FINISH_TRAN then
    else
        self:setStatus(CHAT_CELL_STATUS.FORBIDEN_TRAN)
        self:refreshViewWithStatus()
    end
    self.transFlag:hide()
end

function DialogHeadTextCell:isCanTranslate()
    if self._status == CHAT_CELL_STATUS.ALLOW_TRAN or self._status == CHAT_CELL_STATUS.FINISH_TRAN then
        return true
    end
    return false
end

function DialogHeadTextCell:isNeedTranslation(data)
    if data == nil or self._originRichText == nil then
        return false
    end
    return Game.ChatManager:getInstance():isNeedTranslation(data)    
end

function DialogHeadTextCell:getClassName()
    return "DialogHeadTextCell"
end

function DialogHeadTextCell:isDialogTextCell()
    return true
end

function DialogHeadTextCell:headClick(location)
    if self.speaker.pk == RoleDataManager:getMasterPK() then
        return
    end 
    local parent = UI.ChatMainLayer:getInstance()
    local pointP = parent:convertToNodeSpace(location)
    local talkTip = UI.TalkTips:createTips(TalkTipsType.FromChatLayer, self.speaker, location.x, location.y, function(chatPlayer)
        Game.ChatManager:getInstance():OnPersonalChat(chatPlayer, true)
    end)
    talkTip:setName("TALK_TIP")
    talkTip:leftBottom(pointP.x + 80, talkTip:getBottom() - parent:getPositionY())
    talkTip:refreshArrowPos(0, 16)
    parent:addChild(talkTip, 100)
end

function DialogHeadTextCell:createAgreeState()
    if self.agreeLogo then
        self.agreeLogo:removeFromParent()
        self.agreeLogo = nil
    end
    if self._data.isAgree == nil then
        return
    end
    local logoName = ""
    local text = ""
    local color = ""
    if self._data.isAgree then
        logoName = "ui_information_banner_receive.png"
        text = UI.TEXT_1213306
        color = UI.FONT_COLOR_15_85_71
    else
        logoName = "ui_information_banner_unfinished1.png"
        text = UI.TEXT_1213307
        color = UI.FONT_COLOR_80_5_5
    end
    local logo = UI.Image:create()
    logo:init(logoName)
    logo:setName("heorIcon")
    logo:center(-50, 10)
    self:addChild(logo, 1000)

    local tip = UI.Text:create()
    tip:init(text,UI.FONT_STANDARD,UI.FONT_SIZE_18PX,color)
    tip:center()
    tip:setRotationSkewX(-9.0)
    tip:setRotationSkewY(-9.0)
    logo:addChild(tip,101)
    self.agreeLogo = logo
     if self.cancleBtn then
        self.cancleBtn:hide()
    end
    if self.confirmBtn then
        self.confirmBtn:hide()
    end
    if self._originRichText then
        self._originRichText:setOpacity(160)
    end
end