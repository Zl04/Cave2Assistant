-- ChatManager.lua
-- Author:ydli
-- 2017年09月11日
-- Using:聊天模块
local SceneManager = require("app.game.SceneManager")
local ChatManager = class("ChatManager")
local LanguageManager = require("app.game.LanguageManager")
local MachineManager = require("app.game.MachineManager")
local GameDataManager = require("app.game.GameDataManager")
Game = Game or {}
Game.ChatManager = ChatManager
-- local zip=require("zlib")  
require "cocos.cocos2d.json"
require "utils.Queue"

local winSize = cc.Director:getInstance():getWinSize()
local ProtobufUtil = require("utils.ProtobufUtil")

local scheduler = cc.Director:getInstance():getScheduler()

--队列维护
local Queue = Avalon.Queue
local PERSONAL_LIMITE_NUMBER = 10
local SHIELD_LIMITE_NUMBER = 10

local personl_list_fileName = "personalList3.ud" --私聊列表
local chat_message_fileName = "chatMessage_%dss3.ud" --本地缓存 聊天消息
local system_broadcast_fileName = "systemBroadcast.ud" --系统广播Index
local chat_blackList_fileName = "chatBlackList3.ud" --聊天黑名单
local transform_cache_fileName = "transformCaches3.ud" --翻译本地缓存
local chat_dialog_height_fileName = "dialogHeight3.ud" --记录聊天窗口的高度 用于下次打开界面 马上就能创建最准确的界面大小
local chat_cell_status_fileName = "chatCellStatus3.ud"  --用于记录每个聊天cell的翻译状态
local chat_red_point_fileName = "chatRedPoint3.ud"  --记录各频道和私聊对象的红点

local SPLIT_KEY = "|||"
local MSG_SAVE_LIMITE_NUMBER = 300--每个频道N条 本地缓存
local HTTP_REQUEST_LIMITE_COUNT = 3
local TRANSFORM_STRTB_CACHE_SIZE = 3000
local RICHTEXT_CACHE_SIZE = 100
local OPEN_RICHTEXT_CACHE = true
local TRANSLATE_CD_TIME = 10 --翻译按钮自动切换的 等待时间
local CELL_STATUS_CACHE = 1000 --用于记录每个聊天cell的翻译状态 存储上限

local WriteLocalChannelType = {
    ChatChannelType.TEAM,           -- 队伍频道
    ChatChannelType.GUILD,           -- 工会频道
    ChatChannelType.PERSONAL,           --  私聊频道
    -- ChatChannelType.NEAR,           --附近
}



function ChatManager:ctor()
    self.schedulerID = 0
    self.isHaveLoad = false--是否加载本地存储的消息
    self.messageQueue = nil
    self.personlPlayerList = {}
    self.personlUserIDMap = {} -- pk 和 userID的 映射
    self.shieldPlayerMap = {} -- 屏蔽玩家列表
    self.transFormStrTbCache = {} -- 翻译文本的缓存
    self.richTextCache = {} -- 富文本缓存
    self.dialogHeights = {} -- 记录聊天窗口的高度 用于下次打开界面 马上就能创建最准确的界面大小
    self.cellStatus = {} -- -用于记录每个聊天cell的翻译状态
    self.redPoint = {} --聊天红点
    self.cdTimeMap = {} --聊天cd时间
    self.isLockTouchTranslate = false --是否锁住翻译点击事件(防止超链接点透 触发翻译)
    self.isInTranslateMode = false --是否在翻译模式下（可能会存在本地）
    self.dungeonMsgLock = false --大秘境消息锁
    self.taskMsgLock = false --任务消息锁

    self.requestCount = 0--系统公告http请求计数
    self.systemBroadcastIndex = 0
    self.intervalTime = 0 --每秒 刷新间隔

    self.requestLampCount = 0--跑马灯http请求计数

    self.delayTime = 0
    self.translateCDTargetTime = 0 --翻译按钮切回普通模式的时间搓


    --新跑马灯数据 --服务器下发队列，客户端无条件覆盖。 如果时间还没过期就可以播放，每播放一次 客户端减一次
    --设计的特殊点：每条播放时间为60S（待定），所以 1、根据字数 和 时间动态适配速度，2、速度有上限，最大速度播完了也不足60S的 剩余时间等待。
    --            这样设计的目的 是方便服务器记录客户端播放次数
    self.lampQueue = {}
    self.lampRunning = false
end

function ChatManager:dtor()
    if self.schedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
    self.isHaveLoad = false--是否加载本地存储的消息
    self.messageQueue = nil
    self.personlPlayerList = {}
    self.personlUserIDMap = {} -- pk 和 userID的 映射
    self.shieldPlayerMap = {} -- 屏蔽玩家列表
    self.transFormStrTbCache = {} -- 翻译文本的缓存
    for k, v in ipairs(self.richTextCache) do
        v._richText:release()
    end
    self.richTextCache = {} -- 富文本缓存
    self.dialogHeights = {} -- 记录聊天窗口的高度 用于下次打开界面 马上就能创建最准确的界面大小
    self.cellStatus = {} -- -用于记录每个聊天cell的翻译状态
    self.redPoint = {} --聊天红点
    self.cdTimeMap = {} --聊天cd时间
    self.dungeonMsgLock = false
    self.taskMsgLock = false --任务消息锁
    self.requestCount = 0
    self.systemBroadcastIndex = 0
    self.intervalTime = 0 --每秒 刷新间隔

    self.requestLampCount = 0
    self.delayTime = 0
    self.translateCDTargetTime = 0 --翻译按钮切回普通模式的时间搓
    self.lampQueue = {}
    self.lampRunning = false
end

function ChatManager:getInstance()
    if g_chatManager == nil then
        g_chatManager = ChatManager.new()
        g_chatManager:init()
        g_chatManager:registerNameClickEvent()
    end
    return g_chatManager
end


function ChatManager:purgeInstance()
    if g_chatManager ~= nil then
        g_chatManager = nil
    end
end

function ChatManager:clear()
    self:dtor()
    self:purgeInstance()
    if UI.ChatMainLayer and UI.ChatMainLayer:isInit() then
        UI.ChatMainLayer:getInstance():purgeInstance()
    end
    if UI.ChatQuickLayer and UI.ChatQuickLayer:isInit() then
        UI.ChatQuickLayer:getInstance():purgeInstance()
    end
end


-- 回档（恢复）清理数据
function ChatManager:restoreClear()
end


function ChatManager:init()
    print("ChatManager:init")
    self.messageQueue = Queue:create()
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 0.1, false)
    self:readSysBroadcastIndex()
    self:checkSystemBroadcast()

    local SdkBox = require("utils.sdkbox.SdkBox")
    SdkBox:getInstance():setGoogleTranslationActionListener(handler(self,self.googleTranslationActionCallback))        
end

function ChatManager:googleTranslationActionCallback(eventType, commandId, resultObject)
    print("----ChatManager:googleTranslationActionCallback-----", eventType, commandId, resultObject)
    local paramList = string.split(commandId, "_")
    local size = #paramList
    if size < 2 then
        return
    end
    if eventType == GOOGLE_TRANSLATE_EVENT.TRANSLATE_EVENT then
        local strList = {}
        for k, v in ipairs(resultObject) do
            table.insert(strList, v.translatedText)
        end
        resultObject = strList
    end
    local chatChannelType = tonumber(paramList[1] or 0)
    if chatChannelType == ChatChannelType.QUICK then
        UI.ChatQuickLayer:getInstance():translateCallback(eventType, chatChannelType, paramList[2], resultObject)
    else
        UI.ChatMainLayer:getInstance():translateCallback(eventType, chatChannelType, paramList[2], resultObject)
    end       
end
--[[data = {messageType, PBType pbBytes, gTime, isSelf} 
    PBType 解包pbmessgae ChatChannelType
    messageType  消息类型  ChatMessageType
    pbBytes：数据结构 == true 为pb数据 否则文本数据  -- 要转成table  messageData
    gTime:消息生成的本地时间
    isSelf: 是否是自己本地发送的消息
]]
function ChatManager:update(dt)
    -- print("-------ChatManager:update(dt)")
    if not UI.ChatMainLayer:isInit() then
        return
    end
    local number = self.messageQueue:size()
    if self.finshReadLocalMsg and number > 1 then
        number = 1
    end
    local isCheck = false
    for i = 1, number do
        local data = self:pop()
        if data ~= nil then
            if data.pbBytes then
                self:unCompressPb(data) --pb table
            end
            if data.isLocal then
                UI.ChatMainLayer:getInstance():showMessage(data, data.isSelf)
                isCheck = true
            else
                local channelType = self:showMessage(data, true, data.isSelf)
                local MsgType = ChatMessageType
                if data.messageType == MsgType.TEAM or data.messageType == MsgType.GUILD or data.messageType == MsgType.PERSONAL or data.messageType == MsgType.NEAR or data.messageType == MsgType.WORLD then
                    data.content = nil
                    data._status = nil
                    local xmlStr = Base64Encode(json.encode(data))
                    self:appendChatMessage(RoleDataManager:getMasterPK(), xmlStr, channelType)
                    if data.messageType == MsgType.TEAM then
                        self:showQuickChatTips(data)
                    end
                end
            end
        end
    end
    if isCheck then
        self.finshReadLocalMsg = false
    else
        self.finshReadLocalMsg = true
    end
    self:checkLocalSystemMsg(dt)
    self:refreshTranlateCDTime()
end

function ChatManager:showQuickChatTips(data)
    dump(data,   "----------ChatManager:showQuickChatTips---------")
    local selfKey = RoleDataManager:getMasterPK()
    local speaker = nil
    if data.PBType ==  ChatChannelType.PERSONAL then
        speaker = data.messageData.chatFrom  
    else
        speaker = data.messageData.Speaker
    end

    local chatContent = data.messageData.chatContent
    if chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_TEXT then
        local text = chatContent.text
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_QUICK_CHAT_TIPS, speaker.pk, text)
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_ID then
        local text = ConfigManager:getQuickChatDataById(chatContent.textId)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_QUICK_CHAT_TIPS, speaker.pk, text)
    end
end
function ChatManager:refreshTranlateCDTime()
    if self.translateCDTargetTime ~= 0 then
        local curTime = os.time()
        if self.translateCDTargetTime < curTime then
            --切回到普通模式
            self.translateCDTargetTime = 0
            UI.ChatMainLayer:getInstance():autoChangeToNoTranslation()
        end
    end
end

function ChatManager:resetTranlateCDTime()
    self.translateCDTargetTime = os.time() + TRANSLATE_CD_TIME
end

function ChatManager:loadLoalFile()
    xpcall(function()
        self:_loadLoalFile()
    end, 
    function(e) 
        self:writePersonalList(personl_list_fileName, {})
        self:writePersonalList(chat_blackList_fileName, {})
        self:writePersonalList(chat_dialog_height_fileName, {})
        self:writePersonalList(chat_cell_status_fileName, {})
        for _, channelType in pairs(WriteLocalChannelType) do
            self:writeChatMessage(RoleDataManager:getMasterPK(), "###", channelType)
        end
        self.personlPlayerList = {}
        self.shieldPlayerMap = {}
        self.dialogHeights = {}
        print("---- 捕获已知异常-------")
        print("-----error  清空本地聊天消息、历史聊天对象、聊天黑名单列表------")
        print(debug.traceback()) 
        print("---- 捕获已知异常-------")
       -- return e 
    end, 1)  
end

function ChatManager:_loadLoalFile()
    if self.isHaveLoad then
        return
    end
    self.personlPlayerList = self:readPersonalList(personl_list_fileName)
    self.shieldPlayerMap = self:readPersonalList(chat_blackList_fileName)
    self.transFormStrTbCache = self:readPersonalList(transform_cache_fileName)
    self.dialogHeights = self:readPersonalList(chat_dialog_height_fileName)
    self.cellStatus = self:readPersonalList(chat_cell_status_fileName)
    self.redPoint = self:readPersonalList(chat_red_point_fileName, true)

    if table.nums(self.personlPlayerList) > PERSONAL_LIMITE_NUMBER then
        local list = {}
        for k, v in pairs(self.personlPlayerList) do
            table.insert(list, v)
        end
        table.sort(list, function(a, b)
            return a.lastTalkTime > b.lastTalkTime
        end)
        local size = #list
        for index = size, PERSONAL_LIMITE_NUMBER + 1, -1 do
            local data = list[index]
            self.personlPlayerList[data.pk] = nil
            table.remove(list, index)
        end
        self:writePersonalList(personl_list_fileName, self.personlPlayerList)
    end
    if table.nums(self.shieldPlayerMap) > SHIELD_LIMITE_NUMBER then
        local list = {}
        for k, v in pairs(self.shieldPlayerMap) do
            table.insert(list, v)
        end
        table.sort(list, function(a, b)
            return a.shieldTime > b.shieldTime
        end)
        local size = #list
        for index = size, SHIELD_LIMITE_NUMBER + 1, -1 do
            local data = list[index]
            self.shieldPlayerMap[data.pk] = nil
            table.remove(list, index)
        end
        self:writePersonalList(chat_blackList_fileName, self.shieldPlayerMap)
    end
    
    local size = #self.transFormStrTbCache
    if size > TRANSFORM_STRTB_CACHE_SIZE then
        for i = 1, size - TRANSFORM_STRTB_CACHE_SIZE do
            table.remove(self.transFormStrTbCache, 1)
        end
        self:writePersonalList(transform_cache_fileName, self.transFormStrTbCache)
    end

    local size = #self.cellStatus
    if size > CELL_STATUS_CACHE then
        for i = 1, size - CELL_STATUS_CACHE do
            table.remove(self.cellStatus, 1)
        end
        self:writePersonalList(chat_cell_status_fileName, self.cellStatus)
    end

    for _, channelType in pairs(WriteLocalChannelType) do
        local msgList = self:readChatMessage(RoleDataManager:getMasterPK(), channelType)
        for k, v in ipairs(msgList) do
            -- v = string.trim(v)
            if v ~= "###" then
                -- print("------v----- = "..v)
                local data = json.decode(Base64Decode(v))
                data.content = nil
                data._status = nil
                data.channelType = channelType
                data.isLocal = true
                self:getInstance():push(data)
            end
        end
    end
    self.isHaveLoad = true
end

function ChatManager:showMessage(data, isShowToQuick, isSelf)
    data = clone(data)
    local channelMap = ChatMessageTypeMap[data.messageType]
    local isToQUick = false
    for k, v in pairs(channelMap) do
        if v == ChatChannelType.QUICK then
            isToQUick = true
            break
        end
    end
    
    local channelType = 0
    for k, v in pairs(channelMap) do
        if v ~= ChatChannelType.QUICK then
            data.channelType = v
            UI.ChatMainLayer:getInstance():showMessage(data, isSelf)
            channelType = v
        end
    end
    if isToQUick and isShowToQuick then
        data.channelType = ChatMessageTypeIcon[data.messageType]
        UI.ChatQuickLayer:getInstance():showMessage(data)
    end
    return channelType
end

--[[data = {messageType, PBType pbBytes, gTime, isSelf} 
    PBType 解包pbmessgae ChatChannelType
    messageType  消息类型  ChatMessageType
    pbBytes：数据结构 == true 为pb数据 否则文本数据  -- 要转成table  messageData
    gTime:消息生成的本地时间
    isSelf: 是否是自己本地发送的消息
]]
function ChatManager:push(data)
    if ServerConfigUtil:isForbideChat() then
        return
    end
    if data == nil or type(data) ~= "table" then
       return 
    end
    data.gTime = data.gTime or AvalonUtil.getCurrentTime()--消息生成时间 用于显示
    self.messageQueue:push(data)    
end

function ChatManager:pop()
    -- print("--------------- ChatManager:pop")
    return self.messageQueue:front()
end

--序列化普通文本 "<font size='%d' color='%s' face='%s'>%s</font>"
function ChatManager:textTbData(text, fontColor, fontSize, fontName)
    local tableData = {}
    tableData.tagType = PublicDefine.ContentTagTypeKey.font
    tableData.value = text
    tableData.face = fontName
    tableData.size = fontSize
    tableData.color = AvalonUtil:colorRGB2Str(fontColor)
    -- local pbBytes = proto:encode("ChatSystem.TagValue", tableData)
    return self:hideDefaultParam(tableData)
end

--序列化玩家 公会名字 并生成 超连接数据 data is table
function ChatManager:guildNameTbData(name, data, fontColor, fontSize, fontName)
    local tableData = {}
    tableData.tagType = PublicDefine.ContentTagTypeKey.click
    tableData.value = name
    tableData.face = fontName
    tableData.size = fontSize
    tableData.color = AvalonUtil:colorRGB2Str(fontColor)
    tableData.data = data
    tableData.dataType = PublicDefine.TagClickTypeKey.GuildName
    return self:hideDefaultParam(tableData)
end

--序列化玩家 名字 并生成 超连接数据 data is table
function ChatManager:nickNameTbData(name, data, fontColor, fontSize, fontName)
    local tableData = {}
    tableData.tagType = PublicDefine.ContentTagTypeKey.click
    tableData.value = name
    tableData.face = fontName
    tableData.size = fontSize
    tableData.color = AvalonUtil:colorRGB2Str(fontColor)
    tableData.data = data
    tableData.dataType = PublicDefine.TagClickTypeKey.NickName
    -- local pbBytes = proto:encode("ChatSystem.TagValue", tableData)
    return self:hideDefaultParam(tableData)
end

--序列化 道具名字 并生成 超连接数据 data is bytes "<click size='%d' color='%s' face='%s' data='%s'>[%s]</click>"
function ChatManager:itemNameTbData(name, itemData, fontColor, fontSize, fontName)
    local tableData = {}
    tableData.tagType = PublicDefine.ContentTagTypeKey.click
    tableData.value = name
    tableData.face = fontName
    tableData.size = fontSize
    tableData.color = AvalonUtil:colorRGB2Str(fontColor)
    tableData.data = itemData
    tableData.dataType = PublicDefine.TagClickTypeKey.ItemName
    -- local pbBytes = proto:encode("ChatSystem.TagValue", tableData)
    return self:hideDefaultParam(tableData)
end

--序列化logo 图片 和图片上的文本 mode = "<img src='%s' text='%s' size='%d' color='%s' face='%s'></img>"
function ChatManager:imageTbData(iconName, text, fontColor, fontSize, fontName)
    local tableData = {}
    tableData.tagType = PublicDefine.ContentTagTypeKey.img
    tableData.src = iconName
    tableData.text = text
    tableData.face = fontName
    tableData.size = fontSize
    tableData.color = AvalonUtil:colorRGB2Str(fontColor)
    -- local pbBytes = proto:encode("ChatSystem.TagValue", tableData)
    return self:hideDefaultParam(tableData)
end


--序列化 内部超链接 并生成 超连接数据 data is bytes "<click size='%d' color='%s' face='%s' data='%s'>[%s]</click>"
function ChatManager:innerHrefTbData(text, href, fontColor, fontSize, fontName)
    local tableData = {}
    tableData.tagType = PublicDefine.ContentTagTypeKey.click
    tableData.value = text
    tableData.face = fontName
    tableData.size = fontSize
    tableData.color = AvalonUtil:colorRGB2Str(fontColor)
    tableData.data = href
    tableData.dataType = PublicDefine.TagClickTypeKey.InnerHref
    return self:hideDefaultParam(tableData)
end



function ChatManager:hideDefaultParam(tableData)
    if tableData.size == DEFALAULT_FONT_SIZE then
        tableData.size = nil
    end
    if tableData.color == DEFALAULT_FONT_COLOR then
        tableData.color = nil
    end
    if tableData.face == UI.SYS_FONT_CHAT then
        tableData.face = nil
    end
    return tableData
end

--
function ChatManager:getItemLinkData(goodsData)
    -- dump(goodsData:getBytesData(), "goodsData:getBytesData()")
    -- local goodsMesData = ProtobufUtil:decode("GoodsSystem.EquipmentData", goodsData:getBytesData())
    -- print("len---------------1 goodsData:getBytesData() size = "..string.len(goodsData:getBytesData()))
    local data = {}
    -- data.goodsDataBytes = goodsData:getBytesData()
    -- print("old bytes data = "..Base64Encode(goodsData:getBytesData()))

    local bytesData = goodsData:getBytesData()
    -- if bytesData == nil and (goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT or goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY)then
    --     return
    -- end

    xpcall(function()
        if goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
            local decodeData = ProtobufUtil:decode("GoodsSystem.EquipmentData", bytesData)
            data.goodsDataBytes =  ProtobufUtil:encode("GoodsSystem.EquipmentData", decodeData)
        elseif goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
            local decodeData = ProtobufUtil:decode("GoodsSystem.StarPrayData", bytesData)
            data.goodsDataBytes =  ProtobufUtil:encode("GoodsSystem.StarPrayData", decodeData)
        elseif goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
            local decodeData = ProtobufUtil:decode("GoodsSystem.RelicData", bytesData)
            data.goodsDataBytes =  ProtobufUtil:encode("GoodsSystem.RelicData", decodeData)
        elseif goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
            local decodeData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData", bytesData)
            data.goodsDataBytes =  ProtobufUtil:encode("GoodsSystem.PetEquipmentData", decodeData)
        elseif goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
            local decodeData = ProtobufUtil:decode("GoodsSystem.PetGemStoneData", bytesData)
            data.goodsDataBytes =  ProtobufUtil:encode("GoodsSystem.PetGemStoneData", decodeData)
        elseif goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            local decodeData = ProtobufUtil:decode("GoodsSystem.EquipmentGlyphData", bytesData)
            data.goodsDataBytes =  ProtobufUtil:encode("GoodsSystem.EquipmentGlyphData", decodeData)
        end
    end, 
    function(e) 
        printError("--------------------------------------ChatManager---error", e)
    end, 1)  

    data.templateID = goodsData:getId()
    data.num = goodsData:getNum()
    data.isGolden = goodsData:getIsGolden()
    data.isLock = goodsData:getIsLock()
    local protoData = ProtobufUtil:encode("GoodsSystem.GoodsData", data)
    local itemNameTb = self:itemNameTbData(goodsData:getName(), protoData, UI.ITEM_QUALITY_FONT_COLOR[goodsData:getGoodsRare()])
    return itemNameTb
end

function ChatManager:getItemLinkStr(goodsData)
    local tableData = self:getItemLinkData(goodsData)
    if not tableData then
        return
    end

    local linkStr = AvalonUtil:serializeItemName(tableData.value, tableData.data, tableData.color, tableData.size, tableData.face)
    return linkStr
end


function ChatManager:getNickNameLinkStr(messageType, pk, userID, nickName)
    local speaker = {}
    speaker.pk = pk
    speaker.userID = userID
    speaker.nickName = ToolsUtil:replaceShowNickNameStr(nickName)
    local color = AvalonUtil:colorRGB2Str(UI.CHAT_MESSAGE_TYPE_FONT_COLOR[messageType])
    local linkStr = AvalonUtil:serializeNickName(nickName, speaker, color, nil, nil, true)
    return linkStr
end

--zip 压缩 暂时没用
function ChatManager:compressZip(str)
    -- local v,mv,pv=zip.version()
    local compress = zip.deflate()
    local deflated, eof, bytes_in,bytes_out = compress(str, 'finish')
    local base64Str = Base64Encode(deflated)
    return base64Str
end

--zip 解压 暂时没用
function ChatManager:unCompressZip(base64Str)
    local uncompress=zip.inflate()
    local str = Base64Decode(base64Str)
    local uss,ret,getin,getout=uncompress(str) 
    return uss
end

function ChatManager:compressString(tableData, textType)
    local data = {}
    data.tags = tableData
    data.textType = textType
    -- dump(data, "ChatManager:compressString---data")
    local pbBytes = ProtobufUtil:encode("ChatSystem.ContentMessage", data)    
    -- print("pbBytes base64 ="..Base64Encode(pbBytes))
    return pbBytes
end

function ChatManager:unCompressPb(data)
    local messageData
    local messageType = ChatMessageType.TEAM
    if data.PBType == ChatChannelType.TEAM then
        messageType = ChatMessageType.TEAM
        messageData = ProtobufUtil:decode("ChatSystem.TeamChatMessage", data.pbBytes)
    elseif data.PBType ==  ChatChannelType.GUILD then
        messageType = ChatMessageType.GUILD
        messageData = ProtobufUtil:decode("ChatSystem.GuildChatMessage", data.pbBytes)
    elseif data.PBType ==  ChatChannelType.PERSONAL then
        messageType = ChatMessageType.PERSONAL
        messageData = ProtobufUtil:decode("ChatSystem.PrivateChatMessage", data.pbBytes)
    elseif data.PBType ==  ChatChannelType.NEAR then
        messageType = ChatMessageType.NEAR
        messageData = ProtobufUtil:decode("ChatSystem.NearChatMessage", data.pbBytes)
    elseif data.PBType ==  ChatChannelType.WORLD then
        messageType = ChatMessageType.WORLD
        messageData = ProtobufUtil:decode("ChatSystem.WorldChatMessage", data.pbBytes)
    end

    local chatContent = ProtobufUtil:decode("ChatSystem.ContentMessage", messageData.chatContent)

     -- print("xmlStr == "..xmlStr)
    if chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_XML then
        for k, v in ipairs(chatContent.tags) do
            local content = ""
            if v.tagType == PublicDefine.ContentTagTypeKey.font then
            elseif v.tagType == PublicDefine.ContentTagTypeKey.click then
                if v.dataType == PublicDefine.TagClickTypeKey.NickName then
                    v.data = ProtobufUtil:decode("PublicDefine.HeadRoleData", v.data) 
                elseif v.dataType == PublicDefine.TagClickTypeKey.ItemName then

                elseif v.dataType == PublicDefine.TagClickTypeKey.GuildName then
                    v.data = ProtobufUtil:decode("GuildSystem.InviteGuildData", v.data) 
                elseif v.dataType == PublicDefine.TagClickTypeKey.InnerHref then

                end
            elseif v.tagType == PublicDefine.ContentTagTypeKey.img then
            end
        end
    end
    messageData.chatContent = chatContent
    data.messageData = messageData 
    data.pbBytes = nil
end

function ChatManager:unCompressString(data, removeLink, isHaveBg)
    local messageData = data.messageData
    local chatContent = messageData.chatContent
    local xmlStr = ""
    local selfKey = RoleDataManager:getMasterPK()
    local speaker = nil
    if data.PBType ==  ChatChannelType.PERSONAL then
        speaker = messageData.chatFrom

        if selfKey == speaker.pk then
            xmlStr = xmlStr..AvalonUtil:serializeText(UI.TEXT_1170417, UI.FONT_COLOR_BLUE)
        else
            local content = AvalonUtil:serializeNickName(speaker.nickName, speaker, color, nil, nil, removeLink)
            xmlStr = xmlStr..content
        end
    else
        speaker = messageData.Speaker
        if selfKey == speaker.pk then
            xmlStr = xmlStr..AvalonUtil:serializeText(UI.TEXT_1170417, UI.FONT_COLOR_BLUE)
        else
            local content = AvalonUtil:serializeNickName(speaker.nickName, speaker, color, nil, nil, removeLink)
            xmlStr = xmlStr..content
        end
    end

    -- print("xmlStr == "..xmlStr)
    if chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_XML then
        xmlStr = xmlStr..AvalonUtil:serializeText(":", color)
        for k, v in ipairs(chatContent.tags) do
            local content = ""
            if v.tagType == PublicDefine.ContentTagTypeKey.font then
                if isHaveBg then
                    content = AvalonUtil:serializeText(v.value, UI.FONT_COLOR_41_41_45, v.size, v.face)
                else
                    content = AvalonUtil:serializeText(v.value, v.color, v.size, v.face)
                end
            elseif v.tagType == PublicDefine.ContentTagTypeKey.click then
                if v.dataType == PublicDefine.TagClickTypeKey.NickName then
                    content = AvalonUtil:serializeNickName(v.value, v.data, v.color, v.size, v.face, removeLink)
                elseif v.dataType == PublicDefine.TagClickTypeKey.ItemName then
                    content = AvalonUtil:serializeItemName(v.value, v.data, v.color, v.size, v.face, removeLink)
                elseif v.dataType == PublicDefine.TagClickTypeKey.GuildName then
                    content = AvalonUtil:serializeGuildName(v.value, v.data, v.color, v.size, v.face, removeLink)
                elseif v.dataType == PublicDefine.TagClickTypeKey.InnerHref then
                    content = AvalonUtil:serializeInnerHref(v.value, v.data, v.color, v.size, v.face, removeLink)
                end
            elseif v.tagType == PublicDefine.ContentTagTypeKey.img then
                content = AvalonUtil:serializeImage(v.src, v.text , v.color, v.size, v.face)
            end
            xmlStr = xmlStr..content
        end
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_TEXT then
        local text = chatContent.text
        local content = AvalonUtil:serializeText(":"..text, color)
        xmlStr = xmlStr..content
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_ID then
        local text = ConfigManager:getQuickChatDataById(chatContent.textId)
        local content = AvalonUtil:serializeText(":"..text, color)
        xmlStr = xmlStr..content
    end
    -- dump(xmlStr, "xmlStr")
    return xmlStr
end

function ChatManager:unCompressStringAndSpeaker(data)
    local messageData = data.messageData
    local chatContent = messageData.chatContent
    local xmlStr = ""
    local selfKey = RoleDataManager:getMasterPK()
    local speaker = nil
    if data.PBType ==  ChatChannelType.PERSONAL then
        speaker = messageData.chatFrom
    else
        speaker = messageData.Speaker
    end
    local titleNickName = nil
    if data.PBType == ChatChannelType.GUILD then
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            local title = guildData:getTitleByPk(speaker.pk)
            if title == nil then
                titleNickName = ToolsUtil:replaceShowNickNameStr(speaker.nickName)
            else
                titleNickName = string.format("[%s]%s", title, ToolsUtil:replaceShowNickNameStr(speaker.nickName))
            end
        end
    end

    -- print("xmlStr == "..xmlStr)
    local color = UI.FONT_COLOR_41_41_45
    if chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_XML then
        for k, v in ipairs(chatContent.tags) do
            local content = ""
            if v.tagType == PublicDefine.ContentTagTypeKey.font then
                content = AvalonUtil:serializeText(v.value, color, v.size, v.face)
            elseif v.tagType == PublicDefine.ContentTagTypeKey.click then
                if v.dataType == PublicDefine.TagClickTypeKey.NickName then
                    content = AvalonUtil:serializeNickName(v.value, v.data, v.color, v.size, v.face)
                elseif v.dataType == PublicDefine.TagClickTypeKey.ItemName then
                    content = AvalonUtil:serializeItemName(v.value, v.data, v.color, v.size, v.face)
                elseif v.dataType == PublicDefine.TagClickTypeKey.GuildName then
                    content = AvalonUtil:serializeGuildName(v.value, v.data, color, v.size, v.face)
                elseif v.dataType == PublicDefine.TagClickTypeKey.InnerHref then
                    content = AvalonUtil:serializeInnerHref(v.value, v.data, color, v.size, v.face)
                end
            elseif v.tagType == PublicDefine.ContentTagTypeKey.img then
                content = AvalonUtil:serializeImage(v.src, v.text , v.color, v.size, v.face)
            end
            xmlStr = xmlStr..content
        end
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_TEXT then
        local text = chatContent.text
        local content = AvalonUtil:serializeText(text, color)
        xmlStr = xmlStr..content
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_ID then
        local text = ConfigManager:getQuickChatDataById(chatContent.textId)
        local content = AvalonUtil:serializeText(text, color)
        xmlStr = xmlStr..content
    end
    return speaker, xmlStr, titleNickName
end

--解析pb  并带上翻译 (去掉发送者 和 接收者、 去掉道具超链接但保留颜色、加上引号（引号颜色 同文本颜色）)
function ChatManager:unCompressStringWithTranform(data, strList)
    strList = strList or {}
    local messageData = data.messageData

    local chatContent = messageData.chatContent
    local xmlStr = ""
    local index = 1

    local firstQuotesColor = nil
    local firstQuotesFontSize = nil
    local firstQuotesFontFace = nil

    local secondQuotesColor = nil
    local secondQuotesFontSize = nil
    local secondQuotesFontFace = nil
    local color = UI.FONT_COLOR_41_41_45
    if chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_XML then
        for k, v in ipairs(chatContent.tags) do
            local content = ""
            if v.tagType == PublicDefine.ContentTagTypeKey.font then
                content = AvalonUtil:serializeText(strList[index] or "", color, v.size, v.face)
                index = index + 1
                firstQuotesColor = v.color
                firstQuotesFontSize = v.size
                firstQuotesFontFace = v.face
            elseif v.tagType == PublicDefine.ContentTagTypeKey.click then
                if v.dataType == PublicDefine.TagClickTypeKey.ItemName then
                    local itemTable = ProtobufUtil:decode("GoodsSystem.GoodsData", v.data)
                    local goodData = GoodsDataManager:createLocalGoodsData(itemTable.templateID)
                    if goodData then
                        -- content = AvalonUtil:serializeText(goodData:getName(), v.color, v.size, v.face)
                        content = AvalonUtil:serializeItemName(goodData:getName(), v.data, v.color, v.size, v.face)
                    end
                elseif v.dataType == PublicDefine.TagClickTypeKey.GuildName then
                    local itemTable = ProtobufUtil:decode("GuildSystem.InviteGuildData", v.data)
                    content = AvalonUtil:serializeGuildName(itemTable.name, v.data, v.color, v.size, v.face, removeLink)
                elseif v.dataType == PublicDefine.TagClickTypeKey.InnerHref then
                    content = AvalonUtil:serializeInnerHref(v.value, v.data, v.color, v.size, v.face)
                end
            elseif v.tagType == PublicDefine.ContentTagTypeKey.img then
                content = AvalonUtil:serializeImage(v.src, v.text , v.color, v.size, v.face)
            end
            xmlStr = xmlStr..content
            secondQuotesColor = v.color
            secondQuotesFontSize = v.size
            secondQuotesFontFace = v.face
            if firstQuotesColor == nil and secondQuotesColor ~= nil then
                firstQuotesColor = secondQuotesColor
            end
            if firstQuotesFontSize == nil and secondQuotesFontSize ~= nil then
                firstQuotesFontSize = secondQuotesFontSize
            end
            if firstQuotesFontFace == nil and secondQuotesFontFace ~= nil then
                firstQuotesFontFace = secondQuotesFontFace
            end
        end
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_TEXT then
        local text = chatContent.text
        local content = AvalonUtil:serializeText(strList[index] or "")
        index = index + 1
        xmlStr = xmlStr..content
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_ID then
        local text = ConfigManager:getQuickChatDataById(chatContent.textId)
        local content = AvalonUtil:serializeText(text)
        xmlStr = xmlStr..content
    end
    -- dump(xmlStr, "xmlStr")“
    return xmlStr
end

--生成待翻译的普通文本 （排出 道具名字 和 角色名字）
function ChatManager:parseChatData(data)
    local messageData = data.messageData
    if messageData == nil then
        dump(data)
    end
    local chatContent = messageData.chatContent 
    local strList = {}
    if chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_XML then
        for k, v in ipairs(chatContent.tags) do
            local content = ""
            if v.tagType == PublicDefine.ContentTagTypeKey.font then
                --如果第一个字符是冒号去掉
                local str = string.gsub(v.value or "", "^[:：]+", "")
                table.insert(strList, str)
            elseif v.tagType == PublicDefine.ContentTagTypeKey.click then
                
            elseif v.tagType == PublicDefine.ContentTagTypeKey.img then
            end
        end
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_TEXT then
        table.insert(strList, chatContent.text)
    elseif chatContent.textType == PublicDefine.ChatMsgContentTextType.TYPE_QUICK_ID then
    end
    return strList
end


function ChatManager:registerNameClickEvent()
end

function ChatManager:OnPersonalChat(playerData, isRefresh)
    local newPlayer = self:insertPersonalList(playerData, isRefresh)
    UI.ChatMainLayer:getInstance():showByPosition()
    UI.ChatMainLayer:getInstance():autoChangeTag(ChatChannelType.PERSONAL)
    Avalon.MessageCenter:notice(GameMessage.MC_CHAT_OPEN_MAIN_CHAT)
    UI.ChatMainLayer:getInstance():setSelectedPerson(playerData)
    return newPlayer
end

function ChatManager:insertPersonalList(playerData, isRefresh)
    local isNewData = true
    local isDirty = false
    for k,v in pairs(self.personlPlayerList) do
       if v.pk == playerData.pk then
            isNewData = false
            v.userID = playerData.userID
            if isRefresh then
                if self:compareData(v, playerData) then
                    isDirty = true
                end
                v.lastTalkTime = os.time()
                v.nickName = ToolsUtil:replaceShowNickNameStr(playerData.nickName)
                v.faceDecodeID = playerData.faceDecodeID
                v.wearEquipId = playerData.wearEquipId
                v.sex = playerData.sex
                v.roleLV = playerData.roleLV
            end
            break;
       end
    end
    if isNewData then
        playerData.lastTalkTime = os.time()
        self.personlPlayerList[playerData.pk] = playerData
        self:writePersonalList(personl_list_fileName, self.personlPlayerList)
        UI.ChatMainLayer:getInstance():refreshSelectPlayer(true)
    elseif isDirty then
        self:writePersonalList(personl_list_fileName, self.personlPlayerList)
    end
    return playerData
end

--比较玩家数据返回是否不同  如果不同需要刷新头像
function ChatManager:compareData(dataA, dataB)
    if dataA.sex ~= dataB.sex then
        return true
    end
    if dataA.faceDecodeID ~= dataB.faceDecodeID then
        return true
    end
    if dataA.nickName ~= dataB.nickName then
        return true
    end
    if dataA.roleLV ~= dataB.roleLV then
        return true
    end
    if table.compare(dataA.wearEquipId, dataB.wearEquipId) then
        return true
    end
    return false
end


function ChatManager:getAllChatPersonal()
    if table.nums(self.personlPlayerList) == 0 then
        return self.personlPlayerList
    end

    ---筛选剔除 非好友 非公会成员的对象
    local guildData = MasterDataManager:getGuildData()
    for k, playerData in pairs(self.personlPlayerList) do
        if (not Game.FriendManager:getInstance():isFriend(playerData.pk)) and (guildData and guildData:getMemberDataForPK(playerData.pk) == nil) then
            self.personlPlayerList[playerData.pk] = nil
        end
    end

    local list = {}
    for k, v in pairs(self.personlPlayerList) do
        table.insert(list, v)
    end
    table.sort(list, function(a, b)
        return a.lastTalkTime > b.lastTalkTime
    end)
    if #list > PERSONAL_LIMITE_NUMBER then
        local num = #list - PERSONAL_LIMITE_NUMBER
        for i = 1, num do
            local index = #list
            local data = list[index]
            table.remove(list, index)
            table.remove(self.personlPlayerList, data.pk)
        end
    end
    return list
end

function ChatManager:getFirstChatPersonal()
    local taskTalkTime = 0
    local selectPlayer = nil
    for k, v in pairs(self.personlPlayerList) do
        if taskTalkTime < v.lastTalkTime then
            taskTalkTime = v.lastTalkTime
            selectPlayer = v
        end
    end
    return selectPlayer
end


function ChatManager:refreshPersonalUserID(chatPlayer)
    local userID = self.personlUserIDMap[chatPlayer.pk]
    local isNew = false
    if userID ~= nil then
        if chatPlayer.userID ~= userID then
            chatPlayer.userID = userID
            isNew = true
        end
    else
        self:insertuserIDByPk(chatPlayer.pk, chatPlayer.userID)
    end

    if not isNew then
        return chatPlayer
    end
    if self.personlPlayerList[chatPlayer.pk] then
        self.personlPlayerList[chatPlayer.pk].userID = chatPlayer.userID
    end
    --刷新本地缓存的角色名字
    if chatPlayer.nickName ~= nil then
        if self.personlPlayerList[chatPlayer.pk] then
            self.personlPlayerList[chatPlayer.pk].nickName = ToolsUtil:replaceShowNickNameStr(chatPlayer.nickName)
        end
        if self.shieldPlayerMap[chatPlayer.pk] then
            self.shieldPlayerMap[chatPlayer.pk].nickName = ToolsUtil:replaceShowNickNameStr(chatPlayer.nickName)
        end
    end
    return chatPlayer
end

function ChatManager:insertuserIDByPk(pk, userID)
    if pk ~= nil and userID ~= nil then
        self.personlUserIDMap[pk] = userID
    end
end

function ChatManager:getuserIDByPk(pk)
    return self.personlUserIDMap[pk] or 0
end


function  ChatManager:isShieldPlayer(pk)
    return self.shieldPlayerMap[pk] ~= nil
end

function  ChatManager:getShieldPlayerByPk(pk)
    return self.shieldPlayerMap[pk]
end

function  ChatManager:insertShieldPlayer(pk, playerData)
    local function updatePlayerData(dataToStore, dataToUpdate)
        dataToStore.shieldTime = os.time()
        if (ProtobufUtil:checkFieldIsInit(dataToUpdate, "nickName")) then
            dataToStore.nickName = ToolsUtil:replaceShowNickNameStr(dataToUpdate.nickName)
        end
        if (ProtobufUtil:checkFieldIsInit(dataToUpdate, "userID")) then
            dataToStore.userID = dataToUpdate.userID
        end
        if (ProtobufUtil:checkFieldIsInit(dataToUpdate, "faceDecodeID")) then
            dataToStore.faceDecodeID = dataToUpdate.faceDecodeID
        end
        if (ProtobufUtil:checkFieldIsInit(dataToUpdate, "templateID")) then
            dataToStore.templateID = dataToUpdate.templateID
        end
        if (ProtobufUtil:checkFieldIsInit(dataToUpdate, "sex")) then
            dataToStore.sex = dataToUpdate.sex
        end
        if (ProtobufUtil:checkFieldIsInit(dataToUpdate, "roleLV")) then
            dataToStore.roleLV = dataToUpdate.roleLV
        end
    end

    if self.shieldPlayerMap[pk] == nil then
        local data = {}
        data.pk = pk
        updatePlayerData(data, playerData)
        self.shieldPlayerMap[pk] = data
    else
        updatePlayerData(data, playerData)
    end
    self:writePersonalList(chat_blackList_fileName, self.shieldPlayerMap)
end

function  ChatManager:removeShieldPlayer(pk)
    self.shieldPlayerMap[pk] = nil
    self:writePersonalList(chat_blackList_fileName, self.shieldPlayerMap)
end

function ChatManager:getAllShieldPlayer()
    if table.nums(self.shieldPlayerMap) == 0 then
        return self.shieldPlayerMap
    end
    local list = {}
    for k, v in pairs(self.shieldPlayerMap) do
        table.insert(list, v)     
    end
    table.sort(list, function(a, b)
        return a.shieldTime > b.shieldTime
    end)
    if #list > PERSONAL_LIMITE_NUMBER then
        local num = #list - PERSONAL_LIMITE_NUMBER
        for i = 1, num do
            local index = #list
            local data = list[index]
            table.remove(list, index)
            table.remove(self.shieldPlayerMap, data.pk)
        end
    end
    return list
end

--存取聊天黑名单列表
--存取私聊列表
function ChatManager:writePersonalList(fileName, palyerList)
    Avalon.FileManager:saveMapDataToLocal(palyerList, fileName, true)
end

function ChatManager:readPersonalList(fileName, keyIsNumber)
    local list = Avalon.FileManager:readMapDataFromLocal(fileName, true, keyIsNumber)
    return list
end

--存取玩家消息
function ChatManager:appendChatMessage(pk, xmlMsg, channelType)
    -- print("---------appendChatMessage pk = ".. pk .. "  / and  xmlMsg = "..xmlMsg)
    if channelType == 0 then
        return
    end
    local saveUserKey = GameDataManager:getInstance():getSaveUserKey()
    local filePath = Avalon.FileManager:getUserDataDirection()..saveUserKey.."/"..string.format(chat_message_fileName, channelType)
    local success = Avalon.FileManager:appendDataToFile(SPLIT_KEY..xmlMsg, filePath)
    if not success then
        print("---append fail !!!!!!!  filePath ="..filePath)
        cc.FileUtils:getInstance():createDirectory(Avalon.FileManager:getUserDataDirection()..saveUserKey.."/")
        Avalon.FileManager:appendDataToFile(SPLIT_KEY..xmlMsg, filePath)
    end
end

function ChatManager:writeChatMessage(pk, content, channelType)
    if channelType == 0 then
        return
    end
    local saveUserKey = GameDataManager:getInstance():getSaveUserKey()
    local filePath = Avalon.FileManager:getUserDataDirection()..saveUserKey.."/"..string.format(chat_message_fileName, channelType)
    local success = Avalon.FileManager:writeDataToFile(content ,filePath)
    if not success then
        print("---write fail !!!!!!! filePath ="..filePath)
        cc.FileUtils:getInstance():createDirectory(Avalon.FileManager:getUserDataDirection()..saveUserKey.."/")
        Avalon.FileManager:writeDataToFile(content ,filePath)
    end
end

function ChatManager:readChatMessage(pk, channelType)
    local saveUserKey = GameDataManager:getInstance():getSaveUserKey()
    local filePath = Avalon.FileManager:getUserDataDirection()..saveUserKey.."/"..string.format(chat_message_fileName, channelType)
    local content = Avalon.FileManager:readDataFromFile(filePath)
    local isDirty = false
    local messageList = {}
    if content ~= nil then
        messageList = string.split(content, SPLIT_KEY)
    end
    if #messageList > 1 then
        table.remove(messageList, 1) --分割符 分割后第一个数据 是“”
    end
    local newMsgList = {}
    if #messageList > MSG_SAVE_LIMITE_NUMBER then
        isDirty = true
        local beginIndex = #messageList - MSG_SAVE_LIMITE_NUMBER + 1
        for i = beginIndex, #messageList do
            table.insert(newMsgList, messageList[i])
        end
    end
    if isDirty then
        local newContent = ""
        for i = 1, #newMsgList do
            newContent = newContent..SPLIT_KEY..newMsgList[i]
        end
        self:writeChatMessage(pk, content, channelType)
        return newMsgList
    end
    return messageList
end

function ChatManager:writeSysBroadcastIndex(index)
    if index == nil then
        return
    end
    local content = index
    local selfKey = RoleDataManager:getMasterPK()
    local saveUserKey = GameDataManager:getInstance():getSaveVersionKey()..selfKey
    local filePath = Avalon.FileManager:getUserDataDirection()..saveUserKey.."/"..system_broadcast_fileName
    local success = Avalon.FileManager:writeDataToFile(content ,filePath)
    if not success then
        -- print("---write fail !!!!!!! filePath ="..filePath)
        cc.FileUtils:getInstance():createDirectory(Avalon.FileManager:getUserDataDirection()..saveUserKey.."/")
        Avalon.FileManager:writeDataToFile(content ,filePath)
    end
end

function ChatManager:readSysBroadcastIndex()
    -- print("---------readSysBroadcastIndex pk = ")
    local selfKey = RoleDataManager:getMasterPK()
    local saveUserKey = GameDataManager:getInstance():getSaveVersionKey()..selfKey
    local filePath = Avalon.FileManager:getUserDataDirection()..saveUserKey.."/"..system_broadcast_fileName
    local content = Avalon.FileManager:readDataFromFile(filePath)
    self.systemBroadcastIndex = tonumber(content) or 0
end

--系统打点消息 splitLength 一个tag标签的字数长度，用于优化计算
function ChatManager:sendSystemMsg(str, messageType, splitLength)
    local data = {} 
    local color = AvalonUtil:colorRGB2Str(UI.CHAT_MESSAGE_TYPE_FONT_COLOR[messageType])
    if splitLength then
        local list = AvalonUtil:splitByLength(str, splitLength)
        data.content = ""
        for k, v in ipairs(list) do 
            data.content = data.content..AvalonUtil:serializeText(v, color)
        end
    else
        data.content = AvalonUtil:serializeText(str, color)
    end
    data.messageType = messageType
    Game.ChatManager:getInstance():push(data)
end

function ChatManager:sendSysMsgWithLink(mesData)
    -- print("ChatManager:sendSysMsgLink")
    if mesData.sourceSpriteID ~= nil and mesData.sourceSpriteID ~= 0 then
        local curModel = MachineManager:getInstance():getMachine():getModel()
        local role = curModel:getRoleBySpriteID(mesData.sourceSpriteID)
        if role ~= nil and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC then
            local npcData = role:getNpcData()
            if(npcData) then
                local functionTypeArr = npcData:getFunctionTypeArr()
                for k, v in pairs(functionTypeArr) do
                    if v == PublicDefine.FUNCTION_TYPE.LUCKYWHEEL_TURN and mesData.goodsData ~= nil then
                        if mesData.goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
                            self:sendSystemMsg(mesData.goodsData:getName().."x"..mesData.goodsData:getNum(), ChatMessageType.SYSTEM_MESSAGE)
                        else
                            -- local content = self:getNickNameLinkStr(messageType, pk, userID, nickName)
                            local linkStr = self:getItemLinkStr(mesData.goodsData)
                            if not linkStr then
                                return
                            end
                            local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                            self:formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, UI.TEXT_1110722, you, linkStr)
                        end
                        break
                    end
                end
            end
        end
    end
end

function ChatManager:sendSysMsgWithData(mesData)
    -- print("ChatManager:sendSysMsgWithData"..mesData.changeReason)
    if mesData.changeReason ~= nil and mesData.changeReason ~= 0 then
        local reasonTypeOne,reasonTypeTwo,reasonTypeThree,reasonTypeFour = ToolsUtil:splitAttrReason(mesData.changeReason)
        -- if reasonTypeOne == PublicDefine.ATTR_CHANGE_REASON_TYPE.LUCKYWHEEL and mesData.value > 0 then
            local str = ""
            if(mesData.value >0) then
                str = UI.TEXT_1110722
            else 
                str = UI.TEXT_1170601.." %s"
            end
            local value = mesData.value
            if(value < 0) then
                value = -value
            end
            if mesData.costType == PublicDefine.GOODS_COST_TYPE.GOLD then
                str = str..UI.TEXT_1170326.."  x"..value
            elseif mesData.costType == PublicDefine.GOODS_COST_TYPE.GEM then
                str = str..UI.TEXT_1170327.."  x"..value
            elseif mesData.costType == PublicDefine.GOODS_COST_TYPE.HORCRUX_COIN then
                str = str..LanguageManager:getInstance():getLocalString(1091587).."  x"..value
            end

            if(mesData.changeType == PublicDefine.ATTR_TYPE.curLVExp) then 
                str = str..LanguageManager:getInstance():getLocalString(1111852).."  x"..value
            end

            if str ~= "" then
                local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                self:formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, str, you)
            end
        -- end
    end
end
--序列化普通文本
function ChatManager:serializeTextByMessageType(text, messageType)
    local color = AvalonUtil:colorRGB2Str(UI.CHAT_MESSAGE_TYPE_FONT_COLOR[messageType])
    return AvalonUtil:serializeText(text, color)
end

function ChatManager:formartAndSendSystemMsg(messageType, mode, ...)
    local color = AvalonUtil:colorRGB2Str(UI.CHAT_MESSAGE_TYPE_FONT_COLOR[messageType])
    local content = AvalonUtil:formartRichText(color, DEFALAULT_FONT_SIZE, UI.SYS_FONT_CHAT, mode, ...)

    local data = {} 
    data.content = content
    data.messageType = messageType
    Game.ChatManager:getInstance():push(data)
end

--每秒刷新
function ChatManager:checkLocalSystemMsg(dt)
    self.intervalTime = self.intervalTime + dt
    if self.intervalTime < 1 then
        return
    end
    self.intervalTime = 0

    if not self.dungeonMsgLock then
        self:checkDungeonSystemMsg()
    end
    if not self.taskMsgLock then
        self:checkTaskSystemMsg()
    end

    if GameDataManager:getInstance():getIsJoinGuild()
        and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_PrivateGuildShop) then
        -- 检查公会新随机商店是否有了新商品
        if(mvc.guildShopModel:getIsLockGuildShop()) then 
            if mvc.guildShopModel:checkRandomHaveNewGoods() then
                Game.ChatManager:getInstance():sendSystemMsg(UI.TEXT_1213874, ChatMessageType.SYSTEM_GUILD_MEMBER)
            end
        end
    end
end

function ChatManager:checkTaskSystemMsg()
    local time = GameDataManager:getRefreshWaitingTime()
    if time == 0 then
        return
    end
    local hours = math.ceil(time / SECONDS_ONE_HOUR)
    if hours <= 1 then
        self:sendSystemMsg(UI.TEXT_1170938, ChatMessageType.SYSTEM_MESSAGE)
        self.taskMsgLock = true
    end
end

function ChatManager:checkDungeonSystemMsg()
    local currentSeason = MasterDataManager:getCurrentSeasonData()
    -- if currentSeason == nil or not currentSeason.open then
    --      lcurrentSeason = MasterDataManager:getNextSeasonData()
    -- end
    if currentSeason ~= nil and currentSeason.open then
        local nowTime = GameManager:getNowServerTime()
        local endTime = currentSeason.endTime + GameManager:getEPOCHTime()
        local subTime = endTime - nowTime
        -- print("------subTime = "..subTime)
        if subTime <= SECONDS_ONE_DAY and subTime >= SECONDS_ONE_HOUR then
           if subTime % SECONDS_ONE_HOUR == 0 then
                self.dungeonMsgLock = true
                Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                    self.dungeonMsgLock = false
                    self:sendSystemMsg(string.format(UI.TEXT_1170323, subTime / SECONDS_ONE_HOUR), ChatMessageType.SYSTEM_MESSAGE)
                end, 2)
           end
        end
        if SceneManager:getInstance():isInDungeon() then
            -- print("------subTime = "..subTime)
            if subTime <= SECONDS_ONE_HOUR and subTime >= SECONDS_ONE_MINUTES then
                if subTime % SECONDS_ONE_MINUTES == 0 then
                    self.dungeonMsgLock = true
                    -- print("------bingo---")
                    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                        -- print("------doing ---- ")
                        self.dungeonMsgLock = false
                        self:sendSystemMsg(string.format(UI.TEXT_1170324, subTime / SECONDS_ONE_MINUTES), ChatMessageType.SYSTEM_MESSAGE)
                    end, 2)
               end
            end
        end
    end 
end

--[[拉取系统公告 --超时 拉取三次 30s  超时]]
function ChatManager:checkSystemBroadcast()
    if self.delayTime == 0 then
        self.delayTime = math.random(0, WEB_ERUPT_DELAY_TIME)
    end
    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        self:sendSystemNoticeCallback(false)
        self.delayTime = 0
    end, self.delayTime)
end

function ChatManager:sendSystemNoticeCallback(isScuess, noticeList)
    if isScuess then
        self.requestCount = 0
        --noticeList 发布公告
        noticeList = noticeList or {}
        for k, v in ipairs(noticeList) do
            self:sendSystemMsg(v.content, ChatMessageType.SYSTEM_NOTICE, 50)
        end
    else
        if self.requestCount >= HTTP_REQUEST_LIMITE_COUNT then
            self.requestCount = 0
            return
        end
        local sysNoticeIndex = self.systemBroadcastIndex
        self:sendSystemNoticeHttp(sysNoticeIndex, handler(self, self.sendSystemNoticeCallback))
    end
end

function ChatManager:sendSystemNoticeHttp(sysNoticeIndex, callback)
    local SdkBox = require("utils.sdkbox.SdkBox")
    self.requestCount = self.requestCount  + 1
    local webManageUrl = ServerConfigUtil:getWebManageUrl()
    if (not webManageUrl) then return end
    local httpurl = webManageUrl..Net.HttpSubDirection.SystemNotice 
    local tableData = {}
    tableData.id = sysNoticeIndex
    tableData.languageType = LanguageManager:getInstance():getLanguage()
    local gameLoginManager = require("app.game.GameLoginManager")
    tableData.zoneId = gameLoginManager:getInstance():getServerId()
    tableData.channel = SdkBox:getInstance():getVersionChannel()
    tableData.clientVersion = AvalonUtil.getPackageVersion()
    local sortTable = AvalonUtil:sortParamByFirstChar(tableData)
    -- dump(sortTable, "ChatManager:sendSystemNoticeHttp sortTable")
    local md5ParamStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        md5ParamStr = md5ParamStr..v.value
        paramTable[v.key] = v.value
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr..WEB_MD5_KEY)

    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("POST", httpurl)
    -- print("------httpurl"..httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    xhr:setRequestHeader("Authorization", "Bearer "..md5Str)
    local function onReadyStateChanged()
        print("sendSystemNoticeHttp xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status, "xhr.status", xhr.status)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print("sendSystemNoticeHttp revcive reposne "..self.systemBroadcastIndex)  
            local data = json.decode(xhr.response)  
            --大于本地标记 才认为是新消息（避免 因为超时 导致同时返回两条相同数据）
            -- dump(data)
            if self.systemBroadcastIndex < data.maxId then        
                callback(true, data.data)
            end
            if  self.systemBroadcastIndex ~= data.maxId then
                self.systemBroadcastIndex = data.maxId
                self:writeSysBroadcastIndex(data.maxId)
            end
        else
            callback(false)
            print("banner xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
        xhr:unregisterScriptHandler()
    end

    xhr:registerScriptHandler(onReadyStateChanged)
    local sendParam = json.encode(paramTable)
    -- print("------sendParam"..sendParam)
    xhr:send(sendParam)
end

function ChatManager:isBanByChannelType(channelType)
    local data = MasterDataManager:getBanChatData()[channelType]
    if data then
        if data.banTimeStamp < 0 then
            return true, data.banType, UI.TEXT_1170419
        end
        local nowTime = GameManager:getNowServerTime() - GameManager:getEPOCHTime()
        if nowTime < data.banTimeStamp then
            return true, data.banType, AvalonUtil:_getFullFormatTime(data.banTimeStamp - nowTime, false, true) 
        end
    end
    return false
    -- return true, 2, AvalonUtil:_getFullFormatTime(10000, false, true) 
end

function ChatManager:isHaveLoadLocalFile()
    return self.isHaveLoad
end

-- 只记录翻译完成状态 即status == 4
function ChatManager:insertCellStatusCache(channelType, md5key, status, isJudgeHave)
    if channelType == nil or md5key == nil or status == nil then
        return
    end
    local isDirty = false
    if isJudgeHave then
        for k, v in ipairs(self.cellStatus) do
           if channelType == v.cType and md5key == v.md5key then
                table.remove(self.cellStatus, k)
                isDirty = true
            end
        end
    end

    if status == CHAT_CELL_STATUS.FINISH_TRAN then
        local data = {}
        data.cType = channelType
        data.md5key = md5key
        data.status = status
        table.insert(self.cellStatus, data)
        isDirty = true
    end
    return isDirty
end

function ChatManager:getCellStatusFromCache(channelType, md5key)
    if channelType == nil or md5key == nil then
        return
    end
    for k, v in ipairs(self.cellStatus) do
        if channelType == v.cType and md5key == v.md5key then
            return v.status
        end
    end
end

function ChatManager:resetCellStatusCacheByChannelType(channelType)
    if channelType == nil then
        return
    end
    local isDirty = false
    for k, v in ipairs(self.cellStatus) do
        if channelType == v.cType then
            table.remove(self.cellStatus, k)
            isDirty = true
        end
    end
    return true
end

function ChatManager:saveCellStatusCache()
    self:writePersonalList(chat_cell_status_fileName, self.cellStatus)
end

function ChatManager:insertTransFormStrTbCache(md5Key, strTable)
    if strTable == nil then
        return
    end
    local data = {}
    data.md5Key = md5Key
    data.strTable = strTable
    table.insert(self.transFormStrTbCache, data)
    self:writePersonalList(transform_cache_fileName, self.transFormStrTbCache)
end

function ChatManager:getTransFormStrTbCache(md5Key)
    for k, v in ipairs(self.transFormStrTbCache) do
        if v.md5Key == md5Key then
            return v.strTable
        end
    end
end

function ChatManager:insertRichTextCache(md5Key, _richText)
    if not OPEN_RICHTEXT_CACHE then
        return
    end
    if _richText == nil then
        return
    end
    local data = {}
    data.md5Key = md5Key
    data._richText = _richText
    table.insert(self.richTextCache, data)
    if #self.richTextCache > RICHTEXT_CACHE_SIZE then
        local data = self.richTextCache[1]
        if data and data._richText then
            data._richText:release()
        end
        table.remove(self.richTextCache, 1)
    end
end

function ChatManager:getRichTextCache(md5Key)
    if not OPEN_RICHTEXT_CACHE then
        return
    end
    for k, v in ipairs(self.richTextCache) do
        if v.md5Key == md5Key then
            return v._richText
        end
    end
end

function ChatManager:isOpenRichTextCache()
    return OPEN_RICHTEXT_CACHE
end

--todo 记录聊天窗口的高度 用于下次打开界面 马上就能创建最准确的界面大小
-- type ：ChatChannelType
function ChatManager:saveChatDialogHeight(cType, heightNum)
    local isCanSave = false
    for k, v in ipairs(WriteLocalChannelType) do
        if cType == v then
            isCanSave = true
            break
        end
    end
    if not isCanSave then
        return
    end
    local data = self.dialogHeights[cType]
    if data ~= heightNum then
        self.dialogHeights[cType] = heightNum
        self:writePersonalList(chat_dialog_height_fileName, self.dialogHeights)
    end
end

function ChatManager:getChatDialogHeight(type)
    local isCanSave = false
    for k, v in ipairs(WriteLocalChannelType) do
        if cType == v then
            isCanSave = true
            break
        end
    end
    if not isCanSave then
        return
    end
    return self.dialogHeights[type]
end

function ChatManager:isNeedTranslation(data)
    local SdkBox = require("utils.sdkbox.SdkBox")
    local isNeed = false
    if not data.isSelf and SdkBox:getInstance():isSupportTranslationFunction() and (data.messageType == ChatMessageType.TEAM or 
            data.messageType == ChatMessageType.GUILD or data.messageType == ChatMessageType.PERSONAL or data.messageType == ChatMessageType.NEAR or data.messageType == ChatMessageType.WORLD) then
        isNeed = true
    end
    if isNeed then
        local strList = self:parseChatData(data)
        if strList and #strList > 0 then
            local text = ""
            for k, v in ipairs(strList) do
                text = text..v
            end
            local isShow = SdkBox:getInstance():isNeedTranslation(text)
            if not isShow then
                isNeed = false
            end
        else
            isNeed = false
        end
    end        
    return isNeed        
end


--跑马灯逻辑 begin
--new api
function ChatManager:refreshRunLampDatas(lampDatas)
    lampDatas = lampDatas or {}
    local tempList = {}
    for k, v in pairs(self.lampQueue) do
        if v.lampType == PublicDefine.RunLampType.RunLampType_Local then
            table.insert(tempList, v)
        end
    end
    self.lampQueue = tempList
    self:stopLampRunning()
    local key = AvalonUtil.getCurrentTime()
    for k, data in ipairs(lampDatas) do
        local version = data.version 
        local param = string.split(version, ".")
        if #param < 2 or version == AvalonUtil.getPackageVersion() then
            data.id = data.lampId
            data.content = ""
            table.insert(self.lampQueue, data)
        end
    end
    self:getLanguageFromWebServer(false)
end

--插入本地出发的跑马灯
function ChatManager:insertRunLampData(content, count, isLocal)
    if isLocal then
        local data = {}
        data.id = AvalonUtil.getCurrentTime() - 1000000 + table.nums(self.lampQueue)
        data.lampType = PublicDefine.RunLampType.RunLampType_Local
        data.playCount = count
        data.outTime = GameManager:getNormalServerTime() + SECONDS_ONE_DAY
        data.content = json.encode(AvalonUtil:formartRichTextToArray(UI.FONT_COLOR_171_136_78, UI.FONT_SIZE_18PX, fontName, content))
        table.insert(self.lampQueue, 1, data)
        if not self.lampRunning then
            self.lampRunning = true
            self:beginLampRunning()
        end
    end
end

--RunLampType_Web 类型从web端拉取文本， RunLampType_Scene类型从本地获取文本
function ChatManager:getLanguageFromWebServer(isNotice)
    -- print("---getLanguageFromWebServer---")
    local keyList = {}
     for k, v in pairs(self.lampQueue) do
        if v.lampType == PublicDefine.RunLampType.RunLampType_Web  then 
            if v.content == "" and v.contentKey ~= nil and v.contentKey ~= 0 then
                table.insert(keyList, v.contentKey)
            end
        end
        if v.extend ~= nil and #v.extend > 0 then
            for k, formatParam in pairs(v.extend) do
                if PublicDefine.ContentFormatType.ContentFormatType_WebLanguageId == formatParam.formatType then
                    table.insert(keyList, formatParam.contentValue)
                end
            end
        end
    end
    LanguageManager:getInstance():getLanguageFromWebServer(keyList, handler(self, self.refreshWebLaunguageCallback), isNotice)
end


function ChatManager:refreshWebLaunguageCallback(webLaunguageList, params)
    print("---refreshWebLaunguageCallback---")
    for k, v in pairs(self.lampQueue) do
        local lampType = v.lampType
        if lampType == PublicDefine.RunLampType.RunLampType_Web then 
            if v.content == "" then
                v.content = AvalonUtil.getWebLaunguageByKey(webLaunguageList, v.contentKey)
            end
        elseif lampType == PublicDefine.RunLampType.RunLampType_Scene then
            local LanguageManager = require("app.game.LanguageManager")
            v.content = LanguageManager:getInstance():getLocalString(tonumber(v.contentKey))
            v.content = AvalonUtil.textFormat(webLaunguageList, AvalonUtil:colorRGB2Str(UI.FONT_COLOR_171_136_78), UI.FONT_SIZE_18PX, nil, v.content, v.extend) 
        end
    end
    self.lampRunning = true
    self:beginLampRunning()
end

--始终取第一条
function ChatManager:beginLampRunning()
    -- print("---beginLampRunning---", table.nums(self.lampQueue), self.lampRunning)
    -- for k ,v in pairs(self.lampQueue) do
    --     print("-----", k , v)
    -- end
    if not self.lampRunning then
        print("--- ChatManager:beginLampRunning()---but lampRunning is ", self.lampRunning)
        return 
    end
    if table.nums(self.lampQueue) == 0 then
        self:stopLampRunning()
        return
    end
    local curServerTime = GameManager:getNormalServerTime()
    for k, v in pairs(self.lampQueue) do
        print("----v.playCount---", v.id, v.playCount, v.outTime, curServerTime )
        if v.playCount > 0 and v.outTime > curServerTime then
            UI.RunningLamp:showLamp(v)
            break
        end
    end
end

function ChatManager:stopLampRunning()
    self.lampRunning = false
end

function ChatManager:decreaseLampCount(id)
    for k, v in pairs(self.lampQueue) do
        if v.id == id then
            v.playCount = v.playCount - 1
            if v.playCount <= 0 then
                table.remove(self.lampQueue, k)
            end
            break;
        end
    end
end
--跑马灯逻辑 end

function ChatManager:refreshRedPoint(key, isNew)
    if key == nil then
        return
    end
    if isNew then
        local oldData = self.redPoint[key]
        if oldData == nil then
            self.redPoint[key] = 1
            self:writePersonalList(chat_red_point_fileName, self.redPoint)
        end
    else
        local oldData = self.redPoint[key]
        if oldData ~= nil then
            self.redPoint[key] = nil
            self:writePersonalList(chat_red_point_fileName, self.redPoint)
        end
    end
end

function ChatManager:isShowRedPoint(key)
    if self.redPoint[key] ~= nil then
        return true
    end
end

--sender/receiver [pk, userID, nickName, sex, faceDecodeID, wearEquipId, roleLV]
--guildData [guildID, name ,tk]
function ChatManager:sendGuildInvite(sender, receiver, guildData)
    local contentTable = {}
    require "app.datas.MasterDataManager"
    local color = UI.CHAT_MESSAGE_TYPE_FONT_COLOR[ChatMessageType.SYSTEM_GUILD_INVITE]
    
    local protoData = ProtobufUtil:encode("GuildSystem.InviteGuildData", guildData)
    local content = self:guildNameTbData(guildData.name, protoData, color)
    table.insert(contentTable, content)

    contentTable = AvalonUtil:formartRichTextToTableArray(color, DEFALAULT_FONT_SIZE, UI.SYS_FONT_CHAT, UI.TEXT_1213305, contentTable)
    local pbBytes = self:compressString(contentTable, PublicDefine.ChatMsgContentTextType.TYPE_XML)
 
    local message = {}
    message.chatFrom = sender
    message.chatTo = receiver
    message.chatContent = pbBytes
    local messageBytes = ProtobufUtil:encode("ChatSystem.PrivateChatMessage", message)
    local data = {}
    data.pbBytes = messageBytes
    data.messageType = ChatMessageType.SYSTEM_GUILD_INVITE
    data.PBType = ChatChannelType.PERSONAL
    self:push(data)
end

function ChatManager:sendGuildRecruit(sender, guildName, guildId, text)
    local contentTable = {}
    local color = UI.CHAT_MESSAGE_TYPE_FONT_COLOR[ChatMessageType.SYSTEM_GUILD_INVITE]
    local content = self:innerHrefTbData(string.format(UI.TEXT_1213308, guildName, text), string.format("jumpLayer://%d?guildId=%d", GameMessage.MC_UI_JUMP_GUILD_INFO, guildId or 0), color)
    table.insert(contentTable, content)
    local pbBytes = self:compressString(contentTable, PublicDefine.ChatMsgContentTextType.TYPE_XML)
    local message = {}
    message.Speaker = sender
    message.chatContent = pbBytes
    local data = {}
    -- data.pbBytes = ProtobufUtil:encode("ChatSystem.NearChatMessage", message)
    -- data.messageType = ChatMessageType.NEAR
    -- data.PBType = ChatChannelType.NEAR
    data.pbBytes = ProtobufUtil:encode("ChatSystem.WorldChatMessage", message)
    data.messageType = ChatMessageType.WORLD
    data.PBType = ChatChannelType.WORLD

    -- WORLD
    self:push(data)
end

function ChatManager:refreshCDTime(channelType, time)
    self.cdTimeMap[channelType] = time
end

function ChatManager:getCDTime(channelType)
    return self.cdTimeMap[channelType] or 0
end


function ChatManager:isInCd(channelType)
    local time = self.cdTimeMap[channelType]
    if time == nil or time == 0 then
        return false, 0
    end
    local timeNow = GameManager:getNormalServerTime()
    if time > timeNow then
        return true, time - timeNow
    end
    return false, 0
end

return ChatManager