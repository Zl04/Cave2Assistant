--[[--
数据模型LoginModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
]]
local GameModel = require(mvc.PACKAGE_APP_CORE..".GameModel")

local LoginModel = class("LoginModel",GameModel)

function LoginModel:onRegister()

end




return LoginModel