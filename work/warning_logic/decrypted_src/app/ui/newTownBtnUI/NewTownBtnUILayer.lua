--[[
    小地图
]]

require "app.ui.Component"
require "app.ui.newTownBtnUI.NewTownBtnUIDataManager"
local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require "app.game.SdkManager"
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}

local NewTownBtnUILayer = class("NewTownBtnUILayer", UI.HWBtnComponent)
UI.NewTownBtnUILayer = NewTownBtnUILayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {
    "ui_town_maincity.plist",
    "ui_mentor.plist",
}

-- 列表尺寸
local RIGHTUP_LAYOUT_WIDTH = 120
local RIGHTUP_LAYOUT_HEIGHT = 120
local RIGHTDOWN_LAYOUT_WIDTH = 10
local RIGHTDOWN_LAYOUT_HEIGHT = 70

-- 按钮位置间距
local RIGHTUP_CELL_SPACE = 78
local RIGHT_CELL_SPACE = 80
local RIGHTDOWN_CELL_SPACE = 106

-- 横幅额外空间
local RIGHTUP_BG_EXTRA_SPACE = 76
local RIGHT_BG_EXTRA_SPACE = 32
local RIGHTDOWN_BG_EXTRA_SPACE = 80

-- 右下侧底板距离标记点位置向右偏移距离（收缩动作会抽出一段距离，防止曝光）
local RIGHTDOWN_MORE_SPACE = 60

-- opentype列表
local BtnOpenTypeList = NewTownBtnUIDataManager:getOpenTypeList()

-- 按钮所属区域划分
local NewTownBtnPosType = NewTownBtnUIDataManager:getPosTypeList()

-- 构造函数
function NewTownBtnUILayer:ctor()
    NewTownBtnUILayer.super.ctor(self, UIType.MINI_MAP, COM_RES_LIST, winSize.width - Avalon.issUtil:getWidthOffset(),winSize.height)

    -- 右上角点击状态
    self.rightUpSwitchOpen = true
    -- 右下角点击状态
    self.rightBottomSwitchOpen = false
    -- 处于按钮展开收缩动作中
    self.btnRunActioning = false
    -- 按钮组
    self.btnCellList = {}
    -- 刷新按钮数据
    NewTownBtnUIDataManager:updateTownBtnList()

    self:bindModel()
end

-- 析构函数
function NewTownBtnUILayer:dtor()
    NewTownBtnUILayer.super.dtor(self)
    self.rightUpSwitchOpen = true
    self.rightBottomSwitchOpen = false
    self.btnRunActioning = false
    self.btnCellList = nil

    self:unbindModel()
end

function NewTownBtnUILayer:bindModel()
    -- 刷新老逻辑处上面部分的按钮
    Avalon.MessageCenter:bind(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN, self, self.refreshInfoBtn)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GOODS_USE_INFO_CHANGE, self,self.refreshInfoBtn)
    -- 功能解锁
    Avalon.MessageCenter:bind(GameMessage.MC_UI_FUNCTION_UNLOCK, self,self.refreshInfoBtn)
    -- 商店内购
    Avalon.MessageCenter:bind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.refreshBtnRedPoint)
    -- 领取月卡状态刷新
    Avalon.MessageCenter:bind(GameMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(GameMessage.MC_REFRESH_IAPSHOP_NEW_FLAG, self, self.refreshBtnRedPoint)
    -- 好友红点
    Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_NEW_FRIEND_FLAG, self, self.refreshBtnRedPoint)
    -- 公会按钮红点
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_HAVE_JOIN_REQ, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_NO_JOIN_REQ, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_QUIT_GUILD, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_JOIN_SUCCESS, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BOX_NEW_BOX_CHANGED, self, self.refreshBtnRedPoint)
    -- 背包红点
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_SKILL_POINT_RED_POINT, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshBtnRedPoint)
    -- 探险队，这里因为某些非探险队处在调用
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_EXPEDITION_BAG_CHANGE, self, self.refreshBtnRedPoint)
    -- 学徒导师按钮
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_LEVEL_UP, self, self.refreshInfoBtn)
    Avalon.MessageCenter:bind(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS, self, self.refreshInfoBtn)
    Avalon.MessageCenter:bind(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_REDPOINTS, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_NEW_CITY_REDPOINT, self, self.refreshBtnRedPoint)
    -- 通行证刷新
    if mvc.battlePassModel then
        mvc.battlePassModel:bind("PassRewardData", self, self.refreshBtnRedPoint)
    end
    -- 缤纷活动
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshBtnRedPoint)
    
end


function NewTownBtnUILayer:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN, self, self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GOODS_USE_INFO_CHANGE, self,self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_FUNCTION_UNLOCK, self,self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(GameMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(GameMessage.MC_REFRESH_IAPSHOP_NEW_FLAG, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_NEW_FRIEND_FLAG, self, self.refreshNewFriendFlag)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_HAVE_JOIN_REQ, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_NO_JOIN_REQ, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_QUIT_GUILD, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_JOIN_SUCCESS, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BOX_NEW_BOX_CHANGED, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_SKILL_POINT_RED_POINT, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_EXPEDITION_BAG_CHANGE, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_LEVEL_UP, self, self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS, self, self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_REDPOINTS, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_NEW_CITY_REDPOINT, self, self.refreshBtnRedPoint)
    if mvc.battlePassModel then
        mvc.battlePassModel:unbind("PassRewardData", self, self.refreshBtnRedPoint)
    end
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshBtnRedPoint)
end

-- public:
-- 初始化
function NewTownBtnUILayer:init()
    NewTownBtnUILayer.super.init(self)
end

---- 界面打开关闭时，UI显示隐藏逻辑
function NewTownBtnUILayer:showBar(time)
    local durTime = time or 0
    self:stopAllActions()
    self:runAction(cc.Sequence:create(
        cc.CallFunc:create(function()
            self:show()
        end),
        cc.FadeIn:create(durTime)
    ))
end

function NewTownBtnUILayer:hideBar(time)
    local durTime = time or 0
    self:stopAllActions()
    self:runAction(cc.Sequence:create(
        cc.FadeOut:create(durTime),
        cc.CallFunc:create(function()
            self:hide()
        end)
    ))
end

-- 初始化视图
function NewTownBtnUILayer:onInitView()
    -- 右上角起点
    local rightUpLayout = UI.Layout:create()
    rightUpLayout:init()
    rightUpLayout:setSize(RIGHTUP_LAYOUT_WIDTH, RIGHTUP_LAYOUT_HEIGHT)
    rightUpLayout:rightUp(Avalon.issUtil:getRightMargin(), 0)
    -- rightUpLayout:enableDebugDraw()
    self:addChild(rightUpLayout)
    self.rightUpLayout = rightUpLayout

    -- 右上角按钮
    local rightUpSwitchBtn = UI.Button:create()
    rightUpSwitchBtn:init("ui_maincity_drawer_01.png", "ui_maincity_drawer_01_selected.png")
    rightUpSwitchBtn:center()
    rightUpSwitchBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.rightUpSwitchClick)
    self.rightUpLayout:addChild(rightUpSwitchBtn, 100)
    -- rightUpSwitchBtn:closeClickScale()
    self.rightUpSwitchBtn = rightUpSwitchBtn

    self:updaterightUpSwitchBtn()

    -- 右下角起点
    local rightBottomLayout = UI.Layout:create()
    rightBottomLayout:init()
    rightBottomLayout:setSize(RIGHTDOWN_LAYOUT_WIDTH, RIGHTDOWN_LAYOUT_HEIGHT)
    rightBottomLayout:rightBottom(Avalon.issUtil:getRightMargin(), 12)
    -- rightBottomLayout:enableDebugDraw()
    self:addChild(rightBottomLayout)
    self.rightBottomLayout = rightBottomLayout

    -- 创建右上角横幅
    self:createRightUpBanner()

    -- 创建右边竖幅
    self:createRightBanner()

    -- 创建右下侧横幅
    self:createRightBottomBanner()

    -- 创建特殊按钮
    self:updateBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_Special)


    local maxLevelData = GameDataManager:getMaster():getMaxLevelData(PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    local caveLevel = maxLevelData:getMaxLevel()

    if caveLevel <= 1 then
        self.btnRunActioning = false
        self:rightUpSwitchClick()
    end
end

-- 数据更新，刷新按钮显示
function NewTownBtnUILayer:refreshInfoBtn()
    if not self or tolua.isnull(self) then
        return
    end

    -- 刷新数据
    NewTownBtnUIDataManager:updateTownBtnList()

    -- 刷新收放按钮样式
    self:updaterightUpSwitchBtn()

    -- 刷新右上角横幅
    self:updateRightUpBanner()

    -- 刷新右边竖幅
    self:updateRightBanner()

    -- 刷新右下侧横幅
    self:updateRightBottomBanner()

    -- 刷新特殊按钮
    self:updateBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_Special)
end

function NewTownBtnUILayer:createRightUpBanner()
    -- -- 计算横幅长度
    -- local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightUp)
    -- local btnNum = table.nums(btnListData)
    -- local bgLength = btnNum * RIGHTUP_CELL_SPACE + RIGHTUP_BG_EXTRA_SPACE


    -- 计算横幅长度
    local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightUp)
    local btnNum = table.nums(btnListData)
    local bgLength = btnNum * RIGHTUP_CELL_SPACE

    local maxLength = winSize.width * 0.62
    local btnMaxLength = maxLength - RIGHTUP_BG_EXTRA_SPACE
    local heightMG = math.ceil(bgLength / btnMaxLength)
    if bgLength > btnMaxLength then
        bgLength = btnMaxLength
    end
    self.heightMG = heightMG
    self.eachRowBtnNum = math.floor(bgLength / RIGHTUP_CELL_SPACE)


    -- 横幅底图
    local rightUpBg = UI.Image9:create()
    rightUpBg:init("ui_maincity_bg_01.png", cc.rect(100,0,150,52), cc.size(bgLength, 52))
    rightUpBg._enableAutoUpdatePos = false
    rightUpBg:setPosition((RIGHTUP_LAYOUT_WIDTH + self.rightUpSwitchBtn:getContentSize().width)/2, RIGHTUP_LAYOUT_HEIGHT/2)
    rightUpBg:setIgnoreAnchorPointForPosition(false)
    rightUpBg:setAnchorPoint(cc.p(1, 0.5))
    -- rightUpBg:enableDebugDraw()
    self.rightUpLayout:addChild(rightUpBg)
    self.rightUpBg = rightUpBg

    if heightMG == 1 then
        self.rightUpBg:setSize(bgLength + RIGHTUP_BG_EXTRA_SPACE, 52 * heightMG)
    else
        self.rightUpBg:setSize(bgLength + RIGHTUP_BG_EXTRA_SPACE, 65 * heightMG)
        self.rightUpBg:setPosition((RIGHTUP_LAYOUT_WIDTH + self.rightUpSwitchBtn:getContentSize().width)/2, RIGHTUP_LAYOUT_HEIGHT/2 - 13 * (heightMG - 1))
    end

    -- 按钮列表框（为了跟底图分开展开）
    local rightUpBtnLayer = UI.Layout:create()
    rightUpBtnLayer:init()
    rightUpBtnLayer:setSize(rightUpBg:getContentSize().width, rightUpBg:getContentSize().height)
    rightUpBtnLayer:centerRight((RIGHTUP_LAYOUT_WIDTH - self.rightUpSwitchBtn:getContentSize().width)/2)
    -- rightUpBtnLayer:enableDebugDraw()
    self.rightUpLayout:addChild(rightUpBtnLayer)
    self.rightUpBtnLayer = rightUpBtnLayer

    self:updateBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightUp)
end

function NewTownBtnUILayer:updateRightUpBanner()
    -- 计算横幅长度
    local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightUp)
    local btnNum = table.nums(btnListData)
    local bgLength = btnNum * RIGHTUP_CELL_SPACE

    local maxLength = RIGHTUP_CELL_SPACE * 9
    --local maxLength = winSize.width * 0.62
    local btnMaxLength = maxLength - RIGHTUP_BG_EXTRA_SPACE
    local heightMG = math.ceil(bgLength / btnMaxLength)
    if bgLength > btnMaxLength then
        bgLength = btnMaxLength
    end
    self.heightMG = heightMG
    self.eachRowBtnNum = math.floor(bgLength / RIGHTUP_CELL_SPACE)
    
    -- print(" btnPos.x =22==  ", bgLength, maxLength, heightMG)

    -- 横幅底图
    if heightMG == 1 then
        self.rightUpBg:setSize(bgLength + RIGHTUP_BG_EXTRA_SPACE, 52 * heightMG)
    else
        self.rightUpBg:setSize(bgLength + RIGHTUP_BG_EXTRA_SPACE, 65 * heightMG)
        self.rightUpBg:setPosition((RIGHTUP_LAYOUT_WIDTH + self.rightUpSwitchBtn:getContentSize().width)/2, RIGHTUP_LAYOUT_HEIGHT/2 - 13 * (heightMG - 1))
    end

    -- 按钮列表框（为了跟底图分开展开）
    self.rightUpBtnLayer:setSize(self.rightUpBg:getContentSize().width, self.rightUpBg:getContentSize().height)
    self.rightUpBtnLayer:centerRight((RIGHTUP_LAYOUT_WIDTH - self.rightUpSwitchBtn:getContentSize().width)/2)

    self:updateBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightUp)
end

function NewTownBtnUILayer:createRightBanner()
    -- 计算横幅长度
    local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_Right)
    local btnNum = table.nums(btnListData)
    local bgLength = btnNum * RIGHT_CELL_SPACE + RIGHT_BG_EXTRA_SPACE
    -- 横幅底图
    local rightBg = UI.Image9:create()
    rightBg:init("ui_maincity_bg_02.png", cc.rect(0,50,52,50), cc.size(52, bgLength))
    rightBg._enableAutoUpdatePos = false
    rightBg:setPosition(RIGHTUP_LAYOUT_WIDTH/2 - 1, (RIGHTUP_LAYOUT_HEIGHT - self.rightUpSwitchBtn:getContentSize().height)/2 - 1)
    rightBg:setIgnoreAnchorPointForPosition(false)
    rightBg:setAnchorPoint(cc.p(0.5, 1))
    -- rightBg:enableDebugDraw()
    self.rightUpLayout:addChild(rightBg)
    self.rightBg = rightBg

    -- 按钮列表框（为了跟底图分开展开）
    local rightBtnLayer = UI.Layout:create()
    rightBtnLayer:init()
    rightBtnLayer:setSize(rightBg:getContentSize().width, rightBg:getContentSize().height)
    rightBtnLayer:centerUp((RIGHTUP_LAYOUT_HEIGHT + self.rightUpSwitchBtn:getContentSize().height)/2)
    -- rightBtnLayer:enableDebugDraw()
    self.rightUpLayout:addChild(rightBtnLayer)
    self.rightBtnLayer = rightBtnLayer

    self:updateBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_Right)
end

function NewTownBtnUILayer:updateRightBanner()
    -- 计算横幅长度
    local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_Right)
    local btnNum = table.nums(btnListData)
    local bgLength = btnNum * RIGHT_CELL_SPACE + RIGHT_BG_EXTRA_SPACE
    -- 横幅底图
    self.rightBg:setSize(52, bgLength)

    -- 按钮列表框（为了跟底图分开展开）
    self.rightBtnLayer:setSize(self.rightBg:getContentSize().width, self.rightBg:getContentSize().height)
    self.rightBtnLayer:centerUp((RIGHTUP_LAYOUT_HEIGHT + self.rightUpSwitchBtn:getContentSize().height)/2)

    self:updateBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_Right)
end

function NewTownBtnUILayer:createRightBottomBanner()
    -- 计算横幅长度
    local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightBottom)
    local btnNum = table.nums(btnListData)
    local bgLength = btnNum * RIGHTDOWN_CELL_SPACE + RIGHTDOWN_BG_EXTRA_SPACE + RIGHTDOWN_MORE_SPACE + Avalon.issUtil:getRightMargin()
    -- 横幅底图
    local rightBottomBg = UI.Image9:create()
    rightBottomBg:init("ui_maincity_bg_03.png", cc.rect(100,0,150,65), cc.size(bgLength, 65))
    rightBottomBg._enableAutoUpdatePos = false
    rightBottomBg:setPosition(rightBottomBg:getContentSize().width - 48, RIGHTDOWN_LAYOUT_HEIGHT/2)
    rightBottomBg:setIgnoreAnchorPointForPosition(false)
    rightBottomBg:setAnchorPoint(cc.p(1, 0.5))
    -- rightBottomBg:enableDebugDraw()
    self.rightBottomLayout:addChild(rightBottomBg)
    self.rightBottomBg = rightBottomBg

    -- 右下角按钮
    local rightBottomSwitchBtn = UI.Button:create()
    rightBottomSwitchBtn:init("ui_activity_right_0.png", "ui_activity_left_0.png")
    rightBottomSwitchBtn:centerLeft(2)
    rightBottomSwitchBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.rightBottomSwitchClick)
    self.rightBottomBg:addChild(rightBottomSwitchBtn, 100)
    -- rightBottomSwitchBtn:enableDebugDraw()
    self.rightBottomSwitchBtn = rightBottomSwitchBtn

    local maxLevelData = GameDataManager:getMaster():getMaxLevelData(PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    local caveLevel = maxLevelData:getMaxLevel()

    if caveLevel >= 10 then
        self:rightBottomSwitchClick()
    end

    self:updaterightBottomSwitchBtn()

    -- 按钮列表框（为了跟底图分开展开）
    local rightBottomBtnLayer = UI.Layout:create()
    rightBottomBtnLayer:init()
    rightBottomBtnLayer:setSize(rightBottomBg:getContentSize().width, rightBottomBg:getContentSize().height)
    rightBottomBtnLayer:center()
    -- rightBottomBtnLayer:enableDebugDraw()
    rightBottomBg:addChild(rightBottomBtnLayer)
    self.rightBottomBtnLayer = rightBottomBtnLayer

    self:updateBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightBottom)
end

function NewTownBtnUILayer:updateRightBottomBanner()
    -- 计算横幅长度
    local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightBottom)
    local btnNum = table.nums(btnListData)
    local bgLength = btnNum * RIGHTDOWN_CELL_SPACE + RIGHTDOWN_BG_EXTRA_SPACE + RIGHTDOWN_MORE_SPACE + Avalon.issUtil:getRightMargin()
    -- 横幅底图
    self.rightBottomBg:setSize(bgLength, 65)

    self:updaterightBottomSwitchBtn()

    -- 按钮列表框（为了跟底图分开展开）
    self.rightBottomBtnLayer:setSize(self.rightBottomBg:getContentSize().width, self.rightBottomBg:getContentSize().height)
    self.rightBottomBtnLayer:center()

    self:updateBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightBottom)
end

-- 刷新按钮状态，包括显示隐藏
function NewTownBtnUILayer:updateBtnListByPosType(posType)
    local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(posType)

    if not self.btnCellList then
        self.btnCellList = {}
    end

    if not self.btnCellList[posType] then
        self.btnCellList[posType] = {}
    end

    for k, v in ipairs(btnListData) do
        if posType == 5 then
            -- 特殊按钮组
            self:createSpecialBtn()
        else
            self:createBtnByData(k, v)
        end
    end

    -- 用于清空不存在的按钮（self.btnCellList中存在但本次刷新不存在于btnListData了，说明不显示，直接清除）
    for k, v in pairs(self.btnCellList[posType]) do
        if v.isExist then
            v.isExist = false
        else
            v.btn:removeFromParent()
            self.btnCellList[posType][k] = nil
        end
    end
end

-- 根据按钮的btnPosType和按钮在列表的排序（不是btnOrder）进行位置计算
function NewTownBtnUILayer:getBtnPos(posType, btnOrder)
    local btnPos = cc.p(0, 0)

    if posType == NewTownBtnPosType.NewTownBtnPosType_RightUp then

        -- local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightUp)
        -- local btnNum = table.nums(btnListData)

        -- local bgLength = btnNum * RIGHTUP_CELL_SPACE
        -- local maxLength = winSize.width * 0.62 - RIGHTUP_BG_EXTRA_SPACE
        -- local heightMG = math.ceil(bgLength / maxLength)
        -- local lineNum = math.floor(maxLength / RIGHTUP_CELL_SPACE)

        -- print("   caocaocaocoa   !~~")
        -- print(debug.traceback())
        if self.eachRowBtnNum and self.heightMG then
            btnPos.x = (self.eachRowBtnNum - (btnOrder - 1)%self.eachRowBtnNum - 1) * RIGHTUP_CELL_SPACE + 20
            if self.heightMG == 1 then
                btnPos.y = 0
            else
                btnPos.y = 65 * (self.heightMG - math.ceil(btnOrder / self.eachRowBtnNum))
            end

            -- print(" btnPos.x ===  ", btnPos.x, btnPos.y , bgLength, maxLength, self.heightMG,self.eachRowBtnNum)
        else
            local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightUp)
            local btnNum = table.nums(btnListData)

            btnPos.x = (btnNum - btnOrder) * RIGHTUP_CELL_SPACE + 20
            btnPos.y = 0
        end

        -- btnPos.x = (btnNum - btnOrder) * RIGHTUP_CELL_SPACE + 20
        -- btnPos.y = 0
    elseif posType == NewTownBtnPosType.NewTownBtnPosType_Right then
        local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_Right)
        local btnNum = table.nums(btnListData)

        btnPos.x = -6
        btnPos.y = (btnNum - btnOrder) * RIGHT_CELL_SPACE + 28
    elseif posType == NewTownBtnPosType.NewTownBtnPosType_RightBottom then
        local btnListData = NewTownBtnUIDataManager:getTownBtnListByPosType(NewTownBtnPosType.NewTownBtnPosType_RightBottom)
        local btnNum = table.nums(btnListData)

        btnPos.x = (btnNum - btnOrder) * RIGHTDOWN_CELL_SPACE + 74
        btnPos.y = 14
    end

    return btnPos
end

function NewTownBtnUILayer:createBtnByData(index, btnData)
    local btnPos = self:getBtnPos(btnData.btnPosType, index)

    -- 名称位置
    local namePosY = {
        38,
        38,
        44,
    }

    -- 动效按钮底图
    local animBtnBg = {
        "ui_maincity_btn2_conventional.png;ui_maincity_btn2_selected.png",
        "ui_maincity_btn2_conventional.png;ui_maincity_btn2_selected.png",
        "ui_maincity_btn_conventional.png;ui_maincity_btn_selected.png",
    }

    -- 按钮所在父节点
    local parentList = {
        self.rightUpBtnLayer,
        self.rightBtnLayer,
        self.rightBottomBtnLayer,
    }

    if not self.btnCellList[btnData.btnPosType][btnData.ID] then

        if btnData.btnOpenType == NewTownBtnUIDataManager:getOpenTypeList().NewTownBtnOpenType_CrystalTreature_Activity then
            if not mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature) then
                -- 超过活动时间
                return
            end
        end

        local btn = UI.Button:create()
        btn:init("ui_maincity_btn2_conventional.png", "ui_maincity_btn2_selected.png")
        -- 关闭封装组件相对位置更新，使用原生setPosition，涉及动作
        btn._enableAutoUpdatePos = false
        btn:setPosition(btnPos)
        btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            printInfo("click this btn is ".. btnData.name.. " btnOpenType : "..btnData.btnOpenType)
            -- 判断是否有打开的附属按钮
            if btnData and table.nums(btnData.relateTo) > 0 then
                self:showOtherBtnByOpenType(btnData.btnOpenType)
            else
                NewTownBtnUIDataManager:callTownBtnClick(btnData.btnOpenType)
            end
        end)
        parentList[btnData.btnPosType]:addChild(btn)

        -- 加入按钮列
        self.btnCellList[btnData.btnPosType][btnData.ID] = {}
        self.btnCellList[btnData.btnPosType][btnData.ID].btn = btn
        self.btnCellList[btnData.btnPosType][btnData.ID].isExist = true

        local iconName = nil
        if btnData.btnIcon and btnData.btnIcon ~= "" then
            iconName = string.split(btnData.btnIcon, ";")
        elseif btnData.btnAnimName and btnData.btnAnimName ~= "" then
            iconName = string.split(animBtnBg[btnData.btnPosType], ";")

            local btnAnim = UI.Animation:create()
            btnAnim:init(btnData.btnAnimName..".json", btnData.btnAnimName..".atlas", 1)
            btnAnim:center()
            btnAnim:enableDebugDraw()
            btnAnim:setAnimation("idle1", true)
            btnAnim:setName("btnAnim")
            btn:addChild(btnAnim, 100)
        end
        -- 修改btn图片
        btn:setNormal(iconName[1])
        btn:setSelected(iconName[2])

        local nameText = UI.Text:create()
        nameText:init(btnData.name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
        if btnData.btnPosType ~= NewTownBtnPosType.NewTownBtnPosType_RightBottom then
            nameText:setSize(82, 40)
        end
        nameText:setTextHorizontalCenter()
        nameText:setLineSpacing(-6)
        -- nameText:enableDebugDraw()
        nameText:centerUp(namePosY[btnData.btnPosType])
        btn:addChild(nameText, 200)

        -- 名称阴影
        local nameShadowText = UI.Text:create()
        nameShadowText:init(btnData.name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_0_0_0)
        if btnData.btnPosType ~= NewTownBtnPosType.NewTownBtnPosType_RightBottom then
            nameShadowText:setSize(82, 40)
        end
        nameShadowText:setTextHorizontalCenter()
        nameShadowText:setLineSpacing(-6)
        nameShadowText:centerUp(namePosY[btnData.btnPosType] + 3)
        btn:addChild(nameShadowText, 199)

        -- 右下角按钮名称有底图
        if btnData.btnPosType == NewTownBtnPosType.NewTownBtnPosType_RightBottom then
            nameText:autoAdapt()
            nameText:updateView()

            local nameBg = UI.Image9:create()
            nameBg:init("ui_maincity_namebg.png", cc.rect(25,0,30,22), cc.size(nameText:getContentSize().width + 26, 22))
            nameBg:centerUp(namePosY[btnData.btnPosType])
            btn:addChild(nameBg, 100)
        end

        -- 按钮红点
        local redPoint = AvalonUtil.createRedPoint(btn, 2, 2, 100)
        redPoint:setName("redPoint")
        if NewTownBtnUIDataManager:getTownBtnRedPointShow(btnData.btnOpenType) then
            redPoint:show()
        else
            redPoint:hide()
        end
    else
        local btn = self.btnCellList[btnData.btnPosType][btnData.ID].btn
        btn:setPosition(btnPos)

        -- 被刷新的按钮不会被删除（新数据无该按钮时，按钮不会刷新到，直接删除）
        self.btnCellList[btnData.btnPosType][btnData.ID].isExist = true

        -- 按钮红点
        local redPoint = btn:getChildByName("redPoint")
        if redPoint and not tolua.isnull(redPoint) then
            if NewTownBtnUIDataManager:getTownBtnRedPointShow(btnData.btnOpenType) then
                redPoint:show()
            else
                redPoint:hide()
            end
        end
    end
end

-- 单一功能刷新按钮红点
function NewTownBtnUILayer:refreshBtnRedPoint()
    if not self.btnCellList then
        return
    end

    for posType, _ in pairs(self.btnCellList) do
        local btnInfoList = NewTownBtnUIDataManager:getTownBtnListByPosType(posType)
        for _, cellInfo in pairs(btnInfoList) do
            self:updateBtnRedPoint(cellInfo.btnOpenType)
        end
    end

    if self.functionPanel and not tolua.isnull(self.functionPanel) then
        self.functionPanel:refreshBtnRedPoint()
    end
end

function NewTownBtnUILayer:updateBtnRedPoint(btnOpenType)
    local btnData = NewTownBtnUIDataManager:getTownBtnDataByOpenType(btnOpenType)
    local cellInfo = self.btnCellList[btnData.btnPosType][btnData.ID]
    if not cellInfo or not tolua.isnull(cellInfo) then
        return
    end

    local btn = cellInfo.btn
    if not btn then
        return
    end

    -- 按钮红点
    local redPoint = btn:getChildByName("redPoint")
    if redPoint and not tolua.isnull(redPoint) then
        if NewTownBtnUIDataManager:getTownBtnRedPointShow(btnOpenType) then
            redPoint:show()
        else
            redPoint:hide()
        end
    end
end

function NewTownBtnUILayer:rightUpSwitchClick()
    if self.btnRunActioning then
        return
    end

    self:showRightUpLayoutAction()

    self.rightUpSwitchOpen = not self.rightUpSwitchOpen
    self:updaterightUpSwitchBtn()
end

function NewTownBtnUILayer:showRightUpLayoutAction()
    local totalTime = 0.2
    local fadeTime = 0.2
    self.btnRunActioning = true

    if self.rightUpSwitchOpen then
        self.rightUpBg:runAction(cc.Sequence:create(
            cc.CallFunc:create(function()
                self.rightUpBtnLayer:runAction(cc.Sequence:create(
                    cc.FadeOut:create(fadeTime),
                    cc.CallFunc:create(function()
                        self.rightUpBtnLayer:hide()
                    end)
                ))
            end),
            cc.DelayTime:create(fadeTime - 0.1),
            cc.EaseSineIn:create(cc.ScaleTo:create(totalTime, 0, 1)),
            cc.CallFunc:create(function()
                self.btnRunActioning = false
            end)
        ))

        self.rightBg:runAction(cc.Sequence:create(
            cc.CallFunc:create(function()
                self.rightBtnLayer:runAction(cc.Sequence:create(
                    cc.FadeOut:create(fadeTime),
                    cc.CallFunc:create(function()
                        self.rightBtnLayer:hide()
                    end)
                ))
            end),
            cc.DelayTime:create(fadeTime - 0.1),
            cc.EaseSineIn:create(cc.ScaleTo:create(totalTime, 1, 0))
        ))
    else
        self.rightUpBg:runAction(cc.Sequence:create(
            cc.EaseSineIn:create(cc.ScaleTo:create(totalTime, 1)),
            cc.CallFunc:create(function()
                self.rightUpBtnLayer:runAction(cc.Sequence:create(
                    cc.CallFunc:create(function()
                        self.rightUpBtnLayer:show()
                    end),
                    cc.FadeIn:create(fadeTime),
                    cc.CallFunc:create(function()
                        self.btnRunActioning = false
                    end)
                ))
            end)
        ))

        self.rightBg:runAction(cc.Sequence:create(
            cc.EaseSineIn:create(cc.ScaleTo:create(totalTime, 1)),
            cc.CallFunc:create(function()
                self.rightBtnLayer:runAction(cc.Sequence:create(
                    cc.CallFunc:create(function()
                        self.rightBtnLayer:show()
                    end),
                    cc.FadeIn:create(fadeTime)
                ))
            end)
        ))
    end
end

function NewTownBtnUILayer:updaterightUpSwitchBtn()
    if self.rightUpSwitchOpen then
        self.rightUpSwitchBtn:setNormal("ui_maincity_drawer_01.png")
        self.rightUpSwitchBtn:setSelected("ui_maincity_drawer_01_selected.png")
    else
        self.rightUpSwitchBtn:setNormal("ui_maincity_drawer_02.png")
        self.rightUpSwitchBtn:setSelected("ui_maincity_drawer_02_selected.png")
    end
end

function NewTownBtnUILayer:rightBottomSwitchClick()
    if self.btnRunActioning then
        return
    end

    self:showRightBottomLayoutAction()

    self.rightBottomSwitchOpen = not self.rightBottomSwitchOpen
    self:updaterightBottomSwitchBtn()
end

function NewTownBtnUILayer:showRightBottomLayoutAction()
    local totalTime = 0.3
    self.btnRunActioning = true

    if self.rightBottomSwitchOpen then
        self.rightBottomBg:runAction(cc.Sequence:create(
            cc.EaseBackIn:create(cc.MoveTo:create(totalTime, cc.p(self.rightBottomBg:getContentSize().width - 48, RIGHTDOWN_LAYOUT_HEIGHT/2))),
            cc.CallFunc:create(function()
                self.btnRunActioning = false
            end)
        ))
    else
        self.rightBottomBg:runAction(cc.Sequence:create(
            cc.EaseBackOut:create(cc.MoveTo:create(totalTime, cc.p(RIGHTDOWN_LAYOUT_WIDTH + RIGHTDOWN_MORE_SPACE, RIGHTDOWN_LAYOUT_HEIGHT/2))),
            cc.CallFunc:create(function()
                self.btnRunActioning = false
            end)
        ))
    end
end

function NewTownBtnUILayer:updaterightBottomSwitchBtn()
    if self.rightBottomSwitchOpen then
        self.rightBottomSwitchBtn:setNormal("ui_activity_right_0.png")
        self.rightBottomSwitchBtn:setSelected("ui_activity_right_1.png")
    else
        self.rightBottomSwitchBtn:setNormal("ui_activity_left_0.png")
        self.rightBottomSwitchBtn:setSelected("ui_activity_left_1.png")
    end
end

-- 部分按钮点击后会展示多个按钮（适配部分NPC功能，点击后有多个功能按钮）
function NewTownBtnUILayer:showOtherBtnByOpenType(openType)
    local btnData = NewTownBtnUIDataManager:getTownBtnDataByOpenType(openType)
    if not btnData or not btnData.relateTo then
        printError("not found btnData or btnData.relateTo ! openType : "..openType)
        return
    end

    local openTypeArr = btnData.relateTo
    if table.nums(openTypeArr) <= 0 then
        printError("btnData.relateTo num is less than one ! openType : "..openType)
        return
    end

    local dataArr = {}
    for _,type in pairs(openTypeArr) do
        if NewTownBtnUIDataManager:getTownBtnIsShow(type) then
            table.insert(dataArr, type)
        end
    end

    if(dataArr == nil or #dataArr == 0) then
        printError("ConfigManager:getFunctionNPCButtonByFunctionType get nil ! openType : "..openType)
        return
    end

    local btn = self.btnCellList[btnData.btnPosType][btnData.ID].btn
    local btnPos = cc.p(0, 0)
    btnPos.x, btnPos.y = btn:getPosition()
    local btnWorldPos = btn:getParent():convertToWorldSpace(btnPos)
    local btnSize = btn:getContentSize()
    require "app.ui.newTownBtnUI.NewFunctionPanel"
    local functionPanel = UI.NewFunctionPanel:create()
    self.functionPanel = functionPanel
    functionPanel:init(dataArr, btnWorldPos, btnSize, function()

    end)
    functionPanel:center()
    functionPanel:setName("FunctionPanel")
    UI.UIManager:getRootNode():addChild(functionPanel, UI_ZORDER.MAIN_UI)
end

function NewTownBtnUILayer:createSpecialBtn()

    -- 创建学徒按钮
    self:createApprenticeBtn()

    -- 创建导师按钮
    self:createMentorBtn()

    -- 创建录制按钮
    -- 策划要求暂时屏蔽，不调用
    -- self:createScreenRecord()
end

------- 特殊按钮逻辑 ------------------------
function NewTownBtnUILayer:createApprenticeBtn()
    -- 学徒按钮
    local ApprenticeDataList = mvc.apprenticeshipModel:getApprenticeArr() or {}
    for index = 1, 2 do
        -- 设置opentype
        local btnOpenType = BtnOpenTypeList["NewTownBtnOpenType_Apprentice"..index]
        local btnData = NewTownBtnUIDataManager:getTownBtnDataByOpenType(btnOpenType)
        -- 由于学徒数据都是有序数组，所以第一个不存在，后续也不存在，直接return
        if not NewTownBtnUIDataManager:getTownBtnIsShow(btnOpenType) then
            return
        end

        local data = ApprenticeDataList[index]
        if not data or not data.sex or not data.faceDecodeID then
            return
        end

        if not self.btnCellList[btnData.btnPosType][btnData.ID] then
            local apprenticeLayout = UI.Layout:create()
            apprenticeLayout:init()
            apprenticeLayout:setSize(70, 70)
            apprenticeLayout:rightBottom(30 + (index - 1) * 70 + Avalon.issUtil:getRightMargin(), 100)
            self:addChild(apprenticeLayout)

            -- 加入按钮列
            self.btnCellList[btnData.btnPosType][btnData.ID] = {}
            self.btnCellList[btnData.btnPosType][btnData.ID].btn = apprenticeLayout
            self.btnCellList[btnData.btnPosType][btnData.ID].isExist = true

            -- 这里记录一下编号，点击触发使用
            apprenticeLayout._layout_index = index
            apprenticeLayout:setTouchEnable(true)
            apprenticeLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
                printInfo("click this btn is ".. btnData.name.. " btnOpenType : "..btnOpenType)
                NewTownBtnUIDataManager:callTownBtnClick(btnOpenType)
            end)

            -- 导师学徒获得赞奖励按钮
            local likeBtn = UI.Button:create()
            likeBtn:init("ui_mentor_icon_good_0.png", "ui_mentor_icon_good_1.png", "ui_mentor_icon_good_0.png")
            likeBtn:leftUp(2, 0)
            likeBtn:setName("likeBtn")
            likeBtn:hide()
            likeBtn:setEnableMinTouchSize(false)
            apprenticeLayout:addChild(likeBtn, 10)
            likeBtn:setInterval(1)
            likeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                mvc.send(mvc.events.Mentor_Tutor_Interact_Message, apprenticeLayout._layout_index)
            end)

            -- 按钮红点
            local redPoint = AvalonUtil.createRedPoint(apprenticeLayout, 12, 12, 100)
            redPoint:setName("redPoint")
        end

        local apprenticeLayout = self.btnCellList[btnData.btnPosType][btnData.ID].btn
        self.btnCellList[btnData.btnPosType][btnData.ID].isExist = true

        if apprenticeLayout:getChildByName("headWrapper") and not tolua.isnull(apprenticeLayout:getChildByName("headWrapper")) then
            apprenticeLayout:removeChildByName("headWrapper")
        end

        -- ApprenticeshipLayer脚本处生成头像
        local headWrapper = UI.Component:create()
        headWrapper:init()
        headWrapper:setName("headWrapper")
        headWrapper:setScale(0.6)
        headWrapper:center()
        apprenticeLayout:addChild(headWrapper)

        local bg = UI.Image:create()
        bg:init("ui_information_headframe_bottom.png")
        bg:center()
        headWrapper:addChild(bg, 1)

        -- 放入遮罩
        local frame = UI.Image:create()
        frame:init("ui_information_headframe_box2.png")
        frame:center()
        headWrapper:addChild(frame, 5)

        -- 异步生成头像
        Avalon.WidgetUtil:getHeadByData(self, data.sex, data.faceDecodeID, {}, self, handler(self, function(self, pic, a)
            if (not tolua.isnull(headWrapper)) then
                -- 判断是否使用黑白
                local rawPic = pic:getChildByName("pic")
                if (not data.userID  or data.userID == 0) then
                    rawPic:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
                else
                    rawPic:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
                end
                apprenticeLayout.__rawPic = rawPic
                headWrapper:addChild(pic, 2)
            end
        end))

        -- 显示导师方学徒1头上的交互领奖按钮
        local app1InteractReward, app1LastInteract = mvc.apprenticeshipModel:mentorIsAbleToGetInteractRewardByIndex(index)
        local likeBtn = apprenticeLayout:getChildByName("likeBtn")
        if app1InteractReward and likeBtn and not tolua.isnull(likeBtn) then
            if (app1LastInteract == nil or app1LastInteract == mvc.apprenticeshipModel.INTERACT_TYPE.PRAISE) then
                likeBtn:setNormal("ui_mentor_icon_good_0.png")
                likeBtn:setSelected("ui_mentor_icon_good_1.png")
                likeBtn:setDisabled("ui_mentor_icon_good_0.png")
            else
                likeBtn:setNormal("ui_mentor_icon_lose_0.png")
                likeBtn:setSelected("ui_mentor_icon_lose_1.png")
                likeBtn:setDisabled("ui_mentor_icon_lose_0.png")
            end
            likeBtn:show()
        else
            likeBtn:hide()
        end

        local redPoint = apprenticeLayout:getChildByName("redPoint")
        if redPoint and not tolua.isnull(redPoint) then
            if NewTownBtnUIDataManager:getTownBtnRedPointShow(btnOpenType) then
                redPoint:show()
            else
                redPoint:hide()
            end
        end
    end
end

function NewTownBtnUILayer:createMentorBtn()
    -- 设置opentype
    local btnOpenType = BtnOpenTypeList.NewTownBtnOpenType_Mentor
    local btnData = NewTownBtnUIDataManager:getTownBtnDataByOpenType(btnOpenType)
    -- 由于学徒数据都是有序数组，所以第一个不存在，后续也不存在，直接break
    if not NewTownBtnUIDataManager:getTownBtnIsShow(btnOpenType) then
        return
    end

    local data = mvc.apprenticeshipModel:getMentor()
    if not data or not data.sex or not data.faceDecodeID then
        return
    end

    if not self.btnCellList[btnData.btnPosType][btnData.ID] then
        local apprenticeLayout = UI.Layout:create()
        apprenticeLayout:init()
        apprenticeLayout:setSize(70, 70)
        apprenticeLayout:rightBottom(30 + Avalon.issUtil:getRightMargin(), 100)
        self:addChild(apprenticeLayout)

        -- 加入按钮列
        self.btnCellList[btnData.btnPosType][btnData.ID] = {}
        self.btnCellList[btnData.btnPosType][btnData.ID].btn = apprenticeLayout
        self.btnCellList[btnData.btnPosType][btnData.ID].isExist = true

        apprenticeLayout:setTouchEnable(true)
        apprenticeLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            printInfo("click this btn is ".. btnData.name.. " btnOpenType : "..btnOpenType)
            NewTownBtnUIDataManager:callTownBtnClick(btnOpenType)
        end)

        -- 按钮红点
        local redPoint = AvalonUtil.createRedPoint(apprenticeLayout, 12, 12, 100)
        redPoint:setName("redPoint")
    end

    local apprenticeLayout = self.btnCellList[btnData.btnPosType][btnData.ID].btn
    self.btnCellList[btnData.btnPosType][btnData.ID].isExist = true

    if apprenticeLayout:getChildByName("headWrapper") and not tolua.isnull(apprenticeLayout:getChildByName("headWrapper")) then
        apprenticeLayout:removeChildByName("headWrapper")
    end

    -- ApprenticeshipLayer脚本处生成头像
    local headWrapper = UI.Component:create()
    headWrapper:init()
    headWrapper:setName("headWrapper")
    headWrapper:setScale(0.6)
    headWrapper:center()
    apprenticeLayout:addChild(headWrapper)

    local bg = UI.Image:create()
    bg:init("ui_information_headframe_bottom.png")
    bg:center()
    headWrapper:addChild(bg, 1)

    -- 放入遮罩
    local frame = UI.Image:create()
    frame:init("ui_information_headframe_box2.png")
    frame:center()
    headWrapper:addChild(frame, 5)

    -- 异步生成头像
    Avalon.WidgetUtil:getHeadByData(self, data.sex, data.faceDecodeID, {}, self, handler(self, function(self, pic, a)
        if (not tolua.isnull(headWrapper)) then
            -- 判断是否使用黑白
            local rawPic = pic:getChildByName("pic")
            if (not data.userID  or data.userID == 0) then
                rawPic:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
            else
                rawPic:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
            end
            apprenticeLayout.__rawPic = rawPic
            headWrapper:addChild(pic, 2)
        end
    end))

    local redPoint = apprenticeLayout:getChildByName("redPoint")
    if redPoint and not tolua.isnull(redPoint) then
        if NewTownBtnUIDataManager:getTownBtnRedPointShow(btnOpenType) then
            redPoint:show()
        else
            redPoint:hide()
        end
    end
end

--[[
    录制按钮，因原先设计，该按钮会一直存在，只区分显示或隐藏，所以这里判断为不显示的时候仅跳过按钮刷新逻辑，并不会清除按钮
    策划要求暂时屏蔽，不调用
]]
function NewTownBtnUILayer:createScreenRecord()

    local btnOpenType = BtnOpenTypeList.NewTownBtnOpenType_ScreenRecord
    local btnData = NewTownBtnUIDataManager:getTownBtnDataByOpenType(btnOpenType)

    if not self.btnCellList[btnData.btnPosType][btnData.ID] then
        --录屏按钮
        local screenRecordLayout = UI.Layout:create()
        screenRecordLayout:init()
        screenRecordLayout:setSize(70, 70)
        screenRecordLayout:rightBottom(30 + Avalon.issUtil:getRightMargin(), 170)
        self:addChild(screenRecordLayout)

        require "app.utils.ScreenRecordUtil"
        local offButton = "ui_button_videotape_0.png"
        local onButton = "ui_button_videotape_2.png"
        local initButton = ScreenRecordUtil:getInstance():getIsRecording() and onButton or offButton
        local screenRecordButton = UI.Button:create(UIType.SCREEN_RECORD_BUTTON)
        screenRecordButton:init(initButton, initButton, initButton)
        screenRecordButton:center()
        screenRecordLayout:addChild(screenRecordButton)

        -- 加入按钮列
        self.btnCellList[btnData.btnPosType][btnData.ID] = {}
        self.btnCellList[btnData.btnPosType][btnData.ID].btn = screenRecordButton
        self.btnCellList[btnData.btnPosType][btnData.ID].isExist = true

        local function changeIcon(isOn)
            if (isOn) then
                screenRecordButton:setNormal(onButton)
                screenRecordButton:setSelected(onButton)
                screenRecordButton:setDisabled(onButton)
            else
                screenRecordButton:setNormal(offButton)
                screenRecordButton:setSelected(offButton)
                screenRecordButton:setDisabled(offButton)
            end
            screenRecordButton:disable()
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                screenRecordButton:enable()
            end, 1)
        end

        -- 录屏按钮回调
        screenRecordButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if (ScreenRecordUtil:getInstance():getIsRecording()) then
                changeIcon(false)
                ScreenRecordUtil:getInstance():stopRecording(false, function()
                    local LanguageManager = require("app.game.LanguageManager")
                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111247)) --保存提示
                end)
            else
                changeIcon(true)
                ScreenRecordUtil:getInstance():startRecording(function() 
                    -- 开始成功(XCode BUG导致在调试时不可靠)
                end, function(errorCode)
                    -- 开始失败(XCode BUG导致在调试时不可靠)
                    changeIcon(false)
                    local errorString = ScreenRecordUtil:getInstance():getErrorString(errorCode)
                    UI.ScrollBar:createByText(errorString)
                end, function(errorCode)
                    -- 录制途中出现错误
                    changeIcon(false)
                    local errorString = ScreenRecordUtil:getInstance():getErrorString(errorCode)
                    UI.ScrollBar:createByText(errorString)
                end)
            end
        end)

        ScreenRecordUtil:getInstance():setOnOffStatusChangeCallback(function(isOn)
            self:refreshInfoBtn()
        end)
    end

    local screenRecordButton = self.btnCellList[btnData.btnPosType][btnData.ID].btn
    self.btnCellList[btnData.btnPosType][btnData.ID].isExist = true

    -- 判断是否显示，如果隐藏就跳过后续刷新逻辑
    if NewTownBtnUIDataManager:getTownBtnIsShow(btnOpenType) then
        screenRecordButton:setVisible(true)
    else
        screenRecordButton:setVisible(false)
    end
end

------- 特殊按钮逻辑 ------------------------