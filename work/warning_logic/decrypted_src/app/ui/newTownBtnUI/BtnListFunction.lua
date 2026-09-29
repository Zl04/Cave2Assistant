-- BtnListFunction.lua
-- Author:siyu.lin
-- 2023年9月28日
-- Using:功能按钮

require "app.ui.common.ScrollView"
require "app.ui.common.List.ListView"
require "app.ui.common.GridList.GridList"
require "app.ui.shoplayer.ShopGrid"
require "app.ui.shoplayer.BagGoodsPanel"

local winSize = cc.Director:getInstance():getWinSize()

local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

-- 列表尺寸
local RIGHTUP_LAYOUT_WIDTH = 120
local RIGHTUP_LAYOUT_HEIGHT = 120
local RIGHTDOWN_LAYOUT_WIDTH = 10
local RIGHTDOWN_LAYOUT_HEIGHT = 70

-- 按钮位置间距
local RIGHTUP_CELL_SPACE = 90
local RIGHT_CELL_SPACE = 80
local RIGHTDOWN_CELL_SPACE = 106

-- 横幅额外空间
local RIGHTUP_BG_EXTRA_SPACE = 76
local RIGHT_BG_EXTRA_SPACE = 32
local RIGHTDOWN_BG_EXTRA_SPACE = 80

-- 右下侧底板距离标记点位置向右偏移距离（收缩动作会抽出一段距离，防止曝光）
local RIGHTDOWN_MORE_SPACE = 60

local BTN_NOMAL = "ui_greatnavigation_icon_10.png"
local BTN_SELECT = "ui_greatnavigation_icon_11.png"

local BtnListFunction = class("BtnListFunction", UI.HWBtnComponent)
UI.BtnListFunction = BtnListFunction

local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_town_maincity.plist",
    "ui_mentor.plist",
    "ui_town_greatnavigation.plist",
}


function BtnListFunction:ctor()
    BtnListFunction.super.ctor(self, UIType.FUNCTION_NPC, COM_RES_LIST, 208, 100)
    self.btnCellList = {}
    self:registerListener()
    -- 点击状态
    self.switchOpen = true
    self._skinBtnNormal = nil
    self._skinBtnSelect = nil
end

function BtnListFunction:dtor()
    BtnListFunction.super.dtor(self)
    self.btnCellList = nil
    self:unRegisterListener()
end

-- public:
-- 初始化
function BtnListFunction:init(dataArr, btnPos, btnSize, closeCallback, createNodeCallBack)
    -- 这里由于每个按钮的大小
    self.dataArr = dataArr
    self.btnPos = btnPos
    self.btnSize = btnSize
    self.btnCellList = {}
    self._closeCallback = closeCallback
    self._createNodeCallBack = createNodeCallBack

    BtnListFunction.super.init(self)
end

--[[
    设置皮肤
]]
function BtnListFunction:setSkin(btnNormal, btnSelect)
    self._skinBtnNormal = btnNormal
    self._skinBtnSelect = btnSelect

    self:updaterightUpSwitchBtn()
end

-- 模版函数：初始化组建的视图
function BtnListFunction:onInitView()
    self.runActioning = true

    local layerBgLeft = UI.Image.create()
    layerBgLeft:init("ui_greatnavigation_iconbg_1.png")
    layerBgLeft:center(-230, 0)
    layerBgLeft:setAnchorPoint(cc.p(1, 0.5))
    self.layerBgLeft = layerBgLeft
    self:addChild(layerBgLeft)

    local layerBgUp = UI.Image.create()
    layerBgUp:init("ui_greatnavigation_iconbg_2.png")
    layerBgUp:center(0, -140)
    layerBgUp:setAnchorPoint(cc.p(0.5, 0))
    self.layerBgUp = layerBgUp
    self:addChild(layerBgUp)

    local btnListLayout = UI.Layout:create()
    btnListLayout:init()
    btnListLayout:setSize(208, 100)
    btnListLayout:setIgnoreAnchorPointForPosition(false)
    btnListLayout:setAnchorPoint(cc.p(0.5, 0))
    
    -- btnListLayout:enableDebugDraw()
    btnListLayout._enableAutoUpdatePos = false
    self:addChild(btnListLayout)
    self.btnListLayout = btnListLayout


    --btnListLayout:enableDebugDraw()

    -- 右上角按钮
    local rightUpSwitchBtn = UI.Button:create()
    rightUpSwitchBtn:init("ui_greatnavigation_icon_11.png", "ui_greatnavigation_icon_10.png")
    rightUpSwitchBtn:center()
    rightUpSwitchBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.rightUpSwitchClick)
    self:addChild(rightUpSwitchBtn, 100)
    self.rightUpSwitchBtn = rightUpSwitchBtn

    -- 计算坐标
    -- local layoutPos = self:convertToNodeSpace(self.btnPos)
    -- layoutPos.x = layoutPos.x + self.btnSize.width/2
    -- layoutPos.y = layoutPos.y + self.btnSize.height
    -- btnListLayout:setPosition(layoutPos)
    btnListLayout:setScale(0)

    --btnListLayout:setInterceptTouches(true)
    --btnListLayout:setTouchEnable(true)

    btnListLayout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        print("BtnListFunction onTouchEnded")
        --self:showCloseAction()
        Avalon.AudioManager:playSound("1502")
    end)

    self:updateBanner()

    for k, v in ipairs(self.dataArr) do
        self:createBtnByData(k, v)
    end

    local scaleLeftBg = self:getScale(true)
    local scaleRightBg = self:getScale(false)
    self.layerBgLeft:setScaleX(scaleLeftBg)
    self.layerBgUp:setScaleY(scaleRightBg)

    self:showOpenAction()
    Avalon.AudioManager:playSound("1501")
end

function BtnListFunction:createBtnByData(index, btnData)
    local btnPos = self:getBtnPos(btnData)

    if(self._createNodeCallBack == nil) then
        local btn = UI.Button:create()
        btn:init(btnData.IconNormal, btnData.IconClick)
        btn:center(btnPos.x, btnPos.y)
        btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            btnData.BtnCallBack()
        end)
        btn:setName(btnData.Name)
    
        local redPoint = AvalonUtil.createRedPoint(btn, 2, 2, 100)
        redPoint:setName("redPoint")
        redPoint:hide()
    
        self.btnListLayout:addChild(btn)
    else 

        local node = self._createNodeCallBack(index, btnData)
    
        node:center(btnPos.x, btnPos.y)
        self.btnListLayout:addChild(node)
    end
end

-- 刷新按钮红点
function BtnListFunction:refreshBtnRedPoint(btnName)
    if not self.btnCellList or table.nums(self.btnCellList) <= 0 then
        return
    end

    for k, v in pairs(self.btnCellList) do
        local btnName1 = v:getName()
        if btnName1 == btnName then
            v.RedCallBack(v)
        end
    end
end

function BtnListFunction:getBtnPos(btnData)
    local position = {x = 0, y = 0}
    if btnData.isHorizontal then
        position.x = -(btnData.btnIndex - 1) * RIGHTUP_CELL_SPACE + 10
        position.y = 3
    else
        position.x = RIGHTUP_CELL_SPACE + 15
        position.y = -(btnData.btnIndex) * RIGHTUP_CELL_SPACE
    end

    return position
end

function BtnListFunction:showOpenAction()
    self.btnListLayout:runAction(cc.Sequence:create(
            cc.EaseSineIn:create(cc.ScaleTo:create(0.15, 1)),
            cc.CallFunc:create(function()
                self.runActioning = false
            end)
        ))
end

function BtnListFunction:showCloseAction()
    self.btnListLayout:runAction(cc.Sequence:create(
            cc.EaseSineOut:create(cc.ScaleTo:create(0.15, 0)),
            cc.CallFunc:create(function()
                --self:close()
            end)
        ))
end

function BtnListFunction:updateBanner()
    -- 计算横幅长度
    local btnNum = table.nums(self.dataArr)
    local bgLength = btnNum * RIGHTUP_CELL_SPACE

    local maxLength = RIGHTUP_CELL_SPACE * 6
    local btnMaxLength = maxLength - RIGHTUP_BG_EXTRA_SPACE
    local heightMG = math.ceil(bgLength / btnMaxLength)
    if bgLength > btnMaxLength then
        bgLength = btnMaxLength
    end
    self.heightMG = heightMG
    self.eachRowBtnNum = math.floor(bgLength / RIGHTUP_CELL_SPACE)
    
    -- print(" btnPos.x =22==  ", bgLength, maxLength, heightMG)

    -- 横幅底图
    -- if heightMG == 1 then
    --     self.layerBgLeft:setSize(450, 80 * heightMG)
    -- else
    --     self.layerBgLeft:setSize(450, 80 * heightMG)
    -- end

    --self.layerBgLeft:setAnchorPoint(cc.p(1, 0.5))

    -- 按钮列表框（为了跟底图分开展开）
    --self.btnListLayout:setSize(self.layerBgLeft:getContentSize().width, self.layerBgLeft:getContentSize().height)
    --self.btnListLayout:centerRight((RIGHTUP_LAYOUT_WIDTH - self.rightUpSwitchBtn:getContentSize().width)/2)
end

function BtnListFunction:rightUpSwitchClick()
    if self.btnRunActioning then
        return
    end

    self:showRightUpLayoutAction()

    self.switchOpen = not self.switchOpen
    self:updaterightUpSwitchBtn()
end

function BtnListFunction:getScale(isHorizontal) 
    local scale = 0

    local widthNum = 0
    local heightNum = 0
    for k, v in ipairs(self.dataArr) do
        if(v.isHorizontal) then 
            widthNum = widthNum + 1
        else 
            heightNum = heightNum + 1
        end
    end

    if(isHorizontal == true) then 
        if(widthNum > 0) then
            local len = widthNum * RIGHTUP_CELL_SPACE + RIGHTUP_BG_EXTRA_SPACE + 20
            scale = len *1.0 /self.layerBgLeft:getContentSize().width
        else
            scale = 0
        end
    else 
        if(heightNum > 0) then
            local len = heightNum * RIGHTUP_CELL_SPACE + 20
            scale = len *1.0 /self.layerBgUp:getContentSize().height
        else
            scale = 0
        end
    end

    return scale
end

function BtnListFunction:showRightUpLayoutAction()
    local totalTime = 0.2
    local fadeTime = 0.2
    self.btnRunActioning = true

    local leftBg = self:getScale(true)
    local rightBg = self:getScale(false)

    if self.switchOpen then
        self.layerBgLeft:runAction(cc.Sequence:create(
            cc.CallFunc:create(function()
                self.btnListLayout:runAction(cc.Sequence:create(
                    cc.FadeOut:create(fadeTime),
                    cc.CallFunc:create(function()
                        self.btnListLayout:hide()
                    end)
                ))
            end),
            cc.DelayTime:create(fadeTime - 0.1),
            cc.EaseSineIn:create(cc.ScaleTo:create(totalTime, 0, 1)),
            cc.CallFunc:create(function()
                self.btnRunActioning = false
            end)
        ))

        self.layerBgUp:runAction(cc.Sequence:create(
            cc.CallFunc:create(function()
                self.btnListLayout:runAction(cc.Sequence:create(
                    cc.FadeOut:create(fadeTime),
                    cc.CallFunc:create(function()
                        self.btnListLayout:hide()
                    end)
                ))
            end),
            cc.DelayTime:create(fadeTime - 0.1),
            cc.EaseSineIn:create(cc.ScaleTo:create(totalTime, 1, 0))
        ))
    else
        self.layerBgLeft:runAction(cc.Sequence:create(
            cc.EaseSineIn:create(cc.ScaleTo:create(totalTime, leftBg, 1)),
            cc.CallFunc:create(function()
                self.btnListLayout:runAction(cc.Sequence:create(
                    cc.CallFunc:create(function()
                        self.btnListLayout:show()
                    end),
                    cc.FadeIn:create(fadeTime),
                    cc.CallFunc:create(function()
                        self.btnRunActioning = false
                    end)
                ))
            end)
        ))

        self.layerBgUp:runAction(cc.Sequence:create(
            cc.EaseSineIn:create(cc.ScaleTo:create(totalTime, 1, rightBg)),
            cc.CallFunc:create(function()
                self.btnListLayout:runAction(cc.Sequence:create(
                    cc.CallFunc:create(function()
                        self.btnListLayout:show()
                    end),
                    cc.FadeIn:create(fadeTime)
                ))
            end)
        ))
    end
end

function BtnListFunction:updaterightUpSwitchBtn()
    if self.switchOpen then
        self.rightUpSwitchBtn:setNormal(self._skinBtnSelect or BTN_SELECT)
        self.rightUpSwitchBtn:setSelected(self._skinBtnNormal or BTN_NOMAL)
    else
        self.rightUpSwitchBtn:setNormal(self._skinBtnNormal or BTN_NOMAL)
        self.rightUpSwitchBtn:setSelected(self._skinBtnSelect or BTN_SELECT)
    end
end

-- 注册监听事件(可选)
function BtnListFunction:registerListener()
end

-- 注销监听事件(可选)
function BtnListFunction:unRegisterListener()
end