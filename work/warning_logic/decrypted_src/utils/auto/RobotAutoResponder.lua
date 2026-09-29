--[[
    机器人固定消息回复模块 2017/12/16
    这里做一些默认的, 固定的消息回复, 例如: 
    	服务器连接成功后登陆,
    	登陆成功如果没有人物就用随机名字新建人物
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "utils.ObserverVariable"
require "utils.AvalonUtil"
require "utils.message.MessageCenter"
require "utils.net.NetHelper"
require "utils.net.NetMessage"
require "app.game.GameManager"
require "app.game.GameDefine"
require "app.game.MachineManager"
require "app.datas.PublicDefine"
require "app.datas.MasterDataManager"
require "app.utils.ShareUtil"
require "app.utils.ToolsUtil"
require "app.net.NetLoginSystem"
require "app.net.NetInnerSystem"
require "app.net.NetTeamSystem"
require "app.scene.mainscene.MainLayer"
require "app.ui.UIManager"
require "app.ui.createRoleLayer.CreateRoleLayer"

local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local GameLoginManager = require("app.game.GameLoginManager")
local MapDataManager = require("app.mapkit.model.MapDataManager")
local RobotConfig = require("utils.auto.RobotConfig")
local Helper = require("utils.auto.RobotHelper")

-- 引用UI命名空间
Auto = Auto or {}

-- 模块声明， 素子
local RobotAutoResponder = Auto.RobotAutoResponder or class("RobotAutoResponder")
Auto.RobotAutoResponder = RobotAutoResponder

-- 私有变量

---------------------------------------
-- eo 模块初始化 --









-- 程序逻辑 --
---------------------------------------
function RobotAutoResponder:init()
	-- 初始化内部变量
	self._reconnecting = false

	-- 初始化技能使用时间
	self._skillDue = 0

	-- 引用的登录页面, 包含一些默认逻辑
	self._mainLayer = UI.MainLayer:create()
	self._mainLayer:init()

	-- 新账号设置
	self._account = RobotConfig.ACCOUNT or 
		string.format("test_%d:%d", AvalonUtil.getCurrentTime(), math.random(100000,10000000))
	cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.identify, self._account)

	-- 设置人物外貌
	self._sex = RobotConfig.CHARACTER_SEX
	self._faceID = RobotConfig.CHARACTER_FACEID

	-- 基础模块的加载
	Game.Manager:initBaseModules()
	Game.Manager:initGameModules() -- 注册各个模块网络消息回调, 加载各个模块资源

	-- 接管登录回调
	self:setupLogin()
	-- 接管玩家创建回调
	self:setupCharacterCreation()
	-- 接管进入游戏回调
	self:setupEnterGame()
	-- 接管断线重连回调
	self:setupAutoReconnect()
	-- 接管一些网络回调
	self:setupNetResponds()
	
	-- Machine引擎对GameLoadManager有一些依赖
	SceneManager:getInstance():replaceLoadingScene()
end

function RobotAutoResponder:setupLogin()
	-- TODO: 可能可以去掉对Mainlayer的依赖, 但是现在没必要
    Game.Manager:initLoginModules()
    -- 接管连接完成回调
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NET_CONNECT_COMPLETE, self._mainLayer, self._mainLayer._listenerConnectComplete)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NET_CONNECT_COMPLETE, self, function(self)
        self._reconnecting = false
        -- 直接使用机器人配置的账号登录
        Net.NetLoginSystem:verify(self._account)
    end)
end

function RobotAutoResponder:setupAutoReconnect()
	-- 接管断线重连
    Avalon.MessageCenter:unbind(GameMessage.MC_NET_DISCONNECT, UI.UIManager, UI.UIManager.onNetDisconnectHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_NET_DISCONNECT, self, function(self) 
    	if (self._reconnecting) then return end
    	self._reconnecting = true

    	Helper:clearWaitLists()
    	GameManager:clearScene()
    	GameLoginManager:startLogin()
    	-- 每隔5秒尝试重连, 尝试999次
    	Helper:runAndWait(
    		self,
    		function() Helper:connectToServer() end,
    		function() return not self._reconnecting end,
    		function() end,
    		RobotConfig.RECON_TIMEOUT,
    		RobotConfig.RECON_TRY_NUM
    	)
    end)
end

function RobotAutoResponder:setupCharacterCreation()
	Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_NO_HERO, self._mainLayer, self._mainLayer._listenerLoginNoHero)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_NO_HERO, self, function(self)
    	Net.NetLoginSystem:createHero(self._account, self._account, self._sex, self._faceID)
    end)
end

function RobotAutoResponder:setupEnterGame()
	-- 接管进入游戏回调
	Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_ENTER_GAME, self._mainLayer, self._mainLayer._listenerEnterGame)
end

function RobotAutoResponder:setupNetResponds()
	-- 暂时为空
end

function RobotAutoResponder:setupAutoSkillsInBattle()
	Helper:waitAndRun(
		function() return Helper:isMasterInBattle() end,
		function() 
			local now = AvalonUtil:getCurrentTime()
			if (self._skillDue > now) then return end
			self._skillDue = now + RobotConfig.USE_SKILL_INTERVAL * 1000
			Helper:useARandomSkill()
		end,
		false
	)
end
---------------------------------------
-- eo 程序逻辑 --










-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --




return RobotAutoResponder