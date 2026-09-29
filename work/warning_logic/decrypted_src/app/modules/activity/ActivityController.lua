--[[--
控制器ActivityController，proxy,view已经注入,可以通过cc.ActivityProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
]]
local GameController = require(mvc.PACKAGE_APP_CORE..".GameController")

local ActivityController = class("ActivityController",GameController)


--函数说明
--notification
function ActivityController:noticeActivityShowView(notification)
    if(not mvc.activityView:isActive()) then 
        mvc.activityView:show()
    end
end


--函数说明
--notification
function ActivityController:noticeActivityRefresh(notification)
    if(mvc.activityView:isActive()) then 
        mvc.activityView:activityChange()
    end
end


--函数说明
--notification
function ActivityController:noticeActivityRewardResult(notification)
    if(mvc.activityView:isActive()) then 
        mvc.activityView:rewardResult(notification.params[1])
    end
end



--函数说明
--notification
function ActivityController:noticeActivityClose(notification)
    if(mvc.activityView:isActive()) then 
        mvc.activityView:close()
    end
end



return ActivityController