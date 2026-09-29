-- GuildBoxCell.lua
-- Author:CMonk
-- 2019年04月09日

require "app.ui.common.Text"
require "utils.AvalonUtil"
require "app.datas.GuildBoxDataManager"

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local GuildBoxCell = class("GuildBoxCell", UI.TableViewCell)
UI.GuildBoxCell = GuildBoxCell

GuildBoxCell.CELL_WIDTH = 490
GuildBoxCell.CELL_HEIGHT = 112

GuildBoxCell.CB_OPENBOX = 1
GuildBoxCell.CB_OPENBOX_ANIMATION_DONE = 2

local BOX_FRAME_FULL_PROGRESS_WIDTH = 460
local BOX_FRAME_FULL_PROGRESS_HEIGHT = 77

function GuildBoxCell:updateOncePerSecond()
    self:updateCountDown()
end

function GuildBoxCell:ctor(parentTable)
    GuildBoxCell.super.ctor(self)

    self._parentTable = parentTable
    self:onInitView()

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateOncePerSecond), 1, false)
end

function GuildBoxCell:dtor()
    GuildBoxCell.super.dtor(self)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function GuildBoxCell:onInitView()
    -- 内容运载层
    self._rootLayer = UI.Layout:create()
    self._rootLayer:init()
    self._rootLayer:setSize(UI.GuildBoxCell.CELL_WIDTH, UI.GuildBoxCell.CELL_HEIGHT)
    self._rootLayer:leftBottom(0, 0)
    self._rootLayer:setTouchEnable(true)
    self._rootLayer:setSwallowTouches(false)
    self._rootLayer:setTouchClipNode(self._parentTable)
    self._rootLayer:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        if (self._lastReuqestOpenBoxTime == nil or os.time() - self._lastReuqestOpenBoxTime >= 1) then
            self._lastReuqestOpenBoxTime = os.time()
            if (not GuildBoxDataManager:checkNotifyIsAbleToOpenBox()) then return end
            if (self._data and not self._data.isDroped) then
                if (self._clickCB) then self._clickCB(UI.GuildBoxCell.CB_OPENBOX) end
                if (self._clickCB) then self._clickCB(UI.GuildBoxCell.CB_OPENBOX_ANIMATION_DONE, self._boxIcon) end
                self:playOpenBoxAnimation()
            end
        end
    end)
    self:addChild(self._rootLayer)

    -- 背景框排版
    local contentFrameLayout = UI.Layout:create()
    contentFrameLayout:init()
    contentFrameLayout:center()
    self._rootLayer:addChild(contentFrameLayout)

    -- 底板
    local contentBg = UI.Image9:create()
    contentBg:init("ui_scale9image_bg_bar.png", CCRectMake(0,0,4,4), cc.size(BOX_FRAME_FULL_PROGRESS_WIDTH, BOX_FRAME_FULL_PROGRESS_HEIGHT))
    contentBg:centerLeft(11)
    contentFrameLayout:addChild(contentBg)

    -- 进度条
    self._progressBg = UI.Image9:create()
    self._progressBg:init("ui_scale9image_copper_bar.png", CCRectMake(0,0,4,4), cc.size(BOX_FRAME_FULL_PROGRESS_WIDTH * 0.5, BOX_FRAME_FULL_PROGRESS_HEIGHT))
    self._progressBg:centerRight(11)
    contentFrameLayout:addChild(self._progressBg)

    -- 背景大框
    self._bgFrame = UI.Image:create()
    self._bgFrame:init("ui_guild_giftbag_copper_box.png")
    self._bgFrame:center()
    contentFrameLayout:addChild(self._bgFrame)
    contentFrameLayout:setSize(self._bgFrame:getSize())

    -- 阴影遮罩
    local frameShadow = UI.Image:create()
    frameShadow:init("ui_guild_giftbag_bar_up.png")
    frameShadow:center()
    contentFrameLayout:addChild(frameShadow)

    -- 内容排版
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(BOX_FRAME_FULL_PROGRESS_WIDTH, BOX_FRAME_FULL_PROGRESS_HEIGHT)
    contentLayout:center()
    contentFrameLayout:addChild(contentLayout)

    -- 宝箱小框
    self._boxFrame = UI.Image:create()
    self._boxFrame:init("ui_guild_giftbag_copper_box_quality.png")
    self._boxFrame:center(-193, 0)
    contentLayout:addChild(self._boxFrame)

    -- 宝箱图标
    self._boxIcon = UI.Button:create()
    self._boxIcon:init("ui_guild_giftbag_icon_1.png")
    self._boxIcon:setSwallowTouches(false)
    self._boxIcon:center()
    self._boxFrame:addChild(self._boxIcon)

    -- 物品框
    self._boxDropItem = UI.GoodsGrid:create()
    self._boxDropItem:init()
    self._boxDropItem:center()
    self._boxDropItem:setTouchEnable(true)
    self._boxDropItem:setSwallowTouches(false)
    self._boxDropItem:setTouchClipNode(self._parentTable)
    self._boxFrame:addChild(self._boxDropItem)

    -- 宝箱名字
    self._boxName = UI.Text:create()
    self._boxName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    self._boxName:leftUp(90, 2)
    contentLayout:addChild(self._boxName)

    -- 宝箱经验文字
    self._pointText = UI.Text:create()
    self._pointText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    self._pointText:leftUp(90, 29)
    contentLayout:addChild(self._pointText)

    -- 贡献人排版
    local contributorLayout = UI.Layout:create()
    contributorLayout:init()
    contributorLayout:enableAutoWidth()
    contributorLayout:enableAutoHeight()
    contributorLayout:leftBottom(90, 4)
    contentLayout:addChild(contributorLayout)

    -- 贡献人标签
    local contentStr = string.format(LanguageManager:getInstance():getLocalString(1112120), "")
    contentStr = contentStr:gsub(" ", "")
    local contributorLabl = UI.Text:create()
    contributorLabl:init(contentStr, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    contributorLabl:floatLeft(0)
    contributorLayout:addComponent(contributorLabl)

    -- 贡献人
    self._contributorName = UI.Text:create()
    self._contributorName:init("", UI.SYS_FONT, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    self._contributorName:floatLeft(3)
    contributorLayout:addComponent(self._contributorName)
    
    -- 限制时间
    local timeString = AvalonUtil:_getFullFormatTime(100, true)
    self._timeLabel = UI.Text:create()
    self._timeLabel:init(timeString, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    self._timeLabel:rightUp(8, 5)
    contentLayout:addChild(self._timeLabel)
    self:updateCountDown()

    -- 完成状态勾勾
    self._dropIcon = UI.Image:create()
    self._dropIcon:init("ui_btn_choice_1.png")
    self._dropIcon:rightBottom(0, 0)
    contentLayout:addChild(self._dropIcon)
end

-- 更新计时器
function GuildBoxCell:updateCountDown()
    if (self._data) then
        local timeNow = GameManager:getNormalServerTime()

        -- 更新背景进度
        if (self._endTimeStamp and self._endTimeStamp ~= 0 and timeNow <= self._endTimeStamp and self._fullDisplayDuration) then
            local remainingTime = self._endTimeStamp - timeNow
            local progress = remainingTime / self._fullDisplayDuration
            if (progress > 1) then progress = 1 end
            if (progress < 0) then progress = 0 end
            self._progressBg:show()
            self._progressBg:setSize(BOX_FRAME_FULL_PROGRESS_WIDTH * progress, BOX_FRAME_FULL_PROGRESS_HEIGHT)  
        else
            self._progressBg:hide()
        end

        -- 更新时间文字
        if (self._endTimeStamp and self._endTimeStamp ~= 0) then
            self._timeLabel:show()
            local remainingTime = self._endTimeStamp - timeNow
            if (remainingTime < 0) then remainingTime = 0 end
            local timeString = AvalonUtil:_getFullFormatTime(remainingTime, true)
            self._timeLabel:setText(timeString)
        else
            self._timeLabel:hide()
        end    
    end
    
    return true
end

function GuildBoxCell:getDummyItemData(id)
    require "app.datas.GoodsDataManager"
    local goodData = GoodsDataManager:createLocalGoodsData(id) --23030001
    if goodData then
        goodData:setNum(0)
        goodData:setIsNew(false)
        goodData.isHaveGet = false
    end
    return goodData
end

-- 播放开箱动画
function GuildBoxCell:playOpenBoxAnimation(cb)
    self._openAnimationCB = cb

    -- 向后过后, 向前滚动
    local rotateBackAction = cc.RotateTo:create(0.1, 30)
    local easeBackAction = cc.EaseOut:create(rotateBackAction, 3)
    local rotateForwardAction = cc.RotateTo:create(0.2, -1440)
    local easeForwardAction = cc.EaseIn:create(rotateForwardAction, 5)

    -- 延迟缩小
    local delayScaleAction = cc.DelayTime:create(0.2)
    local scaleAction = cc.ScaleTo:create(0.1, 0)

    -- 回调
    local cbAction = cc.CallFunc:create(function() 
        if (self._openAnimationCB) then 
            self._openAnimationCB() 
            self._openAnimationCB = nil
        end 
    end)

    -- 执行动画
    self._boxFrame:runAction(cc.Sequence:create(delayScaleAction, scaleAction))
    self._boxFrame:runAction(cc.Sequence:create(easeBackAction, easeForwardAction, cbAction))
    Avalon.AudioManager:playSoundDelay("1517", 70)
end

-- 播放新动画
function GuildBoxCell:playBoxNewContentAnimation()
    -- 初始状态
    self._boxFrame:setScale(0)

    -- 滚动动画
    local rotateForwardAction = cc.RotateTo:create(0.2, 720)
    local easeForwardAction = cc.EaseIn:create(rotateForwardAction, 5)
    local rotatePassAction = cc.RotateBy:create(0.1, 30)
    local easePassAction = cc.EaseOut:create(rotatePassAction, 5)
    local rotateBackAction = cc.RotateBy:create(0.1, -30)
    local easeBackAction = cc.EaseIn:create(rotateBackAction, 3)
    local rotateSequence = cc.Sequence:create(easeForwardAction, easePassAction, easeBackAction)

    -- 放大动画
    local scaleAction = cc.ScaleTo:create(0.2, 1)

    -- 执行动画
    self._boxFrame:runAction(cc.Sequence:create(scaleAction))
    self._boxFrame:runAction(cc.Sequence:create(rotateSequence))
end

-- 停止所有动画
function GuildBoxCell:resetAllAnimations()
    self._boxFrame:stopAllActions()
    self._boxFrame:rotate(0)
    self._boxFrame:setScale(1)
    if (self._openAnimationCB) then
        self._openAnimationCB()
        self._openAnimationCB = nil
    end
end









-------------SevenDayLayer 接口--------------
function GuildBoxCell:reset()
    self:resetAllAnimations()
end

function GuildBoxCell:setClickCallback(cb)
    self._clickCB = cb
end

function GuildBoxCell:updateData(data)
    self._data = data

    if (self._data) then
        self:resetAllAnimations()

        -- 更新结束时间戳
        local expiration = self._data.expiration
        if (expiration) then
            self._endTimeStamp = expiration
        end
        local fullDisplayDuration = self._data.timeLimit
        if (fullDisplayDuration) then
            self._fullDisplayDuration = fullDisplayDuration
        end
        if (not self:updateCountDown()) then return end

        -- 更新边框
        local isDropped = self._data.isDroped
        local frameNum = tonumber(self._data.frame)
        if (frameNum) then
            if (frameNum == 1) then
                self._boxFrame:setSpriteName("ui_guild_giftbag_copper_box_quality.png")
                self._bgFrame:setSpriteName("ui_guild_giftbag_copper_box.png")
                self._progressBg:setSpriteName("ui_scale9image_copper_bar.png")
            elseif (frameNum == 2) then
                self._boxFrame:setSpriteName("ui_guild_giftbag_silver_box_quality.png")
                self._bgFrame:setSpriteName("ui_guild_giftbag_silver_box.png")
                self._progressBg:setSpriteName("ui_scale9image_silver_bar.png")
            elseif (frameNum == 3) then
                self._boxFrame:setSpriteName("ui_guild_giftbag_gold_box_quality.png")
                self._bgFrame:setSpriteName("ui_guild_giftbag_gold_box.png")
                self._progressBg:setSpriteName("ui_scale9image_gold_bar.png")
            end
        end

        -- 更新图标
        if (not isDropped) then
            -- 没有领取就显示宝箱图标
            self._boxDropItem:hide()
            self._boxIcon:show()
            local boxIcon = self._data.icon
            if (boxIcon) then
                self._boxIcon:setNormal(boxIcon)
            end
        else
            -- 领取了就显示道具
            local goodsID = self._data.goodsID
            if (goodsID) then
                local goodData = self:getDummyItemData(goodsID)
                if (goodData) then
                    local num = self._data.goodsNum or 0
                    goodData:setNum(num)
                    self._boxIcon:hide()
                    self._boxDropItem:show()
                    self._boxDropItem:reset()
                    self._boxDropItem:setData(goodData)
                    self._boxDropItem:hideNewIcon()
                    self._boxDropItem:hideBG()
                    self._boxDropItem:hideRare()
                    self._boxDropItem:showInfoArea(true)
                    if (num <= 1) then
                        self._boxDropItem:hideCountLabel()
                    else
                        self._boxDropItem:showCountLabel()
                    end
                end
            end
        end

        -- 更新经验显示
        local point = tonumber(self._data.pointValue)
        if (point and isDropped) then
            self._pointText:show()
            self._pointText:setText(string.format(LanguageManager:getInstance():getLocalString(1112119)--[["宝箱点数 x%s"]], point))
        else
            self._pointText:hide()
        end

        -- 更新名字
        local boxName = self._data.boxName
        if (boxName) then
            self._boxName:setText(LanguageManager:getInstance():getLocalString(boxName))
        end

        -- 更新来源名
        local contributor = tostring(self._data.contributor)
        if (contributor) then
            self._contributorName:setText(contributor)
        end

        -- 更新完成状态
        if (isDropped) then
            self._dropIcon:show()
        else
            self._dropIcon:hide()
        end

        -- 检查是否新打开
        local isNewOpen = self._data.isNewOpen
        if (isNewOpen) then
            self._data.isNewOpen = false
            self:playBoxNewContentAnimation()
        end
    end
end