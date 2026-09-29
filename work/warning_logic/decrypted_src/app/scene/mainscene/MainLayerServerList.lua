--[[
	服务器选择列表
]]

-- 模块初始化 --
---------------------------------------
-- 引用
local LanguageManager = require("app.game.LanguageManager")
require("app.utils.ServerConfigUtil")
require("app.ui.common.ButtonS9")

-- 引用UI命名空间
UI = UI or {}

-- 模块初始化
local MainLayerServerList = class("MainLayerServerList", UI.HWBtnComponent)
UI.MainLayerServerList = MainLayerServerList

-- 服务器名字映射
local GATE_HOST_INDEX = {
    {gateHost = "dengbei.avalongames.com", name = "DB哥"},
    {gateHost = "zhaoqiangsheng.avalongames.com", name = "赵强生"},
    {gateHost ="192.168.200.106", name = "王仕宇"},
    {gateHost ="10.172.188.195", name = "胡威"},
    {gateHost ="server1.avalongames.com", name = "秦攀"},
    {gateHost ="10.172.188.155", name = "杨俊"},
    {gateHost ="192.168.200.106", name = "王仕宇"},
    {gateHost ="192.168.200.106", name = "王仕宇"},
    {gateHost ="192.168.200.106", name = "王仕宇"},
    {gateHost ="192.168.200.106", name = "王仕宇"},
    {gateHost ="192.168.200.106", name = "王仕宇"},
}

-- 私有变量:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = true
local DEBUG_DRAW = true
local MAX_PING_VALUE = 9999
local LIST_BOTTOM = 30
local LIST_LEFT = 0
local LIST_HEIGHT = 210
local LIST_WIDTH = 200
local LIST_BG_WIDTH = 200
local LIST_BG_HEIGHT = 220
---------------------------------------
-- eo 模块初始化 --










-- 资源统合 --
---------------------------------------
local COM_RES_LIST = { }

---------------------------------------
-- eo 资源统合 --















function MainLayerServerList:ctor()
    MainLayerServerList.super.ctor(self, 0, COM_RES_LIST, winSize.width, winSize.height)
    self.serverListBg = nil
    self.detailedScrollView = nil
    self.serverButton = nil
    self.serverArrow = nil
    
end

--析构函数
function MainLayerServerList:dtor()
    MainLayerServerList.super.dtor(self)
    avalon.PingUtil:getInstance():stopLoop()
    avalon.PingUtil:getInstance():unregisterCallback()
end

-- 初始化
function MainLayerServerList:init(serverList, onManualSelect)
    MainLayerServerList.super.init(self)
    if (serverList) then
    	self:initServerSelector(serverList, onManualSelect)
    end
end

function MainLayerServerList:initServerSelector(serverList, onManualSelect)
	printInfo("MainLayerServerList:initServerSelector 初始化服务器列表选择器", serverList)
    if table.nums(serverList) > 1 then
        -- 服务器列表
        local serverListHost = UI.Layout:create()
        serverListHost:init()
        serverListHost:leftBottom(0, LIST_BOTTOM)
        self:addChild(serverListHost)
        self.serverListHost = serverListHost

        -- local serverListBg = UI.Image:create()
        -- serverListBg:init("ui_login_banner_server_2.png")
        -- serverListBg:leftBottom(100, 100)
        -- serverListBg:setScale(6.8, 8.2)
        -- serverListHost:addComponent(serverListBg)
        local serverListBg = cc.LayerColor:create(cc.c4b(255,255,255,20))
        serverListBg:setContentSize(LIST_BG_WIDTH, LIST_BG_HEIGHT)
        serverListHost:addChild(serverListBg)
        self.serverListBg = serverListBg

        -- 创建中心区域
        local upLayout = UI.Layout:create()
        upLayout:init()
        upLayout:centerUp(0)

        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:setSize(LIST_WIDTH, LIST_HEIGHT)
        detailedScrollView:init(0, 0, 0, 0)
        detailedScrollView:leftBottom(10, 10)
        detailedScrollView:addInnerNode(upLayout)
        serverListHost:addChild(detailedScrollView)
        self.detailedScrollView = detailedScrollView

        -- 服务器按钮
        local serverButton = UI.ButtonS9:create(230, 30)
        serverButton:init("", "ui_login_banner_server_1.png", "ui_login_banner_server_1.png")
        serverButton:leftBottom(0, 0)
        serverButton:setOnClicked(function()
            self:showServerList(not self.serverListHost:isVisible())
        end)
        self:addChild(serverButton)
        self.serverButton = serverButton


        -- 按钮上面的箭头
        local serverArrow = UI.Image:create();
        serverArrow:init("ui_login_button_triangle.png")
        serverArrow:centerRight(0)
        serverButton:addChild(serverArrow,1)
        self.serverArrow = serverArrow
        

        local curServerColor = nil;

        local curServer = UI.Text:create();
        curServer:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX)
        curServer:centerLeft(10)
        serverButton:addChild(curServer,2)

        local function localSetCurrentServerLabel(zoneId, manualSelect)
        	-- 如果和之前选择的一样, 只隐藏列表, 什么事情都不做
        	if (self.curServerId == zoneId and (manualSelect or manualSelect == nil)) then
        		self:showServerList(false)
        		return
            end

            function changeVisual()
                -- 更新现在选择的服务器Id
                self.curServerId = zoneId

                -- 设置服务器配置
                ServerConfigUtil:setCurrentCfgById(zoneId)

                -- 修改UI显示
                curServer:setText(ServerConfigUtil:getName())
                local curConfig = ServerConfigUtil:getCurrentCfg()
                if (curConfig) then
                    curServer:setFontColor(self:getColorByServerPing(curConfig.ping or 9999))
                end
            end
            
            
            -- 处理手动更换服务器后弹窗确认
            if (manualSelect == true or manualSelect == nil) then
                self:showServerList(false)
                UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_111153, function()
                    changeVisual()
                    if (onManualSelect) then onManualSelect(cfg) end
                end)
            else
                changeVisual()
            end
        end

        local urls = {}
        local serverNames = {}
        local serverPings = {}
        for i, cfg in ipairs( ServerConfigUtil:getServerList() ) do
            local host,port = self:getHostAndPort(cfg.loginUrl)
            table.insert(urls, host)

            -- 初始化PING值
            cfg.ping = MAX_PING_VALUE

            -- 一行的运载行
            local entry = UI.Layout:create()
            entry:init()
            entry:setSize(200, 30)
            entry:leftBottom(5,(i - 1) * 30)
            entry:setAnchorPoint(0.5, 0.5)
            entry:setTouchEnable(true)
            entry:setSwallowTouches(false);
            entry:setEnableMinTouchSize(false)
            upLayout:addComponent(entry)
            entry:addEventListener(UI.Event.COMPONENT_CLICK, self,function ()
                -- entry:scaleTo(1,0)
                if (self.disableClick == true) then return end
                localSetCurrentServerLabel(cfg.id)                
            end )
            entry:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self,function ()
                -- entry:scaleTo(1.1,0)
            end )
            entry:addEventListener(UI.Event.COMPONENT_DRAG_ENDED, self,function ()
                -- entry:scaleTo(1,0)
            end )

            -- 一行的左边, 服务器名字
            local serverNameString = tostring(self:getShowServerName(cfg)) or UI.TEXT_111138
            local serverName = UI.Text:create()
            serverName:init(serverNameString, UI.SYS_FONT, UI.FONT_SIZE_16PX)
            serverName:leftBottom(0, 0)
            if (cfg.isMaintenance) then serverName:setFontColor(UI.FONT_COLOR_GRAY) end
            entry:addComponent(serverName)
            table.insert(serverNames,serverName)

            -- 一行的右边, PING
            local serverPing = UI.Text:create()
            serverPing:init("")
            serverPing:leftBottom(105,0)
            entry:addComponent(serverPing)
            table.insert(serverPings,serverPing)
        end
        upLayout:setSize(146, table.nums(serverList) * 30);
        detailedScrollView:scrollToBottom()


        -- 服务器名字和延迟显示
        local minPingServer = nil;
        local minPing = 100000;
        local minPingColor = nil
        
        local pingUtil = avalon.PingUtil:getInstance()
        pingUtil:stopLoop()
        pingUtil:registerCallback(function (prams)
            if table.nums(prams) < table.nums(serverList) then return end

            for i, cfg in ipairs( serverList ) do
                -- 获取ping
                local ping = checkint(prams[i])
                if (cfg.isMaintenance) then ping = nil end

                -- 根据ping 获取颜色
                local color = self:getColorByServerPing(ping)
                
                -- 在配置缓存中存储ping值, -1 代表各种异常或者ping不通
                if ping and ping == -1 then ping = MAX_PING_VALUE end
                cfg.ping = ping
                
                -- 找到延迟最低的
                if ping and ping < minPing then
                    minPing = ping
                    minPingServer = serverList[i]
                    minPingColor = color
                end

                -- 设置标签颜色
                local serverNameString = tostring(self:getShowServerName(serverList[i])) or UI.TEXT_111138
                serverNames[i]:setText(serverNameString)
                serverPings[i]:setText(ping and ping .. "ms" or "")
                serverNames[i]:setFontColor(color)
                serverPings[i]:setFontColor(color)
                if (not ServerConfigUtil:isCurrentCfgEmpty() and ServerConfigUtil:getZoneId() == cfg.id) then
                    curServer:setFontColor(color)
                end
            end
        end)
        pingUtil:setHosts(urls)
        pingUtil:startLoop()
        
        if (ServerConfigUtil:isCurrentCfgEmpty()) then
            localSetCurrentServerLabel(ServerConfigUtil:getSavedCurrentCfgId(), false)
        else
            localSetCurrentServerLabel(ServerConfigUtil:getZoneId(), false)
        end
        self:showServerList(false, false)

        printInfo("MainLayerServerList:initServerSelector, 现在选中服务器配置 curServerCfg:", ServerConfigUtil:getCurrentCfg())
    elseif table.nums(serverList) == 1 then
        ServerConfigUtil:setCurrentCfgByIdx(1)
    else
        printWarn("MainLayerServerList:initServerSelector, " .. string.format("当前target[%s]没有配置web服务器", CAVEOL_TARGET))
    end

    printInfo("MainLayerServerList:initServerSelector, web游戏登录验证服务器地址:", ServerConfigUtil:getLoginUrl())
end

function MainLayerServerList:getShowServerName(cfg)
    local showServerName = cfg.name
    if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        for k, v in ipairs(GATE_HOST_INDEX) do 
            if(v.gateHost == cfg.gateHost) then 
                showServerName = v.name .. showServerName
                break
            end
        end
    end

    return showServerName
end

function MainLayerServerList:getHostAndPort(address)
    address = string.gsub(address,"https://","")
    address = string.gsub(address,"http://","")
    local params = string.split(address,":")
    local host,port = params[1],params[2]
    return host,port
end
function MainLayerServerList:showServerList(isShow, isAnimated)
    if (not self.serverListHost) then return end
    if (isAnimated == nil) then isAnimated = true end

    local function setListVisible(isVisible)
        self.serverListHost:setVisible(isVisible)
        self.disableClick = not isVisible
    end
    self.serverListHost:stopAllActions()
    if (isShow) then
        if (isAnimated) then 
            self.serverListHost:runAction(cc.EaseSineOut:create(cc.ScaleTo:create(0.2, 1, 1)))
        end
        setListVisible(true)
    else
        if (isAnimated) then
            self.serverListHost:runAction(cc.Sequence:create(
                cc.ScaleTo:create(0.05, 1, 0),
                cc.CallFunc:create(function() setListVisible(false) end)))
        else
            setListVisible(false)
        end
    end

    if (not self.serverArrow) then return end
    self.serverArrow:setImageScaleY(ifelse(isShow,-1 , 1))
end

function MainLayerServerList:getColorByServerPing(ping)
    local color = UI.FONT_COLOR_255_24_0
    if ping then 
        if ping >= 200 then
            color = UI.FONT_COLOR_255_24_0
        elseif ping >= 100 then
            color = UI.FONT_COLOR_252_185_0
        elseif ping >= 0 then
            color = UI.FONT_COLOR_18_191_42
        else
            color = UI.FONT_COLOR_255_24_0
        end
    else
        color = UI.FONT_COLOR_GRAY 
    end

    return color
end


return MainLayerServerList