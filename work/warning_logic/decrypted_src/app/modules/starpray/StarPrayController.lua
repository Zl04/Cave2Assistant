--[[--
控制器StarPrayController，view已经注入,可以通过mvc.starPrayProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]]
------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/24
--desc	:
------------------------------------------------------------------------------

local StarPrayController = class("StarPrayController", mvc.GameController)
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()

--函数说明
--notification
function StarPrayController:noticeStarPrayChangeLayer(notification)
    local param = notification.params
    self.starPrayView:updateBagList(true)
    if param[1] == 1 then
        self.starPrayView:showRightView()
        self:hideView(self.starPraySwallowView, true)
        self:hideView(self.starPrayIncreaseView, true)
        self:showView(mvc.starPrayPanel, mvc.starPrayEquipView)
        self.starPrayView.bagView:show()
        self.starPrayView:hideTabList()
    elseif param[1] == 2 then
        self.starPrayView:showRightView()
        self:hideView(self.starPrayEquipView, true)
        self:hideView(self.starPrayIncreaseView, true)
        self:showView(mvc.starPrayPanel, mvc.starPraySwallowView)
        self.starPrayView.bagView:show()
        -- self.starPrayView:showTabList()
    elseif param[1] == 3 then
        self.starPrayView:hideRightView()
        self:hideView(self.starPraySwallowView, true)
        self:hideView(self.starPrayEquipView, true)
        self:showView(mvc.starPrayPanel, mvc.starPrayIncreaseView)
    end
end

function StarPrayController:onStarPrayTenShopResponse(isSucc ,goodsData ,starPrayPools ,costID ,costNum)
    if self.starPrayShopContentView then
        self.starPrayShopContentView:doTenDrawResult(isSucc ,goodsData ,starPrayPools ,costID ,costNum)
    end
end

function StarPrayController:onStarPrayEquipResponse()
    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function()
        if self.starPrayView then
            self.starPrayView:updateBagList(true)
        end
        
        self.starPrayEquipView:onUpdateContentView()
    end, 0.2)

    
end

function StarPrayController:onStarPraySwallowResponse(isSucc)
    print("StarPraySwallowView:onUpdateContentView()", isSucc)
    if not isSucc then
        return
    end
    UI.ScrollBar:createByText(UI.TEXT_1212458)

    if not self.starPraySwallowView then
        return
    end


    self.starPrayView.bagView:resetGoodsData()
    self.starPraySwallowView.mGoodsData._changeNum = -1

    mvc.starPrayModel:clearSwallowBag()
    self.starPraySwallowView:onUpdateContentView(isSucc)
    self.starPrayView:updateBagList()
    self.starPraySwallowView:updateExpPsg()
    self.starPraySwallowView:updateAddExp()
end

--函数说明
--notification
function StarPrayController:sendStarPrayEquip(instID, eqiupType)

    if eqiupType ~= 2 then --脱装备 需要判断背包是否满
        if not mvc.starPrayModel:isHaveFreePos(#instID) then
            UI.ScrollBar:createByText(languageManagerInstance:getLocalString(1170218))
            return
        end
    end
    local messageData = {}
    messageData.instID = instID
    messageData.isOn = eqiupType == 2 --=true#穿|false#脱
    messageData.npcid = mvc.starPrayModel:getNpcId()
    messageData.plateId = mvc.starPrayModel:getCurStarPlate()
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        messageData.npcid = 0
    end

    Net.Helper:sendMessage(NetMessageType.REQUEST_STAR_PRAY_WEAR, messageData)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

--函数说明
--notification
function StarPrayController:sendStarPraySwallow(entityid, foodInstIDs)
    local messageData = {}
    messageData.entityid = entityid
    messageData.foodInstIDs = foodInstIDs
    messageData.npcid = mvc.starPrayModel:getNpcId()
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        messageData.npcid = 0
    end
    Net.Helper:sendMessage(NetMessageType.REQUEST_STAR_PRAY_SWALLOW, messageData)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

--函数说明
--notification
function StarPrayController:noticeStarPrayBagTouchEnd(notification)
    local param = notification.params
    local grid, touchPosition, spID = param[1], param[2], param[3]

    if self.starPrayEquipView then
        if self.starPrayEquipView:isPositionInBag( touchPosition) then
            local idx = mvc.starPrayModel:findFreePosToEquip(spID)
            if idx then
                local goodsData = grid:getData()
                -- 该星痕是否可以装配
                if(goodsData and goodsData:getIsExpType()) then
                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170281))
                    return
                end

                if not mvc.starPrayModel:checkCanEquip(goodsData) then
                    UI.ScrollBar:createByText(UI.TEXT_1212465)
                    return
                end

                goodsData._changeNum = -1
                self.starPrayView:updateBagList()
                self:sendStarPrayEquip({goodsData:getEntityID()}, 2)
            else
                UI.ScrollBar:createByText(UI.TEXT_1212455)
            end
        end
    elseif self.starPraySwallowView then
        local goodsData = grid:getData()
        if not goodsData then
            return
        end
        local function toSwallTarget()
            -- 判断是否可以作为主吞噬为
            if(goodsData and goodsData:getIsExpType()) then
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170280))
                return
            end

            if not mvc.starPrayModel:checkCanSwallow(goodsData) then
                UI.ScrollBar:createByText(UI.TEXT_1212467)
                return
            end

            self.starPraySwallowView:updateTaregetGoodsData(goodsData)
            self.starPrayView:updateBagList()
            self.starPraySwallowView:showAnimationPutIn()
        end

        local targetData = self.starPraySwallowView:getTaregetGoodsData()
        local isInBag = self.starPrayView:isInScrollView(touchPosition)
        if not isInBag then
            if not targetData then
                toSwallTarget()
            else
                local isInTarget = self.starPraySwallowView:isInTargetArea(touchPosition)
                if isInTarget then
                    toSwallTarget()
                else
                    if not targetData then
                        UI.ScrollBar:createByText(UI.TEXT_1212459)
                        self.starPraySwallowView:showAnimationPutInCancel()
                        return
                    end
        
                    if goodsData:getIsLock() then
                        UI.ScrollBar:createByText(UI.TEXT_1212466)
                        return
                    end

                    --已经穿戴在身上的不能被吞噬
                    if mvc.starPrayModel:isEquiped(goodsData) then
                        UI.ScrollBar:createByText(UIUtil:lang(1112377))
                        return
                    end
        
                    local isAddSucc = mvc.starPrayModel:addSwallowGoodsData(goodsData)
                    if not isAddSucc then
                        UI.ScrollBar:createByText(UI.TEXT_1212468)
                        return
                    end
                    goodsData._changeNum = -1
                    self.starPrayView:updateBagList()
                    self.starPraySwallowView:updateAddExp()
                end
            end
        else
            if not targetData then
                self.starPraySwallowView:showAnimationPutInCancel()
            end
        end
    end
end

--函数说明
--notification
function StarPrayController:noticeStarPrayBagTouchBegin(notification)
    if self.starPraySwallowView then
        if not self.starPraySwallowView:getTaregetGoodsData() then
            self.starPraySwallowView:showAnimationPutInBegin()
        end
    end
end

--函数说明
--notification
function StarPrayController:noticeStarPrayEquipDoOneKey(notification)
    local args = mvc.starPrayModel:getOneKeyUnEquipIds()
    if #args > 0 then
        self:sendStarPrayEquip(args, 1)
        --print("unequip:", args)
    end

    local args = mvc.starPrayModel:getOneKeyEquipIds()
    if #args < 1 then
        UI.ScrollBar:createByText(UI.TEXT_1212463)
        return
    end
    self:sendStarPrayEquip(args, 2)
    --print("equip:", args)
end

--函数说明
--notification
function StarPrayController:noticeStarPrayEquipDoEquip(notification)
    local grid, inSide, touchPosition = notification.params[1], notification.params[2], notification.params[3]
    if not self.starPrayEquipView then
        return
    end
    if tolua.isnull(grid) then
        return
    end

    local isInBag = self.starPrayView:isInScrollView(touchPosition)
    if isInBag then
        if mvc.starPrayModel:getStarPrayPacketFreeBoxNum() <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_1212469)
            return
        end

        local goodsData = grid:getData()
        grid:reset()
        grid:updateView()
        grid:show()
        self:sendStarPrayEquip({goodsData:getEntityID()}, 1)
    end
end

--函数说明
--notification
function StarPrayController:noticeStarPraySwllowDoSwllow(notification)
    local goodsData = self.starPraySwallowView:getTaregetGoodsData()
    if not goodsData then
        UI.ScrollBar:createByText(UI.TEXT_1212456)
        return
    end

    -- 判断是否可以作为主吞噬为
    if(goodsData and goodsData:getIsExpType()) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170280))
        return
    end

    if not mvc.starPrayModel:checkCanSwallow(goodsData) then
        UI.ScrollBar:createByText(UI.TEXT_1212467)
        return
    end

    local ids, hasGoldRare, exp = mvc.starPrayModel:getSwallItemEntityIds()
    if #ids == 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212457)
        return
    end

    local maxExp = goodsData:getMaxExp()
    local localExp = goodsData:getSwallowExp() + goodsData.exp
    local overflowExp = 0
    if localExp + exp > maxExp then
        overflowExp = localExp + exp - maxExp
    end

    local entityId = goodsData:getEntityID()
    local str = UI.TEXT_1212461
    if hasGoldRare then
        str = UI.TEXT_1212462
    end

    if overflowExp > 0 then
        str = string.format(UI.TEXT_1212475,tostring(overflowExp))
    end

    UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
        str,
        function(isSelect)
            self:sendStarPraySwallow(entityId, ids)
            Avalon.AudioManager:playSound("1504")
        end,
        function(isSelect)
        end
    )
end

--函数说明
--notification
function StarPrayController:noticeStarPraySwllowDoOneKey(notification)
    if not self.starPraySwallowView then
        return
    end
    local goodsData = self.starPraySwallowView:getTaregetGoodsData()
    if not goodsData then
        UI.ScrollBar:createByText(UI.TEXT_1212456)
        return
    end

    -- 判断是否可以作为主吞噬为
    if(goodsData and goodsData:getIsExpType()) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170280))
        return
    end

    if not mvc.starPrayModel:checkCanSwallow(goodsData) then
        UI.ScrollBar:createByText(UI.TEXT_1212467)
        return
    end

    local entityId = goodsData:getEntityID()
    local ids = mvc.starPrayModel:getOneKeySwallowIds(entityId)
    if #ids < 1 then
        UI.ScrollBar:createByText(UI.TEXT_1212464)
        return
    end
    mvc.openPanel("StarPray", "StarPraySwallowConfirm")
end

--函数说明
--notification
function StarPrayController:noticeStarPraySwllowTargetTouch(notification)
    if not self.starPraySwallowView then
        return
    end

    local param = notification.params
    local touchName, grid, inSide = param[1], param[2], param[3]
    if inSide then
        -- self:runPutAnimtion()
    else
        -- 恢复正常状态
        self.starPraySwallowView:updateTaregetGoodsData(nil)
        self.starPrayView:updateBagList()
        self.starPraySwallowView:showAnimationPutInCancel()
    end
end

--函数说明
--notification
function StarPrayController:noticeStarPraySwllowBagTouch(notification)
    if not self.starPraySwallowView then
        return
    end

    local param = notification.params
    local touchName, grid, touchPosition = param[1], param[2], param[3]
    local isInBag = self.starPrayView:isInScrollView(touchPosition)

    if isInBag then
        local goodsData = grid:getData()
        mvc.starPrayModel:removeSwallowGoodsData(goodsData)
        mvc.starPrayModel:resetStarPrayBagGoodsData(goodsData:getEntityID())
        self.starPraySwallowView:updateAddExp()
        self.starPrayView:updateBagList()
    else
    end
end

-- mvc.events.StarPray_ShowShopView 处理函数
function StarPrayController:noticeStarPrayShowShopView(notification, npcId)
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        npcId = 0
    end
    self:showView(mvc.starPrayShopPanel, mvc.starPrayShopContentView, 10001, npcId)
end



-- mvc.events.StarPray_Swllow_SHOW_SETTING 处理函数
function StarPrayController:noticeStarPraySwllowSHOWSETTING(notification)
    mvc.openPanel("StarPray", "StarPraySwallowSetting")
end



-- mvc.events.StarPray_Swllow_SETTING_OK 处理函数
function StarPrayController:noticeStarPraySwllowSETTINGOK(notification, settings)
    if #settings == 0 then
        UI.ScrollBar:createByText(UIUtil:lang(1112380))
        return
    end

    mvc.starPrayModel:setSwallowSettingInfo(settings)
    mvc.closePanel("StarPray", "StarPraySwallowSetting")
end



-- mvc.events.StarPray_Swllow_SETTING_Cancel 处理函数
function StarPrayController:noticeStarPraySwllowSETTINGCancel(notification)
    mvc.closePanel("StarPray", "StarPraySwallowSetting")
end



-- mvc.events.StarPray_Swallow_Confirm 处理函数
function StarPrayController:noticeStarPraySwallowConfirm(notification, isYes)
    if isYes then
        local goodsData = self.starPraySwallowView:getTaregetGoodsData()
        if not goodsData then
            UI.ScrollBar:createByText(UI.TEXT_1212456)
            return
        end

        -- 判断是否可以作为主吞噬为
        if(goodsData and goodsData:getIsExpType()) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170280))
            return
        end

        if not mvc.starPrayModel:checkCanSwallow(goodsData) then
            UI.ScrollBar:createByText(UI.TEXT_1212467)
            return
        end

        local entityId = goodsData:getEntityID()
        local ids = mvc.starPrayModel:getOneKeySwallowIds(entityId)
        if #ids < 1 then
            UI.ScrollBar:createByText(UI.TEXT_1212464)
            return
        end
    
        self:sendStarPraySwallow(entityId, ids)
        Avalon.AudioManager:playSound("1504")
    end
    mvc.closePanel("StarPray", "StarPraySwallowConfirm")
end



-- mvc.events.StarPray_Shop_GetReward 处理函数
function StarPrayController:noticeStarPrayShopGetReward(notification)
    local curExp, totalExp = mvc.starPrayModel:getShopExp()
    if curExp < totalExp and totalExp ~= 0 then
        UI.ScrollBar:createByText(UIUtil:lang(1112381))
        return
    end
    
    if mvc.starPrayModel:getStarPrayPacketFreeBoxNum() <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212471)
        return
    end


    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.GOODS_STARPRAY_LUCKY_AWARD_REQUEST, messageData)
end



-- mvc.events.StarPray_Shop_Ten_Click 处理函数
function StarPrayController:noticeStarPrayShopTenClick(notification, npcid)
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        npcid = 0
    end
    local messageData = {}
    messageData.npcid = npcid
    Net.Helper:sendMessage(NetMessageType.STAR_PRAY_TEN_DRAW_REQ, messageData)
end



-- mvc.events.StarPray_Swallow_Overflow 处理函数
function StarPrayController:noticeStarPraySwallowOverflow(notification)
    local goodsData = self.starPraySwallowView:getTaregetGoodsData()
    if not goodsData then
        UI.ScrollBar:createByText(UI.TEXT_1212456)
        return
    end

    -- 判断是否可以作为主吞噬为
    if(goodsData and goodsData:getIsExpType()) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170280))
        return
    end
    if not mvc.starPrayModel:checkCanSwallow(goodsData) then
        UI.ScrollBar:createByText(UI.TEXT_1212467)
        return
    end
    local entityId = goodsData:getEntityID()
    local _, exp = mvc.starPrayModel:getOneKeySwallowIds(entityId)

    local maxExp = goodsData:getMaxExp()
    local localExp = goodsData:getSwallowExp() + goodsData.exp
    local overflowExp = 0
    if localExp + exp > maxExp then
        overflowExp = localExp + exp - maxExp
    end

    self.starPraySwallowConfirmView._overflowExp = overflowExp
end



-- mvc.events.StarPray_Change_Plate 处理函数
function StarPrayController:noticeStarPrayChangePlate(notification, index, isUnlock)
    if self.starPrayEquipView and not tolua.isnull(self.starPrayEquipView) then
        local GameDataManager = require("app.game.GameDataManager")
        local heroData = GameDataManager:getInstance():getMaster()
        local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
        
        if not index then
            index = mvc.starPrayModel:getCurStarPlate()
        end
        mvc.starPrayModel:selectStarPlate(index)
        local config = ConfigManager:getStarPlateDataByID(index)

        self.starPrayEquipView:onChangeStarPlate(heroData, config)

        if isUnlock then
            UI.ScrollBar:createByText(UI.TEXT_227709)
        end
    end
end



-- mvc.events.StarPray_Show_Active_Attr_View 处理函数
function StarPrayController:noticeStarPrayShowActiveAttrView(notification)
    if self.starPrayEquipView and not tolua.isnull(self.starPrayEquipView) then
        self.starPrayEquipView:showStarPlateAttr()
    end
end



-- mvc.events.StarPray_ActiveRune 处理函数
function StarPrayController:noticeStarPrayActiveRune(notification,starPatternID)
    if self.starPrayIncreaseView and not tolua.isnull(self.starPrayIncreaseView) then
        self.starPrayIncreaseView:activeRune(starPatternID)
    end
end



-- mvc.events.StarPray_Upgrade 处理函数
function StarPrayController:noticeStarPrayUpgrade(notification)
    if self.starPrayIncreaseView and not tolua.isnull(self.starPrayIncreaseView) then
        self.starPrayIncreaseView:activeUpgrade()
    end
end



return StarPrayController