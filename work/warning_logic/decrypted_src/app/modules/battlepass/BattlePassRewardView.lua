------------------------------------------------------------------------------
--author: 
--date	: 2019/08/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BattlePassRewardView = class("BattlePassRewardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 850
local COM_HEIGHT = 415
local layoutUU
function BattlePassRewardView:ctor()
    BattlePassRewardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    layoutUU = UIUtil:createAutoUILayout("BattlePassRewardView","app.modules.battlepass.BattlePassPosConfig", false)
    self:leftBottom(20, 10)
end

function BattlePassRewardView:dtor()
    BattlePassRewardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.battlepass.BattlePassRewardView")
end


function BattlePassRewardView:onInitView()
    local leftPanel = UI.Image:create()
    leftPanel:init("ui_passcheck_paper_receive.png")
    leftPanel:leftBottom(5, 22)
    self:addChild(leftPanel)

    local normalButton = UI.Button:create()
    normalButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    normalButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        self:normalClickCallback()
    end)
    normalButton:leftUp(15, 150)
    leftPanel:addChild(normalButton)
    normalButton:setText(LanguageManager:getInstance():getLocalString(1112114))
    normalButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    normalButton:closeClickScale()
    normalButton:setScale(0.8)
    self.normalButton = normalButton

    local normalIcon = UI.Image:create()
    normalIcon:init("ui_passcheck_icon_ordinary.png")
    normalIcon:leftUp(48, 37)
    leftPanel:addChild(normalIcon)

    local normalTips = UI.Text:create()
    normalTips:init(UI.TEXT_110002, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    normalTips:leftUp(80 - normalTips:getContentSize().width / 2, 130)
    leftPanel:addChild(normalTips, 10)



    local goldButton = UI.Button:create()
    goldButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    goldButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        self:goldClickCallback()
    end)
    goldButton:leftUp(15, 340)
    leftPanel:addChild(goldButton)
    goldButton:setText(LanguageManager:getInstance():getLocalString(1112114))
    goldButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    goldButton:closeClickScale()
    goldButton:setScale(0.8)
    self.goldButton = goldButton

    local goldIcon = UI.Image:create()
    goldIcon:init("ui_passcheck_icon_golden.png")
    goldIcon:leftUp(40, 210)
    leftPanel:addChild(goldIcon)

    local goldlTips = UI.Text:create()
    goldlTips:init(LanguageManager:getInstance():getLocalString(1111962), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    goldlTips:leftUp(80 - normalTips:getContentSize().width / 2, 315)
    leftPanel:addChild(goldlTips, 10)

    --tableview
    local tableview = UI.TableView.new({}, 561, 383)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    tableview:leftBottom(158, 21)
    tableview:setDelegate()
    tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init(0)
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 116, 383;
    end);

    local normalData = mvc.battlePassModel:getNormalBattlePassData()
    local goldenData = mvc.battlePassModel:getGoldBattlePassData()
    local normalSize = #normalData
    local goldenSize = #goldenData
    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.BattlePassRewardCell.new();
            cell:init(self.tableview, idx + 1);
        end,
        function(e) 
            printError("------------------------BattlePassRewardView:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    tableview:onUpdateCellNumbers(function ()
        return normalSize > goldenSize and normalSize or goldenSize
    end);

    self.tableview = tableview
    self:addChild(tableview)
    self:refreshView(true)
end

function BattlePassRewardView:refreshView(isFirst)
    local level, curExp = mvc.battlePassModel:getBattlePassLvAndExp()
    self.tableview:reloadData(isFirst)
    if isFirst then
        self.tableview:setContentOffset(cc.p(((0.5 - level) * 116) + self.tableview:getContentSize().width / 2, 0))
    end
    local normalData = mvc.battlePassModel:getNormalBattlePassData()
    local goldenData = mvc.battlePassModel:getGoldBattlePassData()
    local targetIndex = 0
    if level % 10 == 0 then
        targetIndex = level + 10
    else
        targetIndex = math.ceil(level / 10) * 10
    end
    local maxIndex = #normalData > #goldenData and #normalData or #goldenData
    targetIndex = targetIndex < maxIndex and targetIndex or maxIndex

    if self.rightpanel == nil then
        local rightpanel = UI.BattlePassRewardCell.new()
        rightpanel:init(nil, targetIndex, true)
        rightpanel:setPosition(723, 21)
        self:addChild(rightpanel, 100)
        self.rightpanel = rightpanel
    else
        self.rightpanel:refreshView(targetIndex, normalData[targetIndex], goldenData[targetIndex], true)
    end

    local itemList = mvc.battlePassModel:getAllRwardItem(PublicDefine.BattlePassAwardType.BattlePassType_Normal)
    if table.nums(itemList) > 0 then
        self.normalButton:enable()
        self.normalRedPoint = AvalonUtil.createRedPoint(self.normalButton, 1, 1, 100)
    else
        self.normalButton:disable()
        if self.normalRedPoint then
            self.normalRedPoint:removeFromParent()
            self.normalRedPoint = nil
        end
    end

    local itemList = mvc.battlePassModel:getAllRwardItem(PublicDefine.BattlePassAwardType.BattlePassType_Golden)
    if not mvc.battlePassModel:isUnlockGoldPass() then
        self.goldButton:setText(UI.TEXT_1212077)
        if self.goldRedPoint then
            self.goldRedPoint:removeFromParent()
            self.goldRedPoint = nil
        end
    elseif table.nums(itemList) > 0 then
        self.goldButton:setText(LanguageManager:getInstance():getLocalString(1112114))
        self.goldRedPoint = AvalonUtil.createRedPoint(self.goldButton, 1, 1, 100)
    else
        self.goldButton:setText(UI.TEXT_1212077)
        if self.goldRedPoint then
            self.goldRedPoint:removeFromParent()
            self.goldRedPoint = nil
        end
    end
end

function BattlePassRewardView:bindModel()
    mvc.battlePassModel:bind("PassRewardData", self, self.refreshDataCallback)
end

function BattlePassRewardView:unbindModel()
    mvc.battlePassModel:unbind("PassRewardData", self, self.refreshDataCallback)
end

function BattlePassRewardView:refreshDataCallback()
    print("-----refreshDataCallback------")
    self:refreshView(false)
end

function BattlePassRewardView:normalClickCallback()
    local GameDataManager = require("app.game.GameDataManager")
    local itemList = mvc.battlePassModel:getAllRwardItem(PublicDefine.BattlePassAwardType.BattlePassType_Normal)
    local goodsArr = {}
    for k, v in pairs(itemList) do
        local data = {}
        data.goodsID = k
        data.num = v
        data.isGolden = true--goods.isGolden
        table.insert(goodsArr, data)
    end
    -- 根据服务器的需求调整
    if GameDataManager:getInstance():getFreePacketBoxNum() <=0 
        or not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) then
        UI.ScrollBar:createByTextID(1110793)
        return false
    end
    Net.NetLogicSystem:requestGetBpAward(0, PublicDefine.BattlePassAwardType.BattlePassType_Normal)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

function BattlePassRewardView:goldClickCallback()
    local GameDataManager = require("app.game.GameDataManager")
    local itemList = mvc.battlePassModel:getAllRwardItem(PublicDefine.BattlePassAwardType.BattlePassType_Golden)    
    if not mvc.battlePassModel:isUnlockGoldPass() then
        mvc.openPanel("BattlePass", "BattlePassCharge")
    elseif table.nums(itemList) > 0 then
        local goodsArr = {}
        for k, v in pairs(itemList) do
            local data = {}
            data.goodsID = k
            data.num = v
            data.isGolden = true--goods.isGolden
            table.insert(goodsArr, data)
        end

        local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
        if not enough then
            UI.ScrollBar:createByTextID(1110793)
            return false
        end
        Net.NetLogicSystem:requestGetBpAward(0, PublicDefine.BattlePassAwardType.BattlePassType_Golden)
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    else
        mvc.openPanel("BattlePass", "BattlePassCharge")
    end
end


----tablecell--begin----------
local BattlePassRewardCell = class("BattlePassRewardCell", UI.TableViewCell)
UI.BattlePassRewardCell = BattlePassRewardCell


function BattlePassRewardCell:ctor()

end

function BattlePassRewardCell:onEnter()
    BattlePassRewardCell.super.onEnter(self);
end

function BattlePassRewardCell:onExit()
    BattlePassRewardCell.super.onExit(self);
end

function BattlePassRewardCell:init(listView, level, isSpecial)
    self.level = level or 0
    self.isSpecial = isSpecial
    local normalData = mvc.battlePassModel:getNormalBattlePassData()
    local goldenData = mvc.battlePassModel:getGoldBattlePassData()
    self.normalData = normalData[level] or {}
    self.goldData = goldenData[level] or {}
    self.listView = listView
    self:onInitView();
end

function BattlePassRewardCell:onInitView()
    local layout = UI.TouchLayout:create()
    layout:init()
    layout:setSize(112, 383)
    layout:leftBottom(0, 0)
    layout:addTouchEvents(self)
    self:addChild(layout)
     if self.isSpecial then
        local black = UI.Image:create()
        black:init("ui_passcheck_icon_left_mack.png")
        black:centerLeft(-60)
        layout:addChild(black, -1)
    end

    local titleBg = UI.Image:create()
    if self.isSpecial then
        titleBg:init("ui_passcheck_paper_rise2.png")
    else
        titleBg:init("ui_passcheck_paper_rise1.png")
    end
    titleBg:centerUp(0)
    layout:addChild(titleBg)

    local title = UI.Text:create()
    title:init(string.format(LanguageManager:getInstance():getLocalString(1111914), self.level), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    title:center()
    titleBg:addChild(title)
    self.title = title

    local normalBg = UI.Image:create()
    if self.isSpecial then
        normalBg:init("ui_passcheck_paper_ordinary2.png")
    else
        normalBg:init("ui_passcheck_paper_ordinary1.png")
    end
   
    normalBg:centerUp(40)
    layout:addChild(normalBg)
    self.normalBg = normalBg

    local goldenBg = UI.Image:create()
    if self.isSpecial then
        goldenBg:init("ui_passcheck_paper_golden2.png")
        goldenBg:centerUp(211)
    else
        goldenBg:init("ui_passcheck_paper_golden1.png")
        goldenBg:centerUp(210)
    end
    layout:addChild(goldenBg)
    self.goldenBg = goldenBg
    self:refreshView(self.level, self.normalData, self.goldData)

    local level, curExp = mvc.battlePassModel:getBattlePassLvAndExp()
    if not self.isSpecial and self.level == level then
        local flagLeft = UI.Animation:create()
        flagLeft:init("effect_ui_twon_passcheck_xuanzhong.json", "effect_ui_twon_passcheck_xuanzhong.atlas", 1);
        flagLeft:leftBottom(56, 192)
        self:addChild(flagLeft, 100)
        flagLeft:setAnimation("idle", true)
    end
end

function BattlePassRewardCell:refreshView(level, normalData, goldData)
    self.level = level
    self.normalData = normalData
    self.goldData = goldData
    self.title:setText(string.format(LanguageManager:getInstance():getLocalString(1111914), self.level))
    self.grideList = {}
    self.lockList = {}

    self.normalBg:removeChildByName("Item")
    if self.normalData and self.normalData.itemId and self.normalData.itemId > 0 then
        local item = self:createItem(self.normalData.itemId, self.normalData.num)
        item:setName("Item")
        if(item) then
            self.normalBg:addChild(item, 1)
            table.insert(self.grideList, item)
        end 
    end

    self.goldenBg:removeChildByName("Item")
    if self.goldData and self.goldData.itemId and self.goldData.itemId > 0 then
        local item = self:createItem(self.goldData.itemId, self.goldData.num)
        item:setName("Item")
        if(item) then
            self.goldenBg:addChild(item, 1)
            table.insert(self.grideList, item)
        end
    end
    if not self.isSpecial then
        self:refresState(self.normalData, self.normalBg, true)
        self:refresState(self.goldData, self.goldenBg, false)
    end
end

--未完成锁住
--已完成领取按钮
--已领取蒙住半透明 盖章
function BattlePassRewardCell:refresState(data, panel, isUpPanel)
    if data == nil or data.itemId == nil then
        return
    end
    if not data.isFinish then
        panel:removeChildByName("GrayCap")
        panel:removeChildByName("Button")
        if not isUpPanel then
            local lock = panel:getChildByName("Lock")
            if lock then
                lock:show()
            else
                lock = UI.Image:create()
                lock:init("lui_passcheck_luck_bg.png")
                lock:centerUp(110)
                panel:addChild(lock, 10)

                local flag = UI.Animation:create()
                flag:init("effect_ui_general_lock.json", "effect_ui_general_lock.atlas")
                flag:center()
                flag:setAnimation("idle",false)
                lock:addChild(flag, 10)
                table.insert(self.lockList, lock)
            end
        end
    else
        panel:removeChildByName("Lock")
        if data.isReward then
            panel:removeChildByName("Button")
            local grayCap = panel:getChildByName("GrayCap")
            grayCap = UI.Image:create()
            if isUpPanel then
                grayCap:init("ui_passcheck_paper_golden1_mack.png")
            else
                grayCap:init("ui_passcheck_paper_golden2_mack.png")
            end
            grayCap:center()
            panel:addChild(grayCap, 10)

            local rewardBg = UI.Image:create()
            rewardBg:init("ui_information_banner_receive.png")
            rewardBg:setScale(0.7)
            rewardBg:centerBottom(6)
            grayCap:addChild(rewardBg, -1)

            local text = UI.Text:create()  
            text:init(UI.TEXT_1110721, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
            text:center()
            text:setRotationSkewX(-9.0)
            text:setRotationSkewY(-9.0)
            rewardBg:addChild(text)
        else
            panel:removeChildByName("GrayCap")
            local button = panel:getChildByName("Button")
            if button == nil then
                button = UI.Button:create()
                button:init("ui_setup_button_switch_0.png", "ui_setup_button_switch_1.png", "ui_setup_button_switch_2.png")
                button:centerUp(116)
                button:setName("Button")
                panel:addChild(button, 10)
                button:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
                button:setText(UI.TEXT_111035)
                button:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
                    local awardType = PublicDefine.BattlePassAwardType.BattlePassType_Normal
                    if not isUpPanel then
                        awardType = PublicDefine.BattlePassAwardType.BattlePassType_Golden
                    end
                    self:reciveClickCallback(self.level, awardType)
                end)
                button:setTouchClipNode(self.listView)
            else
                button:show()
            end

            local item = panel:getChildByName("Item")
            if item then
                item:playShakeAct(item)
            end
        end
    end
end

function BattlePassRewardCell:createItem(itemId, num)
    local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
    if(goodsData) then
        goodsData:setNum(num)
        goodsData:setIsNew(false)

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:centerUp(40)
        goodsGrid:setInfoArea(true, false)
        return goodsGrid
    end 
end 


function BattlePassRewardCell:onTouchBegan(touch, event)
    local location = touch:getLocation()
    self.beginTouchPosition = location
    if self.listView then
        local point = self.listView:convertToWorldSpace(cc.p(0,0))
        local size = self.listView:getViewSize()
        local rect = cc.rect(point.x, point.y, size.width, size.height)
        if not AvalonUtil:isRectContainsPoint(self.listView, location) then
            return
        end  
    end

    for k, node in ipairs(self.grideList) do
        if AvalonUtil:isRectContainsPoint(node, location) then
            self.selectIndex = k
            break
        end
    end

    for k, node in ipairs(self.lockList) do
        if AvalonUtil:isRectContainsPoint(node, location) then
            self.selectLockIndex = k
            break
        end
    end
end

function BattlePassRewardCell:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if self.listView then
        if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
            return
        end 
        --检查是否在可点击区域 邮件活动区域
        if not AvalonUtil:isRectContainsPoint(self.listView, location) then
            return
        end 
    end

    for k, node in ipairs(self.grideList) do
        if AvalonUtil:isRectContainsPoint(node, location) and self.selectIndex == k then
            local info = node:onShowInfoAreaHandler(true)
            break
        end
    end

    for k, node in ipairs(self.lockList) do
        if AvalonUtil:isRectContainsPoint(node, location) and self.selectLockIndex == k then
            mvc.openPanel("BattlePass", "BattlePassCharge")
            break
        end
    end
end

function BattlePassRewardCell:reciveClickCallback(level, awardType)
    -- 判断背包是否满了
    local GameDataManager = require("app.game.GameDataManager")

    local itemId, num = mvc.battlePassModel:getRwardItemByLevel(awardType, level)
    local goodsArr = {}
    local data = {}
    data.goodsID = itemId
    data.num = num
    data.isGolden = true--goods.isGolden
    table.insert(goodsArr, data)

    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if not enough then
        UI.ScrollBar:createByTextID(1110793)
        return false
    end
    Net.NetLogicSystem:requestGetBpAward(level, awardType)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end
----tablecell--end----------

return BattlePassRewardView












