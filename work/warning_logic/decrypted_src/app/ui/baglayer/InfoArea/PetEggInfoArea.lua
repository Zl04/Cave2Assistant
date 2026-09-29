--[[
    UI - 背包中的宠物蛋详情界面
]]--


UI = UI or {}

local PetEggInfoArea = class("PetEggInfoArea", UI.HWBtnComponent)
local LanguageManager = require "app.game.LanguageManager"
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
UI.PetEggInfoArea = PetEggInfoArea

local COM_RES_LIST = {
    "ui_town_starpray.plist",
    "ui_common_btn.plist",
    "ui_package_pets.plist",
    "ui_common_scale9image.plist",
}


local SPRITE_PETEGG_BG = "ui_pets_egg_paper.png"
local SPRITE_EGGICON_BG1 = "box_quality_box_01.png"
local SPRITE_EGGICON_BG2 = "box_quality_1_5.png"

local PETTYPE = {
    {type = UI.TEXT_1213629, icon = "ui_pets_type_attack_0.png"},
    {type = UI.TEXT_1213630, icon = "ui_pets_type_defense_0.png"},
    {type = UI.TEXT_1213631, icon = "ui_pets_type_balanced_0.png"},
    {type = UI.TEXT_1213632, icon = "ui_pets_type_special_0.png"},
}

local layerSize = cc.size(400, 413)

function PetEggInfoArea:ctor()
    PetEggInfoArea.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)
    self:setInterceptTouches(false)
    self:setTouchEnable(true)
end

function PetEggInfoArea:init(proptype)
    self._proptype = proptype
    PetEggInfoArea.super.init(self)
end

-- 析构函数
function PetEggInfoArea:dtor()
    PetEggInfoArea.super.dtor(self)
end

function PetEggInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function PetEggInfoArea:getGoodsGrid()
    return self._goodsGrid
end

-- 初始化视图
function PetEggInfoArea:onInitView()

    local ZOrder = 0

    local bg = UI.Image:create()
    bg:init(SPRITE_PETEGG_BG)
    bg:center()
    self.bg = bg
    self:addChild(bg)

    AvalonUtil.runTipsAppearShowAnimation(self)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(338, 323)
    contentLayout:center()
    --contentLayout:enableDebugDraw()
    self.contentLayout = contentLayout
    bg:addChild(contentLayout)

    -- 宠物蛋名字
    local eggName = UI.Text:create()
    eggName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    eggName:setWidth(210)
    eggName:setTextCenter()
    eggName:autoAdapt()
    self.contentLayout:addChild(eggName, ZOrder)
    self.eggName = eggName
    ZOrder = ZOrder + 1

    -- 宠物来源
    local petSource = UI.Text:create()
    petSource:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    petSource:centerUp(52)
    self.contentLayout:addChild(petSource, ZOrder)
    self.petSource = petSource
    ZOrder = ZOrder + 1

    -- 宠物图标
    local petIconBg1 = UI.Image:create()
    petIconBg1:init(SPRITE_EGGICON_BG1)
    petIconBg1:centerUp(83)
    self.contentLayout:addChild(petIconBg1, ZOrder)
    ZOrder = ZOrder + 1

    local petIconBg2 = UI.Image:create()
    petIconBg2:init(SPRITE_EGGICON_BG2)

    petIconBg2:center()
    petIconBg1:addChild(petIconBg2, ZOrder)
    self._petIconBg2 = petIconBg2
    ZOrder = ZOrder + 1

    local petIcon = UI.Image:create()
    petIcon:init()
    petIcon:center()
    petIconBg2:addChild(petIcon)
    self.petIcon = petIcon

    -- 宠物类型
    local typeIcon = UI.Image:create()
    typeIcon:init()
    typeIcon:leftUp(115, 169)
    self.contentLayout:addChild(typeIcon, ZOrder)
    self.typeIcon = typeIcon
    ZOrder = ZOrder + 1

    local typeTxt = UI.Text:create()
    typeTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    typeTxt:leftUp(159, 178)
    typeTxt:setWidth(145)
    typeTxt:autoAdapt()
    self.contentLayout:addChild(typeTxt, ZOrder)
    self.typeTxt = typeTxt
    ZOrder = ZOrder + 1

    -- 分割线
    local line = UI.Image:create()
    line:init("ui_scale9image_banner_line_dark.png")
    line:centerUp(160)
    line:setImageScaleX(85)
    self.contentLayout:addChild(line, ZOrder)
    ZOrder = ZOrder + 1

    -- 等级上限
    local levelUpTxt = UI.Text:create()
    levelUpTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    levelUpTxt:centerUp(215)
    self.contentLayout:addChild(levelUpTxt, ZOrder)
    self.levelUpTxt = levelUpTxt
    ZOrder = ZOrder + 1

    -- 按钮
    local btn = UI.Button:create()
    btn:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    btn:centerBottom(15)
    btn:setText(UI.TEXT_1213707)
    btn:setScaleY(50 / 55)
    btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_56_49_44)
    btn:setTouchEnable(true)
    btn:setSwallowTouches(true)
    self.contentLayout:addChild(btn, ZOrder)
    ZOrder = ZOrder + 1
    btn:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)

        -- 宠物蛋
        -- 仅能在洞外使用
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        -- 判断宠物背包是否已满
        local petCount = #MasterDataManager:getBagPets()
        if petCount >= 100 then
            UI.ScrollBar:createByText(UI.TEXT_1213713)
            return
        end

        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1213714,
            function()
                -- 为了绕过一些原有道具的无用判断，直接开
                local master = GameDataManager:getInstance():getMaster()
                AudioUtil:playUseItemSound(self.goodsData:getGoodsID())
                Net.NetGoodsSystem:useItemRequest(
                    self.goodsData:getGoodsID(),
                    self.goodsData:getIsGolden(),
                    master:getSpriteID()
                )
        
                -- 这里先设置一下蛋的外形type，因为在获得蛋的时候，已经脱离使用物品这个环境了
                local goodsAttr = ConfigManager:getPropConfigByID(self.goodsData:getGoodsID())
                local typeIdx = string.find(goodsAttr.icon, ".png")-1
                local eggType = string.sub(goodsAttr.icon, typeIdx, typeIdx)
                mvc.petModel:setNewEggType(tonumber(eggType))
        
                -- 销毁
                if self then
                    self:destroy()
                end
            end
        )
    end)
end

-- 更新视图
function PetEggInfoArea:onUpdateView(data)

    if data then
        local petData = ConfigManager:getPetDataByID(data.extendValue1)
        self.eggName:setText(data.name)
        local tempName = UI.Text:create()
        tempName:init(data.name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
        if tempName:getContentSize().width > 210 then
            self.eggName:centerUp(5)
            self.eggName:setLineSpacing(-8)
        else
            self.eggName:centerUp(14)
        end
        local icon = string.split(petData.icon, ";")
        self.petIcon:setSpriteName(icon[1]..".png")
        local source
        if petData.scenesID == 0 then
            source = UI.TEXT_1213715
        elseif petData.scenesID == -18 then -- 产出来源泰坦之路特殊处理
            source = UI.TEXT_224400
        else
            source = ToolsUtil:getSenceName(petData.scenesID)
        end
        self.petSource:setText(UI.TEXT_1213716..source)
        self.typeTxt:setText(PETTYPE[petData.petType].type)
        self.typeIcon:setSpriteName(PETTYPE[petData.petType].icon)
        local maxLVData = string.split(petData.maxLV, ";")
        local levelTxt = string.format(UI.TEXT_1213717, tonumber(maxLVData[1]))
        self.levelUpTxt:setText(levelTxt)


        if self._petIconBg2 then
            local petQuality = petData.petquality

            local bgImg = "box_quality_1_2.png"
            if petQuality == PublicDefine.PetQualityType.Blue then
                bgImg = "box_quality_1_2.png"
            elseif petQuality == PublicDefine.PetQualityType.Golden then
                bgImg = "box_quality_1_3.png"
            elseif petQuality == PublicDefine.PetQualityType.HiddenGold then
                bgImg = "box_quality_1_4.png"
            elseif petQuality == PublicDefine.PetQualityType.Violet then
                bgImg = "box_quality_1_5.png"
            elseif petQuality == PublicDefine.PetQualityType.Red then
                bgImg = "box_quality_1_6.png"
            elseif petQuality == PublicDefine.PetQualityType.Platinum then
                bgImg = "box_quality_1_7.png"
            end

            self._petIconBg2:setSpriteName(bgImg)
        end

    end

end

function PetEggInfoArea:setGoodsData(goodsData)
    self.goodsData = goodsData
end
