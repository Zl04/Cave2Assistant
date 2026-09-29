-- ActivityLayer.lua
-- Author:ODEI
-- 2017年7月21日
-- Using:窗口主界面 

require "app.datas.RoleDataManager"
require "app.datas.TeamDataManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
-- 背包
require "app.ui.baglayer.BagPanel"
require "app.ui.battlelayer.MonsterBoxLayer"
require("app.ui.rankingLayer.RankingLayer")

-- 内购
require "app.ui.iapshop.IapShopMainLayer"
UI = UI or {}

local ActivityLayer = class("ActivityLayer", UI.HWBtnComponent)
UI.ActivityLayer = ActivityLayer

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
    -- "ui_town_activity.plist"
}


--构造函数(必备)
function ActivityLayer:ctor(spriteID)
    print("ActivityLayer:ctor")
    --窗口大小
    ActivityLayer.super.ctor(
    self,UIType.ACTIVITY_LAYER,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )

    self.rootLayer = nil;           --root节点

    self:init();
    self:registerListener();

end

--虚构函数,destroy时调用(必备)
function ActivityLayer:dtor()
    ActivityLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function ActivityLayer:init()

    --root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width - Avalon.issUtil:getWidthOffset(),winSize.height))
    self.rootLayer:setPosition(cc.p(Avalon.issUtil:getLeftMargin(),0))
    self:addChild(self.rootLayer)

    ActivityLayer.super.init(self)



end


-- 模版函数：初始化组建的视图(必备)
function ActivityLayer:onInitView()

end


-- 模版函数：更新组建的视图(必备)
function ActivityLayer:onUpdateView()

end

--关闭所有活动页
function ActivityLayer:closeAllActivity()
    -- performWithDelay(self.rootLayer, function()
    --     self.rootLayer:removeAllChildren()
    -- end, 0.05)
    
    -- add by zp 这里在没有界面的时候，会导致移动屏幕中心点，导致了疾跑走一格，表现很异常问题
    local children = self.rootLayer:getChildren()
    if(children and #children > 0) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER,function()
            GameManager:centerToMap()
        end,0.05)
    end
    --聊天界面 需要特殊处理
    local mainChatLayer =  self.rootLayer:getChildByName("ChatMainLayer")
    if mainChatLayer then
        mainChatLayer:removeFromParent(false)
    end
    if device.platform == "mac" or device.platform == "windows" then
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
        -- local bigMap = UI.UIManager:getRootNode():getChildByName("BigMap")
        if UI.UIManager:getRootNode():getChildByName("BigMap") then
            local bigMap = UI.UIManager.mMainUILayer:getChildByName("BigMap")
            if(not tolua.isnull(bigMap)) then
                bigMap:closeWin()
            end
        end
        
    end

    if not SceneManager:getInstance():isInPetPVP() then
        self.rootLayer:removeAllChildren()
    end
end

function ActivityLayer:getChildrenNum()
    if(not tolua.isnull(self.rootLayer)) then 
        return #self.rootLayer:getChildren()
    end

    return 0
end

-- 角色状态改变
function ActivityLayer:onUpdateRoleStateHandler(roleData)
    if roleData:getType() == RoleType.Hero then
        local _pk = roleData:getPK()
        if _pk == RoleDataManager:getMasterPK() then
            local fsmState = roleData:getState()
            -- print("ActivityLayer:onUpdateRoleStateHandler",roleData:getIsDead() , fsmState , FSMState.BATTLE , FSMState.MOVE)
            if roleData:getIsDead() or fsmState == FSMState.BATTLE or fsmState == FSMState.MOVE then
                self:closeAllActivity()
            end
        end
    end
end

-- 注册监听事件(可选)
function ActivityLayer:registerListener()
    -- 战斗收获页面
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REWARD, self, self.onRewardHandler)
    -- 显示任务窗口
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_SHOW_TASK, self, self.showTownTaskLayer)
    --邮箱
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_SHOW_MAILLAYER, self, self.showMailLayer)
    --关闭邮箱
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_CLOSE_MAILLAYER, self, self.closeMailLayer)


    --扭曲空间界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, self, self.onShowSpaceLevelSelect)
        -- 显示关卡选择
    Avalon.MessageCenter:bind(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, self, self.onShowLevelSelect)
        -- 处理黑商
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_BLACK_SHOP, self, self.onShowBlackShopHandler)
    -- 处理随机商店
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_RANDOM_SHOP, self, self.onShowRandomShopHandler)
    -- 显示强化界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_STRENGTHEN, self, self.onShowStrengthenHandler)
    -- 显示改造界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_REMOULD, self, self.onShowRemouldHandler)
     -- 显示分解界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_RESOLVE, self, self.onShowResolveHandler)
     -- 显示锻造界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_FORGE, self, self.onShowForgedHandler)
    -- 显示宠物强化界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_PET_STRENGTHEN, self, self.onShowPetStrengthenHandler)


    -- 显示洞穴商店
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_IN_CAVE_SHOP, self, self.onShowInCaveShopHandler)
    -- 显示洞穴点金
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_IN_CAVE_GOLDPOINTING, self, self.onShowInCaveGoldPointingHandler)
    -- 显示洞穴附魔
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_IN_CAVE_ENCHANTMENT, self, self.onShowInCaveEnchantmentLHandler)


    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    -- 关闭所有活动界面 
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY, self, self.closeAllActivity)

    -- 显示捏脸
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_BEAUTYSALON, self, self.onShowBeautySalonHandler)
    -- 显示猫饭
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_CATFOOD, self, self.onShowCatFoodonHandler)
    -- 显示仓库
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_WAREHOUSE, self, self.onShowWarehouseHandler)
    --显示抽奖界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_LUCKDROP, self, self.onShowDropLayerHandler)

    --显示背包界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_BAG, self, self.onShowBagLayerHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_FUNCTION_PANEL, self, self.onShowFunctionPanelLayerHandler)
    -- 显示内购界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_IAPSHOP, self, self.onShowIapShop)

    Avalon.MessageCenter:bind(GameMessage.MC_BATTLE_REMOVE_BAG_PANEL, self, self.onRemoveBagLayerHandler)

    -- 显示大秘境入口
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_ENDLESS_SPACE, self, self.onShowDungeonGuardLayerHandler)
    -- 显示活动列表
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL, self, self.onShowActivityPanelHandler)
    -- 显示怪物详情
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_MONSTER_DETAIL,self,self.onshowMonsterDetailHandler)
    -- 移除怪物详情
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LEAVE_MONSTER_DETAIL,self,self.onRemoveMonsterDetailHandler)

    -- 显示查看玩家属性
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_ROLE_INFO, self, self.onViewRolePanelHandler)


    --显示排行榜
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_RANKING, self, self.onRankingLayerHandler)
    --显示工会科技
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_GUILD_TECH, self, self.onGuildTechOrSkillLayerHandler)
    --大秘境结算界面
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_DUNGEON_END_REWARD_LAYER, self, self.onDungronEndRewardHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_HERO_HEAD_TIPS, self, self.onShowClickHero)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_GUILD_MANAGER, self, self.onShowGuildManagerHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_GUILD_CREATE_OR_JOIN, self, self.onShowGuildCreateOrJoinHandler)
    --好友界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FRIEND_MAIN, self, self.onOpenFriendLayerHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_GUILD_TASK, self, self.onShowGuildTaskHandler)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_BIG_MAP, self, self.showBigMap)


    -- 显示存档点
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_CHECKPIONT, self, self.onShowAchieveHandler)

    -- 切换多语言
    Avalon.MessageCenter:bind(AvalonMessage.MC_SETTING_LANGUAGE, self, self.closeAllActivity)

    --内置浏览器
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_WEBVIEW_LAYER, self, self.openWebView)
    --地图碎片掉落界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_FRAGMENT_DROP, self, self.showFragmentLayer) 

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_MOLD_FRAGMENT_DROP, self, self.showMoldFragmentLayer) 
        --游戏内公告
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_TOEWN_NOTICE, self, self.showTownNotice)
    --宝石合成
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GEM_SYNTHESIS, self, self.onShowSynthesisLayer) 
    --宝石购买
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GEM_BUY, self, self.onShowGemBuyLayer) 
    --符文连接
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GEM_GEM_CONNECT, self, self.onShowGemConnectLayer) 
    --符文分解
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GEM_GEM_DECOMPOSE, self, self.onShowGemDecomposeLayer) 
    
    
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GEM_INLAY, self, self.onShowGemInlayLayer) 

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_COMMON_REWARD, self, self.onShowCommonRewardLayer) 
        --宝石转换
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GEM_TRANSFORM, self, self.onShowTransFormLayer)

    --处理设置等返回城镇的TIPS
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_BACK_TOWN_UI, self, self.onBackTownTips)
    --金矿
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_SHOW_UI, self, self.onShowGoldenMine)
    --符文工房
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_SHOW_UI, self, self.onShowRuneFactory)
    -- 环形任务
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CYCLE_TASK, self, self.onShowCycleTask)
    -- 进阶表现
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_UPGRADE_SKILL, self, self.onUpgradeSkill)
    -- 进阶详情
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_UPGRADE_INFO, self, self.onUpgradeSkillInfo)
    -- 设置界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_SETTINGS, self, self.onShowSettings)
    -- 幻化
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_EQUIP_ILLUSION_SHOW, self, self.onShowEquipIllusion)
    -- 显示活动奖励列表排行
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_ACTIVITY_RANK_DETAIL, self, self.onActivityRankDetail)
    -- 梦境试验
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_DREAM_CHALLENGE, self, self.onActivityDreamChallenge)
    -- 装备升级
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_EQUIP_CONVERT, self, self.onShowEquipConvert)
    -- 梦境排行榜
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_DREAM_RANK, self, self.openDreamRankLayer)
    -- 梦境商店
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_DREAM_SHOP, self, self.openDreamShopLayer)
    --接梦境任务
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_GET_DREAM_TASK, self, self.onShowGetDreamTask)
     --装备重铸界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_EQUIP_RECAST, self, self.onShowEquipRecast)
    -- 超值礼包
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_EXTRA_GIFT, self, self.onShowExtraGift)
    -- 进阶礼包
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_ADV_GIFG, self, self.onShowAdvGift)
    -- -- 七日目标
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_SHOW_SEVEN_DAY, self, self.onShowSevenDayGoal)
    -- 打开聊天主界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_CHAT_OPEN_MAIN_CHAT, self, self.onShowChatMainLayer) 
    -- 离开战斗战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_MAINUI_LAYER,self,self.removeBattleUIHandler)
    --打开宠物PVP结算界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_OPEN_PETPVPEND,self,self.openPetPVPEnd) 
    --boss直达
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_BOSS_DIRECT, self, self.onShowBossDirect)

    -- 打开聊天主界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_CHAT_OPEN_MAIN_CHAT_WORLD_TAG, self, self.onWorldChatByLottery) 
    --周年庆抽奖结果界面展示
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_REWARD, self, self.onShowAnniversaryLotteryRewardView) 
    --周年庆抽奖预览界面展示
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_PREVIEW, self, self.onShowAnniversaryLotteryPreView) 
end

-- 注销监听事件(可选)
function ActivityLayer:unRegisterListener()
    -- 战斗收获页面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REWARD, self, self.onRewardHandler)
    -- 显示任务窗口
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_SHOW_TASK, self, self.showTownTaskLayer)
    --邮箱
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_SHOW_MAILLAYER, self, self.showMailLayer)
        --关闭邮箱
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_CLOSE_MAILLAYER, self, self.closeMailLayer)
        --扭曲空间界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, self, self.onShowSpaceLevelSelect)
    -- 显示关卡选择
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, self, self.onShowLevelSelect)
    -- 处理黑商
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_BLACK_SHOP, self, self.onShowBlackShopHandler)
    -- 处理随机商店
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_RANDOM_SHOP, self, self.onShowRandomShopHandler)
    -- 显示强化界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_STRENGTHEN, self, self.onShowStrengthenHandler)
    -- 显示改造界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_REMOULD, self, self.onShowRemouldHandler)
    -- 显示分解界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_RESOLVE, self, self.onShowResolveHandler)
    -- 显示锻造界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_FORGE, self, self.onShowForgedHandler)
    -- 显示宠物强化界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_PET_STRENGTHEN, self, self.onShowPetStrengthenHandler)

    -- 显示洞穴商店
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_IN_CAVE_SHOP, self, self.onShowInCaveShopHandler)
    -- 显示洞穴点金
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_IN_CAVE_GOLDPOINTING, self, self.onShowInCaveGoldPointingHandler)
    -- 显示洞穴附魔
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_IN_CAVE_ENCHANTMENT, self, self.onShowInCaveEnchantmentLHandler)

        -- 角色状态更新 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    -- 关闭所有活动界面 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY, self, self.closeAllActivity)
        -- 显示捏脸
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_BEAUTYSALON, self, self.onShowBeautySalonHandler)
        -- 显示猫饭
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_CATFOOD, self, self.onShowCatFoodonHandler)
    -- 显示仓库
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_WAREHOUSE, self, self.onShowWarehouseHandler)
    --显示抽奖界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_LUCKDROP, self, self.onShowDropLayerHandler)

    --显示背包界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_BAG, self, self.onShowBagLayerHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_FUNCTION_PANEL, self, self.onShowFunctionPanelLayerHandler)
    
    -- 显示内购界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_IAPSHOP, self, self.onShowIapShop)

    Avalon.MessageCenter:unbind(GameMessage.MC_BATTLE_REMOVE_BAG_PANEL, self, self.onRemoveBagLayerHandler)

    -- 显示大秘境入口
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_ENDLESS_SPACE, self, self.onShowDungeonGuardLayerHandler)

    -- 显示怪物详情
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_MONSTER_DETAIL,self,self.onshowMonsterDetailHandler)
    -- 移除怪物详情
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LEAVE_MONSTER_DETAIL,self,self.onRemoveMonsterDetailHandler)


    -- 显示查看玩家属性
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_ROLE_INFO, self, self.onViewRolePanelHandler)

    --显示排行榜
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_RANKING, self, self.onRankingLayerHandler)

    --显示工会科技
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_GUILD_TECH, self, self.onGuildTechOrSkillLayerHandler)
        --大秘境结算界面
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_DUNGEON_END_REWARD_LAYER, self, self.onDungronEndRewardHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_HERO_HEAD_TIPS, self, self.onShowClickHero)
    
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_GUILD_MANAGER, self, self.onShowGuildManagerHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_GUILD_CREATE_OR_JOIN, self, self.onShowGuildCreateOrJoinHandler)
        --好友界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FRIEND_MAIN, self, self.onOpenFriendLayerHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_GUILD_TASK, self, self.onShowGuildTaskHandler)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_BIG_MAP, self, self.showBigMap)

    -- 显示活动列表
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL, self, self.onShowActivityPanelHandler)
    -- 显示存档点
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_CHECKPIONT, self, self.onShowAchieveHandler)

    -- 切换多语言
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SETTING_LANGUAGE, self, self.closeAllActivity)

    --内置浏览器
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_WEBVIEW_LAYER, self, self.openWebView)
    --地图碎片掉落界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_FRAGMENT_DROP, self, self.showFragmentLayer) 

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_MOLD_FRAGMENT_DROP, self, self.showMoldFragmentLayer) 
    --游戏内公告
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_TOEWN_NOTICE, self, self.showTownNotice) 
    --宝石合成
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GEM_SYNTHESIS, self, self.onShowSynthesisLayer)
    --宝石购买
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GEM_BUY, self, self.onShowGemBuyLayer) 
    --符文连接
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GEM_GEM_CONNECT, self, self.onShowGemConnectLayer)
    --符文分解
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GEM_GEM_DECOMPOSE, self, self.onShowGemDecomposeLayer)
    
    
    
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GEM_INLAY, self, self.onShowGemInlayLayer) 

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_COMMON_REWARD, self, self.onShowCommonRewardLayer) 
    --宝石转换
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GEM_TRANSFORM, self, self.onShowTransFormLayer)
    --处理设置等返回城镇的TIPS
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_BACK_TOWN_UI, self, self.onBackTownTips)
    --金矿
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_SHOW_UI, self, self.onShowGoldenMine)
    --符文工房
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_SHOW_UI, self, self.onShowRuneFactory)
    -- 环形任务
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CYCLE_TASK, self, self.onShowCycleTask)
    -- 进阶表现
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_UPGRADE_SKILL, self, self.onUpgradeSkill)
    -- 进阶详情
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_UPGRADE_INFO, self, self.onUpgradeSkillInfo)
    -- 设置界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_SETTINGS, self, self.onShowSettings)
    -- 幻化
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_EQUIP_ILLUSION_SHOW, self, self.onShowEquipIllusion)
    -- 显示活动奖励列表排行
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_ACTIVITY_RANK_DETAIL, self, self.onActivityRankDetail)
    -- 梦境试验
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_DREAM_CHALLENGE, self, self.onActivityDreamChallenge)
    -- 装备升级
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_EQUIP_CONVERT, self, self.onShowEquipConvert)
    -- 梦境排行榜
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_DREAM_RANK, self, self.openDreamRankLayer)
    -- 梦境商店
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_DREAM_SHOP, self, self.openDreamShopLayer)
    --接梦境任务
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_GET_DREAM_TASK, self, self.onShowGetDreamTask)
    --装备重铸界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_EQUIP_RECAST, self, self.onShowEquipRecast)
    -- 超值礼包
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_EXTRA_GIFT, self, self.onShowExtraGift)
    -- 进阶礼包
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_ADV_GIFG, self, self.onShowAdvGift)
    -- -- 七日目标
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_SHOW_SEVEN_DAY, self, self.onShowSevenDayGoal)
    -- 打开聊天主界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CHAT_OPEN_MAIN_CHAT, self, self.onShowChatMainLayer)
     -- 离开战斗战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_MAINUI_LAYER,self,self.removeBattleUIHandler)
     --打开宠物PVP结算界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_OPEN_PETPVPEND,self,self.openPetPVPEnd) 
    -- Boss直达
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_BOSS_DIRECT, self, self.onShowBossDirect)
    -- 打开聊天主界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CHAT_OPEN_MAIN_CHAT_WORLD_TAG, self, self.onWorldChatByLottery)  
    --周年庆抽奖结果界面展示
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_REWARD, self, self.onShowAnniversaryLotteryRewardView) 
    --周年庆抽奖预览界面展示
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_PREVIEW, self, self.onShowAnniversaryLotteryPreView)  
end

-- 幻化界面
function ActivityLayer:onShowEquipIllusion(npcSpriteID)
    print("-------ActivityLayer:onShowEquipIllusion(")
    if(self.rootLayer) then 
        self:closeAllActivity()
        local equipIllusionLayer = self.rootLayer:getChildByName("EquipIllusionLayer")
        if equipIllusionLayer == nil then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.equipIllusionLayer.EquipIllusionLayer")
                local equipIllusionLayer = UI.EquipIllusionLayer:create(npcSpriteID)
                equipIllusionLayer:center()
                equipIllusionLayer:setName("EquipIllusionLayer")
                self.rootLayer:addChild(equipIllusionLayer, UI_ZORDER.ACTIVITY)
                GameManager:stopMoveHandler()
            end
        end
    end 
end

-- 设置界面
function ActivityLayer:onShowSettings()
    print("-------ActivityLayer:onShowSettings(")
    if(self.rootLayer) then 
        self:closeAllActivity()
        local settingsLayer = self.rootLayer:getChildByName("SettingsLayer")
        if settingsLayer == nil then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.settingsLayer.SettingsLayer")
                local settingsLayer = UI.SettingsLayer:create()
                settingsLayer:center()
                settingsLayer:setName("SettingsLayer")
                UI.UIManager:getRootNode():addChild(settingsLayer, UI_ZORDER.MAIN_UI )
                GameManager:stopMoveHandler()
            end
        end
    end 
end

-- 显示大秘境入口
function ActivityLayer:onShowDungeonGuardLayerHandler(NPCSpriteID)
    print("-------ActivityLayer:onShowDungeonGuardLayerHandler(")
    if(self.rootLayer) then 

        if TeamDataManager:getReadyState() == false then
            self:closeAllActivity()
            local guardLayer = self.rootLayer:getChildByName("DungeonGuardLayer")
            if guardLayer == nil then
                -- 处理隐藏掉其余控件
                Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
                if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                    require("app.ui.dungeon.DungeonGuardLayer")
                    local guardLayer = UI.DungeonGuardLayer:create(NPCSpriteID)
                    guardLayer:setName("DungeonGuardLayer")
                    self.rootLayer:addChild(guardLayer,UI_ZORDER.ACTIVITY);
                    GameManager:stopMoveHandler()
                end
            end
        else
            --正在匹配
        end
    end 
end

-- 显示装备改造
function ActivityLayer:onShowRemouldHandler(NPCSpriteID)
    self:closeAllActivity()
    local pRemouldLayer = self.rootLayer:getChildByName("RemouldLayer")
    if pRemouldLayer == nil then

        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.remouldLayer.RemouldLayer")
            local pRemouldLayer = UI.RemouldLayer:create(NPCSpriteID)
            pRemouldLayer:centerLeft(0)
            pRemouldLayer:setName("RemouldLayer")
            self.rootLayer:addChild(pRemouldLayer,UI_ZORDER.ACTIVITY);
            GameManager:stopMoveHandler()
        end
    end
end

-- 显示装备强化
function ActivityLayer:onShowStrengthenHandler(NPCSpriteID)
    self:closeAllActivity()
    local pStrengthenLayer = self.rootLayer:getChildByName("StrengthenLayer")
    if pStrengthenLayer == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.strengthenLayer.StrengthenLayer")
            local pStrengthenLayer = UI.StrengthenLayer:create(NPCSpriteID)
            pStrengthenLayer:centerLeft(0)
            pStrengthenLayer:setName("StrengthenLayer")
            self.rootLayer:addChild(pStrengthenLayer,UI_ZORDER.ACTIVITY)
            GameManager:stopMoveHandler()
        end
    end
end

-- 处理宠物装备强化
function ActivityLayer:onShowPetStrengthenHandler(NPCSpriteID)
    self:closeAllActivity()
    local pStrengthenLayer = self.rootLayer:getChildByName("StrengthenLayerPet")
    if pStrengthenLayer == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.strengthenLayer.StrengthenLayerPet")
            local pStrengthenLayer = UI.StrengthenLayerPet:create(NPCSpriteID)
            pStrengthenLayer:centerLeft(0)
            pStrengthenLayer:setName("StrengthenLayerPet")
            self.rootLayer:addChild(pStrengthenLayer,UI_ZORDER.ACTIVITY)
            GameManager:stopMoveHandler()
        end
    end
end

-- 显示装备分解
function ActivityLayer:onShowResolveHandler(NPCSpriteID)
   self:closeAllActivity()
    if(self.rootLayer) then 
        local rsolveLayer = self.rootLayer:getChildByName("ResolveLayer")
        if rsolveLayer == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.resolveLayer.ResolveLayer")
                local rsolveLayer = UI.ResolveLayer:create(NPCSpriteID)
                rsolveLayer:centerLeft(0)
                rsolveLayer:setName("ResolveLayer")
                self.rootLayer:addChild(rsolveLayer,UI_ZORDER.ACTIVITY)
                GameManager:stopMoveHandler()
            end
        end
    end 
end

-- 显示装备锻造
function ActivityLayer:onShowForgedHandler(NPCSpriteID)
    if(self.rootLayer) then 
        self:closeAllActivity()
        local EquipForgeLayer = self.rootLayer:getChildByName("EquipForgeLayer")
        if EquipForgeLayer == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.equipForge.EquipForgeLayer")
                local EquipForgeLayer = UI.EquipForgeLayer:create(NPCSpriteID)
                EquipForgeLayer:center()
                EquipForgeLayer:setName("EquipForgeLayer")
                self.rootLayer:addChild(EquipForgeLayer,UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

--显示抽奖
function ActivityLayer:onShowDropLayerHandler(NPCSpriteID)
    if(self.rootLayer) then 
        local luckDropLayer = self.rootLayer:getChildByName("LuckDropLayer")
        if luckDropLayer == nil then
            self:closeAllActivity()
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.luckDropLayer.LuckDropLayer")
                local luckDropLayer = UI.LuckDropLayer:create(NPCSpriteID)
                luckDropLayer:centerLeft(0)
                luckDropLayer:setName("LuckDropLayer")
                self.rootLayer:addChild(luckDropLayer,UI_ZORDER.ACTIVITY)
                GameManager:stopMoveHandler()
            end
        end
    end 
end

-- 显示猫饭
function ActivityLayer:onShowCatFoodonHandler(NPCSpriteID, gobackWin, caveMode)
    if(self.rootLayer) then 
        if(gobackWin == nil) then
            self:closeAllActivity()
        end
        local forgeLayer = self.rootLayer:getChildByName("CatFoodLayer")
        if forgeLayer == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.catfoodlayer.CatFoodLayer")
                local forgeLayer = UI.CatFoodLayer:create()
                forgeLayer:setGoBackWin(gobackWin)
                forgeLayer:init(NPCSpriteID, caveMode)
                forgeLayer:center()
                forgeLayer:setName("CatFoodLayer")
                self.rootLayer:addChild(forgeLayer,UI_ZORDER.ACTIVITY)
                forgeLayer:openShow()
                GameManager:stopMoveHandler()
            end
        end
    end 
end

-- 显示洞穴商店
function ActivityLayer:onShowInCaveShopHandler(NPCSpriteID)
    self:closeAllActivity()
    local shopPanel = self.rootLayer:getChildByName("CaveShopPanel")
    if shopPanel == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require "app.ui.shoplayer.CaveShopPanel"
            local shopPanel = UI.CaveShopPanel:create()
            shopPanel:center()
            shopPanel:init(NPCSpriteID)
            shopPanel:setName("CaveShopPanel")
            self.rootLayer:addChild(shopPanel,UI_ZORDER.ACTIVITY)
            GameManager:stopMoveHandler()
        end
    end
end

-- 显示黑商
function ActivityLayer:onShowBlackShopHandler(NPCSpriteID)
    self:closeAllActivity()
    local shopPanel = self.rootLayer:getChildByName("BlackShopPanel")
    if shopPanel == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require "app.ui.blackShop.BlackShopPanel"
            local shopPanel = UI.BlackShopPanel:create()
            shopPanel:center()
            shopPanel:init(NPCSpriteID)
            shopPanel:setName("BlackShopPanel")
            self.rootLayer:addChild(shopPanel,UI_ZORDER.ACTIVITY)
            GameManager:stopMoveHandler()
        end
    end
end

-- 显示随机商店
function ActivityLayer:onShowRandomShopHandler(NPCSpriteID)
    self:closeAllActivity()
    local shopPanel = self.rootLayer:getChildByName("RandomShopPanel")
    if shopPanel == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require "app.ui.randomshop.RandomShopPanel"
            local shopPanel = UI.RandomShopPanel:create()
            shopPanel:center()
            shopPanel:init(NPCSpriteID)
            shopPanel:setName("RandomShopPanel")
            self.rootLayer:addChild(shopPanel,UI_ZORDER.ACTIVITY);
            GameManager:stopMoveHandler()
        end
    end
end

-- 显示附魔商店
function ActivityLayer:onShowInCaveEnchantmentLHandler(NPCSpriteID)
    self:closeAllActivity()
    local pEnchantmentLayer = self.rootLayer:getChildByName("EnchantmentLayer")
    if pEnchantmentLayer == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.enchantmentLayer.EnchantmentLayer")
            local pEnchantmentLayer = UI.EnchantmentLayer:create(NPCSpriteID)
            pEnchantmentLayer:centerLeft(0)
            pEnchantmentLayer:setName("EnchantmentLayer")
            self.rootLayer:addChild(pEnchantmentLayer,UI_ZORDER.ACTIVITY);
            GameManager:stopMoveHandler()
        end
    end
end

-- 显示点金商店
function ActivityLayer:onShowInCaveGoldPointingHandler(NPCSpriteID)
    self:closeAllActivity()
    local pGoldPointingLayer = self.rootLayer:getChildByName("GoldPointingLayer")
    if pGoldPointingLayer == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.goldPointingLayer.GoldPointingLayer")
            local pGoldPointingLayer = UI.GoldPointingLayer:create(NPCSpriteID)
            pGoldPointingLayer:centerLeft(0)
            pGoldPointingLayer:setName("GoldPointingLayer")
            self.rootLayer:addChild(pGoldPointingLayer,UI_ZORDER.ACTIVITY);
            GameManager:stopMoveHandler()
        end
    end
end


-- 显示关卡选择
function ActivityLayer:onShowLevelSelect(NPCSpriteID, params)
    -- self:closeAllActivity()
    require("app.ui.town.levelSelect.LevelSelect")
    require("app.net.NetTeamSystem")
    local layerType = params
    local isFirst = false
    local extraData = {}
    if type(params) == "table" then
        layerType = params.layerType
        isFirst = params.isFirst
        extraData.caveMode = params.caveMode
    end
    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    if TeamDataManager:getReadyState() == false then
        local pLevelSelect = self.rootLayer:getChildByName("LevelSelect")
        if pLevelSelect == nil then
            self:closeAllActivity()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            local pLevelSelect = UI.LevelSelect:create(NPCSpriteID, layerType, extraData, isFirst)
            pLevelSelect._enableAutoUpdatePos = false
            pLevelSelect:setIgnoreAnchorPointForPosition(false)
            pLevelSelect:setAnchorPoint(0, 0.5)
            pLevelSelect:setPosition(0, winSize.height / 2)
            pLevelSelect:setName("LevelSelect")
            self.rootLayer:addChild(pLevelSelect,UI_ZORDER.ACTIVITY);
            GameManager:stopMoveHandler()
            if RoleDataManager:getIsReincarntion() and 
            (layerType ~= Game.LevelSelectLayerType.Desert_Eye and layerType ~= Game.LevelSelectLayerType.Dried_Spring) then
                LevelSelectUtil:getInstance():setSwitchCaveLayerType(layerType)
            end
        end
    else
        UI.ScrollBar:createByText(UI.TEXT_1212055)
        -- add by zp CO-9601【城镇】异常打开npc界面
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER, nil)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
    end
end


-- 显示关卡选择
function ActivityLayer:onShowSpaceLevelSelect(NPCSpriteID, layerType)
    -- self:closeAllActivity()
    require("app.ui.town.distortedSpace.SpaceLevelSelect")
    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    if TeamDataManager:getReadyState() == false then
        local pSpaceLevelSelect = self.rootLayer:getChildByName("SpaceLevelSelect")
        if pSpaceLevelSelect == nil then
            self:closeAllActivity()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            local disType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectTimeDistoreMode..GameDataManager:getInstance():getMasterPK(), Game.DISTORTED_TYPE.NORMAL)
            if(disType == Game.DISTORTED_TYPE.NORMAL or layerType == Game.LevelSelectLayerType.Distorted_Space) then
                local pLevelSelect = UI.SpaceLevelSelect:create(NPCSpriteID, layerType)
                pLevelSelect:center()
                pLevelSelect:setName("SpaceLevelSelect")
                self.rootLayer:addChild(pLevelSelect,UI_ZORDER.ACTIVITY);
            elseif disType == Game.DISTORTED_TYPE.INFERNO or layerType == Game.LevelSelectLayerType.Inferno then
                mvc.openPanel("Cave", "InfernoLevelSelect")
            elseif disType == Game.DISTORTED_TYPE.VOIDRIFT or layerType == Game.LevelSelectLayerType.VoidRift then
                mvc.openPanel("Cave", "VoidRiftLevelSelect")
            end
            GameManager:stopMoveHandler()
        end
    else
        UI.ScrollBar:createByText(UI.TEXT_1212055)
        -- add by zp CO-9601【城镇】异常打开npc界面
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER, nil)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
    end
end


-- 城镇任务UI
function ActivityLayer:showTownTaskLayer(spriteID)
    self:closeAllActivity()
    local tasklayer = self.rootLayer:getChildByName("TownTaskLayerUI")
    if tasklayer == nil then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require "app.ui.baglayer.TaskLayer.TownTaskLayerUI"
            local tasklayer = UI.TownTaskLayerUI:create(spriteID, UI.TaskLayerUIType.TASKLAYER_TOWN)
            tasklayer:init()
            tasklayer:center()
            tasklayer:setName("TownTaskLayerUI")
            self.rootLayer:addChild(tasklayer,UI_ZORDER.ACTIVITY)
            tasklayer:openShow()
            GameManager:stopMoveHandler()
        end
    end
end

-- 成就UI
function ActivityLayer:showAchievementLayer(spriteID)
    self:closeAllActivity()
    local tasklayer = self.rootLayer:getChildByName("TownTaskLayerUI")
    if tasklayer == nil then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require "app.ui.baglayer.TaskLayer.TownTaskLayerUI"
            tasklayer = UI.TownTaskLayerUI:create(spriteID, UI.TaskLayerUIType.TASKLAYER_TOWN)
            tasklayer:init()
            tasklayer:center()
            tasklayer:setName("TownTaskLayerUI")
            self.rootLayer:addChild(tasklayer,UI_ZORDER.ACTIVITY)
            tasklayer:choiceTabIndex(PublicDefine.UnlockFunctionType.UnlockFunctionType_Achievement)
            tasklayer:openShow()
            GameManager:stopMoveHandler()
        end
    else 
        tasklayer:choiceTabIndex(PublicDefine.UnlockFunctionType.UnlockFunctionType_Achievement)
    end
end

-- 战斗收获页面
function ActivityLayer:onRewardHandler(closeCallback, rewardType)
    if(rewardType ~= UI.RewardType.REWARD_DEEPLINK) then
        self:closeAllActivity()
    end

    print("ActivityLayer:onRewardHandler")
    -- 获取装备和角色数据
    local pDungeonBattleRewardLayer = self.rootLayer:getChildByName("DungeonBattleRewardLayer")
    if(pDungeonBattleRewardLayer == nil) then
        require("app.ui.dungeon.DungeonBattleRewardLayer")
        pDungeonBattleRewardLayer = UI.DungeonBattleRewardLayer:create(closeCallback, rewardType)
        pDungeonBattleRewardLayer:center()
        pDungeonBattleRewardLayer:setName("DungeonBattleRewardLayer")
        self.rootLayer:addChild(pDungeonBattleRewardLayer,UI_ZORDER.ACTIVITY);
        GameManager:stopMoveHandler()
    end
end

--显示捏脸
function ActivityLayer:onShowBeautySalonHandler(NPCSpriteID)
    self:closeAllActivity()
    print("ActivityLayer:onShowBeautySalonHandler")
    local pBeautySalonLayer = self.rootLayer:getChildByName("BeautySalonLayer")
    if pBeautySalonLayer == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.beautySalonLayer.BeautySalonLayer")
            pBeautySalonLayer = UI.BeautySalonLayer:create(NPCSpriteID)
            pBeautySalonLayer:center()
            pBeautySalonLayer:setName("BeautySalonLayer")
            self.rootLayer:addChild(pBeautySalonLayer,UI_ZORDER.ACTIVITY);
            GameManager:stopMoveHandler()
        end
        
    end
end

--显示仓库
function ActivityLayer:onShowWarehouseHandler(NPCSpriteID)
    self:closeAllActivity()
    local pWarehouseLayer = self.rootLayer:getChildByName("WarehouseLayer")
    if pWarehouseLayer == nil then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.warehouseLayer.WarehouseLayer")
            pWarehouseLayer = UI.WarehouseLayer:create(NPCSpriteID)
            pWarehouseLayer:centerLeft(0)
            pWarehouseLayer:setName("WarehouseLayer")
            self.rootLayer:addChild(pWarehouseLayer,UI_ZORDER.ACTIVITY);
            GameManager:stopMoveHandler()
        end
    end
end
-- 显示内购
function ActivityLayer:onShowIapShop(isToHideMainLayer, index, gobackWin, sourceType, isShowBox)
    local iapPanel = self.rootLayer:getChildByName("ShopPanel")
    if isToHideMainLayer then
        self:closeAllActivity()
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if tolua.isnull(iapPanel) then
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                iapPanel = UI.IapShopMainLayer:create(isToHideMainLayer, index, sourceType, isShowBox)
                iapPanel:setGoBackWin(gobackWin)
                iapPanel:init()
                iapPanel:center()
                iapPanel:setName("ShopPanel")
                self.rootLayer:addChild(iapPanel, UI_ZORDER.ACTIVITY); 
                GameManager:stopMoveHandler()
            end
        end
    else
        if tolua.isnull(iapPanel) then
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                iapPanel = UI.IapShopMainLayer:create(isToHideMainLayer, index, sourceType, isShowBox)
                iapPanel:setGoBackWin(gobackWin)
                iapPanel:init()
                iapPanel:center()
                iapPanel:setName("ShopPanel")
                self.rootLayer:addChild(iapPanel, UI_ZORDER.ACTIVITY); 
                GameManager:stopMoveHandler()
            end
        end
    end
end

--显示背包
function ActivityLayer:onShowBagLayerHandler(idx)
    self:closeAllActivity()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
    local pBagPanel = self.rootLayer:getChildByName("BagPanel")
    if pBagPanel == nil then
        local bagData = GameDataManager:getInstance():getPacketBoxData()
        require "app.ui.baglayer.BagPanel"
        pBagPanel = UI.BagPanel:create(idx)
        pBagPanel:init(bagData)
        pBagPanel:centerBottom((cc.Director:getInstance():getWinSize().height -  pBagPanel:getContentSize().height) / 2 - 5)
        pBagPanel:setName("BagPanel")
        self.rootLayer:addChild(pBagPanel,UI_ZORDER.ACTIVITY);
        GameManager:stopMoveHandler()
    end
end

-- 移除背包界面
function ActivityLayer:onRemoveBagLayerHandler()
    print("ActivityLayer:onRemoveBagLayerHandler")
    local pBagPanel = self.rootLayer:getChildByName("BagPanel")
    if pBagPanel ~= nil then
        -- pBagPanel:close()
        pBagPanel:closeWin()
    end

    local pBagPanel = self.rootLayer:getChildByName("FunctionsPanel")
    if pBagPanel ~= nil then
        -- pBagPanel:close()
        pBagPanel:closeWin()
    end
end

--显示背包
function ActivityLayer:onShowFunctionPanelLayerHandler(idx)
    self:closeAllActivity()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
    local pBagPanel = self.rootLayer:getChildByName("FunctionsPanel")
    if pBagPanel == nil then
        local spriteID = 0
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        if (machine) then
            local model = machine:getModel()
            if (model) then
                local modelArr = model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.ACHIEVEMENT)
                if(modelArr and #modelArr > 0) then 
                    spriteID = modelArr[1]:getSpriteID()
                end
            end
        end

        local bagData = GameDataManager:getInstance():getPacketBoxData()
        require "app.ui.baglayer.FunctionsPanel"
        pBagPanel = UI.FunctionsPanel:create(idx, spriteID)
        pBagPanel:init(bagData)
        pBagPanel:centerBottom((cc.Director:getInstance():getWinSize().height -  pBagPanel:getContentSize().height) / 2 - 5)
        pBagPanel:setName("FunctionsPanel")
        self.rootLayer:addChild(pBagPanel,UI_ZORDER.ACTIVITY);
        GameManager:stopMoveHandler()
    end
end


-- 显示怪物详情界面
function ActivityLayer:onshowMonsterDetailHandler(monsterData)
    if monsterData then
        if monsterData:getMonsterSubType() == PublicDefine.MonsterSubType.HitRat
            or monsterData:getMonsterSubType() == PublicDefine.MonsterSubType.Puzzle then
            return
        end

        local heroData = RoleDataManager:getMaster()
        local state = heroData:getState()
        -- 战斗状态屏蔽探险技能
        if state ~= 3 then 
            -- print("----非战斗状态")
            self.rootLayer:removeChildByName("MonsterBoxLayer", true)
            local pMonsterBoxLayer = UI.MonsterBoxLayer:create()
            pMonsterBoxLayer:init(monsterData) 

            local posX, posY = monsterData:getAbsPosition()
            if posX > winSize.width / 2 then
                posX = posX - pMonsterBoxLayer._width - 50
            else
                posX = posX + 50
            end
            -- posY = posY + pMonsterBoxLayer._height / 2
            if posY + pMonsterBoxLayer._height > winSize.height then
                posY = winSize.height - pMonsterBoxLayer._height
            end
                
            pMonsterBoxLayer:leftBottom(posX, posY)
            pMonsterBoxLayer:setName("MonsterBoxLayer")
            self.rootLayer:addChild(pMonsterBoxLayer,UI_ZORDER.ACTIVITY);
        end
    end   
end

-- 松手移除怪物详情界面
function ActivityLayer:onRemoveMonsterDetailHandler()
    local pMonsterBoxLayer = self.rootLayer:getChildByName("MonsterBoxLayer")
    if pMonsterBoxLayer and not tolua.isnull(pMonsterBoxLayer) then
        pMonsterBoxLayer:removeMonster()
    end
end


-- 通过头像 查看队友信息
function ActivityLayer:onViewRolePanelHandler(detailData)
    -- self:closeAllActivity()
    -- 获取装备和角色数据
         -- 
    local parent = UI.UIManager:getRootNode()
    local levelSelectTeam1 = UI.UIManager:getRootNode():getChildByName("LevelSelectTeam1")
    if(not tolua.isnull(levelSelectTeam1)) then
        parent = levelSelectTeam1
    end
    local pViewFriendInfoLayer = parent:getChildByName("ViewFriendInfoLayer")
    if(pViewFriendInfoLayer == nil) then
        require "app.ui.team.ViewFriendInfoLayer"
        pViewFriendInfoLayer = UI.ViewFriendInfoLayer:create()
        pViewFriendInfoLayer:center()
        pViewFriendInfoLayer:init(detailData)
        pViewFriendInfoLayer:setName("ViewFriendInfoLayer")
        parent:addChild(pViewFriendInfoLayer, UI_ZORDER.EQUIPMENTINFO);
        -- parent:addChild(pViewFriendInfoLayer, UI_ZORDER.TOP_ACTIVITY);
        GameManager:stopMoveHandler()
    end
end


-- 排行榜
function ActivityLayer:onRankingLayerHandler(detailData)
    self:closeAllActivity()
    -- 获取装备和角色数据
    local pRankingLayer = self.rootLayer:getChildByName("RankingLayer")
    if(pRankingLayer == nil) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            pRankingLayer = UI.RankingLayer:create(400)
            pRankingLayer:center(-20)
            pRankingLayer:setName("RankingLayer")
            self.rootLayer:addChild(pRankingLayer,UI_ZORDER.ACTIVITY);
            pRankingLayer:openShow()
            GameManager:stopMoveHandler()
        end
    end
end

-- 公会科技
function ActivityLayer:onGuildTechOrSkillLayerHandler(NPCSpriteID)
    self:closeAllActivity()
    print("ActivityLayer:onGuildTechOrSkillLayerHandler",NPCSpriteID)
    -- 获取装备和角色数据
    local pGuildTechOrSkillLayer = self.rootLayer:getChildByName("GuildTechOrSkillLayer")
    if(pGuildTechOrSkillLayer == nil) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.guild.GuildTechOrSkillLayer")
            pGuildTechOrSkillLayer = UI.GuildTechOrSkillLayer:create(NPCSpriteID)
            pGuildTechOrSkillLayer:center()
            pGuildTechOrSkillLayer:setName("GuildTechOrSkillLayer")
            self.rootLayer:addChild(pGuildTechOrSkillLayer,UI_ZORDER.ACTIVITY);
            pGuildTechOrSkillLayer:openShow()
            GameManager:stopMoveHandler()
        end
    end
end


-- -- 
-- function ActivityLayer:onDungronEndRewardHandler(closeCallback)
--     self:closeAllActivity()
--     print("ActivityLayer:onDungronEndRewardHandler")
--     -- 获取装备和角色数据
--     local pDungeonBattleRewardLayer = self.rootLayer:getChildByName("DungeonBattleRewardLayer")
--     if(pDungeonBattleRewardLayer == nil) then
--         require("app.ui.dungeon.DungeonBattleRewardLayer")
--         pDungeonBattleRewardLayer = UI.DungeonBattleRewardLayer:create(closeCallback, UI.RewardType.REWARD_DUNGEON)
--         pDungeonBattleRewardLayer:center()
--         pDungeonBattleRewardLayer:setName("DungeonBattleRewardLayer")
--         self.rootLayer:addChild(pDungeonBattleRewardLayer,UI_ZORDER.ACTIVITY);
--         GameManager:stopMoveHandler()
--     end
-- end

-- 
function ActivityLayer:onShowGuildManagerHandler(defaultIdx)
    self:closeAllActivity()
    local managerPanel = self.rootLayer:getChildByName("GuildManagerPanel")
    if(managerPanel == nil) then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require "app.ui.guild.manager.GuildManagerPanel"
            local managerPanel = UI.GuildManagerPanel:create(defaultIdx)
            managerPanel:center()
            managerPanel:setName("GuildManagerPanel")
            self.rootLayer:addChild(managerPanel,UI_ZORDER.ACTIVITY);
            managerPanel:openShow()
            GameManager:stopMoveHandler()
        end
    end
end

function ActivityLayer:onShowGuildCreateOrJoinHandler()
    self:closeAllActivity()
    local createOrJoinPanel = self.rootLayer:getChildByName("CreateOrJoinPanel")
    if(createOrJoinPanel == nil) then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.guild.createOrJoin.CreateOrJoinPanel")
            local createOrJoinPanel = UI.CreateOrJoinPanel:create()
            createOrJoinPanel:center()
            createOrJoinPanel:setName("CreateOrJoinPanel")
            self.rootLayer:addChild(createOrJoinPanel, UI_ZORDER.ACTIVITY);
            createOrJoinPanel:openShow()
            GameManager:stopMoveHandler()
        end
    end
end

function ActivityLayer:onShowGuildTaskHandler(spriteID)
    self:closeAllActivity()
    local taskPanel = self.rootLayer:getChildByName("TaskPanel")
    if(taskPanel == nil) then
        -- 处理隐藏掉其余控件
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            require("app.ui.guild.task.TaskPanel")
            local taskPanel = UI.TaskPanel:create(spriteID)
            taskPanel:center()
            taskPanel:setName("TaskPanel")
            self.rootLayer:addChild(taskPanel, UI_ZORDER.ACTIVITY);
            taskPanel:openShow()
            GameManager:stopMoveHandler()
        end
    end
end

function ActivityLayer:onShowClickHero(data, x, y, uiType)
    -- self:closeAllActivity()
    print("ActivityLayer:onShowClickHero", x, y)
    local uiType = uiType or UIType.GUILD_CHOICE_HERO
    local pHeadTips = self.rootLayer:getChildByName("HeadTips")
    if(pHeadTips == nil) then
        local pHeadTips = UI.HeadTips:create(uiType)

        pHeadTips:leftBottom(x, y)
        pHeadTips:init(data)
        pHeadTips:setName("HeadTips")
        self.rootLayer:addChild(pHeadTips, UI_ZORDER.ACTIVITY)

        -- TODO 考虑一下是否会被底部
        if(y < pHeadTips:getContentSize().height) then
            y = pHeadTips:getContentSize().height
            pHeadTips:leftBottom(x, y)
        end
    end
end

function ActivityLayer:onOpenFriendLayerHandler(NPCSpriteID)
    self:closeAllActivity()
     print("ActivityLayer:onOpenFriendLayerHandler",NPCSpriteID)
    -- 获取装备和角色数据
    local pFriendsLayer = self.rootLayer:getChildByName("FriendsLayer")
    if(pFriendsLayer == nil) then
        require ("app.ui.social.friends.FriendsLayer")
        pFriendsLayer = UI.FriendsLayer:create(NPCSpriteID, UI.FRIEND_LAYER_SHOW_MODEL.INFO)
        pFriendsLayer:setName("FriendsLayer")
        self.rootLayer:addChild(pFriendsLayer,UI_ZORDER.ACTIVITY);
        pFriendsLayer:showLayer();
        -- pFriendsLayer:enableDebugDraw()
    end
end

function ActivityLayer:showBigMap(mapData,disableFog,mapView, targetID)
    self:closeAllActivity()

 -- 处理隐藏掉其余控件
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
    if(self.rootLayer) then
        -- local pBigMap = self.rootLayer:getChildByName("BigMap")
        -- local pBigMap = UI.UIManager:getRootNode():getChildByName("BigMap")
        local pBigMap = UI.UIManager.mMainUILayer:getChildByName("BigMap")
        if (not pBigMap or tolua.isnull(pBigMap)) then
            -- reload_script_file("app.ui.minimap.BigMap")
            require "app.ui.minimap.BigMap"
            pBigMap = UI.BigMap:create(targetID)
            pBigMap:init(mapData)
            pBigMap:center()
            pBigMap:hide()
            pBigMap:setName("BigMap")

            if (SceneManager:getInstance():isNotInFightScene()) then
                pBigMap:disableFog()
                pBigMap:enableRenderMapGridTexture()
                pBigMap:showTeammate(false)
            end

            UI.UIManager.mMainUILayer:addChild(pBigMap)
            -- UI.UIManager:getRootNode():addChild(pBigMap, UI_ZORDER.ACTIVITY_NEW -1)
            -- self.rootLayer:addChild(pBigMap, UI_ZORDER.BIG_MAP)
        end
        pBigMap:show()
        if (disableFog) then
            pBigMap:getMapView():disableFog()
            pBigMap:getMapView():updateView()
        else
            local bigMapView = pBigMap:getMapView()
            local bigMapGrids = pBigMap:getMapGridList()
            local minMapGrids = mapView:getMapGridList()
            for index, miniMapGrid in pairs(minMapGrids) do
                local bigMapGrid = bigMapGrids[index]
                bigMapGrid:setOpacity(miniMapGrid:getOpacity())
                if (bigMapGrid:isVisible()) then
                    bigMapView:updateMapGrid(bigMapGrid)
                end
            end
        end
        GameManager:stopMoveHandler()
    end
end


-- 显示存档点
function ActivityLayer:onShowAchieveHandler()
    require "app.ui.checkPointLayer.CheckPointLayer"
    local checkPoint = UI.CheckPointLayer:create()
    checkPoint:init()
    checkPoint:center()
    self.rootLayer:addChild(checkPoint, 10)
end


function ActivityLayer:showMailLayer(NPCSpriteID, sourceType)
    if(self.rootLayer) then 
        self:closeAllActivity()
        local mailLayer = self.rootLayer:getChildByName("MailLayer")
        if mailLayer == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.mail.MailLayer")
                local mailLayer = UI.MailLayer:create(NPCSpriteID, sourceType)
                mailLayer:center(0)
                mailLayer:setName("MailLayer")
                self.rootLayer:addChild(mailLayer,UI_ZORDER.ACTIVITY);
                mailLayer:openShow()
            end
            GameManager:stopMoveHandler()
        end
    end 
end

--关闭邮箱
function ActivityLayer:closeMailLayer()
    if(self.rootLayer) then 
        local mailLayer = self.rootLayer:getChildByName("MailLayer")
        if mailLayer ~= nil then
            -- 处理隐藏掉其余控件
            mailLayer:closeCallback()
        end
    end 
end

-- 显示活动列表
function ActivityLayer:onShowActivityPanelHandler(NPCSpriteID, sourceType)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        local activityPanel = self.rootLayer:getChildByName("ActivityPanel")
        if activityPanel == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.activity.ActivityPanel")
                local activityPanel = UI.ActivityPanel:create(NPCSpriteID, sourceType)
                activityPanel:center(0)
                activityPanel:init()
                activityPanel:setName("ActivityPanel")
                self.rootLayer:addChild(activityPanel, UI_ZORDER.ACTIVITY);
                activityPanel:openShow()
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:showFragmentLayer(goodsData)
    if(self.rootLayer) then 
        local dropFragment = self.rootLayer:getChildByName("DropFragment")
        if dropFragment == nil then
            require("app.ui.tips.DropFragment")
            local dropFragment = UI.DropFragment:create(goodsData)
            dropFragment:center(0)
            dropFragment:setName("DropFragment")
            self.rootLayer:addChild(dropFragment,UI_ZORDER.ACTIVITY)
        end
    end 
end

function ActivityLayer:showMoldFragmentLayer(goodsData)
    if(self.rootLayer) then 
        local dropFragment = self.rootLayer:getChildByName("RuneMoldDropFragment")
        if dropFragment == nil then
            require("app.modules.runemold.RuneMoldDropFragment")
            local dropFragment = UI.RuneMoldDropFragment:create(goodsData)
            dropFragment:center(0)
            dropFragment:setName("RuneMoldDropFragment")
            self.rootLayer:addChild(dropFragment,UI_ZORDER.ACTIVITY)
        end
    end  
end

function ActivityLayer:showTownNotice(dataList, closeCallback)
    -- print("---------MainLayer:showTownNotice ", dataList)
    local townNotice = self:getChildByName("TownNotice")
    if townNotice == nil then
        require("app.ui.notice.TownNotice")
        local townNotice = UI.TownNotice:create(dataList, closeCallback)
        townNotice:center(0)
        townNotice:setName("TownNotice")
        self:addChild(townNotice, UI_ZORDER.NOTICE)
        townNotice:showNotice();
    end
end

function ActivityLayer:onShowGemConnectLayer(NPCSpriteID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        -- local synthesisLayer = self.rootLayer:getChildByName("SynthesisLayer")
        -- if synthesisLayer == nil then
            -- 处理隐藏掉其余控件
            -- Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            -- if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
            --     require("app.ui.equipGem.GemSynthesisLayer")
            --     local synthesisLayer = UI.GemSynthesisLayer:create(NPCSpriteID, GEM_LAYER_TYPE.SYNTHESIS)
            --     synthesisLayer:setName("SynthesisLayer")
            --     self.rootLayer:addChild(synthesisLayer, UI_ZORDER.ACTIVITY);
            -- end

            -- 
            
            mvc.openPanel("GemConnect", "GemConnect")
            
            GameManager:stopMoveHandler()
        -- end
    end
end

function ActivityLayer:onShowGemDecomposeLayer(NPCSpriteID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        -- local synthesisLayer = self.rootLayer:getChildByName("SynthesisLayer")
        -- if synthesisLayer == nil then
            mvc.openPanel("GemDecompose", "GemDecompose")
            GameManager:stopMoveHandler()
        -- end
    end
end


--宝石合成界面
function ActivityLayer:onShowSynthesisLayer(NPCSpriteID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        local synthesisLayer = self.rootLayer:getChildByName("SynthesisLayer")
        if synthesisLayer == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.equipGem.GemSynthesisLayer")
                local synthesisLayer = UI.GemSynthesisLayer:create(NPCSpriteID, GEM_LAYER_TYPE.SYNTHESIS)
                synthesisLayer:setName("SynthesisLayer")
                self.rootLayer:addChild(synthesisLayer, UI_ZORDER.ACTIVITY);
            end
            GameManager:stopMoveHandler()
        end
    end 
end

--宝石购买
function ActivityLayer:onShowGemBuyLayer(NPCSpriteID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        
        local uilayer = UI.UIManager.mMainUILayer

        if (GameManager:getIsInNewScene()) then 
            self:closeAllActivity()
            
            performWithDelay(uilayer, function()
                mvc.closePanel("MainCity", "MainCityFunctionChoice")
            end, 0.2)

            local gemBuyLayer = uilayer:getChildByName("GemBuyLayer")
            if gemBuyLayer == nil then
                -- 处理隐藏掉其余控件
                Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
                if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                    require("app.ui.equipGem.GemBuyLayer")
                    local gemBuyLayer = UI.GemBuyLayer:create(NPCSpriteID)
                    gemBuyLayer:setName("GemBuyLayer")
                    uilayer:addChild(gemBuyLayer)
                    
                end
                GameManager:stopMoveHandler()
            end
        else
            self:closeAllActivity()
            local gemBuyLayer = uilayer:getChildByName("GemBuyLayer")
            if gemBuyLayer == nil then
                -- 处理隐藏掉其余控件
                Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
                if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                    require("app.ui.equipGem.GemBuyLayer")
                    local gemBuyLayer = UI.GemBuyLayer:create(NPCSpriteID)
                    gemBuyLayer:setName("GemBuyLayer")
                    uilayer:addChild(gemBuyLayer)
                    
                end
                GameManager:stopMoveHandler()
            end
        end

        
        
    
        -- local gemBuyLayer = self.rootLayer:getChildByName("GemBuyLayer")
        -- if gemBuyLayer == nil then
        --     -- 处理隐藏掉其余控件
        --     Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        --     if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
        --         require("app.ui.equipGem.GemBuyLayer")
        --         local gemBuyLayer = UI.GemBuyLayer:create(NPCSpriteID)
        --         gemBuyLayer:setName("GemBuyLayer")
        --         self.rootLayer:addChild(gemBuyLayer, UI_ZORDER.ACTIVITY)
                
        --     end
        --     GameManager:stopMoveHandler()
        -- end
    end 
end

--宝石镶嵌界面
function ActivityLayer:onShowGemInlayLayer(NPCSpriteID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        local gemInalayLayer = self.rootLayer:getChildByName("GemInlayLayer")
        if gemInalayLayer == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.equipGem.GemInlayLayer")
                local gemInalayLayer = UI.GemInlayLayer:create(NPCSpriteID)
                gemInalayLayer:setName("GemInlayLayer")
                self.rootLayer:addChild(gemInalayLayer, UI_ZORDER.ACTIVITY);
            end
            GameManager:stopMoveHandler()
        end
    end 
end

--共用 奖励界面
function ActivityLayer:onShowCommonRewardLayer(goodsDataList, callback, titleStr, zorder, style, equipmentWasGet, openActType, buttonStr, isDisable)
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
                self.rootLayer:addChild(rewardLayer, zorder or UI_ZORDER.TIPS);
                rewardLayer:showAction(openActType or Game.RewardLayerOpenAction.Scale_Center)
            end
        end
    end 
end

--宝石转换界面
function ActivityLayer:onShowTransFormLayer(NPCSpriteID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        local synthesisLayer = self.rootLayer:getChildByName("SynthesisLayer")
        if synthesisLayer == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.equipGem.GemSynthesisLayer")
                local synthesisLayer = UI.GemSynthesisLayer:create(NPCSpriteID, GEM_LAYER_TYPE.TRANSFORM)
                synthesisLayer:setName("SynthesisLayer")
                self.rootLayer:addChild(synthesisLayer, UI_ZORDER.ACTIVITY);
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onBackTownTips(backTownType, callback)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        if (SceneManager:getInstance():isInDungeon() 
            or SceneManager:getInstance():isInDream()
            or SceneManager:getInstance():isWorldBossCave() 
            or SceneManager:getInstance():isGuildBoss()
            or SceneManager:getInstance():isGhostAbyss()
            or SceneManager:getInstance():isActCave()
        ) then
            if SceneManager:getInstance():isInPuzzle() then
                local tips = UI.Tips:createTips(UI.TEXT_111140,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
                tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
                    mvc.send(mvc.events.Puzzle_Send_Result_Message)
                end)
            else
                local tips = UI.Tips:createTips(UI.TEXT_111140,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
                tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
                    if( RoleBehaviorManager:backTownCheck("[Setting panel to back town]") ) then 
                        GameDataManager:getInstance():setGuildBossBackTownTimeOut(true)
                        GameManager:giveUpBackTown()
                        if(callback) then 
                            callback(true)
                        end
                    end 
                end)
            end
        elseif(SceneManager:getInstance():isInCave() 
            or SceneManager:getInstance():isInHero()
            or SceneManager:getInstance():isDesertEyesCave()
            or SceneManager:getInstance():isDistortedSpaceCave()
            or SceneManager:getInstance():isInInferno()
            or SceneManager:getInstance():isInEaster()
            or SceneManager:getInstance():isInVoidRift()
            or SceneManager:getInstance():isInTrialLand()
            or SceneManager:getInstance():isInViKing()
            or SceneManager:getInstance():isInEverWinter()
            or SceneManager:getInstance():isTitanRoad()
            or SceneManager:getInstance():isInTitanHero()
            or SceneManager:getInstance():isInCaveExploring()
            or SceneManager:getInstance():isDriedSpring() 
            or SceneManager:getInstance():isInExp()
            or SceneManager:getInstance():isChaosWormHole()
            or SceneManager:getInstance():isInWormhole() ) then
            require "app.ui.tips.SettingBackTownTips"
            local lostData = GameDataManager:getInstance():getLostData()

            local tips = UI.SettingBackTownTips:create()
            tips:init(lostData.rewardCoin, lostData.goodsArr, backTownType)
            tips:center()
            tips:callfunName(function()
                if( RoleBehaviorManager:backTownCheck("[Setting panel to back town]") ) then 
                    GameManager:giveUpBackTown()
                end 
            end)
            UI.UIManager:getRootNode():addChild(tips,UI_ZORDER.TIPS)
        end
    end 
end

function ActivityLayer:onShowGoldenMine(npcID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        if self.rootLayer:getChildByName("GoldenMineLayer") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require "app.ui.home.goldenMine.GoldenMineLayer"
                local goldenMineLayer = UI.GoldenMineLayer:create(npcID)
                goldenMineLayer:init()
                goldenMineLayer:centerLeft(0)
                goldenMineLayer:setName("GoldenMineLayer")
                self.rootLayer:addChild(goldenMineLayer, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onShowGoldenMineShowBoostPanel(consumeList,cb)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        if self.rootLayer:getChildByName("GoldenMineShowBoostPanel") == nil then
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require "app.ui.home.goldenMine.GoldenMineShowBoostPanel"
                local goldenMineShowBoostPanel = UI.GoldenMineShowBoostPanel:create(consumeList,cb)
                goldenMineShowBoostPanel:init()
                goldenMineShowBoostPanel:center()
                goldenMineShowBoostPanel:setName("GoldenMineShowBoostPanel")
                self.rootLayer:addChild(goldenMineShowBoostPanel, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onShowRuneFactory(npcID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        if self.rootLayer:getChildByName("RuneFactoryLayer") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require "app.ui.home.runeFactory.RuneFactoryLayer"
                local runeFactoryLayer = UI.RuneFactoryLayer:create(npcID)
                runeFactoryLayer:init()
                runeFactoryLayer:centerLeft(0)
                runeFactoryLayer:setName("RuneFactoryLayer")
                self.rootLayer:addChild(runeFactoryLayer, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onShowCycleTask(npcID, taskData)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        if self.rootLayer:getChildByName("CycleTaskLayer") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                -- reload_script_file("app.ui.cycleTaskLayer.CycleTaskLayer")
                require "app.ui.cycleTaskLayer.CycleTaskLayer"
                local cycleTaskLayer = UI.CycleTaskLayer:create(npcID, taskData)
                cycleTaskLayer:init()
                cycleTaskLayer:setName("CycleTaskLayer")
                self.rootLayer:addChild(cycleTaskLayer, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onUpgradeSkill(npcID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        if self.rootLayer:getChildByName("ChangeJobLayer") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                -- reload_script_file("app.ui.changeJobLayer.ChangeJobLayer")
                require "app.ui.changeJobLayer.ChangeJobLayer"
                local changeJobLayer = UI.ChangeJobLayer:create(npcID)
                changeJobLayer:init()
                changeJobLayer:setName("ChangeJobLayer")
                self.rootLayer:addChild(changeJobLayer, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onUpgradeSkillInfo(npcID, isToHideMainLayer, gobackWin)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        if(isToHideMainLayer) then
            self:closeAllActivity()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        end

        if self.rootLayer:getChildByName("ChangeSkillInfo") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                -- reload_script_file("app.ui.changeJobLayer.ChangeSkillInfo")
                require "app.ui.changeJobLayer.ChangeSkillInfo"
                local changeSkillInfo = UI.ChangeSkillInfo:create(npcID)
                changeSkillInfo:setGoBackWin(gobackWin)
                changeSkillInfo:init()
                changeSkillInfo:center()
                changeSkillInfo:setName("ChangeSkillInfo")
                self.rootLayer:addChild(changeSkillInfo, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onActivityRankDetail(npcID, isToHideMainLayer, gobackWin, rankReward)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        if(isToHideMainLayer) then
            self:closeAllActivity()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
        end

        if self.rootLayer:getChildByName("CaveActivityRankDetail") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                -- reload_script_file("app.ui.activity.caveActivity.CaveActivityRankDetail")
                require "app.ui.activity.caveActivity.CaveActivityRankDetail"
                local rankDetail = UI.CaveActivityRankDetail:create(npcID)
                rankDetail:setGoBackWin(gobackWin)
                rankDetail:init(rankReward)
                rankDetail:center()
                rankDetail:setName("CaveActivityRankDetail")
                self.rootLayer:addChild(rankDetail, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onActivityDreamChallenge(npcID, s3SourceFrom)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self.dreams3SourceFrom = s3SourceFrom

        if self.rootLayer:getChildByName("DreamSelectLayer") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if (self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require "app.ui.dream.DreamSelectLayer"
                local dreamSelectLayer = UI.DreamSelectLayer:create(npcID)
                dreamSelectLayer:init()
                dreamSelectLayer:center()
                dreamSelectLayer:setName("DreamSelectLayer")
                self.rootLayer:addChild(dreamSelectLayer, UI_ZORDER.ACTIVITY)
                dreamSelectLayer:openShow()
                
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Dream, 1, nil, nil, s3SourceFrom)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onShowGetDreamTask(npcID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        if self.rootLayer:getChildByName("DreamGetTaskLayer") == nil then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require "app.ui.dream.task.DreamGetTaskLayer"
                local dreamGetTaskLayer = UI.DreamGetTaskLayer:create(npcID)
                dreamGetTaskLayer:setName("DreamGetTaskLayer")
                dreamGetTaskLayer:init()
                dreamGetTaskLayer:center()
                self.rootLayer:addChild(dreamGetTaskLayer, UI_ZORDER.ACTIVITY)
                dreamGetTaskLayer:openShow()
            end
            GameManager:stopMoveHandler()
        end 
    end 
end

function ActivityLayer:onShowEquipConvert(npcID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        -- TODO 添加装备升级的界面处理
        if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        if self.rootLayer:getChildByName("EquipConvertLayer") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                -- reload_script_file("app.ui.EquipConvertLayer.EquipConvertLayer")
                require "app.ui.equipConvert.EquipConvertLayer"
                local EquipConvertLayer = UI.EquipConvertLayer:create(npcID)
                EquipConvertLayer:init()
                EquipConvertLayer:setName("EquipConvertLayer")
                self.rootLayer:addChild(EquipConvertLayer, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
    end 
end

function ActivityLayer:openDreamRankLayer(npcID, gobackWin)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        -- self:closeAllActivity()
        if self.rootLayer:getChildByName("DreamRankLayer") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.dream.rank.DreamRankLayer")
                local dreamRankLayer = UI.DreamRankLayer:create()
                dreamRankLayer:setGoBackWin(gobackWin)
                dreamRankLayer:init()
                dreamRankLayer:center(0)
                dreamRankLayer:setName("DreamRankLayer")
                self.rootLayer:addChild(dreamRankLayer, UI_ZORDER.ACTIVITY)
                dreamRankLayer:openShow()
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:openDreamShopLayer(npcID, gobackWin)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        -- self:closeAllActivity()
        if self.rootLayer:getChildByName("DreamRankLayer") == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.dream.shop.DreamShopLayer")
                local dreamShopLayer = UI.DreamShopLayer:create()
                dreamShopLayer:setGoBackWin(gobackWin)
                dreamShopLayer:init(npcID)
                dreamShopLayer:center(0)
                dreamShopLayer:setName("DreamShopLayer")
                self.rootLayer:addChild(dreamShopLayer, UI_ZORDER.ACTIVITY);
                dreamShopLayer:openShow()
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Dream, 2, nil, nil, self.dreams3SourceFrom)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

function ActivityLayer:onShowEquipRecast(npcID)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        if self.rootLayer:getChildByName("EquipRecastLayer") == nil then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require "app.ui.recastLayer.EquipRecastLayer"
                local layer = UI.EquipRecastLayer:create(npcID)
                layer:setName("EquipRecastLayer")
                self.rootLayer:addChild(layer, UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end 
end

 -- 显示超值礼包
 function ActivityLayer:onShowExtraGift()
     if(self.rootLayer) then 
         self:closeAllActivity()
         local ExtraGiftLayer = self.rootLayer:getChildByName("ExtraGiftLayer")
         if ExtraGiftLayer == nil then
             -- 处理隐藏掉其余控件
             Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
             if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                 require("app.ui.extraGift.ExtraGiftLayer")
                 local ExtraGiftLayer = UI.ExtraGiftLayer:create()
                 ExtraGiftLayer:center()
                 ExtraGiftLayer:setName("ExtraGiftLayer")
                 self.rootLayer:addChild(ExtraGiftLayer,UI_ZORDER.ACTIVITY)
             end
             GameManager:stopMoveHandler()
         end
     end
 end


-- 显示进阶礼包
function ActivityLayer:onShowAdvGift()
    if(self.rootLayer) then 
        self:closeAllActivity()
        local AdvGiftLayer = self.rootLayer:getChildByName("AdvGiftLayer")
        if AdvGiftLayer == nil then
            -- 处理隐藏掉其余控件
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require("app.ui.extraGift.AdvGiftLayer")
                local AdvGiftLayer = UI.AdvGiftLayer:create()
                AdvGiftLayer:center()
                AdvGiftLayer:setName("AdvGiftLayer")
                self.rootLayer:addChild(AdvGiftLayer,UI_ZORDER.ACTIVITY)
            end
            GameManager:stopMoveHandler()
        end
    end
end

-- function ActivityLayer:onShowSevenDayGoal()
--     if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
--         self:closeAllActivity()
--         if self.rootLayer:getChildByName("SevenDayGoalLayer") == nil then
--             Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
--             if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
--                 require "app.ui.sevenDayGoal.SevenDayGoalLayer"
--                 local layer = UI.SevenDayGoalLayer:create()
--                 layer:center()
--                 layer:setName("SevenDayGoalLayer")
--                 self.rootLayer:addChild(layer, UI_ZORDER.ACTIVITY)
--             end
--             GameManager:stopMoveHandler()
--         end
--     end
-- end


function ActivityLayer:onShowChatMainLayer()
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        self:closeAllActivity()
        if self.rootLayer:getChildByName("ChatMainLayer") == nil then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            local mainChatLayer = UI.ChatMainLayer:recycle()
            mainChatLayer:center()
            mainChatLayer:forceClear()
            self.rootLayer:addChild(mainChatLayer, UI_ZORDER.ACTIVITY)
            mainChatLayer:showByPosition()
        else
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            local mainChatLayer = self.rootLayer:getChildByName("ChatMainLayer")
            mainChatLayer:center()
            mainChatLayer:forceClear()
            mainChatLayer:showByPosition()
        end
        GameManager:stopMoveHandler()
    end
end

function ActivityLayer:onWorldChatByLottery(text)
    UI.ChatMainLayer:getInstance():showByPosition()
    UI.ChatMainLayer:getInstance():autoChangeTag(ChatChannelType.WORLD)
    UI.ChatMainLayer:getInstance():setDefaultText(text)
    Avalon.MessageCenter:notice(GameMessage.MC_CHAT_OPEN_MAIN_CHAT)
end


function ActivityLayer:onShowAnniversaryLotteryRewardView(data)
    mvc.openPanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryReward", data)
end

function ActivityLayer:onShowAnniversaryLotteryPreView()
    if MasterDataManager:getActivityDataArrForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw) then
        local anniversaryLotteryData = MasterDataManager:getActivityDataArrForType(PublicDefine.ActivityType.ActivityType_AnniversaryLuckyDraw)
        local isShow = cc.UserDefault:getInstance():getBoolForKey("annivesaryLotteryShow", false)
        if(anniversaryLotteryData and not isShow) then 
            mvc.openPanel("ActivityAnnivesaryLottery", "ActivityAnnivesaryLotteryPre", anniversaryLotteryData)
        end
    end
end

function ActivityLayer:removeBattleUIHandler()
     if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        local mainChatLayer = self.rootLayer:getChildByName("ChatMainLayer")
        if mainChatLayer then
            mainChatLayer:removeFromParent(false)
        end
    end
end

function ActivityLayer:openPetPVPEnd(data)
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then 
        require "app.ui.PetPVPEndLayer"
        local panel = UI.PetPVPEndLayer:create(data)
        panel:center()
        panel:setName("PetPVPEndLayer")
        self.rootLayer:addChild(panel,UI_ZORDER.ACTIVITY)
    end
end

function ActivityLayer:onShowBossDirect(npcID, npcData)
    -- 若在组队中，则阻止
    if TeamDataManager:hasTeam() then
        UI.ScrollBar:createByText(UI.TEXT_221502)
        return
    end
    if(self.rootLayer and not tolua.isnull(self.rootLayer)) then
        self:closeAllActivity()
        if self.rootLayer:getChildByName("BossDirectPanel") == nil then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
            if(self and not tolua.isnull(self) and self.rootLayer and not tolua.isnull(self.rootLayer)) then
                require "app.ui.shoplayer.BossDirectPanel"
                local bossDirectPanel = UI.BossDirectPanel:create(npcID, npcData:getId())
                bossDirectPanel:setName("BossDirectPanel")
                local isLock, text = bossDirectPanel:checkIsUnlock()
                if isLock then
                    bossDirectPanel:init()
                    bossDirectPanel:openShow()
                    bossDirectPanel:center()
                    self.rootLayer:addChild(bossDirectPanel, UI_ZORDER.ACTIVITY)
                    
                else
                    local LanguageManager = require "app.game.LanguageManager"
                    local languageManagerInstance = LanguageManager:getInstance()
                    bossDirectPanel:closeWin()
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
                    UI.ScrollBar:createByTextID(languageManagerInstance:getLocalString(tonumber(text)))
                end
            end
            GameManager:stopMoveHandler()
        end 
    end 
end
