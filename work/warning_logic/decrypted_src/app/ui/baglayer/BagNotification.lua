-- BagNotification.lua
-- Author:CMonk
-- 2019年6月20日
-- 背包提示

local LanguageManager = require("app.game.LanguageManager")

require "app.ui.HWBtnComponent"

UI = UI or {}

local BagNotification = class("BagNotification", UI.HWBtnComponent)
UI.BagNotification = BagNotification

local COM_RES_LIST = {}
local winSize = cc.Director:getInstance():getWinSize()
local TYPE = {
    GIFT_BAG = 1,
    SKILL_POINT = 2,
    UPGRADABLE_EQUIP = 3,
}

function BagNotification:updateOncePerSecond()
    local totalTime = self._totalTime or 0
    local timeNow = GameManager:getNormalServerTime()
    local remainTime = self._closeTimeStamp and self._closeTimeStamp - timeNow or 0
    if (remainTime < 0) then remainTime = 0 end
    if(not tolua.isnull(self._pro)) then
        self._pro:setPercentage(remainTime / totalTime * 100)
    end
end

-- 构造函数
function BagNotification:ctor( ... )
    BagNotification.super.ctor(
        self,
        UIType.BAG_NOTIFICATION,
        COM_RES_LIST,
        0,    
        0
    )
    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateOncePerSecond), 1, false)
end

-- 析构函数
function BagNotification:dtor( ... )
    BagNotification.super.dtor(self, ...)

    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

-- public:
-- 初始化
function BagNotification:init(data)
    BagNotification.super.init(self, data)
end

-- 初始化视图
function BagNotification:onInitView( ... )
    BagNotification.super.onInitView(self, ...)

    -- 整体背景
    local picBG = UI.Image:create()
    picBG:init("ui_info_banner_iteminfo2.png")
    picBG:center()
    self:setSize(picBG:getSize())
    self:addChild(picBG)

    -- 掉落物品名称
    self._title = UI.Text:create()
    self._title:init("DEADBEEF",UI.FONT_STANDARD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._title:setSize(150, 35)
    self._title:setLineSpacing(-6)
    self._title:setTextCenter()
    self._title:setWidth(150)
    self._title:centerUp(20- self._title:getContentSize().height/2)
    picBG:addChild(self._title)

    -- 物品
    self._goodsGrid = UI.GoodsGrid:create()
    self._goodsGrid:init()
    self._goodsGrid:centerBottom(72)
    self._goodsGrid:setTouchEnable(false)
    picBG:addChild(self._goodsGrid)

    -- 图标ICON背景
    self._iconBG = UI.Image:create()
    self._iconBG:init("box_quality_box_01.png")
    self._iconBG:centerBottom(72)
    picBG:addChild(self._iconBG)

    -- 图标ICON
    self._icon = UI.Image:create()
    self._icon:init("icon_skill.png")
    self._icon:center()
    self._iconBG:addChild(self._icon)

    -- 进度条背景
    local picProBG = cc.Sprite:createWithSpriteFrameName("ui_info_progressbar_00.png")
    picProBG:setPosition(81,45)
    picBG:addChild(picProBG)

    -- 进度条
    self._pro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_info_progressbar_10.png"))
    self._pro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self._pro:setMidpoint(cc.p(0,0))
    self._pro:setBarChangeRate(cc.p(1,0))
    self._pro:setPosition(cc.p(picProBG:getContentSize().width/2,picProBG:getContentSize().height/2))
    self._pro:setPercentage(100)
    picProBG:addChild(self._pro,20)

    -- 按钮
    self.btnView = UI.Button:create()
    self.btnView:init("ui_info_button1_0.png","ui_info_button1_1.png","ui_info_button1_0.png")
    self.btnView:setTextById(LanguageManager:getInstance():getLocalString(1112368))
    self.btnView:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    self.btnView:centerBottom(8)
    self.btnView:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (not self._type) then return end
        
        if (self._type == TYPE.GIFT_BAG) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
        elseif (self._type == TYPE.SKILL_POINT) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG, UI.BagPanel.TAB_INDEX.SKILL)
        elseif (self._type == TYPE.UPGRADABLE_EQUIP) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
        end
        self:hidePanel()
    end)
    picBG:addChild(self.btnView)
end

-- 更新视图
function BagNotification:onUpdateView( ... )
    BagNotification.super.onUpdateView(self, ...)
end

-- 设置显示技能图标
function BagNotification:showSkillIcon()
    -- 图标
    self._iconBG:show()
    self._goodsGrid:hide()
    self._type = TYPE.SKILL_POINT

    -- 标题
    self._title:setText(LanguageManager:getInstance():getLocalString(1112365))
end

-- 设置显示道具
function BagNotification:setShowEquip(ID)
    -- 图标
    self._iconBG:hide()
    local goodsData = self:getDummyItemData(ID)
    self._goodsGrid:show()
    self._goodsGrid:reset()
    self._goodsGrid:setData(goodsData)
    self._goodsGrid:updateView()
    self._goodsGrid:hideNewIcon()
    self._type = TYPE.UPGRADABLE_EQUIP

    -- 标题
    self._title:setText(LanguageManager:getInstance():getLocalString(1112364))
end

-- 设置显示礼包
function BagNotification:setShowGiftBag(ID)
    -- 图标
    self._iconBG:hide()
    local goodsData = self:getDummyItemData(ID)
    self._goodsGrid:show()
    self._goodsGrid:reset()
    self._goodsGrid:setData(goodsData)
    self._goodsGrid:updateView()
    self._goodsGrid:hideNewIcon()
    self._type = TYPE.GIFT_BAG

    -- 标题
    self._title:setText(LanguageManager:getInstance():getLocalString(1112366))
end

-- 设置倒计时时间
function BagNotification:setDisplayCountDownTime(d)
    local timeNow = GameManager:getNormalServerTime()
    self._closeTimeStamp = timeNow + d
    self:updateOncePerSecond()
end

-- 设置总时间
function BagNotification:setTotalDisplayCountDownTime(t)
    self._totalTime = t
    self:updateOncePerSecond()
end

-- 关闭
function BagNotification:hidePanel()
    self:hide()
    self:rightBottom(-winSize.width, -winSize.height)
end

-- 获取一个假物品信息
function BagNotification:getDummyItemData(id)
    require "app.datas.GoodsDataManager"
    local goodData = GoodsDataManager:createLocalGoodsData(id) --23030001
    if goodData then
        goodData:setNum(0)
        goodData:setIsNew(false)
        goodData.isHaveGet = false
    end
    return goodData
end

-- 禁用所有按钮
function BagNotification:disableAllBtn()
    self.btnView:setTouchEnable(false)
end

-- 启用所有按钮
function BagNotification:enableAllBtn()
    self.btnView:setTouchEnable(true)
end