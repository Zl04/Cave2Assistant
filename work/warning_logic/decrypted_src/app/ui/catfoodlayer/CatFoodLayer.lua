-- Author:CHENZIHAN
-- Using:猫饭UI

require("app.ui.common.CurrencyPanel")

local ProtobufUtil = require "utils.ProtobufUtil"
-- require "app.ui.catfoodlayer.catfoodInfoArea"
require "app.ui.catfoodlayer.CatFoodCell"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local CatFoodLayer = class("CatFoodLayer", UI.DownShowWin)
UI.CatFoodLayer = CatFoodLayer

local winSize = cc.Director:getInstance():getWinSize()

local CELL_SIZE = 3 -- 每排可以容纳的单元数量
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_catfood.plist",
}
-- 道具详情的touch事件处理    
local function onPropInfoAreaTouchHandler(self)
    if(self.catfoodInfo) then
        self.catfoodInfo:close()
        self.catfoodInfo = nil 
    end 

end

--构造函数(必备)
function CatFoodLayer:ctor(type)
    --窗口大小
    CatFoodLayer.super.ctor(
    self,UIType.CATFOOD_UI,
    COM_RES_LIST,
    760,    
    551
    )
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:registerListener();

    self._catFoodData = clone(ConfigManager:getCaFoodConfig())

    self.cellLayoutList = {}
    self.catfoodInfo = nil
    self._discountData = nil

    self.caveMode = nil
    -- self:enableDebugDraw()
end

--虚构函数,destroy时调用(必备)
function CatFoodLayer:dtor()
    self.buyed = false
    self.id = 0 
    CatFoodLayer.super.dtor(self)
    self:unRegisterListener();
    self.catfoodInfo = nil
    self._catFoodData = nil
    self.caveMode = nil
end

-- 初始化(必备)
function CatFoodLayer:init(NPCSpriteID, caveMode)
    self.spriteID = NPCSpriteID
    if(self._discountData == nil) then
        self._discountData = MasterDataManager:getDiscountData(PublicDefine.DiscountType.DiscountType_CatFood)
    end
    self.caveMode = caveMode
    CatFoodLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function CatFoodLayer:onInitView()
    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_bg_box1.png")
    bg:center()
    self:addChild(bg)

    -- 标题背景
    local titleBg = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    -- titleBg:centerUp(-21)
    titleBg:leftUp(bg:getContentSize().width/2 - titleBg:getContentSize().width/2 - 8, -21)
    bg:addChild(titleBg, 10)

    -- 猫饭文字
    local catfoodText = UI.Text:create()
    catfoodText:init(UI.TEXT_1170030, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
    -- catfoodText:center()
    catfoodText:centerLeft(56+117 - catfoodText:getContentSize().width/2)
    titleBg:addChild(catfoodText)

    -- 
    local stakes = UI.Image:create()
    stakes:init("ui_catfood_rattan.png")
    stakes:rightBottom(-36, 0)
    bg:addChild(stakes, -1)

    -- 圆盘
    local stakes = UI.Image:create()
    stakes:init("ui_catfood_stakes.png")
    stakes:leftBottom(-49, -18)
    bg:addChild(stakes, 10)

    local stakes = UI.Image:create()
    stakes:init("ui_catfood_tree.png")
    stakes:leftBottom(-91, 0)
    bg:addChild(stakes, -1)

    local cat = UI.Animation:create()
    cat:init("effect_ui_town_catfood.json", "effect_ui_town_catfood.atlas", 1);
    cat:leftBottom(5 - 5, 170 - 5)
    self:addChild(cat, 1)
    cat:setAnimation("idle01",false)
    cat:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(sender, event)
        local randNum = math.random(1, 10)
        if randNum > 6 then
            cat:setAnimation("idle02",false)
        else
            cat:setAnimation("idle01",false)
        end
    end)

    -- local decoretion = UI.Image:create()
    -- decoretion:init("ui_catfood_gavelock1.png")
    -- decoretion:centerBottom(0)
    -- self._contentLayout:addChild(decoretion)

    -- 添加中间的背景
    local contentLayout = UI.Image:create()
    contentLayout:init("ui_bg_paper1.png")
    contentLayout:leftBottom(44, 40)
    bg:addChild(contentLayout, 2)
    self._contentLayout = contentLayout

    local splitLine = AvalonUtil.createSplitLine(560, "ui_scale9image_banner_line_long.png", true)
    splitLine:centerUp(47)
    contentLayout:addChild(splitLine)

    -- 货币组件
    local currentLayout = UI.CurrencyPanel:create()
    currentLayout:rightUp(60, 0)
    self._contentLayout:addChild(currentLayout)


    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(308 *2 + 10,390)
    scrollView:init()
    scrollView:leftBottom(29, 1)
    scrollView:addInnerNode(self._scrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(3)
    self._contentLayout:addChild(scrollView)

    -- 添加货币表现

    -- 底部半透明
    local mask = UI.Image:create()
    mask:init("ui_catfood_gradually.png")
    mask:centerBottom(0)
    self._contentLayout:addChild(mask)

    self:filtCatFoodByMode()

    self:refreshDiscountData()
    for k,v in ipairs(self._catFoodData) do 
        if(v.talentTouchOff == 0 or GameDataManager:getInstance():isActiveExtertnTalentSkill(v.talentTouchOff)) then 
            self:createOneCell(v, k, scrollView)
        end
    end 
    -- self:enableDebugDraw(UI.RED)
    -- 装饰物
    local decoretion = UI.Image:create()
    decoretion:init("ui_catfood_gavelock2.png")
    decoretion:rightBottom(-15, 30)
    self:addChild(decoretion, 100)

    local crystal = UI.Animation:create()
    crystal:init("effect_ui_town_catfood_right.json", "effect_ui_town_catfood_right.atlas", 1);
    crystal:rightBottom(36, 10)
    self:addChild(crystal, 100)
    crystal:setAnimation("idle", true)
    self:refreshAdsStatus()
end

function CatFoodLayer:refreshAdsStatus()
    local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_CatFood)
    if adsData and adsData.isOpen and (adsData.gotNum < adsData.maxNum) then
        local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_CatFood)
        if self.adsBtn == nil then
            local button = AvalonUtil.createPlayAdsButton(function()
                local orderId = AvalonUtil.getCurrentTime()
                GameManager:sendAdsLog(PublicDefine.AdsPlaceId.CatFood, PublicDefine.AdvertFuncType.AdvertFuncType_CatFood, orderId, 5)
                local maxTime = adsData == nil and 0 or adsData.maxNum
                local textList =  {UI.TEXT_1212425, string.format(UI.TEXT_1212426, maxTime or 0)}
                UI.ConfirmDialog.showConfirmDialogCancelRedOkWhiteAndTexts(textList, function(isSelect)
                    GameManager:sendAdsLog(PublicDefine.AdsPlaceId.CatFood, PublicDefine.AdvertFuncType.AdvertFuncType_CatFood, orderId, 6)
                    GameManager:playAds(PublicDefine.AdsPlaceId.CatFood, PublicDefine.AdvertFuncType.AdvertFuncType_CatFood, orderId)
                end, function(isSelect)
                    GameManager:sendAdsLog(PublicDefine.AdsPlaceId.CatFood, PublicDefine.AdvertFuncType.AdvertFuncType_CatFood, orderId, 7)
                end, nil, nil, false)
            end, UI.TEXT_1212931)
            self._contentLayout:addChild(button, 20)
            button:rightUp(-85, -6)
            self.adsBtn = button
        else
            self.adsBtn:show()
        end
        GameManager:loadAds(PublicDefine.AdsPlaceId.CatFood, PublicDefine.AdvertFuncType.AdvertFuncType_CatFood)
    else
        if self.adsBtn then
            self.adsBtn:hide()
        end
    end
    self:updateView()
end

function CatFoodLayer:refreshDiscountData()
    for k,data in ipairs(self._catFoodData) do 
        -- 判断是否打折
        local isDiscount = false 
        local discount = RATIO_NUMBER
        if(self._discountData and #self._discountData > 0) then
            local globalDiscountData = nil
            -- 查找全局的配置
            for k,v in pairs(self._discountData) do
                if(v:getID() == 0) then
                    globalDiscountData = v
                end
            end

            for k,v in pairs(self._discountData) do
                if(globalDiscountData) then
                    -- 有全局配置的时候
                    if(globalDiscountData:judgeToEffect()) then
                        if(v:getID() == data.ID) then 
                            isDiscount = true
                            discount = v:getDiscount()
                            break
                        end
                    end 
                else
                    -- 无全局配置
                    if(v:getID() == data.ID and v:judgeToEffect()) then 
                        isDiscount = true
                        discount = v:getDiscount()
                        break
                    end
                end 
            end
        end

        -- 测试代码
        -- local testDiscount = true
        -- if(testDiscount) then 
        --     isDiscount = true
        --     discount = 60
        -- end

        data.isDiscount = isDiscount
        data.discount = discount
    end 
end

function CatFoodLayer:createOneCell(data, index, scrollView)
    -- 物品地板
    local index_x = index % CELL_SIZE
    local index_Y = math.ceil(index / CELL_SIZE)
    if index_x == 0 then
        index_x = CELL_SIZE
    end

    local cellLayout = UI.CatFoodCell:create(self.spriteID, data, scrollView)
    cellLayout:leftUp(29 + 195 * (index_x - 1), 1+ 275 * (index_Y - 1))
    self._scrollLayout:addChild(cellLayout)
    self._scrollLayout:setSize(308 *2, 275 * index_Y)

    
    self.cellLayoutList[data.ID] = cellLayout
end

-- 模版函数：更新组建的视图(必备)
function CatFoodLayer:onUpdateView()
    local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.NPC_CAT_FOOD)

    self:refreshDiscountData()

    local heroData = RoleDataManager:getMaster()
    local haveDiamond = heroData:getDiamond()
    for k, v in ipairs(self._catFoodData)  do 
        local isGetBufferID = SkillDataManager:judgeMasterHaveBuff(v.buffID) 
        local cellLayout = self.cellLayoutList[v.ID]
        if(cellLayout) then 
            cellLayout:updateView(v)
        end
    end     
end

--改造网络回调
function CatFoodLayer:remouldCallBack(data)
    UI.WaitingLayer:hideWaiting()
    -- add by zp 这里存在严重的逻辑，如果在快速点击两个猫饭，这里UI刷新有问题，这里修改为粗暴的全部刷新
    self:updateView()

    if data.result == "CatFoodResultType_Succeed" then
        UI.ScrollBar:createByText(UI.TEXT_1212025)
    else
        GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.CatFoodResultType",data.result))
    end
end

function CatFoodLayer:refreshPriceColor()
    self:updateView()
end

function CatFoodLayer:refreshActivity()
    self._discountData = MasterDataManager:getDiscountData(PublicDefine.DiscountType.DiscountType_CatFood)
    self:refreshDiscountData()
    self:updateView()
end

function CatFoodLayer:loadAdsResult(isSuccess)
    if isSuccess then
        if self.adsBtn then
            self.adsBtn:show()
        end
    else
        if self.adsBtn then
            self.adsBtn:hide()
        end
    end
end

function CatFoodLayer:filtCatFoodByMode()
    local removeList = {}
    for k, v in pairs(self._catFoodData) do
        local displayModeStrList = string.split(v.displayMode, ";")
        if not self.caveMode and displayModeStrList[1] and displayModeStrList[1] ~= "" then
            table.insert(removeList, k)
        end

        if self.caveMode and displayModeStrList[1] and displayModeStrList[1] ~= "" then
            local isRemove = true
            for i, mode in pairs(displayModeStrList) do
                if self.caveMode == tonumber(mode) then
                    isRemove = false
                    break
                end
            end

            if isRemove then
                table.insert(removeList, k)
            end
        end
    end

    for i = #removeList, 1, -1 do
        if removeList[i] then
            table.remove(self._catFoodData, removeList[i])
        end
    end
end

-- 注册监听事件(可选)
function CatFoodLayer:registerListener()
    -- 分解结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_CATFOOD, self, self.remouldCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshPriceColor)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshActivity)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_ADVERT_STATUS, self, self.refreshAdsStatus)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SDK_ADS_LOAD_RESULT, self, self.loadAdsResult)
end


-- 注销监听事件(可选)
function CatFoodLayer:unRegisterListener()
    --分解结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_CATFOOD, self, self.remouldCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshPriceColor)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshActivity)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_ADVERT_STATUS, self, self.refreshAdsStatus)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SDK_ADS_LOAD_RESULT, self, self.loadAdsResult)
end

function CatFoodLayer:openShow()
    self:open()
end


