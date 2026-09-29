------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 宠物基础属性公用面板
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureEmbattleLayer = class("PetTreasureEmbattleLayer", UI.BaseWin)

local COM_WIDTH = 410
local COM_HEIGHT = 320

-- 资源
local COM_RES_LIST = {
    "ui_gaming_playerstate.plist",
    "ui_package_pets.plist",
}

local PLACE_IMAG_POS_NAME = {
    [1] = "high",
    [2] = "mid",
    [3] = "low",
}

local UPDATE_SIGN = {
    NO_CHANGE = 1,
    SHOW_PASS = 2,
    HIDE_PASS = 3,
}

function PetTreasureEmbattleLayer:ctor()
    PetTreasureEmbattleLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetTreasureEmbattleLayer:init(enemyData, selfData, eventName)
    self.eventName = eventName
    self.workerBg = {}
    self.enemyBg = {}
    self.enemyData = enemyData
    self.workersList = selfData or mvc.petTreasureModel:getcurEmbattlePetsData()
    self.petAdventureList = self.petAdventureList or mvc.petTreasureModel:getPetAdvEmbattlePets()

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureEmbattleLayer.super.init(self, enemyData, selfData)
end

function PetTreasureEmbattleLayer:dtor()
    PetTreasureEmbattleLayer.super.dtor(self)
    self:unbindModel()

    mvc.petTreasureModel:clearcurEmbattlePetsData()
    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureEmbattleLayer")
end

function PetTreasureEmbattleLayer:onInitView()
    self.updateSign = UPDATE_SIGN.NO_CHANGE
    self.canDragItem = true

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:updateLayer()
end

function PetTreasureEmbattleLayer:updateLayer(enemyData, selfData, eventName)
    if eventName then
        self.eventName = eventName
    end

    self.enemyData = enemyData or self.enemyData
    self.workersList = selfData or self.workersList
    self.petAdventureList = selfData or self.petAdventureList

    -- 加载敌人出阵信息
    self:updateEnemy()

    -- 加载自己出阵宠物
    self:updateWorkPet()

    if self.eventName == "PetTreasureGatherLayer" then
        if mvc.petTreasureModel:getIsGathering() then
            self:showPassEnemy()
        else
            self:showNewEnemy()
        end
    end
end

function PetTreasureEmbattleLayer:updateEnemy()
    local enemys = self.enemyData
    local power = 0
    for _, value in pairs(enemys) do
        power = power + value:getPower()
    end

    local seatLayout = self.contentLayout:getChildByName("enemySeatLayout")
    if not seatLayout then
        seatLayout = UI.Layout:create()
        seatLayout:init()
        seatLayout:enableAutoWidth()
        seatLayout:enableAutoHeight()
        seatLayout:rightUp(212, 90)
        seatLayout:setName("enemySeatLayout")
        self.contentLayout:addChild(seatLayout)
    end

    local seatBg = seatLayout:getChildByName("seatBg")
    if not seatBg then
        seatBg = UI.Image:create()
        seatBg:init("ui_pettreasure_banner_enemy_1.png")
        seatBg:center()
        seatBg:setName("seatBg")
        seatLayout:addChild(seatBg)
    end

    for key = 1, 3 do
        local value = enemys[key]

        local enemyBg = self.enemyBg[key]
        if not enemyBg then
            enemyBg = UI.Image:create()
            enemyBg:init("ui_pettreasure_pethead_box.png")
            enemyBg:leftBottom(-252 + 112 * key, -38)
            self.enemyBg[key] = enemyBg
            seatLayout:addChild(enemyBg)
        end

        local backImg = enemyBg:getChildByName("backImg")
        if not backImg then
            backImg = UI.Image:create()
            backImg:init("box_quality_box_01.png")
            backImg:center()
            backImg:setName("backImg")
            enemyBg:addChild(backImg)
        end

        local posImg = enemyBg:getChildByName("posImg")
        if not posImg then
            posImg = UI.Image:create()
            posImg:init("ui_pettreasure_place_"..PLACE_IMAG_POS_NAME[key].."_enemy.png")
            posImg:leftBottom(0, 0)
            posImg:setName("posImg")
            enemyBg:addChild(posImg, 100)
        end

        local enemyIcon = enemyBg:getChildByName("enemyIcon")
        if not enemyIcon then
            enemyIcon = UI.Image:create()
            enemyIcon:init("ui_pets_manual_unkown.png")
            enemyIcon:center()
            enemyIcon:setName("enemyIcon")
            enemyBg:addChild(enemyIcon)
        end
        if value then
            enemyIcon:setSpriteName(value:getIcon())
            if self.eventName == "PetTreasureAdventureLayer" then
                local starTxt = enemyBg:getChildByName("starTxt")
                if starTxt then
                    starTxt:removeFromParentAndCleanup()
                end
                starTxt = UI.Text:create()
                starTxt:init(tostring(value:getStarLv() or 0), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_230_210_190)
                starTxt:rightBottom(10, 6)
                starTxt:setName("starTxt")
                enemyBg:addChild(starTxt)

                local starImg = enemyBg:getChildByName("starImg")
                if starImg then
                    starImg:removeFromParentAndCleanup()
                end
                local txtW = starTxt:getContentSize().width
                starImg = UI.Image:create()
                starImg:init("ui_pets_box_star.png")
                starImg:rightBottom(txtW+10, 8)
                starImg:setName("starImg")
                enemyBg:addChild(starImg)

                local lvLayout = enemyBg:getChildByName("lvLayout")
                if lvLayout then
                    lvLayout:removeFromParentAndCleanup()
                end
                lvLayout = UI.Layout:create();
                lvLayout:init()
                lvLayout:setSize(50, 20)
                lvLayout:setName("lvLayout")
                enemyBg:addChild(lvLayout, 20)

                local lvImg = enemyBg:getChildByName("lvImg")
                if lvImg then
                    lvImg:removeFromParentAndCleanup()
                end
                lvImg = UI.Image:create()
                lvImg:init("ui_home_banner_lv.png")
                lvImg:centerLeft(0)
                lvImg:setName("lvImg")
                lvLayout:addChild(lvImg)

                local lvInnerLayout = AvalonUtil:getStyledNumberNode(value:getLevel())
                lvInnerLayout:centerLeft(25)
                lvLayout:addChild(lvInnerLayout)

                lvLayout:leftUp(0, 0)
                lvLayout:setScaleX(0.6)
                lvLayout:setScaleY(0.6)
            end
        else
            enemyIcon:setSpriteName("ui_pets_manual_unkown.png")
        end
    end

    local titleBg = seatLayout:getChildByName("titleBg")
    if not titleBg then
        titleBg = UI.Image:create()
        titleBg:init("ui_pettreasure_banner_enemy_2.png")
        titleBg:leftUp(-188, -86)
        titleBg:setName("titleBg")
        seatLayout:addChild(titleBg)
    end

    local titleTxt = titleBg:getChildByName("titleTxt")
    if not titleTxt then
        titleTxt = UI.Text:create()
        titleTxt:init(UI.TEXT_1314102, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        titleTxt:centerUp(-2)
        titleTxt:setName("titleTxt")
        titleBg:addChild(titleTxt)
    end

    -- 战斗力
    local powerLayout = seatLayout:getChildByName("PowerLayout")
    if not powerLayout then
        powerLayout = UI.Layout:create();
        powerLayout:init()
        powerLayout:enableAutoWidth()
        powerLayout:enableAutoHeight()
        powerLayout:leftBottom(74, -72)
        powerLayout:setName("PowerLayout")
        seatLayout:addChild(powerLayout, 1000)
    end

    local starImg = powerLayout:getChildByName("starImg")
    if not starImg then
        starImg = UI.Image:create()
        starImg:init("ui_information_equip.png")
        starImg:floatLeft(0)
        starImg:setName("starImg")
        powerLayout:addComponent(starImg)
    end

    local powerTxt = powerLayout:getChildByName("powerTxt")
    if not powerTxt then
        powerTxt = UI.Text:create()
        powerTxt:init(powerTxt:numformat(tostring(power)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
        powerTxt:floatLeft(4)
        powerTxt:setName("powerTxt")
        powerLayout:addComponent(powerTxt)
    end

    if not enemys or #enemys == 0 then
        powerTxt:setText("????")
    else
        powerTxt:setText(powerTxt:numformat(tostring(power)))
    end
end

function PetTreasureEmbattleLayer:updateWorkPet()
    -- local workers = self.workersList
    local workers = self.eventName == "PetTreasureAdventureLayer" and self.petAdventureList or self.workersList
    local power = 0
    for _, value in pairs(workers) do
        if value and value.templateID then
            power = power + value.power
        end
    end

    local seatLayout = self.contentLayout:getChildByName("workersSeatLayout")
    if not seatLayout then
        seatLayout = UI.Layout:create();
        seatLayout:init()
        seatLayout:enableAutoWidth()
        seatLayout:enableAutoHeight()
        seatLayout:rightBottom(212, 76)
        seatLayout:setName("workersSeatLayout")
        self.contentLayout:addChild(seatLayout)
    end

    local seatBg = seatLayout:getChildByName("seatBg")
    if not seatBg then
        seatBg = UI.Image:create()
        seatBg:init("ui_pettreasure_banner_self_1.png")
        seatBg:center()
        seatBg:setName("seatBg")
        seatLayout:addChild(seatBg)
    end

    for key = 1, 3 do
        local value = workers[key]

        if not self.workerBg[key] then
            self.workerBg[key] = UI.Image:create()
            self.workerBg[key]:init("ui_pettreasure_pethead_box.png")
            self.workerBg[key]:leftBottom(-252 + 112 * key, -38)
            seatLayout:addChild(self.workerBg[key])
        end
        local workerBg = self.workerBg[key]

        local backImg = workerBg:getChildByName("backImg")
        if not backImg then
            backImg = UI.Image:create()
            backImg:init("box_quality_box_01.png")
            backImg:center()
            backImg:setName("backImg")
            workerBg:addChild(backImg)
        end

        local posImg = workerBg:getChildByName("posImg")
        if not posImg then
            posImg = UI.Image:create()
            posImg:init("ui_pettreasure_place_"..PLACE_IMAG_POS_NAME[key].."_self.png")
            posImg:leftBottom(0, 0)
            posImg:setName("posImg")
            workerBg:addChild(posImg, 100)
        end

        if value and value.templateID then
            local petData = value
            petData.petPosIndex = key

            local workerIcon = workerBg:getChildByName("workerIcon")
            if workerIcon then
                workerBg:removeChildByName("workerIcon")
            end
            workerIcon = UI.PetMainListCell:create()
            local state =  self.eventName ~= "PetTreasureAdventureLayer" 
            workerIcon:init(nil, state, state, true, petData)
            workerIcon:center()
            workerIcon:setName("workerIcon")
            workerBg:addChild(workerIcon)

            workerIcon:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onPetIconTouchMove)
            workerIcon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onPetIconTouchEnd)
        else
            if workerBg and workerBg:getChildByName("workerIcon") then
                workerBg:removeChildByName("workerIcon")
            end
        end
    end

    local titleBg = seatLayout:getChildByName("titleBg")
    if not titleBg then
        titleBg = UI.Image:create()
        titleBg:init("ui_pettreasure_banner_self_2.png")
        titleBg:leftUp(-188, -86)
        titleBg:setName("titleBg")
        seatLayout:addChild(titleBg)
    end

    local titleTxt = titleBg:getChildByName("titleTxt")
    if not titleTxt then
        titleTxt = UI.Text:create()
        titleTxt:init(UI.TEXT_1314103, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        titleTxt:centerUp(-2)
        titleTxt:setName("titleTxt")
        titleBg:addChild(titleTxt)
    end

    -- 战斗力
    local powerLayout = seatLayout:getChildByName("PowerLayout")
    if not powerLayout then
        powerLayout = UI.Layout:create();
        powerLayout:init()
        powerLayout:enableAutoWidth()
        powerLayout:enableAutoHeight()
        powerLayout:leftBottom(74, -72)
        powerLayout:setName("PowerLayout")
        seatLayout:addChild(powerLayout, 1000)
    end

    local starImg = powerLayout:getChildByName("starImg")
    if not starImg then
        starImg = UI.Image:create()
        starImg:init("ui_information_equip.png")
        starImg:floatLeft(0)
        starImg:setName("starImg")
        powerLayout:addComponent(starImg)
    end

    local powerTxt = powerLayout:getChildByName("powerTxt")
    if not powerTxt then
        powerTxt = UI.Text:create()
        powerTxt:init(powerTxt:numformat(tostring(power)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
        powerTxt:floatLeft(4)
        powerTxt:setName("powerTxt")
        powerLayout:addComponent(powerTxt)
    end

    powerTxt:setText(powerTxt:numformat(tostring(power)))
end

function PetTreasureEmbattleLayer:slotDragEnd(petData, touchPosition)

    local seatLayout = self.contentLayout:getChildByName("workersSeatLayout")
    local seatBg = seatLayout:getChildByName("seatBg")

    local pos = seatBg:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    local size = seatBg:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        -- 冒险状态下
        -- if mvc.petTreasureModel:getExploreState() then
        --     local explorePets = mvc.petTreasureModel:getPetAdvEmbattlePets()
        --     for _, v in pairs(explorePets) do
        --         if v:getId() == petData:getId() then
        --             UI.ScrollBar:createByText(UI.TEXT_221108)
        --             return
        --         end
        --     end
        -- end
        -- 航海状态下
        if mvc.dockModel:isSailing() then
            if mvc.dockModel:checkPetIsSailing(petData:getId()) then
                UI.ScrollBar:createByText(UI.TEXT_221932)
                return
            end
        end
        self:addCenterPet(petData)
    end
end

function PetTreasureEmbattleLayer:addCenterPet(petData)
    local petData = petData

    local seatLayout = self.contentLayout:getChildByName("workersSeatLayout")

    local index = 0
    for i = 1, 3 do
        if not self.workersList[i] or not self.workersList[i].templateID then
            self.workersList[i] = petData
            index = i
            break
        end
    end

    petData.petPosIndex = index

    local workerBg = self.workerBg[index]
    local workerIcon = workerBg:getChildByName("workerIcon")
    if workerIcon then
        workerBg:removeChildByName("workerIcon")
    end
    workerIcon = UI.PetMainListCell:create()
    workerIcon:init(nil, true, true, true, petData)
    workerIcon:center()
    workerIcon:setName("workerIcon")
    workerBg:addChild(workerIcon)

    workerIcon:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onPetIconTouchMove)
    workerIcon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onPetIconTouchEnd)

    local powerLayout = seatLayout:getChildByName("PowerLayout")
    local powerTxt = powerLayout:getChildByName("powerTxt")
    local power = mvc.petTreasureModel:getCurEmbattlePower()
    powerTxt:setText(powerTxt:numformat(tostring(power)))
end

function PetTreasureEmbattleLayer:onPetIconTouchMove(cell, touchPosition)
    if not self.canDragItem then
        return
    end

    if cell:isVisible() then
        cell:hide()
    end

    local data = {}
    data.cell = cell
    data.touchPosition = touchPosition
    data.eventName = self.eventName

    mvc.send("PetTreasure_Self_Embattle_Item_Touch", UIEvent.COMPONENT_TOUCH_MOVED, data)
end

function PetTreasureEmbattleLayer:onPetIconTouchEnd(cell, touchPosition)
    if not self.canDragItem then
        return
    end

    local data = cell:getData()
    local index = 0
    local workersList = self.eventName == "PetTreasureAdventureLayer" and self.petAdventureList or self.workersList
    for i = 1, 3 do
        if workersList[i] and workersList[i].petPosIndex == data.petData.petPosIndex then
            index = i
            break
        end
    end

    local seatLayout = self.contentLayout:getChildByName("workersSeatLayout")
    local seatBg = seatLayout:getChildByName("seatBg")

    local pos = seatBg:convertToNodeSpace(touchPosition)
    local size = seatBg:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        cell:show()
    else
        workersList[index] = nil
        if self.eventName == "PetTreasureAdventureLayer" then
            mvc.petTreasureModel:setPetAdvEmbattlePets(workersList)
        end
        self:updateWorkPet()
    end

    local data = {}
    data.cell = cell
    data.touchPosition = touchPosition
    data.eventName = self.eventName

    mvc.send("PetTreasure_Self_Embattle_Item_Touch", UIEvent.COMPONENT_TOUCH_ENDED, data)
end

function PetTreasureEmbattleLayer:showPassEnemy()
    local seatLayout = self.contentLayout:getChildByName("enemySeatLayout")
    local seatBg = seatLayout:getChildByName("seatBg")
    seatBg:useShader(UI.COMPONENT_GRAY_SHADER)
    local titleBg = seatLayout:getChildByName("titleBg")
    titleBg:useShader(UI.COMPONENT_GRAY_SHADER)
    local powerLayout = seatLayout:getChildByName("PowerLayout")
    local starImg = powerLayout:getChildByName("starImg")
    starImg:useShader(UI.COMPONENT_GRAY_SHADER)
    local powerTxt = powerLayout:getChildByName("powerTxt")
    powerTxt:setFontColor(UI.FONT_COLOR_190_190_190)

    for index = 1, 3 do
        local enemyBg = self.enemyBg[index]
        local backImg = enemyBg:getChildByName("backImg")
        backImg:useShader(UI.COMPONENT_GRAY_SHADER)
        local posImg = enemyBg:getChildByName("posImg")
        posImg:useShader(UI.COMPONENT_GRAY_SHADER)
        local enemyIcon = enemyBg:getChildByName("enemyIcon")
        if enemyIcon then
            enemyIcon:useShader(UI.COMPONENT_GRAY_SHADER)
        end
    end

    local passImg = seatLayout:getChildByName("passImg")
    if not passImg then
        passImg = UI.Image:create()
        passImg:init("ui_pettreasure_clearup.png")
        passImg:leftBottom(-94, -48)
        passImg:hide()
        passImg:setName("passImg")
        seatLayout:addChild(passImg, 100)
    end

    local passEff = seatLayout:getChildByName("passEff")
    if not passEff then
        passEff = UI.Animation:create()
        passEff:init("effect_ui_town_pettreasure_clearup.json", "effect_ui_town_pettreasure_clearup.atlas", 1)
        passEff:leftBottom(20, 4)
        passEff:setName("passEff")
        seatLayout:addChild(passEff, 100)

        passEff:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function()
            if not self or tolua.isnull(self) then
                return
            end

            self.updateSign = UPDATE_SIGN.NO_CHANGE

            UI.WaitingLayer:hideWaiting()
            UI.ScrollBar:createByText(UI.TEXT_1314133)
        end)
    end

    if self.updateSign == UPDATE_SIGN.SHOW_PASS then
        passImg:hide()
        passEff:setAnimation("tigger", false)
    elseif self.updateSign == UPDATE_SIGN.NO_CHANGE then
        passImg:show()
    end
    
end

function PetTreasureEmbattleLayer:showNewEnemy()
    local seatLayout = self.contentLayout:getChildByName("enemySeatLayout")
    local seatBg = seatLayout:getChildByName("seatBg")
    seatBg:useShader(UI.COMPONENT_NORMAL_SHADER)
    local titleBg = seatLayout:getChildByName("titleBg")
    titleBg:useShader(UI.COMPONENT_NORMAL_SHADER)
    local powerLayout = seatLayout:getChildByName("PowerLayout")
    local starImg = powerLayout:getChildByName("starImg")
    starImg:useShader(UI.COMPONENT_NORMAL_SHADER)
    local powerTxt = powerLayout:getChildByName("powerTxt")
    powerTxt:setFontColor(UI.FONT_COLOR_250_211_124)

    for index = 1, 3 do
        local enemyBg = self.enemyBg[index]
        local backImg = enemyBg:getChildByName("backImg")
        backImg:useShader(UI.COMPONENT_NORMAL_SHADER)
        local posImg = enemyBg:getChildByName("posImg")
        posImg:useShader(UI.COMPONENT_NORMAL_SHADER)
        local enemyIcon = enemyBg:getChildByName("enemyIcon")
        if enemyIcon then
            enemyIcon:useShader(UI.COMPONENT_NORMAL_SHADER)
        end
    end

    local passEff = seatLayout:getChildByName("passEff")
    if passEff then
        seatLayout:removeChildByName("passEff")
    end

    local passImg = seatLayout:getChildByName("passImg")
    if passImg then
        passImg:hide()
    end
end

function PetTreasureEmbattleLayer:setUpdateSign(index)
    self.updateSign = index
end

function PetTreasureEmbattleLayer:setCanDragItem(value)
    self.canDragItem = value
end

function PetTreasureEmbattleLayer:bindModel()

end

function PetTreasureEmbattleLayer:unbindModel()

end

function PetTreasureEmbattleLayer:petAdvSlotDragEnd(petData, touchPosition)

    local seatLayout = self.contentLayout:getChildByName("workersSeatLayout")
    local seatBg = seatLayout:getChildByName("seatBg")

    local pos = seatBg:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    local size = seatBg:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        -- 派遣状态下
        -- if mvc.petTreasureModel:getIsGathering() then
        --     local gatherPets = mvc.petTreasureModel:getWorkersData()
        --     for _, v in pairs(gatherPets) do
        --         if v:getId() == petData:getId() then
        --             UI.ScrollBar:createByText(UI.TEXT_221105)
        --             return
        --         end
        --     end
        -- end
        if mvc.dockModel:isSailing() then
            if mvc.dockModel:checkPetIsSailing(petData:getId()) then
                UI.ScrollBar:createByText(UI.TEXT_221932)
                return
            end
        end
        self:addCenterAdvPet(petData)
    end
end

function PetTreasureEmbattleLayer:addCenterAdvPet(petData)
    local petData = petData

    local seatLayout = self.contentLayout:getChildByName("workersSeatLayout")

    local index = 0
    for i = 1, 3 do
        if not self.petAdventureList[i] or not self.petAdventureList[i].templateID then
            self.petAdventureList[i] = petData
            index = i
            break
        end
    end
    mvc.petTreasureModel:setPetAdvEmbattlePets(self.petAdventureList)
    petData.petPosIndex = index

    local workerBg = self.workerBg[index]
    local workerIcon = workerBg:getChildByName("workerIcon")
    if workerIcon then
        workerBg:removeChildByName("workerIcon")
    end
    workerIcon = UI.PetMainListCell:create()
    workerIcon:init(nil, false, false, true, petData)
    workerIcon:center()
    workerIcon:setName("workerIcon")
    workerBg:addChild(workerIcon)

    workerIcon:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onPetIconTouchMove)
    workerIcon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onPetIconTouchEnd)

    local powerLayout = seatLayout:getChildByName("PowerLayout")
    local powerTxt = powerLayout:getChildByName("powerTxt")
    local power = mvc.petTreasureModel:getAdvEmbattlePower()
    powerTxt:setText(powerTxt:numformat(tostring(power)))
end

function PetTreasureEmbattleLayer:getPetAdventureList()
    return self.petAdventureList
end

return PetTreasureEmbattleLayer
