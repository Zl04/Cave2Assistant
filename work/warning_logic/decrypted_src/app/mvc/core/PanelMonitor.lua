--[[--
  视图管理中心,管理panel
  命名定义mvc中的 V 为config中的panel，panel上的layer为config中的view
]]

local PanelMonitor = class("PanelMonitor")
local layerSets = require(mvc.PACKAGE_APP_CONFIG..".LayerSets")

function PanelMonitor:getInstance()
	if not self._instance then
		self._instance = PanelMonitor.new()
	end
	return self._instance
end

function PanelMonitor:ctor()
	self.curContainers = {}

	-- 支持互斥的层级需填写
	-- 各个uiLayer已经打开的视图有序列表
	self.curPanelList = {
		[mvc.VIEW_TYPE.PANEL] = {},
		[mvc.VIEW_TYPE.TIP] = {}
	}
	-- 各个uiLayer最大层级
	self.curMaxZorderList = {
		[mvc.VIEW_TYPE.PANEL] = 1,
		[mvc.VIEW_TYPE.TIP] = 1
	}
end

function PanelMonitor:replaceScene(scene)
	if self._mainLayer then
		self._mainLayer:removeFromParent()
	end
	scene:addChild(self._mainLayer)
end

function PanelMonitor:setMainLayer(mainLayer)
	self:clearPanels()
	self._mainLayer = mainLayer
end

function PanelMonitor:getMainLayer()
	return self._mainLayer
end

function PanelMonitor:clearPanels()
	for _, container in pairs(self.curContainers) do
		local panels = container:getViews()
		if panels and type(panels) == "table" then
			for _, panel in pairs(panels) do
				if panel.ui and panel.ui._moduleInfo then
					mvc.closePanel(panel.ui._moduleInfo[1], panel.ui._moduleInfo[2])
				end
			end
		end
	end
	self.curContainers = {}
end

-- 添加panel到指定层级节点
function PanelMonitor:addPanel(panel)
	local panel = panel
	if not panel.viewType or not panel:getUI() then
		printInfo(string.format(" %s not find viewType:[%s] or getUI() is nil",panel.__cname,panel.viewType or ""))
		return
	end

	local layerSet = layerSets[panel.viewType]
	-- 获取层级节点
	local uiLayer = self._mainLayer:getChildByName(panel.viewType)
	-- 创建节点
	if not uiLayer then
		uiLayer = self:createUILayer(layerSet,panel.viewType)
		-- 初始化该层级最上层UI最大Z轴值
		self.curMaxZorderList[panel.viewType] = 1
		-- 初始化该层级view列表
		self.curPanelList[panel.viewType] = {}
	end
	printInfo("addPanel viewType: ["..panel.viewType.."]  cname: "..panel.__cname)

	uiLayer:addView(panel)

	local viewList = self.curPanelList[panel.viewType]
	local maxZorder = self:getMaxZorder(panel.viewType)

	-- 不在互斥层级范围内
	if not viewList or not maxZorder then
		return
	end

	-- 互斥层接管，默认self.isNoticeShowMainUI为false，关闭时BaseWin不触发
	panel.ui:setNoticeShowMainUI(false)

	if #viewList > 0 and not panel.alwaysShow then
		-- 若该层级已有panel则隐藏，列表加入新view至队尾
		self:hidePanel(viewList[#viewList])
	end
	table.insert(viewList, panel)

	-- 设置新panel层级，新打开默认顶层
	panel.ui:setLocalZOrder(maxZorder)
	maxZorder = maxZorder + 1

	-- 桥接旧系统，当PANEL层级首次打开panel时触发
	if(panel.viewType == mvc.VIEW_TYPE.PANEL) and #viewList == 1 then
		mvc.send(mvc.events.Bridge_Hide_Main_Layer)
		mvc.send(mvc.events.Bridge_Close_All_Panel_Layer)
	end
end

-- 删除指定层级节点的panel
function PanelMonitor:removePanel(panel)
	if not panel.viewType or not panel:getUI() then
		printInfo(string.format(" %s not find viewType:[%s] or getUI() is nil",panel.__cname,panel.viewType or ""))
		return
	end

	local layerSet = layerSets[panel.viewType]
	-- 获取层级节点
	local uiLayer = self._mainLayer:getChildByName(panel.viewType)
	-- 老代码，这里我也看不懂为嘛还能取不到=-=
	if not uiLayer then
		uiLayer = self:createUILayer(layerSet,panel.viewType)
	end
	printInfo("removePanel viewType: ["..panel.viewType.."]  cname: "..panel.__cname)

	local viewList = self.curPanelList[panel.viewType]
	-- 在互斥层级范围内
	if viewList then
		-- 先删除该层级列表中的该panel
		for index = #viewList, 1, -1 do
			if viewList[index].__cname == panel.__cname then
				table.remove(viewList, index)

				-- 判断删除前列表存在多个panel且删除的是顶层，那么下层应该显示出来
				if #viewList + 1 == index and #viewList > 0 then
					local lastPanel = viewList[#viewList]
					if not panel.ui.dontShowPanel then
						self:showPanel(lastPanel)
					end
				end
				break
			end
		end
	end

	uiLayer:removeView(panel)

	-- 桥接旧系统，当PANEL层级删除所有panel时触发
	if(panel.viewType == mvc.VIEW_TYPE.PANEL) and #viewList == 0 then
		mvc.send(mvc.events.Bridge_Show_Main_Layer)
	end
end

-- 展示指定层级节点已经打开的view
function PanelMonitor:showPanel(panel)
	if not panel.viewType or not panel:getUI() then
		printInfo(string.format(" %s not find viewType:[%s] or getUI() is nil",panel.__cname,panel.viewType or ""))
		return
	end

	local showPanel = nil
	local viewList = self.curPanelList[panel.viewType]
	local maxZorder = self:getMaxZorder(panel.viewType)

	-- 不在互斥层级范围内
	if not viewList or not maxZorder then
		return
	end

	printInfo("showPanel viewType: ["..panel.viewType.."]  cname: "..panel.__cname)

	for k, v in pairs(viewList) do
		if v.__cname == panel.__cname then
			showPanel = v
			-- 如果展现的不是顶层view，则需要隐藏当前顶层view，再将展现view调整到列表顶层，进行显示
			if k ~= #viewList then
				self:hidePanel(viewList[#viewList])
				table.remove(viewList, k)
				table.insert(viewList, showPanel)
			end
			break
		end
	end

	-- 检测界面是否已经隐藏,已经隐藏不再触发onShow
	if showPanel:isActive() then
		return
	end

	-- 显示之前触发回调
	showPanel:onShow()

	-- 修改层级值到最大
	showPanel.ui:setLocalZOrder(maxZorder)
	maxZorder = maxZorder + 1

	showPanel.ui:show()
	showPanel:setActive(true)
end

-- 隐藏指定层级节点已经打开的view
function PanelMonitor:hidePanel(panel)
	if not panel.viewType or not panel:getUI() then
		printInfo(string.format(" %s not find viewType:[%s] or getUI() is nil",panel.__cname,panel.viewType or ""))
		return
	end

	-- 不在互斥层级范围内
	local viewList = self.curPanelList[panel.viewType]
	local maxZorder = self:getMaxZorder(panel.viewType)
	if not viewList or not maxZorder then
		return
	end

	-- 检测界面是否已经隐藏,已经隐藏不再触发onCover
	if not panel:isActive() then
		return
	end

	printInfo("hidePanel viewType: ["..panel.viewType.."]  cname: "..panel.__cname)

	panel.ui:hide()
	panel:setActive(false)

	-- 隐藏结束触发回调
	panel:onCover()
end

-- 获取指定viewType最上层panel
function PanelMonitor:getTopZOrderPanel(viewType)
	if not self.curPanelList or not self.curPanelList[viewType] then
		return nil
	end

	local panelList = self.curPanelList[viewType]
	local panel = panelList[#panelList]

	return panel
end

-- 获取指定viewType当前最高层级
function PanelMonitor:getMaxZorder(viewType)
	local maxZorder = self.curMaxZorderList[viewType]

	return maxZorder
end

function PanelMonitor:createUILayer(layerSet,name)
	local Cls = require(mvc.PACKAGE_APP_COMPONENTS..".container."..layerSet.cls)
	local uiLayer = Cls:create()
	uiLayer:setName(name)
	self._mainLayer:addChild(uiLayer,layerSet.zorder)
	table.insert(self.curContainers, uiLayer)
	return uiLayer 
end

-- 新老界面跳转使用 -----------
-- 打开老界面时隐藏mvc的panel类型界面最上层界面
function PanelMonitor:hideTopPanel()
	local panel = self:getTopZOrderPanel(mvc.VIEW_TYPE.PANEL)
	if not panel then
		return
	end

	self:hidePanel(panel)
end

-- 关闭老界面时显示mvc的panel类型界面最上层界面
function PanelMonitor:showTopPanel()
	local panel = self:getTopZOrderPanel(mvc.VIEW_TYPE.PANEL)
	if not panel then
		return
	end

	self:showPanel(panel)
end

-- 新老界面跳转使用 -----------

-- 根据传入panel名获取panel
function PanelMonitor:getPanelByName(panelName)
	local moduleName = checkObjName(panelName)
	local closePanelName = moduleName .. "Panel"
	if not closePanelName or not mvc[closePanelName] then
        return nil
    end

	local panel = mvc[closePanelName]
	if not panel:isExist() then
        return nil
	end

	return panel
end

-- 根据传入的panel名隐藏panel
function PanelMonitor:hidePanelByName(panelName)
	local panel = self:getPanelByName(panelName)
	if not panel then
        return
	end

	self:hidePanel(panel)
end

-- 根据传入的panel名隐藏panel
function PanelMonitor:showPanelByName(panelName)
	local panel = self:getPanelByName(panelName)
	if not panel then
        return
	end

	self:showPanel(panel)
end

function PanelMonitor:removeLayer(viewType)
	local uiLayer = self:getLayer(viewType)
	if uiLayer then
		uiLayer:remove()
	end
end

--可视化某个viewType
function PanelMonitor:visibleLayer(viewType,visible)
	local uiLayer = self:getLayer(viewType)
	if uiLayer then
		uiLayer:setVisible(visible)
		if visible then
			uiLayer:resumeSchedulerAndActions()
		else
			uiLayer:pauseSchedulerAndActions()
		end
   end
end


function PanelMonitor:getLayer(viewType)

	local layerSet = layerSets[viewType]
	if layerSet.cls then
		local uiLayer =  self._mainLayer:getChildByName(viewType)
		if not uiLayer then
			uiLayer = self:createUILayer(layerSet,viewType)
		end
		return uiLayer
	end
	return nil
end



function PanelMonitor:clear()
	if  self._mainLayer then
		self._mainLayer:release()
		self._mainLayer:removeFromParent()
		self._mainLayer = nil
	end
end

return PanelMonitor

---------------------------impl  UILayers----------------------------------------------
