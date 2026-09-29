
--[[
    测试工具  2017/11/30
    -- 公共静态设置 --
	-- 影响所有GMUtil组件
    by CMonk
]]

require "config"

---------------------------------------
-- 引用UI命名空间
UI = UI or {}

-- 素子
local GMUtilConfig = UI.GMUtilConfig or {}
UI.GMUtilConfig = GMUtilConfig




   
 


-- 浮动方向
GMUtilConfig.DIRECTION = {
    LEFT = 1,
    RIGHT = 2,
    UP = 3,
    DOWN = 4,
    LEFT_UP = 5,
    LEFT_DOWN = 6,
    RIGHT_UP = 7,
    RIGHT_DOWN = 8
}




-- 一个标签, 用来从组件向父节点循环查找GMUtilLayer
GMUtilConfig.GMUtilLayerTag = "GMUtilLayerTag"





--------------------------
-- GM工具的设计大小，是相对总config文件里屏幕设计大小的大小
-- 设计宽度
GMUtilConfig.LAYOUT_DESIGN_WIDTH = 1024
-- 设计高度
GMUtilConfig.LAYOUT_DESIGN_HEIGHT = 640
-- TAB内容高度
GMUtilConfig.LAYOUT_TAB_CONTENT_HEIGHT = 568
-- TAB内容宽度
GMUtilConfig.LAYOUT_TAB_CONTENT_WIDTH = GMUtilConfig.LAYOUT_DESIGN_WIDTH
-- 根据背景图像修正需要的顶边偏移量
GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_TOP = 20
-- 根据背景图像修正需要的底边偏移量
GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_BOTTOM = 20
-- 根据背景图像修正需要的宽度偏移量
GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_WIDTH_OFFSET = 110
-- 根据背景图像修正过后的高度
GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_HEIGHT = 
	GMUtilConfig.LAYOUT_TAB_CONTENT_HEIGHT -
	GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_BOTTOM - 
	GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_TOP
-- 根据背景图像修正过后的宽度
GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_WIDTH = 
	GMUtilConfig.LAYOUT_TAB_CONTENT_WIDTH - 
	GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_WIDTH_OFFSET









-- 大*6行行高
GMUtilConfig.LAYOUT_H_XXXXXLARGE_90 = 90
-- 大大大大大行行高
GMUtilConfig.LAYOUT_H_XXXXLARGE_80 = 80
-- 大大大大行行高
GMUtilConfig.LAYOUT_H_XXXLARGE_70 = 70
-- 大大大行行高
GMUtilConfig.LAYOUT_H_XXLARGE_60 = 60
-- 大大行行高
GMUtilConfig.LAYOUT_H_XLARGE_50 = 50
-- 比大行行高高的行高
GMUtilConfig.LAYOUT_H_LARGE_PLUS_45 = 45
-- 大行行高
GMUtilConfig.LAYOUT_H_LARGE_40 = 40
-- 中行行高
GMUtilConfig.LAYOUT_H_MEDIUM_30 = 30
-- 比小行行高高的行高
GMUtilConfig.LAYOUT_H_SMALL_PLUS_25 = 25
-- 小行行高
GMUtilConfig.LAYOUT_H_SMALL_20 = 20
-- 比小小行高高的行高
GMUtilConfig.LAYOUT_H_XSMALL_PLUS_15 = 15
-- 小小行行高
GMUtilConfig.LAYOUT_H_XSMALL_10 = 10










-- 互动行左边偏移量
GMUtilConfig.LAYOUT_INTERACTIVE_LEFT_PAD = 20

-- 分隔符行高度（会留出的空白区域）
GMUtilConfig.LAYOUT_SEPERATOR_ROW_HEIGHT = GMUtilConfig.LAYOUT_H_XLARGE_50
-- 分隔符高度
GMUtilConfig.LAYOUT_SEPERATOR_HEIGHT = 5
-- 分隔符左偏移量
GMUtilConfig.LAYOUT_SEPERATOR_LEFT_OFFSET = 50
-- 分隔符右偏移量
GMUtilConfig.LAYOUT_SEPERATOR_RIGHT_OFFSET = 50
-- 分隔符宽度
GMUtilConfig.LAYOUT_SEPERATOR_WIDTH = 
	GMUtilConfig.LAYOUT_TAB_CONTENT_GRAPHIC_WIDTH -
	GMUtilConfig.LAYOUT_SEPERATOR_LEFT_OFFSET - 
	GMUtilConfig.LAYOUT_SEPERATOR_RIGHT_OFFSET


-- 标签字体设置
GMUtilConfig.LAYOUT_LABEL_FONT = UI.FONT_ARIAL
-- 标签字体颜色
GMUtilConfig.LAYOUT_LABEL_FONT_COLOR = UI.FONT_COLOR_42_31_1
-- 标签字体大侠和高度偏移量
GMUtilConfig.LAYOUT_LABEL_SIZE_OFFSET = -1


-- 区块标题宽度
GMUtilConfig.LAYOUT_TITLE_WIDTH = nil --Label根据内容自适应大小
-- 区块标题高度
GMUtilConfig.LAYOUT_TITLE_HEIGHT = GMUtilConfig.LAYOUT_H_MEDIUM_30
-- 区块副标题高度
GMUtilConfig.LAYOUT_SUBTITLE_HEIGHT = GMUtilConfig.LAYOUT_H_XSMALL_PLUS_15
-- 区块标题下偏移
GMUtilConfig.LAYOUT_TITLE_BOT_PAD = 10

-- 区块标题字体颜色设置
-- GMUtilConfig.LAYOUT_TITLE_FONT_COLOR = UI.FONT_COLOR_118_105_82
GMUtilConfig.LAYOUT_TITLE_FONT_COLOR = UI.FONT_COLOR_42_31_1


-- 按钮文字相对高度偏移量
GMUtilConfig.LAYOUT_BTN_FNT_SZ_OFFSET = -15
-- 按钮高度
GMUtilConfig.LAYOUT_BTN_HEIGHT = GMUtilConfig.LAYOUT_H_LARGE_PLUS_45


-- 输入框高度设置
GMUtilConfig.LAYOUT_INPUT_HEIGHT = GMUtilConfig.LAYOUT_H_LARGE_PLUS_45
-- 输入框内左偏移量
GMUtilConfig.LAYOUT_INPUT_PAD_LEFT = 10
-- 输入框内右偏移量
GMUtilConfig.LAYOUT_INPUT_PAD_RIGHT = 10


-- 下拉菜单高度
GMUtilConfig.LAYOUT_DROPDOWN_HEIGHT = GMUtilConfig.LAYOUT_H_LARGE_PLUS_45
-- 下拉按钮文字相对高度偏移量
GMUtilConfig.LAYOUT_DROPDOWN_FNT_SZ_OFFSET = -15


-- 开关高度
GMUtilConfig.LAYOUT_SWITCH_HEIGHT = GMUtilConfig.LAYOUT_H_LARGE_PLUS_45
-- 开关字体
GMUtilConfig.LAYOUT_SWITCH_FNT = UI.FONT_STANDARD
-- 开关字体颜色
GMUtilConfig.LAYOUT_SWITCH_FNT_COLOR = UI.FONT_COLOR_118_105_82
-- 开关字体文字相对高度偏移量
GMUtilConfig.LAYOUT_SWITCH_FNT_SZ_OFFSET = -15


-- 快捷栏顶边
GMUtilConfig.LAYOUT_QUICK_BAR_TOP = 50
-- 快捷栏左边
GMUtilConfig.LAYOUT_QUICK_BAR_LEFT = 980
-- 快捷按钮高度
GMUtilConfig.LAYOUT_QUICK_BTN_HEIGHT = GMUtilConfig.LAYOUT_H_SMALL_PLUS_25
-- 快捷按钮文字大小相对高度偏移量
GMUtilConfig.LAYOUT_QUICK_BTN_FNT_SZ_OFFSET = -5
-- 快捷按钮宽度
GMUtilConfig.LAYOUT_QUICK_BTN_WIDTH = nil
-- 快捷按钮间隔
GMUtilConfig.LAYOUT_QUICK_BTN_SPACE = 10





-- 面板资源
GMUtilConfig.SPRITE_FRAME_RES = "ui_gmutil.plist"
-- 界面背景
GMUtilConfig.SPRITE_BG = "ui_gmutil_banner_context.png"
-- 关闭按钮
GMUtilConfig.SPRITE_CLOSE_NORMAL = "ui_gmutil_button_return_0.png"
GMUtilConfig.SPRITE_CLOSE_ACTIVE = "ui_gmutil_button_return_3.png"
-- 角色
GMUtilConfig.SPRITE_TAB_CAVE_ACTIVE = "ui_gmutil_button_cave_1.png"
GMUtilConfig.SPRITE_TAB_CAVE_NORMAL = "ui_gmutil_button_cave_0.png"
GMUtilConfig.SPRITE_TAB_CAVE_PRESS = "ui_gmutil_button_cave_2.png"
-- 任务
GMUtilConfig.SPRITE_TAB_PROGRESS_ACTIVE = "ui_gmutil_button_progress_1.png"
GMUtilConfig.SPRITE_TAB_PROGRESS_NORMAL = "ui_gmutil_button_progress_0.png"
GMUtilConfig.SPRITE_TAB_PROGRESS_PRESS = "ui_gmutil_button_progress_2.png"
-- 技能
GMUtilConfig.SPRITE_TAB_EFFECT_ACTIVE = "ui_gmutil_button_effect_1.png"
GMUtilConfig.SPRITE_TAB_EFFECT_NORMAL = "ui_gmutil_button_effect_0.png"
GMUtilConfig.SPRITE_TAB_EFFECT_PRESS = "ui_gmutil_button_effect_2.png"
-- 日志
GMUtilConfig.SPRITE_TAB_ITEM_ACTIVE = "ui_gmutil_button_item_1.png"
GMUtilConfig.SPRITE_TAB_ITEM_NORMAL = "ui_gmutil_button_item_0.png"
GMUtilConfig.SPRITE_TAB_ITEM_PRESS = "ui_gmutil_button_item_2.png"
-- 设置
GMUtilConfig.SPRITE_TAB_OTHER_ACTIVE = "ui_gmutil_button_other_1.png"
GMUtilConfig.SPRITE_TAB_OTHER_NORMAL = "ui_gmutil_button_other_0.png"
GMUtilConfig.SPRITE_TAB_OTHER_PRESS = "ui_gmutil_button_other_2.png"


-- 控件资源
GMUtilConfig.SPRITE_CONTROLS_RES = "ui_gmutil_control.plist"
-- 按钮资源
GMUtilConfig.SPRITE_BTN_RES = "ui_gmutil_btn.plist"
-- 按钮常态
GMUtilConfig.SPRITE_BUTTON_NORMAL = "ui_gmutil_btn_button_yellow_00.png"
-- 按钮按下
GMUtilConfig.SPRITE_BUTTON_PRESSED = "ui_gmutil_btn_button_yellow_02.png"
-- 下拉按钮常态
GMUtilConfig.SPRITE_DROPDOWN_BUTTON_NORMAL = "ui_gmutil_btn_button_query_2.png"
-- 下拉按钮按下
GMUtilConfig.SPRITE_DROPDOWN_BUTTON_PRESSED = "ui_gmutil_btn_button_query_0.png"
-- 下拉按钮按下
GMUtilConfig.SPRITE_SEPERATOR = "ui_gmutil_control_progressbar_00.png"
-- 文字标签背景
GMUtilConfig.SPRITE_LABEL_BG = "ui_gmutil_control_banner_paper.png"
-- 文字背景
GMUtilConfig.SPRITE_TITLE_BG = "ui_gmutil_btn_button_note_0.png"
-- 输入框背景
GMUtilConfig.SPRITE_INPUT_BG = "ui_gmutil_btn_button1_1.png"
-- 开关背景
GMUtilConfig.SPRITE_SWITCH_BG = "ui_gmutil_control_progressbar_01.png"
-- 开关按钮
GMUtilConfig.SPRITE_SWITCH_BTN = "ui_gmutil_control_button_0.png"
-- 快速按钮
GMUtilConfig.SPRITE_QUICK_BUTTON = "ui_gmutil_btn_button_note_0.png"








-- 分隔符Z顺序
GMUtilConfig.LAYOUT_SEPERATOR_Z = -100
-- 默认自动排序区块Z顺序
GMUtilConfig.LAYOUT_SECTION_Z = 1


return GMUtilConfig