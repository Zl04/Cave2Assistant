------------------------------------------------------------------------------
--author: yudong.li
--date	: 2020/03/05
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GuildAuctionStockView = class("GuildAuctionStockView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_guild_purchase.plist"
}
local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 931
local COM_HEIGHT = 575

function GuildAuctionStockView:ctor(spriteId)
    GuildAuctionStockView.super.ctor(
    	self,
    	UI.Type.GUILD_AUCTION_STOCK,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.spriteId = spriteId
    self.lockClick = false
    self.schedulerID = nil
    self:bindModel()
end

function GuildAuctionStockView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.guild", "Guild", false)
    self.iconList = {}
    GuildAuctionStockView.super.init(self, ... )
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetNPCSystem:reqGetAllTreasure(self.spriteId)
end

function GuildAuctionStockView:dtor()
    GuildAuctionStockView.super.dtor(self)
    self:unbindModel()
    self:enableDebugDraw()
    if (self.schedulerID) then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    reload_script_file_mvc("app.modules.guild.GuildAuctionStockView")
end

function GuildAuctionStockView:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_guild_purchase_itembg.png")
    bg:center()
    self:addChild(bg)
    bg:hide()
    self.bg = bg

    local flag1 = UI.Image9:create()
    flag1:init("ui_guild_button_jinhuo_heitiao.png",CCRectMake(2,0,1,1), cc.size(winSize.width, (winSize.height - COM_HEIGHT) / 2))
    flag1:centerBottom(COM_HEIGHT + 36)
    self:addChild(flag1, 11)

    local flag2 = UI.Image9:create()
    flag2:init("ui_guild_button_jinhuo_heitiao.png",CCRectMake(2,0,1,1), cc.size(winSize.width, (winSize.height - COM_HEIGHT) / 2))
    flag2:centerUp(COM_HEIGHT + 36)
    self:addChild(flag2, 11)


    local animation = UI.Animation:create()
    animation:init("effect_ui_town_guild_jinhuo_npc.json", "effect_ui_town_guild_jinhuo_npc.atlas", 1);
    animation:center()
    self:addChild(animation, 11)
    self.npcAnimation = animation
    animation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "begin") then
            if not tolua.isnull(self) then
                self.npcAnimation:setAnimation("idle2", true)
            end 
        elseif (event.animation == "start2") then
            if not tolua.isnull(self) then
                self.npcAnimation:setAnimation("idle2", true)
            end
        end
    end)


    local animation = UI.Animation:create()
    animation:init("effect_ui_town_guild_jinhuo.json", "effect_ui_town_guild_jinhuo.atlas", 1);
    animation:center()
    self:addChild(animation, 10)
    self.animation = animation
    self.animation:hide()
    self.npcAnimation:hide()
    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        if not tolua.isnull(self) then
            self.animation:show()
            self.npcAnimation:show()

            self.animation:setAnimation("begin", false)
            self.npcAnimation:setAnimation("begin", false)
        end
    end, 0.2)
     Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        if not tolua.isnull(self) then
           self.bg:show()
        end
    end, 0.8)
    animation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "begin") then
            if not tolua.isnull(self) then
                
                local list, useCount = MasterDataManager:getGuildData():getAllTreasures()
                if list ~= nil then
                    self.animation:setAnimation("start2", false)
                else
                    self.animation:setAnimation("idle1", true)
                end
            end 
        elseif (event.animation == "start2") then
            if not tolua.isnull(self) then
                self.animation:setAnimation("idle2", true)
            end
        end
    end)

    local panel1 = UI.Layout:create()
    panel1:init()
    panel1:center()
    animation:addComponent("mount_huobi", panel1, true)
    self.curryPanel = panel1

    local icon = UI.Image:create()
    icon:init("symbol_guild_tech_icon_medal.png")
    icon:leftUp(-80, -9)
    panel1:addChild(icon)

    local number = UI.NumberText:create(MasterDataManager:getGuildData().guildTeamMedal, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE, 10)
    number:setTextLeft()
    number:leftUp(-45, -8)
    panel1:addChild(number, 4)
    self.medalNumber = number

    local pos = {{110, 60}, {260, 60}, {50, 185}, {180, 185}, {310, 185}}
    for i = 1, 5 do
        local icon = UI.Layout:create()
        icon:init()
        icon:setSize(144,118)
        icon:leftUp(pos[i][1], pos[i][2])

        local image = UI.Image:create()
        image:init("ui_guild_purchase_box.png")
        image:center()
        image:setName("Box")
        icon:addChild(image)

        bg:addChild(icon)
        table.insert(self.iconList, icon)
    end

    local panel2 = UI.Layout:create()
    panel2:init()
    panel2:center()
    panel2:setSize(360, 140)
    animation:addComponent("mount_jiandin", panel2, true)

    local buyButton = UI.Button:create()
    buyButton:init("ui_guild_button_identify_0.png", "ui_guild_button_identify_1.png", "ui_guild_button_identify_2.png")
    buyButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        self:buyClick()
    end)
    buyButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        self:onDiableClick()
    end)
    buyButton:centerBottom(32)
    panel2:addChild(buyButton)
    self.buyButton = buyButton
  
    local btnText = UI.Text:create()
    btnText:init(UI.TEXT_1213952, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    btnText:centerUp(32)
    buyButton:addChild(btnText, 10)

    local icon = UI.Image:create()
    icon:init("symbol_guild_tech_icon_medal.png")
    icon:leftBottom(140, 100)
    panel2:addChild(icon)
    self.itemIcon = icon

    local number = UI.Text:create()
    number:init("x100", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_WHITE)
    number:leftBottom(170, 100)
    panel2:addChild(number)
    self.itemNumber = number

    local tips = UI.Text:create()
    tips:init(UI.TEXT_1213955, UI.FONT_BOLD, UI.FONT_SIZE_12PX, {r = 152, g = 44, b = 38})
    tips:centerUp(-8)
    panel2:addChild(tips)
    self.tips = tips

    local tipIcon = UI.Image:create()
    tipIcon:init("ui_information_reminder.png")
    panel2:addChild(tipIcon)

    local tips2 = UI.Text:create()
    tips2:init(UI.TEXT_1213959, UI.FONT_BOLD, UI.FONT_SIZE_14PX, {r = 152, g = 44, b = 38})
    panel2:addChild(tips2)

    local left = (panel2:getContentSize().width - tipIcon:getContentSize().width - tips2:getContentSize().width - 16) / 2
    tipIcon:leftBottom(left, 16)
    tips2:leftBottom(left + tipIcon:getContentSize().width + 8, 16)

    self:refreshAllTreasure()
end

function GuildAuctionStockView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_TREASURE_CHANGE, self, self.refreshAllTreasure)
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self, self.refreshMedal)
end

function GuildAuctionStockView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_TREASURE_CHANGE, self, self.refreshAllTreasure)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self, self.refreshMedal)
end

function GuildAuctionStockView:buyClick()
    if not tolua.isnull(self.rewardLayer) then
        self.rewardLayer:removeFromParent()
        self.rewardLayer = nil
        return
    end
    if self.lockClick then
        return
    end
    local list = MasterDataManager:getGuildData():getAllTreasures()
    if list == nil then
        print("GuildAuctionStockView:buyClick list is null")
        return
    end

    --权限
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if masterTitle ~= PublicDefine.GuildTitle.GuildTitle_Leader then
        UI.ScrollBar:createByTextID(1170046)
        return
    end

     --进货完所有宝藏
    local list, useCount = MasterDataManager:getGuildData():getAllTreasures()
    local costList = ConfigManager:getGuildConfigForKey("guildAuctionPrice")
    if useCount >= #costList then
        UI.ScrollBar:createByText(UI.TEXT_1213956)
        return
    end

    --货币时候足够
    local nowGuildMedal = MasterDataManager:getGuildData().guildTeamMedal
    if costList[useCount + 1] > nowGuildMedal then
        UI.ScrollBar:createByText(UI.UI.TEXT_110067)
        return
    end
    
    local status = mvc.guildAuctionModel:getSvrCurStatus()
   if status ~= PublicDefine.GuildAuctionState.GuildAuctionState_StockUp then
        UI.ScrollBar:createByText(UI.TEXT_1213955)
        return
    end
    --时间没对
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetNPCSystem:reqIndentifyTreasure(self.spriteId)

    self.lockClick = true
    self.animation:setAnimation("start", false)    
    self.npcAnimation:setAnimation("start", false)                      
end

function GuildAuctionStockView:onDiableClick()
    if not tolua.isnull(self.rewardLayer) then
        self.rewardLayer:removeFromParent()
        self.rewardLayer = nil
        return
    end
    if self.lockClick then
        return
    end
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if masterTitle ~= PublicDefine.GuildTitle.GuildTitle_Leader then
        UI.ScrollBar:createByTextID(1170046)
        return
    end

    --进货完所有宝藏
    local list, useCount = MasterDataManager:getGuildData():getAllTreasures()
    local costList = ConfigManager:getGuildConfigForKey("guildAuctionPrice")
    if useCount >= #costList then
        UI.ScrollBar:createByText(UI.TEXT_1213956)
        return
    end

    --货币时候足够
    local nowGuildMedal = MasterDataManager:getGuildData().guildTeamMedal
    if costList[useCount + 1] > nowGuildMedal then
        UI.ScrollBar:createByText(UI.TEXT_110067)
        return
    end
    
    local status = mvc.guildAuctionModel:getSvrCurStatus()
    if status ~= PublicDefine.GuildAuctionState.GuildAuctionState_StockUp then
        UI.ScrollBar:createByText(UI.TEXT_1213955)
        return
    end
end

function GuildAuctionStockView:refreshAllTreasure(data)
    if data and data.result == "ResultOfOperation_Ok" then
        local animation = UI.Animation:create()
        animation:init("effect_ui_town_guild_jinhuo_box.json", "effect_ui_town_guild_jinhuo_box.atlas", 1);
        animation:center()
        self:addChild(animation, 10)
        animation:setAnimation("animation", false)
        animation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
            if (event.animation == "animation") then
                sender:destroy()
                if not tolua.isnull(self) then
                    self.animation:addAnimation("start2", false)
                    self.npcAnimation:setAnimation("start2", false)
                    self:showReward()
                end
            end
        end)
    elseif data and data.result ~= "ResultOfOperation_Ok"  then
        self.animation:addAnimation("idle2", true)
        self.npcAnimation:setAnimation("idle2", true)
        self.lockClick = false
        return
    end

    local list, useCount, closeTime = MasterDataManager:getGuildData():getAllTreasures()
    local remainTime = closeTime - GameManager:getNormalServerTime()
    print("---remainTime---",remainTime + 6)
    if remainTime > 0 then
        if (self.schedulerID) then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
            self.schedulerID = nil
        end
        self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
            if not tolua.isnull(self) then
                Net.NetNPCSystem:reqGetAllTreasure(self.spriteId)
            end
        end, remainTime + 6, false)
    end
    list = list or {}
    local costList = ConfigManager:getGuildConfigForKey("guildAuctionPrice")
    for k, v in ipairs(list) do
        local iconBg = self.iconList[k]
        iconBg:removeChildByName("Box")
        iconBg:removeChildByName("Animation")
        iconBg:removeChildByName("GoodsGrid")

        local animation = UI.Animation:create()
        animation:init("effect_ui_town_guild_jinhuo_guang.json", "effect_ui_town_guild_jinhuo_guang.atlas", 1);
        animation:center()
        iconBg:addChild(animation, 10)
        animation:setAnimation("idle2", true)
        animation:setName("Animation")
       
        local goodsData = GoodsDataManager:createLocalGoodsData(v.item[1])
        goodsData:setNum(v.item[2])
        goodsData:setIsNew(false)
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:center()
        iconBg:addChild(goodsGrid, 10)
        goodsGrid:hideFlagIcon()
        goodsGrid:showCountLabel()
        goodsGrid:showInfoArea(false, true)
        goodsGrid:setName("GoodsGrid")
    end
    local cost = costList[useCount + 1] or costList[#costList]
    if cost == 0 then
        self.itemIcon:hide()
        self.itemNumber:hide()
    else
        self.itemIcon:show()
        self.itemNumber:show()
        self.itemNumber:setText("x"..cost)

        local left = (360 - self.itemIcon:getContentSize().width - self.itemNumber:getContentSize().width - 6) / 2
        self.itemIcon:leftBottom(left, 100)
        self.itemNumber:leftBottom(left + self.itemIcon:getContentSize().width + 3, 100)
    end

    local status = mvc.guildAuctionModel:getSvrCurStatus()
    self.curryPanel:show()
    self.itemNumber:setFontColor(UI.FONT_COLOR_WHITE)
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    local nowGuildMedal = MasterDataManager:getGuildData().guildTeamMedal
    if masterTitle ~= PublicDefine.GuildTitle.GuildTitle_Leader then
        self.buyButton:disable()
        self.itemIcon:hide()
        self.itemNumber:hide()
        self.curryPanel:hide()
    elseif useCount >= #costList then
        self.buyButton:disable()
    elseif costList[useCount + 1] > nowGuildMedal then
        self.buyButton:disable()
        self.itemNumber:setFontColor(UI.FONT_COLOR_RED)
    elseif status ~= PublicDefine.GuildAuctionState.GuildAuctionState_StockUp then
        self.buyButton:disable()
    else
        self.buyButton:enable()
    end


    if status ~= PublicDefine.GuildAuctionState.GuildAuctionState_StockUp then
        self.tips:setText(UI.TEXT_1213955)
    else
        self.tips:setText(UI.TEXT_1213954)
    end
end

function GuildAuctionStockView:refreshMedal()
    self.medalNumber:setText(MasterDataManager:getGuildData().guildTeamMedal)
end

function GuildAuctionStockView:showReward()
    self.lockClick = false
    local rewardLayer = UI.Layout:create()
    rewardLayer:init()
    rewardLayer:setSize(100, 100)
    rewardLayer:setTouchEnable(true)
    rewardLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        rewardLayer:removeEventListenerByName(UIEvent.COMPONENT_TOUCH_OUTSIDE)
        if not tolua.isnull(self.rewardAnimation) then
            self.rewardAnimation:setAnimation("end", false)
        end
    end)
    rewardLayer:center()
    self:addChild(rewardLayer, 100)
    self.rewardLayer = rewardLayer

    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,150))
    colorLayer:setPosition((100 - winSize.width) / 2, (100 - winSize.height) / 2)
    colorLayer:setContentSize(winSize.width, winSize.height)
    rewardLayer:addChild(colorLayer, -1) 

    local animation = UI.Animation:create()
    animation:init("effect_ui_town_guild_jinhuo_guang.json", "effect_ui_town_guild_jinhuo_guang.atlas", 1);
    animation:center()
    rewardLayer:addChild(animation)
    animation:setAnimation("begin", false)
    animation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "begin") then
            sender:setAnimation("idle1", true)
        elseif (event.animation == "end")  then
            if not tolua.isnull(self.rewardLayer) then
                sender:destroy()
                self.rewardLayer:runAction(cc.RemoveSelf:create())
            end
        end
    end)
    self.rewardAnimation = animation
    local list, useCount = MasterDataManager:getGuildData():getAllTreasures()
    list = list or {}
    local data = list[#list]
    if data then
        local goodsData = GoodsDataManager:createLocalGoodsData(data.item[1])
        goodsData:setNum(data.item[2])
        goodsData:setIsNew(false)
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:center()
        goodsGrid:hideFlagIcon()
        goodsGrid:showCountLabel()
        goodsGrid:showInfoArea(false, false)
        animation:addComponent("mount_box", goodsGrid, true)
    end
end
return GuildAuctionStockView












