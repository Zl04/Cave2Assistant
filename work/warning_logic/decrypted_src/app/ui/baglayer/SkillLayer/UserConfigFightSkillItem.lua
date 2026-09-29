-- UserConfigFightSkillItem.lua
--[[
  玩家配置技能按钮
]]--
local UserConfigFightSkillItem = class("UserConfigFightSkillItem",UI.HWBtnComponent)
UI = UI or {}
UI.UserConfigFightSkillItem = UserConfigFightSkillItem
local RES_LIST = {
}

local width  = 87
local height = 87
function UserConfigFightSkillItem:ctor()
    self.skillData = nil
    self.isSelect = false
    self.skillId = 0
    self.sprite = nil
    self.index = 0
    -- 冷却类型
    UserConfigFightSkillItem.super.ctor(self,UIType.SKILL_BUTTON, RES_LIST, width, height)
end



function UserConfigFightSkillItem:dtor()
    self.skillData = nil
    self.isSelect = nil
    self.skillId = 0
    UserConfigFightSkillItem.super.dtor(self)
    
end
function UserConfigFightSkillItem:init(skillData, index, isSelect)
    self.skillData = skillData
    self.index = index
    UserConfigFightSkillItem.super.init(self)
    self:setSelect(isSelect)
end


function UserConfigFightSkillItem:getSkillBoxSpriteName()
    if(RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
        return "ui_skill_banner_skillbox.png"
    else 
        return "ui_skill_banner_skillbox_transfer_bg.png"
    end
end

function UserConfigFightSkillItem:onInitView()
	local bg = UI.Image:create()
    bg:init(self:getSkillBoxSpriteName())
    bg:center()
    self:addChild(bg)
    self.bg = bg
    self:setTouchEnable(true)
    self:setCloseDrag(true)
    self:setSwallowTouches(false)
    self.skillId =  self.index or self.skillData and self.skillData:getId()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self, bg, touchPosition)
        self.beginTouchPosition = touchPosition
    end)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, bg, touchPosition)
        local distance = cc.pGetDistance(self.beginTouchPosition,touchPosition)
        if distance < 15 then
            self:dispatchEvent(UIEvent.EVENT_USER_CONFIG_SKILL, self, self.skillId, self.skillData)
        end
    end)

    if self.skillData then
	    -- 技能图标
	    local itemSp = UI.Image:create()
	    itemSp:init(self.skillData:getIconName())
	    itemSp:center()
	    self:addChild(itemSp) 
	    self.sprite = itemSp
    else
        local plusMark1 = UI.Image:create()
        plusMark1:init("ui_btn_team_add_0.png")
        plusMark1:center()
        self:addChild(plusMark1)
        self.sprite = plusMark1
   	end 

end

function UserConfigFightSkillItem:setSkillData(skillData)
	self.skillData = skillData
	if self.sprite then
		if self.skillData then
			self.sprite:setSpriteName(skillData:getIconName())
	    else
	        self.sprite:setSpriteName("ui_btn_team_add_0.png")
		end
	end
end

function UserConfigFightSkillItem:setGray(isGrey)
    self.sprite:setGray(isGrey)
    self.bg:setGray(isGrey)
    if self.selectBg then
        self.selectBg:setGray(isGrey)
        self.selectImg:setGray(isGrey)
    end
end

function UserConfigFightSkillItem:setSelect(isSelect, force)
	if isSelect == self.isSelect and not force then
		return
	end

	if isSelect then
	    local bg = UI.Image:create()
	    bg:init("ui_information_box.png")
	    bg:rightUp(5,5)
	    bg:setName("selectTag")
	    self:addChild(bg)  
        self.selectBg = bg
	    local itemSp = UI.Image:create()
	    itemSp:init("ui_information_btn_yes.png")
	    itemSp:centerBottom(10)
	    bg:addChild(itemSp)  
        self.selectImg = itemSp
	else
		self:removeChildByName("selectTag")
        self.selectBg = nil
	end
	self.isSelect = isSelect
end












