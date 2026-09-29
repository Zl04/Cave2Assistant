
--[[
    画册界面
]]


require "app.ui.Component"
require "app.ui.common.Tab.TabList"
require "app.ui.common.Animation"
require "app.ui.common.ScrollView"
require "app.ui.baglayer.PictureAlbum.PictureAlbumLayer"
require "app.net.NetPetSystem"
require "app.datas.PictureAlbumManager"

local LanguageManager = require("app.game.LanguageManager")

local petPictureProfile = require ("profiles/commonProfile/ProfilePetPicture")
local petTargetProfile = require ("profiles/commonProfile/ProfilePetTarget")

-- local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local PictureAlbumLayerUI = class("PictureAlbumLayerUI", UI.HWBtnComponent)
UI.PictureAlbumLayerUI = PictureAlbumLayerUI

local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 978
local COM_HEIGHT = 555

-- 背包资源
local COM_RES_LIST = {
}

local TAG_TYPE = {
}

-- 图片名字
local BUTTON_NORMAL = "ui_btn_gray2_0.png"
local BUTTON_ACTIVE = "ui_btn_gray2_1.png"
local BUTTON_DISABLE = "ui_btn_gray2_2.png"

-- 布局
local LOG_PANEL_LAYOUT = {

}

-- 构造函数
function PictureAlbumLayerUI:ctor(spriteID)
    PictureAlbumLayerUI.super.ctor(self, UIType.FUNCTION_TAB_PICTURE_ALBUM, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._scrollView = nil
    self._spriteID  = spriteID;
    self._views     = {}
    self._redpoint  = {}
    -- self:enableDebugDraw(UI.RED)
end

-- 析构函数
function PictureAlbumLayerUI:dtor()
    PictureAlbumLayerUI.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function PictureAlbumLayerUI:init()
    PictureAlbumLayerUI.super.init(self)
    self:registerListener()
end

-- 初始化视图
function PictureAlbumLayerUI:onInitView()

    -- 内容区域
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:centerBottom(0)
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    Net.NetPetSystem:pictureAlbumDataRequest()

    self:createFunctionTable()
    self:refreshTabState()
    -- self:refreshTaskRedPoint()
    -- self:refreshTreasureRedPoint()
end

-- 更新视图
function PictureAlbumLayerUI:onUpdateView()
    
end

-- 更新视图
function PictureAlbumLayerUI:createFunctionTable()
    
    -- TAB控件
    local functionTabList = UI.TabList:create()
    functionTabList:init(3,114,64)
    functionTabList:leftUp(865, 50)
    functionTabList:setTouchEnable(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex)
        self:choiceTabIndex(tabIndex)
    end)
    functionTabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    self._functionTabList = functionTabList
    self._functionTabList:setReverseOrder(true)

    if petPictureProfile then
        -- for k=#petPictureProfile,1,-1 do
        --     local data = petPictureProfile[k]
        for k,data in ipairs(petPictureProfile) do
            local functionTab = UI.FunctionTabItem:create()
            -- print("BUTTON_NORMAL ====== ",BUTTON_NORMAL,BUTTON_ACTIVE,BUTTON_DISABLE,LanguageManager:getInstance():getLocalString(data.name))
            functionTab:init(BUTTON_NORMAL, BUTTON_ACTIVE, BUTTON_DISABLE, LanguageManager:getInstance():getLocalString(data.name), UI.FONT_BOLD, UI.FONT_SIZE_20PX)
        
            -- self._redpointTask = AvalonUtil.createRedPoint(functionTab, 0, 0, 10)
            -- self._redpointTask:setVisible(false)
            functionTabList:addToTab(functionTab, k)
            -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
            functionTab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)

            local redpointTreasure = AvalonUtil.createRedPoint(functionTab, 0, 0, 10)
            redpointTreasure:setVisible(false)
            self._redpoint[k] = redpointTreasure
        end
    end

    -- 添加背景
    local bg =  cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png", CCRectMake(303,136,4,2))
    bg:setContentSize(852, 534)
    bg:setAnchorPoint(0, 0)
    bg:setPosition(15, 5)

    local detaultTag = self:getDefaultTag()
    self._contentLayout:addChild(bg,1)
    self._functionTabList:setDefaultIndex(detaultTag)
    self._contentLayout:addChild(functionTabList)
    self:choiceTabIndex(detaultTag)
end

function PictureAlbumLayerUI:getDefaultTag()
    return 1
end

function PictureAlbumLayerUI:choiceTabIndex(tabIndex)
    local panel = nil
    self:hideShareBtn()
    if not self._views[tabIndex] then
        panel = UI.PictureAlbumLayer:create(tabIndex)
        panel:init()

        if (panel) then 
            self._contentLayout:addChild(panel,1)
        end

        self._views[tabIndex] = panel
    end
    for i, view in pairs( self._views ) do
        if i ==  tabIndex then
            panel = view
            view:show()

            if self._redpoint[i] then
                local showRed = PictureAlbumManager:specifyPictureIsRedDot(tabIndex)
                -- print(" showRed ====== ",showRed,tabIndex)
                self._redpoint[i]:setVisible(showRed)
            end
        else
            view:hide()
            view:centerBottom(winSize.height * 2)
            
            if self._redpoint[i] then
                local showRed = PictureAlbumManager:specifyPictureIsRedDot(i)
                -- print(" showRed ==222==== ",showRed,i)
                self._redpoint[i]:setVisible(showRed)
            end
        end
    end 
    
    if (panel) then 
        panel:leftBottom(15, 6)
        self._activePanel = panel
        self:showShareBtn()
    end

    -- Game.FunctionUnlockManager:getInstance():removeNewFlag(tabIndex)
end

function PictureAlbumLayerUI:refreshRedPoint()

    -- if self._views then
    --     print("self._views === ",self._views)
    --     for i, view in pairs( self._views ) do
    --         if self._redpoint[i] then
    --             local showRed = PictureAlbumManager:specifyPictureIsRedDot(i)
    --             self._redpoint[i]:setVisible(showRed)
    --         end
    --     end 
    -- end

    if self._redpoint then
        for i, redpoint in pairs( self._redpoint ) do
            local showRed = PictureAlbumManager:specifyPictureIsRedDot(i)
            redpoint:setVisible(showRed)
        end 
    end

end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function PictureAlbumLayerUI:refreshTabState()
    if not self._functionTabList then return end
    for k, v in pairs(self._functionTabList._compList) do
        self:playTabItemAction(v, k)
    end
end

function PictureAlbumLayerUI:playTabItemAction(tabItem, functionType)
    -- if Game.FunctionUnlockManager:getInstance():isShowUnlockAction(functionType) then
    --     tabItem:disable()
    --     tabItem:playUnlockAction(function()
    --         self:playUnlockActionCallback(tabItem, functionType)
    --     end)
    -- elseif Game.FunctionUnlockManager:getInstance():isShowNewAction(functionType) then
    --     tabItem:playNewAction(0.8)
    -- else
    --     tabItem:removeNewAction()
    -- end
end




function PictureAlbumLayerUI:showShareBtn(parentNode)
    if parentNode ~= nil then
        self.parentNode = parentNode
    end
    if self._activePanel and self._activePanel.showShareBtn then
        self._activePanel:showShareBtn(self.parentNode)
    end
end

function PictureAlbumLayerUI:hideShareBtn()
    if self.parentNode then
        self.parentNode:hideShareBtn()
    end
end



-- 注册监听事件(可选)
function PictureAlbumLayerUI:registerListener()
    -- --更新图册界面视图
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_PICTURE_ALBUM, self, self.createFunctionTable)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshRedPoint)
end


-- 注销监听事件(可选)
function PictureAlbumLayerUI:unRegisterListener()
    -- --更新图册界面视图
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_PICTURE_ALBUM, self, self.createFunctionTable)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshRedPoint)
end