--[[--
 场景层配置文件
]]
require("app.ui.UIManager")

local layerSets = {}

layerSets[mvc.VIEW_TYPE.BASE]      = {zorder=1, cls= "UILayer"}
layerSets[mvc.VIEW_TYPE.SCENE]     = {zorder=2, cls= "UILayer"}
layerSets[mvc.VIEW_TYPE.MAIN_UI]   = {zorder=UI_ZORDER.MAIN_UI, cls= "UILayer"}
layerSets[mvc.VIEW_TYPE.PANEL]     = {zorder=UI_ZORDER.ACTIVITY_NEW, cls= "PanelLayer"} -- 会隐藏，显示主页面
layerSets[mvc.VIEW_TYPE.SUB_PANEL] = {zorder=UI_ZORDER.ACTIVITY_NEW+1, cls= "UILayer"}  -- 不会隐藏，显示主页面
layerSets[mvc.VIEW_TYPE.TOP_PANEL] = {zorder=UI_ZORDER.TOP_ACTIVITY, cls= "UILayer"}
layerSets[mvc.VIEW_TYPE.STATUS]    = {zorder=30, cls = "UILayer"}
layerSets[mvc.VIEW_TYPE.DIALOG]    = {zorder=UI_ZORDER.BLACK_DIALOGUE, cls= "DialogLayer"}
layerSets[mvc.VIEW_TYPE.LOADING]   = {zorder=UI_ZORDER.TRANSITION, cls = "UILayer"}
layerSets[mvc.VIEW_TYPE.GUIDE]     = {zorder=60, cls = "UILayer"}
layerSets[mvc.VIEW_TYPE.TIP]       = {zorder=UI_ZORDER.TIPS, cls = "UILayer"}
layerSets[mvc.VIEW_TYPE.MAX]       = {zorder=UI_ZORDER.MAX, cls = "UILayer"}

-- 未处理的层级
-- UI_ZORDER.FULL_SCREEN  1
-- UI_ZORDER.TOUCH_LAYER  2
-- UI_ZORDER.PERFORMANCE_INFO_AREA  2
-- UI_ZORDER.BLIND   0

return layerSets