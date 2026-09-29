------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/14
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortView = class("BigSailPortView", UI.HWBtnComponent)
require "app.modules.bigsailport.BigSailPortSupplyView"
require "app.modules.bigsailport.BigSailPortMerchantView"
require "app.modules.bigsailport.BigSailPortTaskView"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function BigSailPortView:ctor(data)
    BigSailPortView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.data = data
end

function BigSailPortView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailPortView.super.init(self, ... )
end

function BigSailPortView:dtor()
    BigSailPortView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.bigsailport.BigSailPortView")
end


function BigSailPortView:onInitView()
    if self.data.typeIndex == PublicDefine.FUNCTION_TYPE.FUNCTION_NAVIGATION_STORE then
        local data = {}
        data.qwe = 6534
        mvc.send("BigSailPort_Merchant_Layer")
    elseif self.data.typeIndex == PublicDefine.FUNCTION_TYPE.FUNCTION_NAVIGATION_TASK then
        local data = {}
        data.qwe = 6534
        mvc.send("BigSailPort_Task_Layer")
    elseif self.data.typeIndex == PublicDefine.FUNCTION_TYPE.FUNCTION_NAVIGATION_SUPPLY then
        local data = {}
        data.qwe = 6534
        mvc.send("BigSailPort_Supply_Layer")
    end

    --- 测试打开补给仓
    -- local data = {}
    -- data.qwe = 6534
    -- mvc.send("BigSailPort_Supply_Layer", data)

    -- local data = {}
    -- data.qwe = 6534
    -- mvc.send("BigSailPort_Merchant_Layer", data)

    -- local data = {}
    -- data.qwe = 6534
    -- mvc.send("BigSailPort_Task_Layer", data)
end


function BigSailPortView:bindModel()

end


function BigSailPortView:unbindModel()

end


function BigSailPortView:showSupplyLayer(data)
    if self.bigSailPortSupplyView then
        self:removeFromParent(self.bigSailPortSupplyView)
    end
    print("showSupplyLayer--->: ")
    local BigSailPortSupplyView = UI.BigSailPortSupplyView:create()
    BigSailPortSupplyView:init()
    BigSailPortSupplyView:center(0, 0)
    self:addChild(BigSailPortSupplyView, 1)
    self.bigSailPortSupplyView = BigSailPortSupplyView
end

function BigSailPortView:showMerchantLayer(data)
    if self.bigSailPortMerchantView then
        self:removeFromParent(self.bigSailPortMerchantView)
    end
    local BigSailPortMerchantView = UI.BigSailPortMerchantView:create()
    BigSailPortMerchantView:init()
    BigSailPortMerchantView:center(0, 0)
    self:addChild(BigSailPortMerchantView, 1)
    self.bigSailPortMerchantView = BigSailPortMerchantView
end

function BigSailPortView:showTaskLayer(data)
    if self.bigSailPortTaskView then
        self:removeFromParent(self.bigSailPortTaskView)
    end
    local BigSailPortTaskView = UI.BigSailPortTaskView:create()
    BigSailPortTaskView:init()
    BigSailPortTaskView:center(0, 0)
    BigSailPortTaskView:setName("bigSailPortTaskView")
    self:addChild(BigSailPortTaskView, 1)
    self.bigSailPortTaskView = BigSailPortTaskView
end

return BigSailPortView
