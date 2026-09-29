-- DreamGetTaskLayer.lua
-- Author:ydli
-- 2019年03月11日
-- Using:梦境领取任务界面
UI = UI or {}
local DreamGetTaskLayer = class("DreamGetTaskLayer", UI.CenterWin)
UI.DreamGetTaskLayer = DreamGetTaskLayer

local size = cc.size(567, 415)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_dream_common.plist",
}
----表情界面
--构造函数(必备)
function DreamGetTaskLayer:ctor(spriteID)
    --窗口大小
    DreamGetTaskLayer.super.ctor(self,UIType.MC_UI_DREAM_GET_TASK, COM_RES_LIST, size.width, size.height)
    self.spriteID = spriteID
    local dreamData = MasterDataManager:getDreamData()

   


    self.taskData = {}
    if MasterDataManager:isHaveDreamData() then
        self.netData = dreamData.bossInfos[dreamData.curBossIndex]
        self.taskData = ConfigManager:getDreamTaskById(self.netData.challengeID) or {}
        local dreamConfig = ConfigManager:getDreamConfigForLV(dreamData.lv)
        self.costCoin = dreamConfig.coinCost
        
    else
         Net.NetRoleSystem:requestGetDreamInfo()
    end

end

--虚构函数,destroy时调用(必备)
function DreamGetTaskLayer:dtor()
    DreamGetTaskLayer.super.dtor(self)
end

-- 初始化(必备)
function DreamGetTaskLayer:init()
    DreamGetTaskLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function DreamGetTaskLayer:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_dreamword_paper_3.png")
    bg:center()
    self:addChild(bg)
  
    --title
    local title = UI.Text:create()
    title:init(UI.TEXT_1212269, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_204_204_204)
    title:centerUp(30)
    bg:addChild(title)
    
    --content
    local conditionTitle = UI.Text:create()
    conditionTitle:init(UI.TEXT_1212259, UI.FONT_STANDARD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_51_51_51)
    conditionTitle:leftUp(105, 98)
    bg:addChild(conditionTitle)
   
    local conditionContent = UI.Text:create()
    conditionContent:init(self.taskData.taskDesc, UI.FONT_STANDARD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_51_51_51)
    conditionContent:leftUp(105, 118)
    conditionContent:setSize(366, 55)
    conditionContent:setTextVerticalCenter()
    conditionContent:autoAdapt()
    bg:addChild(conditionContent)
    -- conditionContent:enableDebugDraw()
    conditionContent:setLineSpacing(-6)

    local rewardTitle = UI.Text:create()
    rewardTitle:init(UI.TEXT_1212258, UI.FONT_STANDARD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_51_51_51)
    rewardTitle:leftUp(105, 170)
    bg:addChild(rewardTitle)

    local rewardContent = UI.Text:create()
    rewardContent:init(string.format(UI.TEXT_1212350, checkint(self.taskData.taskReward) / 100), UI.FONT_STANDARD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_51_51_51)
    rewardContent:leftUp(105, 190)
    rewardContent:setSize(366, 80)
    rewardContent:setLineSpacing(-6)
    rewardContent:setTextVerticalCenter()
    rewardContent:autoAdapt()
    bg:addChild(rewardContent)
    -- rewardContent:enableDebugDraw()

    local image = AvalonUtil:serializeImage("symbol_gaming_money.png")
    local number = AvalonUtil:serializeText(tostring(self.costCoin), UI.FONT_COLOR_51_51_51, UI.FONT_SIZE_17PX, UI.FONT_STANDARD)
    local content = AvalonUtil:formartRichText(UI.FONT_COLOR_51_51_51, UI.FONT_SIZE_17PX, UI.FONT_STANDARD, UI.TEXT_1212254, image..number)
    local costTips = UI.RichText:create(-3)
    costTips:init(content, 366, 0, false)
    if costTips then
        costTips:leftUp(105, 268)
        bg:addChild(costTips)
    end

    --leftBtn
    local cancelBtn = UI.Button:create()
    cancelBtn:init("ui_btn_no1_0.png", "ui_btn_no1_2.png", "ui_btn_no1_2.png")
    cancelBtn:leftUp(130, 320)
    bg:addChild(cancelBtn)
    cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:closeWin()
    end)

    local okButton = UI.Button:create()
    okButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png")
    okButton:leftUp(330, 320)
    bg:addChild(okButton)
    okButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:pickUpClick()
        self:closeWin()
    end)
end

-- 模版函数：更新组建的视图(必备)
function DreamGetTaskLayer:onUpdateView()
end

function DreamGetTaskLayer:openShow()
    self:open()
end

function DreamGetTaskLayer:pickUpClick()
    if RoleBehaviorManager:dreamTaskCheck() then
        printWarn(" been blocked when pick up dream task!")
        return
    end
    if self.netData.stat ~= PublicDefine.DreamTaskState.State_UnRecieve then
        UI.ScrollBar:createByText(UI.TEXT_1212252)
        return 
    end
    if self.taskData.coinCost == nil then
        return
    end
    local GameDataManager = require("app.game.GameDataManager")
    if GameDataManager:getInstance():getCurCoin() < tonumber(self.taskData.coinCost) then
        UI.ScrollBar:createByText(UI.TEXT_110210)
        return
    end
    Net.NetRoleSystem:requestPickUpDreamTask(MasterDataManager:getDreamData().curBossIndex - 1)
end