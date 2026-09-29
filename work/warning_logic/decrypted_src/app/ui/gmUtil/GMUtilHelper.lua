--[[
    测试工具 帮助模块 2017/11/30
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.datas.PublicDefine"
require "app.ui.UIDefine"
require "app.ui.common.ControlSwitch"
require "app.ui.common.Dialog.ScrollBar"
require "app.ui.gmUtil.control.GMUtilTextS9"
require "app.ui.gmUtil.control.GMUtilDropDownList"
local GMUtilConfig = require("app.ui.gmUtil.GMUtilConfig")
local SceneManager = require("app.game.SceneManager")
local LatSim = require("app.ui.gmUtil.GMUtilLatencySimulator")
local MapHelper = require("app.mapkit.MapHelper")
local gameLoginManager = require("app.game.GameLoginManager")


-- 引用UI命名空间
UI = UI or {}

-- 模块声明， 素子
local GMUtilHelper = UI.GMUtilHelper or class("GMUtilHelper")
UI.GMUtilHelper = GMUtilHelper

-- 私有变量
local winSize = cc.Director:getInstance():getWinSize()
---------------------------------------
-- eo 模块初始化 --







-- 资源统合 --
---------------------------------------
---------------------------------------
-- eo 资源统合 --









-- 布局 --
---------------------------------------
-- -- 设计尺寸
-- -- 引用GMUtil公用设置
-- GMUtilConfig.LAYOUT_DESIGN_WIDTH = 1024
-- GMUtilConfig.LAYOUT_DESIGN_HEIGHT = 640
-- GMUtilConfig.LAYOUT_TAB_CONTENT_HEIGHT = 568

-- -- 大大大大行行高
-- GMUtilConfig.LAYOUT_H_XXXLARGE_70 = 70
-- -- 大大大行行高
-- GMUtilConfig.LAYOUT_H_XXLARGE_60 = 60
-- -- 大大行行高
-- GMUtilConfig.LAYOUT_H_XLARGE_50 = 50
-- -- 大行行高
-- GMUtilConfig.LAYOUT_H_LARGE_40 = 40
-- -- 中行行高
-- GMUtilConfig.LAYOUT_H_MEDIUM_30 = 30
-- -- 小行行高
-- GMUtilConfig.LAYOUT_H_SMALL_20 = 20

-- 组件z序 --
---------------------
---------------------------------------
-- eo 整体布局 --









-- 程序逻辑 --
---------------------------------------

------------------帮助排版-------------------
-- 弹出一个提示确认取消提示
function GMUtilHelper:showConfirm(text, confirm)
    assert(type(text) == "string")
    assert(type(confirm) == "function" or confirm == nil)

    local tips = UI.Tips:createTips(text,UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL)
    if (confirm) then tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips, confirm) end
end

-- 弹出一个提示确认取消提示
function GMUtilHelper:showConfirmCancel(text, confirm, cancel)
    assert(type(text) == "string")
    assert(type(confirm) == "function" or confirm == nil)
    assert(type(cancel) == "function" or cancel == nil)

    local tips = UI.Tips:createTips(text,UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
    if (confirm) then tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips, confirm) end
    if (cancel) then tips:addEventListener(UIEvent.DIALOG_CANCEL, tips, cancel) end
end

-- 返回一个开关
function GMUtilHelper:getSwitch(textList, width, default, onSwitch, height, fontSz)
    assert(type(textList) == "table")
    assert(type(width) == "number" and width > 0)
    assert(type(default) == "number" or default == nil)
    assert(type(onSwitch) == "function" or onSwitch == nil)
    default = default or 1
    height = height or GMUtilConfig.LAYOUT_SWITCH_HEIGHT
    fontSz = fontSz or height + GMUtilConfig.LAYOUT_SWITCH_FNT_SZ_OFFSET

    local labelList = {}
    for i = 1,#textList do
        local label = cc.Label:createWithSystemFont(
            textList[i], 
            GMUtilConfig.LAYOUT_SWITCH_FNT, 
            fontSz)
        label:setTextColor(GMUtilConfig.LAYOUT_SWITCH_FNT_COLOR)
        table.insert(labelList, label)
    end
    local maskSprite = cc.Scale9Sprite:createWithSpriteFrameName(GMUtilConfig.SPRITE_SWITCH_BG)
    local thumbSprite = cc.Sprite:createWithSpriteFrameName(GMUtilConfig.SPRITE_SWITCH_BTN)

    local pControlSwitch = UI.ControlSwitch:create()
    pControlSwitch:init(maskSprite, thumbSprite, labelList, width, height)
    pControlSwitch:setValue(default)
    pControlSwitch:addEventListener(UIEvent.CONTROL_SWITCH_TOUCH, pControlSwitch, function(obj, num, oldNum)
        if (onSwitch) then onSwitch(obj, num, oldNum) end
    end)

    return pControlSwitch
end

-- 返回一个下拉菜单
function GMUtilHelper:getDropDown(text, width, data, direction, showNum)
    assert(type(text) == "string")
    assert(type(width) == "number" and width > 0)
    assert(type(data) == "table")
    if (direction == GMUtilConfig.DIRECTION.UP) then direction = 1
    elseif (direction == GMUtilConfig.DIRECTION.DOWN) then direction = -1
    else direction = -1 end
    showNum = showNum or 8

    local dropDown = UI.GMUtilDropDownList:create()
    dropDown:init(text, width, GMUtilConfig.LAYOUT_DROPDOWN_HEIGHT, direction)
    dropDown:setDropDownItemShowNum(showNum)
    for i,v in ipairs(data) do
        dropDown:addText(tostring(v))
    end
    return dropDown
end

-- 返回一个输入框
function GMUtilHelper:getInput(text, width, inputType)
    assert(type(text) == "string")
    assert(type(width) == "number" and width > 0)
    inputType = inputType or cc.EDITBOX_INPUT_MODE_ANY

    local input = UI.EditBox:create(width, GMUtilConfig.LAYOUT_INPUT_HEIGHT)
    input:init(
        text, 
        inputType, 
        GMUtilConfig.SPRITE_INPUT_BG, 
        GMUtilConfig.LAYOUT_INPUT_PAD_LEFT, 
        GMUtilConfig.LAYOUT_INPUT_PAD_RIGHT)
    return input
end

-- 返回一个按钮
function GMUtilHelper:getButton(text, width, onClick)
	assert(type(width) == "number" and width > 0)
	assert(type(text) == "string")

	local button = UI.ButtonS9:create(width, GMUtilConfig.LAYOUT_BTN_HEIGHT)
    button:init(text, GMUtilConfig.SPRITE_BUTTON_NORMAL, GMUtilConfig.SPRITE_BUTTON_PRESSED)
    button:setTitleFontSize(GMUtilConfig.LAYOUT_BTN_HEIGHT + GMUtilConfig.LAYOUT_BTN_FNT_SZ_OFFSET)
    button:setTitleColor(UI.FONT_COLOR_42_31_1)
    button:setTitleFontName(UI.FONT_ARIAL)
    button:setOnClicked(onClick)
    return button
end

-- 返回一个只有字符标签的行， 用指定高度和字符串
function GMUtilHelper:getLabel(text, height, width, bgSpriteName, floatDir, color, rightPad)
    assert((type(width) == "number" and width > 0) or width == nil)
    assert(type(height) == "number" and height > 0)
    assert(type(text) == "string")
    assert(type(bgSpriteName) == "string" or bgSpriteName == nil)
    assert(type(floatDir) == "number" or floatDir == nil)
    bgSpriteName = bgSpriteName or GMUtilConfig.SPRITE_LABEL_BG
    color = color or GMUtilConfig.LAYOUT_LABEL_FONT_COLOR
    rightPad = rightPad or 50

    -- 新建一个文字标签
    local textLabel = UI.TextS9:create()
    textLabel:init(
        text, 
        GMUtilConfig.LAYOUT_LABEL_FONT, 
        height + GMUtilConfig.LAYOUT_LABEL_SIZE_OFFSET, 
        color,
        bgSpriteName)
    if (width) then
        textLabel:setSize(width, height)
    end

    -- 设置偏移量调整文字相对背景的位置
    textLabel:setPaddings(10, rightPad, 7, 13)

    -- 设置浮动方向
    if (floatDir == GMUtilConfig.DIRECTION.LEFT) then textLabel:setTextLeft()
    elseif (floatDir == GMUtilConfig.DIRECTION.RIGHT) then textLabel:setTextRight()
    else textLabel:setTextLeft() end

    return textLabel
end

-- 返回一个快捷按钮
function GMUtilHelper:getQuickBarButton(text, width, callback)
    local quickLabel = self:getLabel(
        text,
        GMUtilConfig.LAYOUT_QUICK_BTN_HEIGHT, 
        GMUtilConfig.LAYOUT_QUICK_BTN_WIDTH,
        GMUtilConfig.SPRITE_TITLE_BG,
        GMUtilConfig.DIRECTION.LEFT,
        GMUtilConfig.LAYOUT_TITLE_FONT_COLOR)
    quickLabel:setTouchEnable(true)
    quickLabel:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, quickLabel, function(label)
        label:setScale(1.1)
    end)
    quickLabel:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, quickLabel, function(label)
        label:setScale(1.0)
        if (callback ~= nil) then callback(label) end
    end)
    return quickLabel
end

-- 返回一个标题行
function GMUtilHelper:getTitleRow(text, sub, subOffset, subWidth)
    assert(type(text) == "string")

    -- 新建一个布局来装分割行
    local newRowLayout = self:getAutoHeightLayout()

    -- 新建标题行
    local titleRow = self:getAutoHeightLayout()
    self:addSectionUp(newRowLayout, titleRow)

    -- 标题
    self:addSectionLeft(titleRow, self:getLabel(
        text,
        GMUtilConfig.LAYOUT_TITLE_HEIGHT, 
        GMUtilConfig.LAYOUT_TITLE_WIDTH,
        GMUtilConfig.SPRITE_TITLE_BG,
        GMUtilConfig.DIRECTION.LEFT,
        GMUtilConfig.LAYOUT_TITLE_FONT_COLOR))

    -- 丑陋地用一个空布局来做一个底部偏移
    self:addSectionUp(newRowLayout, self:getAutoLayout(nil, GMUtilConfig.LAYOUT_TITLE_BOT_PAD))
    if (not sub) then return newRowLayout end

    -- 副标题
    subOffset = subOffset or 0
    local subtitleRowLayout = self:getAutoHeightLayout()
    subtitleRowLayout:centerLeft(0)
    newRowLayout:addComponent(subtitleRowLayout)

    self:addSectionLeft(subtitleRowLayout, self:getLabel(
        sub,
        subWidth,
        GMUtilConfig.LAYOUT_SUBTITLE_HEIGHT, 
        GMUtilConfig.SPRITE_TITLE_BG), subOffset)
    return newRowLayout
end

-- 返回一个分割行
function GMUtilHelper:getSeparatorRow(paddingBottom)
    -- 检查参数
    paddingBottom = 
        paddingBottom or 
        (GMUtilConfig.LAYOUT_SEPERATOR_ROW_HEIGHT - GMUtilConfig.LAYOUT_SEPERATOR_HEIGHT) / 2

    -- 新建一个布局来装分割行
    local newRowLayout = self:getAutoLayout(
        GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_WIDTH, 
        GMUtilConfig.LAYOUT_SEPERATOR_ROW_HEIGHT)

    -- 分各行图像
    local seperator = cc.Scale9Sprite:createWithSpriteFrameName(GMUtilConfig.SPRITE_SEPERATOR)
    seperator:setContentSize(cc.size(
        GMUtilConfig.LAYOUT_SEPERATOR_WIDTH, 
        GMUtilConfig.LAYOUT_SEPERATOR_HEIGHT))
    seperator:setAnchorPoint(0, 0.5)
    seperator:setPosition(GMUtilConfig.LAYOUT_SEPERATOR_LEFT_OFFSET, paddingBottom)

    -- 添加文字到布局后返回
    newRowLayout:addChild(seperator)
    return newRowLayout, GMUtilConfig.LAYOUT_SEPERATOR_Z
end

-- 返回一个布局, 默认为自动布局
function GMUtilHelper:getAutoLayout(width, height)
    assert(type(width) == "number" or width == nil)
    assert(type(height) == "number" or height == nil)

    local newRowLayout = UI.Layout:create()
    newRowLayout:init()

    if (not width) then newRowLayout:enableAutoWidth() width = 0 end
    if (not height) then newRowLayout:enableAutoHeight() height = 0 end

    newRowLayout:setSize(width, height)

    if (DEBUG_DRAW) then newRowLayout:enableDebugDraw() end
    return newRowLayout
end

-- 返回一个自动高度的空行, 默认为GMUtil内容宽度
function GMUtilHelper:getAutoHeightLayout(rowWidth)
    rowWidth = rowWidth or GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_WIDTH
    return self:getAutoLayout(rowWidth)
end

-- 设置组件浮动方向和间隔
function GMUtilHelper:setFloatDirWithPad(comp, floatDir, padding)
	assert(comp ~= nil)

    -- 设置浮动方向和间距
    local p1Checked = type(padding) == "number" and padding or 0
    if (GMUtilConfig.DIRECTION.LEFT == floatDir) then  comp:floatLeft(p1Checked)
    elseif (GMUtilConfig.DIRECTION.RIGHT == floatDir) then comp:floatRight(p1Checked)
    elseif (GMUtilConfig.DIRECTION.UP == floatDir) then comp:floatUp(p1Checked)
    elseif (GMUtilConfig.DIRECTION.DOWN == floatDir) then comp:floatDown(p1Checked)
    else comp:floatLeft(p1Checked) end
end

-- 向上浮动添加一个控件
function GMUtilHelper:addSectionUp(layout, comp, padding, z)
	assert(layout ~= nil)
	assert(comp ~= nil)
	self:setFloatDirWithPad(comp, GMUtilConfig.DIRECTION.UP, padding)
	z = z or GMUtilConfig.LAYOUT_SECTION_Z
    layout:addComponent(comp, z)
end

-- 向左浮动添加一个控件
function GMUtilHelper:addSectionLeft(layout, comp, padding, z)
	assert(layout ~= nil)
	assert(comp ~= nil)
    self:setFloatDirWithPad(comp, GMUtilConfig.DIRECTION.LEFT, padding)
    self:setFloatDirWithPad(comp, GMUtilConfig.DIRECTION.UP, padding)
    z = z or GMUtilConfig.LAYOUT_SECTION_Z
    layout:addComponent(comp, z)
end

-- 向右浮动添加一个控件
function GMUtilHelper:addSectionRight(layout, comp, padding, z)
	assert(layout ~= nil)
	assert(comp ~= nil)
    self:setFloatDirWithPad(comp, GMUtilConfig.DIRECTION.RIGHT, padding)
    z = z or GMUtilConfig.LAYOUT_SECTION_Z
    layout:addComponent(comp, z)
end

-- 向右浮动添加一个控件
function GMUtilHelper:addSectionRight(layout, comp, padding, z)
    assert(layout ~= nil)
    assert(comp ~= nil)
    self:setFloatDirWithPad(comp, GMUtilConfig.DIRECTION.RIGHT, padding)
    z = z or GMUtilConfig.LAYOUT_SECTION_Z
    layout:addComponent(comp, z)
end
------------------eo 帮助排版-------------------













------------------帮助杂物-------------------
-- 关闭GM工具
function GMUtilHelper:closeGMUtil(comp)
    if (comp) then
        self:getGMUtilLayer(comp):close()
    else
        require "app.ui.gmUtil.GMUtilLayer"
        UI.GMUtilLayer:instanceClose()
    end
end

-- 从子组件找GmUtilLayer
function GMUtilHelper:getGMUtilLayer(comp)
    local compToTest = comp
    while (compToTest) do
        if (compToTest._GMUtilLayerTag == GMUtilConfig.GMUtilLayerTag) then
            return compToTest
        end
        compToTest = compToTest:getParent()
    end
    assert(false, "This is not a child of GMUtilLayer")
end

-- 返回一个人物属性和ID的对应列表
function GMUtilHelper:getValidAttrList()
    local attrAllList = GameManager:getAttrList()
    local validList = {}
    for key, value in ipairs(attrAllList) do
        if (value.type ~= PublicDefine.ATTR_TYPE.roleLV and 
            value.type ~= PublicDefine.ATTR_TYPE.curCoin) then
            table.insert(validList, value)
        end
    end
    return validList
end

-- 返回模式数据列表
function GMUtilHelper:getModeDataList()
    local modeDataList = {}
    for k, v in pairs (PublicDefine.CAVE_MODE) do
        if (v ~= PublicDefine.CAVE_MODE.MODE_MAX and v ~= PublicDefine.CAVE_MODE.MODE_INVALID) then
            local data = {}
            data.name = ToolsUtil:getModeName(v)
            data.modeType = v
            table.insert(modeDataList, data)
        end
    end
    table.sort(modeDataList, function(a, b)
        return a.modeType < b.modeType
    end)
    return modeDataList
end

-- 返回难度数据列表
function GMUtilHelper:getDiffDataList()
    local diffDataList = {}
    for k, v in pairs(PublicDefine.CAVE_DIFFICULTY) do
        local data = {}
        data.name = ToolsUtil:getDiffcultName(v)
        data.diffType = v
        table.insert(diffDataList, data)
    end
    table.sort(diffDataList, function(a, b)
        return a.diffType < b.diffType
    end)
    return diffDataList
end

-- 从一个对象列表里使用一个统一的属性制作一个新列表并返回
function GMUtilHelper:getListOfField(dataTable, field)
    assert(type(table) == "table")
    assert(type(field) == "string")

    local retList = {}
    for i, v in ipairs(dataTable) do
        table.insert(retList, v[field])
    end
    return retList
end

-- 获取延迟收包现在数值
function GMUtilHelper:getRecvDelays()
    return LatSim:getRecvDelayBase(), LatSim:getRecvDelayDelta()
end

-- 获取延迟收包现在开关
function GMUtilHelper:isRecvDelayOn()
    return LatSim:isRecvOn()
end

-- 获取延迟发包现在数值
function GMUtilHelper:getSendDelays()
    return LatSim:getSendDelayBase(), LatSim:getSendDelayDelta()
end

-- 获取延迟发包现在开关
function GMUtilHelper:isSendDelayOn()
    return LatSim:isSendOn()
end

-- 获取延迟发包现在数值
function GMUtilHelper:getSendDelays()
    return LatSim:getSendDelayBase(), LatSim:getSendDelayDelta()
end

-- 获取延迟发包现在开关
function GMUtilHelper:isSendDelayOn()
    return LatSim:isSendOn()
end

-- 获取收包内容显示开关
function GMUtilHelper:isShowRecvCon()
    return LatSim:isShowRecvContent()
end

-- 获取发包内容显示开关
function GMUtilHelper:isShowSendCon()
    return LatSim:isShowSendContent()
end

-- 获取地图坐标开关现在状态
function GMUtilHelper:getShowCordinates()
    return MapHelper.showDebugCoordinates
end

-- 获取当前账号ID
function GMUtilHelper:getCurrentAccount()
    return cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify, account)
end

-- 获取当然默认服务器IP
function GMUtilHelper:getDefaultServerIP()
    return gameLoginManager:getInstance():getServerUrl() or "0.0.0.0"
end

-- 获取当前默认服务器端口
function GMUtilHelper:getDefaultServerPort()
    return gameLoginManager:getInstance():getServerPort() or 0
end

------------------eo 帮助杂物-------------------













------------------帮助检查提示-------------------
-- 检查是否在城里, 如果不在就提示然后返回否
function GMUtilHelper:checkInTown()
    local ret = SceneManager:getInstance():isInTown()
    if (not ret) then self:noteNIT() end
    return ret
end

-- 检查是否野外, 如果不在就提示然后返回否
function GMUtilHelper:checkInWild()
    local ret = SceneManager:getInstance():isInFightScene()
    if (not ret) then self:noteNIC() end
    return ret
end

-- 默认反馈
function GMUtilHelper:noteDEF() -- DEF = Default
    UI.ScrollBar:createByText("请求已发送喵")
end

-- 提示未知错误
function GMUtilHelper:noteUKN() -- UKN = Unknown
    UI.ScrollBar:createByText("出错了喵! 不知道为什么..")
end

-- 提示未完成输入
function GMUtilHelper:noteICO() -- ICO = Incomplete
    UI.ScrollBar:createByText("写完!!")
end

-- 提示未进洞
function GMUtilHelper:noteNIC() -- NIC = Not In Cave
    UI.ScrollBar:createByText("进洞再说!!")
end

-- 提示没在城里
function GMUtilHelper:noteNIT() -- NIC = Not In Town
    UI.ScrollBar:createByText("回城再说!!")
end

-- 提示功能建设中
function GMUtilHelper:noteCON() -- CON = Construction
    UI.ScrollBar:createByText("还没做好 :P")
end

-- 提示宝物减少
function GMUtilHelper:noteDEC() -- DED = Decrease
    UI.ScrollBar:createByText("财大气粗!")
end

-- 提示宝物增多
function GMUtilHelper:noteINC() -- INC = Increase
    UI.ScrollBar:createByText("你使用了均富卡 ^_^")
end

-- 提示物品生成
function GMUtilHelper:noteIGE() -- IGE = Item Generation
    UI.ScrollBar:createByText("哆啦A梦显神威~")
end

-- 提示怪物生成
function GMUtilHelper:noteMGE() -- MGE = Monster Generation
    UI.ScrollBar:createByText("怪来啦快跑!!!!")
end

-- 提示楼层跳转
function GMUtilHelper:noteLVJ() -- LVJ = LV Jump
    UI.ScrollBar:createByText("怎么又是你!? 又?..")
end

-- 提示改变属性
function GMUtilHelper:noteCAT() -- CAT = Change Attribute
    UI.ScrollBar:createByText("おおおおおお！！")
end

-- 英雄无敌
function GMUtilHelper:noteHIN() -- HIN = Hero Invincible
    UI.ScrollBar:createByText("卧槽！ 就是一个干！")
end

-- 英雄不无敌
function GMUtilHelper:noteHNI() -- HNI = Hero Not Invincible
    UI.ScrollBar:createByText("要小心点咯")
end

-- 怪物无敌
function GMUtilHelper:noteMIN() -- MIN = Monster Invincible
    UI.ScrollBar:createByText("额。打毛？")
end

-- 怪物不无敌
function GMUtilHelper:noteMNI() -- MNI = Monster Not Invincible
    UI.ScrollBar:createByText("咳咳。至少能打了")
end

-- 切换服务器
function GMUtilHelper:noteSSW() -- SSW = Server Swtich
    UI.ScrollBar:createByText("世界跳跃中...")
end

-- 切换账号
function GMUtilHelper:noteSAC() -- SAC = Switch Account
    UI.ScrollBar:createByText("美..美少女变身!")
end

-- 功能解锁
function GMUtilHelper:noteFUL() -- FUL = Function Unlock
    UI.ScrollBar:createByText("突然明白了好多东西")
end

-- 清除解锁提示
function GMUtilHelper:noteCUF() -- FUL = Clear Unlock Function
    UI.ScrollBar:createByText("全部都清扫掉了喵~")
end

-- 模式难度解锁
function GMUtilHelper:noteMDU() -- MDU = Mode Difficulty Unlock
    UI.ScrollBar:createByText("突然想去看世界")
end

-- 提示延迟模拟开
function GMUtilHelper:noteDON() -- DON = Delay On
    UI.ScrollBar:createByText("好..好ka..卡.")
end

-- 提示延迟模拟关
function GMUtilHelper:noteDOF() -- DOF = Delay Off
    UI.ScrollBar:createByText("我能甩枪爆头!")
end

-- 提示延迟开关未打开
function GMUtilHelper:noteDSO() -- DSO = Delay Switch's Off
    UI.ScrollBar:createByText("先打开延迟开关")
end

-- 提示显示包内容
function GMUtilHelper:noteSPC() -- SPC = Show Package Content
    UI.ScrollBar:createByText("嘿嘿, 偷窥一下包")
end

-- 提示隐藏包内容
function GMUtilHelper:noteHPC() -- HPC = Hide Package Content
    UI.ScrollBar:createByText("哦, 包不给偷窥了")
end

-- 提示地图调试数据显示
function GMUtilHelper:noteMDI() -- MDI = Map Debug Information
    UI.ScrollBar:createByText("火眼晶睛!")
end

-- 提示地图调试数据隐藏
function GMUtilHelper:noteMDH() -- MDI = Map Debug Hide
    UI.ScrollBar:createByText("什么都看不见了啊!TAT")
end

-- 提示传送成功
function GMUtilHelper:noteBCO() -- MDI = Blink COmplete
    UI.ScrollBar:createByText("居然传送成功了")
end

-- 提示一键完成任务
function GMUtilHelper:noteQCO() -- QCO = Quests COmplete
    UI.ScrollBar:createByText("都搞定了喵")
end

-- 提示一键完成任务
function GMUtilHelper:noteACO() -- ACO = Achievements COmplete
    UI.ScrollBar:createByText("成就都搞定了喵")
end

-- 提示掉落测试
function GMUtilHelper:noteDDT() -- DDT = Do Drop Test
    UI.ScrollBar:createByText("搞啥子情况掉这么多东西?!")
end

-- 打开界面成功
function GMUtilHelper:noteOUI() -- OUI = Open UI
    UI.ScrollBar:createByText("这是什么魔法?!")
end

-- 英雄模式词缀刷新成功
function GMUtilHelper:noteHMP() -- HMP = Hero Mode Property
    UI.ScrollBar:createByText("词缀变变变变变变变变!")
end

-- 英雄模式词缀刷新成功
function GMUtilHelper:noteDSS() -- DSS = Dream Set Successful
    UI.ScrollBar:createByText("啊... 做了个梦")
end
------------------eo 帮助检查提示----------------

function GMUtilHelper:getScheduler(ids)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    local idx = 1
    local max = #ids
    local func = function ()
        local id = ids[idx]
        if id then
            if (UI.GMUtilExecutor:addGoods(id, 1)) then 
                self:noteIGE() else self:noteUKN() 
            end
        end
        idx = idx + 1
        if idx >= max then
            self:closeScheduler()
        end
    end
    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,func), 0.25, false)
    return self.schedulerID;
end
function GMUtilHelper:closeScheduler()
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end
---------------------------------------
-- eo 程序逻辑 --


return GMUtilHelper