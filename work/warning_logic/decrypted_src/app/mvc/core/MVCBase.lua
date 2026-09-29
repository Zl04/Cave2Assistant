mvc = mvc or {}
local EventRegisterCache = class("EventRegisterCache")

function EventRegisterCache:ctor()
    self.eventListeners_ = {}
end

function EventRegisterCache:getListeners(module)
    local listenerFunc_ = self.eventListeners_[module]
    if isfunction(listenerFunc_) then
        return listenerFunc_()
    elseif istable(listenerFunc_) then
        return listenerFunc_
    else
        printInfo("module: [%s] has no controller", module)
        return nil
    end
end

-- Lazy loading
function EventRegisterCache:register(module, events)
    if module and events then
        self.eventListeners_[module] = events
    else
        error("EventRegisterCache.register failed, module or events is nil")
    end
end
-- function Event.checkEvents()
-- 	local events
-- 	for module, eventFunc in pairs(eventListeners_) do
-- 		events = eventFunc()
-- 		if istable(events) and #events > 0 then
-- 			local eventName, prev
-- 			for i = 1, #events do
-- 				eventName = events[i]
-- 				if not ((isstring(eventName) and eventName ~= "") or isnumber(eventName)) then
-- 					prev = i - 1
-- 					if prev < 1 then prev = 1 end
-- 					printInfo("[%s_e.lua id:%s] event name is empty (prev %s)]", module, i, events[prev])
-- 					-- error(sputs("[%s_e.lua id:%s] event name is empty (prev %s)]", module, i, events[prev]))
-- 				end
-- 			end
-- 		end
-- 	end
-- end

--[[
class observer
--]]
local Observer = class("Observer")

function Observer:ctor(module, notify)
    self.notify = notify
    self.name = module
    self.context = {}
end

function Observer:setContext(context)
    self.context = context
end

function Observer:notifyObserver(event, ...)
    if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        print("[event] event = ".. tostring(event.name) .. " notify ModuleName =" .. self.name)
    end
    self.context[self.notify](self.context, event, ...)
end

function Observer:compareNotifyContext(object)
    return object == self.context
end

--[[
class facade
--]]
local Facade = class("Facade")

function Facade:ctor()
    self.observerMap_ = {}
    self.loadedModules_ = {}
    self.module_configs = {}
    self.event_cache = EventRegisterCache:create()
end

function Facade:clear()
    self.observerMap_ = {}
    self.loadedModules_ = {}
    self.module_configs = {}
end

function Facade:getInstance()
    if not mvc.facade then
        mvc.facade = self:create()
    end
    return mvc.facade
end

function Facade:checkEvents()
    self.event_cache:checkEvents()
end

function Facade:registerEvents(module, events)
    self.event_cache:register(module, events)
end

function Facade:registerObserver(eventName, observer)
    if not eventName then
        error("facade:registerObserver: eventName is empty")
        return
    end
    if self.observerMap_[eventName] == nil then
        self.observerMap_[eventName] = {observer}
    else
        if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
            local observers = self.observerMap_[eventName]
            for k, v in pairs(observers) do
                if v.name == observer.name then
                    print(debug.traceback())
                    __G__TRACKBACK__("observer listener repeat error")
                end
            end
        end

        table.insert(self.observerMap_[eventName], observer)
    end
end
function Facade:_getLoadedModules(moduleName)
    if not moduleName then
        return
    end
    if self.loadedModules_[moduleName] == nil then
        self:loadModule(moduleName)
    end

    return self.loadedModules_[moduleName]
end
function Facade:notifyObservers(event, ...)
    local observers = nil
    if self.observerMap_[event.name] then
        observers = self.observerMap_[event.name]
        for _, observer in ipairs(observers) do
            if self.loadedModules_[observer.name] == nil then
                self:loadModule(observer.name)
            end
            observer:setContext(self.loadedModules_[observer.name])
            observer:notifyObserver(event, ...)
        end
    else
        if event.name == "Open_Panel" then
            local moduleName = event.params[1]
            if moduleName then
                local controller = self:_getLoadedModules(moduleName)
                if controller then
                    controller:noticeOpenPanel(event)
                end
            end
        elseif event.name == "Close_Panel" then
            local moduleName = event.params[1]
            if moduleName then
                local controller = self:_getLoadedModules(moduleName)
                if controller then
                    controller:noticeClosePanel(event)
                end
            end
        else
            printInfo("can not found eventName: [%s] observers", event.name)
        end
    end
end

function Facade:send(eventName, ...)
    -- add by zp 这里把参数给重新修改了一下含义
    local params = {select(1, ...)}
    if (params == nil) then
        params = {}
    end
    -- body = select(1, ...)
    -- type_ = select(2, ...) or "nil"
    -- puts("send: name=%s, body=%s, type=%s", eventName, game.tostring(body), type_)
    -- print("send eventName:[%s]",eventName, params)
    self:notifyObservers({name = eventName, params = params}, ...)
end

function Facade:registerModules(modules)
    modules = table.unique(modules)
    for _, v in ipairs(modules) do
        if v then
            self:registerModule(v)
        end
    end
end

function Facade:registerModule(module)
    -- self:loadEvent(module)
    local listeners_ = self.event_cache:getListeners(module)

    local observer_
    if listeners_ and #listeners_ > 0 then
        observer_ = Observer.new(module, "handleNotification")
        for _, eventName in ipairs(listeners_) do
            self:registerObserver(eventName, observer_)
        end
    end
end

function Facade:getModulePath(module)
    return string.format("%s.%s", mvc.modulePath, string.lower(module or ""))
end

function Facade:loadController(module, controller)
    local controller_ = controller or module
    local pkg_ = string.format("%s.%sController", self:getModulePath(module), controller_)
    local obj_ = require(pkg_).new(module)

    return obj_
end

function Facade:loadModel(module, model)
    local model_ = model or module
    local pkg_ = string.format("%s.%sModel", self:getModulePath(module), model_)
    local obj_ = require(pkg_).new(module)
    return obj_
end

function Facade:loadView(module, view)
    local view_ = view or module
    local pkg_ = string.format("%s.%sView", self:getModulePath(module), view_)
    local obj_ = require(pkg_).new(module)
    return obj_, pkg_
end

function Facade:loadPanel(module, view)
    local view_ = view or module
    local pkg_ = string.format("%s.%sPanel", self:getModulePath(module), view_)
    local obj_ = require(pkg_).new(module, view_)
    return obj_, pkg_
end

function Facade:loadView(module, view)
    local view_ = view or module
    local pkg_ = string.format("%s.%sView", self:getModulePath(module), view_)
    local obj_ = require(pkg_)
    return obj_, pkg_
end

function Facade:loadModule(module)
    if self.loadedModules_[module] then
        printInfo(module .. "has loaded before,plz check")
        return
    end
    local controller = self:loadController(module)
    assert(controller ~= nil, module .. " controller must be not nil")
    self.loadedModules_[module] = controller
    setglobal(checkObjName(controller.__cname), controller)
    controller:onRegister()
end

function Facade:loadConfigs(module_configs)
    self:clear()
    self.module_configs = module_configs
    for module, config in pairs(module_configs) do
        self:registerEvents(module, config.events)
        local models = config["models"] or {module}
        for _, model in ipairs(models) do
            local model = self:loadModel(module, model)
            if model then
                setglobal(checkObjName(model.__cname), model)
                model:onRegister()
            end
        end
    end
end

function Facade:getConfigs()
    return self.module_configs
end

--mvc.facade = Facade:getInstance()

--[[
class notifier
--]]
local Notifier = class("Notifier")

function Notifier:send(name, body, type_)
    Facade:getInstance():send(name, body, type_)
end

--[[
class controller
--]]
local Controller = class("Controller", Notifier)

function Controller:ctor(moduleName)
    self.moduleName = moduleName
end

function Controller:onRegister()
end

function Controller:onRemove()
end

function Controller:handleNotification(notification, ...)
    if notification.name then
        local action = "notice" .. string.gsub(notification.name, "_", "")
        if self[action] and isfunction(self[action]) then
            self[action](self, notification, ...)
        else
            printInfo("%s,can not found method:[%s] to deal notification", self.__cname, action)
        end
    end
end

local View = class("View", Notifier)
function View:ctor(name, panelName)
    self.moduleName = name
    self.panelName = panelName
end

function View:onRegister()
end

local Model = class("Model", Notifier)

function Model:ctor(name)
    self.moduleName = name
end

function Model:onRegister()
end


return {
    Facade = Facade,
    Controller = Controller,
    View = View,
    Model = Model
}
