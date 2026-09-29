--[[
    AUTHOR:ZIHANCHEN
    2017-4-27
    USING: 查看队友信息的UI
]]

require "app.ui.Component"
-- require "app.ui.baglayer.RoleShow.RoleShowArea"
require "app.ui.baglayer.RoleShow.RoleAnimation"
require "app.ui.baglayer.RoleShow.EquipmentIcon"
require "app.ui.baglayer.RoleShow.SelectEquipmentButton"
require "app.ui.team.BaseInfo"
require "app.ui.team.BaseMInfo"
require "app.ui.baglayer.GoodsTabItem"
require "app.ui.baglayer.FunctionTabItem"
require "app.ui.baglayer.InfoArea.BasicInfoArea"
require "app.ui.baglayer.RoleShow.RoleShowArea"
require "app.ui.baglayer.Grid.BagScrollView"
require "app.ui.baglayer.InfoArea.EquipmentInfoArea"
require "app.ui.baglayer.InfoArea.EquipmentPetInfoArea"
require "app.ui.baglayer.InfoArea.LevelBagInfoArea"
require "app.ui.baglayer.InfoArea.RandomBagInfoArea"
require "app.ui.baglayer.InfoArea.GemStoneInfoArea"
require "app.ui.baglayer.InfoArea.StarPrayInfoArea"
require "app.ui.baglayer.InfoArea.PetStoneInfoArea"

-- require "app.ui.team.EquipmentInfo"
UI = UI or {}
local GameDataManager = require("app.game.GameDataManager")
local ViewFriendInfoLayer = class("ViewFriendInfoLayer",UI.CenterWin)
UI.ViewFriendInfoLayer = ViewFriendInfoLayer
local winSize = cc.Director:getInstance():getWinSize()
local VIEW_FRIEDN_INFO_PLIST = {
}

-- 更新角色数据 roleData
local function updateRoleView(self,roleData,  wearEquipmentData)
    if (roleData) then
        self._roleShowArea:setData( roleData,wearEquipmentData)
        self._roleShowArea:updateView()
    end
end
-- 更新攻击强度、法力效果数据
local function updateBaseView(self, basedata)
    if (basedata) then
        self._baseinfo:setData(basedata)
        self._baseinfo:updateView()
    end
end

-- 装备详情的touch事件的处理
local function onEquipmentInfoAreaTouchHandler(self, equipmentInfoArea, touchPosition)
    equipmentInfoArea:close()
end

-- 角色展示区域装备格子被点击的处理器
local function onEquipmentGridClickHandler(self, equipmentGrid, equipmentPosition)
    if (equipmentGrid) then
        --点击同一装备两次
        if self._selectedRoleGrid == equipmentGrid then 
            -- self:closeChoese()
            -- return 
        end

        -- 装备详情
        local EquipmentInfo =  UI.EquipmentInfoArea:create()
        EquipmentInfo:init()
        local equipmentInfoArea = UI.EquipmentInfoArea:create()
        equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
        equipmentInfoArea:hideCompInfo()
        equipmentInfoArea:closeLockFlag()
        equipmentInfoArea:showStrength()
        -- EquipmentInfo:leftUp(210,-117)+
        self:addChild(equipmentInfoArea,999)
        self._equipmentInfoArea = equipmentInfoArea
        local goodsData = equipmentGrid:getData()
        local equipmentPosition = goodsData:getWearPosition()
        print("equipmentPosition-----",equipmentPosition)
        -- 左边的装备
        if  equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Helmet or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Gloves or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Weapon or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Ring then 
            -- equipmentInfoArea:leftUp(-260 - 40 + 80,70)
            equipmentInfoArea:leftUp(-260 - 44,70)
        elseif  equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Chest or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Shoulders or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Boots or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Amulet then
            -- equipmentInfoArea:leftUp(480 - 84,70)
            equipmentInfoArea:leftUp(480 - 57,70)
        end

        if self._data.heroData then
            goodsData.heroData = self._data.heroData
        end
        
        local activeNum = GameDataManager:getInstance():calculationWearSetActiveNum(goodsData:getEquipSetID(), self._data.wearEquipmentArr)
        -- print("self._data.wearEquipmentArr num=", #self._data.wearEquipmentArr, activeNum)

        self._equipmentInfoArea:updateView(goodsData, activeNum)
        -- self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, onEquipmentInfoAreaTouchHandler)
        -- self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onEquipmentInfoAreaTouchHandler)
        self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onEquipmentInfoAreaTouchHandler)

        self._selectedRoleGrid = equipmentGrid
    else
        -- assert(false)
        -- self:closeChoese()
        self._roleShowArea:unselectEquipment()
    end
end

function  ViewFriendInfoLayer:ctor()
    ViewFriendInfoLayer.super.ctor(self,UIType.VIEW_FRIEND_INFO,VIEW_FRIEDN_INFO_PLIST,443,513)
    self:setTouchEnable(true)
    -- self:setInterceptTouches(true)
    -- self:registerListener()
    self._equipmentInfoArea = nil
    self._data  = nil
    self._roleShowArea = nil
    self._roleLeftLayout = nil
    self._baseinfo = nil 
    self._isShowMainInfo = true
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_CHOICE_HERO)
    self:setNoticeShowMainUI(false) 

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_ROLE_IP, self, self.updateIPText)
end

function ViewFriendInfoLayer:dtor()
    self._data  = nil
    self._roleShowArea = nil
    self._equipmentInfoArea = nil
    self._roleLeftLayout = nil
     self._baseinfo = nil 
    ViewFriendInfoLayer.super.dtor(self)

    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_CHOICE_HERO)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_ROLE_IP, self, self.updateIPText)
end


function ViewFriendInfoLayer:init(Data)
    self._data  = Data
    -- dump(self._data)
    ViewFriendInfoLayer.super.init(self)
end

function ViewFriendInfoLayer:onInitView()
    AvalonUtil.runTipsAppearShowAnimation(self)

    --  整个背景图片
    local bgLayout = UI.Layout:create()
    bgLayout:init()
    bgLayout:setSize(443, 513)
    bgLayout:center()
    self:addChild(bgLayout)
    self._bigBg = bgLayout

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_character2.png")
    bg:setContentSize(443, 513)
    bg:setCapInsets(CCRectMake(7,7,1,1))
    bg:setPosition(bg:getContentSize().width/2, bg:getContentSize().height/2)
    bgLayout:addChild(bg)

    local data = self._data
    
    -- 称号
    self._titleText = UI.Text:create()
    self._titleText:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self:addChild(self._titleText)

    -- 名字
    self._nameText = UI.Text:create()
    self._nameText:init("", UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_155_155_155)
    self:addChild(self._nameText)

    -- 公会名字
    self._guildNameText = UI.Text:create()
    self._guildNameText:init("", UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_GUILD_NAME)
    self:addChild(self._guildNameText)

    -- 等级
    self._levelText = UI.Text:create()
    self._levelText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self._levelText:rightUp(62 - self._levelText:getContentSize().width/2, 38 - self._levelText:getContentSize().height/2)
    self:addChild(self._levelText)

    -- ip归属地
    self.ip = UI.Text:create()
    self.ip:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self.ip:rightBottom(62 - self.ip:getContentSize().width/2, 0)
    self:addChild(self.ip)
    
    -- local title = UI.Text:create()
    -- title:init(UI.TEXT_1212327, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_204_204_204)
    -- title:centerUp(12)
    -- self:addChild(title)
    -- title:hide()
    -- self.starTitle = title

         -- 添加分割线
    -- local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    -- lineUpImage:setContentSize(370, 1.2)
    -- lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    -- lineUpImage:setPosition(cc.p(220, 464))
    -- self:addChild(lineUpImage)
    -- lineUpImage:hide()
    -- self.lineUpImage = lineUpImage

    
    if data and data.heroData then 
        local heroData = data.heroData
        local titleID = heroData:getHeroTitleID()
        if (titleID == nil or titleID == 0) then
            self._titleText:setText("<" .. UI.TEXT_1172019 .. ">") -- 无称号
            self._titleText:setFontColor(UI.FONT_COLOR_155_155_155)
        else
            require("app.datas.TitleDataManager")
            local titleData = TitleDataManager:getTitleDataFromID(titleID, heroData.tutorName)
            if(titleData) then 
                self._titleText:setText("<" .. titleData:getTitleName() .. ">")
                self._titleText:setFontColor(titleData:getTitleColor()) 
            end
        end
        self._titleText:setTextHorizontalCenter()
        self._titleText:updateView()

        self._nameText:setText(heroData:getNickName())
        self._nameText:setTextLeft()

        self._guildNameText:setText(heroData:getGuildName())

        self._nameText:centerUp(8)
        self._guildNameText:centerUp(self._nameText:getUp() + self._nameText:getContentSize().height)
        self._titleText:centerUp(self._guildNameText:getUp() + self._guildNameText:getContentSize().height)

        local level, reinLv = heroData:getUIShowLv()
        local levelString = heroData:getIsReincarntion() and string.format(UI.TEXT_224311, reinLv, level) or level
        local level = string.format(UI.TEXT_224316, levelString)--heroData:getLevel())
        self._levelText:setText(level)
        -- self._levelText:setTextLeft()
        self._levelText:updateView()
        self._levelText:rightUp(62 - self._levelText:getContentSize().width/2, 38 - self._levelText:getContentSize().height/2)
    end
    -- 角色展示区域
    local roleShowArea = UI.BaseMInfo:create()
    roleShowArea:init()
    roleShowArea:centerUp(10)
    self:addChild(roleShowArea, 1)
    roleShowArea:addEventListener(UIEvent.ROLE_SHOW_EQUIPMENT_GRID_CLICK, self,onEquipmentGridClickHandler )
    self._roleShowArea = roleShowArea

    if (data) then
        self._roleShowArea:setData(data.heroData,data.wearEquipmentArr)
        self._roleShowArea:updateView()
    end
  
    -- 角色信息（攻击强度、发送强度、坚韧）展示区域
    local basicInfoArea = UI.BaseInfo:create()
    basicInfoArea:init()
    basicInfoArea:centerBottom(50)
    self._baseinfo = basicInfoArea
    if (data) then
        self._baseinfo:setData(data.heroData)
        self._baseinfo:updateView()
    end
    self._bigBg:addChild(basicInfoArea)

    local funnyLayer = self:showFunnyRecrd()
    self._bigBg:addChild(funnyLayer)
    funnyLayer:hide()
    self._funnyLayer = funnyLayer


    local changeButton = UI.Button:create()
    changeButton:init()
    changeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.changeInfo)
    changeButton:setSize(70,50)
    changeButton:centerBottom(0)

    local switchAnimation = UI.Animation:create()
    switchAnimation:init("effect_ui_common_btn_switch.json", "effect_ui_common_btn_switch.atlas")
    switchAnimation:setAnimation("idle", true)
    switchAnimation:center()
    changeButton:addChild(switchAnimation, 10)
    self._bigBg:addChild(changeButton)
    self.changeButton = changeButton


    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, comp, pos)
        self._roleShowArea:unselectEquipment()
    end)
    local heroData = data.heroData
    
    local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
    if (FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_EQUIP)) then 
        -- 星痕详情按钮
        local starButton = UI.Button:create() 
        starButton:init()
        starButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showStarInfo)
        starButton:setSize(50,50)
        starButton:rightBottom(37, 65)
        self._bigBg:addChild(starButton)

        local detailAnimation = UI.Animation:create()
        detailAnimation:init("effect_ui_package_role_starpray_hint_icon.json", "effect_ui_package_role_starpray_hint_icon.atlas")
        detailAnimation:setAnimation("idle", true)
        detailAnimation:center()
        starButton:addChild(detailAnimation, 10)
        self._starButton = starButton
    end


    local starReturnBtn = UI.Button:create()
    starReturnBtn:init("ui_starpray_return_0.png", "ui_starpray_return_1.png", "ui_starpray_return_0.png")
    starReturnBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.hideStarInfo)
    starReturnBtn:centerBottom(12)
    self._bigBg:addChild(starReturnBtn)
    self.starReturnBtn = starReturnBtn

    local SdkBox = require("utils.sdkbox.SdkBox")
    local isShow = SdkBox:getInstance():isSupportTranslationFunction()
    self.ip:setVisible(not isShow)
    if not isShow then
        Net.NetLoginSystem:reqRoleIP(self._data.heroData.pk)
    end
   
    self:open()
    self:showMainInfo()
end
-- 更新基础数据
function ViewFriendInfoLayer:updateBasicInfoView(data)
    if (data) then
        self._data.heroData = data 
        self._baseinfo:updateView(data)
        -- self._detailedInfoArea:updateView(data) 
    end
end
function ViewFriendInfoLayer:onUpdateView()
    -- local data = self._data
    -- if (data) then
    --     -- onWearEquipmentChangedHandler
    --     -- updateRoleView(self, data.heroData, data.wearEquipmentArr)
    --     self._roleShowArea:setData(data.heroData,data.wearEquipmentArr)
    --     self._roleShowArea:updateView()
    --     self:updateBasicInfoView(data.heroData)
    -- end
end

function ViewFriendInfoLayer:registerListener()
end

-- 关闭选中
function ViewFriendInfoLayer:closeChoese()
    if  self._selectedRoleGrid then 
        self._roleShowArea:unselectEquipment()
        self._selectedRoleGrid = nil 
    end
end

function ViewFriendInfoLayer:createBaseInfoBg()
    local baseInfoBg = UI.Layout:create()
    baseInfoBg:init()
    for i = 1, 3 do
        local line = UI.Image:create()
        line:init("ui_character_line.png")
        line:centerBottom(26 + 28 * (i - 1))
        baseInfoBg:addChild(line)
    end
    return baseInfoBg
end

function ViewFriendInfoLayer:showFunnyRecrd()
    local funnyLayer = UI.Layout:create()
    funnyLayer:init()
    funnyLayer:setSize(self:getContentSize().width, self:getContentSize().height)
    funnyLayer:centerUp(0)
    
    -- 滑动信息展示区域
    local scrollLayout = UI.Layout:create()
    scrollLayout:init()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(self:getContentSize().width, 341)
    scrollView:init(0,0,0,0)
    scrollView:leftBottom(0, 70)
    scrollView:addInnerNode(scrollLayout)
    funnyLayer:addChild(scrollView)

    local funnyRecords = GameDataManager:getFunnyRecords(self._data.records)
    scrollLayout:setSize(self:getContentSize().width,  39 * #funnyRecords)
    for k, v in ipairs(funnyRecords) do
        local recordPannel = self:createRecord(v)
        recordPannel:centerUp(38 * (k - 1))
        scrollLayout:addChild(recordPannel)
    end

    return funnyLayer
end

function ViewFriendInfoLayer:createRecord(data)
    local recordPannel = UI.Layout:create()
    recordPannel:init()
    recordPannel:setSize(350, 38)

    local line = UI.Image:create()
    line:init("ui_character_line.png")
    line:centerBottom(0)
    line:setScale(1.5, 1)
    recordPannel:addChild(line)
    -- line:setImageScaleX(1.5)

    local name = UI.Text:create()
    name:init(string.format("%s", data.name), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    name:setTextLeft()
    name:centerLeft(0)
    recordPannel:addChild(name)

    local showText = string.format("%d", data.score)
    if data.score >= 1000000 then
        showText = AvalonUtil:getSimpleNumber(data.score, 6)
    end
    local score = UI.NumberText:create(showText, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    score:setSize(100, 25)
    score:setTextRight()
    score:centerRight(0)
    recordPannel:addChild(score)
    return recordPannel
end

function ViewFriendInfoLayer:changeInfo()
    self._isShowMainInfo = not self._isShowMainInfo
    if self._isShowMainInfo then
        self:showMainInfo() 
    else
        self:showFunnyInfo()
    end  
end

function ViewFriendInfoLayer:showMainInfo()
    self._baseinfo:show()
    self._roleShowArea:show()
    self._roleShowArea:centerUp(10)
    self._funnyLayer:hide()
    if self.starInfo then
        self.starInfo:hide()
        self.starInfo:centerUp(winSize.height)
        self._bigBg:show()
    end
    self.starReturnBtn:hide()
    if self._starButton then
        self._starButton:show()
    end
end

function ViewFriendInfoLayer:showFunnyInfo()
    self._baseinfo:hide()
    self._roleShowArea:hide()
    self._roleShowArea:centerUp(winSize.height)
    self._funnyLayer:show()
    if self.starInfo then
        self.starInfo:hide()
        self.starInfo:centerUp(winSize.height)
        self._bigBg:show()
    end
    self.starReturnBtn:hide()
    if self._starButton then
        self._starButton:hide()
    end
end

function ViewFriendInfoLayer:showStarInfo()
    if self.starInfo then
        self.starInfo:show()
        self.starInfo:centerUp(45)
        self._bigBg:hide()
    else
        require("app.modules.starpray.StarPrayCircle")
        local layer = UI.StarPrayCircle:create(false)
        layer:init(self._data.heroData, self._data.starData)
        layer:centerUp(45)
        self:addChild(layer)
        self.starInfo = layer
        self._bigBg:hide()
    end

    self._baseinfo:hide()
    self._roleShowArea:hide()
    self._roleShowArea:centerUp(winSize.height)
    self._funnyLayer:hide()
    self.starReturnBtn:show()
    self.changeButton:hide()
    if self._starButton then
        self._starButton:hide()
    end

    self._titleText:hide()
    self._nameText:hide()
    self._guildNameText:hide()
    self._levelText:hide()

    -- self.starTitle:show()
    -- self.lineUpImage:show()
end

function ViewFriendInfoLayer:hideStarInfo()
    self.starInfo:hide()
    self.starInfo:centerUp(winSize.height)
    self._isShowMainInfo = not self._isShowMainInfo
    self.changeButton:show()

    self._titleText:show()
    self._nameText:show()
    self._guildNameText:show()
    self._levelText:show()

    -- self.starTitle:hide()
    -- self.lineUpImage:hide()
    self:changeInfo()
    self._bigBg:show()
end

function ViewFriendInfoLayer:updateIPText(data)
    local str  = UI.TEXT_222500
    if data.IpDesc and data.IpDesc ~= "" then
        str  = string.format(UI.TEXT_222500, data.IpDesc)
    else
        str = string.format(UI.TEXT_222500, "--")
    end
    self.ip:setText(str)
end