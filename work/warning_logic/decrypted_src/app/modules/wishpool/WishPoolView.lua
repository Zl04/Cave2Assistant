------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/09/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local WishPoolView = class("WishPoolView", UI.HWBtnComponent)

require "app.net.NetGuildSystem"
require "app.datas.GuildBoxDataManager"
local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require"app.game.SdkManager"

-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_town_guild_wishpool.plist",
    "ui_common_symbol.plist",
    "ui_common_information.plist",
    "ui_common_scale9image.plist",
}

local COM_WIDTH = 716
local COM_HEIGHT = 533
local ZOrder = 1

function WishPoolView:ctor(npcID)
    WishPoolView.super.ctor(
    	self,
    	UI.Type.WISH_POOL_MAIN,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.npcID = npcID

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_DATA, self, self.updateWishData)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_COUNT, self, self.updateWishCount)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_TOTAL, self, self.updateWishTotalCount)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_LIST, self, self.updateWishList)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW, self, self.checkGuildBox)
end

function WishPoolView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.wishpool", "WishPool", false)
    WishPoolView.super.init(self, ... )
end

function WishPoolView:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_DATA, self, self.updateWishData)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_COUNT, self, self.updateWishCount)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_TOTAL, self, self.updateWishTotalCount)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_WISHPOOL_UPDATE_LIST, self, self.updateWishList)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW, self, self.checkGuildBox)

    WishPoolView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.wishpool.WishPoolView")
end

function WishPoolView:onInitView()
    Net.NetGuildSystem:reqGuildWishTotalTime()

    -- 请求一下宝箱信息
    GuildBoxDataManager:requestNewBoxInfo()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg1 = UI.Image:create();
    bg1:init("ui_bg_box1.png");
    bg1:center();
    contentLayout:addChild(bg1, ZOrder);
    ZOrder = ZOrder + 1;

    -- 背景图片
    local bg2 = UI.Image:create();
    bg2:init("ui_guild_wishingpond_bg.png");
    bg2:center();
    contentLayout:addChild(bg2, ZOrder);
    ZOrder = ZOrder + 1;

    -- 标题图片
    local titleBG = UI.Image:create();
    titleBG:init("ui_bg_title.png");
    titleBG:leftUp(184, -20);
    contentLayout:addChild(titleBG, ZOrder);
    ZOrder = ZOrder + 1;

    -- 标题
    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213276, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_168_160_147)
    titleTxt:setSize(234, 40)
    titleTxt:setTextCenter()
    titleTxt:centerLeft(57)
    -- titleTxt:enableDebugDraw()
    titleBG:addChild(titleTxt)

    -- 左石头
    local stone1 = UI.Image:create();
    stone1:init("ui_guild_wishingpond_fg_1.png");
    stone1:leftBottom(-36, 22);
    contentLayout:addChild(stone1, ZOrder);

    -- 右石头
    local stone2 = UI.Image:create();
    stone2:init("ui_guild_wishingpond_fg_2.png");
    stone2:rightBottom(-22, 24);
    contentLayout:addChild(stone2, ZOrder);
    ZOrder = ZOrder + 1;

    -- 进度条
    local prg = UI.ProgressTimer:create()
    prg:init("ui_guild_wishingpond_progressbar_0.png", nil, "ui_guild_wishingpond_progressbar_1.png")
    prg:rightUp(72, 52)
    prg:setPercent(0)
    self.prgBar = prg
    contentLayout:addChild(prg, ZOrder)
    ZOrder = ZOrder + 1;

    -- 徽章暗
    local gift1 = UI.Image:create();
    gift1:init("ui_guild_wishingpond_gift_0.png");
    gift1:rightUp(16, 24);
    contentLayout:addChild(gift1, ZOrder);
    ZOrder = ZOrder + 1;
    self.giftDark = gift1

    -- 徽章亮
    local gift2 = UI.Image:create();
    gift2:init("ui_guild_wishingpond_gift_1.png");
    gift2:rightUp(14, 24);
    contentLayout:addChild(gift2, ZOrder);
    gift2:hide()
    ZOrder = ZOrder + 1;
    self.giftLight = gift2

    -- 许愿次数
    local prgTxt = UI.Text:create()
    prgTxt:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    prgTxt:setWidth(160)
    prgTxt:rightUp(50, 70)
    self.prgTxt = prgTxt
    contentLayout:addChild(prgTxt, ZOrder)
    ZOrder = ZOrder + 1;

    -- 池子特效
    local effBG = UI.Animation:create()
    effBG:init("effect_ui_town_guild_wishingpond_pond.json", "effect_ui_town_guild_wishingpond_pond.atlas", 1);
    effBG:center()
    contentLayout:addChild(effBG, ZOrder)
    effBG:setAnimation("idle", true)
    ZOrder = ZOrder + 1;

    -- 花和投币特效
    local coinEff = UI.Animation:create()
    coinEff:init("effect_ui_town_guild_wishingpond_coin.json", "effect_ui_town_guild_wishingpond_coin.atlas", 1);
    coinEff:center()
    contentLayout:addChild(coinEff, ZOrder)
    coinEff:setAnimation("idle", true)
    self.coinEff = coinEff
    ZOrder = ZOrder + 1;

    -- 顶部特效
    local lightEff = UI.Animation:create()
    lightEff:init("effect_ui_town_guild_wishingpond_light.json", "effect_ui_town_guild_wishingpond_light.atlas", 1);
    lightEff:center()
    contentLayout:addChild(lightEff, ZOrder)
    self.lightEff = lightEff
    ZOrder = ZOrder + 1;

    -- 增满特效
    local giftEff = UI.Animation:create()
    giftEff:init("effect_ui_town_guild_wishingpond_gift.json", "effect_ui_town_guild_wishingpond_gift.atlas", 1);
    giftEff:rightUp(134, 60)
    contentLayout:addChild(giftEff, ZOrder)
    self.giftEff = giftEff
    ZOrder = ZOrder + 1;

    -- 暴击特效
    local criEff = UI.Animation:create()
    criEff:init("effect_ui_town_guild_wishingpond_baoji.json", "effect_ui_town_guild_wishingpond_baoji.atlas", 1);
    criEff:center()
    contentLayout:addChild(criEff, ZOrder)
    self.criEff = criEff
    ZOrder = ZOrder + 1;

    -- 许愿簿
    local wishBook = UI.Button:create()
    wishBook:init("ui_guild_wishingpond_record_0.png","ui_guild_wishingpond_record_1.png","ui_guild_wishingpond_record_0.png")
    wishBook:rightBottom(208, 174)
    wishBook:closeClickScale()
    wishBook:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        mvc.wishPoolModel:clearWishList()
        Net.NetGuildSystem:reqGuildWishList(0)
    end)
    contentLayout:addChild(wishBook, ZOrder)
    ZOrder = ZOrder + 1;

    -- TODOTODO 2021.6.02日 特殊屏蔽改名界面(国内)
    if SdkManager:responsePolicySwitch() then
        local SdkBox = require("utils.sdkbox.SdkBox")
        local target = SdkBox:getInstance():getVersionTarget()
        if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            wishBook:setVisible(false)
        end
    end

    -- 左侧按钮
    local leftBtn = UI.Button:create()
    leftBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    leftBtn:leftBottom(96, 50)
    leftBtn:closeClickScale()
    leftBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:wishClick(1)
    end)
    contentLayout:addChild(leftBtn, ZOrder)
    self.leftBtn = leftBtn

    local leftBtnLayout = UI.Layout:create();
    leftBtnLayout:init()
    local w1, h1 = leftBtn:getSize()
    leftBtnLayout:center()
    self.leftBtnLayout = leftBtnLayout
    self.leftBtn:addChild(leftBtnLayout, 1)

    -- 左侧消耗图标
    local icon1 = UI.Image:create();
    icon1:init(mvc.wishPoolModel:getCostTypeIcon(1));
    icon1:floatLeft(0);
    self.leftIcon = icon1
    leftBtnLayout:addComponent(icon1);

    -- 左侧消耗
    local num1 = UI.Text:create()
    num1:init("000000", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    local w1 = icon1:getSize()
    num1:floatLeft(10)
    leftBtnLayout:addComponent(num1)
    local w2 = num1:getSize()
    leftBtnLayout:setSize(w1+w2+10, 40)
    self.leftConsume = num1

    -- 左侧进度
    local txt1 = UI.Text:create()
    txt1:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_187_174)
    txt1:centerUp(-38)
    txt1:setSize(400, 40)
    txt1:setTextCenter()
    leftBtnLayout:addChild(txt1)
    self.leftPrgTxt = txt1

    -- 右侧按钮
    local rightBtn = UI.Button:create()
    rightBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    rightBtn:rightBottom(84, 50)
    rightBtn:closeClickScale()
    rightBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:wishClick(2)
    end)
    contentLayout:addChild(rightBtn, ZOrder)
    self.rightBtn = rightBtn

    if self:checkInFirst24Hours() then
        self.leftBtn:disable()
        self.leftBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function(self)
            self:wishClick(1)
        end)

        self.rightBtn:disable()
        self.rightBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function(self)
            self:wishClick(2)
        end)
    end

    local rightBtnLayout = UI.Layout:create();
    rightBtnLayout:init()
    rightBtnLayout:center()
    self.rightBtnLayout = rightBtnLayout
    self.rightBtn:addChild(rightBtnLayout, 1)

    -- 右侧消耗图标
    local icon2 = UI.Image:create();
    icon2:init(mvc.wishPoolModel:getCostTypeIcon(2));
    icon2:floatLeft(0);
    self.rightIcon = icon2
    rightBtnLayout:addComponent(icon2);

    -- 右侧消耗
    local num2 = UI.Text:create()
    num2:init("000", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    local w3 = icon2:getSize()
    num2:floatLeft(10)
    rightBtnLayout:addComponent(num2)
    local w4 = num2:getSize()
    rightBtnLayout:setSize(w3+w4+10, 40)
    self.rightConsume = num2

    -- 右侧消耗
    local txt2 = UI.Text:create()
    txt2:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_187_174)
    txt2:centerUp(-38)
    txt2:setSize(400, 40)
    txt2:setTextCenter()
    rightBtnLayout:addChild(txt2)
    self.rightPrgTxt = txt2

    -- 总次数
    local times = mvc.wishPoolModel:getWishTotalTime()
    local maxTime = mvc.wishPoolModel:getTotalMaxTime()
    self.prgBar:setPercent(times/maxTime)
    self.prgTxt:setText(UI.TEXT_1213272 .. "  " .. times .. "/" .. maxTime)

    -- -- 玩法说明
    -- local starButton = UI.Button:create() 
    -- starButton:init()
    -- starButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showStarInfo)
    -- starButton:setSize(50,50)
    -- starButton:leftUp(20, 30)
    -- contentLayout:addChild(starButton, 100)

    -- local detailAnimation = UI.Animation:create()
    -- detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    -- detailAnimation:setAnimation("idle", true)
    -- detailAnimation:center()
    -- starButton:addChild(detailAnimation, 10)

    self:updateWishCount()
    self:checkGuildBox()
end

function WishPoolView:checkInFirst24Hours()
    local curTime = GameManager:getNormalServerTime()
    local guildData = MasterDataManager:getGuildData()
    if not guildData then 
        return true
    end

    if guildData.joinTime and guildData.joinTime > 0 then
        if curTime - guildData.joinTime < 24*3600 then
            return true
        end
    end

    return false
end

function WishPoolView:wishClick(type)
    if self:checkInFirst24Hours() then
        UI.ScrollBar:createByText(UI.TEXT_1213278)
        return
    end

    local count = mvc.wishPoolModel:getWishCount(type)
    local maxCount = mvc.wishPoolModel:geWishMaxTime(type)
    if count >= maxCount then
        UI.ScrollBar:createByText(UI.TEXT_1213271)
        return
    end

    if not mvc.wishPoolModel:checkCurCostEnough(type) then
        if type == 1 then
            UI.ScrollBar:createByText(UI.TEXT_110210)
        elseif type == 2 then
            UI.TipsLayer:onDiamondNotEnough()
        end
        return
    end

    self.wishType = type
    self.isWishing = true
    self.preTotalTime = mvc.wishPoolModel:getWishTotalTime()

    -- TODOTODO 2021.6.02日 特殊屏蔽改名界面(国内)
    local useFirst = true
    if SdkManager:responsePolicySwitch() then
        local SdkBox = require("utils.sdkbox.SdkBox")
        local target = SdkBox:getInstance():getVersionTarget()
        if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            useFirst = false
        end
    end

    if self:checkTodayFirst() and useFirst then
        -- if self:checkTodayFirst() then
        mvc.openPanel("WishPool", "WishPoolTip", {npcID = self.npcID, wishType = self.wishType})
    else
        Net.NetGuildSystem:reqGuildWish(type, self.npcID)
    end
end

function WishPoolView:updateWishList()
    if not mvc.wishPoolController.wishPoolListView then
        mvc.openPanel("WishPool", "WishPoolList")
    end
end

function WishPoolView:checkTodayFirst()
    local userData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local timeStamp = userData:getGuildWishPoolTimestamp()
    local dateObj = os.date("*t", timeStamp)
    local curTime = GameManager:getNowServerTime()
    local curDateObj = os.date("*t", curTime)
    if curTime > timeStamp then
        if curDateObj.year > dateObj.year then
            userData:setGuildWishPoolTimestamp(curTime)
            return true
        elseif curDateObj.yday > dateObj.yday then
            userData:setGuildWishPoolTimestamp(curTime)
            return true
        end
    end
    return false
end

function WishPoolView:updateWishData(data)
    local rand = math.random(1, 3)
    if self.wishType == 1 then
        self.coinEff:setAnimation("coin_copper"..rand, false)
        self.coinEff:addAnimation("idle", true)
        Avalon.AudioManager:playSound("1557")
    elseif self.wishType == 2 then
        self.coinEff:setAnimation("coin_sliver"..rand, false)
        self.coinEff:addAnimation("idle", true)
        Avalon.AudioManager:playSound("1557")
    end

    if data.iscrit then
        self.criEff:setAnimation("idle", false)
    end

    self.coinEff:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(sender, event)
        local rewards = mvc.wishPoolModel:getWishReward()
        if #rewards > 0 then
            local goodsDataList = {}
            for k, v in pairs(rewards) do
                local data = GoodsDataManager:createLocalGoodsData(tonumber(v.id))
                if data ~= nil then
                    data:setNum(tonumber(v.count))
                    table.insert(goodsDataList, data)
                end
            end
    
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, goodsDataList, nil, LanguageManager:getInstance():getLocalString(1110161), nil, UI.RewardLayer.Style.notShowAnyButton)     
    
            mvc.wishPoolModel:clearWishReward()
        end
    end)
end

function WishPoolView:updateWishCount()
    -- 左边按钮次数
    local count1 = mvc.wishPoolModel:getWishCount(1)
    local maxCount1 = mvc.wishPoolModel:geWishMaxTime(1)
    if maxCount1 > 1 then
        self.leftPrgTxt:setText(string.format(UI.TEXT_1213273, maxCount1-count1, maxCount1))
    end
    if count1 == maxCount1 then
        self.leftPrgTxt:setFontColor(UI.FONT_COLOR_RED)
    end

    -- 右边按钮次数
    local count2 = mvc.wishPoolModel:getWishCount(2)
    local maxCount2 = mvc.wishPoolModel:geWishMaxTime(2)
    if maxCount2 > 1 then
        self.rightPrgTxt:setText(string.format(UI.TEXT_1213274, maxCount2-count2, maxCount2))
    end
    if count2 == maxCount2 then
        self.rightPrgTxt:setFontColor(UI.FONT_COLOR_RED)
    end

    -- 左边的消耗
    local w1 = self.leftIcon:getSize()
    local costNum1 = mvc.wishPoolModel:getCurCost(1)
    if costNum1 == 0 then
        self.leftConsume:setText(UI.TEXT_1172013)
        self.leftIcon:hide()
    else
        self.leftConsume:setText(costNum1)
        self.leftIcon:show()
    end
    if not mvc.wishPoolModel:checkCurCostEnough(1) then
        self.leftConsume:setFontColor(UI.FONT_COLOR_RED)
    end
    local w2 = self.leftConsume:getSize()
    self.leftBtnLayout:setSize(w1+w2+10, 40)

    -- 右边的消耗
    local w3 = self.rightIcon:getSize()
    local costNum2 = mvc.wishPoolModel:getCurCost(2)
    if costNum2 == 0 then
        self.rightConsume:setText(UI.TEXT_1172013)
        self.rightIcon:hide()
    else
        self.rightConsume:setText(costNum2)
        self.rightIcon:show()
    end
    if not mvc.wishPoolModel:checkCurCostEnough(2) then
        self.rightConsume:setFontColor(UI.FONT_COLOR_RED)
    end
    local w4 = self.rightConsume:getSize()
    self.rightBtnLayout:setSize(w3+w4+10, 40)
end

function WishPoolView:updateWishTotalCount()
    local times = mvc.wishPoolModel:getWishTotalTime()
    local maxTime = mvc.wishPoolModel:getTotalMaxTime()
    self.prgBar:setPercent(times/maxTime)
    self.prgTxt:setText(UI.TEXT_1213272 .. "  " .. times .. "/" .. maxTime)

    if not self.isWishing then
        return
    end

    if self.preTotalTime+1 == maxTime then
        self.prgBar:setPercent(1)
        self.prgTxt:setText(UI.TEXT_1213272 .. "  " .. maxTime .. "/" .. maxTime)

        self.lightEff:setAnimation("idle", false)
        self.giftEff:setAnimation("idle", false)

        self.giftEff:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(sender, event)
            -- 总次数
            local times = mvc.wishPoolModel:getWishTotalTime()
            self.prgBar:setPercent(times/maxTime)
            self.prgTxt:setText(UI.TEXT_1213272 .. "  " .. times .. "/" .. maxTime)

            self.giftLight:show()
            self.giftDark:hide()

            AvalonUtil.createRedPoint(self.giftLight, 5, 5)

            self.giftLight:setTouchEnable(true)
            self.giftLight:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
                mvc.closePanel("WishPool", "WishPool")
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_GUILD_MANAGER, 3)
            end)
        end)
    else
        self.prgBar:setPercent(times/maxTime)
        self.prgTxt:setText(UI.TEXT_1213272 .. "  " .. times .. "/" .. maxTime)
    end
end

function WishPoolView:checkGuildBox()
    local guildBox = GuildBoxDataManager:getSmallBoxData()
    local cfgBoxID = mvc.wishPoolModel:getGuildBoxID()
    local hasBox = false
    for _, v in ipairs(guildBox) do
        if v.tempID == cfgBoxID and not v.isDroped then
            hasBox = true
        end
    end

    if hasBox then
        self.giftLight:show()
        self.giftDark:hide()

        AvalonUtil.createRedPoint(self.giftLight, 5, 5)
    
        self.giftLight:setTouchEnable(true)
        self.giftLight:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            if not GuildBoxDataManager:isAbleToSee() then
                -- 新会员无法查看
                local timestampToSeeable = GameManager:getNormalServerTime() + GuildBoxDataManager:getTimeDurationToSeeable()
                UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1112229)--[["%s后才能打开公会宝箱"]], AvalonUtil:getFullFormatTime(timestampToSeeable)))
                return
            end

            mvc.closePanel("WishPool", "WishPool")
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_GUILD_MANAGER, 3)
        end)
    else
        self.giftLight:hide()
        self.giftDark:show()
    end
end


function WishPoolView:showStarInfo()
    if self.infoPanel == nil or tolua.isnull(self.infoPanel) then
        local panel = UI.Image:create()
        panel:init("ui_information_banner_details.png")
        panel:centerLeft(132)
        self:getParent():addChild(panel, 100)
        local xAdd = 65
        local yAdd = 80
        local title = UI.Text:create()
        title:init(LanguageManager:getInstance():getLocalString(1112499), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
        panel:addChild(title) 
        title:centerUp(25 + yAdd)

        local line  = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
        line:setContentSize(282, 2)
        line:setCapInsets(CCRectMake(20,1,1,1))
        line:setPosition(160+xAdd, 382+yAdd)
        panel:addChild(line)

        local desc = UI.Text:create()
        desc:init(UI.TEXT_1213309, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
        desc:setWidth(280)
        desc:autoAdapt()
        desc:centerUp(1)

        local height = desc:getContentSize().height
        height = height < 320 and 320 or height
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(280, height)
        if height > 320 then
            local scrollView = UI.ScrollView:create()
            scrollView:setSize(290, 320)
            scrollView:init()
            scrollView:leftUp(25+xAdd, 67+yAdd)
            scrollView:addInnerNode(layout)
            scrollView:useDefaultScrollBar()
            panel:addChild(scrollView)    
        else
            layout:leftUp(25+xAdd, 67+yAdd)
            panel:addChild(layout)
        end
        layout:addChild(desc)

        local touch = UI.Component:create()
        touch:init()
        touch:setSize(310,410)
        touch:center()
        panel:addChild(touch)
    
        touch:setTouchEnable(true)
        touch:setInterceptTouches(true)
        touch:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, panel, function()
            panel:removeFromParent()
        end)
    else
        self.infoPanel:show()
    end
end

function WishPoolView:bindModel()

end

function WishPoolView:unbindModel()

end

return WishPoolView
