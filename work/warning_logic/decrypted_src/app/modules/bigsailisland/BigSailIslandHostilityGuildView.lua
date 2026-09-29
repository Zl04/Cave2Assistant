------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandHostilityGuildView = class("BigSailIslandHostilityGuildView", UI.HWBtnComponent)

require "app.modules.bigsailisland.BigSailIslandGuildTableCellView"

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function BigSailIslandHostilityGuildView:ctor(data)
    BigSailIslandHostilityGuildView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.verticalNum = 1 
    self.horizontalNum = 3
    self.islandId = 0
    self:bindModel()
end

function BigSailIslandHostilityGuildView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandHostilityGuildView.super.init(self, ... )
end

function BigSailIslandHostilityGuildView:dtor()
    BigSailIslandHostilityGuildView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandHostilityGuildView")
end


function BigSailIslandHostilityGuildView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    --self:enableDebugDraw()

    local bg1  = UI.Image:create()
    bg1:init("ui_bg_box1.png")
    bg1:center(50, 0)
    self.contentLayout:addChild(bg1)

    local bg2  = UI.Image:create()
    bg2:init("ui_bg_paper1.png")
    bg2:center(50, 0)
    self.contentLayout:addChild(bg2)

    local bgTitle  = UI.Image:create()
    bgTitle:init("ui_greatnavigation_top.png")
    bgTitle:center(50, -266)
    self.contentLayout:addChild(bgTitle)

    local bgTree  = UI.Image:create()
    bgTree:init("ui_bg_tree.png")
    bgTree:center(-313, 53)
    self.contentLayout:addChild(bgTree)

    local trophyTree  = UI.Image:create()
    trophyTree:init("ui_bg_tree.png")
    trophyTree:center(0, 0)
    bgTree:addChild(trophyTree)

    local rattanTree  = UI.Image:create()
    rattanTree:init("ui_bg_rattan2.png")
    rattanTree:center(415, 180)
    self.contentLayout:addChild(rattanTree)

    local topTitleTxt1 = UI.Text:create()
    topTitleTxt1:init(UI.TEXT_226139, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    topTitleTxt1:center(-200, -190)
    self.contentLayout:addChild(topTitleTxt1)

    local topTitleTxt2 = UI.Text:create()
    topTitleTxt2:init(UI.TEXT_110050, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    topTitleTxt2:center(-50, -190)
    self.contentLayout:addChild(topTitleTxt2)

    local topTitleTxt3 = UI.Text:create()
    topTitleTxt3:init(UI.TEXT_226124, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    topTitleTxt3:center(100, -190)
    self.contentLayout:addChild(topTitleTxt3)

    local topTitleTxt4 = UI.Text:create()
    topTitleTxt4:init(UI.TEXT_226125, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    topTitleTxt4:center(260, -190)
    self.contentLayout:addChild(topTitleTxt4)

    local splitBg  = UI.Image:create()
    splitBg:init("ui_greatnavigation_line_4.png")
    splitBg:center(50, -170)
    self.contentLayout:addChild(splitBg)


    -- 占领该岛屿的公会列表
    local guildListWidth = 650
    local guildListHeight = 385
    local guildList = UI.GridList:create()
    guildList:init(UI.BigSailIslandGuildTableCellView, self.verticalNum, self.horizontalNum, 541, 92, 0, 9, 0)
    guildList:setSize(guildListWidth, guildListHeight)
    guildList:center(0, 30)
    guildList:disableToDragGrid()
    guildList:setCallbackForGridClick(self, self.cellClickCallback)
    guildList:setScrollBarEnabled(true)
    guildList:setCircleVisible(false)
    self.guildList = guildList
    self.contentLayout:addChild(self.guildList)
end

function BigSailIslandHostilityGuildView:refreshGuildsList(dataList)
    print("refreshGuildsList-->:")
    local guildInfoList = {}
    local myGuildID = MasterDataManager:getGuildData():getID()
    local islandConfig = mvc.bigSailIslandModel:getIsLandBoatsInfoByLandId(dataList.islandid)
    self.islandId = dataList.islandid
    for k,v in pairs(dataList.randGuilds) do
        -- 过滤掉自己的公会
        if v.ID ~= myGuildID then
            local isEnemy = false
            --print("islandConfig===>: ", islandConfig)
            for k,v2 in pairs(islandConfig.enemyGuilds) do
                if v2 == v.ID then
                    isEnemy = true
                    break
                end
            end
            v.isEnemyGuild = isEnemy
            v.isLandId = dataList.islandid

            table.insert(guildInfoList, v)
        end
    end
    self.guildList:setData(guildInfoList)
end

function BigSailIslandHostilityGuildView:refreshEnemyQuery(data)
    mvc.bigSailIslandModel:changeEnemyGuild(data, self.islandId)

    local message = {}
    message.islandid = self.islandId
    Net.NetBigSailSystem:reqIslandAllGuilds(message)
end

function BigSailIslandHostilityGuildView:setEnemyFail()
    UI.ScrollBar:createByText(UI.TEXT_226186)
end

function BigSailIslandHostilityGuildView:bindModel()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_REFRESH_ISLAND_GUILDS_LIST,self, self.refreshGuildsList)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_REFRESH_ENEMY_RANK,self, self.refreshEnemyQuery)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_SET_ENEMY_FAIL,self, self.setEnemyFail)
end


function BigSailIslandHostilityGuildView:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_REFRESH_ISLAND_GUILDS_LIST,self, self.refreshGuildsList)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_REFRESH_ENEMY_RANK,self, self.refreshEnemyQuery)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_SET_ENEMY_FAIL,self, self.setEnemyFail)
end





return BigSailIslandHostilityGuildView












