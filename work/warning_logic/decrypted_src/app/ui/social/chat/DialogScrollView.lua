--[[
    UI - 滑动组件
]]--

require "app.ui.common.ScrollView"

UI = UI or {}

local DialogScrollView = class("DialogScrollView", UI.ScrollView)
UI.DialogScrollView = DialogScrollView


-- -- 更新视图
-- function DialogScrollView:onUpdateView(data)
--     -- DialogScrollView.super.onUpdateView(self, data)
-- end

-- function DialogScrollView:onRefreshView(data)
--     DialogScrollView.super.onUpdateView(self, data)
-- end

-- 析构函数
function DialogScrollView:dtor()

end

function DialogScrollView:setSize(width, height)
    self.super.setSize(self, width, height)
    self.maxSize = math.ceil((height / 30) + 2) --cell 最大数
end

function DialogScrollView:getMaxCellSize()
    self.maxSize = self.maxSize or math.ceil((self._height / 30) + 2) --cell 最大数
    return self.maxSize 
end