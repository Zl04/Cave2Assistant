--[[--
   dialog 层  提供弹出效果
]]
local UILayer = import(".UILayer")
local DialogLayer = class("DialogLayer",UILayer)



function DialogLayer:ctor()
	DialogLayer.super.ctor(self)
	local listener = cc.EventListenerTouchOneByOne:create() --弄一个屏蔽层
	listener:setSwallowTouches(true)
	listener:registerScriptHandler(function() return true end,cc.Handler.EVENT_TOUCH_BEGAN )
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
	self.listener = listener
	self.listener:setEnabled(false)
end

function DialogLayer:addView(view)
	DialogLayer.super.addView(self,view)
	
	local layer = cc.Layer:create()

	local anchor = layer:getAnchorPoint()
	
	if not view.cancelAction__ then --没有取消动画
		OpenWithAlert(view:getUI()) -- 用弹起的方式
	end

	if not self.listener:isEnabled() then
		self.listener:setEnabled(true)
	end
end

function DialogLayer:removeView(view)
	local function closeHandler()
		DialogLayer.super.removeView(self,view)
		if self:getSize() <= 0 then
			self.listener:setEnabled(false) --当dialog层没有其他的东西时候 取消屏蔽
		end
	end

	if view.safeClose__ or view.cancelAction__ then
		closeHandler()
	else
		CloseWithAction(view:getUI(),closeHandler)
	end
	
end

--重写
function DialogLayer:remove()
	for key,view in pairs(self._views) do
		printInfo("UILayer[%s] --------------------> remove[%s]",self.__cname,key)
		view.safeClose__ = 1 --安全关闭
		view:close()
		view.safeClose__ = nil
	end
	self._views = {} --重置
	self:removeFromParent()
end


--移除一个 可能需要重写 基于栈 后入先出
function DialogLayer:popView()
	DialogLayer.super.popView(self) 
end

return DialogLayer