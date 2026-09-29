-- ChatMainLayer.lua
-- Author:ydli
-- 2017年09月11日
-- Using:聊天主界面 包含快捷聊天除外的 其他界面
UI = UI or {}
local ChatMainLayer = class("ChatMainLayer", UI.HWBtnComponent)
UI.ChatMainLayer = ChatMainLayer
local ProtobufUtil = require("utils.ProtobufUtil")
require "app.ui.social.chat.SelectPlayerLayer"
require "app.ui.social.chat.ChatBlackListLayer"
require "app.ui.social.chat.ChatDialogLayer"
local GameDataManager = require("app.game.GameDataManager")

local winSize = cc.Director:getInstance():getWinSize()
local size = cc.size(908, 530)

local BlackLayerTag = ChatChannelType.PERSONAL + 10000
local SEND_MESSAGE_WIDTH_LIMIT = Game.SEND_MESSAGE_WIDTH_LIMIT --大约
local INPUT_BOX_FONT_SIZE = 16
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_chat.plist",
}

g_chatMainLayer = nil;

--构造函数(必备)
function ChatMainLayer:ctor(spriteID)
    -- print("TipsLayer:ctor")
    --窗口大小
    -- print("----------ChatMainLayer ctor  1")
    ChatMainLayer.super.ctor(
    self,UIType.CHAT_MAIN,
    COM_RES_LIST,
    size.width,    
    size.height
    )
    self.goodsData = nil
    self.rootLayer = nil         --root节点
    self.selectedTag = nil
    self.lastInputText = nil
    self.personalChatPlayer = nil
    self.isHavePersonalMsg = false
    self.isHaveTeamMsg = false
    self.isHaveGuildMsg = false
    self.isHaveWorldMsg = false
    self.isHaveNearMsg = false
    self.isHaveSysMsg = false
    self.tagBtns = {}
    self.tagDialogLayer = {}
    self:setStatic(true)
    self:init()
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
end

--虚构函数,destroy时调用(必备)
function ChatMainLayer:dtor()
    print(debug.traceback(), "debug.traceback")
    print("----------ChatMainLayer dtor  1", self._static, g_chatMainLayer:getReferenceCount())
    -- if g_chatMainLayer ~= nil and g_chatMainLayer:getReferenceCount() <= 1 then
    --     print("----------ChatMainLayer dtor  2")
    --     g_chatMainLayer:retain()
    --     return
    -- end

    -- print("----------ChatMainLayer dtor  3")
    ChatMainLayer.super.dtor(self)
    self:unRegisterListener()
    self.tagBtns = {}
    self.tagDialogLayer = {}
    -- print("----------ChatMainLayer dtor  4")
    -- reload_script_file("app.ui.social.chat.ChatMainLayer")
   
end

function ChatMainLayer:getInstance()
    if g_chatMainLayer == nil then
        return self:recycle()
    end
    return g_chatMainLayer
end

function ChatMainLayer:purgeInstance()
    if g_chatMainLayer ~= nil then
        g_chatMainLayer = nil
    end
end

function ChatMainLayer:isInit()
    if g_chatMainLayer ~= nil then
        return g_chatMainLayer._initView
    end
    return false
end

function ChatMainLayer:recycle()
    reload_script_file("app.ui.social.chat.DialogHeadTextCell")
    if g_chatMainLayer == nil then
        g_chatMainLayer = ChatMainLayer:create()
        g_chatMainLayer:setName("ChatMainLayer")
        g_chatMainLayer:retain()
    else
        g_chatMainLayer:removeFromParent(false)
        g_chatMainLayer:removeChildByName("TALK_TIP")
    end
    -- if g_chatMainLayer ~= nil and not tolua.isnull(g_chatMainLayer) then
    --     g_chatMainLayer:removeFromParent()
    -- end
    -- g_chatMainLayer = ChatMainLayer:create()
    -- g_chatMainLayer:setName("ChatMainLayer")
    -- print("------------g_chatMainLayer:getReferenceCount() = "..g_chatMainLayer:getReferenceCount())
    return g_chatMainLayer
end

-- 初始化(必备)
function ChatMainLayer:init()
    ChatMainLayer.super.init(self)
    self:setForceListenBackKey(true)
    self:setToCacheTexture(true)
end

function ChatMainLayer:isHide()
    return self:getParent() == nil
end

-- 模版函数：初始化组建的视图(必备)
function ChatMainLayer:onInitView()
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init(0,0,0,0)
    self.rootLayer:setContentSize(size.width, size.height)
    self.rootLayer:leftBottom(0,0)
    self:addChild(self.rootLayer)

    local bg = UI.Image:create()
    bg:init("ui_chat_bg.png")
    bg:center()
    self.rootLayer:addChild(bg)

    local titleBg = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:leftUp(bg:getContentSize().width/2 - titleBg:getContentSize().width/2 - 35, -23)
    bg:addChild(titleBg, 10)
    titleBg:setScale(0.85)

    local activityText = UI.Text:create()
    activityText:init(UI.TEXT_1213206, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_170_170_170)
    activityText:center(7)
    titleBg:addChild(activityText)

    local inputBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_chat_banner_box3.png")
    inputBg:setContentSize(644, 112)
    inputBg:setCapInsets(CCRectMake(300,41,1,1))
    inputBg:setAnchorPoint(0, 0)
    inputBg:setPosition(cc.p(0, 0))
    self.inputBg = inputBg
    self.rootLayer:addChild(inputBg, 200)

    self.lockTip = UI.Text:create()
    self.lockTip:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX)
    self.lockTip:setFontColor(UI.FONT_COLOR_155_155_155)
    self.lockTip:centerBottom(21)
    self.inputBg:addChild(self.lockTip, 10)
    self.lockTip:setTextCenter()
    self.lockTip:setSize(375, 43)
    -- self.lockTip:enableDebugDraw()

    self.sendBtn = UI.Button:create()
    self.sendBtn:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png","ui_btn_yellow_2.png")
    self.sendBtn:rightBottom(76, 13)
    self.sendBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onSendClick)
    self.inputBg:addChild(self.sendBtn, 10)
    self.sendBtn:setTextFont(UI.FONT_STANDARD, 22, UI.FONT_COLOR_63_51_33)
    self.sendBtn:setText(UI.TEXT_1170302)
    self.sendBtn:setScale(0.9)

    self.tip = UI.Text:create()
    self.tip:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    self.tip:center(-67)
    self.rootLayer:addChild(self.tip, 10)
    self.tip:setTextHorizontalCenter()
    self.tip:setSize(300, 100)

    local libIDEdit = cc.EditBox:create({width = 340, height = 44}, cc.Scale9Sprite:createWithSpriteFrameName("ui_chat_banner_nine_chatbox_1.png"))
    libIDEdit:setFontSize(INPUT_BOX_FONT_SIZE)
    libIDEdit:setPlaceholderFontSize(14)
    libIDEdit:setPlaceholderFontColor(UI.FONT_COLOR_255_255_255)
    libIDEdit:setPlaceHolder(UI.TEXT_1170303)
    libIDEdit:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    libIDEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    libIDEdit:setPosition(260, 39)
    libIDEdit:registerScriptEditBoxHandler(handler(self, self.editboxEventHandler))
    self.inputBg:addChild(libIDEdit)
    self.libIDEdit = libIDEdit
     
    self.translationBtn = UI.Button:create()
    if Game.ChatManager:getInstance().isInTranslateMode then
        self.translationBtn:init("ui_chat_button_translation_1.png","ui_chat_button_translation_0.png")
    else
        self.translationBtn:init("ui_chat_button_translation_0.png","ui_chat_button_translation_1.png")
    end
    self.translationBtn:leftBottom(634, 125)
    self.translationBtn:addEventListener(UIEvent.BUTTON_CLICK,self, function()
        if not Game.ChatManager:getInstance().isInTranslateMode then--开始 cd 计时
            Game.ChatManager:getInstance():resetTranlateCDTime()
        end
        self:translationClick()
    end)
    self.rootLayer:addChild(self.translationBtn, 100)
    self.translationBtn:hide()

    local heightBegin = 38 
    local heightSpace = 68
    self:createDialogByTag(ChatChannelType.SYSTEM, UI.TEXT_1170305, 706, heightBegin, 440) 
    self:createDialogByTag(ChatChannelType.WORLD, UI.TEXT_1213207, 706 , heightBegin + heightSpace * 1, 360)
    self:createDialogByTag(ChatChannelType.TEAM, UI.TEXT_1170306, 706 , heightBegin + heightSpace * 2, 360)
    self:createDialogByTag(ChatChannelType.GUILD, UI.TEXT_1170307, 706 , heightBegin + heightSpace * 3, 360) 
    self:createDialogByTag(ChatChannelType.NEAR, UI.TEXT_1170333, 706 , heightBegin + heightSpace * 4, 360) 
    self:createDialogByTag(ChatChannelType.PERSONAL, UI.TEXT_1170308, 706 , heightBegin + heightSpace * 5, 265) 

    local flag = UI.Animation:create()
    flag:init("effect_ui_general_dianhua.json", "effect_ui_general_dianhua.atlas", 1);
    flag:leftBottom(64, 16)
    flag:setScale(0.8)
    self.rootLayer:addChild(flag, 200)
    flag:setAnimation("idle", true)
    self.flag = flag
end
 
function ChatMainLayer:translationClick()
    Game.ChatManager:getInstance().isInTranslateMode = not Game.ChatManager:getInstance().isInTranslateMode
    if Game.ChatManager:getInstance().isInTranslateMode then
        self.translationBtn:setNormal("ui_chat_button_translation_1.png")
        self.translationBtn:setSelected("ui_chat_button_translation_0.png")
    else
        self.translationBtn:setNormal("ui_chat_button_translation_0.png")
        self.translationBtn:setSelected("ui_chat_button_translation_1.png")
    end
    print("----translationClick----", self.selectedTag, self.tagDialogLayer)
    local dialogLayer = self.tagDialogLayer[self.selectedTag]
    if dialogLayer then
        dialogLayer:checkTranslateMode()
    end
end

function ChatMainLayer:autoChangeToNoTranslation()
    if Game.ChatManager:getInstance().isInTranslateMode then
        self:translationClick()
    end
end

function ChatMainLayer:createDialogByTag(tag, name, posx, posy, height)
    local button = UI.Button:create()
    button:refreshClickSize(true)
    -- button:enableDebugDraw()
    button:init("ui_btn_gray2_0.png","ui_btn_gray2_1.png","ui_btn_gray2_1.png")
    button:leftUp(posx, posy)
    button:addEventListener(UIEvent.BUTTON_CLICK,self, self.onChangeTagClick)
    self.rootLayer:addChild(button, 30)
    button:setTextFont(UI.FONT_STANDARD, 20, UI.FONT_COLOR_41_41_45)
    button:closeClickScale()
    -- name = AvalonUtil:splitChinese(name)
    button:setText(name)
    button:setTag(tag)
    -- button:setTextWidth(30)
    self.tagBtns[tag] = button
    button:addEventListener(UIEvent.BUTTON_DISABLE,self,function()
        button:setTextFont(UI.FONT_STANDARD, 20, UI.FONT_COLOR_220_211_147)
    end)
    local dialogLayer = UI.ChatDialogLayer:create(tag, ChatDialogType.MainLayer)
    dialogLayer:init(610, height, true)
    dialogLayer:leftUp(100, 40)
    self.rootLayer:addChild(dialogLayer, 5)
    self.tagDialogLayer[tag] = dialogLayer

    if tag == ChatChannelType.PERSONAL then
        dialogLayer:leftUp(100, 140)
    end

    local redPoint = AvalonUtil.createRedPoint(button, 5, 4, 20)
    redPoint:hide()
    redPoint:setName("REDPOINT")
    if Game.ChatManager:getInstance():isShowRedPoint(tag) then
        redPoint:show()
    end
end

function ChatMainLayer:refreshTips()
    self.tip:setText("")
    self.lockTip:hide()
    self.sendBtn:hide()
    local libIDEditPosX = self.libIDEdit:getPositionX()
    self.libIDEdit:setPositionX(-winSize.width)
    if self.selectedTag == ChatChannelType.PERSONAL then
        local privateChatLV = checkint(Config.General:getValueForKey("PrivateChatLV"))
        local master = RoleDataManager:getMaster()
        if master and master:getLevel() >= privateChatLV then
            if self.personalChatPlayer == nil and not self.isHavePersonalMsg then
                self.tip:setText(UI.TEXT_1170310)
            elseif not self.isHavePersonalMsg then
                self.tip:setText(UI.TEXT_1170340)
            end
            self.sendBtn:show()
            self.libIDEdit:setPositionX(252)
        else
            if not self.isHavePersonalMsg then
                self.tip:setText(UI.TEXT_1170340)
            end
            self.lockTip:setText(string.format(UI.TEXT_1212021, privateChatLV))
            self.lockTip:show()
        end     
    elseif self.selectedTag == ChatChannelType.TEAM then
        if not TeamDataManager:hasTeam() and not self.isHaveTeamMsg then
            self.tip:setText(UI.TEXT_1170320)
            self.lockTip:show()
            self.lockTip:setText(UI.TEXT_1212018)
        elseif not TeamDataManager:hasTeam() then
            self.lockTip:setText(UI.TEXT_1212018)
            self.lockTip:show()
        else
            if not self.isHaveTeamMsg then
                self.tip:setText(UI.TEXT_1170340)
            end
            self.sendBtn:show()
            self.libIDEdit:setPositionX(252)
        end
    elseif self.selectedTag == ChatChannelType.GUILD then 
        if not GameDataManager:getIsJoinGuild() and not self.isHaveGuildMsg then
            self.tip:setText(UI.TEXT_1170321)
            self.lockTip:show()
            self.lockTip:setText(UI.TEXT_1212017)
        elseif not GameDataManager:getIsJoinGuild() then
            self.lockTip:show()
            self.lockTip:setText(UI.TEXT_1212017)
        else
            if not self.isHaveGuildMsg then
                self.tip:setText(UI.TEXT_1170340)
            end
            self.sendBtn:show()
            self.libIDEdit:setPositionX(252)
        end
    elseif self.selectedTag == ChatChannelType.NEAR then 
        local nearChannelUnloclLevel = checkint(Config.General:getValueForKey("NearChannelUnloclLevel"))
        local master = RoleDataManager:getMaster()
        if master and master:getLevel() >= nearChannelUnloclLevel then
            self.sendBtn:show()
            self.libIDEdit:setPositionX(252)
        else
            self.lockTip:setText(string.format(UI.TEXT_1212021, nearChannelUnloclLevel))
            self.lockTip:show()
        end
        if not self.isHaveNearMsg then
            self.tip:setText(UI.TEXT_1170340)
        end
    elseif self.selectedTag == ChatChannelType.WORLD then
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_WorldChat) then
            self.sendBtn:show()
            self.libIDEdit:setPositionX(252)
        else
            self.lockTip:setText(UI.TEXT_1213209)
            self.lockTip:show()
        end
        if not self.isHaveWorldMsg then
            self.tip:setText(UI.TEXT_1170340)
        end
    elseif self.selectedTag == ChatChannelType.SYSTEM then
        if not self.isHaveSysMsg then
            self.tip:setText(UI.TEXT_1170340)
        end
    end

    -- add by zp CO-16488【屏蔽】游戏中可以个其他玩家发消息的地方都需要屏蔽掉
    local SdkManager = require"app.game.SdkManager"
    if SdkManager:responsePolicySwitch() then
        local SdkBox = require("utils.sdkbox.SdkBox")
        local target = SdkBox:getInstance():getVersionTarget()
        if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            self.sendBtn:hide() 
            self.lockTip:hide()
            self.libIDEdit:setPositionX(-winSize.width)
        end
    end
end

-- 模版函数：更新组建的视图(必备)
function ChatMainLayer:onUpdateView()
end

function ChatMainLayer:onEnter()
    -- ChatMainLayer.super.onEnter(self)
end

-- 注册监听事件(可选)
function ChatMainLayer:registerListener()
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_CHAT_REFRESH_TIPS, self, self.refreshTips)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
end

function ChatMainLayer:onTouchOutSizeEvent()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
    self:autoChangeToNoTranslation()
    self:close()
end


-- 注销监听事件(可选)
function ChatMainLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CHAT_REFRESH_TIPS, self, self.refreshTips)
end

function ChatMainLayer:showByPosition()
    Avalon.AudioManager:playSound("1501")
    self:show()
    self:center()
    self:setScale(0.01)
    self:setAnchorPoint(0.5, 0.5)
    local scaleAction = cc.ScaleTo:create(0.15, 1, 1)
    local easeScaleAction = cc.EaseOut:create(scaleAction, 4)
    self:runAction(easeScaleAction)

    if self.selectPlayerBtn == nil then
        require "app.ui.social.chat.ChatQuickSwitchPanel"
        self.selectPlayerBtn = UI.ChatQuickSwitchPanel:create()
        self.selectPlayerBtn:init(500, function(chatData)
            self:setPersonalChatPlayer(chatData)
        end)
        self.selectPlayerBtn:leftUp(120, 60)
        self.rootLayer:addChild(self.selectPlayerBtn, 10)

        local curChatTip = UI.Text:create()
        curChatTip:init(UI.TEXT_1213208, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        curChatTip:leftUp(-14, -18)
        self.selectPlayerBtn:addChild(curChatTip, 10)

        local line = UI.Image9:create()
        line:init("ui_scale9image_banner_line_long.png", CCRectMake(20,1,1,1), cc.size(547, 2))
        line:centerBottom(-6)
        self.selectPlayerBtn:addChild(line, 10)
    end

    if self.selectedTag == nil then
        if TeamDataManager:hasTeam() then
            self:autoChangeTag(ChatChannelType.TEAM)
        elseif GameDataManager:getIsJoinGuild()  then
            self:autoChangeTag(ChatChannelType.GUILD)
        elseif self.personalChatPlayer ~= nil then
            self:autoChangeTag(ChatChannelType.SYSTEM)
        else
            self:autoChangeTag(ChatChannelType.SYSTEM)
        end 
    else
        self:autoChangeTag(self.selectedTag)
    end
    self:refreshTips()
end

function ChatMainLayer:close()
    self:removeFromParent(false)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
end

function ChatMainLayer:handleKeyBackUp()
    if (self:isHide()) then
        return false
    else
        self:close()
        return true
    end
end


function ChatMainLayer:onSendClick()
    print("---------ChatMainLayer:onSendClick()")

    local func = function(message)
        self.sendBtn:enable()
    -- local message = self.libIDEdit:getText() or ""
        message = string.trim(message)
        if self.goodsData ~= nil then
            local goodName = string.format(UI.TEXT_1170301, self.goodsData:getName())
            local strList = string.split(message, goodName)
            local checkList = {}
            for k, v in ipairs(strList) do
                if v ~= "" then
                    v = ToolsUtil:checkMaskword(v)
                end
                table.insert(checkList, v)
            end
            local tempMessage = ""
            local size = #checkList
            for k, v in ipairs(checkList) do
                if k ~= size then
                    tempMessage = tempMessage..v..goodName
                else
                    tempMessage = tempMessage..v
                end
            end
            message = tempMessage
        else
            message = ToolsUtil:checkMaskword(message)
        end
        if message == "" then
            UI.ScrollBar:createByText(UI.TEXT_1170309)
            return
        end

        if self.selectedTag == ChatChannelType.PERSONAL then
            if self.personalChatPlayer == nil then
                UI.ScrollBar:createByText(UI.TEXT_1170310)
                return
            end
            if self.personalChatPlayer and not Game.FriendManager:getInstance():isFriend(self.personalChatPlayer.pk) then
                UI.ScrollBar:createByTextID(1112917)
                return
            end
        end


        if self.selectedTag == ChatChannelType.TEAM and not TeamDataManager:hasTeam() then
            UI.ScrollBar:createByText(UI.TEXT_1170320)
            return
        end
        if self.selectedTag == ChatChannelType.GUILD and not GameDataManager:getIsJoinGuild() then
            UI.ScrollBar:createByText(UI.TEXT_1170321)
            return
        end
        local exteraLength = 0
        if self.goodsData ~= nil then
            exteraLength = string.len(self.goodsData:getName()) / 2 * INPUT_BOX_FONT_SIZE
        end
        if AvalonUtil:isUpLimiteStr(message, SEND_MESSAGE_WIDTH_LIMIT + exteraLength, INPUT_BOX_FONT_SIZE) then
            UI.ScrollBar:createByText(UI.TEXT_1170311)
            return 
        end

        local isBan, banType, timeStr = Game.ChatManager:getInstance():isBanByChannelType(self.selectedTag)
        -- print("---isBan, banType, timeStr ---", isBan, banType, timeStr)
        if isBan and banType == PublicDefine.BanChatType.BanChatType_Ban then
            UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(string.format(UI.TEXT_1170418, timeStr))
            return
        end

        local isCd, remainStr = self:isInCd(self.selectedTag)
        if isCd then
            UI.ScrollBar:createByText(string.format(UI.TEXT_1170332, remainStr))
            return
        end

        if RoleBehaviorManager:chatSysCheck() then
            printWarn(" been blocked when sending chat message!")
            return    
        end

        local sender = RoleDataManager:getMaster() 
        local senderPk = sender:getPK()
        local senderUserId = sender:getUserID()
        local senderName = sender:getNickName()
        local contentTable = self:getInstance():generateContent(message)
        -- dump(contentTable, "contentTable")
        local pbBytes = Game.ChatManager:getInstance():compressString(contentTable, PublicDefine.ChatMsgContentTextType.TYPE_XML)
        if isBan and banType == PublicDefine.BanChatType.BanChatType_Isolated then
        else
            if self.selectedTag ~= ChatChannelType.PERSONAL then
                if self.selectedTag == ChatChannelType.WORLD and mvc.activityAnnivesaryLotteryModel:isCanSign(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat) and not isCd then 
                    local annivesaryLotteryData = mvc.activityAnnivesaryLotteryModel:getAnnivesaryLotteryData(PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
                    local text = annivesaryLotteryData.chatContent
                    if text and message == text then
                        Net.NetActivitySystem:requestAnnivesaryLotterySign(annivesaryLotteryData.ID, PublicDefine.AnniversaryLuckyDrawSignType.AnniversaryLuckyDrawSign_WorldChat)
                    end
                end
                GameManager:sendChatMessage(self.selectedTag, pbBytes, nil, nil, nil)
            else
                self.personalChatPlayer = Game.ChatManager:getInstance():refreshPersonalUserID(self.personalChatPlayer)
                GameManager:sendChatMessage(self.selectedTag, pbBytes, self.personalChatPlayer.pk, self.personalChatPlayer.userID, 
                    self.personalChatPlayer.nickName)
            end
        end
        
        -- 序列化名字 不压缩加密 和内容拼接 然后发送本地
        local data = {}
        local senderData = {}
        senderData.pk = senderPk
        senderData.userID = senderUserId
        senderData.nickName = senderName
        senderData.sex = sender:getSex()
        senderData.faceDecodeID = sender:getFaceDecodeID()
        senderData.wearEquipId = GameDataManager:getInstance():getWearTempId()
        senderData.roleLV = sender:getLevel()
        senderData.reincarntionLv = sender:getReincarntionLv()

        if self.selectedTag ~= ChatChannelType.PERSONAL then
            local message = {}
            message.Speaker = senderData
            message.chatContent = pbBytes

            if self.selectedTag == ChatChannelType.TEAM then
                local messageBytes = ProtobufUtil:encode("ChatSystem.TeamChatMessage", message)
                data.pbBytes = messageBytes
            elseif self.selectedTag == ChatChannelType.GUILD then
                local messageBytes = ProtobufUtil:encode("ChatSystem.GuildChatMessage", message)
                data.pbBytes = messageBytes
            elseif self.selectedTag == ChatChannelType.NEAR then
                local messageBytes = ProtobufUtil:encode("ChatSystem.NearChatMessage", message)
                data.pbBytes = messageBytes
            elseif self.selectedTag == ChatChannelType.WORLD then
                local messageBytes = ProtobufUtil:encode("ChatSystem.WorldChatMessage", message)
                data.pbBytes = messageBytes
            end
        else
            local reciverData = {}
            reciverData.pk = self.personalChatPlayer.pk
            reciverData.userID = self.personalChatPlayer.userID
            reciverData.nickName = self.personalChatPlayer.nickName
            reciverData.sex = self.personalChatPlayer.sex
            reciverData.faceDecodeID = self.personalChatPlayer.faceDecodeID
            reciverData.wearEquipId = self.personalChatPlayer.wearEquipId
            reciverData.roleLV = self.personalChatPlayer.roleLV
            reciverData.reincarntionLv = self.personalChatPlayer.reincarntionLv

            local message = {}
            message.chatFrom = senderData
            message.chatTo = reciverData
            message.chatContent = pbBytes
            local messageBytes = ProtobufUtil:encode("ChatSystem.PrivateChatMessage", message)
            data.pbBytes = messageBytes
        end

        if self.selectedTag == ChatChannelType.PERSONAL then
            data.messageType = ChatMessageType.PERSONAL
        elseif self.selectedTag == ChatChannelType.TEAM then
            data.messageType = ChatMessageType.TEAM
        elseif self.selectedTag == ChatChannelType.GUILD then
            data.messageType = ChatMessageType.GUILD
        elseif self.selectedTag == ChatChannelType.NEAR then
            data.messageType = ChatMessageType.NEAR
        elseif self.selectedTag == ChatChannelType.WORLD then
            data.messageType = ChatMessageType.WORLD
        end
        data.PBType = self.selectedTag 
        data.isSelf = true
        if self.selectedTag ~= ChatChannelType.WORLD then
            Game.ChatManager:getInstance():push(data)
        end
        self:clearEditorBox()
    end

    local gameWordDetectionManager = require"app.game.GameWordDetectionManager"
    local message = self.libIDEdit:getText() or ""
    if message == "" then
        UI.ScrollBar:createByText(UI.TEXT_1170309)
        return
    end
    self.sendBtn:disable()
    gameWordDetectionManager:getInstance():textDetection(message,func,function()
        self.sendBtn:enable()
    end, self.selectedTag)
end

function ChatMainLayer:onHornClick(message)
    print("---------ChatMainLayer:onHornClick()")
    if message == "" then
        UI.ScrollBar:createByText(UI.TEXT_1170309)
        return
    end
    if AvalonUtil:isUpLimiteStr(message, SEND_MESSAGE_WIDTH_LIMIT, INPUT_BOX_FONT_SIZE) then
        UI.ScrollBar:createByText(UI.TEXT_1170311)
        return 
    end

    local isBan, banType, timeStr = Game.ChatManager:getInstance():isBanByChannelType(ChatChannelType.WORLD)
    if isBan and banType == PublicDefine.BanChatType.BanChatType_Ban then
        UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(string.format(UI.TEXT_1170418, timeStr))
        return
    end

    if RoleBehaviorManager:chatSysCheck() then
        printWarn(" been blocked when sending chat message!")
        return    
    end

    local isCd, remainStr = self:isInCd(ChatChannelType.WORLD)
    if isCd then
        UI.ScrollBar:createByText(string.format(UI.TEXT_1170332, remainStr))
        return true
    end

    local sender = RoleDataManager:getMaster() 
    local senderPk = sender:getPK()
    local senderUserId = sender:getUserID()
    local senderName = sender:getNickName()
    local contentTable = self:getInstance():generateContent(message, ChatMessageType.WORLD)
    local pbBytes = Game.ChatManager:getInstance():compressString(contentTable, PublicDefine.ChatMsgContentTextType.TYPE_XML)
    if isBan and banType == PublicDefine.BanChatType.BanChatType_Isolated then
    else
        GameManager:sendChatMessage(ChatChannelType.WORLD, pbBytes)
    end
end

function ChatMainLayer:isInCd(channelType)
    local needCdTime = 1
    if channelType == ChatChannelType.PERSONAL then
        needCdTime = 1
    elseif channelType== ChatChannelType.TEAM then
        needCdTime = 2
    elseif channelType == ChatChannelType.GUILD then
        needCdTime = 3
    elseif channelType == ChatChannelType.NEAR then
        needCdTime = checkint(ConfigManager:getGeneralForKey("NearChannelPublicCDTime"))
    elseif channelType == ChatChannelType.WORLD then
        needCdTime = checkint(ConfigManager:getGeneralForKey("worldChatCD"))
    end
    local curTime = GameManager:getNormalServerTime()
    local lastTime = Game.ChatManager:getInstance():getCDTime(channelType)
    if lastTime > curTime then
        return true, lastTime - curTime
    end
    -- local isCd, remainTime = Game.ChatManager:getInstance():isInCd(channelType)
    -- if isCd then
    --     return true, remainTime
    -- end
    Game.ChatManager:getInstance():refreshCDTime(channelType, curTime + needCdTime)
    return false, 0
end

function ChatMainLayer:generateContent(message, messageType)
    if messageType == nil then
        messageType = ChatMessageType.TEAM
        if self.selectedTag == ChatChannelType.PERSONAL then
            messageType = ChatMessageType.PERSONAL
        elseif self.selectedTag == ChatChannelType.TEAM then
            messageType = ChatMessageType.TEAM
        elseif self.selectedTag == ChatChannelType.GUILD then
            messageType = ChatMessageType.GUILD
        elseif self.selectedTag == ChatChannelType.NEAR then
            messageType = ChatMessageType.NEAR
        elseif self.selectedTag == ChatChannelType.WORLD then
            messageType = ChatMessageType.WORLD
        end
    end

    local contentTable = {}
    if self.goodsData ~= nil then
        local goodName = string.format(UI.TEXT_1170301, self.goodsData:getName())
        local beginIndex, endIndex = string.find(message, goodName)
        -- print("-----goodName = "..goodName)
        -- print("-----beginIndex = "..beginIndex)
        -- print("-----endIndex = "..endIndex)
        local length = string.len(message) 
         -- print("-----length = "..length)
         -- print("-----message = "..message)
        if beginIndex == nil then
            self.goodsData = nil
            local content = Game.ChatManager:textTbData(message, UI.CHAT_MESSAGE_TYPE_FONT_COLOR[messageType])
            table.insert(contentTable, content)
        else
            local proText = string.sub(message, 1, beginIndex-1)
            local tailText = string.sub(message, endIndex + 1, length)
            proText = proText or ""
            local content = Game.ChatManager:textTbData(proText, UI.CHAT_MESSAGE_TYPE_FONT_COLOR[messageType])
            table.insert(contentTable, content)
            
            local content = Game.ChatManager:getInstance():getItemLinkData(self.goodsData)
            -- dump(content, "-----itemcontent")
            if content then
                table.insert(contentTable, content)
                if tailText ~= nil and tailText ~= "" then
                    local content = Game.ChatManager:textTbData(tailText, UI.CHAT_MESSAGE_TYPE_FONT_COLOR[messageType])
                    table.insert(contentTable, content)
                end
            end
        end 
    else
        local content = Game.ChatManager:textTbData(message, UI.CHAT_MESSAGE_TYPE_FONT_COLOR[messageType])
        table.insert(contentTable, content)
    end
    return contentTable
end

function ChatMainLayer:onChangeTagClick(sender)
    -- dump(sender, "sender")
    local tag = sender:getTag()
    self:autoChangeTag(tag)
end

function ChatMainLayer:autoChangeTag(tag)
    local SdkBox = require("utils.sdkbox.SdkBox")
    if SdkBox:getInstance():isSupportTranslationFunction() then
        if tag == ChatChannelType.TEAM or tag == ChatChannelType.GUILD or tag == ChatChannelType.PERSONAL or tag == ChatChannelType.NEAR or tag == ChatChannelType.WORLD then
           self.translationBtn:show()
        else
            self.translationBtn:hide()
        end
    end
    local lastDialogLayer = self.tagDialogLayer[self.selectedTag]
    if lastDialogLayer and lastDialogLayer.clearAllChild then
        lastDialogLayer:clearAllChild(true)
    end
    self.selectedTag = tag
    for k, v in pairs(self.tagBtns) do
        v:enable()
        v:setTextFont(UI.FONT_STANDARD, 20, UI.FONT_COLOR_41_41_45)
        -- v:leftUp(706, v:getUp())
    end
    local btn = self.tagBtns[tag]
    btn:disable()
    btn:getChildByName("REDPOINT"):hide()
    Game.ChatManager:getInstance():refreshRedPoint(tag)
    -- btn:leftUp(710, btn:getUp())
    local dialogLayer = self.tagDialogLayer[tag]
    for k, v in pairs(self.tagDialogLayer) do
        v:leftUp(-winSize.width, v:getUp())
    end
    dialogLayer:leftUp(90, dialogLayer:getUp())
    if tag == ChatChannelType.SYSTEM or tag == BlackLayerTag then
        self.inputBg:setPosition(0, -winSize.height)
    elseif tag == ChatChannelType.PERSONAL then
        self.inputBg:setPosition(67, 31)
        self:setPersonalChatPlayer(self.personalChatPlayer)
    else
        self.inputBg:setPosition(67, 31)
    end
    self:refreshSelectPlayer(true)
    self:refreshTips()
    self:initDiaLogLayer()
    self:autoChangeToNoTranslation()
end

function ChatMainLayer:showMessage(data, isSelf)
    -- print("----ChatMainLayer:showMessage", data)
    -- dump(data)
    local dialogLayer = self.tagDialogLayer[data.channelType]
    if dialogLayer == nil then
        print("!!!!error dialogLayer is nil ")
        return 
    end
    if data.channelType  == ChatChannelType.PERSONAL then
        self.isHavePersonalMsg = true
    elseif data.channelType  == ChatChannelType.TEAM then
        self.isHaveTeamMsg = true
    elseif data.channelType  == ChatChannelType.GUILD then    
        self.isHaveGuildMsg = true
    elseif data.channelType  == ChatChannelType.WORLD then
        self.isHaveWorldMsg = true
    elseif data.channelType == ChatChannelType.NEAR then
        self.isHaveNearMsg = true
    elseif data.channelType == ChatChannelType.SYSTEM then
        self.isHaveSysMsg = true
    end
    dialogLayer:showMessage(data, isSelf)
    self:refreshTips()
    if not isSelf then
        self.flag:setAnimation("idle2", false)
        self.flag:addAnimation("idle", true)
    end

    if data.channelType  == ChatChannelType.PERSONAL then
        self:refreshSelectPlayer(false, data)
    end
    local btn = self.tagBtns[data.channelType]
    if data.channelType ~= ChatChannelType.SYSTEM and self.selectedTag ~= data.channelType and btn then
        local redPoint = btn:getChildByName("REDPOINT")
        if redPoint and Game.ChatManager:getInstance():isShowRedPoint(data.channelType) then
            redPoint:show()
        end
    end
end

--todo 编辑框逻辑
function ChatMainLayer:reciveLinkData(goodsData)
    if self:getInstance():isReviceLinkData() then
        UI.ScrollBar:createByText(UI.TEXT_1170312)
        return
    end
    local message = self.libIDEdit:getText()
    if AvalonUtil:isUpLimiteStr(message, SEND_MESSAGE_WIDTH_LIMIT, INPUT_BOX_FONT_SIZE) then
        UI.ScrollBar:createByText(UI.TEXT_1170311)
        return 
    end
    local goodName = string.format(UI.TEXT_1170301, goodsData:getName())
    self.libIDEdit:setText(message..goodName)
    self.goodsData = goodsData
    UI.ScrollBar:createByText(UI.TEXT_1170322)
end

function ChatMainLayer:clearEditorBox()
    self.libIDEdit:setText("")
    self.libIDEdit:setPlaceHolder(UI.TEXT_1170303)
    self.goodsData = nil
end

function ChatMainLayer:setDefaultText(text)
    if self.selectedTag == ChatChannelType.WORLD then
        -- self.libIDEdit:setText("")
        self.libIDEdit:setText(text)
        -- self.libIDEdit:setPlaceHolder(text)
    end
end

--判断message 中是否含有 goodsDataName
function ChatMainLayer:isReviceLinkData()
    if self.goodsData == nil then
        return false
    end
    local message = self.libIDEdit:getText()
    local goodName = string.format(UI.TEXT_1170301, self.goodsData:getName())
    local beginIndex, endIndex = string.find(message, goodName)
    if beginIndex ~= nil then
        return true
    end
    return false
end

--告诉组件需要选中的对象
function ChatMainLayer:setSelectedPerson(personalChatPlayer)
    if personalChatPlayer and self.selectPlayerBtn and self.selectedTag == ChatChannelType.PERSONAL then
        self.selectPlayerBtn:setSelectedByPK(personalChatPlayer.pk, true)
    end
end

function ChatMainLayer:setPersonalChatPlayer(personalChatPlayer)
    -- print("----------ChatMainLayer:setPersonalChatPlayer", personalChatPlayer)
    self.personalChatPlayer = personalChatPlayer
    local dialogLayer = self.tagDialogLayer[self.selectedTag]
    if self.personalChatPlayer and self.selectedTag == ChatChannelType.PERSONAL and dialogLayer then
        dialogLayer:setfiltPk(self.personalChatPlayer.pk)
    elseif self.personalChatPlayer == nil then
        self.tagDialogLayer[ChatChannelType.PERSONAL]:forceClear()
    end
end

function ChatMainLayer:editboxEventHandler(eventType)
    -- print("ChatMainLayer:editboxEventHandler(eventType) .. "..eventType)
    if eventType == "began" then
    elseif eventType == "ended" then
    elseif eventType == "changed" then
        self.lastInputText = self:judeInputTextLength()
    elseif eventType == "return" then
    end
end

function ChatMainLayer:judeInputTextLength()
    local message = self.libIDEdit:getText() or ""
    local isHave = string.find(message, "\n")
    if isHave ~= nil then
        message = string.gsub(message, "\n", "")
        self.libIDEdit:setText(message)
        AvalonUtil.closeKeyBoard(self.libIDEdit)
        return
    end
    local exteraLength = 0
    if self.goodsData ~= nil then
        exteraLength = string.len(self.goodsData:getName()) / 2 * INPUT_BOX_FONT_SIZE
    end
    if AvalonUtil:isUpLimiteStr(message, SEND_MESSAGE_WIDTH_LIMIT + exteraLength, INPUT_BOX_FONT_SIZE) then
        UI.ScrollBar:createByText(UI.TEXT_1170311)
        AvalonUtil.closeKeyBoard(self.libIDEdit)
        self.libIDEdit:setText(self.lastInputText)
        return self.lastInputText 
    end
    return message
end

function ChatMainLayer:initDiaLogLayer()
    -- print("----ChatMainLayer:initDiaLogLayer()------")
    local dialogLayer = self.tagDialogLayer[self.selectedTag]
    if dialogLayer then
        dialogLayer:initDiaLogLayer()
    end
end

function ChatMainLayer:forceClear()
    local dialogLayer = self.tagDialogLayer[self.selectedTag]
    if dialogLayer and dialogLayer.forceClear then
        dialogLayer:forceClear()
    end
end


function ChatMainLayer:addHeightByIndex(isToUp, index)
    local dialogLayer = self.tagDialogLayer[self.selectedTag]
    if dialogLayer then
        dialogLayer:addHeightByIndex(isToUp, index, 10, 8)
    end
end

function ChatMainLayer:translateCallback(eventType, chatChannelType, commonId, resultObject)
    local dialogLayer = self.tagDialogLayer[chatChannelType]
    if dialogLayer then
        dialogLayer:translateCallback(eventType, commonId, resultObject)
    end
end


--isRrefreshAll 是否全量刷新，否则只刷新 指定data
function ChatMainLayer:refreshSelectPlayer(isRrefreshAll, data)
    if self.selectPlayerBtn == nil then
        return
    end
    self.selectPlayerBtn:hide()
    self.selectPlayerBtn:leftUp(-winSize.width, self.selectPlayerBtn:getUp())
    if self.selectedTag == ChatChannelType.PERSONAL then
        self.selectPlayerBtn:show()
        self.selectPlayerBtn:leftUp(120, 60)
        if isRrefreshAll then
            self.selectPlayerBtn:updateView()
        elseif data.messageData then
            self.selectPlayerBtn:refreshRedPoint(data.messageData.chatFrom)
        end
    end
end