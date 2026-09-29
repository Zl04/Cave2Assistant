------------------------------------------------------------------------------
--author: 
--date	: 2019/10/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GuildLogInfoCellView = class("GuildLogInfoCellView", UI.HWBtnComponent)

GuildLogInfoCellView.TEXT_WIDTH = 286

-- 资源
local COM_RES_LIST = {
    "ui_common_scale9image.plist"
}

function GuildLogInfoCellView:ctor()
    GuildLogInfoCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        0,
        0
    )
    self:bindModel()
end

function GuildLogInfoCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.guildlog", "GuildLog", false)
    GuildLogInfoCellView.super.init(self, ... )
end

function GuildLogInfoCellView:dtor()
    GuildLogInfoCellView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.guildlog.GuildLogInfoCellView")
end


function GuildLogInfoCellView:onInitView()
------程序生成区块开始 node_513114997_1571113485-------
    local node_513114997_1571113485 = UI.Layout:create()
    node_513114997_1571113485:init()
    node_513114997_1571113485.__uiComposerID = "513114997_1571113485"
    addChildAuto(self._layoutUU, self, node_513114997_1571113485, "layout_513114997_1571113485")
    self._timeLayout = node_513114997_1571113485 -- 暴露名字至self
    self._timeLayout:enableAutoWidth()
    self._timeLayout:enableAutoHeight()
------程序生成区块结束 node_513114997_1571113485-------
------程序生成区块开始 node_1779143852_1571112245-------
    local node_1779143852_1571112245 = UI.Image9:create()
    node_1779143852_1571112245:init("ui_scale9image_banner_line_light3.png", CCRectMake(0,0,20,20), cc.size(138, 1))
    node_1779143852_1571112245.__uiComposerID = "1779143852_1571112245"
    node_1779143852_1571112245:floatLeft(0)
    self._timeLayout:addComponent(node_1779143852_1571112245)
------程序生成区块结束 node_1779143852_1571112245-------
------程序生成区块开始 node_2031813123_1571112968-------
    local node_2031813123_1571112968 = UI.Text:create()
    node_2031813123_1571112968:init("", UI.FONT_STANDARD, 14, {r = 193, g = 193, b = 193})
    node_2031813123_1571112968:autoAdapt()
    node_2031813123_1571112968.__uiComposerID = "2031813123_1571112968"
    node_2031813123_1571112968:floatLeft(5)
    self._timeLabel = node_2031813123_1571112968 -- 暴露名字至self
    self._timeLayout:addComponent(node_2031813123_1571112968)
------程序生成区块结束 node_2031813123_1571112968-------
------程序生成区块开始 node_1841807581_1571112915-------
    local node_1841807581_1571112915 = UI.Image9:create()
    node_1841807581_1571112915:init("ui_scale9image_banner_line_light3.png", CCRectMake(0,0,20,20), cc.size(138, 1))
    node_1841807581_1571112915.__uiComposerID = "1841807581_1571112915"
    node_1841807581_1571112915:floatLeft(5)
    self._timeLayout:addComponent(node_1841807581_1571112915)
------程序生成区块结束 node_1841807581_1571112915-------
------程序生成区块开始 node_673957642_1571113081-------
    local node_673957642_1571113081 = UI.Text:create()
    node_673957642_1571113081:init("", UI.SYS_FONT, 14, {r = 193, g = 193, b = 193})
    node_673957642_1571113081:setWidth(GuildLogInfoCellView.TEXT_WIDTH)
    node_673957642_1571113081:autoAdapt()
    node_673957642_1571113081.__uiComposerID = "673957642_1571113081"
    addChildAuto(self._layoutUU, self, node_673957642_1571113081, "layout_673957642_1571113081")
    self._contentLabel = node_673957642_1571113081 -- 暴露名字至self
------程序生成区块结束 node_673957642_1571113081-------
end

function GuildLogInfoCellView:updateData(data)
    if (data) then
        self._data = data

        -- 根据数据显示不同的内容
        if (data.type == mvc.guildLogModel.LogContentTypes.TIME) then
            -- 更新时间显示
            self._timeLayout:show()
            self._contentLabel:hide()

            -- 更新时间内容
            if (data.content) then
                self._timeLabel:setText(data.content)
                self._timeLayout:updateView()
            end
        else
            -- 更新内容显示
            self._timeLayout:hide()
            self._contentLabel:show()

            -- 更新内容
            if (data.content) then
                self._contentLabel:setText(data.content)
            end
        end
    end
end

function GuildLogInfoCellView:bindModel()

end


function GuildLogInfoCellView:unbindModel()

end




return GuildLogInfoCellView












