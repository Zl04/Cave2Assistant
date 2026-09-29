------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/05/16
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local WorldBossView = class("WorldBossView", UI.HWBtnComponent)
local scheduler = cc.Director:getInstance():getScheduler()
require "app.modules.worldboss.WorldBossRewardCell"

-- 资源
local COM_RES_LIST = {
    "ui_town_world_boss.plist",
    "ui_common_information.plist",
    "ui_common_icon_equip.plist",
    "ui_package_log.plist",
}

local COM_WIDTH = 830
local COM_HEIGHT = 580
local layoutUtil
local ZOrder = 1
local REWARD_CELL_W = 80
local REWARD_CELL_H = 72

function WorldBossView:ctor()
    WorldBossView.super.ctor(
    	self,
    	UI.Type.WORLD_BOSS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    layoutUtil = UIUtil:createAutoUILayout("WorldBossView","app.modules.worldboss.WorldBossPosConfig", false)
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self, self.scheduleUpdateTime), 1, false)

    self.blockClick = false
end

function WorldBossView:dtor()
    self.blockClick = false

    WorldBossView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.worldboss.WorldBossView")

    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function WorldBossView:scheduleUpdateTime()
    if self.countDownTime > 0 then
        self:formatCountDown()
        self.countDownTime = self.countDownTime - 1
    elseif self.countDownTime == 0 then
        self:updateBtnTxtAndCountDown()
        if self.schedulerID ~= nil then
            scheduler:unscheduleScriptEntry(self.schedulerID)
            self.schedulerID = nil
        end
    end
end

function WorldBossView:resolveItems(str)
    local items = AvalonUtil:splitStr(str, ";")
    local finalList = {}
    for k, v in ipairs(items) do
        local list = AvalonUtil:splitStr(v, ",")
        local item = {}
        item.id = tonumber(list[1])
        item.num = tonumber(list[2])
        table.insert(finalList, item)
    end
    return finalList
end

function WorldBossView:formatCountDown()
    local str = ""
    local minute = math.modf(self.countDownTime/SECONDS_ONE_MINUTES)
    local seconds = math.modf(self.countDownTime%SECONDS_ONE_MINUTES)
    str = string.format("%02d:%02d", minute, seconds)
    self.countDownValue:setText(str)
end

function WorldBossView:updateBtnTxtAndCountDown()
    local stateData = mvc.worldBossModel:getStateData()
    local roomData = mvc.worldBossModel:getRoomData()
    local stateBox = mvc.worldBossModel:getStateBox()

    self.funcBtn:setText(stateBox.btnTxt)
    self.countDownTxt:setText(stateBox.tipTxt)
    if not stateBox.joinAvailable then
        self.funcBtn:disable()
    end

    self.countDownTime = stateBox.countDown
    if self.countDownTime > 0 then
        self:formatCountDown()
    else
        self.countDownValue:setText("")
    end
end

function WorldBossView:onInitView()
    self.cfgData = mvc.worldBossModel:getCfgData()
    if self.cfgData then
        self.finishReward = self:resolveItems(self.cfgData.finishReward)
        self.lastReward = self:resolveItems(self.cfgData.lastReward)
    end

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
    bg:init("ui_bg_box1.png");
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;

    -- 标题背景图片
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_bg_title.png");
    bgTitle:centerUp(4);
    contentLayout:addChild(bgTitle, ZOrder);
    ZOrder = ZOrder + 1;

    local titleTxtLayout = UI.Layout:create();
    titleTxtLayout:init()
    titleTxtLayout:setSize(235, 50)
    titleTxtLayout:leftUp(305, 10)
    contentLayout:addChild(titleTxtLayout, ZOrder)
    ZOrder = ZOrder + 1;

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1212645, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_170_170_170)
    titleTxt:center()
    titleTxtLayout:addChild(titleTxt)

    -- 背景底图
    local bg2  = UI.Image:create();
    bg2:init("ui_bg_paper1.png");
    bg2:center();
    contentLayout:addChild(bg2, ZOrder);
    ZOrder = ZOrder + 1;

    self:updateInnerPanel(bg2)
end

function WorldBossView:updateInnerPanel(root)
    -- left
    local leftLayout = UI.Layout:create();
    leftLayout:init()
    leftLayout:setSize(252, 447)
    leftLayout:centerLeft(0)
    root:addChild(leftLayout, ZOrder+1)
    -- leftLayout:enableDebugDraw()

    -- 怪物模型
    local posX = leftLayout:getContentSize().width/2
    local posY = 256
    local monsterBG = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_scene1.png")
    monsterBG:setPosition(posX, posY)
    leftLayout:addChild(monsterBG)

    local monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(self.cfgData.showMonsterID, PublicDefine.CAVE_MODE.MODE_WORLD_BOSS, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    if monsterData ~= nil then
        monsterBG:setSpriteFrame("ui_log_banner_page_scene"..ToolsUtil:getPageSceneID(monsterData)..".png")

        local roleAnimation = Avalon.Animation:create(monsterData.spine..".json", monsterData.spine..".atlas", 1)
        roleAnimation:setAnimation(0, "idle1", true)
        local x = monsterBG:getContentSize().width
        local y = monsterBG:getContentSize().height
        roleAnimation:setPosition(monsterBG:getContentSize().width/2, monsterBG:getContentSize().height/3)
        monsterBG:addChild(roleAnimation)
        roleAnimation:setName("roleAnimation")
        roleAnimation:setScale(monsterData.size/1000.0)

        if checkint(monsterData.monsterID) == 10201305 or checkint(monsterData.monsterID) == 10204305 then
            roleAnimation:setPositionX(roleAnimation:getPositionX() + 20)
            roleAnimation:setPositionY(roleAnimation:getPositionY() - 50)
        end
    
        if checkint(monsterData.monsterID) == 10205301 or checkint(monsterData.monsterID) == 10206301 then
            roleAnimation:setPositionY(roleAnimation:getPositionY() - 26)
        end

        roleAnimation:registerSpineEventHandler(function(event)
            if event.animation == "idle1" then
                if math.random() < 0.3 then
                    roleAnimation:setAnimation(0, "idle2", false)
                    roleAnimation:addAnimation(0, "idle1", true)
                end
            end
        end, sp.EventType.ANIMATION_COMPLETE)
    end

    -- tip


    local stateData = mvc.worldBossModel:getStateData()
    if stateData.battleNo and stateData.battleNo > 0 then
        local tipLayout = UI.Layout:create();
        tipLayout:init()
        tipLayout:setSize(270, 90)
        tipLayout:leftBottom(178, 52)
        leftLayout:addChild(tipLayout)
    
        local tipBtn = UI.Button:create()
        tipBtn:init("ui_btn_boss_0.png","ui_btn_boss_1.png","ui_btn_boss_0.png")
        tipBtn:leftUp(0, 0)
        tipBtn:closeClickScale()
        tipBtn:addEventListener(UIEvent.BUTTON_PRESS, self, function(self)
            self.tipBg:show()
        end)
        tipBtn:addEventListener(UIEvent.BUTTON_RELEASE, self, function(self)
            self.tipBg:hide()
        end)
        tipLayout:addChild(tipBtn)

        local sword = UI.Image:create();
        sword:init("icon-equip_large_21080010_2.png");
        sword:leftUp(6, 6);
        tipBtn:addChild(sword, 2)
    
        local txtBgWidth = 268
        local txtBgHeight = 56
        local txtBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_character2.png")
        txtBg:setContentSize(txtBgWidth, txtBgHeight)
        txtBg:setCapInsets(CCRectMake(7, 7, 1, 1))
        txtBg:setPosition(txtBgWidth/2, 150)
        txtBg:hide()
        tipLayout:addChild(txtBg)
    
        local tipContent = UI.Text:create()
        local buffTxt = mvc.worldBossModel:getBuffText()
        tipContent:init(buffTxt, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
        tipContent:setWidth(txtBgWidth-10)
        tipContent:center()
        tipContent:autoAdapt()
        txtBg:addChild(tipContent)
        self.tipBg = txtBg

        local w, h = tipContent:getSize()
        txtBg:setContentSize(txtBgWidth, h+20)
    end

    -- 加入按钮
    local funcBtn = UI.Button:create()
    funcBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
    funcBtn:leftBottom(19, 23)
    funcBtn:setText(UI.TEXT_1212639)
    funcBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    funcBtn:closeClickScale()
    funcBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.blockClick then
            UI.ScrollBar:createByText(UI.TEXT_1212664)
            return
        end

        if not mvc.worldBossModel:checkBattleAvailable() then
            UI.ScrollBar:createByText(UI.TEXT_1212646)
            return
        end

        -- if(mvc.expeditionModel:getExpeditionStatus()) then
        --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
        --         Net.NetNPCSystem:reqStopExpedition()
        --         local battleNo = mvc.worldBossModel:getStateData().battleNo
        --         Net.NetActivitySystem:requestJoinWorldboss(battleNo)
        --         self.blockClick = true
        --     end, function()
        --     end)
        -- else 
            local battleNo = mvc.worldBossModel:getStateData().battleNo
            Net.NetActivitySystem:requestJoinWorldboss(battleNo)
            self.blockClick = true
        -- end
    end)
    self.funcBtn = funcBtn
    leftLayout:addChild(funcBtn)

    -- right
    local rightLayout = UI.Layout:create();
    rightLayout:init()
    rightLayout:setSize(420, 447)
    rightLayout:centerRight(0)
    root:addChild(rightLayout, ZOrder)
    -- rightLayout:enableDebugDraw()

    -- 挑战次数
    local maxCount = tonumber(Config.General:getValueForKey("WorldBossLimitTimes"))
    local curFightCount = mvc.worldBossModel:getStateData().fightedToday or 0
    local fightCount = UI.Text:create()
    local showTxt = (maxCount - curFightCount) .. "/" .. maxCount
    fightCount:init(UI.TEXT_1212647 .. showTxt, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    fightCount:rightUp(20, 10)
    rightLayout:addChild(fightCount)

    local splitLine1 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine1:setContentSize(379, 1)
    splitLine1:setCapInsets(CCRectMake(1,0,1,1))
    splitLine1:setPosition(210, 413)
    rightLayout:addChild(splitLine1)

    -- 首领歼灭奖励
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_boss_paper_title.png");
    bgTitle:leftUp(20, 42);
    rightLayout:addChild(bgTitle);

    local titleTxt1 = UI.Text:create()
    titleTxt1:init(UI.TEXT_1212648, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    titleTxt1:centerLeft(20)
    bgTitle:addChild(titleTxt1)

    local rewardList1 = UI.Layout:create()
    rewardList1:init()
    rewardList1:setSize(380, 75)
    rewardList1:leftUp(20, 78)
    self.rewardList1 = rewardList1
    rightLayout:addChild(rewardList1)

    -- 补刀奖励
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_boss_paper_title.png");
    bgTitle:leftUp(20, 158);
    rightLayout:addChild(bgTitle);

    local titleTxt2 = UI.Text:create()
    titleTxt2:init(UI.TEXT_1212649, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    titleTxt2:centerLeft(20)
    bgTitle:addChild(titleTxt2)

    local rewardList2 = UI.Layout:create()
    rewardList2:init()
    rewardList2:setSize(380, 75)
    rewardList2:leftUp(20, 194)
    self.rewardList2 = rewardList2
    rightLayout:addChild(rewardList2)

    -- 贡献奖励
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_boss_paper_title.png");
    bgTitle:leftUp(20, 276);
    rightLayout:addChild(bgTitle);

    local titleTxt3 = UI.Text:create()
    titleTxt3:init(UI.TEXT_1212650, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    titleTxt3:centerLeft(20)
    bgTitle:addChild(titleTxt3)

    local tipTxt = UI.Text:create()
    tipTxt:init(string.format(UI.TEXT_1212651, self.cfgData.dmgPool), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    tipTxt:leftBottom(40, 70)
    tipTxt:setSize(338, 64)
    tipTxt:setTextLeftUp()
    tipTxt:setLineSpacing(-2)
    tipTxt:autoAdapt()
    rightLayout:addChild(tipTxt)

    local splitLine2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine2:setContentSize(379, 1)
    splitLine2:setCapInsets(CCRectMake(1,0,1,1))
    splitLine2:setPosition(210, 60)
    rightLayout:addChild(splitLine2)

    -- 倒计时显示
    local countDownLayout = UI.Layout:create()
    countDownLayout:init()
    countDownLayout:setSize(380, 50)
    countDownLayout:leftBottom(20, 10)
    rightLayout:addChild(countDownLayout)

    local reminderIcon  = UI.Image:create();
    reminderIcon:init("ui_information_reminder.png");
    reminderIcon:floatLeft(10);
    countDownLayout:addComponent(reminderIcon);

    local countDownTxt = UI.Text:create()
    countDownTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
    countDownTxt:floatLeft(5)
    countDownLayout:addComponent(countDownTxt)
    self.countDownTxt = countDownTxt

    local countDownValue = UI.Text:create()
    countDownValue:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
    countDownValue:floatLeft(5)
    countDownLayout:addComponent(countDownValue)
    self.countDownValue = countDownValue

    self:addUIEffect(leftLayout)

    self:updateRewardList1()
    self:updateRewardList2()

    self:updateBtnTxtAndCountDown()
end
 
function WorldBossView:addUIEffect(rootNode)
    local leftEff = UI.Animation:create()
    leftEff:init("effect_ui_town_worldboss_c.json", "effect_ui_town_worldboss_c.atlas", 1);
    leftEff:leftBottom(-40, -30)
    rootNode:addChild(leftEff, 100)
    leftEff:setAnimation("idle", true)
end

function WorldBossView:updateRewardList1()
    self.rewardListView1 = UI.TableView.new({}, 380, 75);
    self.rewardListView1:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL);
    self.rewardListView1:centerUp(0)
    self.rewardListView1:setDelegate();
    self.rewardListView1:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.rewardListView1:setBounceable(true);
    self.rewardListView1:init(10);
    self.rewardListView1:onUpdateCellSize(function (table,idx)
        return REWARD_CELL_W, REWARD_CELL_H;
    end);

    self.rewardListView1:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.WorldBossRewardCell.new();
            cell:init(self.finishReward[idx+1]);
        end,
        function(e) 
            printError("------------------------rewardListView1:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    self.rewardListView1:onUpdateCellNumbers(function ()
        return #self.finishReward
    end);

    self.rewardListView1:onTableCellTouched(function(table, cell)
        
    end);

    self.rewardList1:addChild(self.rewardListView1);
    self.rewardListView1:reloadData(true);
end

function WorldBossView:updateRewardList2()
    self.rewardListView2 = UI.TableView.new({}, 380, 75);
    self.rewardListView2:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL);
    self.rewardListView2:centerUp(0)
    self.rewardListView2:setDelegate();
    self.rewardListView2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.rewardListView2:setBounceable(true);
    self.rewardListView2:init(10);
    self.rewardListView2:onUpdateCellSize(function (table,idx)
        return REWARD_CELL_W, REWARD_CELL_H;
    end);

    self.rewardListView2:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.WorldBossRewardCell.new();
            cell:init(self.lastReward[idx+1]);
        end,
        function(e) 
            printError("------------------------rewardListView2:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    self.rewardListView2:onUpdateCellNumbers(function ()
        return #self.lastReward
    end);

    self.rewardListView2:onTableCellTouched(function(table, cell)
        
    end);

    self.rewardList2:addChild(self.rewardListView2);
    self.rewardListView2:reloadData(true);
end



function WorldBossView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_WORLDBOSS_BOSS_DEAD, self, self.updateBtnTxtAndCountDown)
end


function WorldBossView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_WORLDBOSS_BOSS_DEAD, self, self.updateBtnTxtAndCountDown)
end





return WorldBossView
