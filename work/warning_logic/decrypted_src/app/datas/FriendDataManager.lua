-- FriendDataManager.lua
-- Author:ydli
-- 2017年09月27日
-- Using:好友模块
local FriendManager = class("FriendManager")
Game = Game or {}
Game.FriendManager = FriendManager
require "cocos.cocos2d.json"
local ProtobufUtil = require "utils.ProtobufUtil"

local GameDataManager = require("app.game.GameDataManager")
local INVITE_FRIEND_COUNT_LIMITE = tonumber(ConfigManager:getGeneralForKey("sendFriendRequestPerMin"))
local friend_list_fileName = "friend.ud"
function FriendManager:ctor()
    self.friendList = {}
    self.inviteList = {}
    self.friendNewCache = {}
    self.updateTimestamp = 0
    self.isReadCache = false
    self.inviteFriendCount = 0 --每分钟累计邀请好友次数
    self.inviteFriendTime = 0  --每分钟累计邀请好友次数
end

function FriendManager:dtor()
    self.friendList = {}
    self.inviteList = {}
    self.friendNewCache = {}
    self.updateTimestamp = 0
    self.isReadCache = false
    self.inviteFriendCount = 0 --每分钟累计加好友次数
    self.inviteFriendTime = 0  --每分钟累计加好友次数
end

function FriendManager:getInstance()
    if g_friendManager == nil then
        g_friendManager = FriendManager.new()
        g_friendManager:init()
    end
    return g_friendManager
end


function FriendManager:purgeInstance()
    if g_friendManager ~= nil then
        g_friendManager = nil
    end
end

function FriendManager:init()
    print("FriendManager:init")
end

function FriendManager:clear()
    self:dtor()
    self:purgeInstance()
end

-- 回档（恢复）清理数据
function FriendManager:restoreClear()
end


function FriendManager:checkAndRefreshFriend(data)
    if not self.isReadCache then
        self:readFriendNewFlagList()
    end
    self.updateTimestamp = data.updateTimestamp
    local isEmpty = table.nums(self.friendNewCache) == 0 and true or false
    data.friendList = data.friendList or {}
    for k, v in ipairs(data.friendList) do
        self.friendList[v.PK] = self:refreshFriendData(self.friendList[v.PK], v)
        if isEmpty then
            self.friendNewCache[v.PK] = 1
        end
        Game.ChatManager:getInstance():refreshPersonalUserID({pk=v.PK, userID=v.userID, nickName = v.nickName})
    end

    --refresh
    local friendNewCacheChange = false
    if not isEmpty then
        for k, v in pairs(self.friendNewCache) do
            if self.friendList[k] == nil then
                self.friendNewCache[k] = nil
                friendNewCacheChange = true
            end 
        end
    end

    if friendNewCacheChange then
        self:writeFriendNewFlagList(self.friendNewCache)
    end

    data.friendInviteList = data.friendInviteList or {}
    for k, v in ipairs(data.friendInviteList) do
        self.inviteList[v.PK] = self:refreshFriendData(self.inviteList[v.PK], v)
    end
    self:noticeNewFlag()
end

function FriendManager:noticeNewFlag()
    if self:isNewFlagOfAll() then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_NEW_FRIEND_FLAG, false)
    else
        Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_NEW_FRIEND_FLAG, true)
    end
end

function FriendManager:deleteFriend(friendPk)
    self.friendList[friendPk] = nil
    self.friendNewCache[friendPk] = nil
    self:noticeNewFlag()
    self:writeFriendNewFlagList(self.friendNewCache)
end

function FriendManager:deleteBatchFriend(pks)
    for k, friendPk in ipairs(pks) do
        self.friendList[friendPk] = nil
        self.friendNewCache[friendPk] = nil
    end
    self:noticeNewFlag()
    self:writeFriendNewFlagList(self.friendNewCache)
end

function FriendManager:addFriend(friendData)
    self.friendList[friendData.PK] = self:refreshFriendData(self.friendList[friendData.PK], friendData)
    Game.ChatManager:getInstance():refreshPersonalUserID({pk=friendData.PK, userID=friendData.userID, nickName = friendData.nickName})
    self:deleteInvition(friendData.PK)
    self:noticeNewFlag()
end

function FriendManager:deleteInvition(friendPk)
    self.inviteList[friendPk] = nil
    self:noticeNewFlag()
end

function FriendManager:addInvition(inviteData)
    self.inviteList[inviteData.PK] = self:refreshFriendData(self.inviteList[inviteData.PK], inviteData)
    Game.ChatManager:getInstance():refreshPersonalUserID({pk=inviteData.PK, userID=inviteData.userID, nickName = inviteData.nickName})
    self:noticeNewFlag()
end

function FriendManager:refreshFriendData(oldData, newData)
    if oldData == nil then
       oldData = {}
    end 
    oldData.PK= newData.PK
    oldData.loginStatus = newData.loginStatus           
    oldData.nickName = ToolsUtil:replaceShowNickNameStr(newData.nickName)
    oldData.userID = newData.userID 
    oldData.sex = newData.sex
    oldData.faceDecodeID = newData.faceDecodeID
    oldData.updateTimestamp = newData.updateTimestamp
    oldData.roleLV = newData.roleLV 
    oldData.isInCave = newData.isInCave
    oldData.offlineTime = newData.offlineTime
    oldData.wearEquipId = newData.wearEquipId
    oldData.reincarntionLv = newData.reincarntionLv
    return oldData
end

function FriendManager:getFriendData()
    local cloneData = {}
    local offLineData = {}
    for k, v in pairs(self.friendList) do
        if v.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE then
            table.insert(offLineData, v)
        else
            table.insert(cloneData, v)
        end
    end
    for k, v in ipairs(offLineData) do 
        table.insert(cloneData, v)
    end
    return cloneData
end

function FriendManager:getInviteData()
    local cloneData = {}
    for k, v in pairs(self.inviteList) do
        table.insert(cloneData, v)
    end
    table.sort(cloneData, function(a, b)
        return a.updateTimestamp > b.updateTimestamp
    end)
    return cloneData
end

function FriendManager:getUpdateTimestamp()
    return self.updateTimestamp
end

function FriendManager:isFriend(friendPk)
    return self.friendList[friendPk] ~= nil
end

function FriendManager:isInviting(friendPk)
    return self.inviteList[friendPk] ~= nil
end

function FriendManager:getFriendNumber()
    return table.nums(self.friendList)
end

function FriendManager:inviteFriend(frienId)
    frienId = checkint(frienId)
    if GameDataManager:getInstance():getMasterPK() == frienId then
        UI.ScrollBar:createByText(UI.TEXT_1170408)
        return false
    end
    if self:isFriend(frienId)then
        UI.ScrollBar:createByText(UI.TEXT_1170407)
        return false
    end
    if self:getFriendNumber() >= PublicDefine.CONST_DEFINITION.MAX_FRIENDS_NUM then
        UI.ScrollBar:createByText(UI.TEXT_1170406)
        return false
    end
    if frienId < 10000000 then--玩家pk至少8位， 且服务器承诺以后不会改
        printError("frienId is invalid when FriendManager inviteFriend ", frienId)
        UI.ScrollBar:createByText(UI.TEXT_1170420)
        return false
    end
    -- if self:isInviting(frienId)then
    --     UI.ScrollBar:createByText(UI.TEXT_1170411)
    --     return false
    -- end

    if  GameManager:getNowServerTime() - self.inviteFriendTime > 60 then
        self.inviteFriendCount = 0
        self.inviteFriendTime = GameManager:getNowServerTime()
    end
    self.inviteFriendCount = self.inviteFriendCount + 1
    
    if self.inviteFriendCount > INVITE_FRIEND_COUNT_LIMITE  then
        UI.ScrollBar:createByText(UI.TEXT_1170412)
        return
    end
    
    GameManager:inviteFriend(GameDataManager:getInstance():getMasterPK(), frienId)
    return true
end

function FriendManager:clearAllNewFlag()
    if(self.friendList) then 
        for k,v in pairs(self.friendList) do 
            self.friendNewCache[k] = 1
        end
    end

    self:noticeNewFlag()
    self:writeFriendNewFlagList(self.friendNewCache)
end

function FriendManager:removeNewFlag(friendPk)
    self.friendNewCache[friendPk] = 1
    self:noticeNewFlag()
    self:writeFriendNewFlagList(self.friendNewCache)
end

function FriendManager:isNewFlagByPk(friendPk)
    return self.friendNewCache[friendPk] == nil
end

function FriendManager:isNewFlagOfAll()
    -- dump(self.friendList, "self.friendList")
    -- dump(self.inviteList, "self.inviteList")
    -- dump(self.friendNewCache, "self.friendNewCache")
    for k, v in pairs(self.friendList) do
        if self:isNewFlagByPk(k) then
             return true
        end
    end
    if table.nums(self.inviteList) > 0 then
        return true
    end
    return false
end

function FriendManager:writeFriendNewFlagList(cacheMap)
    if(cacheMap) then
        Avalon.FileManager:saveMapDataToLocal(cacheMap, friend_list_fileName, true)
    end
end

function FriendManager:readFriendNewFlagList()
    self.isReadCache = true
    self.friendNewCache = Avalon.FileManager:readMapDataFromLocal(friend_list_fileName, true)
end

function FriendManager:getLastReqFriendTime()
    return self._lastReqFriendTime or 0
end

function FriendManager:setLastReqFriendTime(lastReqFriendTime)
    self._lastReqFriendTime = lastReqFriendTime
end

return FriendManager













