--[[--
控制器LoginController，proxy,view已经注入,可以通过cc.LoginProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
]]
local GameController = require(mvc.PACKAGE_APP_CORE..".GameController")

local LoginController = class("LoginController",GameController)




--函数说明
--notification
function LoginController:noticeLoginViewShow(notification)

end



--函数说明
--notification
function LoginController:noticeLoginViewUpdateInfo(notification)

end



--函数说明
--notification
function LoginController:noticeLoginViewShowRegister(notification)

end



--函数说明
--notification
function LoginController:noticeLoginViewReqLogin(notification)

end



return LoginController