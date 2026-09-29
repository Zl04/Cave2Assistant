    
-- CatFoodCell.lua
-- Author:zp
-- 2018年9月20日
-- Using: 猫饭数据处理
local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local CatFoodCell = class("CatFoodCell", UI.HWBtnComponent)
UI.CatFoodCell = CatFoodCell

local COM_WIDTH = 163
local COM_HEIGHT = 248
-- 资源列表(必备)

--构造函数(必备)
--isShowBtn: 是否需要展现假的不可点击按钮图， false：表示不显示，然后按钮交由外部实现
function CatFoodCell:ctor(spriteID, data, scrollView)
    --窗口大小
    CatFoodCell.super.ctor(
    self,0,
    {},
    COM_WIDTH,  
    COM_HEIGHT
    )

    self.spriteID = spriteID
    self.data = data 
    self._scrollView = scrollView

    self:init()
end

--虚构函数,destroy时调用(必备)
function CatFoodCell:dtor()
    CatFoodCell.super.dtor(self)
end

-- 初始化(必备)
function CatFoodCell:init()
    CatFoodCell.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function CatFoodCell:onInitView()
    local data = self.data

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    -- cellLayout:enableDebugDraw()
    self:addChild(cellLayout)

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_catfood_paper.png")
    bg:centerUp(0)
    cellLayout:addChild(bg)

    -- 标题
    local name  = UI.Text:create()
    name:init(LanguageManager:getInstance():getLocalString(data.name), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    name:centerUp(18- name:getContentSize().height/2)
    name:setTextCenter()
    cellLayout:addChild(name, 10)

    local line =  cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png", CCRectMake(0,0,1,1))
    line:setPosition(163/2, 213)
    line:setContentSize(134, 1)
    cellLayout:addChild(line)

    -- 猫饭物品
    local catfoodIcon  = UI.Image:create()
    catfoodIcon:init(data.icon)
    catfoodIcon:centerUp(95-catfoodIcon:getContentSize().height /2)
    cellLayout:addChild(catfoodIcon)
    self._catFoodIcon = catfoodIcon

    -- 描述
    local des  = UI.Text:create()
    des:init(LanguageManager:getInstance():getLocalString(data.effecDescription), UI.FONT_STANDARD, UI.FONT_SIZE_13PX, UI.FONT_COLOR_41_41_45)
    des:centerUp(159)
    des:setWidth(140)
    des:setTextCenter()
    des:setLineSpacing(-3)
    cellLayout:addChild(des, 10)


    local baseboard = UI.Button:create()
    baseboard:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
    cellLayout:addChild(baseboard)
    baseboard:centerBottom(0)
    baseboard:setTouchClipNode(self._scrollView)
    baseboard:setTouchEnable(true)
    baseboard:addEventListener(UIEvent.BUTTON_CLICK, self,self.onRemould)
    self._buyButton = baseboard

    local edibledImage = UI.Image:create()
    edibledImage:init("ui_catfood_seal.png")
    edibledImage:centerUp(95-catfoodIcon:getContentSize().height /2)
    edibledImage:setVisible(false)
    cellLayout:addChild(edibledImage)
    self._edibledImage = edibledImage

    -- 已经食用
    local edibled  = UI.Text:create()
    edibled:init(UI.TEXT_1170029, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
    -- edibled:setVisible(false)
    edibled:setAnchorPoint(0.5, 0.5)
    edibled:rotate(15)
    edibled:center()
    edibledImage:addChild(edibled, -1)
    -- self.edibled = edibled

    local diamondDiscountCost  = UI.Text:create()
    -- 修改字体颜色
    diamondDiscountCost:init(string.format(data.diamondCost), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_50_50_44)    
    diamondDiscountCost:centerLeft(55)
    -- diamondDiscountCost:setOP
    diamondDiscountCost:setOpacity(255*0.8)
    baseboard:addChild(diamondDiscountCost, 10)  
    self.diamondDiscountCost = diamondDiscountCost

    -- 划掉的线
    local bannelLine =  cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_red.png", CCRectMake(0,0,1,1))
    bannelLine:setPosition(diamondDiscountCost:getContentSize().width/2, diamondDiscountCost:getContentSize().height/2)
    bannelLine:setContentSize(diamondDiscountCost:getContentSize().width + 20, 1)
    diamondDiscountCost:addChild(bannelLine)
    self.bannelLine = bannelLine

    -- 需要花费的水晶数量
    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_gaming_diamond.png")
    diamondIcon:centerLeft(25)
    baseboard:addChild(diamondIcon, 10)
    self.diamondIcon = diamondIcon

    -- 花费的水晶数量
    local diamondCost  = UI.Text:create()
    diamondCost:init(string.format(math.floor((data.diamondCost * data.discount) / RATIO_NUMBER)), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)    
    diamondCost:centerLeft(55)
    baseboard:addChild(diamondCost, 10)   
    self.diamondCost = diamondCost

    local heroData = RoleDataManager:getMaster()
    local haveDiamond = heroData:getDiamond()
    if not Avalon.MathUtil:checkDiamonEnough(data.diamondCost, haveDiamond) then
        diamondCost:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    else
        diamondCost:setFontColor(UI.FONT_COLOR_50_50_44)    
    end
end

function CatFoodCell:onUpdateView(data)
    if(data == nil) then 
        return 
    end
    self.data = data

    local heroData = RoleDataManager:getMaster()
    local haveDiamond = heroData:getDiamond()

    local isGetBufferID = SkillDataManager:judgeMasterHaveBuff(data.buffID) 
    self._buyButton:setNormal("ui_btn_yellow6_0.png")
    self._buyButton:setSelected("ui_btn_yellow6_1.png")
    self._buyButton:setDisabled("ui_btn_yellow6_2.png")

    local offset = 10

    if(isGetBufferID == true) then 
        self.diamondDiscountCost:setVisible(false)
        self.bannelLine:setVisible(false)
        self.diamondCost:setVisible(false)
        self.diamondIcon:setVisible(false)
        self._catFoodIcon:setVisible(false)
        self._edibledImage:setVisible(true)
        self._buyButton:disable()
        self._buyButton:setVisible(false)
    else
        self._buyButton:setVisible(true)
        self._catFoodIcon:setVisible(true)
        self._edibledImage:setVisible(false)


        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(data.lotteryID, true)
        local lastCostDiamond = math.floor((data.diamondCost * data.discount) / RATIO_NUMBER)
        local useItemCost =  math.floor((data.lotteryNum * data.discount) / RATIO_NUMBER)
        useItemCost = useItemCost < 1 and 1 or useItemCost
        if goodNumber >= useItemCost then
            local icon = GoodsDataManager:createLocalGoodsData(data.lotteryID):getSmallIconName()
            self.diamondIcon:setSpriteName(icon)
            self.diamondCost:setText(useItemCost)
            self.diamondDiscountCost:setText(data.lotteryNum)
            self.diamondCost:setFontColor(UI.FONT_COLOR_50_50_44) 
        else
            self.diamondIcon:setSpriteName("symbol_gaming_diamond.png")
            self.diamondDiscountCost:setText(data.diamondCost)
            self.diamondCost:setText(tostring(lastCostDiamond))
            if not Avalon.MathUtil:checkDiamonEnough( lastCostDiamond, haveDiamond) then
                self.diamondCost:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            else
                self.diamondCost:setFontColor(UI.FONT_COLOR_50_50_44)    
            end
        end
        if(data.isDiscount) then
            self.diamondDiscountCost:setVisible(true)
            self.bannelLine:setVisible(true)
            self.diamondCost:setVisible(true)
            self.diamondIcon:setVisible(true)

            local startX = self._buyButton:getContentSize().width/2 - ( self.diamondIcon:getContentSize().width + self.diamondCost:getContentSize().width + offset)/2
            self.diamondIcon:centerLeft(startX)
            self.diamondCost:leftBottom(startX + self.diamondIcon:getContentSize().width + offset, 16 - self.diamondCost:getContentSize().height/2)
            self.diamondDiscountCost:leftUp(startX + self.diamondIcon:getContentSize().width + offset, 13 - self.diamondDiscountCost:getContentSize().height/2)

            self.bannelLine:setPosition(self.diamondDiscountCost:getContentSize().width/2, self.diamondDiscountCost:getContentSize().height/2)
            self.bannelLine:setContentSize(self.diamondDiscountCost:getContentSize().width + 20, 1)

            if(repeatData and repeatData[v.ID]) then
                self._buyButton:disable() 
            else 
                self._buyButton:enable()  
            end
        else 
            self.diamondDiscountCost:setVisible(false)
            -- self.diamondDiscountIcon:setVisible(false)
            self.bannelLine:setVisible(false)
            self.diamondCost:setVisible(true)
            self.diamondIcon:setVisible(true)
            
            -- self.diamondCost:centerLeft(55)
            -- self.diamondIcon:centerLeft(25)

            local startX = self._buyButton:getContentSize().width/2 - ( self.diamondIcon:getContentSize().width + self.diamondCost:getContentSize().width + offset)/2
            self.diamondIcon:centerLeft(startX)
            self.diamondCost:centerLeft(startX + self.diamondIcon:getContentSize().width + offset)

            if(repeatData and repeatData[v.ID]) then
                self._buyButton:disable()
            else 
                self._buyButton:enable() 
            end
        end 
        
        local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_CatFood)
        if adsData and adsData.isOpen and (adsData.gotNum > adsData.usedNum) and (adsData.usedNum < adsData.maxNum) and self.data.is_DiamondPurchase ~= 1 then
            self._catFoodIcon:setVisible(true)
            self._edibledImage:setVisible(false)
            self.bannelLine:setVisible(false)
            self.diamondCost:setVisible(false)
            self.diamondIcon:setVisible(false)
            self._edibledImage:setVisible(false)
            self.diamondDiscountCost:setVisible(false)

            self._buyButton:enable()
            self.diamondCost:center()
            self.diamondCost:setVisible(true)
            self.diamondCost:setText(UI.TEXT_1172013)
            self.diamondCost:setFontColor(UI.FONT_COLOR_50_50_44)   
        end
    end

   
end

function CatFoodCell:onRemould()
    local cfgData = self.data

    local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.NPC_CAT_FOOD)
    -- 判断是否在购买中
    if(repeatData and repeatData[cfgData.ID]) then
        return
    end


    local isGetBufferID = SkillDataManager:judgeMasterHaveBuff(cfgData.buffID)
    if isGetBufferID then
        UI.ScrollBar:createByTextID(1170029)
        return
    end
    local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_CatFood)
    if adsData and adsData.isOpen and adsData.gotNum > adsData.usedNum and (adsData.usedNum < adsData.maxNum) then

    else
        -- 判断钻石是否够用
        local heroData = RoleDataManager:getMaster()
        local haveDiamond = heroData:getDiamond()
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(cfgData.lotteryID, true)
        local useItemCost =  math.floor((cfgData.lotteryNum * cfgData.discount) / RATIO_NUMBER)
        useItemCost = useItemCost < 1 and 1 or useItemCost
        if (goodNumber < useItemCost and not Avalon.MathUtil:checkDiamonEnough(math.floor((cfgData.diamondCost * cfgData.discount) / RATIO_NUMBER), haveDiamond)) then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end 
    end
    if RoleBehaviorManager:catFoodAndBeautySalonNpcCheck() then
        printWarn(" been blocking when using catFood npc function !")
        return
    end

    UI.WaitingLayer:showWaiting(true, self:getParent(), GAME_NET_DELAY_UI)
    Net.NetNPCSystem:sendcatFood(cfgData.ID, self.spriteID)

    MasterDataManager:insertRepeatHandleData(RepeatHandleType.NPC_CAT_FOOD, cfgData.ID, true)
    self:updateView()
end