--GameData.lua
--2017-11-7
--Author:zp
--记录 Caveonline 和玩家账号无关的数据

require "utils.userdata.UserData"

Avalon = Avalon or {}

local GameData = class("GameData", Avalon.UserData)
Avalon.GameData = GameData


-- private:
-- 构造函数
function GameData:ctor()
    GameData.super.ctor(self, USER_DATA_TYPE.GAME)

    -- 玩家上次登录方式 默认没有
    self._loginType = -1;
    self._loginServerId = -1;
    self._isRecorderOn = 0
    self._lastReportLoginStepTime = 0
    self._illusionIDNewStringTable = {}
    self._isNewTownType = true
    self._initNewTownTypeFlag = false -- 是否初始化过 self._isNewTownType 字段
    self._areaServerDataArr = {}  -- {zoneID=areaServerData,zoneID=areaServerData}
end
-- 获取上一次登录类型
function GameData:getLoginType()
   return self._loginType
end
function GameData:setLoginType(type)
   self._loginType = type;
end
function GameData:getRecorderOn()
	return self._isRecorderOn
end
function GameData:setRecorderOn(isOn)
	self._isRecorderOn = isOn
end
function GameData:setServerId(id)
	 self._loginServerId = id;
end
function GameData:getServerId()
	return checkint(self._loginServerId)
end
function GameData:markReportLoginStepTime()
    self._lastReportLoginStepTime = os.time()
end

function GameData:getReportLoginStepTime()
    return self._lastReportLoginStepTime 
end

function GameData:setIllusionNew(illusionID, isNew)
    self._illusionIDNewStringTable[tostring(illusionID)] = isNew
end

function GameData:setIllusionNewTable(t)
    self._illusionIDNewStringTable = t
end

function GameData:getIllusionNewTable()
    return self._illusionIDNewStringTable
end

function GameData:getIsNewTownType()
    return self._isNewTownType
end

function GameData:setIsNewTownType(type)
    self._isNewTownType = type
end

function GameData:getIsInitNewTownTypeFlag()
    return self._initNewTownTypeFlag
end

function GameData:setIsInitNewTownTypeFlag(flag)
    self._initNewTownTypeFlag = flag
end

function GameData:getAreaServerDataArr(accountID)
    print("GameData:getAreaServerDataArr", accountID)
    accountID = accountID or ""
    return self._areaServerDataArr[tostring(accountID)]
end

function GameData:setAreaServerDataArr(arr, accountID)
    accountID = accountID or ""
    self._areaServerDataArr[tostring(accountID)] = arr
end
function GameData:print()
    dump(self)
end
