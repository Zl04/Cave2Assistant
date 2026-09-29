-- TopActivityLayer.lua
-- Author:zp
-- 2017年8月2日
-- Using:顶层窗口界面


require("app.ui.cave.kickedLayer.KickedPanel")
local SceneManager = require("app.game.SceneManager")

local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local TopActivityLayer = class("TopActivityLayer", UI.HWBtnComponent)
UI.TopActivityLayer = TopActivityLayer

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
}


UI_TOP_ACTIVITY_ZORDER = {
    TITLE_SELECTOR = 0, -- 称号选择框
    REVIVE = 1,         -- 复活界面
    REVIVE_TIPS = 2,    -- 复活界面的TIPS

    KICK = 200,         -- 踢出界面

    SHOP = 500,         -- 商店层
    SHOP_TIPS = 501,    -- 商店层的TIPS 
}

--构造函数(必备)
function TopActivityLayer:ctor(spriteID)
    --窗口大小
    TopActivityLayer.super.ctor(
    self,UIType.TOP_ACTIVITY_LAYER,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )

    self.rootLayer = nil;           --root节点

    self:init();
    self:registerListener();

end

--虚构函数,destroy时调用(必备)
function TopActivityLayer:dtor()
    TopActivityLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function TopActivityLayer:init()
    TopActivityLayer.super.init(self)

    --root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width - Avalon.issUtil:getWidthOffset(),winSize.height))
    self.rootLayer:setPosition(cc.p(Avalon.issUtil:getLeftMargin(),0))
    self:addChild(self.rootLayer)

end

function TopActivityLayer:getChildrenNum()
    if(not tolua.isnull(self.rootLayer)) then 
        return #self.rootLayer:getChildren()
    end

    return 0
end


-- 模版函数：初始化组建的视图(必备)
function TopActivityLayer:onInitView()
    --root节点
    -- self.rootLayer = cc.Layer:create();
    -- self.rootLayer:setContentSize(cc.size(winSize.width,winSize.height))
    -- self.rootLayer:setPosition(cc.p(0,0))
    -- self:addChild(self.rootLayer)

end


-- 模版函数：更新组建的视图(必备)
function TopActivityLayer:onUpdateView()

end

-- 注册监听事件(可选)
function TopActivityLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_OPEN_TITLE_SELECTOR, self, self.onShowTitleSelector)

    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE, self, self.onShowReviveHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_END, self, self.onShowReviveEndHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_KICKED, self, self.onShowKickHandler)
        --解锁动画
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_UNLOCK, self, self.showUnlockLayer)
    --npc 剧情对话
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, self, self.showNpcDialog)


    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_INDICATE_UI, self, self.showIndicateUILayer)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_DOWNSTAIRS_LEAVE, self, self.showDownStarirsLeave)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_DOWNSTAIRS_ENTER, self, self.showDownStarirsEnter)

    -- 显示内购界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_IAPSHOP_IN_REVIVE, self, self.onShowIapShop)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND, self, self.showBindPanel)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, self, self.onShowCommonRewardLayer)

    -- 结束梦境
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_DREAM_END, self, self.onShowDreamEnd)
end

-- 注销监听事件(可选)
function TopActivityLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_OPEN_TITLE_SELECTOR, self, self.onShowTitleSelector)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE, self, self.onShowReviveHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_END, self, self.onShowReviveEndHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_KICKED, self, self.onShowKickHandler)
        --解锁动画
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_UNLOCK, self, self.showUnlockLayer)
    --npc 剧情对话
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, self, self.showNpcDialog)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_INDICATE_UI, self, self.showIndicateUILayer)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_DOWNSTAIRS_LEAVE, self, self.showDownStarirsLeave)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_DOWNSTAIRS_ENTER, self, self.showDownStarirsEnter)

    -- 显示内购界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_IAPSHOP_IN_REVIVE, self, self.onShowIapShop)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND, self, self.showBindPanel)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, self, self.onShowCommonRewardLayer) 

    -- 结束梦境
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_DREAM_END, self, self.onShowDreamEnd)
end

-- 称号选择界面
function TopActivityLayer:onShowTitleSelector(left, bottom, closeCallback)
    local localPos = self.rootLayer:convertToNodeSpace(cc.p(left, bottom))
    require "app.ui.baglayer.Role.TitleSelectLayer"
    local titleSelector = UI.TitleSelectLayer:create()
    titleSelector:init()
    titleSelector:leftBottom(localPos.x, localPos.y)
    self.rootLayer:addChild(titleSelector, UI_TOP_ACTIVITY_ZORDER.TITLE_SELECTOR)
    titleSelector:setCloseCallback(function(titleID)
        if (closeCallback) then closeCallback(titleID) end
    end)
end

function TopActivityLayer:getIapShopPanel()
    local iapPanel = self.rootLayer:getChildByName("ShopPanel")
    return iapPanel
end
function TopActivityLayer:showBindPanel()
    require "app.ui.baglayer.Setting.BindAccount"
    local bindLayer = self.rootLayer:getChildByName("BindAccount")
    if tolua.isnull(bindLayer) then
        bindLayer = UI.BindAccount:create()
        bindLayer:init()
        bindLayer:center()
        bindLayer:setName("BindAccount")
        self.rootLayer:addChild(bindLayer,UI_ZORDER.ACTIVITY);
    end
    
end
-- 显示内购
function TopActivityLayer:onShowIapShop()
    -- require("app.utils.ServerConfigUtil")
    -- local SdkBox = require("utils.sdkbox.SdkBox")
    -- local versionTarget = SdkBox:getInstance():getVersionTarget()
    -- -- 屏蔽内购
    -- if (device.platform == "ios" and not ServerConfigUtil:isInReview()) 
    -- or  versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN then
    --     UI.ScrollBar:createByText(UI.TEXT_1170846)
    --     return
    -- end
    -- self:closeAllActivity()
    local iapPanel = self.rootLayer:getChildByName("ShopPanel")
    if iapPanel == nil then
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            iapPanel = UI.IapShopMainLayer:create(false, 1, 
                PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_DiamondNotEnoughRevive)
            iapPanel:init()
            iapPanel:center()
            iapPanel:setName("ShopPanel")
            self.rootLayer:addChild(iapPanel,zorder or UI_ZORDER.ACTIVITY);    
        end
    end
    -- print("zorder",zorder)
    -- IapShopMainLayer
end
--共用 奖励界面(内购用到,因为内购页面层级很高,这也需要很高)
function TopActivityLayer:onShowCommonRewardLayer(goodsDataList, callback, titleStr, zorder, style, equipmentWasGet, buttonStr, isDisable)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        local rewardLayer = self.rootLayer:getChildByName("RewardLayer")
        if rewardLayer == nil then
            -- 处理隐藏掉其余控件
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.common.RewardLayer")
                local rewardLayer = UI.RewardLayer:create(goodsDataList, callback, titleStr, style, equipmentWasGet, buttonStr, isDisable)
                rewardLayer:center()
                rewardLayer:setName("RewardLayer")
                print("zorder",zorder)
                self.rootLayer:addChild(rewardLayer, zorder or UI_ZORDER.MAX);
            end
        end
    end 
end
-- 显示复活界面
function TopActivityLayer:onShowReviveHandler()
    local masterData = GameDataManager:getInstance():getMaster()
    if(masterData == nil or masterData:getIsDead() == false or masterData:getIsInRevive() == true) then 
        return 
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_BIG_MAP)
    print("TopActivityLayer:onShowReviveHandler ")

    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_ALL_ACTIVITY)

    if  SceneManager:getInstance():isWorldBossCave() then
        local countDown = mvc.worldBossModel:getReviveCD()
        mvc.openPanel("WorldBoss", "WorldBossDieResult", {countDown = countDown})
        return
    end

    if  SceneManager:getInstance():isInBigCrack() then
        local configData = ConfigManager:getFestivalDataForID(PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID)
        local countDown = configData.resurrectionTime
        mvc.openPanel("WorldBoss", "WorldBossDieResult", {notShowBtns = true, countDown= countDown})
        return
    end

    if  SceneManager:getInstance():isInEaster() then
        local configData = ConfigManager:getFestivalDataForID(PublicDefine.CONST_DEFINITION.EASTER_MAP_ID)
        local countDown = configData.resurrectionTime
        mvc.openPanel("WorldBoss", "WorldBossDieResult", {notShowBtns = true, countDown= countDown})
        return
    end

    -- 在元素炼狱恶魔难度次数用完后直接回城
    local GameMapManager = require("app.game.GameMapManager")
    if SceneManager:getInstance():isInInferno() 
    and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
        if(mvc.caveModel:getInfernoNightMareCostNum() == nil) then
            GameManager:giveUpBackTown()
            return
        end
    end

    -- 在虚空秘境恶魔难度次数用完后直接回城
    if SceneManager:getInstance():isInVoidRift() 
    and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
        if(mvc.caveModel:getVoidRiftNightMareCostNum() == nil) then
            GameManager:giveUpBackTown()
            return
        end
    end

    -- 在维京时代恶魔难度次数用完后直接回城
    if SceneManager:getInstance():isInViKing() 
    and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
        if(mvc.viKingModel:getViKingNightMareCostNum() == nil) then
            GameManager:giveUpBackTown()
            return
        end
    end

    local kickPanel = self.rootLayer:getChildByName("KickPanel")
    if(kickPanel == nil)  then
        local revivePanel = self.rootLayer:getChildByName("RevivePanel")
        if revivePanel == nil then
            require "app.ui.battlelayer.RevivePanel"
            
            revivePanel = UI.RevivePanel:create()
            revivePanel:init()
            revivePanel:center()
            revivePanel:setName("RevivePanel")
            print("TopActivityLayer:onShowReviveHandler  ",tostring(revivePanel),tostring(self.rootLayer))
            self.rootLayer:addChild(revivePanel, UI_TOP_ACTIVITY_ZORDER.REVIVE);
        end
    end
end

function TopActivityLayer:onShowReviveEndHandler(heroData)
    

    print("TopActivityLayer:onShowReviveEndHandler ")
    if heroData and heroData.getPK and GameDataManager:getInstance():getMasterPK() == heroData:getPK() then
        if  SceneManager:getInstance():isWorldBossCave()
            or SceneManager:getInstance():isInEaster() then
            mvc.closePanel("WorldBoss", "WorldBossDieResult")
            return
        end
        
        local revivePanel = self.rootLayer:getChildByName("RevivePanel")
        if(revivePanel)  then
            revivePanel:removeFromParent(true)
        end
    end
end

-- 显示被踢出倒计时界面
function TopActivityLayer:onShowKickHandler(kickType, callbackHandler)
    -- 处理复活界面的相关逻辑处理
    local revivePanel = self.rootLayer:getChildByName("RevivePanel")
    print(self.rootLayer:getChildrenCount())

    print("TopActivityLayer:onShowKickHandler ", revivePanel ,tostring(self.rootLayer))
    if revivePanel then
        revivePanel:kickPause()
    end

    local KickPanel = self.rootLayer:getChildByName("KickPanel")
    if KickPanel == nil then
        KickPanel = UI.KickedPanel:create(kickType, callbackHandler)
        KickPanel:init()
        KickPanel:center()
        KickPanel:setName("KickPanel")

        self.rootLayer:addChild(KickPanel, UI_TOP_ACTIVITY_ZORDER.KICK);
    end
end


--解锁动画
function TopActivityLayer:showUnlockLayer(icon,text,extraData)
    print("TopActivityLayer:showUnlockLayer")
    if(self.rootLayer) then 
        local pUnlockLayer = self.rootLayer:getChildByName("UnlockLayer")
        if pUnlockLayer == nil then
            require("app.ui.UnlockLayer")
            local pUnlockLayer = UI.UnlockLayer:create(icon,text,extraData)
            pUnlockLayer:center(0)
            pUnlockLayer:setName("UnlockLayer")
            self.rootLayer:addChild(pUnlockLayer,UI_ZORDER.WEBVIEW)
        else
            pUnlockLayer:refreshView(icon,text,extraData)
        end
    end 
end


--npc对话框
function TopActivityLayer:showNpcDialog(id, callback, isSwallowTouch)
    print("TopActivityLayer:showNpcDialog id = ", id)
    if id == 0 then
        return
    end
    if(self.rootLayer) then 
        require("app.ui.common.NpcDialog")
        local npcDialog = UI.NpcDialog:create(id, callback, nil, nil, nil, nil, isSwallowTouch)
        npcDialog:center(0)
        npcDialog:setName("pNpcDialog")
        self.rootLayer:addChild(npcDialog,UI_ZORDER.NPC_DIALOG)
    end 
end

--箭头指引
function TopActivityLayer:showIndicateUILayer(target,data,stepData,style,isPointingMapTile,isSwallowTouch)
    print("TopActivityLayer:showIndicateUILayer")
    if(self.rootLayer) then 
        require("app.ui.indicateUILayer.IndicateUILayer")
        local pIndicateUILayer = UI.IndicateUILayer:create(target,data,stepData,style,isPointingMapTile,isSwallowTouch)
        pIndicateUILayer:center(0)
        pIndicateUILayer:setName("pIndicateUILayer")
        self.rootLayer:addChild(pIndicateUILayer,999)
    end 
end

function TopActivityLayer:showDownStarirsLeave()
    print("TopActivityLayer:showDownStarirsLeave")
    if(self.rootLayer) then 
        require("app.ui.cave.downstairsLayer.DownstairsPanel")
        local pownstairsPanel = UI.DownstairsPanel:create()
        pownstairsPanel:init(DownstairsType.DownstairsType_Leave)
        pownstairsPanel:center(0)
        pownstairsPanel:setName("pownstairsPanel")
        self.rootLayer:addChild(pownstairsPanel,999)
    end 
end

function TopActivityLayer:showDownStarirsEnter()
    print("TopActivityLayer:showDownStarirsEnter")
    if(self.rootLayer) then 
        require("app.ui.cave.downstairsLayer.DownstairsPanel")
        local pownstairsPanel = UI.DownstairsPanel:create()
        pownstairsPanel:init(DownstairsType.DownstairsType_Enter)
        pownstairsPanel:center(0)
        pownstairsPanel:setName("pownstairsPanel")
        self.rootLayer:addChild(pownstairsPanel,999)
    end 
end

function TopActivityLayer:onShowDreamEnd()
    if(self.rootLayer) then 
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        require "app.ui.dream.DreamResultLayer"
        local DreamResultLayer = UI.DreamResultLayer:create()
        DreamResultLayer:setName("DreamResultLayer")
        self.rootLayer:addChild(DreamResultLayer, 999)
    end 
end