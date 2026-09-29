------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local UseMoldInfoAreaView = class("UseMoldInfoAreaView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 340
local COM_HEIGHT = 420

-- 布局的宽
local LAYOUT_SIZE_WIDTH = 318
local LEFT_SPACE = 18

local SPRITE_GRID_RARE_1 = "box_quality_2_%d.png"
-- 属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT = "ui_iteminfo_icon_point_01.png"
-- 套装属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT_SUIT = "ui_iteminfo_icon_point_02.png"

function UseMoldInfoAreaView:ctor(data)
    UseMoldInfoAreaView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

-- 装备评分图标
local SPRITE_EQUIPMENT_LEVEL = "symbol_character_hero_power.png"

function UseMoldInfoAreaView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.usemold", "UseMold", false)
    UseMoldInfoAreaView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)    
end

function UseMoldInfoAreaView:dtor()
    UseMoldInfoAreaView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.usemold.UseMoldInfoAreaView")
end


function UseMoldInfoAreaView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_mold_paper_4.png")
    centerBg:center()
    contentLayout:addChild(centerBg)
    self.centerBg = centerBg

    local nameText = languageManagerInstance:getLocalString(self.data.config.moldName)
    local goodsName = UI.Text:create()
    goodsName:init(nameText, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    goodsName:setWidth(300)
    goodsName:setTextLeft()
    goodsName:leftUp(240, 40)
    goodsName:setLineSpacing(-5)
    
    contentLayout:addChild(goodsName, 10)
    self._goodsName = goodsName
    -- goodsName:enableDebugDraw()

    -- 装备评分
    local score = UI.Image:create()
    score:init(SPRITE_EQUIPMENT_LEVEL)
    contentLayout:addChild(score)
    self.scoreIcon = score
    

    local goodsScore = UI.NumberText:create("123213", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsScore:centerLeft(score:getContentSize().width + 4)
    score:addChild(goodsScore)
    self._goodsScore = goodsScore

    -- score:leftUp((self:getContentSize().width - holeWidth) / 2 - score:getContentSize().width / 2 - goodsScore:getContentSize().width / 2 - 10 + 36, 60)
    score:leftUp(180, 90)

    local left = 25--LEFT_SPACE
    -- 物品图标背景底框
    local spriteBg1 = UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(left, 40)
    contentLayout:addChild(spriteBg1)

    -- 物品图标背景
    local bgName = string.format(SPRITE_GRID_RARE_1, self.data.config.rare)
    local spriteBg = UI.Image:create()
    spriteBg:init(bgName)
    spriteBg:center()
    spriteBg1:addChild(spriteBg)
    self._spriteBg = spriteBg

    -- 物品图标
    local iconSprite = UI.Image:create()
    iconSprite:init(self.data.config.moldIcon)
    iconSprite:center()
    spriteBg:addChild(iconSprite)
    self._iconSprite = iconSprite

    -- 属性显示区域
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    -- self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH,250)

    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH, 200)
    scrollView:init()
    scrollView:centerBottom(80)
    scrollView:addInnerNode(self._scrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    self.scrollView = scrollView
    contentLayout:addChild(scrollView)
    -- scrollView:enableDebugDraw()

    self:addDes()

    self:addHoleView()
    self:updateScore()
end

function UseMoldInfoAreaView:addDes()
    local totalHeight = 0
    local attrWidth = LAYOUT_SIZE_WIDTH-25
    local leftOffset = 11
    leftOffset = LEFT_SPACE
    local pointBaseOffset = 3
    local pointBaseValueOffset = 13
    local centerOffsetUp = 13.5
    local pointOffsetY = -1

    for k, v in pairs(self.data.moldInfo.gemIds) do
        if v.gemId then
            local gemConfig = ConfigManager:getGemStoneConfigByID(v.gemId)--GoodsDataManager:createLocalGoodsData(gemId)
            
            -- ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[attrTypeArr[i]])
            if gemConfig.effectDes and gemConfig.effectDes ~= 0 then
                local gemDes = languageManagerInstance:getLocalString(gemConfig.effectDes)
                local centerUp = totalHeight + centerOffsetUp

                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT_SUIT)
                point:leftUp(leftOffset, centerUp - point:getContentSize().height / 2 + pointOffsetY)
                self._scrollLayout:addChild(point)
        
                local baseText = UI.Text:create()
                        baseText:init(
                            gemDes,
                            UI.FONT_STANDARD,
                            UI.FONT_SIZE_16PX,
                            UI.FONT_COLOR_41_41_45)
                baseText:setTextLeft()
                local textUp = centerUp - baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
        
                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                end
                
                self._scrollLayout:addChild(baseText)
                totalHeight = totalHeight + baseText:getContentSize().height
            else
                local gemData = GoodsDataManager:createLocalGoodsData(v.gemId)
                local normalDetailArr = gemData:getNormalDetailDescription()
                if normalDetailArr then 
                    for i,data in ipairs(normalDetailArr) do
                        local centerUp = totalHeight + centerOffsetUp
        
                        local point = UI.Image:create()
                        point:init(SPRITE_EQUIPMENT_AREA_POINT_SUIT)
                        point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
                        self._scrollLayout:addChild(point)
                        
                        local baseText = UI.Text:create()
                        baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                        local textUp = centerUp - baseText:getContentSize().height/2
                        baseText:setTextLeft()
                        baseText:leftUp(leftOffset + 3 + point._width, textUp)
                        self._scrollLayout:addChild(baseText)
                        if(baseText:getContentSize().width > 180) then 
                            baseText:setWidth(180)
                            baseText:setText(string.format("%s",data[1]))
                        end
        
                        local baseValue = UI.Text:create()
                        baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                        baseValue:leftUp(leftOffset + 13 + baseText._width, textUp)
                        self._scrollLayout:addChild(baseValue)
                        
                        totalHeight = totalHeight + baseText:getContentSize().height
                    end
                end
            end
            
        end
    end


    local data = self.data.config
    local moldInfo = self.data.moldInfo
    local gemstoneTypeList = string.split(data.gemstoneType, ";")
    local activeLevelList = string.split(data.effectiveLevel, ";")

    local activeLevel = 1
    if moldInfo.gemIds and #moldInfo.gemIds == #gemstoneTypeList then
        activeLevel = mvc.runeMoldModel:getCharacteristicLevel(moldInfo.gemIds)
    end
    local cruKey = mvc.runeMoldModel:getCharacteristicDesKeyByLevel(activeLevelList, activeLevel)
    if #moldInfo.gemIds == #gemstoneTypeList then
        local buffIDList = string.split(self.data.config.buffId, ";")
        for k, v in pairs(buffIDList) do
            v = tonumber(v)
            if k == cruKey then
                local buffConfig = ConfigManager:getBufferConfigById(v)
                local buffDes = buffConfig.description
            
                local centerUp = totalHeight + centerOffsetUp
        
                local point = UI.Image:create()
                point:init(SPRITE_EQUIPMENT_AREA_POINT)
                point:leftUp(leftOffset, centerUp + point:getContentSize().height / 2 - pointOffsetY)
                self._scrollLayout:addChild(point)
        
                local baseText = UI.Text:create()
                        baseText:init(
                            buffDes,
                            UI.FONT_STANDARD,
                            UI.FONT_SIZE_16PX,
                            UI.FONT_COLOR_85_49_114)
                baseText:setTextLeft()
                local textUp = centerUp --- baseText:getContentSize().height / 2
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
        
                if (baseText._width > attrWidth) then
                    baseText:setWidth(attrWidth)
                    baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                    baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
                end
                
                self._scrollLayout:addChild(baseText)
                totalHeight = totalHeight + baseText:getContentSize().height + centerOffsetUp
            end
        end
    end


    self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)
end

function UseMoldInfoAreaView:addHoleView()
    local gemstoneTypeList = string.split(self.data.config.gemstoneType, ";")
    local moldInfo = self.data.moldInfo
    local data = {}
    for k, v in pairs(moldInfo.gemIds) do
        if v.pos then
            data[v.pos] = {}
            data[v.pos].gemId = v.gemId
        end
    end
    local startX = 0
    for k, v in pairs(gemstoneTypeList) do
        local holeView = mvc.useMoldRuneHoleCellView:create(data[k])
        holeView:init()
        holeView:leftBottom(startX,-43)
        startX = startX+50
        self.contentLayout:addChild(holeView)
    end
end

function UseMoldInfoAreaView:updateScore()
    local combatScoreList = string.split(self.data.config.combatScore, ",")
    local combatScore = tonumber(combatScoreList[1])
    for k, v in pairs(self.data.moldInfo.gemIds) do
        if v.gemId then
            local gemData = GoodsDataManager:createLocalGoodsData(v.gemId)
            combatScore = combatScore + gemData:getCombatScore()
        end
    end 
    self._goodsScore:setText(combatScore)
end

function UseMoldInfoAreaView:bindModel()

end


function UseMoldInfoAreaView:unbindModel()

end





return UseMoldInfoAreaView












