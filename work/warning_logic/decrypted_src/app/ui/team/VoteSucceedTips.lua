--[[
    AUTHOR:ZIHANCHEN
    2017-4-26
    USING: 队伍踢人的投票成功UI
]]

require "app.ui.common.Dialog.ConfirmDialog"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local VoteSucceedTips = class("VoteSucceedTips", UI.ConfirmDialog)
UI.VoteSucceedTips = VoteSucceedTips

--  构造函数
function VoteSucceedTips:ctor()
    VoteSucceedTips.super.ctor(self)
end

--  析构函数 调用父类的方法
function VoteSucceedTips:dtor()
    VoteSucceedTips.super.dtor(self)
end

--  初始化函数
function VoteSucceedTips:init(data)
    data = data or UI.TEXT_110026;
    VoteSucceedTips.super.init(self, data)
end

--  初始化界面函数
function VoteSucceedTips:onInitView()
    VoteSucceedTips.super.onInitView(self)
end

-- 传递回调函数名字
function VoteSucceedTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end


-- 更新视图
function VoteSucceedTips:onUpdateView()

end


function VoteSucceedTips:ok()
    VoteSucceedTips.super.ok(self)
    print("使用回城卷轴回城")
    GameManager:useTownScrollFailTips()
end

function VoteSucceedTips:cancel()
    VoteSucceedTips.super.ok(self)
    print("失败返回城镇")
    if( RoleBehaviorManager:backTownCheck("[VoteSucceedTips giveUp to back town]") ) then 
        GameManager:giveUpBackTown()
    end 
end