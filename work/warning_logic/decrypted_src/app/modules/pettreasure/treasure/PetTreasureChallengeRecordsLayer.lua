------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureChallengeRecordsLayer = class("PetTreasureChallengeRecordsLayer", UI.HWBtnComponent)

require "app.modules.pet.PetMainListCell"
local SceneManager = require("app.game.SceneManager")
local PetPacketLayer = require("app.modules.pettreasure.common.PetTreasurePacketLayer")
local PetTreasureEmbattleLayer = require("app.modules.pettreasure.treasure.PetTreasureEmbattleLayer")
local PetTreasureFragmentsBagLayer = require("app.modules.pettreasure.treasure.PetTreasureFragmentsBagLayer")

-- 资源
local COM_RES_LIST = {
    "ui_gaming_playerstate.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local ITEM_WIDTH = 880
local ITEM_HEIGHT = 94

function PetTreasureChallengeRecordsLayer:ctor()
    PetTreasureChallengeRecordsLayer.super.ctor(
    	self,
    	UI.Type.PET_TREASURE_GATHER,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetTreasureChallengeRecordsLayer:init()
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureChallengeRecordsLayer.super.init(self)
end

function PetTreasureChallengeRecordsLayer:dtor()
    PetTreasureChallengeRecordsLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureChallengeRecordsLayer")
end

function PetTreasureChallengeRecordsLayer:onInitView()

    self.challenagerList = {}
    self.isEmbattling = false

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部背景图片
    local innerBG  = UI.Image:create()
    innerBG:init("ui_pettreasure_record_bg.png")
    innerBG:leftUp(28, 16)
    -- innerBG:enableDebugDraw()
    contentLayout:addChild(innerBG)
    self.innerBG = innerBG

    -- 标题
    local titleBg  = UI.Image:create()
    titleBg:init("ui_pettreasure_record_title.png")
    titleBg:centerUp(74)
    -- titleBg:enableDebugDraw()
    contentLayout:addChild(titleBg)

    local titleTx  = UI.Text:create()
    titleTx:init(UI.TEXT_1314115, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_190_190_190)
    titleTx:centerUp(2)
    titleBg:addChild(titleTx)

    self:updateLayer()
end

function PetTreasureChallengeRecordsLayer:updateLayer()

    -- 加载神器碎片
    self:updateFragmentsBag()

    -- 加载信息
    local recordsData = mvc.petTreasureModel:getBattleRecord()
    if #recordsData > 0 then
        self:updateRecordsList(recordsData)
    end
end

function PetTreasureChallengeRecordsLayer:updateFragmentsBag()
    local fragmentsBaglayer = self.contentLayout:getChildByName("fragmentsBaglayer")
    if not fragmentsBaglayer then
        fragmentsBaglayer = PetTreasureFragmentsBagLayer:create()
        fragmentsBaglayer:init(true)
        fragmentsBaglayer:rightUp(40, 38)
        -- fragmentsBaglayer:enableDebugDraw()
        fragmentsBaglayer:setName("fragmentsBaglayer")
        -- 注意神器碎片在最上层
        self.contentLayout:addChild(fragmentsBaglayer, 300)
    else
        fragmentsBaglayer:updateLayer()
    end
end

function PetTreasureChallengeRecordsLayer:updateRecordsList(recordsData)

    if not self.recordsTableView then
        local tableContentLayout = UI.Layout:create()
        tableContentLayout:init()
        tableContentLayout:setSize(876, 440)
        tableContentLayout:leftBottom(26, 10)
        -- tableContentLayout:enableDebugDraw()
        self.contentLayout:addChild(tableContentLayout)

        local lineImg = UI.Image:create()
        lineImg:init("ui_pettreasure_record_mask.png")
        lineImg:leftBottom(28, 14)
        lineImg:setName("cellBg")
        self.contentLayout:addChild(lineImg, 100)

        self.recordsTableView = UI.TableView.new({}, 870, 420)
        self.recordsTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
        self.recordsTableView:centerBottom(14)
        -- self.recordsTableView:enableDebugDraw()
        self.recordsTableView:setDelegate()
        self.recordsTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
        self.recordsTableView:setBounceable(true)
        self.recordsTableView:init(0, 0, 8)
        self.recordsTableView:onUpdateCellSize(function (table,idx)
            return ITEM_WIDTH, ITEM_HEIGHT;
        end)

        self.recordsTableView:onUpdateCells(function (table, idx)
            local cell = table:dequeueCell();
            if not cell then
                xpcall(function()
                    cell = UI.TableViewCell:create()
                    cell:setContentSize(cc.size(ITEM_WIDTH, ITEM_HEIGHT))

                    self:updateRecordItem(idx + 1, recordsData[idx + 1], cell)
                end,
                function(e) 
                    printError("------------------------recordsTableView:tableCellAtIndex-----------------error")
                end, 1)
            else
                self:updateRecordItem(idx + 1, recordsData[idx + 1], cell)
            end

            return cell
        end)

        self.recordsTableView:onUpdateCellNumbers(function ()
            return #recordsData
        end)

        tableContentLayout:addChild(self.recordsTableView)
    end

    self.recordsTableView:reloadData()
end

function PetTreasureChallengeRecordsLayer:updateRecordItem(index, recordsData, cell)
    local cell = cell
    local logIndex = recordsData.index
    local data = recordsData.log
    cell.logIndex = logIndex

    local cellBg = cell:getChildByName("cellBg")
    if not cellBg then
        cellBg = UI.Image:create()
        cellBg:init("ui_pettreasure_record_banner_enemy.png")
        cellBg:centerRight(40)
        cellBg:setName("cellBg")
        cell:addChild(cellBg)
    end

    if data.red.pk ~= RoleDataManager:getMaster():getPK() then
        cellBg:setSpriteName("ui_pettreasure_record_banner_enemy.png")
    else
        cellBg:setSpriteName("ui_pettreasure_record_banner_self.png")
    end

    -- 加载头像
    self:updateHead(data, cell)

    -- 加载文本
    self:updateText(data, cell)

    -- 加载时间信息
    self:updateTimeInfo(data, cell)

    local revengedBtn = cell:getChildByName("revengedBtn")
    if not revengedBtn then
        revengedBtn = UI.Button:create()
        revengedBtn:init("ui_btn_yellow17_0.png","ui_btn_yellow17_1.png","ui_btn_yellow17_2.png")
        revengedBtn:rightBottom(39, 8)
        revengedBtn:setText(UI.TEXT_1314114)
        revengedBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        revengedBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            if data.revenged == 1 then
                return
            end

            if self.isEmbattling then
                return
            end

            self.selectIndex = cell.logIndex
            self.selectData = data
            self.isEmbattling = true

            self:startEmbattle()

        end)
        revengedBtn:setName("revengedBtn")
        cell:addChild(revengedBtn, 300)
    end

    if data.revenged == 0 and
     data.red.pk ~= RoleDataManager:getMaster():getPK() and
     data.winner == 1 and
     GameManager:getNormalServerTime() - data.gameTime < tonumber(ConfigManager:getGeneralForKey("revengeTimeLimit")) then
        revengedBtn:show()
    else
        revengedBtn:hide()
    end

    return cell
end

function PetTreasureChallengeRecordsLayer:updateTimeInfo(data, cell)
    local tmpTime = data.gameTime + GameManager:getEPOCHTime() - GameManager:get_timezone_offset()
    local date = os.date("%Y-%m-%d", tmpTime)
    local time = os.date("%X", tmpTime)

    local dateText = cell:getChildByName("dateText")
    if not dateText then
        dateText = UI.Text:create()
        dateText:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        dateText:center(326, -26)
        dateText:setName("dateText")
        cell:addChild(dateText)
    end
    dateText:setText(date)

    local timeText = cell:getChildByName("timeText")
    if not timeText then
        timeText = UI.Text:create()
        timeText:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        timeText:center(326, -6)
        timeText:setName("timeText")
        cell:addChild(timeText)
    end
    timeText:setText(time)

    if data.revenged == 0 and
     data.red.pk ~= RoleDataManager:getMaster():getPK() and
     data.winner == 1 and
     GameManager:getNormalServerTime() - data.gameTime < tonumber(ConfigManager:getGeneralForKey("revengeTimeLimit")) then
        dateText:center(326, -26)
        timeText:center(326, -6)
    else
        dateText:center(326, -12)
        timeText:center(326, 16)
    end
end

-- 此处存在服务器传回的blue被攻击者数据刚好被清理的情况，即返回的blue的pk = 0的情况，记录表现为打了宝藏守卫
function PetTreasureChallengeRecordsLayer:updateText(data, cell)
    if cell:getChildByName("richText") then
        cell:removeChildByName("richText")
    end

    local leftFighterStr = ""
    local conditionStr = ""
    local rightFighterStr = ""
    local resultStr = ""
    local fragmentStr = ""
    if data.red.pk == RoleDataManager:getMaster():getPK() then
        leftFighterStr = UI.TEXT_1170328
        if data.blue.pk ~= 0 then
            rightFighterStr = string.format(UI.TEXT_1314125, data.blue.nickName)
        else
            rightFighterStr = string.format(UI.TEXT_1314125, UI.TEXT_1314124)
        end
    else
        rightFighterStr = UI.TEXT_1170328
        leftFighterStr = string.format(UI.TEXT_1314125, data.red.nickName)
    end
    if data.winner == 1 then
        conditionStr = UI.TEXT_1314117
        if data.fragmentId == 0 then
            resultStr = UI.TEXT_1314122
        else
            if data.red.pk == RoleDataManager:getMaster():getPK() then
                resultStr = UI.TEXT_1314120
            else
                resultStr = UI.TEXT_1314119
            end

            fragmentStr = string.format(UI.TEXT_1314121, tostring(data.fragmentId))
        end
    else
        conditionStr = UI.TEXT_1314118
        resultStr = UI.TEXT_1314123
    end

    local content = AvalonUtil:serializeText(leftFighterStr, UI.FONT_COLOR_255_255_255, UI.FONT_SIZE_22PX, UI.SYS_FONT)
    content = content .. AvalonUtil:serializeText(conditionStr, UI.FONT_COLOR_255_255_255, UI.FONT_SIZE_22PX, UI.SYS_FONT)
    content = content .. AvalonUtil:serializeText(rightFighterStr, UI.FONT_COLOR_255_255_255, UI.FONT_SIZE_22PX, UI.SYS_FONT)
    content = content .. AvalonUtil:serializeText(resultStr, UI.FONT_COLOR_255_255_255, UI.FONT_SIZE_22PX, UI.SYS_FONT)
    if data.fragmentId ~= 0 and data.winner == 1 then
        content = content .. AvalonUtil:serializeImage("ui_pettreasure_fragment_"..data.fragmentId..".png")
        content = content .. AvalonUtil:serializeText(fragmentStr, UI.FONT_COLOR_255_255_255, UI.FONT_SIZE_22PX, UI.SYS_FONT)
    end

    local richText = UI.RichText:create()
    local success = richText:init(content, 550, 66, false)
    if success then
        richText:leftBottom(120, 10)
        -- richText:enableDebugDraw()
        richText:setName("richText")
        cell:addChild(richText, 100)
    end
end

function PetTreasureChallengeRecordsLayer:updateHead(data, cell)

    local iconBg = cell:getChildByName("iconBg")
    if not iconBg then
        iconBg = UI.Image:create()
        iconBg:init("ui_playerstate_me_black_up.png")
        iconBg:leftBottom(30, 10)
        iconBg:setName("iconBg")
        cell:addChild(iconBg, 100)
    end

    local iconBlack = iconBg:getChildByName("iconBlack")
    if not iconBlack then
        iconBlack = UI.Image:create()
        iconBlack:init("ui_playerstate_me_black_up.png")
        iconBlack:center()
        iconBlack:setName("iconBlack")
        iconBg:addChild(iconBlack)
    end

    Avalon.WidgetUtil:getHeadByData(self, data.red.sex, data.red.faceDecodeID, data.red.equipment or {}, self, handler(self, function(obj, pic)
        if iconBg and not tolua.isnull(iconBg) then
            iconBg:removeChildByName("heorIcon", true)
            pic:setPosition(38, 36)
            pic:setName("heorIcon")
            iconBg:addChild(pic, 10)
        end
    end))

    local iconFrame = iconBg:getChildByName("iconFrame")
    if not iconFrame then
        iconFrame = UI.Image:create()
        iconFrame:init("ui_playerstate_me_black_01.png")
        iconFrame:center()
        iconFrame:setName("iconFrame")
        iconBg:addChild(iconFrame, 100)
    end

    local lvBg = iconBg:getChildByName("lvBg")
    if not lvBg then
        lvBg = UI.Image:create()
        lvBg:init("ui_playerstate_me_grade.png")
        lvBg:leftBottom(-7, -7)
        lvBg:setName("lvBg")
        iconBg:addChild(lvBg, 200)
    end

    local lvText = lvBg:getChildByName("lvText")
    if not lvText then
        lvText = UI.Text:create()
        lvText:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
        lvText:center()
        lvText:setName("lvText")
        lvBg:addChild(lvText)
    end
    lvText:setText(data.red.roleLV)

    
end

function PetTreasureChallengeRecordsLayer:startEmbattle()
    if not self.embattleContentLayout then
        local embattleContentLayout = UI.Layout:create()
        embattleContentLayout:init()
        embattleContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
        embattleContentLayout:center()
        -- embattleContentLayout:enableDebugDraw()
        self.contentLayout:addChild(embattleContentLayout)
        self.embattleContentLayout = embattleContentLayout
    end
    self.embattleContentLayout:show()

    -- 加载底板
    local embattleBg = self.embattleContentLayout:getChildByName("embattleBg")
    if not embattleBg then
        embattleBg = UI.Image:create()
        embattleBg:init("ui_pettreasure_bg.png")
        embattleBg:leftUp(28, 16)
        embattleBg:setName("posImg")
        self.embattleContentLayout:addChild(embattleBg, 100)
    end

    -- 加载按钮
    self:updateBtn()

    -- 加载右侧布阵情况
    self:updateEmbattle()

    -- 加载左侧背包
    self:showPetTreasurePacket()
end

function PetTreasureChallengeRecordsLayer:backFromEmbattle()
    if self.isEmbattling then
        local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
        embattleLayer:hide()
        local packetLayer = self.contentLayout:getChildByName("packetLayer")
        packetLayer:hide()
        self.embattleContentLayout:hide()
        self.selectIndex = 0
        self.selectData = nil
        self.isEmbattling = false
    end
end

function PetTreasureChallengeRecordsLayer:updateBtn()
    local backBtn = self.embattleContentLayout:getChildByName("backBtn")
    if not backBtn then
        backBtn = UI.Button:create()
        backBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_0.png")
        backBtn:rightBottom(260, 40)
        backBtn:setText(UI.TEXT_1212272)
        backBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        backBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            self:backFromEmbattle()

        end)
        backBtn:setName("backBtn")
        self.embattleContentLayout:addChild(backBtn, 200)
    end

    local battleBtn = self.embattleContentLayout:getChildByName("battleBtn")
    if not battleBtn then
        battleBtn = UI.Button:create()
        battleBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_0.png")
        battleBtn:rightBottom(50, 40)
        battleBtn:setText(UI.TEXT_1212081)
        battleBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        battleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            if not self.isEmbattling then
                return
            end

            if mvc.petTreasureModel:getcurEmbattlePetsNum() < 3 then
                UI.ScrollBar:createByText(UI.TEXT_1314128)
                return
            end

            if GameManager:getNormalServerTime() - self.selectData.gameTime > tonumber(ConfigManager:getGeneralForKey("revengeTimeLimit")) then
                UI.ScrollBar:createByText(UI.TEXT_1314136)
                mvc.send("PetTreasure_Update_Layer")
                self:backFromEmbattle()
                return
            end

            UI.WaitingLayer:showWaiting(true, nil, 5)
            mvc.send("PetTreasure_Send_Battle_Revenge_Pets", self.selectIndex)
        end)
        battleBtn:setName("battleBtn")
        self.embattleContentLayout:addChild(battleBtn, 200)
    end

end

function PetTreasureChallengeRecordsLayer:updateEmbattle()
    local enemyData = {}

    mvc.petTreasureModel:setcurEmbattlePetsData(clone(mvc.petTreasureModel:getBattlePets()))
    local selfData = mvc.petTreasureModel:getcurEmbattlePetsData()

    local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
    if not embattleLayer then
        embattleLayer = PetTreasureEmbattleLayer:create()
        embattleLayer:init(enemyData, selfData, "PetTreasureChallengeRecordsLayer")
        embattleLayer:rightBottom(30, 120)
        -- embattleLayer:enableDebugDraw()
        embattleLayer:setName("embattleLayer")
        self.contentLayout:addChild(embattleLayer, 200)
    else
        embattleLayer:show()
        embattleLayer:updateLayer(enemyData, selfData)
    end
end

function PetTreasureChallengeRecordsLayer:showPetTreasurePacket()
    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        packetLayer:show()
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureChallengeRecordsLayer")
        packetLayer:updateByData(petArr)
    else
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureChallengeRecordsLayer")
        local packetLayer = PetPacketLayer:create()
        packetLayer:init(petArr, "PetTreasureChallengeRecordsLayer")
        packetLayer:leftUp(35, 43.5)
        packetLayer:setName("packetLayer")
        self.contentLayout:addChild(packetLayer, 400)
    end
end

function PetTreasureChallengeRecordsLayer:slotDragEnd(petData, touchPosition)
    if mvc.petTreasureModel:getcurEmbattlePetsNum() >= 3 then
        UI.ScrollBar:createByText(UI.TEXT_1314132)
        return
    end

    local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
    if embattleLayer then
        embattleLayer:slotDragEnd(petData, touchPosition)
    end

    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureChallengeRecordsLayer")
        packetLayer:updateByData(petArr)
    end
end

function PetTreasureChallengeRecordsLayer:bindModel()

end

function PetTreasureChallengeRecordsLayer:unbindModel()

end

return PetTreasureChallengeRecordsLayer