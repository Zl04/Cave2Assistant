--[[
    公会宝箱数据管理器
]]
------------------------------------------------------
require "app.config.ConfigManager"
require "app.datas.MasterDataManager"
require "app.datas.GoodsDataManager"

local ProtobufUtil = require("utils.ProtobufUtil")
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

local DEBUG = false

GuildBoxDataManager = GuildBoxDataManager or {}

GuildBoxDataManager.CANNOT_OPEN_REASON = {
    UNKOWN = 0,
    BAG_FULL = 1,
    UNABLE_TO_SEE = 2,
    NUM_LIMIT = 3,
    NO_BOX = 4,
    NOT_IN_TOWN = 5,
}

-- 初始化
function GuildBoxDataManager:init()
    self:clear()
    if (not self.schedulerID) then
        self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.update), 0.1, false)
    end
end


function GuildBoxDataManager:updateMostRecentInfo()
    if (self:getExpirableBoxNum() <= 0) then
        return
    end
    for k,box in pairs(self.guildBoxTable) do
        if (box.expiration and box.expiration ~= 0) then
            if (not self.mostRecentExpireTime or (self.mostRecentExpireTime and box.expiration < self.mostRecentExpireTime)) then
                self.mostRecentExpireTime = box.expiration
                self.mostRecentExpireBox = box
            end
        end
    end
end

-- 处理到时删除
function GuildBoxDataManager:update()
    -- 清除过期产品
    if (not self.mostRecentExpireTime) then
        self:updateMostRecentInfo()
    else
        local timeNow = GameManager:getNormalServerTime()
        if (timeNow > self.mostRecentExpireTime) then
            self:removeAllExpiredBoxes(true)
            self.mostRecentExpireTime = nil
            self.mostRecentExpireBox = nil
            self:updateMostRecentInfo()
        end
    end
end

-- 网络初始化
function GuildBoxDataManager:initNet(data)
    if data.msgSn == 0 then
        self.allBoxData = clone(data.boxs)
    end
    if data.msgSn ~= 0 and data.boxs then
        for k, v in pairs(data.boxs) do
            table.insert(self.allBoxData, v)
        end
    end
    if not data.isLastMsg then
        return
    end
    self.curGiantBoxID = data.curGiantBoxID
    self.curGiantBoxProgress = data.curGiantBoxProgress == 0 and 0.01 or data.curGiantBoxProgress
    self.curOpenCounter = data.curOpenCounter

    -- 方便的获取掉落列表的方法
    function parseDropItemArr(boxData)
        if (boxData) then
            boxData.dropItemArr = {}
            local boxDropList = boxData.droplist
            if (boxDropList) then
                local dropListData = ConfigManager:getDropListConfig(boxDropList)
                if (dropListData and dropListData.pond) then
                    for i,pondID in ipairs(dropListData.pond) do
                        local pondData = ConfigManager:getPondById(pondID)
                        if (pondData and pondData.goods) then
                            for i,goodID in ipairs(pondData.goods) do
                                local entry = {}
                                entry.ID = goodID
                                if (pondData.goodsNum) then
                                    local num = pondData.goodsNum[i]
                                    entry.num = num or 1
                                end
                                table.insert(boxData.dropItemArr, entry)
                            end
                        end
                    end
                end
            end
        end
    end

    -- 下一个大宝箱
    if (self.curGiantBoxID) then
        self.curGiantBoxData = clone(ConfigManager:getGuildBoxByID(self.curGiantBoxID))
        parseDropItemArr(self.curGiantBoxData)
    end
    
    -- 最后宝箱instID
    if (#self.allBoxData > 0) then
        local box = self.allBoxData[#self.allBoxData]
        if (box) then
            self.lastBoxInstID = box.id.instID
        end
    end

    -- 小宝箱
    local smallBoxUpdated = false
    for i,boxData in ipairs(self.allBoxData) do
        smallBoxUpdated = true
        local isNewBox = false
        local boxInstID = boxData.id.instID
        local boxTempID = boxData.id.tempID
        local box = self.guildBoxTable[boxInstID]
        if (not box) then
            isNewBox = true
            self:invalidateMostRecentExpireTime()
            box = clone(ConfigManager:getGuildBoxByID(boxTempID))
            if (box.isGiant == 1) then
                table.insert(self.guildGiantBoxArr, box)
                parseDropItemArr(box)
            else
                table.insert(self.guildBoxArr, box)
            end
        end
        if (box) then
            -- 所有宝箱的基础数据
            box.instID = boxInstID
            box.tempID = boxTempID
            if (ProtobufUtil:checkFieldIsInit(boxData, "reason")) then
                box.reason = boxData.reason
            else
                box.reason = nil
            end
            if (box.reason == PublicDefine.DROP_REASON_TYPE.DROP_REASON_GUILDBOSS_LVUP) then
                box.contributor = LanguageManager:getInstance():getLocalString(1112391)
            elseif (box.reason == PublicDefine.DROP_REASON_TYPE.DROP_REASON_GUILD_WISH) then
                box.contributor = LanguageManager:getInstance():getLocalString(1112916)
            else
                box.contributor = boxData.contributor
            end
            box.expiration = boxData.expiration
            if (box.expiration and box.expiration < 0) then
                box.expiration = 0
            end

            -- 是否可以获取, not dropped = 可获取
            box.isDroped = boxData.isDroped
            if (box.isDroped) then
                if (ProtobufUtil:checkFieldIsInit(boxData, "goodsID")) then
                    box.goodsID = boxData.goodsID
                end
                if (ProtobufUtil:checkFieldIsInit(boxData, "goodsNum")) then
                    box.goodsNum = boxData.goodsNum
                end
            end
            self.guildBoxTable[boxInstID] = box
        end
    end

    -- 更新可打开箱子数量
    self:updateExpirableBoxNum()
    -- 消除红点
    self:removeNewBoxFlag(true)
    -- 更新表现
    -- if (smallBoxUpdated) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW)
    -- else
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_GIANT_BOX_VIEW)
    -- end
end

-- 更新箱子状态
function GuildBoxDataManager:updateBoxOpenStatus(dropData)
    -- 检查公会和PK信息
    local guildID = nil
    local guildData = MasterDataManager:getGuildData()
    if (guildData) then guildID = guildData:getID() end
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    if (not masterPK or not guildID or dropData.guildID ~= guildID or dropData.pk ~= masterPK) then return end

    -- 更新状态
    local isGiantBoxOpened = false
    local dropNum = #dropData.dropInfo
    local dropDisplayDataArr = {}
    for i,dropData in ipairs(dropData.dropInfo) do
        local box = self.guildBoxTable[dropData.id.instID]
        if (box) then
            box.isNewOpen = true
            box.isDroped = true
            box.goodsID = dropData.goodsID
            box.goodsNum = dropData.goodsNum
            self.curOpenCounter = self.curOpenCounter + 1
            if (box.isGiant == 1) then 
                isGiantBoxOpened = true
            else
                self.curGiantBoxProgress = self.curGiantBoxProgress + box.pointValue
            end

            -- 如果大宝箱, 或者非单个小包厢, 往显示道具列表里添加道具进行显示
            if (dropNum > 1 or (dropNum == 1 and isGiantBoxOpened)) then
                local dummyItem = GoodsDataManager:createLocalGoodsData(box.goodsID)
                if(dummyItem) then
                    dummyItem:setNum(box.goodsNum)
                    table.insert(dropDisplayDataArr, dummyItem)
                end
            end
        end
    end

    -- 如果有需要显示获得的道具, 显示
    if (#dropDisplayDataArr > 0) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_COMMON_REWARD, dropDisplayDataArr)  
    end

    -- 更新可打开宝箱数量
    self:updateExpirableBoxNum()
    
    -- 更新大宝箱
    if (isGiantBoxOpened) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW, true)
    else
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOX_LIST)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW)
    end
    -- 请求更新大宝箱真实进度
    self:requestNewBoxInfo()
end

-- 更新新箱子状态
function GuildBoxDataManager:newBoxArrive(data, isNotifyUpdateView)
    if (data.isGiant == 1) then
        Game.ChatManager:getInstance():sendSystemMsg(LanguageManager:getInstance():getLocalString(1112111) --[["公会大宝箱已更新"]], ChatMessageType.SYSTEM_GUILD_MEMBER)
    end
    self.newBoxExist = true
    if (isNotifyUpdateView) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_NEW_BOX_CHANGED, true)
    end
end

-- 请求更新箱子信息
function GuildBoxDataManager:requestNewBoxInfo()
    Net.NetGuildSystem:requestBoxList(self.lastBoxInstID or 0)
end

-- 请求打开箱子
function GuildBoxDataManager:requestOpenBox(idx, isReversed)
    -- 检查空格子数
    if (GameDataManager:getFreePacketBoxNum() <= 0) then return end

    -- 凑公会ID和PK, 消息需要
    require "app.datas.MasterDataManager"
    local guildID = nil
    local guildData = MasterDataManager:getGuildData()
    if (guildData) then guildID = guildData:getID() end
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    if (not masterPK or not guildID) then return end

    -- 方便拼装方法
    local function appendBox(boxList, boxData)
        local boxID = {}
        boxID.instID = boxData.instID
        boxID.tempID = boxData.tempID
        table.insert(boxList, boxID)
    end

    -- 根据IDX拼装ID
    local boxesToOpen = {}
    if (idx and idx > 0) then
        -- 根据正反序获取箱子列表
        local guildBoxArr = nil
        if (isReversed) then
            guildBoxArr = self:getSmallBoxDataReversed()
        else
            guildBoxArr = self.guildBoxArr
        end

        -- 检查箱子
        local box = guildBoxArr[idx]
        if (not box) then
            printWarn("没有此公会宝箱, idx = ", idx)
            return
        end
        if (box.isDroped) then 
            return 
        end
        
        appendBox(boxesToOpen, box)
    elseif (idx == nil) then
        --拼装所有可以打开的小宝箱
        for i,box in ipairs(self.guildBoxArr) do
            if (not box.isDroped) then
                appendBox(boxesToOpen, box)
            end
        end
    elseif (idx == -1) then
        -- 拼装一个可以打开的大宝箱
        for i,box in ipairs(self.guildGiantBoxArr) do
            if (not box.isDroped) then
                appendBox(boxesToOpen, box)
                break
            end
        end
    end
    
    -- 发送请求
    if (#boxesToOpen > 0) then
        Net.NetGuildSystem:openGuildBox(guildID, masterPK, boxesToOpen)
    end
    
end

-- 请求服务器移除所有打开的箱子
function GuildBoxDataManager:requestToClearAllDroppedBox()
    require "app.datas.MasterDataManager"
    local guildID = nil
    local guildData = MasterDataManager:getGuildData()
    if (guildData) then guildID = guildData:getID() end
    require "app.datas.RoleDataManager"
    local masterPK = RoleDataManager:getMasterPK()
    if (not masterPK or not guildID) then return end

    Net.NetGuildSystem:requestToClearAllDroppedBox(guildID, masterPK)
end

-- 移除列表中的箱子
function GuildBoxDataManager:removeBoxes(data, isNotifyUpdateView)
    local removed = false
    for i,idToRemove in ipairs(data.instID) do
        for i=#self.guildBoxArr,1,-1 do
            local box = self.guildBoxArr[i]
            if (box.instID == idToRemove) then
                self.guildBoxTable[box.instID] = nil
                table.remove(self.guildBoxArr, i)
                removed = true
            end
        end
        for i=#self.guildGiantBoxArr,1,-1 do
            local box = self.guildGiantBoxArr[i]
            if (box.instID == idToRemove) then
                self.guildBoxTable[box.instID] = nil
                table.remove(self.guildGiantBoxArr, i)
                removed = true
            end
        end
    end
    if (removed) then
        self:updateExpirableBoxNum()
    end
    if (removed and isNotifyUpdateView) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW)
    end
    
    -- 重置最近过期宝箱时间
    self:invalidateMostRecentExpireTime()
    return removed
end

-- 移除所有已打开箱子
function GuildBoxDataManager:removeAllDroppedBox(isNotifyUpdateView)
    local removed = false

    -- 清除小宝箱
    local isSmallBoxUpdated = false
    for i=#self.guildBoxArr,1,-1 do
        local box = self.guildBoxArr[i]
        if (box and box.isDroped) then
            table.remove(self.guildBoxArr, i)
            self.guildBoxTable[box.instID] = nil
            removed = true
            isSmallBoxUpdated = true
        end
    end

    -- 清除大宝箱
    for i=#self.guildGiantBoxArr,1,-1 do
        local box = self.guildGiantBoxArr[i]
        if (box and box.isDroped) then
            table.remove(self.guildGiantBoxArr, i)
            self.guildBoxTable[box.instID] = nil
            removed = true
        end
    end

    -- 重置最近过期宝箱时间
    self:invalidateMostRecentExpireTime()

    -- 通知
    if (removed and isNotifyUpdateView) then
        if (isSmallBoxUpdated) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW)
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_GIANT_BOX_VIEW)
        end
    end
    return removed
end

-- 去掉所有过期的盒子
function GuildBoxDataManager:removeAllExpiredBoxes(isNotifyUpdateView)
    local timeNow = GameManager:getNormalServerTime()
    local removed = false

    -- 清除小宝箱
    local isSmallBoxUpdated = false
    for i=#self.guildBoxArr,1,-1 do
        local box = self.guildBoxArr[i]
        if (box.expiration and box.expiration ~= 0 and box.expiration <= timeNow) then
            self.guildBoxTable[box.instID] = nil
            table.remove(self.guildBoxArr, i)
            removed = true
            isSmallBoxUpdated = true
        end
    end

    -- 清除大宝箱
    for i=#self.guildGiantBoxArr,1,-1 do
        local box = self.guildGiantBoxArr[i]
        if (box.expiration and box.expiration ~= 0 and box.expiration <= timeNow) then
            self.guildBoxTable[box.instID] = nil
            table.remove(self.guildGiantBoxArr, i)
            removed = true
        end
    end

    -- 重置最近过期宝箱时间
    self:invalidateMostRecentExpireTime()

    -- 通知
    if (removed and isNotifyUpdateView) then
        if (isSmallBoxUpdated) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW)
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_GIANT_BOX_VIEW)
        end
    end
    return removed
end

-- 清除新宝箱标签
function GuildBoxDataManager:removeNewBoxFlag(isNotifyUpdateView)
    if (not self.newBoxExist) then return end

    self.newBoxExist = false
    if (isNotifyUpdateView) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GUILD_BOX_NEW_BOX_CHANGED)
    end
end

-- 获取新宝箱标签
function GuildBoxDataManager:getNewBoxFlag()
    return self.newBoxExist
end

-- 获取箱子信息反向排列
function GuildBoxDataManager:getSmallBoxDataReversed()
    local boxNum = self:getSmallBoxDataNum()
    local reverseArr = {}
    for i,box in ipairs(self:getSmallBoxData()) do
        reverseArr[boxNum + 1 - i] = box
    end
    return reverseArr
end

-- 获取小盒子列表
function GuildBoxDataManager:getSmallBoxData()
    return self.guildBoxArr
end

-- 获取箱子数量
function GuildBoxDataManager:getSmallBoxDataNum()
    return #self.guildBoxArr
end

-- 获取[[可以]]领取箱子数量
function GuildBoxDataManager:getDroppableSmallBoxNum()
    local count = 0
    for i,box in ipairs(self.guildBoxArr) do
        if (not box.isDroped) then
            count = count + 1
        end
    end
    return count
end

-- 获取[[已]]领取箱子数量
function GuildBoxDataManager:getDroppedSmallBoxNum()
    local count = 0
    for i,box in ipairs(self.guildBoxArr) do
        if (box.isDroped) then
            count = count + 1
        end
    end
    return count
end

-- 获取可以过期的箱子数量, 包括大箱子
function GuildBoxDataManager:getExpirableBoxNum()
    return self.expirableBoxNum
end

-- 获取已开箱数量
function GuildBoxDataManager:getCurrentOpenedNum()
    return self.curOpenCounter
end

-- 获取作为展示的已开箱数量
function GuildBoxDataManager:getCurrentOpenedNumForDisplay()
    local curOpenCounter = self.curOpenCounter
    local limitNum = self:getLimitOpenNum()
    if (curOpenCounter > limitNum) then 
        return limitNum
    else
        return curOpenCounter
    end
end

-- 获取开箱上限
function GuildBoxDataManager:getLimitOpenNum()
    return tonumber(ConfigManager:getBoxNumLimit())
end

-- 获取大宝箱现在进度
function GuildBoxDataManager:getGiantBoxProgress()
    local droppableGiantBox = self:getDroppableGiantBox()
    if (droppableGiantBox) then
        return droppableGiantBox.pointValue
    else
        return self.curGiantBoxProgress
    end
end

-- 获取大宝箱最大进度
function GuildBoxDataManager:getGiantBoxMaxProgress()
    local maxProgress = 0
    local giantBoxData = self:getGiantBoxData()
    if (giantBoxData) then
        maxProgress = giantBoxData.pointValue or 0
    end
    return maxProgress
end

-- 获取大宝箱显示进度
function GuildBoxDataManager:getGiantBoxProgressForDisplay()
    local maxProgress = self:getGiantBoxMaxProgress()
    local progressToDisplay = self:getGiantBoxProgress()
    if (progressToDisplay > maxProgress) then
        progressToDisplay = maxProgress
    end
    return math.floor(progressToDisplay)
end

-- 获取大宝箱数据
function GuildBoxDataManager:getGiantBoxData()
    local droppableGiantBox = self:getDroppableGiantBox()
    if (droppableGiantBox) then
        return droppableGiantBox, true
    else
        return self.curGiantBoxData, false
    end
end

-- 获取可以打开的大宝箱
function GuildBoxDataManager:getDroppableGiantBox()
    local droppableGiantBox = nil
    for i,giantBox in ipairs(self.guildGiantBoxArr) do
        if (not giantBox.isDroped) then
            droppableGiantBox = giantBox
            break
        end
    end
    return droppableGiantBox
end

-- 获取大宝箱物品列表
function GuildBoxDataManager:getGiantBoxContentItemArr()

    local giantBoxData = self:getGiantBoxData()
    if (giantBoxData) then
        return giantBoxData.dropItemArr or {}
    else
        return {}
    end
end

-- 获取到能打开宝箱界面的时间
function GuildBoxDataManager:getTimeDurationToSeeable()
    local guildData = MasterDataManager:getGuildData()
    if (not guildData) then return -1 end
    if (guildData.joinTime and guildData.joinTime > 0) then
        local newMemberLimitTime = tonumber(ConfigManager:getNewMemberBoxOpenLimitTime())
        local timeNow = GameManager:getNormalServerTime()
        local joinTimeDelta = timeNow - guildData.joinTime
        local seeableTimeDelta = newMemberLimitTime - joinTimeDelta
        return seeableTimeDelta > 0 and seeableTimeDelta or 0
    end
    return 0
end

-- 检查并提示是否能够开箱子(表现实际上不应该放这里, 但是图个方便........)
function GuildBoxDataManager:checkNotifyIsAbleToOpenBox(isGiant)
    local result, reason = nil, nil
    if (isGiant) then
        result, reason = self:isAbleToOpenGiantBox()
    else
        result, reason = self:isAbleToOpenBox()
    end
    if (not result) then
        if (reason == GuildBoxDataManager.CANNOT_OPEN_REASON.NUM_LIMIT) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170227)--[["今日领取数量已达上限"]])
        elseif (reason == GuildBoxDataManager.CANNOT_OPEN_REASON.BAG_FULL) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170081)--[["背包空间不足"]])
        elseif (reason == GuildBoxDataManager.CANNOT_OPEN_REASON.NOT_IN_TOWN) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111316)--[[洞窟内不能领取奖励]])
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112115)--[["还不能领取箱子"]])
        end
        return false, reason
    end
    return true
end

-- 检查是否能打开任何宝箱
function GuildBoxDataManager:isAbleToOpenBox()
    -- 检查是否在城里
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInFightScene()) then
        return false, GuildBoxDataManager.CANNOT_OPEN_REASON.NOT_IN_TOWN
    end

    -- 检查背包数量
    if (GameDataManager:getFreePacketBoxNum() <= 0) then return false, GuildBoxDataManager.CANNOT_OPEN_REASON.BAG_FULL end

    -- 检查新入会员时间
    if (not self:isAbleToSee()) then return false, GuildBoxDataManager.CANNOT_OPEN_REASON.UNABLE_TO_SEE end

    -- 检查打开数量限制
    if (self:getLimitOpenNum() == 0) then return true end
    return self:getCurrentOpenedNum() < self:getLimitOpenNum(), GuildBoxDataManager.CANNOT_OPEN_REASON.NUM_LIMIT
end

-- 检查是否能够打开大宝箱
function GuildBoxDataManager:isAbleToOpenGiantBox()
    local isAbleToGetGiantBox = false
    for i,giantBox in ipairs(self.guildGiantBoxArr) do
        if (not giantBox.isDroped) then
            isAbleToGetGiantBox = true
        end
    end
    if (not isAbleToGetGiantBox) then return false, GuildBoxDataManager.CANNOT_OPEN_REASON.NO_BOX end

    local result, reason = self:isAbleToOpenBox()
    return result, reason
end

-- 检查是否可以看见公会页面
function GuildBoxDataManager:isAbleToSee()
    local timeToSeeable = self:getTimeDurationToSeeable() -- -1 为错误 - 不能看, 0 为已经到时间了 - 可以看, >0 为还需等待 - 不能看
    if (timeToSeeable < 0 or timeToSeeable > 0) then return false end
    return true
end

-- 更新可过期箱子数量
function GuildBoxDataManager:updateExpirableBoxNum()
    self.expirableBoxNum = 0
    for k,box in pairs(self.guildBoxTable) do
        if (box.expiration and box.expiration > 0) then
            self.expirableBoxNum = self.expirableBoxNum + 1
        end
    end
end

-- 重置最近一个过期箱子的时间
function GuildBoxDataManager:invalidateMostRecentExpireTime()
    self.mostRecentExpireTime = nil
end

-- 清空管理器
function GuildBoxDataManager:clear()
    self.guildBoxTable = {}
    self.guildBoxArr = {}
    self.guildGiantBoxArr = {}
    self.allBoxData = {}
    self.curGiantBoxID = nil
    self.curGiantBoxData = nil
    self.curGiantBoxProgress = 0
    self.curOpenCounter = 0
    self.expirableBoxNum = 0 -- 需要为宝箱清除机制维护一个高效的可过期箱子数量
    self.lastBoxInstID = nil
    self.mostRecentExpireTime = nil
    self.mostRecentExpireBox = nil
    self.newBoxExist = false
end

-- 回档（恢复）清理数据
function GuildBoxDataManager:restoreClear()
    self:clear()
end

-- 获取宝箱名字
function GuildBoxDataManager:getGuildBoxNameByID(id)
    local guildBoxData = ConfigManager:getGuildBoxByID(id)
    if (guildBoxData) then
        return LanguageManager:getInstance():getLocalString(guildBoxData.boxName)
    end
    return ""
end

--默认初始化
GuildBoxDataManager:init()