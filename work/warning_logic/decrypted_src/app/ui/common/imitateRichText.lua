--[[
    UI - 富文本
]]--
require "app.ui.Component"

UI = UI or {}

local imitateRichText = class("imitateRichText",  UI.HWBtnComponent)
UI.imitateRichText = imitateRichText

-- 元素类型
local ELEMENT_TYPE = {
    TEXT = 1,
    IMAGE = 2,
}

-- 文本对齐
local TextAlignment = UI.LayoutDefaultType

-- 构造函数
function imitateRichText:ctor(verticalSpace)
    imitateRichText.super.ctor(self, UIType.RICH_TEXT, nil, 0, 0)
    self._imitateRichTextLayout = nil
    self._verticalSpace = verticalSpace
    -- 文本对齐方式
    self.alignment = TextAlignment.LEFT_BOTTOM
end

-- 析构函数
function imitateRichText:dtor()
    self._imitateRichTextLayout = nil
    imitateRichText.super.dtor(self)
end

-- public:
-- 初始化
--[[根据网络XML格式文本数据初始化显示文本
    elementList: 元素
    width：限制文本宽度
    height： 限制文本高度 （已废弃）
    startLineHeight: 前置空白高度
    isScrollView: 是否开启内容滚动显示
]]
function imitateRichText:init(elementList, width, height, startLineHeight, isScrollView)
    assert(elementList and type(elementList) == "table" and #elementList > 0, "imitateRichText : elementList is error.")
    assert(width and type(width) == "number" and width > 0, "imitateRichText : width is error.")
    assert(height and type(height) == "number" and height > 0, "imitateRichText : height is error.")

    self._elementList = elementList
    self._width = width
    self._height = height
    self._isScrollView = isScrollView or false
    self._startLineHeight = startLineHeight or nil

    imitateRichText.super.init(self)
end


-- 初始化视图
function imitateRichText:onInitView()

end

-- 更新视图
function imitateRichText:onUpdateView()
    self:removeAllChildren()

    self._imitateRichTextLayout = UI.Layout:create()
    self._imitateRichTextLayout:init()
    self._imitateRichTextLayout:leftBottom(0, 0)
    -- self._imitateRichTextLayout:enableDebugDraw()

    if self._isScrollView then
        self._scrollView = UI.ScrollView:create()
        self._scrollView:init(0, 0, 0, 0)
        self._scrollView:leftBottom(0, 0)
        self._scrollView:setSize(self._width, self._height)
        self._scrollView:setTouchEnable(true)
        self:addChild(self._scrollView)
        self._scrollView:setScrollBarEnabled(true)
        self._scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        self._scrollView:setScrollBarWidth(5)
        self._scrollView:setCircleVisible(false)

        self._scrollView:addInnerNode(self._imitateRichTextLayout)
    else
        self:addChild(self._imitateRichTextLayout)
    end

    self._rowList = {}
    self._rowLineSpaceList = {}

    -- 生成每行包含的元素
    self:updateRowList()

    -- 设置大小
    if self._isScrollView then
        local maxRowIndex = #self._rowLineSpaceList
        local curHeight = self:getTotalLineSpacing(maxRowIndex)

        self._imitateRichTextLayout:setSize(self._width, curHeight)
    else
        self._imitateRichTextLayout:setSize(self._width, self._height)
    end

    -- 排版
    self:addRowNode()
end

function imitateRichText:updateRowList()
    local curRowIndex = 1
    local curRestWidth = self._width

    local function addRowElement(elementNode)

        -- 非滚动显示则不会加载超框内容
        if not self._isScrollView then
            local curHeight = self:getTotalLineSpacing(curRowIndex)
            if curHeight > self._height then
                printInfo("curHeight is over imitateRichText height")
                return
            end
        end

        local stype = self:getElementType(elementNode)
        local elementWidth = elementNode:getContentSize().width

        if stype == ELEMENT_TYPE.IMAGE then
            if curRestWidth < elementWidth then
                curRowIndex = curRowIndex + 1
                curRestWidth = self._width
                addRowElement(elementNode)
            else
                curRestWidth = curRestWidth - elementWidth
                self:addToRowList(curRowIndex, elementNode)
            end

        elseif stype == ELEMENT_TYPE.TEXT then
            -- printInfo(elementNode._text)
            local firstWrap = string.find(elementNode._text, "\n")
            if firstWrap then
                local curElementNode, restElementNode = self:splitElementTextNodeByWarp(elementNode)
                addRowElement(curElementNode)

                curRowIndex = curRowIndex + 1
                curRestWidth = self._width
                addRowElement(restElementNode)
            else
                if curRestWidth < elementWidth then
                    local curElementNode, restElementNode = self:splitElementTextNodeByOverWidth(elementNode, curRestWidth)
                    self:addToRowList(curRowIndex, curElementNode)
    
                    curRowIndex = curRowIndex + 1
                    curRestWidth = self._width
                    addRowElement(restElementNode)
                else
                    curRestWidth = curRestWidth - elementWidth
                    self:addToRowList(curRowIndex, elementNode)
                end
            end
        end
    end

    for _, v in ipairs(self._elementList) do
        addRowElement(v)
    end

end

function imitateRichText:addToRowList(curRowIndex, elementNode)
    if not self._rowList then
        self._rowList = {}
    end

    if not self._rowLineSpaceList then
        self._rowLineSpaceList = {}
    end

    if not self._rowList[curRowIndex] then
        self._rowList[curRowIndex] = {}
    end

    if not self._rowLineSpaceList[curRowIndex] or self._rowLineSpaceList[curRowIndex] < elementNode:getContentSize().height then
        self._rowLineSpaceList[curRowIndex] = elementNode:getContentSize().height
    end

    -- 非滚动显示则不会加载超框内容
    if not self._isScrollView then
        local curHeight = self:getTotalLineSpacing(curRowIndex)
        if curHeight > self._height then
            printInfo("curHeight is over imitateRichText height")
            return
        end
    end
    table.insert(self._rowList[curRowIndex], elementNode)
end

function imitateRichText:addRowNode()
    for k, v in ipairs(self._rowList) do
        self:addElementNode(k, v)
    end
end

function imitateRichText:addElementNode(index, elementList)
    local totalSpacing = self:getTotalLineSpacing(index)
    local lineSpacing = self:getLineSpacing(index)
    local posY = 0
    local posX = 0

    local rowTotalWidth = 0
    -- 获取整段长度
    for _, elementNode in ipairs(elementList) do
        rowTotalWidth = rowTotalWidth + elementNode:getContentSize().width
    end

    -- 配置X坐标位置
    if (self.alignment == TextAlignment.CENTER
        or self.alignment == TextAlignment.CENTER_UP
        or self.alignment == TextAlignment.CENTER_BOTTOM) then
            posX = (self._width - rowTotalWidth) / 2

    elseif (self.alignment == TextAlignment.CENTER_RIGHT
        or self.alignment == TextAlignment.RIGHT_UP
        or self.alignment == TextAlignment.RIGHT_BOTTOM) then
            posX = self._width - rowTotalWidth
    end

    -- 配置Y坐标位置
    if (self.alignment == TextAlignment.CENTER_BOTTOM
        or self.alignment == TextAlignment.RIGHT_BOTTOM
        or self.alignment == TextAlignment.LEFT_BOTTOM) then
            posY = self._height - totalSpacing

    elseif (self.alignment == TextAlignment.CENTER_UP
        or self.alignment == TextAlignment.RIGHT_UP
        or self.alignment == TextAlignment.LEFT_UP) then
            posY = totalSpacing - lineSpacing

    elseif (self.alignment == TextAlignment.CENTER
        or self.alignment == TextAlignment.CENTER_LEFT
        or self.alignment == TextAlignment.CENTER_RIGHT) then
            posY = - (self._height / 4) + lineSpacing / 4 + ((totalSpacing - lineSpacing) / 2)

    end

    for _, elementNode in ipairs(elementList) do

        local stype = self:getElementType(elementNode)

        if (self.alignment == TextAlignment.CENTER
        or self.alignment == TextAlignment.CENTER_LEFT
        or self.alignment == TextAlignment.CENTER_RIGHT) then
            elementNode:centerLeft(posX, posY)

        elseif (self.alignment == TextAlignment.CENTER_UP
        or self.alignment == TextAlignment.RIGHT_UP
        or self.alignment == TextAlignment.LEFT_UP) then
            elementNode:leftUp(posX, posY)

        elseif (self.alignment == TextAlignment.CENTER_BOTTOM
        or self.alignment == TextAlignment.RIGHT_BOTTOM
        or self.alignment == TextAlignment.LEFT_BOTTOM) then
            elementNode:leftBottom(posX, posY)
        end

        -- elementNode:enableDebugDraw()
        self._imitateRichTextLayout:addChild(elementNode)
        -- if stype == ELEMENT_TYPE.TEXT then
        --     printInfo(elementNode._text)
        -- end
        -- printInfo("left : "..elementNode:getLeft().." right : "..elementNode:getRight().." up : "..elementNode:getUp().." bottom : "..elementNode:getBottom())
        posX = posX + elementNode:getContentSize().width
    end
end

function imitateRichText:setLineSpacing(rowIndex, space)
    if not self._rowLineSpaceList then
        self._rowLineSpaceList = {}
    end
    self._rowLineSpaceList[rowIndex] = space
end

function imitateRichText:setTotalLineSpacing(space)
    if not self._rowLineSpaceList then
        self._rowLineSpaceList = {}
    end
    
    for k, v in ipairs(self._rowLineSpaceList) do
        self._rowLineSpaceList[k] = space
    end
end

function imitateRichText:getLineSpacing(rowIndex)
    if not self._rowLineSpaceList then
        return 0
    end

    if not self._rowLineSpaceList[rowIndex] then
        return 0
    end

    return self._rowLineSpaceList[rowIndex]
end

function imitateRichText:getTotalLineSpacing(rowIndex)
    if not self._rowLineSpaceList then
        return 0
    end

    local curHeight = 0
    if self._startLineHeight then
        curHeight = self._startLineHeight
    end

    for k, v in ipairs(self._rowLineSpaceList) do
        curHeight = curHeight + v
        if k == rowIndex then
            break
        end
    end

    return curHeight
end

function imitateRichText:splitElementTextNodeByWarp(elementNode)
    local lastStr = elementNode._text
    local strList = string.split(lastStr, "\n")
    elementNode:setText(strList[1])

    -- 换行后新起一个元素，截出新的字符串内容
    local restElementNode = UI.Text:create()
    restElementNode:init("", elementNode._fontName, elementNode._fontSize, elementNode._fontColor)
    local restStr = string.gsub(lastStr, strList[1].."\n", "", 1)
    restElementNode:setText(restStr)

    return elementNode, restElementNode
end

function imitateRichText:splitElementTextNodeByOverWidth(elementNode, curRestWidth)

    local textStr = elementNode._text
    local charList = self:StringToChars(textStr)

    local lastStr = ""
    local curStr = ""
    for k, v in ipairs(charList) do
        if self:isCJKCode(v) or self:isspace(v) then
            elementNode:setText(curStr)
            if elementNode:getContentSize().width > curRestWidth then
                break
            end

            lastStr = curStr
        end

        curStr = curStr .. v
    end

    elementNode:setText(lastStr)

    -- 换行后新起一个元素，截出新的字符串内容
    local restElementNode = UI.Text:create()
    restElementNode:init("", elementNode._fontName, elementNode._fontSize, elementNode._fontColor)
    local restStr = string.gsub(textStr, lastStr, "", 1)

    -- 换行后的首位是空格则去掉
    local firstSpace = string.find(restStr, " ")
    if firstSpace and firstSpace == 1 then
        restStr = string.gsub(restStr, " ", "", 1)
    end

    restElementNode:setText(restStr)

    return elementNode, restElementNode
end

function imitateRichText:isspace(char)
    if (char == " "
    or char == "\t"
    or char == "\n"
    or char == "\v"
    or char == "\f"
    or char == "\r") then
        return true
    end

    return false
end

-- 拆分出单个字符
function imitateRichText:StringToChars(str)
    local list = {}
    local len = string.len(str)
    local i = 1
    while i <= len do
        local c = string.byte(str, i)
        local shift = 1
        if c > 0 and c <= 127 then
            shift = 1
        elseif (c >= 192 and c <= 223) then
            shift = 2
        elseif (c >= 224 and c <= 239) then
            shift = 3
        elseif (c >= 240 and c <= 247) then
            shift = 4
        end
        local char = string.sub(str, i, i+shift-1)
        i = i + shift
        table.insert(list, char)
    end
    return list, len
end

function imitateRichText:isCJKCode(char)
    local len = string.len(char)
    local chInt = 0
    for i = 1, len do
        local n = string.byte(char, i)
        chInt = chInt * 256 + n
    end

    if (chInt >= 14858880 and chInt <= 14860191)
    or (chInt >= 14860208 and chInt <= 14910399)
    or (chInt >= 14910592 and chInt <= 14911167)
    or (chInt >= 14911360 and chInt <= 14989247)
    or (chInt >= 14989440 and chInt <= 15318719)
    or (chInt >= 15380608 and chInt <= 15572655)
    or (chInt >= 15705216 and chInt <= 15707071)
    or (chInt >= 15710384 and chInt <= 15710607) then
        return true
    end

    return false
end

-- 获取元素类型
function imitateRichText:getElementType(element)
    if element._text then
        return ELEMENT_TYPE.TEXT
    else
        return ELEMENT_TYPE.IMAGE
    end
end

-- 文本整体居中
function imitateRichText:setTextCenter()
    self.alignment = TextAlignment.CENTER
end

-- 文本居中左对齐
function imitateRichText:setTextLeft()
    self.alignment = TextAlignment.CENTER_LEFT
end
-- 文本居中右对齐
function imitateRichText:setTextRight()
    self.alignment = TextAlignment.CENTER_RIGHT
end

-- 文本居中上对齐
function imitateRichText:setTextUp()
    self.alignment = TextAlignment.CENTER_UP
end

-- 文本居中下对齐
function imitateRichText:setTextBottom()
    self.alignment = TextAlignment.CENTER_BOTTOM
end

-- 文本靠右上对齐
function imitateRichText:setTextRightUp()
    self.alignment = TextAlignment.RIGHT_UP
end

-- 文本靠右下对齐
function imitateRichText:setTextRightBottom()
    self.alignment = TextAlignment.RIGHT_BOTTOM
end

-- 文本靠左上对齐
function imitateRichText:setTextLeftUp()
    self.alignment = TextAlignment.LEFT_UP
end

-- 文本靠左下对齐
function imitateRichText:setTextLeftBottom()
    self.alignment = TextAlignment.LEFT_BOTTOM
end

function imitateRichText:setWidth(value)
    assert(value and type(value) == "number" and value > 0, "imitateRichText : width is error.")
    self._width = value
end

function imitateRichText:setHeight(value)
    assert(value and type(value) == "number" and value > 0, "imitateRichText : height is error.")
    self._height = value
end

function imitateRichText:setElementList(elementList)
    assert(elementList and type(elementList) == "table" and #elementList > 0, "imitateRichText : elementList is error.")
    self._elementList = elementList
end

function imitateRichText:openScrollView()
    self._isScrollView = true
end

function imitateRichText:closeScrollView()
    self._isScrollView = false
end