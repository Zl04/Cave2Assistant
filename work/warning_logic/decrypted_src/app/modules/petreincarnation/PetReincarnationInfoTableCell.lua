-- PetReincarnationInfoTableCell.lua
-- Author:siyu

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local PetReincarnationInfoTableCell = class("PetReincarnationInfoTableCell", UI.ListGrid)

UI = UI or {}
UI.PetReincarnationInfoTableCell = PetReincarnationInfoTableCell

local COM_WIDTH = 200
local COM_HEIGHT = 90

local COM_RES_LIST = {
}
--构造函数(必备)
function PetReincarnationInfoTableCell:ctor()
    PetReincarnationInfoTableCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function PetReincarnationInfoTableCell:dtor()
    PetReincarnationInfoTableCell.super.dtor(self)
end

-- 初始化(必备)
function PetReincarnationInfoTableCell:init()
    PetReincarnationInfoTableCell.super.init(self)
    self:setTouchEnable(true)
    self:setSwallowTouches(false)
end

-- 模版函数：初始化组建的视图(必备)
function PetReincarnationInfoTableCell:onInitView()
end

function PetReincarnationInfoTableCell:onUpdateView()
    if not self._data then
        return
    end
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self._cellLayout = cellLayout
    self:addChild(cellLayout)

    self:updateSkillList()
end

function PetReincarnationInfoTableCell:getData()
    return self._data
end

function PetReincarnationInfoTableCell:cellClick()
end

function PetReincarnationInfoTableCell:hide()
end

function PetReincarnationInfoTableCell:isClickShowInfo()
    return true
end

function PetReincarnationInfoTableCell:clearSelect()
end


function PetReincarnationInfoTableCell:updateSkillList()
    local oneSkill = self:addOneSkill(self._data)
    self.oneSkill = oneSkill
    self._cellLayout:addChild(oneSkill)
end

function PetReincarnationInfoTableCell:addOneSkill(data)
    local skillLayer = UI.Layout:create()
    skillLayer:init()
    skillLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)
    skillLayer:center()

    local skillBG  = UI.Image:create()
    -- 是否有阴影背景
    if data.isBack then
        skillBG:init("ui_reincarnation_role_list.png")
        skillBG:center()
        skillLayer:addChild(skillBG)
    end

    -- 原始效果 UI.TEXT_110046
    if data.leftString then 
        local textString = UI.Text:create()
        textString:init(data.leftString, UI.FONT_BOLD, data.fontSize, data.color)
        textString:center(-130,0)
        textString:setTextLeft()
        skillLayer:addChild(textString)
    end

    -- 进阶图标
    local spriteIcon = UI.Image:create()
    spriteIcon:init("ui_skill_banner_arrow1-1.png")
    spriteIcon:center(-30,0)
    skillLayer:addChild(spriteIcon)

    -- 进阶后效果
    if data.rightString then 
        local textString = UI.Text:create()
        textString:init(data.rightString, UI.FONT_BOLD, data.fontSize, data.color)
        textString:centerLeft(70, 0)
        skillLayer:addChild(textString)

        if data.detailDes then
            local detailBtn = UI.Button:create() 
            detailBtn:init("ui_shopping_banner_prompt.png", "ui_shopping_banner_prompt.png", "ui_shopping_banner_prompt.png")
            detailBtn:centerLeft(170)
            textString:addChild(detailBtn)
            detailBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
                self:onClickDetailBtn(data.detailDes)
            end)
        end
    end

    return skillLayer
end

function PetReincarnationInfoTableCell:onClickDetailBtn(detailDes)
    -- 这里应该获取 self._data.detailDes值， 目前策划还没配，暂时用 1010001
    local str = LanguageManager:getLocalString(detailDes)
    local data = {
        tips = str,
        title = UI.TEXT_224302
    }
    mvc.send("PetReincarnation_Show_Detail_Layer", data)
end