------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2021/08/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
local FestivalSignView = class("FestivalSignView", UI.HWBtnComponent)

local SdkManager = require "app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")
local SceneManager = require("app.game.SceneManager")


require "app.modules.festivalsign.FestivalSignTabCell"
require "app.modules.festivalsign.FestivalSignCell"
require "app.modules.festivalsign.FestivalSignOpenCell"
require "app.modules.festivalsign.FestivalSignCloseCell"

-- 资源
local COM_RES_LIST = {
    "ui_town_sevendays.plist",
    "ui_package_log_funnyRecord.plist",
    -- "ui_town_catfood.plist",
    "ui_general_shopping.plist",
    "ui_town_guild_giftbox.plist",

    "ui_welfare_festival_sign.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 1000
local COM_HEIGHT = 600
local ZOrder = 1
local BTN_CELL_W = 109
local BTN_CELL_H = 68
local SIGN_CELL_W = 196

function FestivalSignView:ctor(types)
    self._planType = types.planType or nil
    self._signInType = types.signInType
    FestivalSignView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.btnCellArr = {}
    self:bindModel()
end

function FestivalSignView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.festivalsign", "FestivalSign", false)
    FestivalSignView.super.init(self, ... )
end

function FestivalSignView:dtor()
    FestivalSignView.super.dtor(self)
    self.btnCellArr = {}
    self:unbindModel()
    -- reload_script_file_mvc("app.modules.festivalsign.FestivalSignView")
end


function FestivalSignView:onInitView()
    self.curTabIndex = -1
    self.lastTabIndex = 0

    self:formatData()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    -- 背景图片
    local bg  = UI.Image:create();
    if self._signInType == ANNIVERSARY_SIGN then
        bg:init("ui_welfare_bg_11.png");
        bg:centerLeft(-58);
    else
        bg:init("ui_welfare_bg_01.png");
        bg:centerLeft(-43);
    end
    
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;
    self._bg = bg

    if self._signInType ~= ANNIVERSARY_SIGN then
        -- titleImg
        local titleImg  = UI.Image:create();
        titleImg:init("ui_welfare_title.png");
        titleImg:leftUp(246, 0)
        bg:addChild(titleImg, 10);
    end
    -- titleTxt
    local titleTxt = UI.Text:create()
    if self._signInType ~= ANNIVERSARY_SIGN then 
        titleTxt:init(UI.TEXT_1213125, UI.FONT_BOLD, UI.FONT_SIZE_32PX, UI.FONT_COLOR_255_201_192)
        titleTxt:centerUp(15)
    else
        titleTxt:init(UI.TEXT_221200, UI.FONT_BOLD, UI.FONT_SIZE_32PX, UI.FONT_COLOR_255_201_192)
        titleTxt:leftUp(500, 20)
    end
    titleTxt:useDefaultShadowOnlyStype(UI.FONT_COLOR_86_21_24)
    bg:addChild(titleTxt, 100)
    self.titleTxt = titleTxt

    -- actTime
    local actTime = UI.Text:create()
    actTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    actTime:centerUp(80)
    bg:addChild(actTime)
    self.actTime = actTime
    

    self:initData()
    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end

        self:initSignPanel()
    end, 0.2)
    
    
    -- if self._signInType ~= ANNIVERSARY_SIGN then
    --     self:makeTabList()
    -- end
    self:makeTabList()
    self:addUIEff()
    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end
        print("self._planType", self._planType)
        if self._planType then
            self:initTaskPanel()
        end
        self:updateMainPanel()
    end, 0.5)

    self:refreshTitle()
end

function FestivalSignView:initData()
    -- self.sevenGiftBag = clone(mvc.festivalSignModel:getSevenGiftBag())
    -- -- print("SevenDaysView:initData", #self.sevenGiftBag)
    -- for k,v in ipairs(self.sevenGiftBag) do 
    --     v.allDone = true
    --     v.disableMerge = true
    -- end

    -- self:handleLanguage()
end

function FestivalSignView:initSignList()
    -- local scrollContent = UI.Layout:create()
    -- scrollContent:init()
    -- scrollContent:setSize(547, 446)

    -- scrollContent:leftBottom(297, 56)
    -- self.signLayout:addChild(scrollContent)
    if self._signInType ~= ANNIVERSARY_SIGN then 
        local bg = UI.Image9:create()
        bg:init("ui_welfare_bg_02.png",CCRectMake(1,1,1,1), cc.size(564, 453))
        bg:leftUp(280, 10)
        self.signLayout:addChild(bg)
    end
    self.canGetSignFinalReward = mvc.festivalSignModel:checkCanGetFinalReward(self._signInType)

    -- local beginOffset = math.floor(SIGN_CELL_W/2)

    local scrollContent = UI.Layout:create()
    scrollContent:init()
    
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(550, 480)
    scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
    scrollView:init(0, 0, 0, 0)
    if self._signInType == ANNIVERSARY_SIGN then
        scrollView:leftUp(318, -25)
    else
        scrollView:leftUp(287, 0)
    end
    
    scrollView:setScrollBarEnabled(false)
    scrollView:setCircleVisible(false)
    scrollView:setName("signSV")
    self.signSV = scrollView
    scrollView:addInnerNode(scrollContent)
    self.signLayout:addChild(scrollView)
    scrollView:scrollToLeft()

    local totalW = 0
    local cellW1 = 540
    local cellW2 = 160
    local bottomOffset = 240
    local beginOffset = 80



    if (self.signData.stageArr) then
        -- local startX = 0
        -- local onePaddingX = 136
        -- local onePaddingY = 229

        -- -- ui_sevendays_paper_sign_bg 添加背景
        -- local black = UI.Image:create()
        -- black:init("ui_sevendays_paper_sign_bg.png")
        -- black:centerUp(0)
        -- scrollContent:addChild(black)

        -- local black = UI.Image:create()
        -- black:init("ui_sevendays_paper_sign_bg.png")
        -- black:centerBottom(0)
        -- scrollContent:addChild(black)
    

        for k, v in ipairs(self.signData.stageArr) do
            local cell = UI.FestivalSignCell:create(self._signInType)
            cell:init(v)
            cell:leftBottom(beginOffset, bottomOffset)
            scrollContent:addChild(cell)
            beginOffset = beginOffset+cellW2
            totalW = totalW+cellW2

            -- local cell = UI.SevenDaysSignCell:create(self._signInType)
            -- cell:init(v)
            -- if(k<=4) then
            --     cell:leftUp(startX + (k-1)*onePaddingX, 0)
            -- else
            --     startX = onePaddingX/2
            --     cell:leftBottom(startX + (k-5)*onePaddingX, 0)
            -- end

            -- scrollContent:addChild(cell)
        end
        local width = totalW + 9
        if (width < 0) then
            width = 0
        end
        scrollContent:setSize(width, 450)
    end
end

function FestivalSignView:initTaskList()
    local bg = UI.Image9:create()
    bg:init("ui_welfare_bg_02.png",CCRectMake(1,1,1,1), cc.size(818, 475))
    bg:leftUp(28, -9)
    self.taskLayout:addChild(bg)
    
    local scrollContent = UI.Layout:create()
    scrollContent:init()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(800, 448)
    scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:leftUp(36, 0)
    scrollView:setScrollBarEnabled(false)
    scrollView:setCircleVisible(false)
    scrollView:setName("taskSV")
    self.taskSV = scrollView
    
    scrollView:addInnerNode(scrollContent)
    self.taskLayout:addChild(scrollView)
    scrollView:scrollToLeft()

    -- self.canGetTaskFinalReward = mvc.festivalSignModel:checkCanGetFinalReward(self._planType)

    local totalW = 0
    local cellW1 = 540
    local cellW2 = 196
    local bottomOffset = 230
    local beginOffset = 5
    for k, v in ipairs(self.openTasks) do
        -- reload_script_file("app.modules.sevendays.SevenDaysOpenCell")
        local cell = UI.FestivalSignOpenCell:create(self._planType)
        cell:init(v)
        cell:leftBottom(beginOffset + cellW1/2, bottomOffset)
        scrollContent:addChild(cell)
        beginOffset = beginOffset+cellW1
        totalW = totalW+cellW1
    end

    beginOffset = beginOffset + cellW2/2
    for k, v in ipairs(self.lockedTasks) do
        -- reload_script_file("app.modules.sevendays.SevenDaysCloseCell") 
        local cell = UI.FestivalSignCloseCell:create(self._planType)
        cell:init(v)
        cell:leftBottom(beginOffset, bottomOffset)
        scrollContent:addChild(cell)
        beginOffset = beginOffset+cellW2
        totalW = totalW+cellW2
    end
    local width = totalW + 10
    if (width < 0) then
        width = 0
    end
    scrollContent:setSize(width, 450)
end

function FestivalSignView:initSignPanel()
   
    -- 签到
    local signLayout = UI.Layout:create();
    signLayout:init()
    signLayout:setSize(828, 504)
    signLayout:leftBottom(120, 10)
    self._bg:addChild(signLayout)
    self.signLayout = signLayout

    if self._signInType ~= ANNIVERSARY_SIGN then
        local rewardLayout = UI.Layout:create();
        rewardLayout:init()
        rewardLayout:setSize(283, 481)
        rewardLayout:leftBottom(-5, 57)
        self.signLayout:addChild(rewardLayout, 100)

        local rewardBg = UI.Image:create()
        rewardBg:init("ui_welfare_bg_04.png")
        rewardBg:center()
        -- rewardBg:centerLeft(20, 0)
        rewardLayout:addChild(rewardBg)

        local titleText = UI.Text:create()
        titleText:init(UI.TEXT_1213123, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
        titleText:setWidth(281)
        titleText:setTextCenter()
        titleText:centerUp(53)
        -- titleText:centerLeft(65, -90)
        -- titleText:leftUp(-80, 60)
        rewardLayout:addChild(titleText, 100)

        local descText = UI.Text:create()
        descText:init(UI.TEXT_1213122, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_183_43)
        descText:setWidth(281)
        descText:setTextCenter()
        descText:centerUp(58 +titleText:getContentSize().height)
        -- descText:centerLeft(100, -(48 + titleText:getContentSize().height))
        -- descText:leftUp(-60, (60+titleText:getContentSize().height))
        rewardLayout:addChild(descText, 100)

    
        -- 角色 
        local heroData = RoleDataManager:getMaster()
        local roleAnimation = UI.RoleAnimation:create()
        roleAnimation:init(heroData)
        roleAnimation:centerLeft(90, 35)
        roleAnimation:setScaleX(-1 * roleAnimation:getScaleX())
        rewardLayout:addChild(roleAnimation)
        self.roleAnimation = roleAnimation

        local equipmentDataArr = {}
        for k, v in ipairs(self.signData.showEquip) do
            local equipmentData = GoodsDataManager:createEquipmentForEquipmentID(v.id)
            if(equipmentData) then
                table.insert(equipmentDataArr, equipmentData)
            end
        end
        self.equipmentDataArr = equipmentDataArr
        roleAnimation:updateRoleEquipment(equipmentDataArr)
        self:createSignChoiceEquipType(rewardLayout)

        local roleClickLayout = UI.Layout:create()
        roleClickLayout:init()
        roleClickLayout:setSize(300,460)
        -- roleClickLayout:enableDebugDraw()
        roleClickLayout:centerBottom(25)
        roleClickLayout:setTouchEnable(true)
        roleClickLayout:addEventListener(UIEvent.COMPONENT_CLICK, self.roleAnimation, function()

            if(self.roleAnimation:getRoleRender() and self.roleAnimation:getRoleRender():getHeroAnimation()) then
                self.roleAnimation:getRoleRender():getHeroAnimation():setAnimation(
                    0,
                    "attack_1_" .. self.roleAnimation._currentWeaponType,
                    false
                )
                self.roleAnimation:getRoleRender():getHeroAnimation():addAnimation(
                    0,
                    "attackidle_" .. self.roleAnimation._currentWeaponType,
                    true
                )
            end
        end)
        rewardLayout:addChild(roleClickLayout)
    


        local confirmBtn = UI.Button:create()
        confirmBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png")
        -- confirmBtn:centerBottom(47)
        confirmBtn:centerLeft(70, 90)
        confirmBtn:setText(UI.TEXT_111035)
        confirmBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        confirmBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if self.isGetSignFinalReward then
                -- 正在领奖
                return
            end
            if self.signData.finalRewardState then
                -- 已经领过奖
                return
            end
            if not self.canGetSignFinalReward then
                -- UI.ScrollBar:createByText(UI.TEXT_1213102)
                UI.ScrollBar:createByText(UI.TEXT_1213123)
                return
            end

            self:getSignFinalReward()
        end)
        confirmBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            if self.signData.finalRewardState then
                -- 已经领过奖
                UI.ScrollBar:createByText(UI.TEXT_1110721)
                return
            end
            UI.ScrollBar:createByText(UI.TEXT_1213123)
        end)
        rewardLayout:addChild(confirmBtn)
        self.signConfirmBtn = confirmBtn
    end

    self:initSignList()
    self:updateSignTotalReward()
end

function FestivalSignView:initTaskPanel()
    -- 计划
    local taskLayout = UI.Layout:create();
    taskLayout:init()
    taskLayout:setSize(828, 504)
    taskLayout:leftBottom(120, 10)
    self._bg:addChild(taskLayout)
    self.taskLayout = taskLayout

    self:initTaskList()
    self:updateTotalRewardPrg()
end

function FestivalSignView:updateSignTotalReward()
    if(self.signConfirmBtn) then
        local confirmBtn = self.signConfirmBtn
        if self.isGetSignFinalReward then
            confirmBtn:disable()
            return
        end
        if self.signData.finalRewardState then
            confirmBtn:disable()
            return
        end
        if not self.canGetSignFinalReward then
            confirmBtn:disable()
            return
        end
        confirmBtn:enable()
    end
end

function FestivalSignView:updateTotalRewardPrg()
    if(self.rewardBtn) then
        local confirmBtn = self.rewardBtn
        if self.taskData.finalRewardState then
            confirmBtn:setText(UI.TEXT_1110721)
            confirmBtn:disable()
        elseif self.canGetTaskFinalReward then
            confirmBtn:enable()
        else
            confirmBtn:setText(UI.TEXT_111035)
            confirmBtn:disable()
        end
    end
end

function FestivalSignView:makeTabList()
    -- 如果是web配置就不显示标签, 并且只显示计划
    self.btnData = {}
    if (not mvc.festivalSignModel:isGoalFromWeb(self._planType)) then
        -- 显示签到
        local tab1 = {}
        tab1.goalIdx = self._signInType
        tab1.name = UI.TEXT_1213105
        tab1.select = true
        tab1.isSignInGoal = true

        -- 显示计划
        local tab2 = {}
        tab2.goalIdx = self._planType
        tab2.name = UI.TEXT_1213106
        tab2.select = false
        tab2.isSignInGoal = false

        table.insert(self.btnData, tab1)
        if self._planType then
            table.insert(self.btnData, tab2)
        end
        
    else
        -- 初始化到计划
        self.curTabIndex = 1
    end

    self._tableView = UI.TableView.new({}, BTN_CELL_W+10, 230);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-73, 60)
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.FestivalSignTabCell.new();
            cell:init(self.btnData[idx+1]);
            cell:setVisible(self._signInType ~= ANNIVERSARY_SIGN)
        end,
        function(e) 
            printError("------------------------FestivalSignView:tableCellAtIndex-----------------error")
        end, 1);
        self.btnCellArr[idx + 1] = cell
        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end);

    self._tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        -- 处理self.curTabIndex < 0
        if self.curTabIndex < 0 then
            self.curTabIndex = 0
        end

        if self.curTabIndex == cell:getIdx() then
            return
        end

        self.curTabIndex = cell:getIdx()
        self.btnData[self.curTabIndex+1].select = true
        self._tableView:updateCellAtIndex(self.curTabIndex)

        if self.lastTabIndex >= 0 then
            self.btnData[self.lastTabIndex+1].select = false
            self._tableView:updateCellAtIndex(self.lastTabIndex)
        end

        self.lastTabIndex = self.curTabIndex

        self:updateMainPanel()
        self:refreshTitle()
        if not tolua.isnull(self._detailView) then
            self._detailView:removeSelf()
        end
    end);

    if(GameManager:getIsGooglePlay()) then
        self._tableView:onTableCellHighLight(function(table, cell)
            -- print("onTableCellHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx() + 1
            if(not tolua.isnull(self.btnCellArr[endIndex])) then 
                self.btnCellArr[endIndex]:hightLight()

                Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                    if(not tolua.isnull(self)) then
                        if(self.btnCellArr[endIndex]) then 
                            self.btnCellArr[endIndex]:unHightLight()
                        end
                    end
                end, 1)
            end
        end)

        self._tableView:onTableCellUnHighLight(function(table, cell)
            -- print("onTableCellUnHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx() + 1
            if(not tolua.isnull(self.btnCellArr[endIndex])) then 
                self.btnCellArr[endIndex]:unHightLight()
            end
        end)
    end

    self.contentLayout:addChild(self._tableView, ZOrder);
    ZOrder = ZOrder + 1
    self._tableView:reloadData(true);
end

function FestivalSignView:updateMainPanel()
    if self.curTabIndex <= 0 then
        self:updateSignPanel()
        -- Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SevenDays, 1, nil, nil)
        
        local startTime, endTime = mvc.festivalSignModel:getActDuringTime(self._signInType)
        local showTime = string.format(UI.TEXT_1213099 .. " " .. startTime .. " - " .. endTime)
        self.actTime:setText(showTime)
    elseif self.curTabIndex == 1 then
        -- Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SevenDays, 2, nil, nil)
        self:updateTaskPanel()
        local startTime, endTime = mvc.festivalSignModel:getActDuringTime(self._planType)
        local showTime = string.format(UI.TEXT_1213099 .. " " .. startTime .. " - " .. endTime)
        self.actTime:setText(showTime)
    end
end

function FestivalSignView:outLayoutAll()
    if self.taskLayout then
        self.taskLayout:leftBottom(120, 1000)
    end
    if self.signLayout then
        self.signLayout:leftBottom(120, 1000)
    end
    if self.giftLayout then
        self.giftLayout:leftBottom(120, 1000)
    end
end

function FestivalSignView:updateSignPanel()
    self:outLayoutAll()
    if self.signLayout then
        self.signLayout:leftBottom(120, 10)
    end
end

function FestivalSignView:updateTaskPanel()
    self:outLayoutAll()
    if self.taskLayout then
        self.taskLayout:leftBottom(120, 10)
    end
end

-- function FestivalSignView:updateGiftPanel()
--     self:outLayoutAll()

--     if(self.giftLayout == nil) then 
--         self:initGiftBagPanel()
--     end
--     if self.giftLayout then
--         self.giftLayout:leftBottom(120, 10)
--     end
-- end

function FestivalSignView:refreshTitle()
    local goal = mvc.festivalSignModel:getGoalData(self._planType)
    if (goal and goal.isFromWeb and goal.goalNameOverride) then
        self.titleTxt:setFontName(UI.SYS_FONT)
        self.titleTxt:setFontSize(UI.FONT_SIZE_26PX)
        -- self.titleTxt:setFontColor(UI.FONT_COLOR_155_155_155)
        self.titleTxt:setText(goal.goalNameOverride)
    else
        self.titleTxt:setFontName(UI.FONT_STANDARD)
        self.titleTxt:setFontSize(UI.FONT_SIZE_26PX)
        -- self.titleTxt:setFontColor(UI.FONT_COLOR_155_155_155)

        -- local btnData = self.btnData[self.curTabIndex+1]
        -- local str = UI.TEXT_1213109

        -- self.titleTxt:setText(str)
    end
end

function FestivalSignView:formatData()
    mvc.festivalSignModel:recalculateStageForGoal(self._signInType)

    self.stageArr = mvc.festivalSignModel:getStageArr(self._planType)
    self.taskData = mvc.festivalSignModel:getGoalData(self._planType)
    self.signData = mvc.festivalSignModel:getGoalData(self._signInType)
    -- dump(self.stageArr, "self.stageArr", 5)
    -- dump(self.taskData, "self.taskData", 5)
    -- dump(self.signData, "self.signData", 5)

    self.openTasks = {}
    self.lockedTasks = {}
    for k, v in ipairs(self.stageArr) do
        if v.isLocked then
            table.insert(self.lockedTasks, v)
        else
            table.insert(self.openTasks, v)
        end
    end
end

function FestivalSignView:createSignChoiceEquipType(rewardLayout)
    self.equipTypeNodeArr = {}
    local node = self:createSigneEquipOne(PublicDefine.WEAPON_TYPE.SWORD_SHIELD)
    rewardLayout:addChild(node)
    node:leftBottom(64, -29)
    table.insert(self.equipTypeNodeArr, node)

    local node = self:createSigneEquipOne(PublicDefine.WEAPON_TYPE.GREAT_SWORD)
    rewardLayout:addChild(node)
    node:leftBottom(120, -29)
    table.insert(self.equipTypeNodeArr, node)

    local node = self:createSigneEquipOne(PublicDefine.WEAPON_TYPE.MAGIC_STAFF)
    rewardLayout:addChild(node)
    node:rightBottom(64, -29)
    table.insert(self.equipTypeNodeArr, node)

    -- 默认选中一个
    self:choiceEquipType(PublicDefine.WEAPON_TYPE.SWORD_SHIELD)
end

function FestivalSignView:createSigneEquipOne(equipType)
    local node = UI.Image:create()
    node:init("ui_sevendays_sign_weapon_0.png")
    node.equipType = equipType
    node:setTouchEnable(true)

    -- 中间表现
    local centerBg = UI.Image:create()
    centerBg:init("ui_sevendays_sign_weapon_1.png")
    centerBg:hide()
    centerBg:setName("weaponChoice")
    centerBg:centerBottom(0)
    node:addChild(centerBg)

    local icon = UI.Image:create()
    icon:init(string.format("icon-equip_small1_21080010_%d.png", equipType))
    icon:show()
    icon:setName("weaponIcon")
    icon:center()
    node:addChild(icon)
    if(GameManager:getIsGooglePlay()) then
        node:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, node, function()
            self:handleHightLight(node.equipType, true)
            Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                if(not tolua.isnull(self)) then
                    self:handleHightLight(node.equipType, false)
                end
            end, 1)
        end)

        node:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, node, function(self_, button, touchPosition)
            if not node:checkTouchPosition(touchPosition) then 
                self:handleHightLight(node.equipType, false)
            end
        end)

        node:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, node, function()
            self:handleHightLight(node.equipType, false)
        end)
    end
    node:addEventListener(UIEvent.COMPONENT_CLICK, node, function()
        self:choiceEquipType(node.equipType)
    end)

    return node
end

function FestivalSignView:handleHightLight(equipType, isShow)
    for k, v in ipairs(self.equipTypeNodeArr) do 
        local centerBg = v:getChildByName("weaponChoice")
        local weaponIcon = v:getChildByName("weaponIcon")
        if(v.equipType == equipType) then 
            if(isShow) then
                if(centerBg) then 
                    centerBg:show()
                end
                if(weaponIcon) then 
                    weaponIcon:setSpriteName(string.format("icon-equip_large_21080010_%d.png", v.equipType))
                end
            else
                if(self._choiceEquipType ~= equipType) then
                    if(centerBg) then 
                        centerBg:hide()
                    end
                    if(weaponIcon) then 
                        weaponIcon:setSpriteName(string.format("icon-equip_small1_21080010_%d.png", v.equipType))
                    end
                end
            end
            break
        end
    end
end


function FestivalSignView:choiceEquipType(equipType)
    self._choiceEquipType = equipType
    for k, v in ipairs(self.equipTypeNodeArr) do 
        local centerBg = v:getChildByName("weaponChoice")
        local weaponIcon = v:getChildByName("weaponIcon")
        if(v.equipType == equipType) then 
            if(centerBg) then 
                centerBg:show()
            end
            if(weaponIcon) then 
                weaponIcon:setSpriteName(string.format("icon-equip_large_21080010_%d.png", v.equipType))
            end
        else
            if(centerBg) then 
                centerBg:hide()
            end
            if(weaponIcon) then 
                weaponIcon:setSpriteName(string.format("icon-equip_small1_21080010_%d.png", v.equipType))
            end
        end
    end

    if(self.roleAnimation) then 
        local nowWearArr = {}
        local wearEquipmentArr = self.equipmentDataArr
        if (wearEquipmentArr) then
            for i = 1, #wearEquipmentArr do
                local equipmentData = wearEquipmentArr[i]
                local equipmentType = equipmentData:getEquipmentType()
                if (equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon) then 
                    if(equipmentData:getWeaponType() == equipType) then 
                        table.insert(nowWearArr, equipmentData)
                    end
                else
                    table.insert(nowWearArr, equipmentData)
                end
            end
        end

        self.roleAnimation:updateRoleEquipment(nowWearArr)
        if(self.roleAnimation:getRoleRender() and self.roleAnimation:getRoleRender():getHeroAnimation()) then
            self.roleAnimation:getRoleRender():getHeroAnimation():setAnimation(
                0,
                "idle_town_" .. self.roleAnimation._currentWeaponType,
                true
            )
        end
    end
end

function FestivalSignView:addUIEff()
    -- 右侧花
    local flower  = UI.Image:create();
    if self._signInType == ANNIVERSARY_SIGN then
        flower:init("ui_welfare_decorate_13.png");
        flower:rightBottom(-70, -12)
    else
        flower:init("ui_welfare_decorate_02.png");
        flower:rightBottom(-50, -12)
    end
    self.contentLayout:addChild(flower, 100)

    if self._signInType ~= ANNIVERSARY_SIGN then
        -- 左侧兔子
        local eff1 = UI.Animation:create()
        eff1:init("effect_ui_town_festival_lantern.json", "effect_ui_town_festival_lantern.atlas", 1);
        eff1:leftBottom(12, -5)
        self.contentLayout:addChild(eff1, 100)
        eff1:setAnimation("idle", true)

        -- 飘带
        local eff2 = UI.Animation:create()
        eff2:init("effect_ui_town_festival_ribbon.json", "effect_ui_town_festival_ribbon.atlas", 1);
        eff2:centerBottom(-30)
        self.contentLayout:addChild(eff2, 100)
        eff2:setAnimation("idle", true)

        -- 烟花
        local eff3 = UI.Animation:create()
        eff3:init("effect_ui_town_festival_fireworks.json", "effect_ui_town_festival_fireworks.atlas", 1);
        -- eff3:leftUp(-100, 0)
        eff3:center()
        self.contentLayout:addChild(eff3, 110)
        eff3:setAnimation("begin", true)
    else
        -- 右侧彩旗
        local flag1  = UI.Image:create();
        flag1:init("ui_welfare_decorate_12.png");
        flag1:rightUp(0, 15)
        self.contentLayout:addChild(flag1, 100)

        -- 左侧彩旗
        local flag2  = UI.Image:create();
        flag2:init("ui_welfare_decorate_11.png");
        flag2:leftUp(-70, 10)
        self.contentLayout:addChild(flag2, 100)

        -- 烟花
        local eff3 = UI.Animation:create()
        eff3:init("effect_ui_town_festival_fireworks.json", "effect_ui_town_festival_fireworks.atlas", 1);
        eff3:center()
        self.contentLayout:addChild(eff3, 110)
        eff3:setAnimation("begin", true)

        -- 烛火
        local candle = UI.Animation:create()
        candle:init("effect_ui_town_anniversary_fire.json", "effect_ui_town_anniversary_fire.atlas", 1);
        candle:leftBottom(30, 250)
        self.contentLayout:addChild(candle, 110)
        candle:setAnimation("idle", true)

        -- 彩带
        local ribbon = UI.Animation:create()
        ribbon:init("effect_ui_town_anniversary_caidai.json", "effect_ui_town_anniversary_caidai.atlas", 1);
        ribbon:centerBottom(-30)
        self.contentLayout:addChild(ribbon, 110)
        ribbon:setAnimation("idle", true)

        -- 光圈
        local photo = UI.Animation:create()
        photo:init("effect_ui_anniversary_sign.json", "effect_ui_anniversary_sign.atlas", 1);
        photo:centerLeft(195, 170)
        self.contentLayout:addChild(photo, 110)
        photo:setAnimation("idle", true)
    end
end

function FestivalSignView:handleLanguage()
    self:refreshWebLaunguageCallback({})        

    local curTime = GameManager:getNormalServerTime()
    -- 删除已经下架的 和已经售完 并且标示了隐藏的
    local size = table.nums(self.sevenGiftBag)
    for i= size,1, -1 do
        local item = self.sevenGiftBag[i]
        -- 时间到了下架的
        if (item.endTimeSec > 0 and item.endTimeSec < curTime) then
            print("从本地删除")
            table.remove(self.sevenGiftBag,i)
        end
        
    end
    
    local keyList = {}
    for i,v in ipairs(self.sevenGiftBag) do
        table.insert( keyList, v.nameID )
        table.insert( keyList, v.desID )
    end

    local lans = SdkManager:getInstance():getProductsLan()
    if lans and table.nums(lans) > 0 then
        local hasOneUpdate = false
        for i,v in ipairs(self.sevenGiftBag) do
            local findName = false
            local findDesc = false
            for idx,lan in pairs(lans) do
                if v.nameID == idx then
                    findName = true;
                end
                if v.desID == idx then
                    findDesc = true;
                end
                if findDesc and findName then
                    break;
                end
            end
            if not findDesc or not findName then
                hasOneUpdate = true ;
                break;
            end
        end
        if hasOneUpdate then
            SdkManager:getInstance():loadProductsLan( keyList, handler(self, self.refreshWebLaunguageCallback))
        else
            self:refreshWebLaunguageCallback(lans)
        end
        
    else
        -- dump(keyList)
        -- 获取苹果商店的信息
        SdkManager:getInstance():loadProductsLan(keyList, handler(self, self.refreshWebLaunguageCallback))
    end
end

function FestivalSignView:refreshWebLaunguageCallback(webLaunguageList)
    if not self.sevenGiftBag  then
        return
    end

    local infos = SdkManager:getInstance():getProducts()
    local myChannel = SdkBox:getInstance():getVersionChannel()

    printInfo("SevenDaysView:refreshWebLaunguageCallback, myChannel",myChannel)

    for i,v in ipairs(self.sevenGiftBag) do
        v.name = ""
        v.desc = ""
        v.iapId = ""
        for idx,lan in pairs(webLaunguageList) do
            if v.nameID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.name = str
            end
            if v.desID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.desc = str
            end
        end
        for i,idAndChannel in ipairs(v.IAPList) do
            if checkint(idAndChannel.channelID) == myChannel then
                -- table.insert( iaps, idAndChannel.iapId)  

                v.iapId = idAndChannel.iapId
                break;      
            end
        end
    end

    UI.WaitingLayer:showWaiting(true, nil, 0)

    self:onGetLocalization()
end

function FestivalSignView:onGetLocalization()
    
    for i, d in ipairs(self.sevenGiftBag ) do
		-- 默认货币符号
		d.symbol = self:getCurrencySymbol()
	end
    
    -- self._loading:setVisible(false)
    UI.WaitingLayer:hideWaiting()
end

-- 获取货币符号
function FestivalSignView:getCurrencySymbol()
    local symbol = "￥"
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        symbol = "$"
    end
	return symbol
end

function FestivalSignView:getSignFinalReward()
    -- 检查背包格数
    local goodsArr = {}
    for k, v in ipairs(self.signData.finalReward) do
        local data = {}
        data.goodsID = v.id
        data.num = v.num
        data.isGolden = true
        table.insert(goodsArr, data)
    end

    -- 背包检查合格, 请求获取奖励; 不合格, 提示
    if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)) then
        self.isGetSignFinalReward = true
        Net.NetRoleSystem:requestGoalReward(self.signData.ID, 0, 0)
    else
        UI.ScrollBar:createByTextID(1170081)
    end
end

function FestivalSignView:targetPrgUpdate()
    if not self._planType then
        return
    end
    -- 签到界面的刷新，留给cell内部自己处理
    -- 这里仅处理七日计划的界面刷新，因为不能通过cell的内部处理
    print("FestivalSignView:targetPrgUpdate")
    self:formatData()

    self.taskLayout:removeChildByName("taskSV")
    self:initTaskList()
end

function FestivalSignView:getRewardResp(data)
    self:formatData()
    -- dump(data, "data111111", 10)

    if self.isGetSignFinalReward then
        self.isGetSignFinalReward = false

        -- self.signBoxEff:setAnimation("3", false)
        -- self.signBoxEff:addAnimation("4", true)

        self:popRewards(self.signData.finalReward)
    end

    -- if self.isGetTaskFinalReward then
    --     self.isGetTaskFinalReward = false

    --     -- self.taskBoxEff:setAnimation("3", false)
    --     -- self.taskBoxEff:addAnimation("4", true)

    --     self:popRewards(self.taskData.finalReward)
    -- end
    self:checkFinalRewardState()
    self:updateTotalRewardPrg()
    self:updateSignTotalReward()
    self._tableView:reloadData(true)
end

function FestivalSignView:popRewards(rewards)
    local itemData = {}
    for k, v in pairs(rewards) do
        local goodData = GoodsDataManager:createLocalGoodsData(v.id)
        if(goodData) then
            goodData:setIsNew(false)
            goodData:setNum(v.num)
            table.insert(itemData, goodData)
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, nil, nil, nil, true)
end

function FestivalSignView:checkFinalRewardState()
    self.canGetSignFinalReward = mvc.festivalSignModel:checkCanGetFinalReward(self._signInType)
    -- self.canGetTaskFinalReward = mvc.festivalSignModel:checkCanGetFinalReward(self._planType)

    if self.canGetSignFinalReward then
        -- self.signBoxEff:setAnimation("2", true)
    end

    if self.canGetTaskFinalReward then
        -- self.taskBoxEff:setAnimation("2", true)
    end
end

function FestivalSignView:refreshNewDay()
    if(self._tableView) then
        self._tableView:reloadData(true)
    end
end

function FestivalSignView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.refreshNewDay)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, self, self.targetPrgUpdate)
end


function FestivalSignView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.refreshNewDay)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, self, self.targetPrgUpdate)
end





return FestivalSignView












