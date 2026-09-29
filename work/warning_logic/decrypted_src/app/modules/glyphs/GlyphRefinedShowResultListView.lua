------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/11/23
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GlyphRefinedShowResultListView = class("GlyphRefinedShowResultListView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_general_tips.plist",
    "ui_town_glyphs.plist",
}

UI = UI or {}
UI.GlyphRefinedShowResultListView = GlyphRefinedShowResultListView

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 680
local COM_HEIGHT = 534

function GlyphRefinedShowResultListView:ctor(lastAttrDatas, lastIsGiveUp)
    GlyphRefinedShowResultListView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.mLastAttrDatas = lastAttrDatas
    self.lastIsGiveUp = lastIsGiveUp

    self:bindModel()
end

function GlyphRefinedShowResultListView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.glyphs", "Glyphs", false)
    GlyphRefinedShowResultListView.super.init(self, ... )
end

function GlyphRefinedShowResultListView:dtor()
    GlyphRefinedShowResultListView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.glyphs.GlyphRefinedShowResultListView")
end


function GlyphRefinedShowResultListView:onInitView()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(100, 0)
    --contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self.contentLayout:setTouchEnable(true)
    self.contentLayout:setSwallowTouches(true)
    self.contentLayout:setInterceptTouches(true)
    self.contentLayout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:removeFromParent()
    end)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self.contentLayout:addChild(mask, 0)

    local Bg = UI.Image:create()
    Bg:init("ui_glyphs_paper3.png")
    Bg:center()
    self.contentLayout:addChild(Bg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_227028, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r=48,g=49,b=53})
    titleText:center(0,-230)
    self.contentLayout:addChild(titleText)

    -----------------------------------------------------
    -- body
    local everyHeight = 48 * (#(self.mLastAttrDatas[1])) + 20
    local textLayout = UI.Layout:create()
    textLayout:init()
    textLayout:setSize(600, everyHeight * (#self.mLastAttrDatas))
    -- textLayout:enableDebugDraw()
    textLayout:center(0,0)

    local pInfoArea = UI.GlyphInfoArea:create()
    for i,lastAttrData in ipairs(self.mLastAttrDatas) do
        local attributeNode = UI.Layout:create();
        attributeNode:init()
        attributeNode:setSize(400, 400)
        attributeNode:leftUp(140, (i - 1) * everyHeight + 15)
        textLayout:addChild(attributeNode)

        -- 保存/放弃提示
        local goodsType = (#(self.mLastAttrDatas[1]))
        local strPic = "ui_glyphs_box_abandon.png"
        local strPic2 = "ui_glyphs_mark_abandon.png"

        if self.lastIsGiveUp[i] then
            strPic = string.format("ui_glyphs_box_save%d.png", (goodsType))
            strPic2 = "ui_glyphs_mark_save.png"
        else
            strPic = string.format("ui_glyphs_box_abandon%d.png", (goodsType))
            strPic2 = "ui_glyphs_mark_abandon.png"
        end
        local hintPic = UI.Image:create()
        hintPic:init(strPic)
        hintPic:leftUp(-35,0)
        attributeNode:addChild(hintPic)

        local hintPic2 = UI.Image:create()
        hintPic2:init(strPic2)
        hintPic2:center(-205,-190)
        attributeNode:addChild(hintPic2, 2)

        for k1,v1 in pairs(lastAttrData) do
            local attributeConfig = ConfigManager:getGlyphAttributeByID(tonumber(v1.attrType))
            local attrStr = ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[tonumber(v1.attrType)])

            local point = UI.Image:create()
            point:init("ui_glyphs_tabulation_2.png")
            point:leftUp(0, (k1 - 1) * 42 + 7)
            attributeNode:addChild(point)

            -- UI.FONT_COLOR_41_41_45
            local baseText = UI.Text:create()
            baseText:init(attrStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            baseText:setTextLeft()
            baseText:leftUp(13, (k1 - 1) * 42 + 10)
            attributeNode:addChild(baseText)
            if(baseText:getContentSize().width > 180) then 
                baseText:setWidth(180)
                baseText:setText(string.format("%s",attrStr))
            end

            local promoteValue = v1.attrValue
            local arrowPicName = "ui_glyphs_arrow_1.png"
            if tonumber(promoteValue) < 0 then
                arrowPicName = "ui_glyphs_arrow_2.png"
            end
            local arrow = UI.Image:create()
            arrow:init(arrowPicName)
            --arrow:center(0, 0)
            arrow:centerRight(-25, 0)
            point:addChild(arrow)

            local resultText = UI.Text:create()
            resultText:init(tostring(promoteValue), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r=48,g=49,b=53})
            resultText:centerRight(10, 0)
            point:addChild(resultText)

            -- 判断数值是否超出格子
            local strLen = string.len(tostring(promoteValue))
            if strLen > 20 then
                baseText:setFontSize(UI.FONT_SIZE_14PX)
                resultText:setFontSize(UI.FONT_SIZE_14PX)
            elseif strLen > 17 then
                baseText:setFontSize(UI.FONT_SIZE_16PX)
                resultText:setFontSize(UI.FONT_SIZE_16PX)
            end
        end
    end
    local detailedScrollView = UI.ScrollView:create()
    detailedScrollView:init(0,0,0,0)
    detailedScrollView:setSize(600, 400)
    detailedScrollView:center(0, 22)
    detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
    detailedScrollView:addInnerNode(textLayout)

    self.contentLayout:addChild(detailedScrollView)
end


function GlyphRefinedShowResultListView:bindModel()

end


function GlyphRefinedShowResultListView:unbindModel()

end





return GlyphRefinedShowResultListView












