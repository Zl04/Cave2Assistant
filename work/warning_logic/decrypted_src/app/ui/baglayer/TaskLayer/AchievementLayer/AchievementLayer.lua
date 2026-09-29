--[[
    USING:成就UI
    AHTHOR:CHENZIHAN
]]

require("app.ui.baglayer.TaskLayer.AchievementLayer.AchievementCell")

UI = UI or {}
local AchievementLayer = class("AchievementLayer",UI.HWBtnComponent)
UI.AchievementLayer = AchievementLayer



local DEBUG = false
local DEBUG_DRAW = false
-- 尺寸
local COM_WIDTH = 852
local COM_HEIGHT = 534
ACHIEVEMENT_CELL_COUNT_NUMBER = 4--一个tablecell 放入的元素个数
-- 背包资源
local COM_RES_LIST = {
    "ui_icon_achievements_chest.plist"
}

function AchievementLayer:ctor(spriteID)
    AchievementLayer.super.ctor(self,UIType.ACHIEVEMENT_UI, COM_RES_LIST,COM_WIDTH,COM_HEIGHT)
    self._data = nil
    self._UIType = nil  --显示类型(城镇还是背包)
    self._spriteID = spriteID
    self._achievementPoint = nil;
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACHIEVEMENT_POINT_UPDATE,self,self.onAchievementPointUpdate)
end

function AchievementLayer:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACHIEVEMENT_POINT_UPDATE,self,self.onAchievementPointUpdate)
    self._data = nil
    AchievementLayer.super.dtor(self)
end

function AchievementLayer:init(type)
    self._UIType = type
    self:refreshData()
    self._cellNumber = math.ceil(#self._data / ACHIEVEMENT_CELL_COUNT_NUMBER)
    AchievementLayer.super.init(self)
end


function AchievementLayer:onInitView(data)
    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    line:setContentSize(COM_WIDTH - 46, 1)
    line:setAnchorPoint(0, 0)
    line:setPosition(12, COM_HEIGHT - 48)
    self:addChild(line)


    local type = self._UIType 
    local achievementPoint =  UI.Text:create()
    achievementPoint:init("",  UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    achievementPoint:leftUp(32,14)
    self:addChild(achievementPoint,100)
    self._achievementPoint = achievementPoint

    local achievementPointNum =  UI.Text:create()
    achievementPointNum:init("",  UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_249_220_103)
    achievementPointNum:leftUp(60,9)

 
    local achIcon = UI.Image:create()
    achIcon:init("ui_information_achievement.png")
    achIcon:leftBottom(80,9)
    self:addChild(achIcon)
    self.achIcon = achIcon

    self:addChild(achievementPointNum,100)
    self._achievementPointNum = achievementPointNum

    self:onAchievementPointUpdate()

    local achTableView = cc.TableView:create(cc.size(COM_WIDTH - 18, COM_HEIGHT - 65))
    achTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    achTableView:setPosition(0,15)
    achTableView:setDelegate()
    achTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self:addChild(achTableView, 20)

    achTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    achTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    achTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    achTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    achTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    achTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    achTableView:registerScriptHandler(handler(self,self.tableCellWillRecycle),cc.TABLECELL_WILL_RECYCLE)
    self.achTableView = achTableView
    achTableView:initScrollBar(false)
    achTableView:setScrollBarWidth(6)
    achTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    achTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)

    local bottom = UI.Image:create()
    bottom:init("ui_bg_paper_mask1.png")
    bottom:centerBottom(0)
    self:addChild(bottom, 30)
end

function AchievementLayer:onUpdateView(data)
end

function AchievementLayer:numberOfCellsInTableView(table)
    return self._cellNumber 
end

function AchievementLayer:scrollViewDidScroll(view)
end

function AchievementLayer:scrollViewDidZoom(view)
    
end

function AchievementLayer:tableCellTouched(tableView,cell)

end

function AchievementLayer:tableCellWillRecycle(tableView,cell)
    -- print("---AchievementLayer:tableCellWillRecycle------")
end

function AchievementLayer:cellSizeForTable(table,idx)
    return 775, 215
end

function AchievementLayer:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    if cell == nil then
         cell = UI.AchievementCell:create(self._spriteID, self._UIType, self.achTableView)
    end

    xpcall(function()
        local achDataList  = {}
        for i = idx * ACHIEVEMENT_CELL_COUNT_NUMBER + 1, (idx + 1)  * ACHIEVEMENT_CELL_COUNT_NUMBER do
            local data = self._data[i]
            if data ~= nil then
                table.insert(achDataList, data)
            end
        end
        cell:reload(achDataList)
    end, 
    function(e) 
        print("------------------------AchievementLayer:tableCellAtIndex-----------------error")
        dump(e)
    end, 1)  
    return cell
end

function AchievementLayer:onAchievementPointUpdate()
    self._achievementPoint:setText(UI.TEXT_1212020)
    self.achIcon:leftUp(self._achievementPoint:getLeft() + self._achievementPoint:getContentSize().width + 4, self._achievementPoint:getUp() + 2)
    self._achievementPointNum:setText(RoleDataManager:getMaster():getAchievementPoint())
    self._achievementPointNum:leftUp(self.achIcon:getLeft() + self.achIcon:getContentSize().width + 4, self._achievementPoint:getUp() - 1)

    -- if not isInit then
    --     self:refreshData()

    --     self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
    --         if self.achTableView then
    --             self.achTableView:reloadData()
    --         end
    --     end)))
    -- end
    
end


function AchievementLayer:refreshData()
    local allData = ConfigManager:getAllAchievement()
    self._data = {}
    -- for k, v in pairs( allData ) do
    --     if type(v) == "table" then
    --         table.insert(self._data,v)
    --     end
    -- end
    -- table.sort(self._data,function (a,b)
    --     return a.ID < b.ID
    -- end)

    local completeData = {}
    local otherData = {}
    for k, v in pairs(allData) do
        if type(v) == "table" then
            local adata = MasterDataManager:getAchevementData(v.ID)
            local current = 0;
            local stage = 0;
            local targetNum = 0;
            local maxStage = table.nums(v.goal)
            if adata then
                current = adata.count
                stage = adata.rewardStage 
            end

            if stage < maxStage then
                local targetNum = 0
                if v.countType == 1 then
                    targetNum = v.goal[stage + 1]
                else
                    targetNum = v.goal[1]
                end

                -- 达成目标
                if current >= targetNum then--已完成 未领奖
                    table.insert(completeData,v)
                else
                    table.insert(otherData,v)
                end
            else
                table.insert(otherData,v)
            end

            
        end
    end

    if #completeData > 1 then
        table.sort(completeData,function (a,b)
            return a.ID < b.ID
        end)
    end

    if #otherData > 1 then
        table.sort(otherData,function (a,b)
            return a.ID < b.ID
        end)
    end

    for k, v in ipairs(completeData) do
        table.insert(self._data,v)
    end

    for k, v in ipairs(otherData) do
        table.insert(self._data,v)
    end

end
