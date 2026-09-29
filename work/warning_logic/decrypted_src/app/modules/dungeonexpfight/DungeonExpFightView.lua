------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/08/07
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DungeonExpFightView = class("DungeonExpFightView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

-- 资源
local COM_RES_LIST = {
    "ui_town_boxtreasure.plist",
    "ui_common_symbol.plist",
    "ui_common_btn.plist",
    "ui_town_expdungeon.plist",
}

local COM_WIDTH = 610
local COM_HEIGHT = 560


local JoinCostGoodsId = 23020001 --进入副本消耗的物品(金币)

local winSize = cc.Director:getInstance():getWinSize()

function DungeonExpFightView:ctor()
    DungeonExpFightView.super.ctor(
    	self,
    	UI.Type.DUNGEON_EXP_FIGHT_INFO,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.nowCostGolds = 0
    self.goldTimes = 0
    --self.freeTimes = 5


    self.caveMode = PublicDefine.CAVE_MODE.MODE_EXP
    self.curLevel = 1
    self.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(self.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint()) - 2000
end

function DungeonExpFightView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.dungeonexpfight", "DungeonExpFight", false)
    DungeonExpFightView.super.init(self, ... )
end

function DungeonExpFightView:dtor()
    DungeonExpFightView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.dungeonexpfight.DungeonExpFightView")
end


function DungeonExpFightView:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 0)
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- title
    -- local title = UI.Image:create()
    -- title:init("ui_bg_title.png")
    -- title:centerUp(-10)
    -- contentLayout:addChild(title, 999)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_expdungeon_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226400, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_255_247_225)
    titleText:center(0, -153)
    bg:addChild(titleText, 100)

    -- -- 背景图片
    -- local boxMap  = UI.Image:create()
    -- boxMap:init("ui_boxtreasure_map.png")
    -- boxMap:center(0, 15)
    -- contentLayout:addChild(boxMap)

    -- local leftImg  = UI.Image:create()
    -- leftImg:init("ui_boxtreasure_decorate.png")
    -- leftImg:leftBottom(-45, 10)
    -- contentLayout:addChild(leftImg)

    -- local rightImg  = UI.Image:create()
    -- rightImg:init("ui_bg_decoration.png")
    -- rightImg:rightBottom(-35, 10)
    -- contentLayout:addChild(rightImg)


    -- 拥有的金币数量
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(JoinCostGoodsId, true)
    local goodsData = GoodsDataManager:createLocalGoodsData(JoinCostGoodsId)
    local goodsIcon = goodsData:getSmallIconName()

    local goldBgImg = UI.Image:create()
    goldBgImg:init("ui_expdungeon_black_2.png")
    goldBgImg:center(150, -200)
    contentLayout:addChild(goldBgImg)

    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 255, g = 255, b = 255})
    self._momey:center(13, 0)
    goldBgImg:addChild(self._momey, 4)
    self._momey:setText(self._momey:numformat(string.format("%d",goodNumber)))

    local goldImg = UI.Image:create()
    goldImg:init(goodsIcon)
    goldImg:centerLeft(-25, 0)
    self._momey:addChild(goldImg)

    -- 金币挑战
    local moneyBtn =  UI.Button:create()
    moneyBtn:init("ui_expdungeon_btn.png","ui_expdungeon_btn.png","ui_expdungeon_btn.png")
    moneyBtn:leftUp(157, 420)
    moneyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.goldTimes <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_1328010)
            return
        end

        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(JoinCostGoodsId, true)
        if goodNumber < self.nowCostGolds or self.nowCostGolds == 0 then
            UI.ScrollBar:createByText(UI.TEXT_110210)
            return 
        end

        if self.goldTimes <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_1212646)
            return
        end

        local id = 1--LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(mvc.everWinterRiftModel:getCurLevel())--(self.selectedIcon:getTag())
            Net.NetRoleSystem:heroEnterCaveSceneRequest(
                LevelSelectUtil:getInstance().mPattern,
                self.caveMode,
                self.curDiff,
                id,
            self.spriteID)
    end)
    moneyBtn:closeClickScale()
    moneyBtn:setText(UI.TEXT_226401.."x"..tostring(self.goldTimes))
    moneyBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    contentLayout:addChild(moneyBtn)
    self.moneyBtn = moneyBtn

    --当前等级挑战需要消耗的金币数量
    local costBgImg = UI.Image:create()
    costBgImg:init("ui_expdungeon_black.png")
    costBgImg:center(0, -40)
    moneyBtn:addChild(costBgImg, 3)

    -- local costImg = UI.Image:create()
    -- --costImg:init("symbol_gaming_diamond.png")
    -- costImg:init(goodsIcon)
    -- costImg:centerLeft(-10, 0)
    -- costBgImg:addChild(costImg, 3)

    local costTxt = UI.Text:create()
    costTxt:init("0", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 255, g = 255, b = 255})
    costTxt:setTextCenter()
    costTxt:centerUp(-4, 10)
    --costTxt:centerLeft(costImg:getContentSize().width + 4)
    costBgImg:addChild(costTxt, 4)
    self:freshCostGolds()
    costTxt:setText(tostring(self.nowCostGolds))

    local costImg = UI.Image:create()
    --costImg:init("symbol_gaming_diamond.png")
    costImg:init(goodsIcon)
    costImg:centerLeft(-25, 0)
    costTxt:addChild(costImg, 3)

    --costTxt:setText(costTxt:numformat(string.format("%d",goodNumber)))

    -- -- 免费挑战
    -- local freeBtn =  UI.Button:create()
    -- freeBtn:init("ui_btn_yellow6_1.png","ui_btn_yellow6_1.png","ui_btn_yellow6_1.png")
    -- freeBtn:leftUp(600, 420)
    -- freeBtn:closeClickScale()
    -- freeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     if self.freeTimes <= 0 then
    --         UI.ScrollBar:createByText(UI.TEXT_1328010)
    --         return
    --     end
    -- end)
    -- freeBtn:setText(UI.TEXT_226402.."x"..tostring(self.freeTimes))
    -- freeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- contentLayout:addChild(freeBtn)
    -- self.freeBtn = freeBtn

    self:refreshBtnStatus()

    ----------------------

    --local goodsData2 = GoodsDataManager:createLocalGoodsData(23040001)
    ----------------------
end

function DungeonExpFightView:freshCostGolds()
    -- 根据当前等级刷新金币消耗量
    local master = RoleDataManager:getMaster()
    local heroDataConfig = ConfigManager:getHeroConfig(master:getSex(), master:getLevel())
    if not heroDataConfig then 
        self.nowCostGolds = 0
        return 
    end
    self.nowCostGolds = heroDataConfig.coinNum
end

function DungeonExpFightView:refreshBtnStatus()
    local extraTimes = RoleDataManager:getMaster():getExpCaveTimes()
    local config = ConfigManager:getExpPerNums()
    self.goldTimes = config - RoleDataManager:getMaster():getDungeonExpFightNum() + extraTimes
    --self.freeTimes = 5

    self.moneyBtn:setText(UI.TEXT_226401.."x"..tostring(self.goldTimes))
    --self.freeBtn:setText(UI.TEXT_226402.."x"..tostring(self.freeTimes))
end


function DungeonExpFightView:bindModel()

end


function DungeonExpFightView:unbindModel()

end





return DungeonExpFightView












