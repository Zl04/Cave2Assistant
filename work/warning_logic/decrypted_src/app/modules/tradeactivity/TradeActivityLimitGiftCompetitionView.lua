------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
require "app.datas.GoalDataManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")
local TradeActivityLimitGiftCompetitionView = class("TradeActivityLimitGiftCompetitionView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 681
local COM_HEIGHT = 470

local CELL_WIDTH = 668
local CELL_HEIGHT = 126

local INNER_IMG_LIST = {
    [PublicDefine.TradeActivityIDList.TradeActivityLimitGiftCompetition] = "ui_businessactivities_illustration_05.png",
    -- [PublicDefine.TradeActivityIDList.TradeActivityPetGiftCompetition] = "ui_businessactivities_illustration_05.png",
    -- [PublicDefine.TradeActivityIDList.TradeActivityfashionGiftCompetition] = "ui_businessactivities_illustration_05.png",
    -- [PublicDefine.TradeActivityIDList.TradeActivityachieveGiftCompetition] = "ui_businessactivities_illustration_05.png",
}

local PROMPT_DES_LIST = {
    [PublicDefine.TradeActivityIDList.TradeActivityLimitGiftCompetition] = UI.TEXT_1324529,
    -- [PublicDefine.TradeActivityIDList.TradeActivityPetGiftCompetition] = UI.TEXT_1324531,
    -- [PublicDefine.TradeActivityIDList.TradeActivityfashionGiftCompetition] = UI.TEXT_1324532,
    -- [PublicDefine.TradeActivityIDList.TradeActivityachieveGiftCompetition] = UI.TEXT_1324533,
}

function TradeActivityLimitGiftCompetitionView:ctor()
    TradeActivityLimitGiftCompetitionView.super.ctor(
    	self,
    	UI.Type.TRADE_ACTIVITY_LIMIT_COMPETITION,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.getItemIndex = nil
    self:bindModel()
end

function TradeActivityLimitGiftCompetitionView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityLimitGiftCompetitionView.super.init(self, ... )
end

function TradeActivityLimitGiftCompetitionView:dtor()
    TradeActivityLimitGiftCompetitionView.super.dtor(self)
    self.getItemIndex = nil
    self:unbindModel()
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityLimitGiftCompetitionView")
end

function TradeActivityLimitGiftCompetitionView:bindModel()
    mvc.tradeActivityModel:bind("_targetList", self, self.updateCell)
end


function TradeActivityLimitGiftCompetitionView:unbindModel()
    mvc.tradeActivityModel:unbind("_targetList", self, self.updateCell)
end


function TradeActivityLimitGiftCompetitionView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 右侧底图
    local innerBg = UI.Image:create()
    innerBg:init("ui_businessactivities_bg_02.png")
    innerBg:center()
    contentLayout:addChild(innerBg)

    -- 内部背景图片
    local topImg  = UI.Image:create()
    topImg:init(INNER_IMG_LIST[mvc.tradeActivityModel:getCurActivityID()])
    topImg:centerUp(6)
    self:addChild(topImg)

    local configData = ConfigManager:getTradeActivityDataByID(mvc.tradeActivityModel:getCurActivityID())

    -- 描述
    local desc = UI.Text:create()
    desc:init(configData.name, UI.FONT_BOLD, UI.FONT_SIZE_36PX, UI.FONT_COLOR_245_190_0)
    desc:setTextLeft()
    -- desc:enableDebugDraw()
    desc:leftUp(20, 36)
    topImg:addChild(desc)

    local prompt = UI.Text:create()
    prompt:init(PROMPT_DES_LIST[mvc.tradeActivityModel:getCurActivityID()], UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
    prompt:setSize(310, 44)
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        prompt:setFontSize(UI.FONT_SIZE_14PX)
        prompt:setLineSpacing(-5)
    end
    prompt:setTextLeftBottom()
    prompt:leftUp(10, 102)
    -- prompt:enableDebugDraw()
    topImg:addChild(prompt)

    local updatePrompt = UI.Text:create()
    updatePrompt:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_225_225_225)
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        updatePrompt:setFontSize(UI.FONT_SIZE_14PX)
        updatePrompt:setLineSpacing(-5)
    end
    updatePrompt:setTextCenter()
    -- updatePrompt:enableDebugDraw()
    updatePrompt:rightUp(10, 124)
    topImg:addChild(updatePrompt)
    self.updatePrompt = updatePrompt

    self:updateActivityTime()

    -- 领取框
    local awardLayout = UI.Layout:create()
    awardLayout:init()
    awardLayout:setSize(670, 300)
    awardLayout:centerBottom(10)
    -- awardLayout:enableDebugDraw()
    self.contentLayout:addChild(awardLayout)
    self.awardLayout = awardLayout

    self:createAwardsList()
end

function TradeActivityLimitGiftCompetitionView:updateActivityTime()
    local timeStr = mvc.tradeActivityModel:getActivityOpeningStrByID(mvc.tradeActivityModel:getCurActivityID())
    if timeStr then
        self.updatePrompt:setText(timeStr)
    end
end

function TradeActivityLimitGiftCompetitionView:createAwardsList()

    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    if not groupInfo or table.nums(groupInfo) <= 0 then
        return
    end

    self._tableView = UI.TableView.new({}, CELL_WIDTH + 14, 300)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:center(4, 0)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT
    end)

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createAwardCell(index)
            end,
            function(e)
                printError("------------------------TradeActivityMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createAwardCell(index)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return #groupInfo
    end)

    self.awardLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end

function TradeActivityLimitGiftCompetitionView:createAwardCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())

    local lineImg = UI.Image.create()
    lineImg:init("ui_businessactivities_line_01.png")
    lineImg:centerUp(6)
    cell:addChild(lineImg)

    local image = UI.Image.create()
    image:init("ui_businessactivities_up_03.png")
    image:centerUp(18)
    cell:addChild(image)

    local descLayout = UI.Layout:create()
    descLayout:init()
    descLayout:enableAutoWidth()
    descLayout:enableAutoHeight()
    descLayout:centerLeft(8)
    image:addChild(descLayout)

    local element = UI.Text:create()
    element:init(string.format(LanguageManager:getInstance():getLocalString(groupInfo[index].desc), groupInfo[index].target), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    element:floatLeft(0)
    descLayout:addComponent(element)

    local color = groupInfo[index].count >= groupInfo[index].target and UI.FONT_COLOR_69_227_154 or UI.FONT_COLOR_80_5_5
    local str = groupInfo[index].count >= groupInfo[index].target and UI.TEXT_111021 or groupInfo[index].count.. "/" ..groupInfo[index].target
    local curTarget = UI.Text:create()
    curTarget:init("("..str..")", UI.FONT_BOLD, UI.FONT_SIZE_16PX, color)
    curTarget:floatLeft(6)
    descLayout:addComponent(curTarget)

    if groupInfo[index].rewardid and table.nums(groupInfo[index].rewardid) > 0 then
        local rewardid = groupInfo[index].rewardid
        local rewardnum = groupInfo[index].rewardnum

        local rewardLayout = UI.Layout:create()
        rewardLayout:init()
        rewardLayout:enableAutoWidth()
        rewardLayout:enableAutoHeight()
        -- rewardLayout:enableDebugDraw()
        rewardLayout:leftBottom(26, 2)
        cell:addChild(rewardLayout)

        for awardIndex = 1, #rewardid do
            local goodData = GoodsDataManager:createLocalGoodsData(tonumber(rewardid[awardIndex]))
            if goodData then
                goodData:setNum(tonumber(rewardnum[awardIndex]))
                goodData:setIsNew(false)
                goodData.isHaveGet = false

                local rewardGrid = UI.GoodsGrid:create()
                rewardGrid:init(goodData)
                rewardGrid:hideNewIcon()
                -- rewardGrid:hideBG()
                rewardGrid:hideRare()
                rewardGrid:center()
                rewardGrid:setTouchEnable(true)
                rewardGrid:setSwallowTouches(false)
                rewardGrid:setTouchClipNode(cell)
                rewardGrid:showInfoArea(true, false)

                if awardIndex == 1 then
                    rewardGrid:floatLeft(0)
                else
                    rewardGrid:floatLeft(12)
                end
                rewardLayout:addComponent(rewardGrid)

            end
        end
    end

    local getBtn = UI.Button:create()
    getBtn:init('ui_businessactivities_btn_05.png', 'ui_businessactivities_btn_05.png', 'ui_businessactivities_btn_gray_05.png')
    getBtn:rightBottom(20, 8)
    getBtn:closeClickScale()
    getBtn:setText(UI.TEXT_111035)
    getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    getBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:getAwards(index)
    end)
    getBtn:setName("getBtn")
    cell:addChild(getBtn)

    local gotImg = UI.Image.create()
    gotImg:init("ui_information_banner_receive.png")
    gotImg:rightBottom(24, 8)
    gotImg:setName("gotImg")
    gotImg:hide()
    cell:addChild(gotImg)

    local gotText = UI.Text:create()
    gotText:init(UI.TEXT_1110721, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
    gotText:center()
    gotText:setRotation(-9)
    gotText:setName("gotText")
    gotText:hide()
    gotImg:addChild(gotText)

    self:updateAwardCellBtn(cell, index)

    return cell
end

function TradeActivityLimitGiftCompetitionView:updateAwardCellBtn(cell, index)
    local getBtn = cell:getChildByName("getBtn")
    if not getBtn or tolua.isnull(getBtn) then
        return
    end

    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    local targetInfo = groupInfo[index]

    getBtn:show()
    -- 已领奖
    if targetInfo.stat == 3 then
        getBtn:hide()
        local gotImg = cell:getChildByName("gotImg")
        if getBtn and not tolua.isnull(gotImg) then
            gotImg:show()
        end
        local gotText = gotImg:getChildByName("gotText")
        if gotText and not tolua.isnull(gotText) then
            gotText:show()
        end
    elseif targetInfo.stat == 2 then
        getBtn:enable()
        getBtn:setText(UI.TEXT_111035)
    else
        getBtn:disable()
        getBtn:setText(UI.TEXT_1324508)
    end
end

function TradeActivityLimitGiftCompetitionView:updateCell(data)
    self._tableView:reloadData(true)

    if not self.getItemIndex then
        return
    end

    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    local targetInfo = groupInfo[self.getItemIndex]
    if targetInfo.stat == 3 then
        self:showGetAwards()
    end
end

function TradeActivityLimitGiftCompetitionView:showGetAwards()
    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    local targetInfo = groupInfo[self.getItemIndex]

    -- 重置
    self.getItemIndex = nil

    local rewardid = targetInfo.rewardid
    local rewardnum = targetInfo.rewardnum
    local awardsList = {}
    for index = 1, #rewardid do
        local awarObj = GoodsDataManager:createLocalGoodsData(rewardid[index])
        awarObj:setNum(rewardnum[index])
        if rewardnum[index] > 0 then
            table.insert(awardsList, awarObj)
        end
    end
    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
    end
end

function TradeActivityLimitGiftCompetitionView:getAwards(index)
    local SceneManager = require("app.game.SceneManager")
    if not (SceneManager:getInstance():isNotInFightScene()) then
        UI.ScrollBar:createByText(UI.TEXT_1213665)
        return
    end

    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    if not groupInfo or table.nums(groupInfo) <= 0 then
        return
    end

    local targetInfo = groupInfo[index]
    if not targetInfo.rewardid or table.nums(targetInfo.rewardid) <= 0 then
        return
    end

    local rewardid = targetInfo.rewardid
    local rewardnum = targetInfo.rewardnum
    local goodsArr = {}
    for awardIndex = 1, #rewardid do
        local data = {}
        data.goodsID = rewardid[awardIndex]
        data.num = rewardnum[awardIndex]
        data.isGolden = false
        table.insert(goodsArr, data)
    end

    -- 判断背包是否满了
    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) then
        UI.ScrollBar:createByText(UI.TEXT_1212011)
        return
    end

    UI.WaitingLayer:showWaiting(true, nil, 5)

    -- 发送领奖时记录一下index方便展示领取奖励框
    self.getItemIndex = index
    Net.NetRoleSystem:sendActivityTargetGetAwards(targetInfo.sudId, targetInfo.groupId)
end


return TradeActivityLimitGiftCompetitionView












