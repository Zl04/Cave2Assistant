-- AnswerDataManager.lua
--[[
    答题管理器
]]
------------------------------------------------------
require "app.config.ConfigManager"
local LanguageManager = require("app.game.LanguageManager")
local languageManagerIns = LanguageManager:getInstance()
local SceneManager = require("app.game.SceneManager")
local config = require "Resource.profiles.commonProfile.ProfileVac"
AnswerDataManager = AnswerDataManager or {}

-- 初始化
function AnswerDataManager:init()
    self.curQuest =nil
end


-- 网络初始化
function AnswerDataManager:initNetData(initData)
    self.curQuest = initData
end


function AnswerDataManager:answerResponse(data)
    if data.result == 2 then
        local failureStr = languageManagerIns:getLocalString(1111703) 
        if AnswerDataManager:isNextWrongToBlackRoom() then
            failureStr = languageManagerIns:getLocalString(1111704)
        end
        UI.ScrollBar:createByText(failureStr)
    elseif data.result == 1 then
        local str = nil
    	if self:hasAward() then
        	local succStr = languageManagerIns:getLocalString(1111702)
        	str = string.format(succStr, config[self.curQuest.qusetion.question].goodsRewardsNum)
        else
        	str = languageManagerIns:getLocalString(1111840)
    	end
        UI.ScrollBar:createByText(str)
    elseif data.result == 3 then
    	local failureStr = languageManagerIns:getLocalString(1111703) 
        if AnswerDataManager:isNextWrongToBlackRoom() then
            failureStr = languageManagerIns:getLocalString(1111704)
        end
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111720)..failureStr)
    end

    self.curQuest.nextEnterCaveSec = data.nextEnterCaveSec

	if self.curQuest then
		self.curQuest.answerRemainMsec = 0
	end
end

function AnswerDataManager:getData()
	return self.curQuest
end


function AnswerDataManager:canShowPanel()
	do
		return false
	end
	if (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) then
		return false
	end
	if SceneManager:getInstance():isNotInFightScene() then
		return false
	end
	if not self.curQuest then
		return false
	end
	if self.curQuest.qusetion.question == 0 then
		return false
	end

	if  self.curQuest.answerRemainMsec - GameManager:getNormalServerTime() > 0 then
		print("self.curQuest.answerRemainMsec", self.curQuest.answerRemainMsec, "GameManager:getNormalServerTime()", GameManager:getNormalServerTime())
		return true
	end
	return false
end

function AnswerDataManager:getNextEnterCaveSecRemind()
	return self.curQuest.nextEnterCaveSec - GameManager:getNormalServerTime()
end

function AnswerDataManager:canEnterCave()
	do
		return true
	end
	if (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) then
		return true
	end
	if not self.curQuest then
		return true
	end
	local switch = tonumber(ConfigManager:getGeneralForKey("vacSwitch"))
	if not switch or switch <= 0 then
		return true
	end
	return self:getNextEnterCaveSecRemind() <= 0
end

function AnswerDataManager:isNextWrongToBlackRoom()
	local vacIntervaltime = ConfigManager:getGeneralForKey("vacIntervaltime")
	local arr = string.split(vacIntervaltime, ";")
	return #arr - 1 <= self.curQuest.wrongCount
end


function AnswerDataManager:hasAward()
	local dailyRewardNum = self.curQuest.dailyRewardNum or 0
	local dailyMaxRewardNum = tonumber(ConfigManager:getGeneralForKey("antiAddictionrewardLimit"))
	return dailyRewardNum < dailyMaxRewardNum
end

--默认初始化
AnswerDataManager:init()