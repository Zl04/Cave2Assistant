-- MailDataManager.lua
-- Author:ydli
-- 2017年10月27日
-- Using:邮箱模块
local MailManager = class("MailManager")
Game = Game or {}
Game.MailManager = MailManager
require "cocos.cocos2d.json"
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
    
local fileName = "mail.ud"
function MailManager:ctor()
    self.mailNewCache = {}
    self.mailList = {}
    self.isReadCache = false
    self.richTextCache = {}
    self.delMailList = {}
end

function MailManager:dtor()
    self.mailNewCache = {}
    self.mailList = {}
    self.isReadCache = false
    self.delMailList = {}
    for k, v in pairs(self.richTextCache) do
        v:release()
    end
    self.richTextCache = {}
end

function MailManager:getInstance()
    if g_mailManager == nil then
        g_mailManager = MailManager.new()
        g_mailManager:init()
    end
    return g_mailManager
end


function MailManager:purgeInstance()
    if g_mailManager ~= nil then
        g_mailManager = nil
    end
end

function MailManager:init()
    print("MailManager:init")
end

function MailManager:clear()
    self:dtor()
    self:purgeInstance()
end

-- 回档（恢复）清理数据
function MailManager:restoreClear()
end

--[[
 mailID;
 mailStrID --未解决64位 重新定义的ID
goodsIDs = {templateID, num };             // 奖励的物品
outTime = 3;
titleKey = 4;
contentKey = 5;
hrefUrlKey = 6; 
subType = 7; --//子类型 
createTime = 8;  --//创建时间戳（用于排序)

]]
--
function MailManager:refreshMailList(msgData, isNotice, isGetWebLanguage)
    local mailList = msgData.mailList or {}
    if not self.isReadCache then
        self:readNewFlagList()
    end
    for k, v in pairs(mailList) do
        local data = {}
        data.mailID = v.mailStrID 
        data.subType = v.subType
        data.titleKey = v.titleKey
        data.contentKey = v.contentKey
        data.hrefUrlKey = v.hrefUrlKey
        data.goodsIDs = v.goodsIDs or {}
        data.outTime = v.outTime
        data.rewardStat = v.rewardStat
        data.createTime = v.createTime or 0
        data.extend = v.extend or {}
        data.InstEquips = {}
        data.InstPets = {}
        data.glyphs = {}
        for k, v in ipairs(v.InstEquips) do
            local goodsData = Net.NetGoodsSystem:handlePackGoodsData(v)
            if goodsData then
                table.insert(data.InstEquips, goodsData)
            end
        end

        for k, v in ipairs(v.InstPets) do
            local petData = Data.PetRoleData:create()
            petData:init(v, true)
            if petData then
                table.insert(data.InstPets, petData)
            end
        end

        for k, v in ipairs(v.glyphs) do
            local goodsData = Net.NetGoodsSystem:handleMailPackGlyphsData(v)
            if goodsData then
                table.insert(data.glyphs, goodsData)
            end
        end

        self.mailList[data.mailID] = data
    end
    self:noticeNewFlag()
    if isGetWebLanguage then
        self:getLanguageFromWebServer(isNotice)
    end

    --refresh
    for mailID, v in pairs(self.mailNewCache) do
        if self.mailList[mailID] == nil then
            self.mailNewCache[mailID] = nil
        end 
    end
end

--MailSubType_Web 类型从web端拉取文本， MailSubType_Scene类型从本地获取文本 但颜色默认59_42_12
function MailManager:getLanguageFromWebServer(isNotice)
    local keyList = {}
     for k, v in pairs(self.mailList) do
        local subType = v.subType
        -- print("-----------------------subType = "..subType)
        -- dump(PublicDefine.MailSubType)
        if subType == PublicDefine.MailSubType.MailSubType_Web  then 
            if v.title == nil and v.titleKey ~= nil and v.titleKey ~= 0 then
                table.insert(keyList, v.titleKey)
            end
            if v.content == nil and v.contentKey ~= nil and v.contentKey ~= 0 then
                table.insert(keyList, v.contentKey)
            end
            if v.hrefUrl == nil and v.hrefUrlKey ~= nil and v.hrefUrlKey ~= 0 then
                table.insert(keyList, v.hrefUrlKey)
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
    -- todo 请求文本
    LanguageManager:getInstance():getLanguageFromWebServer(keyList, handler(self, self.refreshWebLaunguageCallback), isNotice)
end

function MailManager:noticeNewFlag()
    if self:isNewFlagOfAll() then
        GameManager:refreshMailNewFlag(false)
    else
        GameManager:refreshMailNewFlag(true)
    end
    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end

function MailManager:removeNewFlag(mailID)
    -- print("----------------MailManager:removeNewFlag  mailID = "..mailID)
    if self.mailNewCache[mailID] == nil then
        self.mailNewCache[mailID] = 1
        self:noticeNewFlag()
        self:writeNewFlagList(GameDataManager:getInstance():getMasterPK(), self.mailNewCache)
    end
end

function MailManager:isNewFlagByMailId(mailId)
    -- print("------isNewFlagByMailId mailId = "..mailId)
    -- local boolFlag = false
    -- if self.mailNewCache[mailId] == nil then
    --     boolFlag = true
    -- end
    -- dump(boolFlag, "boolFlag")
    -- dump(self.mailNewCache)
    return self.mailNewCache[mailId] == nil
end

function MailManager:isNewFlagOfAll()
    for k, v in pairs(self.mailList) do
        if self:isNewFlagByMailId(k) then
            return true
        end
    end
    return false
end

--
function MailManager:writeNewFlagList()
    Avalon.FileManager:saveMapDataToLocal(self.mailNewCache, fileName, true)
end

function MailManager:readNewFlagList()
    self.isReadCache = true
    self.mailNewCache = Avalon.FileManager:readMapDataFromLocal(fileName, true, false)
end

function MailManager:refreshWebLaunguageCallback(webLaunguageList, params)
    for k, v in pairs(self.mailList) do
        local subType = v.subType
        if subType == PublicDefine.MailSubType.MailSubType_Web  then 
            if v.title == nil then--防止有效 内容被覆盖
                v.title = AvalonUtil.getWebLaunguageByKey(webLaunguageList, v.titleKey)            
            end
            if v.content == nil then
                v.content = AvalonUtil.getWebLaunguageByKey(webLaunguageList, v.contentKey)
            end
            if v.hrefUrl == nil then
                v.hrefUrl = AvalonUtil.getWebLaunguageByKey(webLaunguageList, v.hrefUrlKey)
            end
        elseif subType == PublicDefine.MailSubType.MailSubType_Scene then
            local LanguageManager = require("app.game.LanguageManager")
            local dataTitle = {}
            dataTitle.text = LanguageManager:getInstance():getLocalString(tonumber(v.titleKey))
            dataTitle.color =  AvalonUtil:colorRGB2Str(UI.FONT_COLOR_41_41_45)
            dataTitle.fontSize = UI.FONT_SIZE_18PX
            local temp = {}
            table.insert(temp, dataTitle)
            v.title = json.encode(temp)
            
            v.content = LanguageManager:getInstance():getLocalString(tonumber(v.contentKey))
            v.content = AvalonUtil.textFormat(webLaunguageList, AvalonUtil:colorRGB2Str(UI.FONT_COLOR_41_41_45), UI.FONT_SIZE_18PX, nil, v.content, v.extend) 

            v.hrefUrl = AvalonUtil.getWebLaunguageByKey(webLaunguageList, v.hrefUrlKey)
        end
    end
    local isNotice = params[1]
    if isNotice then
         --刷新邮件列表页面
        local mailList, isNeedWebLaunguage = self:getMailList()
        if not isNeedWebLaunguage then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_RETFRESH_MAIL_LIST, mailList)
        end
    end
end

function MailManager:setMailRewardState(mailId, state)
    local mailData = self.mailList[mailId]
    if mailData then
        mailData.rewardStat = state
    end
end

function MailManager:getMailList()
    -- dump(self.mailList, "-----MailManager:getMailList()")
    local list = {}
    local isNeedWebLaunguage = false
    for k, v in pairs(self.mailList) do
        if v.title ~= nil and  v.content ~= nil then
        else
            isNeedWebLaunguage = true
            break
        end
    end
    
    local newList = {}
    local oldList = {}
    for k, v in pairs(self.mailList) do
        local curTime = GameManager:getNowServerTime()
        if v.outTime + GameManager:getEPOCHTime() > curTime then
            if self:isNewFlagByMailId(v.mailID) then
                table.insert(newList, v)
            else
                table.insert(oldList, v)
            end
        else
            self:removeNewFlag(v.mailID)
        end
    end
    table.sort(newList, function(a, b)
        return a.createTime > b.createTime
    end)
    table.sort(oldList, function(a, b)
        return a.createTime > b.createTime
    end)

    for k, v in ipairs(newList) do
        table.insert(list, v)
    end
    for k, v in ipairs(oldList) do
        table.insert(list, v)
    end
        -- dump(list, "-----MailManager:getMailList()")
    return list, isNeedWebLaunguage
end

function MailManager:removeMail(mailID)
    -- table.remove(self.mailList, mailID)
    -- print("---------- MailManager:removeMail(mailID) = "..mailID)
    self.mailList[mailID] = nil
    self:removeNewFlag(mailID)
end

function MailManager:checkLimitAndRemove()
    if table.nums(self.mailList) > PublicDefine.CONST_DEFINITION.HERO_MAX_MAIL_NUM then
        local minMailID = nil
        local createTime = nil
        for k, v in pairs(self.mailList) do
            if createTime == nil then
                createTime = v.createTime
            else
                if createTime > v.createTime then
                    minMailID = v.mailID
                    createTime = v.createTime
                end
            end 
        end
        if minMailID ~= nil then
            self:removeMail(minMailID)
        end
    end
end

function MailManager:isExistingMail(mailID)
    -- table.remove(self.mailList, mailID)
    return self.mailList[mailID] ~= nil
end

function MailManager:isHaveAttachmentReward(mailID)
    local data = self.mailList[mailID]
    if data == nil then
        return false
    end

    if (#data.goodsIDs > 0 or #data.InstEquips > 0 or #data.InstPets > 0 or #data.glyphs > 0) and data.rewardStat == PublicDefine.MAIL_REWARD_STATE.MailRewardStat_New then
        return true
    end
    return false
end

function MailManager:getOneMail(mailID)
    return self.mailList[mailID]
end


function MailManager:getUnReadMailList()
    local newMailList = {}
    for k, v in pairs(self.mailList) do
        if self:isNewFlagByMailId(k) then
             table.insert(newMailList, v)
        end
    end
    return newMailList
end

function MailManager:insertDelId(mailId)
    if not self:getOneMailDelSelected(mailId) then
        table.insert(self.delMailList, mailId)
    end
end

function MailManager:removeDelId(mailId)
    for k, v in ipairs(self.delMailList) do
        if v == mailId then
            table.remove(self.delMailList, k)
            break
        end
    end
end

function MailManager:getDelMailList()
    return self.delMailList
end

function MailManager:clearDelMailList()
    self.delMailList = {}
end

--[[true: 表示已经被勾选中]]
function MailManager:getOneMailDelSelected(mailId)
    for k, v in ipairs(self.delMailList) do
        if v == mailId then
            return true
        end
    end
    return false
end

function MailManager:insertRichTextCache(mailID, _richText)
    if _richText == nil then
        return
    end
    self.richTextCache[mailID] = _richText
end

function MailManager:getRichTextCache(mailID)
    return self.richTextCache[mailID]
end

return MailManager













