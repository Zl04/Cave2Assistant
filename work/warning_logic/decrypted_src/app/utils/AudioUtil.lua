--音效辅助模块
-- by CMonk


local GameMapManager = require("app.game.GameMapManager")

AudioUtil = AudioUtil or {}

local trapEffectStatus = false
local trapEffectStatusThisStep = false


function AudioUtil:updateTrapEffectSound()
	if (not trapEffectStatus) then
		trapEffectStatus = true
		Avalon.AudioManager:playSound("1010")
	end
	trapEffectStatusThisStep = true
end

function AudioUtil:roleStepFinished()
	if (trapEffectStatusThisStep) then
		-- 如果一步完成之前激活了陷阱效果, 那么说明还在陷阱里面
		-- 重置一步中状态
		trapEffectStatusThisStep = false
	elseif (trapEffectStatus) then 
		-- 如果一步完成以后没有陷阱效果, 就说明走出了陷阱
		-- 设置陷阱状态并播放走出陷阱音效
		trapEffectStatus = false
		Avalon.AudioManager:playSound("1010")
	end	
end
Avalon.MessageCenter:bind(GameMessage.MC_ROLE_UPDATE_COORD, AudioUtil, AudioUtil.roleStepFinished)

function AudioUtil:playUseItemSound(goodsId)
	if (goodsId == 20060011 or goodsId == 20060010) then --04
		Avalon.AudioManager:playSound("549")
	elseif (goodsId == 20090011 or goodsId == 20090010) then --疾跑
		Avalon.AudioManager:playSound("550")
	elseif (goodsId == 20040011 or goodsId == 20040010) then --蘑菇
		Avalon.AudioManager:playSound("554")
	elseif (goodsId == 20100011 or goodsId == 20100031 or goodsId == 20100051 or goodsId == 20100021 or goodsId == 20100041 or goodsId == 20100061 or 
		    goodsId == 20100010 or goodsId == 20100030 or goodsId == 20100050 or goodsId == 20100020 or goodsId == 20100040 or goodsId == 20100060) then
		Avalon.AudioManager:playSound("551")
	else
		Avalon.AudioManager:playSound("552")
	end
end

function AudioUtil:playSceneMusic()
	-- local mapData = GameMapManager:getInstance():getMapData()
	-- local sceneStartMapLevel = 9001 --默认城镇地图
	-- local SceneManager = require("app.game.SceneManager")
	-- if (SceneManager:getInstance():isInFightScene()) then
	-- 	local GameDataManager = require("app.game.GameDataManager")
 --    	local sceneLevel = GameDataManager:getInstance():getSceneLevel()
 --    	sceneStartMapLevel = 2000 + sceneLevel
	-- else
	-- 	local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
 --    	sceneStartMapLevel = LevelSelectUtil:getBeginShopLevelForCaveLevel(mapData.level)
	-- end
 --    Avalon.AudioManager:playMusicByConfig(mapData.caveMode, sceneStartMapLevel, nil, true);
 	local _mapData = GameMapManager:getInstance():getMapData()
    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(_mapData.level)
    Avalon.AudioManager:playMusicByConfig(_mapData.caveMode, level, nil, true);
end

function AudioUtil:playDeathSound()
    Avalon.AudioManager:stopMusic()
    Avalon.AudioManager:playSound("1524")
    Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() self:playSceneMusic() end, 15)
end

function AudioUtil:playVictorySound()
	print("----playVictorySound 1")
    Avalon.AudioManager:stopMusic()
    Avalon.AudioManager:playSound("1523")
    Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
    	print("----playVictorySound 4")
    	self:playSceneMusic() 
    end, 13)
end

return AudioUtil