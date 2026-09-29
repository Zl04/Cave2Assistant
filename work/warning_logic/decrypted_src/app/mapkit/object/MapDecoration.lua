local MapHelper = require "app.mapkit.MapHelper"
local MapDefine = require "app.mapkit.MapDefine"
local MapElement = require "app.mapkit.object.MapElement"
local MapDecoration = class("MapDecoration", MapElement)

local USE_TILED_POSITION_STRATEGY = true

function MapDecoration:ctor(map, data, tileWidth, tileHeight, inTown)
	self:setCoordinate(cx, cy)
	self.map = map
	self.tileWidth = tileWidth
	self.tileHeight = tileHeight
	self.offset = {x = 0, y = 0}
	self.visible = true
	self.inTown = inTown
	self.loadedPlist = {}
	self.loadSpineRes = {}
	self.progressKey = nil

	self:setData(data)
end

function MapDecoration:destroy()
	if(self.map) then
		self.map:removeTrapDecoration(self)
	end

	self.map = nil
	local sp = self.sprite or self.spine
	if sp ~= nil then
		if (sp:getParent()) then
			sp:removeFromParent()
		end
		sp:release()
	end
	self._timer = nil
	self._preTime = nil
	self.sprite = nil
	self.spine = nil
	for i,mapPlist in ipairs(self.loadedPlist) do
		Avalon.ResHelper:unloadPlist(mapPlist)
	end
	self.loadedPlist = {}	
    local textureCache = cc.Director:getInstance():getTextureCache()
	for i, atlasName in ipairs(self.loadSpineRes) do
        textureCache:removeTextureForKey(atlasName..".pvr.ccz")
	end
	self.loadSpineRes = {}

	Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_UPDATE_DECORETION_PROGRESS, self, self.updateDecoretionProgress)
end

function MapDecoration:setData(data)
	if (not data) then return end

	self.data = data
	self:setRadiationRadius(self.data.radiationRadius)
	self:setEffectColor(self.data.effectColor)

	self:setDirection(self.data.direction)
	self:setOccupySize(self.data.occupySize)
	self:setOffset(self.data.offset)
	self.flipAtX = self.data.flipAtX
	
	self:setUpSkin(self.data.skin)
end

function MapDecoration:getSpine()
	-- body
	return self.spine
end

function MapDecoration:clickSpine()
	-- body
	if(self.data and self.data:getIsTrap() and self.spine) then
		local nowAnimationName = self.spine:getAnimationName(0)
		if(nowAnimationName == "idle1" or nowAnimationName == "idle2") then
			local clickNum = self.data:getClickNum()
			local tapNum = self.data:getTapNum()
			-- print("MapDecoration:clickSpine", clickNum,tapNum)
			if(clickNum < tapNum) then
				clickNum = clickNum + 1
				self.data:setClickNum(clickNum)
				if(clickNum < tapNum) then
					self.spine:setAnimation(0, "trigger1", false)
					self.spine:addAnimation(0, "idle1", true)
				else
					self.spine:setAnimation(0, "trigger2", false)
					self.spine:addAnimation(0, "end", false)
				end
			else 
				--print("x,y=", self.data.x, self.data.y)
				--print("MapDecorationData testID=  clickSpine", self.data._testID, self.data:getTapNum(), self.data:getClickNum())
				self.spine:setAnimation(0, "trigger2", false)
				self.spine:addAnimation(0, "end", false)
				-- self.spine:setAnimation(0, "end", false)
			end
		end
	end 
end

function MapDecoration:setUpSkin(skin)
	local SceneManager = require("app.game.SceneManager")
	-- print ("set up decoration skin", skin, self.data.ID, SceneManager:getInstance():isManor())

	if SceneManager:getInstance():isManor() then
		local GameInManorManager = require "app.game.GameInManorManager"
		local skinName =  GameInManorManager:getInstance():getWholeManorFacade(self.data.ID)
		if skinName then
			skin = skinName
			self.data:setSkin(skin)
		end
	end

	self.name = skin
	
	local loadSkinPlist = function (townSkin)
		-- if is town building resources, should load texture atlas separately         
        local plist = townSkin:sub(1, #townSkin - 4) .. ".plist"
		Avalon.ResHelper:loadPlistSync(plist)
		table.insert( self.loadedPlist, plist )
	end

	-- Decoration skin may be split into pieces
	-- if so need to combine the pieces 
	local skins = skin:split(",")
	local skinCount = #skins
	if skinCount == 4 or skinCount == 9 then
		self.sprite = cc.Node:create()
		if self.sprite ~= nil then
			self.sprite:retain()

			local side = math.sqrt(skinCount) 
			local x, y, w, h = 0, 0, 0, 0
			for r = 1, side do
				for c = 1, side do
					local i = (r - 1) * side + c
					local sk = skins[i]
					if skin:hasPrefix("town_") then
						loadSkinPlist(sk)
					end
					local sp = MapHelper.createSprite(sk)
					if sp ~= nil then
						self.sprite:addChild(sp)
						sp:setAnchorPoint(0, 0)
						sp:setPosition(x, y)

						x = x + sp:getContentSize().width
						w = math.max(x, w)
						if c == side then 
							x = 0
							y = y + sp:getContentSize().height
							h = y
						end
					end
				end
			end
			print("combined decoration has content size ", w, h)
			self.sprite:setContentSize(w, h)
		end
	else
		-- add by zp 用于测试点击事件处理
		-- if self.data:isSkinPNG() then
		-- 	if(skin == "town_cacti_01.png") then
		-- 		skin = "role_maintown_teststone"
		-- 		self.data.skin = "role_maintown_teststone"
		-- 		self.data.type = 1
		-- 		self.data.trapNum = 10
		-- 	end
		-- end

		if self.data:isSkinPNG() then
			-- decorations in town and guild are big, so they are in separate texture atlas, and should load them separately
			-- if skin:hasPrefix("town_") or skin:hasPrefix("guild_") or skin:hasPrefix("guild_") then
				loadSkinPlist(skin)
			-- end

			self.sprite = MapHelper.createSprite(skin)
			if(self.data.rotate and self.data.rotate ~= 0) then 
				self.sprite:setAnchorPoint(0.5,0.5)
				self.sprite:rotate(self.data.rotate)
			end

			if(self.sprite and self.data.ExtraMethod and self.data.ExtraMethod ~= "") then 
				local arr = string.split(self.data.ExtraMethod, ";")
				-- "1;BOSS6_ENERGY_KEY"
				-- print("self.data.ExtraMethod=", skin, self.data.ExtraMethod, arr[3], num)

				local bg = cc.Sprite:create()
				bg:initWithFile(arr[3])
				local timer = cc.ProgressTimer:create(bg)
				timer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
				timer:setMidpoint(cc.p(1, 0))
				timer:setBarChangeRate(cc.p(1, 0))
				timer:setPercentage(0)
				timer:setPosition(self.sprite:getContentSize().width/2,self.sprite:getContentSize().height/2)
				self.sprite:addChild(timer, 10000)
				self._timer = timer
				self._preTime = nil

				self.progressKey = arr[2]
				if(arr and #arr >= 5) then 
					-- 处理周围动画表现
					local nameArr = string.split(arr[4], ",")
					
					local animName = nameArr[1]
					local animNum = tonumber(nameArr[2]) 
					local locationStr = arr[5]
					local locationArr = {}
					if(locationStr) then 
						local pointArr = string.split(locationStr, ":")
						if(pointArr) then 
							for _,v in ipairs(pointArr) do 
								local cointArr = string.split(v, ",")
								if(cointArr and #cointArr == 3) then
									table.insert(locationArr, {x = tonumber(cointArr[1]), y = tonumber(cointArr[2]), flip = tonumber(cointArr[3])})
								end
							end
						end
					end

					local waitingTime = 0
					local oldPregress = 0
					local showArr = {}
					Avalon.Scheduler:scheduleUpdate(self, function(this, dt)
						waitingTime = waitingTime + dt
						if(waitingTime > 0.2) then 
							waitingTime = 0
							local nowPregress = timer:getPercentage()
							if(nowPregress ~= oldPregress) then 
								oldPregress = nowPregress
								showArr = {}

								local startX = timer:getContentSize().width * (100-oldPregress) /100
								for k,v in ipairs(locationArr) do 
									if(v.x > startX) then 
										table.insert(showArr, v)
									end
								end
							end

							local parentNode = self.sprite:getParent()
							if(not tolua.isnull(parentNode) and showArr and #showArr > 0) then 
								local localZorder = self.sprite:getLocalZOrder()
								local x, y = 0, 0

								local triggerNum = 32
								if(#showArr < triggerNum) then 
									triggerNum = #showArr
								end

								-- 触发相关的逻辑处理
								for i=1, triggerNum, 1 do 
									local animation = Avalon.Animation:create(animName..".json", animName..".atlas", 1)
									local randomNum = math.random(1, animNum)
									animation:setAnimation(0, "stone_"..randomNum, false);
									animation:registerSpineEventHandler(function(event)
										-- print("animation  remove")
										if(animation) then
											animation:runAction(cc.RemoveSelf:create())
										end
									end, sp.EventType.ANIMATION_END)

									-- print("animation =", x, y, #showArr)
									local oneShow = showArr[math.random(1, #showArr)]
									-- print("animation =",x + oneShow.x, y + oneShow.y, oneShow.flip)

									local rotate = 0
									if(oneShow.flip == 1) then 
										rotate = rotate + 180
									end
									animation:setRotation(rotate)

									animation:setPosition(x + oneShow.x, y + oneShow.y)
									-- parentNode:addChild(animation, localZorder - 1)
									self.sprite:addChild(animation,100)
								end
							end
						end
					end)
				end

				Avalon.MessageCenter:bind(AvalonMessage.MC_UI_UPDATE_DECORETION_PROGRESS, self, self.updateDecoretionProgress)
			end

			if self.sprite ~= nil then
				if(self.data.light == 1) then
					-- print("ddddddddddddddddddddddd  skin=", skin)
					-- add by zp 添加高亮的光影效果
					self.sprite:setBlendFunc(cc.blendFunc(gl.DST_COLOR , gl.ONE))
					-- self.sprite:setOpacity(255*0.7)
					self.sprite:setGLProgram(self:loadShader("ColorDodge", true))
				end

				-- printfmt2("create decoration with png file %s", skin)
				self.sprite:retain()
			end
		else
			self.spine = sp.SkeletonAnimation:create(skin .. ".json", skin .. ".atlas")
			if self.spine ~= nil then
				table.insert(self.loadSpineRes, skin)
				-- print("-----create decoration with spine file %s", skin)
				self.spine:retain()

				if(self.data.rotate and self.data.rotate ~= 0) then 
					self.spine:setAnchorPoint(0.5,0.5)
					self.spine:setRotation(self.data.rotate)
				end

				if(self.data:getIsTrap()) then
					local clickNum = self.data:getClickNum()
					local tapNum = self.data:getTapNum()
					if(clickNum < tapNum) then
						self.spine:setAnimation(0, "idle1", true)
					else 
						self.spine:setAnimation(0, "end", false)
					end

					self.map:addTrapDecoration(self)
				else 
					self.spine:setAnimation(0, "idle", true)
				end

				self.spine:registerSpineEventHandler(function (event)
					if(event and event.eventData and event.eventData.name) then
						local startPos = string.find(event.eventData.name, "sound_")
						if(startPos ~= nil) then
							-- 播放音效文件
							local soundFilename = string.sub(event.eventData.name,7,-1)
							local coordX, coordY = self:getCoordinate()
							Avalon.AudioManager:playDynamicSound(soundFilename,nil,{x=coordX,y=coordY})
						end

						local shakePos = string.find(event.eventData.name, "hitshake_")
						if(shakePos ~= nil) then
							-- 播放抖动
							local shake = string.sub(event.eventData.name,10,-1)
							if(shake) then 
								Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
							end
						end
					end
				end, sp.EventType.ANIMATION_EVENT)
			end
		end

	end
	self:adjustSkin()
end

function MapDecoration:loadShader(shaderName, noMVP)
    local keyOfShader = shaderName
    if noMVP == true then
        keyOfShader = keyOfShader.."_noMVP"
    end
    local shader = cc.GLProgramCache:getInstance():getGLProgram(keyOfShader)
    if shader ~= nil then
        return  shader
    end
    local vshFile = "shaders/DefaultShader.vsh"
    local fshFile = "shaders/"..shaderName..".fsh"
    if noMVP == false then
        vshFile = "shader/DefaultMVPShader.vsh"
    end

    -- shader = cc.GLProgram:createWithFilenames(vshFile,fshFile)
    -- -- shader:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
    -- -- shader:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
    -- -- shader:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_TEX_COORD)
    -- -- shader:link()
    -- -- shader:updateUniforms()
	-- cc.GLProgramCache:getInstance():addGLProgram(shader, keyOfShader)
	shader = AvalonUtil:getGLProgram(vshFile, fshFile)

    return shader
end

function MapDecoration:adjustSkin()
	-- decoration has default direction west
	-- if direction is south, should flip at x axis too
	if self:getDirection() == MapDefine.DirectionType.South or self.flipAtX then
		if self.sprite then
			self.sprite:setFlippedX(true)
		else
			self.spine:setScaleX(-1.0)
		end
	end

	if self.sprite then
		if self.inTown or not USE_TILED_POSITION_STRATEGY then 
			self.sprite:setAnchorPoint(0.5, 0.5)
		else
			if self:getDirection() == MapDefine.DirectionType.West then
				self.sprite:setAnchorPoint(0, 0)
			elseif self:getDirection() == MapDefine.DirectionType.South then
				self.sprite:setAnchorPoint(1, 0)
			end
		end
	else 
		-- if self:getOccupySize().width > 1 or self:getOccupySize().height > 1 then
			-- self:setOffset({x = self.offset.x - self.tileWidth * 0.5 + self.tileWidth * self.occupySize.width * 0.5, 
			-- y = self.offset.y - self.tileHeight * 0.5 + self.tileHeight * self.occupySize.height * 0.5})
		-- end
	end
end	

function MapDecoration:runAnim(animName,loop)
	if self.spine ~= nil then
		if(self.data and self.data:getIsTrap()) then
			-- 这里不处理该指令
			
		else 
			self.spine:setAnimation(0, animName,loop) 
		end 
	end
end

function MapDecoration:addAnim(animName,loop)
	if self.spine ~= nil then
		if(self.data and self.data:getIsTrap()) then
			-- 这里不处理该指令
			
		else 
			self.spine:addAnimation(0, animName, loop) 
		end 
	end
end

-- 修改z序  add by zp
function MapDecoration:changeZOrder(changeOrder)
	local sp = self.sprite or self.spine
	if(sp ~= nil and self._changeOrder == nil) then
		sp:setLocalZOrder(sp:getLocalZOrder() + changeOrder)
		self._changeOrder = changeOrder
	end

end

function MapDecoration:addToMap_bak(map, position, zorder)
	-- self.map = map
	local pos = { x = position.x, y = position.y}
	if self.occupySize ~= nil then
		local tileWidthHalf = self.tileWidth * 0.5
		local tileHeightHalf = self.tileHeight * 0.5
		local occupyWidth = self:getOccupySize().width
		local occupyHeight = self:getOccupySize().height 

		-- print ("add decoration at pos222", pos.x, pos.y, self.occupySize.width, self.occupySize.height, self.tileWidth, self.tileHeight)
		if self.inTown or not USE_TILED_POSITION_STRATEGY then 
			if self:getDirection() == MapDefine.DirectionType.West then
				pos = {x = pos.x - tileWidthHalf * occupyHeight + (occupyWidth + occupyHeight) * tileWidthHalf * 0.5, 
					y = pos.y - tileHeightHalf + (occupyWidth + occupyHeight) * tileHeightHalf * 0.5} 
			elseif self:getDirection() == MapDefine.DirectionType.South then
				pos = {x = pos.x + tileWidthHalf * occupyWidth - (occupyWidth + occupyHeight) * tileWidthHalf * 0.5, 
					y = pos.y - tileHeightHalf + (occupyWidth + occupyHeight) * tileHeightHalf * 0.5}
			end
		else
			if self.data:isSkinPNG() then
				if self:getDirection() == MapDefine.DirectionType.West then
					pos = {x = pos.x - tileWidthHalf * occupyHeight, y = pos.y - tileHeightHalf}
					if occupyWidth > 1 or occupyHeight > 1 then
						pos = {x = pos.x, y = pos.y + tileHeightHalf * (occupyHeight - 1)}
					end
				elseif self:getDirection() == MapDefine.DirectionType.South then
					pos = {x = pos.x + tileWidthHalf * occupyWidth, y = pos.y - tileHeightHalf}
					if occupyWidth > 1 or occupyHeight > 1 then
						pos = {x = pos.x, y = pos.y + tileHeightHalf * (occupyWidth - 1)}
					end
				end
			else
				if self:getDirection() == MapDefine.DirectionType.West then
					pos = {x = pos.x - tileWidthHalf * occupyHeight + (occupyWidth + occupyHeight) * tileWidthHalf * 0.5, 
						y = pos.y - tileHeightHalf + (occupyWidth + occupyHeight) * tileHeightHalf * 0.5} 
				elseif self:getDirection() == MapDefine.DirectionType.South then
					pos = {x = pos.x + tileWidthHalf * occupyWidth - (occupyWidth + occupyHeight) * tileWidthHalf * 0.5, 
						y = pos.y - tileHeightHalf + (occupyWidth + occupyHeight) * tileHeightHalf * 0.5}
				end
			end
		end
	end

	if self.offset ~= nil then
		pos = {x = pos.x + self.offset.x, y = pos.y + self.offset.y}
	end
	local sp = self.sprite or self.spine
	if sp ~= nil then
		if self.data:getFinalTerrainType() == MapDefine.TerrainType.Wall then 
			map:getLayer(MapDefine.LayerIndexNodeOnMap):addChild(sp, zorder)
		else 
			if self.data:isOnGround() then
				map:getLayer(MapDefine.LayerIndexNodeOnGround):addChild(sp, zorder)
				-- print ("add decoration on ground ", self.data.skin, self:getCoordinate())
			else 
				-- print ("add decoration on map ", self.data.skin, self:getCoordinate())
				map:getLayer(MapDefine.LayerIndexNodeOnMap):addChild(sp, zorder)
			end
		end
		sp:setPosition(pos)
	end
end

function MapDecoration:addToMap(map, position, zorder)
	if (map and position and zorder) then
		self:addToMap_bak(map, position, zorder)
	else
		map = self.map
		local sp = self.sprite or self.spine
		if sp ~= nil and sp:getParent() == nil then
			if self.data:getFinalTerrainType() == MapDefine.TerrainType.Wall then 
				map:getLayer(MapDefine.LayerIndexNodeOnMap):addChild(sp)
			else 
				if self.data:isOnGround() then
					map:getLayer(MapDefine.LayerIndexNodeOnGround):addChild(sp)
				else
					map:getLayer(MapDefine.LayerIndexNodeOnMap):addChild(sp)
				end
			end
		end
	end
end

function MapDecoration:getNode()
	local sp = self.sprite or self.spine
	return sp
end

function MapDecoration:removeFromMap(animated)
	local sp = self.sprite or self.spine
	if sp ~= nil then
		local function cb()
			-- printfmt("run decoration remove from map callback")
			sp:removeFromParent()
			-- sp:release()
		end
		if animated then
			
			local seq = cc.Sequence:create(cc.FadeOut:create(MapDefine.ElementRemoveDuration), cc.CallFunc:create(cb))
			if seq then 
				sp:runAction(seq)
			end
		else
			cb();
		end
		
		
	end
end

function MapDecoration:fadeAction(isIn, progress)
	if isIn then
		if not self.visible then
			if progress == 1 then
				self.visible = true
			end
			local sp = self.sprite or self.spine
			if sp ~= nil then
				sp:setOpacity(255 * progress)	
			end
		end
	else 
		if self.visible then
			if progress == 1 then
				self.visible = false
			end
			local sp = self.sprite or self.spine
			if sp ~= nil then
				sp:setOpacity(255 * (1 - progress))
			end
		end
	end

	self.isIn = isIn
end

function MapDecoration:setVisible(visible)
	local sp = self.sprite or self.spine
	if sp then 
		sp:setVisible(visible)
	end
end

function MapDecoration:updateAppearance(progress)
	local sp = self.sprite or self.spine
	if(sp ~= nil) then
		if self.isIn  then
			if not self.visible then
				if progress == 1 then
					self.visible = true
				end
				sp:setOpacity(255 * progress)	
			end
		else 
			if self.visible then
				if progress == 1 then
					self.visible = false
				end
				sp:setOpacity(255 * (1 - progress))
			end
			
		end
	end
end

function MapDecoration:updateDecoretionProgress(key, progress)
	-- print("MapDecoration:updateDecoretionProgress 1", key, progress)
	if(not tolua.isnull(self._timer) and self.data) then 
		if(self.progressKey == key and self.preProgress ~= progress) then 
			self.preProgress = progress
			local oneStepTime = 1000

			local totalTime = oneStepTime
			local endProgress = 0

			if(self._preTime ~= nil) then 
				totalTime = AvalonUtil.getCurrentTime() - self._preTime
			end
			self._preTime = AvalonUtil.getCurrentTime()
			if(progress == 0) then 
				endProgress = 0
				totalTime = 500
			else
				local oldPregress = self._timer:getPercentage()
				local pro = (progress*100 - oldPregress) * 2
				if(pro < 0) then 
					endProgress = progress * 100 + 2.5
				else 
					endProgress = pro + oldPregress
				end
				
				if(endProgress > 100) then 
					endProgress = 100
				end

				totalTime = totalTime * 2
			end


			-- print("MapDecoration:updateDecoretionProgress 2", totalTime, endProgress, oldPregress)
			-- self._timer:setPercentage(progress * 100)
			self._timer:stopAllActions()
			self._timer:runAction(cc.ProgressTo:create(totalTime/1000, endProgress))
		end
	end
end

return MapDecoration