--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2019-08-19 23:20:13
]]
UIComposerBlockEditor = class("UIComposerBlockEditor", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

function UIComposerBlockEditor:ctor(content, cb)
    UIComposerBlockEditor.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        0,
        0
    )
    self._cb = cb
    self._content = content

    -- 初始化界面
    self:init()

    -- 添加按键监听
    self._kbListener = cc.EventListenerKeyboard:create()
    self._kbListener:registerScriptHandler(function(keycode, evt)
        if (keycode == cc.KeyCode.KEY_ENTER) then
            self:closeMenu()
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

function UIComposerBlockEditor:dtor()
    if (self._kbListener) then
        local dispatcher = self:getEventDispatcher()
        dispatcher:removeEventListener(self._kbListener)
        self._kbListener = nil
    end
    UIComposerBlockEditor.super.dtor(self)
end

function UIComposerBlockEditor:onInitView()
    -- 菜单宿主
    local width = 800
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
    local cellHeight = 30
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
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
            table.insert(self._menuCells, cell)

            -- 创建内容
            local editBox = UI.EditBox:create(cellWidth, cellHeight)
            editBox:init(actualText, cc.EDITBOX_INPUT_MODE_SINGLELINE, nil, 5, 5)
            editBox:setName("editBox")
            editBox:setFontSize(25)
            editBox:setPlaceholderFontSize(25)
            editBox:setPlaceholderFontColor({r = 200, g = 200, b = 200})
            editBox:leftBottom(0, 0)
            editBox._editBox:setSwallowTouches(false)
            editBox:enableDebugDraw(UI.RED)
            cell:addChild(editBox)
        end
        cell:setTag(luaIdx)

        -- 更新编辑文字
        local editBox = cell:getChildByName("editBox")
        if (editBox) then
            -- 更新回调方法
            editBox:setReturnCallback(function(text)
                self._content[luaIdx] = text
            end)
            editBox:setText(actualText)
        end

        return cell
    end)

    self._menu:onUpdateCellNumbers(function ()
        return #self._content
    end)
    host:addChild(self._menu)
    self._menu:reloadData()
end


function UIComposerBlockEditor:closeMenu(isResultValid)
    if (isResultValid == nil) then isResultValid = true end
    if (self._cb) then
        self._cb(self._content, isResultValid)
    end
    self:removeFromParent()
end