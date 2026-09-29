--[[--
视图RegisterView
可以发送消息 dispose 处理资源释放,dispose只是UI暂时失去,视图本身不会释放,initUI 处理UI初始化
重写父类函数时，切记调用父类函数 如 RegisterView.super.initUI(self)
]]
local GamePanel = require(mvc.PACKAGE_APP_CORE..".GamePanel")

local RegisterView = class("RegisterView",GamePanel)

function RegisterView:onRegister()
   	self:init("LayerRegister",mvc.VIEW_TYPE.PANEL)
end

function RegisterView:initUI()
	RegisterView.super.initUI(self)
end



function RegisterView:dispose()
	RegisterView.super.dispose(self)
end

return RegisterView