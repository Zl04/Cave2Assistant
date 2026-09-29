--[[--
游戏模块控制器，其中包含view多数管理
命名定义mvc中的 V 为config中的panel，panel上的layer为config中的view
]]
-- local mvc = mvc
local GameController = class("GameController", mvc.Controller)
-- register view and proxy setglobal
function GameController:onRegister()
    printInfo("[%s], [%s] onRegister", self.moduleName, self.__cname)
    GameController.super.onRegister(self)

    local module_configs = mvc.facade:getConfigs()
    local module_config = module_configs[self.moduleName]

    self._panelClassName = {}
    local panels = module_config["panels"]
    if panels then
        for _, panelName in ipairs(panels) do
            local panel = mvc.facade:loadPanel(self.moduleName, panelName)
            if panel then
                setglobal(checkObjName(panel.__cname), panel)
                table.insert(self._panelClassName, checkObjName(panel.__cname))
            end
        end
    -- else
    --     local panel = mvc.facade:loadPanel(self.moduleName,self.moduleName)
    --     if panel then
    --         setglobal(checkObjName(panel.__cname), panel)
    --         panel:onRegister()
    --         table.insert(self._panelClassName, checkObjName(panel.__cname))
    --     end
    end

    self._viewClassName = {}
    local views = module_config["views"]
    if views then
        for _, _view in ipairs(views) do
            local view = mvc.facade:loadView(self.moduleName, _view)
            if view then
                setglobal(checkObjName(view.__cname), view)
                table.insert(self._viewClassName, checkObjName(view.__cname))
            end
        end
    end

    self.curOpenViews = {}
end

-- GameController remove setglobal nil
function GameController:onRemove()
    GameController.super.onRemove(self)

    local module_configs = facade:getConfigs()
    local module_config = module_configs[self.moduleName]

    local panels = module_config["panels"]

    for _, panel in ipairs(panels) do
        local view = facade:loadPanel(self.moduleName, panel)
        if view then
            setglobal(checkObjName(view.__cname), nil)
        end
    end
end

function GameController:showView(panel, viewClass, zorder, param)
    if not viewClass then
        return
    end
    local viewName = checkObjName(viewClass.__cname)
    -- printInfo("open view is ====== " .. viewName)
    if self.curOpenViews[viewName] then
        self.curOpenViews[viewName]:show()
        self[viewName] = self.curOpenViews[viewName]
        return self[viewName]
    end
    local view = viewClass:create(param)
    view.__panel = panel
    panel.addViewNames = panel.addViewNames or {}
    table.insert(panel.addViewNames, viewName)
    self[viewName] = view
    self.curOpenViews[viewName] = view
    view:init()
    panel:addChild(view, zorder)
    if (view.postAddChild) then view:postAddChild() end
    return view
end

function GameController:hideView(viewObj, isRemove)
    if not viewObj or tolua.isnull(viewObj) then
        return
    end

    local viewName
    for k, v in pairs(self.curOpenViews) do
        if v == viewObj then
            viewName = k
        end
    end

    if not viewName then
        print("hideView false", debug.traceback())
        return
    end

    if isRemove then
        self.curOpenViews[viewName]:removeFromParent()
        self.curOpenViews[viewName] = nil
    else
        self.curOpenViews[viewName]:hide()
    end
    self[viewName] = nil
end

function GameController:_removeViewByName(viewName)
    if not viewName then
        print("_removeViewByName false", debug.traceback())
        return
    end

    local viewObj = self.curOpenViews[viewName]
    self.curOpenViews[viewName] = nil
    self[viewName] = nil
    if not viewObj then
        return
    end

    if not tolua.isnull(viewObj) then
        viewObj:removeFromParent()
    end

    return
end

function GameController:noticeClosePanel(event)
    local eventParam = event.params

    if not eventParam[1] then
        return
    end
    local moduleName = checkObjName(eventParam[2] or eventParam[1])
    local closePanelName = moduleName .. "Panel"
    if not closePanelName or not mvc[closePanelName] then
        return
    end

    local panel = mvc[closePanelName]
    printInfo(closePanelName)
    if not panel:isExist() then
        return
    end

    if panel.addViewNames then
        for _, name in pairs(panel.addViewNames) do
            self:_removeViewByName(name)
        end
    end
    panel.addViewNames = {}
    panel:close()

    if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        --reload controller
        -- reload_module_mvc(self.moduleName)
    end
end

function GameController:noticeOpenPanel(event)
    local eventParam = event.params
    if not eventParam[1] then
        return
    end

    local moduleName = checkObjName(eventParam[2] or eventParam[1])
    local openPanelName = moduleName .. "Panel"
    if not openPanelName or not mvc[openPanelName] then
        printInfo("not panel in module : "..openPanelName)
        return
    end

    local panel = mvc[openPanelName]
    if panel:isExist() then
        panel:show(eventParam[1], eventParam[2], eventParam[3])
        return
    end
    GameManager:stopMoveHandler()

    panel:open(eventParam[1], eventParam[2], eventParam[3])

    
    local defaultView = mvc[moduleName .. "View"]
    if not defaultView then
        printInfo("is not defaultView")
        return
    end

    self:showView(panel, defaultView, nil, eventParam[3])
end

return GameController
