------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local UseMoldToolBoxCellView = class("UseMoldToolBoxCellView", UI.ListGrid)
UI.UseMoldToolBoxCellView = UseMoldToolBoxCellView

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 90
local COM_HEIGHT = 90

function UseMoldToolBoxCellView:ctor()
    UseMoldToolBoxCellView.super.ctor(
    	self
    )
    self.boxGrid = nil
    self._isDraging = false
    self.moldInfo = nil
    self.isLock = false
    self:bindModel()
end

function UseMoldToolBoxCellView:init(data, ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.usemold", "UseMold", false)
    UseMoldToolBoxCellView.super.init(self, ... )
    self.data = data
end

function UseMoldToolBoxCellView:dtor()
    UseMoldToolBoxCellView.super.dtor(self)
    self:unbindModel()
    self.boxGrid = nil
    self.moldInfo = nil
    self.isLock = false
    reload_script_file_mvc("app.modules.usemold.UseMoldToolBoxCellView")
end


function UseMoldToolBoxCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_fishing_box_1.png")
    centerBg:center()
    contentLayout:addChild(centerBg)
    self.centerBg = centerBg

    -- 背景图片
    local frameImg  = UI.Image:create()
    frameImg:init("ui_mold_box.png")
    frameImg:center()
    contentLayout:addChild(frameImg)
    self.frameImg = frameImg

    local lockImg  = UI.Image:create()
    lockImg:init("ui_fishing_box_2.png")
    lockImg:center()
    contentLayout:addChild(lockImg)
    self.lockImg = lockImg
    lockImg:hide()

    -- local icon  = UI.Image:create()
    -- icon:init("")
    -- icon:centerLeft(3)
    -- centerBg:addChild(icon)
    -- self.icon = icon

end

function UseMoldToolBoxCellView:onUpdateView()
    if self.config then
        if self.config.condition == 1 then
            local roleLv = RoleDataManager:getMaster():getLevel()
            if roleLv < self.config.value then
                self.lockImg:show()
                self.isLock = true
            end
        end
        
        if self.moldInfo then
            local config = ConfigManager:getAllMoldForgingDataByID(self.moldInfo.configId)
            local data = {}
            data.config = config
            data.moldInfo = self.moldInfo
            self:addBoxGrid(data)
        end
    end
    
end

function UseMoldToolBoxCellView:addBoxGrid(gridData)
    if self.boxGrid then
        return 
    end
    local boxGrid = mvc.useMoldBagBoxCellView:create(true)
    boxGrid:init()
    boxGrid:center()
    self.contentLayout:addChild(boxGrid)
    self.boxGrid = boxGrid
    self.gridData = gridData
    boxGrid:setData(self.gridData)
    boxGrid:updateView()
end

function UseMoldToolBoxCellView:createDraggedView()
    if not self.boxGrid then
        return false
    end

    local boxGrid = mvc.useMoldBagBoxCellView:create(true)
    boxGrid:init()
    boxGrid:setData(self.gridData)
    boxGrid:updateView()

    return boxGrid
end

function UseMoldToolBoxCellView:onBagBoxDragEnd(grid, position)
    if self.isLock then
        return 
    end
    if self:checkTouchPosition(position) and not self.boxGrid then
        -- self:addBoxGrid(grid:getData())
        local data = grid:getData()
        Net.NetRoleSystem:reqUseMold(data.config.id, 1, self.config.id)
    end
end

function UseMoldToolBoxCellView:onMoldDragUsed(data)
    
    if data.pos ~= self.config.id then
        return
    end

    -- if data.opType == 1 then
    --     local config = ConfigManager:getAllMoldForgingDataByID(data.configId)
    --     local data = {}
    --     data.config = config
    --     data.moldInfo = self.moldInfo

    --     self:addBoxGrid(data)
    -- end
    
    -- if data.opType == 2 then
    --     self:removeGrid()
    -- end
end

function UseMoldToolBoxCellView:removeGrid()
    self.boxGrid:removeFromParent(true)
    self.boxGrid = nil
    self.gridData = nil
end

function UseMoldToolBoxCellView:isClickShowInfo()
    return true
end

function UseMoldToolBoxCellView:setData(data)
    self.config = data
    self.moldInfo = data.moldInfo
end

function UseMoldToolBoxCellView:getData()
    return self.config
end

function UseMoldToolBoxCellView:getMoldGridData()
    return self.gridData
end

function UseMoldToolBoxCellView:isEmpty()
    return self.boxGrid == nil
end

function UseMoldToolBoxCellView:showIcon()

end

function UseMoldToolBoxCellView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_USE_MOLD_DRAGE_END, self, self.onBagBoxDragEnd)
    Avalon.MessageCenter:bind(AvalonMessage.MC_USE_MOLD_DRAGE_USE, self, self.onMoldDragUsed)
end


function UseMoldToolBoxCellView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_USE_MOLD_DRAGE_END, self, self.onBagBoxDragEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_USE_MOLD_DRAGE_USE, self, self.onMoldDragUsed)
end





return UseMoldToolBoxCellView












