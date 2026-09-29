------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureChallengerLayer = class("PetTreasureChallengerLayer", UI.HWBtnComponent)

require "app.modules.pet.PetMainListCell"
local SceneManager = require("app.game.SceneManager")
local PetPacketLayer = require("app.modules.pettreasure.common.PetTreasurePacketLayer")
local PetTreasureEmbattleLayer = require("app.modules.pettreasure.treasure.PetTreasureEmbattleLayer")
local PetTreasureFragmentsBagLayer = require("app.modules.pettreasure.treasure.PetTreasureFragmentsBagLayer")

-- 资源
local COM_RES_LIST = {
    "ui_gaming_playerstate.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580

local EMBATTLE_PET_POS = {
    HIGH = 1,
    MID = 2,
    LOW = 3,
}

local PLACE_IMAG_POS_NAME = {
    [1] = "high",
    [2] = "mid",
    [3] = "low",
}

function PetTreasureChallengerLayer:ctor()
    PetTreasureChallengerLayer.super.ctor(
    	self,
    	UI.Type.PET_TREASURE_GATHER,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetTreasureChallengerLayer:init()
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureChallengerLayer.super.init(self)
end

function PetTreasureChallengerLayer:dtor()
    PetTreasureChallengerLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureChallengerLayer")
end

function PetTreasureChallengerLayer:removeSelf()
    self:removeFromParent(false)
end

function PetTreasureChallengerLayer:onInitView()

    self.challenagerList = {}
    -- 当前选择的挑战对象index
    self.selectIndex = 0
    self.isEmbattling = false

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
    innerBG:init("ui_pettreasure_record_bg.png")
    innerBG:leftUp(28, 16)
    -- innerBG:enableDebugDraw()
    contentLayout:addChild(innerBG)
    self.innerBG = innerBG

    self:updateLayer()
end

function PetTreasureChallengerLayer:updateLayer()

    -- 加载神器碎片
    self:updateFragmentsBag()

    -- 加载掠夺对象信息
    local fragmentsNum = mvc.petTreasureModel:getFragmentsTotalNum()
    local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()
    local challenagerData = mvc.petTreasureModel:getFragmentsBattleList()
    if #challenagerData == 0 and fragmentsNum == #fragmentsBag then
        self:updateCompoundBtn()
    else
        self:updateChallenagerList(challenagerData)

        -- 加载刷新按钮
        self:updateRefreshBtn()
    end
end

function PetTreasureChallengerLayer:updateFragmentsBag()
    local fragmentsBaglayer = self.contentLayout:getChildByName("fragmentsBaglayer")
    if not fragmentsBaglayer then
        fragmentsBaglayer = PetTreasureFragmentsBagLayer:create()
        fragmentsBaglayer:init()
        fragmentsBaglayer:rightUp(40, 38)
        -- fragmentsBaglayer:enableDebugDraw()
        fragmentsBaglayer:setName("fragmentsBaglayer")
        -- 注意神器碎片在最上层
        self.contentLayout:addChild(fragmentsBaglayer, 200)
    else
        fragmentsBaglayer:updateLayer()
    end

    fragmentsBaglayer:setIsShowCurCollectEff(true)
end

function PetTreasureChallengerLayer:updateChallenagerList(challenagerData)

    local promptContentLayout = self.contentLayout:getChildByName("promptContentLayout")
    if promptContentLayout then
        promptContentLayout:hide()
    end

    -- 内部背景图片
    local challenagerListBg = self.contentLayout:getChildByName("challenagerListBg")
    if not challenagerListBg then
        challenagerListBg = UI.Image:create()
        challenagerListBg:init("ui_pettreasure_collect_paper_2.png")
        challenagerListBg:leftBottom(30, 38)
        challenagerListBg:setName("challenagerListBg")
        self.contentLayout:addChild(challenagerListBg)
    end
    challenagerListBg:show()

    local index = 1
    local function scheduleUpdateTime()
        if not self or tolua.isnull(self) then
            return
        end

        if index <= 3 then
            local data = challenagerData[index]
            if data then
                self:updateChallenagerItem(index, data)
            end
            index = index + 1
            Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, scheduleUpdateTime, 0.1)
        else
            return
        end
    end

    scheduleUpdateTime()
end

function PetTreasureChallengerLayer:updateChallenagerItem(index, data)
    local heroData = data.fightData.heroDetail
    local petsData = data.fightData.fightingPets

    local challenageCell = self.challenagerList[index]
    if not challenageCell then
        local challenagerListBg = self.contentLayout:getChildByName("challenagerListBg")

        challenageCell = UI.Image:create()
        challenageCell:init("ui_pettreasure_collect_paper_1.png")
        challenageCell:setSize(100, 300)
        challenageCell:leftBottom(274 * index - 166, 60)
        challenagerListBg:addChild(challenageCell)
        self.challenagerList[index] = challenageCell
    end

    --- 加载宠物
    local petContentLayout = challenageCell:getChildByName("petContentLayout")
    if not petContentLayout then
        petContentLayout = UI.Layout:create()
        petContentLayout:init()
        petContentLayout:setSize(100, 280)
        petContentLayout:center()
        petContentLayout:setName("petContentLayout")
        challenageCell:addChild(petContentLayout)
    end
    petContentLayout:removeAllChildren()
    for key = 1, 3 do
        self:updatePetItem(key, petsData, petContentLayout)
    end

    -- 公会名
    local guildBg = challenageCell:getChildByName("guildBg")
    if not guildBg then
        guildBg = UI.Image:create()
        guildBg:init("ui_pettreasure_collect_guild_banner.png")
        guildBg:leftUp(-4, -17)
        guildBg:setName("guildBg")
        challenageCell:addChild(guildBg)
    end

    local guildText = guildBg:getChildByName("guildText")
    if not guildText then
        guildText = UI.Text:create()
        guildText:init("", UI.SYS_FONT, UI.FONT_SIZE_12PX, UI.FONT_COLOR_GUILD_NAME)
        guildText:centerLeft(18, 2)
        guildText:setRotation(-7.5)
        guildText:setName("guildText")
        guildBg:addChild(guildText)
    end
    guildText:setText(heroData.guildName)

    -- 名字
    local nameBg = challenageCell:getChildByName("nameBg")
    if not nameBg then
        nameBg = UI.Image:create()
        nameBg:init("ui_pettreasure_collect_name_banner.png")
        nameBg:leftUp(-32, -66)
        nameBg:setName("nameBg")
        challenageCell:addChild(nameBg)
    end

    local nameStr = heroData.pk == 0 and UI.TEXT_1314124 or heroData.nickName
    local nameText = nameBg:getChildByName("nameText")
    if not nameText then
        nameText = UI.Text:create()
        nameText:init("", UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        nameText:centerLeft(42, 1)
        nameText:setRotation(-7.5)
        nameText:setName("nameText")
        nameBg:addChild(nameText)
    end
    nameText:setFontSize(UI.FONT_SIZE_18PX)
    nameText:autoAdapt()
    nameText:setWidth(130)
    nameText:enableWrap(true)
    nameText:setText(nameStr)
    if nameText:getContentSize().height > 29 then
        nameText:setFontSize(UI.FONT_SIZE_14PX)
        nameText:setLineSpacing(-4)
    end

    local iconBg = challenageCell:getChildByName("iconBg")
    if not iconBg then
        iconBg = UI.Image:create()
        iconBg:init("ui_pettreasure_collect_headbox.png")
        iconBg:leftUp(-82, -46)
        iconBg:setName("iconBg")
        challenageCell:addChild(iconBg)
    end

    local iconBlack = iconBg:getChildByName("iconBlack")
    if not iconBlack then
        iconBlack = UI.Image:create()
        iconBlack:init("ui_playerstate_me_black_up.png")
        iconBlack:leftUp(10, 10)
        iconBlack:setName("iconBlack")
        iconBg:addChild(iconBlack)
    end

    Avalon.WidgetUtil:getHeadByData(self, heroData.sex, heroData.faceDecodeID, {}, self, handler(self, function(obj, pic)
        if iconBg and not tolua.isnull(iconBg) then
            iconBg:removeChildByName("heorIcon", true)
            pic:setPosition(46, 52)
            pic:setName("heorIcon")
            iconBg:addChild(pic, 10)
        end
    end))

    local iconFrame = iconBg:getChildByName("iconFrame")
    if not iconFrame then
        iconFrame = UI.Image:create()
        iconFrame:init("ui_playerstate_me_black_01.png")
        iconFrame:leftBottom(1.5, 9.5)
        iconFrame:setName("iconFrame")
        iconBg:addChild(iconFrame, 100)
    end

    local lvBg = iconBg:getChildByName("lvBg")
    if not lvBg then
        lvBg = UI.Image:create()
        lvBg:init("ui_playerstate_me_grade.png")
        lvBg:leftBottom(-2, 16)
        lvBg:setName("lvBg")
        iconBg:addChild(lvBg, 200)
    end

    local lvText = lvBg:getChildByName("lvText")
    if not lvText then
        lvText = UI.Text:create()
        lvText:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
        lvText:center()
        lvText:setName("lvText")
        lvBg:addChild(lvText)
    end
    lvText:setText(heroData.roleLV)

    --- 右下侧
    local powerBg = challenageCell:getChildByName("powerBg")
    if not powerBg then
        powerBg = UI.Image:create()
        powerBg:init("ui_pettreasure_collect_power_banner.png")
        powerBg:rightBottom(-70, -30)
        powerBg:setName("powerBg")
        challenageCell:addChild(powerBg)
    end

    local powerImg = powerBg:getChildByName("powerImg")
    if not powerImg then
        powerImg = UI.Image:create()
        powerImg:init("ui_pettreasure_collect_power_star.png")
        powerImg:centerLeft(20, 2)
        powerImg:setName("powerImg")
        powerBg:addChild(powerImg)
    end

    local powerText = powerBg:getChildByName("powerText")
    if not powerText then
        powerText = UI.Text:create()
        powerText:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_250_211_124)
        powerText:leftBottom(72, 20)
        powerText:setRotation(-10)
        powerText:setName("powerText")
        powerBg:addChild(powerText)
    end
    local powerNum = 0
    for index = 1, 3 do
        powerNum = powerNum + petsData[index].power
    end
    powerText:setText(powerText:numformat(tostring(powerNum)))

    local battleBtn = challenageCell:getChildByName("battleBtn")
    if not battleBtn then
        battleBtn = UI.Button:create()
        battleBtn:init("ui_pettreasure_collect_btn_0.png","ui_pettreasure_collect_btn_1.png","ui_pettreasure_collect_btn_2.png", cc.p(6, 4))
        battleBtn:rightBottom(-58, -80)
        battleBtn:setText(UI.TEXT_1213614)
        battleBtn._text:setRotation(-10)
        battleBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        battleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            if self.isEmbattling then
                return
            end

            self.selectIndex = index
            self.selectFragmentId = clone(mvc.petTreasureModel:getCurCollectFragmentIndex())
            self.isEmbattling = true

            self:startEmbattle()

        end)
        battleBtn:setName("battleBtn")
        challenageCell:addChild(battleBtn)
    end
end

function PetTreasureChallengerLayer:updatePetItem(index, petsData, petContentLayout)
    local data = petsData[index]
    local petData = Data.PetRoleData:create()
    petData:init(data, true)

    local petBg  = UI.Image:create()
    petBg:init("ui_pettreasure_pethead_box.png")
    petBg:center()
    petBg:leftBottom(20 * index - 50, 86 * index - 80)
    petBg:setName("petBg")
    petContentLayout:addChild(petBg)

    local backImg = petBg:getChildByName("backImg")
    if not backImg then
        backImg = UI.Image:create()
        backImg:init("box_quality_box_01.png")
        backImg:center()
        backImg:setName("backImg")
        petBg:addChild(backImg)
    end

    local petIcon = petBg:getChildByName("petIcon")
    if not petIcon then
        petIcon = UI.Image:create()
        petIcon:init(petData:getIcon())
        petIcon:center()
        petIcon:setName("petIcon")
        petBg:addChild(petIcon)
    end

    local posImg = petBg:getChildByName("posImg")
    if not posImg then
        posImg = UI.Image:create()
        posImg:init("ui_pettreasure_place_"..PLACE_IMAG_POS_NAME[index].."_enemy.png")
        posImg:rightBottom(0, 0)
        posImg:setName("posImg")
        petBg:addChild(posImg, 100)
    end
end

function PetTreasureChallengerLayer:startEmbattle()
    if not self.embattleContentLayout then
        local embattleContentLayout = UI.Layout:create()
        embattleContentLayout:init()
        embattleContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
        embattleContentLayout:center()
        -- embattleContentLayout:enableDebugDraw()
        self.contentLayout:addChild(embattleContentLayout)
        self.embattleContentLayout = embattleContentLayout
    end
    self.embattleContentLayout:show()

    -- 加载底板
    local embattleBg = self.embattleContentLayout:getChildByName("embattleBg")
    if not embattleBg then
        embattleBg = UI.Image:create()
        embattleBg:init("ui_pettreasure_bg.png")
        embattleBg:leftUp(28, 16)
        embattleBg:setName("posImg")
        self.embattleContentLayout:addChild(embattleBg, 100)
    end

    -- 加载按钮
    self:updateBtn()

    -- 加载右侧布阵情况
    self:updateEmbattle()

    -- 加载左侧背包
    self:showPetTreasurePacket()
end

function PetTreasureChallengerLayer:backFromEmbattle()
    if self.isEmbattling then
        local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
        embattleLayer:hide()
        local packetLayer = self.contentLayout:getChildByName("packetLayer")
        packetLayer:hide()
        self.embattleContentLayout:hide()
        self.selectIndex = 0
        self.isEmbattling = false
    end
end

function PetTreasureChallengerLayer:updateBtn()
    local backBtn = self.embattleContentLayout:getChildByName("backBtn")
    if not backBtn then
        backBtn = UI.Button:create()
        backBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_0.png")
        backBtn:rightBottom(260, 40)
        backBtn._text:setWidth(152)
        backBtn._text:setTextCenter()
        backBtn._text:setLineSpacing(-8)
        backBtn:setText(UI.TEXT_1212272)
        backBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
        backBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            self:backFromEmbattle()

        end)
        backBtn:setName("backBtn")
        self.embattleContentLayout:addChild(backBtn, 200)
    end

    local battleBtn = self.embattleContentLayout:getChildByName("battleBtn")
    if not battleBtn then
        battleBtn = UI.Button:create()
        battleBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_0.png")
        battleBtn:rightBottom(50, 40)
        battleBtn._text:setWidth(152)
        battleBtn._text:setTextCenter()
        battleBtn._text:setLineSpacing(-8)
        battleBtn:setText(UI.TEXT_1212081)
        battleBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
        battleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            if not self.isEmbattling then
                return
            end

            if mvc.petTreasureModel:getcurEmbattlePetsNum() < 3 then
                UI.ScrollBar:createByText(UI.TEXT_1314128)
                return
            end

            if self.selectFragmentId ~= mvc.petTreasureModel:getCurCollectFragmentIndex() then
                UI.ScrollBar:createByText(UI.TEXT_1314126)
                self:backFromEmbattle()
                return
            end

            UI.WaitingLayer:showWaiting(true, nil, 5)

            mvc.send("PetTreasure_Send_Battle_Pets", self.selectIndex)
        end)
        battleBtn:setName("battleBtn")
        self.embattleContentLayout:addChild(battleBtn, 200)
    end

end

function PetTreasureChallengerLayer:updateEmbattle()
    local challenagerData = mvc.petTreasureModel:getFragmentsBattleList()
    local petData = challenagerData[self.selectIndex].fightData.fightingPets
    local enemyData = {}
    for key, value in ipairs(petData) do
        local petData = Data.PetRoleData:create()
        petData:init(value, true)
        enemyData[key] = petData
    end

    mvc.petTreasureModel:setcurEmbattlePetsData(clone(mvc.petTreasureModel:getBattlePets()))
    local selfData = mvc.petTreasureModel:getcurEmbattlePetsData()

    local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
    if not embattleLayer then
        embattleLayer = PetTreasureEmbattleLayer:create()
        embattleLayer:init(enemyData, selfData, "PetTreasureChallengerLayer")
        embattleLayer:rightBottom(30, 120)
        -- embattleLayer:enableDebugDraw()
        embattleLayer:setName("embattleLayer")
        self.contentLayout:addChild(embattleLayer, 200)
    else
        embattleLayer:show()
        embattleLayer:updateLayer(enemyData, selfData)
    end
end

function PetTreasureChallengerLayer:showPetTreasurePacket()
    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        packetLayer:show()
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureChallengerLayer")
        packetLayer:updateByData(petArr)
    else
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureChallengerLayer")
        local packetLayer = PetPacketLayer:create()
        packetLayer:init(petArr, "PetTreasureChallengerLayer")
        packetLayer:leftUp(35, 43.5)
        packetLayer:setName("packetLayer")
        self.contentLayout:addChild(packetLayer, 400)
    end
end

function PetTreasureChallengerLayer:slotDragEnd(petData, touchPosition)
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
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureChallengerLayer")
        packetLayer:updateByData(petArr)
    end
end

function PetTreasureChallengerLayer:updateRefreshBtn()
    local refreshBg = self.contentLayout:getChildByName("refreshBg")
    if not refreshBg then
        refreshBg = UI.Image:create()
        refreshBg:init("ui_pettreasure_collect_refresh_box.png")
        refreshBg:rightBottom(16, 46)
        refreshBg:setName("refreshBg")
        self.contentLayout:addChild(refreshBg)
    end
    refreshBg:show()

    local refreshBtn = refreshBg:getChildByName("refreshBtn")
    if not refreshBtn then
        refreshBtn = UI.Button:create()
        refreshBtn:init("ui_btn_refresh_0.png","ui_btn_refresh_1.png","ui_btn_refresh_2.png")
        refreshBtn:center()
        refreshBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        refreshBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            -- local function scheduleUpdateRefreshBtn()
            --     if not self or tolua.isnull(self) then
            --         return
            --     end

            --     refreshBtn:enable()
            -- end

            refreshBtn:disable()
            refreshBtn:enable(3)
            --Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, scheduleUpdateRefreshBtn, 3)

            mvc.send("PetTreasure_Send_Battle_Info_Pets", 1)

            UI.WaitingLayer:showWaiting(true, nil, 5)

            UI.ScrollBar:createByText(UI.TEXT_1314138)
        end)

        refreshBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function(self)
            UI.ScrollBar:createByText(UI.TEXT_1314139)
        end)

        refreshBtn:setName("refreshBtn")
        refreshBg:addChild(refreshBtn)
    end
end

function PetTreasureChallengerLayer:updateCompoundBtn()
    local challenagerListBg = self.contentLayout:getChildByName("challenagerListBg")
    if challenagerListBg then
        challenagerListBg:hide()
    end

    local refreshBg = self.contentLayout:getChildByName("refreshBg")
    if refreshBg then
        refreshBg:hide()
    end

    local promptContentLayout = self.contentLayout:getChildByName("promptContentLayout")
    if not promptContentLayout then
        promptContentLayout = UI.Layout:create()
        promptContentLayout:init()
        promptContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
        promptContentLayout:center()
        promptContentLayout:setName("promptContentLayout")
        self.contentLayout:addChild(promptContentLayout)
    end
    promptContentLayout:show()

    local promptText = promptContentLayout:getChildByName("promptText")
    if not promptText then
        promptText = UI.Text:create()
        promptText:init(UI.TEXT_1314131, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_RED)
        promptText:centerBottom(280)
        promptText:setName("promptText")
        promptContentLayout:addChild(promptText)
    end

    local turnToCompoundBtn = promptContentLayout:getChildByName("turnToCompoundBtn")
    if not turnToCompoundBtn then
        turnToCompoundBtn = UI.Button:create()
        turnToCompoundBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
        turnToCompoundBtn:centerBottom(180)
        turnToCompoundBtn._text:setWidth(200)
        turnToCompoundBtn._text:setTextCenter()
        turnToCompoundBtn._text:setLineSpacing(-8)
        turnToCompoundBtn:setText(UI.TEXT_1314130)
        turnToCompoundBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
        turnToCompoundBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            mvc.send("PetTreasure_Click_Tab", 3)
        end)
        turnToCompoundBtn:setName("turnToCompoundBtn")
        promptContentLayout:addChild(turnToCompoundBtn)
    end
end

function PetTreasureChallengerLayer:bindModel()

end

function PetTreasureChallengerLayer:unbindModel()

end

return PetTreasureChallengerLayer