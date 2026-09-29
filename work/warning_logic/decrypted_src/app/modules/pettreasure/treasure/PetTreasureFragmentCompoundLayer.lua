------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureFragmentCompoundLayer = class("PetTreasureFragmentCompoundLayer", UI.HWBtnComponent)

require "app.modules.pet.PetMainListCell"
local SceneManager = require("app.game.SceneManager")

local COM_WIDTH = 920
local COM_HEIGHT = 580

-- 资源
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_pet_treasure.plist",
}

local EMBATTLE_PET_POS = {
    HIGH = 1,
    MID = 2,
    LOW = 3,
}

local FRAGMENT_POS_BY_INDEX = {
    [1] = {
        x = -50,
        y = 0,
    },
    [2] = {
        x = 10,
        y = 10,
    },
    [3] = {
        x = 10,
        y = 10,
    },
    [4] = {
        x = 10,
        y = 10,
    },
    [5] = {
        x = 10,
        y = 10,
    },
    [6] = {
        x = 10,
        y = 10,
    },
}

function PetTreasureFragmentCompoundLayer:ctor()
    PetTreasureFragmentCompoundLayer.super.ctor(
    	self,
    	UI.Type.PET_TREASURE_GATHER,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetTreasureFragmentCompoundLayer:init()
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureFragmentCompoundLayer.super.init(self)
end

function PetTreasureFragmentCompoundLayer:dtor()
    PetTreasureFragmentCompoundLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureFragmentCompoundLayer")
end

function PetTreasureFragmentCompoundLayer:onInitView()
    self.isCompound = false

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部背景图片
    local innerBG  = UI.Image:create()
    innerBG:init("ui_pettreasure_compose_bg.png")
    innerBG:leftUp(28, 16)
    -- innerBG:enableDebugDraw()
    contentLayout:addChild(innerBG)
    self.innerBG = innerBG

    self:updateLayer()
end

function PetTreasureFragmentCompoundLayer:updateLayer()

    -- 加载特效
    self:updateAnimEff()

    -- 加载神器碎片
    self:updateFragments()

    -- 加载按钮
    self:updateBtn()
    
end

function PetTreasureFragmentCompoundLayer:updateAnimEff()
    if not self.CompoundEff then
        self.CompoundEff = UI.Animation:create()
        self.CompoundEff:init("effect_ui_town_pettreasure_compose_box.json", "effect_ui_town_pettreasure_compose_box.atlas", 1)
        self.CompoundEff:leftBottom(470, 264)
        self.contentLayout:addChild(self.CompoundEff, 100)

        self.CompoundEff:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function()
            if not self or tolua.isnull(self) then
                return
            end

            if self.isCompound then
                self.isCompound = false
                self:compoundOver()
            end
        end)
    end

    self.CompoundEff:setAnimation("idle", true)
end

function PetTreasureFragmentCompoundLayer:updateFragments()
    local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()
    if not self.fragmentsList then
        self.fragmentsList = {}
    end

    for index = 1, #fragmentsBag do
        local fragmentImg = self.fragmentsList[index]
        if not fragmentImg then
            fragmentImg = UI.Image:create()
            fragmentImg:init("ui_pettreasure_compose_fragment_"..index..".png")
            fragmentImg:center()
            self.fragmentsList[index] = fragmentImg
            self.CompoundEff:addComponent("box_fragment_"..index, fragmentImg)
        end

        if fragmentsBag[index] ~= 0 then
            fragmentImg:show()
        else
            fragmentImg:hide()
        end
    end
end

function PetTreasureFragmentCompoundLayer:updateBtn()
    local compoundBtn = self.contentLayout:getChildByName("compoundBtn")
    if not compoundBtn then
        compoundBtn = UI.Button:create()
        compoundBtn:init("ui_btn_yellow9_0.png","ui_btn_yellow9_1.png","ui_btn_yellow9_0.png")
        compoundBtn:leftBottom(402, 22)
        compoundBtn:setText(UI.TEXT_1172001)
        compoundBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        compoundBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()
            local fragmentsNum = mvc.petTreasureModel:getFragmentsTotalNum()
            if fragmentsNum < #fragmentsBag then
                UI.ScrollBar:createByText(UI.TEXT_1314134)
                return
            end

            if GameManager:getNormalServerTime() < mvc.petTreasureModel:getFragmentCompoundTime() then
                UI.ScrollBar:createByText(UI.TEXT_1314127)
                return
            end

            -- 背包至少要空出一个格子
            local GameDataManager = require("app.game.GameDataManager")
            local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
            if freePacketNum < 1 then
                UI.ScrollBar:createByText(UI.TEXT_1314137)
                return
            end

            UI.WaitingLayer:showWaiting(true, nil, 5)

            mvc.send("PetTreasure_Send_Fragment_Compound_Pets")
        end)
        compoundBtn:setName("compoundBtn")
        self.contentLayout:addChild(compoundBtn, 300)
    end
end

function PetTreasureFragmentCompoundLayer:showCompoundEff()
    self.isCompound = true
    local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()
    for index = 1, #fragmentsBag do
        local fragmentImg = self.fragmentsList[index]
        if fragmentImg then
            fragmentImg:hide()
        end
    end

    self.CompoundEff:setAnimation("tigger", false)
end

function PetTreasureFragmentCompoundLayer:compoundOver()
    -- 获取奖励
    local awardsStr = ConfigManager:getGeneralForKey("petTreasureDailyReward")
    local awardsStrList = string.split(awardsStr, ";")
    local awardsList = {}
    for _, value in ipairs(awardsStrList) do
        local str = string.split(value, ",")
        local awarObj = GoodsDataManager:createLocalGoodsData(tonumber(str[1]))
        awarObj:setNum(tonumber(str[2]))
        if awarObj:getNum() > 0 then
            table.insert(awardsList, awarObj)
        end
    end

    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
    end

    -- 碎片清空
    mvc.petTreasureModel:clearFragmentsBag()

    self:updateLayer()

    UI.WaitingLayer:hideWaiting()
    UI.ScrollBar:createByText(UI.TEXT_1213656)
end

function PetTreasureFragmentCompoundLayer:bindModel()

end

function PetTreasureFragmentCompoundLayer:unbindModel()

end

return PetTreasureFragmentCompoundLayer