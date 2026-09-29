------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/04
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandExpelView = class("BigSailIslandExpelView", UI.HWBtnComponent)


require "app.ui.PetPVPEndLayer"
require "app.modules.bigsailisland.BigSailIslandRankResultView"


-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_common_symbol.plist",



    "ui_general_pet_pvp.plist",
}

local COM_WIDTH = 620
local COM_HEIGHT = 534

local winSize = cc.Director:getInstance():getWinSize()

function BigSailIslandExpelView:ctor(data)
    BigSailIslandExpelView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data

    self._enemyAllStarts = 0
    self._myAllStarts = 0
    self:bindModel()
end

function BigSailIslandExpelView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandExpelView.super.init(self, ... )
end

function BigSailIslandExpelView:dtor()
    BigSailIslandExpelView.super.dtor(self)
    self:unbindModel()

    -- 请求对应岛屿的信息
    local data = {}
    data.landId = self.data.expelData.islandid
    Net.NetBigSailSystem:reqIslandInfo(data)

    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandExpelView")
end


function BigSailIslandExpelView:onInitView()
    --self:enableDebugDraw()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 0)
    self:addChild(contentLayout, 5)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local bg = UI.Image.create()
    bg:init("ui_greatnavigation_paper_2.png")
    bg:center(0,0)
    contentLayout:addChild(bg)

    local bg2 =  UI.Image9.create()
    bg2:init("ui_greatnavigation_bg_2.png", cc.rect(100,0,150,65), cc.size(428, 360))
    bg2:center(0, -16)
    bg:addChild(bg2)

    local titleLinePic =  UI.Image.create()
    titleLinePic:init("ui_greatnavigation_line_2.png")
    titleLinePic:center(0, -210)
    contentLayout:addChild(titleLinePic)

    local titlePic =  UI.Image.create()
    titlePic:init("ui_greatnavigation_title_1.png")
    titlePic:center(0, -31)
    titleLinePic:addChild(titlePic)


    -- 敌方阵容
    self:enemyBattleArray()

    -- 我放阵容
    self:ourBattleArray()

    -- 分割线2 
    local titleLinePic2 =  UI.Image.create()
    titleLinePic2:init("ui_greatnavigation_line_2.png")
    titleLinePic2:center(0, 180)
    contentLayout:addChild(titleLinePic2)

    -- 驱逐一次
    local expelOnceBtn = UI.Button:create()
    expelOnceBtn:init("ui_greatnavigation_btn_4.png","ui_greatnavigation_btn_4.png","ui_greatnavigation_btn_4.png")
    expelOnceBtn:center(-125, 220)
    expelOnceBtn:setText(UI.TEXT_226118)
    expelOnceBtn:closeClickScale()
    expelOnceBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    expelOnceBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)

        local callback = function()
            local messageData = {
                islandid = self.data.expelData.islandid,
                otherPk = self.data.expelData.otherPk,
                num = 1,
            }
            Net.NetBigSailSystem:reqExpulsionBoat(messageData)
            self:close()
        end

        self:checkStartsShowTips(callback)
        
    end)
    contentLayout:addChild(expelOnceBtn)

    -- 驱逐六次
    local expelSixTimesBtn = UI.Button:create()
    expelSixTimesBtn:init("ui_greatnavigation_btn_4.png","ui_greatnavigation_btn_4.png","ui_greatnavigation_btn_4.png")
    expelSixTimesBtn:center(130, 220)
    expelSixTimesBtn:setText(UI.TEXT_226119)
    expelSixTimesBtn:closeClickScale()
    expelSixTimesBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    expelSixTimesBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local callback = function()
            local messageData = {
                islandid = self.data.expelData.islandid,
                otherPk = self.data.expelData.otherPk,
                num = 6,
            }
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetBigSailSystem:reqExpulsionBoat(messageData)
        end

        self:checkStartsShowTips(callback)
    end)
    contentLayout:addChild(expelSixTimesBtn)

    --------------------
    -- local data = {isWin = false, petStatistics = {{curHp = 0, maxHp = 99, spriteid = 2490819, attackHp = 0, recoverHp = 0}, {curHp = 0, maxHp = 99, spriteid = 2556349, attackHp = 0, recoverHp = 0}, {curHp = 0, maxHp = 99, spriteid = 2621889, attackHp = 0, recoverHp = 0}, {curHp = 4154390, maxHp = 4154390, spriteid = 2687429, attackHp = 99, recoverHp = 0}, {curHp = 1985740, maxHp = 1985740, spriteid = 2752959, attackHp = 1000099, recoverHp = 0}, {curHp = 3114774, maxHp = 3114774, spriteid = 2818499, attackHp = 99, recoverHp = 0}}}
    -- local panel = UI.BigSailIslandRankResultView:create(data)
    -- panel:center()
    -- panel:setName("PetPVPEndLayer")
    -- self:addChild(panel,UI_ZORDER.ACTIVITY)
    -- local data = {}
    -- mvc.openPanel("BigSailIsland","BigSailIslandRankResult",data)
end

function BigSailIslandExpelView:petsLayer(pets, isEnemy)
    -- 宠物船员面板
    local petsLayout = UI.Layout:create()
    petsLayout:init()
    petsLayout:setSize(335, 100)
    petsLayout:centerBottom(15)

    local strTitle = ""
    if isEnemy then
        strTitle = UI.TEXT_226120
    else
        strTitle = UI.TEXT_226121
    end
    local titleTxt = UI.Text:create()
    titleTxt:init(strTitle, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    titleTxt:center(-135, 33)
    petsLayout:addChild(titleTxt)

    local allStarts = 0
    local k1 = 0
    for k,v in pairs(pets) do
        local config = ConfigManager:getPetDataByID(v.petTempleteId)
        local iconStr = ""
        local strs = string.split(config.icon, ";")
        if v.skinid and v.skinid ~= 0 then
            local skinConfig = ConfigManager:getPetSkinByID(v.skinid)
            iconStr = skinConfig.skinIcon
        elseif v.isvariant then
            iconStr = strs[2]
        else
            iconStr = strs[1]
        end

        local image = UI.Image.create()
        image:init((iconStr..".png"))
        image:center(-124 + k1 * 123, 99)
        petsLayout:addChild(image)

        local placeStr = ""
        if k1 == 0 then
            if isEnemy then
                placeStr = "ui_greatnavigation_place_high_enemy.png"
            else
                placeStr = "ui_greatnavigation_place_high_self.png"
            end
        elseif k1 == 1 then
            if isEnemy then
                placeStr = "ui_greatnavigation_place_mid_enemy.png"
            else
                placeStr = "ui_greatnavigation_place_mid_self.png"
            end
        elseif k1 == 2 then
            if isEnemy then
                placeStr = "ui_greatnavigation_place_low_enemy.png"
            else
                placeStr = "ui_greatnavigation_place_low_self.png"
            end
        end

        local image2 = UI.Image.create()
        image2:init(placeStr)
        image2:center(36, 36)
        image:addChild(image2)

        allStarts = allStarts + v.power
        k1 = k1 + 1
    end

    local startsImage = UI.Image.create()
    startsImage:init("symbol_character_hero_power.png")
    startsImage:center(40, 167)
    petsLayout:addChild(startsImage)

    local petStartsTxt = UI.Text:create()
    petStartsTxt:init(petStartsTxt:numformat(string.format("%d",allStarts)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 237, g = 189, b = 84})
    petStartsTxt:centerRight(-134)
    petStartsTxt:setTextLeft()
    startsImage:addChild(petStartsTxt)

    if isEnemy then
        --敌方战力
        self._enemyAllStarts = allStarts
    else
        --我方战力
        self._myAllStarts = allStarts
    end

    return petsLayout
end

function BigSailIslandExpelView:enemyBattleArray()
    if self.enemyLayer then
        self.contentLayout:removeChildByName("enemyPic")
    end

    local enemyPic =  UI.Image.create()
    enemyPic:init("ui_greatnavigation_battlebg_1.png")
    enemyPic:center(0, -100)
    enemyPic:setName("enemyPic")
    self.contentLayout:addChild(enemyPic, 9)

    local enemyLayer = self:petsLayer(self.data.enemy.pets, true)
    enemyLayer:setName("enemyLayer")
    enemyPic:addChild(enemyLayer, 10)
    enemyLayer:center(0, -100) 
end

function BigSailIslandExpelView:ourBattleArray()
    if self.ourLayer then
        self.contentLayout:removeChildByName("outPic")
    end

    local outPic =  UI.Image.create()
    outPic:init("ui_greatnavigation_battlebg_2.png")
    outPic:center(0, 70)
    outPic:setName("outPic")
    self.contentLayout:addChild(outPic, 9)

    local ourLayer = self:petsLayer(self.data.our.pets, false)
    ourLayer:setName("ourLayer")
    outPic:addChild(ourLayer)
    ourLayer:center(0, -100) 
end

function BigSailIslandExpelView:checkStartsShowTips(callback)

    local showTips,needNum,needNum2 = mvc.bigSailIslandModel:getConsumptionRate(self._enemyAllStarts,self._myAllStarts)

    local mySupplycount = self.data.expelData.mySupplycount
    if mySupplycount < needNum then
        UI.ScrollBar:createByText(string.format(UI.TEXT_228300,needNum))
        return
    end


    if showTips then
        local tips = UI.Tips:createTips(string.format(UI.TEXT_226187,needNum,needNum2),UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            if callback then
                callback()
            end
        end)
    else
        if callback then
            callback()
        end
    end

end




function BigSailIslandExpelView:bindModel()

end


function BigSailIslandExpelView:unbindModel()

end





return BigSailIslandExpelView












