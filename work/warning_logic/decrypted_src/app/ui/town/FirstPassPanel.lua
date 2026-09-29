-- FirstPassPanel.lua
-- Author:ydli
-- 2019年8月20日
-- Using:关卡通关奖励

local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local FirstPassPanel = class("FirstPassPanel", UI.HWBtnComponent)
UI.FirstPassPanel = FirstPassPanel
require("app.ui.common.RewardLayer")

local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
    "ui_town_levelselect.plist"
}

-- 尺寸
local COM_WIDTH = 718
local COM_HEIGHT = 303

function FirstPassPanel:ctor()
    FirstPassPanel.super.ctor(self, 0, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    -- self:enableDebugDraw()
end

function FirstPassPanel:dtor()
    FirstPassPanel.super.dtor(self)
    self:unRegisterListener();
    reload_script_file("app.ui.town.FirstPassPanel")
end

-- public:
-- 初始化
function FirstPassPanel:init(mode, diff, maxLevel, curLevel)
	self.data = MasterDataManager:getBattlePassData(mode, diff, maxLevel, curLevel)
    print("-----FirstPassPanel---", mode, diff, maxLevel, curLevel)
	self.curLevel = curLevel
    self.maxLevel = maxLevel
    self.mode = mode
    self.diff = diff
    self.iconList = {}
    self.panelList = {}
    FirstPassPanel.super.init(self)
end

-- 模版函数：初始化组建的视图
function FirstPassPanel:onInitView()    
    local bg = UI.Image:create()
    bg:init("ui_selectfloor_firstclean_paper.png")
    bg:centerLeft(-48)
    self:addChild(bg)

    local name = UI.Text:create()
    name:init(UI.TEXT_1212918, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    name:leftUp(23, 13)
    self:addChild(name, 40)

    --button
    local reviveButton = UI.Button:create()
    reviveButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    reviveButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        self:receiveAllReward()
    end)
    reviveButton:centerBottom(25)
    self:addChild(reviveButton, 10)
    reviveButton:setText(UI.TEXT_1212919)
    reviveButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    self.reviveButton = reviveButton

    --flag
    local flag = UI.Image:create()
    flag:init("ui_information_atk.png")
    flag:leftBottom(74, 130)
    self:addChild(flag, 30)

    self.scrollView = self:createScrollView()
    self:addChild(self.scrollView, 10)
    local flagLeft = UI.Image:create()
    flagLeft:init("ui_selectfloor_firstclean_gradually_1.png")
    flagLeft:leftBottom(119, 14)
    self:addChild(flagLeft, 20)

    local flagR = UI.Image:create()
    flagR:init("ui_selectfloor_firstclean_gradually_2.png")
    flagR:rightBottom(70, 13)
    self:addChild(flagR, 20)
end

function FirstPassPanel:onUpdateView()
    local index = self.curLevel % SHOP_INTERVAL
    index = index == 0 and SHOP_INTERVAL or index
    if mode == PublicDefine.CAVE_MODE.MODE_HERO or mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        index = self.curLevel % HERO_INTERVAL
        index = index == 0 and HERO_INTERVAL or index
    end
	local percent = 100 * (25 + (index - 1) * 145 -  self.scrollView:getContentSize().width / 2) / (self.scrollView._innerNode:getContentSize().width - self.scrollView:getContentSize().width)
    percent = percent < 0 and 0 or percent
    percent = percent > 100 and 100 or percent
    self.scrollView:scrollToPercentHorizontal(percent)
    self:refreshView()
end

function FirstPassPanel:createScrollView()
	local scrollContent = UI.TouchLayout:create()
    scrollContent:init()
    scrollContent:addTouchEvents(self)
    local interval = SHOP_INTERVAL
    if self.mode == PublicDefine.CAVE_MODE.MODE_HERO or self.mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        interval = HERO_INTERVAL
    end
    scrollContent:setSize(145 * (interval - 1) + 90, 180)
    local size = #self.data
    local left = -10
    for k, v in ipairs(self.data) do
    	local panel = self:createPassCell(v, k, k == 1, k == size)
    	scrollContent:addChild(panel, 1000 - k)
    	panel:leftBottom(left, 10)
        left = left + panel:getContentSize().width
        table.insert(self.panelList, panel)
    end
    self.scrollContent = scrollContent

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(490, 180)
    scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
    scrollView:addInnerNode(scrollContent)
    scrollView:init(0, 0, 0, 0)
    scrollView:leftBottom(140, 90)
    scrollView:setScrollBarEnabled(false)
    scrollView:setCircleVisible(false)

    return scrollView
end

function FirstPassPanel:createPassCell(data, index, isFirstOne, isLastOne)
	local panel = UI.Layout:create()
	panel:init()
	if isFirstOne then
		panel:setSize(50, 125)
	else
		panel:setSize(145, 125)
		local bgBar = cc.Scale9Sprite:createWithSpriteFrameName("ui_selectfloor_firstclean_progressbar_2.png")
	    bgBar:setContentSize(145, 10)
	    bgBar:setCapInsets(CCRectMake(0,0,1,1))
	    bgBar:setPosition(cc.p(panel:getContentSize().width/2, 52))
	    panel:addChild(bgBar)
        if data.isFinish then
    		local bar = cc.Scale9Sprite:createWithSpriteFrameName("ui_selectfloor_firstclean_progressbar_1.png")
    	    bar:setContentSize(145, 10)
    	    bar:setCapInsets(CCRectMake(0,0,1,1))
    	    bar:setPosition(cc.p(panel:getContentSize().width/2, 52))
    	    panel:addChild(bar)
        end
	end

    local interval = SHOP_INTERVAL
    if self.mode == PublicDefine.CAVE_MODE.MODE_HERO or self.mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        interval = HERO_INTERVAL
    end
	
	--icon
    local icon, isCanTouch = self:createIcon(isFirstOne, isLastOne, data, index) 
    panel:addChild(icon, 10)
    if isCanTouch then
	   table.insert(self.iconList, icon) 
    end

    if index == self.curLevel - (self.maxLevel - interval) then
        local head = self:createHead()
        icon:addChild(head, 10)
        head:centerBottom(28 + icon:getContentSize().height / 2)
    end
	return panel
end

function FirstPassPanel:createIcon(isFirstOne, isLastOne, data, index)
    local icon = nil
    local image = nil
    local isCanTouch = false
    if isFirstOne then
        isCanTouch = false
        image = "ui_selectfloor_firstclean_node_1.png"
    elseif data.isFinish then
        isCanTouch = true
        if data.isRecived then
            if isLastOne then
                image = "ui_selectfloor_firstclean_2_2.png"
            else
                image = "ui_selectfloor_firstclean_1_2.png"
            end
        else
            icon = UI.Animation:create()
            if isLastOne then
                icon:init("effect_ui_twon_shoutong.json", "effect_ui_twon_shoutong.atlas", 1);
                icon:setAnimation("idle", true)
                icon:rightBottom(-25, 20)
            else
                icon:init("effect_ui_twon_jindu.json", "effect_ui_twon_jindu.atlas", 1);
                icon:setAnimation("idle", true)
                icon:rightBottom(-25, 30)
            end
            local size = icon:getBoundingBox()
            icon:setSize(size.width, size.height)
            local redPoint = UI.Image:create()
            redPoint:init("ui_information_equip.png")
            redPoint:rightUp(-6, -6)
            icon:addChild(redPoint, 100)
        end
    else
        isCanTouch = true
        if isLastOne then
            image = "ui_selectfloor_firstclean_2_0.png"
        else
            image = "ui_selectfloor_firstclean_1_0.png"
        end
    end
    if icon == nil and image ~= nil then
        icon = UI.Image:create()
        icon:init(image)
        icon:rightBottom(-icon:getContentSize().width / 2, 53 - icon:getContentSize().height / 2)
    end
    icon:setTag(index)

    local loft = self.maxLevel - SHOP_INTERVAL + index
    if self.mode == PublicDefine.CAVE_MODE.MODE_HERO or self.mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        loft = index
    end

    local name = UI.Text:create()
    name:init(string.format(UI.TEXT_1212814, loft), UI.ONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    name:centerBottom(-55 + icon:getContentSize().height / 2)
    icon:addChild(name, 100)
    return icon, isCanTouch
end

function FirstPassPanel:createHead()
	local heroData = RoleDataManager:getMaster()

    local headBg = UI.Image:create()
    headBg:init("ui_selectfloor_firstclean_headbox.png")

    -- 添加蒙版效果
    local headCap = UI.Image:create()
    headCap:init("ui_playerstate_me_black_01.png")
    headCap:center(0, -6)
    headBg:addChild(headCap, 3) 


    Avalon.WidgetUtil:getHead(self, heroData, heroData.wearEquipmentArr,self, handler(self,function(self,pic)
        if headBg and not tolua.isnull(headBg) then
            pic:setPosition(40, 45)
            headBg:addChild(pic, 2) 
        end
    end))
    return headBg
end

-- 注册监听事件(可选)
function FirstPassPanel:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_FIRST_PASS, self, self.firstPassCallback)
end

-- 注销监听事件
function FirstPassPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_FIRST_PASS, self, self.firstPassCallback)
end

-- 点击外部区域的处理器(关闭)(可选)
function FirstPassPanel:onTouchOutSizeEvent()
    self:close()
end


function FirstPassPanel:onTouchBegan(touch, event)
    local location = touch:getLocation()
    self.beginTouchPosition = location
    if self.scrollView then
        local point = self.scrollView:convertToWorldSpace(cc.p(0,0))
        local size = self.scrollView:getContentSize()
        local rect = cc.rect(point.x, point.y, size.width, size.height)
        if not AvalonUtil:isRectContainsPoint(self.scrollView, location) then
            return
        end  
    end

    for k, node in ipairs(self.iconList) do
        if AvalonUtil:isRectContainsPoint(node, location) then
            self.selectIndex = k
            break
        end
    end
end

function FirstPassPanel:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if self.scrollView then
        if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
            return
        end 
        --检查是否在可点击区域 邮件活动区域
        if not AvalonUtil:isRectContainsPoint(self.scrollView, location) then
            return
        end 
    end

    for k, node in ipairs(self.iconList) do
        if AvalonUtil:isRectContainsPoint(node, location) and self.selectIndex == k then
            print("---self.selectIndex--", self.selectIndex, node:getTag())
            self:showReward(node:getTag())
            break
        end
    end
end

function FirstPassPanel:showReward(index)
    require("app.ui.common.RewardLayer")
    local data = self.data[index]
    if data == nil then
        print("---FirstPassPanel:showReward-data is null  index = ", index)
        return
    end

    local str1 = string.split(data.Content, ";")
    local array = {}
    for k, v in ipairs(str1) do
        local str2 = string.split(v, ",")
        if #str2 >= 2 then
            local item = GoodsDataManager:createLocalGoodsData(checkint(str2[1]))
            if item then
                item:setNum(checkint(str2[2]))
                table.insert(array, item)
            end
        end
    end
    if data.isFinish then
        if data.isRecived then
            -- Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, array, nil, string.format(UI.TEXT_1212920, 8), UI_ZORDER.TOP_ACTIVITY, UI.RewardLayer.Style.showConfirmButton, false, nil, true)
        else
            self:receiveReward(index)
        end
    else
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, array, nil, string.format(UI.TEXT_1212920, 8), UI_ZORDER.TOP_ACTIVITY, UI.RewardLayer.Style.showConfirmButton, false, nil, true)
    end
end


function FirstPassPanel:receiveReward(index)
    -- 是否背包满
    local data = self.data[index]
    if data == nil then
        print("---FirstPassPanel:receiveReward-data is null  index = ", index)
        return
    end
    local str1 = string.split(data.Content, ";")
    local goodsArr = {}
    for k, v in ipairs(str1) do
        local str2 = string.split(v, ",")
        if #str2 >= 2 then
            local item = {}
            item.goodsID = checkint(str2[1])
            item.num = checkint(str2[2])
            item.isGolden = true
            table.insert(goodsArr, item)
        end
    end    
-- print("----goodsArr-----", goodsArr)
    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if not enough then
        UI.ScrollBar:createByTextID(1110793)
        return false
    end
    local list = {}
    table.insert(list, data.level)
    Net.NetRoleSystem:requestFirstPassReward(self.mode, self.diff, list) 
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end


function FirstPassPanel:receiveAllReward()
    local finishList = {}
    for k1, v1 in ipairs(self.data) do
        if k1 ~= 1 and v1.isFinish and not v1.isRecived then
            table.insert(finishList, v1)
        end
    end

    if #finishList <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212923)
        return
    end

    local goodsArr = {}
    local oldArray = {}
    local list = {}
    for k1, v1 in ipairs(finishList) do
        local str1 = string.split(v1.Content, ";")
        for k, v in ipairs(str1) do
            local str2 = string.split(v, ",")
            if #str2 >= 2 then
                local item = {}
                item.goodsID = checkint(str2[1])
                item.num = checkint(str2[2])
                item.isGolden = true
                table.insert(goodsArr, item)
            end
        end    
        local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
        if not enough then
            break
        end
        table.insert(list, v1.level)
    end

    if #list == 0 then
        UI.ScrollBar:createByTextID(1110793)
        return false
    end
    Net.NetRoleSystem:requestFirstPassReward(self.mode, self.diff, list) 
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

function FirstPassPanel:refreshView()
    if self.data == nil then
        return
    end
    local finishList = {}
    for k1, v1 in ipairs(self.data) do
        if k1 ~= 1 and v1.isFinish and not v1.isRecived then
            table.insert(finishList, v1)
        end
    end

    if #finishList <= 0 then
        self.reviveButton:disable()
    else
        self.reviveButton:enable()
    end

    
end
function FirstPassPanel:firstPassCallback(data)
    if data.mode == self.mode then
       --todo  刷新进度， 弹出结算界面
        self.data = MasterDataManager:getBattlePassData(self.mode, self.diff, self.maxLevel, self.curLevel)
        for k, v in ipairs(self.panelList) do
            v:removeFromParent()
        end
        self.panelList = {}
        self.iconList = {}

        local size = #self.data
        local left = -10
        for k, v in ipairs(self.data) do
            local panel = self:createPassCell(v, k, k == 1, k == size)
            self.scrollContent:addChild(panel, 1000 - k)
            panel:leftBottom(left, 10)
            left = left + panel:getContentSize().width
            table.insert(self.panelList, panel)
        end

        local array = {}
        for k1, v1 in ipairs(self.data) do
            for k2, v2 in ipairs(data.index) do
                if v2 == v1.level then
                    local str1 = string.split(v1.Content, ";")
                    for k3, v3 in ipairs(str1) do
                        local str2 = string.split(v3, ",")
                        if #str2 >= 2 then
                            local item = GoodsDataManager:createLocalGoodsData(checkint(str2[1]))
                            if item then
                                item:setNum(checkint(str2[2]))
                                table.insert(array, item)
                            end
                        end
                    end
                end
            end
        end
        self:refreshView()
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, array, nil, nil, UI_ZORDER.TOP_ACTIVITY, UI.RewardLayer.Style.showConfirmButton)
    end
end