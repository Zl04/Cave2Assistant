------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/02/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetAddTalentPointDesTipsView = class("PetAddTalentPointDesTipsView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

UI.PetAddTalentPointDesTipsView = PetAddTalentPointDesTipsView

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 489
local COM_HEIGHT = 347

function PetAddTalentPointDesTipsView:ctor(data, config)
    PetAddTalentPointDesTipsView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.config = config
    self:bindModel()
end

function PetAddTalentPointDesTipsView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetAddTalentPointDesTipsView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)
end

function PetAddTalentPointDesTipsView:dtor()
    PetAddTalentPointDesTipsView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetAddTalentPointDesTipsView")
end


function PetAddTalentPointDesTipsView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_pets_optimization_paper_2.png")
    bg:center()
    contentLayout:addChild(bg)

    local titleBG  = UI.Image:create()
    titleBG:init("ui_pets_optimization_title.png")
    titleBG:centerUp(20)
    contentLayout:addChild(titleBG)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_224011, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_205_205_205)
    titleText:center()
    titleBG:addChild(titleText)

    local des = UI.Text:create()
    des:init(string.format(UI.TEXT_224012, self.data.str), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    des:centerUp(60)
    contentLayout:addChild(des)

    local line  = UI.Image:create()
    line:init("ui_pets_optimization_line.png")
    line:centerUp(90)
    contentLayout:addChild(line)
    -- line:enableDebugDraw()

    local desTitle = UI.Text:create()
    desTitle:init(UI.TEXT_224013, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    desTitle:centerUp(93)
    contentLayout:addChild(desTitle)


    self:addDesScrollView()
end


function PetAddTalentPointDesTipsView:addDesScrollView()
    -- 滚动视图
    local descScrollView = UI.ScrollView:create()
    descScrollView:init(0, 0, 0, 0)
    descScrollView:centerUp(125)
    descScrollView:setSize(430, 210)
    descScrollView:setTouchEnable(true)
    -- descScrollView:setScrollBarEnabled(false)
    -- descScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    -- descScrollView:setScrollBarWidth(5)
    descScrollView:setCircleVisible(false)
    self.descScrollView = descScrollView
    self.contentLayout:addChild(descScrollView)
    -- descScrollView:enableDebugDraw()
    
    local descLayout = UI.Layout:create()
    descLayout:init()
    descLayout:leftBottom(0, 0)
    self.descLayout = descLayout
    descScrollView:addInnerNode(descLayout)

    local petTalentMaterialList = self:getPetTalentMaterialList(self.config)
    local column = 3
    local startX = 20
    local onePaddingX = 142
    local onePaddingY = 40
    local row = math.ceil(#petTalentMaterialList/3)

    for k, v in ipairs(petTalentMaterialList) do
        local cell = UI.Text:create()
        cell:init(string.format(UI.TEXT_224014, v.level, v.num), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        local idx  = math.floor(k/column)
        if((k-1)%column == 0 or k == 1) then
            cell:leftUp(startX , onePaddingY*idx)
        else
            local ratio = k%column == 0 and column or k%column
            idx = k%column == 0 and idx-1 or idx
            cell:leftUp(startX + (ratio-1)*onePaddingX, onePaddingY*idx)
        end
        descLayout:addChild(cell)
    end
    descLayout:setSize(430, row*onePaddingY)
end

function PetAddTalentPointDesTipsView:getPetTalentMaterialList(config)
    local talentMaterialMaxList = string.split(config.talentMaterialMax, ";")
    local petLevel2TalentMaterialMaxList = {}
    for k, v in pairs(talentMaterialMaxList) do
        local list = string.split(v, ",")
        local dataList = {}
        dataList.level = tonumber(list[1])
        dataList.num = tonumber(list[2])
        table.insert(petLevel2TalentMaterialMaxList, dataList)
    end

    return petLevel2TalentMaterialMaxList
end

function PetAddTalentPointDesTipsView:bindModel()

end


function PetAddTalentPointDesTipsView:unbindModel()

end





return PetAddTalentPointDesTipsView












