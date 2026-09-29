--
-- Author: yueyingsong
-- Date: 2017-11-20 10:42:17
-- Using:内购商店主界面

require "app.ui.iapshop.IapShopDiamondLayer"
require "app.ui.iapshop.IapShopBoxLayer"
require "app.ui.iapshop.IapShopBoxDetails"
require "app.ui.iapshop.IapShopMonthCardLayer"
require "app.ui.common.Tab.SpineTabItem"
require("app.ui.common.CurrencyPanel")

local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require "app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")
local ProtobufUtil = require "utils.ProtobufUtil"
local LanguageManager = require("app.game.LanguageManager")

require("app.utils.ServerConfigUtil")
UI = UI or {}
local IapShopMainLayer = class("IapShopMainLayer", UI.CenterWin)
UI.IapShopMainLayer = IapShopMainLayer

local RES_LIST = {
    "ui_general_shopping.plist",
    "ui_town_guild_giftbox.plist",
}


-- 设计尺寸
local LAYOUT_DESIGN_WIDTH = 1136
local LAYOUT_DESIGN_HEIGHT = 640
-- 模块功能tab选择控件
local LAYOUT_TAB_LIST_SPACE = 0
local LAYOUT_TAB_LIST_WIDTH = 157
local LAYOUT_TAB_LIST_HEIGHT = 65
local SPINE_TAB_ITEM_BTM_SPACE = 15

local TAB_INDEX = {
    DIAMOND = 1,    -- 角色模块
    TASK = 2,    -- 任务模块
    SKILL = 3,   -- 技能模块
}

-- 动画名字 --
---------------------------------------
-- 关闭按钮
local MENU_CLOSE_SPINE_BG_NAME = "effect_ui_package_title_back_bg"
local MENU_CLOSE_SPINE_ICON_NAME = "effect_ui_package_title_back_icon"
-- 角色
local MENU_DIAMOND_SPINE_BG_NAME = "effect_ui_package_title_role_bg"
local MENU_DIAMOND_SPINE_ICON_NAME = "effect_ui_package_title_diamond_icon"
-- 任务
local MENU_GIFT_SPINE_BG_NAME = "effect_ui_package_title_task_bg"
local MENU_GIFT_SPINE_ICON_NAME = "effect_ui_package_title_chest_icon"
-- 技能
local MENU_GOLD_SPINE_BG_NAME = "effect_ui_package_title_skill_bg"
local MENU_GOLD_SPINE_ICON_NAME = "effect_ui_package_title_monthlycard_icon"


--节日
local MENU_FESTIVAL_SPINE_BG_NAME = "effect_ui_package_title_log_bg"
local MENU_FESTIVAL_SPINE_ICON_NAME = "effect_ui_package_title_festival_icon"
--限时
local MENU_LIMITTIME_SPINE_BG_NAME = "effect_ui_package_title_skill_bg"
local MENU_LIMITTIME_SPINE_ICON_NAME = "effect_ui_package_title_limitedtime_icon"
--幻化
local MENU_ILLUSION_SPINE_BG_NAME = "effect_ui_package_title_set_bg"
local MENU_ILLUSION_SPINE_ICON_NAME = "effect_ui_package_title_illusion_icon"

---------------------------------------
-- 动画名字 --

-- 黄金，钻石的图片
local SPRITE_GAMING_MOMEY   = "symbol_gaming_money.png"
local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"

local winSize = cc.Director:getInstance():getWinSize()

-- enum FirstChargeStat {
--      FirstChargeStat_None = 0;               //未充值
--      FirstChargeStat_Charged = 1;            //充值未领取
-- 	    FirstChargeStat_Rewarded = 2;           //已经领取
-- }

function IapShopMainLayer:ctor(isToHideMainLayer, autoOpenIdx, sourceType, isShowBox)
	IapShopMainLayer.super.ctor(self,UIType.MAIN_LAYER,RES_LIST,LAYOUT_DESIGN_WIDTH,LAYOUT_DESIGN_HEIGHT)
	self:setInterceptTouches(true);
	self:setTouchEnable(true)
	self:registerListener()
    self._views = {}
    self._detailView = nil
    self._curIdx = 1;
    self._sourceType = sourceType
    self._defaultIndex = defaultIndex
    self._isToHideMainLayer = isToHideMainLayer
    self._iapBoxFunctionTab = nil
    self._firstRefresh = true
    self._purchaseData =  Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.PURCHASE, GameDataManager:getInstance():getSaveUserKey())
    if checkint(autoOpenIdx) >= 1 then
        self._curIdx = checkint(autoOpenIdx)
        -- add by zp 这里想在评审服可以跳转到宝箱页面
        -- if ServerConfigUtil:isInReview() then
        --     self._curIdx = 1;
        -- end
    end
    if(isToHideMainLayer == false) then 
        self:setNoticeShowMainUI(false)
    end

    Avalon.MessageCenter:notice(GameMessage.MC_IPASHOP_OPEN)
    
    self.isShowBox = isShowBox
    -- require "app.datas.RoleDataManager"
    -- local master = RoleDataManager:getMaster()
    -- master:setNickName("")
end

function IapShopMainLayer:dtor()
    self:unRegisterListener()	
    Avalon.MessageCenter:notice(GameMessage.MC_IPASHOP_CLOSE)
    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_Close,0,0,0,0)

    -- reload_script_file("app.ui.iapshop.IapShopDiamondItem")
    -- reload_script_file("app.ui.iapshop.IapShopMonthCardLayer")
end

function IapShopMainLayer:createContent()
    if self._firstRefresh then
        self._firstRefresh = false

        local haveFestival,haveLimitTime,haveIllusion = false,false,false
        for i,v in ipairs(self._data) do
            if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseFestival then
                haveFestival = true
            elseif v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseLimitTime then
                haveLimitTime = true
            elseif v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseIllusion then
                haveIllusion = true
            end
        end

        -- 创建功能便签
        local functionTabList = UI.TabList:create()
        functionTabList:init(
            LAYOUT_TAB_LIST_SPACE
        )
        functionTabList:leftUp(110, -6)
        functionTabList:setTouchEnable(true)
        functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex)
            printInfo(string.format("IapShopMainLayer onInitView: select function tab %d.", tabIndex))
            self:choiceTabIndex(tabIndex)
            -- if (tabIndex == 2) then
            --     SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_PageOp,
            --     0,
            --     PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Open,
            --     PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_Box,0)
            -- elseif (tabIndex == 3) then
            --     SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_PageOp,
            --     0,
            --     PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Open,
            --     PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_MonthCard,0)
            -- end
            
        end)
        functionTabList:setDefaultIndex(nil)
        self.bg:addChild(functionTabList, 15)
        self._functionTabList = functionTabList
        local tbIndex = 0

        if haveFestival then
            tbIndex = tbIndex + 1
            self._festivalIndex = tbIndex
            local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GIFT, SPINE_TAB_ITEM_BTM_SPACE)
            functionTab.onDisableClick = handler(self, self.tagDisableClick)
            functionTab:init(
                MENU_FESTIVAL_SPINE_BG_NAME, 
                MENU_FESTIVAL_SPINE_ICON_NAME,
                UI.TEXT_223702,
                UI.FONT_BOLD
            )
            functionTabList:addToTab(functionTab, self._festivalIndex)
            functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)
            functionTab:onUpdateView()
        end
        
        if haveLimitTime then
            tbIndex = tbIndex + 1
            self._limitTimeIndex = tbIndex
            local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GIFT, SPINE_TAB_ITEM_BTM_SPACE)
            functionTab.onDisableClick = handler(self, self.tagDisableClick)
            functionTab:init(
                MENU_LIMITTIME_SPINE_BG_NAME, 
                MENU_LIMITTIME_SPINE_ICON_NAME,
                UI.TEXT_223703,
                UI.FONT_BOLD
            )
            functionTabList:addToTab(functionTab, self._limitTimeIndex)
            functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)
            functionTab:onUpdateView()
        end

        if haveIllusion then
            tbIndex = tbIndex + 1
            self._illusionIndex = tbIndex
            local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GIFT, SPINE_TAB_ITEM_BTM_SPACE)
            functionTab.onDisableClick = handler(self, self.tagDisableClick)
            functionTab:init(
                MENU_ILLUSION_SPINE_BG_NAME, 
                MENU_ILLUSION_SPINE_ICON_NAME,
                UI.TEXT_223704,
                UI.FONT_BOLD
            )
            functionTabList:addToTab(functionTab, self._illusionIndex)
            functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)
            functionTab:onUpdateView()
        end

        -- 钻石
        tbIndex = tbIndex + 1
        self.diamondIndex = tbIndex
        local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_DIAMOND, SPINE_TAB_ITEM_BTM_SPACE)
        functionTab.onDisableClick = handler(self, self.tagDisableClick)
        functionTab:init(
            MENU_DIAMOND_SPINE_BG_NAME, 
            MENU_DIAMOND_SPINE_ICON_NAME,
            LanguageManager:getInstance():getLocalString(1111447),
            UI.FONT_BOLD
        )
        functionTabList:addToTab(functionTab, self.diamondIndex)
        functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)
        functionTab:onUpdateView()
        
        -- 宝箱
        tbIndex = tbIndex + 1
        self._boxIndex = tbIndex
        local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GIFT, SPINE_TAB_ITEM_BTM_SPACE)
        functionTab.onDisableClick = handler(self, self.tagDisableClick)
        functionTab:init(
            MENU_GIFT_SPINE_BG_NAME, 
            MENU_GIFT_SPINE_ICON_NAME,
            LanguageManager:getInstance():getLocalString(1111448),
            UI.FONT_BOLD
        )
        functionTabList:addToTab(functionTab, self._boxIndex)
        functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 3, LAYOUT_TAB_LIST_HEIGHT)
        self._iapBoxFunctionTab = functionTab
        functionTab:onUpdateView()

        
        -- 月卡
        -- if not ServerConfigUtil:isInReview() then
        --     local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GOLD, SPINE_TAB_ITEM_BTM_SPACE)
        --     functionTab.onDisableClick = handler(self, self.tagDisableClick)
        --     functionTab:init(
        --         MENU_GOLD_SPINE_BG_NAME,
        --         MENU_GOLD_SPINE_ICON_NAME,
        --         LanguageManager:getInstance():getLocalString(1111449),
        --         UI.FONT_BOLD
        --     )
        --     functionTabList:addToTab(functionTab, TAB_INDEX.SKILL)
        --     functionTab:setSize(LAYOUT_TAB_LIST_WIDTH - 6, LAYOUT_TAB_LIST_HEIGHT)
        --     self.monthCardTab = functionTab
        --     self.monthCardTab:setVisible(false)
        -- end

        -- 选择默认标签   
        if self._defaultIndex  then
            functionTabList:setDefaultIndex(self._defaultIndex)
        end
        
        if self.isShowBox then
            self._curIdx = self._boxIndex
            functionTabList:setDefaultIndex(self._boxIndex)
            self:choiceTabIndex(self._boxIndex)
            self.isShowBox = false
        else
            functionTabList:setDefaultIndex(self._curIdx)
            self:choiceTabIndex(self._curIdx)
        end
        

        -- 刷新宝箱红点
        self:refreshIapBoxRedPoint()
        -- 首冲
        self:initFirstRechagerButton()

        -- 月卡
        -- self:refreshMonthCardRedPoint()

        functionTabList:onUpdateView()
    end
end

function IapShopMainLayer:onInitView()
    local bg = self:createBg()
    bg:center()
    self:addChild(bg)    
    self.bg = bg
    -- local scaleX = winSize.width / LAYOUT_DESIGN_WIDTH
    -- local scaleY = winSize.height / (LAYOUT_DESIGN_HEIGHT + 60)
    -- local scale = scaleX > scaleY and scaleY or scaleX
    -- if (scale > 1.0) then scale = 1.0 end
    -- bg:setScale(scale)

    -- 创建关闭按钮
    local closeButton = UI.SpineTabItem:create()
    closeButton:init(
        MENU_CLOSE_SPINE_BG_NAME, 
        MENU_CLOSE_SPINE_ICON_NAME,
        nil,
        nil
    )
    closeButton:setSize(120, 40)
    closeButton:addEventListener(UIEvent.TAB_CLICK, self, self.closeWin)
    closeButton:rightUp(95, 3)
    closeButton:onActive()
    closeButton:setSingle(true)
    bg:addChild(closeButton, 15)


    -- local haveFestival,haveLimitTime,haveIllusion = false,false,false
    -- for i,v in ipairs(self._data) do
	-- 	if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseFestival then
    --         haveFestival = true
    --     elseif v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseLimitTime then
    --         haveLimitTime = true
    --     elseif v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseIllusion then
    --         haveIllusion = true
    --     end
    -- end

    -- -- 创建功能便签
    -- local functionTabList = UI.TabList:create()
    -- functionTabList:init(
    --     LAYOUT_TAB_LIST_SPACE
    -- )
    -- functionTabList:leftUp(110, -6)
    -- functionTabList:setTouchEnable(true)
    -- functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex)
    --     printInfo(string.format("IapShopMainLayer onInitView: select function tab %d.", tabIndex))
    --     self:choiceTabIndex(tabIndex)
    --     -- if (tabIndex == 2) then
    --     --     SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_PageOp,
    --     --     0,
    --     --     PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Open,
    --     --     PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_Box,0)
    --     -- elseif (tabIndex == 3) then
    --     --     SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_PageOp,
    --     --     0,
    --     --     PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Open,
    --     --     PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_MonthCard,0)
    --     -- end
        
    -- end)
    -- functionTabList:setDefaultIndex(nil)
    -- bg:addChild(functionTabList, 15)
    -- self._functionTabList = functionTabList
    -- local tbIndex = 0

    -- tbIndex = tbIndex + 1
    -- self._festivalIndex = tbIndex
    -- tbIndex = tbIndex + 1
    -- self._limitTimeIndex = tbIndex
    -- tbIndex = tbIndex + 1
    -- self._illusionIndex = tbIndex
    -- --haveFestival,haveLimitTime,haveIllusion
    -- if haveFestival then

    -- end
    -- local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GIFT, SPINE_TAB_ITEM_BTM_SPACE)
    -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- functionTab:init(
    --     MENU_DIAMOND_SPINE_BG_NAME, 
    --     MENU_DIAMOND_SPINE_ICON_NAME,
    --     UI.TEXT_223702,
    --     UI.FONT_BOLD
    -- )
    -- functionTabList:addToTab(functionTab, TAB_INDEX.DIAMOND)
    -- functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)

    -- local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GIFT, SPINE_TAB_ITEM_BTM_SPACE)
    -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- functionTab:init(
    --     MENU_DIAMOND_SPINE_BG_NAME, 
    --     MENU_DIAMOND_SPINE_ICON_NAME,
    --     UI.TEXT_223703,
    --     UI.FONT_BOLD
    -- )
    -- functionTabList:addToTab(functionTab, TAB_INDEX.DIAMOND)
    -- functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)

    -- local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GIFT, SPINE_TAB_ITEM_BTM_SPACE)
    -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- functionTab:init(
    --     MENU_DIAMOND_SPINE_BG_NAME, 
    --     MENU_DIAMOND_SPINE_ICON_NAME,
    --     UI.TEXT_223704,
    --     UI.FONT_BOLD
    -- )
    -- functionTabList:addToTab(functionTab, TAB_INDEX.DIAMOND)
    -- functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)

    -- -- 钻石
    -- local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_DIAMOND, SPINE_TAB_ITEM_BTM_SPACE)
    -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- functionTab:init(
    --     MENU_DIAMOND_SPINE_BG_NAME, 
    --     MENU_DIAMOND_SPINE_ICON_NAME,
    --     LanguageManager:getInstance():getLocalString(1111447),
    --     UI.FONT_BOLD
    -- )
    -- functionTabList:addToTab(functionTab, TAB_INDEX.DIAMOND)
    -- functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)
    -- tbIndex = tbIndex + 1
    -- self.diamondIndex = tbIndex
    
    -- -- 宝箱
    -- local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GIFT, SPINE_TAB_ITEM_BTM_SPACE)
    -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- functionTab:init(
    --     MENU_GIFT_SPINE_BG_NAME, 
    --     MENU_GIFT_SPINE_ICON_NAME,
    --     LanguageManager:getInstance():getLocalString(1111448),
    --     UI.FONT_BOLD
    -- )
    -- functionTabList:addToTab(functionTab, TAB_INDEX.TASK)
    -- functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 3, LAYOUT_TAB_LIST_HEIGHT)
    -- tbIndex = tbIndex + 1
    -- self._boxIndex = tbIndex
    -- self._iapBoxFunctionTab = functionTab
    -- -- 月卡
    -- -- if not ServerConfigUtil:isInReview() then
    -- --     local functionTab = UI.SpineTabItem:create(UIType.IAP_SHOP_FUNCTION_TAB_ITEM_GOLD, SPINE_TAB_ITEM_BTM_SPACE)
    -- --     functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- --     functionTab:init(
    -- --         MENU_GOLD_SPINE_BG_NAME,
    -- --         MENU_GOLD_SPINE_ICON_NAME,
    -- --         LanguageManager:getInstance():getLocalString(1111449),
    -- --         UI.FONT_BOLD
    -- --     )
    -- --     functionTabList:addToTab(functionTab, TAB_INDEX.SKILL)
    -- --     functionTab:setSize(LAYOUT_TAB_LIST_WIDTH - 6, LAYOUT_TAB_LIST_HEIGHT)
    -- --     self.monthCardTab = functionTab
    -- --     self.monthCardTab:setVisible(false)
    -- -- end

    -- 货币组件
    self._currencyPanel = UI.CurrencyPanel:create(UI.FONT_COLOR_170_170_170)
    self._currencyPanel:leftBottom(688, 536 - 14.5 --[[货币组件空白高度大小]])
    self._currencyPanel:setShowShopButton(false)
    bg:addChild(self._currencyPanel, 100)

    -- 分割线
    local splitter = UI.Image9:create()
    splitter:init("ui_scale9image_banner_line_dark2.png", CCRectMake(2,0,1,1), cc.size(911, 2))
    splitter:leftBottom(114, 528)
    bg:addChild(splitter, 100)

    -- -- 选择默认标签   
    -- if self._defaultIndex  then
    --     functionTabList:setDefaultIndex(self._defaultIndex)
    -- end
    
    -- functionTabList:setDefaultIndex(self._curIdx)
    -- self:choiceTabIndex(self._curIdx)

    -- -- 刷新宝箱红点
    -- self:refreshIapBoxRedPoint()
    -- -- 首冲
    -- self:initFirstRechagerButton()

    -- -- 月卡
    -- -- self:refreshMonthCardRedPoint()

    self:open();
end

function IapShopMainLayer:tagDisableClick(targert)
    UI.ScrollBar:createByText(UI.TEXT_1170901)
end

function IapShopMainLayer:createBg()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()

    local board = UI.Image:create()
    board:init("ui_shopping_banner_background.png")
    board:leftBottom(77, 16)
    contentLayout:addChild(board, 1)
    board:setName("BOARD")

    local upLine = UI.Image:create()
    upLine:init("ui_4package_box_up.png")
    upLine:centerUp(-42)
    contentLayout:addChild(upLine, 12)

    local bottomLine = UI.Image:create()
    bottomLine:init("ui_4package_box_down.png")
    bottomLine:leftBottom(15, 0)
    contentLayout:addChild(bottomLine, 12)

    local leftLine = UI.Image:create()
    leftLine:init("ui_shopping_box_left.png")
    leftLine:leftBottom(14, 18)
    contentLayout:addChild(leftLine, 11)

    local rightLine = UI.Image:create()
    rightLine:init("ui_shopping_box_right.png")
    rightLine:rightBottom(10, 18)
    contentLayout:addChild(rightLine, 11)
    return contentLayout
end

-- function IapShopMainLayer:refreshMonthCardRedPoint()
--     if tolua.isnull(self.monthCardTab) then
--         return
--     end
--     if (UI.IapShopMonthCardLayer.haveMonthCardReward() or UI.IapShopMonthCardLayer.haveLifeTimeMembershipReward()) then
--         self.monthCardTab:showRedPoint()
--     else
--         self.monthCardTab:removeRedPoint()
--     end
-- end

function IapShopMainLayer:initFirstRechagerButton(data)
    if ServerConfigUtil:isInReview() then
        return
    end
    local buttonSize = 100
    self.buyStatus = GameDataManager:getInstance():getMaster():getFirstChargeStat()
    printInfo("IapShopMainLayer:initFirstRechagerButton, self.buyStatus = ", self.buyStatus)
    -- test start
    -- self.buyStatus = 1
    -- test end
    if self.buyStatus ~= nil and self.buyStatus > 0 then
        if self.firstRechargeButton then
            self.firstRechargeButton:removeFromParent()
        end
    else
        if self.firstRechargeButton == nil then
            local firstRechargeButton = UI.Button:create()
            firstRechargeButton:init();
            firstRechargeButton:setSize(buttonSize, buttonSize);
            firstRechargeButton:rightBottom(25, 25)
            self.bg:addChild(firstRechargeButton, 1000)
            self.firstRechargeButton = firstRechargeButton
            self.firstRechargeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                local titleStr = UI.TEXT_1212002
                if self.buyStatus == ProtobufUtil:enum_id("PurchaseSystem.FirstChargeStat", "FirstChargeStat_Charged") then
                    --检查背包是否已满
                    if self:checkBagIsFull() then
                        UI.ScrollBar:createByText(UI.TEXT_1212011)
                        return
                    end

                    if (RoleBehaviorManager:firstRechargeCheck()) then 
                        self.firstRechargeIcon:setAnimation(0, "receive", false)
                        Net.Helper:sendMessage(NetMessageType.RECHARGE_REQUEST_FIRST_RECHARGE);
                    else
                        UI.ScrollBar:createByText(UI.TEXT_1212010)
                    end
                else
                    local rewardConfig = ConfigManager:getFirstChargeReward();
                    local rewardStrs = string.split(rewardConfig, ";")
                    local goodsDataList = {}
                    for k, v in pairs(rewardStrs) do
                        local item = string.split(v, ",")
                        if item[2] then
                            local gemstoneData =  GoodsDataManager:createLocalGoodsData(tonumber(item[1]))
                            if(gemstoneData) then
                                gemstoneData:setNum(tonumber(item[2]))
                                table.insert(goodsDataList, gemstoneData)
                            end
                        else
                            printError("getFirstChargeReward do not config num for item :" .. item[1])
                        end
                    end
                    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 7, nil, nil, self._sourceType)
                    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_FirstPurchase,0,0,0,0)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, goodsDataList, nil, titleStr, UI_ZORDER.TOP_ACTIVITY)
                end
            end)

            local firstRechargeIcon = Avalon.Animation:create("effect_ui_general_shopping_purchased_gift.json", "effect_ui_general_shopping_purchased_gift.atlas", 1.0);
            firstRechargeIcon:setPosition(cc.p(buttonSize / 2, buttonSize / 2))
            self.firstRechargeButton:addChild(firstRechargeIcon, 1000)
            self.firstRechargeIcon = firstRechargeIcon

            local label = UI.Text:create();
            label:init("", UI.FONT_STANDARD, 14, UI.FONT_COLOR_255_243_93)
            label:setOutline(UI.FONT_COLOR_125_21_19, 1)
            label:center(2, 26)
            firstRechargeButton:addChild(label, 1000)
            self.firstRechargeLabel = label
        end

        local animationName = "idle"
        local str = UI.TEXT_1212000
        if self.buyStatus then
            if self.buyStatus == ProtobufUtil:enum_id("PurchaseSystem.FirstChargeStat", "FirstChargeStat_Charged") then
                animationName = "unreceived"
                str = UI.TEXT_1212001
            end
        else
            printError("not found buyStatus in hero data")
        end
        self.firstRechargeIcon:setAnimation(0, animationName, true)
        self.firstRechargeLabel:setText(str)
    end

    -- 领取到了奖励，展示实际获得的奖励
    if data ~= nil then
        if data.result == ProtobufUtil:enum_id("PurchaseSystem.ReqFirstChargeRewardResult", "ReqFirstChargeRewardResult_Succeed") then
            local goodsDataList = {}
            for k, v in pairs(data.rewards) do
                local gemstoneData =  GoodsDataManager:createLocalGoodsData(v.id)
                if(gemstoneData) then
                    gemstoneData:setNum(v.num)
                    table.insert(goodsDataList, gemstoneData)
                end
            end
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, goodsDataList)
        else
            GameErrorManager:showError(data.result)      
            printError("show first recharge result error :" .. data.result)
        end
    end

end

function IapShopMainLayer:checkBagIsFull()
    local full = false
    local goodsArr = {}
    local rewardConfig = ConfigManager:getFirstChargeReward();
    local rewardStrs = string.split(rewardConfig, ";")
    local goodsDataList = {}
    for k, v in pairs(rewardStrs) do
        local item = string.split(v, ",")
        if item[2] then
            local data = {}
            data.goodsID = tonumber(item[1])
            data.num = tonumber(item[2])
            data.isGolden = true
            table.insert(goodsArr, data)
        else
            printError("getFirstChargeReward do not config num for item :" .. item[1])
        end
    end

    -- 判断背包是否满了
    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) == true then 
        full = true
    end
    return full
end

-- 点击了右边选项卡
function IapShopMainLayer:choiceTabIndex(tabIndex)
    printInfo("IapShopMainLayer:choiceTabIndex, tabIndex = ", tabIndex)
	if not self._views[tabIndex] then
        local panel = nil;
        if (tabIndex == self.diamondIndex) then
            -- 钻石
            panel = UI.IapShopDiamondLayer:create(self._sourceType)
            panel:init()
        elseif (tabIndex == self._boxIndex 
        or tabIndex == self._festivalIndex
        or tabIndex == self._limitTimeIndex
        or tabIndex == self._illusionIndex) then
            local lType = nil
            if tabIndex == self._boxIndex then
                lType = PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE
            elseif tabIndex == self._festivalIndex then
                lType = PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseFestival
            elseif tabIndex == self._limitTimeIndex then
                lType = PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseLimitTime
            elseif tabIndex == self._illusionIndex then
                lType = PublicDefine.PURCHASE_PRODUCT_TYPE.PurchaseIllusion
            end
            -- 宝箱
            panel = UI.IapShopBoxLayer:create(self._sourceType,lType)
            panel:init()
            SdkManager:getInstance():removeNewIapBoxMark()
            Avalon.MessageCenter:notice(GameMessage.MC_REFRESH_IAPSHOP_NEW_FLAG)
            self:refreshIapBoxRedPoint()
        -- elseif (tabIndex == 3) then
        --     -- 月卡
        --     panel = UI.IapShopMonthCardLayer:create(self._sourceType)
        --     panel:init();
        -- elseif (tabIndex == 4) then
        else
            assert(false)
        end
        if (panel) then 
            self.bg:addChild(panel, 100)
        end
        self._views[tabIndex] = panel
    end
    
    -- self._currencyPanel:setVisible(tabIndex ~= 3)
    
    for i, view in pairs( self._views ) do
        if i ==  tabIndex then
            view:centerBottom(0)
            view:onUpdateView(self._data)
            view:show()
        else
            view:leftBottom(-winSize.width, -winSize.height)
            view:hide()
        end
    end
    self._curIdx = tabIndex
end

function IapShopMainLayer:onUpdateView()
    local myChannel = SdkBox:getInstance():getVersionChannel()
    printInfo("IapShopMainLayer:onUpdateView, 获取商品列表", myChannel)
    Net.NetPurchaseSystem:reqProducts(nil,nil,myChannel)
end

function IapShopMainLayer:refreshProducts(data)
    local isSingle = data.isSingle

    local datas = SdkManager:getInstance():getShowIapDatas()
    
    if not isSingle then
        self._data = clone(datas)
        -- if self._data then
        --     for i, v in ipairs(self._data) do
        --         if (v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_MONTH_CARD or
        --             v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.LifeTimeMembership or 
        --             v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.MonthlySubscription) 
        --             and not ServerConfigUtil:isInReview() 
        --         then
        --             self.monthCardTab:setVisible(true)
        --             break
        --         end
        --     end
        -- end
        -- 先筛选一次 如果为0 需要删除掉
        for i= table.nums(self._data),1,-1 do
            if checkint(self._data[i].productID) <=0 then
                table.remove( self._data, i )
            end
        end
        table.sort(self._data, function (a,b)
            -- 如果排序ID一样, 用其他方法排序
            if (a.sortId == b.sortId) then
                -- 排序ID一样, 有hot标签的在前面, 都有或者都没有的时候用其他方法排序
                if (a.isHot and not b.isHot) then
                    return true
                elseif (not a.isHot and b.isHot) then
                    return false
                end

                -- 排序ID一样, hot标签一样, 用价格排序
                if (a.price < b.price) then
                    return true
                elseif (a.price > b.price) then
                    return false
                else -- 价钱相等用productID排序
                    return a.productID > b.productID
                end
            end

            -- 默认用排序标签排序
            return a.sortId > b.sortId
        end )
        self:createContent()
        self:refreshWebLaunguageCallback({})        
        -- SdkManager:getInstance():setIapDatas(datas)

        

        local curTime = GameManager:getNormalServerTime()
        -- 删除已经下架的 和已经售完 并且标示了隐藏的
        local size = table.nums(self._data)
        for i= size,1, -1 do
            local item = self._data[i]
            -- 时间到了下架的
            if (item.endTimeSec > 0 and item.endTimeSec < curTime) then
                print("从本地删除")
                table.remove(self._data,i)
            end
            
        end
        
        local keyList = {}
        for i,v in ipairs(self._data) do
            table.insert( keyList, v.nameID )
            table.insert( keyList, v.desID )
        end

        local lans = SdkManager:getInstance():getProductsLan()
        if lans and table.nums(lans) > 0 then
            local hasOneUpdate = false
            for i,v in ipairs(self._data) do
                local findName = false
                local findDesc = false
                for idx,lan in pairs(lans) do
                    if v.nameID == idx then
                        findName = true;
                    end
                    if v.desID == idx then
                        findDesc = true;
                    end
                    if findDesc and findName then
                        break;
                    end
                end
                if not findDesc or not findName then
                    hasOneUpdate = true ;
                    break;
                end
            end
            if hasOneUpdate then
                SdkManager:getInstance():loadProductsLan( keyList, handler(self, self.refreshWebLaunguageCallback))
            else
                self:refreshWebLaunguageCallback(lans)
            end
            
        else
            -- dump(keyList)
            -- 获取苹果商店的信息
            SdkManager:getInstance():loadProductsLan(keyList, handler(self, self.refreshWebLaunguageCallback))
        end
       
    end
    
 
end

function IapShopMainLayer:refreshWebLaunguageCallback(webLaunguageList)
    if not self._data  then
        return
    end

    
    local infos = SdkManager:getInstance():getProducts()
    local myChannel = SdkBox:getInstance():getVersionChannel()
    -- local iaps = {}
    printInfo("IapShopMainLayer:refreshWebLaunguageCallback, myChannel",myChannel)

    for i,v in ipairs(self._data) do
        v.name = ""
        v.desc = ""
        v.iapId = ""
        for idx,lan in pairs(webLaunguageList) do
            if v.nameID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.name = str
            end
            if v.desID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.desc = str
            end
        end
        for i,idAndChannel in ipairs(v.IAPList) do
            if checkint(idAndChannel.channelID) == myChannel then
                -- table.insert( iaps, idAndChannel.iapId)  

                v.iapId = idAndChannel.iapId
                break;      
            end
        end
        -- dump(v.IAPList)
        
    end
    -- self._loading:setVisible(true)
    UI.WaitingLayer:showWaiting(true, nil, 0)
    -- print("SdkBox:getInstance():getVersionChannel()",SdkBox:getInstance():getVersionChannel())
    -- 目前暂时只有global包需要本地化显示货币单位
    -- if not infos and (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) and device.platform == "ios" then 
        
        -- SdkManager:getInstance():loadProducts(iaps,handler(self,self.onGetLocalization))
    -- else
        self:onGetLocalization()
    -- end
end

function IapShopMainLayer:onGetLocalization()
    
    for i, d in ipairs( self._data ) do
		-- 默认货币符号
		d.symbol = self:getCurrencySymbol()
	end
    
    self._views[self._curIdx]:onUpdateView(self._data)
    -- self._loading:setVisible(false)
    UI.WaitingLayer:hideWaiting()
end

-- 获取货币符号
function IapShopMainLayer:getCurrencySymbol()
    local symbol = "￥"
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        symbol = "$"
    end
	return symbol
end


function IapShopMainLayer:getOrder(data,count)
    printInfo("IapShopMainLayer:getOrder")
    if data.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Diamond then
        if not Avalon.MathUtil:checkDiamonEnough(count * data.price, GameDataManager:getInstance():getDiamond()) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170045))
            return;
        end
        
    end
    
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        if data.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
            printError("can not get order of box in other scene")
            return
        end
    end
    SdkManager:getInstance():getOrder(data,count,self._curIdx)
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 5, data.productID, nil, self._sourceType)
    -- if data.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
    --     SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_PageOp,
    --     data.productID,
    --     PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Buy,
    --     PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_Box,0)
    -- elseif data.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_MONTH_CARD then
    --     SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_PageOp,
    --     data.productID,
    --     PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Buy,
    --     PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_MonthCard,0)
    -- end
    
end

function IapShopMainLayer:onGetOrderShowLoading(data )
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        UI.WaitingLayer:showWaiting(true, nil, 0)
    else
        UI.WaitingLayer:showWaiting(true, nil, 0, 15)
    end
    
end

function IapShopMainLayer:onPayFail()
    -- self._loading:setVisible(false)
    UI.WaitingLayer:hideWaiting()
end

function IapShopMainLayer:onPaySucc()
    
    -- self._loading:setVisible(false)
    UI.WaitingLayer:hideWaiting()
end

function IapShopMainLayer:onGetOrderError(data)
    -- self._loading:setVisible(false)
    UI.WaitingLayer:hideWaiting()
end

function IapShopMainLayer:onPurchaseResult(data)
    local ProtobufUtil = require "utils.ProtobufUtil"
    -- OrderStat_New = 1;//新订单
    -- OrderStat_Sending = 2;//正在发货
    -- OrderStat_SendedSuc = 3;  //成功发货
    -- OrderStat_OutTimeSendedSuc= 4;  //超时成功发货
    -- OrderStat_SendFailed = 5;  //发货失败
    -- OrderStat_SendByMail = 6; //发送邮件
    local allDatas = SdkManager:getInstance():getIapDatas() or {}
    if(data.result == ProtobufUtil:enum_id("PurchaseSystem.OrderStat", "OrderStat_SendedSuc")) then 
        for i,v in ipairs(allDatas) do
            if v.productID == data.productID then
                -- print("找到了")
                -- 说明有总数限购,需要去请求一次
                if v.saleNum > 0 then  
                    local myChannel = SdkBox:getInstance():getVersionChannel()
                    Net.NetPurchaseSystem:reqProducts({v.productID},true,myChannel)
                    -- print("有总数限制的商品购买成功之后,再去服务器请求一次,刷新显示")
                end 
                break        
            end
        end
    end
end

-- 倒计时结束 刷新界面
function IapShopMainLayer:onCountdownOver(productID)
    for i,v in ipairs(self._data) do
        if v.productID == productID then
            table.remove( self._data, i )
            self._views[self._curIdx]:onUpdateView(self._data)
            break
        end
    end
end

function IapShopMainLayer:onShowDetails(data,sender)
    if not tolua.isnull(self._detailView) then
        self._detailView:removeSelf()
    end
    self._detailView = UI.IapShopBoxDetails:create()
    self._detailView:init()
    self._detailView:center()
    self._detailView:refreshData(data)

    local point = sender:convertToWorldSpace(sender:getAnchorPoint())
    
    local pointSelfCenter = self:convertToWorldSpace(cc.p(LAYOUT_DESIGN_WIDTH/2,LAYOUT_DESIGN_HEIGHT/2))
    local viewSizeW,viewSizeH = self._detailView:getSize()
    
    local point1 = self:convertToNodeSpace(cc.p(point.x - 45, pointSelfCenter.y - viewSizeH/2))
    self._detailView:leftBottom(point1.x,point1.y )
    self.bg:addChild(self._detailView, 1001)

    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_IapShop, 4, data.productID, nil, self._sourceType)
    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_PageOp,
    --     data.productID,
    --     PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Detail,
    --     PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_Box,0)
end

function IapShopMainLayer:onCloseDetails()
    if not tolua.isnull(self._detailView) then
        self._detailView:removeSelf()
    end
end
function IapShopMainLayer:refreshIapBoxRedPoint()
    print("是否有新宝箱",SdkManager:getInstance():haveNewIapBox())
    -- 显示红点
    if SdkManager:getInstance():haveNewIapBox() then
        if not tolua.isnull(self._iapBoxFunctionTab) then
            self._iapBoxFunctionTab:showRedPoint()
        end
    else
        if not tolua.isnull(self._iapBoxFunctionTab) then
            self._iapBoxFunctionTab:removeRedPoint()
        end
    end
end

function IapShopMainLayer:registerListener()
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
    Avalon.MessageCenter:bind(GameMessage.MC_GET_ORDER_SHOWLOADING, self,self.onGetOrderShowLoading)
    Avalon.MessageCenter:bind(GameMessage.MC_GET_ORDER_REQ, self,self.getOrder)
    Avalon.MessageCenter:bind(GameMessage.MC_REQ_PURCHASE_ERROR, self,self.onGetOrderError)
    

    Avalon.MessageCenter:bind(GameMessage.MC_SDK_PURCHASE_FAIL, self,self.onPayFail)
    Avalon.MessageCenter:bind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)

    Avalon.MessageCenter:bind(GameMessage.MC_IAPSHOP_SHOW_DETAILS, self,self.onShowDetails)
    
    Avalon.MessageCenter:bind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)

    Avalon.MessageCenter:bind(GameMessage.MC_PRODUCT_NEED_REMOVE, self,self.onCountdownOver)
    
    Avalon.MessageCenter:bind(GameMessage.MC_ON_TIPS_CLOSE_BUTTON, self,self.onCloseDetails)
    
    Avalon.MessageCenter:bind(GameMessage.MC_FIRST_RECHARGE_STATUS_CHANGED, self, self.initFirstRechagerButton) 

    -- 领取月卡状态刷新
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshMonthCardRedPoint)
    -- 新宝箱上架
    Avalon.MessageCenter:bind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.refreshIapBoxRedPoint)
end

function IapShopMainLayer:unRegisterListener()
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.refreshProducts)
    Avalon.MessageCenter:unbind(GameMessage.MC_GET_ORDER_SHOWLOADING, self,self.onGetOrderShowLoading)
    Avalon.MessageCenter:unbind(GameMessage.MC_GET_ORDER_REQ, self,self.getOrder)
    Avalon.MessageCenter:unbind(GameMessage.MC_REQ_PURCHASE_ERROR, self,self.onGetOrderError)
    
    Avalon.MessageCenter:unbind(GameMessage.MC_SDK_PURCHASE_FAIL, self,self.onPayFail)
    Avalon.MessageCenter:unbind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)

    Avalon.MessageCenter:unbind(GameMessage.MC_IAPSHOP_SHOW_DETAILS, self,self.onShowDetails)
    
    Avalon.MessageCenter:unbind(GameMessage.MC_PURCHASE_SUCCESS, self,self.onPurchaseResult)

    Avalon.MessageCenter:unbind(GameMessage.MC_PRODUCT_NEED_REMOVE, self,self.onCountdownOver)

    Avalon.MessageCenter:unbind(GameMessage.MC_ON_TIPS_CLOSE_BUTTON, self,self.onCloseDetails)
    Avalon.MessageCenter:unbind(GameMessage.MC_FIRST_RECHARGE_STATUS_CHANGED, self, self.initFirstRechagerButton) 

    -- 领取月卡状态刷新
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshMonthCardRedPoint)
    Avalon.MessageCenter:unbind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.refreshIapBoxRedPoint)
end

return IapShopMainLayer