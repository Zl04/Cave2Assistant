------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 宠物技能公用面板
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetSkillLayer = class("PetSkillLayer", UI.BaseWin)

require "app.ui.baglayer.Horcurx.SkillTips"

require "app.modules.petreincarnation.PetSkillTableView"

UI = UI or {}

UI.PetSkillLayer = PetSkillLayer

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 384
local COM_HEIGHT = 178

function PetSkillLayer:ctor()
    PetSkillLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.tableviewSize = {width = 380, height = 163}
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.updateLayer)
end

-- isOther用来判断是否是别人的宠物
-- 如果为true 第一个参数传的是别人的宠物数据，如果为false 第一个参数传的是自己的宠物ID
function PetSkillLayer:init(petID, isOther, offsetY, ... )
    self.isOther = isOther or false
    if self.isOther then
        self.curPet = petID
    else
        if petID then
            self.curPet = MasterDataManager:getBagPetById(petID)
        else
            self.curPet = nil
        end
    end

    --print("PetSkillLayer:init petID ----->:  ", self.curPet)
    self.offsetY = offsetY or 0
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetSkillLayer.super.init(self, ... )
end

function PetSkillLayer:dtor()
    PetSkillLayer.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.updateLayer)

    reload_script_file_mvc("app.modules.pet.PetSkillLayer")
end

function PetSkillLayer:onInitView()
    self.skillObjs = {}
    self.curSelectIdx = 0
    self.lastSelectIdx = 0

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

function PetSkillLayer:updateToShow(petID, isOther, offsetY, ... )
    self.isOther = isOther or false
    if self.isOther then
        self.curPet = petID
    else
        if petID then
            self.curPet = MasterDataManager:getBagPetById(petID)
        else
            self.curPet = nil
        end
    end
    self.offsetY = offsetY or 0

    self:updateLayer()
end

function PetSkillLayer:updateLayer(petListIdx)
    if petListIdx and petListIdx > 0 then
        self.curPet = MasterDataManager:getBagPets()[petListIdx]
    end

    self.contentLayout:removeAllChildren()
    self.skillObjs = {}

    --print(debug.traceback("Stack trace111"))

    performWithDelay(self, function()
        -- 技能
        self:assembleSkill()

        for k, v in ipairs(self.skillData) do
            local oneSkill = self:addOneSkill(v)
            --self.contentLayout:addChild(oneSkill)

            table.insert(self.skillObjs, oneSkill)
        end
        local petId = nil
        if self.curPet then
           petId = self.curPet:getId()
        end
        local PetSkillTableView = UI.PetSkillTableView:create()
        PetSkillTableView:init(petId)
        PetSkillTableView:leftUp(5, -395)
        self.contentLayout:addChild(PetSkillTableView, 1)
        PetSkillTableView:setTableViewSize(self.tableviewSize)
        PetSkillTableView:updateSkillList(self.skillData)
        self.PetSkillTableView = PetSkillTableView

    end, 0)
end

function PetSkillLayer:assembleSkill()
    self.skillData = {}

    local ids = {1, 2, 3, 4, 5, 6, 7, 8}

    if self.curPet then
        local ReincarntionLv = self.curPet:getReincarntionLv()
        if ReincarntionLv > 0 or self.curPet.petquality == PublicDefine.PetQualityType.Platinum then
            local detailConfig = ConfigManager:getAllPetReincarnationDataByID(ReincarntionLv)
            local addSkillNum = detailConfig.addSkillNum
            -- for i=1,addSkillNum do
            --     table.insert(ids, (#ids + i))
            -- end
            ids = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        end
    end

    -- local xArr = {26, 120, 210, 300, 26, 120, 210, 300}
    -- local yArr = {20, 20, 20, 20, 97, 97, 97, 97}
    for k, v in ipairs(ids) do
        local oneSkill = {}
        oneSkill.idx = k
        -- oneSkill.x = xArr[k]
        -- oneSkill.y = yArr[k]
        oneSkill.isLock = false
        oneSkill.isUnkown = false
        oneSkill.isGiftSkill = false
        oneSkill.skill = nil

        if not self.curPet then
            oneSkill.isUnkown = true
        else
            if k == 8 or k == 9 then
                -- 特质技能
                oneSkill.skill = k == 8 and self.curPet:getGiftedSkill() or self.curPet:getGiftedSkill2()
                if oneSkill.skill then
                    oneSkill.isGiftSkill = true
                else
                    oneSkill.isLock = true
                end
            else
                local cfgIdx = self.curPet.isVariant and 2 or 1
                oneSkill.isLock = oneSkill.idx > self.curPet.skillNum[cfgIdx]

                local allSkills = self.curPet:getAllSkills()
                oneSkill.skill = allSkills[k] or nil
            end
        end

        table.insert(self.skillData, oneSkill)
    end
end

function PetSkillLayer:addOneSkill(data)
    local skillLayer = UI.Layout:create()
    skillLayer:init()
    skillLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)

    local skillBG  = UI.Image:create()
    -- 不知道的技能（宠物继承使用）
    if data.isUnkown then
        skillBG:init("ui_pets_skill_box_unkown.png")
        skillBG:center()
        skillLayer:addChild(skillBG)
        return skillLayer
    end

    -- 是否被锁住的技能格子（模版技能数量）
    if data.isLock then
        skillBG:init("ui_pets_skill_box_lock.png")
        skillBG:center()
        skillLayer:addChild(skillBG)
        return skillLayer
    end

    if not data.skill then
        skillBG:init("ui_pets_skill_box.png");
        skillBG:center();
        skillBG:setTouchEnable(true)
        skillBG:setSwallowTouches(true)
        skillBG:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
            --Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, UI.TEXT_1213729)
        end)
        skillBG:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
            --Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
        end)
        skillLayer:addChild(skillBG);
        return skillLayer
    end

    local selectEff = UI.Animation:create()
    -- 特质技能有特殊点击动效
    if data.isGiftSkill then
        selectEff:init("effect_ui_town_pet_skill_slot3.json", "effect_ui_town_pet_skill_slot3.atlas", 1)
    else
        selectEff:init("effect_ui_town_pet_skill_slot1.json", "effect_ui_town_pet_skill_slot1.atlas", 1)
    end
    selectEff:leftBottom(30, 32)
    selectEff:hide()
    selectEff:setName("Select")
    skillLayer:addChild(selectEff, 100)
    if data.isGiftSkill then
        skillBG:init("ui_pets_skill_box_pvp.png")
        skillBG:setImageScale(0.8)
    else
        skillBG:init("ui_pets_skill_box.png")
    end
    skillBG:center();
    skillLayer:addChild(skillBG);
    skillLayer:setTouchEnable(true)
    skillLayer:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self)
        self:skillClick(data.idx)
    end)

    local skillIcon = UI.Image:create()
    local skillCfg = ConfigManager:getSkillConfigById(data.skill)
    skillIcon:init(skillCfg.iconID)
    skillIcon:setImageScale(0.8)
    skillIcon:center()
    skillLayer:addChild(skillIcon)

    local skillData = SkillDataManager:createSkillForSkillId(skillCfg.skillID)
    if skillData:isActive() and not data.isGiftSkill then
        local ring  = UI.Image:create();
        ring:init("ui_information_headframe_box2.png");
        ring:setScaleX(0.8)
        ring:setScaleY(0.8)
        ring:center();
        skillLayer:addChild(ring, 0);
    end

    return skillLayer
end



function PetSkillLayer:skillClick(idx)
    -- TODO:广播点击消息

    local curSkillObj = self.skillObjs[idx]
    if not curSkillObj then
        return
    end

    local select = curSkillObj:getChildByName("Select")
    if not select then
        return
    end

    self.curSelectIdx = idx

    local curData = self.skillData[self.curSelectIdx]
    local skillData = Data.SkillData:create(curData.skill)
    -- print("PetSkillLayer ", curData.skill)
    if(self.curPet and self.curPet.isFight and self.curPet:isFight()) then 
        local petData = MasterDataManager:getFightPetbyId(self.curPet.spriteID) or RoleDataManager:getFightPetbyId(self.curPet.spriteID)
        if petData then 
            if petData:getSiteId() == 0 then
                skillData:setIsPetActive(true)
            end
        end
        -- print("PetSkillLayer 2", curData.skill)
    end

    local tip = UI.SkillTips:create(skillData, 3)
    local viewWidth, viewHeight = tip:getSize()
    tip:leftBottom(- (viewWidth + 28), -42 + self.offsetY)
    tip:init()
    self:addChild(tip, 1000)

    select:show()
    select:setAnimation("trigger", false)
    select:addAnimation("idle", true)

    if self.curSelectIdx~= self.lastSelectIdx and self.skillObjs[self.lastSelectIdx] then
        local lastSelect = self.skillObjs[self.lastSelectIdx]:getChildByName("Select")
        if lastSelect then
            lastSelect:hide()
        end
    end

    self.lastSelectIdx = self.curSelectIdx
end

-- 根据传入的技能数据直接进行更新
function PetSkillLayer:updateLayerByData(data)
    self.curPet = nil
    self.skillData = data

    self.contentLayout:removeAllChildren()
    self.skillObjs = {}

    performWithDelay(self, function()
        for k, v in ipairs(self.skillData) do
            local oneSkill = self:addOneSkill(v)
            --self.contentLayout:addChild(oneSkill)

            table.insert(self.skillObjs, oneSkill)
        end
        print("updateLayerByData------------>")
        local petId = nil
        if self.curPet then
           petId = self.curPet:getId()
        end
        local PetSkillTableView = UI.PetSkillTableView:create()
        PetSkillTableView:init(petId)
        PetSkillTableView:leftUp(5, -395)
        self.contentLayout:addChild(PetSkillTableView, 1)
        PetSkillTableView:setTableViewSize(self.tableviewSize)
        PetSkillTableView:updateSkillList(self.skillData)
        self.PetSkillTableView = PetSkillTableView

    end, 0)
end

-- 根据传入的技能数据直接进行更新
function PetSkillLayer:setTableViewSize(tableviewSize)
    self.tableviewSize = tableviewSize
end

function PetSkillLayer:bindModel()

end

function PetSkillLayer:unbindModel()

end

return PetSkillLayer
