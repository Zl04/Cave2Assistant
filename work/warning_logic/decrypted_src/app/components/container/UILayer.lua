--[[--
   UI 层
]]

local UILayer = class("UILayer",cc.Layer)
-- 注册节点事件
local function registerNodeEvent(self)
    -- 注册node事件
	function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
            -- self:onEnter()
        -- elseif (nodeEvent == "enterTransitionFinish") then
        --     self:onEnter()
            -- self:dispatchEvent(UIEvent.EVENT_ONENTER, self)
        elseif (nodeEvent == "exit") then
            -- self:onExit()
            -- self:dispatchEvent(UIEvent.EVENT_ONEXIT, self)
        elseif (nodeEvent == "cleanup") then
            self:dtor()
		else 
		end
    end
    self:registerScriptHandler(onNodeEventHandler)
end

function UILayer:ctor()
	self._views = {} 
	
    registerNodeEvent(self)
end

function UILayer:dtor()
	self._views = {} 
    self:unregisterScriptHandler()
end

function UILayer:addView(view)
	local ui = view:getUI()
	if not ui then return end
	self._views[view.__cname] = view
	self:addChild(ui)
end

function UILayer:removeView(view)
	local ui = view:getUI()
	
	if not ui then return end
	self._views[view.__cname] = nil
	-- add by zp 这里解决以前老框架对于事件的处理报错处理
	-- ui:removeFromParent()
	ui:runAction(cc.RemoveSelf:create())
	view:onClose() --真正关闭
end
function UILayer:getViews()
	return self._views
end
-- 自身移除函数  需要触发每个view的 close
-- 保证视图逻辑正常运行
function UILayer:remove()
	for key,view in pairs(self._views) do
		printInfo("UILayer[%s] --------------------> remove[%s]",self.__cname,key)
		view:close()
	end
	self._views = {} --重置
	self:removeFromParent()
end

--移除一个
function UILayer:popView()
	for _,view in pairs(self._views) do
		view:close()
		break
	end
end

--获取大小
function UILayer:getSize()
	local count = 0
	for _,v in pairs(self._views) do
		count = count + 1
	end
	return count
end

return UILayer