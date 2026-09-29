-- DreamResultLayer.lua
-- Author:CMonk
-- 2019年03月06日
-- Using:梦境 战斗结束结算

local LanguageManager = require("app.game.LanguageManager")
require("utils.AvalonUtil")
require("app.datas.MasterDataManager")

UI = UI or {}
local DreamResultLayer = class("DreamResultLayer", UI.HWBtnComponent)
UI.DreamResultLayer = DreamResultLayer
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_dream_settlement.plist",
    "ui_town_dream_common.plist",
    "ui_town_dreamword.plist",
    "ui_common_symbol.plist",
    "ui_general_big_number.plist",
}

--构造函数(必备)
function DreamResultLayer:ctor()
    --窗口大小
    DreamResultLayer.super.ctor(
        self, UIType.DREAM_RESULT_LAYER,
        COM_RES_LIST,
        winSize.width,    
        winSize.height
    )

    self.isPhase = MasterDataManager:getJumpTempData() ~= nil
    self:init()
    self:registerListener()
    GameManager:disableMovingHandler()
end

--虚构函数,destroy时调用(必备)
function DreamResultLayer:dtor()
    DreamResultLayer.super.dtor(self)
    self:unRegisterListener()
    Avalon.Scheduler:unscheduleUpdate(self, self.skip)
    GameManager:enableMovingHandler() 
    -- reload_script_file("app.ui.dream.DreamResultLayer")
end

-- 初始化(必备)
function DreamResultLayer:init()
    DreamResultLayer.super.init(self)

    -- 初始出现延迟
    local bossIdx = MasterDataManager:getKilledBossIdx() or 1
    local scriptTime = 0
    if (bossIdx == 1) then
        scriptTime = 6
    elseif (bossIdx == 2) then
        scriptTime = 6
    elseif (bossIdx == 3) then
        scriptTime = 6
    elseif (bossIdx == 4) then
        scriptTime = 6
    elseif (bossIdx == 5) then
        scriptTime = 6
    elseif (bossIdx == 6) then
        scriptTime = 6
    end

    performWithDelay(self, function()
        self:showStartUp()
    end, scriptTime)

    -- Victory过后的信息展示界面开始
    scriptTime = scriptTime + 0.7
    performWithDelay(self, function()
        self:showSecondaryContentFadeIn()
    end, scriptTime)

    -- 数据滚动
    scriptTime = scriptTime + 0.35
    performWithDelay(self, function()
        self:showRunningData(0.7)
    end, scriptTime)

    -- 展示回城按钮
    scriptTime = scriptTime + 1.2
    performWithDelay(self, function()
        self:showReturnBtn()
    end, scriptTime)
end

-- 模版函数：初始化组建的视图(必备)
function DreamResultLayer:onInitView()
    local dreamData = MasterDataManager:getDreamData()

    -- 点击外部检测节点
    local clickOutsideDetector = UI.Component:create()
    clickOutsideDetector:init()
    clickOutsideDetector:center(0, -15)
    clickOutsideDetector:setTouchEnable(true)
    clickOutsideDetector:setInterceptTouches(true)
    clickOutsideDetector:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE_ENDED, self, self.handleClose)
    clickOutsideDetector:setSize(700, 430)
    self:addChild(clickOutsideDetector)

    -- 运载层
    self.rootLayer = UI.Component:create()
    self.rootLayer:init()
    self.rootLayer:setSize(winSize.width, winSize.height)
    self.rootLayer:center()
    self:addChild(self.rootLayer)

    -- 背景灰色层
    self.bgLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 200))
    self.bgLayer:setContentSize(winSize.width, winSize.height)
    self.bgLayer:setPosition(cc.p(0,0))
    self.rootLayer:addChild(self.bgLayer)

    -- 内容层
    self.contentLayer = UI.Component:create()
    self.contentLayer:init()
    self.contentLayer:setSize(1136, 640)
    self.contentLayer:center()
    self.rootLayer:addChild(self.contentLayer)

    -- 动画背景
    self.background = UI.Animation:create()
    self.background:init("effect_ui_town_dreamword_settlement.json", "effect_ui_town_dreamword_settlement.atlas")
    self.background:setSize(1136, 640)
    self.background:center()
    self.contentLayer:addChild(self.background)

    -- 信息内容, 包括按钮
    self.infoLayout = UI.Layout:create()
    self.infoLayout:init()
    self.infoLayout:center(-70, 0)
    self.infoLayout:setSize(1136, 640)
    self.background:addComponent("settlement", self.infoLayout)

    -- 文字内容(和按钮分离, 固定缩放中心点)
    self.textLayout = UI.Layout:create()
    self.textLayout:init()
    self.textLayout:center(65, -3)
    self.textLayout:hide()
    self.infoLayout:addChild(self.textLayout)

    -- 梦境等级标签
    local dreamLvLabel = UI.Text:create()
    dreamLvLabel:init(LanguageManager:getInstance():getLocalString(1111775), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_224_115) --"梦境等级"
    dreamLvLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -2))
    dreamLvLabel:rightBottom(-16, 18)
    self.textLayout:addChild(dreamLvLabel)

    -- 梦境LV排版
    self.dreamLvLayout = UI.Layout:create()
    self.dreamLvLayout:init()
    self.dreamLvLayout:center(45, -34)
    self.textLayout:addChild(self.dreamLvLayout)

    -- 梦境等级LV图标
    local dreamLvIcon = UI.Image:create()
    dreamLvIcon:init("ui_home_banner_lv.png")
    dreamLvIcon:centerLeft(-24, 2)
    self.dreamLvLayout:addChild(dreamLvIcon)

    -- 梦境等级数字
    -- self.styleNum = AvalonUtil:getStyledNumberNode(MasterDataManager:getDreamResultLv())
    if self.isPhase then
        self.styleNum = AvalonUtil:getStyledNumberNode(MasterDataManager:getJumpTempData().dreamLv)
    else
        self.styleNum = AvalonUtil:getStyledNumberNode(dreamData.lv)
    end
    self.styleNum:centerLeft(0, 2)
    self.dreamLvLayout:addChild(self.styleNum)

    if self.isPhase and MasterDataManager:getJumpTempData().dreamCurBossIndex == #dreamData.jump.bossInfos then
        dreamLvLabel:hide()

        dreamLvIcon:centerLeft(-16, 2)
        local posX = dreamLvIcon:getContentSize().width - 16
        self.styleNum:centerLeft(posX, 2)

        self.styleNumOther = AvalonUtil:getStyledNumberNode(MasterDataManager:getJumpTempData().oldLv)
        self.styleNumOther:centerRight(45, 2)
        self.dreamLvLayout:addChild(self.styleNumOther)
        local posX = self.styleNumOther:getContentSize().width + 45

        local dreamLvIconOther = UI.Image:create()
        dreamLvIconOther:init("ui_home_banner_lv.png")
        dreamLvIconOther:centerRight(posX, 2)
        self.dreamLvLayout:addChild(dreamLvIconOther)

        local arrowImg = UI.Image:create()
        arrowImg:init("ui_dreamword_settlement_arrow.png")
        arrowImg:centerLeft(-40, 0)
        self.dreamLvLayout:addChild(arrowImg)
    end

    -- 梦境碎片背景
    local chipBg = UI.Image:create()
    chipBg:init("ui_dreamword_goods_bg2.png")
    chipBg:center(0, 16)
    self.textLayout:addChild(chipBg)

    if self.isPhase then
        -- 梦境越阶挑战进度
        self.dreamDesc = UI.Text:create()
        self.dreamDesc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_236_213_153)
        self.dreamDesc:leftBottom(54, 6)
        chipBg:addChild(self.dreamDesc)
        if MasterDataManager:getJumpTempData().dreamCurBossIndex == #dreamData.jump.bossInfos then
            self.dreamDesc:setText(UI.TEXT_1324304)
        else
            self.dreamDesc:setText(string.format(UI.TEXT_1324303, MasterDataManager:getJumpTempData().dreamCurBossIndex, #dreamData.jump.bossInfos))
        end
    else
        -- 梦境碎片图标
        local chipIcon = UI.Image:create()
        chipIcon:init("symbol_dreamword.png")
        chipIcon:center(-34, 14)
        chipBg:addChild(chipIcon)

        -- 梦境碎片数量
        self.dreamChipNum = UI.Text:create()
        self.dreamChipNum:init("+0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_236_213_153)
        self.dreamChipNum:leftBottom(88, 6)
        chipBg:addChild(self.dreamChipNum)
    end

    -- 按钮
    self.confirmButton = UI.Button:create()
    self.confirmButton:init("ui_dreamword_settlement_btn_0.png","ui_dreamword_settlement_btn_1.png","ui_dreamword_settlement_btn_2.png")
    self.confirmButton:leftBottom(534, 240)
    self.confirmButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self.confirmButton:setText(LanguageManager:getInstance():getLocalString(1110162)) --"返回城镇"
    self.confirmButton:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        -- 清理结算暂存的数据
        MasterDataManager:clearJumpTempData()
        local SceneManager = require("app.game.SceneManager")
        SceneManager:getInstance():leaveWaiting()
    end)
    self.confirmButton:hide()
    self.infoLayout:addChild(self.confirmButton)

    -- boss图标宿主, 和背景一个大小
    self.bossIconBgLayout = UI.Layout:create()
    self.bossIconBgLayout:init()
    self.bossIconBgLayout:center(20, 1)
    self.bossIconBgLayout:hide()
    self.background:addComponent("dreamword01", self.bossIconBgLayout)

    -- boss图标背景火焰
    self.bossIconBgAni = UI.Animation:create()
    self.bossIconBgAni:init("effect_ui_dreamword_down.json", "effect_ui_dreamword_down.atlas")
    self.bossIconBgAni:center(-14)
    self.bossIconBgLayout:addChild(self.bossIconBgAni)

    -- boss图标背景
    local bossIdx = MasterDataManager:getKilledBossIdx() or 1
    if self.isPhase then
        bossIdx = MasterDataManager:getJumpTempData().dreamCurBossIndex
    end
    local bossIconBg = UI.Image:create()
    bossIconBg:init("ui_dreamword_click_box2.png")
    bossIconBg:leftBottom(0, 0)
    self.bossIconBgLayout:addChild(bossIconBg)
    self.bossIconBgLayout:setSize(bossIconBg:getSize())

    -- boss图标
    local bossIcon = UI.Image:create()
    bossIcon:init(string.format("ui_dreamword_click_boss_%d.png", bossIdx))
    bossIcon:leftBottom(18, 9)
    bossIconBg:addChild(bossIcon)

    -- boss文字位置
    local NAME_POS_BOTTOM = {65, 23, 28, 32, 28, 27}
    local currentNamePos = NAME_POS_BOTTOM[bossIdx] or 0
    local bossText = UI.Image:create()
    bossText:init(string.format("ui_dreamword_normal_%d.png", bossIdx))
    bossText:centerBottom(currentNamePos)
    bossIconBg:addChild(bossText)

    self:setRootShow(false, false)
end

-- 模版函数：更新组建的视图(必备)
function DreamResultLayer:onUpdateView()

end

-- 根据BOSS不同做延迟
function DreamResultLayer:showStartUp()
    self:setRootShow(true)
    if self.isPhase then
        self.background:setAnimation("begin2", false)
        self.background:addAnimation("idle2", true)
    else
        self.background:setAnimation("begin", false)
        self.background:addAnimation("idle", true)
    end
    Avalon.AudioManager:playSound("1543", false)
end

-- Victory后的数据展现
function DreamResultLayer:showSecondaryContentFadeIn()
    self.bossIconBgLayout:show()
    self.bossIconBgLayout:setOpacity(0)
    self.textLayout:setOpacity(0)
    self.bossIconBgLayout:runAction(cc.FadeIn:create(0.5))
    self.textLayout:runAction(cc.FadeIn:create(0.5))
    if self.isPhase then
        self.bossIconBgAni:setAnimation("begin2", false)
        self.bossIconBgAni:addAnimation("idle2", true)
    else
        self.bossIconBgAni:setAnimation("begin", false)
        self.bossIconBgAni:addAnimation("idle", true)
    end
    self.dreamLvLayout:setScale(1.2)

    performWithDelay(self, function()
        self.textLayout:show()
        self.textLayout:setScale(0)
        self.textLayout:runAction(cc.ScaleTo:create(0.07, 1.4))
    end, 0.3)

    performWithDelay(self, function() 
        self.dreamLvLayout:runAction(cc.ScaleTo:create(0.08, 1))
    end, 0.37)
end

-- 数据出现和跑动
function DreamResultLayer:showRunningData(duration)
    if self.isPhase then
        return
    end
    -- local targetChip = 5555
    duration = duration * 1000
    local targetChip = MasterDataManager:getDreamResultChip()
    local targetTime = AvalonUtil.getCurrentTime() + duration
    local changeFrameTime = 0.07
    function loopShowData()
        local timeNow = AvalonUtil.getCurrentTime()
        local progress = (duration - (targetTime - timeNow)) / duration
        if (progress > 1) then progress = 1 end
        if (progress < 0) then progress = 0 end
        self.dreamChipNum:setText("+" .. tostring(math.floor(progress * targetChip)))
        self.dreamChipNum:setScale(1.4)
        self.dreamChipNum:runAction(cc.EaseIn:create(cc.ScaleTo:create(changeFrameTime, 1), 1))
        if (progress < 1) then
            performWithDelay(self, loopShowData, changeFrameTime)
        end
    end
    if (targetChip > 0) then
        loopShowData()
    end
end

-- 回城按钮出现
function DreamResultLayer:showReturnBtn()
    self.textLayout:runAction(cc.MoveBy:create(0.1, cc.p(0, 25)))
    self.textLayout:runAction(cc.ScaleTo:create(0.1, 1))
    self.confirmButton:show()
    self.confirmButton:setScale(0)
    local big = cc.EaseOut:create(cc.ScaleTo:create(0.10, 1.1), 2)
    local small = cc.EaseIn:create(cc.ScaleTo:create(0.07, 1), 2)
    self.confirmButton:runAction(cc.Sequence:create(big, small))
    self.confirmButton:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.MoveBy:create(0.07, cc.p(0, 5))))
end

-- 展示或隐藏界面
function DreamResultLayer:setRootShow(b, isAnimated)
    if (not self.rootLayer) then return end
    if (isAnimated == nil) then isAnimated = true end
    local animationDuration = 0.3

    if (b) then
        self.rootLayer:leftBottom(0, 0)
        self.rootLayer:show()
        if (isAnimated) then
            self.rootLayer:setOpacity(0)
            self.rootLayer:runAction(cc.FadeIn:create(animationDuration))
        end
        -- self._canClose = true
    else
        function doHide()
            if (not self.rootLayer) then return end
            self.rootLayer:leftBottom(-winSize.width, -winSize.height)
            self.rootLayer:hide()
        end

        if (isAnimated) then
            self.rootLayer:runAction(cc.Sequence:create(
                cc.FadeOut:create(animationDuration), 
                cc.CallFunc:create(function()
                    doHide()
                end)))
        else
            doHide()
        end
        -- self._canClose = false
    end
end






------------------------------ 事件 --------------------------------
-- 处理确认按钮点击
function DreamResultLayer:onConfirmClick()

end

-- 关闭页面
function DreamResultLayer:handleClose()
    if (not self._canClose) then
        return
    end

    if self._closeCallBack then
        self._closeCallBack()
    end
    self:close()
end

-- 请求获取奖励回调
function DreamResultLayer:openRequestCallback(data)
    printInfo("DreamResultLayer:openRequestCallback()")
    dump(data)
end

-- 注册监听事件(可选)
function DreamResultLayer:registerListener()
    --大秘境结算界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_DUNGEON_END_REWARD_SHOW, self, self.openRequestCallback)
end

-- 注销监听事件(可选)
function DreamResultLayer:unRegisterListener()
    -- 大秘境结算界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_DUNGEON_END_REWARD_SHOW, self, self.openRequestCallback)
end
------------------------------ eo 事件 --------------------------------
