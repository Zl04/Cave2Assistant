--[[--
游戏模块视图

]]


-- local CCSPanel = import(".CCSPanel")
local GamePanel = class("GamePanel", mvc.View)

--提供子类初始化
function GamePanel:onInit()
   
end

--初始化
function GamePanel:init(styleName,viewType)
   self.styleName = styleName or ViewStyle.ViewStyle_CenterWin
   self.viewType = viewType or mvc.VIEW_TYPE.PANEL
   self._hasUI = false
   self._isActive = false
   self._isExist = true
end

function GamePanel:setStyleName(styleName)
   self.styleName = styleName
end

--注入UI
function GamePanel:injectUI()
   if(self.styleName == ViewStyle.ViewStyle_CenterWin) then 
      self.ui = UI.CenterWin:create()
      self.ui:init()
      self.ui:center()
      self.ui:setCloseEndCallBack(function()
         self:close()
      end)
   elseif (self.styleName == ViewStyle.ViewStyle_DoorWin) then 
      self.ui = UI.DoorWin:create()
      self.ui:init()
      self.ui:center()
      self.ui:setCloseEndCallBack(function()
         self:close()
      end)
   elseif (self.styleName == ViewStyle.ViewStyle_DownShowWin) then 
      self.ui = UI.DownShowWin:create()
      self.ui:init()
      self.ui:center()
      self.ui:setCloseEndCallBack(function()
         self:close()
      end)
   elseif (self.styleName == ViewStyle.ViewStyle_BaseWin) then 
      self.ui = UI.BaseWin:create()
      self.ui:init()
      self.ui:center()
      self.ui:setCloseEndCallBack(function()
         self:close()
      end)
   elseif self.styleName == "empty" then
      self.ui = display.newLayer()
   else
      self.ui = CCSPanel:create(string.format("%s/%s",string.lower(self.moduleName),self.styleName))
   end

   if self.ui.setCloseFinishCallBack then
      self.ui:setCloseFinishCallBack(function()
         mvc.send("Close_Panel", self.moduleName, self.panelName)
         return false
      end)
   end
   
   self:onInit()

   self._hasUI = true

   printInfo("Panel:init() styleName:%s ,viewType:%s",self.styleName,self.viewType)

end

--显示
function GamePanel:open(moduleName, panelName, params)
   if self:isExist() then return end
   self:init(params)
   self:validateUI() --显示时候验证UI
   self.ui._moduleInfo = {moduleName, panelName}
   mvc.panelMonitor:addPanel(self)
   self._isActive = true
   self._isExist = true
   if(self.viewType == mvc.VIEW_TYPE.SUB_PANEL) then
      self.ui:setNoticeShowMainUI(false)
   end
   self:onEnter()
end

--关闭
function GamePanel:close()
   if not self:isExist() then return end
   self:dispose() --在清除UI之前
   mvc.panelMonitor:removePanel(self)
   self.ui = nil
   self._hasUI = false
   self._isActive = false
   self._isExist = false
   self:onExit()
end

function GamePanel:show(moduleName, panelName, params)
   if not self:isExist() then
      printInfo("panel is not extst panelName : "..panelName)
      return
   end

   mvc.panelMonitor:showPanel(self)
end

function GamePanel:hide(moduleName, panelName, params)
   if not self:isExist() then
      printInfo("panel is not extst panelName : "..panelName)
      return
   end

   mvc.panelMonitor:hidePanel(self)
end

function GamePanel:clear()
   self.ui = nil
   self._hasUI = nil
   self._isActive = false
   self._isExist = false
end

function GamePanel:onClose()
end

-- 显示之前将触发的回调
function GamePanel:onShow()
   local children = self.ui:getChildren()
   for k, v in pairs(children) do
      if v and v.onShow then
         v:onShow()
      end
   end
end

-- 隐藏之后将触发的回调
function GamePanel:onCover()
   local children = self.ui:getChildren()
   for k, v in pairs(children) do
      if v and v.onCover then
         v:onCover()
      end
   end
end

--验证是否已经初始化
function GamePanel:validateUI()
   if not self._hasUI then -- 如果释放了，则重新初始化
      self:injectUI()
   end
end

--更新视图数据
function GamePanel:update(data)
   self:validateUI() -- update时候验证UI
end

--是否处于活跃显示状态
function GamePanel:isActive()
   return self._isActive
end

--设置活跃显示状态
function GamePanel:setActive(value)
   self._isActive = value
end

--设置存在状态
function GamePanel:setExist(value)
   self._isExist = value
end

--是否存在
function GamePanel:isExist()
   return self._isExist
end


--当显示时触发
function GamePanel:onEnter()
   printInfo("%s onShow",self.__cname)
end


--当关闭时 清除UI之后 触发
function GamePanel:onExit()
   printInfo("%s onClose",self.__cname)
end

--在清除UI之前
function GamePanel:dispose()
   printInfo("%s dispose",self.__cname)
end

function GamePanel:getUI()
   return self.ui
end

function GamePanel:addChild(node, zIndex)
   if(self.ui) then 
      if(not tolua.isnull(node)) then 
         if(zIndex) then 
            self.ui:addChild(node, zIndex)
         else  
            self.ui:addChild(node)
         end 
      end
   end
end

return GamePanel