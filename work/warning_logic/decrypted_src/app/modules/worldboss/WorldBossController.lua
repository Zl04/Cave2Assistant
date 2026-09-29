--[[--
控制器WorldBossController，view已经注入,可以通过mvc.worldBossProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: zhiming.luo
-- date	: 2019/05/16
-- desc	:
------------------------------------------------------------------------------
local WorldBossController = class('WorldBossController', mvc.GameController)
local GameDataManager = require('app.game.GameDataManager')

function WorldBossController:onRoomInitDataResponse()
    if self.worldBossView then
        mvc.closePanel('WorldBoss', 'WorldBoss')
        mvc.openPanel('WorldBoss', 'WorldBossRoom')
    end
end

function WorldBossController:onBeginJoinBattleResponse()
    if self.worldBossView then
        mvc.closePanel('WorldBoss', 'WorldBoss')
    end

    if self.worldBossRoomView then
        mvc.closePanel('WorldBoss', 'WorldBossRoom')
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_HIDE_TOPBAR)

    mvc.openPanel('WorldBoss', 'WorldBossComfirm')
end

function WorldBossController:onRoomUpdateDataResponse()
    if self.worldBossRoomView then
        self.worldBossRoomView:updateRoomData()
    end
end

function WorldBossController:onRemoveRoomResponse()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_HIDE_MINI_ROOM)
    mvc.closePanel('WorldBoss', 'WorldBossRoom')
end

function WorldBossController:onRoomSwitchResponse()
    if self.worldBossRoomView then
        self.worldBossRoomView:switchingRoom()
    end
end

-- mvc.events.WorldBoss_Revive_Immediately 处理函数
function WorldBossController:noticeWorldBossReviveImmediately(notification, diamon)
    local master = GameDataManager:getInstance():getMaster()
    diamon = diamon or 0
    if (master) then
        Net.NetRoleSystem:heroReviveRequest(master:getSpriteID(), master:getSpriteID(), diamon)
    end

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

-- mvc.events.WorldBoss_Win_Quit 处理函数
function WorldBossController:noticeWorldBossWinQuit(notification)
    local SceneManager = require('app.game.SceneManager')
    SceneManager:getInstance():leaveWaiting()
end

-- mvc.events.WorldBoss_BuyBuff_Touch 处理函数
function WorldBossController:noticeWorldBossBuyBuffTouch(notification, arg1, arg2, arg3)
    if mvc.worldBossModel:isMaxBuyBuff() then
        UI.ScrollBar:createByText(UIUtil:lang(1112340))
        return
    end

    local isEnough, itemId, costNum = mvc.worldBossModel:checkCostEnough(arg1 + 1)
    if not isEnough then
        if itemId == Game.ConstGoods.Diamond then
            UI.TipsLayer:onDiamondNotEnough()
        else
            local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
            local name = ''
            if (goodsData) then
                name = string.format(UI.TEXT_1170948, goodsData.name)
            else
                name = UI.TEXT_1212360
            end
            UI.ScrollBar:createByText(name)
        end
        return
    end

    local function sendBuyBuff()
        local messageData = {}
        messageData.num = num or 1
        messageData.buyType = arg1
        Net.Helper:sendMessage(NetMessageType.ROLE_WORLDBOSS_BUY_BUFF_REQUEST, messageData)
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    end

    if itemId == Game.ConstGoods.Diamond then
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UIUtil:lang(1112343),
            function(isSelect)
                sendBuyBuff()
            end,
            function(isSelect)
            end,
            nil,
            nil,
            nil,
            tonumber(costNum)
        )
    else
        sendBuyBuff()
    end
end

-- mvc.events.WorldBoss_Battle_Confirm 处理函数
function WorldBossController:noticeWorldBossBattleConfirm(notification)
    -- if(mvc.expeditionModel:getExpeditionStatus()) then
    --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
    --         Net.NetNPCSystem:reqStopExpedition()
    --         Net.NetActivitySystem:requestWorldbossPrepareBattle()
    --     end, function()
    --     end)
    -- else 
        Net.NetActivitySystem:requestWorldbossPrepareBattle()
    -- end
end

return WorldBossController
