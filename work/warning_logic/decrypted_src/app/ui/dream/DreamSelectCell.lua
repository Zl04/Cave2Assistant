-- DreamSelectCell.lua
-- Author:ydli
-- 2019年3月04日
-- Using:梦境选关界面cell


local winSize = cc.Director:getInstance():getWinSize()
UI = UI or {}
local DreamSelectCell = class("DreamSelectCell", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
UI.DreamSelectCell = DreamSelectCell

local size = cc.size(260, 465)
local COM_RES_LIST = {
}

local BG_IMAGE = {"ui_dreamword_complete_bg.png", "ui_dreamword_click_box2.png", "ui_dreamword_unlock_bg.png"}
local BOX_IMAGE = {"ui_dreamword_complete_box.png", "ui_dreamword_click_box.png", "ui_dreamword_unlock_box.png"}
local TITLE_BG_IMAGE = {"ui_dreamword_click_line.png", "ui_dreamword_click_line.png", "ui_dreamword_unlock_line.png"}
local MONSTER_IMAGE = {"ui_dreamword_complete_boss_%d.png", "ui_dreamword_click_boss_%d.png", "ui_dreamword_unlock_boss_%d.png"}
local NAME_IMAGE = {"ui_dreamword_red_%d.png", "ui_dreamword_normal_%d.png", "ui_dreamword_normal_%d.png"}
local NAME_POS_BOTTOM = {65, 23, 28, 32, 28, 27}
function DreamSelectCell:ctor(index, data, status, parentNode, isNotFirstShowCell)
    DreamSelectCell.super.ctor(self, 0, COM_RES_LIST, size.width, size.height)
    self.status = status
    self.data = data
    self.index = index
	self.parentNode = parentNode
	self.isNotFirstShowCell = isNotFirstShowCell
	self.isPhase = MasterDataManager:getDreamData().dreamType == 1 and true or false
    self.buffIcon = {}
    self:registerListener()
    self:init()
end

function DreamSelectCell:dtor()
    DreamSelectCell.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function DreamSelectCell:init()
    DreamSelectCell.super.init(self)
    local bg = UI.Image:create()
    bg:init(BG_IMAGE[self.status])
    if self.status == DREAM_CELL_STATUS.SELECT then
        bg:centerBottom(-50)
    else
		bg:center()
	end
    self:addChild(bg)
    self.bg = bg
    if BOX_IMAGE[self.status] ~= "" then
	    local box = UI.Image:create()
	    box:init(BOX_IMAGE[self.status])
	    box:center()
	    bg:addChild(box)
	    if self.status == DREAM_CELL_STATUS.SELECT then
		    box:leftBottom(18, 9)
		elseif self.status == DREAM_CELL_STATUS.COMPLETED then
			box:leftBottom(43, 42)
	    else
		    box:leftBottom(73, 42)
    	end
	end

	local monster = UI.Image:create()
	monster:init(string.format(MONSTER_IMAGE[self.status], self.index))
	bg:addChild(monster)

	if self.status == DREAM_CELL_STATUS.SELECT then
        monster:leftBottom(18, 9)
    elseif self.status == DREAM_CELL_STATUS.COMPLETED then
	    monster:leftBottom(44, 43)
	else
        monster:leftBottom(73, 75)
	end

	if not self.isPhase and self.status ~= DREAM_CELL_STATUS.COMPLETED then
	    local titleBg = UI.Image:create()
	    titleBg:init(TITLE_BG_IMAGE[self.status])
	    bg:addChild(titleBg)
	    if self.status == DREAM_CELL_STATUS.SELECT then
            titleBg:leftUp(20, 58)
	    else
            titleBg:leftUp(18, 67)
	    end
	    local goodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.DreamIcon)
	    if (goodsData) then
	        local dreamIcon = UI.Image:create()
	        dreamIcon:init(goodsData:getSmallIconName())
	        dreamIcon:leftBottom(19, 20)
	        dreamIcon:setScale(1.3)
	        titleBg:addChild(dreamIcon)      
		end
		
        local number = UI.NumberText:create(self.data.dropNumber, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_BLACK)
        number:leftBottom(60, 24)
		titleBg:addChild(number)
	end

	local name = UI.Image:create()
	name:init(string.format(NAME_IMAGE[self.status], self.index))
	bg:addChild(name, 5)
	if self.status == DREAM_CELL_STATUS.SELECT then
        name:centerBottom(NAME_POS_BOTTOM[self.index] or 28)
    elseif self.status == DREAM_CELL_STATUS.COMPLETED then
    	name:setScale(0.8)
        name:centerBottom(NAME_POS_BOTTOM[self.index] or 28)
    else
    	name:setScale(0.8)
        name:centerBottom((NAME_POS_BOTTOM[self.index] or 28) * 0.8 - 24)
    end

    if self.status == DREAM_CELL_STATUS.COMPLETED then
    	local flag = UI.Image:create()
	    flag:init("ui_dreamword_complete.png")
	    flag:leftUp(37, 40)
	    bg:addChild(flag)
    end
    self:createBuff(self.data.bufferIDs)
    if self.status == DREAM_CELL_STATUS.SELECT and self.data.isUnlock then
        local refreshBtn = UI.Button:create()
    	refreshBtn:init("ui_dreamword_change.png", "ui_dreamword_change.png", "ui_dreamword_change.png")
    	refreshBtn:rightUp(13, 10)
		refreshBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function ()
			local dreamType = self.isPhase and 1 or 0
    		self:refeshBufClick(dreamType)
	    end)
	    refreshBtn:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, 360)))
    	bg:addChild(refreshBtn, 300)
    end

    if self.status == DREAM_CELL_STATUS.SELECT then
    	local mask  = UI.Image:create();
        mask:init("ui_dreamword_mask.png");
        mask:leftBottom(-2, -1);
        bg:addChild(mask);
    
        local lockAction = UI.Animation:create()
	    lockAction:init("effect_ui_dreamword_unlock.json", "effect_ui_dreamword_unlock.atlas", 1)
	    lockAction:centerBottom(170)
	    mask:addChild(lockAction, 100)
    	if self.data.isUnlock then
	        local lastIndex = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.dreamSelectLastUnlockActionIndex..GameDataManager:getInstance():getMasterPK(), -1)
		    if lastIndex == MasterDataManager:getDreamData().curBossIndex then
		        mask:removeFromParent()
		        lockAction:removeFromParent()
		    else
		    	lockAction:setAnimation("idle", true)

		    	Avalon.Scheduler:scheduleUpdateOnce(self, function() 
		    		if lockAction and not tolua.isnull(lockAction) then
	                	lockAction:setAnimation("unlock", false)
	                end
    			end, 0.6)
	            cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.dreamSelectLastUnlockActionIndex..GameDataManager:getInstance():getMasterPK(), MasterDataManager:getDreamData().curBossIndex) 
		        lockAction:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event, target)
                    if event.animation == "unlock" then
                        target:getParent():runAction(
					        cc.RemoveSelf:create()
					    )
                    end
                end)
		    end
    	else
	    	lockAction:setAnimation("idle", true)
		end
    end

	if self.status == DREAM_CELL_STATUS.SELECT then
		--spine
		if not self.isNotFirstShowCell then
			Avalon.Scheduler:scheduleUpdateOnce(self, function() 
				if self and not tolua.isnull(self) then
					local upAction = UI.Animation:create()
					upAction:init("effect_ui_dreamword_up.json", "effect_ui_dreamword_up.atlas", 1)
					upAction:center(-9, -2)
					upAction:setAnimation("begin2", false)

					bg:addChild(upAction, 100)
					Avalon.AudioManager:playSound("1542", false)
					
					local endAction = UI.Animation:create()
					endAction:init("effect_ui_dreamword_down.json", "effect_ui_dreamword_down.atlas", 1)
					endAction:leftBottom(125, 270)
					if self.isPhase then
						endAction:setAnimation("begin2",false)
					else
						endAction:setAnimation("begin",false)
					end
					-- endAction:setAnimation("begin",false)
					bg:addChild(endAction, -1)
					endAction:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event, target)
						if event.animation == "begin" or event.animation == "begin2" then
							self.isNotFirstShow = true
							if self.isPhase then
								endAction:setAnimation("idle2", true)
							else
								endAction:setAnimation("idle", true)
							end
						end
					end)
				end
			end, 0.6)
		else
			local endAction = UI.Animation:create()
			endAction:init("effect_ui_dreamword_down.json", "effect_ui_dreamword_down.atlas", 1)
			endAction:leftBottom(125, 270)
			bg:addChild(endAction, -1)

			if self.isPhase then
				endAction:setAnimation("idle2", true)
			else
				endAction:setAnimation("idle", true)
			end
		end
    end
end


function DreamSelectCell:createBuff(bufferIDs)
	local index = 0
	local beginX = -10
	local beginY = 30
	local spaceX = 15
	if self.status == DREAM_CELL_STATUS.COMPLETED then
 		beginX = 45
		beginY = 50
		spaceX = 11
	elseif self.status == DREAM_CELL_STATUS.SELECT then
		beginX = 46
		beginY = 70
		spaceX = 13
	else
        beginX = 38
		beginY = 72
		spaceX = 11
    end

	for k, v in ipairs(bufferIDs) do
	    local buffData = ConfigManager:getBufferConfigById(v)
	    if buffData then
	        local icon = UI.Image:create()
		    icon:init(buffData.iconID)
		    icon:setTouchEnable(true)
		    icon:rightUp(beginX + index * spaceX, beginY + index * 30)
		    self.bg:addChild(icon, 10)
		    index = index + 1
		    table.insert(self.buffIcon, icon)
		    icon:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(sender, comp, touchPosition)
		        if self.parentNode then
		        	local nodePosition = self.parentNode:convertToNodeSpace(touchPosition)
                    self.parentNode:showBufInfo(bufferIDs, nodePosition)
		        end
		    end)
		    icon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(sender, comp, touchPosition)
		        if self.parentNode then
                    self.parentNode:hideBufInfo()
		        end
		    end)
		end
	end
end

-- 模版函数：初始化组建的视图
function DreamSelectCell:onInitView()    

end

-- 模版函数：更新组建的视图
function DreamSelectCell:onUpdateView()

end

function DreamSelectCell:refeshBufClick(dreamType)
	if RoleBehaviorManager:dreamCheck() then
		printWarn(" been blocked when refresh dream buf!")
        return
	end
    local dreamData = MasterDataManager:getDreamData()
    local list = string.split(ConfigManager:getGeneralForKey("dreamRefreshCost"), ";")
    local cost = tonumber(list[dreamData.refreshNum + 1] or list[#list])
    if cost == 0 then
		UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetRoleSystem:requestRefreshDreamBuf(true, dreamType) 
	else
	    UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1212264, function()
	    	    local GameDataManager = require("app.game.GameDataManager")
	    	    if not Avalon.MathUtil:checkDiamonEnough(cost, GameDataManager:getInstance():getDiamond()) then
                    UI.ScrollBar:createByTextID(1170045)
	    	    else
					UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                    Net.NetRoleSystem:requestRefreshDreamBuf(false, dreamType) 
                end
	        end, function()
	            
	        end, nil, nil, false, cost)
    end
end

-- 注册监听事件(可选)
function DreamSelectCell:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_SINGLE_DREAM_BUFF, self, self.refreshBuff)
end

-- 注销监听事件(可选)
function DreamSelectCell:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_SINGLE_DREAM_BUFF, self, self.refreshBuff)
end

--只有当前选中的才刷新
function DreamSelectCell:refreshBuff()
	local dreamData = MasterDataManager:getDreamData()
	if self.isPhase then
		dreamData = dreamData.jump
	end
    if self.index == dreamData.curBossIndex then
        local buffInfos = dreamData.bossInfos[dreamData.curBossIndex].bufferIDs
        if buffInfos then
        	for k, v in ipairs(self.buffIcon) do
                v:removeFromParent()
        	end
        	self.buffIcon = {}
            self:createBuff(buffInfos)
        end
    end
end
