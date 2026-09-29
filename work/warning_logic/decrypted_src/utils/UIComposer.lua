-- UI创建工具
-- 根据UI模板创建UI
--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-08-01 14:19:29
]]

local UIComposer = class("UIComposer")

local TEMPLATE_PATH = "utils.UIComposerTemplate"
local PREFIX_NAME = "node_"
local PREFIX_LAYOUT = "layout_"

local AUTOGEN_HEADER_TAG = "程序生成区块开始"
local AUTOGEN_FOOTER_TAG = "程序生成区块结束"
local EXPOSE_COMMENT_TAG = "-- 暴露名字至self"

local ZORDER_PLACEHOLDER = "#{zOrder?}#"
local ZORDER_LINE = "    #{name}#:setLocalZOrder(" .. ZORDER_PLACEHOLDER .. ")"
local EXPOSE_PLACEHOLDER = "#{self._名字?}#"
local EXPOSE_LINE = "    self._" .. EXPOSE_PLACEHOLDER .. " = #{name}#" .. " " .. EXPOSE_COMMENT_TAG


function UIComposer:ctor(node, layoutUtil, moduleName, modulePath, isEdit)
    -- 重载节点dtor实现关闭界面时自动反注册监听
    local nodeDtor = node.dtor
    node.dtor = function(s, ...)
        nodeDtor(s, ...)
        node.dtor = nodeDtor
        self:unregisterEvents()
        -- self:closeNodeTree()
        -- self:closeBlockEditor()
    end

    -- 初始化信息
    self._isEdit = isEdit
    self._node = node
    self._panelName = node.__panel and node.__panel.__cname:gsub("Panel", "") or ""
    self._moduleName = moduleName
    self._viewName = node.__cname
    self._modulePath = modulePath
    self._reloadPath = modulePath .. "." .. self._viewName
    if (self._isEdit) then
        self._filePath = cc.FileUtils:getInstance():fullPathForFilename(self._reloadPath:gsub("%.", "/")..".lua")
        self._templatePath = cc.FileUtils:getInstance():fullPathForFilename(string.gsub(TEMPLATE_PATH, "%.", "/")..".lua")
        self._layoutUtil = layoutUtil
        self._lines = self:getLines()
        self._templates = self:getTemplates(self._templatePath)

        -- 组件列表
        self:initViewComponentInfoFromFile()

        -- 显示节点图
        if (self:isShowNodeTree()) then
            self:showNodeTree()
        end

        -- 阻止面板点击事件
        self:setPanelTouchEnable(false)
    end
    self:registerEvents()
end

-- 注册键盘等事件的反馈
function UIComposer:registerEvents()
    if (self._isEdit) then
        self._kbListener = cc.EventListenerKeyboard:create()
        self._kbListener:registerScriptHandler(function(keycode, evt)
            if (keycode == cc.KeyCode.KEY_DELETE) then
                local currentNodeComposerID = self:getCurrentNodeUIComposerID()
                if (currentNodeComposerID) then
                    self:removeNode(currentNodeComposerID)
                end
            elseif (keycode == cc.KeyCode.KEY_C) then
                self._copyUIComposerID = self:getCurrentNodeUIComposerID()
            elseif (keycode == cc.KeyCode.KEY_V) then
                if (self._copyUIComposerID) then
                    local currentParentUIComposerID = self:getCurrentNodeUIComposerID()
                    self:duplicateNodeAndChangeParent(self._copyUIComposerID, currentParentUIComposerID)
                end
            elseif (keycode == cc.KeyCode.KEY_R) then
                self:refreshUI()
            elseif (keycode == cc.KeyCode.KEY_N) then
                if (UIComposer:getCurNodeTree()) then
                    self:setShowNodeTree(false)
                    self:closeNodeTree()
                else
                    self:setShowNodeTree(true)
                    self:showNodeTree()
                end
            elseif (keycode == cc.KeyCode.KEY_B) then
                self:showNodeBlockEditor()
            end
        end, cc.Handler.EVENT_KEYBOARD_RELEASED)

        self._msListener = cc.EventListenerMouse:create()
        self._msListener:registerScriptHandler(function(evt)
            if (evt:getMouseButton() == 1 and not menu) then
                local clickLocation = evt:getLocation()
                self:showTemplateMenu(clickLocation, function(templateName)
                    self:generateContentFromTemplate(templateName, function(content)
                        self:appendToView(content)
                    end)
                end)

            end
        end, cc.Handler.EVENT_MOUSE_UP)
    end
    
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    if (self._kbListener) then eventDispatcher:addEventListenerWithFixedPriority(self._kbListener, 1) end
    if (self._msListener) then eventDispatcher:addEventListenerWithFixedPriority(self._msListener, 1) end
end

-- 反注册键盘等事件的反馈
function UIComposer:unregisterEvents()
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    if (self._kbListener) then
        eventDispatcher:removeEventListener(self._kbListener)
        self._kbListener = nil
    end
    if (self._msListener) then
        eventDispatcher:removeEventListener(self._msListener)
        self._msListener = nil
    end
end

-- 查找一个Node
function UIComposer:findCodeBlockForANode(uiComposerID)
    local methodContent, methodStartLine, methodLineNum = self:readViewMethod()
    local blockContent = {}
    local blockStartLine = 0
    local blockLineNum = 0
    local isblockNameFound = false
    for i, line in ipairs(methodContent) do
        if (isblockNameFound and line:find(AUTOGEN_FOOTER_TAG)) then 
            table.insert(blockContent, line)
            blockLineNum = blockLineNum + 1
            break
        end
        if (line:find(AUTOGEN_HEADER_TAG) and line:find(uiComposerID)) then 
            isblockNameFound = true
            blockStartLine = i
        end
        if (isblockNameFound) then
            table.insert(blockContent, line)
            blockLineNum = blockLineNum + 1
        end
    end

    return blockContent, methodStartLine + blockStartLine, blockLineNum
end

-- 复制一个Node并替换父节点
function UIComposer:duplicateNodeAndChangeParent(nodeUIComposerID, parentUIComposerID, newChildRecord, isRefershUI)
    if (isRefershUI == nil) then isRefershUI = true end
    if (newChildRecord == nil) then newChildRecord = {} end

    -- 复制自己
    local blockContent = self:findCodeBlockForANode(nodeUIComposerID)
    if (#blockContent > 0) then
        -- 替换自己的ID
        local newID = self:getRandID()
        for i,v in ipairs(blockContent) do
            blockContent[i] = v:gsub(nodeUIComposerID, newID)
        end
        newChildRecord[newID] = true

        -- 替换父节点
        for i,v in ipairs(blockContent) do
            if (v:find("addChildAuto") and v:find(newID)) then
                local nowParentStr = v:split(",")[2]:gsub(" ", "")
                if (parentUIComposerID) then
                    blockContent[i] = v:gsub(nowParentStr, PREFIX_NAME .. parentUIComposerID)
                else
                    blockContent[i] = v:gsub(nowParentStr, "self")
                end
            end
        end

        -- 添加至onInitView
        self:appendToView(blockContent, false)

        -- 复制位置配置
        if (self._layoutUtil) then
            local oldConfig = clone(self._layoutUtil:getLayoutConfig(PREFIX_LAYOUT .. nodeUIComposerID))
            self._layoutUtil:setLayoutConfig(PREFIX_LAYOUT .. newID, oldConfig)
        end

        -- 复制子节点
        local children = self:findChildrenComposerID(nodeUIComposerID)
        if (#children > 0) then
            for i,child in ipairs(children) do
                if (not newChildRecord[child]) then
                    self:duplicateNodeAndChangeParent(child, newID, newChildRecord, false)
                end
            end
        end

        -- 刷新界面
        if (isRefershUI) then
            self:refreshUI()
        end
    end
end

-- 查找一个节点的子节点
function UIComposer:findChildrenComposerID(currentNodeComposerID)
    local chlidrenIDArr = {}
    local methodContent, methodStartLine, methodLineNum = self:readViewMethod()
    for i, line in ipairs(methodContent) do
        if (line:find("addChildAuto") and line:find(currentNodeComposerID)) then
            local lineArr = line:split(",")
            if (#lineArr > 0) then
                local childID = lineArr[3]:gsub(" ", ""):gsub(PREFIX_NAME, "")
                if (childID ~= currentNodeComposerID) then
                    table.insert(chlidrenIDArr, childID)
                end
            end
        elseif (line:find(currentNodeComposerID) and (line:find("addToTab") or line:find("addChild"))) then
            local childID = line:split("(")[2]:split(",")[1]:gsub(" ", "")
            if (childID ~= currentNodeComposerID) then
                table.insert(chlidrenIDArr, childID)
            end
        end
    end
    return chlidrenIDArr
end

-- 替换一段代码
function UIComposer:removeNode(uiComposerID, isWriteToFile)
    if (isWriteToFile == nil) then isWriteToFile = true end

    -- 获取方法内容
    local content, startLine, lineNum = self:findCodeBlockForANode(uiComposerID)

    -- 清除一段代码
    self:replaceContent(startLine - 1, lineNum)

    -- 清除子节点代码
    local childrenIDArr = self:findChildrenComposerID(uiComposerID)
    for i,v in ipairs(childrenIDArr) do
        self:removeNode(v, false)
    end

    -- 根据参数写入文件
    if (isWriteToFile) then
        -- 写入文件
        self:writeToFile()

        -- 刷新界面
        self:refreshUI()
    end
end

-- 增加onInitView方法内容
function UIComposer:appendToView(appendContent, isRefreshView)
    if (isRefreshView == nil) then isRefreshView = true end

    -- 获取方法内容
    local methodContent, methodStartLine, methodLineNum = self:readViewMethod()

    -- 插入方法内容
    self:appendContent(methodStartLine, methodLineNum, appendContent) 

    -- 写入文件
    self:writeToFile()

    -- 刷新界面
    if (isRefreshView) then
        self:refreshUI()
    end
end

-- 替换内容
function UIComposer:replaceContent(startLine, lineNum, replaceContent)
    if (not replaceContent) then replaceContent = {} end
    local removeStart = startLine + 1

    -- 检查内容一致就不替换
    if (lineNum == #replaceContent) then
        local same = true
        local count = 0
        for i=removeStart,removeStart + lineNum - 1 do
            count = count + 1
            if (self._lines[i] ~= replaceContent[count]) then
                same = false
                break
            end
        end 
        if (same) then return false end
    end

    -- 实际做替换
    for i=removeStart,removeStart + lineNum - 1 do
        table.remove(self._lines, removeStart)
    end
    for i,v in ipairs(replaceContent) do
        table.insert(self._lines, startLine + i, v)
    end

    return true
end

-- 插入内容
function UIComposer:appendContent(startLine, lineNum, appendContent, offset)
    local appendStart = startLine

    if (offset and offset >= 0) then
        for i,v in ipairs(appendContent) do
            table.insert(self._lines, appendStart + i + offset, v)
        end
    elseif (offset and offset < 0) then
        for i,v in ipairs(appendContent) do
            table.insert(self._lines, appendStart + lineNum + i + offset, v)
        end
    else
        for i,v in ipairs(appendContent) do
            table.insert(self._lines, appendStart + lineNum + i, v)
        end
    end
end

-- 刷新显示
function UIComposer:refreshUI()
    -- 刷新view脚本并重新打开panel
    reload_script_file_mvc(self._reloadPath)
    mvc.closePanel(self._moduleName, self._panelName)
    UIUtil:setClearBeforeLoadFlag()
    UIUtil:clearDuplicationChecker()
    mvc.openPanel(self._moduleName, self._panelName)
    
    -- 如果不是panel自带view, 重新添加正在编辑的view
    if (self._viewName ~= self._panelName .. "View") then
        local panelName = self._panelName:sub(1,1):lower() .. self._panelName:sub(2) .. "Panel"
        local viewName = self._viewName:sub(1,1):lower() .. self._viewName:sub(2)
        local controllerName = self._moduleName:sub(1,1):lower() .. self._moduleName:sub(2) .. "Controller"
        mvc[controllerName]:showView(mvc[panelName], mvc[viewName])
    end
end

-- 检查一个节点是否存在
function UIComposer:isNodeExist(nodeName)
    local ID = nodeName:gsub(PREFIX_LAYOUT, "")
    if (self._compListByID[ID]) then
        return true
    end
    return false
end

-- 从模板生成内容
function UIComposer:generateContentFromTemplate(templateName, cb)
    self:showInputMenu(templateName, function(inputInfo)
        if (not inputInfo) then return end
        for k,v in pairs(inputInfo) do
            if ((not k:find("?") and v == "") and (not k:find("!") and v == "")) then
                return
            end
        end
        local appendContent = clone(self:getTempateContentByName(templateName))
        self:parseTemplate(templateName, appendContent, inputInfo)
        if (cb) then cb(appendContent) end
    end)
end

-- 生成ID
function UIComposer:getRandID()
    local random = math.random(2147483647)
    local timeNow = os.time()
    return tostring(random) .. "_" .. tostring(timeNow)
end

-- 替换占位符
function UIComposer:parseTemplate(templateName, content, additionInfo)
    local id = self:getRandID()
    local parentName = self:getCurrentSelectedNodeName()

    -- 判断是否不自动添加排版
    local isAutoLayout = true
    if (templateName:find("不自动添加排版")) then
        isAutoLayout = false
    end

    if (isAutoLayout) then
        -- 判断是否有指定插入加入节点位置
        local tabWidth = 0
        local insertLine = nil
        for i=#content,1,-1 do
            local line = content[i]
            local wordStart = line:find("#{addChildLine}#")
            if (wordStart) then
                tabWidth = wordStart
                insertLine = i
                table.remove(content, i)
            end
        end
        local tabString = tabWidth and string.rep(" ", tabWidth - 5) or ""

        -- 可选添加设置zOrder
        local zorder = additionInfo[ZORDER_PLACEHOLDER]
        if (zorder and zorder ~= "") then
            local zOrderLine = tabString .. ZORDER_LINE
            if (insertLine) then
                table.insert(content, insertLine, zOrderLine)
            else
                table.insert(content, zOrderLine)
            end
        end

        -- 添加自动标记
        local idLine =          tabString .. "    #{name}#.__uiComposerID = \"#{uiComposerID}#\""
        local addChildLine =    tabString .. self:getAddChildLineForNode(parentName)
        if (insertLine) then
            table.insert(content, insertLine, idLine)
            table.insert(content, insertLine + 1, addChildLine)
        else
            table.insert(content, idLine)
            table.insert(content, addChildLine)
        end

        -- 可选添加暴露名字
        local exposeName = additionInfo[EXPOSE_PLACEHOLDER]
        if (exposeName and exposeName ~= "") then
            local exposeNameLine = tabString .. EXPOSE_LINE
            if (insertLine) then
                table.insert(content, insertLine, exposeNameLine)
            else
                table.insert(content, exposeNameLine)
            end
        end
    end

    -- 添加头标记和脚标记
    local header =          "------" .. AUTOGEN_HEADER_TAG .. " #{name}#-------"
    table.insert(content, 1, header)
    local footer =          "------" .. AUTOGEN_FOOTER_TAG .. " #{name}#-------"
    table.insert(content, footer)

    -- 固定参数替换
    for i=#content,1,-1 do
        local v = content[i]
        -- 检查是否去除行
        local removeLine = false
        if (v:find("!")) then
            local placeholders = self:getAllPlaceholders(v)
            for i,placeholder in ipairs(placeholders) do
                if (placeholder:find("input_")) then
                    local value = additionInfo[placeholder]
                    if (not value or value == "") then
                        removeLine = true
                        break
                    end
                end
            end
        end

        -- 判断是否需要删除行
        if (removeLine) then
            table.remove(content, i)
        else
            -- 替换一些更多的参数, 目前包括输入菜单读入的参数
            for placeholderRaw,value in pairs(additionInfo) do
                local placeholder = placeholderRaw:gsub("%?", "%%?"):gsub("%.", "%%.")
                v = v:gsub(placeholder, value)
            end

            -- 替换一些固定参数
            v = v:gsub("#{modulePath}#", self._modulePath)
            v = v:gsub("#{name}#", PREFIX_NAME .. id)
            v = v:gsub("#{uiComposerID}#", id)
            v = v:gsub("#{currentParent}#", parentName)
            v = v:gsub("#{layoutID}#", PREFIX_LAYOUT .. id)

            content[i] = v
        end
    end
end

-- 取出一行中所有的占位符
function UIComposer:getAllPlaceholders(line)
    local placeholders = {}
    local wordStart = 0
    repeat
        wordStart = line:find("#{", wordStart + 1)
        if (wordStart) then
            local wordEnd = line:find("}#", wordStart + 1) + 1
            local placeholder = line:sub(wordStart, wordEnd)
            table.insert(placeholders, placeholder)
            wordStart = wordEnd
        end
    until (wordStart == nil)
    return placeholders
end

-- 从ID找到别名
function UIComposer:getExposeNameFromLayoutID(layoutID)
    local uiComposerID = layoutID:gsub(PREFIX_LAYOUT, "")
    local info = self._compListByID[uiComposerID]
    if (info) then
        return info.exposeName
    end
end

-- 取消掉面板的点击关闭
function UIComposer:setPanelTouchEnable(b)
    -- 阻止点击关闭
    local panelName = self._panelName:sub(1,1):lower() .. self._panelName:sub(2) .. "Panel"
    local panel = mvc[panelName]
    if (panel) then
        panel.ui:setTouchEnable(b)        
    end
end

-- 处理特殊类型的子节点添加
function UIComposer:getAddChildLineForNode(nodeName)
    local nodeID = nodeName:gsub(PREFIX_NAME, "")
    local nodeInfo = self._compListByID[nodeID]
    if (nodeInfo and nodeInfo.typeName:gsub(" ", "") == "UI.ScrollView") then
        return "    addChildAuto(self._layoutUU, #{currentParent}#, #{name}#, \"#{layoutID}#\", nil, nil, \"addInnerNode\")"
    end

    -- 默认子节点值
    return "    addChildAuto(self._layoutUU, #{currentParent}#, #{name}#, \"#{layoutID}#\")"
end





















------------------------------- 弹出菜单相关
-- 显示节点内容编辑器
local curBlockEditor = nil
function UIComposer:getCurBlockEditor() return curBlockEditor end
function UIComposer:showNodeBlockEditor()
    if (curBlockEditor) then return end

    -- 获取方法内容
    local uiComposerID = self:getCurrentNodeUIComposerID()
    if (not uiComposerID) then return end
    local content, startLine, lineNum = self:findCodeBlockForANode(uiComposerID)
    
    -- 从内容中去掉首位标记
    local strippedContent = {}
    for i=2,#content - 1 do
        strippedContent[i - 1] = content[i]
    end

    -- 吊起编辑器
    require "utils.UIComposerBlockEditor"
    local nodeTree = UIComposerBlockEditor:create(strippedContent, function(newContent, isResultValid)
        curBlockEditor = nil

        if (not isResultValid) then return end
        local content, startLine, lineNum = self:findCodeBlockForANode(uiComposerID)
        if (self:replaceContent(startLine, lineNum - 2, newContent)) then
            self:writeToFile()
            self:refreshUI()
        end
    end)
    nodeTree:center(150, 0)
    curBlockEditor = nodeTree

    local runningScene = cc.Director:getInstance():getRunningScene()
    runningScene:addChild(nodeTree, 100001)
end

-- 显示节点树
local curNodeTree = nil
local isShowNodeTree = false
function UIComposer:isShowNodeTree() return isShowNodeTree end
function UIComposer:setShowNodeTree(b) isShowNodeTree = b end
function UIComposer:getCurNodeTree() return curNodeTree end
function UIComposer:setCurNodeTree(nodeTree) curNodeTree = nodeTree end 
function UIComposer:setCurNodeTreeActiveByUIComposerID(uiComposerID)
    if (curNodeTree) then
        curNodeTree:setCellActiveByUIComposerID(uiComposerID)
    end
end
function UIComposer:showNodeTree()
    if (curNodeTree) then return end

    require "utils.UIComposerNodeTree"
    local nodeTree = UIComposerNodeTree:create(self._compListByTree, self:getCurrentNodeUIComposerID(), function(compInfo)
        self:setCurrentNodeByUIComposerID(compInfo.uiComposerID)
    end)
    nodeTree:centerLeft(0)
    curNodeTree = nodeTree

    local runningScene = cc.Director:getInstance():getRunningScene()
    runningScene:addChild(nodeTree, 100000)
end

-- 显示模板菜单
local curTemplateMenu = nil
function UIComposer:showTemplateMenu(location, cb)
    if (curTemplateMenu) then return end

    local menuContent = self:getTemplateNames()

    require "utils.UIComposerContextMenu"
    local menu = UIComposerContextMenu:create(UIComposerContextMenu.TYPE.LABEL, menuContent, function(result, isResultValid)
        curTemplateMenu = nil

        if (not isResultValid) then return end
        local templateName = menuContent[result]
        if (cb) then cb(templateName) end
    end)
    menu:leftUp(location.x, location.y)
    curTemplateMenu = menu

    local runningScene = cc.Director:getInstance():getRunningScene()
    runningScene:addChild(menu, 99999)
end

-- 显示输入菜单
local curInputMenu = nil
function UIComposer:showInputMenu(templateName, cb)
    if (curInputMenu or not templateName) then return end
    
    -- 生成内容
    local dupCheck = {}
    local menuContent = {}
    local templateContent = self:getTempateContentByName(templateName)
    for i,line in ipairs(templateContent) do
        -- 一行里面可能有多个输入, 都检查
        local wordStart = line:find("#{input_", 0)
        while (wordStart) do
            local worldEnd = line:find("}#", wordStart) + 1
            local placeholder = line:sub(wordStart, worldEnd)
            if (not dupCheck[placeholder]) then
                table.insert(menuContent, placeholder)
                dupCheck[placeholder] = true
            end
            wordStart = line:find("#{input_", worldEnd)
        end
    end
    table.insert(menuContent, EXPOSE_PLACEHOLDER)
    table.insert(menuContent, ZORDER_PLACEHOLDER)

    -- 根据内容生成菜单
    require "utils.UIComposerContextMenu"
    local runningScene = cc.Director:getInstance():getRunningScene()
    local menu = UIComposerContextMenu:create(UIComposerContextMenu.TYPE.INPUT, menuContent, function(result, isResultValid)
        curInputMenu = nil

        if (not isResultValid) then return end
        if (cb) then cb(result) end
    end)
    menu:center()
    runningScene:addChild(menu, 99999)
    curInputMenu = menu
end

-- 输入菜单和模板菜单是否打开(UILayoutUtil使用, 避免点击冲突)
function UIComposer:isMenuOpen()
    return curInputMenu or curTemplateMenu or curBlockEditor
end

-- 关闭节点树
function UIComposer:closeNodeTree()
    local nodeTree = self:getCurNodeTree()
    if (not tolua.isnull(nodeTree)) then
        nodeTree:closeMenu()
        self:setCurNodeTree(nil)
    end
end

-- 关闭编辑器
function UIComposer:closeBlockEditor()
    local blockEditor = self:getCurBlockEditor()
    if (not tolua.isnull(blockEditor)) then
        blockEditor:removeFromParent()
    end
    curBlockEditor = nil
end
------------------------------- END 弹出菜单相关







































-------------------- 从文件读入输出
function UIComposer:getTemplates(templatePath)
    -- 获取文件所有行
    local templates = {}
    local block = nil
    local f = io.open(templatePath)
    local blockFound = false
    for line in f:lines() do
        -- 去掉注释前缀和空格
        line = line:sub(3)
        if (line:sub(1, 1) == " ") then
            line = line:sub(2)
        end

        -- 生成模板
        if (blockFound and line:find("EndTemplate:")) then
            blockFound = false
            table.insert(templates, block)
        end
        if (blockFound) then
            local processedLine = string.format("    %s", line)
            table.insert(block.content, processedLine)
        end
        if (line:find("Template:")) then
            block = {}
            block.name = line:gsub("Template:", ""):gsub("-", ""):gsub(" ", "")
            block.content = {}
            blockFound = true
        end
    end
    io.close(f)
    return templates
end

function UIComposer:getTempateContentByName(name)
    for i,v in ipairs(self._templates) do
        if (v.name == name) then
            return v.content
        end
    end
end

function UIComposer:getTemplateNames()
    local menuContent = {}
    for i,v in ipairs(self._templates) do
        table.insert(menuContent, v.name)
    end
    return menuContent
end

-- 从文件中读取一些数据
function UIComposer:initViewComponentInfoFromFile()
    self._compListArr = {}
    self._compListByID = {}
    self._compListByTree = {}
    local tempNode = nil
    local viewContent = self:readViewMethod()
    for i,line in ipairs(viewContent) do
        local subStart = tempNode and line:find(tempNode.name .. "_sub.*") or nil
        if (line:find(AUTOGEN_HEADER_TAG) or (subStart and line:find("create"))) then
            -- 添加节点
            if (tempNode and not tempNode.isInList) then
                tempNode.isInList = true
                table.insert(self._compListArr, tempNode)
            end

            -- 创建新记录节点
            tempNode = {}
            if (subStart) then
                tempNode.name = line:split("=")[1]:gsub("local", ""):gsub(" ", "")
            else
                tempNode.name = line:gsub(" ", ""):gsub("-",""):gsub(AUTOGEN_HEADER_TAG, "")
            end
        end

        -- 查找别名
        if (tempNode and line:find(EXPOSE_COMMENT_TAG)) then
            tempNode.exposeName = line:gsub(EXPOSE_COMMENT_TAG, ""):gsub("self%._", ""):gsub("=", ""):gsub(tempNode.name, ""):gsub(" ", "")
        end

        -- 查找节点类型
        if (tempNode and line:gsub(" ", ""):find(tempNode.name .. "=")) then
            local typeName = line:split("=")[2] or "error"
            if (typeName:find(":create")) then
                typeName = typeName:split(":create")[1]
            elseif (typeName:find(".new")) then
                typeName = typeName:split(".new")[1]
            end
            tempNode.typeName = typeName:gsub(" ", "")
        end

        -- 查找父节点
        if (tempNode and line:find("addChildAuto") and line:find(tempNode.name)) then
            tempNode.parent = "error"
            local rawStringArr = line:split(",")
            if (#rawStringArr > 1) then
                tempNode.parent = rawStringArr[2]:split(",")[1]:gsub(" ", "")
            end
        end

        -- 查找UIComposerID
        if (tempNode and line:find("uiComposerID") and line:find(tempNode.name .. "%.")) then
            tempNode.uiComposerID = nil
            local rawStringArr = line:split("=")
            if (#rawStringArr > 1) then
                tempNode.uiComposerID = rawStringArr[2]:gsub(" ", ""):gsub("\"", "")
            end
        end
    end
    if (tempNode and not tempNode.isInList) then
        tempNode.isInList = true
        table.insert(self._compListArr, tempNode)
    end

    -- 转换成Table
    for i,v in ipairs(self._compListArr) do
        if (v.uiComposerID) then
            self._compListByID[v.uiComposerID] = v
        end
    end

    -- 转换成Tree
    self._compListByTree = {}
    self._compListByTree.children = {}
    for i,v in ipairs(self._compListArr) do
        if (v.parent == "self") then
            table.insert(self._compListByTree.children, v)
        else
            if (v.parent) then
                local parent = self._compListByID[v.parent:gsub(PREFIX_NAME, "")]
                if (parent) then
                    if (not parent.children) then
                        parent.children = {}
                    end
                    table.insert(parent.children, v)
                end
            end
        end
    end
end

-- 获取文件所有行
function UIComposer:getLines()
    -- 获取文件所有行
    local lines = {}
    local f = io.open(self._filePath)
    local i = 0
    for line in f:lines() do
        i = i + 1
        lines[#lines + 1] = line
    end
    io.close(f)
    return lines
end

-- 数个数
function UIComposer:countWordAppearance(line, words)
    local count = 0
    for i,word in ipairs(words) do
        local wordStart = 0
        local wordEnd = 0
        repeat
            wordStart, wordEnd = line:find(word, wordStart + 1)
            local isSingleWord
            if (wordStart and wordStart > 1 and line:sub(wordStart - 1, wordStart - 1):find("[%w]") or
               (wordEnd and wordEnd < line:len() and line:sub(wordEnd + 1, wordEnd + 1):find("[%w]"))) 
            then
                isSingleWord = false
            else
                isSingleWord = true
            end 
            if (wordStart and isSingleWord) then
                count = count + 1
            end
        until (endStart == nil)
    end
    return count
end

-- 读取已有数据
function UIComposer:readViewMethod()
    local methodContent = {}
    local methodStartLine = 0
    local methodLineNum = 0
    local endCounter = 1
    local isMethodNameFound = false
    for i, line in ipairs(self._lines) do
        if (isMethodNameFound) then 
            -- 滤过所有方法中的以end结尾的区块
            endCounter = endCounter + self:countWordAppearance(line, {"if", "do", "function"})
            endCounter = endCounter - self:countWordAppearance(line, {"end"})
            if (endCounter <= 0) then
                break
            end
        end
        if (isMethodNameFound) then
            table.insert(methodContent, line)
            methodLineNum = methodLineNum + 1
        end
        if (line:find(self._viewName .. ":" .. "onInitView")) then 
            isMethodNameFound = true
            methodStartLine = i
        end
    end
    return methodContent, methodStartLine, methodLineNum
end

-- 写入文件
function UIComposer:writeToFile()
    local stringContent = ""
    for i,v in ipairs(self._lines) do
        stringContent = stringContent .. v .. "\n"
    end
    io.writefile(self._filePath, stringContent)
end
-------------------- END 从文件读入输出




































--------------------- UILayoutUtil交互
-- LayoutUtil编辑结束
function UIComposer:layoutUtilEditEnd()
    -- 阻止面板点击事件
    self:setPanelTouchEnable(true)
    self:closeNodeTree()
    self:closeBlockEditor()
end

-- 获取现在选取节点的UIComposerID
function UIComposer:getCurrentNodeUIComposerID()
    local currentNode = self:getCurrentNode()
    if (currentNode and currentNode.__uiComposerID) then
        return currentNode.__uiComposerID
    end
end

-- 获取现在父节点
function UIComposer:getCurrentSelectedNodeName()
    local currentNodeUIComposerID = self:getCurrentNodeUIComposerID()
    if (currentNodeUIComposerID) then
        local nodeInfo = self._compListByID[currentNodeUIComposerID]
        if (nodeInfo) then
            return nodeInfo.name
        else
            return "self"
        end
    else
        return "self"
    end
end

-- 获取现在选中节点
function UIComposer:getCurrentNode()
    if (not self._layoutUtil) then return end
    return self._layoutUtil:getChoosenNode()
end

-- 设置现在选中节点
function UIComposer:setCurrentNodeByUIComposerID(uiComposerID)
    if (not self._layoutUtil) then return end
    return self._layoutUtil:setCurrentNodeByUIComposerID(uiComposerID) 
end
--------------------- END UILayoutUtil交互

return UIComposer