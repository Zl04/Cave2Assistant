------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapPokedexCellView = class("ManorStarMapPokedexCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local COM_WIDTH = 820
local COM_HEIGHT = 192 + 25

function ManorStarMapPokedexCellView:ctor(pokedexId)
    ManorStarMapPokedexCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._pokedexId = pokedexId
end

function ManorStarMapPokedexCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapPokedexCellView.super.init(self, ... )
end

function ManorStarMapPokedexCellView:dtor()
    ManorStarMapPokedexCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapPokedexCellView")
end


function ManorStarMapPokedexCellView:onInitView()

    self:center()
    
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_starmap_book_paper_bg.png")
    bg:centerBottom(0)
    self.contentLayout:addChild(bg)

    local pokedexConfig = ConfigManager:getAllStarMapDataByID(self._pokedexId)

    --卡组名称
    local nameText = UI.Text:create()
    nameText:init(UI.TEXT_222623 .. languageManagerInstance:getLocalString(pokedexConfig.starMapName), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    nameText:leftUp(16,0)
    contentLayout:addChild(nameText)

    local pokedexIndex = 1
    local cardNeedLevel = string.split(pokedexConfig.activateLevel, ",")
    local desc = string.split(pokedexConfig.desc, ",")
    local nextLevelDesc = string.split(pokedexConfig.nextLevelDesc, ",")
    local activateStarCardId = string.split(pokedexConfig.activateStarCardId, ",")
    local minilevel = -1
    local cardDatas = mvc.manorStarMapModel._starCardData
    local haveDatas = {}
    local equipDatas = {}
    local isActivate = false --卡组是否激活

    for k,v in pairs(activateStarCardId) do
        if cardDatas[tonumber(v)] then
            haveDatas[tonumber(v)] = cardDatas[tonumber(v)]

            if cardDatas[tonumber(v)].slotId ~= 0 then
                equipDatas[tonumber(v)] = cardDatas[tonumber(v)]
            end
        end
    end

    if table.nums(haveDatas) == table.nums(activateStarCardId) then
        minilevel = 9999
        local page = -1
        for k,v in pairs(haveDatas) do

            if v.level < minilevel then
                minilevel = v.level
            end
        end
    end

    if table.nums(equipDatas) == table.nums(activateStarCardId) then
        isActivate = true
        local page = -1
        for k,v in pairs(equipDatas) do
            if page ~= -1 and page ~= v.cardPage then
                isActivate = false
                break
            end
            page = v.cardPage
        end
    end

    if minilevel > 0 then
        for i = #cardNeedLevel , 1 , -1 do
            local needLevel = tonumber(cardNeedLevel[i])
            if needLevel <= minilevel then
                pokedexIndex = i
                break
            end
        end
    else
        pokedexIndex = 1
    end

    local localDesStr = languageManagerInstance:getLocalString(tonumber(desc[pokedexIndex]))
    local nextDesStr = languageManagerInstance:getLocalString(tonumber(nextLevelDesc[pokedexIndex]))


    local desLayout = UI.Layout:create()
    desLayout:init()
    desLayout:enableAutoWidth()
    desLayout:leftUp(16, 28)
    bg:addChild(desLayout)

    --激活效果
    local desText = UI.Text:create()
    desText:init(UI.TEXT_222624, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 172, g = 166, b = 159})
    desText:floatLeft(0)
    desLayout:addComponent(desText)

    local desText2 = UI.Text:create()
    desText2:init(localDesStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 172, g = 166, b = 159})
    desText2:floatLeft(5)
    desLayout:addComponent(desText2)

    local nextDesText = UI.Text:create()
    nextDesText:init(nextDesStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 106, g = 170, b = 40})
    nextDesText:floatLeft(5)
    desLayout:addComponent(nextDesText)


    local cardLayout = UI.Layout:create()
    cardLayout:init()
    cardLayout:enableAutoWidth()
    cardLayout:centerBottom(74)
    bg:addChild(cardLayout)

    for k,v in ipairs(activateStarCardId) do

        local cData = {}
        local use = false
        if cardDatas[tonumber(v)] then
            cData = clone(cardDatas[tonumber(v)])
            use = true
        else
            cData = {
                cardId = tonumber(v),
                level = 1,
                slotId = 0,
                cardPage = 0,
            }
        end

        local cardView = mvc.manorStarMapCardCellView:create(cData)
        cardView:init()
        cardView:centerBottom(0)

        if k == 1 then
            cardView:floatLeft(0)
        else
            cardView:floatLeft(28)
        end
        
        cardLayout:addComponent(cardView)

        if not use then
            -- local cardlightSp =  UI.Animation:create()
            -- cardlightSp:init("effect_ui_starmap_cardlight.json", "effect_ui_starmap_cardlight.atlas", 1);
            -- cardlightSp:center()
            -- cardlightSp:setAnimation("idle1", true)
            -- cardView:addChild(cardlightSp,-1)
            cardView:hideLevelText()
            cardView:useAllShader(UI.COMPONENT_GRAY_SHADER)
        end
    end

    if isActivate then
        local finishSp =  UI.Animation:create()
        finishSp:init("effect_ui_starmap_tujian_finish.json", "effect_ui_starmap_tujian_finish.atlas", 1);
        -- finishSp:center(-4.5,20)
        finishSp:rightUp(30,51)
        finishSp:setAnimation("idle", true)
        contentLayout:addChild(finishSp,10)

        --标签
        local actBg = UI.Image:create()
        actBg:init("ui_starmap_label_activation.png")
        actBg:leftUp(-15,35)
        contentLayout:addChild(actBg)

        
        local desText2 = UI.Text:create()
        desText2:init(UI.TEXT_1212605, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
        desText2:center(-5,0)
        actBg:addChild(desText2)

        desLayout:leftUp(16 + 74, 28)
        desText:setText("")
    end

    if minilevel > 0 then
        local pokedexLevelBg = UI.Image:create()
        pokedexLevelBg:init("ui_starmap_btn_level.png")
        pokedexLevelBg:rightUp(10,30)
        contentLayout:addChild(pokedexLevelBg)

        local levelText = UI.Text:create()
        levelText:init(tostring(pokedexIndex), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 222, g = 183, b = 97})
        levelText:center(0,0)
        pokedexLevelBg:addChild(levelText)
    end

end


function ManorStarMapPokedexCellView:bindModel()

end


function ManorStarMapPokedexCellView:unbindModel()

end





return ManorStarMapPokedexCellView












