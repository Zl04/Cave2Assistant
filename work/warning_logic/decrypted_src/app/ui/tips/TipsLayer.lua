-- TipsLayer.lua
-- Author:ODEI
-- 2017年7月26日
-- Using:tips界面

require "app.datas.RoleDataManager"
-- require "app.datas.TeamDataManager"
-- 商店层相关TIPS

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local TipsLayer = class("TipsLayer", UI.HWBtnComponent)
UI.TipsLayer = TipsLayer

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
}


TipsLayerNum = 999

--构造函数(必备)
function TipsLayer:ctor(spriteID)
    -- print("TipsLayer:ctor")
    --窗口大小
    TipsLayer.super.ctor(
    self,9999,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )

    self.rootLayer = nil;           --root节点


    self:init();
    self:registerListener();

end

--虚构函数,destroy时调用(必备)
function TipsLayer:dtor()
    TipsLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function TipsLayer:init()
    TipsLayer.super.init(self)

    --root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width - Avalon.issUtil:getWidthOffset(),winSize.height))
    self.rootLayer:setPosition(cc.p(Avalon.issUtil:getLeftMargin(),0))
    self:addChild(self.rootLayer)

end

-- 模版函数：初始化组建的视图(必备)
function TipsLayer:onInitView()

end

-- 模版函数：更新组建的视图(必备)
function TipsLayer:onUpdateView()

end

-- 注册监听事件(可选)
function TipsLayer:registerListener()
    -- print("TipsLayer:registerListener")
        -- 显示进入下一层TIPS
    Avalon.MessageCenter:bind(AvalonMessage.MC_TIPS_SHOW_NEXT_FLOOR, self, self.onShowDownStairsHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TIPS_SHOW_TRANS_DOOR, self, self.onShowTransDoorHandler)
end

-- 注销监听事件(可选)
function TipsLayer:unRegisterListener()
    -- print("TipsLayer:unRegisterListener")
        -- 显示进入下一层TIPS
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TIPS_SHOW_NEXT_FLOOR, self, self.onShowDownStairsHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TIPS_SHOW_TRANS_DOOR, self, self.onShowTransDoorHandler)
end

function TipsLayer:addTips(tips,priority, delayTime)
    -- print("TipsLayer:addTips")
    local tipsParentLayer = nil;
    require "app.ui.UIManager"
    if UI.UIManager:getRootNode() and not tolua.isnull(UI.UIManager:getRootNode()) and UI.UIManager:getRootNode():getParent() then
        tipsParentLayer = UI.UIManager:getRootNode()
    else
        tipsParentLayer = cc.Director:getInstance():getRunningScene()
    end

    local tipLayer = tipsParentLayer:getChildByName("tipLayer")
    if tipLayer == nil then
        tipLayer = UI.TipsLayer:create()
        tipLayer:center()
        tipLayer:setName("tipLayer")
        tipsParentLayer:addChild(tipLayer,UI_ZORDER.TIPS)
    end

    tipLayer:addChild(tips)
    TipsLayerNum = TipsLayerNum - 1

    if priority == nil then
        tips:setLocalZOrder(TipsLayerNum)
    else
        tips:setLocalZOrder(1000+priority)
    end
    if delayTime ~= nil and delayTime > 0 then
        tips:hide()
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            if tips ~= nil and not tolua.isnull(tips) then
                tips:show()
            end
        end, delayTime)
    end
end

function TipsLayer:getTipsParent()
    local tipsParentLayer = nil;
    require "app.ui.UIManager"
    if UI.UIManager:getRootNode() and not tolua.isnull(UI.UIManager:getRootNode()) and UI.UIManager:getRootNode():getParent() then
        tipsParentLayer = UI.UIManager:getRootNode()
    else
        tipsParentLayer = cc.Director:getInstance():getRunningScene()
    end

    return tipsParentLayer:getChildByName("tipLayer")
end

-- 显示普通文本表现
function TipsLayer:onShowCommonTextHandler(text, okCallBack, cancelCallBack)
    require("app.ui.common.Dialog.ConfirmDialog")
    local tip = UI.ConfirmDialog.show(text, okCallBack, cancelCallBack)
    return tip
end

-- 显示普通文本表现
function TipsLayer:onShowCommonTextHandlerWithJustShowOK(text, okCallBack, cancelCallBack)
    local tip = UI.ConfirmDialog.showConfrimOnly(text, okCallBack, cancelCallBack, nil, nil)--  UI.Tips:create()
    return tip
end

-- 显示富文本表现
function TipsLayer:onShowCommonRichTextHandler(text, okCallBack, cancelCallBack, stype, showNoMoreKey, autoAdd)
    if (text) then assert(type(text) == "string" or type(text) == "userdata", "onShowCommonRichTextHandler : text is error type is " .. type(text)) end
    require("app.ui.common.Dialog.ConfirmRichDialog")
    local tip = UI.ConfirmRichDialog.show(text, okCallBack, cancelCallBack, stype, showNoMoreKey, autoAdd)
    return tip
end


-- 踢人投票成功的TIPS
function TipsLayer:onVoteSucceedTipsUI(data)
    require "app.ui.team.VoteSucceedTips"
    local tips = UI.VoteSucceedTips:create()
    tips:init(data)
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack)
    UI.TipsLayer:addTips(tips)
end

-- 显示进入下一层TIPS
function TipsLayer:onShowDownStairsHandler(okCallBack,cancelCallBack)
    if mvc.greedySelectModel:checkIsNeedGreedySelect() then
        okCallBack(true)
        return
    end
    require "app.ui.tips.DownstairsUI"
    local tips = UI.DownstairsUI:create()
    tips:init(UI.TEXT_DES_DOWN_STAIRS, okCallBack, cancelCallBack)
    tips:center()
    UI.UIManager:getRootNode():addChild(tips, UI_ZORDER.TIPS)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)  -- 关闭控制面板
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CONTROL_END)
end

-- 显示进入传送门
function TipsLayer:onShowTransDoorHandler(okCallBack,cancelCallBack, justShowOK)
    if mvc.greedySelectModel:checkIsNeedGreedySelect() then
        okCallBack(true)
        return
    end
    local text = languageManagerInstance:getLocalString(1110510)
    if(justShowOK) then 
        UI.ConfirmDialog.showConfrimOnly(text, okCallBack, cancelCallBack, nil, nil)
    else 
        UI.ConfirmDialog.show(text, okCallBack, cancelCallBack, nil, nil, nil)
    end

    -- require "app.ui.tips.CommonTips"
    -- local tips = UI.CommonTips:create(justShowOK)
    -- tips:init(languageManagerInstance:getLocalString(1110510))
    -- tips:center()
    -- tips:callfunName(okCallBack,cancelCallBack)
    -- UI.TipsLayer:addTips(tips)
    -- require "app.ui.UIManager"
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)  -- 关闭控制面板
end

-- 售卖装备的TIPS 参数三：出售物品所得的黄金数量
function TipsLayer:onSalesEquipment(okCallBack,cancelCallBack,goldAmount)
    require "app.ui.tips.shop.SalesEquipmentTips"
    local tips = UI.SalesEquipmentTips:create()
    tips:init(goldAmount)
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack)
    UI.TipsLayer:addTips(tips)
end



-- -- 购买物品的TIPS 参数三：物品价格 参数四：物品名称 参数五：花费类型（黄金还是钻石）
-- function TipsLayer:onBuyGoods(okCallBack,cancelCallBack,price,itemName,costType)
--     require "app.ui.tips.shop.BuyGoodsTips"
--     local tips = UI.BuyGoodsTips:create()
--     tips:init(price,itemName,costType)
--     tips:center()
--     tips:callfunName(okCallBack,cancelCallBack)
--     UI.TipsLayer:addTips(tips)
-- end

-- 黄金不足的TIPS
function TipsLayer:onGlodNotEnough(okCallBack,cancelCallBack)
    require "app.ui.tips.shop.GoldNotEnoughTips"
    local tips = nil 
    local tipsParentLayer = UI.TipsLayer:getTipsParent()
    if(tipsParentLayer) then 
        tips = tipsParentLayer:getChildByName("GoldNotEnoughTips")
    end
    if tips == nil then
        local tips = UI.GoldNotEnoughTips:create()
        tips:init()
        tips:center()
        tips:callfunName(okCallBack,cancelCallBack)
        tips:setName("GoldNotEnoughTips")
        UI.TipsLayer:addTips(tips)
    end
end

-- 砖石不足的TIPSBuyAmountTips
function TipsLayer:onDiamondNotEnough(okCallBack,cancelCallBack,addToTopLayer)
    require "app.ui.tips.shop.DiamondNotEnoughTips"

    local tips = nil
    local tipsParentLayer = UI.TipsLayer:getTipsParent()
    if(tipsParentLayer) then 
        tips = tipsParentLayer:getChildByName("DiamondNotEnoughTips")
    end
    if tips == nil then
        tips = UI.DiamondNotEnoughTips:create(addToTopLayer)
        tips:init()
        tips:center()
        tips:callfunName(okCallBack,cancelCallBack)
        tips:setName("DiamondNotEnoughTips")
        UI.TipsLayer:addTips(tips)
    end
    return tips
end

-- 材料消耗Tips
function TipsLayer:onItemsCost(data,okCallBack,cancelCallBack,addToTopLayer, extendCallback)
    require "app.ui.tips.shop.ItemCostWithIconTips"

    local tips = nil
    local tipsParentLayer = UI.TipsLayer:getTipsParent()
    if(tipsParentLayer) then 
        tips = tipsParentLayer:getChildByName("ItemCostWithIconTips")
    end
    if tips == nil then
        tips = UI.ItemCostWithIconTips:create(addToTopLayer)
        tips:init(data,okCallBack)
        tips:center()
        tips:callfunName(okCallBack,cancelCallBack, extendCallback)
        tips:setName("ItemCostWithIconTips")
        UI.TipsLayer:addTips(tips)
    end
    return tips
end

-- 罢免会长确认
function TipsLayer:onOverthrowLeader(okCallBack, cancelCallBack)
    require "app.ui.tips.OverthrowVoteTips"

    local tips = nil
    local tipsParentLayer = UI.TipsLayer:getTipsParent()
    if(tipsParentLayer) then 
        tips = tipsParentLayer:getChildByName("OverthrowVoteTips")
    end
    if tips == nil then
        tips = UI.OverthrowVoteTips:create()
        tips:init()
        tips:center()
        tips:callfunName(okCallBack, cancelCallBack)
        tips:setName("OverthrowVoteTips")
        UI.TipsLayer:addTips(tips)
    end
    return tips
end

-- 公会改名确认对话框
function TipsLayer:onRenamingGuild(newName, cost, okCallBack, cancelCallBack)
    require "app.ui.tips.GuildRenameTips"

    local tips = nil
    local tipsParentLayer = UI.TipsLayer:getTipsParent()
    if(tipsParentLayer) then 
        tips = tipsParentLayer:getChildByName("GuildRenameTips")
    end
    if tips == nil then
        tips = UI.GuildRenameTips:create(newName, cost)
        tips:init()
        tips:center()
        tips:callfunName(okCallBack, cancelCallBack)
        tips:setName("GuildRenameTips")
        UI.TipsLayer:addTips(tips)
    end
    return tips
end

-- 公会职级自定义确认对话框
function TipsLayer:onGuildRenameTitle(cost, okCallBack, cancelCallBack)
    require "app.ui.tips.GuildRenameTitleTips"

    local tips = nil
    local tipsParentLayer = UI.TipsLayer:getTipsParent()
    if(tipsParentLayer) then 
        tips = tipsParentLayer:getChildByName("GuildRenameTitleTips")
    end
    if tips == nil then
        tips = UI.GuildRenameTitleTips:create(cost)
        tips:init()
        tips:center()
        tips:callfunName(okCallBack, cancelCallBack)
        tips:setName("GuildRenameTitleTips")
        UI.TipsLayer:addTips(tips)
    end
    return tips
end

-- 公会随机商店购买物品确认对话框
function TipsLayer:onGuildRandomShopBuy(costType, cost, okCallBack, cancelCallBack)
    require "app.ui.tips.GuildRandomShopBuyTips"

    local tips = nil
    local tipsParentLayer = UI.TipsLayer:getTipsParent()
    if(tipsParentLayer) then 
        tips = tipsParentLayer:getChildByName("GuildRandomShopBuyTips")
    end
    if tips == nil then
        tips = UI.GuildRandomShopBuyTips:create(costType, cost)
        tips:init()
        tips:center()
        tips:callfunName(okCallBack, cancelCallBack)
        tips:setName("GuildRandomShopBuyTips")
        UI.TipsLayer:addTips(tips)
    end
    return tips
end

-- 公会个人商店刷新确认对话框
function TipsLayer:onGuildShopRefresh(id, cost, okCallBack, cancelCallBack)
    require "app.ui.tips.GuildShopRefreshTips"

    local tips = nil
    local tipsParentLayer = UI.TipsLayer:getTipsParent()
    if(tipsParentLayer) then 
        tips = tipsParentLayer:getChildByName("GuildShopRefreshTips")
    end
    if tips == nil then
        tips = UI.GuildShopRefreshTips:create(id, cost)
        tips:init()
        tips:center()
        tips:callfunName(okCallBack, cancelCallBack)
        tips:setName("GuildShopRefreshTips")
        UI.TipsLayer:addTips(tips)
    end
    return tips
end

-- 购买物品数量的TIPS 参数三：购买单个物品的需要的钻石数量 
function TipsLayer:onBuyAmount(okCallBack,cancelCallBack,itemDiamondAmount,costType,maxAmount,startAtMax,isSell)
    require "app.ui.tips.shop.BuyAmountTips"
    local tips = UI.BuyAmountTips:create()
    tips:init(itemDiamondAmount,costType,maxAmount,startAtMax,isSell)
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack)
    UI.TipsLayer:addTips(tips)
end

-- 庄园旅行商人交易tips
function TipsLayer:onManorBuyPeddler(okCallBack,cancelCallBack,saleID,giveID,givePrice,maxAmount,startAtMax)
    require "app.ui.tips.shop.ManorBuyPeddler"
    local tips = UI.ManorBuyPeddler:create()
    tips:init(saleID,giveID,givePrice,maxAmount,startAtMax)
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack)
    UI.TipsLayer:addTips(tips)
end

-- 商店通用批量购买弹窗 (只是客户端表现通用, 对应的购买消息得单独实现)
function TipsLayer:onCommonBulkPurchaseTips(okCallBack,cancelCallBack,commonShopType,purchasedNum,expandParam)
    require "app.ui.tips.shop.CommonBulkPurchaseTips"
    local tips = UI.CommonBulkPurchaseTips:create()
    tips:init(commonShopType,purchasedNum,expandParam)
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack)
    UI.TipsLayer:addTips(tips)
end

-- 用于数量选择
function TipsLayer:onNumChoice(okCallBack, cancelCallBack, minNum, maxNum, choiceNum, titleStr)
    require "app.ui.tips.NumChoiceTips"
    -- reload_script_file("app.ui.tips.NumChoiceTips")
    local tips = UI.NumChoiceTips:create()
    tips:init(minNum,maxNum,choiceNum, titleStr)
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack)
    UI.TipsLayer:addTips(tips)
end

-- 背包满的表现
function TipsLayer:onBagIsFull()
    UI.ConfirmDialog.showConfrimOnly(UI.TEXT_1110501, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
    end, nil, nil, nil)


    -- local tips = UI.Tips:createTips(UI.TEXT_1110501 ,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
    -- tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
    --     --TODO 清理背包
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
    -- end)
end

-- 背包满的表现(仅确定按钮)
function TipsLayer:onBagIsFullOnlyConfirm()
    UI.ConfirmDialog.showConfrimOnly(UI.TEXT_1110501, nil, nil, nil, nil)

    -- local tips = UI.Tips:createTips(UI.TEXT_1110501 ,UI.TipsType.CONFIRM,UI.TipsUiType.NORMAL)
end

function TipsLayer:OutOfDateForTurnTable(text, okCallBack)
    UI.ConfirmDialog.showConfrimOnly(text, function() 
        if(okCallBack) then 
            okCallBack()
        end
    end, nil, nil, nil)

    -- local tips = UI.Tips:createTips(text, UI.TipsType.CONFIRM,UI.TipsUiType.NORMAL)
    -- tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
    --     okCallBack()
    -- end)
end

-- 加入公会成功的表现
function TipsLayer:joinGuildSuccess()
    local runningScene = cc.Director:getInstance():getRunningScene()
    if (runningScene) then
        require "app.ui.tips.GuildCreateOrJoinTips"
        local tips = UI.GuildCreateOrJoinTips:create()
        tips:init(2)
        tips:center()
        tips:callfunName()
        runningScene:addChild(tips, 9999999)
        -- 特殊处理这个弹出, 只有1秒, 让它在最上层显示
        -- UI.TipsLayer:addTips(tips)
    end
end

function TipsLayer:createGuildSuccess(data)
    require "app.ui.tips.GuildCreateOrJoinTips"
    local tips = UI.GuildCreateOrJoinTips:create()
    tips:init(1)
    tips:center()

    tips:callfunName(function()
        require "app.ui.tips.CreateGuildSuccessTips"
        local tips = UI.CreateGuildSuccessTips:create()
        tips:init(data)
        tips:center()
        tips:callfunName()
        UI.TipsLayer:addTips(tips)
    end)
    UI.TipsLayer:addTips(tips)
end

function TipsLayer:createBuyGuildIconTips(data, okCallBack, cancelCallBack)
    require "app.ui.tips.BuyGuildIconTips"
    local tips = UI.BuyGuildIconTips:create()
    tips:init(data)
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack)
    UI.TipsLayer:addTips(tips)
end

function TipsLayer:createExchangeTipsTips()
    require "app.ui.tips.ExchangeTips"
    local tips = UI.ExchangeTips:create()
    tips:init()
    tips:center()
    UI.TipsLayer:addTips(tips)
end

function TipsLayer:createBindAccountTips(okCallBack,cancelCallBack, centerCallBack)
    require "app.ui.tips.BindAccountTips"
    local tips = UI.BindAccountTips:create()
    tips:init()
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack, centerCallBack)
    UI.TipsLayer:addTips(tips)
end



-- 跳转商店评论
function TipsLayer:onJumpToComment(okCallBack,cancelCallBack)
    require "app.ui.tips.JumpToCommentTips"
    local tips = UI.JumpToCommentTips:create()
    tips:init()
    tips:center()
    tips:callfunName(okCallBack,cancelCallBack)
    UI.TipsLayer:addTips(tips)
    return tips
end

function TipsLayer:createLoginOutGameTips(tipsText, isLogoutSdk)
    if(tipsText) then
        GameDataManager:getInstance():setLoginOutTipsText(tipsText)
    else 
        tipsText = GameDataManager:getInstance():getLoginOutTipsText()
    end

    if(tipsText) then
        local tips = UI.Tips:createTips(tipsText, UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL,nil,nil,false)
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            if(GameDataManager:getInstance():getLoginOutTipsText()) then 
                GameDataManager:getInstance():setLoginOutTipsText(nil)
                UI.UIManager.cannotRecconnect = false
                -- 关闭连接
                Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
                Game.Manager:clearScene()
                local SceneManager = require("app.game.SceneManager")
                SceneManager:getInstance():startLoginScene()
                if isLogoutSdk then
                    local SdkBox = require("utils.sdkbox.SdkBox")
                    SdkBox:getInstance():logout()
                end
            end
        end)
        tips.touchDialogOutsizeClose = false;
        UI.UIManager.cannotRecconnect = true
        local tipsParentLayer = cc.Director:getInstance():getRunningScene()
        tipsParentLayer:addChild(tips)
        tips:setLocalZOrder(UI_ZORDER.RECONNECT_TIPS)
        return tips
    else 
        return nil
    end
end

function TipsLayer:createLoginSealTips(time)

    local tipsText = ""
    if(time == 0) then
        tipsText = LanguageManager:getInstance():getLocalString(1111108)
    else 
        tipsText = LanguageManager:getInstance():getLocalString(1111109)
        tipsText = string.format(tipsText, ToolsUtil:getCountData(time))
    end

    local confirmCallback = function()
        -- 关闭连接 
        Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
    end

    local tips = nil

    local callBack = nil
    if(time > 0) then
        local waitingTime = 0
        callBack = function(self, dt)
            waitingTime = waitingTime + dt
            time = time - dt
            if(time <= 0) then
                if(not tolua.isnull(tips)) then
                    tips:removeFromParent()
                    confirmCallback()
                end
            else 
                if(waitingTime >1) then
                    if(not tolua.isnull(tips)) then
                        waitingTime = waitingTime - 1 
                        tipsText = LanguageManager:getInstance():getLocalString(1111109)
                        tipsText = string.format(tipsText, ToolsUtil:getCountData(time))
                        tips:updateContent(tipsText)
                    end
                end
            end
        end
    end

    tips = UI.ConfirmDialog.showConfrimOnly(tipsText, function()
        confirmCallback()
        if(callBack) then
            Avalon.Scheduler:unscheduleUpdate(self, callBack)
        end
    end, nil, nil, nil, nil)
    -- local tips = UI.Tips:createTips(tipsText, UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL,nil,nil,false)



    -- tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
    --     confirmCallback()
    --     if(callBack) then
    --         Avalon.Scheduler:unscheduleUpdate(self, callBack)
    --     end
    -- end)
    -- tips.touchDialogOutsizeClose = false;
    
    -- local tipsParentLayer = cc.Director:getInstance():getRunningScene()
    -- tipsParentLayer:addChild(tips)
    tips:setLocalZOrder(UI_ZORDER.RECONNECT_TIPS)

    if(callBack) then
        Avalon.Scheduler:scheduleUpdate(self, callBack)
    end

    return tips
end

function TipsLayer:createAccountTakeOver()
    local tipsText = LanguageManager:getInstance():getLocalString(1113451)
    local confirmCallback = function()
        -- 关闭连接 
        Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
    end
    local tips = UI.ConfirmDialog.showConfrimOnly(tipsText, function()
        confirmCallback()
    end, nil, nil, nil, nil)
    tips:setLocalZOrder(UI_ZORDER.RECONNECT_TIPS)

    return tips
end

function TipsLayer:closeSystemBusyTips()
    if(not tolua.isnull(self._systemBusy)) then 
        self._systemBusy:removeFromParent()
        self._systemBusy = nil
    end
end

function TipsLayer:createSystemBusyTips(time)
    local tipsText = ""
    if(time == nil) then 
        time = 3
    end

    local fixMinutes = 30
    if(time > 60*fixMinutes) then 
        tipsText = string.format(LanguageManager:getInstance():getLocalString(1111474), string.format(">%d%s", fixMinutes, LanguageManager:getInstance():getLocalString(1110164)))
    else 
        tipsText = string.format(LanguageManager:getInstance():getLocalString(1111474), ToolsUtil:getCountData(time))
    end

    local confirmCallback = function()
        -- 关闭连接 
        Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
        if(not tolua.isnull(self._systemBusy)) then 
            self._systemBusy:removeFromParent()
            self._systemBusy = nil
        end
    end

    local tips = nil
    tips = UI.ConfirmDialog.showConfrimOnlyShowRed(tipsText, function()
        print("showConfrimOnlyShowRed")
        confirmCallback()
    end, nil, nil, nil, nil)
    if(tips.ConfirmDialogModel and tips.ConfirmDialogModel.contentLabel) then 
        tips.ConfirmDialogModel.contentLabel:setLineSpacing(-4)
    end

    tips:setLocalZOrder(UI_ZORDER.RECONNECT_TIPS)
    self._systemBusy = tips

    return tips
end

function TipsLayer:createIdleDCTips()
    local tipsText = LanguageManager:getInstance():getLocalString(1112370)

    local confirmCallback = function()
        -- 关闭连接
        Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
        Game.Manager:clearScene()
        local SceneManager = require("app.game.SceneManager")
        SceneManager:getInstance():startLoginScene()
    end

    self._idleDC = UI.ConfirmDialog.showConfrimOnlyShowRed(tipsText, function()
        confirmCallback()
    end, nil, nil, nil, nil)
    self._idleDC:setLocalZOrder(UI_ZORDER.RECONNECT_TIPS)
    if(self._idleDC.ConfirmDialogModel and self._idleDC.ConfirmDialogModel.contentLabel) then 
        self._idleDC.ConfirmDialogModel.contentLabel:setLineSpacing(-4)
    end

    return self._idleDC
end


function TipsLayer:createDestoryGemStoneTips(goodsDataArr, okCallBack, cancelCallBack)
    local showTips = false
    local showTips2 = false
    if(goodsDataArr) then 
        for k,goodsData in ipairs(goodsDataArr) do 
            if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                if(goodsData:haveGemStone() or goodsData:haveGlyph()) then
                    showTips = true
                    break 
                end
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                if goodsData:haveSlotsAndGemData() then
                    showTips2 = true
                    break 
                end
            end
        end
    end 

    if(showTips) then 
        -- add by zp 装备出售优化
        if(cancelCallBack) then 
            cancelCallBack()
        end
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170248))

        -- local destoryGemStoneTips = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1111261),
        --     UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
        -- destoryGemStoneTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        --     if(okCallBack) then 
        --         okCallBack()
        --     end
        -- end)

        -- destoryGemStoneTips:addEventListener(UIEvent.DIALOG_CANCEL, self, function()
        --     if(cancelCallBack) then 
        --         cancelCallBack()
        --     end
        -- end)
    elseif(showTips2) then
        if(cancelCallBack) then 
            cancelCallBack()
        end
        UI.ScrollBar:createByText(UI.TEXT_228301)
    else 
        if(okCallBack) then 
            okCallBack()
        end
    end
end

function TipsLayer:createLostEscapeScrollTips(goodsDataArr, isSell, okCallBack, cancelCallBack)
    local showTips = false
    if(goodsDataArr) then 
        for k,goodsData in ipairs(goodsDataArr) do 
            if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM 
                and goodsData:getItemType()== PublicDefine.ITEM_TYPE.EscapeScroll) then 
                showTips = true
            end
        end
    end 

    if(showTips) then 
        local text = ""
        if(isSell) then 
            text = UI.TEXT_1212022
        else 
            text = UI.TEXT_1212023
        end

        local tip = UI.TipsLayer:onShowCommonTextHandler(text, function()
           if(okCallBack) then 
                okCallBack()
            end
        end, function()
            if(cancelCallBack) then 
                cancelCallBack()
            end
        end)
    else 
        if(okCallBack) then 
            okCallBack()
        end
    end
end

function TipsLayer:createWorldChatConfirm(okCallback)
    local displayText = languageManagerInstance:getLocalString(1112855)
    local worldChatConfirm = UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(displayText, function()
        self:createWorldChatInput(okCallback)
    end, nil, nil, nil, nil)
    if(worldChatConfirm.ConfirmDialogModel and worldChatConfirm.ConfirmDialogModel.contentLabel) then 
        worldChatConfirm.ConfirmDialogModel.contentLabel:setLineSpacing(-4)
        worldChatConfirm.ConfirmDialogModel.contentLabel:setFontName(UI.FONT_STANDARD)
        worldChatConfirm.ConfirmDialogModel.contentLabel:setFontSize(16)
        worldChatConfirm.ConfirmDialogModel.contentLabel:setFontColor({r = 1, g = 1, b = 1})
    end

    -- 喇叭排版
    local speakerLayout = UI.Layout:create()
    speakerLayout:init()
    speakerLayout:enableAutoWidth()
    speakerLayout:enableAutoHeight()
    speakerLayout:centerUp(169)
    worldChatConfirm.rootLayer:addChild(speakerLayout)

    -- 喇叭图标
    local speakerIcon  = UI.Image:create()
    speakerIcon:init("ui_chat_icon.png")
    speakerIcon:floatLeft(0)
    speakerLayout:addComponent(speakerIcon)

    -- 喇叭数量
    local loudSpeakerNum = 0
    local master = RoleDataManager:getMaster()
    if (master) then
        loudSpeakerNum = master:getLoudSpeakerNum() or 0
    end
    local speakerText = string.format(languageManagerInstance:getLocalString(1112892), loudSpeakerNum)
    local speakerTextLabel = UI.Text:create()
    speakerTextLabel:init(speakerText, UI.FONT_STANDARD, 16, {r = 1, g = 1, b = 1})
    speakerTextLabel:floatLeft(2)
    speakerLayout:addComponent(speakerTextLabel)

    return worldChatConfirm
end

function TipsLayer:createWorldChatInput(okCallback)
    self._worldChatInput = UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(nil, function()
        if (okCallback and self._worldChatInput.chatInput) then
            local inputText = self._worldChatInput.chatInput:getText()
            okCallback(ToolsUtil:checkMaskword(inputText))
        end
    end, nil, nil, nil, nil)

    -- 输入框替换内容框
    self._worldChatInput.ConfirmDialogModel.contentLabel:setText(languageManagerInstance:getLocalString(1110597)--[[点击输入聊天内容]])
    self._worldChatInput.ConfirmDialogModel.contentLabel:setTextAlignment(UI.TextHAlignment.LEFT, UI.TextVAlignment.TOP)
    self._worldChatInput.ConfirmDialogModel.contentLabel:setFontName(UI.FONT_STANDARD)
    self._worldChatInput.ConfirmDialogModel.contentLabel:setFontSize(15)
    self._worldChatInput.ConfirmDialogModel.contentLabel:setFontColor({r = 0, g = 0, b = 0})
    self._worldChatInput.ConfirmDialogModel.contentLabel:setSize(350, 120)
    self._worldChatInput.ConfirmDialogModel.contentLabel:setTouchEnable(true)
    self._worldChatInput.ConfirmDialogModel.contentLabel:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self._worldChatInput.chatInput:openKeyboard()
    end)

    -- 输入框本身
    self._worldChatInput.chatInput = UI.EditBox:create(350, 120)
    self._worldChatInput.chatInput:init("", cc.EDITBOX_INPUT_MODE_ANY, nil, 5, 5)
    self._worldChatInput.chatInput:leftUp(40, 40)
    self._worldChatInput.chatInput:setVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_TOP)
    self._worldChatInput.chatInput:setFontColor({r = 0, g = 0, b = 0})
    self._worldChatInput.chatInput:setFontSize(15)
    self._worldChatInput.chatInput:setPlaceholderFontColor({r = 0, g = 0, b = 0})
    self._worldChatInput.chatInput:setPlaceholderFontSize(15)
    self._worldChatInput.chatInput:setMaxLength(Game.SEND_MESSAGE_WIDTH_LIMIT)
    self._worldChatInput.chatInput:setEditBeganCallback(function()
        self._worldChatInput.chatInput:show()
        self._worldChatInput.ConfirmDialogModel.contentLabel:hide()
    end)
    self._worldChatInput.chatInput:setEditEndedCallback(function()
        self._worldChatInput.ConfirmDialogModel.contentLabel:show()
        local content = self._worldChatInput.chatInput:getText()
        if (content == "") then
            content = languageManagerInstance:getLocalString(1110597)--[[点击输入聊天内容]]
        end
        self._worldChatInput.ConfirmDialogModel.contentLabel:setText(content)
        self._worldChatInput.chatInput:hide()
    end)
    self._worldChatInput.chatInput:hide()


    self._worldChatInput.rootLayer:addChild(self._worldChatInput.chatInput)

    -- 替换cancel按钮
    self._worldChatInput.ConfirmDialogModel.cancelBtn:hide()
    local cancelButton = UI.Button:create()
    cancelButton:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png")
    cancelButton:setText(languageManagerInstance:getLocalString(1110042)--[[取消]])
    cancelButton:setTextFont(UI.FONT_STANDARD, 20, {r = 80, g = 80, b = 68})
    cancelButton:leftBottom(47, 25)
    self._worldChatInput.rootLayer:addChild(cancelButton)
    cancelButton:addEventListener(UIEvent.BUTTON_CLICK, self._worldChatInput, self._worldChatInput.cancel)

    -- 替换ok按钮
    self._worldChatInput.ConfirmDialogModel.okButton:hide()
    local okButton = UI.Button:create()
    okButton:init("ui_btn_yellow3_0.png", "ui_btn_yellow3_1.png", "ui_btn_yellow3_2.png")
    okButton:setText(languageManagerInstance:getLocalString(1110596)--[[发送]])
    okButton:setTextFont(UI.FONT_STANDARD, 20, {r = 80, g = 80, b = 68})
    okButton:leftBottom(247, 25)
    self._worldChatInput.rootLayer:addChild(okButton)
    okButton:addEventListener(UIEvent.BUTTON_CLICK, self._worldChatInput, self._worldChatInput.ok)
end

-- 创建招募
function TipsLayer:createGuildRecruitInput(okCallback)
    self._guildInviteInput = UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(nil, function()
        if (okCallback and self._guildInviteInput.ConfirmDialogModel.contentLabel) then
            local inputText = self._guildInviteInput.ConfirmDialogModel.contentLabel:getText()
            okCallback(ToolsUtil:checkMaskword(inputText))
        end
    end, nil, nil, nil, nil)
    self._guildInviteInput:setModelDialog(false)

    local emptyText = LanguageManager:getInstance():getLocalString(1112993) --[["强力公会招募活跃玩家! 赶紧加入我们吧!"]]
    local GameDataManager = require("app.game.GameDataManager")
    local savedMessage = GameDataManager:getGuildRecruitMessage()
    if (savedMessage) then
        emptyText = savedMessage
    end

    -- 输入框替换内容框
    self._guildInviteInput.ConfirmDialogModel.contentLabel:setText(emptyText)
    self._guildInviteInput.ConfirmDialogModel.contentLabel:setTextAlignment(UI.TextHAlignment.LEFT, UI.TextVAlignment.TOP)
    self._guildInviteInput.ConfirmDialogModel.contentLabel:setFontName(UI.FONT_STANDARD)
    self._guildInviteInput.ConfirmDialogModel.contentLabel:setFontSize(18)
    self._guildInviteInput.ConfirmDialogModel.contentLabel:setFontColor({r = 41, g = 41, b = 45})
    self._guildInviteInput.ConfirmDialogModel.contentLabel:setSize(350, 120)
    self._guildInviteInput.ConfirmDialogModel.contentLabel:setTouchEnable(true)
    self._guildInviteInput.ConfirmDialogModel.contentLabel:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        -- self._guildInviteInput.chatInput:openKeyboard()
    end)

    -- -- 输入框本身
    -- local fontSize = 18
    -- self._guildInviteInput.chatInput = UI.EditBox:create(350, 120)
    -- self._guildInviteInput.chatInput:init("", cc.EDITBOX_INPUT_MODE_ANY, nil, 5, 5)
    -- self._guildInviteInput.chatInput:leftUp(40, 40)
    -- self._guildInviteInput.chatInput:setVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_TOP)
    -- self._guildInviteInput.chatInput:setFontColor({r = 41, g = 41, b = 45})
    -- self._guildInviteInput.chatInput:setFontSize(fontSize)
    -- self._guildInviteInput.chatInput:setPlaceholderFontColor({r = 41, g = 41, b = 45})
    -- self._guildInviteInput.chatInput:setPlaceholderFontSize(15)
    -- self._guildInviteInput.chatInput:setMaxLength(Game.SEND_MESSAGE_WIDTH_LIMIT)
    -- self._guildInviteInput.chatInput:setEditBeganCallback(function()
    --     local savedContent = self._guildInviteInput.ConfirmDialogModel.contentLabel:getText()
    --     if (savedContent ~= emptyText) then
    --         self._guildInviteInput.chatInput:setText(savedContent)
    --     end
    --     self._guildInviteInput.chatInput:show()
    --     self._guildInviteInput.ConfirmDialogModel.contentLabel:hide()
    -- end)
    -- self._guildInviteInput.chatInput:setEditEndedCallback(function()
    --     self._guildInviteInput.ConfirmDialogModel.contentLabel:show()
    --     local content = self._guildInviteInput.chatInput:getText()
    --     self._guildInviteInput.chatInput:hide()

    --     -- 长度检查
    --     if AvalonUtil:isUpLimiteStr(content, 500, fontSize) then
    --         UI.ScrollBar:createByText(UI.TEXT_1170311)
    --         return
    --     end

    --     -- 空字符检查
    --     if (content == "") then
    --         content = emptyText
    --     end

    --     self._guildInviteInput.ConfirmDialogModel.contentLabel:setText(content)
    --     GameDataManager:setGuildRecruitMessage(content)
    -- end)
    -- self._guildInviteInput.chatInput:setChangeCallback(function(message)
    --     if AvalonUtil:isUpLimiteStr(message, 600, fontSize) then
    --         UI.ScrollBar:createByText(UI.TEXT_1170311)
    --         return 
    --     end
    -- end)
    -- self._guildInviteInput.chatInput:hide()
    -- self._guildInviteInput.rootLayer:addChild(self._guildInviteInput.chatInput)

    -- 替换cancel按钮
    self._guildInviteInput.ConfirmDialogModel.cancelBtn:hide()

    -- 替换ok按钮
    self._guildInviteInput.ConfirmDialogModel.okButton:hide()
    local okButton = UI.Button:create()
    okButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    okButton:setText(LanguageManager:getInstance():getLocalString(1112994) --[["发布"]])
    okButton:setTextFont(UI.FONT_BOLD, 20, {r = 42, g = 41, b = 45})
    okButton:centerBottom(21)
    self._guildInviteInput.rootLayer:addChild(okButton)
    okButton:addEventListener(UIEvent.BUTTON_CLICK, self._guildInviteInput, function()
        GameDataManager:setGuildRecruitMessage(nil)
        if (self._guildInviteInput.ok) then
            self._guildInviteInput:ok()
        end
    end)
end