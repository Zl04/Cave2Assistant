local RedPointLayer = class("RedPointLayer", UI.HWBtnComponent)
UI.RedPointLayer = RedPointLayer

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
}


UI_TOP_ACTIVITY_ZORDER = {
    TITLE_SELECTOR = 0, -- 称号选择框
    REVIVE = 1,         -- 复活界面
    REVIVE_TIPS = 2,    -- 复活界面的TIPS

    KICK = 200,         -- 踢出界面

    SHOP = 500,         -- 商店层
    SHOP_TIPS = 501,    -- 商店层的TIPS 
}

--构造函数(必备)
function RedPointLayer:ctor()
    --窗口大小
    RedPointLayer.super.ctor(
    self,UIType.RED_POINT,
    COM_RES_LIST,
    0,    
    0
    )
end

--虚构函数,destroy时调用(必备)
function RedPointLayer:dtor()
    RedPointManager:removeEventListener(tostring(self._redPointID), self, self.eventCallBack)
end

-- 初始化(必备)
function RedPointLayer:init(redType, redPointID)
    self._type = redType
    self._type = self._type or Game.RED_POINT_TYPE.NEW_ANIMATION
    self._redPointID = redPointID
    RedPointLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function RedPointLayer:onInitView()
    if(self._type == Game.RED_POINT_TYPE.NEW_ANIMATION) then 
        self:initNewAnimation()
    elseif(self._type == Game.RED_POINT_TYPE.RED_POINT) then 
        self:initRedPoint()
    end
end

-- 模版函数：更新组建的视图(必备)
function RedPointLayer:onUpdateView()

end

function RedPointLayer:eventCallBack(status)
    -- print(" RedPointLayer:eventCallBack", self._redPointID, status)
    if(self.action) then 
        self.action:setVisible(status)
    end
end

function RedPointLayer:initNewAnimation()
    -- print("RedPointLayer:initNewAnimation", self._redPointID)
    local spineName = "effect_ui_common_information_unlocknew"
    local action = UI.Animation:create()
    action:init(spineName..".json", spineName..".atlas")
    action:setAnimation("idle2",true)
    self:addChild(action)
    self.action = action

    RedPointManager:addEventListener(self._redPointID, self, self.eventCallBack)
end

function RedPointLayer:initRedPoint()
    -- local spineName = "effect_ui_common_information_unlocknew"
    -- local action = UI.Animation:create()
    -- action:init(spineName..".json", spineName..".atlas")
    -- action:setAnimation("idle2",true)
    -- self:addChild(action)
    -- action:setName("NEW_ACTION")

    -- self.action = action

    -- RedPointManager:addEventListener(self._redPointID, self, self.eventCallBack)
end