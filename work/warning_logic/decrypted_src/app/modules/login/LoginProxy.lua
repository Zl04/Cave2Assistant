--[[--
视图LoginProxy
可以发送消息,与网络接口进行交互
缓存处理，支持http,socket
onRegister，可以向网络接口注册数据推送回调
]]

local GameProxy = require(mvc.PACKAGE_APP_CORE..".GameProxy")

local LoginProxy = class("LoginProxy",GameProxy)

--注册服务器推送
function LoginProxy:onRegister()
   --cc.netApi:registerCallback(self:getName(),method)
end

return LoginProxy