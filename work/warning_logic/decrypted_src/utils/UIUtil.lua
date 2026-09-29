-- UIUtil.lua
local LayoutUtil = require 'app.ui.UILayoutUtils'
local UIComposer = require 'utils.UIComposer'
UIUtil = UIUtil or {}

local viewNameUIComposerTable = {}
local editingViewDupChecker = {}
local currentEditingViewName = nil
local forceEditMode = false

function UIUtil:init()
    -- 添加自动切换编辑模式相关的信息
    if (CONFIG_SHOW_DEBUG_PANEL) then
        local kbListener = cc.EventListenerKeyboard:create()
        kbListener:registerScriptHandler(function(keycode, evt)
            if (keycode == cc.KeyCode.KEY_0) then
                self:updateNextViewEditable()
            elseif (keycode == cc.KeyCode.KEY_9) then
                self:clearEdit()
            elseif (keycode == cc.KeyCode.KEY_MINUS) then
                self:toggleForceOn()
            end
        end, cc.Handler.EVENT_KEYBOARD_RELEASED)
        local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
        if (kbListener) then eventDispatcher:addEventListenerWithFixedPriority(kbListener, 1) end
    end
end
UIUtil:init()

-- 切换强制开启编辑模式
function UIUtil:toggleForceOn()
    forceEditMode = not forceEditMode
end

-- 按键0的编辑切换器
function UIUtil:updateNextViewEditable()
    -- 选择下一个编辑view
    forceEditMode = false
    currentEditingViewName = next(viewNameUIComposerTable, currentEditingViewName) or next(viewNameUIComposerTable)
    if (not currentEditingViewName) then return end
    local uiComposerToUse = viewNameUIComposerTable[currentEditingViewName]
    if (not uiComposerToUse) then return end

    self:refreshUI(uiComposerToUse)
end

-- 按键9的清空编辑器
function UIUtil:clearEdit()
    -- 清除编辑view
    local uiComposerToUse = currentEditingViewName and viewNameUIComposerTable[currentEditingViewName] or viewNameUIComposerTable[next(viewNameUIComposerTable)]
    currentEditingViewName = nil
    forceEditMode = false

    self:refreshUI(uiComposerToUse)
    self._clearBeforeLoad = true
end

-- 包裹一个通过UIComposer刷新界面的方法
function UIUtil:refreshUI(uiComposerToUse)
    -- 清空编辑器记录, 然后重新加载编辑界面来填充新的编辑器列表
    if (not uiComposerToUse) then return end

    viewNameUIComposerTable = {}
    uiComposerToUse:refreshUI()
end

-- 清除同名View检查器
function UIUtil:clearDuplicationChecker()
    editingViewDupChecker = {}
end

-- 设置下次清空
function UIUtil:setClearBeforeLoadFlag()
    self._clearBeforeLoad = true
end

function UIUtil:createAutoUILayoutyhj(viewName,isEdit)
    return LayoutUtil.new(viewName, 'app.scene.mainscene.LayoutPosConfig', isEdit)
end

function UIUtil:createAutoEdit(node, filePath, moduleName, isEdit)
    -- 检查按键0的编辑强制切换值
    if (CONFIG_SHOW_DEBUG_PANEL and node.__cname == currentEditingViewName and not editingViewDupChecker[node.__cname]) then
        editingViewDupChecker[node.__cname] = true
        isEdit = true
    end

    -- 检查强制编辑
    if (CONFIG_SHOW_DEBUG_PANEL and forceEditMode) then
        editingViewDupChecker[node.__cname] = true
        isEdit = true
    end

    -- 创建排版器
    local uiLayoutUtil = LayoutUtil.new(node, filePath .. "." .. moduleName .. "PosConfig", isEdit)

    -- 创建组件创建器
    if (CONFIG_SHOW_DEBUG_PANEL) then
        if (self._clearBeforeLoad) then 
            viewNameUIComposerTable = {}
            self._clearBeforeLoad = false
        end
        uiLayoutUtil._uiComposer = UIComposer.new(node, uiLayoutUtil, moduleName, filePath, isEdit)
        viewNameUIComposerTable[node.__cname] = uiLayoutUtil._uiComposer
    end
    return uiLayoutUtil
end

function UIUtil:createAutoUILayout(viewOrName, configPath, isEdit)
    return LayoutUtil.new(viewOrName, configPath, isEdit)
end

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
function UIUtil:lang(id)
    return languageManagerInstance:getLocalString(id)
end

local SPRITE_GAMING_RMB = "ui_shopping_banner_rmb.png"
local SPRITE_GAMING_USD = "ui_shopping_banner_dollar.png"
local SPRITE_GAMING_KOREA = "ui_shopping_banner_won.png"

function UIUtil:getMoneyPng()
    if self:isKorea() then
        return SPRITE_GAMING_KOREA
    end
    local symbol = LanguageManager:getInstance():getCurrencySymbol()
    if (symbol == "$") then
        return SPRITE_GAMING_USD
    else
        return SPRITE_GAMING_RMB
    end
end

function UIUtil:isKorea()
    if(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL ) then
        local SdkManager = require"app.game.SdkManager"
        local currencyLocationCode = SdkManager:getInstance():getCurrentcyLocationCode()
        if (currencyLocationCode) then
            if (currencyLocationCode == "KPW" or currencyLocationCode == "KRW") then
                return true
            end
        else
            local languageType = LanguageManager:getInstance():getLanguage()
            if languageType == cc.LANGUAGE_KOREAN then
                return true
            end
        end
    end
    return false
end

local priceMap = {}
local price2Korea = {
    [0.99 ] =   1200,
    [1.99 ] =   2600,
    [2.99 ] =   3900,
    [4.99 ] =   5900,
    [9.99 ] =   12000,
    [19.99] =  24000,
    [49.99] =  59000,
    [99.99] =  120000,
}
function UIUtil:getMoneyPriceStr(price)
    if self:isKorea() then
        local koreaPrice = price2Korea[price]
        if not koreaPrice then
            return tostring(price * 1200)
        else
            return tostring(koreaPrice)
        end
    end

    return string.format("%.2f", price)
end

--[[
	textStr: 文本
	fontType: 字体 默认UI.FONT_BOLD
	fontsize: 字体大小 默认UI.FONT_SIZE_20PX
	fontcolor: 字体颜色 默认UI.FONT_COLOR_50_50_44
	
	width：字体最大长度，如果字体超过这个长度，则通过缩放适配
	height：多行字体高度，如果字体高度超过，则通过缩放适配
]]
function UIUtil:createAdaptTextComponent(textStr,  fontType, fontsize, fontcolor,width,height)
    local componet = UI.Component:create()
    componet:init()
    componet:setSize(width,height or 30)
    -- componet:enableDebugDraw()

    local title = UI.Text:create()
    title:init(textStr, fontType or UI.FONT_BOLD, fontsize or UI.FONT_SIZE_20PX, fontcolor or UI.FONT_COLOR_50_50_44 )
    local size = title:getContentSize()
    local scale = 1
    if width and width > 0 and size.width > width then
        scale = width/size.width
    end

    if height and height > 0 and size.height > height then
        if height/size.height < scale then
            scale = height/size.height
        end
    end

    title:setScale(scale)
    title:center()
    componet:addChild(title)

    return componet
end

function addChildAuto(layoutObj, parent, child, childName, layoutFuncName, zorder, addChildFuncName)
    assert(layoutObj and parent and child, "addChildAuto param is invaild !")    
    assert(type(childName) == "string", "tag是非string类型")

    if not layoutFuncName then
        child._enableAutoUpdatePos = false
        assert(not child[layoutFuncName], "layoutFuncNameError:"..tostring(layoutFuncName))
    end

    if addChildFuncName then
        parent[addChildFuncName](parent, child)
    else
        if not zorder then
            parent:addChild(child)
        else
            parent:addChild(child, zorder)
        end
    end
    layoutObj:autoPos(child, childName, layoutFuncName)
end
