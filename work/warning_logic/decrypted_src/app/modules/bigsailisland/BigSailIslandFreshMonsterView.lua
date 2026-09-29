------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/08/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandFreshMonsterView = class("BigSailIslandFreshMonsterView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_common_symbol.plist",
    "ui_common_btn.plist",
}

local COM_WIDTH = 500
local COM_HEIGHT = 300
local winSize = cc.Director:getInstance():getWinSize()

function BigSailIslandFreshMonsterView:ctor()
    BigSailIslandFreshMonsterView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function BigSailIslandFreshMonsterView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandFreshMonsterView.super.init(self, ... )
end

function BigSailIslandFreshMonsterView:dtor()
    BigSailIslandFreshMonsterView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandFreshMonsterView")
end


function BigSailIslandFreshMonsterView:onInitView()
    self:center(0, 0)
    --self:enableDebugDraw()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0,0)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(COM_WIDTH / 2, COM_HEIGHT / 2)
    self.contentLayout:addChild(mask, 0)

    local bgImage = UI.Image:create()
    bgImage:init("ui_greatnavigation_paper_5.png")
    bgImage:center(0, 0)
    self.contentLayout:addChild(bgImage)

    -- 标题
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226700, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    titleText:center(0, -110)
    self.contentLayout:addChild(titleText)

    -- 内容
    local contentText = UI.Text:create()
    contentText:init(UI.TEXT_226701, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    contentText:center(0, -55)
    self.contentText = contentText
    self.contentLayout:addChild(contentText)

    -- 内容提示
    local contentText2 = UI.Text:create()
    contentText2:init(UI.TEXT_226702, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 96, g = 0, b = 0})
    contentText2:center(0, -20)
    self.showContent = contentText2
    self.contentLayout:addChild(contentText2)

    -- 显示活动时间
    local config2 = ConfigManager:getAllNavigationGeneralConfigData()
    local startDate = GameManager:getClientDateByConfigTimeStr(config2[1].islandMonsterStartTime, "%Y.%m.%d")
    local endDate = GameManager:getClientDateByConfigTimeStr(config2[1].islandMonsterEndTime, "%Y.%m.%d")
    local dateStr = UI.TEXT_226706..string.format(UI.TEXT_1324530, startDate, endDate)
    local contentText3 = UI.Text:create()
    contentText3:init(dateStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 96, g = 0, b = 0})
    contentText3:center(0, 10)
    self.contentText3 = contentText3
    self.contentLayout:addChild(contentText3)

    -- 消耗
    local contentText3 = UI.Text:create()
    contentText3:init(UI.TEXT_223908..":", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    contentText3:center(-65, 45)
    self.contentLayout:addChild(contentText3)

    local config = ConfigManager:getAllNavigationGeneralConfigData()
    local strConfig = string.split(config[1].islandMonsterRefreshConsume,",") 
    -- 消耗 
    local costDiamond = UI.Text:create()
    costDiamond:init(tostring(strConfig[2]), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    costDiamond:centerRight(170, 45)
    costDiamond:setTextRight()
    self.contentLayout:addChild(costDiamond)

    -- 消耗 
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(strConfig[1]))
    local costImage = UI.Image:create()
    costImage:init(goodsData.miniIcon)
    costImage:centerLeft(-30, 0)
    costDiamond:addChild(costImage)

    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local parent = self:getParent()
        if parent.mCloseLayer then
            parent.mCloseLayer = nil
        end
        mvc.closePanel("BigSailIsland", "BigSailIslandFreshMonster")
    end)
    no:center(-110, 110)
    self.contentLayout:addChild(no)

    -- 确认按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()

        local baseInfo = mvc.bigSailPortModel:getBaseData()
        if baseInfo.dayRefreshMonsterNum >= config[1].islandMonsterRefreshNum then
            -- 刷新达到上限
            UI.ScrollBar:createByText(UI.TEXT_224805)
            return
        end

        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(strConfig[1]), true)
        if goodNumber < tonumber(strConfig[2]) then
            -- 水晶不足
            UI.ScrollBar:createByText(UI.TEXT_222209)
            return
        end

        Net.NetBigSailSystem:reqRefreshMonster()
    end)
    yes:center(120, 110)
    self.contentLayout:addChild(yes)

    -- 今日剩余 UI.TEXT_221300
    local contentText4 = UI.Text:create()
    contentText4:init(UI.TEXT_221300, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    contentText4:center(-10, -35)
    self.residueNums = contentText4
    yes:addChild(contentText4)

    self:freshShowData()
end

function BigSailIslandFreshMonsterView:freshShowData()
    local monstersData = {}
    local monsterData = mvc.bigSailPortModel:getIslandMonsterInfos()
    local openMonster = mvc.bigSailPortModel:getIslandMonsterIsOpen()
    if openMonster then
        if #monsterData > 0 then
            local show = false
            for k,v in pairs(monsterData) do
                if #v.monsterids > 0 then
                    show = true
                    break
                end
            end
            self.showContent:setVisible(show)
            if not show then
                self.contentText:center(0, -35)
                self.contentText3:center(0, 5)
            end
        else
            self.showContent:setVisible(false)
            self.contentText:center(0, -35)
            self.contentText3:center(0, 5)
        end
    else
        self.showContent:setVisible(false)
        self.contentText:center(0, -35)
        self.contentText3:center(0, 5)
    end

    local baseInfo = mvc.bigSailPortModel:getBaseData()
    local config = ConfigManager:getAllNavigationGeneralConfigData()
    local haveRefreshNums = config[1].islandMonsterRefreshNum - baseInfo.dayRefreshMonsterNum
    self.residueNums:setText(UI.TEXT_221300..tostring(haveRefreshNums))
end

function BigSailIslandFreshMonsterView:refreshSuccess()
    UI.ScrollBar:createByText(UI.TEXT_1212610)
    local parent = self:getParent()
    if parent.mCloseLayer then
        parent.mCloseLayer = nil
    end
    mvc.closePanel("BigSailIsland", "BigSailIslandFreshMonster")
end


function BigSailIslandFreshMonsterView:bindModel()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_MONSTER_FRESH_SUCCESS,self, self.refreshSuccess)
end


function BigSailIslandFreshMonsterView:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_MONSTER_FRESH_SUCCESS,self, self.refreshSuccess)
end





return BigSailIslandFreshMonsterView












