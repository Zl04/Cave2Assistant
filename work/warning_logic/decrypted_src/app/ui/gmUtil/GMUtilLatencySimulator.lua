--[[
    测试工具 帮助模块 2017/11/30
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "utils.AvalonUtil"


-- 引用UI命名空间
UI = UI or {}

-- 模块声明， 素子
local GMUtilLatencySimulator = UI.GMUtilLatencySimulator or class("GMUtilLatencySimulator")
UI.GMUtilLatencySimulator = GMUtilLatencySimulator
GMUtilLatencySimulator.isInited = false

-- 私有变量
local SEND_Q_FIXED_CONNID = 1
-- eo 模块初始化 --

-- 资源统合 --
---------------------------------------
---------------------------------------
-- eo 资源统合 --

-- 布局 --
---------------------------------------
---------------------------------------
-- eo 整体布局 --

--- 数据结构 --
---------------------------------------
---------------------------------------
-- eo 数据结构 --








-- 程序逻辑 --
---------------------------------------
-- Update循环中代理发送到期的发送包
local function update( ... )
	GMUtilLatencySimulator:delegateSending()
end

-- 初始化素子模块
function GMUtilLatencySimulator:init()
	if (self._isInited) then return end
	self._isInited = true

	self._sendQs = {}
	self._recvQs = {}
	self._recvDelayBase = 0
	self._recvDelayDelta = 0
	self._sendDelayBase = 0
	self._sendDelayDelta = 0
	self._isRecvDelayOn = false
	self._isSendDelayOn = false
	self._isSelfSending = false
	self._isShowSendContent = false
	self._isShowRecvContent = false

	-- 初始化RNG
	math.randomseed(os.time())
	-- 修复初始数字相同的问题
	math.random()
	math.random()
	math.random()
	math.random()

	-- 开始发包循环
	local scheduler = cc.Director:getInstance():getScheduler()
    updateHandler = scheduler:scheduleScriptFunc(update, 0.0, false)
end
GMUtilLatencySimulator:init()








--数值设定----------------------------------------
function GMUtilLatencySimulator:setRecvDelayBase(delay)
	assert(type(delay) == "number")
	self._recvDelayBase = delay
end

function GMUtilLatencySimulator:getRecvDelayBase()
	return self._recvDelayBase
end

function GMUtilLatencySimulator:setRecvDelayDelta(delta)
	assert(type(delta) == "number")
	self._recvDelayDelta = delta
end

function GMUtilLatencySimulator:getRecvDelayDelta()
	return self._recvDelayDelta
end

function GMUtilLatencySimulator:setSendDelayBase(delay)
	assert(type(delay) == "number")
	self._sendDelayBase = delay
end

function GMUtilLatencySimulator:getSendDelayBase()
	return self._sendDelayBase
end

function GMUtilLatencySimulator:setSendDelayDelta(delta)
	assert(type(delta) == "number")
	self._sendDelayDelta = delta
end

function GMUtilLatencySimulator:getSendDelayDelta()
	return self._sendDelayDelta
end










--开关-------------------------------------------
-- 收包开关
function GMUtilLatencySimulator:setRecvOn(isOn)
	assert(type(isOn) == "boolean")
	self._isRecvDelayOn = isOn
end

-- 返回收包开关值
function GMUtilLatencySimulator:isRecvOn()
	return self._isRecvDelayOn
end

-- 发包开关
function GMUtilLatencySimulator:setSendOn(isOn)
	assert(type(isOn) == "boolean")
	self._isSendDelayOn = isOn
end

-- 返回发包开关值
function GMUtilLatencySimulator:isSendOn()
	return self._isSendDelayOn
end

-- 显示收包内容开关
function GMUtilLatencySimulator:setShowRecvContent(isShow)
	self._isShowRecvContent = isShow
end

-- 返回显示收包内容开关
function GMUtilLatencySimulator:isShowRecvContent()
	return self._isShowRecvContent
end

-- 显示发包内容开关
function GMUtilLatencySimulator:setShowSendContent(isShow)
	self._isShowSendContent = isShow
end

-- 返回显示发包内容开关
function GMUtilLatencySimulator:isShowSendContent()
	return self._isShowSendContent
end








--列队管理-------------------------------------------------

-- 推入列队, 设置延迟
function GMUtilLatencySimulator:enqueuePack(list, dataPack, delay, debugPackLabel)
	assert(type(list) == "table")
	assert(type(delay) == "number")
	debugPackLabel = type(debugPackLabel) == "string" and debugPackLabel or "包"

	-- 把包和延迟一起丢进列队, 每个列队有自己的ID计数器
	list._packID = (list._packID or 0) + 1
	local packDue = {
		pack = dataPack, 
		due = AvalonUtil.getCurrentTime() + delay, 
		id = list._packID,
		delay = delay,
		debugPackLabel = debugPackLabel
	}
	table.insert(list, packDue)
end

-- 根据延迟时间, 提出列队
function GMUtilLatencySimulator:dequeueDuePacks(list, masterSwitch, isShowContent, maxNum)
	assert(type(list) == "table")
	if (masterSwitch == nil) then masterSwitch = true end
	assert(type(maxNum) == "number" or maxNum == nil)
	if (#list == 0) then return {} end

	local retCount = 0
	local retPacks = {}
	local headIdx = 1
	local now = AvalonUtil.getCurrentTime() -- 阻止在循环里的时间变化, 保证顺序
	while (#list > 0) do
		-- 作站使用, 从头取包
		local packDue = list[headIdx]
		-- 如果头包未到时间, 就直接返回不检查后面的包, 保持取包顺序
		if (packDue.due > now and masterSwitch) then break end
		-- 否侧把所有到时间的包取出, 直到达到指定最大数量后返回
		-- 	  打印数据
		print(packDue.debugPackLabel .. "ID:", packDue.id, "数据包延迟:", packDue.delay, "毫秒")
		if (isShowContent) then dump(packDue.pack) end
		--    操作列队
		table.insert(retPacks, packDue.pack)
		table.remove(list, headIdx)
		-- 更新返回计数器
		retCount = retCount + 1
		if (maxNum ~= nil and retCount >= maxNum) then break end
	end
	return retPacks
end

-- 在sendBegin和End之间不会拦截消息
-- 如果没有到时间的消息, sendBegin会返回false
function GMUtilLatencySimulator:sendBegin()
	if (not self._isSendDelayOn or self:isAllSendQsEmpty()) then return false end 
	-- self._isSelfSending = true 状态激活后不拦截发包.
	-- 只在LatencySimulator自己调用sendMessage发包的时候会设置此状态.
	-- 目的是为了不依赖于任何外部参数例如MessageType来判断是否存包.
	-- 缺点: 非多线程安全
	self._isSelfSending = true
	return true
end

function GMUtilLatencySimulator:sendEnd()
	self._isSelfSending = false
end

-- 发包延迟入库, 单个
function GMUtilLatencySimulator:sendEnQ( ... )
	pack = { ... }
	self:enqueuePack(self:getSendQ(SEND_Q_FIXED_CONNID), pack, self:calcSendDelay(), "发包")
end

-- 发包延迟出库, 所有到时间的包
function GMUtilLatencySimulator:sendDeQ()
	local packSum = {}
	for i,v in ipairs(self._sendQs) do
		local packList = self:dequeueDuePacks(v, self._isSendDelayOn, self._isShowSendContent)
		for i,v in ipairs(packList) do table.insert(packSum, v) end
	end
	return packSum
end

-- 收包延迟入库
function GMUtilLatencySimulator:recvEnQ(connid, packs)
	assert(type(connid) == "number")
	assert(type(packs) == "table")
	for i,v in ipairs(packs) do	
		self:enqueuePack(self:getRecvQ(connid), v, self:calcRecvDelay(), "收包")
	end
end

-- 收包延迟出库
function GMUtilLatencySimulator:recvDeQ(connid)
	assert(type(connid) == "number")
	return self:dequeueDuePacks(self:getRecvQ(connid), self._isRecvDelayOn, self._isShowRecvContent)
end

-- 根据connid返回或创建一个接收消息列队
function GMUtilLatencySimulator:getRecvQ(connid)
	assert(type(connid) == "number")
	if (not self._recvQs[connid]) then self._recvQs[connid] = {} end
	return self._recvQs[connid]
end

-- 根据connid返回或创建一个发送消息列队
function GMUtilLatencySimulator:getSendQ(connid)
	assert(type(connid) == "number")
	if (not self._sendQs[connid]) then self._sendQs[connid] = {} end
	return self._sendQs[connid]
end

-- 检查接收列队是否为空
function GMUtilLatencySimulator:isRecvQEmpty(connid)
	assert(type(connid) == "number")
	return #self:getRecvQ(connid) == 0 and true or false
end

-- 检查所有接收列队是否为空
function GMUtilLatencySimulator:isAllRecvQsEmpty()
	for i,v in ipairs(self._recvQs) do
		if (#v > 0) then return false end
	end
	return true
end

-- 检查发送列队是否为空
function GMUtilLatencySimulator:isSendQEmpty(connid)
	assert(type(connid) == "number")
	return #self:getSendQ(connid) == 0 and true or false
end

-- 检查所有发送列队是否为空
function GMUtilLatencySimulator:isAllSendQsEmpty()
	for i,v in ipairs(self._sendQs) do
		if (#v > 0) then return false end
	end
	return true
end

-- 计算一个收包延迟
function GMUtilLatencySimulator:calcRecvDelay()
	-- 根据延迟基础和延迟范围设置为每个包生成一个延迟
	local delay = 0
	if(self._recvDelayBase ~= 0 or self._recvDelayDelta ~= 0) then
		delay = self._recvDelayBase + math.random(0, self._recvDelayDelta)
	end
	return delay
end

-- 计算一个发包延迟
function GMUtilLatencySimulator:calcSendDelay()
	-- 根据延迟基础和延迟范围设置为每个包生成一个延迟
	local delay = 0
	if(self._sendDelayBase ~= 0 or self._sendDelayDelta ~= 0) then
		delay = self._sendDelayBase + math.random(0, self._sendDelayDelta)
	end
	return delay
end











--外部接口 包拦截/发送-----------------------------------
-- 收包拦截
function GMUtilLatencySimulator:recvInterceptAndReturnDue(connid, originalPacks, systemPacks)
	-- 接收包移花接木, 把新接收到的包推进列队, 取出已经到延迟时间的包
	local retPacks = originalPacks
	local retSysPacks = systemPacks
    if (self:isRecvOn()) then
        -- 如果开关开启, 移花接木
        self:recvEnQ(connid, systemPacks)
        self:recvEnQ(connid, originalPacks)
        retPacks = self:recvDeQ(connid)
        retSysPacks = {}
    elseif (not self:isRecvQEmpty(connid)) then
        -- 如果开关关闭并有残留包, 放到新的列队的最前端, 此时包会跳过延迟直接取出
        local leftOverPacks = self:recvDeQ(connid)
        for i,v in ipairs(leftOverPacks) do table.insert(retPacks, i, v) end
        systemPacks = {}
    end
    return retPacks, retSysPacks
end

-- 发包拦截
function GMUtilLatencySimulator:sendIntercept(sender, sendFunc, ... )
	-- 条件1: 在开关开启, 并且不是自己发送的时候拦截
	-- 条件2: 在开关关闭, 但是还有残留包的时候, 继续拦截, 等待下一次delegateSending把列队清空
    if ((self._isSendDelayOn and not self._isSelfSending) or 
    	(not self._isSendDelayOn and not self:isAllSendQsEmpty())) then
        self:sendEnQ(sender, sendFunc, ... )
        return true
    end
    return false
end

-- 代替发包
function GMUtilLatencySimulator:delegateSending()
    -- 检查如果有要发送的包, 使用sendMessage发送. sendCheckBegin/End 中会取消拦截
    if (GMUtilLatencySimulator:sendBegin()) then
        local packs = GMUtilLatencySimulator:sendDeQ()
        for i,v in ipairs(packs) do
        	local sender = table.remove(v, 1)
        	local sendFunc =  table.remove(v, 1)
        	sendFunc(sender, unpack(v))
        end
        GMUtilLatencySimulator:sendEnd()
    end
end
---------------------------------------
-- eo 程序逻辑 --

return GMUtilLatencySimulator