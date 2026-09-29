-- PetSkillCell.lua
-- Author:siyu

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
UI = UI or {}

local PetSkillCell = class("PetSkillCell", UI.ListGrid)

UI.PetSkillCell = PetSkillCell

local COM_WIDTH = 90
local COM_HEIGHT = 90

local COM_RES_LIST = {
    "ui_common_grid.plist",
}
--构造函数(必备)
function PetSkillCell:ctor()
    PetSkillCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function PetSkillCell:dtor()
    PetSkillCell.super.dtor(self)
end

-- 初始化(必备)
function PetSkillCell:init()
    PetSkillCell.super.init(self)
    self:setTouchEnable(true)
    self:setSwallowTouches(false)
end

-- 模版函数：初始化组建的视图(必备)
function PetSkillCell:onInitView()
end

function PetSkillCell:onUpdateView()
    if not self._data then
        return
    end
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    self:updateSkillList()

    -- local gridBg = UI.Image:create()
    -- gridBg:init("box_quality_box_01.png")
    -- gridBg:center()
    -- self.cellLayout:addChild(gridBg)

    -- if self._data.emptySlot then
    --     self.goodsData = {}
    --     self.goodsData.emptySlot = true
    --     return
    -- end

    -- local goodsGrid = UI.GoodsGrid:create()
    -- goodsGrid:center()
    -- local goodsData = GoodsDataManager:createLocalGoodsData(self._data:getId())
    -- goodsData:setNum(self._data:getNum())
    -- goodsData:setIsNew(false)
    -- goodsData.isHaveGet = false
    -- goodsGrid:init(goodsData)
    -- goodsGrid:setInfoArea(false, false)
    -- gridBg:addChild(goodsGrid)
    -- self.goodsData = goodsData

    -- local select  = UI.Animation:create()
    -- select:init("effect_ui_gaming_itemselect.json",  "effect_ui_gaming_itemselect.atlas")
    -- select:center()
    -- select:hide()
    -- gridBg:addChild(select, 10)
    -- self.select = select
end

function PetSkillCell:getData()
    return self._data
end

function PetSkillCell:cellClick()
    -- if not self.select then
    --     self.select = UI.Animation:create()
    --     self.select:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas")
    --     self.select:center()
    --     self.cellLayout:addChild(self.select, 0)
    -- end

    -- self.select:show()
    -- self.select:setAnimation("start_square", false)
    -- self.select:addAnimation("loop_square", true)

    local select = self.oneSkill:getChildByName("Select")
    if not select then
        return
    end

    -- local skillData = Data.SkillData:create(self._data.skill)
    -- local tip = UI.SkillTips:create(skillData, 3)
    -- local viewWidth, viewHeight = tip:getSize()
    -- tip:leftBottom(- (viewWidth + 28), -42 + 0)
    -- tip:init()
    -- self:addChild(tip, 1000)

    select:show()
    select:setAnimation("trigger", false)
    select:addAnimation("idle", true)
end

function PetSkillCell:hide()
    local select = self.oneSkill:getChildByName("Select")
    if not select then
        return
    end
    select:hide()
end

function PetSkillCell:isClickShowInfo()
    return true
end

function PetSkillCell:clearSelect()
    if not self.select then
        return
    end

    self.select:setAnimation("end_square", false)
end


function PetSkillCell:updateSkillList()
    local oneSkill = self:addOneSkill(self._data)
    self.oneSkill = oneSkill
    self.cellLayout:addChild(oneSkill)
end

function PetSkillCell:addOneSkill(data)
    local skillLayer = UI.Layout:create()
    skillLayer:init()
    skillLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)
    skillLayer:center()
    --print("addOneSkill  data.y ---------->:   ", data.y)

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