-- BigSailIslandBoatTableCell.lua
-- Author:siyu

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local BigSailIslandBoatTableCell = class("BigSailIslandBoatTableCell", UI.ListGrid)

UI = UI or {}
UI.BigSailIslandBoatTableCell = BigSailIslandBoatTableCell

local COM_WIDTH = 200
local COM_HEIGHT = 90

local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_town_navigation.plist"
}

local MONSTER_TYPE = {
    SMALL_MONSTER = 1,
    BIG_MONSTER = 2,
}

--构造函数(必备)
function BigSailIslandBoatTableCell:ctor()
    BigSailIslandBoatTableCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function BigSailIslandBoatTableCell:dtor()
    BigSailIslandBoatTableCell.super.dtor(self)
end

-- 初始化(必备)
function BigSailIslandBoatTableCell:init()
    BigSailIslandBoatTableCell.super.init(self)
    self:setTouchEnable(true)
    self:setSwallowTouches(false)
end

-- 模版函数：初始化组建的视图(必备)
function BigSailIslandBoatTableCell:onInitView()
end

function BigSailIslandBoatTableCell:onUpdateView()
    --print("BigSailIslandBoatTableCell --->: ", self._data)
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

function BigSailIslandBoatTableCell:getData()
    return self._data
end

function BigSailIslandBoatTableCell:cellClick()
end

function BigSailIslandBoatTableCell:hide()
end

function BigSailIslandBoatTableCell:isClickShowInfo()
    return true
end

function BigSailIslandBoatTableCell:clearSelect()
end


function BigSailIslandBoatTableCell:updateSkillList()
    local oneSkill = nil
    if self._data.isMonster then
        oneSkill = self:addOneMonster(self._data)
    else
        oneSkill = self:addOneSkill(self._data)
    end
    self.oneSkill = oneSkill
    self._cellLayout:addChild(oneSkill)
end

function BigSailIslandBoatTableCell:addOneSkill(data)
    local boatLayer = UI.Layout:create()
    boatLayer:init()
    boatLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)
    boatLayer:center(0,10)

    local boatBG = UI.Image:create()
    boatBG:init("ui_greatnavigation_list.png")
    boatBG:center()
    boatLayer:addChild(boatBG)

    -- 显示船只
    --print("data.boat--->: ", data)
    local shapeConfig = ConfigManager:getAllBoatData()
    local strBoat = "ui_greatnavigation_boat1.png"
    for k,v in pairs(shapeConfig) do
        if v.ID == data.boat then
            strBoat = v.navigationShow
        end
    end
    local boatBtn = UI.Button:create()
    boatBtn:init(strBoat,strBoat,strBoat)
    boatBtn:center(-210, -5)
    boatBtn:closeClickScale()
    --boatBtn:setScale(0.6)
    boatBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local boatInfo = ConfigManager:getAllBoatDataByID(data.boat)
        boatInfo.pk = data.pk
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SHOW_BOAT_INFO, boatInfo)
    end)
    boatLayer:addChild(boatBtn)

    -- 用户名称
    local userName = UI.Text:create()
    userName:init(data.rolename, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    userName:center(-64, -16)
    userName:setTextLeftUp()
    boatLayer:addChild(userName)

    -- 分割线
    local partingLine = UI.Image:create()
    partingLine:init("ui_greatnavigation_line.png")
    partingLine:center(-75, 0)
    boatLayer:addChild(partingLine)

    -- 公会名称
    local guildName = UI.Text:create()
    guildName:init(data.guildname, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    guildName:center(-64, 16)
    guildName:setTextLeftUp()
    boatLayer:addChild(guildName)

    -- 补给
    local supplyPic = UI.Image:create()
    supplyPic:init("ui_greatnavigation_supply.png")
    supplyPic:center(60, 0)
    boatLayer:addChild(supplyPic)

    local supplyNum = UI.Text:create()
    supplyNum:init(tostring(data.supplycount), UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 212, g = 177, b = 72})
    supplyNum:center(20, 0)
    supplyPic:addChild(supplyNum)

    -- 驱逐
    local expelBtn = UI.Button:create()
    expelBtn:init("ui_greatnavigation_btn_1.png","ui_greatnavigation_btn_1.png","ui_greatnavigation_btn_1.png")
    expelBtn:center(200, 0)
    expelBtn:setText(UI.TEXT_226117)
    expelBtn:closeClickScale()
    expelBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    expelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- local messageData = {
        --     islandid = data.islandid,
        --     guildid = data.guildid,
        --     otherPk = data.otherPk,
        --     boatid = data.boatid,
        --     myPk = data.myPk,
        -- }

        -- 超过时间关闭界面
        if mvc.bigSailPortModel:getIsPortClose() then
            mvc.closePanel("BigSailIsland", "BigSailIslandInfo")
            UI.ScrollBar:createByText(UI.TEXT_226216)
            return
        end

        local mySupplycount = 0
        local pets = {} -- 敌人宠物
        local myPets = {} -- 我方宠物
        local myPk = RoleDataManager:getMaster():getPK()
        local boatInfoData = mvc.bigSailIslandModel:getIsLandBoatsInfoByLandId(data.isLandId)
        for k,v in pairs(boatInfoData.info) do
            if v.pk == data.pk then
                pets = v.pets
            elseif v.pk == myPk then
                myPets = v.pets
            end
            if v.pk == RoleDataManager:getMasterPK() then
                mySupplycount = v.supplycount
            end
        end

        if #myPets < 3 then
            UI.ScrollBar:createByText(UI.TEXT_226168)
            return 
        end

        local pram = {}
        pram.expelData = {
            islandid = data.isLandId,
            otherPk = data.pk,
            mySupplycount = mySupplycount,
        }
        pram.our = {
            pets = myPets
        }
        pram.enemy = {
            pets = pets
        }
        mvc.openPanel("BigSailIsland", "BigSailIslandExpel", pram)
    end)
    boatLayer:addChild(expelBtn)

    local guildData = MasterDataManager:getGuildData()
    if not guildData then
        return
    end
    local myGuildID = guildData:getID()
    if myGuildID == data.guildid then
        expelBtn:hide()
    end

    -- 是否显示敌对标识
    local isShowEnemy = UI.Image:create()
    isShowEnemy:init("ui_greatnavigation_lable.png")
    isShowEnemy:center(190, -40)
    isShowEnemy:setVisible(data.isEnemy)
    boatLayer:addChild(isShowEnemy)

    local isShowEnemyTxt = UI.Text:create()
    isShowEnemyTxt:init(UI.TEXT_226160, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 209, g = 182, b = 157})
    isShowEnemyTxt:center(0, 0)
    isShowEnemy:addChild(isShowEnemyTxt)

    return boatLayer
end

function BigSailIslandBoatTableCell:addOneMonster(data)
    local boatLayer = UI.Layout:create()
    boatLayer:init()
    boatLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)
    boatLayer:center(0,10)

    local boatBG = UI.Image:create()
    boatBG:init("ui_greatnavigation_list.png")
    boatBG:center()
    boatLayer:addChild(boatBG)

    -- 显示船只
    --print("data.boat--->: ", data)
    -- local shapeConfig = ConfigManager:getAllBoatData()
    -- local strBoat = "ui_greatnavigation_boat1.png"
    -- for k,v in pairs(shapeConfig) do
    --     if v.ID == data.boat then
    --         strBoat = v.navigationShow
    --     end
    -- end

    local strBoat = "ui_greatnavigation_moster_1.png"
    if MONSTER_TYPE.BIG_MONSTER == data.boat then
        strBoat = "ui_greatnavigation_moster_2.png"
    end
    local boatBtn = UI.Button:create()
    boatBtn:init(strBoat,strBoat,strBoat)
    boatBtn:center(-210, -5)
    boatBtn:closeClickScale()
    --boatBtn:setScale(0.6)
    boatBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- local boatInfo = ConfigManager:getAllBoatDataByID(data.boat)
        -- boatInfo.pk = data.pk
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SHOW_BOAT_INFO, boatInfo)
    end)
    boatLayer:addChild(boatBtn)


    local LanguageManager = require "app.game.LanguageManager"
    local languageManagerInstance = LanguageManager:getInstance()
    local yieldBonus = ConfigManager:getIslandMonsterByID(data.boat)
    local rolename = languageManagerInstance:getLocalString(yieldBonus.name)
    -- 用户名称
    local userName = UI.Text:create()
    userName:init(rolename, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    userName:center(-64, -16)
    userName:setTextLeftUp()
    boatLayer:addChild(userName)

    -- 分割线
    local partingLine = UI.Image:create()
    partingLine:init("ui_greatnavigation_line.png")
    partingLine:center(-75, 0)
    boatLayer:addChild(partingLine)

    -- 公会名称
    local guildName = UI.Text:create()
    guildName:init(UI.TEXT_226706, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    guildName:center(-64, 16)
    guildName:setTextLeftUp()
    boatLayer:addChild(guildName)

    -- 补给
    local config2 = ConfigManager:getNavigationShopLimitTimeAllData()
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(config2[1].materialID))
    local supplyPic = UI.Image:create()
    supplyPic:init(goodsData.miniIcon)
    supplyPic:center(40, 0)
    boatLayer:addChild(supplyPic)

    local supplyNum = UI.Text:create()
    supplyNum:init("+"..tostring(data.supplycount), UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 212, g = 177, b = 72})
    supplyNum:center(40, 0)
    supplyPic:addChild(supplyNum)

    -- 驱逐
    local expelBtn = UI.Button:create()
    expelBtn:init("ui_greatnavigation_btn_1.png","ui_greatnavigation_btn_1.png","ui_greatnavigation_btn_1.png")
    expelBtn:center(200, 0)
    expelBtn:setText(UI.TEXT_226117)
    expelBtn:closeClickScale()
    expelBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    expelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- 超过时间关闭界面
        if mvc.bigSailPortModel:getIsPortClose() then
            mvc.closePanel("BigSailIsland", "BigSailIslandInfo")
            UI.ScrollBar:createByText(UI.TEXT_226216)
            return
        end

        local pets = {} -- 敌人宠物
        local myPets = {} -- 我方宠物
        local myPk = RoleDataManager:getMaster():getPK()
        local boatInfoData = mvc.bigSailIslandModel:getIsLandBoatsInfoByLandId(data.isLandId)
        for k,v in pairs(boatInfoData.info) do
            if v.pk == data.pk then
                pets = v.pets
            elseif v.pk == myPk then
                myPets = v.pets
            end
        end

        if #myPets < 3 then
            UI.ScrollBar:createByText(UI.TEXT_226168)
            return 
        end

        -- local pram = {}
        -- pram.expelData = {
        --     islandid = data.isLandId,
        --     otherPk = data.pk,
        -- }
        -- pram.our = {
        --     pets = myPets
        -- }
        -- pram.enemy = {
        --     pets = pets
        -- }
        -- mvc.openPanel("BigSailIsland", "BigSailIslandExpel", pram)


        -- 发送驱逐岛怪消息
        local messageData = {
            islandid = data.isLandId,
            monsterid = data.boat,
        }
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetBigSailSystem:reqExpulsionMonster(messageData)
        expelBtn:setVisible(false)
    end)
    boatLayer:addChild(expelBtn)

    local guildData = MasterDataManager:getGuildData()
    if not guildData then
        return
    end
    local myGuildID = guildData:getID()
    if myGuildID == data.guildid then
        expelBtn:hide()
    end

    -- 是否显示敌对标识
    local isShowEnemy = UI.Image:create()
    isShowEnemy:init("ui_greatnavigation_lable_2.png")
    isShowEnemy:center(190, -40)
    --isShowEnemy:setVisible(data.isEnemy)
    boatLayer:addChild(isShowEnemy)

    local isShowEnemyTxt = UI.Text:create()
    isShowEnemyTxt:init(UI.TEXT_226706, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 209, g = 182, b = 157})
    isShowEnemyTxt:center(0, 0)
    isShowEnemy:addChild(isShowEnemyTxt)

    return boatLayer
end

function BigSailIslandBoatTableCell:onClickBtn()
    -- 这里应该获取 self._data.detailDes值， 目前策划还没配，暂时用 1010001
    --print("onClickBtn--->: ", self._data.pk)
end