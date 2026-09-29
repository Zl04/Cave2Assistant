--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2019-08-02 15:55:21
]]
UIComposerContextMenu = class("UIComposerContextMenu", UI.HWBtnComponent)

UIComposerContextMenu.TYPE = {
    LABEL = 1,
    INPUT = 2
}

-- 资源
local COM_RES_LIST = {
}

local CELL_HEIGHT = 40

function UIComposerContextMenu:ctor(type, content, cb)
    UIComposerContextMenu.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        0,
        0
    )
    self._cb = cb
    self._content = content

    -- 处理现实内容
    self._displayContent = {}
    for k,v in pairs(self._content) do
        self._displayContent[k] = clone(v):gsub("#{", ""):gsub("}#", ""):gsub("input_", "")
    end

    -- 处理菜单类型
    self._type = type or UIComposerContextMenu.TYPE.LABEL
    if (self._type == UIComposerContextMenu.TYPE.INPUT) then
        self._result = {}
        for i,v in ipairs(self._content) do
            self._result[v] = ""
        end
    elseif (self._type == UIComposerContextMenu.TYPE.LABEL) then
        self._result = nil
    end

    -- 初始化界面
    self:init()

    -- 添加按键监听
    self._kbListener = cc.EventListenerKeyboard:create()
    self._kbListener:registerScriptHandler(function(keycode, evt)
        if (keycode == cc.KeyCode.KEY_TAB) then
            if (self._type == UIComposerContextMenu.TYPE.INPUT) then
                local size = #self._content
                for i,placeholder in ipairs(self._content) do
                    if (self._result[placeholder] == "") then
                        -- 先滚动到合适的位置
                        self._menu:scrollRectToTop({origin = {x = 0, y = (size - i + 1) * CELL_HEIGHT}, size = {width = 0, height = CELL_HEIGHT}})

                        -- 下一帧激活对应的输入框
                        performWithDelay(self, function()
                            for _,cell in ipairs(self._menuCells) do
                                local luaIdx = cell:getTag()
                                local editBox = cell:getChildByName("editBox")
                                if (editBox and luaIdx == i) then
                                    editBox:openKeyboard()
                                end
                            end
                        end, 0.01)
                        break
                    end
                end
            end
        elseif (keycode == cc.KeyCode.KEY_ENTER) then
            if (self.closeMenu) then
                self:closeMenu()
            end
        elseif (keycode == cc.KeyCode.KEY_GRAVE) then
            if (self.closeMenu) then
                self:closeMenu(false)
            end
        end
    end, cc.Handler.EVENT_KEYBOARD_RELEASED)

    -- 添加监听
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithFixedPriority(self._kbListener, -10)
end

function UIComposerContextMenu:dtor()
    if (self._kbListener) then
        local dispatcher = self:getEventDispatcher()
        dispatcher:removeEventListener(self._kbListener)
        self._kbListener = nil
    end
    UIComposerContextMenu.super.dtor(self)
end

function UIComposerContextMenu:onInitView()
    -- 菜单宿主
    local width = 400
    local height = 640
    local host = UI.Layout:create()
    host:init()
    host:leftBottom(0, 0)
    host:setSize(width, height)
    host:setTouchEnable(true)
    host:setInterceptTouches(true)
    host:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
        self:closeMenu()
    end)
    self:setSize(width, height)
    self:addChild(host)

    -- 菜单背景
    local bg = UI.Image9:create()
    bg:init("ui_scale9image_white.png", CCRectMake(0,0,1,1), cc.size(width, height))
    bg:setOpacity(40)
    bg:leftBottom(0, 0)
    host:addChild(bg)

    -- 菜单
    local cellWidth = width
    local cellHeight = CELL_HEIGHT
    self._menuCells = {}
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
        local actualText = self._content[luaIdx]
        local displayText = self._displayContent[luaIdx]
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
            table.insert(self._menuCells, cell)

            local cellFrame = UI.Component:create()
            cellFrame:init()
            cellFrame:setSize(cellWidth, cellHeight)
            cellFrame:leftBottom(0, 0)
            cell:addChild(cellFrame)

            -- 创建内容
            if (self._type == UIComposerContextMenu.TYPE.INPUT) then
                local editBox = cc.EditBox:create(cc.size(cellWidth, cellHeight), "IntentiallyInvalidFileName")
                editBox:setName("editBox")
                editBox:setFontSize(30)
                editBox:setPlaceholderFontSize(30)
                editBox:setPlaceholderFontColor({r = 200, g = 200, b = 200})
                editBox:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
                editBox:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
                editBox:setPosition(0, 0)
                editBox:setAnchorPoint(0, 0)
                cell:addChild(editBox)
            elseif (self._type == UIComposerContextMenu.TYPE.LABEL) then
                local button = UI.Button:create()
                button:init()
                button:setName("button")
                button:setText(displayText)
                button:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_255_255_255)
                button:setSize(cellWidth, cellHeight)
                button:leftBottom(0, 0)
                button:setTouchEnable(true)
                button:setSwallowTouches(false)
                button:enableDebugDraw(UI.RED)
                button:addEventListener(UI.Event.BUTTON_CLICK, self, function()
                    self._result = luaIdx
                    self:closeMenu()
                end)
                cell:addChild(button)
            end
        end
        cell:setTag(luaIdx)

        -- 更新编辑文字
        local editBox = cell:getChildByName("editBox")
        if (editBox) then
            editBox:registerScriptEditBoxHandler(function(eventType)
                if eventType == "return" then
                    if (not self._result) then self._result = {} end
                    self._result[actualText] = editBox:getText()
                end
            end)

            -- 设置真实值
            if (not self._result) then self._result = {} end
            editBox:setText(self._result[actualText])

            -- 设置默认值
            editBox:setPlaceHolder(displayText)
            if (displayText:find("%?") or displayText:find("%!")) then
                editBox:setPlaceholderFontColor({r = 200, g = 200, b = 200})
            else
                editBox:setPlaceholderFontColor({r = 255, g = 0, b = 0})
            end
        end

        -- 更新按钮文字
        local button = cell:getChildByName("button")
        if (button) then
            button:setText(displayText)
        end

        return cell
    end)

    self._menu:onUpdateCellNumbers(function ()
        return #self._content
    end)
    host:addChild(self._menu)
    self._menu:reloadData()
end


function UIComposerContextMenu:closeMenu(isResultValid)
    if (isResultValid == nil) then isResultValid = true end
    if (self._cb) then
        self._cb(self._result, isResultValid)
    end
    for i,v in ipairs(self._menuCells) do
        local editBox = v:getChildByName("editBox")
        if (not tolua.isnull(editBox)) then
            editBox:removeFromParent()
        end
    end
    self:removeFromParent()
end




            