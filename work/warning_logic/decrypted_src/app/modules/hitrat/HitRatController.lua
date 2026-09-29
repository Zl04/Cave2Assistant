--[[--
控制器HitRatController，view已经注入,可以通过mvc.hitRatProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongjian.yang
-- date	: 2019/10/10
-- desc	: 
------------------------------------------------------------------------------
local HitRatController = class("HitRatController", mvc.GameController)
local MachineManager = require("app.game.MachineManager")
local MapDefine = require "app.mapkit.MapDefine"
require "app.renderer.component.ClickFloorHitRatEffectComponent"

function HitRatController:requestBpShopBuy(x, y)
    local data = {}
    data.hammerID = mvc.hitRatModel:getHammerId()
    data.x = x
    data.y = y
    Net.Helper:sendMessage(NetMessageType.LOGIC_RAT_USE_HAMMER_REQ, data)
end

local hammerArea = {
    {5}, {2,4,5,6,8},{2,5,8},{4,5,6},{1,2,3,4,5,6,7,8,9},{1,2,3,4,5,6,7,8,9}
}

function HitRatController:doHammerHit(coordX, coordY)
    local battleView = MachineManager:getInstance():getMachine():getView()

    if battleView._map and (not self._initClickHitRatEffect or tolua.isnull(self._clickFloorHitRatEffect)) then
        local pos = {}
        for i = 0, 2 do
           for j = 0, 2 do
            local coordZ = battleView:getMapTileCoordZ(i, j)
            local posX, posY = battleView:getMapTilePosition(i, j, coordZ)
            table.insert(pos, {posX, posY})
           end 
        end
        self._clickFloorHitRatEffect = Component.ClickFloorHitRatEffectComponent:create(pos)
        battleView._map:addNodeOnGround(self._clickFloorHitRatEffect)
        self._initClickHitRatEffect = true
    end

    local coordZ = battleView:getMapTileCoordZ(coordX, coordY)
    local posX, posY = battleView:getMapTilePosition(coordX, coordY, coordZ)
    self._clickFloorHitRatEffect:setShowIdx(hammerArea[mvc.hitRatModel:getHammerId()])
    
    self._clickFloorHitRatEffect:showHitEffect(true)
    self._clickFloorHitRatEffect:setPosition(posX, posY)
    self._clickFloorHitRatEffect:setLocalZOrder(coordZ + 10000)
    self._clickFloorHitRatEffect:runEffect()
end





-- mvc.events.HTI_RAT_HAMMER_CLICK 处理函数
-- function HitRatController:noticeHTIRATHAMMERCLICK(notification, x, y)
--     self:requestBpShopBuy(x, y)
-- end



-- mvc.events.HIT_RAT_TILE_TOUCH 处理函数
function HitRatController:noticeHITRATTILETOUCH(notification, touchType,  coordX, coordY , touchPosition, tileData)
    if touchType == "click" then
        if not tileData then
            return
        end
        if tileData:getTerrainType() ~= MapDefine.TerrainType.Ground then
            return
        end

        if coordX < 3 or coordX >  7 then
            return
        end
        
        local roleDatas = tileData.roleDatas
        if(#roleDatas > 0) then
            for i=#roleDatas, 1, -1 do
                local roleData = roleDatas[i]
                if(roleData and roleData:getCategory() == Category.TRIGGER_NPC) then
                    Net.NetNPCSystem:openTriggerNpcRequest(roleData.spriteID)
                    return
                end
            end
        end

        if mvc.hitRatModel:isOverloadHot() then
            UI.ScrollBar:createByText(UI.TEXT_1213326)
            return
        end
        if mvc.hitRatModel:getHammerId() > 1 then
            Avalon.AudioManager:playSound("1077")
        else
            Avalon.AudioManager:playSound("1076")
        end
       
        self:doHammerHit(coordX, coordY)
        if self.hitRatHammerView then
            self.hitRatHammerView:updateHammerOnTouchClick(touchPosition)
        end

        self:requestBpShopBuy(coordX, coordY )
    end
end



return HitRatController