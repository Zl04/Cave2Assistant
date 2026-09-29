--[[
    UI - 弹出提示
]]--

require "app.ui.Component"
require "utils.AvalonUtil"
require("app.ui.common.Dialog.ConfirmDialog")

UI = UI or {}

local Tips = class("Tips", UI.HWBtnComponent)
UI.Tips = Tips
local winSize = cc.Director:getInstance():getWinSize()
-- 对话框类型
UI.TipsType = {
    NO_BUTTON = 1,              -- 没有按钮 只有文字
    CONFIRM = 2,                -- 只有确认按钮
    CONFIRM_AND_CANCEL = 3      -- 有确认和取消按钮
}
local TipsType = UI.TipsType

-- TIPS 
    -- START_VOTE_UI = 1,      --  发起把某人踢出队伍的投票的TIPS 
    -- IS_VOTE_UI = 2,         --  是否投票的TIPS 
    -- IS_USE_ESCAPE_UI = 3,   --  是否使用逃脱卷轴返回城镇的TIPS 
    -- VOTE_SUCCEED_UI = 4,    --  投票成功离开队伍的TIPS
    -- DOWNS_TAIRS_UI = 5,     --  下楼的TIPS
    -- USE_ESCAPE = 6,         --  使用回城卷轴TIPS  
    -- LEAVE_TEAM_UI = 7,      --  离开队伍的TIPS 
UI.TipsUiType = {

    SALES_EQUIPMENT = 1,    --  售卖装备的TIPS 99
    BUG_GOODS = 2,          --  购买物品的TIPS 
    GOLD_NOT_ENOUGH = 3,   --  黄金不足的TIPS 
    MASONRY_NOT_ENOUGH = 4,--  钻石不足的TIPS 
    BUY_AMOUNT = 5,        --  购买物品数量TIPS 
    NORMAL = 6,            --  通用的TIPS
    AWARD_ITEM_UI = 7,     --  奖励物品的TIPS
    NORMAL_AND_PROGRESSBAR = 8,     --  带有进度条的TIPS
    DUNGEON_SEASON_REWARD = 9,
    EDITBOX = 10,           --  输入框
    COMMENT_TIPS = 11,    --跳转评论 tips
    BIND_ACCOUNT_TIPS = 12, -- 绑定账号的tips
}
local TipsUiType = UI.TipsUiType

UI.TipsButtonType = {
    NO_TEXT_BUTTON = 1,    -- 不含文本的按钮
    TEXT_BUTTON = 2,-- 含有文本的按钮
}
local tipsButtonType = UI.TipsButtonType
-- private:
local DEBUG = false
local DEBUG_DRAW = true

local TIPS_RES_LIST = {
     
}
local AWARD_GLOD = "icon_gold.png"
local AWARD_DIAMOND = "icon_diamonds.png"

local  TIPS_BG_SPRITE = "ui_tips_banner_box_00.png"    --  背景图片 SIZE:369 253
local  TIPS_BG_SPRITE_1 = "ui_tips_banner_box_00.png"    --  背景图片 SIZE:369 273
local  TIPS_BG_SPRITE_2 = "ui_tips_banner_box_02.png"    --  背景图片 SIZE:369 253 买卖装备的背景图
local  TIPS_BG_SPRITE_3 = "ui_tips_banner_box_00.png"    --  背景图片 SIZE:369 173
local  TIPS_BG_SPRITE_4 = "ui_tips_banner_box_00.png"    --  背景图片 SIZE:370 273 
local  TIPS_BG_SPRITE_5 = "ui_general_information_reward.png"    --  背景图片 SIZE:496 361 

local  TIPS_OK_SPRITE_01 = "ui_btn_button_confirm_0.png"        --  确认按钮
local  TIPS_OK_SPRITE_02 = "ui_btn_button_confirm_1.png"        --  确认按钮
local  TIPS_CANCEL_SPRITE_01 = "ui_btn_button_refuse_0.png"     --  取消按钮
local  TIPS_CANCEL_SPRITE_02 = "ui_btn_button_refuse_1.png"     --  取消按钮
local  TIPS_PROG_BAR_0 = "ui_progressbar_time_00.png"--  进度条
local  TIPS_PROG_BAR_1 = "ui_progressbar_time_10.png"--  进度条

local  GOLD_ICON = "symbol_gaming_money.png"                --  黄金图标
local  CRYSTAL = "symbol_gaming_diamond.png"                --  钻石图标
local  GRAY_BG = "ui_btn_button1_0.png"              --  灰色的背景按钮

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0

-- 点击确定按钮
local function onConfirmHandler(self)
    print("onConfirmHandler")
    self:close()
    if self._tipsuitype == TipsUiType.EDITBOX then
        self:dispatchEvent(UIEvent.DIALOG_CONFIRM,self,self.libIDEdit:getText())
    else
        self:dispatchEvent(UIEvent.DIALOG_CONFIRM,self)
    end
end

local function onCenterHandler(self)
    self:close()
    self:dispatchEvent(UIEvent.DIALOG_CENTER)
end
-- 点击取消按钮
local function onCancelHandler(self)
    self:close()
    self:dispatchEvent(UIEvent.DIALOG_CANCEL)
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    if self.touchDialogOutsizeClose then
        self:dispatchEvent(UIEvent.DIALOG_OUT_SIDE)
        if (self._touchOutsideHandler) then self._touchOutsideHandler() end
    end
end


-- 添加纯图片的确认按钮
local function addConfirmButton(self)
    local button = UI.Button:create()
    button:init(TIPS_OK_SPRITE_01,TIPS_OK_SPRITE_02,TIPS_OK_SPRITE_01)
    -- button:setSize(60, 40)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onConfirmHandler)
    self._bg:addChild(button)
    button:openClickScale()
    self._confirmButton = button
end

-- 添加纯图片的取消按钮
local function addCancelButton(self)
    local button = UI.Button:create()
    button:init(TIPS_CANCEL_SPRITE_01,TIPS_CANCEL_SPRITE_02,TIPS_CANCEL_SPRITE_01)
    -- button:setSize(60, 40)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
    self._bg:addChild(button)
    self._cancelButton = button
    button:openClickScale()
end

-- 添加图片+文字的 返回城镇按钮
local function addImageTextToCityButton(self)
    local button = UI.Button:create()
    button:init("ui_btn_button2.png", "ui_btn_button2.png", "ui_btn_button2_3.png")
    -- button:setSize(60, 40)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
    
    button:openClickScale()
   
    self._bg:addChild(button)
    self._cancelButton = button

    local text  = UI.Text:create()
    text:init(UI.TEXT_110028)
    text:centerBottom(12)
    text:setFontSize(20)
    text:setOutline(UI.FONT_COLOR_OUTLINE_39_16_3)
    text:setFontColor(UI.FONT_COLOR_255_242_210)
    text:setName("text")
    button:addChild(text,100)
end
-- 添加图片+文字的 使用逃脱卷轴
local function addImageTextToTownButton(self)
    local GameDataManager = require("app.game.GameDataManager")
    -- local data =  GameDataManager:getInstance():getEscapeScroll()
    local button = UI.Button:create()
    -- if(data ~= nil ) then 
        
    button:init("ui_btn_button3.png", "ui_btn_button3.png", "ui_btn_button3_3.png")
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onConfirmHandler)
        
    self._bg:addChild(button)
    self._confirmButton = button
    button:openClickScale()
    -- else 
    --     button:init(GRAY_BG,GRAY_BG,GRAY_BG)
    --     -- button:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
        
    --     self._bg:addChild(button)
    --     self._confirmButton = button
    --     button:openClickScale()
    -- end 
    
    local  text  = UI.Text:create()
    text:init(UI.TEXT_110027)
    text:centerBottom(12)
    text:setFontSize(20)
    text:setName("text")
    text:setOutline(UI.FONT_COLOR_OUTLINE_39_16_3)
    text:setFontColor(UI.FONT_COLOR_255_242_210)

    button:addChild(text,100)
end

-- 构造函数
function Tips:ctor()
    Tips.super.ctor(self, UIType.TIPS, TIPS_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self._tipsButtonType = nil 
    self._tipsType = 0
    self._bg = nil 
    self._tipsStr = nil
    self._tipsText = nil
    self._confirmButton = nil
    self._cancelButton = nil
    self._tipsuitype = 0
    self._mTime = 20            --倒计时20秒
    self.mSchedulerID = 0
    
    self._glodAmout = 0         -- 售卖装备所得的黄金数量
    self.glod_Amount =nil 

    self._diamondAmount = 0     -- 购买物品的钻石数量
    self.diamondAmount = nil    -- 购买物品钻石数量的TEXT
    self._itemName = nil        -- 购买物品的名称
    self.itemName = nil         -- 购买物品的名称的TEXT

    self._itemDiamondAmount = 0         -- 购买单个物品所需的钻石数量
    self.itemDiamondAmount = nil        -- 购买单个物品所需的钻石数量的TEXT
    self._itemAmount = 0       -- 购买的物品数量

    self._strFmt = 1 -- 默认购买数量

    self.titleText_Normal = nil -- 通用的TIPS的文字
    self._costType = nil -- 花费的类型 黄金还是钻石
    self._maxAmount = nil -- 购买数量的最大值

    self.mTitleText = nil;
    self._awardData = nil --奖励数据
    self._taskList = {}
    self._taskAwardList = nil 

    self.touchDialogOutsizeClose = true;    --点击外围是否关闭
    self.rewardItems = {}
end

-- 析构函数
function Tips:dtor()
    self._tipsButtonType = nil 
    self._tipsuitype = nil
    self._tipsStr = nil
    self._bg = nil 
    self._tipsText = nil
    self._confirmButton = nil
    self._cancelButton = nil
    
    self._glodAmout = 0
    -- self.glod_Amount = nil

    self._diamondAmount = 0     -- 购买物品的价格
    self.diamondAmount = nil    -- 购买物品价格的TEXT
    self._itemName = nil        -- 购买物品的名称
    self.itemName = nil         -- 购买物品的名称的TEXT

    self._itemDiamondAmount = 0         -- 购买单个物品所需的钻石数量
    self._itemAmount = 0        -- 购买物品数量
    self.itemDiamondAmount = nil        -- 购买单个物品所需的钻石数量
    self._strFmt = 1 -- 默认购买数量
    self.titleText_Normal = nil -- 通用的TIPS的文字

    self._costType = nil -- 花费的类型 黄金还是钻石
    self._maxAmount = nil -- 购买数量的最大值

    local scheduler=cc.Director:getInstance():getScheduler()
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
    self.mTitleText = nil;
    Tips.super.dtor(self)    
    self.rewardItems = {}
end

-- public:
-- 初始化
--tipsType 有无按钮状态
--tipsUiType tips类型
--tipsStr tips内容
--tipsButtonType 文字或图片按钮
--proTime 倒计时时间
function Tips:init(tipsType,tipsUiType,tipsStr,tipsButtonType,proTime,descTips)
    if (tipsType) then assert(type(tipsType) == "number" and tipsType >= 1, "Tips init: the tips type is invalid.") end

    self._tipsType = tipsType or TipsType.CONFIRM -- 默认是没有按钮的。
    self._tipsStr = tipsStr or ""
    self._tipsuitype = tipsUiType or TipsUiType.NORMAL
    self._tipsButtonType = tipsButtonType
    self._porTime = proTime or 1            --倒计时
    self._descTips = descTips
    Tips.super.init(self)

    local tipsButtonType = UI.TipsButtonType
    self:setTouchEnable(true)
    self:setInterceptTouches(true)


    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
end
local winSize = cc.Director:getInstance():getWinSize()



-- 初始化视图
function Tips:onInitView()
    local tipsuitype = self._tipsuitype
    local tipsButtonType = self._tipsButtonType

    local bg = UI.Image:create()
    
    local textSize = {width = 220,height = 80}

    if (tipsuitype == TipsUiType.SALES_EQUIPMENT or tipsuitype == TipsUiType.BUG_GOODS  or tipsuitype ==TipsUiType.MASONRY_NOT_ENOUGH) then 


            self._bg = bg
            bg:init(TIPS_BG_SPRITE)
            bg:center()
            self:addChild(bg)
            self:setSize(bg._width,bg._height)

        if(tipsuitype == TipsUiType.SALES_EQUIPMENT) then -- 售卖装备的TIPS
            local titleText_1 = UI.Text:create() 
            titleText_1:init("", "")
            titleText_1:setFontSize(18)
            titleText_1:setFontColor(UI.FONT_COLOR_59_42_12)
            titleText_1:leftUp(100,60)
            titleText_1:setText(string.format("%s",self._tipsStr ))
            bg:addChild(titleText_1, 10)

            local titleText_2 = UI.Text:create() 
            titleText_2:init(UI.TEXT_111017,UI.FONT_STANDARD)
            titleText_2:setFontSize(18)
            titleText_2:setFontColor(UI.FONT_COLOR_59_42_12)
            titleText_2:leftUp(130,90)
            bg:addChild(titleText_2, 10)
            self.titleText_2 = titleText_2
            -- 黄金图标
            local glod_Icon = UI.Image:create()
            glod_Icon:init(GOLD_ICON)
            glod_Icon:leftUp(205,90)
            bg:addChild(glod_Icon, 10)
            -- 黄金数量
            local glod_Amount = UI.Text:create() 
            glod_Amount:init("",UI.FONT_STANDARD)
            glod_Amount:setFontSize(18)
            glod_Amount:setFontColor(UI.FONT_COLOR_59_42_12)
            glod_Amount:leftUp(235,90)
            self.glod_Amount = glod_Amount
            bg:addChild(glod_Amount, 10)
            
            self.glod_Icon = glod_Icon
        elseif(tipsuitype == TipsUiType.BUG_GOODS) then -- 购买物品的TIPS
            local titleText_1 = UI.Text:create()
            titleText_1:init(UI.TEXT_111013,UI.FONT_STANDARD)
            titleText_1:setFontSize(18)
            titleText_1:setFontColor(UI.FONT_COLOR_59_42_12)
            titleText_1:leftUp(145,70)
            bg:addChild(titleText_1, 10)
            
            -- 消费类型图标 
            local crystal_Icon = UI.Image:create()
            crystal_Icon:init()
            crystal_Icon:leftUp(175,70)
            self.costtype = crystal_Icon
            bg:addChild(crystal_Icon, 10)

            -- 钻石数量
            local crystal_Num = UI.Text:create()
            crystal_Num:init("",UI.FONT_STANDARD)
            crystal_Num:setFontSize(18)
            crystal_Num:setFontColor(UI.FONT_COLOR_59_42_12)
            crystal_Num:leftUp(190,70)
            crystal_Num:setWidth(200)
            crystal_Num:setTextLeft()
            self.diamondAmount = crystal_Num
            bg:addChild(crystal_Num, 10)
            -- w物品名称
            local itemName = UI.Text:create()
            itemName:init("",UI.FONT_STANDARD)
            itemName:leftUp(210,70)
            itemName:setFontSize(18)
            itemName:setFontColor(UI.FONT_COLOR_59_42_12)
            itemName:setWidth(200)
            itemName:setTextLeft()
            self.itemName = itemName
            bg:addChild(itemName, 10)
            
            -- 购买
            local title = UI.Text:create()
            title:init(UI.TEXT_111014,UI.FONT_STANDARD)
            title:leftUp(230,70)
            title:setFontSize(18)
            title:setFontColor(UI.FONT_COLOR_59_42_12)
            title:setWidth(200)
            title:setTextLeft()
            bg:addChild(title, 10)

        elseif(tipsuitype == TipsUiType.MASONRY_NOT_ENOUGH) then -- 钻石不足的TIPS
            -- 不足 TEXT_111015 
            local titleText_1 = UI.Text:create()
            titleText_1:init(UI.TEXT_111015,UI.FONT_STANDARD)
            titleText_1:setFontSize(18)
            titleText_1:setFontColor(UI.FONT_COLOR_59_42_12)
            titleText_1:centerUp(72)
            bg:addChild(titleText_1, 10)
            -- 是否到商店购买
            local titleText_2 = UI.Text:create()
            titleText_2:init(UI.TEXT_111016,UI.FONT_STANDARD)
            titleText_2:setFontSize(18)
            titleText_2:setFontColor(UI.FONT_COLOR_59_42_12)
            titleText_2:centerUp(102)
            bg:addChild(titleText_2, 10)
            -- 钻石图标 
            local crystal_Icon = UI.Image:create()
            crystal_Icon:init(CRYSTAL)
            crystal_Icon:leftUp(bg:getContentSize().width / 2 - titleText_1:getContentSize().width / 2 - crystal_Icon:getContentSize().width, 70)
            bg:addChild(crystal_Icon, 10)
        end
        addConfirmButton(self)
        addCancelButton(self)
        if (self._confirmButton) then

            self._confirmButton:rightUp(70,220)
            self._confirmButton:updateView()
        end
        if (self._cancelButton) then

            self._cancelButton:leftUp(70,220)
            self._cancelButton:updateView()
        end
    elseif(tipsuitype  == TipsUiType.GOLD_NOT_ENOUGH) then  -- 黄金不足的TIPS


        self._bg = bg
        bg:init(TIPS_BG_SPRITE_3)
        bg:center()
        self:addChild(bg)
        self:setSize(bg._width,bg._height)

        -- 黄金图标
        local glod_Icon = UI.Image:create()
        glod_Icon:init(GOLD_ICON)
        glod_Icon:leftUp(150,70)
        bg:addChild(glod_Icon, 10)

        -- 不足
        local titleText_1 = UI.Text:create()
        titleText_1:init(UI.TEXT_111015,UI.FONT_STANDARD)
        titleText_1:setFontSize(18)
        titleText_1:setFontColor(UI.FONT_COLOR_59_42_12)
        titleText_1:leftUp(180,70)
        bg:addChild(titleText_1, 10)

        addConfirmButton(self)
        addCancelButton(self)
        if (self._confirmButton) then

            self._confirmButton:rightUp(70,220)
            self._confirmButton:updateView()
        end
        if (self._cancelButton) then

            self._cancelButton:leftUp(70,220)
            self._cancelButton:updateView()
        end
    elseif (tipsuitype == TipsUiType.BUY_AMOUNT) then       -- 购买物品数量的TIPS


        self._bg = bg
        bg:init(TIPS_BG_SPRITE_2)
        bg:center()
        self:addChild(bg)
        self:setSize(bg._width,bg._height)

        self.valueChangedMark = false

        local function valueChanged(pSender)
        	if nil == pSender then
                self.crystalNum = self.itemDiamondAmount
                self._itemAmount = 1 -- 默认购买数量是1
        		return
        	end

            if self.valueChangedMark then
                self.valueChangedMark = false
                return
            end
        	self.valueChangedMark = true
        	local pPicker = pSender
        	local strFmt  = math.floor(pPicker:getValue() + 0.5) -- 获取数量
            -- print("strFmt",strFmt)

            self._strFmt = strFmt
            self._itemAmount = strFmt
            self.num:setText(self._strFmt) -- 滑块里面的数量

            local a  = self:getItemDiamondAmount(self._itemDiamondAmount)
            local totalPrice = strFmt* a
            -- print("---物品总价--",totalPrice)
            self.itemDiamondAmount:setText(totalPrice)
            pPicker:setValue(strFmt)
        end
        local sprite1 = cc.Sprite:createWithSpriteFrameName("ui_tips_progressbar_time_00.png") -- 黄色的滚动条
        local sprite2 = cc.Sprite:createWithSpriteFrameName("ui_tips_progressbar_time_10.png") -- 黑色背景图

        self.sprite4 = cc.Sprite:createWithSpriteFrameName("ui_tips_button_time_0.png") -- 滑块
        self.sprite4:setTag(1)

        local sprite5 = cc.Sprite:createWithSpriteFrameName("ui_tips_button_time_0.png") -- 滑块

        self.sprite3 = cc.Sprite:createWithSpriteFrameName("ui_tips_banner_number.png") -- 滑块上面的图标
        self.sprite3:setTag(2)
        self.sprite3:setPosition(cc.p(self.sprite4:getContentSize().width/2,self.sprite4:getContentSize().height +22))
        self.sprite3:setVisible(true)
        self.sprite4:addChild(self.sprite3)

        -- 滑块里面的数量
        self.num = UI.Text:create()
        self.num:init("1",UI.FONT_STANDARD)
        self.num:setFontSize(18)
        self.num:setFontColor(UI.FONT_COLOR_59_42_12)
        self.num:leftUp(30,10)
        self.sprite3:addChild(self.num)
        
        local pSlider = cc.ControlSlider:create(sprite1,sprite2,self.sprite4,sprite5) 
        pSlider:setAnchorPoint(cc.p(0.5, 0.5))
        pSlider:hasVisibleParents()
        -- 滑块右边的数字
        local rightText = UI.Text:create()
        rightText:init("",UI.FONT_STANDARD)
        rightText:rightUp(40,67)
        rightText:setFontSize(18)
        rightText:setFontColor(UI.FONT_COLOR_59_42_12)
        self.maxRightText = rightText
        bg:addChild(rightText, 10)
        pSlider:setMinimumValue(1.0) 
        -- pSlider:setMaximumValue() 
        pSlider:setPosition(cc.p(bg:getContentSize().width*0.5,bg:getContentSize().height*0.8-25))
		pSlider:setTag(1)
        self.pSlider = pSlider

        bg:addChild(pSlider, 10)

        pSlider:registerControlEventHandler(valueChanged, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)

        -- 滑块左边的数字1
        local leftText = UI.Text:create()
        leftText:init("1",UI.FONT_STANDARD)
        leftText:setFontSize(18)
        leftText:setFontColor(UI.FONT_COLOR_59_42_12)
        leftText:leftUp(40,67)
        bg:addChild(leftText, 10)
        
        --  钻石图标 
        local crystalIcon = UI.Image:create()
        crystalIcon:init()
        crystalIcon:leftUp(142,148)
        self.costTypeIcon = crystalIcon
        bg:addChild(crystalIcon, 10)

        -- 购买物品的单价
        self.crystalNum = UI.Text:create()
        self.crystalNum:init("",UI.FONT_STANDARD)
        self.crystalNum:setFontSize(18)
        self.crystalNum:setFontColor(UI.FONT_COLOR_59_42_12)
        self.crystalNum:centerUp(148)
        self.itemDiamondAmount = self.crystalNum
        bg:addChild(self.itemDiamondAmount, 10)

        addConfirmButton(self)
        addCancelButton(self)
        if (self._confirmButton) then
            -- self._confirmButton:setScale(0.9)
            self._confirmButton:rightUp(45,205)
            self._confirmButton:updateView()
        end
        if (self._cancelButton) then
            -- self._cancelButton:setScale(0.9)
            self._cancelButton:leftUp(45,205)
            self._cancelButton:updateView()
        end
    elseif (tipsuitype == TipsUiType.NORMAL_AND_PROGRESSBAR) then    
        self._bg = bg
        bg:init(TIPS_BG_SPRITE_1)
        bg:center()
        self:addChild(bg)
        self:setSize(bg._width,bg._height)

        local titletext = UI.Text:create()
        titletext:init("", "")
        titletext:setFontSize(18)
        titletext:setSize(330, 120)
        titletext:centerUp(45)
        titletext:setLineSpacing(-5)
        titletext:setTextCenter()
        titletext:setFontColor(UI.FONT_COLOR_59_42_12)
        titletext:setText(string.format("%s",self._tipsStr ))
        bg:addChild(titletext, 10)


        local proBG = cc.Sprite:createWithSpriteFrameName(TIPS_PROG_BAR_0)
        local scaleX = 212 / 100
        proBG:setScaleX(scaleX)
        proBG:setPosition(self._bg:getContentSize().width*0.5,self._bg:getContentSize().height/2 - 30)
        self._bg:addChild(proBG, 10)

        self.mPro = cc.Sprite:createWithSpriteFrameName(TIPS_PROG_BAR_1)
        self.mPro:setAnchorPoint(0, 0.5)
        self.mPro:setScaleX(scaleX)
        self.mPro:setPosition(self._bg:getContentSize().width*0.5 - 106,self._bg:getContentSize().height/2 - 30)
        self._bg:addChild(self.mPro, 10)
        
        local action = cc.Sequence:create(cc.ScaleTo:create(self._porTime, 0, 1),cc.CallFunc:create(handler(self,self.timeOutCallBack)))
        self.mPro:runAction(action)

        self.mTxtPro = UI.Text:create()
        self.mTxtPro:init(string.format("%d", self._porTime),UI.FONT_STANDARD)
        self.mTxtPro:setFontSize(18)
        self.mTxtPro:setSize(30, 30)
        self.mTxtPro:centerUp(176)
        self.mTxtPro:setFontColor(UI.FONT_COLOR_255_242_210)
        self.mTxtPro:setOutline(UI.FONT_COLOR_OUTLINE_53_42_19)
        self._bg:addChild(self.mTxtPro,100)

        self._mTime = self._porTime

        local scheduler=cc.Director:getInstance():getScheduler()
        self.mSchedulerID = scheduler:scheduleScriptFunc( handler(self,self.schedulerTimeOut) ,1,false)


        if self._tipsType == UI.TipsType.CONFIRM then
            if (tipsButtonType == UI.TipsButtonType.TEXT_BUTTON)  then 
                addImageTextToCityButton(self)
            else
                addConfirmButton(self)
            end 
            
            if (self._confirmButton) then
                self._confirmButton:centerUp(200)
                self._confirmButton:updateView()
            end

        elseif self._tipsType == UI.TipsType.CONFIRM_AND_CANCEL then
            if (tipsButtonType == UI.TipsButtonType.TEXT_BUTTON)  then 
                addImageTextToCityButton(self)
                addImageTextToTownButton(self)
            else
                addConfirmButton(self)
                addCancelButton(self)
            end 

            if (self._confirmButton) then
                -- self._confirmButton:setPositionX(0.9)
                self._confirmButton:rightUp(70,230)
                self._confirmButton:updateView()
            end
            if (self._cancelButton) then
                -- self._cancelButton:setPositionX(0.9)
                self._cancelButton:leftUp(70,230)
                self._cancelButton:updateView()
            end

        end

    elseif (tipsuitype == TipsUiType.AWARD_ITEM_UI or tipsuitype == TipsUiType.DUNGEON_SEASON_REWARD) then    -- 物品奖励的TIPS
        local bgPng = TIPS_BG_SPRITE_5
        self._bg = bg
        bg:init(bgPng)
        bg:center()
        self:addChild(bg)
        self:setSize(bg._width,bg._height)

        local titletext=  UI.Text:create()
        titletext:init(self._tipsStr, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_59_42_12)
        titletext:centerUp(25)
        bg:addChild(titletext, 10)

        if tipsuitype == TipsUiType.DUNGEON_SEASON_REWARD then
            local desctext =  UI.Text:create()
            desctext:init(self._descTips, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_59_42_12)
            desctext:rightBottom(30, 110)
            bg:addChild(desctext, 10)
        end

        addConfirmButton(self)
        if (self._confirmButton) then
                self._confirmButton:centerUp(285)
                self._confirmButton:updateView()
        end
    elseif(tipsuitype == TipsUiType.NORMAL) then            -- 通用的TIPS 
        self._bg = bg
        bg:init(TIPS_BG_SPRITE)
        bg:center()
        self:addChild(bg)
        self:setSize(bg._width,bg._height)
        
        local titleText = UI.Text:create() 
        titleText:init("", "")
        titleText:setFontSize(18)
        titleText:setFontColor(UI.FONT_COLOR_59_42_12)
        titleText:centerUp(55)
        titleText:setSize(220,100)
        titleText:setTextCenter()
        titleText:setText(string.format("%s",self._tipsStr ))
        self.titleText_Normal = titleText
        bg:addChild(titleText, 10)

        if self._tipsType == UI.TipsType.CONFIRM then
            if (tipsButtonType == UI.TipsButtonType.TEXT_BUTTON)  then 
                addImageTextToCityButton(self)
            else
                addConfirmButton(self)
            end 
            if (self._confirmButton) then
                self._confirmButton:centerBottom(50)
                self._confirmButton:updateView()
            end

        elseif self._tipsType == UI.TipsType.CONFIRM_AND_CANCEL then
            if (tipsButtonType == UI.TipsButtonType.TEXT_BUTTON)  then 
                addImageTextToCityButton(self)
                addImageTextToTownButton(self)
            else
                addConfirmButton(self)
                addCancelButton(self)
            end 

            if (self._confirmButton) then
                self._confirmButton:rightUp(70,220)
                self._confirmButton:updateView()
            end
            if (self._cancelButton) then
                self._cancelButton:leftUp(70,220)
                self._cancelButton:updateView()
            end
        end
    elseif (tipsuitype == TipsUiType.EDITBOX) then            -- 输入框tips
        self._bg = bg
        bg:init(TIPS_BG_SPRITE)
        bg:center()
        self:addChild(bg)
        self:setSize(bg._width,bg._height)
        
        local titleText = UI.Text:create() 
        titleText:init("", "")
        titleText:setFontSize(18)
        titleText:setFontColor(UI.FONT_COLOR_59_42_12)
        titleText:centerUp(20)
        titleText:setSize(220,100)
        titleText:setTextCenter()
        titleText:setText(string.format("%s",self._tipsStr))
        self.titleText_Normal = titleText
        bg:addChild(titleText, 10)

        local libIDEdit = cc.EditBox:create({width = 200, height = 25}, cc.Scale9Sprite:createWithSpriteFrameName("ui_public_placeholder.png"), cc.Scale9Sprite:createWithSpriteFrameName("ui_public_placeholder.png"), cc.Scale9Sprite:createWithSpriteFrameName("ui_public_placeholder.png"))
        libIDEdit:setFontSize(22)
        libIDEdit:setPlaceholderFontSize(14)
        libIDEdit:setPlaceHolder(UI.TEXT_111109)
        libIDEdit:setPlaceholderFontColor(UI.FONT_COLOR_222_240_254)
        libIDEdit:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
        libIDEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
        libIDEdit:setPosition(200,190)
        bg:addChild(libIDEdit, 10)
        self.libIDEdit = libIDEdit

        if self._tipsType == UI.TipsType.CONFIRM then
            if (tipsButtonType == UI.TipsButtonType.TEXT_BUTTON)  then 
                addImageTextToCityButton(self)
            else
                addConfirmButton(self)
            end 
            if (self._confirmButton) then
                self._confirmButton:centerUp(180)
                self._confirmButton:updateView()
            end

        elseif self._tipsType == UI.TipsType.CONFIRM_AND_CANCEL then
            if (tipsButtonType == UI.TipsButtonType.TEXT_BUTTON)  then 
                addImageTextToCityButton(self)
                addImageTextToTownButton(self)
            else
                addConfirmButton(self)
                addCancelButton(self)
            end 

            if (self._confirmButton) then
                self._confirmButton:rightUp(40,180)
                self._confirmButton:updateView()
            end
            if (self._cancelButton) then
                self._cancelButton:leftUp(40,180)
                self._cancelButton:updateView()
            end
        end
    elseif (tipsuitype == TipsUiType.COMMENT_TIPS) then
        self._bg = bg
        bg:init(TIPS_BG_SPRITE)
        bg:center()
        self:addChild(bg)
        self:setSize(bg._width,bg._height)
        
        local titleText = UI.Text:create() 
        titleText:init(self._tipsStr, "")
        titleText:setFontSize(UI.FONT_SIZE_22PX)
        titleText:setFontColor(UI.FONT_COLOR_59_42_12)
        titleText:centerUp(55)
        titleText:setSize(240,100)
        titleText:setTextCenter()
        bg:addChild(titleText, 10)

   
        local confirmButton = UI.Button:create()
        confirmButton:init("ui_btn_button2.png", "ui_btn_button2.png", "ui_btn_button2_3.png")
        confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, onConfirmHandler)
        confirmButton:openClickScale()
        self._bg:addChild(confirmButton, 10)
        confirmButton:setTextFont(UI.FONT_STANDARD,UI.FONT_SIZE_22PX, UI.FONT_COLOR_80_61_42)
        confirmButton:setText(UI.TEXT_1170913)

        local cancleButton = UI.Button:create()
        cancleButton:init("ui_btn_button3.png", "ui_btn_button3.png", "ui_btn_button3_3.png")
        cancleButton:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
        cancleButton:openClickScale()
        self._bg:addChild(cancleButton, 10)
        cancleButton:setTextFont(UI.FONT_STANDARD,UI.FONT_SIZE_22PX, UI.FONT_COLOR_80_61_42)
        cancleButton:setText(UI.TEXT_1170914)
        
        confirmButton:centerUp(175)
        cancleButton:centerUp(240)
    elseif (tipsuitype == TipsUiType.BIND_ACCOUNT_TIPS)  then
        print("绑定账号提示框")
        self._bg = bg
        bg:init(TIPS_BG_SPRITE)
        bg:center()
        self:addChild(bg)
        self:setSize(bg._width,bg._height)

        local titleText = UI.Text:create() 
        titleText:init(self._tipsStr, "")
        titleText:setFontSize(UI.FONT_SIZE_22PX)
        titleText:setFontColor(UI.FONT_COLOR_59_42_12)
        titleText:centerUp(25)
        titleText:setSize(240,100)
        titleText:setTextCenter()
        bg:addChild(titleText, 10)

   
         local confirmButton = UI.Button:create()
        confirmButton:init("ui_btn_button2.png", "ui_btn_button2.png", "ui_btn_button2_3.png")
        confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, onConfirmHandler)
        confirmButton:openClickScale()
        self._bg:addChild(confirmButton, 10)
        confirmButton:setTextFont(UI.FONT_STANDARD,UI.FONT_SIZE_22PX, UI.FONT_COLOR_80_61_42)
        confirmButton:setText(UI.TEXT_1170211)

        local cancleButton = UI.Button:create()
        cancleButton:init("ui_btn_button3.png", "ui_btn_button3.png", "ui_btn_button3_3.png")
        cancleButton:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
        self._bg:addChild(cancleButton, 10)
        cancleButton:setTextFont(UI.FONT_STANDARD,UI.FONT_SIZE_22PX, UI.FONT_COLOR_80_61_42)
        cancleButton:setText(UI.TEXT_110012)
        cancleButton:openClickScale()
        

        local centerButton = UI.Button:create()
        centerButton:init("ui_btn_button2.png", "ui_btn_button2.png", "ui_btn_button2_3.png")
        centerButton:addEventListener(UIEvent.BUTTON_CLICK, self, onCenterHandler)
        self._bg:addChild(centerButton, 10)
        centerButton:setTextFont(UI.FONT_STANDARD,UI.FONT_SIZE_22PX, UI.FONT_COLOR_80_61_42)
        centerButton:setText(UI.TEXT_111154)
        centerButton:openClickScale()

        
        confirmButton:centerUp(120)
        centerButton:centerUp(180)
        cancleButton:centerUp(240)
    end
    
    self:center()
    -- self:addColorBG()
end

-- 更新视图
function Tips:onUpdateView()
    print("Tips:onUpdateView")
    local tipsuitype = self._tipsuitype
    if(tipsuitype == TipsUiType.SALES_EQUIPMENT) then  -- 售卖装备获取的黄金数量
        self.glod_Amount:setText(string.format("%s",self:getGoldAmount(self._glodAmout)))
        
        self.glod_Icon:leftUp(self.titleText_2:getLeft() + self.titleText_2:getContentSize().width + 3, 89)
        self.glod_Amount:leftUp(self.glod_Icon:getLeft() + self.glod_Icon:getContentSize().width + 5, 89)

    elseif  (tipsuitype == TipsUiType.BUG_GOODS) then 
        self.diamondAmount:setText(string.format("%s",self:getDiamondAmount(self._diamondAmout)))
        self.itemName:setText(string.format("%s",self:getItemName(self._itemName)))
        if(self:getCostType(self._costType) == PublicDefine.GOODS_COST_TYPE.GOLD) then
            self.costtype:setSpriteName(GOLD_ICON)
        elseif (self:getCostType(self._costType) == PublicDefine.GOODS_COST_TYPE.GEM) then
            self.costtype:setSpriteName(CRYSTAL)
        end
        
    elseif  (tipsuitype == TipsUiType.BUY_AMOUNT) then 
        self.itemDiamondAmount:setText(string.format("%s",self._strFmt*(self:getItemDiamondAmount(self._itemDiamondAmount))))
        self.maxRightText:setText(string.format("%s",self:getMaxAmount(self._maxAmount)))
        self.pSlider:setMaximumValue(self:getMaxAmount(self._maxAmount)) 
        if(self:getCostType(self._costType) == PublicDefine.GOODS_COST_TYPE.GOLD) then
            self.costTypeIcon:setSpriteName(GOLD_ICON)
        elseif (self:getCostType(self._costType) == PublicDefine.GOODS_COST_TYPE.GEM) then
            self.costTypeIcon:setSpriteName(CRYSTAL)
        end
    elseif  (tipsuitype == TipsUiType.NORMAL) then 
        self.titleText_Normal:setText(string.format("%s",self._tipsStr ))
    elseif (tipsuitype == TipsUiType.AWARD_ITEM_UI or tipsuitype == TipsUiType.DUNGEON_SEASON_REWARD) then
         -- dump(self._awardData, "-----------self._awardData")
        local data = self._awardData 

        local beginPosX = 10
        local itemPadding = 80
        local size = #data.goods
        local width = beginPosX + size * itemPadding
        
        local rewardLayout = UI.TouchLayout:create()
        rewardLayout:init(0, 0, 0, 0)
        rewardLayout:setSize(width, 90)
        rewardLayout:addTouchEvents(self)
        -- rewardLayout:enableDebugDraw()
        if size <= 5 then 
            rewardLayout:centerUp(95)
            self:addChild(rewardLayout)
        else --滑动展示
            local taskscrollView = UI.ScrollView:create()
            taskscrollView:setSize(422,90)
            taskscrollView:init(0,0,0,0)
            taskscrollView:leftUp(37, 95)
            taskscrollView:addInnerNode(rewardLayout)
        -- taskscrollView:enableDebugDraw(UI.GREEN)
            taskscrollView:setScrollType(UI.ScrollType.HORIZONTAL)
            self.detailedScrollView = taskscrollView
            self:addChild(taskscrollView)
            taskscrollView:scrollToLeft()
        end
        for i = 1, size do
            local goodData = data.goods[i]
            local goodGrid = UI.GoodsGrid:create()
            goodGrid:init(goodData)
            goodGrid:setInfoArea(true, false)
            goodGrid:centerLeft(beginPosX)
            beginPosX = beginPosX + itemPadding
            rewardLayout:addChild(goodGrid)
            goodGrid:hideFlagIcon()
            goodGrid:showCountLabel()
            goodGrid:hideBG()
            table.insert(self.rewardItems, goodGrid)
        end
    end 
end

--更改标题
function Tips:updateTitle(str)
    if self.mTitleText then
        self._tipsStr = str
        self.mTitleText:setString(self._tipsStr)
    end
end

function Tips:updateNormalText(str)
    -- body
    if(self.titleText_Normal) then
        self.titleText_Normal:setText(str)
    end
end

function Tips:schedulerTimeOut()
    self._mTime = self._mTime - 1;
    self.mTxtPro:setText(string.format("%d", self._mTime))
    if(self._mTime <= 0) then
        local scheduler=cc.Director:getInstance():getScheduler()
        if self.mSchedulerID ~= 0 then
            scheduler:unscheduleScriptEntry(self.mSchedulerID)
        end
    end
end

--倒计时成功后处理
function Tips:timeOutCallBack()
    self:dispatchEvent(UIEvent.DIALOG_TIMEOUT)
end

-- 售卖物品所得的黄金数量
function Tips:getGoldAmount(amount)
    self._glodAmout = amount
    return self._glodAmout
end

-- 购买物品的价格
function Tips:getDiamondAmount(diamondAmount)
    self._diamondAmout = diamondAmount
    return self._diamondAmout
end

-- 购买物品的名称
function Tips:getItemName(itemName)
    self._itemName = itemName
    return self._itemName
end

-- 购买物品数量的单价
function Tips:getItemDiamondAmount(amount)
    self._itemDiamondAmount = amount
    return self._itemDiamondAmount
end

-- 返回购买物品花费的类型
function Tips:getCostType(costtype)
    self._costType = costtype
    return self._costType
end

-- 返回购买的最大数量
function Tips:getMaxAmount(maxAmount)
    self._maxAmount = maxAmount
    return self._maxAmount
end

-- 返回购买的物品数量
function Tips:getBuyItemAmount()
    return self._itemAmount
end

-- 设置奖励物品数据
-- 设置奖励物品数据
function Tips:setAwardData(awardData)
    self._awardData = awardData
    return self._awardData
end

-- --设置按钮文字
-- function Tips:setButtonText(confirmTxt,cancelTxt)
--     if self._tipsButtonType == UI.TipsButtonType.TEXT_BUTTON then
--         if self._tipsType == UI.TipsType.CONFIRM then
--             local _txt = self._confirmButton:getChildByName("text")
--             _txt:setText(confirmTxt)
--         elseif self._tipsType == UI.TipsType.CONFIRM_AND_CANCEL then
--             local _txt = self._confirmButton:getChildByName("text")
--             _txt:setText(confirmTxt)

--             local _txt = self._cancelButton:getChildByName("text")
--             _txt:setText(cancelTxt)
--         end
--     end
-- end


function Tips:getConfirmButton()
    return self._confirmButton
end

function Tips:getCancelButton()
    return self._cancelButton
end

--创建tips 直接加载TipsLayer上
function Tips:createTips(tipsStr,tipsType,tipsUiType,tipsButtonType,proTime,bAddTipsLayer)
    if tipsUiType == UI.TipsUiType.NORMAL then
        if tipsType == UI.TipsType.CONFIRM_AND_CANCEL then
            return UI.ConfirmDialog.show(tipsStr, nil, nil, nil, nil, bAddTipsLayer)
        elseif tipsType == UI.TipsType.CONFIRM then
            return UI.ConfirmDialog.showConfrimOnly(tipsStr, nil, nil, nil, bAddTipsLayer)
        end
    end

    print("Tips:createTips")
    local tips = UI.Tips:create()
    tips:init(tipsType,tipsUiType,tipsStr,tipsButtonType,proTime)
    tips:center()
    if(bAddTipsLayer == nil or bAddTipsLayer == true) then
        require "app.ui.tips.TipsLayer"
        UI.TipsLayer:addTips(tips)
    end
    return tips
end

function Tips:onTouchBegan(touch, event)
    -- print("--------------------------QuickExpressionLayer onTouchBegan")
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    --检查是否在可点击区域 奖励滑动区域
    if self.detailedScrollView ~= nil and not AvalonUtil:isRectContainsPoint(self.detailedScrollView, location) then
        return
    end 

    for k, value in ipairs(self.rewardItems) do
        if AvalonUtil:isRectContainsPoint(value, location) then
            self.selectIndex = k
            break
        end
    end
end

function Tips:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    --检查是否在可点击区域 奖励滑动区域
    if self.detailedScrollView ~= nil and not AvalonUtil:isRectContainsPoint(self.detailedScrollView, location) then
        return
    end

    for k, value in ipairs(self.rewardItems) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
            value:onShowInfoAreaHandler(false, true)
            break
        end
    end
end

function Tips:addTouchOutsideHandler(func)
    self._touchOutsideHandler = func
end

function Tips:setJustShowOk(isJustShowOk)
    if isJustShowOk then
        self._confirmButton:centerUp(self._confirmButton:getUp())
        self._cancelButton:hide()
        self._cancelButton:disable()
    end
end


