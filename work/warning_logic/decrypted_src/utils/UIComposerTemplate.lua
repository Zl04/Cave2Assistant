--Template:布局
-- local #{name}# = UI.Layout:create()
-- #{name}#:init()
-- #{name}#:setSize(#{input_宽度!}#, #{input_高度!}#)
--EndTemplate:布局

--Template:图片
-- local #{name}# = UI.Image:create()
-- #{name}#:init('#{input_图片名字}#')
--EndTemplate:图片

--Template:九宫格图片
-- local #{name}# = UI.Image9:create()
-- #{name}#:init("#{input_图片名字}#", CCRectMake(#{input_9格x}#,#{input_9格y}#,#{input_9格宽}#,#{input_9格高}#), cc.size(#{input_图片宽}#, #{input_图片高}#))
--EndTemplate:九宫格图片

--Template:三状态按钮
-- local #{name}# = UI.Button:create()
-- #{name}#:init("#{input_normal状态图片名字}#", "#{input_active状态图片名字}#", "#{input_disable状态图片名字}#")
-- #{name}#:setInterval(1)
-- #{name}#:addEventListener(UIEvent.BUTTON_CLICK, self, function()
--
-- end)
--EndTemplate:三状态按钮

--Template:三状态按钮带文字
-- local #{name}# = UI.Button:create()
-- #{name}#:init("#{input_normal状态图片名字}#", "#{input_active状态图片名字}#", "#{input_disable状态图片名字}#")
-- #{name}#:setText("#{input_默认文字?}#")
-- #{name}#:setTextFont(#{input_字体}#, #{input_字体大小}#, {r = #{input_R}#, g = #{input_G}#, b = #{input_B}#})
-- #{name}#:setInterval(1)
-- #{name}#:addEventListener(UIEvent.BUTTON_CLICK, self, function()
-- 
-- end)
--EndTemplate:三状态按钮带文字

--Template:动画按钮
-- local #{name}# = UI.Animation:create()
-- #{name}#:init("#{input_动画名字}#.json", "#{input_动画名字}#.atlas", 1);
-- #{name}#:setAnimation("#{input_默认动画名字}#", true)
-- #{name}#:setSize(#{input_宽度!}#, #{input_高度!}#)
-- #{name}#:setTouchEnable(true)
-- #{name}#:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
--     #{name}#:stopAllActions()
--     #{name}#:runAction(cc.ScaleTo:create(0.1, 1.2))
-- end)
-- #{name}#:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
--     #{name}#:stopAllActions()
--     #{name}#:runAction(cc.ScaleTo:create(0.1, 1))
-- end)
-- #{name}#:addEventListener(UIEvent.COMPONENT_CLICK, self, function()

-- end)
--EndTemplate:动画按钮

--Template:文字
-- local #{name}# = UI.Text:create()
-- #{name}#:init("#{input_默认文字?}#", #{input_字体}#, #{input_字体大小}#, {r = #{input_R}#, g = #{input_G}#, b = #{input_B}#})
-- #{name}#:setWidth(#{input_宽度!}#)
-- #{name}#:autoAdapt()
--EndTemplate:文字

--Template:动画
-- local #{name}# = UI.Animation:create()
-- #{name}#:init("#{input_动画名字}#.json", "#{input_动画名字}#.atlas", 1);
-- #{name}#:setAnimation("#{input_默认动画名字}#", true)
--EndTemplate:动画

--Template:角色动画
-- local #{name}# = UI.RoleAnimation:create(false)
-- local masterData = RoleDataManager:getMaster()
-- #{name}#:init(masterData)
-- #{name}#:setScale(#{input_缩放!}#)
-- #{name}#:showBlink(true)
-- #{name}#:showHelmet(true)
--EndTemplate:角色动画

--Template:头像(RoleData)
-- local #{name}# = UI.Component:create()
-- #{name}#:init()
-- #{addChildLine}#

-- -- 用一个包裹节点来确保快速刷新时不会错位, 每次刷新清除掉, 下面回调就能判断后不显示错位头像
-- local headWrapper = UI.Component:create()
-- headWrapper:init()
-- #{name}#:addChild(headWrapper)

-- -- 获取头像
-- local GameDataManager = require("app.game.GameDataManager")
-- local wearEquipmentDataArr = clone(GameDataManager:getRoleInfoDataForPK(RoleDataManager:getMasterPK()).wearEquipmentArr)
-- Avalon.WidgetUtil:getHead(self, RoleDataManager:getMaster(), wearEquipmentDataArr, self, handler(self, function(self, pic)
--     if self and not tolua.isnull(self) then
--         if (not tolua.isnull(headWrapper)) then
--             headWrapper:addChild(pic)
--         end
--     end
-- end), true)
--EndTemplate:头像(RoleData)

--Template:头像(Sex, FaceID)
-- local #{name}# = UI.Component:create()
-- #{name}#:init()
-- #{addChildLine}#

-- -- 用一个包裹节点来确保快速刷新时不会错位, 每次刷新清除掉, 下面回调就能判断后不显示错位头像
-- local headWrapper = UI.Component:create()
-- headWrapper:init()
-- #{name}#:addChild(headWrapper)

-- -- 获取头像
-- Avalon.WidgetUtil:getHeadByData(self, 2, 2020401, {}, self, handler(self, function(self, pic)
--     if (not tolua.isnull(headWrapper)) then
--         headWrapper:addChild(pic)
--     end
-- end))
--EndTemplate:头像(Sex, FaceID)

--Template:列表
-- local width = #{input_表宽度}#
-- local height = #{input_表高度}#
-- local cellWidth = #{input_一格宽度}#
-- local cellHeight = #{input_一格高度}#
-- local #{name}# = UI.TableView:create({}, width , height)
-- #{name}#:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
-- #{name}#:setDelegate()
-- #{name}#:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
-- #{name}#:setBounceable(true)
-- #{name}#:init()
-- #{name}#:onUpdateCellSize(function ()
--     return cellWidth, cellHeight
-- end)
-- #{name}#:onUpdateCells(function (tableview, idx)
--     local luaIdx = idx + 1
--     local cell = tableview:dequeueCell()
--     if cell == nil then
--         cell = UI.TableViewCell:create()

--         local CellView = require "#{modulePath}#.#{input_CELL视图类}#"
--         local cellView = CellView:create()
--         cellView.__panel = self.__panel
--         cellView:init()
--         cellView:setSize(cellWidth, cellHeight)
--         cellView:leftBottom(0, 0)
--         cellView:setName("cellView")
--         cell:addChild(cellView)
--     end
--     return cell
-- end)
-- #{name}#:onUpdateCellNumbers(function ()
--     return 1
-- end)
-- #{name}#:reloadData()
--EndTemplate:列表

--Template:标签排版
-- local #{name}# = UI.TabList:create()
-- #{name}#:init(#{input_标签间隔}#, nil, nil, true)
-- #{name}#.__tabWidth = #{input_标签宽度}#
-- #{name}#.__tabHeight = #{input_标签高度}#
-- #{name}#:setTouchEnable(true)
-- #{name}#:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex, lastIndex)
-- end)
-- #{name}#:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
-- #{name}#:setReverseOrder(true)
-- #{addChildLine}#

-- local #{name}#_sub1 = UI.TabItem:create()
-- #{name}#_sub1:init("#{input_默认标签normal图片}#", "#{input_默认标签active图片}#")
-- #{name}#_sub1:setSize(#{name}#.__tabWidth, #{name}#.__tabHeight)
-- #{name}#_sub1:alignLeft(true)
-- #{name}#_sub1:setSwallowTouches(true)
-- #{name}#_sub1:setChangeScale(false)
-- #{name}#:addToTab(#{name}#_sub1, 1)
-- #{name}#_sub1.__uiComposerID = "#{uiComposerID}#_sub1"
-- self._layoutUU:autoPos(#{name}#_sub1, "#{layoutID}#_sub1")
--EndTemplate:标签排版

--Template:[不自动添加排版]标签
-- local #{name}# = UI.TabItem:create()
-- #{name}#:init("#{input_normal图片}#", "#{input_active图片}#")
-- #{name}#:setSize(#{currentParent}#.__tabWidth, #{currentParent}#.__tabHeight)
-- #{name}#:alignLeft(true)
-- #{name}#:setSwallowTouches(true)
-- #{name}#:setChangeScale(false)
-- #{currentParent}#:addToTab(#{name}#, #{input_标签序号}#)
-- #{name}#.__uiComposerID = "#{uiComposerID}#"
-- self._layoutUU:autoPos(#{name}#, "#{layoutID}#")
--EndTemplate:[不自动添加排版]标签

--Template:滚动视图
-- local #{name}# = UI.ScrollView:create()
-- #{name}#:setSize(#{input_宽度}#, #{input_高度}#)
-- #{name}#:init(0, 0, 0, 0)
-- #{addChildLine}#
--EndTemplate:滚动视图
