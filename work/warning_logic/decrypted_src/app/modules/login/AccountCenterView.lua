--[[--
视图AccountCenterView
可以发送消息 dispose 处理资源释放,dispose只是UI暂时失去,视图本身不会释放,initUI 处理UI初始化
重写父类函数时，切记调用父类函数 如 AccountCenterView.super.initUI(self)
]]
local GamePanel = require(mvc.PACKAGE_APP_CORE..".GamePanel")

local AccountCenterView = class("AccountCenterView",GamePanel)

function AccountCenterView:onRegister()
   	self:init("LayerAccountCenter",mvc.VIEW_TYPE.PANEL)
end

function AccountCenterView:initUI()
	AccountCenterView.super.initUI(self)
end



function AccountCenterView:dispose()
	AccountCenterView.super.dispose(self)
end

return AccountCenterView