------------------------------------------------------
-- UILayoutUtils.lua
-- 作者:	yhj
-- 描述:	拖动布局的基本类
------------------------------------------------------
local LayoutUtil = class("LayoutUtil")

--用来获取锚点位置的方法--
local function getLeftBottomXY(node) return 0, 0 end
local function getLeftUpXY(node) return 0, node:getContentSize().height end
local function getCenterBottomXY(node)
    local size = node:getContentSize()
    return size.width / 2, 0
end
local function getCenterUpXY(node)
    local size = node:getContentSize()
    return size.width / 2, size.height
end
local function getCenterRightXY(node)
    local size = node:getContentSize()
    return size.width, size.height / 2
end

local function getCenterLeftXY(node)
    local size = node:getContentSize()
    return 0, size.height / 2
end
local function getCenterXY(node)
    local size = node:getContentSize()
    return size.width / 2, size.height / 2
end
local function getRightUpXY(node)
    local size = node:getContentSize()
    return size.width, size.height
end
local function getRightBottomXY(node)
    local size = node:getContentSize()
    return size.width, 0
end
--用来获取锚点位置的方法 结束--

--布局类型
local layoutType = {
    leftBottom = {"_left", "_bottom", getLeftBottomXY},
    leftUp = {"_left", "_up", getLeftUpXY, {1, -1}},
    centerBottom = {"_bottom__", "_bottom", getCenterBottomXY},
    centerUp = {"_bottom__", "_up", getCenterUpXY, {1, -1}},
    centerRight = {"_right", "_up", getCenterRightXY, {-1, -1}},
    centerLeft = {"_left", "_up", getCenterLeftXY, {1, -1}}, -- 这个移动的时候有点问题
    center = {"_left", "_up", getCenterXY, {1, -1}},
    rightUp = {"_right", "_up", getRightUpXY, {-1, -1}},
    rightBottom = {"_right", "_bottom", getRightBottomXY, {-1, 1}}
}

-- TAB切换布局顺序
local layoutFuncNameArr = {
    "leftBottom", "centerLeft", "leftUp", "centerUp",  "rightUp", "centerRight", "rightBottom", "centerBottom", "center", 
}

-- 根据布局类型获取控件锚点位置
local function getAnchorPointPos(node)
    local posX, posY = node:getPosition()
    local layoutFuncName = node._layoutFuncName
    local x, y = 0, 0
    if layoutFuncName and node[layoutFuncName] then
        local nodeLayoutType = layoutType[layoutFuncName]
        if nodeLayoutType and nodeLayoutType[3] then
            x, y = nodeLayoutType[3](node)
        end
    end

    return cc.pAdd(cc.p(x, y), cc.p(posX, posY))
end

-- 鼠标移动转换为不同布局下的数值变化
local function mouseMoveToLayoutMove(node, dis)
    local layoutFuncName = node._layoutFuncName
    if layoutFuncName and node[layoutFuncName] then
        local nodeLayoutType = layoutType[layoutFuncName]
        if nodeLayoutType[4] then
            dis.x = dis.x * nodeLayoutType[4][1]
            dis.y = dis.y * nodeLayoutType[4][2]
        end
    end
    return dis
end

local function getConfigFilePath(self)
    return cc.FileUtils:getInstance():fullPathForFilename(string.gsub(self.curFilename, "%.", "/").. ".lua")
end

local function wirtePosInfoHandler(self, string)
    local path = getConfigFilePath(self)
    local file = assert(io.open(path, 'w'))
    file:write(string)
    file:close()
end

local tabIndex = 0
local function tab2str(tab)
    if type(tab) ~= "table" then return tab end
    tabIndex = tabIndex + 1
    local tabStr = "\n"
    for i = 1, tabIndex do tabStr = tabStr .. "\t" end
    local s = ""
    for k, v in pairs(tab) do
        local key = k
        if type(k) == "number" then key = "[" .. k .. "]" end
        if type(v) ~= "table" then
            local valueStr = type(v) == "string" and "\"" .. v .. "\"" or tostring(v)
            s = s .. tabStr .. tostring(key) .. "=" .. valueStr .. ","
        else
            s = s .. tabStr .. tostring(key) .. " = {" .. tab2str(v) .. "},\n"
        end
    end
    tabIndex = tabIndex - 1
    return s
end

local function write2ConfigFile(self, tab)
    local s = "return {" .. tostring(tab2str(tab)) .. "}"
    wirtePosInfoHandler(self, s)
end

-- 全局方法来调整选中控件的位置
local tags = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}}
local curLayoutObj
local shiftPressed
function adjustEditorModeSelectedNodePos(tag)
    if not curLayoutObj then return end

    local addValue = tags[tag]
    if not tolua.isnull(curLayoutObj.currentChild) then
        local factor = shiftPressed and 10 or 1
        local addX = addValue[1] * factor
        local addY = addValue[2] * factor
        local layoutDis = mouseMoveToLayoutMove(curLayoutObj.currentChild, cc.p(addX, addY))

        curLayoutObj:updateCurrentNodePosAndDisplay(layoutDis.x, layoutDis.y)        
    end
end

--------------------------------------------------
---	布局界面的初始化
---		@param 	isEdit:	是不是界面编辑模式
--------------------------------------------------
local savedCurNodeLayoutName = nil
function LayoutUtil:ctor(view, filename, isEdit)
    -- 初始化信息
    self.posInfo = require(filename)
    self.children = {}
    self.currentChild = nil
    self.curFilename = filename
    self.isEdit = isEdit

    -- 处理视图相关信息
    local viewName = nil
    if (type(view) == "string") then
        viewName = view
    else
        viewName = view.__cname
        
        -- 处理关闭界面时自动退出编辑
        local nodeDtor = view.dtor
        view.dtor = function(s, ...)
            nodeDtor(s, ...)
            view.dtor = nodeDtor
            self:viewDtor()
        end
    end

    -- 获取配置信息
    self.viewPosInfo = self.posInfo[viewName]
    if not self.viewPosInfo then
        self.posInfo[viewName] = {}
        self.viewPosInfo = self.posInfo[viewName]
    end

    if self.isEdit then
        -- 编辑层宿主
        self.node = UI.Component:create()
        self.node:init()
        self.node:setPosition(820, 150)
        self.node:enableDebugDraw()
        UI.UIManager._uilayer:addChild(self.node, 10010)

        -- 坐标标签
        self.label = UI.Text:create()
        self.label:init("(0,0)")
        UI.UIManager._uilayer:addChild(self.label, 10010)

        -- 名字显示
        self._nameBox = UI.EditBox:create(500, 30)
        self._nameBox:init("名字", cc.EDITBOX_INPUT_MODE_ANY, nil, 5, 5)
        self._nameBox:setFontSize(30)
        self._nameBox:setPlaceholderFontSize(30)
        self._nameBox:setPlaceholderFontColor({r = 210, g = 210, b = 210})
        self._nameBox:rightUp(0, 0)
        -- self._nameBox._editBox:setSwallowTouches(false)
        self._nameBox:enableDebugDraw()
        self._nameBox:hide()
        UI.UIManager._uilayer:addChild(self._nameBox, 10010)

        -- 关闭按钮
        local savePosInfoAndClose = UI.Button:create()
        savePosInfoAndClose:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
        savePosInfoAndClose:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_36PX, UI.FONT_COLOR_ENTER_GAME_BUTTON_TEXT)
        savePosInfoAndClose:setText("保存退出")
        self.node:addChild(savePosInfoAndClose, 100)
        savePosInfoAndClose:addEventListener(UI.Event.BUTTON_CLICK, self, function()
            self:closeAndSave()
        end)
        
        -- 画移动时的交叉点
        local glNode = gl.glNodeCreate()
        glNode:setContentSize(cc.size(256, 256))
        glNode:setAnchorPoint(cc.p(0.5, 0.5))
        local function majoriDraw(transform, transformUpdated)
            -- 画横竖线
            if self.curEditorAnchorWorldPoint then
                gl.lineWidth(3)
                cc.DrawPrimitives.drawColor4B(255, 0, 255, 255)
                cc.DrawPrimitives.drawLine(cc.p(0, self.curEditorAnchorWorldPoint.y), cc.p(1140, self.curEditorAnchorWorldPoint.y))
                cc.DrawPrimitives.drawLine(cc.p(self.curEditorAnchorWorldPoint.x, 0), cc.p(self.curEditorAnchorWorldPoint.x, 1140))
            end

            -- 画锚点
            gl.lineWidth(1)
            cc.DrawPrimitives.setPointSize(10)
            if self.viewPosInfo then
                for i = 1, #self.children do
                    local node = self.children[i]
                    if not tolua.isnull(node) then
                        -- 设置锁定和普通颜色
                        
                        if (self:isNodeLocked(node)) then
                            cc.DrawPrimitives.drawColor4B(0xCC, 0xCC, 0xCC, 255)
                        elseif (node == self.currentChild) then
                            cc.DrawPrimitives.drawColor4B(0xCC, 0, 0, 255)
                        else
                            cc.DrawPrimitives.drawColor4B(0x7C, 0xFC, 0, 255)
                        end
                        local pos = getAnchorPointPos(node)
                        local parent = node:getParent()
                        cc.DrawPrimitives.drawPoint(parent:convertToWorldSpace(pos))
                    else
                        return
                    end
                end
            end
        end
        glNode:registerScriptDrawHandler(majoriDraw)
        glNode:setPosition(100, 200)
        self.node:addChild(glNode, 10011)

        -- 注册点击回调
        self._touchListener = cc.EventListenerTouchOneByOne:create()
        self._touchListener:setSwallowTouches(true)
        self._touchListener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
        self._touchListener:registerScriptHandler(handler(self, self.onTouchMoved), cc.Handler.EVENT_TOUCH_MOVED)
        self._touchListener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)

        -- 键盘监听
        self._kbListener = cc.EventListenerKeyboard:create()
        self._kbListener:registerScriptHandler(function(keycode, evt)
            -- 如果UIComposer有菜单打开, 直接不做反应
            if (self:isAbleToRespondInteraction()) then return end
            if (keycode == cc.KeyCode.KEY_SHIFT) then
                shiftPressed = true
            end
        end, cc.Handler.EVENT_KEYBOARD_PRESSED)
        self._kbListener:registerScriptHandler(function(keycode, evt)
            -- 如果UIComposer有菜单打开, 直接不做反应
            if (self:isAbleToRespondInteraction()) then return end

            if (keycode == cc.KeyCode.KEY_TAB) then
                self:nextLayoutFun(self.currentChild)
            elseif (keycode == cc.KeyCode.KEY_Z) then
                self:clearSelection()
            elseif (keycode == cc.KeyCode.KEY_Q) then
                if (self.currentChild.layoutUtilName) then
                    self.viewPosInfo[self.currentChild.layoutUtilName][4] = not self.viewPosInfo[self.currentChild.layoutUtilName][4]
                end
            elseif (keycode == cc.KeyCode.KEY_F) then
                self:selectNextUnlockedNode()
            elseif (keycode == cc.KeyCode.KEY_SHIFT) then
                shiftPressed = false
            end
        end, cc.Handler.EVENT_KEYBOARD_RELEASED)

        -- 添加监听
        local eventDispatcher = self.node:getEventDispatcher()
        eventDispatcher:addEventListenerWithFixedPriority(self._touchListener, -10)
        eventDispatcher:addEventListenerWithFixedPriority(self._kbListener, -10)
    end
end

-- 获取位置
local count = 0
function LayoutUtil:autoPos(node, name, layoutFuncName)
    assert(name, "autoPos name参数不为空")
    -- 获取配置值
    local pos = self.viewPosInfo[name]
    if not pos then
        pos = {0, 0, "leftBottom"}
        self.viewPosInfo[name] = pos
    end

    -- 按排版方式应用值
    if (not layoutFuncName) then layoutFuncName = pos[3] end
    if layoutFuncName and node[layoutFuncName] then
        node._enableAutoUpdatePos = true
        node[layoutFuncName](node, pos[1], pos[2])
    else
        node:setPosition(pos[1], pos[2])
    end

    -- 编辑模式配置
    if self.isEdit then
        node.layoutUtilName = name
        node._layoutFuncName = layoutFuncName
        count = count + 1
        node.__count1 = count
        table.insert(self.children, node)

        if (savedCurNodeLayoutName and name == savedCurNodeLayoutName) then
            performWithDelay(node, function() 
                self:setCurrentNode(node)
            end, 0.3)
        end
    end
end

-- 根据排版方式设置位置值
function LayoutUtil:setPos(node, x, y, isSetView)
    if (isSetview == nil) then isSetView = true end

    -- 设置组件位置
    if (isSetView) then
        local layoutFuncName = node._layoutFuncName
        if layoutFuncName and node[layoutFuncName] then
            local nodeLayoutType = layoutType[layoutFuncName]
            if (not node[nodeLayoutType[1]])then
                x = y
                y = 0
            end
            if node[layoutFuncName] then
                node[layoutFuncName](node, x, y)
            end
        else
            node:setPosition(x, y)
        end
    end

    -- 设置配置位置
    if (node.layoutUtilName) then
        if (not self.viewPosInfo[node.layoutUtilName]) then self.viewPosInfo[node.layoutUtilName] = {} end
        self.viewPosInfo[node.layoutUtilName][1] = x
        self.viewPosInfo[node.layoutUtilName][2] = y
    end
end

-- 取消选择
function LayoutUtil:clearSelection()
    -- 取消显示边沿
    if (self.currentChild and self.currentChild.disableDebugDraw) then
        self.currentChild:disableDebugDraw()
        self.currentChild:clearDebugDraw()
    end

    self.curEditorAnchorWorldPoint = nil
    self.currentChild = nil
    self._nameBox:hide()
    self.label:leftUp(0, 0)
end

-- 轮换锚点
function LayoutUtil:nextLayoutFun(node)
    if (not node or not node._layoutFuncName or not node[node._layoutFuncName]) then return end

    -- 轮换
    for i,v in ipairs(layoutFuncNameArr) do
        if (v == node._layoutFuncName) then
            if (i >= #layoutFuncNameArr) then
                node._layoutFuncName = layoutFuncNameArr[1]
            else
                node._layoutFuncName = layoutFuncNameArr[i + 1]
            end
            self.viewPosInfo[node.layoutUtilName][3] = node._layoutFuncName
            break
        end
    end

    -- 写入
    self:saveToFile()
end

-- 根据排版方式获取排版位置
function LayoutUtil:getPos(node)
    local layoutFuncName = node._layoutFuncName
    if layoutFuncName and layoutType[layoutFuncName] and node[layoutFuncName] then
        local nodeLayoutType = layoutType[layoutFuncName]
        return node[nodeLayoutType[1]] or 0, node[nodeLayoutType[2]]
    end

    return node:getPosition()
end

-- 判断点击点是否落在指定对象上
local function isClickInTarget(target, touch)
    local type = type(touch)
    local location = touch
    if type == "userdata" then location = touch:getLocation() end
    local locationInNode = target:convertToNodeSpace(location)
    local s = target:getContentSize()
    if (s.width < 30) then s.width = 30 end
    if (s.height < 30) then s.height = 30 end
    local rect = cc.rect(0, 0, s.width, s.height)
    if cc.rectContainsPoint(rect, locationInNode) then return true end
    return false
end

-- 更开始触摸
local lastPoint
function LayoutUtil:onTouchBegan(touch, event)
    -- 如果UIComposer有菜单打开, 直接不做反应
    if (self:isAbleToRespondInteraction()) then
        return
    end

    -- 获取点击点
    local location = touch:getLocation()
    lastPoint = location

    -- 获取点击到的目标
    local clickTargets = {}
    for i,child in ipairs(self.children) do
        if not tolua.isnull(child) then
            if isClickInTarget(child, location) then table.insert(clickTargets, child) end
        end
    end

    -- 根据z序排序点击到的目标
    table.sort(clickTargets, function(n1, n2)
        local z1 = n1:getLocalZOrder()
        local z2 = n2:getLocalZOrder()
        if (n1:getParent() == n2:getParent()) then
            if z1 == z2 then
                return not (n1.__count1 < n2.__count1)
            else
                return not (z1 < z2)
            end
        else
            return not (n1.__count1 < n2.__count1)
        end
    end)

    -- 选取第一个点击目标, 设置现在点击到的目标节点和信息
    if not tolua.isnull(clickTargets[1]) then
        -- 设置现在节点
        self:setCurrentNode(clickTargets[1])

        -- 检查锁定状态
        if (self:isNodeLocked(self.currentChild)) then return true end

        -- 更新记录和显示坐标
        self:updateCurrentNodePosAndDisplay()
        return true
    end
    return false
end

-- 触摸移动了
function LayoutUtil:onTouchMoved(touch, event)
    if not tolua.isnull(self.currentChild) then
        -- 检查锁定状态
        if (self:isNodeLocked(self.currentChild)) then return end

        -- 计算差值
        local location = touch:getLocation()
        local mouseMoveDis = cc.pSub(location, lastPoint)
        local layoutMoveDis = mouseMoveToLayoutMove(self.currentChild, mouseMoveDis)
        lastPoint = location      

        -- 更新显示
        self:updateCurrentNodePosAndDisplay(layoutMoveDis.x, layoutMoveDis.y)
    end
end

-- 触摸结束了
function LayoutUtil:onTouchEnded(touch, event)
    if not tolua.isnull(self.currentChild) then
        -- 为键盘调整设置全局元素
        self.curEditorAnchorWorldPoint = nil
        self.label:setPosition(cc.p(0, 0))

        -- 检查锁定状态
        if (self:isNodeLocked(self.currentChild)) then
            return 
        end

        -- 设置配置位置
        self:updateCurrentNodePosAndDisplay(0, 0, false)
    end
end

-- 更新框框显示
function LayoutUtil:setCurrentNode(node)
    savedCurNodeLayoutName = node.layoutUtilName
    self.currentChild = node
    self:setGlobalLayout()
    if (self.currentChild.enableDebugDraw) then
        self.currentChild:enableDebugDraw()
    end
    if (self.lastChild and self.lastChild ~= self.currentChild and self.lastChild.disableDebugDraw) then
        self.lastChild:disableDebugDraw()
        self.lastChild:clearDebugDraw()
    end
    if (self.lastChild ~= self.currentChild) then
        self.lastChild = self.currentChild
    end
    self:updateCurrentNodePosAndDisplay()

    self:setActiveNodeInNodeTreeByUIComposerID(self.currentChild.__uiComposerID)
end

-- 设置全局参数
function LayoutUtil:setGlobalLayout()
    curLayoutObj = self
end

-- 更新记录和显示坐标
function LayoutUtil:updateCurrentNodePosAndDisplay(xOffset, yOffset, isUpdateGlobalPos)
    if (isUpdateGlobalPos == nil) then isUpdateGlobalPos = true end
    if (xOffset == nil) then xOffset = 0 end
    if (yOffset == nil) then yOffset = 0 end

    -- 更新布局位置
    local nodeCurrentX, nodeCurrentY = self:getPos(self.currentChild)
    local newLayoutPos = cc.pAdd(cc.p(nodeCurrentX, nodeCurrentY), cc.p(xOffset, yOffset))
    newLayoutPos = cc.p(math.floor(newLayoutPos.x + 0.5), math.floor(newLayoutPos.y + 0.5))
    self:setPos(self.currentChild, newLayoutPos.x, newLayoutPos.y)
    
    -- 更新坐标标签内容
    local x, y = self:getPos(self.currentChild)
    if (x and y) then
        local size = self.currentChild:getContentSize()
        local layoutFuncName = self.currentChild._layoutFuncName and self.currentChild._layoutFuncName or ""
        self.label:setText(layoutFuncName .. "(" .. x .. "," .. y .. ")" .. "\n" .."size:" .. "(" .. size.width .. "," .. size.height .. ")")
    end

    -- 更新全局坐标信息
    if (isUpdateGlobalPos) then
        local curEditorAnchorLocalPoint = getAnchorPointPos(self.currentChild)
        local parent = self.currentChild:getParent()
        self.curEditorAnchorWorldPoint = parent:convertToWorldSpace(curEditorAnchorLocalPoint)
    end

    -- 更新坐标标签位置
    if (self.curEditorAnchorWorldPoint) then
        self.label:setPosition(cc.pAdd(cc.p(30, 30), self.curEditorAnchorWorldPoint))
    end

    -- 更新名字
    local name
    if (self._uiComposer) then
        name = self._uiComposer:getExposeNameFromLayoutID(self.currentChild.layoutUtilName)
    end
    if (not name) then
        name = self.currentChild.layoutUtilName
    end
    self._nameBox:show()
    self._nameBox:setText(name)
end

-- 关闭保存
function LayoutUtil:closeAndSave()
    if (not self._touchListener) then return end
    
    local dispatcher = self.node:getEventDispatcher()
    dispatcher:removeEventListener(self._touchListener)
    dispatcher:removeEventListener(self._kbListener)

    self._kbListener = nil
    self._touchListener = nil

    self:saveToFile()

    self:clearSelection()
    self.node:removeFromParent()
    self.label:removeFromParent()
    self._nameBox:removeFromParent()

    if (self._uiComposer) then
        self._uiComposer:layoutUtilEditEnd()
    end

    reload_script_file(self.curFilename)
end

-- 保存文件
function LayoutUtil:saveToFile()
    -- if (self._uiComposer) then
    --     for k,v in pairs(self.viewPosInfo) do
    --         if (not self._uiComposer:isNodeExist(k) and (not self._doNotDelete or not self._doNotDelete[k])) then
    --             self.viewPosInfo[k] = nil
    --         end
    --     end
    -- end
    -- self._doNotDelete = nil

    write2ConfigFile(self, self.posInfo)
end

-- 界面关闭
function LayoutUtil:viewDtor()
    self:closeAndSave()
end

-- 获取之前选取的节点
function LayoutUtil:getChoosenNode()
    return self.currentChild
end

-- 检查UIComposer菜单
function LayoutUtil:isAbleToRespondInteraction()
    if (not self._uiComposer or not self._uiComposer:isMenuOpen()) then
        return false
    end
    return true
end

-- 检查是否锁定了节点
function LayoutUtil:isNodeLocked(node)
    if (not node.layoutUtilName) then return false end
    if (not self.viewPosInfo[node.layoutUtilName][4]) then
        return false
    else
        return true
    end
end

-- 获取配置信息
function LayoutUtil:getLayoutConfig(layoutName)
    return self.viewPosInfo[layoutName]
end

-- 设置配置信息
function LayoutUtil:setLayoutConfig(layoutName, config)
    self.viewPosInfo[layoutName] = config
    if (not self._doNotDelete) then self._doNotDelete = {} end
    self._doNotDelete[layoutName] = true
end

-- 在未锁定的节点之间轮回
function LayoutUtil:selectNextUnlockedNode()
    local allNodes = {}
    local unlockedNodes = {}
    local lastEntry = nil
    for i,child in ipairs(self.children) do
        allNodes[child] = child
        if (not self:isNodeLocked(child)) then
            unlockedNodes[child] = child
        end
    end

    local firstNode = next(unlockedNodes)
    if (firstNode) then
        local currentNode = unlockedNodes[self.currentChild]
        if (not currentNode) then
            self:setCurrentNode(firstNode)
        else
            local nextNode = next(unlockedNodes, self.currentChild)
            self:setCurrentNode(nextNode or firstNode)
        end
    else
        self:setCurrentNode(next(allNodes, self.currentChild) or next(allNodes))
    end
end

-- 暴露给UIComposer的接口来选中一个节点
function LayoutUtil:setCurrentNodeByUIComposerID(uiComposerID)
    local isFound = false
    for i,v in ipairs(self.children) do
        if (v.__uiComposerID == uiComposerID) then
            self:setCurrentNode(v)
            isFound = true
            break
        end
    end
    if (not isFound) then
        self:clearSelection()
    end
end

-- 设置节点树里的一个节点
function LayoutUtil:setActiveNodeInNodeTreeByUIComposerID(uiComposerID)
    if (not self._uiComposer) then return end

    self._uiComposer:setCurNodeTreeActiveByUIComposerID(uiComposerID)
end

return LayoutUtil
