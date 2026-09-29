--[[
    游戏性能信息
]]

UI = UI or {}
require("app.utils.ServerConfigUtil")
local PerformanceInfoArea = class("PerformanceInfoArea", UI.HWBtnComponent)
UI.PerformanceInfoArea = PerformanceInfoArea

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 200
local COM_HEIGHT = 30
-- 背包资源
local COM_RES_LIST = nil

local PING_COLORS = {
    UI.FONT_COLOR_192_60_47,
    UI.FONT_COLOR_210_185_110,
    UI.FONT_COLOR_100_200_87,

}

-- cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.lastReportDelyDay,"0")
local lastReportDelyDay = checkint(cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.lastReportDelyDay,"0"))
local reportInterval = 3600;


local function reportNetDelay(isFirstTime,delayTime)
    local SdkBox = require("utils.sdkbox.SdkBox")
    local sdkbox = SdkBox:getInstance()
    local gameLoginManager = require("app.game.GameLoginManager")

    local heroData = RoleDataManager:getMaster()
    local tableData = {}
    
    tableData.openuuid = AvalonUtil.getOpenUUID()
    if RoleDataManager:getMasterPK() > 0 then
        tableData.pk = RoleDataManager:getMasterPK()
    end
    tableData.delayTime = delayTime
    tableData.zone = checkint(checkint(ServerConfigUtil:getZoneId()))
    tableData.accountStr =tostring(ServerConfigUtil:getAccountId() or "")
    -- 每隔30分钟上报的地址
    local url = Net.HttpSubDirection.FirstReportNetDelay
    
    -- 初次上报的地址
    -- url = Net.HttpSubDirection.FirstReportNetDelay

    tableData.platform = checkint(sdkbox:getVersionPlatform())
    tableData.channel = checkint(sdkbox:getVersionChannel())
    tableData.account =  sdkbox:getVersionAccount()
    
    tableData.clientVersion = Avalon.HotfixManager:getLocalVersion()
    tableData.clientBuild = Avalon.HotfixManager:getLocalBuild()
    if heroData and heroData.getNickName then
        tableData.nickname = heroData:getNickName()
    else
        tableData.nickname = ""
    end
    
    tableData.phoneInfo = AvalonUtil.getDeviceName()
    tableData.phoneVersion = AvalonUtil.getSystemVersion()
    tableData.phoneLocation = AvalonUtil.getLocation()
    tableData.idfa = AvalonUtil.getIDFA()
    tableData.imei = AvalonUtil.getIMEI()
    tableData.adid = AvalonUtil.getADID()
    tableData.idfv = AvalonUtil.getIDFV()
    tableData.mac = AvalonUtil.getMAC()
    tableData.oaid = AvalonUtil.getOAID()
    tableData.netmode = AvalonUtil.getNetworkMode()

    sdkbox:uploadNetDelayInfo(tableData)
    
    Avalon.AWSLogUtil:sendAWSDelayInfo(delayTime, PublicDefine.WebLogS3DelayType.WebLogS3DelayType_Game)
    -- add by zp CO-13166 停用贪2旧延迟收集系统
    -- Net.Helper:sendHttpMessageByUrl(ServerConfigUtil:getDelayCollectionUrl()..url,tableData,function(response)
        
    -- end,function(readyState,status)
        
    -- end)

end
-- 显示ping值
local function onGetPingValueHandler(self, value)
    if (math.min( checkint(value),9999 ) == 0) then
        --修复兼容:   CO-17607 【延迟】客户端不显示游戏延迟参数了   (最终解决是修改C++, 这里只是对新包热更做兼容处理)
        local fStr = 0
        for i = 1, string.len(value) do
            local str = string.sub(value, 1, i)
            str = checkint(str)
            if str ~= 0 then
                fStr = str
            else
                break
            end
        end
        value = math.min(fStr,9999 )
    else
        value = math.min( checkint(value),9999 )
    end

    local nowTime = os.time()
    if nowTime - lastReportDelyDay >= reportInterval then
        reportNetDelay(lastReportDelyDay <= 0 ,value)
        lastReportDelyDay = nowTime;
        cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.lastReportDelyDay,tostring(nowTime))
    end

    
    

    if tolua.isnull(self) or not self.switchNetMode then
        return
    end
    
    
    self:switchNetMode()
    
    local level = 1;
    if value < 0 or value >= 200 then
        level = 1;
    elseif value <= 99 then
        level = 3;
    elseif value <= 199 then
        level = 2;
    end
    -- print("leve",leve)
    for i,v in ipairs(self.curImgs) do
        v:setImageColor(PING_COLORS[level])
        v:setVisible(i<=level)
    end
    local pingValue = string.format("%sms", value)
    if(not tolua.isnull(self._pingText)) then
        self._pingText:setFontColor(PING_COLORS[level])
        self._pingText:setText(pingValue)
    end
end

-- 显示发送间隔
local function onGetSendIntervalHandler(self, interval)
    if(not tolua.isnull(self._sendIntervalText)) then
        local interval = string.format("SI:%s(ms)", interval)
        self._sendIntervalText:setText(interval)
    end
end

-- 构造函数
function PerformanceInfoArea:ctor()
    self.curImgs = {}
    self.lastNetMode = 999

    PerformanceInfoArea.super.ctor(self, UIType.PERFORMANCE_INFO_AREA, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    Avalon.MessageCenter:bind(GameMessage.MC_PING_VALUE, self, onGetPingValueHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_SEND_INTERVAL, self, onGetSendIntervalHandler)
end

-- 析构函数
function PerformanceInfoArea:dtor()
    PerformanceInfoArea.super.dtor(self)

    Avalon.MessageCenter:unbind(GameMessage.MC_PING_VALUE, self, onGetPingValueHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_SEND_INTERVAL, self, onGetSendIntervalHandler)
end

-- 初始化视图
function PerformanceInfoArea:onInitView()
    -- 显示ping值(在三测的时候修改为 ping直接显示,而不是测试模式才显示 2018年06月20日14:00:33 yys)
    local pingText = UI.Text:create()
    pingText:init("0ms")
    pingText:leftBottom(0,4)
    pingText:setFontSize(UI.FONT_SIZE_12PX)
    pingText:setFontColor(UI.FONT_COLOR_GREEN)
    pingText:setTextCenter()
    self:addChild(pingText)
    self._pingText = pingText

    self.wifiImgs = {}
    local wifiBgNode = cc.Node:create();
    self:addChild(wifiBgNode)
    self.wifiBgNode = wifiBgNode
    
    for i=1,3 do
        local img_bg = UI.Image:create();
        img_bg:init(string.format("ui_signal_banner_wifi0%d.png",i))
        img_bg:leftBottom(-22,5)
        img_bg:setImageColor(UI.FONT_COLOR_GRAY)
        wifiBgNode:addChild(img_bg)

        local img = UI.Image:create();
        img:init(string.format("ui_signal_banner_wifi0%d.png",i))
        img:leftBottom(-22,5)
        img:setImageColor(UI.FONT_COLOR_100_200_87)
        wifiBgNode:addChild(img)

        table.insert(self.wifiImgs,img)
    end

    self.wwanImgs = {}
    local wwanBgNode = cc.Node:create();
    self:addChild(wwanBgNode)
    self.wwanBgNode = wwanBgNode

    for i=1,3 do
        local img_bg = UI.Image:create();
        img_bg:init(string.format("ui_signal_banner_move0%d.png",i))
        img_bg:leftBottom(-22,5)
        img_bg:setImageColor(UI.FONT_COLOR_GRAY)
        wwanBgNode:addChild(img_bg)

        local img = UI.Image:create();
        img:init(string.format("ui_signal_banner_move0%d.png",i))
        img:leftBottom(-22,5)
        img:setImageColor(UI.FONT_COLOR_100_200_87)
        wwanBgNode:addChild(img)

        table.insert(self.wwanImgs,img)
    end
    -- 这里只有测试版本显示该值
    if DEVELOPMENT_MODE then
        require "app.ui.gmUtil.GMUtilExecutor"
        if (UI.GMUtilExecutor:getShowTestUI()) then
            

            -- 显示发送间隔
            local sendIntervalText = UI.Text:create()
            sendIntervalText:init("SI:0(ms)")
            sendIntervalText:leftBottom(50,4)
            sendIntervalText:setTextCenter()
            sendIntervalText:setFontSize(UI.FONT_SIZE_12PX)
            self:addChild(sendIntervalText)
            self._sendIntervalText = sendIntervalText
        end 
    end
end

function PerformanceInfoArea:switchNetMode()
    local mode = AvalonUtil.getNetworkMode()
    if self.lastNetMode == mode then
        return
    end
    self.lastNetMode = mode
    -- print("networkMode",networkMode)
    if networkMode == PublicDefine.NetworkMode.WWAN then
        self.wifiBgNode:setVisible(false)
        self.wwanBgNode:setVisible(true)
        self.curImgs = self.wwanImgs
    else
        self.wifiBgNode:setVisible(true)
        self.wwanBgNode:setVisible(false)
        self.curImgs = self.wifiImgs
    end
end
 