------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/05/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local UseMoldAttrDetailView = class("UseMoldAttrDetailView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 372
local COM_HEIGHT = 520

-- 布局的宽
local LAYOUT_SIZE_WIDTH = 328
local LEFT_SPACE = 18

-- 属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT = "ui_mold_characteristic_diamond.png"
-- 套装属性前面的点
-- local SPRITE_EQUIPMENT_AREA_POINT = "ui_iteminfo_icon_point_01.png"

function UseMoldAttrDetailView:ctor()
    UseMoldAttrDetailView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function UseMoldAttrDetailView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.usemold", "UseMold", false)
    UseMoldAttrDetailView.super.init(self, ... )
end

function UseMoldAttrDetailView:dtor()
    UseMoldAttrDetailView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.usemold.UseMoldAttrDetailView")
end


function UseMoldAttrDetailView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    -- contentLayout:enableDebugDraw()
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_mold_paper_5.png")
    bg:center()
    contentLayout:addChild(bg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_224714, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_178_178_178)
    titleText:centerUp(25)
    contentLayout:addChild(titleText, 101)

    
    self:initMoldAttrView()
end

function UseMoldAttrDetailView:initMoldAttrView()
    if self.scrollView and not tolua.isnull(self.scrollView) then
        self.scrollView:removeFromParent(true)
        self.scrollView = nil
    end

    -- 属性显示区域
    local scrollLayout = UI.Layout:create()
    scrollLayout:init()
    scrollLayout:center()
    -- self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH,250)

    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH, 410)
    scrollView:init()
    scrollView:centerBottom(30)
    scrollView:addInnerNode(scrollLayout)
    scrollView:setScrollBarEnabled(false)
    -- scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    -- scrollView:setScrollBarWidth(5)
    self.scrollView = scrollView
    self.contentLayout:addChild(scrollView)
    -- scrollView:enableDebugDraw()

    local moldBoxConfig = ConfigManager:getAllMoldToolboxData()
    local moldInfo = mvc.runeMoldModel:getMoldInfo()
    local usedMoldData = {}--clone(moldBoxConfig)
    for k, v in pairs(moldInfo) do
        if v.pos ~= 0 then
            usedMoldData[v.pos] = v
        end
    end

    local height = 5
    local leftOffset = (LAYOUT_SIZE_WIDTH) / 2
    for k, v in pairs(usedMoldData) do
        local attrLayout = self:createAttrLayoutByMold(v)
        attrLayout:centerUp(height)
        scrollLayout:addChild(attrLayout)
        height = height+attrLayout:getContentSize().height + 10
    end
    scrollLayout:setSize(LAYOUT_SIZE_WIDTH, height)
end

function UseMoldAttrDetailView:createAttrLayoutByMold(usedMoldData)
    local totalHeight = 0
    local attrWidth = LAYOUT_SIZE_WIDTH-25
    local leftOffset = 11
    leftOffset = LEFT_SPACE
    local pointBaseOffset = 3
    local pointBaseValueOffset = 13
    local centerOffsetUp = 13.5
    local pointOffsetY = -1
    local attrLayout = UI.Layout:create()
    attrLayout:init()
    -- attrLayout:enableDebugDraw()

    local usedMoldConfig = ConfigManager:getAllMoldForgingDataByID(usedMoldData.configId)

    local titleBg = UI.Image:create()
    titleBg:init("ui_mold_paper_bg.png")
    titleBg:centerUp(5)
    attrLayout:addChild(titleBg)
    
    local moldName = languageManagerInstance:getLocalString(usedMoldConfig.moldName)
    local moldTitle = UI.Text:create()
    moldTitle:init(moldName..UI.TEXT_224715, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_178_178_178)
    moldTitle:center()
    titleBg:addChild(moldTitle, 101)

    totalHeight = totalHeight + titleBg:getContentSize().height + centerOffsetUp

    for k, v in pairs(usedMoldData.gemIds) do
        if v.gemId then
            local gemConfig = ConfigManager:getGemStoneConfigByID(v.gemId)--GoodsDataManager:createLocalGoodsData(gemId)
            
            -- ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[attrTypeArr[i]])
            if gemConfig.effectDes and gemConfig.effectDes ~= 0 then
                local gemDes = languageManagerInstance:getLocalString(gemConfig.effectDes)
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                attrLayout:addChild(point)
        
                local baseText = UI.Text:create()
                        baseText:init(
                            gemDes,
                            UI.FONT_STANDARD,
                            UI.FONT_SIZE_18PX,
                            UI.FONT_COLOR_43_43_43)
                baseText:setTextLeft()
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
        
                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                end
                
                attrLayout:addChild(baseText)
                totalHeight = totalHeight + baseText:getContentSize().height
            else
                local gemData = GoodsDataManager:createLocalGoodsData(v.gemId)
                local normalDetailArr = gemData:getNormalDetailDescription()
                if normalDetailArr then 
                    for i,data in ipairs(normalDetailArr) do
                        local centerUp = totalHeight + centerOffsetUp
        
                        local point = UI.Image:create()
                        point:init(SPRITE_EQUIPMENT_AREA_POINT)
                        point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
                        attrLayout:addChild(point)
                        
                        local baseText = UI.Text:create()
                        baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_43_43_43)
                        local textUp = centerUp - baseText:getContentSize().height/2
                        baseText:setTextLeft()
                        baseText:leftUp(leftOffset + 3 + point._width, textUp)
                        attrLayout:addChild(baseText)
                        if(baseText:getContentSize().width > 180) then 
                            baseText:setWidth(180)
                            baseText:setText(string.format("%s",data[1]))
                        end
        
                        local baseValue = UI.Text:create()
                        baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_43_43_43)
                        baseValue:leftUp(leftOffset + 13 + baseText._width, textUp)
                        attrLayout:addChild(baseValue)
                        
                        totalHeight = totalHeight + baseText:getContentSize().height
                    end
                end
            end
            
        end
    end


    local data = usedMoldConfig
    local moldInfo = usedMoldData
    local gemstoneTypeList = string.split(data.gemstoneType, ";")
    local activeLevelList = string.split(data.effectiveLevel, ";")

    local activeLevel = 1
    if moldInfo.gemIds and #moldInfo.gemIds == #gemstoneTypeList then
        activeLevel = mvc.runeMoldModel:getCharacteristicLevel(moldInfo.gemIds)
    end
    local cruKey = mvc.runeMoldModel:getCharacteristicDesKeyByLevel(activeLevelList, activeLevel)
    if #moldInfo.gemIds == #gemstoneTypeList then
        local buffIDList = string.split(usedMoldConfig.buffId, ";")
        for k, v in pairs(buffIDList) do
            v = tonumber(v)
            if k == cruKey then
                local buffConfig = ConfigManager:getBufferConfigById(v)
                local buffDes = buffConfig.description
            
                local centerUp = totalHeight + centerOffsetUp
        
                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp + point:getContentSize().height / 2 - pointOffsetY)
                attrLayout:addChild(point)
        
                local baseText = UI.Text:create()
                        baseText:init(
                            buffDes,
                            UI.FONT_STANDARD,
                            UI.FONT_SIZE_18PX,
                            UI.FONT_COLOR_43_43_43)
                baseText:setTextLeft()
                local textUp = centerUp --- baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
        
                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                end
                
                attrLayout:addChild(baseText)
                totalHeight = totalHeight + baseText:getContentSize().height + centerOffsetUp
            end
        end
    end


    attrLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)

    return attrLayout
end

function UseMoldAttrDetailView:bindModel()

end


function UseMoldAttrDetailView:unbindModel()

end





return UseMoldAttrDetailView












