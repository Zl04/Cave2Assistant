------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2021/10/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GhostabyssSelectView = class("GhostabyssSelectView", UI.HWBtnComponent)
local winSize = cc.Director:getInstance():getWinSize()
local GameDataManager = require("app.game.GameDataManager")
-- 资源
local COM_RES_LIST = {
    "ui_town_ghostabyss.plist",
    "ui_common_icon_buffbig.plist"
}

local COM_WIDTH = 428
local COM_HEIGHT = 544

function GhostabyssSelectView:ctor(data)
    GhostabyssSelectView.super.ctor(
    	self,
    	UI.Type.GHOSTABYSS_SELECT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    print("GhostabyssSelectView extentInt", data)
    self.spriteID = data.spriteID
    self.npcID = data.extendInt
    -- 获取数据信息
    self:refreshData()

    self:bindModel()
end

function GhostabyssSelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    GhostabyssSelectView.super.init(self, ... )
end

function GhostabyssSelectView:dtor()
    GhostabyssSelectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.cave.GhostabyssSelectView")
end


function GhostabyssSelectView:onInitView()
    self:center()
    local halfBg = UI.Image9:create()
    halfBg:init("ui_ghostabyss_up_02.png", CCRectMake(2,2,1,1), cc.size(winSize.width*2, winSize.height*2))
    halfBg:center()
    self:addChild(halfBg)

    -- local bg = UI.Image:create()
    -- bg:init("ui_ghostabyss_bg_06.png")
    -- bg:center()
    -- self:addChild(bg)
    -- self.bg = bg
    local bg = UI.Layout:create()
    bg:init()
    bg:center()
    bg:setSize(428,544)
    self:addChild(bg)
    self.bg = bg

    local titleImage = UI.Image:create()
    titleImage:init("ui_ghostabyss_title_05.png")
    titleImage:centerUp(19)
    bg:addChild(titleImage,100)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1328015, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_WHITE)
    titleText:center(0,-7)
    titleImage:addChild(titleText)

    -- 图标表现
    local iconBg = UI.Image:create()
    iconBg:init("ui_ghostabyss_box.png")
    iconBg:center()
    iconBg:setTouchEnable(true)
    iconBg:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        if(self.haveBuffData ~= nil) then
            self:showBuffInfo()
        end
    end)
    iconBg:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        self:hideBuffInfo()
    end)
    self.iconBg = iconBg
    iconBg:setVisible(false)

    local icon = UI.Image:create()
    icon:init("ui_ghostabyss_box.png")
    icon:center()
    iconBg:addChild(icon)
    self.icon = icon
    

    local animation = self:createAnimation()
    animation:addComponent("location_icon", iconBg)
    animation:centerBottom(120)
    animation:setAnimation("idle", true)
    bg:addChild(animation)
    self.animation = animation


    -- 抽取价格
    local costLayout = UI.Layout:create();
    costLayout:init()
    costLayout:enableAutoWidth()
    -- costLayout:enableAutoHeight()
    costLayout:setSize(200, 0)
    costLayout:leftBottom(55, 98)
    bg:addChild(costLayout, 100)
    self.costLayout = costLayout

    local costImg  = UI.Image:create();
    costImg:init("icon_diamonds.png");  --icon_guild.png
    costImg:floatLeft(-15)
    costImg:setScale(0.5)
    costLayout:addComponent(costImg, 10)

    local costNumTxt = UI.Text:create()
    costNumTxt:init(""..self.diamonNum, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
    costNumTxt:floatLeft(-15)
    costLayout:addComponent(costNumTxt, 10)
    self._costNumTxt = costNumTxt

    -- 抽取按钮
    local extractButton = UI.Button:create()
    extractButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    extractButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        local startExtract = function()
            if(self.animation) then 
                if(self.haveBuffData) then 
                    self.animation:setAnimation("end", false)
                    self.animation:addAnimation("ready", false)
                else
                    self.animation:setAnimation("ready", false)
                end
                self.animation:addAnimation("loop", true)
                self.request = true
                self.loop = false
                self.requestBack = false
                self:refreshInfo()
                
                Net.NetNPCSystem:requestGhostAbyssBuff(2, self.npcID, self.spriteID)
                -- -- TODO 
                -- self:extractBack()
            end
        end


        if(self.haveBuffData) then 
            -- 二次框确认
            if(Avalon.MathUtil:checkDiamonEnough(self.diamonNum, GameDataManager:getInstance():getDiamond())) then
                -- 处理相关逻辑
                startExtract()
            else 
                -- 显示钻石不够
                -- 处理这里的层级
                local tips = UI.TipsLayer:onDiamondNotEnough(nil, cancelCallback,true)
                if(tips) then 
                    tips:setZOrder(UI_ZORDER.MAX)
                end
                tips:removeFromParent(false)
                UI.UIManager:getRootNode():addChild(tips)
            end
            
        else
            startExtract() 
        end
    end)
    extractButton:centerRight(20)
    extractButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    extractButton:setText(UI.TEXT_1150011)
    bg:addChild(extractButton)
    self.extractButton = extractButton

    -- 领取按钮
    local receiveButton = UI.Button:create()
    receiveButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    receiveButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        Net.NetNPCSystem:requestGhostAbyssBuff(1, self.npcID, self.spriteID)
    end)
    receiveButton:centerRight(20)
    receiveButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    receiveButton:setText(LanguageManager:getInstance():getLocalString(1110565))
    bg:addChild(receiveButton)
    receiveButton:rightBottom(14,29)
    self.receiveButton = receiveButton

    self:refreshInfo()
end

-- 请求返回值
function GhostabyssSelectView:extractResponse(data)
    self:refreshData()
    if(data) then 
        local ProtobufUtil = require("utils.ProtobufUtil")
        local operationData = ProtobufUtil:decode("NPCSystem.GhostAbyssBuffOperationData", data.resultData)
        if(operationData.opType == ProtobufUtil:enum_id("NPCSystem.GhostAbyssBuffOpType","GhostAbyssBuffOpType_Claim")) then 
            UI.ScrollBar:createByText(UI.TEXT_1212026)
            Avalon.Scheduler:scheduleUpdateOnce(self, function()  
                if not tolua.isnull(self) then
                    mvc.closePanel("Cave", "GhostabyssSelect")
                end
            end, 0.01) 
            return
        end
    end

    if(self.loop) then
        if(self.animation) then 
            self.animation:setAnimation("free", false)
            self.animation:addAnimation("idle", true)
        end
    else
        self.requestBack = true
    end
end

function GhostabyssSelectView:refreshData()
    -- 获取数据信息
    local buffID = mvc.caveModel:getBufferIDGhostAbyssSceneInfoData(self.npcID)
    if(buffID ~= 0) then
        self.haveBuffData = SkillDataManager:createBufferData(buffID)
    else 
        self.haveBuffData = nil
    end
    self.diamonNum = mvc.caveModel:getRefreshDiamondGhostAbyssSceneInfoData(self.npcID)
end

function GhostabyssSelectView:showBuffInfo()
    if(self.buffInfo == nil) then
        local bg =  UI.Image9:create()
        bg:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(340, 0))
        bg:centerBottom(220)
        bg:setSize(340,0)
        self.bg:addChild(bg)
        self.buffInfo = bg

        local desTxt = UI.Text:create()
        desTxt:init("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
        desTxt:setWidth(320)
        desTxt:center()
        desTxt:setTextCenter()
        desTxt:autoAdapt()
        bg:addChild(desTxt, 100)
        self._desTxt = desTxt
    end

    self._desTxt:setText(self.haveBuffData.description)
    self.buffInfo:setSize(340, self._desTxt:getContentSize().height + 10)

    self.buffInfo:setVisible(true)
end

function GhostabyssSelectView:hideBuffInfo()
    if(self.buffInfo) then
        self.buffInfo:setVisible(false)
    end
end

function GhostabyssSelectView:refreshInfo()
    local haveDiamond = GameDataManager:getInstance():getDiamond()
    if(haveDiamond < self.diamonNum) then 
        self._costNumTxt:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    else
        self._costNumTxt:setFontColor(UI.FONT_COLOR_WHITE)
    end
    self._costNumTxt:setText(""..self.diamonNum)

    if(self.request) then
        self.extractButton:setVisible(false)
        self.receiveButton:setVisible(false)
        self.costLayout:setVisible(false)
        self.iconBg:setVisible(false)
    else
        if(self.haveBuffData == nil) then
            self.extractButton:setVisible(true)
            self.extractButton:centerBottom(29)
            self.receiveButton:setVisible(false)
            self.costLayout:setVisible(false)
            self.iconBg:setVisible(false)

            self.extractButton:setText(UI.TEXT_1328017)
        else
            self.iconBg:setVisible(true)
            local bigIconName = self.haveBuffData:getBigICON()
            --print("bigIconName", bigIconName)
            if(bigIconName)then
                self.icon:setSpriteName(bigIconName)
            end

            self.extractButton:leftBottom(14,29)
            self.receiveButton:setVisible(true)
            self.extractButton:setVisible(true)
            self.costLayout:setVisible(true)

            self.extractButton:setText(UI.TEXT_1170103)
        end
    end
end


function GhostabyssSelectView:bindModel()

end


function GhostabyssSelectView:unbindModel()

end

function GhostabyssSelectView:createAnimation()
    local name = string.format("effect_ui_twon_blessings%d", self.npcID)
    local selectItem = UI.Animation:create()
    selectItem:init(name .. ".json", name .. ".atlas")
    selectItem:setAnimation("idle", true)

    selectItem:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "free") then
            self.request = false
            self:refreshInfo()
        elseif (event.animation == "loop") then
            self.loop = true
            if(self.requestBack) then 
                if(self.animation) then 
                    self.animation:setAnimation("free", false)
                    self.animation:addAnimation("idle2", true)
                end
            end
        end
    end)
    return selectItem
end



return GhostabyssSelectView












