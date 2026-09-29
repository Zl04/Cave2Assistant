-- LevelSelectUtil.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:关卡选择数据
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = class("LevelSelectUtil")
local SceneManager = require("app.game.SceneManager")
g_LevelSelectUtil = nil;


function LevelSelectUtil:getInstance()
	if g_LevelSelectUtil == nil then
		g_LevelSelectUtil = LevelSelectUtil.new()
	end
	return g_LevelSelectUtil;
end


function LevelSelectUtil:purgeInstance()
	if g_LevelSelectUtil ~= nil then
		g_LevelSelectUtil = nil;
	end
end

function LevelSelectUtil:ctor()
    self.mOpenLevel = ConcreteObserver:create(1);       						--开放关卡队列
    self.mDifficulty = ConcreteObserver:create(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1);       --当前难度:1普通难度,2噩梦难度,3地狱难度

    self.mPattern = PublicDefine.GAME_MODE.MODE_SOLO;                                  	--模式:0单人模式,1多人模式
    self.mOpenDifficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2;			--开放难度

    self.mCaveMode = PublicDefine.CAVE_MODE.MODE_NORMAL;
	self.mSelectLevel = 1;

    self.mUseSpecialEvent = false; --  英雄模式下是否使用事件组 true使用事件组
    self.mTeamType = TEAM_STATE.MATCHING;		--队伍状态:1:准备匹配,2:准备
    self.mConfirmID = 0;

    self.mOldOpenLevel = 11;		--上次解锁的等级
    self.mOldOpenDifficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1;		--上次解锁的难度
    self.mReadyOpenSelectLevel = false;		--是不是准备打开关卡选择

	self.mLayerType = Game.LevelSelectLayerType.Normal_Plot
	self.desertLayerType = Game.LevelSelectLayerType.Desert_Eye
end

--初始化时光之门的数据
function LevelSelectUtil:initTimeCaveData()
	print("LevelSelectUtil:initData")
	local lastSelect = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveMode..GameDataManager:getInstance():getMasterPK(), 0)
	if lastSelect ~= nil and lastSelect ~= 0 then
		if lastSelect == PublicDefine.CAVE_MODE.MODE_HERO then
            if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then
                self.mLastSelectTimeCaveMode = lastSelect
            end
		elseif lastSelect == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then
                self.mLastSelectTimeCaveMode = lastSelect
            end
		else
	        self.mLastSelectTimeCaveMode = lastSelect
	    end
	end
	self.mCaveMode = self.mLastSelectTimeCaveMode or PublicDefine.CAVE_MODE.MODE_NORMAL

	local masterHeroData = RoleDataManager:getMaster()
	self.mPattern = PublicDefine.GAME_MODE.MODE_SOLO; 
	self.mOpenDifficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1;

	for i = 1, 3 do
		local pUnlockCaveData = masterHeroData:getUnlockCaveData(PublicDefine.CAVE_MODE.MODE_NORMAL, i)
		if pUnlockCaveData:getIsUnlock() then
			if GameDataManager:getInstance():getOpenCheckpointData(PublicDefine.CAVE_MODE.MODE_NORMAL, i) then
				self.mOldOpenDifficulty = i
			end
			self.mOpenDifficulty = i;
		else
			break;
		end
	end

	self.mDifficulty:set(self.mOldOpenDifficulty)

	local checkpointData = RoleDataManager:getCheckpointData(PublicDefine.CAVE_MODE.MODE_NORMAL,self.mDifficulty:get())
	self.mOpenLevel:set(self:getBeginCaveLevelForShopLevel(checkpointData:getCheckpoint()))

	-- self.mOldOpenDifficulty = 1
	-- self.mOpenDifficulty = 2
	local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(PublicDefine.CAVE_MODE.MODE_NORMAL, self.mDifficulty:get())
	if openCheckpointData and openCheckpointData:getCheckpoint() then
		self.mOldOpenLevel = self:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint());
	else
		self.mOldOpenLevel = self.mOpenLevel:get();
	end

	-- print(self.mOpenLevel:get(),self.mOldOpenLevel)
	GameDataManager:getInstance():openCheckpoint(PublicDefine.CAVE_MODE.MODE_NORMAL, self.mDifficulty:get(), self:getBeginShopLevelForCaveLevel(self.mOpenLevel:get()))
	-- Avalon.UserDataManager:save()
end

--设置模式
function LevelSelectUtil:setPattern(pattern)
	print("LevelSelectUtil:setPattern",pattern)
	if pattern ~= self.mPattern then
		self.mPattern = pattern
	end
end


--设置开放等级 
--@param #int openLevel 开放等级
function LevelSelectUtil:setOpenLevel(openLevel)
    self.mOpenLevel:set(openLevel);
end


--设置开放难度
function LevelSelectUtil:setDifficulty(difficulty)
	if difficulty ~= self.mDifficulty:get() then
		self.mDifficulty:set(difficulty)
		-- self.mOldOpenLevel = 11
		-- self.mOpenLevel:set(31)
		-- return
		local checkpointData = RoleDataManager:getCheckpointData(self.mCaveMode,self.mDifficulty:get())

		local openLevel = self:getBeginCaveLevelForShopLevel(checkpointData:getCheckpoint())

		local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.mCaveMode, self.mDifficulty:get())
		if openCheckpointData and openCheckpointData:getCheckpoint() then
			self.mOldOpenLevel = self:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint());
		else
			self.mOldOpenLevel = openLevel
		end
		GameDataManager:getInstance():openCheckpoint(self.mCaveMode, self.mDifficulty:get(), self:getBeginShopLevelForCaveLevel(openLevel))

		self.mOpenLevel:set(openLevel)

	end
end

--设置开放难度
function LevelSelectUtil:setCaveMode(caveMode)
	if self.mCaveMode ~= caveMode then
		if caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL or caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
            self.mLastSelectTimeCaveMode = caveMode
            cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveMode..GameDataManager:getInstance():getMasterPK(), self.mLastSelectTimeCaveMode)
		elseif caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD or caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            self.mLastSelectTimeCaveMode = caveMode
            cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveMode..GameDataManager:getInstance():getMasterPK(), self.mLastSelectTimeCaveMode)
        end
		self.mCaveMode = caveMode
	end
end

local LevelDefine = {
	INAVLID = -1,
}

--楼层转换为商店层 1~10 -> 2001  11~20 -> 2002  21~30 -> 2003
function LevelSelectUtil:getBeginShopLevelForCaveLevel(level)
	-- print("LevelSelectUtil:getBeginShopLevelForCaveLevel  LevelDefine.CAVE_MAX = ", LevelDefine.CAVE_MAX, )
	if level >= PublicDefine.CONST_DEFINITION.CAVE_LEVEL_MIN and level <= PublicDefine.CONST_DEFINITION.CAVE_LEVEL_MAX then
		local levelIndex = math.ceil(level / SHOP_INTERVAL) - 1
		return levelIndex + PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN
	elseif level > 2000 then
		return level
	elseif level <= 10 then
		return 2001;
	elseif level >= PublicDefine.CONST_DEFINITION.BOSS_LEVEL_MIN then
		return level
	end

	return LevelDefine.INAVLID
end

--商店层转换为楼层 2001 -> 1  2002 -> 11  2003 -> 21
function LevelSelectUtil:getBeginCaveLevelForShopLevel(level)
	-- print("LevelSelectUtil:getBeginCaveLevelForShopLevel"..level)
	if level >= PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN and level <= PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MAX then
		local levelIndex = level - PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN
		return levelIndex * SHOP_INTERVAL + 1
	end
	return LevelDefine.INAVLID
end

function LevelSelectUtil:initTeamData(teamType)
	if teamType == TEAM_STATE.MATCHING then
		local _teamData = {}
		if TeamDataManager:hasTeam() then
			local i = 1
			for k,v in pairs(TeamDataManager:getTeamData()) do
				local tab = {}
				tab.name = v:getNickName()
				tab.state = false 			--是否准备
				tab.pk = v:getPK()
				tab.sex = v:getSex()
    			tab.faceDecodeID = v:getFaceDecodeID()
    			tab.headID = {}
    			tab.onlineState = v:getState() 	--是否在线
    			tab.captain = v:getCaptain() 	--是否队长
    			tab.schemeIDs = v.schemeIDs or {}
    			tab.guildID = v.guildID
				_teamData[v:getPosition()] = tab
               
				-- print("LevelSelectUtil:initTeamData",v:getFaceDecodeID())
			end
		else
		    local master = RoleDataManager:getMaster()

			local tab = {}
			tab.name = master:getNickName()
			tab.state = false
			tab.pk = master:getPK()
			tab.sex = master:getSex()
    		tab.faceDecodeID = master:getFaceDecodeID()
    		tab.headID = {}
    		tab.captain = false
    		-- local wearEquipmentDataArr = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
    		-- for k,v in pairs(wearEquipmentDataArr) do
    		-- 	table.insert(tab.headID,v:getGoodsID())
    		-- end
    		tab.onlineState = PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE
    		tab.schemeIDs = {}
    		if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_HERO and LevelSelectUtil:getInstance().mUseSpecialEvent then	
                local gateConfig = self:getLevelGateConfig()
			    local eventList, isUsed = MasterDataManager:getHeroCaveSpecialEnventBySceneId(gateConfig.ID)
			    if #eventList > 0 and not isUsed then
                    tab.schemeIDs = eventList
			    end
            end

			if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO and LevelSelectUtil:getInstance().mUseSpecialEvent then	
                local gateConfig = self:getLevelGateConfig()
			    local eventList, isUsed = MasterDataManager:getTitanHeroCaveSpecialEnventBySceneId(gateConfig.ID)
			    if #eventList > 0 and not isUsed then
                    tab.schemeIDs = eventList
			    end
            end

            local guildData = MasterDataManager:getGuildData()
    		if (guildData) then tab.guildID = guildData:getID() end
			table.insert(_teamData,tab)
			_teamData[1] = tab
		end

		TeamDataManager:setReadyTeamData(_teamData)
	end
	self.mTeamType = teamType
end

function LevelSelectUtil:getLevelGateConfig()
    local gateId = LevelSelectUtil:getInstance().mSelectLevel
    local list = ConfigManager:getAllLevelSelectDataByType(LevelSelectUtil:getInstance().mCaveMode)
	local gateConfig = nil
    for k, v in ipairs(list) do
		for k2, cfgLevel in ipairs(v.includeLevel) do
            if gateId == cfgLevel then
               gateConfig = v
               break
            end
        end
    end
    return gateConfig
end

--匹配的响应
function LevelSelectUtil:responseMatch(data)

	self.mConfirmID = data.confirmID
	local _teamData = {}
	for i = 1,#data.matchData do
		local tab = {}
		tab.name = ToolsUtil:replaceShowNickNameStr(data.matchData[i].nickName)
		tab.state = data.matchData[i].isConfirm
		tab.pk = data.matchData[i].pk
	    tab.headID = {}
	    for k,v in pairs(data.matchData[i].headID) do
	        table.insert(tab.headID,v)
	    end
	    tab.sex = data.matchData[i].sex
	    tab.faceDecodeID = data.matchData[i].faceDecodeID
        if data.matchData[i].faceDecodeID == nil or data.matchData[i].faceDecodeID == 0 then
	        tab.faceDecodeID = 3010101
	    else
	        tab.faceDecodeID = data.matchData[i].faceDecodeID
	    end
	    tab.onlineState = PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE
	    tab.schemeIDs = data.matchData[i].schemeIDs or {}
	    tab.guildID = data.matchData[i].guildID
		_teamData[i] = tab
	end

	TeamDataManager:setReadyTeamData(_teamData)

	TeamDataManager:setMatchTime(data.residualSureMS / 1000)
	-- UI.ScrollBar:createByText(data.residualSureMS.."")

	Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_RESPONSE_MATCH)

	if not SceneManager:getInstance():isInFightScene() then
		Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,2)
	end
end




--返回相应难度对应的文字与图标
function LevelSelectUtil:getDifficultyText(difficulty)
    local textDifficulty = ""
    local difficultyIconName1 = ""
    local difficultyIconName2 = ""
    if difficulty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1 then
        textDifficulty = UI.TEXT_110002
    elseif difficulty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2 then
        textDifficulty = UI.TEXT_110003
    elseif difficulty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then
        textDifficulty = UI.TEXT_110004
    end
    return textDifficulty,difficultyIconName1,difficultyIconName2
end


--初始化泰坦之路的数据
function LevelSelectUtil:initTitanRoadCaveData()
	local lastSelect = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveMode..GameDataManager:getInstance():getMasterPK(), 0)
	if lastSelect ~= nil and lastSelect ~= 0 then
		if lastSelect == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then
                self.mLastSelectTimeCaveMode = lastSelect
            end
		else
	        self.mLastSelectTimeCaveMode = lastSelect
	    end
	end
	self.mCaveMode = self.mLastSelectTimeCaveMode or PublicDefine.CAVE_MODE.MODE_TITAN_ROAD

	local masterHeroData = RoleDataManager:getMaster()
	self.mPattern = PublicDefine.GAME_MODE.MODE_SOLO; 
	self.mOpenDifficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1;

	for i = 1, 3 do
		local pUnlockCaveData = masterHeroData:getUnlockCaveData(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD, i)
		if pUnlockCaveData:getIsUnlock() then
			if GameDataManager:getInstance():getOpenCheckpointData(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD, i) then
				self.mOldOpenDifficulty = i
			end
			self.mOpenDifficulty = i;
		else
			break;
		end
	end

	self.mDifficulty:set(self.mOldOpenDifficulty)

	local checkpointData = RoleDataManager:getCheckpointData(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD,self.mDifficulty:get())
	self.mOpenLevel:set(self:getBeginCaveLevelForShopLevel(checkpointData:getCheckpoint()))

	-- self.mOldOpenDifficulty = 1
	-- self.mOpenDifficulty = 2
	local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD, self.mDifficulty:get())
	if openCheckpointData and openCheckpointData:getCheckpoint() then
		self.mOldOpenLevel = self:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint());
	else
		self.mOldOpenLevel = self.mOpenLevel:get();
	end

	-- print(self.mOpenLevel:get(),self.mOldOpenLevel)
	GameDataManager:getInstance():openCheckpoint(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD, self.mDifficulty:get(), self:getBeginShopLevelForCaveLevel(self.mOpenLevel:get()))
	-- Avalon.UserDataManager:save()
end

--设置时光之门副本选择类型
function LevelSelectUtil:setSwitchCaveLayerType(layerType)
	-- local lastType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveLayerType..GameDataManager:getInstance():getMasterPK(), 0)
	-- if RoleDataManager:getIsReincarntion() then
	-- 	if lastType == 0 and layerType ~= Game.LevelSelectLayerType.Normal_Plot then
	-- 		self.mLayerType = layerType
	-- 		cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveLayerType..GameDataManager:getInstance():getMasterPK(), self.mLayerType)
	-- 	end
	-- end
	self.mLayerType = layerType
	cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveLayerType..GameDataManager:getInstance():getMasterPK(), self.mLayerType)
end

function LevelSelectUtil:getSwitchCaveLayerType()
	return RoleDataManager:getIsReincarntion() and cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveLayerType..GameDataManager:getInstance():getMasterPK(), 0) or self.mLayerType
end

--设置沙之眼副本选择类型
function LevelSelectUtil:setSwitchDesertLayerType(layerType)
	self.desertLayerType = layerType
	cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LastSelectDesertCaveLayerType..GameDataManager:getInstance():getMasterPK(), layerType)
end

function LevelSelectUtil:getSwitchDesertLayerType()
	return RoleDataManager:getIsReincarntion() and cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectDesertCaveLayerType..GameDataManager:getInstance():getMasterPK(), self.desertLayerType) or self.desertLayerType
end


return LevelSelectUtil;


