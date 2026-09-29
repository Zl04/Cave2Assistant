------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigCrackResultView = class("BigCrackResultView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_world_boss.plist",
    "ui_town_bigcrack.plist"
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function BigCrackResultView:ctor(infos)


    BigCrackResultView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self:center()
    self.heroInfos = infos and infos.heroInfos or {}
    self.isWin = infos and infos.isWin
    self.alreadyReward = infos and infos.winNum or 0
end

function BigCrackResultView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigcrack", "BigCrack", false)
    BigCrackResultView.super.init(self, ... )
end

function BigCrackResultView:dtor()
    BigCrackResultView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigcrack.BigCrackResultView")
end


function BigCrackResultView:onInitView()
    -- effect_ui_town_bigcrack_victory.json
    local headAnimation = UI.Animation:create()
    if self.isWin then
        headAnimation:init("effect_ui_town_bigcrack_victory.json", "effect_ui_town_bigcrack_victory.atlas", 1);
    else
        headAnimation:init("effect_ui_town_bigcrack_fail.json", "effect_ui_town_bigcrack_fail.atlas", 1);
    end
    headAnimation:center()
    self:addChild(headAnimation)
    headAnimation:setAnimation("begin", false)
    headAnimation:addAnimation("idle", true)
    self.headAnimation = headAnimation

    local title = UI.Text:create()
    if self.isWin then
        title:init(UI.TEXT_1213447, UI.FONT_STANDARD, UI.FONT_SIZE_28PX, {r = 249, g = 226, b = 151})
    else
        title:init(UIUtil:lang(1111818), UI.FONT_STANDARD, UI.FONT_SIZE_28PX, {r = 249, g = 226, b = 151})
    end
    title:center()
    title:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(2, -2))
    headAnimation:addComponent("box-victory", title)


    local tab = {
        {"mvp.png", 1},
        {"qita.png", 0.86},
        {"qita.png", 0.86},
        {"qita.png", 0.86},
        {"qita.png", 0.86}
    }
    -- local masterData = GameDataManager:getInstance():getMaster()
    -- local heroData = RoleDataManager:getHeroDataForSpriteID(masterData:getSpriteID())
    -- local detailData = {}
    -- detailData.heroData = heroData
    -- detailData.wearEquipmentArr = {}
    -- local heroInfos = {}
    -- table.insert(heroInfos,{heroData = detailData,  damage = 11})
    -- self.heroInfos =  heroInfos
    -- for i = 1, 5 do
    --     local info = self.heroInfos[1]
    for i = 1, #self.heroInfos do
        local info = self.heroInfos[i]
        local heroData = info.heroData
        Avalon.WidgetUtil:getHead(
            self,
            heroData.heroData,
            heroData.wearEquipmentArr,
            self,
            handler(
                self,
                function(self, pic)
                    if self and not tolua.isnull(headAnimation) then
                        pic:setPosition(cc.p(0,12))
                        headAnimation:addComponent("box-victory-" .. i, pic, true)
                        local img = UI.Image:create()
                        if i == 1 then
                            img:init("mvp2.png")
                            img:center(0,2)
                        else
                            img:init("qita2.png")
                            img:center(0,-10)
                        end
                        headAnimation:addComponent("box-victory-" .. i, img, true)
                    end
                end
            ),
            true,
            tab[i][1],
            tab[i][2],
            i == 1 and cc.p(0, -50) or cc.p(0, -30)
        )

        local nameColor = self.isWin and {r = 255, g = 253, b = 197} or {r = 197, g = 136, b = 115} 
        
        local hitColor = self.isWin and{r = 209, g = 209, b = 163} or {r = 237, g = 207, b = 197} 
        local scoreColor = self.isWin and{r = 255, g = 255, b = 117} or  {r = 254, g = 166, b = 135} 

        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(100,50)
        layout:center(0, 4)
        headAnimation:addComponent("box-victory-mane-" .. i,layout, true)

        local nameText = UI.Text:create()
        nameText:init(tostring(heroData.heroData.nickName), UI.SYS_FONT, UI.FONT_SIZE_20PX, nameColor)
        nameText:floatUp(2)
        layout:addComponent(nameText)

        local hitText = UI.Text:create()
        hitText:init(string.format(UI.TEXT_1213452, info.damge), UI.FONT_BOLD, UI.FONT_SIZE_16PX, hitColor)
        hitText:center()
        hitText:floatUp(-4)
        layout:addComponent(hitText)

        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(100,50)
        layout:center(0, -23)
        headAnimation:addComponent("box-victory-level-" .. i,layout, true)

        local scoreText = UI.Text:create()
        scoreText:init(UI.TEXT_1213451, UI.FONT_BOLD, UI.FONT_SIZE_16PX, hitColor)
        scoreText:floatUp(2)
        layout:addComponent(scoreText)

        local scoreText = UI.Text:create()
        scoreText:init(tostring(info.crossNum), UI.FONT_BOLD, UI.FONT_SIZE_16PX, scoreColor)
        scoreText:floatUp(-5)
        layout:addComponent(scoreText)
    end

    for i = #self.heroInfos + 1, 5 do
        local title = UI.Text:create()
        title:init(UI.TEXT_1212636, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
        title:center()
        headAnimation:addComponent("box-victory-mane-" .. i, title, true)
    end

    self:createBottomLayer()
end

function BigCrackResultView:createBottomLayer()
    local tag = "fail"
    local config = mvc.bigCrackModel:getFestivalConfig()
    local maxTime = config.rewardLimit

    if self.isWin and self.alreadyReward <= maxTime then
        tag = ""
        local title = UI.Text:create()
        title:init(UI.TEXT_1213437, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 181, g = 171, b = 171})
        addChildAuto(self._layoutUU, self, title, "huodejianli", "centerLeft")
    
        local config = mvc.bigCrackModel:getFestivalConfig()
        local maxTime = config.rewardLimit
        local title = UI.Text:create()
        title:init( string.format(UI.TEXT_1213438,  self.alreadyReward ,tostring(maxTime)), UI.FONT_STANDARD, UI.FONT_SIZE_18PX,{r = 181, g = 171, b = 171})
        addChildAuto(self._layoutUU, self, title, "yilinqu", "centerLeft")
        local rewardConfig = {}
        if self.heroInfos[1] and self.heroInfos[1].heroData.heroData.pk == RoleDataManager:getMasterPK() then
            table.insert(rewardConfig, config.mvpReward)
            local mvp = UI.Image:create()
            mvp:init("ui_bigcrack_mvp.png")
            addChildAuto(self._layoutUU, self, mvp, "mvp", "center")
        end
        table.insert(rewardConfig, config.reward)
        local reward = {}
        local idx = 1
        for i = 1, #rewardConfig do
            local tmp = string.split(rewardConfig[i], ";")
            for _, str in ipairs(tmp) do
                local t = string.split(str, ",")
                local goodsId = tonumber(t[1])
                local num = tonumber(t[2])
                local item = self:createItem(goodsId, num)
                if item then
                    addChildAuto(self._layoutUU, self, item, "rewardItem"..idx, "center")
                    idx = idx + 1
                end
            end
        end

    end

    local cdText = UI.Text:create()
    cdText:init("cd", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_208_50_60)
    addChildAuto(self._layoutUU, self, cdText, "cdText"..tag, "center")

    local quitBtn = UI.Button:create()
    quitBtn:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_0.png")
    addChildAuto(self._layoutUU, self, quitBtn, "quitBtn"..tag, "center")
    quitBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onQuit)
    quitBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    quitBtn:setText(UI.TEXT_1212634)

    self.cdText = cdText
    self.remind = 30
    self:scheduleUpdateTime()

end

function BigCrackResultView:scheduleUpdateTime()
    if tolua.isnull(self) or tolua.isnull(self.cdText) then
        return
    end

    if self.remind > 0 then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleUpdateTime, 1)
        local showText = AvalonUtil:_getFullFormatTime(self.remind, true, true, false)
        self.cdText:setText(string.format(UI.TEXT_1212635, showText))
    else
        self.cdText:setText("")
        self:onQuit()
        return
    end
    self.remind = self.remind - 1
end

function BigCrackResultView:onQuit()
    local SceneManager = require('app.game.SceneManager')
    SceneManager:getInstance():leaveWaiting()
end

function BigCrackResultView:createItem(itemId, num)
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


function BigCrackResultView:bindModel()

end


function BigCrackResultView:unbindModel()

end





return BigCrackResultView












