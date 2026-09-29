------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/28
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandView = class("BigSailIslandView", UI.HWBtnComponent)

require "app.modules.bigsailisland.BigSailIslandInfoView"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function BigSailIslandView:ctor()
    BigSailIslandView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function BigSailIslandView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandView.super.init(self, ... )
end

function BigSailIslandView:dtor()
    BigSailIslandView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandView")
end


function BigSailIslandView:onInitView()
    --- 测试打开补给仓
    local data = {}
    data.landId = 23
    --mvc.send("BigSailIsland_Info_Layer", data)

    mvc.openPanel("BigSailIsland", "BigSailIslandShowMap")
end

function BigSailIslandView:showIslandInfoLayer(data)
    if self.bigSailIslandInfoView then
        self:removeFromParent(self.bigSailIslandInfoView)
    end

    -- 请求对应岛屿的信息
    Net.NetBigSailSystem:reqIslandInfo(data.params[1])

    print("showSupplyLayer-->: ", data)
    -- data里面要有选中岛屿的id
    local bigSailIslandInfoView = UI.BigSailIslandInfoView:create(data.params)
    bigSailIslandInfoView:init()
    bigSailIslandInfoView:center(0, 0)
    self:addChild(bigSailIslandInfoView, 1)
    self.bigSailIslandInfoView = bigSailIslandInfoView
end


function BigSailIslandView:bindModel()
end

function BigSailIslandView:unbindModel()
end


return BigSailIslandView











