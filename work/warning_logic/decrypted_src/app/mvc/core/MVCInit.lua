-- UIModuleInit.lua
mvc = mvc or {}
function mvc.initFramework()
    mvc.PACKAGE_MVC_CORE = "app.mvc.core"
    mvc.PACKAGE_UTILS = "utils"

    mvc.PACKAGE_APP_CONFIG = "app.mvc.config"
    mvc.PACKAGE_APP_CORE = "app.mvc.core"

    mvc.PACKAGE_APP_PROTOS = "app.protos"


    mvc.PACKAGE_APP_MODULES = "app.modules"

    mvc.PACKAGE_APP_HANDLER = "app.handler"
    mvc.PACKAGE_APP_COMPONENTS = "app.components"

    mvc.modulePath = mvc.PACKAGE_APP_MODULES --设置模块路径

    mvc.events = require(mvc.PACKAGE_APP_CONFIG..".Events") --获取events

    mvc.VIEW_TYPE = require(mvc.PACKAGE_APP_CONFIG..".ViewTypes") -- 获取视图类型
    require(mvc.PACKAGE_UTILS..".var")
    local tab = require(mvc.PACKAGE_MVC_CORE..".MVCBase")
    mvc.Facade = tab.Facade
    mvc.Controller = tab.Controller
    mvc.View = tab.View
    mvc.Model = tab.Model

    mvc.facade = mvc.Facade:getInstance() -- 获取facade实例
    mvc.GameModel = require(mvc.PACKAGE_APP_CORE..".GameModel")
    mvc.GamePanel = require(mvc.PACKAGE_APP_CORE..".GamePanel")
    mvc.GameController = require(mvc.PACKAGE_APP_CORE..".GameController")
    
    mvc.panelMonitor = require(mvc.PACKAGE_APP_CORE..".PanelMonitor"):getInstance() -- 获取视图管理监控实例
    local module_configs = require(mvc.PACKAGE_APP_CORE..".MVCConfig") --获取模块配置文件
    mvc.facade:loadConfigs(module_configs) --载入模块配置文件
    mvc.facade:registerModules(table.unique(table.keys(module_configs))) --facade注册模块
    
    mvc.send = function (...) return mvc.facade:send(...) end
    mvc.openPanel = function(...) return mvc.facade:send(mvc.events.Open_Panel, ...) end
    mvc.closePanel = function(...) return mvc.facade:send(mvc.events.Close_Panel, ...) end
end

function mvc.clearFramework()
    local initFramework = mvc.initFramework
    local clearFramework = mvc.clearFramework
    mvc = {
        initFramework = initFramework,
        clearFramework = clearFramework,

        send = function () return  end,
        openPanel = function() return  end,
        closePanel = function() return  end,
    }
end
