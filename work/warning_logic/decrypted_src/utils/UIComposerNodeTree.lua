--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2019-08-02 15:55:21
]]
UIComposerNodeTree = class("UIComposerNodeTree", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local CELL_HEIGHT = 20

function UIComposerNodeTree:ctor(nodeTree, activeID, cb)
    UIComposerNodeTree.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        0,
        0
    )
    self._cb = cb
    self._nodeTree = nodeTree

    -- 初始化界面
    self:init()

    -- 设置初始激活
    self:setCellActiveByUIComposerID(activeID)

    -- 添加按键监听
    self._kbListener = cc.EventListenerKeyboard:create()
    self._kbListener:registerScriptHandler(function(keycode, evt)
        if (keycode == cc.KeyCode.KEY_COMMA) then
            if (self._activeIdx > 1) then
                self:activateCellAndCallbackByIdx(self._activeIdx - 1)
            end
        elseif (keycode == cc.KeyCode.KEY_PERIOD) then
            if (self._activeIdx < self._flattenNum) then
                self:activateCellAndCallbackByIdx(self._activeIdx + 1)
            end
        end
    end, cc.Handler.EVENT_KEYBOARD_RELEASED)

    -- 添加监听
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithFixedPriority(self._kbListener, -10)
end

function UIComposerNodeTree:dtor()
    if (self._kbListener) then
        local dispatcher = self:getEventDispatcher()
        dispatcher:removeEventListener(self._kbListener)
        self._kbListener = nil
    end
    UIComposerNodeTree.super.dtor(self)
    -- reload_script_file("utils.UIComposerNodeTree")
end

function UIComposerNodeTree:onInitView()
    -- 菜单宿主
    local width = 300
    local height = 640
    local host = UI.Layout:create()
    host:init()
    host:leftBottom(0, 0)
    host:setSize(width, height)
    self:setSize(width, height)
    self:addChild(host)

    -- 菜单背景
    local bg = UI.Image9:create()
    bg:init("ui_scale9image_white.png", CCRectMake(0,0,1,1), cc.size(width, height))
    bg:setOpacity(40)
    bg:leftBottom(0, 0)
    host:addChild(bg)

    -- 平铺树
    self:updateFlatTree()
    
    -- 菜单
    self._allCells = {}
    local cellWidth = width
    local cellHeight = CELL_HEIGHT
    self._menu = UI.TableView:create({}, cellWidth , height)
    self._menu:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._menu:leftBottom(0, 0)
    self._menu:setDelegate()
    self._menu:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._menu:setBounceable(true) 
    self._menu:init()
    self._menu:enableDebugDraw()
    self._menu:onUpdateCellSize(function ()
        return cellWidth, cellHeight
    end) 
    self._menu:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        -- local displayText = self._content[luaIdx]
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
            table.insert(self._allCells, cell)

            -- 空背景
            local frame = UI.Component:create()
            frame:init()
            frame:leftBottom(0, 0)
            frame:setSize(cellWidth, cellHeight)
            frame:setName("frame")
            cell:addChild(frame)

            -- 创建内容
            local label = UI.Text:create()
            label:init("", UI.FONT_BOLD, 15, {r = 255, g = 255, b = 255})
            label:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -1))
            label:leftBottom(0, 0)
            label:setName("label")
            cell:addChild(label)
        end
        cell:setTag(luaIdx)

        local label = cell:getChildByName("label")
        if (label) then
            label:setText(self._flattenTree[luaIdx].treeDisplayName)
            if (self._activeIdx == luaIdx) then
                label:setFontColor({r = 255, g = 0, b = 0})
            else
                label:setFontColor({r = 255, g = 255, b = 255})
            end
        end

        local frame = cell:getChildByName("frame")
        if (frame) then
            if (self._activeIdx == luaIdx) then
                frame:enableDebugDraw(UI.RED)
            else
                frame:disableDebugDraw()
                frame:clearDebugDraw()
            end
        end
        return cell
    end)
    self._menu:onUpdateCellNumbers(function ()
        return self._flattenNum
    end)
    self._menu:onTableCellTouched(function(table, cell)
        local luaIdx = cell:getIdx() + 1
        self:activateCellAndCallbackByIdx(luaIdx)
    end)
    host:addChild(self._menu)
    self._menu:reloadData()
end

-- 平铺树
function UIComposerNodeTree:updateFlatTree()
    self._flattenTree = {}
    self._flattenNum = 0
    local function treeFlatter(curNode, flatArr)
        if (not curNode.treeDisplayPrefix) then
            curNode.treeDisplayPrefix = ""
            curNode.treeDisplayName = "Root"
        end
        table.insert(flatArr, curNode)
        self._flattenNum = self._flattenNum + 1
        if (curNode and curNode.children and #curNode.children > 0) then
            for i,v in ipairs(curNode.children) do
                v.treeDisplayPrefix = curNode.treeDisplayPrefix .. " | "
                v.treeDisplayName = v.treeDisplayPrefix .. (v.exposeName or v.uiComposerID)
                treeFlatter(v, flatArr)
            end
        end
    end
    treeFlatter(self._nodeTree, self._flattenTree)
end

-- 激活某CELL
function UIComposerNodeTree:setCellActiveByUIComposerID(uiComposerID)
    local found = false
    for i,v in ipairs(self._flattenTree) do
        if (v.uiComposerID == uiComposerID) then
            self._activeIdx = i
            found = true
            break
        end
    end
    if (not found) then
        self._activeIdx = nil
    end
    self._menu:reloadData()
end

-- 某CELL被激活并调用回调
function UIComposerNodeTree:activateCellAndCallbackByIdx(idx)
    self._activeIdx = idx
    self._menu:reloadData()
    if (self._cb) then self._cb(self._flattenTree[idx]) end
end

function UIComposerNodeTree:closeMenu()
    self:removeFromParent()
end




            