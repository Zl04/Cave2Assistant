------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureGatherLayer = class("PetTreasureGatherLayer", UI.HWBtnComponent)

require "app.modules.pet.PetMainListCell"
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local PetPacketLayer = require("app.modules.pettreasure.common.PetTreasurePacketLayer")
local PetTreasureInfoLayer = require("app.modules.pettreasure.treasure.PetTreasureInfoLayer")
local PetTreasureEmbattleLayer = require("app.modules.pettreasure.treasure.PetTreasureEmbattleLayer")
local PetTreasureFragmentsBagLayer = require("app.modules.pettreasure.treasure.PetTreasureFragmentsBagLayer")

-- 资源
local COM_RES_LIST = {

}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local BTN_CELL_W = 109
local BTN_CELL_H = 68

local EMBATTLE_PET_POS = {
    HIGH = 1,
    MID = 2,
    LOW = 3,
}

function PetTreasureGatherLayer:ctor()
    PetTreasureGatherLayer.super.ctor(
    	self,
    	UI.Type.PET_TREASURE_GATHER,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetTreasureGatherLayer:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureGatherLayer.super.init(self, ... )
end

function PetTreasureGatherLayer:dtor()
    PetTreasureGatherLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureGatherLayer")
end

function PetTreasureGatherLayer:onInitView()
    self.battleList = {}

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部背景图片
    local innerBG  = UI.Image:create()
    innerBG:init("ui_pettreasure_bg.png")
    innerBG:leftUp(28, 16)
    contentLayout:addChild(innerBG)
    self.innerBG = innerBG

    self:updateLayer()
end

function PetTreasureGatherLayer:updateLayer()

    -- 加载采集动效
    self:updateGatherEff()

    -- 加载左侧显示宝藏信息
    self:updateTreasureInfo()

    -- 加载右侧布阵情况
    self:updateEmbattle()

    -- 加载btn
    self:updateBtn()

    -- 加载神器碎片
    self:updateFragmentsBag()

end

function PetTreasureGatherLayer:updateGatherEff()
    if not self.gatherEff then
        self.gatherEff = UI.Animation:create()
        self.gatherEff:init("effect_ui_town_pettreasure_ring.json", "effect_ui_town_pettreasure_ring.atlas", 1)
        self.gatherEff:leftUp(232, 280)
        self.innerBG:addChild(self.gatherEff)
    end

    if mvc.petTreasureModel:getIsGathering() then
        self.gatherEff:setAnimation("tigger", true)
    else
        self.gatherEff:setAnimation("idle", true)
    end
end

function PetTreasureGatherLayer:updateTreasureInfo()
    local leftContentLayer = self.contentLayout:getChildByName("leftContentLayer")
    if not leftContentLayer then
        leftContentLayer = PetTreasureInfoLayer:create()
        leftContentLayer:init()
        leftContentLayer:leftBottom(40, 16)
        -- leftContentLayer:enableDebugDraw()
        leftContentLayer:setName("leftContentLayer")
        self.contentLayout:addChild(leftContentLayer)
    else
        leftContentLayer:updateLayer()
    end
end

function PetTreasureGatherLayer:updateEmbattle()
    local enemyData = clone(mvc.petTreasureModel:getGuardsData())
    -- 此处引用会改变到curEmbattlePetsData
    local selfData = mvc.petTreasureModel:getcurEmbattlePetsData()
    if mvc.petTreasureModel:getIsGathering() then
        selfData = clone(mvc.petTreasureModel:getWorkersData())
    end

    local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
    if not embattleLayer then
        embattleLayer = PetTreasureEmbattleLayer:create()
        embattleLayer:init(enemyData, selfData, "PetTreasureGatherLayer")
        embattleLayer:rightBottom(30, 120)
        embattleLayer:setName("embattleLayer")
        self.contentLayout:addChild(embattleLayer, 200)
    else
        embattleLayer:updateLayer(enemyData, selfData)
    end

    if mvc.petTreasureModel:getIsGathering() then
        embattleLayer:setCanDragItem(false)
    else
        embattleLayer:setCanDragItem(true)
    end
end

function PetTreasureGatherLayer:updateBtn()
    local changeWorkersBtn = self.contentLayout:getChildByName("changeWorkersBtn")
    if not changeWorkersBtn then
        changeWorkersBtn = UI.Button:create()
        changeWorkersBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
        changeWorkersBtn:rightBottom(260, 40)
        changeWorkersBtn._text:setWidth(152)
        changeWorkersBtn._text:setTextCenter()
        changeWorkersBtn._text:setLineSpacing(-8)
        changeWorkersBtn:setText(UI.TEXT_1314104)
        changeWorkersBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        changeWorkersBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            if not self.isEmbattling then
                self.isEmbattling = true
                self:showPetTreasurePacket()
            else
                self.isEmbattling = false
                local packetLayer = self.contentLayout:getChildByName("packetLayer")
                if packetLayer then
                    packetLayer:removeFromParent(false)
                end
            end

            self:updateBtn()

            -- 开蛋测试
            -- mvc.openPanel("Pet", "PetResultShow", {showType = 1, eggType = 3, id = "4938803256"})
        end)
        changeWorkersBtn:setName("changeWorkersBtn")
        self.contentLayout:addChild(changeWorkersBtn)
    end

    local battleBtn = self.contentLayout:getChildByName("battleBtn")
    if not battleBtn then
        battleBtn = UI.Button:create()
        battleBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
        battleBtn:rightBottom(50, 40)
        battleBtn._text:setWidth(152)
        battleBtn._text:setTextCenter()
        battleBtn._text:setLineSpacing(-8)
        battleBtn:setText(UI.TEXT_1212081)
        battleBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        battleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            -- 未派遣状态下
            if not mvc.petTreasureModel:getIsGathering() then
                -- 上阵宠物数量不足3个
                if mvc.petTreasureModel:getcurEmbattlePetsNum() < 3 then
                    UI.ScrollBar:createByText(UI.TEXT_1314128)
                    return
                end
            end

            -- 派遣状态下
            if mvc.petTreasureModel:getIsGathering() then
                -- 派遣未达一个小时，无法召回
                if not mvc.petTreasureModel:getCanCallbackGatherPets() then
                    UI.ScrollBar:createByText(UI.TEXT_1314129)
                    return
                end

                -- 背包至少要空出一个格子
                local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
                if freePacketNum < 1 then
                    UI.ScrollBar:createByText(UI.TEXT_1314137)
                    return
                end
            end

            UI.WaitingLayer:showWaiting(true, nil, 5)

            if mvc.petTreasureModel:getIsGathering() then
                mvc.send("PetTreasure_Send_Callback_Gather_Pets")
            else
                mvc.send("PetTreasure_Send_Gather_Pets")
            end

        end)
        battleBtn:setName("battleBtn")
        self.contentLayout:addChild(battleBtn)
    end

    local redPoint = battleBtn:getChildByName("redPoint")
    if not redPoint then
        redPoint = AvalonUtil.createRedPoint(battleBtn, 2, 2, 100)
        redPoint:setName("redPoint")
        redPoint:hide()
    end

    if mvc.petTreasureModel:getIsGathering() then
        changeWorkersBtn:disable()
        changeWorkersBtn:setText(UI.TEXT_1314104)

        battleBtn:setText(UI.TEXT_1314105)
        local redPoint = battleBtn:getChildByName("redPoint")
        local PetTreasureMaxTime = tonumber(ConfigManager:getGeneralForKey("petTreasureMaxTime"))
        local remainTime = PetTreasureMaxTime - (GameManager:getNormalServerTime() - mvc.petTreasureModel:getGatherStartTime())
        if remainTime <= 0 then
            redPoint:show()
        else
            redPoint:hide()
        end
    else
        battleBtn:setText(UI.TEXT_1212081)
        local redPoint = battleBtn:getChildByName("redPoint")
        redPoint:hide()

        changeWorkersBtn:enable()
        if self.isEmbattling then
            changeWorkersBtn:setText(UI.TEXT_1212272)
        else
            changeWorkersBtn:setText(UI.TEXT_1314104)
        end
    end
end

function PetTreasureGatherLayer:updateFragmentsBag()
    local fragmentsBaglayer = self.contentLayout:getChildByName("fragmentsBaglayer")
    if not fragmentsBaglayer then
        fragmentsBaglayer = PetTreasureFragmentsBagLayer:create()
        fragmentsBaglayer:init()
        fragmentsBaglayer:rightUp(40, 38)
        -- fragmentsBaglayer:enableDebugDraw()
        fragmentsBaglayer:setName("fragmentsBaglayer")
        self.contentLayout:addChild(fragmentsBaglayer, 300)
    else
        fragmentsBaglayer:updateLayer()
    end

    fragmentsBaglayer:setIsShowCurCollectEff(false)
end

function PetTreasureGatherLayer:showPetTreasurePacket()
    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        packetLayer:show()
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureGatherLayer")
        packetLayer:updateByData(petArr)
    else
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureGatherLayer")
        local packetLayer = PetPacketLayer:create()
        packetLayer:init(petArr, "PetTreasureGatherLayer")
        packetLayer:leftUp(35, 43.5)
        packetLayer:setName("packetLayer")
        self.contentLayout:addChild(packetLayer, 400)
    end
end

function PetTreasureGatherLayer:slotDragEnd(petData, touchPosition)
    if mvc.petTreasureModel:getcurEmbattlePetsNum() >= 3 then
        UI.ScrollBar:createByText(UI.TEXT_1314132)
        return
    end

    local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
    if embattleLayer then
        embattleLayer:slotDragEnd(petData, touchPosition)
    end

    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureGatherLayer")
        packetLayer:updateByData(petArr)
    end
end

function PetTreasureGatherLayer:bindModel()

end

function PetTreasureGatherLayer:unbindModel()

end

return PetTreasureGatherLayer