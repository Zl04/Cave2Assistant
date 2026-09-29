--[[--
视图LoginView
可以发送消息 dispose 处理资源释放,dispose只是UI暂时失去,视图本身不会释放,initUI 处理UI初始化
重写父类函数时，切记调用父类函数 如 LoginView.super.initUI(self)
]]
local GamePanel = require(mvc.PACKAGE_APP_CORE..".GamePanel")

local LoginView = class("LoginView",GamePanel)

function LoginView:onRegister()
   	self:init("LayerLogin",mvc.VIEW_TYPE.PANEL)
end

function LoginView:initUI()
	LoginView.super.initUI(self)
end



function LoginView:dispose()
	LoginView.super.dispose(self)
end

return LoginView