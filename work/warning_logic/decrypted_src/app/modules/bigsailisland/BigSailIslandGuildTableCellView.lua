------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/14
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")
local BigSailIslandGuildTableCellView = class("BigSailIslandGuildTableCellView", UI.ListGrid)

UI = UI or {}
UI.BigSailIslandGuildTableCellView = BigSailIslandGuildTableCellView

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_town_navigation.plist"
}

local COM_WIDTH = 200
local COM_HEIGHT = 90

function BigSailIslandGuildTableCellView:ctor()
    BigSailIslandGuildTableCellView.super.ctor(self)
    self:bindModel()
end

function BigSailIslandGuildTableCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandGuildTableCellView.super.init(self, ... )
end

function BigSailIslandGuildTableCellView:dtor()
    BigSailIslandGuildTableCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandGuildTableCellView")
end


function BigSailIslandGuildTableCellView:onInitView()
end

function BigSailIslandGuildTableCellView:onUpdateView()
    --print("BigSailIslandGuildTableCell --->: ", self._data)
    if not self._data then
        return
    end
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self._cellLayout = cellLayout
    self:addChild(cellLayout)

    self:updateSkillList()
end

function BigSailIslandGuildTableCellView:getData()
    return self._data
end

function BigSailIslandGuildTableCellView:cellClick()
end

function BigSailIslandGuildTableCellView:hide()
end

function BigSailIslandGuildTableCellView:isClickShowInfo()
    return true
end

function BigSailIslandGuildTableCellView:clearSelect()
end


function BigSailIslandGuildTableCellView:updateSkillList()
    local oneSkill = self:addOneSkill(self._data)
    self.oneSkill = oneSkill
    self._cellLayout:addChild(oneSkill)
end

function BigSailIslandGuildTableCellView:addOneSkill(data)
    local guildLayer = UI.Layout:create()
    guildLayer:init()
    guildLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)
    guildLayer:center()

    -- local guildBG = UI.Image:create()
    -- guildBG:init("ui_greatnavigation_list.png")
    -- guildBG:center()
    -- guildLayer:addChild(guildBG)

    -- 公会图标
    local iconName = GameDataManager:getInstance():getGuildIconForIconID(data.iconID)
    local guildIcon = UI.Image:create()
    guildIcon:init(iconName)
    guildIcon:center(-160, 0)
    guildLayer:addChild(guildIcon)

    -- 公会名字
    local guildNameTxt = UI.Text:create()
    guildNameTxt:init(data.name, UI.SYS_FONT, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    guildNameTxt:center(150,0)
    guildNameTxt:setTextRight()
    guildIcon:addChild(guildNameTxt)

    -- 公会会长名字
    -- local guildLeaderNameTxt = UI.Text:create()
    -- guildLeaderNameTxt:init(data.leaderName, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    -- guildLeaderNameTxt:center(100,20)
    -- guildLeaderNameTxt:setTextRight()
    -- guildIcon:addChild(guildLeaderNameTxt)

    -- 科技总等级
    -- local techTotalLvTxt = UI.Text:create()
    -- techTotalLvTxt:init(tostring(data.techTotalLv), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    -- techTotalLvTxt:center(70,4)
    -- techTotalLvTxt:setTextRight()
    -- guildLayer:addChild(techTotalLvTxt)

    -- 公会人数
    local guildPersonTxt = UI.Text:create()
    guildPersonTxt:init(tostring(data.curMemberNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    guildPersonTxt:center(135,4)
    guildPersonTxt:setTextRight()
    guildLayer:addChild(guildPersonTxt)

    -- 设置敌对
    local str1 = self:getIsCancelEnemy() and UI.TEXT_226152 or UI.TEXT_226151
    local setIsEnemyBtn = UI.Button:create()
    setIsEnemyBtn:init("ui_greatnavigation_btn_1.png","ui_greatnavigation_btn_1.png","ui_greatnavigation_btn_1.png")
    setIsEnemyBtn:center(300, 0)
    setIsEnemyBtn:closeClickScale()
    setIsEnemyBtn:setText(str1)
    setIsEnemyBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    setIsEnemyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)

        local islandConfig = mvc.bigSailIslandModel:getIsLandBoatsInfoByLandId(data.isLandId)
        local enemyNums = 0
        for k,v2 in pairs(islandConfig.enemyGuilds) do
            if v2 then
                enemyNums = enemyNums + 1
            end
        end

        local config2 = ConfigManager:getAllNavigationGeneralConfigData()
        local enemyNumLimit = config2[1].hostilityGuildNum
        if enemyNumLimit <= enemyNums and (self._data.isEnemyGuild) then
            UI.ScrollBar:createByText(UI.TEXT_226186)
            return
        end

        local message = {}
        message.isCancel = not self:getIsCancelEnemy()
        message.islandid = data.isLandId
        message.guildid = data.ID

        -- if message.isCancel then
        --     UI.ScrollBar:createByText(UI.TEXT_226172)
        -- else
        --     UI.ScrollBar:createByText(UI.TEXT_226171)
        -- end

        Net.NetBigSailSystem:reqSetEnemyGuild(message)
    end)
    guildLayer:addChild(setIsEnemyBtn)

    return guildLayer
end

function BigSailIslandGuildTableCellView:getIsCancelEnemy()
    local isEnemy = self._data.isEnemyGuild
    self._data.isEnemyGuild = not isEnemy
    return isEnemy
end

function BigSailIslandGuildTableCellView:onClickBtn()
    -- 这里应该获取 self._data.detailDes值， 目前策划还没配，暂时用 1010001
    --print("onClickBtn--->: ", self._data.pk)
end


function BigSailIslandGuildTableCellView:bindModel()

end


function BigSailIslandGuildTableCellView:unbindModel()

end





return BigSailIslandGuildTableCellView












