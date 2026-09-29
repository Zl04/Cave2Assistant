
--[[
    处理保存一些游戏设置数据
]]

local Manager = Game.Manager

local _moveType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.moveType,MoveType.ALL)    -- CONTROLLER   CLICK
local _showType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.showType,ShowType.VALUE)     -- NONE  VALUE  PERCENT
-- local _shieldChat = cc.UserDefault:getInstance():getBoolForKey("shieldChat",false)      -- 屏蔽聊天
local _fpsMode =  cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.fpsMode,60) -- 分辨率模式
local _fpsToast = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.fpsToast,false) -- 高分辨率模式是否已经提示过玩家
local _shieldChat = false

-- 设置移动操作类型
function Manager:setMoveType(moveType, isPersistent)
    if (isPersistent == nil) then isPersistent = true end

    _moveType = moveType
    if (isPersistent) then
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.moveType, moveType)
        cc.UserDefault:getInstance():flush()
    end
end

-- 获取移动操作状态
function Manager:getMoveType()
    local _moveType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.moveType, MoveType.ALL)
    return _moveType
end

function Manager:getIsClickMoveType()
    if(_moveType == MoveType.CONTROLLER) then 
        return false
    end

    -- body
    -- if MULTI_TOUCH_CONTROL_ID then 
    --     return false
    -- end

    return true
end


function Manager:getIsTouchMoveType()
    -- body
    if(_moveType == MoveType.CLICK) then 
        return false
    end

    return true
end

-- 设置英雄血量显示类型
function Manager:setRoleInfoShowType(showType)
    _showType = showType
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.showType, showType)
    cc.UserDefault:getInstance():flush()

    Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_BLOOD_SHOW_TYPE)
end

-- 获取英雄血量显示类型
function Manager:getRoleInfoShowType()
    _showType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.showType,ShowType.VALUE)
    return _showType
end


-- 设置屏蔽聊天
function Manager:setShieldChat(shieldChat)
    _shieldChat = shieldChat
    -- cc.UserDefault:getInstance():setBoolForKey("shieldChat", shieldChat)
    -- cc.UserDefault:getInstance():flush()
end

-- 获取屏蔽聊天
function Manager:getShieldChat()
    return _shieldChat
end

function Manager:setFps(mode)
    _fpsMode = mode
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.fpsMode, mode)
    cc.UserDefault:getInstance():flush()

    if cc.Director:getInstance():getAnimationInterval() ~= mode then
        print("设置FPS",mode)
        cc.Director:getInstance():setAnimationInterval(1/mode)
    end
end
-- 获取分辨率模式
function Manager:getFps()
    return _fpsMode
end
-- 是否已经提示过
function Manager:isFpsModeNoticed()
    return _fpsToast
end
function Manager:setFpsModeNoticed()
    cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.fpsToast, true)
    cc.UserDefault:getInstance():flush()
end

function Manager:setCustomDefultSetting()
    local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        return
    end

    globalUserData:setCustomDefultSetting()
end

function Manager:getCustomDefultSetting()
    local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        return false
    end

    return globalUserData:getCustomDefultSetting()
end

function Manager:setCustomDefultToast()
    local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        return
    end

    globalUserData:setCustomDefultToast()
end

function Manager:getCustomDefultToast()
	local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        return false
    end

    return globalUserData:getCustomDefultToast()
end

-- 高质量画质自定义
function Manager:setCustomHQ(type, inputValue)
    local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        return
    end

    local value = true
    if inputValue ~= nil then
        value = inputValue
    else
        if type == CUSTOM_HQ_TYPE.PERSON then
            value = 3
        end
    end

    if type == CUSTOM_HQ_TYPE.WEATHER then
        globalUserData:setSettingShowWeather(value)
    elseif type == CUSTOM_HQ_TYPE.NPC then
        globalUserData:setSettingShowNPC(value)
    elseif type == CUSTOM_HQ_TYPE.FRAME then
        globalUserData:setSettingShowFrame(value)
    elseif type == CUSTOM_HQ_TYPE.DECORATE then
        globalUserData:setSettingShowDecorate(value)
    elseif type == CUSTOM_HQ_TYPE.FLOATS then
        globalUserData:setSettingShowFloats(value)
    elseif type == CUSTOM_HQ_TYPE.HORCRUX then
        globalUserData:setSettingIsHideHorcrux(value)
    elseif type == CUSTOM_HQ_TYPE.PET then
        globalUserData:setSettingIsHidePet(value)
    elseif type == CUSTOM_HQ_TYPE.PERSON then
        globalUserData:setSettingShowPersonCount(value)
    end
end

function Manager:getCustomHQ(type)
    local ret = false
    local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        if type == CUSTOM_HQ_TYPE.PERSON then
            ret = 3
        end
        return ret
    end

    if type == CUSTOM_HQ_TYPE.WEATHER then
        ret = globalUserData:getSettingShowWeather()
    elseif type == CUSTOM_HQ_TYPE.NPC then
        ret = globalUserData:getSettingShowNPC()
    elseif type == CUSTOM_HQ_TYPE.FRAME then
        ret = globalUserData:getSettingShowFrame()
    elseif type == CUSTOM_HQ_TYPE.DECORATE then
        ret = globalUserData:getSettingShowDecorate()
    elseif type == CUSTOM_HQ_TYPE.FLOATS then
        ret = globalUserData:getSettingShowFloats()
    elseif type == CUSTOM_HQ_TYPE.HORCRUX then
        ret = globalUserData:getSettingIsHideHorcrux()
    elseif type == CUSTOM_HQ_TYPE.PET then
        ret = globalUserData:getSettingIsHidePet()
    elseif type == CUSTOM_HQ_TYPE.PERSON then
        ret = globalUserData:getSettingShowPersonCount()
    end

    return ret
end

function Manager:getPersonNum()
    local choice = self:getCustomHQ(CUSTOM_HQ_TYPE.PERSON)
    -- print(":getPersonNum=", choice, type(choice))
    return Game.PersonCount[choice]
end

function Manager:getAutoBattleStatus()
    if(self._autoBattle == nil) then
        self._autoBattle = false
        local GameDataManager = require("app.game.GameDataManager")
        local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
        if globalUserData then
            self._autoBattle = globalUserData:getAutoBattleStatus()
        end
    end

    return self._autoBattle
end

function Manager:setAutoBattleStatus(status)
    self._autoBattle = status

    local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if globalUserData then
       globalUserData:setAutoBattleStatus(status)
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_CHANGE_AUTO_BATTLE_STATUS)
end

function Manager:getAutoBattleType()
    if(self._autoBattleType == nil) then
        self._autoBattleType = 1
        local GameDataManager = require("app.game.GameDataManager")
        local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
        if globalUserData then
            self._autoBattleType = globalUserData:getAutoBattleID()
        end
    end

    return self._autoBattleType
end

function Manager:setAutoBattleType(type)
    self._autoBattleType = type

    local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if globalUserData then
       globalUserData:setAutoBattleID(type)
    end
    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_CHANGE_AUTO_BATTLE_TYPE)
end

function Manager:getIsNewTownType()
    if(self._isNewTownType ~= nil) then 
        return self._isNewTownType
    end
    self._isNewTownType = false
    local GameDataManager = require("app.game.GameDataManager")
    local gameUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    if(gameUserData) then
        self._isNewTownType = gameUserData:getIsNewTownType()
    end

    return self._isNewTownType
end

function Manager:setIsNewTownType(type)
    self._isNewTownType = type

    local GameDataManager = require("app.game.GameDataManager")
    local gameUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    if(gameUserData) then
       gameUserData:setIsNewTownType(type)
       Avalon.UserDataManager:saveDataToFile(gameUserData:getType())
    end
end

function Manager:getIsInitNewTownTypeFlag()
    local GameDataManager = require("app.game.GameDataManager")
    local gameUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    if(gameUserData) then
        return gameUserData:getIsInitNewTownTypeFlag()
    end

    return false
end