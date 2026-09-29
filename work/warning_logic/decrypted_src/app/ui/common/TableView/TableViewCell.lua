
--[[
	TableViewCell
]]

local TableViewCell = class("TableViewCell", function()
	local tabCell = cc.TableViewCell:new()
	
	return tabCell
end)
UI = UI or {}
UI.TableViewCell = TableViewCell

function TableViewCell:ctor( node, tableWidth, disableAdapt )
	
	-- self:setNodeEventEnabled(true)
	if "boolean" ~= type(disableAdapt) then
		disableAdapt = false
	end
	
	self.disableAdapt = disableAdapt
	
	if "number" == type(tableWidth) then
		self.tableWidth = tableWidth
	else
		self.tableWidth = display.width
	end
	
	if node then
		self:setContentNode(node, self)
		-- print("self:setContentNode(node, self)")
	end


	-- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
            self:onEnter()
        elseif (nodeEvent == "exit") then
            self:onExit()
        elseif (nodeEvent == "cleanup") then
            self:dtor()
        else end
    end
    self:registerScriptHandler(onNodeEventHandler)
end
function TableViewCell:onEnter()
	-- body
end
function TableViewCell:onExit()
	-- body
end
function TableViewCell:dtor()
	-- body
end
function TableViewCell:setContentNode( node, owner )
	owner = owner or {}
	self.node = node
	
	-- self.spCellBg = owner.spCellBg
	-- self.spBgSelf = owner.spBgSelf
	
	self:removeAllChildren()
	
	if not self.node then
		return
	end
	
	self:addChild(self.node)
	self:setContentSize(cc.size(self.node:getContentSize().width, self.node:getContentSize().height))

	-- CENTER X
	-- self.node:ignoreAnchorPointForPosition(false)
	-- self.node:setAnchorPoint(cc.p(.5, .5))
	-- self.node:setPosition(cc.p(self.tableWidth / 2.0, self.node:getContentSize().height / 2.0))
	
	if not self.disableAdapt then
		self:adaptCell()
	end
end

function TableViewCell:adaptCell()
	self:adaptNodeWidth(self.root_, self)
end
--[[
	node元素内X轴适配

	该函数会在X轴均匀分布子元素
]]
function TableViewCell:adaptNodeWidth( node, owner )
	-- local mw = display.moreWidth * (node:getContentSize().width / 640.0)
	
	-- if owner then
	-- 	if owner.spCellBg then
	-- 		owner.spCellBg:setScaleX((owner.spCellBg:getContentSize().width + mw) / owner.spCellBg:getContentSize().width)
	-- 	end

	-- 	if owner.spBgSelf then
	-- 		owner.spBgSelf:setScaleX((owner.spBgSelf:getContentSize().width + mw) / owner.spBgSelf:getContentSize().width)
	-- 	end
	-- end

	-- for i=1,node:getChildrenCount() do
	-- 	local child = node:getChildren():objectAtIndex(i - 1)
	-- 	local px = child:getPositionX()
	-- 	px = px + (mw * (px / child:getParent():getContentSize().width))
	-- 	px = px - mw / 2.0
		
	-- 	child:setPositionX(px)
	-- end
end

-- return TableViewCell