--[[
AngerProgressComponent.lua
	玩家怒气槽
]]


local AngerProgressComponent = class("AngerProgressComponent", cc.Node)

local angerSpritePng = {{"ui_gaming_energy_00.png", "ui_gaming_energy_10.png", "ui_gaming_energy_max.png"},
{"ui_gaming_monste_energy_00.png", "ui_gaming_monste_energy_10.png", "ui_gaming_monste_energy_max_2.png"},
{"ui_gaming_horcrux_energy_00.png", "ui_gaming_horcrux_energy_10.png", "ui_gaming_horcrux_energy_max_2.png"},
}

local pngs
-- 构造函数
function AngerProgressComponent:ctor(percent, progressType, isNeedFipped)
  	self.percent = 0
  	self.fullSprite = nil
  	if not progressType then
  		pngs = angerSpritePng[1]
    else
  		pngs = angerSpritePng[progressType]
    end
    self._bloodBg = UI.Image:create()
    self._bloodBg:init(pngs[1])
    self._bloodBg:center()
    self.isNeedFipped = isNeedFipped
    if self.isNeedFipped then
        self._bloodBg._sprite:setFlippedX(true)
    end
    self:addChild(self._bloodBg,1)
    local width = self._bloodBg:getContentSize().width
    local height = self._bloodBg:getContentSize().height
    self:setContentSize(width, height)

    local img = cc.Sprite:createWithSpriteFrameName(pngs[2])
    if self.isNeedFipped then
        img:setFlippedX(true)
    end
    self.progressImg = img
    local progress = cc.ProgressTimer:create(img)
	progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)  
    progress:setMidpoint(cc.p(0,0))  
    if progressType == 3 then
        progress:setBarChangeRate(cc.p(1, 0))
    else
        progress:setBarChangeRate(cc.p(0, 1))
    end  
	progress:setPosition(cc.p(width/2, height / 2))  
	self:addChild(progress,2)  
    self.progress = progress

	self:updateProcess(percent)
end

function AngerProgressComponent:setBarChange(from,to,time)

    assert(type(from) == "number", "[ERROR] ProgressTimer setBarChange: parameter from is invalid.")
    assert(type(to)   == "number", "[ERROR] ProgressTimer setBarChange: parameter to is invalid.")
    assert(type(time) == "number", "[ERROR] ProgressTimer setBarChange: parameter time is invalid.")
    if self.progress ~= nil then 
        -- 变化的效果
        self.progress:setPercentage(from*100)
        local to1 = cc.ProgressTo:create(time/1000, to*100)
        self.progress:runAction(to1)
    end
end

function AngerProgressComponent:setFlippedX(isNeedFipped)
    self.isNeedFipped = isNeedFipped
    self._bloodBg._sprite:setFlippedX(self.isNeedFipped )
    self.progressImg:setFlippedX(self.isNeedFipped )
    if self.fullSprite then
        self.fullSprite._sprite:setFlippedX(self.isNeedFipped)
    end
end


function AngerProgressComponent:updateProcess(percent)
	if self.progress then
		self.progress:stopAllActions()
	    self:setBarChange(self.percent,percent, percent - self.percent)
	end

	if percent >= 1 then
		if not self.fullSprite then
			self.fullSprite = UI.Image:create()
		    self.fullSprite:init(pngs[3])
		    self.fullSprite:center()
		    self:addChild(self.fullSprite,3)
            if self.isNeedFipped then
                self.fullSprite._sprite:setFlippedX(true)
            end
		end
	else
		if self.fullSprite then
			self.fullSprite:removeFromParent()
			self.fullSprite = nil
		end
	end
    self.percent = percent
end



return AngerProgressComponent